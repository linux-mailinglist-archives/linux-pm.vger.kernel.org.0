Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978DE153096
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBEM0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:26:55 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:57745 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727963AbgBEM0y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 07:26:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580905614; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hzVPZL4VtKtArOeylhakFEa12U0ksSDJ+F88Oy/mtJc=; b=FVbvESaW3DVOAgfWAsKNnZitwT4pekSYPj3Avc3ylMewO/bGbhJfpHL+DJoc4RC62Q93W1FY
 Zt/B1GX+JkW0lLmZZPl1RXIQOnYcDIk9EYPa6/3uNbY+4Ol8b3doeLZwS506vVmNLFgT5XqO
 EH0cFCW+o1RxHdrEAvi2CV20OZ8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ab48a.7f25d7f70f10-smtp-out-n02;
 Wed, 05 Feb 2020 12:26:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E10BCC447AC; Wed,  5 Feb 2020 12:26:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EFB2C447A5;
        Wed,  5 Feb 2020 12:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EFB2C447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 3/6] dt-bindings: soc: qcom: Add RSC power domain specifier
Date:   Wed,  5 Feb 2020 17:56:09 +0530
Message-Id: <1580905572-22712-4-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
References: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In addition to transmitting resource state requests to the remote
processor, the RSC is responsible for powering off/lowering the
requirements from CPUs subsystem for the associated hardware like
buses, clocks, and regulators when all CPUs and cluster is powered down.

The power domain is configured to a low power state and when all the
CPUs are powered down, the RSC can lower resource state requirements
and power down the rails that power the CPUs.

Add PM domain specifier property for RSC controller.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
index 9b86d1e..5682806 100644
--- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
@@ -83,6 +83,14 @@ Properties:
 	Value type: <string>
 	Definition: Name for the RSC. The name would be used in trace logs.
 
+- #power-domain-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: Must be 0. Number of cells in power domain specifier.
+		    Optional for controllers that may be in 'solver' state
+		    where they can be in autonomous mode executing low power
+		    modes.
+
 Drivers that want to use the RSC to communicate with RPMH must specify their
 bindings as child nodes of the RSC controllers they wish to communicate with.
 
@@ -112,6 +120,7 @@ TCS-OFFSET: 0xD00
 				  <SLEEP_TCS   3>,
 				  <WAKE_TCS    3>,
 				  <CONTROL_TCS 1>;
+		#power-domain-cells = <0>;
 	};
 
 Example 2:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
