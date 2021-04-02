Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22BC3529F4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhDBKy3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBKy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 06:54:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA693C0613E6
        for <linux-pm@vger.kernel.org>; Fri,  2 Apr 2021 03:54:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e18so4405214wrt.6
        for <linux-pm@vger.kernel.org>; Fri, 02 Apr 2021 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qR3Y/pQ3iKdcYn1dnHBVpeHWq1US+Hbl+nSLawsbjwU=;
        b=twT2vrbqFmAZXeUPI1nfAb035BOgX4bEwyiHRWgXaXOJbJsBwGII6BD0bVACSU3hgU
         7SkNv1OWiYSGtKsGovqMNpJ8St9PFg3awG/ydZkftko0wr2ebVvQBON0n7tbcuOvja56
         HeClfafXLdRlX/yepCtw6tPMP0GZQZljOWudswAZ4ox96INmA4XlaR/GYlzhkxbIoJ5z
         557WnwfyBw7ydq9PvJNHu+0rYNt0PBUmB+a09RxA++aWMpi6pNuHniCnFAmY3SRDYbTq
         pV1VnvOF9mZJevrnHz7EeTRZzShTuYnN9sH98wutchdX2aOD1crApcVAfCq1cVpCLsD4
         wlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qR3Y/pQ3iKdcYn1dnHBVpeHWq1US+Hbl+nSLawsbjwU=;
        b=UW4BIsId1i6PYDErOIwJhehWx+2tFZw8yA2Qrry6vExYgb+sy09oHGYjelXHvL9OfZ
         zt0KgXyykV6ghJwsDLdtwDep+tN5mdMHrXNljhi0/TaG64/QuboS6JnlwTGhpK7rOd70
         794ZX6pli+cp6t9Ql8qc6C5b9OABJxXZbvkZcM8OAZ+24urlXLFYalkEU4rjRj7D/2uA
         1+1FUWUrkusYr28WD2w9J427PRf/pe8pndTSdSNaNTSOzQis07Lm50HZTKQKu8svQb1T
         cfmWzI6GV7saJqxyj2pbYcDI5hqUow2ODA93vXyuqkMyLWqTWgigTtrf26tahhfLJS5z
         h9Jw==
X-Gm-Message-State: AOAM533GNCpV3E4taDx5HaN9lwdtYPiVZPLhI5dgpt3zHGqoTedNBzW9
        oLZHy6pjlNyBUUs4vTauUdpjIw==
X-Google-Smtp-Source: ABdhPJx44r/f06WsoxqUjxjFwI2qefInJEA+qqUn6GtWxCII+f5urhqpd7qB4QakQ5OgaNl1uCq8UA==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr14484806wra.179.1617360866337;
        Fri, 02 Apr 2021 03:54:26 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf? ([2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf])
        by smtp.googlemail.com with ESMTPSA id b15sm14429493wmd.41.2021.04.02.03.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 03:54:25 -0700 (PDT)
Subject: Re: [PATCH v6 7/7] powercap/drivers/dtpm: Allow dtpm node device
 creation through configfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-7-daniel.lezcano@linaro.org>
 <YGYg6ZeZ1181/pXk@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d34bd0c8-f0fe-ada4-ebc8-433df51aaefa@linaro.org>
Date:   Fri, 2 Apr 2021 12:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGYg6ZeZ1181/pXk@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/04/2021 21:37, Greg KH wrote:
> On Thu, Apr 01, 2021 at 08:36:54PM +0200, Daniel Lezcano wrote:

[ ... ]

> Why have you not documented all of this in Documentation/ABI so that we
> can find it later?

You are right, I will write some documentation.


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/powercap/Kconfig         |   8 ++
>>  drivers/powercap/Makefile        |   1 +
>>  drivers/powercap/dtpm_configfs.c | 202 +++++++++++++++++++++++++++++++
>>  include/linux/dtpm.h             |   2 +
>>  4 files changed, 213 insertions(+)
>>  create mode 100644 drivers/powercap/dtpm_configfs.c
>>
>> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
>> index 8242e8c5ed77..599b41e4e0a7 100644
>> --- a/drivers/powercap/Kconfig
>> +++ b/drivers/powercap/Kconfig
>> @@ -50,6 +50,14 @@ config DTPM
>>  	  This enables support for the power capping for the dynamic
>>  	  thermal power management userspace engine.
>>  
>> +config DTPM_CONFIGFS
>> +	tristate "Dynamic Thermal Power Management configuration via configfs"
>> +	depends on DTPM && CONFIGFS_FS
>> +	help
>> +	  This enables support for creating the DTPM device hierarchy
>> +	  via configfs giving the userspace full control of the
>> +	  thermal constraint representation.
> 
> Why does this have to be a module, shouldn't it just be part of the DTPM
> code itself?

