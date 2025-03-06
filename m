Return-Path: <linux-pm+bounces-23578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C73A55757
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 21:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9A93A16A1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DB327183F;
	Thu,  6 Mar 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycDkrcv9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16019DF5B
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292229; cv=fail; b=FQk/19E9yrWGUVfLKl2wVnRye9sCJiiB6FUChefYkpB+Se5ZqFui6K0NdoX4Uh7iO1pUfkFAqWN3P3q/qj2RMEgbbb5cr5hUTsTduSPro+GEpP4mu8elpunlG8hM368xS/WvXxeEW0ZcdRLi/QJe8EptUpzvQvVqEoii3e1sSX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292229; c=relaxed/simple;
	bh=uzWyyZvWr9XB/wlm27HGk1zCgRzCJxdAr5UeEw9OyT0=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=UWLqXMjxiTIjT9YPB5+cIFU8SVyaBpGVLBW+mO4Ypxk4jGx+R7jqf3m9gKn7K7XML6keDgHHu9LakvY+K0WaSQJiZ0vN4HkR3jLXI/HuEQsvaQrA1niXbOcxlgnsEQSUnbiklCe4p7iJldwJ5BGcsCbis/UhaeJvl0wqlMqFKEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycDkrcv9; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1wOAWJlrefg1RTwbc9yWUdUTpJH+YGSdJ25zGqiCbvNWOXQLKknCbNaNAKgHwrTyovE0UqMa8sU2SD5bcekTqMOFB6Xr8C2/Ne9STtLOKh0oxPnlfu9AT8WSeFCxmxrtVE0k8i85hdPmAICdEAU7So4Ijk4lqLrVxjS4tfw4QIoOR3vNiFtO7E3y2gac16C4/RjDoRWYf1PZrB5K/dw8+0w93m1BCkUuodOsu46yy5O5Tgf06rcpZrHT99Fyv2i6R6GLBeZ+CX58Ok8twWNVtKEduZQdwz+A6XcXx1ED6rAJHIgRRtSDqdRK25K1TZQgHX6+3nEuDDveF4d7Ca+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/s/+sPHZIWAZtIN9yQ+mHh6xAN7Zkmq42MFZ7A6kcA=;
 b=vRHedoOH8Vaj2yd6kuv8WqyOqw+cEe7mCeKOFKdDmVpraD6jaMd5aza+DtB9B15B9cYIAa+Vy9L01n/VldUMVV666nHhOWXaCjg7NSk+9FRAQL20icoESQ1rHb1Esv1P7WiutihflWeGwOwtvlEQsE3lVz/QhEgVgRIY31WxwqIL4JEBtGW/3ZMQAt+7VejW/zQwGP5ALNhRmeRx9T0TWYL6+00YTHJX4ioF+2zI+EHdvOzKAQ9eVLpfYCIlcQBB/fIcRDcYQzFxndffu6Q7kgLn5rnU4OkORg5FccEwJkoyEzaBwkgWopjbxRcfSgGn7dGVp3dBSbRekzct8wXNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/s/+sPHZIWAZtIN9yQ+mHh6xAN7Zkmq42MFZ7A6kcA=;
 b=ycDkrcv9oq4pFFgBa3RlIw82QvVsnLEEouIfbK8iHTlPY9Soe0jONPU0cL0bESe1mDS3x0wVB6k86rNLe9IrwZE++kSj1Rnaw1q/4ww58iuMuEiedfxKN/Bk72JbTdqarhwVErjPLemP7SVU0Jo4rIyeEhlG+hkNBfK9xQ17Sxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:17:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:17:04 +0000
