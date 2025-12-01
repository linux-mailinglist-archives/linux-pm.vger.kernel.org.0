Return-Path: <linux-pm+bounces-38967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B7C97972
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 14:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8173A4D87
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92104313260;
	Mon,  1 Dec 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQzliYxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC96311941
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595308; cv=none; b=putklTELgdDIgeRuS0aeQzHra9F0ClhCY1BqkYv7eYwcqCXM9tZVmlQO4TsRFqeemOm6XvRK+ytwF1ivyuTm3e1oFji4lIdM3v+ixKOJi+I1CNTvSG1FKcSc2vuPK1N4qTJeKuNoILmXFsPAZJI2LONh0sgl0hfLGnFJ1cQQwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595308; c=relaxed/simple;
	bh=N4tndToaPzKLG/qUfKZyT2gZg+TFQnYXh5g4htIT7pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+XIixp/EiVx0qxLAODUkoH5yZ/qmstGp+U5zP0KyCWQ4M2oh1Q3qXwUFpvYBkLw3Xuxh2ETABNtShgOTqO+F7SVffaTXh15vXZKFt93q8LywrhQ77zNL19IDCXOH+SFLYEdcKND84sB/XlsNlB8t18aGnFhcbWFuwjD2JUNo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQzliYxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148C5C19421
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 13:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764595308;
	bh=N4tndToaPzKLG/qUfKZyT2gZg+TFQnYXh5g4htIT7pc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vQzliYxaFij2KeCbKFMDuii/oZZ3YbyF9j12quk7XIlgbiw3Bj2g7krdqQksEbeOW
	 bjyJd9qAhMs6Mdb8o3CqKNqCOUqzOONXmxx08NY4QBHvj1q+6lY0kjgWv7TLBKSyAy
	 gZbi2cwgpHRQoEjdsBFm9ztM/CtRaJNvC1FMkYfcfSfNanPT/CzxW2RDpqMy5LtfSB
	 iT2Gkz3ZL+MTTwfX/8gUP5aw/bw1L2pqr227KWmiJgk6q/dWg3e8J7RdMpxWWAXPfY
	 UnM62g0ethuokZqKXTmjWdZZBuZ/xW3SPCi8sWH+Z4tVX3BcBzVDfVsMyTsfGWhsIk
	 z+AsyJCW9R2aA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-594330147efso3944466e87.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 05:21:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFHjds0ep/z0Y21pKqfF5qsKc6XNmaqEoqkukEbGYen0sPI14PrjOzsVKk9Zt4TBbCLgLGWewTdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81boXxE7duFzSNCSgbNoJQ6V3J5cmj0EwgulF+BxAScIESVJp
	XUAajOB/VEA3+yb6PGz7HgY6MpouI+bZhOSHpBKUt5bbwwBuwpssytHingugduRYqz0l1Bvr2Gv
	NN4qcFxg2OZEevEZQ6KC4E4tfUXYmprNm0Wmi+4l+wA==
X-Google-Smtp-Source: AGHT+IG0FNOdfRtPHA3+VgX3/k3LZzA9V4ahiD4uMEi+b9TCuAd+yWr2yPuVWFCAD4KRc7YGFRR1Ed67aCy1a/PqZHk=
X-Received: by 2002:a05:6512:400c:b0:595:81eb:5368 with SMTP id
 2adb3069b0e04-596a3eef46cmr13337404e87.39.1764595306685; Mon, 01 Dec 2025
 05:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
 <20251130-next-15nov_expose_sysfs-v20-2-18c80f8248dd@oss.qualcomm.com>
