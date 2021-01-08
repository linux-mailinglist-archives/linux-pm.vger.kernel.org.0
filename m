Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9322EF5A3
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbhAHQSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 11:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbhAHQSE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 11:18:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2A6D2333E;
        Fri,  8 Jan 2021 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610122643;
        bh=9fRyQu8uYFa7h3cUZz3MMpHk6GCetpc3R4IJdyxZytI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGlBTzuo4+3lbmj5uzGwUyA9RiJ+oXV7++NC+iKEtjOMkrO3J/xVM6cjBI1nghCFq
         sm+bhdfvyXiWq0jvyUsgOpqMDI/u5JByMoQcUh+TKwlc8CHbqfIQeiz49x7MHrP5uw
         xRxQZtyGo2behH4Z1kAeUjKBdIkRz1yw5Af0cyV0iTidmAMv3zsPXKJgOZlxkUlCbL
         KY1H+ng88THoLRia4zT9T17xJrpDjeqiZB8LGOXilPiZQaAyLoFX7D7XM7p5BAvSrs
         jNv7jgtsYd4m5O0t0Tc4YF1b+YzCOLBEq5ZFmAotzg5w8MZPutANKY61Mu3JxeKAMP
         iZBcr7nJL+9wg==
Date:   Fri, 8 Jan 2021 16:16:53 +0000
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
Message-ID: <20210108161653.GA4554@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
 <20210104181825.GB27043@kozik-lap>
 <20210104182734.GH5645@sirena.org.uk>
 <20210104183821.GA29033@kozik-lap>
 <20210104212449.GJ5645@sirena.org.uk>
 <20210105165529.GB20401@kozik-lap>
 <20210106145931.GE4752@sirena.org.uk>
 <20210108161635.1b9303c8.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20210108161635.1b9303c8.timon.baetz@protonmail.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2021 at 03:16:48PM +0000, Timon Baetz wrote:

> Muic needs a node to be used with extcon_get_edev_by_phandle().
> Charger needs a node to reference a regulator.

The pattern is to use the parent device's node.

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/4hXQACgkQJNaLcl1U
h9D1Kgf9FdFEaCB21a+mhIY1QWeD08qM2lyq1/GCIzsj4p/ssGdqVnpGAJhLWZqn
nf9Uvf3q/dHc8o07Wvwh9s0zWde4kF56AyBrBbUdBwVONek4vGgb7tTfMIyTbZUR
O/SW1Uj9CodqLzfJz/5Z+zhsa+HXi5Jeroi7oGHe57U+2SGv/gYIfx/aLBIMbz3s
85OyLGL2c41FOTtB4IZYAsdag/eDCAC9B0UfvP2vu3Winr9RHIQlAKs4KZ/wGnQ3
4JTI7pCAlao2ZIKUAuwNvGLAnCIxqNWAvTUfwc0SMGnZkYGpNWB59vhrEd35jiYN
uWvieVoEAZtYG/ygcGXyN/uIcN1w4Q==
=pp/6
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
