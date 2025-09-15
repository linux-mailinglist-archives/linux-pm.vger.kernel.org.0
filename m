Return-Path: <linux-pm+bounces-34624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD3B570D6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51C6189A684
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4742C21D6;
	Mon, 15 Sep 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hE9g8lJd"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F552550AF;
	Mon, 15 Sep 2025 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920007; cv=fail; b=KDDCSLDfl35Shz7OO9Sin8tkfRTWdtK8fhEpWYuDr3nwwe1B5K2CrWrvf9oIt/u4z5zmaThw8cDtaP4zWvZg30fpF9MW3mxCZc6bBrudsZSE3Kcbm6cUoDZvxkGnNBWRhdjNC2n7FQvYi4WHDyAWPoIfFB0rI+A0cUXrNQOkCBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920007; c=relaxed/simple;
	bh=Cin2opBxjOAmoxMRCztNhXo9s5xccpttGnWbQIFMUSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbSj4FVVb/lr9DGbhE3i8psCywyZd1jJ2n/52Blk5DtQkRhaB5sDsfhHlXTj7Exm1QLcmMBM5jpVUOOohCegyrUI8MEbKCS6vYwF/fv9IMUGynDz8ur8JofHoNKUsKbtnkwgjTFy3THQhYL6HJSi4kJ4CkurZenm5AN+FXpCZJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hE9g8lJd; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXGqel3CYun+uBHCSnRyklgHv0gw29xXoPnJC9n4m3tNwHRZmd/1UZz7nITjolsgw2DY5gGLjJijXTkk/taFENNIH8GkGULD6bsKnmTZXQz13soZdpILhx4blHcYma/5DOuIGAn5RpO+5C1MVHtolQEzGawxnuCk2ktpe7FYWF40K1adiYLv41V/UWqi2ydzpeKnzHvuNZ/ub9K5xgP22hOzMyAm9AK94SZGcTlUxesD7tOwrLVhl039HZRinwcJJtkJMWx+gGXk7EEMJmvBUpi8y3PCtVMr7Gn/0J+VhA8ALYwJG/WIsIKE+AZbAqDwGW2fRud5ee5P3uCgbDNQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJpl8eIhVqg9MjGTywUe8u0LjjFHU0kJE4Ce2VJsawI=;
 b=tMdb8KEFHWjfJ3JMWUJQ8weNRArubIy95VthnQ5LTEmavLiyHp2ZUtHLyKhfNjrp08yJsA5L3fqlhmF0X2WjVFGR2LmpN908Sw5j7lhTSvdwfBbkubLtWJj0AsjL06fLJMoCs4BvQBs1oZ+zIdzk3h6dRncss5BQmBtTKnoGfMdANjCoGMPoMXWnZvHxiyH4zf0vTC9CJKlrBXCMzy6Y2K1j9UXJmZ8ixxQx44RpiSjd8GhmCJD2+47wX6ow3IMzDv5SKOuRIRE/19F/8NWzCYke/9/4Yg0nhwXS9e08NKUIKiRN/5fuRfrwC4Ly1eqsiF1iElo2jjsZhkqEyLtJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJpl8eIhVqg9MjGTywUe8u0LjjFHU0kJE4Ce2VJsawI=;
 b=hE9g8lJdoeG9Es6Dy8U5qobyCvYAvbA1fd66t7z2QZHX02euTbOPhJa2eE8EfDIK+UyPA4G4B5qHwDEE7du6nbeoR9G929uS1J2kyTr/ag5BvlmX+aJrpZsb9uFx+bEL2kWNPWULqGcpj5GRrFG+27oXBUQcNUI2EMaRGsPBEr1cQ/8xb7ZlMtviVRZHcQqV/OhRJyFLhzlNmwr/RwWOkUIc+NuQwo59eR3gZ8qz/iF5BYKUjWq+eaRHCUlOBqupMrILPcH7DYaEt0I4NtgFYpe2EJWFFgKTCsaAHjrME8zJUa3Alsz//+zCZFFmWesvj+YVau3dtFx2rhQQpXaYEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9591.eurprd04.prod.outlook.com (2603:10a6:102:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 07:06:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 07:06:40 +0000
Date: Mon, 15 Sep 2025 16:18:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com
Subject: Re: [PATCH v2 4/4] pmdomain: mediatek: Add power domain driver for
 MT8189 SoC
