Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B579AA2A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405182AbfHWITV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:19:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfHWITV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:19:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF62761516; Fri, 23 Aug 2019 08:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548360;
        bh=vFwga+0IfhrFsfBYhg/cHAIL5p0BsKH8JyMfnbxIjyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0TNK/8x7x3o52rGZNsIPeSKkCzkUs/MwiBvSaniE0BVJh/zsBiXwFyUJkqJxn1AL
         mymMqoX3Ha80hUcf5dt3hEKh4pt+NBcAwJobLNMtr2CUgYGd9W1Py8dHWtqQdgtQPL
         txZkSOJDpto4VK8sxX/0SwyhNxsElPKNFuRNyQZg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 725C4614DC;
        Fri, 23 Aug 2019 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548358;
        bh=vFwga+0IfhrFsfBYhg/cHAIL5p0BsKH8JyMfnbxIjyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSCwredS855Uk/ETPwO5bF/kNrXerdPvOdnNpZUurt0yO5L29oUl47ry+8ZgMtIhD
         RnwEINdIj4vaLj/xkr6lqM4Ct35TeuB/j7lBTujz1zDljEwXprZ2xa6nqp/slkibsS
         RKVKJ7gVzZiM3oHrp5MEbuvA9pAfqznkE2Ip98l8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 725C4614DC
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
Subject: [PATCH v2 6/6] arm64: dts: Add rsc power domain for sdm845
Date:   Fri, 23 Aug 2019 13:47:03 +0530
Message-Id: <20190823081703.17325-7-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823081703.17325-1-mkshah@codeaurora.org>
References: <20190823081703.17325-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add rsc power domain to enable sending sleep and wake votes
using generic power domain infrastructure.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0e7f36d2a7d9..1ea61464e666 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -669,6 +669,7 @@
 
 		CLUSTER_PD: cluster-pd {
 			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
 			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
@@ -2587,6 +2588,7 @@
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			#power-domain-cells = <0>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

