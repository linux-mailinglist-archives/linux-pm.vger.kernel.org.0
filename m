Return-Path: <linux-pm+bounces-34954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FCB8407A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 12:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15721520599
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B332F60A6;
	Thu, 18 Sep 2025 10:15:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982CE2EFDB7;
	Thu, 18 Sep 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190557; cv=none; b=ExoqEXaxhnGVCvF+yJ4Mb7ybgxrgIADaK0+4+W/6KCvmFK01mfLPRc3a4tBp73a9I7TbqDH7/7oHAGoEuRvxrWMIS2dPC8x6R7wwAolJfcXTjMaqwAKNigaILwXZmy9gUXq38YK4ulvWl2CRCo42yILpgBdyOSGx39gdWDrNwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190557; c=relaxed/simple;
	bh=ESgooQkzpnuj6/HlASLv8n2pp82wSV61KRfw5RjKnVw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qFmHvxaZcj7jB/X5y06poqvdroqos+hU/ZKL3BhVH2p3H+sZV5e37Sb+J/tw3/M/HxfFUO5igPmvAMhgjoflQzSgdtZOhme/iYCWjzNf6dTasngXPhUmO6SImM3mxl7uKQrECl5LTP4CL1YGsk+TKSmO693BbLLw+Mvr6uCRH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8BB916A3;
	Thu, 18 Sep 2025 03:15:46 -0700 (PDT)
Received: from [10.57.80.59] (unknown [10.57.80.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C883F673;
	Thu, 18 Sep 2025 03:15:54 -0700 (PDT)
Message-ID: <85e3df99-7ba5-4654-9148-5fff25ea0e5a@arm.com>
Date: Thu, 18 Sep 2025 11:15:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpufreq: Initialize cpufreq-based invariance before subsys
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit 2a6c72738706 ("cpufreq: Initialize cpufreq-based
frequency-invariance later") postponed the frequency invariance
initialization to avoid disabling it in the error case.
This isn't locking safe, instead move the initialization up before
the subsys interface is registered (which will rebuild the
sched_domains) and add the corresponding disable on the error path.

Observed lockdep without this patch:
[    0.989686] ======================================================
[    0.989688] WARNING: possible circular locking dependency detected
[    0.989690] 6.17.0-rc4-cix-build+ #31 Tainted: G S
[    0.989691] ------------------------------------------------------
[    0.989692] swapper/0/1 is trying to acquire lock:
[    0.989693] ffff800082ada7f8 (sched_energy_mutex){+.+.}-{4:4}, at: rebuild_sched_domains_energy+0x30/0x58
[    0.989705]
               but task is already holding lock:
[    0.989706] ffff000088c89bc8 (&policy->rwsem){+.+.}-{4:4}, at: cpufreq_online+0x7f8/0xbe0
[    0.989713]
               which lock already depends on the new lock.

Fixes: 2a6c72738706 ("cpufreq: Initialize cpufreq-based frequency-invariance later")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cpufreq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..58e3839a2140 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2953,6 +2953,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 			goto err_null_driver;
 	}
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("cpufreq: supports frequency invariance\n");
+	}
+
 	ret = subsys_interface_register(&cpufreq_interface);
 	if (ret)
 		goto err_boost_unreg;
@@ -2974,21 +2983,14 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	hp_online = ret;
 	ret = 0;
 
-	/*
-	 * Mark support for the scheduler's frequency invariance engine for
-	 * drivers that implement target(), target_index() or fast_switch().
-	 */
-	if (!cpufreq_driver->setpolicy) {
-		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
-		pr_debug("supports frequency invariance");
-	}
-
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
 
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
 err_boost_unreg:
+	if (!cpufreq_driver->setpolicy)
+		static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
 	remove_boost_sysfs_file();
 err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-- 
2.34.1

