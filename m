Return-Path: <linux-pm+bounces-40131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57500CEEAA9
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 14:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B28C13014AE9
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575E2D321B;
	Fri,  2 Jan 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwUMmrTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75C42AB7
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767360357; cv=none; b=eRRglJknGC8mlMm18wkw8p4pQNrsW0fZBVBjbsgSXYYNpNN87xKsI+IRqbiL9ZJwIh0PWIlASc8alj65TgzjvT7ZdkV15Ga1hRpIQVFMEvEq6O22qpR56FM8mZ/e4q9Ylk9cHHEyj7LFku1O+o6JkCBhq/ng49/eTWYqJdVYkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767360357; c=relaxed/simple;
	bh=KF3VN9f+VPypAemwcvf4dtXqVD5uF0Sn4u7LNBUQAVU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR9eebk/2ALOUdwgzwCDyuRkcnkaWKPWF2f6j0QGHcC5lsnnC18X7WsHFvpPIt/J8gmi7AUWYtlt9kontTEbZD6XqAGo/pokAHFtIxo/+Bq9824tKljuVVhrtNr6tHl8m33GI5F2OcV79W074tdKHdM1e3igm9lFskJ8DkR2wEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwUMmrTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E79AC116B1
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767360357;
	bh=KF3VN9f+VPypAemwcvf4dtXqVD5uF0Sn4u7LNBUQAVU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=uwUMmrTekAxhNbgEUUEJxWcG8UF5L8GM+ppcX7Rezc75uRUT2yaWySMMoR68vYPrZ
	 F2YsuketkD9KOUFHZycIxVMemfpkCenAorw3D4v5+g5ObGLNKTeZ88tA/chl0whl/Q
	 Z03IS4hq5XlayV3gKyyn2EPjqtnm9+9xsYk3XgQXeiQyVvrjtwGJnS1tbfAYvUP4Zl
	 qF51Biel5gH9HBBC3fwBs5UggIxMvtdqJnnFYsk4xf56JMZfBsDEkgQ8pVe1PAN2Nc
	 A8tOJqQQdvhkKUHD5mZw6wQorfVcV5w50FkvsJwU55dkY2XdkGjc8aRddlTpHE+Ta1
	 5jIEPhwjZWi7Q==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso109507571fa.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 05:25:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkEpKcuqgpPP33nLysGAS5oFk8rlfmlLTpXemOD9YXcvQ/wqIUMFK+erEg0eGSX/Zovo0znVdMkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKM3zYQMDyeodNSY84HQkbtFHIlSd+nqBFFrdsq72+eYsR1LDl
	jpC2FcXll7BTeIKdJRgC5plXfHXjr/Y8mjKroqUBX+hzNt+nf2Z3hQOHHs3Xt2EGIIciM6Y0gCr
	UpQWh/WROk74mdjj372+trxY2J1VcmUNaTuwQ/T9/Jg==
X-Google-Smtp-Source: AGHT+IFHVJSjlpxhjEuVT0/QXQn2++FhCgrKBkU/OwEkhpBCoAmGaRJjp74urE6iT4fK5E4MiDvzh7yk2dC5SoYrdic=
X-Received: by 2002:a05:651c:241:b0:37a:3189:e7b9 with SMTP id
 38308e7fff4ca-3812158e5b2mr101927421fa.16.1767360355811; Fri, 02 Jan 2026
 05:25:55 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 07:25:54 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 07:25:54 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
 <20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 07:25:54 -0600
