Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB51103C2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLCRmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 12:42:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfLCRmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 12:42:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so4853890wrq.0;
        Tue, 03 Dec 2019 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qE5r3nti027mzy0pKgrnKXkE1RSc8kUqTOaORXIdEtE=;
        b=a40wQB7Mk7pBuIEzPBChXZl1yBZvbIVXlaeGoAaiJcl8DZczFfOnjnbH4qGRZ0lPoT
         sRb08dAvwJLNEP5eDKxT0YBpPq2HtoE0w0BQ5jV2bXhdv76SufUrjfF1rhgxyZLThrsp
         S9blKgXZiiYIkiuBLkMhYny1XboAMLEmBjUeD8rHJy+FiM+s8XPJ0IopkA6ylmfT1Szl
         nwXDM1qbCCzKRRN1vUDI9Ac8ntundjbrtPnLX/IosvRrhRvDfkqzMorv7i/w36fh/01e
         CeBmgwklnmeK9BfhSLVbKd+L0W/hQdVrkFJUhf0AWeQCw5G5psDNjeZ/3d/P7bsqKm4N
         6Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qE5r3nti027mzy0pKgrnKXkE1RSc8kUqTOaORXIdEtE=;
        b=d3SppsbxuINEqJKZoW2zbGSKdkicLcv/C58vSdD7lHbfIzPOFq2I2GaQ8MMpasU9JM
         0/8iKf1q9TTrBQmneSVI6Lsf3opUwbp9AY/fP6nX+bELhIW8YPJC3fLzUKzoQE+SZjYD
         y4ABX2KUgiEwXd+24GLpKubBitPIvSfDlMaoi2XN8mxmZFbmRJ7CsSoBIMm+mEs8wpWb
         YJGofW2qj0dYGX7ZFa8UJbOXnBsXuUj06Tg/udIUeQVENNo+pE8oA/PUupTwtrfdXY4U
         fUJ4TwMh3lZ6tIWw52eP/Gcac3QN7pIwMg+hA5sdI2B1VM+T2JyICX5Pk5VCC61uMTW8
         2/ag==
X-Gm-Message-State: APjAAAU8oyk/ZqkwTmVRTWTvaTwt9fonJHV7Ai781SLje1YYnRZOg3H0
        IaAFPgO1vPWgrvTHTaF8OLg=
X-Google-Smtp-Source: APXvYqyirRyu04jqDg3x30rmhKDhkCSn+pJlYnYt6qaMKeOuedWuhIFZA6+FPRXQ60evaeNBBoHQdg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr6193149wrk.53.1575394951675;
        Tue, 03 Dec 2019 09:42:31 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id x7sm4411960wrq.41.2019.12.03.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 09:42:30 -0800 (PST)
Date:   Tue, 3 Dec 2019 18:42:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20191203174229.GA1721849@ulmo>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2019 at 11:02:26PM +0530, Sumit Gupta wrote:
> Adding new function of_tegra_bpmp_get() to get BPMP data.
> This function can be used by other drivers like cpufreq to
> get BPMP data without adding any property in respective
> drivers DT node.

What's wrong with adding the property in the DT node? We already do that
for Tegra186's CPU frequency driver, so it makes sense to continue that
for Tegra194.

Thierry

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/bpmp.h      |  5 +++++
>  2 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> index 6741fcd..9c3d7f1 100644
> --- a/drivers/firmware/tegra/bpmp.c
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -38,6 +38,44 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
>  	return bpmp->soc->ops;
>  }
> =20
> +struct tegra_bpmp *of_tegra_bpmp_get(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *bpmp_dev;
> +	struct tegra_bpmp *bpmp;
> +
> +	/* Check for bpmp device status in DT */
> +	bpmp_dev =3D of_find_compatible_node(NULL, NULL, "nvidia,tegra186-bpmp"=
);
> +	if (!bpmp_dev) {
> +		bpmp =3D ERR_PTR(-ENODEV);
> +		goto err_out;
> +	}
> +	if (!of_device_is_available(bpmp_dev)) {
> +		bpmp =3D ERR_PTR(-ENODEV);
> +		goto err_put;
> +	}
> +
> +	pdev =3D of_find_device_by_node(bpmp_dev);
> +	if (!pdev) {
> +		bpmp =3D ERR_PTR(-ENODEV);
> +		goto err_put;
> +	}
> +
> +	bpmp =3D platform_get_drvdata(pdev);
> +	if (!bpmp) {
> +		bpmp =3D ERR_PTR(-EPROBE_DEFER);
> +		put_device(&pdev->dev);
> +		goto err_put;
> +	}
> +
> +	return bpmp;
> +err_put:
> +	of_node_put(bpmp_dev);
> +err_out:
> +	return bpmp;
> +}
> +EXPORT_SYMBOL_GPL(of_tegra_bpmp_get);
> +
>  struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
>  {
>  	struct platform_device *pdev;
> diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
> index f2604e9..21402d9 100644
> --- a/include/soc/tegra/bpmp.h
> +++ b/include/soc/tegra/bpmp.h
> @@ -107,6 +107,7 @@ struct tegra_bpmp_message {
>  };
> =20
>  #if IS_ENABLED(CONFIG_TEGRA_BPMP)
> +struct tegra_bpmp *of_tegra_bpmp_get(void);
>  struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
>  void tegra_bpmp_put(struct tegra_bpmp *bpmp);
>  int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
> @@ -122,6 +123,10 @@ void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, un=
signed int mrq,
>  			 void *data);
>  bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp, unsigned int m=
rq);
>  #else
> +static inline struct tegra_bpmp *of_tegra_bpmp_get(void)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
>  static inline struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
>  {
>  	return ERR_PTR(-ENOTSUPP);
> --=20
> 2.7.4
>=20

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3mnoEACgkQ3SOs138+
s6GpwBAAvaZJp87NoF1TROjbDypFZ2E7Oov0yzlV1zJak8mF3KIV0tKaCHoXheWI
rcQZm8VFfh/Gqxw63Yk1Gn9nA1KJoqaIUY1On3cMHvY2wtVF7Wh/tFI+5JNXsCIi
H9et1e5q/J9LaFHxcdNsEeYaocswM31Zy+rNIhT1bpLzvTZObIzbQp5v5eao8U6i
VUdAUsr5XSj0vcN51HVz6CHFMpQsocQV1AsACAMUny+ajHL/FTmJYa5jvXvhqgpX
yH593XBFitXrqAhWj3kR6okHC2U9UAd2S9ZXsu15xawQNymTi2mdqnaoeohRajFj
z9GF5CxNbNCNOBMxvzAkF08s8dQCA/vsSkxQ518Z3BK+dPxu7Leho9yVeNs9muy/
7fOU5sc+gIBuBB0V/fwP2xiPbvoe/wozI2LtbmDa6akd5rwxYLi3ogJOKtS1QRhN
JHaTZ08hjuRiL64s8EAfz1VsQYF0MwkfomCfXKMoTCu+8mVXkcMuZcaotXul/Mck
LMYlsKbCwgLpM4NrNW++q1nTewTXmQpzrLN762Ae23ud7ARns1mwaaGa6UvfxIhE
cxZVU66dHXKEIdGsA6uSByRKUS8/1le4Iy6zRAu7O88XAbxSydYOm45/ovZTEzAz
jAymOGgaP0NBMXICJoBLt3/Z0WwBmSAZ/Vir1cbs2jsup+XvzaE=
=c7iN
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
