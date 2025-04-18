Return-Path: <linux-pm+bounces-25722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE1A93983
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2257216D934
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C4720A5D2;
	Fri, 18 Apr 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g60A/K9+"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701970823;
	Fri, 18 Apr 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989650; cv=fail; b=A57kMhBF02gbGdSW4OlLJHyrtcuIjCEx+nk951xoc5qL6lRfT1wL9u+YzLa3e+i+OnP0b6bmrOVb7HIdT8WW6iNrlWwLYNOGohDhryoWzQP7O+KsaakWkaoJD9qFBZyPlEJz/uu6MEVapWkVPHFt+UYhBdXZuRAnxeua/9GDfH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989650; c=relaxed/simple;
	bh=isZxS2Ur0kDh22AVtMdfPSKCFtJMKmP7XZdFOTZzgtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XUPpu7wKB3MgPTx7LwmuHt+D1jp6Ncqw9XKDUDEJBcfZiHs5GtfzskRutPGNvMGiOuYMwK7LbA8vZR/GJryHg6zEdtGhWy1RYnZTieyivjmf7ZlqmYW3JQ7+PeBjXs+Qz3BZNumFIy1KFx9nTMIwvukgaaS1viZnvG5/OT1j8P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g60A/K9+ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2zrVogGG2zZ2G7HfYUBBpvsT0vX/UXJDPYmCvww4UF0NS5AX721Ga9Alvj7JBihokaAeTuumevN2aBVrLBxlw0i77qYVO9JcaIXOFAB0kUtTNcgd/BAs0Q46j4k5OuIXvKgfd8sN0eQSNQAFlSOh75SNsrTK+d+40XeQCE8ddX2Bgq1R+pctoH9cdnj/DIzooECHLB6XR800v/SaDzFNbESGIER2ikrCbeRvGsAM0q2WFHbPaYb1eNyCrTtU3njVKJgD01xChAWp2W2u0r8cm0UxsemoGB2FD5UUU3bGs9LRKoceohC9zwL6kCIPa/D48CAqorT/AVLNYCpH9a+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZxrPbAybKkBtIE6vsJyc2Mf9i5tXM3OBXIGtHcmTlw=;
 b=eSSn+UAbWx2WRiYKq/s2SXadAX0Y1hKUNdVpXy3q8yiQrZEg+iAAPSq3rpH5Nmk2zyQB+T1aO6yHmc8yDRpFbTqsc93A8O/ISXb0Gta8MXEOTCPzYIRzSXqaV6RDjy7ExkcGcij9xhdD6Y32pAB2JPgp8wYvYV6M+0hUBieJwnicjvvD4EnKYRxiS7ODBnRePvrW/L4Pga4ZROHYdZ633ra11iiy/12Jaw6UfvvgLXwJDPYSENNkQqK64tCydq8Rc7m+yZVB5Fuw+rGSI9Ouv/PR4SoV7KM0S3sv3uHCxalIpZ1O3i1DZGaNeWRJhLRMQZn6UmrXIP86I8q0K5fLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZxrPbAybKkBtIE6vsJyc2Mf9i5tXM3OBXIGtHcmTlw=;
 b=g60A/K9+sGoUNGdYf4XlTYaLaG8uOYRPxc4vRG8S3KHwEFlWTnR9MBL/+5Eu67vFRCLn5MAuMhxBWWOZeb1kMUEcOpTE8bVdYNm+u24w/gwUWSSZ6LfQpEHtijwgaatL/OyLpWpoEbhWZJ67IFm5F2fTZvW+FZbttE99SAXEVvntOIgDUH0vnCYUmT5nlrY/8CwZaDiUd1Kolxzco4xLbxYywBlL7PDb89tbSPXGTdkPMyyabaHlQ/7B7A3J4jF14a0coJ/qWmESctnVxuj3KFWIdCt80Gzt3clthj1Yhx5Sv+0l8PxM2PPHn4NbfM9PdRk22X74EkWEoRMu/fvu/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Fri, 18 Apr
 2025 15:20:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.043; Fri, 18 Apr 2025
 15:20:44 +0000
