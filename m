Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC83FD640
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbhIAJNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243452AbhIAJNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 05:13:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDFC0613D9
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 02:12:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k24so2096314pgh.8
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSLnBv6HzrzRT2E+OrtX7br/e1aM+QCsCVPYd1HLzdc=;
        b=gamJq1iYdnzqTJXSjm+5RkT6COhyrD+KFLc/YuFGGAyOn10TEbeOJ+VJJ/PMMkbAbb
         X8TVF4KZGYZKD2YBT1ll8KLrV6NMxqEdNpP27Hfce9FAbTSmzKiVRXIa6h1SdrK5/3oS
         QgcGhCmBL9ANHdpdCml7SSM8VwC53T7fEDYi3DwyXO8n7sPg7VgW8CdDoL828KmOZwiO
         uY7q60iFvh7y5e6/kpwIG6tXxZrvbUQNYj+7afblhj1EWFnXxAclrcdHvUq4SHeOWTba
         YRNchczQ0me0e6DJrm9o87wVIEpn9ad82xPYPIPQ98xjHX/J2eE0hkeCFp7YR9YTgeMb
         blUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSLnBv6HzrzRT2E+OrtX7br/e1aM+QCsCVPYd1HLzdc=;
        b=aQlX+l+AsHpPZS40BbYAp/zlqjcEm4eXEMvDKMgLQM8GqapJ8+5JpCSdgYHhyATW/b
         8r5MBmTs9SWXXsPy+vAxd+I0wb35/ZsxBZA1+AHQK/IYCYQnXHRXLsjDHDrK/2lf+TFC
         A5+0Vo4vF8vu2+PYiY7qKaOigDHMyWHnYSZ6f14FIN6zje9LqNHW1ZAl3fMlZXTIH4Qm
         e55e4DJNDlWxtgxnJX6DTT6aSa4TNY4U/24j8/KdJLYpPYOwACQ/M9F42ml2Ct4xpTpl
         Yw09nm91fyMPRCWjflWGLP4XEMyE11TWr2P35BTfYN9HMsSPpX0tr+mzUvpnO2q/jden
         nhpg==
X-Gm-Message-State: AOAM532mLsxGecaXrdf/PagwV5UciHOtsYtxxTsEEDuU2L6EI7c87Yfh
        79SnXjkppNCEg3nuoFAMirj9Xg==
X-Google-Smtp-Source: ABdhPJx3GapedXo1LpKHC7Vvi+SwU4/wP2MNKKT+1JUHstrRZUG0Jx8e4bs6LSJDFeo5HtO+2iR6kA==
X-Received: by 2002:a65:648b:: with SMTP id e11mr30941505pgv.138.1630487537479;
        Wed, 01 Sep 2021 02:12:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id o15sm4900093pjr.0.2021.09.01.02.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 02:12:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: Remove ready() callback
Date:   Wed,  1 Sep 2021 14:41:57 +0530
Message-Id: <9c2435b18039fe50328b8f443dcd4dbb009f4618.1630487322.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1630487322.git.viresh.kumar@linaro.org>
References: <cover.1630487322.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This isn't used anymore, get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.rst                    | 3 ---
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 2 --
 drivers/cpufreq/cpufreq.c                                 | 4 ----
 include/linux/cpufreq.h                                   | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index d84ededb66f9..3b32336a7803 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -75,9 +75,6 @@ And optionally
  .resume - A pointer to a per-policy resume function which is called
  with interrupts disabled and _before_ the governor is started again.
 
- .ready - A pointer to a per-policy ready function which is called after
- the policy is fully initialized.
-
  .attr - A pointer to a NULL-terminated list of "struct freq_attr" which
  allow to export values to sysfs.
 
diff --git a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
index 5ae9cfa2ec55..334f30ae198b 100644
--- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -80,8 +80,6 @@ 并且可选择
  .resume - 一个指向per-policy恢复函数的指针，该函数在关中断且在调节器再一次开始前被
  调用。
 
- .ready - 一个指向per-policy准备函数的指针，该函数在策略完全初始化之后被调用。
-
  .attr - 一个指向NULL结尾的"struct freq_attr"列表的指针，该函数允许导出值到
  sysfs。
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7d5f170ecad1..5782b15a8caa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1517,10 +1517,6 @@ static int cpufreq_online(unsigned int cpu)
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 
-	/* Callback for handling stuff after policy is ready */
-	if (cpufreq_driver->ready)
-		cpufreq_driver->ready(policy);
-
 	if (cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c65a1d7385f8..fe6acc04e5e5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -367,9 +367,6 @@ struct cpufreq_driver {
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
 
-	/* Will be called after the driver is fully initialized */
-	void		(*ready)(struct cpufreq_policy *policy);
-
 	struct freq_attr **attr;
 
 	/* platform specific boost support code */
-- 
2.31.1.272.g89b43f80a514

