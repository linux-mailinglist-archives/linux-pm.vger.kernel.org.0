Return-Path: <linux-pm+bounces-34870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6CB7F7CE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED8F3BEAAA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4072248AF;
	Wed, 17 Sep 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pwiap1Oy"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D7155C97;
	Wed, 17 Sep 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116402; cv=fail; b=UpatnpMyEhcy75Y5jWT7LFvMFt/uiS6VqmCJFQaQyJffFYwhGLPdE0ebrHMD4FXWcdvu4peBeAz5IpwiOrC87ZeUk4XMXsKM+1rjPPBj4ZKfEj6d+/cY3jhqlILTXR3O37JRhvKnoCkqe7X+Q9nUFMYahmmfhR4xYrvhNcw/rvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116402; c=relaxed/simple;
	bh=Gm5XfPLAMpH1ugRSQcmWjGR1ZwkPtNezBBLFw3xJij8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evmTR09K6B5oduGv2Y1QJi20egOvHIQmiMZ5rrxIMq6yXsi/ZzN6OrDBAaiip4YoFoJ7SAuPnaRK7pOQxvXmdNaAVuGED+NtHSJlHZ7UkGNm9/U1YE1hXnRwsH1Wy/W1Yo4muvu7tC6oWGxfurrwvtC2iyAi+Hn3bVfbIuOZcOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pwiap1Oy; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8qy655YLBX61trZG1hJMmhUjTnoeZ4+sxmNPDJkXC07L0wDmoguYFSdHJuN826kn0m64cavB0y6oCnKmoMRE1GkwAXHPsbp8HdZh3MAEhxo/5aBty8PfDEjk5XZyGw7npS29eEQXlxLhsBHF+AauFapVxbLRD8iq6RZqi9qhBJ4/7a5hTv9ZqXYnSR9VpKv9DXkKAoyaIqDP/U6l0Gl1Wj1G3aTZorEBWKHP+HvOFSPMB8LEXGOhrZwx3NfLgR+ukB7TiP5Me85pqRpZF9bIt6WxzV6R76yzY0Nt2fCoz8L+8j2kJ6fLJ4yXNOfkRest9sSGXAJPCQT01k14iH5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjjpDgFP0SKYaokkZXiU2tJ2hc/1TvR4ZmtyfJT99TA=;
 b=JWnWOYgqdTxRjOVi/vdeMWVl8LitNMC4frpZ780FEky+y7pBzkrDRyVBM8mOiyV4KWTeA8Ai5NRpDYpBpcp/6yC2hRZVoa+CxzMZzp6bXazqlJY3u4jBrBPeewMIJ1YcOIjGoknO/0bqyAxb5rskWikZslf7NX2gdqyfEfwu6rVqvyXFZ50ZuISQ7X84w0D2awwMe407fxrY9RcNfCPqLP1lGvuk1iK7+x7m90k6zNyZ+kV1eZqpqY4oAo9WIZoCq10Dl28/P/rASkJHb//rx4REnwvGYkfzfqI7Q8CVTYsNZXxG1cGgW+YC2WqBCKO9kg+t5/0NtLJA+3QUIBoYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjjpDgFP0SKYaokkZXiU2tJ2hc/1TvR4ZmtyfJT99TA=;
 b=pwiap1Oyw9lD/AKPBZ1vooCIAIY+rEtHhueXpIw79qY9nHCRVTKpw9PhSBe8JO4YrlXmC1gD7mOeQmCpWI/vm4+AwOamqVjc/V2fjSiwyFcbcBmWczFfbW+cWOoiy5bhDpwadLL/xDBXBS2jdWvtTOqez9BcC1Uea5FgBm0V5rdlKt6nChdjPp7cw4oEYUz/qvBt4A18q8dh5XC3dgn0vnSoKn7e2nhshfseKnir0lyItqP4Wps7lQbnxRhqec8Dh/rUcjbzuvat9flaaZ4CBz+9JiXUetrSz0qNsjzTEklI2ggMoY3yHz43n2NoPyhyMdktqsJT8Afwdk40hCyFhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:39:58 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 13:39:58 +0000
