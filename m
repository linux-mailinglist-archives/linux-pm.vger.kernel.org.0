Return-Path: <linux-pm+bounces-43628-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPfXB5WgqGmZwAAAu9opvQ
	(envelope-from <linux-pm+bounces-43628-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 22:13:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F14207D76
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B02C300E630
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8F382376;
	Wed,  4 Mar 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="szuR+SgM"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3E35B62D;
	Wed,  4 Mar 2026 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658831; cv=fail; b=AmHqd+iO+gqIPzJyy6f8E+UWfTe1/YhrbVk9WkctKRz9gPBmzpj+LMQAd9txycdDsSnkrXDtrenHeAk1KVXOOS5vISGxnSjpekN/Pqhmoi8TE0QrAziCGSgSGmKkIEBYQ5QsMambRAybGeF3VNiYuJ57UrzFlI8FYxlQmWma4Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658831; c=relaxed/simple;
	bh=zyaz1HpDQ/a3G8XTXR+XfZssCfvaGv9k7gOgaPfgxp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BGFc0Ieyo2Te/mZVKO/RDB5eQ2U4uU5Ls19Oj8kZMe7CdgWDT1OF50UIlhebi7vcBQm1N7AYEBFHUajAuPr72XfAHTRwxp0L4nFSFWKTVmjPSz0iv2mdrI7lSEHKey+bfqyTji5PFSIBHd9hj3oqZllDS744pDNW98FhATt2Bko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=szuR+SgM; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg/ZyG5pzKvb9vxMop7G3dEOKz2E3/AWN6hEK8Cq8pp103aGE0+PEzOOmsoahKnlwp/iiGLHBmWRNq44Bbu5eqbqFuD61pndaeJiIBYFaa3bZk/f0cnBK4HD3o03wf1dAt+9bGqdNHLWLs8SX4EEI2I+F8dFnRDj/oYViIk+JL5V6TDDTdSk649+wyulGtwUNWmRx4OIFizqyyArn0iMALdU8fi66fOzTURiFHN6hHAmkwViQyPb9cwdG0aCO3P8dYWTEvuLaJpVwmC6sKOlwr0hcmZuniS4OOUnvzFoRfk1yNIIhsoUsXF94gXNjr6YcBerZVgFvUXri/zG406SRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPws7ymudu16qJshknBUJq35HcxsuY3OrVjlLr3+XJM=;
 b=LjL9ztE2qS15ODT0c/Pif4g5pfa9HHRzN6nVTNcHpOkSWrMJiSEPCge2asSC5H8y/e6PjfMu5krV35+enSsneCVkbbBCcAqawfNglARuIkyzHjQRqtpFovtc0O1Ou0+WZShrESiEBwpKf73mGQSWF6eCClHiZe0T2OHhx2RaIIZA2WsSSV0BmGU+N3vtGHgx6JhQqRdF7GfSj7HQASkMp58AeAu3YiZl9Ah6cBRRglIOMIMV9yY8bS/7/EkgNitNko2yx5zREJVuVaEkfOMyCMXL6OvtqQGER/tP8oHoNjFATiI++E9YC8EnaDfwR9U/aZ/msV1p/sxj9snJ61zwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPws7ymudu16qJshknBUJq35HcxsuY3OrVjlLr3+XJM=;
 b=szuR+SgMdJiPJpwezkwP84QCedlzI+thUnic6Tb0tsqbbhr9ubx7apRHXq9KJyDaRRcfGcACNlervCFvKYnR/5n4oQI2/5l8e8iWcsE0c316jUzciXuldYPm/Ne3HHuOJ9JmmYhRnVm1tTBt6FFfaifxDXxzkcS/uCYMUF1y2wIkWY62ke0mF+gaBWFs1qstpVzqj9Rb02e/DWLEaCqLI1S7HaQl4Jrq6atrmTggjW2DxG2arlrVXZi9GzyVU00vd/r073rOfIm/4bm1cLd/OhpKzrk5DyfGtNUMSYeppNUCxrhAqaPDklgYbcMI5yMPwEcXcQ16zzSpXwyPXOIAgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Wed, 4 Mar
 2026 21:13:46 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 21:13:45 +0000
Message-ID: <0c4ae9ef-b803-4ead-a2c3-d5dc37592d5e@nvidia.com>
Date: Wed, 4 Mar 2026 13:13:43 -0800
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
 <DGUAE329P4FH.3QPNCVLNA99MC@garyguo.net>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DGUAE329P4FH.3QPNCVLNA99MC@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8c88b2-f7df-4005-ed94-08de7a32eb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	KStr2k6G0pCUwWT+Njsu3JeS1hvgjM1ObT/2xMMF1Mc0UYTMei6itBTJjUH2rJcMTub4foYFGl0mFxd9j5sVyOjhOyc47A/RXTdgof+9QQtclS2rCHoRpHh5QcRrqI6bb5d2HraxX4O1DEeGSk1gfgA0oIkHaNqpxUC4vWuoVCkYrXYUpJwSDLtMHRishpVAkz3AjsQZbWck21Iz9tosX8Svf+YmQ3So/0UqwZ6bgBhgrLsK+83b5rj3ZmdnbiAlr0aOWeaNWE7pSJkKZxid3p5wO/EGNFbwmvqMHFbhzNEX+YIl0Vt8Vnz6BIYq+qrCjUtqvzelSj9ArYClxJjyBJS3fDC1yhYpDlcEmxrZqHAI7mJ8PeJkmk9/wgIzLWYbU7xyXkv6iF2N+utt7WfDYOKG2bUGgPWF9oKt//v/FthXz8m4WOOitThHwGD/aTB1uuNu4jJAnlarGaes9KBf78vQliL9oi/qIssaI6UVnnBoqegEUREOIdDQ9iUaQunXpOUuad98ciErJtTHF8zt5e8oWmBVYqNaq/rESPrDbP/3mNUmRHacRjSfqBL8JeXOZtiUyv2zfByGK4TLMpgiJRKUtQ8nHMtm23EGVsbj0RIe/PdyFtf2ZFDFd5PYMM8xkrQZKLifilV7HXZIeCL2+46G6JaVzho0WajuEhWthOYs0Gu7omHef5Mz6xV/1yuAWgKIbuRkfnURjXDwUIhGqQr0vblogocuUGS9brcEDyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGppVDdhcWtrYktkcTJYNVZYa1o4Uk44ZlJxQVMrZGh0dFd5clhiMkJlbzk0?=
 =?utf-8?B?RXRNZTB4S3pWalIrNDAxVjNZY3ZpK1BBcTErcmlQd2dWek5qRzhCaTVEaWVG?=
 =?utf-8?B?UkRtN3lGREltc25Wa0FNcDdiSWE5RnM2V3R4OC9FYmMzT2V4NHNQWXJJVDZC?=
 =?utf-8?B?eWltZ0NLUUFSZXpvMC9OMWNwV0x0dGJCLy9pY3lnU2ZUemhBVmVEWk5BRW5N?=
 =?utf-8?B?QzJxMHVXTjJ3R0dzOHRzeGNpNXJiQ1g4KzF3Rkx5U1Z3UnVKY2xTRjA4TVd6?=
 =?utf-8?B?OFNzK1hHNmY4SGpHcjJ6b25JeVN4eTdXOW1jSGFQaC85V3dYZkJzSko5OXd6?=
 =?utf-8?B?bjVHL1hIVnJvNWRNTDViSjZUczV5TmdnRzdzcks4bzVOZjNRY1lLQUZPVmxq?=
 =?utf-8?B?TmdFcllMYjVJRXZ4bzlsTEhCaGtwbWhxWSs4ZVB0czFuOVcxc2QyV2RVMTRY?=
 =?utf-8?B?eDQyeEJ0UzY3MDNzeTJKMHlIVGM1b2psTkxDaTViTG95K0YvK0FiM05DZGJ2?=
 =?utf-8?B?WkJSV1dXRkRoLzNubzJVU1dYYUcrcHNYQkhyQ09NR3pHTUNtc2QvL3BOR0VH?=
 =?utf-8?B?aW01bHRkTUdlN0N4TGpwQ1MvWExmNCtyVUl2NEtjTjNrZGlXbmVMUjJNT2RT?=
 =?utf-8?B?TU1kbG5SY1ozSitET1J6V3NpR2hjR0lZUTc4ejFobnh6RXFKd2kyZ3FhQng5?=
 =?utf-8?B?L3NmdWhnN3JKYkhmbGFCTHFHN2ZKeTJBbHpqRTB1b3ExNjdGKy9qazhGUU9J?=
 =?utf-8?B?ZW9qVVB0QzlaRTVPL0UwZER6bitCeVBVSjVkL0lRaWQvQXAyNFhvaWl5Y3BY?=
 =?utf-8?B?N3NRdXZ4ZnJqL0E5SWlXcEFrOTJqbDhOWWt1bVhKK3czeXRRSExidWxGQ0Jp?=
 =?utf-8?B?bmVqOStZb01uUWF2aGhpcEhBRk1sQTY5VGxieFFTWEN0MUg4UEwwMGl0SGZP?=
 =?utf-8?B?d09LSGV3M1dpNGlyYXlpRmpSS2VxSW9mRmx6YWNaZnFwM002SEdUTTRLd3du?=
 =?utf-8?B?MDZ1MGNUb1ZudytZZngycVlQSmt6cm1FQWs4MTMxUmwvZStnUnlVMzZIUnYr?=
 =?utf-8?B?amZ6cGZmbkxURHZ5dW1WSy9nNm1IcThzOWZuSkd2bzcyKzlzcllFcWVQTVJy?=
 =?utf-8?B?T0MvQWhVenVJOUh6bmRORFpPS2RvelRsalpTRFlTak1QaWxabWJwb2pEVURG?=
 =?utf-8?B?UHZaempoaHVwSkpQSVBNRC83K3R3V08zSHYwb2VVSk5zZCszSzZia3psNGVF?=
 =?utf-8?B?b1BzMHJsOWI1N28zYTFkYkY5b3JaRnFNU05vK25maHpNMkJkSUFPMVpGNzVl?=
 =?utf-8?B?blVsWTFWVkdtemxsbWtTV091eVhaeHUwTmlpcGZpNWM5MDdVMGNFRmJxUm8z?=
 =?utf-8?B?bU1Oa3dIWkhNUVBEMGNHdXUvNWJmUkZTSEx5eGlKUDU3MFNNTXh4dWJqRHZi?=
 =?utf-8?B?MjNZeGhxNkJEcXBpN0Y3dXMvK3BVMlRYaW9vd3Q4eFljbjgxdG9ocGRpLzdW?=
 =?utf-8?B?SzhLazR2RURpM2JHTERiSS9FeGovbGNHeGdPNkxqNHU5TW1rZHZNMUdJZGNj?=
 =?utf-8?B?c1BTNjZhYlRDSTJxWndpOTZaUE50aUYrZngySHErOVczUGw2WTVtblg3bXJM?=
 =?utf-8?B?Y2hIR0M2enNtcDhPS0Y4QTU5aGNSb1YydnljaXlTOWxJOVFTaUZoYWYwSDZm?=
 =?utf-8?B?SlJ6V1ZJdjUwOUFVaTVuMWlob3dVYzVOL0VmdW9ldUZVdnhyclhVVlkwTGFU?=
 =?utf-8?B?cythME1mMEowMTcwREhEalJPK3NhZ2pWZGpLT2dFSUgyYU5xM2tvRThzVGFD?=
 =?utf-8?B?QnZXM1dsM0RMam5FZHhCT2prYktVZlQ4eVpwdFpBQTNhVkF4M09jOG5pLzd1?=
 =?utf-8?B?WmpZZVpMbzZ5aHFOY1lPZHk2RjlnT2VZY1JEeGZVOGFPck9ydDVNS0tpMkgv?=
 =?utf-8?B?THdrRS9IdzJVS3VTeWNpemwzN1dZVzFDWDFtQkZxRjdXQU9kcWFEZ1NLcSt3?=
 =?utf-8?B?M1FGTXc3UXoyR0FvODdBdGVJdDMwc08rSS9zSUl6c1BITlhVS3pTbXVRalBs?=
 =?utf-8?B?T3VWVU9TNkh4U1EyWEt5SklGSU9lMFlvMTBSVzBTRENrKzdUWFVoKzl1NUln?=
 =?utf-8?B?U2Y3K1ZVVkp4OUxpdW9iM2x0RDZGaU54QS9VYmpBK0NTNVMrSkF0WGJTNEQz?=
 =?utf-8?B?amJMZ09zNGxXWHAxdTNyYVBva3NQVy9WVnl3anBVN2x3aVBOZllqTC9vY2h2?=
 =?utf-8?B?NEtDcGR2UVB4dVQyS2hQUEMzMUs1ZWk5Zm9IQk9CK1F3ekNzL2dmZXk4dUlk?=
 =?utf-8?B?Q2Qyd0UxeURDQXdoVDJSaUVIdlNaME5MQ0FvelU5N0Ewc0pHeHpyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8c88b2-f7df-4005-ed94-08de7a32eb5f
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 21:13:45.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6hM+J6XqJ8B1AMpXs2L5v4SQ5yXdeS9yPqbcIosgv0e2tn9Vixx9ghvbi7acBm6htFkmFR4FI7KOidIfBQHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
X-Rspamd-Queue-Id: 87F14207D76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43628-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:email]
X-Rspamd-Action: no action

