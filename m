Return-Path: <linux-pm+bounces-17476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2860B9C6E0B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 12:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8FD1F221E8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1BD200109;
	Wed, 13 Nov 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ueuyPPi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6764DA04;
	Wed, 13 Nov 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498115; cv=fail; b=X3UdvaHsq9KDpyTUe7ooKpk3Lq0+MCXsa7BgQR0ZXIt9GfTZXanC88pzA8gI4yY1GjTv9QJ3+N0fQXRm9hp3K2s/jLYp7RW5QFMMsoAMFc08esQisIGAr0TvkZLWVj4qaINUeFCdjxMPi/rsb4UVscMelat4zndUwkiBAg/qc2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498115; c=relaxed/simple;
	bh=OyPOY2MrTMROWjr6x8198+jiqgqOCfWLd41GVEszsLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LweDMHz3KWxAHjc4SUetmNA9d39iMAqngahoC6iH71tVHRlpZsiIGeMAzyyFUXlSUWUkLjS3lEKLBIvPgEstCfukjJZpzkaxYtHWC3b2NUDbhRQBWI6MuEA2nsTnI953I6leWOsmkcrz5qthbcgkcPTU0E11m1hRUgFfAGDce7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ueuyPPi4; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqypDB41xefnle1pP3z7BmO8ue8EXTDMfQeRFLQxaj0l2OKsakURE0jMaggmoQRNFptxNRKmcK/ktjhUASKAevPK/nUQ1Kb7Vf9RCYjdKiGQ3g2bF3ELweijt+YdzbsVnZ6kJK4un0E1D1Z08S+6fl2XwNq1bbFvcJOX8WozoA11eQN/pSeX3+CksTDpULKBDZNV0+5eNkeomZO0iYzHTTWegXN3N9JbLh1wVIylf4TJGtyA6ScNfOuB0usblbaKS79UyfDe1XZ/vaBfDJj+iRWlL2oYsoVR7KUvb6FEWmILQfgd2NMN561PJS+DZ/qnrYzUfwEX8Y7tghOWFCqcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXD86l0S36bj36NMoSwR+sQht7gaA12by3Oze/LYptI=;
 b=cQN9imhlnaJ7Nx5nCOeMzxsK12b0NDg1k+DMNpNTZJegeQ/UoGbHcx/sT6KpCtUniFwEflHJm2puL98UwOnFSR1yisHNbZLSrcT8YrwZGu5Ov4m7h+iq19LAKavVosHzXos/DEJqYxkeM/Uv+gX5eCfXhStl8ODnYDZ+V/2PkL7/90g259maJGozswEibLns6i6GqsjrjlM5Q+iMcLmino9P31r2Zs8GH5qTwn780radXYUTIz+63YwK2UeE+7d+GK0+gVuh4fyCuM+Bg/wz4A6VxABcvXRaHlWXpy1TTcpdjVs/Q4tTA8IPsyxvXQgjZPcGacwleRs4yM7rJtdNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXD86l0S36bj36NMoSwR+sQht7gaA12by3Oze/LYptI=;
 b=ueuyPPi41M0qfazpKVFJ4jqst/hx4uw3cW3SEexdfMs5AwmbiEQtNgWJhiqO2I/4DhH1AieZGceKTzV9XHe1so6kkok78E+yhPlSt1FxDFB7w4K8ZiYxb5d41IgEH3NHyS50iK3sVmBsgfijlazTLRBjb5G1PPGgu0uIySKw0gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 11:41:50 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 11:41:50 +0000