Message-ID: <206f245c-d6f6-4dcd-a2f8-643c8100622d@amd.com>
Date: Thu, 6 Mar 2025 14:17:02 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Ugwekar, Dhananjay" <dhananjay.ugwekar@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [GIT PULL] amd-pstate content for 6.15 3/6/25 (redo of 3/3/25 tag)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:408:e3::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: fdebc094-4313-4bf9-34c0-08dd5cebdc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1hmVEZLQ05jaXk5TXByWDBUMlIwckNmQm1rM1UrU1lqc0kvZ1FxMXlBMzVk?=
 =?utf-8?B?WjFmUlBnSFFocW8yUkQxY3ROQTBkOGhvMUZrdE5QQUMyNm9FaFJ2V2RkTWlv?=
 =?utf-8?B?VUc5d0QvaGNWMEhMSThNa2tBMjB1c2loL1I2bllYWVpEbGVKcnRVYlB2ZVhM?=
 =?utf-8?B?VTQ5alo1T0p6bTNSVlJGSk9qQno2WmdpMm5xckppQlhRK1NmM3J0UHZXSGQw?=
 =?utf-8?B?OStDaG4vaEN1UWQ3aEZHMXZHRGJCUlNpVU5FaGdxSzMyc2gwRkduVjR4b1F4?=
 =?utf-8?B?QWRJODl0MTdHa2MrU3VMcUVXeXhwdDRxNnEwTmNhc3dBODBNZGFCajgyemVv?=
 =?utf-8?B?THE4N3ljWExmK09ZTHRXWWlTMjk0Wk8vYkpxVElQNjBLYXVvakp4MVpManBs?=
 =?utf-8?B?SkMyWk9paDhYSmJZNm9WSkMzZERva0F5K1F2QkRiRTYrdlE2d1JmVTQ0aklB?=
 =?utf-8?B?SHBGN1NwQllnMTNscHFkMmM3cjdOOVZDYVBieEE2blZ0R2dhaHdtQ01kRGlZ?=
 =?utf-8?B?VFVSR2o4S0NjNTNJcktmOVpuNllGYUc1TVAxYXhrRGZPcUNlQjlxZ2g1Z2Ey?=
 =?utf-8?B?VEU4ZWF4bDI1bURTM0EzZFloUDBJaFRNSlFtbG1ITTFYSS84MkFSak1XYjlt?=
 =?utf-8?B?Q1NKNzlSRHNKSHdSckRwRXREODZkSmJ3NHgzVW5ZOWU0UWI1Vi9uZzdkNEZn?=
 =?utf-8?B?cXI5L0VzMDFOeXF1QXM5eUZmdnI5cys1SDF2K1ZsYlhNSDgxbDI3Qi9QalRj?=
 =?utf-8?B?bnNSamtNUklpYWxXcjl3WnlHQ3llN1BxWHB4b1lmck9qTWhMU2p2SXJvZFNM?=
 =?utf-8?B?c3Fic1FndHMzNjJXcG5FYVN5WktlMGYzbDl0VVQ3RTlsZjhQL0tsMXRMT3NI?=
 =?utf-8?B?aS9SNGRhSEpob2FvR2czWGZyNHQ2bWcwbEkrZ3lrZnZyTTdrVHRmNjlQcUhj?=
 =?utf-8?B?QnRwY2NkNG9ESEpnZHRDMlhGTlp2ZTNFWXBpTVppc1I5Tmh1UEhWUFJvZ3NV?=
 =?utf-8?B?SkZHL3M0aXpCMlUvMExZWFBKdXhjbER4akdkZWNSODI2encxOWoyYVFBV2Rz?=
 =?utf-8?B?dzk0ZEVkYUVqd004OVZ6bFJ0RU1HZzMxMGhrUWZuTUJCZ2ZsWFRFbFNUQk9l?=
 =?utf-8?B?dDdGZ0k1TkVaN29DMHppTXdXbWJhTjUvZzJVWVBhdS9sTTFMbjB6ellaQzU0?=
 =?utf-8?B?VEVsSUJsUVZvWTlua29xNzZFalBSSnA2ZzlzZXBvVDFDMFdhSDFWQ2gvYy94?=
 =?utf-8?B?VEFraVNsc1RnUld2ZEt4UnVvTUYvVlVkY0NJV3o0amhIMGt6c2ozTkk0aDUx?=
 =?utf-8?B?bjV0UnRhbUUvRUsxSTUrZlEwb3RZeVhROFFIY1N3MmR4akFkcFMwcDY5SnN2?=
 =?utf-8?B?Z0FlcjgvNmUwQ1ZUUjlyYjM1cG5XTDhHMHlYK0sxWkNsaUtBVG9nY0hZZUtJ?=
 =?utf-8?B?SGhrRy9renZHM1cvc0xzbHhySE8wR3Ayb25xbXpQYS9YMHVLOWM0ek1Cc1FX?=
 =?utf-8?B?U0ZjY1ZxeVJ3MHFyWkRpN3FDdm1yaEtFQ0poV1ZmdkIxbERlNDNnakVLemZi?=
 =?utf-8?B?dWRWZXVNTDIwUmZ1SXdFOGZnUE5QQ09CMjk1QVVsTTZrdk84K3lWSG9manRT?=
 =?utf-8?B?RXVybVV4YTNUYXVkTE9iYUV2SVgzVjVuc25LWUJrcVhCV3p3c2YxbkZqZU54?=
 =?utf-8?B?MXBRZmZiS24zRGNzS0grY3NUdlhXSWpSV2xoNzkxYU5qYnVGYnBPVFVvL1Zt?=
 =?utf-8?B?RHh1ZERxNzY2RG83N1dRSEhWdGFpOG9WZVJNQ21KaHpYWkFxbjZLWkt4VjJz?=
 =?utf-8?B?TUJCVFd3N0ExV1pyRUFCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHgvdEdEbjVuTE41UXRqSDVCN2wwZ2NkVVZDK1JTeGsvbW9LbjFhUll2cllW?=
 =?utf-8?B?QWJVdzM2WW45QnQ3RHJ0cWl2RWlMMGRMVDlFWC9RZGFOT3cramptSzRBaTN2?=
 =?utf-8?B?MEhHRmwyUEFJcG5lRGVTRnNlU2hCYWViSEUwQXN6RTZQdEpheEEwTHdnZUlx?=
 =?utf-8?B?SENHZm9LWnREWjFNNTQwNnJyNkRBUUhQR05LL3BaVUtDRHhlcDBna2wrYXRL?=
 =?utf-8?B?UVRYNmRHZkgyQ2VwVTFMektGSjV5TS9iUXduLzBLOHFuZDE1eHVOTWVDQVVV?=
 =?utf-8?B?eFp1MU9DckthVTdwSlZaNDVxakxtRFdEUkphSVNEekFUMFBNTE5QMUZxNTFV?=
 =?utf-8?B?L3hyVVY5Y0NZc2dMWkRXTUJhbjFnVmliWWNBeHlCSUEzWTdDWnNyeVllamYr?=
 =?utf-8?B?Y01UcUZJNkxrODMwdHZwdHVwYm1rWTMxeWxSaENnVUZybWdrdzlMeXlNa0c3?=
 =?utf-8?B?T21qSUxvYnR0dU1mZE44bFpidDlRcDB3NmJZSHBnNFRZUTQ1a1BIcmNPY1o5?=
 =?utf-8?B?QUFqb3JJS0VvMW1mQ01LK3l6SHc0SmZxTi9Ka3hlZElCelBWbW1HY1JFcmZs?=
 =?utf-8?B?REh4VC9SMlpzY2t0THNrQUZVWHhOV2lMcVhFTjZvSWRYZERZK2ZmNkdyaWFI?=
 =?utf-8?B?RHducXZqbW1BNUZnOEpJQ2sxVkw4N01uSFRSUDJHTEc0UGVxWlBNZXpDVEZR?=
 =?utf-8?B?dTQzYVl3MzkzcjFGR1QxREcyUEJwWVJYRmpMTmQwcmgraGFyOE5JWUhZQ054?=
 =?utf-8?B?YlFVaE1TRHdjYXJvaE1JZG1oNUMwbzVPV1Zpd1phUXkzSXF3N1RTM2NvSFZK?=
 =?utf-8?B?V2ZsNzk5aTIrRXo3cGR3V25PRW1qODN0a1pFWUFsUE9kTDNwYVRKa1hPQUhx?=
 =?utf-8?B?d0phUVBJeFdCN0VmckxmQU92emRJSnJLeERwcXRZK1IvUWF5dGVUVk9hWkRQ?=
 =?utf-8?B?ZXpheE81cjhwRXRHc2N1Vm5FTk1rcmJERWk2a1krTm9zV3EvbDhKNXZyU01R?=
 =?utf-8?B?TG9ORXAxa2d6V3poKytMbGV5TjFzUStrbnRSTmpMdE4wTW9zV0RDclZvOThC?=
 =?utf-8?B?NTNBWUxhbExaS3cvb0EyOEYxM2hvd3VXK2lmdVBoTFhxRmJ6UUxRaEJYblYx?=
 =?utf-8?B?RkhYSmhGUW1KeEVHcHZUeEs1THBXZWp4bk0ybE1MUHhTNGRCUkE4cFlKU3Nh?=
 =?utf-8?B?TU05SU5ra0xXenQ0RmZLKzB4dmYzTHVqcytkU3dZK3o4a0IzLzQvVklHd1Zt?=
 =?utf-8?B?ODRPS0cvbEhyVDFKLzNxUHdoT1EzTy95c2liWkF6blhuQk0rTWNUWFhCQUJQ?=
 =?utf-8?B?S3JOaXdGaElRcFhqY1hIYkJWK29CUWdrbytIQ01wY2UrZ01xU2lVcjd3SEN1?=
 =?utf-8?B?b2RJWDhRMi9UaDJobFZJbi9vUldRZGxDMUptYUU0c210ZnNiTndFTDkySHJh?=
 =?utf-8?B?ZUNqOHh4RE5QRENYZHdnVXNWc3BJUTlmQVJYZnJ3NFZ6aXFsWGY1WExpa2Zi?=
 =?utf-8?B?L0pGL21aQ3RjTG1jRDVBRDlKNEQwWCtVM1RPQzFLNjVPR0FySFVsZ3ZPK1NE?=
 =?utf-8?B?WFZ0TThMaUtYWmxVY3Yzc0MrV0hybzQ4U2pMZXZMSGozWEd2d1V5NDhFS3Fv?=
 =?utf-8?B?OWcxbVE3aEdBNVlqKzBYZVlDS3R6U3NWYmsrZ2pCTzF3NE9WU3RBVCt6UlpH?=
 =?utf-8?B?Wkl1WU9QeEVKZy9KbEcyWG10S2lPWWw5b2RUNlRZYmxtcDlxUXNaL0UwZEVw?=
 =?utf-8?B?dkZ5Q3g5Z0JPbWk1NHZHcmtScmswM0lvVTdVdGorTmkrTm1qbWUybFNMWlBm?=
 =?utf-8?B?MG41M3NuOW1YQi82aGtWYXVWblBSd2VtVDJqSUs4WkF2Y2szeTZLUnFLWXVX?=
 =?utf-8?B?RGJBaFAxVEN3NWpZU3ZlNTE3cXdJNVBuWW9FT0VWVkorb1NwYU5IQ3VGN1lO?=
 =?utf-8?B?eDhQQ2Yvb1FObXpubUt5Y08zblBRMmRZL2dlc2RPODNkeitKZnhIUEN1OXdM?=
 =?utf-8?B?SDFWRzkwWmVGNVJXa2UveW5OSEhHS244cElmVzZ4aVdDOXowRlVPQzc2NmdR?=
 =?utf-8?B?cWhSU3dkL2xCNWREQnJZSFovM2h4RzFNbzJwZENGbFl5NGZ1OWxWRVpFTENM?=
 =?utf-8?Q?c4L/G4ZuSKACyLmYTYV9pXXNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdebc094-4313-4bf9-34c0-08dd5cebdc5c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:17:04.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu5LHKCH9Oh69NHdLIdiinmDmibbBmOj7+W5vsalVEXnV1rBgMheK5guLL56V/RuAoxTM8gbZVoTPN8mFXODsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

   Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.15-2025-03-06

