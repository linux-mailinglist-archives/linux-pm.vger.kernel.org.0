Return-Path: <linux-pm+bounces-41982-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMQlKQQkgmnPPgMAu9opvQ
	(envelope-from <linux-pm+bounces-41982-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:36:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242E1DC10C
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4709300B75D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8713D1CB2;
	Tue,  3 Feb 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcbm8xyI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4C3D1CA9
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136107; cv=pass; b=ls5qfYgNIjVQM/1AY2VC61osfe/M85tmGfj+HP83mjB0C0jc1oGkxuhLMkqVdkfqdnp8rxuNjdEG0WQQ/S39D7CSC1yc03OiSEli+jRpBEvPN7iuXu4yJQakVNH8NAOst6jOlDwRsiuv1BGwO2kFxYrFP0inIiW/i4uBp7n5F5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136107; c=relaxed/simple;
	bh=fXSdM/tph+CQ0hSdypd+WHNN70gFwJDk5S/Zwg+BMGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/lZm27RIuSBjVt6UnJesl5Y9WlYMUr3Eye2iJGEyDJEWvVzbXYTVyug6rkRjtcu3UE3ockMfM75J49661Tow8XrMzC5dixGsYkH6uEyzCCwn/XlgJgZwLPWbBAbz1Kkl+6TynQFELq7s+XP7Zik/t1DfzT1+/JCmSAeEYlnW/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcbm8xyI; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso49836215e9.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 08:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770136104; cv=none;
        d=google.com; s=arc-20240605;
        b=R7PzKfsCJZbp1Hp8eGqJfL8yxhM+g5lmQB29PD0ce32vrPpwwyqvo5aygYj/zXr1UI
         Qq99n3ZIGvH94bkQVFTrvaPLbjvU3BKTI8CtbgAb9rThUlY1L/6scN0mUxvHKkPG1WCH
         N7XaMGnhsx5Itqdtchpk+u686kodEVP4ZB19uANcyNL0V+dUnq7UBZfweSiPsLawpz44
         lJMd0x4beo9AfP3BthC/WDTZCLClgAUhmJ7bqylwYQFv3q4hwUmv5xiRnRe4X+DIZjRE
         9GxlZ9upVzICmWV5/eeoqFvOHVEbDA3RVSJ5d71qGO8l1UtCOg7N9/3CqTQt535HHRp/
         V3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gRDaphbKaaiBTQfNJABzc/bHdMK4aRKibRK4EZa3oTc=;
        fh=uMrGIFAfc82PrS3bIWuT8rNjCfy5dFj5U/8guR6fVKc=;
        b=Jh/VaWBejoHxRLgIrKXM+A3VHJoZHVacQFfhs+RwqMV4xYtkvMRAsL+7bh8unT2qtG
         v9vq1JooT2adMxfMHMZnklnVFZz+YJvGaNfJMYsKthsbm8WinFyjsbv3KPWMWgMRGCRZ
         2yp9vHPn+tHEbzYR5apu6UnTjfItiA7ZHRhy7/Rp3dW+H9KTorBJAywq7KNwNRXwWjj/
         oyagy9Ey1ylikPW2uOvsPP24tPW7QKkz5Kgc98HlgiaBT4rrndE2KrXXmm6s/8HFFwMS
         /78Ja9XbohJu/ILt0YLyIdL1g+FdL2+4KyqmXh3CEofuY6Bdoh49UMc/fy7DSYkIA1JM
         +arQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770136104; x=1770740904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRDaphbKaaiBTQfNJABzc/bHdMK4aRKibRK4EZa3oTc=;
        b=Hcbm8xyItJ7T//WYCVBSa+eAv5LUDufCmbSIr9/0EatuyOo/AosxsDdhj0awaik0lU
         HTZXFjQn7DhpDgu+K0Iz0mk0vqNO67pD1S92IS6NN2QCdfDY3T41asrGQqh4K4yhA48v
         STzrDQae4Nm7c4rTYcRvxl7NbIqZgN0gCqQs0ejELh1klRYalpIMgakz0jJxejEQ5l58
         z7rQM0PvIs4DrVB51oSKlh+Fc74uQdN4pTbqKVfXIZOg0Su5gX9mFCFKfYRIGOh2VyQ4
         BAu7K0EVSgIquiKYGhAbquLZH4T3kTh1UyU4XneTt3hrBoJ5Hcy5TwPEc5K/ZFTpdwtR
         jJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136104; x=1770740904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRDaphbKaaiBTQfNJABzc/bHdMK4aRKibRK4EZa3oTc=;
        b=JsXzs0E5QAHOiLX4cOBRvy7sU4HnLW9OhjIvJ7m7d7NgpM6CvwWPS46MVh/mFycm/V
         FQ54KzDX8ArvkJyS6XXyUk12ZGAjy4fcdpfbRiHWwMt0ZpsrWGOsGzyYcN5K8eutp2eh
         I02pJfbragyUO/MJA2aaYnJ347KueMtQ3OebCkMZ8Y8tlXHBJcxecduTfLkA8j4WAE32
         sT/3adItvCvMn9ISrrX+9VsKf8WVVogqAlxWmYFTwM0b+pbMDVZ1ZsGTuP2fDtyI4pFZ
         OgumhI6cIx5HiuDgS4aaRL4s5T7enDYCf/LYMLrVOm4E3wzXIqUPKCJW87Ri+V2EsGsb
         UKkg==
X-Forwarded-Encrypted: i=1; AJvYcCU+6RzzHDAwyaUKOCnkbH/TnFiJfYa46R/7CMom7iLvD8g92ToAxvf/1+7qLFaYxjHuWIHkEaMOUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9/4rvSAlhOrRNywJVFyItPGGxJwIt8fLRKHW65oqVa3bSDWO
	pg2v95CmkPzV7KsqHRwxl5n38ikjd4ohjmYBRNcRC8giqWbohyy3SfEETs0bIAcCEyk9pGJIQ+4
	xHB9FEMcOS0efIZndvnWhO6ZlzE+tpFw=
X-Gm-Gg: AZuq6aKlAknYYsD7l4UE7v78dfwBVe1XDIvb4bdNgeUnDVGpJTfwSDTcrLeqSbcFUgV
	caebyMszmgxaVJ3Xne07Lh/4JiQjSxyKEiCbgIb7irxfAnQ3etgEu4OPLhP05akR0dc8eR6DIpb
	gzVCzAW7cxIgk7WbJlktljY0PjdbhccTWEWOoew27bMa6LKuBHa4diH07ews3bV3r+5qehm4KaO
	1ChEi+Zzn4mpXgTnrZiU9xcb6a9Z42zw6I0UDBmb3jHbgtXpBhgpU6u1xW61Gup+Y/AtzA/
X-Received: by 2002:a05:600c:8505:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-4830e983855mr2996525e9.29.1770136104240; Tue, 03 Feb 2026
 08:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh> <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh>
In-Reply-To: <2026020346-ashamed-campfire-b483@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 18:28:11 +0200
X-Gm-Features: AZwV_QhcrxqiNzZ8cC3BM6w2wrqMyFc9v-0naWUEm2SUwORm6CXF_qwNkbtlMVY
Message-ID: <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41982-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,rere.qmqm.pl,agorria.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 242E1DC10C
X-Rspamd-Action: no action

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:00 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:41 G=
reg Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/misc/asus-dockram.c
> > > > @@ -0,0 +1,327 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * ASUS EC: DockRAM
> > > > + */
> > > > +
> > > > +#include <linux/device.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/mfd/asus-ec.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/sysfs.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/unaligned.h>
> > > > +
> > > > +struct dockram_ec_data {
> > > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > +};
> > > > +
> > > > +int asus_dockram_read(struct i2c_client *client, int reg, char *bu=
f)
> > > > +{
> > > > +     int rc;
> > > > +
> > > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > > +     rc =3D i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENT=
RY_BUFSIZE, buf);
> > > > +     if (rc < 0)
> > > > +             return rc;
> > > > +
> > > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc=
: %d\n",
> > > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > +             return -EPROTO;
> > > > +     }
> > > > +
> > > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> > >
> > > No documentation for these new public symbols?
> > >
> >
> > These functions are mainly used in communication between the dockram
> > device, asus-ec and its subdevices. Export is used here because all
> > mentioned devices can be built as modules. I can add descriptions of
> > functions into header if needed, but they should never be used outside
> > of dockram-EC complex. Same applies to 2 export functions in the EC
> > MFD.
>
> Then you should properly document this :)
>
> > > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > > > +static DEVICE_ATTR_RW(control_reg);
> > >
> > > You did not document your new sysfs files in Documentation/ABI/ which=
 is
> > > required.
> > >
> > > Also, why do you need a brand new user/kernel api at all?  Who is goi=
ng
> > > to use this and for what?
> > >
> >
> > These api were used mainly for debugging/logging purposes and descend
> > from original downstream EC driver. I can both add documentation into
> > ABI or remove them if that is absolutely necessary.
>
> Debugging should not be in sysfs, please put this type of stuff into
> debugfs instead if you really need it.
>

There is no similar way to handle BIN_ATTR_RW in the debugfs (), may I
preserve  dockram_read/write with __maybe_unused instead of removing
them? I will add comment with explanation

> thanks,
>
> greg k-h

