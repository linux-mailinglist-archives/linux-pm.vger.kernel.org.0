Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271A641B02
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLDF7g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLDF71 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:27 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A41B1C0
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a7so9917880ljq.12
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUpy5AaU1iR+sX97Q1RgxtNZNxy7+YZyxW44M5gUdpM=;
        b=NizDqBp1Wf/FIQruX4meZN9rJ5vExQGWAqbYpJaRGyODK5ebQPSHBeqwOBcVUhAyN4
         2H6z3Y5lIsIMDLs9EEBto71d9xioEsWExwpbVYg87vuggVE3BPwjkkMymBUJzRcVfdG0
         Vdtq8TfkRZxzt2KuD8Ko0bcwLb/RI8Cm+RxSQ5cR1lXLy3QUbWgLH0s0P8Eoe12GVSXE
         jJcXoXAkVfpWoCt+iJRw5VCCaDTHgCbIE/J4oNW0FDl1hFjA2CFn3RA7R+6ZjQ7tzONN
         fgcQflg9GhpUjzGon4kFYGqfQPeR9ZA6L/48eR77lH087PkpSHEGAA/rr4jYxfXpexcf
         s8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUpy5AaU1iR+sX97Q1RgxtNZNxy7+YZyxW44M5gUdpM=;
        b=pD6uGn755Nq5XacpL7/iDaXdPt/pUyAqcN44IURa/pkGI4Vx1OAIfYImjBPEDHQdAb
         aznubfXV11FEmBUFMZXC9/Is9+a8NEUchzr/tZS3Z2Gt7qMyuMJn+C4nYYzMVMCJvMbv
         lg4igiUYfW3T7bjlXscRIYWocy22+8M6je+90uT00nVbeAo0ICw09D+AhVtXkFggDZy3
         klvwEz8h2K9nUUPEGvtud2xwpurNQJtaqsX4jIBi5qT64XqH16ogM7ftpQ58lHrN0Wz3
         rkKry0Br5ZZ/bt7wpcnsAn9lD3D3CskMV5Zl0500yzeSUP2znIOIYzxVpJbOHqlYwPCH
         z5OQ==
X-Gm-Message-State: ANoB5pmk1ghMSz47gOtFrHDx1hZduX3ibm4maiaKrnsczIMHu6a3FxuU
        dQjv2KpXVhsGy2rNiwuluTtQyA==
X-Google-Smtp-Source: AA0mqf5xaKGCpWOUnQ2zY6VDvG8q+W9hyC3C9tfAG6P2LkQUbDHQHkMb1kuoej/U46xFPlGHy7tY6w==
X-Received: by 2002:a2e:a265:0:b0:26d:ee99:93b4 with SMTP id k5-20020a2ea265000000b0026dee9993b4mr19876874ljm.329.1670133561730;
        Sat, 03 Dec 2022 21:59:21 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:21 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 14/15] ARM: dts: qcom-msm8974: specify per-sensor calibration cells
