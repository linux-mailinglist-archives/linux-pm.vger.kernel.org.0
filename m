Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7696FEE33
	for <lists+linux-pm@lfdr.de>; Thu, 11 May 2023 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjEKJBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 May 2023 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbjEKJBm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2023 05:01:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742FE659C
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 02:01:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643465067d1so6221806b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683795700; x=1686387700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PpOPhoCRVVr4TLf/GE5sbLeu85r6UE17A7mxhEqx2o0=;
        b=HHFkKe4JvdA7myvOau9njF7ZmmErc0XVypuKeNk8WMGsuTOFNJXXDeWPDKDQ/yFlE+
         hUhKmT6e19CYoH4myEJ3S1m5845Wml4A6K7yEp7k+i4VoijSFXox8xWmJL5cI/AeJO2L
         9IAZu6yZwQa3/y79rbrfI9lzAMN+BiVgHNl+WbEEs+OP7OXomdA1ztkOh738D4ltMhip
         XHUejG/lTTSuunzbSvQMKUbD4tJYOXKMj85K9+VETxEvJ70OM1EbuMRFnZceU12LZppW
         EY0sCSPw9D5TSAMzOmTgsrk7dkZ0+5m0ZyajLKW9fPhkL+mulrNak7/f+98AV50t1OS4
         r7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795700; x=1686387700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpOPhoCRVVr4TLf/GE5sbLeu85r6UE17A7mxhEqx2o0=;
        b=AtEF4/PoZthsk50nGV/VAKjVm/YkUJlqeRByU2gwBBAsbTOPS1/k4t+jnAB6Mk9BLJ
         dKLpf5qdJZAOUFSM5zQCh7XJDAS1FLgEgkL5hdYpjRqOPlfQmmGiSf8tF+WXii4jSCpt
         xmTi7WapRzVJiCkimY8lWZVtBH4taFEzLOqeMMRudTbfmrX0BudbgS7APIttY2BU7yie
         39OmpEm3b3M+TFrPfl2Ahk33ZQlc7MPUCeem97sfauRTNcVd1Tpph6spypBEvhh1Anhp
         w9ItvirWcBk4PbwKHG5opViPC1NaP3YxFEFsHk/kdA9l+3afY+tp9fnkZXPdSjpSIzAI
         8vjQ==
X-Gm-Message-State: AC+VfDwf4ovWaWx3n3TPeDsOofz6wf2bnHdP1hGruXC25CAw2LM3VM45
        7xOHjzVDX9F33snFltnYw3mFEeZJXT6kwiP2qkA=
X-Google-Smtp-Source: ACHHUZ6JgoRzqLA2cz+zc9bNBX0BbFPi/HYzdaITNpGUB6ZbCCjPlDjACy775tc0kp2mlbDWsu4LPw==
X-Received: by 2002:a05:6a00:2d0e:b0:641:699:f353 with SMTP id fa14-20020a056a002d0e00b006410699f353mr28047084pfb.22.1683795699855;
        Thu, 11 May 2023 02:01:39 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id x9-20020aa784c9000000b006475f831838sm3820037pfn.30.2023.05.11.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:01:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sparc: Don't allocate cpufreq_driver dynamically
Date:   Thu, 11 May 2023 14:31:00 +0530
Message-Id: <96f7ea2c952075030ab8d24ee2d3983e1b144f36.1683795616.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no point allocating the cpufreq driver dynamically and add so
much complexity in the driver.

Do what is done for other cpufreq drivers and statically allocate the
cpufreq driver.

Reported-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Looks like I wrote this back in April and forgot to send it :(

 drivers/cpufreq/sparc-us2e-cpufreq.c | 58 ++++++++--------------------
 drivers/cpufreq/sparc-us3-cpufreq.c  | 58 ++++++++--------------------
 2 files changed, 34 insertions(+), 82 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 92acbb25abb3..d3510cfdb3eb 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -20,8 +20,6 @@
 #include <asm/asi.h>
 #include <asm/timer.h>
 
-static struct cpufreq_driver *cpufreq_us2e_driver;
-
 struct us2e_freq_percpu_info {
 	struct cpufreq_frequency_table table[6];
 };
@@ -300,12 +298,19 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
 
 static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cpufreq_us2e_driver)
-		us2e_freq_target(policy, 0);
-
+	us2e_freq_target(policy, 0);
 	return 0;
 }
 
