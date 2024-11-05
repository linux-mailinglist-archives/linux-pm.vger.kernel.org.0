Return-Path: <linux-pm+bounces-17023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2479BCAA9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 11:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181A81F236AE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9DA1D31A9;
	Tue,  5 Nov 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUbYyhJT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BA1D2F7E;
	Tue,  5 Nov 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803198; cv=none; b=Ggxm80rNsnMaKnhBJWliLgn/3lbtDlFX73QpyAw59NmJVbtn4Y366W1ddln9mmfuRoNkhh1N6OcTA/uBDxF7HeK7Om7eqK7uNxeUpquQ+QTY7gKqu8Y0YUtvwR4FF/pWQf5UrrEH7y7CYvk6sNz3tSPq1//iR4IQdSQkVLyfECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803198; c=relaxed/simple;
	bh=4lI34dvKHgNHOUkI/vFnhgPHUreRbzGpQEDeHHGi/w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhxBiCj4D1+HPocAysYKTGNluSs7QOGbURwv/O5TebGELN1kRgh7Ei3Ss6/askfvLcUvbTqVadgSOmVS1ck3SLi+Bi37S2ggwj8W8IOwkkfPca1dc1yjlK1KLKFowIQaQSxXPqGi29OMLgNbM2dj5jiE2JmyKK6nyZbz858UK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUbYyhJT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9acafdb745so908092466b.0;
        Tue, 05 Nov 2024 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730803195; x=1731407995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zXg7Guy64cNzZb/hZAgtsvKuiNGSRMYLjM/cGzZqmE=;
        b=ZUbYyhJTuAhdAXva5us6TwFNVWUCEega8ghivBQJ1el41Yhg+1QbgsFk0i/1C60ddH
         LmEUv1/lP9Ve9wK3ffhDHgorx5yXJ848TdaZpMnhaTMx7F+SyYZmkPofd45gVRNd05gL
         quln56AtwUhwZzlzO/2VrZ2tMPyMQ4XimWpTlArGWv98U8/pJ4bIsSWcUi5zn5K0i3Fd
         aGOPzUMc7STYmO07498KOSfTzOX/ofAddvrzqxH4LmbxpoJVhPHKUm9B+TQOdYrP8wyM
         wPZpNZkO7vZNC7+qUdbsgcQMBs7rutOO1Am6/E4d6C4MCoZXtsIsbfMNB0gVSIJ31HMg
         L+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803195; x=1731407995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zXg7Guy64cNzZb/hZAgtsvKuiNGSRMYLjM/cGzZqmE=;
        b=v+tFdOApShyFewIXwoy4o7qWoOSXwIJULLXGm7Vz2eqpWkT7AuDsHtK2sdoHIjXcub
         +22OJ54D1Uq3GnWAJQ56OSaxT2YSjVFk9T1g/uO70/FNW4PfWHuO8H0RqkkxAbvlE9Gq
         plSe1sRnIsdCAI0A6a6ymfKJGAFmUiOtdnuLEOQRp9jPN77S7OPHGQTRmtwVEHd7SCBV
         7flS5qrYmn6aInq8AORSo5vpYgCAKZko54tCozDh4cbQaieteTl41OFFFPcSQ56Lzd/O
         BWqQ4un/BpYt247X8A9NgkMeZWKvF2ysfVK8fACv+B+m3aIvj6pmsfD6ZzIPZ2DvW8vQ
         98ew==
X-Forwarded-Encrypted: i=1; AJvYcCUAXmuG3NXDGCMVdE5skJIrLSrG6h2qeSmww58XPPp9d7tookE6SJ1cwaN6V9EL/MlXE0HRdrFAxA==@vger.kernel.org, AJvYcCWLcTgWEy8NSuB7ftY++aXWYi309eXa/jCf6SjudDgDUdRBZa2WS+qNYCKFOV0ozyswRx/X66JiKvCO2ys4aYrNKN4Hng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqN0DZpuhLEZf+SOKMQ/Ta1xMG212K1q4ZR26/SzRjdQ12OEDG
	o0FVGk0ytPS1o3lEjeNYDvJAKxPGxSW9qdA+0O9/ASrs3pTO4sytB/rZOZP/v7WR1KdlBf5KxFx
	eahKJEXjhjnrbl4h/iijykVW6PnRf616ZrSs=
