Return-Path: <linux-pm+bounces-35125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A0B8E2A4
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 19:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2298B3B7F02
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174126CE2E;
	Sun, 21 Sep 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN9EP4k7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30122AE6A;
	Sun, 21 Sep 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758477255; cv=none; b=EVL4u0/U+EDIXd73QteSmZ9ZvL/u/5dcxCglyGWsAlaphSQvulpq2M7ta/KvPar6Q3LBdngVPB9x8bG/A4ysse4QlZyDaRiZFcKqI5ImR01IJa2KOWESOd0oxRHf8/fPlSzsxuAdsFmooSNrqMJh9UmJ3zIlyhhrgs1OEJVFy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758477255; c=relaxed/simple;
	bh=ypzo+3PMu9bLzVVOUbp8LKYZ7ZW06X9TJgzOBqby/8g=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=jbbrDtI/o+1ytNXvTKtOGcDjYmJwDycFgYJuvELuybtYAL/l2kV0BRMvQlLGdIUbiSErESe75RtWyKmOMZcywqGYW59/S9vCOq8JQ2GYnjA36GFe5PBH+UqbCXp4nidbYzo9lDe+yJpp9qC7DPNDHwV8ucFA05/s5TMs9rp+GZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN9EP4k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94BDC4CEE7;
	Sun, 21 Sep 2025 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758477255;
	bh=ypzo+3PMu9bLzVVOUbp8LKYZ7ZW06X9TJgzOBqby/8g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dN9EP4k7trHibwCBzzsM5veaTrH/dC46AzdFdMJxejZ0CV7NFya1PlK9k2f2XyZZJ
	 fJ4CVcifA1piF6s5izpji5JiuljVxrDNagoAdmgXOo59QMS+xGapjHZytK37J7t7uh
	 sMdkt5rj5djJhVMEpvwxScYO5KxNxmei4ADIrdHSmc9PbWEme8pnnd0UXLEWJPEHVQ
	 d+523Yz1Xz0T7YCPct3W/+aDi81G3x/fDAEBZjOB8modZt5DOTy6XvgPDsDjZ8+G/b
	 nBxd/88YbYKmdMKDPMigyhLfbQBC0EXuRNr6Jn1zNiCqBp5QtXBTpqvIVDtrpkdxDZ
	 1xh2xEgAWsxVA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915080157.28195-7-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com> <20250915080157.28195-7-clamor95@gmail.com>
Subject: Re: [PATCH v3 06/11] clk: tegra: remove EMC to MC clock mux in Tegra114
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>, Dmitry Osipenko <digetx@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Mikko Perttunen <mperttunen@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Rob Herring <robh@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>
Date: Sun, 21 Sep 2025 10:54:13 -0700
Message-ID: <175847725338.4354.4145979844570539358@lazor>
User-Agent: alot/0.11

Quoting Svyatoslav Ryhel (2025-09-15 01:01:52)
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-teg=
ra114.c
> index 8bde72aa5e68..6b3a140772c2 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -1321,6 +1309,28 @@ static int tegra114_reset_deassert(unsigned long i=
d)
>         return 0;
>  }
> =20
> +#ifdef CONFIG_TEGRA124_CLK_EMC
> +static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args *=
clkspec,
> +                                               void *data)
> +{
> +       struct clk_hw *hw;
> +       struct clk *clk;
> +
> +       clk =3D of_clk_src_onecell_get(clkspec, data);
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       hw =3D __clk_get_hw(clk);

Can you just use of_clk_hw_onecell_get() instead? Then we don't need to
use __clk_get_hw(). Or is this whole function used to return a clk
pointer to something that isn't the clk framework?

> +
> +       if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> +               if (!tegra124_clk_emc_driver_available(hw))
> +                       return ERR_PTR(-EPROBE_DEFER);
> +       }
> +
> +       return clk;

