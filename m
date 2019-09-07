Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A1AC52C
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405046AbfIGHh6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 03:37:58 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:29584 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404968AbfIGHh5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 03:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567841873;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=imBjKFWPpnQiffBQgBcoYSj19gYJyxmbsr48fIp/sx0=;
        b=tlBXOpVTiwf3WSpLAs6TSNT6at1UPG+PrWaUfJcVSPafrYeDnrAPySufymyEZsp0UV
        aHeu15H8/l/XifD81Ws1HMV2f55BBD62ZN2Bw3C6tf1sVmeGYysoUsx53aakA4zJnqhS
        pGwQwAqBFMgDNaL8+bgtyx79bpva9MmQ439+52/3mIlzrUc9DVKogBSkoK+8/Lk4lU1S
        SZpNGXDSp/GXKmFZrAqXKdW/xdIInVleN8lO+/NRGRC+4at+boga1Vdl8GqVkWrPmMnH
        AnHUp09ZvNWCTNFGesrI1gpjNuIgNOA0T9vj36dPtQvQQwxCDD5lq1gtzww0CYV4QkXs
        uc0w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDVCaXAwLbA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v877bZqbZ
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Sep 2019 09:37:35 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <0eb7129f6148faac0150d6299ac97347484c7125.1567839375.git.hns@goldelico.com>
Date:   Sat, 7 Sep 2019 09:37:35 +0200
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F12B47AA-DED2-4BD9-B144-2463A2AE6094@goldelico.com>
References: <cover.1567839375.git.hns@goldelico.com> <0eb7129f6148faac0150d6299ac97347484c7125.1567839375.git.hns@goldelico.com>
To:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Nikolaus Schaller <hns@goldelico.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 07.09.2019 um 08:56 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> This adds code and tables to read the silicon revision and
> eFuse (speed binned / 720 MHz grade) bits for selecting
> opp-v2 table entries.
>=20
> Since these bits are not always part of the syscon register
> range (like for am33xx, am43, dra7), we add code to directly
> read the register values using ioremap() if syscon access fails.
>=20
> The format of the opp-supported-hw entries is that it has
> two 32 bit bitfields. E.g.:
>=20
> 	opp-supported-hw =3D <0xffffffff 3>
>=20
> The first value is matched against the bit position of the
> silicon revision which is (see TRM)
>=20
> omap34xx:
> BIT(0)	ES1.0
> BIT(1)	ES2.0
> BIT(2)	ES2.1
> BIT(3)	ES3.0
> BIT(4)	ES3.1
> BIT(7)	ES3.1.2
>=20
> omap36xx:
> BIT(0)	ES1.0
> BIT(1)	ES1.1
> BIT(2)	ES1.2
>=20
> The second value is matched against the speed grade eFuse:
>=20
> BIT(0)	no high speed OPP
> BIT(1)	high speed OPP
>=20
> This means for the example above that it is always enabled
> while e.g.
>=20
> 	opp-supported-hw =3D <0x1 2>
>=20
> enables the OPP only for ES1.0 BIT(0) and if the high speed
> eFuse is set BIT(1).
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> drivers/cpufreq/ti-cpufreq.c | 91 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 89 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/ti-cpufreq.c =
b/drivers/cpufreq/ti-cpufreq.c
> index 2ad1ae17932d..f2f58d689320 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -31,6 +31,11 @@
> #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
> #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
>=20
> +#define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
> +#define OMAP3_CONTROL_IDCODE			0x4830A204
> +#define OMAP34xx_ProdID_SKUID			0x4830A20C
> +#define OMAP3_SYSCON_BASE	(0x48000000 + 0x2000 + 0x270)
> +
> #define VERSION_COUNT				2
>=20
> struct ti_cpufreq_data;
> @@ -84,6 +89,13 @@ static unsigned long dra7_efuse_xlate(struct =
ti_cpufreq_data *opp_data,
> 	return calculated_efuse;
> }
>=20
> +static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data =
*opp_data,
> +				      unsigned long efuse)
> +{
> +	/* OPP enable bit ("Speed Binned") */
> +	return BIT(efuse);
> +}
> +
> static struct ti_cpufreq_soc_data am3x_soc_data =3D {
> 	.efuse_xlate =3D amx3_efuse_xlate,
> 	.efuse_fallback =3D AM33XX_800M_ARM_MPU_MAX_FREQ,
> @@ -111,6 +123,56 @@ static struct ti_cpufreq_soc_data dra7_soc_data =3D=
 {
> 	.multi_regulator =3D true,
> };
>=20
> +/*
> + * OMAP35x TRM (SPRUF98K):
> + *  CONTROL_IDCODE (0x4830 A204) describes Silicon revisions.
> + *  Control OMAP Status Register 15:0 (Address 0x4800 244C)
> + *    to separate between omap3503, omap3515, omap3525, omap3530
> + *    and feature presence.
> + *    There are encodings for versions limited to 400/266MHz
> + *    but we ignore.
> + *    Not clear if this also holds for omap34xx.
> + *  some eFuse values e.g. CONTROL_FUSE_OPP1_VDD1
> + *    are stored in the SYSCON register range
> + *  Register 0x4830A20C [ProdID.SKUID] [0:3]
> + *    0x0 for normal 600/430MHz device.
> + *    0x8 for 720/520MHz device.
> + *    Not clear what omap34xx value is.
> + */
> +
> +static struct ti_cpufreq_soc_data omap34xx_soc_data =3D {
> +	.efuse_xlate =3D omap3_efuse_xlate,
> +	.efuse_offset =3D OMAP34xx_ProdID_SKUID - OMAP3_SYSCON_BASE,
> +	.efuse_shift =3D 3,
> +	.efuse_mask =3D BIT(3),
> +	.rev_offset =3D OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
> +	.multi_regulator =3D false,
> +};
> +
> +/*
> + * AM/DM37x TRM (SPRUGN4M)
> + *  CONTROL_IDCODE (0x4830 A204) describes Silicon revisions.
> + *  Control Device Status Register 15:0 (Address 0x4800 244C)
> + *    to separate between am3703, am3715, dm3725, dm3730
> + *    and feature presence.
> + *   Speed Binned =3D Bit 9
> + *     0 800/600 MHz
> + *     1 1000/800 MHz
> + *  some eFuse values e.g. CONTROL_FUSE_OPP 1G_VDD1
> + *    are stored in the SYSCON register range.
> + *  There is no 0x4830A20C [ProdID.SKUID] register (exists but
> + *    seems to always read as 0).
> + */
> +
> +static struct ti_cpufreq_soc_data omap36xx_soc_data =3D {
> +	.efuse_xlate =3D omap3_efuse_xlate,
> +	.efuse_offset =3D OMAP3_CONTROL_DEVICE_STATUS - =
OMAP3_SYSCON_BASE,
> +	.efuse_shift =3D 9,
> +	.efuse_mask =3D BIT(9),
> +	.rev_offset =3D OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
> +	.multi_regulator =3D false,
> +};
> +
> /**
>  * ti_cpufreq_get_efuse() - Parse and return efuse value present on =
SoC
>  * @opp_data: pointer to ti_cpufreq_data context
> @@ -127,7 +189,17 @@ static int ti_cpufreq_get_efuse(struct =
ti_cpufreq_data *opp_data,
>=20
> 	ret =3D regmap_read(opp_data->syscon, =
opp_data->soc_data->efuse_offset,
> 			  &efuse);
> -	if (ret) {
> +	if (ret =3D=3D -EIO) {
> +		/* not a syscon register! */
> +		void __iomem *regs =3D ioremap(OMAP3_SYSCON_BASE +
> +				opp_data->soc_data->efuse_offset, 4);
> +
> +		if (!regs)
> +			return -ENOMEM;
> +		efuse =3D readl(regs);
> +		iounmap(regs);
> +		}
> +	else if (ret) {
> 		dev_err(dev,
> 			"Failed to read the efuse value from syscon: =
%d\n",
> 			ret);
> @@ -158,7 +230,17 @@ static int ti_cpufreq_get_rev(struct =
ti_cpufreq_data *opp_data,
>=20
> 	ret =3D regmap_read(opp_data->syscon, =
opp_data->soc_data->rev_offset,
> 			  &revision);
> -	if (ret) {
> +	if (ret =3D=3D -EIO) {
> +		/* not a syscon register! */
> +		void __iomem *regs =3D ioremap(OMAP3_SYSCON_BASE +
> +				opp_data->soc_data->rev_offset, 4);
> +
> +		if (!regs)
> +			return -ENOMEM;
> +		revision =3D readl(regs);
> +		iounmap(regs);
> +		}
> +	else if (ret) {
> 		dev_err(dev,
> 			"Failed to read the revision number from syscon: =
%d\n",
> 			ret);
> @@ -190,6 +272,11 @@ static const struct of_device_id =
ti_cpufreq_of_match[] =3D {
> 	{ .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
> 	{ .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
> 	{ .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
> +	{ .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
> +	{ .compatible =3D "ti,omap36xx", .data =3D &omap36xx_soc_data, =
},
> +	/* legacy */
> +	{ .compatible =3D "ti,omap3430", .data =3D &omap34xx_soc_data, =
},
> +	{ .compatible =3D "ti,omap3630", .data =3D &omap36xx_soc_data, =
},

Well, I just realized that with the latest DTS changes,

ti,omap34xx and ti,omap36xx are legacy and
ti,omap3430 and ti,omap3630 are now official.

> 	{},
> };
>=20
> --=20
> 2.19.1
>=20

