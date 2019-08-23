Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A859AA1C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbfHWIS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:18:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732778AbfHWIS5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:18:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8434861344; Fri, 23 Aug 2019 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548336;
        bh=UABwReuV4uLf5XPJeD7w3YQaYU9rOM7wgslH6gRuocE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iz2ah46LzHbSJG5ukp75O3QWACKIMoBaeWNYpbYheUtK3IMh6aepPQA5ehKcYCkk9
         MIPFjzK+GiJAR4xIiiZdvn9s7utkShUWyvjQ/0TaxG+7WmTdiKDXZoyrL+w0y61pcN
         dz4LTWnmo1oZaddySx2t9r4+i8V/av9y0lzIavOY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CDE761231;
        Fri, 23 Aug 2019 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548334;
        bh=UABwReuV4uLf5XPJeD7w3YQaYU9rOM7wgslH6gRuocE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k30Xn9JBc+s0ckEh2xby+H7xQI7sJuwKgAZlmRHOPBBG9qmF2ZrWuTeAzHKEGVs+e
         ATHGNGHixIJDvM2MYeSUlVxHsqZ5YQecWh1f1hBHqS0rU/sp25VPVtWtlexKYo7dmU
         vUVha8morEyXbCj5HlOZz3KvMAb0yWiRmKgYQIMU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CDE761231
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: soc: qcom: Add RSC power domain specifier
Date:   Fri, 23 Aug 2019 13:47:00 +0530
Message-Id: <20190823081703.17325-4-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823081703.17325-1-mkshah@codeaurora.org>
References: <20190823081703.17325-1-mkshah@codeaurora.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
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

