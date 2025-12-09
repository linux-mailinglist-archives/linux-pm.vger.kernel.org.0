Return-Path: <linux-pm+bounces-39345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E0CAFD92
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF940300A6DF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EC62EB87C;
	Tue,  9 Dec 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="L8C4AV6K"
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305011E86E;
	Tue,  9 Dec 2025 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281736; cv=fail; b=OStK28KCPxOz9ufe//vWHfSUKlcGczzCji06Llu6v/huEDmfenIAQBP7AsPZyOyxhdh2/UaJT/bDLtZtERTaTWd1eSvXU51JJDEzZZmnCviCddB3GHni+0TzmnByz2p92NSnxh78ZkfYBI9kpdjgE1W2kDjgCz+ohsWKDCyIO4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281736; c=relaxed/simple;
	bh=Cyou/cMmEIREwFY7itw5YlkOsQ6a7BPKqiIFwIQuTHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Le9BXt7VeJtlXhQf0G9cxWWQAcWhYvemYm1fXaHVbRpdj+MtYcbv1XV+KGKWP4fCS2j4qeawkG8ydka6N5jL0wSrzb6/BrLdYMfPAJhf/ME099ZKu3Ry6RY3wI6N5KqQUN1DDZg9l8gBsaamJb7/B2WQveLuHwSp7atri4cL2W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=L8C4AV6K; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+GZm3+H2LoCi3GUEOtDvxMvjQF91aMn/5Y258gOz/AHq+2MVbU9T1SzHhCg6Gbkp5TtJKT/HhZ58k7Bu2Lh0/5SSigKL622sP1OU4tMETBN9BB4ABI56v6dii1Qa0fVCisN/2Dx+xfLGfVrjZJ4DTMp3aLr2jCMd34PCvuMtifFUIMH7WkQ7BogwhlA+4m099RVhkhd7b/g6suKdaoU+eKhrcBkCcIzYxLtUXNbTUU7VNjeT7RpQa+MvRPKs+paKx6AmnKw1a8ZDmalcocKkPX+B8ivU7wnyXCI+P09seN2oRBbfee5/tDx2GtJqWw1H5PadjOuqulZ+wRLtLUKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2STf+l4tEWMBn/bsSWKdeecJsgwyGO8j8/68JJIB4g=;
 b=ewWMPz9/8BqN100FUXNzqASXwLLQfxxYPtpvTJns6/J11OK63tw85Dy9fYJ7h6VKynRoRigJI7FgAiSNvG5fvj29rRSoo1az/HsmVJ13eQezvqu8Ytts1bHK+7ccgDhnT5LUoefLZ6js0WLRgdSQRv6K11RwU4AzHKMpGjZI4I+ENim2XQVK6xa3upfWLqo0cY/C2t7IcHSKNptFRdCUVpOf/LmWLmhkNrhE5dkMLdAUihrpye5fk9WghRWv7LRS7hFW7fXp55nYYKWOEDxhUoFbFZ6d+8B2zvpwYzUDHUxWrBXuZWuxoVucsp26VNZxtlp/5GhFWnwGg/RBXAKtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2STf+l4tEWMBn/bsSWKdeecJsgwyGO8j8/68JJIB4g=;
 b=L8C4AV6KG9Ke3PLpsI+9YOVgNPP/awmrMY6+xjnk0mRuhAfNHxkufgclxscbKsEMDqk7WnKI7P1Qd97vyQ8lyfIbd5eSzijM/4oI9nQ/RlYLck7SXil1iCf/0kcgkFGeOSSzQqd6CnJJHf3DtN/cGb1qD2gyrGCCIoB6pMAcVdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2916.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 12:02:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 12:02:08 +0000
