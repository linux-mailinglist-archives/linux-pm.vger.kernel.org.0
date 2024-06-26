Return-Path: <linux-pm+bounces-9989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB99176D8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B1C1F23671
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED267A0D;
	Wed, 26 Jun 2024 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1h/8Xsvp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA1535BF
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372801; cv=fail; b=Gl41KWO42d+ayjSZuBZJrtlBK3troskNeWCP3GCSXSztOMzZdmY3ybdSkUOOSuVpIKAIRO1NkZy0fSq741feM0P9myccX3aIddcmDdS4AWdl5qXkN0lm3nzrKxOXtKLo4MPulF4T3WhiTqM7ZsHbDr+Yu+y86H3dHY0gLxcIA8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372801; c=relaxed/simple;
	bh=eBsi2XGYohl0JYXereyZebYIDZjBjW8ItClFSC68aa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OR06cki+UZg8csOt1LEqYszgOkEqrVWObu4R512+YBXigZtag2Anc20hHl/QD1AJ2Sl5ShohIMwO056HNBG2GBEytOfrdRWEfSnzftXvN+sfxQ2v/ScqiZ31uTqzNNJlDyE264TAEM1qTUt27xoP0TYmRTCVWMx/u2dt/cpTpmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1h/8Xsvp; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZMyN578GxSAuMp51r8jm1L/WEPmZNB+J6sqCn6LWZyt3w/WM6TQrUJmSj4/EAOTPbdvEWe4QgssSOX/jRE3+xmjG3eoW2XGLBbrsQgExplrOlIUzN82jSI+HEq1uaRJuTKM8friKDZSrZ4Gdb4LV7CTJAjrg2ay8PSVF1DyBtZ0p+MjgGOLOz+xgBmz9ZVm9+4Xpj5BZZ4Tp7MyM77DrppYtQV3/ivN7xxRsyQedLD7MN3+rTg9UDFejKkc6v5s9clEG2wiiSqvq0rudv61nTzkQQtAI7Uk9K2UAQJtgcpNmnlbh2sQRNXK+m1QxcM8+0SBNv8p6mIGGbCGw7HhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfLcpBTxQxJklzIrHRcwv4spLzXjLqUHdfSZNqKpfjc=;
 b=hcTHCg+cN/514U/RR5Ulg+XGTgZnCkBSRMofUP9mfNaB2zGY5ZxDnOQiAKZ/SbCKRzk/4MOzUr8Z6na/FtR8wW/nWYoYqNYyBM+Qnf2LlC8UAYO2scu4Bd/didjMPjBYqethPKX+ic0at3ty4ZiELJAjb662FN2WAh5H+PsLOtwLfwAMJYkQm8kYuSFgc7j56wXm0vd4ZmSPuA1TB1kqwpty0H0SGn+in0hOtPnPU4Hc9B6p9G+EdhykDg7/kFbnJ5Yrmb57MKxnI6QxgbJ+v0l86V8GF8h6sf5Wl+3ApldBKKUsDsMQMsWsuIbcGiE9WuDW3kZvHlZxvHmcqLKWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfLcpBTxQxJklzIrHRcwv4spLzXjLqUHdfSZNqKpfjc=;
 b=1h/8XsvpFxRWzw3HC4AHuitZZfKHRSKoNjZTfOeZe5oHTx/N+sPm/RHwXp6wlnWY0k1Cw7jMKcwfUn5tN1XQg3iYWI5uvJxT4inYC+4gl7u2JrT/ETJjw8/VyOGe95ZtxELuaI4yLFUTmZm7HooIWBrgQO1MfEU8k2EFSZnQNaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 03:33:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:33:16 +0000
