Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C833581EA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDHLcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:32:33 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3632 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhDHLc3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 07:32:29 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Apr 2021 04:32:18 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Apr 2021 04:32:14 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Apr 2021 17:01:34 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id EC98D448F; Thu,  8 Apr 2021 17:01:33 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, satya priya <skakit@codeaurora.org>
Subject: [PATCH V2 0/4] Add support for PMK8350 PON_HLOS PMIC peripheral
Date:   Thu,  8 Apr 2021 17:01:05 +0530
Message-Id: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

David Collins (2):
  input: pm8941-pwrkey: add support for PMK8350 PON_HLOS PMIC peripheral
  dt-bindings: input: pm8941-pwrkey: add pmk8350 compatible strings

satya priya (2):
  dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml
  dt-bindings: input: pm8941-pwrkey: Convert pm8941 power key binding to
    yaml

 .../bindings/input/qcom,pm8941-pwrkey.txt          |  53 -----------
 .../bindings/input/qcom,pm8941-pwrkey.yaml         |  88 ++++++++++++++++++
 .../devicetree/bindings/power/reset/qcom,pon.txt   |  49 ----------
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  41 ++++++++
 drivers/input/misc/pm8941-pwrkey.c                 | 103 ++++++++++++++-------
 5 files changed, 201 insertions(+), 133 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

