Return-Path: <linux-pm+bounces-35301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56232B9BD1B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C3D16D8D8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E032322C9F;
	Wed, 24 Sep 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo/qVJoc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4D322766
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744700; cv=none; b=Of+O5cO3Vf6ztP9dR2AeMKu8aYvkvWHSMToruOTcTt1ikn5+PZsU2sFW6I2Ron3Vy1kvInnm7M1jjdyYC+D9Fm3mrzhzimbARspXOw23AFubwv/ypFsUOHJwruDR/0eQe8beiLaFkWMHHCLNGEYh8BPvqhkYl1J/gPBHBDVS2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744700; c=relaxed/simple;
	bh=u4LZa19/Ve+5yPLkEZkyhQLSObpFyigeCyV4BriUmY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcx02whnQlvw9QawFUa03rZ51CTBiEqwLT3A17xO0ItYxjRGNwHKYixUCL5I39Pcpy0eBVpEBGfHgvvojogRS9lE87BrZhG4PZ3b/QEN0Ug9FcS0pncb911DoVNhPyR4EFbWU1RFjC+l6D2Sq6E9pGfZgMBwtoFUDFNPeBVGGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo/qVJoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EF9C113CF
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758744700;
	bh=u4LZa19/Ve+5yPLkEZkyhQLSObpFyigeCyV4BriUmY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uo/qVJocqtCEIJX8yfVvvHQrJMtcWFs4rfO9IU1Q/3ie+D9Q7wRG+poJl2LpCqwfW
	 h3EtrZhsyoEpu1DUPmXWnwIj3WP2rzrqgNyfXp6LcUQNoxBf0j/EMBfkr35Ax6k9Sv
	 GK4a499TDYbPCubA4U8LLLB9tbGsrcbjD0OaPC6aoL6Z6kO2M6z9fYfLv46Kyi0+vU
	 +Nh0dADyZpj35HkOqpYIyt9l+KcXB78aNiilrqycIpweq8orikRnW00KDWGiNy+Kpf
	 RAuUOEEgcQEL2nGeXOXPBk5XBcQWlKGJBUqHqpQOXjNCNmkFz7P+XwsGkrh0qgzRPE
	 0mmhv2fNwqPIw==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-79f79e37c04so180060a34.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 13:11:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzleqnhLGAYsCWdHsFFy6qyF/YJ0Gc3O/QHARPEK0rzaxWVfhGhga5IsS56unjsY1yhMLP6Eh/AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyo9jZ0iwC/c3th2X/WiH4BreokFj76FJ9QURzEhHUNEGA1u9g
	XeGJbEFEtZJhXt60Xr8Y8++U2DOj4d3hMUpBrx4MQeVXNMqWJuiFsY9hv9BBVMbequrJ2ZbhNup
	pabZgzQo7jLDWxyCDMflsscFInKIMR+0=
X-Google-Smtp-Source: AGHT+IHs3r5sWOfElWCg0bb17Zy9vhCe4i/yU+cgR6l8lEqR/wK2BYKZTzP+UxdCs+F1wz7yyCOBT39XKNw+TB8oNCs=
X-Received: by 2002:a05:6830:6a8d:b0:73f:f3a2:212b with SMTP id
 46e09a7af769-7a03d122d2emr693287a34.5.1758744699405; Wed, 24 Sep 2025
 13:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923205631.3056590-1-srinivas.pandruvada@linux.intel.com> <CAJZ5v0h4ozxCLE1utLLb=iehJq2m6wkAegP08AdhwucNpe0KvQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4ozxCLE1utLLb=iehJq2m6wkAegP08AdhwucNpe0KvQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 22:11:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZKfj=MSfFDjk3gnL0rUT08-ixev-y5p9KvwDCpGx3+g@mail.gmail.com>
X-Gm-Features: AS18NWBI33QzkMjV5qdKdxvdWLow-FRVr81j5KWc3DPRBO3hiRLy37UQNl0UTPE
Message-ID: <CAJZ5v0jZKfj=MSfFDjk3gnL0rUT08-ixev-y5p9KvwDCpGx3+g@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Power Slider: Validate
 slider_balance range
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: daniel.lezcano@linaro.org, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Tue, Sep 23, 2025 at 10:56=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > When the module parameter slider_balance is set to the performance
> > slider value of 0, the SoC slider profile switches to performance mode.
> > This can cause the Linux power-profiles-daemon to change the system
> > power mode to performance from balanced mode. This happens when there
> > is only one platform profile is registered as there will be no conflict
> > with other platform profiles.
> >
> > Same issue occurs when the slider_balance is set to the power-saver
> > slider value.
> >
> > Prevent module parameter slider_balance from overlapping with
> > performance and power-saver slider values by adding range validation.
> > Return an error when an invalid value is provided.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
> > ---
> > Rebased on top of bleeding-edge branch of linux-pm
> >
> >  .../intel/int340x_thermal/processor_thermal_soc_slider.c       | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_so=
c_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_sl=
ider.c
> > index 20d70cb01542..49ff3bae7271 100644
> > --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slide=
r.c
> > +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slide=
r.c
> > @@ -67,7 +67,8 @@ static int slider_def_balance_set(const char *arg, co=
nst struct kernel_param *kp
> >
> >         ret =3D kstrtou8(arg, 16, &slider_val);
> >         if (!ret) {
> > -               if (slider_val > SOC_SLIDER_VALUE_MAXIMUM)
> > +               if (slider_val <=3D slider_values[SOC_POWER_SLIDER_PERF=
ORMANCE] ||
> > +                   slider_val >=3D slider_values[SOC_POWER_SLIDER_POWE=
RSAVE])
> >                         return -EINVAL;
> >
> >                 slider_balanced_param =3D slider_val;
> > --
>
> Applied, thanks!
>
> I'm wondering though what happens if slider_balance is set to
> SOC_SLIDER_VALUE_BALANCE and there is no other platform profile
> driver. Will it cause the demon to switch over to the "balanced"
> profile?

Never mind, slider_balance is only used when the profile is "balanced".

