Return-Path: <linux-pm+bounces-24747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D5A79E53
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 10:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA71896EC4
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3841F03E2;
	Thu,  3 Apr 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x8n7zlt1"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B711A01B0;
	Thu,  3 Apr 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669511; cv=fail; b=GYXlCUCpGeN8vgDw3fuqsTyHFJwDIo1aItlEuo7EIDUgfitIazZDtxIFsaIiFynx1zKp+z12QCmo+xfNgy60V5BXZD3s6kbYqHFUyklSzzTA79KqVXlG5Hl4wL29LT2OPITL0HsJ41Jpy03THfscdeM2OB9iz84dORqOmA741Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669511; c=relaxed/simple;
	bh=jiMupApijpASdfrvNf1qsBlWoBuG1R5Cev5fEao8eyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1YXuOTieNNzYUIijrysmUkqO3C7t8LEkGUZAsuGFtDaHZl8cqPQunUe9NYwbnwcboqmxVZfm0grTbK9S2d7cllL5HovNCtE6419zn9E0CMZmBGYcT4dd3Q6eTdUdZgut3f+hYBR354INz7JLikYvP9WvTSWEJXJrzTywRYaO/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x8n7zlt1; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWdR8VdiwxAFEYOFUKYd2M0F5oCdAh5vBtdCBBG+YsdRPl9+AlyspVyRJ12Y2aOOypHCTqYSD1NVWptZ+0yuBDjWHECoPYX9PIBH4yvy3ilSgMCyyOXLyptV94fNyh1WsgywmlI/nsk0GeZleLeZfmDYDNt5eAPUCtrBI0X5rwiU8vTTKJlMADaFaHqtXs7Irej1TOeL1dchL+Jv0Aubj0IC8gF3NwG72M/THqCeS751YzyTrB5RFTyupa2GT0W2lSXgSTx/HiDvDZcRx8gf42FjI3p22h87iRxpS3jzrELx9k7rZuVylmKaKVQw20uoAIcBue9tjkXMhOfErPEoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiMupApijpASdfrvNf1qsBlWoBuG1R5Cev5fEao8eyM=;
 b=nI02FCuy80RXX0/KMcVA88rGyIjBOLUm1sbnUsVKcg7Grle01Zodcd9COhvditRlzgZrPnEXwsfrOhvBImp4RONdR9SeM+pcu5wQITszQDpPoaDwQgaBYfF3Oukctvro/2FRYc8FfD0nJk/Q3pT5dMArRu/u5+8ZZtaIdfiDO1wgZynJf7xeF+H4a8CCVjrgbNuh/egWAnIZFP52aC0B1oH2FViH4K6j/ozO+KL2fpD4xLdDc48U8/PuTTwVp3VbgAElsGTyaGOrQoC0DHfoScHTUiJCyFyig/aisU9Og52m7YAxDQ6zUNOzl62xDh2WJlrY6divOY0D2XlJGAhjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiMupApijpASdfrvNf1qsBlWoBuG1R5Cev5fEao8eyM=;
 b=x8n7zlt1xLg97FCqcso6/md1xIuc1R2kSYlXJkho+gerEYfq25XMfHogFRTtM94HLCthtVBlckGl1E5mdS/fllmdXJ9UzHrYVBp0XaV31xMjOhsepPXgIxfkipCTcpI8zDAXefefy5O6Dqc2NfgP6OJGwW1Iz9UdhPr25YlYVsFRDf7JPSH8uTWDyKJ5Sf4IBCn0b2itnYMqR85wGeoeEQnrHanrtbkzJHgChAFbnCVafjjh7tQSwtJmpNTAPf94j9UkpaA4Us1/UElNazWcv/LELgsTZ1YBcfAtgu7p7G6xXYgOufo/eTDU07Fqry0eJNkXuCu/PxH+bZsdHKeNug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10940.eurprd04.prod.outlook.com (2603:10a6:102:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Thu, 3 Apr
 2025 08:38:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 08:38:26 +0000
Date: Thu, 3 Apr 2025 17:46:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org, rafael@kernel.org, pavel@kernel.org,
	len.brown@intel.com, vincent.guittot@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Message-ID: <20250403094629.GA20718@nxa18884-linux>
References: <20250311083239.3336439-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311083239.3336439-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10940:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d983c4-2468-4f24-fa25-08dd728ae690
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CUSyA3pErOOrI1/z1vvJP3/CFMgWv9/cUFdr2HzE8OgsEliBvRrRnTxOhVAb?=
 =?us-ascii?Q?VXR5YaLyeMa44MtOTntFvLd5DNRnLpg0yT8wAkSMBZu+HyQEBy5maiy0sj5C?=
 =?us-ascii?Q?DUlrDbZ3w3jozm7Lm82MNxwYin3gsooJWASKotzZkuzzfzlpZ43Fn2ykne19?=
 =?us-ascii?Q?2B+rTi7sDk49fOcH35hg36ws8WcO7Y2NiB5WIE0IMmxSv3ny4cGKOSRxBNa4?=
 =?us-ascii?Q?zqHTPavMGl1tk9S5rRbar0Jbi87ocx1MrJEAEfiU0UlT1Za6kkNjxw1Qd/sc?=
 =?us-ascii?Q?ZaU1ZAQjVoqvZgapC5Ac7Vms/+90tIcIQrYAgAeA+0ZJEl7yczpZ0+QKMMeN?=
 =?us-ascii?Q?WNWPovCk79dILnRBZyfObEc7QI5j/SL++IDTH1ndXnDQaLC9VwFuPu9o9+W9?=
 =?us-ascii?Q?bIRr3Cl8Z5ZECGsXNBVYiNUO4pt6SlfahWa3cYOLXqDsnLKHKmyJdF2BjTR3?=
 =?us-ascii?Q?FevXqcLVHivvOUdp1LdwpIRlEzd4BJDrWuP5w148eKHvUleYEdGDJEhgfPpv?=
 =?us-ascii?Q?Btor6mFMrSNfZtaOy9lumKtIzOiSzSquuD7H4qbeYerdY+j70uqDA+IGT6F6?=
 =?us-ascii?Q?AWzFFHdByC9u8QSJK35UO3dIokMff24+OzVmjvswCpeihyIdKu6ehdRdQ6mg?=
 =?us-ascii?Q?xJc973YVMNGnfyf2nyG+TLDnA2x+IRufLrIrCyWWqg0FAtP2++elCV93rxYY?=
 =?us-ascii?Q?1gSN8wSCfPtiYFAeMF3WkCHvAmGVe30JTOohg1CtpJO3iP0yjObQSD/e8NE0?=
 =?us-ascii?Q?cSjg/tyRkTWZ2yHStEURFEG4XyvcX9i4cFXgB84sbwXSBeiQzNLjyXGG+R1m?=
 =?us-ascii?Q?tIjY5HKBrm/rEU1FmOoPiTqZq1q7aCec8H/aoKwC+uAyor49Gl2nUu/d6knx?=
 =?us-ascii?Q?Fg3D7zdWNfaE4y9dJs0+QgTbZSVNoDMZR/9dMFjiJXS4n89NVWTjb4/8A0VR?=
 =?us-ascii?Q?fUWK1Tu9Oivl9RlJT1JjlDuSF2aXAdoAABIiqc2QhwAkCXJKu57KWRvImwgy?=
 =?us-ascii?Q?QMC/f3tbTpPG1tBP5Q3gx3l+f5uy2U353TVUD1+mx8DMcnDAN39UrgackvuU?=
 =?us-ascii?Q?FM44veuU2rIKfpxWC7t0HC3CKe5orlyDHOJMK33Gc9HxN3mhX7tt2xJc3LU1?=
 =?us-ascii?Q?KSCQfs6jNkdg+3YkpTQreLFXDYhGChuDZREASZQmBEQjtN01LNyPadZMPx94?=
 =?us-ascii?Q?yXY2vRr56zH9znpTtG/UHO3YTIRoECwe6llJ0eBi59AhpPf4m4Htqm4YZGag?=
 =?us-ascii?Q?6n5QB4JXQuiV7u1S8tj9nZ3zVaob8vNp1dPZ4yP6OY6RhTJDu2AsfDaogylu?=
 =?us-ascii?Q?lf5mUvOEyN+ovl0xqUgOKArnaYqB7VUDbvNV9Vgg3V42Tq9O8Qq1NOpKNovJ?=
 =?us-ascii?Q?9ixHl6UKTxPCdRGBJcxVrdyMcPkJtT6Aig5AGQAvWp0sX63jsxF94LQmGqz3?=
 =?us-ascii?Q?evG/Umq/R2OW2hSx685tcBpPI/0AVP1b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6FKjyI3DdUrudDgzQlPN0ZHi7FkkBn4DBJjH2mYtekGkoJJTgPz0Ym6ZOyU?=
 =?us-ascii?Q?zJS9/ZYFhhoMPgjOyJM8IyKEplbDambiWkcyeeWt1/B5ecCLzk8MWJ6yhA03?=
 =?us-ascii?Q?zHD3dEZQ41B+xnlFvpTXoku8HFAR4yCegiaEIhBajwAEqdnoMym7ritEwFnQ?=
 =?us-ascii?Q?oCGxC/wP8hjX49QmqO7+ZUDZprTQhUjQY0szcofT081uiU0muxEDJfXr/3j3?=
 =?us-ascii?Q?K9HSUTzwE4yLecQSgZ+ulZ8HbtFdVafXmshF1oC74I/nGMcXtwGwge5ieCek?=
 =?us-ascii?Q?t7CPHxrYSeptKTqdeuWu1xprJM4/aUeWr6CRZdL4X2dkn0yrUC/0FBeAGoFn?=
 =?us-ascii?Q?wU1OLpKBq0TxMC+bGManyEY/9g/SpHMNFqREnL2EXsgXWqa4MKH2X8dtFvIb?=
 =?us-ascii?Q?ABxk26WA7Uhl5JNFId7sdHXGFlPiIA7g71tqQCGGL0cEKy+lN/+MBWHK21ON?=
 =?us-ascii?Q?j/ER2jI/9n7gQ2GZs58XnSXxXfebpLixIrU4mZFg81WJ8kPFTYnPu9mgbRJE?=
 =?us-ascii?Q?NIWfPglv7iK1Rou1mCbuVatwdVDlE3AwH+8J+G7eWNgJXiEE4G71SEUemHzv?=
 =?us-ascii?Q?6IMLK9QEM3O9ksVBAjqFbNYtQIBTQbx/VMu7bElD7Lgz4u/dP9oEQHFalJRW?=
 =?us-ascii?Q?2Di/No55+dgVcAafKh1WHhDPElwZ1YzOesjSZw4euMcsvBsLlr7nvxbt2C6g?=
 =?us-ascii?Q?XDcSP/T+E3/V0kk0RGubMADbWMcg19cJFPM7JDh/lkcUuNKCXaun4jS57rPD?=
 =?us-ascii?Q?zpLNjDGHrVxq//IlzhVq0w5wH3TWPbBG7aefII61w80MtLRRqGQPfgZn3EuW?=
 =?us-ascii?Q?Psv/YQfHWved6Drf30Cy0uVatAr5NG5yX5dr6QdrcvhhL3aetA3rrtEFQyLT?=
 =?us-ascii?Q?TOj6zJN5Unc3MP6yVT06guFprEB3wy/+AkJi4t1zB9gJEI0FnSWC7KILg6ia?=
 =?us-ascii?Q?dZoC3C57Npqd9PBToIsBInbv/JndOXfhFGxc4DnjxG8GAy63SXYjatzWV+Pz?=
 =?us-ascii?Q?apfIFnJ7V+p9yAOTBbMtc+DvO07nWntBYi5t4DQAV22j7bSB7HFYazrUV4zS?=
 =?us-ascii?Q?pLJfMi7PZVvCeSeilnqVi8j1mhudvyqjBzL8rZ/xaoMJxaS7ajUnPJDZRZwM?=
 =?us-ascii?Q?ZVjvGdM01P4uAFfhia1JPdwALi8Sz+9zJh3BUAjU1Zy6b3DatPicf4t5QZVT?=
 =?us-ascii?Q?W4dYfOZkLsQuLXDbpaobyDJHxDEiDhqtpQw+gkueD1x4Gv5F6NFtZzRdTc9g?=
 =?us-ascii?Q?f73uAvEOVpY1pO3sCI/4/YBXFGPGuvmga60G0UmU1m2rdo5TRbYqurboV0NF?=
 =?us-ascii?Q?Fs3rfiBByK4eCteGopamO/Kq/voCEf6eGWW6Uonh0DU9StmVp6+FKpA8Nuza?=
 =?us-ascii?Q?vUhlIr7MpWX/Yzaz0QZggby0Or8i20uw1/wDuGSCOes+WnsmIx/rxSdaRVaR?=
 =?us-ascii?Q?Q+nBM5+NL+SFm8N5Y6L/4SG6VyjXthcngPlYFovBbRzclX71tXor0wRAVU2Y?=
 =?us-ascii?Q?w5e2+/XsM07PWHysnPN2o4pKsdllxj/V4Z8+1IYoV5oPlMjf0eOv2lxLwX2l?=
 =?us-ascii?Q?jdNTRoBY3CB8HCVaEgQC66HRhNPMZoc2mFAgqiHm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d983c4-2468-4f24-fa25-08dd728ae690
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 08:38:25.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GPZpLEfGoQ0h2Z9liRXQKEPZW/w8NEg534XB8W2aZkJ/dbGv/zdZH+jjuIBRAjVCANLXRUhXkYtQYq4T2dQKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10940

Hi Ulf,

On Tue, Mar 11, 2025 at 04:32:39PM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>For some cases, a device could still wakeup the system even if its power
>domain is in off state, because the device's wakeup hardware logic is
>in an always-on domain.
>
>To support this case, introduce device_set/get_out_band_wakeup() to
>allow device drivers to control the behaviour in genpd for a device
>that is attached to it.

Do you have any comments on this patch?

Thanks,
Peng

