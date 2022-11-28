Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0062E639F67
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK1CSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 21:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiK1CSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 21:18:10 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E861C745;
        Sun, 27 Nov 2022 18:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP3jwm8DQa8fQa4Hl/++ADf2e7a+KuyDjPN+A+ZJhyU1JSiOgX53BWQ1tMo+/1s4ELFnDTgwo7BrpUeNFghhUo/GU9FS4VwtzGMFyBFcLRj04ACL4ZOSSKITWEEoBKbFOU7ojdMzVqTqbH1aq70cC4g7/CfZTaGFqS3ERvegMexIlwn020Q2/hpe5D2j4gyoPjZTNHKvZmPg/6/QJr6lgi9JPfTXCDDCnEjDEWfPKJTWeLYinzQ9eBFA1D8dy7pgR8S5UJYBNa3lpHQzD2cwsJr9CD/U1MCz3n8Ifcjxtit1hK5C5bKW6//Lu4YNOoEuwn0KUiQgnNnDL93h8o6/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrMX0KkkV++OXAVWPSFAR1bmfQtsCbTz5wKSom0Carg=;
 b=REcYHFthcgOT02LJIuN+fIQUfReqSUPQDqwSAMQbYZvz8UAHA1aP1QLDATYnKBkv5yH4rfxv9ZAvL34c40rKw1p4kiN09CzPVKRdDYfQOpI7/ZSeW0xa29uOMyAOf/tBkoYPdVHS3vAJAamwWTyWf1sjNUfDHbInUMNtCc1w2w7v+QFxsQVTU1SnZsQGUAedTgZKX/lVt2zfQ3UVcAeQJDy/LTNCZxoFAhaRiiGFcesf3I3KWsW1QPok90Z3k9997hHLVQMz02rzKsARuXLO1QZmH/98UjSfcAn21tTDplF6fcD7Ctbn+CHsMnVskI5kqzPW4JlBrakQ4Ta0FY8Dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrMX0KkkV++OXAVWPSFAR1bmfQtsCbTz5wKSom0Carg=;
 b=gQP+MlWA+yXPMN9F5EnbN63+lPJpUsPq+18G3UKddFnPW0BODhG+10cvrd5r3R1sm0pZ4VkzxnVh0SbFtMzk+WmmduBtSwoJj6ck/z0+A8E7mpS6XvNHlksomOaWpC0xVhCVKfB74WfzpMHGERlZt7uVI1CNhyKn/1b28cO+muQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 02:18:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 02:18:05 +0000
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
Subject: RE: [PATCH 3/5] arm64: dts: imx8m: Document the fuse address
 calculation
Thread-Topic: [PATCH 3/5] arm64: dts: imx8m: Document the fuse address
 calculation
Thread-Index: AQHZAeko/HcNMH13VUuzZNIsSbymoK5Tm01g
Date:   Mon, 28 Nov 2022 02:18:05 +0000
Message-ID: <DU0PR04MB941786872C3E910EB41BDB1588139@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221126224740.311625-1-marex@denx.de>
 <20221126224740.311625-3-marex@denx.de>
