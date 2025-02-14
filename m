Return-Path: <linux-pm+bounces-22106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E08A36603
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 20:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB2E3AF222
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66F91990BA;
	Fri, 14 Feb 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+Evped6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029118B460;
	Fri, 14 Feb 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560269; cv=fail; b=NpVJamTXnCUZp2uNwrg6XT90X0HAfn1Y61iJJOtKKpT4Ntw2T0QQUorVsJBGE6jmk6iAuXQHwvhtnN+XVPVIqLPYPJSn1wr9IkvoxCsHGltWmTX1jK3FXz2ZWY/C/Mp3idN9TI24t3nNIt0cg/eIj91F1ZVac/a+Lxs1kzV4B4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560269; c=relaxed/simple;
	bh=rWQX6rqusoHori8jY2IokugvgUwtH3edzlfu0mJEILo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cCjZFva2ncsGIt8UsXuPs8uuameZwdhJ6lmUDZWA6xNKGBbfU/DMBdIoc542Lj0hs0OXc1agD53NONBAMMQD76qlrzlgwb4J2usflV5cWrDJXDfeScw9uxfPSNEQ2R9/mF/lb4a6SxBkgs5EFNp1UfpO85D5bl0fQnoPX6cEek0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+Evped6; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq5nl0Yar1AGVZShkjex3bGkfrPwsB3g9IFzly47rtnXIzUmD6FhQD7QuD0fNGIIxCcbsKR4j8DCCSybeXe16txcjrun5yvzNqLJkLHO//gLqslnPA9TtvhNAREiCv7qMmyRlPfFt0qeojZD7Hp6zF42K/azfae7A867htDypogcDOpdY2nypyRF4uIonkVUPBDFYhFaBlaFpacKgzTKPPPkgzYSzi+USHfgvtMmIga2AvrOX0XDyhtIWhMHcUyNrZyN6Zt+oWM/DdauNqVE1El4//isAUN5eQuhAisQ7+bN6VqTRzC3rKipCZMJIKFJ5wJN27ao4AtaJTKb0c3hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeD0sNUjjdVwbIbX69RRtJmOU4ygML6QkvG+yPTNcco=;
 b=nvgojIrYij5T/oYMoOxyzG/5ieKeMtPc1xRER5twGEFMf+fLKfZum8ZTb0Uv+ijG2e7tJcY0roTTOzoAeti7WcsaT2mSx5tkYCbvQtC887p7e+/X0q9AKHOqX3CDlfr8lIW4rCwHXo+LHkQKhhAEV+cLNKUsYy87vpS32en24IxGevuKSRvId0nJAR+41S2xJ7yuhiyQR2ilhUJIvdMCoODEkLcb0JnxYPb3/8UU/mhmNlw8D+LbMK+jtGzWaHRYrF3kD0xwz8Gai0kh7pgdOJV/qK9sadKacA4wjosXzKPncsQdLt1Lf2Sqe6ky9ZMEg4pAkToI0yLGh+jqKCYAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeD0sNUjjdVwbIbX69RRtJmOU4ygML6QkvG+yPTNcco=;
 b=g+Evped6CehQEycFWxMFXEtHZbvcQxUpVD85nLrZDMQo1NgVtVuvt0Kg4JtZQrhyqY37Vc3qRjBjBiAXdQmKooQ6rpFITi18l9bJqwlLf0LoXctz/PShN6gCpeteYZhOIc5DwlPjJ563vp8aaR5QeSJX0eWMHIFJWtneXWzN6YTKeOOkASfWkmfLx3dttlUrWJj0LpQ7XIJq/oW92fJzCSPOefTAh1DuP+tqY2nhaeZ5Fm745UwchKDcGHulTIbwsb1ugWt9V3MYost/RmsC+eaYY0+i3P+UBzfqc7taILrGFTmcQMP5/Ft9z0K+UQTbo1zifzc52nJngChB4FKwmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 19:11:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:11:04 +0000
