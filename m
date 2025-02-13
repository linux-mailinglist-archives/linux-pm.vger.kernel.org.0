Return-Path: <linux-pm+bounces-21995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FCA3356B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 03:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6797A10E5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 02:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7A1F75AC;
	Thu, 13 Feb 2025 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djvjLIp9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAE1553AA;
	Thu, 13 Feb 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413153; cv=none; b=mdDBNEmZuAnOx0Y8Dt2qFS0emrUZ04eORZHk59SK36H6CEPiqECsf5rE9tOlR7bTAm5cI0JC/oUuimOKVmCwLDhvdRravt4V9ZgqasPQ+zNZk2iYHns7cl+QlnsVStKyPF7bSxGCCzvR6pb44ruoumeQDlMQlh6L+bnHZTOvGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413153; c=relaxed/simple;
	bh=xXGK+hkiNAqmGRDzJim5UG5/4YOulKq8CXtmJjqHxbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR8hmfYp9zCrLQrjT7TS4rZGDTuT5RsIXXgflgAygCUdAlDWhLX0qs1MBd/sCoHWqTY6GcoQfSVHZBObxrtCntvTe0C6T/k4+QmSM9oLPKn1IMugYU5elL9xuEcmHoianyF6t+U8Pu7hKlUv1F1vjsMusPR5p9vPD7JGof4ouKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djvjLIp9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso581597a12.2;
        Wed, 12 Feb 2025 18:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739413150; x=1740017950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThEK+8ls/3g31TOtGvnpp5N+ZnnkdrOcxxsDcqY6f68=;
        b=djvjLIp9CcBE4urFIO/2gAt9OKCM3Oz0ZjaZe4XvozZeq3j57/HGk0pV7SWk9uwVYm
         VMtSZhEgXMFMzk7XxpmeZd4h1F03EJCUU8TEuOp8k7eJJxEXyq0UZA9CnU/G/rmu4fl9
         oW6DskGne+gLSktoaq5NjaomTI/clBq8QfD+WxIZUKfr1gvTPHesNVuj/DDha8OpNEzA
         CXOf0QTm8SKVBF9QKNsoWqGdvyqftDmwPy15wmkddLrJ94OTWgJPW2SQp4jut2WI95mi
         WCeb72TbFv43Z2o42cwx4Dhw3Ugs65cjMocHyxfeXFGYxLCfVPdcagQdOtfpJkbdHtXe
         O3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739413150; x=1740017950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThEK+8ls/3g31TOtGvnpp5N+ZnnkdrOcxxsDcqY6f68=;
        b=aoBzIM8AGWvnm7bnhvfAb0ddALP+6Rayb2dZxcDksixDdJf/3Kb1QISWAh8Zk7F5KA
         6+wVA1+t8JQyotILd16c2l6OhfM3sx2426utOTXGpIjukQEsxVG97MV6pd5d/v9ZNiAz
         z6J7p4wwTJJREP89NCx/tXAYOHWWoFskEnI1wQzSSHfZX3XGDU6YE/B30ghFuguZKgu2
         awi807fWLybW4xILy2p+DOUj21AZMnrwg21a4DtkmmztFXXjsM2ZuPJGttqNy7VlsDjL
         hE2QTSEmMB5vwSGiItAG8ll0qMLKRDKZLgVpmUKyc/v8jdmFOyxy3RVqO6/1pbFMWHZB
         827w==
X-Forwarded-Encrypted: i=1; AJvYcCU/mwd3rqCVC0PMzNUqs1t2K0zm65gvIpFyJLR9GqfKft1GfPZrWhYf12uhUmh+vdrMsxucsF8xj8Q=@vger.kernel.org, AJvYcCUB0A8T3kHL62gw7Chusd+o0DHJ8NyX8ErLaHN0A24G46cezWWyPQxxLEe8TBQJxx245R5pDEGCKVu1RhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6ztzO4yUQ0nYg+QgpUuwLg2yZbB7XChLCagUe1j54G/P0/NL
	JWPwKkAWp95grfEhgKgYJ/HWcf6DHE2fUCR1hEwd9nf1G1ZFWswTrv0LRkTVxIxJ8enZ/Q2yTSR
	u9/f7LBKMZzEDh794vlWHHZL6St7nOPcx
X-Gm-Gg: ASbGncs9ZQZyOxt6jPmMlXqbDoiRxNV7x1L54RqS2Zxi5/cLGWge7Fic8TezCylVknT
	NJPB5Iwo4gPhA3WihLhGV233dhJ9H+5Gmq1FHpJe3dR9WhK7TpbrEMV9wgyqtjDXn2EDHiSfy4g
	==
X-Google-Smtp-Source: AGHT+IGAxr5YqQUvSoz9+MenQqpjAtscKqMAuPz/l84gJauDI4Dsyr3o6SY6QbHaooalN8wF/Wi8bAev8HGm/mDMrA0=
X-Received: by 2002:a05:6402:3715:b0:5dc:a463:aafd with SMTP id
 4fb4d7f45d1cf-5dec9d3235amr1017254a12.4.1739413149552; Wed, 12 Feb 2025
 18:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219091109.10050-1-xuewen.yan@unisoc.com> <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
In-Reply-To: <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 13 Feb 2025 10:18:57 +0800
X-Gm-Features: AWEUYZnhPboBY5GOcVpSt__jsVyo_2OnZr2KiqQVob_S5bCWyffDCJ5Ra3xMLxk
Message-ID: <CAB8ipk-qYR4LncOi2ue6Rbdc6CqX67_OydcOp14Yj=afYZPe=Q@mail.gmail.com>
Subject: Re: [PATCH] power: energy_model: Rework the depends on for CONFIG_ENERGY_MODEL
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, linux-pm@vger.kernel.org, rafael@kernel.org, 
	len.brown@intel.com, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	jeson.gao@unisoc.com, di.shen@unisoc.com, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

I noticed that this patch has not been merged yet. Do you have any comments=
?

BR

On Thu, Dec 19, 2024 at 5:17=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 12/19/24 09:11, Xuewen Yan wrote:
> > From: Jeson Gao <jeson.gao@unisoc.com>
> >
> > Now not only CPUs can use energy efficiency models, but GPUs
> > can also use. On the other hand, even with only one CPU, we can also
> > use energy_model to align control in thermal.
> > So remove the dependence of SMP, and add the DEVFREQ.
>
> That's true, there are 1-CPU platforms supported. Also, GPU can have
> the EM alone.
>
> >
> > Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> > ---
> >   kernel/power/Kconfig | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index afce8130d8b9..c532aee09e12 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -361,8 +361,7 @@ config CPU_PM
> >
> >   config ENERGY_MODEL
> >       bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
> > -     depends on SMP
> > -     depends on CPU_FREQ
> > +     depends on CPU_FREQ || PM_DEVFREQ
> >       help
> >         Several subsystems (thermal and/or the task scheduler for examp=
le)
> >         can leverage information about the energy consumed by devices t=
o
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