Date: Fri, 18 Apr 2025 11:20:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RESEND v6 2/2] thermal: imx91: Add support for i.MX91
 thermal monitoring unit
Message-ID: <aAJtwxBtBX4ofy/o@lizhi-Precision-Tower-5810>
References: <20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com>
 <20250407-imx91tmu-v6-2-e48c2aa3ae44@nxp.com>
 <aAIkAF_AHta8_vuS@mai.linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAIkAF_AHta8_vuS@mai.linaro.org>
X-ClientProxiedBy: PH0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:510:5::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6f3c76-0a18-4074-7c39-08dd7e8c9652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?9fjuC8neLFrpcVyZB7pWUfhXXLpZCkgFshQuhvM74iyaybBXeQrMSMHwEt?=
 =?iso-8859-1?Q?lBXpX5Gbj2g1W6Gx/f9aKcWuLMZSkVRa6K1J8RiWQUyZDZZKx8OcfxwF4T?=
 =?iso-8859-1?Q?8EfiYiixgDDxfRqDQScMFPVVci2nFSVk2bk1bZrU14D5+S5LRKDMSomHaf?=
 =?iso-8859-1?Q?B7I1l6QcAsuVLYI1ZQ2eo9lXnWVNDnLLxcElU6IobKLO91FrdCf76fpGdr?=
 =?iso-8859-1?Q?5pXHASBM5tScaypSAPH71uQqon7CUlm56mWwYi9QOgSlzpy9Pajkbmp5r8?=
 =?iso-8859-1?Q?l0sR+nayglpzKXmfOc4KRljQcDdWmwqWuLCvaEdZrAPZlfPsU6xTooV01j?=
 =?iso-8859-1?Q?/4ObzzNQPWe8S903OFXhkVUyjlyCE4Js0h42IE8xh5BZPsk9w/o8/5bYr4?=
 =?iso-8859-1?Q?0RhA7ExuNF1EZYq2IaTRBTYjoLcwxArJexGqPyiZv+zPe5DJCiFO4tqT7p?=
 =?iso-8859-1?Q?6zTiwlD6rz1R9BvYgwfFyTNGkXmStBK+cR+0QTe24QmobXjIXiCWnsD5+E?=
 =?iso-8859-1?Q?glmCq1vaYAg00KZT4h8f6hoKKxWdi/vKgz+gwPUC8dzD8rAQDtJ5n0hsmw?=
 =?iso-8859-1?Q?Wm3J+ztxQoBfQ/tHSJm2EwcSmQr7vsJwOAwPiP7hWxCSFZwVyP84Y7F1Bi?=
 =?iso-8859-1?Q?p30SsMPyVTNrXEzpvfTqevth+tgjsplSDTrs0gHtp8HWTFO3BGkqwKPDB2?=
 =?iso-8859-1?Q?2fv95s/NzJDARwTyiLkw4uRoNDI1uoKZaT2SZDVq0pMCCY2ernmV42OzxH?=
 =?iso-8859-1?Q?UZzBOXYPPIT+sWZz4uDBleNVugqWyvBGkhIjgHf3Pgxjt3/my9bZUXYyrj?=
 =?iso-8859-1?Q?UFP/9O0u0c0EEmCHD2IVSyeKdf5Mddc6/yq6vE9YM895k1E1FXHgOqAA51?=
 =?iso-8859-1?Q?u47xxDMKf0hYTZc1osMypXb5VEuyf80ZO/ltE2Qaye7taykJ8S9dxYyQX1?=
 =?iso-8859-1?Q?09tUAkiHm3PTAlqHZCRGnJW7ePekVsC9gD2pSqzGnUdGzhyGuMJz4gT7QF?=
 =?iso-8859-1?Q?j5NArKQRBg+leQkR+B/0KnQS/Vx81O2+hmZiLN/okE64rqf7ZIpA8Oju7m?=
 =?iso-8859-1?Q?/z3ISV/aJ1rD0USCkN2MmmVkxdS1El27GswRRS4E7Is3illquHNJKR2WOv?=
 =?iso-8859-1?Q?UIcQ+Qx7NnsIpVGq20ldcXggCl90t5zagm4ZGr1sWB+ianBiTXq6XMH3dd?=
 =?iso-8859-1?Q?hVo5aEpbNXHsYr7ZddbOBIQkASXXmbRUQOkudUoB0T6AeZMUtZGLcYdRJV?=
 =?iso-8859-1?Q?0fsiWHGp3AH0idC+QpkOoDniaz3EsYpPdaF3Bmf07yNhtayawOXNq5JIDn?=
 =?iso-8859-1?Q?vGiFuXLZfJ21Hf7hynHVzws9GNNlf7wdhJuulFAyAjj4SPIA3KsadUqyCa?=
 =?iso-8859-1?Q?0TgEoper8RDsaPkBcRVpbQeTsmKxysTRGfkjYcJ4yog1wKPhE/Q5AM1yfa?=
 =?iso-8859-1?Q?X0XmyC6kbtYYqgiRpI66S4Ok9RaogkC7IRDW3lDoQqarySiFqsgQ85z5po?=
 =?iso-8859-1?Q?c3HYGwqgzjVrz/LDJqp8CLfpQSi5i5dxQjasrWUHZfqUZD+nPZrHFfHV7a?=
 =?iso-8859-1?Q?dUcH0pY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/n+TALj+DCUjK9X9wsqAIbtC3YSP89eALe+okfdKN5R5vk4YWgu6xwIHcf?=
 =?iso-8859-1?Q?sPwe1KWg4weqhGSeZAn1S8TcCq6tpOJpG7wuV+DmgzElpkrFZzM6YHYaJj?=
 =?iso-8859-1?Q?b0nVg5xABLDMmb8/om5od5mLx3RxMcXHJvFgWtvGLn3pAsfn1lpac9TwAS?=
 =?iso-8859-1?Q?ev4pdyxNPdDobUUO6aF82O4KyTBxB70JIGNKZRXcwbJArbJkVV1Pw4UJCs?=
 =?iso-8859-1?Q?AjmHZ8ucHX+qzuA2cqo3Qx2itcrwDul65EPzVY3tOqaq8aJ6IshBrQFC27?=
 =?iso-8859-1?Q?MThJ2Kl1FiWBECWRlLcibWy2RTI2F5nPqlrlimocBbppan+oONE5f4SMfr?=
 =?iso-8859-1?Q?qh60wbavBleHxypnjkcVSi9oLXUJEvFj3IrWusdYm3PZoK0jv1ZHP1I3rl?=
 =?iso-8859-1?Q?2GyZVFaoNdB7uysqUZujwaNMDuYbN/V2SpEqezRj0j7PORDKvGkWCHbXUv?=
 =?iso-8859-1?Q?bncDbAOdnAmx8cjhruBO6bRel+KR+/rlkLH4ymvDPMCDmPfYXa0Z5seYcq?=
 =?iso-8859-1?Q?51eWwAq+ly/srz70tCk6gqTSyXzrsdd9Sc4Z5zMF3IrNH7m2wgvUP4PjXE?=
 =?iso-8859-1?Q?TZqnY3orvKGUwwhouYjTkLayz2a7JJpKQKnFKDMonhUUPMqs6nqdXnxmlZ?=
 =?iso-8859-1?Q?4ovOSJhzGNGhiq3SKSRyMYcUs0bZ7xSfdcBp8wUTjvk+ry+S5xxz7x/jfS?=
 =?iso-8859-1?Q?x0OfQMITv8cT4iFiFGs8E5u6bgopoiyC726wgp2obxus8eD03JlNBsNYGO?=
 =?iso-8859-1?Q?V72ueQVWV2Afk0QcPw33Sx9UGDqQzkBFBmQKV7VUy8cmoVG9kNEFA67Cfy?=
 =?iso-8859-1?Q?d3xjZUDqLRJX0brOl3dYGP9SyxmUzf8UnmUCK7YqqKXmOMlBsHWOBp1uTW?=
 =?iso-8859-1?Q?IhXhVIbIRZnN47d1VQLW/vlVL72tl7ksgNCmQDFaPau0lkHbHUh6t+RU3x?=
 =?iso-8859-1?Q?uXkt0FOkxKPyQBmbfyypfd51O7PAjSvTXItSJWHJYU5crysgZZwQq1qNSY?=
 =?iso-8859-1?Q?e/rjr97DMQALVKWsn1ieBmxP68ExfFLvN+nTzSC5bWPTDEStZzoPIMmCdg?=
 =?iso-8859-1?Q?KaKESTspeghFZLtqdaHmyWkATyIDhUN2LzI09VIr9pHCTzecdUfsKE4s9G?=
 =?iso-8859-1?Q?Pumj8O33fRKdu4hTwGADiReRVyFwBklsJ4DOFbRK8b/WPV8tjk/bwwGz+j?=
 =?iso-8859-1?Q?+s7E/B7CvEeRwxbqw8pUTDHNadjH6NlSyPCUHJkUQTOMdzIZo8z9MAm6YL?=
 =?iso-8859-1?Q?VXqaIzz+sGEvRCkYNOt5G0XL8nwnrJqlNWSzpzzFJApZHEzwx//mAnj2jn?=
 =?iso-8859-1?Q?cJd5Oo2gYH5FYYySrHofMWCrZJbFXLJjNEspgtRejuv1U2E6hdCzTk9itT?=
 =?iso-8859-1?Q?wjkHaXxDnORiM2uoGVv+INF67QRPzGH0sHophzkSTsP5DTNotSY1vTxd6a?=
 =?iso-8859-1?Q?6envUmZk2omirdKZBCKSnNdGzKEruRs4WKyYI4KxQTK629s3CAFHP0LgNg?=
 =?iso-8859-1?Q?V/GTEwiv9ZdBbV11RrjDV1koRXy8UN1WQmcA6RlvD5aibhfH6adiw2B49L?=
 =?iso-8859-1?Q?4rbrb33EXZhVZNBFP9V3LfBIUqrkSlHb9KCSDcn0iRwaotH5YGGWvoBjzx?=
 =?iso-8859-1?Q?k8ejtfGHZZwqN37e/an+tw0nb5G6Zwhfah?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6f3c76-0a18-4074-7c39-08dd7e8c9652
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 15:20:44.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMAwh7+X/88S6CT7evt0i3y0OQTu23YVxYL+jL8iKrQtOnJocUsTfzilOY3x2E9z81EIak3pHTNt8Q4FiwaeNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762

