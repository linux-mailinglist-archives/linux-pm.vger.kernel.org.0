Return-Path: <linux-pm+bounces-16662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8329B4BAD
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291271F21B95
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5820696B;
	Tue, 29 Oct 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CBa8zqoO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA942A92
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210619; cv=fail; b=i3TE1njUGeb0wVyaND1EO1RUME/CipsSY0F/NCihFkRQD7+a6yMzJNlmCIbEIabgoRDL4/1VWMRU47Scg13Q9YhsrrR0w9kul21KlZj7Rwk+Be+3e7qFoE8HViNEMR9vCPmehmfJZFc4S8/c5Nx5jTGQslfbaESXAtKDYrWqmt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210619; c=relaxed/simple;
	bh=uj3is4drHvbXK8Vxu+nZlXbpCOleaV3bX2W/K+kQzKk=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=gN0+W6I3RfMhrmbtqAuGj4TQW2vgV3jV08KPPBcrWc3F0NHEx1ygYmr70js9/FOVHBAtx6QXb62PfXVpNSg8+XGGh+dPo0wLn6nh77H/NmO5qPEYhgx2kxTp2N0daXHb6pK1BKiySIxwjiPYhFz1UxLN70eFE/198QAMfFNAUWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CBa8zqoO; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCI3xMSWgdXWz4ncGt+vrQjU1RHh0N5XYYzO4FP/w0am630WyLAy4bvuJJHpRlAd4TOuw+3Kpet35AorCkUy9rbgztn5ZSAqX0300Zj/Rw2ePIj+Y1KsWrd/k+xdW3fvELqSjhbMcIqZxdLXO4kKgqY1aNaVolPN93yys5G64J8IGXJs6auMjwrmQKZsdszxuUUb0BoCylfuA6DZR8of5LpwaD5HVbfcx0xRHxZTCDdb8w4YkcK2owOihwQiT9R+glTvrjvM3tv474iC1lXAs0rXv+zCOoOpTkE6d87b3Ig/hmAaknfrIZRaA54CmaaSGKJdgySPy2bYJIaUO7+Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5lb2w9iEhJw6IWO1Q5mBW9Sjll6IYrmV9v4GS2OnBk=;
 b=mM5/Fjbm3u4iPMFLmnOQX8rmGQVnAlAam3nPsaTxKDiZh0ikgOSLYGjLbeFME9+GDM3rqU8oHEY6Ce/oqO1Gj7DtxolXmx9JC0IeGapH/GUomp21vV0jzRc3ANt5pYkQkV2qs2tiRkL5pleeBYFgrLfC9jOjkQV6yXFmuYxUxEmnqbfgF02PMOt0f+LPYefG7VPmjFA22Kc2DOIIkD0D4HSRTVJ1v46RqeMmyG0VcNLcOFbo8e6ugP8wmP5jCEhPXBuWgGYQ5yIf8hraTob7TRM+oERXVQo4YHAcH1cI/Ofk4LEy+hzMsmOHnMWlKk29ZUTK/7VN16VsQeq3LwZFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5lb2w9iEhJw6IWO1Q5mBW9Sjll6IYrmV9v4GS2OnBk=;
 b=CBa8zqoOTSrPb16C1eGJaXYpU2RuHc65bkalUh3Vo7osBnTqTUNgVDLad+qOpilmbjdi9wniUkzQIYiZz0+c627p/f4eNHckMXrO+FD3NXeSzHi1N2/y81imyTEn5DeuB/XstPiGMoryF/T+m1RfFWmBaC/RDH3kZsoLP3Jafgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 14:03:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 14:03:33 +0000
