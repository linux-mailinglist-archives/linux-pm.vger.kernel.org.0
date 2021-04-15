Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6554C3608DA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhDOME3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhDOME0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:26 -0400
Date:   Thu, 15 Apr 2021 12:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y72AhxafK2R6kMGC0g53xS32GPkKnlUdt4qPGjA7VBk=;
        b=pwJs1LWyCg1y6FX7mgAwr37ATXWwaUH7N4zGurWpupXOHHLv2jDxTr7ZrpCLC9S7gYhcVC
        Gc22ar9XBGgtDE5GH6hsa57GvAyowAxs1iae9SEhzZOh9cyeIqWlvoY/+ViheBok9TjKV5
        6S16gtYE1mIDxHaJSVYKVkriQugWMljWVTTRUFeaitzUiIk2pzPavVVoV0iPvWR4fpVlMN
        4QCFPx/YMRWY94JN8OKUbkXEHRGrigq2TW2zAvpkWAcavGU1MbE766czsHEdD6xQDginak
        LLAdPTQm7eA7YdiTxyH2g/txJrDFIyEv2kH6PG8ffU8go0CuGELk8FxYQrbEGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y72AhxafK2R6kMGC0g53xS32GPkKnlUdt4qPGjA7VBk=;
        b=G+ghWHy8yQQVGVY9JC4/JTb+j6jm2modeVjOD1xmen7S5a1Oos+1bXWGF3xo+IBeXFsqKW
        oVAfQ3pewv29PpCA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/devfreq_cooling: Fix wrong
 return on error path
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210319202424.890968-1-daniel.lezcano@linaro.org>
References: <20210319202424.890968-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161848824278.29796.10119141602469930229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9aa80ab2c0ba67ce3281aee604b543293f71390d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9aa80ab2c0ba67ce3281aee604b543293f71390d
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 19 Mar 2021 21:24:23 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:16 +02:00

thermal/drivers/devfreq_cooling: Fix wrong return on error path

The following error is reported by kbuild:

 smatch warnings:
 drivers/thermal/devfreq_cooling.c:433 of_devfreq_cooling_register_power() warn: passing zero to 'ERR_PTR'

Fix the error code by the setting the 'err' variable instead of 'cdev'.

Fixes: f8d354e821b2 ("thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210319202424.890968-1-daniel.lezcano@linaro.org
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fb250ac..3a788ac 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -402,7 +402,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	cdev = ERR_PTR(-ENOMEM);
+	err = -ENOMEM;
 	name = kasprintf(GFP_KERNEL, "devfreq-%s", dev_name(dev));
 	if (!name)
 		goto remove_qos_req;
