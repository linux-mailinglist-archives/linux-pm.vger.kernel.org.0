Return-Path: <linux-pm+bounces-23576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53145A556E9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 20:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85663169E5A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0E26B2AE;
	Thu,  6 Mar 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl/CvLJc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5291DDA8;
	Thu,  6 Mar 2025 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289913; cv=none; b=NX8ILdyCmUskGyru3T9RfxjWyxCTFyLhThIf+v4mM9if5Z0vjy+H1gBSL0ALgs4S0esAAUunuSBI6ICmb2pV+JeBxOec8OOv1P6tdP+B/fsX/9oDqbg6J38t63BsFFn9e31KzXWWcLQqd/gEiXo532QjWBNGiLnSCUS6NbiNLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289913; c=relaxed/simple;
	bh=CLkizdwL2PaxijEb/elPuRAA2i2qQxIVszjmlvOsl8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffmDiELLtJ1dTQM0VW4MbI/8X7RncfgmY+ZpH3xjOYxYEYSZktNVf6LXDGQGe4ljZN/0p8RhlxuSDb0IvxlkjiDYTr32IyA5/B7qvHDLIMAWWsVhLFonQFep0IA6q8SVaeQT80j0YTHasFvJgZ9LcymG51SLOX0YtnWh72+3CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl/CvLJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5F8C4CEE4;
	Thu,  6 Mar 2025 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741289912;
	bh=CLkizdwL2PaxijEb/elPuRAA2i2qQxIVszjmlvOsl8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dl/CvLJcCi7v/BW+oxmiPU88yLPDXQV4kXCGbLxAnO5u2WK/oQcQNCXD5CogMvOws
	 9B7UtkCyB8qDScj0my5w2B5/7i4GoOnzV3edusNRI51ExZ9XQFfuPtQKr28/p2sozc
	 aERr619V6vC45NJEm/z3FSCN+2AvFXkReG6embswvsCIpsk3nE3qQg32HXgz/LvZMJ
	 gZ3T1xc6Bi8vZyxawdVp88tRTqH2KOsVtFf8u0ZO5tJ4gcYfp/3MD+8ARC1Qrv7aHC
	 YnIrHriQ1WbI4pRREOQQVRafiiUvBmiKwiFm8/F0qTptrdrFEBNvC2qU1ALBn9Yltd
	 6th1iHdyk9JmA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6001060115bso512318eaf.3;
        Thu, 06 Mar 2025 11:38:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLLUw3ZxgJxC5R2psPt8TQxuwpHKQNv/VqRXjDn5NEEMIn66hh1xtrELAuavwGRGzZFWLoZ2wKfQM=@vger.kernel.org, AJvYcCXJNCg9z5KfeLRYZQqaAdv6+HZSlLrclHi/a6eZ6nd5MchnL3Punmas7pgZVACHaKSXXrXFB+iW3u28AmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjywean+E1gnAjtz3G3yMQBuQ/+QcYVXelGblE5Ttxeu9jULuX
	wWKfLm15u3mvi7kyNrdoYC0e8TnPkuqx6VwGFpxDm/NqH+WEpCNwbErFuqV5M3uVFSfuuw8l/37
	CT+tbPL3wjeSYeWwzX+172yO7dR8=
X-Google-Smtp-Source: AGHT+IFVJh7lbhZA9B1w8khGnBS8dollYchSr5l3VYxVvpUTw11EPsEEWMnV52SHqpY7jGbHpGATgr1grisJWk8GAbQ=
X-Received: by 2002:a05:6820:209:b0:600:2ad1:5f3f with SMTP id
 006d021491bc7-6004a78c51cmr374542eaf.2.1741289911576; Thu, 06 Mar 2025
 11:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219091109.10050-1-xuewen.yan@unisoc.com> <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
 <CAB8ipk-qYR4LncOi2ue6Rbdc6CqX67_OydcOp14Yj=afYZPe=Q@mail.gmail.com>
 <7bc89310-c0db-4940-8cd7-86566ecb5c65@arm.com> <CAJZ5v0j3+TFB22FKcGMdy6bfvczAcp+egWv5WjY9dWmHKh8fpA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3+TFB22FKcGMdy6bfvczAcp+egWv5WjY9dWmHKh8fpA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Mar 2025 20:38:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1v7AEycKDB_U4mQYP-JUQoqC1Nw3Dm16UGA8Hab_fWw@mail.gmail.com>
X-Gm-Features: AQ5f1JpPSnt76r5uMJlaUcLw0txveon_4t5IrqZsuWQ8TVLiv5MIQxa2-szJ-iU
Message-ID: <CAJZ5v0i1v7AEycKDB_U4mQYP-JUQoqC1Nw3Dm16UGA8Hab_fWw@mail.gmail.com>
Subject: Re: [PATCH] power: energy_model: Rework the depends on for CONFIG_ENERGY_MODEL
To: Lukasz Luba <lukasz.luba@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, linux-pm@vger.kernel.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, jeson.gao@unisoc.com, 
	di.shen@unisoc.com, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi,
>
> On Wed, Mar 5, 2025 at 10:51=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com>=
 wrote:
> >
> > Hi Rafael,
> >
> > On 2/13/25 02:18, Xuewen Yan wrote:
> > > Hi Rafael,
> > >
> > > I noticed that this patch has not been merged yet. Do you have any co=
mments?
> > >
> > > BR
> > >
> > > On Thu, Dec 19, 2024 at 5:17=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> > >>
> > >>
> > >>
> > >> On 12/19/24 09:11, Xuewen Yan wrote:
> > >>> From: Jeson Gao <jeson.gao@unisoc.com>
> > >>>
> > >>> Now not only CPUs can use energy efficiency models, but GPUs
> > >>> can also use. On the other hand, even with only one CPU, we can als=
o
> > >>> use energy_model to align control in thermal.
> > >>> So remove the dependence of SMP, and add the DEVFREQ.
> > >>
> > >> That's true, there are 1-CPU platforms supported. Also, GPU can have
> > >> the EM alone.
> > >>
> > >>>
> > >>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> > >>> ---
> > >>>    kernel/power/Kconfig | 3 +--
> > >>>    1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > >>> index afce8130d8b9..c532aee09e12 100644
> > >>> --- a/kernel/power/Kconfig
> > >>> +++ b/kernel/power/Kconfig
> > >>> @@ -361,8 +361,7 @@ config CPU_PM
> > >>>
> > >>>    config ENERGY_MODEL
> > >>>        bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
> > >>> -     depends on SMP
> > >>> -     depends on CPU_FREQ
> > >>> +     depends on CPU_FREQ || PM_DEVFREQ
> > >>>        help
> > >>>          Several subsystems (thermal and/or the task scheduler for =
example)
> > >>>          can leverage information about the energy consumed by devi=
ces to
> > >>
> > >> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > Gentle ping. You probably have missed that change for the v6.15 queue
>
> Indeed, I have missed this one.
>
> Now applied as 6.15 material, thanks!

And dropped because of

https://lore.kernel.org/linux-pm/202503070326.9hEUez42-lkp@intel.com/

Thanks!

