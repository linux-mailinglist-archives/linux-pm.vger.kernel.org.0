Return-Path: <linux-pm+bounces-43627-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPkeL8mYqGm8vwAAu9opvQ
	(envelope-from <linux-pm+bounces-43627-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:40:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ADF207A94
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E2B301914E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A58384226;
	Wed,  4 Mar 2026 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="a3sgBRA7"
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022124.outbound.protection.outlook.com [52.101.101.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B3382F0A;
	Wed,  4 Mar 2026 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656805; cv=fail; b=Y+z4eR1bmv5X37t3bmVgKTe+MKtuH9U017PnCmorN+cAtP2g5RprNk0ik8JmD5FvIQXjb3zvTRzOWo3zwZ6a0IaWhzjLQF6VvKTX8Muol+Gh0nEr77wEb4wjAGGaWAduKxc0kt6DjCeqApvS3oXaCQsk+j4Iby5D1plnJmNtWqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656805; c=relaxed/simple;
	bh=EUUL1Lmh4h0RIIxXnLA49OE1i3ov7K4JpESNC0c/8oE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=DXFjNZIEa2xP0vWvWrFElcl2dO0QqebEkka5jRIoyt+Zk3427B1qGoyi0kY/D0D6ZpKAcQ/zFOZ3wH22H3jGSy33YZbbS6N2FGzvHtlHjbXuWaydt4c+vzuKRSl2o4tXJF05TT6oG9CR4wc9n5F7SJwe3qy+OtWpL9NpRLhknV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=a3sgBRA7; arc=fail smtp.client-ip=52.101.101.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuW/P5GbaiIDf8TwgK/TK3B6Ztc9wysy6iI0hJAcnFP1sA/8g7B2FwEmVtxZA7KCUq1wqAbY6+DjlXo3dzZEJI1rK81cDwmNAqFk0aH/aEjuMSgrN1TKKJPxs/bm8xSLEstNVAcoH0VwSNtxFLqed30HLYlSC4yQEaFI4SglYxdgCuBDd7UPzh4O4jdzrzUlyx/EhbkfrAR6rphXmIEB6LfLlM4IgqkG3CoKpIlWCnx5hh1sl9ZG2E57FajEWxNK0gT+/mEe+naYvthGDTFi72CpozpoLo+B/h9wJBHPb5oU+TUA9XwsBKZl/oOunLOnAjgatWSQ5EYWUWA0DeK2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+g8Nc2vjxhPUgA9D+Hojq4h6OBBwoRZ1WT5oKfT66c=;
 b=xkwdoM/cN8sTWqlqQTJQt9KpKoVRq0duFUqm3vkkode4GRIPdZmJEluGL93wi3mlYcoJtjZTP8kGE/Brz/0RR4E4B7VEgsn9lGy4ZzkC1CnkJVYpjwjAMhAtW6p4DZ3BjOpMMz3IVl5msDrnt7UBZJT4P/tqluTsP9/Z3QIZ3p1EbySweVi6l+mPzMa6U/fbK+eztIVCSu7i2pQ70OOUWgU1S6OebYwxrMlcXeE48tL/jGww8q1bh12k9PGCF+kVOILm54lVgArWB3/sc1R1B6Lt+i6UY8hbmBYgf7in9yBPFu1X2l/dzhfQcgkA6J2XZsxifZM8coZ8kaxjaKjcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+g8Nc2vjxhPUgA9D+Hojq4h6OBBwoRZ1WT5oKfT66c=;
 b=a3sgBRA7usCs6HcQQNmd8YH0R68z4LUtLnOPfHEzKv2w3MegBpH+Q3cgmhxI+j4S78TNHqjH25DBo9dlO2ULj2Ttk+Bh91FncYz4/Qy9rEXFgkTy5HsJeQzc5uqN+uh5SrEEuIk1cyye2+aKqsqRGdT8rw693RVsuQK/BkBKRos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB7060.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 20:40:00 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:40:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 20:39:58 +0000
Message-Id: <DGUAE329P4FH.3QPNCVLNA99MC@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-pm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: cpufreq: fix clippy::double_parens warning in
 Policy doctest
X-Mailer: aerc 0.21.0
References: <20260304195330.185829-1-jhubbard@nvidia.com>
 <DGU9O3HEY7CN.3OBR26YV3AHGT@garyguo.net>
 <ea3d6134-22ce-4715-be75-e6d41568c7eb@nvidia.com>
 <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
In-Reply-To: <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
X-ClientProxiedBy: AS9PR06CA0422.eurprd06.prod.outlook.com
 (2603:10a6:20b:49e::6) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd7e18e-6be8-4230-0d97-08de7a2e3481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	hY7ladnA3b8l0vTbtJfhrkzKcIFawewhKzWWIQ8y9DbgRuF+LcEWhawNOMWQtvvFEL2vvWIcf2Rqc3S+r/kae0SBl8GAiCeJZIwx20C8C9Xjb6OPfuikf+MVLeuCvUen+NVAmg0Bw5eVRoviDGaWUUI8Plsq5ECqueAwkv/JbzEM8m7R9X5mCi8HYH6ApjT+q9AxS2VsgiWOixGT9hOQRlNhpRAJ4XxBqbC/WcpZRbfjARqtnnpRLSJf4jHW4B2WuYd4uTc/syMclv10wZ7PFif1orBIhzyLKozXCM0J88i8m6CBBAdWzxz4+M7xu1a/GpmC19fs/CqXdwOtkF/54xg/fVqm6i4n85TpyDlh/LG3eWfSusJiNgalADP3GAfzCF+PFrCkco7p5EGURW2iyCXKARY/AaQj+I7iUJ58RfFGraW7M+kjCOKsrIdlCnl26mFC3sj8oeuEIVFJI/XuwSninOdtCn5WUkK5pkz8ZbCn98R24eJSutJS+sapJI8KSpAgR1G+Bnccejs7mzvkaxd3aOL/pDkyy3qIL27F72Foe34/vNj+47wz0meNfaae2MrWvCxSt7h71yQG5G5P/0YSw1ixpMIIxnNIby/buzL3LmtV5lKaNKIla63RYgZYuxDZKYuEkUaOYpLJLgf5KCvWPN/nopBWod5AUHpphMsxuVi5HnDQ/8jLmbHNJcLz4igrfWuYB6RY3jvC2FbWZbMycjpeKlwdAfRYNJVxx20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWg4V3VoYWVBY3NvYU1OcmRVQjl4M0hDckkvSzg4WW84R3NmbVJFYVhPQzhp?=
 =?utf-8?B?eHdPMm9KQ1hIbmZtdVRYeHV5YWNacy9aNnVIL2RsVE1yUnFpRzNPNUhvV2tx?=
 =?utf-8?B?MXpoVjJBcnNabWxJeXEzdkl4RFVSS2hEb3BzSS9WZ0RUOHNyUTRyVHduN3lz?=
 =?utf-8?B?N0todC9JT01ma3RNcnpWNmprWlROdnBmaEI2RXlMNXZDWk9ITTRVemZ3Y2Fl?=
 =?utf-8?B?eWhhSjdLNFY4aUg4OGp2KzNSWDVyVi9sSFdrSmVhUmVSU3poUHNvYjdxRUhD?=
 =?utf-8?B?UTM4QTR2dW1veTMwQ1dTOXRHOVVrcmExeEh4WmZtQnp6d1BRMnRKK1N3M1Zr?=
 =?utf-8?B?QndaM0pDdXI5UjRiaE4wMHRSMG1talNKWlluTGdpamFrUDBBODk1S3hsN2Vh?=
 =?utf-8?B?TkVnamJJZDNKMytycG16Ym5RTnVBenBhWW5uOU0xaUFvMzJkRVFDNzhXTHg5?=
 =?utf-8?B?ZDMvRVg1WU9sTzlidWtWNVAxSVJHdGJHdWdFWXBhaGhiaEdMcFN2cEltZ3d4?=
 =?utf-8?B?UlpCVWdNaVcwQ2ttZitFaEgvRkl6RkVmczJlUm00YUYrN29QOUxkYlk0dWJj?=
 =?utf-8?B?eXoxd3V5bHV6UmJWWFNJTGxaTlNzK2s4c0xTZEJHYXBnTG5SVVo2S0ZqNGsx?=
 =?utf-8?B?MkFmQ0luWnc4VHJkUjQzclplaDBJSWx2bXFPWXNRdGVkQXZkYU1SblBVdVll?=
 =?utf-8?B?WWp0b0RSb3NHUUQzemhXZkd5Z0dRRE9Jczd4bVcyNWU1Z3JPSTZZYUozdzJn?=
 =?utf-8?B?Q3NvZ2Q1OXJ6YVN6K1J6KzJ4dXArcWlRc3JRSi80UUV0VktjUVE0dVNBa3hX?=
 =?utf-8?B?Vm9qVlA5Y2pCOHEzRVhmcFBXQWJENExlNlNHMjU2bXRiMjdFOVF5RkVIdFpj?=
 =?utf-8?B?dHgyM2tVTzdUbTB5ZUJRUVBUVVU5cFptdDhJNDBkM0t6QzR2alJwbmQ0Y3dN?=
 =?utf-8?B?OGdLYldJWFcyYjhnWlMrT1I3d1R5LzRkeVhrd0dsWEJycm4yd1FseDVJNzM1?=
 =?utf-8?B?TjVIMDZkcUN1em9tYlVtYzJCRUt1YjVrSlFnUHlnZ3F0UUpOMm5keU5NVDRP?=
 =?utf-8?B?NEFyaUNXRGs2TEh4TEVnYjhKL3E3QXo4bzVjcmxwdkE2NFUvRzVtbkFkK0dv?=
 =?utf-8?B?RmFuREZwSlBPT3JRV3AwWG1CYnUyK2RiWDc1KzFSbXhOOXZvcC9XSHhKYnhq?=
 =?utf-8?B?RXM2cU5aNXZGTWYrSU1XYzlEWWsyeCsra3ZsZGVQK25RUllhVDh0R2MwaUxL?=
 =?utf-8?B?bndWbWJYcWtSWUdGNTFkT3owejFITVQ2dXVJb3ZIOTE1R0xLL0doNk9Nb2lv?=
 =?utf-8?B?QzVaVDFkSDJ2bTMzSUhKL3pHRnhJNGRPejV4aXBiTDJNcjg0dTRDdUxrNTht?=
 =?utf-8?B?RDRSTDRIS3krdllyNGpHS0pVc0hDN1VXbFZDcFpaYWJRVDJGZlJoRFU2ZlhE?=
 =?utf-8?B?L3ZpdWJxU0FoZkcvL2tPVkQ4STFwSGUrdmdpajFna1RIa1hXeTlpMVRqTDVy?=
 =?utf-8?B?V0EwWCtOZi9McW1xd1NXRzgyZ3BpV05KNG9oTEZYYmRXR1hJN1hYcWxzRk55?=
 =?utf-8?B?WS9tYSs0VFIwMkRWcmR3bzlGSDJUMXllbFM0dldIZUtIMTMvM21Bbk1SRXpj?=
 =?utf-8?B?NWlzYXFsUmhGRHZtU2NCc1lLVXVQSyt6Zlg0T1RXR3d1MkpqU2JCdXVjWWJR?=
 =?utf-8?B?OUtmMHhyaDB0SnNMSElPaS9xc1RIQWZHYUtTMUV4NVFqQlBZaUpoRlhQbnZr?=
 =?utf-8?B?akdzZXFPMTNUV2NkZGlmRVgvMXpKOTRiU0M4WnQreDJRY0ZuaW8vQnZ3REVw?=
 =?utf-8?B?OWw0T0cxdkVGQ0V3Sk1Ib3pvZEt3YWNETXQwTEtWc1pQeDdOYVJGSHNOanJ3?=
 =?utf-8?B?WVV3c2Jnc3kxcG9PZDg1VWhKdTViZEV3dXI1YmsvejE3U2Mzam1uWHBHYTFH?=
 =?utf-8?B?YnpzbFZKVi9id3NhQkFwN2ZBTEcwRlNUTU14SUxKYVllM05tOU9jeC8zZVJi?=
 =?utf-8?B?akRxeUFzY3lUQjJ6a3BkU3g4YnJGZ1V3Nm84WWdCVFp3RGJJQjBNMDBmN1cz?=
 =?utf-8?B?VVJUZjlFeithYjBYQUVwVHMyeE1Gc25JUXhuWGJ3OGpybHV0QytaM3ZUMGRu?=
 =?utf-8?B?UzdHSlRrdUZBcXExeFdWaWFRU1p4QW1ZdmZqNWVWTm84bVRIblJFdUJHQjJR?=
 =?utf-8?B?WWVJUGFQNmF0dVdRKzRncHZnQWFDQ2pHZEt3dFNva2dtbkJ4a1NqTFJibDBp?=
 =?utf-8?B?SWV5Tkplb3J4Wnk2UVdlbUY1d3NRYTlmRmkwY00rS2sybzhIdHpqdlpJYkRk?=
 =?utf-8?B?a2s0eE8yOFJLa0puN3BKQzdsSDQwdVFOYUJVcXFxTlQyNDFHT1Awdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd7e18e-6be8-4230-0d97-08de7a2e3481
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:40:00.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iocLf2gf4tVwbbhm1DhEKRgeKCXO7xN9MgGbEqUztkjmBWfJP7/JcayTXMG8zMmVESnovM6oKF9/ReS6R3QfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7060
X-Rspamd-Queue-Id: 35ADF207A94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-43627-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Action: no action

On Wed Mar 4, 2026 at 8:28 PM GMT, Gary Guo wrote:
> On Wed Mar 4, 2026 at 8:07 PM GMT, John Hubbard wrote:
>> On 3/4/26 12:06 PM, Gary Guo wrote:
>>> On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
>>>> Clippy reports:
>>>>     warning: consider removing unnecessary double parentheses
>>>>       --> rust/kernel/cpufreq.rs:410:60
>>>>        |
>>>>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(),=
 policy.cur()));
>>>>        |                                                ^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^
>>>=20
>>> This looks like a false positive, probably due to how our fmt macro wor=
ks?
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
> =20
>  use std::collections::BTreeSet;
> =20
> -use proc_macro2::{Ident, TokenStream, TokenTree};
> +use proc_macro2::{Group, Ident, TokenStream, TokenTree};
>  use quote::quote_spanned;
> =20
>  /// Please see [`crate::fmt`] for documentation.
> @@ -69,7 +69,8 @@ pub(crate) fn fmt(input: TokenStream) -> TokenStream {
>                      }
>                      (None, acc)
>                  })();
> -                args.extend(quote_spanned!(first_span =3D> #lhs #adapter=
(&(#rhs))));
> +                let rhs =3D Group::new(proc_macro2::Delimiter::None, rhs=
);
> +                args.extend(quote_spanned!(first_span =3D> #lhs #adapter=
(&#rhs)));

Actually `Delimiter::None` isn't fully fixed [1], so perhaps let's done use=
 this
approach.

Injecting a `#[allow(clippy::double_parens)]` would probably a better appro=
ach
today.

Best,
Gary

Link: https://github.com/rust-lang/rust/issues/67062 [1]

>              }
>          };


