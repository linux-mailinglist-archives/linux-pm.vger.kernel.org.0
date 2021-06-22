Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B965F3B0627
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFVNtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:49:21 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39362 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 09:49:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E0B5B1C0B82; Tue, 22 Jun 2021 15:47:03 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:47:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     pingshuo <pingshuo@uniontech.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hibernation:stop resume screen during hibernation
Message-ID: <20210622134703.GA12358@duo.ucw.cz>
References: <20210622124547.28317-1-pingshuo@uniontech.com>
 <CAJZ5v0gnYHmbWANVkoG+6XrUNzBB4__uM0Ladrpn5=L0KEiefA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gnYHmbWANVkoG+6XrUNzBB4__uM0Ladrpn5=L0KEiefA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The display will be woken up during hibernation.
>=20
> That actually depends on its driver.
>=20
> > if the computer equipment is poor, it will cause the screen to flicker.
> > Skip to reusme the display devices in "thaw".
>=20
> But this patch looks like a proof of concept rather than a proper solutio=
n.
>=20
> This needs to be done more carefully.

And because it depends on the driver, I believe we should aim for
per-driver solutions.

BR,
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNHp1wAKCRAw5/Bqldv6
8mz/AJ9utON2IN5ytlKemVKyHq4yjctQGwCfX0A6IzLvvemqDK7/60INdhRZqfE=
=ny9s
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
