Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDA584352
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiG1Plx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiG1Plw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258BE68DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:52 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cd8fnhqAY/u0FIrtNMYFbssqgTiPITE1ioroVTbq61E=;
        b=gSpbfodOBuqWCYchTy7f7960Jxc2Y4wlb5ITlPfYL2aP7AeINQ3NKXso1cR+VR/qcozDRh
        x6BE/Ok89qrWGUhNk1i7TtzfaF/nrCoBSUTWZ+SmMRqE4tnup5vmH7//AcOq5HNjo1QbLv
        A2QwYhDgsFV/qnt3eT9ODPP23f3loHWWmZXaaEJ3VHEyqsfk+GnZHc1oNSvDtC0BwgobaD
        piqmMAVxB7cqmOkB9OrXPpRFRUpl/AINufNbOB5vm8JMmmDkpFSs9dWNN9VkG3Z4ceZFLW
        p4d6KaekU4RF9bR/xd2UQjRAVvI0uRMdCwYHqa69XtmAGzSY818cBVoBYuhEWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cd8fnhqAY/u0FIrtNMYFbssqgTiPITE1ioroVTbq61E=;
        b=yvEUXFeZRczkVhkbG7EBB0NI9Eh8miK0X+xC6vqEFd1nK7PvxlB5lJ5qAUgAOB/R8985GV
        euT5+xukSDQ1sCDA==
From:   "thermal-bot for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Fix array
 underflow in prep_lookup_table()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <YoetjwcOEzYEFp9b@kili>
References: <YoetjwcOEzYEFp9b@kili>
MIME-Version: 1.0
Message-ID: <165902290964.15455.15523789691058201166.tip-bot2@tip-bot2>
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

Commit-ID:     cc67ca28cf8b29245b71e01117927ed2793f35b7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//cc67ca28cf8b29245b71e01117927ed2793f35b7
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Fri, 20 May 2022 18:02:39 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:48 +02:00

thermal/drivers/k3_j72xx_bandgap: Fix array underflow in prep_lookup_table()

This while loop exits with "i" set to -1 and so then it sets:

	derived_table[-1] = derived_table[0] - 300;

There is no need for this assignment at all.  Just delete it.

Fixes: 72b3fc61c752 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YoetjwcOEzYEFp9b@kili
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 3a35aa3..27d4cae 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -151,8 +151,6 @@ static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
 		/* 300 milli celsius steps */
 		while (i--)
 			derived_table[i] = derived_table[i + 1] - 300;
-		/* case 0 */
-		derived_table[i] = derived_table[i + 1] - 300;
 	}
 
 	/*
