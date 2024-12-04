Return-Path: <linux-pm+bounces-18560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E29E41CD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617B028675D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882AC20D4FB;
	Wed,  4 Dec 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="11fiOWWJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4761A8F83;
	Wed,  4 Dec 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332084; cv=fail; b=hKBRSnqLISaDeSYpwbWESaJs0tGDKzb9+KiqRTvwgxvq4teZPxXs33UH9HSVd0ULg7ZjrjPi6/d2P5PGxDnw22FCmAPOLeQdTJSQH3csd4yrlU58JyX4HipEgjmjlqdPyjurOVrXJfYA1KAvEOIoL2A8iEITTjDBbvTDYWm5zXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332084; c=relaxed/simple;
	bh=dUUwGSsPOp3KgFA/sfGAuUS78q8GFRv5dBqTANeoK4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRfn2pS6BYL9k/438DVAvkc4s5H8fowH/Jlb5lvzEJkElgHZDkfE6TR+PM5v/UvOesqW/6anTKyQDUs7lpL/H8tH7zTT6HPMCzCuElx6fkVfTzCz8gYimu6OEQyLKTP6Gc9MZJckJfaM5iVVKfYyoQ6a97+OwpdcitN0bBAF0/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=11fiOWWJ; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyAP3B/k42xzmYGRrqJsFsNGICoeZdIu1tD6VxJlTCaM6st6g3FXLpMRI4SYKgqJ/iWxQbaLKXH7qbEXZK6j5OQes0WdE/m0ZMn3XBTbHX3209dFz/G4AbuZQvL839CzcKkphdSfVGa3NwdPwe7ofZ1ArtASjo6XAtl/vuLSjXqRLtU63eR4Xc4UzqJb/PQxzc1sGls+L7m0T70i4U08LtEf+MgGw3h5AjzE0qkzha8A3n7jm/Tg+OcvR6KQa0lSgaj94fskyYWPJZHyYNAgekEhwvp/JVDlmwLQ1eXXAXbvpzatucxJ6gfPz4lT5CqAdLewHNEIBm2vJAxhmd0ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI8nSWSKRTmvlsOO7Z9Xivf51T+CdYlTeoicBCxJYRI=;
 b=ktm2S7xbEiaVSKJbrLWtRymlK+t2Sv9DDhlu2uEBPtQ70Vrfs5oLSjm+G1H/j7xK41STRG8HKJRyOVabcHYV/FGLoJUmsuAJ+Z3S9bNVpAnPPVf0uDdSsH+Q6T2iswoUrObS7+sHG6Fj2cSzq1VGIMidCkhzZymkYc+rCYJxUKvEHo2zT/180oZOqq6p6DFl6Fp/NCYItw9kT8A9WgPthh05CWF7YItseXfaLJxusKJLeUAZMqBuCsJxILUGF4J45n9ZDUXrpwJ6iKL9aE8BciKCF6QplWyNPMQ51oj21I0LoJ+V+7OekXF3RUICKfOBVn+PF0kG/hPwNTt+edisAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI8nSWSKRTmvlsOO7Z9Xivf51T+CdYlTeoicBCxJYRI=;
 b=11fiOWWJrSz8u5MfIiP4d9DPXgAAL+Og1zq0w3SP7PTw7FW70bo9v53ttIuO15X84khsqjybI7WuimCXbvZV+g0SjYDn66H4yw4DCXTZdDgzSSM9abOHrgMprgwtjWSOAnjuBHHPx6zKshJjAqJGBWgSqKiIgonkIRUCASKLtG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 17:07:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 17:07:59 +0000
