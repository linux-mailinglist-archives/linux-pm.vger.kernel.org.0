Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770AB639FDC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 03:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiK1C7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 21:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiK1C7E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 21:59:04 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB11767B;
        Sun, 27 Nov 2022 18:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEZnTCGgeX2uZpu0wzjphSIYPxD7BbBlzeGTThxTGT4YKYasKd7L1qDhRIqek6DBT/GKLEB9C631TW2MrJ0RCftB3acvgsCXnKkHSADNm4Bep28i4eC5mv0xhwg7oCuVwJyajf2oyLOn0O/qAm61YAbT1Ocpkp5IjrUL8DfySszXoZ36oJmpQJtzRL/AEQuG+klZzGfdmnYLAZTg1bZOo49JILcvfKXSm1wUfDIQ1fhHqZCLNYneNYafKfqaVS36m2ZwiJewgCkrDT+mEwnqKzskVG2rEozIDtTz40iC+ENJBtu9KRKyv4WuguuGuF60LECpvUgBgjwqBHVgxYOJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7GlVdLtf3f4Nj7jHevGh3aJaA9jT+mEvw9hMyD2NwY=;
 b=KdLCeW1L/tBb7JFthyy/+QC0gRtRMQ4T2L14ibi9h2RmqPJqeacySQrFWxBT/zUIAcZ5+ALUhmF7ZT/z3JQHSTUmCF5fb2gjV5QD8onek8ycaoAG1a9d/olKA8+jQQouNzrZkalzOgYgha97eOgbQLpd4F2aAl6a1724b5J0PCT6Z+cJ0dnuRu5KneXAplb51bY4g2k0L2qFLWzAQglQE8sUqC2Wh3NF8BdwxCwKvGv2ZIyuYENnkuJ5XcGFBDtynPcBWTNhYBulH4h2OGu/oRVMeIJTgtZr4l5/OMKrSyyVB3TTv0KF4idPmLvqygqT2lphl7ojPlS6rrEk+RmGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7GlVdLtf3f4Nj7jHevGh3aJaA9jT+mEvw9hMyD2NwY=;
 b=EWAM8BdMWJxRBHgygDsZI/zYGANcwmLLxbdHoNTOAPP1w6uXRv7nVyYjZHi8O8l45fIY9Cng3Hky6avqwx60ZqY/4SIJnXRGPdFC/TYpYCZfKD0xjom/atVtupJetvdAcypsERVD9xxXpTLR5KUqm22vRNYAoGtaefjquw/f0u4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6849.eurprd04.prod.outlook.com (2603:10a6:208:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 02:58:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 02:58:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jun Li <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 5/5] thermal/drivers/imx: Add support for loading
 calibration data from OCOTP
Thread-Topic: [PATCH 5/5] thermal/drivers/imx: Add support for loading
 calibration data from OCOTP
Thread-Index: AQHZAekqquDqS8aFaE2DLjAd1Toona5TpsNw
Date:   Mon, 28 Nov 2022 02:58:59 +0000
Message-ID: <DU0PR04MB941716B691295815DDCA8BA788139@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221126224740.311625-1-marex@denx.de>
 <20221126224740.311625-5-marex@denx.de>
