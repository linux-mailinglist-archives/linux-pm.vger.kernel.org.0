Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0C3581E6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhDHLca (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:32:30 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40502 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHLc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 07:32:28 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Apr 2021 04:32:18 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Apr 2021 04:32:15 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Apr 2021 17:01:38 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id D3D76448F; Thu,  8 Apr 2021 17:01:37 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, satya priya <skakit@codeaurora.org>
Subject: [PATCH V2 2/4] dt-bindings: input: pm8941-pwrkey: add pmk8350 compatible strings
Date:   Thu,  8 Apr 2021 17:01:07 +0530
Message-Id: <1617881469-31965-3-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Add power key and resin compatible strings for the PMK8350 PMIC.
These are needed to distinguish key PON_HLOS register differences
between PMK8350 and previous PMIC PON modules.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: satya priya <skakit@codeaurora.org>
---
Chnages in V2:
 - Moved this patch before the conversion patches.

 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
index 34ab576..6cd08bc 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -8,6 +8,8 @@ PROPERTIES
 	Definition: must be one of:
 		    "qcom,pm8941-pwrkey"
 		    "qcom,pm8941-resin"
+		    "qcom,pmk8350-pwrkey"
+		    "qcom,pmk8350-resin"
 
 - reg:
 	Usage: required
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

