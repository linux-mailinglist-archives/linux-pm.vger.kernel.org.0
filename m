Return-Path: <linux-pm+bounces-9617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7690F59C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8BC282C77
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5EE53E24;
	Wed, 19 Jun 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4uNRpWo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22F15667C;
	Wed, 19 Jun 2024 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820005; cv=fail; b=OHzGmjpSSjiXlOHzxKi1JWb/aMLWDhbaTofEZ6l8YN0IxSjfPPFAuKhPUTgGzaapc0FsDxX8V1HKYS6oaVApaiv0MCjqHD5M+XJWc+VzYOuBrAH4rTgDkuajK3NKBo1O3pzrvJ/aso6jiwN/f8vxTgTvnxFgtdNCWsKR684Pvh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820005; c=relaxed/simple;
	bh=1a4eywjkySKn70e+Aovh8lkmYPlV7WhIhcXz7nSrTLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EnYuj8aYKEDTn+pbbtsHwghMSLfOgBcaIqh9jlqhGkt1vAVna5ifwoI4YZPlhymcZr7UyKl0zlmhInTzdLDfUCBZEapj50G/jZF7YdOsMSdWPUoPW1mcp/STs/i/yO2jjVu2Hb8JfT3ENSWauDyJoPj+qPdMLmlEO5XB/R2DWNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4uNRpWo; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBAgmMXo1hsVf66A1Y1j2EhhE5C+1Y30VON2B0h8KtofgWpJ9nSSBJc836ToajnF1gCMrPIiZpw4pVeSEljoQG9aLehu8S8mAcpUBb42T7FKjFjm2MC+VdC5LC6l32VZeYKfq9qqMat+XpulBEHhO+6WFcqjSfaN5GSgwia7ccQYdYBaHCCLVo5dz1ySD4U93mSOLuZlAnWmwZZfD2aevEnkDnnDqmPFvfV5FO5u61CyiPwMRr1Cc2Yw/WY0JJfiJ+IcV+7olHK4HiXERMYWznFvXlhLacxiTp3tzw8pE5ihsQ71LFQC8ANfRlUcIIbV715juOD219qfZFUFb5Yiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=492SlBdsSKUYlsAgveDTff2HogCvROHHKk2kXQSriH8=;
 b=i9rQjoyylC5lfy+QslKP1wcCAXiRxQ5Pva5KrM9Wdo9psPGelGLH7o/ZNzFCpyauP2fJBo8wH3QJlIvWj+5EBYTe1il7faU4PngL6fqc8Uq9iVzO5n2BN7IVsjye0h9ECmT4TXMsF69rDR4V+dq0gs3YkNECJO7Gszd+LGruqXMqLLhvv1v7bprKwhCfLVmhIVvP0uR5vI2bzIEmS6ZY1kviqcFIjqbTCBNOtMNw2NKydSR2rrCBaH2kCQ+fduVPFvATJQPMvyCCxXI38YE6ksz7MOaJGZNmtuKyS93A+NGmHf/CTH1MziLLM9J2XZolIZue+KJrwkp9ETbSSw1UjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=492SlBdsSKUYlsAgveDTff2HogCvROHHKk2kXQSriH8=;
 b=q4uNRpWofM//7qP2bzgO09GdKhbpj0DYwQPtaG9Ru2mPOt0pupRCqD1sSEVZpqUbFmX3n8LpsejWr+WoJCCO75nFHTljBIZriUhWHV8ivK0aiEbpkWkGFhrk0zMYDGXCYW9SE3qqHKXjMkGD2C4XIXz9WkBi6oEgR+Nz1pqwRsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 18:00:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 18:00:01 +0000