Date: Tue, 9 Dec 2025 12:02:06 +0000
From: Gary Guo <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Message-ID: <20251209120206.1b95a7c0.gary@garyguo.net>
In-Reply-To: <DET9WD6T0KR4.1MILPHIC2LIWB@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
	<20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com>
	<20251208135521.5d1dd7f6.gary@garyguo.net>
	<DET9WD6T0KR4.1MILPHIC2LIWB@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2916:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbcbc73-61a8-43d6-c4f4-08de371ac701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcvwsKOvDc0qafXHtjN5pZQfd6u+wn1nTT/q/v4inVjDFy8UYiSXXQMK0ST2?=
 =?us-ascii?Q?tdYzZl7o9sniSnREiEuHPG3uZJ3u7BfVRRw8ySPiO1rk+oriFzrQyQ7wOY4N?=
 =?us-ascii?Q?+S+6EBo0SUWrplEtTbAhRjcp7tovnBrZhoRFGpsip8S3VcreCzr6/J+vavL4?=
 =?us-ascii?Q?Gr846CB9U0Q+CDbtrhFFYiEvhsd4OvWr7N9bLUNPtkUXY1JN4yDiyxX88zIe?=
 =?us-ascii?Q?zjHJJCrtIjAFR0vXVhBe2X9cMEkyXeH2Szx9J/qNf+n9//qdURQGkp5EMnyg?=
 =?us-ascii?Q?G0pS5dkrRD4dPwNzrxF1IoiLQGxd7rMy1imXZbi2zMzrj7g99W4uZ2cuDt3A?=
 =?us-ascii?Q?pYT64akTM3iQTfHBrxKkcVVh01lRKCb4JiWkMQ0fHI31z/b+ZoPoCbC04Nwi?=
 =?us-ascii?Q?XIWKGxvpBpJhQidZ4jEwbuR/Wm2q6pc39yg9ewZkuxHhqO0xxB4L2QlUq2lH?=
 =?us-ascii?Q?PXG61Cs8E0ORRd28MDYqXtNr30TrudpaoGnYDv36N8G+CNYodchihx2Cocp/?=
 =?us-ascii?Q?9frk2wFEVqFTITfUrJDxDWaraMNkxGigfMnwgcd6szi8c+/iRMzz1FhTSQEO?=
 =?us-ascii?Q?rdX2p/KlEXZrsDCbES0042Mgz7PcM3yxYhW3jE4dJzgEX23l1+5gGZbxhiEO?=
 =?us-ascii?Q?HRwqsr4+clbcObZ1J/uqHvb7q+p/wrtRcEkaiFRzVn7xvx5URsml8b0f/ex3?=
 =?us-ascii?Q?ECVifNtmHgSiRp82dSGVbFqx1lWYLYUfz6l/IRSjG+PHGrxu691Xb9lvJ0Pv?=
 =?us-ascii?Q?TNHOFYqB6mdGFpH5FAZyMZWrmXEAsVFQOta+5oqjdaYi4KhGpFTs2MrMssmI?=
 =?us-ascii?Q?Ri6o6SlKn9XrqPXfTwAs/Sj26PNuwhzbtF0BJC2D44IwUltD+DGU6myTK8Dj?=
 =?us-ascii?Q?RwtkZGorXABSfjSQEfYjo54cr7182Kj2nLiYDb/5byzVsGgLXpcW93WDfnMv?=
 =?us-ascii?Q?ycArzVDbgVQ9miKCLqXoNYeam7uricA7uZ1RrBYyZpXspmiC+XoQ/PV06YHA?=
 =?us-ascii?Q?d2nd94123hxbklimS9ekkYq5RsRdEivemZevYij6RXjtyb9NNGmL+ZpboZeF?=
 =?us-ascii?Q?tIQ6kBM1SKb3ijA13My74MWjSJohIa1tJ0Ml7GZPYrpnoC/4IHn094akKOnu?=
 =?us-ascii?Q?IhMi1px+NDTtPoYGkHm56ziMuRTk0HZVVCeVjyqU/fhk9yXAIPdCkWV8VFlc?=
 =?us-ascii?Q?7srqdQVtLqMvHBcYflfWisUriH6m3GPNEHLXQ0XNlRVb+FNaWQi3HzdzIAO0?=
 =?us-ascii?Q?0aU5IcmzOthnCqge5b+zGcVqKHnnga36inY/5/Tjq7+xXMb+ags4hv80Iv8l?=
 =?us-ascii?Q?6d1sVu1WYhpeGJAN140ZSmrkY0Gyjl322sG3ENk88Oey+MdyACiZMc0lpHa5?=
 =?us-ascii?Q?SKbGs/a0s5lJP9rhxj/Rd0QZOehojyfVw0BNJeEhT4epN9DLzEFY1hCYv9wH?=
 =?us-ascii?Q?11RkJpJodpZKRe0aIGYUdYlyV5rT6Lie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeUVtnElwGjyxukbhNOsP5bGmfkL33m9F9FIyb9aj3/X1IS0LTSuO2J1i7qq?=
 =?us-ascii?Q?S+K5qk4ob3RIL1KNTfZI6ca6+YdVgPX32pAaEURTRR5QSNTNA4un3BWG8xPW?=
 =?us-ascii?Q?HOTc4UsT8AZMuRhwlgAQsscUyRhL/U4tkd5NhsS2Jzp56/D0T4I4NFpAiCai?=
 =?us-ascii?Q?xdCscuT8rhQb3BbGSOY1B2aB3loj80gM5bRDuNKMprP1es4GwXv7Ze1OfqWB?=
 =?us-ascii?Q?EEknx7Gurnc4Z6DcIveb6zi/FdcCUZL2wRBTrxFBXTzWz27iuwt+KVYsnS28?=
 =?us-ascii?Q?QYxo5VoA+nIB1UrNHe0sls45zYd+tv7xJebr5CFnvPtx69j904ClAWVQ+1ga?=
 =?us-ascii?Q?OZY9N+19jSwE64dYKPI7PFXgCXZUcO7NvwojNWGb9vv14aPNrD+V+jDNE5xz?=
 =?us-ascii?Q?lL1MLGZrfHVzYz3ptimK8kBCl7qO60jr1phbeaNzH+d4+IcG8tQ8n9TqEbYp?=
 =?us-ascii?Q?d7Nczoq2R4BYdt4wbU1UZDMhCnHTqJamWR9pf2syTD0NO1PnAeFjm2dpn4V0?=
 =?us-ascii?Q?OUF9Y28eQ6NBucuILGGPoNWL6wNAiIhpHMav3WgjKcjUo5ECm4IlEzLdz3Gw?=
 =?us-ascii?Q?KrMtIhPQ1NknXniebidA36b/jVn7xGClWSZkNtS1At3uJkwnPXO2LzSWOqcS?=
 =?us-ascii?Q?RFsqjlTTaqm517Y+womzoYV7bpr1Tp6e8PZUxSXlbFNAJVH45eQzrFILglEi?=
 =?us-ascii?Q?ZZnvuulJWVFrfwTWa4gHpx6/xqDjme7CCoUp6w7tRtSMaXG2nFsjUowYDC6G?=
 =?us-ascii?Q?mX35sp1+ZMlL5bzGM/4mSvyAR7qPFECjuCG7OlzOTJxQH9O8LKEVEfcjke1/?=
 =?us-ascii?Q?PoNqHsbXV/+gSHDKKkPrRMOhoUvE4NZAeS1QZ8JU70nD8jSFciaJSlSIOGIh?=
 =?us-ascii?Q?0xhHfueDokh8M3H51E4KHFQfVpd7SJohcfY1Kwn5JwTLVS4cbqlczWGr3HxU?=
 =?us-ascii?Q?wNCygiml4/WOqbgckE8bjw5m16spagXgoBtC0TtavFEnJNlXsF/5pGtCtGAt?=
 =?us-ascii?Q?3b7Rc09pc4vHQ+6l7LpA6I7AxU3kc7AA8WbqwW42WcLyVYYr3zarHBPcWdR0?=
 =?us-ascii?Q?CjYNjZUsv4geGgc6hl36FIcZPP37CBI/0EfBS/zGxyS/C63QtCHhoH8CUvF9?=
 =?us-ascii?Q?jmtbcWUO031mlpfkgyQVFHRXKVvedpKSP/OGd4sASJXMbJM5gGzw/7yt1pGD?=
 =?us-ascii?Q?gdMv6K5GNfeRraTwmtiA4zAYESd/gJEwEndqIpBcb43ofUry6HBbOeOTvA5N?=
 =?us-ascii?Q?GOTEiQE5yEBbY29FJQQGjqUU4oCBEOEXpkY07rGCnK2qMN1qKp7lNPJZYVKD?=
 =?us-ascii?Q?bO4aomdH9g25S4B0La+QkrgDamgOXqKGcRnCh7AyRs0NMSGnFkk/lecvAvi2?=
 =?us-ascii?Q?wpsRJ2S3DtUScLOGh3WJuRG8U0wfaZaqftWwrYA8W7PhYyeTEc9wyheoNPt3?=
 =?us-ascii?Q?5hiXV4CwI396oHn/O87GHMfwI5eMzQmlSLsE5dwo1OCSrXTxiNonXfmYfhVK?=
 =?us-ascii?Q?/KqCuRVGjFWRfie/3TP5BgG38Ejou3BCsHSbKqSGQe5EMikJ7/Z5sBlp+S2M?=
 =?us-ascii?Q?H5UcxvHrP+qRk1W00K91pPBJwqbquFBXyUlGQVWe?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbcbc73-61a8-43d6-c4f4-08de371ac701
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:02:08.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfUA+Z2k2K6XG/0WhJv2vNDAhjrtxHy0DZZrNPXjM+qYM2+eQ9Y/mYJ9zv7wMAl4jMz0Md2tN2YsG0nl0DZcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2916