Date:   Sun,  4 Dec 2022 07:59:08 +0200
Message-Id: <20221204055909.1351895-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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
 arch/arm/boot/dts/qcom-msm8974.dtsi | 262 +++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index bdf1a4cca1c1..20c649451e49 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1119,8 +1119,60 @@ tsens: thermal-sensor@fc4a9000 {
 			compatible = "qcom,msm8974-tsens", "qcom,tsens-v0_1";
 			reg = <0xfc4a9000 0x1000>, /* TM */
 			      <0xfc4a8000 0x1000>; /* SROT */
-			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
-			nvmem-cell-names = "calib", "calib_backup";
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
+				      <&tsens_s10_p1>, <&tsens_s10_p2>,
+				      <&tsens_use_backup>,
+				      <&tsens_mode_backup>,
+				      <&tsens_base1_backup>, <&tsens_base2_backup>,
+				      <&tsens_s0_p1_backup>, <&tsens_s0_p2_backup>,
+				      <&tsens_s1_p1_backup>, <&tsens_s1_p2_backup>,
+				      <&tsens_s2_p1_backup>, <&tsens_s2_p2_backup>,
+				      <&tsens_s3_p1_backup>, <&tsens_s3_p2_backup>,
+				      <&tsens_s4_p1_backup>, <&tsens_s4_p2_backup>,
+				      <&tsens_s5_p1_backup>, <&tsens_s5_p2_backup>,
+				      <&tsens_s6_p1_backup>, <&tsens_s6_p2_backup>,
+				      <&tsens_s7_p1_backup>, <&tsens_s7_p2_backup>,
+				      <&tsens_s8_p1_backup>, <&tsens_s8_p2_backup>,
+				      <&tsens_s9_p1_backup>, <&tsens_s9_p2_backup>,
+				      <&tsens_s10_p1_backup>, <&tsens_s10_p2_backup>;
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
+					   "s10_p1", "s10_p2",
+					   "use_backup",
+					   "mode_backup",
+					   "base1_backup", "base2_backup",
+					   "s0_p1_backup", "s0_p2_backup",
+					   "s1_p1_backup", "s1_p2_backup",
+					   "s2_p1_backup", "s2_p2_backup",
+					   "s3_p1_backup", "s3_p2_backup",
+					   "s4_p1_backup", "s4_p2_backup",
+					   "s5_p1_backup", "s5_p2_backup",
+					   "s6_p1_backup", "s6_p2_backup",
+					   "s7_p1_backup", "s7_p2_backup",
+					   "s8_p1_backup", "s8_p2_backup",
+					   "s9_p1_backup", "s9_p2_backup",
+					   "s10_p1_backup", "s10_p2_backup";
 			#qcom,sensors = <11>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
@@ -1137,11 +1189,209 @@ qfprom: qfprom@fc4bc000 {
 			reg = <0xfc4bc000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_calib: calib@d0 {
-				reg = <0xd0 0x18>;
+			tsens_base1: base1@d0 {
+				reg = <0xd0 0x1>;
+				bits = <0 8>;
 			};
-			tsens_backup: backup@440 {
-				reg = <0x440 0x10>;
+			tsens_s0_p1: s0_p1@d1 {
+				reg = <0xd1 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s1_p1: s1_p1@d2 {
+				reg = <0xd1 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s2_p1: s2_p1@d2 {
+				reg = <0xd2 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s3_p1: s3_p1@d3 {
+				reg = <0xd3 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s4_p1: s4_p1@d4 {
+				reg = <0xd4 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s5_p1: s5_p1@d4 {
+				reg = <0xd4 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s6_p1: s6_p1@d5 {
+				reg = <0xd5 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s7_p1: s7_p1@d6 {
+				reg = <0xd6 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s8_p1: s8_p1@d7 {
+				reg = <0xd7 0x1>;
+				bits = <0 6>;
+			};
+			tsens_mode: mode@d7 {
+				reg = <0xd7 0x1>;
+				bits = <6 2>;
+			};
+			tsens_s9_p1: s9_p1@d8 {
+				reg = <0xd8 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s10_p1: s10_p1@d8 {
+				reg = <0xd8 0x2>;
+				bits = <6 6>;
+			};
+			tsens_base2: base2@d9 {
+				reg = <0xd9 0x2>;
+				bits = <4 8>;
+			};
+			tsens_s0_p2: s0_p2@da {
+				reg = <0xda 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s1_p2: s1_p2@db {
+				reg = <0xdb 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s2_p2: s2_p2@dc {
+				reg = <0xdc 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s3_p2: s3_p2@dc {
+				reg = <0xdc 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s4_p2: s4_p2@dd {
+				reg = <0xdd 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s5_p2: s5_p2@de {
+				reg = <0xde 0x2>;
+				bits = <2 6>;
+			};
+			tsens_s6_p2: s6_p2@df {
+				reg = <0xdf 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s7_p2: s7_p2@e0 {
+				reg = <0xe0 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s8_p2: s8_p2@e0 {
+				reg = <0xe0 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s9_p2: s9_p2@e1 {
+				reg = <0xe1 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s10_p2: s10_p2@e2 {
+				reg = <0xe2 0x2>;
+				bits = <2 6>;
+			};
+			tsens_s5_p2_backup: s5_p2_backup@e3 {
+				reg = <0xe3 0x2>;
+				bits = <0 6>;
+			};
+			tsens_mode_backup: mode_backup@e3 {
+				reg = <0xe3 0x1>;
+				bits = <6 2>;
+			};
+			tsens_s6_p2_backup: s6_p2_backup@e4 {
+				reg = <0xe4 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s7_p2_backup: s7_p2_backup@e4 {
+				reg = <0xe4 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s8_p2_backup: s8_p2_backup@e5 {
+				reg = <0xe5 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s9_p2_backup: s9_p2_backup@e6 {
+				reg = <0xe6 0x2>;
+				bits = <2 6>;
+			};
+			tsens_s10_p2_backup: s10_p2_backup@e7 {
+				reg = <0xe7 0x1>;
+				bits = <0 6>;
+			};
+			tsens_base1_backup: base1_backup@440 {
+				reg = <0x440 0x1>;
+				bits = <0 8>;
+			};
+			tsens_s0_p1_backup: s0_p1_backup@441 {
+				reg = <0x441 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s1_p1_backup: s1_p1_backup@442 {
+				reg = <0x441 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s2_p1_backup: s2_p1_backup@442 {
+				reg = <0x442 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s3_p1_backup: s3_p1_backup@443 {
+				reg = <0x443 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s4_p1_backup: s4_p1_backup@444 {
+				reg = <0x444 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s5_p1_backup: s5_p1_backup@444 {
+				reg = <0x444 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s6_p1_backup: s6_p1_backup@445 {
+				reg = <0x445 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s7_p1_backup: s7_p1_backup@446 {
+				reg = <0x446 0x1>;
+				bits = <2 6>;
+			};
+			tsens_use_backup: use_backup@447 {
+				reg = <0x447 0x1>;
+				bits = <5 3>;
+			};
+			tsens_s8_p1_backup: s8_p1_backup@448 {
+				reg = <0x448 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s9_p1_backup: s9_p1_backup@448 {
+				reg = <0x448 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s10_p1_backup: s10_p1_backup@449 {
+				reg = <0x449 0x2>;
+				bits = <4 6>;
+			};
+			tsens_base2_backup: base2_backup@44a {
+				reg = <0x44a 0x2>;
+				bits = <2 8>;
+			};
+			tsens_s0_p2_backup: s0_p2_backup@44b {
+				reg = <0x44b 0x3>;
+				bits = <2 6>;
+			};
+			tsens_s1_p2_backup: s1_p2_backup@44c {
+				reg = <0x44c 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s2_p2_backup: s2_p2_backup@44c {
+				reg = <0x44c 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s3_p2_backup: s3_p2_backup@44d {
+				reg = <0x44d 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s4_p2_backup: s4_p2_backup@44e {
+				reg = <0x44e 0x1>;
+				bits = <2 6>;
 			};
 		};
 
-- 
2.35.1

