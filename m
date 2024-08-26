Return-Path: <linux-pm+bounces-12904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B921C95FA7B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E398AB2099A
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C318D64D;
	Mon, 26 Aug 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUoqJzL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702966F2E0
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703427; cv=fail; b=Q8VwtPvcmPbVrvKLODFQSKTxBYYo+L9bMpNkZv3xsi/9Ebdr4k4nqwf10ImPbB1eoAJoGqtTanaQcZjNVVMfuNUoX5jyOROnmR8V8XKq8AfOdVZjzWW+BeEy10y+tzuGeOM2N9yQqATywWj8UhBbaWFoZpVommbtS5Tbrk9GYuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703427; c=relaxed/simple;
	bh=B2i8iSTF1JaGPia7W2v1t4oCddCjrlofAz/jxl2ABVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o4UUFI0mtNeBmFNCUK8Zj8toDys6uCQSzn3GRPQ+XX1X3sw9L1DAKR45ItoSkhez1GAIoXRWwjP8jLnsKesydoBo6m7RMQje4Ii73MLIGznhiJp8Ig7vfqbFMyuzDeKFQRjGybZFvxYGAM1URvSa3X6eJj/U6y8axgtNT0DWTpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yUoqJzL+; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRzmtZ0T2GAdQIHnC8QZW/lKgqpqWdq593Ol7nX1rAwDjtGJ0bOqvUKHpLqITF+/QaeD/TSXdQwaZtOm3FqTnhzGQ5AomIj5NaR7R3GOiChVrtwWhM84vyzdfsl7984RwqRdKr8qyU9j12GbLpZ7zAPcDjIWiRD97YwTq5bi8IylsWNoXf1h6g6dEsS8F5AGBO+WzwavQsLOa6M/ODbFcHG/D53s4cA/zFPEE8d4jmRPIgA1wKk1tQsxNuoT6Nimu67btX3DEXX0LCMhkf3JEZh78hvHaPL7wsIJz9wv8rSrBQbZr5AoLlNQBtvVDAD0k0xYEyRwkoIJxCOEeZ3maQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g66ErFmTXn9TvIhM+yWQjTHFqO9K5hjq3K4hw4U5VU=;
 b=kz4kfN6B6gIyX/Tb4W7GIX9VEwS/xhx7vlem81cYg/dn+tr8JQc5a32BAxlhAPnVaiIiFQ3u9iaggjB5j/EBgYgDAHEiHnbCX6MOZ3aPuAIspzGQCQlicNV1Ymc5iDZ8tDloSOMngtqIt4YS88bU4zwfT9C0OgwV+EthYswETgm3PIpgrK0PAMoylN9q8PtUqjH33bvu0TowG+FpS0XffzBbuAsoi6/S18tvhncigaZJOIfAoF2rZoO9FBjw+pi/rz7r00VisFXXySXpQFERHReFnKuDPO035eHJ8jb3gpuBZvHvrdJLrBSokA0GbLeDdGFtGHuwEa1FwdjfX9GYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g66ErFmTXn9TvIhM+yWQjTHFqO9K5hjq3K4hw4U5VU=;
 b=yUoqJzL+R6LsYeh2xjwO0jIgqcOvtRUyfhF8dHGcgdNVq0yQf+kbZAupFSVgZXTD3cDaLpb/0UN1sPdy9zDwKnfUthHNvoJCXmUMp7sHmeo5Z+rQLvE3iFnmuXTmCjPQa7OoTyGoI6jZC37UqCQkmodZH3ewpDbeYYH2hWQ24X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 20:17:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Mon, 26 Aug 2024
 20:17:02 +0000
Message-ID: <51239c60-75f9-4f95-a084-87aad0d0959b@amd.com>
Date: Mon, 26 Aug 2024 15:16:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Optimize the
 pm_debug_messages_should_print() condition
To: Xiong Xin <xiongxin@kylinos.cn>, rafael@kernel.org, len.brown@intel.com,
 pavel@ucw.cz
