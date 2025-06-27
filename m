Return-Path: <linux-pm+bounces-29710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CEAEC15C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B37170DD1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D81D79BE;
	Fri, 27 Jun 2025 20:45:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB419597F
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057136; cv=none; b=j1qA2zW5PmfxwcA0ZBcOqcUEt/0aS5JZAfkjSuWDwCIiQLugNtiEeLqZWs8KC3mRnHi3QMwTBILqIgTmQ+bz6dvHdIj4x0lKO6Dg4XG5lnT9aLEJQue28MgF0YG8QFvY/ANH9slMkbS06HxwLjkxDknq/W6C1yHga7Rq+JEVHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057136; c=relaxed/simple;
	bh=WGG0ELSSGfQb5GW1CIg+EOgVf53HzFDC2LIRtyH4PIM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5lyxxnbOW9YNX2a4NuWHC20DmjLOS2k/M41iQ6hfImHNsqeONOz2koN8sM/EqkQOi24iiVkwLfRsA4FNAKEJ4vxXNK7nd2ZJG2jEjUrHgxqQZ4WBEAsqQFKbcCKfZToTzZVmjPk8FHT/CJItawBbChDMBv0D/jYaPqp0+yjSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Fri, 27 Jun 2025 20:45:22 +0000
To: Armin Wolf <W_Armin@gmx.de>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <IOHmEyRrtQvRrrb8x5tIvlcq13fuJs70jSiNRpuj25c4Pu0-57XXgjgKf8RAiCuHifj5RudJKDWLwLqnHFYm3CFtdJi1lFHW0Z2kyu-apVg=@benis.se>
In-Reply-To: <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de> <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 04ef23a80377720ff0bce4ce2c3ca064323c7da7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Not sure what sysfs means?=20

/sys/firmware/acpi# cat platform_profile_choices=20
cool quiet balanced performance

I don't know how to read the error message for not loading hp-wmi, can you =
guide me?



Best regards,
Benjamin Hasselgren-Hall=C3=A9n


On Friday, 27 June 2025 at 19:10, Armin Wolf <W_Armin@gmx.de> wrote:

> Am 26.06.25 um 15:20 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>=20
> > Hi again,
> >=20
> > dmesg: https://drive.benis.se/s/2crz7zPzkrzaqXN
>=20
>=20
> The following message intrigues me:
>=20
> platform_profile: Failed to get profile for handler hp-wmi
>=20
> Can you tell me the exact error message that is returned when reading the=
 platform profile over sysfs?
>=20
> > So I tested thermald again. So here are some results.
> >=20
> > Before:
> > Running Valheim the power draw is 35w and the fps is 41.
> >=20
> > After I have installed thermald:
> > Running Valheim the power draw is 44w and the fps is 46
> >=20
> > So it's working, but I also noticed that it doesn't matter if I change =
the power profile. Same performance and power draw. So something is still w=
eird.
>=20
>=20
> The ACPI code seems to suggest that your device support 7 profiles, while=
 the hp-wmi driver only supports 4. Additionally the drivers fails
> to properly mask out the platform profile value returned by the firmware,=
 so that could be the reason why it is not working on your device.
>=20
> Can you test kernel patches?
>=20
> > Also the bug with the fun still running while the laptop is suspended i=
s an issue.
>=20
>=20
> I CCed the people from the thermal subsystem, maybe they know if this is =
expected behavior or a bug inside the int340x_thermal driver.
>=20
> Thanks,
> Armin Wolf
>=20
> > Thank you very much for your guidance Armin!
> >=20
> > Best regards,
> > Benjamin Hasselgren-Hall=C3=A9n
> >=20
> > On Wednesday, 25 June 2025 at 23:43, Armin Wolf W_Armin@gmx.de wrote:
> >=20
> > > Am 25.06.25 um 23:22 schrieb Benjamin Hasselgren-Hall=C3=A9n:
> > >=20
> > > > The laptop do complain about not being able to load hp-wmi during b=
oot. Same on Fedora 42 as on Debian 13 (with kernel 6.15).
> > >=20
> > > Can you share the output of dmesg?
> > >=20
> > > > I did install thermald and that might have increased the power budg=
et (which is good) - but introduced some bug that keeps the fans on even wh=
ile suspended.
> > >=20
> > > Please elaborate.
> > >=20
> > > Thanks,
> > > Armin Wolf
> > >=20
> > > > Best regards,
> > > > Benjamin Hasselgren-Hall=C3=A9n
> > > >=20
> > > > On Wednesday, 25 June 2025 at 15:44, Armin Wolf W_Armin@gmx.de wrot=
e:
> > > >=20
> > > > > Am 25.06.25 um 10:06 schrieb Benjamin Hasselgren-Hall=C3=A9n:
> > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > The acpidump is here: https://drive.benis.se/s/pcKLAL7i8zncX8q
> > > > > >=20
> > > > > > Best regards,
> > > > > > Benjamin Hasselgren-Hall=C3=A9n
> > > > > > The hp-wmi driver should be able to control the platform profil=
e on your device. Does this
> > > > > > driver load and register a platform profile handler?
> > > > >=20
> > > > > Additionally you might need to install and setup the intel therma=
l daemon for the platform
> > > > > profile settings to work.
> > > > >=20
> > > > > Thanks,
> > > > > Armin Wolf
> > > > >=20
> > > > > > On Monday, 23 June 2025 at 20:52, Armin Wolf W_Armin@gmx.de wro=
te:
> > > > > >=20
> > > > > > > Am 23.06.25 um 15:52 schrieb Benjamin Hasselgren-Hall=C3=
=A9n:
> > > > > > >=20
> > > > > > > > Hi dear Linux friends,
> > > > > > > >=20
> > > > > > > > This is very much a long shot and I understand if no one go=
t any time or motivation for this.However, I am trying to understand how HP=
 Omnibook Ultra Flip (a laptop with Lunar Lake platform) working with power=
 profiles. The reason is that it seems to be very limited while running Lin=
ux (to 30 watts to be exact, no matter the power profile, this is for the w=
hole laptop, to compare with something the Omnibook Ultra 14 with AMD Strix=
 draws up to over 70 watts, sure more power hungry platform but still). Als=
o the gpu performance is not as it should be.
> > > > > > > > So if anyone got the time or so - let me know where to star=
t digging!
> > > > > > > >=20
> > > > > > > > Best regards,
> > > > > > > > Benjamin Hasselgren-Hall=C3=A9n
> > > > > > > > Can you share the output of "acpidump"?
> > > > > > > > Thanks,
> > > > > > > > Armin Wolf