Message-ID: <20250915081811.GF8224@nxa18884-linux.ap.freescale.net>
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
 <20250912120508.3180067-5-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912120508.3180067-5-irving-ch.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: e967a1a7-64f8-4a78-c04b-08ddf4266b2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pNwqsqbcZvwqEdE01C9URR3ABOFtamRTe8BH6SWhdU4CWo/CksbQIJRZE3O?=
 =?us-ascii?Q?a227z2qku1z2yFqe4ktQVIWChtXyjdH1AIAFiwLhW6Ior1i+j8zykPWIR8SA?=
 =?us-ascii?Q?AMGgrSITvuyDkI1ed3NYCNZtLzndabghjXkMYWz3f8HKkTPWLHpAV+gmX11y?=
 =?us-ascii?Q?dvZcGE/AWEfaQ4sEec0VaOTq9SLcpVk/MsB8kVNRU6G7pGiFdnN/1YbDIHmp?=
 =?us-ascii?Q?VyYMG8ibTVkRqL259oEoBktM09tQ1RT8ULHUbhXKQEs2ODbFz0E9kWTIpLai?=
 =?us-ascii?Q?qb3vHNdNmJl+qVnbLsfG778zvIYUtN6Gvb5uWGan1ax6feLPDaet2+skvRUQ?=
 =?us-ascii?Q?QeiFLalLwu2A1R7vsM7rGigjA65eAueV8oVkuiHroXfz6/N71YsGoMkqFApl?=
 =?us-ascii?Q?of1RYVQOjK3UkHjXhIn7TcBp7vX6oLAvvp/t74yPj5H6qnIGyYdoDEJgCa1D?=
 =?us-ascii?Q?Uzn1Ijo+h3D4Njmv6llw189XPrk8HtXOnWadk3r2rj+Tv6vwh9ei42qIDrkn?=
 =?us-ascii?Q?3oVA5L18reT8hcMUaquSL1cs4b80xXEXTRy9cacYBW32Gx89tGkFQqU4z77Y?=
 =?us-ascii?Q?y8ayLgJc67JYiL92EDlSN5CO3wlOQByK63Jqd2Wbdh2g4SP/z2dLj5OL6K2T?=
 =?us-ascii?Q?Zb6mi81khkuOnur+MxA4w668oRfWbYZ8Y3XLOIhnDh7YGdCoAYK/ylkKshMv?=
 =?us-ascii?Q?mro214FDzDhTsZa/Jh98CyRoNElB8pmU+hfN2w6qteMHTWYZqL2f5U443iwc?=
 =?us-ascii?Q?e//+kVCmbbKYwvyC/7UwKxWNvqKw+nVUoXVP50++F907c87AI/JMNCf3AWDE?=
 =?us-ascii?Q?9P49A6DjVAhEInW845yTFpVsG1r55T9zVv/pH5u56NZXUTBVbArk6Cwbqezd?=
 =?us-ascii?Q?Jm2Uy1hZRwgjuV1uFrvrZgKcgVHSu0JqLpH16vgOqeuRvtB8vYMe57PYFdzA?=
 =?us-ascii?Q?JKoKI/pC42yCRevbkQsQgw2/Hc7JIZeo6dXvJOSJd2FscDbwnzafg2SflvrH?=
 =?us-ascii?Q?ck/N9Isv5KN0k9zaxv0VFYB3c9dhQsnVUJXB8q5Mdx+829dBzicZKPNKPdOw?=
 =?us-ascii?Q?GHF+7Bxi8CjHx5jlYdPcx7oK2oxLJB+QVNYDtzhN4LihIg/DcYOb+gf8vHrP?=
 =?us-ascii?Q?LpbpGOAc+WHVb5dxMVvNSYQajxt4mdImukwyYK6reQ90YwMNsVYZ+RlFPcV2?=
 =?us-ascii?Q?aSQ0Lkp7JUSAti8stTYyjK9fwmkgBMWb5L9QEx3u617DJ2coXCowNMMnc2w4?=
 =?us-ascii?Q?ShPGc9xmUt7jvv+ufH13ZdUkynt68fdN+s26CP8n62GisSV5g1bBWhSehW6B?=
 =?us-ascii?Q?cdF/xz0nGTze0OpPE+Hy926GgFN9bcHcrlAMWd8jtO98gw1pjbT6nW/AKvHa?=
 =?us-ascii?Q?OAt2TYq1ksztcy1DmceJ1gXsLXozxL1fsvXe8CWj+Ww6hW02NAENgxmDy7nn?=
 =?us-ascii?Q?T1aKVcJDTL35Ve8d67i1OSJrdv7qRrnd3ZBt7y3cJmYGDEMDzGmNcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UGNrdIcIeT/OGPVPVWWYhRApFutm/T4CSw+LLs7+hjd+m3qdXTflSJyw2Dj?=
 =?us-ascii?Q?RCECKrdr4WEhEX9i4GEXvqWRxZFz5qSB/OwbmmDJJ5JMr/PHZe1FPjTwe3RY?=
 =?us-ascii?Q?z65x+/3y0G52zGjhnJrlmhLa7ON1lDwzq9ufZ2PrazACJWSiSUOmVGLvdVts?=
 =?us-ascii?Q?dkSBi2uyYjmddlRIKX3qCJL3tBIh0ZBGouSSeiI7mbmpE9EYh0UQKB4KZETs?=
 =?us-ascii?Q?X79A+yXutAP13tmfB7N5FKCZPq25zy8Gpm4bzbDBI5TWUAs3MuL2wcZUOLY8?=
 =?us-ascii?Q?uvY+6bp+2N7/qo+aUuspL/vofCFdBGWmlDwf3xr7xZcW0XqqxdwJiArLIcO4?=
 =?us-ascii?Q?Dcn7CwX5jRJQv0G2FXjGsNo9W3E/dNdLJ4SX5vyVbHQug+5ii+fcChgmOXCw?=
 =?us-ascii?Q?DaAGI8cFWi0NJmhRHuTzlGhOjSVuCJZ5KPCtcu0jy4Nbwok27Z2+xrlzU6C1?=
 =?us-ascii?Q?XM6MHUR47xgtYWHt900B6d0EzoGqGe3MpfQ9aEQ0EeSZTrfmQ0cMCgCP52fC?=
 =?us-ascii?Q?AXukquJwWLOtKzv/0ZBJj+VhAJ7MxeaeCuaLz8fX1vZyC/+aa2/owvGYuGxQ?=
 =?us-ascii?Q?J/Glj/NE9vW7i5HgilXIH/yz+LrbMFmWXFcWajSU43aPp8wzLbYIGUIXvPKv?=
 =?us-ascii?Q?rSCUNEWKfQPK7pYKxmDUGq/HZsrFLwpNbWJ0fBhDda9lDFaiNoRrMKpUnNAS?=
 =?us-ascii?Q?Nj4gQiKmPT04snLckw0XbnIJU3t5+jt8QEqCEfYaQk6yKY2FDMCyvyFgLskA?=
 =?us-ascii?Q?0PeMxh8vmXP2igizzQiCJuEmqlyJgU74ahnoJqUvdDfPy9JFO4AwKoVy/e8H?=
 =?us-ascii?Q?keht3JN7A0zOwduy3XXb41MCsFNjtZtAuLqIiWh8LicZ/TRM2mnCM1PNa/F5?=
 =?us-ascii?Q?9n5l6ckslKRmc9IqfKRHg12FDtZmRv2cRAJWbtoFRm8dvDUwS6u7RA2A2p8R?=
 =?us-ascii?Q?AhMAqZE7VIUlpM4D+X9U5U7tzY48AvC8Mkf7OUKpqIm8wUGiM2DwwrIdJKJa?=
 =?us-ascii?Q?fQFpJAErFuwxT/WU1FP+BLD/uzUFe9OPqjg9ogTTW02nrdZWY+jx6t5twFAW?=
 =?us-ascii?Q?iY+V6MjGFb7qzDvWlCtcc2bzrg+VBs1BpUWo6ETClZTO+bAUN+w4KwLC2lCP?=
 =?us-ascii?Q?5vV0cgXe7ZKqkkf5DSyciamxuB2XVm1R/wOcPp8/LeD7s3eAh8pBTX0rHMqS?=
 =?us-ascii?Q?GllZrX1js+ouQTH8yksbGVcSKvKIxp+WglJJl4rH6IcF/Zun+EAyD38loO5a?=
 =?us-ascii?Q?uka47RDM7sMlVKEmYTv8zjkA3CWyDXVGcMSQVL+CG3pKwFg8vhfgH2/9B0kr?=
 =?us-ascii?Q?xH6Tl6RWqXb89qv1bCKRZ00OXnPU8tf8lmf6RwLn6r1MLmlqRf5aRgPCgxCN?=
 =?us-ascii?Q?VM2YH37JbDs5dgvmTz218R5Pav045kXfj2h+MXQSF5M98elTM16LZeoWLmxL?=
 =?us-ascii?Q?yI27k/hyvgDtX+Sd4HapdZWj+swi0ujYJzP4rfs7rVw9IITjJDMA/sdDef3Y?=
 =?us-ascii?Q?Gr+yZcC4r0wdHhrxJTkUmGwyyUFXPY++JqS8oqKnFWgPYCS45w5QplUiqdGt?=
 =?us-ascii?Q?b5Q2oaHw+RQwjQiQrVAEGbso3VsXbF/HUykgAabT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e967a1a7-64f8-4a78-c04b-08ddf4266b2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:06:40.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bz07N0ddDP9T83GrfJRRCfLamkFnpA5S5ETjcI7z7guqZusbJ+ioY4YXrkwbK7tI7upnzZz12knup7NAk29lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9591

