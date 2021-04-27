Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ACE36C220
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhD0JwX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 05:52:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:32456 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhD0JwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 05:52:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619517096; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mWcsOo9TMSuhJz30kQ7/zoSPXTnfufJlXXf5JolInNw=; b=bzdBUpxmS0DpkVN6L8wsNG4cbbJ5KYLKpKtWNBqEBM/hJTMHjdTXf9cTcENHl708CvvaZ48t
 nlUj5S/avaxbQtzqMF2d6gS6WDzN6LxP3gggLb7hEjleiSPiIOLEKly/XI6pHaw71u7qfUIG
 XtNqMR4B24/MhIyIKij789HNMpk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6087de97e0e9c9a6b6d75079 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 09:51:19
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8650FC4323A; Tue, 27 Apr 2021 09:51:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C023C433D3;
        Tue, 27 Apr 2021 09:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C023C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        sibis@codeaurora.org, elder@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [v2 0/3] Add SC7280 interconnect provider driver
Date:   Tue, 27 Apr 2021 15:20:55 +0530
Message-Id: <1619517059-12109-1-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on
the SC7280-based platforms.

v2:
 - Addressed review comments (Rob Herring)
 - Added interconnect paths for USB2 master and slave.
 
Odelu Kukatla (3):
  dt-bindings: interconnect: Add Qualcomm SC7280 DT bindings
  interconnect: qcom: Add SC7280 interconnect provider driver
  arm64: dts: sc7280: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,rpmh.yaml           |   12 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   88 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sc7280.c                 | 1938 ++++++++++++++++++++
 drivers/interconnect/qcom/sc7280.h                 |  154 ++
 include/dt-bindings/interconnect/qcom,sc7280.h     |  165 ++
 7 files changed, 2368 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sc7280.c
 create mode 100644 drivers/interconnect/qcom/sc7280.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

