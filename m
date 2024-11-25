Return-Path: <linux-pm+bounces-18024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0639D7B52
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895E8B20AE1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FA2B9B4;
	Mon, 25 Nov 2024 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="js3APmnV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B263C;
	Mon, 25 Nov 2024 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513567; cv=fail; b=DSerBhduGaOKoRhmIQXkiOkEI026C6i0cv2zllLNGNe9z8O6PPnC1a+Htk8nKmRBgCHUMeHlWRNfVYY1amWB6UhvLnMehnGEZgSSvmAUkW4gMwVnGJZxBYqdpLOvsbcXLxrQPE4T/J+J0nqHn8z8hVNjC3yMF60AmahBiZU7R8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513567; c=relaxed/simple;
	bh=MZuyX3zHBSqu4c2ziEYN9D5Ck0AFz4VCmtQPHFAbcdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bLCEJ8xNiPP6m7PbCgoq8HjWjCqck36Atl69a4qX0ckqfH9cTTSP3h7oasWlKVrxUiUNChGQTsQ7dOck6IjEH8Eq826YC50Esjm2RJynzoGSks+clrX8QLyklXZ8q2DcYEy+1BVTPbrR7OAQWckFyG69TCD+HxH81upYzhOi4xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=js3APmnV; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvHk3lJj9LGBftCykEhDl1zbLg5pxwFKdHYKUqwv3SPJS/auGssBvdPJ1HP93V44Qz5NzfgUN4Prw/Zj88JTCDlpaNuXRx/fWpjr5eTBlyIj4IKZMrEtFSnszozfl1hWnXUrpaEq7GTjrZoP80LUKEqmwu28QNmTdIQKtqDV72Q/YZGby2oQ8j2Tya/1RM65Wc+UtH9RWc/Vp2eAcfkQR8ZzdG3alS5v5C7lvt3amKwR/ENyr/MMOQig1eINUCrZClQI/VvWhIxCZfO6XluH8BLVO7ngl2QrrTryGxeGTtp7UqmgS1DVxvhE+b/YEJXeUK4/eLf9it6+x1LYoxqe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+frPFE2bJyu9Bn47v7XontoiQjZPEV6TzumWRe1pU0U=;
 b=LbBLHsJR0b2e6UpCPwQcfB0GPFw9AN8DgV462No9sOaBG1IinBmn6PMs90b2LsOVpOivUXJ9tQvT+S9KIxN4mrsC31SR9payV4yYJwZEBjxG4T5lZyoOck3bSeZX/VWbP4EvzMOnQtBK0EzgbLDlcmgX3kmNUNgwR5puNlumkmTLAuz6zGnEgzOpvlxsmH+kp07N1mri/O9UAPwJdskkgjjowxv2HxoTPDOrLiInXFfOglcsAzlw4XDitG94bRyXdDutSquwD/3dN1c6GAD/WfdRnSP4WFBz+74Gd87Pits6j/ziTJD3mALiyYql1j5W9+uTew+lPZl39Fjm4+uubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+frPFE2bJyu9Bn47v7XontoiQjZPEV6TzumWRe1pU0U=;
 b=js3APmnVPPq9Y6Hi7/8AJ3Z2CTgZk1h3DgTN/UzgrHYbH3N5+ERd+0knA6qAjFX3HWtgzZ7scT/X2z/oZaeijVQ3L8su0xrDG75kJDjPssn/0Fj3pfsvrzqnc6TOB5f1h7G1IoMXhVL/z9QMUHy8EyoHmpKnizKJAVCkEKoNLaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 05:45:59 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Mon, 25 Nov 2024
 05:45:59 +0000
