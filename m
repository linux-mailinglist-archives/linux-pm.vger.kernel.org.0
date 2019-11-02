Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BCECF3A
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2019 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfKBOmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Nov 2019 10:42:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40019 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfKBOmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Nov 2019 10:42:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so670522wmc.5;
        Sat, 02 Nov 2019 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zM/whlM8S6AD7q0IG4j9Y/yF+Vk/WbrdulCi0E4vlj8=;
        b=iwGBKLSDUfsCAdyiIq3h8EhR6EvUb2SN2zTg6gmEXsHvuqR0maTYYirLw/8kTLPqBy
         k69Y5DD1HyVcDs8/buJaX9YrN/jXT0yWFFzIAhku/DZHFyg8snwFhx347TV+TzHFBlQD
         SH1dX19c45XgPESounMeiHToboXRpqhtgYTzV4PdMqB8rJD//rCVMXc/WylNuybW8XWE
         +9bDyL70FaXDX2Yn5nismcKUOFawOQtM9/KqhnRcimv0uqqSC362HvbOF4cvPIng/VNt
         gGOjikIpsc2zFoltMNe6dULOks+QL3BW7e8SKcai5LiDx2HzlZkCCzjS53bzJBFfGYCO
         Ging==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zM/whlM8S6AD7q0IG4j9Y/yF+Vk/WbrdulCi0E4vlj8=;
        b=QjTkDWO5OmOl5QvRUJA5xOsg3UGpcKjmu3KsJbm6uu4yjEmVU/XRVbzmN0wn8qJGWc
         UntFiEU/alhp18WU+Ur22GUH3I+qPooH6FIwayF4HPzsjx98L3nYVzeZZzQHLzYRcr3t
         gT3npAP0SrHN5L392h/BB8YffHRY08frs0RtwaAQ9Y9w4KTN3/103+DXk7rVPshpOfCB
         A47i3t0Licx5YPVqI6b1TNA03EORABxwfWjlJmurNYoRnxmUaYnW2AmDlXi2RmlQUqs/
         /CDOT9PBmf9MvlqrppmfhcREfzVX5GCP1AYpiyzB67Y16Maxt9hwhne64tX+F4DjLt3G
         QyrQ==
X-Gm-Message-State: APjAAAXiRvkmGn9onD8pqroOL/CGX4d2PrOHiAYYxBa9KS1QX6cuBFIg
        ZFynAHgjV8Pfp4EV7sJPYcQ=
X-Google-Smtp-Source: APXvYqwokwBFr2MYtxdsK1z72BadaiVS2AUHSRK5nNH91bt5QvEJYBLtSr9FSyNwudJUMSBU8CErAg==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr9780746wme.107.1572705758991;
        Sat, 02 Nov 2019 07:42:38 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id s13sm9727704wmc.28.2019.11.02.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 07:42:37 -0700 (PDT)
Date:   Sat, 2 Nov 2019 15:42:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        digetx@gmail.com, devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 12/22] cpufreq: tegra124: Add suspend and resume
 support
Message-ID: <20191102144235.GA3862867@ulmo>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-13-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1565984527-5272-13-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 12:41:57PM -0700, Sowjanya Komatineni wrote:
> This patch adds suspend and resume pm ops for cpufreq driver.
>=20
> PLLP is the safe clock source for CPU during system suspend and
> resume as PLLP rate is below the CPU Fmax at Vmin.
>=20
> CPUFreq driver suspend switches the CPU clock source to PLLP and
> disables the DFLL clock.
>=20
> During system resume, warmboot code powers up the CPU with PLLP
> clock source. So CPUFreq driver resume enabled DFLL clock and
> switches CPU back to DFLL clock source.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 59 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 59 insertions(+)

Hi Rafael,

I was originally planning to pick this up into the Tegra tree with your
and Viresh's Acked-by, but I now realize that there aren't any
dependencies between this and the rest of the series, so this can also
go through your tree.

Do you have any preference on how to merge it? I've already Acked this
=66rom the Tegra side, so feel free to pick it up if that's what you
prefer.

Thierry

> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra12=
4-cpufreq.c
> index 4f0c637b3b49..7a1ea6fdcab6 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/clk.h>
> +#include <linux/cpufreq.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -128,8 +129,66 @@ static int tegra124_cpufreq_probe(struct platform_de=
vice *pdev)
>  	return ret;
>  }
> =20
> +static int __maybe_unused tegra124_cpufreq_suspend(struct device *dev)
> +{
> +	struct tegra124_cpufreq_priv *priv =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	/*
> +	 * PLLP rate 408Mhz is below the CPU Fmax at Vmin and is safe to
> +	 * use during suspend and resume. So, switch the CPU clock source
> +	 * to PLLP and disable DFLL.
> +	 */
> +	err =3D clk_set_parent(priv->cpu_clk, priv->pllp_clk);
> +	if (err < 0) {
> +		dev_err(dev, "failed to reparent to PLLP: %d\n", err);
> +		return err;
> +	}
> +
> +	clk_disable_unprepare(priv->dfll_clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
> +{
> +	struct tegra124_cpufreq_priv *priv =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	/*
> +	 * Warmboot code powers up the CPU with PLLP clock source.
> +	 * Enable DFLL clock and switch CPU clock source back to DFLL.
> +	 */
> +	err =3D clk_prepare_enable(priv->dfll_clk);
> +	if (err < 0) {
> +		dev_err(dev, "failed to enable DFLL clock for CPU: %d\n", err);
> +		goto disable_cpufreq;
> +	}
> +
> +	err =3D clk_set_parent(priv->cpu_clk, priv->dfll_clk);
> +	if (err < 0) {
> +		dev_err(dev, "failed to reparent to DFLL clock: %d\n", err);
> +		goto disable_dfll;
> +	}
> +
> +	return 0;
> +
> +disable_dfll:
> +	clk_disable_unprepare(priv->dfll_clk);
> +disable_cpufreq:
> +	disable_cpufreq();
> +
> +	return err;
> +}
> +
> +static const struct dev_pm_ops tegra124_cpufreq_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
> +				tegra124_cpufreq_resume)
> +};
> +
>  static struct platform_driver tegra124_cpufreq_platdrv =3D {
>  	.driver.name	=3D "cpufreq-tegra124",
> +	.driver.pm	=3D &tegra124_cpufreq_pm_ops,
>  	.probe		=3D tegra124_cpufreq_probe,
>  };
> =20
> --=20
> 2.7.4
>=20

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl29ldkACgkQ3SOs138+
s6GR4w//Ti81Vt9yfuiyTAKRnT23nbpt2nOwUpiZdVVifWAxX2mZT0UMIyKfOcQK
BHYu6iXvOJ8iUBP/Mp+RNWJqwKGoRen6WvsMzCpWeagN+cfIGbtIcW+mUYGU5gEm
gjwtwzOHXAXuc/LlCHhOV8TIUlsKQa5lLdLLv+HWAlqOEDaNZ/bVSciYOlp0KYl/
q0O14CsRvrNgHerlkhv8yfwP7joSMtDWXGeF7n/HlnT3dOz08uLf5aQ+MHo2URTZ
6ZCimFz/qscdJiH1XYnmRRoOORTCM7m5kmMMefqLOHyiOhGQzH4FhtGJP9+oCQzJ
a17B8uHQJaQepuJBLerEESObUPvEbr6tzGxq0Hjw/uT2XP2qqX8V6ljoM3Xio3hN
tcZAshrn73QTdKJ2/B0hNxCn77+Pv/RpAUBkKMdX5nK+MIOOW0JOXpGj/VelUVLG
CGACvm6B6xVixHiV5TtKzCHVtc1T7hh6xrCZUzQkrUQ2XcmS8h7MIT5HOmU+4Kum
79343LgON6Dcs1eRei+bqCy126HB2vNX/w+2X4khVgVsPE8vVbSydWilLna9zm/c
Qv3cdelr/RHe1OW5w7RjtsJXxA1U8mf0LatdmPV6nKE4JBpCKbLRTXp7Kh0oHuR5
E1BgGxiFL03NJWWrpb1OPs0QrJDIEtMxYPwcUxQtMlaa1750+7w=
=wkKy
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
