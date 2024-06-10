Return-Path: <linux-pm+bounces-8899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8693190285D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18547287BBF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DF14F9F5;
	Mon, 10 Jun 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="HzBsRp0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67814EC43;
	Mon, 10 Jun 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042942; cv=none; b=mEFnB5DyLV5kh5hQ1za3Q+UmBTf24alUSlHkQCJB1vZk2AYslqklWe+sik+JhXH2RxlIdc2csbRdmyRWkHDvyY7PyI1Y6kjjAtokUlz/3lPee07BvveY8ZbMn3td2/MfSPzqLt33jc+xLS7wEORKi+UNc69R4JEVqH6mGcpt05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042942; c=relaxed/simple;
	bh=jIe9JeocBr7G6WT23O2lxLj34KMlvE4LnyGCyZrVp2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCVGMEnpRh/I2xhCAjyNGRAgbhktQ1ijUzN/wQCvl3pWXbMq8Ogv6+uAYuS8g2cprBKc8eHlo+sTDwoJ7944XMuA90+SQvIMJB6QpP3Jv2E+umSJY4C2nDk5KEZGzwCxEkwTdkw8EYMbUFzvIOjCEYMMnOUu4twgqQ0iNg1fV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=HzBsRp0p; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 2873F635B055;
	Mon, 10 Jun 2024 20:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1718042934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHBmuPzeQk6RrXH74wFJcj/vN52Uy+kCPKcbBOPsTrU=;
	b=HzBsRp0p2xJRqImMu3onkIhg6CjljW8VZToRrXgpaQXBLvbdPuvPGBWdZbTWmczSPegHfF
	BFEKKTFgQ2S5OC0aiWVpspiJKkRqCfqJMnKLnnASxjP8qCYhS9lZd3aOZE39Cl2ypmcQpW
	wn78Rz/9Z/WRzRfCADQXJuudsuSj7ak=
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
 sandipan.das@amd.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] Add per-core RAPL energy counter support for AMD CPUs
Date: Mon, 10 Jun 2024 20:08:43 +0200
Message-ID: <1887843.tdWV9SEqCh@natalenko.name>
In-Reply-To: <cfd0a622-89bc-4303-a972-4b5c8380eb76@amd.com>
References:
 <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
 <2733323.mvXUDI8C0e@natalenko.name>
 <cfd0a622-89bc-4303-a972-4b5c8380eb76@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2184984.irdbgypaU6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2184984.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Mon, 10 Jun 2024 20:08:43 +0200
Message-ID: <1887843.tdWV9SEqCh@natalenko.name>
In-Reply-To: <cfd0a622-89bc-4303-a972-4b5c8380eb76@amd.com>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 10. =C4=8Dervna 2024 17:17:42, SEL=C4=8C Dhananjay Ugw=
ekar wrote:
> Hello Oleksandr,
>=20
> On 6/10/2024 7:58 PM, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On pond=C4=9Bl=C3=AD 10. =C4=8Dervna 2024 12:07:45, SEL=C4=8C Dhananjay=
 Ugwekar wrote:
> >> Currently the energy-cores event in the power PMU aggregates energy
> >> consumption data at a package level. On the other hand the core energy
> >> RAPL counter in AMD CPUs has a core scope (which means the energy=20
> >> consumption is recorded separately for each core). Earlier efforts to =
add
> >> the core event in the power PMU had failed [1], due to the difference =
in=20
> >> the scope of these two events. Hence, there is a need for a new core s=
cope
> >> PMU.
> >>
> >> This patchset adds a new "power_per_core" PMU alongside the existing
> >> "power" PMU, which will be responsible for collecting the new
> >> "energy-per-core" event.
> >>
> >> Tested the package level and core level PMU counters with workloads
> >> pinned to different CPUs.
> >>
> >> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa=20
> >> machine:
> >>
> >> $ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> >> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> >> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
> >>
> >> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d=
@linux.intel.com/
> >>
> >> This patchset applies cleanly on top of v6.10-rc3 as well as latest=20
> >> tip/master.
> >>
> >> Dhananjay Ugwekar (6):
> >>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
> >>   perf/x86/rapl: Rename rapl_pmu variables
> >>   perf/x86/rapl: Make rapl_model struct global
> >>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
> >>   perf/x86/rapl: Add wrapper for online/offline functions
> >>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
> >>
> >>  arch/x86/events/rapl.c | 311 ++++++++++++++++++++++++++++++-----------
> >>  1 file changed, 233 insertions(+), 78 deletions(-)
> >>
> >>
> >=20
> > With my CPU:
> >=20
> >   Model name:             AMD Ryzen 9 5950X 16-Core Processor
> >=20
> > and this workload:
> >=20
> > $ taskset -c 1 dd if=3D/dev/zero of=3D/dev/null
> >=20
> > the following result is got:
> >=20
> > $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep=
 1
