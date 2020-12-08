Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA842D25C0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgLHIWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 03:22:42 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53545 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727559AbgLHIWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 03:22:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3A406C7F;
        Tue,  8 Dec 2020 03:21:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 08 Dec 2020 03:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cQfOkOJh+W2ncPOOtPBR29+hpuG
        wA7DnPqCP/mcp+RQ=; b=ppUo6sT1Rx4Rx33UfWWwLNyk3okKg2/lnFWxRdOdUF2
        2xXLJCn+WquhboIWP0Ws2g8DCZAMzRF1NgryUjZ857f4iHIczGNcKQ0C/58OTfYN
        CX366MJAGM3IrJ5IRl0hMX3hfi1tDRKr8DkRp0Ow2+7zu2IloMDUMRzDcaHuv1Bf
        HvaqDsvW8xlfsRc6m+HAL52pFWDYuDOUZajdFCq0vQme0g6PNfi0zHeNc4VGy6wo
        NkG4lPj4t/WkbqkN+rKCpLhGihRn+IW7nhbS0WL9N7rbirT2fkIP6bxqP9Y3Cvpt
        LYGKwsPLFNFblAMDELibYuqMa6lUmVLZNYXdKdU8NNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cQfOkO
        Jh+W2ncPOOtPBR29+hpuGwA7DnPqCP/mcp+RQ=; b=ozlgh2U7G4WaltBwvAXILY
        ZIkCkmEPSFWgw+KQZ/BQlDb1Bg0MDPkntOgNmeOBCF8YC87kjK7nAYG49EKdNt4g
        wu4T8zcu6GxQbxum8U9m3GeoxuuDnOtGAINGOvbKO6e3Rc4P11ShXE//FV9tthPB
        1QTX0KMqUPzTKxRYwKeh2QcmThNsOqitx8PbHO8q0w6IV9fklqdFHNhVhu3khSxS
        yw7nfqO2iPnXdEkw6+Ec6f2efq3Oot7LDI44XK/u0p7y6zx0k1StMKwt89gufLES
        b3VE+7TPbaJNtwPE62csy2fXOVpLgQtrkvpO0KIL6A2vhX/Z9rZ9PJ07gRND0YiA
        ==
X-ME-Sender: <xms:oDfPXxj7ptTx-0CKlksl-E2vA90RfaBEAZIUAlYKpUnLpJfpUFjHxA>
    <xme:oDfPX2CVxiKGyCwI6qpYmv_znYPhYsKjiM7b-40kAPYcmAszGapujZueVd_Gtnrq9
    h_iJKfuHvGrEMdB2WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:oDfPXxEyoiQu2tRusAHZijWb4mUejwKvMivetcLQPajmDU0NH6FvIA>
    <xmx:oDfPX2QDmnyx62zRzI8aAhCLrANFeirgZy6HXWPliUvbC03rESQGLA>
    <xmx:oDfPX-wNE4F7nhHkHezYX5XLn06SlLuhoz-QMbAMyD2nCI-6KlLWIQ>
    <xmx:ojfPX5w3gAOXWyA8qunCmTkvTz2300syak36nxHr8I1tNsuZTrP18Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 513081080057;
        Tue,  8 Dec 2020 03:21:52 -0500 (EST)
Date:   Tue, 8 Dec 2020 09:21:50 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        wens@csie.org, jernej.skrabec@siol.net, samuel@sholland.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cpufreq: sun50i: add efuse_xlate to get efuse
 version.
Message-ID: <20201208082150.jbpdlpcghbj3liqj@gilmour>
References: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lez4floknnnll5q5"
Content-Disposition: inline
In-Reply-To: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lez4floknnnll5q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 08, 2020 at 03:19:28PM +0800, Shuosheng Huang wrote:
> It's better to use efuse_xlate to extract the differentiated part
> regarding different SoC.
>=20
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>

Please wait a bit for reviews before sending a new version. You've sent
three versions in a day, and I haven't reviewed the first one.

