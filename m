Return-Path: <linux-pm+bounces-29840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4CAEDCD3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F587A1A25
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186A285053;
	Mon, 30 Jun 2025 12:32:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF222853EB
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286743; cv=none; b=Y2NvilAr/6TxqUfdf3QEpGmPsJc3d+EKqPczCWANkjKKUdDtlnonY3S/jHCCSGsHp43R0CeS/nmgZG4J8bm9xgyXTDBSQCdKtldgoS/baBqujBq2Kzk6eT3vz/axk8S8YPiUFuQR8ahzAO7Jn07rHXu0ZpVO+lnJK2zO19D/maY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286743; c=relaxed/simple;
	bh=OkLZI0+rH5b3dEjix9sT6Vx5EYN7FdRVpujmRfrj6mo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hajpOY3sCsGxv44WESduxD3YnlaCl84Yp+XIL8Z8V52sa2a8XnaKRtPNFSzqzHV0dwVzaZBgcJ6+CKv6f8GUPqYsToi++4UiyPOG7clAZvXLgFLDqimL81yoSHK3pp7ziCLTlC+wGqla4xbZKM/Cbrcp4Qt+0YBWe0nly5auGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Mon, 30 Jun 2025 12:32:05 +0000
To: Kurt Borja <kuurtb@gmail.com>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: Armin Wolf <W_Armin@gmx.de>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <oZxsMVf4IphclLjVLbrpp1rHYXlgWYV7BXDzgP40QKiHSOUtVDtDwP_s2uKFel3aLTZyIh-KepV7MjdSN_MkRWpn1_v55BEs0MEVyhKK0fU=@benis.se>
In-Reply-To: <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com> <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se> <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 44c08f2f9c43b65f81201a07f4709a84738bf68f
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


On Saturday, 28 June 2025 at 02:45, Kurt Borja <kuurtb@gmail.com> wrote:

> On Fri Jun 27, 2025 at 5:49 PM -03, Benjamin Hasselgren-Hall=C3=A9n wrote=
:
>=20
> > Hi Kurt,
> >=20
> > I do not experience the same error messages as in the bug report - no e=
rror message at all. It respons to changing power profile without any error=
s.
> > I also tried 6.12 but same behaviour as 6.15.3 (just getting some gpu g=
litches - problably because of Lunar Lake).
>=20
>=20
> Can you paste the output of `cat /sys/firmware/acpi/platform_profile` on
> Linux v6.12?

cat /sys/firmware/acpi/platform_profile_choices=20
cool quiet balanced performance

cat /sys/firmware/acpi/platform_profile
cat: /sys/firmware/acpi/platform_profile: Invalid argument

>=20
> > I am trying to understand how power profiles work - I guess on a high l=
evel it's controlled by uefi and the profile is set by the OS? Or is it mor=
e complicated than that?
>=20
>=20
> Yes, as quick overview. Power profiles are usually a capability of
> individual devices. Drivers of these devices expose this profiles to
> userspace through some predefined interfaces. Then your DE enviroment
> exposes this to you.
>=20
> KDE and Gnome use power-profiles-daemon. This program controlls mainly
> two kernel interfaces: CPUFreq and platform-profile (there may be more).
>=20
> You can read about CPUFreq here [1], although I don't know much about
> it. The platform-profile interface may be used by any platform driver -
> in your case this is the hp-wmi driver.
>=20
> This driver exposes some firmware defined profiles to sysfs trough the
> following paths.
>=20
> /sys/firmware/acpi/
> /sys/class/platform-profile/
>=20
> You won't find the latter in the Linux LTS version though. You will find
> documentation on these paths here [2] and [3] respectively.
>=20
> PD: Please, avoid top-posting in kernel mailing lists, interleaved style
> is very much preferred [4].
>=20
>=20
> [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
> [2] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-file-t=
esting-sysfs-platform-profile
> [3] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-file-t=
esting-sysfs-class-platform-profile
> [4] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>=20
> --
> ~ Kurt

