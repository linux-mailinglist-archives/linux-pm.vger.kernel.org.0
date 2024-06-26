Return-Path: <linux-pm+bounces-10072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A88918EB2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F891F21275
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968EE19067B;
	Wed, 26 Jun 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PmDJeFtB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81318FC85;
	Wed, 26 Jun 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427259; cv=fail; b=SXedL76ciov7FfG1JNLXBZkNQ7H+m+H1s+eAXHK83ifB7/Zv7lH2C27qUXw5wmohMYqmupVth0eJzqGdSo3ZmE890p/UZxlKAePnqhMQZ6V4JL8YVZxTd7YgQQWvkkHhvtPDl1ceLLw1HSgIQJ2tqmAkt1BNSwKoTRrFxYRh19E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427259; c=relaxed/simple;
	bh=XY0FtRgEWN5Ims8YYlrz12xBzdH+8Dsf+Xiy3eAnp+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TgliBtdm9jb7rLmmXWSivyXAYyUgEu+7RjCS91N9Fiee5kTds0mZ6Cc5X8HhaFger5gSUM+P8tCAqf9fof4SrXHp/qFZXWkRfbXqz78KgIjZMfE8DKODAZPmyzipDyLbXH+xj6RjWGv0AgFKDDuko8j3zIh7Qb7Iy81A0MAr1js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PmDJeFtB; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcWk1OjgBIm9SPYGg8oWAG613GwZmRaraxdbvPquVqxNe1j0A89fdTVHwiNdtDB0lTRvvRPsRzBpoBqhdHTIPd4V44RLkbr/Xr3ymFAGfKnSAMNA0OaO8vxlrkb5b48cdGnYlPE9QO74BAaE1/V4SLhVeRMIhIG7gimQTPBYxLSmyW4GX5t5TPTU87pFfx58XTiY0qTE1Y48vWYHXAuNh0UHO/B0nYSVbKxwd/lEvi1RbQE/gQAgEw+z9F3/6LZhUmXodgjVxVI+/6tSBiD8uhcCdKXlLykTzmYU/vyYCI4K/8Qsf1JZwpOdR25f10WS9GA4Gg16NEanCY4X8v2SlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDAijn63/43fWU0S6wG9E+kfIVTdHWLked3XSj/CIgQ=;
 b=Q9uoxPXhGUaI33C2IIlYxP/Ofe8OCF9pwy5XXNL+SnFDdNkSQZyY3MbuYPi8p2/JsC8+z/3owm9UNUjb3oAsFs1c0or/G0N+VuWeK6hAO2tm1vw/vyUgsdZKlYOdrF2hXpyEolswnP1meYURy1nENtJMKdxKHoHznk9E709WCm+dOA7iuPj8eS8VstmUnEL1VYnNgr5CE97Dn08dE5Jh+Y68bfazgyh+84071lmEcXpSJAJv4laiUdT+LeCyaSW6heiFQcNGbDHz7Wu3dC3qvNMu7O/QDIPitYdlJ0Gmtd0Au9BKZGVcNJ3mpQlRRjLgVncftQkPjoF203tcTWkNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDAijn63/43fWU0S6wG9E+kfIVTdHWLked3XSj/CIgQ=;
 b=PmDJeFtBDkGYbuQIHShqX0VlSYWS8Ju+yKtpcR1qt0mO4N+a7OElQ1OvyiOuObSCdUFBhhetIZ9pvV5/9JSMEobKrlHk5w5VxZFNH2cOO3Fue5a2GJkmmdwoUzep3G2RyNRGTJ4330I1ggeOUlwtE41BY2b2p234Th/yD1Lg8pQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 18:40:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:40:55 +0000
