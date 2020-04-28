Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755CB1BCC6A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 21:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgD1Tb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 15:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgD1Tb1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 15:31:27 -0400
Received: from earth.universe (dyndsl-095-033-172-075.ewe-ip-backbone.de [95.33.172.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BFA21707;
        Tue, 28 Apr 2020 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588102286;
        bh=xj/V0eXDEGpxei/D4tRMMNGrhD6ZfmLPRgXfOZqZIGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/FoPomPbU1vPfODWtg6PZi8uOI/TJdHLpuHwDWL8wmZG/ki/i8heElf78GyUXuYr
         YDQTitPOORz1q5RWM34tPzESu94USs0MWCUDpKDC3h/f28pTs+3d17VchijSrYU8Fj
         cFHEBWN2uv4vgGyI/R/lZQt4GMyBAtBf8FBvn26Q=
Received: by earth.universe (Postfix, from userid 1000)
        id DDA173C08C6; Tue, 28 Apr 2020 21:31:24 +0200 (CEST)
Date:   Tue, 28 Apr 2020 21:31:24 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 04/17] power/reset: vexpress: Support building as a module
Message-ID: <20200428193124.xe53lgorhc6uyffv@earth.universe>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-5-robh@kernel.org>
 <CAK8P3a2BZLti5pLrru8s-45Yz54SA0JZbyjvYEstSDJZfnzEmA@mail.gmail.com>
 <CAL_Jsq+Hk_WuK=c+eHi1Kz3EPzm=zOw2ctETXEySPH1WgAGjug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ujoodgxix7zrbfc"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+Hk_WuK=c+eHi1Kz3EPzm=zOw2ctETXEySPH1WgAGjug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6ujoodgxix7zrbfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 20, 2020 at 12:23:13PM -0500, Rob Herring wrote:
> On Mon, Apr 20, 2020 at 10:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > Enable building the VExpress power-off/reset driver as a module.
> >
> > Your change allows loading and unloading the driver, but actually
> > unloading is a bug with the current implementation, as there is no
> > 'release' handler to undo the _vexpress_register_restart_handler()
> > function.
>=20
> And also to save and restore pm_power_off...

I'm fine with providing Acked-by for this for merging through a
different tree or taking it through my tree.

> > It should not be hard to add a release handler, or you could just
> > mark the function as non-unloadable by only having a module_init()
> > but no module_exit() function.
> >
> > I suppose if you do the latter, there should also be a suppress_bind_at=
trs
> > flag in the device_driver. This is a preexisting bug.
>=20
> I may just drop this patch. I wrote it and then realized I don't need
> it as PSCI can be used instead.

So is the driver useless on arm64 and depends can be reduced to
arm32?

-- Sebastian

--6ujoodgxix7zrbfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6ohIwACgkQ2O7X88g7
+ppDwRAAjzNQt+XW6UyQw1RRYM2D/aruiSteQDj9cf12K3voQf5RNkTLuRqVnJ07
Va8MWbiUbK95NMhhwkqIf8QZ3hpt3tTR5c0f8pLvBhbG7EJvhK8VVNqDmfFsjy4v
ahU0XxqIYt7pFxtsEo/WZ3o6L0maB15vdguIhKpEetmpd8hY9HJazdiiqrwu+dHX
J/bQpZ0ogKb6Nzckn9NZDOQGpAyi4qHkIjss7lvB6FCq/e2I4SIbxbhmE9UPhNcH
nJGSIbCTei/AhVDZApM4OBfcgg1QZQq4gffNPGXoA45hYNl/aCdLRNz+9syiSZhl
4vLICMyDPCCSFiud5CFnFeUXRcmc8Le/oAM+xVAY/O0loHmKZLELXkXR/NjrCyGn
ZKuQ70LBrMULyd/rqz+FhYKuObOTX1fZEaFW/NSSTMFpDHdpP1g6qmj92XCZK0V5
xpqZPyKjDvSRRfTFFVK9a8RhK34oV7WuL6HbSuo+2IktoavQjIQNKmem56qGUjrF
S+SR6r1majboQHs8NngZ7usn+u2oCLAst2LAsNUkz/Bi18JtjS8yqL9mRp8xYnDQ
BOL4zeUZMo/fBBksGeNwOYvf7bLKEneQ6kNhclGgqDc+81rbkv/YQYDW/wTXHw+a
yMPT/3lDRKcsUJoXQRgWWurcXn8WG6ii/qONJQMei2HQM9NtI/w=
=XM6R
-----END PGP SIGNATURE-----

--6ujoodgxix7zrbfc--
