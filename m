Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F034511
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFDLHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:07:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfFDLHt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:07:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so10510068wre.7;
        Tue, 04 Jun 2019 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dzmv5f/tB55ppvfWSDgrYl0NxAQ9wg83wzA62DKiOUQ=;
        b=MPC19/+0j53h8zLPkewYYhh+vLB5ivqrrXzmB64cUcWDjxGhnpChcIomKsunjm6Aup
         jS94oU3wOF+IVgVZG1hs8xkXzDfCtobX0iXMMJ/TaNWA4J+uo6GN0H1rIMAcrgkSlI7N
         N9d8vremAHFg2y8G5cV95op0GryEZ42GSGY7blrqgKcs3HMMYlRCcaVSev5t/YVBbQ3M
         c5MXbNRTQjSCG5469e1BE2PscbtsyBLdM+yDEMDAlE9mWpTnqVPkGzt0o4QwSHus3KMK
         kX456FxcY2ZAECpkyehcvt9vn0NX1tBTcPVgoZ7ZrltueXzdjHvRMU7A+q1zRyb5eAwB
         DJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dzmv5f/tB55ppvfWSDgrYl0NxAQ9wg83wzA62DKiOUQ=;
        b=MxhNLQNeIBQkh9KjQotdmN69hPGIQQstO/BaEuJREwh3kjO8Vx2oFid46HqIIqaCMR
         9FtZMfMYs4ipuwGzR6uk4J32DTn+CzzTjwcdJcqtCQf3osgTYUtq12tm9pNOV+IhnObl
         gStiZ+Qjh3sSC2XexfcZiW71xA0X27xYWwbDOZWTCJi3Ezhwys2E0UdM6x/gojkPC6ty
         WQ8JVGSfsaiSa6nlFEe4syozzMsWKhF0+g9EP9aA2vvsTl6HyLGCLkowR3nhGrRBgNx8
         04lof2P0o35/02QAwO7NYf8APHoJPNJbTPJokQnGomCdIokcjr/PkT2UD2EGAIunAH7X
         L/eg==
X-Gm-Message-State: APjAAAXMM/jxDAUhrDxKR1/8YVAZSsvplDdDc4+xZ7ck5oQScvCwxNWD
        UJkEbA3mPP5sgs0kjVdm/pc=
X-Google-Smtp-Source: APXvYqznMduIOGbML4XqKgU85PZ2fbQ8UTghTr+ITgk+B2xKMfiNSEC9ZMc32f0k5kGn94HvV/1P8A==
X-Received: by 2002:adf:fd09:: with SMTP id e9mr6556456wrr.292.1559646466387;
        Tue, 04 Jun 2019 04:07:46 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k185sm1944623wma.3.2019.06.04.04.07.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:07:45 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:07:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
Message-ID: <20190604110744.GG16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-8-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:06AM +0300, Dmitry Osipenko wrote:
> There is no guarantee that interrupt handling isn't running in parallel
> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
> disabled in the Interrupt Controller in order to ensure that device
> interrupt is indeed being disabled.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devf=
req.c
> index b65313fe3c2e..ce1eb97a2090 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>  	struct notifier_block	rate_change_nb;
> =20
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
> +
> +	int irq;

Interrupts are typically unsigned int.

>  };
> =20
>  struct tegra_actmon_emc_ratio {
> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct te=
gra_devfreq *tegra)
>  	u32 val;
>  	unsigned int i;
> =20
> +	disable_irq(tegra->irq);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev =3D &tegra->devices[i];
> =20
> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct t=
egra_devfreq *tegra)
>  		val &=3D ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> =20
>  		device_writel(dev, val, ACTMON_DEV_CTRL);
> +
> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> +			      ACTMON_DEV_INTR_STATUS);
>  	}
> =20
>  	actmon_write_barrier(tegra);
> +
> +	enable_irq(tegra->irq);

Why do we enable interrupts after this? Is there any use in having the
top-level interrupt enabled if nothing's going to generate an interrupt
anyway?

>  }
> =20
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
> @@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device=
 *pdev)
>  	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
> -	int irq;
>  	int err;
> =20
>  	tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_devi=
ce *pdev)
>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>  	}
> =20
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> -		return irq;
> +	tegra->irq =3D platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err =3D tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +		return err;
>  	}

This is very oddly written. tegra->irq should really be an unsigned int
since that's the standard type for interrupt numbers. But since you need
to be able to detect errors from platform_get_irq() it now becomes
natural to write this as:

	err =3D platform_get_irq(pdev, 0);
	if (err < 0) {
		dev_err(...);
		return err;
	}

	tegra->irq =3D err;

Two birds with one stone. I suppose this could be done in a follow-up
patch since it isn't practically wrong in your version, so either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2UQAACgkQ3SOs138+
s6HPvRAAogvLg24roavW9e7A3VdF3hlMWEnqKCC24FEBd6eTJ4Nt7X3va3AxSlfE
S4tU3i5ZTylG1nrwSRetmfiz1mvRp8IXOymC/HY4u/JH9DOCkZZGuR+BX6UZNO02
ia2b2p4R1lJQ1Pma23WXwWq1cdZwuDLURu8jFOJXeya2AxwDMHvvEH5fRmTIi8Si
gWzaDJflpljuWmkq+BwQAbc3r3L/r06kuwhGpzEZlebWb3i/mdMz8fh1wN/Eaeq8
h5jy38K1DkUdE5ZrK9iGwx1XW7Zr7boGxDqvqcRH0Id7IPQFHmVP3FqKsrHc1Dh0
c/N413JawucZ5aTMjAMfg1sggJPSwYH0bni94CKnzXToLqRhcVDQzdFb4fmFRBUY
t7NRFkgGUqK0Q8bULX05mvuU1cuB6+aWu+lCIOuMRp0dOf+01dS8SHpVoJHA41od
LqEMJZTzlufBV06vHugV6N6LoTxiBiomyhgAmiJEexsYL778fZIm3TgPHqhPeEL5
dHOp8ray2NBNl8ufwAeI2ynRelZJhqk3+loyz+JkU6TeLnQArrmhSwGoJYX2/0U7
Kc5FNjzTI9nwrxgCetKV3VG56ut4qNVjo4CXr0QIsVQtV/yD2ufAB0y8fyBOFQ5X
Wfcjge3dgrtlqi0WrARpwL3Kiz9OMJyPdykYEIr1GFsXLiKMbG0=
=39a/
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