In-Reply-To: <20221126224740.311625-5-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6849:EE_
x-ms-office365-filtering-correlation-id: fe53a7d6-3831-4786-9a52-08dad0ec7f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HliYGDt9uL/LWJ20WmngyE8MyFyzNUD64GD5Ylba1jLh+Cfgt3Vh8ndj+xSuu6zZGCvHxBQ/7zLDuuydTsQXTpzguh10eoZkDrmosvt3Ulab75iqWf3bEBh0vN/7T2A1LxJ8VvaPrBqP/GltDoxMdTcDYmbDf/n6DkDX0knJKFsoYIr9ICPho9iGY5IjLKpPXD9p3+/luuv72YkBx1LIGPdjZFBQ4C4Ur3IkRp3OWfEm3w2IA+j8Bb/O/g3Var+3ceHtiS7AC7hGrSc0s6c+1RFTVI2mcYJiM4MnS9g4+PbQNCqHrt4K8N4QrxLRJBpD1gdqjU2OT/HTBQINDMDW6SyVmFmdNsDw4oxPV5uf+IGRqbQXv+uw/gOdQ7nynEsAUYJwaULouQeQhBIhEwvqqzvQ71rG8NPbt27C4cYrNcxovnqWHvadad8vbu71+EJ+hmnxFCWvguxv6yUGSk1Quke4uo35n7IQd6+mWerGiVzn/cMTTVZOpppzql02VgRPcyEoa2dFdm5dOdgUV5cD72HzS0eolIaZKUksnEYgnih0OEAuROatq4Z4zltas0w1eoR4J+WrP/v8syC442bDQP3keurCmHM+9bQlvRCaScKeCc0/8zYO4O4PwMjs4DnyHt+SbShveiChmB10gkuoChcPzDVPDst7uRSvap5K4wUA7aUXpgI6SFBM6SheZK9RK0ioBxPgfe952w/7oPPgOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(478600001)(316002)(2906002)(76116006)(66946007)(33656002)(110136005)(54906003)(71200400001)(83380400001)(122000001)(38100700002)(55016003)(26005)(6506007)(7696005)(86362001)(9686003)(186003)(38070700005)(5660300002)(7416002)(44832011)(52536014)(41300700001)(8936002)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GX24pahVIBm3mDY3oQbm6/NqtOQ+CBwRRjh9lVso/r/x7Q/kIhFMVFbRsPKL?=
 =?us-ascii?Q?zQMuPW1zOGrqpVSoDsj0ikX02ZYubfdCWolKWuKC92AMh4Kf9RYIgOw5yyzy?=
 =?us-ascii?Q?q/wwaRSoZlt718t3DipOoAPv1q2xga33QTE22CiAmJyNVVzEVu2C5YDJNYhY?=
 =?us-ascii?Q?bBXzJ91hcT1dq78HGI/xLKJCdMJhMWk4QxYgG4gu7PxjYIQANVx8ZpoR6FcE?=
 =?us-ascii?Q?+HbaQX92eXIf5lw999lVuFAT99cGZtL43bKqH4TS74Q4aWbGW/L9Kv3QPw3q?=
 =?us-ascii?Q?kG2s1HND5DOETY/kT8xZRiW/koq01p1J74znBq9RXiJNmAozvIB9zlxOp7Ec?=
 =?us-ascii?Q?q2lTa/KVjMwCXvmoFPwCt0fBMAHSFl3hWxSIZieVzeF/Iiz0TdgjZ/Iizbwm?=
 =?us-ascii?Q?LT+rZGdQilMNpG9Z2celYMDgmrYg3IT20QSHtzS+/q1tlzEIoemAbCF7JVM8?=
 =?us-ascii?Q?J6zcXxxUkZ4/7zYilEhDSIYMvUsAwH9lSjV60PDrBUjXTJcvV/Ol5Zl4cD1t?=
 =?us-ascii?Q?tyFOHVB1JImrw1nmpsNkCmEnvKbHZSQfAo06VRel91NLrc8/2xhI7FSWhtEj?=
 =?us-ascii?Q?YetBNBYLzmfk2C2f7MmkJzqo0PF97ySVeIGwFb5U3JuaLxs4b7n4vwAYGtjc?=
 =?us-ascii?Q?YACo7Fo7zyRYiHXWAvMGGlZSfe9n7OmVqOlKTiCJTrVhSA/psAyuNZkBn3Mt?=
 =?us-ascii?Q?WHIY6ZLlM3+mdDzEroqQGI4bokWLknFT5cN/nhNdvpDoNTfRz+yNOjzESAvB?=
 =?us-ascii?Q?IRtjsLv6zJKBCgLpqM/c6QZxQ5Vxd09T1a89sJFHCIsd6+4IUcmo+LwfK8xH?=
 =?us-ascii?Q?TRYFgGphUSPs+gzpc16rKKX0rIzEczwyczdVYjsTk6ORxQxwmsSDljKsBMd9?=
 =?us-ascii?Q?/6n/Bh+0Gs1M+5qcaPuKwt7ktMtmy4buov/70E9rKcWi//VQMfG6oTr/3ceg?=
 =?us-ascii?Q?1Ah/6/h6j1aISTO3g+r235jxK1CVIC3sg3rqyl66uOi3hBCPFPf8HBLAxxBr?=
 =?us-ascii?Q?P0ircxFEa/dYn2/h1Fh1zNHqAyBcjZoCsIKS3V3AFxi6GsDtaG46A4lPRg8R?=
 =?us-ascii?Q?VI0OfXixgrU/swZHRPfKSN3se7EXRNMPBbWK7BFTic27gycKPr4KFvUJ3A0G?=
 =?us-ascii?Q?/3hP1G9df17EUqYZ/u2/BmnoH0TwUZQjSmazvSkSJzOcetDsroybszzOwbNk?=
 =?us-ascii?Q?HESJ2cN9rt8S9LUo+9zF8qQIpJFUNBR/s/WukPFltVKymIulKwMT1ns8BuPB?=
 =?us-ascii?Q?2B539ZtPC10iX2IixLJnmCXqNyMyVseNK1mAvkK8kh/f0wl4eSDF/0+rBPKQ?=
 =?us-ascii?Q?lpY94gmSlJ6Ijv2Smrv7DSHast6GbzZ36rUAYISxIX34arS4gdNinveeJTpZ?=
 =?us-ascii?Q?OtVtgnm/mTHnPc2pHO1JJVTYQFomLZfQvRfAKt0dLW5EODtPQFZikHcM/G6M?=
 =?us-ascii?Q?U9u5e7cTB5hd/+OYVFAFmrfH7GieZsEdlqKs3i5X4fnzxbRMQ31XgaHx5mWQ?=
 =?us-ascii?Q?ujIQc0RL5qaM5dI5COe7utfM6QQMKAa4SFehLae66rjQBt+5h8uVUi4nvNaI?=
 =?us-ascii?Q?njzfEA7E9ybhbnSg+48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe53a7d6-3831-4786-9a52-08dad0ec7f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:58:59.4823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJeyjhT4MXKBuN0XKSta7eCt1IibjbD9F+mw6j9wYFnN3M58jt1+Lx5YU9KySItpsjbZu5nmjbaOYaifAyDnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: [PATCH 5/5] thermal/drivers/imx: Add support for loading calibra=