On Fri, Sep 12, 2025 at 08:04:53PM +0800, irving.ch.lin wrote:
>From: Irving-ch Lin <irving-ch.lin@mediatek.com>
>
>Introduce a new power domain (pmd) driver for the MediaTek mt8189 SoC.
>This driver ports and refines the power domain framework, dividing
>hardware blocks (CPU, GPU, peripherals, etc.) into independent power
>domains for precise and energy-efficient power management.

This seems also mix cleanup and add new support into one patch.

>
>Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
>---
>+ */
>+#ifndef __PMDOMAIN_MEDIATEK_MT8189_SCPSYS_H
>+#define __PMDOMAIN_MEDIATEK_MT8189_SCPSYS_H
>+
>+#define MT8189_SPM_CONN_PWR_CON			0xe04
>+#define MT8189_SPM_AUDIO_PWR_CON		0xe18
>+#define MT8189_SPM_ADSP_TOP_PWR_CON		0xe1c
...
>+#define MT8189_PROT_EN_MMSYS_STA_1_VDE0			(BIT(13))
>+#define MT8189_PROT_EN_MMSYS_STA_0_VEN0			(BIT(12))
>+#define MT8189_PROT_EN_MMSYS_STA_1_VEN0			(BIT(12))
>+#define MT8189_PROT_EN_PERISYS_STA_0_AUDIO		(BIT(6))
>+#define MT8189_PROT_EN_PERISYS_STA_0_SSUSB		(BIT(7))

Nit: align all the macro definitions.

>+
>+enum {
> #include <dt-bindings/power/mt7623a-power.h>
> #include <dt-bindings/power/mt8173-power.h>
> 
>+#include "mt8189-scpsys.h"
>+
> #define MTK_POLL_DELAY_US   10
> #define MTK_POLL_TIMEOUT    USEC_PER_SEC
>+#define MTK_POLL_TIMEOUT_300MS		(300 * USEC_PER_MSEC)
>+#define MTK_POLL_IRQ_TIMEOUT		USEC_PER_SEC
>+#define MTK_POLL_HWV_PREPARE_CNT	2500
>+#define MTK_POLL_HWV_PREPARE_US		2
>+#define MTK_ACK_DELAY_US		50
>+#define MTK_RTFF_DELAY_US		10
>+#define MTK_STABLE_DELAY_US		100
>+
>+#define MTK_BUS_PROTECTION_RETY_TIMES	10
> 
> #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
> #define MTK_SCPD_FWAIT_SRAM		BIT(1)
>+#define MTK_SCPD_SRAM_ISO		BIT(2)
>+#define MTK_SCPD_SRAM_SLP		BIT(3)
>+#define MTK_SCPD_BYPASS_INIT_ON		BIT(4)
>+#define MTK_SCPD_IS_PWR_CON_ON		BIT(5)
>+#define MTK_SCPD_HWV_OPS		BIT(6)
>+#define MTK_SCPD_NON_CPU_RTFF		BIT(7)
>+#define MTK_SCPD_PEXTP_PHY_RTFF		BIT(8)
>+#define MTK_SCPD_UFS_RTFF		BIT(9)
>+#define MTK_SCPD_RTFF_DELAY		BIT(10)
>+#define MTK_SCPD_IRQ_SAVE		BIT(11)
>+#define MTK_SCPD_ALWAYS_ON		BIT(12)
>+#define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(13)
> #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
> 
> #define SPM_VDE_PWR_CON			0x0210
>@@ -56,6 +82,15 @@
> #define PWR_ON_BIT			BIT(2)
> #define PWR_ON_2ND_BIT			BIT(3)
> #define PWR_CLK_DIS_BIT			BIT(4)
>+#define PWR_SRAM_CLKISO_BIT		BIT(5)
>+#define PWR_SRAM_ISOINT_B_BIT		BIT(6)
>+#define PWR_RTFF_SAVE			BIT(24)
>+#define PWR_RTFF_NRESTORE		BIT(25)
>+#define PWR_RTFF_CLK_DIS		BIT(26)
>+#define PWR_RTFF_SAVE_FLAG		BIT(27)
>+#define PWR_RTFF_UFS_CLK_DIS		BIT(28)
>+#define PWR_ACK				BIT(30)
>+#define PWR_ACK_2ND			BIT(31)

Align the code

> 
> #define PWR_STATUS_CONN			BIT(1)
> #define PWR_STATUS_DISP			BIT(3)
>@@ -78,10 +113,39 @@
> #define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
> #define PWR_STATUS_WB			BIT(27)	/* MT7622 */
> 
>+#define _BUS_PROT(_type, _set_ofs, _clr_ofs,			\
>+		_en_ofs, _sta_ofs, _mask, _ack_mask,		\
>+		_ignore_clr_ack, _ignore_subsys_clk) {		\
>+		.type = _type,					\
>+		.set_ofs = _set_ofs,				\
>+		.clr_ofs = _clr_ofs,				\
>+		.en_ofs = _en_ofs,				\
>+		.sta_ofs = _sta_ofs,				\
>+		.mask = _mask,					\
>+		.ack_mask = _ack_mask,				\
>+		.ignore_clr_ack = _ignore_clr_ack,		\
>+		.ignore_subsys_clk = _ignore_subsys_clk,		\
>+	}
>+
>+#define BUS_PROT_IGN(_type, _set_ofs, _clr_ofs,	\
>+		_en_ofs, _sta_ofs, _mask)		\
>+		_BUS_PROT(_type, _set_ofs, _clr_ofs,	\
>+		_en_ofs, _sta_ofs, _mask, _mask, true, false)
>+
>+#define BUS_PROT_SUBSYS_CLK_IGN(_type, _set_ofs, _clr_ofs,	\
>+		_en_ofs, _sta_ofs, _mask)		\
>+		_BUS_PROT(_type, _set_ofs, _clr_ofs,	\
>+		_en_ofs, _sta_ofs, _mask, _mask, true, true)
>+
>+#define TEST_BP_ACK(bp, val)	((val & bp->ack_mask) == bp->ack_mask)
>+#define scpsys_get_infracfg(pdev)	\
>+	syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "infracfg")

