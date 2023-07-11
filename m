Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DAD74EEFD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGKMeI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGKMeH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:34:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA7F1728
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:33:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso61669195e9.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078746; x=1691670746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaXHvKCxI7KxVS1KmSwJhdeP1kNsqjjvViQ53Us8p1Y=;
        b=EvTR3VJokIKJM+b0Kp0/7nqMC6tubRIxA95za/J3604hJdnio26SvzUkKcdNYvTPOx
         IcGKyZlBsjK3S7KOuMdTH3E6cAU5LKt/mM9fCApeQ1pNa0jxWKQkz7mgMbZfRQpDsrYD
         y9jUyCnEsOcS+IkL8z1EMrqvLbPEtVIh6Btd8n+eT3vdNEzUb0S/UXKPxSUT2DjaQDtX
         MPOtPz2K+Ui6CPgWKr7IYZ17FGiGb4k7LZkp/IjMVQOgAEizeyIieDMSvqfYCfdvbxpR
         67TkCJVelEnQ97k4aLciiFsFzT9nm/Tk2dsxjldfmZAxlp090/RzFaLiHebJd0EQm/VO
         eITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078746; x=1691670746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaXHvKCxI7KxVS1KmSwJhdeP1kNsqjjvViQ53Us8p1Y=;
        b=CJyZTMY/HzPjxpnNYTaxqO5tcdz7woOaJMhZ1FmsZqhDMj7bPHytIpgIsjtgfzWYRf
         yMa1x8Sd8hi8BpwW/HqzKJwRk4Jwe3qmkUe6GYT3+1b718l8DTCoeqg+wDMEwqthK8Hn
         NQw8TsK6EQZqXKFw6vlbAEWbemKk1Xx7MNvoG3G+0KYDvtEFevmL97TZOOHqAD4iuLxF
         8Yc2exRojs+lTfsyWp8NySAWSqSPx0Qg90WyxyDSEGwbM87iGAzrql6jL9HPinqGpWcT
         c8DGDS1nQjF8aR3kSP6yoDqSCFUOrzVKr0kTuWl8OMQ3mA4rvmGmHU1jDd4EFt0fCYX3
         XsbA==
X-Gm-Message-State: ABy/qLZs1U+i95D8DYKadqqhu9jnPm4RBpLcK+jccj5Y7Aui+rNXL9zp
        yCAdbff4Glc9OF3l3ccN8RzEEaVpR8Kmsl77p4+LJw==
X-Google-Smtp-Source: APBJJlF/Un+4BrkKuR/dQAlc7XT7zlceCutSzyx8Jl8oQZGTFTrVsq9POqO6fXg5OIxvXghJ/47yww==
X-Received: by 2002:a2e:95ce:0:b0:2b6:ad79:a4fb with SMTP id y14-20020a2e95ce000000b002b6ad79a4fbmr2655685ljh.1.1689077969500;
        Tue, 11 Jul 2023 05:19:29 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:47 +0200
Subject: [PATCH 48/53] arm64: dts: qcom: sdx55: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-48-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=655;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GVqmsSMX0fxTkDbnjbH1iljfmht9W+hSLX9r25Tevic=;
 b=N2eLJQMNYylLqqzdwgHQFGEzhpfNvaREkV3iEByCL6wCEZDNiZPaLzavwd1ss+OBo43FniXsU
 RRR1dXkYRonD06UpBTkLnP8XTQEYWZWmKVNEQ4fmb2GknWU1iYc98KI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 55ce87b75253..35519e018ab2 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -866,6 +866,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 	};

-- 
2.41.0

