Return-Path: <linux-pm+bounces-19637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F29FA1B6
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 18:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38191188D520
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA90154BE4;
	Sat, 21 Dec 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TafH1u09"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD64156C7B;
	Sat, 21 Dec 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734800824; cv=none; b=WPaZ6GkPc2w6zzdEvzYdFfL2S7FATHaLt/Y94c0aA+90hsq0hyGl8I8K/HIHjZLfkB0+dHehJ3+k6TxaaJni/eZXoG5mkS5/rigIbTKxJGS44ehy++eQ/g5IupFyNPMYyusYUof2ZTUp4EJUtPmUM5QflF/NdFXi0fhPerebUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734800824; c=relaxed/simple;
	bh=ntQ1w7hCL2FfP5YiBa8pKaUnHZpiLMoDT4MOibVnz/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBUGFsTuhXPFVGR1bKS93a9KCT81R+MDRJGHTYaaUtSuulg+M+DW96LC+GC6zkZI9vLp5ATSncQDGb1CRT49FxR5R3Ixf/KmSOtt8tP7jyGuZQklLS4mpWX2l48SqK2l9Cajz4hC48e143CUCVpB6wwq9eEGWQZwvrVR2JRlGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TafH1u09; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so3731718a12.1;
        Sat, 21 Dec 2024 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734800821; x=1735405621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEfG3d6d7WLv7fjVd9xW17rD/4mmuIy3K8PbZK17npg=;
        b=TafH1u09b3pS/3sFjZEKL5pph/g/P0rpELt0wuPIps70onphtBzl/0GrZRGf72IixA
         ku3VD8hesVmmL5yjSjRTixBivtXxphE85WX5OvRZrSrfG3Ko0BFz/3ZRupEop4TYk+Qp
         /wMJi6ZFGiifzPPLbTWTjLIxVaYIQQxE/Ky+XOkopKJiFTfn7Xsblt7SWlgxf7gVMGFo
         TiZ5vLYI73NJz1fdnD/Q1RPjayjUZQFk2Q11GN1Kzcrkc11m5erpEFeLtNMzmd+lYPrR
         38p2Gbnq/my5NwehjhyBpZ8+a+2wJRLy6Lf35JRNFdeTDwNvNQ80tG9bbClyC+wWsMwJ
         qD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734800821; x=1735405621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEfG3d6d7WLv7fjVd9xW17rD/4mmuIy3K8PbZK17npg=;
        b=q7+HXzEInkshwjrbJwM9LnJtLjPcHeT1/QlwHBjohuNCTcN6qOKeir0CGnhXnaweos
         w1vCsg+/oJojbaNABoZ17Da75baHbI3qiHC+5PMpFHTKZ1HGrRP5GQu8TKklBT4Qa9G3
         ld9h/by5bI13UuP1peW9CVVOtF29/0iDDz4GoCd15h8rYadaelYJkB+us04YI2UCLP0k
         5P+TmxsU6owggsXHasaz2ET+5504LX1hx7KwF/WObnGhAy9FBt/2+wzbroRyPntCd3br
         d2a0QBxtei5w6vlV5tvtxAMZiGGJyewsrXyTbeuZ7TCBRAK2oJHoxZVXT5j/jSy4IvTN
         d76Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs2emRZGFr4w8FMv/ss96AihMgBGlkSo9sNvYKuwbsRjCgkDWqsQ28tjj8nN+D9Pxz4iUdU2zTLN8=@vger.kernel.org, AJvYcCWgxj9EbiJZCk8efZBno4Nw/RjbFPSoco/aIR6D3zOGX+8VHc17VybXpybjnkxF6+QI0BC2EDdYoGrbcdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYinwTpKM8ORAYigivrW+QXc+gxEQ3WJU0nvSy11KzqczqobOj
	Vo94gMSeyBawTtb1uWp0LxNCC3MWZXWX7XwRlfo4MlrlvTIWBO9PPID67X0VamHWP2pJj/cniaR
	9bbiJ7Ds6UsTWKt05JUpHPF9IabEANQ==
X-Gm-Gg: ASbGnctJWp82Ny8XqdKH7KTWuSWsRY4WaM+pUEn5K/KPsI2fZitNGxoaBVKJOemvErc
	ijpfVCUQr8j9rw2E3pCN+Ly/2o9cyMDq46gw2uqNV5Zr5ZA4lHlKUPOj3eUM34ENwUexH+hDe
X-Google-Smtp-Source: AGHT+IE1/1OVE5AnLq+329uNuh3sK5Xji4OEC2Nec6zPoPoQZ/dvUnHCWIySXcihqV2FNfzXkQmWJZ58Hn7BpfpDf1s=
X-Received: by 2002:a05:6402:4023:b0:5d1:3da:e6c with SMTP id
 4fb4d7f45d1cf-5d81dd8ea06mr7381905a12.10.1734800820757; Sat, 21 Dec 2024
 09:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212161608.24730-1-pvkumar5749404@gmail.com> <CAJZ5v0hQfGdsjy-VQmw4HV5Bqcv7mvR_bLnabGKb7E-obJb2Zw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQfGdsjy-VQmw4HV5Bqcv7mvR_bLnabGKb7E-obJb2Zw@mail.gmail.com>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Sat, 21 Dec 2024 22:36:48 +0530
Message-ID: <CAH8oh8V_aeg2eo0QQK-4oSHr4ZZbLh9iKJ8hM-580sDBcTHOPg@mail.gmail.com>
Subject: Re: [PATCH] doc: power: Add missing parameter description for memory_bm_create
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 7:28=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Dec 12, 2024 at 5:16=E2=80=AFPM Prabhav Kumar Vaish
> <pvkumar5749404@gmail.com> wrote:
> >
> > Added the parameter description for bm, gfp_mask and safe_needed
> > for the function memory_bm_create
> >
> > Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> > ---
> >  kernel/power/snapshot.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 30894d8f0a78..690dd1f467b9 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -680,6 +680,9 @@ static int create_mem_extents(struct list_head *lis=
t, gfp_t gfp_mask)
> >
> >  /**
> >   * memory_bm_create - Allocate memory for a memory bitmap.
> > + * @bm: Memory bitmap.
> > + * @gfp_mask: GFP mask for the allocation.
> > + * @safe_needed: Get pages not used before hibernation (restore only)
>
> This isn't exactly accurate and I'd rather drop the comment entirely.
>
Is it like the comment is inaccurate or the comment is not needed at
the place entirely ?
> >   */
> >  static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
> >                             int safe_needed)
> > --
> > 2.34.1
> >

