Return-Path: <linux-pm+bounces-43622-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA2GGx+RqGkLvwAAu9opvQ
	(envelope-from <linux-pm+bounces-43622-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:07:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B32076D5
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7249530288FA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E9382284;
	Wed,  4 Mar 2026 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9u7ENez"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2D37F725;
	Wed,  4 Mar 2026 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654856; cv=fail; b=AArTSkq40Tr8v/7p1IZdniIjKnKCo9E1Mrxonk5z3AzujL85H+asNsqTcHkxin0R082jo+FVQgtDyZRsYTDhh/Pqv1aRGT1Rzf4XokRSA15bqwYQXyD/mSlzgm+vgEU7Da/6LNl/vx56zwzD87z/keG0/8P2WWPShfiNHuFwsbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654856; c=relaxed/simple;
	bh=xukUkS3b+wwyPGf8rdvOfZ/MFywLLroo15RjsPdOFgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uODM/GRHEYWCNCpigUV0uwDHeVhpOahSAzst0Hm8/MkjrqbK2564mqo/0qpZurYQMMiiIGLId2TVZ4n5oicEtmPOls0TrkYYw5dPW6pzfXRQJrbL8jXdhvz2Nnm4d57lwaIIlUpRFfqAX8cCzWkWJi6kQd535yUeQTSNCqI6uBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U9u7ENez; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+J/QIgCH/pj6asFYMfnKg/FhxxPqd9cu6sPVyLUT/1MkgvVpm0o54bFYuNYJyNgMXz6G5guaOXr3u80/qUJltHsQvqbTmPlYHSV4k1hLNp1tLsLuf3Oie703wZPnPLuHY9NxcxU3GhrOxlgfrNToZrFKR3YQCpZqYlgEIBDaSnwtNiZIZnlcphguOrBZ66i+0k8654JH5zO58cqOsZSXsIUsaFa3ldXn+B+0ox9VbVWPzmAWVblXJDZJN7AsfJSRK/TlvHKmVbsz4EoJhmMi/xzBQG9w1ke4hKauAxQ5+iqKr5r6fPECLvy8BPPZegY5FnUF1JtfOa6EE74PoN+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhvy0KgVKu78ALdHp1ofYPn0RKjNb6cdfZDNAp30Qkw=;
 b=oupc8a74emieVYycMG0VzDxRdMAo6OCt3gPHjjbLPiDHaXsa3HmDPCG65RBsCvS5n1apK87y2UYNqnk9Zj3OGv14nRx9YPMJHtWD7rSkF+de5Rg6e7/H/oT4lBmfLEvlKtgbJKsr9APJtqnwQ3YGTKa3Tg6gPAajnhh2A6jZFLyQFwHQWon4oSt6rUU31SD/ES3s81aWfl8dIei33W6PuX+4Mz/kj3x5NumQVqRd2XYbl7GZkLXjRz9Yhnm0+EJRFTnbXMVzDNlULCWZCPau1zM4QubA0jyCo9a0WhB/YnYtOZnk4888MTEKAnzlmNTAXkMvZZf0B1ckWcbg4HXqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhvy0KgVKu78ALdHp1ofYPn0RKjNb6cdfZDNAp30Qkw=;
 b=U9u7ENezzfqV3PpqLhHdoOEBRJ5VSFpPHDxdD1vBD2RVxVRIICX3HA/Px6tSCJL/iUKsrOgbFVyg0+JR+ya2vu9svlvqdzpebPnp1fVT35VUhmqGNdQtjhrJRCTYh7CqxJAyvLQ2cHMoBKRudtspoiNPNximsBsnJbScoLzXV/zImnaZ115PRTFE0xsg4+2Dm+JA0gyNYLwnyrZO7cYXjM07baXsZoM1xZBJdt6ko81Bs3KldSWrLnGZV+poCuf9LB0UEZmlyD2w0LNLrsNA5tu4oGwMuZvIfbRX0ws6rfHEdbvpxzrn69g3tAfyjJ1IttUOhU1HP0CtQ8nPp4pLQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Wed, 4 Mar 2026 20:07:31 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:07:31 +0000
Message-ID: <ea3d6134-22ce-4715-be75-e6d41568c7eb@nvidia.com>
Date: Wed, 4 Mar 2026 12:07:29 -0800
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
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DGU9O3HEY7CN.3OBR26YV3AHGT@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e44cfa7-7e30-4ea3-00fe-08de7a29aae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	C19ZgSCPtWAtcD3xx3v530tymbjBK16eofaCVpNXH1+nSGwPHTq9mj1WoiM5FiKXHvza+87GX487lmsvktpfbbvvjKmsmF0Pi6rENy7PwJuOBikZa+mNFvTu6wBLF8jEprigIDqH1/D9hsVzzrIXBNtgHn42luFcs1g+7S4/4Z636s7ou+rkYQQhS5C5hIbbwfaQ+Qze8mbpL83F7auLsS1ZOUzB6y60VjIy7KXAgsRBaIPq2MsUQreImL4+JikzBnGboGNlSL6veqS41T9i6wHLcKt+GqGJJ4qvaqmq8s2CfnD6pPnqXiUjSvpUctoWUE4p/IVZ6+0uJLx/RF9oxYrWg9iqNv53QnwmM7Fil8gfa1N0Hslrd+CPfQrpSQH4zwWBBpd59p8C2VDyaW1jxGkmIMI07E25mgLibt6M0HShA6ooeavNCl70DPnCMgbJvLBPRNv3bdFfk8BdjhVXZW9Eb/7c4WzmEyqi6p0pSoCcgFK/KNOGlDDgcrYluNLUSzY+FnhjtA1NdZoaQw1dbPZ29qqPZN0fFrZLz/FtaBXCJPf6aE3BbyVxhvudtE2Tq9vLjTaqklXxU6ZfhtcehkvgfBGFOwLVyW5ZLdXSHHx/Ts590u1WsTuOad1zLOp2jBjr8c+MDRofl6JiFtvQR/HRqYzNU3vQRayJBL1viYmgEn+Xt6uXkwYWDK0PnhG3ugmpjE15Rcb29zwEBrg0Jx6o2Zv5RDN8TbsBxDHchlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk43T0lxVFZ1MVBTTGw1TUpBMmYzdUwzaU83VTY0MUM2RGV5RlFBMnRQSHFF?=
 =?utf-8?B?cnpDcHBLd3FocnY3b2tvNDFxbWVIU3pSUlN5U0R0TkM2cTF1TEd2cXJrSmpF?=
 =?utf-8?B?anV0VzI5ejN4aVNIMXE3ZkpyMEE2NU5BZTJYbUR1RWxDOFNRWXJXT3NZaXN3?=
 =?utf-8?B?THlBNC9uMVpuTU03L1JmUXdBenNxQVRFT3FHUGkzZWFweTc5aXd2M0duK3JP?=
 =?utf-8?B?anFCbmZyQW8xdEQ4b255WHdPOXhTd1NZWWRMVFBPV2lvejlndFh0TVVWV2ds?=
 =?utf-8?B?NWRTTDdQOHFtVFc3MndWM2YrOUc3VjhkVDI0VlNGOUp4ZEY5Z04xQlNicEpo?=
 =?utf-8?B?a2dDdWdISUdMcnF4SnRaOVV3WDUvNzYvRnYvVGVqcVFNOFd6OU45b2F4RFU3?=
 =?utf-8?B?NXdaVCtwK3dzRDhNQ21xcUJ6a0VKSG1SR2gzR0RwWjE1K3VLZjEya0Y0ZkxM?=
 =?utf-8?B?MHhmNTlSVEdKbEJYV3I3K1BmOXFqVTBDYUxRUHp6cTEzaVh1cFZ3RzV3cDBT?=
 =?utf-8?B?ZFo0ZXVveGVZMlVPQU1TT2ZHRVJkV3JKRmFDcUx3TER2V2YvT1lNQk13U0Fq?=
 =?utf-8?B?aHRVUDNoSVNDOUFqQ2luenRjVWgwZWY5bU5pYzVFd2IrSldOdzhPOUx5OXh5?=
 =?utf-8?B?dmZqMmsvWlppNlEyenBtK01ncmxXUmd0UnlLRzNyM2E5dnRrV2t4cUFDbDgx?=
 =?utf-8?B?Z05QWElURHJOUmlhd1hsRFhzMjJUUTMxckpTK2pjOWh4QUswVXJ1SHRkUzFy?=
 =?utf-8?B?cytzdnR3eURHb3NaYzVUUy96aS9YRW4zYTJGV2VLNE55eUh6cWs0YWFhSlNL?=
 =?utf-8?B?NU1mMDd5RVdVNHY0U2J0OUluR1N2UHEveWlMZFJUUHlnVFdtYW9WaDd1NFhO?=
 =?utf-8?B?Yk1kVDJySmtWWGdYNzhMOWF3K0hob3MzS0RsOWVZbTk2L2YxbytrRmZNVWJs?=
 =?utf-8?B?bW1VRDRXRkYwczJlSDdORXY0eTVpWmxNUmNVS2YrY08zNW1ydUczQzJ1bjlk?=
 =?utf-8?B?NlM1SDQ4dy9qVzJ1R2ZXTnNJcUFKSlhkUXROOUtwRnRkNGY0eXpaUytpVFZG?=
 =?utf-8?B?QVpTNmdqUmpZcTM0ZWk3N0tpSkZhUDJTekRwNVROeW1wTHNtcDdNYXRJMUYy?=
 =?utf-8?B?UXNhTElhQnZ6Ri9QeEtoZnNkUzhHWlNZcTZoYS9lc0ZtdlhiSTdFVldqaXdn?=
 =?utf-8?B?ZzA2MTB2dVBJR0RsMEpvK2VYb2hLTkRXbEZMdlBTalhodTg2NnM2akpXbW1K?=
 =?utf-8?B?TVBQWEVKRVFlZk9IeE5VNUFKK1RiV1grT3c3OHI2L1pJODYxOFdYRVREOURx?=
 =?utf-8?B?ZXBvTUFYeXYyTldjVUtEcHBTTFEweEZhc2NQZ2l1Qm9iaEZVUXJLM0NWL0Nn?=
 =?utf-8?B?eDVlVnNDSGFsYnY5R1FTL3hxeHVuN01SM0k2NXJmc3Z0cWNZaitYNHB4aVlU?=
 =?utf-8?B?czNkUG9VdDZMeFVXVnI3NXpqUXR5QlNsQ1RJT21LN2R5K0g0U0RESFNtSzEy?=
 =?utf-8?B?U0J3eitpS0N0WEt6NE4wSnlnQng2aGVvaTFIZktUaGpWb1Vlb3JuTW04Y1E4?=
 =?utf-8?B?dTJNeEhuS0JjK2trUUJCa01aRnRSYXRaalJJc2NBN0o0N1lrM3NCNnBZR25q?=
 =?utf-8?B?NWs3Q2I5NXl2aHZlUU55d2VLV24rMm4yNHVlOFc1SlFhaEVBWkFETkJHVnBa?=
 =?utf-8?B?QTQvVWQxOVhMSGE2Z211K3N0VnJmTkI2TkRqanhiR05ESmpobDNQS2lIN0Fv?=
 =?utf-8?B?dlpVRHI3Wm9hbmdnU0hnVFlkQkovSlJJeDQ2TnpoMjBGQVZjU3FyY2RaZm5Y?=
 =?utf-8?B?c0E2RkxKVUtaSXI2SGMwT2FsRTY5SVZtWEduYmlCMVZhS1pIclo1Q3ZWemhO?=
 =?utf-8?B?Y1ljb3hXMlFyNjVNcnRucmI0QlFhSnRBWDkrRlNBM0szOXBDeHlycllzK1BV?=
 =?utf-8?B?RHB2N0M1c0NXSG9HbjJWajNFeWxpRDdkVm5ja0tOeDB5Zjk3MlhFdWVJM3Y1?=
 =?utf-8?B?WklLbDFuTjJlQ29GdVVqeFp2RmFBMC9ablpxZlZoL3ltZlZFZ242bFRmWTBh?=
 =?utf-8?B?TGlqQy9hZ1F1cVV2UFF5ei9BV0pnRnc3czBvLzNoSjVxdFRsOGVSclhpM1RE?=
 =?utf-8?B?blNDZWpmcGVhbFFIbnd2L3liaG9sbHA0ZGk5VkNyRWp5a0MxUHhZTmVzajd5?=
 =?utf-8?B?QW1zTHlmb2RZL0JINVcwRjRJSTlCSGZ1S2pxMG8vSytLaW9hUVl4S3dNVWli?=
 =?utf-8?B?N3ZUWm1JTXJPYlRWUUVNWm5LSUhQR0cvWCsva1N4d3l4UzQ4YkZrOC9vcmRm?=
 =?utf-8?B?YW9JRlpnQitlVTFIM0s3dDhONm13NGNidnp6Z29YQ1pSdlB3UzExdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e44cfa7-7e30-4ea3-00fe-08de7a29aae0
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:07:31.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOQ28xHQV9FPYjpXdGKvD4S7bMup/NI5dwth8kIHexRf0cBZ0WWiNv/cYSRBepsCTk1a98HQiSFunIIIRtQK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
X-Rspamd-Queue-Id: 740B32076D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43622-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 12:06 PM, Gary Guo wrote:
> On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
>> Clippy reports:
>>     warning: consider removing unnecessary double parentheses
>>       --> rust/kernel/cpufreq.rs:410:60
>>        |
>>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
>>        |                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This looks like a false positive, probably due to how our fmt macro works?

Probably, but in any case we need to remain clippy clean, so this
work-around seems about right, yes?


thanks,
-- 
John Hubbard

