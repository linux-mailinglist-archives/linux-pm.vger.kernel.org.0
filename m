Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E894221ACC6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgGJB6I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 21:58:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44219 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727910AbgGJB6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 21:58:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594346287; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=skG1sNc6a9bKW7iRy/ErFo7Z5EjunK0kUA/gn4pjeGg=; b=gw45VV3n050dgtru5ObkYysqpbm8+gkVcWAtccAMjejADDP4X9UEjk+CQ5h3Dzo8//J5Gk76
 VweuRNpBNnlmAGxA74sLJsC6yM18Oaqauo9pDPzq3XiyD+NYPclm1xyO6Ej5Y3CmC5UelXPH
 bZ5HIuEfWVTQ21axuudZS448cNo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f07caf278e7807b5eecf9fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 01:57:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70C59C433C8; Fri, 10 Jul 2020 01:57:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A72B2C433C6;
        Fri, 10 Jul 2020 01:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A72B2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 0/6] interconnect: qcom: Misc bcm-voter changes and fixes
Date:   Thu,  9 Jul 2020 18:56:46 -0700
Message-Id: <20200710015652.19206-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These changes are mostly unrelated, but there are some dependencies
between them.

v2:
- New patch for generic qcom,icc.h bindings
- New patch for documenting qcom,tcs-wait property
- Update bcm_div() 'base' parameter from u64 to u32

Mike Tipton (6):
  dt-bindings: interconnect: Add generic qcom bindings
  dt-bindings: interconnect: Add property to set BCM TCS wait behavior
  interconnect: qcom: Support bcm-voter-specific TCS wait behavior
  interconnect: qcom: Only wait for completion in AMC/WAKE by default
  interconnect: qcom: Add support for per-BCM scaling factors
  interconnect: qcom: Fix small BW votes being truncated to zero

 .../bindings/interconnect/qcom,bcm-voter.yaml | 13 ++++
 drivers/interconnect/qcom/bcm-voter.c         | 63 ++++++++++++-------
 drivers/interconnect/qcom/icc-rpmh.c          |  3 +
 drivers/interconnect/qcom/icc-rpmh.h          | 20 ++----
 include/dt-bindings/interconnect/qcom,icc.h   | 26 ++++++++
 5 files changed, 88 insertions(+), 37 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

