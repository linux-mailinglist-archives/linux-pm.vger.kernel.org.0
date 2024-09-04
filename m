Return-Path: <linux-pm+bounces-13634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0996C82E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 22:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2961F22F7F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA461E6DEB;
	Wed,  4 Sep 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ekfU8Yx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592040C03
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480689; cv=fail; b=ToIDPZAkCx32R4S70hk+aTGyCy6TET4zXqBaaBdMMX2bnjNRFpDAMGbLS6sW0Ea0kF3c3VntnVJ5+9EA2YhIutvmaBKktF6EvSdt78GM0fG9UdArDJPX+KrvqssTuZOv+1BkZlm3rIME1hWpYD9P3Jwd3W1qG0DxD4n1nPV1Tv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480689; c=relaxed/simple;
	bh=zlcIKqsOFWYgZbTSIbvrLCaQC05BRMWwckrSwmHHfKg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=XIONq/stamc5VOqyRQNGOQKQ59J4fV+/2K7lfS3YR9OWUa+pg/aygX4zNTVzAQ5K8Cfw802THD1BcRtWCottdDInDdHEb0x9Pqj4KZNAReLB01KEaTZRvE9/tUdjEzrtKFyujgmzJdH0Hky5voeepnOQXn7uYC6LApghgXff7q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ekfU8Yx; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWQdYZp97O7hn5B0fbvkcbRMTVXQ+X4YbMZTvY2A1SZYtteMxySUXiVmAyUJ5inLe1c+OqyQoWxm2fYZip0B4gCvEL5IrdfJPF/D58C9/rF3+dLZzQPBzWTk2q1mDMfGfd9qPYVWL9bBQ3AU076jp5QE7vMRqk83GXGHLbCZ+piSoCNPBsis4pnnBjZ4quoYYkQ30J8bRohtRMMPb6t0c5k8fEAWsxyitgr2HC2qcz8TPis5PED+cfJs9HNjr/P8l/EsivpSgnc/BYpGwqIMqHwtUCmEdccG5odyA+nh7EM4ODV8/DZhX7gj+VQAv5zc+MoI9i4UwQMvZMcx5s4h+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c03jFKEXxsPNA1gevuNta1ew0/+0y8H1Ihp1RBY3vOg=;
 b=Rkt0dMNbXQV16GcBa15pPdP8m9wh5UswTWjBtkGbk0qdcr/s7/qLQh+yElwryG7FS5/+qPrdGjwBLKe9UO7gzq403HXQj8aq8d9j3VDoIyEP6xVGbj6l7cMaQJ+OkObfukKTC2i56peOtYZhcHcqjilH9sOS8zjsFpNiKa6qL3z+5CxYFP/PraQc0eTb9aHrZVF/nxMMP6w6MlOo55BnwU5kh44LyuV0QQdAmq4UF4avO4bGFUjZkrYyRskQEGiNX12WpbW6L06/apDNfAHV0ri5gQbqIMl1DbedDH/IaHi6Y9t6DHtt6sasm4qlTrASLJChqV8Gw1QyZgXQwlrS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c03jFKEXxsPNA1gevuNta1ew0/+0y8H1Ihp1RBY3vOg=;
 b=1ekfU8YxGF+PO817xlO9wpmRKbi53s513HqqQdXcMpfqEP7NVo3prjj5f56AWXe/DSB8CLvxmtcyUMCCQ5aVd3ApvP8OXktcRdKTG8DwZm3c8jMTR09ou8ytnvOAbFiABc0ZpsY5hVLSn2/sypTTlQYmBhDCy9oK0sn9PkKo8jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Wed, 4 Sep 2024 20:11:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 20:11:24 +0000
