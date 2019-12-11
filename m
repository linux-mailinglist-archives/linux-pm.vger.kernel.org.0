Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB511B4FF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfLKPus (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:50:48 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46516 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbfLKPur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576079438; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sz/wsBUGRl/3B6yGNXWjSD/WW8og/T1ubMIdBPmaXDI=;
        b=KF5zXw54QJn/POO8s9HQHsxBSkMEjBV1Q/eTMTSJ03M67Owaj8GZW6NxnSxxsCMXPXaR9Y
        Bx7/InBQCoFksg6+jpPUM+5T7k56jTU1f088Gw3JlYtbNX7jV1uqpACN+F7DzKc23wvo37
        zbHfTyfz8jWKmmxVC33rl7QkhpiuaKM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] usb: roles: Add API to register notifiers
Date:   Wed, 11 Dec 2019 16:50:31 +0100
Message-Id: <20191211155032.167032-2-paul@crapouillou.net>
In-Reply-To: <20191211155032.167032-1-paul@crapouillou.net>
References: <20191211155032.167032-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add usb_role_switch_notifier_register() and
usb_role_switch_notifier_unregister().

The registered notifiers will be called when the USB role is changed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/usb/roles/class.c | 24 +++++++++++++++++++++++-
 include/linux/usb/role.h  | 20 ++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 8273126ffdf4..9b122b504b98 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -10,6 +10,7 @@
 #include <linux/usb/role.h>
 #include <linux/property.h>
 #include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -19,6 +20,7 @@ static struct class *role_class;
 struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
+	struct blocking_notifier_head notifier_chain;
 	enum usb_role role;
 
 	/* From descriptor */
@@ -49,8 +51,11 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw->dev.parent, role);
-	if (!ret)
+	if (!ret) {
 		sw->role = role;
+		ret = blocking_notifier_call_chain(&sw->notifier_chain,
+						   (long)role, sw);
+	}
 
 	mutex_unlock(&sw->lock);
 
@@ -85,6 +90,22 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
+int
+usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				  struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&sw->notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
+
+int
+usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+				    struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&sw->notifier_chain, nb);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_unregister_notifier);
+
 static void *usb_role_switch_match(struct device_connection *con, int ep,
 				   void *data)
 {
@@ -317,6 +338,7 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&sw->lock);
+	BLOCKING_INIT_NOTIFIER_HEAD(&sw->notifier_chain);
 
 	sw->allow_userspace_control = desc->allow_userspace_control;
 	sw->usb2_port = desc->usb2_port;
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index efac3af83d6b..5f67d42cd28d 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 
 struct usb_role_switch;
+struct notifier_block;
 
 enum usb_role {
 	USB_ROLE_NONE,
@@ -50,6 +51,11 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev);
 struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *node);
 void usb_role_switch_put(struct usb_role_switch *sw);
 
+int usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				      struct notifier_block *nb);
+int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+					struct notifier_block *nb);
+
 struct usb_role_switch *
 usb_role_switch_find_by_fwnode(const struct fwnode_handle *fwnode);
 
@@ -82,6 +88,20 @@ fwnode_usb_role_switch_get(struct fwnode_handle *node)
 
 static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
 
+static inline int
+usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				  struct notifier_block *nb)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int
+usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+				    struct notifier_block *nb)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct usb_role_switch *
 usb_role_switch_register(struct device *parent,
 			 const struct usb_role_switch_desc *desc)
-- 
2.24.0

