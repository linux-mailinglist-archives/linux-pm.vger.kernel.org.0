Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB822C918E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgK3Wvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 17:51:36 -0500
Received: from z5.mailgun.us ([104.130.96.5]:10604 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgK3Wvg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 17:51:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606776677; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=wIHgMmsHCnSa0+3dsCDmblT5fCSV3MruKCNgTVpRPVY=; b=dX39QC8vUuMraPgr1dc8iNAJjwiQQlgE6l21I9KHrGAPq1zzsyXgpL9N5rxJempL9qmlzkw4
 C/ov1B/zxMMztXrjAOysDTFxcTB5XHb0opFZBMTtrk11dWEw1EHBAr4VWP38S33AA+0E0ifR
 DeHrf5CziXC5//FOI4BycQW6MCg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fc577471f6054cb8d557f0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Nov 2020 22:50:47
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C92CFC43461; Mon, 30 Nov 2020 22:50:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 823B9C433ED;
        Mon, 30 Nov 2020 22:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 823B9C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v6 0/3] Better domain idle from device wakeup patterns
Date:   Mon, 30 Nov 2020 15:50:36 -0700
Message-Id: <20201130225039.15981-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The v5[1] of the series brought out some interesting discussions. The
most important being is it worth adding the additional expense to all PM
domains even if no wakeup pattern is available. It seems like
maintaining a domain specific flag that the governor could check is a
generic enough option. That should disable additional overhead for
domains that do not need this feature.

Ulf suggested that we could allow wakeups only if any of the domain idle
state specifies a residency. However, we don't want to check for next
wakeup everytime the domain enters idle just because the domain
specifies an idle state with residency. This is also not desired.

Also, if the domain checks for next wakeup, should the parent domains of
the domain also check for next wakeup? And when do we set that up? These
are questions that we don't know the answers yet. So, let's enable the
domain governor only if the domain sets up the flag or when the device
in the domain specifies the next wakeup.

The previous post of the series explaining why this is a useful feature
is v5[1]. Please let me know what you think.

Thanks,
Lina

[1]. https://www.spinics.net/lists/linux-arm-msm/msg75555.html

Lina Iyer (3):
  PM / Domains: add domain feature flag for next wakeup
  PM / domains: inform PM domain of a device's next wakeup
  PM / Domains: use device's next wakeup to determine domain idle state

 drivers/base/power/domain.c          |  59 ++++++++++++++++
 drivers/base/power/domain_governor.c | 102 ++++++++++++++++++++++++---
 include/linux/pm_domain.h            |  37 ++++++++--
 3 files changed, 183 insertions(+), 15 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

