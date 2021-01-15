Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23A2F7CF1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbhAONn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 08:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbhAONn3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 08:43:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F012323382;
        Fri, 15 Jan 2021 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610718168;
        bh=wj532yWZYS0o7o1BgNfV+51J3eKIr9MV1erMfuZz0p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jm29pmQliCc9q4xjZOk6DNrUSC1j4Vg2Km3WXfK1DOkoUQmqnBDtYqR3JrwYM3ejI
         S1pWT7iYPCFQ9dYxAyyhTDbu9JTiGDP/HTlMB2MDsE3u1QsQu0bPI7vZHcuiiby7BZ
         56+pHP7UxebAnn/csIRf/tQpt07CVsJosMTMIYliqymj1cqUxQ4cBMaDz1UijDG1RU
         nsUw0XUi94oKfkRnMtH7aSfmgYIMMu+R1gdhouIzxJblZg3mRoe19DTwwLcaR7qAmF
         2qRma9rsMyQx1sUmM3ugPlJVZQEOMM7hV94Jr0Al9wtkG43n9RDAfTlvLk13W+D7vD
         DJAw5aoPkbjdw==
Date:   Fri, 15 Jan 2021 13:42:14 +0000
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
Message-ID: <20210115134213.GB4384@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20210104181825.GB27043@kozik-lap>
 <20210104182734.GH5645@sirena.org.uk>
 <20210104183821.GA29033@kozik-lap>
 <20210104212449.GJ5645@sirena.org.uk>
 <20210105165529.GB20401@kozik-lap>
 <20210106145931.GE4752@sirena.org.uk>
 <20210108161635.1b9303c8.timon.baetz@protonmail.com>
 <20210108161653.GA4554@sirena.org.uk>
 <20210115071914.0407a928.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20210115071914.0407a928.timon.baetz@protonmail.com>
X-Cookie: Debug is human, de-fix divine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 06:19:28AM +0000, Timon Baetz wrote:
> On Fri, 8 Jan 2021 16:16:53 +0000, Mark Brown wrote:
> > On Fri, Jan 08, 2021 at 03:16:48PM +0000, Timon Baetz wrote:

> > > Muic needs a node to be used with extcon_get_edev_by_phandle().
> > > Charger needs a node to reference a regulator. =20

> > The pattern is to use the parent device's node.

> So is extcon going to be a self-reference then?

I guess, assuming you even need to look this up via the device tree.

> Just for my understanding: I can see sub-nodes for MFD all over the
> place. It is still not clear to me why sub-nodes aren't the right
> choice in this specific case?

They probably aren't the right choice for a lot of the other usages
either, there's a great tendency to just encode the specific way that
Linux currently handles things into the DT without really thinking about
what it means.

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmABm7UACgkQJNaLcl1U
h9B6Cwf/Qf3U0S1f0c2IO8s9Lt5WSXX9YyodDDALaTx2Q+FDh7p0U8w7R+T8cu5B
7qxuRPJt1cKrg6+px0vePMoPP1ls8i/GxpmvFq4CQ2SHToa2xQXSVc7Y8xscAMCU
fej+U7snogytrmfmOcfavNlujd4DWbomXyRKz58AKcG7x/LNVLNw8PN+5sOrmf0T
OxHD/4HsqYl3R6aC1U6e7bl9jXXXnDcMIStad0+BYLxqi4pWStCCpaeIZFX9wl9D
8vijp8OPSb5lrqnUjJfifjBIrcJfKaHaBcVtjZKS8ys0J3wuRL5kZOonxVOuJVfq
MfWB+HNd05Rq3eluZuyzJy2X4Gp9hw==
=8nOi
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
