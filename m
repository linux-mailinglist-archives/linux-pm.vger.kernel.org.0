Return-Path: <linux-pm+bounces-18522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BE9E35EB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 09:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A75169DCC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45971991C3;
	Wed,  4 Dec 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="Uc+vB0ym"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2124.outbound.protection.outlook.com [40.107.22.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF37196C7B;
	Wed,  4 Dec 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302245; cv=fail; b=EfZ3ETRDpD95uUv4/xznhlE2B13IbeadWaetYVCG/h//4vjGXPCNXRx8XwAyLZ+7mmOSFzgoMUkZjDH226br9wvCtGfNSzodg+9f17Yn6aZAgZgKHQsELVkb9Bni/Dk2OAPezQED3lRWxRg/X4ZQPEfXB7HhWjqwcOMHwEHz67A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302245; c=relaxed/simple;
	bh=7PPqNW5UuyAP1lvEoo1wqQNf8Dv4mGf17/9xfWvTVeA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UvVzLOuRGhGmWSfqIrRSNhzzmTJpsSrgME55KlWuABjHRA3AP0JiRMyOWkVb97QyUAjA391w3gcJSsDrVlAUbg31dHBujtWvdwf8/b6Z+Au8fnTVQYwzGLZEW7PPCLI31D13msBoMWar4dCOe3YGP034gyzjPr2ka7wmgZzoKzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=Uc+vB0ym; arc=fail smtp.client-ip=40.107.22.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsPJJ8Qb04xKjuJa9/Xwb38XqnW3LPox0mYriZzWVqsdPBypXQ+ahWfcHhb9lMR4FmpncV1rR8KEquv1S0JXpovW2Xdm+JJYMeKaYZWQuoBx4MmYBmAObuu1gBe8DD3S1mcu5/DZE14++xwFOYWBpT9BmAZ9FBWgP90ltTDnbeYE4jcKh8/5MtvLHRb5rx7NgW+du9eo+RFzO9Js/u4fEQXhvRxO0FZZwRVuiMtdjYbP2uZ8hr1NO2YPVPUirWuGVSaWF4K4ysmGdtSCemtH0g/Aia7CId2G2+CUBgVlN/jLbRQZt4wADpTW+H39b1ur1uopUL3hFVs6OilvrVNN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDMVfpYvuwEP/lRAz4CK7RvbhG5cax8UxvK6rsWdc2s=;
 b=CvWOpUQwfCcbqRYclJJuvCuLi4lEjztt7LtBLJs5E9B55M1VBffilS3l1HHvbVvbEQnXjv6lD8Lwmw2jsdpTGSJgqEnLfqbuc8FgiSfrvzrF0tnG3duMfuMPnseJwn0BaTdW3lPJEFphCd7y+3Oj+gUGRrF/hb+UlWlTkNwEHNjI/GPPCRNoOApUauf0fJeIEA5vDvZ/WMe2xQHAtxLrRkYyHgtutJIUULRBRT7v9DV6zXqKBcu4e030ulu0xvcs+GEfx24DFOcSzbDepoZdDY0U+CFgiGSS7P6AkQmn/fni+OTVY/aXmYireIpRCfY0ZsD5aHnNxPiGvtTa9hrNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDMVfpYvuwEP/lRAz4CK7RvbhG5cax8UxvK6rsWdc2s=;
 b=Uc+vB0ymQF/Hxf2t1xh1cLP61/f7SCL5gegLid+g+mkpdlM6d6U0ys3IJafKf1pu5cXi1pByIH9JoIZEmAZxBBg3WkLfP8Qg/bdoMjDRGcXP5WQJJT+s5fEPkTJa28T5oF2uKgcZeq2PQYWNSPthp6oNbNenAxWmE6yI0AKKHxI0J2jZwi+2a5KElD/alALrUy9EqflpYeWQz/Xudg8IzcPzk+dW6N3juOY3afjWbBmOq3vMNfU8onN+hvtZxb3K/LGRU45CLh1eUfPQpdstGa+IViAC4M1e4YKXBqe1tXfEH7FmLxczdLAXx5MoyoGtf5k2va2eIxIuYhptp7/a7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by GV2PR03MB9474.eurprd03.prod.outlook.com (2603:10a6:150:e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 08:50:39 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 08:50:39 +0000
Message-ID: <ed9cf02b-6f6e-46b5-a583-4fd32fa31a91@uclouvain.be>
Date: Wed, 4 Dec 2024 09:49:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
 <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
 <8f585460a1bc52f78a6d0867aed87398bde30152.camel@linaro.org>
 <18629c9edd295a524a1c9764f013a0e97e0b275f.camel@linaro.org>
 <61a54367-2406-4106-bf8b-9fda4f2d11a6@uclouvain.be>
 <d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|GV2PR03MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: dcae149f-75dd-4a84-0390-08dd1440b9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0p6KzQ0c3AxdnMwaWJrOWh1ZTYzcFVSeW5XbElrNUtHbGlPdmRZMkZTdkNO?=
 =?utf-8?B?cFBNdks5K29XZjlxTkdlb3JJQ0ZYc3dKd0VBNTJKZkVxZzUrZTBCUE0yMjhS?=
 =?utf-8?B?eVJKbUdzcmxQQWtMa3NUdmdZVmhyaUp0ZU40OVpRM3FsZXNaN1gxTE56cmdN?=
 =?utf-8?B?VWg3UVh3OWJJK3FvZVZuUzFUSlMyeHY1Y1FLUFJiZGZsWW9oNTdTUUZqQitQ?=
 =?utf-8?B?RHNINGVrSTNKSWVPR0dCVDJKMSt1TVRUUWUvNlRpUi9lalR2YUxuV1VyY1RM?=
 =?utf-8?B?VU1saDVJTVJVeEIzb1VpYU1WcmR2SGU5TVhNTFQxMi9RNmduMDB4N2dweExq?=
 =?utf-8?B?b1hxcFMveVdqdmEzRTdyUSszL1JZTE1ZYlluS29KQllyWW9VM3g2WStuSzd3?=
 =?utf-8?B?WkwxQk9Ja25wVzd5OStHRG5EU01hWUg4U2hqTmJKWGZTelVPWTdmQ0xHV0pU?=
 =?utf-8?B?K1E3K21sT0tvTmM0bVR1S3ZNcGtXZjVaT1g2cktncENzWER2M0FrdnlOYW9l?=
 =?utf-8?B?UGQ0OWEzN3ZqYUFpeHFMbTFBeVpPelpqNFlhMnVtSlFzWHNvYkhYakFsZ3lK?=
 =?utf-8?B?Y1BLait4YktQYVhpVDJGMldmb295cXdCbFQ1YnVGTFFMRDVPdldmT25hYkV1?=
 =?utf-8?B?THhwb0Z0MUdlYUtMWUNsWUhzQUtYME04M2JoRHFCNFZYc0lWeGNNd1JpbFFn?=
 =?utf-8?B?NXdIU2N1RjFGbnlJalhjZVFhUmhveWsyekNiSFdSREhMVHFHNnNnTzZiemh1?=
 =?utf-8?B?ZzJ3ZTcveGZRWm16cHFicmV2L3FOQkdJSXA4Q1hIQ1JhV0NUbUhScWdnOWhD?=
 =?utf-8?B?c25TN3VsdVZuMzhmUlRKOURjbjdFZEY1WjNnY2hsTUl5elVsUFJob1laUmto?=
 =?utf-8?B?b2I1dUFyeUVpR1BiTUwxbXhNMTE1YnUwVDFIZFlHazNLWWVXb2VJOUpJa0tM?=
 =?utf-8?B?Qmt1L216cENGVzM1bjFIMHpXSzljNWpvRG96M3dLZkFySk82Yzdtd0N2b2po?=
 =?utf-8?B?elZmZk01TnhZNnF4cmlJRjhFN0pZN3JpME4vbEZPSWt1TW1pcXBWZUVvMTBx?=
 =?utf-8?B?ajRtR05SY2JlenBXWjdtNjBLT0NZVlFMN3FERnN3Q0RoQVB3RzBOY0V5eDls?=
 =?utf-8?B?MmRqOHJuNDBteHNuWGt1VmFpZVNSbkhWM1RHMEptZmNmMTFqKysvNFk0cUZY?=
 =?utf-8?B?VVc0VElhWlQ3bitUNnMxSERHUGUyQ3k3NUh6bEdrWUZVaEppMnVTNjBpTy8x?=
 =?utf-8?B?dFl2b3VpdC9nZnZTcU9wcGxUL1BiNXpIOXRMdUovZTBSYWQvMTh2SFZicFJ6?=
 =?utf-8?B?akxMTWlZcktCMFhTSmhDTkZ5U0JHV0lBbEJ4UXRmZHhWaDlwbDhxdkdDbUl0?=
 =?utf-8?B?MUJVUlNEamljWGRjTnVGaWFDbWs1UXhtbUtuMVhYajY5TnJueU1XbUpCZEFQ?=
 =?utf-8?B?MytGQkVzcjVPUGdtQnl5NTVFY081b2p5WkIrZ0NnamVSeHg5UGVTVEc2U21y?=
 =?utf-8?B?aWdNQSt2dVdzT3pkdFdTbmVsU0dReUpOaFQyUEtGekltRzdtNjJ4YjNOMmhU?=
 =?utf-8?B?aTJyZHI3dHdITnZ5ZHRYcFhTc2RVQ1ViaDFRWlNDR3BWZ2l3SnJMRk1jU2ZI?=
 =?utf-8?B?aHNBSjhmeWRjSzNuSUVqamZjQWVXbW5HVnk5dmg0Z0hyRllDMXR0TU9lUXJW?=
 =?utf-8?B?bi9PMmY5cDZyTXNlRFhCbXJlY21jaUhVQzljclVvOFNuUnRTQWNlU01jNVM4?=
 =?utf-8?B?WjVGK1haVThPRk9ST3Q1T3M0ekU0eWFrWFVPTzcwbXdNYjBwbUs2OFgzU1FU?=
 =?utf-8?B?bHNTdFQzQnJhandIeUdlY2RtMFVUTGZoUkUzNDZDaldmYkZGaThJdVR1OG1F?=
 =?utf-8?Q?Lw9v+hCjRK0Ea?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enFYdEoza0ViN29UalJERGI3WkpuWGdkTXBiekMyQ0xsWU5NamwzcHJhYmhj?=
 =?utf-8?B?cDh6clAwdmRYT0RYNDZaNXBKVDBXbmFNbllINVc2bFRMWCtaMEQyaVNmY29Q?=
 =?utf-8?B?aUlZK25vQjEwTVlsM0JLbWpzTW00V2hGa2lSSVkrUmFQTytIMlJKc0dUSFVj?=
 =?utf-8?B?VWJGRzVEUDhwMG5rZFloRzR6M2YzSllZQ2ppYTNaREF4QlhFeTZUeVYvQ2gz?=
 =?utf-8?B?Q0MrZ2V1Y2ZXUDU3WkJpRjRTYTFFOE1MUEZVRkdOSWNsbkwza1RxSGVWM0tO?=
 =?utf-8?B?aHc2akc3V3FTRUZuUXMxRzYza1diOE5COFN3SXlobmtadzg3VW9sMHhtOXJ1?=
 =?utf-8?B?eHRyTGZaZWFjZ3ptdTFzYVJkRVAwUnlFUG56YUNNYVhoRGExODJTODlaRExY?=
 =?utf-8?B?ck02andHeTFxbzRCR0czT1VxOEoyZVlWYngwbkl0SklLd3RwdEc2OTJZblhw?=
 =?utf-8?B?VzNWdWVOWUhNcXByWXlsT2pVYSt2azByQUhxZ3pUa2QvRVZFUi9mc3NZR2VU?=
 =?utf-8?B?RHFXOEM3ZEErbXJIREk0OFlzWFlULzlWVTQrTlYxVVlnYjBvV1RhQWdpWUQy?=
 =?utf-8?B?SnBSN3ZMUWNBZExTcWovN000QVhxK0M5TEN3QXYzK3JEbVQrakNZN2ROYjdv?=
 =?utf-8?B?RUZhRmpIR3ErWnd2UWpnMWFrbUNZbDNmT2RvalNmTC9sc2RidWd1T00vSUZ6?=
 =?utf-8?B?eTUyQVIwU3JvRzF2RkxhWUtyOUhwNm1uY2lSWWxHb3h4cm8rbUlFUlpqM2xH?=
 =?utf-8?B?dlRIYjRxWW9XL2dCYjltTFFqS3MxVmhUdkJsbmJhUzlYVFBMdHovQmlCczJY?=
 =?utf-8?B?T051VVNOWDRXbDd6ekdVU0lpem1ZKzVCZkZVVkY1YldpQzlQdjB2M211TTE0?=
 =?utf-8?B?ak4vZ0F0bW9Wci9ubEo3a1Rhd2Y1cVlkOVQ2WjAvcC83MzR6VWR6RkthRFcy?=
 =?utf-8?B?QStYbGppbUJlNXFTNmowTStUTWRqZEpGSXgrYmVjYXpuMURCUllnK2RlZTlJ?=
 =?utf-8?B?WmFnaXV1aXZhS0FyNFpPQUxBTmlCemdlbFRpL0dySW5UK3pDRTM2b1g0ZTFT?=
 =?utf-8?B?SSswTGx3UFBObEFPUnVWR1NpbUoycXdUNWhlNFppQi9yQWRIVDRmZUVrajE2?=
 =?utf-8?B?ZzV1YTdpTWdWUkZOZTBXdUtyR1FyRlB0OThBRlBmNk4yTCtvTXRPTkoxWFhC?=
 =?utf-8?B?WFVMTUNVYTdBczIvSjk3akhZMk5KS2QweDhab2JEQmVuUGRLTTE4eTNYbEU3?=
 =?utf-8?B?ZzgrSjQxYTdDNFBzZ1pHYUZPZmh6eXNhcTBwVHJNNlBnUXR6MDBRS2lReXhF?=
 =?utf-8?B?QXQ4Ym53QXhUSFNJWUFaUnNoVmdqRXoxOHNtcWloK2VoZU1NcHhCeXUwRnhm?=
 =?utf-8?B?YUhPTXA3MElTekFhTmQ0eFRBZHhZQnArT1dUc3FNbTlZeGhzbTMvVVdhbzFr?=
 =?utf-8?B?NDJjbEpmZzlNTFRvczV1OWxQUjF0RXdZOEhlZTFxaHIyRGdqWkN6ZUhSb004?=
 =?utf-8?B?SGhRMWdDWGJvZ2tsSHNmTUxWVm00bUhkMCs4UFoyYXM4OHUzdnVGQVV5Z2pM?=
 =?utf-8?B?bys3ODhJcXB5eTlQZDNjWE10N1UzUXdlVHl3OVdYK3UzM04zSHkwc05FN3hz?=
 =?utf-8?B?c1lPN2VSelFDendEYXNxdiszVngzUWVXbGs4Ny9FZHd2YVlDQWs4VkJ3Ri9V?=
 =?utf-8?B?STkzZmo1TEJvMS9nYWRjR1NUaFU2UHE5bDJWKzQ4Z1BWRlVqeWF0Zm9MYUo1?=
 =?utf-8?B?YzQxYUlXZlNFVktPdG1wK1U4R01taURYZVZBNE5BTEE5Q09RaEFqNno2Tnhz?=
 =?utf-8?B?ZW5pYjBHUEpSaEtTM2dTSDNBTWNRVFE0MDVkOTlaZkFiQi9hRm1IU1kvYkRH?=
 =?utf-8?B?L3ZWblA3ZHZzOWwrMEZaWlF2aDhEOWx5UUE2OHE3QStkVm92NlpOZy8yK2V0?=
 =?utf-8?B?VkU5MjBKVEhGRmZFSjJValkyRFhGV1JmMEZsbUVnK2hhY25ROGpZRUpIZnRm?=
 =?utf-8?B?am9FUEFBeUh1c3RHamR1SlFRR3FMZVdoTHJ6cnk2dGo0Tk94RjZsNVc1dmM2?=
 =?utf-8?B?TGw5akxFcVBLT1BhWVRNZVN4MzdpTCtVbVpET0dHcXU3WHBSOVZPVWNTeE44?=
 =?utf-8?B?cFdLaDIybHFqOWRSRUMzS3RJRS9PUWUvaHlJK1dhNldDTEpWcW1ETXFhdlhU?=
 =?utf-8?Q?q35WmTmii7Rp6OPMh/gc9oMTXRTOd1KoZn0TB0zK3SAg?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: dcae149f-75dd-4a84-0390-08dd1440b9f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:50:38.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYRbezzs3NpvMrmGWSa3tkpeFGghYJZkEnPjMe1kApGTEEVn1wObnvuTAYw4fkoftux7uoD0lnBbZr2Xdviyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9474

On 12/3/24 12:06, André Draszik wrote:
> On Tue, 2024-12-03 at 11:30 +0100, Thomas Antoine wrote:
>> Should I explicitly deny their use in the code for the max77759 or is it
>> just for information?
> I'd probably do something like this, which will indeed deny their reading
> and/or writing, both via debugfs, and also normal driver access via
> readmap_read()/write() etc:
> 
> static const struct regmap_range max77759_registers[] = {
> 	regmap_reg_range(0x00, 0x4f),
> 	regmap_reg_range(0xb0, 0xbf),
> 	regmap_reg_range(0xd0, 0xd0),
> 	regmap_reg_range(0xdc, 0xdf),
> 	regmap_reg_range(0xfb, 0xfb),
> 	regmap_reg_range(0xff, 0xff),
> };
> 
> static const struct regmap_range max77759_ro_registers[] = {
> 	regmap_reg_range(0x3d, 0x3d),
> 	regmap_reg_range(0xfb, 0xfb),
> 	regmap_reg_range(0xff, 0xff),
> };
> 
> static const struct regmap_access_table max77759_write_table = {
> 	.yes_ranges = max77759_registers,
> 	.n_yes_ranges = ARRAY_SIZE(max77759_registers),
> 	.no_ranges = max77759_ro_registers,
> 	.n_no_ranges = ARRAY_SIZE(max77759_ro_registers),
> };
> 
> static const struct regmap_access_table max77759_rd_table = {
> 	.yes_ranges = max77759_registers,
> 	.n_yes_ranges = ARRAY_SIZE(max77759_registers),
> };
> 
> static const struct regmap_config max77759_regmap_config = {
> 	.reg_bits = 8,
> 	.val_bits = 8,
> 	.max_register = 0xff,
> 	.wr_table = &max77759_write_table,
> 	.rd_table = &max77759_rd_table,
> 	.cache_type = REGCACHE_NONE,
> };
> 
> And maybe without cache for now. Most are probably not cacheable anyway.

Thank you very much, I'll try this out.

Best regards,
Thomas

