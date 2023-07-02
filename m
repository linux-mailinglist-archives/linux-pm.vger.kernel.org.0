Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB2744F56
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGBRuw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBRuw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:50:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34CE6C
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:50:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so5612567e87.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688320248; x=1690912248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njCJmlbSIeB3iLgzCjXAUGSkcFcm0Wzmp2XKu6LQ3g4=;
        b=ssG7/m80HLcUtzN1Tp8sf8cWXOe8MEJXLIi4oxSezPkJSudJCvDjF/iosLzHuIpJjh
         Mnyh+TxoYYdGlxwWrKErzgisnI/UMEo3BaZdq+qjL/Z60/voNmMirPCr6atuWj8I5kye
         fgKs/+SK8eTchJAXlyQp4x985BuSAb4jfS8v0pxbvT5hnmorTGHOCT86elBvIOmloi/W
         dXS5fDdITV6ExL3/k2LwgJuqu6dGfTPri5EYb+M+s5rR14Fu5dF+7sOPZptI4Ch7xtYI
         3An7LkVTxHd2tvG/5BRhFzCCKReqxuIYbu4llyrl7tnNa0mdlg7r8g5l6sV1x6yD5GNW
         hbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688320248; x=1690912248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njCJmlbSIeB3iLgzCjXAUGSkcFcm0Wzmp2XKu6LQ3g4=;
        b=BBjdTVHGtPvwHI/GMs8vPYycdZ8WwlQN8EHnh91+b6ftyBaK5V624Wb7O4Ic5BK615
         BKxX4lhed8Sfbf2asI8sYFjsHo7Cpe0mHrxaIZbk5nlQ/6AGqxIC0gcv0E7BurZvhLLj
         UbkfMBO3GUXB1XpdIp02LMLyr0e6v6wr39vBmGRhZUMu1ci+0hZtrac17p3R0xkXJ5F5
         L/5nqZ06dwDkHLyyLlsO4SKBcayp5Fbrk8FLDe8sMAhJ3X/jGGZnmR07Byh5hBaaaEIN
         gIxSUTK0Ft4MVx5klonrr9upa7yawQ8e446OLLqoKhE4M4123Ez1aiQ0usbGZvOpiKYH
         eaxg==
X-Gm-Message-State: ABy/qLbcgJX1D07loIYlUg3IOtPUHIkpmp4d6wMMVZ1Mf4a9rUtc6+pp
        JA8ro8crZkQcXdfYxcdVEJWpNg==
X-Google-Smtp-Source: APBJJlFId1IOZctJQ1PTPLk4Ird+SgEb9UvsJMTQSH7UqV6if0h47PhvKg0F4NMxVXrij5LPMbKCiw==
X-Received: by 2002:a05:6512:34c8:b0:4fb:85ad:b6e2 with SMTP id w8-20020a05651234c800b004fb85adb6e2mr5110913lfr.50.1688320248082;
        Sun, 02 Jul 2023 10:50:48 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d1-20020ac24c81000000b004fb759964a9sm3354130lfl.168.2023.07.02.10.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:50:47 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [RFC PATCH 2/8] cpufreq: qcom-nvmem: enable core voltage scaling for MSM8960
Date:   Sun,  2 Jul 2023 20:50:39 +0300
Message-Id: <20230702175045.122041-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
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

Reuse APQ8064 config for MSM8960 to enable core voltage scaling.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 422fd8ca8a00..113f35668048 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -410,7 +410,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,apq8064", .data = &match_data_apq8064 },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
-	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
+	{ .compatible = "qcom,msm8960", .data = &match_data_apq8064 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
-- 
2.39.2

