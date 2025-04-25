Return-Path: <linux-pm+bounces-26182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D64A9C4D5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63035188C8C9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931E23CEFF;
	Fri, 25 Apr 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCHlm4IM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D622397B0
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575884; cv=none; b=EKV7QfkH1ihsyWWWxUB5r4E9i3lqMDh6TnWUHBk/1vKnzXU5UBQepWALGS3y1hoi1q1oTy4paWXc9zi739fRaU5gXjKjzo+7zWxnvXZz2EB/rt1SDGtUaTufNhj+wMD6B7z8/ZuwPjnX72g8UTUlrwMEoEIGuiV0n4jwWhDEmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575884; c=relaxed/simple;
	bh=2XTlxLm6HhjD5NksRt/hceGdAq7tvii4hFXdGKcaMBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjlykyzRP863Ty4JfyQ2gYqh2ai23cS8OtwbZGMR4A+O2jKnKOPi6xwjTpuZ8o4roTOL6d8Bxa1RkU9wYIHKbhrK97nJEuLImoG65g74Z8io7alRq00ld/rmZz9yWPBlUxhBt0/Y7fUPGCQ+4znjM1UaF3nblxzTDc+ds/Da2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCHlm4IM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fead317874so18539357b3.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745575881; x=1746180681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6prVsylQnKDMIBjZXP4uOELttil8ar/HvFRq0ET36k=;
        b=aCHlm4IMPVCU77HKh0v3RVgGxG4PsL8OzUM50d5cTV7RZBnscQxBgJcXx+ZcO/Rzx2
         NhE211gq/gGrWZIi4uc3cjJWftgjuAwyTL9PilRgj/dCiz0awYSZXtzHuiWIb+DAtTn/
         3ZgCbF7Dfl0rHl8mMGpFC/eJ/CZuepH6hB/kSCz70V7/ahq8eaH93FIglY/pGJ6m+dvX
         l3ikh1X4up5ZqMRTi1AssyX1hcsb7mZDusH9JMH+QtVIZOKukPXHEqrSFKqyX/bbnhIL
         rpph2iAk7Pih9gHQz+0jWh2bX1lzzh/MK9hb9hx2Bj+6TTGsQCYvJlv9leUBbhmtWbmP
         oH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745575881; x=1746180681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6prVsylQnKDMIBjZXP4uOELttil8ar/HvFRq0ET36k=;
        b=ERMIOmd8b2pShsLe69m5bNJvnG5LB247b+OsF3LFl5aRaNBIse4Y+XTg55CXTFjVls
         eWdT9zcQCQwv7y9isees2UYmDn38OqXOJ0R1bH4nAdK+B79rR/3Np71CuAbp4C2QKT/W
         yeDxt6DNVtmW8qs1fQ1DHFs7g7aSWVovsJwwMDLdeSW0+Vk3bdcE2liruRXlG9PY6nRN
         J2h7bZ8/21QqBbZ+dHxxyMNyB5REkI0fPPB6w8yd5hnT6IJLPcXRCb55lf6t69uH311Z
         VZ6BgpM6asXwk/TGHk3wcMsouZAYRdfZ/ZCFCHIQo6HR8H0jnEBdFTz0xOEU+VyNCZ7r
         cMow==
X-Forwarded-Encrypted: i=1; AJvYcCW8BOuqfYpp4YK01RyZPpmtePlCv7zDGtEeEVIbqeifWnrFlj1WfE59AYduVILH3pZKtoIq7PZx+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoetYRhD4sjUtr46XBLOtQAJM/UGyh6UelIh761cNPcs92jxL
	qvQVDl2sDbxg+31uEODTsfU56ajB/Cph5/lvjZ497uuOxNNZ4kAUA21iYQzWQLPPrD/QlGJ15mZ
	RtEm2IoPg3m6U2gBlub8IILV4lnZljZ+z3ctF6g==
X-Gm-Gg: ASbGncsvTlYfri9LN15y01nHKFbgBx67Fqtrz4sNgb0fYl7siRoNHdNIhoigToZELJi
	tr7lSpN4I8xc9vK38EFhFxcleTnvLnKX8VKoUU4Y/61W07UAweXP+led6mS4IKmjhl1YMDUg/tH
	easSbdZDTYsY8EaHpXbQfEWtI=
