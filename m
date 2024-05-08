Return-Path: <linux-pm+bounces-7673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07DA8C04D8
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DA1282C0D
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDC130A4D;
	Wed,  8 May 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="ouDlQhBi"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94341E507;
	Wed,  8 May 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196118; cv=none; b=jEl8qPvfG5utNqaaAR/sP/KT+QqPNN00k9fIVQF0ubbSY26wsFdkI0Q4WqRM6KLT8uAOjU+Vf6ze9gO4gtpzcHiJMKjgikxmmICB8JJaL6C/QYSIhUtthKEZb4AugHDBPWIp1/tu4efLJHJHJ8+uZJc4YTCpesU2+i7WxfLwP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196118; c=relaxed/simple;
	bh=l0iCh2D9m1zDZoOjgAn7im/lvZClHoGOJnpz/LTpnNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skM4GelB77gMy1I2/FcvmmrDqzHXFoUtgMF/wIdqTpT9anO02fxhq0yYG6unnpikKC5XZoG/D5hZS5mNcGdtSdluar3ao9F8eSzvvWUoyx0+tXjfd9OSYjakVZfC7m8FUCReu5JYWE93uUOoUt52ZV6gFcJqL/TW74x2lGc7+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=ouDlQhBi; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 4C72D6356CD3;
	Wed, 08 May 2024 21:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715196113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LybpwXf3J6sYKHqeDA3soDFI2KOJDAOdiTLAE/GPAKA=;
	b=ouDlQhBiMIO4XHvyQxES/dSx7JIfYgCDzStT2tPOKWpdUS7UfPUZd4gK7QB+I/EEDWPPDo
	NRq7CfShyj6O2TTuaAUHwrLYxtqcU6N2owxoafZrb2ZOCKrOIK4rEoPCvnU+F2S0ExgiQC
	TVwNzBRlhQumD65Zb/IEqdSeDvhBJA8=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 08 May 2024 21:21:39 +0200
Message-ID: <2728768.mvXUDI8C0e@natalenko.name>
In-Reply-To: <6041368.lOV4Wx5bFT@natalenko.name>
References:
 <cover.1715152592.git.perry.yuan@amd.com> <4916526.31r3eYUQgx@natalenko.name>
 <6041368.lOV4Wx5bFT@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12430864.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12430864.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 08 May 2024 21:21:39 +0200
Message-ID: <2728768.mvXUDI8C0e@natalenko.name>
In-Reply-To: <6041368.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0

