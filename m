Return-Path: <linux-pm+bounces-36724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA3C015B1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032131A63365
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C2315D46;
	Thu, 23 Oct 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leun2FQi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD49315783
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225936; cv=none; b=WpvZ+3l/53FrplGmO+AwWyNTz2djsJq230TbWHHp3UtpzBd/rNgaN8/uuWTtCVEbgnaJo2JpXP4xCNmZD4Qv/xWsr8GpE3JPJHPiayl89wqyqPLHskKKforoJQ4QSHCZO5khUjnubjp6Z4RV9vRTrqDmGgufV7rOnfweQWmXhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225936; c=relaxed/simple;
	bh=vTFnJ06KEKXrVEI0mBGwvSblp5jfCxMuSkM0lraKhos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhCfblTU0gt9wxZSjyoKq3qyEK+B3HEKobO1ZKslWp6VOZ3WX2tTHfwRWGgLVcA1FRCkT+yMt8tk2Vxs8lhIK5FisT1GYjdwVpxd3ctb8Z0wN/jENeMs+hI/ijGCluqMpaQDQlQeVN6Hf58Y3wFa9BqW2xpCfAtgdK6xPwJNIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leun2FQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F4BC19423
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761225936;
	bh=vTFnJ06KEKXrVEI0mBGwvSblp5jfCxMuSkM0lraKhos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=leun2FQi+LfxDvGkHXiW1jCuw5q8CfpK+TswofyaVu9edE4Y7owuyuSMk+5VFAbnr
	 vOPwVSOWFlidJKmFbqaXkcbTWOWxF/qbpVduuCPtmNXrkxbtnuoGcFEJv1Mlziapw/
	 RvpHruqdKHaAr6R3gHF+1dPcFU92TRxlIJ8R0uZMAkbuQfKmwAA4w4sy1+eVor7Sqp
	 9KGoQpk8zGycXhVXOtTLiaaUXzCjmFDe3UWvi/ndoBl42nuGSZBzbVih/qmj0Fd3gk
	 AXqx+DACkPg5CW3Mf2iVi60LmcXXr7XTuT6CAIUAOTqeEyH7nVnWWlWACyCF/RYwPT
	 x6Zpod6WJsLVA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591ebf841ddso1002647e87.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 06:25:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3FucmQWzh8Q2RSDRJEKtW7z+Q3d/WBQjQEN9JI1r8TJFXn7sSMBDP04sPz/KIhfmyPaJMi9akBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyapYdyxQmdJEYmNpKXVIuUdZd1nAUSAYBgYICWYFPvaiqazBD9
	JOJyWXwNwpFA/V1g7neUxfXUoYmufs+N4P1V1R++atLA3ZFdoKHHqSUmzMOGKbsJQUfXqJdqKLZ
	XF2liXMfckXaVlefks1eoFumniUXOoPQ=
X-Google-Smtp-Source: AGHT+IF/QxGh0Uh18+Vu5oFqndQ9eTFAFuChF/l1T7L2YcTuBk6NAJrEmSDaYAY6Oqq46nktI15zolAHjgRe4JbZsyg=
X-Received: by 2002:a05:6512:ba1:b0:57c:2474:3733 with SMTP id
 2adb3069b0e04-591d85982ebmr8129374e87.42.1761225934764; Thu, 23 Oct 2025
 06:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org>
 <ms55ue7qqbvoyfhptzu2a5cuthusihtobremhuqfm7lyu7b62o@qasunalgkptl>
 <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com> <44k7h2wzksrp4eghvdim5kiq5tsul3p7yhy44d3eii7hyvivch@xx3x762acknd>
In-Reply-To: <44k7h2wzksrp4eghvdim5kiq5tsul3p7yhy44d3eii7hyvivch@xx3x762acknd>
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 23 Oct 2025 09:24:56 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9=2217VUNyGq9Z9hiZJfcjSYzzXy8WMh-0jD0a=a2eYJA@mail.gmail.com>
X-Gm-Features: AS18NWAygUjF8kk0etHernlCfpEOLEdv1BAMj1gRH37qVZmZ0TnzMAcb8jNH7mU
Message-ID: <CAJ-ks9=2217VUNyGq9Z9hiZJfcjSYzzXy8WMh-0jD0a=a2eYJA@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: simplify callers of `to_c_str_array`
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:32=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 22-10-25, 07:22, Tamir Duberstein wrote:
> > I believe the `{clk,regulator}_names` vector bindings remain alive for
> > the whole scope, even if they are shadowed. See
> > https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D202=
4&gist=3D800b334c514c2024d7b5e47fc54c1f2d.
>
> I tried to print the name of the regulator and clk in the C code:
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d67d392e16d4..89b65fe07b99 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2565,6 +2565,8 @@ int dev_pm_opp_set_config(struct device *dev, struc=
t dev_pm_opp_config *config)
>                 goto err;
>         }
>
> +       pr_info("%s: %d: %s: %s\n", __func__, __LINE__, config->clk_names=
[0], config->regulator_names[0]);
>
> and I get this:
>
> [    2.358437] core: dev_pm_opp_set_config: 2568: =EF=BF=BD<=EF=BF=BD=EF=
=BF=BDy=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD<=EF=BF=BD=EF=BF=BDy=EF=BF=BD=EF=
=BF=BD=EF=BF=BDx=EF=BF=BD=EF=BF=BD: =EF=BF=BD<=EF=BF=BD=EF=BF=BDy=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD<=EF=BF=BD=EF=BF=BDy=EF=BF=BD=EF=BF=BD=EF=BF=BDx=
=EF=BF=BD=EF=BF=BD
>
>
>
> With following diff applied over your patch, it works again:
>
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 743080e14292..02cb754c4abd 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -444,13 +444,13 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) ->=
 Result<Self> {
>      /// The returned [`ConfigToken`] will remove the configuration when =
dropped.
>      pub fn set(self, dev: &Device) -> Result<ConfigToken> {
>          let clk_names =3D self.clk_names.as_deref().map(to_c_str_array).=
transpose()?;
> -        let clk_names =3D clk_names.map_or(ptr::null(), |c| c.as_ptr());
> +        let clk_names =3D clk_names.as_ref().map_or(ptr::null(), |c| c.a=
s_ptr());
>          let regulator_names =3D self
>              .regulator_names
>              .as_deref()
>              .map(to_c_str_array)
>              .transpose()?;
> -        let regulator_names =3D regulator_names.map_or(ptr::null(), |c| =
c.as_ptr());
> +        let regulator_names =3D regulator_names.as_ref().map_or(ptr::nul=
l(), |c| c.as_ptr());
>
>          let prop_name =3D self
>              .prop_name
>
>
> and I get:
>
> [    2.460149] core: dev_pm_opp_set_config: 2568: dummy_clk: dummy_reg

Good catch. This should really be a lot more defensive so the compiler
catches this kind of use-after-free. I'll send v2 shortly.

