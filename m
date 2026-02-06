Return-Path: <linux-pm+bounces-42189-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COhABnVIhWkN/QMAu9opvQ
	(envelope-from <linux-pm+bounces-42189-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 02:48:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E0F90E2
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 02:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9663018288
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 01:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0924A044;
	Fri,  6 Feb 2026 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oICE/4xv"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE30246766;
	Fri,  6 Feb 2026 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342416; cv=fail; b=X4q19gkzu26/K6ahZBhsSV1oC6f+dcuspZPVdo9GNBY5jivEvJky7TUVNO9odEED6MwcXPEXJnkXKGXO/4RCGg4VGqJU6gEyk9gVmGdK1HUudsaajzdAusRNrb4Z3z+FJtT71gJ72ehZTtzh7q5Loh/3er99hAT8BjIp2mjna/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342416; c=relaxed/simple;
	bh=vJELBGo7MsmkR/GUvkDta1TFDQDjrbVz376ELQhqKwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QP7fmCqWUctvEEvMMuAVoiiQGEGzkl8lRHiCRV1cRL9UUSTQ/pa5L3o9QTaIl5Sz7a+hTHXbrDfUdCc5E9t0xsa/+NTBCGQg/NzNBNi3RAlWNA/4u90hgsp8Yb6ftZCqXSoy2GT7XCPh//dOQt8RamrJSXpvQe2q65XAcx3TRX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oICE/4xv; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5iLoGmGcujTvej6/kn68Ck6IVVYBLry41fsgxP3iVJwhGJ+9b8EXBJ/ZGKo+aXczPovi0KSRPjMRzdW/EZ3OPmsa+DbNtSBna3o4TOB1dzCsbpTqdPYt2ZUTY4+RVptrYWLnbmG01qyx4j6TuAiRqSoAXIAELOGVhxacAfBZoR/jPC76O32N6a/1cb2Ekx668YODpcGuw9Ko9xYNUGYYFpIxgVrhZ5CC/3uNmm+KjRl/ywaPOcSPrYN3KfjM0Je6+tX25yLAmRQ6RjAQ+EG3n7yQkrGJMLX6M670+cqhvhiky1oZX3abmp+UJiPWI4f6ZcbF0sh2bXof9RRrWsguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBdJm1+hCplRgYc59BeKtBgxNokIVQZBgzgh3Oa6yYA=;
 b=ftedxaJSLC1gNj69S6tErXnD1cCKBI6dNcNq2d37lbo+FSGgbNhF6jLQkRpJHbLyVU6ESiB0m41egmYz+R/tziD2fNrjURw5wEfwmx6+qZGYL50+PdQJ3w/x4J5aRQ/Xy8joLBGWcsSkDOzxPorOqm2WRASMxAIxU1yDBpVkrnsa6ba5kHyC7OAe1hiBljpCZvzqoTjUZEZu0ePE97XV51U8PV5GXXj+F6yRbm+RpsH2PZMRcu0mWaEf6rQHobGZFYmfrCsXimAXUSrbIRVst8ijfKOPE+eOdpYOFO4kJDTezDTvdJ7y20UNmLxBHzTp04E3jI7egPaZT5vJWEjx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBdJm1+hCplRgYc59BeKtBgxNokIVQZBgzgh3Oa6yYA=;
 b=oICE/4xv1n83ZvjUZcCm2v6Jl72jls3CWAh6r2wYCeAz1mMNPxN0eO/P8nlK3YBZCsTLlyAOZY9gIQAJVg/6xvn4aExYKXgwhKnXexDALuKS8LgiGh1yg8fPm1U02nUeFdU2L6jWjGfdP5t/Obc1X12lFsTTeqth/+7/Bym1Mq02WamwyuEJsAjqj2//31E4bUXYbqiJ4x40meziAx/pXmnJBg/dXTBDpd2kfDGwqt/nZhafWYVgxnuXUSmRFKNXJ2uqu+9+lbH95jCl+27tvD2TMTzYjhlgh846tQPBoLUpN7cDn/en+twyYYJsNBrgTqTqGoogSOp7dANWCYNVyw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB12164.eurprd04.prod.outlook.com (2603:10a6:150:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 01:46:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:46:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach
	<l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] pmdomain: imx: Fix i.MX8MP VPU_H1 power up sequence