X-Google-Smtp-Source: AGHT+IGurFHGYwar2TKD3VtJNgOfTgLYu73UwsY3fMeiKx/80V1BEROWuydsOdDJ1TKv9Y5NtKhSq17Sa7k73YOZM/k=
X-Received: by 2002:a05:690c:4b0a:b0:708:3a47:3d2c with SMTP id
 00721157ae682-70854107cf6mr20217487b3.13.1745575881129; Fri, 25 Apr 2025
 03:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028@eucas1p1.samsung.com>
 <20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
 <20250414-apr_14_for_sending-v2-1-70c5af2af96c@samsung.com>
 <CAJZ5v0irRq8_p35vf41_ZgomW0X=KZN+0HqwU2K9PvPRm8iZQA@mail.gmail.com>
 <b9c4182d-38c2-4173-a35a-0e1773c8f2ed@samsung.com> <CAJZ5v0gE0anjW_mDSwNXY8xoZ_0=bDDxiSbUq1GP7-NycDojrQ@mail.gmail.com>
 <cbf20469-02ab-403a-8db7-2b66e9936b4f@samsung.com> <CAPDyKFqND2JrH8nLUzAqwWgHkwia6M9XOJoY6AqxtR0t120JUA@mail.gmail.com>
 <20250425-lumpy-marmot-of-popularity-cdbbcd@houat>
In-Reply-To: <20250425-lumpy-marmot-of-popularity-cdbbcd@houat>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Apr 2025 12:10:45 +0200
X-Gm-Features: ATxdqUE_JbjUe45S3EVZ15Z84FoHvfu8q4ysbH-yq1WIOchBVAmKx33KA3qSxvM
Message-ID: <CAPDyKFp-Bguqukn0my9mVDdSyG2eQ3EPP+diD-BBg-P_E8S9=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: device: Introduce platform_resources_managed flag
To: Maxime Ripard <mripard@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, m.szyprowski@samsung.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Apr 2025 at 09:09, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Thu, Apr 24, 2025 at 06:51:00PM +0200, Ulf Hansson wrote:
> > On Thu, 17 Apr 2025 at 18:19, Michal Wilczynski
> > <m.wilczynski@samsung.com> wrote:
> > > On 4/16/25 16:48, Rafael J. Wysocki wrote:
> > > > On Wed, Apr 16, 2025 at 3:32=E2=80=AFPM Michal Wilczynski
> > > > <m.wilczynski@samsung.com> wrote:
> > > >>
> > > >> On 4/15/25 18:42, Rafael J. Wysocki wrote:
> > > >>> On Mon, Apr 14, 2025 at 8:53=E2=80=AFPM Michal Wilczynski
> > > >>> <m.wilczynski@samsung.com> wrote:
> > > >>>>
> > > >>>> Introduce a new dev_pm_info flag - platform_resources_managed, t=
o
> > > >>>> indicate whether platform PM resources such as clocks or resets =
are
> > > >>>> managed externally (e.g. by a generic power domain driver) inste=
ad of
> > > >>>> directly by the consumer device driver.
> > > >>>
> > > >>> I think that this is genpd-specific and so I don't think it belon=
gs in
> > > >>> struct dev_pm_info.
> > > >>>
> > > >>> There is dev->power.subsys_data->domain_data, why not use it for =
this?
> > > >>
> > > >> Hi Rafael,
> > > >>
> > > >> Thanks for the feedback.
> > > >>
> > > >> You're right =E2=80=94 this behavior is specific to genpd, so embe=
dding the flag
> > > >> directly in struct dev_pm_info may not be the best choice. Using
> > > >> dev->power.subsys_data->domain_data makes more sense and avoids bl=
oating
> > > >> the core PM structure.
> > > >>
> > > >>>
> > > >>> Also, it should be documented way more comprehensively IMV.
> > > >>>
> > > >>> Who is supposed to set it and when?  What does it mean when it is=
 set?
> > > >>
> > > >> To clarify the intended usage, I would propose adding the followin=
g
> > > >> explanation to the commit message:
> > > >>
> > > >> "This flag is intended to be set by a generic PM domain driver (e.=
g.,
> > > >> from within its attach_dev callback) to indicate that it will mana=
ge
> > > >> platform specific runtime power management resources =E2=80=94 suc=
h as clocks
> > > >> and resets =E2=80=94 on behalf of the consumer device. This implie=
s a delegation
> > > >> of runtime PM control to the PM domain, typically implemented thro=
ugh
> > > >> its start and stop callbacks.
> > > >>
> > > >> When this flag is set, the consumer driver (e.g., drm/imagination)=
 can
