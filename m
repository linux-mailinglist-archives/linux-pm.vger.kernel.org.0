Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B583E369977
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbhDWSZn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 14:25:43 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:51564 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbhDWSZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 14:25:35 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Apr 2021 11:24:59 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Apr 2021 11:24:57 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Apr 2021 23:54:57 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 255CE4845; Fri, 23 Apr 2021 23:54:56 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH V2 2/3] ARM: dts: qcom: Add device node support for TSENS in SC7280.
Date:   Fri, 23 Apr 2021 23:52:56 +0530
Message-Id: <1619202177-13485-3-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619202177-13485-1-git-send-email-rkambl@codeaurora.org>
References: <1619202177-13485-1-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added device node for TSENS controller and critical interrupt support in SC7280.

Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
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

