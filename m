Return-Path: <linux-pm+bounces-37898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D7C55A83
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 05:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 832A434C495
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDD2FF642;
	Thu, 13 Nov 2025 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b6rqhx+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E227B345;
	Thu, 13 Nov 2025 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008595; cv=fail; b=ne4gHEPf80PhUw10xhbrjKp+qZiCKIap10BHl9kIl038+XUNLmr+qzmdhdpk9BqW8RyYEw/Qhhmyg+K/yRzqQZCvF5Dnp8+/D40L59Hy8sKmGoXp7x/0JPsVPl1jJI7GOT1/g7S4Cgjre3Fs1l72isYal48IQFCFn8r95EwoekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008595; c=relaxed/simple;
	bh=xovgAoOG9NPT91hS0mAktkELBB6lRmO++M5MAYNb1bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sPk+JsaJOdMBPnk/8zPwoS4hiH9Q3RvpE5icj4yot4qZcUB/3sYkULcP+tiTxoGBdz2q6Yz/v9E3kB7RsJnkZauLMVWl9tcI5WlyKQpJqz4suqC2l5U4NDkUnTaPBjTCf0Vc6IvzKzyq//2qelPdG8/qOyBLtwTd6ECuVFiMGRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b6rqhx+D; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuCMs8BAkyt0DQxITnyqLfhT7inZpBpGWYFshuFCNNM7tttOXgRut7CDOIBa5uo5Gv7pDaiKrsJP4Ikox/bOEwIrfKK6F9f+cDnPlLyWXZGKGt7Ia/MHmLFhajVx66yhBkydfu2hwYIjtIRd2rMbja6Ao+HHh5AZhd6COAAbTuQIQz14PteB4STxmSM2x6ho/jqACs6Im1BmEa7zzVd7XpXxGccIsMR7bZNbFlzGEVXoN2L+dGrEJOJ9BY4CIq3BS7yxg1bka+LGushE69na3Wds5VE37ooWX7fsxU778+jelJ6rf1NlS64vNXOEgiIP6h3GekBBvZIQYwtCf3KizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4FdF/laC+vUUhaoCyEjepAntCxfv+kXCXigPqgm+9c=;
 b=wB7sCf9dlRa14TWboek1rI7O/+2nXy9y75DERo4YbpYO1QUyI3yaTJN2r7NxtYKapH0VqDmfDM5CDc8QXFFmuPOTYWf/dzLVc0vy6Fj0nKXJF85kT2/cWbJuFfKTb80td4NEgcVTZHs6KsYHSdp3vCvKucPDKw/OhGkDNVyOpt601+ZmiT7Mao8FXRvbWo2unMFktQzCuzUNk3HqunxOWFpTIbvGvwldDu+m68esE23cuaWQDsY+Lj+cSxyoKs4AxAvUAHrfPfTrSvrG5jKHB9OJt8SRyLmyzXF7XOiJ1qjdGE2VqQQtV0if165aZYvgndnBNqRYzJ7WzndvJgrccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4FdF/laC+vUUhaoCyEjepAntCxfv+kXCXigPqgm+9c=;
 b=b6rqhx+D3Tv9FevZucAHNlBgBhggteJgtyN9jNSMpI0tWTGcmU/t+rCS8gXqNchEmMlp8GzxXYIqeNDdu1P/Qgtxfa14h5IE4bJVzpWl3gFiFcEsiqV4gkX+p83XbNTK/GtXSbqMLOIY1V6tuWexO2LJ9jWrIuRlUh2w4TTejlA56LjfKeFZNBb2WEX4JKYnr3UbRpGv4Cr0h/VVz2MT/28R8F84s4K9xvD1RaOM5/YtqnZJegEcBoLFrR9HJ/9SYOr0pXeH4KZhAnSXMbsLL+9T+dGYLDQQNa57I1k42vBXgVlQEntamnb495O/4RnKpjdyqdfwkjsXog/jNtGGXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 13 Nov 2025 04:36:27 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 04:36:27 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 04/11] memory: tegra: implement EMEM regs and ICC ops for
 Tegra114
