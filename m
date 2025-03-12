Return-Path: <linux-pm+bounces-23913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC698A5DC69
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4748F3A7CEA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6023F28A;
	Wed, 12 Mar 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tIAgF64r"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324B236426;
	Wed, 12 Mar 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781808; cv=fail; b=G/pTZcqhio7wzZct3FvqFpIjMRHBxYaSsaqVzpbLu2I3TtD+V9JO0kVl9D+fxvu/G43wbw0F78F7mwx1oDDQHilG5ViiBKNTYNNvteTmBieo1ZYEcnurYQZ8Yg0AauF9ReEk2wdJq0v+esJd3FSq2rZz03SY9co02qBxIRVoLjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781808; c=relaxed/simple;
	bh=/H40qA+RlOuZfmyMcNL6MEwOf+zi9B/R1wuA/yJ01wI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VUsDuu2ucErpQsI+xEBLMeaw5x53rxbbhZGQKRPRIMv7+N1T8GVfv4UgSpE9Xp+dQPI6u4g8n2V9SerhkehBFcXcPDe7RgB/UESGugroG93RuJhPhMBBA/0h7ooEBi3m43v5VUEShH4WXZio0dtRGPuh3AE4De7R+kuPfVsRpsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tIAgF64r; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe5Gkk3/wYGtGH7BKjyommIib5Agju1Zt4j5gJKB30hw+H8a9+/1fAJmeh5HCQEA6OYiRXDn1kshhQ2mhyRAZEgU5ShVPIgwJfvbRfubP2rXtUrx1XOus9bn6ykj22TDtEag0neVzW9dv5Kv1ci6/XnUKDVHk8preVOC8yvGWqLrdpQ0GSAsBox/jthcXxye9SsEfZJPJxndPuM+OteIcqcemAJ9mbqKbz58VAlep7fKqGD7XGE78RglRGSeUouYxMIrOhOXCnnJgvPDU5E9E9rvPyP/o2ZrAvTG9FRnyECWQlPHRMap6/ff1K9JX0bfFo1/HzUDQ2+j7/+EOmS4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfy7g1zxhsaXgB6HnMyx/t1Dd+zrizDPbg3jLRFtzsA=;
 b=UcW5A9wjVKXONc8nQXEwMhRGZ2E/hbv45snJzyoqDVu60PqZmh8rtlITxMEL3GZkINbk9Vb/VTYXlJMRKlvHbVai5j4YH5VxopZKsSUUr9j6nqrCnVY1FujbnS3FhtzVOinNBtzmEWapzCjDbRzCpPdy5rE6qF5lyJ9PlhEmUscgIBvUhUfqt/+NWpvwqgLSnFZuuk6VwMp6inqM0rlVHBT9/na9qP8jmhHeKpBLAk2ifg5fikR+jIjOhGykrX2Rm0g1twrSgaK9pmqf/DC7O0ZwdlyGSh+4Aw1pG9FkabKXapiWkz9j1Wkrg1/r4bUQ9kQeOP5BlHEroa5xt3wOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfy7g1zxhsaXgB6HnMyx/t1Dd+zrizDPbg3jLRFtzsA=;
 b=tIAgF64rmTRzj3dgrrto5Hb+L3hfnoR7tc2xkCCRji5gA98ZmnwkiDrjyLiTxcchfbzU8GDkr1VNnxXQeftomLCYMV+UPBdfAjAi9AtiEe4WBN06XamIm1JLx/XtH4/v2HXgPGh9emKHoSww9sINsgZmZaJC3Hzdwv60XhA0NHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 12:16:40 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 12:16:40 +0000
