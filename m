Return-Path: <linux-pm+bounces-8385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93098D3AB3
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC1D1C2410D
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE4180A9F;
	Wed, 29 May 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB6Y8QYc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AE180A8B
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996144; cv=none; b=nShm9zOGCWiyzCqMx7LhNVvJ80mtre3oQEbeToQKnp1XlHS6Sag7ETC6ofHpeFjoMaPsKky4aRFK5SpwIAoKvaNK52ETLl7xf+khgDIfwaMYUgsN9E+qzLPa7Jxapu96Lf8YTrts9wKwoyqepMWoxW0oLkasENVO8THEAs/PuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996144; c=relaxed/simple;
	bh=ftdb1zmL/72PvtsH9vB/i7unc05q/XJ1MbfMwbPqDoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOH8l3vc45JNe7dt2deUXkHF46YHtaSiFRMK4g/fd8JRF7furwFomholxfc0oGjc9m/kCdQvC/JXeTpaCqU3FwfvHcQN99l8znH5C/8k0RPdU1LIlFc5IVehg6HbNh9N5N88E5gqdDaDX3H1bbY8vPwYpMddGQr0eax1ZkUxwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qB6Y8QYc; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so832043276.1
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716996142; x=1717600942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVNOgelONT07b9FQMGSY/r/Dp2asYo6hWXODwZeg4Kk=;
        b=qB6Y8QYcYH1arSgMPD8SGZMN5e0gw8pdxETMGC78SOhWbMbyFXglp6tybyyXWSVRIN
         DMKVk1rsTk4tBN8IeJdt8G0SSGaKN8IwwzNUx+KWsBQf783gyYTfHWDk009q6AsdyD2z
         +1drkaV7AgSGPVJ+q6XZG3VzBwvLY2DTSt+DptRUoqC+SYoIArlrEDbGMvzcGrFdmfDH
         rEYoK7H6H3o031d+ELHj0+Epx3f28GHUtOxCdsms+ij/NjNl7sGET6fl2YlXRgk1c6Pa
         UtAZ/0kWRHU744TTCGR7iUnrbUVvxxYsWFb/fFWBwnf12ctyYOQuNxA1rGojc9OjUKOn
         1+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996142; x=1717600942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVNOgelONT07b9FQMGSY/r/Dp2asYo6hWXODwZeg4Kk=;
        b=wQEXdTJe8X0lqJoAVgVIOVtm9HDXdRJ1+ImbEa2HaOoncLgihXIXs+yaVXcIqvAbZ+
         h8txd+N6iDcvcquCyf2FtgJl2+4LB+Ny69Up31an6g0Ce8CQOHjAj+YfwusxcNKPvh1F
         uTgsVSN2yMG6XaAChnsKd1Dv9Zm4ca1hgwa3exFARO5mOdmZmHrOzMcJAe1DFiTiq8IE
         5zDMnNpd8DO4CJdoGkDap88aAFpiqm/SXyiQgLEYiU3DAp7Cjid+3Dzp6RZwrojjcPeF
         vba7IwpI98nQ19vgGKkl7Zk4fssMTcT55KY0RJOoqOMSuxm/wuxZfkUvIlTKHXNDOHD1
         xIVw==
X-Forwarded-Encrypted: i=1; AJvYcCUEut7Y08mxLJ64UX/9i1axGZIlbLOsYlI383zKYhQIGsRJuIBFD8qeybhaLQx1tl/QiPfL54EJ2rB93YRpMDDdkMG4Xa4QJZw=
X-Gm-Message-State: AOJu0YwxkZ0bMeMGWu0ljS50V1fuiUIF8S+L2H6y6oI6zRMP//lF5oUA
	9El2d0kDeM2HSi2zvg7P0l4WeexfKAhkWdsc5IB4BcjsgtjbiQ8NdyPGZVv3GgfO0gtH7rKyz3y
	RyfzjoMjRy7qpEXNbthSPNTPviePnv5JOBGAzMg==
X-Google-Smtp-Source: AGHT+IFEEwc2BzA0rX78s94Zqs2JUVOvx29Z00Sv0+XpxHmRvPtJIPPoRxajiH7TOZW3YzoQpbeJXN26G/E57oUUVgs=
X-Received: by 2002:a5b:b49:0:b0:dfa:4ff5:d55d with SMTP id
 3f1490d57ef6-dfa4ff5d6f4mr1490315276.49.1716996141911; Wed, 29 May 2024
 08:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
 <20240528-yoga-ec-driver-v4-3-4fa8dfaae7b6@linaro.org> <ce6cbe69-f1de-1224-2a6e-3c7b07203d84@linux.intel.com>
