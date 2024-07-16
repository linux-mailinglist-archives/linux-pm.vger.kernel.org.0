Return-Path: <linux-pm+bounces-11152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6059B93268E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A041C20B2C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F0198A2A;
	Tue, 16 Jul 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TM1Gmtj+"
X-Original-To: linux-pm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2069.outbound.protection.outlook.com [40.92.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9184C7B;
	Tue, 16 Jul 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133096; cv=fail; b=A3HSLolqRqy8MkBKsjarR78dJRPoQ6KQSv9/WhRujECHUhtrxZGewkXT8ilm1143EY+Izs05pOoP3967/MqkyQzKV0NRtkhlwGGB+0F7x8gu+zcPAENejgA/M72KFkfuNta3ODOhzKZaqp2Avlr40GDSi1diCRKO+DsrgEiKML4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133096; c=relaxed/simple;
	bh=Lu0UlDPGGeqPlxpmytJYfSTeXTgwOJeKv4K5Yhie7Lo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLNx5DGVW9cwDB1szVGzvMsA4zXPkP/ErzFAbc5h/hmdGjjQdKVveT3ZVvpDZBlQ7x7wshG0IVc7JAN+6QKgOoF/kHZWfmm8h3n9dsj+OxT6oLtUoSlHEocizpG1MZwztKhbIGQ3EYfjz5CN8CtLKfJ6uYFXNQr13pvy9nTxmko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TM1Gmtj+; arc=fail smtp.client-ip=40.92.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZo0CSRwYzgwYDr2gjy8FKHRssqIP+C4fV/BQ+0BYK8b6WYtPvrPRWh91HbnCn/ZCCSutak/et8WgoHZ/aa8l7ivp49RN82HpJsxhqOPPSYJPbBiSf1o58pr0RtsqF2v5f/XxUsV7ghtLVvNFTPeaKblPI+cvOyTzH9EmM0+9B3qXYcaMuZLoLtDRuxr3p0x4RMGCXD29WF8kQwh9YhgXPHjK0DcmUN68qgOjvcvGqusYz3Qwy9unhpdRgJtuDEUgfvAG96bz4HE7fTLQ7SF3WPb/ey06b6s6zmH7G9xSl1p6cAQgp/sGnlx3sdaLkoF4db6WdQnchkH7uost6NkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lb998CHZzP9AP49vMUZogm3bl4ZmNxrgcsZZqpXSEk=;
 b=dJ2AWTxScGj+0FRIQYnuE74FeOtmdzBb0Ru2hqje+VFV5IPLOP4Q0xVHekW9T/f3ZGoQrqC9Li4pEZptN5yCP9S4lWCLFesP0nofJ8XecXEdGdjCdFEMcWjlU32ZYuH9baQAYR1ucjGAtocOcaVNBa+vyWowvq/6uHofXfZX9J6r3bBzrVcQOp5FqQXXJr8GsdWEJUiDyvpK5pDAypIKZ1shVRx6WFP/78+BRDxNLNDCKpRNwbuHHgVy4bOmkt+pAXB6HZqTc37E4WJuIx0hVGdvqEWlWlLw/j9eCwXs3r8NFilmQhX5aERoryVaYOiGKGJgKI+cQXaeqaLfYvvX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lb998CHZzP9AP49vMUZogm3bl4ZmNxrgcsZZqpXSEk=;
 b=TM1Gmtj+X5rXkJkRCQNBZ34ZsfES7ZL3Y35j0CG9M2TeJ1uQ9P0MM1l43imgS0gjK1Cr/HHPbt82Q/wACyDdRSXwuAxX4k7ueMHNf0ge59zobujzF4AYqUG3eBAAPN0YXklkrJp3SLvNr35JnQzQzxr+XAPsG9jmwbO39OtxwTzANqBy03aZptkGHQc4pdPSC09BuwUXsRVRKi9tqhmUvQ9a8RmeoHprhDYaUGJbcrk99rP23QlpX4wr53ZFB65mY1zTpHpoWivL98pgDwkGe3kFPQ570j+8wZ39HGs4nYxCJ7S8BM6tk7UI02DDIjz3inHqS2Fy3u+84QKiJEZ4ug==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1305.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 12:31:26 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 12:31:26 +0000
Message-ID:
 <MA0P287MB2822D6D2EE89DBFBF4835678FEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 16 Jul 2024 20:31:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] riscv: dts: sophgo: cv18xx: Add sensor device and
 thermal zone
