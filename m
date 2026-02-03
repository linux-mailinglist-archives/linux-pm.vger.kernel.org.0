Return-Path: <linux-pm+bounces-41961-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JNWHMHjgWmDLQMAu9opvQ
	(envelope-from <linux-pm+bounces-41961-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 13:02:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830FD8B74
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 13:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9EF30B881A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B833C53C;
	Tue,  3 Feb 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFsYpk5Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BA337B8F;
	Tue,  3 Feb 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120024; cv=none; b=ZP5EHdYoSh+HjJJJXbdqSHBGoF7ZDYTM/gb1xX0qsPx4LtnOe0uhJY5fSPBKhaZ27+LnAePbfICWm67/bKRmMqqRpcUsf2haZEh3kTuLmGPSlaPZUGdV/LGhKaOuRHZdzdDY2NIUUXzeYCg1uA4Am6g1LlWmAvWNU4CvakRVuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120024; c=relaxed/simple;
	bh=yCCU+DvWpf3LJfse1GGtLeSuFfLtuaZGyh1ZRLHPv6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD2Ms0wNVOBHxmujl/Pw4UNUglr8vfSvlhsC6DBtyKKRjVRfL9GBp7Tzfd1sfF+xr566jNtVvZkwKsVkrl7zoEhFD8ax72ldVZWqPSGfoKiXXhr2IDncjJscFZIZE84p1q8+3oGy7xvFHbT3LBuLQNsllfe+W+lzmsz//JDuia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFsYpk5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175B1C116D0;
	Tue,  3 Feb 2026 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770120023;
	bh=yCCU+DvWpf3LJfse1GGtLeSuFfLtuaZGyh1ZRLHPv6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFsYpk5YsCjQrxctryV88+vNiA78r+2EPOoK5PJ/byNU2kNxDd44uzJGjVP6LlJhY
	 ihl1qvC8kMjUs8c/ZrpwMw5p3gaZVcWAHkZr9TlLb92yaXa7OmIWxqqmoN+a2DUnME
	 BgQZYUb+vZCuvKQmSqrdfXV/ZcbS25Qf7loKbgyQ=
Date: Tue, 3 Feb 2026 13:00:20 +0100
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
Message-ID: <2026020346-ashamed-campfire-b483@gregkh>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh>
 <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41961-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,rere.qmqm.pl,agorria.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0830FD8B74
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> вт, 3 лют. 2026 р. о 13:41 Greg Kroah-Hartman <gregkh@linuxfoundation.org> пише:
> >
> > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > --- /dev/null
> > > +++ b/drivers/misc/asus-dockram.c
> > > @@ -0,0 +1,327 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * ASUS EC: DockRAM
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/mfd/asus-ec.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/sysfs.h>
> > > +#include <linux/types.h>
> > > +#include <linux/unaligned.h>
> > > +
> > > +struct dockram_ec_data {
> > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > +};
> > > +
> > > +int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
> > > +{
> > > +     int rc;
> > > +
> > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > +     rc = i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_BUFSIZE, buf);
> > > +     if (rc < 0)
> > > +             return rc;
> > > +
> > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d\n",
> > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > +             return -EPROTO;
> > > +     }
> > > +
> > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> >
> > No documentation for these new public symbols?
> >
> 
> These functions are mainly used in communication between the dockram
> device, asus-ec and its subdevices. Export is used here because all
> mentioned devices can be built as modules. I can add descriptions of
> functions into header if needed, but they should never be used outside
> of dockram-EC complex. Same applies to 2 export functions in the EC
> MFD.

Then you should properly document this :)

> > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > > +static DEVICE_ATTR_RW(control_reg);
> >
> > You did not document your new sysfs files in Documentation/ABI/ which is
> > required.
> >
> > Also, why do you need a brand new user/kernel api at all?  Who is going
> > to use this and for what?
> >
> 
> These api were used mainly for debugging/logging purposes and descend
> from original downstream EC driver. I can both add documentation into
> ABI or remove them if that is absolutely necessary.

Debugging should not be in sysfs, please put this type of stuff into
debugfs instead if you really need it.

thanks,

greg k-h

