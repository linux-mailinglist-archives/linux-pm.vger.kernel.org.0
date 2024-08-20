Return-Path: <linux-pm+bounces-12574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423C958C55
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B55028511B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174E1BDAA7;
	Tue, 20 Aug 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SEdLHilB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2F1B9B3D
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171810; cv=none; b=G+oZS2XHpB6swagEVKNkIEO5hrk0SZufWBobQoUEGVhWNZmdZLj37UImlTk2sbLeJALTk8/XMk3/D+3FfOv9SL/2mjtq8cIyQv56FLgmnm/2hHu5fBL6J9nB8Fb7FLkYt2xwirloTsphHh4dz3GCbnqGyp6btZgnwsMPESQcGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171810; c=relaxed/simple;
	bh=H2v4wPkY9/S00PuSqnRFW7BMeliOkRRZuCIYsWw2Xl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlWibJTkKYxwoBgHHROzTMBEwGH2V1IcUA/Zl8QTfq1EbyHF3cKP+6cxxiYoOEeR2nMA5mmxq/GQ30t14ZXYWJuofaOLMxXWdfhYObMqowlU4pAN9lbljjsw9nuGIuh+haHWAR37hELcwGqhq1XZ0mSdDjZ0RFSsSbGTxl5f5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=SEdLHilB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso4903756a12.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171807; x=1724776607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT5j0PZ9X9xu3k6v8CfXi6RGxKCSRQvQX4tJvcwiDgI=;
        b=SEdLHilBdGd+HV3kLIAFgh5Tco/aov6L03RWLcXoDAxxwECbqowStf7e7Nn4W00uNA
         8ou3G4Dx/Qe935abWpyN261HVj/GzOCQ3TdT5w/Ei88D7RX7h/hPDGY513givXkFJOiL
         FlhSh8Oqovtucp01VF8KkxGGsubtzyP4MExPV5wMARKfzjNOIg/rNu6Uq2XcVvXM/1Gn
         NotMSmAekdwHEjUvlRlecHIuTf82M0IC/dNIXbEHRGht3TJroZomTcVEcZ7gFL/bP5aF
         B309BAeGdVe2jdane30E7qGJcyQLmu1IZuO0fGUiO0esf7UfyDmBCjvU04zCUWbsviB1
         NlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171807; x=1724776607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT5j0PZ9X9xu3k6v8CfXi6RGxKCSRQvQX4tJvcwiDgI=;
        b=u1UChiOcI/tq3fMBSoxD+7ZUja3y6Bwyfp44d2X55gwIJ7SyZvIt28hMR69L/PaDSt
         6Lx1oCwPjoyFij9e8AS4gFwItbZJR6iil1frs5Bs5vmgICjl849aB51dKC9r58CvQ6Tb
         SoI6HsoTc7dBRyyJjDFUbECkh2gMscS26sNtLTOEcUl82L4p4HnuHMY1ToK1m6Th+/2s
         RIrWsa9bbpDG2HW9BczldAmdAp5M91+N/KYRnCvitXdEwlNoRWIjTflu7ah4CZLvpkW4
         oR7YVp/a73n/j8cSjjqSmz2YBd2+CS2w8AczdKWpDMxJXof18nDWpnx4G5RewkO1os7A
         8g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdzBmgYfllyKVNNFM0Lv8+dwGjNtitdxD4/AYxAj/AAZn/mHt0DWh0C6hHYNxTr6oZcxYEWiot2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOd03eL5zPcoPdFxz12ufmNjYKX9Vexb6d1CfiZTIjzHwQCm7
	njxEQj37hi127VuW8OMEOHRPuBgFePriua3WqPToRV2d1L5eH34gg1fiSBdFMfk=
X-Google-Smtp-Source: AGHT+IFCqy8udzUPQSToeARc04ldQIgYbEcEvnYLXxCQCr6hah66sD1+LHqReW2Q/Kq1330Y8OrsKQ==
X-Received: by 2002:a17:907:efc8:b0:a7a:c197:8701 with SMTP id a640c23a62f3a-a83929534e5mr1074429266b.31.1724171807015;
        Tue, 20 Aug 2024 09:36:47 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:46 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 10/16] sched/qos: Add a new sched-qos interface
