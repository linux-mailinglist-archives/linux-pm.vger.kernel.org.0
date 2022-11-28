Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3A639F6F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 03:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiK1C3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 21:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK1C3l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 21:29:41 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DEE0AC;
        Sun, 27 Nov 2022 18:29:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/oeip+roBshqTMzNT4UUHdLL6xDuICG+s9nWVgdDkHhQzZ90izXKsDwoQ8ya2r71A2a04Z9WmS/z1wVB9qq9a31S/0ptbBOQoTGriDnIcwEaOp6yBp7lUwGaT/lhhRDkjP8iDrBg+tvfpDkin3PHa058qfrLgepVHbdun36k5sU/M6BkLWX7iMTbaeCKmPGnLUmhB8PrzqqH788pjk9bCQyBUOsHEkp/dcgXVdckhZDZ3m+nUxXeyP/GWp4EgqcwtKycPxI/ce3Aapt8lrB1Rx99w4zhMr4gvJ0XJxsgo+auJqnuN665Oxku044njXiudnLR5Tj22EZ1wHoVIAV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4669lpI2PbL9mHXh/7hm7VCYR+QieYKC1ACDtrJ7FCk=;
 b=nqpVz9dcn88FNfGCGfOUK2fR8wrpRhO2wLYsCXBkv/sa++MfCdta1fIC4QdRXQfvlxupfbCK2VgwE/94EQf74RYcy5ZrHNO3Z2i7Gccnb++ZgkxqylLFeur7egqA7z+N6wlFI2nh3D9190LwREdGbzQZISHHKQ3pHzq0SDfNdRkPCuemTsqJBa5/PCXqrVSCGGZWdguYUmvaSoOxXyeIE0mg4ohG7/1erpCIweQVETUZeLGPWRhbWxgnf4GaTInyqtZYcULQuKi7Qnzi1vrhVQpnGGzz9pSYXXiZq+49IG3zpPRSSl8pFz5W79K+YEF7ZHkH5g+wEfL2PDA6rDnUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4669lpI2PbL9mHXh/7hm7VCYR+QieYKC1ACDtrJ7FCk=;
 b=CtEc6H8uZAMQon5sTSnsEf9Vl3Eydyv0Y8/oVbdZJHvdDqUYNCSKpVCgC5oYjNHGgGu/k6c4XgsU0mqwOOJFhSBh12iS1VsMEAciz9AJh7Atbc3EavHfReG2joD92+iwyxvn3BRTFNnHQzHe4bwXKyf4X15YVmstDKXUvosYN8g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 02:29:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 02:29:37 +0000
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
Subject: RE: [PATCH 4/5] arm64: dts: imx8m: Add TMU phandle to calibration
 data in OCOTP
Thread-Topic: [PATCH 4/5] arm64: dts: imx8m: Add TMU phandle to calibration
 data in OCOTP
Thread-Index: AQHZAekprWDy+vIGVkSku0CyFem3Ra5TnpQA
Date:   Mon, 28 Nov 2022 02:29:37 +0000
Message-ID: <DU0PR04MB941745CAF0D4BFF1007145FA88139@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221126224740.311625-1-marex@denx.de>
 <20221126224740.311625-4-marex@denx.de>
