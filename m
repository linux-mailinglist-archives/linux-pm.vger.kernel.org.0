Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A715076C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBCNhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 08:37:23 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:59444 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727728AbgBCNhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 08:37:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580737042; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hzVPZL4VtKtArOeylhakFEa12U0ksSDJ+F88Oy/mtJc=; b=ulF8OvZYwgLqSHzc2RlCZ96HgdW2jxgRhfxNW+wpfx6WydSjRRAZUOWaUrRqI8Tfwl+gs+VY
 +t2aDv6VzR4Z8wfe5241PAu1AOun0buR20dxyWhmnGKpfkT1pmIAT/QS4MqNqWZydYbkkMc+
 DhQ7XfoEZpX4bTBftjd4heX2Vh8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e38220e.7fd29cc8ca08-smtp-out-n01;
 Mon, 03 Feb 2020 13:37:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19FF4C447AB; Mon,  3 Feb 2020 13:37:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6471C447A1;
        Mon,  3 Feb 2020 13:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6471C447A1
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
Subject: [PATCH v3 3/7] dt-bindings: soc: qcom: Add RSC power domain specifier
Date:   Mon,  3 Feb 2020 19:05:36 +0530
Message-Id: <1580736940-6985-4-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
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
