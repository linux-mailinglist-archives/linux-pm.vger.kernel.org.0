Return-Path: <linux-pm+bounces-26833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB651AAEC10
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1DF9E3F54
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE1028BA9F;
	Wed,  7 May 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZbq2NFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B7211278
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645253; cv=none; b=WhZMOO50shhbTgH9VXOBk+oXRWK7Fo0wXuow5cJ+oaLXLvH3UufM4I0ooMxT3NL9DGBaWUI+pK4lWAxe0BZqygQwt926XRPqabscHhhcxFEDTOdAURaZ/7LsFJCSuFAkhG371iCAD6iTLqLpfd/9Y6Ef4GQIdlBOWEvOthcfNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645253; c=relaxed/simple;
	bh=kvxfAt9mZdWf/uEiEG3518AtWtSuCcxF7ycxWMiGbRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/FT2YBfpDPCfsnw2LkEV1fh7AHr9lg0v48FHRkOLlfIOk8BJ1AMeZ9TcIUwjB5KMhNYtWd4eqvm/Zn2WhCiigrRhsfu+PYscHTFdF4n0OhbHqGyUBIaNwyDsV95ulGtVMw/HfcpyELs+EkvQ3COXaS3WF3rEPxX7z50Gj1onWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZbq2NFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC7CC4CEE2
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746645253;
	bh=kvxfAt9mZdWf/uEiEG3518AtWtSuCcxF7ycxWMiGbRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pZbq2NFBTmWMndrDDRcWVEDka/k3TfXkmYw+5EfXtW3F+HwKP3oqDkhxOcbnw9vl+
	 j2R9maX7JimD8JXQhqzkGGUEN9d7M838KENSwWMVOzvi6wjV3ByhE3iMGgX5u+65YS
	 N1ouUNbCoTJHNxZQ5h9DjRZMuQmE27F+ipOD2LEJcnnESH34jOY+EYm+oaAqXfFmHd
	 gFf7L745N9qFKi1oshyf/eAGrEQ5tfgWfL4BeQ+ypcTN4bdmem8x/aCxSiL5+2OPPP
	 czTU5qXK6o7C4c3RAiD4JL9zizfhaAIa047C1qlUS7S3HuPgwnCuI6Oos7qtSUWt+g
	 5IsaeZ/oVwCag==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2da3b3bb560so203376fac.3
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 12:14:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcNlLyRPuW+evsUP1kfagdJo8fSZxJlGv/gWrot5/6Vy6uju+xl8+N5uQjy/bg89I+3EFpIHluIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrVq9BNXQbOwyu+kUIOGUz6VO1xmwDceMBt7Jc9kNfrOVNkdX
	IxcX8mDd+TeuQHuERbXV029OwX04aTRdrtyNy985MbWMNRQ2q7ldnOM1iIuMpAT+eJmkZrT4lCb
	P1iooDHGFMt8aKyW4f44iECnSsD4=
X-Google-Smtp-Source: AGHT+IE3jXSjGIIfI91jHEVc3h4Cxa573NLi6+6W00fLbnV16KozMGvO2lXXGZJOwey2fzVqDNLIJrnzqPug+7yMk78=
X-Received: by 2002:a05:6870:702a:b0:2c2:304b:b94f with SMTP id
 586e51a60fabf-2db8140cfc6mr513447fac.13.1746645252404; Wed, 07 May 2025
 12:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501211734.2434369-1-superm1@kernel.org> <20250501211734.2434369-3-superm1@kernel.org>
In-Reply-To: <20250501211734.2434369-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 21:14:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com>
X-Gm-Features: ATxdqUFOGk9YGDM06KNvT2yGAglzogvXYMO4gKjLzkN35bu358LIPVBevHRiGE4
Message-ID: <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/amd: Use suspend and hibernate post freeze notifications
To: Mario Limonciello <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 11:17=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification
> callback support") introduced a VRAM eviction earlier in the PM
> sequences when swap was still available for evicting to. This helped
> to fix a number of memory pressure related bugs but also exposed a
> new one.
>
> If a userspace process is actively using the GPU when suspend starts
> then a deadlock could occur.
>
> Instead of going off the prepare notifier, use the PM notifiers that
> occur after processes have been frozen to do evictions.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callbac=
k support")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7f354cd532dc1..cad311b9fd834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4917,10 +4917,10 @@ static int amdgpu_device_pm_notifier(struct notif=
ier_block *nb, unsigned long mo
>         int r;
>
>         switch (mode) {
> -       case PM_HIBERNATION_PREPARE:
> +       case PM_HIBERNATION_POST_FREEZE:
>                 adev->in_s4 =3D true;
>                 fallthrough;
> -       case PM_SUSPEND_PREPARE:
> +       case PM_SUSPEND_POST_FREEZE:
>                 r =3D amdgpu_device_evict_resources(adev);
>                 /*
>                  * This is considered non-fatal at this time because
> --

Why do you need a notifier for this?

It looks like this could be done from amdgpu_device_prepare(), but if
there is a reason why it cannot be done from there, it should be
mentioned in the changelog.