Message-ID: <8e87fa8c-5254-46d5-a853-46e8c31cbe0e@amd.com>
Date: Wed, 12 Mar 2025 17:46:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250304152327.1561017-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b719bb9-506a-415b-0823-08dd615fbea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eERaQktGL1dBUXk1Vk43aEVaWER3TDlOb2l0WmphUGVZaldUMVp2dmxFUElG?=
 =?utf-8?B?WGYrbFJXVnVFRGZGa0JzZmZ3R2l0Q2FFank0dDdKVEFtSGpIOExRRlhvSTk0?=
 =?utf-8?B?ZlUyNlZ3QVNlYWdMNHFKLzhneXB0djlWVEVzNmdUWnJpOGdVUlE3ampNTGVJ?=
 =?utf-8?B?V05MTGszdjRZd3RteCthNi9qdDFtTE9xV1lxNE1RSFN3NkRuZlAxSGZ1SkVv?=
 =?utf-8?B?R2k2UklCVFhYSnhjdmJCM1F1SGZuRW0zNlhBK040bW4xbHIzbmpxd25yOUJj?=
 =?utf-8?B?ZWxCbWtuZHZ6WUxib1ZtbnFDbjJTSEZvdFNBZHduL0pXUWZyNzRNUUdiWk9O?=
 =?utf-8?B?dVRJaW4xaFhydktxdmtDUFdJZ21HeTllMnVnVk04TzIrYVRqenBNcW4yc29E?=
 =?utf-8?B?TUNaRG1adFozcXYvMHJ2aVBrT2VydmZ1R2I0WWFDUTBxTTh2emhTZWkyTkVN?=
 =?utf-8?B?UzZLWm9HUFZiM21PQ0ppc3FYUVVWZnM2d1NONFNoTWg5WW5kYkJpMExKZHda?=
 =?utf-8?B?UGNTM0VoWkxySWMwM2U4T0xpWEU3V1YrOHNPY0wzODlldTVhYjdjV2JOd3Yz?=
 =?utf-8?B?cGRmUjQ5eXl6QkEvZVhneGxvNkduZDgzQnJzQXhKRU4wanVESmlFenRBVmJv?=
 =?utf-8?B?bWJJVE9PeEs0bUR2bWpyMC9IMjNVWDRGOEF3ZjZLK3NnMi9xbzQvSkRabkxL?=
 =?utf-8?B?bEVYaEtoU3Z4ejRZSTM5bS9La3BVSlY1b2Z2QmJQc0NtOHk0R2U4UkpQRHFN?=
 =?utf-8?B?eUIwYmlXUjhxQTMyb2wyVmF1NDdwWm1GMWxBRmwwUUNzdXRYc2JOU1ExMHB6?=
 =?utf-8?B?TG5vRmdSemFhOWFSb3dzYVkxZGtKYm51ZGF1TVBzbVoxcE5oWmtVVC9RTCtG?=
 =?utf-8?B?azlnK2dldDN6UzVuMVFHYmtCNWI0SFpiV0M1cXVoTWV0RXNPWlV2VkRjSmFS?=
 =?utf-8?B?Y3hZU2VxY2czVXV1U1NZbHlRQm9nWVZqbjJYZnQ2NzBDZWVXYUFwazJZeFdG?=
 =?utf-8?B?Sk55d2U0aDRvOE11b2pTcDByL1hiVkpPTTZNWW5NOVZlZUJadzJRQzJ0WmtM?=
 =?utf-8?B?MGs2TFdvQ1JadkEyeGF6bXRqamt6WC8zZnl1NjNNRE9nN2hjK0ZINDNKc2Ew?=
 =?utf-8?B?c3VSZndHSkNTOHZTVlNuek1GVnpvWmV6OXMrWnlGTGJLMzZGNkNNSElUbHg5?=
 =?utf-8?B?TFgzM0FzbkFYK282ZlU4bDJwZXEvY1FZMXVWb1VvUHpRWW1jMU5oL01DbjVJ?=
 =?utf-8?B?dGxzYmdIUHRCbDMxRlVjSUJmTkxCd2pKdUQ0VmExVlNMdjFIWTRDRmZBaUJm?=
 =?utf-8?B?RjNjcE84TDAxVHNkK1lVR0JWVHdmdDVCYmh1ZUUzOVRWRU90U21wZHRNWHYx?=
 =?utf-8?B?VEM3YlVvd1Urb0xkUlB0WGdsaU9JU2xFOTRFRmhGRXZCazNpb1VUYUlGRTAy?=
 =?utf-8?B?cGw0U2M2YUltTlFEeU5Tdi9obERQc0djSHBRRFJwS3dRK3k5NnZwKzI4T0R3?=
 =?utf-8?B?T1F5WGNEYjl4MnBYT0hWL0tVUUtGb3A1Szlpbk1zbnVTdG83VFNhY3E4dndn?=
 =?utf-8?B?T1dJYjJ6Y3ExK3NNNlFHS1Yrek1oSkR6SFliQUU3Yk9ncVhSbWJmaDZSR0V3?=
 =?utf-8?B?bndyOGxMa2tKR256aFBlSUxOamdYNXo2QlAweVhLbktsT2NQaVZVbEFGdWty?=
 =?utf-8?B?OU15ZnNPMDZXa2o1cEtPUjBhUmk5MEJOUGdITzV3UGRRMjVlSUpVM05VZ3FF?=
 =?utf-8?B?UDhGY2wzbzhLTXBtcTZZekF3akNLMGVKSTdiNEJOUkxVcmhxU1hzL3pIYTFP?=
 =?utf-8?B?QWsrb3pNSWRWRkJXaThtbk5WOHF4Y1JzRXRyTE1VK2lGdllSU0RHd1JpcHZt?=
 =?utf-8?Q?J61K4PfhddiiK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXN6bUQwOE9hci9OVGxiYVZJWEd0cHZaOWxBRzlpR1VzRy9aME05TUUxdFJL?=
 =?utf-8?B?c2VGMmhaZTlUQXlPNzJSb2c5Z1NuNmN6SS80cTRtL1YyRHFYMjJSYXZuOGxZ?=
 =?utf-8?B?V2NjYnliY2ZBWHVXNzRCN0lZRFhsTU1PU2hYR1RCTHpkakVmUE1PcGp1K3Q2?=
 =?utf-8?B?eEZ4cHZkUHl3MkxJYkxWeC9DcVEzcW0yeFlkRXhkLzlkVG9YYWdpVlFwWlpZ?=
 =?utf-8?B?aENKOE93bHU2dVJoaGNWNlU1ZTI1RE5OMFM2Q0tRZnViMnhRcWN4RWNuYVhr?=
 =?utf-8?B?bVVidWwyUm9QVVZRdlRTTWVMeUFKd3M1WW5BL1hzakw4L0pQcWZyMWtkN0Zh?=
 =?utf-8?B?eHpjZmpMU05YdTZxR1NQUEdVdmR3UUcwNnJjZ1R4ejFGeGVNMjBvTVN1RXUr?=
 =?utf-8?B?ODgyMTNhVC9SMW96RS9QTjZUTDBUMml3ZEJuOGpkMjE4dEJ6NEpWSTZFMjRY?=
 =?utf-8?B?cFBNd0cwU2U1ZWZiNG1JbEg4M1R6MUxFMTZDaCtrTDlOMk5zMzlQYkl4Ull0?=
 =?utf-8?B?WnJHZmg0c3V5QTJxd201Uzd1eW1hMGtjUjM4TGZsVmV0L2RoRWRQQWxWSFc2?=
 =?utf-8?B?NmtiTHdQRDFnZHhoenNFWGM4b1VWZWJHQ3dYamhaVXBJeUxPaWYxZFZEZGJI?=
 =?utf-8?B?UHlLR0UydEhNV01keW1GSk9BdU9HaEt5QXNDMnRnc0J3Qm1qT2ZucmNjUEJI?=
 =?utf-8?B?SkpkUTlEeFpRdCthSVRXa3FwWUkwUFdta3BJNjRzMnIvOXQzRFZSSzZXbGx4?=
 =?utf-8?B?dnBZOEJzWlExSWJLdXR0ekZmK2R1VUxhd3FRc1ZZRDVjU2hpeTRCUUxHc0lT?=
 =?utf-8?B?TWJTZUhqUG01UmI5QWs2S1JwSmpycGdlcy9BcCs2K1lWblh2Sm9KTEJ5SzZq?=
 =?utf-8?B?Sy9KQUE2Wk8yWVFIMzNNR1VnaHVEMEVjWUZjUnE5MWhBVm5HNC82VDhUVEVx?=
 =?utf-8?B?REVMUGhHQ1Q2ckg4M2xHQjh6ZW0wQmNRekdORlpyb0pGdHh6V1R6aGU2VFVk?=
 =?utf-8?B?aW95OFBKRktEVUZCM2VLSFVSREhueThRWmhhT2Eyay9PZnM3ZjdMZFJWbTZR?=
 =?utf-8?B?eVpZMFpJV0M3TWdXOVROei9PZHcwdkh2b1QyVCtueFl0c2RNcVgyUzF6czhF?=
 =?utf-8?B?cjhJMjd5WmRjcG1sMEVSR2FiMHY4UUpxRUJTblc3UDdTZVhGTDRrYmZBSCtt?=
 =?utf-8?B?L2tBRWdpQlphWGlWL29vVnFxc2RMNkl6dDU4NWhQZEp2eC85b2Q0L3c0NVM0?=
 =?utf-8?B?WEtQb2V6MXJsTzZBZnJpaUZqTDJOVGwrWVlYRDFWcjRyalNrT2RlTllOOGxQ?=
 =?utf-8?B?ckowNHNUQkQxY0NLb2ZUcUM4Y2Z5WXlmeXlTb0l5U0ptTU1YSGgvMEI0OHNw?=
 =?utf-8?B?RGpxRDNGZ3pmK2JBWVNPSWU5TnVYTHQ4QWhFQS9Yai9GRng3T3Vua1BsSEd5?=
 =?utf-8?B?NnBWVTZKQzc3ZVJiaWRWd0pJOTFFaDk5UlNFWktvUDN4WWhKclZpdFRlR0gx?=
 =?utf-8?B?ZlJ2bDlFU3hZOEEwU040Y25PRkJzbFNtMnNKQVpQeXAwSCtwZzZ5bWJYbnVh?=
 =?utf-8?B?STFMd3FOUmNaVzFmSGhxWUdiTEkwNVFFdW9yd0xvU2IrSDJ6d2crenE0UXRD?=
 =?utf-8?B?ODJYTXhmanY0anNmUHN0VkdQQlp0NUxQUlE0aFN2Qk1iZXJpQ09DQTZKS3N2?=
 =?utf-8?B?S3c0cytlRU5VZkw0cDlaaDJ1THZ5OE5rVVFMVkhMdysyaW5IR243dnBxOFJh?=
 =?utf-8?B?Umx4L1Zpd1c0L21qK3JMcEZvd3NZczFVRk1HNkFBWmVlMVpyUGhjWUdKdGs0?=
 =?utf-8?B?TlhPY2RVVjVGNnVjeHh3bmxPSk81WEhtOE5EWTBvZWFUdllEOTcyaUVXL2to?=
 =?utf-8?B?bUtQTTh2ZnkvVU40alRSVzl1d1FpdWhrTFNZbW1xTE5KRkRGYXppUDVlYi9Q?=
 =?utf-8?B?K1N5WjUvNWprYXhTdEl2L1FVeEIybENmSWR2Uit4eVM0Q3V5N294Ym9EOGUv?=
 =?utf-8?B?a3VEcTJCK0kyMndlaWtvVys0Vi9ZUkpIaFFKRVNidGtMNEU2bHczZTE1RVZl?=
 =?utf-8?B?QUVBRzkyTVhFVVhCU2kwdXpoYStXYW9xbDBNQ0RKSzhpbzZxYmtjZWxnaDNM?=
 =?utf-8?Q?5cphBTRxbkpvrLjNJSpRpC8Nq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b719bb9-506a-415b-0823-08dd615fbea4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 12:16:40.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7jVCmbHCeEXwBuOWrP7qNmNtEucJEdcfhRRo5kjbWpILXwxDaZ8KFf21OCmPmiO9iqIN7LRGmMOea3281s67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

