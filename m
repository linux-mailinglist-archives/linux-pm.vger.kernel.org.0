Return-Path: <linux-pm+bounces-42468-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEgOBB97i2nTUgAAu9opvQ
	(envelope-from <linux-pm+bounces-42468-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 19:38:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A384511E5B0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 19:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6B2303CC38
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163632BF32;
	Tue, 10 Feb 2026 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QJaR+wE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F362DAFDD;
	Tue, 10 Feb 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748695; cv=none; b=YoCdDMcA0TlzM5H/YH6Gy/Kp7M6ngcdyqmZAKj6G9ow6UCOgR0oyTqwZLRNgixIKJ8dipROHKrFBh295YFQU/EXUQNn2zxCIK4d80TUyw38ql+245Kg14AikS++8q5eQ7CkreooazNTbvV7o1bDSsfqaX5nM8xUGWh0bG0aelfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748695; c=relaxed/simple;
	bh=0S3RJow1qD7PFdkhzxVnh4+LwnKI1lU+DZNFvWp386o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IEMU4ezDBk+Vbxh/DBdeT43dXi0lGeDejK/E2XZFs+34CtvYMdyQwhA9lDpI6FyW8irZHco7BmovELi7LWOwWPQxA1TAKGtbsILUhRMQiQCzqS1QEMMavSBGY4SubMFmDSsv5rdvEVBcEEq/8yLE9T3A3Okw/ldy9xHT0WnT0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QJaR+wE+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 65D9826E45;
	Tue, 10 Feb 2026 19:38:05 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxMFZOdYNC1j; Tue, 10 Feb 2026 19:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770748684; bh=0S3RJow1qD7PFdkhzxVnh4+LwnKI1lU+DZNFvWp386o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=QJaR+wE+1zXkxKP4PgxVfqx8aPct1wMFu6bp0neQIu2LEWMCyFNZBTq6TEW5EAsMu
	 e1JBYnTsrnXckubEcRNki6Jci1tPDUrr+DLpjDmNaIBJc3AIqgNnI2j0bOtqMyjliQ
	 3Mq2G1Vl/K6xwoGHbmkN+Ar/re1/CKwQZUaGbnBlu1Yai9OOBhvk+l9zrmEOt0SnCU
	 o8dU44CF7kTCn8xQ92CFCmUob9CxQ5r+XYzYDGs9xTLCUj6RwUHeEZB252FDEDVAXC
	 Ds+Mc89LfdcrpXGs+nqEexg1J/p5qoe5b7tW3XprZQSUuvJbUPBGWK41S959DanCBF
	 4ZkcqIcVWvGPA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Feb 2026 00:07:50 +0530
Message-Id: <DGBI0L4E59ZY.24OGXR0XUDH4Z@disroot.org>
Cc: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 08/12] leds: flash: add support for Samsung S2M
 series PMIC flash LED device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Kaustabh
 Chakraborty" <kauschluss@disroot.org>, "Lee Jones" <lee@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "MyungJoo Ham" <myungjoo.ham@samsung.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "Sebastian Reichel" <sre@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-8-78f1a75f547a@disroot.org>
 <e34d429e27392eba894b9592724a77fa82fc8009.camel@linaro.org>
 <DG75VP6IIUXD.1VA6YSMNTPJQ6@disroot.org>
 <9dad174d88c814d3ad2086a31e8dfc222fd431e4.camel@linaro.org>
In-Reply-To: <9dad174d88c814d3ad2086a31e8dfc222fd431e4.camel@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42468-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A384511E5B0
X-Rspamd-Action: no action

On 2026-02-10 10:03 +00:00, Andr=C3=A9 Draszik wrote:
> On Thu, 2026-02-05 at 21:46 +0530, Kaustabh Chakraborty wrote:
>> On 2026-02-04 16:55 +00:00, Andr=C3=A9 Draszik wrote:
>> > Hi,
>> >=20
>> > On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
>> > > Add support for flash LEDs found in certain Samsung S2M series PMICs=
.
>> > > The device has two channels for LEDs, typically for the back and fro=
nt
>> > > cameras in mobile devices. Both channels can be independently
>> > > controlled, and can be operated in torch or flash modes.
>> > >=20
>> > > The driver includes initial support for the S2MU005 PMIC flash LEDs.
>> > >=20
>> > > Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> > > ---
>> > > =C2=A0drivers/leds/flash/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
>> > > =C2=A0drivers/leds/flash/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> > > =C2=A0drivers/leds/flash/leds-s2m-flash.c | 410 ++++++++++++++++++++=
++++++++++++++++
>> > > =C2=A03 files changed, 423 insertions(+)
>> > >=20
>> > > diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
>> > > index 5e08102a67841..be62e05277429 100644
>> > > --- a/drivers/leds/flash/Kconfig
>> > > +++ b/drivers/leds/flash/Kconfig
>> > > @@ -114,6 +114,18 @@ config LEDS_RT8515
>> > > =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the=
 module
