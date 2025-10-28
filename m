Return-Path: <linux-pm+bounces-36984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236BC155D4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A54D1885A64
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47D275B0F;
	Tue, 28 Oct 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCcEq09F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398801C6FE8
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664362; cv=none; b=C69xcjtdCT2v302LTU9qehvOlg3yg1gBMg/Bu5ff5rF1FSUcisNu1ymSI6ucgLy8E7AgRJfF9bkUgwmJ6jkYx9MdO0j1ilt0XSSALAAsZBVC5knzlBtn+zi8lHWbE3QlLas862DYTvx+4hkgPFY2Z2f4EDlq3a/GWuP2y88LLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664362; c=relaxed/simple;
	bh=i00n8zFtKP+mhhjoD55uYMZelLozBQ4aXy4CrqF63MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9IVkeWacXO0fxGY/gUFJiyBX2IxzCtCk38MPn7P2ctKOYSo1ZGpwOaBr81VJyuFhvRRbHNtMPh/QzdpcFz+CD/CChbrpZHQ5ilXGzuSZKSld6w7p0gUXaEFIuDvU5igAmnxkIEzO4L/vb3n0wTKncGitLSMkU5bjoI9TgFXsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCcEq09F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97717C116C6
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664361;
	bh=i00n8zFtKP+mhhjoD55uYMZelLozBQ4aXy4CrqF63MA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MCcEq09FD9T4xr1diuip6Z0gox/Rr/KVB598GyvI6rkg5t1vCpnml6L1gesv/Kd/k
	 UE0ZXw5P/ifI/pZyTV84hUpBgy8xmLEHP3H+qJ3lB8FqlixRC6pI3VRTqu7Fr3AP2p
	 hIbE90NCxe0WYktM/0btNH291gppTPVd/BHG5AAqy5YXzYnHJqLaKt5U94Xl7wc+7d
	 Smz0IT8y0eltDVvKhDCDsjeDX73llazN0lxC1OgqsV/llnxOmsvM7/dAEf32L3gd56
	 21xugBtVLyxo2UatzmIBmqsAL2JhBj+vLMf9fcwoackQKurIuojmUIRMuNDVpmFMEy
	 GMzJtz1aZSrzw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3c73e93eadfso2183838fac.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 08:12:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVS5pazB+Rt1FGCroese/5dQewZNmEqWI+zxWSZrbpYNj95SsMWCDl4ESJwsfEbuPwM0tGHR/t6GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KGHTiJER89hnaNZY3S8CmP3/9ECoJKnvyuKYUt4+kmWVvGL4
	BGWK7m+l0LjFkFRas0awVRZdtozlnmedirpkiWleMybckVDPJ0JSNuz9TrNxSdpWbwUydpb8lGh
	yyzjwAnzm2kpx+TAJRlz8FpOBSwQPph4=
X-Google-Smtp-Source: AGHT+IEuOdDSyU9iNzilvEGk6zUlv5kvr73w1riKHIuVfEde781Ya6iiulxWyhWwZyo32pqGXM+e/C7QQGthCoWWQo4=
X-Received: by 2002:a05:6871:7803:b0:3d2:b176:8f2e with SMTP id
 586e51a60fabf-3d5da19c3d5mr1544868fac.44.1761664360852; Tue, 28 Oct 2025
 08:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026033115.436448-1-superm1@kernel.org> <20251028111730.2261404-1-safinaskar@gmail.com>
 <CAJZ5v0iziWj0dWWFMz-otXAt2c1PBp6RwQKVjt_hwbrU4B_fVg@mail.gmail.com> <CAPnZJGCOR_zCOvLPdyYARQrZdafvBGwkXaDO-MGA6axw4etEsA@mail.gmail.com>
In-Reply-To: <CAPnZJGCOR_zCOvLPdyYARQrZdafvBGwkXaDO-MGA6axw4etEsA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 16:12:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jT222NbgqUp4VNfTA3sUNuG1dEoBBCCtFg78ZQQwm0dA@mail.gmail.com>
X-Gm-Features: AWmQ_bnzBtq80brWlEpaL5vxLAg1dAYOSsy3Zf_o_Plica9GRE_q6ItajHQAiEc
Message-ID: <CAJZ5v0jT222NbgqUp4VNfTA3sUNuG1dEoBBCCtFg78ZQQwm0dA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
To: Askar Safin <safinaskar@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, superm1@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, mario.limonciello@amd.com, pavel@kernel.org, 
	rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:56=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> On Tue, Oct 28, 2025 at 2:49=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > What kind of damage are you talking about, specifically?
>
> Again: "pm_restore_gfp_mask" will restore "gfp_allowed_mask" to its
> normal value,
> which will contain __GFP_IO and __GFP_FS. Thus "pm_suspended_storage" wil=
l
> start to return false.
>
> But "pm_suspended_storage" is called here:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/mm/swapfile.c#L1895
>
> (Also, please, read that big comment at this link.
> Well, I have to admit I don't understand it in full.)
>
> This check is needed to prevent swapping out pages during hibernation.

It is actually more complicated, but fair enough.

Basically, the concern is that a swap page can be freed and then
re-used for storing another page of memory after the image has been
created, so the swap metadata in the image would not match the reality
any more.

> Call chain is so:
> swap_writeout -> folio_free_swap -> folio_swapcache_freeable ->
> pm_suspended_storage
>
> So by calling "pm_restore_gfp_mask" we allow pages to be swapped out.
>
> But we already wrote hibernation image by that point!
>
> So swapping pages will make our swap partition inconsistent.
>
> Moreover, as well as I understand, whole reason why we deal with GFP mask
> in hibernation code is to prevent swapping out pages.

No, it is not the whole reason.  It is also done to avoid accessing
swap devices while they may not be (fully) operational.

> We restrict GFP before creating hibernation image here:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/kernel/power/hibernate.=
c#L463
> .
>
> We do this (as well as I understand) to prevent pages from swapping out.
>
> And, starting from that moment, as well as I understand, we should
> not restore GFP mask until either:
> - we resume
> - hibernation will abort for some reason (for example, "wake up event
> detected during hibernation")

Again, this is slightly more complicated because the GFP mask is going
to be restricted again shortly after being restored temporarily by the
$subject patch and if no memory allocations happen in the meantime,
nothing bad will happen.  Also, if those memory allocations don't
trigger swapping, nothing bad will happen either.  Now, it is quite
unlikely that anyone will attempt to allocate a lot of memory during
the "prepare" phase of a suspend or power-off transition, so all of
this is not super-worrisome, but I agree that avoiding all of this GFP
mask restrict/restore dance would be better overall.

I'm going to remove the  pm_restrict_gfp_mask() and
pm_restore_gfp_mask() calls from dpm_suspend_start() and
dpm_suspend_end(), respectively, but that's not a change for 6.18.

Thanks!