Date: Wed, 13 Nov 2024 17:11:38 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112145618.GR22801@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: PNYP287CA0041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2f3b80-062e-4423-9a41-08dd03d829bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlJEUTRBVTVSRnNBWGlDeWg0RnJCQlFGTzFQYjNrUHpUcWs4SUplUlRadDcy?=
 =?utf-8?B?Z3ZoYUVjb1FFOFVTWWdTTFI1elRMN0VteUZJL1JZTHYzNEJ2MkxnL2JtV3Vp?=
 =?utf-8?B?bVNYd29ld3ZBTzM3QzN6NnJ6M0htZnhEVGFLTUdUWk4yVWRBWmhHSmRHa29w?=
 =?utf-8?B?L3QxNXRGeWZYU3RxU2xkcTNBc2Z6SkY1bCt3R1kxa3ZyWmRwT0hkSjM0MDM2?=
 =?utf-8?B?TEZncnk2LzkyWGJXdldsV3hiclRSUnZPd1AwV0NWWVhEU1ZUUmtob0ZQWVl6?=
 =?utf-8?B?REhrZVFVdkRhWTZ6VDAvcTh2Y3JiYWIwVmRzYS80VWNpRExtRW1JWkVLOFJj?=
 =?utf-8?B?T0QyN3JNYnZMTGZSUG4zeTVxY3FVb01DOXBXR0VOT3lTajRkWVUvSnVqZHpU?=
 =?utf-8?B?MWhOR0RxYXZOR3FrVEtRbmhEQmpHVUo4WkFUc3A5WTNnOUdRT0x1SlAxYUJO?=
 =?utf-8?B?QWZ3Z2gvWlplVUs5czVab24zL3d2a0NzR3ZVc1ZncDluZmF1M1V6eVdFY3pV?=
 =?utf-8?B?akZoS0pXbnJaQmdxSUFQNEUyZ3pwLyt5dFdZNGJ6UjFTM3pLbU82S3RSTDBs?=
 =?utf-8?B?b1VEbW16dnNUemJxL2xYeThBaE8yUVJPZ3pObm1IbmdKTHVOSVY4WTdNaWZt?=
 =?utf-8?B?VUVsZVJqRjRBUjdRVEYvMzNVcU5mN3ZNODk2eEdNZnZCU2dFaWFzdUVFd2pm?=
 =?utf-8?B?OVpTekQzSFFVQUV1UUJUZktBL21uUmd1c1ZySUdwaVhQV0RvMlAwUzRYZ0Uw?=
 =?utf-8?B?bXFkUDVRZE9CRGZ0NFB4ZFViUFlwOGtrUU9FK3ZsYXBhclB2NTBrcjdUaS82?=
 =?utf-8?B?OWNzNUhGbmh2a1BVajJFN0t6NjJCNjZWMVpLUXhYWURoeFZGS2tsNlpOaFU4?=
 =?utf-8?B?T01NV0xyM3V1K2RJazN4VlFYa1Fqem5vN3pDTVVvQTlPV2VCNlZFQ2F4QXVJ?=
 =?utf-8?B?T3NyamtQY2o4eXFmcENzQkR4VG96WjZWM000VHZnNnoyaXJWaUl0d0ZTM2Fs?=
 =?utf-8?B?NFFxcGluMDJ0ZlNmamR4Y1BGdVBFT2R2SFZHR0ZlZjJOMkQ5aXBEcmhBL0xY?=
 =?utf-8?B?VWdEU1RrOVhDeDA2OXpYUXhEUTZ2ZmYwOWg4MUgwbERIUWp6UEt5c2VLbHRN?=
 =?utf-8?B?aElFUlExWC95ZEEzTUVnK2dRSU1ZUTlnL3dlTmRvUFVFRVR3eTRCTzNvMVAz?=
 =?utf-8?B?TVBXYy95ZnVqcFZLbzFiVFBNY1B5aERyQ2d0Nk56ZEozaFVubm55c3hJdnVC?=
 =?utf-8?B?M2s2d0Vma0tJY04yNjdua0d3aHNzSDVuZG80Ukk3d2wvcFcrZENOSnU5NG91?=
 =?utf-8?B?WUplYkdhTWk4MVBYZlN5NzZwcWtZcjd4SXF5OEROQlNqbmxNR3BXakNESnpL?=
 =?utf-8?B?UkdNZ3lwVURBR3BDaUdFdnRjVHNxWmh4ZG1rZ0ZUS1Y4TnRzKzJwR3cwNG9C?=
 =?utf-8?B?VUR0VkZlMDh6UHR0eXNaeUFtNHhkMXg0RzBSMXpvWEFFUE5TTlBFaG1hS0VF?=
 =?utf-8?B?VTc2Vk9IVVhuWk9kdFZxbDNTbGF1TkpwdXU4OFdxYllBRzRjOUVZZkNPb2F4?=
 =?utf-8?B?UTN4K1Jhb0lzRDFWaU0yLzJ0dXpjaHNZK1FXVDBYa1dLdUdjY1VQNUVHcGox?=
 =?utf-8?B?OVlIREtleW5JcHNVejR3Mkpqb2JwZFlUeVhqekpsYjQ3dFlIVWlEdFRYRDhp?=
 =?utf-8?B?dDE1STFkVm45MklJUGdlK1QxZnlIZXdUdmVJL2o2eGVxRmJDSERqS0ZvUUpD?=
 =?utf-8?Q?lmcu1GO2XFPHE1H2TbW3dNfwDLXNp69R9mxG+HV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TklpUjQ0L2UwYkNycUM2Zkd6QXdwVzBNVXZJaE5kUWxSb1NUZ3Z0NmFtRHZE?=
 =?utf-8?B?VUtRRjNJQ0UwVkJQSTdzbEd6VzNIRnoyT3ZTd0xFTk80UXpjNGl6WjlJWWZ3?=
 =?utf-8?B?Q2xhblliMXVYN3dlQXFGamdGemxHWnFINjU5V1VlL1daRnVhdXdYc3J5a0NM?=
 =?utf-8?B?QVBrWTR0cGx1dzRJU0JWM2h4RXBqMUNid1ZYa2Fpa21LU01hZGZvRkl3aXVV?=
 =?utf-8?B?NFFla3NLMmVPZjQ3SDZqQ2hsR2M2eVRvS1V4cTZDMW4yL2M2aFBXc2o0QVRs?=
 =?utf-8?B?MnpjY2ozS3YwZXgwNVlySnhYaWR3Wlg1RE9NS05CdnRheGlXanViWkRrZ2NG?=
 =?utf-8?B?ZURwWW1qN0gzRmNXcUt4aFpIZHJheWY5R29MYWFEcm9kamZOekd3U3BwemRz?=
 =?utf-8?B?T1hUTVJBc3hiRWRHZVpyVityZUxnUnZFZ2w4clNxM2ZRSjJlWFNXajFDWDEw?=
 =?utf-8?B?aWRmbDRyYTlZS1JYc0V6SUJZSFZKS3ZabHFNdS8xN01NNVpqT2FrYnI3SVIx?=
 =?utf-8?B?Ymx5b0M5YUJ0ekdUTG14Y3drVU9XV0orbTQxRWVuMVhnYzJpemwrSWd3R1Nh?=
 =?utf-8?B?d0ROY3dMeE82Vkx4UU55c2ZGTlZ6dlhaeDErR0IzTGlZeHVXNGNYT3lwa1Ew?=
 =?utf-8?B?WUs3Z2RKSE1JeEtRTVRaMEUzNE1waVlDK0hETlB6RWVWZG1TMHVtSzBTS0Fy?=
 =?utf-8?B?bktTcXRrV0w4SUZ6dTd3RUVrZi8wczAvN0VRcTRLRnQ5VmVVSk5kVndNRHZq?=
 =?utf-8?B?RkNBT0Z4WHJJZDlHTXAvSUlvU0M4SjNEeGdnMHhsczcxdTJLcnlhVmdwSktw?=
 =?utf-8?B?TWtSYUpMaWZHQjcwUVR4cUhPVFVzT2xob3lic3c1UXk2UmtrOHZJb3NWZFBv?=
 =?utf-8?B?b04zUk0zR1hvcUc4RzMxU0hZTjAvVTdnQkw1VlJiOVR3US8raW9ZR0pHbEds?=
 =?utf-8?B?dkJQYk1tVGhmRXd1bG9rcGxlR3JSQmdOanJlYStNeGRJQVVKOFZaWktoTzRq?=
 =?utf-8?B?OGNlMktGdGxuTys0SHg4TmIzczJGYWcwaHpxK3BKVjVnb3dvSjQ3ZkZVNVBW?=
 =?utf-8?B?NnQwd24waDBQOW5sQ2Jza2d5V0RiV3BLRGtuQVVvMVZqbExGeE1YNkF1Rmg1?=
 =?utf-8?B?OS9Ud3A4OXBrWDVzVGl5Y01DbE5BTmZFOE1kSE51aStBalprbWxrNnJHeDNX?=
 =?utf-8?B?SkNtZXo0ZmVrckJlZXVLWlNoZnFtZ3RVU0lTY0UycmJ3M2FtdHNUd3RLTk9R?=
 =?utf-8?B?bGJPdWJ4SmRBY3MxVVUzL0lNSHhiNnZodk45am5ybHdad0RPWW5PMWxBZktD?=
 =?utf-8?B?VjR1aDN1TUlFL1B0REdMWFBTWW5Ic0ZwdE01VUZNM2QxU01qMnBFeS9xOG9B?=
 =?utf-8?B?SklDUkVmUE9BQ01FUUdrblN4S1k1dTBZRVc1UVNlZHROck5wV0Q0dUsxcVhF?=
 =?utf-8?B?RGJIUmxGaTh0c1h0Z0ExYmNVdGl0Skd2KzA4TDd1WFE0UWlNRzF2NVFwZHhK?=
 =?utf-8?B?eUJTU0U5R2VYNThwa0VDcE1DOUxYRFVxdVArZE4xZHp5aVVWKzN5RDhxUFhJ?=
 =?utf-8?B?ekpYLy8yRkFJZ09UWm4zNjdnOHptRXB1SDllOVpsTXFvaVgrbTNRS285cDRs?=
 =?utf-8?B?MDNiMDZ0Q0FjUk1kR3YycEJEVElLTHZaNEpNMm5XQzFzUWlLNGZDSC9VZlVN?=
 =?utf-8?B?ODZVbHIyL3U5bFFBSmJ2MTF5NExLWFYyVHF4NWVhV1pMb3czYmpYSEtncXE2?=
 =?utf-8?B?TUMyYS9aaXlNanBUbGhuVEZDaG01NkNXblR2TDFnYnJ4RGlxbytXR0h2OUwv?=
 =?utf-8?B?RGVoanhJbkUvYVpTbnEwdkFyVFZPSkxzUjRHR0FHUlpzcm9JaWswSFY4N3Mw?=
 =?utf-8?B?VXJhcG11eWZXYnZLZ0tXV0NmVHArOGI2OHhKd0VNMjNyUFkyZXVoY2RzdE5i?=
 =?utf-8?B?VzNoUkNYOCt3dXpNUkVNcWR6bGJCbHNDVXoyZHZBZnRaOTZhS2trUlNEalQv?=
 =?utf-8?B?US8xMDhmTmpOYmpiUlZxWFVHYVdZWDFMd21mUWJZSHN3OWxqMndZelBiMXNm?=
 =?utf-8?B?eHRaanh0eWhaZkI5NXVzUGZReVNOSS9NY29nazZGOTJDYTZ0U0xGOE4yaVBP?=
 =?utf-8?Q?DbF0jyk99yXstg94532kmIjXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2f3b80-062e-4423-9a41-08dd03d829bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 11:41:50.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDasMKopawLM0iWYUg6s8k/LTrVyqOAZv6mznlw+eCljlq+ZXiYcSupsxcUtzzk0JajDkkhxhYXW6Op8ZOQ4GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