>> > > =C2=A0	=C2=A0 will be called leds-rt8515.
>> > > =C2=A0
>> > > +config LEDS_S2M_FLASH
>> > > +	tristate "Samsung S2M series PMICs flash/torch LED support"
>> > > +	depends on LEDS_CLASS
>> > > +	depends on MFD_SEC_CORE
>> > > +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>> > > +	select REGMAP_IRQ
>> > > +	help
>> > > +	=C2=A0 This option enables support for the flash/torch LEDs found =
in
>> > > +	=C2=A0 certain Samsung S2M series PMICs, such as the S2MU005. It h=
as
>> > > +	=C2=A0 a LED channel dedicated for every physical LED. The LEDs ca=
n
>> > > +	=C2=A0 be controlled in flash and torch modes.
>> > > +
>> > > =C2=A0config LEDS_SGM3140
>> > > =C2=A0	tristate "LED support for the SGM3140"
>> > > =C2=A0	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>> > > diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefi=
le
>> > > index 712fb737a428e..44e6c1b4beb37 100644
>> > > --- a/drivers/leds/flash/Makefile
>> > > +++ b/drivers/leds/flash/Makefile
>> > > @@ -10,6 +10,7 @@ obj-$(CONFIG_LEDS_MAX77693)	+=3D leds-max77693.o
>> > > =C2=A0obj-$(CONFIG_LEDS_QCOM_FLASH)	+=3D leds-qcom-flash.o
>> > > =C2=A0obj-$(CONFIG_LEDS_RT4505)	+=3D leds-rt4505.o
>> > > =C2=A0obj-$(CONFIG_LEDS_RT8515)	+=3D leds-rt8515.o
>> > > +obj-$(CONFIG_LEDS_S2M_FLASH)	+=3D leds-s2m-flash.o
>> > > =C2=A0obj-$(CONFIG_LEDS_SGM3140)	+=3D leds-sgm3140.o
>> > > =C2=A0obj-$(CONFIG_LEDS_SY7802)	+=3D leds-sy7802.o
>> > > =C2=A0obj-$(CONFIG_LEDS_TPS6131X)	+=3D leds-tps6131x.o
>> > > diff --git a/drivers/leds/flash/leds-s2m-flash.c b/drivers/leds/flas=
h/leds-s2m-flash.c
>> > > new file mode 100644
>> > > index 0000000000000..1be2745c475bf
>> > > --- /dev/null
>> > > +++ b/drivers/leds/flash/leds-s2m-flash.c
>> > > @@ -0,0 +1,410 @@
>> > > +// SPDX-License-Identifier: GPL-2.0
>> > > +/*
>> > > + * Flash and Torch LED Driver for Samsung S2M series PMICs.
>> > > + *
>> > > + * Copyright (c) 2015 Samsung Electronics Co., Ltd
>> > > + * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
>> > > + */
>> > > +
>> > > +#include <linux/container_of.h>
>> > > +#include <linux/led-class-flash.h>
>> > > +#include <linux/mfd/samsung/core.h>
>> > > +#include <linux/mfd/samsung/s2mu005.h>
>> > > +#include <linux/module.h>
>> > > +#include <linux/of.h>
>> > > +#include <linux/platform_device.h>
>> > > +#include <linux/regmap.h>
>> > > +#include <media/v4l2-flash-led-class.h>
>> > > +
>> > > +#define MAX_CHANNELS	2
>> > > +
>> > > +struct s2m_fled {
>> > > +	struct device *dev;
>> > > +	struct regmap *regmap;
>> > > +	struct led_classdev_flash cdev;
>> > > +	struct v4l2_flash *v4l2_flash;
>> > > +	struct mutex lock;
>> >=20
>> > Please add a (brief) comment describing what the mutex protects.
>>=20
>> The mutex object prevents the concurrent access of flash control
>> registers by the LED and V4L2 subsystems. -- will add this.
>>=20
>> > > +
>> > > +	/*
>> > > +	 * Get the LED enable register address. Revision EVT0 has the
>> > > +	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
>> > > +	 */
>> > > +	if (priv->pmic_revision =3D=3D 0)
>> > > +		reg_enable =3D S2MU005_REG_FLED_CTRL4;
>> > > +	else
>> > > +		reg_enable =3D S2MU005_REG_FLED_CTRL6;
>> >=20
>> > You could REG_FIELD() and friends for this and everywhere else with
>> > similar if / else.
>> >=20
>>=20
>> REG_FIELD(), from what I understood, is for selecting a bit field inside
>> a single register. However this code chooses between two separate
>> registers. I believe your interpretation was incorrect? Please clarify.
>
> The first argument to REG_FIELD is the register itself, so reg fields can
> be used to describe this difference. See e.g. drivers/leds/rgb/leds-mt637=
0-rgb.c
> Of course, you could have a member variable instead to hold the register
> index if all bits are the same in both revisions. Either way would avoid
> having to constantly check the revision during runtime.

Wow, this is a great way of abstraction, thanks. I will try to implement
this in all drivers, let's see.

>
> Cheers,
> Andre'


