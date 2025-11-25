Return-Path: <linux-pm+bounces-38548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B844C84732
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 856503507FE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A52F49EC;
	Tue, 25 Nov 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLc0uZz2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED62F290B
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066106; cv=none; b=HWJYB9SXN2lr2bnTR3yFrlry1vtEg+KZ0EzRa0YmgRB0TzHaV9X35dOrUSVLHs9Zh4JF8xPVK48NEIJe+Bfn08dO+6EShx4C7i/THs+1lFOHvW0vH2SZmYtO5pyAJOhU48uX26lP0J5zMvRx5GcYB9269jensZ3Qz2So6YeXQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066106; c=relaxed/simple;
	bh=Nl+s8+3VqFL8i/pvXYObJT1n7cruxQ9Kkr2MdBYPQNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNOmswnOQEmf5CGb0itSq8/9lNCm6EtsnSuu5c2J5miU6gz38oZ5qj6+vgb2sPtYGwCYYmKZrFtTXaVz2mBUT6glB4O6dqghJyBdxSlS0s6bJGJoNeR4lJjjogRgqadGsu46NK8KZxSk2k9zc5Z6ediMtcXpVj3NWimRRNOXHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLc0uZz2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3c965df5so2829453f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764066103; x=1764670903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMAa1PahDcZGGFamJpPR85zyctP0GPcnw67hHv9HjNU=;
        b=GLc0uZz2DvejL+9fdSJGkA1QRga3m+XsED20aH3XZIMmTBSjeCSuqVasEzNk8Pvscp
         8eZb1rkWsHK0989pDvhjHUUMpLf/9MwW3Y8kMNiHpOGzRdV3JBHjUIRL9XfTTu1VX0ON
         tqQIF80HRtyYJQPqDfavxv0m5xq9eNe+Vda3FSaKIGVoN/KsGWRGMz+hQ5RcidTAZ1U1
         rg7RAoE6XyPOOlLJuvzsDW3DrWpAGF8mJUGz0q26WOKnGJMPYG7jff1BQue2Tf2NFHYs
         YdMlYalvYn9ENaJ45K1NUM+3pvBIGM+iOjFbXcvj3kaeDaFdhbpOycf825LtemlGZ5gn
         hHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066103; x=1764670903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMAa1PahDcZGGFamJpPR85zyctP0GPcnw67hHv9HjNU=;
        b=SuCifXotcFIcF/vEn9G+lL2a22ZwImfzRSsCykElMWYw7N7OyZlzO8rgqDd5wQ2/bz
         e6mMhGLCN1FTpbmfAaZrsSZ6Tgpdgg62WvvtVaC2HXcWA3K+F/BehO5S3Ra2YmBiXfYV
         oAFTkCzzSYmoHrsxUyzZ+idixW4+9y5jpsYYLuVFUPeB3TavMrBoDU0ZxSH7532eZ2Zc
         x8I5o0B+BfIeywa8hjbbRNvdLkw1HiOJ3H59kH2yojPYOnrC1TjE6dqvz1vohKzX5IXS
         A0FyF3GQimhPf4D05FPo0RziD6MarR2RNhPXgulIqWqV1XyRdMzyhr+OqMmunSzmVwhp
         iITQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX34CPlcq8XXlvgX823IxfevMBk1VZn3iVLJgwVAbUyKM4ZgLUT/tR7g5IVe1BtxYgsw9wZuG+dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5GO/dPME95UvuxRqzxW2hhIyinc6JVM6sP9hYPiCjt6B4QKW
	vqZMTT0DzwHRGGCJK3kC/eJQhUKQnEomMAexFSUC+auSHt+Yxp3RKSASf+O3q8gHJ+nOVQ40DQk
	nwZ8dXgcpR0eo1dkwqLQOHKHCqAmqPxfaupey
X-Gm-Gg: ASbGncs4GUPBHpCThxcDsrsNdhChoXy2Ax/+dOjjLA9YZgq2Og80lmtchQZLKKYCWZ1
	VY0MdRCVWQktPOVxW/ySPj28xhpvFLTD7didvUUbDDz2wo3GbDdxt8Axxi9jV7Q1OiF+Pxkahuk
	wiXXHWpm+Fzp3TM1K+ZhoD1mnrHn97BRLXt1gJ0B9ewgX4KGs1Amx+5E4sttq7eTpbQWwHF3tAc
	lEFqN121iLMwiHyXBgZtznk3mBLVR7o6POTG4np/n49+N2XP7/iyAUy01gZNCGbb1wufnux
X-Google-Smtp-Source: AGHT+IGs/n3s+ljPxhnH+g77kzWfSIpoVvX9+gmjeFbXMAeiCC1KIHbqdKpuwES2cbl9f+HwXmh2k55li5DiqVgzvXc=
X-Received: by 2002:a05:6000:420d:b0:425:7e45:a4df with SMTP id
 ffacd0b85a97d-42e0f1e3540mr2067660f8f.11.1764066102844; Tue, 25 Nov 2025
 02:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915080157.28195-1-clamor95@gmail.com> <20250915080157.28195-7-clamor95@gmail.com>
 <175847725338.4354.4145979844570539358@lazor>
In-Reply-To: <175847725338.4354.4145979844570539358@lazor>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Nov 2025 12:21:30 +0200
X-Gm-Features: AWmQ_bl56LuUHLPnztGhAMdmRur5Ggnq7b6fJH-NAjFY7Cca_zX_XBphsvjf_7k
Message-ID: <CAPVz0n2xtmNRvawkvWD7FJbfTU0y2bD+qsFoJ4VLmivaz=K7aA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] clk: tegra: remove EMC to MC clock mux in Tegra114
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Osipenko <digetx@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 21 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 20:54 Step=
hen Boyd <sboyd@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Quoting Svyatoslav Ryhel (2025-09-15 01:01:52)
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-t=
egra114.c
> > index 8bde72aa5e68..6b3a140772c2 100644
> > --- a/drivers/clk/tegra/clk-tegra114.c
> > +++ b/drivers/clk/tegra/clk-tegra114.c
> > @@ -1321,6 +1309,28 @@ static int tegra114_reset_deassert(unsigned long=
 id)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_TEGRA124_CLK_EMC
> > +static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args=
 *clkspec,
> > +                                               void *data)
> > +{
> > +       struct clk_hw *hw;
> > +       struct clk *clk;
> > +
> > +       clk =3D of_clk_src_onecell_get(clkspec, data);
> > +       if (IS_ERR(clk))
> > +               return clk;
> > +
> > +       hw =3D __clk_get_hw(clk);
>
> Can you just use of_clk_hw_onecell_get() instead? Then we don't need to
> use __clk_get_hw(). Or is this whole function used to return a clk
> pointer to something that isn't the clk framework?
>

I have tried to switch __clk_get_hw to of_clk_hw_onecell_get but it
did not work, tegra124_clk_emc_driver_available fails and I get
EPROBE_DEFER cascade. I will keep __clk_get_hw like Tegra124 driver
does since of_clk_hw_onecell_get did not worked in this case.

> > +
> > +       if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> > +               if (!tegra124_clk_emc_driver_available(hw))
> > +                       return ERR_PTR(-EPROBE_DEFER);
> > +       }
> > +
> > +       return clk;

