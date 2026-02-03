Return-Path: <linux-pm+bounces-41986-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAsBKHQogmnPPgMAu9opvQ
	(envelope-from <linux-pm+bounces-41986-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:55:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC3DC557
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B073025D02
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5933D6DF;
	Tue,  3 Feb 2026 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2dQmV9r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72F395D99
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137417; cv=pass; b=UmAvRETtNfDBi6+6xR6r+Zf+VxnzQE/1EXt3cYVf8eOM/haXMoAaOUjoRLKADYoBhA1kXfD9LOLmB+rxqiT7H1PCY5671Q4SRrXcUYW5YdlDGf4u0gSU8rcMOiwn2LlTlo/4PWhI+HbrdN5Frpi4XRpME3wMXIc31kdd1Mg1KXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137417; c=relaxed/simple;
	bh=LrQnpvin4jtRqTsha3/cBUOZ8TmO+h7BvZEhl43PHAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO9TtO1NtqFpqrPrzWbK9h7gBj3SBNJPHcn9gKCMFvMfuyDhHUY1rXhlAXYorIb5F0Xg5A+6HHv1/6IdgGlmutYynhBkJUtQ20xg4FRV7HSHZch4c10AcgJ/B2lQtmUVz9ay3irjSEaYlIy/yQ9JWG9sKK9bx1OAGO63hXIzUY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2dQmV9r; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so47935195e9.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 08:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770137413; cv=none;
        d=google.com; s=arc-20240605;
        b=Q8+TvQsgQH6BzGFz3k3aTN+puCJrvIPOoTaP7QUxa7eQSqePW+ZH0GhIrSQqidWMPw
         tOZbdFWuAKZ1JfIYM5PGWo2j5osJEzydPXWh9cNhj3ILyejXyQ/o+im4+I6OPOhizQUL
         NwApNK9UGwndGLIzQ4SSdMwHYbHEJvhMV+RTMSQ7PGj934U4NXxbn8njpElZmDwVbW2I
         uic/0KcBbiJ/hF+n8vQ4s3pbqtLSIKbagqb8oFTNqx5jVVmnOwMC2AGFM62LEMoVQzZH
         hECYVcO45zkULRQrXZOsGmKYCnVw+lEquwYKeDtQU8Og7bCpsIMvorgcFwUhRRMHJG7t
         k96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peC1LbgC8hk+M9QjMfBLz3bgPIBhDM3o4nZmhT+Urjk=;
        fh=NIFTA/p8TyQN2mNwKVIQ85iA77j+sWQDTDfJ4V2q0kM=;
        b=No5Bew3iwANT9SaUAvD1FhExOpLQOjZQD7SXqxb7PKvR99k7YhQKS62Yv+8EWK+Dls
         tPWr7+22ENEcMJd96H1QvF6cI+QRAy2uBxbLYElPVYUYp8THJna51TPg1AO5xqrLtqeu
         +EfgB/8xCszz96Lu8H9GJmCtCQRmZQmegOmulMngrLMybP4ppAGkmGss+RfBvhWVS+L2
         02Bhfah7vE3V3toiYodblQeWnMlUeoigBkZSRs/L5a66UkOrVClxv5Pqh3+t1NB5aeRO
         icCdMifXrnPNalYzY68amwBFx+NyUCaVH7vttAg2r9pHToJ7pZaQPiepnBCqw9A7xPBc
         suGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770137413; x=1770742213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peC1LbgC8hk+M9QjMfBLz3bgPIBhDM3o4nZmhT+Urjk=;
        b=l2dQmV9rfqTvBDqTAxv/XOKuhb1MNeWZmU0EFv+Apr8CU1PzRklu24uu3akqqWRpKf
         1D93WWfNTeSex8YQ5j6Cfkf4Ol7dvWfSqUcjXWCNTNIYTbIgfe7g2c2Rg9wUbWCSwY5B
         E97KAd/ZWA8bAS+dlvZ8XJNo3gWgOB1CQtI0Wp3hgsq2z7w2SMPA2kx/55qBprAUEA0E
         mtSNsxJUg4v2h5mVu5GZVLGmzuYthb5Owz1867Q40GqSztumvSiQ1FSNJe6uJrxVfsdR
         wTZjbGj8EuqwdDgnefbI+HLiEYPH7z7+rzMRRC2httg0Zajl7eqYp+SomWUXnEBZOBnn
         3SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137413; x=1770742213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=peC1LbgC8hk+M9QjMfBLz3bgPIBhDM3o4nZmhT+Urjk=;
        b=Ga08ZKDboHxGBV7/tUizBScprhj3VnEYVrXUdciAt/1PYOu+RHxzdXz6qzaN37jTRL
         2OL94AhWPJPsvPEW/CZ/SBFg+JW1YzST6ok3jYZFYQfkfiWxX5qzgvemdk4rCQw44TMr
         bEisg6mXo3OaCSxl2PFpFgKd8VsFHwN3aXbE+MuXFLATHc54Ziilg4V2Z/pi/FHLagXK
         mkxciuwSoPGFIuAQFpHkzWK0FNXNQ88EG8cjV4GEGsmvauakbbRZ5vMX2XYRgnOHkp2d
         GK8MaQznUWY0hnqP6kfGJ2h0TSH2JW4uBwvXoiHxLxU5yxdlLS94m9CryRPxjdWSJvyF
         gCnA==
X-Forwarded-Encrypted: i=1; AJvYcCUHQZNfNplZWZnrdVDTzkVqxtZATuTkzPNXC4fVx3g9cNaM6s1hu1vZK60gOTH6dZYztHnRv3NgSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv66iRe6gwUQYjSiORp4CMf6y+mw9maRsHEgSpk6ZaHmd6+Xz8
	WHokjKMafuqAhHoXeOZtuGlzVfxDu+TRrcqdphCTN8Qc779FlWZvv6pvgI7GAJyaeFDbAOA5ZyD
	VKgOLR0FydE4WeKCzss9OTF+pqPZ1lFI=
X-Gm-Gg: AZuq6aIK9ucxBXOYeL9prC3mBi6wzeYLPNJ9OX7aqQk9eEP0Phjn80ZGo18lfsqjWLc
	ZgvDQ2NApvg76+jA9MBE8NBO2uZcPKsaX5/4azXAXkzK3j51HR7jnuFuAkPk1XlXNyOC4ysECQ6
	ycyOKZyycjNt3uxsdmB5BW1PJ0tWyAZdbt/SjEW7Digt2SfyYDVQa/UBF1UQGcrdGfb29kOCH6B
	8Uh1D8wPAooEdjUn3w0LdcOQd+C9lE359J/+Kh9tLSlQ/sH3fuib6pGjH/xble0LCTUiJ+x
X-Received: by 2002:a05:600c:4513:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-4830e97a05bmr3659285e9.33.1770137413203; Tue, 03 Feb 2026
 08:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh> <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh> <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
 <2026020314-humbling-mobility-c24a@gregkh>
In-Reply-To: <2026020314-humbling-mobility-c24a@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 18:50:01 +0200
X-Gm-Features: AZwV_QhyAHDV7XSYIRgT7-uQ1XQONO6unrRbKGh2IXqIB7iOHyEWGvsJ3FZAmW0
Message-ID: <CAPVz0n0TMOCYnMiVUZ7xx-1SqrXuaVCOY-o4-x9L=f-xSMDj8g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41986-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,rere.qmqm.pl,agorria.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 10AC3DC557
X-Rspamd-Action: no action

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:45 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 03, 2026 at 06:28:11PM +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:00 G=
reg Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> > > > =D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:=
41 Greg Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > > >
> > > > > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/misc/asus-dockram.c
> > > > > > @@ -0,0 +1,327 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > +/*
> > > > > > + * ASUS EC: DockRAM
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/err.h>
> > > > > > +#include <linux/i2c.h>
> > > > > > +#include <linux/mfd/asus-ec.h>
> > > > > > +#include <linux/mod_devicetable.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/mutex.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +#include <linux/string.h>
> > > > > > +#include <linux/sysfs.h>
> > > > > > +#include <linux/types.h>
> > > > > > +#include <linux/unaligned.h>
> > > > > > +
> > > > > > +struct dockram_ec_data {
> > > > > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > > > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > > > +};
> > > > > > +
> > > > > > +int asus_dockram_read(struct i2c_client *client, int reg, char=
 *buf)
> > > > > > +{
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > > > > +     rc =3D i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM=
_ENTRY_BUFSIZE, buf);
> > > > > > +     if (rc < 0)
> > > > > > +             return rc;
> > > > > > +
> > > > > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > > > > +             dev_err(&client->dev, "bad data len; buffer: %*ph=
; rc: %d\n",
> > > > > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > > > +             return -EPROTO;
> > > > > > +     }
> > > > > > +
> > > > > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > > > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> > > > >
> > > > > No documentation for these new public symbols?
> > > > >
> > > >
> > > > These functions are mainly used in communication between the dockra=
m
> > > > device, asus-ec and its subdevices. Export is used here because all
> > > > mentioned devices can be built as modules. I can add descriptions o=
f
> > > > functions into header if needed, but they should never be used outs=
ide
> > > > of dockram-EC complex. Same applies to 2 export functions in the EC
> > > > MFD.
> > >
> > > Then you should properly document this :)
> > >
> > > > > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SI=
ZE);
> > > > > > +static DEVICE_ATTR_RW(control_reg);
> > > > >
> > > > > You did not document your new sysfs files in Documentation/ABI/ w=
hich is
> > > > > required.
> > > > >
> > > > > Also, why do you need a brand new user/kernel api at all?  Who is=
 going
> > > > > to use this and for what?
> > > > >
> > > >
> > > > These api were used mainly for debugging/logging purposes and desce=
nd
> > > > from original downstream EC driver. I can both add documentation in=
to
> > > > ABI or remove them if that is absolutely necessary.
> > >
> > > Debugging should not be in sysfs, please put this type of stuff into
> > > debugfs instead if you really need it.
> > >
> >
> > There is no similar way to handle BIN_ATTR_RW in the debugfs (), may I
> > preserve  dockram_read/write with __maybe_unused instead of removing
> > them? I will add comment with explanation
>
> debugfs allows you to do much much more than simple stuff like
> BIN_ATTR_RW().  Go wild there, but don't put debugging stuff in sysfs,
> that is NOT what it is there for at all, but rather, that is exactly
> what debugfs is for.
>

I am removing said stuff from sysfs, that is not what I am asking.
Debugs does not allow to upload register values in a form of binary
block. It allows only dumping via debugfs_create_blob or
debugfs_create_regset32 but not writing. If you know examples of
reading and writing register sets as binary data, please point me to
it.

I am asking if it is possible only to preserve dockram_read/write
functions in the code, without exposing it to sysfs.

> thanks,
>
> greg k-h

