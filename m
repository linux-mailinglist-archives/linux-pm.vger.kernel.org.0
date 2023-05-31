Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDB71734A
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 03:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjEaBm5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 21:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjEaBmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 21:42:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6935E124
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 18:42:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4f757d575so562190e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685497372; x=1688089372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N12gfFtx2uUrPiE+zEwFxqEuTlfoHWgM0ZbjtW5pSzo=;
        b=s40cckDoVbkyLiNx+I24Sv8hcbm0EfanQbMSWlF0Za2R/LeKdodwn/8zZ8Ug9QVTJu
         mIbfhcd/mckYqHp9rCw91uRxAoeX7MojU6hUBiYeGngr6FQKKuND1SusUuuGvm4Wmh7m
         Bb84yxQGxZTtYnwy8Zca/kLTkC3VJj3++lUcJgEO4T3KstqL785U6ziVNOKuFR++5Ycc
         gsQSnBlyWp5goB+ujA7juECNpLEkQy8JiSdLONspiwYjscDW/tTU/AKHYjT9ITK2fitS
         Y/mWOCFYbv3+lDgfH5KcBLtpi/51fi3XTTMR9tlYN0kLrOVWauZ/7jFCB9ZrFhMGVM74
         3X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685497372; x=1688089372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N12gfFtx2uUrPiE+zEwFxqEuTlfoHWgM0ZbjtW5pSzo=;
        b=eWDVYcO57bYOdVLeiFfEqHzWQ78ewL/u+SWHPMrWztxyOR2k2EBnrvOngU+XHm+S40
         fZZygBmNgcLZ+nnKSh8i8xM9t0/mHX9S8wYJRn4WBa/QTLgXrzkyQ+X7QUNbk4Rqq2WY
         hh4Pmiv29hQPlCMaDzRp+Ygq3d998WCy69WbLiiEB2sKa2ux26TGg4Lk2F+tsGmiTUyZ
         xXUkBA2WrTvhRwcqiFaMAeNS/LY+x5rBryc/5d81rKSl78uuBBAE0+zbSPVuBcbFFcvF
         lYZRHvsU61yfG2ahu6Ij5wkDdcuyrFIPh85yXjPYgsITtTMCkHVDrAMhAnVjHonO/sTo
         1W9g==
X-Gm-Message-State: AC+VfDwCkC/lCYYLLFjzr8r+WJ6SlARURCBABd7v8E3nDQ8tFdWtsE4N
        rVN+7tEHJ28EflLWiaEuC1rc+g==
X-Google-Smtp-Source: ACHHUZ4B7uyEA+PMOmmqXz5/TeRg0+k23G4/4d5E3EfVX5cES1J0OJdMClokWlam/MMqPqXPHxVWig==
X-Received: by 2002:a05:6512:ad3:b0:4f1:3a46:b351 with SMTP id n19-20020a0565120ad300b004f13a46b351mr4504276lfu.4.1685497372822;
        Tue, 30 May 2023 18:42:52 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id q20-20020ac25294000000b004f3945751b2sm515994lfm.43.2023.05.30.18.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 18:42:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/4] ARM: dts: qcom-pm8941: add resin support
Date:   Wed, 31 May 2023 04:42:47 +0300
Message-Id: <20230531014248.3824043-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
References: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Wrap existing pwrkey and new resin nodes into the new pon node to enable
volume-down key support on platforms using pm8941 PMIC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index a821f0368a28..cf1fcf97fa88 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -19,12 +19,24 @@ rtc@6000 {
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		pwrkey@800 {
-			compatible = "qcom,pm8941-pwrkey";
+		pon@800 {
+			compatible = "qcom,pm8941-pon";
 			reg = <0x800>;
-			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
-			debounce = <15625>;
-			bias-pull-up;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+			};
+
+			pm8941_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
 		};
 
 		usb_id: usb-detect@900 {
-- 
2.39.2

