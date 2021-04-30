Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7B36FC6E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhD3OaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 10:30:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24023 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233437AbhD3OaI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Apr 2021 10:30:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619792960; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9zi1Tsu0QMPHkbhFNxaXa6idnL/BacHLa+H3Pmpe8Ck=; b=gWzzAg9qh+2dguCYPzL0DjeHGzzjjR4wrVW7zNDPZl4qdn974MGmP1hyb2Vqt6hHYajOX9Ke
 61VS4i/Y/7YEFGiKIHhg+nM11ySHQNjIBBzgg9AS4jy7YBQJS3CBWrJPMHmAW/uJmBT8i/zg
 6WwpoLU+yivD+RKYNqhTj2BzylE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 608c142d2cc44d3aea555f48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Apr 2021 14:29:01
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2586C43217; Fri, 30 Apr 2021 14:29:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66BDFC433D3;
        Fri, 30 Apr 2021 14:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66BDFC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, swboyd@chromium.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/2] DDR/L3 Scaling support on SC7280 SoCs
Date:   Fri, 30 Apr 2021 19:58:19 +0530
Message-Id: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch series adds support for DDR/L3 Scaling on SC7280 SoCs.

Depends on the following patch series:
L3 Provider Support: https://lore.kernel.org/lkml/1618556290-28303-1-git-send-email-okukatla@codeaurora.org/
CPUfreq Support: https://lore.kernel.org/lkml/1618020280-5470-2-git-send-email-tdas@codeaurora.org/
RPMH Provider Support: https://lore.kernel.org/lkml/1619517059-12109-1-git-send-email-okukatla@codeaurora.org/

It also depends on L3 and cpufreq dt nodes from the ^^ series to not have
overlapping memory regions.

Sibi Sankar (2):
  cpufreq: blacklist SC7280 in cpufreq-dt-platdev
  arm64: dts: qcom: sc7280: Add cpu OPP tables

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 135 +++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   1 +
 2 files changed, 136 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

