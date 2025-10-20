Return-Path: <linux-pm+bounces-36512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3EBBF32D1
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6B2E4F45C4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99492D47F6;
	Mon, 20 Oct 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgwgEjSp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846302C08CC
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987945; cv=none; b=gRI0gslKfeidFtFuSy1u4jXY5XnvbFeDHBsKpqrEwjxTdiQ4SyFwJOOqXmnelbxrktHfbb9eQvYuWuK0gL16F2Lp2Fe7XmURlSFmH4Is5/v0V1eiiaZjAnB5EP17szXidYZGGS+s3ZvlN6TeMRDvdQoP5HirNT4EhKCnsho+T8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987945; c=relaxed/simple;
	bh=J/Fg8bUxzsQ2IgZQRldX5NySPruVgzQRsbMNc0FNNa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijE3pWknxTtuwDSb1j0b+2f5gNwAf4pu57Rz5qujvj/yU6pvQ51lL6K8fBYdjo87w1F0K70bgh/8rJm32wKqyJLj8nIfstpFOcOV0YmbwlzNnVWwmjEPSxZ9opGzVlkLDK8wfHfTpRWsAlxZZ/FKD6eglr/OQUFxXEYhujZwxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgwgEjSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B2C2BCB2
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760987945;
	bh=J/Fg8bUxzsQ2IgZQRldX5NySPruVgzQRsbMNc0FNNa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DgwgEjSpRXCkeH3ZOkUpcsK3B2cJw/c+X7dq2Eg3fsY3azaiyDjXEAEMJItaV4bOq
	 wc8uiYzZXRVhMzm07kQE0/lekYwh7xWax2xPA6BV8gUu6nrZhtFluVLaZAs7dhrMDl
	 AkrlWXIzd6SAB92aYW58KBUvFcxzj8ih2pQWkdWmaY2MXCTHtfx1feVx/U9GoeoVrk
	 FLxgA5Hnby4S5Vdonhj6r8U8Mf5yaU32eK6+IpaAoYX0XSPZsdbq2z4qpKy2FAMVKa
	 Y7F+IEwjdPYf/y0ydnUm/AD7ws7qP76Foh9lEM4L9b3jWKwavTNuNy5xoZ2h7R8ntz
	 O/QHydjC9kTSA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c27e5ca2beso1235873a34.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:19:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsSWEGGPrWNJSui3lTmMA8Mg6lYcnx1EKvxndE9d9VohTDbJxRX0u6olGWLKVGzrFM3JiYjeCA3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQTZVdZu7j74BUv8dYlOyhep1vCkaQgMDSLT6QovzaIBkeILg
	aT0zf9jliieM50fj++W9RMBStzpvH8Of0M+H8EmsNCSMn3QwGqpNQi10zFKk9lwV7eqK/M4nhu9
	Q3TYhidKoh+JmAIJoHq1t+IGi4v4m/os=
X-Google-Smtp-Source: AGHT+IEM/IHVfesjnU7C1tyRsx/zEryDAAVIgQX2Cok/4ExdyrEXdnSNRKPKSxZcsGEKLSUnGe93koHhxhnKg2drHoY=
X-Received: by 2002:a05:6808:d46:b0:441:8f74:e84 with SMTP id
 5614622812f47-443a3099e92mr6321887b6e.62.1760987944138; Mon, 20 Oct 2025
 12:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org> <20251020165317.3992933-4-superm1@kernel.org>
 <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
 <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org> <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
 <aec8fc6c-3f9f-4ec1-a929-7a0be6026a3d@kernel.org> <CAJZ5v0gMf-qMGa6iBL2NdRXd-Mt5cpsoVQ90y+rSyK5xoYEf8A@mail.gmail.com>
 <aa04dea5-d35b-46c9-9501-0a2e79ecbd79@kernel.org>
