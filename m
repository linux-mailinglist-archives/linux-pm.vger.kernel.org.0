Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0013765C4D9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbjACRNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 12:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbjACRMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 12:12:32 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF713DFB
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 09:11:34 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 1so46507166lfz.4
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 09:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JccoZqih8NMDPLuOB1vR7eQ4lQc1zHRGNfhVSrbaXuQ=;
        b=W9R/zXmKj0eqmBefLvFQsInxzB1tdZyecZS2wdZfLCjQxcaXXA66oiFvieZA/R0HEo
         1rY+4BFkSIb34JH33MPv0FjUdz+wEVPss7YnDTkTKBPvS38JXXI+v7ggQLpwborIOmNe
         Kvd9Vsr74tR112gL3nDbnkyphKKHTYR1QmTED5y2rW6XidTUBu5D+/gsDsZLhKEA3BP8
         jeTxnd0iNUPvgzqj9gskcg/sFgzYbc5K8GeFSqiciESEdBxzy03ld/JVQPu1nXlIm7W5
         bDeO9oj3Mcd6sb5NWvR6Jcr5wtCmPaeQP4BWJz7+LbiZjSbaws+jMUNJXc7Zx6OZgNaA
         LSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JccoZqih8NMDPLuOB1vR7eQ4lQc1zHRGNfhVSrbaXuQ=;
        b=8GLoOfZzAsygvjRdbXOkC/bpLFvSpptWVvvzdbGJ1LqdBUmSFNxFYIUeteqRqeDkMc
         l3KsiXwF4CTKMIXpNidkj9NlWFPYLRJxl6+cCXNh6TqW+uqFT+/DZPrzt7o8JSUUGeJl
         ZXGvdiONFwaBx5Y9UW5n7CXQtLul7kDfJ97D2KiO4k3pD5aQoXvXrzqsx6FEpl4VXlzn
         6p+GxwQ+qOVy/MSpGgnE9xYKE8l18NlYkoq58W8DoSx4CZ+0z9twlLAG58UcBDjkb36w
         tFGrcnxkr3Ulc2sArew6PTpzwA4Ms4EY+mEzgGtEE8SIbtfn8T8jDx5TTLzkU0x1vF5D
         xlJw==
X-Gm-Message-State: AFqh2krWCtU1ImjZwywLCmIhYAmc1ORsGb/Tw8tPEmnMKdTxN1uyirNF
        U4N3+5pE0pn8GN0U271ZZq334Q==
X-Google-Smtp-Source: AMrXdXv6Y0gRiCny+Y/ci6XfffadRMEqeydwbmZ5pksP3Cc3L0y8Xfkxe+h7RH3CXtp761AOKvYkWA==
X-Received: by 2002:a05:6512:b19:b0:4ca:eebd:3bd2 with SMTP id w25-20020a0565120b1900b004caeebd3bd2mr13035509lfu.45.1672765892471;
        Tue, 03 Jan 2023 09:11:32 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id by17-20020a05651c1a1100b0027ffd0ec180sm249511ljb.55.2023.01.03.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:11:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Add SM6375 to cpufreq-dt-platdev blocklist
Date:   Tue,  3 Jan 2023 18:11:29 +0100
Message-Id: <20230103171129.191193-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM6375 platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 8ab672883043..1a7b2420e735 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -150,6 +150,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sm6115", },
 	{ .compatible = "qcom,sm6350", },
+	{ .compatible = "qcom,sm6375", },
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
 	{ .compatible = "qcom,sm8350", },
-- 
2.39.0

