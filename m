Return-Path: <linux-pm+bounces-22385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090FA3B17B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 07:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737663AFD67
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304511ADC76;
	Wed, 19 Feb 2025 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jKRPNAUV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA29192B66;
	Wed, 19 Feb 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739945582; cv=fail; b=IUhvUe8BoSU3zLH5yzxwwuxSLB4KpspmEjyaVLwhOxO3Zam+Yn75JK6so5xVlZXHLH88ZRhwmJsdRSbrtXzs7QI65t8QYE9/mCT77LIRLKSmI+GSrPYccYRAQ0M/eCfpMlQx1/bloiQAyt6Xwe0pvqgXW+Jbohr9nlIDjstv4sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739945582; c=relaxed/simple;
	bh=DFykbuNgl9ArJ91bAdjwapcMeWruztOvFy79+rNIlTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LsFoQPSxMskq9X09AVxhExeBeCbDmiDqqWiYYUHUEgBCdd0iFOHWwOOCXhGel1bUMfekO4fEuLHlFbbnCaMms7iF1o+WFNdtLRFkG9tsLFhty57+hQZud3hVVVu5pkE8S076sGq8ddO4o9Xc28uSKSAEJ7O2k09eVgZTnKrxFZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jKRPNAUV; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZn3ncMUZboLFVv0AotWNnxqAwwPoM+GyR2cyXQKrgYL5v7IywOD1qfSVA10mnKzFtqST8a1KkwQSmtJZFbB7XLSPV+bafY0k3SffCs/BENvbg4dTMc7oZvXDTqI5qi1/+RWwhP/xF8LZq5PHqiXIQ44YvUMamqfdbQQrd4IsHDKZ3eKsIUkqrcOQzewR6FQOMa/txeA6b/WS0yxcOgqw2d//+E4KaB+1LcnXngWAgXj5Kkhf+IHgzO97lBwQwsGfp1YXMrQAIlcNL2rqN8GabBOWNgSxt26EEvm8uBW3HoTIRIsx7jbFyoT4cs762wimiWcL30wDBEf0HD7yujL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7StBQiUMZ2MBXaVWv+dxKua3PIkYPHsO2e5jh8TnUs=;
 b=p2kF0GAyvEEMz2NrWl4cPLZha69XZY45g7M1dvOkTn0k0L39nDOvui18XXRi/hIHcwnfAlf6YGgEJtIk1+x2thlXJhq6OJPN6I1d5stCoaiAPelqHjqCQGX2Y6qsNSe8KS8kvaokaiJ7PZI7szwwQ4i63DViwsRAMRaKXBdP05VphF1xTDeX6rwrPOiGwK3Tau+fqfxr5U5uTDBJZzIL+l7/wCVDcsg5SwPh+IhCTvUuapZNpK5/OYtA+ntbzhC8fzwSwSPtrylmw49w7JwW0LT0nfpaEKfk1lMRKkrQ/IK1rM2jURXyWJGSH6X6nq1tB+9l6LaAU/KmbR9o/MqGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7StBQiUMZ2MBXaVWv+dxKua3PIkYPHsO2e5jh8TnUs=;
 b=jKRPNAUVXABnUpDdKH0CVHS0Ayb6MmJ5aJg5M6a2VBs19yD6UenX0ArFonKZ1g3H6jD6vG/c8VoBgHuGYQPTpB9LtCrVrJedrd3XgkY3/ls8dhGC3BnnYsQ4hg+XKSgebQ2c++TGXp1b3J1MwgzI3RPACaHIzTqUwG/IBa7jqic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 06:12:58 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:12:58 +0000