Message-ID: <7b1d8208-1e00-4ca3-a4f9-7d13c9867447@amd.com>
Date: Tue, 29 Oct 2024 09:03:31 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: New amd-pstate content for 6.13 (10/29/24)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e77b8a-9614-4f10-8f24-08dcf8227974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elY5dTRpbFpGNmd5TVlyZzNkYytuOEVVQ3ZjUzRKeWRDNlV5Ym1CU2RlcWUr?=
 =?utf-8?B?S0lSZWEyMnh3SnM0cDRPWHd1RHFraTBPZW5ucTVhZ3I0NEx0RzZZdlJEMEY2?=
 =?utf-8?B?RWd0Vm84NzdicW9Id2F3L3A2LzFaV1RmNWptQzhpZFpOM2p4Z2dGcnN2Y1VF?=
 =?utf-8?B?WG1oWDl5UWkwa3lGYnJEbDJ3N3ZVN0ZDa3l5Uml2OFVDZkpLQldJYTVpYlRt?=
 =?utf-8?B?V0lPR1FoMUVTTTEva0ZkZEU5Z0lxWG9zaDRDeGhQRUI2RkV2TDVJVk5VNnhX?=
 =?utf-8?B?NnVCd01DaTRSa01XRmlza0xNWGpMQjBDeHFxdGJQM2paUktTT25VckhqZGR4?=
 =?utf-8?B?NlNjTzJUWEJUVFZ5RzBleGpvL3pVamJYR1FUZXBLbE5uQkErN3RxQUFiVUt0?=
 =?utf-8?B?Sis0RDUwOTVaZzlhSmpFbEJ0YWVtWThWUTRyenpTVkYwUG0zUWszUE1KRGMz?=
 =?utf-8?B?dHpKTkIyVUVMNTNGalBpa3VCb2NITTBrRFhMakt3YlNicUI1dTJ2NkZWaFdQ?=
 =?utf-8?B?Z0kzSlhWNEdSc2tJZFIrZml1NHcwdU1UMkdiMURxSUJLUXR5czBENDhkK2E0?=
 =?utf-8?B?ZWNMYTUvcFNFMDk2aHFvYU43b2g1MGd5SzVWOTFKOUNVUnRNZ3UwMGh0UzdD?=
 =?utf-8?B?RkFxQmtBdU4zUzdKZkx6MVVpdXVyNDl1cGYyT1BZbUpJNUhsUit1T01pb1Qw?=
 =?utf-8?B?SGZVaWRaQTJ6QTh3ZjRBOWxQcUxSUTNvQndXSWI5cWlTanE5NUl1djFrV0Uy?=
 =?utf-8?B?QllNYXphVE5SVnhEUHNSdloyVXgwaFJOaE9KUzM3cVFXcHBkdnpSazBEVHpF?=
 =?utf-8?B?YkdkNmZWbzlnUXZDeGVWV0xnMlFHeGViOUk1dDhqQ1N0NC9XVE1EK1RGYm5D?=
 =?utf-8?B?V0FVdXlOL25BS1htbGJZL29yRkR3b1FPLzhyUUd4YkJIby93ank4YklWR1Nv?=
 =?utf-8?B?L2ZMbks3MG1PelhHSWhNdW1MZnROZFpvQTFlb2VpZHF4Q0ttOWR3K3lvcFQ0?=
 =?utf-8?B?bXlSdDZWSVRyTDd1WDFVSCtNUFp2eGtJcGF3VHJKaGpDdDVIK1R3V0RQalI2?=
 =?utf-8?B?WEJJcG1RUk8wVDZleThSWkhBV0xaSm5uK2M4R2s1QkVKTXBzMlFzT0RRVVdM?=
 =?utf-8?B?ZWVTQjBDSGU4Y3BmVGNaU08vbWorSzEwbjhYSmhLOVJQMkZVMXd5dWZKUCs1?=
 =?utf-8?B?bkJVd25JdlFwWENDREVEVklidlZSK1pJcHN1L2h6RWZtZndNSjR6QnIxQ3M1?=
 =?utf-8?B?dXhTUlBwYmJ5N1E5SnQ4dXJiVFg3dFhpbi94VHJmdHA4Sy9VN0s1T1ZSamdh?=
 =?utf-8?B?T3ppRUY2NDlhTHR1RDl1L01hZXRONjMwczVlNnA5dDlhY2R1dE5UUDR0WUx6?=
 =?utf-8?B?L0xRUXhkZC96UThjMVFZeVhQQ0J0OWpXbU82ZWQwYVZVdzhWbHZZQk40bDQ1?=
 =?utf-8?B?MExvYXN1UkNXNGl2Z0N5Z2Z5MG5rd0lBMWl5eURweEpEOXRUUlhKL21RSXow?=
 =?utf-8?B?VlloNDJrZDY5bjIxK0Zzd1UvZjF6SjE2Nng5MWFVSWRXZHFxcUVXZHFJNjlu?=
 =?utf-8?B?aC9RWGVRV3J1MkF2SXQrdkp1cDc5bG5YaXI5cFBwdDg3YjR1cmVpQTl5V3py?=
 =?utf-8?B?UjhGbGZkVTkyYi9idFhiTDA4TFBWREUzekJWRFJwamtkUTNkK2F3eEU0VE54?=
 =?utf-8?Q?X5WQT3MLEJkK/HEP4nwn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1I0Z1dsQlAvczViOXBYYVpNdjRFcjdRYVJ2VlUxWE5KL2RxTjVuRzdzK1Zy?=
 =?utf-8?B?TUozL01rakVzSzEybHRKK0MwK1lRSlROZC9HdjRLRE80d1pUeVdSRGNHR1Ns?=
 =?utf-8?B?cEVob3lNeENiWVdPTDZ2NUNhT1Y4NFRrcVF0NnhZZ3ZLUG4xbXZUUGVZdHAy?=
 =?utf-8?B?M2RNQWlQd3RNOXFIY3paSlg0Q2JoZVBQQi9uTGp3OHk1eEtLMUIxdGdTMndk?=
 =?utf-8?B?M3RHY3pnZ2JXWERGSVFhVkZTSE9RMm5YLzdGTy9sTmRLVzhNcGRzdm10MG8w?=
 =?utf-8?B?dFJCWDZYOW0wZjlSWkVZcSt0ZDdnejZ2eC9PeEVURDFZdmh3MEUrYVM5aVFD?=
 =?utf-8?B?bWcyUlhYTEY1OG4vVTF4UlhsSjhvNHpDaXU3MFhaU1ZiT1c2ay9NWEcreU54?=
 =?utf-8?B?bUNwWXhaeHZDVExsNXB0a1JTZGRPcWk3elNOYnFQeDk0NHpFNGJCK1Z4SE9t?=
 =?utf-8?B?S1RRWGM2ZTNqclBQbkY1WFFhcWoyK0lxeXpDL2F3TU42K3NBQzFPTGdQTjQ5?=
 =?utf-8?B?NkZDR0NWWDA4NDFESTBYeWJmNWp6VUIyMTNKWlBpTCtSdlArSFBaWlZkT1pP?=
 =?utf-8?B?bWdkMW00UDlZSzh0WWtGSzlNaXNyRDBjOFNSSEQxZ09pakN6RHIzNWZmMzFp?=
 =?utf-8?B?Z1BEQ2ExV1BNT2pDS2hZSEFRSldlQzEvZDdZdm5VMzZ5K01tRk1zZkNrMFdk?=
 =?utf-8?B?UmVsaEEyZzFGVSt4cFF1Nm5NcGZqa2dQSVVjNUlLbVpyQ21TbUVXVkR4S1JE?=
 =?utf-8?B?emlVQ0hLOXZGckFpUmYvbVFvZVdHT2VKOXhmb1FKQmZUb1dDcWdTaERqZndB?=
 =?utf-8?B?YXZBQkxxZzB5cGRCZjZ0VzhjczAwUWgzaGtGcEQxZ0NzdVA5RTYrQklHY0xU?=
 =?utf-8?B?aG1mVnoyK1V2MjRtd2pqQzdZSmhmaDNjTWVZQk1OSlZZSDhkUDRldGlGOU1v?=
 =?utf-8?B?RGlGTlFvYzBhVUdnM1daZEF1enZDWTBlVng4dmM3cUI2SXkyd0tqT0RnMTNz?=
 =?utf-8?B?YnNsWUd3NlZ1UEZ5d1dqd2RLNGk3OWJFNnh0VTFvd0pBWjZ0U0hSbFBVcWZ0?=
 =?utf-8?B?R2EvUUdmS1dPUkhJUGpLZSt1Z2dLZDFrcnUxZzZBcFFqUmk0Q0ZtaHhraGxL?=
 =?utf-8?B?NE8yN293S3o0Y3NLbSs4OVRZbVpERDFtV1pNSDBYTm00VllRcUpjeXhxVWlW?=
 =?utf-8?B?T0FxbDVlWERUMjF5YmNLVkFnVUVFSjlGNkZpZmVwVno5aHM2QmZacEV0N25i?=
 =?utf-8?B?c0x4cGlEQVV0Q2tOcmdBN1BzM2x4WTdPYlZJT3F2WXAxSGFXbzUxVllKcGNY?=
 =?utf-8?B?d0w0bEl4OWE1R3RvM0t5Y0J0VTUySHdiUzF3dHNkQU1xV29LY3huZUVQeEdW?=
 =?utf-8?B?QzViVEVIM3pVTnJFZjNFQzVCMHUxRlQ3TDdQa3ZnY1NNWmZTZE42VGNSbVNy?=
 =?utf-8?B?dUFHNjZWTUJlRTd1M1BBZy8yZ2hNZ2VLY3RvQ0ZMR3BOK3RiODNDdlZFL0ow?=
 =?utf-8?B?blNKQitxUHdhYnlsZC95SmRheU9DbVdsTFFsK2s0VGQ1MVU3SUMrdVd4LytZ?=
 =?utf-8?B?Y0RuT1ZmZDY3dFp1aCtnd0djaGRmUjZpTjZESEtLRmFScnlrNmJBdGdSckZH?=
 =?utf-8?B?SENiU0tHZW1xSzc1TzVsZHdmNWFjdHdaREprdTNSZnBITzMvLzZaT3lEOHNI?=
 =?utf-8?B?am9wSHN5RmppN3YvMTNwK3lFTlhyb0hGMG5udTRZaWkzaFc5dVAxSkJxNC9v?=
 =?utf-8?B?ODR6QzlRRTI5d1dOdkN3LzhhU2FDQUJkRnFZVzRvcUlvNFNxSEhCMVk5N25S?=
 =?utf-8?B?bGlNZ3NYSndIcEllaW05MUVRcklHSnZyeWpSNSt1elhJOEhEMUJKMGdjVkht?=
 =?utf-8?B?b3hkN29zUEQrS0drVklOTzVQR2ZqL0JNd3FFU2hsbmpyVjlwYkNXMHRJRGpu?=
 =?utf-8?B?R0FhUTBhRzFSamdDaEE3TWdaMmhXWmUxNHpzMk1waXlKWFNBeEs5RFRIMEFT?=
 =?utf-8?B?N2Uwa2tLQVMzOE03NTcrc3RKcVcxSzZYR1c3ZmFGT3VjYXdXQldBZlZaais2?=
 =?utf-8?B?bm4rYWhtRzVraUxNb1FsMm92RmtqTjVBS3k5eXFWNmhKZUhneVVuNFBuMlQ3?=
 =?utf-8?Q?hrZxyxJkKR+Y+SIL+W4fmy+9j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e77b8a-9614-4f10-8f24-08dcf8227974
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:03:33.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qA/NVw9NKXmGf92FATsNJJr7hd4wGDOU8dRuVVwpDC7ad6rDP0l3hmwehoYmHtAoMQuuKYOak5LT6+ZnLSsEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

