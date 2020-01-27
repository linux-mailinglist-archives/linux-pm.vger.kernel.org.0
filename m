Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5455314AADE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA0UEv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:04:51 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51737 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgA0UEv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:04:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155491; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zKV6cJDC7D9lZtbet0fncNoNw3SzF9fxJt5jaczV1pg=; b=HPu9j+MkEzpNSWVDpwWBF9KPUAqOdD0xChkKlGiJY5e70MSwS7ZbhUb9eI2GEsjvj6kYwraC
 NA5T2cBOu/b0jsdjVYeQeidnmtRwE73OubUjGCuugLxt2CO1HP+8xkGh6Iq2S98fanmCoBfR
 5Ew+qstRX2XaR9wsdswyE2E6B10=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f4259.7f06fc9765a8-smtp-out-n01;
 Mon, 27 Jan 2020 20:04:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCDE9C447AA; Mon, 27 Jan 2020 20:04:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C7C5C447A1;
        Mon, 27 Jan 2020 20:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C7C5C447A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC v3 05/10] opp: of: export _opp_of_get_opp_desc_node
Date:   Tue, 28 Jan 2020 01:33:45 +0530
Message-Id: <20200127200350.24465-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export _opp_of_get_opp_desc_node in preparation for attaching multiple
opp_table per device.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/of.c  | 3 +--
 drivers/opp/opp.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 43acf54934be7..015ee9ab09485 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -25,8 +25,7 @@
  * Returns opp descriptor node for a device node, caller must
  * do of_node_put().
  */
-static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
-						     int index)
+struct device_node *_opp_of_get_opp_desc_node(struct device_node *np, int index)
 {
 	/* "operating-points-v2" can be an array for power domain providers */
 	return of_parse_phandle(np, "operating-points-v2", index);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9e021f819acca..6f56ff6038605 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -226,12 +226,14 @@ void _put_opp_list_kref(struct opp_table *opp_table);
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
 void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
+struct device_node *_opp_of_get_opp_desc_node(struct device_node *np, int index);
 void _of_opp_free_required_opps(struct opp_table *opp_table,
 				struct dev_pm_opp *opp);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
+static inline struct device_node *_opp_of_get_opp_desc_node(struct device_node *np, int index) { return NULL; }
 static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 					      struct dev_pm_opp *opp) {}
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
