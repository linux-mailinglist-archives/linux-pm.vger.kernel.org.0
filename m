Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BDD65AB6D
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAATlK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjAATlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:41:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238342F1
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y25so38891308lfa.9
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFMgmMV7FQ7qxfSHjmq0dTPxGyh/y9BAB4HqOoms1Wg=;
        b=jC0k2DH/zzU0tAbhER9ZTheg35WD1hy8YMWMK4VY0nSCitwEfmjPuz2sJt+Z7/Rtv0
         eLCJoYzlZKD9/s+Zn6cmmUBfrEm4QR4RwLLAyBc3HcSBYIXYd/HAR8PSXrFm+QoGuyKq
         fMLihkSfqoJh3xOiCXbkBCVD0dFNdkHcBlYGRco/d4/Dnw57ikvgI10DtG6373Ufh9YV
         aqO4AjN3HNpmybx+PjLkTQLEKcGOjaSPDpfS9nIyFjYKueXnaZevIeRI5qghOX6zbYEA
         v62IS4VTdC4nTGJJ8EYq/kzAYe6tQBctKuFEFw2X0jo13KxN5hz1wbhOYZmC81OnJ4v3
         FfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFMgmMV7FQ7qxfSHjmq0dTPxGyh/y9BAB4HqOoms1Wg=;
        b=gAPPFfuhImvyogz117qgqzQD64szvl4Hp0XOhUBhc7TQZ+REr8Rth6M9q2GPLd4mab
         yx9Nj7vCiQtkx9Sgv4L1yqzkicd6rH53StmJQi08Q3Ap7LkuDdRtY7FOImPTDp+AZlTN
         6HVAeMihbWclNvvbsS4f6WQUiN3b2V5CoTyl1n/nLtyZIirmf0yLDIsgpn1GFvEQ+aKI
         U58KJeNhYIH6EH1+1xCR8qvg51Tuz9JnjDh4WOBMyBcMCdfYbi7t/XVaB4CAGcKDeUnH
         5kQ49Wl/YXCLJf4v4taQJH5u353Q6D0pJ8yNiEVb/J5Er5ezFJqVkyJnPSnIfDNGpjwP
         6dQA==
X-Gm-Message-State: AFqh2kp3NiArp9f4TZ5nZXaoRefkZCo28Babsd16X4+DLfAKlZrL9kuW
        HRq3xvjw7IeFax4AzE1fedvivA==
X-Google-Smtp-Source: AMrXdXv7u82bCqNshpUEl7TI1/sFtqvP2w7WvROFS+mwYy5kgQPEcclDMZUejbaaz4PplO8duKh48w==
X-Received: by 2002:a05:6512:3ca9:b0:4b5:61c5:8927 with SMTP id h41-20020a0565123ca900b004b561c58927mr12252669lfv.42.1672602051513;
        Sun, 01 Jan 2023 11:40:51 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:50 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 17/20] arm64: dts: qcom: msm8976: specify per-sensor calibration cells
Date:   Sun,  1 Jan 2023 21:40:31 +0200
Message-Id: <20230101194034.831222-18-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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

Specify pre-parsed per-sensor calibration nvmem cells in the tsens
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 153 +++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 05dcb30b0779..2d360d05aa5e 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -481,8 +481,129 @@ qfprom: qfprom@a4000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			tsens_caldata: caldata@218 {
-				reg = <0x218 0x18>;
+			tsens_base1: base1@218 {
+				reg = <0x218 1>;
+				bits = <0 8>;
+			};
+
+			tsens_s0_p1: s0-p1@219 {
+				reg = <0x219 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s0_p2: s0-p2@219 {
+				reg = <0x219 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s1_p1: s1-p1@21a {
+				reg = <0x21a 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s1_p2: s1-p2@21b {
+				reg = <0x21b 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s2_p1: s2-p1@21c {
+				reg = <0x21c 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s2_p2: s2-p2@21c {
+				reg = <0x21c 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s3_p1: s3-p1@21d {
+				reg = <0x21d 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s3_p2: s3-p2@21e {
+				reg = <0x21e 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_base2: base2@220 {
+				reg = <0x220 1>;
+				bits = <0 8>;
+			};
+
+			tsens_s4_p1: s4-p1@221 {
+				reg = <0x221 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s4_p2: s4-p2@221 {
+				reg = <0x221 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s5_p1: s5-p1@222 {
+				reg = <0x222 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s5_p2: s5-p2@223 {
+				reg = <0x224 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s6_p1: s6-p1@224 {
+				reg = <0x224 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s6_p2: s6-p2@224 {
+				reg = <0x224 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s7_p1: s7-p1@225 {
+				reg = <0x225 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s7_p2: s7-p2@226 {
+				reg = <0x226 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_mode: mode@228 {
+				reg = <0x228 1>;
+				bits = <0 3>;
+			};
+
+			tsens_s8_p1: s8-p1@228 {
+				reg = <0x228 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s8_p2: s8-p2@229 {
+				reg = <0x229 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s9_p1: s9-p1@229 {
+				reg = <0x229 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s9_p2: s9-p2@22a {
+				reg = <0x22a 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s10_p1: s10-p1@22b {
+				reg = <0x22b 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s10_p2: s10-p2@22c {
+				reg = <0x22c 0x1>;
+				bits = <1 6>;
 			};
 		};
 
@@ -492,8 +613,32 @@ tsens: thermal-sensor@4a9000 {
 			      <0x004a8000 0x1000>; /* SROT */
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
-			nvmem-cells = <&tsens_caldata>;
-			nvmem-cell-names = "calib";
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s3_p1>, <&tsens_s3_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>,
+				      <&tsens_s5_p1>, <&tsens_s5_p2>,
+				      <&tsens_s6_p1>, <&tsens_s6_p2>,
+				      <&tsens_s7_p1>, <&tsens_s7_p2>,
+				      <&tsens_s8_p1>, <&tsens_s8_p2>,
+				      <&tsens_s9_p1>, <&tsens_s9_p2>,
+				      <&tsens_s10_p1>, <&tsens_s10_p2>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s3_p1", "s3_p2",
+					   "s4_p1", "s4_p2",
+					   "s5_p1", "s5_p2",
+					   "s6_p1", "s6_p2",
+					   "s7_p1", "s7_p2",
+					   "s8_p1", "s8_p2",
+					   "s9_p1", "s9_p2",
+					   "s10_p1", "s10_p2";
 			#qcom,sensors = <11>;
 			#thermal-sensor-cells = <1>;
 		};
-- 
2.39.0