To: Haylen Chu <heylenay@outlook.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42211B13FF62603E3E18B8DCD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <SEYPR01MB42211B13FF62603E3E18B8DCD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [jvB/P+SZCtXiWlqRZ249doPujEUJJ7LR]
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <178e4d7e-69dd-4564-88ee-6383c65042dd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: eda397d9-d56d-42c7-7670-08dca593350e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|4302099013|3412199025|1602099012|440099028;
X-Microsoft-Antispam-Message-Info:
	bI/ykK5P4xn/Q5NiSuGNlFUfxgF6FNQjTWbm+7dpf0Akv0CaY95hGS6CkBayOjSZEQ9h/6m037MvkgBF4PSNU8jsApYJFD3gQFWRGbLlKkbGaW4hM2pMzSv81ELvgPIN7lCqSB+KcsMeBUd5+RxGIa4IUudkZjEjpegd5MjfwAuceLvClwF9xPdtY8VkEv2Xtq3biq5A0xYF46r+arvMfFUXd7VKmEwshStF0oxOphfgF/i53kptJZ9IXXKlr2G/vh7+2K5vG2SAdXws2FAYhGArNALKlWURfYi4rjDqVPntL0E3MhhSEpm4T0fXFIm2oFKuxvpJrboyJDMSkbP3uE2HPKsKZhkzQ99RhLzv7fsIyCxZSWZaQDvevREI9PTQiijeBGUpXSr1LJmNWiFFIfwpl27JWaY2JPxhnXsUSRe+7AfDqFaFwNSaQAxZAj6gxblJFuukFFVYrsmq9VvSv5p2tnih7z06/tylsjEBpecrnasR9CAmX6kQPww0doiTHEbSVjm3Zt/jAJKGgfCKrX4nFEaq9MPenFqr25J1ZwM1aRZVqrttmEdwtK5VYIc1f4AiyNCNQAaMPM2b2WTgwy/KQ4PemFi2Dn3W6TsTAAyRQX+QbBMFTZ29rpRFCUf4ImGvSOTVpTre70R64V4WuAYociOM5pFk1Nw6Kwo/yYuw1ZYoWz6pafVoo11R+VmpDfwEr8TbDdUUVys7MRrywXSv1/8t+wd2dADPwcTbQ62nDmd8ST6LrNEtM56sQVZM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THJUWXJ1NTc1Qm5mQ2g1NFB0QXFCRlNXbDlsaFFIdU03aHRJYXdTU2lRRTNi?=
 =?utf-8?B?eHFVeTEycHhCOUM3YWJLSkJVKzlHS3hFOFhKNStNWllYMm5WZzgrOTlxbkVX?=
 =?utf-8?B?WHI1RVdKVkRIS1JKZmcxZVdLTVBQcHB2UXlUa1RGL09aVFBSYzRKR3lhZ1F5?=
 =?utf-8?B?WmdBeFhXYWRzcWtObnhVZnFDYXJaYXlDZ0xORkpOQVZGRTVrTUViaEUzUjVL?=
 =?utf-8?B?eHRuQUNNSUp0Tlljc1NML09LTms4N2tLanVmVEJiUUZWdU5vWGF2WS92UlEv?=
 =?utf-8?B?L0RCYkpVUG5hZ29LMjhkRzI1cGxML2NUVm5qaTZiQ1VuSE5JZVhZZGtocVNz?=
 =?utf-8?B?RUtOb1hPdlVjSDVKd096a1F5WmNaOVlEQWtsMjkrUFBZZ0xvak82a3RoaUVl?=
 =?utf-8?B?amhFOFMrcGozaWdJb1gvc245QWRQNC9TSStNMzVHY2VYUDZKeERaV1NvWStm?=
 =?utf-8?B?dVRTUVM0dTVDSjNyakVGaVJVVW9Uczd5a0ZsbGk0ZmtSNHBld3lsR29yVDdW?=
 =?utf-8?B?bkFhblJGNzRTcFQ2ckVkTzlvOFdua01Bd20zVmdxV3ZiWVp0UjdUalc1NHpp?=
 =?utf-8?B?US9BVTNSdWNoVUNya1o0Vmdhb1djM05UTnNNTjZLdzlteDh3U2UvUUYyNTZL?=
 =?utf-8?B?QlZydDA2dmkyanAvV0QrMWZ4NG5KZW5DWFArMmRDcGhYU2N5bUovKzl4Znpj?=
 =?utf-8?B?R3NDOGFhSzZ4bi9mTXBuenZ2b29MdEJRY3ZPcnJhZ3hCRVd3WVREaWt1Ynhu?=
 =?utf-8?B?dXNWaURJNGlldlFjSEZMc3NmTnNtQVJ2bUZoUDdja1I4VEg3QUpQaXlVRmho?=
 =?utf-8?B?MDhRZ2liU3o1cUVWeU5HYURoNElHb01DNkh3MUZpV2p0R2RNSFQwVVBraDFU?=
 =?utf-8?B?VjdWeDVONXhraDZuelpnVVMxNGpGNjdIZkxzZkRVWDZXTnQvQ0xIV2t6dTNj?=
 =?utf-8?B?b2I0djNXY1FrQXR3MVdoZHNmdnVQOS9sc1Y5UE9TSW1nZjc2VW5EUmg5bHFQ?=
 =?utf-8?B?Z2pIWm51THZUU1FHZWp5aGpWWUE2elU4WFk0TWhGbXYxM2N5N3dsZ043M3l6?=
 =?utf-8?B?bm5aQlZId3BOejdVWjVvaVhRbG9sbnpxMlpERGFBTzRhOG54TjF5TzhjTmxU?=
 =?utf-8?B?YkdnNm9ZWnpUeWZzbmtLbkVkZUVwOUR3T05uT21vWG15ZnlSdTBtanZ2SWdt?=
 =?utf-8?B?NFEwOVYxL0JKaUhLRVByS0h4QTgxa2JtNlFwbEpIa0xwU1FRTFN6aXQrODV6?=
 =?utf-8?B?azhzSFRxQlJyZS9tVWZkMCs5dWdWL3FqMndMdVBYWFVTWUhqekdWWUd0a1l6?=
 =?utf-8?B?KzBndTNtMlJTS3BwQlI2TklpRSs5YVBjTm9HZmJOdy9nOUdjQzk5N09qajBw?=
 =?utf-8?B?V0FJMTU4dEpOWEw3ZHpXcEk2aG1McXk0SklXZzVTaEtDRS9qSFZ2bkE0UllE?=
 =?utf-8?B?ek14V3lJWGNhNVgzMTZNVHBWMVoyejBMWXQyUFFuUzJTTDBHKzZKU2hwK2NS?=
 =?utf-8?B?RGpjYnFIL2Q4eUNwYzBBUUE5UEVwclJ5Z28xOG1tbndnREtWUDRVTjcrdDJi?=
 =?utf-8?B?NXUxL09YMnhLaWxtMnYwdTVOY2dpbWdKMHNuWUxLOUpkM3RWZVJKUWNRbUJN?=
 =?utf-8?B?OFJXRjdrcXNlWUhUazlCWWY2d2VWaXdjeVpuaG1WKzVIRW5MVTgybDNackU0?=
 =?utf-8?Q?GSA16r36vAbpj0oGyBfw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda397d9-d56d-42c7-7670-08dca593350e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 12:31:26.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1305


