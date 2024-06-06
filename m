Return-Path: <linux-pm+bounces-8712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C238D8FE7DF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3403A1F2269E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64457195F10;
	Thu,  6 Jun 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SC4lwstz"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2086.outbound.protection.outlook.com [40.92.107.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1461D688;
	Thu,  6 Jun 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680781; cv=fail; b=cgknajrYqqPYvyUfjpUZIKEktv/7RkIvgh0TDbvtchlW12RvUvIf68MwINqp67EKYkZxKuqI9Ga3XMjj1WR23DA0aHhWqaBqPAJdcI7wL/6yDgmwHt1eofczU+hdAmR15xJE2pL6WH3QnBTiyGz34fmRj8e1HpgScipFlybUv78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680781; c=relaxed/simple;
	bh=yTHdYKUAIdJRQlBO979yaiQ5PF+eMMt3Zypiw12F/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KBS3PU57yotdfA+kyVdHitKItGjOR02epqZGyTJVqP+gDnnO9+tOHk0r5DN0i50XDJZqyYe6j0/z1vcQc5Dmlz8NHH1Y2aPn9Dfuop5cNcfAabrArpC4+mhxZZGPIys55tXQXHCDbGimLVgvIdJpSUQu2cvN2wSj2D6fQ/Yz4jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SC4lwstz; arc=fail smtp.client-ip=40.92.107.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjlayhP+TJqKDx02J6t4dyPtcmAoYq2PM/TX4car2QKMKnd+51ZwwA3qWpVxutQLGRrQvu983FTeD91/F/zX0gCHiUCAShlO4wqMu6DVvY/H4btYpzngHfmB4glPEMmKfagxpFD/ZfTwke+UCsxOtKciCduR8a94eaPueKdH988K5FWbQhm9aVMfp7A5shKQhfX2uTZd1lIgQaGgVNVeFzGWOaaBEgswq/JOoZu39P3NvXSUJA64hUKAq/9328p0ya66sk5j5QC3fxnxRGM6LArXqF7l/icD8zqOwztWrx+nkZO66TCiX6gFQkTYjjh7TLCpW4YTCovj/yjpGR3Yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7RyNEK/SZiMBPFRsyChZe4sv+YZt9bOrcIjLaQkwHA=;
 b=gEsV7PBhRmB+HidY+41YiqLicP0B/o1r6/xPcqKUbG2dSTNpk5I+1GfYThAKYK2+Ymt933rj516f5A8WfK5C0qLVGVVFdRGl0ABoy2hYEJvVxJ4xNnHoySsSOcLwE3gq9e2YxEbQdu4kwl7PAbv2oVrAYWZFlpqzhUBF0NWl5YSn8O7J7htDCAyz4c5xXL0rM/6ACbOmTO8CxyOgWiF4wSQECR4pncI/NDmVRcCO9oW1/Ji2DgvDSIqNNrGYZuqFwIL0dEMVXKgM52GLqzyLZw8Ph2bS/PYM+7vmicqb3bmanE5jmcbxqu/IaG/MYHV7iCZfvXxTu1dO96+xnPzeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7RyNEK/SZiMBPFRsyChZe4sv+YZt9bOrcIjLaQkwHA=;
 b=SC4lwstz/BxzatjEIRO1+kXsb2ZhUrXCkm2T8qaWXHFEBUCcshimMex0phjyT+NQ20RvVEeOyJgTjjwG+AFVQyIUHRPBcVy0msFZEyyNB4olvlzoFOSMLjvh3pBar1RlcQVRYPjIKDi8mbeNIbnz0miUcUGp7NcOLFTWDOqlvvzlbasPysNEbr1rOpd7RRPrkWUIybIiifuPdi8uVh7p0oDALTGijnTX0ZVk9auq2mJmW2esQu82bVEBfN0FZh7o1YHqqxM9BDY+tr2WdrgSKLv7KIVdoG+juVW1enP6g3BKfi4JKxhftqBzLInflY1iii5BHexse2vsJ7Kzv5rm/g==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TY0PR0101MB4585.apcprd01.prod.exchangelabs.com
 (2603:1096:400:206::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 13:32:54 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:32:54 +0000
Date: Thu, 6 Jun 2024 13:32:46 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: sophgo,cv180x-thermal: Add
 Sophgo CV180x thermal
Message-ID:
 <SEYPR01MB4221F0E46F600E013974F21BD7FA2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB42189977B4172405F5704CC4D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB49531F55C8D7DC5D0050CAF9BBF92@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240605-tightwad-janitor-82cfceb1469d@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-tightwad-janitor-82cfceb1469d@spud>
X-TMN: [jFjPx4ocdXOp+2tsDXSBaiWOiBmI4omW]
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZmG6fi9fdSCC3P28@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TY0PR0101MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 897ad3e1-835f-4798-ba35-08dc862d2bac
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	PHQiJ6SYFtx8JefPfJdb8OKNuNemZM8hB6boojVMRwyocQMLeIH05/k+Gk/Ast4J3RTJCf8v6LgGfTLIumNQwJS7ishwilHnfNUqqj6MfZJmi/897269nlTum1t/NCefv5dyqzZZCGpGT5gMxiWg5mTrURgZ3Dh/FHJYEqKXAKNDTcEQ1IbukHW6STN2TWp4BraIDzeVtuNFpM3EAtlW7sc1Nksa53pSkZoGVgLObSztrDracxfPH4wndOmZ1eelcnXUBFMiCn+2r/v7f7+aqwJgMFZpw0TnUFMM+pbJJC8xQyqs2go3JTBKuze8i/B+MZZRPvdNedUJpn4gL0N1fC/Qxj6q9MmxohzZVBPNObC7y8RaapmJSzPLKQKx7FgtfGmqML99YzdGw0sOWxxgBB3guhNP2PwYhNMC9ridskKAGYqyhvZVc/35ASMIEAoF6qyn8RZSj49uux5yWwxZoyammkAdvmjKOTEpObgdYsTW2ZlIEiuYfONstAqcV/tnaIWcjzo5EYlFO47CzXkXmmKqw2ZBrjq3+q2NyAymgcTFyGlCv5h3rI435RIetJ4d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Qoh+eC7T/Jhs6tmQyrPLx6WigUMcr+EPuprH49c20qlHlTtXwd3BmhTRP6D?=
 =?us-ascii?Q?2Twwxgr7RE0r4Kd8QxhGry7yqg28iGSf5nJQaHGXDHsdqhwUqj4uC38S7YeP?=
 =?us-ascii?Q?q3FTfOsW/lasmgJwBUegk5MsqvunmVJLMn6TgBY8Kqye2SyzXX1AqiiyKYaV?=
 =?us-ascii?Q?9x92JyrHr7oOkMhq0Wy+gfrdOViQ5n9bsNx/Zht+OYjHFr/uP1NY0QglEy9w?=
 =?us-ascii?Q?SN4Z7VpX7Oi4ezaStc+2CWX/89SHlUk5drcnqQz6UUCTz0J9j44Wnj7BBNFm?=
 =?us-ascii?Q?l2WpZITb3EoUHMA33HzHl13mnAWc0iutysIfYGO9bADOTXGW5fc3NzMIRMcw?=
 =?us-ascii?Q?Uv3p6ZtIwc9YQIzmQeR8XhsMQPp2ocrnbWoFSLxaS4E1FpCKGo/JCdfugKxG?=
 =?us-ascii?Q?noLg5k+U3uE+kuupCvrqy7IDg49s3vFgscoFUN0MUy1yH2O2DWIc+9g5qYq0?=
 =?us-ascii?Q?8yTb6Rm7M+BS6qDahxKfLeUnM61zC7FgFRqFpQUWBx6LBmCCUwTavRztvL0b?=
 =?us-ascii?Q?om3DpF5/RNJbr27aL8CBPwrFJLbx6zxDzE8a88C5ZRx95KqA3pWsJiQZLqr2?=
 =?us-ascii?Q?vX1QoXJgrJS2WCN1aELpX3gLiuTICIQA0FfyTzYxHYvJ0BIVHe/KvW/KIJPn?=
 =?us-ascii?Q?IF+ngIgWy5hxnn4vPg59B1Yx3K+e0o9aeZo4gDKoSMu5Dd8Tg/wGFD7onfNm?=
 =?us-ascii?Q?o30YwonS4UFLbvj+POc1JnyD6IsInz0CdZRFUSExjbPFsAD09XJJne7Fnw0V?=
 =?us-ascii?Q?FS011LTgUw2q5r5K7Xq+rRDTIdLgrIAQYkTUrK51pIwvppt9sISaldzcpHVs?=
 =?us-ascii?Q?0+1lw7DTUpqUYFT/OLPXpRYAEHQ+euCTdwDtYaZ46VQYoWc/DyOAz3bPuUQj?=
 =?us-ascii?Q?8GXO2OSmk/G6pex+JqstqRqP0/DrdhN3BoExzRv57kPSLLG/QK4C8ogL5cko?=
 =?us-ascii?Q?BmAGD3dkd3XV1N96r9WaHBzn2nybIjKmIvRQscyoKNC9P1aV3v0Evo+LhxOM?=
 =?us-ascii?Q?QwOcmRe4+zrOGvofEiyTyKRP8BgnNQ32Q6IMMm01nPHEsTpCdQ1CgMaHMb1D?=
 =?us-ascii?Q?7rcBftlyhhdV23CwtHkCN1qn7pRqx1H5Pc1CkKvMvuxAMrG05ieLkPGcy8Dx?=
 =?us-ascii?Q?GRZ3Tqzqh3MBo8JtWdGBBsyCNPlOtl4OJiGaZ9BVRR+VRBviFMlTM/wfKKeh?=
 =?us-ascii?Q?qLG9Ike5o8XPLWMMiAQ+eRrFb0EvjI5LYGYfAeUcHORmKv79hCKwzvX7uwU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ad3e1-835f-4798-ba35-08dc862d2bac
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:32:54.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4585

On Wed, Jun 05, 2024 at 06:54:17PM +0100, Conor Dooley wrote:
> > > +  accumulation-period:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Accumulation period for a sample
> > > +    oneOf:
> > > +      - const: 0
> > > +        description: 512 ticks
> > > +      - const: 1
> > > +        description: 1024 ticks
> > > +      - const: 2
> > > +        description: 2048 ticks
> > > +      - const: 3
> > > +        description: 4096 ticks
> > > +    default: 2
> > > +
> > > +  chop-period:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: ADC chop period
> 
> What's a "chop" and why is either this or the accumulation-period a
> fixed property of the hardware? Shouldn't this choice really be up to
> the user?

The chop-period is an ADC parameter.

Both accumulation-period and chop-period specify how the sensor
measures temperature. Making these parameters up to end users brings
extra unnecessary code complexity. Being configurable for each board
should be enough and other thermal drivers have been doing things in
this way.

> 
> > > +    oneOf:
> > > +      - const: 0
> > > +        description: 128 ticks
> > > +      - const: 1
> > > +        description: 256 ticks
> > > +      - const: 2
> > > +        description: 512 ticks
> > > +      - const: 3
> > > +        description: 1024 ticks
> 
> Can we just make the number of ticks the unit here, and above?
> Also, a "oneOf: - const" structure is just an enum.

I do not catch your idea. These values directly map to raw register
configuration, which simplify the implementation a lot.

> 
> > > +    default: 3
> > > +
> > > +  sample-cycle-us:
> > > +    description: Period between samples
> > > +    default: 1000000
> No constraints?

Sample cycle is more flexible because of hardware designing.

Best reguards,
Haylen Chu

