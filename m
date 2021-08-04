Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3513DFFB3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhHDK6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 06:58:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47736 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237568AbhHDK6q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Aug 2021 06:58:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628074713; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1yEyx4zDCThfGh0MKzJPsMlxXnL6JvXOTClEMfzJDsY=; b=GVIVGZW07VHZwA3pBaShArJSnvmxcS7MEeHn4rnyX+rM2ADYriph2O1xZh8fmPZ3L7MFu5Km
 RVbW4HLP8O+gXdNMaZkAiH3q77MTwamz9S/4fxFkmcLHYgRzs6JGbrkMOVgZsZY7OljjPf7O
 ZFk9QxE39KZPW4QkCcrl71UGkpw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 610a72d9ad1af63949071d16 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 10:58:33
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B0C9C43217; Wed,  4 Aug 2021 10:58:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81D32C433F1;
        Wed,  4 Aug 2021 10:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81D32C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 0/2] PM / Domains: Add support for 'required-opps' to set default perf state
Date:   Wed,  4 Aug 2021 16:28:14 +0530
Message-Id: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v6: Fixed up some more error handling in __genpd_dev_pm_attach()

v5: Dropped all default_pstate handling in runtime suspend/resume

v4: Fixed error handling in __genpd_dev_pm_attach()

This is a re-spin of the series [1] which was adding support for a new
DT binding (assigned-performance-state) and based on the discussions on
that thread [2] it was concluded that we could achieve the same with the
existing 'required-opps' binding instead.

So this series, just drops the new binding and uses required-opps to achieve
the default perf state setting thats needed by some devices.

---
Some devics within power-domains with performance states do not
support DVFS, but still need to vote on a default/static state
while they are active. Add support for this using the 'required-opps'
property in device tree.

[1] https://lore.kernel.org/patchwork/project/lkml/list/?series=501336&state=%2A&archive=both
[2] https://lore.kernel.org/patchwork/patch/1436886/

Rajendra Nayak (2):
  PM / Domains: Add support for 'required-opps' to set default perf
    state
  arm64: dts: sc7180: Add required-opps for i2c

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 24 ++++++++++++++++++++++++
 drivers/base/power/domain.c          | 28 ++++++++++++++++++++++++++--
 include/linux/pm_domain.h            |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

