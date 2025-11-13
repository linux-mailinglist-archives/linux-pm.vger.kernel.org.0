Return-Path: <linux-pm+bounces-37959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A1C57E73
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D58D34E6CE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26B2874E9;
	Thu, 13 Nov 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haoMfR6B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CC284B29
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043699; cv=none; b=Q3m5+xJZu8abk7434aomcUvg+qIdSMQqukONvuJwrq4Hv/kodffU0r9P5qFCtEfwgreW7d4mCDT/MIWF4IWygRbz6dSY65GP5jmCe2nJebKw+jBtmIRiSQcZSA07jbaSE7HVhFYyfB5x7fPTq3CPSKQFMuG8y4yuL+ynZGu0gXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043699; c=relaxed/simple;
	bh=Xe7Ea1AD5sUFo6oXsT+qD/kgt+3KXcnBspVGZoedp+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnJYXbwLqmqTtr0VEafdwz4jlBJnUAOYIUKkkwiAuFHL09w0c43N7u/73vT58Wct7Qo6JcEY4S9L/+QqQkivyWw+qzv5YLCbW6HoKAo9myIdstdFCym01KcPiY/IIbl/AthzHcqUiMpkUhfJGpxqNZGQueuZ0qFmF53iFXKr6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haoMfR6B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477549b3082so7850475e9.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763043696; x=1763648496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVTH3OodIWn9qSwlGdTpQLDwP01tYh5/+5JVhlUv+nY=;
        b=haoMfR6BOBTWSk33QievBrW0k/VGkRlaKureVuWz+EWYvTVVkZkFCMS6eUUnmQYSAw
         vR00hPMIblDxs46XHig8ocQyFTYfG0mPmuOK11AFrGYZs57O3apL4OpumSJgqFigVh36
         lyVMQdtFw3YH4m+hcIbCk3o2FezKLi4XqOV58JZ2kJkkNQ1WX0Sif7s9Hx0Tt3siIYBg
         jDvH4kP6ALOvxN8Y29K9hs/n8oC+sunAquEbV+d1ez384R0covO6b3Kc2mg9vhSHDpWe
         AgdmA1cioKdK4YcHP25oSF/2Y4YsemfW6erNdywEyN0rKnW0Bm31/95VA0jms1JTGL7A
         45Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043696; x=1763648496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVTH3OodIWn9qSwlGdTpQLDwP01tYh5/+5JVhlUv+nY=;
        b=JTJs7CqsDV/IHd/J+eaJv4UQeaumCi/Wu9IX08/DrocUrIJJcnJucy2btMqzSVYubb
         2mXAZuyRCERjyrwwrLAf9LXmUnb2SyN6vyR0AKVBTB6TAGLYe7d23LNXhpU76qqflmWj
         G+w3VtRa1enY7RPRkepPpSHN+GpwxO/9n0QDyScDNSDmmx9YFnaPrJ103T4fESIvtNV2
         5cgp5ImgffPC3/kQUjkGwemlw9P64YPPQgtf11+Baa3vWeXZf4xkUdnHlvh4M9oKKuk/
         NS6jrzoDcIq9pDBHFpetu9QoDJfS569KvAgI+ZWLzm/VE9YtzWHk31imk3xqvWD6d/4W
         MC9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTKJ+feTosoB9tFEivxt29gvOiFueupn/q9m5Eb/m6Z8sq4wuqc2cb9A22XHq82eU8yokmZ670Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfGs0j+xdGs+/ONKDtxj2zKc/4mDcELTKPNC1u8Cb43dr29Ug
	T2ObIejs7tI+XxoTDIMuwzcWlkubssdOdWESuy82VDRp5Y+rL0PiDfiPWijdz3TTE+F6MLN0nxr
	qlQ1trhL4mR02p/OhAPiMEkwsOTlNnPk=
X-Gm-Gg: ASbGnctfAZMEgi+aUGlSBryvZIfeTFxgPnccM5jv049wJ68Vf0Y2G+j26SN9O7JZ1p6
	vklsXrpIrItRTz+RxTXdFJw/Ss5zUVvwrSJ1DhL6R16Oe5visvbMEL4sI0lf+swRgD/Zm5oUD0D
	cW4u1VHq1lVF5p6dBY3YiQn6soCuXzbNgKR5Yk1dUcb3UCir2BvPDR22XfXV3NsKzYMoRYmpJAC
	qReNHALRjtrHSlSeSvkaezci3VBPnN4WQ7RDhEeto59ZFN5Da3L7fzrZnR41OqsSJWf1N0r
X-Google-Smtp-Source: AGHT+IHpKdVN83TCm20YE3t1L1lDlWwYUNuksMEsa3ToWtEDthhiiFsiCO+R+2diKHhI8EC3wUv5l0WKP1xsWN52j2s=
X-Received: by 2002:a05:6000:4210:b0:42b:3ed2:c079 with SMTP id
 ffacd0b85a97d-42b4bdb3157mr6520095f8f.48.1763043695648; Thu, 13 Nov 2025
 06:21:35 -0800 (PST)
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
Date: Thu, 13 Nov 2025 16:21:24 +0200
X-Gm-Features: AWmQ_blflchRXgqVJi0za8JR5StKpVBhyxQTDb1Y4F00r9nuMPcYEvgT9Q0wdNU
Message-ID: <CAPVz0n2gUT5aOT3S05Up+vAiMBf5jmthRV_7z_fpj9RsPWEg_w@mail.gmail.com>
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

This logic was adopted from Tegra124 driver, but of_clk_hw_onecell_get
might be applicable. I will adjust to use it and if all works as
expected, I will apply it in v4. Thank you.

> > +
> > +       if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> > +               if (!tegra124_clk_emc_driver_available(hw))
> > +                       return ERR_PTR(-EPROBE_DEFER);
> > +       }
> > +
> > +       return clk;

