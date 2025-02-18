Return-Path: <linux-pm+bounces-22320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58FA3A460
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0534D1889283
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09E26FA4A;
	Tue, 18 Feb 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jNqJQWbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F726E144;
	Tue, 18 Feb 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899941; cv=fail; b=W1NBJn2ETrqypc93zkCfcwXnGvN+IW3zAF2h/QkW6R3lI5yDiAcm72Ln51nbyptpYO7Hts63Sn7bh2dyIRzDpa19i5DI6+byQfKZ+WKk4/hHaXftmlYDv52iFjw/OwSv/uw9hdsZSMIt5h7mEB6u+NbrRvwlUZKlGQ0hrV0ik0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899941; c=relaxed/simple;
	bh=+N0vmM9wgYZxuwefn0kib5dXYA2Lzr0vJ9SqXHh54XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYFqL+zUrJc3lPvMTsb0jXZuQnm6jLEZYU9i3/Tiuge0yLMeAh4BlrEBJLFYKS+gROsAMQ1YflP8s3lxuiFP8MZIDyilZ2H6MFcikjhdINv56YopzlYvRUuSDncAdmM8EIzuAUyEDjrgSR2F9jKWhzHDWH2HU9Z3bMhlhDMV/ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jNqJQWbq; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQyLr4GUfTdl8UfA16OmfiaJuqc9xLftbmfa93VthzSeW49AWN8JRNqShu3VBRsvxOW90kiwT0nVUjiyRxcNL4p6QIA2WPNVISheKFbUa0nlh8lwoo7cu+yAvNzcVr2dgaWbRooIhg2CivGW50mWTIXrHJpjZ/3Pe1bEjuYQYpSYnY722F1kWhjGhdNSwkPUvsmV60uZDoZXgWmxgyZxRCf599rv4ljXCSwsQLA88SABl/wqYBVj1KeHscvqqOPrADGaQ0WkW1oQqx/SCPOcz39KrmVYapgpzQvXCGemw41EGHjdO9trkT3JNi6/948IlSpMuZZS+JFAj2wcFH77pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d7Bbr9G3/iwKShFZT449tJGeKKnocqOTdp/mcvHjMo=;
 b=UlrA9BQAc3STSfHRBFqXH/pdn0PpWlHuGOckzeT8vKnQb2M8jPLBVksIbLQiPnB68lMFcoH71Zqt0pEYTg0llmI6LQ96lANAbdQemRoI69efHBqYlWGSRvhM2lLS34z8omaQ4oQP9pbjKWQ6UdUfmh+gtUs9yfdCC2tIpz1CauIt9bWs1E6nSF3LqmT1KY75K6oc1XE3gyvLOtopWna4Ofoy7Dk/Ypb5GXveXdRI9PKKK5sPElHIbHzMu4jOe6tj8GNhER0dKaWxVILz+5B5jPS61afdHussOdCe91tu3j5WN/bnzLGlRzCiDwVsbs9NJNnkoGcPNVdp/hVkZy5VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d7Bbr9G3/iwKShFZT449tJGeKKnocqOTdp/mcvHjMo=;
 b=jNqJQWbqLOORz4CXzgFsqC+QQET2S7+WT0+PVFhDYYdHP8htX48w3stIsG54o9Ehx7znHwzRPcRRgeMJjVa4/eMUBdYHTOWtVUaiEgah6zSeHK4UHX+JtsF3EsVWy3qlgpWj6bAn2eiOAmXCo2WvQX3EuzSwVf+CSX7iukMqUTHN4gXUNQJoXnuBcU7tVtLdMKtr5Gs2cb93ADlM3xkEQEelbBttohp+YZV2uNjvRP90SY28ZwgwOju9hUSOyiP73JafODWa2PPQ6xmDDDTjGHSRhxptwPPJ+4PCpXxU3WM+yVCpshLxPWpHNJUn4W90pLYmcwYuI1p2FTdCcb25rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10977.eurprd04.prod.outlook.com (2603:10a6:800:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:32:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:32:15 +0000
Date: Tue, 18 Feb 2025 12:32:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] thermal/drivers/qoriq: Use dev_err_probe()
 simplify the code
