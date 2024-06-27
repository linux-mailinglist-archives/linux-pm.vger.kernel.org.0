Return-Path: <linux-pm+bounces-10127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B091AAD1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 17:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52B81F268C4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F74197A96;
	Thu, 27 Jun 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ctXKhwdT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EF15EFA4;
	Thu, 27 Jun 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501186; cv=fail; b=N3WCa3raCjYsS8iTHqq/rC29kMiNbQ1HG/Wr7KG4IHmqAVyryd9VAJ2SCkedvy6uSHjPLrqbjWel5+V+v+KNvuzc1YECTRzKUJt4MFxlj6P6nLGhpR2ZanTBXMqa77ZMxwc8idYP5k7bF6ep+mcPNVbHpdjaMDVK/jU4lirs+lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501186; c=relaxed/simple;
	bh=GLySh6kQtPYorQIcVul+wUyvhtQRJV52o8H5EZlEuTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/MvgJuGb5SwqInZ4hYHk3IL/2a92M8G2lqM0dUYpug5Cte1SYsSlkZSmDsuENvqI1NXwDAI5DBe6i/5wkWUNKpol4W0JHF0LQDuPaw7/fcFeePs0fyGXrqbXA6hw92K2hHHllfNpqPUu4HGZchoF/tczBox060kdjWWcTpCeRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ctXKhwdT; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/CnBBhiExYYe9+6g16S8BAW2aRMUf8u/IvL3isoW2VZZaMMrr/3V60iOMhG51KQ5LZtJKbjBharjfs24r3o+OxTevsUDtOzkzbCaKR1T11DQLcy6FiJV9YMbepsdGmyASpGApFfXu1znCVFxnSPGvuITWAJJdanPansQ9XP+uKR9MgFWyTNz2HZ/0f0PQzRq8R4ESfj0yabvBGiqAvxBaLURbz1sgOKFwY1ULb+oAk0Eg7Vh+NhCZL7SiafDCWUXi5VIZ9l8IDIDu8KsXIyV8h4oHUBtTTLCdTi83O/QBu2dj8R79bM7504TOJ+34uGV7IbychvFFSxVS/pF+/98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1GLj445z0Aya/qKJD6w083lRo4T0QYwppOQXkABleQ=;
 b=jPWXvh27PCnpXcDMV2Eb7nig5vntTtccBcOy8810RCpc8D1MPW/fJlEHS3uy6cxYYdf0NNKFPAMj0iOyPBYEI+b2c3h9cfXgyvX/ilwEKdtnKzdC9SEI8RwjoV+XMH4DKYrlTTHLm6MdV8t81jOwILaWjKQ0jfk/XwYZc99qVlkYU2S4arnNhG+hW+vRvk95Kl9/bvSFiALd8L8S3WoKKsAqWLvZFPneDuunnffjS121hHDJs7zBIuhdECYiepFJsAfnmv/uNWhEccVO4uKTH+I665S+vf7yMVjmGtER2Sd28XbNiCLRTr9ypN10pNYrlGRCU/TimDmdpJz1Gih4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1GLj445z0Aya/qKJD6w083lRo4T0QYwppOQXkABleQ=;
 b=ctXKhwdTU331J0H5OeiOxOOTEOqBrtYFCVhwJaM7Sc9qJkVjxE+LsKq5Nn/icivYcScNw7ITZiyqXBpSlyXj3H3P2SVvyaZlsBzpRpdjw50BX5n/i8D4AzmeT3A7vU5e1SC4oVVZWqtQiFIt6rz+T77fK4j2j5W5cfqs0RG1pVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 15:13:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 15:13:00 +0000
