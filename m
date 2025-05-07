Return-Path: <linux-pm+bounces-26837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE7AAEC5E
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AA67B2FF4
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B321507F;
	Wed,  7 May 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYPkuJ5R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33E19CC0A
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646946; cv=none; b=D5srDc5cibpQMiAEtrn4G+CEAIMNqUuCTCu8xmpZIMfETpvF1js5JSMawtEML6pr4LmWGxY0Id8e81faPlixs8ud6YdKCFh/NNGV2M4UBFQ4/yrF94TW2q+Sq/o158wxR6McZMUO72wV4zZFqnJpV4rB4eGQ9bLGH8Xw3yXtHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646946; c=relaxed/simple;
	bh=5iJCcI3FR8/P0A08nQxkbKtXNe5/wYTs8YZ8bBgQZXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDVTMq6xpq/skcfX/pnFLKbGwR4WkucU/zz3Fe1NOJ7Epq/VBhIPmPDDVULkVu+1vjNBCx6y6YYCgghpN1JOHvb3vdd+zPUmoffWqH3xg4NfacVC1z8cnJr6CKUwQ98RT7parGuMyHfpftHz0AxD9Sw+iunjzicEvh1zF2rx1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYPkuJ5R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30a80e3222fso42075a91.3
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646944; x=1747251744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTze7T/nMPYLGfndPbV/+oBYxD1sIAoMG3LrG1Olm08=;
        b=eYPkuJ5RSwVBJ4FWUV9Bw2YV5LWoMGnIaJ5sxMFNnoGCVRW++ydIJGbXDpk7q5FuV8
         RyBi+5W3yeFVAIeGZUzQvS7hSgAteiM17NluziJi+ZSf9Fmusrsi20nikOQ/lZ/UUndA
         CbznwjSRqziaWLM3N/evWUcHAybZ9PorCXVLQv1hBCbZ3Uh3bVh1Ct1eGiGYgBtgXEFD
         ITTD8efmbO/pfyNbSDhtWXFvfUHUvuyRECyoC6gqmrGke/YxLEPzKxyWtMEja/1dM5/T
         hGiJNJrVIt75RTQy0fJX2gm5t2pVJ9dF40Zbs0urCWNxQVXkie/wMn8qkGWFB4Hw+uYD
         k0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646944; x=1747251744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTze7T/nMPYLGfndPbV/+oBYxD1sIAoMG3LrG1Olm08=;
        b=EuQjkzuK3TmxnAQMeSf0+RlhRzEfzoHjZVfXbqt+ecVPMlZ73UkB0/sk4nGKMEO0zg
         /wZZSbIxDANzPG4dX1sarG9oHFjqQ4Mc8bx4OU3t0W/z4bLub/Z5EyBkGYGgmM81L7TD
         zS+QL5mMrA15f9HPFQdq7eskbC8NTR/iWGJ6IUuVzr+ZXABKwKoqIFH6tR1/2vaAac+9
         JyGfbl2RY1zpFImvWZRHTvWJB6O0AOk49tKvpawAuO33hnCerZ/z7Tkg5rM+XTtDiL/e
         Fy7lNxYYmJNRTc+RKspW3ypuA3eY161F+MQrZ8IpCagMR+HMTPR7yvTF3LkqOWGSbrhC
         gd/w==
X-Forwarded-Encrypted: i=1; AJvYcCVYeijQhcCSGAmm0GXVvTR9Hhn3Ff66a894x8cZPbn0zhhAHCjStsB/yTEWw299LeDO5+erNos7nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwJn+FSByfpJPeEBb6OMBpsDqHi6p93vXuST+wVKfg06zJort
	fiah3Rb9zWlrsGDZVc7AoVN3dDnzDIWCb7x8Jy5IJPLhO2Jr2TqL6o+PfDby3K2fkNOJ0eHlpPW
	HuR7wW7h+7X/XzzC+Y/hUH24UjUE=
X-Gm-Gg: ASbGncsTuo2xxpwslbOX7TEqL7xqcwW3grYGAvj403jQWxxSnZFnFheZeiJp27R9bkn
	5X2xwvVagQqCNHnxNgIgGe70/mLGcvIGyLogoHa2x9Fa6zSmQBjg5P8uX08V5m1TBI+ehQuQZyn
	2lqCOAJ7NfxvpVxZ5TezfiyQ==
