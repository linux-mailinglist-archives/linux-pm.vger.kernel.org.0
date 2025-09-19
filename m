Return-Path: <linux-pm+bounces-35028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F0B897E9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AE13B9C98
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311B1F3BBB;
	Fri, 19 Sep 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp3gn7bA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CC1EFF8D
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285624; cv=none; b=JafyMvAGrmpoIw4zH1vg46SygVNR+ReYppeM5xT1hdA0L674PMtduWFnOosHh6L9UyTrar6Kh/TuXB939Srm4mmaSplDhgDu0hzTCSRRhFdR7hBdy1EgQLy4RR/nrNP0MDvh+88onOLCK3TIc405JYZ6+3w/4/nwQWF17b8CsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285624; c=relaxed/simple;
	bh=IkhiQvxSVJBNEXYwVrCccUG3TFRY4PESJjnaQR6FiqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPNLpx7yXLC3UT8MTabG7oMrC3a5PqgxLqZNtg3TAMIgMQUkEoivK8EShEPZZHzcP5wd3RpAo+TnNG/IfWJQM/lhwhGpqPXALH3EsMlk8SpjexcriI09Y4MD9egPRJbqv9WEPdJpGsLLxdOIJzIV+ofjH03ZtvpuPwy482wbbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp3gn7bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF16C4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758285624;
	bh=IkhiQvxSVJBNEXYwVrCccUG3TFRY4PESJjnaQR6FiqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vp3gn7bAQCSFP2rTtO+Egh2VmMfniuDrPcFxR0zdw5I2kIMjAUXHmvMEjS3VaHT3R
	 RqFy8DlqsE2OMKIIalednDbl4IU/jAOc8gWHKHsEU9GScuRDdaO1du4nzcqr77WN67
	 W01FPkbfe/NFk6GlFAtCtB9Df0KkbVjZchfkS6+615JJyHxJb2GfWwF+kPMyF27/6w
	 NyYUnln7r63Z05ado5w/AO5TxA0pKJW+xB2XoIaJqJWdggw8cD5Uip0H+xyGWaU+it
	 IUX4sfX9+WamWCuaaxX7uB0bODccJtEa3oaOiKiF2wgCWf6hJLPCL9FnR1uvcwFDlo
	 Sz2NIgE+Ci+3Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-328466c2aedso1852884fac.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 05:40:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZxQYRGVksv4D3dYcqny4U+5Nb0ejxhSuVZYihrHIgYTuonBvWhJ4inD2TOX2zZjrIipnwlL97iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5ML8/PcQSCla6Pw/uSOdhAkCb/eRy1Dh8dDvVbBPIJ5bffaH
	cvI93QT49GerGCw/VRsnoxnDwouR37DQiMq4u7wfJ8hRiPTUuKLzagQEnMxZHVdQD5SXUql9CRe
	LFJfADrFaSwlLNZdBfwuua7+y++4eZtY=
X-Google-Smtp-Source: AGHT+IGN6yKheRKFWPzTBebZECqkVSf5jQ9sRYeDfhkyJi3xILFaY9CJLuH+Txi2bawvjGDTvzV+EzhA/dpIsY+2+nk=
X-Received: by 2002:a05:6808:bc8:b0:438:257d:6663 with SMTP id
 5614622812f47-43d6c2bd39amr1474905b6e.48.1758285623777; Fri, 19 Sep 2025
 05:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12749587.O9o76ZdvQC@rafael.j.wysocki> <20250919113922.7tozmbts6cs3y5va@lcpd911>
In-Reply-To: <20250919113922.7tozmbts6cs3y5va@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 14:40:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0himPgJrg7s0G7HbgFTtawEMRCJBXiuvaZnT1z9MB_mqw@mail.gmail.com>
X-Gm-Features: AS18NWD3a-WCHk-dCiI2bNf5gF2oTgLdUlcM3Mm6h19fD9EBjsdnibTPASziZu8
Message-ID: <CAJZ5v0himPgJrg7s0G7HbgFTtawEMRCJBXiuvaZnT1z9MB_mqw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Fail cpuidle device registration if there is
 one already
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:39=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Rafael,
>
> On Sep 19, 2025 at 13:22:20 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Refuse to register a cpuidle device if the given CPU has a cpuidle
> > device already and print a message regarding it.
> >
> > Without this, an attempt to register a new cpuidle device without
> > unregistering the existing one leads to the removal of the existing
> > cpuidle device without removing its sysfs interface.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Add the new check before the driver module reference counting (Dhr=
uva).
>
> Thanks for addressing!
>
> >
> > ---
> >  drivers/cpuidle/cpuidle.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -635,8 +635,14 @@ static void __cpuidle_device_init(struct
> >  static int __cpuidle_register_device(struct cpuidle_device *dev)
> >  {
> >       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > +     unsigned int cpu =3D dev->cpu;
> >       int i, ret;
> >
> > +     if (per_cpu(cpuidle_devices, cpu)) {
> > +             pr_info("CPU%d: cpuidle device already registered\n", cpu=
);
>
> Sorry for not pointing this earlier,
> perhaps pr_err makes more sense?

No, this need not mean a functional issue.

