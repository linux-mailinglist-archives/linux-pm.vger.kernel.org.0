Return-Path: <linux-pm+bounces-20684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8954A16A7A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 11:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260C316104F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC01AF0C2;
	Mon, 20 Jan 2025 10:10:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C91AF0B0;
	Mon, 20 Jan 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367800; cv=none; b=HIf1JX52cYa24Jt4jWorb0Z+40Kd75SC/nynD2pKEIm4KSPAV6YGMFb9AtAXt1ykWCArS+f73La4YoMv8OGYF4VLn9d2Koj/c01QQxm986V+MImzp0Rlrxx/crhGNuhJN1OL4PdR12yN0yAneYOB8ferl4ZK1iCu5wOLoe8ytHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367800; c=relaxed/simple;
	bh=UxOQKa4WkPcS1zv5zpAbRahS3K3XYRt4gKb0MtALyIE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DcymbCVbEC8hWhSX9E8KImbzfFubRLSEmYISYQIyPXft4EnY6BvQpoW0WM4btUnIBzgEf/bG3lg6XsvyJVtED+kAsYYSxOaVCmbuT6+q3Z+f6IvqH0fy7z5yRMyvCrq3Uoec9dXCiIFC/54rs/CEA5FfLNUEZGvAJL1ZAjJaFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047321063;
	Mon, 20 Jan 2025 02:10:26 -0800 (PST)
Received: from [10.57.34.174] (unknown [10.57.34.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC8F3F66E;
	Mon, 20 Jan 2025 02:09:54 -0800 (PST)
Message-ID: <5a8deed4-7764-4729-a9d4-9520c25fa7e8@arm.com>
Date: Mon, 20 Jan 2025 10:09:46 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-pm <linux-pm@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpufreq/schedutil: Only bind threads if needed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove the unconditional binding of sugov kthreads to the affected CPUs
if the cpufreq driver indicates that updates can happen from any CPU.
This allows userspace to set affinities to either save power (waking up
bigger CPUs on HMP can be expensive) or increasing performance (by
letting the utilized CPUs run without preemption of the sugov kthread).

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
---
- RESEND: pick up tags
- v2: Add comment for the dl_task_check_affinity return (Juri)
v2: https://lore.kernel.org/lkml/a4a70646-98a4-4b85-955e-62d66ba68927@arm.com/
v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/

 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 kernel/sched/syscalls.c          | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 28c77904ea74..a81444501158 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -691,7 +691,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 	}
 
 	sg_policy->thread = thread;
-	kthread_bind_mask(thread, policy->related_cpus);
+	if (policy->dvfs_possible_from_any_cpu)
+		set_cpus_allowed_ptr(thread, policy->related_cpus);
+	else
+		kthread_bind_mask(thread, policy->related_cpus);
+
 	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ff0e5ab4e37c..8230358d2b90 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1139,6 +1139,13 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
 		return 0;
 
+	/*
+	 * The special/sugov task isn't part of regular bandwidth/admission
+	 * control so let userspace change affinities.
+	 */
+	if (dl_entity_is_special(&p->dl))
+		return 0;
+
 	/*
 	 * Since bandwidth control happens on root_domain basis,
 	 * if admission test is enabled, we only admit -deadline
-- 
2.34.1

