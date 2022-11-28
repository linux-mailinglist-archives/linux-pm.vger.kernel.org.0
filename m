Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CF4639F5E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 03:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiK1CQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 21:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK1CQ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 21:16:27 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32636FE7;
        Sun, 27 Nov 2022 18:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvTZcSB/aLasvC5/eqYKTui4eGNtSkw+Bz6vAw7oJfqs7cZPUKkVDtUccdEg+azY6G3aYC8oCTQVROZMQVukuU5UWlFVlUv540JObIxDjn9I5189LxNkTipv60WA3zrSPPYnmrhFIFd1MTFebwPcgqDS67gOXtm2V0fgU8l0JyeXxZ8ipNQ4R1xH0c7ism1Jh7cPE8rHElEH27JC2WBwwZZ/2q/PCbxCwpi2NNUn62NZTkHaR0J6i3zviscPU+YEACKUBO4ymssLPlcLlZHSsvMFON8xphgyfyOK6htWybJfZdw8n73NO78USLrsQZd2o6De6s0d3YtJ737SgWNujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8N2ZmrUtzg/b305uiO4t1hFBq9AUNlYsQg5dteJIZw=;
 b=Wh4Bo4nztkDD6CTU85hQA9aji0U6nTaE4TMnoHw+FLkFtPxKqCwHoPu00U5zmMLMOPdAbmDKmEnu7ByFAFi40pA+EC/I833SON0c5u2R19HQXsP14nIa5TMkGEOzBDl+Berh85M2TP7icDO1+J4PocmioK6MgJviY1fZ4uDiF1iIbmJVNZwEr92ccIK+VeLDoHDzxNSILXcUTSQihlmMrzPy02yR7TRysh0u3IxlUrwiW1DIYx2qWZhKLy5ZYH32UdCphwXGqHrXWmxJd6LR46ihzCWdtpoyJo0dfJg1eNgRCsJowIwNH4tPtKexmmUHgygwFqwytDmTJQsiApFxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8N2ZmrUtzg/b305uiO4t1hFBq9AUNlYsQg5dteJIZw=;
 b=A7CKBg2fILTb7eatagdVEOnUvLPowlaWcvjwmPNoYyyJ1fjgxvvF+iq2e4tUyoW3IMZBL7aiv5mo+Xp5DMYVXr/8cngPRIZG4DkASR54CJldOyn7OZcKxKAW0bz2sgyWsE7kH8/6z0B6e5whnueJaxiOwA92FmKRb9pYeg7Eh2Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 02:16:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 02:16:23 +0000
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
Subject: RE: [PATCH 2/5] arm64: dts: imx8m: Align SoC unique ID node unit
 address
Thread-Topic: [PATCH 2/5] arm64: dts: imx8m: Align SoC unique ID node unit
 address
Thread-Index: AQHZAeknIEzhA3fWEk+nOCu0aBi4Za5TmuCA
Date:   Mon, 28 Nov 2022 02:16:23 +0000
Message-ID: <DU0PR04MB941773722478FFF6E611CF0288139@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221126224740.311625-1-marex@denx.de>
 <20221126224740.311625-2-marex@denx.de>