Message-ID: <074aaf93-b402-4228-a843-227a6323bffc@nvidia.com>
Date: Wed, 17 Sep 2025 14:39:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devreq: move governor.h to a public header location
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Robie Basak <robibasa@qti.qualcomm.com>
References: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acd8c25-8ab3-4dea-cce3-08ddf5efb17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDZVRnY4b3R5bS9zTElkSDdES3ZWV0pob1R5MHAyeFphZnNIRmFYQzh0UFZ1?=
 =?utf-8?B?Z2RKVHdWeXhaLzlMM2ZlVFBUMXJlL1RzdlhxcDZmd0NsVmV0VldyS2hBQ3Vl?=
 =?utf-8?B?OEIyT0FUVWdGZjVlTTN3QWl5Zm1Mam03QVdGN3V3TCs4SEdUMGdWb0pjdFZY?=
 =?utf-8?B?SHBaZXhRbkhNNCtla0RwTlF0VEQySHlOdkJvUHJ4dXZQTnpaU1cvdEdBeDFk?=
 =?utf-8?B?WFpRZmtYZnpacjlYamZLOTVvWldiKzBZMVA2SW9CRUxVZFhzTmF4cC94bExZ?=
 =?utf-8?B?TE92TWJwZDVtZ2VMeEJvckxqQkpaMEpCNm1UYy8vSmhDVDBwcVhVUWlFaFRJ?=
 =?utf-8?B?L1RzeHFZajJNTHlFa001cWVTRHhldWR1OXdRLzFXS1RycGIvUC81YkhnOTkw?=
 =?utf-8?B?Sm5ZZkkrOW1NZjZCU0xmSG1Kb0ZkWE9aN3VrWStkYU9sVjZINmJwWFJzRW5a?=
 =?utf-8?B?a3dqTmZqUWFCeXY1UWF1MHlXM0Vma3NrTTAxN1cxR0JQQUxraHJtSDhvYzha?=
 =?utf-8?B?Yk1JQyttejBKaGxQMy9iaVMwZmo1bmg1Q21DYWpwV21ob01XSTJpSDRPQmM4?=
 =?utf-8?B?RXVFaGI5d29hbklEUkxJZDc0Ymc2cGpQU0VtMGQ5cHRZRlByMjRQbWlzS3dZ?=
 =?utf-8?B?MGlkSlliUmU3NCsrYlNZWkIxVWRNbStKenkvQngzb0RvV3lUR3ZrMEJjWWd4?=
 =?utf-8?B?ZlN0MFZKRkFGeC8rRzNVTmdNQ0I3NGVrZUZsK0NjeUZaTU9TLy80SHE3WG9y?=
 =?utf-8?B?aGZsT1UzR2R3d1NMeVRvVlBBRlI3QnF4cnB6Mm90bFk0N3ZQUXVxVHFIdFhZ?=
 =?utf-8?B?NnNoTGJsT2s1RFU0c2xrRTdUSVgwdHl0T0xaTkRaZDZmWjh0TlBoajdhbVJK?=
 =?utf-8?B?SWlyYjhTNDE1dDZUVW1hZ2QycEtpNjZiN1FtelZHdkJXUXZld2lLeXVwTWcy?=
 =?utf-8?B?aGYrOVRpS1Q1MlhudFEvYXpPK2EvNDFYMWREM0s2YVQ3RGJkYTFEQmNNbHZn?=
 =?utf-8?B?eGQvUjltcTdZenl2VDM3eTZ5SnBScXV6ajdETzhrYmhTdGhodzVsRXI2cFVW?=
 =?utf-8?B?WU1XaFA4blRkcDVHY0x6eW9Ya2hDbkJUS1B0Nm5UZzBtS2ZEVVJGYjlXWVI5?=
 =?utf-8?B?T3ZkT244ci9YQ3l3U1B1Y0p3ZGhuMTRDdzJRV3NCL3pYNWxmTUZjbHlZR0JB?=
 =?utf-8?B?VU9hcDhlcmh2VE1vd1RldmRQK2dkSis1TE5QdFpVaExJZk55cHVIZ01mOFNL?=
 =?utf-8?B?SHdwWlJXcEJHTklLME5iSkJXbzl6MVR5Lzl3Z3UzUXRIUktNdGFUU1VnNG5P?=
 =?utf-8?B?NUtUMTIxOE1oN01jZmZWbUYyRmlTYURjRjY1WGZ6aytNV0pmckZSM01kbkRJ?=
 =?utf-8?B?YmZYOXFLK2Z0ZjhDZEs3d3JvTk5TMlUrMHI3aEJuRDZSWDJUbmI5dWhsZnEy?=
 =?utf-8?B?L3lMczhlQTRkSUpFUDA0THhKK3NtZ3VCc0dYZmhHYVMwN0JaaHdKM0E5dVI1?=
 =?utf-8?B?VUwyR1BJa0o5N0lpcGZXRnN3WXcxU0h2SU8xaE5GY3RiVWxOM20zVjRMTGhF?=
 =?utf-8?B?Z0hvYkIxOWFUNFMrZ1dSK3hPQkR2TWZFd0FEZ3BCRDN0YVNUV1laejdKU1R0?=
 =?utf-8?B?VG9BcUZQRHpNRlhkOEhUUkVEdXBJaC9UOHlMSlp5UE5aV0tYUXRTaHNlZVQ0?=
 =?utf-8?B?Vkh5Mmlldys1NTZiM1pjR0xQZGpqc1JLMjl1VEgxbTNuZks3dlg1eXZtZENk?=
 =?utf-8?B?a09Ia0pWT0tPVkFlWHdYeUxDelNaYjVjYUVFbXdoeHF6a1FkcmZuM3o5aFJo?=
 =?utf-8?B?WEMwN0IxcmNMRlp0OTFPWDB0V3ZxeHZncjVydmkvWDMwaWFad20xQnhjOUlj?=
 =?utf-8?B?S3dlVG4yTlpadktyazFud2dLTHJlcWYrWExibmtkTDNOMTZNMzFBcytLUUJO?=
 =?utf-8?Q?bbiRKxcrbEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjcvKyt1OUpmSEdpaC9GNWtTVU5rdFdHYWNqWU5uOVRzUkZJckE1c0JMaVRU?=
 =?utf-8?B?SW5YS1JYckZNUnhuSk04dXp0U0NOaGlyaWwrTk9XamdEcWlCcmZJd1c1Y200?=
 =?utf-8?B?WnlDZG84ei9GeXpZTmdydFo5Mzc2QUJtNHMwWFFDRkZIZWIxU3hRaEhOVEl2?=
 =?utf-8?B?T1RMR05GNUVSVEVpV3NKUTNkWnRsbjhCZkxVRkQ5cnJpMENNWks0TWRMRlpF?=
 =?utf-8?B?VnBjSExNL1lIYUxTT0tkTTIwc1EvT0U3NWFhYVZjbnFiSERwZW02R3BkV1ZL?=
 =?utf-8?B?ZGE5bjA3VGthWStrZDNUcW5Ia21pdmRFWjJNV1ZrK3hYTzhSd1VhdEQ1Z3l5?=
 =?utf-8?B?OVNjSlpUYjdhT3R4TnBWZVhxeldSK2o2dFpXaUQxVk5ONWF0U28rVEVEZW5W?=
 =?utf-8?B?MmJJMWpZVmFvUlpHa2RPa2NWUG1DV29vR2Rna0QreWpQNG9FUEd6Y2FwazZM?=
 =?utf-8?B?N1pOOVRDUGJ2eVhPVWVBNVl1TUpreVZ3QjZmenRUOUVsMUI2UXdKMW5kNEFM?=
 =?utf-8?B?b3c5MFhyNE9iT29sa0Z6WmxnMjJ1V3RYYkF6UlcxZEFQY3I3NnU1UVJheGNT?=
 =?utf-8?B?V0JwbTVuckR5aVdBN3cvc00yMnlGNUV0K1NNTVVpMlVNQUVVd28wNjZ5RmdI?=
 =?utf-8?B?My9sRzhwbWxpZ2hBUVlXTlRqUGtZK3ZYU1laSVQ1YVZ1RHl2cHdmbkUyTG9o?=
 =?utf-8?B?Y2J5ZVdad29MRmk5V0VKSThTTkJuaThGR1JyaE1Zc2JLSzBVLy82K2R2TWZN?=
 =?utf-8?B?WDdrallnZGNpVHFFTUliMjU0bmw4N2tIaUVyOXJoRUFRR3g4ZnhGeDAyL0Zw?=
 =?utf-8?B?TTRSL3lhRDVPZzE4Tk9iK3Yzb1ozangyUGZRY2lpTkJTMGUvdlI3M3FmOEZq?=
 =?utf-8?B?aHNtWUVZWEVSUUdJM3JZd1hTSEkyWDBZdm5WbzU3VENNZjhIa3ZyOTZvc09l?=
 =?utf-8?B?WnJDb3hBTnpqdm9mQlBwT1JPZ25wK3ZZcWNPRzRPMmRnVEpmM2VJbDY5Qk5P?=
 =?utf-8?B?enZBWGpnMjFHL21TM2cySThRMXc4a0VMeEl2UVA4MEJmeXM2OWc0TkNGK0Z0?=
 =?utf-8?B?ZnR5cTQwSGpXYUFybExXRWZHQkh5aXcvYUhWYmRHdjZhRkFpamVGbUs2Q3ZD?=
 =?utf-8?B?VVFKZW5ncXM3WmlWa2lqallKNnZlNVBtRy91UjRaQTdldjhJU3VsR2VYVWFG?=
 =?utf-8?B?eVZvM1JMMDVjalAwM1ljMDNCaDA0TExhQm4xZEliaWhNTFk1WTZ0R2x3KzYx?=
 =?utf-8?B?WlIvQWNUTmZyaHQ2dFZKNTM3UHpFZmw3OG5yQmo3RzhOWGJlNFZQR1Y2VVZJ?=
 =?utf-8?B?cE1rTy9BVVBCbTV1NVVtTk4vcis4QVViMm5PZWVBRFpQRzlvVjVORUtGN1Uy?=
 =?utf-8?B?Q0ZNNnF5d1VsUlhBMm9MRmlFbldZV00wMzNHQXl0QlJ4R0RCQVBWdSs1bjAx?=
 =?utf-8?B?UmpQUXBVbkR2WmhiOWVHY3ZLeFpFWWE3OWFUMFJRK0o0Zm00dlNxajY5Z0dE?=
 =?utf-8?B?S2pNODFPYjRFcmMwZGI0K1p0d1BVcUZFdE4rQTlmR1JRNWFwV1dRWE0zM29n?=
 =?utf-8?B?bEk5dzl2K1FLcDRSbzY5N3o1WXJ5QmtjWjJtQjBqYXJoNnI0TVhsUTFtVC9C?=
 =?utf-8?B?ZUFuSitVUzZpMzBVV0Vwemh3V093dDdNcVlqajdLbWx0WG16N1hOdUh0Mk9D?=
 =?utf-8?B?bjZxa1ZVV1pOTWRzaSt0Yll4RXJHNGhjODhYZzlZalRHdFduL09BcEdPQjZ3?=
 =?utf-8?B?ZXh1MU9BNUpiN1dhVXhDc1JtWUFPYkxWcGxCbGpkVHhwTEpzWnJVbjgwZk9N?=
 =?utf-8?B?NFJuT0JBTnh5amtBYnM1aGp5emlmbzdvaU9FT2xsKzl5UXh1Z0J1WWZKNmJa?=
 =?utf-8?B?YTNOaG44RnpKQ3ZjVHpVRkZUZW5pNXFGdEhTdElkcWVBcSt4U2U1VHBHSlpV?=
 =?utf-8?B?eC9xWkV4RW5HY0JSSzFlblVHMyt5alhrSHIrYXNjWVplQTNlRUlGZyt1T3Qz?=
 =?utf-8?B?RlVZQzdxZnVhYkNuUkZiZm9zNGZPUjdRWnFBakI1aTRJWkIvK3A4YnNoTmJ1?=
 =?utf-8?B?dXp3MzhrTXlxMkxRODl4c25Fam40a3BtaWxyYlFFekpEVXJFSXVsWEhhSmdt?=
 =?utf-8?B?SnJLZU5CZU11VFRGaU1XblBRS3M3UnZ3aTJQQlNSNnhEcDM0VWRqSnA0U0F1?=
 =?utf-8?Q?wz9cgGje59JWBOVPB+bsvpT+mnhgxDDuxIaEse9HRBYA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acd8c25-8ab3-4dea-cce3-08ddf5efb17f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:39:58.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6sW3JA1/9UuCZh5P/LalgRS/eVmqNsLEH26ULiWh+VfFbMNgoQj/dkkYp0w1+YcOF5E8zsAA/VYVddapM5MLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193