Message-ID: <Z7TEGQQ/JM/q454F@lizhi-Precision-Tower-5810>
References: <20241209164859.3758906-1-Frank.Li@nxp.com>
 <Z5EULLr7hsk1RIZy@lizhi-Precision-Tower-5810>
 <8693bf83-9878-404e-b609-dcaf758d485c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8693bf83-9878-404e-b609-dcaf758d485c@linaro.org>
X-ClientProxiedBy: SA1PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10977:EE_
X-MS-Office365-Filtering-Correlation-Id: 465fc613-19d3-40de-45fa-08dd50422f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWlOVVAraVdGWHJYaXBsUTJ5S1ZoZjdkTFBaZE1PSHNuSWNaR0dHTDFYWWVk?=
 =?utf-8?B?RXRMclB2T1pZZUdZV0R4Z2VrazJpZEJQMFY4eEhPWmV1SUwvK2owV0RaT3ZJ?=
 =?utf-8?B?NlllWnVyWWdvTjloTVdoalUvR2VFWUdzZjlnU1VyU2xjRnVBWEtIS0hQUHln?=
 =?utf-8?B?RUc2TTFmQmdldmRCVUlOb1Z5WlRjaXZCL0FVNWtwTmZSN3VmZHF2L3dCMnc5?=
 =?utf-8?B?bkdPeVlMMFJ3MUh1TkZjNGNQeDg0YUhTZzdST2FpMURWUHE5cTZoclFjUkg1?=
 =?utf-8?B?TnhGY2FmSkN3OU1DdllOZyt1dFM3dTNQR1g0TVROMVhDVXhaem83NStERzI5?=
 =?utf-8?B?QXFFVHBueldSNi9NazdjSno0WVRVamFiYXpTbnRPZU1XUlRCZmJMZTBhVXND?=
 =?utf-8?B?bWZjR0lpS3EvSVpXME9aaHlZRVpwNXFxcGJZcHF1dXg3akpGWWRVQ1FLU3JZ?=
 =?utf-8?B?Qldvem8xeXhYT2NqT3l3UXREaEhVZlBTcmdhYmdjL0twdVloSGxvWnVKejhs?=
 =?utf-8?B?NjN6a3lXck04K2E0cGtmSEw5dHNYckdNOS9xcFRIaThKSzBjSXM1elhvODBp?=
 =?utf-8?B?cVpLYjJ2STZ1Q3JBbk01clpld2JRb1F2QWFyNUQ4cDRoZkhtRks5M3krdEI5?=
 =?utf-8?B?UkNlUjd6VU5iWkFJYXFNbjVOQnhObi9ZZ3RZUWtJU01TM0oxNnV6UlFySzBW?=
 =?utf-8?B?QUgvRnhaeUxiQjlYaHFtWjBNMHZRc3hCTUt5bVJ3bnNwSWZ1OXo0NGNXTlVm?=
 =?utf-8?B?dVFJZ3JEanpvVUk4TmpQUjV1d0pSc1o1TkdvQWdpNVAxZ2hFM2FkalpaajNx?=
 =?utf-8?B?ajNReEtxUU84a2UvNW0xeXQxTVFScld3T1pDNmxUTkIrcFVrSGMxV2w2dHhN?=
 =?utf-8?B?UU1TQTZIUnUvYkpzQW5vRG1WaGI0OG04cnJON25oRDRCQjNyNldqeDVnejYx?=
 =?utf-8?B?amc1dytlVjMzL1hVNEVBUzFPRGplM0lsRFNzQjU0UVdvdks2R2ZPU0VadE9k?=
 =?utf-8?B?V0pzNEl0YWRoQWZ6U21hZXFUMWZXaDkwL242Tkh5bHNhemNQL0FBNHZjNmtW?=
 =?utf-8?B?YXZ1eGZPbVRMZFRJazF0VWt3SVZXWlFHaHJrYjlFRDc2eWV1S09DN3I5U09a?=
 =?utf-8?B?cGRlZDF5SWVndDhZYWtvZk1TcmlpRTZHeTA1Y01nenQ2WXJValFPZ0NOWWVR?=
 =?utf-8?B?aU0xeXMyUFVKVFJPWEk4TVB1NCtFcjF6c1U0SERsdGUxckkzZTBuMkVQYk1v?=
 =?utf-8?B?L2l0MXFsc05EbUxjeTN0bW1QcFg2dlRaOVg1cE5xbHovMC92OUNxVVI3c0cv?=
 =?utf-8?B?R08wWnpIYzZURjQ1NGtZNXBtRXFta1puS0JxQzBCaDVQNmVtSnh4R0MxTmhW?=
 =?utf-8?B?OFZTWEpiaG5aSVFveVIrTEtWWEM2a09vUW1rMitwbUxaRGlPVEZ4V2FsUndW?=
 =?utf-8?B?cmN2YjhnMm1rMEJVeVlMYVIzZ2grMW1JVUtvZUxLbW5VeHlCZmVuTFBQVzJa?=
 =?utf-8?B?NEFGOE1CL0FkU2o2VVg4bzVlZ1dFTThwMlY3RFNSbm5oMTIvYm81UFVDK0tO?=
 =?utf-8?B?elU2VHc5UmhxeWxoZ212WUc0ZEtwOWhhMjBQZmZPSHNHZnVhNHhHQmtndGQx?=
 =?utf-8?B?VEhJSnMvYzZ4clhaM0hBM3NoUjlFUGVOdzFFQVZodk1RcmkrTnljMVROWGgy?=
 =?utf-8?B?ekdnY3hVYTJpSEtJV1dOMUZ4cktjamlJRXdPeHh2ajgrN3BDNHRGOW16Rzdr?=
 =?utf-8?B?R2VuNk5lWmp1Y3N4RzVpL1RCM2h1dHk1SWpjelBud1gyMGdWclY0T1p6akdh?=
 =?utf-8?B?UmY4VGs4NHBqcTYyN1RGTjhuaVR0WXBrNDZISlNsOHFzRGtNUk93c0lsYnhF?=
 =?utf-8?Q?xEG7jCXbWJnae?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3BLU29SeUVENE56MGp3U2o0djZ5a3A2eWdOUlczNEtVVFBha1ZML0pEK3Rj?=
 =?utf-8?B?MFc2LzdEVVo5QUt6dU14VVcyTm1pVUllRDJidlZ2dmppVTdVQUgwMjRyZjY3?=
 =?utf-8?B?ekwvKyswOXpDb2NLMUZMeUlBVWdKRjdZdWFoRlQ0WXI4c2hwNWZMa2ZYbStt?=
 =?utf-8?B?M1FkQkw1VnRIc3VTdUZzUFhzbUZYSU9GSnl4M3pzTzZsenFLa1lOWS9DTFVI?=
 =?utf-8?B?LytoOTdjeXUrcy8xaERRb1pZcTlGWDBkOUdpT3FtdFp3cTJUNnFIdGt4eUlx?=
 =?utf-8?B?ZVplQStFNlJ0WHh3bDNKcnZpYzk5ZTVmS0ZEM0JyVGR2elMxZEF0RXZhVW9z?=
 =?utf-8?B?UmN2TUtxTGpicW1hUFNaeFpmeGNTeXFSRk8vWDVIUFFla0lRaFZqckIrbGIw?=
 =?utf-8?B?MnZ3K3htTWVvRDFWbWg5NU5rYWZRdG9WRlNoYTJ2MG4yeE1INHVuVWpDc3Zs?=
 =?utf-8?B?YStKVXIwVzlqN2lxdWcweGpBcGVoNHhmbDc2ZHd6N2w1cnpsb3o5Smg3ZHBo?=
 =?utf-8?B?UEN1L0srSTU1YnZIaXV6SUNScWxJWnA4WDVuTEhmQ3NNZ3RSV1QzQkRvR0pp?=
 =?utf-8?B?TitqVFdvTWpoN1QvU1hCcDd0N1VCM0JBVzVCRG9kRmVremdBQVhweURGVzA0?=
 =?utf-8?B?cnM1N28wVGYvTzVBMzJOeHVYaFlUZXpwSElYd3BmUGJodTRoWG1NV3VSN2Nj?=
 =?utf-8?B?K1BKOSs3U3BqYUR5YVBZblJVOUlYdzA2WDBjZFNKZ2drYlZHdnQ0VkV2NHUx?=
 =?utf-8?B?S0NidVhYdGlqckNBUkp0Zm44RlRhcmlQSTFXTFFRSWFzMjdSN1ZHUVVEYTN2?=
 =?utf-8?B?cDRxWUZ0djlSckxnU1hCbFNMaVdJQ2dxWTdwVDdrUHJ4TFZNa2UzWVVtbkZu?=
 =?utf-8?B?cVJ5WGJPMVFsdGpJU0VEVHNPckUzZ3lzZzliNFcvNUx6WWprSjdsN0NzV2Mx?=
 =?utf-8?B?ZE9iNEJud0MrcVptR2xLREZySmVvT0VjLzh2NEFPd2srTkJyNDVESnd4UnFl?=
 =?utf-8?B?SktQc0pQckF6TG1ZQ3dMOXBoaTdJdFVpcGlzU2VRL053ZzB5bW1EcmtXY0Ur?=
 =?utf-8?B?SWZOeCtqWndWOVQzbVNRK3hZYjE0cUVlOUNJY0xzSHp3WFpDb3hzSGthdzFu?=
 =?utf-8?B?a3g4dWhZenBubmJnbWIxeDE0SUhxNlJ1ei9HQ2djTzFTcU9BWnNNVSttV1Z5?=
 =?utf-8?B?eHZLemxUNHgrdExncXRXZVowZkJMNjUvdC9RRVJJcTQrMzhhM3RUSFB2Q1BG?=
 =?utf-8?B?azdZUzY4Mk0raHAzK0dubDV6bFc3bWYyYkw1NVpzSm4yVVRNRHFMYU5udzZK?=
 =?utf-8?B?bmFUTG1TWWtjREEzL0hBUi8ycXBmNnErRlloei9oQnZ5NFhWMWlMaVBvRG5l?=
 =?utf-8?B?cTFLYTd0YW5GRVc4Mkg3bkFzUzB4UGJNTzF1ZWdKQnNkN01zRTlneDJyT2NN?=
 =?utf-8?B?czlrc3JwSS9tM2dvT3JLcVloc2xBOXh0WkpWOUxaT3ljYmI2cW8ybWtGZUVM?=
 =?utf-8?B?cXpIaExodWx4K3gzcU5WQkFMRnVqaCtPMWljQnBCSHlRdlRLV2ZtMWtBYWhj?=
 =?utf-8?B?aUw5ayt1bUNkMWxhWDRNQ2xtbldvcUJJbnluMTJiQ25OcG0vQTNBSGhaZW5J?=
 =?utf-8?B?OU42VVkrUUNqYjgyOUg2UGhDOGN0T1JIL1NhQitjRXExNTRDaGpMR1VMSjhu?=
 =?utf-8?B?SVBDZ1VoZFZsWVpuM2hkK1ZYaHc4bUNmNXdNTk1EeTZEbnFBSTB3OHVnTU1N?=
 =?utf-8?B?REJodEFlTnZWQm1XbXkrT1pXcDVZTk4yT1pydWIxYk9aT1psdktqMWVnMUV1?=
 =?utf-8?B?dk80TEp0VHhLYTJkUGhXOFNlTnRNMnZzSnlrQkl4SEdzOTVacm4wWXRKMWpx?=
 =?utf-8?B?eng2NStBWkdtalhoa2xLazZ4ejRnMjdOSDk5UzA3d1ZGZjhmL1E1OE9haGo3?=
 =?utf-8?B?K3FrN0REV09lSmJ6V0tVcDVsamNYcjZqY0JHSHRDUHJvL1JxM0VlMDNHaUl2?=
 =?utf-8?B?SzBzcHEybmRZSUpaWjVTSmt1RVh0NkdhQVBHT012NmozV3FzVjhWVjJjN0lI?=
 =?utf-8?B?UFdhSExHWTB5RVZvRmE2SWF3YzVsSDduVEpXYWk0aU1sMmhzTTlWOUpTSVBa?=
 =?utf-8?Q?t36mEb6pXCEGvzVbfvSnLSX89?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465fc613-19d3-40de-45fa-08dd50422f68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:32:15.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8s8gvzfe/9tzniI7CdUYTpqN/jkon49biFCRFohvzND4yVooPQe5vqXRASAoUHJLU4Aty8OuME4Bznp504ytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10977

On Wed, Jan 22, 2025 at 06:41:22PM +0100, Daniel Lezcano wrote:
> Hi Frank,
>
> On 22/01/2025 16:52, Frank Li wrote:
> > On Mon, Dec 09, 2024 at 11:48:58AM -0500, Frank Li wrote:
> > > Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
> > > code.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> I applied the patches, thanks
>

Thanks, I have not seen at linux-next/master. Anything missed?

Frank

>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

