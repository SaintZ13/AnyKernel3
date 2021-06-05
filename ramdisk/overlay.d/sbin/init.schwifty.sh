# RAMDISK CREATED BY Freak07 @ xda-developers
# RAMDISK MODIFIED BY SaintZ93 @ xda-developers

#!/system/bin/sh 

	chmod 666 /dev/input/event9

	stop vendor.sensors

	start vendor.sensors
	
	chmod 666 /dev/input/event9

sleep 15;

# Applying Schwifty Settings

# Core control parameters for gold
	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

# Core control parameters for gold+
	echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/task_thres
	# Controls how many more tasks should be eligible to run on gold CPUs
	# w.r.t number of gold CPUs available to trigger assist (max number of
	# tasks eligible to run on previous cluster minus number of CPUs in
	# the previous cluster).
	#
	# Setting to 1 by default which means there should be at least
	# 4 tasks eligible to run on gold cluster (tasks running on gold cores
	# plus misfit tasks on silver cores) to trigger assitance from gold+.
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

# Disable Core control on silver
	echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

# Setting b.L scheduler parameters
	echo 95 95 > /proc/sys/kernel/sched_upmigrate
	echo 85 85 > /proc/sys/kernel/sched_downmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 85 > /proc/sys/kernel/sched_group_downmigrate
	echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks
	echo 400000000 > /proc/sys/kernel/sched_coloc_downmigrate_ns
#	echo 35 > /proc/sys/kernel/sched_min_task_util_for_colocation
#	echo 1 > /proc/sys/kernel/sched_dynamic_ravg_window_enable

# Use WALT
#	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
#	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	echo 4 > /proc/sys/kernel/sched_prefer_spread
	echo 200 > /proc/sys/kernel/walt_low_latency_task_threshold
	echo 110 > /proc/sys/kernel/walt_rtg_cfs_boost_prio
	echo 3 > /proc/sys/kernel/sched_ravg_window_nr_ticks

# Tweak IO performance after boot complete
	
	# configure input boost settings
	echo "0:1305600" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
	echo 120 > /sys/devices/system/cpu/cpu_boost/input_boost_ms
	
# Setup Schedutil Governor
	echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 500 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
	echo 1209600 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq

	echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor	
	echo 500 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
	echo 1497600 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/rtg_boost_freq

	echo "schedutil" > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor	
	echo 500 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
	echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/iowait_boost_enable
	echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/rtg_boost_freq

# Setup EAS cpusets values for better load balancing
	echo 0-7 > /dev/cpuset/top-app/cpus
	echo 0-7 > /dev/cpuset/foreground/cpus
	echo 0-3 > /dev/cpuset/background/cpus
	echo 0-3  > /dev/cpuset/system-background/cpus
#	echo 1-2  > /dev/cpuset/audio-app/cpus
	echo 0-3 > /dev/cpuset/restricted/cpus

# Use WALT
#	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
#	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	echo 4 > /proc/sys/kernel/sched_prefer_spread
	echo 200 > /proc/sys/kernel/walt_low_latency_task_threshold
	echo 110 > /proc/sys/kernel/walt_rtg_cfs_boost_prio

# Tweak IO performance after boot complete
	echo "cfq" > /sys/block/sda/queue/scheduler
	echo 128 > /sys/block/sda/queue/read_ahead_kb
	echo 128 > /sys/block/dm-0/queue/read_ahead_kb
	
# Set TCP congestion algorithm
	echo "bbr" > /proc/sys/net/ipv4/tcp_congestion_control

# Setup EAS cpusets values for better load balancing
#	echo 0-7 > /dev/cpuset/top-app/cpus
#	echo 0-7 > /dev/cpuset/foreground/cpus
#	echo 0-3 > /dev/cpuset/background/cpus
#	echo 0-3  > /dev/cpuset/system-background/cpus
#	echo 1-2  > /dev/cpuset/audio-app/cpus
	echo 0-3 > /dev/cpuset/restricted/cpus

# Setup runtime blkio
# value for group_idle is us
	echo 1000 > /dev/blkio/blkio.weight
	echo 10 > /dev/blkio/background/blkio.weight
	echo 2000 > /dev/blkio/blkio.group_idle
	echo 0 > /dev/blkio/background/blkio.group_idle

# Set GPU Max Frequency to stock sd855 value
	echo 585000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq

echo "Schifty-Kernel Setup Finished" >> /dev/kmsg
