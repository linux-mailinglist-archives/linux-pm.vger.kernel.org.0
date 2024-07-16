Return-Path: <linux-pm+bounces-11174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3A6932ED3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B728305C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BDE19E7D0;
	Tue, 16 Jul 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ili9IX1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A725761;
	Tue, 16 Jul 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149428; cv=none; b=DJUXvThe9a75dtxxIEPw8w4g1laPdThDHMVCpP58GgimbcBhEqmS/cWuTjE4sU4fz71aGaQNHcM+1gCj0BfessFRsj7U50Wqxnua6yz3YWcqRurhLhgTHz6e+B4V/ALnA/pWWBc9izsotm6X34mfGCySdhbj/+S05zqHTSb7goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149428; c=relaxed/simple;
	bh=MMCx01sQkZXr2bYV8A4ZzgSApVnPCts9ZdziPtO5VtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYI5EnrOqT5wK6updOeqKcrTYwSe02eq99dXLxo3sCjZt7YIODrbm62D4bH7Nw2Bzv2r+pFLbNUPQwsv7vQvUYzaiETz0FFvQ/GJCH8viguLOxIrLFP0KAmvJt+sX09Oth5Oy3liqDqkjzyGbn2VoCZiYkQw8zs6ud6EM79R7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ili9IX1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2432FC4AF0D;
	Tue, 16 Jul 2024 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721149428;
	bh=MMCx01sQkZXr2bYV8A4ZzgSApVnPCts9ZdziPtO5VtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ili9IX1URa9NAUUZ83lvohGbA4JbDFOG+HmR7sfXio6hRLeT1xYs3j0dJ2B2UU8SL
	 eWTcuzf4IQxmcLKkg8BsO5/z4mW6OQZZ9oTju0wci53yk95Ai4mSGqVTB+D5eztsNt
	 Kq280BclDvDZVSD2i7aqye5H52JkL31SOfeKZKqqe22k09/Jm7KklbrMPDJNz1Kjdp
	 c7zW4phMK7tOG98iiycI1mUirfjvvEkfhg8S2MW1B/bbmfYzavbTS/v2dOydm2xsmD
	 YTD7jdbZ9kkXwEQa8cjPt1yhuMIEsMT5z+STVLgrtK9DhDjO3zQclqBudQVBUBDvwA
	 W7ndDP3473tGw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5cd2bfc8915so66333eaf.2;
        Tue, 16 Jul 2024 10:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGArH7Ker7FTazsgMLgcEGVYTl7qH0YueYh/cGA5bTLKAs+A5eTL9LQQL3zfjv2UoKFZvpQpFpXZG5TqpAk41gpEUlp0kDGl+rzrcZJxzwfI1EdP2ZXVsqQ/hIKCrbH/4jVuzIjOU=
X-Gm-Message-State: AOJu0YxhMw8hryrae3VXmC976YeV6mwGV0myAAmBLvMeVIAfAWEz/TVL
	I2lM0OskgZzEJYxctc/DjthX3LEW9CQbz3WcLXVR7bx04k+rAbRQPY9pr2OQaqjisOpCNVXhz0q
	94ILXoWMwTCr54JW5Ug4eN8CruDs=
X-Google-Smtp-Source: AGHT+IHkWjDT44R1OHPFm+DuX3NSMA6mAzhQls9y5Grg44VSDEQoPtwf7ZdP0vQBar5Ai5QfvBPE6BpQRsEBr1wttew=
X-Received: by 2002:a05:6820:1dc5:b0:5c6:6029:1568 with SMTP id
 006d021491bc7-5d3c8f1573dmr20500eaf.0.1721149427315; Tue, 16 Jul 2024
 10:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240716152025.7f935fb0@mir>
 <CAJZ5v0gZ5611KXqfjSZOdjRi7v8num3P-vO82c7LGuS1Ak1=FQ@mail.gmail.com> <12474042.O9o76ZdvQC@natalenko.name>
In-Reply-To: <12474042.O9o76ZdvQC@natalenko.name>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 19:03:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jc5Cm+0ktyLm_0un149xws4dpVQfs4C277PMVqbHi7jw@mail.gmail.com>
Message-ID: <CAJZ5v0jc5Cm+0ktyLm_0un149xws4dpVQfs4C277PMVqbHi7jw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Stefan Lippers-Hollmann <s.l-h@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2024 at 6:38=E2=80=AFPM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hello.
>
> On =C3=BAter=C3=BD 16. =C4=8Dervence 2024 16:04:16, SEL=C4=8C Rafael J. W=
ysocki wrote:
> > On Tue, Jul 16, 2024 at 3:20=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@=
gmx.de> wrote:
> > >
> > > Hi
> > >
> > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > On Tue, Jul 16, 2024 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > > On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <=
s.l-h@gmx.de> wrote:
> > > > > > On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > > > > > > On 2024-07-16, Rafael J. Wysocki wrote:
> > > > > > > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Holl=
mann <s.l-h@gmx.de> wrote:
> > > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-=
Hollmann <s.l-h@gmx.de> wrote:
> > > > > > > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lez=
cano
> > > > > > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafae=
l J. Wysocki wrote:
> > > > > > > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@inte=
l.com>
> > > > > > > > > [...]
> > > > > > > > > > > Silencing the warnings is already a big improvement -=
 and that patch
