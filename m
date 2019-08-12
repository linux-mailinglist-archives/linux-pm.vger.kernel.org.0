Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CDF89ADC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfHLKHM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 06:07:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfHLKHM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 06:07:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so104158710wru.0;
        Mon, 12 Aug 2019 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62GUIJaxsBr0ns4SlEavg70SWuAMSrdfYiBgGd57XwE=;
        b=koRkDpUJs8FTTEu+44bl2ey1mrNgtTjT+bTugu+eIyQg7hsNVOy5j7iOjWTJqAP8MQ
         2LqlsSn95ssNqyFoIfESU563xqDB+zB0Oh3K8FXIGJyd+4JfZ4mQWYtfIh90UaoOME1f
         o/4ZxOnvGrCE+I7z9oRMQaEyZs3Lx8iNk3yVd4QAp0f6AXu+lnPQeT2Oiom2zYDu2GR6
         o/y1zD13X49NUWXxbMAzMyTfc5eshBlMerUT1Lf7Z86/RjC++8QYBFRoINc1RyqVWj+o
         Q0uz7KoiRHoMeFBlEPVPGI46wBVUBoujXXN0UKElYyJ3vUiAt/Z6DpzVvAJ/O73dQGPi
         ofxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62GUIJaxsBr0ns4SlEavg70SWuAMSrdfYiBgGd57XwE=;
        b=Kvf3WIjBFnnMBdakTG+YPkFcQCHkqEXxk4iPkK7Yb1I1C7A/EYA5SJMGGt/PY0Hq9e
         GK1WsqHDI2Dn+3FIMqXD2sQn/KBVUbbIDbFbwtSMeTMQiVWeWoVfXIowRKojhj+BvYbr
         5p70oLGWb0XEb5L6oQ2ZlzafDfdR7kf5zbjd1bfeiILXsXfmwt9VLqlpsbBZBuhkIrIN
         S9IAotlT9ESorTEsz/6O/oGgGjlkF8loPwkaKDznpxGX8hMjh7g2sVA90RVr8O+jW+6I
         OJ5a8seRVjJlW0P4tGl51SLtTn0/KCkuwMX7M1Z1HyjdDo9uxRgxrjJwBBfDFYnqWnX/
         x3Eg==
X-Gm-Message-State: APjAAAWYE3FqP6dzIcCiL5m7c/oySiy758LX9QIakBAaiycd9oe7szKR
        1nwrBXdP7KBdJZMxieAMen0=
X-Google-Smtp-Source: APXvYqyGe3Uwpwg7TpcsDIQdq3Bc6K7fyTqjMAwH5wH1xbomsRFtWiYH1mhqegRSYkgIiRW1ibmNkg==
X-Received: by 2002:adf:f710:: with SMTP id r16mr5314208wrp.81.1565604428659;
        Mon, 12 Aug 2019 03:07:08 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id e4sm29119075wrh.39.2019.08.12.03.07.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:07:07 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:07:06 +0200
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
Subject: Re: [PATCH v8 12/21] cpufreq: tegra124: Add suspend and resume
 support
Message-ID: <20190812100706.GK8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-13-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-13-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:51PM -0700, Sowjanya Komatineni wrote:
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
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 60 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra12=
4-cpufreq.c
> index 4f0c637b3b49..e979a3370988 100644
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
> @@ -128,8 +129,67 @@ static int tegra124_cpufreq_probe(struct platform_de=
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
> +	/* disable DFLL clock */
> +	clk_disable_unprepare(priv->dfll_clk);

This comment is superfluous since it doesn't explain anything that the
code below doesn't explain already.

Not sure who will end up merging this. If not me, then this is:

Acked-by: Thierry Reding <treding@nvidia.com>

--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ROkoACgkQ3SOs138+
s6EJKQ/+I3cbYEQ/nCqI+FT9m+vu0hLSkyzx0lJlJVnxlgxIi4AJGx6Pb3bXgNy4
LEOQC2nlCzm1Lr9JeKBVpZ/AtP8axsHNXtAffRCITM3nfaXZhLCq1dhCXbf4uobC
RCS8mOavaYc3hiqjb3Kg0V7CsGJ7TbNmAiCv32yIRKt21/vFz4nR+cyEEFZqYmkc
BoCTX1+soYNwseydeRYxzCh619PxkfhENk41LrFlERSmQ7Ao4NVi1kq0FKLANmoi
eY0Z++jK0OBTn74N2txmRuzguQe5UwqC6AAgMAzB7dvBHyFLc8iOJUmrNNL8bqj7
vorJ7UK5f61JX9rEDC8Wq4i3RApb9aEyG+PiCpRTXlMbQOscpIZUnTU7P86DSfBt
OxB1ZF2VZs9m/zoGOOKBPkO6ZpPNGKjjC+W1vhNNcHbB7uKolgABRgqvIK74wUrK
ldM4+ba2hQxur5YU3Nrffaml2KORg2zBXm4YAm0DElONwx4Xtx0eQ1ymX2k9k/Dj
KMiWTNSrN+jXruhyECkO90ogxk/DIzaBkVfieIDTzKYOggXKEo/PNUAepL0Osq7q
IpQ576FFctxafQLakYMk0O89nTJnNtVkAUmdVi1BK2m0vKQclpzlE4w43UcJl3zb
MYbIcsCnKZwWz9QsUmRI76d8JLPKsPiTtFjUopToIkOhSMcVO10=
=xDLq
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
