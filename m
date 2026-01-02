Return-Path: <linux-pm+bounces-40111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9BCEE200
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 11:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C7863003BCF
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259132D8DBB;
	Fri,  2 Jan 2026 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZSAsRtG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06912D480F
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767348365; cv=none; b=bKji7jq4y4c1I2giWAzFqEs9wHdFNV2NOZMjsqNBpzFjlJL0z3qQ6f3GXb9IyxEGpHz6IanKaUDrp7FARBqP+Ntr3/CpU2oTGOV2mLHcRHt4lovOERGj81/uViDJ1Db5fkllMexLIdp5i5xDXEk9AiSf5nuk/+RNMlhsyL0stHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767348365; c=relaxed/simple;
	bh=gchyAxkFCm31zIKqZC5yld6T9YtZLl36hqgAgO5bNfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4Tm/3eKegUw87Fqfv3KBqhEK94MYz/enDr2llD09rrmRwd1gweU4niKXv1OSCfOC8hVlNOt+HNHQc8tHoBusN0+HOC2ldglE2WbsnfMdTJzpx+FTZljRygSb6X0aUWFU9SoRc25aF3BFV58ps/p6g5TACuS6pjCW/kVRS1d4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZSAsRtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88347C2BCB6
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767348364;
	bh=gchyAxkFCm31zIKqZC5yld6T9YtZLl36hqgAgO5bNfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GZSAsRtGHFfgeoTVK33CkuT63zYzQxc0+NFc5Iy5UrH7TxPBQBt+9sQrDIDkP90Sf
	 JUv7c33zMLlROsCZXUAdhPRJLj/CUcb4F4seEJScZHGWhHdOxx+zjFI+TlwRzAMSl4
	 pkYtn8UCGs0DXwwGfc7z6u/twcFCK+HiZCH6ijKhQ1HTjX3903/lZVJzUxihxmuwMX
	 YrZQoGndxqELJBKEimE4VmEsEheiW/URzXqP8QxWp3V6oIYlpbs4UXW37ez6Uo+WAZ
	 0CIiWOEkCTiwly2W1zkmuNPhCw3Tv9PU8TxfOe8aqsf71nfLgt6BU14qburCTS+lqU
	 QUTBzfAadJNEg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-598eaafa587so13651584e87.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 02:06:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBZlwfBQ59hf6wxrviYcBXNkz0CZGyv2h59n6TwaCLi0mKZLK7HhMIqbA48o1pbjJvJVB13zxE8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxiKsSJ1MTDRGU3GVTCj/6RyaKi+XdQc5aJO00NxQt8P3X3HY
	A4Cd0vD9HJCLtdiZiSxbz4mTXtjwrThSfM0AhJeGY8Fljs8gq01em8NnBcLqQ9NXdG0zZLBNSne
	Ts+X3q+W5Mnod5ZTT1Ylyhllg2IBVDg9rcOEkpTTREQ==
X-Google-Smtp-Source: AGHT+IFGdco3IkndyZVqVIrcNxSfB0QYH1orte4zZsqd4dtQJlhjdGqzpakv3I4zCBg3a81gJfH5GvwcXtaxtjuHS/o=
X-Received: by 2002:a05:6512:131c:b0:593:ffa:6988 with SMTP id
 2adb3069b0e04-59a17d9707fmr14535500e87.21.1767348362869; Fri, 02 Jan 2026
 02:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:05:50 +0100
X-Gmail-Original-Message-ID: <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
X-Gm-Features: AQt7F2p5KpT_VMscgdeBfPWopnrQ29TsIsrUWNt-I0niquK6j9g2Sp51yPziFyA
Message-ID: <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
Subject: Re: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based allocations
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 6:20=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Devres APIs are intended for use in drivers, where the managed lifetime
> of resources is tied directly to the driver attach/detach cycle. In
> shared subsystem code, there is no guarantee that the subsystem
> functions will only be called after a driver has been attached, nor that
> they will not be referenced after the managed resources have been
> released during driver detach.
>
> To ensure correct lifetime handling, avoid using devres-based
> allocations in the reboot-mode and explicitly handle allocation and
> cleanup of resources.
>
> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 34 ++++++++++++++++++++++-----------=
-
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..3af6bc16a76daee686e8110b7=
4e71b0e62b13ef8 100644
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
> @@ -10,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
> +#include <linux/slab.h>
>
>  #define PREFIX "mode-"
>
> @@ -71,9 +74,11 @@ static int reboot_mode_notify(struct notifier_block *t=
his,
>  int reboot_mode_register(struct reboot_mode_driver *reboot)
>  {
>         struct mode_info *info;
> +       struct mode_info *next;
>         struct property *prop;
>         struct device_node *np =3D reboot->dev->of_node;
>         size_t len =3D strlen(PREFIX);
> +       u32 magic;
>         int ret;
>
>         INIT_LIST_HEAD(&reboot->head);
> @@ -82,19 +87,17 @@ int reboot_mode_register(struct reboot_mode_driver *r=
eboot)
>                 if (strncmp(prop->name, PREFIX, len))
>                         continue;
>
> -               info =3D devm_kzalloc(reboot->dev, sizeof(*info), GFP_KER=
NEL);
> +               if (of_property_read_u32(np, prop->name, &magic)) {

Please use device_property_read_u32() if you have access to a device struct=
.

> +                       pr_err("reboot mode %s without magic number\n", p=
rop->name);

If this is an error, shouldn't we bail out?

> +                       continue;
> +               }
> +
> +               info =3D kzalloc(sizeof(*info), GFP_KERNEL);
>                 if (!info) {
>                         ret =3D -ENOMEM;
>                         goto error;
>                 }
>
> -               if (of_property_read_u32(np, prop->name, &info->magic)) {
> -                       dev_err(reboot->dev, "reboot mode %s without magi=
c number\n",
> -                               info->mode);
> -                       devm_kfree(reboot->dev, info);
> -                       continue;
> -               }
> -
>                 info->mode =3D kstrdup_const(prop->name + len, GFP_KERNEL=
);
>                 if (!info->mode) {
>                         ret =3D  -ENOMEM;
> @@ -102,8 +105,7 @@ int reboot_mode_register(struct reboot_mode_driver *r=
eboot)
>                 } else if (info->mode[0] =3D=3D '\0') {
>                         kfree_const(info->mode);
>                         ret =3D -EINVAL;
> -                       dev_err(reboot->dev, "invalid mode name(%s): too =
short!\n",
> -                               prop->name);
> +                       pr_err("invalid mode name(%s): too short!\n", pro=
p->name);
>                         goto error;
>                 }
>
> @@ -116,8 +118,12 @@ int reboot_mode_register(struct reboot_mode_driver *=
reboot)
>         return 0;
>
>  error:
> -       list_for_each_entry(info, &reboot->head, list)
> +       kfree(info);
> +       list_for_each_entry_safe(info, next, &reboot->head, list) {
> +               list_del(&info->list);
>                 kfree_const(info->mode);
> +               kfree(info);
> +       }
>
>         return ret;
>  }
> @@ -130,11 +136,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>         struct mode_info *info;
> +       struct mode_info *next;
>
>         unregister_reboot_notifier(&reboot->reboot_notifier);
>
> -       list_for_each_entry(info, &reboot->head, list)
> +       list_for_each_entry_safe(info, next, &reboot->head, list) {
> +               list_del(&info->list);
>                 kfree_const(info->mode);
> +               kfree(info);
> +       }

The code is repeated here, maybe factor it out into a separate function?

>
>         return 0;
>  }
>
> --
> 2.34.1
>

Bart

