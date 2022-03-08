Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBC4D22AE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiCHUes (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350250AbiCHUer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC213DDDF
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:49 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHl7pMgZDdF3mvZle51GTdnz+5ouUI1DDX1ah4ymwuQ=;
        b=hWfYW9J8mqwzTRFmUvQIYNp09ofbzBrVNodPDexW4Wizdpk42jQ3iSFd36BwnHlyVe1VwV
        ELCN2NxtpBAVfFar/zF2uHs56qZzfT2hfGeI7E38QZLDSqeyQIyY6X9oqOED1zjSpCKwTg
        sHrMbepKVp0OjVXmv+CwNNOYSHmdqZdZtePTf7SF1Y8rHj0m/5sqnKz/4kcVSpiRkDZXLd
        jrIX/+0Sa881A84nGFSHSiCuRnoWL9RHZ/sQvCsbaCkKaF9uNoVq2BskilwTeWjWThMPeO
        keUzncruB9kO2wcxViGIqFBbXgndP1H/oUcWDRUTikChCgFn9Yt/h2PLOfTEuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHl7pMgZDdF3mvZle51GTdnz+5ouUI1DDX1ah4ymwuQ=;
        b=zHr3wjqMQS6jqV7nwBHSslIijAQGNBmK0vaL+DA3qiwtv0aq/ql07BEshPaTif3slO0695
        ppB3ghazvjwy5XBQ==
From:   "thermal-bot for Mikko Perttunen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: tegra-bpmp: Handle errors in BPMP response
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210915085517.1669675-1-mperttunen@nvidia.com>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Message-ID: <164677162607.16921.603454196840443886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1a7c9213d5f9bfd5e1bf4f87df1abc166ce48ffc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1a7c9213d5f9bfd5e1bf4f87df1abc166ce48ffc
Author:        Mikko Perttunen <mperttunen@nvidia.com>
AuthorDate:    Wed, 15 Sep 2021 11:55:13 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

thermal: tegra-bpmp: Handle errors in BPMP response

The return value from tegra_bpmp_transfer indicates the success or
failure of the IPC transaction with BPMP. If the transaction
succeeded, we also need to check the actual command's result code.
Add code to do this.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20210915085517.1669675-1-mperttunen@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 94f1da1..5affc3d 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -52,6 +52,8 @@ static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
 	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
 	if (err)
 		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
 
 	*out_temp = reply.get_temp.temp;
 
@@ -63,6 +65,7 @@ static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
 	struct tegra_bpmp_thermal_zone *zone = data;
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	req.type = CMD_THERMAL_SET_TRIP;
@@ -76,7 +79,13 @@ static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
 	msg.tx.data = &req;
 	msg.tx.size = sizeof(req);
 
-	return tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
+	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tz_device_update_work_fn(struct work_struct *work)
@@ -140,6 +149,8 @@ static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
 	err = tegra_bpmp_transfer(bpmp, &msg);
 	if (err)
 		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
 
 	*num_zones = reply.get_num_zones.num;
 
