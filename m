Return-Path: <linux-pm+bounces-38425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DEC7EC51
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 02:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC973A497A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA14239E9A;
	Mon, 24 Nov 2025 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WybGtEPD"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70A635;
	Mon, 24 Nov 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763948916; cv=fail; b=fKaxoR5EJAt0mFxs1vUm+a6nJk9I1AwkrnkK95hmKH8c/WxZvIk02w0XoKIKS9G8aWEI7hHbH3GAi+GEoJ4LhJXIBiz9Z9A0ib1R/vEpNuY1AloBmoGIWQ+HZsJD0vX8z+VDd9C6CkHLK9d/RXvBXdQKk+Px7nA25NhWWya/yIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763948916; c=relaxed/simple;
	bh=SczH994C3wYo4iC/a3z1c2nGeMrYh2s6LM3AHYLeejc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oi6FL16llCQdWeoHHFpUcmoM8YzTcnYf1YPy0dhYCoPr93mElTx0SYlj2WO7I6GsoAFQ1+8B2FT2CbT7Mf9O5EWWmu8rEIuC3iGl1jQzOsvncymeNqX5zWLLdPznpTAwr28+GcOl+i/RAUaBVpKMfQMhppBRzVimgDFFcM8hJLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WybGtEPD; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY2aF8QOZ7N+HPvs12lqoVkV4xNm9PoGQQUq1ExriwbPURz8erl/v/T0kjzurvIJqP3ezpoINEFJJK0mzdmXzGUYHAipv7k8qdZY8U2aX15iPkgSw82galX2F6HX/q5wj0SA1q83lmQ5iRPHpkLIYwtNrOvsb3HfGdREHq7jyCpTfuWVCMyqPGdstv7uxg+n9EW5kkEBh16LFoGrJBIW6EiL6Se+yd1ls/P2UXz9GWbBowJudlzAmQDGMYe3NTFMZ+brPbiLm784WIaHgQCw8B7k/HmlKAZy8IjCk3OrxueMhh/I5mzOFoC8WASpoOuPxlN1+aCdP9120JUd34j2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA4K0cqDJQQGWWCGbclhMIgSx8itMsm5b7SH5h1nbfA=;
 b=gcI6iSeXXOCGyVs4sRq8SXva5ddo/f4TTuv2QmvrLjh5uhrycrKnMs3m2fWECR0ZwVsdN+VFnM9V5OBz1VYZolRYvYmSfwV5MSCcrrPcVIEMua5zxIOpUQ48hqQF6VBwarp9odxpDaNAtYIpeG7cJvm03dUjnyuXrweN2w0SsG+8YuZiPOwCL2wYaOjKAAHKIdMrjHYw2wC8bjepl5nkrPETIljvY7bLnMn6KNnyESZwMUUhU+ijtQzk9NeB6ay9glXOx9IIMQNoOF2Kg5j6BfVwVG1cmoAieIajfzpCVXrF7Yb/zlf6bqzymjmB0k+WiEvqijO6wlGIz1cCXfk3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA4K0cqDJQQGWWCGbclhMIgSx8itMsm5b7SH5h1nbfA=;
 b=WybGtEPD1bjEUJo7ocrd584pEps+luzUpffjp3uJ30cKmWLtS3gmnetFGyAL+l7qdh/eMsUZyX7NiV56MkG6mJVDFTZMKXtRjhkAhGCtf+h6T85Hp4h3Cl3beX7lQ4hL1Nz/BJdqGbCGeM0ShahEvRy3+mnIOE1UVHrFXqky4hbqDlRVLG/FFcmRdw2MjiIm1JPo/qQxiEJbpyitZNcHffDRXB5MuOjz03A+Paci0kW7EvPF3s/z7Rcpz7J3PFo3FC0fRMRWtMDKZXRdiiNlfbHsrXEZETaavVxgXbJcDQJMEi8w3VWMdsPepZR6w8TJo+IDfIg97rvwf1kkbR7ZNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DU4PR04MB11813.eurprd04.prod.outlook.com (2603:10a6:10:624::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 01:48:31 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 01:48:31 +0000
Message-ID: <72c06ed1-0db0-4c9b-b286-86858de23bbe@oss.nxp.com>
Date: Mon, 24 Nov 2025 09:48:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk
 mask for 8mq vpu
To: Frank Li <Frank.li@nxp.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, peng.fan@nxp.com,
 eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <aSCPGdnTVmd48f+i@lizhi-Precision-Tower-5810>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <aSCPGdnTVmd48f+i@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DU4PR04MB11813:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d211a92-5597-4125-82fd-08de2afb91d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBkYm15MGJnUGdKZDBkN2ZXaVRGNU9mRTkvbXpuckxJaEZTZkcvbVM0b0Fu?=
 =?utf-8?B?cGl6NFNVa0NpRG1lY0w3bWFnM3RiNzM1ZlJ2N0lnN1cvSkpRN0Z3a1M2L2NE?=
 =?utf-8?B?b1NHVUVGSktKOTZ5UVRJelZnQ0lvSzZzcU1kVjZjUW9NWEhKcG95VGNJa21D?=
 =?utf-8?B?RDFNSWtpUGVZZzNBOCs2OE5Qc3JUNHJpVUFNVEtRajk2VllFenNLQlEyZWVW?=
 =?utf-8?B?eFNRRHc1Sk1GOGg4WmRNQkRrTXRWQ2szck54VnFaL2dXTVdPTTRGbFdkcmJL?=
 =?utf-8?B?RWI3Rkk0dHdTZHh3eDQvL0hwZlhoNlRnOFB0Ly9aNmpjNXZlMDVOcUR6S2Fa?=
 =?utf-8?B?R3ZVdm9lY05zRUJRM0ZJdmd6ZUhZVDBsdEVmREJJRkV3cVBSOEV2TGpvVFRT?=
 =?utf-8?B?cXp4bXNvMUVHdUlJVkU4NnRoUjVpOHZNalU4YlZrclZVc3ZGQ1BzRGI4Q1h1?=
 =?utf-8?B?N0Y2bEJjMEVtYURWeWFLVUpOU2NGcE1Rbk9PWFJQSld4aVpUUEV6UmZLdjRa?=
 =?utf-8?B?UVZBY3F0b1BpUHZER2FIUWhxcmRza05kTEM4MzFGTVI4NUtFSVAvYkdFaFRH?=
 =?utf-8?B?SnBjS2Y4VDdrRmhUV2N5cGdBRUkzbjNoL1RjeTZxckdJMmtNSzJKM2EzRU9x?=
 =?utf-8?B?WUdtd29FamdpTnIrTDQ0MDJkUm4yMXVaS0VRNi92MUtxZEdaTTZpWHVKY0ZG?=
 =?utf-8?B?TWNMM29NYnpsVWhRdVFhSTRGNFhzaHpuYjIzb21SMjhuS0xQM2FTaG13Q09t?=
 =?utf-8?B?NFdUS2RPTjQ5SnVxSnUwZGx4UXcxOWs3T1BBZ1hQWGNUbHFGRXI0QjRTVURU?=
 =?utf-8?B?T1lJL25PZTNCRnNkZzRRclVMeUdKcmpyZnFWTXNkK0FQeWJxeVdZaFRJNjI5?=
 =?utf-8?B?cmlSWHVjTHRCdkNUV0tkdlhsNWcvUkYrTmMvN3d2d1doLzN5ZFUvR3EyR1ZO?=
 =?utf-8?B?b05Tc1kxZWYwUERQbU8zc2R1empyYjRWbHFTRkhsU1NheHZ0QjZuRldxNUlG?=
 =?utf-8?B?UWJwdGZUWHBjRGlhUWhqMVpVcU4yV0w3Ym5za3hCdTRleldoTHdFVy9iYmZE?=
 =?utf-8?B?NkVTeE1VZi9tRjd4aFpNNXpsRGJJNkFiM1BoZ1ArS2lRNldUSkJFeGhLM2tI?=
 =?utf-8?B?MFNvelRRVERGSTV4cVhvOGYyall4U1d5N1k5UXJLa2dEK0JBTG9qNFprM3NO?=
 =?utf-8?B?a0hUa2tGUG5WWDdibzM4RUhLTGNKYkIvUzVoTWVsa0p1K0FWNjhzeWtuZ21o?=
 =?utf-8?B?dWVDMTlXanFSQmVreHFRQXJudUo4a2t1WTA2OUdWenlkLzFreVN6SUh6UEYv?=
 =?utf-8?B?TlF1L1B4NkRCWUhVVHo5UjlPZFl4eGp3TUhWVTA2M1E1VWh0Y1J3eTZBN2JN?=
 =?utf-8?B?UzM5S0FoM0lpbEpjdys1c3BKY2dIMXBPL0xrN1R3VHErR0QzYmppOFJiMjZ5?=
 =?utf-8?B?RkxFRERmWFNXQXlQNEM4YmhXNnByYzVSSVlmWE9vTXpnOHgwTUUzNjZXZFBj?=
 =?utf-8?B?WmgwT21NOEtPdmJoa25wV2hmNE1qMzkrcXlNeXJyVnZYSG54WVNYa1RRVytJ?=
 =?utf-8?B?TmhnVjVTKy9vWW1aeE9yRmFGOGh5WEY3SjI3ejNTMUV4L2RkVmMrU1NENThQ?=
 =?utf-8?B?T1Z5elVlQ0dBenUzTmh2bFk5VHlkZHFGUElrczg0SklIWm85TzJBRWJiaWNt?=
 =?utf-8?B?MTBVRWw3am5oUkVYWTlLRE5tODVVOVd0bXJKSldlQ1ZrbFcrSWkwSys1UGkv?=
 =?utf-8?B?ZlRZd1BvUVQ0WUlqbnhmbE03L3J2UTQrcXF3S2NzNTNrRlg5MXRDenl2NkM2?=
 =?utf-8?B?aHVNbGNuM1JJM3J5VndaQ01tNVFkREZVcytBWXdjNFMyaldXR2hBeDJzL25s?=
 =?utf-8?B?Q293eUgrV0Mxd0JtUFBUZjNabHJNWHZOZ0xxWFQrSlUwRFNGOTVXZ1h1OWNu?=
 =?utf-8?Q?RKBITaaJMXlnZrR5EBtjqf2ONP1ohkdM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akluVytwc1dPbkdES21sekpYckVENFFZMnBZTnZDSlNXNUV1NVkrR3h4VStT?=
 =?utf-8?B?ZHRMTnZrK1dYQlNXUHphM2cxRlpmU29semsyNmd6QXlaWEtDVm8vQkt6Qzhz?=
 =?utf-8?B?ekhLYkhVR0V2SjZGTStQL3A2NW04Z0QwQ01UZlB0WW5mS2dzcUVNajZNcS9C?=
 =?utf-8?B?bEpwZ2VsVkJEb0tQaWJXT25Yd1AySDNYbVdUT1c1ZmtrSE13bUd3RXBFeGlt?=
 =?utf-8?B?ZXp1WnAwRWtWM1B2L0lOSmRmSmtzNWsvQVhTTnhHRlFNVTZSbjRDWGdwM2lu?=
 =?utf-8?B?T1RwWUNGME1vVFY3cU14NU1KWmRmOXh4QjVXNFdncGVidnhmVDhGMU5PbTVM?=
 =?utf-8?B?M3F6MHRidUVPcVZWRUFOWXJGZW0wT0NnTkN5eFdxSklyNjVzUy83bjgxZUNI?=
 =?utf-8?B?cGJjWHgzOHordEtkZ2dSTUhGYzdZWTM4TEtRaHh0UTJFa2NSdUw1cnAwaUhZ?=
 =?utf-8?B?SkZMWEJHS1BoZXpFbWkyM1NBVUdKVXhoYTBhS3lrT0hhM0p2NmtkbHRYSW91?=
 =?utf-8?B?dExxcnZrYkdVZis2Z0pwL2pXeExGVGl6R0ZJaTlXcHBCZjZEK0lSckw4MlVF?=
 =?utf-8?B?OHFmeHVuLzZhdmFjbm5ET2NkdFkwUzg1UFR1eTd3MTEvRmJ6cVdsWWh5OG5I?=
 =?utf-8?B?bTVFTEdwc05hcUN4THJsUlJDckQyS0xWclFSYmtweW90ZVlNVU9QRFBQMyt4?=
 =?utf-8?B?dG1nMHJyNHp4ODkydGplclBDbHRjNXhBUjVDeXVha2FvUUl6ZlZMcmhjanBz?=
 =?utf-8?B?aFMrTnhBU2xVamx1Tnl5Ukc3eVFmTFVzYjl6Q21yU2pjZmlIdWgvRTMyeWZP?=
 =?utf-8?B?c0MrNkZxbmVqL1FzZGVRMjFWLytURC9YM0owRVBpR0dSUGYwVUhWMGdJQWtv?=
 =?utf-8?B?V2t0SHhzdUVDejdZanJ4SWlHZmJIc3NxRW5aUy9TQVhUOGREc01UTVYwSUox?=
 =?utf-8?B?SVliTG1KTHBsdHY2VjhuTnhmVm5ocEVyMXE2VEZHYmo0TWJUQnlGYXNrOUY4?=
 =?utf-8?B?bFBJKzRickMxMXBwZG9GclA5STR1anBNM094TW9VRkxXUW5iZEczcyttWWR6?=
 =?utf-8?B?cWVSTk0rMjRCcFdSWjF2bHhzYkxpMWF5TmNRM1daWGFnUjl3SXo3OU92Sm9O?=
 =?utf-8?B?QTJhL2t4eDZoeUZkMjFESFJ1VVBlK1JKSy9jN1NIMEJWZWhGNzJOSi9aekRK?=
 =?utf-8?B?K2dhdUFXdnBzRDFvbWthL09Rb2pSYm5RczhCRG4vbjVyaXA5QUhXeVdQWjhN?=
 =?utf-8?B?QlFCdnc3WlE3M0lmSkthR2h6TkdOblc5Mm1jajIyRGp1RnVIVWZPVGlIUmxr?=
 =?utf-8?B?Zm5kZ3U0ejJqeUIzaU5nNmpMbVlnV0NaK2hkdGlORy81VzNtdXZSTkxrbjJY?=
 =?utf-8?B?SnAzcVNCaEF2ejdEQ1FLOFlXTEE5L0JrY0hZR0xjbUs2THBzanptYVpidlFX?=
 =?utf-8?B?MEdlTkNPOTBBd0dQRHI2alRTTXpLQzVqUnVPQ3V0OHluK2ZnR01LVStFSEt6?=
 =?utf-8?B?cGZJRXFKNVN6YmxqeDd1cUpkT1hDbXV3a3VJazFEQUxMbklXNmNxc1o3NVM4?=
 =?utf-8?B?QUQ1cmh2NHA1NERaWTFZdG4vOFpCcnhkQTljY0p2ZTdCTzgySWVSVU5mRTBq?=
 =?utf-8?B?c1RuUXZRdzNqYWxKTWJKTTRXNWtPajdqT1JLYlFiN1dONHIyWm4rUzlKcUpJ?=
 =?utf-8?B?SVBuY2lMZDJ3THRTMHlUL3lxaTFwRkp5TlVNaG4yODlwOHcvRC85RmFobDVM?=
 =?utf-8?B?MzZnUlRpbnd0SWdoV21VMVZNNTZPTmF1emFONjRxc3JLZktOdU5GZnZQYkdz?=
 =?utf-8?B?RWRPVjRST2VxMlM1TmJISnlJbDVtaHFyOERsSzNVMTNtbVc4ZGMycTRLSW5L?=
 =?utf-8?B?OW0yVHFsTmY5eXUycTd3SEtkRkttSk1sRE5zTGwvU3FOemxZMUtEQ3lYK2NY?=
 =?utf-8?B?RmRvRVVIR2pFdlRCMVhmckY3RUJsOXN5a2Z3Tm12bitGdnFGT3dQOFpFT1lT?=
 =?utf-8?B?bTdEZnlHbG5VekgvOCszSkZraXNYSG51a254MkVjNnBBTi9ENWpiQ1ozalM2?=
 =?utf-8?B?UnZ2bkpEM21reDF1UHQ3eG1sZDE5aTVTaS94U3VsSUNKcjhyUUdqcHRERjZi?=
 =?utf-8?Q?it/xLSQDgtNn3Twe8CpEIyGzD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d211a92-5597-4125-82fd-08de2afb91d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 01:48:30.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHKhjVYNxKslhSFxe8KZ9EQg2AacMX1DgC7exTmRs6RXHDXJ1m5GQ1fSyP/5qKzSSE7grcc81SIbB/hTlC8pFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11813

Hi Frank,

On 11/22/2025 12:11 AM, Frank Li wrote:
> On Fri, Nov 21, 2025 at 04:19:08PM +0800, ming.qian@oss.nxp.com wrote:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> The ADB in the VPUMIX domain has no separate reset and clock
>> enable bits, but is ungated and reset together with the VPUs.
>> So we can't reset G1 or G2 separately, it may led to the system hang.
>> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
>> Let imx8mq_vpu_power_notifier() do really vpu reset.
>>
>> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>>   drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> index 5c83e5599f1e..1f07ff041295 100644
>> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> @@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
>>   		.clk_names = (const char *[]){ "g1", },
>>   		.num_clks = 1,
>>   		.gpc_name = "g1",
>> -		.rst_mask = BIT(1),
>> -		.clk_mask = BIT(1),
> 
> Does this bit not exist or just put VPU's reset bit here previously?
> 
> Frank

In NXP's internal VPU solution of i.MX8MQ, this vpu-blk-ctrl is not used 
directly.
The internal driver always reset the G1 and G2 VPU together.
Just like imx8mq_vpu_power_notifier() does.

Regards,
Ming

>>   	},
>>   	[IMX8MQ_VPUBLK_PD_G2] = {
>>   		.name = "vpublk-g2",
>>   		.clk_names = (const char *[]){ "g2", },
>>   		.num_clks = 1,
>>   		.gpc_name = "g2",
>> -		.rst_mask = BIT(0),
>> -		.clk_mask = BIT(0),
>>   	},
>>   };
>>
>> --
>> 2.34.1
>>

