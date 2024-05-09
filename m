Return-Path: <linux-pm+bounces-7683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63368C0F1B
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 14:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639111F22E4D
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E114B951;
	Thu,  9 May 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="stYgXDz5"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753D149DEA;
	Thu,  9 May 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256093; cv=none; b=hXpMIifzucDY4xafKNow4o1VXYguy6PUDbGcKp7KOYmjGt3b6IE6RyafMX8TpD0sxyO41v4L37qFWKFT3nW+1axo0F5N135YjntF/RiYYKvT/iGYCQ4Di3nWA9Ye1F8ALHDLexePYZgJcxbkneEhGXjlTNUjJ4Li0rkti8aHxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256093; c=relaxed/simple;
	bh=NZZLyJDGLZNRli8nJWyfhkdqu/3Uq/TaG9ZH8peVufE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjBqiTTRsmgY9YhhsKxva/hErBlfmZFQXJUwLUb3IeFNDjyRuZ5kzi9GXP+mqvvy4XvKrOVQ8sSoKVGzVzi4IWOcd+SKGmYMkJLIbDY6REv7SGNcBa6uiLZ0Yhez+c4/V2UOVZI2xmS9oGHsV5egF+utDBoh8XKyCsCSfYy+Ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=stYgXDz5; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 424066356CD3;
	Thu, 09 May 2024 14:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715256080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vIAVJt2VE30osPxzi8z8hFVMXnbvUT3aPuW66map1o=;
	b=stYgXDz5ZKTBTvW7R981K7KXEfQHPNS4QKIOthXyR98Rs5pgR/vZTa1r2vrba55cI8S9Fn
	1ysnBkfg9SrpZe1oCzPZijg+Cw7NOJ+bIgQw6tUJxt4DvvMFUqbE8nI7FVU+ryfpJWnTxy
	JY6zNFXqkGbzIxBG4pW/1/F75GjhvEU=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com,
 Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Thu, 09 May 2024 14:01:05 +0200
Message-ID: <5777236.DvuYhMxLoT@natalenko.name>
In-Reply-To: <5b4f0361-a456-4e6a-983b-7c534783c643@amd.com>
References:
 <cover.1715152592.git.perry.yuan@amd.com>
 <12430912.O9o76ZdvQC@natalenko.name>
 <5b4f0361-a456-4e6a-983b-7c534783c643@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6041598.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6041598.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Thu, 09 May 2024 14:01:05 +0200
Message-ID: <5777236.DvuYhMxLoT@natalenko.name>
In-Reply-To: <5b4f0361-a456-4e6a-983b-7c534783c643@amd.com>
MIME-Version: 1.0

On =C4=8Dtvrtek 9. kv=C4=9Btna 2024 0:13:49, SEL=C4=8C Mario Limonciello wr=
ote:
> On 5/8/2024 16:31, Oleksandr Natalenko wrote:
> > On st=C5=99eda 8. kv=C4=9Btna 2024 21:21:39, SEL=C4=8C Oleksandr Natale=
nko wrote:
> >> On st=C5=99eda 8. kv=C4=9Btna 2024 21:13:40, SEL=C4=8C Oleksandr Natal=
enko wrote:
> >>> On st=C5=99eda 8. kv=C4=9Btna 2024 17:11:42, SEL=C4=8C Oleksandr Nata=
lenko wrote:
> >>>> Hello.
> >>>>
> >>>> On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:05, SEL=C4=8C Perry Yuan wro=
te:
> >>>>> Hi all,
> >>>>> The patchset series add core performance boost feature for AMD psta=
te
> >>>>> driver including passisve ,guide and active mode support.
> >>>>>
> >>>>> User can change core frequency boost control with a new sysfs entry:
> >>>>>
> >>>>> "/sys/devices/system/cpu/amd_pstate/cpb_boost"
> >>>>>
> >>>>>
> >>>>> 1) globally disable core boost:
> >>>>> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boo=
st"
> >>>>> $ lscpu -ae
> >>>>> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      M=
HZ
> >>>>>    0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.=
578
> >>>>>    1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.=
578
> >>>>>    2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.=
855
> >>>>>    3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.=
578
> >>>>>    4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.=
578
> >>>>>
> >>>>> 2) globally enable core boost:
> >>>>> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boo=
st"
> >>>>> $ lscpu -ae
> >>>>>     0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983=
=2E578
> >>>>>    1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.=
578
> >>>>>    2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.=
578
> >>>>>    3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.=
578
> >>>>>    4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.=
578
> >>>>>
> >>>>>
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>>>> The V9 patches add per CPU boost control, user can enable/disable C=
PUs boost
> >>>>> as the below command tested on a laptop system.
> >>>>> # before
> >>>>>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ    =
   MHZ