In-Reply-To: <20221126224740.311625-3-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6975:EE_
x-ms-office365-filtering-correlation-id: be5b5d62-c61c-4d00-27ff-08dad0e6c8d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqBCIk4IoH9xIBajbqULPDOVf/XvFPQjwHpVNsBRqnaVm4PN1jY6Fj3CYcxhH4+eTxF0hnV6nwWO7+pNWZ3Fob+YiaO6MJL0CbIxk9VP8ElI6aEaSkhXhTu4lnOa98/IjlXHouaZb0EgYD6uKGWnbDBjWwnSbuZ2x/wqlSBRz2TWJ0eFTUFDclDtEgABVyLoUITF3TaVL/LFDOt59XV3UmvmNM2NkTV0aN/jhbJZ+6R7FMpJnMV4g6x0do5sgmPDhUqafbvesRIbjI6rYifXMJVeAcWdtdEQbgft24GpupQbFSCCU//M1KqYXORlcdw4zGVGeT2sZEwN6/3A6C/9ikEh12p2sqe8319aUVR/doq/MOWGhbD8fXlcWhfXEMiOpxQ40W11UabqYZ41NhygdKKwzgA9T9g24nLXsVHlw4+s8MfYe6beL1/tnZlcZb4a7JoG4RrXA2dMk3+qpGN3grwXlyKAHCV4d3EM/4dlsgYW1nNXG8ngoV+lskJfWT5knR906IyrVrXN5zZ+iFbDI+XHM7w1zusWVZFTYlCLbzGjtB4qGKm/2QUwJgbhY32PJPjwP1OEstq/BMk5MxiQJ9tOGB0VtFS+AoqE8ztijLiBrU01YQ7a75ojp4DFt6zxOaA1cWrnYABsNocwiYtKXtOtJSQmhhJU/A9ES51Mh/jnxMFZIcRfTW9nF3ddw5LCBncphbl9jqTcHVvEN0ZkDPuFMpVkYdYxRb/9Z9Z4RS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39850400004)(396003)(376002)(366004)(451199015)(2906002)(44832011)(41300700001)(54906003)(4326008)(66446008)(8676002)(66946007)(66556008)(64756008)(66476007)(316002)(110136005)(52536014)(8936002)(76116006)(33656002)(71200400001)(5660300002)(26005)(86362001)(478600001)(9686003)(7416002)(6506007)(7696005)(186003)(38100700002)(83380400001)(55016003)(122000001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?guStwDlF+HweDTC4jGfHWIsWCAigDjGhdz9pdtTz1d8n2RkXKBVv+zTGlbO6?=
 =?us-ascii?Q?JyOTNk6SfvKISdFrqmt6PpEoRKjJv2fw4It77b2NKLCjrB8/TghmfqazHPin?=
 =?us-ascii?Q?ZqiPoNsn+QNzTWdKZwILnGG9bBoSuKwQDXBltYfQGWAhYTocyf1ZS5WWa5JC?=
 =?us-ascii?Q?BfDn2qs6EtGhY5aC/yZWzY+Q/uw+oM5Pzb1cXmY+9Drz9S8Lc5BSZ4MFF5Iq?=
 =?us-ascii?Q?5sFaoScpoTHqUD8cgnDNKBGK0/Khk3kI4Zep3dta2CErMcmOnP/BPaGrzFOG?=
 =?us-ascii?Q?9h11UB5MNtZ/MtP8enmEDlMYavxGco+2ctFCh3PO1LJgyBVhmoRKurNHBqyB?=
 =?us-ascii?Q?7SJEELnMWNBGaIKkIcUF5dJ2QSIY925cGg082KmX452HNrZA0H/cGE/eVhza?=
 =?us-ascii?Q?N+s7QpjpESzIocEECa5PbM+ioBSPhv8qITgkN+nDFO+s5rXT5JEtdD9qie9x?=
 =?us-ascii?Q?9zB+aUu0V3DUN73av6FklgnIhpBt7ts+NNixe+6OEbY8125PTFJhJZtbrVoo?=
 =?us-ascii?Q?etg9/Iz7AX73eMuIQGp//tPbtYpErQdsmK0sr/4t4NHcsvkk2MHaKo2+4G8x?=
 =?us-ascii?Q?VO40a60k3KPL9NAvsAFRG9GN0cYIoVWhJgqXH5FWVqBWJernrUaZ7hteaQm1?=
 =?us-ascii?Q?ZlFhn5a3zlprMV7z7//QDhn6LV0FU/oc5tFAgCjQ0qpde7Y3Zj5LhtiJQ+IB?=
 =?us-ascii?Q?vL90HLcEisMc2V2fJNWT1FvSPbyRpScpe3ElFer6Qhu2ibewccOK8Sze+NRf?=
 =?us-ascii?Q?TCB2lSnLebqOhK8RVSqEDyFtjxueaM6mnxsP/kjGC4S5nkTRnY4AN58uIlxd?=
 =?us-ascii?Q?tYlu/nmdD4dytNHEVuSsDUUUtZ5yBS7+oSJcPUZ1UaO4vYxR1f32giHI6s5e?=
 =?us-ascii?Q?K3MnYkInAEYKYnknsnviy0gSkpupyKS3W4mJfEE4I8oS/cwr6yEygVSQj5IY?=
 =?us-ascii?Q?3tTrhzaVy07r86vTI6Y/QEC6WKefXQwgYAGOs2HgUPw+RPUtX1+DLN62wJLj?=
 =?us-ascii?Q?OAbfvsAnkIxIf8pBk8KsyH1v3+5QF2j23X2R6ZI0poau1t3serE9WnH+0a+r?=
 =?us-ascii?Q?rVcjUEkxkIVKUTfZYKv0oGwboAphHedutanItNyO395q1PGXS16u/YKTiNln?=
 =?us-ascii?Q?wCMjeyyrbxiA8Xqh2SZn4l/ESsSa/UgC0xkVulYXusWoaCdu9gcq5d1rN6Ib?=
 =?us-ascii?Q?rtWvx+KVi6+Aa3ic1pP/5VN5FPeQetC7rYy2lt0T6vw4Czhyt3WV2292YC5L?=
 =?us-ascii?Q?EXqGT1nDrnoePjoojv2p3+4MQR0prUBtSs2UqW9GLHspX1Mg6ARle14MMGzR?=
 =?us-ascii?Q?yMOnelQlvH9zAra/wPCieGiJX6r+gPfWAKjoeER6zrfNzgNDu2Ibo2+3/MFb?=
 =?us-ascii?Q?sHk/Z6DNgAhG4J/beofjZxJ0HkJR5tyO2+YRG/DUpDpOtzgIyJnO0nYqSEzj?=
 =?us-ascii?Q?zFk0fvEQBQOScx7Ts1/uhemccnMnRBrQhAITUWYuvZhU1vWUWGUa9rAfuZbi?=
 =?us-ascii?Q?rOmxvIDbVkbPzCQej8BJXAKXy57dp62S6uRTK/rNdLIARiu6oHOm3PKWiSbJ?=
 =?us-ascii?Q?h4kRVZEgqwPBGP2oB4k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5b5d62-c61c-4d00-27ff-08dad0e6c8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:18:05.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/ugfpyVcm7t7RlAZfxArSDvEjQiPylJvXBeVzQDH5/MfOC1Y92u3zB7u5e+TfHIGf555qjfBaoN4ivyMfYCig==
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

