Return-Path: <linux-pm+bounces-39003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5EC98DAD
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0E7E4E1882
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C721C17D;
	Mon,  1 Dec 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EdlzOF3Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F241DF759;
	Mon,  1 Dec 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617519; cv=fail; b=QxaYFmSfy/zwBnuVRvtYcZ86YUciHmgO253kFLZD9vzp2pAtlo6HK9K7uEN+FMFfQn/9M4yT/EvzCUx06tBudRGSbHeezJCuj6HvpAsy8jnwJahFdR1QPrlMOisYvEzIK1tN6sHLGDMeotZ+qklBPZPhm6oD9mNTdyJykTgeQL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617519; c=relaxed/simple;
	bh=c0hNgmuMuRmrASLglMtmNDCAM/xt2BRSbfyGv6dCxms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LoZlfrCdMQrhKK1/WHCm2rHRX5tRL8MQrGR7qWaKqsKj+jR0DKl4iIrsrA9E1MYmJtCkQjHtOGQLWnHsr/lEQPfQeLNm8D88gDWb5VTPFC0dqRvRLfo+lMx4c7VKWdjxJQkMb7L+pI6jnxeCMdwjZH/jgmeQR38PMAUMx4FgddQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EdlzOF3Z; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT9BxBT2nZ3KKgEOTt+nXZNESHgzxAmXz7KMPyB24/ZMAKnOR88jJZJcRJNdYBP0jscG6UyG+Lzp9LZ+NR0FI1JCMHuiUJAtKZAHLCdvK+3F+OaO1HPBrXzL8uOaEhnhyj2QqjGZXL9ohyYjc49KdOqoBy0Kkq/Ki/TB4Ua0Ni+OHNldvkc1tILKh90PmsUb1Hay+it9J/bfmUZEC5Fp1Iy/sF0qY3l/H4PDGCdi3f6HVhuyMh+hILkR0PDxgoDr8NlReSR1AJus9wJn0cro7cuzB6enr7+nqIp+vkJffM/xbB/F6P9Y6x/TBozfZ0Gk5g/XKCibOJBqvKn6iUtjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA/Y12uKOPXdZ3cTPpJdwi+zFsY54cGmwllOTfPd/HU=;
 b=tpHCbv7AoEw+aktVFvZpiyjSz4TZoGFbI36CGxmxvcffdTt9JVvX55j7zJxt4VAovCeSw/KXlMaztSCu13Xln8lssIn+5pcIBTxqoiMPQbHwFW1gGZYAivtvvd+pUo68jFWJ58h8CVqynoTHWJ7aJfjtGTL7WCf+dBxJarCg6QN18/f431N+DQrkGHU95HijLBcFowxV32elHu/M1rfqOY15wnmzUS3el+3HBiRxBV1NhG2rrlePKkbwQkksRDdoPOZRcL28EWPAk1Elq19oGA+eNe4V0VTdafVZVuPqE6BR88MKT058qqJ3vfEIHV1xWT2hwu7RkDCTXwkQ+9ltZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA/Y12uKOPXdZ3cTPpJdwi+zFsY54cGmwllOTfPd/HU=;
 b=EdlzOF3ZpxhroA1dcwOg44vyqa8QOsQj0eSiKU/rRCENT9BAYBKmlGgxkEyJNKuMq9CocfQOz+tQNFPcCQT7DXJsz/5rvAm6xB9rb6tjz3s+Fx7FH71bPwpsZdnsGsX2g/U0W9GFeGtoldxtRcnLE0CpmyyC23hfG3ciUbJez9XRrXhIpxjf/qUxv3qXCPELLn/EXLo8dAVYyo5Nn5I6uuTDHurMYMfOpxKDKAAuIv4gcYf6BCJ6ZyI4py0JZD9NAvzxbQWE1v6JLhZRU+PslwefV4pWWs0AKkELUimOjnOY/RvEM5PqF7BWe1QadSeEwjbmf8XeyaoaCKd9fqCIUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 19:31:54 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:31:54 +0000
