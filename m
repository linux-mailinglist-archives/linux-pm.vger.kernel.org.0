Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0613E332472
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCILvl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 06:51:41 -0500
Received: from z11.mailgun.us ([104.130.96.11]:25830 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCILvf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 06:51:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615290695; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YN9fzJ1SDHQH0Lz+TGW/8aZRxsC+jESqxCAq0M5A/dE=; b=G/Xq8khKI7M/qxsU6yYu+Orp2rCdiUq06D/ca3Avkvgh3xDjRwdZT0Tr3Lnxe1TQe/XXCwHi
 5tXW80YlKdAsAwNypD3eUxw4s02aO4uDbWCcYxg84L6dHJgwUJM+MFWoxg+2VWT3bXKyx4K2
 DrvJwwy/hiK/DKk5FdMHXfh6j2o=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60476145fcddd4bda6546c93 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 11:51:33
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DD1AC433ED; Tue,  9 Mar 2021 11:51:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CF46C433C6;
        Tue,  9 Mar 2021 11:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CF46C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [0/3] Add SC7280 interconnect provider driver 
Date:   Tue,  9 Mar 2021 17:20:06 +0530
Message-Id: <1615290609-21009-1-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on
the SC7280-based platforms.

[1] https://lore.kernel.org/patchwork/cover/1389010/
The series depends on ^^

Odelu Kukatla (3):
  dt-bindings: interconnect: Add Qualcomm SC7280 DT bindings
  interconnect: qcom: Add SC7280 interconnect provider driver
  arm64: dts: sc7280: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,rpmh.yaml           |   12 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   88 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sc7280.c                 | 1918 ++++++++++++++++++++
 drivers/interconnect/qcom/sc7280.h                 |  152 ++
 include/dt-bindings/interconnect/qcom,sc7280.h     |  163 ++
 7 files changed, 2344 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sc7280.c
 create mode 100644 drivers/interconnect/qcom/sc7280.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

