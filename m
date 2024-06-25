Return-Path: <linux-pm+bounces-9961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE0916CAA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF57286656
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1D16F917;
	Tue, 25 Jun 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zo8hnAmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681716EBF5;
	Tue, 25 Jun 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328295; cv=fail; b=f/CmjR/Q6glFaDmP/KoeiNEkGrQ1z8QqXDUXj7S34OunvLx9xgZZQ9lyTKdSiVAgWh6aZroDUW1cjERStIuR0h9qJId6OyMwWdHhqRLxQE5Fe8Hy9eb92MrZjsl1jxaSgAjDc66DhH/38N3hPOMMFytd8Da1RMzLZ0HSveTxGjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328295; c=relaxed/simple;
	bh=3N/CZ9P/KJHOfLorP7ygaf1P6u+obUYQqEif3JAArII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3Vub/jqEOLYWd2Z54+nK6e7Ef6pEjeCoDHm1atA4d+Ye3ne1vYnPH+CkCa0jQCrdEPn6Hz4qQWJ08VDXUe8ZFIgROlC9Ha/qp9XY76sIhx/kvQhIf04wcyZWg9EcmiIl+BfvZqYbKCT21UEvIpKbcSts7Tqziix9pwMfrQgyQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zo8hnAmY; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5O23S45bGOlDDSuhyYm6qnE3fZei7ugiq9RlSFACKd13JibbI4VWQ4X5z8vHgV9yEg0uI+Yen8wN75P7nVY5YxYF4SdtWr06KfagGzU5Wp6e5HEjqPfsFjR+xWaZqWxKlcsRb0itMtuKusuzbiJFENiUpMSV9bDyLE5wuYNhmKyq92v6XACFdQkB1DYRUrxFvnO+iq+3WcZrfEDLX0HwwIwgo4UZ2UvT2psBc1YRTjHWBRCk1vEkL2EovZfenhpGvku/GYMSkTPHORpaPcSxwnwBBlRlfDVW1TP8Uav7CMAegJnVdLImebG176M9W3B+yuTKNfmmo62FBvtRlqZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/2GMKw36jN0r4dLuZtJAteF/2SDKvfMTwAT0y289/8=;
 b=P+VMOLmw9i7IZaPZ7tK+tb9sTEV9thUxURjgPUtXbR2npnEVdS9kE+OmabkIn55IBSU+gpWRfgGx7Xrq801XTE6XrfNJ+eA8b3MkywLtKQdRsrxUbfZytsW1CpM/xzpX6N9s2yUOGzWNAqMLq93imZGyh/Px1bCk4UlQ9P/GmN2URxZ0GXPOK/adlHlqIE+SgopVK6+jNZpPn/o0FQ6qUIINCvMGjFXfkBbdk2otSMyI9jizkkGsfCzcPOA0h/HxVQ6nF/Pwsi5kDKpKPcZsMAg5QHjNnB1CkotOLlohQSKAEQUE2p/PRbA63glZOPdI+tQp2dJKmsePCysJgO0rCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/2GMKw36jN0r4dLuZtJAteF/2SDKvfMTwAT0y289/8=;
 b=Zo8hnAmY3WGHygSWmqVxeb8vEzaeVfYV3hlzRdUkWDFqHudp3LFgWik3vUAsMKMdYYl2Svg2gBN10PbYm/O+QD6iQmZ+r4HpJlN/b6uWsZ4xHT3haJrcohD9BkYdFN3ersnF9iixbC25/8QZuotjIPSwJNQRh9pGmQs+fUuw2Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 15:11:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:11:31 +0000
