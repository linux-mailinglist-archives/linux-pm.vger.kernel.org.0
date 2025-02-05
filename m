Return-Path: <linux-pm+bounces-21418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E094FA29811
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0071A3AADFC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F171FECC1;
	Wed,  5 Feb 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="psxSTEGE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436B1FECA6;
	Wed,  5 Feb 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777874; cv=fail; b=EwPV8QvQvN2eUbSWmMlUZMrRL/Dt/uLEKsc776F87+IedznBcAcBnBQ41xFEAaokadrIlVUBj6+yeDHkqOFjpAOD/C7jq1VkXmXzc6EKkX/eUj4gcczGj+E3e7CiQ87wf65ZzKsOac1f89eegRv9vBQMeW0zpJ6ThYQsNPmYer8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777874; c=relaxed/simple;
	bh=nnZq4yrYdDd3Lwr8gLqekkndJtXthvSgvbZDcy7EH2U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5mrP60Joa1q6SZQCx55Str2BcRiwcN+weoyQE3/kvZRW691Exbcpc3u2KvkU0myY8zfZEaIvZwsmCAHwaIonAWjP8btjuUq6mZ9yA9+Gwgmrm0LEcDi+lKEvta2iX0nfTcJ3Lq8NRGHlON23Z21hO7LcSa1zsMkA395NEvBMXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=psxSTEGE; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4YwvsKSWqsG9wXGeoznpgRPgeEThHRs/LvaqbmH+m6TU7TE7XY+2LBS3WCTiz6aVSoXV9XjvDHN+7CUkAaGfNF0hbNho/3dNl1h8sixX6HiKH3KGz8eMbpo/YWYCD9sYkgT9j7Zzxit+3SanUPU6kGC4fHg4lBQGWGLBaftRiWkmtahW+niTli3N1gdlN5BLArkqRZo7akKCb6nVMopynrNB1tvg+rjIzcFYa64BtyKS3rkGbSmxtnOoeYx862ps7Jj71uDatksnXkO7wMcHhasoelziczHWAqrXkZLhUwEOozBXIvrlUbD5+XXd3cZXhbdgYe5aHaidPhBl0cpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV/cljLZoswCIDU+4bO2ktfKhzlfD+bjI72873UFg3A=;
 b=VplXKPlCJzWAi99lV+t7XE0Yb07ezWmA1h14CFGsVCR8xrqS2DUly4Dwyp4PmQo2NvErXcratiEYOVBxL+GQa0C9hpK5nVYBU3rjSHkoxzjbCT+X265NLtkp22ViT+/GevjQ3I0fwNV7yjrhBGgr0zg3XTT9XGZtdwBoPt950MMcNtC1QIRh78mMF8CjunT2RQZpK9IWFVQHskhtn+oeS3iJ5+Aa0bvPihvPKoH6DAaG8HpsVXas26i8RTg0/WgC/HkRBrq3jZrNEmSt6eaZHYW9klMzLc+vyPc1ti3XIKBvER/bUiDBo96cxuKVo8szVbjqo2mz5pk1nldiqawwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV/cljLZoswCIDU+4bO2ktfKhzlfD+bjI72873UFg3A=;
 b=psxSTEGE3vhIcbhHsUPEI/aVuc8lEuTAtvNyl4A3XcQTxf3kGisMPAxcFICwvBXmUwmOMRP/qezDE13VRJQmmnbS6az0nOtH6CpcOMrRVs66aMEm/zZmDTQbaJa6oPX4rsrBgBLsuhpWRh6XKjYH0b8OxaDrNJBrF0HRQBPWrlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:10 +0000
