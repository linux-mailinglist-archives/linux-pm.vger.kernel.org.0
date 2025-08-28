Return-Path: <linux-pm+bounces-33225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D111B3960F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62511898D86
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1CD279DC9;
	Thu, 28 Aug 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cY9fu5nO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2031F8AC5;
	Thu, 28 Aug 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367891; cv=fail; b=qERMvylx1GOcEXu/ulEL4zR2zNon+2Q8iTegRPhGfGiMX0NKGVujUDsdfvu4TZJ97MK3B30oEfHldQ64XBqTPjI/4hamKr8yM5fPVrlwMZFm0B/lsMqCSUw2V/XxELRtK6dFo3KC/6VEK2QfbFzSf9t+V2act2S2z/apzoyhscw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367891; c=relaxed/simple;
	bh=W4FtYF+4TAVZf25OjwnsOYYFFlTC7+mqrArZMTfU46g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkRbXgEdlUev8ZIxE3EI/no2eJvaaI18W0/PNHXIPCLX+QTvNkkvypk00QhCzuRUAL065Xj7nghZJSS2/BBHzwialAlqPc7eU9cQor2C9yd5ptr73FzRZwK9YyVF+t+c4Rw5sAIHUSo/v4MYhpWtL5+z9ITw6wuln0qxxsA9oAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cY9fu5nO; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw43iuBP1gBjRGmXcNDychEzsZV0vL+O7Ta6Lrr3NgRRALAFwOXgE4vO+hDB1CiOuWB7F9PKMz7oRmfxbMwgGB61SvV+ce54edsGBPzNHzHowFjDfJXIE6ABwDYVBWAMKh58omB9Hbbps0/Wko6S/jt4ri6BYwRT9qU/xGp1eEYRoC86GXtyxxxCZYhbZrQFEv+dWVXOva2M9PZm8EZFRjBJAd9jA/xr5p/RtIm6KEXOw8tu85dUJzkeD3qxe63iZa9y8ml69hzkR1KjdPAygwENuMuMe9O6B0LKblTTCu2NeFlEu7Ay1r+tcx35YxF8u+BF1IvsOHDhyE7KSfMI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUnkCgTQfiH5CbXaOvxbwiRkKsMMhQ57KQrea7VEGNY=;
 b=yNhmwddfkDgsHWb1ZcZtxksHj8XE2aPPqVL4jMHngQiOiUWcdtCeuQMt/WKfF8/w06lEsWy6OCFjxzZwRHtebdUmAdOAmlGIrrhV61hlQRo2atQo5bJU6CYcxI/q+VFU72ZGkmJ9O3AUxHzE/Om7fXu6h1wsmB9lHSdwoPivzq9m/+lPhJM6tLWXX7OvtnaMhTC/RAJ6pufFCp6aXCsUhj+HxXktsTWX9KNTTaLjK6cCW1DWEbRBLbhpCEy8L7VbAkC7sKRklu++4W+pwp7mZtdaUUiqDbp7+F0E29ZdzyENdn7qLJ/wRM07ZuZFrK9Y+SddhgS7F53JVQyclTHlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUnkCgTQfiH5CbXaOvxbwiRkKsMMhQ57KQrea7VEGNY=;
 b=cY9fu5nOGzPR54Vtsxs2yyu9DBORmUJ2MSeBOFZxTQIqdyJI2yIT7Qlc5IHs68TfGgZNNzkuqfkQyXso59Un7Xb7FwMsnwM1fxE1tUZaB4/bPyoEBcZPIdHmf/kS2tKQ0ltQV1ue0tyeOgOA2D7hT0VmKvzoV2N45VCL6g5VCwIvRqePQ9kW8Gs639M6SpjyA8stpGDXoWQClAmzni0jAVYfCoGooK0ePFmV3L4Le+grljHKyIfO8qgGJA5GJgluEMkIKwEgS+Qj1WxA2amCbMngNtwhKOh0dWwrVO4SELTgokQt13KEEdDnrd6GfR6kAYMOA/gs1hu/67a7rHbY7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 07:58:02 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 07:58:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5 5/6] thermal: tegra: add Tegra114 specific SOCTHERM driver
