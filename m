Return-Path: <linux-pm+bounces-40481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70575D0434B
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06EC2307E28F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7482DB781;
	Thu,  8 Jan 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEhiROL8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628252DA775
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887826; cv=none; b=kGSXPiLw5NjUsdRzFU7W1fXsNrCrjLCZV/pezj1oSsNIWBt1ffTfr6XY7Hl5vTef/JyJ3VG6rlUcrhrKYRCMPqbY+pDh25uFsA8JAh3M5oBYGcx7sknLxTYq3f7Onm94+uhiDe2OPcqkLdClMmADDGOd49i8pRXgjAboF2y/Oqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887826; c=relaxed/simple;
	bh=XYY1AIUn55S9FRrCRgnns51o8NkVBTf012+7nx4yISU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtb/YNX5MsskQ6apRmkwCX3YYcy7aigOJI28KpMJLisPGM0GXkcc/aPvSpwRymig1MQq957ic56qNOtgBKoTutwsZ1R1ONPcLZGqGSEQ1Lb2S3C4QuJwqORaN0NX0wiYbfVHx+K3mn//edDiPg1hbIg96TOE7YTT+r7p5RvyssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEhiROL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B8DC116C6
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887826;
	bh=XYY1AIUn55S9FRrCRgnns51o8NkVBTf012+7nx4yISU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KEhiROL8pxbpy8C+ry6OsqqZYhYrtBNk9DKuZuwQMzo2X60ARZuAIdveO6OAuNv2S
	 o0ABqtMun3zY/mXwxnxIRBs103GJ4Tzqw4CmnU6kMG2nIR/PcjqI8Hu7/LSkyFP8gY
	 p6UOwU62MCTexnKJGiNA4/6Ei3tJL2ZeBA0XWYI6n6gLB2e0+huWtasnCfkH2oQ8Ds
	 HM/BpkVUtQrqNtJxmxxrTVcjWOP6GyQQ+3OxVyukcKlQvLp0zP0ZO6Mz5C+ZH2km3H
	 y5hu+10Mkal6jvBRDOxijVKR1Nrca/t7eIHllmHAVlUZy9rSrebXxb4o7JRPJHpZoK
	 s4ld9FV+33qWQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f11ad6e76fso2767099fac.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:57:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyDYrnPcTPXpbWX2VihvYZSkPkD7CsQex2wRTJ0UNIcklGa4y3DhZGmqZxGWbuIts39prEHqv42A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NWzOmlNXj7ESOCkPFvH03TIKcX4+gIfw5S3/3Rlfm+QE15eQ
	fQyJnBfz9rG597BghEOwGJyhq98EZU3sVnmUdauPZUkGwnGPkCarzyRvMpYJO5OOipDFuR9Vw2O
	glojKW9BbJbEAhGsQyJ2Au3Y9tG5tspE=
X-Google-Smtp-Source: AGHT+IHQdhXAS/VBbejzMSxg4Ih9pXi7CLX52X1PqBKKOTniSYJvE7EpdgqV+jQaC4BprcGb0z+blh5EsuJNdUHA/P4=
X-Received: by 2002:a05:6871:549:b0:3ff:4663:3562 with SMTP id
 586e51a60fabf-3ffc09793aemr2738663fac.13.1767887825013; Thu, 08 Jan 2026
 07:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105103730.65626-1-mrout@redhat.com> <28e46f37-54be-4c28-a7a8-2b3e80a8cd30@igalia.com>
In-Reply-To: <28e46f37-54be-4c28-a7a8-2b3e80a8cd30@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 16:56:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+Lz7ePtfbcVSyRqNPwLQNDoPT9zQ+a=7JL0S0RSR90Q@mail.gmail.com>
X-Gm-Features: AQt7F2pCUyqU104FG_UDvj5RiMqv3fCGmP_fdrtn8lTAJaX7EU0279ic3DAZcwg
Message-ID: <CAJZ5v0j+Lz7ePtfbcVSyRqNPwLQNDoPT9zQ+a=7JL0S0RSR90Q@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix memory leak in em_create_pd() error path
To: Changwoo Min <changwoo@igalia.com>, Malaya Kumar Rout <mrout@redhat.com>
Cc: linux-kernel@vger.kernel.org, malayarout91@gmail.com, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:44=E2=80=AFAM Changwoo Min <changwoo@igalia.com> w=
rote:
>
> Thanks, Malaya, for the bug fix. This makes sense to me.
>
> Reviewed-by:  Changwoo Min <changwoo@igalia.com>

Applied as 6.19-rc material, thanks!

> On 1/5/26 7:37 PM, Malaya Kumar Rout wrote:
> > When ida_alloc() fails in em_create_pd(), the function returns without
> > freeing the previously allocated 'pd' structure, leading to a memory le=
ak.
> > The 'pd' pointer is allocated either at line 436 (for CPU devices with
> > cpumask) or line 442 (for other devices) using kzalloc().
> >
> > Additionally, the function incorrectly returns -ENOMEM when ida_alloc()
> > fails, ignoring the actual error code returned by ida_alloc(), which ca=
n
> > fail for reasons other than memory exhaustion.
> >
> > Fix both issues by:
> > 1. Freeing the 'pd' structure with kfree() when ida_alloc() fails
> > 2. Returning the actual error code from ida_alloc() instead of -ENOMEM
> >
> > This ensures proper cleanup on the error path and accurate error report=
ing.
> >
> > Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a perfor=
mance domain")
> > Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> > ---
> >   kernel/power/energy_model.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index 11af9f64aa82..5b055cbe5341 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -449,8 +449,10 @@ static int em_create_pd(struct device *dev, int nr=
_states,
> >       INIT_LIST_HEAD(&pd->node);
> >
> >       id =3D ida_alloc(&em_pd_ida, GFP_KERNEL);
> > -     if (id < 0)
> > -             return -ENOMEM;
> > +     if (id < 0) {
> > +             kfree(pd);
> > +             return id;
> > +     }
> >       pd->id =3D id;
> >
> >       em_table =3D em_table_alloc(pd);
>
>