Message-ID: <a4cff15e-2da9-4d00-85e8-d18e7e0f67fb@amd.com>
Date: Wed, 5 Feb 2025 11:46:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] cpufreq/amd-pstate: Convert all perf values to u8
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-7-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-7-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: da659cdb-c977-4959-4c41-08dd460dace3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnNYdFZ1L1NjYXY4SnRBSmlaTG1HbFRiQmhsNHMxQU5HdzBrWm9uTVU1RWZt?=
 =?utf-8?B?VTYraCsySHVKNHRkNzJZaURuZlVvcjN6OGFqOGFxTy9YVjZNR3FNVjZlbmdy?=
 =?utf-8?B?dWxYVDBHazUxZ0c0QVhlQlRobnE1azkvRGxKejU2cVlidkZENkNDKzY0MmtS?=
 =?utf-8?B?M2srMFVSL2NVWVdVQWEzdkNQVE1DYjVvcmsrMFV1VS9WcWhUUTZrM1l2SEd6?=
 =?utf-8?B?YnlvQ2pWRFJOL01lNHJ4K1ZQM3ZMODYyZmVoMlppYTl0eWxHa0NDM01yUDln?=
 =?utf-8?B?QlROZXpxV0l1LzVFUUFvYzJ6NWF6UG9DaGZVUmRmWTRwMldkSldVeSs4RGJr?=
 =?utf-8?B?NGgyYnY0eUozN3NPYlB2OVhCUC9ULzdaUFRabWFJUjNMZy9QR3dMb2ZpdjRl?=
 =?utf-8?B?TkMrNjFJR1EwRTFrMFYvK0dxL3IySVRWTnhuWitWVFJoNzJjbzJtdVRhYnlm?=
 =?utf-8?B?VkRRU0RleVlHV3ZrQjVIc3NNRG0zcFJUUWlFcDJpbVhxdE56TDRzR3k3Znor?=
 =?utf-8?B?Um9FYmErMktXMzFURVZNY1RjemtIUkpKTkQrckFzQVJUZFd4VFFwb2RqYWlk?=
 =?utf-8?B?eG5odWpXWGpHb2N5azdKNVpUNGJDZVZzMlArQkMza1E5MnpzZTFvU0dEWmdE?=
 =?utf-8?B?R2R5TzlsT3lJQTNuWWFnSS8wVFltZGQvQnJBREZqdmR6NWxteUFIVEgzVDVI?=
 =?utf-8?B?aGhYZTRWanFlN29DSmhmczY0dlY0TlJrdnZLdXRHODY1cFVCaFRnQ1NOc2Ur?=
 =?utf-8?B?amNTY1NiRWpZaG9RR3hGMVVTNmpRcVA3T0N6ck9BVVJBZGNRSHBCdUg4MW9z?=
 =?utf-8?B?Wm83VHZvYkZyc2xiNi9MelpOU3ZDRFlXTjR4VlhKeVptTkNDZFpaSVhqY0ht?=
 =?utf-8?B?YUlrZ3ZKcFI2Yi9vTzhicUJ5WmhZTWdnYzJzVkFpZllzSmcreENWS3RlMTVI?=
 =?utf-8?B?SjJ6eU5iZlFNQ2FoNnp4d2Iza1A0dm1JV1Z4eXZlRVNRS295ZmJwWExuZDgy?=
 =?utf-8?B?SG9BVnNleEozdWk3MndoWllQU2NkZ291cTFyVjNnbG9KSXo3ZzVNN21MRVVn?=
 =?utf-8?B?ZVMxVGZTUUo0ZUxZV0dTMEJIZEV4U3J3WmZRK0F4ZndUaU1NMERuTWF6ZTBj?=
 =?utf-8?B?S203RUkxM1p5M2dKR1cxUEMvaDVyQkxxazhRNjE2bGR5QWpzMmZzRFFkeWJI?=
 =?utf-8?B?MERYWldjM0lhaTM5T0Mvb2E1T2E5ZHVLYWhkMlE5Tit3R0wwVURvaEREaFN4?=
 =?utf-8?B?NE5XZVdTQlg5ZVk0R0FxK3N4ZzhHb1Iva2RoOEs2dTE5aGVBWVRvTjR2OC9F?=
 =?utf-8?B?MlQ2S3BYTGJaNU1UTkJmS05oRm54SUN5U0dKZ1ZpeitEanJMYWduT0g5OWd0?=
 =?utf-8?B?QTJ0czZBRWM0cWROeWFubVlBSGE0UFRpeUZaWU9jUTFPVVI5c2YwOXYrV0Iz?=
 =?utf-8?B?THZpYk4rUnZ2d1dLZ085U2xxZnVYb3FrYXZGcy9FR1NYWjYvenV6aE1SandH?=
 =?utf-8?B?Zi9IcFBsdERXdlRsY3cvYzdLaHdzSjZZNmlJc3dESUE3NFY3QWU1MEptdGJp?=
 =?utf-8?B?RGJRcXk4aHd5UG5ERzZXaWdRdFVUSk9oK1BGeWJNY0xVYnJtc0R1VGVWSjBn?=
 =?utf-8?B?LzlMQ3ordUtXc0xnbE83U2d3blpvY09wL1V5NXBBcEJvcWVJWWJmQ3pKUGdI?=
 =?utf-8?B?RkQ3UitlK0d0Y2RsQkN2blFxSzU4Z0RQTWZRR0JqdXh0cyt4MkNGTXZDNVZC?=
 =?utf-8?B?SVlYc2FySm93bDVMeXVaNlVrUVIxdTUyc3JleGRnTGtHYlRES3F2NGR1OS9u?=
 =?utf-8?B?VEdNS0RldVFnMlhGRzNFQkZiTnJqeTVGTjNOa205L2VUK3pIMUJYWDhLUUxs?=
 =?utf-8?Q?n1E+hGQYYzKDF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3AreGZaTktyMzJUNGYwYjhudUU2dkN0dmFDMmlUbUFkaGR2OFN4S2VtRm1K?=
 =?utf-8?B?QnhSM0lWUVhtK2ZMeW50NHVJVEdEZjUzanJIb2NqWjJNc2hzWFBBMXRCcWp4?=
 =?utf-8?B?RHU4NVhKRlR4WWttbTltbTgySWtHSitYUXhkaWRrNUJyL0wrL3hCYXE2a0Zv?=
 =?utf-8?B?KzdPalAyQ3N6QlJLZlBnSkFoc0lJd1lvVTFUdERzd2hKVEd6bmVsbjdNR2Qx?=
 =?utf-8?B?QkhEd1RKd21hRWQ1WHMrQTVPL0EydnZpSUR3TFp6cHdETVZjdnhvcGtwL2ND?=
 =?utf-8?B?SDZYeWRuOVpVdXFoWW1FNVBrRENtTUw1UTlVb01yRVZ5KzBBT1AzYmk0L3Nk?=
 =?utf-8?B?ajczNkVhZDREc3J6ODQrZzY4RW91S1pGZHVac285My9iNGg4UCtEU0ZwaHU1?=
 =?utf-8?B?MVd3aVBBOGU4d0FSb1BLdHBFZjRTd3BwcXNWd3NYMEtwWDVOcDdJc1NMK1hQ?=
 =?utf-8?B?YlY0bk1RVmEwTU1naTZuZGF5aEtCUGRFMmJ5dEpyT2x3eExoWm9kbWR4eTJE?=
 =?utf-8?B?WU5CUXhTeHV1U1F5S1FEVDFIRXlVWFpHTDIwM00xVFF6TU1tVGxwQjZNNG5P?=
 =?utf-8?B?RTFvZjc3dzc1SHVtSGVGMHdVZkcybExGeGlvZjgreVJCaGVNQThCZnVxS213?=
 =?utf-8?B?aHFwaVI3WnkwR0FYWWdiQ3NRNXlscEp5VzdhZU9qYldRb0Q4K1FKWnd4S0xz?=
 =?utf-8?B?V0JVSVRoaFVRUUduTXc1TWNFWk1VZXU0MGpyTkJXeEMwTHdXNFRnVlFENnNk?=
 =?utf-8?B?V0ttVFBvK2dSZUNZdTBVSmJCaXRGZEdjeDJBOTNqYXFheDY3aFF6VE45aFR0?=
 =?utf-8?B?TXpoWjFISXAyakhkRnc4b0JpVFVyT2JYenNCS3Q1Mmd1VkFTT3BQMVdBZWo5?=
 =?utf-8?B?WHV2OGVwSldWNDRGTSs4SGU0a3lKMDN0a2pMcHh4YVplRmJTeER3OWN5QUtW?=
 =?utf-8?B?aEIxUlE3VkFTRll1MVJ5V3dBbENETENLeVh6Uk9jbXdNZVdPQ1NDNHdJRVdr?=
 =?utf-8?B?b2NOdzhlRjZkYTBIeDg2VUFjajQxV1FwUlZuaVI1OEpKUTdaUnBadWMxS3ZL?=
 =?utf-8?B?dVFyaUR5TkJ3V24rc2xmYVNRNTV4V3BUajZ1TTZKZnRTVFcvTjJxU1lhUXll?=
 =?utf-8?B?L0w3NGxmbmhIcjZLVFVyNm9kd2tzY3hvMzVuTHFSeG5wOU8xRXp2dzI5MG9y?=
 =?utf-8?B?dklsNmtGOWZmN3krYVkvUjJPWEE0OC9GWmVMZnBnOXFVVHRpcThIbHdTSHBi?=
 =?utf-8?B?cVFuL1pZYVpMTDVDY1hnUmp6YXo0ZzAyaGVQTHRLenhBWG9SNFZlVnVmcjdy?=
 =?utf-8?B?Sjc3VWJGcDJtbEpoalNqSXBGZTd4blBkNVJzcjFwNG5Bd0JGcWxqNVlSbm1Y?=
 =?utf-8?B?V0YrL0xET2FrZitFRmdBcWdkL0o2aFEyd2cxemlnY3I2M2c3b0h0eHZCcjBa?=
 =?utf-8?B?dFFQeU9qWFlRT2xuYjJVcFZFN1lORk1xU0lVSTVQbURZdjhRaUdJV1RxYTQw?=
 =?utf-8?B?VWd2RFhRUlNDQkRTTk1tdVZ6MUpHY25tOGswdlpzNGkzUFZ1UTBVeitLakl6?=
 =?utf-8?B?WklhaytOb3RNS01Ia1Axc0Q4OGwvV2RRd05zZWRrb2FHYytJVVRNd1ZFcEU5?=
 =?utf-8?B?NjRsZEdxK1Q5T3NVK2dvemRQdC9PdFI0clVSNzg2QlNHckJtN2tDcjl1aDgz?=
 =?utf-8?B?SFN1a1oraFhucmJEWUFDRnBoZTJaVUxVeDZZVDdpem5WOUdic0FyRXRhUzVr?=
 =?utf-8?B?NkJGQzZVUlUweDcxQkVIRmlwUldPUXJhdVFwVy91WEZLRnpKSGk0QzFJUzVp?=
 =?utf-8?B?UzNQUkc3SFRUMngwblRIMUN1UGpFdTcvcGZrVEtMZFRvSWJPaG5IVkIwdFNS?=
 =?utf-8?B?Y01ibjlkUDcyeWRzd2t4K2grUENtVWxEcHB1cWovNUdxVTNUL21La0JmYjFF?=
 =?utf-8?B?NWdydE9DckxJT1NFbUw3MGJxeit0NytPODJtaWJPRys5VDRDNlAwRlJxelp3?=
 =?utf-8?B?VmNuWlpWbnhMaVhCNUV1cERERUl4RUVSZTNIcFpmQ0RFYldhLzlSODFSZ1V3?=
 =?utf-8?B?RUdtK0xZQ3BDcmNRU3lUME0wS0l0OVhraFB5cWVHQW1iQzdjUXJtcmlMeFBU?=
 =?utf-8?Q?CK/bbe7X9apVmIKzG8eyrvzW/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da659cdb-c977-4959-4c41-08dd460dace3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:10.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksW/CaEdukTSf8TLr6bEmOm9tBlEisTE0s4ituGgPie0FPYu2OPLFgugltoHqV+P2FtzWF0nIQ8FIXf1TIwLag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> All perf values are always within 0-255 range, hence convert their
