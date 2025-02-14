Return-Path: <linux-pm+bounces-22110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926A5A36734
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59EE3AC5F1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE761A83ED;
	Fri, 14 Feb 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fP021DDi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D417E;
	Fri, 14 Feb 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567205; cv=fail; b=XxzU+iRlLs8+sPejOB9PEgOVsQUXVDN/ptSJkfHOv9pCCckhO4mzrUF4NW9UUnJIr6y1I6hgpl0ie796m9cZRxZT016k8LW8QUpmBR0IPJahx/FwAqwm13lZVjUhfJn0T2u1sCXdstQyb5kwcule4cCjYAS/B6kQOo2/RJ9ffec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567205; c=relaxed/simple;
	bh=Oc+v6pLQFxcDCd4f+2dHebHzzZxRzTiZeu/6TvezfIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ik+ax2yP8Ym/UAUjVGhb8t+kxTB1fSCYCVy5xpY3AdMdTXWgKQgWyPLynM9ZiV8gGslVzO8lttxupZXCK6rT/q++i5GsFGm1YXbLd0TZ7xWBhycUkfBOw0f0xp+pkHfzQePWtm0ysXfUp/H705z9YSmU+ivVvXq94doZ5Wfvpe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fP021DDi; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYiQzPgC8oRvalwAcT/7pn58wlYxGIDgAcFSYVelIpNd+J8JqHqLYzGqokcqsCRevA+kgqTzkHIQ/iHl4WdXMVY36El0FoojwO27WxUvCVL68WvfWUyq3ToDI2g3S9DL3CB74hiiFBoSc5DBipNc1wLQNjVMlhVzIpdYJQfgJtBmIDBQdeja/p9qeHMcDWPcArUixPitTIe7OwBuaJ/zF0Z4K028GHV+o1PULbSAUXEX69vrkbof52Ey5lU9nVL7r7ccltSDHyFnXCGYepjkhzBu7Ocf80jTAJ5QucdQXikuNqlWhSNfvMg0c2us/GhOqP3noSFyNXXVvcrrK+lotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrS5Y6twAEiI8VhPlFeMxjuppqNNnTI5zunVmHRwDzg=;
 b=RX/OonUBklL4d1j09M0LhM62L84Xx40UR6PfFC5reLrGZ2KaHshTjR8jknYHtZBnYrdRzXDA/mLGzEOiVKyWGLiLLWtRxNz658MsDyJmUout8kMV1UTdcvZKtGt4mdTprL8tqZ/CsYP41XZRrLpfAE4lSK4Bg7sRzM+FDRbV2GHVQ4/3kDwOpEz/bFKVn3jLsLzp7TVy6yriD9wOVPiW2+bXJxU8Ck7Fd2VKDHO6qdzNzlVwCCfa3FkbFJL9ecuCSHaQFK+SniZ3XxPKKEyG74gVOgHtjvzyZTprLVKAAk8G7Zx6Ix5OAdHjqgA8cpVRq//KSEGFcSDe2lihBcx9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrS5Y6twAEiI8VhPlFeMxjuppqNNnTI5zunVmHRwDzg=;
 b=fP021DDilaruv+Sz3Q2KkGknQh1sN3HJyznYSO3XF7QgFfqspyZ5ytotBMLEVjxiA4BaxVp5AGInoJIAS5rsjTsRT1WI1akYxrifYvyNr97zMOFJ3Kb1T1ihi/kYckTwWxojGjIDnTZyCu7X6bNDbCnuIGAg8J5VLmKlpcEm1JjiNMIhRaGgY4j2l5SOahJ0vNCiysZKF8E/+S2FNzGp1lUrGt665w7rL31tedaxYjRhMegcGTBQIYwLcQaw2s58eOc+3rlRo8PLmtRW6qhUVCcY5i+7oDOUtBJGudOioT/vUB0gEirTxoBEI2oBLe1vBmozAwfzifDzqXYiWPio7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 21:06:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 21:06:38 +0000
