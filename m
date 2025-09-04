Return-Path: <linux-pm+bounces-33828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D9B43AA6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DBA3B05B0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CE2F619E;
	Thu,  4 Sep 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bniC1y9A"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C92F998E;
	Thu,  4 Sep 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986476; cv=fail; b=SryvAZtOAQFKql8jnVG3mF1bD5V+OAUAXkOCGYL9vMReDM6g9Zjs1lbb7lhmAfSZ3eGOlPxMOwxbPoBB4V3bjGMeO4Vvny8RvXgfzNrB9Lj6DA4ji40JoWaI94b60fqEynn5sEy1eWQdc7Vr5ntFG5sVdZU1a1vpMOv7qFMY1cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986476; c=relaxed/simple;
	bh=tIXmXSHWptnP+mHWBvg4oHg1Mg1lltHzV5CQ9BrzYmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FU8lmMx95uSym4jgWTviv5awDtmmpNVzoRa26srEoJ6alDmPz7DdKDWP9/X+uUSbJAETmN7Qectm+ZJ45gwgTmd+fQF8+WZLiCTavzmLG7yDIKiEFoeDn5C1UufRUF2LrAyZcArzAtBO5M6dtM1VVsFTlNljtPZWxBO5HMdbbEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bniC1y9A; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwmSXGkpgI/qwZfWzX/8VMqcTes02t9PhNUXpnU4jMgSfD8UseJejukrdn6HH5zIBQS2jT2D30mOYE7j2xUJnATQPp3Sd/E/mTRDhuzqyIxFHVXFnLHHkGXtE/wLVD5TjADYpAl+7VclN4VP7VsGI6HTiAhjDcswWeFvGN/+p/HNGofus0fh/4KGGMGi9zxo7aIuQ7YBHyX5p/yMc4yF7i4RZ9+wpTmOWkuLbWLw82PGTT9bPSwllSGlik4qHSA7qYHZo+CMeGyYu6fUBHo/pSuz/fkcAc7aJ9yZu4EK8TMcLxjlZFtlmEyW1teaZ7UC2OTcZ774Lya6iOyRR9FZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//Z9OjsP8DCBwntEyq6upJHsyd1hc/cFSuxPnKpJQ0g=;
 b=bMlguUauBnSUhU7YH6NwzG/naEu3yC8WUzOzp92Zr9Ri6gRBRiTCCQCKuvf4rl9L6yEcxtU6+eHj6238ZghTOCg4osB74RTeXIjsJ5/0+N8s65XiPT/dIcu2u7czBcl/Fva6wT7wU4Uo082uvS2cmSQzyxO9kNyZ1hOQQP8RTvrBWOyx1aF0c29eAABKI0IEcpqypvs/TlevMe/R8Smfl95Jlr359upIAzDR0Tlrv8gqtBDDfpBxFIFa4DLw2Jg6TCtpN2Z7G2bleTIouOHiOWPHEuRPE73AmHJWPtcOdhrcJUW8roR4h7OHT9rnnAxb1WPGbDqA82ftTIJWydrfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//Z9OjsP8DCBwntEyq6upJHsyd1hc/cFSuxPnKpJQ0g=;
 b=bniC1y9Apr4vBXCEGFBlYbI1dwTE48J0oygPiG6IICb0/grFaXq4vVZNtQMaNAsasSwOSmipkKBCS79CQUm5OQb4mbLbVv3bDmKSgoHGRvD47ZEqiGcKYWcEMu7nSVn2Lb+lFaWeYWhM4OykthNuOfeKG/WIrK2t4+8vNO/plMBp4PZBnSBW0AxGuuFPR7GDzLM9Ah78l3pJGCg6Uas9B5ciCpMO3/LRjNvb+rmqwt9cHOn4VZQIpfjgFhpAXAdxPkOlmyAsL7sfQ2pjmSO+VO/klnqkRRNfSsQJNebozzCZfmFdEq97v44Lc6q/1UHoARPvjukEVUqv8AFj97Th2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 11:47:50 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 11:47:50 +0000
