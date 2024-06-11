Return-Path: <linux-pm+bounces-8966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96539043FD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1071C21F10
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597A770FB;
	Tue, 11 Jun 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xCIcpxNK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804B74413;
	Tue, 11 Jun 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131826; cv=fail; b=fWc34ph1H1OM1zLU6+VQHA5Mw0sIdTDFSnB1cL3oSbv7STDfU5TH2MFW//8KoQTkggX0/6tR6BX1v/JUJHisJR17EGHHjt7hc1TOMrBq3s2S/Y5fj2MYzz+sR7EdAwd5M4JSd6FX0xRjzqSuGkJSZbMjsqVCOqTKssx+NfV96m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131826; c=relaxed/simple;
	bh=wmy0HqAEHaemGmSY7K93GL0yt4skXg7PMr1gb5Krsf4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPTaABsx26n8zWDbt3a8jkionur+D5iy4vfuv5ifBWJeGy1zc8ibbP/Dmzv+gShtrnsZM0HouwsUEY775V0dokyEly8T2rBrH4DQt1lX1A2DzsdTCHEU7m+rfaLutG03pxtFVI8VgVT/t5DOyIiZZFw90dg1bJDzeAaw/ajkSfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xCIcpxNK; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFGuT44rC2df17REXc2hxrhn9uLmMq91+i9KHAXOU5/oki2zg0n8vxFTyVP5+Iz67gweqR8u/CkWeJ+hRafLXJ6JyDJcID2muvWA9Kn4KSN/Uf/gaJymoJn08U/lBi3sHVflJaQs4YXbb+Sa8d1On0ia+w2s+hdk2hFpYjNJVlAY1NBUkfilvLIfwRAX4Xor96+BixHLkcOhhlpBZIYz/dyhidjN5T0hpy+dMmIiseS7KB2q8Cbaj2dtPeKEeCOxpULL3aaoT75X6ar1XAYWmgH4jxAVWdYHh4ogk4C57I0Ss8VmAgh/+baV8oUbYhDcxohEooMq9sBH6TnhwP1eOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ckoeaBkIpQUUQmTIyYxpdobzzDstzFefzYBabrKeJM=;
 b=TXrwUkzWIxxAdNAKD3ukQyCELvrOmPyg2lghC7pZTCLpH4B8rF2BqM3xx6dgSyygdCcDajAu59HnEDmi9OCiKBApnRRLfmYfthl3AEhBN1y4S+BeJ6d+HQSqmjeA6oIp81Cy90dJT+eS66AKZZi4aO1sL+Od0ALy+LjIyUDukTPIQMaSDW9YZHmyhhAhdCMW53Habj7cSPk/0qdWL37H4LOf0isEszZhAHJ/QE4vOGaIrKZ9SlPyR3WR99TPd0lpqil6qZ26jr+yaafDNzR3SEueD6LKxW42T04Gr2EmpAtx8D23RxeIudfRWFgvpwYB23Q9ZvWW/UFrixVQAgLaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ckoeaBkIpQUUQmTIyYxpdobzzDstzFefzYBabrKeJM=;
 b=xCIcpxNKZJwoW6fhhOdADBl3MQps8zAzy1uDwTN8bf2G7dzE9APa38bgfDa2+mE0DZWz3TgcofgDxV9MUJoccSafPsi/wcff5ZbFY5CXFf/1BzP7lUbg0qJZMWndRM8KMV/iCsSnYLTARPCNTRz3fC1b50NOCJLmf6BfIkN6paA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:50:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:50:22 +0000
