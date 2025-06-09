Return-Path: <linux-pm+bounces-28311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F5AD215D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AD43ACDAF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BF19E97C;
	Mon,  9 Jun 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEBAMZ4L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5219D093;
	Mon,  9 Jun 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480571; cv=none; b=mjHxZ7vM0/cpo6VQOpI6gRJcfC3yYsFoS2/msAnHurGHY1tbg+hVQDLcoDiK6bg6MQyJ3puwoUjbziu8a7pvVTyp4a6pW1nZ4eCgIeYkxHS3xaFsDjx67BWzGvEGZ2BEWBK5YfUwxrR7N0XP+JbIQCraM0TAALQ9QTYQsldg0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480571; c=relaxed/simple;
	bh=N2hGCKcDh6Xpz7j/msHBJtSOvhiYQg5u/JmVQ9+iXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMxoExY64aTqoKp4x4VKrQg0LRUl/fg/9No+DKD4b9+xKEQOgvAdJZXSoTeQHwOTfJE87s95lyesYJHsNKPgXVvZzC17YUYKmCjztQQo3LLR1thYWIRQRjfgP8BS2uT0zsI/Wrpu9aRx7HCs6p0LsFqcs64N6gOPn1GZDBZyHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEBAMZ4L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234c5b57557so40023965ad.3;
        Mon, 09 Jun 2025 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749480569; x=1750085369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDQ70N0apsO9qdPmuXxM1Y0/xVvdzg0zBWkIx78RQC4=;
        b=KEBAMZ4Ld9jd7B13Hj9YQXaUe3fArul3ZsCJFGyUA5A4u2a+WPAXpfdsm6/wIB+GyR
         plZRixzUuX3CFYaZMP3ueA146Dy5G4w5cUWpcJQ7pCLr72rDVJQodNNEPzFaIg6Gk0e+
         ThBMtoZF/6qENJphq6bt3YG5GGVQWOdqxY9+xm93BsOiXyJLtP+iT8kztcHP+1EedGnb
         sL/8w2PpvN5jc0s/pJE71zDGg0wEUAAd6s9uSD3JojAwv3AL6H5YQcuoLtXZgcr09cqz
         g6r1A1eUP5nLXCJ+bVDtvnBuBBPu+fV+cO79T4co2qddd6SLBcIKmbenjdkeVgup/fcv
         bgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749480569; x=1750085369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDQ70N0apsO9qdPmuXxM1Y0/xVvdzg0zBWkIx78RQC4=;
        b=XhaxfiHVxuCmpuS3ViDzxrwBcqbd84Wr508W8Ef7XUS8d7KFMAMCgzZeMx49hrwE+o
         CejN7cSGOcZ/qt0w8cI4I6V59Uw4E1AHA3YBCTG/HI380FPUbYc7EpR83RZ6PaudoKmP
         /qkO037DilW1EOQl+tp424Wk2rLLtclV2Nj3rzWd5Qxo57s87CR0E89NF5f614z93MyX
         WnP5ZfyLQ/ZARR2mUW/moLCi4mZLq0/F8yqt+UyZOWCirgpAmKDN+FkEdknW9hTHGljJ
         9F2Qug0kUfXIns10XCXtzbNdYbhKmCSHLaDJCs3PU1UWiPom8Cm97cj55yaEcA0/3Zft
         jnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXdwbh86J46bhcCfNVytv+C1tgy4xxe2c1pTBEqy0JyZkBR7ZHwj20LA42Snk0UlZ1pa4bePpx8mnyzCxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KkoMEh+aoja1r6qWKhKVgiZzVrz7xdli/lUXF10yT3+m6fEJ
	T6BxiKmuVZG4Pm28eo4AuFJB6cLmUH0uWeOz1xQ0y+cJFqP+s0YuaEoI
X-Gm-Gg: ASbGnct3HM+1FkZCdGqlPfjTF4YGSbWppKeyEP8IYXS9WnBZOUGkw4BRqgmYdhTPVlz
	C3Fs7TodiRBZegX9KEc3GfNcdV69dVmFZP5ycCwW7MxuOmyaUMECKXUJnn+9T0nLSZ8ltstYxHB
	rmOYrT7u4TvTVQbNrZUqZwQTJEowe7KQJzlo6HZrsmoSVYRsLCCkN2xF7n9MnPDsG45CePAZ8cy
	BKxJTZfGbNTxhIJsXUyV9aN/DGqv+HdawKE0JVsc/STdogVyJc8hXStBxxOViLCMhxbcPhr0att
	oqMbC9Z1slXEoIh7iny2NuhXst6fRrXAiFXpGfBKtOnQnHiiGcD6UYIoTj+934mWY6WTuHcoKQ3
	i82pF0pb3y60TZceIqL7d
X-Google-Smtp-Source: AGHT+IGh7IxC0gxR92VaO3pJATFB7kZhChhV4DQACNpg/Bn2At+RqcEukNET3ao+hdzNQYXuwV3U2Q==
X-Received: by 2002:a17:902:d4cd:b0:229:1619:ab58 with SMTP id d9443c01a7336-23601dc4419mr200497475ad.43.1749480568711;
        Mon, 09 Jun 2025 07:49:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:30ac:7971:9724:5a2d:e1ce:3f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm55499015ad.53.2025.06.09.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:49:28 -0700 (PDT)