Message-ID: <cfffcabd-c33b-46f9-9b16-b6063ceee4c1@nvidia.com>
Date: Thu, 4 Sep 2025 17:17:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
To: webgeek1234@gmail.com, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, bbasu@nvidia.com, sumitg@nvidia.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e048b7b-9525-4cf2-5c24-08ddeba8dfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alJGZ0lvV0RYRTllQ1Z0VGdLd3dXZitmMk5FaHdlYjBuTTdmM0dYV3RpZDdS?=
 =?utf-8?B?dFlFSjRjYlZEOU9RQ3VFR1FBK0xxK2dscEFsV0tQcTFKWXd4T3BYRlNZQnF3?=
 =?utf-8?B?YzBrMGEwQ2N2aG10bWV5bVRaWkdIRDdxeDJybUlabXBrejFHU2Y3MVdKQVBR?=
 =?utf-8?B?MStGKzNvY2NLSDlPcWQwTHlUY0dSWTlROW5reGtXVUhrTHRpWFJQVDdWYW9s?=
 =?utf-8?B?M3AzL2J0M1lER3JyaGhTdHNSV05NQW9KYVQxOEZtSkd3ZFJtc212WTN3aWYw?=
 =?utf-8?B?N01VKzNYNk5FS3BMV2ZYNjRkZzhlNVU3a1AwYUsrcGw3Sk16eE02VEg2VzlL?=
 =?utf-8?B?RzNXUHJxMCtuWTVJL3dCUktHdEZ6T0Zwc1RQVnl3L3BCTU1CSWkwN2V0dHN5?=
 =?utf-8?B?dmkrVzgwR1Z4Q1pBU01UVCtEd1M1cnlTVEJObXRQWS8xTGk1NFJCWUUzbEhj?=
 =?utf-8?B?ajNweTA4R1lBSW0vSzNqVnVFL3hGWUtDR3BDbmVqRGt1bTZvZUJ6a3A2MStG?=
 =?utf-8?B?ajh6c2tqMnlEdHBYOTNiVkxUd3NmLzQ0NHVOOUQ3UzZoa0hiOGgvVk0rQzhT?=
 =?utf-8?B?dlJJenZTaForMG9OM3JJYk5Bd2gzMVg5Skg1NUVhanR4VEJ4Vm9vbWNnQUNw?=
 =?utf-8?B?b3ZzbVdDV1VYOTRZZDQwRG1mN3IybkgyWFR3T3RpeDlHdmhsd1FMOHkxSVZj?=
 =?utf-8?B?ZHNBKzJLY0xQYVhyTEZMcGdYbEMzK2dGTEcvVUs3bFAyZDg5cy9UTWxHejRp?=
 =?utf-8?B?d09iMEdRR0ZabHpscFdEWnhNRC9uZ3lZUktXOE1aVWVKdXc4SHROb2cwcFRG?=
 =?utf-8?B?WTd0RXU2UURRQXhCOC9RMzFYRnZEV3FRWi9HbE9XMkV4N0xyWUo5YjlPUHh2?=
 =?utf-8?B?MHhJZDFGSXlIOFY2ZWNYVVJkRmxqUkpreU8rSFYrdHNrak1PQzBGbFVEUEYy?=
 =?utf-8?B?d2FBbWVZTUNvLzBkRWJZUkdkVHVSY0l4R25KbXNUQW5vSnk4N3dINUx5TCt1?=
 =?utf-8?B?azlQKy82OFQ1MTZ0RHpQeFZ3eS9XTHRsVXN6MjBDdnZtcXEwUzdFT05vZVd1?=
 =?utf-8?B?MUxjTXhKL1MxOW5nRlFDUWVoelIxUGF3YTBhVi95UEF6SjRSdStVTkNTcmgv?=
 =?utf-8?B?YktaQy9EdlVkejM5Y0g4TGkzQmxOVmk4cTd4azQ2cFpySkdxWE1ZQUFPdTdr?=
 =?utf-8?B?WUp0OTNIbm4rdWJ4QmptYjlZdS9YaE55NVNCdUZ4b0ZCTXFnQVlaMWRPK2V0?=
 =?utf-8?B?MWNyUW83dmc4cmFwbGhTY1dOWDFnbTU1dS9QeTRsMi9QQnAvQmhMV21JUmVl?=
 =?utf-8?B?ME8xR2psVWVBQm5sQXVEZThtZmc1ZG1sSXd1NnU1RGxpbnlrUG9JMk1aWWdz?=
 =?utf-8?B?WmsyUzNia1Qvc1B6TC9sVDJVYURPMExuaVZCMWI0anZUSjhCdVE1UnFzWmNG?=
 =?utf-8?B?NUlaNUlKWndoTHRGVTZYL3FQUTE0SGJyNWFxeFBuc3hTNTFLaXdZUUc4REdI?=
 =?utf-8?B?STNkbXFUOWpsckZ2NXU5N1N6cE40akkvWFV0TlJzcVhSYklCY2pyaW95T1F0?=
 =?utf-8?B?UEFxNmlLNllBUGYvS0NrVUkyNEZCY3MwME85MVIzUlY1YVZTNk1JTnpoUytG?=
 =?utf-8?B?eDZnV0Z2eTBob0JjMGFWeTZzcy9uaVZZRnlzb28ycUJBdmNud2ZXWVVEeElh?=
 =?utf-8?B?RWhxbTViUXpEV1B2dE5YTitvUVF3bmlQblBQY3Z0WUtIM2VjT2tFTUhVTld5?=
 =?utf-8?B?MHMwVmo4RlYxVUV1cGN5c2xCL2JXVVZyUk9mcUFHYTgxb05LRHJnTTBEOHdL?=
 =?utf-8?B?RkxhWGhpdTEvWnk5SldWYm9HazNya2VhNWl4dmUxUzFzcW4wbk9udTVpK2t4?=
 =?utf-8?B?a2ZHN01hczFEWWx4OVRkc2tJZCtZeFhFeGMwVlFMMDNoemVYdEw0YzVEWnMv?=
 =?utf-8?B?TTZuaHJmdDl2a3JXcHd3MGRicFIrNjcvRWEzSlBnV1czaTd5SE5LcDlTSUZl?=
 =?utf-8?B?MmxpR2R1azNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFNPMDNrdEdsaC9JUElMSWtEQVRuQjFuVGl2TnVYdGdwalJqSkx5bEE0azJz?=
 =?utf-8?B?OE92WTFVaGFvRk5GVS9WWE8zYlNXWGFobmxUV25jR0pnMEJrWWcvRnFyTjZs?=
 =?utf-8?B?ZVRDTTNqTzdGUUtxVDZCY2hsU1BGcXFaVXY5eXNJRkJWdmJwcUttanV1OEM5?=
 =?utf-8?B?Wlpyc3lkWjE4eDB5bEFWb01xK2pTVHdjckQyVHhBUUVkMXRYeHFXY0s2SWdh?=
 =?utf-8?B?WDNjOGZkM0Y3LzNyZU9MNUp0cGswbWFDNjBRSzhVZmhUSGJ5RTV6MUxuY042?=
 =?utf-8?B?dWR5YS9SdUdsVWlCU2VVN1UySWFUa2FNRHp3RE1ZNzZGRituYnpubGhOOTZp?=
 =?utf-8?B?Zm5mWXFwYjlsOS9WdkR2cDVkaWJnRnJaRE1Kb3U4ZjZVSEFSWTFBczZMRUdH?=
 =?utf-8?B?S0JZb3k5cHF2azZQQlVJZm8zT21wVVlTSGFUR3JaNkhZaElHak1QdEJOWGRh?=
 =?utf-8?B?MkR1K0o1Z2FDN1lvekNESXZxUkZzU2VQLzhtakdaeStoSGRUdUd0QWpka2Vz?=
 =?utf-8?B?MnJlenZjQ2hQUUFOR2hRYWhsRmhPd24rK09KRHlGRFJkdE9WcUdTRjl5ZG43?=
 =?utf-8?B?eHhqcUdJR29wMnhkdm9mVExTemRmRWxoMTRPRlJZQ0xSZjAzbXlVOXFuS1J6?=
 =?utf-8?B?TGY1Vy91MDdGeW1nZUFweWhTK2pHVFFibUdzY051VnRPTUdmUXRNbWMwZkgw?=
 =?utf-8?B?bTVzS2dVNlNQZU5EV1YweVZpaFFra3Z5NzJDOGF6UGdnWUg1V01zdkhGUk9J?=
 =?utf-8?B?VWRURm1rOHpKMVVBWVFJRklMRVlRa05KN0hlV1I0R1Q1cHRQeXNOb1FyRXhj?=
 =?utf-8?B?VXhmbFBHMWQyNEtScVlSekhGTlV4TjNwbUZLWUxsT3EwNDk5cnZiUHJsdDdC?=
 =?utf-8?B?Mm1TblBDeWVkcUhNT2xpOHFXVkdyWGdtUU1HTWdiNm9iMVh2eUVmZnp5Mmti?=
 =?utf-8?B?b2dGUkFJRmpVTzZOWnZ1NVlKTGRPaDM1TTFPeWtrRVI3eWtjNll1dlNUVG5N?=
 =?utf-8?B?cWR2cm5xYlpueTRtc3BVOG5zNnlCTE9nVFhySU5lejM2NE1SNnBsQmJnK3cr?=
 =?utf-8?B?UUFMUjcvSnhtQWI3azBHZ2tUeFcvajNXUkpaaWFNS1pxcnAzWmVrR2hFQWho?=
 =?utf-8?B?aGMrUGVPeFNlRzRyRHU4SzJ4RThGWURCcTFBc1NtbW5ITWtCUzhLN3hucGln?=
 =?utf-8?B?VGlYMWFWbDd5VmowTUtiN0Fud1E1MVdrOWpVL0dsYm1leGYwRDM4SVRiVjZr?=
 =?utf-8?B?WXQ4Tnp0UEVtTlNsYzJFZS93QWdpYmZzU2NMUkkrbk9XckdyUUFOdDlBcVRY?=
 =?utf-8?B?T0NZTDlRY2JiNStYM21hUTVqc2h0UFhmQm01MWZrdWdYSzYxOWs1dDJWZTlO?=
 =?utf-8?B?SVNYbUV0MFd4SnEwRzhMdXk3empaOWN0dTlZbGh5WFpKS0hMaFFGVGN1V3ZW?=
 =?utf-8?B?SjNxcjBaa0ozemVDMDJqbDdqOUEzbHpnT1BoQ0dJbUhJb05xZmtIYThldjZ0?=
 =?utf-8?B?YnMrUVpOcEp0VHF5Q2ZUN3RDd0V3aEx0RW1nMWprYkJ1MTlFY3JxK2s0a3Bq?=
 =?utf-8?B?RFltM2tpdUZnUk12N010QUFydkVHcFZtRTM5R2VwOEg0TndXaENTRzF6ZWZy?=
 =?utf-8?B?eWVEM2pRZHF4bUtVN3ZzNFhoMXQwNHBSSVhXMklObnUzcG0xOWxONWNKK0cx?=
 =?utf-8?B?MzBHbzZja3pScy91ZHBPNlIwR3BZTWpHUHpITlA1YjAwNXJ4WWNyWFFBS2dY?=
 =?utf-8?B?Z1ExYlZIZkZaS2ZPTzZSOHBmVk9ZVHo3VjRZcmJFNHNZODZlYkg0M3cxM3U4?=
 =?utf-8?B?eWg2YTRoNDZIeU56ekEzR2EvWERJeFJmZzkvNHROS3dwMThuSTJWTGZrM0xL?=
 =?utf-8?B?VlZzZHNPUS9ScS9FWHdUWGtzOWo5ODRDRWlCdnh5aDlNU2ZicjYzQllEUkQ3?=
 =?utf-8?B?MjF6aXBWT0pUY2FVUVlFcFVXV3BSMUNJYkhvMkUrSVZEVlJtdHVSRVdQWWZ0?=
 =?utf-8?B?a2lPSy90cVFMTXl0dEtOY2VuZm5ZUzJHMERqcG8ydFAweG1CdkNtc0ZINHZy?=
 =?utf-8?B?R0I1Y09EOGlGelBLdFI2Rzk5REFaVEx5SzFNbTc0Q3FEdlVGSFFlb2VwNkRt?=
 =?utf-8?Q?9Xk2ikfeZ8t0TYFcd+47a67cu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e048b7b-9525-4cf2-5c24-08ddeba8dfc3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:47:50.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtyZFMt8LosTHkHtVt3Zf0uOfMdnggdDQ33Lp2ZV6DB12UG91ip/3xrKR88aof0hM0nOdE3nKvDBGX8ebe+zow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829


