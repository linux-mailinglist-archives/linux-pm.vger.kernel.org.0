Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AB37B5BB
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhELGQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 02:16:33 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53424 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhELGQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 02:16:30 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2021 23:15:23 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 May 2021 23:15:21 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 May 2021 11:44:39 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 676D3488F; Wed, 12 May 2021 11:44:38 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V4 0/5] Add support for PMK8350 PON_HLOS PMIC peripheral
Date:   Wed, 12 May 2021 11:44:08 +0530
Message-Id: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

David Collins (2):
  input: pm8941-pwrkey: add support for PMK8350 PON_HLOS PMIC peripheral
  dt-bindings: input: pm8941-pwrkey: add pmk8350 compatible strings

satya priya (3):
  dt-bindings: power: reset: Change 'additionalProperties' to true
  dt-bindings: input: pm8941-pwrkey: Convert pm8941 power key binding to
    yaml
  dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml

 .../bindings/input/qcom,pm8941-pwrkey.txt          |  53 -----------
 .../bindings/input/qcom,pm8941-pwrkey.yaml         |  51 ++++++++++
 .../devicetree/bindings/power/reset/qcom,pon.txt   |  49 ----------
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  80 ++++++++++++++++
 .../bindings/power/reset/reboot-mode.yaml          |   2 +-
 drivers/input/misc/pm8941-pwrkey.c                 | 103 ++++++++++++++-------
 6 files changed, 204 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

