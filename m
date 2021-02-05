Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7B311A5F
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 04:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhBFDnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 22:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhBFDlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 22:41:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C64C08E86F
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 14:27:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n81so8657628ybg.20
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2021 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nTYZSPOjkc18IliuMfnfRh5H/pVF22NJbjiTgx5RAVQ=;
        b=Mm6nmK+U9sWgdy5Kl5FWR72rOFcOPFvROrGTmdoXRpZIiuZV62ELOWH/ANFl9FZv48
         WKXxbas72ewJwQSAlM+tuQ5oro9iQc2J6lQg3Fj4ZGY95z4hvdDMslQ/xFUCHGw9JTQW
         ozCrQLXZ4ZZwk460RT8jQymPqzGWnn6RzLezbUwlZbxeN6sZ9i9EFrxpHIMJXDCZ+GtS
         ZxX35V5B8D7JFLk2l9CMndHRKsILANotrh6ov6yUqsjE4ZkLpQq/qs+6ILuymjBzW/t3
         lfMT6f+nRYfVGGUpAXuGaHE3M4iW6zmvvcop6V9w3pEKg6VttIn53oZg6LRjtoP47yQC
         LIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nTYZSPOjkc18IliuMfnfRh5H/pVF22NJbjiTgx5RAVQ=;
        b=aFsyAl5Q7E9lAxGFJwKkt1D3p4afF5aJPsb6/rJyVe5UxALoBHY2+iXwo61kD+U2rG
         H94YgZnVA9owoHgAOH5djOZYXa2oeZ+zOjRZTssGbv2FfE+CZTuYATgTwyaBlIhS4E5T
         a0QuyePPJoX4lSeOA8Rb+k5e4cRGydAUd62cMSN6ebufsC9INvNsRzkx7X/tqDLqMgQK
         l+2MeaxHYnuRRvFZgJoI/c6RvFHlyPTBwP2KN5PKurwaQM3dALjG2v2SaSamw2NvKcKr
         tgaDW4ws2Td6GtMpm/PJaj2YTqIduGDi5v5Po1FRPkjMYbQ65XzOj6+wXDZGmXyo07Mq
         4xHg==
X-Gm-Message-State: AOAM5315Lv5mTocgWpulO/aHVOqMfQJwz9MDX8EhffHiQa1hcBnxkzpp
        WSqebTaqDLYkoLFS2A2wZrPskQq3aJ1YddE=
X-Google-Smtp-Source: ABdhPJyW1m9SbXAqH09239WynVsuVFpGwpuvcunwzfCPoBBzTTIBp5GlOy/wl0ZJFwtPTfMh78OkuipnUZY/zB8=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:a25:3104:: with SMTP id
 x4mr9895088ybx.141.1612564022147; Fri, 05 Feb 2021 14:27:02 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:41 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-6-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 5/8] driver core: fw_devlink: Handle suppliers that don't
 use driver core
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

Device links only work between devices that use the driver core to match
and bind a driver to a device. So, add an API for frameworks to let the
driver core know that a fwnode has been initialized by a driver without
using the driver core.

Then use this information to make sure that fw_devlink doesn't make the
consumers wait indefinitely on suppliers that'll never bind to a driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 15 +++++++++++++++
 include/linux/fwnode.h | 19 +++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f466ab4f1c35..ea710b33bda6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1636,6 +1636,17 @@ static int fw_devlink_create_devlink(struct device *con,
 
 	sup_dev = get_dev_from_fwnode(sup_handle);
 	if (sup_dev) {
+		/*
+		 * If it's one of those drivers that don't actually bind to
+		 * their device using driver core, then don't wait on this
+		 * supplier device indefinitely.
+		 */
+		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
+		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		/*
 		 * If this fails, it is due to cycles in device links.  Just
 		 * give up on this link and treat it as invalid.
@@ -1655,6 +1666,10 @@ static int fw_devlink_create_devlink(struct device *con,
 		goto out;
 	}
 
+	/* Supplier that's already initialized without a struct device. */
+	if (sup_handle->flags & FWNODE_FLAG_INITIALIZED)
+		return -EINVAL;
+
 	/*
 	 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
 	 * cycles. So cycle detection isn't necessary and shouldn't be
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index d5caefe39d93..dfefd43a737c 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/err.h>
 
 struct fwnode_operations;
 struct device;
@@ -18,11 +19,13 @@ struct device;
 /*
  * fwnode link flags
  *
- * LINKS_ADDED: The fwnode has already be parsed to add fwnode links.
- * NOT_DEVICE: The fwnode will never be populated as a struct device.
+ * LINKS_ADDED:	The fwnode has already be parsed to add fwnode links.
+ * NOT_DEVICE:	The fwnode will never be populated as a struct device.
+ * INITIALIZED: The hardware corresponding to fwnode has been initialized.
  */
 #define FWNODE_FLAG_LINKS_ADDED		BIT(0)
 #define FWNODE_FLAG_NOT_DEVICE		BIT(1)
+#define FWNODE_FLAG_INITIALIZED		BIT(2)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -161,6 +164,18 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 	INIT_LIST_HEAD(&fwnode->suppliers);
 }
 
+static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
+					  bool initialized)
+{
+	if (IS_ERR_OR_NULL(fwnode))
+		return;
+
+	if (initialized)
+		fwnode->flags |= FWNODE_FLAG_INITIALIZED;
+	else
+		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
+}
+
 extern u32 fw_devlink_get_flags(void);
 extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
-- 
2.30.0.478.g8a0d178c01-goog

