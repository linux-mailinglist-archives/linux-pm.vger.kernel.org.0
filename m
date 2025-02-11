Return-Path: <linux-pm+bounces-21835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C652A30CCE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5DF188AF45
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095FF222582;
	Tue, 11 Feb 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kxoga/PA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E52320F;
	Tue, 11 Feb 2025 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280482; cv=fail; b=g6MC3lyyOCFxzWkbg1kTKvDqGov1xOe8s9cwyjvzG+EpvZsa0KTiXkqluTVwjr50A1L2IhK6MlYyHvfb4uE1dHImY9TCfHium9hHQXtWxNPqcMjA+qcv12aqD5HbrRSd8MDW4Ei8LEeFDEg0vkOgCKpnw+hoHbYCoo7vqtkUD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280482; c=relaxed/simple;
	bh=4ZQhK8MudzpArhrgRZyvgn7s8bQDul3mki5Rr5HNaB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOtEExxhA8f8xixh1gagTY6uB0kvn4vb+CbzcpmZJSvWc4AZvFTXYkamXgyiYG69UhsU+jijGc24USXYgV0B8FXvy1GyWZHTkxp2u9A92vXw4k2UgEgsoJWLRk4XDeUdW2pNJ/OQ9eWtYqhhR3zhbBQ5vUxTjvA3nF/alEJ1O6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kxoga/PA; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKeoMt95no6OvGlzZ/yN3ePDpDknCWf+Yvuac/QEHHKdzcIozVshcr0j3UGClrmZDau+/rTvps+rWXcN/rHt8UZch5Jx7BLVQ5Or2zdTb9qkbY57FQbHUK0N+MhRMHmKsXAC9PeowCckAAiGKIkjhBjc3mcegUAwJDFrzIShmfk2FkSIY3JBrzi0hoGX6iAeEEdf3FHAs0V04K8AeUvsmV0jMrJnFjGa0rjiKLKem3nC1XkmV4Xz8NCMy/ASfCFdw58i56kGzIZWs2BlpTgAhbZTWJVmpkq8nguZ+cKEZZypaTd9Mr8NlqJAfr8BQ8poyNL0hltpI6rOlteZM1Ifdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnTrY3+/R4aXkEsA7wJadkZMdeup6+LC+9Y9+lzIjis=;
 b=EOQK9SPddSJADV4gMntkc0elFhaM4zYwGfdn0bxAkood+Me1eYm7VZfXkkv5BIui3dAKvZFaSrLVTZXXpjJ6aj7p5gqUmqpwhKMljph3ozRhK/xeauCXQiGXDfSKKLa0N673WXnxrDRqSBFDrRnekvqtIxKDeP0megIh1NoaODokauS+IQjYy09zHalYJCUN2X9M7VE3Gb+POGdxOrn/cn3j3Nh+OA01vdxagK9a+/BJwGFEC1vNNgPGAhPAd3zHhZYJMigcpE1BotjphH+tEYOFjA5OggDRRgp551QOvq8j8DkkT52ZaAZuEEGJUmc3E+eiee6t+AnFHSGB6t/5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnTrY3+/R4aXkEsA7wJadkZMdeup6+LC+9Y9+lzIjis=;
 b=kxoga/PA7mvB7Px8YDamscKwjTZDqsbkCE1zIEwV9o7GwsGQvtQil/W2eUy4pU3RyLANUTpZmBWWRejp9hIQe8qgYE5+RwUJS1diM5r45htjcNIiT9po7IqenO6PB2BK3k3lgXH/QKZi1EokMyCpn/MxVRErnc/+RV4vk1Dn6rI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 13:27:59 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 13:27:59 +0000
