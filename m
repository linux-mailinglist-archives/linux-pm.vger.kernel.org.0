Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0482E9667
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 14:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhADNxE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 08:53:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbhADNxE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 08:53:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B481207B1;
        Mon,  4 Jan 2021 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609768343;
        bh=WGYF7SlhXlucOWrieoYG3cJVW6/AxFwCogu0WarBMJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/wYJk7SVuVVAtZC7qLGTgDaw11H1+rJfcvI8K7vJiAXWKIii/jsSsDFnpG/THXED
         IpCeA+ZxKspqCrCBdzoGyZKXECvByHrrnOnbjTdxwuNGh+uQtOgAUE9IbKj1CL0Jve
         /qo5lYEyKgBZIXIfacQtJHylkpBtSneFoFECP3NtfrbAD+0so+6R6GVw/KB652h0wy
         RJU+FfEbpKXFWhbUSKk+iaTM/OPqmQH5ku9uZ4XbM4OiCUXYqhpRpVsRfzNcv5nvqE
         VQvCb5PoQd6li7omJ45xXKfsFSGIq+fMLy55UWXTMteVy49YV7564ItNoSRTYuf3h4
         xDaZEOb3D0SHw==
Date:   Mon, 4 Jan 2021 13:51:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20210104135156.GB5645@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20201230205139.1812366-2-timon.baetz@protonmail.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 30, 2020 at 08:52:07PM +0000, Timon Baetz wrote:

> +- charger: Node for configuring the charger driver.
> +  Required properties:
> +  - compatible: "maxim,max8997-battery"
> +  Optional properties:
> +  - extcon: extcon specifier for charging events
> +  - charger-supply: regulator node for charging current
> +
> +- muic: Node used only by extcon consumers.
> +  Required properties:
> +  - compatible: "maxim,max8997-muic"

Why do these need to appear in the DT binding?  We know these features
are there simply from knowing this is a max8997.

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zHXsACgkQJNaLcl1U
h9Bpuwf+Lbwwbn3A88GywPIb5p6fVae+jvfJHuyrCmnosfLzRuc3P72FyihL2Ssk
d8+57ttupGJ+sZqgJK+Ih9Eu4mMrsJbScy4O5WyFQfGJ3PQPpWlsHIq8DEUDlEy/
Ltf5HzGezxfmsC2nhapHNzFE2cbnn+AKmeK+rN2DxeYvuHFlfXNEdWSdeNK/zDeF
aUNAik0aInnufO7MOE1cqfgWfFxEnin6wxCGKOu2aCdcdli9aE536mwYz9WZc34j
vNbTxOcLDqWo+dtNtp1aOuRqX3kMO+X1SCBEYPymOwwgqt5Yo9179LOZNvqMN2E9
E+FL/m5IwwLbH06CDjp/ZT+aoF4psw==
=tIIA
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
