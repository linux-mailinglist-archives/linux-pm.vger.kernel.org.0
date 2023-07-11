Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3674EE76
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjGKMVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjGKMVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:21:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2610F6
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so9034774e87.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077953; x=1691669953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUYkKYV4ujMuk/ZAzUO3GhIfjlSDACYKMYMpvbHOS0o=;
        b=OgunhkVOF31gy38IhMYvZho9KhSZ47S9iBORV+B36TBHEI1JAGoOya2CnSx0xvAq5v
         liYYiSZKkzTxHN0eE1ZHZN8GnyINqoW4vX9CzMfKqC0hymDNkSlYMuuikfxmmc7P/9/7
         QnYrYgoJYopuQIMsxEfvJ9kVIrNI0I+g4ADspVcr0fibplX7pI1EzGfRHHMgQ6Np0IHL
         yDbYoAPrLD0IkK/WKk8gep9brzNYyxwTw+8+AuldU48HIUA9tUlOECSDy4iFX7z/fabW
         wyBC95Ln+K65PUff0VbhhPeTvbTFVNiXgUcujfvrW4UsdN2Qh5whMTACusaKtp54t7FN
         uAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077953; x=1691669953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUYkKYV4ujMuk/ZAzUO3GhIfjlSDACYKMYMpvbHOS0o=;
        b=EO9S1/FkOleUu8OZM0N/p4iQzsGPb/3+Zl0qQI8QB1uz/eIt6dK/Y3szHjSfF9mVhI
         EykG0iLO8Su4VArLgSyNnCbX/SMA2nUvl+zU4rWV3C7KBkdBS95JMjxZRolN08/KpWrR
         eJE0wh1anHeOfh/X8nzDTR+oN5hDBT57rceQtGIAKWkOP9yESTbddde1AhvvCMt9W0Jf
         6NNtSJHemATI7m56Ax7hdwxL/JEKRpFQ4Sy7PsgHkKuuAYBYOOAzNVRx5iC4la7Gx9tL
         5GbIuESUiTCECqLL4Ui8XJtjMRjUEKnudAhQ6xkWkE9i0SIbDo9p5t7ycPAohf0kdEiA
         WnSg==
X-Gm-Message-State: ABy/qLYeWg+Mgcr4K0ng+l6P4nNSvYfZ6RpNpCJ4LEd/LIKrFuxwLhil
        T+R6/zFKjlkzMeKxn1rw2tY8wA==
X-Google-Smtp-Source: APBJJlFPUmyPSwMDVSzJWoSM+iefcHajI+de62524A0AkTML6/JzXuMpkaVh+NTJM4H+MO9OfFHL7w==
X-Received: by 2002:a2e:8210:0:b0:2b6:dec9:2813 with SMTP id w16-20020a2e8210000000b002b6dec92813mr12673229ljg.29.1689077953345;
        Tue, 11 Jul 2023 05:19:13 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:34 +0200
Subject: [PATCH 35/53] arm64: dts: qcom: sc7180: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-35-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=644;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xdrbax/ndnKE1dzVNPWI8e+2pkkV5TGwm4Tup9sPjbw=;
 b=ULJhbO/N8xan2DF4ZAbAkoTD8jZOS6LFAS8q/YqNYtwsRloh0iYcbUBoTNfPR7QB3ush0REIq
 9YjPh6F2yYjATxZuvg5kiiV3rlOj8Y9dltoQtB+QSLrRjusYdbPNHcU
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
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 179544ba12db..cf12f358fabb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3653,6 +3653,7 @@ rpmhpd_opp_turbo_l1: opp11 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0

