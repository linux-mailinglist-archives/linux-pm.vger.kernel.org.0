Return-Path: <linux-pm+bounces-32559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74ECB2AD3D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA06C1B621E1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89B31B12D;
	Mon, 18 Aug 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAq7NvIC"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF51315776;
	Mon, 18 Aug 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531966; cv=fail; b=MBUh9Py2k5Q4P/zPDPwnZXvOP8HzJ1ugHpM1HU0AzPPKJrShTH8zgDOtBJxlOi3caByckpyS1AT5LcRBtJx7ofqlgr/52EvzYhpzR3bBSLHDYtvIzffpeFa+2J7dx2TNkuC6kgcF7q1tcOzWt8yqJ/kv6MGJNL6s+cFLH/sJgpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531966; c=relaxed/simple;
	bh=04+4SNaZibOlzw7In+D4I2kE8hiiB9Q/K8lvPLjAeEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cWvzxqYA48qgBroF7YFWMXo+VlrswwHq1jKfy2TW9yGTxA7dcDMX+e3MfddtlegrjA686RM+FWqyUvXvF3IU4PZCBr51oanCtjtW5lrSgDXPW/bNvpEG//ezxldT9caISErSXGNjzujbn3UHsGBy6Aeo/1pgNj+50VWejOi3MW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAq7NvIC; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otSVWqRqlrat4qNsE11o8Au0EPkNxbMETK1SwD2s6x657+KB8gBjO+nKm8cihOSo+girevtP3orBx5etJatXT3tcy4IJWnMSfEAoh4Lvfh0ZkqS4iZg33nTYbV7bvVKxH8lx5ggWa2FNgps7Nyuhkpb1Broj5V1NgvN0ItRm2Rn8YdovzXPXRzpEABs0gs6Eu7KRm1ADmLdQZ2JiUP1UBv+CoQEgWH9QwKckkBbhvP+fYCUbJ6IokFHnpHq7c/H7PhVG2vjEDSDu2YSGJthGBHWcJsoI+wayB94XNtlv97OKRsO3uk6SPfDUd9ord1Pd18U8gntGJ0GFraIVL7jyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAseJOcRF+eDsniCuRc3nCkudaIkoO426rKDQFiQQZE=;
 b=b737aHPhAoiFV5sthQRVGpwv9cLkOXzkuz3pOw1L2tHLooAMJb4AItpieJWTZlP14+WK9yNQ3MSXgwLfkr0GG9Idi43hsg6+93v1WnrVFiKTVPUplt7K+yWYJezGoRxybrFNWejGbQJfQsj2d1Ucai/NlC7bLRcEjd44O/RZpurU91cFaeKWvGWHaGXTx3KIx+dZls6t2R0Nmsa3mFY2DMnRC91NL4dLcwOJQqEc3DKpIYL/XiwrDrliRZAy5CsjXZQcqBhjxdC0pTKY0FOeTC6aKxsmNDUrLHgJV3FBngSnRD0lLSzpSGtQKKu9RpDkIqatJXiCEnbhuMTQTSrpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAseJOcRF+eDsniCuRc3nCkudaIkoO426rKDQFiQQZE=;
 b=AAq7NvICTEbkaFb9EomF//vuKPaB3NGEYqVy522FNcBROAv7ASj3/ILOY4YAsf3zkqhb+5eX4ENTsovKRKPHkeYUlv9QoM+hITQiC0KCHH/nlWsyfrYVUm1VHU34EM1AL1/9fheRb1Is8eO/4q9B8JSUreba8TA7ABoQkcd+wYtiS+t16Mpq9n208oYwHaVwwdnnxyol1eCbWRCwKyYs8VWml4MrkWNdfiCAgMktSKmoR19XW7m4Xr639kHi+TdybPaObDEWimbNB+4AcyvOe2ktkiJFbEDAKeVWQJmHfmBzZaqDt6RnUaIfI8zTZg3aQEhKCIgTBe0eaphLkb6Ydw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:46:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:46:00 +0000
Date: Mon, 18 Aug 2025 11:45:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: qoriq: Add compatible
 string for imx93
