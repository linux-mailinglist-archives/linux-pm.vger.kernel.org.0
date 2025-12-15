Return-Path: <linux-pm+bounces-39546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73449CBD79C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5657530133AF
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABAB32571C;
	Mon, 15 Dec 2025 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="i2E1ONX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021143.outbound.protection.outlook.com [52.101.100.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AD2D0C8C;
	Mon, 15 Dec 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797284; cv=fail; b=aJAvPFTctgu5gPxtYDaKhwCTik/06LAoHW8Oi0bIZqWEZ0SSPygWXAA6qWb+/qiIRukr8AbOfEjoG/n4J92bxmareZl6tLW9lUuxMG4Rv/qkP6Sgz90+JA8yc0XXNCfkJBEH2M4syhNTGTM8oteanefZg7Z4/P9smhUkDEMK1sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797284; c=relaxed/simple;
	bh=BM9Wn7qFG4iXTB/AYSq2WzFhTx8FNeERlzlizlMfvMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+9uFlNV6uo2lTPI+J8XskxU7ojHq/Ab4nliKMtZVoB2yEH6wf0R8RWyO+EWX90FeREM8Y/Ow9SvI9npAwoFDvf18FqqXHRHUTU0DoqXPaaDmyV/gptusXk7wUME87ZzBfOqWqqtHDKuAgD2hzoyKavyKGy7cEvUH832x9fTqNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i2E1ONX8; arc=fail smtp.client-ip=52.101.100.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob0eW2rbS48vks8gQeiNiscOk1v/AInKEAKg1ixdjQbkFBdI3fkAce3C8JmuOTkGpbHWrF3AO+imrZauR/jBX+1u3NyFyJ2za6PM5KdagBIL8cmK8O3qPcbt/m3TG2rztcWCqkQZCFNJZtl6N9p3C3cAt0Q/B0tTp/gbzl4GhDYVE65fk270LNv4skSXsDU5D+75LaNSbwfyd/tgEHT2nxd6NJBTTZyuDclbPRTpCReLDsv9PeSzgo6WUE09Udbvgigsdue1JWUFglX7PyfHySZwHyknk/ss4sF3G6bUW0qkTAT554I2EwzzIqXhZTXMQFN8XnKRUjo/jiJA49+u5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maoXwEDtMxB6oIbduT7rb1b26dynIWD0O+I5GulcbTc=;
 b=eKrrTu/nbX9EqX7qR/FiZsOLpUJtvUGMPCdVCD0ZaNrETZvPJLKqGAfn4CU0BOanu9lKO/4BTzOh9nDbPcbSWeOWZZ0t99H11NK7wS/xESJkg9KxDr8BnzM5yWinzDdn3+CdTvwZBP1HAJKhCZGzqXpcl9o5GAYfMGla9v0rBq30z2sicVxpzcpg3URgluTvj23jE/Bg4CzF2KIEbo09JALzV88FBybqKq2hGANjRa6nDS0Egguve4GPwnEUgnAedDa3V0WYncdOdzJakZwV7r3VdnCNT6s9mTx+ZGzi50/4qX7gf/gc9LvF3GrO+dCO2uyhwMCMQeilMZjU4MhscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maoXwEDtMxB6oIbduT7rb1b26dynIWD0O+I5GulcbTc=;
 b=i2E1ONX8t1Zapr7InGeske4aJPWL4Jf/baeLOJby24zrt95VnwYbZnXtrv9EuJ8Ry1iZGNRKb28a49/tKS2yhLonVxVhi2sxAeRkHLMce6zrnx/GJU5QsMa5ZagKTrH7Ge2xLx1nIa8C/OpCnurR8hd64b10UGnjB1Wrsqhdr10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3352.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 11:14:37 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:14:36 +0000
Date: Mon, 15 Dec 2025 11:14:30 +0000
From: Gary Guo <gary@garyguo.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon
 <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Message-ID: <20251215111430.756f8872.gary@garyguo.net>
