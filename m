Return-Path: <linux-pm+bounces-43808-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDVbB1LLqmlWXAEAu9opvQ
	(envelope-from <linux-pm+bounces-43808-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:40:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D1220CEC
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A06A304F7F8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB83234964;
	Fri,  6 Mar 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUYMEuvB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07681C2FF
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800579; cv=pass; b=qTKdYAddxn8Gs9d69O7tiZCohkIMjvhzH/KiG/yLgRVj36aNm7mwsWr9lXjkSh6DyVLESzAUKZWSm6MtS12hCCu2JBRCZZlz6JMJ1OPJKadsGRXWUt3fnF/+5VeM70ViogNehDxq7KTPP4+1kwUIbEY68C2lJ+9guqqLPH+K6cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800579; c=relaxed/simple;
	bh=3iygJoPOwNrrBVuuOUTp2fQuvBfV8i+a2skvu06vJXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTyU+s7e3JNMidRyNMJHyV2bT/oeiEEbisx+O9qnt8CpSu8PQ+KEbkORwCOjStrG0fCS3eMgqhNpK4j32kxJu9E907Ul4QNN0rLIKeSBAgMBVz1aAFPfQux4wRJ1LaEFhgMAOsQOLwPzuk9iyiJax01fcVn/BIVsfP6bxREURuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUYMEuvB; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439af7d77f0so5403188f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:36:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772800575; cv=none;
        d=google.com; s=arc-20240605;
        b=HPK9e6cYKbzenNrlRyzjGb/1pdz+H8jlEey/CXBwGTSdDtQJv+1z/Dcl9R9Ta4CX2k
         6Rw34bWph9BquTrhG5v5KTmH9LIfFAGppgGlNfAbJs9TS/N8fOaURqDG3tvyGwSKd7Af
         wJilsTQVNvpyiAEb7yTHOM1IaMyauiTBT7wyvjYfsUBtK5z7KX5DmeezwayQBF9Np0x7
         hyvlPzV8p3cFnRiGG/i9nl0B7z2hlLiv8eC30T3BAm71aYTAx8VFj0aBt3ZDRg1IQ4V+
         2zsXgJ2S+LmkzXhqe2o7qSblFPX5u+o+8QdC4I22SgsU5SMIY4iP4CzN1rOwr7miaKPY
         iYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTFOCQ3b3qwQMXCESetVZGrS8ry4DwSa6lkGQRfagWk=;
        fh=fqSmzyTuW4ki1WiKcqkA9g7V5Dd1f7q41orP969E7/8=;
        b=gd/g391N24a0EqvR4guRpUc+s8i7e0N/hPm2ZTu58e3+tQEcMRFSKtytenIMEJDmeZ
         a5LIeuoN35SQDz2Kjxn3ATNclk3Eujb8oFf7fhZ/85bAyniWcaf+lnR/nMasw9zP4EBv
         YSoiBg0HJixb0a4MFaBNB/DSbvtTS18nNxmYgGulSu8AZohQQgBfxRY4PNvDS5XLuLpK
         ZT8zSBeDboYBJcH9gd1XXQn2XTMwAeYnUdPEGUTa7IohDN82eKhqVS7d6v8tJ5ix+2YN
         AV1rHUFu0Th+M0TBe1A0ZSCshrd1fhbVv1B6VyZwdVO/xVmzddj3yqOnncj2V7aKYd6t
         yFcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772800575; x=1773405375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTFOCQ3b3qwQMXCESetVZGrS8ry4DwSa6lkGQRfagWk=;
        b=WUYMEuvBQq7YTwdC+CmYSdfxZhPP7dWxCYvgSBcZ83g3wNpU8a1U5wECKRJ/cqNWiG
         qM6jaBHHVXO1rYFrWgt+eZ4E670pQtZgoVFFTZtgHrO4Abb0Ih50QdgBvzp4eGFx9CPo
         A93fE0kRGxRu/xwE9erilTrcESmQaUFjwDY1KEpSB2vV8jhINS6g57O7aR8zdASe19uB
         Fl6P6oA35AxhLFhB2YB/2uSmkNWNsqGAR9APkhLqHmf/32M1diaR7xVrisP2nfR+phjc
         W9YgrDneovHw4q56RNR4ZxIyMObxx/7zZcm9P9/leh1eksywweTlnNuJmn8+jLeL0FQf
         vJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800575; x=1773405375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTFOCQ3b3qwQMXCESetVZGrS8ry4DwSa6lkGQRfagWk=;
        b=szcKnDsq5QQUxtmTN1XLvrMczct5yOmGZB0Gi45n5rx+shATGkOw/q/kkur88n337C
         vzgWHQHxpJzny6X1JO2E4M4kSx+k7HAu4Us/xDGNkRwM15AhsIsDbj0mMEVgP4oVmyuH
         U69Ab/hcshu61c0ikZAvMfmwZ8ahknz9/QGyDw5ZpksmltkCI/+HF/+HR97j/EpmhTXW
         FLXNdXhrvSOMc6QpRjUXhE/8FUHt2EVKi4tPqvGMyaNwgPjbY8xMopFjBPz4scmyxOlu
         rBvpuwp645TLte8KKGZY/24GZrd5hnB8dXMmmBROtxFNzaePYIodvsnQP4du3Zluq21M
         UpVw==
X-Forwarded-Encrypted: i=1; AJvYcCV0WNnk1Q/uHaPtZFeoOzhruTIgfgcO2exhSHsWRzN5+AyGkGRAL8VEtipg4qJmQWE4iFRX9nCuIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1YgLksMJ0OFca+4F8YrW+UnUMIPXg6JFBBnjfqrBcnEq0KCYY
	8QNWceoVu0KRssSXaBEAPIi0cGzLhp8zEvEgFdeXzZ4+0hdrBXN4JwINWbb6iVGahMUtGfs/x/o
	8Ydn9gw22ydo85YqLgAXkhsSYi2tML2T8knKK
X-Gm-Gg: ATEYQzz5gfliSBoxzG4QqO3Rx1LK/YelBZ1qdPlLozNzmLQE7VwN6J4faooIEVyzT3e
	b8suqRa1pO+QwIaKNCeujHvnjzIYIiGgo4eLVCTnbkr3J84tLnvvGPxxDmjXZERvOuUOcXVDtfF
	aqMU2/ZrC/TKlyssAAi958PSuX4nk5KRJA10EqSkYYJ28j9CNaVOB+eWdHSNQuwsW7vIYynCHPo
	h6VPbTTZfmOQXArknDlouVmvHMleaz8cDb5/CC+fV8U49v5u6MEPAT8SBy6cveQTlZG3wqBVx4V
	mwTVeDth
X-Received: by 2002:a05:6000:2013:b0:439:c9e9:ae58 with SMTP id
 ffacd0b85a97d-439da35f82dmr3419573f8f.22.1772800574941; Fri, 06 Mar 2026
 04:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-5-clamor95@gmail.com>
 <20260306091856.GD183676@google.com>
In-Reply-To: <20260306091856.GD183676@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Mar 2026 14:36:03 +0200
X-Gm-Features: AaiRm50H7lVKIsk91od-d80RXKo6AMK1wPdpR8c14yqEtsKD5PZ9EyDtWP7NlX0
Message-ID: <CAPVz0n0S4WDdL9H6nCbDTYcJ2FqbVv7bfsZFgupdasfp8HdvQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mfd: Add driver for Asus Transformer embedded controller
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 254D1220CEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43808-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qmqm.pl:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

=D0=BF=D1=82, 6 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:19 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 09 Feb 2026, Svyatoslav Ryhel wrote:
>
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > detection and common operations for EC's functions.
> >
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/mfd/Kconfig         |  15 ++
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/asus-ec.c       | 467 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/asus-ec.h | 138 +++++++++++
> >  4 files changed, 621 insertions(+)
> >  create mode 100644 drivers/mfd/asus-ec.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 7192c9d1d268..312fd15eec6a 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -137,6 +137,21 @@ config MFD_AAT2870_CORE
> >         additional drivers must be enabled in order to use the
> >         functionality of the device.
> >
> > +config MFD_ASUSEC
>
> MFD_ASUS_EC
>
> > +     tristate "ASUS Transformer's embedded controller"
> > +     depends on I2C && OF
> > +     select SYSFS
> > +     select ASUS_DOCKRAM
> > +     help
> > +       Support ECs found in ASUS Transformer's Pad and Mobile Dock.
> > +
> > +       This provides shared glue for functional part drivers:
> > +         asus-ec-kbc, asus-ec-keys, leds-asus-ec, asus-ec-battery
> > +         and asus-ec-charger.
>
> Why the additional tabbing?  What example did you take that from?
>

MFD_MXS_LRADC
MFD_SL28CPLD
MFD_STMPE

They use 2 tabs, so I asume I have to switch to 2 tabs and a list too.

> > +       This driver can also be built as a module. If so, the module
> > +       will be called asus-ec.
> > +
> >  config MFD_AT91_USART
> >       tristate "AT91 USART Driver"
> >       select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index e75e8045c28a..b676922601ba 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_MFD_88PM805)   +=3D 88pm805.o 88pm80x.o
> >  obj-$(CONFIG_MFD_88PM886_PMIC)       +=3D 88pm886.o
> >  obj-$(CONFIG_MFD_ACT8945A)   +=3D act8945a.o
> >  obj-$(CONFIG_MFD_SM501)              +=3D sm501.o
> > +obj-$(CONFIG_MFD_ASUSEC)     +=3D asus-ec.o
> >  obj-$(CONFIG_ARCH_BCM2835)   +=3D bcm2835-pm.o
> >  obj-$(CONFIG_MFD_BCM590XX)   +=3D bcm590xx.o
> >  obj-$(CONFIG_MFD_BD9571MWV)  +=3D bd9571mwv.o
> > diff --git a/drivers/mfd/asus-ec.c b/drivers/mfd/asus-ec.c
> > new file mode 100644
> > index 000000000000..e151c1506aa2
> > --- /dev/null
> > +++ b/drivers/mfd/asus-ec.c
> > @@ -0,0 +1,467 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * ASUS EC driver
>
> Copyright?  Author?
>
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/asus-ec.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
>
> Alphabetical.
>
> Are you sure all of these are in use?
>

