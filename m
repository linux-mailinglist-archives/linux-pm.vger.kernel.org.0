Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60767744F09
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGBRna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGBRnE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D85183
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so5608682e87.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319781; x=1690911781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p35WnKMBrcXjWofFp1qaZzVTDzePQvr7csu2aCOqwqs=;
        b=Ex6Qty5NQA+OMe426tTOlQi9DdfvarRAeo3rNIPrebH+QWHcfuQ3akHy9RJ7IUAGWV
         PmGEt/22Xl4I/ypJ40OEW51nDANL2ceEFbTEohuXI8RwjzNjbNmgC0AGOYbL8vF4td05
         h8g4If8E1+bkzQdn0majiXcMimpVixMAqeAeOJyet+QuR/xyyl9TA9eq30G5aJB0zClQ
         +pvgCJQ0l9kHtcAEay9JN0k0YNOBK6kgqA8euuI9LkGEaA5JjF8v+1FiBLVhzW7gjAUa
         aXj8pM/dObad9YJpyRPz6Oqry33mtLD52r/uuihhnRI4OaaZxMHlCo1p7ulk1azm3psT
         VuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319781; x=1690911781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p35WnKMBrcXjWofFp1qaZzVTDzePQvr7csu2aCOqwqs=;
        b=WnvbyTsMlEdygu+imkUOklo919W8QEi+xPdYq9D9/RJj0XPUZDZ6JkvKU575w9aofx
         LhWUJ+zh7WNi+Y97j9mpmD+dFBXXI7swFBDQQnqg01R8n1IRr+LgBDPoyBr5xdGaW0ID
         goXk2CjivTexicmk6ASl+u/9lopyWe/mzGBiWbs9722CCHt0Z/Y3aAo0yfd3KIFxfXuX
         j3Rkqygx1bOU4mDRpkTc9BfmtGOKgPQlDJ+xFBa7CLP7UTx8cYi+8YpW1F/30uPe9Z76
         afF0OGDx5UHg3sUTRQRa6DENKVRpRGq9nUyidnzqYAGo9ZQfnSpWCOXUZryyMGXmpkkw
         hLkg==
X-Gm-Message-State: ABy/qLbr31hdbzWyBBJG9jc1CYusOzjFN16WwfWINQrWRTL663cfBlm9
        6GchWD5owOxZQJsZ8OocrMaS0Q==
X-Google-Smtp-Source: APBJJlHfIYKPLytohmPzXYxo2iOKjkOvmbWAbnFRn3JksRlWN++KHH9xEYp3mxEfx8pweMNo1KS20Q==
X-Received: by 2002:ac2:5e68:0:b0:4fb:8939:d95c with SMTP id a8-20020ac25e68000000b004fb8939d95cmr4930570lfr.30.1688319781653;
        Sun, 02 Jul 2023 10:43:01 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:01 -0700 (PDT)
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
Subject: [PATCH v3 15/28] ARM: dts: qcom: apq8064-cm-qs600: constraint cpufreq regulators
Date:   Sun,  2 Jul 2023 20:42:33 +0300
Message-Id: <20230702174246.121656-16-dmitry.baryshkov@linaro.org>
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
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
index 6472277d1c6d..ee0090e03fb3 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
@@ -106,8 +106,8 @@ pm8921_s1: s1 {
 		};
 
 		pm8921_s3: s3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1400000>;
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
 
@@ -147,9 +147,23 @@ pm8921_l23: l23 {
 			bias-pull-down;
 		};
 
+		pm8921_l24: l24 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+			bias-pull-down;
+		};
+
 		pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
+
+		/* HFPLL regulator */
+		pm8921_lvs7: lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
 	};
 };
 
-- 
2.39.2

