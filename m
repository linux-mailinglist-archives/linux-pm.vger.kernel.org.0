Return-Path: <linux-pm+bounces-43621-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BG9E76QqGnZvgAAu9opvQ
	(envelope-from <linux-pm+bounces-43621-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:06:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBC207675
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF17330117B7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73D381AF6;
	Wed,  4 Mar 2026 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="i3NUVaY3"
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022140.outbound.protection.outlook.com [52.101.96.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA30378D82;
	Wed,  4 Mar 2026 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654770; cv=fail; b=d3lHzXDYljKEQDbyLbI7bCg1HdV87YFtI15wHPrFiOmaIvR4aIVNaJYw9ZCAdvWEnQYRbT8ynFMhc4vQq5myG0IkB2NGaxK7upszCZzPJe64eBaVlHG4qMXII4WkTtDBbfiX8+DjR/yZINVKi0PgR1UqcLp+8LmFBh+aPgxfTaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654770; c=relaxed/simple;
	bh=FZ/D8dfZFq2la9GRGDv/O+SXGutxJzdjWN5vS2c7/pw=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=g3SgXu6F+4qP5hO8E0VofyTycJALyPWSWICSh/voop93v+E+/T4/KDXvd8g3HggeugvqCxdDMV7w4KU71uAzNfSyC2IzzR0+CEY1JYBiQkUEjP50F4ieYdTrnkhT5JbP+aekwOqOhVI1zzM4L+EzasgQMsErqAHXemHOJ84MZd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i3NUVaY3; arc=fail smtp.client-ip=52.101.96.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqeKr3W5RuxeSWoVD3pbbPluDtBqNvlFK+e3yq5DxRhDaOvWRLUZut8oOK27vsmaVJjuDu47vg48i4hpayBaFD3NpMMd6JN7IWu/9RNNg2oswMw4mcziExlPI5M8O+NkYXYY1YpGc79VcFFk6rvcwyxs8fXfofK9rUYwuClxaYPaWN2o90Leqey4KQSgFvoZXKZWbvSGFNxz00SPfoCV2Nm5TPWJDMZCct1z4bbTcLkbEffviNzVvT52BpGnht/pQMsSvK5FCJlLPswdCuPEtP5Y3tR9nDMAfLs1tL3nhR/SlmKWTaM/d+mQRxYr4H37s8repSkLFakLK3I29BSpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+voua+D/9b+EQFZKm4k3KmXo7Q3bI+OOwsSqXKPmME=;
 b=luxDizpdNYO3xqgPLfc45JyYfcDNmyLccQy92z01IzI0FJfYu1QC/7Qjap22EaHPbiqEkoAhdmEYIOuUh38p+Uv2Xs8Fp6VAV0dcfgaU1TFrCZ8V3B25vaDGqfKx+aBMzZdsH9QZBlrKzcXErWDF80eKIZ/T0Ge7zmIY8h2l0cn9jHoqXyz5xoJOE5nvgxvbnZS8ivrWzaj5jM+iDUZ4qfLiLXXPmEgEn5JFoyJu3tAO6yC4lGpj5j5xEbr9fJDJtaW7xnzT9WWh9OdXtYCXOcfDFEv6HRykAv4oi8H96B8dz+g7OgXneKFDbszcNyQ/sMK+BpUxd+/zjB0moXrULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+voua+D/9b+EQFZKm4k3KmXo7Q3bI+OOwsSqXKPmME=;
 b=i3NUVaY3rg/HItWU7TU/qQWx/bUtxUBAotp5IgVJ3HTSsYKLT3pz60/nt+1TUSK4M06OHwhD0/6mvaeow41kaNoj0R3GqefnTFQBWTqArvkgCfUmsThNYTIDDG+3+hl7qwHinff4MjD3qqDItIxctvfp1Wj4nqmZUS5fJheAZOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1884.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 20:06:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:06:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 20:06:02 +0000
Message-Id: <DGU9O3HEY7CN.3OBR26YV3AHGT@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <linux-pm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: cpufreq: fix clippy::double_parens warning in
 Policy doctest
X-Mailer: aerc 0.21.0
References: <20260304195330.185829-1-jhubbard@nvidia.com>
In-Reply-To: <20260304195330.185829-1-jhubbard@nvidia.com>
X-ClientProxiedBy: LO4P123CA0388.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5452a074-f1f4-4dcb-1981-08de7a2975f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	1KzP4a1vTRaLuTCjeWGHsV4OybuK8sPFO19RH1gA1imOjd+bSCnuvT8BrOHPl9o7qnKLE7BHx4CH7x5hajRzl7Vf1BCOqZyCoUeyW+w2Q45V2FyrvuoAkLTqdmAQ9u4t7IZRkMDvsR6Un3mBlzA5weP/Yrrs5v0qPi9Y3SSH92D4qqpe6UMq7NCslZhB3avlhXAv4UKw4jiHsQ+Mbg4rqo/nJiBve0VX8FccoSrZ6NLD3zaTC75f9I5ElE5mI9hYiSXpJK+FB4N6Y6/fy+9g/zZI6G1OPQfz0kRttRE6oW8NPSKqS7ZnShJaZYDSfRxg7+71TN2Zt53Ymkw9J5Fh0XGkpXktHg7CcNIkYO09jIQLKGsfTABMd9bBYRnKe97qfBvBkgyOp6qhT0GocR5iGgXpSSLcpAY0aN2QoWTQo1tDzgMFxNVChvazhXeeWvzKR4LyatCYLofFV7pZfJYIglH+T77VFjp+0LVEmixATrshgNzImvbm1ENXA+G0RFm00JIABO5PgAuh3RHqj9hneXhpyxPs/OP8ocjzvg9aUq48QfXgJNibhnE5bxItDKrU2PWkpB01miDeTmAfA24oF5IDRPg9zfBC2TUhjy2/2SVf1XAsrDfjBNoKxiMf1+lr8GtQyNmpAFSut/+IKSQXE0dqx2zmur3Z/UUalKALZYiNTZH33P6ln5CZBQJAjpiUmUC0HR41p67JNySnamrtK4V3MLkE+zu6IW7wrWCZ0BE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHlPd2IxM2VSWG82WWFmQ1FUc3NHQXRVR3BLOTVVY25KYmo1eUY4K3pzRjI5?=
 =?utf-8?B?RzcvNWVRdHM5VStHdFlpV2gydXNua0xhMnVWNmR4czR6YU1Tb0J3NFFQelYw?=
 =?utf-8?B?OEk1aEVSc2xyS0J0ak1CbTdQMzZ3Z3NJKzVaWDR0Um43VExqc2RCdW9ra0NS?=
 =?utf-8?B?ODd1ejB4SVRGUC93T2lYYnpIUFpUL3Vta0xkditYcytrbWVJYy9XUnhISnl5?=
 =?utf-8?B?VVJkeW5WUXVaZldZUGdrYjZCdXNNeWRiZnQ1cFNEZjBHUHdHR0ZRd0pKdTBD?=
 =?utf-8?B?WFdiVllVYjgrU1M2bmhIc3RyK3BMYXo5ZnlaODNDYnBYa2krbWV2aHY4aXc1?=
 =?utf-8?B?L3Zac3IwLzRka2IreFd0U0JuaSs1bzBKZmhFVGhKNjlNbFZCbXpWdEpHbHQz?=
 =?utf-8?B?K3Jib2NJMXFVRDZLTitRSm12WkhFRkhWd0pPNDVJc3pRTVBrUDFNVHJIRmZo?=
 =?utf-8?B?c1VVY3BPbWcvVXdJeWo2WnltY3BRd3k4NnErMkJ0Rlo1UDRoNUlWN2VDa0dI?=
 =?utf-8?B?MXFuclBMUUtPZUZXL1l6TWpSU092ak1FUjJXVEo5ajFCZmltMzV6V3ZJdEJ6?=
 =?utf-8?B?blBhYXJ6aEFKQUZrUmdseHZPaHZLRXNOSHpRVTROMjlJMkltU0FQMEJtbUV2?=
 =?utf-8?B?WDRlS0VuS21LZmNOcFhqQWhRd09LZ3F5QTgrdkxmMUlXK1I3R0pYamRVVnlP?=
 =?utf-8?B?RFdhVVlrZmhUWDlGbUZpZmpmYk5ZeStzbmREYkprZktsbDNab1lvaDcyZERG?=
 =?utf-8?B?RGdRa2t5RzQ1ZlFhaHhSS2ZWeE5PWmpqU2dOUCtndk5FRWJJT3pqWExoVnFv?=
 =?utf-8?B?TzRrUzhqakdFMHFXdnRzeFdnaHFMNEVndFVhTVpRWmJXUGQ1Ukthc3Q2NUhm?=
 =?utf-8?B?aW1iV3pXUFp5V3hhczFMeHc5bVhjM0FDemFHU3E2WVJYQTZqOFA3UTFJMWhr?=
 =?utf-8?B?bDRER093RGZXRUJvM3RYcEtwTmR6RHpDZUI4TWowc0RGbEN4SHkyN2lqOEx4?=
 =?utf-8?B?aVB5WHU2cE9zNjlLd09pOTh3MXZ2anpiNERQVnJvUHB0aUp5YWIzeVhmaUtJ?=
 =?utf-8?B?bmRhUEx4R2hNOVA0UXBBMHFmRVhWUjdpNm9NR1lWVDBZcGtpWWtyd213UStY?=
 =?utf-8?B?NmtWbkJkbDkzVHVRaHhkdUxqOGdEUkIreTBGWS9QRGxLR3ZUTHE5VlJBcS9m?=
 =?utf-8?B?VUlXbkFRczFjeCs2WGtucGwxUjF3enVDSFoyNkpUcUNBcWpVbWlybnZ0ZkFY?=
 =?utf-8?B?WGVGNUEwV256dmVzZytaWFQ0cnFua2lVRGpZWlBNbFdNY28xM2J0WVhzalBi?=
 =?utf-8?B?WGsveHk1a0d0UGxXMVNnY3FhemNmeWtqRDI1UVRMVi9uWFFkcm9IRFlrK3Rw?=
 =?utf-8?B?K2hoSGRCbUJzOFNERUxMMzkxc2g0OU43VWV0L3loUzdQUFU1RUZua0czVGhL?=
 =?utf-8?B?SFZDYzJIMjlCbjZwanZodXRrN3NTTzBVYitQZ0xrc2kyMXFwbzNoNkJVWVdl?=
 =?utf-8?B?Z0xIYzd6VkZGcmx2V2NjUndYVGJPZkEzMTB1N01kY0laWFVFd3hidjc0MDdk?=
 =?utf-8?B?SWFNSVN1SDVmaEQxWm5CeE1wbmJNaGNhZHhaUjlqZXl2LzNjaDZYNlJlVmc3?=
 =?utf-8?B?QmM4NEdlZEtEZ3ZReG9KZFdBS0htUnphQVo3cWVhRkZCa0Eyem92Qkw3T1JG?=
 =?utf-8?B?MVdoRHpSVitPc3Bua0dET0xoR0U0Q2J4cWxIcVZ6K01UY2ZEWTh0RS9hT2Fs?=
 =?utf-8?B?NWdEYzAyZm9DTnltQU9CemdqclNQR2poUnM5eTBsTFpIbGxDWWlCNkhkSnVs?=
 =?utf-8?B?VC9EVFU2WmEwOEIxRFd3TEFGenQ1MGFZWU91SmJYRkpuQ3dvbU51c2YrZUZL?=
 =?utf-8?B?WDF1MFpmRUVEYld4V0VVUlErUnNuUW1HcDFWZERHRXZxYXBISUQ2QjJxQlJr?=
 =?utf-8?B?T2RFZXRHR2lNVzFGQm0ybE16aHEwSmM2TVJTYmd3Y3ROUmxJRWVkNGQ5Z3NK?=
 =?utf-8?B?TDVxVGJodDRCSU83K2R3U3htdzViQmxLUmZuNEhUSHp5VEkyR0EycXo1V3Zr?=
 =?utf-8?B?VVF4ZFNBMENnbjgvSW91SWNYa1UvdTFqYXRIZXo3aURJdFR4aWVQVlE2NlRM?=
 =?utf-8?B?V1A4c21YTW1KVE5Wd0RsakFTSnBRRlZHWTduVTNWZWh4a2NkTjFNTVFsRkZK?=
 =?utf-8?B?WDRIVFVYN1dpbjVIcHR1Z0J1dk5lRzB1Rm9KNENicTlFUE1Cc0lsc2w4Yk5a?=
 =?utf-8?B?dXY0eHVqaUJSTHlHSkJkRVV4cUV4R3dURFhvZUpsSVZlMUNOL3pvU283MUFO?=
 =?utf-8?B?Z0xWc0k0MWtScDNVL1BjeVBoVDBUVitYeW1HdkJyak82Q0hMMEVOdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5452a074-f1f4-4dcb-1981-08de7a2975f6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:06:02.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSBsEWfvB2C3kKPxi3g22G5aZsllfHCyAP+47dBuXeiymUQUhtz43aUQTurS5O/xBowJksaOe+TkwgGhgXA10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1884
X-Rspamd-Queue-Id: EFDBC207675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-43621-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Action: no action

On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
> Clippy reports:
>     warning: consider removing unnecessary double parentheses
>       --> rust/kernel/cpufreq.rs:410:60
>        |
>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), po=
licy.cur()));
>        |                                                ^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^

This looks like a false positive, probably due to how our fmt macro works?

Best,
Gary

>
> Fix this by using separate format arguments.
>
> Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and d=
river ops")
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 76faa1ac8501..e94a17731557 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -407,7 +407,7 @@ pub fn to_table(mut self) -> Result<TableBox> {
>  ///         .set_fast_switch_possible(true)
>  ///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
>  ///
> -///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy=
.cur()));
> +///     pr_info!("The policy details are: cpu=3D{:?}, cur=3D{:?}\n", pol=
icy.cpu(), policy.cur());
>  /// }
>  /// ```
>  #[repr(transparent)]
>
> base-commit: ecc64d2dc9ff9738d2a896beb68e02c2feaf9a02


