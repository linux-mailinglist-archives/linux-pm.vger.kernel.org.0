Return-Path: <linux-pm+bounces-41666-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWNNd3Qemkq+wEAu9opvQ
	(envelope-from <linux-pm+bounces-41666-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 04:15:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1AAB5E5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 04:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09D2D301303C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165BF1DC997;
	Thu, 29 Jan 2026 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EtNe6Aq6"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE21474CC;
	Thu, 29 Jan 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656537; cv=fail; b=cV+5YuvM4GEmDRh/9GZo2hS2Q2dLBFQTN0d4LNZf7T3gfqu9jSeh25+hBswCDwm/2fV+S78gT3Qhu8raL+kkz9e56x5Zl5v8qojFzG86JcTPzet1X9BR2vzqQVf/3rPiqZ6dGDQ33l95q5MtbrWIR+ZWS1U9huDkId3cgXgN8Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656537; c=relaxed/simple;
	bh=hOQ43iJgD3dWbb0nPgkO4qK3Z58mDYZ8burZAL7MIY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/623w4/+rQkt23ykqFnPsn49q786J//PoqDKJJzW5o/7//wHGUZFEkX2KS8GSItqbDJBU2JXU3CloInArbyo7X7RnmeVn5nLDQpsky7Z/nuie4nh0iH8PVcMrzFXy/4iyjR0UYiVr29TMy6euaOwvcvUtMfHB2+fybfCS8SbM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EtNe6Aq6; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOyzYKQn4r729Yazp+j9i8BND0bofTuMs/lSOnqEergKFPZ+1hDJXLNHyrd7tvMlZwe9dkcYDROLDpkQheUMYtoFhGUNDD+6jFKtAk/oXwqjtc4m7GCKY1bBO0iAqNVQNmhXF7ME7gKFVQCtmOiVwynrbIlxLoMeY4yCMUO8ENQpgCAmBw0t+lNbpr38LVLnx22AsX6mME07vg2hTvEoNkiirU0rid3CQZy1CcdWrofko+vILycJiIvsTeAYUdO7SZV7b9FQERZ6/w88NYQ6ppsi8sYptMIn0trjwb2jTKkcWfJBYlgKeVZHppWNRUwlf3+GrbE1a1oodAHSdFCVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX+B28WV8zFLwfWXF7nj3di/H8bR3cT8ybssxFY/OIA=;
 b=bMKiHU67N8GoXw5D6EWLtN9frlMZXJ16vNvEH05MnxuvJf9ShK1DOnc6F8ff1yNu2ZOtpPlqaZkYSoM336hVNyd72G4RjH6iw3zorfROHFnOg4SjcAuT05/74bAxJ4pXopKxVulnZg90krahwpe4P/US7HA42jRvKd4q8XMbImhV8KvAZapklJHoDZumi5Dga39otu1mnboVl+2oVovx/RBSiEnf/Uf+jtcOXZmSAijq7ZMeoCIrZdtcbfNxqhK7ykqB8WLRNMpnbazoy69/BtfN6waEURfV0VAYGXEwIQOGJuHQkzp90NjpvrrO1z7No/nZVWHmQOPVegxHLNJ+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX+B28WV8zFLwfWXF7nj3di/H8bR3cT8ybssxFY/OIA=;
 b=EtNe6Aq6wyn5GKr9CMz+DXebRQrZdFyAh7fR+KQ2nL1m4wwKkMTv7SqMUDIHK27/f+3w2KskLA3awNhl+svgt4qg8Fvl1U5y4Xh20X5vj6K47YX7krNDs7xR9bEm6mV5VAbJQEAXne3m5syNw+qAEHLMJXgAKQ9WbcrAEEX7IzA4weus1Wf7J/SinP4jec8Vigkob05xF3X7m5G3h6dAcqAyuFEyIYtAbswp4ViPBxcAWcfXELzyRz4+8oH4ZpXeZrXaH8TBVJS4inrywwrwxaC4OqDpKFXHydRKZC3J6GSoaifPs4UcOsrnfijIzEdbkHvWcMENi8NNu3DO2RRAUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 03:15:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 03:15:32 +0000
Date: Thu, 29 Jan 2026 11:15:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: imx: Fix i.MX8MP VPU_H1 power up sequence
Message-ID: <aXrQzt5YH5mP8RVF@shlinux89>
References: <20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com>
 <aXpPWea3dBY3lS6s@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXpPWea3dBY3lS6s@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de27eaa-aff1-4288-3899-08de5ee4a990
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWJaEZydxE7UZ9cqjI3P43WZN/aAdJmgc1wxZcXwFPI0VFGkgBZELRzQx1Tc?=
 =?us-ascii?Q?BdEMjjLvMmwuVOb7HTmz1wxKxV/jwfK61jVVf9pKDElCcN6fWW8lu1H3s9vj?=
 =?us-ascii?Q?r5DOkYjPbOS2CR5266DweE2SKeKuJoiIJQQ12nvISOTlt5Pz4LP/dTNnGAxu?=
 =?us-ascii?Q?S2fuIprDkQI18KYp6ih8G+OscF8N/rf2ICzMmfxzTjsuVKaDQ2/d+RJb6zNM?=
 =?us-ascii?Q?dUqPDVj7pwnmZNRndo7v9o0d6Yt3T8xEpTvaoXmcjqHqVvTzaHeR5OVaoObw?=
 =?us-ascii?Q?YsSA46mRFak08c3ic1laDm1UIQUP1/zxBUYn/CMlDXQz2fW9SErvvCXt2vt/?=
 =?us-ascii?Q?+e+XQ7Bs3qYZc2ufXj/dryYAiC+pG56Q0aJBfg8OAHvuaNhP0g5xJxvOElPg?=
 =?us-ascii?Q?tTTScuHKU97xUqtETibcBJXb39zt5ix5cuJGx+tZ7a4L4JGP0ZsHnLYpn/Zl?=
 =?us-ascii?Q?vXhK5UmCOMFIEA88KZXTiA9m+nA+Ia7kIhiY4jJYvJDIZPnP91A511R846EJ?=
 =?us-ascii?Q?rXW65IFB5rdHgzyerntCETsba/ItZH79vpWLB5hBq/bz4hX8jzvJuMhsDdO9?=
 =?us-ascii?Q?HxnNqIAUu4lrsQseEhA090P2ZDDHc/QZJCts32/A2tPYAjF7PmHTFTZXTvuG?=
 =?us-ascii?Q?t0UPWhopJYOzlQAnJRdOAU9sdjvepAGcjwrAehO5INLth0VFJ8tt7ZpVB4X9?=
 =?us-ascii?Q?8GSGiPOGtZ7r4kHlqZN+OEv9lwDNyhT0/7q0SmTbbDn9maqys1C+sbx+pP7I?=
 =?us-ascii?Q?4jMkqG1K7zE5xeWMDV/BjUifAuM5tfda+W9pZ8gdq/YTIIwb1wTTwGqJaGLj?=
 =?us-ascii?Q?QEjw01x1bM5ZPXe0suI+bBELa3Mx7lF1KMaJA0yYdjbr7qZC5Xi3Zoh8XV6x?=
 =?us-ascii?Q?PLcP8I6LuUfWdt44sZb4FiLuZRO8uELWxRNjvs7oPY2BwtvXP6B3LFTG5xOr?=
 =?us-ascii?Q?1NRbPauyjkotmJge7Z1X9ubdIUC4tH/dbPQjUkByEjIRaSk4HYeU0gXbTTX8?=
 =?us-ascii?Q?egpM1dyDHxN/HZp+DlyBRPQFUTHSZGKi0n36nM4UwiXQ1/jf6gj7GGFa4FjU?=
 =?us-ascii?Q?QSYuZU8FRDwxCyBux/VTlXIFYBYmamHsimx+reLXXTimBCy34A0Ycbp29e15?=
 =?us-ascii?Q?V+Oy/+gNXToHAwyA78FtR/lDJ2uCCIlBd+m1VQPHog6Mmb/CIiF5h8z/kdw+?=
 =?us-ascii?Q?uA4TBm9xL3vikG7t8thVeucLbqGg+cu5d/rp/8aIAovz4ch195S8G7eUTiyO?=
 =?us-ascii?Q?CVn9X9D2H9wfllt4hP9fb8daw2uI8XcjsqMwL52lHT/3p01VlwEQPW4TCAyv?=
 =?us-ascii?Q?13WkeV9/KUQM0mYBfbntPyAebnHyjajFCr8flDbvV2PqchQbgINdtakRgovV?=
 =?us-ascii?Q?Kj/RtxGBF01uB6LADKXoMtl2UW05CpEqJu6PK3wYLfj/BVUET8aSBbfS5uoR?=
 =?us-ascii?Q?+rXEothYCjcyYGGIzha6JcqASJlGt4cDjI/kKc0HWThvsBpq6U7DyehIsqVX?=
 =?us-ascii?Q?BL4CSLfizTTJ072/x4Yr9lI6LiapW1v21YUCHWXm1TYFB56PZaBgLQlRxXjo?=
 =?us-ascii?Q?sXkSiJP8n1DqGXa0IwOYTOoA5/3xD1QdC4UticgqHL2jsuFTxOW1fhbeY3M9?=
 =?us-ascii?Q?lZlSNI0r0HYmvReaqbuLk/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DRmGtoz7x+iwE/OwPhSlaoNBpJ9PvTf1wbm05dtPNH5FGL/T7G1CC8Sq20Tn?=
 =?us-ascii?Q?YPgjsEs8IQgUhAXyOIiTRDEHFS78VuPoj2oou1XD2oJZr94mhOKfBRql3Kgk?=
 =?us-ascii?Q?GOId31x9+EnmEyxxTz2MJ2+5mqkgJPAN+i6plI4Xj9S12GfA0FqdcEQn2LYH?=
 =?us-ascii?Q?bJ3tcFxGqrKau824tgvCKplQmn1yuVx1I3DvSdSCLUlcLyMKJzK4SLmg3DrY?=
 =?us-ascii?Q?yVdOazRognD8/rT8j234g11uf5tkEor//qx3LUmChKOOCTqVp67aPfdom1Ar?=
 =?us-ascii?Q?V9lO4gnU+VpL8W8T1U9v44/KQjJbXpiqoemP6AACd61hSkQ4NSikhdeWLBGO?=
 =?us-ascii?Q?XdOzaWPZqKrvUJPPrQAx+wn0urq9cT9TiLK4fN2HRswYjKozcwqW8XRQFyW3?=
 =?us-ascii?Q?k+UU5UP/2mhI2/qanm9qFqdLtXVtN+GN3fIQ8z6i+j7veVv2GJOTEUAx7s5E?=
 =?us-ascii?Q?RTYQeK/g6Usdr72VEJFdyZ2z+Mtgd34DeutwHiEGfOaow2LJX/KexGflAqMa?=
 =?us-ascii?Q?Sz8hGiUbbNdNwyABnqUXGCZOByN0/M35gKAg63LwN489kDbbxaqhpN1hYx7/?=
 =?us-ascii?Q?hA+TNI5LiI1VVR0lYugZOmwYfy+JAGCJntBcSFiIGx0QEranEi+h+XT9MBOy?=
 =?us-ascii?Q?RJzhI7TgSUBSVHnJBOYl66DbzNBS+rgX8Ka/EuT4TD20MBcmC4VxXAaGVuSf?=
 =?us-ascii?Q?OPUdqdKUFRRF2KcYmTjVhgtXkvrf1rJvxsDnOvo032q4rDvQt1A9DoxxZRvO?=
 =?us-ascii?Q?4B6madJ/BABdGq8fN0TEa1mG18YsnQZ0K48NPVABViiWBsSLBd585Nt6qFeY?=
 =?us-ascii?Q?DKKCjvF9kK/m3+jjZyKxJo84w+mkRGF3UYwJOGITw7AqHSsL/XLGWg2yQxcp?=
 =?us-ascii?Q?P1puKBLHCRrtaBZOn+r29C5WWFV2kowfMJIqs7O2wBL4xAu1PH10alsh8o+m?=
 =?us-ascii?Q?1FrvUWQ7nx4RvfklMBJI9quiwxnQg8K9MiiGmoiW8Iak48yX72Xq2Sz0Lr19?=
 =?us-ascii?Q?fdCsps6QvAbEN88D5jjvOVfnf5avL8WZS2nXwkBNKfUbDaUq/XCMaNPmFSHx?=
 =?us-ascii?Q?82O4HjbtYvZEO38UQzZ1XQ1WbaSFRC27FHFqPz3UspWMiwRmtm2/qC5ilEaa?=
 =?us-ascii?Q?fnf6Xjx/ATIpXKOfehjK47aN4Mo8YoiPYJgReg8Me30J5YLST3hmIEELyR96?=
 =?us-ascii?Q?akxn39kWaUmVqJWT2L+zdSSjVPd645O0hrC2putK0VNcJx+w7Hkl9z8GACVd?=
 =?us-ascii?Q?/pS3FuU7jhKHiA41NSdJa4xxJYpD2QhmJw/En0sSO16UTCil1QAc4UfU3Vot?=
 =?us-ascii?Q?n9Y2oWzPtNUgqlCN5ACXO+nx3RVXnQ7oFaf0P6K9Yj2NzKrgBup8NPcXkfZ/?=
 =?us-ascii?Q?FBEdAKwn0dcQ7nJ8Jx8OItJdjO48gBR+lzucfLDbJ+i7LIPAQj+9GgvVpxt4?=
 =?us-ascii?Q?saOExhsCNjzg9SDQbgcpXJ62eLzTE+BwQbsPmMdZh30r4HVSUn21hD/2ipsJ?=
 =?us-ascii?Q?1VwbaMpaijbi94N4FviqWxCffCGd5wQfo3hGjrMpEkQNRfqccmbKefE0P20+?=
 =?us-ascii?Q?RAlSuTLyBWW8RY2VE0cQP3wmwehK+dNw6gyBk42Zn/3fgIE3/lXDMThoZdt7?=
 =?us-ascii?Q?pYLAci2qD2CfyyzqE1WhPEKYvc5aRJ/n9JIUMvExZVqY/3ubL2hhydUCCIwa?=
 =?us-ascii?Q?1gtWm+djzqyqpPeeTstsKsUlSK2eAEICVUYuJlyzm8RVNhWdgg5N8yoLjq+v?=
 =?us-ascii?Q?AWce6KoaqA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de27eaa-aff1-4288-3899-08de5ee4a990
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 03:15:32.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDJdQaPcV10PiCNlVmq1HEntszb1O8Zzy6nvMgFmbVohRExYF51/yZ8SefFBDR+lBhDYbu+6Yw/GXQ1YRC1YXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41666-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 4FA1AAB5E5
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:03:05PM -0500, Frank Li wrote:
>On Wed, Jan 28, 2026 at 11:11:25PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>
>Subject need descript what did
>
>for example:
>	fix build warning =>
>	do what to fix build warning.
>
>suggest
>	"Clear clk before power up gpc to implement workaroud of i.MX8MP errata"
>
>> Per errata:
>
>Provide errata link here

Sure. BTW, I also need to correct subject title to VC8000E.

Wait to see whether Lucas has any comments, then post out V2.

Thanks
Peng

>
>> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
>> power up/down cycling.
>> Description: VC8000E reset de-assertion edge and AXI clock may have a
>> timing issue.
>> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
>> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
>> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
>> de-asserted by HW)
>>
>> Add a bool variable is_errata_err050531 in
>> 'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
>> is needed. If is_errata_err050531 is true, first clear the clk before
>> powering up gpc, then enable the clk after powering up gpc.
>>
>> While at here, using imx8mm_vpu_power_notifier() is wrong, as it ungates
>> the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
>> but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
>> imx8mp_vpu_power_notifier() for i.MX8MP.
>>
>> Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 37 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> index 74bf4936991d7c36346797d8b646dad40085fc2d..5b26b7c2c43172817d5e407a7d85eb6c5400d5a8 100644
>> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> @@ -54,6 +54,7 @@ struct imx8m_blk_ctrl_domain_data {
>>  	 * register.
>>  	 */
>>  	u32 mipi_phy_rst_mask;
>> +	bool is_errata_err050531;
>
>Put errata descritpion as comments here.
>
>>  };
>>
>>  #define DOMAIN_MAX_CLKS 4
>> @@ -108,7 +109,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>>  		dev_err(bc->dev, "failed to enable clocks\n");
>>  		goto bus_put;
>>  	}
>> -	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>> +
>> +	if (data->is_errata_err050531)
>> +		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>> +	else
>> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>>
>>  	/* power up upstream GPC domain */
>>  	ret = pm_runtime_get_sync(domain->power_dev);
>> @@ -117,6 +122,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>>  		goto clk_disable;
>>  	}
>>
>> +	if (data->is_errata_err050531)
>> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>> +
>>  	/* wait for reset to propagate */
>>  	udelay(5);
>>
>> @@ -514,9 +522,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
>>  	},
>>  };
>>
>> +static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
>> +				     unsigned long action, void *data)
>> +{
>> +	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
>> +						 power_nb);
>> +
>> +	if (action == GENPD_NOTIFY_ON) {
>> +		/*
>> +		 * On power up we have no software backchannel to the GPC to
>> +		 * wait for the ADB handshake to happen, so we just delay for a
>> +		 * bit. On power down the GPC driver waits for the handshake.
>> +		 */
>> +
>> +		udelay(5);
>
>this time quite short, suggest read register before udelay() because udelay()
>is not neccesary to have MMIO read/write.
>
>Frank
>> +
>> +		/* set "fuse" bits to enable the VPUs */
>> +		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
>> +		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
>> +		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
>> +		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>  static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
>>  	.max_reg = 0x18,
>> -	.power_notifier_fn = imx8mm_vpu_power_notifier,
>> +	.power_notifier_fn = imx8mp_vpu_power_notifier,
>>  	.domains = imx8mp_vpu_blk_ctl_domain_data,
>>  	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
>>  };
>>
>> ---
>> base-commit: 4f938c7d3b25d87b356af4106c2682caf8c835a2
>> change-id: 20260128-imx8mp-vc8000e-pm-4278e6d48b54
>>
>> Best regards,
>> --
>> Peng Fan <peng.fan@nxp.com>
>>