X-Gmail-Original-Message-ID: <CAMRc=MewoxcijL_OYi=LwWMJmYCSsYFQ2j+koOF5b2_w8VyGsg@mail.gmail.com>
X-Gm-Features: AQt7F2rI3NWR6QuodOzhEpXpogsjLgXzH51rPaAO3w7SLsaoq_EOT9bRmjfQdNo
Message-ID: <CAMRc=MewoxcijL_OYi=LwWMJmYCSsYFQ2j+koOF5b2_w8VyGsg@mail.gmail.com>
Subject: Re: [PATCH v22 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bgolasze@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Dec 2025 19:56:34 +0100, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Currently, there is no standardized mechanism for userspace to discover
> which reboot-modes are supported on a given platform. This limitation
> forces tools and scripts to rely on hardcoded assumptions about the
> supported reboot-modes.
>
> Create a class 'reboot-mode' and a device under it to expose a sysfs
> interface to show the available reboot mode arguments to userspace. Use
> the driver_name field of the struct reboot_mode_driver to create the
> device.  For device-based drivers, configure the device driver name as
> driver_name.
>
> This results in the creation of:
>   /sys/class/reboot-mode/<driver>/reboot_modes
>
> This read-only sysfs file will exposes the list of supported reboot
> modes arguments provided by the driver, enabling userspace to query the
> list of arguments.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 139 +++++++++++++++++++++++++++++++++++++-
>  include/linux/reboot-mode.h       |   1 +
>  2 files changed, 137 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..96d0201697a539c6d048dac021db97e4e3063366 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -6,10 +6,12 @@
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
> +#include <linux/slab.h>
>
>  #define PREFIX "mode-"
>
> @@ -19,6 +21,42 @@ struct mode_info {
>  	struct list_head list;
>  };
>
> +struct sysfs_data {

Let's make this more descriptive? struct reboot_mode_sysfs_data?

> +	const char *mode;
> +	struct list_head list;
> +};
> +
> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sysfs_data *sysfs_info;
> +	struct list_head *head;
> +	ssize_t size = 0;
> +
> +	head = dev_get_drvdata(dev);
> +	if (!head)
> +		return -ENODATA;
> +
> +	list_for_each_entry(sysfs_info, head, list)
> +		size += sysfs_emit_at(buf, size, "%s ", sysfs_info->mode);
> +
> +	if (!size)
> +		return -ENODATA;
> +
> +	return size + sysfs_emit_at(buf, size - 1, "\n");
> +}
> +static DEVICE_ATTR_RO(reboot_modes);
> +
> +static struct attribute *reboot_mode_attrs[] = {
> +	&dev_attr_reboot_modes.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(reboot_mode);
> +
> +static const struct class reboot_mode_class = {
> +	.name = "reboot-mode",
> +	.dev_groups = reboot_mode_groups,
> +};
> +
>  static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>  					  const char *cmd)
>  {
> @@ -62,6 +100,61 @@ static int reboot_mode_notify(struct notifier_block *this,
>  	return NOTIFY_DONE;
>  }
>
> +static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
> +{
> +	struct sysfs_data *sysfs_info;
> +	struct sysfs_data *next;
> +	struct list_head *head;
> +	struct mode_info *info;
> +	int ret;
> +
> +	head = kzalloc(sizeof(*head), GFP_KERNEL);
> +	if (!head) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	INIT_LIST_HEAD(head);
> +
> +	list_for_each_entry(info, &reboot->head, list) {
> +		sysfs_info = kzalloc(sizeof(*sysfs_info), GFP_KERNEL);
> +		if (!sysfs_info) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +
> +		sysfs_info->mode = kstrdup_const(info->mode, GFP_KERNEL);
> +		if (!sysfs_info->mode) {
> +			kfree(sysfs_info);
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +
> +		list_add_tail(&sysfs_info->list, head);
> +	}
> +
> +	reboot->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
> +						   (void *)head, reboot->dev->driver->name);

No, why pass the list? You should create an instance of struct sysfs_data per
device_create(). If it needs to contain a list, then let it contain a list but
don't allocate the list_head, that's really unusual.

> +
> +	if (IS_ERR(reboot->reboot_mode_device)) {
> +		ret = PTR_ERR(reboot->reboot_mode_device);
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	list_for_each_entry_safe(sysfs_info, next, head, list) {
> +		list_del(&sysfs_info->list);
> +		kfree_const(sysfs_info->mode);
> +		kfree(sysfs_info);
> +	}
> +
> +	kfree(head);
> +	reboot->reboot_mode_device = NULL;
> +	return ret;
> +}
> +
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> @@ -113,16 +206,39 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>  	register_reboot_notifier(&reboot->reboot_notifier);
>
> +	ret = reboot_mode_create_device(reboot);
> +	if (ret)
> +		goto error;
> +
>  	return 0;
>
>  error:
> -	list_for_each_entry(info, &reboot->head, list)
> -		kfree_const(info->mode);
> -
> +	reboot_mode_unregister(reboot);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(reboot_mode_register);
>
> +static inline void reboot_mode_unregister_device(struct reboot_mode_driver *reboot)
> +{
> +	struct sysfs_data *sysfs_info;
> +	struct sysfs_data *next;
> +	struct list_head *head;
> +
> +	head = dev_get_drvdata(reboot->reboot_mode_device);
> +	device_unregister(reboot->reboot_mode_device);
> +	reboot->reboot_mode_device = NULL;
> +
> +	if (head) {
> +		list_for_each_entry_safe(sysfs_info, next, head, list) {
> +			list_del(&sysfs_info->list);
> +			kfree_const(sysfs_info->mode);
> +			kfree(sysfs_info);
> +		}

This loop is duplicated, can you please factor it out into a dedicated
function?

> +	}
> +
> +	kfree(head);
> +}
> +
>  /**
>   * reboot_mode_unregister - unregister a reboot mode driver
>   * @reboot: reboot mode driver
> @@ -131,7 +247,11 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>  	struct mode_info *info;
>
> +	if (!reboot->reboot_mode_device)
> +		return -ENODEV;
> +
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
> +	reboot_mode_unregister_device(reboot);
>
>  	list_for_each_entry(info, &reboot->head, list)
>  		kfree_const(info->mode);
> @@ -199,6 +319,19 @@ void devm_reboot_mode_unregister(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
>
> +static int __init reboot_mode_init(void)
> +{
> +	return class_register(&reboot_mode_class);
> +}
> +
> +static void __exit reboot_mode_exit(void)
> +{
> +	class_unregister(&reboot_mode_class);
> +}
> +
> +subsys_initcall(reboot_mode_init);
> +module_exit(reboot_mode_exit);
> +
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_DESCRIPTION("System reboot mode core library");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b56783c32068096325f92445b9530d1856c4826c 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -5,6 +5,7 @@
>  struct reboot_mode_driver {
>  	struct device *dev;
>  	struct list_head head;
> +	struct device *reboot_mode_device;

Why can't this be part of struct (reboot_mode_)sysfs_data?

Bart

>  	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
>  	struct notifier_block reboot_notifier;
>  };
>
> --
> 2.34.1
>
>