Message-ID: <f4390b09-7c12-44b8-9f6e-6eab81e9fc32@amd.com>
Date: Thu, 27 Jun 2024 10:12:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>,
 Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
 <peterz@infradead.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-3-mario.limonciello@amd.com>
 <87msn7ezoz.fsf@BLR-5CG11610CF.amd.com>
 <b0682b62-a690-4776-b2bf-444b6838cb05@amd.com>
 <87frsymogx.fsf@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87frsymogx.fsf@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1bdf44-9fe5-4944-570c-08dc96bba22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHB6Vy9hZ21KNzV2bUVtNTR3b2xXZ0pwT2RpS0x5eU5EYmNmeDlWUmYvelo2?=
 =?utf-8?B?WENmRTRJdmpEeG93MkJKaTlWREFBQjh1azJMbXFwYysyQStkaG1VRUkxT0RX?=
 =?utf-8?B?ZVVYeWhyV1laWDdUdjNOT215Q3N6L0Q3VmxxOTlvVGhxVHhwMHVidHN2eWl6?=
 =?utf-8?B?ZlZZRWJ1RG4wMzZ3ekVqbVBSWWMrSGU0MGxmRXZHN1ZlU241ZWNSdld3eWZ4?=
 =?utf-8?B?WTBRUmNmN3dNVUZuVEM5SjRCS1NzdU5jbExkUXViMDVRdk9rQ3M0WWRQTTdH?=
 =?utf-8?B?TFFaM2VaY0w1WEtaMzIvemszK0pvQ2RucDBBcHMzcGVwSTBJY1Z1OU9OSmtp?=
 =?utf-8?B?NUdGUkNSaFlLejlIMXZPT2xnL2YxZ3NScmsvL1pOSlpJWkU1WDM3Q3dmSGJ3?=
 =?utf-8?B?S3ZBU2ZpYWNzZ21JcG5Ub2w3QUtvL045SWRXV3pKK2NrUFNERW5vV25hTFE0?=
 =?utf-8?B?b2dFMWZtVFlNUjZDQmhvWk5KVE5oZ3RmcnpBOTNUcE1pWXUvR2hPSWs4OW9R?=
 =?utf-8?B?c3RTYXUrY0hHd2VkeG5xNjVmeVJMZDFSQ2l4cHQralptNzBMVEorMU9uOGJy?=
 =?utf-8?B?bm9ia0JwNTUwWDBjbzlrNXBXSDJkQjg1blB1aFdRN1d2SDhaNlBkcWlGeHVO?=
 =?utf-8?B?YVJKY056Y2p4bjZ4SzFJVFhEb0V1d2l0OUFTSTdnNzJGVkpRVWVXMUFtTngz?=
 =?utf-8?B?aDBrU0VWaW5zdDZWc3V0V2NmVzRhZ1NwbDBJRDNSNzBPTTUxYk5MdWZaVXZJ?=
 =?utf-8?B?T0p5OGtCTkd0VUFKNHFQQjJMSU5EMnoyVlBYZExKdExsQjNDV2RBQ1hNSHh6?=
 =?utf-8?B?YngweTZDUSt3a0VRRGpOL3VWRnZMOTBISVlxZ2x2Z3dna3dTM3R1bXpqK1By?=
 =?utf-8?B?Ry9BWEpPbjNEbUZISDR4RXhhU1c1WkdRalIrQTFzOWdaVStCc3c0TXduSUVQ?=
 =?utf-8?B?VTJrMmxldnBVWGxDNC9Da0RONXBtWGJ2blBRQ0VtM0pmalJ1Q3NrMjR5Zjlq?=
 =?utf-8?B?ak1FTWJsNTNnMjM0VG9lUUpnWVBmVC9WWjVqK0pTaXV5bUx1am8yaUthRlJq?=
 =?utf-8?B?SSsrZ1NHNlBuZkdYS3g2a0dxcjdYeWt1eThtbEQvR1RwSUMwMUxZR1ZvYzFL?=
 =?utf-8?B?WEh0S1ZiVFFWbWdsSXV1emNBT0ZabkRyM1hJb0xkdThPYkFJeEx4WkpjVmxj?=
 =?utf-8?B?azBjZ05qNWE3ZHIwd21paEtBSHFRRldKWG5XLzh4NVlVQmVncG5nblJhYThL?=
 =?utf-8?B?cCttRzZ4aHV4VEJrRzJISGtZZ2ZmSlEvOFVTbFR2TjY1czRHZVF1OU1QSmhD?=
 =?utf-8?B?eW9UQThIdEhXS0I3MlNnUVRxMUdGREVCYXpRUUN4M2dpZThxdDl1K2cydTNi?=
 =?utf-8?B?NWxrNlNTaXFxbXd5U0toSGFYNnRQekdKRnVSOUhmbURNQmorZW0yOHl6ZGd5?=
 =?utf-8?B?WWtGdDZxTmNON2pqOEFFdTNUK2hKSEltZnhpZS9LeHdFbGxQV2pMdmZWcENq?=
 =?utf-8?B?Q2dXRklwSEJJZ1JycENPL1FHZnhpMXZaVThOMEVHSlY4TjljNGR0Y0JiY0VF?=
 =?utf-8?B?TzljakhFRUVMQ1VCZW9mZ2YzSCttT0M4Z2g0WUlSRUJXTW5FdW1VQUdXV3pD?=
 =?utf-8?B?Z1ZCTTN5Rlc5OTNHRHloaHJ3NFBxU2FKZGNxNmF6YUk0dElKZndmcnJGQmxq?=
 =?utf-8?B?N1lQT3hlb3Q2SGdrTFAvUGxkaGtwTE0zUzNBbzZiVmx4QzZjZm14M3Rsb3lk?=
 =?utf-8?Q?+RZHLje3MjGuNVnnUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm9NZmFoL0U5QVJiU2lGUmsrNnZ4UWtzTTk3TkpMR0tJVWdpanBLQitWTkZE?=
 =?utf-8?B?d0VWUm9TTnVhTlM0ME1uaVhqT24wR0srUjc5UjEvUG14NTc5VmlJM0VqQ0VC?=
 =?utf-8?B?RUlGRFlUNDd0dW9wTzV2Z1UvTmdjRW5sRFQvRWZscmxiNXlZbndpK3VnUldm?=
 =?utf-8?B?QytjVVVwVE9EOGMrNkhQQlgyMUh6YksxbjdvK1hob2Zwc2JPRVBEVVdSd0JK?=
 =?utf-8?B?OHlyNVFRbERqOU14aFI2U0U0aUJCdkJkMWJNMkkzdDhGVTlCWjFEUlRKdEpM?=
 =?utf-8?B?S094Qk9lTnRLOHkvdTZScGpqRVNjNjJMbXhTcjFoUFJGeHJKaVpFK3pORmZl?=
 =?utf-8?B?VzlSNXhSR2MvbWlEa0E0MGpmY215akhhU2FRYlExNnVhcWx1WTIxS3F6T3da?=
 =?utf-8?B?OGx6dG40bXlVVkpOTmx2RzdDbE56Sng1aGpjSGwwVmpXc0tmWkszOGtoejh1?=
 =?utf-8?B?eW81YXl3YWNBM1hkdmJVczhYN2VKcmVBWENFUitpbmVSL3pwK1YzY20rUWpz?=
 =?utf-8?B?YVZqampJbHlvaDd5TmJVSlZ2aDFtdlM5TW44cmowanlKZTR3Vi9iZTBhb2V2?=
 =?utf-8?B?OHp2czNNcmFjTkxadXRzNlJxRk04dk1JRnJ2M29uTXJUMHNYT1MrNFBaYW1D?=
 =?utf-8?B?TnR2amw1WjdEc1VFTE5iTllhQjZkOWZkN0xzRXg0RzM2RUs0ZFdlalVmRHc3?=
 =?utf-8?B?cUlqcWMzNHFBd1ZoclVuSHZxM0dJd1F0UlVnWWtrMTNTRW9PK0pUd2txNXIx?=
 =?utf-8?B?L3hLZlRzemlPM2xObGhObVFCbEdXVzNSbHVXSnJoWTRoVFU3WUx6amhKR1FN?=
 =?utf-8?B?SE5jOUNHcVZTajJIUkhUMTd3Vm9wTEJpb0ZSMmIyekZqUHpHUFpHeG1Sdys2?=
 =?utf-8?B?eG1EOEt1dmxzU2FLTEtheFhCa0ZzOHYzMjJwODdCaVdTcXNQaTdlMmVURG9N?=
 =?utf-8?B?Y1Q0bGRoMVZVeS9oMXhrY0Rzd2pYUHl2dThOM2dwM2g3Z3BPQUNDR3lJNW5j?=
 =?utf-8?B?NHpTTHpNajRBVXF0S1M5ZHJXQ0VDMXkxSVlSNWJmOXBtalkvZ3lvZ0xja21t?=
 =?utf-8?B?RWg1V1oyT0dUa05kSUxxNWhnYXpKendVMWVrS3gwYWpVRFNRNm9DMEx4cXBt?=
 =?utf-8?B?ODBKUHRBd3VTc0FsQks5b3BtbmtabDRmck9UNFBZMFZKZDdYbmpPeEw0eTRh?=
 =?utf-8?B?NHJrcEs3V1RHaFY1YmhkZEpheHQ2bDZaZWNFcGpLQ3IxejVBNDluT1RMdWNs?=
 =?utf-8?B?Vk1GMDE3a2E4cHNRTlIvbUFsVCtycHYrSlVmWVhIVktmNkJRQm1qdEptTTRz?=
 =?utf-8?B?a3QrZUxVV2RJc3NET2RxSlFkU0dYaG8ydHo2TStwSlpyTVNpVjI0UEs0OTJU?=
 =?utf-8?B?SmVyOWFCd2Q1SEJBVkFkaDYzNHNGREhqektpQXZIVUhwRk1TZ3JERFZSd3B0?=
 =?utf-8?B?akFoSGFLUlJUaE0xSnVHRm1lSVdDY2pBY3QyZllPWURFenU1VFA5WXA5eEl1?=
 =?utf-8?B?bnh6OTBpZTNRenB6Rit6WU5yTmJFcXZqK2hJV2JzbkJTckJNZ0s3elJ2bzNa?=
 =?utf-8?B?ZXh0WThtWEgxcmJBa3g3VEh1SnhHZmpraU13MjJYZkRYUEdkZ29MZHhmeVNm?=
 =?utf-8?B?VVJKYXJUNkVsOGJxSGlMRFF3N29CeERwT0ZWeElpeGNrbXVuamRGUjdRUEMz?=
 =?utf-8?B?bGM1T05pY25BdGM5UmRuWlpzeDRLajdwODhYeGl6LzdqZVFsWjI2UzkzMEhD?=
 =?utf-8?B?MXpxd2RvanR2aGpESnN1OHZ2L1lhRVJHTHVLNENxcnRMczY5QUl6RkpFTVpp?=
 =?utf-8?B?UGZmNlpWMEFsb1F3aHRpeVN1TW9iUVVFSnk5ZW1rK01kQ2lZa0tCRTFSSG9k?=
 =?utf-8?B?eGdzdVRiUXRaRXJDbHd0WVQzdEprSDN6MkJOVmlmSWJsQnpEUHZkYlRYSE1T?=
 =?utf-8?B?UHo4ZUlWaVBKSTViclM5Yi9ZdFluVWxMdzJacnBhbWJ5Q21hbVZ6YWl6VGpn?=
 =?utf-8?B?TEtnMW5RSjZNWjhzWUZCcG1sRHFwTW5zcFcrT1hWaGhjemQyWnc4SzFWWm5H?=
 =?utf-8?B?Znd0M2w1ZlVVM056SVBhZzN6MjBPdzJvOGNybFdrK0tSUndIS0lGbnpuUncw?=
 =?utf-8?Q?pG5sgrfUKPGRwZjcXhinFaAm9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1bdf44-9fe5-4944-570c-08dc96bba22b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:13:00.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsoeebgKNfE9WDIp3UF1i0NjIhgpjX4HPAMlMt+mfa8g2usA/Ef7QQ7udkJSVtcZryxVNEMo660Jj2ZR6vsrrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

