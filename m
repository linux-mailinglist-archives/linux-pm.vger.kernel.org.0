Return-Path: <linux-pm+bounces-10733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B973A9298BE
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD22810A7
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E37225A8;
	Sun,  7 Jul 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNdfNIWX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD2EDC
	for <linux-pm@vger.kernel.org>; Sun,  7 Jul 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368289; cv=fail; b=sWaRRz9uKa3DX8TJKCFt+mg154xlRRSN2mcIvVTX7uR2os6rwwuQzr3ZX3u8U/NZJec6QQ5tdTLI1GHN7IDnGkJQovTUvtvKtssNd+SwO4dr3D83KCuWIA5a2uOhwE85ue/tm4hIxPlvpsD3vi7aREDYq53nw6Fq5HUAIqn2qYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368289; c=relaxed/simple;
	bh=VzGOPLSHcs5QhkMnwVptI60n3tNjy8hm6j6bsHjvJFQ=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=bopaS8pmCcoGbtM6D1mxDvlI0VgsB7nTPGHtwJbU2RZCb4OhtRRN9RaCvgddkzsuVTWMTl3LJiSm41PoaOnFpQOIO9B72wPXXV7Af1QQbT0W+BXnmn1TaGW2DqcbrSPSXKjqqM370nxbSOYRtqNOk/Ia2SbaSQH5A7icVtwc5v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNdfNIWX; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hriKXmUT2D3/btgHKmOXQ4UIiV5dY7XRObONVlo3sOWgOhU4dsvPPxmMkhhybEZhEDa0wKrJdGs+7v00wS5Z0X0wX0V2QUM2SdvaTpjfVlMLAKjQjgbFUhADKswY8KahIITR9BaKPVFIhZoK33hpF3AqLBN3YpG9AilwMtdDVTUuEvkvZ3xVk0kbFDpvIosqgzIrDPX2VNIvPTvBz5yHvRM0cNP9waoq6wy7YgAGpr5DlJGmQDdz2H4QqFO2QKND1ljdKC2aVh5kbpeSHeTrKahRlugphYVorrI2uxj3QyfgyWCrG3ai32zQbssge6GTOC760PJgiywoha1rdgHhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm0LInyrbqGIlqEs+CHuUiDWJOa3RH3ZlPOS7v4eYJk=;
 b=Xp2YhlSn8jHHvMNICHcGzjPUsgDNI+rKWXLc8RsxOk5okibX53MuawGAjcYE5vDQQyM0VP6I9up4MfVxnJtmh+qoBLgzVTjEMAljkR+uB2vFN49eHsjp5hxnZtSg2eA3F8odCnR+eX5tgsKaO5DT46Sl5CZkpfDMsgkeVmaC/7ZFKCDneAhSatL/YlDJkOFdTK1ZPGIeNFybdqQqEWTNBH0tUIqyTS6FWjukTNMNIEc+sW4tR7G0jaNjBOGcVyvrqxSbAs+4j2ZPUWcQRqGKJbR50GFm52I2udKmnQrAaOOv3IvrgA6D837gPXqN/tKcr3qGRuA+G/4jCsq57VeqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm0LInyrbqGIlqEs+CHuUiDWJOa3RH3ZlPOS7v4eYJk=;
 b=pNdfNIWXhyDjZLp9s1ZHb7GcXmcv65AnUMHK+n13B/+/i6rq8EctV9Yr5PlE58ZHWwX+QmtZBI5h+mRqlbEh5k3RUQiOSYB9U6Jcq5UvaLGMvA+ZiA5ozNEwTFvjylKUcubqokKrXr7HdZmNxUSqv7TLSyOVhHa3diUxAcFAQ/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Sun, 7 Jul
 2024 16:04:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7741.029; Sun, 7 Jul 2024
 16:04:42 +0000