X-Google-Smtp-Source: AGHT+IGdawEqtJxVGK+JSHNRepXUXgjNBu0yjM+RsF0Eufl62wIFQjgHE5X6DJTDR4ipT4hMnCEl01mptgZsx4+0fxQ=
X-Received: by 2002:a17:90b:4d06:b0:305:5f25:59ad with SMTP id
 98e67ed59e1d1-30aac25d0a3mr2608910a91.7.1746646944387; Wed, 07 May 2025
 12:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501211734.2434369-1-superm1@kernel.org> <20250501211734.2434369-3-superm1@kernel.org>
 <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com>
 <98d527c6-a185-40f9-8ce3-46f5d7a67e81@kernel.org> <CAJZ5v0i=9fpg2YxJhd+2rAx1gkqaquoExHvgMiFefn6YqVieOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=9fpg2YxJhd+2rAx1gkqaquoExHvgMiFefn6YqVieOA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 May 2025 15:42:13 -0400
X-Gm-Features: ATxdqUFdNa1TOYCQQ4md1wN__mvI3A170baT-1F7y33oUuTC3i5KfOiznTcios0
Message-ID: <CADnq5_OUhWEfL_=hfMi8hFfMDOgR21hd5NU9TOzmePhpK5LzsQ@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/amd: Use suspend and hibernate post freeze notifications
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 3:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, May 7, 2025 at 9:17=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
> >
> > On 5/7/2025 2:14 PM, Rafael J. Wysocki wrote:
> > > On Thu, May 1, 2025 at 11:17=E2=80=AFPM Mario Limonciello <superm1@ke=
rnel.org> wrote:
> > >>
> > >> From: Mario Limonciello <mario.limonciello@amd.com>
> > >>
> > >> commit 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification
> > >> callback support") introduced a VRAM eviction earlier in the PM
> > >> sequences when swap was still available for evicting to. This helped
> > >> to fix a number of memory pressure related bugs but also exposed a
> > >> new one.
> > >>
> > >> If a userspace process is actively using the GPU when suspend starts
> > >> then a deadlock could occur.
> > >>
> > >> Instead of going off the prepare notifier, use the PM notifiers that
> > >> occur after processes have been frozen to do evictions.
> > >>
> > >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> > >> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification ca=
llback support")
> > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c
> > >> index 7f354cd532dc1..cad311b9fd834 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> @@ -4917,10 +4917,10 @@ static int amdgpu_device_pm_notifier(struct =
notifier_block *nb, unsigned long mo
> > >>          int r;
> > >>
> > >>          switch (mode) {
> > >> -       case PM_HIBERNATION_PREPARE:
> > >> +       case PM_HIBERNATION_POST_FREEZE:
> > >>                  adev->in_s4 =3D true;
> > >>                  fallthrough;
> > >> -       case PM_SUSPEND_PREPARE:
> > >> +       case PM_SUSPEND_POST_FREEZE:
> > >>                  r =3D amdgpu_device_evict_resources(adev);
> > >>                  /*
> > >>                   * This is considered non-fatal at this time becaus=
e
> > >> --
> > >
> > > Why do you need a notifier for this?
> > >
> > > It looks like this could be done from amdgpu_device_prepare(), but if
> > > there is a reason why it cannot be done from there, it should be
> > > mentioned in the changelog.
> >
> > It's actually done in amdgpu_device_prepare() "as well" already, but th=
e
> > reason that it's being done earlier is because swap still needs to be
> > available, especially with heavy memory fragmentation.
>
> Swap should be still available when amdgpu_device_prepare() runs.

We need to do this after processes are frozen, otherwise applications
keep running and keep allocating VRAM so by the time processes are
frozen, swap is disabled and we don't have anywhere to store the
contents of VRAM if memory is full or fragmented.

Alex

>
> > I'll add more detail about this to the commit for the next spin if
> > you're relatively happy with the new notifier from the first patch.
>
> I need to have a look at it, but adding it for just one user seems a
> bit over the top.  I'd prefer to avoid doing this.

