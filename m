Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6645830B6C2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 05:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhBBE4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 23:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBBE4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 23:56:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31A0C061786
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 20:55:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m12so1494905pjs.4
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2021 20:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnjYJhpsvi+EI6uh+V9emtTk5rRYy/hy1WxcaaGRj88=;
        b=jMCQvOrib39iuufOoGnShhg7/M0QlLhgoR/DzvJuyYtnVlkdshCDsPRDtE/0jgK5k5
         8aMyNcmbhs8BDR+1UNY05IUJIYrCvtXEVFL/6HNtEQlTwpxRbWt88F1EtwOZ9MxLQfyb
         DTNRKEzt4tnv9/2gVzxaMgFW+eo6yqLUy2gm6ZI8O7r1C+HdaJy0zFMT1s9WTtQtJYU2
         1P3i1Ab8BqjM566cK4qfFZdO69Xb4RzEMAHOIGIz36rUvN0mBoX/UyA4W5qvitshuPCr
         BmfUrJDFbatH0Zfvc/D/1ftB2GWy9u/W70MmT6r5Owh7rLlxipN4VEyMXLt5CZbl8hj8
         DQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnjYJhpsvi+EI6uh+V9emtTk5rRYy/hy1WxcaaGRj88=;
        b=UzMxkrajQ3ccz8PdTRMbPWzaOX3Gv/9pGYfz9q7qhgMTtBsSM+WC5Q00H3K+1Kbvqe
         qlgeU6eHHLcUhCKFZ+gjAgZzitXB05Vc9mXho9rB/IecB0LuqpC2cqajDwgdhoYpScB9
         vrMv0Goo1DFBRm3SqOvGra5CFXdSPrlUrAXVF9H0iwIS7GYZoX3H5jIVoEg1QYpYnlVV
         tnyB5TfFqnMfBybAei74oQK2EdoSSDe2sl0uFa7VZgxsgABd4z1Iw2bVnui5357cy20T
         xlKLWWYoPsWchoKWpy1bELj76VUJRhQeAOJFMmguYiTHhr2NPJIdk4iZMnG408j1p3br
         8gPQ==
X-Gm-Message-State: AOAM532O0nxnLCjCuJVKti+4OAaO6V1bgIyXpwcDwhhEhGi8Hk/GrBU+
        Bag9GicUlSpOlKwnYmKwN7hVtg==
X-Google-Smtp-Source: ABdhPJwS93fNsUH31dYgXN8xBzZ5bkht/DGUPiwXokd8KJoRuC/YLfOQ67hcBaOskP59AiVUpErNJg==
X-Received: by 2002:a17:903:22c2:b029:de:45c0:69f2 with SMTP id y2-20020a17090322c2b02900de45c069f2mr20804008plg.26.1612241719095;
        Mon, 01 Feb 2021 20:55:19 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i3sm20044312pfq.194.2021.02.01.20.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 20:55:18 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH V2] cpufreq: Remove CPUFREQ_STICKY flag
Date:   Tue,  2 Feb 2021 10:25:11 +0530
Message-Id: <a59bb322b22c247d570b70a8e94067804287623b.1612241683.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

During cpufreq driver's registration, if the ->init() callback for all
the CPUs fail then there is not much point in keeping the driver around
as it will only account for more of unnecessary noise, for example
cpufreq core will try to suspend/resume the driver which never got
registered properly.

The removal of such a driver is avoided if the driver carries the
CPUFREQ_STICKY flag. This was added way back [1] in 2004 and perhaps no
one should ever need it now. A lot of drivers do set this flag, probably
because they just copied it from other drivers.

This was added earlier for some platforms [2] because their cpufreq
drivers were getting registered before the CPUs were registered with
subsys framework. And hence they used to fail.

The same isn't true anymore though. The current code flow in the kernel
is:

start_kernel()
-> kernel_init()
   -> kernel_init_freeable()
      -> do_basic_setup()
         -> driver_init()
            -> cpu_dev_init()
               -> subsys_system_register() //For CPUs

         -> do_initcalls()
            -> cpufreq_register_driver()

