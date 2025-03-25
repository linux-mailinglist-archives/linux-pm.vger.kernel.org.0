Return-Path: <linux-pm+bounces-24489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C57A6E8DC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 05:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748D016DC6C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 04:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7C1A5B9B;
	Tue, 25 Mar 2025 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FNrd2TuC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812033F7;
	Tue, 25 Mar 2025 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742877016; cv=fail; b=VOVHHfObr28VpeKIL3nvJ8hTQVSITN/YyfpHabOsv1FM6vyKVIeeEzJOhthOO/AHCLq3v7/YtpZ04g3RTXtHe6a8UzLVa/+1UDoxastrnARsRzrTxsniD4N75H9IQbwPhmfmOHPDNJ4hB79z/yH94rHBFeL/0kjT+0brqqw4rVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742877016; c=relaxed/simple;
	bh=k6LEZF1TJ/Qon/t8SdsrMu/EMLtoHcfwWGBc/RBrLfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsy//BVa9J084c3BR9NQcLrN0hrvWE3t+cn/irr/tx4aZWpYuP6wZrXvBjRygkSZEdmhnSjPc/j4Ym45zPFWn8+HLqOZFPrZ3EXte3opuAn7mg62XCv5m/wSkkPHXnDNp9qHqydixcXItIG7qsfWK6bQ3mUGSFjIEuAT3d2jFCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FNrd2TuC; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYqECpI/6sX8BAADEVtc/Zd7EXcISo5nwa/TG+wyRlcWv1mBgIsrS4QTJ9t1lXwNuGP6pZMmz75uxyJ26wvyg4mnzBktDdWPZjoNxG56lJj+NNYL/VAaDTFLCJDTEciHL5obpRpyZsMhwV86/adS7Igua8Lbr169+PljQcr95YhCmoUdvcUsrZ/wefVL0nlfhFe1AEOkNISJnZWgZ0zoliEWygOqgFzDnXCdpWJIUlSsm3rrWLx5g5aSzn1OSw5ulr5dH5M285h3UJ6l3ev1PxncxrfySJekhMygztI73YZr2KaXeD+bZBegFfdaoDet3pCXB7gv7OdV2Ldudj+QcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6UNlo8yJiMoYitNwutOmx/BjMyehBUuYb/gmJCWlgQ=;
 b=iTbWrXQ0h0FNRIM6dYnmdcqwARKo4M3RnBb8VLY+UjCza6Xiel7vuB0FTas07JHccOAkf41cGv9FS10SfM5Jr7awB+VMoYivpARlz9ybnke7RhvXGlu1A2r4qXVZB3iSUCkvlLR5i9F+af68PQKUEMkJB/ck/9DzDfln+KtQAzlDx6sMLflBQCAYe8kh5LKv17ixYIBGEVAD3mLZfy8YU/5DovVTII7j3zSj6CpqTGxLd5wrmdLRRW7/Ys33hcD9UNbGDwcYtdM2ZF+IiyQjiOIK15xDBv6tbrGHjkCRf6xyvK3e1fhlP9Ryrm55X/gNv4+mCYwCLmdrMDoP+DsLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6UNlo8yJiMoYitNwutOmx/BjMyehBUuYb/gmJCWlgQ=;
 b=FNrd2TuCUZvhgOXZT+G+aWAsKlbExW16PUoV7QI7kLR5ss3nnjnF9Q9naG6OrixODAvrICmegFUM9WGMtFw5EZiZCDLdVociPcwtgCMrBKcXODAg0yOuEHUeX9YXYYUgmNXjpx0Xr/UttrY5ajLBadOQdWGwgQDsJ6wqJxU4oCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:30:07 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 04:30:07 +0000