> datatype to u8 everywhere.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this for 6.15.

> ---
>   drivers/cpufreq/amd-pstate-trace.h | 46 +++++++++++------------
>   drivers/cpufreq/amd-pstate.c       | 60 +++++++++++++++---------------
>   drivers/cpufreq/amd-pstate.h       | 18 ++++-----
>   3 files changed, 62 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index 8d692415d905..f457d4af2c62 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -24,9 +24,9 @@
>   
>   TRACE_EVENT(amd_pstate_perf,
>   
> -	TP_PROTO(unsigned long min_perf,
> -		 unsigned long target_perf,
> -		 unsigned long capacity,
> +	TP_PROTO(u8 min_perf,
> +		 u8 target_perf,
> +		 u8 capacity,
>   		 u64 freq,
>   		 u64 mperf,
>   		 u64 aperf,
> @@ -47,9 +47,9 @@ TRACE_EVENT(amd_pstate_perf,
>   		),
>   
>   	TP_STRUCT__entry(
> -		__field(unsigned long, min_perf)
> -		__field(unsigned long, target_perf)
> -		__field(unsigned long, capacity)
> +		__field(u8, min_perf)
> +		__field(u8, target_perf)
> +		__field(u8, capacity)
>   		__field(unsigned long long, freq)
>   		__field(unsigned long long, mperf)
>   		__field(unsigned long long, aperf)
> @@ -70,10 +70,10 @@ TRACE_EVENT(amd_pstate_perf,
>   		__entry->fast_switch = fast_switch;
>   		),
>   
> -	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
> -		  (unsigned long)__entry->min_perf,
> -		  (unsigned long)__entry->target_perf,
> -		  (unsigned long)__entry->capacity,
> +	TP_printk("amd_min_perf=%hhu amd_des_perf=%hhu amd_max_perf=%hhu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
> +		  (u8)__entry->min_perf,
> +		  (u8)__entry->target_perf,
> +		  (u8)__entry->capacity,
>   		  (unsigned long long)__entry->freq,
>   		  (unsigned long long)__entry->mperf,
>   		  (unsigned long long)__entry->aperf,
> @@ -86,10 +86,10 @@ TRACE_EVENT(amd_pstate_perf,
>   TRACE_EVENT(amd_pstate_epp_perf,
>   
>   	TP_PROTO(unsigned int cpu_id,
> -		 unsigned int highest_perf,
> -		 unsigned int epp,
> -		 unsigned int min_perf,
> -		 unsigned int max_perf,
> +		 u8 highest_perf,
> +		 u8 epp,
> +		 u8 min_perf,
> +		 u8 max_perf,
>   		 bool boost
>   		 ),
>   
> @@ -102,10 +102,10 @@ TRACE_EVENT(amd_pstate_epp_perf,
>   
>   	TP_STRUCT__entry(
>   		__field(unsigned int, cpu_id)
> -		__field(unsigned int, highest_perf)
> -		__field(unsigned int, epp)
> -		__field(unsigned int, min_perf)
> -		__field(unsigned int, max_perf)
> +		__field(u8, highest_perf)
> +		__field(u8, epp)
> +		__field(u8, min_perf)
> +		__field(u8, max_perf)
>   		__field(bool, boost)
>   		),
>   
> @@ -118,12 +118,12 @@ TRACE_EVENT(amd_pstate_epp_perf,
>   		__entry->boost = boost;
>   		),
>   
> -	TP_printk("cpu%u: [%u<->%u]/%u, epp=%u, boost=%u",
> +	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
>   		  (unsigned int)__entry->cpu_id,
> -		  (unsigned int)__entry->min_perf,
> -		  (unsigned int)__entry->max_perf,
> -		  (unsigned int)__entry->highest_perf,
> -		  (unsigned int)__entry->epp,
> +		  (u8)__entry->min_perf,
> +		  (u8)__entry->max_perf,
> +		  (u8)__entry->highest_perf,
> +		  (u8)__entry->epp,
>   		  (bool)__entry->boost
>   		 )
>   );
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e179e929b941..dd4f23fa2587 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -186,7 +186,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>   static DEFINE_MUTEX(amd_pstate_limits_lock);
>   static DEFINE_MUTEX(amd_pstate_driver_lock);
>   
> -static s16 msr_get_epp(struct amd_cpudata *cpudata)
> +static u8 msr_get_epp(struct amd_cpudata *cpudata)
>   {
>   	u64 value;
>   	int ret;
> @@ -207,7 +207,7 @@ static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
>   	return static_call(amd_pstate_get_epp)(cpudata);
>   }
>   
> -static s16 shmem_get_epp(struct amd_cpudata *cpudata)
> +static u8 shmem_get_epp(struct amd_cpudata *cpudata)
>   {
>   	u64 epp;
>   	int ret;
> @@ -218,11 +218,11 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>   		return ret;
>   	}
>   
> -	return (s16)(epp & 0xff);
> +	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
>   }
>   
> -static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
> +static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>   {
>   	u64 value, prev;
>   
> @@ -257,15 +257,15 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>   DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>   
>   static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
> -					  u32 min_perf, u32 des_perf,
> -					  u32 max_perf, u32 epp,
> +					  u8 min_perf, u8 des_perf,
> +					  u8 max_perf, u8 epp,
>   					  bool fast_switch)
>   {
>   	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>   						   max_perf, epp, fast_switch);
>   }
>   
> -static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>   {
>   	u64 value, prev;
>   	int ret;
> @@ -292,12 +292,12 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>   
>   DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
>   
> -static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
>   {
>   	return static_call(amd_pstate_set_epp)(cpudata, epp);
>   }
>   
> -static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
>   {
>   	int ret;
>   	struct cppc_perf_ctrls perf_ctrls;
> @@ -320,7 +320,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>   					    int pref_index)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	int epp;
> +	u8 epp;
>   
>   	if (!pref_index)
>   		epp = cpudata->epp_default;
> @@ -479,8 +479,8 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>   	return static_call(amd_pstate_init_perf)(cpudata);
>   }
>   
> -static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
> +static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>   {
>   	struct cppc_perf_ctrls perf_ctrls;
>   
> @@ -531,14 +531,14 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   	return true;
>   }
>   
> -static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> -			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
> +static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
> +			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>   {
>   	unsigned long max_freq;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
> -	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   
> -	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>   
>   	max_freq = READ_ONCE(cpudata->max_limit_freq);
>   	policy->cur = div_u64(des_perf * max_freq, max_perf);
> @@ -550,7 +550,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>   
>   	/* limit the max perf when core performance boost feature is disabled */
>   	if (!cpudata->boost_supported)
> -		max_perf = min_t(unsigned long, nominal_perf, max_perf);
> +		max_perf = min_t(u8, nominal_perf, max_perf);
>   
>   	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>   		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> @@ -591,7 +591,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   
>   static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   {
> -	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
> +	u8 max_limit_perf, min_limit_perf, max_perf;
> +	u32 max_freq;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	max_perf = READ_ONCE(cpudata->highest_perf);
> @@ -615,7 +616,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>   {
>   	struct cpufreq_freqs freqs;
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	unsigned long des_perf, cap_perf;
> +	u8 des_perf, cap_perf;
>   
>   	if (!cpudata->max_freq)
>   		return -ENODEV;
> @@ -670,8 +671,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   				   unsigned long target_perf,
>   				   unsigned long capacity)
>   {
> -	unsigned long max_perf, min_perf, des_perf,
> -		      cap_perf, min_limit_perf;
> +	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   
> @@ -904,8 +904,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   {
>   	int ret;
>   	u32 min_freq, max_freq;
> -	u32 highest_perf, nominal_perf, nominal_freq;
> -	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> +	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
> +	u32 nominal_freq, lowest_nonlinear_freq;
>   	struct cppc_perf_caps cppc_perf;
>   
>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -1112,7 +1112,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>   static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   					    char *buf)
>   {
> -	u32 perf;
> +	u8 perf;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	perf = READ_ONCE(cpudata->highest_perf);
> @@ -1123,7 +1123,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
>   						char *buf)
>   {
> -	u32 perf;
> +	u8 perf;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	perf = READ_ONCE(cpudata->prefcore_ranking);
> @@ -1186,7 +1186,7 @@ static ssize_t show_energy_performance_preference(
>   				struct cpufreq_policy *policy, char *buf)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	int preference;
> +	u8 preference;
>   
>   	switch (cpudata->epp_cached) {
>   	case AMD_CPPC_EPP_PERFORMANCE:
> @@ -1548,7 +1548,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	u32 epp;
> +	u8 epp;
>   
>   	amd_pstate_update_min_max_limit(policy);
>   
> @@ -1597,7 +1597,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	u64 max_perf;
> +	u8 max_perf;
>   	int ret;
>   
>   	ret = amd_pstate_cppc_enable(true);
> @@ -1634,7 +1634,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>   static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> -	int min_perf;
> +	u8 min_perf;
>   
>   	if (cpudata->suspended)
>   		return 0;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 9747e3be6cee..19d405c6d805 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -70,13 +70,13 @@ struct amd_cpudata {
>   	struct	freq_qos_request req[2];
>   	u64	cppc_req_cached;
>   
> -	u32	highest_perf;
> -	u32	nominal_perf;
> -	u32	lowest_nonlinear_perf;
> -	u32	lowest_perf;
> -	u32     prefcore_ranking;
> -	u32     min_limit_perf;
> -	u32     max_limit_perf;
> +	u8	highest_perf;
> +	u8	nominal_perf;
> +	u8	lowest_nonlinear_perf;
> +	u8	lowest_perf;
> +	u8	prefcore_ranking;
> +	u8	min_limit_perf;
> +	u8	max_limit_perf;
>   	u32     min_limit_freq;
>   	u32     max_limit_freq;
>   
> @@ -93,11 +93,11 @@ struct amd_cpudata {
>   	bool	hw_prefcore;
>   
>   	/* EPP feature related attributes*/
> -	s16	epp_cached;
> +	u8	epp_cached;
>   	u32	policy;
>   	u64	cppc_cap1_cached;
>   	bool	suspended;
> -	s16	epp_default;
> +	u8	epp_default;
>   };
>   
>   /*