Also, please put a changelog in the cover letter, we don't have any way
to tell what is the difference between v1, v2, v3 and v4.

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 82 ++++++++++++++++----------
>  1 file changed, 51 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun=
50i-cpufreq-nvmem.c
> index 9907a165135b..3c0531938d1a 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -19,24 +19,51 @@
> =20
>  #define MAX_NAME_LEN	7
> =20
> -#define NVMEM_MASK	0x7
> -#define NVMEM_SHIFT	5
> +#define SUN50I_H6_NVMEM_MASK		0x7
> +#define SUN50I_H6_NVMEM_SHIFT		5
> +
> +struct sunxi_cpufreq_soc_data {
> +	int (*efuse_xlate)(struct nvmem_cell *speedbin_nvmem);
> +};
> =20
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
> =20
> +static int sun50i_h6_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
> +{
> +	size_t len;
> +	u32 *speedbin;
> +	u32 efuse_value;
> +
> +	speedbin =3D nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	efuse_value =3D (*(u32 *)speedbin >> SUN50I_H6_NVMEM_SHIFT) &
> +			  SUN50I_H6_NVMEM_MASK;
> +	kfree(speedbin);
> +	/*
> +	 * We treat unexpected efuse values as if the SoC was from
> +	 * the slowest bin. Expected efuse values are 1-3, slowest
> +	 * to fastest.
> +	 */
> +	if (efuse_value >=3D 1 && efuse_value <=3D 3)
> +		return efuse_value - 1;
> +	else
> +		return 0;
> +}
> +
>  /**
>   * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
> - * @versions: Set to the value parsed from efuse
> + * @soc_data: pointer to sunxi_cpufreq_soc_data context
>   *
>   * Returns 0 if success.
>   */
> -static int sun50i_cpufreq_get_efuse(u32 *versions)
> +static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data =
*soc_data)
>  {
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> -	size_t len;
> +	int versions;
>  	int ret;
> =20
>  	cpu_dev =3D get_cpu_device(0);
> @@ -63,43 +90,33 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  		return PTR_ERR(speedbin_nvmem);
>  	}
> =20
> -	speedbin =3D nvmem_cell_read(speedbin_nvmem, &len);
> +	versions =3D soc_data->efuse_xlate(speedbin_nvmem);
>  	nvmem_cell_put(speedbin_nvmem);
> -	if (IS_ERR(speedbin))
> -		return PTR_ERR(speedbin);
> -
> -	efuse_value =3D (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> -
> -	/*
> -	 * We treat unexpected efuse values as if the SoC was from
> -	 * the slowest bin. Expected efuse values are 1-3, slowest
> -	 * to fastest.
> -	 */
> -	if (efuse_value >=3D 1 && efuse_value <=3D 3)
> -		*versions =3D efuse_value - 1;
> -	else
> -		*versions =3D 0;
> =20
> -	kfree(speedbin);
> -	return 0;
> +	return versions;
>  };
> =20
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
>  	struct opp_table **opp_tables;
>  	char name[MAX_NAME_LEN];
>  	unsigned int cpu;
> -	u32 speed =3D 0;
> +	int speed =3D 0;
>  	int ret;
> =20
> +	match =3D dev_get_platdata(&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +
>  	opp_tables =3D kcalloc(num_possible_cpus(), sizeof(*opp_tables),
>  			     GFP_KERNEL);
>  	if (!opp_tables)
>  		return -ENOMEM;
> =20
> -	ret =3D sun50i_cpufreq_get_efuse(&speed);
> -	if (ret)
> -		return ret;
> +	speed =3D sun50i_cpufreq_get_efuse(match->data);
> +	if (speed < 0)
> +		return speed;
> =20
>  	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> =20
> @@ -163,8 +180,12 @@ static struct platform_driver sun50i_cpufreq_driver =
=3D {
>  	},
>  };
> =20
> +static const struct sunxi_cpufreq_soc_data sun50i_h6_data =3D {
> +	.efuse_xlate =3D sun50i_h6_efuse_xlate,
> +};
> +
>  static const struct of_device_id sun50i_cpufreq_match_list[] =3D {
> -	{ .compatible =3D "allwinner,sun50i-h6" },
> +	{ .compatible =3D "allwinner,sun50i-h6", .data =3D &sun50i_h6_data },
>  	{}
>  };
> =20
> @@ -198,9 +219,8 @@ static int __init sun50i_cpufreq_init(void)
>  	if (unlikely(ret < 0))
>  		return ret;
> =20
> -	sun50i_cpufreq_pdev =3D
> -		platform_device_register_simple("sun50i-cpufreq-nvmem",
> -						-1, NULL, 0);
> +	sun50i_cpufreq_pdev =3D platform_device_register_data(NULL,
> +		"sun50i-cpufreq-nvmem", -1, match, sizeof(*match));

The alignment here raises a checkpatch warning with --strict

Maxime

--lez4floknnnll5q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX883ngAKCRDj7w1vZxhR
xbJHAQDmcSqlridLyB0SRGolBHcXCe9dPTSgLj/2rXPbLbyqyQEAgHhkTPY5DzP/
wV7FUsm6Syw1GB66TNsQH/8ty3fyEgc=
=x4Ax
-----END PGP SIGNATURE-----

--lez4floknnnll5q5--