Message-ID: <144c8309-c355-447b-9106-1396a0169bb2@amd.com>
Date: Sun, 7 Jul 2024 11:04:19 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: 4th set of changes for amd-pstate on 6.11
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 89066b11-9450-4eb8-ccac-08dc9e9e8339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXFVVXAyRktYZmc4NVJja3VpUE9iTHhHSEQ1L1JjOSsrRWtnbEFKOWUzRGxw?=
 =?utf-8?B?alcxU3NaU04zaEpQSm9hWHRpN1o5VFJtSVRKcEo1ckVUR01QQ0VISGp4Z2lp?=
 =?utf-8?B?TURHLzRneU5ZenNQM2NuMmJZYUQ0M1dlMmMzTUNEcFhpZmJxN3JBQTgwSHl4?=
 =?utf-8?B?ZkdreHJDVlp1cVZERFJKSkkvZVZvYTVIU1B4YjhsaTlhV3VEYkZicGVrSmlp?=
 =?utf-8?B?TlNNME1kcElQNVFyV01TTjJaU3NFMStWeGJKUFYrQUZ1MTRmaUhvdC8zcVNW?=
 =?utf-8?B?WEtMNVVDbU5NakRtV2I3N2IxdDZpZzdJVitLSUY4dThvVUtqOWJWWE92UWR2?=
 =?utf-8?B?MkYwUmdkNGo0WGJPS1hSVEppeGRLY0lPWnMybVVHcURrQ1dqNVRBUkRHUEN4?=
 =?utf-8?B?VlpGRFpWZFhRZmt2clFoYUMveWlUS281Y1VBVitabUFmb1hpM2ZUQWZxUkRL?=
 =?utf-8?B?Y3JYbG5LckoyOXFNSExyYlhvOERKV0I5S05xUWRhSUZlMkZJZ3kwamR5cnhm?=
 =?utf-8?B?VExnck90ZzBqQU1sbFQvVHFxcEJiTEw5UHZhUG9TRjE1M0VCZGJQbXNmRjFB?=
 =?utf-8?B?cTh6bkNXZExiMHV1ZU9ZSXozejhGcTFFZGFFaUthTmVtdWRQRjRVRHJnMTJt?=
 =?utf-8?B?cXFpU1l1ZEJMTkk1NG1ad3llQW5Gdk0vc0lsZHMrbEkvMzhmYktoWUhlYTFy?=
 =?utf-8?B?bXlYSVc3Zjg5SEwzWFZUa01KdTh1MEloQklKb2tQTGxXOHpJN1ArYmJ5NDQ5?=
 =?utf-8?B?a1lYRnMxL3llN1ZvQjNoRG43TGxSc2QrMlJETEJ6UHR6TG4vdjV6bFZseXd2?=
 =?utf-8?B?d3VGM1J6R1VXS1hiblc5clpmY2FGb0EzZ1dLbG9HMzduWllVK0dWUnVwSWZa?=
 =?utf-8?B?QUFPeGpTR2w5bEZHNUhNS1BmTlVBZTJzaUlGSHEvMnlUMmROQmNET3pXN1I2?=
 =?utf-8?B?S3pRdW8rTThMRm1LZFhIRUNCajd4elB0TURiaGRucXFQditudnVNOFBjZ3Zx?=
 =?utf-8?B?MTF2emNzMFRWd0lrWnBLUE9MODBwcmhlMnZPRVF6VlR5RXJ4ZW9ReThTTzFh?=
 =?utf-8?B?cXFwdHZmYW40Lzl3MTREajRNcTZ3R2dOdWo3bkFXWmpYak5XZVpvWkMxRTlW?=
 =?utf-8?B?ZTNOd2taanNWQ2JobUZWeFoyd0JENXkySTV0cXp5UVlhTk1FWEdvd2FiTTBh?=
 =?utf-8?B?bksxYVlVdlNsVGlTK3VHajllV3pXMTFsSnFsL00rc1EvWVgwTGVWTTMvY1F3?=
 =?utf-8?B?Y2NuME1rcGRTTnhQRG9rQStmQmRKalE4WHpERzFwVHJnQ3hZWE53ZWw0RFky?=
 =?utf-8?B?TU40SHlkWnNlOGwxMHkzUW1jNlkzOUdTYjFHSi9MRlNHL3RzeWl1N3B1d3B1?=
 =?utf-8?B?all6NSt2N0RETGlxOE1sZURTZmtzVmQyMFFwYjZndnZjTG1DTkIzUk1JcVlV?=
 =?utf-8?B?M2sxeVBpK0xsTStLOHptRkgxVVg0ckM4RFJQWWM4UStwS0psSzUrMWpyVnR6?=
 =?utf-8?B?ZStaakRXTWtBTk4wZnhWTG80N2JFK0c3aVNBb1Q3YUpERkRiekJyVkFqak1w?=
 =?utf-8?B?TC9mMjQ4VEwzV3hrR2t0TnhoWit3cXNpdTVVYjhiOEEyaTNubDcvZlFLRWs2?=
 =?utf-8?B?UHA5YmgzS0piRmx5QTc0TVNvVFVBYTNIcytMempKd1VSVTNEeUMzamNuczAw?=
 =?utf-8?B?d040Ni9oWUxXNlJ2RFZxTGthYldDaStNUHpvVGh6TndNOElsL2tkU2N5ckJI?=
 =?utf-8?B?MllEV1NqYzVjWXcydFdwejVuYmNQZk96aUYzRW9HMTRyRmJRMy83dkVnQUgx?=
 =?utf-8?B?RDNMYkF6dU1ydkFnNWFRZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHk3UFVmYzd4cGZmQzUrRm50TEQvWGJWeVRZUExPYU94MG43OWpYdXcwZG1G?=
 =?utf-8?B?YnBVS09DNHY2aW1lS0FFb2hrWEJnLzB2TkE1Uk55UEw2MTh6MTBwYUVOM3Jj?=
 =?utf-8?B?TyswUWhQdWROYnp3eXdma3BjWUEwa2xabmd1Q1Z2eWlNK1pLTHB4alg1M25B?=
 =?utf-8?B?Z1RJbDRhWUZLME14RDM4ckZMcW5xQ011VXA0aVdFRDB2ODdYWVFXUzY0Z1dy?=
 =?utf-8?B?a3BKdFJ0aTF1SXA3NFpUaFpYUGFyYWpTN2NwSjY3WXBrZEVDbXdmTUVMSGlI?=
 =?utf-8?B?emFhREE0dGhzb1lmOUJjcEsrSFh6cmRxUzQ2WjJyWUt3SjQ3QSsrNHhTN2lN?=
 =?utf-8?B?SEV4TkNuTko0VnBscUlvZjRGMVlWZmVhWUtyVURjYWEvRGsvbjRBL25MU1hi?=
 =?utf-8?B?WVNVdFo3TmdKajZuMGh2Y0tGS0xGejlmUVpVN2w3M1o2akJ6aVVQREQzUTRk?=
 =?utf-8?B?RnZCdXZsYmxjVWs2MGhtdU8vbFp2YkpvN0t1dDVzaUtJT0psK0RMMHlNdGIz?=
 =?utf-8?B?WFB0ODBScENGYnVVdU92Y3hjRlgySEFYcnpwYVhpelVyQy9PcTg5SDBpUGRK?=
 =?utf-8?B?RHVvVCtTZWdtcjdHS29odzloM2xacWlzVnBvWWNTb1FNa2ExYmd4ZUdFUnhL?=
 =?utf-8?B?RVdwOUVhd1dKbmg4K2o0NkVHeHM1L2lxaC9lazlJTkxUclpFbWNLOHZuWUlW?=
 =?utf-8?B?L05LSzczUXJMQnBJYkVSSVRlSjZNclZ1Vit5dmtoOHZzUVpIMVRIWWd5V3BP?=
 =?utf-8?B?WUZWQzFLcUI5QUI2STg5TTJPek1Vb2ltcDFoRXQvcVh1aE5ORDM4MnprV0FX?=
 =?utf-8?B?R08xYkZtaTkzaitybExvc2hYYU5xR0NVY0xpK2J4eGJvQU9HaUZETkZHaENs?=
 =?utf-8?B?TmcyVDFCRzRGOVBod09DREpyOFliQU5tMEhOa29TcWg4dWpXd21QUE5rcVhm?=
 =?utf-8?B?RTFDS0RYM0o0N09PWG9xMTlIN2NIZDJYVHBTY0JqY0g4MmJ5b3AweTVWRGVa?=
 =?utf-8?B?eEJFN0NCQXhVNVJLT2EzL3MzQ2pwRnNqOFlnTy91NllxTkhoQ3UvZ0YrZy9G?=
 =?utf-8?B?dE11SjVxTnFmSzJMQVNsVW5vekh0YzNlMCtwTjZyd1FXY3JHQzhwYVNjNWlS?=
 =?utf-8?B?YU8za2pVK0FqdE1jRXdma1ZsaVBCQ1MrazA2anowVEUzSk0rQzVHQWwxTCtG?=
 =?utf-8?B?T284eFhwTXJmTDhxNDA4SUNSanhDbVZBekRtRTFSZkE2VzJpaTJ4RmdWbXlN?=
 =?utf-8?B?RFRLOUVKR3ZJQ0loc21xL0tNNjBneVI1dHZsMW9UZmd3M0VMa3MwUm12N2Jo?=
 =?utf-8?B?ZG5FOXlUV3pmeFlLaHYyRU5UZ1k0VWcvVnl1UjRFOUZwdURFZ0wxUzdjZzFa?=
 =?utf-8?B?QVRpVnFyRWZqRnM3SlNOdGZDcU1rZ2JpUExtTVBKckpISkNlZDgvb3NSbVhH?=
 =?utf-8?B?UmdaTjJ1eUNCc1RQS1J1aTUwZHdRbUxOZTdBa1BMdFpQcU1Ic3dUZEEzSzV1?=
 =?utf-8?B?bHdGN0V4SldxTWtPWFVSa1FXa2pqYzhaazV4dDA4d0MvREZqV1pPSDAzTnly?=
 =?utf-8?B?T3VCaFFhSlNuK2dpelJyL2JYSytuQTNReElGRmVROXJxTmwxdGpKcEdHcFVr?=
 =?utf-8?B?WTFzaXBLei9NVkI2ajlxUlVITWZ3ZzN2bzZzRERmOFZMZUI3UHVHSkJmTGpS?=
 =?utf-8?B?QnRKQkZ2bjc0LyswL04xOUFFd1hYOU9Dd3A0UjROZUdITU9NQTZJdUp6WVhH?=
 =?utf-8?B?bHVUbmI4SmcvK3FaaDRJdjNRQnJ0dUQ4QW1NZ1A1M0dPa3FPVUR1UXdDWklB?=
 =?utf-8?B?VzhFLytzMVRtcmRyYVFCTEhiaTU1Z3pxTFJrTFhKeGk1bmQ4M3dqelJqUjVQ?=
 =?utf-8?B?Y1JwMWlYeWk5cmhYcXJ1S2RycVZxMmhOYUR4czFGM1ljSzVhZC9JSzdCdWVa?=
 =?utf-8?B?V2xxcnBHWndCTW1aa1BhODBrTldlWlAyS0FBRkVlV243SGJ1dTVJVVVEelJu?=
 =?utf-8?B?ZUFQRE5FK1R2cUZzbzByQ1ZZNXYxRjBteDVyNTljT0NMTVJqMWtQanlQdU53?=
 =?utf-8?B?M0FxU09iN1haRi9GaWpzRzJxTGVockx6bDF2N2xnZGwwbkg4dzNqNmNOc2li?=
 =?utf-8?Q?gcZcbYlDFaAiTkLsSX1lrQYWR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89066b11-9450-4eb8-ccac-08dc9e9e8339
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 16:04:42.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doZXt17MUMCD4ENA4iRw2IvvurTgCooUsb4YKNAudNXt9+0qHcUDuO+BgvKDWyfrP9NQ393ZPKSsA/BPmZEafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

The following changes since commit 6d588891a90c5a946aaac11a93d06edd89ed9054:

   Documentation: cpufreq: amd-pstate: update doc for Per CPU boost 
control method (2024-06-26 15:48:21 -0500)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.11-2024-07-07

for you to fetch changes up to 738d7d03571c7e38565bd245c0815a2c74665018:

   cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory 
CPPC systems (2024-07-07 10:32:48 -0500)

----------------------------------------------------------------
Fourth set of changes for amd-pstate in 6.11

This adds fixes for setting scaling max frequency on systems
without a dedicated MSR for setting CPPC requests.

----------------------------------------------------------------
Dhananjay Ugwekar (2):
       cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
       cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared 
memory CPPC systems

  drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
  drivers/cpufreq/amd-pstate.c    | 43 
+++++++++++++++++++++++--------------------
  2 files changed, 30 insertions(+), 25 deletions(-)