In-Reply-To: <20251130-next-15nov_expose_sysfs-v20-2-18c80f8248dd@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 1 Dec 2025 14:21:33 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeUoFhmxcxsvboKx1E3KCsqkd081d8e9PypuYCCiL1XFw@mail.gmail.com>
X-Gm-Features: AWmQ_bkGyUzCYupYh4H9zrTju8AEEx7ZqrbnrsCk9eYZAKreADhZ5gd528AVIkc
Message-ID: <CAMRc=MeUoFhmxcxsvboKx1E3KCsqkd081d8e9PypuYCCiL1XFw@mail.gmail.com>
Subject: Re: [PATCH v20 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bgolasze@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 7:21=E2=80=AFPM Shivendra Pratap
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

This should also be documented under Documentation/ABI/.

> This read-only sysfs file will exposes the list of supported reboot
> modes arguments provided by the driver, enabling userspace to query the
> list of arguments.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 76 +++++++++++++++++++++++++++++++++=
++++--
>  include/linux/reboot-mode.h       |  6 ++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..ae03f2d96a84477f1e9f281bf=
3110911d7044a70 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
>
> +#define pr_fmt(fmt)    "reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -19,6 +21,56 @@ struct mode_info {
>         struct list_head list;
>  };
>
> +static ssize_t reboot_modes_show(struct device *dev, struct device_attri=
bute *attr, char *buf)
> +{
> +       struct reboot_mode_driver *reboot;

This is not related to this patch but please consider proposing
renaming of this structure to struct reboot_mode_devicd because
calling it a driver is quite confusing where in reality it's a device.

> +       struct mode_info *info;
> +       ssize_t size =3D 0;
> +
> +       reboot =3D container_of(dev, struct reboot_mode_driver, reboot_mo=
de_device);
> +       if (!reboot)
> +               return -ENODATA;

container_of(p, t, m) returns the address of the structure of type t
containing the member pointed to by p known under the name m in the
type of t. It just calculates the offset between the address of m in t
and p. It's not possible for it to return NULL.

> +       scoped_guard(mutex, &reboot->reboot_mode_mutex) {
> +               list_for_each_entry(info, &reboot->head, list)
> +                       size +=3D sysfs_emit_at(buf, size, "%s ", info->m=
ode);
> +       }
> +
> +       if (!size)
> +               return -ENODATA;
> +
> +       return size + sysfs_emit_at(buf, size - 1, "\n");
> +}
> +static DEVICE_ATTR_RO(reboot_modes);
> +
> +static struct attribute *reboot_mode_attrs[] =3D {
> +       &dev_attr_reboot_modes.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(reboot_mode);
> +
> +static const struct class reboot_mode_class =3D {
> +       .name =3D "reboot-mode",
> +       .dev_groups =3D reboot_mode_groups,
> +};
> +
> +static void reboot_mode_device_release(struct device *dev)
> +{
> +    /* place holder to avoid warning on device_unregister. nothing to fr=
ee */
> +}
> +
> +static void reboot_mode_register_device(struct reboot_mode_driver *reboo=
t)
> +{
> +       int ret;
> +
> +       reboot->reboot_mode_device.class =3D &reboot_mode_class;
> +       reboot->reboot_mode_device.release =3D reboot_mode_device_release=
;
> +       dev_set_name(&reboot->reboot_mode_device, reboot->driver_name);
> +       /* Check return value to avoid compiler warning */
> +       ret =3D device_register(&reboot->reboot_mode_device);
> +       if (ret)
> +               pr_debug("device_register failed for %s : %d\n", reboot->=
driver_name, ret);
> +}

I'm not sure if this has been addressed before but why is this even
optional? Why don't we just return -1 here if we fail to register the
device?

And just for the record: I'm still convinced that using
device_create() here will result in nicer code and allow us to contain
the associated reboot_mode_device inside this compilation unit.

If Bjorn really insists on keeping it this way though, then you need
at least a call to device_initialize() here.

> +
>  static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reb=
oot,
>                                           const char *cmd)
>  {
> @@ -76,6 +128,7 @@ int reboot_mode_register(struct reboot_mode_driver *re=
boot)
>         size_t len =3D strlen(PREFIX);
>         int ret;
>
> +       mutex_init(&reboot->reboot_mode_mutex);
>         INIT_LIST_HEAD(&reboot->head);
>
>         for_each_property_of_node(np, prop) {
> @@ -112,6 +165,7 @@ int reboot_mode_register(struct reboot_mode_driver *r=
eboot)
>
>         reboot->reboot_notifier.notifier_call =3D reboot_mode_notify;
>         register_reboot_notifier(&reboot->reboot_notifier);
> +       reboot_mode_register_device(reboot);
>
>         return 0;
>
> @@ -132,9 +186,13 @@ int reboot_mode_unregister(struct reboot_mode_driver=
 *reboot)
>         struct mode_info *info;
>
>         unregister_reboot_notifier(&reboot->reboot_notifier);
> +       if (device_is_registered(&reboot->reboot_mode_device))
> +               device_unregister(&reboot->reboot_mode_device);

If you bail out of reboot_mode_register_device(), you don't need the
above check anymore because the device could

Bart