On Tue, Nov 12, 2024 at 03:56:18PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 12, 2024 at 02:23:14PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 12, 2024 at 12:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 01:29:08PM +0100, Patryk Wlazlyn wrote:
> > > > The generic implementation, based on cpuid leaf 0x5, for looking up the
> > > > mwait hint for the deepest cstate, depends on them to be continuous in
> > > > range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x86
> > > > platforms, it is not architectural and may not result in reaching the
> > > > most optimized idle state on some of them.
> > > >
> > > > Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
> > > > fallback to the later in case of missing enter_dead() handler.
> > > >
> > > > Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> > > > ---
> > > >  arch/x86/kernel/smpboot.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > > index 44c40781bad6..721bb931181c 100644
> > > > --- a/arch/x86/kernel/smpboot.c
> > > > +++ b/arch/x86/kernel/smpboot.c
> > > > @@ -1416,9 +1416,9 @@ void native_play_dead(void)
> > > >       play_dead_common();
> > > >       tboot_shutdown(TB_SHUTDOWN_WFS);
> > > >
> > > > -     mwait_play_dead();
> > > >       if (cpuidle_play_dead())
> > > > -             hlt_play_dead();
> > > > +             mwait_play_dead();
> > > > +     hlt_play_dead();
> > > >  }
> > >
> > > Yeah, I don't think so. we don't want to accidentally hit
> > > acpi_idle_play_dead().
> > 
> > Having inspected the code once again, I'm not sure what your concern is.
> > 
> > :enter.dead() is set to acpi_idle_play_dead() for all states in ACPI
> > idle - see acpi_processor_setup_cstates() and the role of the type
> > check is to filter out bogus table entries (the "type" must be 1, 2,
> > or 3 as per the spec).
> > 
> > Then cpuidle_play_dead() calls drv->states[i].enter_dead() for the
> > deepest state where it is set and if this is FFH,
> > acpi_idle_play_dead() will return an error.  So after the change, the
> > code above will fall back to mwait_play_dead() then.
> > 
> > Or am I missing anything?
> 
> So it relies on there being a C2/C3 state enumerated and that being FFh.
> Otherwise it will find a 'working' state and we're up a creek.
> 
> Typically I expect C2/C3 FFh states will be there on Intel stuff, but it
> seems awefully random to rely on this hole. AMD might unwittinly change
> the ACPI driver (they're the main user) and then we'd be up a creek.

AMD platforms won't be using FFH based states for offlined CPUs. We
prefer IO based states when available, and HLT otherwise.

> 
> Robustly we'd teach the ACPI driver about FFh and set enter_dead on
> every state -- but we'd have to double check that with AMD.

Works for us as long as those FFh states aren't used for play_dead on
AMD platforms.

How about something like this (completely untested)

---------------------x8----------------------------------------------------

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a3a012..bd611771fa6c 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 
+static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+{
+       unsigned int cpu = smp_processor_id();
+       struct cstate_entry *percpu_entry;
+
+       /*
+        * This is ugly. But AMD processors don't prefer MWAIT based
+        * C-states when processors are offlined.
+        */
+       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+               return -ENODEV;
+
+       percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+       return mwait_play_dead_with_hints(percpu_entry->states[cx->index].eax);
+}
+EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);
+
 static int __init ffh_cstate_init(void)
 {
        struct cpuinfo_x86 *c = &boot_cpu_data;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 831fa4a12159..c535f5df9081 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -590,6 +590,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
                        raw_safe_halt();
                else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
                        io_idle(cx->address);
+               } else if (cx->entry_method == ACPI_CSTATE_FFH) {
+                       return acpi_procesor_ffh_play_dead(cx);
                } else
                        return -ENODEV;
        }
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index e6f6074eadbf..38329dcdd2b9 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
                                    struct acpi_processor_cx *cx,
                                    struct acpi_power_register *reg);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
+int acpi_processor_ffh_dead(struct acpi_processor_cx *cstate);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
                                                      acpi_processor_flags
@@ -300,6 +301,11 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 {
        return;
 }
+
+static inline acpi_processor_ffh_dead(struct acpi_processor_cx *cstate)
+{
+       return -ENODEV;
+}
 #endif
 
 static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,

---------------------x8--------------------------------------------------------

--
Thanks and Regards
gautham.