Message-ID: <9cd10b8b-ff56-4171-ad9c-df84fdad6be2@amd.com>
Date: Wed, 4 Dec 2024 11:07:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpufreq/amd-pstate: Reuse and refactor code
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:806:28::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b97019-bb4d-4ff0-9e01-08dd1486347c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjNPRTZkNVdKYnA3aVlOZmMvTFJHTGVRTE95eXVnRVVhckJJRUwyS0p1NnE0?=
 =?utf-8?B?M0xiMnBDUkNPa3hDTEFCOWhjdWNWVWVNT3hRaHIzTmN6S2dMaGNic0NuRTZr?=
 =?utf-8?B?ODIvdVFiZ3dtaGIzTDA0ZWg4Wk1mSzFGL0RFendvdGMvQlEvd3Uvek14bStH?=
 =?utf-8?B?NTl2bUp4OG0zTzZXVHdRVFJmRElJNGxpN2ZCTThjbnZCNzkrSGxVdGd0b3Ny?=
 =?utf-8?B?eS93WU5wMzg5Nk5nLzFOUTJPcnZodC9NV1hZVG9LYVpHK1RRUEVYS2kzQ1R6?=
 =?utf-8?B?dFJxcUgxRmJ1QUFHRHp1NTRWbUVwenkwTWVzVW9USnpFSXpYWnd0RElPY2ly?=
 =?utf-8?B?U2FRNmFMNFcweWZPNStiV053dFJzSzJVTFBXbnBDNkNja0JubGcrbGlCKzZx?=
 =?utf-8?B?UWtTSk5xS3pvWmw5cGRObDBKVHpkTmg2Y04wbk41ZU5lM092UXBVVzBZcDVS?=
 =?utf-8?B?akxJMEdvUGpqTVFabXRJQ0NIRzUyKytqQThlWUNrc1NzNGRsbGhNV2NXTEdy?=
 =?utf-8?B?S1d2TS9nZXlUUjViWktOazlVcEYwUU5GVkovR0pnMk1Ndy9tMTRjdEFRM2dm?=
 =?utf-8?B?NUY5OWoyL2g3N2NpMndLcVpnUjl0R0ZsZStzeGhRVC8zNVhuOXk0eStjV2Rk?=
 =?utf-8?B?azFPeElsTGt6aHdENDlyZnZhZzJJNS9jQUJpUEp2aWtHc00xVEdsL3FqYUVS?=
 =?utf-8?B?aGhsRWNFRnFVUjJNdExEdmIvSytrS1dQdEZXbTRndkpiU2RoQWRPWWtTaXk5?=
 =?utf-8?B?RnJDT0hGSkc0bi9DaXhUTTFmZ3kxb2hqMHpuRUxUV2JlYmVKNmFJSkRWUHp4?=
 =?utf-8?B?VThndGVIYm9wNy9sT0ZvK2RxZlhuamVteTh1eTE0T3RySkhpUjMrWTl3ZWw3?=
 =?utf-8?B?UkZVd3BKaW54Q0JobGZWcHJTUnFlTnBuU2QzZWFGNmRJcEI4YVFwL0pHbk9K?=
 =?utf-8?B?dFdjRENjTjNzS1lHV0x4SEVJRXYwOVdEV0c4aDZTazRvNkVwWVNDcE8zWHBz?=
 =?utf-8?B?V0l6Nk5VTzhFSThXY0NCZk8xSUdyUW9sWGN3emNGc0VoazloQ0pDQ2pJVW5Z?=
 =?utf-8?B?NnN0N3VBSTFYMDhESk9xWTNlZ1dkQzlWMHBSU21oWU5hRlpBbkZ3UHA0N01x?=
 =?utf-8?B?a0VPT1NoSERnaXZLY3J6UDNFWmozN3FuZ0lYTzNHWUtRSTNOaG9paGVKMEFU?=
 =?utf-8?B?eTY3dFIzbXMybU5LLzF4eG9jNjBvZE1DbGtwKzYxTjdQenZvbG1VL0dybHlR?=
 =?utf-8?B?NWduU2RodDB1V1l1bVdZSm10UXpSZkl6Ym1DZGlSTVNWQlhiaEF1SEJzOFBi?=
 =?utf-8?B?RHNyVkVjeXNYdVBFWWhOaU11WmdiMGJOa01ibmRjVEZYQnUzSlcxajFUakRm?=
 =?utf-8?B?SFBKQWFya0NjZkF1RFpLaWRlY1pVSFUxaUhvbTFiQ0t6TVRQOEhzWGZCeDVF?=
 =?utf-8?B?bDVBZUFidWFmWlNHdmZzbVJOenNWdkZ3RDc3YVgvbElzVGJRekE5V09jeUFr?=
 =?utf-8?B?Y0xxNEdIbVVua2lyZURzSkFZSHNkVjJ3Rlp4alB5Y2x2RmZtR0YwRDd3ZVNY?=
 =?utf-8?B?R3BYbmNXWFVRU2pUQVF4b1lLdkhBYkhJQUJCMnlXVENlbUlOTE1MYi9aajNQ?=
 =?utf-8?B?UUtmU1lQbUZIMTF0cWFoUXhsaXo0Ly9SVmtSejE2emZCS2pZWlNncFM3Y0JQ?=
 =?utf-8?B?MDQ2dVZuVHdkcVRUM2pJTWJJcVE1MHNwUGRrY0M1aGNQSDduZ1M4YVFDbmlC?=
 =?utf-8?B?eVNoSnRNcS91czhCaEoxb09jeSt1NzlMcXJVZjBCbjB3WXhMaDJISkdPUlYz?=
 =?utf-8?B?KzhtYmZVYm1udi9yenJQUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlBWZjU1djBtaVZyVkRrQnhhTTZrU05NUnQ1VFBpUVBhNTVrdTNIbFAxajht?=
 =?utf-8?B?Z2poeVRNbTBjZzFJQnVhU2p5Um5mdTQzWDk2UTk3OThoeFBudEhZNmpVV212?=
 =?utf-8?B?YUkvajUvVmE5WjV6cDJZemNPSVFQdHlPbEh3U2NEUnVDZHpaRU5SM1I2ajht?=
 =?utf-8?B?VGJzWGRoZ0xTMVV3VE5VY1JESWs2L01JUWlNRCtIOFpZYlI4S0kzUTNuUDd4?=
 =?utf-8?B?TU1DZHdkWG1YeVhuNUkwUkNzdDdIajhhZXpadE15Y3F5TVNTTzcxdmZTRUFH?=
 =?utf-8?B?RC8wSzl4SjlySGVwMk1VeUZWWGpaVFQ4VEtveXMyQzJNZTJCcUY4eDdOejRT?=
 =?utf-8?B?NFV4YjFYMkxqMGVYTTd3T2ttZHpQS1BVd0p3TGVpQXdhd1pIQTNGaWJtbXJ4?=
 =?utf-8?B?SXRYVmVMZ3FnaE5oK1BEcjRreDhFUng2M3dpK3hYL3VQcy9NZDRJU2JJa2o2?=
 =?utf-8?B?ZUR1UXBKdFhWbVBrMmFiaE40ZXRjM0NWLytoNEJtcFB4Ly90ZE5ZSDdPWkNQ?=
 =?utf-8?B?NXN5c05PeEd4WGVJNlR0N3pBZUtVSUZ1TWp2dks0VFcxd2pCTVZGSXVNT21u?=
 =?utf-8?B?ZEFzS1VrcmV5SWdoeVM1QlNjSkZGa0ZDYmdkTHBKOFh1Q3FTVzZXSlRRNU9O?=
 =?utf-8?B?TkxNVjhlY3Q3RTNGZkNLK2s3TE4vVGJURFFwMVBQTi9RdU5pY1gvcVFjTy8y?=
 =?utf-8?B?V3orU21SWWRCVWdTNnVhampYaXI4enUvN0p4RGo5RzZqNFhkd2h3dTNrSGtM?=
 =?utf-8?B?TFgySnoyL0tZRDlDK3FWM0ZCZlpzK3V2RXVJeXlhZnJMYTZVUDZEN2ZVUlNx?=
 =?utf-8?B?NnR1ZzJCMXRwT09LYjcyYmxRNHF5Uk1jZmM1TFlEZHNNT1E2N0V3OHM0eUoy?=
 =?utf-8?B?N3ErblcwR3RTamd5NEYzbi9qaVd4M3U5UUhiendMMzBwR2MrclNRcktucE5D?=
 =?utf-8?B?dUFRYStiWVpzcmxvRHVJS2RjYTUxYnNJb1gxQzVmdXI3Si9TN1ZCUmVSYWxU?=
 =?utf-8?B?U2R4SU9TRy9TenM4RysrTjQrUW81ZFhRbVZTaHhnbnRaYytrdFB5bzg0MXUx?=
 =?utf-8?B?ZlRFTmVndzZIRDIzZ2cyOWRIbm1lbWpGSkZ1blVSQVI3N2s5dWdxSFV0Ni9j?=
 =?utf-8?B?N3JIU3N5SDUrdEpDemJybC9rU3FJZmRsMTZKSVpQSmdJVzQ1TEM4YmFtbXRT?=
 =?utf-8?B?UWZZUFg4MWw1R0h1OFVXYTNSNURBcVkzdnhlbXlNZ1V3WmJoMkFGeVdnejUz?=
 =?utf-8?B?TkxBRVpkdnFQc3ZhTXcwZ1pianlDaGV5R2RWWDduVkVteEZ3RG80a0FHZGFn?=
 =?utf-8?B?NjZPeGlraFBpVm9SdXlxVkZ5OXk3RjBzUWRXeDRjZlpaSjBkaXlDUTdBSkhw?=
 =?utf-8?B?c2pobXQwWHFqblNtUUJHK294OHNscUM3dE9Nc3FTQS9XYzRqMzNLN3dUYlJ0?=
 =?utf-8?B?c2M2VG9kRWwzOHVPYmRUdEVMQ2ZCVGxReUN1L1ZlemFkbmFvS005WHhrWWQ0?=
 =?utf-8?B?TjZQbDZKeGhUWlhOU2xOclFHR3ZjZVVSZHNDRHU4KzdackNLNDF1eGJKcGNX?=
 =?utf-8?B?dUFDVzEzS2VVUDBXKzRlQmlwdS96WXM2S0lBS0VuUGc2MlZpV1NxMEhzWGkz?=
 =?utf-8?B?QlJLVEZORnBxQU1USFc4VTM0bVNVZmF6NlNKL3dFbCtYTGRvbFoxUlZSb0ZK?=
 =?utf-8?B?YlptR20rZXp4dGllaTVvdTFTWGlQUkZuUkFJMXR4ZUYvYTE1dEczTEVSamNL?=
 =?utf-8?B?eDk5NHdqU3RkalFjako2U3VUSkZEU0dLZDNVcDlJMVNGMHh4dUNvVVk5cFAy?=
 =?utf-8?B?WEQrM0FYU2YrL0V6ZmhXaExIVng2aEF0Y3lCVVhrc0c1Q3pLY2Y3M1F0S3Yy?=
 =?utf-8?B?bUcvWk1ISTh3cHA5c0dIeGdRWTdXOWQxeVROVUwrck0zSXk1RjRsWGFGbVhS?=
 =?utf-8?B?b1FacUtqZGpqZjdtaTlTS3Fla3V2SVJVOVpjUUhiRFhoSklQVUt6em54Sk5L?=
 =?utf-8?B?YnRiZTNJWVdtVlFYMzhscWhocTJzOHIrNFZZZmljMUROc2JUc3Y2ZlRGNjF4?=
 =?utf-8?B?VGNiQ3A4RS9ocFNxRHc3U1RVaCtzZW5JdVNuaUZueFY3RzdNRWxseUhHRVg2?=
 =?utf-8?Q?3J0GG0YPJLS1G9fItdta6n8zf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b97019-bb4d-4ff0-9e01-08dd1486347c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:07:59.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuRNf31eW3SBa4SiB8eGGgNR3/+pwuquCTmRBvKrdBDGdTHIRzGFoRwykU4hXRkoNT785exmtPvoFq+XTMEtTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

On 12/4/2024 08:48, Dhananjay Ugwekar wrote:
> Use static calls to avoid frequent MSR/shared memory system checks.
> 
> Reuse existing functions amd_pstate_update_perf() and
> amd_pstate_set_epp() instead of duplicating code.
> 
> Remove an unnecessary check for active mode in online and offline
> functions.
> 
> Eliminate a redundant function amd_pstate_epp_offline().
> 
> Dhananjay Ugwekar (5):
>    cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to static
>      calls
>    cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
>    cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and
>      amd_pstate_epp_offline()
>    cpufreq/amd-pstate: Remove the cppc_state check in offline/online
>      functions
>    cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and
>      amd_pstate_epp_offline()
> 
>   drivers/cpufreq/amd-pstate.c | 151 +++++++++++++++++------------------
>   1 file changed, 73 insertions(+), 78 deletions(-)
> 

For the patches not already reviewed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll add this to superm1/bleeding-edge.

I have another series that I will build on top of it as well.

