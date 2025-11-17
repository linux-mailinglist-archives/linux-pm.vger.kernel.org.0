Return-Path: <linux-pm+bounces-38129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D1C645A9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16083A97B7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234E331A5F;
	Mon, 17 Nov 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXEs49DX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D1331A55
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385958; cv=none; b=fgyeBh4h6k0VU3DhdrY2leJYCieCXdS3e8Fmmcz1Ji5NR5RMOebNks492zEa251UzEcA2GG8JK98fBQaiY1wC5tlViqCwIey+9aCCiS+YRJ3M1ONXyI/Q/Y7zJ6grAZ2jmzZCS0H6QIczHddD5bntLUTmUkyQJT0Q5dFDs3bvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385958; c=relaxed/simple;
	bh=BXrkaPWSS4ADX1uV9kOtNe4mMT/WZtJVEu732fC+Nsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4c2e+RmqFEAH7xnSkkuQGyvyjC7HO3Q89jxrxZYkZRzRZPbrIl93O4QPsdU/aoSF3dXKU0dpjJC9I9x0GWDLjCqz/z3SjRmG5wZOPzf+ffLU7lrFQqPqD6iZ1aHv7jPQcRRqvtDpBZvWJva2R+10oU9P8kk9saOjPMntGvhMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZXEs49DX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so6122963a12.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763385955; x=1763990755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKrCcNYpwdQk4idzk2CaMl1TyunpWVVmxS8N4sU6sgM=;
        b=ZXEs49DXok9qsNJGDEed75ch4EE4emxdz0OrONswDKPI7biOc+XLwta3F1bGgY+7ZD
         zyDtlJeI2I2fLo/0Q8BYW6qfE/fdzHbYETPohTHGTdiDCKkp7uojcbxiRKdrn7qvk1Y3
         oLCgWJAeLVJDLkoJlIa/E9z5HKP7vEwPSVskYkAuvtu6hHrIBXcFENdXGl/EXAxxPiJI
         5k7Ha2iuByhrH3VWDc1jYO2+k706r2+g5DN4i6xhsC/CkoofKxp+Bk2jrg9eQQ0I698Q
         S7es/ajWmGhb0TeA/74VHz62tg/+1ynKnPmMUgcwRVSif9TtQ4aLpMNHqHJ4VgxiV6IR
         Kf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385955; x=1763990755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKrCcNYpwdQk4idzk2CaMl1TyunpWVVmxS8N4sU6sgM=;
        b=gxl5AfrNQvXah9QCwrmeBspEEclS77ispQ23hMLjEvI4Dti13r/ZPBOm98KiT+bj1t
         q5JHJSivbJUKhGDqWXjop3+XJhU0n0U/Sj258pyl3NRwnAoouGzU8uFcdjJiHTIl5HsH
         NF20oS8qan4TkaXVWqUb1CBGPUviecp0yt9/X+2MU0YeYzpKecWC1YJHB45FYWGPWBR6
         XZFDUXSIQmfGTy8upuaisp+i2h0catvk21Or2xD6RnHhY9dzCjKcf4vEQkZITdd3COTa
         JJ0hcfNMCa8y8hQvmoDzCJcvB2ejI3Xz8jNFUsRI80zV4iG5ZcUP6q4rh3WzbBV0IXKj
         AZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXA0jF1/GBWbmMA164f29aXaId7OzD8Frb+4Q3UCQ+o2gQCnx1NTozJQcXiAi3D0ks6eBdrJ613nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxliOk6Wzv0NVIJSivqhlTBO4fZ+TxVqHVhmimP2NihV8H3+qgI
	WBwtbqXrL9/WIN5woc4PNtZ8Sfyl/IqCNsW8sT+cYzIY163iYbhjbN9aaTwUD+KqnHLrTDIN0ov
	xHCb8HHttwI7FxunA2Q4YbhD3TlEHUur0qE2tXbI+CA==
X-Gm-Gg: ASbGncs6V3+rpGpsBClRMe6WDVAoNzsKjoBWb/s/90a2gvWJVQ1UIjKPwy+fH70QvYp
	HpBmc5n7ZFi6nP+mAhlUwxLTCQEgOU8arW3LbYir4nEZneDKHfJ124EJ9y6nqdtk60HcGS9zPKV
	XT1D0xZewASLpFg4aungJ0emLLa/sief5aAD5uTCXKdn0gKjUMNnSYYDeE3tX/UBzALJzoGZB7a
	52DYbP+fSB/KFIy/A2OrF1hmMdqhhyadsWUQp7B8SraTWy1gz3hJRi7MWfymN2CagJFVNftWcjp
	KKw6vNiA5KcSom0AAoMwjvtgago4KhLd7lHa5A==
X-Google-Smtp-Source: AGHT+IGA9IKPcA2NVRU837UYITNqUiXqVbs8u2QaPkG4oxbaV5NUnuCMpfTaiZd84H+nHDlEyxQ+y6jkHzkDtmQk7r0=
X-Received: by 2002:a17:906:dc8b:b0:b73:7ebd:469d with SMTP id
 a640c23a62f3a-b737ebd51c7mr700980966b.18.1763385954694; Mon, 17 Nov 2025
 05:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <20251116-next-15nov_expose_sysfs-v1-2-3b7880e5b40e@oss.qualcomm.com>
