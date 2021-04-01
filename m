Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9E351FE5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhDAThQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233786AbhDAThQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 15:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A468D6108B;
        Thu,  1 Apr 2021 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617305836;
        bh=+2HkIIjf3Fx8Ql7r+k8EhdnzFruKkCkpZUMFaA0onMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUX/yzlicpQEcWwq9cgjEwJPuF2qlr/1yhoGOgNljU454tAKZyMCXSHZRnck6fIeR
         pOMg3WG1ogoNzn2fRYfG5dvGl1bcRb9azRZyf+Lv2PoXXS5J8mh1XRpgrvXEUbChWf
         WNkDrumgsYo34ztwtGLtywgAB9zBj/fGpSUoNY9M=
Date:   Thu, 1 Apr 2021 21:37:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
Subject: Re: [PATCH v6 7/7] powercap/drivers/dtpm: Allow dtpm node device
 creation through configfs
Message-ID: <YGYg6ZeZ1181/pXk@kroah.com>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-7-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401183654.27214-7-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 01, 2021 at 08:36:54PM +0200, Daniel Lezcano wrote:
> The DTPM framework is built on top of the powercap framework as a new
> controller to act on the power of the devices. The approach is to
> provide an unified API to do power limitation on devices which are
> capable of that with different techniques.
> 
> In addition, the DTPM framework allows to create a hierarchical
> representation of the devices in order to reflect the dependencies of
> the power constraints we want to apply to a group of devices.
> 
> The hierarchy can be different for the same platform as it will depend
> on the form factor (tablet, notebook, phone, ...), on other components
> and/or a policy, and application scenario.
> 
> The kernel can not have such knowledge and only the SoC vendor can
> setup its platform to fulfill the objectives of its hardware.
> 
> This patch adds the ability to create a DTPM hierarchy via
> configfs. All DTPM capable devices are registered in a list, and the
> creation of a configfs directory with the name of one of this device
> will create a DTPM node in the DTPM powercap sysfs. If the name is not
> in the list, a virtual node will be created instead. This virtual node
> in the DTPM semantic is to aggregate the power characteristics of the
> children.
> 
> In order to do the connection between the configfs and sysfs easily, a
> 'device' file contains the path to the corresponding DTPM powercap
> node in sysfs (cross filesystems symlink is not supported by
> configfs).
> 
> In order to not block any new features in the future, the hierarchical
> constraints are stored under a top folder 'constraints', so sibling
> can be created for other purposes if needed.
> 
> When the configfs was populated, the module can not be unloaded until
> all the elements in the tree have been removed.
> 
> 1) Resulting creation via mkdir:
> 
> root@rock960:/sys/kernel/config# tree dtpm/
> dtpm/
> └── constraints
>     └── platform
>             ├── device
> 	    └── soc
> 	        ├── device
> 		└── pkg
> 		     ├── device
> 		     ├── cpu0-cpufreq
> 		     │   └── device
> 		     ├── cpu4-cpufreq
> 		     │   └── device
> 		     └── panfrost-devfreq
> 		            └── device
> 
> 2) The content of the 'device' file above
> 
> root@rock960:/sys/kernel/config# find dtpm/constraints -name "device" -exec cat {} \;
> /devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:1
> /devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:2
> /devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:1
> /devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:0
> /devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0
> /devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0
> /devices/virtual/powercap/dtpm/dtpm:0
> 
> 3) The dtpm device creation node is reflected in sysfs:
> 
> root@rock960:/sys/devices/virtual/powercap/dtpm# find . -type d | grep dtpm
> ./dtpm:0
> ./dtpm:0/power
> ./dtpm:0/dtpm:0:0
> ./dtpm:0/dtpm:0:0/power
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:1
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:1/power
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/power
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:2
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:2/power
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:0
> ./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:0/power
> ./dtpm:0/dtpm:0:0/dtpm:0:0:1
> ./dtpm:0/dtpm:0:0/dtpm:0:0:1/power

Why have you not documented all of this in Documentation/ABI so that we
can find it later?


> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/Kconfig         |   8 ++
>  drivers/powercap/Makefile        |   1 +
>  drivers/powercap/dtpm_configfs.c | 202 +++++++++++++++++++++++++++++++
>  include/linux/dtpm.h             |   2 +
>  4 files changed, 213 insertions(+)
>  create mode 100644 drivers/powercap/dtpm_configfs.c
> 
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 8242e8c5ed77..599b41e4e0a7 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -50,6 +50,14 @@ config DTPM
>  	  This enables support for the power capping for the dynamic
>  	  thermal power management userspace engine.
>  
> +config DTPM_CONFIGFS
> +	tristate "Dynamic Thermal Power Management configuration via configfs"
> +	depends on DTPM && CONFIGFS_FS
> +	help
> +	  This enables support for creating the DTPM device hierarchy
> +	  via configfs giving the userspace full control of the
> +	  thermal constraint representation.

Why does this have to be a module, shouldn't it just be part of the DTPM
code itself?

> +
>  config DTPM_CPU
>  	bool "Add CPU power capping based on the energy model"
>  	depends on DTPM && ENERGY_MODEL
> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> index fabcf388a8d3..519cabc624c3 100644
> --- a/drivers/powercap/Makefile
> +++ b/drivers/powercap/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_DTPM) += dtpm.o
> +obj-$(CONFIG_DTPM_CONFIGFS) += dtpm_configfs.o
>  obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
>  obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
>  obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
> diff --git a/drivers/powercap/dtpm_configfs.c b/drivers/powercap/dtpm_configfs.c
> new file mode 100644
> index 000000000000..b8de71e94fc3
> --- /dev/null
> +++ b/drivers/powercap/dtpm_configfs.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2021 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The DTPM framework defines a set of devices which are power capable.
> + *
> + * The configfs allows to create a hierarchy of devices in order
> + * to reflect the constraints we want to apply to them.
> + *
> + * Each dtpm node is created via a mkdir operation in the configfs
> + * directory. It will create the corresponding dtpm device in the
> + * sysfs and the 'device' will contain the absolute path to the dtpm
> + * node in the sysfs, thus allowing to do the connection between the
> + * created dtpm node in the configfs hierarchy and the dtpm node in
> + * the powercap framework.

Tieing configfs and sysfs is very odd, and ripe for problems.  Those are
independant filesystems with independant devices and paths and object
lifetimes.  How can you guarantee they all work together ok?

