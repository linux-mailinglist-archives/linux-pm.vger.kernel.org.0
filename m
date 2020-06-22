Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3212031D7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgFVIRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 04:17:12 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18511 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgFVIRL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 04:17:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592813830; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=JqD4rQ/7H9u9A4vYuO3dpeXtRmsDu9f2oa3njpuXPM0=; b=pLd5L6MnvB8mpKjNRQRZ//WdbkN9GFbVLJz+Gxp/Ko4rCJDrrKc5o1jzj5UqOtJog2oWcjba
 oWOZt5Y41dbqwdPH82NjuWS6Fh/V+za1UOm+DTwXqaKtpZHZwFDfRRV+cbOwIInR+7OhUgAr
 ++MeRoPVlJR3iWCtGdy4KUuz26Q=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ef069036f2ee827da32b72f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 08:17:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A68D4C433C6; Mon, 22 Jun 2020 08:17:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F84BC433CA;
        Mon, 22 Jun 2020 08:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F84BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, smasetty@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v6 0/5] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Date:   Mon, 22 Jun 2020 13:46:44 +0530
Message-Id: <20200622081649.27280-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series aims to extend cpu based scaling support to L3/DDR on
SDM845 and SC7180 SoCs.

Patches [1-2] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
Patches [3-5] - Update bw levels based on cpu frequency change

V7:
 * Fixup comments for correctness [Matthias]
 * Initialize icc_scaling_enabled to false [Matthias]
 * Make use of the increased per line character limit [Matthias]

V6:
 * Add global flag to distinguish between voltage update and opp add.
   Use the same flag before trying to scale ddr/l3 bw [Viresh]
 * Use dev_pm_opp_find_freq_ceil to grab all opps [Viresh] 
 * Move dev_pm_opp_of_find_icc_paths into probe [Viresh]

V5:
 * Pick up R-bs from Amit
 * Drop icc tag support/dt changes till the a consensus is achieved
 * Use dev_pm_opp_adjust_voltage instead [Viresh]
 * Drop dev_pm_opp_get_path_count [Saravana]
 * Rework dev_pm_opp_set_bw

V4:
 * Migrate to using Georgi's new bindings
 * Misc fixups based on Matthias comments
 * API fixups based on Bjorn's comments on v2
 * Picked up a few R-bs from Matthias

v3:
 * Migrated to using Saravana's opp-kBps bindings [1]
 * Fixed some misc comments from Rajendra
 * Added support for SC7180

v2:
 * Incorporated Viresh's comments from:
 https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
 https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
 * Dropped cpufreq-map passive governor

Sibi Sankar (5):
  cpufreq: blacklist SDM845 in cpufreq-dt-platdev
  cpufreq: blacklist SC7180 in cpufreq-dt-platdev
  OPP: Add and export helper to set bandwidth
  cpufreq: qcom: Update the bandwidth levels on frequency change
  cpufreq: qcom: Disable fast switch when scaling DDR/L3

 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +
 drivers/cpufreq/qcom-cpufreq-hw.c    | 86 ++++++++++++++++++++++++++--
 drivers/opp/core.c                   | 31 ++++++++++
 include/linux/pm_opp.h               |  6 ++
 4 files changed, 121 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

