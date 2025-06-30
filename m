Return-Path: <linux-pm+bounces-29842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22AAEDD5F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD17189B14D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5524DD10;
	Mon, 30 Jun 2025 12:46:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54331DFF7
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287601; cv=none; b=WEQxW8DbtZ4LzwKu2Qd2KYJakFLCwPJIcIBQAgoeT8LZmmYyBw+vwoeTwgNdDaPqgt8aECWQ//DPiuomn3bNvCnZLPcGgcEPr+sEwfEgzeX+zN1wjpvy6h1SHrDFyHtxbVK0BL1/FPM5c/2mpGP6cukivPMdH+RaMdrqimt9KQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287601; c=relaxed/simple;
	bh=2BVCDvgicPA5NH4rK3hgEquyVFKNjzo603AU5zkTyAY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzXVudyeNqftalZ/Yl/fDVZroACWYuSsvjJX87VwYtXAS7rxlhoYF8IBGKWqfwJOxOanzsb4JQYR6BCbuj+UhX00DaY+yo9Eo3WmDWUOeaDJCvrUqmr98Z9ZwNCHM7AL0IpEBNYNc84GPS8FNI5I15sMS12WhoC5gSEw/pkiVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Mon, 30 Jun 2025 12:46:28 +0000
To: Armin Wolf <W_Armin@gmx.de>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: Kurt Borja <kuurtb@gmail.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <j_p1hHcOXyva0UEpg4sTPqgLids8s32HxY2oYcpt1rX32spMMOhufyHwscBnt0HqL4ERznsS92ob9KViB1WWEk8wg7VHwNyRV5PO-3ssHOk=@benis.se>
In-Reply-To: <bf9475d3-9131-4d4f-af05-411fdd4f032f@gmx.de>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com> <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se> <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com> <oZxsMVf4IphclLjVLbrpp1rHYXlgWYV7BXDzgP40QKiHSOUtVDtDwP_s2uKFel3aLTZyIh-KepV7MjdSN_MkRWpn1_v55BEs0MEVyhKK0fU=@benis.se> <bf9475d3-9131-4d4f-af05-411fdd4f032f@gmx.de>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 34860aa707308950be56b743a07eb1938f38c6fd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Monday, 30 June 2025 at 14:39, Armin Wolf <W_Armin@gmx.de> wrote:

> Am 30.06.25 um 14:32 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>=20
> > Best regards,
> > Benjamin Hasselgren-Hall=C3=A9n
> >=20
> > On Saturday, 28 June 2025 at 02:45, Kurt Borja kuurtb@gmail.com wrote:
> >=20
> > > On Fri Jun 27, 2025 at 5:49 PM -03, Benjamin Hasselgren-Hall=C3=A9n w=
rote:
> > >=20
> > > > Hi Kurt,
> > > >=20
> > > > I do not experience the same error messages as in the bug report - =
no error message at all. It respons to changing power profile without any e=
rrors.
> > > > I also tried 6.12 but same behaviour as 6.15.3 (just getting some g=
pu glitches - problably because of Lunar Lake).
> > >=20
> > > Can you paste the output of `cat /sys/firmware/acpi/platform_profile`=
 on
> > > Linux v6.12?
> > > cat /sys/firmware/acpi/platform_profile_choices
> > > cool quiet balanced performance
> >=20
> > cat /sys/firmware/acpi/platform_profile
> > cat: /sys/firmware/acpi/platform_profile: Invalid argument
>=20
>=20
> Good, it seems that the firmware returns additional data when querying th=
e current platform profile.
> As the driver does not mask-out this data, he cannot determine what kind =
of platform profile is currently
> selected and thus returns -EINVAL.+
>=20
> I can provide you with an experimental patch, could you test that?

Yes! I am trying to compile 6.16-rc3 atm and the first time I am doing this=
, but I will happily test a patch.

>=20
> Thanks,
> Armin Wolf
>=20
> > > > I am trying to understand how power profiles work - I guess on a hi=
gh level it's controlled by uefi and the profile is set by the OS? Or is it=
 more complicated than that?
> > >=20
> > > Yes, as quick overview. Power profiles are usually a capability of
> > > individual devices. Drivers of these devices expose this profiles to
> > > userspace through some predefined interfaces. Then your DE enviroment
> > > exposes this to you.
> > >=20
> > > KDE and Gnome use power-profiles-daemon. This program controlls mainl=
y
> > > two kernel interfaces: CPUFreq and platform-profile (there may be mor=
e).
> > >=20
> > > You can read about CPUFreq here [1], although I don't know much about
> > > it. The platform-profile interface may be used by any platform driver=
 -
> > > in your case this is the hp-wmi driver.
> > >=20
> > > This driver exposes some firmware defined profiles to sysfs trough th=
e
> > > following paths.
> > >=20
> > > /sys/firmware/acpi/
> > > /sys/class/platform-profile/
> > >=20
> > > You won't find the latter in the Linux LTS version though. You will f=
ind
> > > documentation on these paths here [2] and [3] respectively.
> > >=20
> > > PD: Please, avoid top-posting in kernel mailing lists, interleaved st=
yle
> > > is very much preferred [4].
> > >=20
> > > [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
> > > [2] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-fi=
le-testing-sysfs-platform-profile
> > > [3] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-fi=
le-testing-sysfs-class-platform-profile
> > > [4] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
> > >=20
> > > --
> > > ~ Kurt