There are some mix usage, one place use this marco, others places
use the API. not understand why introducing this macro.

>+
> enum clk_id {
> 	CLK_NONE,
> 	CLK_MM,
> 	CLK_MFG,
>+	CLK_MFG_TOP,
> 	CLK_VENC,
> 	CLK_VENC_LT,
> 	CLK_ETHIF,
>@@ -89,6 +153,9 @@ enum clk_id {
> 	CLK_HIFSEL,
> 	CLK_JPGDEC,
> 	CLK_AUDIO,
>+	CLK_DISP_AO_CONFIG,
>+	CLK_DISP_DPC,
>+	CLK_MDP,
> 	CLK_MAX,
> };
> 
>@@ -96,6 +163,7 @@ static const char * const clk_names[] = {
> 	NULL,
> 	"mm",
> 	"mfg",
>+	"mfg_top",
> 	"venc",
> 	"venc_lt",
> 	"ethif",
>@@ -103,10 +171,27 @@ static const char * const clk_names[] = {
> 	"hif_sel",
> 	"jpgdec",
> 	"audio",
>+	"disp_ao_config",
>+	"disp_dpc",
>+	"mdp",
> 	NULL,
> };
> 
> #define MAX_CLKS	3
>+#define MAX_STEPS	4
>+#define MAX_SUBSYS_CLKS 20
>+
>+struct bus_prot {
>+	u32 type;
>+	u32 set_ofs;
>+	u32 clr_ofs;
>+	u32 en_ofs;
>+	u32 sta_ofs;
>+	u32 mask;
>+	u32 ack_mask;
>+	bool ignore_clr_ack;
>+	bool ignore_subsys_clk;
>+};
> 
> /**
>  * struct scp_domain_data - scp domain data for power on/off flow
>@@ -115,8 +200,12 @@ static const char * const clk_names[] = {
>  * @ctl_offs: The offset for main power control register.
>  * @sram_pdn_bits: The mask for sram power control bits.
>  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>+ * @sram_slp_bits: The mask for sram sleep control bits.
>+ * @sram_slp_ack_bits: The mask for sram sleep control acked bits.
>  * @bus_prot_mask: The mask for single step bus protection.
>  * @clk_id: The basic clocks required by this power domain.
>+ * @subsys_clk_prefix: Clock names need to enable before access this subsys.
>+ * @bp_table: Bus protection table for this power domain.
>  * @caps: The flag for active wake-up action.
>  */
> struct scp_domain_data {
>@@ -125,9 +214,13 @@ struct scp_domain_data {
> 	int ctl_offs;
> 	u32 sram_pdn_bits;
> 	u32 sram_pdn_ack_bits;
>+	u32 sram_slp_bits;
>+	u32 sram_slp_ack_bits;
> 	u32 bus_prot_mask;
> 	enum clk_id clk_id[MAX_CLKS];
>-	u8 caps;
>+	const char *subsys_clk_prefix;
>+	struct bus_prot bp_table[MAX_STEPS];
>+	u32 caps;
> };
> 
> struct scp;
>@@ -136,8 +229,11 @@ struct scp_domain {
> 	struct generic_pm_domain genpd;
> 	struct scp *scp;
> 	struct clk *clk[MAX_CLKS];
>+	struct clk *subsys_clk[MAX_SUBSYS_CLKS];
> 	const struct scp_domain_data *data;
> 	struct regulator *supply;
>+	bool rtff_flag;
>+	bool boot_status;
> };
> 
> struct scp_ctrl_reg {
>@@ -153,6 +249,8 @@ struct scp {
> 	struct regmap *infracfg;
> 	struct scp_ctrl_reg ctrl_reg;
> 	bool bus_prot_reg_update;
>+	struct regmap **bp_regmap;
>+	int num_bp;
> };
> 
> struct scp_subdomain {
>@@ -167,6 +265,8 @@ struct scp_soc_data {
> 	int num_subdomains;
> 	const struct scp_ctrl_reg regs;
> 	bool bus_prot_reg_update;
>+	const char **bp_list;
>+	int num_bp;
> };
> 
> static int scpsys_domain_is_on(struct scp_domain *scpd)
>@@ -191,6 +291,21 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
> 	return -EINVAL;
> }
> 
>+static bool scpsys_pwr_ack_is_on(struct scp_domain *scpd)
>+{
>+	u32 status = readl(scpd->scp->base + scpd->data->ctl_offs) & PWR_ACK;
>+
>+	return status ? true : false;
>+}
>+
>+static bool scpsys_pwr_ack_2nd_is_on(struct scp_domain *scpd)
>+{
>+	u32 status = readl(scpd->scp->base + scpd->data->ctl_offs) &
>+		     PWR_ACK_2ND;
>+
>+	return status ? true : false;
>+}
>+
> static int scpsys_regulator_enable(struct scp_domain *scpd)
> {
> 	if (!scpd->supply)
>@@ -233,11 +348,19 @@ static int scpsys_clk_enable(struct clk *clk[], int max_num)
> static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
> {
> 	u32 val;
>-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>+	u32 ack_mask, ack_sta;
> 	int tmp;
> 
>-	val = readl(ctl_addr);
>-	val &= ~scpd->data->sram_pdn_bits;
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_SLP)) {
>+		ack_mask = scpd->data->sram_slp_ack_bits;
>+		ack_sta = ack_mask;
>+		val = readl(ctl_addr) | scpd->data->sram_slp_bits;
>+	} else {
>+		ack_mask = scpd->data->sram_pdn_ack_bits;
>+		ack_sta = 0;
>+		val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
>+	}
>+
> 	writel(val, ctl_addr);
> 
> 	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
>@@ -251,35 +374,184 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
> 	} else {
> 		/* Either wait until SRAM_PDN_ACK all 1 or 0 */
> 		int ret = readl_poll_timeout(ctl_addr, tmp,
>-				(tmp & pdn_ack) == 0,
>+				(tmp & ack_mask) == ack_sta,
> 				MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> 		if (ret < 0)
> 			return ret;
> 	}
> 
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO)) {
>+		val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
>+		writel(val, ctl_addr);
>+		udelay(1);

Add a comment on why delay 1us.

>+		val &= ~PWR_SRAM_CLKISO_BIT;
>+		writel(val, ctl_addr);
>+	}
>+
> 	return 0;
> }
> 
> static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
> {
> 	u32 val;
>-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>+	u32 ack_mask, ack_sta;
> 	int tmp;
> 
>-	val = readl(ctl_addr);
>-	val |= scpd->data->sram_pdn_bits;
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO)) {
>+		val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;
>+		writel(val, ctl_addr);
>+		val &= ~PWR_SRAM_ISOINT_B_BIT;
>+		writel(val, ctl_addr);
>+		udelay(1);

Ditto.

>+	}
>+
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_SLP)) {
>+		ack_mask = scpd->data->sram_slp_ack_bits;
>+		ack_sta = 0;
>+		val = readl(ctl_addr) & ~scpd->data->sram_slp_bits;
>+	} else {
>+		ack_mask = scpd->data->sram_pdn_ack_bits;
>+		ack_sta = ack_mask;
>+		val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
>+	}
> 	writel(val, ctl_addr);
> 
> 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
> 	return readl_poll_timeout(ctl_addr, tmp,
>-			(tmp & pdn_ack) == pdn_ack,
>+			(tmp & ack_mask) == ack_sta,
> 			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> }
> 
>-static int scpsys_bus_protect_enable(struct scp_domain *scpd)
>+static int set_bus_protection(struct regmap *map, struct bus_prot *bp)
>+{
>+	u32 val = 0;
>+	int retry = 0;
>+	int ret = 0;
>+
>+	while (retry <= MTK_BUS_PROTECTION_RETY_TIMES) {
>+		if (bp->set_ofs)
>+			regmap_write(map,  bp->set_ofs, bp->mask);
>+		else
>+			regmap_update_bits(map, bp->en_ofs,
>+					   bp->mask, bp->mask);
>+
>+		/* check bus protect enable setting */
>+		regmap_read(map, bp->en_ofs, &val);
>+		if ((val & bp->mask) == bp->mask)
>+			break;
>+
>+		retry++;
>+	}
>+
>+	ret = regmap_read_poll_timeout_atomic(map, bp->sta_ofs, val,

Could non atomic version be used?

>+					      TEST_BP_ACK(bp, val),
>+					      MTK_POLL_DELAY_US,
>+					      MTK_POLL_TIMEOUT);
>+	if (ret < 0) {
>+		pr_err("%s val=0x%x, mask=0x%x, (val & mask)=0x%x\n",
>+		       __func__, val, bp->ack_mask, (val & bp->ack_mask));
>+	}
>+
>+	return ret;
>+}
>+
>+static int clear_bus_protection(struct regmap *map, struct bus_prot *bp)
>+{
>+	u32 val = 0;
>+	int ret = 0;
>+
>+	if (bp->clr_ofs)
>+		regmap_write(map, bp->clr_ofs, bp->mask);
>+	else
>+		regmap_update_bits(map, bp->en_ofs, bp->mask, 0);
>+
>+	if (bp->ignore_clr_ack)
>+		return 0;
>+
>+	ret = regmap_read_poll_timeout_atomic(map, bp->sta_ofs, val,

Ditto.

>+					      !(val & bp->ack_mask),
>+					      MTK_POLL_DELAY_US,
>+					      MTK_POLL_TIMEOUT);
>+	if (ret < 0) {
>+		pr_err("%s val=0x%x, mask=0x%x, (val & mask)=0x%x\n",
>+		       __func__, val, bp->ack_mask, (val & bp->ack_mask));
>+	}
>+	return ret;
>+}
>+
>+static int scpsys_bus_protect_table_disable(struct scp_domain *scpd,
>+					    unsigned int index,
>+					    bool ignore_subsys_clk)
>+{
>+	struct scp *scp = scpd->scp;
>+	const struct bus_prot *bp_table = scpd->data->bp_table;
>+	int ret = 0;
>+	int i;
>+
>+	for (i = index; i >= 0; i--) {
>+		struct regmap *map;
>+		struct bus_prot bp = bp_table[i];
>+
>+		if (bp.type == 0 || bp.type >= scp->num_bp)
>+			continue;
>+
>+		if (ignore_subsys_clk != bp.ignore_subsys_clk)
>+			continue;
>+
>+		map = scp->bp_regmap[bp.type];
>+		if (!map)
>+			continue;
>+
>+		ret = clear_bus_protection(map, &bp);
>+		if (ret)
>+			break;
>+	}
>+
>+	return ret;
>+}
>+
>+static int scpsys_bus_protect_table_enable(struct scp_domain *scpd,
>+					   bool ignore_subsys_clk)
>+{
>+	struct scp *scp = scpd->scp;
>+	const struct bus_prot *bp_table = scpd->data->bp_table;
>+	int ret = 0;
>+	int i;
>+
>+	for (i = 0; i < MAX_STEPS; i++) {
>+		struct regmap *map;
>+		struct bus_prot bp = bp_table[i];
>+
>+		if (bp.type == 0 || bp.type >= scp->num_bp)
>+			continue;
>+
>+		if (ignore_subsys_clk != bp.ignore_subsys_clk)
>+			continue;
>+
>+		map = scp->bp_regmap[bp.type];
>+		if (!map)
>+			continue;
>+
>+		ret = set_bus_protection(map, &bp);
>+		if (ret) {
>+			scpsys_bus_protect_table_disable(scpd, i,
>+							 ignore_subsys_clk);
>+			return ret;
>+		}
>+	}
>+
>+	return ret;
>+}
>+
>+static int scpsys_bus_protect_enable(struct scp_domain *scpd,
>+				     bool ignore_subsys_clk)
> {
> 	struct scp *scp = scpd->scp;
> 
>+	if (scp->bp_regmap && scp->num_bp > 0)
>+		return scpsys_bus_protect_table_enable(scpd,
>+						       ignore_subsys_clk);
>+
> 	if (!scpd->data->bus_prot_mask)
> 		return 0;
> 
>@@ -288,10 +560,15 @@ static int scpsys_bus_protect_enable(struct scp_domain *scpd)
> 			scp->bus_prot_reg_update);
> }
> 
>-static int scpsys_bus_protect_disable(struct scp_domain *scpd)
>+static int scpsys_bus_protect_disable(struct scp_domain *scpd,
>+				      bool ignore_subsys_clk)
> {
> 	struct scp *scp = scpd->scp;
> 
>+	if (scp->bp_regmap && scp->num_bp > 0)
>+		return scpsys_bus_protect_table_disable(scpd, MAX_STEPS - 1,
>+							ignore_subsys_clk);
>+
> 	if (!scpd->data->bus_prot_mask)
> 		return 0;
> 
>@@ -307,6 +584,11 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> 	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> 	u32 val;
> 	int ret, tmp;
>+	bool pwr_ack;
>+
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_KEEP_DEFAULT_OFF) &&
>+	    !scpd->boot_status)
>+		return 0;
> 
> 	ret = scpsys_regulator_enable(scpd);
> 	if (ret < 0)
>@@ -320,34 +602,121 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> 	val = readl(ctl_addr);
> 	val |= PWR_ON_BIT;
> 	writel(val, ctl_addr);
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON)) {
>+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_is_on,

Ditto.

>+						scpd, pwr_ack, pwr_ack,
>+						MTK_POLL_DELAY_US,
>+						MTK_POLL_TIMEOUT);
>+		if (ret < 0)
>+			goto err_pwr_ack;
>+
>+		udelay(MTK_ACK_DELAY_US);
>+	}
>+
> 	val |= PWR_ON_2ND_BIT;
> 	writel(val, ctl_addr);
> 
> 	/* wait until PWR_ACK = 1 */
>-	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
>-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
>+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_2nd_is_on,

