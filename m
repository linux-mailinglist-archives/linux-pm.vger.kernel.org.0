Return-Path: <linux-pm+bounces-15155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EFA990922
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2681F21493
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83461C8769;
	Fri,  4 Oct 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTKzspeT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AF1C8761;
	Fri,  4 Oct 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059311; cv=none; b=b/BUqGifCvY6sjA1KPWXfFySygUudiVHNwHXomAeGpIbWDxCdZBmKtUfhKbiiNlD3h0uRhJm6BTzJrrDh5aZaQlrDsZR6JZ8LwyC12WKqJOVHu1ABIzgiLjlunFEWFQOeQiaSNQMJqtSsWJlcITrWxIikbNkzj411wNgN5jetx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059311; c=relaxed/simple;
	bh=VcdWpeZzXXVqcK7mmUjpmFx69LyvMwwPTL+mrgVzoxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcdjhRJpXRwI9iMHtqHiSsBvh9wpzzH+qwjNOVBmf0vy5ctZKoeJTzKcx9dM3rIRMU57yStJ9Mi5th/+OxLsmMHuf8YtmCVw2i5dfZwlXrhSqAzNCyoNTcdohaIubnfLvNf03fQr0R/wn7CmEGaaA+qFjf4by7QrpIblsK3GMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTKzspeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9100CC4CED2;
	Fri,  4 Oct 2024 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059311;
	bh=VcdWpeZzXXVqcK7mmUjpmFx69LyvMwwPTL+mrgVzoxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VTKzspeTzmvZrslylxG4PwSjopfV9MtmLXGzc8SB91iQQKLSqL5t4KVy79J1UCIec
	 O/MlXYn5uJ3X+/+XLDxetcyWNtEGyMWPjm/MeKvFZzwfSYN1M04UjI/MUvWowSwIpk
	 a4IeBnMFkdGXjdl5jcJ2anrXSVoDbviA9HFidjNFg0NsMeX1yJKzSAr/YtDUEYa3tm
	 JEdB85y1eBBfcJpPY0TZwlYuvA7to5GeGy73ViSdo9Qv48uKH3qXAXe7E8hoNE1UaL
	 q2lJFx2mpDp5u/0Ne3FxzNE08X+elL6RHg9SHeOyGPX07fNhZesa/CPs4D01fEsFR3
	 Rpp8YB6Wp8ziw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e1baf0f764so753298eaf.1;
        Fri, 04 Oct 2024 09:28:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKNY2WCueN2HhvYKRXfbJNXorz8OyYlElDPzoIGa4gKMd2FDZJwMz1bwrJg8U50Tl//fxu/1u4vQs+ykk=@vger.kernel.org, AJvYcCX7+D/F0D09w2DjfGswjnBFAYtGFh567C716YAG37YVQ60KrziWVrwFKzWvrWmpMEPOfe6iRBZ813c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVPByDX5qbhJy9wsG70mIXqmlQced0csROFUleK0oM6Jb6t9r
	aDKdUOKv87WwGmoeCsiB+ak2fRM+79IKvOTqQtlCmSz2x1zWIYhF0VcCFo9cTtvlhaX7/x/qUD4
	gGpUqfHUtRfc8BL6heW6DF4GIj48=
X-Google-Smtp-Source: AGHT+IGkH3eSm76Y+dAOdUFbEPIXaTIyenB3X/AcSew8S5ibDCXnIBU1uMFOM/zBtCsbcpw5PaQCUkC9W4rNc8coyOg=
X-Received: by 2002:a05:6820:82a:b0:5e7:c925:af3 with SMTP id
 006d021491bc7-5e7cc079e04mr1760542eaf.5.1728059310905; Fri, 04 Oct 2024
 09:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12549318.O9o76ZdvQC@rjwysocki.net> <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com> <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
 <5222419a-2664-4bb5-b1d4-77a46677bb4d@arm.com> <CAJZ5v0jkbQG4A+saKDfCz6g2-A=rZ2y34k2v9jA9uhp9A17ZBw@mail.gmail.com>
 <CAJZ5v0iSb=RGiuXrBPq6V0ZObhPedznuv7CGgAyO1MMshCQrMg@mail.gmail.com> <a42ebcff-10f8-4888-a3d8-fd2705da41b3@arm.com>
In-Reply-To: <a42ebcff-10f8-4888-a3d8-fd2705da41b3@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 18:28:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-Y9qwKTc=EOOxRGHqMitZpqti6addKPMP45byZ18K5Q@mail.gmail.com>
Message-ID: <CAJZ5v0i-Y9qwKTc=EOOxRGHqMitZpqti6addKPMP45byZ18K5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in thermal_zone_get_by_id()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:52=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 10/4/24 14:48, Rafael J. Wysocki wrote:
> > On Fri, Oct 4, 2024 at 3:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> On Fri, Oct 4, 2024 at 3:37=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>>
> >>>
> >>>
> >>> On 10/4/24 14:25, Rafael J. Wysocki wrote:
> >>>> Hi =C5=81ukasz,
> >>>>
> >>>> On Fri, Oct 4, 2024 at 10:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm=
.com> wrote:
> >>>>>
> >>>>> Hi Rafael,
> >>>>>
> >>>>> On 10/3/24 13:25, Rafael J. Wysocki wrote:
> >>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>>
>
> [snip]
>
> >>>>>>
> >>>>>
> >>>>> I wasn't aware of that helpers in cleanup.h.
> >>>>>
> >>>>> Could you help me to understand when this this
> >>>>> 'if (_T) put_device((&_T->device)' will be called?
> >>>>
> >>>> When the pointer variable initialized via the CLASS() macro goes out
> >>>> of scope (that is, before freeing the memory occupied by the pointer
> >>>> itself).
> >>>
> >>>
> >>> OK, so do we still need the old code in
> >>> thermal_zone_device_unregister(), which calls
> >>> put_device(&tz->device) ?
> >>
> >> Yes, we do.
> >>
> >>> Maybe that code can go away?
> >>
> >> That particular one drops the reference acquired by device_register()
> >> and I don't see an alternative clean way to drop it.
> >
> > The problem there is that local variable tz goes out of scope at the
> > end of the function (at least formally) and put_device(&tz->device)
> > needs to be called before the wait_for_completion(&tz->removal) which
> > definitely needs tz to be still around.
>
> OK, I see now. That makes sense. With that feel free to add:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!

