Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A571652B5C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiLUCF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiLUCFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE9205C2
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so21321012lfa.12
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI5offdUIb1lMhzrYh6GbSePnARaWiVw3PY2elHH1e0=;
        b=amSRYNJZdUaOgHHpYXPwSDFc+YgcYrKyMBTe8UCgV0IQzuT1U2cHK4EYa3WyrOUJgA
         1B+PtEn2P4T1CdoOwdfrBZw9qhvMhUsw0mlPwVglm/UVvLhB9nPiPv0YCnU9faVh5XVN
         Spl/WO6QbReXJ+I0yloNXibRutgWmYlqdQ0DaVuQWdDb6FGqrB9OtRCLxpjl6w3nHdsp
         ygXDMja2nVgNTAxnXcxolQt9Fszo6PCiy4WoH3tkDe/8bBm7LVoSFcKNYy0g4Cn2Lt5m
         CJ13gv7n75ei6Lu5ecJUBHtlB4cS80GrYWf6/STOMB9jf0irF8F2I36MTI5rd9C268QU
         yKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI5offdUIb1lMhzrYh6GbSePnARaWiVw3PY2elHH1e0=;
        b=yo8wDnJWcHZxIdl6J1DXLolP6NIr498mEG4eMyUVyyqiGtfxXW5NMth3KxjfD1orgP
         QRzZ/7iqnlZf8KP2unm7naHGz3UuETXDUeTtqEKrdsl+gAFCkBttB/WSp8kwfykbmakr
         nuqzRU8ngxXy2nvK+pbLSWeu6xg87aB+rqzC+rG+dLkh8dtYJVdsWLi8SEZ5wg0AOCjz
         ouRzHqVlSvFnneVNF1r3rVI0wiEtaFcVAnmInd9l1sB5MPGb4QWssOnJhaqQVXYuC173
         Y1pfxwuhEhNJa9EDDb+VJA3l7nQ1rdMeJ+8EKweYvmE1slmoaUGOyUy8RfkN/Z69T6Sr
         VIjw==
X-Gm-Message-State: AFqh2kqIsNg8NtFS6HfcVbvczE327fg+UeIXmRz1vU1xx0HlWchExRy0
        AP9ywdu5YSeGBwmYdlz18yLRkg8LpbQtosyqDyY=
X-Google-Smtp-Source: AMrXdXtcdqminnkRc1myE5/Xn3OlrgElLch2FY1u5ht6nw9h5Mz7UgDFBv3OOlfLG6GzyuWqlDG0qg==
X-Received: by 2002:a05:6512:2821:b0:4b5:26f3:2247 with SMTP id cf33-20020a056512282100b004b526f32247mr76001lfb.69.1671588337552;
        Tue, 20 Dec 2022 18:05:37 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:37 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 19/20] ARM: dts: qcom-msm8974: specify per-sensor calibration cells
