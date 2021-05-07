Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8677B37600D
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 08:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhEGGJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 02:09:14 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:26424 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGGJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 02:09:13 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 May 2021 23:08:14 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 May 2021 23:08:11 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 May 2021 11:37:36 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 418E448DF; Fri,  7 May 2021 11:37:35 +0530 (IST)
From:   Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
Subject: [PATCH V4 0/3] Add DT bindings and device tree nodes for TSENS in SC7280
Date:   Fri,  7 May 2021 11:37:18 +0530
Message-Id: <1620367641-23383-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding compatible string in TSENS dt-bindings, device node for TSENS controller and 
critical interrupt support, Thermal zone support and cooling maps.

Changes:- 

[PATCH V4 1/3]:- no changes.
[PATCH V4 2/3]:- no changes.
[PATCH V4 3/3]:- Changed node name from cpu_crit to cpu-crit under thermal-zones.

Dependencies:
https://lore.kernel.org/patchwork/project/lkml/list/?series=487403
https://lore.kernel.org/patchwork/patch/1410952/

Rajeshwari Ravindra Kamble (3):
  dt-bindings: thermal: tsens: Add compatible string to TSENS binding
    for SC7280
  arm64: dts: qcom: SC7280: Add device node support for TSENS
  arm64: dts: qcom: SC7280: Add thermal zone support

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 874 +++++++++++++++++++++
 2 files changed, 875 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

