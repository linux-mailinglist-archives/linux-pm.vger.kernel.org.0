Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA26B7646
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCMLmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 07:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCMLl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 07:41:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B166423C
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 04:41:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y15so5786684lfa.7
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+k+reC4AwOd4vHClc4yefjsS0s41ZK6miu+3sYuwsE=;
        b=D+6o3R1C0cSJshMzbgjMBzugrRd02mjgMMfcRAKcnQWvZlip/dpYUvdrAwLYStgPJo
         fiZzOFkhkhPAlxBmzrAa9GmJCIlaxse4NnECdxF1x4Yr3UqS4R4nWdNmiPFmWmDdRxY/
         Df+eK9HgoGcaYxUT7CwXASV/f8O7XTz/pdgkKBAxrzBPktwfJxt40blD5azzyr7T/J61
         bc1Co7BLkUKxHPkYsXIXFFrBY2Prt1gmxJjr9eawzJrvCcWGLTzDVaGLSUmmJz/3hDkE
         Gczune8n299zuSUo6Ddj04cgXOovXbVOBcbvLb3KCfQBULipdHVGos6yEaQ3jShQtU7d
         x97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+k+reC4AwOd4vHClc4yefjsS0s41ZK6miu+3sYuwsE=;
        b=WrQJrB7VoMhIg7EKv3RPEOJJsdF1+a+kAaVsIoTOZos+dZqgP8Mr9Qb99KJFMl+8CI
         6XORPYJ6u5Hd64BBTHdlA4osflXG+ECZ6SUo3LUR/v8jmyk8qEXBuzJnK7s4HXkTaJYY
         /P0F+XN6SLIk8h0OmL4a4bXRR6NzfKXHtIngBzNfmFd6uz3Ld5PmAQePIk5mnl25rw20
         6fIKMtqfZxXfCyb04ieq15uqd+Xky5WjN9awi+AU99C8VYCoPqalYXa/fZrDGtEXRLzM
         T0JjWaOQ4QHy1VWiM3mPf5bZNFGkkhbTS13MEBrqZkJQHsPR8DZQNbnHDw7/KYQ6FNfc
         foVQ==
X-Gm-Message-State: AO0yUKVjfLFDnGQjPRMVQtHqPHS7rF8aqe+WrfzOihSBoixXh2H6ZTxP
        chKI7epiIuTArCEioqyw6xuxmuziFVjZEYLpSns=
X-Google-Smtp-Source: AK7set8JAuzg3+U4FmrY83xuBoNpWhJ8U0Eae2ii+jB7mOPeJtAPpZ1/jkLcsDPaWDwSEPde5egsUA==
X-Received: by 2002:a05:6512:204:b0:4db:a19:6dfe with SMTP id a4-20020a056512020400b004db0a196dfemr9171576lfo.26.1678707682378;
        Mon, 13 Mar 2023 04:41:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i2-20020ac25222000000b004d86808fd33sm948465lfl.15.2023.03.13.04.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 12:41:10 +0100
Subject: [PATCH v2 4/7] arm64: dts: qcom: sc7280: Use the correct BWMON
 fallback compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v2-4-04db989db059@linaro.org>
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678707675; l=775;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HQt/UEo0cCtLu7F+JcX1cFn0BClxhTD3AkZRLXFvT0U=;
 b=8GfFDsHT11QIGg4Lh93AuCcCvfDiE3d5GrUEo35sOOaBIOvDCiRTRVmEUHTptsgg9YFoj0wItyjZ
 b0Q39cQ1Bp8sVVQITi4tFc+DvQ/0+uwT5yCCU3tEU/gbcqROcQd7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the correct fallback compatible for the BWMONv4 with merged global and
monitor register spaces.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8f4ab6bd2886..f15fea6cc316 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3533,7 +3533,7 @@ opp-7 {
 		};
 
 		pmu@90b6400 {
-			compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
+			compatible = "qcom,sc7280-cpu-bwmon", "qcom,sdm845-bwmon";
 			reg = <0 0x090b6400 0 0x600>;
 
 			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.39.2

