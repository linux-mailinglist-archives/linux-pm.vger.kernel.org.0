Return-Path: <linux-pm+bounces-23490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6EA5030D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 16:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E118842F8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9924A052;
	Wed,  5 Mar 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpW3yggm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC127241CA0;
	Wed,  5 Mar 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186665; cv=none; b=GxZ+nDvkNL1LT3fu4nvX34fx9n47vPWYxpmlApki4UK9Lx6VOTaPyyHTrmBa2mz3iCIh5erDPV2TDYgR/1JTisDbRxVNcbJuuiknQT0hi/dpo1voaX0Y/xxc8vyKSGBnmzz9CJzwVCMV9OHpyoWZkeueUQVisacCPC/8p9Z5bfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186665; c=relaxed/simple;
	bh=1Gl63dkDn6YzbWhpJHr86mBXDaJRRA0A/VL5dyST0Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZuc2ptwcLfLnSK/eYaeyv53OmfIatdletRjU0uC+92R1fiX3rUSluMj/6Zq10XNTxMDh+t2YcAC4yFTtHROOFstjx8VJAEdOfcZP8LrI7hTWGu9z7qc5DLeoxp16jGqT1FXTfCrfRQVOgNvo8Jdofkkpsfq6UYxtBkv4uIkbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpW3yggm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A709C4CEEA;
	Wed,  5 Mar 2025 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186664;
	bh=1Gl63dkDn6YzbWhpJHr86mBXDaJRRA0A/VL5dyST0Ro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BpW3yggmd7ODf5pzH0d5SReTzmSwrcsqOPrOUG8ua8kCKHH1C7zt+Vna2GsFPM89z
	 Y4hS+ilKjgM4Ma328JcmNeHtmY0+yBkci2CTwTDexDbFKZrI22MkYLrelsL+FnzmLs
	 k7hFixlnHi8pAS+JnonJXvpPt8gfiEpPXuL1H2cuz/qAxLjL3m/VQN+H4IPJk9dQ9a
	 ++7qHUF9si/CRgKal/Lg+OXYnvT75HoY/fepSLoEM6sNl3AXGdWr3AXMFjNO/D2/6S
	 75Mi7PKqeVTNiRsl7l/UBsjMTZkUzm0M0it/anIFAi4k+KBBtHv7AiefmSFyMaR2ww
	 SnkOrYTYJ9N5g==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6001060115bso1602392eaf.3;
        Wed, 05 Mar 2025 06:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPrq8kIA4rKSSmVDaOKySR+jP4qQKXgMSukyvFGST/Qj0tZvmArY2Gdcrh+N3Jcd+SYbTDO4b09mA=@vger.kernel.org, AJvYcCX68M2BHrcNWBo8X7RBqBlgOkYyeDRCBAqxRVA37t1s92veOhK/YqVd7k1BsvBulDwbjcg1q9kdu6ivXEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5S9HoQ2TpzutlQA0a5iW34uQ1m1cvtMoY38929Px7u3b85Ep
	k8Rz40dwRh+bx/11FqalxKCc5k9k7ne+QBBSTgKaSwIg/aiNAI/ZVWlU0au2nHHgtHrpKXfjUOH
	+EZhvGVgHf4lNEsNB2TwcndtgbEM=
X-Google-Smtp-Source: AGHT+IFrp15y/CCHFHM8ClNOdliUQk6Gp8kcuTU19LoJl8SFC7OzoexHyamhW/uvTFwPp3lLv4Y4oc8fNnMXq6XFVjs=
X-Received: by 2002:a05:6820:a01:b0:5fa:6805:645b with SMTP id
 006d021491bc7-600336499dbmr1682833eaf.6.1741186663541; Wed, 05 Mar 2025
 06:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219091109.10050-1-xuewen.yan@unisoc.com> <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
 <CAB8ipk-qYR4LncOi2ue6Rbdc6CqX67_OydcOp14Yj=afYZPe=Q@mail.gmail.com> <7bc89310-c0db-4940-8cd7-86566ecb5c65@arm.com>
In-Reply-To: <7bc89310-c0db-4940-8cd7-86566ecb5c65@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Mar 2025 15:57:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j3+TFB22FKcGMdy6bfvczAcp+egWv5WjY9dWmHKh8fpA@mail.gmail.com>
X-Gm-Features: AQ5f1JoSo8eNhPNHqvOq89t9K7B1E5EMRUYkiyzEstbu4yChAy-xnfDK2hhxN58
Message-ID: <CAJZ5v0j3+TFB22FKcGMdy6bfvczAcp+egWv5WjY9dWmHKh8fpA@mail.gmail.com>
Subject: Re: [PATCH] power: energy_model: Rework the depends on for CONFIG_ENERGY_MODEL
To: Lukasz Luba <lukasz.luba@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, linux-pm@vger.kernel.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, jeson.gao@unisoc.com, 
	di.shen@unisoc.com, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 5, 2025 at 10:51=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 2/13/25 02:18, Xuewen Yan wrote:
> > Hi Rafael,
> >
> > I noticed that this patch has not been merged yet. Do you have any comm=
ents?
> >
> > BR
> >
> > On Thu, Dec 19, 2024 at 5:17=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >>
> >>
> >> On 12/19/24 09:11, Xuewen Yan wrote:
> >>> From: Jeson Gao <jeson.gao@unisoc.com>
> >>>
> >>> Now not only CPUs can use energy efficiency models, but GPUs
> >>> can also use. On the other hand, even with only one CPU, we can also
> >>> use energy_model to align control in thermal.
> >>> So remove the dependence of SMP, and add the DEVFREQ.
> >>
> >> That's true, there are 1-CPU platforms supported. Also, GPU can have
> >> the EM alone.
> >>
> >>>
> >>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> >>> ---
> >>>    kernel/power/Kconfig | 3 +--
> >>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> >>> index afce8130d8b9..c532aee09e12 100644
> >>> --- a/kernel/power/Kconfig
> >>> +++ b/kernel/power/Kconfig
> >>> @@ -361,8 +361,7 @@ config CPU_PM
> >>>
> >>>    config ENERGY_MODEL
> >>>        bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
> >>> -     depends on SMP
> >>> -     depends on CPU_FREQ
> >>> +     depends on CPU_FREQ || PM_DEVFREQ
> >>>        help
> >>>          Several subsystems (thermal and/or the task scheduler for ex=
ample)
> >>>          can leverage information about the energy consumed by device=
s to
> >>
> >> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>
> Gentle ping. You probably have missed that change for the v6.15 queue

Indeed, I have missed this one.

Now applied as 6.15 material, thanks!