Yes, but if you are willing to double check I would be happy to
include your findings.

> > +#define ASUSEC_RSP_BUFFER_SIZE               8
> > +
> > +struct asus_ec_chip_data {
> > +     const char *name;
> > +     const struct mfd_cell *mfd_devices;
> > +     unsigned int num_devices;
> > +};
> > +
> > +struct asus_ec_data {
> > +     struct asusec_info info;
> > +     struct mutex ecreq_lock; /* prevent simultaneous access */
>
> We know what mutexes do.
>
> If you're going to provide a comment, state WHAT is is protecting.
>
> Or just omit the comment altogether.
>

checkpatch script requires a brief comment why mutex is used, I added
a brief comment where it is used. If you don't like it, then propose a
fix to checkpatch.

> > +     struct gpio_desc *ecreq;
> > +     struct i2c_client *self;
>
> "client"
>

Is there any written convention that struct i2c_client pointer MUST be
named "client"? "self" is pretty well fitting to. You are just
nitpicking.

> Why are you storing this?
>

To use later on to get device and irq.

> > +     const struct asus_ec_chip_data *data;
> > +     u8 ec_data[DOCKRAM_ENTRY_BUFSIZE];
> > +     bool clr_fmode;
> > +     bool logging_disabled;
> > +};
> > +
> > +#define to_ec_data(ec) \
> > +     container_of(ec, struct asus_ec_data, info)
> > +
> > +static void asus_ec_remove_notifier(struct device *dev, void *res)
> > +{
> > +     struct asusec_info *ec =3D dev_get_drvdata(dev->parent);
> > +     struct notifier_block **nb =3D res;
> > +
> > +     blocking_notifier_chain_unregister(&ec->notify_list, *nb);
> > +}
> > +
> > +/**
> > + * devm_asus_ec_register_notifier - Managed registration of notifier t=
o an
> > + *                               ASUS EC blocking notifier chain.
> > + * @pdev: Device requesting the notifier (used for resource management=
).
> > + * @nb: Notifier block to be registered.
> > + *
> > + * Register a notifier to the ASUS EC blocking notifier chain. The not=
ifier
> > + * will be automatically unregistered when the requesting device is de=
tached.
> > + *
> > + * Return: 0 on success or a negative error code on failure.
> > + */
> > +int devm_asus_ec_register_notifier(struct platform_device *pdev,
> > +                                struct notifier_block *nb)
> > +{
> > +     struct asusec_info *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +     struct notifier_block **res;
> > +     int ret;
> > +
> > +     res =3D devres_alloc(asus_ec_remove_notifier, sizeof(*res), GFP_K=
ERNEL);
> > +     if (!res)
> > +             return -ENOMEM;
> > +
> > +     *res =3D nb;
> > +     ret =3D blocking_notifier_chain_register(&ec->notify_list, nb);
> > +     if (ret) {
> > +             devres_free(res);
> > +             return ret;
> > +     }
> > +
> > +     devres_add(&pdev->dev, res);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_asus_ec_register_notifier);
> > +
> > +static int asus_ec_signal_request(const struct asusec_info *ec)
> > +{
> > +     struct asus_ec_data *priv =3D to_ec_data(ec);
> > +
> > +     guard(mutex)(&priv->ecreq_lock);
> > +
> > +     dev_dbg(&priv->self->dev, "EC request\n");
> > +
> > +     gpiod_set_value_cansleep(priv->ecreq, 1);
> > +     msleep(50);
> > +
> > +     gpiod_set_value_cansleep(priv->ecreq, 0);
> > +     msleep(200);
> > +
> > +     return 0;
> > +}
> > +
> > +static int asus_ec_write(struct asus_ec_data *priv, u16 data)
> > +{
> > +     int ret =3D i2c_smbus_write_word_data(priv->self, ASUSEC_WRITE_BU=
F, data);
> > +
> > +     dev_dbg(&priv->self->dev, "EC write: %04x, ret =3D %d\n", data, r=
et);
> > +     return ret;
> > +}
> > +
> > +static int asus_ec_read(struct asus_ec_data *priv, bool in_irq)
> > +{
> > +     int ret =3D i2c_smbus_read_i2c_block_data(priv->self, ASUSEC_READ=
_BUF,
> > +                                             sizeof(priv->ec_data),
> > +                                             priv->ec_data);
> > +
> > +     dev_dbg(&priv->self->dev, "EC read: %*ph, ret =3D %d%s\n",
> > +             sizeof(priv->ec_data), priv->ec_data,
> > +             ret, in_irq ? "; in irq" : "");
> > +
> > +     return ret;
> > +}
>
> Remove both of these functions and use the i2c_smbus_*() API instead.
>

