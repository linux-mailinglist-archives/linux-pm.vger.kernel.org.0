Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4666D32683E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBZUNP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhBZUMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:12:18 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96CC0698C8
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 12:09:23 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 6C11F1F69E;
        Fri, 26 Feb 2021 21:07:37 +0100 (CET)
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
Subject: [PATCH 41/41] arm64: dts: qcom: sdm630: Add DMA to I2C hosts
Date:   Fri, 26 Feb 2021 21:04:11 +0100
Message-Id: <20210226200414.167762-42-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add DMA properties to I2C hosts to allow for DMA transfers.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index fccfc4e9f69d..0ec070fea034 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1805,6 +1805,8 @@ blsp_i2c1: i2c@c175000 {
 					<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c1_default>;
@@ -1823,6 +1825,8 @@ blsp_i2c2: i2c@c176000 {
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c2_default>;
@@ -1841,6 +1845,8 @@ blsp_i2c3: i2c@c177000 {
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c3_default>;
@@ -1859,6 +1865,8 @@ blsp_i2c4: i2c@c178000 {
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c4_default>;
@@ -1905,6 +1913,8 @@ blsp_i2c5: i2c@c1b5000 {
 				 <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp2_dma 4>, <&blsp2_dma 5>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c5_default>;
@@ -1923,6 +1933,8 @@ blsp_i2c6: i2c@c1b6000 {
 				 <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c6_default>;
@@ -1941,6 +1953,8 @@ blsp_i2c7: i2c@c1b7000 {
 				 <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp2_dma 8>, <&blsp2_dma 9>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c7_default>;
@@ -1959,6 +1973,8 @@ blsp_i2c8: i2c@c1b8000 {
 				 <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			clock-frequency = <400000>;
+			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c8_default>;
-- 
2.30.1