From: Rohan Lambture <rohanlambture13@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohan Lambture <rohanlambture13@gmail.com>
Subject: [PATCH] cpupower: Add cpu_start()/cpu_stop() callbacks for monitors
Date: Mon,  9 Jun 2025 20:19:12 +0530
Message-ID: <94c3faee898b5436cc0b837c6778011a060b8468.1749480264.git.rohanlambture13@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move per-CPU logic from inside individual monitors to the main
monitoring framework by adding cpu_start() and cpu_stop() callback
functions to the cpuidle_monitor structure.

This refactoring allows the framework to handle per-CPU scheduling
and gives higher priority to fork_it operations as mentioned in
the TODO. Individual monitors now only need to implement per-CPU
initialization and cleanup logic without managing the CPU iteration
themselves.

Changes made:
- Add cpu_start()/cpu_stop() function pointers to cpuidle_monitor struct
- Update monitoring framework to call per-CPU callbacks for each CPU
- Refactor cpuidle_sysfs and mperf monitors to use new callback pattern
- Maintain backward compatibility for monitors without per-CPU callbacks

This addresses the TODO item: "Add cpu_start()/cpu_stop() callbacks
for monitor -> This is to move the per_cpu logic from inside the
monitor to outside it."

Signed-off-by: Rohan Lambture <rohanlambture13@gmail.com>
---
 .../utils/idle_monitor/cpuidle_sysfs.c        | 44 ++++++-----
 .../utils/idle_monitor/cpupower-monitor.c     | 78 +++++++++++++++++--
 .../utils/idle_monitor/cpupower-monitor.h     |  2 +
 .../utils/idle_monitor/mperf_monitor.c        | 30 +++----
 4 files changed, 114 insertions(+), 40 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 8b42c2f0a5b0..01b1de04e03b 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -43,35 +43,39 @@ static int cpuidle_get_count_percent(unsigned int id, double *percent,
 
 static int cpuidle_start(void)
 {
-	int cpu, state;
 	clock_gettime(CLOCK_REALTIME, &start_time);
-	for (cpu = 0; cpu < cpu_count; cpu++) {
-		for (state = 0; state < cpuidle_sysfs_monitor.hw_states_num;
-		     state++) {
-			previous_count[cpu][state] =
-				cpuidle_state_time(cpu, state);
-			dprint("CPU %d - State: %d - Val: %llu\n",
-			       cpu, state, previous_count[cpu][state]);
-		}
-	}
 	return 0;
 }
 
 static int cpuidle_stop(void)
 {
-	int cpu, state;
 	struct timespec end_time;
+
 	clock_gettime(CLOCK_REALTIME, &end_time);
 	timediff = timespec_diff_us(start_time, end_time);
+	return 0;
+}
 
-	for (cpu = 0; cpu < cpu_count; cpu++) {
-		for (state = 0; state < cpuidle_sysfs_monitor.hw_states_num;
-		     state++) {
-			current_count[cpu][state] =
-				cpuidle_state_time(cpu, state);
-			dprint("CPU %d - State: %d - Val: %llu\n",
-			       cpu, state, previous_count[cpu][state]);
-		}
+static int cpuidle_cpu_start(unsigned int cpu)
+{
+	int state;
+
+	for (state = 0; state < cpuidle_sysfs_monitor.hw_states_num; state++) {
+		previous_count[cpu][state] = cpuidle_state_time(cpu, state);
+		dprint("CPU %d - State: %d - Val: %llu\n",
+		       cpu, state, previous_count[cpu][state]);
+	}
+	return 0;
+}
+
+static int cpuidle_cpu_stop(unsigned int cpu)
+{
+	int state;
+
+	for (state = 0; state < cpuidle_sysfs_monitor.hw_states_num; state++) {
+		current_count[cpu][state] = cpuidle_state_time(cpu, state);
+		dprint("CPU %d - State: %d - Val: %llu\n",
+		       cpu, state, current_count[cpu][state]);
 	}
 	return 0;
 }
@@ -205,6 +209,8 @@ struct cpuidle_monitor cpuidle_sysfs_monitor = {
 	.hw_states		= cpuidle_cstates,
 	.start			= cpuidle_start,
 	.stop			= cpuidle_stop,
+	.cpu_start		= cpuidle_cpu_start,
+	.cpu_stop		= cpuidle_cpu_stop,
 	.do_register		= cpuidle_register,
 	.unregister		= cpuidle_unregister,
 	.flags.needs_root	= 0,
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index ad493157f826..096e3cf35eb3 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -304,12 +304,29 @@ int fork_it(char **argv)
 	unsigned long long timediff;
 	pid_t child_pid;
 	struct timespec start, end;
+	int cpu;
 
 	child_pid = fork();
 	clock_gettime(CLOCK_REALTIME, &start);
 
-	for (num = 0; num < avail_monitors; num++)
-		monitors[num]->start();
+	/* Call global start callbacks first */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->start)
+			monitors[num]->start();
+	}
+
+	/* Call per-CPU start callbacks */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->cpu_start) {
+			for (cpu = 0; cpu < cpu_count; cpu++) {
+				if (monitors[num]->flags.per_cpu_schedule) {
+					if (bind_cpu(cpu))
+						continue;
+				}
+				monitors[num]->cpu_start(cpu);
+			}
+		}
+	}
 
 	if (!child_pid) {
 		/* child */
@@ -332,8 +349,25 @@ int fork_it(char **argv)
 		}
 	}
 	clock_gettime(CLOCK_REALTIME, &end);
