Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE916275F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgBRNt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 08:49:29 -0500
Received: from foss.arm.com ([217.140.110.172]:52634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNt3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 08:49:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9FD1FB;
        Tue, 18 Feb 2020 05:49:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D34A53F6CF;
        Tue, 18 Feb 2020 05:49:27 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:49:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Message-ID: <20200218134926.GH4232@sirena.org.uk>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
 <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
 <20200211190614.GP4543@sirena.org.uk>
 <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
 <20200214114749.GB4827@sirena.org.uk>
 <375c7756fca56de4f2f85d1a1a4e0b01dadc290b.camel@fi.rohmeurope.com>
 <208a81c87e944c69d95da85d7fd0f3ea2bd61547.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline
In-Reply-To: <208a81c87e944c69d95da85d7fd0f3ea2bd61547.camel@fi.rohmeurope.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 07:23:38AM +0000, Vaittinen, Matti wrote:

> By the way - do you have some nice test cases for regulators hidden
> somewhere? If so, do you think you could share them? I sure have some
> for BD718x7 but they are somewhat clumsy and require special HW. (I've
> never liked unit-tests but I must admit there are some specific cases
> where they would be pretty usable).

You can't really run tests on actual regulator drivers outside of test
rigs as they're kind of important to the system they're running in.

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5L62UACgkQJNaLcl1U
h9AmpQf/Sh9P3ryrmoMBEQp3tnpxxMRxZYKeqQpaMK347KrY7FF8v38AFpSwNIJJ
3fFTu3vXfSNgpf5io3pmWhwQt7P0qV6sHiAGp/HcWgbSTaWsS+WUawffc4Ktz2LY
lQWg8mxosy7Ip/BKBB+h925C5id0M6afqZlgUg5ACzCYCRpGk+HPN1zb0gSeU5Oh
qni/LyBFo+6ugvCuEspGStlDIIHOSD+eyUk+as8Hct1Ou/WQdqpCZH7ghhBwfbN+
IpLj7p+k6VCa2RXgrd/mdmHZQWE1x3r3JnUkpCdBCF94SXHC54khG3Syiznad9XQ
UyxcwiQxUuv+DD9zP0ly2VKl6BcErg==
=1sE4
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
