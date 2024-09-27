Return-Path: <linux-pm+bounces-14855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276159880F5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2470D1C22BCD
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316AA18A922;
	Fri, 27 Sep 2024 08:59:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8B718A6D0;
	Fri, 27 Sep 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427564; cv=none; b=BkIq/lWwqZ2rlmlLGmit0m0Yvd1SDE+iwEU9cQppX7vBl5L5iX+wdhtP+Tk2EmAuadPHpUGLqfUgCOVX299w6grnl7IpiUZIxuJOeC/vCBveaktpl2qEiGZUSBCBLZdL8FRRijwJi+AtWV9/QIP1GS0zty6nZK/cZA4c3QCBge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427564; c=relaxed/simple;
	bh=NGLIU0j9AdC9AAMMc2VPzHjSqyonkN6Gs5Ot0xEAcOk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JQ9JCneAcVN1/aAVqXg3FL+Adbxi0RA50Fx2mHQm0kxIY2M2c0gfMrBYhin8oar8o9bqMWJ0eCazx9lZ8uJE2g8eXBFKYryUofvyQmWlWGirTIh9k/bXu+BuA3SQJyiwso4Bo2mDB0xs0eoMRrZYkUEGtMYyD0iDjIuT20/PnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FBC514BF;
	Fri, 27 Sep 2024 01:59:51 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CEE03F64C;
	Fri, 27 Sep 2024 01:59:19 -0700 (PDT)
Message-ID: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
Date: Fri, 27 Sep 2024 09:59:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove the unconditional binding of sugov kthreads to the affected CPUs
if the cpufreq driver indicates that updates can happen from any CPU.
This allows userspace to set affinities to either save power (waking up
bigger CPUs on HMP can be expensive) or increasing performance (by
letting the utilized CPUs run without preemption of the sugov kthread).

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
- v2: Add comment for the dl_task_check_affinity return (Juri)
v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/

 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 kernel/sched/syscalls.c          | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c6ba15388ea7..10faab849a3e 100644
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
index aa70beee9895..2ef1cb8626bc 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1172,6 +1172,13 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
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

