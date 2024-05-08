Return-Path: <linux-pm+bounces-7674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5B8C064C
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 23:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4381F23263
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE7131E43;
	Wed,  8 May 2024 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="BOZ5oF8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30C12BF20;
	Wed,  8 May 2024 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203883; cv=none; b=kzRfTIQaaAhirxDKgBkRqgZU3CixYuNNUarhpXMDLcs0ruF9c4VseLHhuwf9lEOg+87EcOthFl3ZQVb6vp8ru6b1xpUT0XIv9Qwoch4YJoYcUKBY4rHgBn7tPybGG0sfGQ2SIY2RiQjM1VaKZ1eNVSl3FbemSKSgtvH+5pfp9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203883; c=relaxed/simple;
	bh=ZtLGdl52vtg3vnmN06ew7auLRElOGROMxgEJsMhzGDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyD9hMfkv3OsN8nBHZbezpo3SEmND0e+ZaApnIPkr6o50QS03xSngph8UyBW2aQn9iYO8tOYGRmzbXItq7EhPQeHRQbEAbG9NKZe0YtsZc8amTu2Y5zgXCbHJ9KW6ZARsf+S+V5mfIT0Nmpo9XeeLgg5g1YHQb/Y0NtMnbLePxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=BOZ5oF8B; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 5FD2C6356CD3;
	Wed, 08 May 2024 23:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715203875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d2BqnhV+W965UycNPyHoE8fPrB0pAV5FBq8owwCeXiI=;
	b=BOZ5oF8Bj64A1l2IqDpSHAFY/+vvZ0ByCeUJ1r8bF075+BGKK4+iZ3m2HoXynUsv4luEPN
	/JS4id7zbB6JJY6bBPgCBFHYXZtEZb2kwKcd7jgIL3TpV0VuFnBPhMfNgXK4hC59MntRk2
	nMjuBJUUv3oGXGy+04fqBzdAAIh7fzI=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 08 May 2024 23:31:02 +0200
Message-ID: <12430912.O9o76ZdvQC@natalenko.name>
In-Reply-To: <2728768.mvXUDI8C0e@natalenko.name>
References:
 <cover.1715152592.git.perry.yuan@amd.com> <6041368.lOV4Wx5bFT@natalenko.name>
 <2728768.mvXUDI8C0e@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5776996.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5776996.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 08 May 2024 23:31:02 +0200
Message-ID: <12430912.O9o76ZdvQC@natalenko.name>
In-Reply-To: <2728768.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0

On st=C5=99eda 8. kv=C4=9Btna 2024 21:21:39, SEL=C4=8C Oleksandr Natalenko =
wrote:
> On st=C5=99eda 8. kv=C4=9Btna 2024 21:13:40, SEL=C4=8C Oleksandr Natalenk=
o wrote:
> > On st=C5=99eda 8. kv=C4=9Btna 2024 17:11:42, SEL=C4=8C Oleksandr Natale=
nko wrote:
> > > Hello.
> > >=20
> > > On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:05, SEL=C4=8C Perry Yuan wrot=
e:
> > > > Hi all,
> > > > The patchset series add core performance boost feature for AMD psta=
te
> > > > driver including passisve ,guide and active mode support.
> > > >=20
> > > > User can change core frequency boost control with a new sysfs entry:
> > > >=20
> > > > "/sys/devices/system/cpu/amd_pstate/cpb_boost"
> > > >=20
> > > >=20
> > > > 1) globally disable core boost:
> > > > $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boo=
st"
> > > > $ lscpu -ae
> > > > CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      M=
HZ
> > > >   0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.5=
78
> > > >   1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.5=
78
> > > >   2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.8=
55
> > > >   3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.5=
78
> > > >   4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.5=
78
> > > >=20
> > > > 2) globally enable core boost:
> > > > $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boo=
st"
> > > > $ lscpu -ae
> > > >    0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.=
578
> > > >   1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.5=
78
> > > >   2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.5=
78
> > > >   3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.5=
78
> > > >   4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.5=
78
> > > >=20
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > The V9 patches add per CPU boost control, user can enable/disable C=
PUs boost
> > > > as the below command tested on a laptop system.
> > > > # before
> > > >   CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ     =
  MHZ
> > > >   0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7=
740
> > > >   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0=
000
> > > >   2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1=
260
> > > >   3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0=
000
> > > > $ sudo rdmsr 0xc00102b3 -p 0
> > > > 10a6
> > > >=20
> > > > $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> > > > # after
> > > >   CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ     =
  MHZ
