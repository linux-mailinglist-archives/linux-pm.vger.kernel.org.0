Return-Path: <linux-pm+bounces-16225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0C9AB092
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 16:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16531F23A77
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138D1A00D2;
	Tue, 22 Oct 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2xm/MWgB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B719F471
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606472; cv=fail; b=IGx46JCqV+pqUP6gmXBMN60H38MrIQ3IsIXhjAyRX7M/nhh5QK9pOqW3D5yyHMrE9q2Jj9dfuspDwpShwYwNohQZAaxwC5knOZx+bD58IGgJkGSfn4SwK8Vfk+qMvkRmypAH5gyEz8+89DAGtLDwv2CySEudIZwrLg+FPIQqiBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606472; c=relaxed/simple;
	bh=+XtlXaeivgHDzKIpoogdM7eipA8F8oWORBGY4gAnJIg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=IFnP3pxxzzTr4EfAHF6/MgpTcJdDdB5gOBCyW8AVI1GpAj1kjTukU/63IbCXiTMcjhILpI7XBJ5AYjeieR/iQD+x2PwzKn4zqrXux7ilojYGI7N0bJme8cEcQnMMTU4hoAaaJJA6qWXmP+mUgxZHdaBuG0fngqtUOTQ3IsDCohU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2xm/MWgB; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INpPxXr5iSuAm8A9b3Aoab17JfQZbGmON3iIpXjhnG6g78IFrDTOVUJkjNX6WYDtV0OqLk/HgwxOV58bhmGFJuvX8POYzQcNDZNxhHy50xoh0jGKvGA0zhYd8t2EY+sOap+XzdW5eqsDmGALMCnWwY6+QCL1d9ucZsMf7WJrywnh8V+rrUmgpY+Sv22Et1BGmr0iqIEoPupkgKLzL3Q6+IBlTMSh8TpPPadI/kMB3sSYBy9fR6Gs1fnlI0RSFVbDp8hGQ6MjoSKvhPBGIpk01X0VzImR82FLjZ1Hv3hgHTaTNHSlTXm5RI6a1gHn6RP9vK8FNImWAg37j8Ue2oVKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RGdjfTKBedoiBZGRro2FnWtTnoru/zkinlKdtZaDPA=;
 b=iiH6vwt2b/KH9SsiQ8/QEAyaAlJOjc8GexjgVfxYEkC8ZsvMIPUmLXAcg2b+Qvujo/qvUdtZcdJ3IPYkBwBjP9o53a7W3STQ9bK/V/0KV9uqsOu465Bf1Cg+NcO8dihs2egMcc4I7aJ1BX8LcOdB5ROLEL8UHWIa2V0f68LPQgHcK3wnAzf+QM0CfJIog4c3dZ9+EJV0sY4+koKTco2Qi8D0pjlsl4vP2ElKag+MCpfStSVGKQHtPtx7cH1vJ0zjuT+yaC/cf8n7atr8rJVgKB2Hat9yhKZTd+ypKGCwS7ppSM1jQqkXj9pY5ZPcsEzwQyDXk5BOBqbrdne64A4aKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RGdjfTKBedoiBZGRro2FnWtTnoru/zkinlKdtZaDPA=;
 b=2xm/MWgBiWEEpJlEU9fNjaLUhQOX+Mo5dalx7+fPvc/g+jQomaJuEnGZSP6+rLjq/a93iuCuOkj4HspPFcwYo8B/AvCGEe5oAlB8O97ot5jaFn0cJ2FOHdoD/EzQlKXLmfZFbjNbBuvYjMogA3JaIQZ7pOWxmccgUHNjdhxth54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 14:14:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:14:28 +0000
