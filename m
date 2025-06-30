Return-Path: <linux-pm+bounces-29843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E919BAEDD78
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D556218895B8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EB286D7E;
	Mon, 30 Jun 2025 12:49:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5F2868B3;
	Mon, 30 Jun 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287745; cv=none; b=jLOim6tt9Rd1OJ9fb7ZQKYsS0OaICSM6dpGMjvOepio24F0TPre25qIY3voO9qKMao3pS1d94rPFTRzcpXqZH73+0zAcVlqs3bh9Sg8my5u1ePumK+CjykxytoDJ+FVCLhTukVixg7ChbT18ocKwGYfWl/nkEE6pDD8IF0hRrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287745; c=relaxed/simple;
	bh=OEh08LFrHwMvpGzKcfLv3yZIoFhZE9xfxB0Kb3jKY4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqLXnAtSd0wP9qV5edWOx51ZsbJKLolwL7qPMnv6MXi+8OR8kTrBN/45eZCO6RFKfuNF3Ng7NSWZY1h7NGIjMNhWgo+9tl1Wyd/rGXwB7Qpb9aNM7RWj7P4yPv7yhc8yyGBQJYt2zACCNrYA2rA0YeeUswVD6/VIQugaBcKYVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Mon, 30 Jun 2025 12:48:57 +0000
To: "Zhang, Rui" <rui.zhang@intel.com>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: "W_Armin@gmx.de" <W_Armin@gmx.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se>
In-Reply-To: <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de> <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 43a036b81c1cdc96344bff36802964a6ffc2f150
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


On Monday, 30 June 2025 at 03:18, Zhang, Rui <rui.zhang@intel.com> wrote:

> > > So I tested thermald again. So here are some results.
> > >=20
> > > Before:
> > > Running Valheim the power draw is 35w and the fps is 41.
> > >=20
> > > After I have installed thermald:
> > > Running Valheim the power draw is 44w and the fps is 46
> > >=20
> > > So it's working,
>=20
>=20
> Good to know that thermald helps.
>=20
> can you please also attach the turbostat output? say "turbostat -o ts.log
> sleep 1"

https://drive.benis.se/s/KtRtCQXi7mS8GMi=20
There you go. I am compiling the linux kernel atm so the laptop is working =
very hard (I am thinking of logging).

>=20
> > > but I also noticed that it doesn't matter if I change the power
> > > profile. Same performance and power draw. So something is still
> > > weird.
> >=20
> > The ACPI code seems to suggest that your device support 7 profiles,
> > while the hp-wmi driver only supports 4. Additionally the drivers fails
> > to properly mask out the platform profile value returned by the
> > firmware, so that could be the reason why it is not working on your
> > device.
> >=20
> > Can you test kernel patches?
> >=20
> > > Also the bug with the fun still running while the laptop is suspended
> > > is an issue.
> >=20
> > I CCed the people from the thermal subsystem, maybe they know if this
> > is expected behavior or a bug inside the int340x_thermal driver.
>=20
> how do you suspend the system? and can you attach the dmesg output after
> system "suspended" and resumed?

Will test later!

>=20
> thanks,
> rui

