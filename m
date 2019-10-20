Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97FEDE071
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 22:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJTUfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 16:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfJTUfT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 16:35:19 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A7121928;
        Sun, 20 Oct 2019 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571603718;
        bh=0BZCTVybFYdutIhAdoTAhNwvf9adyvA5o/4WyUSSLCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Es/t6OJrm5fYKS/AjdcXrChXRJd+I0JtwjaBfZmeJVWJtHkMJ2N4ZOL0ER263TBKh
         zblhD3wmlYg0lqLsB0KLTd/PU9Wpk5VRd7ezp4oJfBo4g9PJram7Wd1m4abQaVz41C
         OQMi3mGQIuHpsqQXCSUezP/bE8nrzKKLfcS3nWl0=
Received: by earth.universe (Postfix, from userid 1000)
        id 70EB63C0CA0; Sun, 20 Oct 2019 22:35:16 +0200 (CEST)
Date:   Sun, 20 Oct 2019 22:35:16 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCHv2] power: supply: cpcap-charger: Limit voltage to 4.2V
 for battery
Message-ID: <20191020203516.sp2vafrvb2pi3hp6@earth.universe>
References: <20191016221817.8501-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3thxzith3uiedyki"
Content-Disposition: inline
In-Reply-To: <20191016221817.8501-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3thxzith3uiedyki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Wed, Oct 16, 2019 at 03:18:17PM -0700, Tony Lindgren wrote:
> There have been some cases of droid4 battery bulging that seem to be
> related to being left connected to the charger for several weeks.
>=20
> It is suspected that the 4.35V charge voltage configured for the battery
> is too much in the long run, so lets limit the charge voltage to 4.2V.
> It could also be that the batteries are just getting old.
>=20
> We don't really want to just change the charge voltage to 4.2V as Android
> may have charged the battery to 4.35V as pointed out by Pavel Machek.
>=20
> To add checks for battery voltage, the driver needs to understand the
> voltage it's charging at, and also needs to better understand it's
> charger state. Right now it only understands connect and disconnect,
> while now we need to know also a connected state but not charging.
>=20
> So let's add better charger state handling with help of chrgcurr2 interru=
pt
> for detecting charge full and retry, and add a check for battery voltage
> before we start charging. And then we finally can lower the charge voltage
> to 4.2V.
>=20
> Note that we've been using the same register values as the Android distros
> on droid4, so it is suspected that the same problem also exists in Androi=
d.
>=20
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reported-by: Merlijn Wajer <merlijn@wizzup.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>=20
> If this looks OK, I would appreciate an immutable branch against v5.4-rc1
> with just this patch in it for merge conflicts with v5.5 dts changes.

Thanks, I queued this to power-supply's for-next branch using the following
signed immutable branch:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
tag/?h=3Dpsy-cpcap-charge-volt-limit-signed

-- Sebastian

--3thxzith3uiedyki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sxQQACgkQ2O7X88g7
+ppfug/+OwZrst7R7Pe1ieMe0cpXbAWsTLzZJhIOWOQQ6ow8ppg0m6HaEIOFT+9y
NzE0OBG0FrLRCHa00bMDt+zUllueb9HRNxeEBeIGU3bahJz+CVmZ1n8WKYjHFwIw
ZGE+5fM+ouGGsM4j+1m+Ls/BCYlzMDV7OCcxZW/In3SYpP5LbWZevAzaQ4B7Ahvb
c3lNftMELx6ngiHJ0CSJ+lBhTNTxdpIlHn04yYtuPMLLogycHa4ldMZk/VlzKZF5
KoEDDP5lEhVIOBCRMidcbyY+Va7wT6zZtpzV0YahvW65GFNkhYAAH6mL2nI4HxAH
TvE7AjVq34amkS6WG45sgJYVELVUV5fDLrUpKtgU4bR+ixUYvDwicHV4yqkL+LQI
Hsku/sz4EBDJY6CMUXtgzSHkyQncI76/G+bXBlBHMLNIImE2rFJ4tsNsR7REbTc9
fyrwNWfiYV8+HbqSKpurQteHH6vee5jFjqzOFHIxRbNOsrM4omCzPN13Gq+alooa
ryjWgdUAoryzGxEYrzI2yT9Wy8BxlcNGTa3nW/tFehwMN60C9briGEFu8y35dgPx
gSCPL2Zdngz6fwRWtLrMm9xJTmHhxDcjMJwt8pfvQex6iwtT8kDMQQna0m+QEObX
edmwk+LsXCb9MqAyY+2v6mQPKDf4PauFmLVwoC1ND4PsZF3eJZs=
=bf+f
-----END PGP SIGNATURE-----

--3thxzith3uiedyki--