Message-ID: <6c68f0f4-ebdd-4740-9930-99124c7a6ff5@amd.com>
Date: Wed, 26 Jun 2024 13:40:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: make cpufreq_boost_enabled return bool
To: Dhruva Gole <d-gole@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240626084354.1762483-1-d-gole@ti.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626084354.1762483-1-d-gole@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0012.namprd05.prod.outlook.com
 (2603:10b6:803:40::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0b27aa-c625-479e-482c-08dc960f837a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2NVK2MzRis4QWFXMFVGSlRBcUljc1BuNnhXZGh5MlRXZ01HUmVhS24vcG5l?=
 =?utf-8?B?aWhBMTM0LzhpT05idG9WRVZONmszQmR1R0lURFZqYjlVMHB1Z2Q1bVFYMkFz?=
 =?utf-8?B?RG1rL3VoUzRqd2lpK0FDZ3BkSXVEamVabzhEMnRoSVdiQWc5eDZrU2hVeEtN?=
 =?utf-8?B?blBHZEYxS3R5aVRQUlZjU202a0I4dzlHbEZ3OVhhVFB4YkJCcUl0MEM2cmw3?=
 =?utf-8?B?UDgzTXlVMWxrK3dZdUg2M2xIRHZENXFCczd3N2tEMEp3ZGVsei9JME5qSFpP?=
 =?utf-8?B?WC9PdlNJNEt0My9zLzZIbmc3eGYwN3dnTHhPSjVxakpmUkthaDl5a2djaWdL?=
 =?utf-8?B?NVlJVDhZZC9hYjZ2MTRvUlFNcjNEK1dXeld6QTEwVkRubEhGV3JHZHBqR29C?=
 =?utf-8?B?ZVhJVGlCSmFQVmF5QVJtbitsQm5iL1V1eVllMk5TV1ZBVE9vTXFrVXppeEM3?=
 =?utf-8?B?L2U4YnlaVGNVaDZvaTh3K25ORHdRajZjSVl3YlBGaHFoYlhFYTk2dXBqdDVx?=
 =?utf-8?B?ZGJYQmZNSDYrMlpKc3JHamNpVFdyYTJjcjR1ZFpleXJZcmRGcDhiMDdCS0VB?=
 =?utf-8?B?QTlpMHl5b0dlQkZ3aU9XNytYVE1ObU9McUFIRTB0cXd0bGxNdjBYT3p6RDBN?=
 =?utf-8?B?OHFHUzgrUWl0bFdJdXN0aHVPYUtPclE0Zm0xcnQzb3pmcTZNWFJWTGY0TjZ5?=
 =?utf-8?B?K3Y0TW4xNEMwUnUyak13Z1VwdU53UzZabm8vMmhWUFUzNE1jY2tWRmgrV3Ju?=
 =?utf-8?B?cFR3MnhuNzRZeU43amRjaWVCU2txZlZZM09pV2FrMTIwV2NPcGVBU1U1bHk4?=
 =?utf-8?B?WWJSRUlyZm5KTnRHc3ZnTHkrMXAvS0JYWWdTT2sxTHNCRkZKV0wwUHhkZGJH?=
 =?utf-8?B?Q3ZUWkpQUFZEeFY1RlRwdllHUkJyajBnK29DTFI5emNUSjQ5V1Rzb0tmeUl5?=
 =?utf-8?B?dmNQSFFkNlh6WktWUVY3cnhRRXM5RzNEdTZxc2g3eGtEK1hBOWpXbTlva0RG?=
 =?utf-8?B?b0YxWHF3YWN0T3dkaStXekMxMlhPL0pJcmFUd0pSNExWVCtzTk9NaW1UQ3dG?=
 =?utf-8?B?ck5GT016WHRJZ2l4UXhYRGtaQ3loRGE3ZUR1UGlGV1FBajdCQW05bFRUM2t3?=
 =?utf-8?B?WE9VZVVhVkwrdWV3ekZIYWNHMHlvMnd3K0M0WWpRalZVelZPTCtYaHhIa1BP?=
 =?utf-8?B?ODV2ZzhVUUJsUTROQVhvOHlrT1p5b1VzM1NaWGtLcG80eTNadmNxTGJvcHR2?=
 =?utf-8?B?RE5yWFhjRHVobmljWUx3V3RQZ08rMFIrUXc5ZkwvUnIxTEJRZ0wzK1VyVFRy?=
 =?utf-8?B?aXhQWjNWL0xEdmZQTkhWT3VGdGRwU1ZFOFc3Sm03ZlhHd1ZVMDdpVW9MZ2tV?=
 =?utf-8?B?TWViYVBHbk5wQjRoYWVzbnU2aUFEOW5VTmNyUUNLaTdwUk5QWnFjMGgyWER3?=
 =?utf-8?B?dHp1YWQ3QzJVK0U4TitlaEIwOEtXdHZtTGpnS0FyRkRpNEVOQUJXYlBMdW9M?=
 =?utf-8?B?VmIwK05STHFDalFJSmhrRlFaOGtqcGE4dlZTM0xUUlZvSFBNdW8rMHJqUFNz?=
 =?utf-8?B?am9OUkNUNXlmN3RXSG5WZDdVci9PTVExMDhTOStqZldXSFF1SHp6WHhra3Vy?=
 =?utf-8?B?REE2WkRKTi9XN3JXRU5qNTJKWmRzZlpHNEl2Y0JIdmN6NTFiZUZINW1ZNlN5?=
 =?utf-8?B?T2pjdk1DRzZWYWxEdjlZbGpiQkRvZlYwUGhqTG9uYmtHa1ZHQUhFQTdCNGRa?=
 =?utf-8?Q?1GXq5xhV9/hfIcemdPFykkd3LWPblaM1VYbmIbn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3F4ZmtDejExWEVGaGM2Ly80L3BBRXVtOHBmaWpDM01rM01YOEpKR0tOT253?=
 =?utf-8?B?WDZHQzdrZUhJN0Zoemk2a0tzYlJNc2pGbWxGV3o5MTk4SE9tQjFEZTVEMFFY?=
 =?utf-8?B?bjZPcExJTjZxY1hjRDRrcXoyMFV2R05WdnBDZjRpVDlTUG1VTTZwZEdTcHc3?=
 =?utf-8?B?eW56My85d2ZYYWtFam4yR2NkbGI4a3NoK1NsQmRGdXJqbHJCN20vRCtPSGJE?=
 =?utf-8?B?NzhtREU4cjdMejdxVmxTYVdRVVR5Z1FOR2pmbnRVSnBBdHh1TC9BSWQ0R0NT?=
 =?utf-8?B?cmUwcG92aWpOdWJDSEt0YmtNcEtHSThEK1d0UHdMSW4rY0lKeDJ1bVpBRDFT?=
 =?utf-8?B?dndIVTBVaUxNTXZvSTUwaWpQMlBYTHExYnlua0RpaHdoVlNEQkRlUGR3aUlU?=
 =?utf-8?B?Qk9GQUZZam9tUWtwSHRxTVNnajM3REY2U3ZRa1g0YlIyaWJZcmZEZi9PTm1C?=
 =?utf-8?B?Qnc5eFliZ3ltMTlHTWJQR3NaRFhoc0pKb01DZjdjcFlEMEQ2VW1LYitWenFR?=
 =?utf-8?B?bUtKdFdpT1c2RWJXWHl1M1JQaTNZMnNmMkFxeXJmSlp6Tkw3NnIrUnZyQ2Ns?=
 =?utf-8?B?RDllcGRnR2lwN0ZCTmFSbUtxS0NpOWhEUlQ4dG5kSGpTRnNGYXh4RWppcEZE?=
 =?utf-8?B?enB2MGtwenFZcGlvK25EVGh4ZXNYWTNBN2FoVXBvV1VGNlI0NGFJeGNxME9O?=
 =?utf-8?B?UFlwRDd2YVR0eWc5MFlFN2xxUGNhTGUrTW9GWjMwZ3lFL084dStYN0FVeXhl?=
 =?utf-8?B?cC9hQXBwZ2p3VFEvb2dBSzd1VGR5bjhXNzl0b3dpcW5YVG1lMDRyNnpHS3Mz?=
 =?utf-8?B?Snl4YXg5UUlDeXM1bU1kblpZczFqRUZWNENjdWtxRXlNa3J5N3oycFoxN3NK?=
 =?utf-8?B?QVV3aDVYK1dxRVFJdGdjTFd0RFgxRW9lektXbGN3eUkvbmlyb3VhdVlsV3ZW?=
 =?utf-8?B?a3NGYkM4S3QxVWY1ckhwaTN3MzI2TnJSbzNnb1JXLytVRUVJVWcwenIzTUdi?=
 =?utf-8?B?UXB3NnNtSytnZ01tcXh4VHA0STkzejdEeTZjQk53ckVYancxNmp2d3hra0RZ?=
 =?utf-8?B?VW9seEJkMFJndTdHZ3BaMkhSU1p1T2dxWHAxSnFpWHdkdzZPTjA3VkFLZGJC?=
 =?utf-8?B?WW9lTU5aZG5wWTduQlpMc0wwelk3NW5WQ0RnS1JEOXRDcHlhSDU3MHpjM3ps?=
 =?utf-8?B?U1h4S0NoWTlDWjdsY0ZnQnJrS0VEWDFwcVpUdFR3alBWZnJiNWoreWt3Q214?=
 =?utf-8?B?WEpVM0tRWTVkS20yL3E0aEFLKy9DUHNxNk5oVzFaYThFMnMrUFpzeTZ0Qm5o?=
 =?utf-8?B?d3dTUENHc0RjU0tFc1h1dS9SaWp3REN3aDN0ODlaVHpmZmQvekxlNE84LzJK?=
 =?utf-8?B?WEtOZHFHVUdLaEk4cXY5TDZxNHBuVVJ5MHc3OW81V0lKQWZEZzJ6bFNKWGp2?=
 =?utf-8?B?bXRINzdHdDRLcVBBRTAzaUk1Vmd5M1pyUVY0RnZGQU9TZDYvRmpqVk1UR0VP?=
 =?utf-8?B?ck5heitVVXRmaFJqM1lTNHo1SVZTeWJKT3VTL21HcHUwTkRFRzNHU1RFY2dW?=
 =?utf-8?B?dEhpQkU3cmNaOHovMm1sV2VwdlY5aE9jaU5SOFRsMFRXdUlIRDZQalQ0ZXdl?=
 =?utf-8?B?N3Vkcy9lTjBld2dBY2d1OVArVmRQcVI1dG1iNkZjQUJtN3RsdVNsYThSMEFz?=
 =?utf-8?B?ZDM5YlpTVnJvV2Vlakk0UVphejBlLzVpQ09RK01yalQ0WUI0VnQ2TmZTZzRn?=
 =?utf-8?B?M1B5MlZnb3Vvc0xQWVFESERZaW5UNUkyTmIydXZDK3pVSVZBMnJXcjhDVVFT?=
 =?utf-8?B?SkRuUmJyUW91N2haNXNLYUxhR2MwdUVZNGtFR0NhaEY2R1F4YlhscFlQN1Ba?=
 =?utf-8?B?MGx5dVNOVThuYmRiNzZjdmhpUXhxOFlrdTMrRzF4WUdMQlhvYnhvU1NETFBB?=
 =?utf-8?B?L0diemo5eUVUaVJxYm5BcjBSNFBEdTJzVmhSbDJkTzFHQmdIRzlKYWovb2N3?=
 =?utf-8?B?TlVmOFZYSkhxbkxKMWdzQjFPZVpxS040RUxJU1VzRHhnY0E3SUd0MGVQVFRN?=
 =?utf-8?B?aU82NU1FT053VUE5K0s4NXdlNlVqajZMczJJSnlJZjVacE1xZ3Y0WTVlWjNZ?=
 =?utf-8?Q?oJJRQ70tfxVSmO8yzrbMhal0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0b27aa-c625-479e-482c-08dc960f837a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:40:55.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY1zNrMSN+ZhTJy2NOqQsJHGfCV4CTihhV8WPmvbEoYH4h0ql4ZQJzysMatobPq5To9LXS70ARwaPr8E80anoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468

On 6/26/2024 03:43, Dhruva Gole wrote:
> Since this function is supposed to return boost_enabled which is anyway
> a bool type make sure that it's return value is also marked as bool.
> This helps maintain better consistency in data types being used.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> No functional changes, just noticed this as I was reviewing the patch,
> "cpufreq: Allow drivers to advertise boost enabled"
> 
>   drivers/cpufreq/cpufreq.c | 2 +-
>   include/linux/cpufreq.h   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e678ea7b0891..5704036f294a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2874,7 +2874,7 @@ int cpufreq_enable_boost_support(void)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
>   
> -int cpufreq_boost_enabled(void)
> +bool cpufreq_boost_enabled(void)
>   {
>   	return cpufreq_driver->boost_enabled;
>   }
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 20f7e98ee8af..523f81b7e2aa 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -785,7 +785,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
>   
>   #ifdef CONFIG_CPU_FREQ
>   int cpufreq_boost_trigger_state(int state);
> -int cpufreq_boost_enabled(void);
> +bool cpufreq_boost_enabled(void);
>   int cpufreq_enable_boost_support(void);
>   bool policy_has_boost_freq(struct cpufreq_policy *policy);
>   
> @@ -1164,7 +1164,7 @@ static inline int cpufreq_boost_trigger_state(int state)
>   {
>   	return 0;
>   }
> -static inline int cpufreq_boost_enabled(void)
> +static inline bool cpufreq_boost_enabled(void)
>   {
>   	return 0;

If making the change to the function, I think you may as well also 
change this to "false".

>   }
> 
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed


