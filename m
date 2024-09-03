Return-Path: <linux-pm+bounces-13434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F696A139
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A521F2303E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2715573B;
	Tue,  3 Sep 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M2u3X5t8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32442C6A3
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375185; cv=none; b=BnGySq8UsPw0VB0GqrDCATIkVL8MKhEQmBi/2a+x6+Smeq9NQhVba1/I508jpA0h68G8bqmofoH/KASL70DM9tOf9ahmNARFtzX92sZd6U3JBO6uYPOGipREPmFm2HDwLOb7sfXZvX0+QRhjjxI72lHOGbPYaurLaLZo9bAItOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375185; c=relaxed/simple;
	bh=769AZS6ccmCab8ZrcJRJi8wn/zE+hvP6bFtP/ZJJwV8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePBxoY24R1a5jZ5BKtfs4M5ByHRE+dby3/xGbcbuPkjwf786blVOeO0G3J0Z7drhQyHBQV48E3np0xphtswVMcDrAPXZUiILyxVSgj7rctoNpdt4BEc+emydwHda89nqw/np6LfrY0VXGMTiFIf9FOeRShZ1mpOWgfrDw5vafLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M2u3X5t8; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725375180; x=1725634380;
	bh=fZw2Ch3u5hRZqeAMAyJmjBrhbl+7dgxWe2Pn3GHZBFk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M2u3X5t8kHzTXtAddxfdMZk71bLmYl3ZJ5zA0bE1BVmjFpVaGH8RkkZvzyhhIaeUk
	 eKStOS2LqDmSjSq14P3Y45sETnXLFxkimvfgjw9vkcQpu4rIzq3Vl9wFI0xlOh/idj
	 IMF2HSODQ3Zm1aRO4wUnP3d34JLsuYXxcRo4kuYrrLYE/K9hB9OML0jMXtfmEbPE8/
	 4ewduWu42pT/Qlqtde+t14j9mRbbwMt//I3hogl4QyDa79gejtnQHrnTHCoLnMknRR
	 YyW0DJc0Ym+zSb2RtMlyUZQvyKP1qDdXDbPYSyl9e+d3coloW0xTKjdLeE2+CmGoLK
	 3CkSH7lo7azWA==
Date: Tue, 03 Sep 2024 14:52:54 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: John <therealgraysky@proton.me>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: amd-pstate-epp: CPU freq never hits minimum level booted into OpenWrt but does under Arch
Message-ID: <cJ_RYyxqXiGtT99l77dXTRIbOQEW-i1nAwHunOhkVWKJwm6uzRhSocbqbr60eJjqZc34apTRIq2pK5uyINZvdROB3yNrHPAiVO8uJpI9gfg=@proton.me>
In-Reply-To: <365cb75f-4d47-4e77-a202-ddb171f92004@amd.com>
References: <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me> <CYYPR12MB86554E10C5F1A155B7F049F79C932@CYYPR12MB8655.namprd12.prod.outlook.com> <365cb75f-4d47-4e77-a202-ddb171f92004@amd.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 35f60339530906a70c2cc1b94b840fcb6ef3983f
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you all for the replies and the willingness to help.  I believe that =
the issue is that OpenWrt's kernel is not compiled to be tickless.  Please =
see this PR I sent which changes that[1].  When I build OpenWrt with that P=
R applied, I am able to see the 400 MHz idle just fine.

Since you asked, please find the Arch Linux kernel config[2] and the OpenWr=
t config after applying my PR[3].  If you have any suggestions to modify th=
e OpenWrt config, I am glad to hear them!

1. https://github.com/openwrt/openwrt/pull/16317
2. https://gitlab.archlinux.org/archlinux/packaging/packages/linux-lts/-/bl=
ob/247bbd4865ff5f8d6afa820383c3d025f443ff78/config
3. https://gist.github.com/graysky2/286a298c1619e78778b8f9e780b18088

I unsubscribed to the ML so please cc me on your replies.

On Tuesday, September 3rd, 2024 at 9:32 AM, Mario Limonciello <mario.limonc=
iello@amd.com> wrote:

> Hi John,
>=20
> My first thought is that you might not be enabling amdgpu in OpenWRT.
> If you don't enable amdgpu on an APU then some IPs in the SoC will
> remain initialized to the firmware defaults. So I would start with
> checking this.
>=20
> Something else you could do to confirm it's not a userspace cause is
> compile your arch kernel using your OpenWRT kernel config and confirm it
> replicates or not.
>=20
> If it's not amdgpu and you can't figure it out I agree with Perry's
> suggestion to open a bug report for us to characterize this. Please
> attach kernel configs from both so we can do a scripts/diffconfig to
> understand.
>=20
> Thanks!
>=20
> On 9/2/2024 21:28, Yuan, Perry wrote:
>=20
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >=20
> > Hi John,
> >=20
> > I would like to suggest that you submit a BZ ticket to resolve the issu=
e.
> > Loop Mario and Gautham for help.
> >=20
> > Best Regards.
> >=20
> > Perry.
> >=20
> > > -----Original Message-----
> > > From: John therealgraysky@proton.me
> > > Sent: Tuesday, September 3, 2024 3:21 AM
> > > To: linux-pm@vger.kernel.org
> > > Subject: amd-pstate-epp: CPU freq never hits minimum level booted int=
o
> > > OpenWrt but does under Arch
> > >=20
> > > I have a mini PC based on an AMD Ryzen 7 5800U APU dual booting Arch
> > > Linux and OpenWrt (snapshot). When booted into Arch, the cores idle a=
t the
> > > minimum frequency of 400 MHz with amd-pstate-epp/active. When I boot
> > > into OpenWrt with amd-pstate-epp/active however, the lowest frequency=
 the
> > > cores will drop down to is 1,383 MHz.
> > >=20
> > > As a test, while booted into OpenWrt, I stopped every running daemon =
and
> > > stopped all network interfaces. Checking CPU% in htop showed more or =
less
> > > nothing using the CPU that might be keeping it from reaching 400 MHz.
> > >=20
> > > The kernel version for both distros are in parity (currently 6.6.48),=
 but do differ
> > > in their respective configs. I am wondering if kernel config options =
might be to
> > > causing this or if there is something else that can be checked.
> > >=20
> > > # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> > > powersave
> > > # cat /sys/devices/system/cpu/amd_pstate/status
> > > active
> > > # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
> > > amd-pstate-epp

