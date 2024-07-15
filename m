Return-Path: <linux-pm+bounces-11096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F679312A1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC231F20EEE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552C188CC7;
	Mon, 15 Jul 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR30q+cs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3FC18411C;
	Mon, 15 Jul 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040794; cv=none; b=SayN3PjUVqkJIyJuZNha1P3JBASQ1IoZWx+U5kTnJJpKY+GSOZZP7ZEHHDmkVrL3+6hJ24dE+/81Aj2yRQltNHvvxccR7HyOoBUAJuUQaAQRHOVqfxogBvZp2cANN33wZeS3wT7Hi270EQsWrcEl88GebJKTL6CfeEBETJ84zVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040794; c=relaxed/simple;
	bh=go1RKdeWevmqlzJcj+0SmBE1i8gOi6uPq998XQXL1vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJloEx8dBr4DNStTiugd+egw0EVpE1/lVc4PAVvjOfmz9esQjJ5W5hHtvUuhv89K+rzjSpQRRVY5tL/AYUYAlQ6aWdIptDb/y5FGlyDCnaqIllGTVs77GfAv9rBUPgkXQDK4NlFI3HshtvcfM/VUlCWaWUIHzHDLG1b1kxZelEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR30q+cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8874FC4AF0A;
	Mon, 15 Jul 2024 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721040793;
	bh=go1RKdeWevmqlzJcj+0SmBE1i8gOi6uPq998XQXL1vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nR30q+cs4rFBRHrQyHOahbPpP+cEQfIX73N0QYnyhXX7X50amjFHedLGO049M/USJ
	 IZBoCKvhxfAQwJ8UdknlF5zwxwknlsVbimal5MVv/6g+D209oTEDt1ffQTtwKNu8wN
	 HzApz+athrZE4j4NPEpFd0XSn/kMglwY6SOjRuOnQas67g1G+8sFf9ImWTgMQtfcbc
	 9Li5SimRbki3pbfRV9UdrYwPhRRKM0AkkTcIQI0yFTensmOUvPq6znbU3TbjojEy0a
	 ryvyYVcbD94zVV9L5EktUU0MAXG9xanH0vm3cgHadO3ZDxhyo4u/IKXxdt2TgaQ23x
	 k2q4V+tXNeMlA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e80d68776so573883fac.1;
        Mon, 15 Jul 2024 03:53:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqLSmJoyrGWbt406IEvoEyFSHsf/hTvwIhA0d5OSQqKGknxujmEWZi1makpZAWBi24aPvyX9lBrhdv2X5Nx8Zf8FFtNwt3Qj0eAKCAd1alE+1w52OpEgR+arHhns9/p411SabzNe8=
X-Gm-Message-State: AOJu0YzLnW31NgvrxV+Au33Ln7bOZSW7tMDsRhEf3jGLeIkA/Ls2jlEg
	M/7Pqn8Cayae1r6H0mMefbxE8FNryP0pqCO/WAKxFaOphzkLdkP1hJeIrbXuJ/as38FBKg6Bvxp
	MMJKUOV4YjfRmHoimOy3YBVcIKxM=
X-Google-Smtp-Source: AGHT+IE1nRYX5jYV7UE4UwfWPU1vFbo3Fy2uevt/GfSWI5Xg5ImMvJ8CpEY8MdH+3+KbLcUGvz2nYnAWzACxPo6QfMk=
X-Received: by 2002:a05:6870:d146:b0:25e:180:9183 with SMTP id
 586e51a60fabf-2603abb9762mr10053514fac.4.1721040792760; Mon, 15 Jul 2024
 03:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
 <20240715110659.51b441e2@mir>
In-Reply-To: <20240715110659.51b441e2@mir>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 12:52:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZeAEXXVnqUccOwfu7-WEwAeXwrV-PoE4+BiOVVrOiEg@mail.gmail.com>
Message-ID: <CAJZ5v0iZeAEXXVnqUccOwfu7-WEwAeXwrV-PoE4+BiOVVrOiEg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 11:07=E2=80=AFAM Stefan Lippers-Hollmann <s.l-h@gmx=
.de> wrote:
>
> Hi
>
> On 2024-07-14, Eric Biggers wrote:
> > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip(=
)
> > > if zone temperature is invalid") caused __thermal_zone_device_update(=
)
> > > to return early if the current thermal zone temperature was invalid.
> > >
> > > This was done to avoid running handle_thermal_trip() and governor
> > > callbacks in that case which led to confusion.  However, it went too
> > > far because monitor_thermal_zone() still needs to be called even when
> > > the zone temperature is invalid to ensure that it will be updated
> > > eventually in case thermal polling is enabled and the driver has no
> > > other means to notify the core of zone temperature changes (for examp=
le,
> > > it does not register an interrupt handler or ACPI notifier).
> > >
> > > Also if the .set_trips() zone callback is expected to set up monitori=
ng
> > > interrupts for a thermal zone, it needs to be provided with valid
> > > boundaries and that can only be done if the zone temperature is known=
.
> > >
> > > Accordingly, to ensure that __thermal_zone_device_update() will
> > > run again after a failing zone temperature check, make it call
> > > monitor_thermal_zone() regardless of whether or not the zone
> > > temperature is valid and make the latter schedule a thermal zone
> > > temperature update if the zone temperature is invalid even if
> > > polling is not enabled for the thermal zone (however, if this
> > > continues to fail, give up after some time).
> > >
> > > Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip(=
) if zone temperature is invalid")
> > > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd03=
3fca16@linaro.org
> > > Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.n=
et
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > On v6.10 I'm seeing the following messages spammed to the kernel log en=
dlessly,
> > and reverting this commit fixes it.
> >
> >     [  156.410567] thermal thermal_zone0: failed to read out thermal zo=
ne (-61)
> [...]
> >     [  158.458697] thermal thermal_zone0: failed to read out thermal zo=
ne (-61)
> >
> > /sys/class/thermal/thermal_zone0/type contains "iwlwifi_1".
>
> I am observing the same issue on v6.10 with an Intel ax200 WLAN
> card in a kaby-lake/ i5-7400 system and a Fujitsu D3400-B22
> mainboard and the 'newest' BIOS (V5.0.0.12 R1.29.0) as well:
>
> $ dmesg | grep -i -e iwlwifi -e thermal_zone2
> [    3.692433] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
> [    3.698547] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100=
530 wfpm id 0x80000000
> [    3.698556] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
> [    3.703292] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 8=
9.3.35.37
> [    3.797296] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.=
0 cc-a0-77.ucode op_mode iwlmvm
> [    4.090341] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160M=
Hz, REV=3D0x340
> [    4.090524] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    4.218496] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
> [    4.285399] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
> [    4.341754] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
> [    4.345445] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    4.601400] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    4.857372] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    5.114387] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [...]
> [  143.643801] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [  143.899818] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [  144.155813] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [  144.411815] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [  144.667828] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [  144.923801] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [  145.179822] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [...]

As I said in the reply to the previous report, this thermal zone is
useless and it can be disabled via sysfs.  The message will go away
then.

We'll see what can be done to make the message go away completely or
at least stop being printed after a certain number of iterations.

