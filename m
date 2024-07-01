Return-Path: <linux-pm+bounces-10284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B791E0EC
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67286B2108A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197015E5BC;
	Mon,  1 Jul 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLEz4hs0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600712CDA5;
	Mon,  1 Jul 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841015; cv=none; b=BjeLYLVFE7V19OmqGo/1wFw8aKnUrWuaB2aKfEkNxH5EIlxaqvmMFEHsaflVsArs+K/Aba2WhUyCzYcfE0lyjv4ZOZyLduHuk60Kp2zDBwVaSEFhHxDJF0Kao/PnY6ZpHnnPiA/LFETflbTnUq/ugGD16AgNtAuLyG42MdEjR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841015; c=relaxed/simple;
	bh=m21yC57ODxRD18ht102wHgdmJx5reH2b2U9SZmrgAdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO0Gnnr/fDlcEKarie2TF1HWp7W10jU/WkgG83Uybfrj+OBRff/bOx5RS3/g4K4ftgnFyon8vJTZXjVIT9eaYfBn1n3korOJ2xE9vxK5EAs5qWyqFcpN1kNKuOzqluVBhoyUeQTL540Qyoq5pvxW+127ztZQixrY2o699PfyiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLEz4hs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032B1C4AF0F;
	Mon,  1 Jul 2024 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719841015;
	bh=m21yC57ODxRD18ht102wHgdmJx5reH2b2U9SZmrgAdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MLEz4hs0uwnmXNjh6UZEVdLAEFjN5XrJgNia4Y8kW7zLbri5tgjJ3OdAyeRafogC0
	 ZEVKwuy7sl6O5ak+fiqHoTYETrJYG6VVHAyMh3EaIzn+ZpD8+PsaDXga7REym3eR0l
	 lItVdOczoSV8O94oVkZ9FHrIs57LvT7axkTAHkFIXoBYOC6p04jv3huNh1ziwLS2XU
	 Jqr3cfyNjGoNtz2yrg9a3QPJnWUsSMWRWz1STBTe8pDflisR4mhXs6wYJ3H6UQnnrP
	 1fwWNEoujsArp3w1e3YOeUz1LWQFm9tpeYQzJTh4IE19vx56veLJqki3jM4RZcWQqL
	 Uk77DDt3HO/oA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1b6b6b2c5so162625b6e.0;
        Mon, 01 Jul 2024 06:36:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5EH66WMW3Br6d/dmY1XRsKdIW5PeFEptsoNXQIyxre4FizECISjY/sogPhOMeeCkCb4APgSnM8YotpLKujXa6bo1PbDLNqTbwd3z/bKaR+ES20aMW2bWEgVOOd7IRqvyhqHBioOXSh3s/XA3TpJ9o1TexnxZ2MJyQKOBIMteyD9T0
X-Gm-Message-State: AOJu0YwyPt9p0ZmDc37B0rBBdN5drSe5i90GbCNxnfhyDyz/PKBwxwwa
	k7To6VjZzmzmlzBf+0ToYrCpyiUquwWePEtoL9+DqvrdVDfF7aZwNaFygc0oYnG42EbLRH/kZq4
	mTMOIVGi4uoY6HpoGe60TksbeIxM=
X-Google-Smtp-Source: AGHT+IGfsKotb9gnIdhj3JmpJC0jYUdmWS2sE093ZBw73pp67hENAcBGajrOdwvPfXRjrZzdEDaD6sEB9pUF62Ygmyw=
X-Received: by 2002:a05:6870:a349:b0:254:d417:34ff with SMTP id
 586e51a60fabf-25db3630354mr5461561fac.4.1719841014236; Mon, 01 Jul 2024
 06:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com> <f78d50e2-cda5-48a6-b591-96218bd83e2b@linaro.org>