Cc: linux-pm@vger.kernel.org
References: <20240805091509.91362-1-xiongxin@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240805091509.91362-1-xiongxin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 01005a2b-442b-43b7-1d63-08dcc60c0bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUpnZGI0UDNTUS83TFg4aHVCNFdtMjJndk9vL0luOS9YN2ZaU0RvSlZIU01O?=
 =?utf-8?B?Y2RrV21YQmRzY3hGcThpbk1PcW1LKzArWWtsRFVSL2FGY21MMUFhZFNxa0JU?=
 =?utf-8?B?Y0h1eEhrYnJSM0xJRE5oaDlKQXJKV2NlNDhaQzh5YjhlREJGemNrTExaYkhq?=
 =?utf-8?B?WW9JTktsQTVCelBtUnp2U2FXbkpmeXRaeitYR2VqSHJkc1pXLzNzWHA3S2RL?=
 =?utf-8?B?N2o2MkdFZEVGbjIxT1hNSld6eGo1QkZ1UHBleWVmYkRtbFlacmI5TVIvWUFB?=
 =?utf-8?B?eHcrYWxPZHY5YXBDdUN5Mm15MDBHcWJVOVVPZkhDNkJ2L3hTVkdFV3pZRjdP?=
 =?utf-8?B?NXljem1EcHo3eDlpa2dwNkNJWlBEdGVtN1Y2ZkxhcVRtaHlaNGk3SzZnb1VD?=
 =?utf-8?B?bGFaNXFYN0JrZlpzMnNQMDZpR2tVQ2dBb0g1cVQzeENMY2xiSDV0OFRpVW1X?=
 =?utf-8?B?eHVoeDRtRzFjNG1SL0VXU2ZsZCsxRExON2wvTjdUS3BHTVdLZ29lQ1U5SVJR?=
 =?utf-8?B?cXdYaitNWG5GVlNMNzhiNWcwUVcvZmh4WU9UZXhjR0pONE5MSE9qV0xvWEFM?=
 =?utf-8?B?WjY5eUxjRy9jTk8wQm1JbWdTWlNJUlMyYUp3RUZxWjJjbUM0RHFSMFRwbXJQ?=
 =?utf-8?B?SWZhc2tFZ2lyL2lINjVJVE11RTBORHhnbGNlZjQrVHVIamozVGF3a1BIK1oz?=
 =?utf-8?B?aGltNGF3RHJuTGlrK3F2M1U4UW9Ya1dqM0JESnRZL3ZkUENoRkJJM0dYTms3?=
 =?utf-8?B?U24rWlByVFFyRTNwR3VZN2YyNW1NUHlWNmhZaW5vMkdLNTRkM1RHTWZ0Tllv?=
 =?utf-8?B?enY0MEV2K1dGaXJWcHJYeVZPekxzYlRGbGpsc1E1ekZBUzN1VFJBcHN3MjAr?=
 =?utf-8?B?b2dYUUZDL3pjOGtXamF6WUNUYUVObDhIbFhjSHhzT01tLzBTN0tTNWQ4NWd4?=
 =?utf-8?B?QnBXOVhmR2VibWJFOG82SUZEbzhLRTU1L1NKQzNzWEpMaUcvcjhuWEg0cVpu?=
 =?utf-8?B?M01HRGJHbmJ1cHpnLzRjeWZJdzJTWVhOaW5pT0N0TWpGbmtWYXFzUGhjZ2NW?=
 =?utf-8?B?b0thMk13Ym5Fdlk1VW8zS0RORGRvbzY2MmhsZCt2cmQ5aVNBdkd4RWlXZUpl?=
 =?utf-8?B?aWsySEkva2lWeTdEbTVFTXMyVlR6WDVkL3huakhwQmZSY2doR21iRTFkM0pz?=
 =?utf-8?B?ZGRGUTU3YzlCek9BcXFqM2ZIWUJiYU9QRTltTnRXTDZpdEczTUpqN2pvaVJO?=
 =?utf-8?B?V0ZpZjkwYWtoL2QyZFk3dGJVanRyZWJKeHNlNmZ4QU9ZQjBYMWhxTVdmczMx?=
 =?utf-8?B?OENLaW10aS9yMWIrVktYTW53eVlmRElOemxaQVpqcTBtOXpmRzlVeTh0S1lt?=
 =?utf-8?B?elorWFZLM3dTTStNSHNVejY0MDRXcWdMV2E5YTQySkcyODFUbEc4cUJwSE11?=
 =?utf-8?B?RlY3aW1QUkUzMS9oUllrWnRoWE1ESkhiMm82UzlqWXdKcTYxNkJlNU8zVXlz?=
 =?utf-8?B?VU1yNDBDVXRmV1hqRGlHQTg4emtvTm9aVGVoN0pkZUpqUFIzZ2JwOGhzMTZT?=
 =?utf-8?B?enZuR1cva0owK0ZFYzJSRjZ1K29SdG00Sjh6SW5kazIrckhtU2hvVjhWVW9I?=
 =?utf-8?B?ZG9paGp0aG5Qckg2VkZCT2dWQTZzZURHb2pJTDc2YUlZN0s4ZndMR0FhQUtC?=
 =?utf-8?B?QWo2NDNOUWtqdTB2cktFeXBHUy9SQ0xqRXhjT2dMaTFDYjBzeXFUVjR6SG9x?=
 =?utf-8?B?Ujh6WmMxN2RhTXA4azNmdUN5VUZPZ09Qd0pOMEZGaEpLRlBtakhZRTE2b0JG?=
 =?utf-8?B?MUFWUlRXMjlrT2daYUdwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2JlMVJZTTBMV3RhaFhITDlPNEdCTkF3c2ZQTG5nSERvaFU0L1g3S2xPMFNH?=
 =?utf-8?B?US9CREVEekRFVWZrbWNYUXZxc0Y1Wlk3MXc0dnNvQ3pFVDEzcE5sd2lEY3cy?=
 =?utf-8?B?Qi9tU21NNTNDOG9LVTEwWGVsSmZ4Tk45eFk4QVBZSXFFZnE1aThUV3NzYXdq?=
 =?utf-8?B?YXdGTU9FZ3pTMStTZmsxRy95VFgvTEpJaFpDcTAzcjB5NS9wTFZOemdPY29F?=
 =?utf-8?B?bXpRdHNrNEQybWZkSXptaFdKa2x6NWZvY0dEL2hhcllrT2R5d1J3NmV4d1dv?=
 =?utf-8?B?ekZZRnpGaGJlak5xdVY0cnZTRUQ3YlVaeVJMNktuUGVSU3M1bnNqV3hsTUl6?=
 =?utf-8?B?VkVLUnU5M0QzaXhPRjM5T2QyV3c2OVVVSFBCR3VUWjhDQTRmOUtKRUx0cVlO?=
 =?utf-8?B?WDMzUnhKN0RrWnp3MlY2S2hCQTRTZklVTWhGdWJlTkpHTmhXNXdlcThrd3hF?=
 =?utf-8?B?VnJIeUtNYytkdHk2MDJrM3EzdzBsQTQwaENOaWVCVUU3VXJPSnBET2xvVEZX?=
 =?utf-8?B?ampxbjYzLzl3clY0VWh4dkhuUThwdlFyUEI2REJ0eHdDYTY2Zlg5dUlYMUZ4?=
 =?utf-8?B?bWlQd0ZmZ2luaU5XZzZ2MjY1RUNkWHpMMWpJeTlSRlBOQzZxZmVnTUU2K1Rk?=
 =?utf-8?B?NHV5ZHdHalBXbkJqZlNOZk4rSm9BWllwNGptdXlmY0owZW5JRUttaXd1VXhz?=
 =?utf-8?B?V3lFUkFsNy9HbjlFa1haQmdEU24xcTZpR3BvWGF0Zks2bSttUTQvdVdIbkhY?=
 =?utf-8?B?SFlzaDRMaDVoWkhHeE41RE5sY0NraHJlK1BjS3phTjdqZHVvaThWaTVDUmVu?=
 =?utf-8?B?dkVwenhyYWxkcWpMN0U5cHRJaWI0ZHQzdXNpWUNpNDFLQkRJYmZnVGNjMURz?=
 =?utf-8?B?UnNYaHR5THFOS1ZYRVdGRXBHWjVXSVpvV1lvSzIwcDFINkIyRnlsOGNvN2pq?=
 =?utf-8?B?cEJtVTZwbENyNGxKN3F0NEloOTlvYUY5anVLd2tYbWp3aVI3RHo4SHlweFRh?=
 =?utf-8?B?ZkFDOHh1VHBQT1l6UkxhZzI5clRqdWJSQzkrQXJwRWx2OThJaXhBM2hScmFY?=
 =?utf-8?B?dStybFNoTi9rL1QvVnl5Q1NOaElVMFMwUlBkSUdKdHJBZ3d2TFIwblNsMjFy?=
 =?utf-8?B?aGVsSFp5d1M5ZDFzOHBFZmx5RjFTVTBRRWk3TGhCWTBsYkg0Q2dLVjNOVjlY?=
 =?utf-8?B?ZFZRbXg2QVcrRzNpeCsrRFdoMk5qdkkzNUxqbTExSEdjd1dMa3FhYmwyeGk3?=
 =?utf-8?B?OWdwMGo0YTdBRGw5SHNHbUpGRVAxTnViOTRneHdSUnZpbjRkQ3J5TjJ6QTJh?=
 =?utf-8?B?VnZSaS9PRWgwMHpaZHZJa2U1dEoxVlBPajZnaGpFRXVpcm4wT2ZiVW8yUHI4?=
 =?utf-8?B?QVJWTEdUK29wNnFPNUdlS0ZFVGFoUEtuZ3Jsa0IvQitwc3M5TEd2S3hMZVJj?=
 =?utf-8?B?N3EvNklTNHZNcUFLTCtqNzJLbE9sNkRFenJJS2RSbWhOejZEQmlNM01Dd0du?=
 =?utf-8?B?cEZHb21RaVcrWG9hMURRc3B0eWIwRkxNdmpqTUVMM1NKYit1azhMYzFGanda?=
 =?utf-8?B?akJMaTF0ZnF2dVlnT3lBNVFqdlBxRWY4dWhSQWxCQi91dUpyaGxWS2Rzc1Jy?=
 =?utf-8?B?bHZDR1VhL2lXUXdaWks0S1VaVjFRUVQ0Q1REdWdybXZRd2l2ZzBwcGJpdDla?=
 =?utf-8?B?dG00L3N3WTl0RkwwdUZzSkxGVUlDNEdZNGRzTjFKUEpJUnp4RzduendoalJK?=
 =?utf-8?B?V1RzMlBVTXNJazZBRmNBWGZDcmNGZTVhRDZhaE1PeUlsMjlNdkRCWXJuYlNN?=
 =?utf-8?B?MW1vSEQyS29JbUxlcFpQcUVDV2lHdzF5VTR3d2lCaTNmaDU0elg1ajZRMkN0?=
 =?utf-8?B?Nm5NMXA1cTBIWW9tNThHbXdMYU1IWk9GbGlDYXgrTjI4YTVsVTUzTUpRdzNF?=
 =?utf-8?B?R2UxMEdma3lhZ3hwUkI2NUZWNkJ6RGxTRWVNaGtGM1Z6TTF4SEFaVXppZHFz?=
 =?utf-8?B?Q3RZK01kMzdYQXIrTm9hc3Q0Z1RydHVkNEhLSWRsUnpBRzhubk1sT2xuQXR6?=
 =?utf-8?B?VVo0ZFlScGttUk4rQnhpRlpHVDl2dUtMTjMxbDhBZlRwTGlaVjdqT3VoL2po?=
 =?utf-8?Q?gSo6D8EfsvBbrZ+mQPb096s2T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01005a2b-442b-43b7-1d63-08dcc60c0bd7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:17:02.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: labp6WDdRygQTtyxgDu5q1aXh0r1Vr53a2pTMtaFzmb2OfM/N594S26HDdmO84qT9EbdP5LWuiAk8eiNITR+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