Date: Fri, 14 Feb 2025 17:06:37 -0400
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
Message-ID: <20250214210637.GK3886819@nvidia.com>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
 <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
 <Z66oWuLwY4X9Ou9D@thinkpad>
 <CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
 <20250214191103.GH3886819@nvidia.com>
 <CANiq72=tDhUEjdBmVTPv4cFeD8iiKwJAQD3Cb1=Y4KnE-vh2OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=tDhUEjdBmVTPv4cFeD8iiKwJAQD3Cb1=Y4KnE-vh2OQ@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:408:f4::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: caddebac-b0c7-4d34-9ec9-08dd4d3b7907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWRvRUJDNlFOdDJ0N2x3M1psVkpqc0lWMHZJMGNjcVhpc3RoRDRKNWVNUUpI?=
 =?utf-8?B?MDVCdjFuYVF2SUU1R3M2SUVlUXBneFY4SVBDLzBlNjBpQm1XRE04cHdKT0Nk?=
 =?utf-8?B?RVNGTktrNlVESldsRWFETWRESGV0Wk5YRDc2UEIzTCtPZVhUNVJ6cTIxMW5p?=
 =?utf-8?B?SEFONTZtSWRiUlNObzVEUHlLNzR2cE9YSGNUa1N0SWVqWXV5VW1nRktldSs2?=
 =?utf-8?B?eDZDSEZrTkZnMHpDcjdzRDQ4VjRsTVpiL2JxWjlsRmJBYytPK3ZjbEdkcDNI?=
 =?utf-8?B?bkdRZmJCRkhBNlNRRy9heGgwM0Z6SGwvVVNrZjlsaVg3WjN1K3pPREh3VzR4?=
 =?utf-8?B?NHU1bkYwYk9TVGNRZkJqMXFYVHB6bVMyZFl2Smo4dUhrZnI3QzNPVTJRNWt2?=
 =?utf-8?B?WDI3N25aUjVjT3NKck55bFpOMW9YaEFHVDVXZkxiN1VQcDBUSmU2V0tNYUFz?=
 =?utf-8?B?dUxJemZsbXlFbGYzUXFVd01IbU82ckU1cWJqMk1HMkVsN0hwNlQ4S0xEcWpP?=
 =?utf-8?B?Ylgza1dMRGFqNDVONDFIOENBd1U0TVFzWlhWaG8xMTlpWGFVZ0pCSGE5T1Z4?=
 =?utf-8?B?T1pjQ0laZlRhSzhyd3pGbU5DSWVwb2Y4NVJWSzhNOGcrYWZPRkE1Wm1PVkla?=
 =?utf-8?B?NENudXd6dUZ3UGQ2WG1jM3IxQ0kraDdnTS9Rd1pVTEMzSDdabVNHeGpGNlk0?=
 =?utf-8?B?ZzZ6YmtlWnhtdXBnU0FPYXB6T0t4dTM3c0VHOS8wSVFyTTNFOStIaVo3RFlG?=
 =?utf-8?B?VHNzQ0xadlBYNlVicWpvWUJ4Y01ORnMxclZFWllwcmRLb0EyekI1eUJqS3Vq?=
 =?utf-8?B?KzRPNFh5SWg2REttTG5BWVgxbDdKU3JDSjdwaXNMQmxmTGgvbWVBcnl3dExZ?=
 =?utf-8?B?QlJKNWZaeWJ2Z09YYS8xM2VNSm5nR3VZMlV0bE1OUWxtczNLc25ic3puQ0dt?=
 =?utf-8?B?NFZQdlRJdDN0dUd6MVNiVzlLSnBQQm9NQ2F0WHVvdzl1RjdZZGJzRnVnSHhD?=
 =?utf-8?B?QS9jSkZGc1NWdDJCMlM2cTdQZEFLdTlHcFh4Y0xMeTJneDg1RGYrT05OdWJH?=
 =?utf-8?B?UndTN0g2c2lPOEcwSWMzNlk2WWE4ZEtLU21FNzQrRUV4ZHl2ZXFFcmJ0WDhI?=
 =?utf-8?B?c2I4T21KdVNnMnZnRjRsOHNQKy9wUjYrdWV1Ykp2YzJQdEV6d0VBa09OZm1Q?=
 =?utf-8?B?WHI4NS9oOWZGT0RWM1hpcUVJVFh2aTZJWUFuQktzL0RPa1d0TVVQc0dQVC9Q?=
 =?utf-8?B?Wmd1UmtNUVRwT25JMUJyWjQ2K3ZKbEc0MUxWenRJL1ZmSnlNaHlKNE5BVTVr?=
 =?utf-8?B?eTZtWEczVGRGNnFxR3ZPallEVStxK1YrV2h6eWgxSGEwRldqa1Q0QlorU2Vn?=
 =?utf-8?B?dTRKaDYyK0FPVjVLNU5BUVN6SXNOY3ZsaEIzUXU3VVNKMFhqTGFhVThha1By?=
 =?utf-8?B?MTZhd2dSRm5YRXMzT1BieHlQNkFnQW1LQ0JTamdFYTBzbUhpUkNMakZpOTgz?=
 =?utf-8?B?OW16ZFhzdk1mZ3BiLzVwK0Rqbm9CV0RUdzRIMXh1RXhHQTZ1WFJXeFBMZ3ND?=
 =?utf-8?B?WG5RSGhPVHRzSy9ZQVJ2SXo5TG00cU9ReHJqeDEyTk10ZFBBVlF0K1VMdjlI?=
 =?utf-8?B?b1pLVmpMaGIwTzVNUkZVbHVZS3BxOEdOWkhUKzdmNXFNL0xVRlJNejVMRFpN?=
 =?utf-8?B?aUpoNEd4bjl0MFdPcmcwVnRoN2I3amRBT2VYU1o0WVdUbGZnOWZ0bFhWNWhS?=
 =?utf-8?B?M3Y3UmphYjJpMW5FNGlVd05HNHpxUlZhQlBEVnFrbWdDYXVPSUo3MnBoR050?=
 =?utf-8?B?NVJSZnlBNXZJa2FjNnZZbndLb1QrdEUydzNxL1lEaTQ2aFpua291R3ZHRVJh?=
 =?utf-8?Q?XReUxXbhJubOn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alc4WkxaRi9WUDFnU3B2V0NPUElYRVhxbk1UcDFuZ3NtVldaeHRxa0dUbnBY?=
 =?utf-8?B?WUdWTUlvdHZybkxwc1JsY09Ra09KYndhVUpzckhORURQZVo0YlhKNUN3anNU?=
 =?utf-8?B?bTBRUk5vb1dvK2QrcWVFOE54VVBFZE9xL0FLMVUrbzVoUThCcU9RVGhBVHRq?=
 =?utf-8?B?bmJXeVZTaG9FTXFjV3NVT1Bmb3ZOSWRlNU0yTE9VV2d4akpzc0N4N1RIdjQy?=
 =?utf-8?B?SDdDNnFCbWV6WnByNWc1azNNaXlSYjFKWEZjWnNjNlhlcVVQWWxIcHBUVDJX?=
 =?utf-8?B?emZqQ2o2OGJQL2JxWnlCdjRkZUlMV2hyR3hpcUo1U3o0elV4VWNaajBxdzNO?=
 =?utf-8?B?RkZMcWswbGlxL3NDeXZqeVpKUXoyS3RqckV1eVRXVUdldkh0NEgyT1I1cGpF?=
 =?utf-8?B?UlU4TElSMjFMQjNQUjd6T0FWM1lNdkp1d2dkelUxdW8zS0NnaUl4UG4zM2RF?=
 =?utf-8?B?Q3ZYRTRJZGVNM0pBOTBqWi8vRUNrZ0Z6NTYvNEU5bVIybEJGQlFleHFsUWVr?=
 =?utf-8?B?ZXViNU9wQjl3UXUxVG0rdU5sUFp4dEs5TGZTeXRWazhhZ2t4d0ZWSWlEc3Bx?=
 =?utf-8?B?am1MWWNnSG90SjhHaDB5Z3YvS0doUlhCMkloYzVuTGxZVnROSXdRS0F2UnQy?=
 =?utf-8?B?cHpWWVp2SW9nUjdKbHRFN1ZQZ1d5NTlCYkdXUWdrbnUzcEE1MGFmTU5ueEF1?=
 =?utf-8?B?VVdPd0RSbjFaWnNKcWxYR2l0ZlI1dncya05TU2UrMGlzcjJLYXFLcU9vOGc3?=
 =?utf-8?B?MUJ0RjFCbTh3OGZQd1QyQVQ3Q05odUNUQUxwd2FEaUpMMkhKSG5OdmZYamFo?=
 =?utf-8?B?eVBPZmpPMHN4MEpvR1U2YmRsWG02aVVsczVveExLWEp6VTRTR1BjSFU4YkVZ?=
 =?utf-8?B?RWwvRmtJcWR6UGZ2NlpvNkUrTmxMekhBV0ZhbHlZNDJXUWV4TU44MlRyTXB6?=
 =?utf-8?B?eVAzTXJJN2EwZHJWa3QzSDRhL0NiV005SHc2anA1SnZOZjRPd2kxWEp4WFVX?=
 =?utf-8?B?MUtDRGljNDZxK3BvWWdhb0x4WUUyWmFQQXp1SDlvRmdqYTV2SFNPOUdHYWxD?=
 =?utf-8?B?Y25LODkyeXQ2S2Q5NlZ3NzNSTTlIRFZTQWhwNVM4Q3ptTWp1SkdnbzJSY25P?=
 =?utf-8?B?WEhrdGsxb0dYQllvbitrSFVzTGEvMTBLUG9uaDgxdktmNC9ONVFQbjRFZmFV?=
 =?utf-8?B?RjAxcHZXcHpYZVBXOFJaM3M1Mm5VdUZxN1pWYUtHOE1hZDhoVGdvQWRpYWlp?=
 =?utf-8?B?YXlqc0xIeGo1c0ZuSEU4YkEwa0Z1aDVYbmJGOEZ4a3pVbzd5RWlLdHp4RU14?=
 =?utf-8?B?c1lsYkM0YUlEUW1uSW9SVHkyUGNnWS81ejlyZzFhaXVGTTNSV1BRMjdsQmY2?=
 =?utf-8?B?K0lYSnMwSjRsaVhjdDEzbk1YQlNHM1NnV3ZZcU9JYW9TRXlZZTM1clFVL2ly?=
 =?utf-8?B?Nkh0emNXOXFPR2dVQllza1NCTHByVXJQQlZRb3lnanR3bkczQkFYWlBBVmYr?=
 =?utf-8?B?UmR4WUJUak1yWDNlRWZUYWVMcjJBM0lzTVJlNFRVV05KZHpvQ3pBSXFYak1U?=
 =?utf-8?B?cW5SNnFhZnN4MUpJd1NYODdmUWpCS3NKd0pOMDcwT2dVRG9ub0NkTEFFaVZv?=
 =?utf-8?B?cll1dVdNOWx2c1ViRFdXNEtobm02ZkR0QWp5NHJVTG1EOE9wN2JpQUZEZjFn?=
 =?utf-8?B?eE5tb1NuLytjMmZ0NjRMamlrQSsxeVRGV1l6aGk4TEtSZStLWUFrNTVleXlF?=
 =?utf-8?B?UmxFeWEzR0ZLaGJsWEF0TTJHZkFDbGlEK3JxZlJjUjdEY0poVXd4RWxrUE11?=
 =?utf-8?B?d1UzMmFwbFRPelZpRjJNaHpKUHVDSkZmT1hTZXZocGh0RExoUFgrdklvR1Fp?=
 =?utf-8?B?NWRMMlVPcFM5MG1YWkVQYWhuMTRxZEp1QnM2QUxtd1ZRRnJSaG1rMmJHMTZQ?=
 =?utf-8?B?OHg1eVorZVMvSkM2aWdPMTNpMi95L0t2dDJ4bWRpWnVidE1DZmtrcnhRL3B4?=
 =?utf-8?B?SlRqMEkwZEk0Ty9RdndQYU1WRU9QYUZVeHJTbTU0eTJuREFmdFp2elRXSGhh?=
 =?utf-8?B?RUFSVklnQjZCbUdrUjlpdXZkbTdmNitDZVlLcjUvU0hCZ3BnenMrSlgyYXVw?=
 =?utf-8?Q?XhHU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caddebac-b0c7-4d34-9ec9-08dd4d3b7907
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:06:38.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz0X9M2hysyFVQ2fFlbQzoRVapemXYkT/DYLPUDX8We4gbK9lFEcggwCmfF7vig3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