Message-ID: <fccc4878-a205-45cf-b651-53c151e48d25@nvidia.com>
Date: Mon, 1 Dec 2025 11:31:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
 <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
 <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
 <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com>
 <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
 <ea455598-fc0e-4768-b540-5091f7ccd025@nvidia.com>
 <CANiq72kAnY2035vc2vvXDpUV-_vM=0W2_-mBts846jHo1ri3Yw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72kAnY2035vc2vvXDpUV-_vM=0W2_-mBts846jHo1ri3Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfaf6ff-83b4-4a4a-14e7-08de31104884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzdJd0p3VWRPWGR4UWxnb3l3TlBKazBqdGN0TC9jRE9xNVNCcEhFWXd5WlN1?=
 =?utf-8?B?T2J1eFVmYmdDTHFaUnFDa05QQTUrSHFGbHpiRkM0eGg0eVdDUFZBMWxQWWE3?=
 =?utf-8?B?UkxMQ0JRbHdnQnRRdEtUc29SVWMreEszNjFaSzBONUpHY1R6M1JoRlowaGZ4?=
 =?utf-8?B?WEx4QjJ0d2NnaHorSEs4bmcrMmJFRkVTN1F2azhTSjA0RVV2bUxMQ202Y0t0?=
 =?utf-8?B?NVgyQVNPeWt4ZXZheU0xeUN3eFlhRS9BS1RDNDVBTTRhVmlmVkFhVEJUcnVQ?=
 =?utf-8?B?S09yZkNBaTA3c2F2MG9lSTA0QnJIdG1TelFKZDVreDRuUHpBTUNtRllrV2dr?=
 =?utf-8?B?cDdQWUU5ZndCUktDNUVZTkpzTmZBTFlBQTFaYmswY1p0cFQycVhVNGJ6QkdI?=
 =?utf-8?B?WlV4OHlJYnp6QjRWT1h6S0ZkMm5IakhrYnEyMWJ5M0RhR3ZBOVFIRW1xQTE5?=
 =?utf-8?B?VEU0aE5wS3ZseWx4WTBNRW96S1N2M1lEMlQ0RGFVLythakNUK25uVkZxSkMy?=
 =?utf-8?B?VUptZ2YreEpVUTVqLzZKME96RlY0T0QvOEhuWEpnaitMaGZnK3lIUUplSUox?=
 =?utf-8?B?cGFuc1l6Zy81c1ArUW5FYjdEVnUzcjQ5cG10YnNwaG9HQ1U2aXhKdVl1Z3Rp?=
 =?utf-8?B?UjR0YXBCTDlDZzJpc21lS1hreTdyYmZuemMrK0J4Z0tnaXhVQ25CRDlORStJ?=
 =?utf-8?B?NjVjYnJ0Z1Evd3ExNUZZQ1NDWklyaHFOWWY1ZnNidVlsUjV2TWNqNVg5M2Yz?=
 =?utf-8?B?RmlLbHRlR2pCSkZ1UHR2QmkyUWNPZEVmdzlyQitBOXFBaVpLNjJVUzROanA0?=
 =?utf-8?B?dURVUTJ5Y0o2ZzRHY1ZPT3M3ZWhUYWJVNVdvRURPZGNvN3JYY0pPL0U1NFA4?=
 =?utf-8?B?dXhCTEZ4dTJRS01CcVV1ckVxT2xoKzZvYUdNbTJkY2piOERRQmNNalNQNC9C?=
 =?utf-8?B?eEpWcHlSclM2YVJsU3I2VnRoeVVMY0JTU1ZHMHI2RXJiZkQyb0VVMVVYQURR?=
 =?utf-8?B?TE1kMWZBZ3J2M202UXlLcC9XTnhoR2hKSWxtcXpiUXNJMFFHQS9xb1Zkb1kx?=
 =?utf-8?B?NDd1RkJ1MVdVOWNoZWZiY004ek00OG9NellHWGYxWnpYT1pqaCsvNTJKcmNi?=
 =?utf-8?B?ZFIzbGc4cEFMOTNYbStlRzlZZHVvUndYRnpUNDU1RG5vYnFOTW5xR1duYU1I?=
 =?utf-8?B?eFhCaS9yWTg1bFpIbGwwZTFSbW1hSmJQSnNlQlFIRXB6V2kwL3RpdlBBbEoz?=
 =?utf-8?B?Qi8wSXlHNlMrSGJPR1l0UDhiNm51dmNUSmNic0dKazRjVWd0R0FjSWJkU2gy?=
 =?utf-8?B?N3hrelNVWkhZdlRKeEI3TnFCM3FIVVMyNVpaSUk4bnRZS2t0Z0hnelY0ZzNN?=
 =?utf-8?B?dmVKQ0ZESHFGQ3Y3Z2luWWRONVhiRUxGRi9ZS0MyWGFqSm54QXFIRXA4bktH?=
 =?utf-8?B?WExSWm92VjJLdVhqajVrUDhrVkVGNlVwaE05QUZTbmNCSE1HMU82aHlsakwz?=
 =?utf-8?B?ZzdzcHhBSTM1bGNXd25saWJQRDRudkJCUi92UkoxektUSDVSUUpvNThHSkh0?=
 =?utf-8?B?aEZ2VDIvQlNUbFJzQ0NWVzRCMC9YK0ZZY2ZqMk5PakhmYWoxcndjUzQ1Q1NR?=
 =?utf-8?B?ME1ST3lsRXJYOUh3T2IzQVFiMTVtNGZwWXlvNm9DUlkzeUV0d29acktydExL?=
 =?utf-8?B?VTFLa2VkR2Ftc3J3eldBalNOczI0cURlb0QwWGMrV0VXVnpXQTM0czM0SjVs?=
 =?utf-8?B?WTlxNURBQU81WTYzSjNoMGF4Ym5pREc4eGZRa2JvNTZVSStGbGJsbk84Z1Ir?=
 =?utf-8?B?OWdjWHN4bEhkRkljWTR2QVVCcUxXdSs4bXhoTFVWZ0lBNU52UzhnRVdDamlu?=
 =?utf-8?B?eTlUSkdLMUMySmk4aUVHS3hlY2NMOXIzRzdWSmIvcm9RMmE0ZmtoeEZkQXVX?=
 =?utf-8?Q?fzqNQuWeODVOGvlWmJ33jpUKgO4f91q7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3JueEVqcThiRVhZeGlraUJ2VFlPZVZVUmFmZ2xTdEcwa3NOWk1sZUwvZ016?=
 =?utf-8?B?bkZjV3ZiQ3JLTnRGNkdhZDBpRGxIZU16VmZ0cURzQTZ2R2tTN2psbUtsemR1?=
 =?utf-8?B?emNVamhNeHFOZElOeEl2elZTcnhmR0RnS2tKZE55YkJnS2twNGtqQW1HNVJU?=
 =?utf-8?B?WkpOWWM2WjhVSm05UFFNdUZyQ3NjZExxNi9XOHBjQUxLMEZuWi9Hd1NYUHZG?=
 =?utf-8?B?UXdGL21QdUtwOTNqNS9rUW5pK3VkQThWSlNEYzEya2hsd3hTZzRuK2FmeVI2?=
 =?utf-8?B?WlJYUnhteUxqVTA2RHpPSDlmeDV2Q1E5d1NlYmlNK0JYYXZjeWxEM3BXWnhz?=
 =?utf-8?B?STVtWUwzZVhlSjNmL1hJSHB3eTYvSUcxUVNlZVFaaStPZ3k5NnpkYWpXblo2?=
 =?utf-8?B?eXFUbTVJZHQzbnY1ZjRYSVptREN3QlFTL0xIMklTU2xQeEVUUi90eTU4VXFT?=
 =?utf-8?B?S0VOaU1Cc0ZSb0Q1TzcveGdzY1FaOVRFZHJEOUl2cENIVE9abUtzb3ZhWDZs?=
 =?utf-8?B?eHM0S0Y4dko3S3BZb3VqcTY2THU5cDV6S3diME5yc0xLb3FXMlZ0QTh3bXZR?=
 =?utf-8?B?Z1VGejhiNVdERDhTYUxVVkVJeFVDMCs0M0FCU0FGV1g2RWg3aXkzanlMWnJS?=
 =?utf-8?B?TkY2L2thdFMwdWZhNGFiM2JJVGRjQkZzYWNWSkVHdzdJRHhUNFZtT1NEMzlx?=
 =?utf-8?B?UjBFc3JGS2VWSDd5U0pvcElWbUhNWEhYUlFmVTJ6THlJUFFoamkzeUVvZUU3?=
 =?utf-8?B?aWk1ZzczYmpvTCtBVG5pTU51VXRxdTFnV0psOTdaVTAyVDRydVVxZEpLR0Y1?=
 =?utf-8?B?SEhWN2lxRC9vSUtGKytFNzJhNjRRRm1pb3FDVDlIZzR2dnNtZ05NV3FDNnNG?=
 =?utf-8?B?bzhJd0dEdE5MTGpyNUlDM1V0T28xdHM4Z3NLZFRrUXFGekEwZitKeWthR2dk?=
 =?utf-8?B?QzhnZlRWVHBmTG90TW80TjFveVlpQXdXdHdPcUQrM0U2WlhoajN2YXF0NkpF?=
 =?utf-8?B?OVRwZHJ6QTRYNEdCR3ZHYW4ySjJVSXdBU1d2MTZuVGdmOCtsZ1hnNFBKc0tM?=
 =?utf-8?B?bHViUzZzcUFCRmh6L2VsUEF2M3JsQW1iUVBwTDZGaTFjdFFGYXZxWTJ5QVd1?=
 =?utf-8?B?Mk5LQ0hXSXBBSGYvNXE3bkRIRWErTVVBRE4wR21nckFGSHpzeGIwU1lDdEM4?=
 =?utf-8?B?S2NkN2lRY0IyUXArSVpaellzT0NPc0F1a2lNdlhiVlpKYXk4Ukd2ZUR1VU9j?=
 =?utf-8?B?bUJFdEhZU2JCKzh1OXRMcHR4VnBuc2NtUHJDSGlQbi85cnNzemdqYW53T2wv?=
 =?utf-8?B?U2UwSWFuTDAxWXlhUWpkai9rWTlxUEU0M3FiWk1JQkhadUpmcVQrRFp3dHB2?=
 =?utf-8?B?a29KWlcvVDh2Rnl1NjNDU1dkQU5NZERMRkxyTzVObUFsSTh3QmRaZENlSG1I?=
 =?utf-8?B?dWRhamZUYnRZdVVDV0tKWFdyQzQ3bmVzQUJmU0tHSFJzaGxYZ2ZqNk96TTVw?=
 =?utf-8?B?dFN0YVdBZlc2WnB3YXZwRVZxeDY3eDAwVEZhT1hwQUZ6cFN5TWxHakdXRHNU?=
 =?utf-8?B?NXROblRaOXdCVkw1MVgxWWhWcHpIaDhaSlFETGpLYXpmZE85cGQ1L0d3bE05?=
 =?utf-8?B?RG9ySTFMTWJPdTAybmdTRjRMV3d6a05DZWIzWDFhc2RoS1BZMG5jY1FVZk1o?=
 =?utf-8?B?ZnRETEk2ZS9SWkFSZW5ScTh4OTJKSDh4eEFrbDYvblhqZTMwVkI4ZEdYSFJQ?=
 =?utf-8?B?bUdnemdGQXN2TlR5OTJyZzF1MTNpZHBDRGI3WGhzZVZIL2toWDgyaEtFUExu?=
 =?utf-8?B?Tk45K3RHaXBQbTgvcmF5dm5kODF2ZG0wUEdXWXh6NDBsL1orZm5KVnRmMGxW?=
 =?utf-8?B?NXgzVTBjRTRoSXJmR3VmVjZLZ2tFNzhCZ1FqbXdBazNlb0djblhxVytmdlpU?=
 =?utf-8?B?SHhGSVdGOUFKZjdjVjFjZWZaNXVxM0xncTBMVCtadFRKbC9RWktPd3RMTXVk?=
 =?utf-8?B?ZFZkRzdlc2x6SlpDRmVObXJEbFdHWlRFTFhKUy8yZmREMFZlUUNuL1NnZXBU?=
 =?utf-8?B?N2l0c1pZLzd3c2NERG0wV2VUTThoT0V1ZFJUakVRampxQmhuQnovOTdLVDlR?=
 =?utf-8?Q?6ANbd0PmM2POVbi3y4ovu+ff3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfaf6ff-83b4-4a4a-14e7-08de31104884
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:31:54.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4oQJdHeZ0XhwyQ/5Bhl2L/Pcpuo2ISio9hSaTghUmdGMRpF15sTt8R8nL8qh9vxF8uuextqWPooGiz1rViLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