This would not reduce size much but it will reduce readability
significantly since i2c_smbus_*() API have quite extended names.

> > +
> > +/**
> > + * asus_ec_i2c_command - Send a 16-bit command to the ASUS EC.
> > + * @ec: Pointer to the shared ASUS EC structure.
> > + * @data: The 16-bit command (word) to be sent.
> > + *
> > + * Return: 0 on success or a negative error code on failure.
> > + */
> > +int asus_ec_i2c_command(const struct asusec_info *ec, u16 data)
> > +{
> > +     return asus_ec_write(to_ec_data(ec), data);
> > +}
> > +EXPORT_SYMBOL_GPL(asus_ec_i2c_command);
>
> Why is this needed?  Why not share 'client' with the leave drivers and
> let them make their own calls to i2c_smbus_write_word_data()?
>

Because parent should not share its internal stuff with subdevices.

> > +static void asus_ec_clear_buffer(struct asus_ec_data *priv)
> > +{
> > +     int retry =3D ASUSEC_RSP_BUFFER_SIZE;
> > +
> > +     while (retry--) {
>
> Why is the amount of retries related to the buffer size?
>

Buffer size is 256 bytes, 1 read is 32 bytes. Calculate

> > +             if (asus_ec_read(priv, false) < 0)
> > +                     continue;
> > +
> > +             if (priv->ec_data[1] & ASUSEC_OBF_MASK)
>
> No magic numbers.  Define the 1.
>

#define ONE 1

> > +                     continue;
> > +
> > +             break;
> > +     }
> > +}
> > +
> > +static int asus_ec_log_info(struct asus_ec_data *priv, unsigned int re=
g,
> > +                         const char *name, char **out)
> > +{
> > +     char buf[DOCKRAM_ENTRY_BUFSIZE];
> > +     int ret;
> > +
> > +     ret =3D asus_dockram_read(priv->info.dockram, reg, buf);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (!priv->logging_disabled)
> > +             dev_info(&priv->self->dev, "%-14s: %.*s\n", name, buf[0],=
 buf + 1);
> > +
> > +     if (out)
> > +             *out =3D kstrndup(buf + 1, buf[0], GFP_KERNEL);
> > +
> > +     return 0;
> > +}
>
> The driver is written now.  You can remove this over-engineered debugging
> facility.
>

