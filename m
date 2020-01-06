Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC391312EC
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 14:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgAFNaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 08:30:11 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:9007 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgAFNaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 08:30:10 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Jan 2020 19:00:00 +0530
Received: from c-rkambl-linux1.qualcomm.com ([10.242.50.190])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Jan 2020 18:59:37 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 7E5BE11E4; Mon,  6 Jan 2020 18:59:36 +0530 (IST)
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
Subject: [PATCH v2 0/2] Add critical interrupt and cooling maps for TSENS in SC7180 and configuration in yaml
Date:   Mon,  6 Jan 2020 18:59:27 +0530
Message-Id: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added critical interrupt support in TSENS node and cooling maps in Thermal-zones node
and configuration for SC7180 in yaml.

changes in v2:
* Removed renamings from thermal-zones.

Rajeshwari (2):
  arm64: dts: qcom: sc7180: Add critical interrupt and cooling maps for
    TSENS in SC7180
  dt-bindings: thermal: tsens: Add configuration in yaml

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 197 ++++++++++++++++++++-
 2 files changed, 194 insertions(+), 4 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

