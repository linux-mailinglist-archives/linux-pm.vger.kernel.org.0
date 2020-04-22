Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC57E1B439E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgDVL6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:58:06 -0400
Received: from foss.arm.com ([217.140.110.172]:48294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgDVL6F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 07:58:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE4531B;
        Wed, 22 Apr 2020 04:58:05 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0BFB3F6CF;
        Wed, 22 Apr 2020 04:58:04 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 7871C682F37; Wed, 22 Apr 2020 12:58:03 +0100 (BST)
Date:   Wed, 22 Apr 2020 12:58:03 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 14/17] bus: vexpress-config: simplify config bus probing
Message-ID: <20200422115803.GY364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-15-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-15-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:07PM -0500, Rob Herring wrote:
> The vexpress-config initialization is dependent on the vexpress-syscfg
> driver probing. As vexpress-config was not a driver, deferred probe
> could not be used and instead initcall ordering was relied upon. This is
> fragile and doesn't work for modules.
> 
> Let's move the config bus init into the vexpress-syscfg probe. This
> eliminates the initcall ordering requirement and the need to create a
> struct device and the "vexpress-config" class.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/bus/vexpress-config.c | 118 ++++++----------------------------
>  1 file changed, 21 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
> index 43f5beac9811..43deb4df140b 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -56,7 +56,6 @@ struct vexpress_config_bridge {
>  
>  
>  static DEFINE_MUTEX(vexpress_config_mutex);
> -static struct class *vexpress_config_class;
>  static u32 vexpress_config_site_master = VEXPRESS_SITE_MASTER;
>  
>  
> @@ -121,9 +120,6 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
>  	struct regmap *regmap;
>  	struct regmap **res;
>  
> -	if (WARN_ON(dev->parent->class != vexpress_config_class))
> -		return ERR_PTR(-ENODEV);
> -
>  	bridge = dev_get_drvdata(dev->parent);
>  	if (WARN_ON(!bridge))
>  		return ERR_PTR(-EINVAL);
> @@ -146,94 +142,6 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_regmap_init_vexpress_config);
>  
> -static struct device *vexpress_config_bridge_register(struct device *parent,
> -		struct vexpress_config_bridge_ops *ops, void *context)
> -{
> -	struct device *dev;
> -	struct vexpress_config_bridge *bridge;
> -
> -	if (!vexpress_config_class) {
> -		vexpress_config_class = class_create(THIS_MODULE,
> -				"vexpress-config");
> -		if (IS_ERR(vexpress_config_class))
> -			return (void *)vexpress_config_class;
> -	}
> -
> -	dev = device_create(vexpress_config_class, parent, 0,
> -			NULL, "%s.bridge", dev_name(parent));
> -
> -	if (IS_ERR(dev))
> -		return dev;
> -
> -	bridge = devm_kmalloc(dev, sizeof(*bridge), GFP_KERNEL);
> -	if (!bridge) {
> -		put_device(dev);
> -		device_unregister(dev);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	bridge->ops = ops;
> -	bridge->context = context;
> -
> -	dev_set_drvdata(dev, bridge);
> -
> -	dev_dbg(parent, "Registered bridge '%s', parent node %p\n",
> -			dev_name(dev), parent->of_node);
> -
> -	return dev;
> -}
> -
> -
> -static int vexpress_config_node_match(struct device *dev, const void *data)
> -{
> -	const struct device_node *node = data;
> -
> -	dev_dbg(dev, "Parent node %p, looking for %p\n",
> -			dev->parent->of_node, node);
> -
> -	return dev->parent->of_node == node;
> -}
> -
> -static int vexpress_config_populate(struct device_node *node)
> -{
> -	struct device_node *bridge;
> -	struct device *parent;
> -	int ret;
> -
> -	bridge = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
> -	if (!bridge)
> -		return -EINVAL;
> -
> -	parent = class_find_device(vexpress_config_class, NULL, bridge,
> -			vexpress_config_node_match);
> -	of_node_put(bridge);
> -	if (WARN_ON(!parent))
> -		return -ENODEV;
> -
> -	ret = of_platform_populate(node, NULL, NULL, parent);
> -
> -	put_device(parent);
> -
> -	return ret;
> -}
> -
> -static int __init vexpress_config_init(void)
> -{
> -	int err = 0;
> -	struct device_node *node;
> -
> -	/* Need the config devices early, before the "normal" devices... */
> -	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
> -		err = vexpress_config_populate(node);
> -		if (err) {
> -			of_node_put(node);
> -			break;
> -		}
> -	}
> -
> -	return err;
> -}
> -postcore_initcall(vexpress_config_init);
> -
>  static int vexpress_syscfg_exec(struct vexpress_syscfg_func *func,
>  		int index, bool write, u32 *data)
>  {
> @@ -430,7 +338,8 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
>  {
>  	struct vexpress_syscfg *syscfg;
>  	struct resource *res;
> -	struct device *bridge;
> +	struct vexpress_config_bridge *bridge;
> +	struct device_node *node;
>  
>  	syscfg = devm_kzalloc(&pdev->dev, sizeof(*syscfg), GFP_KERNEL);
>  	if (!syscfg)
> @@ -443,11 +352,26 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
>  	if (IS_ERR(syscfg->base))
>  		return PTR_ERR(syscfg->base);
>  
> -	/* Must use dev.parent (MFD), as that's where DT phandle points at... */
> -	bridge = vexpress_config_bridge_register(pdev->dev.parent,
> -			&vexpress_syscfg_bridge_ops, syscfg);
> +	bridge = devm_kmalloc(&pdev->dev, sizeof(*bridge), GFP_KERNEL);
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	bridge->ops = &vexpress_syscfg_bridge_ops;
> +	bridge->context = syscfg;
> +
> +	dev_set_drvdata(&pdev->dev, bridge);
>  
> -	return PTR_ERR_OR_ZERO(bridge);
> +	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
> +		struct device_node *bridge_np;
> +
> +		bridge_np = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
> +		if (bridge_np != pdev->dev.parent->of_node)
> +			continue;
> +
> +		of_platform_populate(node, NULL, NULL, &pdev->dev);
> +	}
> +
> +	return 0;
>  }
>  
>  static const struct platform_device_id vexpress_syscfg_id_table[] = {
> -- 
> 2.20.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