No, this is logs EC firmware behaior. According to your logic kernel
should have no logging whatsoever, and dmesg output is obviously
redundant.

> > +static int asus_ec_reset(struct asus_ec_data *priv)
> > +{
> > +     int retry, ret;
> > +
> > +     for (retry =3D 0; retry < 3; retry++) {
>
> Why 3?
>
> Why are you using for() here and while() above?
>

Transferred from vendor source. No datasheet.

> > +             ret =3D asus_ec_write(priv, 0);
>
> Add a comment to explain how this works.
>
> Or, better still, define the value.
>

#define ZERO 0

> > +             if (!ret)
> > +                     return 0;
> > +
> > +             msleep(300);
>
> Why 300?
>

Transferred from vendor source. No datasheet.

> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int asus_ec_magic_debug(struct asus_ec_data *priv)
>
> What does this do?  More comments throughout please.
>

Checks firmware behavior. More is not known.

> > +{
> > +     u64 flag;
> > +     int ret;
> > +
> > +     ret =3D asus_ec_get_ctl(&priv->info, &flag);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     flag &=3D ASUSEC_CTL_SUSB_MODE;
> > +     dev_info(&priv->self->dev, "EC FW behaviour: %s\n",
> > +              flag ? "susb on when receive ec_req" : "susb on when sys=
tem wakeup");
> > +
> > +     return 0;
> > +}
> > +
> > +static int asus_ec_set_factory_mode(struct asus_ec_data *priv, bool on=
)
> > +{
> > +     dev_info(&priv->self->dev, "Entering %s mode.\n", on ? "factory" =
: "normal");
>
> Remove all of the debugging prints now.
>

No, this is logs EC firmware behavior.

> > +     return asus_ec_update_ctl(&priv->info, ASUSEC_CTL_FACTORY_MODE,
> > +                               on ? ASUSEC_CTL_FACTORY_MODE : 0);
> > +}
> > +
> > +static void asus_ec_handle_smi(struct asus_ec_data *priv, unsigned int=
 code);
>
> No forward declarations.
>
> > +static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
> > +{
> > +     struct asus_ec_data *priv =3D dev_id;
> > +     unsigned long notify_action;
> > +     int ret;
> > +
> > +     ret =3D asus_ec_read(priv, true);
> > +     if (ret <=3D 0 || !(priv->ec_data[1] & ASUSEC_OBF_MASK))
> > +             return IRQ_NONE;
> > +
> > +     notify_action =3D priv->ec_data[1];
> > +     if (notify_action & ASUSEC_SMI_MASK) {
> > +             unsigned int code =3D priv->ec_data[2];
> > +
> > +             asus_ec_handle_smi(priv, code);
> > +
> > +             notify_action |=3D code << 8;
> > +             dev_dbg(&priv->self->dev, "SMI code: 0x%02x\n", code);
> > +     }
> > +
> > +     blocking_notifier_call_chain(&priv->info.notify_list,
> > +                                  notify_action, priv->ec_data);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int asus_ec_detect(struct asus_ec_data *priv)
> > +{
> > +     char *model =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D asus_ec_reset(priv);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     asus_ec_clear_buffer(priv);
> > +
> > +     ret =3D asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_MODEL, "model"=
, &model);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ret =3D asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_FW, "FW versio=
n", NULL);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ret =3D asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_CFGFMT, "Confi=
g format", NULL);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ret =3D asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_HW, "HW versio=
n", NULL);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     priv->logging_disabled =3D true;
> > +
> > +     ret =3D asus_ec_magic_debug(priv);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     priv->info.model =3D model;
> > +     priv->info.name =3D priv->data->name;
> > +
> > +     if (priv->clr_fmode)
> > +             asus_ec_set_factory_mode(priv, false);
> > +
> > +err_exit:
> > +     if (ret)
> > +             dev_err(&priv->self->dev, "failed to access EC: %d\n", re=
t);
> > +
> > +     return ret;
> > +}
> > +
> > +static void asus_ec_handle_smi(struct asus_ec_data *priv, unsigned int=
 code)
> > +{
> > +     dev_dbg(&priv->self->dev, "SMI interrupt: 0x%02x\n", code);
> > +
> > +     switch (code) {
> > +     case ASUSEC_SMI_HANDSHAKE:
> > +     case ASUSEC_SMI_RESET:
> > +             asus_ec_detect(priv);
> > +             break;
> > +     }
> > +}
> > +
> > +static int ec_request_set(void *ec, u64 val)
> > +{
> > +     if (val)
> > +             asus_ec_signal_request(ec);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(ec_request_fops, NULL, ec_request_set, "%llu\=
n");
> > +
> > +static int ec_irq_set(void *ec, u64 val)
> > +{
> > +     struct asus_ec_data *priv =3D to_ec_data(ec);
> > +
> > +     if (val)
> > +             irq_wake_thread(priv->self->irq, priv);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(ec_irq_fops, NULL, ec_irq_set, "%llu\n");
>
> Document these.
>

Debugfs does not require any documentation.

> > +static void asus_ec_debugfs_remove(void *debugfs_root)
> > +{
> > +     debugfs_remove_recursive(debugfs_root);
> > +}
> > +
> > +static void devm_asus_ec_debugfs_init(struct device *dev)
> > +{
> > +     struct asusec_info *ec =3D dev_get_drvdata(dev);
> > +     struct asus_ec_data *priv =3D to_ec_data(ec);
> > +     struct dentry *debugfs_root;
> > +     char *name =3D devm_kasprintf(dev, GFP_KERNEL, "asus-ec-%s",
> > +                                 priv->data->name);
> > +
> > +     debugfs_root =3D debugfs_create_dir(name, NULL);
> > +
> > +     debugfs_create_file("ec_irq", 0200, debugfs_root, ec, &ec_irq_fop=
s);
> > +     debugfs_create_file("ec_request", 0200, debugfs_root, ec, &ec_req=
uest_fops);
> > +
> > +     asus_dockram_debugfs_init(priv->info.dockram, debugfs_root);
> > +
> > +     devm_add_action_or_reset(dev, asus_ec_debugfs_remove, debugfs_roo=
t);
> > +}
> > +
> > +static int asus_ec_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct asus_ec_data *priv;
>
> Call this "ddata".
>

Is there any written convention that driver private data pointer MUST
be named "ddata"? "priv" is pretty well fitting to. You are just
nitpicking.

> > +     int ret;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->data =3D device_get_match_data(dev);
> > +     if (!priv->data)
> > +             return -ENODEV;
> > +
> > +     i2c_set_clientdata(client, priv);
> > +     priv->self =3D client;
> > +
> > +     priv->info.dockram =3D devm_asus_dockram_get(dev);
> > +     if (IS_ERR(priv->info.dockram))
> > +             return dev_err_probe(dev, PTR_ERR(priv->info.dockram),
> > +                                  "failed to get dockram\n");
> > +
> > +     priv->ecreq =3D devm_gpiod_get(dev, "request", GPIOD_OUT_LOW);
> > +     if (IS_ERR(priv->ecreq))
> > +             return dev_err_probe(dev, PTR_ERR(priv->ecreq),
> > +                                  "failed to get request GPIO\n");
> > +
> > +     BLOCKING_INIT_NOTIFIER_HEAD(&priv->info.notify_list);
> > +     mutex_init(&priv->ecreq_lock);
> > +
> > +     priv->clr_fmode =3D device_property_read_bool(dev, "asus,clear-fa=
ctory-mode");
> > +
> > +     asus_ec_signal_request(&priv->info);
> > +
> > +     ret =3D asus_ec_detect(priv);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to detect EC versi=
on\n");
> > +
> > +     ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > +                                     &asus_ec_interrupt,
> > +                                     IRQF_ONESHOT | IRQF_SHARED,
> > +                                     client->name, priv);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to register IRQ\n"=
);
> > +
> > +     /* Parent I2C controller uses DMA, ASUS EC and child devices do n=
ot */
> > +     client->dev.coherent_dma_mask =3D 0;
> > +     client->dev.dma_mask =3D &client->dev.coherent_dma_mask;
> > +
> > +     devm_asus_ec_debugfs_init(dev);
> > +
> > +     return devm_mfd_add_devices(dev, 0, priv->data->mfd_devices,
> > +                                 priv->data->num_devices, NULL, 0, NUL=
L);
> > +}
> > +
> > +static const struct mfd_cell asus_ec_pad_mfd_devices[] =3D {
> > +     {
> > +             .name =3D "asus-ec-battery",
> > +             .id =3D 0,
> > +             .of_compatible =3D "asus,ec-battery",
> > +     }, {
> > +             .name =3D "asus-ec-charger",
> > +             .id =3D 0,
> > +             .of_compatible =3D "asus,ec-charger",
> > +     }, {
> > +             .name =3D "asus-ec-led",
> > +             .id =3D 0,
> > +             .of_compatible =3D "asus,ec-led",
> > +     },
> > +};
> > +
> > +static const struct mfd_cell asus_ec_dock_mfd_devices[] =3D {
> > +     {
> > +             .name =3D "asus-ec-battery",
> > +             .id =3D 1,
> > +             .of_compatible =3D "asus,ec-battery",
> > +     }, {
> > +             .name =3D "asus-ec-charger",
> > +             .id =3D 1,
> > +             .of_compatible =3D "asus,ec-charger",
> > +     }, {
> > +             .name =3D "asus-ec-led",
> > +             .id =3D 1,
> > +             .of_compatible =3D "asus,ec-led",
> > +     }, {
> > +             .name =3D "asus-ec-keys",
> > +             .of_compatible =3D "asus,ec-keys",
> > +     }, {
> > +             .name =3D "asus-ec-kbc",
> > +             .of_compatible =3D "asus,ec-kbc",
> > +     },
> > +};
> > +
> > +static const struct asus_ec_chip_data asus_ec_pad_data =3D {
> > +     .name =3D "pad",
> > +     .mfd_devices =3D asus_ec_pad_mfd_devices,
> > +     .num_devices =3D ARRAY_SIZE(asus_ec_pad_mfd_devices),
> > +};
> > +
> > +static const struct asus_ec_chip_data asus_ec_dock_data =3D {
> > +     .name =3D "dock",
> > +     .mfd_devices =3D asus_ec_dock_mfd_devices,
> > +     .num_devices =3D ARRAY_SIZE(asus_ec_dock_mfd_devices),
> > +};
> > +
> > +static const struct of_device_id asus_ec_match[] =3D {
> > +     { .compatible =3D "asus,ec-pad", .data =3D &asus_ec_pad_data },
>
> Passing MFD data through a different registration mechanism is not
> allowed.  Use identifiers to match in instead.
>
> git grep "\.data =3D.*void" -- drivers/mfd
>

Why? So for overwhelming majority of the kernel drivers this is
perfectly fine and ok, and for MFD this is no no? Point me please to
any written convention why using OF match (which is a must for any new
driver) is bad? Especially since this driver targets embedded devices
which rely mostly on OF device trees.

> > +     { .compatible =3D "asus,ec-dock", .data =3D &asus_ec_dock_data },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, asus_ec_match);
> > +
> > +static struct i2c_driver asus_ec_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "asus-ec",
> > +             .of_match_table =3D asus_ec_match,
> > +     },
> > +     .probe =3D asus_ec_probe,
> > +};
> > +module_i2c_driver(asus_ec_driver);
> > +
> > +MODULE_AUTHOR("Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>");
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("ASUS Transformer's EC driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/asus-ec.h b/include/linux/mfd/asus-ec.h
> > index 6a36313b9ebd..6a06b125ba30 100644
> > --- a/include/linux/mfd/asus-ec.h
> > +++ b/include/linux/mfd/asus-ec.h
> > @@ -2,16 +2,78 @@
> >  #ifndef __MISC_ASUS_EC_H
> >  #define __MISC_ASUS_EC_H
> >
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/workqueue.h>
> > +
> >  struct i2c_client;
> >
> > +struct asusec_info {
> > +     const char *model;
> > +     const char *name;
> > +     struct i2c_client *dockram;
> > +     struct workqueue_struct *wq;
> > +     struct blocking_notifier_head notify_list;
> > +};
> > +
> >  #define DOCKRAM_ENTRIES                      0x100
> >  #define DOCKRAM_ENTRY_SIZE           32
> >  #define DOCKRAM_ENTRY_BUFSIZE                (DOCKRAM_ENTRY_SIZE + 1)
> >
> > +/* interrupt sources */
> > +#define ASUSEC_OBF_MASK                      BIT(0)
> > +#define ASUSEC_KEY_MASK                      BIT(2)
> > +#define ASUSEC_KBC_MASK                      BIT(3)
> > +#define ASUSEC_AUX_MASK                      BIT(5)
> > +#define ASUSEC_SCI_MASK                      BIT(6)
> > +#define ASUSEC_SMI_MASK                      BIT(7)
> > +
> > +/* SMI notification codes */
> > +#define ASUSEC_SMI_POWER_NOTIFY              0x31    /* [un]plugging U=
SB cable */
> > +#define ASUSEC_SMI_HANDSHAKE         0x50    /* response to ec_req edg=
e */
> > +#define ASUSEC_SMI_WAKE                      0x53
> > +#define ASUSEC_SMI_RESET             0x5f
> > +#define ASUSEC_SMI_ADAPTER_EVENT     0x60    /* [un]plugging charger t=
o dock */
> > +#define ASUSEC_SMI_BACKLIGHT_ON              0x63
> > +#define ASUSEC_SMI_AUDIO_DOCK_IN     0x70
> > +
> > +#define ASUSEC_SMI_ACTION(code)              (ASUSEC_SMI_MASK | ASUSEC=
_OBF_MASK | \
> > +                                     (ASUSEC_SMI_##code << 8))
> > +
> >  /* control register [0x0A] layout */
> >  #define ASUSEC_CTL_SIZE                      8
> >
> > +/*
> > + * EC reports power from 40-pin connector in the LSB of the control
> > + * register.  The following values have been observed (xor 0x02):
> > + *
> > + * PAD-ec no-plug  0x40 / PAD-ec DOCK     0x20 / DOCK-ec no-plug 0x40
> > + * PAD-ec AC       0x25 / PAD-ec DOCK+AC  0x24 / DOCK-ec AC      0x25
> > + * PAD-ec USB      0x45 / PAD-ec DOCK+USB 0x24 / DOCK-ec USB     0x41
> > + */
> > +
> > +#define ASUSEC_CTL_DIRECT_POWER_SOURCE       BIT_ULL(0)
> > +#define ASUSEC_STAT_CHARGING         BIT_ULL(2)
> > +#define ASUSEC_CTL_FULL_POWER_SOURCE BIT_ULL(5)
> > +#define ASUSEC_CTL_SUSB_MODE         BIT_ULL(11)
> > +#define ASUSEC_CMD_SUSPEND_S3                BIT_ULL(41)
> > +#define ASUSEC_CTL_TEST_DISCHARGE    BIT_ULL(43)
> > +#define ASUSEC_CMD_SUSPEND_INHIBIT   BIT_ULL(45)
> > +#define ASUSEC_CTL_FACTORY_MODE              BIT_ULL(46)
> > +#define ASUSEC_CTL_KEEP_AWAKE                BIT_ULL(47)
> > +#define ASUSEC_CTL_USB_CHARGE                BIT_ULL(50)
> > +#define ASUSEC_CMD_SWITCH_HDMI               BIT_ULL(70)
> > +#define ASUSEC_CMD_WIN_SHUTDOWN              BIT_ULL(76)
> > +
> > +#define ASUSEC_DOCKRAM_INFO_MODEL    0x01
> > +#define ASUSEC_DOCKRAM_INFO_FW               0x02
> > +#define ASUSEC_DOCKRAM_INFO_CFGFMT   0x03
> > +#define ASUSEC_DOCKRAM_INFO_HW               0x04
> >  #define ASUSEC_DOCKRAM_CONTROL               0x0a
> > +#define ASUSEC_DOCKRAM_BATT_CTL              0x14
> > +
> > +#define ASUSEC_WRITE_BUF             0x64
> > +#define ASUSEC_READ_BUF                      0x6A
> >
> >  /* dockram comm */
> >  int asus_dockram_read(struct i2c_client *client, int reg, char *buf);
> > @@ -21,4 +83,80 @@ int asus_dockram_access_ctl(struct i2c_client *clien=
t,
> >  struct i2c_client *devm_asus_dockram_get(struct device *parent);
> >  void asus_dockram_debugfs_init(struct i2c_client *client,
> >                              struct dentry *debugfs_root);
> > +
> > +/* EC public API */
> > +
> > +/**
> > + * cell_to_ec - Request the shared ASUS EC structure via a subdevice's=
 pdev.
> > + * @pdev: EC subdevice pdev requesting access to the shared ASUS EC st=
ructure.
> > + *
> > + * Returns a pointer to the asusec_info structure.
> > + */
> > +static inline struct asusec_info *cell_to_ec(struct platform_device *p=
dev)
> > +{
> > +     return dev_get_drvdata(pdev->dev.parent);
> > +}
> > +
> > +/**
> > + * asus_ec_get_ctl - Read from the DockRAM control register.
> > + * @ec:  Pointer to the shared ASUS EC structure.
> > + * @out: Pointer to the variable where the register value will be stor=
ed.
> > + *
> > + * Performs a control register read and stores the value in @out.
> > + *
> > + * Return: 0 on success, or a negative errno code on failure.
> > + */
> > +static inline int asus_ec_get_ctl(const struct asusec_info *ec, u64 *o=
ut)
> > +{
> > +     return asus_dockram_access_ctl(ec->dockram, out, 0, 0);
> > +}
> > +
> > +/**
> > + * asus_ec_update_ctl - Update the DockRAM control register.
> > + * @ec:   Pointer to the shared ASUS EC structure.
> > + * @mask: Bitmask of bits to be cleared.
> > + * @xor:  Bitmask of bits to be toggled or set (via XOR).
> > + *
> > + * Performs a read-modify-write update on the control register using
> > + * the provided @mask and @xor values.
> > + *
> > + * Return: 0 on success, or a negative errno code on failure.
> > + */
> > +static inline int asus_ec_update_ctl(const struct asusec_info *ec,
> > +                                  u64 mask, u64 xor)
> > +{
> > +     return asus_dockram_access_ctl(ec->dockram, NULL, mask, xor);
> > +}
> > +
> > +/**
> > + * asus_ec_set_ctl_bits - Sets bits of the DockRAM control register.
> > + * @ec:   Pointer to the shared ASUS EC structure.
> > + * @mask: Bitmask of bits to be set.
> > + *
> > + * Sets bits of the control register using the provided @mask value.
> > + *
> > + * Return: 0 on success, or a negative errno code on failure.
> > + */
> > +static inline int asus_ec_set_ctl_bits(const struct asusec_info *ec, u=
64 mask)
> > +{
> > +     return asus_dockram_access_ctl(ec->dockram, NULL, mask, mask);
> > +}
> > +
> > +/**
> > + * asus_ec_clear_ctl_bits - Clears bits of the DockRAM control registe=
r.
> > + * @ec:   Pointer to the shared ASUS EC structure.
> > + * @mask: Bitmask of bits to be cleared.
> > + *
> > + * Clears bits of the control register using the provided @mask value.
> > + *
> > + * Return: 0 on success, or a negative errno code on failure.
> > + */
> > +static inline int asus_ec_clear_ctl_bits(const struct asusec_info *ec,=
 u64 mask)
> > +{
> > +     return asus_dockram_access_ctl(ec->dockram, NULL, mask, 0);
> > +}
>
> This is all abstraction for he sake of abstraction.
>

Is this nitpicking for the sake of nitpicking? All 3 are used by
subdevices and have proper descriptions. According to your logic maybe
all clear, set and setclr wrappers should be removed across kernel as
well. And all access functions can be dropped to xfer covers
everything.

> > +int asus_ec_i2c_command(const struct asusec_info *ec, u16 data);
> > +int devm_asus_ec_register_notifier(struct platform_device *dev,
> > +                                struct notifier_block *nb);
> >  #endif /* __MISC_ASUS_EC_H */
> > --
> > 2.51.0
> >
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

