Return-Path: <linux-pm+bounces-19827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756409FDFBA
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EF03A1801
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA817BEC6;
	Sun, 29 Dec 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkOrdj4T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72E7083A;
	Sun, 29 Dec 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735486392; cv=none; b=fPKvoP1lvDYvRrSTOtaHGbO9xeQJD57DOCQXf/zD5tNRXuDpZGXBSoudD1OI9uOc4YHt4toaYwddn08jdDexXwu+RulCy1yGN7g1+YPh62W9FkYUXRJXBKop9o5uBznOxakT9s6iNHJSPNV/laKhQHPaGtgOgjVY19ZVKCtwc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735486392; c=relaxed/simple;
	bh=3LsfofT+blAiQE0xr7Jj5IDprrltIytKnprCsgIZs3s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d9e9da5d8wl4aUaGwKZirhjPLEnF1J5cY09gY4LS83bXCxl+mwebYeQIpo3jZbE51KMFGTWeYFhWMH4IidWLd98cu6pgkDIlSXrLApdM7+WSK2UWqStx9ffw1qw2yF8mLQ8UBe/jEA2KgmteeUL8VM8qFMp7ckqLKrYsQwsrYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkOrdj4T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735486390; x=1767022390;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3LsfofT+blAiQE0xr7Jj5IDprrltIytKnprCsgIZs3s=;
  b=lkOrdj4T3nAcCspqP3nMILw4Q7sc4khFtNqeolsKso1F7Y4UqA4+zNQD
   h6aCkpFvhFu7eXVyjv4mYGGchc2uewGV3tZ85L555hr86bg9QMmM47Zh5
   xVWNRUf5kdG2Vyvui0E3ySsUTmb2fDSWjDd1l1KtpLXXvjZh8kEH0HO+t
   +pYFycxVMOyl4q9r7vxR1BmtCuwR/GDw21LB0vKxhD1qbtFzz7E7aHQ2a
   eeieFfO7voeFsD/GCbJVSte1VQfAwzA1LIE87wPRMu0fMRYRRpaQi2aAG
   wcbwrLWnZqk16wQiraXPDc4V7ZU8eW3QT2KixLczuO0Dkk5Idifbg5tXv
   w==;
X-CSE-ConnectionGUID: bQKkyKXzSHOaMbY2HRWA8w==
X-CSE-MsgGUID: Lq5OEk4wQN+7rWpoOOAkuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="23390312"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="23390312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 07:33:09 -0800
X-CSE-ConnectionGUID: nydfrK+iQg6J7GDuQ3rJWg==
X-CSE-MsgGUID: xKOdafBxS5yECYw0aENgKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123865963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 07:33:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 29 Dec 2024 17:32:59 +0200 (EET)
To: Pengyu Luo <mitltlatltl@gmail.com>
cc: bryan.odonoghue@linaro.org, andersson@kernel.org, conor+dt@kernel.org, 
    devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, heikki.krogerus@linux.intel.com, 
    konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    linux-usb@vger.kernel.org, nikita@trvn.ru, 
    platform-driver-x86@vger.kernel.org, robh@kernel.org, sre@kernel.org
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp)
 EC driver
