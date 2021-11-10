Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85B44C31D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhKJOmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 09:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhKJOms (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 09:42:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1378B61106;
        Wed, 10 Nov 2021 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636555201;
        bh=xqZi6iTYc50vjoO0XtxsyimzxbnA+3z6Sn+/RRjZgtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXVWX7fuRz9fJ47j8xk7hCkr3Lt0XQmfYcrFDGwOaNHgVd1OrZS7Y51zxZeK6N6cQ
         mzcdnC/kngo0vr7stFva55y6D13ypLXGNr+vc7wG6zkAcyIApK5YI42TE74y1ALbWg
         92WS+Df4Z2/OuJ9kMdPshfQubomOWn+g+jLab5Ef/+jsxBdhwvMx+NsuUqXyJ2aQsS
         WCFR6OrsJ+l7TECGzjw2viaFBT4lcWKTev/AIhMb7kqOhqBD6bHJnGLSeUpxdgmDP5
         xpsyLPHjbrOnT+isXgBhRw/InkgCtvYXNwCWP3uccmRp3s4hygKYCRWy9SNnpwjcYj
         s8BMumMnSIeow==
Date:   Wed, 10 Nov 2021 14:39:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com, alistair23@gmail.com,
        andreas@kemnade.info, shawnguo@kernel.org
Subject: Re: [PATCH v15 4/8] regulator: sy7636a: Remove requirement on
 sy7636a mfd
Message-ID: <YYvZuo+VWhe23fgN@sirena.org.uk>
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-5-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSiTZPc7Z0AF7E/8"
Content-Disposition: inline
In-Reply-To: <20211110122948.188683-5-alistair@alistair23.me>
X-Cookie: You have junk mail.
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mSiTZPc7Z0AF7E/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 10, 2021 at 10:29:44PM +1000, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Acked-by: Mark Brown <broonie@kernel.org>

--mSiTZPc7Z0AF7E/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGL2boACgkQJNaLcl1U
h9Bx3gf/XHLIMEoOui17lfMQpG17TCnihVcc6BYCq5EZQlOOwi5yLEqwMqwFDKc2
TnbR6hpDO7wm7eUevhDb9E9FRY8vyGXoV/bZE07XaKlJh7C9h7qiJCzdXroJvZVl
ClLrBTcMBLKRJGVU4Ff8bvohEigK6iH8Oq2b5whh2mZfA9s8ne5A8K+7edsqwl/u
FWeYyAwXEYFhaRHJ6wkN5iFwX1XftgkTxUMS4jUBypFM68t9qtCrHNo6nNsArfPU
6gefYO8LS8FvnJtf84F+oWqiiPalOcGJGw30tYGoyjCJwKSn4ilS8Y5Fj+1MUI14
oUkyet/xZzRwfpGdbO1ZE8k3KHonyA==
=QAPF
-----END PGP SIGNATURE-----

--mSiTZPc7Z0AF7E/8--
