Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F3C7CA7D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfGaRc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 13:32:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45086 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfGaRc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 13:32:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BCF558031F; Wed, 31 Jul 2019 19:32:14 +0200 (CEST)
Date:   Wed, 31 Jul 2019 19:32:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
Subject: Re: [RFC v4 0/8] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
Message-ID: <20190731173225.GB24222@amd>
References: <20190725070857.6639-1-parth@linux.ibm.com>
 <20190728133102.GD8718@xo-6d-61-c0.localdomain>
 <4fcd3488-6ba0-bc22-a08d-ceebbce1c120@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <4fcd3488-6ba0-bc22-a08d-ceebbce1c120@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Abstract
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> The modern servers allows multiple cores to run at range of frequencies
> >> higher than rated range of frequencies. But the power budget of the sy=
stem
> >> inhibits sustaining these higher frequencies for longer durations.
> >=20
> > Thermal budget?
>=20
> Right, it is a good point, and there can be possibility of Thermal thrott=
ling
> which is not covered here.
> But the thermal throttling is less often seen in the servers than the thr=
ottling
> due to the Power budget constraints. Also one can change the power cap wh=
ich leads
> to increase in the throttling and task packing can handle in such
> cases.

Ok. I thought you are doing this due to thermals. If I understand
things correctly, you can go over thermal limits for a few seconds
before the silicon heats up. What is the timescale for power budget?

> BTW, Task packing allows few more cores to remain idle for longer time, so
> shouldn't this decrease thermal throttles upto certain extent?

I guess so, yes.

> > >> These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchma=
rk
> >> which can create two kinds of tasks: CPU bound (High Utilization) and
> >> Jitters (Low Utilization). N in X-axis represents N-CPU bound and N-Ji=
tter
> >> tasks spawned.
> >=20
> > Ok, so you have description how it causes 13% improvements. Do you also=
 have metrics how
> > it harms performance.. how much delay is added to unimportant tasks etc=
=2E..?
> >=20
>=20
> Yes, if we try to pack the tasks despite of no frequency throttling, we s=
ee a regression
> around 5%. For instance, in the synthetic benchmark I used to show perfor=
mance benefit,
> for lower count of CPU intensive threads (N=3D2) there is -5% performance=
 drop.
>=20
> Talking about the delay added to an unimportant tasks, the result can be =
lower throughput
> or higher latency for such tasks.

Thanks. I believe it would be good to mention disadvantages in the
documentation, too.

Best regards,
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1B0KkACgkQMOfwapXb+vK/SQCdEakOOhPJoZSXw6d1ALOX3ZWx
knYAn2U5kHCHmxOCvozd/2HU6N2RxX4Z
=4uGg
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
