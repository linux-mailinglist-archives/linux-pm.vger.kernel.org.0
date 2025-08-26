Return-Path: <linux-pm+bounces-33061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA6B35154
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 04:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366C4189A036
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33DB1FF1A1;
	Tue, 26 Aug 2025 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGsKRbCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED441A08AF;
	Tue, 26 Aug 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173738; cv=fail; b=oLP+OIdxsWFzz4ATDPKePpwOWDgsf4uuCRsp02FLZLd4M36lzX1pQTllbdbUO+A5hWKZJkUzLjlk0jqIyRQSu9h+LWbmPY70oHF/oN3gESKA8dOYmnYX1KYUuAYzZwR6ejAuyAl5SlBI6cWyTeE25naFY1ibiFcp0+lOcvbHCqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173738; c=relaxed/simple;
	bh=aFTnlgZyJVgOqbMLN1qe0Q+6k4uOL4xYMzEtvwzan9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhFCa/jpvdJ8KGZUT70xq1hABpRXp5siBQDureCgQTaVpSN3aZZj1jaQO+fGmw+byiLASPp7Gan9GhGCF7d/MIY+I6L3ZIsi6PETHrY8o6eS9ACEQypeuym9T2LvD/hdTD6DekeMWWeA4Xu1zDHgure5KvTvBEywTtOGYXPOGtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGsKRbCs; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBOmNUCiko82rv9LVX9wNkABiSJRPR/Vchpgv9t0iTUpHv4M/KmeJM/vLfH3Bl8+eaBv211FNwa7qo34u6cPzD5BulhoJcCN9WhvB7NErIdaqWBuWS2cAIRjogEsPxA+uMwzI33kWt/v9AdZu56wtLEjcyQLf5WObCwJJcMk9CHkwAjwilSa6oYMOcLJyGJeBGJdpl6AoBrKfKf6cVSljRJost/TE6Q9ruJzOlPFl0OEodzYsQcGM8PSChxX6LV/CNSqQWGS0KOWwMEjcTbHMleNP62HEnGNmw65VKVJiv0n4GeyZ/PAMJmFk8SedsOXoQkldSh+CnII4lLIxVLZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iYEie9d50w8ckXPabLzLcSTM6mmghmZks2wio3LNuY=;
 b=pmYMPM+zi0ptA1TSK1sIjTMnl4Jg+nulIl9DFDNhim7H4EEvnOl7BvD1FXluPf72xgU14NHfwYIN3M4/x2eC/THlVC9caLLXpYDdU3oyrcK792SKko7Xk1siRnVZU/YdL9OH++VeFdF7CLyc5MHv5lV4BgUTXrOPN5h58ci6kZ9kuHkFnBeq23PHbSwo5TyS18I+L2L6RZVmTY+18On+FEyQCPrYZrg+UbPsCs0OLB2unSlhK87bKmRhdErUEvwpwHsOH9BdI2ussbjh91xKhahSRV5ywD+EFFSiTC3RJ1oQiNqiC/CJOaNyW75WZiCt8NOxeS2MCrCT7rEjO2OhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iYEie9d50w8ckXPabLzLcSTM6mmghmZks2wio3LNuY=;
 b=DGsKRbCsXgfP27gX9sjuObQzIJHZjTn1+CRfIf+tRn2/uui/i1fZyzBpmOYl5hMdTz8M0vnyLwYR/haq3jbtopKzdt1D9kyNHAKZTixzm8O6keIjCpOt2kjLxuwNB2kvx0IoIW7oEt1FeD5cjH0yQ6IuaC+mUSDIGWlLxBqc64qOs7KW/MsBQ9yTnjd6wOzcTZ4SxPp9DHMMSblenr3/L83qLj9OWv9DqtCwiW1cz2ZpAz/107PSeL+RQI+8x+pLFRXFRHFfBD6By7/9xGWqxsPwwHeZGA4/PqX0XqYRMbDLnErmldZUzyP3e3nXNsZtpOTXoh/32gH9w828R8YufA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 02:02:10 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:02:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: thermal: add Tegra114 soctherm header
