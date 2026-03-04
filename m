Return-Path: <linux-pm+bounces-43626-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCzpH4WXqGkLvwAAu9opvQ
	(envelope-from <linux-pm+bounces-43626-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:35:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA25B207A28
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940C83029245
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62D382F06;
	Wed,  4 Mar 2026 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uOcxva+R"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF918364E9E;
	Wed,  4 Mar 2026 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656467; cv=fail; b=XrTtCzM9xLDryR4eiugnbyzV8QALHIkdrt+ryCMIvaQWaAUOeZdS13vLZ84XeTOWEh9genIyua0MFztLTQa04jIQB/cllYvLQS4Ej4ZV+oHbSt0js+qULHkUepwcu2+GcyPaOz1mKooDq3dEsYd9QBDpUOPbLqDGpHbf18GpNeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656467; c=relaxed/simple;
	bh=2q333LdLEOBTSXzEUrmowgzBzlJw8cmOAyUzfeJTxzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oeNw0igle2TDksfjlsww4It6aGxk2hxhJfKFKFy/nRrCeeDc6MrZeb3DTfHCrUSa9+S5W1KnNCNMzV9iAXnHG/h4h3PGgNaWNQ2+Z4xroxFWMFay4sZ5Usrv4VqoBcZJQBOuWCkt83sweiBguS1hnNoa1t11hrq/V9zrOTep91k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uOcxva+R; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+vIpyDY4JUTcqdYRo7r4+SG+f7XsE1IYW4WVoD7lSEFqU0nI531Q+sLAnuAgJMCXCV9SK0O9gKUvyEVudj8pZ+7RHhJJxDa2fuxHVtDzUkZzC6GPr9wm3PbCsBlP6FnyFvNZQptQh6OxnBPs+/KeHNzA/JfQG+L2vCiMPhspxS1uk46ayh3LRq3eIrcEmn1LN0jLNodlQyFKfz+tN/O0ySiDYEncVWQW8ev8bDuNc8ONlneBU5fBEmcyOCfECPvUtfUvtEh+mCzx5m/Dc7t5R5AFuiRknuyDv6Ttp0KwL5pGs2YBfnhqNVFWUWN4yWqWgxV3617KEHGnJpXjAHP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gFRWQu1nFALuPEDGXhVr0PGLt6buqswPyFaQB/8N8s=;
 b=uGWCVFCw6o6Dv9hrsOsPKAfpbJvZLv0rfIXE04SGMIOae6zFMKRb+b1wJrW9TfNyDcEwOhqchkg9A4ZGC/eddrZ61zeMQu9oDxFXs+S1Pf1o+u1bJBsmLBkLV16DdJkigWj0/cfiWiMs9fxgfy+QVxavx6wdjy1tnp9H8ORjsRsivdfiIUDkxpqAtkww7HkPsshwQTyEskQ22MwaYOtZv7Mq8choqADyMt3Gh1SDetMJeA+EcQkKRCF1HKPjBxqwo1Bwk1JK0h1M7yXyuWQaokI0W82WTVQ8rAWXM0Rbh2JaNCbMk5hUDHl+4+SrXtXeTjteRCSUC/14FRgYlnX74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gFRWQu1nFALuPEDGXhVr0PGLt6buqswPyFaQB/8N8s=;
 b=uOcxva+RWOoMMcBRybekqBWLLpqsvYWILmZWMKva7aizHbtgRIOhJMu/OOPMSWfKDeX5691uwoIkN/mzx28v/xadWrpO1ohUBf8kEdEDci/Rridqk7tB7pW1ibnfR60k6ODESSfrtMTlGb5qZpw7Dkz21xvD88tiJQQv4ybUvsA5wPaTNdch/sSktjVlxgDtuLOlA3PW0rPdoG9I3LxEdMk+Zxz7oT/5IdZdAs75nT/9Pv8wlwMxHl+CVwS2zqwPinQs2f59GZ6gxHvFWbW7q89yFew70m5GCfBQwlAkKez1lziNV8I5kowZejVBJ7L0RUrZpKmFteNMacaF/x4dug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Wed, 4 Mar 2026 20:34:19 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:34:19 +0000
Message-ID: <aa0ab485-3289-4238-b730-5ea2d6d5a06e@nvidia.com>
Date: Wed, 4 Mar 2026 12:34:17 -0800
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
 <DGUA6UMYDGG9.1AA0FD146PS3K@garyguo.net>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DGUA6UMYDGG9.1AA0FD146PS3K@garyguo.net>
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
X-MS-Office365-Filtering-Correlation-Id: fa921e4f-f599-4444-9016-08de7a2d692b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	IOhkArrnP9AyOv54pwCDnF/nXPuFfgq+TamV4PSsAzBlEvRhW/1eZee9ikmYhhxr7Uc9EMeiVfIuxe597+XP4lKG3qi/l+94fUZ8iWfToTK/a1HbIMnEaVVtSBuuMj75CS9XFC1IV+Jcgg/riESxOKT+tX9dV8sUq0Sp7LA1lNkJfymOEc/owZ+yNT/mzgE/qjFHnvXNlh/VQzOZlzptleUZWGeR29GFwzIP0zZj5yAVrzDfwNd3EK2MZ0k6Rmn/XReXL+RldGbka3A9F5rMfr/sc74QsR9xDjD48gzkOvzHx9Do3fOnwRs1EYm3O88BTZrb8RE/FH6r6N7XQGH6rtSRp4AOENnvNGzVjVgRllFFbwp0deK7zeR94Nhd8VSzYUnsl2DVK9jFXo0EWVN78uJPDKBp8t2mU8fgbyhMP8M90WdzSON8QgEgSJw7jqjiR7t6jqNHny1nXCu2FSPn8epRCA7TlUaJ8/2/JLDK8XigHchgZcDKiO++oAXMRziT5lrqQmqSGkP35irbMvd0ZtiF3f188i37+x64XwLQue0IMxWlewKs0bsdzH4YeWyZ//WrQJJpBeaQCrDExlYdkhNB0nbOG/RgGXjmWNzir6K/r2xvPbYkq6+rqstAeddY2xXwUPat3798JHO4v50CaLw5ZG89iYMa9hQakZpBKqaAiBBc7bz5wI6kNMSQsbIFPRl8wiFhGoJBOdtpq3AagX7zqi07BRH1avsHT9pX63E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rnh1Wm4za0tCMC9hYVNzbUxkV1kzakVDdXFpZ1lIaGwwZVUrVmJid2dmNy9p?=
 =?utf-8?B?WmNNc2QrQnhxRGRUVzJoRjZKTnd5T3ZnME1pcHJDR3dYeENUYTd0M1Y4czVj?=
 =?utf-8?B?SEk5bTZMRjMwa01BaldXaEkvK2p3amlnMlZsczdGbW93NDNYNW85SjM5QlZq?=
 =?utf-8?B?eVM5OXJVeEpGai9UVktIek9pUVFRYjBiM213S2FEVm5OcUc2Smc0VSt4bmg3?=
 =?utf-8?B?Q2tBRjE2cm5VTG5MaVZGcjhjME9uZHVUS2JxL29iNkU2SzVkcHpWSnVwbzNO?=
 =?utf-8?B?WVNUNnlmb3VuSDZIeUF5aXFKWnNKWTZ4dUcrMXM0RTV6ZGQ1N21yZHFPVlVV?=
 =?utf-8?B?ZDZQMmhHNndjbWRFaGtITjgvcGVVSi9pdlM0YjR2TXlWaGVxYi84WkhoTWJq?=
 =?utf-8?B?aFpqc3lQdG1uMGNaNFVIOGxsWFh6UUZlL1VEKzlGZDM3V3p2c3liUTZzNkIv?=
 =?utf-8?B?M0lDUnJROGlPdVdMRElOVUV4NEV1ejc5NFhhREhzOENpa3pMR0JOYjBHaTJS?=
 =?utf-8?B?cHNpRE1vY0V3L20rV29qS2xHM2NaekNLTUhqRTBIVEN3V1JvUUErSTdDOTFh?=
 =?utf-8?B?alNXZTYrOFRGR09lTGxZbUxjV0V5ajdrb3prVDVKOVpkN0Z1MzgwZDVKWm5L?=
 =?utf-8?B?NStXN1d1YWY3eTJ1UjU0Q2hqelI0c256T1BEcFl3MTFPU2pQQlpTK2xUS0xs?=
 =?utf-8?B?bjhLQTQrNFl1S0lHdHlzcVBZSWQzcVhOY2M3NkNDc2tnWjM3d0gxUlBLMGVQ?=
 =?utf-8?B?bE1WWE5pSVBCc0JKN2lKRGJDZ1hUdUlpSnBMODdqWjM3bGl3eHhZZU5USDRl?=
 =?utf-8?B?anVsZnBHZ1JGRnI5bHFJaUlQc2l3QXFMbi81RG9CWlFUZUwzL0lZTHc4Q2Nv?=
 =?utf-8?B?N09IaWJFZUd4ZHU1VFBobU8zMmpTN3c1RE5rWGYyTDkrT0h4dlBlMVROMkJP?=
 =?utf-8?B?ejNXOVBwN1ZKcUg5TjZCcEcxTHRBVnVKUTYzdURsSWptUm1PRytpeStJZVRk?=
 =?utf-8?B?VzRBQUFYVS9PYjZrR2FHbHJoS0hjb2ZhaitGbWNqeiszWlpLNG5FN0dKQzg1?=
 =?utf-8?B?dS94OTRJVklJcmlNVUlwUlI1bElBQ0VSc0hHL1FZY0Zmem9sUlp5cVVGZmEy?=
 =?utf-8?B?eHpkaU5hUmZjR2Ric043czkwVGt5SyttRnZQMmN0enlkL2dYMis1VXpNdUpa?=
 =?utf-8?B?ZzZJdVBOaVZPZ3hHOUZXb1F1SzZ3NVYvSWdCMktTdktBK014dGdraW9RdExt?=
 =?utf-8?B?ZGQ4SUdMR0Z3Z0tiM0NGeXRlbDBOYzZUZTU0alZ6Q09IRHlhTHlBL3hsSkF1?=
 =?utf-8?B?dzFhS3NsMWY1TXZIbmN1ZFFIVTN1dWpkUnRkNUFrZU1EL3pOUUZvQnFycXE2?=
 =?utf-8?B?d1RaUUduVHRPM0JlT0k3VUhQUy9IUFdabnlLYldhTnpWU093OVNhOWJYTjF3?=
 =?utf-8?B?c1FaYWplZllQN1Nxd0YycXA0RHFOdERmdnFRZy9KeWZ3S3FMUUFpaXVncnJm?=
 =?utf-8?B?TjZLRVYza2hEZGorai9KVGd3ZlBscWJyTWgrSFpRVGs3SmJwVDdtWVdZbis2?=
 =?utf-8?B?MDlNSkRBK0swOXVCKzRWdlc2UjBNcFBqdHI1MW1JaGdhNnFreDcwTVg5V2Z0?=
 =?utf-8?B?cys0Kyt5dDM4a0doUW9zLytlTkU2a0FHMks1V240S05ZTnRkclhONkVEQ1VO?=
 =?utf-8?B?ZWlERFk1czFvVEczS0RxNnBSejV4MWRpVnpkL2QrMVpZNUFVOWJjczRVdkdW?=
 =?utf-8?B?NHFFRG5CY2Z1a1B5cE15elUvcnl4TGdKei9KZmJnalpVMFQ0VFgrYnB0em5Y?=
 =?utf-8?B?d0NoVHM0Y0ltQ0xsNTdXMm44TVJpbTBSWWJUUHcycWpZeVFMQ0dIdEFKUU5k?=
 =?utf-8?B?U0gxeFhwdTdRMzlaQUpsR2pqS2VERXJod3NKSjZodmFOUlhNTllhSkFNVlpN?=
 =?utf-8?B?RXpDc0VPT0Y2WHBqU0x2cmhyeVZaZitIcmtCZ3RCdTJNRWdwWG41UzJ6RjQ5?=
 =?utf-8?B?V1g3WGppbkxhdTVMb2hBTGlzdkJHa1IweUk2SnZUV25lOGRMYVJuOHNwQith?=
 =?utf-8?B?NXJLS3NPcHA0Z3lHd0N1ZDFKL0FIQXRYMjJ3V3grTFM0YTBCUGRnSDY5bWhr?=
 =?utf-8?B?RGZjdkpOeUFyZXg0V2NiWEpVekFmNTh4ajdLL0QwVTFvdGI3dEV0Wjc3WGhU?=
 =?utf-8?B?TTJxRE1OUDNsOXpFa0YvTFRMdVRvSHRDdURIdWhYSFJVSmEzV244SUgyTGJI?=
 =?utf-8?B?VFFlL0FoVXNINTZ5dTNqT05qYlRRc1ZFSGMxdXQzZVo1YVJrR25CMk5ZM1hR?=
 =?utf-8?B?a1JHdWV5UU54T1NHd2Zyc0tFSTh0MVFRV1lXYUZ5RFY4N0t1ZjdsZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa921e4f-f599-4444-9016-08de7a2d692b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:34:19.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bknISWpITnisMpKHtMLOz6S1XfsA3pbmy4jlRA7DTN03ymP9sGbgaNyhz0RvC13//fQFvbimQAuL8PwDRMVkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
X-Rspamd-Queue-Id: EA25B207A28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43626-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On 3/4/26 12:30 PM, Gary Guo wrote:
> On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
>> Clippy reports:
>>     warning: consider removing unnecessary double parentheses
>>       --> rust/kernel/cpufreq.rs:410:60
>>        |
>>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
>>        |                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
> 
> This looks like a Clippy bug that's fixed in latest Clippy:
> 
> https://github.com/rust-lang/rust-clippy/pull/15939
> 

Looks like it, yes. I'm using the 1.78 toolchain because it is
the oldest and we are supposed to verify that builds work with
the oldest:

<blueforge> linux-github (fix-clippy-double-parens-v2)$ clippy-driver --version
clippy 0.1.78 (9b00956 2024-04-29)

<blueforge> linux-github (fix-clippy-double-parens-v2)$ rustup which clippy-driver
/home/jhubbard/.rustup/toolchains/1.78.0-x86_64-unknown-linux-gnu/bin/clippy-driver

I'm not sure if this means we should workaround the problem or not.

thanks,
-- 
John Hubbard