In-Reply-To: <20251116-next-15nov_expose_sysfs-v1-2-3b7880e5b40e@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 17 Nov 2025 14:25:42 +0100
X-Gm-Features: AWmQ_bko9MypuXVKQ-ri649OhlUs0218mLgHlt4bzFRM40wdm7fFs3mbaFjy7YE
Message-ID: <CACMJSeu6BGS+AyEXyR9S7d6qGkbP3GiEzq6qy1860QaOQ-peQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 16 Nov 2025 at 16:20, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
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
>  drivers/power/reset/reboot-mode.c | 72 +++++++++++++++++++++++++++++++++++++++
>  include/linux/reboot-mode.h       |  3 ++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..062df67735c4818cfeb894941e537f19ea9d4ccb 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -7,18 +7,77 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
>
>  #define PREFIX "mode-"
>
> +static DEFINE_MUTEX(reboot_mode_mutex);
> +
>  struct mode_info {
>         const char *mode;
>         u32 magic;
>         struct list_head list;
>  };
>
> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct reboot_mode_driver *reboot;
> +       struct mode_info *info;
> +       ssize_t size = 0;
> +
> +       reboot = container_of(dev, struct reboot_mode_driver, reboot_mode_device);
> +       if (!reboot)
> +               return -ENODATA;
> +
> +       list_for_each_entry(info, &reboot->head, list)
> +               size += sysfs_emit_at(buf, size, "%s ", info->mode);
> +
> +       if (!size)
> +               return -ENODATA;
> +
> +       return size + sysfs_emit_at(buf, size - 1, "\n");
> +}
> +static DEVICE_ATTR_RO(reboot_modes);
> +
> +static struct attribute *reboot_mode_attrs[] = {
> +       &dev_attr_reboot_modes.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(reboot_mode);
> +
> +static const struct class reboot_mode_class = {
> +       .name = "reboot-mode",
> +       .dev_groups = reboot_mode_groups,
> +};
> +
> +static void reboot_mode_device_release(struct device *dev)
> +{
> +    /* place holder to avoid warning on device_unregister. nothing to free */
> +}
> +
> +static void reboot_mode_create_device(struct reboot_mode_driver *reboot)
> +{
> +       static bool is_class_registered;
> +
> +       reboot->reboot_mode_device_registered = false;
> +
> +       scoped_guard(mutex, &reboot_mode_mutex) {
> +               if (!is_class_registered) {
> +                       if (!class_register(&reboot_mode_class))
> +                               is_class_registered = true;
> +               }
> +       }

This could be achieved with DO_ONCE() but you still haven't explained
why this needs to be done here. Why not in the module's
subsys_initcall()? As of now, the class will not appear in sysfs until
the first device is registered which isn't a very common behavior.

Bart

> +
> +       reboot->reboot_mode_device.class = &reboot_mode_class;
> +       reboot->reboot_mode_device.release = reboot_mode_device_release;
> +       dev_set_name(&reboot->reboot_mode_device, reboot->driver_name);
> +       if (!device_register(&reboot->reboot_mode_device))
> +               reboot->reboot_mode_device_registered = true;
> +}
> +
>  static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>                                           const char *cmd)
>  {
> @@ -78,6 +137,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>
>         INIT_LIST_HEAD(&reboot->head);
>
> +       reboot_mode_create_device(reboot);
> +
>         for_each_property_of_node(np, prop) {
>                 if (strncmp(prop->name, PREFIX, len))
>                         continue;
> @@ -119,6 +180,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>         list_for_each_entry(info, &reboot->head, list)
>                 kfree_const(info->mode);
>
> +       if (reboot->reboot_mode_device_registered) {
> +               device_unregister(&reboot->reboot_mode_device);
> +               reboot->reboot_mode_device_registered = false;
> +       }
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(reboot_mode_register);
> @@ -136,6 +202,11 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>         list_for_each_entry(info, &reboot->head, list)
>                 kfree_const(info->mode);
>
> +       if (reboot->reboot_mode_device_registered) {
> +               device_unregister(&reboot->reboot_mode_device);
> +               reboot->reboot_mode_device_registered = false;
> +       }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(reboot_mode_unregister);
> @@ -162,6 +233,7 @@ int devm_reboot_mode_register(struct device *dev,
>         if (!dr)
>                 return -ENOMEM;
>
> +       reboot->driver_name = reboot->dev->driver->name;
>         rc = reboot_mode_register(reboot);
>         if (rc) {
>                 devres_free(dr);
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..400cfde0e029aef14ff90a11b9d12d0c3ce8dee6 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -5,6 +5,9 @@
>  struct reboot_mode_driver {
>         struct device *dev;
>         struct list_head head;
> +       const char *driver_name;
> +       struct device reboot_mode_device;
> +       bool reboot_mode_device_registered;
>         int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
>         struct notifier_block reboot_notifier;
>  };
>
> --
> 2.34.1
>

