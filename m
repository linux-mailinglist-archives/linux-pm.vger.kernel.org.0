Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027003DAAAB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhG2SFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 14:05:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12795 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhG2SFN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jul 2021 14:05:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627581909; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jGAZNpvv9zROAVlHGnt4zPV0nfKI5c1XmksYWoQ4fn0=; b=S517ZWLohZ5vz46nfs3qwqy4poiYzOkS5IL9WtDu51uROHnHB6bEr8fWDfoPme5b5dKOxS+o
 Q7nLgJ33UmVT590uucXgG8vmIBdME0DLaezRczHungU/fhjKqKpZRWUXUdCjLlPQ2mjtdfSB
 0rPZ/tzo9qvi072s98T67MC39Hs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6102edcd1dd16c87885da9d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 18:05:01
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85B93C43217; Thu, 29 Jul 2021 18:05:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC769C433D3;
        Thu, 29 Jul 2021 18:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC769C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     sboyd@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mka@chromium.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/4] Fixup register offsets to support per core L3 DCVS
Date:   Thu, 29 Jul 2021 23:34:41 +0530
Message-Id: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm SoCs (starting with SM8350) support per core voting for L3 cache
frequency. The patch series re-arranges the cpufreq register offsets to
allow access for the L3 interconnect to implement per core control i.e.
the first 0x100 is now accessed by the L3 interconnect driver instead.

L3 interconnect provider node on SC7280 SoC:
epss_l3: interconnect@18590000 {
	compatible = "qcom,sc7280-epss-l3";
        reg = <0 0x18590000 0 0x1000>, <0 0x18591000 0 0x100>,
	      <0 0x18592000 0 0x100>, <0 0x18593000 0 0x100>;
	...
};

CPUFREQ node on SC7280 SoC:
cpufreq_hw: cpufreq@18591000 {
	compatible = "qcom,cpufreq-epss";
	reg = <0 0x18591100 0 0x900>,
	      <0 0x18592100 0 0x900>,
	      <0 0x18593100 0 0x900>;
	...
};

The patch series also prevents binding breakage by using the
SM8250/SM8350 EPSS compatible.

Sibi Sankar (4):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add compatible for SM8250/8350
  cpufreq: qcom: Re-arrange register offsets to support per core L3 DCVS
  arm64: dts: qcom: sc7280: Fixup the cpufreq node
  arm64: dts: qcom: sm8350: Fixup the cpufreq node

 .../bindings/cpufreq/cpufreq-qcom-hw.txt           |  6 +++++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  6 +++---
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  9 ++++-----
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 23 ++++++++++++++++++----
 4 files changed, 31 insertions(+), 13 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

