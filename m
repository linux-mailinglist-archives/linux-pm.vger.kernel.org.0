Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7336F873
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhD3KbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 06:31:19 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32283 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 06:31:18 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 30 Apr 2021 03:30:30 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Apr 2021 03:30:28 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg02-blr.qualcomm.com with ESMTP; 30 Apr 2021 15:59:55 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 05421488D; Fri, 30 Apr 2021 15:59:54 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH V3 1/3] dt-bindings: thermal: tsens: Add compatible string to TSENS binding for SC7280
Date:   Fri, 30 Apr 2021 15:59:50 +0530
Message-Id: <1619778592-8112-2-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619778592-8112-1-git-send-email-rkambl@codeaurora.org>
References: <1619778592-8112-1-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding compatible string in TSENS dt-bindings for SC7280.

Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b7a832f..23cf265 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -46,6 +46,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,sc7180-tsens
+              - qcom,sc7280-tsens
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