for you to fetch changes up to efb758c8c803217e58248f03db372c5e23827dae:

   cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline() 
(2025-03-06 13:01:26 -0600)

----------------------------------------------------------------
amd-pstate content for 6.15 (3/6/25)

A lot of code optimization to avoid cases where call paths will end up 
calling
the same writes multiple times and needlessly caching variables.  To 
accomplish
this some of the writes are now made into an atomically written "perf" 
variable.
Locking has been overhauled to ensure it only applies to the necessary 
functions.
Tracing has been adjusted to ensure trace events only are used right before
writing out to the hardware.

NOTE: This is a redo of amd-pstate-v6.15-2025-03-03 with a fixed Fixes tag.

----------------------------------------------------------------
Dhananjay Ugwekar (10):
       cpufreq/amd-pstate: Modify the min_perf calculation in 
adjust_perf callback
       cpufreq/amd-pstate: Remove the redundant des_perf clamping in 
adjust_perf
       cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to 
amd_pstate_update
       cpufreq/amd-pstate: Convert all perf values to u8
       cpufreq/amd-pstate: Modularize perf<->freq conversion
       cpufreq/amd-pstate: Remove the unnecessary cpufreq_update_policy call
       cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
       cpufreq/amd-pstate: Use scope based cleanup for cpufreq_policy refs
       cpufreq/amd-pstate: Remove the unncecessary driver_lock in 
