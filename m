Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE73E5466
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhHJHhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhHJHhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 03:37:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93EEC061796
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l11so8182795plk.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+OKnXMPuWjj4W4bJLq3zK2g9mX6oy/b+uBVNWEhoHA=;
        b=tDJZDgwt6Zksre0+Hb84Oaba+GoGOFFnBNTSeFFbIxWMY/kmyer6CIsG5m8Gy1g4kk
         ZPUAYeVRYBtzn0FBsxM4HhlemFAWLIb56qQo4pQnz6c5f7xENOK6is2MpgB5M1+OBV+S
         9Zm/29cSjLdXxi+vsEPSUIH6KgUXgXJsq0AylkYvvSZhObcjRBgiojCe/7Sj210pOp80
         B+rZ+ivfcTLYlFni4Hj2lO6nKUPI0+ITlM7b3vSLzNp2txKbP/hwxM67bbsz45XYtwBD
         0fFIr55WXt/JEs1cPOIdCNfXMztD8eqHJaqaBeHvwiddMhcl6kMq2iyk2VxenpTkoJfB
         SiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+OKnXMPuWjj4W4bJLq3zK2g9mX6oy/b+uBVNWEhoHA=;
        b=hRWc78nMIkGwR2+wtSFDuRrYsu/I7pmf7ibLw30jsDrnzvWm3g7wB1BmhD++1uZO+A
         89EdNKxh3BgDzBYCSHXUTibDWa+xDGgX8TAnsVuSv/XhEFrzE9Q6VZ3BOCJyVH+D1hqd
         oLrp+72LUQ9vlE+Y6TJyqIxWytl3wMvG8tR897CaDYquch0nFYcvbeyvE7/QGRN/s79E
         2WGVrBLTBL7hjk4XGHKCquIFed3z8lPHhEae7/I0bjRt8x9FtIcWTEuxzCs+icDXouTj
         KOGS0YqFp03/MnPPmFs0aVkp2uG6txLeJPJcmmsvTCgxHaHXtV2Cwhnw2J8hKdGgha8T
         GeoQ==
X-Gm-Message-State: AOAM533fuyyivTJ9+8yhkARKCm6g88jIct5SDjIf5sG4qpX6JNrno0/Y
        RKAj+r0kJXMNUaHsxYuzFnXXag==
X-Google-Smtp-Source: ABdhPJxsNfQtKMmDJCqfKBGePJ4HXpw4jtllLvQqCujxTBROh6Vo5ApG0dxLBFcfmn+AeKmqFYOShg==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr8527pgr.411.1628581037290;
        Tue, 10 Aug 2021 00:37:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id d9sm21546884pfv.161.2021.08.10.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] cpufreq: imx6q: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:50 +0530
Message-Id: <ba662b10e043e7734eb9d9e9bbc4c75afab9c2a4.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628579170.git.viresh.kumar@linaro.org>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
automatically register with the energy model.

This allows removal of boiler plate code from the driver and fixes the
unregistration part as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 5bf5fc759881..aa8df5b468d7 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -192,14 +192,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	policy->clk = clks[ARM].clk;
 	cpufreq_generic_init(policy, freq_table, transition_latency);
 	policy->suspend_freq = max_freq;
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
 	return 0;
 }
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_IS_COOLING_DEV,
+		 CPUFREQ_IS_COOLING_DEV |
+		 CPUFREQ_REGISTER_WITH_EM,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
-- 
2.31.1.272.g89b43f80a514

