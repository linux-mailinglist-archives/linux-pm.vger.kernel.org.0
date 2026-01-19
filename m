Return-Path: <linux-pm+bounces-41079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F246D3A4A6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 11:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D08C3038954
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928F280A51;
	Mon, 19 Jan 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BW9IQFaH"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953121B9FD;
	Mon, 19 Jan 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817895; cv=fail; b=GWLuYVF8LrbSf6HV7opOO6ByjTOTft8x6IkzAqd6W/V6xtmfqF1L4E6lxcE7zRhFPk2gyNrScjSr455rg2FphkmMAbWdye+zFYxge1JvZ3kXNo2BL5+bG7VpRae+J/JBzXBqf1Y0rue6nUWl1DAvaYcyBWR7fSjK0S30mE6WlGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817895; c=relaxed/simple;
	bh=S5sFnPIbvCDwKiJwq6MVFV9waYl29NVYRbWN16f0VQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNikXe4LWT/+kf3JYwgoe1Ry+eXys8RPz9pEaPeD2LJKbbO77iJlNCEk/O5foWBYvAPZShUrwUadWZyWgN3WcKOZH26BEmwKDFTv85TQoROfNZGcjChJBWCwTvcKzY/m523dm7zCHyIt6fN02+keCqmZxy2yy+bhTCyJi2nrTVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BW9IQFaH; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH3TAtTvPSGQYi3dXg1HaubveYRFJZzuXoRjWmO+OyF6s8RgpzKo8MVbqjbnUzEm/eNSO/Zao/k25MyYIIgyZrBP5AqgGWn1oO3BtdLo2DpAzQ/sJG3xZgEYpDywrbKR2amxksFzJokU7HHZ7VQ3CZYKvxx2lF8aeslooMMyM/NZtx9zzRg/MbLyqY5fjHgN7zjENMbRRWpiOIin1CrpeeSk40nS0ECVhAQmN8XugHJce+5xPmQVUWyPoPeA3nbDzj+JH937J5fBaYaKXV74RSMqv5e4HIFP8ZGwRr0tJWfT6SqbKn8oKysibLglfNXsQ43tBmVbMqewootpq2TEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5sFnPIbvCDwKiJwq6MVFV9waYl29NVYRbWN16f0VQY=;
 b=XstWP+DRq9cUA15AoN2kMubU2YMtco4xBl++k8x7LkEjd4D1KTwqXuSa3H43wnbdCbLUaksTdq3C+oF7tG574VU0qQALkFhN/bDwgs6nH987LC2y6dudjhxskCZJ0jt9BhfbGD0VN+M4voppWitu0bB9mJfo41jF6ElpSzW9fO0vu3zg6yLRaxBi2Fc8hQ4Bc9cR0d/m/XLnFTkOvKgZlAttJUrvjJgRO6gqHiY5FfsmPA7/X7BuHKOZYbGw9eMUmdMTZCBPf+PpEvqKoPvdW78Zprau/xLyT1/nxjaPM7O6jIR9+/zkbU990durW7VFfYRrp8WBNa0vNnGCOkScdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5sFnPIbvCDwKiJwq6MVFV9waYl29NVYRbWN16f0VQY=;
 b=BW9IQFaHA5fU2VsaF/BFnyHJJbemX1+QGiLcDErKDbWUHGpnu1DjsjLd4mxd15gFn//nTEbxH19ZumuiczferqlqbgOZmxUItxlTiE67pQE0tjAxfA9m7heIMperrkQ/YAAY4K3XMQibb/ZZTjmw08HwA9/IN7ZgGskJnBzyFnsgYf7qSP7kovj8sCoiBgrSKaCpZ8qYvLlkusQ/Ec/SXgnaX7G6XWfQ+fngYJXfhulQoRu2grjxGkzNsW2PLCA6lwWNwLoktaTsyWDVVkyVyLVzj5++lBiX4DvsnJ6+brSPdxDAgmT9g8o6BfvcqFpGlg3WWKXTKRZQAB2SQoQtMQ==
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by VI0PR04MB11669.eurprd04.prod.outlook.com (2603:10a6:800:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 10:18:08 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 10:18:08 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] Fix the imx8mm gpu hang due to adb400 reset wrongly
Thread-Topic: [PATCH 1/2] Fix the imx8mm gpu hang due to adb400 reset wrongly
Thread-Index: AQHciSElqb8eMfYnlUy8S2i6O2x6bLVZRLqAgAAAm5A=
Date: Mon, 19 Jan 2026 10:18:08 +0000
Message-ID:
 <VE1PR04MB7213A1AE9B3347964AC144348788A@VE1PR04MB7213.eurprd04.prod.outlook.com>
References: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
	 <20260119-imx8mm_gpu_power_domain-v1-1-34d81c766916@nxp.com>
 <f31eef1eb99542e99486f3df84c90c304b7f2c9c.camel@pengutronix.de>
