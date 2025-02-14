Return-Path: <linux-pm+bounces-22111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B6A36772
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C511F16B072
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870921940A1;
	Fri, 14 Feb 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRte8pC7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054F158870
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568187; cv=none; b=GXiFfF66rSCvkMMAw81qb5qMIbeF1X6Bzo/9wVLVMmxdH1pxqfKqUfdSym2bkM94hJolNuWFkReLQY9OL7a7djpVGKnxa5dSiuX882NrmBVhJvJSLja1lxGwoQgq3m/KKM2i5xtEizJnr2c+NM0Duny6G3ZfZyQsjf7JRbCiY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568187; c=relaxed/simple;
	bh=mwcXLk9eByPlSUw29kVLqbRPUyHHUeY2kw+0OdWYk+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUciNRwQqsUPQ148EaLBI3b8NDWVI6tvye6g+bnA++sicvRgdJjwoEYU1TMFIsU0alQ7tO8rfszjWbwURYoUaOyjiECCNJoU3waLepHYc67+eqGZ4a0KkSakk/JzouvHQfOiq1Fo6ubwucS/+IxQOqxUcJRYFxWOWrySKbIQvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRte8pC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED81C4CED1
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568186;
	bh=mwcXLk9eByPlSUw29kVLqbRPUyHHUeY2kw+0OdWYk+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kRte8pC7h4zNvThDCZLj2vxqv5b2VtUX9eZmV3GWgBDjKVWDzWROA1IZPPk6IKF1I
	 k4mnCGwQPzEaZa48G+km3NGsHcT0VgzUeMeCFfzwpN5GyNUMJheTCabgAe0sUt0DNZ
	 kPcD4OabiN92nWTxegkgnsnqEtJHqspXeMP8lVmI7brmvD3z5dXO9DUNP6zXmY/MSh
	 yZ3Q5YysrjPNf+dH9r+HXFgcv6zRb5Ueu9tlOKx4RBcP49WDX4PwHe0fr2Lu8M1ngv
	 1DBUbQhcZ8jufLcEirqwpLPXNyU81xthxqj3T/PsVot1mtPwDi63SkPGuRI7CEqsDu
	 xDJ9vm58hZVag==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fc9789a258so2204466eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 13:23:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWk1DjQeUFcZqiuD8Mawtj1cS91UINFmP/9DZCiXoam+bHvxHmCEtOw4knUwJXvIgQiBX/E2zccpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7J+hRdYnFBlN1cM9O1+LZMbxSF9vBIazZrBdxxHYiIwbLCf8
	KSNcuquT/IOqs1dzE+X/GOks/f3QNbj5H+8gztTDmWyZjvHQunQkCw4OGkzCvSnK1DiS++WKDyD
	sN0RW0NLuStiFlSOYT8SdGl20BoE=
X-Google-Smtp-Source: AGHT+IEk/udvXHQOg8eBh7P4f6eQq1d26U0N8PA1iOu7hLhDr3+fBFgL290Znf5Ap3L359F/OimsEmYh4/mGr5UnVp8=
X-Received: by 2002:a05:6870:3b86:b0:29d:f65b:85fa with SMTP id
 586e51a60fabf-2bc98d844a0mr524838fac.10.1739568186227; Fri, 14 Feb 2025
 13:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212084232.2349984-1-dedekind1@gmail.com> <CAJZ5v0hnm_Xx-NQfOiOFWNYJoeOr-LbgTcd1u0SxNM=EbyQQTA@mail.gmail.com>
 <f6922e38fd83433d60c0f7d9dc9a6effb967cc8a.camel@gmail.com>
In-Reply-To: <f6922e38fd83433d60c0f7d9dc9a6effb967cc8a.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Feb 2025 22:22:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4FOwwmsPcsMv9Jr1LCXRP6U-Y0vUOJYt5HCtDvQe__g@mail.gmail.com>
X-Gm-Features: AWEUYZlp26ocrXKIU8_fEq7XbZ1fnVIC_SItOXKCgV-cBty9ji5UsGUlQx87SVk
Message-ID: <CAJZ5v0h4FOwwmsPcsMv9Jr1LCXRP6U-Y0vUOJYt5HCtDvQe__g@mail.gmail.com>
Subject: Re: [PATCH 1/2] intel_idle: Add C1 demotion on/off sysfs knob
To: dedekind1@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Artem,

