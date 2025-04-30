Return-Path: <linux-pm+bounces-26460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CBAA4DDD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E86A3B37C4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD025D8E7;
	Wed, 30 Apr 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="juhEZaaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2112.outbound.protection.outlook.com [40.107.22.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA51D6DBC;
	Wed, 30 Apr 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021000; cv=fail; b=mIZL8F+NRKqrUFFK+8RAV7tt5DSqkJjf5353IHMeTSvcDywHETDen/jiGbkVebcsVHYbH2F7+r0+6k3jjCgICSnDh/aRkrQY7umOXWyjwoRrBw9S32HX9rcOycKpPhUVyFmrVwGCI5ZNQWQmoJ7U6JY8GCqn94RXAP3tJ3JwLng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021000; c=relaxed/simple;
	bh=IucfSYHYx3fFYxFwvlJOZzIXAPZyR05wUmmyBrhontc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJMMIsRVUVCtC0E2+HnxuDfSk0/jkEHhD4IJFiHRydH3XWRBZCMl8VECoUmh0/06rFWhX8csGDzNN6i/J3jDrwFu4fYTh3/1BG5s8zIBwKFnBbmjb32jTGZmubrvFp/1Z3R0BhYIyVuJZb+5ZIL5+BCnAr/kllQtR67YmubyjwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=juhEZaaF; arc=fail smtp.client-ip=40.107.22.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcatJLQkrbp+gXaJScF1McxjfWK2LWt8H9mlx53a3543PjPe3SdTb+9G7yhIdRkMDUqS/Pw1SUDv97WNNhd/uSJIa7sPPLI2wyFR+G6yize87WVSylUdNIdKfmS/dbFfmiDhi0IzCJoTZPsALyKrS+0nCChPUFhVBU+1SId/ZX/Jsyi3Yi6L3bmWmcnRvYnR7D6RVpL6RPRkZ7zqrAqrOpY/4F1+GrStu8tpZ5xIkYV7gF6VjYEmFIrSg1kEQKOOBw9vMdmh4JsgBR4YyWTp6ElJ5uF3aAZqkUH85UnawMZlY+utfZEi6JFbMIlTWVfLYTDzASrWceWQIzwveSmnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jERfBa7XOF7DDelPcDI7CB+VTAzLtijmCvMQpNGJ87Q=;
 b=ZDNT055BzWL7CY1VpEzVNfFR2C9600Yd2A1PkokZxw7iT58u3WyGY80wn7curv2ZVnFZgfGIjUdOlI1yH+WfVpmjxkY5Sz7Rr/bNg/WTmemDXuYoNb22X5r0q6SqtG0K/o2VK3LHa12f8GigsxLLMnyksEvnRm3y3PB6vn4aL2759DVyRu3qY9kTT2FPH+Dy2N2tGnfWGkAj+teaZv7lJ6WqGD+WIQW5XAk1tnQUsretDifCYxa/HTbLJLkSezVx+Xjoi0FN8GzxlxfpfK1svJCauD2HKyYDoNifsQG3XTZUR55kt+epESi6oabLF5SoCv6FAYzzEZYWz1drQfujGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jERfBa7XOF7DDelPcDI7CB+VTAzLtijmCvMQpNGJ87Q=;
 b=juhEZaaFulfxD4NFtwAP3/qv/YhgH3MjsawbOMwDaSmuUOqtoQ6cECGoMMKbx7LEcYrVIgeDrcJ2Z1FfBUVcCBxZovGIysKqbdXg4CJ0fPqRGl9IM6cMdrOfhOgHd0Ebjpv3RM47bOPaGFf+jFFWTkOkExtRMY5nSmm9flz1gIPUpDnxAn6nC11IJCQOe0Fhc6z30HboaGb0FpInTAPsutkjxKlUHjrBmutXQuvpykV7oBMHaxeNtSVIGag31fmjRnQ6nLMimb8SE36nlPKogvUCbQOMcxiAkP6cWtdJ4eBI8zNn0Yjp2VxHsBTXXpic2CC7+ABDpvj3f7sUGWBzyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DB9PR03MB9711.eurprd03.prod.outlook.com (2603:10a6:10:453::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:53 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 13:49:53 +0000
Message-ID: <49ead205-0181-4d2f-83c4-e04e501dc95c@uclouvain.be>
Date: Wed, 30 Apr 2025 15:49:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] power: supply: add support for max77759 fuel gauge
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dimitri Fedrau <dima.fedrau@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-2-50cd8caf9017@uclouvain.be>
 <ieh6g5m4oectmje2gowa6rl2blzjuovjpyd3cmbvoql4qn2c7m@2osiwclwxi43>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <ieh6g5m4oectmje2gowa6rl2blzjuovjpyd3cmbvoql4qn2c7m@2osiwclwxi43>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DB9PR03MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1db28a-25e3-455e-8e50-08dd87ede249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGZiRXNHWWE2eGFTRWhMUDZKQmxESDR0enFRdTFJdXVpZUdrVVUyclR5bVpi?=
 =?utf-8?B?RWdkdmRwSS9oemtQNHJUN2h1eThlUFlPRjh6dHZBdEV0QXc0K04xS3RId2Qr?=
 =?utf-8?B?amJUSTRIRWt2M3Q2QWJhTWJqYkFFaG1RN0R0azNhODU4OG80b1pETHVIQkFm?=
 =?utf-8?B?a05sZHNNV0NjQ2hzWGV0T2tRdm5xRFVwNFRMQkVTSnJHdU9XemREMHkrWUtS?=
 =?utf-8?B?Vmo3dDkrUXh3YUg0dTMzL2pCSnZiNUxoRnVTbW5Wc2VKcnY3VW1RaVNBUjFt?=
 =?utf-8?B?eFF0dHVNczRzT1Nxelg3U2FPcWQ2aWpzMmVscW5sS1IrY1ovWGl0VytmNlVV?=
 =?utf-8?B?bVhFTzFwUG94NThYb1M1aVR6eE85eDc3RDFybVpjckZzd0tITzZRVmQwK2Zw?=
 =?utf-8?B?V3VWaGdVa1MzeEgxV3psMjdKTVR1cFNjZFdoWmVEdWt2TktSNG1uMWc3U2dO?=
 =?utf-8?B?YkErbTYrc0dTeFZNM3FoL0NPTnFtb3JDemR6dDU5ZHJscWkwTkcwTlptcWNS?=
 =?utf-8?B?ZGFucEtRektMOXZkTWszOGQrVFppZlhQVHVXMGx4djh1SExqZzZMb1BabDdR?=
 =?utf-8?B?OFZLWjRnQ1c0V1B6UnpCdEsxc09nTjBSZTJxZC9MdGVBUWJKMnArWVNXYWdS?=
 =?utf-8?B?WjhxZFhkV1RVWERrcDJQZDc1T0MrdEtsek1TRDkzRjgzUHZJTWhyY0t0NVVS?=
 =?utf-8?B?RGh5UUd0WGU3N3h1L3ZDWnp2S2h3eG1UL3pBSTJ5UFk1ZzVsZkFkc1l4cEty?=
 =?utf-8?B?bVc1VWVTTDF0YmJJUVJnNUNldXJKY3RIai9sd3lIb1hHRzRvQ0s0ZVVRTm15?=
 =?utf-8?B?QWhqRXBTWVpDeGthaEhVczhjVWNOUEl0VkJaR1pYZ2ZMVFFpdTZQSmI3eFVZ?=
 =?utf-8?B?SUxIdFVDQjRBSEpvME5uM3lpWW9pMmZoeWdGaUM3cFk0eWJYVU5GWktoK3p4?=
 =?utf-8?B?Y1h2UGo5SGVQQi9qVm5nTVFLTWlRNk12dzl6bFc0UnhpYjhJWVlNWWR2cVBE?=
 =?utf-8?B?NEV4dm11VkdaTXhLV296L1hPQnBlcldPYlkzRGJ1VnRkUWx3d2hZemJLYmRT?=
 =?utf-8?B?ODBBK2RpTjJXR29VaEJKVlYvZGNCZFR2SEF5U0tzZnBlWjFxMTRxU0sxbTZQ?=
 =?utf-8?B?UnFLTndHZWdtclpoVjRkbU1FNGNLdzVxckQyUkpKSUdMS3ZPUDEwOE96U0Ex?=
 =?utf-8?B?djNqM2h5cEh5WEZCRDZLV2dINS9KandkM09JOElVK2ErYU1pWWxrdDU5eWU2?=
 =?utf-8?B?djVEM2MrcDNNUFpxS0lmUDN2WEUzYjNnd294SWRnWE10Lzg2eSsxd0dXbkwr?=
 =?utf-8?B?WEtkcXhDSjhuTFphTHRhckhTYVRwZzVHOERwQURmZTNIUS9UNEZZUVYxWEhC?=
 =?utf-8?B?NzVtN2g4UHZ1Nk5Qc1RnZlhBTkZBL3cvQ0VsUkxhS2o2c0s1bVlCK2ozcGdu?=
 =?utf-8?B?bnRLV3pZeWY0Q29KK3owamVYSzZ2TWhGN3Y4UVh5NktCS0pqeis2VlJkUjJo?=
 =?utf-8?B?WTh2WU5HOFErVzZveFVzWjhKamNoejNxRTRBekZvL2tGVXNMdWRmaDJDMnoz?=
 =?utf-8?B?aytTRFBYbExhRGh3dXNya1VhMzU5UmkvVmJ3NVR1VzFJOFU4VlNhU3VhL1pT?=
 =?utf-8?B?UThhZ1VPbjJSbGVVbHA4ZTFsY3lPRTRQbzRNeSsxK0NjelhVVGxFc1hGSXFr?=
 =?utf-8?B?dENGK3ZNb1RyWnhJMHZYQ1JhY1VmWXZBUWpVRmZkUTlwTUdESkhZeE9yMFZC?=
 =?utf-8?B?R1VWeHZXMmFBcmRsUitRWkRxd0xmdnl2dkRmSEV4aTY4NVpzMnpRMzZpeHp3?=
 =?utf-8?B?TWN3T2hpWWtucUF2T0p0SUFENFhnUllsM2N1VkVmZVhHbWNHQi8yakpjVWh4?=
 =?utf-8?B?MU1JNnZuWnNURzY4VXNEcW5BUi9HSVZ2aWY4SVA2YjZkeDBxcGRra29hREJF?=
 =?utf-8?Q?yU62TEKG5sM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFodEFJbDhEdTNGT0xmNTdlMFdRbE1IOHdMUnNKYnVTZkFtdjMzV0xHMkRQ?=
 =?utf-8?B?VnkvUWJ4VkFkelc1TkY4RFd5MVB4cXVRSWEyQmUyYlF5Y3pCNVlKdzdKUXdP?=
 =?utf-8?B?dEgrMGdHeHYyekJlQzJHcnRYNEt6a1A3MjduK2RTVTI5WEZSWXdJbkxtamhq?=
 =?utf-8?B?LzMwei82TEVESlFEOEIyRDBhdkNVdkduR1Vua0d6aWtJcDd6eVV0UkJTakVF?=
 =?utf-8?B?UXFuOXNxSlBKclJJdzV0dHVEdVNUd2QrV2J0ck5FRzc1ZjJ4d2lPMjNkRzh2?=
 =?utf-8?B?Zitxb3RUZDkzdXcvQmhHc1lzcGZ4OEo0bHhnRWt4NUZ0NDA1MVg5eUxtOWJF?=
 =?utf-8?B?Q2RxbE5xSWlrQ2VRUnltMGJzM0Nhem00dFRlVVNjeStjOUFyT1dGbEVOOHdE?=
 =?utf-8?B?aFdCcE9aOGs4OFV2ckpnRVJaZGRiQXg1ZHZzbDZlSnVHeXF0LzJLelJyQmlu?=
 =?utf-8?B?OUxIeWp2dkRDLzJBR0ZqaHpzVkJMc09qaEZ4YUhubjMrZGd4czlTN1dCYVBz?=
 =?utf-8?B?UTdncFYzTUcrdnI5emp1cnIxSVY3K0FGbXlMZkR3bC9tTHlVbUdUeXlwQnN5?=
 =?utf-8?B?S2kzNWVSbHl3M1ZXWndVd3MwaFZxRDVUNG00ZlNKaldFejJCQ2VoZUgwWVg2?=
 =?utf-8?B?TTNPZysyb3RSZmF2Sk5vd1hXcFVnejZZeklnUjI5a3J6cTYwMDg2b3ExVWt3?=
 =?utf-8?B?K2tmYnkyNVFoUy9QeFVZSVE4MXdUNDk2UjU4ME5GTCtzVUI4UjVRSTVDdzEz?=
 =?utf-8?B?NFlwa0NGQTVmdUlrVDA1Zy9WTHkvTS9lNWVBNTJqdDYrTXl4bWNoRXFta2F0?=
 =?utf-8?B?SVlxREdmWWxRZ3U5NEZ1Z2dwL2Ewb3pGbXQ5YTBLSlhJbERpdy81ckxlVkxC?=
 =?utf-8?B?VS9PUVVXLzhDbzdnQldDdmtDNEg3NWtjV1hTU0xlYUNYeTRJRGRRa2t2b0U4?=
 =?utf-8?B?bjRnWW9SMjl4WUJJbWQydGR1VlF0cDVCemRMMVU4YnFQWXkxWVU4Nyt5elBL?=
 =?utf-8?B?Z0dsOU44UzBLZjhGWE03WTFMVnVhb3Zna0xJZ0VDSjdia0FBSzFyQm01YXhV?=
 =?utf-8?B?Vy94UW1DYittOVNMKzlEKy9xMW4va284VWdQNXo3b2I4U0NLVE53MEVTRk14?=
 =?utf-8?B?WndwSUNSOTB2Y2JlVGU1bCtsQnlhaE1vK29MVkw0SnhpR0N1SW5heU5yaWtX?=
 =?utf-8?B?Q3MrblJNZXVZZEpNSngzVWp6U21CekZrMlBYSXlzaEVXTzVyNWIxVEJJampm?=
 =?utf-8?B?RE53MDFpZ2NJSWc1MDNLaVNjREE0dEg0NnhCWnhhRVBjWWVJYzNkVTBCOWdi?=
 =?utf-8?B?enBvYlVLWCtmbnowTWtDdzZVRHVXaTg1TVBTUndBeTMycDFVaWt2cHptSjlG?=
 =?utf-8?B?aXB4d2p2WWtwVWdEVFZ5UDdHOVg2cDUrZ21CNE9RL0ttZ1hkbG9tdFl1a1N3?=
 =?utf-8?B?SzN2T2FOblgvYi9mWmRsUXVUMmVuQlpuRS9KVDhIZmRyU3VrNFRsTDFBcHBF?=
 =?utf-8?B?V0ZTa1N1eFdXTmR3VVBkRTJid0ZOS2cwbUNFN3J5L25TWUFTeGthenFycTUy?=
 =?utf-8?B?VmhENTBZZ1hHVHdjb1gwK21QaEUxWUV6aFpvSlhydEtmSDhVVmcweDJNdDZS?=
 =?utf-8?B?ampBT0g0OEkxVEQwMk5ldFZseEFtTWJBbC9JSzRZL1JjaWRhWHhSejVDZ2I0?=
 =?utf-8?B?cFdHQ1hENUlhTmsxVVJHMnZxbzZ0dC9jMDBFdmx3OWtHQU5lTzlFbDB2dTBB?=
 =?utf-8?B?YUFacHpzYWw3bmJBbGVZTmRSaTl1T1ZnNHdFanpmOVl4TGlnTHZyMmE3QzRX?=
 =?utf-8?B?bytzMEZpVHNBdHJtYzlMazB2R2F0MDYveVg4V1NvNnVSTjlocXFyMGZ6MTFJ?=
 =?utf-8?B?TDRmRjhCWHRqdm1naHNtck5FNldIRlhIWHNBM0FrWHNhQjB3R0NXcnBIbkR5?=
 =?utf-8?B?Q2tvTUwySWJ6OERzbjlIeGQ1MmdDQWdSQ052U3NVRGdYMEJPNS90VXZKQVdu?=
 =?utf-8?B?UDcvMGlyM3FqaURYQ01wYVN6VzEya0hsdmVJU3RNR3ZxWFBhaitKRUh0MEhr?=
 =?utf-8?B?WnRhd3NwWnFsNFRwVzdUUWtBZGNwWlBiaUFkVWg0R2oxek5zZzNLV29VVU1G?=
 =?utf-8?B?ZCs0c3hIWlBkRkgvSTBOK3VtdWZaT0hOcUw4WjhySWI5TWtiQnVkektRdENE?=
 =?utf-8?Q?v4d0n30NPirGcijiMGVPGewKtnPnH8bMQX7VCEzfluFB?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1db28a-25e3-455e-8e50-08dd87ede249
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:53.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QocbOCD7T7RiBaVvQawPLd9r1YpzjQyQacgTIUoLLaBmmmWiFIgd9aJV2CJT73lewFj+92OXr3LeL1OgAP63Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9711