X-Google-Smtp-Source: AGHT+IGyp5qs3OGjZBYXe62SjBEm9TG3IE0LldEbihnyb53iVdCylwWMrR/gWOo3N4VcWuryr9/BUtAQGE/fVMQK/08=
X-Received: by 2002:a17:906:c116:b0:a9a:616c:459e with SMTP id
 a640c23a62f3a-a9e55ae0414mr1808433466b.27.1730803194219; Tue, 05 Nov 2024
 02:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104203555.61104-1-hdegoede@redhat.com> <20241104203555.61104-2-hdegoede@redhat.com>
In-Reply-To: <20241104203555.61104-2-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Nov 2024 12:39:18 +0200
Message-ID: <CAHp75Vdkwg4pUs=k-GNv9wxuecVpMromh_F49bbfhYL7sxjwDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: x86-android-tablets: Add Vexia EDU ATLA
 10 EC battery driver
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:36=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The Vexia EDU ATLA 10 tablet has an embedded controller instead of
> giving the os direct access to the charger + fuel-gauge ICs as is normal
> on tablets designed for Android.
>
> There is ACPI Battery device in the DSDT using the EC which should work
> expect that it expects the I2C controller to be enumerated as an ACPI

expect --> except

> device and the tablet's BIOS enumerates all LPSS devices as PCI devices
> (and changing the LPSS BIOS settings from PCI -> ACPI does not work).
>
> Add a power_supply class driver for the Atla 10 EC to expert battery info
> to userspace. This is made part of the x86-android-tablets directory and
> Kconfig option because the i2c_client it binds to is instantiated by
> the x86-android-tablets kmod.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

>  obj-$(CONFIG_X86_ANDROID_TABLETS) +=3D x86-android-tablets.o
> +obj-$(CONFIG_X86_ANDROID_TABLETS) +=3D vexia_atla10_ec.o

This splits the original (compound) object lines, please move it
either before (and this seems even better with ordering by name in
mind) or after this block.
>

Actually this blank line gives the false impression that the
originally two lines are not related. I would drop this blank line as
well.

>  x86-android-tablets-y :=3D core.o dmi.o shared-psy-info.o \
>                          asus.o lenovo.o other.o

...

> +#include <linux/bits.h>
> +#include <linux/devm-helpers.h>

+ err.h

> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/byteorder.h>

...

> +/* From broken ACPI battery device in DSDT */
> +#define ATLA10_EC_VOLTAGE_MIN_DESIGN           3750000

_uV ?

...

> +struct atla10_ec_battery_state {
> +       u8 len;                         /* Struct length excluding the le=
n field, always 12 */
> +       u8 status;                      /* Using ACPI Battery spec status=
 bits */
> +       u8 capacity;                    /* Percent */
> +       __le16 charge_now;              /* mAh */
> +       __le16 voltage_now;             /* mV */
> +       __le16 current_now;             /* mA */
> +       __le16 charge_full;             /* mAh */
> +       __le16 temp;                    /* centi degrees celcius */

Celsius / celsius

> +} __packed;
> +
> +struct atla10_ec_battery_info {
> +       u8 len;                         /* Struct length excluding the le=
n field, always 6 */
> +       __le16 charge_full_design;      /* mAh */
> +       __le16 voltage_now;             /* mV, should be design voltage, =
but is not ? */
> +       __le16 charge_full_design2;     /* mAh */
> +} __packed;

Instead I would add the respective units to the variable names:
_mAh
_mV
...etc.

(* yes, with the capital letters to follow the proper spelling)

...

> +static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8=
 *values)
> +{
> +       struct device *dev =3D &data->client->dev;
> +       int ret;
> +
> +       ret =3D i2c_smbus_read_i2c_block_data(data->client, cmd, len, val=
ues);
> +       if (ret !=3D len) {
> +               dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
> +               return -EIO;
> +       }

> +       if (values[0] !=3D (len - 1)) {

Hmm... AFAIU this is part of SMBus protocol. Why do we need to care
about this? Or is this an additional header on top of that?

> +               dev_err(dev, "I2C command 0x%02x header length mismatch e=
xpected %u got %u\n",
> +                       cmd, len - 1, values[0]);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}

...

> +               val->intval =3D min(charge_now, charge_full) * 1000;

MILLI (here and below)?

> +               break;
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               val->intval =3D le16_to_cpu(data->state.voltage_now) * 10=
00;
> +               break;
> +       case POWER_SUPPLY_PROP_CURRENT_NOW:
> +               val->intval =3D le16_to_cpu(data->state.current_now) * 10=
00;
> +               /*
> +                * Documentation/ABI/testing/sysfs-class-power specifies
> +                * negative current for discharing.

discharging

> +                */

--
With Best Regards,
Andy Shevchenko

