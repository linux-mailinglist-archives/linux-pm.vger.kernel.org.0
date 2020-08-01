Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE63234F9F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 05:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHADch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 23:32:37 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12700 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728466AbgHADch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 23:32:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596252756; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=mZoXbg7QKXgsr8QudG8yDWBYbvZd92MunjPxpBzjxNo=; b=XlvZeryHlQmq9aqJrHY/7EFqEtQKqlizQqUHM2XB6YMmiN/xpsCVdUFSTaaTjQNOYMwZ+fzN
 k5taZme1noS3A55JDOLpLIrYCTJdt0Z8EfebifzUSwRquVoFx9GYQpFVaAx3EkCXDVOv1nqR
 VqDetKQsWvox9b6dfC1V+TWJQKA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f24e24976a940cda8fd2c20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 03:32:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 055D9C43395; Sat,  1 Aug 2020 03:32:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29223C433C9;
        Sat,  1 Aug 2020 03:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29223C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3 0/6] interconnect: qcom: Misc bcm-voter changes and fixes
Date:   Fri, 31 Jul 2020 20:32:09 -0700
Message-Id: <20200801033215.1440-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These changes are mostly unrelated, but there are some dependencies
between them.

v3:
- Improve qcom,tcs-wait property description
- Stop using #define in property `default` doc

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

 .../bindings/interconnect/qcom,bcm-voter.yaml | 20 ++++++
 drivers/interconnect/qcom/bcm-voter.c         | 63 ++++++++++++-------
 drivers/interconnect/qcom/icc-rpmh.c          |  3 +
 drivers/interconnect/qcom/icc-rpmh.h          | 20 ++----
 include/dt-bindings/interconnect/qcom,icc.h   | 26 ++++++++
 5 files changed, 95 insertions(+), 37 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

