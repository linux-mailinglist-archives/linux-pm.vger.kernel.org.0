Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC01DE5C1
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgEVLpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 07:45:30 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:13748 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgEVLpa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 07:45:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590147929; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=y/tDLDxTaj/n3oOwTrmbLB4Bs+dfP08FE74B3sme6oo=; b=ewfN5CHDTLMq4dK022YZoPGZo13B1ru5Q+cY0hk3L11KvZ96+KN693SouFHOYPvig5ZNWJzf
 Th3g9XRa9AfcQ6gJ+d3z5JxAaUhQlP+bUN2/5L+5tbFcsycrYQxB/j38PXzPTEa9RnhsKM9Y
 Dw3YMobUAyQRYKK3BiRtP8Ngdd8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec7bb4a.7fbc1b475b90-smtp-out-n03;
 Fri, 22 May 2020 11:45:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11212C433C6; Fri, 22 May 2020 11:45:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 249C7C433C6;
        Fri, 22 May 2020 11:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 249C7C433C6
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
Subject: [PATCH v3 0/2] Add cold interrupt support to tsens driver
Date:   Fri, 22 May 2020 17:14:50 +0530
Message-Id: <20200522114452.28647-1-manafm@codeaurora.org>
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

Changes in v3:
* Add cold interrupt support to tsens driver
* Update cold interrupt support in yaml


*** BLURB HERE ***

Manaf Meethalavalappu Pallikunhi (2):
  drivers: thermal: tsens: Add cold interrupt support
  dt-bindings: thermal: tsens: Add cold interrupt support in yaml

 .../bindings/thermal/qcom-tsens.yaml          |  42 +++++++
 drivers/thermal/qcom/tsens-v2.c               |   5 +
 drivers/thermal/qcom/tsens.c                  | 112 +++++++++++++++++-
 drivers/thermal/qcom/tsens.h                  |  11 ++
 4 files changed, 169 insertions(+), 1 deletion(-)

-- 
2.26.2
