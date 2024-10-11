Return-Path: <linux-pm+bounces-15516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED639999956
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 03:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2511C222F1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 01:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6CC13D;
	Fri, 11 Oct 2024 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2vHM2TIo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA817BA9;
	Fri, 11 Oct 2024 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610194; cv=fail; b=gHbwg5MNiLosLW+p7DmGJL5pmYCkrB3eAqW3xvcTFdW4a6OdwLxPFBtza1Rq5yHncxzzLNmJ4By13s+4GoriHGkN1/SRWRXM0CJWNxYE5Z0fVz9RzoU1vFKKjEVU7on6gWnUkLQQJRWc+77ml5PX+BdFtFU7WyYoM8OGUX/ScWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610194; c=relaxed/simple;
	bh=ydesrNNPbkC2oUtbUYUxxxHKo91S7H4rUFWBIE2dmgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpDafJKekrLRMTSBHmc6Q/sqUAaeUrnHq1C4xJ5jWw4+TYX9082gFJyJ1t3CaiaiVPmnORPoVIID2mw8ugteAnjviXFZEvOOykVm1BI22udGtRcZk1dZdhvRxjFVoUcV+mV0Wt1CpnGCA3NcgV0Ik4Vx2131RtF3U2EmjoKAAZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2vHM2TIo; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSPaWCbqe/IdxAExuhAgnrASMcvDXX+huW+EEF2MLiG8GZLZzqJO/1WBtkOEZ9yaXixfcWVbzCBYae1nFA0MfMlme8u04u8c51KIyHvztSkWwZNPFRIiwN7bmNib42269KSjKXX9WddC/gomY8MLoRBmQTaYYBOlA2zFNgWACLGhahVW4RwQ4DnAM/yer7HrvfLvcZFvM6BZjlIs6qoDOkp3f3kB20woFdUdqpeKIBQWZtTrFtn/eynCt/6/MdsHDvqtQdgLmODoR9elPLVwyG1C4dJ3GTw6oru0ecKLUumAAL8rFvOReevzYkJ4E+hGVnkwODsT0diphw8TTFvupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI8TjifObE+GCAo8lzNvWYVwkoI3l0bWEZyiDui3MRU=;
 b=QZnCsunLNsxCwlwIqVe2HEx5bh2L5V6UxHSQDw7CYgGA5LZ/mvBF71slzQ6N0nTzcA1eve0+vnJguGxi46pFHhVlxzDM/1U9QTilBmsVAC3co1ICJDPa62zR1UeCe7s4Pto6ejEjN+AEXiVWjTk9QIWe/F3Be3snSDMqrmwNWve6+YWlJCaX1KwVftyZKAnBVmisSzKwNqyLKX2NvSV1rwp0KDicUMNk9RDvqnX8ohQQIMvXpSvrSwDcNRHHa51F2HR78csrC200r5Iwloh/sd5HhBTavdqadE2OYkTK6I40zIEve22M3LcoWkU/q6HWrw3lduajaAK+/fmUQl0z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI8TjifObE+GCAo8lzNvWYVwkoI3l0bWEZyiDui3MRU=;
 b=2vHM2TIoBVkCeviUslhywnTbkgStfoTaNTlf2kbRK/LTpAP+h/SRyeOUqL2y/ZtgkjoLSyrZa8gp/cfSnXpc6q5ogLwhM5wT8D2PJ8b5y6JKGIFe8q53qo3lnUifjyQcpvYa9MXzyrUaFcEwR+rosgsrMAMUBNr7UeeaxRFf7Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 01:29:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 01:29:49 +0000
