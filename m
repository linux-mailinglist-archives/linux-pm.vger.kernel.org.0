Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B071D234CCA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgGaVOg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 17:14:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26530 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgGaVOf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 17:14:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596230075; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dURvjg+v1UCqBQ4hlCLmLOVZo/34TjDJA5WmTO9SFL8=; b=VUOulxi+y5X6mHPtfdp6MK73XyGu+cQfHjiVw282AFolzfvdaqfTp35c0HfrL9+CpIY/poAr
 MuySEtOUAfPOP96JnoU+2eb8/5Q/jhjAue+GhW5TuemACNrr66BJE8GgyVW+yDdMEFW/UYEO
 CG2qdXjQC3yoCIwivlWPQVJ4Hyc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f2489b2d2bd131f680e1a8b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 21:14:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C151DC433CA; Fri, 31 Jul 2020 21:14:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C71D7C433CA;
        Fri, 31 Jul 2020 21:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C71D7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 0/4] Add restart commands for PM8150
Date:   Fri, 31 Jul 2020 14:14:16 -0700
Message-Id: <1596230060-6065-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PM8150 uses reboot-mode framework to set magic values for bootloader to read
during next boot. dm-verity wants to use "dm-verity device corrupted" [1] as
the restart command, however the reboot-mode framework does not support spaces
in the command line as devicetree property names cannot have spaces. This
patch series adds two new optional array properties to reboot-mode framework: 
reboot-mode-names and reboot-mode-magic. The arrays supply the commands and 
magic values, respectively.

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

