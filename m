Return-Path: <linux-pm+bounces-24223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10986A66020
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 22:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3FB16E71E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9C202F96;
	Mon, 17 Mar 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="nxnWmFIV"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACD1FECC6;
	Mon, 17 Mar 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245451; cv=none; b=W+JT6oz/K4SDOdThylDBqgHl9UbuX5mlp3mxuPEBZtEpYaLpaS80H18iS6KCwLMD3OmQ62BSRImRqYPFnG/7ruFwT2ZNJYzamOFsL2BR3Fw5MQrAGsxQB/Eo+rYYDGPinvguMLfGtUQV0ppepr03qCDTbp68Gg4zjCBVt6nTTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245451; c=relaxed/simple;
	bh=ab4IqfsmBi41pyQrA5c7PS8OY31ABv/AuC+v0thYmCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDKRmRQGCFr9Dg6mTYtQHVGmidkY2nkGBWy+Lwzrq9cCdNPSCY3SgAGHBKexoyT1Osa5ZMm3akCdwtvdcK/ySdaBrPBQA0bNTyP3jHPFXapGc9LQ0D7pnrTGVq7FOTzJ1glRkvnQ1vBe1jXgzHfSz5dHLkZMQKqBKNb6IfcfuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=nxnWmFIV; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id E15412E09B0B;
	Mon, 17 Mar 2025 23:04:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742245444;
	bh=alHDLglzbUStpsAUDP4B6mG5jEGQpKMpSRB+Fy88q3s=;
	h=Received:From:Subject:To;
	b=nxnWmFIVO90lxm/cl5qf5oXVuytWQYHf2am5gkUzal6RtBDsS8QcX/OtSRR2uBmMS
	 VUYhqdkv2sA8XXr6XdVTp1ZfYjifYNnK0IPwoAwPjcNtTJPC0dfR/SCqwRorInNWI7
	 8lad6YHAhPeaRVxoksEGXE82Trvk/dZWZ2ViHXP8=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-307c13298eeso56360761fa.0;
        Mon, 17 Mar 2025 14:04:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU7zDDu5U7tppats1ko5zj3CmeBAgfoLYd3/u+DRN9eckH25f2cSTfRfuQours4r/8EM96MJfre4mM=@vger.kernel.org,
 AJvYcCUqQ68c+QX5+c/oLLxBW1QLYe5qFp5rUy1/WqxtvrvqMatmsBKTZK3gjz4ytvlqXY4LcFOE41hqF6Q=@vger.kernel.org,
 AJvYcCV3PKUWjtif2jmtAcT7dmZP+HKJU3/6R+3y6VsdOrNmtxyunAFlSkwPJvPH9bimsFhEX3k6nsL0XsMb5jg=@vger.kernel.org,
 AJvYcCXvLksMZBZb3NcvRiXvzHRGL7pa6sRMdvg5chcvsgz3Jej/sJd/W/K+iV5re+YZp8LGoPCchLDrVVc+UYQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXt3ZayXsY8nSF4yrBSUaqd0IrB28Ol/DmR/XpIGM9uFr3qaD
	ddUtS5c2UMMnC/Hv7mIsUxjMCk/0Rgyw6Eyo6R7E8xDDcS/5cP+Dw0U3ojsFc543vfmWdf6QSPO
	zNkMj96DrjOgt/KxfiKXoghuctT4=
X-Google-Smtp-Source: 
 AGHT+IE3WcqxgOVNvvgT6N80/11W/VjFGG4CkxrhiN22EBJFREh2NPKRLD++qTaeSUY6xou5Mx8u8oNIutJF9jXELM8=