Message-ID: <31730330-c0d0-41a0-88e9-6ce2909b6c41@amd.com>
Date: Tue, 25 Jun 2024 22:33:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
 Linux PM <linux-pm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
 <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
 <e8275758-e0f7-46c9-8131-094abe363292@amd.com>
 <20240626032557.5vsjmzyzmtkbzom6@vireshk-i7>
 <20240626032702.fai3hlybfe6czmjd@vireshk-i7>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626032702.fai3hlybfe6czmjd@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e67e3f-81a4-402b-c8b4-08dc9590b753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vkk5eDN5RGY3WmtWbmdlcHNmQm5KQTBFR1BXcmJCMDNGZEdWVkFtcE1zUHpE?=
 =?utf-8?B?M1VvNmsrNHYvZEpUQVpRaU52SkF2OEpXR3cvQnMwb1ZLWE5tU1dhS0pnU2tD?=
 =?utf-8?B?b0lpMXpySm5WOGhKRWgxTXhLRGwxeTc3OTVON0xVcFVLSHI2aVE1Wk5LRm9I?=
 =?utf-8?B?N2RWdDU1OThBeHIzRm83M00yOHpTSGNkOGNRenJ4amJtTVpEK2owRmNXRWJG?=
 =?utf-8?B?VFdBSm10a0Yzd2FNSmh1VWU0UWozalpuRTZ6VlFLK0VIZXZ2MVYwbDcyTFh1?=
 =?utf-8?B?UGw0RDM4eVc2ZlhEUTd0cUdud3gvOW9WNndQbVRrU3ZzUTFmcFdGQ09jVFFW?=
 =?utf-8?B?OWpCVzU4TWkwODdQQUFZV2VMZTlJa3I2SzlsS3N3MkFmcGoybGdwaTJvL3Bp?=
 =?utf-8?B?YytqMEJSMXRJQ1d5ayt4eElKa1lWQk55RTRoZWNZWUFtS2dweXFaVWpJNGY4?=
 =?utf-8?B?RUtaZnUwSU1LbG0xa0NvdFNiZ3g0U2RheE05UGI2bVZodzVPSmthRThpKzgz?=
 =?utf-8?B?UGhWREJLZU9BVGN1ODBCdlhJVzZzVUMzS0tHY1lBS2lkRm1NVnd1bFFRMmxB?=
 =?utf-8?B?ZEZVek1xTUNZSG9QeXZiMDRZTEdaTTdPNU83b3pVWTdLT21DWlJBMVZESmdu?=
 =?utf-8?B?eWF3SG5MSHhTQVNrdWtzbzc4VE5HaXI5OXQ3ZHdIeDh2bWNpdEdqRWdyN04y?=
 =?utf-8?B?ODN4NnFxM1RnZERrMWQxUVhtMHRsUXpEQUZSUVV4a0I3cGh6ZXFycnRkNTV0?=
 =?utf-8?B?MXJid0greUZvT25QYkhsdkxxZjJuc2wvektPZXBUa0xOZ1RzaVNoOWxOM1Fm?=
 =?utf-8?B?S2dmTE94Q3ZjNGdWTUdabm9nT0FaekxkZUhTSXJ1QW9ldlU3Q05CT1ZxZnhW?=
 =?utf-8?B?cmN4MXJ0b2tSdGhnREZDaldSL2t1bktkN1ptMzZqN0N0UUM4SVBubTlseTlB?=
 =?utf-8?B?dnA3aHhwSW82ZzFnM0d0Q21jSllmZW9QajJMSEtBUHFCTTQyRHA4M0dra1Vl?=
 =?utf-8?B?Z1dQa3doazYwaHBVd1MwTE05SFp0YU4vSmI1SXlQRnAweXl0TDYwNTh3QjIv?=
 =?utf-8?B?R00ybGZEZVFQb3h5NHk2SkNOV056R3djQm92YWN0NXlienFPTGpjQ0YvZE4r?=
 =?utf-8?B?S1dham11VGJDOHlWYmVLZisxaEplQ3BtS24wYjY5S1BsRzU1UktVZGNZZ3VO?=
 =?utf-8?B?K0NFZW5JWFF1Um1jMk5ReFV1Z0JUUWd4c1lpaHN3YTFjOVRGVFJuUS9MM1pV?=
 =?utf-8?B?N0k4NGgrZ0ZFUENWKzIxT2ljNFlOdndaL3VjMnJtNlNnUE8wUE5OVUhPTHlD?=
 =?utf-8?B?ZmhCZEtxZ0hDdTA3T25vTCt1YXo5RkNXTmNMa05MRkNPaEdJL0o5bFFEclA2?=
 =?utf-8?B?a2pyNWlBSXNITStmeWk4bENZMkFTYlVnY2VpWCtyZ043cFZYU0hOVjRKQXh3?=
 =?utf-8?B?MlBPL2Z3UUVKelFXcDVqZzUzLytHRE5MZnFhcFpnWWhTUmUwTXF4c0FmNnpV?=
 =?utf-8?B?NnI0MXBuRHI0eVk1OGtkYkF6eDFYV1VPbExOOXljaVUvTzg3enVmVStUTHZk?=
 =?utf-8?B?TUtjc25WY2hkcDlRd3lsUjFFOWxGaG5iRitGZS9TOUtxd0Z3dzhyL1lHdW5D?=
 =?utf-8?B?V1RUY0wzWERxQWxlWEFuVTFDK3NucFpEUzhVeWNzYjNTN0orRm1WVWpjZjlv?=
 =?utf-8?B?ckl4clA3K1BORjVQU01kU3BkY29MVXJjRGxwZzVabzA5aDV6OWxUSkNpU0lw?=
 =?utf-8?B?MUpLbERIRlpVVTU5L3dTTkdQbi9iOFpTYXEwQnkyVThxSjJRV3FBUUN6UU5Z?=
 =?utf-8?B?NFptOWdVUlRNTFhtRHRiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFNtUjQrN0RaRUVwSml6SC9QTy9NdGU4NWdYZXc4NmxsTGdCeENtVVVzTjF1?=
 =?utf-8?B?MExlK3JkSWg4cHUzRUFteFVoOEFNRlRPR2krczZWQWNCQURteDRJeTB0Zm92?=
 =?utf-8?B?MDhCdlM2clBDeDZkb250akpZcWptUzl4VzMyeTdaRjkxNmNtalJ1UGhQVzZs?=
 =?utf-8?B?ZDJpTlBNcTYza2N1R3VzMkxOVncrS2dpdk1QZE9RN1ZxekxpVW9aOGM5Q28y?=
 =?utf-8?B?RG84VXpVYUUrYzk3U3dKaGJkSTdQQWQvQlVNdGJLZWpYQ0hSTUxHcCtOVmh2?=
 =?utf-8?B?WTBsVGZaaGVJWHZMMzk5YzNHb0J0N2ZNWUM3aWs2QWMycU1uUE1mSXlNRXdL?=
 =?utf-8?B?cXkrMkRQa0JyODZWMjVOUjBqWmlub20rQ0hlbjBGVC9WUEFFa3ExdVN4OFpH?=
 =?utf-8?B?eFJYU2IvOC95dWV1djRZRlRlTVJ4WE9mKzQrcEhvU0pBN0RqdEs4THdFTmJG?=
 =?utf-8?B?U0lDWXFjMlhYWXVEbDA4OERhdE5vK3ZNVWVNUU56YmlJc0NvNHhycWFXczhr?=
 =?utf-8?B?OGlQL0VVTklaSFo3dGJoN013OVdLaXgzeEFsUnBCbk1nL1hwT2x5TkVhUnhr?=
 =?utf-8?B?NlZsakNxT3pEZGRybjJnZEFaVkZ0aUg3dVluNzcxYVZ4Y0Q3MVpPK2FHcDlG?=
 =?utf-8?B?WnNHK04rNGhqdlduSzY2TFFpQUpZb3N4UGFkeDZoa0ZneDRralBZRWk0VVg5?=
 =?utf-8?B?Mms1ZW5FNUZiV0g1cXFxeHkxd1ZnNENVM0tKc2w5eDBtdTJ4YmxXbmU1K3JG?=
 =?utf-8?B?dWZ5VDlZYkNWN2hWNTVvaHdqMU1TdnR3SGk4blNxd3pZUzAxZUxPUjJMcUwr?=
 =?utf-8?B?V2FuMGpqeHN2a2twQWNCUWxzd01HRkpiSjVWVUJZSTJoT2xrTDZYanNDZURG?=
 =?utf-8?B?Z3phK1ZCVUlQVENsQWgxV0t5WjREbmcvVWNqbU05bWNnTElqL3ZKZDIyLzc5?=
 =?utf-8?B?NGtBQ3RIZ0luUFprNm9kSGxQa0VjV1NqeTBDa2dDZHNLUlBUVEt2ZVgvalB2?=
 =?utf-8?B?WFZPbDlFSWhseWxtSXZpd3FGMzZiTGtma2Q1Y3RTbDNmaSsyUVNEa1FLSVR6?=
 =?utf-8?B?SThEUGd5cEIzeDN1VmkvN2F6RXZoSE1GckpERE5NWks3WExDelhIanlkaE9T?=
 =?utf-8?B?WkVXWWNsWkNxVG5JaktaZXprNkNNRWdUZTBqNWFweWRJalJwdEhtZzFhMjhk?=
 =?utf-8?B?NkR4S3NIbUYza2N0eTFWbjFLNmExRjVwaDMyUDBFTjlJMEhoUTJ2MGdxMWYv?=
 =?utf-8?B?dGt2UXFSNVptbUdqWFh2TzArd2ZqeTVrSEFQVVVqdE1DTkdrWUdpYXBRU01x?=
 =?utf-8?B?VkxYZkplWXVrd2xlVUJ0MFFvWkw5eTZwOU9pSDJPbGtXaUtORUsrMmc1aEtT?=
 =?utf-8?B?YlJQc2hGMGhkeTBpVDBLcHliT0ZIU1ZTS1dQOWZUS0NlUTE4aFc2WWpMaWVh?=
 =?utf-8?B?dW9QMUhVOHVhWGc3KzUwMzJzU1MvRGZIc0tBOU01OExTQkNpMUwvTGlPYjdp?=
 =?utf-8?B?N1hDTWZhMXRYME1oUWZQY2ZaZFlRQldsQVJ6UHRIaGxDc0tvZThUbExlM3Iw?=
 =?utf-8?B?WXJHaDY2NXFNTldDOWdYZEU3TkhlYUlsZXhoQXV6UWVHL0lFSGpFRUVLUGJU?=
 =?utf-8?B?MDBvZWdydDNWUlBJZ0hhdG94MTdVdXJPYTBqZE9pRHpXTW4zWFg2RWVkOFpp?=
 =?utf-8?B?WlZpdis4YjRDcUR3eWtVL1h4YVhYMGJlZEQ0TldNamppdE93bG1rTkg4WGlj?=
 =?utf-8?B?UHhBL0lncWN3WXRJTkl2VzRoa1ZteGM3dWpxYjdNTlAzek83OG12R2dXaTBM?=
 =?utf-8?B?bDVIWWxNNTExT0ZrSE1XSmY5UnVFMG5Cb0N1VXlUYUgxa1gwYjl6MU1xYWMy?=
 =?utf-8?B?UlZjSGU5bEJFcllFU3ZScnRqTmJhaTBNcXp4SksxNzRDYjlwbktKUW9UdUYw?=
 =?utf-8?B?RjhwMFcwQlpIenpJV0VvcElZYTdWWkR0Vm1CcmJyUDRNTk9iRUptcXU0YkdH?=
 =?utf-8?B?RGFVV2JITWNWR0tuMDdFbDBSVVppRytUcTZPQmpZWHlVcTVPYXIyYU8vL2pN?=
 =?utf-8?B?dm9nME9DMXRnL0ZJZUJEdXBtelFpVFpkekNxMlVJclZZNWNGMmdnSnE1eTlM?=
 =?utf-8?Q?P9PfUJ/iDJuY+I0NvVBiRW8Dm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e67e3f-81a4-402b-c8b4-08dc9590b753
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:33:16.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+KEldgMvCNJENOUyOQvbEDOFZTA/XhxGz1Kfn2LVSPb6Wu2c9QKZJ6M1jBWGdNHuOJHv7zYZlsPtu3XyTd2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

On 6/25/2024 22:27, Viresh Kumar wrote:
> On 26-06-24, 08:55, Viresh Kumar wrote:
>> On 25-06-24, 22:20, Mario Limonciello wrote:
>>> Yeah; that's effectively the same result as Gautham's suggestion.  He had
>>> just said to change policy_has_boost_freq() for the same.
>>
>> I know. The problem is policy_has_boost_freq() (as its name suggests)
>> needs to check if the policy supports boost freqs (in a generic way)
>> and it is used at several other places and it would be wrong to hack
>> that routine to fix this problem.
>>
>> All we want here is for the core to not touch boost_enabled if the
>> policy->init() function has already done so.
>>
>>> I'll test it with yours and reconcile the better one to submit back out for
>>> v15.
>>
>> You can send it separately to be honest, and it looks like a fix, so
>> Rafael should be able to get it merged a bit sooner. Add a fixes tag
>> too.
> 
> And maybe send patch for acpi-cpufreq and any other platform that is
> broken too..
> 

I can take it all through the amd-pstate tree.
I'll put it at the front of the series.
I think as long as we can get it merged before ~rc6 it should be fine 
for the 6.11 merge window.

