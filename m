Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06874EE9D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjGKMWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjGKMVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:21:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECFB1BF5
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b700e85950so85741221fa.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077967; x=1691669967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4NULi+Pg3BzaFa9S+uijdnxcMxII5T4dtt9x/IhMZ8=;
        b=W51lFjiu6a9R1/lJNF1ZBGOFoMD7fqaxsfek7DTQrhsBd504k/wpfWeVhedCDuV2aI
         qIxxz5nCWhOd8mTqmZrpv/Yd7mbKAqG+f8kVW+3TkWle7RF+57hvdoVVE5tId+4wstBT
         KKnQEOgkzR61RmsOJuGAkWRBj1zdJqK9sISHGMpRm0IeQNADDnNxEVdl9Z6XNvfyXGP5
         u9jzlOWga5t1c+XMXnT8J2s0ZAR/yMWWmyWIw12hqDou+Prc4Z/7UIW8osFTMJkpP0YI
         +749AH9e7aGwn2DRqPmbsJ9c4x9ofeqpzMfyhiO7eAxgMJPRUFttJS6QiSXl6sgtAb7H
         WdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077967; x=1691669967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4NULi+Pg3BzaFa9S+uijdnxcMxII5T4dtt9x/IhMZ8=;
        b=biAi5aIGTy1iIE3ud6/CqJ14MH88w+mZgrhdfIfw7wyUGEG1UmW9vkG9H21tW7g/xy
         7bVkwuVba7xCoKEwKxCCTm8JzcF8F4d7+/nyhOJJ5Pn8nVP35PcFre77C9c+PX+rtUQ1
         Rk+M1CT1b6VSghCmDaB2qebZMhHqOEd4iD7le0O8iVOJmjmFv91LWaf+yAHb5DfeGbtx
         jkN2noKjq11JP5bwy+ELbYYeiWFBtx0zbMkjoM+uldjfczQ2g+bthIKCT/CH6E5nWRfy
         YK7Q25PaPpuSPPeUoKiqXxhASKr4aD9D0XcSdgLvyk1c7Yj3zf7TgBd3h/jBhS3B5lxs
         YPow==
X-Gm-Message-State: ABy/qLZPzED+icI+lDoxO0dJ6tqdSZirDz2ipA3N87TEmeqRFDnHrKVv
        r/l4BJkoJroqv5d6vo7OCshO4g==
X-Google-Smtp-Source: APBJJlG9xsUvTuE03igdC3Ho1c17TBaguMFId7SIKc7FOSZ2/1jZ/jWeJIIt+HonBcxtInnXGwgTqQ==
X-Received: by 2002:a2e:7215:0:b0:2b6:efc7:2aee with SMTP id n21-20020a2e7215000000b002b6efc72aeemr12050313ljc.51.1689077967029;
        Tue, 11 Jul 2023 05:19:27 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:45 +0200
Subject: [PATCH 46/53] arm64: dts: qcom: sm8450: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-46-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1005;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SQpHj4TfmA+4UsCzDDjRNhiu3Ox+vTnH5LdKeWnrUM4=;
 b=5TQbA1R0ncEPLIqSN9iQ3lNCQ1W1zper+KD3P7WyAqNmnUuh156FuhAQ4i0R2vj4WhJnt0hdW
 1FI94sDsjs4CxRHVepToXuIcyfT1PtDipM1ijKn6MOvhS5so+AWerUl
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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1668d97ce459..9c9645809af7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -4008,6 +4009,7 @@ apps_rsc: rsc@17a00000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