On st=C5=99eda 8. kv=C4=9Btna 2024 21:13:40, SEL=C4=8C Oleksandr Natalenko =
wrote:
> On st=C5=99eda 8. kv=C4=9Btna 2024 17:11:42, SEL=C4=8C Oleksandr Natalenk=
o wrote:
> > Hello.
> >=20
> > On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:05, SEL=C4=8C Perry Yuan wrote:
> > > Hi all,
> > > The patchset series add core performance boost feature for AMD pstate
> > > driver including passisve ,guide and active mode support.
> > >=20
> > > User can change core frequency boost control with a new sysfs entry:
> > >=20
> > > "/sys/devices/system/cpu/amd_pstate/cpb_boost"
> > >=20
> > >=20
> > > 1) globally disable core boost:
> > > $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> > > $ lscpu -ae
> > > CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
> > >   0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
> > >   1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
> > >   2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
> > >   3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
> > >   4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
> > >=20
> > > 2) globally enable core boost:
> > > $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> > > $ lscpu -ae
> > >    0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
> > >   1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
> > >   2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
> > >   3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
> > >   4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
> > >=20
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > The V9 patches add per CPU boost control, user can enable/disable CPU=
s boost
> > > as the below command tested on a laptop system.
> > > # before
> > >   CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       =
MHZ
> > >   0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
> > >   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
> > >   2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
> > >   3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> > > $ sudo rdmsr 0xc00102b3 -p 0
> > > 10a6
> > >=20
> > > $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> > > # after
> > >   CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       =
MHZ
> > >     0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0=
000
> > >     1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0=
690
> > >     2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4=
541
> > >     3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0=
000
> > > $ sudo rdmsr 0xc00102b3 -p 0
> > > 108a
> > >=20
> > >=20
> > > The patches have been tested with the AMD 7950X processor and many us=
ers
> > > would like to get core boost control enabled for power saving.
> > >=20
> > > Perry.
> > >=20
> > >=20
> > > Changes from v9:
> > >  * change per CPU boost sysfs file name to `boost` (Mario)
> > >  * rebased to latest linux-pm/bleeding-edge
> > >=20
> > > Changes from v8:
> > >  * pick RB flag for patch 4 (Mario)
> > >  * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
> > >  * merge patch 6 into patch 3 (Mario)
> > >  * add two patch for per CPU boost control patch 6 & 7(Mario)
> > >  * rebased to latest linux-pm/bleeding-edge
> > >=20
> > > Changes from v7:
> > >  * fix the mutext locking issue in the sysfs file update(Ray, Mario)
> > >  * pick ack flag from Ray
> > >  * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
> > >  * rerun the testing to check function works well
> > >  * rebased to linux-pm/bleeding-edge latest
> > >=20
> > > Changes from v6:
> > >  * reword patch 2 commit log (Gautham)
> > >  * update cover letter description(Gautham)
> > >  * rebase to kernel v6.9-rc5
> > >=20
> > > Changes from v4:
> > >  * drop the legacy boost remove patch, let us keep the legacy interfa=
ce
> > >    in case some applications break.
> > >  * rebase to linux-pm/bleeding-edge branch
> > >  * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
> > >    Enhancements which has some intial work done there.
> > >=20
> > > Changes from v4:
> > >  * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> > >  * pick RB flag from Gautham R. Shenoy
> > >  * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
> > >  * rebase to latest linux-pm/bleeding-edge branch
> > >  * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And=
 Enhancements