amd_pstate_update_limits
       cpufreq/amd-pstate: Fix the clamping of perf values

Mario Limonciello (19):
       cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
       cpufreq/amd-pstate: Show a warning when a CPU fails to setup
       cpufreq/amd-pstate: Drop min and max cached frequencies
       cpufreq/amd-pstate: Move perf values into a union
       cpufreq/amd-pstate: Overhaul locking
       cpufreq/amd-pstate: Drop `cppc_cap1_cached`
       cpufreq/amd-pstate-ut: Use _free macro to free put policy
       cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be 
the same
       cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
       cpufreq/amd-pstate-ut: Run on all of the correct CPUs
       cpufreq/amd-pstate-ut: Adjust variable scope
       cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
       cpufreq/amd-pstate: Cache CPPC request in shared mem case too
       cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and 
*_set_epp functions
       cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
       cpufreq/amd-pstate: Drop debug statements for policy setting
       cpufreq/amd-pstate: Rework CPPC enabling
       cpufreq/amd-pstate: Stop caching EPP
       cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()

  arch/x86/include/asm/msr-index.h   |  20 ++++----
  arch/x86/kernel/acpi/cppc.c        |   4 +-
  drivers/cpufreq/amd-pstate-trace.h |  57 +++++++++++----------
  drivers/cpufreq/amd-pstate-ut.c    | 211 
++++++++++++++++++++++++++++++++-------------------------------------------
  drivers/cpufreq/amd-pstate.c       | 666 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h       |  65 +++++++++++++-----------
  include/linux/cpufreq.h            |   3 ++
  7 files changed, 461 insertions(+), 565 deletions(-)

