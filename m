Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A134D22B0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbiCHUeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350249AbiCHUep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8A3B55F
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:47 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zvWqR79Eqd1Y5kQpmzHaMWVk34SDBEM95bet+fl/3g=;
        b=aahMp4jB7Fj+FYrRrChR/a0Aqb5y9rVkwMEzzVrv49qcBxkHRgxnrK0Wqd94Z2gF2EtPL5
        N647SwYtU2D0ghVYufuxR20SFVzJZ9z5Z9M0vsaBdKpccyvwxmiOWRM+yhOuPYFpVm6e/e
        hMJEh632GBCikLJNnd8cw13Sq2jm7qyoIrXE3cCBpxqs0A9RBRrMOLFusWXqLJQcIIlj64
        SURjMwL3oXkrNyHsZQ2RFQQno4xy5GXP8ZrWdm9uyQZUudjZGdSLY5Rz+F2PcwM/RplCqG
        IboRM8qvZ8YDQRDU+YxuZscolzSlGORZN/5c5UC0NyRbWjmcqn2VlJSeNQnI+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zvWqR79Eqd1Y5kQpmzHaMWVk34SDBEM95bet+fl/3g=;
        b=J2jvw7wh0If3JfAFM7gq9edf0TU07m8qs/eQcacntZfqNx/wN7O0El320jNicyi9AQhKBC
        WsTzl1MCyynKozAg==
From:   "thermal-bot for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/ti-soc-thermal: Remove unused
 function ti_thermal_get_temp()
Cc:     YueHaibing <yuehaibing@huawei.com>, Bryan Brattlof <bb@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220305125047.26948-1-yuehaibing@huawei.com>
References: <20220305125047.26948-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <164677162401.16921.4167236429666709415.tip-bot2@tip-bot2>
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

Commit-ID:     1d6aab36a26ba44b114d7f8a857c430c9e0c32c9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1d6aab36a26ba44b114d7f8a857c430c9e0c32c9
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Sat, 05 Mar 2022 20:50:47 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

thermal/drivers/ti-soc-thermal: Remove unused function ti_thermal_get_temp()

commit b263b473bf62 ("thermal: ti-soc-thermal: Remove redundant code")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20220305125047.26948-1-yuehaibing@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0959632..703039d 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -107,14 +107,6 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
-				      int *temp)
-{
-	struct ti_thermal_data *data = thermal->devdata;
-
-	return __ti_thermal_get_temp(data, temp);
-}
-
 static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = p;