Message-ID: <7e39d303-933a-4715-893b-5d11474ecf70@amd.com>
Date: Tue, 11 Jun 2024 13:50:21 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 02/10] cpufreq: amd-pstate: remove unused variable
 nominal_freq
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <9278090e44050a43692173461eb7a915c123618e.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <9278090e44050a43692173461eb7a915c123618e.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: c8af488a-8d6d-42b5-d320-08dc8a47596a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTNEUUwrMEE0SGxwb2VsSXB2N0hEc08wSDZXUlhlZ2ZiOW13TUhiNndxVHNB?=
 =?utf-8?B?R0wwMmxVQ3l1bU1CdE1kNE1GUzA3MlJtZTh0TUhKRUpoWkVhU0h0UUJ2QVFu?=
 =?utf-8?B?VjRKdGZSR3JGZzhuNXJWS3c5bkZNM3ZibUVLaFlaNFRnNGMrd3VlKzR0OEY1?=
 =?utf-8?B?cEhJYW9nOGFDbTFieGc2aGRLRzRTU0RhT1RxbVJxbTU1TlU1VUs2a1pudm9i?=
 =?utf-8?B?OTVaWkVhdUxZMEFvbEJDSTliVGpnZHZzMTM2bTVCY1NGN2QxdDlLcm93K1pi?=
 =?utf-8?B?cWh1elpRVE5VRDRtS1BIUXRGMk94YytCSEdyMjVWUkRlK2ZqY1JRSUpFREQz?=
 =?utf-8?B?d0hxYjFodmNxd1RsNEVEOG1zSC9SWVBQSTdBZkI4bm5pRDhHcTFoT1c1Umk5?=
 =?utf-8?B?RUNlRVhIOEZwcHFFLzllOEdXbDA5TTZwMm1EeEd4MFpOYjRyNUkxMEkrVlor?=
 =?utf-8?B?aW9tV0dKcUJ1SFZMTDQ5RTMrMFVLYytRSnR5MTRFRmh6TG1FTThqNTFJdUlF?=
 =?utf-8?B?R3YyM04vQzhHU2tYWlhkY2ZNcDMzd3M0bFBiQnlTbzRJTlFsOVVvcFZ0c212?=
 =?utf-8?B?NWVpalB5SkQ4T2ZpWE5iR0dzb1d1K1BxQVhPREkrL1UyWDkyRTFUaFVYWGZL?=
 =?utf-8?B?MWFReDJyc09VSmtGM3ZUZTFVZnAxWG5SQzhoT0xQVHpsT0xUUlp2c05MRDNz?=
 =?utf-8?B?S1lBYVE2NXVDaWtkMkhxbkZNdUtXZGFOalYzc2hRNEVTM0lJdFpVTEJzRGht?=
 =?utf-8?B?aFMvQmNGV0JXanNLSUNXYkFta1B0bnNWeUt2bCt4akRIYklGOXczMUlvM1Rx?=
 =?utf-8?B?U0VOQXI4SnNNVWM3eU9VNlJ3dHJnMGNPUUFRNUZkcERrVlRRaEdvUTcrVjNQ?=
 =?utf-8?B?bDhJbEV1T0FMc1JTb052ZTN4OTNvU0JJU2ZSNjFKMkhqb3R0NFlGYjVNU0dB?=
 =?utf-8?B?V21qeVp4Q3dFWDlHYVY5d3o1SnBxV0llbFd4NkZUU1laeERJRHVOeUJpa0dF?=
 =?utf-8?B?eVA1WGc5VUIzUnA1eUdMbTlBTkNxazhCNnVDT09UbFlpYVltbmVDcnRWZE91?=
 =?utf-8?B?eWErZFF6V2k3c0xXMkRyMTcrS0Rkek9qZXRaSTF4Rll0RGRiWllHY3JEdDZr?=
 =?utf-8?B?VGp6YjFxekptcGNwVVJBcGJzeVltakhJZzhTL1hBb2F3enFzT1hHbkl3dTVI?=
 =?utf-8?B?eW52aHl6dUxyNkNpak5pMWVzRkJzdXRyYit3L25UdXA3eFdKOFlxb3lJVFBs?=
 =?utf-8?B?NjdiNXRxMUcyN0ZGQVBabVNaMUhxU08zczRqTjQ4enV4UWZaTDlLdTBRaFh3?=
 =?utf-8?B?SDFrZitYVDFYdllXVmhjVVpYQlIweWhGU0l2Ly9ldkRIM2ZKQytaWE1wQ0c0?=
 =?utf-8?B?TGFDek82cmNRZHFCc2NvcTYxK3p2WW16RkZpU3l3RkdIbnFuTWZjY2puaHZi?=
 =?utf-8?B?bFh0RW93VU1ia0FnOGx2WWhkMTI5OVQrVmRYOFgwelE2L3dJeHhORHFJTld3?=
 =?utf-8?B?N3R6UkMyai9TbDcxVXpJY05kUEN2ZGlXYzBVRzhITlRsTytnYys4dTArMk0z?=
 =?utf-8?B?TTBIU2Q1NFEwOFVoaks4a1ZMbmdVRExWNVdWb2xOV1dvRVhyU1pEQjBrcm5t?=
 =?utf-8?B?dUtOMW1Ga21OYVhUSUduU0NRVWgyQWJyNU1HU0xoV0h3cEtDZHVPSTFSalp5?=
 =?utf-8?B?Z2xGcDI5Rnp2YlFzVGpnSXJ1MmZaZGhaQk0vVXExTEpHVW11OWFzTW5uTWYz?=
 =?utf-8?Q?tdUgUcpNNxleLQlawCVKmC6r/SyZ4siZ3seOeCy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTVsL2pmdmNuSHE1RjV4eFFic3FwZ1hQblJLWGZIaHhEMG1uRDZUNlEwSlJL?=
 =?utf-8?B?WkhVNi9ldi85OUNIcUVZTDd1MFlwbW93eDRleTRTbktibEZqbU5DL1RtVCtz?=
 =?utf-8?B?UjdKbXJROVJtQTNwSWs2Vy9TL3FYYm5FNnJCZlVuSkRmdlA4Q2VZd3ZySVRX?=
 =?utf-8?B?MkF2SUpyb0NMM1Y3V3hJbitPUTVyMEFlZ1lyWDBJdnpsc1B4Q003UnJuN3dq?=
 =?utf-8?B?cXR2WXhNNTJURWJ4TDgrSGZ3UEdDdWV6MnhTaEN2L29YVnRGNVBydWRQV09Y?=
 =?utf-8?B?VVhuVWpwb1dwSFd6N3VkbTRoS08zSGJDa1YyclJ0bzBNRFZVK3dUMmhoOWsy?=
 =?utf-8?B?NXBGUDVxU2dhR0lralVsUEtta0ptNlBsbGVUZXAvaTdDQXZlRzR6UmpiUDNI?=
 =?utf-8?B?YUpHSStlM0p1VkpQemJpbGNUWHh2cjkrbmtjeGU2L0t6ZUdkNlBiVTRuUStM?=
 =?utf-8?B?RC9PbGNwQUhRT01PVGtyTDZIaGZnUXBIZ0tQQjNOSE5ObEVuSVAxQjZhMDRF?=
 =?utf-8?B?VCtad2E1T2xlRlZUYXR1U2NvOGJvL1RNa1hGdmRtajlBVnpGdm5NUVBtRFhE?=
 =?utf-8?B?d2NNRko2MlVSQWNoSDlFS2U4ZVc5QUQrNjl0SGxCR0t0d1RtTVQ3ZzVpcVBD?=
 =?utf-8?B?RzFPYzhRUVZydzZ3UnNhKzJwZG03blVUc2J3QWI5RDJyWk1ydUZWb2pBb2pS?=
 =?utf-8?B?eGc5RmZndy8yc1hLNWw5U2IzQmxVNU94aDNuSUJKMkxZYTF3SGIxQzlyYUhK?=
 =?utf-8?B?TXZRUDZ0dkpKb0hvdTc4OGpJQllIY082S1NSSHJiUTdHNG1sSUMvWU15VDZo?=
 =?utf-8?B?clhldDR0dHJwRWpqVGxzVVZlbnNka1Ric0hjMXkxdnAzNnloK2xqb0FGazJX?=
 =?utf-8?B?VjV6d25lc2ZxOC9JcnpsTElybDZVRTZWYm12ZzFJVUFTbWZsVURVdlN1UVFh?=
 =?utf-8?B?bjIzdGtXZzNQMXFYYmJBV0RzczBSbnczb2sxYnNRb1lNN0dTYk5NRmtWUnFK?=
 =?utf-8?B?aHc5SUdQSXBUQUV4SWtiZXF3K2J1ZUhHL1FxTVpvN3hqRVExYlRIcDE4U0dX?=
 =?utf-8?B?Sitoc1lZTVZES2JveTBnVURlbTBpYkVJRzdKT0JKRXFMUGxvaXo1R2JkUGNW?=
 =?utf-8?B?alV1RFJoM2FKdEZFMjJGZ3JmN0J4M0tTNUpYUVhZYmhTM0puV3QzTCt2T3kr?=
 =?utf-8?B?UHpWODY4ZUw4MHhzbHRxbnpubC9PSnkxU2k3dE11MkpIL2lOQUVrWlpjcXVV?=
 =?utf-8?B?QjFlaUhWMWVwM0ZNNVBZTlNpbnVMYi9ZTEs2ZUErUTdrcTZoOXN4T0ZEVzBq?=
 =?utf-8?B?RStOMUxBOW1VWktxdUVKM2I2azNFM1M3dEE0YktNQTlGeklOMjJpYS9FTjBy?=
 =?utf-8?B?WjRpc0dQVk9tOHZJK05ibHI3aEtlVVAxS094THBISkdPSS9hNzBjRi9Ib1Qx?=
 =?utf-8?B?NHhKcTFWL3lmRjBCUWdZWVZYL0NZUkY4N2pjcVFZMTAzZmtqM29BeXRjeFJ5?=
 =?utf-8?B?S1M0aUgxOXhFR0djUnA1WERIWTZodUxHdklPYWpvYyt0SVNLMWpPRUMwazBB?=
 =?utf-8?B?bDIyWGFkSVIzTlREY1VXREFCdytMSUhXUjRwNkIzNkZPNmovZHAydWoycWx4?=
 =?utf-8?B?b20vK1ZrRWtIbzFBb1A1SWZTd0w0TTl0K29KZlJ5OTMwWnlGdlZld0NTTkZp?=
 =?utf-8?B?blR6U2tjS0Voa0ZFVVozQ1orWDBZMk1zVkltZXJjQk85eXR3Q2V3YnRQY3p4?=
 =?utf-8?B?UkU1bXREUzlaOG16Tm1iN1NMVzE5Y0gvT0tkM1hhS1RZeXBCbzF0b29RRHdU?=
 =?utf-8?B?VGEzUTZFR2JleFd4ckdIaEd0azc4cEcxZE0venIwWnQyRDlyRW9MektTTzh2?=
 =?utf-8?B?ZHhkL25aYVNlVnlJdlZOYUFKMWkrVkdiOXczNkhYVjU1aDR3THNqbVBtbmlx?=
 =?utf-8?B?SnlQTlBTS2YyZlpzV2NwWSs5blJLcWZqc0VrQ3Y1a2dwREl0Mm1LS3hjM2Y5?=
 =?utf-8?B?QXNzeG84Y041VWtEdzF6UlgvY1BpSmtzbzZKa25VczZ2cU1YMW8wTnQ0eUhj?=
 =?utf-8?B?OGl3NklPT2xhZFJXK0F0cUphYnpwMzJCYlN5VmR3dG5qYWt3L3JGWWJMdUdL?=
 =?utf-8?Q?Du4QPTo/fvT0L8VR4EoOSG+Qo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8af488a-8d6d-42b5-d320-08dc8a47596a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:50:22.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iR/1Gs5a1T8M8yTm0imywWhIfkvG86DpxniZyX715h9Cl822EwqmvFelYEZTwhxGiy2GGQeWLYfX1SSQZO37Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

On 6/11/2024 03:52, Perry Yuan wrote:
> removed the unused variable `nominal_freq` for build warning.
> This variable was defined and assigned a value in the previous code,
> but it was not used in the subsequent code.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 37fce0569d06..36b1964ca8d3 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -944,7 +944,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   {
> -	int min_freq, max_freq, nominal_freq, ret;
> +	int min_freq, max_freq, ret;
>   	struct device *dev;
>   	struct amd_cpudata *cpudata;
>   
> @@ -975,7 +975,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	min_freq = READ_ONCE(cpudata->min_freq);
>   	max_freq = READ_ONCE(cpudata->max_freq);
> -	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   
>   	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>   	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
> @@ -1395,7 +1394,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>   
>   static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   {
> -	int min_freq, max_freq, nominal_freq, ret;
> +	int min_freq, max_freq, ret;
>   	struct amd_cpudata *cpudata;
>   	struct device *dev;
>   	u64 value;
> @@ -1428,7 +1427,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   	min_freq = READ_ONCE(cpudata->min_freq);
>   	max_freq = READ_ONCE(cpudata->max_freq);
> -	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   
>   	policy->cpuinfo.min_freq = min_freq;
>   	policy->cpuinfo.max_freq = max_freq;


