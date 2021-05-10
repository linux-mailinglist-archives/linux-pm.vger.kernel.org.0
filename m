Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C6377CCD
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEJHDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 03:03:12 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61182 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJHDL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 03:03:11 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 May 2021 00:02:07 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 May 2021 00:02:05 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 May 2021 12:31:20 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id BF4374F18; Mon, 10 May 2021 12:31:19 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V3 3/5] dt-bindings: power: reset: Change 'additionalProperties' to true
Date:   Mon, 10 May 2021 12:31:02 +0530
Message-Id: <1620630064-16354-4-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change 'additionalProperties' to true as this is a generic binding.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
Changes in V3:
 - This is newly added in V3.

 Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index 9c6fda6..ad0a0b9 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -36,7 +36,7 @@ patternProperties:
   "^mode-.*$":
     $ref: /schemas/types.yaml#/definitions/uint32
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