On Fri, Apr 18, 2025 at 12:05:52PM +0200, Daniel Lezcano wrote:
> On Mon, Apr 07, 2025 at 04:05:40PM -0400, Frank Li wrote:
> > From: Pengfei Li <pengfei.li_1@nxp.com>
> >
> > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > single sensor for the CPU. The register layout differs from other chips,
> > necessitating the creation of a dedicated file for this.
> >
> > This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
> > accuracy, refer to the datasheet, as it varies depending on the chip grade.
> > Provide an interrupt for end of measurement and threshold violation and
> > Contain temperature threshold comparators, in normal and secure address
> > space, with direction and threshold programmability.
> >
> > Datasheet Link: https://www.nxp.com/docs/en/data-sheet/IMX91CEC.pdf
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v5 to v6
> > - remove Macro's review tag
> > - remove mutex lock
> > - use set_trips callback
> >
> > Change from v4 to v5
> > - add irq support
> > - use period mode
> > - Marco, if need drop review tag, let me know
> >
> > Change from v3 to v4
> > - Add Macro's review tag
> > - Use devm_add_action()
> > - Move pm_runtim_put before thermal_of_zone_register()
> >
> > change from v2 to v3
> > - add IMX91_TMU_ prefix for register define
> > - remove unused register define
> > - fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
> > - use dev variable in probe function
> > - use pm_runtime_set_active() in probe
> > - move START to imx91_tmu_get_temp()
> > - use DEFINE_RUNTIME_DEV_PM_OPS()
> > - keep set reset value because there are not sw "reset" bit in controller,
> > uboot may change and enable tmu.
> >
> > change from v1 to v2
> > - use low case for hexvalue
> > - combine struct imx91_tmu and tmu_sensor
> > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > - use s16 for imx91_tmu_get_temp(), which may negative value
> > - use reverse christmas tree style
> > - use run time pm
> > - use oneshot to sample temp
> > - register thermal zone after hardware init
> > ---
> >  drivers/thermal/Kconfig         |  10 +
> >  drivers/thermal/Makefile        |   1 +
> >  drivers/thermal/imx91_thermal.c | 398 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 409 insertions(+)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d3f9686e26e71..78a05d1030882 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
> >  	  cpufreq is used as the cooling device to throttle CPUs when the passive
> >  	  trip is crossed.
> >
> > +config IMX91_THERMAL
> > +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	depends on OF
> > +	help
> > +	  Include one sensor and six comparators. Each of them compares the
> > +	  temperature value (from the sensor) against the programmable
> > +	  threshold values. The direction of the comparison is configurable
> > +	  (greater / lesser than).
> > +
> >  config K3_THERMAL
> >  	tristate "Texas Instruments K3 thermal support"
> >  	depends on ARCH_K3 || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 9abf43a74f2bb..08da241e6a598 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> >  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> >  obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> >  obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> > +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
> >  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> >  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> >  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> > new file mode 100644
> > index 0000000000000..e8deb0b07dc98
> > --- /dev/null
> > +++ b/drivers/thermal/imx91_thermal.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2025 NXP.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/thermal.h>
> > +#include <linux/units.h>
> > +
> > +#define REG_SET					0x4
> > +#define REG_CLR					0x8
> > +#define REG_TOG					0xc
> > +
> > +#define IMX91_TMU_CTRL0				0x0
> > +#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
> > +#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
> > +#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
> > +
> > +#define IMX91_TMU_THR_MODE_LE			0
> > +#define IMX91_TMU_THR_MODE_GE			1
> > +
> > +#define IMX91_TMU_STAT0				0x10
> > +#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
> > +#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
> > +#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
> > +
> > +#define IMX91_TMU_DATA0				0x20
> > +
> > +#define IMX91_TMU_CTRL1				0x200
> > +#define IMX91_TMU_CTRL1_EN			BIT(31)
> > +#define IMX91_TMU_CTRL1_START			BIT(30)
> > +#define IMX91_TMU_CTRL1_STOP			BIT(29)
> > +#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
> > +#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> > +#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
> > +
> > +#define IMX91_TMU_THR_CTRL01			0x30
> > +#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
> > +
> > +#define IMX91_TMU_REF_DIV			0x280
> > +#define IMX91_TMU_DIV_EN			BIT(31)
> > +#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
> > +#define IMX91_TMU_DIV_MAX			255
> > +
> > +#define IMX91_TMU_PUD_ST_CTRL			0x2b0
> > +#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
> > +
> > +#define IMX91_TMU_TRIM1				0x2e0
> > +#define IMX91_TMU_TRIM2				0x2f0
> > +
> > +#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
> > +#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
> > +
> > +#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
> > +#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
> > +
> > +#define IMX91_TMU_PERIOD_CTRL			0x270
> > +#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
> > +
> > +#define IMX91_TMP_FRAC				64
> > +
> > +struct imx91_tmu {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct thermal_zone_device *tzd;
> > +	int high;
> > +	bool enable;
> > +};
> > +
> > +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> > +{
> > +	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
> > +
> > +	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1 + REG_SET);
> > +}
> > +
> > +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> > +{
> > +	u32 reg = IMX91_TMU_CTRL1;
> > +
> > +	reg += enable ? REG_SET : REG_CLR;
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
> > +}
> > +
> > +static int imx91_tmu_to_mcelsius(int x)
> > +{
> > +	return x * MILLIDEGREE_PER_DEGREE / IMX91_TMP_FRAC;
> > +}
> > +
> > +static int imx91_tmu_from_mcelsius(int x)
> > +{
> > +	return x * IMX91_TMP_FRAC / MILLIDEGREE_PER_DEGREE;
> > +}
> > +
> > +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	s16 data;
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(tmu->dev);
> > +	if (ret < 0)
> > +		return ret;
>
> Why using pm_runtime* all over the place ?
>
> It would make sense to have in the probe/remove functions (or in the set_mode -
> enabled / disabled), suspend / resume but the other place it does not make
> sense IMO. If the sensor is enabled by the set_mode function and then
> pm_runtime_get() is called, then the ref is taken during all the time the
> sensor is in use, so others pm_runtime_get / pm_runtime_put will be helpless,
> no ?
>
>
> > +	/* DATA0 is 16bit signed number */
> > +	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
> > +	*temp = imx91_tmu_to_mcelsius(data);
> > +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
> > +		ret = -EAGAIN;
>
> When the measured temperature can be out of limits ?

