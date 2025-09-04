Return-Path: <linux-pm+bounces-33839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A13B43D1D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821B41B218B5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50F306484;
	Thu,  4 Sep 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx7UrRW/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CD302779;
	Thu,  4 Sep 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992322; cv=none; b=SbU12NLifzl8IK5YGX8XeDrXjJMyYnc3VFiQzgGRQDBpqHWi39EsR2Eow4LEdaq+yBxh7+ohEH+z+eFvCzKwsFs4SG4pqoo9UJUYZSgBgnqtMvZPEpVmd/FOH6OPpNAt/GK4HhwNyC2Od5VqMSH1Pav+I4+Uh0uOAANSEYbLLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992322; c=relaxed/simple;
	bh=o7DlDEa6s+GPt5Sc8GcYUiaee/fyiW6FMt2CJQjE4oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKKBHlMqWVfKLyYsmiWQKyv8AuLfsKY2wBoIDuwhCcni9gNmhqASTMbtylQJ+a0lKEKIIo5v947j3IT4hPgjBQXsmd3x9LQdKMh5o1YpW0u9alB4Aq0vowKezielqUtgcmoaUHHaY7idEepzC/ZnGZ9bP85qSoNgEDkl0EW+mTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx7UrRW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDFAC4CEF0;
	Thu,  4 Sep 2025 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756992321;
	bh=o7DlDEa6s+GPt5Sc8GcYUiaee/fyiW6FMt2CJQjE4oo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sx7UrRW/J6cpDAku2HmKxpruNktm46k+VtDxcsh4dEdDbxh3hAKbLZbJ/s8607yam
	 4CFqVfEzJILW30qF4UKuW0gEpIQ7xfpVp0qHAZ8M4D0WfVDtS/E8WX+OETzuM+uTt+
	 elxDSDZNaEgVXSLvJQe6CkaXlNY5J8SDKfvZJD94OA+uEqvdUbUasdGPoS1rFXsp7t
	 avFkpebB7+2DDlUc/FQHWHlIGE/fMBSLV9Y/stMFJNtJCIRnVunCNnaKQxdHoaxgCL
	 VRSRhCHJfKqY7BFVc4SZhODQYM1NH9uW6F7pFfYF7hr7H9pCwibUr6cTIk9JjB/X8p
	 /L8Kqegl8t85A==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381e2079fso981618a34.0;
        Thu, 04 Sep 2025 06:25:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOY/fMWktW/it2u4IsNf9E/HW2Re8h5yfnB/wHQYkx1tvcGAhcPJrM2cnZiHXRdhEwIKqYDQYsr9s150k=@vger.kernel.org, AJvYcCVSUKzpvm27I+y80quAB03wNSGz2F3M1fe3eZYcqyFnk9Oi1cjyrz9diSKglbIQENZHx9g/0l9HpiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBrzcPGMQLLrEgK9jXP+v5y5DyO5y7oTN+nEPB9q3HfVLXR46
	avWisctOCIYKQiz6aSI9sOnux3+1Iqg/fbihYgMI3PEOxtyAAuwjXXz2t58PAW4mX8vynA5QeoR
	o/vEgDJawpCnt+Gv4TnGI9Mzdz/HH0lc=
X-Google-Smtp-Source: AGHT+IEO0DPnbDBhm1SH2nsgCQm4i0gWB5bPTaefbRVN1qchaOiFJpo46jB40EoQpgdATtXMVyH8I7ezWydnK/PvzsQ=
X-Received: by 2002:a05:6830:3c84:b0:745:62e6:c7f0 with SMTP id
 46e09a7af769-74569dcfb3bmr11461882a34.10.1756992321007; Thu, 04 Sep 2025
 06:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12745610.O9o76ZdvQC@rafael.j.wysocki> <1947735.tdWV9SEqCh@rafael.j.wysocki>
 <57c54d50-9948-42be-985a-195b2027733a@arm.com>
In-Reply-To: <57c54d50-9948-42be-985a-195b2027733a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 15:25:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPJbL+Ume2q1d6aoZ-PgpY-jqVfPDnwS8KbezLcK5bgg@mail.gmail.com>
X-Gm-Features: Ac12FXyt8bF-Gjiyl7sRqJN2U6QA1bD49UmLHfg-m-LeBspLxX7YNm6KLRLuoCE
Message-ID: <CAJZ5v0jPJbL+Ume2q1d6aoZ-PgpY-jqVfPDnwS8KbezLcK5bgg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] thermal: gov_step_wise: Allow cooling level to be
 reduced earlier
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:32=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 8/25/25 14:31, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current behavior of the Step-wise thermal governor is to increase
> > the cooling level one step at a time after trip point threshold passing
> > by thermal zone temperature until the temperature stops to rise and the=
n
> > do nothing until it falls down below the (possibly new) trip point
> > threshold, at which point the cooling level is reduced straight to the
> > applicable minimum.
>
> Quite long single sentence to describe these stuff...

Yes, it is long.  I'll try to rearrange it when applying.

> >
> > While this generally works, it is not in agreement with the throttling
> > logic description comment in step_wise_manage() any more after some
> > relatively recent changes, and in the case of passive cooling, it may
> > lead to undesirable performance oscillations between high and low
> > levels.
> >
> > For this reason, modify the governor's cooling device state selection
> > function, get_target_state(), to reduce cooling by one level even if
> > the temperature is still above the thermal zone threshold, but the
> > temperature has started to fall down.  However, ensure that the cooling
> > level will remain above the applicable minimum in that case to pull
> > the zone temperature further down, possibly until it falls below the
> > trip threshold (which may now be equal to the low temperature of the
> > trip).
> >
> > Doing so should help higher performance to be restored earlier in some
> > cases which is desirable especially for passive trip points with
> > relatively high hysteresis values.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/gov_step_wise.c |   15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/thermal/gov_step_wise.c
> > +++ b/drivers/thermal/gov_step_wise.c
> > @@ -20,7 +20,9 @@
> >    * If the temperature is higher than a trip point,
> >    *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> >    *       state for this trip point
> > - *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
> > + *    b. if the trend is THERMAL_TREND_DROPPING, use a lower cooling s=
tate
> > + *       for this trip point, but keep the cooling state above the app=
licable
> > + *       minimum
> >    * If the temperature is lower than a trip point,
> >    *    a. if the trend is THERMAL_TREND_RAISING, do nothing
> >    *    b. if the trend is THERMAL_TREND_DROPPING, use the minimum appl=
icable
> > @@ -51,6 +53,17 @@
> >       if (throttle) {
> >               if (trend =3D=3D THERMAL_TREND_RAISING)
> >                       return clamp(cur_state + 1, instance->lower, inst=
ance->upper);
> > +
> > +             /*
> > +              * If the zone temperature is falling, the cooling level =
can
> > +              * be reduced, but it should still be above the lower sta=
te of
> > +              * the given thermal instance to pull the temperature fur=
ther
> > +              * down.
> > +              */
> > +             if (trend =3D=3D THERMAL_TREND_DROPPING)
> > +                     return clamp(cur_state - 1,
> > +                                  min(instance->lower + 1, instance->u=
pper),
> > +                                  instance->upper);
> >       } else if (trend =3D=3D THERMAL_TREND_DROPPING) {
> >               if (cur_state <=3D instance->lower)
> >                       return THERMAL_NO_TARGET;
> >
> >
> >
>
> That make sense
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

