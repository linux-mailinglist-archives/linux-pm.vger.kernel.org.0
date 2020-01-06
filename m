Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60E21312E8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFNaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 08:30:11 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:36505 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbgAFNaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 08:30:10 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Jan 2020 19:00:00 +0530
Received: from c-rkambl-linux1.qualcomm.com ([10.242.50.190])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Jan 2020 18:59:44 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 1965A11E4; Mon,  6 Jan 2020 18:59:43 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manaf@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add configuration in yaml
Date:   Mon,  6 Jan 2020 18:59:29 +0530
Message-Id: <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
References: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added configuration in dt-bindings for SC7180.

Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index eef13b9..c0ed030 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -38,6 +38,7 @@ properties:
           - enum:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
+              - qcom,sc7180-tsens
               - qcom,sdm845-tsens
           - const: qcom,tsens-v2
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

