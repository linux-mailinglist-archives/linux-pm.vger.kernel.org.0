Return-Path: <linux-pm+bounces-25496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E16A8A990
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 22:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F0B17F399
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E7B256C92;
	Tue, 15 Apr 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VYOjWWo9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C65255259;
	Tue, 15 Apr 2025 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749997; cv=fail; b=V6n+ohOFYeXvenjgyT92nAUTq0Izb+54xh14lEiTD7STUz8f0DbqoWbi1j3FCcDOcYQVcuofYIbdHjV4JgTRIZwN1xJdXv0O/e8eWnKCJJx8cyutQ5OgVdkP4RVTLQOpamWFcibgN+pAbsvwVltDniPx84ylgbTNyWfnpSAuY0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749997; c=relaxed/simple;
	bh=Yo5fPP2CSf/mICMlTo0B5yGC9dA0xz1xl8NV8O7WtqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=quXkwf5HQSXHDltpXMrdf12ihNbCus6i1YQF4b9Avkp2UHpleBGzUE6ATT/fpVfnh0f+i81nbm6bQQbsHfS8MmlojuXkBMOyahZ0wPunIjhJ7Y+aPIFDvMtWUjj1W+9xg9p5NvsbBqDmSI32KJbgxTaSC5QpS/Z3GfpLmJ3hXAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VYOjWWo9; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWYYSOzwI8xysIMdvGdR/mt0pdugnyhCq2D+KAGD0ITVC4flW021xFm81Sr/sStvpunXJfVmd/1zV2SyDBcxVP7mKG43HBRVopGM/NOHmwpbBnwPPhlYyPWNTLC4pq42vPY4mrH/rgRaM9r3DT2CEvNg9DrdEO9/5jBTvXNNr3/ynQ4i2NZouFBxkJMMwwl/1juuXA4C2Q9Qr1fzlIjZV/SvK6/9E1HKzGG4mEKeH5XHFEcG2zFLXXMn8RkHvnTQauA8dBVCPU36x3LfkrtDgUyKt0XMfeqi3LaAbUG/bJHHhnmXIp4Bo8LIoiDv0IttIXw6CgsdpcB8JJhr6NOWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHi+dUCd2m80rVsXbdO+ZE55tTchOfmPXA6TrNK/iBM=;
 b=Dhjydt8t4JdUmdIGxSZrVQVrsTf34eaZsnZlUu7QiehNX11R01+Rm1gSbuiZ1TIaHTgcfkv5cHHQ5guXr3FZa/C/LRLaH0u3P0U/5JG5xYKYfTxiMmzfBcFW/mGUseMN6wvnH39MHGDnS0YBcoBPRX+awEAwYDTkqxkSqB54Ra3gFQrRw+lW6a3u+zgv4qMDju/8ILa2k+4NOhX0U6hIMJ0yGw6UxYBdJK2Isc6QGFicmq1tkaebZ1u1HwDFA7qWyz14CybuUTQWV0J3PfDhWZcGdycomuSBOd8B2tiBA8fTvYEa9RtZ5Rmg2NK5u1gmcRNAdFhr9xqcLDIfzncvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHi+dUCd2m80rVsXbdO+ZE55tTchOfmPXA6TrNK/iBM=;
 b=VYOjWWo9Kwlg99J3ki2k0NEDeEEktFIrgVkG+1M2RiHeQoMwadNIBDzCKP/MtrTjoEezbop3DMR5pihomL18DcxM+lqcARLi1wW9hEF2mp/ws6Z0e1NUGFrjjMK633Kkhap/ci4H+UOZ4ok0de4LGEvpbALHgLOcZIsEMdw6auU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 20:46:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 20:46:32 +0000