Message-ID: <0297acf4-aab6-4561-9d8f-5c9082fe4869@amd.com>
Date: Wed, 4 Sep 2024 15:11:22 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: amd-pstate development for 6.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e1e983-49b3-4a10-5f85-08dccd1dc04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWFnNCtIdkhoLzAreTdYZ2J3Qm42LzBmcFFqT1BMZkVKMGFzUWpkbUhHemtS?=
 =?utf-8?B?dHVQMHU3Z2ZnRGdZSEtjcUtCVitTZWtMTnBVWmxrZTJlbGs3T0JPZFZ4LzR2?=
 =?utf-8?B?bDZtZlo0OUVXRUE1OHdzb3dnQ1IrUmtWT3UwSFdsN2xjVzNZWHhYWTRFdjFO?=
 =?utf-8?B?cmM4REFncG56bW9HMy9VV0o2QzZMQ0ZvTUVkWnAvTEFXazdTejBNMzN0aFRl?=
 =?utf-8?B?L1VnNGpCMzdVZklXcDBJZ1BmTkU5K2ZtVFgwWkttRUNCWVdpVE5LZFVwZ0Ry?=
 =?utf-8?B?R25xTHNoZFozMTg2bm1IaVVzNE5WbDlZUDlSc2dVYjUrdStFenhaUmVZVlJG?=
 =?utf-8?B?b0dsd0tzSDdnVDdqV0ZMbVBYazAvcjdDZWR1NWZ4VDNBZlZzVTBjSXJJcDBT?=
 =?utf-8?B?STRTekVXM1A0SzQrUlRMZzgrVVVtRHpxVFFLZENHb29KQklnaTZzYTl3Mlk3?=
 =?utf-8?B?UGtITFM4eDN1cTNnZlM0RWcxM3JxTnRvMzdsdW9STFZCU2Y5UHFoeDNPcGhl?=
 =?utf-8?B?SWx4UEhyeUlIeWh0VG9lNTdCeE91SncvZTh1Y2RkL2kwQUpES2NGcFlvbkJZ?=
 =?utf-8?B?ek1RY3U4M2V0TGtqZUtkRlYxcGFTQ0RPTkY2SFpGSmpOTm1yVTAySFFpMThj?=
 =?utf-8?B?eHlvbHdpUVIzTUhaOEcwWEovTnNEaU5IcEo2bjVwd1JtZ3B2Nm5mdEROV1du?=
 =?utf-8?B?YTg0VEtEME5MOGVOcFkxa3FuZUtEMFFYYVJsZ1d3M2h0UkVtUzRUdHhEWjI3?=
 =?utf-8?B?QkxkRitMREVHVnlyKzNFMzl4UzVZMXNReW45K1VLdnhKUmxSYmpuYTNpWW9R?=
 =?utf-8?B?NTBJODg0MUNkenYwZ1UwN0dvaUthd2FOWU9UMHNxVEU4UFhUeG9zTy9rOHJu?=
 =?utf-8?B?K25aRFZVZHd6dTRPaUQvcndoaVZmSzdKaU5WaTQ4czVRZXQzNE01MFNpRW41?=
 =?utf-8?B?RG9zcXNISW1MMUVobUtKTncwUytGYzQrMC9VUW5rc0o5QWF4VDJNdWkvak9n?=
 =?utf-8?B?bTJqaTVrMXdvYkEwM3VLU2VxemFnVXFHY0JKdXNVbzhyQ0FLcERVS0hzVnhH?=
 =?utf-8?B?WTlWMCtEclkxYUxFaDZ2dzNLWVdVL3VDSjROWVRGcElLVHU4MGpSc2JuVW8z?=
 =?utf-8?B?RlU1THhlVXFwWjRoQUNYNjRjajdDK2RDOEZWZlZyaytpSlZaZ0lGeU53ZVJD?=
 =?utf-8?B?dW45VEZiR1U2NytRcEgwNkZjYzk5MWNrSTJKdVFVRk5GUkRFWmhFc3RhdS9E?=
 =?utf-8?B?ODY2S1ZtelluSmNJeGs1cFpUYVdIcnNlVFF5bjFpYTdCQXlMQWllT0Vnb3Bp?=
 =?utf-8?B?RWhKM285TGlxbitBS1NsNlhDZndPVWF3eFpDRHpmQXlKMEhaUlArcmx6ODZZ?=
 =?utf-8?B?ME9uMUdkbFRLdzIyMjhZeG9jaWpweG45OWd5QUhzU1hFWjBZL1ZxU255TUw0?=
 =?utf-8?B?UGhrSklOOGNyRjJDN3MwTVNleWxnTjl4cnRpOHlKUDQ4Nm5IZHFBbnJkYml3?=
 =?utf-8?B?cHdCZ01TL1loR0p5aThOUTExTHIySTh0cS83dVExYXFKK2FrSlRiRWlpNXVY?=
 =?utf-8?B?MklxUVBvbVFWa1laa1BaenRxNEs2aGI2OWtoQjA2UHUzQmJjOHVyZUI4MVFW?=
 =?utf-8?B?cTF2OWtEWEZNYU0rWVVyQ2JOcDNlbHN5amFuK1ZoMG01aTVwUzZ1NGduSWEr?=
 =?utf-8?B?WHpQY01jNjF3ZVViUHJZNGVwZWN4K2hVSlk1UmxzOE5HR0l3L1ZqSVNGZXI3?=
 =?utf-8?B?anhKRThJa3crcWhKWkRhdVRQa29ZWVdBbHRuNXVieVR1S000eWFCVGM5aXd2?=
 =?utf-8?B?OTM5U0FKSE5rcWlIK1BQZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVE2cDZsZTk5VlVwUXo1Sjl3NG1zSGIxNWp4Ryt5SGJpV3BXeERwMTRCZGow?=
 =?utf-8?B?M1hFT3FVeFhHanJ4blR1UEJTNmNISGVvZDFZeTZkbTRlNkNqMWs3c2RFeUgr?=
 =?utf-8?B?ZHRLb2l6eUdqUWYrWklPaTQ0M0tsQnVpZklZKzRKTnhaTlFqZWtHb1MxVGZU?=
 =?utf-8?B?OFRUYnErcnhhN2ZHSzhGR0RZR2psNk94ekEvTGcxc0pSTis0cG5MV0txLzNm?=
 =?utf-8?B?aGx5aTNqUDNXcG1rRjlhUGd1MHZKUWdtSmNieGdtV0RPcXplUXV5OGdlZ3VQ?=
 =?utf-8?B?RlE5R1p1QzNPa1M5NE54dDM1QnhSaGxUeWUwekk0dkJxOFZ6QVROTVJoR2ZK?=
 =?utf-8?B?bDJZZlNRYkZockhhMmF3dTJvU09QWW9YNE9qSk9EUjZha3hCK1BUaG52YjZI?=
 =?utf-8?B?Z2lUYVJ3R3FET0pxa3cvWldUWnBSYkU0OGgyTWk0U0JkNkdEVlArRjQrZTZW?=
 =?utf-8?B?Q2FBcGhyRWpodHhpZ0RFbUloZlhWMldQUjY0eHpwT0ZlN2pKZkxpeWp0MURX?=
 =?utf-8?B?WmlQRloyNWVidi84WkFBZzFsaXJKU0JUeHkwa0E5bnJGVzUwWnpHcktZcmkz?=
 =?utf-8?B?ajFXMUlPWVF1S0wrbGJlc0lRZE8wWnZCMHUrNE1uMzRaVmFWSWwzKzR4VGRo?=
 =?utf-8?B?ZXc5dkNQRUM2eUttdGNtb1dFQjBSbVByUURtK1JzUGdOYU9KQ0hOWlVwWXhO?=
 =?utf-8?B?OWJoL1dVUW5Ecmg5TC9BQUk0eFRLNWlCTHdPRDZFMXFUMG9MSHV0di9nd1Np?=
 =?utf-8?B?d0ZnQ3JLU0QrdERadjBJaytlT0xLNDhYYVJyWFJyK0g5anF3YWtqRXVKMEtP?=
 =?utf-8?B?NG1xR052bmsrUmZzSXBvSFBTUjVwancyS2hEVkQ5YWJuTHV6QmhzNXc4dVcr?=
 =?utf-8?B?REFKWStiZDZJT2JacnRoMkhOeWFEVys1bXRmc0dLYmFsOVR0b1F3MWluQ0d3?=
 =?utf-8?B?SS9SYTVwbnlXbjJ4dHBNQ1ZrdVAyREUwZ2lCU0k2L2FtQWxqdEJlbjFMY0NM?=
 =?utf-8?B?SC80Q2szaDdIQWN3UFNJbXRoUDBISzJUU1dIVnUvYUJONDJFY3A0dkhVYzht?=
 =?utf-8?B?ZEJFQXFSUGVScWZKNVQrRkRaaEtGWDVLUGs1djBqbnhSaG4xZDJ2Zll3VTdM?=
 =?utf-8?B?bitRRFpiOFdrTFFWN0cvTnFKaUFXMjhxMnl5UlRqcGJwU25wcDFOaEdZdkxj?=
 =?utf-8?B?M29NeE5YREhxU0cwVFVEUjNZTlhqc081N00wUXliSnlOMkVuZXB2bDJqSmVq?=
 =?utf-8?B?QlkvRGZnUTVhN3JlZDFmRjFQcnNJMHBBVmVNTEEzSU5QSnh5OUtla3NWcU1Y?=
 =?utf-8?B?enNjVExtWHFBTWo4NGFPNFpZdDc2eEp1WnpDMzZmL3h5YlJYS1NnZDhmd3px?=
 =?utf-8?B?TjJVdk9hTHhHRGk4bkFqTk0vTFNjTkNiMHBlRi91QTZrVUFDb3FmS2xVajZC?=
 =?utf-8?B?aGlkMTZ1V3VDTlNlVXc4U2JZM2E0TWhBTkRuT2JHM0FLeWwra0g2M01FdmhJ?=
 =?utf-8?B?alNPaG5GbVE5cVZmOEw3VFBNaG5pWXVEUUZ5QWo2L3k1WDJzUXNCdTdTNVhH?=
 =?utf-8?B?Mi9oem4xbDdHdTUzSVJ3cStNMFplVmIzTE1ycWo5VnF2cW1JenFOcXBSTUUv?=
 =?utf-8?B?N0N5WFVLdnVqT1FzemViWVcrZ0NhOFN6RTZHQnJDcC9HbldDU3hqOVhXcFB2?=
 =?utf-8?B?WlpiR2pXMTBPREt4T2JPN3BCRU9Zek1UZWxka1Y0cXpINjNwWGlrTXQ4cXFq?=
 =?utf-8?B?dVVyUVkwbVB3UnZkbnlHYzdyT2Z1UnRJS1dhbFdHc21uSmxaTHROT212b3R0?=
 =?utf-8?B?SGNXbU5UUnhIKzNBakQyZytwMkVRMTBLOEpxZHVob1pQbkhmU2YzcldNQ2U3?=
 =?utf-8?B?TWhNVzh3a2ZLKzRwditEektoZk5QdTA0c0ZGK1VLM1ZlNHM3UUVZZW0xb0dW?=
 =?utf-8?B?RWJ1a2dWVmVYaTB3Y1RLZEJrSVRjbzQyU1ZQZXlETnppTGhrZFJYWWVrUkZk?=
 =?utf-8?B?UkdodTZYMm40ZVJPeVhIV1VNMmF2ejVQbXJlLy93MSt4aVcvZzc3blh5TVZN?=
 =?utf-8?B?TEYrZEFVRi9zTTEyRk1sUmE4T3NpVVJrdDROZmhsS0k5Y1ZmeC8yTVNtaHhh?=
 =?utf-8?Q?DNgs+wBE+dLNcpxKWJVPVmKUe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e1e983-49b3-4a10-5f85-08dccd1dc04b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 20:11:24.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64R0JmC7GnD2q/C06pN50nWwHBVYhBH2akeEdnQ/M206HFf0yi98L701j4Kv97z7JKpJ9wqvhSc9Fl/OsOVHPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.12-2024-09-04

for you to fetch changes up to c3e093efbc6cac7bf9dc531dcb751b86daaa65b0:

   cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit() 
(2024-09-04 15:07:34 -0500)

----------------------------------------------------------------
amd-pstate development for 6.12:
* Validate return of any attempt to update EPP limits, which fixes
   the masking of hardware problems.

----------------------------------------------------------------
Mario Limonciello (1):
       cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit()

  drivers/cpufreq/amd-pstate.c | 11 +++++++----
  1 file changed, 7 insertions(+), 4 deletions(-)

