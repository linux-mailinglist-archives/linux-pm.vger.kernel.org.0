Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55441744F15
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGBRnd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjGBRnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC8E62
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b699284ff4so58775711fa.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319783; x=1690911783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSVXLsNAShBJHVR9vMtlXCAILUdGmBkWDTfqBXPK0KY=;
        b=ZmcJGF6jZZmFSCd8ycbmcaHOGMQyab9woSgJuP6kPofFGLkUbCpH2iJL4ZnOluRXOT
         yRG0PX1JwRwroLdh943/EkXEnCdJ6Oj7l3MMIorqIw52bx6A8uDuX8Pr9AyMQGRXas6F
         5yvbfYBACeY/JLtRMpckROrDBO2ZihYecW75gRb1B86ELPptNzjNH06fmaFFL7XgAklO
         Xdn8i/UjPaJjt7mYPOrlz6f8swIk1kMZxglJkhvPPqOSXwindOCtTsGKmX/vIJNuCwsU
         uAeCdW+oDMRSP47mM7fBHrJQ6QFrrAImB/qgqAuHA//xt/Rcxu1vd0xvOOV7/aV8cS9M
         4o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319783; x=1690911783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSVXLsNAShBJHVR9vMtlXCAILUdGmBkWDTfqBXPK0KY=;
        b=MFHmH4+Z0sOtQrsQzCvKNgjlN8FKme/R0/QB1qMng1BZBtecrnRU7VjNAGRS+UiF5T
         XjFn9c8WkTnBH/upILAqg50nPlwFnkZZBJjyltfX7kbjv+wzIL50NyFOie8OgwtcNrAQ
         G96dFaoXd+jOEdichT2o65W8amZdL79Nxc9awH57aAXEkbGczyaI+2ARrbh6BLxklFNE
         ouKUsATUEC1Ny1MI2UjvCmKR47idzeSxF+nUFNEN1M8V1bYtAzCgzu3e7+00YRnrzWG+
         kTNyxR1qTGsqIqNanhtr1WiFett8dRulTr98PPnVjP/N/zfYT7gKw3hj4LNj6EvnvHO0
         xQfA==
X-Gm-Message-State: ABy/qLbMMOCVg3sAFOVpRsRxU3bPM+M7MjrFqHIVqVJueVswkueVMCIh
        Lvl6keiMUs72gocEu4oEw9gkRg==
X-Google-Smtp-Source: APBJJlGfQ5YkJLM5BRaVIDUTJf0Ihg0ey3efv6IrZlrqxbR3TVF8Kn/hf/0Ururks7UbAt0Uq3H7PQ==
X-Received: by 2002:a2e:8182:0:b0:2b6:cfec:69f7 with SMTP id e2-20020a2e8182000000b002b6cfec69f7mr4573764ljg.1.1688319783483;
        Sun, 02 Jul 2023 10:43:03 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:03 -0700 (PDT)
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
Subject: [PATCH v3 17/28] ARM: dts: qcom: apq8064-sony-xperia-lagan-yuga: constraint cpufreq regulators
Date:   Sun,  2 Jul 2023 20:42:35 +0300
Message-Id: <20230702174246.121656-18-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add additional constraints to the CPUfreq-related regulators, it is
better be safe than sorry there.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 6988bd212924..26f1e81e2bf5 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -130,7 +130,7 @@ pm8921_s2: s2 {
 		};
 
 		pm8921_s3: s3 {
-			regulator-min-microvolt = <500000>;
+			regulator-min-microvolt = <950000>;
 			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 			bias-pull-down;
@@ -281,7 +281,7 @@ pm8921_l23: l23 {
 		};
 
 		pm8921_l24: l24 {
-			regulator-min-microvolt = <750000>;
+			regulator-min-microvolt = <1050000>;
 			regulator-max-microvolt = <1150000>;
 			bias-pull-down;
 		};
@@ -335,7 +335,11 @@ pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
 
+		/* HFPLL regulator */
 		pm8921_lvs7: lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
 			bias-pull-down;
 		};
 
-- 
2.39.2