On Tue, 09 Dec 2025 09:52:13 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Mon Dec 8, 2025 at 10:55 PM JST, Gary Guo wrote:
> > On Mon, 08 Dec 2025 11:47:01 +0900
> > Alexandre Courbot <acourbot@nvidia.com> wrote:
> >  
> >> `build_assert` relies on the compiler to optimize out its error path.
> >> Functions using it with its arguments must thus always be inlined,
> >> otherwise the error path of `build_assert` might not be optimized out,
> >> triggering a build error.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Fixes: c6af9a1191d0 ("rust: cpufreq: Extend abstractions for driver registration")
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >> ---
> >>  rust/kernel/cpufreq.rs | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> >> index f968fbd22890..0879a79485f8 100644
> >> --- a/rust/kernel/cpufreq.rs
> >> +++ b/rust/kernel/cpufreq.rs
> >> @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
> >>          ..pin_init::zeroed()
> >>      };
> >>  
> >> +    // Always inline to optimize out error path of `build_assert`.
> >> +    #[inline(always)]
> >>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> >>          let src = name.to_bytes_with_nul();
> >>          let mut dst = [0; CPUFREQ_NAME_LEN];
> >>   
> >
> > This change is not needed as this is a private function only used in
> > const-eval only.  
> 
> ... for now. :)
> 
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
> It could be useful in the general sense, but for this particular case
> the rule "if you do build_assert on a function argument, then always
> inline it" also covers us in case `copy_name` gets used outside of const
> context, so isn't it the preferable workaround?

In this particular case the `copy_name` shouldn't be used at all
outside const eval. It's specificially for building a table during
const eval. It's a bug if it's outside, hence I think
`#[inline(always)]` adds confusion to the reader of this code.

I get that you want to have a general rule of "if you're using
something with `build_assert!`, then use `#[inline(always)]`", but I
think applying that rule here is detrimental.

Hence I suggested adding a marker to indicate const-eval only function,
so we can either say const-eval-only functions are fine without inline
markers, or perhaps just use normal panicking-assertion inside these
functions (as `build_assert!` behave identical to just `assert!` in
const-eval).

Best,
Gary

