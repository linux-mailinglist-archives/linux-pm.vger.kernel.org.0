Return-Path: <linux-pm+bounces-28507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CFAD614F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 23:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC8F3AB67D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F1244696;
	Wed, 11 Jun 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oFq0TOyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC4244675;
	Wed, 11 Jun 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677404; cv=fail; b=DUozRTgDIN/0o2q75Cfugd/5lUWX/QLRNOvKSXrp24/48+szNplPrDRlfRjsSVNFWKKNtBFRcg6QeuphGHHhFJdb9yfx2gCHuD13j2W3utEa+xSaBL4hiRNyt+nyTm72HtqF1FYxs2Vz+ySjiFal+ACesDMsJoavD0ELn+1KulA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677404; c=relaxed/simple;
	bh=GkOU38OxmtD4/DB+tPfR3BZVm5eycBBZsx8weIaAUiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U2K3TXUXt/b25+FaLdHFLI7HFDhtc+TAx43TrBcGuVidtf0Y1+4ROrsxhTKcepdQ5IHMS65SEbpyslJl9uDvgkrXJCf8z1vEWhS/UWB35GIqVRuA5WW3RQqILcoM2t30oIMSsXteihW1c5ZZa11eoHEgZAcCwtSb4Vg4e5b/W1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oFq0TOyy; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+Eh74VIqXreHLfHt1G/6fhl2HKI5yC4U7HQFihQB+tQGt5lxjzU9fgRJG2qckRidOc9YQHhu8xfGw6jOeoVTRxL7rUmdLJhERoDCl7Hq927x7NbbQHd17uwqR1WIi11LP33GPkoN/P+PrNqNhTQF9JNCDLpcChvDuhvmUiO/kg94juWat8+sTx83s1l9ljLfdgKMxgRHUyMWdp8NO/5WoXlqoZGNeZvkwlFPmmOoYWAL17LERd0h9ac6mGAfg7jS2YbpKJct4vezrlf+T0bf8k4GLVbW9k/9ZkZiNGNFuZ2A0fZmVeOYclCVbi14Uyr80IFziO9GKAc3I3trJNoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkw8t5Fl6VW6or/Wd/n/Q4s1kRhQL2bjrp7WiEUq/9s=;
 b=PNVhYrNJnH4AW8SymUByr6ODHbmLf6+BnKhewUUxeLht+ioLWYDdxjY7Ug7Rot6J+/kHNGYj6nOlCoMM7LlHVUFa+NYJ2e2mFqy0qShE2LT7Yb55tXJCOxeiqvUelnRPAPgoQovwXV700+FTTL2c4IDykiqtns4/z58kVxS59z8VHMxoMRfbh9AvmLph7DUH0IyL5yS7wPACKxwEhJs3mxYkFF3FKzuR1eCvLpo2k1MJbU0D7y8+46lE+jElhEqBdIeKpRcYSf+m74CRtgjl2azRJLwd3TZXfBXtN7gUJ23qnqUM8w/Z665Qkkr3t/IvwDi+YPJYvLKh1NPkbN/adA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkw8t5Fl6VW6or/Wd/n/Q4s1kRhQL2bjrp7WiEUq/9s=;
 b=oFq0TOyynHsJ/rOWl4ixIsAjKPsPTVAfbJyy9g9dRnyGVKg0j9vDmgfJ/1BZLa2p6xkBbWbsf4JRgc8+ZooVGyAjXcpdGwQ2B449oSOvx9nPtRUwBjO5LgbHqHvIcAJtR31CLAurF7xMhCUoIyDk2Z1JPouTZ9sHTinOGdAdV2dUW6dRzhVqovPQlxVVLjILenggdj+y4DDWsXFPux2tPzYEJB15/PxgrvVYWX5cv5j5XU0U0aLLHHEuTbcZR8H8SJhcqRomj778EqZfAXW6Zz9NLFseyRIhcJY6qSwQTGHYRKb7nJUmDsUbPxsjuUyhmTZKtEP766T/D6FVMRY4tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10722.eurprd04.prod.outlook.com (2603:10a6:102:483::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Wed, 11 Jun
 2025 21:29:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 21:29:58 +0000
Date: Wed, 11 Jun 2025 17:29:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v6 2/6] mfd: pf1550: add core mfd driver
Message-ID: <aEn1ToxYUKlaiR5H@lizhi-Precision-Tower-5810>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
 <20250611-pf1550-v6-2-34f2ddfe045e@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-pf1550-v6-2-34f2ddfe045e@savoirfairelinux.com>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10722:EE_