Ditto.

>+						scpd, pwr_ack, pwr_ack,
>+						MTK_POLL_DELAY_US,
>+						MTK_POLL_TIMEOUT);
>+	else
>+		ret = readx_poll_timeout(scpsys_domain_is_on,
>+					 scpd, tmp, tmp > 0,
>+					 MTK_POLL_DELAY_US,
>+					 MTK_POLL_TIMEOUT);
> 	if (ret < 0)
> 		goto err_pwr_ack;
> 
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF) && scpd->rtff_flag) {
>+		val |= PWR_RTFF_CLK_DIS;
>+		writel(val, ctl_addr);
>+	}
>+
> 	val &= ~PWR_CLK_DIS_BIT;
> 	writel(val, ctl_addr);
> 
> 	val &= ~PWR_ISO_BIT;
> 	writel(val, ctl_addr);
> 
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_RTFF_DELAY) && scpd->rtff_flag)
>+		udelay(MTK_RTFF_DELAY_US);
>+
> 	val |= PWR_RST_B_BIT;
> 	writel(val, ctl_addr);
> 
>-	ret = scpsys_sram_enable(scpd, ctl_addr);
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_NON_CPU_RTFF)) {
>+		val = readl(ctl_addr);
>+		if (val & PWR_RTFF_SAVE_FLAG) {
>+			val &= ~PWR_RTFF_SAVE_FLAG;
>+			writel(val, ctl_addr);
>+
>+			val |= PWR_RTFF_CLK_DIS;
>+			writel(val, ctl_addr);
>+
>+			val &= ~PWR_RTFF_NRESTORE;
>+			writel(val, ctl_addr);
>+
>+			val |= PWR_RTFF_NRESTORE;
>+			writel(val, ctl_addr);
>+
>+			val &= ~PWR_RTFF_CLK_DIS;
>+			writel(val, ctl_addr);
>+		}
>+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF)) {
>+		val = readl(ctl_addr);
>+		if (val & PWR_RTFF_SAVE_FLAG) {
>+			val &= ~PWR_RTFF_SAVE_FLAG;
>+			writel(val, ctl_addr);
>+
>+			val &= ~PWR_RTFF_NRESTORE;
>+			writel(val, ctl_addr);
>+
>+			val |= PWR_RTFF_NRESTORE;
>+			writel(val, ctl_addr);
>+
>+			val &= ~PWR_RTFF_CLK_DIS;
>+			writel(val, ctl_addr);
>+		}
>+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF) &&
>+		   scpd->rtff_flag) {
>+		val |= PWR_RTFF_UFS_CLK_DIS;
>+		writel(val, ctl_addr);
>+
>+		val &= ~PWR_RTFF_NRESTORE;
>+		writel(val, ctl_addr);
>+
>+		val |= PWR_RTFF_NRESTORE;
>+		writel(val, ctl_addr);
>+
>+		val &= ~PWR_RTFF_UFS_CLK_DIS;
>+		writel(val, ctl_addr);
>+
>+		scpd->rtff_flag = false;
>+	}
>+
>+	ret = scpsys_bus_protect_disable(scpd, true);
> 	if (ret < 0)
> 		goto err_pwr_ack;
> 
>-	ret = scpsys_bus_protect_disable(scpd);
>+	ret = scpsys_clk_enable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> 	if (ret < 0)
> 		goto err_pwr_ack;
> 
>+	ret = scpsys_sram_enable(scpd, ctl_addr);
>+	if (ret < 0)
>+		goto err_sram_enable;
>+
>+	ret = scpsys_bus_protect_disable(scpd, false);
>+	if (ret < 0)
>+		goto err_sram_enable;
>+
> 	return 0;
> 
>+err_sram_enable:
>+	scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> err_pwr_ack:
> 	scpsys_clk_disable(scpd->clk, MAX_CLKS);
> err_clk:
>@@ -365,8 +734,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> 	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> 	u32 val;
> 	int ret, tmp;
>+	bool pwr_ack;
> 
>-	ret = scpsys_bus_protect_enable(scpd);
>+	ret = scpsys_bus_protect_enable(scpd, false);
> 	if (ret < 0)
> 		goto out;
> 
>@@ -374,11 +744,53 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> 	if (ret < 0)
> 		goto out;
> 
>+	scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>+
>+	ret = scpsys_bus_protect_enable(scpd, true);
>+	if (ret < 0)
>+		goto out;
>+
> 	/* subsys power off */
> 	val = readl(ctl_addr);
>+
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_NON_CPU_RTFF) ||
>+	    MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF)) {
>+		val |= PWR_RTFF_CLK_DIS;
>+		writel(val, ctl_addr);
>+
>+		val |= PWR_RTFF_SAVE;
>+		writel(val, ctl_addr);
>+
>+		val &= ~PWR_RTFF_SAVE;
>+		writel(val, ctl_addr);
>+
>+		val &= ~PWR_RTFF_CLK_DIS;
>+		writel(val, ctl_addr);
>+
>+		val |= PWR_RTFF_SAVE_FLAG;
>+		writel(val, ctl_addr);
>+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF)) {
>+		val |= PWR_RTFF_UFS_CLK_DIS;
>+		writel(val, ctl_addr);
>+
>+		val |= PWR_RTFF_SAVE;
>+		writel(val, ctl_addr);
>+
>+		val &= ~PWR_RTFF_SAVE;
>+		writel(val, ctl_addr);
>+
>+		val &= ~PWR_RTFF_UFS_CLK_DIS;
>+		writel(val, ctl_addr);
>+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF))
>+			scpd->rtff_flag = true;
>+	}
>+
> 	val |= PWR_ISO_BIT;
> 	writel(val, ctl_addr);
> 
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_RTFF_DELAY) && scpd->rtff_flag)
>+		udelay(1);