Date: Thu, 13 Nov 2025 13:36:24 +0900
Message-ID: <8942558.lOV4Wx5bFT@senjougahara>
In-Reply-To: <20250915080157.28195-5-clamor95@gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-5-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0358.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::9) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d50d00-e9c8-4e31-1951-08de226e3589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|10070799003|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnNCWG5NekFhV0x1VVFUY053WHJZK0RtSVVCK0hKWUp1RklVSXhEQ3pjZVRv?=
 =?utf-8?B?UTF1OGU3VTVQQ3dSOENXL2pzdm8vQ3pvU25CNklMTGVJdWRDYTF3anJsWmZ2?=
 =?utf-8?B?eU56eFkySFFVRjF0Q1FuVGM1NEFJMFUzYjdyLzZiYk9ESDhDUEhhbzJ5d1pn?=
 =?utf-8?B?L2pTMnNRaG9pNGwxZ0F2VHU4bmVMMGZuNjJQWHE4ckljRThPTlovTjRDWW5K?=
 =?utf-8?B?TUY3anVDcWRKdFViZE5CZnR4OGFsSUR0KzkxUHQ0aTlUbG1BeE5YZk56dndn?=
 =?utf-8?B?UnZJVmsrV1R1aFdSVmc0djFrbmVCaGZwK0lFZm1jNjVDUFhtdVB3eDJvMWZq?=
 =?utf-8?B?cW5JcFdxeTBTZGRqUFdOVFo0VitiY1NmYTcwYnVYVVZTZHdUWWNEMDlKT1k5?=
 =?utf-8?B?Q0hXeFBvcDdibXV3SUdVWmRnRVFkR3BWQjRxaXJZWHlYcHNXTXYrbndkMURl?=
 =?utf-8?B?MkxvQ2lUcUhWZnhHOHJVYzY4aDRaclpVSDFKRE5wUXZ3ZllYNTlvY1N4YWZW?=
 =?utf-8?B?NHRtMXdJNUN4NXBlQ3NrWTFNL2x4cG9rSHZ2YzZ2eVpJVi9pWEZQS3ZzMjlu?=
 =?utf-8?B?Vk1nRm95M29NYy9JSzBoZlVQaHdzRFB3RC9hZWtnbU16cldudzFKakd0TmxO?=
 =?utf-8?B?TS9zTlV1Ky9nUDlMSHhYQStFdFVZN2svbFFhakZiYkxUZlVrRmhUZFJUejdy?=
 =?utf-8?B?aE9HSlNxamUwRFRQRG4wMWhVclBPTjdRL3FrMllnWkFraklsQ0Q3L0RqYlVM?=
 =?utf-8?B?OGdOTFVVUmNEUHBoZDg2L0UzeDhhZFV1ZTgzTGFDWTZVMk9RZDNoV1JTbjdB?=
 =?utf-8?B?NE9VVUZyTC9EQkdpU1Qvbm5Qb1RybWRTcUxLQnl4dktpSmZUb3hVaklMbjMr?=
 =?utf-8?B?dmIyQVlUS3JidVp6eGQ2K24rRnR0cVlkUE8vdCtUaFE5dFhoMlI0ckxRc05K?=
 =?utf-8?B?UU14K01FVjZ6MENxbFJtMys5UU84OW9sZzV1R0FHVkJ6c1JJZ2U0RWVqVE1V?=
 =?utf-8?B?amVkc2tzY3I3YjNYY1NMck41QzRPano2bWFWdEZ5WjRVOTVBdTZSc0k3eERJ?=
 =?utf-8?B?N2k1c0oyOU9sUlg0VER4eGtzNm9iVGE1d3gyUGpGZ3ZhMVZOa2poSkZ1bi9V?=
 =?utf-8?B?NVJzdUl5ZnQ2anRBeE1BdGxuUUxFUTlwd0JtNVJkajBMV0tpMlhvenBDOWRN?=
 =?utf-8?B?b3lMWTVSUDUwT2tlcllOY2VQVEJORFNPZEdLR3gxQ2loVHMySVJsVVZ3RE8w?=
 =?utf-8?B?bWVNUEFKOC9BdzgzMzdmOVRLMHNLODRabEVFV3BHMUttZkl0QjlVa2pydUZo?=
 =?utf-8?B?YUNQenQvejdDaU9sb3hiU09MRitSV3BiUHAwUzJqMUQ3MG8yNkJQTllTWk1Q?=
 =?utf-8?B?d3diNlcrazBkRlRHMERUcEV6a3BDbXl1UlN0dEFtTVhmSEdxbTZVNnlxOGto?=
 =?utf-8?B?cU91N0M3bzVYQVF2UWhBdUFpdWlYM000dS94am0zclI4WURBKzdHeUJDKzF4?=
 =?utf-8?B?ZWJ3Y2I4M3R1WG5SN0VJL3h0UjloMm5CYVhrR3dEbzdGeGk3Vjcvak5XYVda?=
 =?utf-8?B?ZUtBM095RVhFejlZR2lSTGJsR0dwNThyejNDTVNoMFJqSjNpaEVJcitRaHpV?=
 =?utf-8?B?QkZUNmxhazcrWUV2dWVmbE45Mm5UazBMN0JkLzY1SFlSNklPL0g0RkwwUHBs?=
 =?utf-8?B?RXdiYm1jMVBFUGRJd2NlY1pNYjgyeU05KzhtRkVzMk1hMVZ6YklUQlE3UmtB?=
 =?utf-8?B?YkQ3bm1pQitFaHRvREhiUDllL3Q3M01LT3dIdjVLMmh3ZGRtNkF6K29KckRT?=
 =?utf-8?B?U3hWQVJCZzhyRi9qdTFFMVF3QkVkMGRibFI0amVEWTNvSGFlMzBDQlBRaUxp?=
 =?utf-8?B?cjlLMW1SYUZBbG5GelQyNVZyRjJWSjVJbU1YRllpckFPbU9MTmNCc1doNTRQ?=
 =?utf-8?B?YVZ5NXNVUzg1dlJPUFFaRGZRc2JwNFBSWUZjbUdZa0w5aE9xYk91a3c0bFp1?=
 =?utf-8?Q?EpIxzvnYZtY23KfIidr8i277gSoZ2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(10070799003)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekVVQzh2ZE5yMzkzRFh6NnQydW9TNFF4NHlNRVJFNnBCRXlyWU0wclJZdGd4?=
 =?utf-8?B?QzFWRktEOEdUTm1ERkpNcDRnTE5zZGg0MUZtcTgxVkVNNzlpdlMwcDlhZUVa?=
 =?utf-8?B?SnpnUnBldEZxWWI0WnRlZ2JWYVdjTG5sRzREd1RrZ2R5ejRYbmhTRXBuaG9I?=
 =?utf-8?B?TzF0NkxiY3JiODRJanBuNVdaQmEyNzlsRGtUNFZnWitOL3U1dTY3NVVqVnhW?=
 =?utf-8?B?K0dtcUc1NWJTL3dWRjNLVTViTmNZU2ZjZVRySkYvc0c5eFlLbXptZGpMQ0g3?=
 =?utf-8?B?NHFWb2NuL0NHWDNhZ0VVakRXcmsvaVF4QWdSY0Ntei9YdE9CQldNMkVQNFJa?=
 =?utf-8?B?VTV3dFZkM1R4Tkl0TEZNVml6V3ZiM3NhYWhCQW4rL0toTVRNNDF5eVBwUlB3?=
 =?utf-8?B?YUJPeWgzU0U5WVpHSzdZZ29vZkFSTGp5cXBacGxUM3kzbjkxMGxISGFTS2E3?=
 =?utf-8?B?VE5kOWV3dk5BZW1BcFFzQTVybmxoREdWL24rWWNEQWkwekJUV3NHQnhUaXVR?=
 =?utf-8?B?MXJEWUdackVCZFJ5NEdVU3pSd04ydS9KWStxQXZaamI1bjhEeWNFWVdDb21k?=
 =?utf-8?B?aUpBTmo3SVJIbGRTNm4xMnU0cXQwRXdBWTBLLzdyd2h3VFdkQzdkREJ5Y0J3?=
 =?utf-8?B?Z3Z4cmh4aTdkTUR5cEptdTFpRkFmeUM1cGNyZk9QV2JaTXEvTXFnbDVacEc5?=
 =?utf-8?B?TzVUR0FEUm5mei9vYTBsKzBvWXgyT0hHb0RlU1hPa2tYdEhiWW5paFBkenR4?=
 =?utf-8?B?TUFpTnlqcytIMWNuSVQrb2h6NUY5aWw3SE1iWHBOTU56OXR6bXJ0dHBaRW5x?=
 =?utf-8?B?LzJpemFXdmlXa3BZTmJRaDNuWDZjTElxd1VXdGp0YXVwNEZrRGNkTW0wallW?=
 =?utf-8?B?a3ZHVk9JcVVObzNPZFp2RDgrNWtOVG11aU13QlgzUVRQWEhINjlyRzZsZmln?=
 =?utf-8?B?OTFURFg1R1ZSbkZ3NldrOTRpNSs0cmZ3QzNFWDVIdGIrY1JaaVU2NCtSbHFS?=
 =?utf-8?B?U2RHY0w0WUVJNDVFMU5UbE82eUFLOTdmN3lzK0tGN2NLQUs0ck1XT083enZV?=
 =?utf-8?B?NGgrSTBjZ3hYTUZnczBUbjBpYnlGSGY1VGU1bkNMUDhVay9Uckdabk52WkxQ?=
 =?utf-8?B?bVhNcEpmNDViNnhCSGt4Z1cwZ3cxUXR4RWJtaEdPVWhKb0YyQ1lDUzFMdHAr?=
 =?utf-8?B?dnBMVGttMEZ3akNwQXdSU09UbWZoL1cxZCtoYjZwMTVoeHdKcXdEQ0dHZFpu?=
 =?utf-8?B?TXZqRzBJSzJieVZhanJOWXFRbWIwR09xSk51ZE8yK2xmVXVTS3lGVFpJM2xz?=
 =?utf-8?B?bHRYaFBqWFRMd0g3a2VVSVVOeFNwaXRVSGdudWRHeXc2dE9MZXVIeGpuWlhL?=
 =?utf-8?B?cGI2UnlOSTRObGpNSTNncm96S2p0NFE4ekxvbFRNQ2NRdmtweGVlK3lnY2Yx?=
 =?utf-8?B?dGlkZnFYM2N4dEhwRmc1ZjlSaUw1RmVMMlpsbkdHS2c0RHZ4MGNvZmtCNEg4?=
 =?utf-8?B?enZGbUV5akd1R1FKUEhSUTJVakpQTGFJdXo4d1VEOVd3QUg5V21WUGY3Qmxs?=
 =?utf-8?B?VnorV2RSRGNvWWwyRGt5Zi93ZFhDY1ByQUR1bzh4Y1ByNEFxR2ZPS2ZKbGx3?=
 =?utf-8?B?VVZFSXYzc0pOTHdPeUc2MXVBeDRCSWs1MG4rL2RPZThLR24xWSsyMFg2Nmoy?=
 =?utf-8?B?N2RtMEpoa0hjTk13b3hOUlprbVUrL2xjbkxMbVBaSUkwQm1ZcnZOaUlpYUpW?=
 =?utf-8?B?QTBvcklQalRRQ1dqeEFKN1ExWDh6d1d0TWl1NHQ0aVBDaHZlV1RPSno3c3c5?=
 =?utf-8?B?c1FnQ1ZMMWZYY3dFZDNxbWQ2WCtITEpYV3ZUVllQb01ab3R1MkJpSmxCWEx6?=
 =?utf-8?B?eXhXcnR6N3pLeTB5UXRudHJPbVdJMmdJOWFkSjFHUXVrYlZLeFFLVVdLa1JJ?=
 =?utf-8?B?djk5b3FDVXluai9wb1JZclg0RzVTOG8vRE9tWVgxSklHRExxaWRYSlBZb2dJ?=
 =?utf-8?B?dWluOWM0OWZabldIejNmeldFTUVCY2txakZ0ZllwZ2tud0ZmZDY3V1c2UGQv?=
 =?utf-8?B?NERRdU1qY3gvM0tJbE1SL283SkRhMHV6QWJ3RmFCS01ZQlZCd2ZxZmc4VFBq?=
 =?utf-8?B?Q0QwMG93OE82cDAwV0NDSEkzRG5pbDZlUWlvRkxsTmV2UUQ4NzYzRlhKcWFa?=
 =?utf-8?B?VDViVEZXck9hNVFPM2hPOUt3WTZHT2t4cDlMQXpzN00xVUk3aGR0Q0J2MlRC?=
 =?utf-8?B?NCtPRENOR0hVTllGVGxDOEoxSEJRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d50d00-e9c8-4e31-1951-08de226e3589
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:36:27.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cStd2eLeb/ii1D9ZidYxJ5Ammv84IWZo5nGIl20uodjNgMO/dAYGYtDynbDDcgjKgJQXVCKIOgLlSI9deN5CUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370