All options I've seen around are tristate as well as CONFIGFS_FS, so
TBH, I don't know what is the best option.

>> +
>>  config DTPM_CPU
>>  	bool "Add CPU power capping based on the energy model"
>>  	depends on DTPM && ENERGY_MODEL
>> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
>> index fabcf388a8d3..519cabc624c3 100644
>> --- a/drivers/powercap/Makefile
>> +++ b/drivers/powercap/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  obj-$(CONFIG_DTPM) += dtpm.o
>> +obj-$(CONFIG_DTPM_CONFIGFS) += dtpm_configfs.o
>>  obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
>>  obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
>>  obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
>> diff --git a/drivers/powercap/dtpm_configfs.c b/drivers/powercap/dtpm_configfs.c
>> new file mode 100644
>> index 000000000000..b8de71e94fc3
>> --- /dev/null
>> +++ b/drivers/powercap/dtpm_configfs.c
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2021 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * The DTPM framework defines a set of devices which are power capable.
>> + *
>> + * The configfs allows to create a hierarchy of devices in order
>> + * to reflect the constraints we want to apply to them.
>> + *
>> + * Each dtpm node is created via a mkdir operation in the configfs
>> + * directory. It will create the corresponding dtpm device in the
>> + * sysfs and the 'device' will contain the absolute path to the dtpm
>> + * node in the sysfs, thus allowing to do the connection between the
>> + * created dtpm node in the configfs hierarchy and the dtpm node in
>> + * the powercap framework.
> 
> Tieing configfs and sysfs is very odd, and ripe for problems.  Those are
> independant filesystems with independant devices and paths and object
> lifetimes.  How can you guarantee they all work together ok?

I think my description is not correct. We do not create a sysfs entry,
we create a powercap device. So there is not interaction, just a 1:1
relationship with create/remove and the powercap device.

But I can understand the "path" for the device can be controversial. I
don't see how it can be inconsistent as it refers always to the device
path which does not change but we describe something from one filesystem
to another filesystem.

If it is a problem, it can be removed. Userspace can still do the
connection between the configfs entry name and the device in sysfs by
looking up the name in /sys/devices/virtual/powercap/dtpm/dtpm:*/name.

[ ... ]

