Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B56DB46D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjDGTt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjDGTtS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 15:49:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FA7D90
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 12:49:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p34so24531921wms.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680896953; x=1683488953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/DHrk49vUBVWlm5NrT6lO9bNYVi+21wKREqdqKmUws=;
        b=kmZMdNysMb5VIEkXebVDmgXywocnEat6oPEmZhsNVS4cPxBsXEOP2gth7209mUaf51
         2qRrXdSSY972vlN9uIw0LzEhdiiQvsrtydPVIu0S/lWn5JbJCcAfe7E6FzdKU1r2JegU
         tuLOd30N27R9qlJA4vYcD2s2swQ2xH9+3y8r4C7Hiq07WqwyVDpy78bLHTOmWAzM86pQ
         QlQjk6guTigTWQBc1lxV5iYu9/4NaFjYT0kKRZfuPdPr/9hvZawwlLQVmG8AcpZb+QWo
         ANQKyc2Fc/zbW3JtRJJGewHoqOSFJtydMbgW0/9wurNO/1ZAzwpwwH5IxPpGFFSSg8Kt
         XmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896953; x=1683488953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/DHrk49vUBVWlm5NrT6lO9bNYVi+21wKREqdqKmUws=;
        b=MzLXJeSiOc98egW0wk3IOl1HzvBqDR3kGw9eTc0DBO6ruPOiIBqFDtezsghXJ23dVF
         wV3YvMUU+6fyrg/yqECkO/O1VZQYIT/8nZ0x99XXf+2luwdpXLy1h9LB8QEodluF0aB9
         sSEw283ZDhze0Lf7XRqWSa9TKb+7RxdrorTdvqDcDZ8t8sg5sWGXYRZiuzofHohQp7dk
         l7z5TvAIcIZ5fhUiUcqPTGL/369qcWSL+KLVb/hSNNHy9vcrFI57rEEoSytPjtePeZ+6
         GPHmJX1ww1MpGzEmUm5bC0iuYfkO99VJsy7es0bGuTUViNwYvsjVCfV3PdIKS6UZ2z2u
         VR5A==
X-Gm-Message-State: AAQBX9cqbLJhLIR1f8e4QU93he7gETlGnYvB/p/3xUyAphrF7B7EgOw4
        fVs1ErbKQHAxbpn81stWjQUdWg==
X-Google-Smtp-Source: AKy350aMDp1jimULttE1OgKaYThyamFt8dwR6CbqA0W+Mm/c4jjbdbj7sp9v0GmLtZfIBuBJlHsQZQ==
X-Received: by 2002:a05:600c:2296:b0:3f0:5fda:c95f with SMTP id 22-20020a05600c229600b003f05fdac95fmr2300287wmf.26.1680896952843;
        Fri, 07 Apr 2023 12:49:12 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm9429551wmo.44.2023.04.07.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:49:12 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v9 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Fri,  7 Apr 2023 20:49:03 +0100
Message-Id: <20230407194905.611461-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
References: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
new file mode 100644
index 0000000000000..24393a1590580
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
+&wcnss {
+	vddpx-supply = <&pm8916_l7>;
+};
+
+&wcnss_iris {
+	vddxo-supply = <&pm8916_l7>;
+	vddrfa-supply = <&pm8916_s3>;
+	vddpa-supply = <&pm8916_l9>;
+	vdddig-supply = <&pm8916_l5>;
+};
-- 
2.39.2