In-Reply-To: <20241228135107.608204-1-mitltlatltl@gmail.com>
Message-ID: <41e8cc85-6978-49b0-7216-3ce715d48101@linux.intel.com>
References: <597a3374-311c-45e7-8c3b-8d9a18a20062@linaro.org> <20241228135107.608204-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1167656764-1735486379=:922"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1167656764-1735486379=:922
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 28 Dec 2024, Pengyu Luo wrote:
> On Sat, Dec 28, 2024 at 8:33=E2=80=AFPM Bryan O'Donoghue <bryan.odonoghue=
@linaro.org> wrote:
> > On 27/12/2024 17:13, Pengyu Luo wrote:
> > > There are 3 variants, Huawei released first 2 at the same time.
> >
> > There are three variants of which Huawei released the first two
> > simultaneously.
> >
>=20
> You have mentioned many grammar and code issues.
> So I explain something, I taught myself C, writing code is just my hobby.
> I am also not a native speaker, I have never lived in an English
> environment. Sometime I may use inappropriate words to express. I try my
> best to express my idea clearly. I hope you can understand.
>=20
> > > Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> > > Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> >
> > Choose either "codename should be" or "codename is"
> >
> > > Huawei Matebook E Go 2023(sc8280xp@2.69GHz).
> >
> > Maybe say here "codename unknown"
> >
>=20
> should be, I want to express I am guessing.
> I guess the last one is also gaokun3. But anyways, this driver works
> for the latter two.
>=20
> > > Adding support for the latter two variants for now, this driver shoul=
d
> > > also work for the sc8180x variant according to acpi table files, but =
I
> > > don't have the device yet.
> > >
> > > Different from other Qualcomm Snapdragon sc8280xp based machines, the
> > > Huawei Matebook E Go uses an embedded controller while others use
> > > something called pmic glink. This embedded controller can be used to
> > > perform a set of various functions, including, but not limited:
> >
> > "but not limited to":
> >
> > > - Battery and charger monitoring;
> > > - Charge control and smart charge;
> > > - Fn_lock settings;
> > > - Tablet lid status;
> > > - Temperature sensors;
> > > - USB Type-C notifications (ports orientation,  DP alt mode HPD);
> > > - USB Type-C PD (according to observation, up to 48w).
> > >
> > > Add the driver for the EC, that creates devices for UCSI, wmi and pow=
er
> > > supply devices.
> >
> > I'm a terrible man for the "," dropped all about the place but you're
> > going too mad with the commans there ->
> >
> > "Add a driver for the EC which creates devices for UCSI, WMI and power
> > supply devices"
> >
>=20
> This was copied from C630 patches, replaced with my devices.
>=20
> > >
> > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > ---
> > >   drivers/platform/arm64/Kconfig                |  19 +
> > >   drivers/platform/arm64/Makefile               |   2 +
> > >   drivers/platform/arm64/huawei-gaokun-ec.c     | 598 +++++++++++++++=
+++
> > >   drivers/platform/arm64/huawei-gaokun-wmi.c    | 283 +++++++++
> > >   .../linux/platform_data/huawei-gaokun-ec.h    |  90 +++
> > >   5 files changed, 992 insertions(+)
> > >   create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
> > >   create mode 100644 drivers/platform/arm64/huawei-gaokun-wmi.c
> > >   create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h
> > >
> > > diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/=
Kconfig
> > > index f88395ea3..eb7fbacf0 100644
> > > --- a/drivers/platform/arm64/Kconfig
> > > +++ b/drivers/platform/arm64/Kconfig
> > > @@ -33,6 +33,25 @@ config EC_ACER_ASPIRE1
> > >         laptop where this information is not properly exposed via the
> > >         standard ACPI devices.
> > >
> > > +config EC_HUAWEI_GAOKUN
> > > +     tristate "Huawei Matebook E Go (sc8280xp) Embedded Controller d=
river"
> >
> > Krzysztof already mentioned this but the "sc8280xp" is questionable, yo=
u
> > should probably drop mention of qcom and sc8280xp from your compat and
> > tristate here.
> >
>=20
> Agree, how about using sc8280xp-based for tristate?
>=20
> > > +     depends on ARCH_QCOM || COMPILE_TEST
> > > +     depends on I2C
> > > +     depends on DRM
> > > +     depends on POWER_SUPPLY
> > > +     depends on INPUT
> > > +     help
> > > +       Say Y here to enable the EC driver for Huawei Matebook E Go 2=
in1
> > > +       tablet. The driver handles battery(information, charge contro=
l) and
> > > +       USB Type-C DP HPD events as well as some misc functions like =
the lid
> > > +       sensor and temperature sensors, etc.
> > > +
> > > +       This driver provides battery and AC status support for the me=
ntioned
> > > +       laptop where this information is not properly exposed via the
> > > +       standard ACPI devices.
> > > +
> > > +       Say M or Y here to include this support.
> >
> > OTOH the help text is where you could mention the sc8280xp class of
> > laptops/tablets.
> >
>=20
> I see
>=20
> > > +
> > >   config EC_LENOVO_YOGA_C630
> > >       tristate "Lenovo Yoga C630 Embedded Controller driver"
> > >       depends on ARCH_QCOM || COMPILE_TEST
> > > diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64=
/Makefile
> > > index b2ae9114f..ed32ad6c0 100644
> > > --- a/drivers/platform/arm64/Makefile
> > > +++ b/drivers/platform/arm64/Makefile
> > > @@ -6,4 +6,6 @@
> > >   #
> > >
> > >   obj-$(CONFIG_EC_ACER_ASPIRE1)       +=3D acer-aspire1-ec.o
> > > +obj-$(CONFIG_EC_HUAWEI_GAOKUN)       +=3D huawei-gaokun-ec.o
> > > +obj-$(CONFIG_EC_HUAWEI_GAOKUN)       +=3D huawei-gaokun-wmi.o
> > >   obj-$(CONFIG_EC_LENOVO_YOGA_C630) +=3D lenovo-yoga-c630.o
> > > diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/plat=
form/arm64/huawei-gaokun-ec.c
> > > new file mode 100644
> > > index 000000000..c1c657f7b
> > > --- /dev/null
> > > +++ b/drivers/platform/arm64/huawei-gaokun-ec.c
> > > @@ -0,0 +1,598 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * huawei-gaokun-ec - An EC driver for HUAWEI Matebook E Go (sc8280x=
p)
> > > + *
> > > + * reference: drivers/platform/arm64/acer-aspire1-ec.c
> > > + *            drivers/platform/arm64/lenovo-yoga-c630.c
> > > + *
> > > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > > + */
> > > +
> > > +#include <linux/auxiliary_bus.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/input.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/version.h>
> > > +
> > > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > > +
> > > +#define EC_EVENT             0x06
> > > +
> > > +/* Also can be found in ACPI specification 12.3 */
> > > +#define EC_READ                      0x80
> > > +#define EC_WRITE             0x81
> >
> > Is this odd indentation ?
> >
>=20
> No, apply it then check the source, it is normal.
>=20
> > > +#define EC_BURST             0x82
> > > +#define EC_QUERY             0x84
> > > +
> > > +
> > > +#define EC_EVENT_LID         0x81
> > > +
> > > +#define EC_LID_STATE         0x80
> > > +#define EC_LID_OPEN          BIT(1)
> > > +
> > > +#define UCSI_REG_SIZE                7
> > > +
> > > +/* for tx, command sequences are arranged as
> > > + * {master_cmd, slave_cmd, data_len, data_seq}
> > > + */
> > > +#define REQ_HDR_SIZE         3
> > > +#define INPUT_SIZE_OFFSET    2
> > > +#define INPUT_DATA_OFFSET    3
> > > +
> > > +/* for rx, data sequences are arranged as
> > > + * {status, data_len(unreliable), data_seq}
> > > + */
> > > +#define RESP_HDR_SIZE                2
> > > +#define DATA_OFFSET          2
> > > +
> > > +
> > > +struct gaokun_ec {
> > > +     struct i2c_client *client;
> > > +     struct mutex lock;
> > > +     struct blocking_notifier_head notifier_list;
> > > +     struct input_dev *idev;
> > > +     bool suspended;
> > > +};
> > > +
> > > +static int gaokun_ec_request(struct gaokun_ec *ec, const u8 *req,
> > > +                          size_t resp_len, u8 *resp)
> > > +{
> > > +     struct i2c_client *client =3D ec->client;
> > > +     struct i2c_msg msgs[2] =3D {
> > > +             {
> > > +                     .addr =3D client->addr,
> > > +                     .flags =3D client->flags,
> > > +                     .len =3D req[INPUT_SIZE_OFFSET] + REQ_HDR_SIZE,
> > > +                     .buf =3D req,
> > > +             }, {
> > > +                     .addr =3D client->addr,
> > > +                     .flags =3D client->flags | I2C_M_RD,
> > > +                     .len =3D resp_len,
> > > +                     .buf =3D resp,
> > > +             },
> > > +     };
> > > +
> > > +     mutex_lock(&ec->lock);
> > > +
> > > +     i2c_transfer(client->adapter, msgs, 2);
> > > +     usleep_range(2000, 2500);
> >
> > What is this sleep about and why are you doing it inside of a critical
> > section ?
> >
>=20
> Have a break between 2 transaction. This sleep happens in acpi code, also
> inside a critical region. I rearrange it. We can sleep when using mutex
> lock instead of spinlock.
>=20
> Local7 =3D Acquire (\_SB.IC16.MUEC, 0x03E8)
> ...
> read ops
> ...
> Sleep (0x02)
> ...
> write ops
> ...
> Release (\_SB.IC16.MUEC)
>=20
> > > +
> > > +     mutex_unlock(&ec->lock);
> > > +
> > > +     return *resp;
> > > +}
> > > +
> > > +/* -----------------------------------------------------------------=
--------- */
> > > +/* Common API */
> > > +
> > > +/**
> > > + * gaokun_ec_read - read from EC
> > > + * @ec: The gaokun_ec
> > > + * @req: The sequence to request
> > > + * @resp_len: The size to read
> > > + * @resp: Where the data are read to
> > > + *
> > > + * This function is used to read data after writing a magic sequence=
 to EC.
> > > + * All EC operations dependent on this functions.
> >
> > depend on this
> >
>=20
> mistyping
>=20
> > > + *
> > > + * Huawei uses magic sequences everywhere to complete various functi=
ons, all
> > > + * these sequences are passed to ECCD(a ACPI method which is quiet s=
imilar
> > > + * to gaokun_ec_request), there is no good abstraction to generalize=
 these
> > > + * sequences, so just wrap it for now. Almost all magic sequences ar=
e kept
> > > + * in this file.
> > > + */
> > > +int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
> > > +                size_t resp_len, u8 *resp)
> > > +{
> > > +     return gaokun_ec_request(ec, req, resp_len, resp);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_read);
> > > +
> > > +/**
> > > + * gaokun_ec_write - write to EC
> > > + * @ec: The gaokun_ec
> > > + * @req: The sequence to request
> > > + *
> > > + * This function has no big difference from gaokun_ec_read. When cal=
ler care
> > > + * only write status and no actual data are returnd, then use it.
> > > + */
> > > +int gaokun_ec_write(struct gaokun_ec *ec, u8 *req)
> > > +{
> > > +     u8 resp[RESP_HDR_SIZE];
> > > +
> > > +     return gaokun_ec_request(ec, req, sizeof(resp), resp);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_write);
> > > +
> > > +int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte)
> > > +{
> > > +     int ret;
> > > +     u8 resp[RESP_HDR_SIZE + sizeof(*byte)];
> > > +
> > > +     ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> > > +     *byte =3D resp[DATA_OFFSET];
> > > +
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_read_byte);
> > > +
> > > +int gaokun_ec_register_notify(struct gaokun_ec *ec, struct notifier_=
block *nb)
> > > +{
> > > +     return blocking_notifier_chain_register(&ec->notifier_list, nb)=
;
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_register_notify);
> > > +
> > > +void gaokun_ec_unregister_notify(struct gaokun_ec *ec, struct notifi=
er_block *nb)
> > > +{
> > > +     blocking_notifier_chain_unregister(&ec->notifier_list, nb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_unregister_notify);
> > > +
> > > +/* -----------------------------------------------------------------=
--------- */
> > > +/* API For PSY */
> > > +
> > > +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> > > +                          size_t resp_len, u8 *resp)
> > > +{
> > > +     int i, ret;
> > > +     u8 _resp[RESP_HDR_SIZE + 1];
> > > +     u8 req[REQ_HDR_SIZE + 1] =3D {0x02, EC_READ, 1, };
> >
> > Instead of constructing your packet inline like this, suggest a
> > dedicated function to construct a request packet.
> >
> > For example 1 @ INPUT_SIZE_OFFSET =3D> the size of data a dedicated
> > function will make the "stuffing" of the request frame more obvious to
> > readers and make the construction of packets less error prone.
> >
>=20
> I will try to do it, but there are many magic sequences in any size, I
> need pass them anyways.
>=20
> > > +
> > > +     for (i =3D 0; i < resp_len; ++i) {
> > > +             req[INPUT_DATA_OFFSET] =3D reg++;
> > > +             ret =3D gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > > +             if (ret)
> > > +                     return -EIO;
> > > +             resp[i] =3D _resp[DATA_OFFSET];
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_psy_multi_read);
> > > +
> > > +/* -----------------------------------------------------------------=
--------- */
> > > +/* API For WMI */
> > > +
> > > +/* Battery charging threshold */
> > > +int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int=
 ind)