> + *
> + * The dtpm nodes can be real or virtual. The former is a real device
> + * where acting on its power is possible and is registered in a dtpm
> + * framework's list with an unique name. A creation with mkdir with
> + * one of the registered name will instanciate the dtpm device. If the
> + * name is not in the registered list, it will create a virtual node
> + * where its purpose is to aggregate the power characteristics of its
> + * children which can virtual or real.
> + *
> + * It is not allowed to create a node if another one in the hierarchy
> + * has the same name. That ensures the consistency and prevents
> + * multiple instanciation of the same dtpm device.
> + */
> +#include <linux/dtpm.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/configfs.h>
> +
> +static struct config_group *cstrn_group;
> +
> +static struct config_item_type dtpm_cstrn_type;
> +
> +static const struct config_item_type dtpm_root_group_type = {
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static struct configfs_subsystem dtpm_subsys = {
> +	.su_group = {
> +		.cg_item = {
> +			.ci_namebuf = "dtpm",
> +			.ci_type = &dtpm_root_group_type,
> +		},
> +	},
> +	.su_mutex = __MUTEX_INITIALIZER(dtpm_subsys.su_mutex),
> +};
> +
> +static bool dtpm_configfs_exists(struct config_group *grp, const char *name)
> +{
> +	struct list_head *entry;
> +
> +	list_for_each(entry, &grp->cg_children) {
> +		struct config_item *item =
> +			container_of(entry, struct config_item, ci_entry);
> +
> +		if (config_item_name(item) &&
> +		    !strcmp(config_item_name(item), name))
> +			return true;
> +
> +		if (dtpm_configfs_exists(to_config_group(item), name))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static struct config_group *dtpm_cstrn_make_group(struct config_group *grp, const char *name)
> +{
> +	struct dtpm *d, *p;
> +	int ret;
> +
> +	if (dtpm_configfs_exists(cstrn_group, name))
> +		return ERR_PTR(-EEXIST);
> +
> +	d = dtpm_lookup(name);
> +	if (!d) {
> +		d = kzalloc(sizeof(*d), GFP_KERNEL);
> +		if (!d)
> +			return ERR_PTR(-ENOMEM);
> +		dtpm_init(d, NULL);
> +	}
> +
> +	config_group_init_type_name(&d->cfg, name, &dtpm_cstrn_type);
> +
> +	/*
> +	 * Retrieve the dtpm parent node. The first dtpm node in the
> +	 * hierarchy constraint is the root node, thus it does not
> +	 * have a parent.
> +	 */
> +	p = (grp == cstrn_group) ? NULL :
> +		container_of(grp, struct dtpm, cfg);
> +
> +	ret = dtpm_register(name, d, p);

Why isn't the "name" the same name of the sysfs object that the kernel
created already?

I still do not understand why you need 2 different names for the same
device.

> +	if (ret)
> +		goto dtpm_free;
> +
> +	if (!try_module_get(THIS_MODULE)) {

Why are you trying to increment your own module reference count?  That's
totally racy and does not work.  And you are doing it _way_ after the
function has been called, what is this for?


> +		ret = -ENODEV;
> +		goto dtpm_unregister;
> +	}
> +
> +	return &d->cfg;
> +
> +dtpm_unregister:
> +	dtpm_unregister(d);
> +dtpm_free:
> +	if (!d->ops)
> +		kfree(d);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static void dtpm_cstrn_drop_group(struct config_group *grp,
> +				  struct config_item *cfg)
> +{
> +	struct config_group *cg = to_config_group(cfg);
> +	struct dtpm *d = container_of(cg, struct dtpm, cfg);
> +
> +	dtpm_unregister(d);
> +	if (!d->ops)
> +		kfree(d);
> +	module_put(THIS_MODULE);
> +	config_item_put(cfg);
> +}
> +
> +static struct configfs_group_operations dtpm_cstrn_group_ops = {
> +	.make_group = dtpm_cstrn_make_group,
> +	.drop_item = dtpm_cstrn_drop_group,
> +};
> +
> +static ssize_t dtpm_cstrn_device_show(struct config_item *cfg, char *str)
> +{
> +	struct config_group *cg = to_config_group(cfg);
> +	struct dtpm *d = container_of(cg, struct dtpm, cfg);
> +	struct kobject *kobj = &d->zone.dev.kobj;

Why are you using the "raw" kobject?

And wait, a configfs and sysfs object are in the same structure?  You
just broke lifetime rules again :(

> +	char *string = kobject_get_path(kobj, GFP_KERNEL);
> +	ssize_t len;
> +
> +	if (!string)
> +		return -EINVAL;
> +
> +	len = sprintf(str, "%s\n", string);

What sysfs namespace is this in?  This feels really odd to me...

> +
> +	kfree(string);
> +
> +	return len;
> +}
> +
> +CONFIGFS_ATTR_RO(dtpm_cstrn_, device);
> +
> +static struct configfs_attribute *dtpm_cstrn_attrs[] = {
> +	&dtpm_cstrn_attr_device,
> +	NULL
> +};
> +
> +static struct config_item_type dtpm_cstrn_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_group_ops = &dtpm_cstrn_group_ops,
> +};
> +
> +static int __init dtpm_configfs_init(void)
> +{
> +	int ret;
> +
> +	config_group_init(&dtpm_subsys.su_group);
> +
> +	ret = configfs_register_subsystem(&dtpm_subsys);
> +	if (ret)
> +		return ret;
> +
> +	cstrn_group = configfs_register_default_group(&dtpm_subsys.su_group,
> +						      "constraints",
> +						      &dtpm_cstrn_type);
> +
> +	/*
> +	 * The default group does not contain attributes but the other
> +	 * group will
> +	 */
> +	dtpm_cstrn_type.ct_attrs = dtpm_cstrn_attrs;
> +
> +	return PTR_ERR_OR_ZERO(cstrn_group);
> +}
> +module_init(dtpm_configfs_init);
> +
> +static void __exit dtpm_configfs_exit(void)
> +{
> +	configfs_unregister_default_group(cstrn_group);
> +	configfs_unregister_subsystem(&dtpm_subsys);
> +}
> +module_exit(dtpm_configfs_exit);
> +
> +MODULE_DESCRIPTION("DTPM configuration driver");
> +MODULE_AUTHOR("Daniel Lezcano");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index e47bd5bbf56e..d7bbb9fd97eb 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -8,11 +8,13 @@
>  #define ___DTPM_H__
>  
>  #include <linux/powercap.h>
> +#include <linux/configfs.h>
>  
>  #define MAX_DTPM_DESCR 8
>  #define MAX_DTPM_CONSTRAINTS 1
>  
>  struct dtpm {
> +	struct config_group cfg;

You now have 2 reference counted structures trying to control the same
structure.  Your lifetime rules just got so intertwined and messed up
it's not going to work, sorry.

thanks,

greg k-h
