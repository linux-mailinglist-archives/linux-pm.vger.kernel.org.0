Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7A34466A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 15:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCVOBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 10:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhCVOAh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 10:00:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83E5D6196C;
        Mon, 22 Mar 2021 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616421635;
        bh=gMbyLIsDgdrx2p+wsSzWRpnq2aTtrR6qI7dJYUusx5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kw8ylOp5OcG1vmTzkycRqwkjUu8cFq1IgXcOiISlCvxMCaXDtTWyUMz1EgTxI/dWp
         mVoOQUmD8163+D6D6ZfiTs+XUQu+sbmCEPxmDf7pNQSfvqUmZOpAkGMg4QCJPaoLWh
         z2BL3Lib8FrHdYhGUgwjGfoRlDH/fwjrmMSQBgTZXptSWKipjhk4jl+5iJ4idd53oW
         4wDMCv5OV4286PGQs3wt1nlIUMgkSyfOD413Myi7dwarE7dj1VuaiUHrhiLswappeD
         zmQuF+6RHXr/L8tv3DIng0eOgTgTn9+B1BZiLOpT/4Dm9JX1u3XLSdX3udJtGgXbGS
         CRQrn7aHERBBQ==
Received: by earth.universe (Postfix, from userid 1000)
        id B27383C0C96; Mon, 22 Mar 2021 15:00:33 +0100 (CET)
Date:   Mon, 22 Mar 2021 15:00:33 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Randy Dunlap <rdunlap@bombadil.infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: Fix a typo
Message-ID: <20210322140033.iqarbpbwsibmb25h@earth.universe>
References: <20210319055230.32220-1-unixbhaskar@gmail.com>
 <469f4918-bd2d-8586-accd-77eeaf6dcd68@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iecqdof7l5rn7ahq"
Content-Disposition: inline
In-Reply-To: <469f4918-bd2d-8586-accd-77eeaf6dcd68@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iecqdof7l5rn7ahq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 19, 2021 at 11:11:47AM -0700, Randy Dunlap wrote:
> On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:
>=20
> > s/systme/system/
> >=20
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>=20
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, queued.

-- Sebastian

> > ---
> > drivers/power/supply/charger-manager.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/sup=
ply/charger-manager.c
> > index 4dea8ecd70bc..45da870aecca 100644
> > --- a/drivers/power/supply/charger-manager.c
> > +++ b/drivers/power/supply/charger-manager.c
> > @@ -1604,7 +1604,7 @@ static int charger_manager_probe(struct platform_=
device *pdev)
> > 	mutex_unlock(&cm_list_mtx);
> >=20
> > 	/*
> > -	 * Charger-manager is capable of waking up the systme from sleep
> > +	 * Charger-manager is capable of waking up the system from sleep
> > 	 * when event is happened through cm_notify_event()
> > 	 */
> > 	device_init_wakeup(&pdev->dev, true);
> > --
> > 2.26.2
> >=20
> >=20

--iecqdof7l5rn7ahq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBYowEACgkQ2O7X88g7
+pr2ng/+PwNcOIxr/cG8gA27xJ/v/6NY3YHdp8hZYtIL0HOz5vpZkGuFw8ZUQL23
fPWelqgG6qNj17WVZoXzDi+J0JcYUZo/Fz31KX5fjvE97CRg2ACiJdd6XXH14B/w
5jgwPOz+hWCtSWC1d8RAWZoTaD7IEsosRo0ZtmJfxWsJQsKUttPO1JQHyW3HmdKD
36pivPoe36efaNLeGAw1gYZeufsXlVGWbeEYvnILUOIrxTJOSjNuar6drtbUVAxS
iwTVAafH2E5FCknr/1Gm9OXayTmwH+P7g/oKRrqlaDw+ekk2uyCrzjQs8RVd4kMb
D5/RKzFLXQXprfr1DuPkQ1R1Q22mra+/ox0b++m5JQXtZTAGxPuNvHeojDDRDTQ5
prkzbIm0EetFmBsYWvls/tjI/YMXr7k0tvkVkkm8ofd75wEz1sfI8hxlhHwu3ket
sAxF0S4N6+os1Z3Pl2+73mNdghHWseakSj7VCSDqu4pkeY/PCmtQVE1cZ6utiIqB
Sw5b6RBZQMQzbKQXjwYqBx+utCSv//u2Iso71kAuC3mY5p9k+1ApZpe9MtHJOp9t
xOOQVa6wVh874kF+7KepyZOZtGY1P3H40YiTBC+x8/dflyOBbs83U/hUeknXNNce
TVr5EOK+kXFw2rgetU5pU7WnMN7MoomTTIYNwPr6eOISUdeCV6Y=
=FlLL
-----END PGP SIGNATURE-----

--iecqdof7l5rn7ahq--
