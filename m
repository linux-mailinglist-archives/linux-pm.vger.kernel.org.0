Return-Path: <linux-pm+bounces-10135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52A91AEF1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97027B214C4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333C199EAF;
	Thu, 27 Jun 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeMgYDuv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FC13A276
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512637; cv=none; b=as0Ep4o2JYpfcfbdz3D1F1pwhYJ3if26VnFPHBuVzddWotOqvonqsRhwm0Hr6rxiOGDsBNzCGwoim667q1/1I0DtAtZVcIjDwz8ZWV/wRVOAjiHr3p+/B6SuPQ0hdEdolFCKKBPwTGQ9+PGCVv6hycHiKbSpSmLTSX909fLM12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512637; c=relaxed/simple;
	bh=LYtX3V5zjBlkgDDjam3EFKlmfi7YVG4smr68YFM9yTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9D6lksE1IIrji+ZICVX8mBY8JLPfDaOWbQGYvkPv5y0aeEGSrgfc9HTp0L5KnakuWaS4O1IIrTqJg+g8ShFVawZODLzz6xmmEbpfKP6Du/G7KHD5YQlpaTCEvW4eKYlmMUa46GTT+y1o1dekTv6qiBG4Pne8GsTrQDO1SsMCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeMgYDuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78849C4AF07
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512637;
	bh=LYtX3V5zjBlkgDDjam3EFKlmfi7YVG4smr68YFM9yTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EeMgYDuvtEJQlMKv0t6nu6LrJFPQzv4Sd4VT2uVIOBUUhUv/57kRpB1rDHunNejm0
	 ASYRsFIc5sQjRHlUGBZbKglUQih+SB6AGEIQ51H6MWw0QbQhRbiMdGAxUVKA4IyqyI
	 +BkYR8EDBj0itDKGQxEqfwto4O3nxpt6o8nkFycG+mgQhCpUGpVBUH6BabwWnZf88C
	 BfFMbvTKHzmeL6uy0Y8Vss5YCk9pGN4dLd/zUnrdZEEKHhUkOwwdB9i1Gs7efnjzMh
	 H54/XEjQdS7qkjxgM0/u3AiNhG6qSh01Pje603spMcspS79f4cxlzcdwOmv1pnaPLl
	 2JyJb3UZLPM/w==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d561131a3cso295837b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 11:23:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUCDZDa9TIQaza96nHD+haxZuzp8d4/qNmti6DcWULvwsK2I4cUDHRL/dliJWcceuJaNbfcxhPYTT+r7LGKmrykQaqKJEIY+8=
X-Gm-Message-State: AOJu0YzVOhy2bVplBfe4168IkjwYMp+6IxlKmmM9Iu759EoLCQhK3AZO
	+fIyvQEu/P6KAhsuCF/YAPql//3PjYx0DlvNH7Ke2miaEDjGjVOK7xrHEN053KPG4S1lLaBARbe
	44pz3xAMizC/6wv4VWLgE1ERiY98=
X-Google-Smtp-Source: AGHT+IFVIgnI4vdgHFt6wdhMk0FoxPywmEJB6zg4gPkfAcpYUhCmZmlNbVbiVMD1fAhKmhmF5S9BrbrfjGGhb2THRbM=
X-Received: by 2002:a05:6820:826:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5c1e5ca2ca1mr20800921eaf.0.1719512636713; Thu, 27 Jun 2024
 11:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org> <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
 <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com> <43ded807-be8d-4673-ab8c-1ed2a5a32077@linaro.org>
In-Reply-To: <43ded807-be8d-4673-ab8c-1ed2a5a32077@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 20:23:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0=k4HZhKhs=2iwO8zc=jkng898wF-nn_bUT-xA_iu6w@mail.gmail.com>
Message-ID: <CAJZ5v0g0=k4HZhKhs=2iwO8zc=jkng898wF-nn_bUT-xA_iu6w@mail.gmail.com>
Subject: Re: Trip points crossed not detected when no cooling device bound
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:30=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/06/2024 11:54, Rafael J. Wysocki wrote:
> > On Thu, Jun 27, 2024 at 12:24=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 26/06/2024 23:21, Daniel Lezcano wrote:
> >>
> >> [ ... ]
> >>
> >>>> Oh, I see where the problem can be.  If the zone is polling only, it
> >>>> will not rearm the timer when the current zone temperature is invali=
d
> >>>> after the above commit, so does the attached patch help?
> >>>
> >>> At this point, I went far when bisecting another problem and I ended =
up
> >>> screwing my config file. So I had to generate a new one from the defa=
ult
> >>> config. Since then the issue is no longer happening which sounds very
> >>> strange to me.
> >>>
> >>> I'm still investigating but if you have a suggestion coming in mind, =
it
> >>> would be welcome because I'm failing to find out what is going on ...=
 :/
> >>
> >> I finally reproduced the issue. That happens when there is *no* coolin=
g
> >> device bound on *any* thermal zones.
> >
> > Interesting.
> >
> >> Your patch seems to fix the problem but I'm not sure to understand the
> >> conditions of the bug
> >
> > It's probably the same as for commit 202aa0d4bb53:
> > thermal_zone_device_init() sets tz->temperature to
> > THERMAL_TEMP_INVALID and if the first invocation of
> > __thermal_zone_get_temp() returns an error (because the .get_temp()
> > callback returns an error), monitor_thermal_zone().  If polling is the
> > only way in which the zone temperature can be updated, things go south
> > because the timer is not set and there is no other way to set it.  No
> > updates will be coming
>
> If there is no polling delay (aka interrupt driven), the routine will
> skip the _set_trips function and the monitor_thermal_zone() will do
> nothing in this case, right ?

_set_trips() looks at tz->temperature, however, and it doesn't make
sense to call it if the latter is invalid.

Same for handle_thermal_trip() and governor callbacks.

> Even setting a label jump to "monitor:" the routine is broken AFAICT

I beg to differ.

Yes, monitor_thermal_zone() does nothing if there is no polling, but
it needs to be called anyway because it checks whether or not polling
is there in the first place.

And if there is no polling, it is assumed that
__thermal_zone_device_update() will be called by other means.

> > The reason why the presence of cooling devices can "fix" this is
> > because thermal_bind_cdev_to_trip() sets tz->need_update to 1 which
> > then causes the thermal_zone_device_update() in
> > __thermal_cooling_device_register() to trigger and that will update
> > the temperature.
>
> IIUC, the first time get_temp() fails and then when the tz is bound, the
> update triggers a new call with get_temp() which returns a valid
> temperature ?

Yes.

