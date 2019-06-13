Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECC743A1F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfFMPSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732155AbfFMNFd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jun 2019 09:05:33 -0400
Received: from earth.universe (dyndsl-095-033-011-189.ewe-ip-backbone.de [95.33.11.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C3B205ED;
        Thu, 13 Jun 2019 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560431132;
        bh=9nw7s7Y1QRBTXFeeD1F8tOL9Kaizm2l7e3Ph/Xz+h50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzRm/x10/pYWTJzw5naJiqba5efR9LYMIKMLRdFAtvkvh4JkXIQ56p6+ZjI0kXE0E
         4jpE1a6LzXszIazL6ARJUwzldZdqylsrebyOpqTNJ5qL7VHd/4wQCvVTMNCCqflaAB
         cl/R3NEOjn2v+4zgAZE6fn0tBF9DEiTradMT58MI=
Received: by earth.universe (Postfix, from userid 1000)
        id 0F2303C0C77; Thu, 13 Jun 2019 15:05:30 +0200 (CEST)
Date:   Thu, 13 Jun 2019 15:05:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v15 0/7] support ROHM BD70528 PMIC
Message-ID: <20190613130529.kgswgbuszb24itxz@earth.universe>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
 <20190611200043.eib3g3acc7ilawsx@earth.universe>
 <20190612060328.GQ4797@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z7gwwmvwfgzls6v6"
Content-Disposition: inline
In-Reply-To: <20190612060328.GQ4797@dell>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--z7gwwmvwfgzls6v6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2019 at 07:03:28AM +0100, Lee Jones wrote:
> On Tue, 11 Jun 2019, Sebastian Reichel wrote:
> > On Mon, Jun 03, 2019 at 10:23:37AM +0300, Matti Vaittinen wrote:
> > > Patch series introducing support for ROHM BD70528 PMIC
> > > [...]
> >=20
> > I think all patches have been reviewed by the respective subsystem
> > maintainers. Lee, can you provide an immutable branch with the MFD
> > patches (1, 2, 4)? Looks like the other patches only depend on those
> > and can go through their respective subsystems.
>=20
> Yes.  It's on my TODO list.

Thanks.

> Would you prefer this method over me just taking them all and sending
> out a PR?  The latter is my usual flow, but I'm happy with either.

Both methods are fine with me. I usually go with "my" method, since
that results in less shared commits. It simplifies potential
follow-up bug fixes, since there is only one tree to fix.

-- Sebastian

--z7gwwmvwfgzls6v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0CShYACgkQ2O7X88g7
+pr+dQ//UKZYRSKZHKIkw81U/LPaGmkXOWyyYGwVfxHDYeMyeHur/klljg+mU4bW
gMCGCns23SP/L4c9lOc3aY/Ovkjuq2gjonKtMFo66fY9slf6MdnC4L9FNXXUqsPK
oa8Fir0ful7FdJ4HxsxLqkiTT1wWDNRgchMI/iNEhcjMt14rlzwIM7wyktT8O/Zr
9Om2Cx282JEE5hGbl2D98VPrR67vqNRqOwIhZ+lQBNgXiOUgvlh2UDqpXziOjdwX
vxgmoxUB1v72itnyz0qf46L+ayqnPmBH6MSEdTYs5vYz4l64c4jIXoyyJ/pPr+ck
rb6eygO0LkADnW6zab11yWn1HH/CYJG1TUNMNOw8a4RFPpCyDW17U5ksICi55hhx
HrG1YXCPgpiGV2d0MawLwLhEbv3FXIYDPPt6xEne0FXUHg53apOQjmyPoGP404RN
M7jJJlpkGyHd5N2iskFU79NBES64aHkc/uvmEZw56xHUVg0SZ9e/V7zLKWwxMYeM
C0kaTjsN86xnoNwsMoVx94RiIjk38xDz1anaAafOtpkUxdFb2xL9qpGWiUlwZKVJ
ALa7k8jleI0Mzv/fOFHGBZzkGoPCdqURkANKyCLHBA8Pi++nGR4RHF2Om/goK/mb
pLme4LVfDKswR8HYUbrfCBLsG/uBNX1GfoEH9/CQ2gNKSphUZ90=
=ScGm
-----END PGP SIGNATURE-----

--z7gwwmvwfgzls6v6--
