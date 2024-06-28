Return-Path: <linux-pm+bounces-10186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB70291BCD8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0901F22C72
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E315575D;
	Fri, 28 Jun 2024 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPdi+1l1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA24DA0C
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571766; cv=none; b=TF4Jfvq8mtKcfKC/XA0Nif7BQeuhz7XYReFPvkx7CoR1FQCUDqCBE9f0ic+WDayd0c3/7ESNXmF0z9Si2H3kxJRFKQpCF1jkzLQhzVM8hIQcEwq/bgQHKK33CePykzUemJF4ggU5GKSJYJ7zly83LzpX4HyYV5w4CgOZWloqYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571766; c=relaxed/simple;
	bh=8N4TYZQN3YoCP21UZKbO8Huur0lt1pOsz77M3jyK7TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl1rcb4bfTtPAcCJnAm/+0vWnsqxszaHTpbfpogxrMdSumJxD+6nlOwfhozwbP90EV/W0527MBgRPUAjkGFnOPXeqPfgH82ved0CSA/2pDGp3nzuJJZGnY/dO7sNdCBsvJna5NgTNMm4s87ZLTw/+Nag5VPfn+7Ydcx40xxRJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPdi+1l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36184C4AF0A
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719571765;
	bh=8N4TYZQN3YoCP21UZKbO8Huur0lt1pOsz77M3jyK7TY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZPdi+1l1JK0gn3HlLRShKHvbXVdlYuao57+5tD2Td5DBxEFzVRC9+wEX3CDM2Yfou
	 K3xx1UEBUHGzr+m2we4NR8PziczengNN2lxMDj6hM8DVAQkcYwazSXGZtmrqYQrd2b
	 xNR5Z17rPblb5/XxWKegd7KP75JaqTSbvsuFE830WZuqDSmZ2c3IxpRNQl4AFxx72H
	 fEoGyR1G+68JA6AKKiyz0tCjllDJyN4me/adLCgIULz7v0uo4tXzlzByM1LZvOzMMc
	 Y2q/DEtwRppr7b3lkOf8TC2dd3JQM2CWKwg5OSf+xOJlaELB5HFHq1XwvMOhrtn448
	 +S6zazaQI0HLA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d56573277dso12331b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 03:49:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNXltcXlGD/Ft7aHl7EoyOUT7xD+tquYCzOJjN86lfTQ2zOUePaJuaSXMonqcB1Flgk8rYLPvXwMSntGv6LaWMqFehyG9Tgek=
X-Gm-Message-State: AOJu0YwEU4KMd4zIOl1osEq7CpyoBSM8Ck1z3TRq4lCeUOkuchvyIVrR
	cUs7EiPx/k4kxNqFqdQyBEXNKIb9soraBfO6Xx/y9JvsvZZqgFNiVpI4n04piG01PoCNQYuwT5m
	em5brhCVvjXJUvchZjwUU+KnoKrA=
X-Google-Smtp-Source: AGHT+IEqORqAOodN9l3fD73UgRaOyIYBVltbQR9J5NlCuONW/xwt6jBC/PtIuCT/9y5/Qjls0aQwAN/wBtSBz+1nim4=
X-Received: by 2002:a05:6870:b623:b0:254:affe:5a08 with SMTP id
 586e51a60fabf-25cf000314bmr19300884fac.2.1719571764399; Fri, 28 Jun 2024
 03:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org> <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
 <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
 <43ded807-be8d-4673-ab8c-1ed2a5a32077@linaro.org> <CAJZ5v0g0=k4HZhKhs=2iwO8zc=jkng898wF-nn_bUT-xA_iu6w@mail.gmail.com>
 <ff495355-3a9f-422b-b9c8-707f7e35ba43@linaro.org>