On 01/09/25 09:03, Aaron Kling via B4 Relay wrote:
> External email: Use caution opening links or attachments
>
>
> This series borrows the concept used on Tegra234 to scale EMC based on
> CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> bpmp on those archs does not support bandwidth manager, so the scaling
> iteself is handled similar to how Tegra124 currently works.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---

Tegra186/194 had multiple drivers for BWMGR, ISOMGR and LA+PTSA configs
on the CPU side. I am not sure how effective this patch series will be 
in absence
of those components. In Tegra234, those were moved to BPMP-FW. So, Kernel
forwards the BW request to BPMP (R5) who takes care of setting the final 
freq.

Thank you,
Sumit Gupta

> Aaron Kling (8):
>        dt-bindings: tegra: Add ICC IDs for dummy memory clients for Tegra186
>        dt-bindings: tegra: Add ICC IDs for dummy memory clients for Tegra194
>        cpufreq: tegra186: add OPP support and set bandwidth
>        memory: tegra186-emc: Support non-bpmp icc scaling
>        memory: tegra186: Support icc scaling
>        memory: tegra194: Support icc scaling
>        arm64: tegra: Add CPU OPP tables for Tegra186
>        arm64: tegra: Add CPU OPP tables for Tegra194
>
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 317 +++++++++++++++
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 636 +++++++++++++++++++++++++++++++
>   drivers/cpufreq/tegra186-cpufreq.c       | 152 +++++++-
>   drivers/memory/tegra/tegra186-emc.c      | 132 ++++++-
>   drivers/memory/tegra/tegra186.c          |  48 +++
>   drivers/memory/tegra/tegra194.c          |  59 ++-
>   include/dt-bindings/memory/tegra186-mc.h |   4 +
>   include/dt-bindings/memory/tegra194-mc.h |   6 +
>   8 files changed, 1344 insertions(+), 10 deletions(-)
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250823-tegra186-icc-7299110cd774
> prerequisite-change-id: 20250826-tegra186-cpufreq-fixes-7fbff81c68a2:v3
> prerequisite-patch-id: 74a2633b412b641f9808306cff9b0a697851d6c8
> prerequisite-patch-id: 9c52827317f7abfb93885febb1894b40967bd64c
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>
>

