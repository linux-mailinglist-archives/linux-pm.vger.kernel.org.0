Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9FE3B6E45
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhF2G3r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 02:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhF2G3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 02:29:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96598C061760
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 23:27:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1350769pjx.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmWe9Vq21X/jj7YIMqM+Ctm/Lrcx68BGlGSe9RyB0yA=;
        b=XQzjX7G8XcUa1PnQduhgk9ecZYXbeD6UMiCM2ToFSNyNgUmZJH8eksfL1TIlf62zcX
         NfMJPjmrKVYJNeg/7Yhuu/BDz8YN8oBglqN0MHY4yOMr2sfYh0+LGbWh+q9VubeffoHF
         lYoEkYLbXHaE/jmGRH9drn0INiuonzvqrndJABwZpsUuctr5YtadyJ+Fg5/jAFp30mN9
         dCjuaIXZQohOcf78pIlW8HwJyUF/udVzdWg2sJRSpoo1Gd5bMDYWdSvgnKJw4QjTHX3a
         tuGosY89PCEgJnoIWwRqdPvtUbpmd9DGmavsL/VSsrkYDZgoA8EgBYXsDtD5gEbThTIJ
         BS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmWe9Vq21X/jj7YIMqM+Ctm/Lrcx68BGlGSe9RyB0yA=;
        b=QzmI3k1Cq7+mHEWs5ws8mhGvSkf69wwQab/AKYsZJ8IdlVGdCLhqEGw0gI+Ge9TjxN
         1DtPtdFer+msYJeDxdLAImZw6NPnpUsbv49jYFefqtEyWBMbBSj1O/F3OQL7UNEl9mNL
         QwqW+6T3dywhWhHFKek65POXkQ596/8AS9jdmzG368QFEbZfwHhrmxDIKkitE937jS2S
         sVmSthXcChHWha4lGfCbXWX1YkER2vnZ5Z9tPfFFJuF4gkp3FCuIJ+gEqU0/SRzio3DC
         pYuweKFLchG2+IK8mdF3mA69ht9owG0sTZh5wLZpbLFg3gMtW5tFAX0sIFaklXPZWNfb
         URHQ==
X-Gm-Message-State: AOAM531pfnNvZ4pGr+458kuDYKvQZnEMXOFl3DaK3x3qEpyGpC5ItARt
        fkiuuqksSz/88UL25HTGiyQFOg==
X-Google-Smtp-Source: ABdhPJwK0qWXw7nqwnRcNOLb9GEJ378RLcnYx9rnA9zS/ylvAg3eAOvgPB7/5cgFqkZGrrH92hsA7Q==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr25923101plh.11.1624948035163;
        Mon, 28 Jun 2021 23:27:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id b126sm16705885pfg.176.2021.06.28.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:27:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        TungChen Shih <tung-chen.shih@mediatek.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: Remove ->resolve_freq()
Date:   Tue, 29 Jun 2021 11:57:08 +0530
Message-Id: <759b9ad35a011e36f3b203fb01ac3d505269befa.1624946983.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <b5ac439050ab3c5b92621e20490fe7f46d631ef6.1624946983.git.viresh.kumar@linaro.org>
References: <b5ac439050ab3c5b92621e20490fe7f46d631ef6.1624946983.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
introduced this callback, back in 2016, for drivers that provide the
->target() callback.

The kernel haven't seen a single user of the same in the past 5 years
and there is little hope that it will be used anytime soon.

Lets remove it for now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.rst        |  3 ---
 .../zh_CN/cpu-freq/cpu-drivers.rst            |  2 --
 drivers/cpufreq/cpufreq.c                     | 21 +++++++------------
 include/linux/cpufreq.h                       |  9 --------
 4 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index a697278ce190..5ee49820d48a 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -58,9 +58,6 @@ And optionally
 
  .driver_data - cpufreq driver specific data.
 
- .resolve_freq - Returns the most appropriate frequency for a target
- frequency. Doesn't change the frequency though.
-
  .get_intermediate and target_intermediate - Used to switch to stable
  frequency while changing CPU frequency.
 
diff --git a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
index 0ca2cb646666..f906a4e5a3ac 100644
--- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -64,8 +64,6 @@ 并且可选择
 
  .driver_data - cpufreq驱动程序的特定数据。
 
- .resolve_freq - 返回最适合目标频率的频率。不过并不能改变频率。
-
  .get_intermediate 和 target_intermediate - 用于在改变CPU频率时切换到稳定
  的频率。
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d691c6c97c79..b106191d84b1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -527,22 +527,17 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 		unsigned int target_freq, unsigned int relation)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-	policy->cached_target_freq = target_freq;
+	unsigned int idx;
 
-	if (cpufreq_driver->target_index) {
-		unsigned int idx;
-
-		idx = cpufreq_frequency_table_target(policy, target_freq,
-						     relation);
-		policy->cached_resolved_idx = idx;
-		return policy->freq_table[idx].frequency;
-	}
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
-	if (cpufreq_driver->resolve_freq)
-		return cpufreq_driver->resolve_freq(policy, target_freq);
+	if (!cpufreq_driver->target_index)
+		return target_freq;
 
-	return target_freq;
+	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
+	policy->cached_resolved_idx = idx;
+	policy->cached_target_freq = target_freq;
+	return policy->freq_table[idx].frequency;
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 353969c7acd3..18f0ddf7347a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -330,15 +330,6 @@ struct cpufreq_driver {
 				       unsigned long target_perf,
 				       unsigned long capacity);
 
-	/*
-	 * Caches and returns the lowest driver-supported frequency greater than
-	 * or equal to the target frequency, subject to any driver limitations.
-	 * Does not set the frequency. Only to be implemented for drivers with
-	 * target().
-	 */
-	unsigned int	(*resolve_freq)(struct cpufreq_policy *policy,
-					unsigned int target_freq);
-
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
-- 
2.31.1.272.g89b43f80a514

