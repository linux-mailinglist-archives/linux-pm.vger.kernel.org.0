Return-Path: <linux-pm+bounces-29839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C95AEDCCA
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02A81899C05
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904E242D83;
	Mon, 30 Jun 2025 12:31:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C532F1FE6;
	Mon, 30 Jun 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286689; cv=none; b=ogQiboVR4Pil28c8sI5GtWbc22FUHRbRG8mB07PkwyB3vv7waDz+ejglYENiWq6uDqtYw33DOimB1o7JEh1KLTnefOtio+SoeYDIPD5SM/m/dJI3YiHmet0bJ7MULTYmGGM866xMBHO+g4/Pr/xChtSgGJogN8qF1NZljXZXet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286689; c=relaxed/simple;
	bh=dU7GGXFIfaPTQQofUlvHwdBqJ9f+t3bWDI3an8Jy6TM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GggsJmmwq9DMrv0/2cdWWHSl7k0SElHamx2frx9IgpZX5uAVsgrNpUyemwbH25aH0xGTGlc8N06bg8YoPk/CeVqjaCeg8Bjh10gvBEz8iDq9cG5ouANudD2A8Jrk4Vl5PdyFucW7WevhWiG4iQB6G5H8AtrHBUoyMT40IAw8tCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Mon, 30 Jun 2025 12:31:13 +0000
To: Armin Wolf <W_Armin@gmx.de>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: Kurt Borja <kuurtb@gmail.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <ODTjSMb7txgGF_gfWq-zWlEhygUDgdi8hu5piyxj8IT0eCmCVZKA7cvlE1jW4bWY970L1dXXvkkbBg1-cWBg2NEwmm3vCn8zs_O25417ZbA=@benis.se>
In-Reply-To: <032bba69-7f74-4181-9398-d9d370195bd0@gmx.de>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com> <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se> <ilIo-AIjpnkWmahXpgmQeK_6mFWl5s7x7jf0qSdGlpHSGMK1KJDdFjKLQ3t--U-cEUKtpx7s49njQx1I_nU100aE_ca4frY50L4miN8LCks=@benis.se> <032bba69-7f74-4181-9398-d9d370195bd0@gmx.de>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 40a349eed958f48226b5ef011aa58d0691d89276
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable




On Saturday, 28 June 2025 at 02:40, Armin Wolf <W_Armin@gmx.de> wrote:

> Am 27.06.25 um 23:56 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>=20
> > One more thing: I noticed this during boot (before entering password fo=
r disk encryption)
> > https://drive.benis.se/s/5wMkEMKs6SELQzt
> >=20
> > Thermal trip point bug and other stuff, might be something?
>=20
>=20
> Yes, it seems the trip code AML code try to access an array called CUZO t=
hat is only initialize
> inside a ACPI control method called _WAK. Since _WAK is only called when =
the system wakes from
> a sleep state CUZO remains initialized and thus causes this error.
>=20
> Can you check if a BIOS update is available for your device?

I have the latest bios for my device.


>=20
> Thanks,
> Armin Wolf
>=20
> > Best regards,
> > Benjamin Hasselgren-Hall=C3=A9n
> >=20
> > On Friday, 27 June 2025 at 22:49, Benjamin Hasselgren-Hall=C3=A9n benja=
min@benis.se wrote:
> >=20
> > > Hi Kurt,
> > >=20
> > > I do not experience the same error messages as in the bug report - no=
 error message at all. It respons to changing power profile without any err=
ors.
> > > I also tried 6.12 but same behaviour as 6.15.3 (just getting some gpu=
 glitches - problably because of Lunar Lake).
> > >=20
> > > I am trying to understand how power profiles work - I guess on a high=
 level it's controlled by uefi and the profile is set by the OS? Or is it m=
ore complicated than that?
> > >=20
> > > Best regards,
> > > Benjamin Hasselgren-Hall=C3=A9n
> > >=20
> > > On Friday, 27 June 2025 at 21:15, Kurt Borja kuurtb@gmail.com wrote:
> > >=20
> > > > Hi all,
> > > >=20
> > > > On Fri Jun 27, 2025 at 2:10 PM -03, Armin Wolf wrote:
> > > >=20
> > > > > Am 26.06.25 um 15:20 schrieb Benjamin Hasselgren-Hall=C3=A9n:
> > > > >=20
> > > > > > Hi again,
> > > > > >=20
> > > > > > dmesg: https://drive.benis.se/s/2crz7zPzkrzaqXN
> > > > > > The following message intrigues me:
> > > > >=20
> > > > > platform_profile: Failed to get profile for handler hp-wmi
> > > > > This might be a regression.
> > > >=20
> > > > This was reported a couple months ago and I completely forgot until=
 I
> > > > saw this thread. See [1].
> > > >=20
> > > > @Benjamin: Can you please check if your power profiles work on Linu=
x
> > > > v6.12 (LTS)?
> > > >=20
> > > > Also try:
> > > >=20
> > > > $ cat /sys/firmware/acpi/platform_profile
> > > >=20
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220008
> > > >=20
> > > > --
> > > > ~ Kurt

