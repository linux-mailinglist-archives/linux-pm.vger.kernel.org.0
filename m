Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD45600F0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiF2NDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiF2NDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 09:03:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A2E017
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 06:03:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1123605wmr.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07gCvC2bDldwfU3PIuJqaF8MAJ6sayZEsNcAcstdbkA=;
        b=w55VpGFTkA3/pkKMVTCgcz7crZHIYE9dBkkVarqWRGB8AXnw2GccaKIiDHd6GX8veJ
         gwGZmeCvRuNG/rsdfyL3AhJBAfE9TNBOK12Nwosmjak6M5/XQxR0l1wFYVNFl4QOrBZV
         FM9Pvb1nxR6HruJDjABnirpbaXmC4dBlv56A8Xba7W6VLn7GOXb7fIRuArmZ5k2o1ybB
         sAxNhQXf3nT2s/2FJo/IzPWVyLWxDEZQW1KaRYY/XZx5q2GXrw83j180Ia0/hYXuDiRR
         aurEvt6YBfpnHhglxgO4ey+9QIe7uzCp3Kwzq/YBcR0S/Q5HEmSK7K5GxSQ9WIFpF28D
         Q8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07gCvC2bDldwfU3PIuJqaF8MAJ6sayZEsNcAcstdbkA=;
        b=rsK9YMjKGoj7f6nYq0yeKJ+QQKrEiwJYFtExSny3OiF7/SCcMdl4//qxYR+ymmvppJ
         VLJcvtdbink7QuixoszpgnYtW2hm3+gq1oqT9mJDmzAX0WrcH5+CFAkaUxxe9BH3jbQZ
         xGxtGtXNcxBhAsg7Q7QnlsAbdT2yeIHziFxcgXb5XG1AIETD0d+M0EtiJP0MzNuH5rkM
         5b4iKqr3hyz3c1vXnYSG5sY+3aof/vWfFmJ/taRPrVZISYxjaf4mKKVFbwLcN2BHwrDL
         rUFGcJ2S91zTRCJODuTfCwItlIN+aS8BoVC4jQBueN1ySmVWfLQrgNbnbRfzyPwJxBrP
         FAIw==
X-Gm-Message-State: AJIora8NxBcu5gm6fznvEklL7TDWd+3nSGXNa+qB5QI9TUc80sJQpNIC
        ZW1D/QYh4s2OW27VLmii+pTnzw==
X-Google-Smtp-Source: AGRyM1tdK7Di+7eAr0stiNBdznQa5qJ+GaDNLzwwt+Lt8qEteCU+2sPLEP11PbsG/WI49JQ3RYwrtA==
X-Received: by 2002:a05:600c:35ce:b0:39c:7dc2:aec0 with SMTP id r14-20020a05600c35ce00b0039c7dc2aec0mr3621071wmq.33.1656507791387;
        Wed, 29 Jun 2022 06:03:11 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b00213ba3384aesm17056979wrr.35.2022.06.29.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:03:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH 5/5] cpufreq: qcom-cpufreq-nvmem: Add msm8939 as cpr_genpd
Date:   Wed, 29 Jun 2022 14:03:03 +0100
Message-Id: <20220629130303.3288306-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
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

Add in msm8939 as a CPR genpd cpufreq SoC.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 355c8b99e974a..63cbb6b57e64b 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -453,6 +453,7 @@ static struct platform_driver qcom_cpufreq_driver = {
 
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
+	{ .compatible = "qcom,msm8939", .data = &match_data_cpr_genpd },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_cpr_genpd },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
-- 
2.36.1

