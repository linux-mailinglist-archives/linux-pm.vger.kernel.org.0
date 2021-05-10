Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08847377CD0
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhEJHDO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 03:03:14 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61182 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhEJHDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 03:03:12 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 May 2021 00:02:07 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 May 2021 00:02:05 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 May 2021 12:31:20 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 6EB814B37; Mon, 10 May 2021 12:31:19 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V3 0/5] Add support for PMK8350 PON_HLOS PMIC peripheral
Date:   Mon, 10 May 2021 12:30:59 +0530
Message-Id: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
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
 .../bindings/input/qcom,pm8941-pwrkey.yaml         |  87 +++++++++++++++++
 .../devicetree/bindings/power/reset/qcom,pon.txt   |  49 ----------
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  44 +++++++++
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

