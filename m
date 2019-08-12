Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF389A80
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfHLJxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:53:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37004 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfHLJxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:53:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so11198106wmf.2;
        Mon, 12 Aug 2019 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G2spvlN9eUViINwSX8FLxMr7evAtvkAGUBzR5szrA6Y=;
        b=uNj2PzOWlYlm63XokrWRMDpTE+Vuqj1ANchbpecQS0QcxzFrm5pQbh2FZhKpyxjJJO
         69MGdgUe4m020JK6zmZd9cYpjxOcnwArSNqsGTe/4QF8/ULz/K4t8tzdojHSLloVB8pR
         D7tF6VkN9VUzEnHGDEW7lIe6Pek1g1JbEU2dzxohIUlyg0wYXBXnIOyMwNjIlby4n3El
         hxVFwY04AX2YIVv7F8ksqr2cOYse067RYHQYt5yKpt45a3cfkrPjr7Al8LkKoA47sVRK
         JGdzl9sW5rkb/EmUhs/VcGxZXO8Mp0wbGuHyHqneOZrEltcRwfBzzfB/u/bYeAyl+WRS
         Flzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2spvlN9eUViINwSX8FLxMr7evAtvkAGUBzR5szrA6Y=;
        b=qi68GWwx3WI9yDirlBqPqd4VlebAlOMZ8lBJWeca6LeqP5QqcfAvTtp55t1/wassuK
         TNPv7+N0MvS4JdBYXHmnt5i9Yvy+uxaEEtsb3ug7JTHQHKcVAQi6XFF8gD8BhPWPNcxt
         oPPPZQUEL8YF2Re8Lh8sAwNx3REZi1xlbqVs6osinQhckbbHT+NB2pbtB14QahNW4jfg
         JVL3hRFDYNhGlz4AWlnUG4qcm4bZ1tIixVwtE+/1UuFi+wrJHrU6ZadBZ113OOJ4PEoS
         760wBd5heehO6m9Pp4oJGhvxrz3Mk4rs4NCrtuSc3mLUz2WxfpjuytMkEtdtJOYVLkn5
         9MVw==
X-Gm-Message-State: APjAAAWi7KQWNzyVloDcFt2cF93hvRdqifRkJsoMdq4KszYkNjP5XgtV
        w3Pmd0eq6/SoKW/sRdCFsJ8=
X-Google-Smtp-Source: APXvYqwbMybiTxjGXH5d4FP5EAydJFALYbdnI5jzXf1AhozoLGqlFSqtheu0qHGyI2NDVuElLZ6OuQ==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr27231371wmc.19.1565603625897;
        Mon, 12 Aug 2019 02:53:45 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id o6sm230670853wra.27.2019.08.12.02.53.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:53:44 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:53:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com, linus.walleij@linaro.org, stefan@agner.ch,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, jckuo@nvidia.com, josephl@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, mperttunen@nvidia.com,
        spatra@nvidia.com, robh+dt@kernel.org, digetx@gmail.com,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 09/21] clk: tegra: clk-super: Fix to enable PLLP
 branches to CPU