Message-ID: <2e1f1002-458f-4dd8-a101-a121c840022c@amd.com>
Date: Tue, 25 Mar 2025 10:00:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-2-superm1@kernel.org>
 <4d224956-b4f9-4b0c-b5fb-70abe82e6ab5@amd.com>
 <784b2e21-10fb-44d8-b874-b6bc2ee238c6@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <784b2e21-10fb-44d8-b874-b6bc2ee238c6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3e86b7-5473-4a53-2e72-08dd6b55b8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEtadTM1NHZjZzFWaVErWmZrVGNKc2tGZGQrSGw5UXRDMWNSbGRGRGQ5Wk1m?=
 =?utf-8?B?RXhhTXpQZ01jRE4zdm1rb3JHU20xQVlLYUtFcDBXODc0aHp6Q25zWFhxSmpK?=
 =?utf-8?B?V0dueG9JcmhUU016cm9LSHZUYU9OQWJJRE81VFl3YUpuTEF5S1AxUmI1MHJj?=
 =?utf-8?B?bFFzR25UOWF3RDB4ejdOb3FPdWtPWmZJQmQycmNCTDNqV05QbG1KM0dSMTRL?=
 =?utf-8?B?aW9NT1F2a1hSZmJ4VlAwdzlFd204MXBjVWlyT0pxR2hWeW45Z3FHdis3SkRF?=
 =?utf-8?B?QTRic3Arb0dleEhzSDVoRWZwSGhlWUs4YmpTNTRwZk5vY09HbnNDRnQ2emE0?=
 =?utf-8?B?cTFBcDFNcm5EWkRoeEMrQ01JcWV3R0JGOFZTeTkwNmdZL0tVbGpUQ1M3Sm5C?=
 =?utf-8?B?QnMyYXlKVVRubFoyaWVpOXZ6NzI3c2hoVnJ1ZDBWTUlYNFVQckZUNmZjZ1V5?=
 =?utf-8?B?S3U1Q2lFV1FITkQrMVM1a2R4dm1LMk43eGdqV3FjbzZMTnFuUGFFUlprdHhv?=
 =?utf-8?B?QXQ0ZjljMVhZdDNUSERBN3JWb1huTXVqMEhkL211YlJaSWRlc2hETUw0RmdD?=
 =?utf-8?B?TCtPRHp1N2RWL2c1V3kyL0NLYzZiT3JuUENrLzF0SW9GT1ZibnJQcU5aaWIy?=
 =?utf-8?B?OUtmSVBFSHB0UFJZd2NFQUczVHNZbzdRZGcwS3dQbWY4Tzc3Q1BLUm9DbGlH?=
 =?utf-8?B?MjBERWxZbmdkcWVKNEErRSt0cXBkWWlneG9TWWRNdklvY1FGdXZNYTlzNVRt?=
 =?utf-8?B?NG5ybnUxTjdmcHpsc3dxTGlPTkM3MWRBNnRvb3VETXJYZGlQNWpIUzl4SmZs?=
 =?utf-8?B?eWJGVExiWHBISW5LWFNuT3BJT2RqVTdjeXE0UlBlb3JjMVhUdDV5bVlFSzZw?=
 =?utf-8?B?Nk5kUCtnYUZ0QWVkUmh2YUhaalVIWWxkdEJtZitlSDlTNVdUUmI3dG9vb281?=
 =?utf-8?B?KzFwMjUvZGltWTdZekZtL0t6MkpjQTBUN3hyN3JnMTFYRzNpTi9tLy8vTDAw?=
 =?utf-8?B?em92OUV6UTluV1dyRDJOdEZieCszb2d3SHV4TVo1a1JNakpaendsc3pLdHpl?=
 =?utf-8?B?b1YyMnZYQlNSZFc3NndZTVk1RzlhS04zUEdxb1R0aXR6V0JnN25MUlNTdTNB?=
 =?utf-8?B?dkpqbFZvUXdtOHlRaFlCR04rMmlwb3ROZXhtSFZ2dHRvRlFPTjNlUDBuMHFO?=
 =?utf-8?B?cFRGcFh3R2ZlZWVvY2dFK095ZXZIaXJzeEMxSDY3TEpFc2FuM1dkek5qZ1Aw?=
 =?utf-8?B?dklIQkMvbEQzeUxmWXFteUxsZXdHcWhDeDdya3dCUk9tOXBxaTVXaXlLVUow?=
 =?utf-8?B?VGFzTnNYSXN3U0k2Sm51NjZ0TmRvMm5FWGxiKzdlTysvazZNQ09hR2M3VDly?=
 =?utf-8?B?N2dXYk83cWVLNWdiN1d4Vm5LMXNEQmJxMDZWdEIxVzliSVhYM2ZacWJkLzFm?=
 =?utf-8?B?T1ljSlh5bkhsQ3VQMzBrZTRIeXlWaW5paVRudFRwemNSNmpCVjRZdlBKaS9o?=
 =?utf-8?B?NkZTcWJxa2pqZVdMZ08vUlRmNlVzOGZDNzYzdXlXQm5LM3JLSjJVM3F3OG5P?=
 =?utf-8?B?Y3R5T09XV1NlZE9ON25Cbkp1TnMzQ3FlYlFsbFp6OHVtbHFpY25GWXlVUEU4?=
 =?utf-8?B?YjZ3bVRjM0tQKytlWkFVQjRaV2lWeUpnZTlkQUsxbmV3WjlseXp4Ly83Um5R?=
 =?utf-8?B?bDc5Ynhyb0FVU2JVY3hvbFp2ZFZ5cmRUU1RJM0JtbU83Qy9Gc3VHOGMyVDcr?=
 =?utf-8?B?Z2hQTjBRRzdEbXQ2eldlM2duOCtOaEluQmdEMTFVcnJkNWRtTkJLS1FMVHIw?=
 =?utf-8?B?N1E0UVBLM3BNaUJoc0xWTFArZmNVWDYwdkJSd203MUN2a0R0SUlaeUFpdGZh?=
 =?utf-8?Q?kLwYdkuhSdGqV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0xtMHFzS0s4cXlNT1Qxb25IZkg4elJ6L2VybTdNS1BFZHFlZzFrclE3UnVm?=
 =?utf-8?B?T2gwRXBrSU9tcFRzL1pscWhibDdJUVRXckpaNDUyWUhxUUR3amk1cFRyWFBH?=
 =?utf-8?B?L1dEczJacW15WlV5QU1QcmkxUHd3UUFFZW5lYWhaNkg2RlhHTkVNTmlmYm1y?=
 =?utf-8?B?bHZQOGRmSDFSdXR5THFnRlIwWC9QR1ZuNlBRdXhkUDBaUUxFVEszaG9lL21t?=
 =?utf-8?B?WGFac0lqWWVQV3psSEhSMkxLK0xLcmpSQVZaUUZ5TkduZjdOcGpUcUhNeWtm?=
 =?utf-8?B?anMyMm82eWJaOEVqN0w4c2FtbzNBeXZQN3NJeWtvemJ0ZmtkUzJrRHhFeXJt?=
 =?utf-8?B?WGk5R3FxamZMdkt2NVBuWTVTcFpEOEdPejZSSDAzYTRKRWh1dDFjT2hEaGk1?=
 =?utf-8?B?S1h3RSs5b1hQaWdPUDU5dXV2RjBWWkE3Vk1KVDVxWjJVZ0VDZk1zZ0RaNUx6?=
 =?utf-8?B?T0NpSENVZnI3alg2cjN4NVRyWVhpUUpvMHJzK2JTVm44RW1yYytRRW1SQjRs?=
 =?utf-8?B?cWkzd09FN3dPUDUwTk1BdzNBTFV1eERWS1dLdmFJaml6bUtWS3ErbmlHc21l?=
 =?utf-8?B?V3ZVbmsvbGs2SXBTanhNUDZLZXJoVUNKdUwxaGt4QnpsY3FjdHpialpoS3Qr?=
 =?utf-8?B?UVoyUmIyS3FIOHB4cVZPRDdQeitaOHVBMW53SU9NVVRSV1Y4NllZNkJsSDJU?=
 =?utf-8?B?aExGUHZGRVFiUHYzcDE5SktBdkVJL1VYaVI4MUpuVVFwRWFEUnNlMzlwQXJj?=
 =?utf-8?B?by9WY01TaUpCOUFQVjVZVUx0TTFIckxST1UyVHdXZzdYVVphMFkxUkxYcE12?=
 =?utf-8?B?QjBaTUFDZDJVeG1NQ2NaSW1OREJXcGV3ZVZEd2dHWmpTaXFpRHFrSi9kVjZK?=
 =?utf-8?B?U3Uvdk1PcEFTN2xYdmdiUkhzU3NpWnNnV2hCKzMvZ1hiVHcra3RlNENOWkly?=
 =?utf-8?B?d0RvK1dsZzVYK1QySmljdmlpam9TQ1pkVUZnYlAwczZ0dmxjbzFvdjE0Q1ls?=
 =?utf-8?B?RDdUcXR5Q2c4MCsvRDNnVjFhd2JiYWxBVVRCTlIvQWg2cXF5dUhzQUg0QWJD?=
 =?utf-8?B?TVFVNEdMYlZXdTZta1RnSFh4d2t0c0VSZDNjaUwxeDY5SW52d1VJL3M0Q0Fl?=
 =?utf-8?B?UWQyM214ZXR1SDU4dzlhQVVidGdUd0FpZEYzM3NNNU5lVmVSYWhkUWdkS2Nv?=
 =?utf-8?B?RjR0Ri9ZYktHcVYvdnBHVm85WGpSMjFsZ0FuaDlnakx2M2VNOUJKMFBrOHBr?=
 =?utf-8?B?Mitmakh1b2dqV3ZuczdBRnpNOWZ2RFA4OFNka1hrUkdqUU5wRFhBb1dUTHRy?=
 =?utf-8?B?Q3E3dEY3eGhYWGRTNEV6aFRXaERQdjNmeDB5RTgzQXpNU3ZGSnlzNGFGakVR?=
 =?utf-8?B?eXRlNG0welFGTWdHV3RFNHViU1dNZWw3NzhKdFE0dThlSm9Zb0I5M0VuVWRP?=
 =?utf-8?B?S1ZjQzk0anQwcFQzNFBNaklTeHdLVmh5Q2RQWGlpV3U5cUdjMVJYelhqWGth?=
 =?utf-8?B?VWxSallGRU13QXA5eklMSzFVSjloVmZtTm9QNllMTVRHS0tCVVVlcFBsODFo?=
 =?utf-8?B?dVBYdTEzR2l6eGJkeEJmVnZtVk0xU3c0UGxSazJDalgyMHcyMXI0c0JDQm8w?=
 =?utf-8?B?NWhDb1YyWmFTSk5SQXVhdjQ0UEpGVTVYVzI0S09WSDhIUUVlQmExRkNHQnRH?=
 =?utf-8?B?NENaSGNkUHZGdC93L0JGZVo4TUZkdDBjdUVEc2M5YzhQd0NFTy9JdFViNVBG?=
 =?utf-8?B?bE1jbmFWMDJSY3FUQXlvQk8xbVd1UDNSb0tCdDBRYWUyTGJ1bVBTanZ4cHpo?=
 =?utf-8?B?M1lnai9MaXYvcVpSV2xPTllRcnlkN0dkUEJ1d0ZJd2tWREhQcWh4bVlyTG9r?=
 =?utf-8?B?TzNldVBwV1VUSDh0M2toTHFWbkVNVS80c1J4dkFDK2NJOXVlQUpab2dTamEx?=
 =?utf-8?B?RHRYUUhLbHhqSDRyM2kwdm83MWkxbnZqcElxSWtDbVMyV0hIdmFicTZmRnV6?=
 =?utf-8?B?SlpYYTcrN0hIOGdQcnd2VFl3L2ljMVE2K2UvTWVmaUNrTEF1Wk93elltRVpE?=
 =?utf-8?B?TDdJM25xaUppdlZrUVdVZlgrWnBmU1lnQ0hXdWpIUDNqcUxQeVRZRzdzZ1Zn?=
 =?utf-8?Q?ayDTZFTJrxNvRdbKv5hNo4n4L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3e86b7-5473-4a53-2e72-08dd6b55b8ab
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:30:07.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEvIURBlQWiKJXR8ydM66c6ZzLRF2wmqjwhp8OlGtxBBVSIKSJMcrma64OJ4bxaadHCCSNJmBYWwJjiJ/2Nrzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926

