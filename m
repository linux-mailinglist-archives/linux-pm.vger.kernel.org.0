Return-Path: <linux-pm+bounces-12905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D811095FAA9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AE6B20EF5
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5F19A2B7;
	Mon, 26 Aug 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x4ZiUrQp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8A19AD9E
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704113; cv=fail; b=k7wr1WGxQHzmvnMLJxwFOLXsXHywwVvqDyZmCK+h4chX8njSMJXOdVRea5tnKDRzP3oEULlNKNGRjGXqekv0UnyvnP9wLszhd3ssRwqQoCDaCwvfrtxdLeDsB2dqhy3sBGxTcZQr3EvumgDYNe57KN4xxoBigO4GMoW5kloUqHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704113; c=relaxed/simple;
	bh=EDcVpjFaUkqzNVFvPZ1Rn2lftH5DTRr6a3eI8t6AEoY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=hVE1Iodt6omrbb/ONIOVJBV9bWpoD+0+dp9b9MLT2xepbWTWZAaqtNBRsxJl2wvFs5aPzGW7ujYqPk+HCrC1eq4ByVnUFuZ77scSjMYvNqKg2v4WdXuRsDLUVuPjxr1WL3vXvW/zcjPUHf65fBy4aZtw9aRutuoz4y2owJ/qOmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x4ZiUrQp; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLPgDFQd5i4WPB6A+/QlISvYcf8otQKfxUilMlAlYFnphh8GP7Enzo283cvRxNNtYxe8THzFGlmDUtH5rw7t6cOCjXYoplCzCLjBxbwehify6csGJmNRgs++H1YiocyMWIn6iIwfA2qgc18xutsAJcswA+jpFPsEUv0rCZf2eaLu8LAeEutgnIhZBi5fjzL1MslKbeamVbEd2H5ZSXbAcY+SxKOj1StStawfpSGfNof4VK84wp94JMobDLxepzuWTfXPDZwXR2389hBk73XW0cEq+fmhiO3WKbIkD+SzBZ5SHQJz95gxImvBGNT0kpDfpgJMfgKaMFmInVUWQmcWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jKsUgVOUQB+Sk71p5f8OxyrwtjYlxMHdybuPGxuqTg=;
 b=bRyQIx3ulQKIYbv/xb4wLUBbSmFzkMO/9ZsaOwvk8cC7S/lfOHk0/eWPCuiT/vLpdAw1haJ/TcsxqztzqvBtObxeZ5lT7Y0ZHb4+CHSWN62IiLuysT4ExlEMYnNQ7U/TrMbiKXzE4MdfkKS8n/ViGFKKdPdV27l1k6ARAIYLyb218BddW+sfsSPZNZVvt9B8BG+Jh7FZ1uWY8BaEu0yHwutl3p8kyfjxuOKJC5O1FJCsFtCvF9tbmU1bsKnI3ibIpS9syXMnyvtz4LKwR+D6JRmVaRc1U1e4XTgHsT/7d6DcrnGjIlEjGbf4zasDKJQBtqrAoycQUE91rti0IQD41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jKsUgVOUQB+Sk71p5f8OxyrwtjYlxMHdybuPGxuqTg=;
 b=x4ZiUrQpNBpEafrxnMSly818h1DZk3gEA62lVdLXrQZ2oipvcbYTES6Q1YgdyOz6JWnYbEMVK/iW+ki7LoOfTQkgaGpA1NQeEWskQoMs1zlB1gRScozEeszQMAgThOgG8ADbX5PtvBtGNhA4ZGz6IT8WcvQvbQx+mMAPYQk7UrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 20:28:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Mon, 26 Aug 2024
 20:28:28 +0000
