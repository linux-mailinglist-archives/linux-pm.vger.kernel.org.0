Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA91E231F05
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgG2NJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 09:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2NJQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 09:09:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B82C061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 06:09:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so18031578wrm.12
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQfdEuMEXU5Gdcf8kVbSvuqtuSTWo+SqwETHH/EjJfI=;
        b=SuYvuX0IPCTcXEtfXXG68mvZ/p9xhMQDFcgCiKY5yIg+y5OlPUVAKNNF/hZG3sh3vd
         ZDdsoF8isKHtF4VEfba4yNQYQMAtk9f+UY5bxgNBI3qfW90yE+oA+GxIM9yphD/FePN8
         xFVCMDJEUC8uFud+QApNIx/qBkckMBeFrDLWoRMZEzJ/5WkLD99JdhJq8FzeM6AoedTV
         fQm8kgKpF7MOOsyRhndcJawlJ2yb0REhjSCq42rQQ3wPZne8LlWoAnoiRALslALMr+Lk
         qiyOVL9ksB7T9NpJmNAw0dQtJnbBO0j4F3jPIxxSi/ftEUsAsvItJR3LzpOjV55145c+
         /5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQfdEuMEXU5Gdcf8kVbSvuqtuSTWo+SqwETHH/EjJfI=;
        b=AAEyYRaLDzfws3XZZPOHpIyzfYCvb8O3wKytRS+WgCJm5cK6Q8Z2+NOyuYMuYUC6n7
         shseXOwGWZlmLVOdsJyLEklECGIMWll+l4f9oh04IfbTFn1za5QC4grRLS6te8V8zbif
         KOeQIcjJf+fEudOk1Uy9Je+WcfP4+xr/Dni3p7U1IqjDWv3tKhxKwep+VwKxCF0SUABQ
         JoVJg8oPVRxjXO+BcgQblrI/MqUWF4Y0acJQvZMvZUtdx+8uufjQ7uavGbWRHsM6RjEI
         jBUbAWBwiNqS6vZW21H++ab3BlI/vExhz/8mP+94j2NVps1OFAC1etFtzLQjhMCsTOu6
         il6Q==
X-Gm-Message-State: AOAM53359nxNwMmRiJXPXxIK+1RSu6GUJmPjrapo0Plfy713cjZF681t
        jsUg+zBMlXuImprQhwieG9saRA==
X-Google-Smtp-Source: ABdhPJxSAMPSjI0FLvCE+74bREfrHAh6dkek8xiGTxb62T9e8tMQouxd50GMLeyj296EW8A60fEAVQ==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr14678893wrw.311.1596028154475;
        Wed, 29 Jul 2020 06:09:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id v8sm4017619wmb.24.2020.07.29.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 06:09:13 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:09:10 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 2/3] sched: Cleanup SCHED_THERMAL_PRESSURE kconfig
 entry
Message-ID: <20200729130910.GA1075614@google.com>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
 <20200712165917.9168-3-valentin.schneider@arm.com>
 <20200727141825.GA4174@lca.pw>
 <16f8c1d4-778b-3ab8-f328-bae80f3973b4@arm.com>
 <jhjpn8fiphi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjpn8fiphi.mognet@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 28 Jul 2020 at 17:16:57 (+0100), Valentin Schneider wrote:
> We could change the arch Kconfig into
> 
>   select SCHED_THERMAL_PRESSURE if CPU_FREQ_THERMAL
> 
> but that seems redundant; this dependency is already expressed in
> SCHED_THERMAL_PRESSURE's definition. Is there a proper pattern to select
> some Kconfig option only if all of its dependencies are met?

How about something like this (totally untested):

---8<---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 939c4d6bbc2e..2ac74904a3ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -46,7 +46,6 @@ config ARM
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
-	select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c403e6f5db86..66dc41fd49f2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,7 +192,6 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
-	select SCHED_THERMAL_PRESSURE
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/init/Kconfig b/init/Kconfig
index 0a97d85568b2..c2e1f3ac527e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -493,6 +493,7 @@ config HAVE_SCHED_AVG_IRQ
 
 config SCHED_THERMAL_PRESSURE
 	bool
+	default y if ARM64 || ARM_CPU_TOPOLOGY
 	depends on SMP
 	depends on CPU_FREQ_THERMAL
 	help
--->8---

Thanks,
Quentin
