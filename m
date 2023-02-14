Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E16695F78
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 10:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjBNJla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 04:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjBNJl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 04:41:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB99234F6
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:41:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mg23so7994071pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXF4aiObQqM4BGutqE03xyAKHDYTqvDe3hT1w9nB6Ds=;
        b=AsSOw48/eYWpAph8NDZwYZOMsIjVILQxvFf32tBBFv0vQWW5F0m1/zz2tQ/snxvLYg
         HTj/NLVWTFRuYFq2OXxCR8K6h9efKDEJp4HTk/O6ZqhqpNG/doLONgQ3Vv2Yu2pLLcdL
         iPFu1mc3RH+j8gsK8yYf0w9gime8G20HhWh2FFoIgosEpSJtGqWHSbKq7vZ/JirXCp5m
         zgoso9TBiYFsFitvi26QAhO+vKK14Dyf3Zd0fWm+eoX1fMwxWIDbLmvldFhgcXNWuZ8j
         kzbzEwU24Qz4SbpXpgBDG8+oMyPz+Y8FiUZ4EhDvQBnLV8RdD1ABWvq3XD8243mp7kBs
         uJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXF4aiObQqM4BGutqE03xyAKHDYTqvDe3hT1w9nB6Ds=;
        b=du5A8RpQVWsgvYyAW7UUWWvTMd6KUSeqkMu/iK/DHJvX/mrlNywNMMCtRmu0/uMWuI
         yHqWeDSSdDDzB+sTDHzryk89kP8fdG+dWU+EtLmTcHJlxy7VoMqi6HrVb/JbLu5rFCfN
         gQmjhRURywzJGHfp+aqof2GmriXN76l8Acr5gBavZxnPe4N/CnfCo/AVw5QbHFdBycwX
         YnIWEA+iVtfL6Cq+RHe4LErQHDLTyj+VOLO4fctuzuwJB89dRpV1FA1bx72Zo1Gu4smw
         lkwRlG6v2XkSGt6v/Rg3W5DrPl9LHaJ8wJtQ/3mKrC7Ob6GNCSsXxhL2WYdHtwUpwSXn
         Ytmg==
X-Gm-Message-State: AO0yUKXgmCzq8zbnH8eimHLLLRIxzrJKwrtjH2lPjtBKy0orCqcRckBJ
        yzlU2Wd6zucBt9r2rZvXFqxh
X-Google-Smtp-Source: AK7set85h3b9oZBx7uPbXQ1ArhLvE9ehWjcxIVvpsRGNyLH8cAD9a7UhnFPiII9FvN6e4cpW7SmNXQ==
X-Received: by 2002:a17:90b:3910:b0:230:fac8:d7e7 with SMTP id ob16-20020a17090b391000b00230fac8d7e7mr1810318pjb.2.1676367684465;
        Tue, 14 Feb 2023 01:41:24 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a5a4300b00233cde36909sm5095572pji.21.2023.02.14.01.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:41:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-hw: Add missing null pointer check
Date:   Tue, 14 Feb 2023 15:11:15 +0530
Message-Id: <20230214094115.23338-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

of_device_get_match_data() may return NULL, so add a check to prevent
potential null pointer dereference.

Issue reported by Qualcomm's internal static analysis tool.

Cc: stable@vger.kernel.org # v6.2
Fixes: 4f7961706c63 ("cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 340fed35e45d..6425c6b6e393 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -689,6 +689,8 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
+	if (!qcom_cpufreq.soc_data)
+		return -ENODEV;
 
 	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
 	if (!clk_data)
-- 
2.25.1