> Subject: [PATCH 3/5] arm64: dts: imx8m: Document the fuse address
> calculation
>=20
> The mapping from OCOTP reg DT property to Fusemap Descriptions Table in
> the datasheet is often unclear. Add a comment to make it easier to find o=
ut
> how it works. No functional change.
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
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 19 ++++++++++++++++---
> arch/arm64/boot/dts/freescale/imx8mn.dtsi | 19 ++++++++++++++++---
> arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++----
> arch/arm64/boot/dts/freescale/imx8mq.dtsi | 19 ++++++++++++++++---
>  4 files changed, 65 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 423cb36cbcd53..513c2de0caa15 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -563,15 +563,28 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mm_uid: unique-id@4 {
> +				/*
> +				 * The register address below maps to the
> MX8M
> +				 * Fusemap Description Table entries this way.
> +				 * Assuming
> +				 *   reg =3D <ADDR SIZE>;
> +				 * then
> +				 *   Fuse Address =3D (ADDR * 4) + 0x400
> +				 * Note that if SIZE is greater than 4, then
> +				 * each subsequent fuse is located at offset
> +				 * +0x10 in Fusemap Description Table (e.g.
> +				 * reg =3D <0x4 0x8> describes fuses 0x410 and
> +				 * 0x420).
> +				 */
> +				imx8mm_uid: unique-id@4 { /* 0x410-0x420
> */
>  					reg =3D <0x4 0x8>;
>  				};
>=20
> -				cpu_speed_grade: speed-grade@10 {
> +				cpu_speed_grade: speed-grade@10 { /*
> 0x440 */
>  					reg =3D <0x10 4>;
>  				};
>=20
> -				fec_mac_address: mac-address@90 {
> +				fec_mac_address: mac-address@90 { /*
> 0x640 */
>  					reg =3D <0x90 6>;
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 312e3abc35ea8..068f599cdf757 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -564,15 +564,28 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mn_uid: unique-id@4 {
> +				/*
> +				 * The register address below maps to the
> MX8M
> +				 * Fusemap Description Table entries this way.
> +				 * Assuming
> +				 *   reg =3D <ADDR SIZE>;
> +				 * then
> +				 *   Fuse Address =3D (ADDR * 4) + 0x400
> +				 * Note that if SIZE is greater than 4, then
> +				 * each subsequent fuse is located at offset
> +				 * +0x10 in Fusemap Description Table (e.g.
> +				 * reg =3D <0x4 0x8> describes fuses 0x410 and
> +				 * 0x420).
> +				 */
> +				imx8mn_uid: unique-id@4 { /* 0x410-0x420 */
>  					reg =3D <0x4 0x8>;
>  				};
>=20
> -				cpu_speed_grade: speed-grade@10 {
> +				cpu_speed_grade: speed-grade@10 { /*
> 0x440 */
>  					reg =3D <0x10 4>;
>  				};
>=20
> -				fec_mac_address: mac-address@90 {
> +				fec_mac_address: mac-address@90 { /*
> 0x640 */
>  					reg =3D <0x90 6>;
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index c9459ed21b243..ddcd5e23ba47d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -426,19 +426,32 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mp_uid: unique-id@8 {
> +				/*
> +				 * The register address below maps to the
> MX8M
> +				 * Fusemap Description Table entries this way.
> +				 * Assuming
> +				 *   reg =3D <ADDR SIZE>;
> +				 * then
> +				 *   Fuse Address =3D (ADDR * 4) + 0x400
> +				 * Note that if SIZE is greater than 4, then
> +				 * each subsequent fuse is located at offset
> +				 * +0x10 in Fusemap Description Table (e.g.
> +				 * reg =3D <0x8 0x8> describes fuses 0x420 and
> +				 * 0x430).
> +				 */
> +				imx8mp_uid: unique-id@8 { /* 0x420-0x430 */
>  					reg =3D <0x8 0x8>;
>  				};
>=20
> -				cpu_speed_grade: speed-grade@10 {
> +				cpu_speed_grade: speed-grade@10 { /*
> 0x440 */
>  					reg =3D <0x10 4>;
>  				};
>=20
> -				eth_mac1: mac-address@90 {
> +				eth_mac1: mac-address@90 { /* 0x640 */
>  					reg =3D <0x90 6>;
>  				};
>=20
> -				eth_mac2: mac-address@96 {
> +				eth_mac2: mac-address@96 { /* 0x658 */
>  					reg =3D <0x96 6>;
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 2b6d3f4ff5d93..8a2ec90b493d9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -593,15 +593,28 @@ ocotp: efuse@30350000 {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <1>;
>=20
> -				imx8mq_uid: soc-uid@4 {
> +				/*
> +				 * The register address below maps to the
> MX8M
> +				 * Fusemap Description Table entries this way.
> +				 * Assuming
> +				 *   reg =3D <ADDR SIZE>;
> +				 * then
> +				 *   Fuse Address =3D (ADDR * 4) + 0x400
> +				 * Note that if SIZE is greater than 4, then
> +				 * each subsequent fuse is located at offset
> +				 * +0x10 in Fusemap Description Table (e.g.
> +				 * reg =3D <0x4 0x8> describes fuses 0x410 and
> +				 * 0x420).
> +				 */
> +				imx8mq_uid: soc-uid@4 { /* 0x410-0x420 */
>  					reg =3D <0x4 0x8>;
>  				};
>=20
> -				cpu_speed_grade: speed-grade@10 {
> +				cpu_speed_grade: speed-grade@10 { /*
> 0x440 */
>  					reg =3D <0x10 4>;
>  				};
>=20
> -				fec_mac_address: mac-address@90 {
> +				fec_mac_address: mac-address@90 { /*
> 0x640 */
>  					reg =3D <0x90 6>;
>  				};
>  			};
> --
> 2.35.1

