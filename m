Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8319E74EF13
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGKMh3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGKMh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:37:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCFD1702
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:37:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so732813466b.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078976; x=1691670976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQLBnYw5pfVzQylFNgskr7H7oEW4uSiPIu84jcjkQCk=;
        b=D6JObIJ+KRtWil+qp/lKlqe8Z91J+AyR1cc8itwP4EhBV+KGCa1dCqaofCCrGkRR/r
         CFyQmQszKM9wtww/Ju8Vj/N0FkmvikTb8WOhPaVdWwweKEf6PzY5qPEyY0w2yYspjygB
         fn9Ej9oZGt22rSmr+1G4DbiheDglVXFW/VBNduzpn4PO6pwl3ZHE4YZzh4NlhK0o/qkt
         l0ZaIA2SXXI6WvfQDOZB+ffkQZIuCpyKrgiuK+Jy+qYMSMcuEWEK3HOonsNAyjCihg1c
         gb419lAwbVp0q4z9igpVlwpe/TnOl57wHJFzqiw2H28Oj1SYsMn/+F8zLsNaXovio23K
         tSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078976; x=1691670976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQLBnYw5pfVzQylFNgskr7H7oEW4uSiPIu84jcjkQCk=;
        b=F+/Zh+y4Nn/1imCslZOwdN+F+CaPaVS6pKm7gFOSBm8NeAnU1uiyOgg8TEHza2RRMK
         JklbbgReiB4P6I2Vs5W/ZZx/gy+h1WL9v7/EWsvDHq8dgMsmHw61fcVMrAFxziIjTNt/
         wQ5Bajn31TnOSUghIGZGLUhn4YSH5dxp4xND2aL1N6T82Shq5c9hPadKOK10acNJUNof
         y8AMh8HOij1tamvbB/AYndAHFmOfwDu1/AeRjE/bt69Vp2u5a5soxLztR4wioAurutT7
         G8K2TfxNW6CpSzFlJAPLDmYw7bqRumkh8mODQQDEPaTYjwwNDC3elfPsDV9Ge7nsYXx7
         AR1A==
X-Gm-Message-State: ABy/qLZVqemFqa84FfzeZMAdKj8ECOsRfMpIPYsgJfMQBQKtVY8aBwWq
        jL0keYkxhtqERDYJ5TlS1Dk0YCDGy+xmTdJEtnrP8Q==
X-Google-Smtp-Source: APBJJlH5jgTV6clHkuAbdLyaxwSZbX0NQWlWbozqxx3ivhQVSBF6LhXWQmS5O3CgizbKk35ErOwtyA==
X-Received: by 2002:a2e:6a04:0:b0:2b7:14d4:ce6d with SMTP id f4-20020a2e6a04000000b002b714d4ce6dmr7721930ljc.48.1689077968298;
        Tue, 11 Jul 2023 05:19:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:46 +0200
Subject: [PATCH 47/53] arm64: dts: qcom: sm8550: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-47-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2n73VwmB8gd6z5jxJWL0kWv1/JV05PWG3zpj6M//Tvs=;
 b=6cAucdktEPv499aSOqbmljlM2KKvs2eSJ07hrXrAq/GVNAj6ilgikTUSIcX93dYozWDDDBb7g
 UwYMsvaySf6AKgM7Tyt09TTWQN7rdv3hVkop9AW3R7L1dPXgX0KPAkN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e8aba256931..d54b0ac6d0a3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -3714,6 +3715,7 @@ apps_rsc: rsc@17a00000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