Thread-Topic: [PATCH] pmdomain: imx: Fix i.MX8MP VPU_H1 power up sequence
Thread-Index: AQHckGhsKfbL9460CEeUNBqlNzz6y7Vn3+KAgA0TnJA=
Date: Fri, 6 Feb 2026 01:46:52 +0000
Message-ID:
 <PAXPR04MB845908F512331CBDA0890D678866A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com>
 <aXpPWea3dBY3lS6s@lizhi-Precision-Tower-5810>
In-Reply-To: <aXpPWea3dBY3lS6s@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV2PR04MB12164:EE_
x-ms-office365-filtering-correlation-id: 9173b406-f6f7-4aab-8c90-08de652199e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1cdByoV49Gu1lGfiJPzQgKhfpWFbo01Rpka+f2nGWYsrdd5RJYf6bovK140O?=
 =?us-ascii?Q?xd2+0a6PPtnKXUIcmbYpYunmy3Gmf4h59Snr3t674rYJOVjmVpNMjbj8gN+u?=
 =?us-ascii?Q?41JBZyNiKZ5x5LKC/uM1H38l0htxqnLECX3cXf47Wbfjb4H+917s6SKCQpgS?=
 =?us-ascii?Q?XgzJTv9OcbHahemBE2/R8c4M+jkn0MW3NOvUt32u207fcC/FBE3a9uiPSIeH?=
 =?us-ascii?Q?ELn/Au5xbSH8qkNqWqzqMgd+STaXeZJYwyYhgi9mLonITOX5PkZGF3eRtHvR?=
 =?us-ascii?Q?OA+gIfdDT+Zkq+j7bGwmfzagXQFIm82+4hW989PHekGcPfO0SZVgoT6Wllav?=
 =?us-ascii?Q?MH4GaZveZ9Jheri/s1AETPPXyPMxE5dF6kj3BbCHrrkW4NvbxZsB3XfmllRu?=
 =?us-ascii?Q?7hHrl1NOb3P/lOwIKeDXyQKc7P2fagOykXHeo3pBsAsCT50s/SZN5M/TN0CG?=
 =?us-ascii?Q?lMFT+xfS6VwBkg+/rNV2qM6pu5j8f+hOxJVkf5KOW+3nxTgKrD0UNTCJKvQB?=
 =?us-ascii?Q?M5L46y3D5VSxDmMqzEiV+iiblwlkaaibkmRENlJSexIjtwY6xAOaNec5zR90?=
 =?us-ascii?Q?0Nn6/+hJK87w0sNjpbATEC5FvG78lehfIwVEul+B4UdWFLPYLKIv4sBR9BAq?=
 =?us-ascii?Q?sxrE6MpSDglL5Ob+XZBk5l1yaCWkBdqtpy169OW02qD7TwWW6dCxxOssODT3?=
 =?us-ascii?Q?7C8hJoME4zVCFvqhxL3mZlG5qskYHZ2Vp5oUOh99VsgtqQKntG9hZ9TsRKRd?=
 =?us-ascii?Q?CqsID/0pqiA1oOQmjMPq6M6T6YjFLKkxTfAsYZmp/O0aDQewlckSQ5NnJwj0?=
 =?us-ascii?Q?beSITTT4oqxpB0fUNa/WpXDlzxyAgSSMFMuOrju02P2C4f4lBUWyYBYRnDU6?=
 =?us-ascii?Q?l9zSyPhFVbUbeD7CA0CifUVhb5/SMhQ/kaosBIqDcilMChecc+j2LkIzGZHt?=
 =?us-ascii?Q?CoDCPW0k1XF+WTMwrqwbgH8m7hB3/nOL5zHHYRdZlIKH0I9rTjRkQXYcNlti?=
 =?us-ascii?Q?NYzL7hAdWgyu5/wRq+BhMZjyZteNkqeJovIpFU+VxQFj771higd7aJnAkzki?=
 =?us-ascii?Q?yYjSNkxzFwRRJC8q0YxbCilJGuNTFS/dHiT1c/1WPrurY7JD3iRvFIYpcWku?=
 =?us-ascii?Q?jIMDBEK4lNt8YuY/EpUPyIg7sbWi+4LTogKwrc34PILy51ng8oaGFAQInu7c?=
 =?us-ascii?Q?UlgJvalgJJkMOEqZFN/1w3vAzGkKfricGgVn0ivOPE42rOeR7qHy7DPjr8mq?=
 =?us-ascii?Q?nnQ/Uj1y6mHHnOgbEWxRCFdtif1dGAOliZcXalrGAB5jfLXr85fLPfsK3+Zd?=
 =?us-ascii?Q?oyWCF5ITAIgdvyy3o2DWexUEWGKjwvtI/+s9ZdmTjjxDcPFQ+AhwZ4H+gdDY?=
 =?us-ascii?Q?UFd2gudzMJPF7ffPIIV1UsxCxBghcDMW30WFIiqbNkWcAY9/G/f3ZzFxkXyR?=
 =?us-ascii?Q?l54HYTodEyJbsAUqROtfy0td5Ww7eYUw6DM2MNy6M6CQzfZuz5KXV4cY3jlS?=
 =?us-ascii?Q?Pik+LuSEXOw0OXX2tRc7tp3sPQCaqpySn6x50Xj9HGBCe+TKZNHs68hc6tUP?=
 =?us-ascii?Q?ivyYPL18IhfjyClgDynVUVWNXim34b11n7tBDJ9N/TEuDp3e/dYyzap6Ifzm?=
 =?us-ascii?Q?1UXvUKxLZlHdTOELs3NsMk4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2MVQ4OIk8Wxui/CF+XrRSuaH8RyArbAJqcdl/NtccTYXDbpBGhLQyK/avZHE?=
 =?us-ascii?Q?Q8lpe15u9VM6ZZczN2em+AlbAWyXFL6nDPfPAX78RYvFQrQDxykHA0cp3+n/?=
 =?us-ascii?Q?ckYJJXGrWwqloJo5fs0tSkIquEdhMEF4v98tK1K3zM+sNsELO89YBmUDVQyP?=
 =?us-ascii?Q?b9sFSfK/u2H/4mrSyAcc8tmwNYLQKsINiQnxFOY8ZZF3nhMsfiEd1bE06T4z?=
 =?us-ascii?Q?3Hv2PR3ehe0Thlw739ry5d0N8LKI/Nr+8GZ4HlHxcNrTVtmo+osXFxuVtYP8?=
 =?us-ascii?Q?I0KlfNmLsCUs69z8lHx7VVh2kQIRIThI5gJP8of/rmR5F68I5PRcmv21JLjv?=
 =?us-ascii?Q?B0PVYzsWr0iYHQXCFS4Z/tYE8Idh3GLBg9DttHjcdYPCwL+mjBA3gm5G7zVA?=
 =?us-ascii?Q?r5s+8VpuuUGIJ9ueB1lNSYfWGTTF6VN/oiyf0+EXK9Jb0TPfoogu9taLlepH?=
 =?us-ascii?Q?POKtxJ6Smkxf3O1iafcqLoJ6LE2cqmX2AnH0i6sLa7D9k/B+GVp8oIevL6oY?=
 =?us-ascii?Q?857Z/9Dp+eTapsGZYbXy/40YNY9DEHu49izRDNlRsAV5kqiz7OwaO6/jqzuf?=
 =?us-ascii?Q?6lYRXJ2QEAxfPRkhBqF9ZjacOTDp0gjVyqSILzkW5K0gFn2K038ncynDZxEf?=
 =?us-ascii?Q?IfCSdcCTgsGDcI2iZL0SJ97tH0vl6hrN8K87ZHBGnqubxOIwuOQDFekrtyrH?=
 =?us-ascii?Q?v/36y08nD56vsEbyt6L6chT1HisJbnlAjwE0REogdEKLzgPLgXlZnPCXTIiP?=
 =?us-ascii?Q?txLJDLMvF6K2gOF/fjV4OhKkGdn/xDhwSy5OGgxQLCUlfzR9s+pHFLqBLJnJ?=
 =?us-ascii?Q?D/eh1rVPFDad8TncyOdZOTkDosrbq8hGHQqFNapfhZyNebwLKyWmWkS1YrBx?=
 =?us-ascii?Q?x7X7IFkO+TGKQrS5auxotNFS7NxXAinBNzQ4yQxfaOJk90WjuGRp+R9v7vPY?=
 =?us-ascii?Q?YGFHbAVTRzn9I+habOqmQF3Cn8CF3eaXX1/TD7+YoIh2Hw+sDObAIyzhah5J?=
 =?us-ascii?Q?uk2YhSRb5Bl5UJhPSN1I8iqSnMUQ8uJtUECsz/HARiuEhArA/gPUttIJ/srx?=
 =?us-ascii?Q?PUvus7gwQaWW6wpstZEE/SuWTHj51ADmuo8AWd2LWpRrcMC2bEujgUbNuo/w?=
 =?us-ascii?Q?8xlNCYUtb33YbaoeBD+nlKgydh96A3LVM4d23Yz/24XYLCntN0JNaDuG7e1l?=
 =?us-ascii?Q?RS2vRn7rLVZmvYoHxP9mCif93q9r1a8bkDmjUvUbXwe0zD35qitBf9wrKULn?=
 =?us-ascii?Q?YbxaqEKLufAi3p58wrCK+3kjXzYQa9m8i/WJ3rurAQVPEKUYq8GejXpGWenl?=
 =?us-ascii?Q?NXsMoYhFiOZqccYdLVb+iao3e66xt9xES4jNboq9+mWju+BKd6Rrj53knM+u?=
 =?us-ascii?Q?C4oPOr4THDBisaXSSHN2XNnwvb37Nw165F2h/IIL5pP021mORIjxPY+Jzkqy?=
 =?us-ascii?Q?Cym7Mm/GBaGChphHNxAu/txCPYpsVbUobPac4PH+hdATGS17ThFA6YDo4vFU?=
 =?us-ascii?Q?mal6UbbYydvdOsCWXEO8VWbI0nnVu+ERnpVoc4SpL7hBZUpvwogp8Z11Oqvu?=
 =?us-ascii?Q?ilNPgopucDc5cSwUCWAtYEk1lRXNhYwiPvRxIK4UKbg05SphPV1KalhM5RMK?=
 =?us-ascii?Q?FtoSZH2thj0E4SbktM9+13Q7cieaf9OZKYvn+h13yWMFGeT+3UQsoyC7UFDp?=
 =?us-ascii?Q?sdfk4xF5BnDbOcl7Lx+xO3acdQKcEISpYsLu4mY9GCJb/HhR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173b406-f6f7-4aab-8c90-08de652199e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 01:46:52.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eB4GFZ4qUyBkZ6F1PRlAPo9do3H7Ft6w2imfNYmCSOMfBMfNEzA5cd0O50QUD7zyccwqMleOalZ+o1fcoiz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-42189-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@nxp.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,PAXPR04MB8459.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A4E0F90E2
