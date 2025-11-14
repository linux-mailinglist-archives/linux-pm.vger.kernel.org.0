Return-Path: <linux-pm+bounces-38077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B23C5F2DA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 21:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFF3F3566EB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9C33C530;
	Fri, 14 Nov 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9uEaNsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE0328623
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151025; cv=none; b=e8itHQlU0qffQLvIfsB95kWjhUdQwzFw0IhmXWh8klmbXv38G5gwpgqV+Cqel9SyKskGHDtg8ebqHM+zQfumR2DmDWgq14O37KyhkLfK/KfbnNVfy5F34mlwWehex3Bh0v657NbFOfjvUhuG7niT2nxeP0xBu9a1a+eOV/4JRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151025; c=relaxed/simple;
	bh=LPm6PfqVS+HQNq47BY1UWiwy4nb6ZzX9sPnVLiugYQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1FM9RpRZbB7IoDxYxqZeQ2WVoTyWypDZ+gNVKSi9fEubfjESG9jiSW0W+cvz6Jeug1my8uYxWwrxeASzrodPno3O17bRO1poFuFNUPmKCFLb3p36qYd5hOCkqwaLOhlJ8gOtpqzClvt6wzY5JVO2zwwL8grMgsfEnaJ7wn3NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9uEaNsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130CAC4CEF5
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763151025;
	bh=LPm6PfqVS+HQNq47BY1UWiwy4nb6ZzX9sPnVLiugYQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S9uEaNsOB2FOR7QGB+85DvKFK2R0HrVbSCXn5VLbmQslpRPObPjH8GnhAzObaJk2j
	 7hRrfD9QNbx0CbmdppNGFFH/+NUoTqaVzQESo9cVByO76a3QaoIorMEEJ3jLkmz0ld
	 4Pm8p93fF2siYamwmp3WUvFPmoa6sXwAzag+dGc9i9jZeZwVPQ+2F5tS/OhFODMWqi
	 FIgPueCpWnotFdM+EnKV/75lp25l5tLi00BiJJgXoCdcsfWXrTpml6Al+vA/RkioEo
	 IiHGP4kVbjPaeG38ZqV6hP5ZBXCTIMbob5Xtvtw3olElNlEwwg0zuGQ7MVOsjrN3LR
	 7ldoR0oG4a4eg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45034dbaaabso1018776b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 12:10:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNiP6mOGGa7YkPJv8nOcuWLzWt0dlrmLS2U1llWR6duKljVpwlMig49BT3SgaHofZbgsnSeabqUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHk+ugojJgv+2316HOyk7O4nqa7hhJ9Ryuh6VV7AH6dSGRN25U
	uRQyoPeKfTd7iD3bnqlxOpBrDWgC+EGOq7Ax+j7cV+ieIrsZ1jnRj51IKXD8KaJGuGy4fNttovG
	tucM/PIKUOKZM2M79QCrEIO12KAPX2Ps=
X-Google-Smtp-Source: AGHT+IFFH74fU0m8yNu9dhSeDlHh4mX442nlh0Lw0FnFpCxwnSfRGR27TojlyGySKj67IfBYzhtz7gF6yShTPm3oGsE=
X-Received: by 2002:a05:6808:5287:b0:44f:76aa:77c5 with SMTP id
 5614622812f47-4509757f28cmr1893769b6e.44.1763151024390; Fri, 14 Nov 2025
 12:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-thermal-device-v1-0-d8b442aae38b@gmx.de> <CAJZ5v0gZ7+i+irhaq2jQpTt++HuVRjqz8==Ov9VmQ9Q1J1TM0w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZ7+i+irhaq2jQpTt++HuVRjqz8==Ov9VmQ9Q1J1TM0w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 21:10:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h7vrqMquOgCAiBG1Pe7=mF4XGug6-CUT7=Y5daRDRt6w@mail.gmail.com>
X-Gm-Features: AWmQ_bl3CQH1ff7xqQBE-I5XpqYT5kAShE24vTwTInBa2JKUZm6P0oNV-U2znIo
Message-ID: <CAJZ5v0h7vrqMquOgCAiBG1Pe7=mF4XGug6-CUT7=Y5daRDRt6w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] thermal: core: Allow setting the parent device of
 thermal zone/cooling devices
To: Armin Wolf <w_armin@gmx.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC list trimmed and I'd rather not use such an extensive one if I were you.

On Fri, Nov 14, 2025 at 1:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Nov 14, 2025 at 4:24=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote=
:
> >
> > Drivers registering thermal zone/cooling devices are currently unable
> > to tell the thermal core what parent device the new thermal zone/
> > cooling device should have, potentially causing issues with suspend
> > ordering
>
> Do you have any examples of this?

Especially for thermal zones.

> > and making it impossible for user space appications to
> > associate a given thermal zone device with its parent device.
> >
> > This patch series aims to fix this issue by extending the functions
> > used to register thermal zone/cooling devices to also accept a parent
> > device pointer. The first six patches convert all functions used for
> > registering cooling devices, while the functions used for registering
> > thermal zone devices are converted by the remaining two patches.
> >
> > I tested this series on various devices containing (among others):
> > - ACPI thermal zones
> > - ACPI processor devices
> > - PCIe cooling devices
> > - Intel Wifi card
> > - Intel powerclamp
> > - Intel TCC cooling
> >
> > I also compile-tested the remaining affected drivers, however i would
> > still be happy if the relevant maintainers (especially those of the
> > mellanox ethernet switch driver) could take a quick glance at the
> > code and verify that i am using the correct device as the parent
> > device.
> >
> > This work is also necessary for extending the ACPI thermal zone driver
> > to support the _TZD ACPI object in the future.
>
> Can you please elaborate a bit here?
>
> _TZD is a list of devices that belong to the given thermal zone, so
> how is it connected to the thermal zone parent?
>
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> > Armin Wolf (8):
> >       thermal: core: Allow setting the parent device of cooling devices
> >       thermal: core: Set parent device in thermal_of_cooling_device_reg=
ister()
> >       ACPI: processor: Stop creating "device" sysfs link
> >       ACPI: fan: Stop creating "device" sysfs link
> >       ACPI: video: Stop creating "device" sysfs link
> >       thermal: core: Set parent device in thermal_cooling_device_regist=
er()
> >       ACPI: thermal: Stop creating "device" sysfs link

This will kind of break things because user space may rely on those, may it=
 not?

> >       thermal: core: Allow setting the parent device of thermal zone de=
vices

For this last change, you need to define what it means for a thermal
zone to have a parent device.  In particular, in what way would a
thermal zone depend on its parent?

> I can only see the first three patches in the series ATM as per
>
> https://lore.kernel.org/linux-pm/20251114-thermal-device-v1-0-d8b442aae38=
b@gmx.de/T/#r605b23f2e27e751d8406e7949dad6f5b5b112067

That's probably because of the excessive CC list.