In-Reply-To: <f31eef1eb99542e99486f3df84c90c304b7f2c9c.camel@pengutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR04MB7213:EE_|VI0PR04MB11669:EE_
x-ms-office365-filtering-correlation-id: 5edaeb13-b619-4167-dcef-08de57440b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVlZME1EbU55QloxeHBMUnVuUDZ2enJ2c0M1RHFpWWZ3Zk12SVFvVlpQdlRI?=
 =?utf-8?B?eWNKbkRnK2VHNnVhWVRxTFIxcjREM0I1ZG44aFBwdThqdmdYYUlNdjVMa05v?=
 =?utf-8?B?K0p6U2dzTExCS1FSd2d1OFNDTkRRWmNLTFZsSTM0cFl2M2k1UTcrNEMwaGEv?=
 =?utf-8?B?UmZqL0UzYTJjSmU5WE9SUnVsQkxlU1gweWdaZzI2ajNYL01BTGdsd2ZmcElF?=
 =?utf-8?B?bWZSc1MrRHhIZDZ6bENqT09UWVBlSmlrUnhFbDZ2SEd3ZlR6ZmwwUm9KSDI4?=
 =?utf-8?B?OFhQd3JxMHBCeVdMRmNUM1UwUjNESHg1VGRkTUhTdjIySGcwY1hwOUsrL29h?=
 =?utf-8?B?KzkzZURwdHF5b3RQUmplcFg1N2NqVEVFb2RBSkdXcFlXMU5EeERUYjdBcCta?=
 =?utf-8?B?Q01rZ1UzdEx1ZExnSEc1RG5jTHRpMDdZWUtnSDQwS045cXJ4SXZvTkg0d0NX?=
 =?utf-8?B?Nm93bVM1Qi9BNzUzc21EZVF0Q0o0NFBJSzlwT1V5OVo3NW5nVnhRaHVnTjYr?=
 =?utf-8?B?OVM1L0ZFdlhXMXYzWVI3VnE1WnNuM2h6Y1dncnVTQml1b0VGV01wc2dsSHJr?=
 =?utf-8?B?SXhvZWtSNnhKejNzQjdMbWlvQ1E1NnduUFR4TnFrVUhNVktEd0kxNjIzMmZO?=
 =?utf-8?B?TWhSZmhwWmE3Z0NWdThldUVkM2lmeERJZTVCaU5PYmpNQmxvRmlrZU9SbVRl?=
 =?utf-8?B?UTE1N1BkbWROWEV5K003cEJQM3g1ZE45TSt5ZVhiWTRzVElwOFd0R2hYeC93?=
 =?utf-8?B?OHN0ODlsRTlHSk0yemFabWI5TVpXK0VRaHVnb0tiWnZYRFE1QUxRNFpRZlZO?=
 =?utf-8?B?dzRSYTJtZ1BBMjlWbHFWUXA0aVpIWURESjNudVBkZy95ZVhpN09IbUhtQytj?=
 =?utf-8?B?clF0Q1czMmxiZmNtRzNMNzQrb2xjdE9SdUZ1bU4wdE8yd2t1RWdOV3FTcEM5?=
 =?utf-8?B?UnhiSGdxTjROMGgzTTlLcnZzMXZ0RWNHVW1zYTFaMTcvcWQvWFZOSXFNT1Mx?=
 =?utf-8?B?ZThwUy9hZEVsSzN5ZEJ1TWJnUURaT2xudWprRVVpQXZSNlFjZmRab1doTkhj?=
 =?utf-8?B?WWt5VHlZamhGeTNiWE5FT21LWDVDeEJsZEdnbisrQlRKdThiU2h1OXRzZDJk?=
 =?utf-8?B?NHpOdkJOWjVFT2RSaVVqdGtyM1JlN0M2M0lENithMFczNzJMTW1WeHJ5TlNI?=
 =?utf-8?B?QTlETExuRnNSMnVVRWQxUGEwWkdtZ21zLzFoTmh6NzMxbnAvREx2akRaVXR1?=
 =?utf-8?B?bjUzcFdITmY2V0ZXc2p1aUh3cWh6V2lUZVlCVVN3UU9IVHROaFU0dzlvVlJU?=
 =?utf-8?B?VHlGNjlvcnhRVEt5dlY2NzRTNkwzeCtJVjlsSklWajlUTFBXbUlnZ21ob0RW?=
 =?utf-8?B?NWc0ZUhtRzFEZ0F1SUlrZ1R5bmF3YXdBY0JXTVhpdWs4ejVPNjZKV0pGbWd6?=
 =?utf-8?B?aHBCUHJIbjUzb2dxbk56R2owSjBIRnQxbGNFVUp3ZGs2U1U2MWVCbmIycHB2?=
 =?utf-8?B?QVI1S282ellidDhVRU9QeGszTlM0Zi9pOG5LM2duVmdDMkhhQTNCRW5MWk83?=
 =?utf-8?B?UktKdjdjbWtXMFZBandzN1hkNkc5c1NaSWFZUk5OT1phdDRiZUtqZnBKcU5v?=
 =?utf-8?B?Tm1iSTUvVlBPNkFFTFNOVVdRVjlnR1hmNFdac0lwZjl5SHRBU0V0S0k3ZVlZ?=
 =?utf-8?B?cjJVL3dPTlorejRDZXVZZ1VXSmg3c0d6N2t2QnFLREZ6ZkhoSzJiRE45Q1JW?=
 =?utf-8?B?Z1VyeXNVK3FHT0dybWlXSEhIb1VHTFNhQ1gvMmxVd3FPb095RzNlaGdTNi90?=
 =?utf-8?B?MERwYjFzL0s1OUFRalpLOURFTFduWlNkbHplWFo2OFU4M21na1pQd29KZ3RS?=
 =?utf-8?B?NWZBN2FlVUNWNnh6REUvNlQ0bVR4R1lMNmpOWkQ3eWIrWEpoUVFHYlZ6dDhI?=
 =?utf-8?B?eFRVVldPa3Y3NTZxaGVPSExSN0ZsNWR5U2UzbmsyQVkvUkpyaVJ5NW5ZVnc1?=
 =?utf-8?B?dHVnSERmQXRvMTMwc1VMTjdlZnRrcnh6a1FvQmdTWXFtUlJ3aFllQlZhYzdR?=
 =?utf-8?B?b2Y4QzFnMjUzYjQ1ZEJYNTFOcFBCcVlxOWFhUllkc0R3OG4vREh1bk14VnJj?=
 =?utf-8?B?YTl5TXIvWkU0ODYyODNQQUtFK1QvR2MvdWpIOEtMZUs2WnFuVFlPWVo2eUNO?=
 =?utf-8?Q?5xigwDcEonNU43DifPlvNLY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXltdlJKK2lFZUR1aWJWM2NKaHRNWkdjWWlXbDdlcGpDdk9JSEs4UGJlL2lt?=
 =?utf-8?B?cUFkdmYyb0MzUXhNN2RkMGVkOFc4cVFrNTRCVEljcEs5L2ZqYnZOUFRPaGxX?=
 =?utf-8?B?ckduc0JWR3pMN295MkhEOUdSOCtKSTJtU0lPeVc2MUUxQXNnb1pqa3NGaVVE?=
 =?utf-8?B?ajFMK2t2c0NtWjdJaWR3THc3MXkwT0lBUDFoWS9KSVg3SU1GUEpqNlo0QTlL?=
 =?utf-8?B?QVlyMUU3Z3JIRVlFU3NCNTQ3MW1WK2NycHErajN0TERHWDZDcmJpRjdlbHVk?=
 =?utf-8?B?NENsRVZzZ0w0VHNEYU9GamMrY0JxY2REZ3B4K0xOMVllTFpyTnV5ZENxSW9y?=
 =?utf-8?B?VUlLVmVQTFNVcFkvR3plUHYwZEpkR0ZpdUsxK0RrdVh6bFltZjN6YStJVjNI?=
 =?utf-8?B?b08zNTNjM3poVnJDaWp2dTRSdVlIbm0yOEI3eHovSlZRc1cyRUFhZ0o3MmVN?=
 =?utf-8?B?Q2dIV1FzNVczNCtWVkt2QksyTWRsN2tZWkdSVEx6ajFlWko3aEhYR2JlcFdH?=
 =?utf-8?B?Yjl0ck13cUwzcDhhYzFuekFjNzNDei8rb1FVaHY5WGlTL1owOTJPYXNqQlZx?=
 =?utf-8?B?SHdwc1Flc2tuVG40MjZrTjR3TjliSmJ0VEV5c29aMjd6Tkt2czZuWjJyaXN2?=
 =?utf-8?B?emtsQ3NZK1dUaGNEZjRRMnJLNlVvVHdIYUhsNVdGVE4wNGxDaTZaclVST1g2?=
 =?utf-8?B?QUtuaVlkdnR6T2tNZFhrVndyY0VYQitrSFYrUVJPTTdIazhVZ01oQURIejBw?=
 =?utf-8?B?dkViYVZtSGN1SXhPRktPVGJKRk4vMkVJRG1oZmdyUTV4bnQ1aTFra2QrOU5I?=
 =?utf-8?B?dnhNa3pUeHh5QWhqU0paTUFscnpWcTJpcEFiT1V5STkzN0hYVU9IRWNKNmVI?=
 =?utf-8?B?ZDhjTVJ1VzIvZHVHQ1o1dTh6Y0NUSHhWVTNBczBoZE45MnYvWjl5TG5Za3ZI?=
 =?utf-8?B?c2tYVWdZckdJeFNWUTk3cDVMM2pOOVI5Wk9FTCtDcVhSRXE1bWFQUWpJSWV4?=
 =?utf-8?B?ZW9wWWRnT0hqdE14SFBUZGozamZKaUp1OWJwWE10aTYrYk5UZG4wdXdiQVFY?=
 =?utf-8?B?NGc5MnQ5ZjNKZEx2alV1c2VJWTRRaEV5Qzg5TGFOZUU0aHMyQnlFVHlmNEp5?=
 =?utf-8?B?UnhsUEpaRVQ3cEZ4bGNremV2dnFzNGwwK2Fsak90c296TkVQVldqRDNPWWIy?=
 =?utf-8?B?THNGZlllWm5KQUpWYnc3WWI4cWJxNFlDV0xjcUowMFg2ZlpGcndEMVhiMHhr?=
 =?utf-8?B?NHRtZ3d3bkRDSUZpdFRaMmZhYmJXN0s0ZDBXb0pCbGE0dHEwbnFYQlpWalFN?=
 =?utf-8?B?VU9Oai9RQXpXMkRLaDVRRHM3Q0luSm5UQzNQUnBrUC9vYWM3WHQyd1UwRnlZ?=
 =?utf-8?B?UUVCUmRBS3pJeXJQRGZhTzJ3OUM4RXliZzQyUEdTWTdpK2NNWEtUeHA1UEZ1?=
 =?utf-8?B?RHFpOGRvTHNMMUY2QnRnV0NKSENJdEpMcWpSNGF4MCtMRVYwRE41cUR2Q1dT?=
 =?utf-8?B?NWZvU1lRU0FJVER2OFNWK0NhVmlXMnd6bG0xQTFZVG90R3BicjVRbnhMOVdN?=
 =?utf-8?B?ZE16WUVHRlFLdnpOb2w4S1pmc21uNkYvZ1JheGJtaGoxRnp4c0xLOWphUVVM?=
 =?utf-8?B?Q1ZvNG5nVGdQK3BHNkxaUkl6MlExY1QvVlEvdTdNOWx6ZTZuakplY0ZDbUd0?=
 =?utf-8?B?aFhNUitMc2F6dmowV25BZ09HSlhEVHRRTGs2OU5ZTStxTjZRdG5adXdvNDlL?=
 =?utf-8?B?VkRyV0kyVE45UEJZZnBPODlGK21PNjg4dXY3SVJnWUFJMCtyOVlmdjdTWkxL?=
 =?utf-8?B?eGVONEVxcVJSa0FqWitaYU4xT1NvRVNMQkdLRCtSUlVKZTJKVldEc0tFZkxl?=
 =?utf-8?B?RjVGU0V2dVd1SVZYallKTkQ4NzlQRTNpVTUxNzlVdnpVUkxYYnFiUWxJY3FR?=
 =?utf-8?B?OVlVL1M4a2U2aXZMaTBaem1vQ09VUDV4cmlTT2NpY2pNTHpxY3FMaHB5SExi?=
 =?utf-8?B?dkM1MW1zS2lQdE1rNEVmejJyeDRCOHJwSitzeFU0MG1jbVRaUG8rNlJJcktm?=
 =?utf-8?B?ZjBZUEFwbFMyR0Rmem50SjBKbVJFTXJleExkWHNMYUw1M01BUGFDWWUwaDEz?=
 =?utf-8?B?dWY4NS9IWit1QUFDZXNRazVQRXB1TjlscExGWmVWZUlHSWF3dmduc0RFVmpq?=
 =?utf-8?B?ejBVMFhQOE0rT0hIR1FNR25tZXcrWnduL2V3eVFMMytVdjZBR1JibmFoaHpY?=
 =?utf-8?B?S2pmTHp1VlhmY2t6MlE0dzVQTDk3NXh1cmUxaXdQbG9PR0w5NU1tK2dNK0NI?=
 =?utf-8?Q?zlE29UKnHdNNYkAEgL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edaeb13-b619-4167-dcef-08de57440b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 10:18:08.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIrCPJyGRkvGXa4s3zwHvHyeN16UwGRon5dB8JJMGGGKvUDOJgARTAOV+0CjAgfHz4cC0k2w5pw+02uS/WNVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11669

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gRml4IHRoZSBpbXg4bW0gZ3B1IGhhbmcgZHVlIHRv
IGFkYjQwMCByZXNldA0KPiB3cm9uZ2x5DQo+IA0KPiBBbSBNb250YWcsIGRlbSAxOS4wMS4yMDI2
IHVtIDE2OjUzICswODAwIHNjaHJpZWIgSmFja3kgQmFpOg0KPiA+IER1ZSB0byB0aGUgSFcgbGlt
aXRhdGlvbiBvbiBpLk1YOE1NLCB0aGUgZ3B1bWl4LCBncHUyZCBhbmQgZ3B1M2Qgc2hhcmUNCj4g
PiB0aGUgc2FtZSByZXNldCBkb21haW4sIHRoYXQgbWVhbnMgd2hlbiBncHUyZC8zZCBnbyB0aHJv
dWdoIHRoZSBwb3dlcg0KPiA+IG9mZi9vbiBjeWNsZSwgdGhlIGdwdTJkLzNkIHJlc2V0IHdpbGwg
YWxzbyByZXNldCB0aGUgZ3B1bWl4IGRvbWFpbiwNCj4gPiBUaGUgR1BVTUlYIEFEQjQwMCBwb3J0
IGFsc28gYmUgcmVzZXQuIEJ1dCB0aGUgQURCNDAwIG11c3QgYmUgcHV0IGludG8NCj4gPiBwb3dl
ciBkb3duIGJlZm9yZSByZXNldCBpdC4NCj4gPg0KPiA+IGN1cnJlbnRseSwgZ3B1bWl4LCBncHUy
ZC8zZCBwb3dlciBkb21haW4gdXNlIHRoZSBwbSBydW50aW1lX3BtIHRvDQo+ID4gaGFuZGxlIHRo
ZXNlIHBvd2VyIGRvbWFpbiBkZXBlbmRlbmN5LCBidXQgaW4gc29tZSBjb3JuZXIgY2FzZSwgdGhl
DQo+ID4gZ3B1bWl4IHBvd2VyIG9mZiB3aWxsIGJlIHNraXBwZWQsIHRoZW4gdGhlIEFEQjQwMCBw
b3J0IHdpbGwgYmUgaW4NCj4gPiBhY3RpdmUgd2hpbGUgZ3B1MmQvM2QgZG9pbmcgdGhlIHJlc2V0
LiBUaGUgR1BVTUlYIHRoZSBBREI0MDAgcG9ydCB3aWxsDQo+ID4gYmUgcmVzZXQgd3JvbmdseSwg
c28gbGVhZCB0byB1bnByZWRpY3RhYmxlIGJ1cyBiZWhhdmlvci4NCj4gPg0KPiA+IFRvIHNpbXBs
aWZ5IHRoZXNlIGRvbWFpbiBvbi9vZmYgb3JkZXIgJiBkZXBlbmRlbmN5LCByZWZpbmUgdGhlIGNv
ZGUgdG8NCj4gPiBkaXJlY3RseSBoYW5kbGUgR1BVTUlYIGRvbWFpbiBvbi9vZmYgYWxvbmcgd2l0
aCB0aGUgZ3B1MmQvM2QgcG93ZXINCj4gPiBvbi9vZmYgZmxvdy4NCj4gPg0KPiBJIGRvbid0IGxp
a2UgdGhhdCB3ZSBhcmUgYWRkaW5nIHF1aXRlIGEgYml0IG9mIGNvZGUgdG8gdGhpcyBkcml2ZXIg
anVzdCB0byB3b3JrDQo+IGFyb3VuZCBhIGlzc3VlIG9uIGEgc2luZ2xlIGRvbWFpbiBvbiBhIHNp
bmdsZSBTb0MuDQo+IA0KPiBXb3VsZG4ndCBpdCBiZSBtdWNoIGVhc2llciBhbmQgcHJvZHVjZSBt
dWNoIHRoZSBzYW1lIHJlc3VsdHMgaWYgd2UganVzdA0KPiBtb3ZlIHRoZSBBREIgaHNrIGJpdHMg
ZnJvbSB0aGUgZ3B1bWl4IHRvIHRoZSBncHUgZG9tYWluPyBUaGlzIHdvdWxkIG1lYW4NCj4gd2Ug
ZG9uJ3QgdHJpZ2dlciB0aGUgaGFuZHNoYWtlIHdoZW4gdGhlIGdwdW1peCBkb21haW4gaXMgcG93
ZXJlZA0KPiB1cC9kb3duLCBidXQgSSBndWVzcyB0aGF0IHNob3VsZCBiZSBmaW5lLg0KPiANCg0K
SXQgc2hvdWxkIGJlIGZpbmUgdG8gZG8gdGhlIEdQVU1JWCBBREI0MDAgaGFuZHNoYWtlIGFsb25n
IHdpdGggdGhlIGdwdSBkb21haW4gYXMNClRoZSBIVyByZXNldCBpcyBkb25lIGluIGdwdSBkb21h
aW4uIFRoZW4gdGhlIEdQVU1JWCBkb21haW4gb25seSBkbyBpdHMgb3duIG9uL29mZi4NCmxldCBt
ZSB0cnkgdGhpcyB3YXkgdG8gY29uZmlybSBpdC4gSWYgaXQgaXMgZmluZSwgd2lsbCBmb2xsb3cg
aXQsIFRoeC4NCg0KQlINCkphY2t5IEJhaQ0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvcG1kb21haW4vaW14L2dwY3YyLmMgfCAxMDANCj4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNl
cnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BtZG9tYWluL2lteC9ncGN2Mi5jDQo+ID4gYi9kcml2ZXJzL3BtZG9tYWluL2lteC9ncGN2Mi5j
IGluZGV4DQo+ID4NCj4gYjdjZWE4OTE0MGVlODkyM2YzMjQ4NmVhYjk1M2MwZTFhMzZiZjA2ZC4u
M2ExM2FhN2YxODg4ODYzMDQ4MTA2Yw0KPiAyNDMyZWUNCj4gPiBjODBjNzM2NGM0NjIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wbWRvbWFpbi9pbXgvZ3BjdjIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcG1kb21haW4vaW14L2dwY3YyLmMNCj4gPiBAQCAtNTMsOCArNTMsNyBAQA0KPiA+ICAjZGVm
aW5lIElNWDhNTV9WUFVHMV9BNTNfRE9NQUlOCQkJQklUKDEzKQ0KPiA+ICAjZGVmaW5lIElNWDhN
TV9ESVNQTUlYX0E1M19ET01BSU4JCUJJVCgxMikNCj4gPiAgI2RlZmluZSBJTVg4TU1fVlBVTUlY
X0E1M19ET01BSU4JCUJJVCgxMCkNCj4gPiAtI2RlZmluZSBJTVg4TU1fR1BVTUlYX0E1M19ET01B
SU4JCUJJVCg5KQ0KPiA+IC0jZGVmaW5lIElNWDhNTV9HUFVfQTUzX0RPTUFJTgkJCShCSVQoOCkg
fCBCSVQoMTEpKQ0KPiA+ICsjZGVmaW5lIElNWDhNTV9HUFVfQTUzX0RPTUFJTgkJCShCSVQoOCkg
fCBCSVQoOSkgfA0KPiBCSVQoMTEpKQ0KPiA+ICAjZGVmaW5lIElNWDhNTV9ERFIxX0E1M19ET01B
SU4JCQlCSVQoNykNCj4gPiAgI2RlZmluZSBJTVg4TU1fT1RHMl9BNTNfRE9NQUlOCQkJQklUKDUp
DQo+ID4gICNkZWZpbmUgSU1YOE1NX09URzFfQTUzX0RPTUFJTgkJCUJJVCg0KQ0KPiA+IEBAIC0y
OTIsNiArMjkxLDEzIEBAIHN0cnVjdCBpbXhfcGdjX2RvbWFpbiB7DQo+ID4gIAkJdTMyIGhza2Fj
azsNCj4gPiAgCX0gYml0czsNCj4gPg0KPiA+ICsJY29uc3Qgc3RydWN0IHsNCj4gPiArCQl1MzIg
cHh4Ow0KPiA+ICsJCXUzMiBoc2tyZXE7DQo+ID4gKwkJdTMyIGhza2FjazsNCj4gPiArCQl1bnNp
Z25lZCBsb25nIHBnYzsNCj4gPiArCX0gcGFyZW50X2JpdHM7DQo+ID4gKw0KPiA+ICAJY29uc3Qg
aW50IHZvbHRhZ2U7DQo+ID4gIAljb25zdCBib29sIGtlZXBfY2xvY2tzOw0KPiA+ICAJc3RydWN0
IGRldmljZSAqZGV2Ow0KPiA+IEBAIC0zMzUsNiArMzQxLDMwIEBAIHN0YXRpYyBpbnQgaW14X3Bn
Y19wb3dlcl91cChzdHJ1Y3QNCj4gZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KPiA+ICAJCX0N
Cj4gPiAgCX0NCj4gPg0KPiA+ICsJLyogTmVlZCB0byBkbyBzcGVjaWFsIGhhbmRsaW5nIGZvciBw
YXJlbnQgZG9tYWluIGxpa2UgR1BVTUlYIG9uDQo+IGkuTVg4TU0gKi8NCj4gPiArCWlmIChkb21h
aW4tPnBhcmVudF9iaXRzLnB4eCkgew0KPiA+ICsJCQkvKiByZXF1ZXN0IHRoZSBkb21haW4gdG8g
cG93ZXIgdXAgKi8NCj4gPiArCQlyZWdtYXBfdXBkYXRlX2JpdHMoZG9tYWluLT5yZWdtYXAsIGRv
bWFpbi0+cmVncy0+cHVwLA0KPiA+ICsJCQkJICAgZG9tYWluLT5wYXJlbnRfYml0cy5weHgsIGRv
bWFpbi0+cGFyZW50X2JpdHMucHh4KTsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEFzIHBlciAiNS41
LjkuNCBFeGFtcGxlIENvZGUgNCIgaW4gSU1YN0RSTS5wZGYgd2FpdA0KPiA+ICsJCSAqIGZvciBQ
VVBfUkVRL1BETl9SRVEgYml0IHRvIGJlIGNsZWFyZWQNCj4gPiArCQkgKi8NCj4gPiArCQlyZXQg
PSByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQoZG9tYWluLT5yZWdtYXAsDQo+ID4gKwkJCQkJICAg
ICAgIGRvbWFpbi0+cmVncy0+cHVwLCByZWdfdmFsLA0KPiA+ICsJCQkJCSAgICAgICAhKHJlZ192
YWwgJiBkb21haW4tPnBhcmVudF9iaXRzLnB4eCksDQo+ID4gKwkJCQkJICAgICAgIDAsIFVTRUNf
UEVSX01TRUMpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCWRldl9lcnIoZG9tYWluLT5kZXYs
ICJmYWlsZWQgdG8gY29tbWFuZCBwYXJlbnQgUEdDXG4iKTsNCj4gPiArDQo+ID4gKwkJLyogZGlz
YWJsZSBwb3dlciBjb250cm9sICovDQo+ID4gKwkJZm9yX2VhY2hfc2V0X2JpdChwZ2MsICZkb21h
aW4tPnBhcmVudF9iaXRzLnBnYywgMzIpIHsNCj4gPiArCQkJcmVnbWFwX2NsZWFyX2JpdHMoZG9t
YWluLT5yZWdtYXAsIEdQQ19QR0NfQ1RSTChwZ2MpLA0KPiA+ICsJCQkJCSAgR1BDX1BHQ19DVFJM
X1BDUik7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAlyZXNldF9jb250
cm9sX2Fzc2VydChkb21haW4tPnJlc2V0KTsNCj4gPg0KPiA+ICAJLyogRW5hYmxlIHJlc2V0IGNs
b2NrcyBmb3IgYWxsIGRldmljZXMgaW4gdGhlIGRvbWFpbiAqLyBAQCAtMzc2LDYNCj4gPiArNDA2
LDExIEBAIHN0YXRpYyBpbnQgaW14X3BnY19wb3dlcl91cChzdHJ1Y3QgZ2VuZXJpY19wbV9kb21h
aW4NCj4gPiAqZ2VucGQpDQo+ID4NCj4gPiAgCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoZG9tYWlu
LT5yZXNldCk7DQo+ID4NCj4gPiArCS8qIHJlcXVlc3QgcGFyZW50IEFEQjQwMCB0byBwb3dlciB1
cCAqLw0KPiA+ICsJaWYgKGRvbWFpbi0+cGFyZW50X2JpdHMuaHNrcmVxKQ0KPiA+ICsJCXJlZ21h
cF91cGRhdGVfYml0cyhkb21haW4tPnJlZ21hcCwgZG9tYWluLT5yZWdzLT5oc2ssDQo+ID4gKwkJ
CQkgICBkb21haW4tPnBhcmVudF9iaXRzLmhza3JlcSwNCj4gZG9tYWluLT5wYXJlbnRfYml0cy5o
c2tyZXEpOw0KPiA+ICsNCj4gPiAgCS8qIHJlcXVlc3QgdGhlIEFEQjQwMCB0byBwb3dlciB1cCAq
Lw0KPiA+ICAJaWYgKGRvbWFpbi0+Yml0cy5oc2tyZXEpIHsNCj4gPiAgCQlyZWdtYXBfdXBkYXRl
X2JpdHMoZG9tYWluLT5yZWdtYXAsIGRvbWFpbi0+cmVncy0+aHNrLCBAQA0KPiAtNDM4LDYNCj4g
PiArNDczLDIxIEBAIHN0YXRpYyBpbnQgaW14X3BnY19wb3dlcl9kb3duKHN0cnVjdCBnZW5lcmlj
X3BtX2RvbWFpbg0KPiAqZ2VucGQpDQo+ID4gIAkJfQ0KPiA+ICAJfQ0KPiA+DQo+ID4gKwkvKiBy
ZXF1ZXN0IHRoZSBQYXJlbnQgZG9tYWluIEFEQjQwMCB0byBwb3dlciBkb3duICovDQo+ID4gKwlp
ZiAoZG9tYWluLT5wYXJlbnRfYml0cy5oc2tyZXEpIHsNCj4gPiArCQlyZWdtYXBfY2xlYXJfYml0
cyhkb21haW4tPnJlZ21hcCwgZG9tYWluLT5yZWdzLT5oc2ssDQo+ID4gKwkJCQkgIGRvbWFpbi0+
cGFyZW50X2JpdHMuaHNrcmVxKTsNCj4gPiArDQo+ID4gKwkJcmV0ID0gcmVnbWFwX3JlYWRfcG9s
bF90aW1lb3V0KGRvbWFpbi0+cmVnbWFwLA0KPiBkb21haW4tPnJlZ3MtPmhzaywNCj4gPiArCQkJ
CQkgICAgICAgcmVnX3ZhbCwNCj4gPiArCQkJCQkgICAgICAgIShyZWdfdmFsICYgZG9tYWluLT5w
YXJlbnRfYml0cy5oc2thY2spLA0KPiA+ICsJCQkJCSAgICAgICAwLCBVU0VDX1BFUl9NU0VDKTsN
Cj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWRldl9lcnIoZG9tYWluLT5kZXYsICJmYWlsZWQg
dG8gcG93ZXIgZG93biBwYXJlbnQNCj4gQURCNDAwXG4iKTsNCj4gPiArCQkJZ290byBvdXRfY2xr
X2Rpc2FibGU7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCS8qIHJlcXVlc3QgdGhl
IEFEQjQwMCB0byBwb3dlciBkb3duICovDQo+ID4gIAlpZiAoZG9tYWluLT5iaXRzLmhza3JlcSkg
ew0KPiA+ICAJCXJlZ21hcF9jbGVhcl9iaXRzKGRvbWFpbi0+cmVnbWFwLCBkb21haW4tPnJlZ3Mt
PmhzaywgQEANCj4gLTQ3Nyw2DQo+ID4gKzUyNywzMCBAQCBzdGF0aWMgaW50IGlteF9wZ2NfcG93
ZXJfZG93bihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4NCj4gKmdlbnBkKQ0KPiA+ICAJCX0NCj4g
PiAgCX0NCj4gPg0KPiA+ICsJaWYgKGRvbWFpbi0+cGFyZW50X2JpdHMucHh4KSB7DQo+ID4gKwkJ
LyogZW5hYmxlIHBvd2VyIGNvbnRyb2wgKi8NCj4gPiArCQlmb3JfZWFjaF9zZXRfYml0KHBnYywg
JmRvbWFpbi0+cGFyZW50X2JpdHMucGdjLCAzMikgew0KPiA+ICsJCQlyZWdtYXBfdXBkYXRlX2Jp
dHMoZG9tYWluLT5yZWdtYXAsIEdQQ19QR0NfQ1RSTChwZ2MpLA0KPiA+ICsJCQkJCSAgIEdQQ19Q
R0NfQ1RSTF9QQ1IsIEdQQ19QR0NfQ1RSTF9QQ1IpOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJ
LyogcmVxdWVzdCB0aGUgZG9tYWluIHRvIHBvd2VyIGRvd24gKi8NCj4gPiArCQlyZWdtYXBfdXBk
YXRlX2JpdHMoZG9tYWluLT5yZWdtYXAsIGRvbWFpbi0+cmVncy0+cGRuLA0KPiA+ICsJCQkJICAg
ZG9tYWluLT5wYXJlbnRfYml0cy5weHgsIGRvbWFpbi0+cGFyZW50X2JpdHMucHh4KTsNCj4gPiAr
CQkvKg0KPiA+ICsJCSAqIEFzIHBlciAiNS41LjkuNCBFeGFtcGxlIENvZGUgNCIgaW4gSU1YN0RS
TS5wZGYgd2FpdA0KPiA+ICsJCSAqIGZvciBQVVBfUkVRL1BETl9SRVEgYml0IHRvIGJlIGNsZWFy
ZWQNCj4gPiArCQkgKi8NCj4gPiArCQlyZXQgPSByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQoZG9t
YWluLT5yZWdtYXAsDQo+ID4gKwkJCQkJICAgICAgIGRvbWFpbi0+cmVncy0+cGRuLCByZWdfdmFs
LA0KPiA+ICsJCQkJCSAgICAgICAhKHJlZ192YWwgJiBkb21haW4tPnBhcmVudF9iaXRzLnB4eCks
DQo+ID4gKwkJCQkJICAgICAgIDAsIFVTRUNfUEVSX01TRUMpOw0KPiA+ICsJCWlmIChyZXQpIHsN
Cj4gPiArCQkJZGV2X2Vycihkb21haW4tPmRldiwgImZhaWxlZCB0byBjb21tYW5kIFBhcmVudCBQ
R0NcbiIpOw0KPiA+ICsJCQlnb3RvIG91dF9jbGtfZGlzYWJsZTsNCj4gPiArCQl9DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICAJLyogRGlzYWJsZSByZXNldCBjbG9ja3MgZm9yIGFsbCBkZXZpY2VzIGlu
IHRoZSBkb21haW4gKi8NCj4gPiAgCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKGRvbWFpbi0+
bnVtX2Nsa3MsIGRvbWFpbi0+Y2xrcyk7DQo+ID4NCj4gPiBAQCAtNzg3LDIwICs4NjEsNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGlteF9wZ2NfZG9tYWluDQo+IGlteDhtbV9wZ2NfZG9tYWluc1td
ID0gew0KPiA+ICAJCS5wZ2MgICA9IEJJVChJTVg4TU1fUEdDX09URzIpLA0KPiA+ICAJfSwNCj4g
Pg0KPiA+IC0JW0lNWDhNTV9QT1dFUl9ET01BSU5fR1BVTUlYXSA9IHsNCj4gPiAtCQkuZ2VucGQg
PSB7DQo+ID4gLQkJCS5uYW1lID0gImdwdW1peCIsDQo+ID4gLQkJfSwNCj4gPiAtCQkuYml0cyAg
PSB7DQo+ID4gLQkJCS5weHggPSBJTVg4TU1fR1BVTUlYX1NXX1B4eF9SRVEsDQo+ID4gLQkJCS5t
YXAgPSBJTVg4TU1fR1BVTUlYX0E1M19ET01BSU4sDQo+ID4gLQkJCS5oc2tyZXEgPSBJTVg4TU1f
R1BVTUlYX0hTS19QV1JETlJFUU4sDQo+ID4gLQkJCS5oc2thY2sgPSBJTVg4TU1fR1BVTUlYX0hT
S19QV1JETkFDS04sDQo+ID4gLQkJfSwNCj4gPiAtCQkucGdjICAgPSBCSVQoSU1YOE1NX1BHQ19H
UFVNSVgpLA0KPiA+IC0JCS5rZWVwX2Nsb2NrcyA9IHRydWUsDQo+ID4gLQl9LA0KPiA+IC0NCj4g
PiAgCVtJTVg4TU1fUE9XRVJfRE9NQUlOX0dQVV0gPSB7DQo+ID4gIAkJLmdlbnBkID0gew0KPiA+
ICAJCQkubmFtZSA9ICJncHUiLA0KPiA+IEBAIC04MTEsNiArODcxLDE0IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaW14X3BnY19kb21haW4NCj4gaW14OG1tX3BnY19kb21haW5zW10gPSB7DQo+ID4g
IAkJCS5oc2tyZXEgPSBJTVg4TU1fR1BVX0hTS19QV1JETlJFUU4sDQo+ID4gIAkJCS5oc2thY2sg
PSBJTVg4TU1fR1BVX0hTS19QV1JETkFDS04sDQo+ID4gIAkJfSwNCj4gPiArDQo+ID4gKwkJLnBh
cmVudF9iaXRzID0gew0KPiA+ICsJCQkucHh4ID0gSU1YOE1NX0dQVU1JWF9TV19QeHhfUkVRLA0K
PiA+ICsJCQkuaHNrcmVxID0gSU1YOE1NX0dQVU1JWF9IU0tfUFdSRE5SRVFOLA0KPiA+ICsJCQku
aHNrYWNrID0gSU1YOE1NX0dQVU1JWF9IU0tfUFdSRE5BQ0tOLA0KPiA+ICsJCQkucGdjID0gQklU
KElNWDhNTV9QR0NfR1BVTUlYKSwNCj4gPiArCQl9LA0KPiA+ICsNCj4gPiAgCQkucGdjICAgPSBC
SVQoSU1YOE1NX1BHQ19HUFUyRCkgfA0KPiBCSVQoSU1YOE1NX1BHQ19HUFUzRCksDQo+ID4gIAl9
LA0KPiA+DQo+ID4NCg0K