X-MS-Office365-Filtering-Correlation-Id: 118584f0-3bf0-4796-0cc9-08dda92f1de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdV2HSYK314zidVWMCb9Q1AIlQdK5DsE5Jc4wVlCdwUZFrbRECUB4WWbwofu?=
 =?us-ascii?Q?wJNbifaJhw+4GnkbbhJI91JGX6uvHzZikracUbcxyJnddI9/V4Pf5S6uhvqk?=
 =?us-ascii?Q?3oBYSoqGVmOGzQZ2hm48OOsw96hq8X9p4RYjI/717MX5OQBRXSQgaTuyGxp3?=
 =?us-ascii?Q?ja31B7TdveQqFmGwsd9g91TgBbB53gi49Auudr9+WYYxS+8YtCY6R9slzCB3?=
 =?us-ascii?Q?M2ixmLNxNNpxsg8/xfRYB+XSbUBpyz1r1QiqgxEoRrJhvpMvZJm+iVy0E80g?=
 =?us-ascii?Q?MqG+mvHulfBSsAjZmkpLh25L0w4TTkqgpQCq8cyHd/gGB1TWyQ83R+q6skYU?=
 =?us-ascii?Q?1LxvAPmE4mVtYkFNlOAJKeo21Akpe+RiBNGw4yZyaxU3nYcxY6FdFqy8zAlI?=
 =?us-ascii?Q?YrQZW4lCzLdA9lpo0CpkPCgYSXE9JkHA+sVjWSxqzH38BwieHiAdVexqnijd?=
 =?us-ascii?Q?B2kDfp6eBeaji6b0M/npWONxWESn4i7LOu88yGaCJme7C3tM9WJ3GN68L6g3?=
 =?us-ascii?Q?LrMyb+5i0EYVYiVaqB6knZwoqQafUcYSBXYmhMoTz85ptlJmkHV6OoW6fCjp?=
 =?us-ascii?Q?4iUXjY7Zjmzan67E+ZnPTSyRnl3O6By/Uiomixxbf2e9KfSKFY6Y2uiXPBuJ?=
 =?us-ascii?Q?GmDvg62cu/wck7N8p3N8pOwSaWssjrRLesTl7bdCZri4tAw83d7u0EGyzlDt?=
 =?us-ascii?Q?9otNV7VdIVQkZN6eKtj9cxMELe1CFTNgKbBneS41gTU7KlhJYbnQ97wLNMJC?=
 =?us-ascii?Q?mMybm5iQ8HjRfkvSBCFO8pVc360UJYXNepcDsuwaJvhGu9HW0invfieu4AaM?=
 =?us-ascii?Q?WhcL77OEBIx2vkyyBCb9PfGPqtf/L7g+Cfgt/FVIusjsdgbVJe0ImGB7oJs7?=
 =?us-ascii?Q?pKnPT+Y5WeqC2wRDGUHcasphJoqu4kBGYzwwKLSjth2aiqY9HobP1LFR9OjL?=
 =?us-ascii?Q?pfuxJUnL0Zl00vpsiXe+WKRdOnVFWSEDYIIEjkv34U3/4VRF2vf3FEUpvd64?=
 =?us-ascii?Q?9/yMy3JJ+PGyf50Kq+rEBEnIQ19gKP8xLvUGl7sPDmFC9umuwFM6TK+Zal8F?=
 =?us-ascii?Q?uXtCBD1rnq+kqc1+yh2APbsgze2CgnY5F0H/makzbcwShqKL7itTTLPyuV/i?=
 =?us-ascii?Q?RFRFEANNgAIPabxlqYp4kfxLMuPNc9P1ovrsUcLUZv+A/tn+cTwj+9ORq8Ao?=
 =?us-ascii?Q?lbQF+4CxVDfCt4mqfikt8Z0+x0SLFTn9eLFf2MEG85doZZv0nOkXk+PujMFT?=
 =?us-ascii?Q?1hYDvc/n6FLTytcYGUVMqYiEFBnjxN2VKPPJ2md5fx/wzOm2lVybHtB82pjp?=
 =?us-ascii?Q?ol/FPsY2SMI3877RkXRD78wv8opa6AQdecQEQVVyIjK4HGEsxeR0BcM3+86b?=
 =?us-ascii?Q?VggziMzKMstf00LGadUb7hugvemxBQe5WrJiO+7t40myVWhkaM5MNjSWqHcD?=
 =?us-ascii?Q?m0SQvI7eJAWRNkGy44U/ENWq450hv2CBjwH6yCkr3Scg9/64nfeJPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+MBUx8wAkE0P7pTAsY6oLz7j/EkSicdANhkMOfmv/nUwnZfx04VG2ymfbEmm?=
 =?us-ascii?Q?nHhc4a9Cbii3GRR75imrKOpGzKgPeH8oa6aNlMvzMPdk00CDDUPdvY+PJoQH?=
 =?us-ascii?Q?QDNqVXSDZTyOIqT2yH/daqIR5A8rx5Ci1UQHQShw74NvlC9mzfyVPm0SeWYc?=
 =?us-ascii?Q?KqFR+26mNlACkeNrUjMzMuQp5huU/yV8ckN7FcQg6W+cBdsPW4C+Qnx3yEhP?=
 =?us-ascii?Q?1fuPBqWSdMet3jo5IcIS5p2F11/GiMdMSi1qooi5RSaoqx6e8SdplvRX7jfp?=
 =?us-ascii?Q?big6CtVjTY9kU9koWtx/wk4DaDw2jUjFrF3DHCAdnKkb5KarcosO1sgiXAS5?=
 =?us-ascii?Q?RORCypY/IF7bx8vIikxviyYeIG/FBToVZf8UTS7Xjh37RMln7G0ZyJFj2fpu?=
 =?us-ascii?Q?bRcRSVGWxVOzTW1cuJw4/IyBIKdmcQXWa7+YD28S9zQGhCJGys6fjkZNOf9i?=
 =?us-ascii?Q?+YCPUje2fW15VgdBwNSefV5y5qfGoBA4r/kzKWsioB68ja9jav6tV9K8vgMH?=
 =?us-ascii?Q?ojmiLqxsROn3UDUgdYxuZCZg1mb+5fClI9NdxF1SIKx3sgKHQnVFJUn4N+Iy?=
 =?us-ascii?Q?2Q91eBOH6Q7HtMkBVFDtP92EZZOd/LWLX8p+TGXMfmRId7DCQ/fK9ScA99i7?=
 =?us-ascii?Q?LtptCiFeU1+AlFJaB3fEZ5nTRrx3IaVibMp7BtrF9M8tSUjI/hvZSsM5Ldzx?=
 =?us-ascii?Q?iLVVciLGkiz5AtpLNWaPYi9C3mv0PAdHa/+MtTidYE1g+c68EuZO/4nb4yMF?=
 =?us-ascii?Q?sHKbYUQUd/qq86wsESwKOb1uNhYgkvi4RC/Pkhk8xyRqyBHa6vieMcTTQrJI?=
 =?us-ascii?Q?U10M1huj0OEpQCKfdqoNMdnN8OHbnVWN3j/fB9W4hwMWjp53HXRbCwhFE6Wi?=
 =?us-ascii?Q?lFfAUu+Zsv/Qy1Ml4cEuSZ+/W+CC+1zdsSupmjdRxaqluUfRb2mKwawrUFTG?=
 =?us-ascii?Q?XNLrM3wgu8voKcJESt+RD/7/CIWCrJXtT8qPa6YZ72ZRABhSsCFIE+UotohP?=
 =?us-ascii?Q?uzM9TKGbvbJ1KQbeHTJ3JWRNWPUVDoSEV9dMH4yoT9UhdecIqS/xziMhmcjk?=
 =?us-ascii?Q?couL1YbLkbdR0wEyKtUsjwqc8uaQHAyK6A1ommnolEvp/2EVI0feX09REF+8?=
 =?us-ascii?Q?VAwLGb7zn/I06s0gv9r1Pw1/TCxgu1RQGmfMNxBHuI3WXpGT7EwjT8H+K1Xc?=
 =?us-ascii?Q?tYjwLRO5hzd13YdbE9xACt35aGZg35lGXRmo0pCXJaUeEvbOESkzMiVFnR/Y?=
 =?us-ascii?Q?lba88mSNO6xClL9nGEDPMTM3zV9/cXSMrCsklOsXrO8p6ENUb5Hk5TGhRgYI?=
 =?us-ascii?Q?cnWeJ66MuG9KrRlpxLaPsmaVbZzC6Ed8DODkwPlNqwzute2wfGP+6tFxmX2U?=
 =?us-ascii?Q?NXYqyFbmluzPBz/vc+SOSEmqBFD0Llr4vo9ZD84ZEQ3iB/ZrZshUM8E6dZDO?=
 =?us-ascii?Q?1HACHJgr6rbsghVPGfW3fH2DK0460HIdbaUZISchPMVCupwJCUgT5Pj5/O8p?=
 =?us-ascii?Q?7UVcMzDj5+OYl8kYXtajuVAyEESzFLBZzJMMLFl3ZjzFcGyY8nRyWodtIaz8?=
 =?us-ascii?Q?UmlIYdIDeGVpr17Srdq510CA98yu/AEj3KCP9zrQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118584f0-3bf0-4796-0cc9-08dda92f1de2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:29:58.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuHqkURRSouHZTBbKskSrVNIkrQV3NNyvdrTjRnMkeJea4tI2yvYr2gSkfxnEmHzMSQI1aahS0nkXgPaXFI7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10722

