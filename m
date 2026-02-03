Return-Path: <linux-pm+bounces-41962-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WINeJTbkgWmDLQMAu9opvQ
	(envelope-from <linux-pm+bounces-41962-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 13:04:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41002D8BD1
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97440303CD19
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9D33CEB9;
	Tue,  3 Feb 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdzPS04D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D643382C8
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120107; cv=pass; b=cydPmH8b+xRCL+0kTO7U+uvGD+rwVMSm3ftGQqTQbnf34P5aRU/V65KMwqHZYbJwYxPfnEJKRqnIoaYSuRZaCEDbslCmuHfCSm9Xm+Lo2/2+6TvNg07ZeW6EGRWUmpX2d3K+q9L7Z3ZOu62EIlELrt3IZj4X4hZssrNVEHEWu1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120107; c=relaxed/simple;
	bh=KgIolBAt6/FrgaPpJwLax8SGQvAvtZV5AB2VrW6pIuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANeLvfgLip7OEY1Wg4aTaKd1ADTUPDCzeb5lwCYuYXkmU94jFmhN894NglU9IcGNU3STFSh4gk8CwH0XHsg4Z6yTDJ6w/9UKGwsCGGMvbrfNH//3ld4zHIotI14AZvQhscTrGm7H75lAhkkmdQlXx/MRTNNNpEDqxAUAEms0LHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdzPS04D; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4749517f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 04:01:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770120104; cv=none;
        d=google.com; s=arc-20240605;
        b=ZuImb5ZvAsoUryl6WuXI2Ko1A9lUDR1oh0Ra0BIgKIdZdTPYs2Hds20cpey1mc70e7
         5jmAlXiBO6rg6W/8l0+4g8OjlVyU5YvEtB1eqhdV92eVUCDfKQro4RU9f99OvtS2EoFD
         S5QziUM0ZswsjBRV6ayAbBgVqeYOQCg2XcysSkkNU0ySwIx3TdjD++s1xKDlllLY4hC2
         gGXwRdHIMFulgtAr4qWABFcdEl8rWrS0NVEDiThOSKE6fnxvpr7XEKNJo0CqlRoPhOHN
         aw5DtU7bXGzAJC8HapE1CEfOrmJHq3uyHW519iCLclBR5j/KvntzeYw+OQPH541WdwpU
         8k5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2VFmkjkyUco8JpC8ERq9+9wVbEgE55aH092lxEE7AA=;
        fh=22CGc/oVGDu7o7ZkAEEgvDQqzAu8BcH+PFY4c9EYIUI=;
        b=WRplMTPVLR+ufcSqi/KneY+TvjPzALz3B7IftiOsnS25DvImIsD+/HVF+d45wwBuOD
         ioWaGjg9bFQbnd9BrpyIKmLf7BcwtmBKGlwO8LOCTK2AHvmfmTIAqoY79dBleNt6lon/
         ltr/PVL62FOpA82bjVczpTUz5+ATv5p6yy0dSILRYVBYYlhAe3dBMq2SRmFmki4qQ1UQ
         vhjnvrxuIFkrKpaz89CtxnsN1sw2SMRpTHatpR4j3/JUvtVS8r+Aq/YjBWQRePvzobaE
         2ki31OWoWBOPFL/eaTxrOQIm9oSqxrXInUwTA/ZT9jfRTd/rRJs8bfOG4ItM3MQifa8H
         YI1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770120104; x=1770724904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2VFmkjkyUco8JpC8ERq9+9wVbEgE55aH092lxEE7AA=;
        b=GdzPS04DgJWbVhGdA2GLpyD8YFmtcjDo0w9k/VpyWJJdd4iucnSGHa5kANfD5xlCq3
         dRpMLqpGB6czdTfsSaBp9QXOFEodZu8Q/Zr7gCdCXkRTDBR/a2nX6lJeMccHDkWeGmnh
         St/H7SbdgVyC68OlR8eFBdd4ar9PSRRx9R5iPjJBPzm4bO3SRw0I2P7IH7CC42csFy5N
         1u9LzhMnOlg3WwT0oEwd0MGlLlaeNuGGWJtYCdZesXVBPdt4a3jKWdfH/DL5yEuTdbXV
         M9yt0/8MQHqyC7+RNyO4YMajTtUFqpgLhLv8WnJ2HRgt+EHfgfDR9qLCYs1akpxRVX4l
         MeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120104; x=1770724904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2VFmkjkyUco8JpC8ERq9+9wVbEgE55aH092lxEE7AA=;
        b=McW8pSogyu6qOH/+2JnBDV2HMYIXUM8JT0n2VkFlLM/2ZiOkfezLmMr4ogUeWEk+Ym
         MnpYGHNYrD+2TZx9ZvcAroxBIht3m2ebzXnafyVT5NzAjUFcAi9iD4RnAvE11Eo50DrW
         T7xozjHxwZKdAVBsw++ZktYPDSBWGS3ZpkW7XPYISJeijS7pyqFYhQ01PNo4gLuIL4VH
         RAKQaK3bj5yXNmwKCdRUWKJ7+j7KMcYvtjw4094y11AjWxJnBxQCy+DCwK2//dr7ifvc
         v5f01Xtr5TRTAhmCghRGpJoiEl2CB9lS3xEFs1w/9cdSP1zqXLFevWfDa9AdqGO+R1gz
         jghA==
X-Forwarded-Encrypted: i=1; AJvYcCVlPswJTHmYhP7zZDtoh+jMF103mnF/sGg6Q3na2NUTuU8n8PmgeK/E23EBsSEb6fuNBm0b+rTsTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrrDNm/2V0tW5QlIjIXItyWwN7HlHv0iTuTFgKmm9wTO6HUKY
	0x7NXuiq8njxPkDvsOzwf0iv+dVc+EgXlme9yMopkM1FnGZJ8Y4OayxSc3OE7tou134845IzTae
	qhxQZbxZJdrEDrys22ehsPEGG8fqlHEM=
X-Gm-Gg: AZuq6aJM7gDRz0VnhOEyMuzeOcpQtIaH5xSknI7wtuf/tceYa4u/aaKsotzaINKUVOr
	2Nm5y7JNU3X/aqZF5SvYtNRvn0UVJlAbkptu55XUKnFfbNw1pSeuoTyqNVKNgx5tcmzjRTQTpgN
	gnSYrPdKzwomJYF2AUP6PCRjkI6xjgsqxhgUOBZ4qjD5a01270DUaWJgGJz49e4144Y94q9Mbel
	o7JZfDkh22cwrnKPSTKDontIlqIafqDRwDuUZHa34Kk69m174Gmezc3U3E3CpqYZ7QjOlU0
X-Received: by 2002:a5d:64c9:0:b0:431:a43:ee88 with SMTP id
 ffacd0b85a97d-435f3aaf7cemr23688957f8f.42.1770120103900; Tue, 03 Feb 2026
 04:01:43 -0800 (PST)
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
Date: Tue, 3 Feb 2026 14:01:31 +0200
X-Gm-Features: AZwV_Qgr0pBQ1wVH0-u5VwU9YYr35W4aVL8W6PTRUnVQKr-nmLWu36hzeAruxuU
Message-ID: <CAPVz0n2i1r03R=yO4XnQpKFggixfcn_Ni4vGZrfDyEOTJHDi+w@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-41962-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 41002D8BD1
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

Noted

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

Noted. Thank you.

> thanks,
>
> greg k-h

