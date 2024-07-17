Return-Path: <linux-pm+bounces-11197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DCE933667
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 07:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C191C220A8
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 05:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF07494;
	Wed, 17 Jul 2024 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PtNDpQi1"
X-Original-To: linux-pm@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazolkn19012058.outbound.protection.outlook.com [52.103.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1899134C4;
	Wed, 17 Jul 2024 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194257; cv=fail; b=Wss/AEvrHDCP2XPfNhsxYl0wc8aiHnztYaRFVC15E+6mSN1suDUlRfd+KSYOa/jttn6aq3sUCMdIszs8s2i+jEfr/Nn6JYFWSHAcAIVIF1JtKN9pko1e3A2CH7o1OelGRvIr/rkn0zFuAvSaWOgEq/5m6w4jju94qbvoarPqU0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194257; c=relaxed/simple;
	bh=qepa3gaI4BjVV0BnLKw7sr+YKnqx0Kv0AOIcI56RQPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kig0FaBpf97sqgInO1q2dSWSX1qqZDQ+LHZv/VQjsUKT9J+hGaTXfbNN6FGx/beoVnwmaCpPowFtMr4NPVMBJRi5FQb08vPfpf/p3iQHPVMlQo5LOEJ+4tM3MifG4yDaXDy/sqyCIY9XZSmR94cHzLgnnqUnuknlfiz34Hv/jaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PtNDpQi1; arc=fail smtp.client-ip=52.103.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODwMn5p6beZ8s+M164C3FS5DbQmXYVTRiFGMNgBWpwPtAJUyaWkWlSDrmNmsg0ru9pKfxhhorVt/QerGPDm0wADr6S3rfxVqmPeO/HKYn5mRV/AnwLqjWQDhMtzixr9WPYUjengCVBihleo7PAiXzOs9nJwuUR8zOKkH3IKdbvbdXaZix6FcOMeDEPxNEHZPoJItI5Looa7Fh4PKpYVmi40Z3WG+vSRG5jY6cpFVxN9p6GKQe+HbdXmUg7eG1u9gKlkmi7isvO8IVEGeZlkdd7Rg9KlpoCWYCEpz3+nuu/FIn7EKSIwW8grlJqfiQourWR4R2e+D1GkVE1ixl5tIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mQbfvDMzXKCrOCCAddXpt/BV5ngupcDJrK6rwENnuU=;
 b=u5rnQQhD2AzMcQGbiRtimCXEAllGDAZ1qru4WL82fVr2PIefokmt4udUlDKzDwqvgAWS7DgyGvhcdYVMW64cWvARZdwBuH2kHPtJZdULrSgqrDUFo9TOZdYginlt5Y0mwVplPFswKAY/2ydboFDnjUbFFMdyreFSYbyHwKaTzaHmjC+X5+vbAHwRsqk/feUHM66z225hGwOS73Fx4gCeE2lVLjd3pVg7zLWONAuubutcUrcjo8o98CL1lWiq7CFzzQ1CBuYLtcTF92dBrmMr+McuOdZTbQlvq825gG9yvZerETr44y1/4VXwOZvO5z3kuKaFKN5jNEQbtNmXwfF7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mQbfvDMzXKCrOCCAddXpt/BV5ngupcDJrK6rwENnuU=;
 b=PtNDpQi1iaWPV9dqreLDzsEbWBpnllXmmIcfVzUEGw/noK+dX/qV31bSOt4/tlWRfdeDuBYLdsz560FX/s4xI4fzpJs/7+5XjfYYzt4uloRXIZt76xl/wP4ScD5is+aCJAWQB8RCjW07nJRb442rl/ee7zo1qb1vOLlQhMKCrcPOzvl3dXU6IXd+tFngjIFGRPXxQSo00/1wGw+iPjEpTeIbEKixMy2y2biL2+3GvPyKLKxMWo37jQV31m4GbGr4Mba++RHQ2FWn8vwlvHcoYGxHWiODDCPmsblQkjGTSf1psgk6dTmdEq0dDgqjBSDShEJA4VHcVIWg0Q0LJS0g3g==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4847.apcprd01.prod.exchangelabs.com
 (2603:1096:400:285::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 05:30:49 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 05:30:49 +0000
Date: Wed, 17 Jul 2024 05:30:41 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID:
 <SEYPR01MB42214130E7A922314CF44C3BD7A32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240716-cloning-canopy-a6799dc7f3b9@spud>
 <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953D97AE6DAD99C386CB7DFBBA32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822A2F07F21FC5445EF8946FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB495329786AD07F076BBD6867BBA32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495329786AD07F076BBD6867BBA32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [QJcw9foGKnQo2ASlSQASHCrnWOHlqjoa]
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZpdXAfkrR3I4tUTX@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: f593cce5-6716-4ec3-335c-08dca6219dba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	ufpSefTorHm62mIjaki5YTgdfelpAAV+YQPCcqK9WT4xq7zE31GRN2R1BLt+ZfXOLwsofw/DXLmBttyTZO4xhnpsJvzaYIwygXWK/o/7Rw7JpYj5k0W86YFqU8m8lTzd4LcretFCYgoWIScvmZUucTqMu8BjDzjb0/0eB9+FYA0x4WnpCO/XKjfMqdgT8tgs/ft3SUHcBKHDtWKfmRwkWNSJXyzoii+nrHOproJCwkbl34MrQ8XyBJNW3b8N9Jb3eSGGbf/WAwYPZ8HsGaE06ih4zSrVKxvPVTT4RPKTPXGqaObDNAwWtzteqx6Rzj2PHNGgGmtYImH3EqDa37+X6iLexu00jaoE8gh3bE1WlKewLlwkjW8bX76uKXEDCZOBH6V5+Yuo+qRsr692H6q0LP6g+wSW0jwTifrt9nIYIlmY7egVhpjVT7GgVHsJ1FSeEfyrI+pEO/i3rdQgv3hE6AGdI5DpLpfTitNlEOmIC/kStpQyAnQwfYVB17DbryNmQKuTtCQ/UGFMexRy7eGMz1PKLz3U1e+fmx2Z8UOxolPVQLPDFXEdJET0RSnkibhyLABBgUrEFnFFJATyRKUXKDwbVGyroRHvg7fzZshpg/ASUXEPkhSI+iKViF0SHeh+PdJmPKGSWlplaZxQ6fSmqA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9wnxujlhSysiTrGGuQajDF6m+XGZlsitm/p/F+IWCuW0949pPbhJrHaGh+9?=
 =?us-ascii?Q?4WCGM9FlNGYBfC1q4nkdXKp40msRj/Q9kIcyjNyOrUvJxhTOhfIa0j9BrXeL?=
 =?us-ascii?Q?HlT4lqS7qEVfWoMc4LaEdrdO94w7genzGFSx+fq4ANvjZ07eEyk/8/5i53yN?=
 =?us-ascii?Q?E0RUlCEucv22yXf5/nnBtxfPaoD8fwL6XW7FFylckSzNSl555l/cZkvsoPxl?=
 =?us-ascii?Q?RIJKL7kkDAoVjkeQ4DmQ1sNxejGYG0l6XhOqeZs0UVuQK1ssdjPIh4UMq9PB?=
 =?us-ascii?Q?K9TDChHzERonKekVTz2LF1RJCesejGcTaGCR0+NWCwaWt9qnXWTQu+fhsOE/?=
 =?us-ascii?Q?cPvKIeCkuwtCKT6my2XyOreZOjHt/Kv/rJ6NRZdzJhDHcTuqdlfBxDePxFb6?=
 =?us-ascii?Q?3Zcj6pWhIssfl1EGMBPOB72PtbToVuzVlMe7hFdF2YBLzHLqMUampax9ZGr4?=
 =?us-ascii?Q?ohehyXhuFLdNJo74BfoG6HEErbSOKgcy302xssfZhdQP6Kn78ySGRofMxh6k?=
 =?us-ascii?Q?G8vZTXSsr+/+y+IpWfw56WAO+ustyFSHk+ljn1uDwwmd1Doq3HNzX5vWEsyq?=
 =?us-ascii?Q?ePILHcAzZeOxvRgC9y9JCfWRyfqhqebc3xPjiAT57JMMBqtodKAemjDxjFkt?=
 =?us-ascii?Q?W1Z06AMABbOu95dpYP/tRTSq0W2iDxSGMPZidPsEHIUVKW734rAEGk4BqAJ7?=
 =?us-ascii?Q?8EtLRj2rbEOfHhFbwZ0n+85+Lyjrz2KY/txPukZ5PNUvwKQHQ13vhG3h+Mdz?=
 =?us-ascii?Q?sS1nHpdwmOe92ejLSrSwLxmpiuxklpVxu3730FbciKSoD7LYwOykhCXrvhoi?=
 =?us-ascii?Q?LgsCn8uqpmA671OBQ3INVCwbx448X158e8Lg//Ycp4Gy/PhJtGozVTQEVXTC?=
 =?us-ascii?Q?lV6yfOVYCL32cxqIPXQ0ZJqKf7G8PCPowHfT49NK68SSc72zZL5CzTlMmyin?=
 =?us-ascii?Q?6Pfe+xg3CfpLF8DzGs3OipyLGkOhXN07rCthgqCcP0b2/7Do7ZhrSq1kKXXz?=
 =?us-ascii?Q?FaMmbJFttJ6qkEWq2kXqxy7mRcFD5wZeaymVC0HjoDU/+KPrtE+GcnVLkLq/?=
 =?us-ascii?Q?m/cTx8N/NIJdEvKK27V6T2QkVk343W3GPUgCLrM/6CrpF5OZbeKDXb7C8dc6?=
 =?us-ascii?Q?czwJnTj/91IzwlseMU7jT9hWanp53HYdTNOXkNtNKrHiukQv/4Nt0ryu9DCN?=
 =?us-ascii?Q?991k/UwjqtUKTD0z/dJi6KUxfcHVmYyGt1vOiu67akC9WdOvK3hQWfCUNbg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f593cce5-6716-4ec3-335c-08dca6219dba
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 05:30:49.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4847

On Wed, Jul 17, 2024 at 10:27:35AM +0800, Inochi Amaoto wrote:
> > And allow me clarify, what I said "a compatible that matches an actual SoC
> > and use it everywhere" means to define "sophgo,cv1800-thermal" just as
> > Haylen did and use it for all cv18xx SoC chips.
> > 
> 
> I know it. But there may be something like the pinctrl. They share the same
> logic, but have different data and layout. In fact, I am sure the thermal 
> is not suitable for this case.

But for the thermal sensor, they are exactly the same, I don't think
it's worth to add compatible strings for each SoC. Even though later
SoCs do come with a different design, we could add a new one with
little pain.

Best regards,
Haylen

> > Anyway, as Conor suggested, we'd better not use wildcards (char 'x') in
> > compatibles.
> > 
> 
> Yeah, I agree.
> 
> > Thanks,
> > 
> > Chen
> > 
> > > > Or we can add ones for each SoC and have a fallback to cv1800.
> > > SoC specific compatible means most of the SoC have different part
> > > for this peripheral. For safety, it may not use the fallback
> > > generic compatible.
> > > 
> > > Regards,
> > > Inochi

