Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8867741B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 03:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAWCbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 21:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjAWCbq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 21:31:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900116333
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 18:31:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t5so9507997wrq.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 18:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyw85nc/PwcD3lfXSO76poeJVDlKaOkIt5Q0MKdYW04=;
        b=tlFWUO+J1/0CkQIa646Kv8in1aiHnBN/7eoQk1B6TasxF1tXHw1L9pVBlXcILb5pDF
         Ij3Vf/Pma8HxRKotn/VfwdK733K0HBP4hohGo6n/WOqlPfV8sDFWyH7T8yaO+2Tyk/51
         w3TQjywYoUJJLH21wAUk1zPl5UAJV8Xp/Y2XUrnv9qFLkOPimBGw5ve3vbkE6VVNW68C
         K5LnWUtllljhYPoLusGAPxsFpYyfms5ytZ6VGow8ei8AmcpfZQiPlPBUmXD2u2YQT7xc
         i32cYaqhnIZvcxWpxZU3FQtFrTf+6sUMGjeI0Bjk1e0eX/DPJaIY1EOOsxG0RXm5cr2G
         eERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyw85nc/PwcD3lfXSO76poeJVDlKaOkIt5Q0MKdYW04=;
        b=lSDK5++pmTBtghEDTgH5bUX9CvgLXABRtvzJ+Mtfj7w87txbMZHfYD0c9JMRaDNE/f
         WybN3X0QpmNN4O1zz9IjEcNY1tqFqGIleZbPT+YWDTtd/triJ/m8m4YgoK0bSu/7D3Gv
         /PHPuYxH0y8Lug7h3dwUz40SmYBj69abH66Du7txXrovNBkimu8YikTw1SuYmMcjN8En
         InnRdCudQEPpdorhxeh77ov+ytqetgA8PKS0ILDQZnafl8duPqm0HDr3d3vGJwlBqWkl
         e+Kypa8zIWKzpe7e2ui4SnZQILpXgOi4f5cT1GsKR5lWf05jdHfrpfr7BsDBltPCX5XY
         1pbQ==
X-Gm-Message-State: AFqh2koav4Mr6YSl9lMLtyE8tbv9G2lbGtzkP99fCVjOVP5h/lhbbj6J
        yud1STrgjrupGEBIkxqzycy4Rg==
X-Google-Smtp-Source: AMrXdXuXqz/aCi6HoQmRqatT6pPkmUBr19lwXLCECUyYH5z/bdL0Z5qNOWqyin1NKXcwuJiZDBK6RA==
X-Received: by 2002:adf:edd1:0:b0:2bd:c6ce:7bfc with SMTP id v17-20020adfedd1000000b002bdc6ce7bfcmr20804816wro.42.1674441094980;
        Sun, 22 Jan 2023 18:31:34 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm18672703wrp.58.2023.01.22.18.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:31:34 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v4 4/6] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Mon, 23 Jan 2023 02:31:25 +0000
Message-Id: <20230123023127.1186619-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

The msm8939-pm8916.dtsi include configures the regulator supplies of
MSM8939 used together with PM8916, as recommended by Qualcomm. In rare
cases where boards deviate from the recommended design they can just
avoid using this include.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
new file mode 100644
index 0000000000000..18a1b3cca01d6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8939.dtsi"
+#include "pm8916.dtsi"
+
+&dsi0 {
+	vdda-supply = <&pm8916_l2>;
+	vddio-supply = <&pm8916_l6>;
+};
+
+&dsi1 {
+	vdda-supply = <&pm8916_l2>;
+	vddio-supply = <&pm8916_l6>;
+};
+
+&dsi_phy0 {
+	vddio-supply = <&pm8916_l6>;
+};
+
+&dsi_phy1 {
+	vddio-supply = <&pm8916_l6>;
+};
+
+&mpss {
+	pll-supply = <&pm8916_l7>;
+};
+
+&pronto {
+	vddpx-supply = <&pm8916_l7>;
+
+	iris {
+		vddxo-supply = <&pm8916_l7>;
+		vddrfa-supply = <&pm8916_s3>;
+		vddpa-supply = <&pm8916_l9>;
+		vdddig-supply = <&pm8916_l5>;
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8916_l8>;
+	vqmmc-supply = <&pm8916_l5>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8916_l11>;
+	vqmmc-supply = <&pm8916_l12>;
+};
+
+&usb_hs_phy {
+	v1p8-supply = <&pm8916_l7>;
+	v3p3-supply = <&pm8916_l13>;
+};
+
+&rpm_requests {
+	smd_rpm_regulators: regulators {
+		compatible = "qcom,rpm-pm8916-regulators";
+
+		/* pm8916_s1 is managed by rpmpd (MSM8939_VDDMDCX) */
+		/* pm8916_s2 is managed by rpmpd (MSM8939_VDDCX) */
+		pm8916_s3: s3 {};
+		pm8916_s4: s4 {};
+
+		pm8916_l1: l1 {};
+		pm8916_l2: l2 {};
+		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
+		pm8916_l4: l4 {};
+		pm8916_l5: l5 {};
+		pm8916_l6: l6 {};
+		pm8916_l7: l7 {};
+		pm8916_l8: l8 {};
+		pm8916_l9: l9 {};
+		pm8916_l10: l10 {};
+		pm8916_l11: l11 {};
+		pm8916_l12: l12 {};
+		pm8916_l13: l13 {};
+		pm8916_l14: l14 {};
+		pm8916_l15: l15 {};
+		pm8916_l16: l16 {};
+		pm8916_l17: l17 {};
+		pm8916_l18: l18 {};
+	};
+};
-- 
2.38.1