In-Reply-To: <fmdoyqoyksspygcjg3wbqxtqqntunk2wfny6vvt3iq6wddwuzr@a4kfi2hcc5x2>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
	<20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
	<20251208135521.5d1dd7f6.gary@garyguo.net>
	<fmdoyqoyksspygcjg3wbqxtqqntunk2wfny6vvt3iq6wddwuzr@a4kfi2hcc5x2>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3352:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e879ba-ff35-4032-f286-08de3bcb21da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oaHtX5+NK61NPIIxNpqkGOkGnJfpshux93Ms0XYS6iAXrQ5dsmdjlnYfVhRf?=
 =?us-ascii?Q?lYJjPt0I/DYnV0b29qGO9QhVvNr1JDWBgX9HG55ji2/7zXKjCbAoGZF9L40Q?=
 =?us-ascii?Q?MkcT3vM5ZNof3Lp7MM/akdpXc+ZlA12p7W1RJyuwu+Y3IpSkbBZsdn4VwY/8?=
 =?us-ascii?Q?mi/iFjzxROYkf3u9oqp1dH4vAuYcz25oZ5ONkDYqJ/9gk01sudKq5ng7hd2G?=
 =?us-ascii?Q?wmxVLquttKfblmE+3b7j5iIwP2RalI1CBnDdhKhd16nr9T3ed0kmbQ3W/SZa?=
 =?us-ascii?Q?VmhJgcc+j/1+kCxJxAvhi5XIWnmmXyE7/cOxzVYVy+RkXHlD1Vo44Nk3s7rm?=
 =?us-ascii?Q?xY48cdts+t3HqViBuWuW4Ty3Tho9StEtsjDarbdiXM2gEc8H+19QNj/dQW04?=
 =?us-ascii?Q?XLA+I9w/LSyQCIS/8bicyUBBHEa94U95OA5ZgPGzN1FNQAyqvSe7i/C9Zpqw?=
 =?us-ascii?Q?+8RYBIscoi/QL5aKZxOhEj5uWsDw8bBGyENkkYuaQYcanoRdV8IcE5n6+IC8?=
 =?us-ascii?Q?+B1RH9FC+kAyw3kV/enHgslYeBwPbXYp6nFtEogYj9MDiA2gNDb7cLhNZbr4?=
 =?us-ascii?Q?WKDPCdf3NPyFLFNxtejFGFl9+9zQ01r0Un9uY5LUBcI4Dvfo+hd50oyq0idz?=
 =?us-ascii?Q?C6nFCvN/gkVx5otOuP1ekBOwpKsK5tz0Z//4kLSnp65MPULfSjo57C6CVAod?=
 =?us-ascii?Q?hBLWWcslc9hkf/e1p7DOvzNVQmL4jVCZCjCpzWM+6G6aJyr/80zQxtn3BUdT?=
 =?us-ascii?Q?IqjEqpEBm6u+kdckquvUXIXrnNdMxyAVsHJyAebp0XMbPWqrYfb0uE7uof6g?=
 =?us-ascii?Q?sOIB9q7TE7g2m7cfyuGH2+hhoDD3eLotGqkpYc6KIcDR9SwIUQeqDvu26KuM?=
 =?us-ascii?Q?Lu08aOODDOcEu/Lb9mZstLOKqzmfSjPjsdVQmKprlWfohqdi1+d9Dx677dQB?=
 =?us-ascii?Q?xOrGLJLeE+3CGb5i34beJZ794MZ5tiINH7HYLk3Bi7a1bnaoFk/0B9E5KGg9?=
 =?us-ascii?Q?eJVNorvC+GHZZgH3Bs6gxuDjS8dqClpRXZzJJ4POeT83yiv2BlClFexFFtC1?=
 =?us-ascii?Q?Nfgtqwtf6U2TXxDGGi443Yui2ymiRtSQAO0Va72nfmroLgDEWjvDU/C+5Mne?=
 =?us-ascii?Q?z96B34E/PCodlZZ6RNB+Ak9g9BJkiBpdGmM0i4rT6ZdLowALH3tMPYIwjk8y?=
 =?us-ascii?Q?XAJL6Qzl4lSbRm+s0m9unl58zAqhhV9/lBMjpoUTey6axUK/TXhUYd9Uziyw?=
 =?us-ascii?Q?IU28ZQ7otK5QRmNjrwmUmHSafO2502OIkR1TVmYWwk8wzHSFlpfvzrUGPwn3?=
 =?us-ascii?Q?Tc+blpqfev2xHE2locilVMEtPydspC/AljqJtu91bxq+PuccSHIgxgLOwGIS?=
 =?us-ascii?Q?y/gUqPddSuETXdgUg42hQ7DJGWKACiINRneMe2EFhft7TNAX6Ybq+lKrVrfq?=
 =?us-ascii?Q?T5FjoG3e9Qwvi1AmGAFJQfbiIBKMrPFd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lm2CpbMX3+d+AuqygpNw4+sdSsBTv0O8VL1cX94qQmfxUoRbGHGfj1FwmmRZ?=
 =?us-ascii?Q?P5uwTnyhIah/vugpZMBmwgdjT9FTFy+UUDSrvfyssQmBL+ZnccM/4aKTDXx2?=
 =?us-ascii?Q?O5o4AWkmsQaTxK/lKxWFk+cdUXtKCjnD6hXQMn8iyvxfblg0K/3UbIsh5gNs?=
 =?us-ascii?Q?kJDfWV+4+57/DvGrxVfgd91e7JNcJ888muHTyQSWcv1Kx8DyBaT6n2RlBHK1?=
 =?us-ascii?Q?pU9KSg9KneGdAc80OSqbXwPxW4pK4MQtrgJfifP1cg7Ft3KAJJB9FGpweRw+?=
 =?us-ascii?Q?T9sEbxDMl9eBR8/2UjiaofM/XVHVbBRYxNnWfYVg+bX//adZ1xmuTa8hCrnG?=
 =?us-ascii?Q?g3BVC88s3NSXD+kXog+C7K10u4f0hn+qU86ocx55u3Fhj0ekPpu9XXV3kqql?=
 =?us-ascii?Q?00ANIVN4eo1v0/zmUlDSJob9UbNeVlNhzCeX8RtUwL5ct4iqNK5OYeVo/Krb?=
 =?us-ascii?Q?Ugr99QwTC0BG6uSLltQyKGLMNXKq5/9rQ4AuUxJzOx4ZyLj2P3zWWGf8OQnF?=
 =?us-ascii?Q?G2kO/9ItUqt6bvohmM4bi4uAbp59DPiCRUkfKOf58sCWByrgck3vIak3BOQq?=
 =?us-ascii?Q?7hCRL/xWfcjkWNVKwxUt+NxnRP2nBMQt8VLPNntmzRUtT6+339OtGaHBtTKm?=
 =?us-ascii?Q?OextjRnkt/kf2ah0frQDQs57RzMiPeDLWh3bUq/mrLpgfJAYkO1GnCMt5TTE?=
 =?us-ascii?Q?Uo9H8u/RNEUzLpDAsUjeBLj2IW1gNZm8AI+pbEDw/kvwoWRHFc4K4EMqPFud?=
 =?us-ascii?Q?VxucpsXkckfl1NyZVdR1Te2ZZ6EmlqFCvyNnxEUsrivX/WaYqDnoPlxpOWDf?=
 =?us-ascii?Q?JW99npGB/JAwserRFjKBjN/lldpL9DQmvGox9pRdLyhnvhpz23p5OFFshb0A?=
 =?us-ascii?Q?wIXeEfhSejLUx7FNm/+Whyurugjycs6o4XzqJe1lt4CPTOUY78uQ9HpqLM3O?=
 =?us-ascii?Q?wNinkY0rc5D9Luuko/EvakHycY96kF/OmizADq8VUj1ob8IFc8nxfx/2T4nM?=
 =?us-ascii?Q?Xggty8iyiuFnWgXoap/PupYH0ARVP6F4DgCwcm4mAjMWayf2nG2QV6eQBRW6?=
 =?us-ascii?Q?1Ekm0OT4l6rCkox1tNP9zZBviyLpH68ARSU8WUJKuBHGygDwjNEo5N3TgxIY?=
 =?us-ascii?Q?HipJK0FHWpsJZYMrLE69x7SMq11u/+nCwSIpr7/Fx/ocmsMi3fHWVeY9Rye4?=
 =?us-ascii?Q?0aMHBiiLLFYAD0dYC9OLcot1/VHpgucmCNaWROOr60DFMa/3W5dEw/4uMNV+?=
 =?us-ascii?Q?Oz3NaM2T5omtBfdXjZ2MY90DP6vJ/IyIvh7eBLvPN+j8QMpQiZNxVcxTGL5j?=
 =?us-ascii?Q?bZ9T36p7CMoc1Q+SxaZ24GCyW+4hd9ydG7q6BF0fxkTjtajAErmq7sxSF9+Q?=
 =?us-ascii?Q?I0bjo/HC8W4L9i0Xk+ikpPvT8lIpsyHnxBBRxseZpb1fQIgVQnvLWHeearSV?=
 =?us-ascii?Q?s1U0N18R3dMsNfXYF4gtITi5CpTY/7KgCiA/pbswzAikkwliHvo08jdigBgp?=
 =?us-ascii?Q?XgRqLE56ioa/YWdJQOAZQiYE32wpyZFvoTT+RRqRV4ebflLyRPvwNddRxzzx?=
 =?us-ascii?Q?IxGbqXzgaUqa0odCuUWhIxv571joHDtGSdDw3VcX?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e879ba-ff35-4032-f286-08de3bcb21da
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:14:36.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yvwZR7UZgoitImJuRgwrRBIuxN1N1Ud92HcG90AzZQ0zaN5v44OST9PEHiNZZUm+SzE3JmWyhNFsN1XdO4rkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3352

