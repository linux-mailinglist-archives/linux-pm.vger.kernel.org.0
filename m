Return-Path: <linux-pm+bounces-19784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484879FD6E5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 19:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5A5164ED1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A301F893B;
	Fri, 27 Dec 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixgwggbo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCE1F7545;
	Fri, 27 Dec 2024 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323714; cv=none; b=lN/0lFtaBL6OxpqspJGobo0pC7a1hWV0QOvF8E0dYj91t499PH/5q6wBm5ElICdt1TFJEc3Lvm/N55YNcQYEHZKabGCyah4h2gL86iudDouKdg0SYsU0rZLhTO5uDfisJcMQHF83Na9Ad0keG2QBsm/2WlX1/RcXdvfIeEVixJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323714; c=relaxed/simple;
	bh=vBrJrY2Hj5tOfoJWfOPTHktpGDYBEUFhYbFgydkxqwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qA7qVVtWAfroaJVH18nbx2B9DZScVdAEp6j38qobJNVWQEWIC3uaIOBo0UBodzG/qDfPb3x9E7/wTby/wymLHzd3cjmy+TfcR/u6FA/AbRtB4xfuo9rJZePyrkZAx9POL8de84uERgjpy6rZnKrSuPQU8t25UAropbatcovRh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixgwggbo; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a01bcd0143so4982670fac.2;
        Fri, 27 Dec 2024 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735323710; x=1735928510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPsu1IPBLIzjgQtca2rKf1h+8+lUSjMS4XekT8YOWuU=;
        b=IxgwggboVuPAyQ7Y5DBdY3P7VeAeVMzkw70hAFbATzVgM4EN8OUb604dGpWHpv5GA3
         xT4IK6ILUJTCdz31e2Y1l+DLAVB1rMVOrCIrzgjdYCMo+BXmxROTiWAivJ6jwFVLjjEk
         s3dbesXyszD2Q4NkaEguSPqn1lZUvIWpIYyMe7WcQg4sE/2ZXfohM4ooeSMmFFM5m9Fe
         96acyIGR0FZE3cu2ex2tdDVzYp1/UmWKGqW7LxzmfvQXKSrDVtIZn/FIaOfIyYYihUKd
         fZ3IeEMVU261qaJqyfYYNjNBtMMyfVRHxvOgFZIiByfWAzQFWdfyN6rOA3MRXRGE+Nbe
         T1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735323710; x=1735928510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPsu1IPBLIzjgQtca2rKf1h+8+lUSjMS4XekT8YOWuU=;
        b=Ncmflh6CEPeW/UqyDs/6pT2Sbwo55wl+BZFeo1AIFvszYBjOferY0+LnDzGPvYWg/e
         hzy5rmpQJrAbTL/ADE68/klfUP30mm7ojTr8cZa0f1YDsdbZXCFwUQNx+ohmv+GtAK2J
         7fi6OY0H6/TK6gIUg19fN7JgcplInFMIezxaKVoyW+PXjq4IfZZ3ioFVqkDhSgCty+OM
         OOK21wzxlRzxFDPr0B0AdOgJbzf6dnTgV7NxoyK/lJPLzvkalu07mYUYT1nLJXMIPKRU
         hU8w4h8yVZaJFVB8auJKqbeWvyHLTAeGjg3FVzNjThACybSZdSZxj64LeDXN5NeOS2nO
         SYow==
X-Forwarded-Encrypted: i=1; AJvYcCU22VGI0zR+a2kwvgd8NKrRg2uQbOUpzTaLXGhkq7FBC+adV2x0DMjIgP9c43u45HZcidIXGqP1WAXU@vger.kernel.org, AJvYcCUcrEZ5/kcIjmn8Wx4vHC18q6TepB4vfdGZcjW97eJRzWjbYFBrreP7dJVzMvqSnlD1/tQulzeXDgaLc55A@vger.kernel.org, AJvYcCV5FIMXiEg+mQR4GEhSRKy6XRVOZIL99kMSP8c4AJvmG6hwAZU+HsuwSscXH3KAU8diEgR0h7fj2qqminUXVjMeO9Z/bQ==@vger.kernel.org, AJvYcCW5687bDPQY6Fvb00Qd+L/fMp2Rk0bUZjbeKuGQ1GnvDBs8zSbB7g9PNN5BeIHgw197EC1/Sx97ZxUc5T5Yjw==@vger.kernel.org, AJvYcCXGMOJ5NGZPQqgfU3qonbBDc7elprPlJQzHHq/ORvfP080rS8gO5qsiuLFF9JqDQZfyeuImrcpHQvXz@vger.kernel.org, AJvYcCXY4W8fcAJSNZ0mtyTmRCdGDJ9bn570OOi+bd++xfqKCai6l1lfYF8ScHYOJT+567H6//d+DTsdEpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMd1tW8gJg4IaYtBB1ki+ijxSPapyb0esEYYJtk1hS2FqFBlb
	EV+6lNAouLbouk5+4VwxI5DiFt5lHws4W08TbQS7lsVpk+dZnGblGIT7Rf3ceBjvFjaIl9z02CI
	diCXmFaueVeRgkztMwKRP6yj/GJw=
