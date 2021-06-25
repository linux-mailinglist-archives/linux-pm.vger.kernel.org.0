Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749C63B4A28
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFYVbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 17:31:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26745 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhFYVbU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 17:31:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624656539; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=2ytQZ0GiePJNRSQsX0zaH9qhbTUbXKraxZXQz57Le9Q=; b=SBVckKtwfuyugOqyonXu7Yxdn88gw3dZLi+l9tL5SD0WgZtvwvfGK9A+kZaNf4QXh/pUezuJ
 C8FEJIIuFQxBFXi1/VMswbQ7BO87pw+eQNWCZ7UYEcUypT+wQYu2MMGksUbr/g0VBfjLdnkn
 8ueb+ysd0mtOefiYe9LBDZUh2Ro=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60d64a9bdc4628fe7e690568 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 21:28:59
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29625C433D3; Fri, 25 Jun 2021 21:28:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29059C433F1;
        Fri, 25 Jun 2021 21:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29059C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 0/4] interconnect: Fix sync-state issues
Date:   Fri, 25 Jun 2021 14:28:35 -0700
Message-Id: <20210625212839.24155-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These patches fix a couple of sync-state bugs that either cause the initial BW
floors to be ignored entirely, or to be never removed after sync-state is
called.

Mike Tipton (4):
  interconnect: Zero initial BW after sync-state
  interconnect: Always call pre_aggregate before aggregate
  interconnect: qcom: icc-rpmh: Ensure floor BW is enforced for all nodes
  interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

 drivers/interconnect/core.c          |  7 ++++++-
 drivers/interconnect/qcom/icc-rpmh.c | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

