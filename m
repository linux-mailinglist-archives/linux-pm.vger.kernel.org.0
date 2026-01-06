Return-Path: <linux-pm+bounces-40302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C2CF7D77
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 11:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7C63059640
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 10:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C50343D78;
	Tue,  6 Jan 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLHgFBcW"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED787322A13;
	Tue,  6 Jan 2026 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695771; cv=fail; b=ExmxfONBQ3fi0wxJITaKwYM1W45VSgt5TvwUTC+apZMNEsS+wdh7n/W+Cl/chJe9NbqpsF3ChyAm/YcGs+3jStfdpW2/XQso1fi6jKq80JMnjPo1EwJne0lCx1jKn7zj8UutBA3K/lNgzGQdTion0BOq2jWA4bAO75tyID4rOpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695771; c=relaxed/simple;
	bh=ZoeNNaRKvPv1wEajrUlxM5MyH0FOCGq3qkstQ4yk8f4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2waNp57AaYqxJnu+QKwLntn6BuKytPpDV0L9aK1TVc7ppFrF3fSocwk/Z6FfVbVU/9VKP2cDCTXda7+vAbXPHhPWCes/p2Jvwu1qE7s7qPZ1hwRJr2+XvEZ2dR/gfHZ9xsccQ4AVbM49seDTDLzV5U2SZ3Y/bN0lYqjFQgcemU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLHgFBcW; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR5bQ5OcXgFon8i0JADJAhHKOVOYbW9Tfx8jTAACCDIlQsZkpNA+RieiLxOy++3BjX4t/T72WFVX2OD9XVatUIoPX7SvxpiKlix5WLDzawxX+EYiA83fnb0aQ814DKWQ/eSx3xv7ZUga5HJJsCRHbYWlesESZDEhrSphO9tLr1kh7bgsF7zTprnHC0Idms6OzEYek5i6ce4Hj/ig8RPC+9ITXuOOflaorDjz48JKGxOfZdn7sddWG7EsyjkyRjd6rhG39Eh8Gov1z+yNJsfpfp1uIO+92FHySssAUfRWRg2BAMn0qHqsPfuAN5wXcben1GHM5OUAL//JSo4HSBd5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPvYjQ6+wjcvLt9bMdxUlc9oL2RmkKG1E65oDLS0tQ0=;
 b=WgAiUQR4s288TWGejvTtaw3ykFhiBWTwcSuZl3uLZynj3QVAW9g6m6d0kXPD5i7bgFinkh6hwJMnRqSIIkk9c6FJNKkjSl2CxJJRIguFVvAxQ0zq8Ek3SN8IiWsLaGY9tL4nyTNBBRFudoooqhKswdb/MaIGtnU6VfSlHMsuMx1NYUTX1UnseTyR8J/ZUM5TSk4PBqSxVD13QRvJLWJu+WkAadXHdC0TbSI9XIWkUKiHWcHFNk20FcOIx7MBfMqwlIFLIk12g/z+vAXD0lN+I4b+tXtJyZGBdAp+VXEoNnbro2uK+pvX7fkpw0+CE7emPU7bVaUqxp3I7R6GuMqMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPvYjQ6+wjcvLt9bMdxUlc9oL2RmkKG1E65oDLS0tQ0=;
 b=hLHgFBcWRWn32eJtD7ynDrosNbC2dRY59eXZ8SYlM/PmLMFX/dHnY4mcpzpQ0WBUuF8LVPH2lPfRC/yifIzR+aZyNnx0jn+UXQ7c5W/yYtPIbCz//wiZtu16riJdxO/EIO1SR7M/eQfX/VgQLFjdEFqUxI8kxCJrRUp7H8aZv/8Pu6XZXYUpAip3F7A/q2Ivgh8f1B6GVseffLa9FicQCSQNmvshNnT5cZSAXZvs7BdVMsv13ZpTSJyAzF6cWNtOnE03869tt47JTmiZFxt22czJEoiVhZb3X+q/z4MK73gpsJUF56Q4n+tEEOkw6Hja2ibPF15fe0eoDUBaJ6g2rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:36:06 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 10:36:06 +0000
