Return-Path: <linux-pm+bounces-14586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86597EF69
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C96B1F221FE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83CA19F105;
	Mon, 23 Sep 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="d+CArDqR"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F219E995;
	Mon, 23 Sep 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109827; cv=none; b=aj1JGrUbwEtCNgAEOKSgNDxBTdS4J+hQnucGnAlOnBmoXPfL4puRLnvdBt/ueOIdmDavSpASEfSt8EPxeBxNngufbAwXz3NY7tSb9WzPPYGiFOzQeNpDFViiZKMBaEtJh4SSeCtt36svWQk4B0U/qS7y/0O6ISQMTW8giFJyHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109827; c=relaxed/simple;
	bh=R0WZdlzZBu24b+2R8GP+PjziF2CyfhN0x2PiVR8BH3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCckZMACw3FCAPvl/umZjsgZI5YKG7WidMWkKA0AJqxoP9eXx5DHLbem1BKP4A63TuYuJ8mIJRqgWBpGNtcbFUu/0FvKVuNyJ8cpZVuH96iMGwx7EEK2kHm+qIKlQ+K3NYCLBQuX0pTj7UVlMhQQ4GCRdX3S9Vx6dCU++WwV5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=d+CArDqR; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2D0FC2E0085E;
	Mon, 23 Sep 2024 19:43:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727109821;
	bh=Kjm8vl1DOoDtysvTZm5sJc604YqW2x3SecPQo2a2EBU=;
	h=Received:From:Subject:To;
	b=d+CArDqR6bNqEtslUR3AmiCZbSWsdYH0M7yCIHU2MG5gzUBQ7R2yglLnvux2iZw4L
	 aYnCjzigT0ZYOAlxgM0QaFnBmsI8Iu3l0/bIOmPxZgyjqY88kLUt2fOvo9uOhd/QXD
	 m8x5p4eEb3jk3IBI7IN82/mreRW3l/0wIM2seb90=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2f7528f4658so39763391fa.3;
        Mon, 23 Sep 2024 09:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMhzH/QbDOb1Oc/HeP3lr6lNHyBH256sncqubOCv7LMBa8BZhjXrRq+IOCq+PIfTKNjb8Lcl+2W45McvK6+6R/KM0H@vger.kernel.org
X-Gm-Message-State: AOJu0YwD23I7GjGeotPraqQzhR1xj4VOpkMy4El5gIM4KNKyb5edoQAp
	gEPyj914P9/iR3m8NCz7H0sWt5iKAhtlGyPVb/iVIkvrBO6iCqiGaUbjav5Zsl/ujWcuEw3qZZy
	z1t2iGfQcUcuhB7tcWI2TshMEAlE=
X-Google-Smtp-Source: 
 AGHT+IGc60gL1gOAkHYMYuiHSxR7O5fB1FcmmLzF199/PpWvKj7QS2uBpDdK/69Q+yBUA5rHMyXUjpnAUI95I6YwO/I=
X-Received: by 2002:a2e:b8d3:0:b0:2f7:90b9:7534 with SMTP id
 38308e7fff4ca-2f7cb2f638cmr53385191fa.11.1727109820435; Mon, 23 Sep 2024
 09:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
 <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
 <1eff4036-b785-4737-b919-d67c52efea65@amd.com>
In-Reply-To: <1eff4036-b785-4737-b919-d67c52efea65@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 18:43:28 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
Message-ID: 
 <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <172710982155.20328.10703034457279960078@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> On 9/23/2024 11:15, Antheas Kapenekakis wrote:
> > Does DRM core handle virtual displays like VNC?
> >
>
> You can make use of virtual display connectors in amdgpu.  This is how
> drivers for new ASICs are first developed in emulation and also what's
> used for early hardware bring up.

Microsoft specificies all displays "state where all displays=E2=80=94local =
and
remote, if any=E2=80=94have been turned off"

If any means that no displays =3D no call perhaps. Would be interesting
when designing a system for disabled people though. Given how it
interacts in Windows, I want to say the target here is inactivity.

> > As mentioned in the cover letter, the _DSM specifies both virtual and
> > actual displays.
> >
> > Also, Windows behavior is like a lockscreen. 5 seconds after screen
> > turns off after inactivity, instantly when you press the power button.
> >
> > I tend towards making a sysfs entry. Not sure.
> >
>
> Who would call this sysfs file?  Systemd?  The compositor?  When?
>
> In Linux the compositor is in charge of doing the modesets that involve
> turning on/off the screen.  In most cases if you press the power button
> in Linux systemd-logind picks up the event.  It triggers a behavior
> that's controlled by the logind configuration.  Typically that's turning
> on a lockscreen and/or starting the suspend sequence.

That's where it gets hairy and an area WIndows uniquely does not have
a problem with because the OS is monolithic.

If it were me, yes, systemd would switch the system to the inactive
"Screen Off" state 5 seconds after the system displays are off due to
inactivity. If we are talking about implementing something Modern
Standby-like, then pressing the powerbutton would no longer suspend
the device. Instead systemd would use two tiers of activators like
windows (first tier for "Screen Off", second tier for "Sleep"; right
now there is only one tier that mirrors screen off) and once all those
activators are released, suspend the kernel.

Then it would handle the transition from "Active" to "Screen Off" to
"Sleep" through a sysfs endpoint, with the platform responding by
e.g., lowering TDP and using a different fan curve.

If the kernel is asked to suspend outside of the Sleep state, then it
does the transitions to reach that state and references the quirk
table to avoid racing conditions in manufacturer firmware (not with
the kernel), before it suspends.

> Important to note; it DOESN'T explicitly turn off displays.  If you
> configured it to suspend then displays get turned off as part of the
> kernel suspend sequence (drm_atomic_helper_disable_all).
>
> If it is configured to trigger a lockscreen then the compositor will
> turn off displays after whatever the DPMS configuration is set to.

The problem with a DRM atomic helper is that we cannot control how it
is called and do debouncing. WIndows does debouncing (part of that is
waiting for 5 seconds so that if you move the mouse the call is
skipped). You could have edge conditions that spam the calls.

Antheas

