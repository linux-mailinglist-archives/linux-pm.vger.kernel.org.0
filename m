Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7D67973
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2019 11:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfGMJK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jul 2019 05:10:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48902 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMJK6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jul 2019 05:10:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 724B680556; Sat, 13 Jul 2019 11:10:44 +0200 (CEST)
Date:   Sat, 13 Jul 2019 11:10:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Get rid of unused flags
Message-ID: <20190713091054.GA19902@amd>
References: <cover.1562854650.git.amit.kucheria@linaro.org>
 <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-11 19:51:25, Amit Kucheria wrote:
> The network_latency and network_throughput flags for PM-QoS have not
> found much use in drivers or in userspace since they were introduced.
>=20
> Commit 4a733ef1bea7 ("mac80211: remove PM-QoS listener") removed the
> only user PM_QOS_NETWORK_LATENCY in the kernel a while ago and there
> don't seem to be any userspace tools using the character device files
> either.
>=20
> PM_QOS_MEMORY_BANDWIDTH was never even added to the trace events.
>=20
> Remove all the flags except cpu_dma_latency.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0poB4ACgkQMOfwapXb+vLG7wCgnztvYft+BcWanbamBuUSENlO
abMAoKnVi80Q5RSiavr2GBO/deSZEWRH
=RkWH
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
