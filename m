Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5590C37B792
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 10:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhELING (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 04:13:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:32369 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhELING (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 04:13:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620807118; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=z0fHUZecSYuqWomka6fjDkY05S5ZCmTD18gCyAwIM1E=; b=SikBjwnyId4WbD6Yq5UFem+v0IdyiYRzEZ6W6H0BEKF41VNSs/as31Uz2SvBopCYybGJhzX/
 AZMqvdfKwjOd+Gq5Z5MfHEzsYY3gP1zw+UWcW6M5tw1Et8fmM5fDf0NbzvRU8dv35JvdBbY0
 Q7VG1lK9Jny8j8v2cKMjzzPEaTE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 609b8db9938a1a6b8f0b6ecc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 May 2021 08:11:37
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7677C43143; Wed, 12 May 2021 08:11:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76454C433F1;
        Wed, 12 May 2021 08:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76454C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, dianders@chromium.org, mka@chromium.org
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 0/2] DDR/L3 Scaling support on SC7280 SoCs
Date:   Wed, 12 May 2021 13:41:21 +0530
Message-Id: <1620807083-5451-1-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch series adds support for DDR/L3 Scaling on SC7280 SoCs.

V3:
 * Rename opp table nodes [Matthias]
 * Rename opp phandles [Doug]

V2:
 * Add a new opp table for cpu 7 to account for the additional frequencies
   supported by it.

Depends on the following patch series:
L3 Provider Support: https://lore.kernel.org/lkml/1618556290-28303-1-git-send-email-okukatla@codeaurora.org/
CPUfreq Support: https://lore.kernel.org/lkml/1618020280-5470-2-git-send-email-tdas@codeaurora.org/
RPMH Provider Support: https://lore.kernel.org/lkml/1619517059-12109-1-git-send-email-okukatla@codeaurora.org/

It also depends on L3 and cpufreq dt nodes from the ^^ series to not have
overlapping memory regions.

Sibi Sankar (2):
  cpufreq: blacklist SC7280 in cpufreq-dt-platdev
  arm64: dts: qcom: sc7280: Add cpu OPP tables

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 215 +++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   1 +
 2 files changed, 216 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