On 3/4/26 12:39 PM, Gary Guo wrote:
...
> Actually `Delimiter::None` isn't fully fixed [1], so perhaps let's done use this
> approach.
> 
> Injecting a `#[allow(clippy::double_parens)]` would probably a better approach
> today.
> 

OK, so that gets us here:

commit 924f411d6cd0cc4d702f197566f5e701915d5760 (HEAD -> fix-clippy-double-parens-v2)
Author: John Hubbard <jhubbard@nvidia.com>
Date:   Wed Mar 4 13:07:43 2026 -0800

    scripts/rustdoc_test_gen.rs: suppress clippy::double_parens in doctests
    
    The fmt! proc macro wraps each format argument like &(arg). Writing a
    tuple argument such as (a, b) produces &((a, b)) after expansion.
    Clippy flags that as double parens, but the user has no way to avoid
    it because the outer parens come from the macro template.
    
    Add clippy::double_parens to the existing #![allow(...)] in the
    generated doctest wrapper block. This only covers doctests, but no
    non-doctest code in the tree currently passes a tuple to a printing
    macro.
    
    Suggested-by: Gary Guo <gary@garyguo.net>
    Signed-off-by: John Hubbard <jhubbard@nvidia.com>

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index d61a77219a8c..e9ca56a3b73d 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -208,7 +208,7 @@ macro_rules! assert_eq {{
     #[allow(unused)]
     static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 2;
     {{
-        #![allow(unreachable_pub, clippy::disallowed_names)]
+        #![allow(unreachable_pub, clippy::disallowed_names, clippy::double_parens)]
         {body}
         main();
     }}


thanks,
-- 
John Hubbard