Message-ID: <e9811d4e-60bb-49ea-80da-5d4597ef8705@amd.com>
Date: Tue, 25 Jun 2024 10:11:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 perry.yuan@amd.com, skhan@linuxfoundation.org, li.meng@amd.com,
 ray.huang@amd.com
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
 <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:806:125::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 432537eb-03ec-4773-c7d3-08dc9529186e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEx0UklrWG01SnpuV2dzZktid1hSQ0E1NDdFR2dIWm5RVStnTnhjOHcvVHhK?=
 =?utf-8?B?eFEybzRBc0FmSWFlVWlaV2RVUW9WMEYwdDhKOE9TVGZjTEJDK1VML3A1YjBn?=
 =?utf-8?B?V1JyMTBQVGxHR2xvWWNwSDdZTEVRYlo4VFdUZVgyRjNSb2haOVFoMExhWFNE?=
 =?utf-8?B?RDFPZ2lWUWVUVTNlZTZaVWduN013N0NSeWpwaDlNUW55c3l1NDJ5RXU1ZE1a?=
 =?utf-8?B?bUd1M2F5d0c1Q0haVVdZVVZiWTJDdWY4WXNiZ2FydkxBMHU2dGM4NitmU2wr?=
 =?utf-8?B?dHNMWjdDRTMvb0toTFZxUXRkMG5INFlMRzRTTFhnT2kwM215dXRtSXY3Qnhj?=
 =?utf-8?B?MkhtaHZRUVpQYStudWZSV0pzSm10b3ZHZmMwWUV3aUppQU1TcUx2bzNSMm9I?=
 =?utf-8?B?aUhyYVBMc3g4QUJnM3ZGYlc5RjdPRmRBUTFVUnEwbXBZODBrbkYvZlVodHNz?=
 =?utf-8?B?RGpRUVhTRUxac0ZMQ1I5VHFEVUVCK0FqUllESFh0cTN0WFplQWJTVWlpVTBB?=
 =?utf-8?B?ZW92Rjg4Q3VrdEYyY0NQakl6Y2d0ZDVUUUp5a3czWEFQQ1duMnBhUVZHUTdl?=
 =?utf-8?B?QlYwUnVDVWcvbnQxZWF4L3V6cEZjaVAxN3ZJZ1ZMZGIzNUJzL2R2TEl3b283?=
 =?utf-8?B?a3lHWDhxZWh0K2x5SHV3OTFKdXNRekpNSUNTVGl4MGx2NWlJK014Y0JwekZ4?=
 =?utf-8?B?U3YxTG5WaDAxQUYwVi95eE5lUWpjU3J3a0VNR3Z4bHRzZ29HZlp5bWhpR2Rw?=
 =?utf-8?B?VG1YVDRLK0xlUTdWcUcyYXRRdmZnZFpQRERieWFXbk5CdnVkMUxRM3RpWDNT?=
 =?utf-8?B?eTF6YlJrRUJ1dVlyUnVLL01OUEFpa3pCUDRzUlVvRldHMWgvdldsZEZkY2RX?=
 =?utf-8?B?cXFZMVA3Qk5IdnJxSFIxTlROc1dFTEMrM3lqUmZzSU91bkw3bEdPYXB0U3M5?=
 =?utf-8?B?eDU4QjlkUVgvUTJYWEV1QW9wb1FtejNRa25NMHJrMzh5Y3NxMk5YbC9PQVNt?=
 =?utf-8?B?SXdYQS9DS2RWSFVsUEFyTWoxdWl6dVZjTWZZZmtKbEJ2QmR6WlFoUDhEd01Z?=
 =?utf-8?B?dnd5SFdqczVYUi96ZGtldU5Zb0d5MGt1MTBHWHNmcXlMaW5jWGxURjByUGVw?=
 =?utf-8?B?a1dVWHRaL1ozQ2RYRkRnUlI4dGNzSU1UL2srbmoyR0JycnR6Tkx5a2FQUkxQ?=
 =?utf-8?B?WHVSd1FMRVFkdVFnVk5ub2ZLam8xYVBqREswYTdyeHZxd2t2cy80Rkl6ZUg1?=
 =?utf-8?B?NkVWWG9wMGVZcFlYWXlMUlE3WW0vVDZwSnNVaFJHNFFLRm1HTlNGYWdlQ0ZO?=
 =?utf-8?B?cGtOK3p6dTVhcXgwSmQ2dFBLdmNVNzZJYS9ZYzVPYXduZGhadG1SK2lRNmtN?=
 =?utf-8?B?bjBQOXhTeDBwd3IxZHhkYkdqU3BacHdXUzMrUkJWUGlwaGRLanQ2bkMrY256?=
 =?utf-8?B?RS8xdmd5OHlOdTBCb1Y0MkZMQi9HdURpTDN4RGVCVDRwNHQ3ZkRjeTJad1BO?=
 =?utf-8?B?SUU5ZWlWTUpkd0Y3cnA5UzgzWXBvTjFmL0Z6WHRQZWJSc3ZrZ3NXTy90RGl2?=
 =?utf-8?B?em9HMzJjMk4wS3FDQ3J3WTc4bEtpY29DZ2YwMXErMUFYQTJnbkVsMlVMRk5j?=
 =?utf-8?B?eSt3WjBCWkFRZ0JSdmVkdkpjM2QvUWpvRU5lblhJSnZ3MU0yZTVDNjNDMStM?=
 =?utf-8?B?d2xNemVKM0FRa0xlTUpqR2ZrZU5wbDZxQWIwV21nYUpFSnNlVGJYVURiKzZP?=
 =?utf-8?Q?N873Q8GpnGoA4WzKRfoy0jVVm+bfYJXbyjBNi1m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUVFbnEyc0tHK1poem1uUjlzblRHQXluMGxMZjJLT2V0eUswQURVQzlyYUYz?=
 =?utf-8?B?VVRnRExPY01wbUpUMkhEclBiellockFIR1Faa0s1SU9YbnlSZEFhMGhTT0Z2?=
 =?utf-8?B?cmo2VnpSYU1oTXJoeGt3R0NaR0tTbEFPeW91ZkI4dFk5K09sSDlaUFJtNVEr?=
 =?utf-8?B?OXJudTh3d3hEemhEUlp2VGxSZEpBanZCWkhteWxWS21TUkZPckxIdFcrdVp5?=
 =?utf-8?B?Z1NPWmRKVURnUTAzWVpCNkdDZTBjTGZ5ckhrYVB6ZGNzVStmWGxDT2h0THlN?=
 =?utf-8?B?MjFlUzBJbkc1bmlFZUFsU1NtVHJXSW4xRjlOMHZzSTUzazVjSlBIbUJCSXNP?=
 =?utf-8?B?bTE5ai9UNDRPQTBCMDYzM2dIZEZpZmlucE5PRlNzMjB1c2t3N2c4UkJlVk80?=
 =?utf-8?B?b0g4UlByc1RMMTZsMDhtUmVIalRaYml4VHRPcDNWRlZXSWsxcmpJc0NvZUpC?=
 =?utf-8?B?eDl1YWFOeFprblpFUnl6c1RJdEpTUXNEOTNNVUh5VkZmY1gwZlhCRjZCY3FQ?=
 =?utf-8?B?cmx3SWRRMERxcmtjZlhpVzV4R1d2OG9kT3d0NzlkbHcxVHQrTk96WXR0Vzdw?=
 =?utf-8?B?bkFLTHduL1ROTjkvRzZQVzBQVWp6UVp4UitRc2p1bWxUUi96Y3NzcEgvSFJV?=
 =?utf-8?B?OHUwVkNOMS9oODlQVDBpTjVZd2trU0Z0a3E3NHJoVlI3MENYWFk5SWdqckds?=
 =?utf-8?B?QUwwN1Jzekx1dDlNTFhodVVnby9SS3A0eUswWjlaZDcvQzdieHJOUFpRbHBk?=
 =?utf-8?B?cGRtTjdaK1VxRmg3RVBOVFE1UXMzWUwvZ0RpOUZ0bFU0cnpSVlVCbUpyTmc1?=
 =?utf-8?B?ZGdmV0w4RXU5VVN2Qlg0TUpwTkxpMFhyT0NvUGxQRy9FK0lNMVZkZm8ySXB6?=
 =?utf-8?B?QjZiUWM5NGNuSlZvSDMwclc2UWlQSzJHS0I3bTZjWU9FY0d2ZU9QNnBaTUN1?=
 =?utf-8?B?UWkxcXFpTjFUTEZoTTFuTkJhZFhkb0RkeUZoazZpdlB1V0FMNHJVYlorajIz?=
 =?utf-8?B?YUdjcHVQdEx2LzA5ZDZDdUtENVhQdnFNZThhSXVWYlpYL3lKLzA4akpmY09l?=
 =?utf-8?B?Y21PZHpPWmhaMi9tTThUTm41bUw5ZU5YamlSQTBkYjZJdStCTzl6eTRQcFRq?=
 =?utf-8?B?MG5aZVR4L1pxNEtDVmxlaWs1SURHNmZxTlJGaFRwMlF4Ukg4alU2S1Q1enZa?=
 =?utf-8?B?WVFtM1ZITGJMSW9xdFkwZ0dWdUl2bFNqRmdPdTZxUUNBN0VXOE5hNW51V2dJ?=
 =?utf-8?B?ZW1MVXRZcHdESXNrZnlrdzVuVC9FMFRkNmZ1TS9QK0NjbzliT1VMenhLelk0?=
 =?utf-8?B?OE1jUkZoR2ltM0w5MTdhWkx1UGV6eTFaQWp0WXlFTFNmcGwvUzF3UHNuZjZF?=
 =?utf-8?B?TXdHeHh4dFpDUWxhN2thQ21LT1pQMTZIdG9jZEVKTXhVb0xrdW1lZWRxK2lv?=
 =?utf-8?B?ZGNNOUJteFpjMXlnVVhscVBDdXFLWG50Zmp1WFZqWHJYNTB3akFlMHZhRFdm?=
 =?utf-8?B?Q3RFVTkvQ29ISnlsT1N6OGZLdXpwR2hhRWw2ZEFueURkQW0vRTBFWnpCZlRy?=
 =?utf-8?B?RndvYTBZRGtoVTlITW91VktacFFhcmtUbk1NekNTWjhPNW5CSWQxWEdIK3Ew?=
 =?utf-8?B?S0g4eWxwR1V4Sm1ZVW5jK3BxeWpXbWlxYzlsQnlsaXljSU02aGh2QTE3aEhI?=
 =?utf-8?B?Um8vb3JhMkMyS2x1NVdYQUZuLzR2V2RPNjZnRUMyUFpYQUZBdDRzUG1xOEVK?=
 =?utf-8?B?dWo3eHhRbmFyaEZmY3Z6eEw0L1pZS1B4KzJ5OWVLWlN1V1Rhdm9DcXRjZWh5?=
 =?utf-8?B?b0FXQnJaUzZtWVhRN0p0VmhwV2k0RWowMDh1MUYycVhSOElFQldUT05wb2hZ?=
 =?utf-8?B?WlVwK256azJLbVNWRG9sTk1JaHVEU0d2Y21oU2Jvdy9yaTExT2gzcVhLd0xL?=
 =?utf-8?B?QUVaVWhIZ09WamJxekpkUUF6YzhTVVhoL052WS8vRFRKY1MvblJiM3hYQlVU?=
 =?utf-8?B?WnNzMXdzdUtONFVIQVpHS29ieTErcEZPcWdtdFFIMW9QN3dqZXlCaStnOTR4?=
 =?utf-8?B?S2RWUGN6MU5BZmhlWlFGWHdTcXREY2tMQXhQanFqdmp4QUQ1Q1dONW90RWFE?=
 =?utf-8?Q?8/oXR3sFoIjVNDQOmcKuUg6XM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432537eb-03ec-4773-c7d3-08dc9529186e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:11:31.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogUE2URuYWEDCGI3JzAHD/wRM+hIuyC3rkemT2oxjkcIFE33oVMZCHEltaLwYlPDbMzZl/c07iUF16WVl3ZnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

