Return-Path: <linux-pm+bounces-6032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC5C89B66D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 05:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553FF281EBE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 03:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D311C0DF0;
	Mon,  8 Apr 2024 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTg9WpMv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCD1C0DC7;
	Mon,  8 Apr 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547188; cv=none; b=cr56X4myu99BYxg9QFKzJiHGTwFF2nJQ94+Zcu7VGDLdE0ADsZAy4/sf8KTn+oWwfadUQFxNDkQKh6iQcDBhXecEZTU13bPt4RGIo/nICWiQGUASfkNDKfbPZGdXrwli0XrUrf/FKeH7BUCd4tWsRtpxfORTLR0Jvbr8FN5HQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547188; c=relaxed/simple;
	bh=jWMZ2HZ3Bb+CCiJ4NDxZ3ZAUHWn0EA4pell8ZZY8hm8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rTh5mc9mC785yCwvWRD00tsHaNVjd47xYPGoYAtM5tKQias8KkJr2IKMuRzLzjUPpCarVgVjJN2Quh+4KicV/3qUnUCSKmRC+ngTZ7IkEstBH6qlDHHwB/dJrlEfL52nO2tpRUfWn2xxLlf01HMZGZUxglJv4/Xbw5aDXenJKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTg9WpMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0715C433F1;
	Mon,  8 Apr 2024 03:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712547187;
	bh=jWMZ2HZ3Bb+CCiJ4NDxZ3ZAUHWn0EA4pell8ZZY8hm8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bTg9WpMvBlPylOJbesSgZiYTOFKFVpnM0tyf9aIQxcKY6ZBsLdDFBYBYhl2Ed8us9
	 wyr9CtqSJ/9ww26TldpUO/sx0XFjXrJlvkru0c4CaMyfkCCadOmOcEoLDT9u9VvnmW
	 LrvRXBepTVlX+slyF6LUyCDjn6/nRQGaaONAZxdmPROvR4WIcQB2TmE6JrsoVFJHyF
	 RiL96QOFEPI9GW1F94TZTNFOwPSh1975UPDcOBwATY4JFvzJECqw1xddNnB6Wa+SdS
	 IkCmwAvWhAZyF3/RVwMlH5puSEW1sNe3Vf7piRAyMwybPOGRFj1lCaEF8Y8N+eEya+
	 19fVuTAkZJGNQ==
Message-ID: <b5235bd84101f25815a523c8a37810b7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240225160616.15001-2-andre.przywara@arm.com>
References: <20240225160616.15001-1-andre.przywara@arm.com> <20240225160616.15001-2-andre.przywara@arm.com>
Subject: Re: [RFC PATCH 1/1] clk: sunxi-ng: h6-r: add GPU power domain
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
To: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 07 Apr 2024 20:33:05 -0700
User-Agent: alot/0.10

Quoting Andre Przywara (2024-02-25 08:06:16)
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-h6-r.c
> index 02b28cfc5525e..363fb7a71e9f5 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -217,6 +219,86 @@ static const struct sunxi_ccu_desc sun50i_h616_r_ccu=
_desc =3D {
[...]
> +static int sun50i_h616_register_ppu(struct platform_device *pdev,
> +                                   void __iomem *base)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct genpd_onecell_data *ppu;
> +       struct sun50i_h616_ppu_pd *pd;
> +       int ret;
> +
> +       pd =3D devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
> +
> +       ppu =3D devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
> +       if (!ppu)
> +               return -ENOMEM;
> +
> +       ppu->domains =3D devm_kzalloc(dev, sizeof(*ppu->domains), GFP_KER=
NEL);
> +       if (!ppu->domains)
> +               return -ENOMEM;
> +
> +       ppu->num_domains =3D 1;
> +       pd->genpd.name          =3D "GPU";
> +       pd->genpd.power_off     =3D sun50i_h616_ppu_pd_power_off;
> +       pd->genpd.power_on      =3D sun50i_h616_ppu_pd_power_on;
> +       pd->base                =3D base;
> +
> +       ret =3D pm_genpd_init(&pd->genpd, NULL, !sun50i_h616_ppu_power_st=
atus(pd));
> +       if (ret) {
> +               dev_warn(dev, "Failed to add GPU power domain: %d\n", ret=
);
> +               return ret;
> +       }
> +
> +       ppu->domains[0] =3D &pd->genpd;
> +       ret =3D of_genpd_add_provider_onecell(dev->of_node, ppu);

Is this provider removed somewhere when probe fails or the driver is
removed? It looks like the rest of the driver uses devm during probe.