Date:   Wed, 21 Dec 2022 04:05:19 +0200
Message-Id: <20221221020520.1326964-20-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specify pre-parsed per-sensor calibration nvmem cells in the tsens
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 313 +++++++++++++++++++++++++++-
 1 file changed, 307 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 8d216a3c0851..4d3df70e6158 100644
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
@@ -1137,11 +1189,260 @@ qfprom: qfprom@fc4bc000 {
 			reg = <0xfc4bc000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_calib: calib@d0 {
-				reg = <0xd0 0x18>;
+
+			tsens_base1: base1@d0 {
+				reg = <0xd0 0x1>;
+				bits = <0 8>;
+			};
+
+			tsens_s0_p1: s0-p1@d1 {
+				reg = <0xd1 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s1_p1: s1-p1@d2 {
+				reg = <0xd1 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s2_p1: s2-p1@d2 {
+				reg = <0xd2 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s3_p1: s3-p1@d3 {
+				reg = <0xd3 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s4_p1: s4-p1@d4 {
+				reg = <0xd4 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s5_p1: s5-p1@d4 {
+				reg = <0xd4 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s6_p1: s6-p1@d5 {
+				reg = <0xd5 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s7_p1: s7-p1@d6 {
+				reg = <0xd6 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s8_p1: s8-p1@d7 {
+				reg = <0xd7 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_mode: mode@d7 {
+				reg = <0xd7 0x1>;
+				bits = <6 2>;
+			};
+
+			tsens_s9_p1: s9-p1@d8 {
+				reg = <0xd8 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s10_p1: s10_p1@d8 {
+				reg = <0xd8 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_base2: base2@d9 {
+				reg = <0xd9 0x2>;
+				bits = <4 8>;
+			};
+
+			tsens_s0_p2: s0-p2@da {
+				reg = <0xda 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s1_p2: s1-p2@db {
+				reg = <0xdb 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s2_p2: s2-p2@dc {
+				reg = <0xdc 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s3_p2: s3-p2@dc {
+				reg = <0xdc 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s4_p2: s4-p2@dd {
+				reg = <0xdd 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s5_p2: s5-p2@de {
+				reg = <0xde 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s6_p2: s6-p2@df {
+				reg = <0xdf 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s7_p2: s7-p2@e0 {
+				reg = <0xe0 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s8_p2: s8-p2@e0 {
+				reg = <0xe0 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s9_p2: s9-p2@e1 {
+				reg = <0xe1 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s10_p2: s10_p2@e2 {
+				reg = <0xe2 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s5_p2_backup: s5-p2_backup@e3 {
+				reg = <0xe3 0x2>;
+				bits = <0 6>;
+			};
+
+			tsens_mode_backup: mode_backup@e3 {
+				reg = <0xe3 0x1>;
+				bits = <6 2>;
+			};
+
+			tsens_s6_p2_backup: s6-p2_backup@e4 {
+				reg = <0xe4 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s7_p2_backup: s7-p2_backup@e4 {
+				reg = <0xe4 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s8_p2_backup: s8-p2_backup@e5 {
+				reg = <0xe5 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s9_p2_backup: s9-p2_backup@e6 {
+				reg = <0xe6 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s10_p2_backup: s10_p2_backup@e7 {
+				reg = <0xe7 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_base1_backup: base1_backup@440 {
+				reg = <0x440 0x1>;
+				bits = <0 8>;
+			};
+
+			tsens_s0_p1_backup: s0-p1_backup@441 {
+				reg = <0x441 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s1_p1_backup: s1-p1_backup@442 {
+				reg = <0x441 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s2_p1_backup: s2-p1_backup@442 {
+				reg = <0x442 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s3_p1_backup: s3-p1_backup@443 {
+				reg = <0x443 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s4_p1_backup: s4-p1_backup@444 {
+				reg = <0x444 0x1>;
+				bits = <0 6>;
 			};
-			tsens_backup: backup@440 {
-				reg = <0x440 0x10>;
+
+			tsens_s5_p1_backup: s5-p1_backup@444 {
+				reg = <0x444 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s6_p1_backup: s6-p1_backup@445 {
+				reg = <0x445 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s7_p1_backup: s7-p1_backup@446 {
+				reg = <0x446 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_use_backup: use_backup@447 {
+				reg = <0x447 0x1>;
+				bits = <5 3>;
+			};
+
+			tsens_s8_p1_backup: s8-p1_backup@448 {
+				reg = <0x448 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s9_p1_backup: s9-p1_backup@448 {
+				reg = <0x448 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s10_p1_backup: s10_p1_backup@449 {
+				reg = <0x449 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_base2_backup: base2_backup@44a {
+				reg = <0x44a 0x2>;
+				bits = <2 8>;
+			};
+
+			tsens_s0_p2_backup: s0-p2_backup@44b {
+				reg = <0x44b 0x3>;
+				bits = <2 6>;
+			};
+
+			tsens_s1_p2_backup: s1-p2_backup@44c {
+				reg = <0x44c 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s2_p2_backup: s2-p2_backup@44c {
+				reg = <0x44c 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s3_p2_backup: s3-p2_backup@44d {
+				reg = <0x44d 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s4_p2_backup: s4-p2_backup@44e {
+				reg = <0x44e 0x1>;
+				bits = <2 6>;
 			};
 		};
 
-- 
2.35.1