Message-ID: <2d55ebec-1e42-4ddb-b0e2-529d3b2d7b85@nvidia.com>
Date: Tue, 6 Jan 2026 10:36:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clk: tegra: Adjust callbacks in tegra_clock_pm
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-tegra@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <5088794.31r3eYUQgx@rafael.j.wysocki>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5088794.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: edaff6df-decc-4a7a-1e5e-08de4d0f659d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3JmSS9Sa240WWdBMFNjQkxBSGVNVkhSeTBnZVBhUnZYYjVEZ0ZpYXVaV1FF?=
 =?utf-8?B?TVAzdVlLeFFYTUFQcS9Fa1hJWDcybzc0ZzhWMmVaRXVXK2dLTmF0RGRMYUJh?=
 =?utf-8?B?M2x1NllRYmNKWVdLQlhIU2xXQk5jTUZuNyt2c1ltL201eWxVN3d0WkdUNUov?=
 =?utf-8?B?L0dBcUprUlo1UE85ekNxY29RbjZ0SFk0R0hlSTdtZzVwcWFEcVlmNVhBR0Rx?=
 =?utf-8?B?RWhxcURpQ0lrMDNHRFViQkRqYkVTZzRTaTZqWWRqVk9TaUwrckk1UDdEUDc0?=
 =?utf-8?B?cnFPa0lrREFoMnBJZ3lkY0tSaUt5VzBQZ1YxVmV0MTVNR05jZkpTMkdWbE9V?=
 =?utf-8?B?UUxsaUNJVWZYemRNWHdOZUdCZXVNUVRyY3U2OWdOVDRRbm5rR3drSXpZM25O?=
 =?utf-8?B?UzRlK1VHU2tzYzBLV2ZrRmxGbFdqVi8zck9VTS8rWTZtNXpPbUZtY2ZRcGht?=
 =?utf-8?B?ZHJERUVKaVhWSFNSQlpqZHZlaGkwM2RhWTNGRHlEUlZxOHNYeEVjODNBd2dN?=
 =?utf-8?B?WnJnaHAwUjdENlZ5bzI4cW9TLy9wa1NiNWN0SGZxOFRNcHZueWIxWEVsSmpv?=
 =?utf-8?B?RGduS1NiWFdZam5uMElhbWNJZWlzTXAzSUhMbTRiajIrMUZvekVUL3BMUW84?=
 =?utf-8?B?bTRsektkQ0ROU3hVRlVtNjJvSlR4SGZlK3pnR1RaZ1VtREZ5K0lWRXhsM0FG?=
 =?utf-8?B?aG9oT1dXRDBXZ1loYmt2aXhXa1JucnRUc2t5ZUFUYTBERDFENllVMmhRMnov?=
 =?utf-8?B?K0daT0JuR2QzMW0wOHNGSmN3RFYyMUV6cFZFVkFLTjZDVXgrdGxESDFCYlFF?=
 =?utf-8?B?aHBScDdrMTl2VTZGVGRHQnkxODlDLzdjWUFub3E2Y1VOeVZUMVpwZ0hhT3p4?=
 =?utf-8?B?NjlKeitpamtiemlRcVBqc2MzemNOOUcyL1pGMjZvNWdJWjY5dTQrTHNUcTUy?=
 =?utf-8?B?V0k0amtYVmlHNnhPUmgyc2YxSEQ5Z3JDeDBJbTJ3alhlUG1QMktXZFFUQUtJ?=
 =?utf-8?B?bDNBZW9oTFF1VzRHME1pK2t0RnV1REFXcGM4WjAyR2ZaVWZNNzFMbWhuVU5H?=
 =?utf-8?B?VmRiYy9OWXcvUFdBKzNTWXA0cTVXK0liSEVQV0RlajIvTGJwVkMrUm1HRGI0?=
 =?utf-8?B?Um9McnI1T29DN3ZLUHZKZHhmMFFVb2F5Y0U0cFJEWTk0bHYxeTB5NmdtclpG?=
 =?utf-8?B?L3FoQUlaSnZtNm5sZi9adnlWWWJDWUtvRlNxV0pLZ2UxcDZjeWpDeFV2ZG5C?=
 =?utf-8?B?SnpRdm9jZ0tuYnN6Y1BDUG9FTjVhUDloTnlBbkwrdlJSN3l5ZTk0STNxNXdh?=
 =?utf-8?B?VGVra2hQWjNYcjBHSlV2dXIvaTdSaktLWXk5OFVKcCtobTVnZXluZm43a0tV?=
 =?utf-8?B?TnRXWjRWY2YyQ056Nis2S2dlUzZXaW91UFZlZnkyUFIzQjFVaVFDeE9MSGJG?=
 =?utf-8?B?NHF2MzRjK1pZZWt5V3hVN0c2dFBJZDBlb3V1UCtTSzJSNzZtZ2pJTktvbkp5?=
 =?utf-8?B?QmFMQVJtQnN3WlNMcStHMWVOZWFLTlVvNG0wVDR3SXlVdnhuN1QvWlFkYW1S?=
 =?utf-8?B?NXgrRnJwTTZZb3JuRWswRlpzOFBhLzRFeHhidCtsS0pUYUxScnp2MllDT1Bl?=
 =?utf-8?B?NFR3Yk5UMmM4TGRaQ2dKMVVYSGFYNDlPVkpkZklUdWJ2OUs2ekQxTzNRQm5S?=
 =?utf-8?B?dkZ4TGthTjFjeXhWWlFiV0pJQVBnQTAyeWt3eWdmUTd5b1ZHb2xiOXZkcGpS?=
 =?utf-8?B?ZnBNaXJRTVlwUHUxVVRsdnFrbndPa0RhcHZPRzUvZDZsRjQwdkQ1ZjJEMjY2?=
 =?utf-8?B?UGFXMTljMDdoQmFiWVAvYVpVMnlJTVNPLzh3K044emlTTUU2VjFlbXBwaWRD?=
 =?utf-8?B?N1dZRW9ONmFERURoSDRITXZ1amtXTXkxNUhUeFhMS1E2c0h6azZFSXpBOFhn?=
 =?utf-8?Q?a6qNeSJzRJdniLn9m/7mbVpd2xPJw9Oc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEVwZ2ZsZzVjTk9hdmZ5VjdJSlJhNzNIT2xQVDZHdVoySXltUUY0K3FnQUdD?=
 =?utf-8?B?UUJ3TTlHSklpRDdleEJ0ZVdhOHJvaWJzNmVQTG9TUXJTazc3Rk9BTlRWdmhs?=
 =?utf-8?B?czJNTFRuMGJhYmhzSGNrRUJxSzk3cmxuYkRoQkdwQVhDYmhPa0pyZ2NxYVd4?=
 =?utf-8?B?cFFLMk4wNURQRVhCdEV3cUFGQXNIaGFYZ3ZidEZMd2hxbmlXKzBhSG9ZVnpG?=
 =?utf-8?B?TVplVExUWmoxREFES0VCOExTWmZpMEhlNyt6YkRpRU14N1dBbWFTcDlXOVJq?=
 =?utf-8?B?VUV0b2tCU0FpZHc3T01vNzdXODNCUmVBbktyQ1hSWUowL2JsM1JXemNyMWk3?=
 =?utf-8?B?OXQ1S3U3ajhUdlRSOGZ1cWQ4Q0dmSzkzU0EyREJ1VE9MdjE3Z0p0eXBVME9F?=
 =?utf-8?B?dHZ5QmZING82bzBBYkQwTzI0ZTJmUUxHT1RSSDFtVkd5eHRpZWFhKzJXTUls?=
 =?utf-8?B?NU96bkg1a21JSXJmd2VWRFRadnh0MlpuOVZ5c0RUL2NZd29HRjNDNGswR2tt?=
 =?utf-8?B?eldLZmQyVTJTeHREeXY2UWZmVEl0Zi9VVGtvenVkYjVHZE5vSTM4QzZYQ2VS?=
 =?utf-8?B?QTA3WXYwR1FYZ3dvRVAvTzMzZWFuRnFkYmxlL1NYL21MTzdoWU9tNE5TR0hN?=
 =?utf-8?B?bnBEU0VJT25DVEFHMFg5UUg2dUxYVkNpSThFdDZ6SHFTeE15ajhtZkNzQy9J?=
 =?utf-8?B?aFFzZHlBcVVROGlXRlc0bGFCZUdPaWkrUUptNUw2MGNMVllFVm41WUZkaTF3?=
 =?utf-8?B?MjFPRERybnhGbEhXTFkxekZVbkVHWnBITFZYRmVZODhEKzZHbHQ5bm5LM0Fa?=
 =?utf-8?B?czcxUm9zSm53NzEvbnVYQXI0UTlnWEVLSVlGV3lEbXlSeFlmNFBvTEYxV2Rk?=
 =?utf-8?B?bUEvbkVtRDZMajBJMkR3TlQ1T2VUUUNPN0ZBejlNdkZqNU1TRVJIR2JqZ1Nx?=
 =?utf-8?B?TWFDMjY1WHZyNWdDa0o1VC85blRDM1pjeVAvTUdXbnVmMjU4UGdxdlV2cU5m?=
 =?utf-8?B?T1lteG0xL1BPZ1VOc3pVNmVDYWV6Uk00dUhVWHhrdjRQSU0vc0FQUzhGbThC?=
 =?utf-8?B?TmhGRElyUXJ2SnhsV1c0bHpLaVJqdFF1dVRPMkgxVnJOVDhkWjAzT3JkcUU1?=
 =?utf-8?B?SFUvUTdSMzY2WXpRNWd2MHpZZ2hOdkJ2SVBpOGtmQ2gweERsK0NpZE5Na3VP?=
 =?utf-8?B?YjBZV3QwV3Y0dWFYU1VSci9NTDI1N3hFdjNqSzc1N3lEZnR6RDQyUGU5Rklx?=
 =?utf-8?B?ZXc3Q09HbzNtbjg2R281MFJJT3d3R1VDQS8vN1BZKzFVK1pkMHVLSlVKazlj?=
 =?utf-8?B?TThXOWR5cXc3VEJXdTdQeFdCR0tib1JwUG5kcGcvSDZzWUtQbWlNTmREdEJz?=
 =?utf-8?B?MG96MGNJSnN2cC96UmRkWXRLTG1SOVo0WTlOa1BmSTN3WGphVzZFNnVVMnJV?=
 =?utf-8?B?a3VrNTgvOFBNeVdRdnh3Vzh2enAvMGNINmo5Si8wN1UwUjU2TWE4ZG9sYzgz?=
 =?utf-8?B?eDVwN1ErdG92d1UrQjJNRm1vL1VxRkJZL0QzMmNKaVJ2YVJTK3FMUCtyU2hN?=
 =?utf-8?B?TS9qRlhKVkY1VkQrZHlzSDFGMXFBSlhOQjJEWVd6YTRJTGxhUlh0QTNQTkh4?=
 =?utf-8?B?SHVoV3UxNDRDcGVsUGVpQWRFY3VXWVZHL2JiSmNITVk1cGh0c3ZYdVN3UWpq?=
 =?utf-8?B?ZkFMVE5ZTWpLSll2QjlTOXVWNkQ3SG9uV1FKU2NIL3dQVE9aZktjNnBicnUv?=
 =?utf-8?B?Y2g0OElJSGdCUW0yNUIzelFXVWM0SFV6bjRyWWUxOXJzd3FQY2NYM3JkZ2pu?=
 =?utf-8?B?NU9vV0djKzcvRUZPYU92MlV1UTJ6QVVSNTFtUGZhUFV5THdZZEhNd1B6ME45?=
 =?utf-8?B?RGpQRFcxMWh2Sm9RbURaRVdIQ3g3dW1BNFlYS0pmaVpQdVZhcVA1djZrK2lE?=
 =?utf-8?B?bkNHZzRNTG8wYXV1KzhjZ1FJc1ZER0RCSGgzTXA0aExwL2toTVozNmtvOWt1?=
 =?utf-8?B?NFFhTDlSMEFCcXhZQVRBRmQxYmR3a0tPVEQwK2JuVXU1c2VVdGRXKzBXRjBz?=
 =?utf-8?B?QUdjS1FERUNsODZHcXEzcUxqYWVoQnZiYXlhdmZtSXVsQTdLUGFERyt3NTlB?=
 =?utf-8?B?S2ZENU5Fcm1SZzBmVXVLTld1TjZPOHJoSEh0U1Rqdmx5Y3BNTzBPK3YybWVI?=
 =?utf-8?B?dnl1MlpOV0t2NTZadDVlOFNJMXVpT1ZTVDFxVEZ4TmJkUUl5MlV4R0ZOUEl1?=
 =?utf-8?B?bUk4R3BlVEVVTUxTS3A1bHROZWFlRXF5bkJ5ajlMZmNaejRBcklDYnJvRERY?=
 =?utf-8?B?TFB3dUFEYkRhWldENndqU01zWjI5NjdwUk5LYVZiWUZMTlRPakpwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaff6df-decc-4a7a-1e5e-08de4d0f659d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:36:06.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhATVQnPQJnLx0zWAZj5HCx9a3k39l7TyWVdf8imPNCxCtLhlar4VWDO16CKX2lZrSBxI963JKRz1pWHP28iHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