Message-ID: <6d7e5cc5-db07-423b-b39c-0de213fedaf5@amd.com>
Date: Thu, 10 Oct 2024 20:29:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Add support for AMD hardware feedback interface
To: Bagas Sanjaya <bagasdotme@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <Zwh3Ky9Qoe6si1qC@archie.me>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zwh3Ky9Qoe6si1qC@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: c16a9e71-93a6-48da-4903-08dce99432bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjRTaHZiVGxoYyt0eER3Qm5PSUxIY01rQ1ZrU3dFb2pFL2ZmQ2t1OSt0VjYr?=
 =?utf-8?B?cDYzUzhObHRKTGJyQ1BJNXV3dm0yOURtZmxLdGtxenI0TzJnUko2Z2NLQWp1?=
 =?utf-8?B?a0xlYzdOV3VlTERXU29DeFFLcHlRVExpV1hlZUllK1RJRHF2TEliSk9EZ0xK?=
 =?utf-8?B?U0RjS1BpSEdPYXJ5Mm5vVEt2VmE5bU01SFhTWXozYXhUOThydmFyYVNyRWE3?=
 =?utf-8?B?ZW52T2hEMCtwWDNTaXRWT0ZCRWZ2VVpJcHZYb2cxR1VhRlB3NUV0NHR3aWV0?=
 =?utf-8?B?ZGZ4SHVoZE5wdWRlMFFSMGtDRnBjVklzN3NIWGl6dnprV3RSZW9OakthVW1U?=
 =?utf-8?B?MitQWGhRQXFteVk5VHhvRlR1NDRjWUNsbzExYUswMUFScFBKdnY4RHZtQzQy?=
 =?utf-8?B?VUs0ZCtONmNaS0ZhcEZOUUF2Rmpkai9vRXJWR0x6eE1PMCtLQ2tWQ0o1d0NS?=
 =?utf-8?B?bjFlWmNxRjI3VTZ4dlpUUkdVSk96cVFFa3B4bUlOWENOVzlqVFp0RXpCL0VJ?=
 =?utf-8?B?Q3ZTY3d4ZXcyZm1BaEVLZkFLVmM5dDF1bFNqclFQRjA3SHZBcElUV2NwN1R2?=
 =?utf-8?B?QVNDRUk5NWFUc1VUU1JVMHN6dE0yYkJTTWV4d3lCTUw5LzZCNlJMT0hNVkUv?=
 =?utf-8?B?UTVTZGpKdUF5bldUM2dPb2N3aTFheXlHRWdNcDVJNFljejBYZnFRb3RxRHBM?=
 =?utf-8?B?TTVMSVg2eUlnWU5ocDVUbXM5WGp0RURsZmRwMGdPZmQ2dkhROFF3SFJEY0w3?=
 =?utf-8?B?bnBveTc5dW1Femk0eWlsYlRtc3hVbXlMWThNd1NtczJNUGxVOGtFL3NRTk1V?=
 =?utf-8?B?ZmtvcWFRdXJqeVA3Mm5YMXZUZ0N5eklzTm01Mks2TEpyelM0a3NpcUJNWVlx?=
 =?utf-8?B?MEVyUUh1VUlYUEZ5alJvVU1uSDZUanlPbktyMy96TEI1R2tnbG9FY0tYczUx?=
 =?utf-8?B?TUlDcUcvNUxCRXMza1NyUlRDeC9zZHpRYmszc1d5RVdKdFhDbWk3cklWM3g5?=
 =?utf-8?B?S2dQK0N4RUk0OXN5L0hrQnlhM3JpUjF6aHNBcWtDKzQzQ2FEQTJHVkRIS3ll?=
 =?utf-8?B?eCtmMzdnTWY2TElzODY3bGNFaGF3cDJENEZSOG5HRWU0YjVVSnFzRnZvOUEr?=
 =?utf-8?B?Vnlxb1l5UnNoK28rbE1MQmV6RUxvaTlHdWxIc1ZuYU9ZdGVnc1lUZURPK3Ro?=
 =?utf-8?B?UWY0YTRPTjFlQnByMk91dUs1TVU1YXlDN01VUDQ2M2U3N3NIb1p2NEt2R28v?=
 =?utf-8?B?UmRwQUJMOU8reEhHYXA5bjVWbWFZOFpPKzNXRnJIbFVsNWJNOVloVUsyaUpN?=
 =?utf-8?B?V3RaYkdpK2dwQ1hWa1QrUkUvM21PZXhZY1VhSjhUK2NWbURYM2tlemo1SVpC?=
 =?utf-8?B?RFJ1anZtVTlpcEgwNkhtK0xYVXljSVRnU1lZQnFJd24rUUJOTEd6Q1dyVDdq?=
 =?utf-8?B?Zmd5VG9NaHFFcEpNaC9GMDBzd3ovV01QQzgxSUNyMXRESnA1cCs4ZURvdGJl?=
 =?utf-8?B?Nm5JYkYrTGlBWFlBSEd4YWlFNElUY2d1eUVvNkZGK3ZpbWNxMkNYdFMzdmxY?=
 =?utf-8?B?dmVoTzc0TUhzdDkyWm80Z0VjRG1jQWpJSHNicURIZHdkMGx3VE1LbXlTRk9x?=
 =?utf-8?B?SU1mY1dIM2c0aWhnaDBqeW9jTDNlU2p0cjhMZk1vbGVZc21Wc2dobFNWdzMv?=
 =?utf-8?B?MnJxTFAxVFg5U3IzMUQzSXZ5SXpJTWdBRHFHOExQYXR0b1FVTUdQdk5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG1nUjhla2ZHaWFyV1FZYmptekdZc1V5VEpmSnliS0Jqb294WVVpNzVock9o?=
 =?utf-8?B?ZytWdGF5TzlHalhJbHlHYXBMdS9iN2M3bFRhaWt6MlJxaUNvejdoZ3FXVS9N?=
 =?utf-8?B?ZUJKa2xWNnpBTkd2MENzZ2ZnT25TaEpMNGlXcTduYXVMR241cHpDTEFkVWY5?=
 =?utf-8?B?cEI3N1NMek44UldYZy82Sjc0NHRlM1VyRko5bTdxWUkrOS9HdEhxMlhHbSt2?=
 =?utf-8?B?RjgvdEZ5UHduSDlUeXdtSkNZeUFxN1B1ejNHR3RSd3MybTRUNTRBbVhIbGtp?=
 =?utf-8?B?ZE9VVjBVQmVZTUpzM2hMeVI3T1lrdWhJMW9KaHY4YVpBaE5adnc4KzlscnZm?=
 =?utf-8?B?cDJYMHhqenpZVVpNR3dpU2VPUEZKd3ZBZXUza2lPZ043RlhiQ1AxQTNEWHRv?=
 =?utf-8?B?VE5aUHdMZ0NSVk1FNVZ2OXRxWDM0SXZvMFBLU2h2ZkZVbys4aFI5a0RzYzk0?=
 =?utf-8?B?L2xpajNnbktDMytISlNYdFlqZUIyL3QrVXRUMnM0YVJiRzlpb1VVWVZWYkpx?=
 =?utf-8?B?eVRJQ3hlMjM2aWo0ODJIZlc3bmh3ckFRelBCMlNoWnF1OXlqYStISGJVeTBO?=
 =?utf-8?B?WUY1Qi83OWVncnp0NEc4VW9MeFZXeEhWQ3YwMGc0TWZSNm14c2FkaVFSRzh0?=
 =?utf-8?B?eFoyOHFiaVE4bDJObi9tZ0szK2g1QU5hbnlYWDQwRXptYVlCYU9jeU9JdGxX?=
 =?utf-8?B?bkZsS1FvSktTeXh3MDAwVFFpZUVhWXQ1djV2dnVBaWhPVlFqY1pwTUZIM09q?=
 =?utf-8?B?U1JIeVQ3ZzAwYm5JUkdhVFVVeUV1ZUtVVEpsWVFLZWliSWNDNXlpaU11aXhR?=
 =?utf-8?B?TERreEc0RGZsKzUzbW9kRjFjeE9SK1Y1SnVGeGdzMy9OMGt6TWxqOTRpZm1E?=
 =?utf-8?B?NnF3R2RiL1NlVWY2a1B3dnF5QnVTVDV3ZmNpRllwWTdTNzVFQnIxemd6V2dK?=
 =?utf-8?B?b2hZeFdUcGlMS3hzSkNSMnJlcVVCTFRUVkpEdmpsRVd4NzI1dWpZb3RrYVFT?=
 =?utf-8?B?TVhRZXJsQTZGYW0zRFhrVVZJOVBRZ1lCekxVWHJSQ1lPaTRSUU9WRWNYRjBx?=
 =?utf-8?B?SkViVjd2K1QzUHNDeEF4cVMwWGR1Uk45dVQxOSt1a0VOd240aEJtSEQwcm5j?=
 =?utf-8?B?L1FSdktCSnc0RUVreHh6VWZTZkpGNk05TlhoRXZnSkdsanNvNVRwVjY4WnA5?=
 =?utf-8?B?NXJWd0tXS2xab1BPUmh2aVRaaHc0UURZcjk5MnBuNzNFR1lkZkQ0Z1RiSmxM?=
 =?utf-8?B?YjEwYWFEVU85Y1ZHSVRmT3JySmM4bUJhVG1DRXVtUGVWakttR0U3aXE2V1gz?=
 =?utf-8?B?MmpLSzE5MDUxQStxcktFcU9oeVhFRzhFcnFQbEFnc2RRMXBXN3VHOS9xWlRF?=
 =?utf-8?B?eVFvQU5GZWRtVkFIanRRUzJkU0htcWtWYWpZK0Z5V3pqNEZIWERzbE9qRGI4?=
 =?utf-8?B?OHMvS0V1MDJ3RlVrQ1g5TWV3ZjZyVHZqZTU3b0V4ZStMVUFsb01sTkZSd29u?=
 =?utf-8?B?UjBQdmF2c3lkNFNIOWxBSTU2WU0zZUVGYWdCWUFIcnRGTVZOZDJQM3QrTGVa?=
 =?utf-8?B?ZUFJdk5EbnZiSlMzWDBoZzlaRFhLOFpMYWlnb2I5eDZmV0dsZkU0eGxuZXZX?=
 =?utf-8?B?K2FjUmxEYWNPSGxzOEZwd3FzRzJBb216MjlLdVhUejVNaUFkSXQrcWdRRXF3?=
 =?utf-8?B?QVNaLzhIcHMvZE9tbVdnOUtwbzZUWTRCZUVqTXl1Q0prZXNOOFlHU0VESDJv?=
 =?utf-8?B?TW1ZUi8rQUp3YWc3S2xTZ2FrSmw3T1diclJQUWtYL3JwcWE3dDJqMkRwMVFU?=
 =?utf-8?B?YmI0Nk42M3pVVURWUGRUQXViUDFjdGVKZDNxMTUySUtTM2lUUmRXN09SOXk1?=
 =?utf-8?B?OUtLNHhqU1h4bFNuVTRqWmRNTVhNQ0didExhekszN1VGYUR6UVQyTWpUSWF1?=
 =?utf-8?B?a0JNTVpTYzFWZ1kyRmVmekpDYkExa2VaZERFVDFrRmRXZHRnWGdqYnhzVzlN?=
 =?utf-8?B?U3hlUVBTdXZhS2N3Q0pPUHQ5a0wyMEFLeWlNRytrTnE3YUZNeTlWWjV4WG1O?=
 =?utf-8?B?UlZMdXpHWXJscHF1Rm1GNnBtSWlHTThHQnMrU2FSTE1zVDUyYVRjL3A3a3ND?=
 =?utf-8?Q?qnf1+PpOakgplQTtuOn3aqLCN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16a9e71-93a6-48da-4903-08dce99432bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 01:29:49.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPhevpAOPplzooEAifoViZ0+nk5IpXSSkxva3VntbkksuPxOjaZtTihCXfqY96PEpKZccnjz4gLoQwuNxO/+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

