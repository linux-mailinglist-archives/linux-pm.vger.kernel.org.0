Return-Path: <linux-pm+bounces-37961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90228C57FB8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11333AD0E3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C132C21DB;
	Thu, 13 Nov 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTsXoWdL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42629C327
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044164; cv=none; b=hwkN9niwBGKZ+nBDJ0SWPVPvaJqJp73T7tolvW9f0Fz5MGROX6eiIB23rWsrphVeHCBm5M7QWyaiyxZwSbCJwDnaZVLE3CnigBOvTplWHUd17ZrFqjU91xD2mBpkgXrRsyJSW3ljYf4sEPuwA93+lHt17LbXNCitcKwBfTAqa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044164; c=relaxed/simple;
	bh=enukvQUkWp5qWLLQJutYEr5eHCre8gtyCfegyL8aecU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrLk1A04Y5M4SvfHzBtgYjR/XzLasaP+r3KDMcQ3KFS6YG6s52ScwpQ+IqchqGeV2shXaiAiB63svH33IXM8+lhSjcxCsNbAInxBKRI/cXzNKkkhSyV+z7mF2CipJe6yvXqEe1RtRsPstzCh3qO8FO8GR371t2epJWxOa4OQZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTsXoWdL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b47f662a0so977927f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763044160; x=1763648960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNomNoVs3/3wdBsUcq9EZSvX1zLpw+oNIAvlqkMmZEs=;
        b=MTsXoWdL5q+SKlKFYuluPzOD01u5Un9K0DErqJEcgs6WiRpSbbI5NNZX3gSvFhXKR6
         QY5Kza6huPV0tgxIbLxCwu1+wExP9MxfVJmtk/5yd1zvprODuYXu1RHE5/b5gCI2lyXe
         E7vm1+iNcnvO5ULiHvudpmhjgiMXsf0tLRZTL8hu7aTAPyZBOrzazrR8oynNh9FAF9Mh
         M1qixhxtDwJa+ZIF/HMxw6f8uWUrsiAvWwAMrLz29PO8EChBw4JXcZRqbwXZsERb1tSH
         0MORytgRr3WbRHs8FX42JeDkoiwqk/im9aMBRG7CmwRK62YZDsl1rlJJXJ24Gt8pjuak
         vz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044160; x=1763648960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNomNoVs3/3wdBsUcq9EZSvX1zLpw+oNIAvlqkMmZEs=;
        b=Zw74Y8a7xSl0m8nOlJTDyFCNZKjIH5wP08rLb8FpDAIwTTh0NNL55YrRJoOlFlfCH2
         taX6gBxBdbjeA4XtiI/9beKSWZUhrTCMu4UX1BIkG4dt9zafsqdmaJhHklO/GUvwnNZj
         JgZw7lBBXAlx1BlByh18QHly6xzadwg6Haihf1aCpbrKKJ5BhUKPjkv8HG291b2kmgrK
         2u7WmobDkdMOMTU6VBhcrhUvORBbmBf/1FKto0gz+3jYMKzIA6tFca5et+3vMvjhAl8a
         ot4pz0bY+oR2aR6xHeS/jQOhoci59yg1p/U91nhD5YK55zLGz+68niZwgwC5liA58zl5
         R5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvgjesyYr0M6T6ZVt0+IdvZmmil61k8wlX+sV/XgbJwSd1tdYJANPG/ZyeV1BdwhjUIyxmIo9hKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSFDEbVtiPefhi84C30+kBr7+U997zIFlqXOjQJTti7oFgjxsy
	R/uHg8Y1dhaKHVnBkqMtlowfxEGP/786G5TGDfB4PLd/YwgryCr/jJYpNFPP0rL/QB/5+4Nzoab
	9aDMMbm2Lc+iHF0NlTpk8DlxY34sPU+8=
X-Gm-Gg: ASbGncs0Atzv4bDLdq9wLL8w+g8rxYrxnmfAHCyerHr4rhyNau2YE3CiRVpJ/g320+W
	QOn9iuIkIkYZUH8kb2VFARMT/NZMDyanSSmk7NJYqhljT3hBtN0X6V3VPzs7acz2LfjEWDDJ4zR
	9v7j+m+soPe90guY7kN+6nnOymPY9IXpZH2/EzaxMJGkgscle86m6ivuX51dFWBJiG+XcdoO78w
	mLJyN8taxKWWY52ld1KUI7CUNds9LafLw6ooJTxugpyyyI+vjB60sKKGCNx2UIfhGagBAtdwjnU
	CHO2Y6g=
X-Google-Smtp-Source: AGHT+IEjZesfWe6UAJr9rfneLrz6LT9ITsEcvC5EG+9+SI64dIq/3Wyqp3hO3mKXfLSgOhg9/PSLnT/sN+ozMuJc6zU=
X-Received: by 2002:a05:6000:230b:b0:429:d253:8619 with SMTP id
 ffacd0b85a97d-42b52795624mr3292848f8f.5.1763044159375; Thu, 13 Nov 2025
 06:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915080157.28195-1-clamor95@gmail.com> <20250915080157.28195-7-clamor95@gmail.com>
 <6112196.aeNJFYEL58@senjougahara>
In-Reply-To: <6112196.aeNJFYEL58@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Nov 2025 16:29:08 +0200
X-Gm-Features: AWmQ_bn3skm8vRUEdsGZ0nnCIIDUv9P1uoNNzH9ij76xxg0XWrgAcalJ4Vq9gRI
Message-ID: <CAPVz0n12YKGfjvYZZOkMaB18gk74xiprB7=XbcSpPvi9=Jtt4A@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] clk: tegra: remove EMC to MC clock mux in Tegra114
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 13 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 07:0=
5 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Configure EMC without mux for correct EMC driver support.
>
> Rather than just 'removing EMC to MC clock mux in Tegra114', I would say =
this patch removes current emc and emc_mux clocks and replaces them with th=
e proper EMC clock implementation. I would edit the commit subject and comm=
it message along those lines.
>