On Wed, Jun 11, 2025 at 04:02:59PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>
> Add the core mfd driver for pf1550 PMIC. There are 3 subdevices for
> which the drivers will be added in subsequent patches.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v6:
>  - Address Frank's feedback:
>    - Ensure lowercase when defining register addresses
>    - Use GENMASK macro for masking
>    - Hardcode IRQ flags in pf1550_add_child_device
>    - Add dvs_enb variable for SW2 regulator
>    - Drop chip type variable
> v5:
>  - Use top level interrupt to manage interrupts for the sub-drivers as
>    recommended by Mark Brown. The regmap_irq_sub_irq_map would have been used
>    if not for the irregular charger irq address. For all children, the mask
>    register is directly after the irq register (i.e., 0x08, 0x09) except
>    for the charger: 0x80, 0x82. Meaning .mask_base would be applicable
>    for all but the charger
>  - Fix bad offset for temperature interrupts of regulator
> v4:
>  - Use struct resource to define irq so platform_get_irq can be used in
>    children as suggested by Dmitry
>  - Let mfd_add_devices create the mappings for the interrupts
>  - ack_base and init_ack_masked defined for charger and regulator irq
>    chips
>  - No need to define driver_data in table id
> v3:
>  - Address Dmitry's feedback:
>    - Place Table IDs next to each other
>    - Drop of_match_ptr
>    - Replace dev_err with dev_err_probe in probe method
>    - Drop useless log in probe
>  - Map all irqs instead of doing it in the sub-devices as recommended by
>    Dmitry.
> v2:
>  - Address feedback from Enric Balletbo Serra
> ---
>  drivers/mfd/Kconfig        |  14 ++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/pf1550.c       | 339 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/pf1550.h | 254 +++++++++++++++++++++++++++++++++
>  4 files changed, 609 insertions(+)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 96992af22565205716d72db0494c7bf2567b045e..de3fc9c5e88b5c2a2c7325e2ceeb8f9c3ca057de 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -558,6 +558,20 @@ config MFD_MX25_TSADC
>  	  i.MX25 processors. They consist of a conversion queue for general
>  	  purpose ADC and a queue for Touchscreens.
>
> +config MFD_PF1550
> +	tristate "NXP PF1550 PMIC Support"
> +	depends on I2C=y && OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Say yes here to add support for NXP PF1550.
> +	  This is a companion Power Management IC with regulators, onkey,
> +	  and charger control on chip.
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5e5cc279af6036a6b3ea1f1f0feeddf45b85f15c..7391d1b81d1ee499507b4ac24ff00eb2e344d60b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -120,6 +120,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
>
> +obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
> +
>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
>
>  ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
> diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d330ee2268224db96e3a0ae1916e64fb444030c6
> --- /dev/null
> +++ b/drivers/mfd/pf1550.c
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// pf1550.c - mfd core driver for the PF1550
> +//
> +// Copyright (C) 2016 Freescale Semiconductor, Inc.
> +// Robin Gong <yibin.gong@freescale.com>
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +// This driver is based on max77693.c
> +//
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config pf1550_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = PF1550_PMIC_REG_END,
> +};
> +
> +static const struct regmap_irq pf1550_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_IRQ_CHG,		 0, IRQ_CHG),
> +	REGMAP_IRQ_REG(PF1550_IRQ_REGULATOR,     0, IRQ_REGULATOR),
> +	REGMAP_IRQ_REG(PF1550_IRQ_ONKEY,	 0, IRQ_ONKEY),
> +};
> +
> +static const struct regmap_irq_chip pf1550_irq_chip = {
> +	.name			= "pf1550",
> +	.status_base		= PF1550_PMIC_REG_INT_CATEGORY,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 1,
> +	.irqs			= pf1550_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_irqs),
> +};
> +
> +static const struct regmap_irq pf1550_regulator_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_LS,         0, PMIC_IRQ_SW1_LS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_LS,         0, PMIC_IRQ_SW2_LS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_LS,         0, PMIC_IRQ_SW3_LS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_HS,         3, PMIC_IRQ_SW1_HS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_HS,         3, PMIC_IRQ_SW2_HS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_HS,         3, PMIC_IRQ_SW3_HS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO1_FAULT,    16, PMIC_IRQ_LDO1_FAULT),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO2_FAULT,    16, PMIC_IRQ_LDO2_FAULT),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO3_FAULT,    16, PMIC_IRQ_LDO3_FAULT),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_110,      24, PMIC_IRQ_TEMP_110),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_125,      24, PMIC_IRQ_TEMP_125),
> +};
> +
> +static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
> +	.name			= "pf1550-regulator",
> +	.status_base		= PF1550_PMIC_REG_SW_INT_STAT0,
> +	.ack_base		= PF1550_PMIC_REG_SW_INT_STAT0,
> +	.mask_base		= PF1550_PMIC_REG_SW_INT_MASK0,
> +	.use_ack                = 1,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 25,
> +	.irqs			= pf1550_regulator_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_regulator_irqs),
> +};
> +
> +static const struct resource regulator_resources[] = {
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_LS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_LS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_LS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_HS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_HS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_HS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO1_FAULT),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO2_FAULT),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO3_FAULT),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_110),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_125),
> +};
> +
> +static const struct regmap_irq pf1550_onkey_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_PUSHI,  0, ONKEY_IRQ_PUSHI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_1SI,    0, ONKEY_IRQ_1SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_2SI,    0, ONKEY_IRQ_2SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_3SI,    0, ONKEY_IRQ_3SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_4SI,    0, ONKEY_IRQ_4SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_8SI,    0, ONKEY_IRQ_8SI),
> +};
> +
> +static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
> +	.name			= "pf1550-onkey",
> +	.status_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
> +	.ack_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
> +	.mask_base		= PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +	.use_ack                = 1,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 1,
> +	.irqs			= pf1550_onkey_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_onkey_irqs),
> +};
> +
> +static const struct resource onkey_resources[] = {
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_PUSHI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_1SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_2SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_3SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_4SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_8SI),
> +};
> +
> +static const struct regmap_irq pf1550_charger_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BAT2SOCI,	0, CHARG_IRQ_BAT2SOCI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BATI,           0, CHARG_IRQ_BATI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_CHGI,           0, CHARG_IRQ_CHGI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_VBUSI,          0, CHARG_IRQ_VBUSI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_THMI,           0, CHARG_IRQ_THMI),
> +};
> +
> +static const struct regmap_irq_chip pf1550_charger_irq_chip = {
> +	.name			= "pf1550-charger",
> +	.status_base		= PF1550_CHARG_REG_CHG_INT,
> +	.ack_base		= PF1550_CHARG_REG_CHG_INT,
> +	.mask_base		= PF1550_CHARG_REG_CHG_INT_MASK,
> +	.use_ack                = 1,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 1,
> +	.irqs			= pf1550_charger_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_charger_irqs),
> +};
> +
> +static const struct resource charger_resources[] = {
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BAT2SOCI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BATI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_CHGI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_VBUSI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_THMI),
> +};
> +
> +static const struct mfd_cell pf1550_regulator_cell = {
> +	.name = "pf1550-regulator",
> +	.num_resources = ARRAY_SIZE(regulator_resources),
> +	.resources = regulator_resources,
> +};
> +
> +static const struct mfd_cell pf1550_onkey_cell = {
> +	.name = "pf1550-onkey",
> +	.num_resources = ARRAY_SIZE(onkey_resources),
> +	.resources = onkey_resources,
> +};
> +
> +static const struct mfd_cell pf1550_charger_cell = {
> +	.name = "pf1550-charger",
> +	.num_resources = ARRAY_SIZE(charger_resources),
> +	.resources = charger_resources,
> +};
> +
> +static int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
> +			   unsigned int *val)
> +{
> +	int ret = 0;
> +
> +	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, 0x15);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, 0x50);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, 0xab);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
> +	if (ret)
> +		goto read_err;
> +
> +	return 0;
> +
> +read_err:
> +	dev_err_probe(pf1550->dev, ret, "read otp reg %x found!\n", index);
> +	return ret;
> +}
> +
> +static int pf1550_add_child_device(struct pf1550_dev *pmic,
> +				   const struct mfd_cell *cell,
> +				   struct regmap_irq_chip_data *pdata,
> +				   int pirq,
> +				   const struct regmap_irq_chip *chip,
> +				   struct regmap_irq_chip_data **data)
> +{
> +	struct device *dev = pmic->dev;
> +	struct irq_domain *domain;
> +	int irq, ret;
> +
> +	irq = regmap_irq_get_virq(pdata, pirq);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,
> +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> +				     pirq, chip->name);
> +
> +	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING, 0, chip, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add %s IRQ chip\n",
> +				     chip->name);
> +
> +	domain = regmap_irq_get_domain(*data);
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cell, 1,
> +				    NULL, 0, domain);
> +}
> +
> +static int pf1550_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct pf1550_dev *pf1550;
> +	const struct mfd_cell *regulator = &pf1550_regulator_cell;
> +	const struct mfd_cell *onkey = &pf1550_onkey_cell;
> +	const struct mfd_cell *charger = &pf1550_charger_cell;
> +	unsigned int reg_data = 0, otp_data = 0;

