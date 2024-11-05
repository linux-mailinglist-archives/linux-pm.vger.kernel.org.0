Return-Path: <linux-pm+bounces-17017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D29BC854
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 09:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB04B220BF
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582311CCEC9;
	Tue,  5 Nov 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRvcu9eY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812591C1738;
	Tue,  5 Nov 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796712; cv=none; b=jr1fCSgDmsBaG86pC35zqc4ZBeyN/QxU6wAOMMV4AJuG/VOLyLI2f8RUEpeV3jwH6VIvZ1RTU4CEZD7KHhDziE8b6iRD341jImL88FCceUdtTYT97bchGz5wRK8wC8BRHtYNuaw2Go+TXZXSes9Ec0H6CoJNj9G2PRTwkA1EteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796712; c=relaxed/simple;
	bh=f1f++oseP5z53a8EZBwl3wZQyH58MDK1VM4I4c5ws5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsvDh5F3ej8vqG2NDmUYRS/RKqjEwo19X41uObso+CHYNQYCjML20DTsjAs3kBDjwdubqBFW263KUQ9cu0R33LwbWktWaB9EUXGJZ1IsxI9ex0xixRLaNqD73y8IFWnhAFhb4LZZ6sCQsdNH9CybnpQRkik2ntRzpRKdB6SU2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRvcu9eY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f2b95775so5858948e87.1;
        Tue, 05 Nov 2024 00:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730796709; x=1731401509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJEtfstV+NvZnqlt/Dxh46XLJUgR+ECVmBD0MQzuU9Q=;
        b=QRvcu9eY05bl6I4Eo8X/W0+n6pSiCJ+/asb9Uxwl+Duc1L9QKx96qPx6O13YSaju6q
         5r4iiSxs+VFwa8QGWRo/Ij+ZbnnTUd2ViRSxC9Px8PEUsEePnK5hGv4lKcFqkx8Ozksw
         8vsOfKEdd+WOvbzamMcFHd4ZmQAglmwsyu7M5umMVgKDf5TJqvaMVDEUtkXVDF3NKOwx
         9Pj4gQ8W2i2KsHPLCcPlz618OMUE5JeVhzv1NpjOPso2DnrnYXATF/M5SHwMz3ugQ/rF
         G0HfFQfCr0F3YKT3iFJyz4KirizFFtpWNjiukmac4nlx4RuwwkN87NZfOQqk+YCW0ZLV
         Kn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730796709; x=1731401509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJEtfstV+NvZnqlt/Dxh46XLJUgR+ECVmBD0MQzuU9Q=;
        b=n8yta+E43Og8pral6Bh+yLwWOXlw6d5XnCrc7WFAK6HNtkTiIL7f3f1CsMvbulGJyi
         nkByeeP9CiOp7mBHCDEtvmUTeDx+qCrvC7yx5H0/sqdPMoi4yNOKyDovJCZOGyZPrAX1
         Rto6+pmxCfTM6aKxTy1kak8NElaCbScaJyt7EB84zpmlTXPvRZrD1lvap5j2Enfbz3v7
         jHmZfZMxwIRz1BLBKUKLPtnYc77Gl29qssuRcWw2zHsVJN0/cITLcrBw7zwzJPSeOEWI
         M4rCeHm/+yvgyPlKKyDafU06hZ0I1KJqrvaUqsGEzxXqrvDfuXc6Nt8kPkyHOErGW+hv
         ItKw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQd3dbO+Yl3fwPZEjThG28iUA1JTKEyooDnRUsr8IW0gRYIROEpIdMgaz9T9zsOM/C42e4jks/A==@vger.kernel.org, AJvYcCXX+aL8dTZRk+cSZdrurhC6mDwASw8xICCNFlDM9F3cKqiX/2QJfeo8h2EAIbt/Y1bMo57WPFdfzxR+o7/CRx+5KbZhNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93jTjCR19IGUBDmIRkLZPmFHBxHb/B4vnW7Ez2LuBtvh/Wxiu
	zMQvGDoTIMmORGfJKHa5l5s1P5NQ1lghUe8KaO7Jld2VXaBFffp7JCBKY9MzZ2qZiNb7LzSHALL
	v1PdM/NlbqhNOY562UfO/dveOXai6MBGSxf0vkA==
X-Google-Smtp-Source: AGHT+IH7pRC9jatDhIceNks3WrokjgSdUgzF0/V0AOFS/A960Brva7gvEjBbHcDxj+l5njGKTSvGHyr0i+AmrN8PRKU=
X-Received: by 2002:a05:6512:2350:b0:53b:7ecc:5ddf with SMTP id
 2adb3069b0e04-53d65df1a08mr10770837e87.26.1730796708287; Tue, 05 Nov 2024
 00:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104203555.61104-1-hdegoede@redhat.com>
In-Reply-To: <20241104203555.61104-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Nov 2024 10:51:10 +0200
Message-ID: <CAHp75Vete6HoHRRef-n2VNTZOawwMeULqH_a-ZD-z-K1iJDiFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86/intel: bytcrc_pwrsrc: Optionally
 register a power_supply dev
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:36=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> On some Android tablets with Crystal Cove PMIC the DSDT lacks an ACPI AC
> device to indicate whether a charger is plugged in or not.
>
> Add support for registering a "crystal_cove_pwrsrc" power_supply class
> device to indicate charger online status. This is made conditional on
> a "linux,register-pwrsrc-power_supply" boolean device-property to avoid
> registering a duplicate power_supply class device on devices where this
> is already handled by an ACPI AC device.
>
> Note the "linux,register-pwrsrc-power_supply" property is only used on
> x86/ACPI (non devicetree) devs and the devicetree-bindings maintainers
> have requested properties like these to not be added to the devicetree
> bindings, so the new property is deliberately not added to any bindings.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

+ array_size.h

> +#include <linux/bits.h>
>  #include <linux/debugfs.h>
> +#include <linux/interrupt.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>

...

> +       if (device_property_read_bool(pdev->dev.parent, "linux,register-p=
wrsrc-power_supply")) {

Btw, is that property type of boolean? If not,
device_property_present() has to be used.

...

> +               irq =3D platform_get_irq(pdev, 0);
> +               if (irq < 0)
> +                       return dev_err_probe(&pdev->dev, irq, "getting IR=
Q\n");

This dups the embedded error message.

...

> +               data->psy =3D devm_power_supply_register(&pdev->dev, &crc=
_pwrsrc_psy_desc, &psy_cfg);
> +               if (IS_ERR(data->psy))
> +                       return dev_err_probe(&pdev->dev, PTR_ERR(data->ps=
y),
> +                                            "registering power-supply\n"=
);
> +
> +               ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +                                               crc_pwrsrc_irq_handler,
> +                                               IRQF_ONESHOT, KBUILD_MODN=
AME, data);
> +               if (ret)
> +                       return dev_err_probe(&pdev->dev, ret, "requesting=
 IRQ\n");

With

    struct device *dev =3D &pdev->dev;

at the top of the function you may make lines shorten and neater.

> +       }

--=20
With Best Regards,
Andy Shevchenko

