Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78F45EE9F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 14:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhKZNK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 08:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhKZNI0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Nov 2021 08:08:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4991D610A7;
        Fri, 26 Nov 2021 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637931914;
        bh=7kWyWOzNhvpzrbyXFw3NApkY4l5o3i0sxnomHklyFkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UqziiORfQ5oNDPEF5+/34wqiUp9Dn7l/0h8oEgqIpyhwqnyMzePlvT+LvV8FrtqpB
         7CE6konpS/+G2GKVaz2Gr2+meHnZmgunZfcj7FX5STy/wLF5hFNwvKiVlGDatJeWd5
         3uT+c9rkrGVZnbR3qFpy3rGOim+/K4EKCW1P9geg1L2XMnr1zXuM7gtHZg/briTrKi
         k46UFoiZ8kDPNWngXiqg2WPBsLAkuu80c/86IQIAsv9fZW6JHAu1lP/HD1vVHDeZt2
         J6idDo8+ddG8aGnL0oj3mOpHtgo0lCaif0qytQIXv0hvhgTEI3a4c974l92QkWnfJn
         CLjWx4CmTjS0A==
Date:   Fri, 26 Nov 2021 13:05:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v2] media: i2c: dw9714: add optional regulator support
Message-ID: <YaDbhSsh5vKBsZai@sirena.org.uk>
References: <20211126090107.1243558-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+3BsLA530vjlUXPc"
Content-Disposition: inline
In-Reply-To: <20211126090107.1243558-1-martin.kepplinger@puri.sm>
X-Cookie: You fill a much-needed gap.
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+3BsLA530vjlUXPc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 26, 2021 at 10:01:07AM +0100, Martin Kepplinger wrote:

> +	dw9714_dev->vcc = devm_regulator_get_optional(&client->dev, "vcc");
> +	if (IS_ERR(dw9714_dev->vcc)) {
> +		dev_dbg(&client->dev, "No vcc regulator found: %ld\n",
> +			PTR_ERR(dw9714_dev->vcc));
> +		dw9714_dev->vcc = NULL;
> +	}

To repeat my original feedback: unless the supply can be physically
absent you should use regulator_get().   The _optional variants are only
for cases where the supply might be physically absent.

--+3BsLA530vjlUXPc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGg24QACgkQJNaLcl1U
h9D7uAf/YWhxPh6vIyKOyKhroBRkkkeqy4vHZaGVEcwetiDdf/NkDXbVP6W4QskA
7GO7fD8SXgrZC6oWqGasy2gx7Qf5lqMFezcpxpzNOulrieEI9XLRKCVj4LRM8iSD
wLzC88AcEG5uqLt0g/Fi1Lz32VjFVNGA6yq3riz3srXdL+ZV5MOfnX4dDpcoHcuD
mDsM1tgkhWVG7tLffFk/s5+zr7ZP/szPJul6WRRnj+kcxO9EikkrlVAxKaOLGfgU
ov1X7FzX6V2iSltnz/g83W+tf/ZYnbw20zyPpi6eElTTDpVYHLZeli4IlnjjMbj/
em0ysfhJXTVdTJhY7qrq8rg/g2Rr7Q==
=IhNf
-----END PGP SIGNATURE-----

--+3BsLA530vjlUXPc--