Clearly, the CPUs will always get registered with subsys framework
before any cpufreq driver can get probed. Remove the flag and update the
relevant drivers.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/include/linux/cpufreq.h?id=7cc9f0d9a1ab04cedc60d64fd8dcf7df224a3b4d
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/arch/arm/mach-sa1100/cpu-sa1100.c?id=f59d3bbe35f6268d729f51be82af8325d62f20f5

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Detailed commit log.

 drivers/cpufreq/cpufreq-dt.c           |  2 +-
 drivers/cpufreq/cpufreq.c              |  3 +--
 drivers/cpufreq/davinci-cpufreq.c      |  2 +-
 drivers/cpufreq/loongson1-cpufreq.c    |  2 +-
 drivers/cpufreq/mediatek-cpufreq.c     |  2 +-
 drivers/cpufreq/omap-cpufreq.c         |  2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      |  2 +-
 drivers/cpufreq/s3c24xx-cpufreq.c      |  2 +-
 drivers/cpufreq/s5pv210-cpufreq.c      |  2 +-
 drivers/cpufreq/sa1100-cpufreq.c       |  2 +-
 drivers/cpufreq/sa1110-cpufreq.c       |  2 +-
 drivers/cpufreq/scmi-cpufreq.c         |  2 +-
 drivers/cpufreq/scpi-cpufreq.c         |  2 +-
 drivers/cpufreq/spear-cpufreq.c        |  2 +-
 drivers/cpufreq/tegra186-cpufreq.c     |  2 +-
 drivers/cpufreq/tegra194-cpufreq.c     |  3 +--
 drivers/cpufreq/vexpress-spc-cpufreq.c |  3 +--
 include/linux/cpufreq.h                | 17 +++++++----------
 18 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ad4234518ef6..b1e1bdc63b01 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -175,7 +175,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 }
 
 static struct cpufreq_driver dt_cpufreq_driver = {
-	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d0a3525ce27f..7d0ae968def7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2810,8 +2810,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (ret)
 		goto err_boost_unreg;
 
-	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
-	    list_empty(&cpufreq_policy_list)) {
+	if (unlikely(list_empty(&cpufreq_policy_list))) {
 		/* if all ->init() calls failed, unregister */
 		ret = -ENODEV;
 		pr_debug("%s: No CPU initialized for driver %s\n", __func__,
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 91f477a6cbc4..9e97f60f8199 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -95,7 +95,7 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 }
 
 static struct cpufreq_driver davinci_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= davinci_target,
 	.get		= cpufreq_generic_get,
diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 86f612593e49..fb72d709db56 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -116,7 +116,7 @@ static int ls1x_cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver ls1x_cpufreq_driver = {
 	.name		= "cpufreq-ls1x",
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= ls1x_cpufreq_target,
 	.get		= cpufreq_generic_get,
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 022e3e966e71..f2e491b25b07 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -463,7 +463,7 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 }
 
 static struct cpufreq_driver mtk_cpufreq_driver = {
-	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 3694bb030df3..e035ee216b0f 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -144,7 +144,7 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 }
 
 static struct cpufreq_driver omap_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= omap_target,
 	.get		= cpufreq_generic_get,
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9ed5341dc515..2a3b4f44488b 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -374,7 +374,7 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 };
 
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 			  CPUFREQ_IS_COOLING_DEV,
 	.verify		= cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 37efc0dc3f91..7380c32b238e 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -420,7 +420,7 @@ static int s3c_cpufreq_resume(struct cpufreq_policy *policy)
 #endif
 
 static struct cpufreq_driver s3c24xx_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.target		= s3c_cpufreq_target,
 	.get		= cpufreq_generic_get,
 	.init		= s3c_cpufreq_init,
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index bed496cf8d24..69786e5bbf05 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -574,7 +574,7 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
 }
 
 static struct cpufreq_driver s5pv210_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= s5pv210_target,
 	.get		= cpufreq_generic_get,
diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index 5c075ef6adc0..252b9fc26124 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -186,7 +186,7 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 }
 
 static struct cpufreq_driver sa1100_driver __refdata = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= sa1100_target,
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index d9d04d935b3a..1a83c8678a63 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -310,7 +310,7 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 /* sa1110_driver needs __refdata because it must remain after init registers
  * it with cpufreq_register_driver() */
 static struct cpufreq_driver sa1110_driver __refdata = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= sa1110_target,
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 491a0a24fb1e..5bd03b59887f 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -217,7 +217,7 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
-	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index e5140ad63db8..d6a698a1b5d1 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -191,7 +191,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
-	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 73bd8dc47074..7d0d62a06bf3 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -160,7 +160,7 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver spear_cpufreq_driver = {
 	.name		= "cpufreq-spear",
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= spear_cpufreq_target,
 	.get		= cpufreq_generic_get,
diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index e566ea298b59..5d1943e787b0 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -117,7 +117,7 @@ static unsigned int tegra186_cpufreq_get(unsigned int cpu)
 
 static struct cpufreq_driver tegra186_cpufreq_driver = {
 	.name = "tegra186",
-	.flags = CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+	.flags = CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 			CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.get = tegra186_cpufreq_get,
 	.verify = cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 6a67f36f3b80..a9620e4489ae 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -272,8 +272,7 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 
 static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.name = "tegra194",
-	.flags = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS |
-		CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = tegra194_cpufreq_set_target,
 	.get = tegra194_get_speed,
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index f711d8eaea6a..51dfa9ae6cf5 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -486,8 +486,7 @@ static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.name			= "vexpress-spc",
-	.flags			= CPUFREQ_STICKY |
-					CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+	.flags			= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify			= cpufreq_generic_frequency_table_verify,
 	.target_index		= ve_spc_cpufreq_set_target,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9c8b7437b6cd..c8e40e91fe9b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -387,8 +387,13 @@ struct cpufreq_driver {
 
 /* flags */
 
-/* driver isn't removed even if all ->init() calls failed */
-#define CPUFREQ_STICKY				BIT(0)
+/*
+ * Set by drivers that need to update internale upper and lower boundaries along
+ * with the target frequency and so the core and governors should also invoke
+ * the diver if the target frequency does not change, but the policy min or max
+ * may have changed.
+ */
+#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
 
 /* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
 #define CPUFREQ_CONST_LOOPS			BIT(1)
@@ -432,14 +437,6 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_IS_COOLING_DEV			BIT(7)
 
-/*
- * Set by drivers that need to update internale upper and lower boundaries along
- * with the target frequency and so the core and governors should also invoke
- * the diver if the target frequency does not change, but the policy min or max
- * may have changed.
- */
-#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(8)
-
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.25.0.rc1.19.g042ed3e048af

