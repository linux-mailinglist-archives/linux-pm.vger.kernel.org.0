Return-Path: <linux-pm+bounces-29714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F7AEC178
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333603A74B7
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CBB258CE8;
	Fri, 27 Jun 2025 20:50:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AF1E48A;
	Fri, 27 Jun 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057412; cv=none; b=u9FryltefJOaMurf+GGQA2Licaz4pgYM1UdI9W5y1sf47UuXh8+mmHjgOequHdnin8m5RbRzA6kYWSGr8DZUR+UQin6zLOZc8X+5e5CdXw3p44s992TkOvE8aa4GcGlxrbREwiwGu58J/YRSjXtB5fpn1I3dFh9UWIXoECsw13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057412; c=relaxed/simple;
	bh=14H19cR11NGBgs8VD0gkm0NoBzX0DJXJrULPEtmGD4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJpPLEAFZ33FbFFGN0t1BIelGJVqb42qXTQCT0nxyGAica015Xv0/XDutKvZHsfsvjpgKtaAZtRa7TNjnyS2794dvd/PUVRpYLYejBzsSrKiRPzI8LvwkXLgVYLHn0zWd2DKP/yuk9r23/sGaiprfp92su5S1YHR0/Dl+a+2oks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Fri, 27 Jun 2025 20:49:56 +0000
To: Kurt Borja <kuurtb@gmail.com>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: Armin Wolf <W_Armin@gmx.de>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se>
In-Reply-To: <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de> <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 5df4ea01e5edf5a5d1a3933e1665f0fa2a281b67
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kurt,

I do not experience the same error messages as in the bug report - no error=
 message at all. It respons to changing power profile without any errors.
I also tried 6.12 but same behaviour as 6.15.3 (just getting some gpu glitc=
hes - problably because of Lunar Lake).

I am trying to understand how power profiles work - I guess on a high level=
 it's controlled by uefi and the profile is set by the OS? Or is it more co=
mplicated than that?=20



Best regards,
Benjamin Hasselgren-Hall=C3=A9n


On Friday, 27 June 2025 at 21:15, Kurt Borja <kuurtb@gmail.com> wrote:

> Hi all,
>=20
> On Fri Jun 27, 2025 at 2:10 PM -03, Armin Wolf wrote:
>=20
> > Am 26.06.25 um 15:20 schrieb Benjamin Hasselgren-Hall=C3=A9n:
> >=20
> > > Hi again,
> > >=20
> > > dmesg: https://drive.benis.se/s/2crz7zPzkrzaqXN
> >=20
> > The following message intrigues me:
> >=20
> > platform_profile: Failed to get profile for handler hp-wmi
>=20
>=20
> This might be a regression.
>=20
> This was reported a couple months ago and I completely forgot until I
> saw this thread. See [1].
>=20
> @Benjamin: Can you please check if your power profiles work on Linux
> v6.12 (LTS)?
>=20
> Also try:
>=20
> $ cat /sys/firmware/acpi/platform_profile
>=20
>=20
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220008
>=20
> --
> ~ Kurt

