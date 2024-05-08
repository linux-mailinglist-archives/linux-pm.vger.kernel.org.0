Return-Path: <linux-pm+bounces-7659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E25528C00B6
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C911F27811
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352491272C4;
	Wed,  8 May 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="I7NodmaO"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9781272BB;
	Wed,  8 May 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181121; cv=none; b=Ip+HxRge5OA5VhlUjXeoO8BmAF5ftob9gSbghzqAgurOa8sZUCYGzY7RNicIBFEhyH2gk3kLmJiTZ5LmmLi4aT85hmXpyPlXUtOHXiAzQOO1imdo6s+SG1eD0xv7mNkx3NHIEencdD1gzrcdTw04XFdnO/0twifUWj4222ERsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181121; c=relaxed/simple;
	bh=vImjKnxy3rGl7yL+SZpgGb5cYxG4rbforMVAbq2Tycw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNcr/Vh+li4AUFElYptDNff20cqfgZu5BVdFjBAAO6RrFNfaQYaSQdlal51sF2Bhvk+ah03a1EJwlR9NI79MGTPD4iggWbnmezkMyZVqXOTLivpwykLYPVxp4dmwlIHTH/YiWcH/MtZ7tY5jrKyOeci4LvBWadXK6d8lpxRxCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=I7NodmaO; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 1194E62DD101;
	Wed, 08 May 2024 17:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715181114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofZfmqMlM4xbn52ILVyak4iroqJ+0SAVWwfqZlcKwnk=;
	b=I7NodmaOAQkn6AVVFRJ4kdKJTluqWE6jv5ayazlRD+UoCBQynPecfezN1420tkwlQ76U9n
	LxRyJVyTJxl+cNt21Iq/n2C5TLLg6ixqvwjKmgXOQrUcQQ1pyJWJKZ6AFcH44p1KtxrSiZ
	fJBeowGJXqv03XflmvnGfUXdM1o8i2Q=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 08 May 2024 17:11:42 +0200
Message-ID: <4916526.31r3eYUQgx@natalenko.name>
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4563618.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4563618.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 08 May 2024 17:11:42 +0200
Message-ID: <4916526.31r3eYUQgx@natalenko.name>
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
MIME-Version: 1.0

Hello.

On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:05, SEL=C4=8C Perry Yuan wrote:
> Hi all,
> The patchset series add core performance boost feature for AMD pstate
> driver including passisve ,guide and active mode support.
>=20
> User can change core frequency boost control with a new sysfs entry:
>=20
> "/sys/devices/system/cpu/amd_pstate/cpb_boost"
>=20
>=20
> 1) globally disable core boost:
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
>   0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
>   1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
>   2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
>   3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
>   4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
>=20
> 2) globally enable core boost:
> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
>    0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
>   1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
>   2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
>   3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
>   4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> The V9 patches add per CPU boost control, user can enable/disable CPUs bo=
ost
> as the below command tested on a laptop system.
> # before
>   CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>   0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
>   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
>   2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
>   3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> $ sudo rdmsr 0xc00102b3 -p 0
> 10a6
>=20
> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> # after
>   CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>     0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0000
>     1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0690
>     2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4541
>     3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> $ sudo rdmsr 0xc00102b3 -p 0
> 108a
>=20
>=20
> The patches have been tested with the AMD 7950X processor and many users
> would like to get core boost control enabled for power saving.
>=20
> Perry.
>=20
>=20
> Changes from v9:
>  * change per CPU boost sysfs file name to `boost` (Mario)
>  * rebased to latest linux-pm/bleeding-edge
>=20
> Changes from v8:
>  * pick RB flag for patch 4 (Mario)
>  * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
>  * merge patch 6 into patch 3 (Mario)
>  * add two patch for per CPU boost control patch 6 & 7(Mario)
>  * rebased to latest linux-pm/bleeding-edge
>=20
> Changes from v7:
>  * fix the mutext locking issue in the sysfs file update(Ray, Mario)
>  * pick ack flag from Ray
>  * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
>  * rerun the testing to check function works well
>  * rebased to linux-pm/bleeding-edge latest
>=20
> Changes from v6:
>  * reword patch 2 commit log (Gautham)
>  * update cover letter description(Gautham)
>  * rebase to kernel v6.9-rc5
>=20
> Changes from v4:
>  * drop the legacy boost remove patch, let us keep the legacy interface
>    in case some applications break.
>  * rebase to linux-pm/bleeding-edge branch
>  * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
>    Enhancements which has some intial work done there.
>=20
> Changes from v4:
>  * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>  * pick RB flag from Gautham R. Shenoy
>  * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
>  * rebase to latest linux-pm/bleeding-edge branch
>  * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enh=
ancements
>  * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
>=20
> Changes from v3:
>  * rebased to linux-pm/bleeding-edge v6.8
>  * rename global to amd_pstate_global_params(Oleksandr Natalenko)
>  * remove comments for boot_supported in amd_pstate.h
>  * fix the compiler warning for amd-pstate-ut.ko
>  * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>    error during testing
>  * fix the max frequency value to be KHz when cpb boost disabled(Gautham =
R. Shenoy)
>=20
> Changes from v2:
>  * move global struct to amd-pstate.h
>  * fix the amd-pstate-ut with new cpb control interface
>=20
> Changes from v1:
>  * drop suspend/resume fix patch 6/7 because of the fix should be in
>    another fix series instead of CPB feature
>  * move the set_boost remove patch to the last(Mario)
>  * Fix commit info with "Closes:" (Mario)
>  * simplified global.cpb_supported initialization(Mario)
>  * Add guide mode support for CPB control
>  * Fixed some Doc typos and add guide mode info to Doc as well.
>=20
> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.com/
>=20
> Perry Yuan (7):
>   cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>   cpufreq: amd-pstate: initialize new core precision boost state
>   cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>   cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
>     while cpb boost off
>   Documentation: cpufreq: amd-pstate: introduce the new cpu boost
>     control method
>   cpufreq: amd-pstate: introduce per CPU frequency boost control
>   Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
>     control method
>=20
>  Documentation/admin-guide/pm/amd-pstate.rst |  30 ++++
>  arch/x86/include/asm/msr-index.h            |   2 +
>  drivers/cpufreq/acpi-cpufreq.c              |   2 -
>  drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>  drivers/cpufreq/amd-pstate.c                | 189 ++++++++++++++++++--
>  include/linux/amd-pstate.h                  |  14 ++
>  6 files changed, 225 insertions(+), 14 deletions(-)