On 6/27/2024 09:47, Gautham R.Shenoy wrote:
> Mario Limonciello <mario.limonciello@amd.com> writes:
> 
>> On 6/27/2024 00:12, Gautham R.Shenoy wrote:
> 
> [..snip..]
>>>
>>>> -	return CPPC_HIGHEST_PERF_MAX;
>>>> +	/*
>>>> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>>>> +	 * the highest performance level is set to 196.
>>>> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
>>>> +	 */
>>>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>>>> +		switch (c->x86_model) {
>>>> +		case 0x70 ... 0x7f:
>>>> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
>>>> +		default:
>>>> +			return CPPC_HIGHEST_PERF_DEFAULT;
>>>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> Should this be CPPC_HIGHEST_PERF_MAX ?
>>>
>>> Without this patchset, this function returns 255 on Genoa (0x10-0x1f)
>>> and Bergamo (0xa0-0xaf) systems. This patchset changes the return value
>>> to 166.
>>>
>>> The acpi-cpufreq driver computes the max frequency based on the
>>> boost-ratio, which is the ratio of the highest_perf (returned by this
>>> function) to the nominal_perf.
>>>
>>> So assuming a nominal_freq of 2000Mhz, nominal_perf of 159.
>>>
>>> Previously the max_perf = (2000*255/159) ~ 3200Mhz
>>> With this patch max_perf = (2000*166/159) ~ 2100Mhz.
>>>
>>> Am I missing something ?
>>
>> Yeah; this is exactly what I'm worried about.
>>
>> How does Bergamo handle amd-pstate?  It should probably explode there
>> too.
> 
> So amd-pstate driver calls amd_pstate_highest_perf_set() only when
> hw_prefcore is set.
> 
> Thus for Genoa and Bergamo, since hw_prefcore is false, the highest_perf
> is extracted from the MSR_AMD_CPPC_CAP1. See this fragment in
> pstate_init_perf()
> 
> 
> 	/* For platforms that do not support the preferred core feature, the
> 	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> 	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> 	 * the default max perf.
> 	 */
> 	if (cpudata->hw_prefcore)
> 		highest_perf = amd_pstate_highest_perf_set(cpudata);
> 	else
> 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> 
> Hence it doesn't blow up on amd-pstate. So it looks like it would be
> better if the prefcore check is in the amd_get_highest_perf() function
> so that it can be invoked from both acpi-cpufreq and amd-pstate drivers.
> 

Ah; yes this makes more sense then.  I'll work on a modified series 
during next kernel cycle.


