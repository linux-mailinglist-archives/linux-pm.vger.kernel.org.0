Return-Path: <linux-pm+bounces-38520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E5CC832C2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 04:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434C23A155A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0D1A9F86;
	Tue, 25 Nov 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TX1PWPN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBC7263B;
	Tue, 25 Nov 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040013; cv=fail; b=PyWucScvkccqcKKm0QwWfwdPaCVqJTVrSqleY5ca/z0E6xA3apEyFp5P4rAvY8pBHFvyWrTuCqiPrF9dZN5aQ+43njD+jQlb/vAhHJgdzc7S3/ddLvhcHx2FjKG4HGb9CVkzn4g4dgHjJYkPqFf3pxVBpzxCyOdNz0WhGyf0gVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040013; c=relaxed/simple;
	bh=Cyly0olORwlWbLzJLSEVlnSD1JZ9GFHmEEC65tuObuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0AsTdtNzi782EbzdWB7KZOroG3tPbIUgVBdIVk6B90EW+9+wvoamqaAsrhFCih+1udy+vEDOUtmW5iHf6A7MeeXIbszlO+m7pwBAjzYjRmN904dJAHTrL9uiJ/lBqL+Pl/TVWgZ10Ron3H1fbM1KKBHRpGNui0oe8hKR9vLoxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TX1PWPN3; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS4ug6Orp0XZj2JdC85rEJ5DAv5PF/OypJmbB6UGvbqH37qu7+/mYks6BxxV2G2ngwFuib/pk1DKBZRE1q5+Y7rOB8IFqcqIwonsW79bMCoeXG8fILI5TNh1eImu97ZXZ0Ppg0F9fFl2Av9IJatweCDxxyd1c5q58q26DrnUjuP+APtizh2jr6H1RcOicPHYhiOVi8naQ4bHQmI6p6YFPBT6tEM/uEKQFT0rg5HfT6+n/XtieiCfng/T4J4SKZl8KN4hH2V9k95I2KDGUNyhvUkcWbWDvwszBQt8rqfCWP/tH4tkfI5C2nidRscGc+s1uswCU+KO9H9oGzhaGUqVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06IMffk7mSl4K6Cb8NQNv2+GCZ4TxZfSyWF0LqOZl0A=;
 b=DLE076R0kLUdKKo7mxrFyG8cG4VV7NcRN4jJRxzgdXUWs3ADMc37kWNIqGPsoCT1zEINzrjVuknRZsoNHdEjeFNPKgZPnF+skjqemwEyWvDxLmXqQc/3XRyTw9ZcnRpWDQbpZK56ELoPNkvsTUQB6nXkYV2HUflZs9ucwEAnZnqxsGNPO2+lsd11HF1nChaZORahtilizF4Jv5dMvt527+bO0kQLEM5wlOlvXoxttyMAPpUYD2OGASb8/fNTKNynhFNtn7CfIV3XcDaks0ZZ0L16odCbXATszGnbaE76nWc1F9hvCEOnbJSSXjz0NFqFnIAac8K2mnP/2vzdEThYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06IMffk7mSl4K6Cb8NQNv2+GCZ4TxZfSyWF0LqOZl0A=;
 b=TX1PWPN3U7dt9Yt7fObrE1gmK0QbUoc9EWNnuUE/isBzHhGo06n+9BiGEncvIAED/x8pBj3WpOGNL+VkkayIutdn6quG6N+nKWYC73qB3N66IvQJSoJGCZly71FZjNIWZ49GWkVYlY7msTFUrJZ9K/vIZQstGjiJmXVyZ0vByiOjRL3BIAR7EvY2MhIuEIXYfbgOqG8rA6lxW1YcW2pcy/se9wv6gMfClG7uTh4pzdt3Lsapw6C3Ue1UcEq37rgdndhXo82N8t78sbE1EkpnbMeICJMyDAnZDY2uvRBcLvlLw57EbVZXZl8kN2d2yhd0cIbNETCxZ96WbI6NPCd2+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB11557.eurprd04.prod.outlook.com (2603:10a6:10:607::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 03:06:47 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 03:06:47 +0000
Message-ID: <a4e516d3-ff8e-4233-b959-7a8d4222e5d6@oss.nxp.com>
Date: Tue, 25 Nov 2025 11:06:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: verisilicon: Avoid G2 bus error while decoding
 H.264 and HEVC
To: Lucas Stach <l.stach@pengutronix.de>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <20251121081911.1682-2-ming.qian@oss.nxp.com>
 <53cb1a8e87f80d8bb1a9b6463077a99b2268e46c.camel@pengutronix.de>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <53cb1a8e87f80d8bb1a9b6463077a99b2268e46c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB11557:EE_
X-MS-Office365-Filtering-Correlation-Id: ceef1564-b131-4687-57b8-08de2bcfaba2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzVpb1Bwbmpka1F6blRzSUxuay9DelFUVVRhcHcwaGs2Z0ZGenpkYjZ5cDhU?=
 =?utf-8?B?S3N5NXZrbmpGVkxJbmxkYUpvVlU4c2QvaUpXOWsybFpWQzlqK2t2R1BXeXla?=
 =?utf-8?B?TFdLaWwrOWNzejk2cFlYeEJrSTZkSEpWVElCaE5pVldWb2VKTUhDejVoekp4?=
 =?utf-8?B?Mm5WQmpTQ2VKSjRjdzV1STVDWkIxT2c4SDFIUXhkdGV2WEpxbkNwQnY5VTJP?=
 =?utf-8?B?OWRRUCs2a1IvdGRxUjJXVWlUM2kwSGl3cThnTHhmem0ySEJYVTEycjhvdG5F?=
 =?utf-8?B?QW10L1M3cVlvS3JnVmZNcU1qL3lSWG9rTFNmbUNFWVp1WVBoY2E0Wnlpdkto?=
 =?utf-8?B?aUhIdWsyZm5MQ3lQUlY1L3NYZExHTFhzMlptUnhwNnp2eFovTThUU1dnbm5Z?=
 =?utf-8?B?cXUrS1RDWWRIQjRBM002YkJWdXN4eE0yell2bnlaQU1OMWtvbCtveUlqMWdk?=
 =?utf-8?B?SWVWYTNPMzNzNndObkYyUkpCMkJYMWsrQW1uT2l3T2hPcURSSlp2Y2hkam02?=
 =?utf-8?B?WUlRbUdEeDR3RWFlY2xldUdnaHJienRWSVdHQlVDN29yTmFlVWFzVnNJTFVq?=
 =?utf-8?B?L3RDZFI1SlBra1lBc256ZE15K2dpSU9sT1IxV3NPMXk4YmllTUMvVHJSVjVu?=
 =?utf-8?B?RVpaSHBMMU1JaVlERXByR0RjbjZTaHlOOVB0WVAxNi85N1drdkVvcEhsdmo0?=
 =?utf-8?B?YmhqTE9ac2VUclJqMENVNXpRRFRuWVNOdGFrazBVRWF4UGpRNGRGVjhSOVdx?=
 =?utf-8?B?Z09haG1oY0pELzlqbmlrc3E0b1pubnU0d0VoeGtIMmM0RXROanVRNE9JekZv?=
 =?utf-8?B?MGNFRW1nakEzVmJaMDZiSEVFSmwvM2NsMGZLNWNzbDZwUEI5bVBBVm5ab1I5?=
 =?utf-8?B?VUhlTWNaYnBKUEZMbGIrVGRTSTdseFNFUVl5NFNCZ1hVbU9CRFl6c2tOTFEv?=
 =?utf-8?B?T3A5ODdBL0JHeHFOc3lBc3RBZm9ocFZQdFlZNDRacU5sWHBjVHRIaEM3TzdK?=
 =?utf-8?B?MmNKRmtlM2ZjVTE0clYxVlg5eC9lWDZvdGRzbFlEN3BJSC84Nlh2bWZkYW9z?=
 =?utf-8?B?dFEra29vbnowZ1AxeUkrYURVUnk0UThXK3RxTitXR05mR2pLVCt6aTg0cG53?=
 =?utf-8?B?c002Qmt0UEdSMW1hK0dKWm5lQnptTDYyYmdaeHN0bEljdHdUTy9nV1FQZVVz?=
 =?utf-8?B?RGE5WUJzb3lNVWpVcER3OGM3MjljOFlSek50MHgwYjNSVWZwcHg4elliUEpP?=
 =?utf-8?B?aW9RdjgrNGZBZm9qOWpBNVBJV2c4cW1MVDZqRk0wcHhYNlVMaHFBcWJURkVi?=
 =?utf-8?B?ZCt0eUhNS3QwZGd0Tm4vMGEyYUNtSmdyMGpKRGxmK0pKVjNHSjFEVEtBcHFW?=
 =?utf-8?B?d2VQMEFMK05yREIxTzI2NXYrQ3JwV3dGRUFJN3p5aGJHZ3RqN0dwTXdWdVhV?=
 =?utf-8?B?UTVDS01TaC9yMWJldkx4SUFzUFJ0VjkzTmY3RFZmbXpQZGUvenpmTjY2T1hq?=
 =?utf-8?B?UkNHdWNrSXF1bzJnay96b1RuMngzVkl0aUJUTGhwWjBTVisyZ0JCSHJ6VTB4?=
 =?utf-8?B?bGFaTlpaV2pTY3NJT3Q5WjJ5aU1YWkdRMDdDZXJPWTQxWllKMzlsSFBPYTN2?=
 =?utf-8?B?eVc0NUJvZXFCWkhjOGxhWmNETjEzRisxd3NlNFREVFFXeTR5RGRoazBCQ3RP?=
 =?utf-8?B?SU50N0hXQkVHVk5nZ1U1S3gzZ0tBS2dvaGpsT3ZBb3FMdG4yMCtVUGtJWk5u?=
 =?utf-8?B?SnVTN2ViV2xSaHJ4QkZENkxLRDNxUE1XVlNES2QzYVpGRnZlV2I5WmNpWEk2?=
 =?utf-8?B?OGYySkJDN25vV2xza2JEZjVMNDBtaHA5Z0dEU1pXZUhjRWtBMmRKeXI4SHlk?=
 =?utf-8?B?bVNmN3JESXVPdnQxZUp2Zlk2elExNVdJdEFXUUprS3JZazU1L1RUamRUOWM5?=
 =?utf-8?Q?+vcslLdRchDa6HwuPWSLd5frRFMGd5P2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlpUa3VPQzlWZWlsYW9UcSsybk80VTFhdnFTdTI1NzN6eEdYcnJCVm5yZ1E5?=
 =?utf-8?B?YTY3cjlkWEl2cEhHck1Hb0dNc3hqZjFCV3NMZ1NtcmdlYTArazJvTkVoT3Vq?=
 =?utf-8?B?STZlc3V0NjhSQ2FWUSt1UTJtTnhkNGdSVk1rU1o4TU1uZGlLbzRBZm9BK1BK?=
 =?utf-8?B?UTEzbEdGb3h3cGVrSnEyQVRCaGVBbGt3T2RKTDFnM2IrVzA3WUo2bG5KTnp6?=
 =?utf-8?B?REtvMkJrK1JWcUJZeDlsUERFYWRwWW5hQXlkNi9vZk1jdWp0eTFsN2RFM1kx?=
 =?utf-8?B?NDNBTU5sN3I2TERkVVRqMHFxbUNhWjltVjdtRVFRWVpraFZBM1NYcStqT1pm?=
 =?utf-8?B?ZWJXaTdJYzYrZW81ZEFtaG13OWg4RkFiVVpaekU3eDRSbklySGxVcHFzZmZW?=
 =?utf-8?B?Wmh2RkduUjI1RElRL0k1NHYvVXl5R3lObHRMais5bUZQdkNVTDZ4ZmNwOWdr?=
 =?utf-8?B?cUVPeE9pL0FYN3ZlejVhTktCclpseCtyMmlKdisyeDZFUWZTbm1PeHBnQ05i?=
 =?utf-8?B?TE81T1ZIOW9ySjNvWmc3eTlROEhYTHhMZnVaUE8ySlpnOTVHS1pVTEQzRHZn?=
 =?utf-8?B?amhnYXo1a3BicjNnU2VUeklxck5BUGlWSkdJUlZUdTZPZ2VvN0QyMXZqN3Zj?=
 =?utf-8?B?VzVYaW5BMjFTQnBYNEUyNnBKTXJGSm5mbzgyZVpLa1dINWdvWXdaVzlhVnZn?=
 =?utf-8?B?YTkzQXdQeURwc0ZNS1lkWUdCdVgveStBZ2t2MW1qZ3k1Q1EvQ1lHUUM0RERJ?=
 =?utf-8?B?cytnT0FDYks4aVJJNm5zakIzNUV4WGZhYnhUa2c1T2xtZ3Y0bjlkWk9KTkZq?=
 =?utf-8?B?WlkrRjRIbnNCUkVGMVhnY3VGejhXTjZtTjhXeFYwT3JpNlVDVEhsY095MERu?=
 =?utf-8?B?Sm93eWYrY2ZGc05KU1k3dmxpNWdDK29mR1B3NUNVZHFFclE3QjJSSTNod1hR?=
 =?utf-8?B?ckpibWxnSGFmVW9ETFNtV083TTdhTGwrNUYyejZ3NSt5M1E4bHlyckZFRURQ?=
 =?utf-8?B?c3RRYXlmcnVHWnVUcUV4WHE2bkNHUDhTS1hsR3dOeFlRSVhFN1hJcUpYclpS?=
 =?utf-8?B?MU9aZndwYjhRSHZhMFA4cWtrSXJxTFc4MkN0VUhHVWZQUUc3MWRHZzgxOU1s?=
 =?utf-8?B?TDRhV0wwY0NsZExtek8zZDduQ0dPNmRTYzdyQ3hnbVpBaGJ5RFYwUlFWcmlO?=
 =?utf-8?B?Y29YQk4yTVdENldLeWNHdXVhQVhjSWZhcDN2ZllHdG94K2ozbEMranFRRlBw?=
 =?utf-8?B?WTMrWkpBV09lenMrL0VTL0V3S21aWEliWnhsbVVZTjI0MndSZ2E3OUhuNjhT?=
 =?utf-8?B?RkpTSU01b0c3WnFQZTlZZWxkWFhFVktUSm1ZUUJWaFlNaSs5MllheXFhcVBK?=
 =?utf-8?B?TmNPMDFNUGxDZFlNak94a2gyaXhkbitvNEk0M05OYzNINWhrc0dDcFF6a3RP?=
 =?utf-8?B?UDZCL0phOWFncERUV0RYK1lSYmdvbVJQNW03VDZMY1NKMHdZR3o5TXFKSy9z?=
 =?utf-8?B?d2tOYzV3dU1pWXYxRjU2WVorbHp2S0JmN0E1V2FnOW9PS2F3WlpVcEh2QW4r?=
 =?utf-8?B?SmxnNm9EMzdpaHlCKzJhV0N2MHRCUk03Y3kxZUtjekYxYk1UTmxjS0JMNHU1?=
 =?utf-8?B?WVN6Nlo4RXp5cm5EYVFtTTFOOEZpVDZSTG45L0ZzekUwOXZtYis1TVVEdk92?=
 =?utf-8?B?YnNSY1pqQk5HR1VGL0VPR2ZxMitBSWV3VmROSFM3RnI3d2JmTXZsR25rZS9F?=
 =?utf-8?B?WEtDV2lWM0lkTStvL3pzcDJsbHFkUjd2OXgremN5QmltT3FBeGh3U1dYb2ZK?=
 =?utf-8?B?NWhqN3paa3VkMVpLL2o0V3RNNWdNbS9uWUt0Y2VRU2Jxb09KRU4xaGN3dnJJ?=
 =?utf-8?B?QXRJSzRqaVRteWo2c0w3cFQ5cmRRZmk5OVFzanhzZm1VRzhmbjhyNm44L2lG?=
 =?utf-8?B?MXZBUmFGQWNXR2dubll2MVlzOWtIazlBbHRkcFpaYUtTOEM3VHNOWG1SZ0JG?=
 =?utf-8?B?VjJJdFpqOUJkTUVSTXhBMi9QWVZPTGlJNXRKK1dLVTBLeW96NGFrV2tpbXRS?=
 =?utf-8?B?UDVoL1Fxam94aTVYL2R0L2pUMms0Sy9FcWI4SWRtbE9IMTd6Q0kyUE1LbUd4?=
 =?utf-8?Q?5+xV0sdCT03ZVAols+6DNX3NM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceef1564-b131-4687-57b8-08de2bcfaba2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:06:47.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9P+E1GKb2zTGzNF2RHnldjJoCxubA4n7/5CMNJAJq6z/hByhJRzZ7c1WqIZcp4baBHqZgivJRY2y/Ip+YjRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11557


Hi Lucas,

On 11/25/2025 1:42 AM, Lucas Stach wrote:
> Hi Ming,
> 
> Am Freitag, dem 21.11.2025 um 16:19 +0800 schrieb
> ming.qian@oss.nxp.com:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
>> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
>> error and produce corrupted pictures, even led to system hang.
>>
>> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
>> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>>
>> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
>> Then this allows for successful multi-instance decoding of H.264 and HEVC.
>>
> Is there any more info available on what's actually causing the hang?
> Is there some kind of overflow of the interconnect request capacity?
> 
> I'm asking to understand the issue a bit better, as locking both
> decoder instances against each other seems like a pretty big hammer.
> 
> Regards,
> Lucas
> 

In NXP's internal VPU solution, i.MX8MQ combines g1 and g2 into a single
device for processing. However, i.MX8MP separates g1 and g2 into two
separate devices.
However, I cannot find relevant documentation.
I can only guess that there are some hardware signals on the i.MX8MQ
that might interfere with each other, such as G1 and G2 VPU.

We recently encountered this problem when trying to switch to upstream
device nodes. So we tried applying our previous strategy.

I agree that waiting or locking is not nice enough, I will try a better
solution.

Regards,
Ming

>> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro.h   |  1 +
>>   .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
>>   .../media/platform/verisilicon/imx8m_vpu_hw.c |  4 +++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
>> index e0fdc4535b2d..8baebf767d26 100644
>> --- a/drivers/media/platform/verisilicon/hantro.h
>> +++ b/drivers/media/platform/verisilicon/hantro.h
>> @@ -101,6 +101,7 @@ struct hantro_variant {
>>   	unsigned int double_buffer : 1;
>>   	unsigned int legacy_regs : 1;
>>   	unsigned int late_postproc : 1;
>> +	atomic_t *shared_resource;
>>   };
>>   
>>   /**
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 60b95b5d8565..036ce43c9359 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/videodev2.h>
>>   #include <linux/workqueue.h>
>> +#include <linux/iopoll.h>
>>   #include <media/v4l2-event.h>
>>   #include <media/v4l2-mem2mem.h>
>>   #include <media/videobuf2-core.h>
>> @@ -93,6 +94,9 @@ static void hantro_job_finish(struct hantro_dev *vpu,
>>   
>>   	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
>>   
>> +	if (vpu->variant->shared_resource)
>> +		atomic_cmpxchg(vpu->variant->shared_resource, 0, 1);
>> +
>>   	hantro_job_finish_no_pm(vpu, ctx, result);
>>   }
>>   
>> @@ -166,12 +170,34 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
>>   			      msecs_to_jiffies(2000));
>>   }
>>   
>> +static int hantro_wait_shared_resource(struct hantro_dev *vpu)
>> +{
>> +	u32 data;
>> +	int ret;
>> +
>> +	if (!vpu->variant->shared_resource)
>> +		return 0;
>> +
>> +	ret = read_poll_timeout(atomic_cmpxchg, data, data, 10, 300 * NSEC_PER_MSEC, false,
>> +				vpu->variant->shared_resource, 1, 0);
>> +	if (ret) {
>> +		dev_err(vpu->dev, "Failed to wait shared resource\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void device_run(void *priv)
>>   {
>>   	struct hantro_ctx *ctx = priv;
>>   	struct vb2_v4l2_buffer *src, *dst;
>>   	int ret;
>>   
>> +	ret = hantro_wait_shared_resource(ctx->dev);
>> +	if (ret < 0)
>> +		goto err_cancel_job;
>> +
>>   	src = hantro_get_src_buf(ctx);
>>   	dst = hantro_get_dst_buf(ctx);
>>   
>> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> index 5be0e2e76882..1b3a0bfbf890 100644
>> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> @@ -324,6 +324,8 @@ static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
>>   static const char * const imx8mq_g1_clk_names[] = { "g1" };
>>   static const char * const imx8mq_g2_clk_names[] = { "g2" };
>>   
>> +static atomic_t imx8mq_shared_resource = ATOMIC_INIT(1);
>> +
>>   const struct hantro_variant imx8mq_vpu_variant = {
>>   	.dec_fmts = imx8m_vpu_dec_fmts,
>>   	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
>> @@ -356,6 +358,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
>>   	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
>>   	.clk_names = imx8mq_g1_clk_names,
>>   	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
>> +	.shared_resource = &imx8mq_shared_resource,
>>   };
>>   
>>   const struct hantro_variant imx8mq_vpu_g2_variant = {
>> @@ -371,6 +374,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>>   	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
>>   	.clk_names = imx8mq_g2_clk_names,
>>   	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
>> +	.shared_resource = &imx8mq_shared_resource,
>>   };
>>   
>>   const struct hantro_variant imx8mm_vpu_g1_variant = {
> 