On Mon, 15 Dec 2025 10:36:55 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On Mon, 08 Dec 2025 11:47:01 +0900
> Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > `build_assert` relies on the compiler to optimize out its error path.
> > Functions using it with its arguments must thus always be inlined,
> > otherwise the error path of `build_assert` might not be optimized out,
> > triggering a build error.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: c6af9a1191d0 ("rust: cpufreq: Extend abstractions for driver registration")
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> >  rust/kernel/cpufreq.rs | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> > index f968fbd22890..0879a79485f8 100644
> > --- a/rust/kernel/cpufreq.rs
> > +++ b/rust/kernel/cpufreq.rs
> > @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
> >          ..pin_init::zeroed()
> >      };
> >  
> > +    // Always inline to optimize out error path of `build_assert`.
> > +    #[inline(always)]
> >      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> >          let src = name.to_bytes_with_nul();
> >          let mut dst = [0; CPUFREQ_NAME_LEN];
> >   
>  
> > This change is not needed as this is a private function only used in
> > const-eval only.
> > 
> > I wonder if I should add another macro to assert that the function is
> > only used in const eval instead? Do you think it might be useful to have
> > something like:
> > 
> > 	#[const_only]
> > 	const fn foo() {}
> > 
> > or
> > 
> > 	const fn foo() {
> > 	    const_only!();
> > 	}
> > 
> > ? If so, I can send a patch that adds this feature. 
> > 
> > Implementation-wise, this will behave similar to build_error, where a
> > function is going to be added that is never-linked but has a body for
> > const eval.  
> 
> I already applied this from V2, should I drop this change ?
> 

Thinking again about this I think `#[inline(always)]` is fine to keep as
it can also be used to indicate "this function shall never be codegenned".

However I do still think the comment is confusing per-se as there is no
"optimization" for this function at all.

RE: the patch I am fine either without this patch picked or having this
patch in and fix the comment later.

Best,
Gary