> > > +{
> > > +     /* GBTT */
> > > +     return gaokun_ec_read_byte(ec, (u8 []){0x02, 0x69, 1, ind}, val=
ue);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_threshold);
> > > +
> > > +int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 e=
nd)
> > > +{
> > > +     /* SBTT */
> > > +     int ret;
> > > +     u8 req[REQ_HDR_SIZE + 2] =3D {0x02, 0x68, 2, 3, 0x5a};
> > > +
> > > +     ret =3D gaokun_ec_write(ec, req);
> > > +     if (ret)
> > > +             return -EIO;
> > > +
> > > +     if (start =3D=3D 0 && end =3D=3D 0)
> > > +             return -EINVAL;
> > > +
> > > +     if (start >=3D 0 && start <=3D end && end <=3D 100) {
> >
> > if start >=3D 0
> >
> > is redundant no ? start is a u8 it can _only_ be >=3D 0 ..
> >
>=20
> Yeah, this code was written with int. Later, I used u8 since one byte is
> convenient for EC transaction(we don't need clear other 3 Bytes). After
> chaging, I forgot to revaluate it.
>=20
> >
> > > +             req[INPUT_DATA_OFFSET] =3D 1;
> > > +             req[INPUT_DATA_OFFSET + 1] =3D start;
> > > +             ret =3D gaokun_ec_write(ec, req);
> > > +             if (ret)
> > > +                     return -EIO;
> > > +
> > > +             req[INPUT_DATA_OFFSET] =3D 2;
> > > +             req[INPUT_DATA_OFFSET + 1] =3D end;
> >
> > again a function to construct a packet gets you out of the business of
> > inlining and "just knowing" which offset is which within any give
> > function which indexes an array.
> >
> > > +             ret =3D gaokun_ec_write(ec, req);
> > > +     } else {
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_threshold);
> > > +
> > > +/* Smart charge param */
> > > +int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *v=
alue)
> > > +{
> > > +     /* GBAC */
> > > +     return gaokun_ec_read_byte(ec, (u8 []){0x02, 0xE6, 0}, value);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge_param);
> > > +
> > > +int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 va=
lue)
> > > +{
> > > +     /* SBAC */
> > > +     if (value < 0 || value > 2)
> >
> > value < 0 can never be true
> >
> > > +             return -EINVAL;
> > > +
> > > +     return gaokun_ec_write(ec, (u8 []){0x02, 0xE5, 1, value});
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge_param);
> > > +
> > > +/* Smart charge */
> > > +int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
> > > +                                u8 data[GAOKUN_SMART_CHARGE_DATA_SIZ=
E])
> > > +{
> > > +     /* GBCM */
> > > +     u8 req[REQ_HDR_SIZE] =3D {0x02, 0xE4, 0};
> > > +     u8 resp[RESP_HDR_SIZE + 4];
> > > +     int ret;
> > > +
> > > +     ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> > > +     if (ret)
> > > +             return -EIO;
> > > +
> > > +     data[0] =3D resp[DATA_OFFSET];
> > > +     data[1] =3D resp[DATA_OFFSET + 1];
> > > +     data[2] =3D resp[DATA_OFFSET + 2];
> > > +     data[3] =3D resp[DATA_OFFSET + 3];
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge);
> > > +
> > > +int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
> > > +                                u8 data[GAOKUN_SMART_CHARGE_DATA_SIZ=
E])
> > > +{
> > > +     /* SBCM */
> > > +     u8 req[REQ_HDR_SIZE + GAOKUN_SMART_CHARGE_DATA_SIZE] =3D {0x02,=
 0XE3, 4,};
> > > +
> > > +     if (!(data[2] >=3D 0 && data[2] <=3D data[3] && data[3] <=3D 10=
0))
> > > +             return -EINVAL;
> >
> > Repeat of the clause above which was checking u8 >=3D 0 for the same
> > values in the rest of the clause - including checking <=3D 100.
> >
> > Certainly a candidate for functional decomposition, inline function or =
a
> > define.
> >
> > > +
> > > +     memcpy(req + INPUT_DATA_OFFSET, data, GAOKUN_SMART_CHARGE_DATA_=
SIZE);
> > > +
> > > +     return gaokun_ec_write(ec, req);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge);
> > > +
> > > +/* Fn lock */
> > > +int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on)
> > > +{
> > > +     /* GFRS */
> > > +     int ret;
> > > +     u8 val;
> > > +     u8 req[REQ_HDR_SIZE] =3D {0x02, 0x6B, 0};
> >
> > Reverse Christmas tree
> >
> > u8 req[REQ_HDR_SIZE];
> > int ret;
> > u8 val;
> >
> > Not required but nice to look at.
> >
>=20
> Agree
>=20
> > > +
> > > +     ret =3D gaokun_ec_read_byte(ec, req, &val);
> > > +     if (val =3D=3D 0x55)
> > > +             *on =3D 0;
> > > +     else if (val =3D=3D 0x5A)
> > > +             *on =3D 1;
> > > +     else
> > > +             return -EIO;
> > > +
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_fn_lock);
> > > +
> > > +int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on)
> > > +{
> > > +     /* SFRS */
> > > +     u8 req[REQ_HDR_SIZE + 1] =3D {0x02, 0x6C, 1,};
> > > +
> > > +     if (on =3D=3D 0)
> > > +             req[INPUT_DATA_OFFSET] =3D 0x55;
> > > +     else if (on =3D=3D 1)
> > > +             req[INPUT_DATA_OFFSET] =3D 0x5A;
> > > +     else
> > > +             return -EINVAL;
> >
> > Why not use a bool for on ?
> >
>=20
> Yes, we can.
>=20
> > > +
> > > +     return gaokun_ec_write(ec, req);
> > > +}
> > > +EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_fn_lock);
> > > +
> > > +/* Thermal Zone */
> > > +/* Range from 0 to 0x2C, partial valid */
> > > +static const u8 temp_reg[] =3D {0x05, 0x07, 0x08, 0x0E, 0x0F, 0x12, =
0x15, 0x1E,
> > > +                           0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,=
 0x26,
> > > +                           0x27, 0x28, 0x29, 0x2A};
> > > +
> > > +int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_=
REG_NUM])
> >
> > int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 *temp, size_t
> > temp_reg_num)
> >
> >
> > > +{
> > > +     /* GTMP */
> > > +     u8 req[REQ_HDR_SIZE] =3D {0x02, 0x61, 1,};
> > > +     u8 resp[RESP_HDR_SIZE + sizeof(s16)];
> > > +     int ret, i =3D 0;
> > > +
> > > +     while (i < GAOKUN_TZ_REG_NUM) {
> > while (i < temp_reg_num)
> >
>=20
> It is a constant. But later, as Krzysztof suggested, I will use interface=
s
> from hwmon, then reading one at a time.
>=20
> > > +             req[INPUT_DATA_OFFSET] =3D temp_reg[i];
> > > +             ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> > > +             if (ret)
> > > +                     return -EIO;
> > > +             temp[i++] =3D *(s16 *)(resp + DATA_OFFSET);
> >
> > What's the point of the casting here ?
> >
> > memcpy(temp, resp, sizeof(s16));
> > temp++;
>=20
> A 2Bytes symbol number in little endian, ec return it like this, so
> casting.

You should use __le16 and proper endianess conversion function then.

It's bit confusing that in the declaration you used RESP_HDR_SIZE and here=
=20
you do it with DATA_OFFSET instead. It feels DATA_OFFSET is unnecessary=20
duplicate of RESP_HDR_SIZE and will easily lead confusing variation such=20
as above.

--
 i.
--8323328-1167656764-1735486379=:922--

