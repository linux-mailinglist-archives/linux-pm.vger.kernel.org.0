Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2B3D1595
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhGUROK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 13:14:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11321 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhGUROD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jul 2021 13:14:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626890079; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=n+WomZgsGntNVi2ZamTOte+9Sxr3DS3WUwW5O2gEwCI=; b=gUC+oaiLeKShmICAM8fp2QqdXjv4NUC1gjvQwSKJvkX0N6N8QyX3Q24seKsvbGfKpA88dbn0
 An+3LpJnXDJv83Mi5wbCFy0n40TsNTK7jCdRciYVIT1EYU2g3EWavd24fseOLJ89G91+1wGm
 uYeHzoGoC4En078PeXhtrN6GFlc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60f85f5ee31d882d184a7f2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:54:38
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3F2AC4338A; Wed, 21 Jul 2021 17:54:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8D96C433D3;
        Wed, 21 Jul 2021 17:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8D96C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 0/4] interconnect: Fix sync-state issues
Date:   Wed, 21 Jul 2021 10:54:28 -0700
Message-Id: <20210721175432.2119-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These patches fix a couple of sync-state bugs that either cause the initial BW
floors to be ignored entirely, or to be never removed after sync-state is
called.

v2:
- Move pre_aggregate call to outside the aggregate if statement

Mike Tipton (4):
  interconnect: Zero initial BW after sync-state
  interconnect: Always call pre_aggregate before aggregate
  interconnect: qcom: icc-rpmh: Ensure floor BW is enforced for all nodes
  interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

 drivers/interconnect/core.c          |  7 +++++++
 drivers/interconnect/qcom/icc-rpmh.c | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

