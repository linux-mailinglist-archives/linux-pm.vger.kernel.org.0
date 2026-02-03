Return-Path: <linux-pm+bounces-41960-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ayvQBizigWnxLgMAu9opvQ
	(envelope-from <linux-pm+bounces-41960-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:55:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F42D8AAC
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C87D303EA85
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA233ADA7;
	Tue,  3 Feb 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCyAVNgX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2022339
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119713; cv=pass; b=T/clhC86tTxMU1wBfBVnhi9XrG5tk53EgfhE7ijrCv4aSBkCC+mUbKs4WK18ht2oPgciujV5yoFJvIahVq+bvd4T9lP4Kx9JITwR9PIQC+5kuqttns28Oh/Khpee4/2+lmKtcyQHAgRdI8TUmZo3UMHXg9gQKuZJ6qhzSWGsudE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119713; c=relaxed/simple;
	bh=9O0t3nOqWgtzHoOehLwVH3QJcXMOzB1ELLyYtURrIuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0mraj/csg5haJ8FsCaqgUAWzsxUbjzCUiUhyQFX4Wvq2730IE/k9AP/ZF5RjATuA7PCMtwQFR1ZGNBV2O4A/GYD00blmsi1HuWORbI7Oo08MzlHu0hg6k8bvkPMBAuvwoqIvBK8/y8k51ccXrmJF0T5K1dxeU0JX3/Mhzo7JrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCyAVNgX; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806bf03573so27219425e9.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 03:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770119710; cv=none;
        d=google.com; s=arc-20240605;
        b=XnTz5b20ZlnS6oqV+Avky74UpKuO4S1llxEsqajTiFtwhTD3+/JyNNT8N9I+NPSO5Y
         5rfacYAjIGV9tgAiI0xqMUjkyoB6W0PYFgpDP2rPZUjrr7nPrE8QlobuHaOh3aX1h8wQ
         6+SrnyHh8yEti5QT0x3GyjJa/vnt8zBuez/IP6TpKuDHPyzyW2WM5u0xdGCJFyFNNxKF
         v1wrJExEPJkKIqKJF8WuCpKESWBEBANQLDcdZ6WOlYrp77EcolibXikN/L0pCFf+sSKf
         +Z4IAu0VkfTuY5ZomxLApz8y7sA34T4Dd7WyoX8G1iyJKgzfRWOPqAnvDr0oi8Lg69jk
         q2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJ2rGVAn9aB3hsANmqfw/I2Kf6J6nYb+RtHOxOIJw0I=;
        fh=7k8iNbOUXtPjcJMc4RtkqvjKaznlEfiZ+XX2XNNaBqI=;
        b=cCSZ3yZuTKb4tzb4S+sn/MNVrsrP1irGt9JzUq9eVFZ/oAisrB6uIeO7XPRcgT3m+h
         e70mlH9OiDVokr5qLRlJ7Le1HwwyTt9AN7LW+mJDfkoH+WiuhRA+Phj++hxmyNU4U3oH
         5i5zZYoSW9BMDqGs5ADAiT3EktBPSwx19e6/It5gl9oRIvOIAkouJn0DgvZJWBn/jH3x
         IuFGoPAgHMrl+5fVnIaMO4PfiyXxmMO6QWPTOOt7tMNF+BqCOGdfz+/2OVle1q70oXQr
         KMLATL9ocp3aQJjJSbzMtJX3JtNlFEBBeO9d3LMmtkrG8eUk/10S14ee0d4UY56ouc/a
         HcJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770119710; x=1770724510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ2rGVAn9aB3hsANmqfw/I2Kf6J6nYb+RtHOxOIJw0I=;
        b=MCyAVNgXL7nwa1l+j+PMLHiJK29uguooa6k9wvZGwna76kxD/t0qVYQbK9Mll7WidJ
         ZPcRlwB6qJ8qw0nIQHtlSxKh2FzzMfTNsX+LvGUaOWIGBAxVBWTEeKuB3lAvoBtxcEC7
         qwkIdURKccIDoWNbXifcEuR9L77pRHmnA4agCs4bmBUlEqkcnMmpjlEaYmGKPOhUNdBZ
         T+nv5tjL29a3zsW8ET2PEe27hA4ZXUxNigCfpxlSEhqe/01xzLNogfLhPNAfr5bikbdx
         KMHwbD1++UT/r1DXuMag6MNtH1Qcy0jflsuN/SCFhAdfz6v4WD5GFsNI9GlXYTdDX3rh
         oFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119710; x=1770724510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJ2rGVAn9aB3hsANmqfw/I2Kf6J6nYb+RtHOxOIJw0I=;
        b=SozrGkPjXXhIA0d1LOxpj5SrEq4FVYMkGUXELfgZViAeUORideeFNquqM8udqwRgER
         pUf7Qsd/2CRwKzLxWlrTHRqVJmx6fOdNTiM30XDWeC9cKsRwRRagAtKhhXWrvKA35x5b
         7IJ8yy9ZlxS3MVcyOrgWW4IL+w8hyfQVnU5zY9+j3i7qbwv7td0La/yMcWgt1wcia426
         vwvlM5gEF0JR6okC5ti9J0OKU5exUIhhgCt4pD7cd1b34BWTXVcZSjHFqQmdJmhgZNkO
         4japqD7bl8Y/2rqtS8nDkN6QE2Y4k4nqmUExvREwLU3s8G1gNHhlrja/fjBf4bbxxVBL
         2MVw==
X-Forwarded-Encrypted: i=1; AJvYcCVf+WtM7bnGVmed/0PLodZ65jhGlV7ql/FDEkgQFW6SsXvUd7jDRtB63ltlpAMdIYpkyUkGVhrNsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+MQZoG7B/XwsP5ti0pHA+SuvGvTCsdU3AOa0k0Ba4iyDo0TX
	pgbm//CXA+QOCwo7raYQDbS39cmrmczt3qezNbBAlenEzj9CdqjkDJt0sMVDbjTA33KgcgRMQQY
	Cg5xRjIX8nOjgSXKdeLoI+h/Zgtzw03o=
X-Gm-Gg: AZuq6aI/rIXjXvIoM8KsBXfVeGmdf4jdnhLTxJRnCn7kOT9v1xLO+ek1fEZ8M7yS1HA
	LXkr/jhe3ynKklp3l7alkOV6xJDvIrtctVv1lvguXnuHeyFN0tX8Xi0Ewf0K8/3OvX+i2kJ/4+i
	xhfrb8MliAgbm+folMcX1QV9SgRTtY8jdJRBeizO1ahvKmnmxVmFSk+T+2a6WLPxmReKiGQnOln
	gkZqzYuRIOAvSf83SU4BzhxE2ibQHZi/dl40Drd37FyTjKIv1sQyllXf4KsdJXjxCBd6gal
X-Received: by 2002:a05:600c:34ce:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-482db491e61mr217693765e9.17.1770119709814; Tue, 03 Feb 2026
 03:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh>
In-Reply-To: <2026020350-unrevised-humming-7a42@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 13:54:58 +0200
X-Gm-Features: AZwV_Qgw0b1U_6kBWSx9OhS-IJWxhPVx8BmrGdD1Vb7TZ1z_SuHtAUlbzg5ifu4
Message-ID: <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41960-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 24F42D8AAC
X-Rspamd-Action: no action

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:41 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > --- /dev/null
> > +++ b/drivers/misc/asus-dockram.c
> > @@ -0,0 +1,327 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * ASUS EC: DockRAM
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/asus-ec.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > +
> > +struct dockram_ec_data {
> > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > +};
> > +
> > +int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
> > +{
> > +     int rc;
> > +
> > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > +     rc =3D i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_B=
UFSIZE, buf);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d=
\n",
> > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > +             return -EPROTO;
> > +     }
> > +
> > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(asus_dockram_read);
>
> No documentation for these new public symbols?
>

These functions are mainly used in communication between the dockram
device, asus-ec and its subdevices. Export is used here because all
mentioned devices can be built as modules. I can add descriptions of
functions into header if needed, but they should never be used outside
of dockram-EC complex. Same applies to 2 export functions in the EC
MFD.

>
> > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > +static DEVICE_ATTR_RW(control_reg);
>
> You did not document your new sysfs files in Documentation/ABI/ which is
> required.
>
> Also, why do you need a brand new user/kernel api at all?  Who is going
> to use this and for what?
>

These api were used mainly for debugging/logging purposes and descend
from original downstream EC driver. I can both add documentation into
ABI or remove them if that is absolutely necessary.

> thanks,
>
> greg k-h

