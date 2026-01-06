Return-Path: <linux-pm+bounces-40308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9CCF8394
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCC71300BEEE
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09E326D70;
	Tue,  6 Jan 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTcZr5jL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C86322B79
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701248; cv=none; b=jFYY/faxzHuZYchTsWykLFMUSg8bJYG5eIolX5q22e3MAmnFuEo4p5HSbwxZz3HPEgyBe0itjM8AdsLFnhq5fdd1Ti6dyMDSj/xC06EFx2IbdZYRyaV0fT3up0dEmQYVeYdqeRPpK3kjroaPxhdmxOzSHwJiKWkXPAMGwJGv70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701248; c=relaxed/simple;
	bh=/mjh/Q/tS+61kVfSsdJlx94WJRS29YqK7ZVoYoUlvUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoER/HdLsu53KjP53i8+oVqG+N5quUH0GIhuCshfXGGBZXEiTBXt+OgVimIrJJr2WBSrAtVsCG5z4In9wA2EL3WIPAhbVhikOetWLYZ2FrRHS9JpQgmU0giV9Oecdsj4B2tQ/0hZm9oADzQGD8zwPtipXoTDFp8Fk2Uj0yyJlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTcZr5jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97537C2BC86
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767701248;
	bh=/mjh/Q/tS+61kVfSsdJlx94WJRS29YqK7ZVoYoUlvUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sTcZr5jLmGsMbgutqwZSdRax5nqfG8474PHWm3/O8Vq8aq6ppj3bprFs/yRcQPiuV
	 EXh/fTilgHjc4mRMSLEkxZm8dnYso4S3mujc1S/3DCkqgin8RaHrun0RlCeTyZZ9ZO
	 bSe3+JZa+50uttDkgFIZAO2V2OiZHGhhPQXoip7cHBFZade/yG9r9aNLOLJvUZ1TW1
	 xZ66pjtm1Y6Ml+pRrwz9zFjDjc5DKv1MC0dYXMYt1wsdn1i4vTiv15hhyQo3qJ+PhN
	 o6GZzSVe3xetFc8JSVM6Y+JMCbb2upCyt/sa7Ptz5ntDjRm6hPa6JpZxCTphIcI30R
	 BcsHdYJi9A5RA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f9e592af58so516543fac.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 04:07:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg1RFoR1waVNid6rkTzEQU+3k+JjveNDBsGELHc9Uy8usHqktqnD313mNhYfR1IZE8bTMlSGeoBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OaWgRLrozd6IH+PpYmB59po4uTy+j97Wisa6SMnqBDZig1oP
	aT0bMJAWAx3xKVSOiGJSm5aS0pbRAstEc5y1TaveJrgxaQK5DVRVSkOEteQ9Ng2Q+d9own1xd8O
	AnOHhvE05cqzz4GTbkVfjPj88w37eLlI=
X-Google-Smtp-Source: AGHT+IHU78EL+YYo1xtqlNPAW/eedsiitl/vGn03rLf1ZPbM90twcsTJD+wDRrcpygcvKdWRWTHtTonI94comtqslcM=
X-Received: by 2002:a05:6820:5306:b0:65b:31cf:ca92 with SMTP id
 006d021491bc7-65f47acf9b9mr1221486eaf.84.1767701247505; Tue, 06 Jan 2026
 04:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5088794.31r3eYUQgx@rafael.j.wysocki> <2d55ebec-1e42-4ddb-b0e2-529d3b2d7b85@nvidia.com>
In-Reply-To: <2d55ebec-1e42-4ddb-b0e2-529d3b2d7b85@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Jan 2026 13:07:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i7Rbk5sWCo2Z1Y4j_ZFW7nCUr18H8i2JCM=aPpfZOQ4w@mail.gmail.com>
X-Gm-Features: AQt7F2q4RS2sF-HYZqBJgxgSFV1f7UNgugvNRibacX_GZnHtOjHkhHkP0YpJYrc
Message-ID: <CAJZ5v0i7Rbk5sWCo2Z1Y4j_ZFW7nCUr18H8i2JCM=aPpfZOQ4w@mail.gmail.com>
Subject: Re: [PATCH v1] clk: tegra: Adjust callbacks in tegra_clock_pm
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-tegra@vger.kernel.org, 
	Linux PM <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-clk@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Tue, Jan 6, 2026 at 11:36=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Rafael,
>
> On 04/01/2026 11:53, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > System suspend and resume callbacks run after the core has bumped
> > up the runtime PM usage counters of all devices, so these callbacks
> > need not worry about runtime PM reference counting.
> >
> > Accordingly, to eliminate useless overhead related to runtime PM
> > usage counter manipulation, set the suspend callback pointer in
> > tegra_clock_pm to pm_runtime_resume() and do not set the resume
> > callback in it at all.
> >
> > This will also facilitate a planned change of the pm_runtime_put()
> > return type to void in the future.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This patch is requisite for converting pm_runtime_put() into a void
> > function.
> >
> > If you decide to pick it up, please let me know.
> >
> > Otherwise, an ACK or equivalent will be appreciated, but also the lack
> > of specific criticism will be eventually regarded as consent.
> >
> > ---
> >   drivers/clk/tegra/clk-device.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/drivers/clk/tegra/clk-device.c
> > +++ b/drivers/clk/tegra/clk-device.c
> > @@ -175,7 +175,7 @@ unreg_clk:
> >    * perspective since voltage is kept at a nominal level during suspen=
d anyways.
> >    */
> >   static const struct dev_pm_ops tegra_clock_pm =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put=
)
> > +     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume, NULL)
> >   };
> >
> >   static const struct of_device_id tegra_clock_match[] =3D {
>
>
> I gave this a quick test and this is causing a suspend regression on
> Tegra20 and Tegra30 that use this driver. Looking at the console log
> on Tegra20 I see the following errors ...
>
>   tegra-clock tegra_clk_sclk: PM: dpm_run_callback(): pm_runtime_resume r=
eturns 1

Of course, it needs a wrapper.

>   tegra-clock tegra_clk_sclk: PM: failed to suspend: error 1
>   PM: Some devices failed to suspend, or early wake event detected

Thanks for reporting!