On 3/4/2025 8:53 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Dynamic energy performance preference will change the EPP profile
> based on whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust
> EPP values on plug in or plug out events.
> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Change defaults to performance (AC) and balance_performance (DC)
>  * Default Kconfig to disabled for now
>  * Rebase on latest branch
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>  drivers/cpufreq/Kconfig.x86                 |  12 ++
>  drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>  drivers/cpufreq/amd-pstate.h                |   5 +-
>  4 files changed, 155 insertions(+), 9 deletions(-)
> 
[Snip]
> @@ -1556,6 +1667,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	if (!policy->cpuinfo.max_freq)
>  		return -ENODEV;
>  
> +	/* policy can't be changed to performance policy while dynamic epp is enabled */
> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE && cpudata->dynamic_epp)
> +		return -EBUSY;

We might need to tweak this condition, because if we enable "CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP" in config
and boot with "amd_pstate=active" it lands here (cpufreq_online()->amd_pstate_epp_set_policy()) driver init fails 
as the default governor is performance. 

> +
>  	cpudata->policy = policy->policy;
>  
>  	ret = amd_pstate_epp_update_limit(policy);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index fbe1c08d3f061..6882876f895de 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -104,7 +104,10 @@ struct amd_cpudata {
>  	/* EPP feature related attributes*/
>  	u32	policy;
>  	bool	suspended;
> -	u8	epp_default;
> +	u8	epp_default_ac;
> +	u8	epp_default_dc;
> +	bool	dynamic_epp;
> +	struct notifier_block power_nb;
>  };
>  
>  /*