In-Reply-To: <ff495355-3a9f-422b-b9c8-707f7e35ba43@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 12:49:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hh0whAL7BEUf=C=q6frcb1xROsBfRinVLdndGCpkddXQ@mail.gmail.com>
Message-ID: <CAJZ5v0hh0whAL7BEUf=C=q6frcb1xROsBfRinVLdndGCpkddXQ@mail.gmail.com>
Subject: Re: Trip points crossed not detected when no cooling device bound
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:04=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/06/2024 20:23, Rafael J. Wysocki wrote:
> > On Thu, Jun 27, 2024 at 6:30=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 27/06/2024 11:54, Rafael J. Wysocki wrote:
> >>> On Thu, Jun 27, 2024 at 12:24=E2=80=AFAM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 26/06/2024 23:21, Daniel Lezcano wrote:
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>>> Oh, I see where the problem can be.  If the zone is polling only, =
it
> >>>>>> will not rearm the timer when the current zone temperature is inva=
lid
> >>>>>> after the above commit, so does the attached patch help?
> >>>>>
> >>>>> At this point, I went far when bisecting another problem and I ende=
d up
> >>>>> screwing my config file. So I had to generate a new one from the de=
fault
> >>>>> config. Since then the issue is no longer happening which sounds ve=
ry
> >>>>> strange to me.
> >>>>>
> >>>>> I'm still investigating but if you have a suggestion coming in mind=
, it
> >>>>> would be welcome because I'm failing to find out what is going on .=
.. :/
> >>>>
> >>>> I finally reproduced the issue. That happens when there is *no* cool=
ing
> >>>> device bound on *any* thermal zones.
> >>>
> >>> Interesting.
> >>>
> >>>> Your patch seems to fix the problem but I'm not sure to understand t=
he
> >>>> conditions of the bug
> >>>
> >>> It's probably the same as for commit 202aa0d4bb53:
> >>> thermal_zone_device_init() sets tz->temperature to
> >>> THERMAL_TEMP_INVALID and if the first invocation of
> >>> __thermal_zone_get_temp() returns an error (because the .get_temp()
> >>> callback returns an error), monitor_thermal_zone().  If polling is th=
e
> >>> only way in which the zone temperature can be updated, things go sout=
h
> >>> because the timer is not set and there is no other way to set it.  No
> >>> updates will be coming
> >>
> >> If there is no polling delay (aka interrupt driven), the routine will
> >> skip the _set_trips function and the monitor_thermal_zone() will do
> >> nothing in this case, right ?
> >
> > _set_trips() looks at tz->temperature, however, and it doesn't make
> > sense to call it if the latter is invalid.
> >
> > Same for handle_thermal_trip() and governor callbacks.
> >
> >> Even setting a label jump to "monitor:" the routine is broken AFAICT
> >
> > I beg to differ.
> >
> > Yes, monitor_thermal_zone() does nothing if there is no polling, but
> > it needs to be called anyway because it checks whether or not polling
> > is there in the first place.
> >
> > And if there is no polling, it is assumed that
> > __thermal_zone_device_update() will be called by other means.
>
> AFAICT, the interrupt can fire and it will result in a
> thermal_zone_device_update() but the interrupt must be setup by
> __set_trips() which is skipped because of the invalid temperature.

Say the zone temperature is invalid and __set_trips() is not skipped.

You'll end up with nonsensical values of "low"  and "high".  Is this OK?

If you rely on __set_trips() to set up the interrupts for you, it
needs to be given a valid zone temperature and trip thresholds.

Some special handling of invalid tz->temperature may be added to it, though=
.

> I've confirmed that with my evb board.
>
>   - trips point
>   - no polling delay (interrupt based)
>   - no cooling device
>
> That does not work, there is no trip crossed notification.

Yes, if the first zone temperature read fails and there are no
interrupts coming to trigger next temperature updates, this is what's
going to happen.

I gather that the fix I sent doesn't help in this case?

I'll send a v2 of it with .set_trips() taken into account.

> >>> The reason why the presence of cooling devices can "fix" this is
> >>> because thermal_bind_cdev_to_trip() sets tz->need_update to 1 which
> >>> then causes the thermal_zone_device_update() in
> >>> __thermal_cooling_device_register() to trigger and that will update
> >>> the temperature.
> >>
> >> IIUC, the first time get_temp() fails and then when the tz is bound, t=
he
> >> update triggers a new call with get_temp() which returns a valid
> >> temperature ?
>
> Ok, I can see another glitch here. Actually the thermal_of is calling
> thermal_of_zone_register() which in turn calls
> thermal_zone_device_enable(). However, the driver can be not fully setup
> yet (eg. rockchip_thermal.c), so it results in an error in get_temp and
> an invalid temperature.
>
> With the aforementioned setup, that leads to a broken thermal platform
> because no trip notification will happen.
>
> All this result in a fragile code :/
>
> That is working only because there is a cooling device bound to the
> thermal zone which happens after the sensor is fully setup.
>
> IMO, we should be much less resilient to .get_temp failing ...

Well, there is one more problem with it which is the handling of the
-EAGAIN return value.  Drivers may believe that it is special, but it
actually isn't.

For now, I want to restore the behavior that was present before
because some setups may rely on this.