On Fri, Feb 14, 2025 at 1:51=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> Hi Rafael,
>
> thanks for reply!
>
> On Wed, 2025-02-12 at 21:11 +0100, Rafael J. Wysocki wrote:
> >
> > > +static ssize_t c1_demotion_store(struct device *dev,
> > > +                                struct device_attribute *attr,
> > > +                                const char *buf, size_t count)
> > > +{
> > > +       int err;
> > > +       bool enable;
> > > +
> > > +       err =3D kstrtobool(buf, &enable);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       mutex_lock(&c1_demotion_mutex);
> > > +       /* Enable/disable C1 demotion on all CPUs */
> > > +       on_each_cpu(c1_demotion_toggle, &enable, 1);
> > > +       mutex_unlock(&c1_demotion_mutex);
> >
> > This is not the only place where MSR_PKG_CST_CONFIG_CONTROL gets
> > updated.  The other one is drivers/platform/x86/intel/pmc/cnp.c
> >
> > There is no real conflict because the PMC core thing happens during
> > system suspend/resume on client platforms, but this is kind of
> > duplicated code.  Any chance to consolidate this?
>
> Thanks for pointing this out.
>
> I'd propose to leave it as is because it is such a small amount of
> duplication and also trivial. Since the two code paths do not interfere
> with each other, I am not sure consolidation is worth it in this case.
>
> I was also hoping that this patch would be backported by OS vendors,
> because it makes a very significant difference on recent Intel
> server platforms, so I wanted to keep it simple for easier backporting.
>
> But I did not dare to CC stable, because it may not be perceived as fix.
> However, in practice enabling C1 demotion fixes performance issues on
> recent Xeons in some workloads.
>
> If you really think the MSR read and write code should be consolidated,
> I would propose to do this as a separate patch-set on top, so this one
> stays simple and easier to backport.
>
> To recap:
>
> * I propose not to consolidate it.
> * If you insist, I propose to do it on top of this one.

I would at least add a common wrapper around the RMW thing that would
return the old value, to make it clear that it is not only used in
this one place.  That wrapper can be added in a separate patch, so it
is possible to backport it without changing functionality.

> Please, let me know.
>
> > > +static ssize_t c1_demotion_show(struct device *dev,
> > > +                               struct device_attribute *attr, char *=
buf)
> > > +{
> > > +       unsigned long long msr_val;
> > > +
> > > +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
> > > +       return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOT=
E));
> >
> > This reads the register on the current CPU with the assumption that
> > the specific bit value will be the same for all CPUs.  Is this always
> > true?
>
> Yes, anything else would be either a BIOS bug or a user toggling the MSR
> bits directly via /dev/msr. I was trying to keep the driver simple and
> avoid detecting different values, because the only think we could do in
> that case is just print a warning.
>
> >   What about systems with more than one package?  Do they always
> > initialize this bit to the same value in all packages?
>
> Yes, anything else would be a misconfiguration or bug.
>
> >   I guess so,
> > but then I would add a comment documenting this assumption and the
> > reasons for it.
>
> I'll add, thanks!
>
> > I'm not sure if the attr name is clear enough.  I guess reading the
> > doc is really necessary to get an idea of what this is about, but it
> > might indicate that the demotion is done in hardware, like
> > "hw_c1_demotion".
>
> Well, let's see. I propose two approaches for naming this attribute.
>
> 1. Follow the Intel name, documented in the Intel SDM: c1_demotion.
> 2. Try to come up with a better and more intuitive name. I would suggest =
one of
> these:
> * demotion_to_c1
> * auto_demotion_to_c1
>
> I followed approach #1. I agree that C1 demotion is not an intuitive name=
,
> because it sounds like C1 is being demoted. But I am used to it, and it i=
s also
> old and documented in the SDM.

This is not my point.

You are essentially extending Linux ABI here which isn't
Intel-specific and I'm just saying that "c1_demotion" needs some
context, or it is even hard to say where it comes from.  It is
described in intel_idle documentation, but in order to find that
description, one needs to know that this is an intel_idle feature
which isn't really obvious.  "intel_c1_demotion" would be better even
IMV.