try keep reverse christmas tree order.

> +	int ret = 0;
> +
> +	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
> +	if (!pf1550)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, pf1550);
> +	pf1550->dev = &i2c->dev;
> +	pf1550->i2c = i2c;
> +	pf1550->irq = i2c->irq;
> +	pf1550->dvs_enb = false;
> +
> +	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
> +	if (IS_ERR(pf1550->regmap))
> +		return dev_err_probe(pf1550->dev, PTR_ERR(pf1550->regmap),
> +				     "failed to allocate register map\n");
> +
> +	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
> +	if (ret < 0 || reg_data != PF1550_DEVICE_ID)
> +		return dev_err_probe(pf1550->dev, ret ?: -EINVAL,
> +				     "device not found!\n");
> +
> +	/* regulator DVS */
> +	ret = pf1550_read_otp(pf1550, 0x1f, &otp_data);
> +	if (ret)
> +		return ret;
> +
> +	if (otp_data & BIT(3))
> +		pf1550->dvs_enb = true;
> +
> +	/* add top level interrupts */
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf1550->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING,
> +				       0, &pf1550_irq_chip,
> +				       &pf1550->irq_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_add_child_device(pf1550, regulator, pf1550->irq_data,
> +				      PF1550_IRQ_REGULATOR,
> +				      &pf1550_regulator_irq_chip,
> +				      &pf1550->irq_data_regulator);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_add_child_device(pf1550, onkey, pf1550->irq_data,
> +				      PF1550_IRQ_ONKEY,
> +				      &pf1550_onkey_irq_chip,
> +				      &pf1550->irq_data_onkey);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_add_child_device(pf1550, charger, pf1550->irq_data,
> +				      PF1550_IRQ_CHG,
> +				      &pf1550_charger_irq_chip,
> +				      &pf1550->irq_data_charger);
> +	return ret;
> +}
> +
> +static int pf1550_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(pf1550->irq);
> +		disable_irq(pf1550->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(pf1550->irq);
> +		enable_irq(pf1550->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
> +
> +static const struct i2c_device_id pf1550_i2c_id[] = {
> +	{ "pf1550", 0 },

I remember needn't add 0 at here.

after fix above two small issues

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
> +
> +static const struct of_device_id pf1550_dt_match[] = {
> +	{ .compatible = "nxp,pf1550" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pf1550_dt_match);
> +
> +static struct i2c_driver pf1550_i2c_driver = {
> +	.driver = {
> +		   .name = "pf1550",
> +		   .pm = pm_sleep_ptr(&pf1550_pm),
> +		   .of_match_table = pf1550_dt_match,
> +	},
> +	.probe = pf1550_i2c_probe,
> +	.id_table = pf1550_i2c_id,
> +};
> +module_i2c_driver(pf1550_i2c_driver);
> +
> +MODULE_DESCRIPTION("NXP PF1550 multi-function core driver");
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..64ff475215cced21a5ebc24f799f48315a51d260
> --- /dev/null
> +++ b/include/linux/mfd/pf1550.h
> @@ -0,0 +1,254 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * pf1550.h - mfd head file for PF1550
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>
> + *
> + * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> + * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> + */
> +
> +#ifndef __LINUX_MFD_PF1550_H
> +#define __LINUX_MFD_PF1550_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +enum pf1550_pmic_reg {
> +	/* PMIC regulator part */
> +	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
> +	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
> +	PF1550_PMIC_REG_SILICON_REV		= 0x02,
> +
> +	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,
> +	PF1550_PMIC_REG_SW_INT_STAT0		= 0x08,
> +	PF1550_PMIC_REG_SW_INT_MASK0		= 0x09,
> +	PF1550_PMIC_REG_SW_INT_SENSE0		= 0x0a,
> +	PF1550_PMIC_REG_SW_INT_STAT1		= 0x0b,
> +	PF1550_PMIC_REG_SW_INT_MASK1		= 0x0c,
> +	PF1550_PMIC_REG_SW_INT_SENSE1		= 0x0d,
> +	PF1550_PMIC_REG_SW_INT_STAT2		= 0x0e,
> +	PF1550_PMIC_REG_SW_INT_MASK2		= 0x0f,
> +	PF1550_PMIC_REG_SW_INT_SENSE2		= 0x10,
> +	PF1550_PMIC_REG_LDO_INT_STAT0		= 0x18,
> +	PF1550_PMIC_REG_LDO_INT_MASK0		= 0x19,
> +	PF1550_PMIC_REG_LDO_INT_SENSE0		= 0x1a,
> +	PF1550_PMIC_REG_TEMP_INT_STAT0		= 0x20,
> +	PF1550_PMIC_REG_TEMP_INT_MASK0		= 0x21,
> +	PF1550_PMIC_REG_TEMP_INT_SENSE0		= 0x22,
> +	PF1550_PMIC_REG_ONKEY_INT_STAT0		= 0x24,
> +	PF1550_PMIC_REG_ONKEY_INT_MASK0		= 0x25,
> +	PF1550_PMIC_REG_ONKEY_INT_SENSE0	= 0x26,
> +	PF1550_PMIC_REG_MISC_INT_STAT0		= 0x28,
> +	PF1550_PMIC_REG_MISC_INT_MASK0		= 0x29,
> +	PF1550_PMIC_REG_MISC_INT_SENSE0		= 0x2a,
> +
> +	PF1550_PMIC_REG_COINCELL_CONTROL	= 0x30,
> +
> +	PF1550_PMIC_REG_SW1_VOLT		= 0x32,
> +	PF1550_PMIC_REG_SW1_STBY_VOLT		= 0x33,
> +	PF1550_PMIC_REG_SW1_SLP_VOLT		= 0x34,
> +	PF1550_PMIC_REG_SW1_CTRL		= 0x35,
> +	PF1550_PMIC_REG_SW1_CTRL1		= 0x36,
> +	PF1550_PMIC_REG_SW2_VOLT		= 0x38,
> +	PF1550_PMIC_REG_SW2_STBY_VOLT		= 0x39,
> +	PF1550_PMIC_REG_SW2_SLP_VOLT		= 0x3a,
> +	PF1550_PMIC_REG_SW2_CTRL		= 0x3b,
> +	PF1550_PMIC_REG_SW2_CTRL1		= 0x3c,
> +	PF1550_PMIC_REG_SW3_VOLT		= 0x3e,
> +	PF1550_PMIC_REG_SW3_STBY_VOLT		= 0x3f,
> +	PF1550_PMIC_REG_SW3_SLP_VOLT		= 0x40,
> +	PF1550_PMIC_REG_SW3_CTRL		= 0x41,
> +	PF1550_PMIC_REG_SW3_CTRL1		= 0x42,
> +	PF1550_PMIC_REG_VSNVS_CTRL		= 0x48,
> +	PF1550_PMIC_REG_VREFDDR_CTRL		= 0x4a,
> +	PF1550_PMIC_REG_LDO1_VOLT		= 0x4c,
> +	PF1550_PMIC_REG_LDO1_CTRL		= 0x4d,
> +	PF1550_PMIC_REG_LDO2_VOLT		= 0x4f,
> +	PF1550_PMIC_REG_LDO2_CTRL		= 0x50,
> +	PF1550_PMIC_REG_LDO3_VOLT		= 0x52,
> +	PF1550_PMIC_REG_LDO3_CTRL		= 0x53,
> +	PF1550_PMIC_REG_PWRCTRL0		= 0x58,
> +	PF1550_PMIC_REG_PWRCTRL1		= 0x59,
> +	PF1550_PMIC_REG_PWRCTRL2		= 0x5a,
> +	PF1550_PMIC_REG_PWRCTRL3		= 0x5b,
> +	PF1550_PMIC_REG_SW1_PWRDN_SEQ		= 0x5f,
> +	PF1550_PMIC_REG_SW2_PWRDN_SEQ		= 0x60,
> +	PF1550_PMIC_REG_SW3_PWRDN_SEQ		= 0x61,
> +	PF1550_PMIC_REG_LDO1_PWRDN_SEQ		= 0x62,
> +	PF1550_PMIC_REG_LDO2_PWRDN_SEQ		= 0x63,
> +	PF1550_PMIC_REG_LDO3_PWRDN_SEQ		= 0x64,
> +	PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ	= 0x65,
> +
> +	PF1550_PMIC_REG_STATE_INFO		= 0x67,
> +	PF1550_PMIC_REG_I2C_ADDR		= 0x68,
> +	PF1550_PMIC_REG_IO_DRV0			= 0x69,
> +	PF1550_PMIC_REG_IO_DRV1			= 0x6a,
> +	PF1550_PMIC_REG_RC_16MHZ		= 0x6b,
> +	PF1550_PMIC_REG_KEY			= 0x6f,
> +
> +	/* charger part */
> +	PF1550_CHARG_REG_CHG_INT		= 0x80,
> +	PF1550_CHARG_REG_CHG_INT_MASK		= 0x82,
> +	PF1550_CHARG_REG_CHG_INT_OK		= 0x84,
> +	PF1550_CHARG_REG_VBUS_SNS		= 0x86,
> +	PF1550_CHARG_REG_CHG_SNS		= 0x87,
> +	PF1550_CHARG_REG_BATT_SNS		= 0x88,
> +	PF1550_CHARG_REG_CHG_OPER		= 0x89,
> +	PF1550_CHARG_REG_CHG_TMR		= 0x8a,
> +	PF1550_CHARG_REG_CHG_EOC_CNFG		= 0x8d,
> +	PF1550_CHARG_REG_CHG_CURR_CNFG		= 0x8e,
> +	PF1550_CHARG_REG_BATT_REG		= 0x8f,
> +	PF1550_CHARG_REG_BATFET_CNFG		= 0x91,
> +	PF1550_CHARG_REG_THM_REG_CNFG		= 0x92,
> +	PF1550_CHARG_REG_VBUS_INLIM_CNFG	= 0x94,
> +	PF1550_CHARG_REG_VBUS_LIN_DPM		= 0x95,
> +	PF1550_CHARG_REG_USB_PHY_LDO_CNFG	= 0x96,
> +	PF1550_CHARG_REG_DBNC_DELAY_TIME	= 0x98,
> +	PF1550_CHARG_REG_CHG_INT_CNFG		= 0x99,
> +	PF1550_CHARG_REG_THM_ADJ_SETTING	= 0x9a,
> +	PF1550_CHARG_REG_VBUS2SYS_CNFG		= 0x9b,
> +	PF1550_CHARG_REG_LED_PWM		= 0x9c,
> +	PF1550_CHARG_REG_FAULT_BATFET_CNFG	= 0x9d,
> +	PF1550_CHARG_REG_LED_CNFG		= 0x9e,
> +	PF1550_CHARG_REG_CHGR_KEY2		= 0x9f,
> +
> +	PF1550_TEST_REG_FMRADDR			= 0xc4,
> +	PF1550_TEST_REG_FMRDATA			= 0xc5,
> +	PF1550_TEST_REG_KEY3			= 0xdf,
> +
> +	PF1550_PMIC_REG_END			= 0xff,
> +};
> +
> +#define PF1550_DEVICE_ID		0x7c
> +
> +#define PF1550_CHG_TURNON		0x2
> +
> +#define PF1550_CHG_PRECHARGE		0
> +#define PF1550_CHG_CONSTANT_CURRENT	1
> +#define PF1550_CHG_CONSTANT_VOL		2
> +#define PF1550_CHG_EOC			3
> +#define PF1550_CHG_DONE			4
> +#define PF1550_CHG_TIMER_FAULT		6
> +#define PF1550_CHG_SUSPEND		7
> +#define PF1550_CHG_OFF_INV		8
> +#define PF1550_CHG_BAT_OVER		9
> +#define PF1550_CHG_OFF_TEMP		10
> +#define PF1550_CHG_LINEAR_ONLY		12
> +#define PF1550_CHG_SNS_MASK		0xf
> +#define PF1550_CHG_INT_MASK             0x51
> +
> +#define PF1550_BAT_NO_VBUS		0
> +#define PF1550_BAT_LOW_THAN_PRECHARG	1
> +#define PF1550_BAT_CHARG_FAIL		2
> +#define PF1550_BAT_HIGH_THAN_PRECHARG	4
> +#define PF1550_BAT_OVER_VOL		5
> +#define	PF1550_BAT_NO_DETECT		6
> +#define PF1550_BAT_SNS_MASK		0x7
> +
> +#define PF1550_VBUS_UVLO		BIT(2)
> +#define PF1550_VBUS_IN2SYS		BIT(3)
> +#define PF1550_VBUS_OVLO		BIT(4)
> +#define PF1550_VBUS_VALID		BIT(5)
> +
> +#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK		0x3f
> +#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT		6
> +#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK		GENMASK(7, 6)
> +#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT	2
> +#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK	GENMASK(3, 2)
> +
> +/* top level interrupt masks */
> +#define IRQ_REGULATOR		(BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(6))
> +#define IRQ_ONKEY		BIT(5)
> +#define IRQ_CHG			BIT(0)
> +
> +/* regulator interrupt masks */
> +#define PMIC_IRQ_SW1_LS		BIT(0)
> +#define PMIC_IRQ_SW2_LS		BIT(1)
> +#define PMIC_IRQ_SW3_LS		BIT(2)
> +#define PMIC_IRQ_SW1_HS		BIT(0)
> +#define PMIC_IRQ_SW2_HS		BIT(1)
> +#define PMIC_IRQ_SW3_HS		BIT(2)
> +#define PMIC_IRQ_LDO1_FAULT	BIT(0)
> +#define PMIC_IRQ_LDO2_FAULT	BIT(1)
> +#define PMIC_IRQ_LDO3_FAULT	BIT(2)
> +#define PMIC_IRQ_TEMP_110	BIT(0)
> +#define PMIC_IRQ_TEMP_125	BIT(1)
> +
> +/* onkey interrupt masks */
> +#define ONKEY_IRQ_PUSHI		BIT(0)
> +#define ONKEY_IRQ_1SI		BIT(1)
> +#define ONKEY_IRQ_2SI		BIT(2)
> +#define ONKEY_IRQ_3SI		BIT(3)
> +#define ONKEY_IRQ_4SI		BIT(4)
> +#define ONKEY_IRQ_8SI		BIT(5)
> +
> +/* charger interrupt masks */
> +#define CHARG_IRQ_BAT2SOCI	BIT(1)
> +#define CHARG_IRQ_BATI		BIT(2)
> +#define CHARG_IRQ_CHGI		BIT(3)
> +#define CHARG_IRQ_VBUSI		BIT(5)
> +#define CHARG_IRQ_DPMI		BIT(6)
> +#define CHARG_IRQ_THMI		BIT(7)
> +
> +enum pf1550_irq {
> +	PF1550_IRQ_CHG,
> +	PF1550_IRQ_REGULATOR,
> +	PF1550_IRQ_ONKEY,
> +};
> +
> +enum pf1550_pmic_irq {
> +	PF1550_PMIC_IRQ_SW1_LS,
> +	PF1550_PMIC_IRQ_SW2_LS,
> +	PF1550_PMIC_IRQ_SW3_LS,
> +	PF1550_PMIC_IRQ_SW1_HS,
> +	PF1550_PMIC_IRQ_SW2_HS,
> +	PF1550_PMIC_IRQ_SW3_HS,
> +	PF1550_PMIC_IRQ_LDO1_FAULT,
> +	PF1550_PMIC_IRQ_LDO2_FAULT,
> +	PF1550_PMIC_IRQ_LDO3_FAULT,
> +	PF1550_PMIC_IRQ_TEMP_110,
> +	PF1550_PMIC_IRQ_TEMP_125,
> +};
> +
> +enum pf1550_onkey_irq {
> +	PF1550_ONKEY_IRQ_PUSHI,
> +	PF1550_ONKEY_IRQ_1SI,
> +	PF1550_ONKEY_IRQ_2SI,
> +	PF1550_ONKEY_IRQ_3SI,
> +	PF1550_ONKEY_IRQ_4SI,
> +	PF1550_ONKEY_IRQ_8SI,
> +};
> +
> +enum pf1550_charg_irq {
> +	PF1550_CHARG_IRQ_BAT2SOCI,
> +	PF1550_CHARG_IRQ_BATI,
> +	PF1550_CHARG_IRQ_CHGI,
> +	PF1550_CHARG_IRQ_VBUSI,
> +	PF1550_CHARG_IRQ_THMI,
> +};
> +
> +enum pf1550_regulators {
> +	PF1550_SW1,
> +	PF1550_SW2,
> +	PF1550_SW3,
> +	PF1550_VREFDDR,
> +	PF1550_LDO1,
> +	PF1550_LDO2,
> +	PF1550_LDO3,
> +};
> +
> +struct pf1550_dev {
> +	bool dvs_enb;
> +	struct device *dev;
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
> +	struct regmap_irq_chip_data *irq_data_regulator;
> +	struct regmap_irq_chip_data *irq_data_onkey;
> +	struct regmap_irq_chip_data *irq_data_charger;
> +	struct regmap_irq_chip_data *irq_data;
> +	int irq;
> +};
> +
> +#endif /* __LINUX_MFD_PF1550_H */
>
> --
> 2.49.0
>
>

