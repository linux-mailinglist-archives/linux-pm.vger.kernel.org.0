Return-Path: <linux-pm+bounces-36487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E219BF2A9D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 653884FA90C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10627331A72;
	Mon, 20 Oct 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHc3dbIv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF600331A44
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980545; cv=none; b=dCwILBrWNaWM/VVkxfc7woM2dwswJXlzru15K+BWcYo1Vyz94PfZ/SYQAGtOzhlwaqhadwnoFGRorG9H4mNE4L1IPqn4T7Wo36605VnP2iZXEeiSqecPPjEsZJ0uGR8Ziztli4OIdRLAjKAQVTfNaYGoolLeYtwkpXrm1qY6Efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980545; c=relaxed/simple;
	bh=/Bo/w1IWbEdCpFqdwJJwvlPplSNhRb4GDvaPtHIqS2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0P86wQ5cVXinu0m7MT4T08eiQv1kxaSeOrfO86yqBBKitjUBTC/vPBHPckT8T7NmMbdslTTXBwOOGfz8OB7d4uLjrCpAsdU7RwCj0424Pnv33f1sw/hWuHYKHBLFn8IM1/IWoHCaF/iiOs5Qfj4oHw6M2Qk+jc+SPrTXAjgCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHc3dbIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA07C19425
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980544;
	bh=/Bo/w1IWbEdCpFqdwJJwvlPplSNhRb4GDvaPtHIqS2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nHc3dbIvnlHbK7ZAppgVog5WwvJKdAazmoIWifi15l+mDRzKJpi0KlBJiH1SGt8lt
	 s0NeCU0/LxE1Sjll4pc2MWoc8wFPPgZilDEWz/L9O+lX37FT6d+H5rwwMXSDYodmfs
	 FWxP5W3j5W3WazmizDUU7YNQ5+OyOHBCmj+hivaZ4Kgx6jCz6nzYLgLhoMw3d4r/1B
	 8SIq1GnmnXKWqQW+8pF/q95iJgURGYqtzvwp4TgMvS5h5NRzswWLl/tX8UoJ2bvYVF
	 yzm++abYlAGpsZB39vBrEJrvvpr1yOjxdYKqqN/KwZlR3xKTItOhukxBQAOTKFaxVt
	 VQWyOmQSxBYEg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7bb79ad6857so2457430a34.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:15:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnwJ258fFyZzLMaXk7UMuKLS9bbbWT97nf9v2BREO7KegwSrIPOtJ27XxLiLaOo1o7F9dzYINOWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YztYYXiYoRwEMLwolIdrgMui7FAiGmuh99op1rxPnumEl3f5zUk
	cOEyHBTHsj6RfCmXkdQEFiNsg45rg3myYPebRHazFhNJ9JHDm84fvrhxJMSp1jqzrvM2xqIYvQG
	5zwE2ueqh/sTZFHGGZlLz8Ut06xJaKSI=
X-Google-Smtp-Source: AGHT+IFfB91PdM3JAdN1gbGd5x2R0NfKffZhpjnLvP2/4hItmtoOjnqFQsirY6tJdehIacGcQfZbbL8vCtBlKgLWvxY=
X-Received: by 2002:a05:6808:181e:b0:438:430b:3dce with SMTP id
 5614622812f47-443a2dfa130mr6084442b6e.10.1760980543788; Mon, 20 Oct 2025
 10:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org> <20251020165317.3992933-2-superm1@kernel.org>
 <c93821d6-2e59-481a-8119-1c00a3fdcd5e@collabora.com>
In-Reply-To: <c93821d6-2e59-481a-8119-1c00a3fdcd5e@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:15:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ioc=b0Z5oofvtcmJ=Mb2aBF2bzvZM71tGpa0L6k+FR_w@mail.gmail.com>
X-Gm-Features: AS18NWBmz6ZVP5RNm5vs0CgcHlNudUd7W1UYMEtj6Z5bUAS6AC0XVTH8twLSOrc
Message-ID: <CAJZ5v0ioc=b0Z5oofvtcmJ=Mb2aBF2bzvZM71tGpa0L6k+FR_w@mail.gmail.com>
Subject: Re: [RFC 1/3] PM: Mark device as suspended if it failed to resume
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>, mario.limonciello@amd.com, airlied@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
	gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
	rafael@kernel.org, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:59=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 10/20/25 9:50 PM, Mario Limonciello (AMD) wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > If a device failed to resume the PM core treats it as though it
> > succeeded.  This could cause state machine problems.

You need to be very specific here as this is a significant change in behavi=
or.

> >
> > Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> > ---
> >  drivers/base/power/main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index e83503bdc1fdb..bf9c3d79c455f 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1104,6 +1104,9 @@ static void device_resume(struct device *dev, pm_=
message_t state, bool async)
> >       device_unlock(dev);
> >       dpm_watchdog_clear(&wd);
> >
> > +     if (error)
> > +             dev->power.is_suspended =3D true;
> > +
> >   Complete:
> >       complete_all(&dev->power.completion);
> >
>
>
> --
> ---
> Thanks,
> Usama

