Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3441FCC0
	for <lists+linux-pm@lfdr.de>; Sat,  2 Oct 2021 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhJBPhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Oct 2021 11:37:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhJBPgy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Oct 2021 11:36:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3C0661F43FC0
Received: by earth.universe (Postfix, from userid 1000)
        id F22923C0CA8; Sat,  2 Oct 2021 17:35:04 +0200 (CEST)
Date:   Sat, 2 Oct 2021 17:35:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Colin King <colin.king@canonical.com>,
        patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: wm831x_power: fix spelling mistake on
 function name
Message-ID: <20211002153504.244kdj7vkurcuzg7@earth.universe>
References: <20211001120449.17914-1-colin.king@canonical.com>
 <20211001132534.GJ9223@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjryjpadlfjb4xau"
Content-Disposition: inline
In-Reply-To: <20211001132534.GJ9223@ediswmail.ad.cirrus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pjryjpadlfjb4xau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 01, 2021 at 01:25:34PM +0000, Charles Keepax wrote:
> On Fri, Oct 01, 2021 at 01:04:49PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > There is a spelling mistake in the name wm831x_battey_apply_config,
> > fix it.
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks, queued.

-- Sebastian

--pjryjpadlfjb4xau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFYfCIACgkQ2O7X88g7
+pqFug//SCffn3nc+/n4Q7PPL99PrQXAlxTHIrSYatkXgJRSJIh831p3sYAxjbJz
ilOrw7mmX6DDJMr/7JtnBOaGaOk/iFIiqt7Oim26cgikiL4OUDuo8jpqIWe8Inr0
OefTzxlcjLadO6MnydBcmB3CGqTY8cLfvVXcEmFf3V2YY4d1fvttf7HGVi6N8mTJ
Kuv9bKGEy5NfLoZgwopolSeVu1g8AQM//GrqVysmX6Z2+C6df5b9ik1agyekBCJl
tOByOf7uigNP69KeeWHJliJyYrPsLHJRzj8OnS6wAaV6q0hc3p7EIc4YPhrBRQsD
XMCy4wkAbOTX7HQ58ADL+BZjsmziwioj2Ea1o1OdWd9hhFz4EpuQBtevT1VNZ2Oe
JHfm6H8b+V0JX6DAiV0M+Oa5ZjN0B4exnhKfnQQPeZt3pAsxJpi6GuDhHvsZiqAv
tYUcBNwLi3du3b3rKZAiqlKVO9zkVnTqAhRsHJWjvdJYgRkZRPRP2uiy62hxvZYf
Qc+qmcJICtoE1lQgpNpj0HGH6D+E6/wW/8Z+VnFQzB4FZ28rFTA9qmQ0Iyo4iCQP
Yo2j3FZpQi40h5q97ak1WGuqjALTpbqkoHVPN0u/VM4z7f/JfEiqj56I0xo6laOL
thf8NvK5ZRCm4RJAWOUViV1FbY5LRNIxkFP5gkaj/UK49Vq0Gic=
=O7Ze
-----END PGP SIGNATURE-----

--pjryjpadlfjb4xau--