> >>>>>    0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.=
7740
> >>>>>    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.=
0000
> >>>>>    2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.=
1260
> >>>>>    3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.=
0000
> >>>>> $ sudo rdmsr 0xc00102b3 -p 0
> >>>>> 10a6
> >>>>>
> >>>>> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> >>>>> # after
> >>>>>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ    =
   MHZ
> >>>>>      0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  40=
0.0000
> >>>>>      1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 139=
1.0690
> >>>>>      2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 365=
4.4541
> >>>>>      3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  40=
0.0000
> >>>>> $ sudo rdmsr 0xc00102b3 -p 0
> >>>>> 108a
> >>>>>
> >>>>>
> >>>>> The patches have been tested with the AMD 7950X processor and many =
users
> >>>>> would like to get core boost control enabled for power saving.
> >>>>>
> >>>>> Perry.
> >>>>>
> >>>>>
> >>>>> Changes from v9:
> >>>>>   * change per CPU boost sysfs file name to `boost` (Mario)
> >>>>>   * rebased to latest linux-pm/bleeding-edge
> >>>>>
> >>>>> Changes from v8:
> >>>>>   * pick RB flag for patch 4 (Mario)
> >>>>>   * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
> >>>>>   * merge patch 6 into patch 3 (Mario)
> >>>>>   * add two patch for per CPU boost control patch 6 & 7(Mario)
> >>>>>   * rebased to latest linux-pm/bleeding-edge
> >>>>>
> >>>>> Changes from v7:
> >>>>>   * fix the mutext locking issue in the sysfs file update(Ray, Mari=
o)
> >>>>>   * pick ack flag from Ray
> >>>>>   * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
> >>>>>   * rerun the testing to check function works well
> >>>>>   * rebased to linux-pm/bleeding-edge latest
> >>>>>
> >>>>> Changes from v6:
> >>>>>   * reword patch 2 commit log (Gautham)
> >>>>>   * update cover letter description(Gautham)
> >>>>>   * rebase to kernel v6.9-rc5
> >>>>>
> >>>>> Changes from v4:
> >>>>>   * drop the legacy boost remove patch, let us keep the legacy inte=
rface
> >>>>>     in case some applications break.
> >>>>>   * rebase to linux-pm/bleeding-edge branch
> >>>>>   * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
> >>>>>     Enhancements which has some intial work done there.
> >>>>>
> >>>>> Changes from v4:
> >>>>>   * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> >>>>>   * pick RB flag from Gautham R. Shenoy
> >>>>>   * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
> >>>>>   * rebase to latest linux-pm/bleeding-edge branch
> >>>>>   * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes =
And Enhancements
> >>>>>   * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
> >>>>>
> >>>>> Changes from v3:
> >>>>>   * rebased to linux-pm/bleeding-edge v6.8
> >>>>>   * rename global to amd_pstate_global_params(Oleksandr Natalenko)
> >>>>>   * remove comments for boot_supported in amd_pstate.h
> >>>>>   * fix the compiler warning for amd-pstate-ut.ko
> >>>>>   * use for_each_online_cpu in cpb_boost_store which fix the null p=
ointer
> >>>>>     error during testing
> >>>>>   * fix the max frequency value to be KHz when cpb boost disabled(G=
autham R. Shenoy)
> >>>>>
> >>>>> Changes from v2:
> >>>>>   * move global struct to amd-pstate.h
> >>>>>   * fix the amd-pstate-ut with new cpb control interface
> >>>>>
> >>>>> Changes from v1:
> >>>>>   * drop suspend/resume fix patch 6/7 because of the fix should be =
in
> >>>>>     another fix series instead of CPB feature
> >>>>>   * move the set_boost remove patch to the last(Mario)
> >>>>>   * Fix commit info with "Closes:" (Mario)
> >>>>>   * simplified global.cpb_supported initialization(Mario)
> >>>>>   * Add guide mode support for CPB control
> >>>>>   * Fixed some Doc typos and add guide mode info to Doc as well.
> >>>>>
> >>>>> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd=
=2Ecom/
> >>>>> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@am=
d.com/
> >>>>> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@am=
d.com/
> >>>>> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@am=
d.com/
> >>>>> v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@am=
d.com/
> >>>>> v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@am=
d.com/
> >>>>> v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@am=
d.com/
> >>>>> v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@am=
d.com/
> >>>>> v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@am=
d.com/
> >>>>>
> >>>>> Perry Yuan (7):
> >>>>>    cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> >>>>>    cpufreq: amd-pstate: initialize new core precision boost state
> >>>>>    cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost c=
ontrol
> >>>>>    cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
> >>>>>      while cpb boost off
> >>>>>    Documentation: cpufreq: amd-pstate: introduce the new cpu boost
> >>>>>      control method
> >>>>>    cpufreq: amd-pstate: introduce per CPU frequency boost control
> >>>>>    Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
> >>>>>      control method
> >>>>>
> >>>>>   Documentation/admin-guide/pm/amd-pstate.rst |  30 ++++
> >>>>>   arch/x86/include/asm/msr-index.h            |   2 +
> >>>>>   drivers/cpufreq/acpi-cpufreq.c              |   2 -
> >>>>>   drivers/cpufreq/amd-pstate-ut.c             |   2 +-
> >>>>>   drivers/cpufreq/amd-pstate.c                | 189 +++++++++++++++=
+++--
> >>>>>   include/linux/amd-pstate.h                  |  14 ++
> >>>>>   6 files changed, 225 insertions(+), 14 deletions(-)
> >>>>
> >>>> I've applied this series along with fixes and improvements [1], and =
I cannot get guided mode to work with my CPU any more.
> >>>>
> >>>> The CPU is:
> >>>>
> >>>> ```
> >>>> Vendor ID:                AuthenticAMD
> >>>>    Model name:             AMD Ryzen 9 5950X 16-Core Processor
> >>>>      CPU family:           25
> >>>>      Model:                33
> >>>>      Thread(s) per core:   2
> >>>>      Core(s) per socket:   16
> >>>>      Socket(s):            1
> >>>>      Stepping:             2
> >>>> ```
> >>>>
> >>>> I've got `amd_pstate=3Dguided` set in the kernel cmdline, but `amd-p=
state-epp` gets loaded anyway.
> >>>
> >>> OK, this part is solved like below:
> >>>
> >>> ```
> >>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstat=
e.c
> >>> index aafa4466e5ced..5aee7d2b8cfd7 100644
> >>> --- a/drivers/cpufreq/amd-pstate.c
> >>> +++ b/drivers/cpufreq/amd-pstate.c
> >>> @@ -66,7 +66,7 @@
> >>>   static struct cpufreq_driver *current_pstate_driver;
> >>>   static struct cpufreq_driver amd_pstate_driver;
> >>>   static struct cpufreq_driver amd_pstate_epp_driver;
> >>> -static int cppc_state;
> >>> +static int cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> >>>   static bool cppc_enabled;
> >>>   static bool amd_pstate_prefcore =3D true;
> >>>   static struct quirk_entry *quirks;
> >>> @@ -1958,10 +1958,6 @@ static int __init amd_pstate_init(void)
> >>>   	/* check if this machine need CPPC quirks */
> >>>   	dmi_check_system(amd_pstate_quirks_table);
> >>>  =20
> >>> -	/* get default driver mode for loading*/
> >>> -	cppc_state =3D CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> >>> -	pr_debug("cppc working state set to mode:%d\n", cppc_state);
> >>> -
> >>>   	switch (cppc_state) {
> >>>   	case AMD_PSTATE_DISABLE:
> >>>   		pr_info("driver load is disabled, boot with specific mode to enab=
le this\n");
> >>> ```
> >>>
> >>> as we have discussed here [1].
> >>>
> >>> [1] https://lore.kernel.org/lkml/CYYPR12MB865554562BE018D46FF0108C9CE=
52@CYYPR12MB8655.namprd12.prod.outlook.com/
> >>
> >> Ah no, scratch it, it's not solved. With `amd_pstate=3Dguided` the dri=
ver fails to register during the boottime with the same `sysfs` error:
> >>
> >> ```
> >> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu/c=
pufreq/policy0/boost'
> >> kernel: Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS =
4805 03/18/2024
> >> kernel: Call Trace:
> >> kernel:  <TASK>
> >> kernel:  dump_stack_lvl+0x47/0x60
> >> kernel:  sysfs_warn_dup+0x5a/0x70
> >> kernel:  sysfs_create_file_ns+0x196/0x1b0
> >> kernel:  cpufreq_online+0x244/0xde0
> >> kernel:  cpufreq_add_dev+0x7b/0x90
> >> kernel:  subsys_interface_register+0x19e/0x1d0
> >> kernel:  cpufreq_register_driver+0x177/0x2f0
> >> kernel:  amd_pstate_init+0x1b8/0x2c0
> >> kernel:  do_one_initcall+0x5b/0x320
> >> kernel:  kernel_init_freeable+0x1dc/0x380
> >> kernel:  kernel_init+0x1a/0x1c0
> >> kernel:  ret_from_fork+0x34/0x50
> >> kernel:  ret_from_fork_asm+0x1b/0x30
> >> kernel:  </TASK>
> >> ```
> >>
> >> and things revert to `acpi_cpufreq` instead.
> >>
> >> What's wrong?
> >=20
> > This happens with both `amd_pstate=3Dguided` and `amd_pstate=3Dpassive`=
, while with `amd_pstate=3Dactive` it works. Also note I've got:
> >=20
> > ```
> > CONFIG_X86_AMD_PSTATE=3Dy
> > CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
> > ```
> >=20
> > aka "active" by default.
> >=20
> > It seems I miss to understand something in the init sequence.
> >=20
>=20
> I think what's going on is that by reusing the same name as acpi_cppc=20
> does for sysfs when amd pstate is changing modes the sysfs file from=20
> amd-pstate isn't cleared and so acpi_cppc tries to make it.

Seems so. I've renamed `amd_pstate`'s `boost` file to `amd_pstate_boost`, a=
nd now I'm able to boot with `amd_pstate=3Dguided`, and after boot under `/=
sys/devices/system/cpu/cpufreq/policyX` I see both `boost` (from `acpi_cppc=
`, apparently) and `amd_pstate_boost` at the same time.

Not sure the fact both files are present is as intended.

>=20
> Don't get me wrong - I do think that we should keep the same sysfs name=20
> for both, it's easier for users.
>=20
> But if we're going to keep mode switching from amd-pstate at runtime we=20
> really need to make sure that amd-pstate-ut explicitly tests all these=20
> combinations to catch these types of problems.

Not sure it's runtime switching only that is affected. I guess having `CONF=
IG_X86_AMD_PSTATE_DEFAULT_MODE` set to `active` and then having `amd_pstate=
=3Dguided` on the kernel cmdline is not considered to be a runtime switchin=
g (or is it?), yet it doesn't work either due to filename conflict.

> >>
> >>>
> >>> But this part:
> >>>
> >>>> When I try to set `guided` manually via `echo guided | sudo tee /sys=
/devices/system/cpu/amd_pstate/status`, the status gets dropped to `disable=
`, `tee` errors out with `-ENODEV`, and there's this in the kernel log:
> >>>>
> >>>> ```
> >>>> $ jctl -kb | grep sysfs: | cut -d ' ' -f 5-
> >>>> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu=
/cpufreq/policy0/boost'
> >>>> =E2=80=A6
> >>>> kernel: sysfs: cannot create duplicate filename '/devices/system/cpu=
/cpufreq/policy31/boost'
> >>>> ```
> >>>
> >>> is not. I've successfully booted with `amd_pstate=3Dguided`, then did=
 this:
> >>>
> >>> ```
> >>> $ echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
> >>> ```
> >>>
> >>> just for the sake of test, and got this:
> >>>
> >>> ```
> >>> tee: /sys/devices/system/cpu/amd_pstate/status: File exists
> >>> ```
> >>>
> >>> and this:
> >>>
> >>> ```
> >>> kernel: WARNING: CPU: 9 PID: 8528 at drivers/cpufreq/cpufreq.c:2961 c=
pufreq_unregister_driver+0x1a/0xc0
> >>> ```
> >>>
> >>> which corresponds to:
> >>>
> >>> ```
> >>> 2957 void cpufreq_unregister_driver(struct cpufreq_driver *driver)
> >>> 2958 {
> >>> 2959         unsigned long flags;
> >>> 2960
> >>> 2961         if (WARN_ON(!cpufreq_driver || (driver !=3D cpufreq_driv=
er)))
> >>> 2962                 return;
> >>> ```
> >>>
> >>> I haven't conducted this test before, so I don't know whether this be=
haviour is new, or it was present in older iterations. I also don't know if=
 this belongs to the "boost" series or the "fixes", and just letting you kn=
ow so that you can test the runtime switching yourself and see if it is rep=
roducible in your environment as well or not.
> >>>
> >>>> The following is applied on top of v6.9-rc7:
> >>>>
> >>>> ```
> >>>> cpufreq: amd-pstate: automatically load pstate driver by default
> >>>> cpufreq: amd-pstate: fix the highest frequency issue which limit per=
formance
> >>>> cpufreq: amd-pstate: implement heterogeneous core topology for highe=
st performance initialization
> >>>> x86/cpufeatures: Add feature bits for AMD heterogeneous processor
> >>>> cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
> >>>> Documentation: PM: amd-pstate: add guide mode to the Operation mode
> >>>> Documentation: PM: amd-pstate: add debugging section for driver load=
ing failure
> >>>> Documentation: PM: amd-pstate: introducing recommended reboot requir=
ement during driver switch
> >>>> cpufreq: amd-pstate: add debug message while CPPC is supported and d=
isabled by SBIOS
> >>>> cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
> >>>> cpufreq: amd-pstate: optimiza the initial frequency values verificat=
ion
> >>>> Documentation: cpufreq: amd-pstate: update doc for Per CPU boost con=
trol method
> >>>> cpufreq: amd-pstate: introduce per CPU frequency boost control
> >>>> Documentation: cpufreq: amd-pstate: introduce the new cpu boost cont=
rol method
> >>>> cpufreq: amd-pstate: fix the MSR highest perf will be reset issue wh=
ile cpb boost off
> >>>> cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost contr=
ol
> >>>> cpufreq: amd-pstate: initialize new core precision boost state
> >>>> cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
> >>>> cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
> >>>> cpufreq: amd-pstate: fix code format problems
> >>>> cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities miss=
ing
> >>>> cpufreq: amd-pstate: get transition delay and latency value from ACP=
I tables
> >>>> cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
> >>>> cpufreq: amd-pstate: Remove amd_get_{min,max,nominal,lowest_nonlinea=
r}_freq()
> >>>> cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_no=
nlinear}_freq
> >>>> cpufreq: amd-pstate: Document the units for freq variables in amd_cp=
udata
> >>>> cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
> >>>> ```
> >>>>
> >>>> Previously, with your submissions, it was possible to use `guided` m=
ode with my Zen 3.
> >>>>
> >>>> [1] https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd=
=2Ecom/
> >>>>
> >>>>
> >>>
> >>>
> >>>
> >>
> >>
> >>
> >=20
> >=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart6041598.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY8uwEACgkQil/iNcg8
M0sF4hAA1Fs0lhZFlWK/MEZGAHpBhS6gPs7IxFbuPXNnvzEtbfCPWJXm64nJpc6t
IreVK0tdZxvJ8Vdt8Mxh0yZLhlLWKvJgwo/UW+l/9mnKoqV9DN/13euRAbs95oMN
5VHhBQPylzYl+joaYLqSWOlND68c7+0S4yEXFWMdhnhvfiI+viMbCDwi7s7FgfT6
gyoeiAPkVYyWWk/uNldcyVR/IMqT7xk/eTHgY2Z3pjzKZCmeGUz+vVK1gtVS5Lh5
a4kQiFeU6yU90feQEC9wKe6hnCllIpCMvLGI29nT3BtEltaWTmq/aqMY84TH4PTZ
9wGiJhLE/U4R0Y7dFNGJ2JdghPpFhB5nep9FTiuY7nPZswdvb3ye7nhFDZaGFcun
mWqeiJ82SNKsMXWqTGUN6Hb4U1yrKf5AfRffuZbkZQe9rmzykrn02X/szVKceIEZ
Q7/F6idsDCDGJWid8MI9opE+2BYjkltKtGgmOjJpP/NZZfmqkMFxCV4yfa0Phi3w
WZLBtV5TRDIeeRW7OksTwaIMVKsLxlca+DTkb8b9T5eGcI1AILYtt/G6CaL/AGbQ
a7YNyOWvHDoIEzmGcF+KNwIKPmyJpOfordz+idJPTC9SkXvHo7qqPn/tAeR2gfuG
9j4AarTx3iajfvcfbgPlTBMgu6ZnFzZ7kPWM/Hm/CF1pzI1tVnQ=
=j1Dd
-----END PGP SIGNATURE-----

--nextPart6041598.lOV4Wx5bFT--




