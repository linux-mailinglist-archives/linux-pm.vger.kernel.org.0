Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5017F20486B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 06:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgFWEFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 00:05:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:46741 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728290AbgFWEFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 00:05:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592885153; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=iYRCY9d7/pjVcoq+dL5FiY4OkzTvsLWVQfnZhwaoa0I=; b=TF49dpG/ZIc/Ii0W6P3NkPwz+0nkFQAsg3SI/IQtp1siVBcS939WykXoHuPX7KNIZiY62tFh
 uhf3oZKrui590RELlT0esYNyqSX0I2RqM6ktyOKne8tw6BgKKvDyWlLJurYL9/8aSM4oDEFm
 Ik2wcwulKXRU7rHhLsWssbl4lTo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ef17f8886de6ccd441fb87e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 04:05:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8E02C433A0; Tue, 23 Jun 2020 04:05:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A5DEC433C6;
        Tue, 23 Jun 2020 04:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A5DEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 0/2] interconnect: qcom: Add common dt-bindings
Date:   Mon, 22 Jun 2020 21:05:13 -0700
Message-Id: <20200623040515.23317-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add common dt-bindings to replace internal macros.

Mike Tipton (2):
  dt-bindings: interconnect: Add generic qcom bindings
  interconnect: qcom: Don't redefine bucket/tag macros

 drivers/interconnect/qcom/icc-rpmh.h        | 18 ++------------
 include/dt-bindings/interconnect/qcom,icc.h | 26 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