Message-ID: <7c5acc3a-5437-4cdf-bf3a-872d075d34b0@amd.com>
Date: Wed, 19 Jun 2024 12:59:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] AMD Pstate Driver Fixes and Improvements
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 gautham.shenoy@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718811234.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cover.1718811234.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: bc37f70e-75f8-4931-74bb-08dc9089a396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkI0WDU1dmZPVitTM3psSElHU2JmREFWMXBuMkFFcTQvN1F0R2ZyNXRQWDgz?=
 =?utf-8?B?VmxZeFlvMCtvbzF4U1VUVW1tOEpSOTFTTzhXcHBFZGNNWjJnTEdZVVJ6UzRs?=
 =?utf-8?B?aURFTDE3aFV5ek9EdW13Y3BZL29wYVNZLzAxTEg5My9DdENhNzNBSWFzTWVI?=
 =?utf-8?B?aUZKKzQvUXZvZG5qNDU5dTE4UVJLbmxmUDdCbUpoODR2YWJKcEh1RzNaaWdI?=
 =?utf-8?B?RVB2ZnRJQ0hFeHlHbXdFN2MvTEFnRHFqWi9seFRPdTZxZHl3c3EycWVoMEpi?=
 =?utf-8?B?cy9xQTlScDB0OXU3OEhVMnhEenRPTDU3V0E1dm1OQzVxYTVDSTkyT00vNjZ6?=
 =?utf-8?B?TDBnRVRDMFpxUU5pcnBJUVE2THRjSGYvQkdPSWdjMkNpeUdRTXZGcjNmSEtt?=
 =?utf-8?B?WkcyNWJnRUFNczhNbm5zNjlLbFV4bU1RWjFVbEJQUlpSaU0zVjFWVDZESVZX?=
 =?utf-8?B?ci9ybTl4UXo2Wk9zVTZzanpPTTRjc0JhdHNuVGsrTUxFZjdYdENhd1pVbzl6?=
 =?utf-8?B?dWtkVVhiVjFYbEVzSS95RVcwQjlUdG53SmhuTjNhMEEzYzlDWS9GM2grTU5j?=
 =?utf-8?B?NHlZWlVKMmsrT3IxUWlzUmZLNU1BR2U3MmhoZHZGWWpVc3l1dEZxcG1oUE1I?=
 =?utf-8?B?amhDOXU3cGh2MW9rdFcyWUc2TUgrWTEyTzF6OTcrbzd1N0UzQ044K3Frc2Y4?=
 =?utf-8?B?L2ZuaHpjMTY5QzhQaXVERVd1bSszZkZpOUYzT3hkbUNGSDRKMjJNaHQwbnl3?=
 =?utf-8?B?VngxREoyOTJKVTd0aXhpb0lXU2todDkyZzc1Q09kQTk5OWdOWWxPZ2M0Wm9s?=
 =?utf-8?B?UzJyMEJhSFhLYlhRRy9FVkNWZWJBdmdLc2RNUlBQSktSOWd1cWpYRzlHanZ6?=
 =?utf-8?B?MThXOGpVMWpQNlV3YnY4MXdERlVUZzBhZmxPcXl3elVRSEEzNzRjWHRnNHN4?=
 =?utf-8?B?UzFFVGxlS3lzVmJEM2p4bnRyZ1lKRDIrTjV1RW1zYmJ3V2Nzd3JOblR2Y3dw?=
 =?utf-8?B?ZWxCSDkybG9HZkVNNVpvMmVvNWM3K3BzUkVsdFdRVVo0QisyYm4rL2RTL1Ns?=
 =?utf-8?B?VlFNcTJBUUdMQ1ArTEZrdUVQNzY0ajBHbUhkN2pxVnBkVlF1SVZ1WWZPbWVB?=
 =?utf-8?B?RzdrRytZRVVwRVlBdjA3ek1OaExyVGY5K08zREZUSXNoOWd5M1J5d3hRUUhC?=
 =?utf-8?B?dm9qMTgxT1gyWnM0TC8yTjg4Z2x2aFc4M0hCZ3dvZldCeXZLak9tMzI3UEhi?=
 =?utf-8?B?ZDc5WUczaEdJWDhZMW5IaWttYllEOU0xWUZWRnRMQTJjd0drcjdvdkx0SEJs?=
 =?utf-8?B?bEg3UnRRaVZONEVEeXBtWTRJZDdLclFRNEY1L0g4WXllY2dDM3NZMXl6Z1RX?=
 =?utf-8?B?YnlpTVh3SkhxMjJIU3cvTkQwQ3k0aEYvUXZ3TDNjdlBYbkxQRHpXZGV0cHZo?=
 =?utf-8?B?VjZaMWFxeW44NXh0b0RTMk0zMzhuTHdMNDVxRXZNUHZuZjlBWlp5ZElXRG9V?=
 =?utf-8?B?V2pyTUlORG9CTjh1MUJPQU55S0dwWmwxQk5IOUdyUmhpTzBFMHcyZ0tSMXlZ?=
 =?utf-8?B?RStOcjNja01xQ0VzelpEa09xajc4QjYweFNOT0h2UEsrNFlNa0J4T0Ryckps?=
 =?utf-8?B?TUwrZ0J1Y0hidVAwWUo5cTNmYTE5UUhyTkNoNEJTd2ZGTUJmaEpXRXpsQjlq?=
 =?utf-8?Q?WOVfiVFSBzYB9Ix7kV3U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFpKRFR0SlJrc1NBZDVRdmV1aWZac25mS3hDaXlmdjVmQXJTZG1nT1M0NGJt?=
 =?utf-8?B?N29CSGxSUDQ4SitLaFJVRTJqWGpIbEYyMkVlckFEdEZLRGI0M3ZyNTRqaWhQ?=
 =?utf-8?B?azRrUitETzRJcENmcjh6ekQvWVFGemtaL05JM01WR1ExelpoeEJBQ2kwTHd2?=
 =?utf-8?B?dnpxSDA0YXU5cjdRRit4bXNzNFY4RG8zbUwwV0s3b1hnbFNUZVY1RlAyK1Vk?=
 =?utf-8?B?ZmI0aVN1akhaMnp5NmVyYWRjdU1LSnE2ajhGK1BBM0ZoKzVaQ1hINUNKL1ZH?=
 =?utf-8?B?S2ZtaW5EOHluK3llUUVkZDd3SGI2Y3M5a0hzeGczSTRVRnRGeiswQWlvalNW?=
 =?utf-8?B?MjErMm54Y1ZRVHY0bTNPR0N1M3JjeDlIYkdrRG1Wem05QkpHa3hmVXZMOFlK?=
 =?utf-8?B?NHdibFljWUJNQ203NkZNUVVON29KbVNRakw3ZE1zSHNONkRGUUdJVWU0SHYw?=
 =?utf-8?B?Sk9neDhIU05xUnFIemNXOGExaTZCTzlCZ2d2R0FzckpKUnZ3TlhoeldiL281?=
 =?utf-8?B?MGthSmNBMUJqa21NRHJCcWFMaTlwVmFuR2pab2lORmcra085b28reVVibXZ6?=
 =?utf-8?B?b0p6ZS9MWHJPRVFmeFgvVXF3Qm1aaUZqSkFrbkVpN3BDTkRFVy9QZk5Sdngz?=
 =?utf-8?B?MHBOT21XVFR0MWo2VjAwSkRzM1RVeGdTaXVpdGNhc3RSQVJISUVvVjRpSFNm?=
 =?utf-8?B?VHM2Q1ByNEFCd2w1TGRrNS9yZ2lCTlNuU094cU1JczJNcEdZZmgrU3c4MWMx?=
 =?utf-8?B?aFFtMzFVNUg1cHNnWlFNYStJOFUwZXNjRExQalBnNSt1SENvOXJuUFBjOHlE?=
 =?utf-8?B?QTBhZlZPYnNUbWVxa3A4OXRFcGdhTVBYT3l6RDMxcDRNV1VrRGpxaFZobm8x?=
 =?utf-8?B?T0F5akZmbG82U3FpZzA4eFAzbGhQbG9JQ2lXS3M5WEQwbU1IUFFaeERrWlg4?=
 =?utf-8?B?eHNXMm9HbXpreElOakdFU1pQRmtGK1BxMGFoTjJQbTNheDhxQ3djYUwxZ0lJ?=
 =?utf-8?B?QjBHTDZpVUMxRitUN0JBUFhpNTV3MVh2NHJGV1hJQjZrcTVVRE9OV2taMkpK?=
 =?utf-8?B?UlUrVTUyUUdSbUZzM1o0N2Z4K2xCZG5sVXlsQktIa2loMUZRSE5NbFowbEJ3?=
 =?utf-8?B?OHZIcEZVU1NHNzRvWmxDaG51ay9DQzNObCtxbCtuZ3FCUm9qWXk2N1RoZVJZ?=
 =?utf-8?B?aS9qRVkzNkJkRXdwNkF5YU00WTBqZGxETzg3Wkk2QXlTSUtLZllnS3FJQ0lo?=
 =?utf-8?B?YmR6M3NlaysvVW5oSlowSlhvYzVOdXQyNkRKWUt0bU9PSEgyeWdOQVNuemwr?=
 =?utf-8?B?WGg1RldjK3ZZTG5oMWpYb3NpbllvdTdSOGZmWTJWSkpJcUpjNGg4bytTamx0?=
 =?utf-8?B?d2JEWG5MU0doTXV6UUZWYmE4V0UzS0lDeVZMZDZjajIvK1loMTlzeU8vZW5u?=
 =?utf-8?B?TkVnS3FIblpkRExoV2hWQy9pT0ZtdTc4bXBhQ1BRRnpaRHpQbml3Ry8rWUtT?=
 =?utf-8?B?K1NjRGRhSFNKNC8yK09lQmRVZnNybjdJQ3J6aTQrL09Lc3crVGFhdWxYZ3NH?=
 =?utf-8?B?Rk53MERESFBZVnQvTENmcW0renM2ZmttUHJKcFh3VFNQOXZGNERzSWJSaU1B?=
 =?utf-8?B?dFgzb0JrRzdRdm5pTUlXVHpVT0VOT0ovYWRFOHBKUUY0U0pTQWg2bGRxdnlv?=
 =?utf-8?B?cXVZV1BYejRYTnMrY1BMVWFyU1lRcmRZMXpDNXNDUkR4S1JqeFhqeTdINDBS?=
 =?utf-8?B?KzdPd1BLS1dYYVNkYVZsMkxZWWticmMvczZDTGttSjBXLzE0MkN5cnBYYUhw?=
 =?utf-8?B?RjdRQXJTZ0NzWkpEYkRlWlZuSzV3bWFaTXpSNW1Xa0hXTG5zYmhqalNkSlY3?=
 =?utf-8?B?aVdZL0xSL0dkK3BLUEJlTTRFc0wwRFZGQXNoUXJzS2V1a3p1b3dFZnM5Uy9q?=
 =?utf-8?B?ZUdQaFpVWEw1VVhRcWFIa0ZxMVhJWE9EeXY2SVV1K2lMbXlrNFZqbG9Sblhq?=
 =?utf-8?B?dFVabTlBK2FKK2k0ekpRLzgzUXBHSEc1elhzUW5FakhOclEvYnJ3SFAxeW5u?=
 =?utf-8?B?YXRDNnZ0SW5BT2hsOXZES1dETkJGTk04Y21CTWQ0bkplNGV4RGJWdWNJWm1M?=
 =?utf-8?Q?vTkF+mrQmZIsLuUlZTPEoMpwX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc37f70e-75f8-4931-74bb-08dc9089a396
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 18:00:01.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6AShsI8NJWIkGfod8LwAQ+iuXqp8kzmKElKZDEjaKGzpYa9tNw1iqPqtQNDfz6o7E8UnGLHshFBe19aAncp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