> > > > > > > > > > > works to this extent for me with an ax200, thanks.
> > > > > > > > > >
> > > > > > > > > > So attached is a patch that should avoid enabling the t=
hermal zone
> > > > > > > > > > when it is not ready for use in the first place, so it =
should address
> > > > > > > > > > both the message and the useless polling.
> > > > > > > > > >
> > > > > > > > > > I would appreciate giving it a go (please note that it =
hasn't received
> > > > > > > > > > much testing so far, though).
> > > > > > > > >
> > > > > > > > > Sadly this patch doesn't seem to help:
> > > > > > > >
> > > > > > > > This is likely because it is missing checks for firmware im=
age type.
> > > > > > > > I've added them to the attached new version.  Please try it=
.
> > > > > > > >
> > > > > > > > I've also added two pr_info() messages to get a better idea=
 of what's
> > > > > > > > going on, so please grep dmesg for "Thermal zone not ready"=
 and
> > > > > > > > "Enabling thermal zone".
> > > > > > >
> > > > > > > This is the output with the patch applied:
> > > > > >
> > > > > > The ax200 wlan interface is currently not up/ configured (syste=
m
> > > > > > using its wired ethernet cards instead), the thermal_zone1 stop=
s
> > > > > > if I manually enable the interface (ip link set dev wlp4s0 up)
> > > > > > after booting up:
> > > > >
> > > > > This explains it, thanks!
> > > > >
> > > > > The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive=
() is
> > > > > premature or it should get disabled in the other two places that =
clear
> > > > > the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> > > > >
> > > > > I'm not sure why the thermal zone depends on whether or not this =
bit
> > > > > is set, though. Is it really a good idea to return errors from it=
 if
> > > > > the interface is not up?
> > > [...]
> > > > > > [   22.033468] thermal thermal_zone1: failed to read out therma=
l zone (-61)
> > > > > > [   22.213120] thermal thermal_zone1: Enabling thermal zone
> > > > > > [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlw=
ifi-PTP, with index: 0
> > > > >
> > > > > Thanks for this data point!
> > > > >
> > > > > AFAICS the thermal zone in iwlwifi is always enabled, but only va=
lid
> > > > > if the interface is up.  It looks to me like the thermal core nee=
ds a
> > > > > special "don't poll me" error code to be returned in such cases.
> > > >
> > > > Attached is a thermal core patch with an iwlwifi piece along the li=
nes
> > > > above (tested lightly).  It adds a way for a driver to indicate tha=
t
> > > > temperature cannot be provided at the moment, but that's OK and the
> > > > core need not worry about that.
> > > >
> > > > Please give it a go.
> > >
> > > This seems to fail to build on top of v6.10, should I test Linus' HEA=
D
> > > or some staging tree instead?
> >
> > No, it's missing one hunk, sorry about that.
> >
> > > [ I will be offline for the next few hours now, but will test it as s=
oon
> > >   as possible, probably in ~9-10 hours ]
> >
> > No worries and thanks for your persistence!
> >
> > >   CC      drivers/thermal/thermal_core.o
> > > drivers/thermal/thermal_core.c: In function 'handle_thermal_trip':
> > > drivers/thermal/thermal_core.c:383:37: error: 'THERMAL_TEMP_INIT' und=
eclared (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
> > >   383 |             tz->last_temperature !=3D THERMAL_TEMP_INIT) {
> > >       |                                     ^~~~~~~~~~~~~~~~~
> > >       |                                     THERMAL_TEMP_INVALID
> > > drivers/thermal/thermal_core.c:383:37: note: each undeclared identifi=
er is reported only once for each function it appears in
> > > drivers/thermal/thermal_core.c: In function 'thermal_zone_device_init=
':
> > > drivers/thermal/thermal_core.c:432:27: error: 'THERMAL_TEMP_INIT' und=
eclared (first use in this function); did you mean 'THERMAL_TEMP_INVALID'?
> > >   432 |         tz->temperature =3D THERMAL_TEMP_INIT;
> > >       |                           ^~~~~~~~~~~~~~~~~
> > >       |                           THERMAL_TEMP_INVALID
> > >
> >
> > Attached is a new version that builds for me on top of plain 6.10.
> >
>
> This builds and runs fine for me, no dmesg spamming any more. In `sensors=
` I get this:
>
> ```
> iwlwifi_1-virtual-0
> Adapter: Virtual device
> temp1:       -274.0=C2=B0C
> ```
>
> (very beneficial during the heat wave)
>
> There are no "thermal" messages in dmesg whatsoever, any other info you'd=
 like me to provide?

No, thank you, it works as expected.

> Also, feel free to add:
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks!