+static struct cpufreq_driver cpufreq_us2e_driver = {
+	.name = "UltraSPARC-IIe",
+	.init = us2e_freq_cpu_init,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = us2e_freq_target,
+	.get = us2e_freq_get,
+	.exit = us2e_freq_cpu_exit,
+};
+
 static int __init us2e_freq_init(void)
 {
 	unsigned long manuf, impl, ver;
@@ -319,39 +324,15 @@ static int __init us2e_freq_init(void)
 	impl  = ((ver >> 32) & 0xffff);
 
 	if (manuf == 0x17 && impl == 0x13) {
-		struct cpufreq_driver *driver;
-
-		ret = -ENOMEM;
-		driver = kzalloc(sizeof(*driver), GFP_KERNEL);
-		if (!driver)
-			goto err_out;
-
-		us2e_freq_table = kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
-			GFP_KERNEL);
+		us2e_freq_table = kzalloc(NR_CPUS * sizeof(*us2e_freq_table),
+					  GFP_KERNEL);
 		if (!us2e_freq_table)
-			goto err_out;
-
-		driver->init = us2e_freq_cpu_init;
-		driver->verify = cpufreq_generic_frequency_table_verify;
-		driver->target_index = us2e_freq_target;
-		driver->get = us2e_freq_get;
-		driver->exit = us2e_freq_cpu_exit;
-		strcpy(driver->name, "UltraSPARC-IIe");
+			return -ENOMEM;
 
-		cpufreq_us2e_driver = driver;
-		ret = cpufreq_register_driver(driver);
+		ret = cpufreq_register_driver(&cpufreq_us2e_driver);
 		if (ret)
-			goto err_out;
+			kfree(us2e_freq_table);
 
-		return 0;
-
-err_out:
-		if (driver) {
-			kfree(driver);
-			cpufreq_us2e_driver = NULL;
-		}
-		kfree(us2e_freq_table);
-		us2e_freq_table = NULL;
 		return ret;
 	}
 
@@ -360,13 +341,8 @@ static int __init us2e_freq_init(void)
 
 static void __exit us2e_freq_exit(void)
 {
-	if (cpufreq_us2e_driver) {
-		cpufreq_unregister_driver(cpufreq_us2e_driver);
-		kfree(cpufreq_us2e_driver);
-		cpufreq_us2e_driver = NULL;
-		kfree(us2e_freq_table);
-		us2e_freq_table = NULL;
-	}
+	cpufreq_unregister_driver(&cpufreq_us2e_driver);
+	kfree(us2e_freq_table);
 }
 
 MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index e41b35b16afd..91d1ed558136 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -19,8 +19,6 @@
 #include <asm/head.h>
 #include <asm/timer.h>
 
-static struct cpufreq_driver *cpufreq_us3_driver;
-
 struct us3_freq_percpu_info {
 	struct cpufreq_frequency_table table[4];
 };
@@ -144,12 +142,19 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
 
 static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (cpufreq_us3_driver)
-		us3_freq_target(policy, 0);
-
+	us3_freq_target(policy, 0);
 	return 0;
 }
 
+static struct cpufreq_driver cpufreq_us3_driver = {
+	.name = "UltraSPARC-III",
+	.init = us3_freq_cpu_init,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = us3_freq_target,
+	.get = us3_freq_get,
+	.exit = us3_freq_cpu_exit,
+};
+
 static int __init us3_freq_init(void)
 {
 	unsigned long manuf, impl, ver;
@@ -167,39 +172,15 @@ static int __init us3_freq_init(void)
 	     impl == CHEETAH_PLUS_IMPL ||
 	     impl == JAGUAR_IMPL ||
 	     impl == PANTHER_IMPL)) {
-		struct cpufreq_driver *driver;
-
-		ret = -ENOMEM;
-		driver = kzalloc(sizeof(*driver), GFP_KERNEL);
-		if (!driver)
-			goto err_out;
-
-		us3_freq_table = kzalloc((NR_CPUS * sizeof(*us3_freq_table)),
-			GFP_KERNEL);
+		us3_freq_table = kzalloc(NR_CPUS * sizeof(*us3_freq_table),
+					 GFP_KERNEL);
 		if (!us3_freq_table)
-			goto err_out;
-
-		driver->init = us3_freq_cpu_init;
-		driver->verify = cpufreq_generic_frequency_table_verify;
-		driver->target_index = us3_freq_target;
-		driver->get = us3_freq_get;
-		driver->exit = us3_freq_cpu_exit;
-		strcpy(driver->name, "UltraSPARC-III");
+			return -ENOMEM;
 
-		cpufreq_us3_driver = driver;
-		ret = cpufreq_register_driver(driver);
+		ret = cpufreq_register_driver(&cpufreq_us3_driver);
 		if (ret)
-			goto err_out;
+			kfree(us3_freq_table);
 
-		return 0;
-
-err_out:
-		if (driver) {
-			kfree(driver);
-			cpufreq_us3_driver = NULL;
-		}
-		kfree(us3_freq_table);
-		us3_freq_table = NULL;
 		return ret;
 	}
 
@@ -208,13 +189,8 @@ static int __init us3_freq_init(void)
 
 static void __exit us3_freq_exit(void)
 {
-	if (cpufreq_us3_driver) {
-		cpufreq_unregister_driver(cpufreq_us3_driver);
-		kfree(cpufreq_us3_driver);
-		cpufreq_us3_driver = NULL;
-		kfree(us3_freq_table);
-		us3_freq_table = NULL;
-	}
+	cpufreq_unregister_driver(&cpufreq_us3_driver);
+	kfree(us3_freq_table);
 }
 
 MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
-- 
2.31.1.272.g89b43f80a514