On 12/1/25 8:43 AM, Miguel Ojeda wrote:
> On Mon, Dec 1, 2025 at 5:36 AM John Hubbard <jhubbard@nvidia.com> wrote:
...
>> Is there proc macro magic we can come up with? Or rustc or clippy
>> changes? So that this is becomes a better foundation upon which to
>> build?
> 
> Converting more code to macros has their own set of tradeoffs, but it
> depends on what you mean. Do you have something in mind?

Mainly just: is there a way to automatically "derive" (generate) an
always-inline directive for any function that attempts to call
build_assert!() on any of its arguments? And in fact, *force* the
always-inline, if it is not forced hard enough today.

Something along those lines.

> 
> And yes, I have had it in our usual lists for a long time and we
> mentioned it to upstream Rust and so on. We are well aware that
> `build_assert!` isn't ideal, and in many cases it is best to avoid it
> when there is a better approach.
> 
> Now, if a company has the means to improve the situation, e.g. by
> sponsoring someone upstream to work on features like this, then by all
> means, please go ahead! That would be very welcome, and we have some
> contacts that could be interested in working on things like that, so
> please feel free to ping.
> 

I will bring this up (along with the KSYM_NAME_LEN hashed symbol project)
to our internal Rust groups. Both of these seem like nice, self-contained
projects that someone could really get into.

thanks,
-- 
John Hubbard


