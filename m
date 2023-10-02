Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FFA7B5AC1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbjJBS7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbjJBS7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:59:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BFAC
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 11:59:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50308217223so30577e87.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273186; x=1696877986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETmrOyXpzkFbupwItSkBNFCMqm+cnfW5vWqiMF83MgM=;
        b=KXDx19e3//Y8kt0JJre+F6jhUk0ruqw4A3TRW2+76Yj/+X9CHgG8eeu6/CsIgqTn6E
         NaCzrD0egxBynwKreHodsfqeg6Anra8B/pyd46VJwXi2zEEfW98lDBGbATy+Mq8LHEze
         kJaiFRa793vc2BsITA77TNfunGvnskZE/UrOIPlE2zZ+PE3O5gUCB9fe0RDJebclKG0r
         ZC6v+x1tR8q/TjPUYf/9c7gFPZyQNKM03y6NMM5lxND/gEFLM1aMOUewnr7u4EqfLVT6
         iLtKMQiIoZQVYP+ky6DL7rBFMTkcxjBgnrlbVYi7hd5+ZdWqj/ZalPClaOwrO70YHT4S
         lRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273186; x=1696877986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETmrOyXpzkFbupwItSkBNFCMqm+cnfW5vWqiMF83MgM=;
        b=i9ztI6Ztj6K9PeRb2G8VrAxGrTwmOGuMJ6pcRXWWqmXx7+TJG/A0wUfoKwLxlgwldk
         NOnpaiyAQRex00lSHUbfnhHS/Zp0a8mk+D7tXcxos3mz/GS3FyeyG3ormaU8srt7YNTb
         Uy9ylwkT9HwoOiYjRq3mg1ULChIZJTIFNNZl/B1WQpRpsohHreXfxlXLITug/eIo+/KO
         gAWvwlOJVZoj0Li+cbrcFWl4MU2PKsRqzYooV6fm1tzSHwH4JjRdSIPyUm750j4Rq/+J
         WfsyIGWtSeh60c3GGd/hqS5vPe2zuGhPM/X5PWF72SujodE7ZpsBQZNDuqE6PmVhSMQE
         8E7g==
X-Gm-Message-State: AOJu0YzETfU6P1ly/1FcrnrcMUoyuF14BUOT37BUuX7Pfl233nfcPQUv
        UHrE/2q2en/FY7CCCtJSQ+5qkg==
X-Google-Smtp-Source: AGHT+IGoo4epBUciQRmMmhHMfybHxLIJNCItcKoPirP6vC0ZxB9+PFXBJdN8BkE3vJgSJ2vYEEuuPA==
X-Received: by 2002:a19:8c47:0:b0:500:9524:f733 with SMTP id i7-20020a198c47000000b005009524f733mr9981048lfj.20.1696273186047;
        Mon, 02 Oct 2023 11:59:46 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00502d7365e8fsm2443981lfc.137.2023.10.02.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:59:45 -0700 (PDT)
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
Subject: [PATCH v5 6/6] cpufreq: qcom-nvmem: enable core voltage scaling for MSM8960
Date:   Mon,  2 Oct 2023 21:59:40 +0300
Message-Id: <20231002185940.1271800-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
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

Reuse APQ8064 config for MSM8960 to enable core voltage scaling.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index e1cf677b0c6f..6b54a674e9ea 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -408,7 +408,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
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

