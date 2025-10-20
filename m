Return-Path: <linux-pm+bounces-36501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E52BF3021
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B95A3B62E6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBF2BE04C;
	Mon, 20 Oct 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBzKp5rt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FE221DB5
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986234; cv=none; b=Q0ZPsDyfTtp4x1p5HesUb56ePSwS1z2iAQtrij65os7BUHrevkAqSioatozDCKu//43JHu5QNE14QtX9GuOY99vR3LzjK+9m5nN1NAaz3n7xzoxtCUai+RQWMh8q6h24P5XE1SZwTngUZdyy061Asgrpe+XbHgPfjnBQ6MpFaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986234; c=relaxed/simple;
	bh=T9xox0HM4UF95GIL4X1Mn43yKdjkpOS/EWQtbC4EEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoHE8J1+jP4/F7GXSnsNcO5jpWSLy73v4ZD72g9fKMu/s18ekfOnu2unP8KpqxiufHOyCqKN0pmglglSgceqllowgtunjHIWIHWa1/acqYtZTw+twVnu9Kjqhmz35rzvlFQuZoLxJhoV7mfLOCzC+/HLye0QP8Kvv6z+saK4Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBzKp5rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D9CC16AAE
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760986234;
	bh=T9xox0HM4UF95GIL4X1Mn43yKdjkpOS/EWQtbC4EEJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HBzKp5rtQ0Q8SVxn/1FlqftM/plmc2WgoX+gulyccpBKV5FTDk2wp5otTaeIk4jFC
	 fEt62b6Kv9PD71QGe/1OuyX8OcUtrQV9ifO08jXPy8cCSOwfjmH4oYCp3gB6jN+0q9
	 snx49ojC4QIbP8v1S+Wx3Z9b0058PyeXPDjlHjnZkeh+diBAqfFg4TsXtszuVjSExg
	 DAUt/syVsbuu7YNFn3ofbBGaRKXaeXQfzroNKoJ5JKYBRzLls68TXNvsA73DjzeF8w
	 dyScxKWNtAUvvb5e++cTiRbz30AH4/qM0T19Qh3DnEKpxdBbLC/GbztpLYJNzsU2KC
	 UTdwsD6+qpvPQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-442003b80d0so1733905b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 11:50:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH/ZP3XC2clKfB1AKVwe2zW8aPhYt66mCIHCGxjI/MYJOWZ2MpSlagLYKL7JLXVFGKnTEaXNKajQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcVK7nQ0Hd9rsrSgJ3+ok9+HlaCjAQNSCAnEEdnKH5hSKgAWk
	JkfLUXA1pHiQThQ+vFQsxTBaGeTO5Vs0pRDyIDQuGnT0sH/IgFnhrBmNQ/EuNe2fwi3Ysvkcfa3
	lvBbnCkwCqzDndZRHb1XGmTdKxjk1Uwk=
X-Google-Smtp-Source: AGHT+IHST6iSSjR9sowIUp74URZmCfDo260rlv0OLY3MtNgq5MbkgmXa21ZyE1N1chceC+tTpTh+NIvIgmYQVBg9HjI=
X-Received: by 2002:a05:6808:6718:b0:43f:abc7:f840 with SMTP id
 5614622812f47-441fb97f76cmr7641827b6e.17.1760986233391; Mon, 20 Oct 2025
 11:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org> <20251020165317.3992933-4-superm1@kernel.org>
 <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
 <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org> <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
 <aec8fc6c-3f9f-4ec1-a929-7a0be6026a3d@kernel.org>
In-Reply-To: <aec8fc6c-3f9f-4ec1-a929-7a0be6026a3d@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 20:50:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMf-qMGa6iBL2NdRXd-Mt5cpsoVQ90y+rSyK5xoYEf8A@mail.gmail.com>
X-Gm-Features: AS18NWBuf_ZaMFCedSeiIN34onuDzQPdHGd1wzQY-S5DN-sJHQED06c6kG-OGlI
Message-ID: <CAJZ5v0gMf-qMGa6iBL2NdRXd-Mt5cpsoVQ90y+rSyK5xoYEf8A@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, airlied@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
	gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
	simona@ffwll.ch, Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:32=E2=80=AFPM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
>
>
>
> On 10/20/2025 12:39 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 20, 2025 at 7:28=E2=80=AFPM Mario Limonciello (AMD) (kernel=
.org)
> > <superm1@kernel.org> wrote:
> >>
> >>
> >>
> >> On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
> >>> <superm1@kernel.org> wrote:
> >>>>
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> The PM core should be notified that thaw was skipped for the device
> >>>> so that if it's tried to be resumed (such as an aborted hibernate)
> >>>> that it gets another chance to resume.
> >>>>
> >>>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_drv.c
> >>>> index 61268aa82df4d..d40af069f24dd 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *de=
v)
> >>>>
> >>>>           /* do not resume device if it's normal hibernation */
> >>>>           if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_=
is_suspend())
> >>>> -               return 0;
> >>>> +               return -EBUSY;
> >>>
> >>> So that's why you need the special handling of -EBUSY in the previous=
 patch.
> >>
> >> Yup.
> >>
> >>>
> >>> I think that you need to save some state in this driver and then use
> >>> it in subsequent callbacks instead of hacking the core to do what you
> >>> want.
> >>>
> >>
> >> The problem is the core decides "what" to call and more importantly
> >> "when" to call it.
> >>
> >> IE if the core thinks that something is thawed it will never call
> >> resume, and that's why you end up in a bad place with Muhammad's
> >> cancellation series and why I proposed this one to discuss.
> >>
> >> We could obviously go back to dropping this case entirely:
> >>
> >> if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend()=
)
> >>
> >> But then the display turns on at thaw(), you do an unnecessary resourc=
e
> >> eviction, it takes a lot longer if you have a ton of VRAM etc.
> >
> > The cancellation series is at odds with this code path AFAICS because
> > what if hibernation is canceled after the entire thaw transition?
>
> Muhammad - did you test that specific timing of cancelling the hibernate?
> >
> > Some cleanup would need to be done before thawing user space I suppose.
>
> I agree; I think that series would need changes for it.
>
> But if you put that series aside, I think this one still has some merit
> on it's own.  If another driver aborted the hibernate, I think the same
> thing could happen if it happened to run before amdgpu's device thaw().
>
> That series just exposed a very "easy" way to reproduce this issue.

Device thaw errors don't abort anything AFAICS.

What can happen though is that another device may abort the final
"power off" transition, which is one of the reasons why I think that
rolling it back is generally hard.