X-Received: by 2002:a2e:8e95:0:b0:30b:ee7d:1a88 with SMTP id
 38308e7fff4ca-30cd95eff6amr8898941fa.10.1742245441545; Mon, 17 Mar 2025
 14:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-14-lkml@antheas.dev>
 <ce0727b4-bf47-4dc7-9103-d87d88a0e213@t-8ch.de>
 <CAGwozwEqjoW-6J8rzm9HcJ0W1DVvzzPkPRzsKZE62gk3Q1ewSA@mail.gmail.com>
 <a764ce58-27a8-44f1-b60e-c6a6d4233977@t-8ch.de>
In-Reply-To: <a764ce58-27a8-44f1-b60e-c6a6d4233977@t-8ch.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 17 Mar 2025 22:03:50 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG90y99x=B9wKOmOVttLEskhMDrWGquE5ujwxoRYVuPUQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrk6qsDS2fQycZIn5Xkedg-wEukNfPbAoavo73DZmkYOeZAEsTn_O3L7a0
Message-ID: 
 <CAGwozwG90y99x=B9wKOmOVttLEskhMDrWGquE5ujwxoRYVuPUQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org, sre@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174224544413.7327.12689648841011406555@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 17 Mar 2025 at 22:02, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> On 2025-03-17 19:20:46+0100, Antheas Kapenekakis wrote:
> > On Mon, 17 Mar 2025 at 19:13, Thomas Wei=C3=9Fschuh <linux@weissschuh.n=
et> wrote:
> > > On 2025-03-17 16:53:49+0100, Antheas Kapenekakis wrote:
>
> > > > @@ -60,6 +61,7 @@ enum oxp_board {
> > > >  };
> > > >
> > > >  static enum oxp_board board;
> > > > +static struct device *oxp_dev;
> > >
> > > Using a global variable is ugly.
> > > An explicit parameter passed through
> > > battery_hook_register() -> add_battery()
> > > would be nicer.
> > > It would require changes to the core code and all its users, though.
> >
> > I debated doing this. Unfortunately, this driver uses a global
> > variable already (see board), so introducing a struct here seemed a
> > bit excessive.
> >
> > During a refactor, removing the board global variable would introduce
> > a features struct, which can then be used for the battery hook.
> >
> > So I think they should be done together in a future series.
>
> Fine by me.
>
> <snip>
>
> > > > +static int oxp_add_battery(struct power_supply *battery, struct ac=
pi_battery_hook *hook)
> > > > +{
> > > > +     /* OneXPlayer devices only have one battery. */
> > > > +     if (strcmp(battery->desc->name, "BAT0") !=3D 0 &&
> > > > +         strcmp(battery->desc->name, "BAT1") !=3D 0 &&
> > > > +         strcmp(battery->desc->name, "BATC") !=3D 0 &&
> > > > +         strcmp(battery->desc->name, "BATT") !=3D 0)
> > > > +             return -ENODEV;
> > >
> > > If they only have one battery, why is the check necessary?
> >
> > Leftover from when I modelled the battery hook from asus-wmi. If the
> > battery hook only runs for system batteries and not e.g., for
> > peripherals, I will remove this.
>
> The battery hook runs for all batteries discovered through ACPI.
> These should only be system batteries.
>
> > > > +
> > > > +     return power_supply_register_extension(battery, &oxp_psy_ext,=
 oxp_dev, NULL);
> > > > +}
> > > > +
> > > > +static int oxp_remove_battery(struct power_supply *battery, struct=
 acpi_battery_hook *hook)
> > > > +{
> > > > +     power_supply_unregister_extension(battery, &oxp_psy_ext);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static struct acpi_battery_hook battery_hook =3D {
> > > > +     .add_battery =3D oxp_add_battery,
> > > > +     .remove_battery =3D oxp_remove_battery,
> > > > +     .name =3D "OneXPlayer Battery",
> > >
> > > This struct can also be aligned.
> >
> > Can you expand on that?
>
> It is about lining up the "=3D" characters all in one vertical line.
> Same as in oxp_psy_ext;

I am mixing up my spaces and my tabs. What is the canonical way to
render tabs so I can make sure they are aligned?

> <snip>

Thanks,
Antheas