Message-ID: <a326b90f-3c11-43cc-8b86-438b3bff86d1@amd.com>
Date: Tue, 11 Feb 2025 18:57:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] cpufreq/amd-pstate: Stop caching EPP
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-15-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-15-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: c107e990-7d0c-4f98-a548-08dd4a9fe6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTRxbS8yRi94R3BzbFVaNURHcnFTUjl1TU1CUFV1R3ErWG5DZlNKSFVjVk9v?=
 =?utf-8?B?alEzSVdIRC8ySk9EY3NYTjJGbURDdGY0MVY4M01ISnNHSlZMMkh3Q1hyMURj?=
 =?utf-8?B?VTFsbUg2dThDMTlzRlJwQWozU1VXcTdtd21sQ1RSUURkSjlMWklKaU1ETnlH?=
 =?utf-8?B?eHAvb3g5TnVtaGpzZW1IZEwxRGxqOG1PRHQxY053ZUtaQjhvbmMxS3doTlYr?=
 =?utf-8?B?OFF1NlZEWVNmYk5BRVlHQmo3YWJuVTQyN25PcUl0aGdyc05uOStWVDRWbHUx?=
 =?utf-8?B?Z29lRXdFMUVxNFBqd2wySERPMWhZQTBHazZ0dzEwaVNYdGZnMzVvQmV3dFBv?=
 =?utf-8?B?RTM3dHJmbjNncC9odjhDTk4wVWQ4UnByZVQwUGJEZjR0a1dXa050clpXYzFV?=
 =?utf-8?B?WXdzY1hZbm0vSFo1QmdJalJ5WVhsaDc0V2RaSTcyTGJhOHVSdnJBc1A4TG1K?=
 =?utf-8?B?K055Z1BoVFZrUXA1VmVpeHhSWEkxazhVQjNJbCtmVWpQVXlsRmVXQjBaQXls?=
 =?utf-8?B?eklkREx3UlE1OGxTQjYyRGJhWHpqV3dqZ0tBQXdTYllFbTJEK0NCMStuQ0xk?=
 =?utf-8?B?Zk1vaGYrYmppdDIzSjUzQ1QvOG4zdDJab1BsTGZycUVzVmd3UHBaTjVTQ3Zm?=
 =?utf-8?B?TUIxeloxRzhwVTRiemQ0R2ZscXRGTGdEMU5qN2p0VTVBbEN0eXJmSHovYTZQ?=
 =?utf-8?B?MTljbUUyUElVREtRWHNtTlFmaG1XcEowaDdPWE5aNzg3OVdualBzUjFPcldQ?=
 =?utf-8?B?bytqTWdwUDNNOWJQbzZMbDRYdHdqNFJFSTNoUGtDblAxZ2xxb1pBZjVhRXlD?=
 =?utf-8?B?a0d2Ym90MzNwMXl6dGM3QkpveXdkVC83TmQ3bTZreVNGeTdQQ3BCWEswVHly?=
 =?utf-8?B?amVxek1GU29pQ0dHNXBDUGNsRFlZMkhpa3U0MVltTXJ1VEQvMlFmMkNOVGRQ?=
 =?utf-8?B?c1FCWkJPald3aFd5OFBVK3IyRkdGTjVFZlZDRm5qMTNidWNaVFhTby9LVURQ?=
 =?utf-8?B?M2FDaVlva1RQNXBYRk4yd25USVh6MU9kaUhpeFk0UG0xVFIyU3Z2ZGhxcmhs?=
 =?utf-8?B?Qnd5U0t2RTRrOC9yZnhjRlhWeXBxMFdhbGMxU2V4UHJTaURtTGREM0pBU3c0?=
 =?utf-8?B?Z3RBZVBCMWdTeTlTRlJPclJQbG9CbFI4cHFncnZTUnBXN01VMXFCMWR4SndF?=
 =?utf-8?B?MWczR2s0dTZoSEhoU3h6eTkyQW84ZjMwNnE0L2lwM2poQmZ5YnphL1RlNEx1?=
 =?utf-8?B?YVFQSFQzKy96dFdsM2YwdTFRL3lJcUkxM2tFaUYxcng4SlIzSSsxV3ByVkd4?=
 =?utf-8?B?V2N4ZXFlWmtkbUFjbWJrMHdIeDFMTUFXSW4rQjBGQkZBM2hIVGlkSGR5Tm5l?=
 =?utf-8?B?ZjBvTE5kbiswYmsydnByY204RXZLbHkyN3RvVEhQOTF1Sy91Ykh3ZEZtTEtM?=
 =?utf-8?B?blJwV0dQY2JFVmZBc2NXckpxdzE5VmRBdENyd1p5TVVwcXhHeTFIQWlzaW1Z?=
 =?utf-8?B?a0ExcnZwY3RiZW11ZXc4MlJxb2JzVjFyUGhlMkZQY2VXMDVCbkJ2ZEpoWlZU?=
 =?utf-8?B?Q1A1YlNwTGFXc2YrYmR0N1E2aXp1dVQ3RFcxT0VWWEMyVW4rOXJ0d1FZSnla?=
 =?utf-8?B?WVJKekh5RUNLd0MzRTQ4cTVUUEtUcElnM1dtT2twYzVBbzAzRTRmWDhSYVJM?=
 =?utf-8?B?b1lhQ1A4WFBtbEl0eTJFMWFLK1J0VTAxam5XVGt3RUNQNWdJdm1hWmV5Y08y?=
 =?utf-8?B?dVlxSkxZS1FGc0txcWhBd0FMa3ZKWTUrYVNQQjZwaVZDMjZGa3VCczJoSEMr?=
 =?utf-8?B?R2czUnRXaGdkbTRtaXA2THdLSTgrR2lwSHI4bWR3Sm9hQURzenVFaWY0c0VN?=
 =?utf-8?Q?pLXxK9SKo2PeH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUYxYXdjbXBkaW5JQjNPMFRuV1dRdjVyOElvWTB4aUNXZDRyd3ROVVBLYjA1?=
 =?utf-8?B?ai9LM0pkNWhKOHhyK0FCbFJUNENwVm4wTlhDTnRrQ05KNCtob2hhbjZLYkYv?=
 =?utf-8?B?UzMyQ0F4VXg3SGYySXZ1TWJNczk4QWdjK0FtY1V4Q1hUS0RCYTVTQUZTV2x5?=
 =?utf-8?B?YytYaGNBcmZNYTg2aHM5clhFVmQzUWhtQ3lsTXNJU3dBVjZwRlFvcStaOENE?=
 =?utf-8?B?d2twV2ovMW5Jc1k0TXY3WEF2Zjk2TEg4SzlqaGp2N0twenBIcWF6T3BYbERR?=
 =?utf-8?B?NVRFT3NoUVFEbzM1dVVYQ09QKzJhUG1QT0R2bTFLbDQwcWJRZXFTOTRHcEtO?=
 =?utf-8?B?VVlxN1NTNCtsaWJIT0JjUmI0enBHeklDb2RpUno1YWgzaXdVNUV5dGowam1t?=
 =?utf-8?B?ZG1UbzM4V25ZNDlOTnNBZlBHbFpCSDZINjdUNG1mRFZPY1Q3NGxCNTMycUZD?=
 =?utf-8?B?NVdZMHhJN1hkUVZvNFFDOURnSXdTRkpjdjRBTDBGMms1U3ZwekxjQ3BhWWcx?=
 =?utf-8?B?blUvY3RIODFxNG5WR1FlcGZIOGg1a0N2T0oyRVdYR2ZwZjRNTE5QWWhWajJR?=
 =?utf-8?B?c0JWYnphek91NHJqZ2lNY1JYcGRMSjNIVUd5RGpPLzlvWVNnYU5kTXlTY0Zw?=
 =?utf-8?B?K3dQVkxxeGFQNGdjT2NLZk5PcEFHbUVSZFBtQ01KVDlkcE5SQTI2T1hSa0NP?=
 =?utf-8?B?OFlZczBabS96U1JiUUNOMzVMbzFiSndlM09GekJNTlFGRmQybmlsZ0RyY0VG?=
 =?utf-8?B?WngwTVlGdUREUDZKT2pQb095eUpLSlIyaFlmakhlRnJDMXlmZzY1b1l4aW5V?=
 =?utf-8?B?NXVvVUVrdmtwOTVzYlhrV0gwdndBcjFDNUNkblZGMDl6N3pncTNlb29VVzJD?=
 =?utf-8?B?WlJtQkV3WXcyRVJXTCtCZXIwWTZRWG1OMW92dHZ4RVIzN1lwSU5BV21XdG5j?=
 =?utf-8?B?VExuYmJoa28wbm5pSWtYZDZXRHZ2WHNYcktTMHBFc2lzWFVlVHFKNGxPeVdH?=
 =?utf-8?B?by82NHRTb3lmdlk0aFNwbjg4Yk96OVVRRlhUd2dtZXp2dExjWHdoV3BaVWtG?=
 =?utf-8?B?M2lJclFEOVF3d0RWWkJnZFVaa3N3R2dHTVNxa1ZyQ1h5ZXUyOC9OOEs1K1BF?=
 =?utf-8?B?L2UzOEZXMmVJS2R1WUhzTDcxRnBQY005ems4SkRmNkZUUWpaZElLU2p1THIx?=
 =?utf-8?B?Z3Jtb3NpQyt2OGZISEh4UHk3NUNTRHV3d2FWQ0ptV0xndzhwYW15bmpPeVdl?=
 =?utf-8?B?VUwvbWFWVWFwNVlwZEp1dCtSSlZocE1CUUg0MTFlck1ZRWg1Tk9MT0tDRk5M?=
 =?utf-8?B?b0xpWGI1SVZpU2FRSDJJV3V4dXJudHdHUHlkRXZla2dYKytnK1hMMFFCbjUz?=
 =?utf-8?B?SzdRK0RHa2VDWm9VdFZsWHcxYytlQXpoYjQ0dmI5MmI2M0IvZTJFcFZYUTlQ?=
 =?utf-8?B?VFJSWGdzTm5vaFZBN2wrYjhXa2pxQjNTT3pmN1FmSjJRcmJHTEhWOEJjK1hj?=
 =?utf-8?B?aEJCMEtic0tDUVRObWJuektYeHR4WVFiTWR6WVovdW54ZkI3djNkZm1sQkZr?=
 =?utf-8?B?cjM4SEVFeFRuVmNOdUNYRElnMkQzWkMvQWxtN3hZcEZxaFFVb0x6L2tUS0sr?=
 =?utf-8?B?Rm9XcDJoanhXQ1pDZFBXMndhdnVVUlA4aEViczMxcFhaUVp0ZW95V1RuRWN2?=
 =?utf-8?B?Wk44VW1ueUhQVk1kWXNYcGNIb2U5b1p0ME9LeE81RGppVVBhZWlzU1hFQS9w?=
 =?utf-8?B?SlVZWk5NNUpxc3BYRGs3NlhYakxUano5ejI2d0U3YWxBSkNNM2czMThnQ1Bj?=
 =?utf-8?B?MEUyeEVIU1NDZ1Nkdk9BQUVCZldxSXdvbm1yUkZFUEFvRTNEUG9WOEk5WWla?=
 =?utf-8?B?aG5Ldm81cnZLc0Fwb3RQV0RoenJrQkFkSHRWckFZNlovbWlOUjZIc3FadXRY?=
 =?utf-8?B?VC9ncWpiVnZ4dSsyZ1hZRHpkY0xJMlJOSXVZSzNBWW4wVU9HcUJ0WmREQUFP?=
 =?utf-8?B?cW81K1dBUG1UYUZ4bHAvNm03cldWamlDcVdyT0QxL0FDc1dxNExlbEVSUDFB?=
 =?utf-8?B?SndEMDJaRiszcW50QldtQlpkV0M1eVkxTHhoZGx3eHBrMGQ0T3ZMR0hiQlpF?=
 =?utf-8?Q?0WSTZXSlPfih1Mbxcjl2nSGbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c107e990-7d0c-4f98-a548-08dd4a9fe6d6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:27:59.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9q1bbfZZPdHcEXm+4hFrtiXD6q3y72JYe2/0A76lGWjeoJTrQKSz77cSIWAyWO5YHa85xa0hi7GxEqKaZHcoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> EPP values are cached in the cpudata structure per CPU. This is needless