Message-ID: <20190812095343.GH8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-10-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-10-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:48PM -0700, Sowjanya Komatineni wrote:
> This patch has a fix to enable PLLP branches to CPU before changing
> the CPU cluster clock source to PLLP for Gen5 Super clock and
> disables PLLP branches to CPU when not in use.
>=20
> During system suspend entry and exit, CPU source will be switched
> to PLLP and this needs PLLP branches to be enabled to CPU prior to
> the switch.
>=20
> On system resume, warmboot code enables PLLP branches to CPU and
> powers up the CPU with PLLP clock source.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-super.c            | 14 ++++++++++++++
>  drivers/clk/tegra/clk-tegra-super-gen4.c |  7 ++++++-
>  drivers/clk/tegra/clk.c                  | 14 ++++++++++++++
>  drivers/clk/tegra/clk.h                  |  5 +++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
> index 39ef31b46df5..e2a1e95a8db7 100644
> --- a/drivers/clk/tegra/clk-super.c
> +++ b/drivers/clk/tegra/clk-super.c
> @@ -28,6 +28,9 @@
>  #define super_state_to_src_shift(m, s) ((m->width * s))
>  #define super_state_to_src_mask(m) (((1 << m->width) - 1))
> =20
> +#define CCLK_SRC_PLLP_OUT0 4
> +#define CCLK_SRC_PLLP_OUT4 5
> +
>  static u8 clk_super_get_parent(struct clk_hw *hw)
>  {
>  	struct tegra_clk_super_mux *mux =3D to_clk_super_mux(hw);
> @@ -97,12 +100,23 @@ static int clk_super_set_parent(struct clk_hw *hw, u=
8 index)
>  		if (index =3D=3D mux->div2_index)
>  			index =3D mux->pllx_index;
>  	}
> +
> +	/* enable PLLP branches to CPU before selecting PLLP source */
> +	if ((mux->flags & TEGRA210_CPU_CLK) &&
> +	    (index =3D=3D CCLK_SRC_PLLP_OUT0 || index =3D=3D CCLK_SRC_PLLP_OUT4=
))
> +		tegra_clk_set_pllp_out_cpu(true);
> +
>  	val &=3D ~((super_state_to_src_mask(mux)) << shift);
>  	val |=3D (index & (super_state_to_src_mask(mux))) << shift;
> =20
>  	writel_relaxed(val, mux->reg);
>  	udelay(2);
> =20
> +	/* disable PLLP branches to CPU if not used */
> +	if ((mux->flags & TEGRA210_CPU_CLK) &&
> +	    index !=3D CCLK_SRC_PLLP_OUT0 && index !=3D CCLK_SRC_PLLP_OUT4)
> +		tegra_clk_set_pllp_out_cpu(false);
> +
>  out:
>  	if (mux->lock)
>  		spin_unlock_irqrestore(mux->lock, flags);
> diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra=
/clk-tegra-super-gen4.c
> index cdfe7c9697e1..98538f79b0c4 100644
> --- a/drivers/clk/tegra/clk-tegra-super-gen4.c
> +++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
> @@ -180,7 +180,7 @@ static void __init tegra_super_clk_init(void __iomem =
*clk_base,
>  					gen_info->num_cclk_g_parents,
>  					CLK_SET_RATE_PARENT,
>  					clk_base + CCLKG_BURST_POLICY,
> -					0, 4, 8, 0, NULL);
> +					TEGRA210_CPU_CLK, 4, 8, 0, NULL);
>  		} else {
>  			clk =3D tegra_clk_register_super_mux("cclk_g",
>  					gen_info->cclk_g_parents,
> @@ -196,6 +196,11 @@ static void __init tegra_super_clk_init(void __iomem=
 *clk_base,
>  	dt_clk =3D tegra_lookup_dt_id(tegra_clk_cclk_lp, tegra_clks);
>  	if (dt_clk) {
>  		if (gen_info->gen =3D=3D gen5) {
> +		/*
> +		 * TEGRA210_CPU_CLK flag is not needed for cclk_lp as cluster
> +		 * switching is not currently supported on Tegra210 and also
> +		 * cpu_lp is not used.
> +		 */

Indentation looks odd here. If you want to comment the whole block, put
the comment above the "if (...) {". If you want to comment the contents
of the block, indent one level further so it aligns with the "clk =3D ..."
below.

Otherwise looks good, so with the indentation fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

>  			clk =3D tegra_clk_register_super_mux("cclk_lp",
>  					gen_info->cclk_lp_parents,
>  					gen_info->num_cclk_lp_parents,
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index 573e3c967ae1..eb08047fd02f 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -23,6 +23,7 @@
>  #define CLK_OUT_ENB_W			0x364
>  #define CLK_OUT_ENB_X			0x280
>  #define CLK_OUT_ENB_Y			0x298
> +#define CLK_ENB_PLLP_OUT_CPU		BIT(31)
>  #define CLK_OUT_ENB_SET_L		0x320
>  #define CLK_OUT_ENB_CLR_L		0x324
>  #define CLK_OUT_ENB_SET_H		0x328
> @@ -199,6 +200,19 @@ const struct tegra_clk_periph_regs *get_reg_bank(int=
 clkid)
>  	}
>  }
> =20
> +void tegra_clk_set_pllp_out_cpu(bool enable)
> +{
> +	u32 val;
> +
> +	val =3D readl_relaxed(clk_base + CLK_OUT_ENB_Y);
> +	if (enable)
> +		val |=3D CLK_ENB_PLLP_OUT_CPU;
> +	else
> +		val &=3D ~CLK_ENB_PLLP_OUT_CPU;
> +
> +	writel_relaxed(val, clk_base + CLK_OUT_ENB_Y);
> +}
> +
>  struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int ban=
ks)
>  {
>  	clk_base =3D regs;
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 8a9af45b6084..560e2bcb3d7d 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -677,6 +677,9 @@ struct clk *tegra_clk_register_periph_data(void __iom=
em *clk_base,
>   * Flags:
>   * TEGRA_DIVIDER_2 - LP cluster has additional divider. This flag indica=
tes
>   *     that this is LP cluster clock.
> + * TEGRA210_CPU_CLK - This flag is used to identify CPU cluster for gen5
> + * super mux parent using PLLP branches. To use PLLP branches to CPU, ne=
ed
> + * to configure additional bit PLLP_OUT_CPU in the clock registers.
>   */
>  struct tegra_clk_super_mux {
>  	struct clk_hw	hw;
> @@ -693,6 +696,7 @@ struct tegra_clk_super_mux {
>  #define to_clk_super_mux(_hw) container_of(_hw, struct tegra_clk_super_m=
ux, hw)
> =20
>  #define TEGRA_DIVIDER_2 BIT(0)
> +#define TEGRA210_CPU_CLK BIT(1)
> =20
>  extern const struct clk_ops tegra_clk_super_ops;
>  struct clk *tegra_clk_register_super_mux(const char *name,
> @@ -838,6 +842,7 @@ int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, =
u8 p_div);
>  int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
>  		 u8 frac_width, u8 flags);
>  void tegra_clk_osc_resume(void __iomem *clk_base);
> +void tegra_clk_set_pllp_out_cpu(bool enable);
> =20
> =20
>  /* Combined read fence with delay */
> --=20
> 2.7.4
>=20

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RNycACgkQ3SOs138+
s6FWNhAAlaShT2GFtVBnhhFJ445GVNOhlfEDJqg1Z1G4FVSwFxbtkRYmVuAa+KSq
YgcgH99epOInSsouaVVlwF3uBpAaZVXn1tX3LSzqvbvgDWq4H/EnWOk8jRwKL4Tv
a0CLk8G7kfgwHy83vBuZu2XcBqp8tmWjFLs6Z2g3hohxnwGkmcc1503vqP/Iv/cm
M1Xh+nIcilyWJZh+HSKJXi6gmsciVh1ebEItgZjVzDq74AIVs8WQIsN5evcRPrYH
sF3t8n+vEThtO4yv0nrBwOeXDW7+DoLHbNNttnb++5DoJ8YPFamEOhPXULomtH+5
W0WYACbVmq+r/vSGq0/CvdsUOuXfUtcIFRcSKflomIi9sIE62Zxcgx2Mu5DFwF3J
mKVetDtHpqnWn8HP/cwAd/pUI8OBiUczzdneJtYY+Kl9HYZ+QRhvR69C1QXt00JS
hx41ObgsLn66B2pmKcOzCs8IlPfzPnjzNpsiRloHv2b82be/VHB3CR+H1LUkv2BY
nQmdXPUOLaFeHUMUgXus4i8XoHOWsxnIAQdgW5Q44BQesc0eOZKGl9aRbO9g+8Wi
xNTHsaXoSDCGsEqEGC4suyUqz1CI9OrGbRcJRSr72zdSO0krgOV4Gy8lgvHhIDjw
03rH1AMxPh3jCXhHiN9SFNSPPDhbguHoEz+5sDezI0s52deFTGY=
=ARG9
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
