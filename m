Return-Path: <linux-pm+bounces-24711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8763DA780E6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 18:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671767A23C7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D7B20E030;
	Tue,  1 Apr 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HeAdoYhz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA620D509;
	Tue,  1 Apr 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526672; cv=fail; b=Te4VIU7222IvSxU01bOXsm1eJESSw/7PkAka+OZT4+PDTIfElq2IKwJl04ko2Rp3J0ca9dY0J7lXflBgXdhjaOmuK7v0vSFzwIe/v+yI25Mq4f25eIXoWkTn2SLvfyv88repqAQ4qLg1jxs0DvWcXbFt98vCpTTf5NUWgFALOGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526672; c=relaxed/simple;
	bh=pDdsLRA1c58I5rFZt6DzwWJXC0kikgUSJWOPRPULoes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rRcbW/as8+39Nm+pXcIM4BcAMVo0uSmEWOltYbuzGjuBAy4qxl/XVgZ8Svi34pAEERlvLEFdx6/9iSImLpEh86m+nHaWNmDbc3fM7CtN8IanvlAGTljC5Sqb9ZEGsaaZGPQ+YNUKjx5wzeq2n0P6rKXHf0TZMjoAH8IQFhQvPEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HeAdoYhz; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr/06+LTqDTugbt4WbC8XrHVMCtnE4YLnZTJhg93NizOf2zmH66V4oXhxnyJ/PJnLlcpmepZDWRKaO4za1Jzq2h1P5dQICCksRuVh1c0yNK+LkxtYra3CE+ECP26eWZlQHUSMd3z8lZLGkVdSrXXn/lg179sZ9T0uhGnV2KIxbmC+p3/vssBpAA7fkhb18sQBfHGVcrqFzeGzDN4g/R5aXtK7OAEueHtHytktUpIIvYwUXt/rrV9Yi5Z/7KJNpEf4UakUIJEawYdg8eOwiMEwzgUlA7K0pj3k6KrrYjdsZIiTqo8MUvSbzfZnUtrIIVQFpBL8Fb17q+th2TXGNrCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w502nHdYFtF2wAlBMeBtT1+F3Sz+jexyGXBxSseNImI=;
 b=aZH7a48/89CLexobB6BVHbqgjUIC56sY/dFYLj5NhjpRNGRlIqhtnRaTkpCPhfGy+gM6NfXn8c1JDt2n6WL3z6V/a52lhiolGkjF0zje7IsAbedEf+gH0hOEydyVVRuROhVas1M7rsmfXijhCfk/ZEU8VeIAG1PeXnr/+5W4bU4lZiPyal7VykdpVc3J/Pwcgbx4Uep3AU/7+bH/2iO4ygJMEzD1se2sUnbEXTzTNsH33nxUa/Yniq0g7uBB5JEORZezCp3zPV6BNEeR2Os7/eYF9g3uPUbDV3l0dH5hwI7p5XFWHYILB1z8Zc75qInlUgDR2DUlCleWNmR55r+aHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w502nHdYFtF2wAlBMeBtT1+F3Sz+jexyGXBxSseNImI=;
 b=HeAdoYhzZWgHG9cpDrbD4vunzYz8F4edGy5LUIXhftTb+90LyWhHl4yXzK0+CuL8qIQe+pk82nyQ8q5yWc8v0IsDxSO7GA3FBELMa6SykON/xGjmwG/MmeU5Pz5LuDpMihi8DundDbYtpr9tJJtkwslPXD+R+3LCrbE+RezTwgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 16:57:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 16:57:47 +0000