> though because they are also cached in the CPPC request variable.
> 
> Drop the separate cache for EPP values and always reference the CPPC
> request variable when needed.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 30 ++++++++++++++++--------------
>  drivers/cpufreq/amd-pstate.h |  1 -
>  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 697fa1b80cf24..38e5e925a7aed 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -268,8 +268,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  	}
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	if (epp != cpudata->epp_cached)
> -		WRITE_ONCE(cpudata->epp_cached, epp);
>  
>  	return 0;
>  }
> @@ -320,7 +318,6 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	}
>  
>  	/* update both so that msr_update_perf() can effectively check */
> -	WRITE_ONCE(cpudata->epp_cached, epp);
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	return ret;
> @@ -337,11 +334,14 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	u8 epp_cached;
>  	u64 value;
>  	int ret;
>  
>  	lockdep_assert_held(&cpudata->lock);
>  
> +	epp_cached = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
> +
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		union perf_cached perf = cpudata->perf;
>  
> @@ -352,10 +352,10 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
>  						    cpudata->cppc_req_cached),
>  					  policy->boost_enabled,
> -					  epp != cpudata->epp_cached);
> +					  epp != epp_cached);
>  	}
>  
> -	if (epp == cpudata->epp_cached)
> +	if (epp == epp_cached)
>  		return 0;
>  
>  	perf_ctrls.energy_perf = epp;
> @@ -364,7 +364,6 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  		pr_debug("failed to set energy perf value (%d)\n", ret);
>  		return ret;
>  	}
> -	WRITE_ONCE(cpudata->epp_cached, epp);
>  
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  	value &= ~AMD_CPPC_EPP_PERF_MASK;
> @@ -1218,9 +1217,11 @@ static ssize_t show_energy_performance_preference(
>  				struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 preference;
> +	u8 preference, epp;
> +
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
> -	switch (cpudata->epp_cached) {
> +	switch (epp) {
>  	case AMD_CPPC_EPP_PERFORMANCE:
>  		preference = EPP_INDEX_PERFORMANCE;
>  		break;
> @@ -1588,7 +1589,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
>  	else
> -		epp = READ_ONCE(cpudata->epp_cached);
> +		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
>  	perf = READ_ONCE(cpudata->perf);
>  
> @@ -1624,23 +1625,24 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	union perf_cached perf = cpudata->perf;
>  	int ret;
> +	u8 epp;
> +
> +	guard(mutex)(&cpudata->lock);
> +
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
>  	ret = amd_pstate_cppc_enable(policy);
>  	if (ret)
>  		return ret;
> -
> -	guard(mutex)(&cpudata->lock);
> -
> -	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> +	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, epp, false);
>  	if (ret)
>  		return ret;
>  
>  	cpudata->suspended = false;
>  
>  	return 0;
> -
>  }
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 16ce631a6c3d5..c95b4081a3ff6 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -100,7 +100,6 @@ struct amd_cpudata {
>  	struct cpufreq_policy *policy;
>  
>  	/* EPP feature related attributes*/
> -	u8	epp_cached;
>  	bool	suspended;
>  	u8	epp_default;
>  };