On Fri, Feb 14, 2025 at 09:24:31PM +0100, Miguel Ojeda wrote:
> On Fri, Feb 14, 2025 at 8:11 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Sure, but it was said, by many people, many times, that "Rust is
> > allowed to break".
> 
> A lot of people have said many things (especially in online fora), and
> many of those things are contradictory, but that does not really mean
> anything.

We don't have a community where there is a clear authority
structure. If lots of people are repeating a thing, that thing usually
becomes the consensus and common viewpoint regardless of who
originated it. The repetition reflects community agreement and buy in
of the idea.

At the end of the day, only the policy adopted by the people merging
patches really matters.

The assumption being if respected people speak with authority on a
policy they have also got buy in from the people responsible to
execute it.

I also think you should merge your policy document to the tree, not
keep it on a web page. That seems to be a big part of getting
community agreed policy adopted.

> Finally, ambiguous terms are used in many cases to refer to different
> parties: "Rust community", "Rust people", "Rust team", "Rust
> maintainers"... I have started to ask people to avoid doing that (at
> least in the LKML), please, and be concrete if possible.

Okay, that makes lots of seense. Please don't use "we" as well.. I
have no idea who is included in your "we", or what to even call it.

> > And Greg's version:
> >
> > https://lore.kernel.org/all/2025013030-gummy-cosmic-7927@gregkh/
> 
> I cannot speak for Greg, sorry.

