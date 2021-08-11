Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACE3E9015
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhHKMG7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbhHKMGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:06:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A18C0613D3
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so2376312plr.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ofSxGdnm5bQgO5ybUPtJlTPnLp/1dUTraYQIc2Dj88=;
        b=iwTOkiC/FXUeP1MLxGDlrpK1q06mt4TyUQNlfCjlir/zVNQVwmC8IyZx1okkLu9f/j
         606hr/6LLIzeQjXQ+gfVkmRvwMz4YDiy+OMpHXFxUDReYSC1TvYUeK1zgTx7cyIWKHya
         55Hv68e/543vCLaQpFrJNuOrjoAA/GphQd9g/FJuN5c6ngePB3XNSNhm58UFR2n1TjSU
         wPjXtCe5Lul1gMnoDsBOUUEHlYqDovYwMAbip1yoSpdkQ25r3e6hx7qrzJW4Ha4SR3+k
         y3evmJrMv5CVxHCDUXDyKcPKiojH6Fdp7VMRO0Tn8B8g27ZozDaQysQZ8T2urFOcaeHW
         y2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ofSxGdnm5bQgO5ybUPtJlTPnLp/1dUTraYQIc2Dj88=;
        b=Eh3rr2hdFg9fB0uP/TWK3Zrf+9dehqQ4JbqAn6S7KOTWKNhjWVaVQ7RJ8lIFZZvGmb
         3I2rDN9/wlyNSTpebuNbW/KUIJeVCz6lP6MlcaaCJfjnlT7fODWVmtLD3DW9afXQ+dka
         pI5Ou4K39p012Crk4GqtAJYbLiFcpReNUrpsXpmKlfYfgI62nj+SV6lmtcmra3LVyZAB
         C8fa6bmxf9SBlQnN1MZR2L1NugkjHRaElcBmXl/W/oXb/GB62ggydZx8IOm81BmCE5At
         m+rxBjCk02DaJ9DtQaAczaJ3XJFoQTiD/bIjWj2lRvXSX7HIyS42W+bObP6660IwEXqV
         eiCg==
X-Gm-Message-State: AOAM531cuJkAgZe+NgI8W2ffba9LCbZ023ZgeFW4V5jvX7CWpTVKNaoR
        973KlqGggv9hgQAhFFXcjIJGWg==
X-Google-Smtp-Source: ABdhPJzZNCarUQb+wmgvHCqQuBebizl22BB5vB7L87pka2ErubXU+XPnoyKImVLRbKOai4WDMxq6rA==
X-Received: by 2002:a17:90a:ff94:: with SMTP id hf20mr20868931pjb.64.1628683584303;
        Wed, 11 Aug 2021 05:06:24 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id x19sm28203832pfa.104.2021.08.11.05.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/9] cpufreq: imx6q: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:41 +0530
Message-Id: <69cd4b06c671fabf828c853a7dd6ea6225357d42.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628682874.git.viresh.kumar@linaro.org>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to automatically register with the EM
core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 5bf5fc759881..90beb26ed34e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -192,7 +192,6 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	policy->clk = clks[ARM].clk;
 	cpufreq_generic_init(policy, freq_table, transition_latency);
 	policy->suspend_freq = max_freq;
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
 	return 0;
 }
@@ -204,6 +203,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
 	.init = imx6q_cpufreq_init,
+	.register_em = cpufreq_register_em_with_opp,
 	.name = "imx6q-cpufreq",
 	.attr = cpufreq_generic_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.31.1.272.g89b43f80a514

