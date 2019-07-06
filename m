Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77495612EE
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfGFUag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 16:30:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47804 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfGFUag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 16:30:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D7FB180476; Sat,  6 Jul 2019 22:30:21 +0200 (CEST)
Date:   Sat, 6 Jul 2019 22:30:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
        mka@chromium.org, ulf.hansson@linaro.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
Message-ID: <20190706203032.GA26828@amd>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
> to happen for you.
>=20
> I would try
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=3Df012a132824fc870b90980540f727c76fc72e244
>=20
> to narrow down the scope somewhat.

Bisect says:

572542c81dec533b7dd3778ea9f5949a00595f68 is the first bad commit
Author: Viresh Kumar <viresh.kumar@linaro.org>

    cpufreq: Register notifiers with the PM QoS framework

    This registers the notifiers for min/max frequency constraints
    with the

 Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
 Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
 Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Unfortunately, it does not revert cleanly:

pavel@duo:/data/l/linux-next-32$ git show
572542c81dec533b7dd3778ea9f5949a00595f68 | patch -REsp1
6 out of 11 hunks FAILED -- saving rejects to file
drivers/cpufreq/cpufreq.c.rej


pavel@duo:/data/l/linux-next-32$  git bisect log
# bad: [1e2a4c9019eb53f62790fadf86c14a54f4cf4888] Merge branch
'pm-cpufreq-new' into linux-next
# good: [f012a132824fc870b90980540f727c76fc72e244] Merge branches
'acpica', 'acpi-osl', 'acpi-tables', 'acpi-misc' and 'acpi-tools' into
linux-next
git bisect start '1e2a4c9019eb53f62790fadf86c14a54f4cf4888'
'f012a132824fc870b90980540f727c76fc72e244'
# good: [48a8a5f9a326d1c1a5505d51fb98086e5003f37e] Add linux-next
specific files for 20190701
git bisect good 48a8a5f9a326d1c1a5505d51fb98086e5003f37e
# good: [96021e491dbf30bd1c5c1a753992838c8d8d00cb] Merge branches
'acpi-apei', 'acpi-doc', 'acpi-soc' and 'acpi-pmic' into linux-next
git bisect good 96021e491dbf30bd1c5c1a753992838c8d8d00cb
# bad: [141467868c1f7bf1c4e8394a39d47d4db38cd2f1] cpufreq:
intel_pstate: Reuse refresh_frequency_limits()
git bisect bad 141467868c1f7bf1c4e8394a39d47d4db38cd2f1
# good: [2a79ea5ec53973c8711b54d33ace5c77659dc8f8] PM / QOS: Pass
request type to dev_pm_qos_read_value()
git bisect good 2a79ea5ec53973c8711b54d33ace5c77659dc8f8
# bad: [572542c81dec533b7dd3778ea9f5949a00595f68] cpufreq: Register
notifiers with the PM QoS framework
git bisect bad 572542c81dec533b7dd3778ea9f5949a00595f68
# good: [208637b37824c8956fe28d277835a403ee35fa84] PM / QoS: Add
support for MIN/MAX frequency constraints
git bisect good 208637b37824c8956fe28d277835a403ee35fa84
# first bad commit: [572542c81dec533b7dd3778ea9f5949a00595f68]
cpufreq: Register notifiers with the PM QoS framework

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0hBOgACgkQMOfwapXb+vK1xQCeK5YNPvOJMTUEZAlO3pq6sQi/
VeAAn2eTZuWwiYd17VkY2A0aOxlpZH/p
=rJBJ
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
