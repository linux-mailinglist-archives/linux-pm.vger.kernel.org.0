Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068E4311909
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 03:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBFCx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhBFCcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:32:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F92FC0698E0
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 14:26:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n81so8657139ybg.20
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2021 14:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=223PDDzeAXN7fiB0Z3sv31/CUo0CMPx1p1AufcopYWI=;
        b=SFHQmMRc/ic1nmrT5IMiYstkL++tDL7Z3c9ojJSjDDxJdd2i0nznkXSFR68OUU+aVL
         37l+IB6klV569hlqPafHkvF6+7WsET3whuds9yrB7AV+RdCxsQ77OXj4J7Tcyq8/Ykby
         AlApFXR5yrG/7Vz11J14XoDvvGtfu1xCPL8V4LNO83ZHxI6bzavvye1rrEa6QHHFK9ZC
         VbK5aLF05CCF+bWVcucqMPqSUnnHjKES2+MRdskFBHbYTLhsN1Fzt8tWmeiWWfnkvi6G
         ubCkpqgDZw/sb8byBLZrzDfglYOud2eHQ2Bdkq3sgX+3NHRqCEOzx+TOG8IfoQk25pne
         myDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=223PDDzeAXN7fiB0Z3sv31/CUo0CMPx1p1AufcopYWI=;
        b=H2yF0ngo4JLm0gpZtsVHr3FRIFYL2YiPytgSJltQZ5XRtvDhlmZrRmUV1fdiUfY5B1
         4ArQWgvQRcrjFWylm1xezCs9nStlZhe+/Q25qnutxHd5FUiiejRMD8DVE5j0EjanMHPS
         IDV/LN9tcUgNtOQmm5HiaMfXBA2oi+uN/OqV1IBofrrcf9eqAVxwlb4K90uTw2kMWUok
         nHByR4+zOJ2ydAZb+tph84XYWmkCkF3du65zJFJLLDbzSs2fAIZt1Wga31Pckq8/uHdC
         LgK3vokYsJ5TS9b6Swoyn3qz/HFKtgaqF+OrH/gTCdM+o2NCkSBhqQYyfXFRmW1g0Y+l
         eczg==
X-Gm-Message-State: AOAM533i6Ej6wk/99PjRRn2WXAJXflqLyvaDtp5uqpZmtMm30c81oPcm
        zccjKeQ8lgP/CbDjARdwR6mwFGc8pIe9HP4=
X-Google-Smtp-Source: ABdhPJxrL9cH3mLaTtg3wJ/fW0QIFeUS4+4EDQLIPatw4HQvuGDNDATg7OIEzUZWu1cx19SOt5U8lpPfcWDatIE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:a25:2693:: with SMTP id
 m141mr9430134ybm.104.1612564011451; Fri, 05 Feb 2021 14:26:51 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:37 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 1/8] driver core: fw_devlink: Detect supplier devices that
 will never be added
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
        Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

During the initial parsing of firmware by fw_devlink, fw_devlink might
infer that some supplier firmware nodes would get populated as devices.
But the inference is not always correct. This patch tries to logically
detect and fix such mistakes as boot progresses or more devices probe.

fw_devlink makes a fundamental assumption that once a device binds to a
driver, it will populate (i.e: add as struct devices) all the child
firmware nodes that could be populated as devices (if they aren't
populated already).

So, whenever a device probes, we check all its child firmware nodes. If
a child firmware node has a corresponding device populated, we don't
modify the child node or its descendants. However, if a child firmware
node has not been populated as a device, we delete all the fwnode links
where the child node or its descendants are suppliers. This ensures that
no other device is blocked on a firmware node that will never be
populated as a device. We also mark such fwnodes as NOT_DEVICE, so that
no new fwnode links are created with these nodes as suppliers.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/base/core.c    | 31 ++++++++++++++++++++++++++++---
 include/linux/fwnode.h |  2 ++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 484a942884ba..c95b1daabac7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -148,6 +148,21 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
 	fwnode_links_purge_consumers(fwnode);
 }
 
+static void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child;
+
+	/* Don't purge consumer links of an added child */
+	if (fwnode->dev)
+		return;
+
+	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_links_purge_consumers(fwnode);
+
+	fwnode_for_each_available_child_node(fwnode, child)
+		fw_devlink_purge_absent_suppliers(child);
+}
+
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
@@ -1154,12 +1169,22 @@ void device_links_driver_bound(struct device *dev)
 	LIST_HEAD(sync_list);
 
 	/*
-	 * If a device probes successfully, it's expected to have created all
+	 * If a device binds successfully, it's expected to have created all
 	 * the device links it needs to or make new device links as it needs
-	 * them. So, it no longer needs to wait on any suppliers.
+	 * them. So, fw_devlink no longer needs to create device links to any
+	 * of the device's suppliers.
+	 *
+	 * Also, if a child firmware node of this bound device is not added as
+	 * a device by now, assume it is never going to be added and make sure
+	 * other devices don't defer probe indefinitely by waiting for such a
+	 * child device.
 	 */
-	if (dev->fwnode && dev->fwnode->dev == dev)
+	if (dev->fwnode && dev->fwnode->dev == dev) {
+		struct fwnode_handle *child;
 		fwnode_links_purge_suppliers(dev->fwnode);
+		fwnode_for_each_available_child_node(dev->fwnode, child)
+			fw_devlink_purge_absent_suppliers(child);
+	}
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
 	device_links_write_lock();
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index fde4ad97564c..21082f11473f 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -19,8 +19,10 @@ struct device;
  * fwnode link flags
  *
  * LINKS_ADDED: The fwnode has already be parsed to add fwnode links.
+ * NOT_DEVICE: The fwnode will never be populated as a struct device.
  */
 #define FWNODE_FLAG_LINKS_ADDED		BIT(0)
+#define FWNODE_FLAG_NOT_DEVICE		BIT(1)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
-- 
2.30.0.478.g8a0d178c01-goog

