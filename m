Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A12409D20
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 21:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbhIMTcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhIMTcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 15:32:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BABFC061762
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 12:31:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a591700b001976d2db364so832807pji.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t8tfRr4pDfwNBQ7+2uutj5zJKW753YHlsVVOI6R4V1g=;
        b=SsiOFCJ61FtdyEwlHuuUPngVYXdsKbEzdCt0gPMgprmMChpMxdMnX02ut+TP+jS5wY
         jMF3dwWGOVCP+DRWrobbuKP5oamplIR5xnKsq4GAs1bZHSQn1SCTUGhsUlqSXuqU+qzG
         c1i/CiVL0T34mL+WEqkCKmAgiL17FLGPaBmunrrcqcoSSfrbATEIZzjqfAeYtiEKiuyy
         8Ycy3Ep3pkfNBZ3QG08EcilnQpmqjotvFGWcvrR3rjL8S3KYFwqGdVK878yfoRwo0lYa
         ELWeakQGKAVw29XZfobwozmMZBsZgACMCPc3lCLLQlpK1ITY1wH4ekjAFicLvfFbcUBm
         md4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8tfRr4pDfwNBQ7+2uutj5zJKW753YHlsVVOI6R4V1g=;
        b=l0N+Rkyi0l5bnVhxluKIqGYfgExlSyVatdkl8wilmRwUUrjDL3Il0xxSdXNwQ2B0P/
         oAbwXi44oyi08kpe/pkgD8eyFFyK3l1wCVljcuILvWJBncV/Bxj7CAAj8UxxIC1EdvB7
         /YW+CspkbzgHJaQQJ2VSin91JdIVXGBcxDVaM5Trqb9MYDTTwNCvlx4tvvsrwO5s8BKx
         +6IKrpwak+dtFQAs9ELq4jbIQh4HMuTiWGqE2YXf4RgauZWbkQCj+/tIMi+pzRDw8sbE
         N71tEgn2XJh/BPLahABXwwKyd0ZKtTiHX3ifa4yB4CzX4Y4N8VO3plnUgVk5pYHvBB2L
         Lyfg==
X-Gm-Message-State: AOAM5328awvdUUrAgTvLZZP6WZC2cxqADWGnNa5LiWSCzhoZRukS19Mw
        eYEqko3tqD8iisH83Dnj/B3asw==
X-Google-Smtp-Source: ABdhPJxuwSI85i/xe46Nka94nE+DuxtOTejLTQJx8lZFP9sntveoLX/giHUgMr8cZ4l4bQo/v65q3g==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr11767178plk.62.1631561465400;
        Mon, 13 Sep 2021 12:31:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7b92:14a1:4f7c:6560])
        by smtp.gmail.com with ESMTPSA id j17sm8126169pfn.148.2021.09.13.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:31:04 -0700 (PDT)
Date:   Mon, 13 Sep 2021 12:30:58 -0700
From:   Benson Leung <bleung@google.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YT+m8jr8Ehe3R55G@google.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EwOD/L4uVEvwhlPZ"
Content-Disposition: inline
In-Reply-To: <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--EwOD/L4uVEvwhlPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adam and Heikki,

On Mon, Sep 13, 2021 at 03:15:46PM +0000, Adam Thomson wrote:
> On 13 September 2021 14:30, Heikki Krogerus wrote:
> >
> > My plan is to register a separate power supply for each PDO. So for
> > every source PDO and every sink PDO a port has in its capabilities,
> > you'll have a separate power supply registered, and the same for the
> > partner when it's connected. With every connection there should always
> > be one active (online) source psy and active sink psy (if the port is
> > source, one of the port's source psys will be active and the partner
> > will have the active sink psy, or vise versa - depending on the role).
> >
> > Each PDO represents a "Power Supply" so to me that approach just
> > makes the most sense. It will require a bit of work in kernel, however
> > in user space it should mean that we only have a single new attribute
> > file for the power supplies named "pdo" that returns a single PDO.
> >
> > Let me know if you guys see any obvious problems with the idea.
> > Otherwise, that is how we really need to do this. That will make
> > things much more clear in user space. I have a feeling it will make
> > things easier in kernel as well in the long run.
> >
> > Adding Adam and Guenter. It would be good if you guys could comment
> > the idea as well.
>=20
> Hi Heikki,
>=20
> Thanks for CCing me. My two pence worth is that I always envisaged the PSY
> representation as being 1 PSY for 1 power source. I consider this in a
> similar manner to the Regulator framework, where 1 regulator can support =
a range
> of voltages and currents, but this is covered by 1 regulator instance as =
it's
> just a single output. For USB-PD we have a number of options for voltage/=
current
> combos, including PPS which is even lower granularity, but it's still onl=
y one
> port. I get the feeling that having PSY instances for each and every PDO =
might
> be a little confusing and these will never be concurrent.
>=20
> However, I'd be keen to understand further and see what restrictions/issu=
es are
> currently present as I probably don't have a complete view of this right =
now. I
> wouldn't want to dismiss something out of turn, especially when you obvio=
usly
> have good reason to suggest such an approach.

I thought of one more potential downside to one-psy-per-pdo:

Remember that a source or sink's Capabilities may dynamically change without
a port disconnect, and this could make one-psy-per-pdo much more chatty with
power supply deletions and re-registrations on load balancing events.

At basically any time, a power source may send a new SRC_CAP to the sink wh=
ich
adjusts, deletes, or adds to the list of PDOs, without the connection state
machine registering a disconnect.

In a real world case, I have a charger in my kitchen that has 2 USB-C ports
and supports a total of 30W output. When one device is plugged in:
5V 3A, 9V 3A, 15V 2A
However, when two devices are plugged in, each sees:
5V 3A

The load balancing event would result in two power supply deletions, whereas
if it were a single psy per power supply (incorporating the list of PDO cho=
ices)
it would just be a single PROP_CHANGED event.

It seems cleaner to me to have deletions and additions only possible when t=
he
thing is unplugged or plugged.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--EwOD/L4uVEvwhlPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYT+m8gAKCRBzbaomhzOw
wtH2APoDV1gSfN+pPGCY8Vu2eranOxsb9iPXHEdCwBTAw09zaQEAsWkCmW/nU+5k
DKM6H/4JTFwKE559RgzaBiVpAFgzaAo=
=etoe
-----END PGP SIGNATURE-----

--EwOD/L4uVEvwhlPZ--
