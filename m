Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC82E9F7B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 22:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbhADVZ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 16:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADVZ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 16:25:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0401216C4;
        Mon,  4 Jan 2021 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609795516;
        bh=ENuN3yW4AW1o6Z39AIixJU3HWpYwrvRogBcKSXsjZPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDb5rwA/zMWUNyO+pboCFAAgX12vqdTkFlumCsmAim1FSponJel41VPzIXa/pK4qs
         eNVFlZjx344b3sPtocDH5AOxyah5I0VS01awbekP+/VB52yzjraMLcDQU7wBFWTrlV
         8aZEJPUwsXeN8+Qc6HKZfP0gIkA58Q/tUBI2FwzeXp+dEB41iVjx28QGgwZamJVyNI
         zXqmzaP0rNOKaK0e42V3MgCR+kzV1gOlr4m/q321iXqgcF56IYLpTZWMJXfwrezhiT
         1mDDlfzfVbGkg3qxr1VfNIlQXcnAOmJV0rMWBu5BJ4wXO74mI18LOuit/7/35rodZY
         fQ/PfBzUCum1w==
Date:   Mon, 4 Jan 2021 21:24:49 +0000
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
Message-ID: <20210104212449.GJ5645@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
 <20210104181825.GB27043@kozik-lap>
 <20210104182734.GH5645@sirena.org.uk>
 <20210104183821.GA29033@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <20210104183821.GA29033@kozik-lap>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2021 at 07:38:21PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 04, 2021 at 06:27:34PM +0000, Mark Brown wrote:

> > We can indicate the presence of features without adding new compatible
> > strings, that's just encoding the way Linux currently divides things up
> > into the bindings.  For example having an extcon property seems like it
> > should be enough to figure out if we're using extcon.

> It won't be enough because MFD will create device for extcon and bind
> the driver. The same for the charger. We have a board where max8997 is
> used only as PMIC (providing regulators) without battery and USB
> connectivity.

I'm not sure I follow, sorry?  Either the core driver can parse the
bindings enough to know what children it has or (probably better) it can
instantiate the children unconditionally and then the function drivers
can figure out if they need to do anything.

> Another point, is that this reflects the real hardware. The same as we
> model entire SoC as multiple children of soc node (with their own
> properties), here we represent smaller chip which also has
> sub-components.

Components we're calling things like "extcon"...

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zh6AACgkQJNaLcl1U
h9D85Qf9HAkIDxqmUT3DuU1gC8iLvHOzcvGAFb/R2kAgDBX9QGM4PIo36fI1p7o2
xwEdAv60V7yNTtP6gpTMfRj+IAl+URIZys7CzALyL77mH7uCc1EZOJgMHEN8FMif
jngEiDVMzp816XxUJHO9SX9n4vTnWr/9D3j/qD/LdkA2wx98SqyOfUhCs4csGqns
QUkI2r52B5op3cpVNlxlqcaWBF8b+4dMSNhGoSTw7ZnDCjz3ZVrNalGcQ5DOIi2q
HbFlJkSA7jHdnrXf6HGfa3hAGRDNaQAg935Zzvc+PV8Sz5kaqxOYa1SoYASV1NZ4
nwhwhH1ADHFKfU9mTF33rkqAKR8QYQ==
=Xd45
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