In-Reply-To: <20221126224740.311625-4-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7593:EE_
x-ms-office365-filtering-correlation-id: c228a0a9-cfd5-4c3f-afb2-08dad0e86543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WlFT3462/nJ/USTX/QZbw8xHDpcTHJz2X5EHRAo7NgCNHeTTtzv59kn2lEq0/dB1pqNZAAQckDSUQOrJWbv2RJr0byEg4eZXLrg7JwBiem8+hpSIAGGI215aZSP+IlSU6X0RjBFVXgcLaqXYwmpHtYhM1xm/5I2iuukN8rLQJ26bMdqniO4q9Q6hxkT5Xh48/8zx07vN0tF++TAi82CK48rQkSp08nLpkRyHxFKTUS2zdWadJAkSXq7npPBTSqrVJxMQtT2HEd3JHcou8+Pwr904pjQBjS48Pd1h3uVpjqFchRlZ6cguKQ28ywCtXlj97VcLJHojEFGZ1E2QYYnKPLPU1DoleKzq7axzCj6Q3xHdcJ1kRLCGG+SObdxBrTLiKOGLvAV7TppTGpqhSs4Mtg5Kc2i/KPD8x1JD/tKQW/s0J8Uu1bwoJq6dcSFD30KRtO2N9B3XzV/H2IhdbVBZi/deBuPG74PxJUj+7eSDF4p1JwMBp/oturwblqePBeoJzuwFcF7j1HF+F8lkbEPcLuTNroURTT2YmPLVUpT4YiKQsDkjm0257B3oJejEIXjnxfLnmB0oPLb0fMQPxqrLCICcytbLtbRGE3BwkOqcKEIEfc4FpF/A0ETznuOephsLkZp6kqjz5bdB2NQ/vyvZjuaS6TUZIBTZRxN2kwAlcelOUyhJQGk4ja6Q7Yt0Rt07wM4G7KxI0crnWMyFKAlaOEndRZG9+4fboJvMiuFIdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(9686003)(7696005)(83380400001)(2906002)(26005)(6506007)(38100700002)(86362001)(5660300002)(44832011)(52536014)(54906003)(110136005)(38070700005)(316002)(122000001)(71200400001)(478600001)(66556008)(66946007)(7416002)(8936002)(66476007)(76116006)(64756008)(66446008)(8676002)(186003)(41300700001)(4326008)(33656002)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iFZOR5eUqQrKsKdW3Y5eGFSrXn/IpbzcEY91sc3NFGvpPoTQ1ted7hoaPtzA?=
 =?us-ascii?Q?Ylk+3xMhutNzftwEbSeNY0OVz8siI4+ObUsKSF8NUjFlSJk8cfNVaPCdA9a4?=
 =?us-ascii?Q?oylpMXX+vcA+LAKMq+Y5coepZGRsixzv7Bdy6FK9j0GZOLlebWSRQ5i+JIF9?=
 =?us-ascii?Q?7GOkYDBUmpp+Se4ih8JE3a4SGEwlvdezgWrq5BEXJ435jchXAgr3Z614aw6p?=
 =?us-ascii?Q?d9tc1Bd6yt70YugkJ+uPF2R+53xv/RD3HrCiy3dCH2fxYFZgdygNNhUD2kqS?=
 =?us-ascii?Q?QRe1seSAkNIJtbLID5+9IaIWvbXpc88NEu94DN4YoH5lLV29F4VZdO4eTzyd?=
 =?us-ascii?Q?aBktbNJRbEQBQ7xDS07YqClXraJplPF50KKqShBsYRt5JWMQaOKtU7uos5cK?=
 =?us-ascii?Q?J9EC4MoyrwY+7CiPMq/tlVWF5u0zSnOOmtt6mRu8AqXjJizbQ8Dy+lDa09BP?=
 =?us-ascii?Q?hIsKRwjO8vtlpPHqNSSLpGC09ulBf7HPFSeeYOOMA7ztF9PLy1y16KtqaRUI?=
 =?us-ascii?Q?GqRjmFV0DdHsf34BqscObLNErToaX6PV7sWt+QIPQ7N8fPJknvmw4BbUBMwC?=
 =?us-ascii?Q?t5NG2RomHtm2bwD9fpp1YsGg/DMDdX+ns+9Bdskw9OW+Q+QCPReiHq4YsykJ?=
 =?us-ascii?Q?idBzJ2pZBtDIEhep49h8KF3vloN13pTYnCWCUBYjDdyjg/hcslV3afVGEj7I?=
 =?us-ascii?Q?dlvRwNkxVjUXpbNYmgjwAskJzNpB9hzhLcz0wzkGu/WS1nmCecMZ7jesO7Bg?=
 =?us-ascii?Q?hOlizd7M5zveuQye4pJOq+dpcb8d1GqAS+cSii1v8fTBA3YBcU1oPauEv9QG?=
 =?us-ascii?Q?Si0ddYBEvmaFQaKX9dgTvGilCYadQ9EHlr2N6clvCPYCbQeLkk0AOBrJB0Zr?=
 =?us-ascii?Q?ur+wRs5A1Cl96dZwd9U5UCJ1sCWaXmmpcgPmAl3/PlBk2zkp4RCgBrdV4t+5?=
 =?us-ascii?Q?4dsfhCT056fzwvnwXleLKSJrOlW9ShSGiTB6UuJPQbjBC1npKEDJEe288nKD?=
 =?us-ascii?Q?qetWiKU/Na+kqcw9SeWWCkVNSPvXUs5Iukd7irpEMLeAZ1tecbVn4b31goUd?=
 =?us-ascii?Q?celTm5PSGVEro2PDcqzqPVxLNSV2IHs1qPtfiYSDVt91xt0o5a5ySwE1a9jP?=
 =?us-ascii?Q?NfMNUE55w1lekMbJ8KMiBRVb+NZPa/SbFZliThUVJSQGZlyCNndZZPAA2w5d?=
 =?us-ascii?Q?sjLTvl/OEC9gEUpFy+LMq2ZCBFvZbJGt3lFTVPDZiq2FKJCgmPoHNruKNGww?=
 =?us-ascii?Q?WBpn5UtYmubyoQAGJRhmJkCHKcY+Kp/3CDBSsL4KWdy7d+xCYAG2MmF9PW8i?=
 =?us-ascii?Q?kzL79JkOt+u+TA8UBPY6E73ANSd6w5lKF3rAO9fKy5lI+fn3J4JBsHvrIaDt?=
 =?us-ascii?Q?X1bD3r9+cB5ZhkZgz75XcY1PUmDxWGJYfYvWOeCQQetoZ70+uTenqKYhgYDM?=
 =?us-ascii?Q?qnpZjiALx5RbTl49HwvCM67YQripkhEBrd2s8k+RM4hbhrrRWD07sd6zQ8/A?=
 =?us-ascii?Q?2uxTRgVGlKyojG2CQVa7OzIs5BJRABl4I9Cytx34y7dj+9bZlLIfoSVpaZmL?=
 =?us-ascii?Q?SYUJ/MdfF/csp+IdDFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c228a0a9-cfd5-4c3f-afb2-08dad0e86543
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:29:37.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNiLZUnPe41lk4EqkQIJ/9ssnXUovNWW3rNk88qIz9ezG2nURgxsIu5uDSwfQJFR8pPCrOfExTXyRvhoAp+2Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: [PATCH 4/5] arm64: dts: imx8m: Add TMU phandle to calibration da=
ta
> in OCOTP
>=20
> The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
> calibration values in OCOTP. Add the OCOTP calibration values phandle so =
the
> TMU driver can perform this programming.
>=20
> The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2
> uses 4.
>=20
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
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
> arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
> arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 513c2de0caa15..0cd7fff47c44d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -496,6 +496,8 @@ tmu: tmu@30260000 {
>  				compatible =3D "fsl,imx8mm-tmu";
>  				reg =3D <0x30260000 0x10000>;
>  				clocks =3D <&clk IMX8MM_CLK_TMU_ROOT>;
> +				nvmem-cells =3D <&tmu_calib>;
> +				nvmem-cell-names =3D "calib";
>  				#thermal-sensor-cells =3D <0>;
>  			};
>=20
> @@ -584,6 +586,10 @@ cpu_speed_grade: speed-grade@10 { /* 0x440 */
>  					reg =3D <0x10 4>;
>  				};
>=20
> +				tmu_calib: calib@3c { /* 0x4f0 */
> +					reg =3D <0x3c 4>;
> +				};
> +
>  				fec_mac_address: mac-address@90 { /*
> 0x640 */
>  					reg =3D <0x90 6>;
>  				};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 068f599cdf757..5eef9b274edde 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -498,6 +498,8 @@ tmu: tmu@30260000 {
>  				compatible =3D "fsl,imx8mn-tmu", "fsl,imx8mm-
> tmu";
>  				reg =3D <0x30260000 0x10000>;
>  				clocks =3D <&clk IMX8MN_CLK_TMU_ROOT>;
> +				nvmem-cells =3D <&tmu_calib>;
> +				nvmem-cell-names =3D "calib";
>  				#thermal-sensor-cells =3D <0>;
>  			};
>=20
> @@ -585,6 +587,10 @@ cpu_speed_grade: speed-grade@10 { /* 0x440 */
>  					reg =3D <0x10 4>;
>  				};
>=20
> +				tmu_calib: calib@3c { /* 0x4f0 */
> +					reg =3D <0x3c 4>;
> +				};
> +
>  				fec_mac_address: mac-address@90 { /*
> 0x640 */
>  					reg =3D <0x90 6>;
>  				};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index ddcd5e23ba47d..0173e394ad4d8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -380,6 +380,8 @@ tmu: tmu@30260000 {
>  				compatible =3D "fsl,imx8mp-tmu";
>  				reg =3D <0x30260000 0x10000>;
>  				clocks =3D <&clk
> IMX8MP_CLK_TSENSOR_ROOT>;
> +				nvmem-cells =3D <&tmu_calib>;
> +				nvmem-cell-names =3D "calib";
>  				#thermal-sensor-cells =3D <1>;
>  			};
>=20
> @@ -454,6 +456,10 @@ eth_mac1: mac-address@90 { /* 0x640 */
>  				eth_mac2: mac-address@96 { /* 0x658 */
>  					reg =3D <0x96 6>;
>  				};
> +
> +				tmu_calib: calib@264 { /* 0xd90-0xdc0 */
> +					reg =3D <0x264 0x10>;
> +				};
>  			};
>=20
>  			anatop: clock-controller@30360000 {
> --
> 2.35.1