Date: Fri, 14 Feb 2025 15:11:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <20250214191103.GH3886819@nvidia.com>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
 <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
 <Z66oWuLwY4X9Ou9D@thinkpad>
 <CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:208:329::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e5ab88-5ee8-4f17-8f90-08dd4d2b5416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcEb/M55KL2EL6r4NX/jLTaq92PxPT0b/owzE6FSPINPQE/znXSws7JA+f65?=
 =?us-ascii?Q?g+eSQKmSTXNFCZp8i0158bRBEzKgbQdw4uRhQCGWieBFeoSVYXsFG968AeAs?=
 =?us-ascii?Q?0MdvU22f4aGJ2P5uj+lxxeiu6N8jNh84R8M4Y8FVuqIT6NxNBv6EFnvY0Llb?=
 =?us-ascii?Q?Ap/QChFdPx1d16vdX3YKQBJl7ZKgIZLNiPjA34jFv4j50uZYhZu357Uheob8?=
 =?us-ascii?Q?EYDwsr8CBxVLXdy9/w3iE6kdN3OqSEl6B5a2goT5/EcC4j31pCe8PMOZ7ZVL?=
 =?us-ascii?Q?L+e46ZqcT3bAWWvkTQu4TpazHPOuoBQjyWfKe8AmKkUah/15XzfHHNeU7VPj?=
 =?us-ascii?Q?HOwJ+kQGf1Q2GI6P74a/Zti8IUgxNlf3UhXxt0AmGjOB3XWa1BN99XGSanO2?=
 =?us-ascii?Q?J0ogMngnk92+DfyYMfbLIzpQPwbSvJIQaVPMLT8joTnE6ZT590rNykJbU7V3?=
 =?us-ascii?Q?tyKJ3eeSfqfiDprQddg0wVdAXJF2+btNt6PcZnRJSayEOC5ajAgjiERcv32W?=
 =?us-ascii?Q?VoqlQUvTLhdX0TQIVY5oYnOC1Wye8caozrRxsXzc+oisOKDXxlUlIYEPNSZK?=
 =?us-ascii?Q?H4Np1cBsVtGB8DhFgVI2uts7Z8UAmXxhnSFSb4C5/8LkbB6kFKZ0ontF9P8r?=
 =?us-ascii?Q?ceO9eNB+jzdpgcyICK2m3OZUBYqEwOQduLRg5TgR96VZglB83Iilikc8cHJ6?=
 =?us-ascii?Q?GbYKDXmYuaROfUuTGr7OwLQHP2HoCOmOvuSQIoy2s8/a+W5/QpkzwaMgE/5S?=
 =?us-ascii?Q?KeZdPiruu13ILMrzWELeELoj9bVqOSvZLMS1ZTWK7ftrxAt5XwRJVRhXfjdV?=
 =?us-ascii?Q?D53YUYsrOVicd/RzwapurIYmhCYLFLLr+jMqW6AibIra26t02PB1AogmdzLO?=
 =?us-ascii?Q?sGOEd8nHGP6DCn1WD9HaDLXjWisa1oAsMpsAEGFU+5OGOjJxTvKjR4lzWOKr?=
 =?us-ascii?Q?iMnOKNGcnZ6+mGkn09c47V69AMo1zy3JAivjVSmsTsKO1PhYIRK5zuQgvTCV?=
 =?us-ascii?Q?y1eAkZ1e+NHZ3FRQXZ/XcGVWVrxw/rD2e4uaugphVlEw92bdckiJxbMcidzz?=
 =?us-ascii?Q?JYPv7ErcyStpQaX1ROcSzqb9dBn9fptwwJdigxM4d8Vq8RghHfRvlTvjiHN3?=
 =?us-ascii?Q?ka4JHyNmyiiZdsV5ZQV4P+OnkMagSs5czbcF173v3EbNhfOFcxaYemseq1l9?=
 =?us-ascii?Q?YuV9CSZBb0eKHu9lNqz6IS0cBgST05KRhH31pjwsuusr453i5kB1HWBb8yDX?=
 =?us-ascii?Q?xJdcOO25eTVcj7yVYbxryFaywQMlMfPeroK8RS+hAJlHJcrWlNIskWUYUTxS?=
 =?us-ascii?Q?wihLDD3iXb3jAkvY+dVt1i2a4DwVrY4qdDpr3vjNwdiy4SfZCFLcRr+MMhrh?=
 =?us-ascii?Q?dWRMuBgdZ7jj4FVQFY9ESRe/7Tj7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FCetjOBmDZWI4mtHH+fPmRS0rrvAwLqKafi8A982N+ErOvAFh6pkSgvr/MZt?=
 =?us-ascii?Q?NR9QIWSsW+hEr51i9DleoniUNfzbCWrKKhL9gEwD1kCL8WnunorSw1as4TxE?=
 =?us-ascii?Q?PnIJjiHWvoGhG0oWDjrxQgV5vWb6duEBCh9khtUc//MGwkkZxj7t8lL5xuVK?=
 =?us-ascii?Q?WMk5DcMc+DFH2YvsdYR5lMFY6JgWk0SgTs9xymLVxNKl+Q+YW+Ksxnbi/o5/?=
 =?us-ascii?Q?rMAiLVP8fnPD4H+7SOYTzx5TkorjNBu9zExa1iGiqsWSghlGZ/DFw70jI+N4?=
 =?us-ascii?Q?oLPVgn/TcUO6yDEJTpIpSM2xXbyPgz+RPEK4OXRRvCp1VdHR9qylexIGfgYT?=
 =?us-ascii?Q?y7TDmUy10TnxOIFOPX34aDhSnAM3j3OZLk4hZmVHJykbwYhx4+PlS5MY0/R9?=
 =?us-ascii?Q?meITF7m5XMPNQ07v5iAbotDeCnbNmRR7GHQwS6lwrWyal5y6yhhPrv/FosJ6?=
 =?us-ascii?Q?GGUNtzz8G11DeCv1wKSNOyu3dCdmHUkchM4iBSbv+klZVhoSKZcjJQ917AET?=
 =?us-ascii?Q?kLCBov1iCVNFDedCKwEcygYd09Cbq3bM803lDIHSf09X05+mp+vSiRbmfk2/?=
 =?us-ascii?Q?LrdizMWV2RSZkqu7D0NV5by1wzWbMqcRBNfiR9spQXPUZPTODFa5NDn1ZJt3?=
 =?us-ascii?Q?gnAnfVZCMnIR0oLh6WOZqLiXSJPbG+N1nTIgdDQn67HeJVQV8eknJ7JC1wSz?=
 =?us-ascii?Q?G8yryWW7iP/szBLl/aguFfBlb3SxumfsMEdLHX7hZEEABnmr36i65ujwV/cN?=
 =?us-ascii?Q?G6sKOvY5jWqbrZ/UfrTT4B3+fd/w0Gau+Mwzup1t7deAA1F3LwTJnhaOxZUk?=
 =?us-ascii?Q?naCtHznJ3tg9nzs5hkV+J8/LtaAF1CP7xtf4k5wzQQA3fRoOfM7+LjKy+lfk?=
 =?us-ascii?Q?+/thEk6gFS1veSsJOtaocW4DY+XWJn1BIbbPoZAgZg8socXY1wzZ2vn8yh0z?=
 =?us-ascii?Q?sSHplmwhv1hVffIQGGWqXHv/n9JpW8PX4tD72tpR/iU0jZy+tzUZV9XT640L?=
 =?us-ascii?Q?8vRvgQmbh10ndVrC/LdfsEGClQT7O+MPhgkGSm97yV9/19XXMhs0isnxgrhb?=
 =?us-ascii?Q?ZxOuqGASxATfZaHSa10pO0fGioLZNWXBJkJv4092nyhNzgYCGB4h6FLHgYAD?=
 =?us-ascii?Q?LZIzRjc+gxiTg0zLa3uRA3+GMePbIx5YzcwCq6PIpmfN8LZ8Ien2WZLGTQRm?=
 =?us-ascii?Q?GwJtSF5H6H88CbdkbEHe+a56yQHRBkjCI1La/INZKZMQtpNcxXfDasNcQcqZ?=
 =?us-ascii?Q?2LrhRpRvD5EYV0JxnGNLU1+mzFr3IHPLtughjjVMjPx0wf9kCKQ2CdQ8DNfK?=
 =?us-ascii?Q?GqeOr8DFzlkc1LW800HT7I+QGZVKuTUY5jErkJ4VEQtxXfk26Dfw4fcYvftI?=
 =?us-ascii?Q?PaYgGolj4Z61yowH6J3IulnCP8ZSn9j176gjuiXPjmAgK0b4W627+vox+mGu?=
 =?us-ascii?Q?doy5aB1uHHrcboolSjUS6miAnGyfVJim0WkkUmzpMJGuuAQlA5WbHxewMdYP?=
 =?us-ascii?Q?H3rl4rtWctlT+0bT9bR6cViEcU/+m6fe7TBrRtu8aW9V2TfnGFONrU0/TCA0?=
 =?us-ascii?Q?n7yeGeEBC/fJlvtaN2o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e5ab88-5ee8-4f17-8f90-08dd4d2b5416
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:11:04.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oWpYMGwHmrLTRqgz+gQZ8qTTsz0oBvUZxuxsThk0qbzXWXwKNVdYQKM/+SvAbEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

