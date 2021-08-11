Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F13E9016
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhHKMHA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbhHKMG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:06:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219EC06179C
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n12so1747311plf.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ufaB+OMXdYU7j7TBo3XtAZpCHOejyA+3wA93Op1lzU=;
        b=t8lLzjPFZAWIYgTJOrFd2HG+scMTfIhGn3oErjtmiM//ccrcySFz8JOOZKulU+EiNL
         OXO+8zbdgMhoqwmYzFPpIQvy4NwR+3xGy5J0bpgHy4m6WaA+Vf+QrgkpMTwpC5PcNtPD
         +3lIVvpcRqaoz4+sOPxLsf88Wq0iRFXBDSECTlXfjDnmdjovXDpk2WgY//lc1NDMlyiD
         OH+cO8WaQ/hiuH1bJmO6CiXIanr5Wlii23Zg8EHPNS8qNTCNeQvGb7mbutXNddc+MLFl
         bh2hLW7kZP4owycILCEv6xAz8aM45z9ROAHxGDHqSi3Dwf27fyvzFcDHRtXM4FVUR9Kw
         QHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ufaB+OMXdYU7j7TBo3XtAZpCHOejyA+3wA93Op1lzU=;
        b=bMZo9zfCTBoAFbNz5gkJQg1ju7627zb20OAi71OdJOsXaIvUiSPQVl9GGFC24wzKxD
         pzMnSwrzzp88J0CYlWsB7+tG2U2P8Vo9NzISnMPayvmMlkUU+rPgTfUtsBniuPrCHlGs
         Hxp+dIW1dbGuMS6tE0dMFKT3m0dYpdZaTuBS7DSF9xbdAkBh72a9S4eC5PkKQJVn+k7p
         MQmxFwOEyALBOoA5kUN8x47+ny50aUiUCPLUlJIo76LfKSf2bcJ63MkZrkTkg7U8dxp0
         ey1hH32qZDOJMPj9p6fxcN2k2FwhPAaQ4J1yZRrukMaYWN31mluOpyPJwh7P1Wd+VQS/
         E4Ww==
X-Gm-Message-State: AOAM530YC5H89AftXHdQDXgFWkWC+GWosr5qcjgraC6w6OYXiqvm64v+
        wnRmWrJwFI8K1ZU7eFjHpKTp0A==
X-Google-Smtp-Source: ABdhPJwMwN2fm97TlkXuwYPxuFuL4cxb2WPXC0Be7ZXZT7ga2QkHLotZZsNvgbZMaOm1uLqj8hwR+w==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr562898pgl.198.1628683587396;
        Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j22sm31239903pgb.62.2021.08.11.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH V2 4/9] cpufreq: mediatek: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:42 +0530
Message-Id: <c643714aa4e525aea4d54c2fd35950c046555621.1628682874.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/mediatek-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 87019d5a9547..866163883b48 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -448,8 +448,6 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
-	dev_pm_opp_of_register_em(info->cpu_dev, policy->cpus);
-
 	return 0;
 }
 
@@ -471,6 +469,7 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
+	.register_em = cpufreq_register_em_with_opp,
 	.name = "mtk-cpufreq",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.31.1.272.g89b43f80a514

