Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9827D2D764B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436618AbgLKNKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436591AbgLKNKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:10:25 -0500
Date:   Fri, 11 Dec 2020 13:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbQDcnTD3/Yh+mkn+rX3NKUH2xy+Mx6kEC2F5JYLhY0=;
        b=yFfJNS06s59x1wlnyLiEqi4+ZfMvYgl+KRb0rD7w2jidLG6V/m2LON8z91oG2Eibs4XdEg
        WIsqvIrt88zYtBEeZEtExiWhpa4eB1m1RkzF4JQw86qaXNzLt5CQ6MFqFLru1Eu9Nsmudo
        UhgITfLTp9iKdshQBpzfnaMdV/5F9Fpe9GUJQwbchnrQsLEyAh10NHFvF2pzQp6ztbHmoE
        tP4sUHBiu8hxgE3nF+XZB/A3shKXBTjx/0Q2LuLtCnDcEAZEY7LPRQ1R6vjmi79zw9A1Tc
        FD/ZUoovnagja+SwnDa3C4dJsY+MDhy1B17bQdvW1+fJslgV8BVPqmlk37HzPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbQDcnTD3/Yh+mkn+rX3NKUH2xy+Mx6kEC2F5JYLhY0=;
        b=Pxr4KTFEOPjfoJbdq8v+0265flZw2Yz7qGS+GZfuyDJfPEUzAdNHyAD0LFQFSKE74kIrlm
        96pNwZDTkaeifSDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] platform/x86/drivers/acerhdf: Use
 module_param_cb to set/get polling interval
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
References: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <160769214407.3364.7484361663829871694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a65181c41e57709053892832d261956afe281deb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a65181c41e57709053892832d261956afe281deb
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 03 Dec 2020 08:17:37 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Dec 2020 17:03:58 +01:00

platform/x86/drivers/acerhdf: Use module_param_cb to set/get polling interval

The module parameter can be set by using ops to get and set the
values. The change will allow to check the correctness of the interval
value everytime it is changed instead of checking in the get_temp
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter Kaestle <peter@piie.net>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20201203071738.2363701-1-daniel.lezcano@linaro.org
---
 drivers/platform/x86/acerhdf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 44b6bfb..19fc8ff 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -84,8 +84,6 @@ static struct platform_device *acerhdf_dev;
 
 module_param(kernelmode, uint, 0);
 MODULE_PARM_DESC(kernelmode, "Kernel mode fan control on / off");
-module_param(interval, uint, 0600);
-MODULE_PARM_DESC(interval, "Polling interval of temperature check");
 module_param(fanon, uint, 0600);
 MODULE_PARM_DESC(fanon, "Turn the fan on above this temperature");
 module_param(fanoff, uint, 0600);
@@ -824,3 +822,11 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
+
+static const struct kernel_param_ops interval_ops = {
+	.set = param_set_uint,
+	.get = param_get_uint,
+};
+
+module_param_cb(interval, &interval_ops, &interval, 0600);
+MODULE_PARM_DESC(interval, "Polling interval of temperature check");
