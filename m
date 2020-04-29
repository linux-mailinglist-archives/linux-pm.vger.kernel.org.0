Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E139E1BE95D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgD2U6u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38937 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgD2U6t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id m10so3130965oie.6;
        Wed, 29 Apr 2020 13:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myrenzSPyW59XpfF+gIY1TxdoxeVOHKfaEK33JnlZTA=;
        b=jfLWwBOAOJfrGQDrLkC24LXLhz6oOO3jCqVuGnW/ixZ6enwc9DSBkIIVb6U5idzP3f
         DSUkdDzRsAtU7In+4th6OHG/Fxi/PngZbb7sOqEiPfrckCKC7gKR9HZ1rWuxSwDHe/IY
         j7QT9EHkPGe0F++o+0v0aLwqOWR0K8qgzeKL7Vu2qn21MaHIrr4Wcp3T6D9l1oCueUil
         U9XBuunMZ4aFRpY8GFXlVwbMSEtKoPgry8BfAvxt0RdD11MkwLW9e4zj9wYgdo4n7khB
         K7vpGPL0JeQ4lOND9Hxx7bIy7JbKaSDitFrOCDBTCWGy9+DNkjiun2OuF8R+4J7KmcPs
         fELA==
X-Gm-Message-State: AGi0PuZWpJ1awCB4nsZqfG5iiWGcow0K6zZX4nZuiewi+8Uo8wvMqjSy
        W6xkEM8OR6hw9BHrFuCbmw==
X-Google-Smtp-Source: APiQypId0MDw7AeVQVQkoHCYMF2A7Fv08/wl1ScqTYpGJciki03GgiqVioMmxhSmH8L/Spi9eOa0sg==
X-Received: by 2002:a54:4e86:: with SMTP id c6mr127195oiy.178.1588193926891;
        Wed, 29 Apr 2020 13:58:46 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 13/16] bus: vexpress-config: simplify config bus probing
Date:   Wed, 29 Apr 2020 15:58:22 -0500
Message-Id: <20200429205825.10604-14-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The vexpress-config initialization is dependent on the vexpress-syscfg
driver probing. As vexpress-config was not a driver, deferred probe
could not be used and instead initcall ordering was relied upon. This is
fragile and doesn't work for modules.

Let's move the config bus init into the vexpress-syscfg probe. This
eliminates the initcall ordering requirement and the need to create a
struct device and the "vexpress-config" class.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/vexpress-config.c | 118 ++++++----------------------------
 1 file changed, 21 insertions(+), 97 deletions(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index 43f5beac9811..43deb4df140b 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -56,7 +56,6 @@ struct vexpress_config_bridge {
 
 
 static DEFINE_MUTEX(vexpress_config_mutex);
-static struct class *vexpress_config_class;
 static u32 vexpress_config_site_master = VEXPRESS_SITE_MASTER;
 
 
@@ -121,9 +120,6 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
 	struct regmap *regmap;
 	struct regmap **res;
 
-	if (WARN_ON(dev->parent->class != vexpress_config_class))
-		return ERR_PTR(-ENODEV);
-
 	bridge = dev_get_drvdata(dev->parent);
 	if (WARN_ON(!bridge))
 		return ERR_PTR(-EINVAL);
@@ -146,94 +142,6 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_regmap_init_vexpress_config);
 
-static struct device *vexpress_config_bridge_register(struct device *parent,
-		struct vexpress_config_bridge_ops *ops, void *context)
-{
-	struct device *dev;
-	struct vexpress_config_bridge *bridge;
-
-	if (!vexpress_config_class) {
-		vexpress_config_class = class_create(THIS_MODULE,
-				"vexpress-config");
-		if (IS_ERR(vexpress_config_class))
-			return (void *)vexpress_config_class;
-	}
-
-	dev = device_create(vexpress_config_class, parent, 0,
-			NULL, "%s.bridge", dev_name(parent));
-
-	if (IS_ERR(dev))
-		return dev;
-
-	bridge = devm_kmalloc(dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge) {
-		put_device(dev);
-		device_unregister(dev);
-		return ERR_PTR(-ENOMEM);
-	}
-	bridge->ops = ops;
-	bridge->context = context;
-
-	dev_set_drvdata(dev, bridge);
-
-	dev_dbg(parent, "Registered bridge '%s', parent node %p\n",
-			dev_name(dev), parent->of_node);
-
-	return dev;
-}
-
-
-static int vexpress_config_node_match(struct device *dev, const void *data)
-{
-	const struct device_node *node = data;
-
-	dev_dbg(dev, "Parent node %p, looking for %p\n",
-			dev->parent->of_node, node);
-
-	return dev->parent->of_node == node;
-}
-
-static int vexpress_config_populate(struct device_node *node)
-{
-	struct device_node *bridge;
-	struct device *parent;
-	int ret;
-
-	bridge = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
-	if (!bridge)
-		return -EINVAL;
-
-	parent = class_find_device(vexpress_config_class, NULL, bridge,
-			vexpress_config_node_match);
-	of_node_put(bridge);
-	if (WARN_ON(!parent))
-		return -ENODEV;
-
-	ret = of_platform_populate(node, NULL, NULL, parent);
-
-	put_device(parent);
-
-	return ret;
-}
-
-static int __init vexpress_config_init(void)
-{
-	int err = 0;
-	struct device_node *node;
-
-	/* Need the config devices early, before the "normal" devices... */
-	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
-		err = vexpress_config_populate(node);
-		if (err) {
-			of_node_put(node);
-			break;
-		}
-	}
-
-	return err;
-}
-postcore_initcall(vexpress_config_init);
-
 static int vexpress_syscfg_exec(struct vexpress_syscfg_func *func,
 		int index, bool write, u32 *data)
 {
@@ -430,7 +338,8 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 {
 	struct vexpress_syscfg *syscfg;
 	struct resource *res;
-	struct device *bridge;
+	struct vexpress_config_bridge *bridge;
+	struct device_node *node;
 
 	syscfg = devm_kzalloc(&pdev->dev, sizeof(*syscfg), GFP_KERNEL);
 	if (!syscfg)
@@ -443,11 +352,26 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 	if (IS_ERR(syscfg->base))
 		return PTR_ERR(syscfg->base);
 
-	/* Must use dev.parent (MFD), as that's where DT phandle points at... */
-	bridge = vexpress_config_bridge_register(pdev->dev.parent,
-			&vexpress_syscfg_bridge_ops, syscfg);
+	bridge = devm_kmalloc(&pdev->dev, sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	bridge->ops = &vexpress_syscfg_bridge_ops;
+	bridge->context = syscfg;
+
+	dev_set_drvdata(&pdev->dev, bridge);
 
-	return PTR_ERR_OR_ZERO(bridge);
+	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
+		struct device_node *bridge_np;
+
+		bridge_np = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
+		if (bridge_np != pdev->dev.parent->of_node)
+			continue;
+
+		of_platform_populate(node, NULL, NULL, &pdev->dev);
+	}
+
+	return 0;
 }
 
 static const struct platform_device_id vexpress_syscfg_id_table[] = {
-- 
2.20.1