I've applied this series along with fixes and improvements [1], and I canno=
t get guided mode to work with my CPU any more.

The CPU is:

```
Vendor ID:                AuthenticAMD
  Model name:             AMD Ryzen 9 5950X 16-Core Processor
    CPU family:           25
    Model:                33
    Thread(s) per core:   2
    Core(s) per socket:   16
    Socket(s):            1
    Stepping:             2
```

I've got `amd_pstate=3Dguided` set in the kernel cmdline, but `amd-pstate-e=
pp` gets loaded anyway. When I try to set `guided` manually via `echo guide=
d | sudo tee /sys/devices/system/cpu/amd_pstate/status`, the status gets dr=
opped to `disable`, `tee` errors out with `-ENODEV`, and there's this in th=
e kernel log:

```
$ jctl -kb | grep sysfs: | cut -d ' ' -f 5-
kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpufre=
q/policy0/boost'
=E2=80=A6
kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpufre=
q/policy31/boost'
```

The following is applied on top of v6.9-rc7:

```
cpufreq: amd-pstate: automatically load pstate driver by default
cpufreq: amd-pstate: fix the highest frequency issue which limit performance
cpufreq: amd-pstate: implement heterogeneous core topology for highest perf=
ormance initialization
x86/cpufeatures: Add feature bits for AMD heterogeneous processor
cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
Documentation: PM: amd-pstate: add guide mode to the Operation mode
Documentation: PM: amd-pstate: add debugging section for driver loading fai=
lure
Documentation: PM: amd-pstate: introducing recommended reboot requirement d=
uring driver switch
cpufreq: amd-pstate: add debug message while CPPC is supported and disabled=
 by SBIOS
cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
cpufreq: amd-pstate: optimiza the initial frequency values verification
Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control me=
thod
cpufreq: amd-pstate: introduce per CPU frequency boost control
Documentation: cpufreq: amd-pstate: introduce the new cpu boost control met=
hod
cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb=
 boost off
cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
cpufreq: amd-pstate: initialize new core precision boost state
cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
cpufreq: amd-pstate: fix code format problems
cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_freq=
()
cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear=
}_freq
cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
```

Previously, with your submissions, it was possible to use `guided` mode wit=
h my Zen 3.

[1] https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.com/

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4563618.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY7li4ACgkQil/iNcg8
M0sK4A/8CBR0rRDUlLAqHe4vx/jwLb4E41lEzJ4J/lg1pINR/JNN5p2ZcBlCBeM9
mJkovc6jhQU8A/IYigK0blZ7OKoJkNl4AQMg8vDF+7lHQBOiRa4iZy4igntpli4G
puRMzn9wYNUri75zQPe1iubf0GRbX/2eAsnBkOMndr0iHGWBy+2H8LSh+/qJ2eLV
p6WFvNsUEbDc0VlNdTyY7HEHqltYgXIkVDGNxFdIeMPB0Zer0kTq0qeZFZoDs6Ao
k1mmzAAroPcDD2h+WmSTrUJoAPYSSFWi0hk5q3IKsfrP21t0UGz1nMQ78yAxOnaf
Lab1gKHIggoQGBH7OyR6/xFaM8SS5dbw25n4EU50w8vBpjL6I5il8cdWzx2TGMQk
5X1sGTFZ86OoJpvEbViaQ3eZxA9xhTZaOE52t5+bTtqAyV78SOYHSJwx5dOOZFJx
MJjV5NDUGnIFBMVfx5H/HpkWYQ/F2BNJRrvhpZ0aY7zVQ3WbJAlXAEO1722RFLqJ
Wr3bEiqKKkSHb+46QRzURciz8JgJpxjVXz8Ln0RdLJxKCiNTkLWAEDpAMlZyR9jn
l0ggZtI449rr4xSnaZ74M+kCQGWdw8m9cxJ8q/juE8528yDDbGEUjtrWQxJqCRhX
VDU0ZlxvIYCxC/+IKpSUC+fOMamd5kZl64OGAKQxroDkAEnYCWY=
=3nXF
-----END PGP SIGNATURE-----

--nextPart4563618.LvFx2qVVIh--




