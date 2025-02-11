Return-Path: <linux-pm+bounces-21830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1265A30C61
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2EF3A4BC7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A291F1902;
	Tue, 11 Feb 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nIrtyxp0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831E524F;
	Tue, 11 Feb 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278927; cv=fail; b=iUTJ2r8uJl9KYyODiue7DHnHQyS5is/fndEu8yNmAbyjznZYWk3qjyhRhJizoUc+mnsRIJWYTFt9C1kktmZ8DrRMFO/9RV2HUQ2+9GE3yitka5L9jUUiIq5OQ34bnIDIv77zV1GeqYM08QjYMVYKaC4Cv5T3tDoTPo94Zo87Aww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278927; c=relaxed/simple;
	bh=tHrm76fWKfNPdhm9xtASnwfX+IJmXigolv8SZBFooM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G6LIPf7/vnLZPBmtgZxse8NTPyh92zNfvp4d5ZMOOtgOM5W3rm9KAdr+VJLts6VAJ3Q0AuiDUZBePhndMZK0hiyGZ0ZhnJW3iNt2/mOnme8ko1aVaF+YoSK5V2eJ8cWf0sjNdC8XA8nGRrGb/PubuE5eI40Z8HeeboY4jiuPgd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nIrtyxp0; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRLDXyTm1HUQa6Tmq2VTGHZVSK4twtIKQnz9uCm0rDNpQC4+Y6vYrb9IwqvyebpXOx5ektiw8w04KJpMv0qY12iBUEMgXbPAL0xpV/Wa5nEoVArequHv29975bJovxVjI0PIxY8Ejd2BEw6ynfj2EfQfJpG5EMkyi5DF+IVsVQMkF1iHuWYnLWTkoYQDfR+kGlVvWUhif8Ns4UbymlCddnPYcg+XeqzzjSJ5LHyJow9e4nwg0qgXpDA8XdYDUZ8zOLF39luCU+lkJrTpzp/OF/qYskUNAYjViCN3BNkOk0ySbFmfVrR7akTIQmc/i5IuGa0I1w+1x14Uczc+JEUgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aJB2fugUSGsE18bZcmrsSdWQoKSWV+BPpoIv+2DIO0=;
 b=mmfaQVwZVW3eYZ+vSPofBEkc7XXCrlrPykBJzPPUteD+ImyqZpF3ynST0UFaBtCqArx+gaklXPxgXYjwu++Sw8d6EBkk5GbSPSVVdi8i0vNC3j1l897Gwny/tVLRe3rCskxHS8cEpAUfAaig4OdbytKKpNX2d3kxYh1AjnXT6VIUtmIyc+jb/aE4/QBNqPLZppQgR9HKBYkrWs/qCKQypW66fTeQz6Ep+/hmguyQ5M05q6tBmbbCY4NEzUvjIeZjcZAPtxhrukeysF89DyS2VfvF9vdE72Jin9GPCE7oddWERHDXdXiLUS3yJvgu3i1PFKO2gul4N4IZaXTdkvkdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aJB2fugUSGsE18bZcmrsSdWQoKSWV+BPpoIv+2DIO0=;
 b=nIrtyxp0GMA7PIo6g6S8/XGwH05J/n7LrafXW3Pr7eJq+2O239kyqPXWGSZUQ8OL18KKAsHStTFzavj+eXRG/gNI7Jcp97nZbdWbvh0cjLzLsqYREHezUCO1QwzhD+GImENvFSwpt8jjE77tZ4+Q9iMXSt2FyuTwkKOQcnwJsio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 13:02:02 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 13:02:01 +0000
