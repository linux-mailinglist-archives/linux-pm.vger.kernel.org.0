Return-Path: <linux-pm+bounces-26836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431DAAEC4B
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB257ACBA2
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60C28E58E;
	Wed,  7 May 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpNghWlK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F728E58C
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646757; cv=none; b=QMmVpeLb4Ps9c7q5F4rOU/KaoNrHO6MDOjZCDpU/iGgqt+cOJjraSPP1vicjDxir3q9YZoWpuf2Dhxw7Dyei0LoGkg7pnIoF2c3tciFJ+dK2v6dj+vX2s7X0B+hZUZQH5wFq8aOfxEKcVpLyCA2izR6tnulh4d1jXILheNsmDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646757; c=relaxed/simple;
	bh=Vj9qOb5V3uxpmd9UqB7cYHTOrTQy5HFXlYEkJmL+5+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiH5e/ekQPX226I7LoXNEHyWIET/UJmKxyjA33cat5g7rT75ptaV8VGOCoJW87nRZZ/YlTirHmBs/j7LG+xIhmDJdIGr8P8juV25BLtbAFhnRvsAu6ETtv9PmsYyBw4TOlHCsyXccHGjyGhHtawQvmz6fiCIhiklw0OVUITtVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpNghWlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E509C4CEE9
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746646757;
	bh=Vj9qOb5V3uxpmd9UqB7cYHTOrTQy5HFXlYEkJmL+5+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IpNghWlKls3jjaaEFPFkYL42YYvTdZEdW59H4+K1InQZFesjCDQ2NS5yLN6DJ4qQr
	 3aEatFPFtdEOCpJ3gWYcCHdx+7JpKw+jX+q6zSIBMIqz2tWSLuSgvZcNjTnx8VzOwZ
	 qoFgSmTFyJEMUdWKw9UlFMG81CIjwaCSoXGe0VGbzNRQ+hMmggzqcQCEWWN8Ug4lOg
	 U5QWbwtI2lC57yIuxHbe4l5BSBU94Z2VtCuhXv0o0i5FVG2NFZyxyNYAiQ+OBDv4X2
	 mBLC3lHDXJxTxcIoQGynFkHIfz4ak8A+/Voa2TZnb5+VWCKnhJ4iSXHBlGICLM9Xoq
	 +0u0UdRrkvhqw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2da3c5729fcso216135fac.0
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 12:39:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsPvUtbuQJ+Sf1V/SGTb+3rHEem4NWSySCsP159AhojAwvQ4djoBn0qzULxGvYCew4/GzVKc/60A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkmwu2/1jKCVbBeUIKrGczMIjf/3hoyqfg26gBpccNd7oBcLV
	UI7WfH22IxYrxlQikIszBZEpCs2sDMIOel06Vx+C/j8DC7fQ66lfStR79ThpyWv/EXCzmYBu9Dc
	Or85ve14JcQ94ZFz+8C4lBClStuY=
X-Google-Smtp-Source: AGHT+IGo/W4JOA+eogKjcZX0SbjnfgMZPqFNNbTthgE5/frrNaxzGLSk/pg5gWwpOI6EYLJKtSZD+5ed0ZRsjc4fNfM=
X-Received: by 2002:a05:6870:458e:b0:2b7:d3d2:ba53 with SMTP id
 586e51a60fabf-2db5be3985amr2628749fac.12.1746646756509; Wed, 07 May 2025
 12:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501211734.2434369-1-superm1@kernel.org> <20250501211734.2434369-3-superm1@kernel.org>
 <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com> <98d527c6-a185-40f9-8ce3-46f5d7a67e81@kernel.org>
In-Reply-To: <98d527c6-a185-40f9-8ce3-46f5d7a67e81@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 21:39:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=9fpg2YxJhd+2rAx1gkqaquoExHvgMiFefn6YqVieOA@mail.gmail.com>
X-Gm-Features: ATxdqUGguP0YKc2QUBS1pUWeH6IHkczf8OMk4tYV33yVjmY5Obs12eo-MvEh4X0
Message-ID: <CAJZ5v0i=9fpg2YxJhd+2rAx1gkqaquoExHvgMiFefn6YqVieOA@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/amd: Use suspend and hibernate post freeze notifications
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 9:17=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 5/7/2025 2:14 PM, Rafael J. Wysocki wrote:
> > On Thu, May 1, 2025 at 11:17=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> commit 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification
> >> callback support") introduced a VRAM eviction earlier in the PM
> >> sequences when swap was still available for evicting to. This helped
> >> to fix a number of memory pressure related bugs but also exposed a
> >> new one.
> >>
> >> If a userspace process is actively using the GPU when suspend starts
> >> then a deadlock could occur.
> >>
> >> Instead of going off the prepare notifier, use the PM notifiers that
> >> occur after processes have been frozen to do evictions.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> >> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification call=
back support")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 7f354cd532dc1..cad311b9fd834 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -4917,10 +4917,10 @@ static int amdgpu_device_pm_notifier(struct no=
tifier_block *nb, unsigned long mo
> >>          int r;
> >>
> >>          switch (mode) {
> >> -       case PM_HIBERNATION_PREPARE:
> >> +       case PM_HIBERNATION_POST_FREEZE:
> >>                  adev->in_s4 =3D true;
> >>                  fallthrough;
> >> -       case PM_SUSPEND_PREPARE:
> >> +       case PM_SUSPEND_POST_FREEZE:
> >>                  r =3D amdgpu_device_evict_resources(adev);
> >>                  /*
> >>                   * This is considered non-fatal at this time because
> >> --
> >
> > Why do you need a notifier for this?
> >
> > It looks like this could be done from amdgpu_device_prepare(), but if
> > there is a reason why it cannot be done from there, it should be
> > mentioned in the changelog.
>
> It's actually done in amdgpu_device_prepare() "as well" already, but the
> reason that it's being done earlier is because swap still needs to be
> available, especially with heavy memory fragmentation.

Swap should be still available when amdgpu_device_prepare() runs.

> I'll add more detail about this to the commit for the next spin if
> you're relatively happy with the new notifier from the first patch.

I need to have a look at it, but adding it for just one user seems a
bit over the top.  I'd prefer to avoid doing this.

