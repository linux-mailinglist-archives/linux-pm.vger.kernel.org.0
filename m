Return-Path: <linux-pm+bounces-36086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1568DBDABEB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE0A3E82DF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499FB2DAFA5;
	Tue, 14 Oct 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d97LftG6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B90242D97
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461991; cv=none; b=ueGsgv9cOBmZ/mCUYDqq5yJGJsqT/ovsdo8jVcSIiNm+PR+a6hTu+7sIOetmG9Kzzot0b+y5ySAKoi8TIyYZcTAxwxHBNn4bV+e0iFdusDojUcSoXnNTdlAedkMwZCQsKFc4qLfJBSyK6P/qq/UHBChYR62KRFZ4STeK47kIqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461991; c=relaxed/simple;
	bh=rXiLK97jQSKb9NjqeQVrvOHmBfHI2ihJ6GLPZJD5tX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS1aS1JwxwqKjGFIkedg3qJ+OowcCFIZlr30ri9RSl01yqWUxk64i137vf+k4I0uyxtPBJWFbpFIUb4o+Mpih1B9UlmPPf4+z8G96Ckw9EVKFiJ6BT1G0bIjJZlAcHKloAMGoXU1iGrfDrdlyxdyW1tRYwffbhPy1urMcwNtte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d97LftG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B1C116D0
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760461991;
	bh=rXiLK97jQSKb9NjqeQVrvOHmBfHI2ihJ6GLPZJD5tX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d97LftG6gaK6XMAu0bMU+XQVR7pEM49s9DD8wk/5aI8ji2OaHSm5z/uOiOfQDNyPm
	 bzRqrn3RYEh/OBsakB4q0BwQS/DxeUW6Vl2htjZKCuTJxyz2aLSS5LQSacUTYE9Yzs
	 B3yEEKSwAVRlokQI66r4mZcMj8kCf+womlIcan5IjVxu4KFCazykDizAPANvp/1xgg
	 0fIRiH6vkSqjRyzptgxKhewvQEr0xK6tHhSojnfHBGQVpNdqWnwD7/Wumze1+tMXPl
	 OM+nQWGOOJerbp7ZQIEUzlYSWMTV+yCbaq4B5MENpiJ8w1VYANXU93i7vyqRpY5xnS
	 RQU8ml4ATwNgg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7b6d6a1e4e4so3725127a34.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIpds3Jxbvw9neL6mUks9rBL37TrwXXoieJMfcgAaoYmVTnoc/H4UsWBKJMTzmBwcb7g+jFRwAnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hYUUCJHfRikWaWAZmgpassf0Nfa9yZIah74gs8t+DVSjTCvh
	IeH/ORgDO/4wNL4aaBW87kqOHYx4JBtdjjBIcum9pSLbgOKY8X7hSBHSTEGi+gSaspor85GgxrN
	FXfL5RJVUMKr6z8tGcxk/yRzF13o20pk=
X-Google-Smtp-Source: AGHT+IEKn9pZqQfRBNDA9mZsQCQCdEZ4E+z2C0Lh35jSLm1ajT6sv/DGBVCdpgpOmum0F+Q4B8OR4TbZ18Y+9h4hoUc=
X-Received: by 2002:a05:6808:f15:b0:43f:21bb:32ae with SMTP id
 5614622812f47-4417b4841dcmr10249992b6e.50.1760461990250; Tue, 14 Oct 2025
 10:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014072203.979292-1-kaushlendra.kumar@intel.com> <20251014095544.flxkpnzuxun2t7ky@lcpd911>
In-Reply-To: <20251014095544.flxkpnzuxun2t7ky@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 19:12:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHcvXHdMfdakd5TUgcAiOGFW8hbvb2k-xb92dz81cGhA@mail.gmail.com>
X-Gm-Features: AS18NWAMbIHzxRjKZncC1j9EAqsTkvtiwlVo_415JQ-9hhdzXkJq9psP4k35kCA
Message-ID: <CAJZ5v0iHcvXHdMfdakd5TUgcAiOGFW8hbvb2k-xb92dz81cGhA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Introduce DEFINE_PM_GENERIC_FUNC macro to reduce
 code duplication
To: Dhruva Gole <d-gole@ti.com>
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org, pavel@kernel.org, 
	dakr@kernel.org, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:55=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 14, 2025 at 12:52:03 +0530, Kaushlendra Kumar wrote:
> > Add DEFINE_PM_GENERIC_FUNC macro to completely eliminate repetitive
> > code patterns in power management generic operations. This macro
> > generates the entire function definition including signature,
> > implementation, and symbol export for each pm_generic_* function.
> >
> > This reduces code duplication significantly while maintaining the
> > same functionality and improving code maintainability.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> > Changes in v2:
> > - Include function signature and symbol export in macro as suggested
> > ---
> >  drivers/base/power/generic_ops.c | 158 +++++--------------------------
> >  1 file changed, 26 insertions(+), 132 deletions(-)
> >
> > diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/gene=
ric_ops.c
> > index 6502720bb564..0afea5d8f8ef 100644
> > --- a/drivers/base/power/generic_ops.c
> > +++ b/drivers/base/power/generic_ops.c
> > @@ -8,6 +8,14 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/export.h>
> >
> > +#define DEFINE_PM_GENERIC_FUNC(func_name, op_name) \
> > +int pm_generic_##func_name(struct device *dev) \
> > +{ \
> > +     const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL; \
> > +     return pm && pm->op_name ? pm->op_name(dev) : 0; \
> > +} \
> > +EXPORT_SYMBOL_GPL(pm_generic_##func_name)
> > +
>
> NAK.
>
> Honestly, I am not okay with this level of optimization just to reduce
> lines of code. It was much more verbose and clear earlier and I don't
> really understand the full benefit of this patch.
>
> If we look at this from the eyes of a newcomer to the kernel, who does
> not follow the PM lists/ is coming from older kernels and tries to jump
> to the definitions of pm_generic_runtime_suspend or whatever - it's
> going to break for them. I use ctags to jump around kernel definitions
> extensively and after this patch I will have to jump through hoops to
> find what pm_generic_XYZ is doing and where it even is defined. grep
> will break too.
>
> Unless there's real proof that this greatly improves code readability or
> performance that I can't think of right now.
>
> Perhaps Greg/ Rafael can comment on whether this is truly justified
> from a maintainence perspective, but as a PM susbsys user it will make
> things just complicated for consumers of these ops to dig into IMO.

OK, so it was my comment that triggered this, maybe you'd prefer the
previous version:

https://lore.kernel.org/linux-pm/20250919124437.3075016-1-kaushlendra.kumar=
@intel.com/

