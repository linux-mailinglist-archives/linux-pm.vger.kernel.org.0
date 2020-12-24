Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682322E289D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgLXSqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 13:46:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48210 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLXSqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 13:46:55 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4F7971C0B96; Thu, 24 Dec 2020 19:46:12 +0100 (CET)
Date:   Thu, 24 Dec 2020 19:46:11 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
Message-ID: <20201224184610.GA22388@amd>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20201208164145.19493-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The density of components greatly increased the last decade bringing a
> numerous number of heating sources which are monitored by more than 20
> sensors on recent SoC. The skin temperature, which is the case
> temperature of the device, must stay below approximately 45=B0C in order
> to comply with the legal requirements.

What kind of device is that?

Does that mean that running fsck is now "illegal" because temperature
will not be managed during that time?
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/k4fIACgkQMOfwapXb+vK0pACdElRIhj2E7JSW/euwtaHk+y6G
MuYAn2zhuOJZFsAkWfeGv0uu00QcTRE5
=NqMu
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