> >=20
> >  Performance counter stats for 'system wide':
> >=20
> > S0-D0-C0              1               1,70 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C1              1               8,83 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C2              1               0,17 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C3              1               0,33 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C4              1               0,14 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C5              1               0,33 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C6              1               0,25 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C7              1               0,19 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C8              1               0,66 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C9              1               1,71 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C10             1               0,38 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C11             1               1,69 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C12             1               0,22 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C13             1               0,11 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C14             1               0,49 Joules power_per_core/energy=
=2Dper-core/
> > S0-D0-C15             1               0,37 Joules power_per_core/energy=
=2Dper-core/
> >=20
> >        1,002409590 seconds time elapsed
> >=20
> > If it is as expected, please add my:
> >=20
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>=20
> We can see that after you affined the workload to cpu 1, energy=20
> consumption of core 1 is considerably higher than the other cores,=20
> which is as expected, will add your tested-by in next version.
>=20
> P.S: I'm assuming here that cpu 1 is part of core 1 in your system,=20
> please let me know if that assumption is wrong.

You assumption should be correct:

$ cat /sys/devices/system/cpu/cpu1/topology/core_id
1

> Thanks for testing the patch!
>=20
> Regards,
> Dhananjay
>=20
> >=20
> > Thank you.
> >=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2184984.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmZnQSsACgkQil/iNcg8
M0t+SQ//cFOUD42pQ87oXU+DNh8dOLRaZgt5OVPnx9wVRuH5xs6JMksQQ0cCl4Mn
sa2VdK5pMMUsd8e39+Sf3Y9qAi+y6hN9DJAy6D2PM3eIgVLrfyBx8cu8wwYPJYLj
5hM6EYFI9pntlnfj+solUrTdA5gfuAzzHpBmq1aRsRjVyCVEQwVKaArBrHXbHR+J
6mPxs2bcLoZGal+4rYNxUBwztUjJvJ4NLMaWumyZlRfBuXAwiUSPFRu8TaI2kxZN
lDWnzlViyx0qPh86cD/QaD7j85QaPOFNfeou7g1vUhJ34oywko5UfqNjW8AcgDxD
QQ3tTeja0+aQL1yLL1buOFL073fdtfICyjRhFsozEWDkvIBAel1P5LOFAPPfUHQD
X736qZG7BSvERo62nlZz59XMh9W/8gGSXA8fXEvusK2jx9hhqW8NC1QSBGOZgFp1
3vI/z/zPn3236s/oEd++tJa1drUBDPMc59zxIzU+CW8xGc22dyWe3bj7Rn0LZRBV
NPdRpgrJyv60rWj07w1NR9KTkSWYWR47xoNIv6JlN7bpaJSlo9hwhg0SVF4ihL/N
Z5rLGFmxqrpBHwMbehSQM1kr8faF8BvdLbskbqPFuhePnHPir8IjPpDA7+My5Sp6
hNjQ0nAYSpmMiEwI9Grre1uhInW+CpVnsuw5zTjC0uW2A4ebI0g=
=eAZx
-----END PGP SIGNATURE-----

--nextPart2184984.irdbgypaU6--