Message-ID: <d6e8ce59-4139-4832-ab8e-133181d0c874@amd.com>
Date: Mon, 26 Aug 2024 15:28:26 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: amd-pstate fixes for 6.11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:806:d0::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8510c6-1e6f-4352-d7b6-08dcc60da4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHlkU25neUV5Z2xwMkhiNk5TV0NYeXFyMURDVzU4c29vb3U2ME9CMDV6YXRq?=
 =?utf-8?B?TUt2QTRyMERjdlJZbEdhSkxTTk9pRmtyZ0ZiUzNDNEIrdHBVNmRXVWZsZkdJ?=
 =?utf-8?B?SDFPN2pxWWNNY25qcE1oOFNnanpXdXl0RkFVL0k4dHdiSmlLQ2xDN2FVeG9R?=
 =?utf-8?B?TmlNTkhuOXcxTUd1WXlxaDR3VjFHRHlMYzNFb0ZXb1VDNkZHc0hUcWN2WWtz?=
 =?utf-8?B?enU4b2RQUGUraXdwakk5aDQ1V01MZzhjUmx4VEIza2M1OGY0S2VYVFZlUHVB?=
 =?utf-8?B?WHE5YXpxUVdzVjgrWWtRRkdyQ1oxQWlHN3BwbjBFRTMrN2djK3FicHZHNlhh?=
 =?utf-8?B?bmFoR1pNdjFIVjJmamtWVzAxVkdFckwxcTlRQ2RjcHBsUW15Sm01a2Z2RElq?=
 =?utf-8?B?QnVWSWUwa1YrM01YbjBmSHdDak1aVFlWMEs0cy9LVm9MblR0VXN3TmRpRlo0?=
 =?utf-8?B?bHBaelBhQ3l3MHgzYTFmb2NQaUNpYTFXS1R0cmFpMHI2dmQ0MGVITVFrUHgx?=
 =?utf-8?B?djRMamtxNHpwN0k0dmVmdlBTbXNPSEV3cDV5YlNjbm90ek5mMFNnYkJZVUhV?=
 =?utf-8?B?N0lDTTVGdDNNekppa2pzMk1YdUpQdlpialpmVFMyOEJEQ3hSUTN4dWpOblNr?=
 =?utf-8?B?NUhRTVFKamhCRlJjbUlaa2lqRDdRU0lBK0RSUUNLblh5NVlseElFbndEL2F4?=
 =?utf-8?B?YnNjQkxYWTZUdEJmSG16RXM3bWJ3TGI1VUhobDczaGFRdTVrTmhzSDNvRFJV?=
 =?utf-8?B?ZWs4ellIYWkvdDFnV3hHVlgvc1oxcVd3TmxZWGhVc1B1NWVPMUlyY0VFbGwz?=
 =?utf-8?B?RW5ObkxwR0REVEUyRXlybXhRWUhaM0JRMDdsOVRNRnlqOHo4NklHYXRjWVpX?=
 =?utf-8?B?dmpyNDVHRTk2UkZTTnZtYXNZeFl2SWJhSnlqZ0lEME8vdTBuV1ptaW5IZ3py?=
 =?utf-8?B?UnVPejlPRW5ZN0JVQ0pPL0lzUmtCL05tN2J6cDB5WlJYd2UvZFUvQmJJV3E1?=
 =?utf-8?B?UEJYTXdjalZwVHJWWUlJVFRLZzNYMkpRdjBWQjI5alo5VGp0WXRRa3B0RXJh?=
 =?utf-8?B?dlRvSnpqK283eFZFSlROZW9uOWZtc29kMmtmeVFJWGFGbHZza3dTTGd5UHI2?=
 =?utf-8?B?eUs1ejY4bHREbWdrd0VyOGh2RHc3cGU2aHZlSHRlRS9EK3cvNzJZYXRjM3lN?=
 =?utf-8?B?SEpzM0k1U2tVYmg4czVJRnVXeVdaQmZNaUJMQ1dDYnY0SkFpYkY2NHZOS0l2?=
 =?utf-8?B?N2QyekN0NFBJQ05zTGliaExRVnE1aUFzUGpzMk1SZHZMV0EwNVhpbXp3b25r?=
 =?utf-8?B?OER0K0FEeFV4Qml6UUZQVXFMSC9vVFdEYUZUeGlBeU1yZHI0dzk3OENUSnVB?=
 =?utf-8?B?ZjhKSW9ONjlmM0h4WTRFRWlKT2xyVUZ0QmZuaTlYL0JTT3JoZUdEbjI1UUor?=
 =?utf-8?B?aUxIVWk2cEhtTXhTQUY1dFBVbWVzLzZKV1pEYVVoZGZSMy9nOENlL3c1K2xn?=
 =?utf-8?B?YmVjb2NURnUwQ3JWeFpLMHVXT1IyejRXZTVWOWtnOW5sb3lRdzFQczlucVYz?=
 =?utf-8?B?WHpVTU1YRU9OWndpOHkra0NZd3JXQXQ4ZE9JU0NYK2t5SEpjRlZMNkpJekJJ?=
 =?utf-8?B?Sm9QbkZCd202V2VQVDUydmpCcW1OT1NmRzdQelpFcDdEbFZCU3VpZVJlQndU?=
 =?utf-8?B?eTZmWDE0UTA4cGpIVjl2Y0FEbDdPVkQyTTFwUjdpNEZNeEdJNG1xTjZISTJ4?=
 =?utf-8?B?Sk1LcmVqUGQzdUZ5Z3lWNGtOQ0V5aU9QYVcxSkpOK1F4bitaemFhMlhiZ3Rx?=
 =?utf-8?B?bUY3cGNZWkJhcGRVcnZvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzF6MGVWSHEzbThTSXErckVhTEVlck8wYVVlY3phMVV3azZoRllIaGZoUWVR?=
 =?utf-8?B?NGk2c29NQ1R1M0hiUUE2VVdUOWU1VHFuNUdienI4Ylcyb29RdUczK1IweVB5?=
 =?utf-8?B?VFFjdjhacFdKZUtXUVQ3cVhNanVHR1JjSzZ0R2VpbzNrS2lCVEpiRWNNUHh5?=
 =?utf-8?B?cVI3SmlYLzdnZGFIRkJzQ2Z5OStPcDhLRU5NY0VUR2IzMi9uMEpMS2ZSamRx?=
 =?utf-8?B?c1JyVnRiOHVud21aekltaHZKclNNTnhpYkVDV00xWWdlS0c2YWU4SEp2dXgw?=
 =?utf-8?B?Sm5JR3dXUFZORDdGaThScEptT0dSYTZFZDBZMzNMWnk4UVR5R2dCSCtqODJC?=
 =?utf-8?B?cWRCZXVPR0E1bHMwWUl2QnpibERBZzAwZjRrM2pXYVY2Rk1Cd3hxZXdPUDJr?=
 =?utf-8?B?UnUrZXF3eXNZNHIwcFgwQkJXTExqV1hZWkdpTVJvKzg2cG1ZZU5BMXIxeXdu?=
 =?utf-8?B?UCtlTnlwS0IwU3VNYlNEYXFmMmZhUVdlNEw5UmZ6YjJsb0FzQTQ2OW54MUZO?=
 =?utf-8?B?K2wyTFpVSHBxalNSUHV3ekMxZUJEeDE3TWxuZXlRejQrUXZoK053UlFqUzVR?=
 =?utf-8?B?aUFUbU5HOXBLcHVoOTNaU3dsSmljL1g3V0k1YTJRY0NSWWhpUkxaQUcwZEw1?=
 =?utf-8?B?blZoUFVERmxvL243Uzk3eFBrUWhuejdIMkFWRjgyNFlnM0pmS2JsMEowR0p3?=
 =?utf-8?B?bFFtSHoyU1ZXRzB5NmYxbnJFWnY3T2tERW5JbVpiU3gxUTVSUTErNG1NeE1x?=
 =?utf-8?B?M1M2OVVHTENWU2krYmlxTkV3ZEtTZHJNMW8ra3RXdG1vYUN1REFHZHR1bUdT?=
 =?utf-8?B?U1h6aG01c3B5SzJ2aWM2RFc2QXFabzJ2aWFjL3dlRmVuK3pJSm5oL1lOT3gz?=
 =?utf-8?B?eDJMWjV3eGsrdSt2WG5FQUJsQ3hJdXNiWUE2SjVDUis3S2xjTE9INVQ3djVL?=
 =?utf-8?B?M3JObEd3UERuN1VtYVo2dTdOWTFlaVdEQjQ5T1o2WlFRTEhrRGxWVGxDbU1s?=
 =?utf-8?B?TWhJaGZnLzNJSDhWVHI1Rk9WbnkxNnM2Y3MzUlhGSFVJdkRMbXB4Z3R4MXJv?=
 =?utf-8?B?Y0FGSS8xdDFDOXBOT0psdUhidkNpbzRjeHplZnJRMm1YQnVkZUQ2RnIrdGlk?=
 =?utf-8?B?bDcxRFdhTzdvM2VpVXArK0RaL0RkVUpxWGdGQUR5WDFWMmRkMFVVbE9Heklh?=
 =?utf-8?B?VVUybTZ3cUpuNlN0b2ZxL3AzbFpyL1VIbk1oMFZEbmdBcGR4T3c5TVc4REli?=
 =?utf-8?B?amdRSlRiL1JFZlN0UUNGRVY1ZjNUY0tPTThhOWxFblhlTnM2Q29SOGlsWEdt?=
 =?utf-8?B?dnFuRU92N29uNUZaT0FTMHpzK3RYa1VTeFo5cWJTc3lhb2JMTlVIanRDQnR0?=
 =?utf-8?B?QncwZm9xTjlGeXh6cjU4Wk82cmkvYlR3TjR1M1FEb0xKZ0pGckFyc3NFTGh5?=
 =?utf-8?B?SW5QSFdEK1lzRVIzU1FKbHBCcjgxV3llVDhKd1dMN2xMaktPZGdRallXaHN0?=
 =?utf-8?B?SUFDUU9GZGNNaXp4TEtUaTAvOXlZaFJFeVI3cWRka2NTbWNSODNPMXJtWUhJ?=
 =?utf-8?B?b3hmWlNMTkdvNUN1VGFUTVdlUC9PTGFPQ1Zxazh2VGU3MnNjUDBwanRNTDFC?=
 =?utf-8?B?T2RGSjBoaXdDK3U5cndGVGQ4N3hCd1VpUXlISC9JUUNibDJCMUNZdS9yTWhF?=
 =?utf-8?B?T0pDdWlxSjlUTG1DY2c0SU9YVEd5aHo2bGdiYkZGaWYzWnoyVEZYenlSNnVJ?=
 =?utf-8?B?YWRCYzRXUUE0QlQ0eERtdkpIdHh3TERHem9DSGhBS3FOclBFVWRCWUg1UDFB?=
 =?utf-8?B?TDl1ckRTRnNLT0RNMHZ6NXBvbERvNDloZitmVzQ5WjczTGJOVUJ5U3R0bHM3?=
 =?utf-8?B?a01sWXRxUURYSER5SUF6SmJPNisrMGM4YU9aWi9wM09BVGdPWitRNDBiR1BG?=
 =?utf-8?B?RzNVdVcyREtPcTBseDJudnJ3VHp3cWNRM0Z4N2p6b09Bc3RraVAranB5dlg4?=
 =?utf-8?B?ejNEWHd2QVJUT1V2SzJzSWNnUXJZRndEbFhVdEJRTkd4TXExNzV4VmdtQ1NI?=
 =?utf-8?B?WnJkckVFcEFkcGxsWndoVTJEVk1DL3Q3a25CeXBERjBtbnB3S1BDMGdsaDFq?=
 =?utf-8?Q?w2ssSU8eKMHXY0/3+mYBhd9c3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8510c6-1e6f-4352-d7b6-08dcc60da4d3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:28:28.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oakbW/AtYlZPgE0jS0zvhOck3eX4VnLtDAuKo+2+c+lyGij62NOYt1rZ2H1C6Xm0EHxzwPDaMwvdjq/mzzOwCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

   Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.11-2024-08-26
 
 
 
                                     for you to fetch changes up to 
9983a9cd4d429dc9ca01770083c4c1f366214b65:

   cpufreq/amd-pstate-ut: Don't check for highest perf matching on 
prefcore (2024-08-23 11:07:58 -0500)

----------------------------------------------------------------
amd-pstate fixes for 6.11-rc
- Fix to unit test coverage
- Fix bug with enabling CPPC on hetero designs
- Fix uninitialized variable
 
 
 
 
----------------------------------------------------------------
Dan Carpenter (1):
       cpufreq: amd-pstate: Fix uninitialized variable in 
amd_pstate_cpu_boost_update()

Gautham R. Shenoy (1):
       cpufreq/amd-pstate: Use topology_logical_package_id() instead of 
logical_die_id()

Mario Limonciello (1):
       cpufreq/amd-pstate-ut: Don't check for highest perf matching on 
prefcore

  drivers/cpufreq/amd-pstate-ut.c | 13 ++++++++-----
  drivers/cpufreq/amd-pstate.c    |  4 ++--
  2 files changed, 10 insertions(+), 7 deletions(-)