-	for (num = 0; num < avail_monitors; num++)
-		monitors[num]->stop();
+
+	/* Call per-CPU stop callbacks */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->cpu_stop) {
+			for (cpu = 0; cpu < cpu_count; cpu++) {
+				if (monitors[num]->flags.per_cpu_schedule) {
+					if (bind_cpu(cpu))
+						continue;
+				}
+				monitors[num]->cpu_stop(cpu);
+			}
+		}
+	}
+
+	/* Call global stop callbacks */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->stop)
+			monitors[num]->stop();
+	}
 
 	timediff = timespec_diff_us(start, end);
 	if (WIFEXITED(status))
@@ -352,10 +386,25 @@ int do_interval_measure(int i)
 		for (cpu = 0; cpu < cpu_count; cpu++)
 			bind_cpu(cpu);
 
+	/* Call global start callbacks first */
 	for (num = 0; num < avail_monitors; num++) {
 		dprint("HW C-state residency monitor: %s - States: %d\n",
 		       monitors[num]->name, monitors[num]->hw_states_num);
-		monitors[num]->start();
+		if (monitors[num]->start)
+			monitors[num]->start();
+	}
+
+	/* Call per-CPU start callbacks */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->cpu_start) {
+			for (cpu = 0; cpu < cpu_count; cpu++) {
+				if (monitors[num]->flags.per_cpu_schedule) {
+					if (bind_cpu(cpu))
+						continue;
+				}
+				monitors[num]->cpu_start(cpu);
+			}
+		}
 	}
 
 	sleep(i);
@@ -364,9 +413,24 @@ int do_interval_measure(int i)
 		for (cpu = 0; cpu < cpu_count; cpu++)
 			bind_cpu(cpu);
 
-	for (num = 0; num < avail_monitors; num++)
-		monitors[num]->stop();
+	/* Call per-CPU stop callbacks */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->cpu_stop) {
+			for (cpu = 0; cpu < cpu_count; cpu++) {
+				if (monitors[num]->flags.per_cpu_schedule) {
+					if (bind_cpu(cpu))
+						continue;
+				}
+				monitors[num]->cpu_stop(cpu);
+			}
+		}
+	}
 
+	/* Call global stop callbacks */
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->stop)
+			monitors[num]->stop();
+	}
 
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index c559d3115330..830ad5ee68d6 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -57,6 +57,8 @@ struct cpuidle_monitor {
 	cstate_t *hw_states;
 	int (*start) (void);
 	int (*stop) (void);
+	int (*cpu_start) (unsigned int cpu);
+	int (*cpu_stop) (unsigned int cpu);
 	struct cpuidle_monitor* (*do_register) (void);
 	void (*unregister)(void);
 	unsigned int overflow_s;
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 73b6b10cbdd2..6340f5d771b6 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -224,27 +224,27 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 
 static int mperf_start(void)
 {
-	int cpu;
-
-	for (cpu = 0; cpu < cpu_count; cpu++) {
-		clock_gettime(CLOCK_REALTIME, &time_start[cpu]);
-		mperf_get_tsc(&tsc_at_measure_start[cpu]);
-		mperf_init_stats(cpu);
-	}
-
 	return 0;
 }
 
 static int mperf_stop(void)
 {
-	int cpu;
+	return 0;
+}
 
-	for (cpu = 0; cpu < cpu_count; cpu++) {
-		mperf_measure_stats(cpu);
-		mperf_get_tsc(&tsc_at_measure_end[cpu]);
-		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
-	}
+static int mperf_cpu_start(unsigned int cpu)
+{
+	clock_gettime(CLOCK_REALTIME, &time_start[cpu]);
+	mperf_get_tsc(&tsc_at_measure_start[cpu]);
+	mperf_init_stats(cpu);
+	return 0;
+}
 
+static int mperf_cpu_stop(unsigned int cpu)
+{
+	mperf_measure_stats(cpu);
+	mperf_get_tsc(&tsc_at_measure_end[cpu]);
+	clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
 	return 0;
 }
 
@@ -373,6 +373,8 @@ struct cpuidle_monitor mperf_monitor = {
 	.hw_states		= mperf_cstates,
 	.start			= mperf_start,
 	.stop			= mperf_stop,
+	.cpu_start		= mperf_cpu_start,
+	.cpu_stop		= mperf_cpu_stop,
 	.do_register		= mperf_register,
 	.unregister		= mperf_unregister,
 	.flags.needs_root	= 1,
-- 
2.49.0


