Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA808248E46
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHRSzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 14:55:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53045 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbgHRSyo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 14:54:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597776883; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vfiuCTct4hAHdpafOBx0+18YNtmCRa6E9a+yCwaEzcU=; b=Azbz45FQcXObhI8ECC9G9Mb6STvULOPGTyBayytk//S1UGt2QFgibOyRZLCoqL4cLEUGnu9+
 0HFCcisRAazG2rS4ySWd/IcgcCE9l2TQMvF9FtlTLryuluoqI0JTfZwDYCfnLwF0euMSsXN/
 deS9WT4tdESikOLGlJBoY287PcA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f3c23e0f2b697637a94b24d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 18:54:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8DA6C43395; Tue, 18 Aug 2020 18:54:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F28BCC433CA;
        Tue, 18 Aug 2020 18:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F28BCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [RESEND PATCH v1 0/4] Support spaces in reboot mode framework
Date:   Tue, 18 Aug 2020 11:54:12 -0700
Message-Id: <1597776856-12014-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resending with updated recepients and cover subject.

PM8150 uses reboot-mode framework to set magic values for bootloader to read
during next boot. dm-verity wants to use "dm-verity device corrupted" [1] as
the restart command, however the reboot-mode framework does not support spaces
in the command line as devicetree property names cannot have spaces. In order
to support the PM8150 comamnds, this patch series adds two new optional array
properties to reboot-mode framework: reboot-mode-names and reboot-mode-magic.
The arrays supply the commands and magic values, respectively.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-verity-target.c?h=v5.5#n255

Elliot Berman (4):
  dt-bindings: power: reset: Convert reboot-mode to YAML
  dt-bindings: power: reset: Add alternate reboot mode format
  power: reset: Add support for reboot mode alternate properties
  arm64: dts: qcom: pm8150: Add reboot magic

 .../bindings/power/reset/reboot-mode.txt           | 25 ---------
 .../bindings/power/reset/reboot-mode.yaml          | 64 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8150.dtsi               |  5 ++
 drivers/power/reset/reboot-mode.c                  | 42 +++++++++++++-
 4 files changed, 110 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.yaml

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

