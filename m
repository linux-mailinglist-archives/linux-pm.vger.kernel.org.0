Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B232682B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZULp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhBZULc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:11:32 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E2C0698C7;
        Fri, 26 Feb 2021 12:07:36 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id C8E1E1F695;
        Fri, 26 Feb 2021 21:07:32 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 40/41] arm64: dts: qcom: sdm630: Add I2C functions to I2C pins
Date:   Fri, 26 Feb 2021 21:04:10 +0100
Message-Id: <20210226200414.167762-41-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This was overlooked earlier, fix it to ensure the busses can
work properly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index a5a06afc2c94..fccfc4e9f69d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -941,96 +941,112 @@ pinconf-rx-cts-rts {
 
 			i2c1_default: i2c1-default {
 				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c1_sleep: i2c1-sleep {
 				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c2_default: i2c2-default {
 				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c2_sleep: i2c2-sleep {
 				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c3_default: i2c3-default {
 				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c3_sleep: i2c3-sleep {
 				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c4_default: i2c4-default {
 				pins = "gpio14", "gpio15";
+				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c4_sleep: i2c4-sleep {
 				pins = "gpio14", "gpio15";
+				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c5_default: i2c5-default {
 				pins = "gpio18", "gpio19";
+				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c5_sleep: i2c5-sleep {
 				pins = "gpio18", "gpio19";
+				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c6_default: i2c6-default {
 				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c6_sleep: i2c6-sleep {
 				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c7_default: i2c7-default {
 				pins = "gpio26", "gpio27";
+				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c7_sleep: i2c7-sleep {
 				pins = "gpio26", "gpio27";
+				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
 			i2c8_default: i2c8-default {
 				pins = "gpio30", "gpio31";
+				function = "blsp_i2c8";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
 			i2c8_sleep: i2c8-sleep {
 				pins = "gpio30", "gpio31";
+				function = "blsp_i2c8";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
-- 
2.30.1

