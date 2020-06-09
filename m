Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59B61F40EC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgFIQbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 12:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIQbR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jun 2020 12:31:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0FE20774;
        Tue,  9 Jun 2020 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591720277;
        bh=KGsTckml0xbEI9J0TlXRHHhvg6RDFGQ4i5mIyxkxaRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Vi1eeq41LwbYuDhmRV6SXYFOUt7Zcb/rvNpdZsjsEudsphM5ldCTWGm3IQU9UqSx
         C5gajI05pVV1hIBCo8l023M0xJyOo6ztJMiYOzgrT5Fh6nXoWLPzc0KM5s1YPXXQYY
         K1Eg7uaM9FrGJIOhe6EcDaLq09mbI+5+B5R9RiR4=
Date:   Tue, 9 Jun 2020 17:31:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: max77620: Convert to json-schema
Message-ID: <20200609163115.GL4583@sirena.org.uk>
References: <20200609162621.1769610-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AGBBLMjITsWHeOTZ"
Content-Disposition: inline
In-Reply-To: <20200609162621.1769610-1-thierry.reding@gmail.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AGBBLMjITsWHeOTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 06:26:21PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Convert the Maxim MAX77620 PMIC device tree bindings from free-form text
> format to json-schema.

Acked-by: Mark Brown <broonie@kernel.org>

--AGBBLMjITsWHeOTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fuVIACgkQJNaLcl1U
h9CftAf/U/sNqwgkbzXWIw+NaofN1U68XUh173YGDAYEDgYZrv+dd7iVw7bOXuPe
+j5x5gtNssHTKVU+W9umxb1yRMJ/AZCoAiCruVFWmgd+XXMatFG73X+DdPQZyR+9
kicOZlf+I95Gz31Ih5dyZ5waOgQMOf8NARAT/V7pwJsepGWRLercdCVePXDtFx6I
s4Fv8fXfMklu8VR4+DkcFzV78FCDDpRlcCwOQOlHdYKrzlhMETutMzQGwJg4eMYA
UXby6+vQPPC3fEkEk3o6EA9/YuI4CrpiWBfTAGnzg3uPZuz1zDcJ70hmscSkw54w
OL9VSs8BdDlIE2ucAFDsXWNxBI3ewg==
=yEfK
-----END PGP SIGNATURE-----

--AGBBLMjITsWHeOTZ--