Date: Mon, 25 Nov 2024 11:15:39 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <Z0QPAxW+UEu/Uf77@BLRRASHENOY1.amd.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241114115831.GQ6497@noisy.programming.kicks-ass.net>
 <ZzYyPzT4AwSkbRpH@BLRRASHENOY1.amd.com>
 <20241115101100.GZ22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115101100.GZ22801@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MA0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b0100b-85bd-4476-7dec-08dd0d147016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0vUc0DdbCz0YQG7FAoPGSxuXJdamDC+RsGddTzTSFgjSoQ/OSmHB90S/2QT?=
 =?us-ascii?Q?MrVMaDkt8kEkjrKeMUJeHvtD6IdTKxylBp8TWBrYrpGVo2gRZOz24TOQc/br?=
 =?us-ascii?Q?54yaFmm4XJUOgyCD86xZvKUxy1nxJSa4RR28HvVHuRd1AI8139Lqk+kLj+5R?=
 =?us-ascii?Q?S7dgDh3oq8SHnezbdZWxbtdm4haWzlnCokjMpEsFBVoGFaZJ1NoZxi9zqXqE?=
 =?us-ascii?Q?0Ws+NcWlWa+/R2LKm4TBBgAFfPn8CpMS+aP1ZS09gjZPDoG1E0yTLR1KUZHZ?=
 =?us-ascii?Q?fgRhcCM0cNnfQErLLihlrRAfiQ9ILMdESA6YJrmo7CxBKovErfFkNTTWT/Tj?=
 =?us-ascii?Q?c1hvjSQRlqdpRL37fUBBI4w4XJvY1Gci/yehTjv5MiRcS6KbfP0W2aF25eI2?=
 =?us-ascii?Q?WTt1M3lO2d2DKPPSHsfAAYuEJUGeZ+1sxSe5bxw2P4zDZH0wO8R8k5fywPss?=
 =?us-ascii?Q?Ukvhg7mIaTZn8QiXKVy14NN2sn38g5qQly+CD/7QD35qVIr7/ktnCQS5/AdD?=
 =?us-ascii?Q?/9YJEcb6cxbJ0AWiAL+z7ZqpXxrrVCjgLOH7yY4yYeRZa62UB8KBYbkCCNAs?=
 =?us-ascii?Q?oPF02+COCRlvC/EVh5+lGUyTPnRUeqFFzrJwQOXJXOslzMP56RgDBwdl+iyj?=
 =?us-ascii?Q?eBQL/zqROQ1WLWzdfVD12S4akmjr2e1ho+ShIcCZISMG2txf3/S4H0jsnjn3?=
 =?us-ascii?Q?LbD4VtrC5P1xJYz/GdpZoRy9vMNHciIHbLTKXzNdbki+aEibS8iJ2E8yp27Y?=
 =?us-ascii?Q?6Ns0AblhqAnnFO0NhbKaZqBsCSML0kQMUwg2vvtTpKe32SQW0+xCVGnLcpHK?=
 =?us-ascii?Q?OdaXdr0mH4wTDss1Kju5u3YGFTx/jTKCFo/rp7uhbkz0mxC+in9DdtHkP5+F?=
 =?us-ascii?Q?1v+sVguNrSoDATpZX34+7imBM+bytcIB2iXxCzYO5saTCywIzQ2Yswtbr7Fv?=
 =?us-ascii?Q?RbzXhKF4Heq69BNhfDBPuTmlvAXfiSHplxdD4nwL1h/231sjx/1U5asxP9tl?=
 =?us-ascii?Q?3mGbU3UPkqItW4+ksFBgy2HVecD4rBZmMGq/4ks8fIcb40aEDK6FZ7ATioK2?=
 =?us-ascii?Q?OOx/8BERxOxuWwCdXTnMltBxYBvTCECWW0d1P9XuSJA1PHNuR53yqn8uHkeE?=
 =?us-ascii?Q?EDDVS6tBOFz4H4zQtziMlpQgBZidicDP1wT3HYF8s+d2aOlcNfc19oBlIvn8?=
 =?us-ascii?Q?+GkOXbyhaoM5BFruDoDQzyTT1gzRafu4YMl3h1ScgVFE/M8sgMAMbP3Y8qrI?=
 =?us-ascii?Q?r0y7vHZLaOsjP1pDdkG+oTX7nXvCiS1UNe6TD+zdL9Bl47nuUB0L/8l9FzvW?=
 =?us-ascii?Q?4etpkJfIKeBTv+gLUXPR9TJuzmU8SIqaW9i1fFtjh0eBVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7D5vjk3gtbZBk6dAmMVAOg0ICWMQW7n6WT6lkAGJmTrNklsW0DjSf8In/g4E?=
 =?us-ascii?Q?aNqwi4WU3St569QKC6eLVtDWiCB0kmZ0AJCGeRNBpKYpLwhm8NPpCJ/qO9WN?=
 =?us-ascii?Q?g0WQx+UKgjoBAukLRzrDHFi93+/bdA60gSClK9lds/FCdeqZ88EnM42pham4?=
 =?us-ascii?Q?eGpbE3hl8rlgbPW3mpYht4E3jLMB0LaxdnNPDXw0garEW2ff7Bt0eUiPZA/9?=
 =?us-ascii?Q?p9evLT2jKZRxwWv+Baoc4nWkijVV9elTALo2NNR40WHjSvUWyAXMjk17yzAX?=
 =?us-ascii?Q?QfMk0DbYIt/1xplJl/5H0u1H+6lwFQH4K7UYDMQuguL1iIeoutvwDP+UClJI?=
 =?us-ascii?Q?6vM57Ke1NOrSj9+NvbEDOFTrOov/k+x2vQf6q+npjlqwZkq4h2NmLfhM/Hbj?=
 =?us-ascii?Q?sSvT195pznIDgYuG1a26DJYE1zXGRs0PryjI6X7TNpKjUr3cI69rcvxN0nGT?=
 =?us-ascii?Q?ClKxJKx+Vo4rDNGCYPYHdTeRbACz98P9iz4KP30+28wmxqkCzXZdbtQEymcc?=
 =?us-ascii?Q?3oBX/QVWmFFOhJw6SS93ETYerWyUBVZ1QdAUaKmIBvxIA+n3bcAsq8JD3FBt?=
 =?us-ascii?Q?/qpUvaNwIUGBLcU8Y26OBLkIyXKZJXbiedpff+7GKPzabjPsppfr+nLkO3WB?=
 =?us-ascii?Q?1VdHNbKw2CQ4jhdEkLWIb38c28PvuR5UscKmxvgXHEhjYbgFb01Xy55smX2r?=
 =?us-ascii?Q?pr6uIQvBgsbIHeYoSrd8KoRDaHtFPKY5AAM6moUBUf34ZjC4IIbMk57mkW1C?=
 =?us-ascii?Q?8szeD80YkptjXGvc+yXY2m8b+Kf2aCh0LAc8TbzS9z1E2lnpkQpLRYLMdn0H?=
 =?us-ascii?Q?59bvRJXfX+cjIt9m/Dm5swJnEfCskgzOqVUvE5C6ft6CLyz4og78So3ARQmp?=
 =?us-ascii?Q?gHIJakeEqQXuZCB003G1bQ74JmLGiJgiFJlg2fN5utqRczY45jfaNzd066z5?=
 =?us-ascii?Q?XG1gELmW4mY0XDAS3Ic+1aA5+ARUGL2Zxh59bN6aAA0ih2y9mx1IB3iMvBhw?=
 =?us-ascii?Q?nJ+ejqnfwVh3KrB0aBOtzHHrVy2A13NMCKJ/pLqFYWI8cka4CJ/KIIaT4vC/?=
 =?us-ascii?Q?ux1htnnyiU9VSmlFaDXnDsEANBcBTaIFRBdoZXjpbxo/RnhhTW7oQCFlYp9W?=
 =?us-ascii?Q?Y9Y0Da5vnPyPBcdzmFxdC29d6vD6Tra3c54GzmkRgPvjbiY2zQ6U6HdTwUyV?=
 =?us-ascii?Q?rElcNCjcF9X1a+V6zp6yOicJCiNWNVkwlzIjYCL6wLmcJ3xp0q7TLD6pEaW6?=
 =?us-ascii?Q?jZAXghqO/AvcwCL4ONY2q8rBkTkAPnb127WiGQADtEq+SWK+bGBjgOPO6UBj?=
 =?us-ascii?Q?zlyJJ1Yf+aAV95alPXHSwB3zwL+9tJCEJ+Elvb5eKwUptXRQTFVfsrYd0+Dl?=
 =?us-ascii?Q?lhtpk0WgCP4CKukcpG2lVRPBwzQGz+Oo/2l6Sr8TWQD77XYZN9PncEmK/M71?=
 =?us-ascii?Q?dE0CAukPrlXeuwU524AWe4/Rn8Nv6zDvY/qJqYEkyEwVWLe9LSF0xddodauX?=
 =?us-ascii?Q?g76WCp3w/Tc2mB0vOMY71l7nEQAhOWthx+STXQo43xEZgrruyUlsTe5+gHHw?=
 =?us-ascii?Q?s0zHV5pA0T4KNDZZRcO8gVsVVdwftiODbZ2IcHbd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b0100b-85bd-4476-7dec-08dd0d147016
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 05:45:59.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c/2WmryqZAYM/PO1xTN1nwpfhUrJ0nkqQDLoIeoWH0VmBdzPLoxouTMPhSqUV7neVF8EFUyKV5UfDy2eRNb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460

Hello Peter,

Apologies for the delay in response. I was away most of last week.

On Fri, Nov 15, 2024 at 11:11:00AM +0100, Peter Zijlstra wrote:

[..snip..]

> > 
> > > But if it were to use MWAIT for regular idle, then surely it's OK for
> > > offline too, right?

Yes, this is not a problem.

> > 
> > I tried this out today and there is no functional issue.
> > 
> > However, I would like to run some experiments on whether HLT provides
> > better power savings than MWAIT C1 with CPUs offlined. I will get back
> > with this information tomorrow.
> 
> Right, but in most cases you'll have C2/C3 with io ports specified and
> those will be picked for play_dead anyway. It's just the exceptionally
> weird BIOS case where you'll have C2/C3 as FFh -- because random BIOS
> person was on drugs that day or something like that.

It is unlikely to have a BIOSes on AMD platforms that allow users to
disable ACPI C2 state. That would be the only scenario when an
offlined CPU would enter FFH based C1.

> 
> Anyway, what I'm trying to say is that you'll probably fine without
> adding a bunch of if (AMD|HYGON) logic -- the less of that we have, the
> better, etc..

I agree, I will resend the patch without this check.

--
Thanks and Regards
gautham.