Date: Thu, 28 Aug 2025 16:57:59 +0900
Message-ID: <3366819.oiGErgHkdL@senjougahara>
In-Reply-To: <20250828055104.8073-6-clamor95@gmail.com>
References:
 <20250828055104.8073-1-clamor95@gmail.com>
 <20250828055104.8073-6-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::6) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eae2be2-b0e9-449a-11cb-08dde6089ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTEycXNaWHpFcUZZcXZGRTIrckdqbTVBUGNXN0xaeDdiMVNZdlROZytqV0tH?=
 =?utf-8?B?VG1sRHZ6cUhtSnFNYzZmMXZrTkJwemdTY01FRVFONWpqaS80eGRmTGNUelpL?=
 =?utf-8?B?OEczeDEzYUlsMThmcDMycWVySlJnQ1JHaDdjT1hDZTczZ1dxa2Y3amhMNklj?=
 =?utf-8?B?VVJBRmJKTzlUS0ptV1djRXRuV092T1c5MjU4T1NGZDA1K2ZkczczcUltYy9o?=
 =?utf-8?B?dWRXTkJCTkRveTlvQnRReWE5SHBVS2p3SEFOb2RCK0I1R3k5dHVIazNaMHQ2?=
 =?utf-8?B?Njl2NW5XRyt2K3h0N3VtbDVFdWx5aWppWGF4WHQyV2lVTlVueko3VGNmbG5z?=
 =?utf-8?B?ckJOZ3BiajhuTUhmTGhDU1Q3RXJQSmhlY1Y3VUZ3V2ZrNmVwWEs5Q3RCZ3VR?=
 =?utf-8?B?cHlEaUc2bmZDSitFQ2dkRmxXUFlYRXR6SEh4aWtFR2hqM0ZHRVZsTDMwYWJL?=
 =?utf-8?B?MjNWR0pxWUEweUZUOFZMUDBITnp6K2VtTXBzVjhxVnlqeWc4eE1zaGJCeTEr?=
 =?utf-8?B?elIyVnRHWjFvdjZUbm8ydmQrRFJUWFNPS1U1RzV5TUhUY2tLU2tkSWZHc0Fv?=
 =?utf-8?B?UUtESis1QjhCa2FUL1JNU2FuK2VxNjErUStLaGgxdXVETFF5WTJsb2E0RWIx?=
 =?utf-8?B?UzJNOE9Rd1BDVzJlQUcvNnBpUlZDakNabmJuMkozVVVSRWlnaFUrdW51cnE3?=
 =?utf-8?B?MXBSelVuazViVFptdk5WMDRKSm5aRmJrRFFoWkpvazd3RjNqQ3FxdVJETVM3?=
 =?utf-8?B?U0E4enhNeUQ3R3JTTUVmS1B0bWFkR0djQys5Q3hjakEvZm5QWkdNTHJ1djNn?=
 =?utf-8?B?ajNCM0c4TEZwODFEMzJWTlBCSWJheUtDWGhDN1o2VGdESWtqWXE2RU56Q2h3?=
 =?utf-8?B?Uy8wRWE4S0xYNGdFbFhYRTNTeSs2VzVNdmlzaVB6cDhCRE5WMUpYTGx1WEVX?=
 =?utf-8?B?ZjNOcVUxdEdSek1TTjFaVklma09oOFdIN1dxYks2RkRoMnlLa0FoSm8yTGtS?=
 =?utf-8?B?bnJMMTRxT0lDanl6ZFRGT3ZnRXNHOGYrUU1pY2tzV1dleFEzazZCd3puM04w?=
 =?utf-8?B?Q29sbHVKbUNjNm1BWjNadUEvbnc5c2ZLMjAyYVRmODNvUmhTZElIVGhsRmtD?=
 =?utf-8?B?MEpmbC8yYXd5SnlzTWp3bGtVZVdyeXM0T0xWaVZXUk1RdzZTZG1ibURNRXZa?=
 =?utf-8?B?NXNKbmwxZjNNYW5LZTJyMUdzK3EwVzdCWU1ZMGNDekRDSlhURlFhT1VXTmJU?=
 =?utf-8?B?T09Vd2s2a0JnK3RvZkxKQzNTZVNETmxaS1BHSCsxOHNXNHFOU3NaSVFnUXQx?=
 =?utf-8?B?U0pteU5idXdmUnhzUjZqTm5BazFwcHNOSVpRZnNHWnoxNDJtc3RwWExDMG5J?=
 =?utf-8?B?OHVBaTg5dENBY1R3Yjc5RmIzN0ZqMjJMekNNVVJSMEJIYmVqeFVac1Uza3dl?=
 =?utf-8?B?WkRySVhpdC9peUVKMFhMZ3JZK1R5UUZFb1V2eWk1TlA4Nzh5NGRYbUtzc0hQ?=
 =?utf-8?B?TmhVbVBUZlBvUU1uUTlVbCttYTRNM3M5Z3htN1luK3VDQ2IybjJXRHVtaG1w?=
 =?utf-8?B?U05JZ1crWDZacjN1K1M1ZXNibmhCWnpzcjV0ZGl1azMyTEtoVUUzY3lYajI5?=
 =?utf-8?B?NXprWWNKekV2UVNkcEVFNWJCWXhMTFdDN2tTZkVrZTRNL1NVbzVlVWkvOUdM?=
 =?utf-8?B?N2FPQnVESDQ2bXA5ZzlDZTVrYk10cU05RXIzdnNpV3VVNUVjcGZNRUZ0Nnha?=
 =?utf-8?B?WHBsMnIrbWt4SllzQUl3dUVYUFJYRE1MUG5UMmhxalluajQ1MWhJNy9YY1Ja?=
 =?utf-8?B?anpNcG9yWWxoa2xYVEhia0trY1BSQ01xeGhpYVY1R0kxa3JmMGZwZ1h5VEo3?=
 =?utf-8?B?dmZJc0w1ZGpOZklpeHV1SlVoOEthRTJBZ01KRmxsVFVOeTg1Y2syOHF5ZzM5?=
 =?utf-8?Q?reFoF7jBcmCLJa59BYvzTxhRFX+mYp80?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vjd3aXdhL01PRWg4U2hUY21DV3kvSGhFeFRha0UycTZ4STZCRms5azFJK3Qr?=
 =?utf-8?B?bWpXTWJYb1dtdmI5eS9lQkdGci9YN2xOYmdLZkNyaWFQNE80OG05QUptcENN?=
 =?utf-8?B?cElYOS93aFpkWDNSSE9ubUFiUzIyMVZWMXlVM09GNmRGbSs4VWlCbnZPalVF?=
 =?utf-8?B?R1pCN2xRelFjL1JkOENESkMyNlNWL1B3aUlLaDF3TDlqODhYcEZCSGJSV1hn?=
 =?utf-8?B?Wm5xUXlUTllJQVpTcnQrTytvSXhXS3YzVmNib1h6cWh4b2dyUnVKQmlLdHEy?=
 =?utf-8?B?T0JWRE5aS3dQSmZlSHpYNUx3YmIrV2s0QS9vSmpHWFFIWDI2VXVVc2Q4U3VP?=
 =?utf-8?B?cjJ0OG5HeVdTV2xCSC91L3F5RGxDVzNZSklBcW9WOXFjSDZyY3ZUbDBPcUE1?=
 =?utf-8?B?eDJ4NlIwQWtnZ3RuT2djK2Y0VURPdHNCOGlmQklEY3dsdzgyeUN2MnA3dUdx?=
 =?utf-8?B?Tkg3T1hMQnZRYld1cVpVckxjUGZOQi8vNERPdHZRU2dUUWlOckpwM1ZEd0ZG?=
 =?utf-8?B?UzlyTElGazhMTWJjSmt5WmMySlljN21sR3VIb2s1TStiOGFWcnQrbEJuTTNT?=
 =?utf-8?B?UUR1VkZmSy9WdW5mazcwSnlJbzd2RkxIM3BqNkJWc3VmSEplVkRxckZVVDUz?=
 =?utf-8?B?MmRrdVEzWEU0elFaQ2RKVGNzMlM1NmNSVCtSd2NDY2t4N2RaZjBSOW5qV3N2?=
 =?utf-8?B?Yk1DWkZLdEFJNnRVUUNKMG1JY2ZKVXNwa3NQay9uRXZXQXVnL1FKdHZGMUJu?=
 =?utf-8?B?NFUwMStPQjhvcWNabHZjeVM3REFZOEhGYXBWTFQ0UXdFZGN0U0g1RjkvMngz?=
 =?utf-8?B?bE9tVWtmYWJnQjlpdnJuc1VkblBxbFFramdrVlNEbkJZOUxPaHR6c1JNcmlx?=
 =?utf-8?B?WEQ0YmsvZUxYR3Jtazl2dVJuaWxNbnFoemlqelkxc2xtSEJiei9CTHFIUy9L?=
 =?utf-8?B?TC9LZkpmL2VBNm9xODZkaTZzZGlIRndmRndiRFdYL3JibHR1aFVhRVl1V1dw?=
 =?utf-8?B?U2RQZ0IrVTJHWTRYQ1ZLN3loZzZaNHVjdkZLM0pGd1dUTTQ5cWV3VEdYTDZj?=
 =?utf-8?B?ZUFhaENIc2QzNW5xVW8zQUJyNHd2UVQxamxhdytXbXAwRnhOREdYUGlwUm5K?=
 =?utf-8?B?UFpGWXQ1WUN5MkczelBNMDd3WlorT215WXFPOUxkVnlEdDVRUUZ2ZEhhYW1y?=
 =?utf-8?B?YWFuaVJ1T1lJdEltVDdNWnY1aG1qbS9SQjFuOWxORE9EaTRoTjJtY0dONktv?=
 =?utf-8?B?QlJ5ZlRKaW83bk9OeFJ3K1RmZzFHQnhnOHpjNmtrdjNheGFYVjJQRU9CaGR3?=
 =?utf-8?B?VWxYcW1xUTN4WnJEWDU1QTF0NFllc2IrQkJ3WTN1YmJrWFJBTWNyczNzVVd2?=
 =?utf-8?B?M2QxQmllbjB2Y1B1NEFxZ2lzdHNiZDMybnI2VFdnS2tFRGRyYXEraUt3a3Jo?=
 =?utf-8?B?b1VJdGtSU05lQ3hHRlh3VDZNckxUWUdwK2xEZGFZcGlrYysrbzhtTnlJaUxI?=
 =?utf-8?B?MXk0V2V6cWd4akpOT1BBNmtNekFPbG51UjM0UUtMcU1BcEZjSDduRS9lZWdy?=
 =?utf-8?B?R3pJZFFkcUxjZysveVpxOUtCY1ptWU1iVVlKaDVTbWtUVzc2S1NZN2ZlZXpz?=
 =?utf-8?B?dzU3RWNqRjdMWjdNRGkvNnkrdDBIY1dzeUxQYjlWNlYxamkvYlp5dzdIcXhi?=
 =?utf-8?B?cVNBNDl5MENoNlRCZmVYUFg1Vk9qSkR1bFVYYitwTlM4TkF3UEQzcmpTV0cz?=
 =?utf-8?B?N2VxVW5rbFdXK3NrMmU0NGJScmZqdnQxbUNKYWR6VWdxTCtiNGp2MWZzWE5N?=
 =?utf-8?B?cjVYdmhCMXlZTE9qRENOQXRwUGQ4VzlZbDBualBjRTN5SWlWQVFISGZpZnlY?=
 =?utf-8?B?dXdWWGVWVjFHM08ycUJwblZEUUMyeUtnZ3VJVGRtMFZpdEVEMEw3Q3drMGFk?=
 =?utf-8?B?UFZkekgzQkxzb0ZFMUZCU3VseHpLZkZlUE5LT2Y2QmwvMXArWXE4K1VxNUVL?=
 =?utf-8?B?UEVMUkJ4TDFWM2JHejlET0JDMUphb0VhbllVK01sQWc2NDFZWEpsbkJmakJr?=
 =?utf-8?B?OTd4V0xPTCs0dllwWWhDK3lGVmQ3VWUrOGRVNFVpMm41K09VcGNGVG81WHdW?=
 =?utf-8?B?Sm13MEN3MFBxZUI0ZkVpR3JnQzg0dnRYQUdvVEdlS0xXNkVGNU9TUzRaaXc2?=
 =?utf-8?B?WFczbm84STNzRWhGbWNoalhRVDVwbjlFcU1Pc3hFOVZ4N3FrSXZTT0c3RU1P?=
 =?utf-8?B?dURzUVBhSDVLTVZmL29vRENUbkp3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae2be2-b0e9-449a-11cb-08dde6089ced
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:58:02.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pknYdol3OUwJfPwPBkqL3P9bo6BCuT60Q6rY8RyJrbuOwSmmlPoLCdDRTzljl5eWyduH8UuquRH36Qfk21Gs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