> > > >     0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400=
=2E0000
> > > >     1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391=
=2E0690
> > > >     2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654=
=2E4541
> > > >     3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400=
=2E0000
> > > > $ sudo rdmsr 0xc00102b3 -p 0
> > > > 108a
> > > >=20
> > > >=20
> > > > The patches have been tested with the AMD 7950X processor and many =
users
> > > > would like to get core boost control enabled for power saving.
> > > >=20
> > > > Perry.
> > > >=20
> > > >=20
> > > > Changes from v9:
> > > >  * change per CPU boost sysfs file name to `boost` (Mario)
> > > >  * rebased to latest linux-pm/bleeding-edge
> > > >=20
> > > > Changes from v8:
> > > >  * pick RB flag for patch 4 (Mario)
> > > >  * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
> > > >  * merge patch 6 into patch 3 (Mario)
> > > >  * add two patch for per CPU boost control patch 6 & 7(Mario)
> > > >  * rebased to latest linux-pm/bleeding-edge
> > > >=20
> > > > Changes from v7:
> > > >  * fix the mutext locking issue in the sysfs file update(Ray, Mario)
> > > >  * pick ack flag from Ray
> > > >  * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
> > > >  * rerun the testing to check function works well
> > > >  * rebased to linux-pm/bleeding-edge latest
> > > >=20
> > > > Changes from v6:
> > > >  * reword patch 2 commit log (Gautham)
> > > >  * update cover letter description(Gautham)
> > > >  * rebase to kernel v6.9-rc5
> > > >=20
> > > > Changes from v4:
> > > >  * drop the legacy boost remove patch, let us keep the legacy inter=
face
> > > >    in case some applications break.
> > > >  * rebase to linux-pm/bleeding-edge branch
> > > >  * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
> > > >    Enhancements which has some intial work done there.
> > > >=20
> > > > Changes from v4:
> > > >  * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> > > >  * pick RB flag from Gautham R. Shenoy
> > > >  * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
> > > >  * rebase to latest linux-pm/bleeding-edge branch
> > > >  * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes A=
nd Enhancements
> > > >  * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
> > > >=20
> > > > Changes from v3:
> > > >  * rebased to linux-pm/bleeding-edge v6.8
> > > >  * rename global to amd_pstate_global_params(Oleksandr Natalenko)
> > > >  * remove comments for boot_supported in amd_pstate.h
> > > >  * fix the compiler warning for amd-pstate-ut.ko
> > > >  * use for_each_online_cpu in cpb_boost_store which fix the null po=
inter
> > > >    error during testing
> > > >  * fix the max frequency value to be KHz when cpb boost disabled(Ga=
utham R. Shenoy)
> > > >=20
> > > > Changes from v2:
> > > >  * move global struct to amd-pstate.h
> > > >  * fix the amd-pstate-ut with new cpb control interface
> > > >=20
> > > > Changes from v1:
> > > >  * drop suspend/resume fix patch 6/7 because of the fix should be in
> > > >    another fix series instead of CPB feature
> > > >  * move the set_boost remove patch to the last(Mario)
> > > >  * Fix commit info with "Closes:" (Mario)
> > > >  * simplified global.cpb_supported initialization(Mario)
> > > >  * Add guide mode support for CPB control
> > > >  * Fixed some Doc typos and add guide mode info to Doc as well.
> > > >=20
> > > > v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd=
=2Ecom/
> > > > v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@am=
d.com/
> > > > v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@am=
d.com/
> > > > v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@am=
d.com/
> > > > v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@am=
d.com/
> > > > v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@am=
d.com/
> > > > v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@am=
d.com/
> > > > v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@am=
d.com/
> > > > v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@am=
d.com/
> > > >=20
> > > > Perry Yuan (7):
> > > >   cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> > > >   cpufreq: amd-pstate: initialize new core precision boost state
> > > >   cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost co=
ntrol
> > > >   cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
> > > >     while cpb boost off
> > > >   Documentation: cpufreq: amd-pstate: introduce the new cpu boost
> > > >     control method
> > > >   cpufreq: amd-pstate: introduce per CPU frequency boost control
> > > >   Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
> > > >     control method
> > > >=20
> > > >  Documentation/admin-guide/pm/amd-pstate.rst |  30 ++++
> > > >  arch/x86/include/asm/msr-index.h            |   2 +
> > > >  drivers/cpufreq/acpi-cpufreq.c              |   2 -
> > > >  drivers/cpufreq/amd-pstate-ut.c             |   2 +-
> > > >  drivers/cpufreq/amd-pstate.c                | 189 ++++++++++++++++=
++--
> > > >  include/linux/amd-pstate.h                  |  14 ++
> > > >  6 files changed, 225 insertions(+), 14 deletions(-)
> > >=20
> > > I've applied this series along with fixes and improvements [1], and I=
 cannot get guided mode to work with my CPU any more.
