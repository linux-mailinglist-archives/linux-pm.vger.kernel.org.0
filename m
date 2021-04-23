Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2436996E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbhDWSZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 14:25:32 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:65303 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbhDWSZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 14:25:29 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Apr 2021 11:24:52 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Apr 2021 11:24:50 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Apr 2021 23:54:16 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id A6BCF4845; Fri, 23 Apr 2021 23:54:15 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH V2 0/3] Add DT bindings and device tree nodes for TSENS in SC7280.
Date:   Fri, 23 Apr 2021 23:52:54 +0530
Message-Id: <1619202177-13485-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added compatible string in TSENS dt-bindings, device node for TSENS controller and 
critical interrupt support, Thermal zone support, cooling maps and added hysteresis
as zero as it is not needed for critical trip points.

Changes:
1) Added sensors according to sensor ID's under thermal-zones.
2) Added hysteresis as zero as it is not needed as system is supposed to shut down when critical point is reached.

Dependencies:
https://lore.kernel.org/patchwork/project/lkml/list/?series=487403
https://lore.kernel.org/patchwork/patch/1410952/

Rajeshwari (3):
  dt-bindings: thermal: tsens: Add compatible string to TSENS binding
    for SC7280
  ARM: dts: qcom: Add device node support for TSENS in SC7280.
  ARM: dts: qcom: Add Thermal zone support in SC7280.

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 866 +++++++++++++++++++++
 2 files changed, 867 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