Hi,

On 4/30/25 02:36, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Apr 21, 2025 at 08:13:33PM +0200, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The interface of the Maxim MAX77759 fuel gauge has a lot of common with the
>> Maxim MAX1720x. A major difference is the lack of non-volatile memory
>> slave address. No slave is available at address 0xb of the i2c bus, which
>> is coherent with the following driver from google: line 5836 disables
>> non-volatile memory for m5 gauge.
>>
>> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>>
>> Other differences include the lack of V_BATT register to read the battery
>> level. The voltage must instead be read from V_CELL, the lowest voltage of
>> all cells. The mask to identify the chip is different. The computation of
>> the charge must also be changed to take into account TASKPERIOD, which
>> can add a factor 2 to the result.
>>
>> Add support for the MAX77759 by taking into account all of those
>> differences based on chip type.
>>
>> Do not advertise temp probes using the non-volatile memory as those are
>> not available.
>>
>> The regmap was proposed by André Draszik in
>>
>> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/
>>
>> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
>> ---
> 
> [...] (I actually skipped reviewing big parts here for now)
> 
>>
>> +		ret = of_property_read_u32(dev->of_node,
>> +					   "shunt-resistor-micro-ohms", &val);
> 
> device_property_read_u32(dev, ...)
> 
>> [...]
>> +	ret = of_property_read_u32(dev->of_node,
>> +				   "charge-full-design-microamp-hours", &info->charge_full_design);
>> +	if (ret)
>> +		info->charge_full_design = 0;
> 
> This is not in the DT binding and thus not allowed. Also I will NAK
> adding it to the DT binding, since the following should be used:
> 
> Documentation/devicetree/bindings/power/supply/battery.yaml
> 
> followed by using power_supply_get_battery_info() in this driver.
> 
> Adding this support is probably a good idea, since it allows
> providing all kind of static information from DT and you are
> missing the non-volatile memory part from the existing chip.
> 
> Note that the power-supply core will pick up and expose any
> of these properties automatically.
>

As I said to Dimitri Fedrau, this is actually a mistake on my part coming from
an attempt at getting things working which failed. Charge full design should
be correctly computed now so I don't think it would be useful to get it from
DT.
 
>> +	ret = max1720x_get_rsense(dev, info, data);
>>  	if (ret)
>> -		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
>> +		return dev_err_probe(dev, ret, "Failed to get RSense\n");
> 
> You can either drop this error print, or the ones in
> max1720x_get_rsense(). No need to print two errors.
> 
> Greetings,
> 
> -- Sebastian

I will do that in v4.

Best regards,
Thomas

