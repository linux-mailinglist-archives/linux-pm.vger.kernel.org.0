Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3D652B55
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiLUCFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiLUCFk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3738820352
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:36 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 1so21377548lfz.4
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUNyl5gUqKABxQW3CtqGyJPzKUZiSegt4ZuS1VLA3tE=;
        b=SkORZjcVt7+wz18iEvffo9ZZVzgZo7naq3BqnIFX8XpxBlX3dVXpLuyAqnLN+z6mxu
         lXB5tGhgLVDt14hE8agX1GhEz7xUuXoKqXMECXzsk9Cwy/tQQz4gjPxJlzeH4eaderIl
         zke/9Zh42VnEIiOTyE5GwrnTh+hUSsivl1zr0W4ZufknvnONBeqJOikIHcdJnoE5R75K
         eZDxSQXaGGt9IMQm4UOvl5LvO7BtsUzmP7w5+d8Ck0Df7kNASg2MMtBG1QqBSvcxXdOc
         RzwenlHN4G90r7WqgLB+adaB24RXeGpDr4T8gnSavUYR1wweTS2xj8frt8dC5tfpzwBW
         l3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUNyl5gUqKABxQW3CtqGyJPzKUZiSegt4ZuS1VLA3tE=;
        b=687/LBch3dj1H+nSH4n2kY7DLTiPuSBxDXBK+qTKGouEV04mO8dxVijHzOXS3ayzju
         XTX1GwhnbjTotbVV8G1yqWB/nKKflHTttcUAk5jslqbcpJ7cTvIAJ26hJWGrBK+wNbmh
         LX4VQlvofsp8FaJhpfTmHLsAUsAcmPH2+EUXGSLfdSd4t9qAWVFlbb9hXZAbz+8MhOZb
         SpTo1BY7V2uAKLZYpEMSRuNuCgpXnmqSNR7Bg++ZvAbXzFKEnwA5L+bdPmj+cFyGAslA
         /MH/hbyMJbg7KYz7qwgBPl+J/6zMTMWlgRpUbkl5LM2mmv8oqF4V6eJgyGrqlCin+oO9
         01hg==
X-Gm-Message-State: AFqh2kr81UO+jh3pv3gAS1OuvmKgr6LexIwyN844pCHEuoEKni1ENv/9
        ytwyFHoIWIyOdYIIgBM02Gl57A==
X-Google-Smtp-Source: AMrXdXv5jmYOkFFB6poF6YLep/kXi+wg8iJqJAfab7bEf4V8MjKV05o0miqw2be/UaT7ro+Na18bNg==
X-Received: by 2002:a05:6512:c24:b0:4c7:bcee:aaed with SMTP id z36-20020a0565120c2400b004c7bceeaaedmr127824lfu.24.1671588335770;
        Tue, 20 Dec 2022 18:05:35 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:35 -0800 (PST)
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
Subject: [PATCH v4 17/20] arm64: dts: qcom: msm8976: specify per-sensor calibration cells
Date:   Wed, 21 Dec 2022 04:05:17 +0200
Message-Id: <20221221020520.1326964-18-dmitry.baryshkov@linaro.org>
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
2.35.1