On 8/5/2024 04:15, Xiong Xin wrote:
> pm_pr_dbg() is useful when debugging suspend and hibernate. commit
> cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at
> suspend/resume") using pm_suspend_target_state to limits the output
> range of pm_pr_dbg(), causes the original pm_pr_dbg() output range to
> change.
> 
> In the suspend process, pm_pr_dbg() is called before setting
> pm_suspend_target_state. As a result, this part of the log cannot be
> output.
> 
> pm_pr_dbg() also outputs debug logs for hibernate, but
> pm_suspend_target_state is not set, resulting in hibernate debug logs
> can only be output through dynamic debug, which is very inconvenient.
> 
> Expand the scope of the state variable in state_store() and add judgment
> on it in pm_debug_messages_should_print() to extend the debugging output
> of pm_pr_dbg() to suspend and hibernate processes.
> 
> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume").
> Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>

I think this is a good way to help the issue you raised.

There is a minor issue with your commit message cutting off the lines 
reported by checkpatch, but otherwise the code change is reasonable to 
me for the problem.

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit cdb8c100d8a4 
("include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume")'
#7:
pm_pr_dbg() is useful when debugging suspend and hibernate. commit

total: 1 errors, 0 warnings, 51 lines checked

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   kernel/power/main.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index a9e0693aaf69..a376107efbb4 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -559,6 +559,8 @@ late_initcall(pm_debugfs_init);
>   
>   #endif /* CONFIG_PM_SLEEP */
>   
> +static suspend_state_t pm_state = PM_SUSPEND_ON;
> +
>   #ifdef CONFIG_PM_SLEEP_DEBUG
>   /*
>    * pm_print_times: print time taken by devices to suspend and resume.
> @@ -613,7 +615,9 @@ bool pm_debug_messages_on __read_mostly;
>   
>   bool pm_debug_messages_should_print(void)
>   {
> -	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
> +	return pm_debug_messages_on &&
> +	       (pm_suspend_target_state != PM_SUSPEND_ON ||
> +		pm_state != PM_SUSPEND_ON);
>   }
>   EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>   
> @@ -715,7 +719,6 @@ static suspend_state_t decode_state(const char *buf, size_t n)
>   static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
>   			   const char *buf, size_t n)
>   {
> -	suspend_state_t state;
>   	int error;
>   
>   	error = pm_autosleep_lock();
> @@ -727,18 +730,20 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
>   		goto out;
>   	}
>   
> -	state = decode_state(buf, n);
> -	if (state < PM_SUSPEND_MAX) {
> -		if (state == PM_SUSPEND_MEM)
> -			state = mem_sleep_current;
> +	pm_state = decode_state(buf, n);
> +	if (pm_state < PM_SUSPEND_MAX) {
> +		if (pm_state == PM_SUSPEND_MEM)
> +			pm_state = mem_sleep_current;
>   
> -		error = pm_suspend(state);
> -	} else if (state == PM_SUSPEND_MAX) {
> +		error = pm_suspend(pm_state);
> +	} else if (pm_state == PM_SUSPEND_MAX) {
>   		error = hibernate();
>   	} else {
>   		error = -EINVAL;
>   	}
>   
> +	pm_state = PM_SUSPEND_ON;
> +
>    out:
>   	pm_autosleep_unlock();
>   	return error ? error : n;