It is safety check. It may be caused by incorrect calibration data or some
glitch at ref voltage.

>
> > +	if (*temp <= tmu->high && tmu->enable) {
>
> I suggest to provide a change in the thermal core to return -EAGAIN if the
> thermal zone is not enabled when calling thermal_zone_get_temp() and get rid of the tmu->enable
>
> > +		writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> > +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> > +	}
>
> For my understanding what are for these REG_CLR and REG_SET in this function?

REG_CLR\REG_SET is offset 8\4 for each register, which used clear\set only
some bits without touch other value

	SET register work as

	val = readl(reg);
	val |= mask;
        writel (val, reg);

the benenfit of use CLR/SET register make code simple and it is atomic change
one bit.

>
> > +	pm_runtime_put(tmu->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int imx91_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	int val;
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(tmu->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (high >= IMX91_TMU_TEMP_HIGH_LIMIT)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +
> > +	/* Comparator1 for temperature threshold */
> > +	writel_relaxed(IMX91_TMU_THR_CTRL01_THR1_MASK, tmu->base + IMX91_TMU_THR_CTRL01 + REG_CLR);
> > +	val = FIELD_PREP(IMX91_TMU_THR_CTRL01_THR1_MASK, imx91_tmu_from_mcelsius(high));
> > +	writel_relaxed(val, tmu->base + IMX91_TMU_THR_CTRL01 + REG_SET);
> > +
> > +	writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> > +
> > +	tmu->high = high;
>
> Why is 'high' needed?

Need re-enable irq when tempture below high.

Frank
>
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> > +	pm_runtime_put(tmu->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> > +{
> > +	struct device *dev = tmu->dev;
> > +	u32 trim1, trim2;
> > +	int ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (trim1 == 0 || trim2 == 0)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
> > +	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx91_tmu_action_remove(void *data)
> > +{
> > +	struct imx91_tmu *tmu = data;
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_enable(tmu, false);
> > +}
> > +
> > +static irqreturn_t imx91_tmu_alarm_irq_thread(int irq, void *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev;
> > +	int val;
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(tmu->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	thermal_zone_device_update(tmu->tzd, THERMAL_EVENT_UNSPECIFIED);
>
> Ack the IRQ before calling thermal_zone_device_update()
>
> > +	val = readl_relaxed(tmu->base + IMX91_TMU_STAT0);
>
> One blank line to let the code breath
>
> > +	/* Have to use CLR register to clean up w1c bits */
> > +	writel_relaxed(val, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> > +
> > +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +
> > +	pm_runtime_put(tmu->dev);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_device_mode mode)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	int ret;
> > +
> > +	if (mode == THERMAL_DEVICE_ENABLED) {
> > +		ret = pm_runtime_get(tmu->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		imx91_tmu_start(tmu, true);
> > +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> > +		tmu->enable = true;
> > +	} else {
> > +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> > +		imx91_tmu_start(tmu, false);
> > +		pm_runtime_put(tmu->dev);
> > +		tmu->enable = false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct thermal_zone_device_ops tmu_tz_ops = {
> > +	.get_temp = imx91_tmu_get_temp,
> > +	.change_mode = imx91_tmu_change_mode,
> > +	.set_trips = imx91_tmu_set_trips,
> > +};
> > +
>
> [ ... ]