tion
> data from OCOTP
>=20
> The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
> calibration values in OCOTP. Add support for reading the OCOTP calibratio=
n
> data and programming those into the TMU hardware.
>=20
> The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2
> uses 4, the programming differs in each case.
>=20
> Based on U-Boot commits:
> 70487ff386c ("imx8mm: Load fuse for TMU TCALIV and TASR") ebb9aab318b
> ("imx: load calibration parameters from fuse for i.MX8MP")
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Looks good to me

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Li Jun <jun.li@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: devicetree@vger.kernel.org
> To: linux-pm@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/thermal/imx8mm_thermal.c | 163
> +++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>=20
> diff --git a/drivers/thermal/imx8mm_thermal.c
> b/drivers/thermal/imx8mm_thermal.c
> index e2c2673025a7a..da09c00ac663a 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -20,6 +21,22 @@
>  #define TER			0x0	/* TMU enable */
>  #define TPS			0x4
>  #define TRITSR			0x20	/* TMU immediate temp */
> +/* TMU calibration data registers */
> +#define TASR			0x28
> +#define TASR_BUF_SLOPE_MASK	GENMASK(19, 16)
> +#define TASR_BUF_VREF_MASK	GENMASK(4, 0)	/* TMU_V1 */
> +#define TASR_BUF_VERF_SEL_MASK	GENMASK(1, 0)	/* TMU_V2 */
> +#define TCALIV(n)		(0x30 + ((n) * 4))
> +#define TCALIV_EN		BIT(31)
> +#define TCALIV_HR_MASK		GENMASK(23, 16)	/* TMU_V1
> */
> +#define TCALIV_RT_MASK		GENMASK(7, 0)	/* TMU_V1 */
> +#define TCALIV_SNSR105C_MASK	GENMASK(27, 16)	/* TMU_V2
> */
> +#define TCALIV_SNSR25C_MASK	GENMASK(11, 0)	/* TMU_V2
> */
> +#define TRIM			0x3c
> +#define TRIM_BJT_CUR_MASK	GENMASK(23, 20)
> +#define TRIM_BGR_MASK		GENMASK(31, 28)
> +#define TRIM_VLSB_MASK		GENMASK(15, 12)
> +#define TRIM_EN_CH		BIT(7)
>=20
>  #define TER_ADC_PD		BIT(30)
>  #define TER_EN			BIT(31)
> @@ -32,6 +49,25 @@
>  #define SIGN_BIT		BIT(7)
>  #define TEMP_VAL_MASK		GENMASK(6, 0)
>=20
> +/* TMU OCOTP calibration data bitfields */
> +#define ANA0_EN			BIT(25)
> +#define ANA0_BUF_VREF_MASK	GENMASK(24, 20)
> +#define ANA0_BUF_SLOPE_MASK	GENMASK(19, 16)
> +#define ANA0_HR_MASK		GENMASK(15, 8)
> +#define ANA0_RT_MASK		GENMASK(7, 0)
> +#define TRIM2_VLSB_MASK		GENMASK(23, 20)
> +#define TRIM2_BGR_MASK		GENMASK(19, 16)
> +#define TRIM2_BJT_CUR_MASK	GENMASK(15, 12)
> +#define TRIM2_BUF_SLOP_SEL_MASK	GENMASK(11, 8)
> +#define TRIM2_BUF_VERF_SEL_MASK	GENMASK(7, 6)
> +#define TRIM3_TCA25_0_LSB_MASK	GENMASK(31, 28)
> +#define TRIM3_TCA40_0_MASK	GENMASK(27, 16)
> +#define TRIM4_TCA40_1_MASK	GENMASK(31, 20)
> +#define TRIM4_TCA105_0_MASK	GENMASK(19, 8)
> +#define TRIM4_TCA25_0_MSB_MASK	GENMASK(7, 0)
> +#define TRIM5_TCA105_1_MASK	GENMASK(23, 12)
> +#define TRIM5_TCA25_1_MASK	GENMASK(11, 0)
> +
>  #define VER1_TEMP_LOW_LIMIT	10000
>  #define VER2_TEMP_LOW_LIMIT	-40000
>  #define VER2_TEMP_HIGH_LIMIT	125000
> @@ -128,6 +164,129 @@ static void imx8mm_tmu_probe_sel_all(struct
> imx8mm_tmu *tmu)
>  	writel_relaxed(val, tmu->base + TPS);
>  }
>=20
> +static int imx8mm_tmu_probe_set_calib_v1(struct platform_device *pdev,
> +					 struct imx8mm_tmu *tmu)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	u32 ana0;
> +	int ret;
> +
> +	ret =3D nvmem_cell_read_u32(&pdev->dev, "calib", &ana0);
> +	if (ret) {
> +		dev_warn(dev, "Failed to read OCOTP nvmem cell (%d).\n",
> ret);
> +		return ret;
> +	}
> +
> +	writel(FIELD_PREP(TASR_BUF_VREF_MASK,
> +			  FIELD_GET(ANA0_BUF_VREF_MASK, ana0)) |
> +	       FIELD_PREP(TASR_BUF_SLOPE_MASK,
> +			  FIELD_GET(ANA0_BUF_SLOPE_MASK, ana0)),
> +	       tmu->base + TASR);
> +
> +	writel(FIELD_PREP(TCALIV_RT_MASK, FIELD_GET(ANA0_RT_MASK,
> ana0)) |
> +	       FIELD_PREP(TCALIV_HR_MASK, FIELD_GET(ANA0_HR_MASK, ana0))
> |
> +	       ((ana0 & ANA0_EN) ? TCALIV_EN : 0),
> +	       tmu->base + TCALIV(0));
> +
> +	return 0;
> +}
> +
> +static int imx8mm_tmu_probe_set_calib_v2(struct platform_device *pdev,
> +					 struct imx8mm_tmu *tmu)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct nvmem_cell *cell;
> +	u32 trim[4] =3D { 0 };
> +	size_t len;
> +	void *buf;
> +
> +	cell =3D nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf =3D nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	memcpy(trim, buf, min(len, sizeof(trim)));
> +	kfree(buf);
> +
> +	if (len !=3D 16) {
> +		dev_err(dev,
> +			"OCOTP nvmem cell length is %ld, must be 16.\n", len);
> +		return -EINVAL;
> +	}
> +
> +	/* Blank sample hardware */
> +	if (!trim[0] && !trim[1] && !trim[2] && !trim[3]) {
> +		/* Use a default 25C binary codes */
> +		writel(FIELD_PREP(TCALIV_SNSR25C_MASK, 0x63c),
> +		       tmu->base + TCALIV(0));
> +		writel(FIELD_PREP(TCALIV_SNSR25C_MASK, 0x63c),
> +		       tmu->base + TCALIV(1));
> +		return 0;
> +	}
> +
> +	writel(FIELD_PREP(TASR_BUF_VERF_SEL_MASK,
> +			  FIELD_GET(TRIM2_BUF_VERF_SEL_MASK, trim[0])) |
> +	       FIELD_PREP(TASR_BUF_SLOPE_MASK,
> +			  FIELD_GET(TRIM2_BUF_SLOP_SEL_MASK, trim[0])),
> +	       tmu->base + TASR);
> +
> +	writel(FIELD_PREP(TRIM_BJT_CUR_MASK,
> +			  FIELD_GET(TRIM2_BJT_CUR_MASK, trim[0])) |
> +	       FIELD_PREP(TRIM_BGR_MASK, FIELD_GET(TRIM2_BGR_MASK,
> trim[0])) |
> +	       FIELD_PREP(TRIM_VLSB_MASK, FIELD_GET(TRIM2_VLSB_MASK,
> trim[0])) |
> +	       TRIM_EN_CH,
> +	       tmu->base + TRIM);
> +
> +	writel(FIELD_PREP(TCALIV_SNSR25C_MASK,
> +			  FIELD_GET(TRIM3_TCA25_0_LSB_MASK, trim[1]) |
> +			  (FIELD_GET(TRIM4_TCA25_0_MSB_MASK, trim[2]) <<
> 4)) |
> +	       FIELD_PREP(TCALIV_SNSR105C_MASK,
> +			  FIELD_GET(TRIM4_TCA105_0_MASK, trim[2])),
> +	       tmu->base + TCALIV(0));
> +
> +	writel(FIELD_PREP(TCALIV_SNSR25C_MASK,
> +			  FIELD_GET(TRIM5_TCA25_1_MASK, trim[3])) |
> +	       FIELD_PREP(TCALIV_SNSR105C_MASK,
> +			  FIELD_GET(TRIM5_TCA105_1_MASK, trim[3])),
> +	       tmu->base + TCALIV(1));
> +
> +	writel(FIELD_PREP(TCALIV_SNSR25C_MASK,
> +			  FIELD_GET(TRIM3_TCA40_0_MASK, trim[1])) |
> +	       FIELD_PREP(TCALIV_SNSR105C_MASK,
> +			  FIELD_GET(TRIM4_TCA40_1_MASK, trim[2])),
> +	       tmu->base + TCALIV(2));
> +
> +	return 0;
> +}
> +
> +static int imx8mm_tmu_probe_set_calib(struct platform_device *pdev,
> +				      struct imx8mm_tmu *tmu)
> +{
> +	struct device *dev =3D &pdev->dev;
> +
> +	/*
> +	 * Lack of calibration data OCOTP reference is not considered
> +	 * fatal to retain compatibility with old DTs. It is however
> +	 * strongly recommended to update such old DTs to get correct
> +	 * temperature compensation values for each SoC.
> +	 */
> +	if (!of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
> +		dev_warn(dev,
> +			 "No OCOTP nvmem reference found, SoC-specific
> calibration not loaded. Please update your DT.\n");
> +		return 0;
> +	}
> +
> +	if (tmu->socdata->version =3D=3D TMU_VER1)
> +		return imx8mm_tmu_probe_set_calib_v1(pdev, tmu);
> +
> +	return imx8mm_tmu_probe_set_calib_v2(pdev, tmu); }
> +
>  static int imx8mm_tmu_probe(struct platform_device *pdev)  {
>  	const struct thermal_soc_data *data;
> @@ -180,6 +339,10 @@ static int imx8mm_tmu_probe(struct platform_device
> *pdev)
>=20
>  	platform_set_drvdata(pdev, tmu);
>=20
> +	ret =3D imx8mm_tmu_probe_set_calib(pdev, tmu);
> +	if (ret)
> +		goto disable_clk;
> +
>  	/* enable all the probes for V2 TMU */
>  	if (tmu->socdata->version =3D=3D TMU_VER2)
>  		imx8mm_tmu_probe_sel_all(tmu);
> --
> 2.35.1

