Return-Path: <linux-pm+bounces-29860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92546AEEA5F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 00:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0353E1D43
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82995290BB4;
	Mon, 30 Jun 2025 22:30:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAF28F514
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322603; cv=none; b=B6rgOM7vDCnOpeLNBBx0dUFTIl8xILMBbIuiYLzKT4+t2gfCeGWxOpGEMbDKZLgQuNDExG65XZoP6E69VKqcu7cdqhOuDoEaBBeWM3ulqd1G7VIlZeDVVejnikHwKTBkqb/RCxj4FonjPDfS5O+Ic72okwRSvlrJhJ3F8A+eKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322603; c=relaxed/simple;
	bh=egHzrVlKIuNkOSz6kKYtVbRsEhLtLrrIezCiIWc0ll0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt8JcTsc4vrtNfvgFYBpfQfK2YLVMkV06PZXW/RQJ/Oj5SBelT5c2IHcCwZE9Ile80CVU7uSIiUZNmCuRRnoEbgOkdenB6d5GLMa0hY23/bkvwG8Kq2j02cjorSMXDHZU6sLx5UtkULesRGsIX0u5M066/N9i7ChH4+wac0/bAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Mon, 30 Jun 2025 22:29:46 +0000
To: Armin Wolf <W_Armin@gmx.de>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: Kurt Borja <kuurtb@gmail.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <JQkv2Fxny1LxdvvwhjRdF7tnxhTsZy7cZypJB8vpJeaaCU2-0ZrGW3k7F-HlSEhe-pzVtbCO9TzPE06mvXhs1q6_esONc8jAzgc3Pglq8ak=@benis.se>
In-Reply-To: <77c78beb-84c6-4113-8a32-ba09ab22f098@gmx.de>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com> <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se> <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com> <oZxsMVf4IphclLjVLbrpp1rHYXlgWYV7BXDzgP40QKiHSOUtVDtDwP_s2uKFel3aLTZyIh-KepV7MjdSN_MkRWpn1_v55BEs0MEVyhKK0fU=@benis.se> <bf9475d3-9131-4d4f-af05-411fdd4f032f@gmx.de> <j_p1hHcOXyva0UEpg4sTPqgLids8s32HxY2oYcpt1rX32spMMOhufyHwscBnt0HqL4ERznsS92ob9KViB1WWEk8wg7VHwNyRV5PO-3ssHOk=@benis.se> <77c78beb-84c6-4113-8a32-ba09ab22f098@gmx.de>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 8189cb91c4169d1bcaa5e21c14e7bbc9aa7a6d6b
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





Best regards,
Benjamin Hasselgren-Hall=C3=A9n


On Monday, 30 June 2025 at 16:50, Armin Wolf <W_Armin@gmx.de> wrote:

> Am 30.06.25 um 14:46 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>=20
> > On Monday, 30 June 2025 at 14:39, Armin Wolf W_Armin@gmx.de wrote:
> >=20
> > > Am 30.06.25 um 14:32 schrieb Benjamin Hasselgren-Hall=C3=A9n:
> > >=20
> > > > Best regards,
> > > > Benjamin Hasselgren-Hall=C3=A9n
> > > >=20
> > > > On Saturday, 28 June 2025 at 02:45, Kurt Borja kuurtb@gmail.com wro=
te:
> > > >=20
> > > > > On Fri Jun 27, 2025 at 5:49 PM -03, Benjamin Hasselgren-Hall=
=C3=A9n wrote:
> > > > >=20
> > > > > > Hi Kurt,
> > > > > >=20
> > > > > > I do not experience the same error messages as in the bug repor=
t - no error message at all. It respons to changing power profile without a=
ny errors.
> > > > > > I also tried 6.12 but same behaviour as 6.15.3 (just getting so=
me gpu glitches - problably because of Lunar Lake).
> > > > > > Can you paste the output of `cat /sys/firmware/acpi/platform_pr=
ofile` on
> > > > > > Linux v6.12?
> > > > > > cat /sys/firmware/acpi/platform_profile_choices
> > > > > > cool quiet balanced performance
> > > > > > cat /sys/firmware/acpi/platform_profile
> > > > > > cat: /sys/firmware/acpi/platform_profile: Invalid argument
> > >=20
> > > Good, it seems that the firmware returns additional data when queryin=
g the current platform profile.
> > > As the driver does not mask-out this data, he cannot determine what k=
ind of platform profile is currently
> > > selected and thus returns -EINVAL.+
> > >=20
> > > I can provide you with an experimental patch, could you test that?
> > > Yes! I am trying to compile 6.16-rc3 atm and the first time I am doin=
g this, but I will happily test a patch.
>=20
>=20
> Alright, i attach the experimental patch. Please note that this might not=
 fully solve the problem, because the
> driver also needs support for the additional platform profiles available =
on your machine.

I think I managed to patch a kernel that I installed. No performance change=
.=20

Then I also tried=20
cat /sys/firmware/acpi/platform_profile
on a non-patched kernel and I get the result (balanced) on kernel 6.15 (but=
 not on 6.12).=20

Dunno what to do with this tho? What have we learned?


>=20
> However after setting the platform profile the driver should be able to r=
ead the current platform profile setting
> without any errors.
>=20
> Thanks,
> Armin Wolf
>=20
> > > Thanks,
> > > Armin Wolf
> > >=20
> > > > > > I am trying to understand how power profiles work - I guess on =
a high level it's controlled by uefi and the profile is set by the OS? Or i=
s it more complicated than that?
> > > > > > Yes, as quick overview. Power profiles are usually a capability=
 of
> > > > > > individual devices. Drivers of these devices expose this profil=
es to
> > > > > > userspace through some predefined interfaces. Then your DE envi=
roment
> > > > > > exposes this to you.
> > > > >=20
> > > > > KDE and Gnome use power-profiles-daemon. This program controlls m=
ainly
> > > > > two kernel interfaces: CPUFreq and platform-profile (there may be=
 more).
> > > > >=20
> > > > > You can read about CPUFreq here [1], although I don't know much a=
bout
> > > > > it. The platform-profile interface may be used by any platform dr=
iver -
> > > > > in your case this is the hp-wmi driver.
> > > > >=20
> > > > > This driver exposes some firmware defined profiles to sysfs troug=
h the
> > > > > following paths.
> > > > >=20
> > > > > /sys/firmware/acpi/
> > > > > /sys/class/platform-profile/
> > > > >=20
> > > > > You won't find the latter in the Linux LTS version though. You wi=
ll find
> > > > > documentation on these paths here [2] and [3] respectively.
> > > > >=20
> > > > > PD: Please, avoid top-posting in kernel mailing lists, interleave=
d style
> > > > > is very much preferred [4].
> > > > >=20
> > > > > [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
> > > > > [2] https://docs.kernel.org/admin-guide/abi-testing-files.html#ab=
i-file-testing-sysfs-platform-profile
> > > > > [3] https://docs.kernel.org/admin-guide/abi-testing-files.html#ab=
i-file-testing-sysfs-class-platform-profile
> > > > > [4] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
> > > > >=20
> > > > > --
> > > > > ~ Kurt

