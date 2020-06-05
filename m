Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441211EFD1D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFEP7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 11:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgFEP7G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 11:59:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDFD206DC;
        Fri,  5 Jun 2020 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591372745;
        bh=+DeSwYrnPA6G0ugZwfX3ACwrq9yW7J/IId7P9pQilp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zQSiprL2cwbeT/YPWP/8YAd9Un60KPo0blinDMpaFBO7IGpqGCUZVBJqgyLIbL73g
         hHlJXxtqVpPH++fsYYcMHMJBGLSgdQdromJBHdD41GzKB1RJyx2D/pWBRgqo1bty3G
         Nl8EOuOWpYXEOq98dsXWf9vmNrAkfvnRe3iLETMU=
Date:   Fri, 5 Jun 2020 16:59:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] regulator: do not balance 'boot-on' coupled regulators
 without constraints
Message-ID: <20200605155903.GI5413@sirena.org.uk>
References: <CGME20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6@eucas1p2.samsung.com>
 <20200605063724.9030-1-m.szyprowski@samsung.com>
 <20200605102018.GA5413@sirena.org.uk>
 <2f0e021d-387a-4693-882d-aba66e20dd2b@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <2f0e021d-387a-4693-882d-aba66e20dd2b@samsung.com>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 03:37:32PM +0200, Marek Szyprowski wrote:
> On 05.06.2020 12:20, Mark Brown wrote:

> > No, this is not what boot-on means at all.  It is there for cases where
> > we can't read the enable status from the hardware.  Trying to infer
> > *anything* about the runtime behaviour from it being present or absent
> > is very badly broken.

> Okay, what about the 'always-on' property? I don't think that we need=20
> another property for annotating this behavior, as in my opinion this is=
=20

No, that's just as disconnected from the need - we may as well do it
based on the regulator name being an odd number of characters.

> just an implementation issue on the Linux kernel and regulator=20
> framework. Alternatively I can drop the property check, but then it=20
> won't be possible to have a regulator without a consumer, which follows=
=20
> the other one (although we still don't have a real use case for it).

> If you don't like this idea at all, I will try to move this logic to the=
=20
> custom coupler again, although it would mean some code copying.

I think that's better TBH.

> > Saravana (CCed) was working on some patches which tried to deal with
> > some stuff around this for enables using the sync_state() callback.
> > Unfortunately there's quite a few problems with the current approach
> > (the biggest one from my point of view being that it's implemented so
> > that it requires every single consumer of every device on the PMIC to
> > come up but there's others at more of an implementation level).

> I'm not sure if we really need such complex solution for this...

So I think that the specific approach there is overly heavyweight and
restrictive but I do see the general use case here for something per
regulator providing we can avoid breaking anything that does actually
need to change the regulator state (eg, raising the voltage for
cpufreq).  Previously to the past week I'd only really heard about it
causing problems in the context of displays left on by the bootloader
glitching during boot but this is a concrete use case and we already
have the infrastructure to track dependencies at the device model level
if we use it well. =20

OTOH if you have a coupler already that needs to be doing stuff all the
time at runtime it may be easier to just put this in the coupler,
especially I think in this case where the lack of the devfreq driver
wouldn't mean that the hardware being controlled wasn't being used at
all.  The coupler would end up backstopping a missing cpufreq or devfreq
driver.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aa8cACgkQJNaLcl1U
h9CF1Qf/eNmlSRJrp5ipDLEwz6mu9IGiA3HFJjyQeiDeTsAjHVWQ0OjybOTCX+Sj
ppAhpN58xLP3ZBL5XJc1VcuM2Aq8EMMmST7StSNewJX3ISdCOOfMdmBTqhiZ1cZR
cehYMgBwA2U02TNi6gXAd6HCGAIaSpDmnBVo3+4oNcnr/6O+RSzcJk+HUWAeRTyO
K+E9Vd6adqQkzislcP9fxuSoABOqOaad3xcoSSA++JKdJZcevIyhzB3fK51jwErr
UmCxXir40BdfF7CVAfqNT9ocwwGF8Q6RdLSy6Gf7fpZDwa8W1SIQSTSLPTDQFz7+
MZknGWhZ1tN1gmMvBn1DKMFi7RwlqQ==
=zvyi
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
