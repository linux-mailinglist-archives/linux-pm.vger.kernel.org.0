Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498D624B709
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgHTKq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731888AbgHTKoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 06:44:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573EC061345
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so734068plb.12
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RX8jH7WYd4F2NVJ6VgmGb3ASYy7lGOBAgdZtCkqBvgg=;
        b=kdJLB6xvJRzMw7YX5ULxAs3uZEqeFAoojfyPwZGYu+aBdj6Ph7yQ0NOWZklMEqNtVg
         CAg5NoZLrksr02/KRsMQAlBdpxV7alLNPycJflXgUYlJ3YGYTSgE3Yt2sulqK6O3u74f
         0pPfT82L00RoAauHAovkXrF0UhOb7nt4XEsR3cCmZbPyRBk46P02Ih5tAQk4QMotcLEb
         FJLOVNuynnZvkkJZUNxNZnxweZRXDIxbcv6Mm61B6vWMhgvLjBUhFrjJI8wDk4tSxgFz
         Ze/Jy3wG4otR5A+kN/cKBR1hw2oMICfuKmcfrXw4vsmU5k4Pgd7BifURwVtXbU5lhD6R
         xfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX8jH7WYd4F2NVJ6VgmGb3ASYy7lGOBAgdZtCkqBvgg=;
        b=JKRnlGHCh7X3AkZwqfNTQW9ZX0GDQCTpruoaZS6Qs21DCYJGapWvjh//AFYATzzryi
         pDpap0i4t2SbpbwojluaCFT5gg/z6ckHW8zC+h8JL9fFAL2elz86XJkjXkZMtWnF4a0A
         mOI7LBitYHFcihYunEmbREQaCtM3iXUaf/4FsXrDiAP4R7m9YveqV/ZPBGuefoO0Cv9R
         WBfreelYifWXwLUv1y7rBu0VF3lC7z0qm8dBNvB6LX1PyrB5dzpJIdZ2m5xyx5kfjmcp
         nSxLknMKqh+b1emwBcvaN6g1PP1AyoWRoBwIbAomGuhGcE6VALBcX+SAROI6zVFGo84F
         i5Zw==
X-Gm-Message-State: AOAM5310NMQhUrgyhnHTxsJzi4XDut/RSn/1OHf7/2R+km0vCRqN/drx
        eUk5QrazividQ8tgIstzYSFBKw==
X-Google-Smtp-Source: ABdhPJwYvC+Z5ZdgGh31gUC2Q60ovUZ9XGSX4w1+f97jUslWlDxDur07VZVEPifi0eTRojgeMah0+g==
X-Received: by 2002:a17:902:ac84:: with SMTP id h4mr2112048plr.334.1597920258939;
        Thu, 20 Aug 2020 03:44:18 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id e125sm2435256pfh.69.2020.08.20.03.44.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:18 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:50 +0530
Message-Id: <d720fb56f6d526fda30d1a22931597f94f8cf5df.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
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