On 6/25/2024 08:51, Dhananjay Ugwekar wrote:
> Minor modification, the commit subject is supposed to be
> "cpufreq/amd-pstate-ut: Handle the inconsistency between nominal_freq and other *_freq units"
> 
> The second half disappeared due to the word wrapping I guess.

I had some other feedback on the series, so when you submit a v2 can you 
try to fix the title on the first patch?

> 
> Regards,
> Dhananjay
> 
> On 6/25/2024 7:11 PM, Dhananjay Ugwekar wrote:
>> cpudata->nominal_freq being in MHz whereas other frequencies being in
>> KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>>
>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index fc275d41d51e..66b73c308ce6 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -202,6 +202,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>>   	int cpu = 0;
>>   	struct cpufreq_policy *policy = NULL;
>>   	struct amd_cpudata *cpudata = NULL;
>> +	u32 nominal_freq_khz;
>>   
>>   	for_each_possible_cpu(cpu) {
>>   		policy = cpufreq_cpu_get(cpu);
>> @@ -209,13 +210,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>>   			break;
>>   		cpudata = policy->driver_data;
>>   
>> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
>> -			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>> +		nominal_freq_khz = cpudata->nominal_freq*1000;
>> +		if (!((cpudata->max_freq >= nominal_freq_khz) &&
>> +			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>>   			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>>   			(cpudata->min_freq > 0))) {
>>   			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>   			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
>> +				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
>>   				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>>   			goto skip_test;
>>   		}
>> @@ -229,13 +231,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>>   
>>   		if (cpudata->boost_supported) {
>>   			if ((policy->max == cpudata->max_freq) ||
>> -					(policy->max == cpudata->nominal_freq))
>> +					(policy->max == nominal_freq_khz))
>>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>>   			else {
>>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>   				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>>   					__func__, cpu, policy->max, cpudata->max_freq,
>> -					cpudata->nominal_freq);
>> +					nominal_freq_khz);
>>   				goto skip_test;
>>   			}
>>   		} else {