> > >=20
> > > The CPU is:
> > >=20
> > > ```
> > > Vendor ID:                AuthenticAMD
> > >   Model name:             AMD Ryzen 9 5950X 16-Core Processor
> > >     CPU family:           25
> > >     Model:                33
> > >     Thread(s) per core:   2
> > >     Core(s) per socket:   16
> > >     Socket(s):            1
> > >     Stepping:             2
> > > ```
> > >=20
> > > I've got `amd_pstate=3Dguided` set in the kernel cmdline, but `amd-ps=
tate-epp` gets loaded anyway.
> >=20
> > OK, this part is solved like below:
> >=20
> > ```
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index aafa4466e5ced..5aee7d2b8cfd7 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -66,7 +66,7 @@
> >  static struct cpufreq_driver *current_pstate_driver;
> >  static struct cpufreq_driver amd_pstate_driver;
> >  static struct cpufreq_driver amd_pstate_epp_driver;
> > -static int cppc_state;
> > +static int cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> >  static bool cppc_enabled;
> >  static bool amd_pstate_prefcore =3D true;
> >  static struct quirk_entry *quirks;
> > @@ -1958,10 +1958,6 @@ static int __init amd_pstate_init(void)
> >  	/* check if this machine need CPPC quirks */
> >  	dmi_check_system(amd_pstate_quirks_table);
> > =20
> > -	/* get default driver mode for loading*/
> > -	cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> > -	pr_debug("cppc working state set to mode:%d\n", cppc_state);
> > -
> >  	switch (cppc_state) {
> >  	case AMD_PSTATE_DISABLE:
> >  		pr_info("driver load is disabled, boot with specific mode to enable =
this\n");
> > ```
> >=20
> > as we have discussed here [1].
> >=20
> > [1] https://lore.kernel.org/lkml/CYYPR12MB865554562BE018D46FF0108C9CE52=
@CYYPR12MB8655.namprd12.prod.outlook.com/
>=20
> Ah no, scratch it, it's not solved. With `amd_pstate=3Dguided` the driver=
 fails to register during the boottime with the same `sysfs` error:
>=20
> ```
> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/cpuf=
req/policy0/boost'
> kernel: Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 480=
5 03/18/2024
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  dump_stack_lvl+0x47/0x60
> kernel:  sysfs_warn_dup+0x5a/0x70
> kernel:  sysfs_create_file_ns+0x196/0x1b0
> kernel:  cpufreq_online+0x244/0xde0
> kernel:  cpufreq_add_dev+0x7b/0x90
> kernel:  subsys_interface_register+0x19e/0x1d0
> kernel:  cpufreq_register_driver+0x177/0x2f0
> kernel:  amd_pstate_init+0x1b8/0x2c0
> kernel:  do_one_initcall+0x5b/0x320
> kernel:  kernel_init_freeable+0x1dc/0x380
> kernel:  kernel_init+0x1a/0x1c0
> kernel:  ret_from_fork+0x34/0x50
> kernel:  ret_from_fork_asm+0x1b/0x30
> kernel:  </TASK>
> ```
>=20
> and things revert to `acpi_cpufreq` instead.
>=20
> What's wrong?

This happens with both `amd_pstate=3Dguided` and `amd_pstate=3Dpassive`, wh=
ile with `amd_pstate=3Dactive` it works. Also note I've got:

```
CONFIG_X86_AMD_PSTATE=3Dy
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
```

aka "active" by default.

It seems I miss to understand something in the init sequence.

>=20
> >=20
> > But this part:
> >=20
> > > When I try to set `guided` manually via `echo guided | sudo tee /sys/=
devices/system/cpu/amd_pstate/status`, the status gets dropped to `disable`=
, `tee` errors out with `-ENODEV`, and there's this in the kernel log:
> > >=20
> > > ```
> > > $ jctl -kb | grep sysfs: | cut -d ' ' -f 5-
> > > kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/=
cpufreq/policy0/boost'
> > > =E2=80=A6
> > > kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/=
cpufreq/policy31/boost'
> > > ```
> >=20
> > is not. I've successfully booted with `amd_pstate=3Dguided`, then did t=
his:
> >=20
> > ```
> > $ echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
> > ```
> >=20
> > just for the sake of test, and got this:
> >=20
> > ```
> > tee: /sys/devices/system/cpu/amd_pstate/status: File exists
> > ```
> >=20
> > and this:
> >=20
> > ```
> > kernel: WARNING: CPU: 9 PID: 8528 at drivers/cpufreq/cpufreq.c:2961 cpu=
freq_unregister_driver+0x1a/0xc0
> > ```
> >=20
> > which corresponds to:
> >=20
> > ```
> > 2957 void cpufreq_unregister_driver(struct cpufreq_driver *driver)
> > 2958 {
> > 2959         unsigned long flags;
> > 2960
> > 2961         if (WARN_ON(!cpufreq_driver || (driver !=3D cpufreq_driver=
)))
> > 2962                 return;
> > ```
> >=20
> > I haven't conducted this test before, so I don't know whether this beha=
viour is new, or it was present in older iterations. I also don't know if t=
his belongs to the "boost" series or the "fixes", and just letting you know=
 so that you can test the runtime switching yourself and see if it is repro=
ducible in your environment as well or not.
> >=20
> > > The following is applied on top of v6.9-rc7:
> > >=20
> > > ```
> > > cpufreq: amd-pstate: automatically load pstate driver by default
> > > cpufreq: amd-pstate: fix the highest frequency issue which limit perf=
ormance
> > > cpufreq: amd-pstate: implement heterogeneous core topology for highes=
t performance initialization
> > > x86/cpufeatures: Add feature bits for AMD heterogeneous processor
> > > cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
> > > Documentation: PM: amd-pstate: add guide mode to the Operation mode
> > > Documentation: PM: amd-pstate: add debugging section for driver loadi=
ng failure
> > > Documentation: PM: amd-pstate: introducing recommended reboot require=
ment during driver switch
> > > cpufreq: amd-pstate: add debug message while CPPC is supported and di=
sabled by SBIOS
> > > cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
> > > cpufreq: amd-pstate: optimiza the initial frequency values verificati=
on
> > > Documentation: cpufreq: amd-pstate: update doc for Per CPU boost cont=
rol method
> > > cpufreq: amd-pstate: introduce per CPU frequency boost control
> > > Documentation: cpufreq: amd-pstate: introduce the new cpu boost contr=
ol method
> > > cpufreq: amd-pstate: fix the MSR highest perf will be reset issue whi=
le cpb boost off
> > > cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
> > > cpufreq: amd-pstate: initialize new core precision boost state
> > > cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> > > cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
> > > cpufreq: amd-pstate: fix code format problems
> > > cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missi=
ng
> > > cpufreq: amd-pstate: get transition delay and latency value from ACPI=
 tables
> > > cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
> > > cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinear=
}_freq()
> > > cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_non=
linear}_freq
> > > cpufreq: amd-pstate: Document the units for freq variables in amd_cpu=
data
> > > cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
> > > ```
> > >=20
> > > Previously, with your submissions, it was possible to use `guided` mo=
de with my Zen 3.
> > >=20
> > > [1] https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.=
com/
> > >=20
> > >=20
> >=20
> >=20
> >=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5776996.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY77xYACgkQil/iNcg8
M0vTPRAAn5Ok15YbTWaUKJBld7bnA7lqyUbyXz/VHzJa1Qfj4ctiG/e49qLgrIYU
S/XB4BSmh5Ofn7/I8rZn28CbMgEpFzQJU/FTyohPk2DNALeT/3b+MClHD4P1PoVq
eqBMTCAHwIK7v393ozjr+y53DeMg7mqsSCdLlDbHPmUj9+SlF6h9NrO+x1qwAVzc
tGhrCxqoL873mW0h6zPzQBrEdDBhUNX8SJ1BM77szlzgEt2+DwWJF0W7XXN767So
jLiLNhXxro87EgfnvFYc4MHkce0peNzEX2f2eMihl+SMCRC53hMbaKt93iJWNRZp
zpvLQD+AMN9nHexERJWLggXIDkV4V03CrfnJELjBMtTSoNdVf1i99Prh3y3RbZzS
KrxAnyF1EOIksKbxFXDWojbJ+rXJUPA+lgRXDt/HoD8f4G8Ynb1W2rMzBU8gCK3D
YyJ7KIWMvCQpi+0td9S1a3qQGZn9ENjSzwAk7WnElTkKFWX/77XvD2wTDbVdP/1g
eoF05ve/A3Qm28JauOE1m2i/ZS5Lgjt8LC2Gtgbu4qzKjHhCy399V/cQAYdaz3LX
CdIRerOVTlRGicLLadJo9cOPBX8IFMq4r7Wh+5W0or1pwlrffRWsTr69iJR8JXuA
K+pe8NeSRfvhmC2cozs8Cj8enx4y+z2Auesg/C8w8QFyYEdoqaY=
=+58A
-----END PGP SIGNATURE-----

--nextPart5776996.DvuYhMxLoT--