On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> Prepare Internal Memory Controller for introduction of External Memory
> Controller.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/memory/tegra/tegra114.c | 193 ++++++++++++++++++++++++++++++++
>  1 file changed, 193 insertions(+)
>=20
> diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra=
114.c
> index d03a5d162dbd..c615857f7fad 100644
> --- a/drivers/memory/tegra/tegra114.c
> +++ b/drivers/memory/tegra/tegra114.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
>   */
> =20
> +#include <linux/device.h>
>  #include <linux/of.h>
>  #include <linux/mm.h>
> =20
> @@ -1165,6 +1166,195 @@ static const struct tegra_mc_reset tegra114_mc_re=
sets[] =3D {
>  	TEGRA114_MC_RESET(VI,       0x200, 0x204, 17),
>  };
> =20
> +static void tegra114_mc_tune_client_latency(struct tegra_mc *mc,
> +					    const struct tegra_mc_client *client,
> +					    unsigned int bandwidth_mbytes_sec)
> +{
> +	u32 arb_tolerance_compensation_nsec, arb_tolerance_compensation_div;
> +	unsigned int fifo_size =3D client->fifo_size;
> +	u32 arb_nsec, la_ticks, value;
> +
> +	/* see 20.3.1.1 Client Configuration in Tegra4 TRM v01p */
> +	if (bandwidth_mbytes_sec)
> +		arb_nsec =3D fifo_size * NSEC_PER_USEC / bandwidth_mbytes_sec;
> +	else
> +		arb_nsec =3D U32_MAX;
> +
> +	/*
> +	 * Latency allowness should be set with consideration for the module's
> +	 * latency tolerance and internal buffering capabilities.
> +	 *
> +	 * Display memory clients use isochronous transfers and have very low
> +	 * tolerance to a belated transfers. Hence we need to compensate the
> +	 * memory arbitration imperfection for them in order to prevent FIFO
> +	 * underflow condition when memory bus is busy.
> +	 *
> +	 * VI clients also need a stronger compensation.
> +	 */
> +	switch (client->swgroup) {
> +	case TEGRA_SWGROUP_MPCORE:
> +	case TEGRA_SWGROUP_PTC:
> +		/*
> +		 * We always want lower latency for these clients, hence
> +		 * don't touch them.
> +		 */
> +		return;
> +
> +	case TEGRA_SWGROUP_DC:
> +	case TEGRA_SWGROUP_DCB:
> +		arb_tolerance_compensation_nsec =3D 1050;
> +		arb_tolerance_compensation_div =3D 2;
> +		break;
> +
> +	case TEGRA_SWGROUP_VI:
> +		arb_tolerance_compensation_nsec =3D 1050;
> +		arb_tolerance_compensation_div =3D 1;
> +		break;
> +
> +	default:
> +		arb_tolerance_compensation_nsec =3D 150;
> +		arb_tolerance_compensation_div =3D 1;
> +		break;
> +	}
> +
> +	if (arb_nsec > arb_tolerance_compensation_nsec)
> +		arb_nsec -=3D arb_tolerance_compensation_nsec;
> +	else
> +		arb_nsec =3D 0;
> +
> +	arb_nsec /=3D arb_tolerance_compensation_div;
> +
> +	/*
> +	 * Latency allowance is a number of ticks a request from a particular
> +	 * client may wait in the EMEM arbiter before it becomes a high-priorit=
y
> +	 * request.
> +	 */
> +	la_ticks =3D arb_nsec / mc->tick;
> +	la_ticks =3D min(la_ticks, client->regs.la.mask);
> +
> +	value =3D mc_readl(mc, client->regs.la.reg);
> +	value &=3D ~(client->regs.la.mask << client->regs.la.shift);
> +	value |=3D la_ticks << client->regs.la.shift;
> +	mc_writel(mc, value, client->regs.la.reg);
> +}
> +
> +static int tegra114_mc_icc_set(struct icc_node *src, struct icc_node *ds=
t)
> +{
> +	struct tegra_mc *mc =3D icc_provider_to_tegra_mc(src->provider);
> +	const struct tegra_mc_client *client =3D &mc->soc->clients[src->id];
> +	u64 peak_bandwidth =3D icc_units_to_bps(src->peak_bw);
> +
> +	/*
> +	 * Skip pre-initialization that is done by icc_node_add(), which sets
> +	 * bandwidth to maximum for all clients before drivers are loaded.
> +	 *
> +	 * This doesn't make sense for us because we don't have drivers for all
> +	 * clients and it's okay to keep configuration left from bootloader
> +	 * during boot, at least for today.
> +	 */
> +	if (src =3D=3D dst)
> +		return 0;
> +
> +	/* convert bytes/sec to megabytes/sec */
> +	do_div(peak_bandwidth, 1000000);
> +
> +	tegra114_mc_tune_client_latency(mc, client, peak_bandwidth);
> +
> +	return 0;
> +}
> +
> +static int tegra114_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 =
avg_bw,
> +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	/*
> +	 * ISO clients need to reserve extra bandwidth up-front because
> +	 * there could be high bandwidth pressure during initial filling
> +	 * of the client's FIFO buffers.  Secondly, we need to take into
> +	 * account impurities of the memory subsystem.
> +	 */
> +	if (tag & TEGRA_MC_ICC_TAG_ISO)
> +		peak_bw =3D tegra_mc_scale_percents(peak_bw, 400);
> +
> +	*agg_avg +=3D avg_bw;
> +	*agg_peak =3D max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static struct icc_node_data *
> +tegra114_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, vo=
id *data)
> +{
> +	struct tegra_mc *mc =3D icc_provider_to_tegra_mc(data);
> +	const struct tegra_mc_client *client;
> +	unsigned int i, idx =3D spec->args[0];
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	list_for_each_entry(node, &mc->provider.nodes, node_list) {
> +		if (node->id !=3D idx)
> +			continue;
> +
> +		ndata =3D kzalloc(sizeof(*ndata), GFP_KERNEL);
> +		if (!ndata)
> +			return ERR_PTR(-ENOMEM);
> +
> +		client =3D &mc->soc->clients[idx];
> +		ndata->node =3D node;
> +
> +		switch (client->swgroup) {
> +		case TEGRA_SWGROUP_DC:
> +		case TEGRA_SWGROUP_DCB:
> +		case TEGRA_SWGROUP_PTC:
> +		case TEGRA_SWGROUP_VI:
> +			/* these clients are isochronous by default */
> +			ndata->tag =3D TEGRA_MC_ICC_TAG_ISO;
> +			break;
> +
> +		default:
> +			ndata->tag =3D TEGRA_MC_ICC_TAG_DEFAULT;
> +			break;
> +		}
> +
> +		return ndata;
> +	}
> +
> +	for (i =3D 0; i < mc->soc->num_clients; i++) {
> +		if (mc->soc->clients[i].id =3D=3D idx)
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	dev_err(mc->dev, "invalid ICC client ID %u\n", idx);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static const struct tegra_mc_icc_ops tegra114_mc_icc_ops =3D {
> +	.xlate_extended =3D tegra114_mc_of_icc_xlate_extended,
> +	.aggregate =3D tegra114_mc_icc_aggreate,
> +	.set =3D tegra114_mc_icc_set,
> +};
> +
> +static const unsigned long tegra114_mc_emem_regs[] =3D {
> +	MC_EMEM_ARB_CFG,
> +	MC_EMEM_ARB_OUTSTANDING_REQ,
> +	MC_EMEM_ARB_TIMING_RCD,
> +	MC_EMEM_ARB_TIMING_RP,
> +	MC_EMEM_ARB_TIMING_RC,
> +	MC_EMEM_ARB_TIMING_RAS,
> +	MC_EMEM_ARB_TIMING_FAW,
> +	MC_EMEM_ARB_TIMING_RRD,
> +	MC_EMEM_ARB_TIMING_RAP2PRE,
> +	MC_EMEM_ARB_TIMING_WAP2PRE,
> +	MC_EMEM_ARB_TIMING_R2R,
> +	MC_EMEM_ARB_TIMING_W2W,
> +	MC_EMEM_ARB_TIMING_R2W,
> +	MC_EMEM_ARB_TIMING_W2R,
> +	MC_EMEM_ARB_DA_TURNS,
> +	MC_EMEM_ARB_DA_COVERS,
> +	MC_EMEM_ARB_MISC0,
> +	MC_EMEM_ARB_RING1_THROTTLE,
> +};
> +
>  const struct tegra_mc_soc tegra114_mc_soc =3D {
>  	.clients =3D tegra114_mc_clients,
>  	.num_clients =3D ARRAY_SIZE(tegra114_mc_clients),
> @@ -1172,10 +1362,13 @@ const struct tegra_mc_soc tegra114_mc_soc =3D {
>  	.atom_size =3D 32,
>  	.client_id_mask =3D 0x7f,
>  	.smmu =3D &tegra114_smmu_soc,
> +	.emem_regs =3D tegra114_mc_emem_regs,
> +	.num_emem_regs =3D ARRAY_SIZE(tegra114_mc_emem_regs),
>  	.intmask =3D MC_INT_INVALID_SMMU_PAGE | MC_INT_SECURITY_VIOLATION |
>  		   MC_INT_DECERR_EMEM,
>  	.reset_ops =3D &tegra_mc_reset_ops_common,
>  	.resets =3D tegra114_mc_resets,
>  	.num_resets =3D ARRAY_SIZE(tegra114_mc_resets),
> +	.icc_ops =3D &tegra114_mc_icc_ops,
>  	.ops =3D &tegra30_mc_ops,
>  };
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