In-Reply-To: <ce6cbe69-f1de-1224-2a6e-3c7b07203d84@linux.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 17:22:10 +0200
Message-ID: <CAA8EJproC_mW4pZ_C-BUUm73xfqja0EKVLvCZ+C_1dhW3xoEnw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 at 17:20, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 28 May 2024, Dmitry Baryshkov wrote:
>
> > The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> > the onboard EC. Add glue driver to interface the platform's UCSI
> > implementation.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/usb/typec/ucsi/Kconfig          |   9 ++
> >  drivers/usb/typec/ucsi/Makefile         |   1 +
> >  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 189 ++++++++++++++++++++++++=
++++++++
> >  3 files changed, 199 insertions(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kc=
onfig
> > index bdcb1764cfae..680e1b87b152 100644
> > --- a/drivers/usb/typec/ucsi/Kconfig
> > +++ b/drivers/usb/typec/ucsi/Kconfig
> > @@ -69,4 +69,13 @@ config UCSI_PMIC_GLINK
> >         To compile the driver as a module, choose M here: the module wi=
ll be
> >         called ucsi_glink.
> >
> > +config UCSI_LENOVO_YOGA_C630
> > +     tristate "UCSI Interface Driver for Lenovo Yoga C630"
> > +     depends on EC_LENOVO_YOGA_C630
> > +     help
> > +       This driver enables UCSI support on the Lenovo Yoga C630 laptop=
.
> > +
> > +       To compile the driver as a module, choose M here: the module wi=
ll be
> > +       called ucsi_yoga_c630.
> > +
> >  endif
> > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/M=
akefile
> > index b4679f94696b..aed41d23887b 100644
> > --- a/drivers/usb/typec/ucsi/Makefile
> > +++ b/drivers/usb/typec/ucsi/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)                     +=3D ucsi=
_acpi.o
> >  obj-$(CONFIG_UCSI_CCG)                       +=3D ucsi_ccg.o
> >  obj-$(CONFIG_UCSI_STM32G0)           +=3D ucsi_stm32g0.o
> >  obj-$(CONFIG_UCSI_PMIC_GLINK)                +=3D ucsi_glink.o
> > +obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)  +=3D ucsi_yoga_c630.o
> > diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/type=
c/ucsi/ucsi_yoga_c630.c
> > new file mode 100644
> > index 000000000000..ca1ab5c81b87
> > --- /dev/null
> > +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2022-2024, Linaro Ltd
> > + * Authors:
> > + *    Bjorn Andersson
> > + *    Dmitry Baryshkov
> > + */
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_data/lenovo-yoga-c630.h>
> > +
> > +#include "ucsi.h"
> > +
> > +struct yoga_c630_ucsi {
> > +     struct yoga_c630_ec *ec;
> > +     struct ucsi *ucsi;
> > +     struct notifier_block nb;
> > +     struct completion complete;
>
> Add includes for what you used here.
>
> > +     unsigned long flags;
> > +#define UCSI_C630_COMMAND_PENDING    0
> > +#define UCSI_C630_ACK_PENDING                1
> > +     u16 version;
> > +};
> > +
> > +static  int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset=
,
>
> extra space
>
> > +                             void *val, size_t val_len)
> > +{
> > +     struct yoga_c630_ucsi *uec =3D ucsi_get_drvdata(ucsi);
>
> Missing include for ucsi_get_drvdata

I'll review my includes, but this comment and the comment for
ucsi_operations are clearly wrong. There is a corresponding include.

>
> > +     u8 buf[YOGA_C630_UCSI_READ_SIZE];
> > +     int ret;
> > +
> > +     ret =3D yoga_c630_ec_ucsi_read(uec->ec, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (offset =3D=3D UCSI_VERSION) {
> > +             memcpy(val, &uec->version, min(val_len, sizeof(uec->versi=
on)));
> > +             return 0;
> > +     }
> > +
> > +     if (offset =3D=3D UCSI_CCI)
> > +             memcpy(val, buf,
> > +                    min(val_len, YOGA_C630_UCSI_CCI_SIZE));
>
> Fits to one line.
>
> > +     else if (offset =3D=3D UCSI_MESSAGE_IN)
> > +             memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
> > +                    min(val_len, YOGA_C630_UCSI_DATA_SIZE));
> > +     else
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static  int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int=
 offset,
>
> extra space, there seems to be more of them below but I won't mark them.
>
> > +                                    const void *val, size_t val_len)
> > +{
> > +     struct yoga_c630_ucsi *uec =3D ucsi_get_drvdata(ucsi);
> > +
> > +     if (offset !=3D UCSI_CONTROL ||
> > +         val_len !=3D YOGA_C630_UCSI_WRITE_SIZE)
> > +             return -EINVAL;
> > +
> > +     return yoga_c630_ec_ucsi_write(uec->ec, val);
> > +}
> > +
> > +static  int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int =
offset,
> > +                                   const void *val, size_t val_len)
> > +{
> > +     struct yoga_c630_ucsi *uec =3D ucsi_get_drvdata(ucsi);
> > +     bool ack =3D UCSI_COMMAND(*(u64 *)val) =3D=3D UCSI_ACK_CC_CI;
> > +     int ret;
> > +
> > +     if (ack)
> > +             set_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> > +     else
> > +             set_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
>
> Include for set_bit()
>
> > +     reinit_completion(&uec->complete);
> > +
> > +     ret =3D yoga_c630_ucsi_async_write(ucsi, offset, val, val_len);
> > +     if (ret)
> > +             goto out_clear_bit;
> > +
> > +     if (!wait_for_completion_timeout(&uec->complete, 5 * HZ))
> > +             ret =3D -ETIMEDOUT;
> > +
> > +out_clear_bit:
> > +     if (ack)
> > +             clear_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> > +     else
> > +             clear_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
> > +
> > +     return ret;
> > +}
> > +
> > +const struct ucsi_operations yoga_c630_ucsi_ops =3D {
>
> Include for ucsi_operations.
>
> > +     .read =3D yoga_c630_ucsi_read,
> > +     .sync_write =3D yoga_c630_ucsi_sync_write,
> > +     .async_write =3D yoga_c630_ucsi_async_write,
> > +};
> > +
> > +static int yoga_c630_ucsi_notify(struct notifier_block *nb,
> > +                              unsigned long action, void *data)
> > +{
> > +     struct yoga_c630_ucsi *uec =3D container_of(nb, struct yoga_c630_=
ucsi, nb);
>
> Include for container_of
>
> --
>  i.
>


--=20
With best wishes
Dmitry