Hi,

Here is the updated PR based off the linux-pm/cpufreq branch.

The following changes since commit a9dedaa07b5e6034dbdd482c23aa3936958292ac:

   cpufreq: Switch back to struct platform_driver::remove() (2024-10-28 
12:24:39 +0100)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.13-2024-10-29
  
  
  
                                                                 for you 
to fetch changes up to ff2653ded4d99b709f62f35656d976c47a7aa476:

   cpufreq/amd-pstate: Move registration after static function call 
update (2024-10-29 08:50:39 -0500)

----------------------------------------------------------------
Update the amd-pstate driver to set the initial scaling frequency policy
lower bound to be lowest non-linear frequency. This will have a slight
power consumption impact but should lead to increased efficiency.

Also amd-pstate is enabled by default on servers starting with newer
AMD Epyc processors.

Align more codepaths between shared memory and MSR designs.

Add various code cleanups to rename functions and remove redundant calls.
  
  
  
  
----------------------------------------------------------------
Dhananjay Ugwekar (11):
       cpufreq/amd-pstate: Rename MSR and shared memory specific functions
       cpufreq/amd-pstate: Remove the redundant verify() function
       cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
       cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
       cpufreq/amd-pstate: Call amd_pstate_set_driver() in 
amd_pstate_register_driver()
       cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
       cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call
       cpufreq/amd-pstate: Rename functions that enable CPPC
       cpufreq/amd-pstate: Do not attempt to clear MSR_AMD_CPPC_ENABLE
       cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function
       cpufreq/amd-pstate: Align offline flow of shared memory and MSR 
based systems

Gautham R. Shenoy (1):
       amd-pstate: Set min_perf to nominal_perf for active mode 
performance gov

Mario Limonciello (7):
       cpufreq/amd-pstate: Fix non kerneldoc comment
       cpufreq/amd-pstate: Don't update CPPC request in 
amd_pstate_cpu_boost_update()
       cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP 
limits
       cpufreq/amd-pstate: Drop needless EPP initialization
       cpufreq/amd-pstate-ut: Add fix for min freq unit test
       cpufreq/amd-pstate: Push adjust_perf vfunc init into cpu_init
       cpufreq/amd-pstate: Move registration after static function call 
update

Swapnil Sapkal (1):
       amd-pstate: Switch to amd-pstate by default on some Server platforms

  drivers/cpufreq/amd-pstate-ut.c |   6 +++---
  drivers/cpufreq/amd-pstate.c    | 229 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------------
  2 files changed, 97 insertions(+), 138 deletions(-)

