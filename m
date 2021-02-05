Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104363118C6
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 03:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBFCpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 21:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhBFCnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:43:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C98C08EC29
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 14:27:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7so8773095ybj.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2021 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0bK1cCqgN588qufpQS/jjMkFLqvM+XaA6lencJh5Esw=;
        b=pd0J5a0Gj6OJSYp7XH9+FNQHPBJdLZKzDSYwPK5u1ibnaAHv+7CWag8ijunOE9TunY
         rfH4kJBJkTaXTV9oJb29EtaGVzAhamAsrUpD9WxBP9zdpVN+VSy75zOwQ8X3ZfAdhLMe
         mDKrHkXJdOvKIScsXP0LwxtmU+0Z8CAngf3uWgzTxFHgVYCjuL8rAz4Vsox/6LUAxzW5
         MRcdF+4usBPhWiIaGf4NAtDC1+btGYzFBfT9G0+ShzhkBywErl48rl5a4pOA+2aiWGVY
         8M7h6tRlVXuW8kVZ+qFMkd2OawDjkeFzk26X1oEdg4TO44R/lohfBKQybn9mqBUar5JT
         uqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0bK1cCqgN588qufpQS/jjMkFLqvM+XaA6lencJh5Esw=;
        b=ZH+zo1tuuOLJ6a9iZr0awrNYEaEIt5COftOreTZUUdDK8C8u3XzdikBNW/8J86nlTU
         Xidb1Ofl8TUoLXtg3/Cly3ijbJIDh+kaoVgm7gk6LH5NI23rfxndrXY0/9LyyflXtPXX
         QXiB1wyDqO1EBjdVDYcfujRgATHzajwCBVBk+N8Q/FUUyyQBWC6ncWg1lwmJfpI5dutK
         rue5X+rgMZqFFOQeD5sz4d7mOdvJXKHK5r6dYqd4Czt3LBLOqMv8RfTnN/2yQ+uez3u5
         lTnAO0m8JnC03N18EW8d+IzXiY8cVEi0c5cJS5twXR/DD/or0lnDdVwGXTY89KKxt1Yk
         Xlow==
X-Gm-Message-State: AOAM530VgDCXsWqvS4EOW3vJy9Nal1jcIJqOE055Ipe9hUD3VJCTIYox
        YmJFGVpKAgZd6nuvBjnmfHoQULD5dKkVW2c=
X-Google-Smtp-Source: ABdhPJw99YDc8d0ycmQvA2pScnXjqnl/G4/xLF7whBdxq6B/zNO/ve0DpZDnU/PkkiSIcO/DWD8tNvRuJW0clJs=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:a25:743:: with SMTP id
 64mr8649867ybh.333.1612564029679; Fri, 05 Feb 2021 14:27:09 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:44 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-9-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 8/8] clk: Mark fwnodes when their clock provider is added/removed
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allows fw_devlink to recognize clock provider drivers that don't
use the device-driver model to initialize the device. fw_devlink will
use this information to make sure consumers of such clock providers
aren't indefinitely blocked from probing, waiting for the power domain
device to appear and bind to a driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8c1d04db990d..27ff90eacb1f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4555,6 +4555,8 @@ int of_clk_add_provider(struct device_node *np,
 	if (ret < 0)
 		of_clk_del_provider(np);
 
+	fwnode_dev_initialized(&np->fwnode, true);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_clk_add_provider);
@@ -4672,6 +4674,7 @@ void of_clk_del_provider(struct device_node *np)
 	list_for_each_entry(cp, &of_clk_providers, link) {
 		if (cp->node == np) {
 			list_del(&cp->link);
+			fwnode_dev_initialized(&np->fwnode, false);
 			of_node_put(cp->node);
 			kfree(cp);
 			break;
-- 
2.30.0.478.g8a0d178c01-goog

