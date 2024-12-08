Return-Path: <linux-pm+bounces-18763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58F9E850B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4452F281572
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25432148850;
	Sun,  8 Dec 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyhJNTCi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F31474B8
	for <linux-pm@vger.kernel.org>; Sun,  8 Dec 2024 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661792; cv=none; b=Dgo9jPo/HUO+gASBbjHiMWCnFo8aNX49STEqECLu/PsYZ18iOTSloL3vdN/aPzLrTHKWTBD2CEWWaU/gr2FbfvyAJzNhS31xP/97IbCHFzjuBCl3B9jf/nSZ2jn5pfxfpSNscc5FZbKpiBU72Eou8RQswwldWJSqVV81TJ1650M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661792; c=relaxed/simple;
	bh=Y1VrfaUJOsHO1WFsOHnhUnMmpc+knkf8+T6J1ZH+360=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7WG0t9owyTm1SV6xwcVOrstlgRtJwaD0k/ZimcY+kZkS/SMwtWSeaBnDhb7uPCT/sY9SyQpBhxYDFBznxIPu4Q7MG130duXBUzEqEfSoQYf6zeS/Qr+YHXp05bK0OqOhaSNVzgw9ZclwXsN4nLsaBb50BSa/k7xYFrJ5yepT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyhJNTCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E89C4CEE0
	for <linux-pm@vger.kernel.org>; Sun,  8 Dec 2024 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661791;
	bh=Y1VrfaUJOsHO1WFsOHnhUnMmpc+knkf8+T6J1ZH+360=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JyhJNTCiW50mZQhwiOkkRceY8SYIGl0bPdnLmEdR4PDpOIRBk2UZNOGnq12S4Ut+6
	 3nyTam2ylc+T3VFg4uivwD1VRLuCPjRKli+mJLNNPF4gg0Qnvti57/IZcxOsabOcJq
	 0VYObQvVjR8sBVNlxVEmfSJQL6KIG967hahZcSyNIFnYj3IAzSBM8IV1WEMBjKANvP
	 lHM4TEcBaWAgX6zdKiHCxFHIhPdBA4hior1CBBCqqDEnUB0Y4zLuGivfg8m1Jic5xB
	 3v8HvDDwDnplzSV2gzVZuqWHovTgRtd6jmCaqBZKvQvkiXD0Fj9MNmH1TWsuMPuh/Z
	 8uAVLavPHFLTQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so4273882a12.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Dec 2024 04:43:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNLOfERPFy3UkXBHloc42c60Id4Mwmg5NOz0bfyegdNVXUFeqUkiFLVUw2saWBTFdO4Yx2kwDTlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGhXXPUE/cx0hot078aZs7tABxmghFDokm6q5tWCB4Pr2S75x
	1EATJRp7Bi6av/m+jCepS7/l7ErbMZQS5ajssJ12NGmSZBUbLmCQhpzVX1esKWHSnKQ3KLZqSte
	iIO735eqq9ONTBdRmOsM4eHp0zKc=
X-Google-Smtp-Source: AGHT+IEwMdJAK1TEIbACXHy0BbMLfAFH2951o0gRCPTzx5amZVYs+eE3LjkD4Lm7z7Ax4i9ZpMDZ4K8dvkv2F0pucxM=
X-Received: by 2002:aa7:d3c8:0:b0:5d3:cd5b:64a9 with SMTP id
 4fb4d7f45d1cf-5d3cd5b656dmr6300254a12.34.1733661790431; Sun, 08 Dec 2024
 04:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412070231.MzXdNrLv-lkp@intel.com> <faqkdyfv4wstpsc6miyfwq73nyj7tke4epses4msjewrh26her@vpovriyfjtcv>
In-Reply-To: <faqkdyfv4wstpsc6miyfwq73nyj7tke4epses4msjewrh26her@vpovriyfjtcv>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:42:27 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1uDfp+tD395SyA201880rUKRKGYwjM+pCaFRMzDzF9-Q@mail.gmail.com>
Message-ID: <CAGTfZH1uDfp+tD395SyA201880rUKRKGYwjM+pCaFRMzDzF9-Q@mail.gmail.com>
Subject: Re: [chanwoo:devfreq-next 4/4] drivers/devfreq/sun8i-a33-mbus.c:384:47:
 error: passing argument 1 of 'devm_clk_rate_exclusive_get' from incompatible
 pointer type
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org, 
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like you to make the new patch without error.

Thanks,

On Sat, Dec 7, 2024 at 5:37=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Sat, Dec 07, 2024 at 02:37:41AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.g=
it devfreq-next
> > head:   27d1a5d95c5202f927f1155ad8f919778cd9f155
> > commit: 27d1a5d95c5202f927f1155ad8f919778cd9f155 [4/4] PM / devfreq: su=
n8i-a33-mbus: Simplify by using more devm functions
> > config: arm64-randconfig-002-20241206 (https://download.01.org/0day-ci/=
archive/20241207/202412070231.MzXdNrLv-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20241207/202412070231.MzXdNrLv-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202412070231.MzXdNrLv-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/devfreq/sun8i-a33-mbus.c: In function 'sun8i_a33_mbus_probe'=
:
> > >> drivers/devfreq/sun8i-a33-mbus.c:384:47: error: passing argument 1 o=
f 'devm_clk_rate_exclusive_get' from incompatible pointer type [-Wincompati=
ble-pointer-types]
> >      384 |         ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
> >          |                                           ~~~~^~~~~~~~~~
> >          |                                               |
> >          |                                               struct clk *
> >    In file included from drivers/devfreq/sun8i-a33-mbus.c:6:
> >    include/linux/clk.h:214:48: note: expected 'struct device *' but arg=
ument is of type 'struct clk *'
> >      214 | int devm_clk_rate_exclusive_get(struct device *dev, struct c=
lk *clk);
> >          |                                 ~~~~~~~~~~~~~~~^~~
>
> Huh, back then something with my build testing must have been broken.
> The right thing is to squash the following into said commit:
>
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
-mbus.c
> index fae0793182a7..52e146fe389d 100644
> --- a/drivers/devfreq/sun8i-a33-mbus.c
> +++ b/drivers/devfreq/sun8i-a33-mbus.c
> @@ -381,7 +381,7 @@ static int sun8i_a33_mbus_probe(struct platform_devic=
e *pdev)
>                 return dev_err_probe(dev, ret, "failed to lock dram clock=
 rate\n");
>
>         /* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
> -       ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
> +       ret =3D devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to lock mbus clock=
 rate\n");
>
>
> If you don't want to rewrite history, tell me, then I create a proper
> patch.
>
> Thanks and sorry,
> Uwe



--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