Message-ID: <c817bf2d-9dfc-4685-8b7d-82e74f594a1b@amd.com>
Date: Tue, 1 Apr 2025 11:57:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] cpufreq: cpufreq_update_limits() fix and some
 cleanups
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f4b474-09bb-49b9-308e-08dd713e5440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDhwMFJBaWE2RG5UbGoza0dWbjI0N2FWSXQ3WFhhMVBCeEY4Z0VkREFkSTRj?=
 =?utf-8?B?NzErbFJIeTRHdUVHR1BJQlhhbzd4cDdiQXJXcTBSbmtNVmFkZzBGZ2F2YU5l?=
 =?utf-8?B?dDIxSEVnR0ZZR0F2U0h3MmVQNTI5R210M3IyZXh6ek50VGxBUUFFUHROS2d5?=
 =?utf-8?B?Nnoxd2wvQmlHcVpVM01vV0dEbGhsbFBtMmdqSFFmTWxYMXBlclZaTFBURHpL?=
 =?utf-8?B?NXZwN0RWTjdSbjlHU2lDdnpTaXdKWEwrRmY1Wm1GSzNnSDVoVk1uaU9IOG1r?=
 =?utf-8?B?d3R0RHNPUkxTVDJ2L3BrcmlMYUVnKzZmdWRYQ3pXdEtoMnNHanJaUmsrQlFY?=
 =?utf-8?B?ZGRkc2dsYXVnblk0RXZnbC82cWRLVnZROVBJU1ZZTC8va1lIUUVubUlDSE5s?=
 =?utf-8?B?L2JiUWNaL0szaExSSEJ1VG52M3JiRGtYNEpGR2tjazdST29QYzFDWGRlL0RY?=
 =?utf-8?B?cEYwYUsyaE1UN0xxL1ZKR1R1aExRZ0ZUWXp1MC9wV2p3T0VtdEtYcER1Q3RE?=
 =?utf-8?B?ei8rb1Bld0NBVzg0OTJCUEorNmJKM1BTeSt6RHM3Nitmb2EyQ3cxbzZDM0Nq?=
 =?utf-8?B?eVNBZFlVYXZzeWdUMUlJc1RyOVJkL0gydTFpOWN4c24xenp3dDhCVDBmWHNw?=
 =?utf-8?B?NG9KWlZod0NBbWd1ZmNPdHp1bnFmb0J5Q2hMNGZBRVdEUkVTWXhkUldsbTdY?=
 =?utf-8?B?V1ZIb2V0TVZZMzJ5OVZ3V2VGMFd4b3YwMkNWUCtxMDlTZmg1ZXdBbHFMNXp0?=
 =?utf-8?B?d3RydGxpdkQ2SG5hTm9TSG9RVUlSMWV2YU03dnRiNlE3b2NxY2IweE9WK1VB?=
 =?utf-8?B?bEF2Z1hHcUx2K1ZINUVQZGdNcm5sZWpsck1HTnVNWGFSTzlTWDMzZmxvbnZ6?=
 =?utf-8?B?eDFUQTV1cC9GQ0RmMUFmRzNOOTl6Um9lMCtYcnY4WHVBSWpaSjd5WGtiZmlH?=
 =?utf-8?B?MlBJVm1UakFHandML0l2UEZTa2lTVjZZS2ZoSTFOSGVsYllWWUdDazNVWmV3?=
 =?utf-8?B?TU55V1RpcXVSbDQ4Y3h1d0prWU9vZFpUMStoWUVqd2hRR0NIM3lVWHNvc29s?=
 =?utf-8?B?NGhrWUNwYVFTaVpRWjdZNVAwTzBDbFFMSnZKWjB0c1Q0azl4MTJMZzNpRDFu?=
 =?utf-8?B?ajBoSkZnVWFpbzB6QkNid201ZmI3TmJxcjZweEduZWdybkxodHFtb3RWUVhC?=
 =?utf-8?B?Q0tJb2tzYm50ZTBBelRPczdMVUJwWFJldjcxcU0xSS9rcnB1NmRXbXJ1ZEFX?=
 =?utf-8?B?N1k0QVFvQzRleVBCbG5ZWm5Xb2VsM1Q2VU5BVmxMekVDczlHNGVDN0FRRkRI?=
 =?utf-8?B?YmVqVGVIdXk1WDA0QjNVT2IwMlFNS2Q0TGwveGc5ckp6Y2gwdFBVTlArU25v?=
 =?utf-8?B?UnN0TDlZdkVTV3RIQUdZZmtQZFRqZTZTTldGb3pJTlNyeHlwMEpKUWFDenUz?=
 =?utf-8?B?STU5V2dRN0d3MjZPY3ZCZUZoWUhMTUE2NG5sT05aV0Z3eXIxSWNEaTRCVnRC?=
 =?utf-8?B?RVJqTTVQczZQNnMyZjBQZ1VHelBxV2YyNGM3S2ZVQ2tSZjdiVFdHVWNsZWRK?=
 =?utf-8?B?VENJNEpYSFZUUDlqSGlnaFJPL09UV1NweDBMK3MrQTYrY2hHYkVzTlFrUFNR?=
 =?utf-8?B?bkxTcUNpSmVINVFFMjE5cVExalBIbGlpSkV3VHZuSVVjd0dhNFJCc25FbkFR?=
 =?utf-8?B?OVJUOWhFQS9rQnZaZWdFM3lmUU9lM1I5Z3JEQkIyeklDOGhEbGJKbUxrTWRZ?=
 =?utf-8?B?NTFOanN5UW5sQ216OC9RWTdzWFR3OG5KQzhkYWJuS2tmNXFacGlReVNXZTVu?=
 =?utf-8?B?RFl0SWtWaFRha21KUk5KQzNQZEF6OFpqcEpMSUJFNTJZbWhxTnpnRW04ZTZm?=
 =?utf-8?B?SGlZNmtDSG5KQWxKQW1aV0FYRFptcnAycjh6aHA0aDBFaW45aE5lRXQzeHA3?=
 =?utf-8?Q?v1XrwXqmBtE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z211eU1HR3YvaXQ4d0Z6Ymg3czV1TzJEeDJvQmkvM0IyRGxRakNSd09iN2Mw?=
 =?utf-8?B?VWtidE1uclhnU1BvMisvSHRqTVhtc1h2ayt2bFpOMmRsQ3dvRGpVaTd5Y1VT?=
 =?utf-8?B?WFM5am1CcHF4Z0Jnb3NVS0E4dnZNNVVEb0hGMVhnTXgrQ0ZkeFk1M2VvT1pu?=
 =?utf-8?B?KzhoQTdQand4bmZwQjl2TnJ4bXJwYVU3dFlVU1JSVjNZRjRkaUpCUytWTHln?=
 =?utf-8?B?VDA2MTFVRW5YZERSWDBqVFc2V2l1aTJ1SFM3N1BZQml3Z20wS282VXJIZFFS?=
 =?utf-8?B?WVRPRFdYaVZ1MVk2dm90dzhEOFBrd1MxZUhKcG9OZVd6aHl0MWVhTHZodlJ3?=
 =?utf-8?B?dElmWWg5MEpRaEo0UUxMSDZBckxpRkp2M1Q3WWpZR2RMYUdnSy9JcjB5RzFR?=
 =?utf-8?B?ckRaQmJ3T0xML0NzVHhodjlXRHF2WkVlbnFxRit4VTVEemF0aE9iZVBqQ0h1?=
 =?utf-8?B?NHpRUFJZelgyVjlDSS9CYnRyUXhHM3Fpd1VKWVZrbzZIY3FrdWhPNjNIdzUv?=
 =?utf-8?B?MVdlb3l2T0xvTVIrRmJjbTBWOGhvMkpQQ0gyeU0rcG51aGtkZitSK2tDczBu?=
 =?utf-8?B?NkhZMy9QV2hPdFlOZWl2bzBFQVNEUVU5Q3Bycit6bEtrV3BxbWNDY3Vzc0Rj?=
 =?utf-8?B?VG1yYnRuQ1dUdnlHa3NuSVcxaXpSQ3BDbWlyVUp2UnBVUm9LUGpGM2plVm92?=
 =?utf-8?B?ZHJJaEJKUkZhemJseUtsZ1M5VTVDanlmcDBPU1R4bmJJYjZadklLUGducEUv?=
 =?utf-8?B?YjNUb3IycDMxbmFRcVpub0FZODRxWEpXN2JnUUJTdDJBdTRXcUFoY1puSUNE?=
 =?utf-8?B?MnBBalk4UE51aGY4ZlRzbThZbzdmOTVjSDJmaEwwc3JoKzBlL2EvbUppelh5?=
 =?utf-8?B?Q1dDb0xLY2F5Vnl3Tm85OWV0REZGQVBvRUdKMmxWMjRLOFBRZit6cDFPTEFk?=
 =?utf-8?B?T0FGNG9pTDhWbElXNzFWMFRlSmtkclRpQ1ZVWnNPRXJmb0UrbURkY3RZak8w?=
 =?utf-8?B?blBCR1BEK2Q0ais5bVZQa0k2SldFaEQ4Z2FzVUxZdFZWYlE5dkN3bkRzS2k2?=
 =?utf-8?B?ZCtNRjhRN3c5ZEsxdTdZc2thOVFlb0l2cU1hTitEbG9vVmJjSkpuWDVTOFVj?=
 =?utf-8?B?T1VSem9MRXFIdWFaUjkxN1hPM0pBTnlqU0RhZjJEaUQ1VXNGWjZNV2tTeE1E?=
 =?utf-8?B?d05qQUxhRW5nMUlDeUc5TlQyTmw0OEN4UjY4S092cnZiUHFmUmZKdCszS0NM?=
 =?utf-8?B?Zlp2SG1EaFFuTkVBK2NTT0ZqSkJxemFwaVQyZUhmT3ZJOXFseE1jOGRlczlt?=
 =?utf-8?B?T0RJV09ObE1zRkduRy9mNzJpVnVLZER3K0hESWNXT1hEdGpCTEhuRHFZdVpO?=
 =?utf-8?B?QW1WMXEzRWt0VVJlaDlJeU4yOWVma0lNcW01UDR1REk3U09VTmJRZkVtLzNL?=
 =?utf-8?B?L2ZaTU9FaU5yQ3A5L2ZEMXpqR0tzRmcvRXZMakJGc2VYSzMxQm9HNUdSNE1L?=
 =?utf-8?B?dFJJQW1rbklIRWxDYmttSXozN210QmpEaGt2QTcxMFJ3Q2pCNmZCcmMvdGdL?=
 =?utf-8?B?Ymw3akJKZHFQQzViaUFXeStRTnJneVJ0dlEweG4rUnNZcUJHZUdsMEtyWUtX?=
 =?utf-8?B?OENTTXVWY1RTTXVJZWR2dy9kTUl6cHFqVjBFY2l1dllOU0FDK1NqdXBuLzlT?=
 =?utf-8?B?QnpZOXR3T0hTenRYMXlxbXV3NXlZbWVtZmcvOEdxaVlzUy95NEN3R2hqa0ti?=
 =?utf-8?B?U3BvcUtzQUtkSy9JWTRFeUNaUGpKTll2TWxnTllpbldRNHZzTDdRQitCNyt2?=
 =?utf-8?B?cVRxaWdEYytic2I3L3lUdGdIZEhEbm84Wm9YbVlxZ0k1L2hNRVBRQkhSN3c1?=
 =?utf-8?B?cDl1dUV5Um03bkVaS21DWDZ6NkhRd1FJTGVFR0pndVNsbUpWUjFycnV2SVd5?=
 =?utf-8?B?aTQ0dHZzbzhueGIveDkwKzMveTRIcWpGL2YySC9TRDNSS09OY0FhNmhqRHJl?=
 =?utf-8?B?blNkYlYvYStpeGpGcVBDcGNjbngxVGgrd2tTTkpQTEFrWjhjWmVUWGdndUtF?=
 =?utf-8?B?R0VjUC9kMndKT2RSS3I4WjB6VVVPWHUyc0hZcVdHS1Yzc2ozVHNuY21teE1l?=
 =?utf-8?Q?AIbagyRTVUeBj70jLhCb5A0VH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f4b474-09bb-49b9-308e-08dd713e5440
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:57:47.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SmAjr4UveT9s3RJxm154EEG4T+ZNfri66eNHHmcI+N7zCDQ4hsdE8yMhDhV8/8oV4X9C5gXX3tV9BGEzC7teg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

On 3/28/2025 3:36 PM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This series of patches consists of a fix for a possible (and actually happening
> in some cases) NULL pointer dereference in cpufreq_update_limits() (patch
> [01/10]) and a bunch of tangentially related fixes inspired by it, mostly about
> using __free() for cleanup and locking guards.
> 
> The first patch is definitely for 6.15, but the rest is rather 6.16 material.
> 
> Please refer to the individual patch changelogs for more information.
> 
> Thanks!
> 
> 
> 

It's a great set of cleanups, makes the code a lot easier to follow.

For the series:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>


