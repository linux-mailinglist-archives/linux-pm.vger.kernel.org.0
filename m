Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE112965F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 14:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLWNQo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 08:16:44 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:64670 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbfLWNQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 08:16:44 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Dec 2019 18:45:12 +0530
Received: from c-rkambl-linux1.qualcomm.com ([10.242.50.190])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Dec 2019 18:44:46 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id B6463121E; Mon, 23 Dec 2019 18:44:45 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH 0/2] Add critical interrupt and cooling maps for TSENS in SC7180
Date:   Mon, 23 Dec 2019 18:44:29 +0530
Message-Id: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added critical interrupt support cooling maps support in SC7180 changed sensors 
name under thermal-zones and added configuration for SC7180 in yaml.

Rajeshwari (2):
  arm64: dts: qcom: sc7180:  Add critical interrupt and cooling maps for
    TSENS in SC7180.
  dt-bindings: thermal: tsens: Add configuration for sc7180 in yaml

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 289 +++++++++++++++++----
 2 files changed, 240 insertions(+), 50 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