Hi Rafael,

On 04/01/2026 11:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> System suspend and resume callbacks run after the core has bumped
> up the runtime PM usage counters of all devices, so these callbacks
> need not worry about runtime PM reference counting.
> 
> Accordingly, to eliminate useless overhead related to runtime PM
> usage counter manipulation, set the suspend callback pointer in
> tegra_clock_pm to pm_runtime_resume() and do not set the resume
> callback in it at all.
> 
> This will also facilitate a planned change of the pm_runtime_put()
> return type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch is requisite for converting pm_runtime_put() into a void
> function.
> 
> If you decide to pick it up, please let me know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
> 
> ---
>   drivers/clk/tegra/clk-device.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/clk/tegra/clk-device.c
> +++ b/drivers/clk/tegra/clk-device.c
> @@ -175,7 +175,7 @@ unreg_clk:
>    * perspective since voltage is kept at a nominal level during suspend anyways.
>    */
>   static const struct dev_pm_ops tegra_clock_pm = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume, NULL)
>   };
>   
>   static const struct of_device_id tegra_clock_match[] = {


I gave this a quick test and this is causing a suspend regression on
Tegra20 and Tegra30 that use this driver. Looking at the console log
on Tegra20 I see the following errors ...

  tegra-clock tegra_clk_sclk: PM: dpm_run_callback(): pm_runtime_resume returns 1
  tegra-clock tegra_clk_sclk: PM: failed to suspend: error 1
  PM: Some devices failed to suspend, or early wake event detected

Jon

-- 
nvpublic


