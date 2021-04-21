Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D543366A17
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbhDULpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 07:45:16 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27473 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhDULpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 07:45:16 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Apr 2021 04:44:43 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Apr 2021 04:44:41 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Apr 2021 17:14:07 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id B6ECD4828; Wed, 21 Apr 2021 17:14:06 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH V1 0/2] ARM: dts: qcom:  Add device node support for TSENS in SC7280.
Date:   Wed, 21 Apr 2021 17:14:00 +0530
Message-Id: <1619005442-16485-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add TSENS node, user thermal zone configurations, critical interrupt,
cooling maps and configuration in yaml for TSENS in SC7280.

Dependencies:
https://lore.kernel.org/patchwork/project/lkml/list/?series=487403
https://lore.kernel.org/patchwork/patch/1410952/

Rajeshwari (2):
  ARM: dts: qcom:  Add device node support for TSENS in SC7280.
  dt-bindings: thermal: tsens: Add configuration in yaml

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 874 +++++++++++++++++++++
 2 files changed, 875 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

