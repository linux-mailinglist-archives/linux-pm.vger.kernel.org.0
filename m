Return-Path: <linux-pm+bounces-43680-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGEdHvR4qWl77wAAu9opvQ
	(envelope-from <linux-pm+bounces-43680-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 13:37:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A4211C97
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 13:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1D9A3012C84
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01439A061;
	Thu,  5 Mar 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zqxEUJaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022093.outbound.protection.outlook.com [52.101.101.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9853321B1;
	Thu,  5 Mar 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713920; cv=fail; b=lpDX+lutUHnyzVAPNVyPDSKbxXPZ1RCIlO9yjo66HpJRlDSYHoNUy/HoQcw+fAYu/9nNzhm+We6mfeo56iGrW+2hfRShkqgOWEQDK8UjEHxTChzz4R8rtKWqfPat2nkD5qh2nYXdiKz99dOSG47L1/sPuA2ZUwhgBaW4uPp9F/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713920; c=relaxed/simple;
	bh=8GkZCgSHnbnn2msCqenkWIHO1jvl4fUiFGlywCGcGfw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GTklpPZJ9a3pQtetWZx04X/59k9uNmGp3ap1GCuenwKsX0DHK1X/7UXUv0tqadCAaoTEfGEonHlraMnrL5Sh459h3Wx438a6iO1/dGU8DveR2gt9p5Fqc9z3O6N3mcjeGrc1rODGGii1FeF/leYBlvKsQhDcmOCsDJf5RGcJ89c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zqxEUJaF; arc=fail smtp.client-ip=52.101.101.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW8QM2gBgc24huHRB4PiNaURRUDCNxnJCWfeQ5t7EIPtU4D0H/ID0bqDbAKWGs5Ii/OHJDZRvBAzFZ+HJq86gsBYF8m/hDgn8NkIM10YNTB3vItI5x2A13R4SZ3pzkmBQzFs9Mp0ksHPhxxNq0KsdRZL/4IVOmxKA55fMPTzg6QaKBudX131RZlTxIt5wLxPzCPrKF13jNKet55ekPn7w3r5nlTti31VbpmyUoEaOWJIvOaPCGWNc6IINIeNgBOYsJ5Mak/btgbUIOCRTA2Ghmd5F3GVCVnRS4Oy7F10ZVdsYQO1YrqpmwTrLLs83oWcpLqbAwkg8tg2IBaGNZSf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU760lzaoax0hqElGnEbWWdIa2N7M4uWMxpQuJscI9A=;
 b=NCUZ+eK/LFNFiwbyX6w2Kx5UHjjSx5GhEVxvE6P0wfSRnCDjpyyggMQWLyE0zqu4SJNq0ckYAlYvTHDnFMXBo8u9firwWpPy2yso8GTHdT7pzSTyo02LdUAlOd8t56b2fGFnwFzOQUGFcoLPN2sUMPiMuRIiYPS/2WCGaR+6SQtwhFh5E5Z/acvbRAUr3n58j7uvraA6nw8bukDZvkx4Luh/fk+2wsAHIvQmOKP/jlzCnExresAhejqQCqhVItmAm+PHbpPYGBzqV3U7BQ/n0sP7t789aP9XG9GHeaOHPaNQU+yMQ3ldRruadEzPJDl7ULDt7md4/ixiykPxI0f4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU760lzaoax0hqElGnEbWWdIa2N7M4uWMxpQuJscI9A=;
 b=zqxEUJaFs5cBP+k7wiKq1kLuPX1q9X5bMeRt0vO5i0MUh1YO8nuYThWLA/3oWjh1fjP0qxmBEIcOhIDfwwQc7O2CqUG1tnnPUZtO88C468++RSF5G7JW66OfhePn7SQJiRUcA9moRt31omsojKYhbODDcH6OTfEL2ucDzpS9WY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7333.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:31:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 12:31:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 12:31:54 +0000
Message-Id: <DGUUMXMLYH02.2ZIPQEXAJYTEG@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-pm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: cpufreq: fix clippy::double_parens warning in
 Policy doctest
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260304195330.185829-1-jhubbard@nvidia.com>
 <DGU9O3HEY7CN.3OBR26YV3AHGT@garyguo.net>
 <ea3d6134-22ce-4715-be75-e6d41568c7eb@nvidia.com>
 <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
 <DGUAE329P4FH.3QPNCVLNA99MC@garyguo.net>
 <0c4ae9ef-b803-4ead-a2c3-d5dc37592d5e@nvidia.com>
In-Reply-To: <0c4ae9ef-b803-4ead-a2c3-d5dc37592d5e@nvidia.com>
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 0742c69d-6e74-466c-1599-08de7ab32f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	+lKJjEQYk+qdkvGECM2pvJTuRW0Qo5aZJomAYykldysOcvjKxE7Mn+bQ+CjsxOF5j8sZmaY98zc0Qx7eoa0ZFba6aO7hKqdzA7hMUBVH8VgeJ/IfMaBhwMXFF+cot+u/TjrtZlSPjat3NGfuJ8XyPzu0XJHXMo0e9HPZnEUBhDARGOroMotpKUpMU3nJiW6x+/GDN/ihuq0ZZCDExNX8wqVFwCSOHMf1+atwxjEtfCIWqLBk6STTpY1YIj/dkp3bP4vzZtAuFNkPfU++l1nOM9OFNjBsvvmyZqbeQFwfDyVlI2YgVt+26BwTRRmyPf7UuFKPmaSlUFCacUIwB+psVnJaMAnHOO8wc48k0xCYXZDu2Ehg9LNMMyfSQ7qRWKgYZiRIRIEQmUWrlKWge9t+jbKuqu6vVqJXeNOlhZmwUFFNTJ/uSXyGlvujJ/0K865rxPozArxeHsOx8ed/ocRuJFp+s4WacygEuSHdA6RE/jdRo0Qp+H3ucxH09YmgPB0r7lURt1BX5XPlLx93SqLAthTdM4vG6oiBSdo86yXIeFVgmCMvho8GEoT6fn9ft7PZ0kfqD+hadI/3ptMGByMCPt4/y1IoXA0Ai1aLgGi6zXbx6FuGFLj+vngyGnCS4nNF0NLdsqtYUPfBCjeQrnH+IWfPGBjLJwDZhyBy3/bxHGad/lwsonSV/q4iqbRn0csU1BsoZvwxSaahjjqRukei6OZh4gefhDqAvT+WWPL+Pec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K29hbHc3aExnVmgwQ1dLck95QldkWmM0Mjc3M2hmRE1GQVUwMnhRd0IxTFRY?=
 =?utf-8?B?SjBENEtCNmd1bTBqOGNLZWRWaHdIQ21KeWIrbjFHNmQrWlZwSWNrUERocFN2?=
 =?utf-8?B?a29tWjZCT1piekFlS2lhSjVscjhtNjdJSzRVTEMwZ0xENVlqclhhSllJZmY3?=
 =?utf-8?B?VFRNNk13aHp2KytKbCt5TUdlc20ya0lnVENmTzJVNlFhYVQxVEVkNkhFbjYw?=
 =?utf-8?B?QUw5cExMSGxNMzBWSUd2emxxbThEMmZlWmpHRlVIU1BlUDhZTGE0enRIVHFT?=
 =?utf-8?B?WExTU3Vvakl6Q25HYWZEMXFHaTYya0d4bmxLdlhkd1NUM05jNk9ocFFpU2VK?=
 =?utf-8?B?L2Qxb3RwMk1JWGNHT1ltcGNJVWJPbWFES05SaHNydlVMTC9DZlRWbWl1b2VQ?=
 =?utf-8?B?a3JkMncwTjhhbmdzOU52SzQ1Vjltc3pOK1pZdEZCM0JUMExzQ0U3NnppajhC?=
 =?utf-8?B?TUh3UVc4dHhpVm9xaFN2TzBRaFl1aVBTQjVPRlhYc3pUVGxnM2RKUDRLRXE4?=
 =?utf-8?B?UHk4L0FYU2xmMVVsc0FlbWhQQnJTTDNkYjhXZHE3TW9nZU1pMnFtTXlqM0hu?=
 =?utf-8?B?eEpKbVVDZkhTN0RkVHpYSkh1ZkNMdmdmQ0VlTDRJNC9sdGd0cXozK0RkeVRH?=
 =?utf-8?B?d29BWVZMSzViZ3FWd0syNE5TclI5TE82aWNhRXBsWTBURjhRSW1kZ3daci95?=
 =?utf-8?B?dlM0T3o2TXlOMEgvS3A5LzRuNEZHTmJHcFVqL0M2WkJuVE01eGYweXFNNGdN?=
 =?utf-8?B?aUkzOFcxKzFiWHE3eGtMNGdMY1Jzb2JhazVXa2hKSk84d1BjVHJQczhmd3Va?=
 =?utf-8?B?Tm93QVFBNTQvUUZ2VmJ0L1k0eHBVSFVIb3V5aEYzNFh4MVVGUHFoQStTcmV2?=
 =?utf-8?B?dkJwcUJ0QW9COXRhOHRxYmxiSGtDc0NKZ3JvUzhLOXR5NGkwM3NrbjYwS3hO?=
 =?utf-8?B?aEorV1AySVM2Yzh0eXUwMVhrVDBZWlE3V0lIc21iQkNNTTJEZTBrbklsUTJr?=
 =?utf-8?B?ZlRQZG0rZFNtamxETXlKRzJnTFQwbFhtUi90dGxhUUd0R1M1OElCL2loM0Vj?=
 =?utf-8?B?RHd6eXcyVG0rdEw4QUVlQWRDaGJLRURrYjNjeWJEd005ZjhqcjdGa2l5dFpt?=
 =?utf-8?B?UFhFaTEvUHc1VEUrTFJLRDBjL3lNUDFNOXVsdVNVdWREa3laZWM2d1AxQkRo?=
 =?utf-8?B?eTJWN1ZGV1JrRUNYd2d4WTN4TmdnL2pDVXpzbzZReGhUeHRud0l4S00wS1dI?=
 =?utf-8?B?T0poMW14ZnRxeXJzWWFSdlY0Z0lIWjVTTGFiRVdYVEJJV25ubXNPWE9XbFFI?=
 =?utf-8?B?c2l3NnNydmFoQmFCUHk5R09hRnBYdDZnbHczdk9uUG1USTE2MUFreXU0OXE0?=
 =?utf-8?B?NUVxbi82NkcvUW1mK0psNzVwTktNWGhVNno1VEZ3cStoNG80OVBZTnZERURC?=
 =?utf-8?B?a2wzTHZEOXBFWEN3dmxBcXlhM3djUCtoaXJ6VDhmcFEyUkVYelhDTXFiNU9a?=
 =?utf-8?B?VVFUZzdWMkpOaGYvWXpnd0lxaURaUDVYNlpvbjZKVXhvdmtYbjV2SXJ1b3o0?=
 =?utf-8?B?QzFBeVVZY3QyYjQ0Ty9ObEZ6b1AzNi9vSTJuQmZvbTI0UnlQazRyTVVqV1ov?=
 =?utf-8?B?KzV6NVdKTkIxc0xhRk5YU1lKN0NETUg5b2lJSEVZeXhVTmpTcGFLNWVtSnlE?=
 =?utf-8?B?RG0xRCtpYmw1QnNPTW1VSXVEdTlLcmVzRTBYSkdnTkdTZldXNm5XZTV2NXVS?=
 =?utf-8?B?Tkw0MVZRdzIvS2lHcURxMmQ5R2liL0JZUzRRMDRObDZISFRaUDhIVjlEYTVU?=
 =?utf-8?B?N2NsV0dHZVpkZ0tuMURwSURxbDcxQlJsSDJQNTg4UHI0Nnp0WlFUeHRIRFoy?=
 =?utf-8?B?MnRiSDk4ZEJsMGNhVWxNemRZdTlTcEhxUTRuT05DdEVhWU1sdFFUcUw0Vmdi?=
 =?utf-8?B?UnBObDJHSE9nSTdyVm9Nc0dkdWtJdGduMUlON2hZd0tsNGdIa2tXTDJWbk9j?=
 =?utf-8?B?MzQ0S1YweUdRa0VwL2xHZzZlT1kxQzE2OUdJY212c1hrVVgwcXp5WmdFR25q?=
 =?utf-8?B?SUtMRmpGcVNqRWZxUmRvSmM0Mzh3MFRqaktFRW5ocTl3Y1hyU3RXaDUwMDNr?=
 =?utf-8?B?QVZidndMM2kyeU43bmpCY1gzQXp3bXBrRGc5UGdtaThsTVM5NUxqclNtcWFx?=
 =?utf-8?B?WnJORmxYYkNOajVwb3VGNHlGdGsyZEN2TkFLRjFUWVFoc1pRUlhEaGRqSkx2?=
 =?utf-8?B?eWZiS1lQeGdmNHVHWlFuU2NqbjVxM3Nnb3psR0lnS0o3eVUzWDlySWtGeVVF?=
 =?utf-8?B?VFZUak12ekVZLy9jNzc0clY4clY0SVd6QmtLMG1vRTlhL2JYVGVFUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0742c69d-6e74-466c-1599-08de7ab32f6a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:31:54.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH23FIFyBw++5+iM6nKzDxvhu92ooaABUL2JSAVL5ggISfCOjeS3d2UeNJvcUT9T1H2ENr4+jOTbHtVZp6NvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7333
X-Rspamd-Queue-Id: 105A4211C97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-43680-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed Mar 4, 2026 at 9:13 PM GMT, John Hubbard wrote:
> On 3/4/26 12:39 PM, Gary Guo wrote:
> ...
>> Actually `Delimiter::None` isn't fully fixed [1], so perhaps let's done =
use this
>> approach.
>>=20
>> Injecting a `#[allow(clippy::double_parens)]` would probably a better ap=
proach
>> today.
>>=20
>
> OK, so that gets us here:
>
> commit 924f411d6cd0cc4d702f197566f5e701915d5760 (HEAD -> fix-clippy-doubl=
e-parens-v2)
> Author: John Hubbard <jhubbard@nvidia.com>
> Date:   Wed Mar 4 13:07:43 2026 -0800
>
>     scripts/rustdoc_test_gen.rs: suppress clippy::double_parens in doctes=
ts
>    =20
>     The fmt! proc macro wraps each format argument like &(arg). Writing a
>     tuple argument such as (a, b) produces &((a, b)) after expansion.
>     Clippy flags that as double parens, but the user has no way to avoid
>     it because the outer parens come from the macro template.
>    =20
>     Add clippy::double_parens to the existing #![allow(...)] in the
>     generated doctest wrapper block. This only covers doctests, but no
>     non-doctest code in the tree currently passes a tuple to a printing
>     macro.

I think we should either disable with

    #[allow(clippy::double_parens, reason =3D "false positive before 1.92")=
]
    fn update_policy(policy: &mut Policy) {

or disable it globally for all Rust code before 1.92.

Miguel, which one do you think is better?

Best,
Gary

>    =20
>     Suggested-by: Gary Guo <gary@garyguo.net>
>     Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index d61a77219a8c..e9ca56a3b73d 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -208,7 +208,7 @@ macro_rules! assert_eq {{
>      #[allow(unused)]
>      static __DOCTEST_ANCHOR: i32 =3D ::core::line!() as i32 + {body_offs=
et} + 2;
>      {{
> -        #![allow(unreachable_pub, clippy::disallowed_names)]
> +        #![allow(unreachable_pub, clippy::disallowed_names, clippy::doub=
le_parens)]
>          {body}
>          main();
>      }}
>
>
> thanks,


