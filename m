Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F86F9D0D
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 02:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjEHAdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 May 2023 20:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHAdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2023 20:33:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80588A60
        for <linux-pm@vger.kernel.org>; Sun,  7 May 2023 17:33:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f00d41df22so26053377e87.1
        for <linux-pm@vger.kernel.org>; Sun, 07 May 2023 17:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683505994; x=1686097994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEQDCOyFW88AgofKdbGFwc945Q39RQOUdRFCRSDEy4A=;
        b=y9IkXDsAwbqXPLy4CCV5z82g+CmkqqbXvOuEKwpKwRK26EljXvzOqDXIgiDkIRYKVB
         0CPVca372LKAWy8VvibYZ8UnwO8DCraceJKCtZsgNmR+uBCtvjeQ8j6spnsblxY22PBu
         2lblNOJFYLu73gZwBFo+ULelUnDGDSqNnasLrWvaMLgaxja5JwGpgoOc494XSc1mARZ3
         ndcyA1Hi9AE/aq6sHfjShEplyIZOzRwMH9I7CaK7yHNhq2Ed2dKurudO6OkX9KIMCsYn
         Xz4Jo3bF+qs/zLAOkzmmRJWheDx8YHQ8kH/VFFYUZEexfUWfw7SEL0WVlquzcMGD+ZNJ
         dc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683505994; x=1686097994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEQDCOyFW88AgofKdbGFwc945Q39RQOUdRFCRSDEy4A=;
        b=ilKXN3aVQ43rOyIWDOUGXBJ2C/LrU8BV4nm1XyGfbr0qJZiYgm83lv53779agSOVmg
         2HpkQX04H7QvtDb1UaWxh/4SxAMnQFlufDA1aj7DUTU43XR9sjbKNuTaMJ5siKdB1mrR
         8+EqzeZ5oEiINa/QzDGWAcl1OBwsAcNm6RFjLi5s4zesd+G4j9D1dka+VZg0XaCEFwVE
         MLVwMXt0QpYUBbFLEAjcTeXccfd+GbjEcldpv2qvBm/dav+SDiuC4Lf5nys+GIK/hbO1
         ib4OiLobpswRyoSF0TK/xXu/Jpem48AqJuCL3gmfpIKWniUbkafRiDWYpWM6O2gsE4+z
         YI9w==
X-Gm-Message-State: AC+VfDy8K1vemVkpDpBPLr/2mp0i+jutFcOy5DgTPUOWU45cD1xZMroi
        kXtsePkOvMaM5RtgaihqS81mjg==
X-Google-Smtp-Source: ACHHUZ56enFA9XXTyqGS4NKHXMm5OwkUAErfoCMn0N+pG4Pzb5367H6gEqKnmtEID/UCoHRjBDMSuw==
X-Received: by 2002:a05:6512:3983:b0:4eb:41ac:e33 with SMTP id j3-20020a056512398300b004eb41ac0e33mr4860293lfu.19.1683505994800;
        Sun, 07 May 2023 17:33:14 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id m22-20020ac24256000000b004eca2b8b6bdsm1114807lfl.4.2023.05.07.17.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 17:33:14 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: qcom: apq8074-dragonboard: enable coincell charger
Date:   Mon,  8 May 2023 03:33:09 +0300
Message-Id: <20230508003309.2363787-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
References: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
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

Enable coincell charger for the coin battery which can be installed on
the APQ8074 dragonboard.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 16d609b85dfe..1d1c08674254 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -113,6 +113,12 @@ &mdss {
 	status = "okay";
 };
 
+&pm8941_coincell {
+	qcom,rset-ohms = <2100>;
+	qcom,vset-millivolts = <3000>;
+	status = "okay";
+};
+
 &pm8941_gpios {
         msm_keys_default: pm8941-gpio-keys-state {
                 pinconf {
-- 
2.39.2