> > >  * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
> > >=20
> > > Changes from v3:
> > >  * rebased to linux-pm/bleeding-edge v6.8
> > >  * rename global to amd_pstate_global_params(Oleksandr Natalenko)
> > >  * remove comments for boot_supported in amd_pstate.h
> > >  * fix the compiler warning for amd-pstate-ut.ko
> > >  * use for_each_online_cpu in cpb_boost_store which fix the null poin=
ter
> > >    error during testing
> > >  * fix the max frequency value to be KHz when cpb boost disabled(Gaut=
ham R. Shenoy)
> > >=20
> > > Changes from v2:
> > >  * move global struct to amd-pstate.h
> > >  * fix the amd-pstate-ut with new cpb control interface
> > >=20
> > > Changes from v1:
> > >  * drop suspend/resume fix patch 6/7 because of the fix should be in
> > >    another fix series instead of CPB feature
> > >  * move the set_boost remove patch to the last(Mario)
> > >  * Fix commit info with "Closes:" (Mario)
> > >  * simplified global.cpb_supported initialization(Mario)
> > >  * Add guide mode support for CPB control
> > >  * Fixed some Doc typos and add guide mode info to Doc as well.
> > >=20
> > > v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.c=
om/
> > > v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.=
com/
> > > v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.=
com/
> > > v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.=
com/
> > > v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.=
com/
> > > v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.=
com/
> > > v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.=
com/
> > > v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.=
com/
> > > v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.=
com/
> > >=20
> > > Perry Yuan (7):
> > >   cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> > >   cpufreq: amd-pstate: initialize new core precision boost state
> > >   cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost cont=
rol
> > >   cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
> > >     while cpb boost off
> > >   Documentation: cpufreq: amd-pstate: introduce the new cpu boost
> > >     control method
> > >   cpufreq: amd-pstate: introduce per CPU frequency boost control
> > >   Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
> > >     control method
> > >=20
> > >  Documentation/admin-guide/pm/amd-pstate.rst |  30 ++++
> > >  arch/x86/include/asm/msr-index.h            |   2 +
> > >  drivers/cpufreq/acpi-cpufreq.c              |   2 -
> > >  drivers/cpufreq/amd-pstate-ut.c             |   2 +-
> > >  drivers/cpufreq/amd-pstate.c                | 189 ++++++++++++++++++=
=2D-
> > >  include/linux/amd-pstate.h                  |  14 ++
> > >  6 files changed, 225 insertions(+), 14 deletions(-)
> >=20
> > I've applied this series along with fixes and improvements [1], and I c=
annot get guided mode to work with my CPU any more.
> >=20
> > The CPU is:
> >=20
> > ```
> > Vendor ID:                AuthenticAMD
> >   Model name:             AMD Ryzen 9 5950X 16-Core Processor
> >     CPU family:           25
> >     Model:                33
> >     Thread(s) per core:   2
> >     Core(s) per socket:   16
> >     Socket(s):            1
> >     Stepping:             2
> > ```
> >=20
> > I've got `amd_pstate=3Dguided` set in the kernel cmdline, but `amd-psta=
te-epp` gets loaded anyway.
>=20
> OK, this part is solved like below:
>=20
> ```
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index aafa4466e5ced..5aee7d2b8cfd7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -66,7 +66,7 @@
>  static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
> -static int cppc_state;
> +static int cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore =3D true;
>  static struct quirk_entry *quirks;
> @@ -1958,10 +1958,6 @@ static int __init amd_pstate_init(void)
>  	/* check if this machine need CPPC quirks */
>  	dmi_check_system(amd_pstate_quirks_table);
> =20
> -	/* get default driver mode for loading*/
> -	cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> -	pr_debug("cppc working state set to mode:%d\n", cppc_state);
> -
>  	switch (cppc_state) {
>  	case AMD_PSTATE_DISABLE:
>  		pr_info("driver load is disabled, boot with specific mode to enable th=
is\n");
> ```
>=20
> as we have discussed here [1].
>=20
> [1] https://lore.kernel.org/lkml/CYYPR12MB865554562BE018D46FF0108C9CE52@C=
YYPR12MB8655.namprd12.prod.outlook.com/

Ah no, scratch it, it's not solved. With `amd_pstate=3Dguided` the driver f=
ails to register during the boottime with the same `sysfs` error:

```
kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpufre=
q/policy0/boost'
kernel: Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 4805 =
03/18/2024
kernel: Call Trace:
kernel:  <TASK>
kernel:  dump_stack_lvl+0x47/0x60
kernel:  sysfs_warn_dup+0x5a/0x70
kernel:  sysfs_create_file_ns+0x196/0x1b0
kernel:  cpufreq_online+0x244/0xde0
kernel:  cpufreq_add_dev+0x7b/0x90
kernel:  subsys_interface_register+0x19e/0x1d0
kernel:  cpufreq_register_driver+0x177/0x2f0
kernel:  amd_pstate_init+0x1b8/0x2c0
kernel:  do_one_initcall+0x5b/0x320
kernel:  kernel_init_freeable+0x1dc/0x380
kernel:  kernel_init+0x1a/0x1c0
kernel:  ret_from_fork+0x34/0x50
kernel:  ret_from_fork_asm+0x1b/0x30
kernel:  </TASK>
```

and things revert to `acpi_cpufreq` instead.

What's wrong?

>=20
> But this part:
>=20
> > When I try to set `guided` manually via `echo guided | sudo tee /sys/de=
vices/system/cpu/amd_pstate/status`, the status gets dropped to `disable`, =
`tee` errors out with `-ENODEV`, and there's this in the kernel log:
> >=20
> > ```
> > $ jctl -kb | grep sysfs: | cut -d ' ' -f 5-
> > kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cp=
ufreq/policy0/boost'
> > =E2=80=A6
> > kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cp=
ufreq/policy31/boost'
> > ```
>=20
> is not. I've successfully booted with `amd_pstate=3Dguided`, then did thi=
s:
>=20
> ```
> $ echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
> ```
>=20
> just for the sake of test, and got this:
>=20
> ```
> tee: /sys/devices/system/cpu/amd_pstate/status: File exists
> ```
>=20
> and this:
>=20
> ```
> kernel: WARNING: CPU: 9 PID: 8528 at drivers/cpufreq/cpufreq.c:2961 cpufr=
eq_unregister_driver+0x1a/0xc0
> ```
>=20
> which corresponds to:
>=20
> ```
> 2957 void cpufreq_unregister_driver(struct cpufreq_driver *driver)
> 2958 {
> 2959         unsigned long flags;
> 2960
> 2961         if (WARN_ON(!cpufreq_driver || (driver !=3D cpufreq_driver)))
> 2962                 return;
> ```
>=20
> I haven't conducted this test before, so I don't know whether this behavi=
our is new, or it was present in older iterations. I also don't know if thi=
s belongs to the "boost" series or the "fixes", and just letting you know s=
o that you can test the runtime switching yourself and see if it is reprodu=
cible in your environment as well or not.
>=20
> > The following is applied on top of v6.9-rc7:
> >=20
> > ```
> > cpufreq: amd-pstate: automatically load pstate driver by default
> > cpufreq: amd-pstate: fix the highest frequency issue which limit perfor=
mance
> > cpufreq: amd-pstate: implement heterogeneous core topology for highest =
performance initialization
> > x86/cpufeatures: Add feature bits for AMD heterogeneous processor
> > cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
> > Documentation: PM: amd-pstate: add guide mode to the Operation mode
> > Documentation: PM: amd-pstate: add debugging section for driver loading=
 failure
> > Documentation: PM: amd-pstate: introducing recommended reboot requireme=
nt during driver switch
> > cpufreq: amd-pstate: add debug message while CPPC is supported and disa=
bled by SBIOS
> > cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
> > cpufreq: amd-pstate: optimiza the initial frequency values verification
> > Documentation: cpufreq: amd-pstate: update doc for Per CPU boost contro=
l method
> > cpufreq: amd-pstate: introduce per CPU frequency boost control
> > Documentation: cpufreq: amd-pstate: introduce the new cpu boost control=
 method
> > cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while=
 cpb boost off
> > cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
> > cpufreq: amd-pstate: initialize new core precision boost state
> > cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> > cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
> > cpufreq: amd-pstate: fix code format problems
> > cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
> > cpufreq: amd-pstate: get transition delay and latency value from ACPI t=
ables
> > cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
> > cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear}_=
freq()
> > cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonli=
near}_freq
> > cpufreq: amd-pstate: Document the units for freq variables in amd_cpuda=
ta
> > cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
> > ```
> >=20
> > Previously, with your submissions, it was possible to use `guided` mode=
 with my Zen 3.
> >=20
> > [1] https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.co=
m/
> >=20
> >=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12430864.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY70MMACgkQil/iNcg8
M0t4CQ/+LsQ+TSgrHJF5FR18m6uypR0KP8W7bb+tXqfjDiZkzGID+fumssQuneID
TNYxxRlFE80kA2rqcYckEBPO8NemQygRGTzN2LYyGglHLZV7TwVcGSqRKFF3BYi8
6XIzF78tmO8J2czEOPpbJOa2/k/tipCVzXdZpUR3o3pG4fNTC4exyA+N/OHqimXD
wsXtW2gVznw1nCuoHF8SlKETjTnd09A9WDiHQd8wR7JlQ3M6TvxaLcM9SrmI/m8N
iBKyrJaKhbw55ZYN61ZC+tyN1cUMcQfKiEhk1mbORUsFQCDSMlS8rGDu4Ba55iGc
xxBkARUcpkNvOlRM3CYnaxFVOpIzMDlKagdKiDebabnTQa/r3NYkFMyf5fgBR3pj
+TBGO3nuCix7NR+Nk9day6eThzvZTFzf6xEUONiO2Gs0KIEIk66+QV/B+xTmj3o8
grVFBacK98IAWRDZw1u9CeW7rXg9cQM+Bqw5+OH+1DYyng9tISsS1XUFfutKff9i
DbqTQTg5//Gs87oOV/tTxdQuWPirEwm5FBlNGD1aZUkem5+ct8ldWNu5ygJ6V0UB
ip1jKNT/2DlibO5bYxG8cyiYxC3Lz7UCQdO1KEsilSt22ozCPrtSf9MGQoYeigMJ
3Wcaux0YHaL68zsY/n3AuE3/Mtqvo0HdK7yLeCxJ0WmjahCxrzg=
=K3j7
-----END PGP SIGNATURE-----

--nextPart12430864.O9o76ZdvQC--