Message-ID: <aKNKrxX1FaNI/pQ3@lizhi-Precision-Tower-5810>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
 <20250818-imx93_tmu-v3-1-35f79a86c072@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx93_tmu-v3-1-35f79a86c072@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: c08aae5a-af9c-4163-a9ff-08ddde6e54a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fJkaXQOMBvnMQ65htJH8qywkm2dZ7haJg06C3XCPDkFvs0+av77PHfEeYgM?=
 =?us-ascii?Q?sCIowlMDQov8dHsXePjcEMBI03KinAgEgF+3K2I78rb+iL1Jt2uI5tQpaKYg?=
 =?us-ascii?Q?Xo5bU0yRUBo+e/SjhwBnDAORi63tmDhcvDWIKWfdsvvcukGMEcIaIQajQ/ek?=
 =?us-ascii?Q?Gnch8NfhFnr9sanjoBTPpVW7CH8SFeOpi5YQxIJ903pAW5cKL9zZwc6MRZqe?=
 =?us-ascii?Q?9JDkyeEYbmAaN17KiU+0rsWZzdtaKCnqBGbOCd7bI11pLrgiaU9tyCJXPxlA?=
 =?us-ascii?Q?MuRPx9jhkTDmLTjNrBRFj91MhjD4U4UDglMKv9dNAGgOYZeBWEB9fdE3Zahw?=
 =?us-ascii?Q?kKybdgNgSYYjwNnyFSEJ+06s/WYPweQTkEYpjrAUWsTAKOgsnhTeCyT8FXUM?=
 =?us-ascii?Q?pw032/NffDXb8wlq3qwhxUTVowi2i36+SeDBHeYcBf9Bllkdh0+Dsaye2Y1N?=
 =?us-ascii?Q?mfnpWDxWXc+GJryUG4xvUt2T5j/EeeC/NfVTewp78r6iCH/h6hOXaKCxQTBY?=
 =?us-ascii?Q?aD03kDH/sZ0gCWbyPbxLiFyqa4oac1sCEFI5PGB971JKltkznjfBrBsMgLr7?=
 =?us-ascii?Q?0xTVYwJhCvY3wmAm2ITp45SjnoicCC2Qdkhds8nfALO+XrTWheg2Cu9DEYh3?=
 =?us-ascii?Q?O487vUu6rz6x7xS1WBq34Hs078Q6KzKD1TsBy3aZDLSMP7gZrtmUYHRAzAev?=
 =?us-ascii?Q?i18586FCLNaO692ho8JZru4rynpZxn51UCrwlocYsHsBg01YY4MXDCP/8zTD?=
 =?us-ascii?Q?al8izcby3R6yoeIeSdFippmkl2pJoL6h6MdMoVOHg2t5npqaS1sqQsLAzdip?=
 =?us-ascii?Q?Xkbbtmva4Hpd/13EnUyi1G4RTjiy2pRMRQzaRzvytVH91w8eSvnDCd5cFFId?=
 =?us-ascii?Q?lmEjvi17GO6uxjdIh9imqer1Mk4EXvKAW3F/QJofEDFNvGNtk8Ixp4RoUKpb?=
 =?us-ascii?Q?gdv/r7Jf6AE2QtyhRgCabMMjUjFX2ti+O4IXeavYT9NcF2bTj+kcFeCR1frD?=
 =?us-ascii?Q?/TyZPv2DvsOKtOdJEa9JZ/FUZsGyJ2OPdV/pcMXj4LmLC5pysorKhpUVtExl?=
 =?us-ascii?Q?HY0XJPXhydsKXdSpUHbG1ekPO6WBe8odgz6SrhfQJCW9sWroJDTaqECoHq6K?=
 =?us-ascii?Q?TGzvMf1EJpVrStHnRbcBb+fUZgeCaJJ95IXxCITStvqLdL+SZKeNThHZb/bV?=
 =?us-ascii?Q?VNWbslLkgRSc16kaqytAfnCGIHef+dxcB+2G9hHWPsARiD+NEWXJrYlr105n?=
 =?us-ascii?Q?dljQml6YDgSMEc+o20G3HGYte4fVCjN5h88VdoenRG8/WQQv2UlaKvN91Sau?=
 =?us-ascii?Q?rpnnl1RCFIaZnXuJIfKm8Dow2qBM7FWniKCN+qE93qAGmHNPTkzA3KnRTpbd?=
 =?us-ascii?Q?44IKvtobul86v4JZfoPWU/fin+L2MZZaztpLBf+4LM89KgY+7PeGo9yv7La8?=
 =?us-ascii?Q?Oexvk9WCBhDA8s+I4Kafsqx1AKlkf42RTnvQVWB9dIcRBA8uQjBz4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvlKfSiu/okmTxMqq5ybV8IDF52d58naGMZlicWrgnjrj988Vk77reIhuvI2?=
 =?us-ascii?Q?qwnCUCvTKIKT6yNAJNM61Vm3eKYHQSR1fd+vY/vd5JiVC15MlLEv5o3vKwku?=
 =?us-ascii?Q?CxJ6IEMZG9UwkrZ8JeWnY7wvaj2gn11dX5rxwU4NK26cNGSI+dvVZtELwtkd?=
 =?us-ascii?Q?5B5ySjKrGchh1WOOmdbr+HvYAimcW+FMVD1jYO25w6Qt4cglsi84fUAiRWpR?=
 =?us-ascii?Q?pOEoVTMw+FFoGImgVWPsmDl4fLYBvf0hr/nx+TFCuFo/CSKo/xoMVnjYtQzq?=
 =?us-ascii?Q?w5jR49jIHg4vgcN0Snsfbpa71TC0l/bYF71KIwSlYPJBZyXVt3iZZq1yHbFT?=
 =?us-ascii?Q?dTE9X4UqSOHwC5gEdvbAqmgCPjXJYu6N3ysbvk5Hqu5KoyJfsKCqo6yi66qk?=
 =?us-ascii?Q?m7PKhZuUDFWw74DDeocfGf9SWLKiuQAx7eIfr4ABbQiGW7wW9ZY5Qwv8DsC5?=
 =?us-ascii?Q?PKC+VixoclkcFHlf0J+4825VPQKT6stqJjToInHqVTUzQWr/ozgxIFnpww+H?=
 =?us-ascii?Q?gBK1RPWv81w38abZq0QqIo2+c92IH4ERkaRPhPKfk+3J/5qN3VbyBE6xaefR?=
 =?us-ascii?Q?tTo234vjDx7OKYa5g0GeSGZJovFLjK6kDhYU3WWTlCDjtKntVLT+kRhahv6r?=
 =?us-ascii?Q?eMOqPmhLG+GZIv9O/oX0xso1YVs7NpJ5PXDmZ3Zf0F7lFeMbBmctpvv7MVr2?=
 =?us-ascii?Q?lhyJjwzPqvd/YYiPV/v0n36JcuS2t+pK7FdgnOX7yNzNmJAQNbId+GWKjD14?=
 =?us-ascii?Q?5kZVR4FiEMGC4Y0z5/VnSKDrq2faL3GNot3iMg0+HpKQhxObLRDHjF5vMdYh?=
 =?us-ascii?Q?Qd1iRFnWn/wAMqEblbaMlYHamei+D9GWD+bcCFqXF+nnuijMpO9y8KWjrtjm?=
 =?us-ascii?Q?Yw2+6H7RWf+pGLpnmWUVq6d+rbYClvWlHmJ6Grkcu0mReelnqMPq3T++DEFA?=
 =?us-ascii?Q?IDM8K0D1GnTlRN/XlTbM4TmuxAtvGNePvKhTgS4Gi6osqjbnmgy+TstX3nzG?=
 =?us-ascii?Q?9CaUtOj4Tg7EMN6bSlztiXHMRhzBmtxQVNuGfrcWsp3Bn48fpZw6hvAQfBvH?=
 =?us-ascii?Q?XN1OZ7AfXaxD9ovArb/zDMHzFjLil+2GEaRLmM5i8zmlHABHcCcug2iNCCEW?=
 =?us-ascii?Q?/cyXE32BhAS5hWCxgHtyj9Mf6OvnCD04NU5MEE5t+vXuIVjlokSC2bpdVZse?=
 =?us-ascii?Q?/kf6eJ/wsmGF+KCXFJYdGG7+PD16doVzrcxm1oWqSsAg4RnuFvpsRxl+COrg?=
 =?us-ascii?Q?gCeVNnIKuIFxsyng/jfrmS4z7q84eOB/Pmh+enUr9q3w5IB7OiEC+iK2G2ed?=
 =?us-ascii?Q?o8Y4o/ihIjb2vukTsRqmT7gq9VhFfmBDhi6EvzwkO/UgIm/4WJ+Wqw7szZmK?=
 =?us-ascii?Q?iWkBDYX+6z5e9GDvztzygJpRHfdEExaEfiblu4q2HIdtf3yh1CBmJvO57xxx?=
 =?us-ascii?Q?38JM+ZOMgKph4gyp7d9eEiT4k1UQ+Jcjs068BddJQwtiiZCbM6lw3OuIzgJ2?=
 =?us-ascii?Q?DZ58Zswae9+hHQzNVlG/4F3OrR0Oo1wzIxh06FUmtnMaZvp7hA4MipIIy6XO?=
 =?us-ascii?Q?U3wkddFRhdOcQ7qlSrfI2TbnaepGuLNNNtyial2R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08aae5a-af9c-4163-a9ff-08ddde6e54a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:46:00.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FYhHDQ2HOk6jNWMnpfjQ+xC371DBDhCcEzgcrF73Rl8QIJpu34K2vBsor7uNRzCm7V4A9KkFDteonFj41c8SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

On Mon, Aug 18, 2025 at 05:33:11PM +0800, Jacky Bai wrote:
> Add i.MX93 compatible string 'fsl,imx93-tmu' because Thermal monitor
> unit(TMU) on i.MX93 has differences with QorIQ platform and not fully
> compatible with existing Platform, such as fsl,qoriq-tmu.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  - v3 changes:
>   - refine the commit log
>   - drop the compatible fallback support
>
>  - v2 changes:
>   - keep the enum
>   - refine the commit log to use i.MX93 and QorIQ name
> ---
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> index aa756dae512a2c6e3f0b6bb1ab4a65c01e373ea7..f3b136f5e1cba1fff7e90678d7e3d7ec3ddd25c1 100644
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -25,6 +25,7 @@ properties:
>      enum:
>        - fsl,qoriq-tmu
>        - fsl,imx8mq-tmu
> +      - fsl,imx93-tmu
>
>    reg:
>      maxItems: 1
>
> --
> 2.34.1
>

