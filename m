Return-Path: <linux-pm+bounces-43625-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAlTKgaXqGkLvwAAu9opvQ
	(envelope-from <linux-pm+bounces-43625-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:33:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507962079EA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB61E30217D3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D737E31A;
	Wed,  4 Mar 2026 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpQeSKXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC736361DAB;
	Wed,  4 Mar 2026 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656387; cv=fail; b=IQ13GNv/bnfEgk/sSLp/yJJZsNVwtilSpVu9I6clmlzQ7K/Zky8fDsq1GbfAtpH0mPt7z//sRfSHxlMygrGhdfsc0LZuV/KWy/yQN2n45uQ6J4phBDDchHVFTZVhx8/cQG9UZriyQfMNMsr9PdM+wgNt/Jv0YcL4vk8n/rEH7ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656387; c=relaxed/simple;
	bh=oNnyva4l0AEvhX4HvP2E2afReVmiE04/y9x3emP180w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=use7z8KEKocYmQu5QB0vKSplcA2V42Vc06dWpgja+icN7jYBD3PyB62hPyRTDq55DnArrcm0Gb7n8lBivysOO/4FRVsEdozNkO5GPR/0LKDYQUd7zgaqoWSfbzcltHENsXm6o+Q9U+ql0U7tsUCEas61YlO5f/wDYSKImansynE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpQeSKXw; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCd98VZ9sftUZZauemrmlgKqylPIRG7GP6C7sZ4qMFEfjXIyKwLh1B0zh9E7mVQS2cAiorY9lYjfN8OiFxsp3aIkFZ3WFKY3BC5/kFyCJ4aga+L3Mgd114k1BwKWw2nctAGKrzcrHud/8ZBEzZme8ZEp9BNtyb73UHzIeL7OvwGnmoIVOa7ff6ELX7ZasX1tLIHqXlfM+byXM/D5xteNA0TkAQtxmBkAL8HHpt+yurVwJXL/BgtxJF11k1oaVF2FCAZRo5EgV/oA7kPMnCrOHWvMS/jXSUuo9Fwne1+SvXVqNd6yfBe6sigkY8kRvfBFeoFdqA8KGvyjItu1/2rTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zRKGL2PGNoUbuy3nfByOIci2PpxmjlOis8nl8sQkO4=;
 b=FW2D5GTjgSzHoiWMHnfVWJSFsmCmI/OUpmObG2Xqw2pQ4K3jA0ghaCx59zAIbdxvt9/1rv6KfwFEAbsqfXT/tWzWtEIMpbPjDjc5B8xOUuW7Nb/vpvBapRbzaideLj36SP8hfknXAoSxfp/Bivl2bQVL3Su4xZqCl5GIetMIXgU34dEB5XdgRiUOdiP1FGhl6bmJAaNgJhaMtE+NxWkHK5w4L3Rimw3kIzsYZCpDmgrbppz12VBUSOjSPrYxUy4oH73TbTJIzt5XGRQDed/iwWcQ6ZwxKMPSRrPku9Zzkd5noD/dcxpfWdhEIsDC57KcwWYr5lvLaz90qBPeHT32Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zRKGL2PGNoUbuy3nfByOIci2PpxmjlOis8nl8sQkO4=;
 b=GpQeSKXwjwtt4Vug6exL/TYf68wF4cDh4CQ5Emu9n7M0Umu5zk6mGzIj65J09t/mzzOXp4tEMG0Lqw2OzZcIItEpQeDGSZuB381x0PsoOElk+jVGrejHrFH+ncXyUBtI7XuiLXJRRNkE/i+MxAE1fm5lHpGvsozs7v/fVEGurKZNKL5K817CAQ/M0SP2y316dtpaL1+++/j5TSYSBjKB8ZbDK9Js3guqqTFdmthAJ4iilRkmHGlzo4ftSU7vblrNVZ9DsrPpW6ivy/+i04d+ivaMTl9XehBONNyIeb9NnY2E55m+i15I3lnW+xLHZsw9+a9lzqRfpPuJCQJWpEKNTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Wed, 4 Mar 2026 20:32:59 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:32:59 +0000
Message-ID: <eaa82810-51bf-49e6-9a0a-db1e4c8768cd@nvidia.com>
Date: Wed, 4 Mar 2026 12:32:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: cpufreq: fix clippy::double_parens warning in
 Policy doctest
To: Gary Guo <gary@garyguo.net>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260304195330.185829-1-jhubbard@nvidia.com>
 <DGU9O3HEY7CN.3OBR26YV3AHGT@garyguo.net>
 <ea3d6134-22ce-4715-be75-e6d41568c7eb@nvidia.com>
 <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::19) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cd8d16-5d54-4416-d06e-08de7a2d39c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	Bn+PhzWNGAtn9RuhYojHGpNh1PBbqgtXF1EvhvNFykL2u9obUzZRAfrR3B9yDNqNMSd+1lGY+qsg0XAikKP97bJJykVbhCycwgp1/clL9oQGrXWvuxLJszAWRIVtxvy4Co9ImRbOM2QcBA3MW29UzsMjMprXDiJcASIxAHw4yqVIzIkifwuLRBtYQD7IRGy/aU6Jx09kcfXR0ZWUb0MRy2ShXYKNRHXzHFyCwBIqKn0jpVP+D9T1ggpsFGR+wCi0xEsLcYLEi8LLY19bhFOJfR0ttXWwFsav8RLZOELk1L2WApoiStmEH4BpS0dH/QeDkDLsOpFTXCavwipdASf/wrUTSL7Erqnhww5IRxyO7j2UNAygGmvlqJf/WiK4tUOaki8/zFA5XkAnzeqlsztQFMsDRHvyDvYPEd5cDwdCJzTZfpx0eyuyIw5h66s1kThnuUfzba7Czr7a2p8YtcTMOo6CCkuGsy0jeuyEX2OzExAQT6Gv1YAgGAKWwXfYQHJPZrYB8dAmnRJPhqWCXXPo/RQTwOPGOMjtB94st8OygnMG/1iWd+nfSMhc7C/4kGHG7KxINjVIMW0okqYr0cdRSnpjD2tT+zEvk+tD7PViaeiGLubD4DXsJ+tORmV0PauYtxFLUyb6Od0mPIVGQD6JtqfCi1M5eGsKaQPoA4si68fY1W1v2DXHRzXdLUgoQ0qJZSmkusndRy/TV/4zeh74AEsDV3HOAR180UfA0n0Jg8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RxNUEvdXBZa0d0dGFsUGhScTVEWUw4VnJ6UTVLWFI3MEFPUnlZVzY0NXda?=
 =?utf-8?B?cmhCYk84blg4SEFIemJVdllFSGtDbGhQVERZSHoxV3FmWHFmUXJoT1NZOVph?=
 =?utf-8?B?aXE0dktyRkdLU2w3NXVITnZaNWhUTzYvWnFSdFRwTXY1Vks1MmhKVER3ZWQ2?=
 =?utf-8?B?TGVxUFdxRVIzVklDR2NUWlRHMWdXTFJLelRSVWFSaGVIZlFmNXQ2QzJPbTBp?=
 =?utf-8?B?WlV2c1RyYkJCYzNVRzZaL1lic1VlYXQ1WU5PcUVabmd1aUE5TUxjZHRHQWJj?=
 =?utf-8?B?SzZJclBBSktUS2JHOVB6NlNWazY1OWdFWlRqQWpDSFNYTHl3cVg5RjM4VU91?=
 =?utf-8?B?ZWp4VDY1VDRGclRZbi80bmRaT2ZxVlNrRWFzUmNyeCtodmdhdU5BMlBtRnRi?=
 =?utf-8?B?SGNpcmVqTTRjbzdnMVBac2F0K2loR09tRUlFNlgvYStxNE9uTHBhNU9NT09l?=
 =?utf-8?B?NFRIUThVUmZlbGZsanlOQkdpUWlxaWorVVBBSGxGbGVSZmhHZ1g5YmdmN21O?=
 =?utf-8?B?UG96OExIMzV0R1FzTjhWRUlPNVVDdmpOQXdKQXBUc3pJdEVVbGV3dFNwdFg0?=
 =?utf-8?B?TmdSbk81OUpMaEQ4Y0xzNjhyZ2hlTHlnbERzaFRoc0paN0ExSS9YNml6YXQv?=
 =?utf-8?B?LzFUT1I2VE5KdjVaNTRCUG55cnV0UmJVd1lWamw3VGtuWkVtUUd5Qk11L0xC?=
 =?utf-8?B?M0grMDRCS2hXWC9rU3J0UTNkU0hPVFN0cDZHN1N3TkEyVjhrRE1oNWNlRnJr?=
 =?utf-8?B?WGRZdGp1Wlo3Q21JK29SOEZzK1dDRS8yOFZYWUVXV1M3b1cwcU1VTE1JZVE3?=
 =?utf-8?B?c3IzVjVCVlhubGIwTllvWEFtWkxRVXU0M3gvc1hTcnVSM1E0bGNhSEFBcnpI?=
 =?utf-8?B?eEdHc0dBZklzNkUvMW11RlNHWndnNjNoeFJrV2JUVUt0NGNmRi9hRXc3Z3Jn?=
 =?utf-8?B?ZlpQR1VCMDdZblkwcmZwTmlrRXlYZTlva2Zxd1F0MVgxZmhuZXBOVlQ3Z244?=
 =?utf-8?B?cVJYamx3TXFGNlpsZExuQm40WWZETG1xMEV0ZklwazZWMnZjMTZuY09lQTBy?=
 =?utf-8?B?U2VBUmovMzY5YzgyVlBnT2daZWYxTzhtV08vWFdhOWhSYm9Oc1NPUHg4ZDMy?=
 =?utf-8?B?bE9VUERkeTZvVjcwR1NGbm9PTUtNVjhrVzhibC9yU0Z4QmsyV05DRGUxZjhC?=
 =?utf-8?B?Q2J3YWFnWHZQUks0RWVaMXVhL21yQ2JCZTV1R2NpVW83ck1WU2p5MDY4Q3Bm?=
 =?utf-8?B?U056ay9HMHdIM3hyaGtZSmZldGFPa2hldmhhbW1QbmZYUUZHSjByT09INlJs?=
 =?utf-8?B?eS9uTmhjT21HYnZrOWFCcXFsbzFjcGdHbXNwUXRBZU13REtoQzJpL0M0Vkd3?=
 =?utf-8?B?SUE3bFBiK2d6ZGliR2Eyc3dtSWo4SkpaS1J1dkJlWEM2OHFUSTNWdldMNlcv?=
 =?utf-8?B?YUpaYTJLbGxMZndSaVppT3lJUGR4RUl2UUxnT0xCTG94M2d0SU42WWx5V3ho?=
 =?utf-8?B?OVcxcTg3c3hsK1NOLzNabWdjTlNES3RsdW5TNHZObU15WDNJZkZWTFYwUE1Q?=
 =?utf-8?B?cWNHdjV1bEh5eFJwcUdlN3QzcG5BTTE4NE9KQ0lXRGZtc2hMOThmQ1BVQXhI?=
 =?utf-8?B?Q1dXaEpoZkVHcUdLY1F0UlBOYlBza2p1THZCaUY1ckdNTUJPdjNEUG05bFA0?=
 =?utf-8?B?UUU0Smo3SGNNL0cwR3dYbnFqaUhKeHlnTEUxQlNPdHluTnpRQldXZ2Jzdjg4?=
 =?utf-8?B?NytYN1lGUC95MS9WK0c0WDVONy9HTmViZTFlaXBBOENlZ1dqeHFDWVJOVUJN?=
 =?utf-8?B?Q0lTaXAwWmJESEtRZzBLSGp1bzdkVzdpR1Q5Q2JVL2lWamt1SlAxYlZwNXVT?=
 =?utf-8?B?OHlGWHQrbXFCalhPRGh6alF6ZDlDRFhUaGY1YWxabmREOWpxQjI1N1FQQmRv?=
 =?utf-8?B?UW4wSGlwWXVTVTg1cnhhOEFWVWp5dTZHZHBEK1k0SzJXTjJ5MEV4Z1MxclpV?=
 =?utf-8?B?YXpOSFFBdUc0bmxENXB1UG9DL0ZFbyt4aG0rSHlUWlJVU3RaR1VSek4xVElj?=
 =?utf-8?B?dGpuMmtoU1hSRXJwanhvclBXU2NEWjZ6QjRCaitIS0pIaW9CS2dPWHdKQ0Fj?=
 =?utf-8?B?alVpWmlKK2NxUGdjRGFnWEFVekEveWZTNXJtVm96aE1vT3owU1hlQmExOXhn?=
 =?utf-8?B?OHdKRVRwVDh6bnlldGZsSFFTUGo4azVHZG15WnE5SU93NktsOWFsSVJHV0Q5?=
 =?utf-8?B?VVlHWUtPaTZ3c2RnU0JaTEpnbEovNVB3VW1ZNzlkY0I4ekVLSG51VnRVNnR5?=
 =?utf-8?B?UmhLdytURTVGbTN6OTUrckdQQmJoOHYzcGF2NFpweStLTDlyNUVJdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cd8d16-5d54-4416-d06e-08de7a2d39c6
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:32:59.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae1rTTj/BJKhuaMzFBwwHKpq31jzEoVDBtDOvZMarlSGGJnoJnbib7SdfvPdQQ9LcvZQxczC44SF2W/78/QzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
X-Rspamd-Queue-Id: 507962079EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43625-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhubbard@nvidia.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 12:28 PM, Gary Guo wrote:
> On Wed Mar 4, 2026 at 8:07 PM GMT, John Hubbard wrote:
>> On 3/4/26 12:06 PM, Gary Guo wrote:
>>> On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
>>>> Clippy reports:
>>>>     warning: consider removing unnecessary double parentheses
>>>>       --> rust/kernel/cpufreq.rs:410:60
>>>>        |
>>>>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
>>>>        |                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>> This looks like a false positive, probably due to how our fmt macro works?
>>
>> Probably, but in any case we need to remain clippy clean, so this
>> work-around seems about right, yes?
>>
>>
>> thanks,
> 
> Can you try this?
> 
> Best,
> Gary
> 
> -- >8 --
> 
> diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
> index ce6c7249305a..51988a69af21 100644
> --- a/rust/macros/fmt.rs
> +++ b/rust/macros/fmt.rs
> @@ -2,7 +2,7 @@
>  
>  use std::collections::BTreeSet;
>  
> -use proc_macro2::{Ident, TokenStream, TokenTree};
> +use proc_macro2::{Group, Ident, TokenStream, TokenTree};
>  use quote::quote_spanned;
>  
>  /// Please see [`crate::fmt`] for documentation.
> @@ -69,7 +69,8 @@ pub(crate) fn fmt(input: TokenStream) -> TokenStream {
>                      }
>                      (None, acc)
>                  })();
> -                args.extend(quote_spanned!(first_span => #lhs #adapter(&(#rhs))));
> +                let rhs = Group::new(proc_macro2::Delimiter::None, rhs);
> +                args.extend(quote_spanned!(first_span => #lhs #adapter(&#rhs)));
>              }
>          };

That works nicely.

thanks,
-- 
John Hubbard