Add comment on delay 1us.

>+
> 	val &= ~PWR_RST_B_BIT;
> 	writel(val, ctl_addr);
> 
>@@ -388,12 +800,29 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> 	val &= ~PWR_ON_BIT;
> 	writel(val, ctl_addr);
> 
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON)) {
>+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_is_on,

Non atomic version?

>+						scpd, pwr_ack, !pwr_ack,
>+						MTK_POLL_DELAY_US,
>+						MTK_POLL_TIMEOUT);
>+		if (ret < 0)
>+			goto out;
>+	}
>+
> 	val &= ~PWR_ON_2ND_BIT;
> 	writel(val, ctl_addr);
> 
> 	/* wait until PWR_ACK = 0 */
>-	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
>-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
>+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_2nd_is_on,
>+						scpd, pwr_ack, !pwr_ack,
>+						MTK_POLL_DELAY_US,
>+						MTK_POLL_TIMEOUT);
>+	else
>+		ret = readx_poll_timeout(scpsys_domain_is_on,
>+					 scpd, tmp, tmp == 0,
>+					 MTK_POLL_DELAY_US,
>+					 MTK_POLL_TIMEOUT);
> 	if (ret < 0)
> 		goto out;
> 
>@@ -419,54 +848,145 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> }
> 
>+static int init_subsys_clks(struct platform_device *pdev,
>+			    const char *prefix, struct clk **clk)
>+{
>+	struct device_node *node = pdev->dev.of_node;
>+	u32 prefix_len, sub_clk_cnt = 0;
>+	struct property *prop;
>+	const char *clk_name;
>+
>+	if (!node) {
>+		dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
>+			PTR_ERR(node));
>+		return PTR_ERR(node);
>+	}
>+
>+	prefix_len = strlen(prefix);
>+
>+	of_property_for_each_string(node, "clock-names", prop, clk_name) {
>+		if (!strncmp(clk_name, prefix, prefix_len) &&
>+		    (strlen(clk_name) > prefix_len + 1) &&
>+		    (clk_name[prefix_len] == '-')) {
>+			if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
>+				dev_err(&pdev->dev,
>+					"subsys clk out of range %d\n",
>+					sub_clk_cnt);
>+				return -EINVAL;
>+			}
>+
>+			clk[sub_clk_cnt] = devm_clk_get(&pdev->dev, clk_name);
>+
>+			if (IS_ERR(clk[sub_clk_cnt])) {
>+				dev_err(&pdev->dev,
>+					"Subsys clk get fail %ld\n",
>+					PTR_ERR(clk[sub_clk_cnt]));
>+				return PTR_ERR(clk[sub_clk_cnt]);
>+			}
>+			sub_clk_cnt++;
>+		}
>+	}
>+
>+	return sub_clk_cnt;
>+}
>+
>+static int mtk_pd_get_regmap(struct platform_device *pdev,
>+			     struct regmap **regmap,
>+			     const char *name)
>+{
>+	*regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, name);
>+	if (PTR_ERR(*regmap) == -ENODEV) {
>+		dev_notice(&pdev->dev, "%s regmap is null(%ld)\n",
>+			   name, PTR_ERR(*regmap));
>+		*regmap = NULL;
>+	} else if (IS_ERR(*regmap)) {
>+		dev_notice(&pdev->dev, "Cannot find %s controller: %ld\n",
>+			   name, PTR_ERR(*regmap));
>+		return PTR_ERR(*regmap);
>+	}
>+
>+	return 0;
>+}
>+
>+static bool scpsys_get_boot_status(struct scp_domain *scpd)
>+{
>+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
>+		return scpsys_pwr_ack_is_on(scpd) &&
>+		       scpsys_pwr_ack_2nd_is_on(scpd);
>+	return (scpsys_domain_is_on(scpd) > 0) ? true : false;
>+}
>+
> static struct scp *init_scp(struct platform_device *pdev,
>-			const struct scp_domain_data *scp_domain_data, int num,
>-			const struct scp_ctrl_reg *scp_ctrl_reg,
>-			bool bus_prot_reg_update)
>+		     const struct scp_soc_data *soc)

