Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18982D97A6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438494AbgLNLrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 06:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407656AbgLNLrI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Dec 2020 06:47:08 -0500
Date:   Mon, 14 Dec 2020 12:46:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607946387;
        bh=wyj3+V8/GidtOhBncWae6PlOpBcFpm/Iv+pC8sW/RkI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaXsLGisJuwfyFAbkFDHfoiHv9pUqw1vMP4oMOiUd/xDvJ2rLQ9sfORYj9oTYCBJj
         h8smgylxiSc3oR1S6CES3regeYUf+e2iVOXGiRs31qYSWQXCJAkZT+BALh8JgQv42N
         zn/nScC5Oc12sHSObgLjQvurD4H62sl9t7T1MJI//7mU1TjNXgTWaOw4KKy1THQERI
         sq7vNoHstJoNZZ/Z7hcWvVKHyOaNj+mppniF1RRFpFEkUDY01kddURJshR8PGqty4v
         b9AXmBOKIwnl0vl8HnOuET1dRiNF8nFNJSioZp+TLfbAh2v07CGuDeidwf6Sr8b5tL
         IqJtGa3TjBnpg==
From:   Sebastian Reichel <sre@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Michael Klein <michael@fossekall.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] power: reset: new driver regulator-poweroff
Message-ID: <20201214114625.xq55gkkmvdigese5@earth.universe>
References: <20201211151445.115943-1-michael@fossekall.de>
 <20201211151445.115943-2-michael@fossekall.de>
 <20201212234116.cddx5yur7ox7itxv@earth.universe>
 <20201214100204.ngkgfrghdp3ui3um@gilmour>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uy472czivduskjvu"
Content-Disposition: inline
In-Reply-To: <20201214100204.ngkgfrghdp3ui3um@gilmour>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uy472czivduskjvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Mon, Dec 14, 2020 at 11:02:04AM +0100, Maxime Ripard wrote:
> Hi Sebastian,
>=20
> On Sun, Dec 13, 2020 at 12:41:16AM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Fri, Dec 11, 2020 at 04:14:43PM +0100, Michael Klein wrote:
> > > This driver registers a pm_power_off function to turn off the board
> > > by force-disabling a devicetree-defined regulator.
> > >=20
> > > Signed-off-by: Michael Klein <michael@fossekall.de>
> > > ---
> >=20
> > Thanks, queued.
>=20
> Did you also merge the binding?

Yes.

-- Sebastian

--uy472czivduskjvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/XUIcACgkQ2O7X88g7
+pr0Fg/9FDDxDr8rhtSeHCAMSGYGI/0Z++QmPLDpGkvEW1wl3bN65PJs++gg4ys8
pEQ46pqhyeeNB1Ua/B/NNFoLrTxoJl/K2vym/9qNcINtkU2RqJBM1mdbyis6TBB1
HyH3T6DxAwWgLsavY3xyZE9YOSv727RYIlkMEHeELvoO6TRToiVmgd5vTqumsAds
EXCiV1uAXGuiujxVxyI9K6/mKK0FZ9ViWgzCRL8pHQIvUj9frndeJPvSnSZUH0Yk
UwaX2xbhaZmuRLzbVgV/f4VfdhzJgILzh3BgFdiO5zQByjfODBFT117X7CONVtqL
yngZDUOpMZufgLiGgot+WiMca4e8UY5FEPrwqZ/x7E6ByB5jtejJk8yLKRwwLssC
uk0MRKVB8Z/q7PioBnKFaJNgkoC1/HURgBHAL9BCxA3OWOSql075ByKfubv5KCgW
efmO5IM3LSidrU4xezqA0GkQF3J0tl0r0uk7cfrL2r+PgBjJyLdhoIyPhOXFw4ul
WW+amS5KZCSVby0wTQ2PBxYVQ+JAQSaOuW32DvFckPU7DK9UDB0Ti3EcxjyPUycT
KxlaFRgJ5ReuVpC+mpli2+LqxJfmSNoBeUihsegU2ijRcg1cbt49i2tCZ7LgdW0O
GUZcREN7C0nrb+UEn7SuNkCWJVi5HlpY8OWV2ZJalvZZkjx9oVk=
=9/Cy
-----END PGP SIGNATURE-----

--uy472czivduskjvu--
