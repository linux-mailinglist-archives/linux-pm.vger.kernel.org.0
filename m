Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92CC64851C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiLIP0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiLIP0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CF8F08B
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcVWJd9ElP4s5dpyhiw9umTDqqrH0LH6f0MqsA5xgO4=;
        b=oChr19G74vkDrbksxwde4+AjRPogAxn2sN1YQjCyTV6dg/J61dZcG02RxTybnokXVFNDos
        bskOccUSxTqbaha+Mo0/fAvOcaP/gVzjhw+GLZOUa1kd9vStegQeLVzsqUWBnkPIyJJUby
        RmMjsyuyvr9zzYGgZeho9PbUzeLD7d99Y9LjB9HuwGWI/128QNDnwcTqIezdUHcgFt+WaQ
        iwntR89hnz9g8tjf5Z6Nv+G1nnMaVVpifNkfsH+uvZkJ74jXyvElhdea5AKx1vLZYscdqz
        Lx8wDA7rOGlVDpQWZqNq1bWHdgnSy8jkq7HisH0SYEwz6u2Lp0f3YlyV7ycDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcVWJd9ElP4s5dpyhiw9umTDqqrH0LH6f0MqsA5xgO4=;
        b=sQ12iXJ08pbovQhTjLvhfDTQ3+VPaxTEEThQs5b6CITJHif7QQ0yfm264Yt5XEgAIi+PhY
        BPR7rooNsKNyuTDQ==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Simplify
 k3_thermal_get_temp() function
Cc:     Bryan Brattlof <bb@ti.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221031232702.10339-2-bb@ti.com>
References: <20221031232702.10339-2-bb@ti.com>
MIME-Version: 1.0
Message-ID: <167059958735.4906.597495666808063069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     277958b1c90fc5818fc9dea870cc5aec9af3d152
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//277958b1c90fc5818fc9dea870cc5aec9af3d152
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Mon, 31 Oct 2022 18:26:52 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/k3_j72xx_bandgap: Simplify k3_thermal_get_temp() function

The k3_thermal_get_temp() function can be simplified to return only
the result of k3_bgp_read_temp() without needing the 'ret' variable

Signed-off-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20221031232702.10339-2-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/k3_j72xx_bandgap.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index c073b10..a9f99a1 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -249,14 +249,7 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 /* Get temperature callback function for thermal zone */
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = tz->devdata;
-	int ret = 0;
-
-	ret = k3_bgp_read_temp(data, temp);
-	if (ret)
-		return ret;
-
-	return ret;
+	return k3_bgp_read_temp(tz->devdata, temp);
 }
 
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
