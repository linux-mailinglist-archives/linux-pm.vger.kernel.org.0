Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB171D6778
	for <lists+linux-pm@lfdr.de>; Sun, 17 May 2020 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgEQKrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 May 2020 06:47:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:19161 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbgEQKrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2020 06:47:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589712430; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=gKtdSd/m1Hypkss/AI1u9zC9wBa/GBjsWEYmwhUlMa0=; b=t2ijHR4PW57guprPPiJQTIQlMP3iSQDNSJ7xuMm7Jky6E3wLIqwzjV5DOlMkyxA9cRpM18hB
 OgejXqfs2cVQI41x7V5PdtrcobdDR11SJSPe+bh7fQh1K/RtDhBB9UvegNurEOdnHmuJD0jz
 lXiRi06JzyfYBwZvLPI9FA5tmWU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec11624.7f7243054618-smtp-out-n04;
 Sun, 17 May 2020 10:47:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6FBDC43637; Sun, 17 May 2020 10:46:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73F91C433D2;
        Sun, 17 May 2020 10:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73F91C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=manafm@codeaurora.org
From:   Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Subject: [PATCH v2 0/2] Add zeroc interrupt support to tsens driver
Date:   Sun, 17 May 2020 16:16:25 +0530
Message-Id: <20200517104627.29501-1-manafm@codeaurora.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The changes have dependency on merging tsens-common.c into tsens.c [1]
to merge first.

Dependencies:
[1] https://lkml.org/lkml/2020/4/29/1028

Changes in v2:
* Add zeroc interrupt support to tsens driver
* Update zeroc interrupt support in yaml

Manaf Meethalavalappu Pallikunhi (2):
  drivers: thermal: tsens: Add zeroc interrupt support
  dt-bindings: thermal: tsens: Add zeroc interrupt support in yaml

 .../bindings/thermal/qcom-tsens.yaml          |  21 ++++
 drivers/thermal/qcom/tsens-v2.c               |   5 +
 drivers/thermal/qcom/tsens.c                  | 107 +++++++++++++++++-
 drivers/thermal/qcom/tsens.h                  |  10 ++
 4 files changed, 141 insertions(+), 2 deletions(-)

-- 
2.26.2