On 3/25/2025 7:04 AM, Mario Limonciello wrote:
> On 3/24/2025 04:58, Dhananjay Ugwekar wrote:
>> On 3/21/2025 7:58 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Dynamic energy performance preference will change the EPP profile
>>> based on whether the machine is running on AC or DC power.
>>>
>>> A notification chain from the power supply core is used to adjust
>>> EPP values on plug in or plug out events.
>>>
>>> For non-server systems:
>>>      * the default EPP for AC mode is `performance`.
>>>      * the default EPP for DC mode is `balance_performance`.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v3->v4:
>>>   * Handle Kconfig not being set
>>>   * Fix dynamic epp default on server
>>> v2-v3:
>>>   * Fix typo in Kconfig
>>> v1->v2:
>>>   * Change defaults to performance (AC) and balance_performance (DC)
>>>   * Default Kconfig to disabled for now
>>>   * Rebase on latest branch
>>> ---
>>>   Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>>   drivers/cpufreq/Kconfig.x86                 |  12 ++
>>>   drivers/cpufreq/amd-pstate.c                | 135 +++++++++++++++++++-
>>>   drivers/cpufreq/amd-pstate.h                |   5 +-
>>>   4 files changed, 161 insertions(+), 9 deletions(-)
>>>
>> [snip]
>>> @@ -1050,6 +1056,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>>       kfree(cpudata);
>>>   }
>>>   +static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
>>> +{
>>> +    struct amd_cpudata *cpudata = policy->driver_data;
>>> +
>>> +    if (power_supply_is_system_supplied())
>>> +        return cpudata->epp_default_ac;
>>> +    else
>>> +        return cpudata->epp_default_dc;
>>> +}
>>> +
>>> +static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>>> +                        unsigned long event, void *data)
>>> +{
>>> +    struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
>>> +    struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
>>
>> For consistency, we should add "if (!policy)" check I think
>>
>>> +    u8 epp;
>>> +    int ret;
>>> +
>>> +    if (event != PSY_EVENT_PROP_CHANGED)
>>> +        return NOTIFY_OK;
>>> +
>>> +    epp = amd_pstate_get_balanced_epp(policy);
>>> +
>>> +    ret = amd_pstate_set_epp(policy, epp);
>>> +    if (ret)
>>> +        pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
>>> +
>>> +    return NOTIFY_OK;
>>> +}
>> [snip]
>>> @@ -1364,6 +1444,32 @@ static ssize_t prefcore_show(struct device *dev,
>>>       return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>>>   }
>>>   +static ssize_t dynamic_epp_show(struct device *dev,
>>> +                struct device_attribute *attr, char *buf)
>>> +{
>>> +    return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
>>> +}
>>> +
>>> +static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
>>> +                 const char *buf, size_t count)
>>> +{
>>> +    bool enabled;
>>> +    int ret;
>>> +
>>> +    ret = kstrtobool(buf, &enabled);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (dynamic_epp == enabled)
>>> +        return -EINVAL;
>>> +
>>> +    /* reinitialize with desired dynamic EPP value */
>>> +    dynamic_epp = enabled;
>>> +    ret = amd_pstate_change_driver_mode(cppc_state);
>>
>> I think implicitly changing the driver mode when we write to dynamic_epp file might lead to some confusions.
> 
> How about only allowing to write dynamic_epp attribute when in active mode already?

Yes, I think we should allow, dynamic_epp only with "active mode + powersave governor". And when user tries 
to enable dynamic_epp in the wrong combination, we should fail, right?

> 
>>
>>> +
>>> +    return ret ? ret : count;
>>> +}
>>> +
>>>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>>>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> 


