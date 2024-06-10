Return-Path: <linux-pm+bounces-8884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8690242B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31B21F21B0E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02612F5BE;
	Mon, 10 Jun 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="a6VOxOiS"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC679823DF;
	Mon, 10 Jun 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030124; cv=none; b=gWzH+qkHW+m4zR8WN2vn53W71wUzFeYezgdLlCUEYBLq52dQJvCjOe9LiOYOKPeRZyEnkjuLyyGNJXizUCOa2EjnCjKdjezs6Ev8Wo/kdEftP+oAnT9gOxpUjTNrhKDfjD6zi39NaV6SRHUHGucPHfGcDD89D9uQfludgZKoCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030124; c=relaxed/simple;
	bh=91sBIoOFuPu9SFY+tLlcUuwCHDWSFm5niB4kvRVeoCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpiAJOyxhqINB9K9dCxlYUdqmUgWsAG8csDWS8qlu4YLiQkAxwXkXmCfOJy5QCIQvo1O4ZT+xP5kWe1A/GfsuF5t0BQXPEe9lV4ePuYQSyZF1tH22/Oay5Cb1WUgYNyQGJJnkDL5mQFZV+0ZJopmohJRzN6JNN6uVjzgL8ztur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=a6VOxOiS; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 4D1B9635B043;
	Mon, 10 Jun 2024 16:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1718029705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0SMNTkYAuc5O8ZdDG31qtzlnMEbWZ7EjPgqLUUlf1k=;
	b=a6VOxOiS62O9xhjfaIQGv9ESrXEmBAqJ2SObD/XeVfvJa62ZDU/hYV+pxYdW40hd4pH/sS
	TV1n8s1AmmRBPAdZ5gC7qGR3L/9uKSSh/ss3Ot8H9G3f8XubQ+5kkEkgUsd4c4ZgtCbOvB
	GmfwSOLHwdGH1NIN7hyNUy0F941/dto=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 sandipan.das@amd.com, linux-pm@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 0/6] Add per-core RAPL energy counter support for AMD CPUs
Date: Mon, 10 Jun 2024 16:28:11 +0200
Message-ID: <2733323.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12451447.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12451447.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Mon, 10 Jun 2024 16:28:11 +0200
Message-ID: <2733323.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 10. =C4=8Dervna 2024 12:07:45, SEL=C4=8C Dhananjay Ugw=
ekar wrote:
> Currently the energy-cores event in the power PMU aggregates energy
> consumption data at a package level. On the other hand the core energy
> RAPL counter in AMD CPUs has a core scope (which means the energy=20
> consumption is recorded separately for each core). Earlier efforts to add
> the core event in the power PMU had failed [1], due to the difference in=
=20
> the scope of these two events. Hence, there is a need for a new core scope
> PMU.
>=20
> This patchset adds a new "power_per_core" PMU alongside the existing
> "power" PMU, which will be responsible for collecting the new
> "energy-per-core" event.
>=20
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
>=20
> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa=20
> machine:
>=20
> $ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1
>=20
>  Performance counter stats for 'system wide':
>=20
> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>=20
> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@li=
nux.intel.com/
>=20
> This patchset applies cleanly on top of v6.10-rc3 as well as latest=20
> tip/master.
>=20
> Dhananjay Ugwekar (6):
>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
>   perf/x86/rapl: Rename rapl_pmu variables
>   perf/x86/rapl: Make rapl_model struct global
>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
>   perf/x86/rapl: Add wrapper for online/offline functions
>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>=20
>  arch/x86/events/rapl.c | 311 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 233 insertions(+), 78 deletions(-)
>=20
>=20

With my CPU:

  Model name:             AMD Ryzen 9 5950X 16-Core Processor

and this workload:

$ taskset -c 1 dd if=3D/dev/zero of=3D/dev/null

the following result is got:

$ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0              1               1,70 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C1              1               8,83 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C2              1               0,17 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C3              1               0,33 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C4              1               0,14 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C5              1               0,33 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C6              1               0,25 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C7              1               0,19 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C8              1               0,66 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C9              1               1,71 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C10             1               0,38 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C11             1               1,69 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C12             1               0,22 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C13             1               0,11 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C14             1               0,49 Joules power_per_core/energy-per=
=2Dcore/
S0-D0-C15             1               0,37 Joules power_per_core/energy-per=
=2Dcore/

       1,002409590 seconds time elapsed

If it is as expected, please add my:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12451447.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmZnDXsACgkQil/iNcg8
M0t6fQ/9Fdruv7/wOgfWfxsmq12Z1F7j5jUZ3jwi5SWc8eM7xrP9k0xHc9MUuiAz
Wa6Q+GHzOASCcjGfyHbfJMwUj9fjjbDClvtVM+IV+F3jM+HDqYJs3xfHLxZYi5Yq
aZb6R8fmXv+O43R3N/T/fRuAjWod/+1KYnvP0ktPD7GCw/5bSWelLdmYAeEOyF8+
wbOZY4Vpa4mMIB6aywrmtDLWBfb3b1x3bKTCZiIxxgnjf/Kn6JZUKm/cqdJ7j12d
ZBmgC8MQEtbd1gGX3yF53kCUOnMJ5Pl/oKNC8upLlej+ktwGzIEqWrV3MDAFChmK
q8OukQvozY3VZinqRDJ5xsB1o1sSyGmnaNiWUTXV3TXr8Is+urKeGG9Vrcr81KTe
QPDGesLe09hh/DH051o34XbOj1fA680DP21gVlC7jMyfanxPCvyCnnQ9O6pL81MK
H7aueueox41UXHoIFRIZ5znWwewei8ny+4gAPam5/XVVX4E2rnBjl88OHWgMUXvU
biSFXskJU58wakoFWQd9iaCriGy1Ke+vKadeO8DpM89hLQSA+y08J2YXbBmQa7dT
pg4aNkKOeWwsMgzzJ0SbBJdPy66mhMLshln45oqTFYFyLTEKF1rfsFWZrKKn7wsg
uhjXr+TwTTA8dqewzCYxFq9drb/6bO1Dmn8UJDjMFAGWcBlRgaI=
=SsIp
-----END PGP SIGNATURE-----

--nextPart12451447.O9o76ZdvQC--