Date: Tue, 26 Aug 2025 11:02:03 +0900
Message-ID: <4679238.LvFx2qVVIh@senjougahara>
In-Reply-To: <20250825104026.127911-5-clamor95@gmail.com>
References:
 <20250825104026.127911-1-clamor95@gmail.com>
 <20250825104026.127911-5-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PNYPR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::13) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6845eb60-b0fb-4ab8-87b2-08dde4449154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjA0cjhUUjBFYXRCc1BvS1Y5WlF5YWtMSjdsVFQ1VlhSK0syOGZyN2YxbzFL?=
 =?utf-8?B?c1ZXWTlzYXhvOC9tZHh2VXFKTENFSlJKVW5SQkllNWZEVUtoNS9tRi9taG9C?=
 =?utf-8?B?bGhUcXlvMWRwY2N0bUlpd2QzOGhZWDBoeFRYNTZoMVlabW10YjV5RzlUZ0lu?=
 =?utf-8?B?amRudE8ySmpPTDZwbjZnS0krSG1rM25yOHlLcmhyUmUrM1dOVkVjRjBHSkdj?=
 =?utf-8?B?M1BSbDNRNnZuczlERWJIMVljMUpIZ25rMVprZTJ3RFlWWHlFSnc1M3B1SHpZ?=
 =?utf-8?B?Y0FJVHFBaW8wR0gxM1F6UkRvTzhDbHh1NzZXQi9iQnJZeWJmdzY1UUh6NElM?=
 =?utf-8?B?S0hHL2NlbmhZandrR0lwTm16TVl1ZTJqUUZNeWN5NUhXcWNLSmwzOUxMRk5z?=
 =?utf-8?B?dS9GVXRZcjI3N05lOTY4QjNvWTZxMG93alNlSUs4SGNHM3paS1l0WXptN3BC?=
 =?utf-8?B?MHgwQUh2Q2tCM3Y2UUM0Zy81ZUpJd3FnR0dEWHY3c1lnQWNnckF4bUdrcmh2?=
 =?utf-8?B?VFBRRHQ5RDhtL0FpYnA5YmhCMkZNc0ZhZlZROTVBV0VUVkx2YUJ2dTlnOWxS?=
 =?utf-8?B?VkFpa1FxUkZJUi9WMzU2L3E4QUYxM3RnbE9LaGI4aktxWGUwNXhRRDFPYnZn?=
 =?utf-8?B?NXRvbFZNdWRrbExoRGNLTWgrTGxUdVV2a2REOUZrVHlUMlZ2S1U2OE9wWGY4?=
 =?utf-8?B?NzNxYXNPM2paeWorWkJsbmMyNEwxN1NhUmgvaWxpNEZIUTVnWloyUnhZS2Qr?=
 =?utf-8?B?SkpHSndIZkdIdkd3RWtjSjhxNU16NU5GL2RTeFV5VkQ2TzlPeGVWR1BTbjZi?=
 =?utf-8?B?NWp5d2FnNlhFOHlPSXVUOVloOGxKbERHV0hoVjNLQ1A3eW9FT3ZqdVBnV0hm?=
 =?utf-8?B?cHRWU1I3MUw0RkVmLzdqMW9jK0pBOG00OUdXblY1ZmJIR1BsSGhkMlVtN0RB?=
 =?utf-8?B?UkVnZmRwVmhhd1lUYmlKaC90YmN4WmhaYkJITWgvYWhESjlzNGhTU0dVeVlZ?=
 =?utf-8?B?MldvZFMvazJjVFl6a2ovak5OaEREb212a3gxV1BaWHJZVTRyYU4rYUJSaXRP?=
 =?utf-8?B?eTIrOGFaY0NnYnNpVjhKQUVSakowZEJmL0xYV21XRCtEUkVNQ29EYTV6VlEx?=
 =?utf-8?B?dW85d1VtUExJV2t0R3plRzFERzNRWTk0VWlJaHREeWplZ2ZTUFJ0SUZiU0dz?=
 =?utf-8?B?bEdpd3d2eDVLNitqZlZkYlpLc3pnOEFpQkc3ZU5VUW5rNkFzK1djK3ltNjdD?=
 =?utf-8?B?VnZKSVRKWXpzZ2EvNm10TmpQWTN4OU5UdE9KNGRadzk2TDZFK21ENmQwdlVI?=
 =?utf-8?B?N2I3Nk1WMWwyMTBCVVJDdTFVUElJK3dsUGw5dXAvNVVxd3JHUitjWW5ycHBt?=
 =?utf-8?B?aU11NWVHaUdaMkxwMWszWmVwY2txRmhaVkJMZnJ6a3FLang5ZjM2WjN4VlJk?=
 =?utf-8?B?dkM3RGh4V21NUWRSRWtBZExCVXhveTlaV0FxRWwwM2k1ZWJrOWllTFJ2djFh?=
 =?utf-8?B?WmEvTHpvWVNLc0IxdHRVWStRdk10cWFEY0ROYUVBMGVMNGp6WGl5dFZQOU5p?=
 =?utf-8?B?blRrRmxyczVnR3ZIUEJ6WFdXS3hoYS9tNnRjK3lkSVM3dTJoV0UzWHVkcWFn?=
 =?utf-8?B?bUlMQmZHdFp2QndVWnBXNVg4RGFEMTA0UmRQQTRydTRvdXhGdk1LZVlSS3FJ?=
 =?utf-8?B?cWt4eGYvY0NUalpkdUVBMXV4Uy9IWThSWUlDSHhNeW5Kd0t2czRhVUw5WER3?=
 =?utf-8?B?V25ocEt1RmhpNzgxS3NRRzV4b3ZpKzh1RkdadjNDV2FRYVdEM091TjB4Q1Ju?=
 =?utf-8?B?NXVvMjdWNXUwdnhzV25TNk52OUQzdUZkWU04OVE2VlY0TW54YjZjZ0lxZWFY?=
 =?utf-8?B?WlFXb1UyNmlUeDRHbkdLaEdSWS9nbHBxK1R3bXRHTURiWFRZSUlUSnFoQ1Q2?=
 =?utf-8?B?QWhzZlJDbXVZRlB4cWhrVWtvc29yRUZ4NTR6cEFrVlhqRHl6NkEyVHFsdU9Z?=
 =?utf-8?B?WGplZmN5VzlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktUVmNJcWhlbWxkOGUvcEp6SElwRlNmRHZ2dWZBSURhbXdVd0RZK1U5bXcx?=
 =?utf-8?B?Qk5KaEozakFOdXFuald5VDZJazhOVy9IQVdtbWpvYlk0cU12Wm40VmFOckVU?=
 =?utf-8?B?eEllNVF2Skk3dWVRdU1LUE9wR2w5UXpZL09oT1FnUnkxTDdNRnhVbCtzanIx?=
 =?utf-8?B?ZjZNRVVNMlFDdGlJSGhlclh4REo2YkUzOVhwRU9VdHd0K3dlTGZXcytjYWp2?=
 =?utf-8?B?eTBjcDdlZUw2Z1FXRXF0ZUVVVTZPTUJ5NG0rUG9wYWhEam13U3hJUE1MbGE4?=
 =?utf-8?B?RHZRb0VjZEZvd3NIaXdTNTd2WGpSV2NCNjBDYlgvS2hHYWFtQkJwYSttSXMx?=
 =?utf-8?B?M1VBUkovRldXY241UE9LREIveUh1ZUx5cW10eGRjR3N5dU42bzNzb2FudlVy?=
 =?utf-8?B?UVhRN3F6LzkrNlViNm9KSzQ5cXlMeDBNRy9NWmsrOThYc1VzakNyR0RzRXFF?=
 =?utf-8?B?cjl3YUh2L1Noa0IrSWZrcUxQTlNialJrZFlkK1FYNk1ROGZoWnFPVTNha1BH?=
 =?utf-8?B?aHVyYnFSSi9mZkZxR0w3MVdRd1lJbGNFY3RveWQ3M29vd1VIZTVaS0Q3U0JH?=
 =?utf-8?B?ckJjNEF1SHh1S1EzOTlBUDQvZ1pnQ0k5WW9pNk5uYlNRU2h2UlIvZWdOdkhI?=
 =?utf-8?B?enNPc1RvZDVRRlRYTi9nRjZGdkxvSVZ5UGpNNE9mN3ZITkZaTFhUaW5VMjRk?=
 =?utf-8?B?UjM2REpGRzE2aFRIZnNMTFZoc3pRVWN4cHhML3h2blZ6MWhrak41VVJCVUJ3?=
 =?utf-8?B?VW9iRGlINEhQV2R4bEFQQUxiTmJUME1BOTl0TzU5bE9iS2pabzlZVHZwSzhz?=
 =?utf-8?B?N09VSG1qMGNQejc5V1crN2JQQzU4MytLRmpLeTRvQ0l5Y2ZEMmI3MFgzbjhI?=
 =?utf-8?B?ZlRNRDU5dTNVSGpTbExPcHF1N2Jwc0VsaHVFMzkrTnlKR0VPRGVyTW45Y0ti?=
 =?utf-8?B?V01tZEZSQlRrSnBQMjZtd2ZOamxNMmFsRmxJSWVzb0xOMGpsQnVVQXZBS2Ft?=
 =?utf-8?B?eE9GaTNkK0E3VkphZkZKVDZuUm1jWW0xTCt2Nmp3K2dSaEE1dk1SUlJMYVhk?=
 =?utf-8?B?SEkyd2RRUEVJN2NCdFJxclFyZDBST0I0ak5KRWdHY2xxMXhhUFZGWWhtemhG?=
 =?utf-8?B?OGd2NTBtb25MbTFId1BLYmZGVHl5d0RtNlpVU0RsVkQxT0lNWVE2c1lTZnU1?=
 =?utf-8?B?cDkwWlhNYnQ2Si9LbnhYUkZXWDZRQkxHa1ZPZG54UThPNjJMY0hXVGF5Zk5k?=
 =?utf-8?B?ekpxVmV0Unh4UE91RW9BNU1PUHZEZzRQSmVCRXJ2dllIaXpHUVRYN2lHSUJG?=
 =?utf-8?B?MXdzMnVKeWlnQTNpbUNWWVFmNnBvYWM0M2tER0kxeHRFcmluVStNQXJyZVpL?=
 =?utf-8?B?Zy9kcWgrM1Zxd2JjS0p2S2VVK01QaS9Ja1AxaCtFd21BcnNsU1BVdk9Id09P?=
 =?utf-8?B?RDc4ME5iMkJLc2IxdTdmdFBoTHhKQmpGbzFmSkpBVjdqRXhCTnRLM1dYYm9r?=
 =?utf-8?B?a2VRdmxlWGZ5aWFkVE5xVWp5aEREdkRpYURZYWdQeHUzM21vUTJoYWI1T0ow?=
 =?utf-8?B?VjhLVVhSSDh3bXZzVlR1RzhFR0FJK1l6ZFNuR2l4cGZFcFBsODR4TFFEUFFY?=
 =?utf-8?B?SWxvbW5ZTHVsWkdIcFVYd3ZDbGxUTzV4VkRCeEduR2JUdDZ6K1AybjJ4NllV?=
 =?utf-8?B?TFkxL3pVbC9TWW95aWhkeUEwZVN2TElMblk0Z1FjTEo4UHIvaE5najBoUmRP?=
 =?utf-8?B?dnpta3UzdWVSdUtiaG14RExabGNsVURLd1h0bTZBMzRhYUhXT20yUGFpSkVE?=
 =?utf-8?B?MHprb0J1dzhkVjJGL2JrVnV3ZlJnRzZxZXh0ZWcvSHd2NldyUVBiYjYzOUJJ?=
 =?utf-8?B?eWhBRi9US0cweWU4dzV6anlCUHJaUVpQTEs4bzRXc2dHYndmc2s4S0RSRTU5?=
 =?utf-8?B?NG44Skh6Z1F4NFVOelRGVVJYZlAzY09ydW8yWUFYVzM0djh4YjBqZ1JjUFlm?=
 =?utf-8?B?cVBxMUt2VnBHZ2xxRmx0NnEzZWV6bXB6WTFFTHhPZWQyRktZdDV4UEdocXhM?=
 =?utf-8?B?TDhmQStFMVlLM3dwM09xeC9xb3RSUjlQWHdQUU92dnF5THllVmNwUVhsSmhF?=
 =?utf-8?B?SkQ0MjJxM0VKV2E3ZWlRU05BOUVickpRVys4azNnT2hLck5nRjJwYnhJcVJL?=
 =?utf-8?B?ckVoUGU3ZGxVL1lXWGRHYStzVitrY1hjaVZHMThudGhVZEFLb2JYdXpna0pP?=
 =?utf-8?B?RnNCYmUwckN5MHp2c1Rsa1lzRzhnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6845eb60-b0fb-4ab8-87b2-08dde4449154
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:02:10.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dSsZiU+RNRMZ93BaIs84P4kzNsFjn+rEzaqh3/aBdJAFKKtOeSV1ng7Qi15tivRU+OEJvbaCmmqDCzvZsOECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

On Monday, August 25, 2025 7:40=E2=80=AFPM Svyatoslav Ryhel wrote:
> This adds header for the Tegra114 SOCTHERM device tree node.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../dt-bindings/thermal/tegra114-soctherm.h   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h
>=20
> diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h
> b/include/dt-bindings/thermal/tegra114-soctherm.h new file mode 100644
> index 000000000000..b766a61cd1ce
> --- /dev/null
> +++ b/include/dt-bindings/thermal/tegra114-soctherm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides constants for binding nvidia,tegra114-soctherm.
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> +#define _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> +
> +#define TEGRA114_SOCTHERM_SENSOR_CPU 0
> +#define TEGRA114_SOCTHERM_SENSOR_MEM 1
> +#define TEGRA114_SOCTHERM_SENSOR_GPU 2
> +#define TEGRA114_SOCTHERM_SENSOR_PLLX 3
> +
> +#define TEGRA114_SOCTHERM_THROT_LEVEL_NONE 0
> +#define TEGRA114_SOCTHERM_THROT_LEVEL_LOW  1
> +#define TEGRA114_SOCTHERM_THROT_LEVEL_MED  2
> +#define TEGRA114_SOCTHERM_THROT_LEVEL_HIGH 3
> +
> +#endif

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