Message-ID: <e08fab15-3dce-4471-a016-abd6baab9340@amd.com>
Date: Tue, 15 Apr 2025 15:46:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Move max_perf limiting in
 amd_pstate_update
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415082308.3341-1-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250415082308.3341-1-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ce4135-758b-4892-f145-08dd7c5e9ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXkrWGdKWFREZnU0RzgyT0tOVnhmb0o2dFp1cmdWdHE0RlJzWUt4Vmw5bzhJ?=
 =?utf-8?B?ejBLcGljWlVxRFYxMzhnZlNZV1g3SkZJRWJ6eGVzV0lkSmlvZXJRMUxLYnVj?=
 =?utf-8?B?ajN3Ynd1SFcwb3c0bnlkN2JNcTBPbUJGZWh6blBxd3JNSVBwOFozQk9laGdS?=
 =?utf-8?B?N0VpVTdRa0tJMHNKVVNVdTJ5L0dmNlV4eTVBVWVOcXZSN2piT3dFZHZtenlw?=
 =?utf-8?B?RFgzY3BCTXhLcEpoL0MvdmF0ZHBqV0RkU1RPSGUvOVBXcTBSYWsyTnBvaE1v?=
 =?utf-8?B?K0s5RGRGUDZKWXc5VXFTdmprTW1xUDJHNVpnVzdZUHZwMDJxUnRnUURhcUc4?=
 =?utf-8?B?eGdZb3pCdmIvQzd2eUVFREdYUXk2dWEvdnA3V2J6QVBScFhPcGxLcG00N0dr?=
 =?utf-8?B?Ry9ZdVQ5dU01bDlRYTh0SHU0N1FMTENMZEFyVmhtZE1GZ0I4UnVhV3VLSzh5?=
 =?utf-8?B?SzR2RnhnSkk1dS9OcDhBb0ErT1M2NmN1bklNd0xEd3JXTVNEeUFVbHhtbTlI?=
 =?utf-8?B?LzFGK0FQR2lHQnNzUHNobGxGNmJUeFBnSEh5ZWdmN3MxR09CWTdMNU1aaVlD?=
 =?utf-8?B?QStTS1Y0QVVCK0Z2VDBoaEJnMVpNOGJCdzVjaEdMaTlXMVFZeWZ6RzdqcEph?=
 =?utf-8?B?ZlFidW5STnNtYks4TFhXM1BDZStCMXVxSURkYkZ4LzExZ3J6OEZQY0hDbnI0?=
 =?utf-8?B?UjhBN0FKRzl3aFpoL2ZHaGp2SGI4ek1JWjRST2djNkE0dHJSMU15clRRdWtm?=
 =?utf-8?B?ZEN5ZGp0RlZrTWdXMWhQNCtRRlZjTGJSU3gydTRuTEVpY084and2U01udVA5?=
 =?utf-8?B?TnJqNlVpQ2RYWDg4aFJkckI0VXZjSjJtTHVuM3dNaVJpRHNyZ2VyUnNhVmFk?=
 =?utf-8?B?K1gwd2s4QUIzWWR4L3NQR2VlQ2xOQTFiMmVlbHRPVzFQOGduQlJMSjVVNkIr?=
 =?utf-8?B?TlNKeGxQRFkwVXZ2cWIrdkV1dGxGSTNLZ1hVT1o3TzZqMnlNUVdJN1NLQ3pm?=
 =?utf-8?B?RXh0UVNGZS9VR2pzcGJycUVxQlBUaE1jQ2V6eGc0WDdpY3VXZWhianhrNnB5?=
 =?utf-8?B?UlhacWpGNEU1UjdkL2lVZE9KdUNmcXBqK1J5c3VadENQeUo0dVEwbTRXQzZU?=
 =?utf-8?B?bHZ0ZGR4dVQ1aXo3NmprSHE5aVFuQzA0czBveXpZbkpWSFBibzlWU2tGZWVJ?=
 =?utf-8?B?VmZyKy9TMWdDVTdibmdHampPYzhSOXF3RFlOSFc2dVRaMGI2a21QdVJhaWtz?=
 =?utf-8?B?YlgwOUI1RjBBYjdMVXRKWjJYUll4ZzRrVUQ2YjdyZXp5QWtoemJqMjBvMU16?=
 =?utf-8?B?ZXhtRjZ4Si96UmFNbmpVVW9kMzFPaW1KM1IzLzN0aWJ6Rzd3TXlXUmNnU2tP?=
 =?utf-8?B?eXNON3FVdW01Yno0dEoram4vS0NQVWt4aEJNeklwVmhxSkpOQnhXM2xweXdh?=
 =?utf-8?B?ekZBam1LUTh4UU5ubkxrYUp2azBROWxPeGw4Y0NjTnlmTTFHTGZpeEVmYW5L?=
 =?utf-8?B?dm95bDN0WUxFZGZoUWIvNmZaWnFsaGZyaDZiZ1p3VnZ4LzVsU0lvUjQ4SFNF?=
 =?utf-8?B?a1h4VFl4eElEMUVXRmk1R2NIQThsaEtqUlhMOEZyS3R3cjlQbWgwaTZ0UmV5?=
 =?utf-8?B?YjVHYmRPdHREcEJkTk5EZENadW5VTDdQTzBPTXRmUng1cHBxMVJBM09lalZv?=
 =?utf-8?B?ZFpJV2tPenNYcEtoMlRyd0pFanZkckpCYktXY0xtN0dmb2htNDFsSUprbGhn?=
 =?utf-8?B?V2poRTlrMXllZnl3a3ZpaTRUMWFOZE96WGxEelkwek05Sm5PNjQyODJRQ3Zw?=
 =?utf-8?B?Ykcya0RTenNDdE1BaDFiUmVPQmFUMWFUdXdOVEtLazVmZTZZTlp5ZDBucHRt?=
 =?utf-8?B?YlEyN2trblBCTE9nT054bEJjaWlIbGRHZlpoRmFrRXc4blUvNGlnaXJsMnpH?=
 =?utf-8?Q?XVmgOqTU+7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDI5enN6K1FCSTJVNWdlT2RQdnZhWjdXekIzWEdnZWxML1RMcmkrUGxNVVVW?=
 =?utf-8?B?OEtwL1dMSzJuaGQxcHN1NXlJMjJIRWE0aUE4YlNXWnpwN2pWVTg5djdtdGIw?=
 =?utf-8?B?K21DOVI3MDNNUk9EYnZKKzN6a0tqa3hZaVNyNVZLZjBrMTYrZEZQcnBWZ25H?=
 =?utf-8?B?Z2xRcE04OENWbmYzTmx3STlvZ3hmcytvTlNwdUZkbjQ0bmpPK0hmelhrU1h1?=
 =?utf-8?B?UUdwNWxETDdnNXlhbkZJR1V2N1hlTlQvZjRWUzJDVk8zbDNGR0V2cXdwRTht?=
 =?utf-8?B?Mm1MYm5XNnVGbytLOGNjOTY1bmxRakc4WGpxTkZSQmQwOHpHTUlRT2ZwMGtx?=
 =?utf-8?B?TTNEYWxKL2FyQ3MyRnhqNHNxTGpNS0FoNEkrMVlkdGFJSlVTa29ZUnpDam15?=
 =?utf-8?B?dkI4YmtSVGpxaS9SRmsrZDdVY2cyZXlMdmlNOHNjZGkxN1VjWFE4K0hIY0xX?=
 =?utf-8?B?cXNucGI1bUZ3bFVlbktEOUhDdE50TXpIOS93RU5Bd2lIMU9OMjFHemZtVnRJ?=
 =?utf-8?B?a2I4enJpeFY3T1gyMTk4NCtkaU80d0lBN1dOcXRJMEd1d3V5eU5RWE81VmM0?=
 =?utf-8?B?ZHVWdFhqRnlDQjE0MVNFMlFoQjVmM0dTdnU4ZlNtOSsrTUY5Nm5oSm1nSXY4?=
 =?utf-8?B?R3NlYUZEMWlmVGUxbkFCb3NqUC94bSt6QXZhVHlMNUFDM2ZtYWVVcnAwdXds?=
 =?utf-8?B?aUJtOEZ0Zi9SbFpjYllyR2JkSHg2WFdlMnhPaVUxaVA3bGVxa1VoSHFaNTR6?=
 =?utf-8?B?TTgweHRKR3ExVTdGMHpIcWJTbTlYL1FYaE5scndDR0tXUXZGUGZSc1liM0Yv?=
 =?utf-8?B?RmZVV201UjF3bzUzVzV3NUZPSXp0bjNxTnNGVm5DYWlYU0RGYkhSY1JXUWhB?=
 =?utf-8?B?cHJqOHlRK0lHcHY0MU9nZDBiaEttNWQ1dm9RWmI0QmVLWnpDRUZSejN6RjZZ?=
 =?utf-8?B?MXl5Q2N4T1pWci84ZnBDcnhNSG8wdEM4MSt1OGo2YnlzdlpWNExlQ3VuMXpm?=
 =?utf-8?B?b2t0T3hVUFBJWG4zTUhSVXh3S3BUS3pvK0dhRlJ4Z1lLczJiaE9VYmdzR1Rk?=
 =?utf-8?B?UTlOYUpOc2JFRVRFYzdWVmhsRUI3RlhQT1dHTWtKTmJ5c3F4R0lZOHFrMDZJ?=
 =?utf-8?B?NDMxUVd3c3g5NVlQcVFLVGR0bVRnQzdYSllkaGxPZkpnYlY2enRBbkM0M0x0?=
 =?utf-8?B?Ky91cEhmSmJmZDV6QW9jR3praEY2ZWI1bW5UOGovSG1TVDlFZDYrdUFvcXM1?=
 =?utf-8?B?c3hiQWVlZ09jRnhTZEM5b1A5d2RpelVYcnkvR21BWEh3K3hIY0VGMzg2aHFX?=
 =?utf-8?B?SzRaMGtOV3YvaS9BbWlOazZtVjhxR0FWSkNkclZ1cXRwd2ZtcEhyVUpHa1pD?=
 =?utf-8?B?TmEzQm9qNGwrQWFDWG8vYmIxWk1sdGIzckRzdUloanhNWVBSdWFrZ1ZpbHFr?=
 =?utf-8?B?cUpvUzBVaVpGUm5Gd1FDam9RL0wyMGYwc2NIUXNmK1JtalNKRGdvWXRxTnlN?=
 =?utf-8?B?OThmeVJvZVZJdEJMYnNFNEUzWFJlWmFNWVpyZUU4NVgxdU54dFZrQ3JGakc5?=
 =?utf-8?B?Um1EWkJNWERUYXNjaDh5VWVYS3l5WVcrUUQ5Z0loclBkbXVON1ovaU0vM1Uw?=
 =?utf-8?B?Q2lSL3YzYWhHUEpNcldXUlJjb2R4Wlp4MUJVUFpMSFR2dmcrY3JUZlZ1ZmJo?=
 =?utf-8?B?TzlHR2U1ekRkUWtvdW1LUHBHUDJJRm44aDRNZlo1WVBMZWZFaU94OTlhYVZK?=
 =?utf-8?B?aE16NkU0K05vNzdFR0g2MFhyek40dXN3cVhXOTJzbitvVkhwK3ZzTnNrTDAy?=
 =?utf-8?B?VHpyTDQ5N1p0U2FqV29OTjI3aDlTSmlUMi9JU3dRelFzbkdhQUNVNUM5aThZ?=
 =?utf-8?B?dDR0NkdqY3NzSmhwU0s0OCtGeU1Sb0JJWXBUQkMxRW05VzltVDFBTnM3ZkIz?=
 =?utf-8?B?UHF3ekM2MllJQXpDMHVIWXRXemJhZUZuZjdlbWx0bTMvVTJBa1dOUUpDQUo0?=
 =?utf-8?B?UVdHOUUxWSt5ckNqdmtiUnVlZXZmc3RQazJ6Ylh6aE9XVGVwNlBoNVR0cmhU?=
 =?utf-8?B?ekt6WkI3NU43SG56dm95ZDMva0NJQ1VzaHYyek15TWt3NC91OFNvT2FGdVlY?=
 =?utf-8?Q?QOwGiS8cWXynTfOiL8T4msaoQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ce4135-758b-4892-f145-08dd7c5e9ae5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 20:46:32.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /psO4Xaj5wBuE9anGZn96uS/mtlYMmrcWPiJ6xcrSc02Of825FvRaFMGHgrNxHsbL0ymhmnZ2VLGdTqdfIm+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905

On 4/15/2025 3:23 AM, Dhananjay Ugwekar wrote:
> Move up the max_perf limiting, so that we clamp the des_perf with the
> updated max_perf.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c54c031939c8..c29840ba3b30 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -554,6 +554,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>   	if (!policy)
>   		return;
>   
> +	/* limit the max perf when core performance boost feature is disabled */
> +	if (!cpudata->boost_supported)
> +		max_perf = min_t(u8, perf.nominal_perf, max_perf);
> +
>   	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>   
>   	policy->cur = perf_to_freq(perf, cpudata->nominal_freq, des_perf);
> @@ -563,10 +567,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>   		des_perf = 0;
>   	}
>   
> -	/* limit the max perf when core performance boost feature is disabled */
> -	if (!cpudata->boost_supported)
> -		max_perf = min_t(u8, perf.nominal_perf, max_perf);
> -
>   	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>   		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
>   			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,


