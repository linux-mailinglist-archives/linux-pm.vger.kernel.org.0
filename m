Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9F310790
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 10:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBEJRZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 04:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhBEJPI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 04:15:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D84C06178C
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 01:14:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lw17so6393710pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2021 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hF9qEuN0t60aQwKqM2EZNImZ2qgd4dzTdPhlz4GhOnQ=;
        b=baG+mICmSRFGZPpmbX/z/Q4npvhOxgihshME85DpDK2T0FDiP7iS/B3GDOrt6gJxVZ
         FZtI11V//62Tp1qEsLtjEMoYU3iXL2YKkyckgA4PUsQIMK+XKon9U4sIWjCmgEvzoTb0
         TzEgzdfvMHxlSrzrD7Gc/Bvh1lCla/shieQ/Tn3wQlCWHrd1oIB5ajwVjGMRjE2pxw0E
         I3C/2bRtZcqghfKMZCQjcBulO8O7VO2I02wJWYUH8HN15LGZvYLrl5OyeGHMP5lkxU3X
         DZijxN0r3GKjXbNrsx2DM4daqIiIXsQp+JhPVhvE7LFBtyB2y6sHrcf965+pSgDCdN2f
         j4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hF9qEuN0t60aQwKqM2EZNImZ2qgd4dzTdPhlz4GhOnQ=;
        b=OEsUEdY5k4GY3QUlOYHPkeqpS5fr1H5tal9ngFaeEePzso7/9D0UXhJw5NB8YHlatS
         dHaLDBJHr4Pe5jdKbOSSPa+G7SnSyV7Edqnp5D/gHNPSLzsU2IsyP9ode0y93cqb0lmY
         xSB5P0mSeRTUPL/hAmdk/eaoQQ8LBx4FS5lroe/M0MJmlhTdvfZLdmy9zMs8rJhQRFft
         zwAAMH9i/5M4qd1gVk74zAS2D5gCtsbgvuzPmFijcNGMD4AVBg03GNtrk/JY1h0yJJtO
         ZqgtjFgsEc/aBjWjHGvg0nF9c98hcrrFPtdzVo7brJtZdG/BmSQHJR2ELAhwGzZY2XIa
         Xzzg==
X-Gm-Message-State: AOAM530j9pIUUfjxtLzd2toB2hsxq4uZfZtwcOw9Vvl7n7iFDUofbi6T
        lguB/t2yAGVuaj87Z1gfJxffdw==
X-Google-Smtp-Source: ABdhPJzMZUYleeQSiIhOFPG2P/DidutEB3glNkXsbtPLIAjr9ajmQIPI/We0jC/1sgmvuqkqgZmNaQ==
X-Received: by 2002:a17:90a:7c45:: with SMTP id e5mr3198293pjl.170.1612516467392;
        Fri, 05 Feb 2021 01:14:27 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j3sm7721155pjs.50.2021.02.05.01.14.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:14:26 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:44:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203114521.GA6380@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-02-21, 11:45, Ionela Voinescu wrote:
> Therefore, I think system level invariance management (checks and
> call to rebuild_sched_domains_energy()) also needs to move from arm64
> code to arch_topology code.

Here is the 3rd patch of this series then :)

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 5 Feb 2021 13:31:53 +0530
Subject: [PATCH] drivers: arch_topology: rebuild sched domains on invariance
 change

We already do this for the arm64, move it to arch_topology.c as we
manage all sched_freq_tick sources here now.

Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 16 ----------------
 drivers/base/arch_topology.c | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1e47dfd465f8..47fca7376c93 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -240,7 +240,6 @@ static struct scale_freq_data amu_sfd = {
 
 static void amu_fie_setup(const struct cpumask *cpus)
 {
-	bool invariant;
 	int cpu;
 
 	/* We are already set since the last insmod of cpufreq driver */
@@ -257,25 +256,10 @@ static void amu_fie_setup(const struct cpumask *cpus)
 
 	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
 
-	invariant = topology_scale_freq_invariant();
-
-	/* We aren't fully invariant yet */
-	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
-		return;
-
 	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
 
 	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
 		 cpumask_pr_args(cpus));
-
-	/*
-	 * Task scheduler behavior depends on frequency invariance support,
-	 * either cpufreq or counter driven. If the support status changes as
-	 * a result of counter initialisation and use, retrigger the build of
-	 * scheduling domains to ensure the information is propagated properly.
-	 */
-	if (!invariant)
-		rebuild_sched_domains_energy();
 }
 
 static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 20b511949cd8..3631877f4440 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -23,6 +23,7 @@
 
 static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
 static struct cpumask scale_freq_counters_mask;
+static bool scale_freq_invariant;
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -35,6 +36,23 @@ bool topology_scale_freq_invariant(void)
 	       supports_scale_freq_counters(cpu_online_mask);
 }
 
+static void update_scale_freq_invariant(bool status)
+{
+	if (scale_freq_invariant == status)
+		return;
+
+	/*
+	 * Task scheduler behavior depends on frequency invariance support,
+	 * either cpufreq or counter driven. If the support status changes as
+	 * a result of counter initialisation and use, retrigger the build of
+	 * scheduling domains to ensure the information is propagated properly.
+	 */
+	if (topology_scale_freq_invariant() == status) {
+		scale_freq_invariant = status;
+		rebuild_sched_domains_energy();
+	}
+}
+
 void topology_set_scale_freq_source(struct scale_freq_data *data,
 				    const struct cpumask *cpus)
 {
@@ -50,6 +68,8 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
 			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
 		}
 	}
+
+	update_scale_freq_invariant(true);
 }
 EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
 
@@ -67,6 +87,8 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
 			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
 		}
 	}
+
+	update_scale_freq_invariant(false);
 }
 EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
 
-- 
2.25.0.rc1.19.g042ed3e048af

-- 
viresh
