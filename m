Return-Path: <linux-pm+bounces-28443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52248AD4C4E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E93189A92F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DA22DFA3;
	Wed, 11 Jun 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JmgN6dmu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2015.outbound.protection.outlook.com [40.92.22.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379D2D543C;
	Wed, 11 Jun 2025 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625612; cv=fail; b=UtB9y8kARo9IwCsCLUad1Ck9XFZlc1lmAzOhMH9pKsstYIPvr8a18dkJLhYi7qgYIS1WLNDHwnl1mJHovu15jVmqekPrmJfwiJOdfhcyawvgHDrZKHLWeyh7kP7BTzABc5BIqI8p8DEocjRDEeYuvSseICxwUSQFM8qKkCkNFYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625612; c=relaxed/simple;
	bh=SRXz4cy98ixducQ4aW0m5p/9e1afELIHY9qAE20Cl4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeZzVSlBxQs25cj5VMtAcqSaB1LzKsu203DYYMhIE5ccgZQc1/5yzq0tXZJOYPkqhDBDbRiyTxQMPVY2/rp12zkIH6ePDYPqMuJ5jFYQY/6h9c2sNtY6/1PekLI+Vv8eibrhil1isKQ2Pkqud65gCwl5n34QDmZHc53tavywXYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JmgN6dmu; arc=fail smtp.client-ip=40.92.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qURPb85rX5J0wvGuDYgh/Bs/O4JsMG4a2oDAc79ZnWzQUfCaBBgaR8bwwsbjq5y62SaSlF4xJcVcm4VfVDr6y+vI9uk1FdOqdKFF2beMxBMzS1CFUAD8iGJ6t+uG3jrLvl/GXE7/lbHxZWNmbNtYKmnMsA6psoGh407dLNOk8uxSwhcWS9oXtRWpHF7PItmVW2eUMVPGadFvI4C5+PvKblRfTftxcWMqtGetqm4tWyQki3wAdcIoubROJ8Y6GfSt0O9yyp/27cU1qLwK3rFU26fHJFsq24XYcQKvrnVwt/gUgxK/zIuV42IJcxhi8u4y+v5vzQb0XZKYqzVQyFmiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCMuPiTAQeEfSp1iolha2clbPjgQNvk8/dysYbczu5E=;
 b=aUMVsnc01B9K2sDaL+iEgeZ4VCubhcGUV+vUP6EdL7YL3iz1K6qR93xSRsmKxfMJN21kUO3oah3sfNiyIQ6LTXCsr2riWdTbbG0Dxicy3Lr3TTarrS4Q/FPk5hx16WqtPVF7q2QcrRLiMHdeUuueWrX3iMYKLVHfZQkGPE8p01e4UoFjyjYak5gQNPoQGZ4XI1zp3tzOJ2khuQibI7BGji84IAjTAsLc5a7zYT5qn+eIEKJKOkPvOe2/ly8wpCKPzkbtSaTfkEcHdoJAusYTl/N1S5pveNB1eKPEsQAIKFfN/lENQnqPYymMpK1+7XXyWorBDDLr/BzZ/iZVZbL5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCMuPiTAQeEfSp1iolha2clbPjgQNvk8/dysYbczu5E=;
 b=JmgN6dmu/DLuXnprfzbgDabbQepHJEJSFhZeiR7yfQD53RiF2MKF6XOfMdxdRk2Zu270Zfb7aK1LkTQyeuzy/Wz0DDh42+likwMeJkvLJXcBR7816FuLE4IgjBftOMx0pJCbhtrw5Uwca/6zrZtlKAvsf0MVGrq7DWQQ3fTwhJ7QcwF0v6AbDzRiCY5QskWwYiZiL+r/xx40/+nqAVw5fWIZItZiRSM9NIAo5EIwCf1d7tVmk/Pu3u2qc7VFboE9xeA5ZKjLcmYGCOBz+95yCj0kxoB3RNF4P+ZtlTcZ0RTdQXVk3AmIpG7fTd/daRQwsyAZbxpHWBWXSFG6nFg77Q==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by BLAPR19MB4628.namprd19.prod.outlook.com (2603:10b6:208:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.16; Wed, 11 Jun
 2025 07:06:47 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8835.012; Wed, 11 Jun 2025
 07:06:47 +0000
Message-ID:
 <DS7PR19MB8883034308D6642B6B567CAD9D75A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 11 Jun 2025 11:06:36 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
 <20250611-ipq5018-tsens-v11-1-266566bfd16a@outlook.com>
 <17eaaad4-7713-4149-b66c-1c48db3ab42f@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <17eaaad4-7713-4149-b66c-1c48db3ab42f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0043.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <3c9138ea-c088-44cb-a59b-5aaeb1b34217@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|BLAPR19MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: dd67b1dd-9787-44ae-6a8b-08dda8b68719
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBvbAt8nrAK1sszYZ7KbVe5e5mMvtLM6tHmZrBV7mvXXb4ALwMUGdvdjkwa6YVsT0hsL4UdpdYvYIzG6TYLYmO3VE7VyK8Oq7/sqJlwkUjUGp6snU+hY7XhSRP6ddroMivVpooITskqULzzYefppH8aXJglvxCbaP11IRCjbfzfWzv8Mzq4wqmC/6WWhpVHKzvpv4w5n0dPYifThg1UEoL69BAEbQLNxfgzQmMEWFPn2bmhLO27D4Ssi9LJcRBxbjGEpz4fuG2dSYly/5c4pqlGNIuASQMKobsO/w/LwWUvPWr/fV/vJZHOi9YlOFx6QGqvyghkoP5w3o95hMi+ka6F5Puquoa0UQxqkAhJF0aAy+siRa9CSuknWI7y4iiMR4eMvew99MPk0D5cyqOl5+SyBjEW84V6SSScqPe+a6BesdW+yiODuqhFy68a/k1HAOVk333VLiM1j1CI80GerBkzen+6rt4/w9Ue50EarAmJ+GTd5oi+lg48u11v0DcMqRtkAdkYHSBPaAnEOnl9FxD8z40hC8TpqYTzB2ZA7iFu+PJMuJZyhOEobweHtCC/I/4dt6wsBn5MrS3g/pJXJeFzUj5P2vMGvMpssqXbMpfoXnzKMkZfQ5sCQQwm6XNT8MOXeS6Db+Bl6xYspMKgrFcm8yiaTIekxJgN3UN5GheGAt1u5UBZ3DaJ2w7L50WDHpYIaCIsjAIdHMxSI7cfnEJMwvj4vNwezWU0+oPVhN9Hbivcr5N1mqsEWsahE5maYe3D5lpQfqchMNpEIVOp0DdFf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|6090799003|5072599009|461199028|19110799006|15080799009|7092599006|440099028|3412199025|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2RhamhxL2loRGxXRkZBWUk1SWZQcHpRaEpXT3hRTmtOUGduNERHQlc5TEQ3?=
 =?utf-8?B?a2RuTFRNQWJXdXRFeHZZU1QrNGpVc0hpM1dyVUhTUzU4d29WU2RiU212bUhn?=
 =?utf-8?B?MHp0cnFtUk9vT0RCSG9MdXhLcWxTSitreEhPYnhwdVQzQmFjQzBYL2w2Rm1N?=
 =?utf-8?B?dDZzSTFkd3pjdUNkOWxNTzRTYUZUcGl6Uy9XYmFyM2ZrMmthR3dRSTR6bm4y?=
 =?utf-8?B?TjVNdWhRU2hpbmpLMUJqclNVdG5kUDRMU0xiQjlmQ2lyTllPNGVrYUl5bFdD?=
 =?utf-8?B?RnlaMDhzaldnMVFDR3RJV21pdUNtRzBjcFFQdkNIV2c5T1BrYzBzaXVoc29B?=
 =?utf-8?B?NnNyemthaVBGMmx4b1BuRUVwRDBDaWlHS3M3WjNaRVJLc3RXeWJoQ1plSlht?=
 =?utf-8?B?QnN5WGVwNWRyc1FsTUwwb01HQktvY3hjL2NIQ0hFZnd6VVRhSHZsa2JCT3dl?=
 =?utf-8?B?MTFGZTA1NTlZMGt4UE8wT3hJU09UTzh3cEh1RGxndjhFWTRtU0FHR1NRUXZl?=
 =?utf-8?B?aWdUQWlpWnBkc3llSWZ6aEZhbnN4N1pXZkhxS2FmRk5wNnkyWUd3Y0h4L3Vu?=
 =?utf-8?B?R1I0LzJGTy81aWUyZjhBby9BK3FBMm0zd3YwR0duMjRBeG9hRlR1YUVOUTZv?=
 =?utf-8?B?ZTF2eWtCWWU4M3E3QTNLM1BNeGRuU2JyeHFxK3NBaUwwdU5rMTRaVGVCSUlu?=
 =?utf-8?B?N1pmOEIrd0xuUzVzc2Jib1QwSnB1aVQ1anl5K1MvVERXd3YxcTZSNXkxd1o0?=
 =?utf-8?B?UkltVkRMaGg1SXF4cnN3SkdUMGlRcG12QUY5bWloOWU2NjAvbEwxdGVSTzRm?=
 =?utf-8?B?VWxtYW85aXh4cHd6Vnkya2FIL3BuVWhtV3Uzd2pJRWg0RW5GeGtOMnpNMXNz?=
 =?utf-8?B?WU1zUHgxTzJ1aWQwckZ0eldIc29MaUowM3RoNHB0ZEVwVG4rKytDb1N3dTRt?=
 =?utf-8?B?bUI0OXNKN3ZxZkdRVzhmQ1hVZ0NUOGQrdHg0Vm1mdFNuVkpoR0UvcE5UWlpI?=
 =?utf-8?B?YUJhYmZIS2ZwcWtGeGY1MHVPSEloeVBQL1VNTEV1UHJRM1RhLysxRWFBV2I1?=
 =?utf-8?B?V1FRR1l4Tk1HMFhGa3RKMk15aDY1Q0x5djhscTV6MHFhbkxtR2V1R1BFMndP?=
 =?utf-8?B?R2haTnFvS2hTWHVyeWZkZ2todWphUG5GTkdXYk9aQWdrdmhNUEJVWFZDOXhn?=
 =?utf-8?B?VnZHdWNKQzM5RENoRG1UMkhEMzVvTWsxb1Zma0E3cHhzWFd4aHF2OFJQY3dM?=
 =?utf-8?B?bnhzNXpuaHRoc2xMT3hIemtKSFp0dy9wcGl0cmxjdnFFV1NpQmRteEZhbndy?=
 =?utf-8?B?M2ptYXBqTFhGUTZhRkZ3WDZrNW1LUFVrV3BaL0ZZbFhuMyttdGZHRUpDWVM1?=
 =?utf-8?B?K3Q1U1czU0c5K295Um9QdnlCMmJsOUxCVUppQTZTeU15VHlrbDN6Ly94cko1?=
 =?utf-8?B?Y09NVjBJZlZBRkU5bkZDeCtEQ3E1VllPdHE5MFhGNHZrNWV0VEpvYWZueExa?=
 =?utf-8?B?NGNDSEh6b2NrbzFoV1plVjhXTk1xQzRQM0hRUVdNbnY5NEh1Vyt0RmM0QU9y?=
 =?utf-8?B?dTR0WmNhODUyQnhRM0FwVGhKWmloOFNWN3VoWTVxamhnQVZuZ21nRlp2dEhC?=
 =?utf-8?B?bmtVTGtFQlY4OWVKclhmTml2R3AwVkRjbDhKMUhOaEVhOEZ0M3BRZ3FCem9U?=
 =?utf-8?B?a2VGS2VUTFRLbFl0ZlRTVGM3UHBtblg4THVxV25ONERITWJLWGZwcko2VVRl?=
 =?utf-8?Q?m8H8Ipf5TpF+BIktt8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFzbE0yNUw2TXNObkZuVGFYNzFoNDl0eDVOS1FwR1YxbHlVSHllZDlkTUxH?=
 =?utf-8?B?UnMzT2FCU1VNU3Y1VVJadGpXWVBBV1R5c3JvNFo4YlBLUHFkMVdkVzBLd1Rp?=
 =?utf-8?B?SHNlZ2oyUUVGNDIrWWpDamhGQm9lUWgvQ3c3ZExndzF6Y0I3YUNBUUMwMnBn?=
 =?utf-8?B?eVlFMFJCRDVJaVo0Wmx4dEdPUHdOZEJCS1pFTDhvb3RQcUp2UEJaaDU2SmVZ?=
 =?utf-8?B?ZVlOQ3lhbGEvQ3UxQ3p0Ym5hWVZraTJsajEwbWZ6RSt4dkJ6eTA2S1RqY2po?=
 =?utf-8?B?ZVZVODdZNDRhY1V5eEpKWEVWanEvK2xDa3FwOUlRZ2ZJa2xiTnQ0VXRwM2Z3?=
 =?utf-8?B?cEtSeWs5SWgrZ0Z3WlZFSk5KZUtyV1pqT2FVaVR4bkFnZzYwWUUwSFQ1VWJx?=
 =?utf-8?B?Z2dPWjdrNUZIQmlSMHhseDZJSCtKbHE1eE5RWlI0bXY0R29kL1kwcWhKeldQ?=
 =?utf-8?B?OHRIUXVQdDMwbGt5TnA3Rlp2blhTd0EvQVYxMEM3Tkovd20yWVNwRjZJa1dD?=
 =?utf-8?B?QmEwK1oyTmFuaG4vck9DVkN2ZWFQRU8zcnJFMkdjYktlcWNlV2xHQkFnb2d6?=
 =?utf-8?B?TlZodWY5U0d6Y0RBYmV4MTY2RG9ZWTdFTlRPOWt2TDI5elJLVGlsTTNRTVZ0?=
 =?utf-8?B?MnhXVWQrTFUrS0NaTzNMM2NSano5RXcrZWpDUDNWTVoxSmJsRE5PZ3JtS1FE?=
 =?utf-8?B?eWFuRG9NVjFHKzRPMkJVL2J1UzdMTm9jWFZWN1hGRUExSVhBWStsbXJzN0cy?=
 =?utf-8?B?QzYzY3hJVVdvYzRNUlZDYllsdCtwYkcwaVYyb1pLc002elhNWTJDVkNUK3RW?=
 =?utf-8?B?K2xVV1ZYekVBNHRrNFBXZzZLWDNRRGFQVUY2QjA1cnpXVGRraFY0dmhaUGFv?=
 =?utf-8?B?b2xmYXBLaEdGV0cwbmxMMElOYm9QSUpjbTlreXc2UjdxaUtqYy9lTGNsOWcx?=
 =?utf-8?B?M2NJNlRxMEhpTHl3eU0yR0wwVTNSRnhPRXg3b0tBQ3NHbSswdzZJVGV4R2NF?=
 =?utf-8?B?SEVBUGNodjFCZlZHTCs5L1RJM2FBaFVLVis2cDFNVHVpWm9mYVdUSUV1dTY0?=
 =?utf-8?B?d3FWb2lwK0IxRHo0VHhtTnpXa2o4eUQ4TnRtcm1HNTB6eFhvS3dFbzhCcEJI?=
 =?utf-8?B?UzRpNC9LaTA2U1kyVFlXMlNockpGTXdvOFB5b3Y1UVFydG9mZ05EN0c3ejQy?=
 =?utf-8?B?SnlYMGRuVklnT0RUUDE1cGNGOEs5L3dpbjNHOGVPVTVrSkUwYUh6c2ZwMThI?=
 =?utf-8?B?SkdkaGMwNTVaeWRvUnl3YWdqSmJWZG15cXp2dEFBamw5MkhEV0ZzcUEybCtB?=
 =?utf-8?B?OURFQmR4aWxMWkl6UVJ1My8zU2pSQStGWDJOREhaeGl5MHpJUnRVREtyZXFR?=
 =?utf-8?B?MGxtS1ZLTHhvdmxWbnl0RWVJNnhSRHNSQWRLc2hoOFVCb0ZpbktKdXR5TkRT?=
 =?utf-8?B?dVFBT1U1ajNZUnozTzRuNWdLL0VQS0tXeWQxRlhUR1RraEhzS25JNXMySnpu?=
 =?utf-8?B?Tmk1Umt2c3NzSCs5UWFDOUFEYXgwbVVpVE9Rbm0yTUx4eTJuVk9tRVBLZW51?=
 =?utf-8?B?UGM0ZXV5eE02djZ3eVlBZ3lLRHg1WUhJMHFHeEVCdEJWelpTd0JlNEZlTWtF?=
 =?utf-8?B?Y3lDMHRiVWl5WlNhV3R2T1A2MTZxdTZPWmRucVR2bk5Ddml1eUJ0b3hHNUZJ?=
 =?utf-8?Q?85VYjz0xXjXCoaHfcD5N?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd67b1dd-9787-44ae-6a8b-08dda8b68719
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:06:47.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4628

Hi Krzysztof,

On 6/11/25 10:51, Krzysztof Kozlowski wrote:
> On 11/06/2025 07:12, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> IPQ5018 tsens should not use qcom,tsens-v1 as fallback since it has no RPM
>> and, as such, deviates from the standard v1 init routine in the driver.
>> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 5 ++++-
> 
> You just added it recently with the fallback (in v9 of this patchset)
> and now remove it?
> 
> And what does it mean it has no RPM? How does it affect the driver? Does
> fallback work or not?

IPQ5018 tsens IP is V1, but since it's got no RPM, it follows a 
different init routine for which VER_1_X_NO_RPM was created just like 
there is one for V2 without RPM, else the driver wouldn't probe. This 
was added as part of:

https://patchwork.kernel.org/project/linux-arm-msm/patch/DS7PR19MB8883C5D7974C7735E23923769DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/

Since its introduction, I missed updating the bindings which caused a 
binding issue (as reported by Rob) on the compatible as it expects the 
qcom,tsens-v1 as a fallback. But we can't use that fallback, so that's 
why it needs to be a standalone compatible.

> 
> 
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 0e653bbe9884953b58c4d8569b8d096db47fd54f..73d722bda8adc2c930edfc3373e6011f19c7c491 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -36,10 +36,13 @@ properties:
>>                 - qcom,msm8974-tsens
>>             - const: qcom,tsens-v0_1
>>   
>> +      - description: v1 of TSENS
> 
> So that's still v1... I don't understand.

As mentioned, the IP is still v1 but with a different init routine in 
the driver for IP v1 without RPM

> 
>> +        enum:
>> +          - qcom,ipq5018-tsens
>> +
>>         - description: v1 of TSENS
>>           items:
>>             - enum:
>> -              - qcom,ipq5018-tsens
>>                 - qcom,msm8937-tsens
>>                 - qcom,msm8956-tsens
>>                 - qcom,msm8976-tsens
>>
> 
> 
> Best regards,
> Krzysztof

Best regards,
George