On 10/10/2024 19:54, Bagas Sanjaya wrote:
> On Thu, Oct 10, 2024 at 02:36:52PM -0500, Mario Limonciello wrote:
>> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
>> provide behavioral classification and a dynamically updated ranking table
>> for the scheduler to use when choosing cores for tasks.
>>
>> Threads are classified during runtime into enumerated classes.
>> Currently, the driver supports 3 classes (0 through 2). These classes
>> represent thread performance/power characteristics that may benefit from
>> special scheduling behaviors. The real-time thread classification is
>> consumed by the operating system and is used to inform the scheduler of
>> where the thread should be placed for optimal performance or energy efficiency.
>>
>> The thread classification helps to select CPU from a ranking table that describes
>> an efficiency and performance ranking for each classification from two dimensions.
>>
>> The ranking data provided by the ranking table are numbers ranging from 0 to 255,
>> where a higher performance value indicates higher performance capability and a higher
>> efficiency value indicates greater efficiency. All the CPU cores are ranked into
>> different class IDs. Within each class ranking, the cores may have different ranking
>> values. Therefore, picking from each classification ID will later allow the scheduler
>> to select the best core while threads are classified into the specified workload class.
>>
>> This series was originally submitted by Perry Yuan [1] but he is now doing a different
>> role and he asked me to take over.
> 
> Sorry but can you specify the base commit/tree of this series? I can't apply
> it on top of current platform-drivers-x86.git, though.
> 
> Confused...
> 

Sorry about that.  As it crosses a few subsystems it will require some 
coordination to properly land once it has review comments.

It's (currently) based off:
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=linux-next

commit 57533bc760ae ("cpufreq/amd-pstate: Fix non kerneldoc comment")

