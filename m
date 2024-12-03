Return-Path: <linux-pm+bounces-18436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4769E18EF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA522807F3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC941E0E17;
	Tue,  3 Dec 2024 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="U/KazvYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2114.outbound.protection.outlook.com [40.107.241.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDC1E0DE9;
	Tue,  3 Dec 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220725; cv=fail; b=B9AQsPbIZY8nytL6QB68DnJHULu6Sfw5FxFytCd1OnINd5dnRP99Cn/So/xjTGuRwPecjoPP967UG4THzbvXxr+ntkB091n8p41dK+wEbNIbhhQtLsAVCDzXtSnW6bDPyui7AD1zR/5zZkGZs2KX6wIHP0caJIesEqIqxQnIW4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220725; c=relaxed/simple;
	bh=ab7FWO+9TVuPGmJTsFPOtUYiDYAS+X/h1GInV2A6Ilo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PntqrZsm6hGvgqJZFwY7/7FOmJJUgeFH+1nKz/EjBL8Eu3aoCif5dg0V7LKJATWqrWSppKO6eBTCJu+ex4CNFSQ+MGoL8DwOnrAZubYuVAPzHBxL2naYsYc0cxcVZ9xAa0GrDdyt4Cp3wyti1WYRRKGt/R4v5mhtXHkk7To2m94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=U/KazvYA; arc=fail smtp.client-ip=40.107.241.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJwXCd7WJKteERkfpuaa1wVi2DmD2xC7fgztIa/+4Gf5O/AaWSMVWtyrDaMhrJVpq5Lv0vKa2qsN6JYQEs58iCrEUJWyY+rgeCf8wmMhD8T2OuJEZGxoztpY5980RK7dBslidJAUZ5x0zlkwbNhI+sGKe9uCUEQksjurwH0Qidz9ncZ0cvbgDvv8ELruNI4Vf8nrJpz0d8cBr3HuVb6bIbMjsKF/LRYD/04etVEHIAs/xS0QsIYBVY4OOv8hmHZdkj9rHaaWlCjKo2ozPpJzR+pbDeKEqWrct2+yAmLTZDCNMSzJaaFLNb0WGP1t+jG2WjqwLkC27UdHzReC03nrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jItZPVFxCk2giPMXionZZIUvsaqSVulFYvSoEHHQ0nw=;
 b=P+F5g0Ef3w+QqLI4gtfIPEskiVxZ6jzc68BhhfDzfQbASp1zJ9mU8c5j7WFXseOfIWYBNlglhcz8xj3lbNdd/2PgZK7s2br5/mJMGtwrhHujHLCriPHiV8w6eqMD+JNL6AgxOnuZOnOfisos0ojX3GwuRGEJYzPCDnE0g55A4NkSJ/XKC6WdQPdH4ojg7GW6az6r8Yu23J2GQ+jd7Vy7XQx4bLpM5qBXFCRJvHAkv9dhVLhvFg0Jzng0zvHz3oHaPiaFRC2D4YSkFdzSWsxqzYx/Ri+IF6jZXZ6iqsHsSfnPvGBqXV6aQSHG8dykHk4jRqZJHs3oHPQ3N8dvNVM/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jItZPVFxCk2giPMXionZZIUvsaqSVulFYvSoEHHQ0nw=;
 b=U/KazvYAHo7r7vo01QJ/yB6pEkRO7hZob8KIfFhh993ndEERd1wGewP0ue0BKB4snw/WGYWRyBDzxg91ClKjS/bBC2p41arbqhQ4fs/kw7LLjgLvvMw2OKMtoEqbJe2FXHakz3jASXSEXIwbjF6GFIB8T/R4G8TzJr3Ta2IjFTOjyGq60VoZ2al7zGRlgfou/LJ3Ay0uJaR59FSMVdXtjO+RDWFAINfDpymSDlulbW28OgISrNcnS5Xcp4NCkP3UxU697L7BwkBVyrh7eqKnHl5zWM/upOIHx2CEOap1Jc1usJetmxZNeSE/ZyAaNY/N2Z5RuhfarimeQzDceHC9Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AS2PR03MB9561.eurprd03.prod.outlook.com (2603:10a6:20b:59a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 10:11:58 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 10:11:58 +0000
Message-ID: <bce22ca8-aed2-41ae-b2ef-fdc71266709a@uclouvain.be>
Date: Tue, 3 Dec 2024 11:11:15 +0100
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
 <9387c0cf-d291-485a-8cd1-1aced7eba14e@uclouvain.be>
 <2883fb0dd22312d5da9039d4fef869276a0bd430.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <2883fb0dd22312d5da9039d4fef869276a0bd430.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AS2PR03MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e2c8a0-64b2-4a60-4fd3-08dd1382ec1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3pUZzJTSmJxN2lUSENCSUlTQlJRYXFhdVRUc1RkZHkyWjVvNW5FRG1wRHF4?=
 =?utf-8?B?SDFLQmhqWnFGUkMrZ1kvbGt4LzUvUm1maXpZVEhZQzBGSWc4aVp6UXRHMnB3?=
 =?utf-8?B?SHJNRmFlUzd2dnBGYlRlMXdqZkJvdXBOTW5UcXdhUndka0VvMGZRMnVUaDg0?=
 =?utf-8?B?M3l0VXBSanhGK3hMRDNMNXFWYzdGdHFaY0xwUWthZTBlTVVpYXVFVTVydkR1?=
 =?utf-8?B?VnpvM0dUbXlSSy9Da3ZMWDJ2Z0oySFVIU1BXdzNVNnJzcWNTKzNCdUUybTgr?=
 =?utf-8?B?dXZ0d2tjeEVtcmZEcVRLZTNTbUFYYlR0V21SSFh4ejVnMEtuYjJEYXRCVjlp?=
 =?utf-8?B?YncvaHJrNjdHKy9sVVJPNFRHbFJUZjM4Wk8wbGFxSE94ZnQzZ2ZuMDJ5eEtn?=
 =?utf-8?B?MndjSjlzUFRYaEpJd3NGNVVXRUNJMlZsUmZ3SC9GRXNBUlN6T2had1VKN1Z6?=
 =?utf-8?B?djhRK3F4TlkvOUVUTmx4YmdUWXBHcTlNVTAyZnRUUklFYVZTU2tSN2ZIZ1kr?=
 =?utf-8?B?UXBtMWJuZWRkRXFUTDRReEF5WFV2THlqZERWTFUwdzRoRENGMk1QQjVIM1Zx?=
 =?utf-8?B?WlZaYU92c3lRSU5kNzVieGJBWGwyZTZhRVBLVW96a3NZanFScUh4UGFLeGov?=
 =?utf-8?B?aE9FWmFWQ1pzcm1GTC9sb2RDWnJldWRiMFNlelhHYkFIdkZ1YjJWc1B1OVJD?=
 =?utf-8?B?S2JxcTUvYkFUelJtNTZWcFFtM0plWHBoUVF4cUdPWTIyNVdnYjErNzRoVnEw?=
 =?utf-8?B?ekJTMHlRR2tVYlNUSzlkbisvOHMwbVMvWTJCT2NYcFJBTklQeGJJQVBPT0Y5?=
 =?utf-8?B?dnJqeWk2YkNWZ3l3QStrOUpoSkdEczY0K0VkS3pHNXVvVFhDNVRJUVpHNm5Z?=
 =?utf-8?B?ZHRuMmIzYnlHUDVxQXdmNmJGTmgwaGw5YjlIR2I1OWpIRDErQ0UzcUZkTHhy?=
 =?utf-8?B?T3dZYjVLRGV0RW52TDlJUGJoUElSSE9CZCtJM2pDYnVtZWpPK1A5R0xpS2sx?=
 =?utf-8?B?OGNCYitZMnNEb1FjYlVyTm5zUHo0L3RMRHRBL0I3VkR4b3BhTXM3WWI3cWZ4?=
 =?utf-8?B?NUJyamU0OGxqZzg5dTFPYW9uZEpsQ3phUTlPcG1GVDJVaGlHYmFNNWNxR3No?=
 =?utf-8?B?czVWMXQvTzAwYmxoNUx4clhpZ2xmeUpHT0pTNVZKbEtnUEpEekhmZ3gzZ2U3?=
 =?utf-8?B?OUVCenlLSE84K3hGT3ZOWDNuaFlVeEVGbVNvUkNPbnBFMFVIcGV2VGJSME5X?=
 =?utf-8?B?ZEVaOHh3YUJIVEJCb0JCSkdVY1FKZUZENzlUN05EUHZqV1p5YnJVMkgrdi9F?=
 =?utf-8?B?M0RxRG9pdncwWFhhckRYbzBKSHhrU2dkejlkazZEeTZUdi9VUjR3SG83Kzl5?=
 =?utf-8?B?RFZJWDdXRy9UWnNjelN0MnY1M0hscjVybGtDUnJwNE9XejN0VGkyQTNnQTNn?=
 =?utf-8?B?Wm5MemRuUXRmLzV5M2FMNkoxdnVZeW05SHNZM05TTTNhZDlUSHJCeDRhblpQ?=
 =?utf-8?B?TjVMRGxKbGJxSXpiZkVldEs3K1NtU1FtZ3BoMzk3TlJ4ZUxQWHNPMU9rbTRY?=
 =?utf-8?B?dXZaZk0rb1BvZkt4em9ZaFQ4bGhKTTVWdUFhb04vSElkdDVUdEVkTVEwanpq?=
 =?utf-8?B?MmhPanRsZ1ZKVktVcXhHVHZndWZ4K0kvb2k3U2tha1NMK3gxSno1RnFoLzJG?=
 =?utf-8?B?WjNuM0FPVTdvaWZLL0lOR3pOUVVyS093VFBWci9XVkNCVlR3OG5LUy9yZlpM?=
 =?utf-8?B?TENEMHdmQldMZDA5eGdRbWM4azJ5OXJLb2w0Y3llNWZaMnZPLzRRenoyNTBP?=
 =?utf-8?B?ZCtzQy81RTR0aFZRUFZldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3p1RjBaQkVqOFZtTFZ2dXkxU0l2TTl6NWRPUW15UkRtUk5JZ3VTZTZrUUdq?=
 =?utf-8?B?UWlnamlid200TFpwblJ5M25tQmUxZE9yMmZsZjkyOG12Tkt2Mm80My9JZ3Y5?=
 =?utf-8?B?WUVRQjZ6OXpienJJTjFKYXNrbWYzWTVnNXVHVXM3NFdVVksxckkydXFScFZx?=
 =?utf-8?B?NDVSTHc1YmNWR3NvVDhDNFJXYklURmNyRkgwbjU2dE1zcXd6MHJCaThkVEJ6?=
 =?utf-8?B?Vm9US1p3QzRnbGtldmN4eVY2SkIzUW1sWFgwZGdQQklrWmlIVmZXaUVGMkRX?=
 =?utf-8?B?dnl2d25PRWpvbDlRZW9yYkNxb0J4R2lJTlBTbWlJd1BDUndQd1AvS0MxYXlm?=
 =?utf-8?B?b1JoWkV6dVprQXFxT3dYN1djUFJYazJsME1pS0VnTlNMNUYxdGprV2prbFdF?=
 =?utf-8?B?SDI1UmdUWEFjL1RIaGRPV0g2OGhJbktkcXhTQUNPK01KVXBGTHJwMFJjN0J2?=
 =?utf-8?B?cjY3TnFTZnZqT0dKbUVuL2YwRCtoYTd0OHhKSlZyZXc0Z05TZnBhRUZBU2Fv?=
 =?utf-8?B?OHFVckU4VWQ1d01EL0ErbjhFRUhreDkxUTd2WE53bnU5T3kwalVtSXJkK0g4?=
 =?utf-8?B?NkFtRHllRlhBYndJRkw3bkRSUE5uOVBHazgzT0VPQStJQTlONFlUcThYOFlX?=
 =?utf-8?B?b3Z5cm4yZXhvNWFPU2RXMXNFWEYwYlNsWHd0NUQ3cHVsMUhjTU9MMUtrbytC?=
 =?utf-8?B?VlFzcVpPbzZmcTM5R2VHRlYzY2NYZ1g3cC80azBKalVjZi94WWZkVmJYQ2la?=
 =?utf-8?B?M3VwTDNoeFVTdlJBT2lxQmhrQktaZXpzQVkrZWFnQ2RubDlxL2x2V1FHRnE1?=
 =?utf-8?B?V1JjeHJQTTBsZkhWa1NXTno4Mit3a05yMndDdkRQaXBpaWt2YjV1VzdXVTZK?=
 =?utf-8?B?R2xYU200ejFqbE13bUZLOG5yZU5OQU9ReHc2ZmFXcnMyL2tTcTBWQkZvMWdS?=
 =?utf-8?B?VjFkNVN2Z1dKMGk2ZUZXR0VGYlBiWHJ0RlAzMXRvSStkMXY0YkUwdHhBdG4y?=
 =?utf-8?B?dWx2MVQ1Rmh0UzBqWXFzTnZCYTB2eENhUDEwL1pTV2d2aFN1dVgvS2JpSUpD?=
 =?utf-8?B?VVI0RFlEcEExVGpUVU5PTUVvZ25BQXBxY29DYndRRDJDNVVGampBUmU0NnEr?=
 =?utf-8?B?K0hrTHJaM0NydDBUbEdwc1Y1dHd6UVpXSHFrMTdETHZmVndOSWp3RGZtUnJi?=
 =?utf-8?B?dGFRVHV0R3p4RFBPWElmcnU2Y0poVUgzeGRLNyt5OFFQc1B3eS9EMzR4S2JE?=
 =?utf-8?B?MFBWT3VoUG0yMFJ1cEt6QUM0NHhYZkFBVVZzZlNEcllGYzcvZUNlRWRFc0NZ?=
 =?utf-8?B?M1U2MEJuOEhTQVdDZHA3amNSSXd2blJRak5PQk51QnJEQ0NDb3ZRREVtSXo0?=
 =?utf-8?B?S2xHVjdpMW5GdncveGkxdjhtcGZSTFJ5RFF4YmgxMmFsbjBxc0g0UUpKeVlK?=
 =?utf-8?B?ZHJIL3VsYVVyTVFabVZwbVVTMnF0ckIrbm50bzdnY2s4MnNnWVJCYk90WExj?=
 =?utf-8?B?UzdjRUJKaEFvekdyaHhOM2hqeVRnWFBVNHRVSGZMeTl4UFAyK1o1dktwSGpy?=
 =?utf-8?B?di9QUk95WmoyRXdYZUhOVnRHSlM2alU3eU9yeFlFaWdRYjFQbEhFNGVzaVNX?=
 =?utf-8?B?ZXhNNkprcVhHTnhwLzI1NWhaN2Y4UzdmRjg5WnV1eXYzamZ5RWVrVU0xc3U4?=
 =?utf-8?B?cUx0UitkN01JUjdUK3d6UjJ3dTM1dkt5c0U2NHgxT1VGcmxNKzhqaHd2bUVJ?=
 =?utf-8?B?NmJBL1Y1SzhETmpFVitucE9Tc3BhYjViekhhUmlOeFpHVm51dGE0MkNiM0Vj?=
 =?utf-8?B?K1EydXVqL2owQ1FBVWxreUtNemVJb3VJUy9xSnBybHovM3praGFVU3N6KzJz?=
 =?utf-8?B?cUFmc3RRQ3VGYjQ2eFZtNzhQTmcvbEpJcEtBK25DM2Jha09tbUh1V2owUzFv?=
 =?utf-8?B?VDNRSzZYV1NXdlpsczFQZ21jeGRiZVlrVnl3TW92bUNKNjc0T3NFd2RxT01t?=
 =?utf-8?B?UmdWdG9heXVUWTU1c2hIcFh4eTRDajNNQWdmSE1xNVdpeVM3M1Q5d3pqUHRy?=
 =?utf-8?B?NDk5a3NOWFVDSHk0enFHRFlsYmVYNk9DL1E5T2pPaVpFYTdUamYwVEdSREVp?=
 =?utf-8?B?NDNkZ25PSTBjeHM2eUdaM1J1cGNrUXpPK3BydVJVelI1aDNXNCs2NHUwc1ds?=
 =?utf-8?Q?YqJ8jfdzpAjMhfRaciuX/iAy/sSP1nDgV7EQthS10G1Y?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e2c8a0-64b2-4a60-4fd3-08dd1382ec1e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 10:11:58.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMsfuIjpAUZ9GVaTJKvl4+QOWP9tBtNVrhSd1XW7T+fxv5wJZI40NGa/wKTkTgkDAeCO0DnY8Yh2hwv2kuGLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9561

On 12/3/24 10:31, André Draszik wrote:
> On Tue, 2024-12-03 at 10:08 +0100, Thomas Antoine wrote:
>> On 12/3/24 07:47, André Draszik wrote:
>>>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>>>
>>>> The Maxim max77759 fuel gauge has the same interface as the Maxim max1720x
>>>> except for the non-volatile memory slave address which is not available.
>>>
>>> It is not fully compatible, and it also has a lot more registers.
>>>
>>> For example, the voltage now is not in register 0xda as this driver assumes.
>>> With these changes, POWER_SUPPLY_PROP_VOLTAGE_NOW just reads as 0. 0xda
>>> doesn't exist in max77759
>>>
>>> I haven't compared in depth yet, though.
>>
>> Is the voltage necessary for the driver? If so, we could just not
>> read the voltage. If it is necessary, I can try to kook into it and try
>> to find in which register it is located (if there is one).
> 
> Downstream reports it in
> https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-mainline/max1720x_battery.c#2400
> 
> so upstream should do, too.

I should have checked before answering. Indeed, I will try to see the
best way to choose the register based on the chip. From what I see, it
will also be necessary to change the translation of the reg value to microvolt
as downstream does *78125/1000 when it is currently *1250 in mainline:
https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-mainline/max1720x_battery.h#49
 
>>>>  static const char *const max17205_model = "MAX17205";
>>>> +static const char *const max77759_model = "MAX77759";
>>>>
>>>>  struct max1720x_device_info {
>>>>       struct regmap *regmap;
>>>> @@ -54,6 +57,21 @@ struct max1720x_device_info {
>>>>       int rsense;
>>>>  };
>>>>
>>>> +struct chip_data {
>>>> +     u16 default_nrsense; /* in regs in 10^-5 */
>>>> +     u8 has_nvmem;
>>>> +};
>>>> +
>>>> +static const struct chip_data max1720x_data  = {
>>>> +     .default_nrsense = 1000,
>>>> +     .has_nvmem = 1,
>>>> +};
>>>> +
>>>> +static const struct chip_data max77759_data = {
>>>> +     .default_nrsense = 500,
>>>> +     .has_nvmem = 0,
>>>> +};
>>>
>>> This should be made a required devicetree property instead, at least for
>>> max77759, as it's completely board dependent, 'shunt-resistor-micro-ohms'
>>> is widely used.
>>>
>>> I also don't think there should be a default. The driver should just fail
>>> to probe if not specified in DT (for max77759).
>>
>> I hesitated to do this but I didn't know what would be better. Will change
>> for v2.
> 
> Just to clarify, has_nvmem can stay here in the driver, just rsense should
> go into DT is what I mean.

It was clear don't worry. This answer is related to the same subject:
https://lore.kernel.org/linux-devicetree/20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be/T/#ma55f41d42bf39be826d6cbf8987138bcc4eb52e3

>>>> +
>>>>  /*
>>>>   * Model Gauge M5 Algorithm output register
>>>>   * Volatile data (must not be cached)
>>>> @@ -369,6 +387,8 @@ static int max1720x_battery_get_property(struct
>>>> power_supply *psy,
>>>>                       val->strval = max17201_model;
>>>>               else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
>>>>                       val->strval = max17205_model;
>>>> +             else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX77759)
>>>> +                     val->strval = max77759_model;
>>>>               else
>>>
>>> This is a 16 bit register, and while yes, MAX172XX_DEV_NAME_TYPE_MASK only
>>> cares about the bottom 4 bits, the register is described as 'Firmware
>>> Version Information'.
>>>
>>> But maybe it's ok to do it like that, at least for now.
>>
>> I thought this method would be ok as long as there is no collision on
>> values. I hesitated to change the model evaluation method based on chip
>> model, where the max77759 would thus have an hard-coded value and the
>> max1720x would still evaluate the register value. I did not do it because
>> it led to a lot more changes for no difference.
> 
> Downstream uses the upper bits for max77759:
> https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-mainline/max_m5.h#135
> 
> I don't know what the original max17201/5 report in this register
> for those bits, though. Given for max77759 this register returns
> the firmware version, I assume the lower bits can change.

Based on this datasheet of the max1720x, the upper bits are the revision
and the four lower bits are device. So it could change.
https://www.analog.com/media/en/technical-documentation/data-sheets/MAX17201-MAX17215.pdf#MAX17201%20DS.indd%3A.213504%3A15892

If the four lower bits are not always 0 for the max77759 then I guess it
is necessary to change this as it wouldn't work with all max77759.


Best regards,
Thomas

