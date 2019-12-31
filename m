Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB112D730
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 09:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfLaI7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 03:59:19 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:56788 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfLaI7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 03:59:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577782758; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jtFpi8V2xnwBVO1X5DbVIdxcfrA+MlrmjIybWkRqf9o=; b=QQS7VPqP1xpNDoK/0qzgH9VU09CK9SfNZ7slBnNVyQIZX1DrGkswBEbKUq0YKK4bbSJuq4D+
 qIz+Ccl02K1Ku1wOQtOEGIAL5gqDGldvLD+HjNZ8e1AXrOIUhbDnnR7Kd+cQ4QGsD8NVOaBD
 g79Jp+1Wrdi42fN58IsFpsfZzCs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b0de5.7f3405f9ec38-smtp-out-n02;
 Tue, 31 Dec 2019 08:59:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 158C2C4479F; Tue, 31 Dec 2019 08:59:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93547C43383;
        Tue, 31 Dec 2019 08:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93547C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [V2, 0/3] Add SC7180 interconnect provider driver
Date:   Tue, 31 Dec 2019 14:28:54 +0530
Message-Id: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on
the SC7180-based platforms.

Depends-on: interconnect: qcom: sdm845: Walk the list safely on node removal
Depends-on: Walk the list safely on node removal
Depends-on: Add device tree support for sc7180

Odelu Kukatla (3):
  dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
  interconnect: qcom: Add SC7180 interconnect provider driver
  arm64: dts: sc7180: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
 .../bindings/interconnect/qcom,sc7180.yaml         | 155 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  96 +++
 drivers/interconnect/qcom/Kconfig                  |  10 +
 drivers/interconnect/qcom/Makefile                 |   2 +
 drivers/interconnect/qcom/bcm-voter.c              |   1 +
 drivers/interconnect/qcom/sc7180.c                 | 787 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sc7180.h     | 161 +++++
 8 files changed, 1213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 drivers/interconnect/qcom/sc7180.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
