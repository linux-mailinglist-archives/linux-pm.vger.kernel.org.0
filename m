Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2A361A32
	for <lists+linux-pm@lfdr.de>; Fri, 16 Apr 2021 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbhDPG7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Apr 2021 02:59:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44608 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239256AbhDPG7X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Apr 2021 02:59:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618556338; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mFahiqmBUzZJantEUUJofFLfR+1vSK+fgZDkIYbab78=; b=ZLgZ4ZG45F2ghReOHCRVZCe9byHeLYls+hODcufagR3y93ZhmZdkK9p/RbXDeCW2ioWKGNZ5
 Gsf3wys4YhgNlsW0raQfoGBR6j1YK/xRvZhdbL1TkYgBwaFiOv5PeJNOi8SbwL+z/+8ViL1n
 s2DFv9nMn8IYeX3DXgQAv/qHWYU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 607935b12cc44d3aea47c284 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 06:58:57
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E252C43464; Fri, 16 Apr 2021 06:58:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48661C433C6;
        Fri, 16 Apr 2021 06:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48661C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        sibis@codeaurora.org, elder@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [0/3] Add L3 provider support for SC7280
Date:   Fri, 16 Apr 2021 12:28:07 +0530
Message-Id: <1618556290-28303-1-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 provider support on SM7280 SoCs.

Depends on: https://lore.kernel.org/patchwork/cover/1389010/
Depends on: https://lore.kernel.org/patchwork/cover/1392102/

Odelu Kukatla (3):
  dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
  interconnect: qcom: Add EPSS L3 support on SC7280
  arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider

 .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   9 ++
 drivers/interconnect/qcom/osm-l3.c                 | 124 ++++++++++++++++-----
 drivers/interconnect/qcom/sc7280.h                 |  10 ++
 include/dt-bindings/interconnect/qcom,osm-l3.h     |  10 +-
 5 files changed, 124 insertions(+), 30 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

