Return-Path: <linux-pm+bounces-43623-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOb5EASWqGkLvwAAu9opvQ
	(envelope-from <linux-pm+bounces-43623-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:28:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D900320798B
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 193453021420
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1637F8CD;
	Wed,  4 Mar 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IlKiAJYR"
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021139.outbound.protection.outlook.com [52.101.100.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813C361DAB;
	Wed,  4 Mar 2026 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656129; cv=fail; b=iIevReCDqkCYkG2FeWhK+0EiyjMwBnLFQYy7JUTt4z+w3FJ2aBtce7O/zrQbi1QZh0mQYy9cT8PpRNep7pQ6Jw2fprCLygg8m9IwKvyumjyZhHfZ7I5/uA/P+AAjExc0YoASlruK1Y4dmZzlMVgJExC2x9YforfdSQH2EZt+two=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656129; c=relaxed/simple;
	bh=p9Ibk8VOsnOYHZ87sEiL28o07JBxF71LhyfT9l2zVtI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=jpxY8aB+P52metKqYJ3U0rjIhKp0CxXRoIJrOsSSfzn+mFh99h+/A9xAtvc9STgEENz4uV+GsSrmJVVNUM5W892stwRD8daF9MhsxwMm+xM/riz2oB4Pv5Suuw0Jir9JMgs3uTr60VrmBNKmL7O1zrv8ZIj8C3bkHXb7LJ1nYho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IlKiAJYR; arc=fail smtp.client-ip=52.101.100.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvlxnIPfBQpKU4lM+kMjvMtrp1Z2bYrSsbLJ13cM+4PlUCRfwiRZiVnkC6ScQSX20OaViJHx3Dgf19Om+Rd9g1P5ZMjOhkREzfpOucXNNhVyzsRe/maTR+RTIfd45MKAKv7J8QGBk9I5rVITilw/vl16BeoPyeH1ZitHOLN/4+KYgGAVT6K5INspRo6j9ne7j5KXLPRnGBOqMWMpv8LYETenRP5FNKBB03n3R6HffYAolp9d/oIHGvU+YDTkamwkglMSltGtmapx1xGRJASMsqn2KBfYBDgC1fEQ0IHDrOrTd9k5UU8On7n2nKm5XVX7sdxOsxKMH2+BrfZgzK/ZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEwX+Bk3UOIRl4GY4Qnwe1NPkPDn+MbzHkJZj5RL/04=;
 b=GhCd2BOt/Z7smSrg0hiGe1+EEktrDphzFuyDgG+wV3v6cRqkKOIYkeCgNh3jnGioppysfdzWwYRWBOT4dJSWSQ/qhq73fMaXhRtg236dao8rCQsNINVJPoo7vaaPfzlIy4BcnJ1A2q+ca8nRcG4cE7GkJC57PVFZMcdgIQWgVp954YV3ZiC8RyP7Dq7ocDyIJO7ihIGndhYvoK22vmcSHIH61LbR9BCwAkjdGCGtVrMVfWXO7mIH3gXttMFrVEDZmWXKSYFencX2qHdGXi4tpfgj4rQSeS7JZsw5O8ci6N4DIlVPaJFxUSX55Pgtmv2axTx3bzUJ2iiWgzmxtD5lvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEwX+Bk3UOIRl4GY4Qnwe1NPkPDn+MbzHkJZj5RL/04=;
 b=IlKiAJYRDvZQkvSzaSt56CiiRSpDMhocccrs/GRBk6dOO6VlbsVB47Lns0+KUXo4OHMOE6ELAXiN4wESC5b2HjKA7FcKP6zPmNejXmb4apNSAbOGuj55aZ92xZMnUcvqDU4AbYACNoaadWwnNcEnQNDyTokL9EGYDqK/YRtsZQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 20:28:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:28:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 20:28:43 +0000
Message-Id: <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
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
In-Reply-To: <ea3d6134-22ce-4715-be75-e6d41568c7eb@nvidia.com>
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3367:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fcee48-1c67-413f-92b8-08de7a2ca17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	o10QlOL7LlVKVVV4ImZaHi2ETrPShLc0270JDS7borxjUqDjpKur0XVpUZ/qVtcfY4OJVh1BRC43PAdT7lihhjWlS1T+g4tz4J5TlQYOEqUyGdKbJ7oi81xpDmFbj4qp/clbnu4xy2UBDqNDdGTuWcYSvVXbmzhXDqq4vduz96AJWk7MoGDkLa5dUEd6O/+oQWSp40DDZhY4Vtzxocdt9Cl2XZULuXX6qh8meWDtEO62bnPtsX5/1SQcSLlEHzvezw5Ey+DqOzbXHThN2+k7KoXfHjIUSHd1XXf6cNx2+4kwROeb5vVuSBOwcdUNf2Zg3aDiZEq1xli1mshc7BDSKEHGQOIxsWbi91a4fe3Vp+ksI/UlB0xafz6llRQAUvq0q3lanJe3soifLWJmpuuX2NwIr77xcLBGjlFU13rxFVRS55HQlW1VUgiCHfBUrYXQPF9ZJR+jfcqgWwBZi1ga2c84+p+WDqVoNsRL5V1cSKtrG7/h/i6VIUmPh5cW9PUFYDAEF2gx6NGllqWN2+bhn417hG/Slpi/3UB7Q9x3fCyR2K6gvPpMiczONnXgXHvRUmD3SF/ND3wKxgOVXGwMlZ3HOv2xcltHjbA8E5b1ev0aTciNqMaMc+nmpANA85Ul9sZqNnA9Y1xTjG0TCZwrrEGVUXnyxIrolIQiG4okAsX81SVAFVqBgx/7d6uE3ku8+klZbFB/ew8cxqZwg2/e1502eYHGfyV5fWKlRtAwwNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhmNUo0ZHZMWjEyQU41cmkwSGI5cjNMTWFua3Zpak84dTZOMUpzSWtFeCtJ?=
 =?utf-8?B?ZERDUVBxbnU2QS9JMkdnam9lWlZ1aHRZUHpCQU8vcmFkTFhaZkF4b0dna29Z?=
 =?utf-8?B?MWhSUHZEcFhLenJFYnZlUThHNjZvOU14SG1YOHZtVEptMEZLck5MNG1qS3Jh?=
 =?utf-8?B?YmMyWkFlTWp0cVRIN1d3SEN2aGZNYjc2ekVFT05nTTBXZ1U1OWpWVk91NjZk?=
 =?utf-8?B?cXBrYk9xanQybEdaYklIampNMWVvVzV6cHh2NjVnVU1Bd0hSMHJKZTc2djc3?=
 =?utf-8?B?Y1pBbWsyZFU5cTRGWFE4bmJjSHMrSGtTLys0V014OU9Od3V2Wkoza2ZYZlpa?=
 =?utf-8?B?dTd3d0hyYm5QZXFDRTd2VlFGZXFjL05jSVU3ZFl0NGJETW9NQ21tRjRHa0Z1?=
 =?utf-8?B?QlJDRnhsL2ZBUmFZVjN0ZVpjeVU1TkhEVWVibHNOa0xoR0dEMDlVVWhBY1FM?=
 =?utf-8?B?aEhUM3NqMlJTK2xKMzIrUzRMU3BETWVKRks1Sis2MTdlRnRGTkVldk9jbUxP?=
 =?utf-8?B?ZHZraFJHdStzaE5qUXZmL21RaXAwZXd0eW1NdU1MUzR4SEJ6QnlQTmxLcVBq?=
 =?utf-8?B?MkNPZ0dwbXlZbDNkU21XNEVUTVdRVC9TMFpIV2NZdmpjNFNQbmFvUjhXRkd6?=
 =?utf-8?B?dVVVeTRYeGJKU082NVNMeWM1OVZ3c2txWllEVjVJWk9HeCtLV3dCdW0zNjlP?=
 =?utf-8?B?d1o3WGR6c0pGaVJYWGcxTnVFWFpPMUVXTzRrUFBDYW9IYVVtVzJRbkYvdUtj?=
 =?utf-8?B?WFhZTWxFeUZUdjVDRHY4VjZndUQyWmVUbGd4U21kaisyUEpNWEp1MGJ1cjlW?=
 =?utf-8?B?L1U4N1RGc0lkY0VKNlFDUkV6aEFwZEc0MTBaTTQ1NmcyS2hGMmhRVUJleXZk?=
 =?utf-8?B?bzc4V3JDMmIxbzRuSlRSMFdIeWFkdWcxeXk5K1R6bzIvb3JHaTRzc0Q5NFN3?=
 =?utf-8?B?NW1aNE9GMWRaRldXY25Gb1AzWFRtYXJiZWdvTmw1M256S3QvdEM4dllPNDd2?=
 =?utf-8?B?ZGJpZ3p1T1BpVnBwcjN6SnpjQ3ZBREVxTE1DcXowL3A1R3VILzEza2U1ajhR?=
 =?utf-8?B?MWJQR1RDeUVPczdpa1VBL2N2MUxPN3ZqbGMrbW5GRVdtNlNOZmN2eWQ0U3A3?=
 =?utf-8?B?U2E2UmpXellDaXpmL1BRMnd1c1NpRFVpUHNQcUtUd0M5elR1c2Npd1lJRUNh?=
 =?utf-8?B?bktoRnEwek5WWmdXbHVvdHFwbW1mY1laN04reERYMys3emZxOW9ZNjlTRW5x?=
 =?utf-8?B?bG94NE9KRTlrMG9pKzZBakRYZXQvSkpvZGtnL3BZNmhRSWlXTGNPWDd1Skor?=
 =?utf-8?B?dWNqeldQOWRKU21ydEFHVDNTS2RTK3grYWdKdi82MlJ0VGFqWU96emVCMW90?=
 =?utf-8?B?NHYyVVFCYTdvQnVXTmt2SU51TXVGbml2T3FaVyttck1sWVFQa2JQRDlzMEo2?=
 =?utf-8?B?NzcvMHViVGJOTWNsZXNFL2YrUGFocVVpV0p3a1IzRWcwbU1FeGhjSWs3bXpr?=
 =?utf-8?B?VWMxdEFTakhPVW1wRUNXV3BNbVdOekNLZHFsU1l4UDZXeXlhV0Rxa1JsMXhh?=
 =?utf-8?B?WTlkaExUVHQwRnZQRVpLa3lwYzI2YU4zMXpVandsT1hZdmU3RGkzQjRyWGIx?=
 =?utf-8?B?TG1oQnpmTUlHNzlZM3MrRk84Y3BSZFpuN1BCTExTdWhzMjBHQnU0SjR1aGN0?=
 =?utf-8?B?L21Mdi8rYkdPSWRxTmZsYlBRS1E4elQxcjdaSGgrMVBHeWV4UnI2aXdLLzN4?=
 =?utf-8?B?RTc2WkwyODloUDFONXF2dXkwaGUwdDhRdHIrSUM4dGZDbTl2WTR4c0NrTWpa?=
 =?utf-8?B?RkVscUJkazFxc2p6WkhzOXdvVU9FR3hCM0FrN1dERWl6cVFBQmdUVW9PVWxS?=
 =?utf-8?B?ZDJqdGpPR1JQakowTDM5eWYxQUkzMXgyZUg0ZW9xNEhXM3JGVHk4anphRWlz?=
 =?utf-8?B?M1VaZHJTYTdxek9yZ3NyaWlYdklJMHd6bUh4ZFZiYzZxaDJ5NU1FSHIzdFQz?=
 =?utf-8?B?ZXExbjJtcmVzV3JRVHpXWU03Rlp0Y3FnbGVlVWZ4OS9UeEkyLzd4TGh1RDhL?=
 =?utf-8?B?RXBVRVoyNU1XdTdIZHdaVStTZDM3YWlqNDRBVE9RbXNUQ3FGZkNuZFNObmxP?=
 =?utf-8?B?OW9pZWFZT2Y1bTk0Ui9DcEZ5ckI4OHp2Vkx4U2psaGNhdklVaTNDdE9BUWxh?=
 =?utf-8?B?K3hJbzFFVzJKS1d6MjBpZ2tLcENWSSsvQlp0bjlmMVozMFpZRDZxZm00V290?=
 =?utf-8?B?TC9ibE5rbUxjWnhaY1JPWW02REMrS0RUWWJLL3JPQlIwV1BXL2p6aWJjMFN2?=
 =?utf-8?B?QmEvSk5TeEtXVThWTmRhZTN6dWFmM0xvUXZjM09lVSszWFlNYnRQdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fcee48-1c67-413f-92b8-08de7a2ca17e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:28:44.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o40+JkgXBf4Yn239gSUgX3gYdhEaIP+cu9XM5J04+kMNfMm6SNGyLREygsa/FS44xs5QLcKA3uB4knmKIfNYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3367
X-Rspamd-Queue-Id: D900320798B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-43623-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Action: no action

On Wed Mar 4, 2026 at 8:07 PM GMT, John Hubbard wrote:
> On 3/4/26 12:06 PM, Gary Guo wrote:
>> On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
>>> Clippy reports:
>>>     warning: consider removing unnecessary double parentheses
>>>       --> rust/kernel/cpufreq.rs:410:60
>>>        |
>>>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), =
policy.cur()));
>>>        |                                                ^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^
>>=20
>> This looks like a false positive, probably due to how our fmt macro work=
s?
>
> Probably, but in any case we need to remain clippy clean, so this
> work-around seems about right, yes?
>
>
> thanks,

Can you try this?

Best,
Gary

-- >8 --

diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
index ce6c7249305a..51988a69af21 100644
--- a/rust/macros/fmt.rs
+++ b/rust/macros/fmt.rs
@@ -2,7 +2,7 @@
=20
 use std::collections::BTreeSet;
=20
-use proc_macro2::{Ident, TokenStream, TokenTree};
+use proc_macro2::{Group, Ident, TokenStream, TokenTree};
 use quote::quote_spanned;
=20
 /// Please see [`crate::fmt`] for documentation.
@@ -69,7 +69,8 @@ pub(crate) fn fmt(input: TokenStream) -> TokenStream {
                     }
                     (None, acc)
                 })();
-                args.extend(quote_spanned!(first_span =3D> #lhs #adapter(&=
(#rhs))));
+                let rhs =3D Group::new(proc_macro2::Delimiter::None, rhs);
+                args.extend(quote_spanned!(first_span =3D> #lhs #adapter(&=
#rhs)));
             }
         };

