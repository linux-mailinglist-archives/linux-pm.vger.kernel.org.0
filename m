Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB423608D2
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhDOME1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhDOMEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59438C061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:02 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Q/WhqAfUhrd+IX08m9AmmBvM3E4TsQFY+CssVrYq4c=;
        b=v6wdWlCGXKsjMnKXTdA8IpGd9TQ6H8elcm/0XkAh992yZbsmRCV6UUMvqLSSwVLc5Bvdw2
        TJIEMr1jrp3Ph1OHQynlK0C00tRh7jadJOCNRom83CA6f+y54cVSe+aTLPHa3qEkoLSIbw
        PgpElry6YO8tYcN65CBqFDPjvYuHlHm7G+k7wTHR7LvTJSLNRMGG5CTSl75cW+v54rNdBw
        eOjudIGSgBpait7rFVz4hSwXqODfghAFY5XLgEswfxuBxwxM7oLZVG7MILEoYBW/uRT2G8
        2FMejGHinBZAL0NogucxOe6VeeARmMDQlwKXIFyQFCsDj7iVn/LDS7NTpQDPUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Q/WhqAfUhrd+IX08m9AmmBvM3E4TsQFY+CssVrYq4c=;
        b=z7RTKbcGJ6sX0q0vFdbTRZy345GnGdhvcBbFaZWuMKq3qAK0TJtDAGIJbbWinwjr0Sx1A+
        QcV0cWXAqlETYKAw==
From:   "thermal-bot for Guangqing Zhu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Fix missing put_device error
Cc:     Guangqing Zhu <zhuguangqing83@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210404125431.12208-1-zhuguangqing83@gmail.com>
References: <20210404125431.12208-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Message-ID: <161848824018.29796.16963569425778407686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f4136863e8899fa0554343201b78b9e197c78a78
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f4136863e8899fa0554343201b78b9e197c78a78
Author:        Guangqing Zhu <zhuguangqing83@gmail.com>
AuthorDate:    Sun, 04 Apr 2021 20:54:31 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

thermal/drivers/tsens: Fix missing put_device error

Fixes coccicheck error:

drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device; call
of_find_device_by_node on line 715, but without a corresponding object
release within this function.

Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into tsens.c")
Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210404125431.12208-1-zhuguangqing83@gmail.com
---
 drivers/thermal/qcom/tsens.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a6..3c4c051 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -755,8 +755,10 @@ int __init init_common(struct tsens_priv *priv)
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
 							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i]))
-				return PTR_ERR(priv->rf[i]);
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
 		}
 		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
 		if (ret)