On 6/19/2024 10:40, Perry Yuan wrote:
> Hello everyone,
> 
> This patchset addresses critical issues and enhances performance settings for CPUs
> with heterogeneous core types in the AMD pstate driver.

The heterogeneous stuff was dropped from the series so this is no longer 
accurate.  However everything else in the series is good now.

I've applied this to my bleeding-edge branch at 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=bleeding-edge 
and will do some more testing on it.  I'll plan to send out a PR next 
week with it to catch 6.11.

Thanks!

> Specifically, it resolves problems related to calculating the highest performance
> and frequency on the latest CPUs with preferred cores.
> Additionally, the patchset includes documentation improvements in amd-pstate.rst,
> offering a comprehensive guide covering topics such as recommended reboot requirements
> during driver switching, debugging procedures for driver loading failures.
> 
> Your feedback and suggestions for improvement are highly appreciated.
> Please review the patches and provide your valuable input.
> 
> Thank you.
> 
> Best regards,
> Perry.
> 
> Changes from V4:
>   * pick all the RB by and ACk by flags from Mario
>   * fix typo for patch #10 in the commit log
>   * improve the commit log for shared memory in patch #11
>   * drop hetero core type patches into another patchset
>   * drop debugging section patch for amd-pstate.rst
> 
> Changes from V3:
>   * add one new patch to enable shared memory type CPPC by default
>   * pick all the RB by and ACk by flags from Mario and Gautham
>   * update the patch #7 PPR link with doc id (Boris & Mario)
>   * fix the highest perf initialization issue with preferred core check
>    for patch #9 (Gautham)
>   * rework return core type and commit log for the patch #9 (Mario)
>   * address feedback for patch #5 for the debugging suggestions.(Mario)
>   * retest the patches on MSR and shared memory type CPPC systems, no regression seen.
> 
> Changes from V2:
>   * pick review by and ack by flags from Mario and Gautham
>   * rebase to latest linux-pm bleeding edge branch
>   * fix driver loading block issue for patch 4, make sure the warning will
>     not abort the driver loading in case there are some new family/model id.
>   * fix the driver loading sequence issue for patch 10, it allows command line
>     and kernel config option together. command line will override kconfig option.
>   * add back the AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f to return
>     the highest perf and check others CPU core type in the following codes.
>   * run some testing on the local system.
>   * move the amd_core_type to amd-pstate.c because of the amd-pstate.h was removed lately.
> 
> Changes from V1:
>   * drop patch 11 which has been merged in a separate patch. (Mario)
>   * fix some typos in commit log and tile (Mario)
>   * fix the patch 11 regression issue of kernel command line (Oleksandr Natalenko)
>   * pick ack flag for patch 7 (Mario)
>   * drop patch 4 which is not recommended for user(Mario)
>   * rebase to linux-pm/bleeding-edge branch
>   * fix some build warning
>   * rework the patch 3 for CPU ID matching(Mario)
>   * address feedback for patch 5 (Mario)
>   * move the acpi pm profile after got default mode(Mario)
> 
> Perry Yuan (8):
>    cpufreq: amd-pstate: optimize the initial frequency values
>      verification
>    cpufreq: amd-pstate: remove unused variable nominal_freq
>    cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
>    cpufreq: amd-pstate: add debug message while CPPC is supported and
>      disabled by SBIOS
>    Documentation: PM: amd-pstate: add guided mode to the Operation mode
>    cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
>    cpufreq: amd-pstate: enable shared memory type CPPC by default
>    cpufreq: amd-pstate: auto-load pstate driver by default
> 
>   Documentation/admin-guide/pm/amd-pstate.rst |   2 +-
>   drivers/cpufreq/amd-pstate.c                | 145 +++++++++++++-------
>   2 files changed, 95 insertions(+), 52 deletions(-)
> 


