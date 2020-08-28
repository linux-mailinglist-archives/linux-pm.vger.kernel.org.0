Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844E2255456
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 08:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgH1GJG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgH1GIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 02:08:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DDC061237
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j11so1425484plk.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ltB0x29xQVj68tlFCXWk/tYz44PXtyGE60oP/+ehOs=;
        b=rdyR3brTWRm2cdYTcp4hJs26JKuqhOUxZKUhjd8MXxr61ST+mUFJHEa0bdPMaXG2ai
         Yr2/H4WF08CrEFfnDljGlqo5/eZ6LNqfyv3qFfb/aJ+8RL9VgUNjNIni8nUqcIpzTbLP
         r5iP2wfqCqFOUeDuFRjvUpkmVpqXSnq1J7/NFFwUwtqYqiqICTKGaFhOI+xi59PZKZfl
         NmWVqYo4UwOfqI+yDmOIuLBeg16/LA2P7QPjBVgUoz08f9c/4i2hO33MvMVeVP0+67Bj
         W1lMwXBt1w8cIXpfXxx6t2GTwKq3QmGxQ8PUdabh9Vtaj9A35dOSKNBygH/FrbxJ6kaf
         qFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ltB0x29xQVj68tlFCXWk/tYz44PXtyGE60oP/+ehOs=;
        b=Ccwj31K98+n6ZiJT0gi9d+SbauEvIYsUroVh0ao9mn4x2Epf8N1km8JlmoOjbq9Gzi
         Ei3PxXC+SHCnvxK4oZDyvW/K2HgZx/KTL4FyCwQ//6skDNZTudeL4eAlFXdsM/u7xDOw
         EJZihdIzAmgOm/T5QqMzYpIlwOS1g1//GEwQzXfY8O4PpBexdC0ZmdTJULsRig/CBUmn
         ak8ktSnpprmOt+mRnNnPqQVq4gn4X7apdhOfCMtvmiz8dOTHQkqDsSVyku74HQ+snbLE
         0ENZinPE3/q63Hb5VQSTjnEquzfIREqgssAZq6Fq40LjYLiB91noqwXddvPcoqmXRyCr
         Jwxg==
X-Gm-Message-State: AOAM531KWUK1D8jTLOTbxFNYqscC8UpL263NPY0YJK9vs2I9eGPO+HIi
        1sM05lUfEe6HfOLPUNXrIOjODDKGjomqEQ==
X-Google-Smtp-Source: ABdhPJwbgV1FzjAwFSqcsRrAIggFjn2uhp68e/aKVaJt/w0FFokoyhreptthw26tZjvmWj/8eoyjSQ==
X-Received: by 2002:a17:90a:ec0b:: with SMTP id l11mr303206pjy.136.1598594897414;
        Thu, 27 Aug 2020 23:08:17 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id u14sm149783pfm.103.2020.08.27.23.08.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 23:08:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/8] cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Fri, 28 Aug 2020 11:37:46 +0530
Message-Id: <84dc113f3ada31c858481077d7b535af2765a084.1598594714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2: No changes.
---
 drivers/cpufreq/imx6q-cpufreq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef7b34c1fd2b..5bf5fc759881 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -48,7 +48,6 @@ static struct clk_bulk_data clks[] = {
 };
 
 static struct device *cpu_dev;
-static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int max_freq;
 static unsigned int transition_latency;
@@ -390,9 +389,6 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_reg;
 	}
 
-	/* Because we have added the OPPs here, we must free them */
-	free_opp = true;
-
 	if (of_machine_is_compatible("fsl,imx6ul") ||
 	    of_machine_is_compatible("fsl,imx6ull")) {
 		ret = imx6ul_opp_check_speed_grading(cpu_dev);
@@ -507,8 +503,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 free_freq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_opp:
-	if (free_opp)
-		dev_pm_opp_of_remove_table(cpu_dev);
+	dev_pm_opp_of_remove_table(cpu_dev);
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
@@ -528,8 +523,7 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
-	if (free_opp)
-		dev_pm_opp_of_remove_table(cpu_dev);
+	dev_pm_opp_of_remove_table(cpu_dev);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
-- 
2.25.0.rc1.19.g042ed3e048af