In-Reply-To: <f78d50e2-cda5-48a6-b591-96218bd83e2b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 15:36:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g925BYOqiz5RWAc-wDtjpgTA4tw8Mo+ubJSRssgx6eLg@mail.gmail.com>
Message-ID: <CAJZ5v0g925BYOqiz5RWAc-wDtjpgTA4tw8Mo+ubJSRssgx6eLg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:17=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 28/06/2024 15:56, Rafael J. Wysocki wrote:
> > On Thu, Jun 27, 2024 at 10:55=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Currently the thermal framework has 4 trip point types:
> >>
> >> - active : basically for fans (or anything requiring energy to cool
> >>    down)
> >>
> >> - passive : a performance limiter
> >>
> >> - hot : for a last action before reaching critical
> >>
> >> - critical : a without return threshold leading to a system shutdown
> >>
> >> A thermal zone monitors the temperature regarding these trip
> >> points. The old way to do that is actively polling the temperature
> >> which is very bad for embedded systems, especially mobile and it is
> >> even worse today as we can have more than fifty thermal zones. The
> >> modern way is to rely on the driver to send an interrupt when the trip
> >> points are crossed, so the system can sleep while the temperature
> >> monitoring is offloaded to a dedicated hardware.
> >>
> >> However, the thermal aspect is also managed from userspace to protect
> >> the user, especially tracking down the skin temperature sensor. The
> >> logic is more complex than what we found in the kernel because it
> >> needs multiple sources indicating the thermal situation of the entire
> >> system.
> >>
> >> For this reason it needs to setup trip points at different levels in
> >> order to get informed about what is going on with some thermal zones
> >> when running some specific application.
> >>
> >> For instance, the skin temperature must be limited to 43=C2=B0C on a l=
ong
> >> run but can go to 48=C2=B0C for 10 minutes, or 60=C2=B0C for 1 minute.
> >>
> >> The thermal engine must then rely on trip points to monitor those
> >> temperatures. Unfortunately, today there is only 'active' and
> >> 'passive' trip points which has a specific meaning for the kernel, not
> >> the userspace. That leads to hacks in different platforms for mobile
> >> and embedded systems where 'active' trip points are used to send
> >> notification to the userspace. This is obviously not right because
> >> these trip are handled by the kernel.
> >>
> >> This patch introduces the 'user' trip point type where its semantic is
> >> simple: do nothing at the kernel level, just send a notification to
> >> the user space.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
> >>   drivers/thermal/thermal_core.c                            | 8 ++++++=
++
> >>   drivers/thermal/thermal_of.c                              | 1 +
> >>   drivers/thermal/thermal_trace.h                           | 4 +++-
> >>   drivers/thermal/thermal_trip.c                            | 1 +
> >>   include/uapi/linux/thermal.h                              | 1 +
> >>   6 files changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.y=
aml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> index 68398e7e8655..cb9ea54a192e 100644
> >> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> @@ -153,6 +153,7 @@ patternProperties:
> >>                 type:
> >>                   $ref: /schemas/types.yaml#/definitions/string
> >>                   enum:
> >> +                  - user     # enable user notification
> >>                     - active   # enable active cooling e.g. fans
> >>                     - passive  # enable passive cooling e.g. throttlin=
g cpu
> >>                     - hot      # send notification to driver
> >> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
> >> index 2aa04c46a425..506f880d9aa9 100644
> >> --- a/drivers/thermal/thermal_core.c
> >> +++ b/drivers/thermal/thermal_core.c
> >> @@ -734,6 +734,14 @@ int thermal_bind_cdev_to_trip(struct thermal_zone=
_device *tz,
> >>          if (tz !=3D pos1 || cdev !=3D pos2)
> >>                  return -EINVAL;
> >>
> >> +       /*
> >> +        * It is not allowed to bind a cooling device with a trip
> >> +        * point user type because no mitigation should happen from
> >> +        * the kernel with these trip points
> >> +        */
> >> +       if (trip->type =3D=3D THERMAL_TRIP_USER)
> >> +               return -EINVAL;
> >
> > Maybe print a debug message when bailing out here?
> >
> > A check for "user" trips would need to be added to
> > thermal_governor_trip_crossed() and to the .manage() callbacks in the
> > power allocator, step-wise and fair-share governors, if I'm not
> > mistaken.  Especially fair-share and power allocator should not take
> > them into account IMV.
>
> I'm not sure the power_allocator needs to change anything. The trip
> point used is switch_on which is only derived from passive or active
> trip point, so it is not possible to have a user trip point used in the
> manage callback.

OK, it checks for "active" specifically.

> Did I miss something ?

No, I don't think so.