In-Reply-To: <20221126224740.311625-2-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6975:EE_
x-ms-office365-filtering-correlation-id: 3b177e16-1821-4674-22e8-08dad0e68bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZkIukFiwyrhsuYgJfRJIYIGR0I7tZIHlEcmes6iwGjFO05jMbxZweWHgwooj+KLq6S6QYSfoO3cMasFPw/txK+ltRYklclaZnXWMDCq31BOwNPKxVMyEI2HVaT+pkzuhT/0+VIQZeGBncesMDaga3kfQiSRiGzpcpnifavLFXia9JKc5S3AlfJ46kgVnSuhtCuWjTxlHbyNyejNXlP/D4Lg0vEyzuL5kFms+MSU9uPjgHNb9B9pY1osZO4lVgleo3PkRdGX4U9Jew43bTF/mOOGICUj89qeUVzOxE+p4ho2IO4EtGE55OLpLmjOo+LG1o9X+C6LaOiOniPYo+sk5A/XQBmCpd/2sxl9OmSMAdeKkdpNPrl19qDpslRuDcB7mgWvyFebNSmQ7PXygkpI26TzLGE0tIUqwy4OmIkniTllzEBDItxGY40UcnVPW3SKqKg0lmefACtRYvun3BD+E46F/NhbHTa/Tski5hGxPIlg9SU9E0iMk3i4cKY2AxLmLWfBBfO3RWfY5e1S9q/QgFVgCuWtNUX7KHS+/eFVlKwyLn3DzOX0z4daa9hF0yo2ZMITgNQylpVW52j642L/jWRUkYd3GJiIwtYH8IgNQhGMxHqMcuyykst9fKed1vd9z6kH0u5l9szuIN1hPZw57HqJRJ+YkkATOVfyu3Mez02a7ioKB5lTUmzYWMlj3SZB4J3/aeCQXwgLJrMq/p376b9UTok8J5sIFxJ9bcYL9P4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39850400004)(396003)(376002)(366004)(451199015)(2906002)(44832011)(41300700001)(54906003)(4326008)(66446008)(8676002)(66946007)(66556008)(64756008)(66476007)(316002)(110136005)(52536014)(8936002)(76116006)(33656002)(71200400001)(5660300002)(26005)(86362001)(478600001)(9686003)(7416002)(6506007)(7696005)(186003)(38100700002)(83380400001)(55016003)(122000001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QT0b4YXyhSnVxOrpIxDsEjV7DYIW/RN1d6/XDVOKcgXi0JSbbXkUUejZEu/F?=
 =?us-ascii?Q?+WLv96MCG5q6+cW8KFZNJIInSWu/4ETEifx2dCogB3d+NusVxAm04OKzaGK5?=
 =?us-ascii?Q?HWOjs/pqR6kjOMcs1jug/NlkUufA+naxL47n2MNK8t1ej6+CLD5DmCMDKZRP?=
 =?us-ascii?Q?2rr5DUzfvMbObtUImk4bGVilHhr4ZNgUtaYhQmDL4MFm1TsAlOLAlzz2QguX?=
 =?us-ascii?Q?fZQBqBgHQ5oqHZtv3uG/FHQwKlFF80LU2Gf6xciGQV+kNRk2XaZ1ZoqU3488?=
 =?us-ascii?Q?ae+wDVJfeDHXrJPc12ErGMM599BpuLFB8xTQVvCYKL3FFA7zDuUASWZ84LHW?=
 =?us-ascii?Q?ygeHTYGDw7tU3HcZNgfF1jOqX4byjjwUgv+CVULlTil+z3xv6N0lp6DsQ32S?=
 =?us-ascii?Q?c1S/MxBePLu2Og45DRh83XhyFAZJTepY1Zxtje8+CCDjOlncrJxHDqZHXYYg?=
 =?us-ascii?Q?OrnEqFA5GKPUk/VtOKU8WzxTyEYgxXc8yh4tpnHYl2E2YIcDLHLejcLI8vwn?=
 =?us-ascii?Q?whtz2wO7exu0ZJbAR3/9FSBod/w4BUPGriKxVVr1n0LCeUN6VuRL+gSEf0ha?=
 =?us-ascii?Q?E1gveCCUcAn/acufqFzG+YljXJ+SN6M7lAp6XHMwuZ8ECYSDRKmFrMgpvbdn?=
 =?us-ascii?Q?NIu6ENlOPDWBtgL1WpioECeQ8vqXB3FR+XhFMtOQxWnSKGxa6KuHYHNM+16H?=
 =?us-ascii?Q?Q7xO2DdwvNmKPFXWHyK7dF9ZF2n89oXOHxthGjgY5nIErroF5nSuQMvmqFto?=
 =?us-ascii?Q?Z8YfU7UG1dZo42J6bJQ8IORfNe+sCwK5XZo5NEJ/GcEK1T7LGFbArIoZh12b?=
 =?us-ascii?Q?uo1NInjtc+Oovm8DqT7o18ulw0ke9fwh8LFgZd+MWCAIl6kwod9mO9PNG8Zb?=
 =?us-ascii?Q?kx6XngkuGgVnyd9rMpSYBix/WYl95V064Dj2HHMoqSppJdJEOIc8F9wqnQxA?=
 =?us-ascii?Q?ybk2ldhicBSKRbfRBvGx1CUynzQ99qCOszeUBONlOjNlCy39OUbvbX1f3okZ?=
 =?us-ascii?Q?tALFrih1RQXNXBkCxxjEGus4C4IKaahBRng68rKxEsMbVl9mtS+Ss2i0OfCt?=
 =?us-ascii?Q?/axRqBvx1RxSNBShj8m4ra3o+j9kCEt+orvdaFE0aTbL5i0YwVG51e80Evz0?=
 =?us-ascii?Q?5AbRGqH/qrH1VpL423Lwvi5YnvKP6AjLyMKuexdDXYX2SZqXK10Bn8lxPwOi?=
 =?us-ascii?Q?rvaWShJR3tkCvW8GnLLGZhRpzzcOR8nyDribz6H2rVwWETxL8YEa9k0Smh7G?=
 =?us-ascii?Q?MWfCnDXlU3iPrPxGqcbLddKDzg57/bcUQpJunW8jLpOcn5r55mxAsd4vTGv8?=
 =?us-ascii?Q?Jpn6/Sxj5dKkoFuzYx7O+eRjAJzE21ul5PagisLOPPGwUuh14vxTT6wwtTvZ?=
 =?us-ascii?Q?FM0J6Djs9gHzepAN8FHaArXEt84A+n+qabbCsQWVJWDvEH25LExFSVTANuzY?=
 =?us-ascii?Q?uFYzFHf5qwE1QWfkKxaG7S7WjPD8FjTCiPYjgHKhITGte2PQNn2YJfy/xZ4H?=
 =?us-ascii?Q?wHgEv/4JWHi9e9kS9RK2M8JZsBWF1JurTmycRle1GkFyEY+pYEnLnqZPid8p?=
 =?us-ascii?Q?txgsNmtAhqUaeF2s1TY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b177e16-1821-4674-22e8-08dad0e68bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:16:23.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSZbQEhzHhKsz8CvHGSPjrn48uzwibjY7qg0URiEMVKiiTjY7o0UlVLqLPCmTsRk2iHwapcBzGCtUhak8D+0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: [PATCH 2/5] arm64: dts: imx8m: Align SoC unique ID node unit add=
ress
>=20
> Align the SoC unique ID DT node unit address with its reg property.
>=20
> Fixes: cbff23797fa1 ("arm64: dts: imx8m: add NVMEM provider and consumer
> to read soc unique ID")
> Signed-off-by: Marek Vasut <marex@denx.de>

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
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
> arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
> arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 0c97aca8db6b6..423cb36cbcd53 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -563,7 +563,7 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mm_uid: unique-id@410 {
> +				imx8mm_uid: unique-id@4 {
>  					reg =3D <0x4 0x8>;
>  				};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 9b3a9e1384ae9..312e3abc35ea8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -564,7 +564,7 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mn_uid: unique-id@410 {
> +				imx8mn_uid: unique-id@4 {
>  					reg =3D <0x4 0x8>;
>  				};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index f18cf611f778e..c9459ed21b243 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -426,7 +426,7 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mp_uid: unique-id@420 {
> +				imx8mp_uid: unique-id@8 {
>  					reg =3D <0x8 0x8>;
>  				};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 5246b44a37d4a..2b6d3f4ff5d93 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -593,7 +593,7 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mq_uid: soc-uid@410 {
> +				imx8mq_uid: soc-uid@4 {
>  					reg =3D <0x4 0x8>;
>  				};
>=20
> --
> 2.35.1

