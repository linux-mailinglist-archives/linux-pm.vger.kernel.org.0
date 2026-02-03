Return-Path: <linux-pm+bounces-41984-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEy4LWImgmnPPgMAu9opvQ
	(envelope-from <linux-pm+bounces-41984-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:46:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F266DC336
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 701FB3013886
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C53D3315;
	Tue,  3 Feb 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5mycXDb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB73242B8;
	Tue,  3 Feb 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137116; cv=none; b=uBGlNlSuhjhaGmfDLDCqu7VLZEqht+kSEIGUSUXKDWJNISbyKB2Z7tckxQRRIgebOWIfJ1NuNR8bMkaPgjgrsSZ3J2za/g4ajHqNoaTbtyxkGrMZA18Gy/wHaxzaTQ87TnUE2gOTGOsyYJsZEtOcAaV2IJ0JPQtHyNJ7RSplbVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137116; c=relaxed/simple;
	bh=VnrNcTHa5WlQcoAdSfcLdDsVJjnwZzPTrXpkqxBTaE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op+UWhDgx0Amp0Fmd88KQB6n56DCSLMVqFWEaIhslhsq+j2NSnE2zsiPjNCjyZjr//NkXIe2os+Lj3uG2di5T+mdBrySYKZYH7d1z3ocan5gLV5yWYLIecn1Zz92NspXgqcN9PGD2ol1Hsvw210ZXpqlz91NEm/MhSi9J3Fnl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5mycXDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2CEC116D0;
	Tue,  3 Feb 2026 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770137115;
	bh=VnrNcTHa5WlQcoAdSfcLdDsVJjnwZzPTrXpkqxBTaE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5mycXDbIHaY3QAsKg8u1y1CW89Hj/OBTaJdF7kop2yfLeuKZqzcKi6nOaj9u/9fn
	 7IFyYywm2JoAURYRiV6EQ8UcyrPcoLkJ0tVaQHN+MbTG5uxfVWTK3Hhq4MjBvGgoF+
	 aUHs0XFRxETfqt30rSVDCSxEo9CudEYIrgYxmcHk=
Date: Tue, 3 Feb 2026 17:45:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
Message-ID: <2026020314-humbling-mobility-c24a@gregkh>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh>
 <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh>
 <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41984-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,rere.qmqm.pl,agorria.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6F266DC336
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 06:28:11PM +0200, Svyatoslav Ryhel wrote:
> вт, 3 лют. 2026 р. о 14:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org> пише:
> >
> > On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> > > вт, 3 лют. 2026 р. о 13:41 Greg Kroah-Hartman <gregkh@linuxfoundation.org> пише:
> > > >
> > > > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > > > --- /dev/null
> > > > > +++ b/drivers/misc/asus-dockram.c
> > > > > @@ -0,0 +1,327 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * ASUS EC: DockRAM
> > > > > + */
> > > > > +
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/i2c.h>
> > > > > +#include <linux/mfd/asus-ec.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/mutex.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/string.h>
> > > > > +#include <linux/sysfs.h>
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/unaligned.h>
> > > > > +
> > > > > +struct dockram_ec_data {
> > > > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > > +};
> > > > > +
> > > > > +int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
> > > > > +{
> > > > > +     int rc;
> > > > > +
> > > > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > > > +     rc = i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_BUFSIZE, buf);
> > > > > +     if (rc < 0)
> > > > > +             return rc;
> > > > > +
> > > > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > > > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d\n",
> > > > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > > +             return -EPROTO;
> > > > > +     }
> > > > > +
> > > > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> > > >
> > > > No documentation for these new public symbols?
> > > >
> > >
> > > These functions are mainly used in communication between the dockram
> > > device, asus-ec and its subdevices. Export is used here because all
> > > mentioned devices can be built as modules. I can add descriptions of
> > > functions into header if needed, but they should never be used outside
> > > of dockram-EC complex. Same applies to 2 export functions in the EC
> > > MFD.
> >
> > Then you should properly document this :)
> >
> > > > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > > > > +static DEVICE_ATTR_RW(control_reg);
> > > >
> > > > You did not document your new sysfs files in Documentation/ABI/ which is
> > > > required.
> > > >
> > > > Also, why do you need a brand new user/kernel api at all?  Who is going
> > > > to use this and for what?
> > > >
> > >
> > > These api were used mainly for debugging/logging purposes and descend
> > > from original downstream EC driver. I can both add documentation into
> > > ABI or remove them if that is absolutely necessary.
> >
> > Debugging should not be in sysfs, please put this type of stuff into
> > debugfs instead if you really need it.
> >
> 
> There is no similar way to handle BIN_ATTR_RW in the debugfs (), may I
> preserve  dockram_read/write with __maybe_unused instead of removing
> them? I will add comment with explanation

debugfs allows you to do much much more than simple stuff like
BIN_ATTR_RW().  Go wild there, but don't put debugging stuff in sysfs,
that is NOT what it is there for at all, but rather, that is exactly
what debugfs is for.

thanks,

greg k-h