On 03/09/2025 14:43, Dmitry Baryshkov wrote:
> Some device drivers (and out-of-tree modules) might want to define
> device-specific device governors. Rather than restricting all of them to
> be a part of drivers/devfreq/ (which is not possible for out-of-tree
> drivers anyway) move governor.h to include/linux/devfreq-governor.h and
> update all drivers to use it.
> 
> The devfreq_cpu_data is only used internally, by the passive governor,
> so it is moved to the driver source rather than being a part of the
> public interface.
> 
> Reported-by: Robie Basak <robibasa@qti.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/devfreq/devfreq.c                          |  2 +-
>   drivers/devfreq/governor_passive.c                 | 27 +++++++++++++++++-
>   drivers/devfreq/governor_performance.c             |  2 +-
>   drivers/devfreq/governor_powersave.c               |  2 +-
>   drivers/devfreq/governor_simpleondemand.c          |  2 +-
>   drivers/devfreq/governor_userspace.c               |  2 +-
>   drivers/devfreq/hisi_uncore_freq.c                 |  3 +-
>   drivers/devfreq/tegra30-devfreq.c                  |  3 +-
>   .../governor.h => include/linux/devfreq-governor.h | 33 +++-------------------
>   9 files changed, 37 insertions(+), 39 deletions(-)

For the Tegra part ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


