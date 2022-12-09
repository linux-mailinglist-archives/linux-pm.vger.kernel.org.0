Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F064851F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiLIP0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiLIP0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7038F098
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfNidTnQB4F52eMK1hmMioyq+qkw1Xg/s7rzgZYmnYQ=;
        b=QsPTieMdGeL/Hbk1UDU4Nq+Swzok5OkxZ3snEeAjgqXFtljMjju1sV22emsClj3PIAhKs/
        kJxgaDuqBHB0A8fHnFdl5XKoeMO5VowTHvfA50HDskP4lbAoqlNYr2c6wM6bM1IlzSD4dx
        K6CZPje0hVwQGWNUney3xGkw49ucZjinKmCyzh4rSA3eZonaUb170Oq6JEtaMrPNF8is9e
        nlsiY1QF+Haa9zXdLlFaokbhez1Z+SeJtnxsqJeyd8wksUfqcrxBwoIj9gclNMHK3db+9/
        1EXoPP3FdebZmdJFu7QhP8/qimaEUhQ6ZECQ7EAN+ez3e42GTn5meg+U17yn/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfNidTnQB4F52eMK1hmMioyq+qkw1Xg/s7rzgZYmnYQ=;
        b=//uu8NGkkwMGV0pS+J6On7j0aP5a8zkVoduqO6WJ5/MSpBsO5Km/gqKD/BA7UrF0nyIucT
        kohSSerpgoEa3IBQ==
From:   "thermal-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/power allocator: Remove a
 useless include
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C9adeec47cb5a8193016272d5c8bf936235c1711d=2E16694?=
 =?utf-8?q?59337=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C9adeec47cb5a8193016272d5c8bf936235c1711d=2E166945?=
 =?utf-8?q?9337=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <167059958799.4906.16455516656871309686.tip-bot2@tip-bot2>
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

Commit-ID:     8bd477942348cec5841be3f1ce4bef6c26c6b2e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8bd477942348cec5841be3f1ce4bef6c26c6b2e0
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sat, 26 Nov 2022 11:42:25 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/core/power allocator: Remove a useless include

This file does not use rcu, so there is no point in including
<linux/rculist.h>.

Remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/9adeec47cb5a8193016272d5c8bf936235c1711d.1669459337.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/gov_power_allocator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index eafb288..0eaf152 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -8,7 +8,6 @@
 
 #define pr_fmt(fmt) "Power allocator: " fmt
 
-#include <linux/rculist.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
