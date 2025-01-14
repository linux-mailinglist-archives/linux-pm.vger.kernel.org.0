Return-Path: <linux-pm+bounces-20422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7EA10B4D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ACB160792
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84191BFE05;
	Tue, 14 Jan 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZN2Vuu6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27321BD012;
	Tue, 14 Jan 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869263; cv=none; b=kAzc5REk/cEstN4rXSk+L10I5dti3tJUz1dfBz34AkGH/wC9wJgigSnaUytV64yLgAi9r89N4ELvPRuyva/AjQ6bf13HgntKzV0xB8nTI+TE3K3hKveLTosIPljO5W6i3NNg4AG+Neq007PnGHPwiXDUzHBnWVy3EElstwPoQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869263; c=relaxed/simple;
	bh=qn0liHuV+HqEbBeQ5aYzpXs6UUzCWEWNkcftd2sCrYI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q3/2CcMXn2Q8dKmPBkLq+dyb5SrdhLtdabtf6Op4sW9mZHHqumz76d1I+h0smSajJkHc6titKcmkdHzqhDMXUvEEwQtkZ1afFp4rhZL03vtRxtwsxb9CxGqilR7I1RPnX7++Vk4nLnuneYEA0lEtn5LrtO4kiCYinTj4k801wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZN2Vuu6e; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736869262; x=1768405262;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qn0liHuV+HqEbBeQ5aYzpXs6UUzCWEWNkcftd2sCrYI=;
  b=ZN2Vuu6eIZjLpcyaRAiwSGsWRK9mKzaROu3jFt5SHE1t4vSjJlXhLvzs
   A/2yoebuayhGnOrsQwil/PP2LYBxpTYOWyEuxvv7dr5Zd/IIrVl4ZY2jh
   y4T1uzx3U1SdJhXo+r4FAPS9zRV2Pi6ie++wjYXjMYr8ZZgqeJElOxQVS
   Qn9GvXyp6dtsyiQhi3RFuugn88G48R2i/Zlzv0VKUPJf1TQr64j+b9KvI
   VYge5Te+VnuBLAfQBkAUZuXW8oTE0mKPclfV3Qpf+SxgC+5FVSIVlKLvO
   1PqPBSN5Gmm69MIknySFIaA1fwgEKeF+robgZoYCa8J2Zkd40HqoLaLfh
   A==;
X-CSE-ConnectionGUID: Xht8FwqoRta4GJL6j7tNCg==
X-CSE-MsgGUID: 8KJloBnlRkaGX15EFQqU8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36382267"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="36382267"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:41:00 -0800
X-CSE-ConnectionGUID: 5HLHvUtqSW6Cs32LBcDWVw==
X-CSE-MsgGUID: 8RF7edNCQ6+5zyjKd/T0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="104784037"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:40:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Jan 2025 17:40:51 +0200 (EET)
To: Pengyu Luo <mitltlatltl@gmail.com>
cc: andersson@kernel.org, bryan.odonoghue@linaro.org, conor+dt@kernel.org, 
    devicetree@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, heikki.krogerus@linux.intel.com, 
    jdelvare@suse.com, konradybcio@kernel.org, krzk+dt@kernel.org, 
    linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    linux-usb@vger.kernel.org, linux@roeck-us.net, 
    platform-driver-x86@vger.kernel.org, robh@kernel.org, sre@kernel.org
Subject: Re: [PATCH v3 2/6] platform: arm64: add Huawei Matebook E Go EC
 driver
In-Reply-To: <20250114083133.607318-1-mitltlatltl@gmail.com>
Message-ID: <d2a42fc7-37a9-3fcc-4c35-e542ddb112e8@linux.intel.com>
References: <402b261b-e51d-7121-1e13-b1bc1f5d40f5@linux.intel.com> <20250114083133.607318-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1499874815-1736864506=:1077"
Content-ID: <03944f23-5ba5-efab-3be2-7e7a72fa6aa4@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1499874815-1736864506=:1077
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <839add08-5968-6c24-36a6-f31790b45694@linux.intel.com>

On Tue, 14 Jan 2025, Pengyu Luo wrote:
> On Tue, Jan 14, 2025 at 2:56=E2=80=AFAM Ilpo J=C3=A4rvinen <ilpo.jarvinen=
@linux.intel.com> wrote:
> > On Tue, 14 Jan 2025, Pengyu Luo wrote:
> >=20
> > > There are three variants of which Huawei released the first two
> > > simultaneously.
> > >
> > > Huawei Matebook E Go LTE(sc8180x), codename seems to be gaokun2.
> > > Huawei Matebook E Go(sc8280xp@3.0GHz), codename must be gaokun3. (see=
 [1])