X-Gm-Gg: ASbGncuFNMteQ9uZha2OhZnWWdUKe6/BlQMGH4vLOwivZwGHcLR0nrylqTgqPdQA3XB
	RUmHZq0KBxFKk015fdFkuIqTAGoejTXwnpF7tzcMtO6R3xSJHlr7H7bxQ/+UIHkmT2W5ZH2lc
X-Google-Smtp-Source: AGHT+IG8c2SseR2yzpufYwiY5RGzY9ZzaH2c8nE9pJi5fMROAkeJXjxgaI7JOCljOMasDckG0mk3JvSkugQeiTAO6Ac=
X-Received: by 2002:a05:6870:ff47:b0:29e:29e1:db1d with SMTP id
 586e51a60fabf-2a7faf914f2mr13957265fac.3.1735323710049; Fri, 27 Dec 2024
 10:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227171353.404432-1-mitltlatltl@gmail.com> <20241227171353.404432-3-mitltlatltl@gmail.com>
In-Reply-To: <20241227171353.404432-3-mitltlatltl@gmail.com>
From: Maya Matuszczyk <maccraft123mc@gmail.com>
Date: Fri, 27 Dec 2024 19:21:14 +0100
Message-ID: <CAO_MupKJyHbEb6RQ0B4gHwPQCrB=NfHJ-odY6R+DaSwOaSfnGw@mail.gmail.com>
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp)
 EC driver
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good to see someone else doing EC drivers for arm64 laptops!

pt., 27 gru 2024 o 18:16 Pengyu Luo <mitltlatltl@gmail.com> napisa=C5=82(a)=
:
>
> There are 3 variants, Huawei released first 2 at the same time.
> Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> Huawei Matebook E Go 2023(sc8280xp@2.69GHz).
>
> Adding support for the latter two variants for now, this driver should
> also work for the sc8180x variant according to acpi table files, but I
> don't have the device yet.
>
> Different from other Qualcomm Snapdragon sc8280xp based machines, the
> Huawei Matebook E Go uses an embedded controller while others use
> something called pmic glink. This embedded controller can be used to
> perform a set of various functions, including, but not limited:
>
> - Battery and charger monitoring;
> - Charge control and smart charge;
> - Fn_lock settings;
> - Tablet lid status;
> - Temperature sensors;
> - USB Type-C notifications (ports orientation,  DP alt mode HPD);
> - USB Type-C PD (according to observation, up to 48w).
>
> Add the driver for the EC, that creates devices for UCSI, wmi and power
> supply devices.
>
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/platform/arm64/Kconfig                |  19 +
>  drivers/platform/arm64/Makefile               |   2 +
>  drivers/platform/arm64/huawei-gaokun-ec.c     | 598 ++++++++++++++++++
>  drivers/platform/arm64/huawei-gaokun-wmi.c    | 283 +++++++++
>  .../linux/platform_data/huawei-gaokun-ec.h    |  90 +++
>  5 files changed, 992 insertions(+)
>  create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
>  create mode 100644 drivers/platform/arm64/huawei-gaokun-wmi.c
>  create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h
>
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kcon=
fig
> index f88395ea3..eb7fbacf0 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -33,6 +33,25 @@ config EC_ACER_ASPIRE1
>           laptop where this information is not properly exposed via the
>           standard ACPI devices.
>
> +config EC_HUAWEI_GAOKUN
> +       tristate "Huawei Matebook E Go (sc8280xp) Embedded Controller dri=
ver"
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       depends on I2C
> +       depends on DRM
> +       depends on POWER_SUPPLY
> +       depends on INPUT
> +       help
> +         Say Y here to enable the EC driver for Huawei Matebook E Go 2in=
1
> +         tablet. The driver handles battery(information, charge control)=
 and
