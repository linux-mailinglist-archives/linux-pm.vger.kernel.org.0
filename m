Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA040D3B7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 09:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhIPHYY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhIPHYX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 03:24:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E5C061766
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 00:23:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h3so5308750pgb.7
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9+JjymWywjibzYahIE08Q7Lk+YbzJ8GWAwAgGuQw44=;
        b=CAU4jQUppKg76S8sxSwN4FATl9tAoUi0pf7tVytHg2CWKGP6dmI4UmJ4aS6EeI3u4b
         H5+6lrvJ+E6PWvkj22Of5x3zQcPjQaxWGMUShPwQm4Nzak1xjQfDZ4AOASyHjSpwpaHU
         w8ZFS65wuMpJAqgLD3DS+RzAhWZvZ0N/wHT2VuvgUO2SrS55yuwsKGugQeUF6Ol2v2xM
         mzFZJOQI1XxmTDcinj85Qj+GooSieocbQvWUvaH5nT6AUoIFSI10E5Uz+lHug7yGybOf
         sullI8IOsVNPMSAWJIZToPeMcUz8ufMbAEQYiHJmBHGDHhNqP507mZ8X6rxecFZtHIhE
         HoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9+JjymWywjibzYahIE08Q7Lk+YbzJ8GWAwAgGuQw44=;
        b=3dVoi1+jYO3N0B6qviPJd+JTxRMfu/Zebj+R/vNzy+tt+tqC2rOrsoNqckImaWmV5c
         rjnq30vQMWo+CrMtLYmT1EebYhyTPVxT8mN4PebDua7e8ittC8bTaRg7RlrWrgpRXN7W
         7O4c2ulQtj1NO4xmacr3likVqYtOnvBkE0a8n4ot0JXUzIfgr07H1JJDGlsCfTQVjbHY
         5MpfjKcgRboNquvPJ3oaWM4eJPezbJt0pyYRmYzVu62UtlhqvZKMA8AWno92uSbtiRz6
         xWBj1bGNbtFNWSklLrvBcAjMViUT7ZA0UAajI9DkXXXaj4O8nAJ3rKEcNxuC1sstUgUV
         AKKA==
X-Gm-Message-State: AOAM530cJLyHDrSw1xG3/bwGHvbBFhkaitqc6TiH3SG0MdMpuptVcgXK
        +W6QKDPZNyaJqB5AbMdW5hPAsg==
X-Google-Smtp-Source: ABdhPJxrw/i8/N4QcV/OPohGevkmBciVqntAoM3lzV9qrc0fJyPndAZSM9qimFhphx8j3XIivyK8ew==
X-Received: by 2002:a65:6251:: with SMTP id q17mr3761839pgv.416.1631776982664;
        Thu, 16 Sep 2021 00:23:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ab:1cc3:dd84:94f3])
        by smtp.gmail.com with ESMTPSA id c15sm1102192pfn.105.2021.09.16.00.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 00:23:01 -0700 (PDT)
Date:   Thu, 16 Sep 2021 00:22:55 -0700
From:   Benson Leung <bleung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
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
Message-ID: <YULwz8NsoA3+vrhA@google.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xat0VWzVRBLGhR0l"
Content-Disposition: inline
In-Reply-To: <YUB16up3JDwi3HfI@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xat0VWzVRBLGhR0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Tue, Sep 14, 2021 at 01:14:02PM +0300, Heikki Krogerus wrote:
> Mon, Sep 13, 2021 at 03:15:46PM +0000, Adam Thomson kirjoitti:
> >=20
> > Hi Heikki,
> >=20
> > Thanks for CCing me. My two pence worth is that I always envisaged the =
PSY
> > representation as being 1 PSY for 1 power source. I consider this in a
> > similar manner to the Regulator framework, where 1 regulator can suppor=
t a range
> > of voltages and currents, but this is covered by 1 regulator instance a=
s it's
> > just a single output. For USB-PD we have a number of options for voltag=
e/current
> > combos, including PPS which is even lower granularity, but it's still o=
nly one
> > port. I get the feeling that having PSY instances for each and every PD=
O might
> > be a little confusing and these will never be concurrent.
> >=20
> > However, I'd be keen to understand further and see what restrictions/is=
sues are
> > currently present as I probably don't have a complete view of this righ=
t now. I
> > wouldn't want to dismiss something out of turn, especially when you obv=
iously
> > have good reason to suggest such an approach.
>=20
> I'm not proposing that we drop the port-psys. I'm sorry if I've been
> unclear about that. The port-psy we can not drop because of several
> reasons. For starters, we still can not assume that USB PD is always
> supported.
>=20
> What I'm trying to propose is that we take advantage of the
> power-supply framework by building a "dynamic" hierarchy of power
> supplies that supply each other in order to represent the actual
> situation as closely as possible. For example, a port-psy that is
> supplied by port-Fixed-sink-psy that is supplied by
> port-partner-Fixed-source (that is supplied by port-partner-psy).
> Something like that. The only "static" part in the hierarchy is the
> port-psy, as everything else about it can change, even without
> disconnection.
>=20
> So the port-psy always either supplies another psy or is supplied by
> another psy in this hierarchy, depending on the role of the port. But
> most importantly, the properties of the port-psy itself are _newer_
> adjustable - they are read-only. The psy that supplies the port-psy
> can be adjustable, if it's for example PPS, but not the port-psy
> itself.
>=20
> The problem with having only a single psy per port (and possibly
> partners) is that it does not work well enough when the capabilities
> change, and the capabilities can really change at any moment, we don't
> need to disconnect for that to happen - simply by plugging another
> device to another port can change the power budget for your port and
> change your capabilities. The biggest problem is when we loose the
> ability to adjust the values if we for example loose the PPS that we
> were using in the middle of operation. The single psy has to attempt
> to handle the situation by adjusting something like the ranges of the
> properties, because it can't change the actual property set itself.
> That is hacky, and to be honest, a little bit risky, because it leaves
> us at the mercy of programmers completely unnecessarily.
>=20
> With my proposal, if the capabilities change, it only means we rebuild
> the psy hierarchy, and that's it. Nothing else needs to be done in
> kernel, and all changes are super visible and clear in user space.
>=20

Thanks for providing the clarification. So you're proposing a port-psy and a
port-partner-psy that are connected to each other (one supplying the other).
If PD is not present, those two will exist per port and partner, and there
will be information about Type-C current (and possibly BC 1.2 and other
methods?)

Do you have an example hierarchy you could share that explains what it would
look like in /sys/class/power_supply with PD with Source Caps and Sink Caps=
 on
both sides?

I think this all makes sense if the connector class is a read interface
for this info. Have you considered how the type-c connector class and this =
pd
psy support will handle dynamic PDO changes for advertisement FROM the port=
s?

For example, let's say you wanted the kernel and user to manage two USB-C p=
orts
with higher power support (meaning, 5V, 9V, 15V, 20V capable), but then your
kernel and user needs to edit the Source Caps on the fly based on load
balancing.

If caps are represented as a group of psys together, how do you as a kernel
and user create an modify the set of Source_Caps you put out on a port?

Thanks,
Benson

> thanks,
>=20
> --=20
> heikki

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--xat0VWzVRBLGhR0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYULwzwAKCRBzbaomhzOw
wom1AQCNZ/hwtQBhee1O29UF9wqYqjzyNI6WzWJuXmz4sjeWhAEA74S5yLRF7Vq0
kvMtyRkRQ+IMZkUJK8w4DM9wIFGXvA4=
=qhlX
-----END PGP SIGNATURE-----

--xat0VWzVRBLGhR0l--