Noted

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/clk/tegra/clk-tegra114.c | 48 ++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-t=
egra114.c
> > index 8bde72aa5e68..6b3a140772c2 100644
> > --- a/drivers/clk/tegra/clk-tegra114.c
> > +++ b/drivers/clk/tegra/clk-tegra114.c
> > @@ -622,10 +622,6 @@ static const char *mux_plld_out0_plld2_out0[] =3D =
{
> >  };
> >  #define mux_plld_out0_plld2_out0_idx NULL
> >
> > -static const char *mux_pllmcp_clkm[] =3D {
> > -     "pll_m_out0", "pll_c_out0", "pll_p_out0", "clk_m", "pll_m_ud",
> > -};
> > -
> >  static const struct clk_div_table pll_re_div_table[] =3D {
> >       { .val =3D 0, .div =3D 1 },
> >       { .val =3D 1, .div =3D 2 },
> > @@ -672,7 +668,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max=
] __initdata =3D {
> >       [tegra_clk_csi] =3D { .dt_id =3D TEGRA114_CLK_CSI, .present =3D t=
rue },
> >       [tegra_clk_i2c2] =3D { .dt_id =3D TEGRA114_CLK_I2C2, .present =3D=
 true },
> >       [tegra_clk_uartc] =3D { .dt_id =3D TEGRA114_CLK_UARTC, .present =
=3D true },
> > -     [tegra_clk_emc] =3D { .dt_id =3D TEGRA114_CLK_EMC, .present =3D t=
rue },
> >       [tegra_clk_usb2] =3D { .dt_id =3D TEGRA114_CLK_USB2, .present =3D=
 true },
> >       [tegra_clk_usb3] =3D { .dt_id =3D TEGRA114_CLK_USB3, .present =3D=
 true },
> >       [tegra_clk_vde_8] =3D { .dt_id =3D TEGRA114_CLK_VDE, .present =3D=
 true },
> > @@ -1048,14 +1043,7 @@ static __init void tegra114_periph_clk_init(void=
 __iomem *clk_base,
> >                                            0, 82, periph_clk_enb_refcnt=
);
> >       clks[TEGRA114_CLK_DSIB] =3D clk;
> >
> > -     /* emc mux */
> > -     clk =3D clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> > -                            ARRAY_SIZE(mux_pllmcp_clkm),
> > -                            CLK_SET_RATE_NO_REPARENT,
> > -                            clk_base + CLK_SOURCE_EMC,
> > -                            29, 3, 0, &emc_lock);
> > -
> > -     clk =3D tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOU=
RCE_EMC,
> > +     clk =3D tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_=
EMC,
> >                                   &emc_lock);
> >       clks[TEGRA114_CLK_MC] =3D clk;
> >
> > @@ -1321,6 +1309,28 @@ static int tegra114_reset_deassert(unsigned long=
 id)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_TEGRA124_CLK_EMC
> > +static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args=
 *clkspec,
> > +                                             void *data)
> > +{
> > +     struct clk_hw *hw;
> > +     struct clk *clk;
> > +
> > +     clk =3D of_clk_src_onecell_get(clkspec, data);
> > +     if (IS_ERR(clk))
> > +             return clk;
> > +
> > +     hw =3D __clk_get_hw(clk);
> > +
> > +     if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> > +             if (!tegra124_clk_emc_driver_available(hw))
> > +                     return ERR_PTR(-EPROBE_DEFER);
> > +     }
> > +
> > +     return clk;
> > +}
> > +#endif
> > +
> >  static void __init tegra114_clock_init(struct device_node *np)
> >  {
> >       struct device_node *node;
> > @@ -1362,16 +1372,24 @@ static void __init tegra114_clock_init(struct d=
evice_node *np)
> >       tegra_audio_clk_init(clk_base, pmc_base, tegra114_clks,
> >                            tegra114_audio_plls,
> >                            ARRAY_SIZE(tegra114_audio_plls), 24000000);
> > +
> > +     tegra_clk_apply_init_table =3D tegra114_clock_apply_init_table;
> > +
>
> Is there any particular reason for moving this here? If not, omitting the=
 change would simplify the patch a bit.
>

IIRC, I tried to align with Tegra124 EMC clk driver, I will try to
drop this change and check if all works as expected.

> >       tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
> >                                       &pll_x_params);
> >
> >       tegra_init_special_resets(1, tegra114_reset_assert,
> >                                 tegra114_reset_deassert);
> >
> > +#ifdef CONFIG_TEGRA124_CLK_EMC
> > +     tegra_add_of_provider(np, tegra114_clk_src_onecell_get);
> > +     clks[TEGRA114_CLK_EMC] =3D tegra124_clk_register_emc(clk_base, np=
,
> > +                                                        &emc_lock);
> > +#else
> >       tegra_add_of_provider(np, of_clk_src_onecell_get);
> > -     tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> > +#endif
>
> tegra124_clk_register_emc and tegra124_clk_emc_driver_available have stub=
 implementations when CONFIG_TEGRA124_CLK_EMC is not enabled, so it would b=
e cleaner to just call them always.
>

Yes, I will adjust this in v4. Thank you.

> >
> > -     tegra_clk_apply_init_table =3D tegra114_clock_apply_init_table;
> > +     tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> >
> >       tegra_cpu_car_ops =3D &tegra114_cpu_car_ops;
> >  }
> >
>
>
>
>

