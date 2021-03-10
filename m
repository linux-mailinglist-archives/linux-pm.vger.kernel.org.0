Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4483334DD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 06:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhCJFYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 00:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhCJFXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 00:23:44 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9AC061760
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 21:23:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d23so4689094plq.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 21:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXPftVm0Zz9RXWAlvb9njkCnptfxOnMIFmu/ocdebw0=;
        b=h5+1uQxetPSjw8PACHK4t2Hd7vuH90JC6wRZq6oSAr8QycfGdMjzlfDxYz7UPNs3fE
         aDipwaizdLvcrXJmgIwgVsPbDXRHBrjM2Ffxw7BTeYHyahm/g90kElvQ3d9rj4KC7NhV
         BuNDfIjuhXTcKFLFyB3fQV7Sfaaq6AEOIWiZ/ExmDnVp6FdYreeMALKRdw0GJ379k504
         Ln6D2d+eN45oJSVdvHjS70ZNp1uAmrJ5IijFqhJ/jluNKdWGPelt/+E+MyN7U9lz6X5R
         AGVcCgiYFeBhgNSUgcXaphlisYiaf6y2AyeoRYehUEEnZtySl24rGgSo21c3iSNRu5cR
         2Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXPftVm0Zz9RXWAlvb9njkCnptfxOnMIFmu/ocdebw0=;
        b=VbP6Q9Jt7JYxFtFk5ZxwDvceyhd0S8U3odl48x3LFd4X79vFpWUg5J46sQLCdfprc6
         kjJsblQDgwZNXgf/yjr7iriXiDFEmvi6PoYUKaDIvMSaxwQmuszoowUjUGTQeKwUU3aa
         ceV4P+mCmQEmgXgWAClfpxFXWgzujP8OUBrk9Y3ly09wSMFBmo3ZzXjHGQW0LpCZV8DA
         rM3bija7Or7ixS1v4ph0BuhhkOFV46U5Ttb3LzfhZ+eYucOWiMRrJc5vYS72COw8KSqG
         Sd5YB4o+cBc6iLseypEM2xaxLTDJE4NjUup+GnZUw0wpybMDI3mTRiS+k3RLJ8Y8rueo
         EA5Q==
X-Gm-Message-State: AOAM533HqdDaHQadIjhd9pUSby/zemLozwHvXTZQIt4fkHu16KUUKClp
        W0Z3Ts1bbgY69CGFwWMrCufRJw==
X-Google-Smtp-Source: ABdhPJyYc3eM5HErG3TJ/XnSdlxUI2pE0MOSw0tUndBQqhlzSXWkXpMxCGbJcweVKRMmrJAypgJ2Iw==
X-Received: by 2002:a17:90b:2307:: with SMTP id mt7mr1736715pjb.37.1615353823991;
        Tue, 09 Mar 2021 21:23:43 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id u15sm14361469pfk.128.2021.03.09.21.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 21:23:43 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/4] arch_topology: Rename freq_scale as arch_freq_scale
Date:   Wed, 10 Mar 2021 10:53:23 +0530
Message-Id: <2dd2c60c0268550f566c3c83d06b651b4f0e9e4e.1615351622.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615351622.git.viresh.kumar@linaro.org>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename freq_scale to a less generic name, as it will get exported soon
for modules. Since x86 already names its own implementation of this as
arch_freq_scale, lets stick to that.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c  | 6 +++---
 drivers/base/arch_topology.c  | 4 ++--
 include/linux/arch_topology.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index e08a4126453a..aa8d893619ed 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -256,8 +256,8 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
 	 * initialized AMU support and enabled invariance. The AMU counters will
 	 * keep on working just fine in the absence of the cpufreq driver, and
 	 * for the CPUs for which there are no counters available, the last set
-	 * value of freq_scale will remain valid as that is the frequency those
-	 * CPUs are running at.
+	 * value of arch_freq_scale will remain valid as that is the frequency
+	 * those CPUs are running at.
 	 */
 
 	return 0;
@@ -327,7 +327,7 @@ void topology_scale_freq_tick(void)
 			  const_cnt - prev_const_cnt);
 
 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
-	this_cpu_write(freq_scale, (unsigned long)scale);
+	this_cpu_write(arch_freq_scale, (unsigned long)scale);
 }
 
 #ifdef CONFIG_ACPI_CPPC_LIB
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index de8587cc119e..2a1cecbde0a4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -31,7 +31,7 @@ __weak bool arch_freq_counters_available(const struct cpumask *cpus)
 {
 	return false;
 }
-DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
@@ -53,7 +53,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
 
 	for_each_cpu(i, cpus)
-		per_cpu(freq_scale, i) = scale;
+		per_cpu(arch_freq_scale, i) = scale;
 }
 
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b73a61..583af517f123 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -23,11 +23,11 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
-DECLARE_PER_CPU(unsigned long, freq_scale);
+DECLARE_PER_CPU(unsigned long, arch_freq_scale);
 
 static inline unsigned long topology_get_freq_scale(int cpu)
 {
-	return per_cpu(freq_scale, cpu);
+	return per_cpu(arch_freq_scale, cpu);
 }
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
-- 
2.25.0.rc1.19.g042ed3e048af