Align. scripts/checkpatch.pl should be able to report the warnings.

> {
> 	struct genpd_onecell_data *pd_data;
>+	struct resource *res;
> 	int i, j;
> 	struct scp *scp;
> 	struct clk *clk[CLK_MAX];
>+	int ret;
> 
> 	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
> 	if (!scp)
> 		return ERR_PTR(-ENOMEM);
> 
>-	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
>-	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
>+	scp->ctrl_reg.pwr_sta_offs = soc->regs.pwr_sta_offs;
>+	scp->ctrl_reg.pwr_sta2nd_offs = soc->regs.pwr_sta2nd_offs;
> 
>-	scp->bus_prot_reg_update = bus_prot_reg_update;
>+	scp->bus_prot_reg_update = soc->bus_prot_reg_update;
> 
> 	scp->dev = &pdev->dev;
> 
>-	scp->base = devm_platform_ioremap_resource(pdev, 0);
>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>+	scp->base = devm_ioremap_resource(&pdev->dev, res);

Not sure why change this. The same range are also mapped by others?


> 	if (IS_ERR(scp->base))
> 		return ERR_CAST(scp->base);
> 
>-	scp->domains = devm_kcalloc(&pdev->dev,
>-				num, sizeof(*scp->domains), GFP_KERNEL);
>+	scp->domains = devm_kcalloc(&pdev->dev, soc->num_domains,
>+				    sizeof(*scp->domains), GFP_KERNEL);
> 	if (!scp->domains)
> 		return ERR_PTR(-ENOMEM);
> 
> 	pd_data = &scp->pd_data;
> 
>-	pd_data->domains = devm_kcalloc(&pdev->dev,
>-			num, sizeof(*pd_data->domains), GFP_KERNEL);
>+	pd_data->domains = devm_kcalloc(&pdev->dev, soc->num_domains,
>+					sizeof(*pd_data->domains),
>+					GFP_KERNEL);
> 	if (!pd_data->domains)
> 		return ERR_PTR(-ENOMEM);
> 
>-	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>-			"infracfg");
>-	if (IS_ERR(scp->infracfg)) {
>-		dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
>+	if (soc->bp_list && soc->num_bp > 0) {
>+		scp->num_bp = soc->num_bp;
>+		scp->bp_regmap = devm_kcalloc(&pdev->dev, scp->num_bp,
>+					      sizeof(*scp->bp_regmap),
>+					      GFP_KERNEL);
>+		if (!scp->bp_regmap)
>+			return ERR_PTR(-ENOMEM);
>+
>+		/*
>+		 * get bus prot regmap from dts node,
>+		 * 0 means invalid bus type
>+		 */
>+		for (i = 1; i < scp->num_bp; i++) {
>+			ret = mtk_pd_get_regmap(pdev, &scp->bp_regmap[i],
>+						soc->bp_list[i]);
>+			if (ret)
>+				return ERR_PTR(ret);
>+		}
>+	} else {
>+		scp->infracfg = scpsys_get_infracfg(pdev);
>+
>+		if (IS_ERR(scp->infracfg)) {
>+			dev_err(&pdev->dev,
>+				"Cannot find infracfg controller: %ld\n",
> 				PTR_ERR(scp->infracfg));
>-		return ERR_CAST(scp->infracfg);
>+			return ERR_CAST(scp->infracfg);
>+		}
> 	}
> 
>-	for (i = 0; i < num; i++) {
>+	for (i = 0; i < soc->num_domains; i++) {
> 		struct scp_domain *scpd = &scp->domains[i];
>-		const struct scp_domain_data *data = &scp_domain_data[i];
>+		const struct scp_domain_data *data = &soc->domains[i];
> 
> 		scpd->supply = devm_regulator_get_optional(&pdev->dev, data->name);
> 		if (IS_ERR(scpd->supply)) {
>@@ -477,14 +997,14 @@ static struct scp *init_scp(struct platform_device *pdev,
> 		}
> 	}
> 
>-	pd_data->num_domains = num;
>+	pd_data->num_domains = soc->num_domains;
> 
> 	init_clks(pdev, clk);
> 
>-	for (i = 0; i < num; i++) {
>+	for (i = 0; i < soc->num_domains; i++) {
> 		struct scp_domain *scpd = &scp->domains[i];
> 		struct generic_pm_domain *genpd = &scpd->genpd;
>-		const struct scp_domain_data *data = &scp_domain_data[i];
>+		const struct scp_domain_data *data = &soc->domains[i];
> 
> 		pd_data->domains[i] = genpd;
> 		scpd->scp = scp;
>@@ -503,11 +1023,26 @@ static struct scp *init_scp(struct platform_device *pdev,
> 			scpd->clk[j] = c;
> 		}
> 
>+		if (data->subsys_clk_prefix) {
>+			ret = init_subsys_clks(pdev,
>+					       data->subsys_clk_prefix,
>+					       scpd->subsys_clk);
>+			if (ret < 0) {
>+				dev_notice(&pdev->dev,
>+					   "%s: subsys clk unavailable\n",
>+					   data->name);
>+				return ERR_PTR(ret);
>+			}
>+		}
> 		genpd->name = data->name;
> 		genpd->power_off = scpsys_power_off;
> 		genpd->power_on = scpsys_power_on;
> 		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
> 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IRQ_SAVE))
>+			genpd->flags |= GENPD_FLAG_IRQ_SAFE;
>+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ALWAYS_ON))
>+			genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> 	}
> 
> 	return scp;
>@@ -530,8 +1065,17 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> 		 * software.  The unused domains will be switched off during
> 		 * late_init time.
> 		 */
>-		on = !WARN_ON(genpd->power_on(genpd) < 0);
>-
>+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
>+			scpd->boot_status = scpsys_get_boot_status(scpd);
>+			if (scpd->boot_status)
>+				on = !WARN_ON(genpd->power_on(genpd) < 0);
>+			else
>+				on = false;
>+		} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_BYPASS_INIT_ON)) {
>+			on = false;
>+		} else {
>+			on = !WARN_ON(genpd->power_on(genpd) < 0);
>+		}
> 		pm_genpd_init(genpd, NULL, !on);
> 	}
> 
>@@ -1009,6 +1553,328 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
> 	{MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
> };
> 
>+/*
>+ * MT8189 power domain support
>+ */
>+static const char *mt8189_bus_list[MT8189_BUS_TYPE_NUM] = {
>+	[MT8189_BP_IFR_TYPE] = "infra-infracfg-ao-reg-bus",
>+	[MT8189_BP_VLP_TYPE] = "vlpcfg-reg-bus",
>+	[MT8189_VLPCFG_REG_TYPE] = "vlpcfg-reg-bus",
>+	[MT8189_EMICFG_AO_MEM_TYPE] = "emicfg-ao-mem",
>+};
>+
>+static const struct scp_domain_data scp_domain_mt8189_spm_data[] = {
>+	[MT8189_POWER_DOMAIN_CONN] = {
>+		.name = "conn",
>+		.ctl_offs = MT8189_SPM_CONN_PWR_CON,
>+		.bp_table = {
>+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
>+				     0x0c94, 0x0c98, 0x0c90, 0x0c9c,
>+				     MT8189_PROT_EN_MCU_STA_0_CONN),
>+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
>+				     0x0c54, 0x0c58, 0x0c50, 0x0c5c,
>+				     MT8189_PROT_EN_INFRASYS_STA_1_CONN),
>+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
>+				     0x0c94, 0x0c98, 0x0c90, 0x0c9c,
>+				     MT8189_PROT_EN_MCU_STA_0_CONN_2ND),
>+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
>+				     0x0c44, 0x0c48, 0x0c40, 0x0c4c,
>+				     MT8189_PROT_EN_INFRASYS_STA_0_CONN),
>+		},
>+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
>+	},
>+	[MT8189_POWER_DOMAIN_AUDIO] = {
>+		.name = "audio",
>+		.ctl_offs = MT8189_SPM_AUDIO_PWR_CON,
>+		.sram_pdn_bits = GENMASK(8, 8),
>+		.sram_pdn_ack_bits = GENMASK(12, 12),

You could use BIT, same applied the below GENMASK usage.

>+		.bp_table = {
>+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
>+				     0x0c84, 0x0c88, 0x0c80, 0x0c8c,
>+				     MT8189_PROT_EN_PERISYS_STA_0_AUDIO),
>+		},
>+		.clk_id = {CLK_AUDIO},
>+		.caps = MTK_SCPD_IS_PWR_CON_ON,
>+	},
> /*
>  * scpsys driver init
>  */
>@@ -1098,6 +1977,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
> 	}, {
> 		.compatible = "mediatek,mt8173-scpsys",
> 		.data = &mt8173_data,
>+	}, {
>+		.compatible = "mediatek,mt8189-scpsys",
>+		.data = &mt8189_spm_data,
> 	}, {
> 		/* sentinel */
> 	}
>@@ -1113,8 +1995,7 @@ static int scpsys_probe(struct platform_device *pdev)
> 
> 	soc = of_device_get_match_data(&pdev->dev);
> 
>-	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
>-			soc->bus_prot_reg_update);
>+	scp = init_scp(pdev, soc);

In the end, better separate your changes into small patches, mix cleanup
and new support is not easy to review.

Regards
Peng