> > > >> check it and skip managing such resources in its runtime PM callba=
cks
> > > >> (runtime_suspend, runtime_resume), avoiding conflicts or redundant
> > > >> operations."
> > > >
> > > > This sounds good and I would also put it into a code comment somewh=
ere.
> > > >
> > > > I guess you'll need helpers for setting and testing this flag, so
> > > > their kerneldoc comments can be used for that.
> > > >
> > > >> This could also be included as a code comment near the flag defini=
tion
> > > >> if you think that=E2=80=99s appropriate.
> > > >>
> > > >> Also, as discussed earlier with Maxime and Matt [1], this is not a=
bout
> > > >> full "resource ownership," but more about delegating runtime contr=
ol of
> > > >> PM resources like clocks/resets to the genpd. That nuance may be w=
orth
> > > >> reflecting in the flag name as well, I would rename it to let's sa=
y
> > > >> 'runtime_pm_platform_res_delegated', or more concise
> > > >> 'runtime_pm_delegated'.
> > > >
> > > > Or just "rpm_delegated" I suppose.
> > > >
> > > > But if the genpd driver is going to set that flag, it will rather m=
ean
> > > > that this driver will now control the resources in question, so the
> > > > driver should not attempt to manipulate them directly.  Is my
> > > > understanding correct?
> > >
> > > Yes, your understanding is correct =E2=80=94 with one minor clarifica=
tion.
> > >
> > > When the genpd driver sets the flag, it indicates that it will take o=
ver
> > > control of the relevant PM resources in the context of runtime PM, i.=
e.,
> > > via its start() and stop() callbacks. As a result, the device driver
> > > should not manipulate those resources from within its RUNTIME_PM_OPS
> > > (e.g., runtime_suspend, runtime_resume) to avoid conflicts.
> > >
> > > However, outside of the runtime PM callbacks, the consumer device dri=
ver
> > > may still access or use those resources if needed e.g for devfreq.
> > >
> > > >
> > > > Assuming that it is correct, how is the device driver going to know
> > > > which resources in particular are now controlled by the genpd drive=
r?
> > >
> > > Good question =E2=80=94 to allow finer-grained control, we could repl=
ace the
> > > current single boolean flag with a u32 bitmask field. Each bit would
> > > correspond to a specific category of platform managed resources. For
> > > example:
> > >
> > > #define RPM_TAKEOVER_CLK        BIT(0)
> > > #define RPM_TAKEOVER_RESET      BIT(1)
> > >
> > > This would allow a PM domain driver to selectively declare which
> > > resources it is taking over and let the consumer driver query only th=
e
> > > relevant parts.
> >
> > Assuming we are targeting device specific resources for runtime PM;
> > why would we want the driver to be responsible for some resources and
> > the genpd provider for some others? I would assume we want to handle
> > all these RPM-resources from the genpd provider, if/when possible,
> > right?
> >
> > The tricky part though (maybe Stephen had some ideas in his talk [a]
> > at OSS), is to teach the genpd provider about what resources it should
> > handle. In principle the genpd provider will need some kind of device
> > specific knowledge, perhaps based on the device's compatible-string
> > and description in DT.
> >
> > My point is, using a bitmask doesn't scale as it would end up having
> > one bit for each clock (a device may have multiple clocks), regulator,
> > pinctrl, phy, etc. In principle, reflecting the description in DT.
>
> My understanding is that it's to address a situation where a "generic"
> driver interacts with some platform specific code. I think it's tied to
> the discussion with the imagination GPU driver handling his clocks, and
> the platform genpd clocks overlapping a bit.
>
> But then, my question is: does it matter? clocks are refcounted, and
> resets are as well iirc, so why do we need a transition at all? Can't we
> just let the platform genpd code take a reference on the clock, the GPU
> driver take one as well, and it's all good, right?

The problem is the power-sequencing that is needed to initialize the
GPU. Have a look at patch3's commit message - and I think it will be
clearer what is needed.

In my last reply for patch 3/4, I am suggesting this whole thing may
be better modeled as a real power-sequence, using the new subsystem in
drivers/power/sequencing/*

Kind regards
Uffe

