Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560CF2C6E66
	for <lists+linux-pm@lfdr.de>; Sat, 28 Nov 2020 03:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgK1B4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 20:56:33 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:19866 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgK1Bkc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Nov 2020 20:40:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606527590; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pJvZfnlN+I7hdxtQ7If5F/t9qx8IuKWMTGk2I9ahoqc=; b=W+c4WcPIkP3hsM/qjneW2DbG/W2igyUkFglt1T7ZI9FIEuNArD4mlVvzsA59J2SpW4UNAylj
 vS9M834nUo/arLGPO3DmQST4pxMl8uPCFb35GmSQ0E0D3OPWvH/sEohF+Pwoo4KsIVg7TMJy
 +YdjH1kqsSMJHO9g0wmuDcUDxeA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fc1aa65b9b39088ed6be20d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 28 Nov 2020 01:39:49
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF268C43461; Sat, 28 Nov 2020 01:39:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E00EBC433C6;
        Sat, 28 Nov 2020 01:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E00EBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <qperret@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [RESEND PATCH V3] PM / EM: Micro optimization in em_cpu_energy
Date:   Sat, 28 Nov 2020 07:09:23 +0530
Message-Id: <1606527564-27238-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <671427cc-2abb-68eb-5e54-0851785efa84@intel.com>
References: <671427cc-2abb-68eb-5e54-0851785efa84@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the sum of the utilization of CPUs in a power domain is zero,
return the energy as 0 without doing any computations.

Acked-by: Quentin Perret <qperret@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 include/linux/energy_model.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b67a51c..8810f1f 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	struct em_perf_state *ps;
 	int i, cpu;
 
+	if (!sum_util)
+		return 0;
+
 	/*
 	 * In order to predict the performance state, map the utilization of
 	 * the most utilized CPU of the performance domain to a requested
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

