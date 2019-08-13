Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B244C8B25F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfHMI0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 04:26:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfHMI0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 04:26:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F10F609F3; Tue, 13 Aug 2019 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684783;
        bh=xzOhyFf1Lb46S8iAihNlSdA4LL0HPldY24aFh3YUK0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeOOay96bcbwlqWp+6qJ6shCorX7S6h6RJKWfoaXikBl9vI399ZUn7MSJH7zGL1tp
         HxMvM7zDbl8BHQBXjEF9zaY4VcJSSSmlCGiPQCmsp5SqASOeFVQdpVXjOZztzh3Ie1
         f5pJJoXBqL+DSFX8VZ8Rd11J5GIQKtjSsvdprcLs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A289760A4E;
        Tue, 13 Aug 2019 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684780;
        bh=xzOhyFf1Lb46S8iAihNlSdA4LL0HPldY24aFh3YUK0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frBfUD6bqYpPrAXTVl7+FVgCxgJkq800lMJIBKph9xa7tOJKG9IUZpYDRyxYYiSl/
         DGFC2vowty5hzFbo3sdYtaJia4K7iEgYyfOnzoHjn1uRQoNs+tjSAGkENMuP8cuJoy
         0l872hgv7nLbRxWlzTBuz27/9hjrDRnQe371WGLU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A289760A4E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: soc: qcom: Add RSC power domain specifier
Date:   Tue, 13 Aug 2019 13:54:41 +0530
Message-Id: <20190813082442.25796-4-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813082442.25796-1-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
index 9b86d1eff219..d0ab6e9b6745 100644
--- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
@@ -83,6 +83,13 @@ Properties:
 	Value type: <string>
 	Definition: Name for the RSC. The name would be used in trace logs.
 
+- #power-domain-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: Number of cells in power domain specifier. Optional for
+		    controllers that may be in 'solver' state where they can
+		    be in autonomous mode executing low power modes.
+
 Drivers that want to use the RSC to communicate with RPMH must specify their
 bindings as child nodes of the RSC controllers they wish to communicate with.
 
@@ -112,6 +119,7 @@ TCS-OFFSET: 0xD00
 				  <SLEEP_TCS   3>,
 				  <WAKE_TCS    3>,
 				  <CONTROL_TCS 1>;
+		#power-domain-cells = <0>;
 	};
 
 Example 2:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