Yet he does seems to be speaking with authority on this topic. His
message was quoted on LWN and likely was read by a large number of
maintainers.

Is he not part of your "we"?

> I can read his message in the following ways:

I think it was very clear, sorry, I don't read it your many ways at
all.

>   - I can read it as a general ability of subsystems to potentially
> agree to treat Rust code as something like staging, like block's plan.

As a side note, I don't see how anyone can enact this plan without the
support of Linus to do CONFIG_RUST=n builds and put out a non-working
rc1. IMHO it is yet unclear if this is real thing or an unproven idea
block has that will run into problems.

> It is very hard to keep hundreds of maintainers on the same page.

It is, but also I think you need to take this challenge to succeed.
 
> > I do not agree with "Didn't you promise Rust wouldn't be extra work
> > for maintainers?" in your document. Clearly there is a widespread
> > belief this kind of promise was made, even if it was never made by
> > you. "Rust is allowed to break" is understood to be the same as saying
> > it won't cause extra work.
> 
> Sorry, but I have to strongly push back against this paragraph.
> 
> Are you really saying that, because people out there may think
> something, we cannot claim anymore that we did not promise something?

Again "we" ?

I'm not concerned about "people out there". Greg said it. Others who I
would think are part of your "we" have posted it on LKML.

It is not clear at all. If you said Miguel never claimed it, then I
would not complain. You said it correctly above, be concrete. Ideally
acknowledge there were different policy ideas in wide circulation, but
they did not get adopted.

> Furthermore, I don't agree with your assessment in your last sentence
> at all. Even if it was decided to allow Rust to break globally and at
> all times, it does not mean Rust is not extra work. 

I appreciate this point is realistically true, but look at how Philipp
presented this 'no break' concept to Christoph as a no-work option for
him.

My main point here is that I'm glad things are getting straightened
out, some of the conflicting policy ideas shot down, and the demands
on maintainers are being articulated more clearly.

> That is good, but to be clear, from my point of view, the approach
> mentioned in the document I wrote is what we have always said.

There is another we :)

Jason