>> +static struct config_group *dtpm_cstrn_make_group(struct config_group *grp, const char *name)
>> +{
>> +	struct dtpm *d, *p;
>> +	int ret;
>> +
>> +	if (dtpm_configfs_exists(cstrn_group, name))
>> +		return ERR_PTR(-EEXIST);
>> +
>> +	d = dtpm_lookup(name);
>> +	if (!d) {
>> +		d = kzalloc(sizeof(*d), GFP_KERNEL);
>> +		if (!d)
>> +			return ERR_PTR(-ENOMEM);
>> +		dtpm_init(d, NULL);
>> +	}
>> +
>> +	config_group_init_type_name(&d->cfg, name, &dtpm_cstrn_type);
>> +
>> +	/*
>> +	 * Retrieve the dtpm parent node. The first dtpm node in the
>> +	 * hierarchy constraint is the root node, thus it does not
>> +	 * have a parent.
>> +	 */
>> +	p = (grp == cstrn_group) ? NULL :
>> +		container_of(grp, struct dtpm, cfg);
>> +
>> +	ret = dtpm_register(name, d, p);
> 
> Why isn't the "name" the same name of the sysfs object that the kernel
> created already?
> 
> I still do not understand why you need 2 different names for the same
> device.

Perhaps I answered in the previous email or I am misunderstanding your
question.

The different devices at init time will initialize their power numbers
and allocate a dtpm structure with the ops to get/set the power.

They add the dtpm pointer to a list with the name which is an unique
identifier. At this point, the sysfs object does not exists.

That is what do dtpm_add() / dtpm_del().

When we call the function dtpm_cstrn_make_group(), it call
dtpm_register() with the name and that creates the sysfs object with the
name.


>> +	if (ret)
>> +		goto dtpm_free;
>> +
>> +	if (!try_module_get(THIS_MODULE)) {
> 
> Why are you trying to increment your own module reference count?  That's
> totally racy and does not work.  And you are doing it _way_ after the
> function has been called, what is this for?

Right, it does not make sense.


>> +		ret = -ENODEV;
>> +		goto dtpm_unregister;
>> +	}
>> +
>> +	return &d->cfg;
>> +
>> +dtpm_unregister:
>> +	dtpm_unregister(d);
>> +dtpm_free:
>> +	if (!d->ops)
>> +		kfree(d);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static void dtpm_cstrn_drop_group(struct config_group *grp,
>> +				  struct config_item *cfg)
>> +{
>> +	struct config_group *cg = to_config_group(cfg);
>> +	struct dtpm *d = container_of(cg, struct dtpm, cfg);
>> +
>> +	dtpm_unregister(d);
>> +	if (!d->ops)
>> +		kfree(d);
>> +	module_put(THIS_MODULE);
>> +	config_item_put(cfg);
>> +}
>> +
>> +static struct configfs_group_operations dtpm_cstrn_group_ops = {
>> +	.make_group = dtpm_cstrn_make_group,
>> +	.drop_item = dtpm_cstrn_drop_group,
>> +};
>> +
>> +static ssize_t dtpm_cstrn_device_show(struct config_item *cfg, char *str)
>> +{
>> +	struct config_group *cg = to_config_group(cfg);
>> +	struct dtpm *d = container_of(cg, struct dtpm, cfg);
>> +	struct kobject *kobj = &d->zone.dev.kobj;
> 
> Why are you using the "raw" kobject?
> 
> And wait, a configfs and sysfs object are in the same structure?  You
> just broke lifetime rules again :(
> 
>> +	char *string = kobject_get_path(kobj, GFP_KERNEL);
>> +	ssize_t len;
>> +
>> +	if (!string)
>> +		return -EINVAL;
>> +
>> +	len = sprintf(str, "%s\n", string);
> 
> What sysfs namespace is this in?  This feels really odd to me...
> 
>> +
>> +	kfree(string);
>> +
>> +	return len;
>> +}
>> +
>> +CONFIGFS_ATTR_RO(dtpm_cstrn_, device);
>> +
>> +static struct configfs_attribute *dtpm_cstrn_attrs[] = {
>> +	&dtpm_cstrn_attr_device,
>> +	NULL
>> +};
>> +
>> +static struct config_item_type dtpm_cstrn_type = {
>> +	.ct_owner = THIS_MODULE,
>> +	.ct_group_ops = &dtpm_cstrn_group_ops,
>> +};
>> +
>> +static int __init dtpm_configfs_init(void)
>> +{
>> +	int ret;
>> +
>> +	config_group_init(&dtpm_subsys.su_group);
>> +
>> +	ret = configfs_register_subsystem(&dtpm_subsys);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cstrn_group = configfs_register_default_group(&dtpm_subsys.su_group,
>> +						      "constraints",
>> +						      &dtpm_cstrn_type);
>> +
>> +	/*
>> +	 * The default group does not contain attributes but the other
>> +	 * group will
>> +	 */
>> +	dtpm_cstrn_type.ct_attrs = dtpm_cstrn_attrs;
>> +
>> +	return PTR_ERR_OR_ZERO(cstrn_group);
>> +}
>> +module_init(dtpm_configfs_init);
>> +
>> +static void __exit dtpm_configfs_exit(void)
>> +{
>> +	configfs_unregister_default_group(cstrn_group);
>> +	configfs_unregister_subsystem(&dtpm_subsys);
>> +}
>> +module_exit(dtpm_configfs_exit);
>> +
>> +MODULE_DESCRIPTION("DTPM configuration driver");
>> +MODULE_AUTHOR("Daniel Lezcano");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
>> index e47bd5bbf56e..d7bbb9fd97eb 100644
>> --- a/include/linux/dtpm.h
>> +++ b/include/linux/dtpm.h
>> @@ -8,11 +8,13 @@
>>  #define ___DTPM_H__
>>  
>>  #include <linux/powercap.h>
>> +#include <linux/configfs.h>
>>  
>>  #define MAX_DTPM_DESCR 8
>>  #define MAX_DTPM_CONSTRAINTS 1
>>  
>>  struct dtpm {
>> +	struct config_group cfg;
> 
> You now have 2 reference counted structures trying to control the same
> structure.  Your lifetime rules just got so intertwined and messed up
> it's not going to work, sorry.

Ok, I will rework this part.

Thanks for taking the time to review the patch

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
