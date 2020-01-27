Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBF14AACA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0UEJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:04:09 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:25529 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbgA0UEJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:04:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155448; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=QQkEgPnxmrptI1lZyJpzKW7DPznWJqntmF4wRA+2Cmo=; b=vzEk6tahfjsHg8lwd7M3m2NkQQ4PjUjt02fBqfTP1iBOeXHCpHG3um4MjMeKEG026RaVdM8S
 vGhcv9iqdDBCwUPhkuG7yhFQUhVgoqkrdGWKbefo5X0aHScTvK9PVWapyFdrUNX27vPQLjRk
 M3I8Dg5aEXXJFEhfZHo2wq9pbxc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f4235.7fc27dbecf80-smtp-out-n03;
 Mon, 27 Jan 2020 20:04:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65019C447A3; Mon, 27 Jan 2020 20:04:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88E2DC433CB;
        Mon, 27 Jan 2020 20:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88E2DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Date:   Tue, 28 Jan 2020 01:33:40 +0530
Message-Id: <20200127200350.24465-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This RFC series aims to extend cpu based scaling support to L3/DDR on
SDM845 and SC7180 SoCs.

Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
Patches [5-7] - Hack in a way to add/remove multiple opp tables to
                a single device. I am yet to fix the debugfs to
		support multiple opp_tables per device but wanted to
		send what was working upstream to get an idea if multiple
		opp tables per device is a feature that will be useful
		upstream.
Patches [9-10] - Add the cpu/cpu-ddr/cpu-l3 opp tables for SDM845
                 and SC7180 SoCs.

v3:
 * Migrated to using Saravana's opp-kBps bindings [1]
 * Fixed some misc comments from Rajendra
 * Added support for SC7180

v2:
 * Incorporated Viresh's comments from:
 https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
 https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
 * Dropped cpufreq-map passive governor

Git-branch: https://github.com/QuinAsura/linux/tree/lnext-012420

Some alternate ways of hosting the opp-tables:
https://github.com/QuinAsura/linux/commit/50b92bfaadc8f9a0d1e12249646e018bd6d1a9d3
https://github.com/QuinAsura/linux/commit/3d23d1eefd16ae6d9e3ef91e93e78749d8844e98
Viresh didn't really like ^^ bindings and they dont really scale well. Just
including them here for completeness.

Depends on the following series:
[1] https://patchwork.kernel.org/cover/11277199/
[2] https://patchwork.kernel.org/cover/11055499/ 
[3] https://patchwork.kernel.org/cover/11326381/

Sibi Sankar (10):
  arm64: dts: qcom: sdm845: Add SoC compatible to MTP
  cpufreq: blacklist SDM845 in cpufreq-dt-platdev
  cpufreq: blacklist SC7180 in cpufreq-dt-platdev
  OPP: Add and export helper to update voltage
  opp: of: export _opp_of_get_opp_desc_node
  opp: Allow multiple opp_tables to be mapped to a single device
  opp: Remove multiple attached opp tables from a device
  cpufreq: qcom: Update the bandwidth levels on frequency change
  arm64: dts: qcom: sdm845: Add cpu OPP tables
  arm64: dts: qcom: sc7180: Add cpu OPP tables

 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 287 +++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 453 ++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c    |   2 +
 drivers/cpufreq/qcom-cpufreq-hw.c       | 246 +++++++++++--
 drivers/opp/core.c                      | 111 +++++-
 drivers/opp/of.c                        |   3 +-
 drivers/opp/opp.h                       |   2 +
 include/linux/pm_opp.h                  |  10 +
 9 files changed, 1083 insertions(+), 33 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
