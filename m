Return-Path: <linux-pm+bounces-35024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15921B8936F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED42176895
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717730C617;
	Fri, 19 Sep 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpnUCH5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C330C100
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280462; cv=none; b=eAkPUZV4ksi28S9vr7tdX5ubTO5Tm4lJJ7U7/o6b70eVxXjFNDj8xLxs+MEALorwTOJ2lXWrD7OUZNG/jQnAOxXlhYkxVp6rj40DgJeRUjHOhUxraFOr7OhqnoXlykSLAIQrZAG4ii2ROAIBl31p012a1ByJTDIinxti+GXXeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280462; c=relaxed/simple;
	bh=3oHB5M17fAPCaUOWIy7staPxRqP0sgNkjBo8MB8iCs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5ePVxcORXp/L4mFC8tTn3SOi4aqFfAHaBMLNJif+W9RExGFvMm8tmGBs10Brd1l/NYHwBObyoYhJ277RdPuhDR0qAbHJyjT+FT3ZrOufOfe6Lfz1m46neWvhYqk6RX+RmkdmBE5znQ/3jzCHvz9DSSqH51sjvvgv3hheMuLeTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpnUCH5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801F6C4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280462;
	bh=3oHB5M17fAPCaUOWIy7staPxRqP0sgNkjBo8MB8iCs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WpnUCH5/wpB4XM7KLfs/VUxv7oKPLNgE2dxYCejXjYtIEUx68aIdvITg1tw3tCUs7
	 h4GgP85w62aUvSikFmho9cRWhoVCSmUFbmq3QMHiQ8bjnPB9cwmvbXGsYqFhxB7Wd2
	 eMMQbQsefKlqpdEP8TxRr3/ALnA0qxTKf53kLWc6LuE3RMu7WBe6Kid3W7No2OxXg4
	 QVjMj2u9mRcGbMuCAhuwGTwfvfsJ2bTnQErGleHF0x5qz2n4ugj/pylZFAr1MQVKyg
	 15mHJdH6FvgdBgYcX2hmYvI77+CZdlDDRPx+UVc+YtePC/UY4qNJaMxiPDctucI+dc
	 e2zvacGDZPEow==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-752f88e0b59so1447637a34.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 04:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzxhYifEIae/OXr2wIXqP1WarMY9n9EeJ/rdrQZhiAlEMXhVlohZhlMHfuCHcexxgZOYTrXZ/NPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KP7wwKy1kJJI2IykSejNpm60UJgRcuPa5xrm1MMVD1u4mKez
	tWqLgChyf6W9EsNd1o8Abmj05gWaMq4NgnuaCXstikUKZNaRxQqYdHYGi8Iquj9AVsG2pmPyodd
	JR/Kudb/GfFa4/3DYi7aqkrdgXcdQjVo=
X-Google-Smtp-Source: AGHT+IGLpj/lQRwBPOEbZHrxrK3WqjA8s9QwnWqC1dbMSAnpOxnRlgLPlZlXUMZqO7PDq4hzKwhSrE/rAfQ02rJ74jM=
X-Received: by 2002:a05:6830:631b:b0:756:d6ab:e7a9 with SMTP id
 46e09a7af769-76902d5b77fmr3868391a34.13.1758280461874; Fri, 19 Sep 2025
 04:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3374815.aeNJFYEL58@rafael.j.wysocki> <20250919050928.6sprmdpz2pwgydcc@lcpd911>
In-Reply-To: <20250919050928.6sprmdpz2pwgydcc@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 13:14:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCaLebTwtm36dxxG0NBOc1DVPj9cjYHKOWm5kApNa1TQ@mail.gmail.com>
X-Gm-Features: AS18NWBzT6h889TaE7l6WW4Iz6YZGG6Dk_VjK05Co-aXWxzmQI-FiRCRfLLeNjU
Message-ID: <CAJZ5v0hCaLebTwtm36dxxG0NBOc1DVPj9cjYHKOWm5kApNa1TQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: Fail cpuidle device registration if there is
 one already
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 19, 2025 at 7:09=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Rafael,
>
> On Sep 18, 2025 at 23:19:20 +0200, Rafael J. Wysocki wrote:
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
> >  drivers/cpuidle/cpuidle.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -635,11 +635,17 @@ static void __cpuidle_device_init(struct
> >  static int __cpuidle_register_device(struct cpuidle_device *dev)
> >  {
> >       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > +     unsigned int cpu =3D dev->cpu;
> >       int i, ret;
> >
> >       if (!try_module_get(drv->owner))
> >               return -EINVAL;
> >
> > +     if (per_cpu(cpuidle_devices, cpu)) {
> > +             pr_info("CPU%d: cpuidle device already registered\n", cpu=
);
> > +             return -EEXIST;
>
> Here we return prematurely after a try_module_get right?
> Do we need a module_put() similar to how you do it later by calling
> unregister_device function by checking ret =3D cpuidle_coupled_register_d=
evice ?

Good catch, thanks!

I need to move the new check above the driver module reference counting.

