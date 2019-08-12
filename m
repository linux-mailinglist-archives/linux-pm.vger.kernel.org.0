Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2989AB6
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfHLKBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 06:01:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfHLKBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 06:01:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so11222505wmg.0;
        Mon, 12 Aug 2019 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lWrWlWYj8cvJ3r/FmTFT+tjcuUTnaXDsUrXZMHuksYo=;
        b=ar7EqkwRDl4xpHq7AvfU+gQfmaCoAx0Y5xv4UIH3A22fsLoa1bYP0OmScYRKH7+sm7
         cdyo2gCE+RqLB4wPd4ZmdFEnrHNyi3oMc07+lRaOYIcG7SZ2H0NAW+98RQuHLW/Y6qab
         577eq+Ax3qjdC06Yapg/VO4CQgJopb94nnJ6aDssiGX1GJKvrxdXinB25/bc7erswV0y
         A9GZ5L02/zoR2WgNtvroCGwisa5J14PcsEajq8BH1g/MttOaw2vZheArGNnvPHmgCCe1
         FEdFjG7+h6oMs79m/flFofwXY3u6zHPrJIwo+KNyQ+F9At/C0yyA4hv+rZpdT59aTqkg
         PbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lWrWlWYj8cvJ3r/FmTFT+tjcuUTnaXDsUrXZMHuksYo=;
        b=XZHO4aElWcg0GG4OPN5rXJ9FNtlOSJLUQZ+WzMMh+U7x+EKASHN1eRKhFgNIZr1EGF
         e1Lok/jhuKbtMvJpcoBis0fJbvaZg83q3UdzU6T6XefJBKuMY9GMmO5eRohb9HsI/QZS
         WBWuILAtNA7zNf6NUGGyYTvYTfvhg5BSnRHZUGJzlFOXfygbuJwOlboSpupNQrmYPo/S
         +RCyWK3xs/NLBYdefDoZN3+ulMDUqIJcx6KEO0AAbB2wMIrTVCjvYXNUrbQesm3FjMkM
         NT8FZzDxtd/ByQ3scQh4KxPQiqtkjoODIe7xR49dG/GZBVGg+kvHwfH9Px+biOWYfuve
         W0ww==
X-Gm-Message-State: APjAAAXLBoz3zKi7Xt1fce3yGqvlzkueEFeW3cOvi4OVHqIdPpQYP24V
        KgWErTdZKjVbQI9arNUKqkY=
X-Google-Smtp-Source: APXvYqxDtGEc4QyyHF/B4+oUczVRvnYQ6PMqgZN8YjrpYNhCxVjC+msiBt4HMMk+Kaaf+7tJZEYpJQ==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr25880744wmc.33.1565604089682;
        Mon, 12 Aug 2019 03:01:29 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id u5sm8764194wmc.17.2019.08.12.03.01.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:01:28 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:01:27 +0200
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
Subject: Re: [PATCH v8 11/21] clk: tegra: clk-dfll: Add suspend and resume
 support
Message-ID: <20190812100127.GJ8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-12-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-12-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:50PM -0700, Sowjanya Komatineni wrote:
> This patch implements DFLL suspend and resume operation.
>=20
> During system suspend entry, CPU clock will switch CPU to safe
> clock source of PLLP and disables DFLL clock output.
>=20
> DFLL driver suspend confirms DFLL disable state and errors out on
> being active.
>=20
> DFLL is re-initialized during the DFLL driver resume as it goes
> through complete reset during suspend entry.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.c               | 56 ++++++++++++++++++++++++=
++++++
>  drivers/clk/tegra/clk-dfll.h               |  2 ++
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  1 +
>  3 files changed, 59 insertions(+)
>=20
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index f8688c2ddf1a..eb298a5d7be9 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1487,6 +1487,7 @@ static int dfll_init(struct tegra_dfll *td)
>  	td->last_unrounded_rate =3D 0;
> =20
>  	pm_runtime_enable(td->dev);
> +	pm_runtime_irq_safe(td->dev);
>  	pm_runtime_get_sync(td->dev);
> =20
>  	dfll_set_mode(td, DFLL_DISABLED);
> @@ -1513,6 +1514,61 @@ static int dfll_init(struct tegra_dfll *td)
>  	return ret;
>  }
> =20
> +/**
> + * tegra_dfll_suspend - check DFLL is disabled
> + * @dev: DFLL device *
> + *
> + * DFLL clock should be disabled by the CPUFreq driver. So, make
> + * sure it is disabled and disable all clocks needed by the DFLL.
> + */
> +int tegra_dfll_suspend(struct device *dev)
> +{
> +	struct tegra_dfll *td =3D dev_get_drvdata(dev);
> +
> +	if (dfll_is_running(td)) {
> +		dev_err(td->dev, "dfll is enabled while shouldn't be\n");

Minor nit: "DFLL" in the error message, just like you have in the
kerneldoc comment above. Perhaps also make the error message a little
more specific. "while shouldn't be" makes the user guess what that
means. Perhaps better to say something like:

	"DFLL still enabled while suspending\n"

or perhaps even add a hint as to what could be the culprit:

	"DFLL still enabled while suspending, possibly a cpufreq driverbug\n"

The latter is somewhat long and the former is enough because the
kerneldoc comment already explains that cpufreq might be the reason for
this.

With a more specific error message, this is:

Acked-by: Thierry Reding <treding@nvidia.com>

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ROPcACgkQ3SOs138+
s6GNTQ//VCpA84fs+aIIyDiD3wn1shO+OCh67D3tZ+8ScJa6j54SmHrCHGGWY3GP
9JVQr5VFX4tMxrslidnMe6laHcoM5JU+vPSovEq5dTqjZe2HTmjsMswUBABd/Jrg
fid7ioVcpPfdbbO2qNMS42Q698Kx0IFAv1t4NmhmCDDaE6NerYN8eJ94KYrFx7TI
p4mvNUV3WcR9aGEOLwVyAcUatmR5EReyZJJ8nSNdPxfdzrLHUUtI9oIP9q8ADgpl
djfabIZYjrDWaNIx6X/HLQU+3zf3C/SvDMsDJd8/oOa1WkOXKy7Wsbgt6PWZpm8q
DbMkl8e57/v5fEfaERkqq+U9C0GFdZfpriI7qofQvbi80rkVrDq8UKEAQa/KkfeN
8wiHr9XVeIwddApapx1YilBL1gAAphRdD7NOzvxeO4KMKCzbuQ7upYReNtBEaMVA
EwhjYNEVWuEMwg3S5ssxpjqyWMT11WUDIxmX3WqPswNzN1K/dNCrDzKye1IVIET/
s66UjxKscWJVnsmQWUVE4LKw3S6Tct4BOR+Us7XDJd9f417iSCTTC8lsEoz2PCIv
tWNEWekILl5Pg/yT5SXy6z8+0g0fsD9R3Pxe56vf9dnGiG9kGx0wmP02FENpKUs2
T+fSap9ZYLgjVvT2L3WDyQZWbVDl8X31T5nCquBVXKYSWOQqwrM=
=U0sL
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