Date: Tue, 20 Aug 2024 17:35:06 +0100
Message-Id: <20240820163512.1096301-11-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The need to describe the conflicting demand of various workloads hasn't
been higher. Both hardware and software have moved rapidly in the past
decade and system usage is more diverse and the number of workloads
expected to run on the same machine whether on Mobile or Server markets
has created a big dilemma on how to better manage those requirements.

The problem is that we lack mechanisms to allow these workloads to
describe what they need, and then allow kernel to do best efforts to
manage those demands based on the hardware it is running on
transparently and current system state.

Example of conflicting requirements that come across frequently:

	1. Improve wake up latency for SCHED_OTHER. Many tasks end up
	   using SCHED_FIFO/SCHED_RR to compensate for this shortcoming.
	   RT tasks lack power management and fairness and can be hard
	   and error prone to use correctly and portably.

	2. Prefer spreading vs prefer packing on wake up for a group of
	   tasks. Geekbench-like workloads would benefit from
	   parallelising on different CPUs. hackbench type of workloads
	   can benefit from waking on up same CPUs or a CPU that is
	   closer in the cache hierarchy.

	3. Nice values for SCHED_OTHER are system wide and require
	   privileges. Many workloads would like a way to set relative
	   nice value so they can preempt each others, but not be
	   impact or be impacted by other tasks belong to different
	   workloads on the system.

	4. Provide a way to tag some tasks as 'background' to keep them
	   out of the way. SCHED_IDLE is too strong for some of these
	   tasks but yet they can be computationally heavy. Example
	   tasks are garbage collectors. Their work is both important
	   and not important.

	5. Provide a way to improve DVFS/upmigration rampup time for
	   specific tasks that are bursty in nature and highly
	   interactive.

Whether any of these use cases warrants an additional QoS hint is
something to be discussed individually. But the main point is to
introduce an interface that can be extendable to cater for potentially
those requirements and more. rampup_multiplier to improve
DVFS/upmigration for bursty tasks will be the first user in later patch.

It is desired to have apps (and benchmarks!) directly use this interface
for optimal perf/watt. But in the absence of such support, it should be
possible to write a userspace daemon to monitor workloads and apply
these QoS hints on apps behalf based on analysis done by anyone
interested in improving the performance of those workloads.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 Documentation/scheduler/index.rst             |  1 +
 Documentation/scheduler/sched-qos.rst         | 44 ++++++++++++++++++
 include/uapi/linux/sched.h                    |  4 ++
 include/uapi/linux/sched/types.h              | 46 +++++++++++++++++++
 kernel/sched/syscalls.c                       |  3 ++
 .../trace/beauty/include/uapi/linux/sched.h   |  4 ++
 6 files changed, 102 insertions(+)
 create mode 100644 Documentation/scheduler/sched-qos.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 43bd8a145b7a..f49b8b021d97 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -21,6 +21,7 @@ Scheduler
     sched-rt-group
     sched-stats
     sched-debug
+    sched-qos
 
     text_files
 
diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
new file mode 100644
index 000000000000..0911261cb124
--- /dev/null
+++ b/Documentation/scheduler/sched-qos.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Scheduler QoS
+=============
+
+1. Introduction
+===============
+
+Different workloads have different scheduling requirements to operate
+optimally. The same applies to tasks within the same workload.
+
+To enable smarter usage of system resources and to cater for the conflicting
+demands of various tasks, Scheduler QoS provides a mechanism to provide more
+information about those demands so that scheduler can do best-effort to
+honour them.
+
+  @sched_qos_type	what QoS hint to apply
+  @sched_qos_value	value of the QoS hint
+  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
+			applies. If 0, the hint will apply globally system
+			wide. If not 0, the hint will be relative to tasks that
+			has the same cookie value only.
+
+QoS hints are set once and not inherited by children by design. The
+rationale is that each task has its individual characteristics and it is
+encouraged to describe each of these separately. Also since system resources
+are finite, there's a limit to what can be done to honour these requests
+before reaching a tipping point where there are too many requests for
+a particular QoS that is impossible to service for all of them at once and
+some will start to lose out. For example if 10 tasks require better wake
+up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
+4 can perceive the hint honoured and the rest will have to wait. Inheritance
+can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
+hint will lose its meaning and effectiveness rapidly. The chances of 10
+tasks waking up at the same time is lower than a 100 and lower than a 1000.
+
+To set multiple QoS hints, a syscall is required for each. This is a
+trade-off to reduce the churn on extending the interface as the hope for
+this to evolve as workloads and hardware get more sophisticated and the
+need for extension will arise; and when this happen the task should be
+simpler to add the kernel extension and allow userspace to use readily by
+setting the newly added flag without having to update the whole of
+sched_attr.
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..67ef99f64ddc 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -102,6 +102,9 @@ struct clone_args {
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
 };
+
+enum sched_qos_type {
+};
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
@@ -132,6 +135,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_QOS			0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 90662385689b..55e4b1e79ed2 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -94,6 +94,48 @@
  * scheduled on a CPU with no more capacity than the specified value.
  *
  * A task utilization boundary can be reset by setting the attribute to -1.
+ *
+ * Scheduler QoS
+ * =============
+ *
+ * Different workloads have different scheduling requirements to operate
+ * optimally. The same applies to tasks within the same workload.
+ *
+ * To enable smarter usage of system resources and to cater for the conflicting
+ * demands of various tasks, Scheduler QoS provides a mechanism to provide more
+ * information about those demands so that scheduler can do best-effort to
+ * honour them.
+ *
+ *  @sched_qos_type	what QoS hint to apply
+ *  @sched_qos_value	value of the QoS hint
+ *  @sched_qos_cookie	magic cookie to tag a group of tasks for which the QoS
+ *			applies. If 0, the hint will apply globally system
+ *			wide. If not 0, the hint will be relative to tasks that
+ *			has the same cookie value only.
+ *
+ * QoS hints are set once and not inherited by children by design. The
+ * rationale is that each task has its individual characteristics and it is
+ * encouraged to describe each of these separately. Also since system resources
+ * are finite, there's a limit to what can be done to honour these requests
+ * before reaching a tipping point where there are too many requests for
+ * a particular QoS that is impossible to service for all of them at once and
+ * some will start to lose out. For example if 10 tasks require better wake
+ * up latencies on a 4 CPUs SMP system, then if they all wake up at once, only
+ * 4 can perceive the hint honoured and the rest will have to wait. Inheritance
+ * can lead these 10 to become a 100 or a 1000 more easily, and then the QoS
+ * hint will lose its meaning and effectiveness rapidly. The chances of 10
+ * tasks waking up at the same time is lower than a 100 and lower than a 1000.
+ *
+ * To set multiple QoS hints, a syscall is required for each. This is a
+ * trade-off to reduce the churn on extending the interface as the hope for
+ * this to evolve as workloads and hardware get more sophisticated and the
+ * need for extension will arise; and when this happen the task should be
+ * simpler to add the kernel extension and allow userspace to use readily by
+ * setting the newly added flag without having to update the whole of
+ * sched_attr.
+ *
+ * Details about the available QoS hints can be found in:
+ * Documentation/scheduler/sched-qos.rst
  */
 struct sched_attr {
 	__u32 size;
@@ -116,6 +158,10 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	__u32 sched_qos_type;
+	__s64 sched_qos_value;
+	__u32 sched_qos_cookie;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..a7d4dfdfed43 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -668,6 +668,9 @@ int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_QOS)
+		return -EOPNOTSUPP;
+
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
 	 * information.
diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
index 3bac0a8ceab2..67ef99f64ddc 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
@@ -102,6 +102,9 @@ struct clone_args {
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
 };
+
+enum sched_qos_type {
+};
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
@@ -132,6 +135,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_QOS			0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
-- 
2.34.1


