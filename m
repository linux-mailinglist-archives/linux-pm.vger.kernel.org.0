Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9E59E711
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbiHWQWg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244225AbiHWQWG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BA2767E2
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:23 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKRIw1WRSewky3o1kZcwCgkOaBelQoUDGkTWXSgy8FY=;
        b=wCCvX+nJGMvPeZOVyTXi9oqz0N3mdvTOvpzX4MOIDe3hvQK+1p/lmBZSU6FqTq8hbky90j
        o4MgVazCnIZySkZkGO3jdkORRAKRL2+TaXcIF8IZaCZGP/NvsQRA0wdRqGQ7nt8kP0eQcD
        X9c6/5aJTTc99PiUfo67UGOpuDPH53Q89IGJGZ9xPkU6+6HedL/dSp0UHQv6zblgUg39bu
        4HDG3aKrqQ7jnzuBB8qeuYw5cYswIH1Xza9Y0Y63yk+iZ0+hH9Y6RS+kWHbIh0Lu0AV5f9
        V7mjYA4ZXBBEaZbidhg7RJ4rHX053g36vAw/SfeNdMnsBKh9j1mBM1Morkzkxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKRIw1WRSewky3o1kZcwCgkOaBelQoUDGkTWXSgy8FY=;
        b=OUr1XtoLgTqHA4cHIYHhKnAk5zblonrcxHkUTxqAwc56gH3OSrsbr0pPB/riRpsFY50Syg
        YGpQPRc/nc9W6OCg==
From:   "thermal-bot for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Fix error code in of_thermal_zone_find()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <YvDzovkMCQecPDjz@kili>
References: <YvDzovkMCQecPDjz@kili>
MIME-Version: 1.0
Message-ID: <166125860068.401.6527171705353525583.tip-bot2@tip-bot2>
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

Commit-ID:     45b8850b3d3071d5ea9e19ad4a29ad5f0b5d1ec1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//45b8850b3d3071d5ea9e19ad4a29ad5f0b5d1ec1
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Tue, 09 Aug 2022 10:56:26 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:37 +02:00

thermal/of: Fix error code in of_thermal_zone_find()

Currently, if we cannot find the correct thermal zone then this error
path returns NULL and it would lead to an Oops in the caller.  Return
ERR_PTR(-EINVAL) instead.

Fixes: 3bd52ac87347 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YvDzovkMCQecPDjz@kili
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 82236fe..15b342f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1102,6 +1102,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int 
 			}
 		}
 	}
+	tz = ERR_PTR(-EINVAL);
 out:
 	of_node_put(np);
 	return tz;
