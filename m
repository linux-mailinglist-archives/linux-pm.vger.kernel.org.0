Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0733E9D8E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhHLEgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhHLEgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:36:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA875C0613D3
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:35:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso8686489pjy.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAdryzVWDItJYYyaDLA7TehMKmxc7AbVJUX+CfkiRLM=;
        b=xzANoon5SbQWRFGC1BUPcxuFt4rcYZc8/rPCpYUjdCqey0034wFpO6mH6LFYSEQvVw
         2nxj3THpCJA9kO5visFyu0mNL/9jkIuuPPeveXEv89LFPKOeCUuYSeVr8aXD1aX8X/QF
         rKU17iP/WdMU+QYu8OaNypVR6mGiZdu/WjazUaCM+rhTWa3sq5BWK1ljtVWIB60NYXwl
         rcIzGW+1/IoEaw0ZnCkWrPG9RQPm5bJR0fp/2VJ8Br8bpi+zrPG23NvlXOMqcezp3AfZ
         XS4DasrPso/XizZc3lRn9FPzcJwvOxedKzWzqV8tey/IS9cTyqwSBhl09rQfG7MvLBf0
         YPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAdryzVWDItJYYyaDLA7TehMKmxc7AbVJUX+CfkiRLM=;
        b=YRY7jJqqqj+6HGW07PTrOyXAdVpmDaXigKrhfywfSt+p3+IuMZwmsoVvPs7HHdRk+8
         Q+YDnvrGf4uWwlea9QMl/YaBDZl07jNPA8N8rMNhcqp09eG+Mj2YQsw6DNtMRdVMaH6c
         rfAO6tMtP0WaQGVWgmrt4akPLT8N2DVHoraRhFokRfiMwphYDJX0LWTg/eM11Caz/W2T
         bECDd8WFOhSCAtS790PPM5/KgfNK+lvKKcA4aqh6Frtc2YPZJeLCrpWzQpzqaeUVjGV6
         AEd66FVjrpHTGIEeZCcDiyLlsy9ENtWc9u+7i+Uk/uRBGGLT8QeBljtMzbH6Z1tR3vF5
         fGiA==
X-Gm-Message-State: AOAM53375Ml5yLz2C9y5iPs6WteQNwrpz0yeu1XXpfPQA79QqH2e4qjc
        p1qsFVJJvO/HTpodfzxXsiyqWQ==
X-Google-Smtp-Source: ABdhPJy2AbrBOUm7YSLqdS9F+padZ3/Kqb30z/4DNK85cIGfcg4uF6WfM2R4KPJNix9Qjy6EOWSz3Q==
X-Received: by 2002:a62:3082:0:b029:3cb:52bd:c0ab with SMTP id w124-20020a6230820000b02903cb52bdc0abmr2310147pfw.56.1628742954426;
        Wed, 11 Aug 2021 21:35:54 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id q1sm1377480pfn.6.2021.08.11.21.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:35:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/9] cpufreq: imx6q: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:16 +0530
Message-Id: <fcd300c685d5152e76a811c492b0e6eccde29717.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to register with the EM core.

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