In-Reply-To: <aa04dea5-d35b-46c9-9501-0a2e79ecbd79@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 21:18:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=sw9X3mV2ddOD_-qJwxveXQ1faD6HWtStLo9xOpwYKA@mail.gmail.com>
X-Gm-Features: AS18NWCIGD1552PBhOTdIYxOfP1sqnVlsDjWGNWVpcbA7we01MzHPxSZzmFLQoU
Message-ID: <CAJZ5v0j=sw9X3mV2ddOD_-qJwxveXQ1faD6HWtStLo9xOpwYKA@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, airlied@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
	gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
	simona@ffwll.ch, Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:14=E2=80=AFPM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
>
>
>
> On 10/20/2025 1:50 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 20, 2025 at 8:32=E2=80=AFPM Mario Limonciello (AMD) (kernel=
.org)
> > <superm1@kernel.org> wrote:
> >>
> >>
> >>
> >> On 10/20/2025 12:39 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Oct 20, 2025 at 7:28=E2=80=AFPM Mario Limonciello (AMD) (kern=
el.org)
> >>> <superm1@kernel.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
> >>>>> On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
> >>>>> <superm1@kernel.org> wrote:
> >>>>>>
> >>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>
> >>>>>> The PM core should be notified that thaw was skipped for the devic=
e
> >>>>>> so that if it's tried to be resumed (such as an aborted hibernate)
> >>>>>> that it gets another chance to resume.
> >>>>>>
> >>>>>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> index 61268aa82df4d..d40af069f24dd 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *=
dev)
> >>>>>>
> >>>>>>            /* do not resume device if it's normal hibernation */
> >>>>>>            if (!pm_hibernate_is_recovering() && !pm_hibernation_mo=
de_is_suspend())
> >>>>>> -               return 0;
> >>>>>> +               return -EBUSY;
> >>>>>
> >>>>> So that's why you need the special handling of -EBUSY in the previo=
us patch.
> >>>>
> >>>> Yup.
> >>>>
> >>>>>
> >>>>> I think that you need to save some state in this driver and then us=
e
> >>>>> it in subsequent callbacks instead of hacking the core to do what y=
ou
> >>>>> want.
> >>>>>
> >>>>
> >>>> The problem is the core decides "what" to call and more importantly
> >>>> "when" to call it.
> >>>>
> >>>> IE if the core thinks that something is thawed it will never call
> >>>> resume, and that's why you end up in a bad place with Muhammad's
> >>>> cancellation series and why I proposed this one to discuss.
> >>>>
> >>>> We could obviously go back to dropping this case entirely:
> >>>>
> >>>> if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend=
())
> >>>>
> >>>> But then the display turns on at thaw(), you do an unnecessary resou=
rce
> >>>> eviction, it takes a lot longer if you have a ton of VRAM etc.
> >>>
> >>> The cancellation series is at odds with this code path AFAICS because
> >>> what if hibernation is canceled after the entire thaw transition?
> >>
> >> Muhammad - did you test that specific timing of cancelling the hiberna=
te?
> >>>
> >>> Some cleanup would need to be done before thawing user space I suppos=
e.
> >>
> >> I agree; I think that series would need changes for it.
> >>
> >> But if you put that series aside, I think this one still has some meri=
t
> >> on it's own.  If another driver aborted the hibernate, I think the sam=
e
> >> thing could happen if it happened to run before amdgpu's device thaw()=
.
> >>
> >> That series just exposed a very "easy" way to reproduce this issue.
> >
> > Device thaw errors don't abort anything AFAICS.
> >
>
> You're right; it doesn't abort, it just is saved to the logs.
> The state is also not maintained.
> > What can happen though is that another device may abort the final
> > "power off" transition, which is one of the reasons why I think that
> > rolling it back is generally hard.
>
> That's exactly the reason for the first patch in this series.  The state
> of whether it succeeded isn't recorded.  So if thaw non-fatally fails
> and you've saved state to indicate this then any of the other calls that
> run can try again.

So long as they are called.

But as I said before, I would save the state in the driver thaw
callback and then clear it in the driver poweroff callback and look at
it in the driver restore callback.  If it is there at that point,
poweroff has not run and hibernation is rolling back, so you need to
do a "thaw".

