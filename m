Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49D32B34A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352517AbhCCDul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349854AbhCBRhJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Mar 2021 12:37:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C7364F32;
        Tue,  2 Mar 2021 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614705943;
        bh=wzxX6fB8ox2DNpZZ8LhGeG/FrKDK2EebFNNFbxqx7JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1Pf6H+SbYeaOIFSpQ3JOAeTr6Dw84eJClIrlFPmfVDOpTWYy0yEAZTcnzidNGC2l
         pGyIdR0imIsR7LHvGcERf65jjYy4s1cqkFR4kreAaK1YD807JajOAkxZYhQdSeTnyz
         ShYqvpjXxT+IP5QBlY4aw2tPgLkXjEFMxfscxvC7Uc+VvDfsTc2cmnQPZ75I5l7ceZ
         76EwYvMMbRScED51f1jE4G+Nmx5kO8uYzSv1xOz/NFwNlx29LnhicXpe9NaR/054Dp
         nNFA17Q9A3GqtYGb5vIBTk3+yojRm3iIqLchlTqApSnIBeIu5yghp8KzUNgflhe80o
         LQeQkz44p11Ew==
Received: by earth.universe (Postfix, from userid 1000)
        id A4ABB3C0C96; Tue,  2 Mar 2021 18:25:40 +0100 (CET)
Date:   Tue, 2 Mar 2021 18:25:40 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
 reset handling
Message-ID: <20210302172540.suq6m7cbulorp4at@earth.universe>
References: <20210205133319.1921108-1-geert+renesas@glider.be>
 <20210302154406.n4d6euiruwan4pm5@earth.universe>
 <CAMuHMdULLDcRFhOQrGXuRxTcMeX5bc3fi-CkSSmrejSP6JUKWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4kn6yoahxuaazce6"
Content-Disposition: inline
In-Reply-To: <CAMuHMdULLDcRFhOQrGXuRxTcMeX5bc3fi-CkSSmrejSP6JUKWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4kn6yoahxuaazce6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Mar 02, 2021 at 05:18:21PM +0100, Geert Uytterhoeven wrote:
> Hi Sebastian,
>=20
> On Tue, Mar 2, 2021 at 4:44 PM Sebastian Reichel <sre@kernel.org> wrote:
> > On Fri, Feb 05, 2021 at 02:33:19PM +0100, Geert Uytterhoeven wrote:
> > > Currently, there are two drivers binding to the R-Mobile System
> > > Controller (SYSC):
> > >   - The rmobile-sysc driver registers PM domains from a core_initcall=
(),
> > >     and does not use a platform driver,
> > >   - The rmobile-reset driver registers a reset handler, and does use a
> > >     platform driver.
> > >
> > > As fw_devlink only considers devices, it does not know that the
> > > rmobile-sysc driver is ready.  Hence if fw_devlink is enabled, probing
> > > of on-chip devices that are part of the SYSC PM domain is deferred un=
til
> > > the optional rmobile-reset has been bound, which may happen too late
> > > (for e.g. the system timer on SoCs lacking an ARM architectured or
> > > global timer), or not at all, leading to complete system boot failure=
s.
> > >
> > > Fix this by:
> > >   1. Setting the OF_POPULATED flag for the SYSC device node after
> > >      successful initialization.
> > >      This will make of_link_to_phandle() ignore the SYSC device node =
as
> > >      a dependency, making consumer devices probe again.
> > >   2. Move reset handling from its own driver into the rmobile-sysc
> > >      driver.
> > >      This is needed because setting OF_POPULATED prevents the
> > >      rmobile-reset driver from binding against the same device.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > To be queued in renesas-devel for v5.13.
> >
> > Acked-by: Sebastian Reichel <sre@kernel.org>
>=20
> In the meantime, this has method been abandoned, and this patch was
> superseded by "[PATCH v2] soc: renesas: rmobile-sysc: Mark fwnode when
> PM domain is added"
> https://lore.kernel.org/linux-arm-kernel/20210216123958.3180014-1-geert+r=
enesas@glider.be/

Ah I remember seeing that, wondering why I am being CC'd and
ignoring it :)

Thanks for the pointer,

-- Sebastian

--4kn6yoahxuaazce6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmA+dQcACgkQ2O7X88g7
+pqc/w//W5vDfGs22TY9mzvMDs2b5bphnJBFMWzL7KQhHEsNXGmHGPI+nYg6N+GE
gm5J0W0AwhVRmO1EY2Qcd+ls79eCnd2tVer7JWHwKXiGMpGq5qd8KjL8EilYluUG
62Rkc5mmECtq2qPqhqLblmdedJydoDbmENw3LlS6virxWx0MNSxe4ErF/BkNliqu
sNJ1Qi2VS8e5rBAZDEXeg/ihZGaf1kWH41gnags1R+0QY1buu/MZz7I4Y1gzO9P9
oLCKxkcppNqfWwYgmehExokEd+46fYclpQD3xeoG9kez80dnb2oiTh305ZmCMedv
XtjcDyNfC3X+QqA69lJtPttfzbzOGFY81bph3suQAwZaNCsdocLjSE9JrONMmJCB
y5g8iKBJbe0tzqo7t2V8ZeZyjGg7OyyxKInuiuhhPl3lrTfqtdVAGM3JorUJBU+R
FYeJ6fgicIuBwt3zXxTJAlzAG3pFm7GEkeB93+d1342Nex4Pbzgizf0EHrXJUl/7
b5O2O3/staEjsOKUMUDzNcvh1rkYKNSIQkMe/ohQB9JNOG8fSUXDDFPBFU0d9ap0
4Fd+/QKJbtXWITKvL36JmpAFsXDhmnax580sFAdpALzTLftenYOldFy1aT4fksCD
Nt9Wz0RQQy6u0t/XfjRJQGS5lZeIkVqOnfD0/WznHZeA2W66v8M=
=8pjj
-----END PGP SIGNATURE-----

--4kn6yoahxuaazce6--