Message-ID: <66c37c15-e655-4c1e-ba5f-70307a0c8b1a@amd.com>
Date: Wed, 19 Feb 2025 11:42:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] cpufreq/amd-pstate: Invalidate cppc_req_cached
 during suspend
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Miroslav Pavleski <miroslav@pavleski.net>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-2-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250217220707.1468365-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 668ba40e-b229-4005-8a72-08dd50ac74bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mnc4ZmVtQkpmdFNBOFozZXJzZ2NFS2tKcU54Z2ttc3NDeE1rb2p6UnliRCtr?=
 =?utf-8?B?Si9sV2R1djNyQUVFWXAwOHkvTFh5QmY2Z09Hd3R0RlN6RmlTSnRkSm1tQUFk?=
 =?utf-8?B?a0pNeXJ2b29WU0c0SlJ3U1lhTTRTSXZqU2FHcEtPTmdZd1hoY1ZsdW40M2k5?=
 =?utf-8?B?MnFkRXRuaW1qTjRjeTAxekFyWWsyWThJVXRQR1Uwc0l1ejRGNVptU21Jc0ZY?=
 =?utf-8?B?a2JkQjhDTXRaR2ZHRXBUc0t1Y0xQbDlqNnphSU5SeXZGL0Y3UFZuZDBjQnpI?=
 =?utf-8?B?cjNGaXVrSnREbCt0bEZmVFVRUTJJdnRQdFhPQzRGQ2ExVUp1MzdkV05zVnd0?=
 =?utf-8?B?TENNNENtbk1nVUNkR0hjM3dtVG1YbVk5YlRnbUxrcU5IeXNwdGpQTEFjcHhI?=
 =?utf-8?B?OEZBenN5K1JFY2NSU1ZUaENEeHFmTTNYeDRDekZNc1gwTitybVQ0bEVGa3N4?=
 =?utf-8?B?QjFXTnhWUm9MaFB4ejBDeGlkUFZaRXdKMHNaRmYzS3pnOUdKaG5aTlFPUGdr?=
 =?utf-8?B?eU1XYXZyVVBXbjRmT1lrT1hGcDhaNWlUZGhQYmFLZFB5MnJPM2NiUUE2NTBW?=
 =?utf-8?B?a0FXWlplVFdON1dNNTI0ZHhMdTY2dkN0VVpQaHdIQzFRTVYzMGM0Q1lidnRj?=
 =?utf-8?B?ZXI4U2RNMlpBa2N1RzhIVUx2ai81Q3lsMitSRmJGOVNSenpueUF1V0l0a1NJ?=
 =?utf-8?B?T2dQcmpjSSs0TFlJR1NOR2NqUmsrWS9aTmluOHA2emFCMEExVndPM1pSNzJ6?=
 =?utf-8?B?MzJ0Vlk5eUV2Q0QwcTNwdUJYd2RWc1dRM3QrNitxcTRjNkVhb3VUMHVvRUV3?=
 =?utf-8?B?ZG9hQzJXSDhveTJqNFlKSUlWNlhxQXprWnpacXVjdFFvVkFVQTNMNjNmcVJD?=
 =?utf-8?B?a0VkS1NHTmZKYXZNbi9kcTNHcm5kRC8rYnpiUU96WEZ6dzhsNzV6ZHhGb1pw?=
 =?utf-8?B?dmxSS2pnZkpXcTZUZDJUT2M3MmZZWWFpTDR2MEcySWoxUk9PWi9DZCt6VnBq?=
 =?utf-8?B?dndTV2M4d0JaZjhUU0Z5dW9iS3Z0R3VwM0wyWDVZekhRV2poM0p0MEFhVVJW?=
 =?utf-8?B?bWZNbTlyaEcxbmpueEhmVmNvNE0wMm5lUHpqNjZhSDM5SVFvYVkwZkVGTE51?=
 =?utf-8?B?NW9EQUM3NHdlbHRPWFRHS1VDOVd3Z25ESkxhUzZkQWxFN0xIQ0QxMW1ZdHIr?=
 =?utf-8?B?L2ZJbFVRb1ZtTnpsMDNrRXpUeStBeXA1NWFIRnloRXEvVzBVelBYRU5JVjBB?=
 =?utf-8?B?VnNKaWFnQ0k4VjBDYS8wNlRrSWx1MCtQM1M2cGZoWTViTlAzd2M0N1FVTlVx?=
 =?utf-8?B?WWd2bjZIVUdSMi9ab3crZkQ4MU1pVDYwTVlKS0RwZS81ZEpsc1lOUFdrVGxL?=
 =?utf-8?B?Y3NFb0JvUDVKbFRtNlF3VkZvc1VkQVljRHJ3VDVPUzlLSklhRW8vcWtmVTNJ?=
 =?utf-8?B?eHR5clZhdEpIdGFBKzFIWi8rL2ZWL3d4QXdUQ1VPYXZIbGgzRVVqUXpVVTJx?=
 =?utf-8?B?dy91S3BhbnZxYjNQUTRkZXpoa1U4VVQ0MExLUXhkOUhGckRLaGNyQU1ya1hn?=
 =?utf-8?B?WFAvaWppNGNxdDJGd1N2MDlLcFhTQ1J4Yyt4eFN0eUc4ZGZkR2ZNaFJUdnFx?=
 =?utf-8?B?N1RqRDYyMWx6Vmp0NFVERzBJS1pMVCtXbXl2aVAzY0o3OEpNYnVTRTlKUnZh?=
 =?utf-8?B?UUZCMHhWc01WUmwrc1psN2tGaSs3VS8yVmNEaEcyQnlDYnVkazRRUzRpd2l3?=
 =?utf-8?B?RnpTcGQrRGQrVVBZbkhzbW5UdjlYVmx5WUs1OW9ROE1nOW1QZmZDRk1BdG9L?=
 =?utf-8?B?eGpSYWVzcUtGcVV4MTEzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZUWk5icDAxdGVHbXUrTlBHVVZvWVRkcE55V0EvNUd0M0Vnb014WWN4bXdS?=
 =?utf-8?B?RStmQytEZ3JLUnh4RG4veFJVZVVxY2c5R1lSRWthSVI3UjRrMk94TVl5U2pE?=
 =?utf-8?B?Yk9oMTVOT2Z4Sm02RWlUMFpod25Ed2I5ei9lWmc0dWFSQ3BTMkUvbVZuaG5n?=
 =?utf-8?B?MTk0dDhqT0VpYTZLVi9YdjVmYldqMTYyRDUvcS9xUDdMUlhRT3hSZUtWUG9z?=
 =?utf-8?B?QzhCb3Z3bTVodnA5WklVUTNRSkRHQjRQTUx6eUQ1UmpjcFlQU2FDQVNCTFRm?=
 =?utf-8?B?akREd1hCd3NBUVJHcC9TWVFUOUVBaW5nT3pWVnNyOVk2SHJtcC8vVjRpcThV?=
 =?utf-8?B?b2NtM2FEb29seFlCRTF0NkkxUk52S05KQTZiWW1HdzN0elFIbFZ0YTdvMk5K?=
 =?utf-8?B?a0FNNVhGN3JUanR0UE5mNUMzRDZ5czZwR3V3dUhadUZIRG9LQVVPa3ExSlFK?=
 =?utf-8?B?RFlDNDRTWFlVTXBLQU9Hd0x3YzBmR1hjL084dUlUWnljNUFUZ0FiUHpzdXF4?=
 =?utf-8?B?YnJjT3gxNUREd3ZIUUREMzNiRTdPSWw0bWRTRTZQVWVXRTZQWXZpMUxLTTR3?=
 =?utf-8?B?Q2JOa0Q5bGtsemNLOEFta0VhWTVJa2M0Ulc0ZGpTVFQzMU5GMFROdy8vdkd4?=
 =?utf-8?B?OVVsbUZrSXY0T0kvWS9kSUlMYVQwSjNlelM0UzNYZHh4aDZ6TUh4MWRtMDUr?=
 =?utf-8?B?aDNLbVpHVndMNFd4eE5EKzZyQ3BGa3ZIaXNGNDQvcTJta3REUmNhL0RSUDdo?=
 =?utf-8?B?N1FKT0NocXVXL3hUbllvcHRPSHlQVUE0Nk5Vbmd0cWV0YVdLa1E1WWhVaStS?=
 =?utf-8?B?K2lCUStRWVdDK3ZwYUFpV2l3cXJFQkdmTkttVDF0dFdxZmJyUmFwS1pza015?=
 =?utf-8?B?dm9LVU9RVlZuL3V0K0lnRW5nSHVNeDBZakZ1RU91RTA4d25wRk00UmRTeHkw?=
 =?utf-8?B?aGp1ZjZ6TE1ObVFWaGhkTVNjQWZZKzdEWksyUUFNV1VOSy92MXpBRkdad1lu?=
 =?utf-8?B?cVplZHk5Q0VIQTQyYUp3UFRjUHY1R0FNeG1qb1YvZnpKTTArbzE4VVUwOUhB?=
 =?utf-8?B?SVZCc0ZZeXVDTm4vTjJoV3VPanBENk5ZUHhuT1MwenpYZ3lUcm9zZVZzdVlW?=
 =?utf-8?B?QXQrVm4rRVNZSjlHWXBmRUtYZjhlRno4a0szNFp0b3RlTGUyTG5kTXlDYlpS?=
 =?utf-8?B?UW9jUElqSWtVeTlEcnJ1UERsK1JsZzk3dGZxY3VZWlR5ZXpnZ25Pdjl1WHFi?=
 =?utf-8?B?NlRRcVM5N3U1clJKbDBUak1PRFd0N1F4UHVBRnNyMWtYY0V0M25DOGc2NFda?=
 =?utf-8?B?blhrdHdKQmRzWkVrVmYzcVB4M29LMmhxVWFydDYxUTdqQjZNVFRrdDFPSloz?=
 =?utf-8?B?YTlYNjdZcVJYWHlmY0RJMUhVcldWUUkvYTluNlFTUmE0anFkSXlPSG9BZ0la?=
 =?utf-8?B?Y1FKbFpyR253UmpZakR4MWdCV2VCTUVmaHNkQ0YxOHFDM0VQV1NJR1pjVktS?=
 =?utf-8?B?UjlocXZKUm15dzhSZFVGd3RVNHJFdHFhQ0tET2RLRzZ1UTA2YkVFMzRQeWtX?=
 =?utf-8?B?SURvQkxJMnNtTFVKMFpZdE1MQVp0RjMwd0ZLZG1PWDBOZkRpOGJJUzd2akVi?=
 =?utf-8?B?N0lmVG8rWEdocy9tRnpXYVVxak44aFA0amZRSUVaOFdIVmI0cGlUbmNSakgy?=
 =?utf-8?B?NnFJUTRzSXduanM5c2JPcWxveU1tMEwwanEreFg5a3Ztd0E3TGptamhIQzVs?=
 =?utf-8?B?MXRScm44eWh2UGxzbTVOb01oc09VR2ljVHRGSGVLd21Dd3lNYXc5Y00yanNW?=
 =?utf-8?B?QzlNN1FJbHhGbG1ackljdU4yalRlaVQ1dVpWOWVGazhyb1gvcnpLTWxQQWIv?=
 =?utf-8?B?VUVUZGZyVXR3YzhTRnNkR3JjRjcrZ2g0VXlRTWJBZXg2RHRJOTNuc2Jxb2hh?=
 =?utf-8?B?Smc0WkUrUWNTNEQ2WlNtb1p1NHRPVGJzaHBNQXJ6dkFzOFBLd2M3WHIrWnQ3?=
 =?utf-8?B?WUl3S2xtQkw2amI4Qkk1QlNtdDE3aFJKYWRpa2VJRWthWmJMSHhJQ0xwUDl3?=
 =?utf-8?B?K3JkVTVCQzNHajhxbkozaGw5and0NEkrTFlkZysyWXNTUFAza2RrdW1NM3JL?=
 =?utf-8?Q?ImyPXNjjKPZ2uY/QAmFmIzv10?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668ba40e-b229-4005-8a72-08dd50ac74bd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:12:58.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esM+is8agUDGauq30687yEomx7Qg337TSikN8GwkoRS37QicOkNQgNb4859JHg6hw6Hnz3M3l+0ITQ8KdEpWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

On 2/18/2025 3:36 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> During resume it's possible the firmware didn't restore the CPPC request MSR
> but the kernel thinks the values line up. This leads to incorrect performance
> after resume from suspend.
> 
> To fix the issue invalidate the cached value at suspend. During resume use
> the saved values programmed as cached limits.
> 
> Reported-by: Miroslav Pavleski <miroslav@pavleski.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f425fb7ec77d7..12fb63169a24c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1611,7 +1611,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  					  max_perf, policy->boost_enabled);
>  	}
>  
> -	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
> +	return amd_pstate_epp_update_limit(policy);

Can we also add the check "if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)"
in "amd_pstate_epp_update_limit()" before calling "amd_pstate_update_min_max_limit()". I think it would help in 
avoiding some unnecessary calls to the update_min_max_limit() function.

Patch looks good to me otherwise.

Thanks,
Dhananjay

>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> @@ -1660,6 +1660,9 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  	if (cppc_state != AMD_PSTATE_ACTIVE)
>  		return 0;
>  
> +	/* invalidate to ensure it's rewritten during resume */
> +	cpudata->cppc_req_cached = 0;
> +
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  


