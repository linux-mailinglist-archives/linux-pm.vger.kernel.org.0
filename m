Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE97376014
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 08:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhEGGJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 02:09:24 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7626 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhEGGJR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 02:09:17 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 May 2021 23:08:18 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 May 2021 23:08:15 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 May 2021 11:37:45 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 57D5E48DF; Fri,  7 May 2021 11:37:44 +0530 (IST)
From:   Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
Subject: [PATCH V4 2/3] arm64: dts: qcom: SC7280: Add device node support for TSENS
Date:   Fri,  7 May 2021 11:37:20 +0530
Message-Id: <1620367641-23383-3-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620367641-23383-1-git-send-email-rkambl@codeaurora.org>
References: <1620367641-23383-1-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding device node for TSENS controller and critical interrupt support in SC7280.

Signed-off-by: Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 2cc4785..275113c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -825,6 +825,28 @@
 			interrupt-controller;
 		};
 
+		tsens0: thermal-sensor@c263000 {
+			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
+			reg = <0 0x0c263000 0 0x1ff>, /* TM */
+				<0 0x0c222000 0 0x1ff>; /* SROT */
+			#qcom,sensors = <15>;
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible = "qcom,sc7280-tsens","qcom,tsens-v2";
+			reg = <0 0x0c265000 0 0x1ff>, /* TM */
+				<0 0x0c223000 0 0x1ff>; /* SROT */
+			#qcom,sensors = <12>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
+			#thermal-sensor-cells = <1>;
+		};
+
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sc7280-aoss-qmp";
 			reg = <0 0x0c300000 0 0x100000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

