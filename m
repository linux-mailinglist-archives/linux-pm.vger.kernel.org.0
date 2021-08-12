Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B23E9D90
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhHLEg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhHLEgV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:36:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77745C061799
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:35:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b7so5619659plh.7
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5B6LAGyn6qpvhvvXqvmp0F5nk8/QX8RYvQTVx1M0/gM=;
        b=QP4d91nKyPuYgkXOj2993WRqr7vFWjzAt2pAYEpOqBJrX79KK7X7Lye9RW33nVemOS
         glTh3230AbIEle58TNmDHg+mGlObfxcChEqEIgpM51UFcNuoT5t2gwEZYo9rstSe+BUh
         G8oAVPZc4Or2lHFxR9TnUcIaCZpTTeNW497UmbMV9rdrFsDQX3C4DbEyHzT9ETDcJuHH
         44M487nZNgj5a1TirMtTv5x8vkPi0ZRWgBVRFM/hm1MZ4gPWlnqSsL9XbuORZM21Fqvq
         2Kb9HOtRennF8T/9AvDxP+8H2lNL1JiYws1Z/YqfyQ//45J/2m8OCM9lP/bKaiSF0mx/
         SA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5B6LAGyn6qpvhvvXqvmp0F5nk8/QX8RYvQTVx1M0/gM=;
        b=ruXxMX9v9HBVdmDLQbAgG5ywRjg5MjnjZJXkQI3JwSBvZvZR4bvpP6AQkCBGrKBdX9
         cMvwE+kxwLPfBNtTqx85xjci6Zo3jAj7xDuTHWvacpD598bJ7B253ZXtN/tkxBsULkFW
         /D+WdkLjfwje1WXniRmT/LZ2inAFv+mQs/p2A5qGGsgGeYBq9DPWACX/0vszzCphMyKq
         1Sv11ig8R5sC4HcpZRxAxE7x9OaewnsZT9MTyAql1bhY68As2tUUtZF/3O/i++MJORH9
         y/addNczouj/jGb7Feilc/tR3ijydY2GmNtIxLE3zUOYTln0HfdZP7z/COv7I+qTtmrK
         kFgA==
X-Gm-Message-State: AOAM533sQzGHqUccQcBCc396KjS1zQ8ZVbJSPpiBxW+XVwbJI09BAVpv
        WQrvp9OjHzSJtaOMFnVVPlXWWjVZ4xK8Fg==
X-Google-Smtp-Source: ABdhPJywxltlmffoNhquAq7k75/erYD2KPWkiClGULINl/c/3BgHh8iADap4QiF3r0hcPTmn6BYUhg==
X-Received: by 2002:a17:902:bc41:b029:12d:3f9b:401e with SMTP id t1-20020a170902bc41b029012d3f9b401emr2042045plz.47.1628742957070;
        Wed, 11 Aug 2021 21:35:57 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v31sm1420379pgl.49.2021.08.11.21.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:35:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH V3 4/9] cpufreq: mediatek: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:17 +0530
Message-Id: <3701fd64a3fb947fc805ca0d108ab87562a9659b.1628742634.git.viresh.kumar@linaro.org>
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

