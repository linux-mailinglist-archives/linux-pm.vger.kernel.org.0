Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D11AFC6B
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDSRIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:34 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:33896 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgDSRId (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:33 -0400
Received: by mail-oo1-f65.google.com with SMTP id q204so1591980ooq.1;
        Sun, 19 Apr 2020 10:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wB2U6U0ewgKGp4KSPn+vSVDTtuFAzErpi8wcYMw6Fo=;
        b=J330on2EgzdkMLi2/N5HetUHoxJl7mS4qTXMNe1ccQP23uw+Wb0Kvs5B+2yJEWBD/I
         +WzrP3wOxAgQGAHJoc+7c7PfLJrsIKzTpA39fIHxSjbS/PEyas/w3MEVcLIs4bYupMEq
         rJ5UQ2M/05hQYFnqmxKwKN+ukoOz0Mwk3oaDYwdNbH2mpUKBFQL88em7XZN5UH+NWU0D
         6xS3W7tET1RYGjUVsZfkAa8ILZYqZPK1vRA6e2q9OEZCts6rU5SLep0E8BXson/vFsR/
         fQImbJPH+nC0ygqaEd2jCgbKrGnvro6qK5RI/39JtHMXQlvINs83Ulw6P0uS56u4Rp0s
         rryg==
X-Gm-Message-State: AGi0PubosoL4wv9E78d+6DBNnx7YE5Ag86kjZDNplz5kMAr5eFDJlK7U
        CN0giwNRJbVMpZAzWWb6Y3Zp+Lc=
X-Google-Smtp-Source: APiQypImHT/KiAE2mwj4qy0evl0L7k4NWcklyJuzb3ysWeesGWHDLxv/Jj7+ufFs8HRp8SjUd7oBZw==
X-Received: by 2002:a4a:7011:: with SMTP id r17mr9863390ooc.17.1587316112203;
        Sun, 19 Apr 2020 10:08:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 14/17] bus: vexpress-config: simplify config bus probing
Date:   Sun, 19 Apr 2020 12:08:07 -0500
Message-Id: <20200419170810.5738-15-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
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

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