> +         USB Type-C DP HPD events as well as some misc functions like th=
e lid
> +         sensor and temperature sensors, etc.
> +
> +         This driver provides battery and AC status support for the ment=
ioned
> +         laptop where this information is not properly exposed via the
> +         standard ACPI devices.
> +
> +         Say M or Y here to include this support.
> +
>  config EC_LENOVO_YOGA_C630
>         tristate "Lenovo Yoga C630 Embedded Controller driver"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Mak=
efile
> index b2ae9114f..ed32ad6c0 100644
> --- a/drivers/platform/arm64/Makefile
> +++ b/drivers/platform/arm64/Makefile
> @@ -6,4 +6,6 @@
>  #
>
>  obj-$(CONFIG_EC_ACER_ASPIRE1)  +=3D acer-aspire1-ec.o
> +obj-$(CONFIG_EC_HUAWEI_GAOKUN) +=3D huawei-gaokun-ec.o
> +obj-$(CONFIG_EC_HUAWEI_GAOKUN) +=3D huawei-gaokun-wmi.o
>  obj-$(CONFIG_EC_LENOVO_YOGA_C630) +=3D lenovo-yoga-c630.o
> diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/platform=
/arm64/huawei-gaokun-ec.c
> new file mode 100644
> index 000000000..c1c657f7b
> --- /dev/null
> +++ b/drivers/platform/arm64/huawei-gaokun-ec.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * huawei-gaokun-ec - An EC driver for HUAWEI Matebook E Go (sc8280xp)
> + *
> + * reference: drivers/platform/arm64/acer-aspire1-ec.c
> + *            drivers/platform/arm64/lenovo-yoga-c630.c
> + *
> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/notifier.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/version.h>
> +
> +#include <linux/platform_data/huawei-gaokun-ec.h>
> +
> +#define EC_EVENT               0x06
> +
> +/* Also can be found in ACPI specification 12.3 */
> +#define EC_READ                        0x80
> +#define EC_WRITE               0x81
> +#define EC_BURST               0x82
> +#define EC_QUERY               0x84
> +
> +
> +#define EC_EVENT_LID           0x81
> +
> +#define EC_LID_STATE           0x80
> +#define EC_LID_OPEN            BIT(1)
> +
> +#define UCSI_REG_SIZE          7
> +
> +/* for tx, command sequences are arranged as
> + * {master_cmd, slave_cmd, data_len, data_seq}
> + */
> +#define REQ_HDR_SIZE           3
> +#define INPUT_SIZE_OFFSET      2
> +#define INPUT_DATA_OFFSET      3
> +
> +/* for rx, data sequences are arranged as
> + * {status, data_len(unreliable), data_seq}
> + */
> +#define RESP_HDR_SIZE          2
> +#define DATA_OFFSET            2
> +
> +
> +struct gaokun_ec {
> +       struct i2c_client *client;
> +       struct mutex lock;
> +       struct blocking_notifier_head notifier_list;
> +       struct input_dev *idev;
> +       bool suspended;
> +};
> +
> +static int gaokun_ec_request(struct gaokun_ec *ec, const u8 *req,
> +                            size_t resp_len, u8 *resp)
> +{
> +       struct i2c_client *client =3D ec->client;
> +       struct i2c_msg msgs[2] =3D {
> +               {
> +                       .addr =3D client->addr,
> +                       .flags =3D client->flags,
> +                       .len =3D req[INPUT_SIZE_OFFSET] + REQ_HDR_SIZE,
> +                       .buf =3D req,
> +               }, {
> +                       .addr =3D client->addr,
> +                       .flags =3D client->flags | I2C_M_RD,
> +                       .len =3D resp_len,
> +                       .buf =3D resp,
> +               },
> +       };
> +
> +       mutex_lock(&ec->lock);
> +
> +       i2c_transfer(client->adapter, msgs, 2);
> +       usleep_range(2000, 2500);
> +
> +       mutex_unlock(&ec->lock);
> +
> +       return *resp;
> +}
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Common API */
> +
> +/**
> + * gaokun_ec_read - read from EC
> + * @ec: The gaokun_ec
> + * @req: The sequence to request
> + * @resp_len: The size to read
> + * @resp: Where the data are read to
> + *
> + * This function is used to read data after writing a magic sequence to =
EC.
> + * All EC operations dependent on this functions.
> + *
> + * Huawei uses magic sequences everywhere to complete various functions,=
 all
> + * these sequences are passed to ECCD(a ACPI method which is quiet simil=
ar
> + * to gaokun_ec_request), there is no good abstraction to generalize the=
se
> + * sequences, so just wrap it for now. Almost all magic sequences are ke=
pt
> + * in this file.
> + */
> +int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
> +                  size_t resp_len, u8 *resp)
> +{
> +       return gaokun_ec_request(ec, req, resp_len, resp);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_read);
> +
> +/**
> + * gaokun_ec_write - write to EC
> + * @ec: The gaokun_ec
> + * @req: The sequence to request
> + *
> + * This function has no big difference from gaokun_ec_read. When caller =
care
> + * only write status and no actual data are returnd, then use it.
> + */
> +int gaokun_ec_write(struct gaokun_ec *ec, u8 *req)
> +{
> +       u8 resp[RESP_HDR_SIZE];
> +
> +       return gaokun_ec_request(ec, req, sizeof(resp), resp);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_write);
> +
> +int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte)
> +{
> +       int ret;
> +       u8 resp[RESP_HDR_SIZE + sizeof(*byte)];
> +
> +       ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> +       *byte =3D resp[DATA_OFFSET];
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_read_byte);
> +
> +int gaokun_ec_register_notify(struct gaokun_ec *ec, struct notifier_bloc=
k *nb)
> +{
> +       return blocking_notifier_chain_register(&ec->notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_register_notify);
> +
> +void gaokun_ec_unregister_notify(struct gaokun_ec *ec, struct notifier_b=
lock *nb)
> +{
> +       blocking_notifier_chain_unregister(&ec->notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_unregister_notify);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* API For PSY */
> +
> +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> +                            size_t resp_len, u8 *resp)
> +{
> +       int i, ret;
> +       u8 _resp[RESP_HDR_SIZE + 1];
> +       u8 req[REQ_HDR_SIZE + 1] =3D {0x02, EC_READ, 1, };
> +
> +       for (i =3D 0; i < resp_len; ++i) {
> +               req[INPUT_DATA_OFFSET] =3D reg++;
> +               ret =3D gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> +               if (ret)
> +                       return -EIO;
> +               resp[i] =3D _resp[DATA_OFFSET];
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_psy_multi_read);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* API For WMI */
WMI is in ACPI, this laptop doesn't boot with ACPI so why are things
handled in WMI separate from rest of the driver?

> +
> +/* Battery charging threshold */
> +int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind=
)
> +{
> +       /* GBTT */
> +       return gaokun_ec_read_byte(ec, (u8 []){0x02, 0x69, 1, ind}, value=
);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_threshold);
> +
> +int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end)
> +{
> +       /* SBTT */
> +       int ret;
> +       u8 req[REQ_HDR_SIZE + 2] =3D {0x02, 0x68, 2, 3, 0x5a};
> +
> +       ret =3D gaokun_ec_write(ec, req);
> +       if (ret)
> +               return -EIO;
> +
> +       if (start =3D=3D 0 && end =3D=3D 0)
> +               return -EINVAL;
> +
> +       if (start >=3D 0 && start <=3D end && end <=3D 100) {
> +               req[INPUT_DATA_OFFSET] =3D 1;
> +               req[INPUT_DATA_OFFSET + 1] =3D start;
> +               ret =3D gaokun_ec_write(ec, req);
> +               if (ret)
> +                       return -EIO;
> +
> +               req[INPUT_DATA_OFFSET] =3D 2;
> +               req[INPUT_DATA_OFFSET + 1] =3D end;
> +               ret =3D gaokun_ec_write(ec, req);
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_threshold);
> +
> +/* Smart charge param */
> +int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *value=
)
> +{
> +       /* GBAC */
> +       return gaokun_ec_read_byte(ec, (u8 []){0x02, 0xE6, 0}, value);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge_param);
> +
> +int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 value)
> +{
> +       /* SBAC */
> +       if (value < 0 || value > 2)
> +               return -EINVAL;
> +
> +       return gaokun_ec_write(ec, (u8 []){0x02, 0xE5, 1, value});
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge_param);
> +
> +/* Smart charge */
> +int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
> +                                  u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]=
)
> +{
> +       /* GBCM */
> +       u8 req[REQ_HDR_SIZE] =3D {0x02, 0xE4, 0};
> +       u8 resp[RESP_HDR_SIZE + 4];
> +       int ret;
> +
> +       ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> +       if (ret)
> +               return -EIO;
> +
> +       data[0] =3D resp[DATA_OFFSET];
> +       data[1] =3D resp[DATA_OFFSET + 1];
> +       data[2] =3D resp[DATA_OFFSET + 2];
> +       data[3] =3D resp[DATA_OFFSET + 3];
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge);
> +
> +int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
> +                                  u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]=
)
> +{
> +       /* SBCM */
> +       u8 req[REQ_HDR_SIZE + GAOKUN_SMART_CHARGE_DATA_SIZE] =3D {0x02, 0=
XE3, 4,};
> +
> +       if (!(data[2] >=3D 0 && data[2] <=3D data[3] && data[3] <=3D 100)=
)
> +               return -EINVAL;
> +
> +       memcpy(req + INPUT_DATA_OFFSET, data, GAOKUN_SMART_CHARGE_DATA_SI=
ZE);
> +
> +       return gaokun_ec_write(ec, req);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge);
> +
> +/* Fn lock */
> +int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on)
> +{
> +       /* GFRS */
> +       int ret;
> +       u8 val;
> +       u8 req[REQ_HDR_SIZE] =3D {0x02, 0x6B, 0};
> +
> +       ret =3D gaokun_ec_read_byte(ec, req, &val);
> +       if (val =3D=3D 0x55)
> +               *on =3D 0;
> +       else if (val =3D=3D 0x5A)
> +               *on =3D 1;
> +       else
> +               return -EIO;
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_fn_lock);
> +
> +int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on)
> +{
> +       /* SFRS */
> +       u8 req[REQ_HDR_SIZE + 1] =3D {0x02, 0x6C, 1,};
> +
> +       if (on =3D=3D 0)
> +               req[INPUT_DATA_OFFSET] =3D 0x55;
> +       else if (on =3D=3D 1)
> +               req[INPUT_DATA_OFFSET] =3D 0x5A;
> +       else
> +               return -EINVAL;
> +
> +       return gaokun_ec_write(ec, req);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_fn_lock);
> +
> +/* Thermal Zone */
> +/* Range from 0 to 0x2C, partial valid */
> +static const u8 temp_reg[] =3D {0x05, 0x07, 0x08, 0x0E, 0x0F, 0x12, 0x15=
, 0x1E,
> +                             0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0=
x26,
> +                             0x27, 0x28, 0x29, 0x2A};
> +
> +int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_=
NUM])
> +{
> +       /* GTMP */
> +       u8 req[REQ_HDR_SIZE] =3D {0x02, 0x61, 1,};
> +       u8 resp[RESP_HDR_SIZE + sizeof(s16)];
> +       int ret, i =3D 0;
> +
> +       while (i < GAOKUN_TZ_REG_NUM) {
> +               req[INPUT_DATA_OFFSET] =3D temp_reg[i];
> +               ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> +               if (ret)
> +                       return -EIO;
> +               temp[i++] =3D *(s16 *)(resp + DATA_OFFSET);
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_temp);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* API For UCSI */
> +
> +int gaokun_ec_ucsi_read(struct gaokun_ec *ec,
> +                       u8 resp[GAOKUN_UCSI_READ_SIZE])
> +{
> +       u8 req[REQ_HDR_SIZE] =3D {0x3, 0xD5, 0};
> +       u8 _resp[RESP_HDR_SIZE + GAOKUN_UCSI_READ_SIZE];
> +       int ret;
> +
> +       ret =3D gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> +       if (ret)
> +               return ret;
> +
> +       memcpy(resp, _resp + DATA_OFFSET, GAOKUN_UCSI_READ_SIZE);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_read);
> +
> +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> +                        const u8 req[GAOKUN_UCSI_WRITE_SIZE])
> +{
> +       u8 _req[REQ_HDR_SIZE + GAOKUN_UCSI_WRITE_SIZE];
> +
> +       _req[0] =3D 0x03;
> +       _req[1] =3D 0xD4;
> +       _req[INPUT_SIZE_OFFSET] =3D GAOKUN_UCSI_WRITE_SIZE;
> +       memcpy(_req + INPUT_DATA_OFFSET, req, GAOKUN_UCSI_WRITE_SIZE);
> +
> +       return gaokun_ec_write(ec, _req);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_write);
> +
> +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg)
> +{
> +       u8 req[REQ_HDR_SIZE] =3D {0x03, 0xD3, 0};
> +       u8 _resp[RESP_HDR_SIZE + UCSI_REG_SIZE];
> +       int ret;
> +
> +       ret =3D gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> +       if (ret)
> +               return ret;
> +
> +       memcpy(ureg, _resp + DATA_OFFSET, UCSI_REG_SIZE);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_get_reg);
> +
> +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id)
> +{
> +       u8 req[REQ_HDR_SIZE + 1] =3D {0x03, 0xD2, 1, 0};
> +
> +       if (port_id >=3D 0)
> +               req[INPUT_DATA_OFFSET] =3D 1 << port_id;
> +
> +       return gaokun_ec_write(ec, req);
> +}
> +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_pan_ack);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Modern Standby */
> +
> +static int gaokun_ec_suspend(struct device *dev)
> +{
> +       struct gaokun_ec *ec =3D dev_get_drvdata(dev);
> +       u8 req[REQ_HDR_SIZE + 1] =3D {0x02, 0xB2, 1, 0xDB};
> +       int ret;
> +
> +       if (ec->suspended)
> +               return 0;
> +
> +       ret =3D gaokun_ec_write(ec, req);
> +
> +       if (ret)
> +               return ret;
> +
> +       ec->suspended =3D true;
> +
> +       return 0;
> +}
> +
> +static int gaokun_ec_resume(struct device *dev)
> +{
> +       struct gaokun_ec *ec =3D dev_get_drvdata(dev);
> +       u8 req[REQ_HDR_SIZE + 1] =3D {0x02, 0xB2, 1, 0xEB};
> +       int ret;
> +       int i;
> +
> +       if (!ec->suspended)
> +               return 0;
> +
> +       for (i =3D 0; i < 3; i++) {
> +               ret =3D gaokun_ec_write(ec, req);
> +               if (ret =3D=3D 0)
> +                       break;
> +
> +               msleep(100);
> +       };
> +
> +       ec->suspended =3D false;
> +
> +       return 0;
> +}
> +
> +static void gaokun_aux_release(struct device *dev)
> +{
> +       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +
> +       kfree(adev);
> +}
> +
> +static void gaokun_aux_remove(void *data)
> +{
> +       struct auxiliary_device *adev =3D data;
> +
> +       auxiliary_device_delete(adev);
> +       auxiliary_device_uninit(adev);
> +}
> +
> +static int gaokun_aux_init(struct device *parent, const char *name,
> +                          struct gaokun_ec *ec)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +       if (!adev)
> +               return -ENOMEM;
> +
> +       adev->name =3D name;
> +       adev->id =3D 0;
> +       adev->dev.parent =3D parent;
> +       adev->dev.release =3D gaokun_aux_release;
> +       adev->dev.platform_data =3D ec;
> +       /* Allow aux devices to access parent's DT nodes directly */
> +       device_set_of_node_from_dev(&adev->dev, parent);
> +
> +       ret =3D auxiliary_device_init(adev);
> +       if (ret) {
> +               kfree(adev);
> +               return ret;
> +       }
> +
> +       ret =3D auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(parent, gaokun_aux_remove, adev);
> +}
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* EC */
> +
> +static irqreturn_t gaokun_ec_irq_handler(int irq, void *data)
> +{
> +       struct gaokun_ec *ec =3D data;
> +       u8 req[REQ_HDR_SIZE] =3D {EC_EVENT, EC_QUERY, 0};
> +       u8 status, id;
> +       int ret;
> +
> +       ret =3D gaokun_ec_read_byte(ec, req, &id);
> +       if (ret)
> +               return IRQ_HANDLED;
The error should probably be logged instead of silently ignored

> +
> +       switch (id) {
> +       case 0x0: /* No event */
> +               break;
> +
> +       case EC_EVENT_LID:
> +               gaokun_ec_psy_read_byte(ec, EC_LID_STATE, &status);
> +               status =3D EC_LID_OPEN & status;
> +               input_report_switch(ec->idev, SW_LID, !status);
> +               input_sync(ec->idev);
> +               break;
> +
> +       default:
> +               blocking_notifier_call_chain(&ec->notifier_list, id, ec);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int gaokun_ec_probe(struct i2c_client *client)
> +{
> +       struct device *dev =3D &client->dev;
> +       struct gaokun_ec *ec;
> +       int ret;
> +
> +       ec =3D devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +       if (!ec)
> +               return -ENOMEM;
> +
> +       mutex_init(&ec->lock);
> +       ec->client =3D client;
> +       i2c_set_clientdata(client, ec);
> +       BLOCKING_INIT_NOTIFIER_HEAD(&ec->notifier_list);
> +
> +       /* Lid switch */
> +       ec->idev =3D devm_input_allocate_device(dev);
> +       if (!ec->idev)
> +               return -ENOMEM;
> +
> +       ec->idev->name =3D "LID";
> +       ec->idev->phys =3D "gaokun-ec/input0";
> +       input_set_capability(ec->idev, EV_SW, SW_LID);
> +
> +       ret =3D input_register_device(ec->idev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register input =
device\n");
> +
> +       ret =3D gaokun_aux_init(dev, "psy", ec);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D gaokun_aux_init(dev, "wmi", ec);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D gaokun_aux_init(dev, "ucsi", ec);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> +                                       gaokun_ec_irq_handler, IRQF_ONESH=
OT,
> +                                       dev_name(dev), ec);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to request irq\n")=
;
> +
> +       return 0;
> +}
> +
> +static const struct i2c_device_id gaokun_ec_id[] =3D {
> +       { "gaokun-ec", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, gaokun_ec_id);
> +
> +static const struct of_device_id gaokun_ec_of_match[] =3D {
> +       { .compatible =3D "huawei,gaokun-ec", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, gaokun_ec_of_match);
> +
> +static const struct dev_pm_ops gaokun_ec_pm_ops =3D {
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(gaokun_ec_suspend, gaokun_ec_resume)
> +};
> +
> +static struct i2c_driver gaokun_ec_driver =3D {
> +       .driver =3D {
> +               .name =3D "gaokun-ec",
> +               .of_match_table =3D gaokun_ec_of_match,
> +               .pm =3D &gaokun_ec_pm_ops,
> +       },
> +       .probe =3D gaokun_ec_probe,
> +       .id_table =3D gaokun_ec_id,
> +};
> +module_i2c_driver(gaokun_ec_driver);
> +
> +MODULE_DESCRIPTION("HUAWEI Matebook E Go EC driver");
> +MODULE_AUTHOR("Pengyu Luo <mitltlatltl@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/arm64/huawei-gaokun-wmi.c b/drivers/platfor=
m/arm64/huawei-gaokun-wmi.c
> new file mode 100644
> index 000000000..793cb1659
> --- /dev/null
> +++ b/drivers/platform/arm64/huawei-gaokun-wmi.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * huawei-gaokun-wmi - A WMI driver for HUAWEI Matebook E Go (sc8280xp)
Just because in ACPI it's done by WMI stuff doesn't mean the non-ACPI
driver has to reflect this

> + *
> + * reference: drivers/platform/x86/huawei-wmi.c
> + *
> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +#include <linux/version.h>
> +
> +#include <linux/platform_data/huawei-gaokun-ec.h>
> +
> +struct gaokun_wmi {
> +       struct gaokun_ec *ec;
> +       struct device *dev;
> +       struct platform_device *wmi;
> +};
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Battery charging threshold */
> +
> +enum gaokun_wmi_threshold_ind {
> +       START   =3D 1,
> +       END     =3D 2,
> +};
> +
> +static ssize_t charge_control_thresholds_show(struct device *dev,
> +                                             struct device_attribute *at=
tr,
> +                                             char *buf)
> +{
> +       int ret;
> +       u8 start, end;
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       ret =3D gaokun_ec_wmi_get_threshold(ecwmi->ec, &start, START)
> +               || gaokun_ec_wmi_get_threshold(ecwmi->ec, &end, END);
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%d %d\n", start, end);
> +}
> +
> +static ssize_t charge_control_thresholds_store(struct device *dev,
> +                                              struct device_attribute *a=
ttr,
> +                                              const char *buf, size_t si=
ze)
> +{
> +       int ret;
> +       u8 start, end;
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       if (sscanf(buf, "%hhd %hhd", &start, &end) !=3D 2)
> +               return -EINVAL;
> +
> +       ret =3D gaokun_ec_wmi_set_threshold(ecwmi->ec, start, end);
> +       if (ret)
> +               return ret;
> +
> +       return size;
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_thresholds);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Smart charge param */
> +
> +static ssize_t smart_charge_param_show(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      char *buf)
> +{
> +       int ret;
> +       u8 value;
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       ret =3D gaokun_ec_wmi_get_smart_charge_param(ecwmi->ec, &value);
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t smart_charge_param_store(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       const char *buf, size_t size)
> +{
> +       int ret;
> +       u8 value;
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       if (kstrtou8(buf, 10, &value))
> +               return -EINVAL;
> +
> +       ret =3D gaokun_ec_wmi_set_smart_charge_param(ecwmi->ec, value);
> +       if (ret)
> +               return ret;
> +
> +       return size;
> +}
> +
> +static DEVICE_ATTR_RW(smart_charge_param);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Smart charge */
> +
> +static ssize_t smart_charge_show(struct device *dev,
> +                                struct device_attribute *attr,
> +                                char *buf)
> +{
> +       int ret;
> +       u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       ret =3D gaokun_ec_wmi_get_smart_charge(ecwmi->ec, bf);
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%d %d %d %d\n",
> +                         bf[0], bf[1], bf[2], bf[3]);
> +}
> +
> +static ssize_t smart_charge_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t size)
> +{
> +       int ret;
> +       u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       if (sscanf(buf, "%hhd %hhd %hhd %hhd", bf, bf + 1, bf + 2, bf + 3=
) !=3D 4)
> +               return -EINVAL;
> +
> +       ret =3D gaokun_ec_wmi_set_smart_charge(ecwmi->ec, bf);
> +       if (ret)
> +               return ret;
> +
> +       return size;
> +}
> +
> +static DEVICE_ATTR_RW(smart_charge);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Fn lock */
> +
> +static ssize_t fn_lock_state_show(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 char *buf)
> +{
> +       int ret;
> +       u8 on;
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       ret =3D gaokun_ec_wmi_get_fn_lock(ecwmi->ec, &on);
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "%d\n", on);
> +}
> +
> +static ssize_t fn_lock_state_store(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  const char *buf, size_t size)
> +{
> +       int ret;
> +       u8 on;
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       if (kstrtou8(buf, 10, &on))
> +               return -EINVAL;
> +
> +       ret =3D gaokun_ec_wmi_set_fn_lock(ecwmi->ec, on);
> +       if (ret)
> +               return ret;
> +
> +       return size;
> +}
> +
> +static DEVICE_ATTR_RW(fn_lock_state);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Thermal Zone */
> +
> +static ssize_t temperature_show(struct device *dev,
> +                               struct device_attribute *attr,
> +                               char *buf)
> +{
> +
> +       int ret, len, i;
> +       char *ptr =3D buf;
> +       s16 value;
> +       s16 temp[GAOKUN_TZ_REG_NUM];
> +       struct gaokun_wmi *ecwmi =3D dev_get_drvdata(dev);
> +
> +       ret =3D gaokun_ec_wmi_get_temp(ecwmi->ec, temp);
> +       if (ret)
> +               return ret;
> +
> +       i =3D 0;
> +       len =3D 0;
> +       while (i < GAOKUN_TZ_REG_NUM) {
> +               value =3D temp[i++];
> +               if (value < 0) {
> +                       len +=3D sprintf(ptr + len, "-");
> +                       value =3D -value;
> +               }
> +               len +=3D sprintf(ptr + len, "%d.%d ", value / 10, value %=
 10);
> +       }
> +       len +=3D sprintf(ptr + len, "\n");
> +
> +       return len;
> +}
> +
> +static DEVICE_ATTR_RO(temperature);
> +
> +static struct attribute *gaokun_wmi_features_attrs[] =3D {
> +       &dev_attr_charge_control_thresholds.attr,
> +       &dev_attr_smart_charge_param.attr,
> +       &dev_attr_smart_charge.attr,
> +       &dev_attr_fn_lock_state.attr,
> +       &dev_attr_temperature.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(gaokun_wmi_features);
> +
> +static int gaokun_wmi_probe(struct auxiliary_device *adev,
> +                           const struct auxiliary_device_id *id)
> +{
> +       struct gaokun_ec *ec =3D adev->dev.platform_data;
> +       struct device *dev =3D &adev->dev;
> +       struct gaokun_wmi *ecwmi;
> +
> +       ecwmi =3D devm_kzalloc(&adev->dev, sizeof(*ecwmi), GFP_KERNEL);
> +       if (!ecwmi)
> +               return -ENOMEM;
> +
> +       ecwmi->ec =3D ec;
> +       ecwmi->dev =3D dev;
> +
> +       auxiliary_set_drvdata(adev, ecwmi);
> +
> +       /* make it under /sys/devices/platform, convenient for sysfs I/O,
> +        * while adev is under
> +        * /sys/devices/platform/soc@0/ac0000.geniqup/a9c000.i2c/i2c-15/1=
5-0038/
> +        */
> +       ecwmi->wmi =3D platform_device_register_simple("gaokun-wmi", -1, =
NULL, 0);
> +       if (IS_ERR(ecwmi->wmi))
> +               return dev_err_probe(dev, PTR_ERR(ecwmi->wmi),
> +                                    "Failed to register wmi platform dev=
ice\n");
> +
> +       platform_set_drvdata(ecwmi->wmi, ecwmi);
> +
> +       return device_add_groups(&ecwmi->wmi->dev, gaokun_wmi_features_gr=
oups);
> +}
> +
> +static void gaokun_wmi_remove(struct auxiliary_device *adev)
> +{
> +       struct gaokun_wmi *ecwmi =3D auxiliary_get_drvdata(adev);
> +       struct platform_device *wmi =3D ecwmi->wmi;
> +
> +       device_remove_groups(&wmi->dev, gaokun_wmi_features_groups);
> +       platform_device_unregister(ecwmi->wmi);
> +}
> +
> +static const struct auxiliary_device_id gaokun_wmi_id_table[] =3D {
> +       { .name =3D GAOKUN_MOD_NAME "." GAOKUN_DEV_WMI, },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, gaokun_wmi_id_table);
> +
> +static struct auxiliary_driver gaokun_wmi_driver =3D {
> +       .name =3D GAOKUN_DEV_WMI,
> +       .id_table =3D gaokun_wmi_id_table,
> +       .probe =3D gaokun_wmi_probe,
> +       .remove =3D gaokun_wmi_remove,
> +};
> +
> +module_auxiliary_driver(gaokun_wmi_driver);
> +
> +MODULE_DESCRIPTION("HUAWEI Matebook E Go WMI driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/huawei-gaokun-ec.h b/include/lin=
ux/platform_data/huawei-gaokun-ec.h
> new file mode 100644
> index 000000000..a649e9ecf
> --- /dev/null
> +++ b/include/linux/platform_data/huawei-gaokun-ec.h
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Huawei Matebook E Go (sc8280xp) Embedded Controller
> + *
> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> + *
> + */
> +
> +#ifndef __HUAWEI_GAOKUN_EC_H__
> +#define __HUAWEI_GAOKUN_EC_H__
> +
> +#define GAOKUN_UCSI_CCI_SIZE   4
> +#define GAOKUN_UCSI_DATA_SIZE  16
> +#define GAOKUN_UCSI_READ_SIZE  (GAOKUN_UCSI_CCI_SIZE + GAOKUN_UCSI_DATA_=
SIZE)
> +#define GAOKUN_UCSI_WRITE_SIZE 0x18
> +
> +#define GAOKUN_TZ_REG_NUM      20
> +#define GAOKUN_SMART_CHARGE_DATA_SIZE  4 /* mode, delay, start, end */
> +
> +/* ---------------------------------------------------------------------=
----- */
> +
> +struct gaokun_ec;
> +struct notifier_block;
> +
> +#define GAOKUN_MOD_NAME                        "huawei_gaokun_ec"
> +#define GAOKUN_DEV_PSY                 "psy"
> +#define GAOKUN_DEV_WMI                 "wmi"
> +#define GAOKUN_DEV_UCSI                        "ucsi"
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* Common API */
> +
> +int gaokun_ec_register_notify(struct gaokun_ec *ec,
> +                             struct notifier_block *nb);
> +void gaokun_ec_unregister_notify(struct gaokun_ec *ec,
> +                                struct notifier_block *nb);
> +
> +int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
> +                  size_t resp_len, u8 *resp);
> +int gaokun_ec_write(struct gaokun_ec *ec, u8 *req);
> +int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* API For PSY */
> +
> +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> +                            size_t resp_len, u8 *resp);
> +
> +static inline int gaokun_ec_psy_read_byte(struct gaokun_ec *ec,
> +                                         u8 reg, u8 *byte)
> +{
> +       return gaokun_ec_psy_multi_read(ec, reg, 1, byte);
> +}
> +
> +static inline int gaokun_ec_psy_read_word(struct gaokun_ec *ec,
> +                                         u8 reg, u16 *word)
> +{
> +       return gaokun_ec_psy_multi_read(ec, reg, 2, (u8 *)word);
> +}
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* API For WMI */
> +
> +int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind=
);
> +int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end);
> +
> +int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *value=
);
> +int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 value)=
;
> +
> +int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
> +                                  u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]=
);
> +int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
> +                                  u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]=
);
> +
> +int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on);
> +int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on);
> +
> +int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_=
NUM]);
> +
> +/* ---------------------------------------------------------------------=
----- */
> +/* API For UCSI */
> +
> +int gaokun_ec_ucsi_read(struct gaokun_ec *ec, u8 resp[GAOKUN_UCSI_READ_S=
IZE]);
> +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> +                        const u8 req[GAOKUN_UCSI_WRITE_SIZE]);
> +
> +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg);
> +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id);
> +
> +
> +#endif /* __HUAWEI_GAOKUN_EC_H__ */
> --
> 2.47.1
>
>

Best Regards,
Maya Matuszczyk