On Thursday, August 28, 2025 2:51=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add Tegra114 specific SOCTHERM driver.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/tegra/Makefile            |   1 +
>  drivers/thermal/tegra/soctherm.c          |  13 ++
>  drivers/thermal/tegra/soctherm.h          |   4 +
>  drivers/thermal/tegra/tegra114-soctherm.c | 209 ++++++++++++++++++++++
>  4 files changed, 227 insertions(+)
>  create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
>=20
> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makef=
ile
> index eb27d194c583..9b3e91f7fb97 100644
> --- a/drivers/thermal/tegra/Makefile
> +++ b/drivers/thermal/tegra/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_TEGRA_BPMP_THERMAL)	+=3D tegra-bpmp-thermal.=
o
>  obj-$(CONFIG_TEGRA30_TSENSOR)		+=3D tegra30-tsensor.o
>=20
>  tegra-soctherm-y				:=3D soctherm.o soctherm-
fuse.o
> +tegra-soctherm-$(CONFIG_ARCH_TEGRA_114_SOC)	+=3D tegra114-soctherm.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_132_SOC)	+=3D tegra132-soctherm.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D tegra210-soctherm.o
> diff --git a/drivers/thermal/tegra/soctherm.c
> b/drivers/thermal/tegra/soctherm.c index 926f1052e6de..bd1919f70860 10064=
4
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -31,6 +31,7 @@
>  #include <linux/reset.h>
>  #include <linux/thermal.h>
>=20
> +#include <dt-bindings/thermal/tegra114-soctherm.h>
>  #include <dt-bindings/thermal/tegra124-soctherm.h>
>=20
>  #include "../thermal_core.h"
> @@ -357,6 +358,12 @@ struct soctherm_oc_irq_chip_data {
>=20
>  static struct soctherm_oc_irq_chip_data soc_irq_cdata;
>=20
> +/* Ensure that TEGRA114_* and TEGRA124_* counterparts are equal */
> +static_assert(TEGRA114_SOCTHERM_SENSOR_CPU =3D=3D
> TEGRA124_SOCTHERM_SENSOR_CPU); +static_assert(TEGRA114_SOCTHERM_SENSOR_ME=
M
> =3D=3D TEGRA124_SOCTHERM_SENSOR_MEM);
> +static_assert(TEGRA114_SOCTHERM_SENSOR_GPU =3D=3D
> TEGRA124_SOCTHERM_SENSOR_GPU); +static_assert(TEGRA114_SOCTHERM_SENSOR_PL=
LX
> =3D=3D TEGRA124_SOCTHERM_SENSOR_PLLX); +
>  /**
>   * ccroc_writel() - writes a value to a CCROC register
>   * @ts: pointer to a struct tegra_soctherm
> @@ -2048,6 +2055,12 @@ static void soctherm_init(struct platform_device
> *pdev) }
>=20
>  static const struct of_device_id tegra_soctherm_of_match[] =3D {
> +#ifdef CONFIG_ARCH_TEGRA_114_SOC
> +	{
> +		.compatible =3D "nvidia,tegra114-soctherm",
> +		.data =3D &tegra114_soctherm,
> +	},
> +#endif
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
>  		.compatible =3D "nvidia,tegra124-soctherm",
> diff --git a/drivers/thermal/tegra/soctherm.h
> b/drivers/thermal/tegra/soctherm.h index 083388094fd4..aa4af9268b05 10064=
4
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -142,6 +142,10 @@ int tegra_calc_tsensor_calib(const struct tegra_tsen=
sor
> *sensor, const struct tsensor_shared_calib *shared,
>  			     u32 *calib);
>=20
> +#ifdef CONFIG_ARCH_TEGRA_114_SOC
> +extern const struct tegra_soctherm_soc tegra114_soctherm;
> +#endif
> +
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  extern const struct tegra_soctherm_soc tegra124_soctherm;
>  #endif
> diff --git a/drivers/thermal/tegra/tegra114-soctherm.c
> b/drivers/thermal/tegra/tegra114-soctherm.c new file mode 100644
> index 000000000000..688104f28052
> --- /dev/null
> +++ b/drivers/thermal/tegra/tegra114-soctherm.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/thermal/tegra114-soctherm.h>
> +
> +#include "soctherm.h"
> +
> +#define TEGRA114_THERMTRIP_ANY_EN_MASK		(0x1 << 28)
> +#define TEGRA114_THERMTRIP_MEM_EN_MASK		(0x1 << 27)
> +#define TEGRA114_THERMTRIP_GPU_EN_MASK		(0x1 << 26)
> +#define TEGRA114_THERMTRIP_CPU_EN_MASK		(0x1 << 25)
> +#define TEGRA114_THERMTRIP_TSENSE_EN_MASK	(0x1 << 24)
> +#define TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK	(0xff << 16)
> +#define TEGRA114_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
> +#define TEGRA114_THERMTRIP_TSENSE_THRESH_MASK	0xff
> +
> +#define TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK	(0xff << 17)
> +#define TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK	(0xff << 9)
> +
> +#define TEGRA114_THRESH_GRAIN			1000
> +#define TEGRA114_BPTT				8
> +
> +static const struct tegra_tsensor_configuration tegra114_tsensor_config =
=3D {
> +	.tall =3D 16300,
> +	.tiddq_en =3D 1,
> +	.ten_count =3D 1,
> +	.tsample =3D 163,
> +	.tsample_ate =3D 655,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_cpu =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_CPU,
> +	.name =3D "cpu",
> +	.sensor_temp_offset =3D SENSOR_TEMP1,
> +	.sensor_temp_mask =3D SENSOR_TEMP1_CPU_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_CPU_MASK,
> +	.pllx_hotspot_diff =3D 6,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_CPU_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_CPU_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_CPU_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_CPU_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_CPU,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_gpu =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_GPU,
> +	.name =3D "gpu",
> +	.sensor_temp_offset =3D SENSOR_TEMP1,
> +	.sensor_temp_mask =3D SENSOR_TEMP1_GPU_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_GPU_MASK,
> +	.pllx_hotspot_diff =3D 6,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_GPU_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_GPU_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_GPU_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_GPU,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_pll =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_PLLX,
> +	.name =3D "pll",
> +	.sensor_temp_offset =3D SENSOR_TEMP2,
> +	.sensor_temp_mask =3D SENSOR_TEMP2_PLLX_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_PLLX_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_TSENSE_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_TSENSE_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_TSENSE_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_TSENSE,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_mem =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_MEM,
> +	.name =3D "mem",
> +	.sensor_temp_offset =3D SENSOR_TEMP2,
> +	.sensor_temp_mask =3D SENSOR_TEMP2_MEM_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_MEM_MASK,
> +	.pllx_hotspot_diff =3D 0,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_MEM_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_MEM_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_MEM_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_MEM,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group *tegra114_tsensor_groups[] =3D {
> +	&tegra114_tsensor_group_cpu,
> +	&tegra114_tsensor_group_gpu,
> +	&tegra114_tsensor_group_pll,
> +	&tegra114_tsensor_group_mem,
> +};
> +
> +static const struct tegra_tsensor tegra114_tsensors[] =3D {
> +	{
> +		.name =3D "cpu0",
> +		.base =3D 0xc0,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x098,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu1",
> +		.base =3D 0xe0,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x084,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu2",
> +		.base =3D 0x100,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x088,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu3",
> +		.base =3D 0x120,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x12c,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "mem0",
> +		.base =3D 0x140,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x158,
> +		.fuse_corr_alpha =3D 1000000,
> +		.fuse_corr_beta =3D 0,
> +		.group =3D &tegra114_tsensor_group_mem,
> +	}, {
> +		.name =3D "mem1",
> +		.base =3D 0x160,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x15c,
> +		.fuse_corr_alpha =3D 1000000,
> +		.fuse_corr_beta =3D 0,
> +		.group =3D &tegra114_tsensor_group_mem,
> +	}, {
> +		.name =3D "gpu",
> +		.base =3D 0x180,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x154,
> +		.fuse_corr_alpha =3D 1124500,
> +		.fuse_corr_beta =3D -9793100,
> +		.group =3D &tegra114_tsensor_group_gpu,
> +	}, {
> +		.name =3D "pllx",
> +		.base =3D 0x1a0,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x160,
> +		.fuse_corr_alpha =3D 1224200,
> +		.fuse_corr_beta =3D -14665000,
> +		.group =3D &tegra114_tsensor_group_pll,
> +	},
> +};
> +
> +static const struct tegra_soctherm_fuse tegra114_soctherm_fuse =3D {
> +	.fuse_base_cp_mask =3D 0x3ff,
> +	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x3f << 10,
> +	.fuse_shift_cp_shift =3D 10,
> +	.fuse_base_ft_mask =3D 0x7ff << 16,
> +	.fuse_base_ft_shift =3D 16,
> +	.fuse_shift_ft_mask =3D 0x1f << 27,
> +	.fuse_shift_ft_shift =3D 27,
> +	.fuse_common_reg =3D FUSE_VSENSOR_CALIB,
> +	.fuse_spare_realignment =3D 0,
> +	.nominal_calib_ft =3D 90,
> +};
> +
> +const struct tegra_soctherm_soc tegra114_soctherm =3D {
> +	.tsensors =3D tegra114_tsensors,
> +	.num_tsensors =3D ARRAY_SIZE(tegra114_tsensors),
> +	.ttgs =3D tegra114_tsensor_groups,
> +	.num_ttgs =3D ARRAY_SIZE(tegra114_tsensor_groups),
> +	.tfuse =3D &tegra114_soctherm_fuse,
> +	.thresh_grain =3D TEGRA114_THRESH_GRAIN,
> +	.bptt =3D TEGRA114_BPTT,
> +	.use_ccroc =3D false,
> +};

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