On 2024/7/16 17:42, Haylen Chu wrote:
> Add common sensor device Sophgo CV18xx SoCs and thermal zone for
> CV1800b SoCs.
>
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 30 +++++++++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi  |  8 +++++++
>   2 files changed, 38 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index ec9530972ae2..0b5c7bc94b05 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -12,6 +12,34 @@ memory@80000000 {
>   		device_type = "memory";
>   		reg = <0x80000000 0x4000000>;
>   	};
> +
> +	thermal-zones {
> +		soc-thermal {
> +			polling-delay-passive   = <1000>;
> +			polling-delay           = <1000>;
> +			thermal-sensors         = <&soc_temp>;
> +
> +			trips {
> +				soc_passive: soc-passive {
> +					temperature     = <75000>;
> +					hysteresis      = <5000>;
> +					type            = "passive";
> +				};
> +
> +				soc_hot: soc-hot {
> +					temperature     = <85000>;
> +					hysteresis      = <5000>;
> +					type            = "hot";
> +				};
> +
> +				soc_critical: soc-critical {
> +					temperature     = <100000>;
> +					hysteresis      = <0>;
> +					type            = "critical";
> +				};
> +			};
> +		};
> +	};
>   };
>   
>   &plic {
> @@ -25,3 +53,5 @@ &clint {
>   &clk {
>   	compatible = "sophgo,cv1800-clk";
>   };
> +
> +
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 891932ae470f..76b02cc279aa 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -310,5 +310,13 @@ clint: timer@74000000 {
>   			reg = <0x74000000 0x10000>;
>   			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>   		};
> +
> +		soc_temp: thermal-sensor@30e0000 {

Nodes on any bus, thus using unit addresses for children, shall be 
ordered by unit address in ascending order.

See https://docs.kernel.org/devicetree/bindings/dts-coding-style.html.

> +			compatible = "sophgo,cv1800-thermal";
> +			reg = <0x30e0000 0x100>;
> +			clocks = <&clk CLK_TEMPSEN>;
> +			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> +			#thermal-sensor-cells = <0>;
> +		};
>   	};
>   };