On Fri, Feb 14, 2025 at 06:56:43PM +0100, Miguel Ojeda wrote:

> > I mean that Andrew's branch got broken because of it.

> We also never promised we would fix every single Rust issue spotted
> across the entire kernel. We try to do our best to help, though.

Sure, but it was said, by many people, many times, that "Rust is
allowed to break".

This is not just my incorrect impression. For instance read Philipp's
note to Christoph:

https://lore.kernel.org/all/293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org/

 > reassure you that the burden of keeping Rust abstractions working with
 > any changes on the C side rests entirely on the Rust side's shoulders?
 > (because that's what the statements made by the latter seem to mean to
 > me)

And Greg's version:

https://lore.kernel.org/all/2025013030-gummy-cosmic-7927@gregkh/

 > So the claim remains the same here.  It's just like staging, api changes
 > to subsystems are allowed to break staging, and rust code, and
 > maintainers do NOT have to fix them up there, that's up to the staging
 > and rust maintainers/developers to do so.

I've heard the same statements at conferences and in other coverages
like LWN. Frankly, I never much believed in this story as workable,
but it was advanced by many people to smooth the adoption of Rust
bindings.

>    https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rust-wouldnt-be-extra-work-for-maintainers

I do not agree with "Didn't you promise Rust wouldn't be extra work
for maintainers?" in your document. Clearly there is a widespread
belief this kind of promise was made, even if it was never made by
you. "Rust is allowed to break" is understood to be the same as saying
it won't cause extra work.

However, I am glad we are seeing a more realistic understanding of
what Rust requires of the community over the long term.

Jason

