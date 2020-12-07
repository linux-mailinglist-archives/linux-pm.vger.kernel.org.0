Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D22D1216
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLGNau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgLGNau (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Dec 2020 08:30:50 -0500
Date:   Mon, 7 Dec 2020 13:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607347809;
        bh=k2URTkzxeMwoISkkN5bsau+WynBK8IIMYqLAxO5uPHo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkiSBGDGIUXUBAsl7n0jcDNZQKUWTkQvfstxJ+jZf/uj5r5ILwZ5MF/FZhSJGFVMR
         6hXL/BvhfSFTFphlMUf4b5JgAy/0+mNbxivH757hLWsEIztFfoev1iDE8d9NrvP1l8
         MPdInRyMdID5NYfRYnvLAjogzzhLcf4Ji95p0c005MTvM6/u8agd69ffHFeZC3icxn
         tq+4hjL/amgUD/5YJdBAvdiMZX6ovbb7Tbo6z5k3x57gaJX/XbggoCo6CZkvP1/MJ8
         BvgdWNbinjiVMeT9buffxbIfdPC1/e6fY+179RJPXvGhj7flpzLSu5/25eS6YN2Rrv
         jVhiefA4XYQVQ==
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/7] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20201207133003.GC5694@sirena.org.uk>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f001986493a51fe591cb09a544770651bf589d35.1607216141.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <f001986493a51fe591cb09a544770651bf589d35.1607216141.git.cristian.ciocaltea@gmail.com>
X-Cookie: Absinthe makes the tart grow fonder.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 06, 2020 at 03:27:04AM +0200, Cristian Ciocaltea wrote:

> +/*
> + * ATC2603C notes:
> + * - LDO8 is not documented in datasheet (v2.4), but supported
> + *   in the vendor's driver implementation (xapp-le-kernel).
> + * - LDO12 mentioned in datasheet is not programmable, hence not
> + *   handled in this driver.
> + */

No reason not to include LDO12 here, the framework supports fixed
regulators fine and the bindings should reflect the physical structure
of the hardware - if something is being supplied by LDO12 on the PMIC
then you'd expect the binding showing a connection from LDO12.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/OLloACgkQJNaLcl1U
h9DGdQf5AayPz6I++uKbGeHYLcff0IAmsUsjS4QBP72ZGYTA28F3UvsIbL1ACLco
prlBF8LC5X/qWiTRWfVd5yEs5/0kHS+L3lp/HXCw665aoJz13Q4jBO6seyWC76Bd
xNKlouA2lDrKUJ4f/Nxmi4q0F9m+b6h3AgT/kMtvrnLAp+s+3Y7WR6GGUnHBN6V+
lQT+OjUn9DE3rqjIzZVqB6MLxBSjX/Oy0mZKz1Xn5PS2C9PY2tHY8wx07ytPE3xA
zqNiMelOGIbE7mYKEB4Pl0b9qDXFe6OIkRgFTRdbpJyr6hiLC+XmhJojcDyUf7Zh
y6q5jlwVCos1QC1zB8M6z4fEUm57SA==
=yD4E
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
