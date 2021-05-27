Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED039272A
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhE0GOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 02:14:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19766 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229619AbhE0GOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 02:14:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622095985; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=aeDa3X9qCUqCdqikvcq0CFihZ9uyr2R7mEqIHkiwHUQ=; b=jpb+MD124T1pTeKlLgn5XuxHGPhOwW5OJKiSagbScLpbCAxvXxAEoTEoY058zoQJEefr6EBK
 +rPcemeUL1Gw/Fmw0wZMJ8Z6Grb/wuPaSvcRfR1KfiXUi2hoHBpum2HdZcJddX+y90/+jcht
 k483m9gv4lYjcLMg4nMetzOEPtI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60af3869c229adfeff8321bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 May 2021 06:12:57
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8032C4360C; Thu, 27 May 2021 06:12:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 113E7C433D3;
        Thu, 27 May 2021 06:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 113E7C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 0/3] PM / Domains: Add support for assigned-performance-states
Date:   Thu, 27 May 2021 11:42:26 +0530
Message-Id: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a re-spin of the series that was posted a while back [1]
with no major changes except for some review feedback from Stephen
addressed.

Back when this was posted, we thought its a good idea if client
drivers handle this instead of genpd core handling it [2]
So that lead to another series which handled this in the i2c 
driver [3], but then it looked like it would be duplication
of code across drivers and perhaps it should be done some place
centrally.

The way forward seems like
1. Get the bindings reviewed from DT folks
2. Once the bindings are finalized, figure out how to handle this
centrally without duplication. While this series does it with everything
handled in genpd core, there are perhaps other ways to do it with genpd
core exporting some helpers and genpd providers handling some of it with
callbacks.

----
Some devices within power-domains with performance states do not
support DVFS, but still need to vote on a default/static state
while they are active. Add support for a new device tree property
which the clients can use to specify this and add support in
kernel to parse this value and vote.

[1] https://lore.kernel.org/patchwork/patch/1284040/
[2] https://lore.kernel.org/patchwork/patch/1284042/
[3] https://lore.kernel.org/patchwork/patch/1356618/

Rajendra Nayak (3):
  dt-bindings: power: Introduce 'assigned-performance-states' property
  PM / Domains: Add support for 'assigned-performance-states'
  arm64: dts: sc7180: Add assigned-performance-states for i2c

 .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 24 +++++++++++
 drivers/base/power/domain.c                        | 27 ++++++++++++
 include/linux/pm_domain.h                          |  1 +
 4 files changed, 102 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

