Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21E1F01C0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFEVdv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 17:33:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15917 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbgFEVdu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 17:33:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591392830; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=IAHtev+drdjHORDurNRZb9RBH0LS4soHB+6HHbpezn4=; b=c+XsN+NvqhUVkew+gbaUGVSTNhQLcH+MW8j6lH/uYwcGanN0Mz/x7V+H7D5/iqeiTrAS4lq2
 u8Hzwjb+U1r6bzwJ9Mp3Om1G0NivEOntD0RweJebbKldjNomkGHbAyBoyNLlu4RVpI8dWutU
 3uEdyTOPf/oR8Mcm5n3W5k2j+QU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5edaba3d2c549984755f608b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Jun 2020 21:33:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BCB36C43395; Fri,  5 Jun 2020 21:33:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A5F8C433C6;
        Fri,  5 Jun 2020 21:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A5F8C433C6
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
Date:   Sat,  6 Jun 2020 03:03:27 +0530
Message-Id: <20200605213332.609-1-sibis@codeaurora.org>
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

Based on Viresh's opp-next:
https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next

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