X-Rspamd-Action: no action

> Subject: Re: [PATCH] pmdomain: imx: Fix i.MX8MP VPU_H1 power up
> sequence
>=20
> On Wed, Jan 28, 2026 at 11:11:25PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
>=20
> > +
> > +	if (action =3D=3D GENPD_NOTIFY_ON) {
> > +		/*
> > +		 * On power up we have no software backchannel to
> the GPC to
> > +		 * wait for the ADB handshake to happen, so we just
> delay for a
> > +		 * bit. On power down the GPC driver waits for the
> handshake.
> > +		 */
> > +
> > +		udelay(5);
>=20
> this time quite short, suggest read register before udelay() because
> udelay() is not neccesary to have MMIO read/write.

Missed this comment.
This is to wait ADB handshake, not waiting value to be written
into registers(saying use readl).

5us is enough for ADB handshake, I prefer to keep it.

Thanks,
Peng.

>=20
> Frank
> > +
> > +		/* set "fuse" bits to enable the VPUs */
> > +		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
> > +		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
> > +		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
> > +		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> >  static const struct imx8m_blk_ctrl_data
> imx8mp_vpu_blk_ctl_dev_data =3D {
> >  	.max_reg =3D 0x18,
> > -	.power_notifier_fn =3D imx8mm_vpu_power_notifier,
> > +	.power_notifier_fn =3D imx8mp_vpu_power_notifier,
> >  	.domains =3D imx8mp_vpu_blk_ctl_domain_data,
> >  	.num_domains =3D
> ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
> >  };
> >
> > ---
> > base-commit: 4f938c7d3b25d87b356af4106c2682caf8c835a2
> > change-id: 20260128-imx8mp-vc8000e-pm-4278e6d48b54
> >
> > Best regards,
> > --
> > Peng Fan <peng.fan@nxp.com>
> >