Message-ID: <9c5a60b6-d9ab-470f-9f3a-03f5c872d3de@amd.com>
Date: Tue, 11 Feb 2025 18:31:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] cpufreq/amd-pstate: Update cppc_req_cached for
 shared mem EPP writes
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-11-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-11-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be7e307-b922-46b1-de48-08dd4a9c4685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVVLMUlMcTdCQXgveC9ZRUdXKzVsd3hiakx6b1h4UDFoMkkrSFBsQmpmWCt5?=
 =?utf-8?B?cFg0aFNPMUhndHFndk16dTdwandtckR1LzZzcWZ4Z3czdjZZRk9NZDNJeEhn?=
 =?utf-8?B?Wi9rYTRhb2tWbE1YSFcyR0ZyOVhQUjBTM1JhZWIva0diby9LMXJzdDNRTHV2?=
 =?utf-8?B?NFlPSzRGUzdOVDJUSm9ZMFdZdFIyMkt4MTVZd05vUmpSamtMOWlkcUtIVTF0?=
 =?utf-8?B?R3g2a1ZkL0hsb2Vjc0dWa3czV3NuaWFZa0RmNVhsTFQ3OXJuQlJ5U0g3ZFN4?=
 =?utf-8?B?R2w0aFJNNHlSbDN5cUdyZ2dRdEhsdjEvWUFFNFlCTHA5NXpFMVJkY1k5cWFF?=
 =?utf-8?B?RDREUWx0Z0VQWDQ0YkRJYithZGdwTE5oTHN0anRkY2lNK1Y5bUFnZUFLYzVh?=
 =?utf-8?B?S3lHd2RJbjlpbWljTGRZY09MdzRleVNEcXVNSHpyRDRIaUV6TTRNYjVOVW02?=
 =?utf-8?B?R0pjMEFIdHo4NFQ3OVJhNWZYSkZzcVgrQU9JYUtuSzVmWWxOc010SXM5cC8x?=
 =?utf-8?B?QUVvbFNOUmh5VlFndVRRVlNQeFZtL3ROMU1ta1o3Ym1IWDh6Z3RtU3o2R0lk?=
 =?utf-8?B?dEtPMUxDUWtxSVZiVllKTm45a1JPNFhxNlJIaWY3TG4zcU0zSHVDMUdWVisv?=
 =?utf-8?B?UWFnQm9xZGV5bUlPcTJYTGFhbXArb1EzNkJCYWxudlp3dksyS3NoaHpvUTNz?=
 =?utf-8?B?SHk2MzlBdzBXOVBzdUh3Y2RCRUpLcmxSdzAySzZYaHp1M0VwTS8xYndUTjEv?=
 =?utf-8?B?ZmpJTFBPWlMxMnBlMFBPa29RM2hlemtOMzkvakZMSDVsTVJtbVp1R0pscUh1?=
 =?utf-8?B?Q3Eyb1VhL2NvR2Rwd3RJT1k0S1A5RVpzTlVNL0RFMml4TnNBUkV5K284SzB0?=
 =?utf-8?B?Z0M3dEYvZGM0MWp5cWJrakRWUEt5bFhyaGFUMmtYUWRHUkhWYUNaSFpRL2Q3?=
 =?utf-8?B?VVBlVVAwUFdhSExsd3Fkb0pCOHJLRVFFK0lqdS95cFJQT1U3MUxMeGEyS2Zv?=
 =?utf-8?B?M1A5cWpkeElFbFNQL0Mza3dHK3o1UHFseHd0cGtHVUJ4dHlSalNLZWhoR2hz?=
 =?utf-8?B?ekd4dksyS1VKcWhUS3RVU2x0eTBReEZTa2RORVoxdGNxYXNDTTk5ZGhrL3Y3?=
 =?utf-8?B?MnNleFFrbFFKTnpTdHp1dWNPZnE0NXdBeFY5UzFlbnlwR2krc1hNYlp5dnBu?=
 =?utf-8?B?QVZFVnRoN2JNVFAwaTlBRTJiTkM0MFlhUG1rL05sNFJ0aDJkc1pPOFpmYitq?=
 =?utf-8?B?Sldsa0llQkJ6NjRocGZIVGZnVysrNElUcmw2R2oyNkdXWlUvS3VnS0hOT1lD?=
 =?utf-8?B?N2R0ZWF6cElXUjJuNTRYRlc0MEtGQ2pxMTNRK0ZZZ0RERDIrSS9GdTB6NS9Z?=
 =?utf-8?B?UEthNHB3K29VaDFYWWNmeHpMYktpbHRuUHVNU2lSRWpXdFVSbmRJVVoxczlR?=
 =?utf-8?B?T3VmcU16Vnpkc2tPQ2lXalB3a0R5RE5mYzBQdUNwd1JmQ0RqaEp1bmsyWEJx?=
 =?utf-8?B?cnNEVWZ3OUI1T3kvM2l6RklQSDNLejJsKy9qdW9MZTJ0OVFHK1BvN2xZb29t?=
 =?utf-8?B?a1ZmTHpzZ285cysxb3d2VUZXdlozVXFOTXBGRUVzbElDS2pUY21ZREpSOWtj?=
 =?utf-8?B?TXp5dzhaU0hmN01oK3VodE5ZaWMwZm1JVjM0NFVKbDFnWng2UHRrbk1SeGZS?=
 =?utf-8?B?K2FsNlgxOTBha2FTeGx1RnZ5WXcxazdIZGo2OW4rb0pOcGtMSTc1MU5uL0U2?=
 =?utf-8?B?Tzdabmd6ZDBORWxJdGg3Q3loR29zOVF0S0FmUW5WTnBZV3d1aDYybGtmaUxR?=
 =?utf-8?B?ZU01RUZzNVhIN08veWhlK3h5U0NtWG55MjkwekxjRndrRlpnS0tuU1c4dHRF?=
 =?utf-8?Q?WG4p/Jgs3mVDt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djBhcVFJY0hheWI2aFhaUFQvMExwcTJwakgvUzBsWEdWOTR5TkE3cHhrYnVz?=
 =?utf-8?B?aUlOMzRERHg1WnlLRGNwUmg0Q3E5bWlMZjZqd04rR3U2OGFIWStIbW1wT0J0?=
 =?utf-8?B?RnJIR2VjYUJMWjFwb3ZrcjRhK1NBNlRyNFpOcS9aYzdFYU15U3Q4UHZBUzRY?=
 =?utf-8?B?U28zVFlSbmViZHlwbFdrWko0eWY1eW1XcGhWUlhzNTFsUk1PbWVxdEs4YXQw?=
 =?utf-8?B?NnBucWlLNTBTekZvU0kzSEhtRjhiY0FxeXJuZ2ZuQTk3cnFvcTY2T1Jpc2tI?=
 =?utf-8?B?c2pVWFZNcHYzUzdsdUtOd0RkSTltSzMvV3pTa1JrT3V1YnlxYmUvdDZpdytq?=
 =?utf-8?B?aUI2Z1l3clVVWldTRjVRSmJ5ZzEyTzZydmtrTll2NjJwYUhwaXNTcU9oZStx?=
 =?utf-8?B?VkZIa3hCZU1iTjNReERuUFYvNXlOalFSMGozSE9Rb3VjT2cwMWNEeURiRzNX?=
 =?utf-8?B?eFZBUHVTUHUrNko2N3h2SjBuaWNiWnNHZzlCcVJIZGlyb0JTMHlwS2duMG5N?=
 =?utf-8?B?b09XcHczWnNxU1BERkQ5TWpoaXIvR3FoWWJMRDVMNXJiT0MwYndnMmFCZlF4?=
 =?utf-8?B?SldRQ2h2TGRPUzZIRXczb2VsZ2RPZVhqNjZiRGtMTGRSQmZneEZiZ3BOUS9Y?=
 =?utf-8?B?R2JLMHNzZ0JVOUk5bVYyRnQ0RWk4RExvOGlXNFJiMW5PckhnSmtDaUNiOWFW?=
 =?utf-8?B?WTF6V2ZaM09DNms0QUNEbkhpZVFVNzdBVzZoeU4vVXJOdEdtMnlWTCt2Y1Q4?=
 =?utf-8?B?c3lhTk5GeVRPd2U1YzNQdWVtSDgrRzZNcEJIZmlpMUFDY1ZvTHNjZ3RKRzA5?=
 =?utf-8?B?SVdpRS9ISDJRVGQ5ajZzMGlQVjVMcUV5RUZnWHNjTDYvZ0cwZ2hqYmhQYzcw?=
 =?utf-8?B?WnkwWXdrWjhzSU1DeEY4VXoxQmYvMk5tZVhBMWtKUlNFcmxPcnEvUGhaeWhl?=
 =?utf-8?B?cUM2eUFDODM3cnhjNXpNOTVSWVR4bjF6djhtVXFVSmJSSDYzdmpJNzRTRzBy?=
 =?utf-8?B?R3pRSlZPZVdja3crK2VIZmN6MG10czlSUmwyWVVOU2xUVlBVWG52WVVsMlBn?=
 =?utf-8?B?MHFUTWFLeHNiUXpoOHJ5REFkQ2s2RnZXVWgwa1ZZL1FqVWM3TGpNUzNTOVNI?=
 =?utf-8?B?bWlSRmlUT1RkUnl2MFNIVnRlVkZlbXI2bmdENVBET3lqaVR0SXdTcmNHTU0w?=
 =?utf-8?B?QVZyU2E2R1pVNTBmaGt5enQyVjd0RlVVR1EzRkxKQ0RJRGc5WDhlTndkU1BE?=
 =?utf-8?B?WjZ3cDc2ME9xUWhCZEVZK1lrSisyK050dXdMUmtpODlIMUZ5WnI5MGJYek8x?=
 =?utf-8?B?WTlsdWFvZis1VTB6MEVJWVhrTjB5bU5qSEpMZTJEY2tZalBSc1FsbXBlOEd3?=
 =?utf-8?B?a2JmRnFaWlNDOEc3QXdKTE81Zys3WTBrQWZLd042bTFzUjY0Z0szcWFMTzJU?=
 =?utf-8?B?Q1l5eXJZU0daQjZkYTNFdHU2VFVqajN5M1pFa2tTMDVDSTBlcGVzaUJFSnFF?=
 =?utf-8?B?WWMrMEFadXNlSWVvUDFwRy9VSU1wUUpnc29IeVgyUVNubys0NFhBckNEZkdi?=
 =?utf-8?B?MFVNVldmK2pFczdrTTVNcmNsMU9NMUs4Q0NyblZYTGt4czVQYTFkZDVDQ1By?=
 =?utf-8?B?QTNEdVU5anlWcTlpaEUrVjM4ajJSeDY3bUdtdnM5NWxSdTNrcWo4M0s4cTQ5?=
 =?utf-8?B?Z0EwT2dENFNobEVyUnNZcXFaNnl3SkxqOWFyZllWaW1uR2E0ZDhXd2tKNkVM?=
 =?utf-8?B?TXRqYVJBY2pwbGxETUUxaFdvNDVqL1NkRmo0UmFTMm93QVdQQ2pIQ2VnVTAv?=
 =?utf-8?B?TUxrUjdSQ1RCNFhQS1pKM29DMlBMcnhZYWN4c1FVQkYxaHkxeENpL1QyUWJI?=
 =?utf-8?B?czM0bGxlSHgwUGtMWnI3NXhYT0ZnYW1penRXaDh5NjB5c0pxeklNMG05TkI5?=
 =?utf-8?B?TmtMeEFBbi9hT3VLdlpzVnFqMCtvc2VUak9hNktYQ25FS2lEUFNyUnoydjh3?=
 =?utf-8?B?YVBrbmN6K2p1dUwyVE14aC9KV3VHKzM3cndwQ0tTRmpJbE1NVGVkMWZMcTZU?=
 =?utf-8?B?LzRpb3dzU3Y1VjdsTGY0blhVQzhHUWdJQXlLQkVmdW1IUnRJbTB2TFdqWWF5?=
 =?utf-8?Q?zvOm0dIC99pt6xGxdreM9EEcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be7e307-b922-46b1-de48-08dd4a9c4685
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:02:01.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpti1iY5bPLOsKrqbJRVpdtmhA8NjqH9yRtocV7lybiGEWGblyCQoKa/YAljR+vH9SjazD2BnqJY6XT7QwQgZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On EPP only writes update the cached variable so that the min/max
> performance controls don't need to be updated again.

Looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e66ccfce5893f..754f2d606b371 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -338,6 +338,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value;
>  	int ret;
>  
>  	lockdep_assert_held(&cpudata->lock);
> @@ -366,6 +367,11 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	}
>  	WRITE_ONCE(cpudata->epp_cached, epp);
>  
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +	value &= ~AMD_CPPC_EPP_PERF_MASK;
> +	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
>  	return ret;
>  }
>  


