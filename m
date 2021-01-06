Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC42EC006
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAFPAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 10:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAFPAk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Jan 2021 10:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F3092311B;
        Wed,  6 Jan 2021 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609945200;
        bh=Ujxg+0YYoFI8WvUgcbYeDyszhm5GGvsP5kBNDrttEm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eItwBxH/7Rl3eFXNVlqkYSiWt5yHJjAiI2z7nilX/on7EZhML6y6/h3uImpBDEw2x
         fnHj99bYw601Xgw97w8SuohFfEF1qFwvjmDvWCpERVkWYZpuHla2rggXRCHv0EnLy5
         4b9lGjj/ADITb2N474R9DPECO3CuBz3Bl6VtnDm4A8Jwz4xLdZeUjCoYQI6jEFbduC
         /+fclNi8qNSGc5vhx0OpTjiZlQQk9g3s1RkvEXJfxcWuTfQ7k2FrKdAEoD0BkxF3Fv
         j/oDsWp3ZEmSKhFI5Qd+eFw+zuqxqPfcb53qyeHLnWkgqvQW4zx+f6El/jRhwTiYnM
         eo/gQcWiedtDA==
Date:   Wed, 6 Jan 2021 14:59:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
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
Message-ID: <20210106145931.GE4752@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
 <20210104181825.GB27043@kozik-lap>
 <20210104182734.GH5645@sirena.org.uk>
 <20210104183821.GA29033@kozik-lap>
 <20210104212449.GJ5645@sirena.org.uk>
 <20210105165529.GB20401@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <20210105165529.GB20401@kozik-lap>
X-Cookie: Happy feast of the pig!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2021 at 05:55:29PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 04, 2021 at 09:24:49PM +0000, Mark Brown wrote:

> > I'm not sure I follow, sorry?  Either the core driver can parse the
> > bindings enough to know what children it has or (probably better) it can
> > instantiate the children unconditionally and then the function drivers
> > can figure out if they need to do anything.

> Currently the MFD parent/core driver will instantiate children
> unconditionally.  It would have to be adapted. With proposed bindings -
> nothing to change.  MFD core already does the thing.

We're not talking massive amounts of code here, but we are talking ABI
for a DT update.

> The point is that function drivers should not be even bound, should not
> start to probe. Otherwise if they probe and fail, they will pollute the
> dmesg/probe log with failure. With the failure coming from looking for
> missing of_node or any other condition from parent/core driver.

There will only be an error message if one is printed, if we can do a
definitive -ENODEV there should be no need to print an error.

> > > Another point, is that this reflects the real hardware. The same as we
> > > model entire SoC as multiple children of soc node (with their own
> > > properties), here we represent smaller chip which also has
> > > sub-components.

> > Components we're calling things like "extcon"...

> I am rather thinking about charger, but yes, extcon as well. Either you
> have USB socket (and want to use associated logic) or not.

Right, I'm just saying we don't need to add new device nodes reflecting
implementation details into the DT to do that.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/10FMACgkQJNaLcl1U
h9AKwAf7BqMZl8eI7FlLmnCtP1/zU+16wmpeCfQRZE9Fo8WGj+eF2U0pmb86KjEb
GgTkf9j0in+XnO2qzg6QpikLqcZjyk5HUx/0UJElo5iuS+nWpNqvLIQtoD6m+YFB
pGeYoYlw0s+7oTaiNFqt/8SeuQ0NFChOVQSxwew39wc16L0Ushv72bIqztZz4HHd
V9CHJKRG8J+5Ol5TlFb6FyobI4z5/tyWfX/LlGHedN3EsMbdn80SC2y2h6q5doZ+
U/TpBofzh5K/Hmu++4GZP20bOLSc18YhyfO8W/bJk//o8BXXWEfp57v/hlxSgHLb
sSxSZYSaINOsb7kUXaSjuwFrdlHuZg==
=MxWV
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
