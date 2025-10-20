Return-Path: <linux-pm+bounces-36492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2414DBF2C4A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6364648BD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A7330312;
	Mon, 20 Oct 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esCKnBGZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8713DDAE
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981988; cv=none; b=ZiTCs5GmgehhYl/rAZz6u6AZxgbSgsrz3DculfmH6DhZL+p4hMtxjJqtNSKWDuc1YgvmgNWCh6e9ZUUguJrk5AyjVXfs/Sh2JjTX/f7ivfZfgn+jXE7wDLlVtGH1eUKSl5Y9LNiF0U9Q1c7P4Mxk9Xwdkbl8rAN3qvBNdUvKtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981988; c=relaxed/simple;
	bh=wT1Y0qfI1uM/2GtV+FQhAIBMo9jpLEUnAXNhpAS02FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DulvkDcDd08tnLfPp+O7/UL/lWQGDWTjfaqxPhAa0VzsfCt/0Xrp0IlMZDvHp6W7Na9oDaQHy1j/FvKt0G+Wim4ZplJkDQqJsxDPIAlLNwpVNeYsn2D57XcmvRzHxKhb494mzWSm5PcIuqu+HlHbVn2jMMJqxOoi9Pl/XEqPQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esCKnBGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E187C19425
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981987;
	bh=wT1Y0qfI1uM/2GtV+FQhAIBMo9jpLEUnAXNhpAS02FE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=esCKnBGZ6tc7fXkUNN0JMOBxu4pT8vQeT0lTR5kZUFWi+3eMrJIJJBjRCN85L+Nba
	 oQpck0TBqIfTz0bdA27GzRuRMDrlPQYiN+8itrLY2Bg4xX3JMsd3oqo0dUym8iRseY
	 kHyQUsYhahuf50qjT0r2elMPjfOeOjT8t1Mq09jIc8WLS6U+ql/aSTJwekhaXUN+eu
	 hJ3Sg5z7uInlb/xr6vLmnxZ3SlFZjE1QUhtFyQoJ3+oCOLGgx29OwbJgxrr0XlOAas
	 R1kCWqalRAZ3NA3aBPyrgqXuvAJfIEUnZG39F9IUByVkYfl/QOt5LKcIq0zCyjnSk+
	 6Op2Pp9/4GVvw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43f715b18caso2288112b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:39:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOwDmOWy3GL9fCTjdM31Qyn75n4g8TEiWGn8zheon2+ZY1KJWp7euY3osdExDxHiYMrkzi8sn0PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXiYEo9sA10exai1AzSUanHox/AmcOPEPAb0GrSD6Ghr57OT/
	AxhCj4D3p8xZW7IxF2anRCVUgtP0qCPGWCa9fslNY6viQbR7mYvKsRjHOJpEfnPE6mfnFLgh3GT
	CvKh+fwFpTAOyJjyKUuz18vfVwgR2VGU=
X-Google-Smtp-Source: AGHT+IG2Rxr5g0ETdapUPV9rmvM1DRXwrnwlcoW74xA8ZYJcZOIYF2AKB8oeuOlCh0+q7dU4hWkh88h8bpa+Do93q4Y=
X-Received: by 2002:a05:6808:138b:b0:441:8f74:fb1 with SMTP id
 5614622812f47-443a31ef503mr6101556b6e.62.1760981986716; Mon, 20 Oct 2025
 10:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org> <20251020165317.3992933-4-superm1@kernel.org>
 <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com> <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
In-Reply-To: <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:39:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
X-Gm-Features: AS18NWAGFArtUw2iag6c7zcOb_ybIi_pg36NhodGLq9MnSrMsDZdX75ZsN_KO40
Message-ID: <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, airlied@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
	gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
	simona@ffwll.ch, Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:28=E2=80=AFPM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
>
>
>
> On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> The PM core should be notified that thaw was skipped for the device
> >> so that if it's tried to be resumed (such as an aborted hibernate)
> >> that it gets another chance to resume.
> >>
> >> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index 61268aa82df4d..d40af069f24dd 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
> >>
> >>          /* do not resume device if it's normal hibernation */
> >>          if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_=
suspend())
> >> -               return 0;
> >> +               return -EBUSY;
> >
> > So that's why you need the special handling of -EBUSY in the previous p=
atch.
>
> Yup.
>
> >
> > I think that you need to save some state in this driver and then use
> > it in subsequent callbacks instead of hacking the core to do what you
> > want.
> >
>
> The problem is the core decides "what" to call and more importantly
> "when" to call it.
>
> IE if the core thinks that something is thawed it will never call
> resume, and that's why you end up in a bad place with Muhammad's
> cancellation series and why I proposed this one to discuss.
>
> We could obviously go back to dropping this case entirely:
>
> if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>
> But then the display turns on at thaw(), you do an unnecessary resource
> eviction, it takes a lot longer if you have a ton of VRAM etc.

The cancellation series is at odds with this code path AFAICS because
what if hibernation is canceled after the entire thaw transition?

Some cleanup would need to be done before thawing user space I suppose.

