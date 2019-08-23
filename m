Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4679AA11
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbfHWISc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:18:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbfHWISc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:18:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C160608CC; Fri, 23 Aug 2019 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548310;
        bh=1GbHG78SpJmojCXUdDitKC6EvtNM7lX/s2bc+Panfa8=;
        h=From:To:Cc:Subject:Date:From;
        b=k4+9gztgTEKY8Slfd4OgSaJVM+hx9MLreb+6m5phqPyThV4A+Pa8L7LeeaTJlxDw2
         7mWfBtrkYy/mHLDRlBnbYfaaAy391o5CaXBCQwDvs9E0RR61EKcHOZ6HrZN+47tqC+
         WAaBn4S2jDvOvJrS7SYDn6ogIF5DcgmNqf1FejrI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE6E0608CC;
        Fri, 23 Aug 2019 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548308;
        bh=1GbHG78SpJmojCXUdDitKC6EvtNM7lX/s2bc+Panfa8=;
        h=From:To:Cc:Subject:Date:From;
        b=k9QzRQ+I81EFg07fzx9675Swl+AGsX7PXxXz/ZehUBf6rNy1cdaXSnI9D0yyBS91d
         xgcnlqpSwRceKf1K+s+M4Z4x+4ZRpWRju1LaoOEymLYfDcZaAb39EJcnqJcaXqn+PZ
         yA48ImCN+WgAUMEaq/mkofP66C4zn38+s+arRLpU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE6E0608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v2 0/6] Add RSC power domain support
Date:   Fri, 23 Aug 2019 13:46:57 +0530
Message-Id: <20190823081703.17325-1-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
- Add Stephen's Reviewed-By to the first three patches
- Addressed Stephen's comments on fourth patch
- Include changes to connect rpmh domain to cpuidle and genpds

Resource State Coordinator (RSC) is responsible for powering off/lowering
the requirements from CPU subsystem for the associated hardware like buses,
clocks, and regulators when all CPUs and cluster is powered down.

RSC power domain uses last-man activities provided by genpd framework based on
Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
states. As a part of domain poweroff, RSC can lower resource state requirements
by flushing the cached sleep and wake state votes for resources.

Dependencies:

[1] https://lkml.org/lkml/2019/5/13/839

Maulik Shah (6):
  drivers: qcom: rpmh: fix macro to accept NULL argument
  drivers: qcom: rpmh: remove rpmh_flush export
  dt-bindings: soc: qcom: Add RSC power domain specifier
  drivers: qcom: rpmh-rsc: Add RSC power domain support
  arm64: dts: Convert to the hierarchical CPU topology layout for sdm845
  arm64: dts: Add rsc power domain for sdm845

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt |   8 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 105 +++++++++++++-----
 drivers/soc/qcom/rpmh-internal.h              |   3 +
 drivers/soc/qcom/rpmh-rsc.c                   |  84 ++++++++++++++
 drivers/soc/qcom/rpmh.c                       |  22 ++--
 include/soc/qcom/rpmh.h                       |   5 -
 6 files changed, 185 insertions(+), 42 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