> > > Huawei Matebook E Go 2023(sc8280xp@2.69GHz), codename should be also =
gaokun3.
> > >
> > > Adding support for the latter two variants for now, this driver shoul=
d
> > > also work for the sc8180x variant according to acpi table files, but =
I
> > > don't have the device to test yet.
> > >
> > > Different from other Qualcomm Snapdragon sc8280xp based machines, the
> > > Huawei Matebook E Go uses an embedded controller while others use
> > > a system called PMIC GLink. This embedded controller can be used to
> > > perform a set of various functions, including, but not limited to:
> > >
> > > - Battery and charger monitoring;
> > > - Charge control and smart charge;
> > > - Fn_lock settings;
> > > - Tablet lid status;
> > > - Temperature sensors;
> > > - USB Type-C notifications (ports orientation,  DP alt mode HPD);
> > > - USB Type-C PD (according to observation, up to 48w).
> > >
> > > Add a driver for the EC which creates devices for UCSI and power supp=
ly
> > > devices.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219645
> > >
> > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>

> > > +/**
> > > + * gaokun_ec_psy_get_smart_charge_enable - check if smart charge is =
enabled
> > > + * @ec: The gaokun_ec
> > > + * @on: The state
> > > + *
> > > + * Return: 0 on success or negative error code.
> > > + */
> > > +int gaokun_ec_psy_get_smart_charge_enable(struct gaokun_ec *ec, bool=
 *on)
> > > +{
> > > +     /* GBAC */
> > > +     *on =3D 0; /* clear other 3 Bytes */
> >=20
> > =3D false (as it's bool)
> >=20
> > What that comment means??? The type is bool so what "3 Bytes" ???
> >=20
>=20
> We will write to the lowest Byte, the higher 3 Bytes are dirty, so clear =
it.

Are you saying you assume bool is 4 bytes long? I'd be cautious on making=
=20
assumptions on sizeof(bool).
=20
> We can also implememnt it like this
>=20
> int ret;
> u8 resp;
>=20
> ret =3D gaokun_ec_read_byte(.., &resp);
> if (ret)
>         return ret;
>=20
> *on =3D !!resp;

Yes, I prefer explicit u8 -> bool conversion like this.

> > > +/* Fn lock */
> > > +static int gaokun_ec_get_fn_lock(struct gaokun_ec *ec, bool *on)
> > > +{
> > > +     /* GFRS */
> > > +     u8 req[] =3D MKREQ(0x02, 0x6B, 0);
> >=20
> > Does that random acronym map to one of the literal? In which case a def=
ine
> > would be more useful than a comment. (You seem to have a few similar
> > comments preceeding the req definitions)
> >=20
>=20
> They are ACPI method names/identifiers, it will be useful if someone want
> to locate ACPI's implementations.

Okay, I guess it's fine as is then.


> > > +static int gaokun_ec_get_temp(struct gaokun_ec *ec, u8 idx, int *tem=
p)
> > > +{
> > > +     /* GTMP */
> > > +     u8 req[] =3D MKREQ(0x02, 0x61, 1, temp_reg[idx]);
> > > +     u8 resp[] =3D MKRESP(sizeof(__le16));
> > > +     __le16 tmp;
> > > +     int ret;
> > > +
> > > +     ret =3D gaokun_ec_read(ec, req, sizeof(resp), resp);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     extr_resp((u8 *)&tmp, resp, sizeof(tmp));
> > > +     *temp =3D le16_to_cpu(tmp) * 100; /* convert to HwMon's unit */
> >=20
> > extr_resp() does memcpy() but there should be no need to copy anything
> > here. You just want to have __le16 pointer of the response data data.
> >=20
>=20
> I think this would break abstraction, recently, these data are accessed b=
y
> extr_resp() and refill_req() only.

If you want to keep doing it like that, not a big deal for me.

There are different ways to do the abstraction though, and not all require
memcpy() when changing a layer (e.g., a pointer advancing to the other=20
layer).

> > > +/* -----------------------------------------------------------------=
--------- */
> > > +/* EC */
> > > +
> > > +static irqreturn_t gaokun_ec_irq_handler(int irq, void *data)
> > > +{
> > > +     struct gaokun_ec *ec =3D data;
> > > +     u8 req[] =3D MKREQ(EC_EVENT, EC_QUERY, 0);
> >=20
> > Great, here you have named them. Could you name all of the other litera=
ls
> > too, please.
>=20
> I mentioned this in previous version. Most of them are magic, it is hard =
to
> generalize them. We could name partial scmd according to specific functio=
ns
> (sysfs functions), their function names have implied registers' meaning, =
and
> these registers would be never reused in other functions.

Fair (I didn't read every comment made to the previous version).

> > > +/* -----------------------------------------------------------------=
--------- */
> > > +/* API For UCSI */
> >=20
> > for
> >=20
>=20
> Agree

For me, you don't need to reply "Agree", "Ack" or something along those=20
lines if you're going to act on the feedback. Just make sure you don't=20
forget them :-). It'll save us both some time when we focus on points that=
=20
need further discussion.

--=20
 i.
--8323328-1499874815-1736864506=:1077--