Message-ID: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com>
Date: Tue, 22 Oct 2024 09:14:26 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Preparing next amd-pstate PR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 716238ad-7fc1-40d0-12fb-08dcf2a3d715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHFIZkFIR0FaK2pyakpXb3ZrNC9vS1IwZG1XeDJEQ0taTnBIWC8zZFBsdlRR?=
 =?utf-8?B?ejdhS09ncGg4M0E3RlhLTzhlL1ZkdUxPVEZvRU1sMVluWkUzbFpnRFpBcnJ4?=
 =?utf-8?B?ZlBkVlkwNUJQbGhHVUI3b0o4TThqVStwRWlhMHo5L25CVDZ2bGFsOW1PZVkr?=
 =?utf-8?B?d2J1Z0ZGMjZURUhtaTRsT21ZZFcwRzFwQTFFRzZNQW5GeENCLzBaZEYyeFRp?=
 =?utf-8?B?WCtmTVQ5M0xkYVVCRFpCUk5zRzhpRS9jcEgyYncweGQySnZ2aXpjZnZPdURq?=
 =?utf-8?B?Q3JKU0IwRnZKQithaFVDTDVldnA0OTZoTWlzbkh2VkRIRCtXTjhTU0RaUUdQ?=
 =?utf-8?B?Yjd4c0NIUXI4VmUycHc1MitSeDJwM243UFAvaVd1NjNKUGUxK1MwTjUyRmZD?=
 =?utf-8?B?alpTRDRDeFZ3YVlwVDZlRllmVDlLZlc5QUx1cmliNUJoUzFhNGdRTmliR0Nj?=
 =?utf-8?B?cFRtTGUzc2pPdGtMVkVjNFBiSzc3ZTJYT296c1RLSk40a2swdkN1cWFicTF1?=
 =?utf-8?B?azNiQkQxSTFUNXI0NGVYamdGSS8yeEM2eWorNWFaczBzMGZzTkJFa2c5SExj?=
 =?utf-8?B?ZzVzQjQvVlZXM1BkY2hCSHUvQklOMC9KR2ZyV1ppbFdGWklQL0dUODNXbU12?=
 =?utf-8?B?N2RvTVdOLzlqbldNVTNHUElsd0taNXp2OEJzVldBTHBSOEVNKzBjamZIZEZz?=
 =?utf-8?B?SkttMTB3Szc5TTZkMGEvd1lXUkFQb0R3UFJEK3JhYW5heWFkanppTjVvblBQ?=
 =?utf-8?B?L1lrTHNsdnhKeGRXR2swSlBZeVA0ck9LZXcvL1FOMjRpSzNzZC81UEU0K2V2?=
 =?utf-8?B?Q2dxSjVzU25QYWhpRE5uaGNRMDBDV2dtMVV5dG5IamlPaVRpY1IzMFljSzZu?=
 =?utf-8?B?MTRGL2VrNEdWWXEzcFkwTjVVVU1NMk9IaEgyMGJhWmN4TzFXU1ZCVDNlMHg2?=
 =?utf-8?B?ZE5Ia0tZM2pCeENwRjFGOG5UQ1I2d3lNSGE5NFN1dXY2U2NuczczbkcwUHJa?=
 =?utf-8?B?MGc3V1poUm5ab0NpeW9SbkFhVzMvWW9LOWN6NTBEV3ZBTDhTZWVXMDF6a2ZY?=
 =?utf-8?B?WnhPcllkcENmMXRnSE9GaFhLN0VJak0weU16bFFuUThjOER5b2xMUllCM1Jy?=
 =?utf-8?B?YUdESS9Sd1h0eHlIbHpCNnA0YVE4bmd2QStGZE9MaERSdEl5bE5sRThWUUow?=
 =?utf-8?B?TkQ3TEhIYzF6VC91WVAvbGZiNXZkaGtYaTJmUzBGaTBhV0FQVXltdGNzcmZi?=
 =?utf-8?B?TVpwdGwwMm1BU2MxWWR3VnBVdzBvalZJd2N0c1FXOTBJbUplQWx3TXdFdmw5?=
 =?utf-8?B?WVBiMGE2SG1sc0dXMG91S0xub25JNVBNZ29ZVUZ1ZXpEOERBcGVLcndjTGw2?=
 =?utf-8?B?WVZWWkRiYXdqSEtWS0RIRm1NaGdzelRLVWFYWXcreTZnR3RCZ0FJQldCbDhs?=
 =?utf-8?B?ZCsvTEVmWTdMdUJrL1ZoMzVhM012T0UyN0hrZVRzckYvZk9KaXFobGJBTWR6?=
 =?utf-8?B?WVNsQ0t1V3hSSzhReldwWHhhelZQcElqa3MwVVBPQi9ZWmhoRDRmckVsdHpS?=
 =?utf-8?B?Ukd3NzN5b0tLODFHamVaQzFuVUl0dXJXSGIzZThweTJtOHgvajA5bERGU3Nn?=
 =?utf-8?B?Z2M2NU1Zb2NpV2NWaHpQNjBKY1lTbk1Tc2VSZUZCSmdLQVRGN0xwc2d5NzJI?=
 =?utf-8?B?MEttbndtZ2k5SnNsSTAzZUxkMndtR3pRWmJHRyt2d3lQQ2g1eC9aOTc2S3NT?=
 =?utf-8?Q?A9Ql8816PvilN7kz9sk6XbykNNqTqe1BhSDhKkU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXp6VVNIL2pCNTYyWnpjUzREYU9WTVVFSVJYdkNHanppQnV3SFlGMjM1VFIy?=
 =?utf-8?B?S0ZSYmJjb1licmdlRkhTVW1Ga3VYR1Q5bXpOOXhtRlhaSjJoZXpzQ2t0TVJS?=
 =?utf-8?B?M25qSHpmMUZGUG1zZmFlKzRFY1VBSG9ITG1jbXAxOXJXMTBaaHI3YVhCVkpO?=
 =?utf-8?B?SlNkOXdMTnZCK0FBVXBDdkpmeW16VUduZERxcGYySGNRemJFZFFsb1FPWThj?=
 =?utf-8?B?RVNSS0R5Rk5UUGxLeVhNbzRCZ1pMU1B1bmFWNCtkV09Gc01GZDZYT0ZwSm9L?=
 =?utf-8?B?VzRiOC9RSURmMURadCtZZnpJYnRQUnVPVjBISUUyVndWcU4yK1NKQkQ4cmps?=
 =?utf-8?B?UDNMa1YzK3FCWlZtSHhlNEFsMVRxUStIVW5RYVNMOHVjOS9rQW5COVIrVGVW?=
 =?utf-8?B?bDgwd1BHUnNOc0JwK1ZKZWZ5a25mRGZ2WGxRaGl3VzRBMTA1RmRQZEZ1R0F1?=
 =?utf-8?B?SmFoc3NpNzEwbFBsWnlWaENPaEFHdmx6V3BubmJQcVluc0ZleWVXdTExSnFU?=
 =?utf-8?B?SkswNVpsUGZUN2crNWJUekwrTzlIRWE5ZFIvZEdxYlZDNzMrVDBOMEdFYWYw?=
 =?utf-8?B?NDI5ZHg2UnBwQTBnblJieUd2bGUzL2dySUJmYVlKZWNJWUk5Wnk3OHkxSTNT?=
 =?utf-8?B?YXFVUFdNN0NvNFBhR2orQ1VMdm5FRld1dGo1Q2w5d0poMFZkS2x0RU5MdW95?=
 =?utf-8?B?eUlsakcvbWo2Ym1CWmpFOUlwRWdGcUJqZnN5OGtCa3dsT3krTVpXMElZNjUv?=
 =?utf-8?B?VW1WWUgrN0YyNU81SDJBMDNaT09KcGxUTXM1U0dmb2hnL3daYUxqMDB5dnEv?=
 =?utf-8?B?VlQzOXFvZ1pBTUZNcnYyVmJVUGtiYkg2L3YyckZGV0lTOHRrbEVtMElRcmVP?=
 =?utf-8?B?QnRiQ252UnFMSXAwT0JZZUsvNHMzSE1OZWtGNWxjMEtab0ozeWsyRVlpWWJM?=
 =?utf-8?B?dlA5TUoweTk0RzZiWmx1YndocGplY3FJRjJ0ang4eGdNa2hZbjEzU1dvMm5P?=
 =?utf-8?B?cEpybzRXUlplR0hwSmZOS0ZaSm5FRlEzQVRlTHVFSkl2U2tsdy9QNEozZzlU?=
 =?utf-8?B?T2xyR3lvYXlTcXFTdHVaekJoMzlPdDg1L3hlSDJlTHVOalQrdXBCUEFPcmtY?=
 =?utf-8?B?MmlqUnpPTkhvcGlXYmU2M0xSaHRrYnZ4MEpKTTdqQXVBTUkwd3E1WThsUytJ?=
 =?utf-8?B?OFBRN0prc0s1b3hWQWNNd1dFbTBQWjJZeDJoSnBmUFpUeEwrRm5mZEVjRG1X?=
 =?utf-8?B?c1Z6SS94Z1g3RWVoUWxQdzduTlZ2a2VRaEVBRkU1anNqN05FZU1oaXc5dzRI?=
 =?utf-8?B?YnQ0Vml1TTlYNTJxQUdVTDJsa2plOXhLdktWY1ljNWJMUDRJdzRjOXJnOWwv?=
 =?utf-8?B?d3FsZVR1c1JvenRRVllWNEYyS1pqK2lwcUVTWUV1T0dTNGY2QXRobVRvZzcx?=
 =?utf-8?B?ZlNSR2xWakU0RjJ4Y1hYc1VjazRlL0R5MW1HVzVVaWpFeWFVTXcyOW11Q0ox?=
 =?utf-8?B?eEFFeXc5L0tYTUR4M2RaLzRtQmhHdnZyV1Vzc1lyTUdUTDJ6Rll1ZEhHcmc1?=
 =?utf-8?B?TTBCM0N1RStGeGdtWGhIdVdZTVBhZFphR0pNdGpjMEhXeXBEQ3RLdTR6Q3o5?=
 =?utf-8?B?cWIwRDduUUpZNHdJZ2hoWlJKUkF4a2FxTEQ1cHZ0LzQ3U0NZQlQxY2tyalFq?=
 =?utf-8?B?OWQxUTNlMEl3c04zcktteXgybHJJOVFoNjNBU1YxTUErVjdEb1A2cTdJR3pn?=
 =?utf-8?B?VjdXUjlteWRmWXRPakhLSzRrdzR4OE5xUHNZNDJadTlrbEN3bXh0TjRtbWlj?=
 =?utf-8?B?NWlQZUVYV3B5SFVaTGpMZHNYQmszbkVrMHNmL3V4RWZYUE1OcCs2WGxxN1Qy?=
 =?utf-8?B?dHZVZkl4NnMwTnR5ZjhVWnlZMjU4cldpRzlHejIvY3JDTXNuRUU4Q3NLbWRx?=
 =?utf-8?B?VGFxZ0M2QjdUU3BVVDd1UFlLbnZjY1dHMHhCQllxUFJ5Q0JuNThGYzFZTkR1?=
 =?utf-8?B?VVRZZ2NwSWpKN1FXOWdCMFVmNlV5aFpOS1NQSlc4Z3FrUDZ3YjQvMkVvM3JZ?=
 =?utf-8?B?aU1OQXV6ZjUyL3lnVmM2b2JTelE2b3Z6UTh5RXBVQVg5SnA2cHhDUENSWUk3?=
 =?utf-8?Q?KW+EIJWHke2ohfrWOJPJ/NylY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716238ad-7fc1-40d0-12fb-08dcf2a3d715
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:14:28.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q5QEPwO56vTerhACyy7/wctGDFM959tGZhGO8p8Yzy8bL1hDVNk/mikLc22qXXFH1fNRdl74Be7OmYaQEyxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

Rafael,

As Boris mentioned we need to drop these two commits and go through some 
more review.  There's an active series under review for it.

       CPPC: Use heterogeneous core topology for identifying boost numerator
       x86/cpufeatures: Add feature bits for AMD heterogeneous processor

In order to prepare the next amd-pstate 6.13 pull request, I wanted to 
discuss with you the best way to do it.  Those commits came into 
linux-pm/linux-next with this tag:

     * tag 'amd-pstate-v6.13-2024-10-10' of 
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux:
       cpufreq/amd-pstate: Fix non kerneldoc comment
       cpufreq/amd-pstate: Rename MSR and shared memory specific functions
       CPPC: Use heterogeneous core topology for identifying boost numerator
       x86/cpufeatures: Add feature bits for AMD heterogeneous processor
       cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory 
systems

Unless there are other conflicts I'm not aware of I was going to suggest 
that you just drop this entire PR, and then I'll take the other commits 
that were in that tag besides those two in an updated tag.  I would then 
do the next one based on content in linux-pm/linux-next instead of 6.12-rcX

Does that work for you?  If not, can you advise how we should do this?

Thanks!

