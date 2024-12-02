Return-Path: <linux-pm+bounces-18357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA79E0677
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CC2BA3834
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A23205ADE;
	Mon,  2 Dec 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="tFftLeIz"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2105.outbound.protection.outlook.com [40.107.21.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152320013D;
	Mon,  2 Dec 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151883; cv=fail; b=QJI6XJoYB+dwf0DkUwseh4amfQhNx7ALzfF82GB/NSxCO5k6OHl/6qTSmCZ44N+Q5gKfVdEJKEXs/KTWno8n5HdXfu2GhiWOZkRTGPv3wgJU4cUcAOvRdMRbAuxfMNTooz79kE+ANOOgUGy+5ZO5gIzf6BnySsxGRdopFerPS74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151883; c=relaxed/simple;
	bh=NyKepsKCFtgE8SRZWLPkyh2kdW+QIbsUSpFvG1uq+e8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GRt3wghCNH+DX5QxW/ALifq65x+jFLYOhlwZRLHnO29agr5WOxWZcV0QnzsHQkA7ZgZpa4GjCXUE+tb5FpULK2g5rLZN5ftMeQCiPlhqlT+M9bG4GbyldfsXyBy46hy4cv9q0aHQdoAhgjHVbqQU3bv2HOjV7UjOFRs2WWeLP4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=tFftLeIz; arc=fail smtp.client-ip=40.107.21.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIMwphPDGq4Xi80mgJcJWS8pPN9CIfkQrRwqs27R6dxaChtz0UlB/6RbaJXykDK3U6ImcrWZF4ZWICqCp8BN6YScx/X9QMFpIzmZ3CjNMU6GddZCmhJ1jqjIpUS5mXH72fu+V4vFo3NrjvsUryrPbTKPJHU2S9AOrHRfJRopsvR01Ttd7RK/AaZ3HUQOWsDA24cdpf6eL8lY8vji0jDZxNziY30CKLSAbgkK9Rv3WO+6sucJtEyl2gNj8xlSqAl4pf++lBFH2gIqAof2mstdBUVlGzBLm9/dReQy8gClDREdDLaNHTWw05hu5Y5ZtF4UZUaFCkHvjNVuo5EDYFBIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzkH3SE3Dp5CsyW0LSRpN9sNaj8fS0mAwf3s8stGXT4=;
 b=rLlTQthjQAG1PkZuw0k9Wmm6l8QzyY3dV7JLPK77uXC3f877M3JBj5JoBFHmoEjmcol8oxQinbPGZ9XD6+yjYSLJ8on8M6J6p6YWXEhe2q94DvlnEs+e+IeilsjQEwiMBT8itFwkZ001aVnJLVYL9WZ972VQh95jkPxKygiH161lExSmjpjvirwzwSOP5zMpULBkJiIpVMBxjtUX8xdmRIdTZA+OKXtVd0axvTJfg6B4jKpHpyj8fWkM0/SKGXmIJS+WUscObqococtdlS0qJp+wc82uKxDTMFCpkQ+XV8vMSB/E1ltr17la8TqaCk5RlExMEYr1jWBrtWQwxCGrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzkH3SE3Dp5CsyW0LSRpN9sNaj8fS0mAwf3s8stGXT4=;
 b=tFftLeIziofoAOuq5NKtBqWBb0TTnKZpTakxT351mIHcdZnStDoJTn+B82P62cBqzN5UNu1isZbNlxD9z+ridZY8ND/kI5vbdYuvmawemGm/YDkbcliTaUzJ6Tnyb/wH/mWlZO7nPA4ZL/c9kQpjEY0C08/OBynuuu75BXV2vpqLMJGClqMwdOkdq6/c4swyt/vOzztyQP2B114Y3x2Xd3KN/bBLN17fyCX8C/v3PKH+CFqtBJy4y/fxTMSYPWXGEZHOSy9tTTp6yATRilIWucKW9Kc5Sxp+Z47n1ki6tGhLsaX4V9zSt6XT+JYKiZRaRtWhI2BIHu68EdfTZ62YuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AM7PR03MB6499.eurprd03.prod.outlook.com (2603:10a6:20b:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 15:04:31 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 15:04:30 +0000
Message-ID: <b8b72bde-31f3-4148-bd01-49826f9f9bd7@uclouvain.be>
Date: Mon, 2 Dec 2024 16:03:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-4-98d2fa7bfe30@uclouvain.be>
 <68b897f0-5583-4d09-87d5-4ff4d3080ef7@kernel.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <68b897f0-5583-4d09-87d5-4ff4d3080ef7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AM7PR03MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 181adfcd-8fdf-42ee-ece0-08dd12e29f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlB3Mm54dDJjM3RZVmp2L2dHU0FvdHRGei8xeWs2OHEwcUZrc1JnMXMwR3hS?=
 =?utf-8?B?NWpoQ3REV0FlZUVvN1JCdFA5K1Q3TUtkdTRQaDhnZzNTREU3UWxtUGQzQlFo?=
 =?utf-8?B?ZUJnYnlScDY1NkpKWVBDV1ZRVHB4RHQrQWtSVjhmci81ZS9Eei9WVWJUQmpJ?=
 =?utf-8?B?c0NhNE9BR0pPYzRKRXJ4V3ZlS2JJdGtrQVNtSi9HRDA3K3FjNUdoNEcxYnI1?=
 =?utf-8?B?YTg1TEt4dVBiZEhkMFpzWnV5c1BiS21iMEhxckZOMjMra3VtczRqSUsraGZt?=
 =?utf-8?B?aHBmc0JBUFNGd3F1VGdVZ290aXB4WTlSRENKT0lwQmY4bno1QW5SYWsrSUND?=
 =?utf-8?B?cjk1dTZESnU1bVZKNVFObjN0V1BkVTlnSkdkbHBzTEdKRlFwd2E1Rk9YTjRP?=
 =?utf-8?B?dlJSRXg4K0dYcFcySkljN1o5TFRRNFBWdGNwTVgzelc0VEUwNFNScitDemtI?=
 =?utf-8?B?dFpSN2F0R1lQQTRyTmdwS094amppOXpSemtEUzAwKzlzVm9KZStzZ3Btb0Qv?=
 =?utf-8?B?d09HYXR1N3NxT1pjYkROL09WaGNTYkJtZzlqWm53bnB4S0JKMkRkWkg4R3Jn?=
 =?utf-8?B?TDI5VC8rSHJlMjI3VEF0K0J5RzkrTmE1VnVCTXpZekVIUGV1QVRmdURpaVds?=
 =?utf-8?B?c3RmbmlLR2tQTjZXdnFLdUpyQ2tQcWFWU0U1RWtGc2lRS1RQaWpaYmtETHJG?=
 =?utf-8?B?L1ZUWkhyc1hHRVdIQ1N4VktqUURjbklFM3AxM2JoUjh6L2VEcGRzSVdMeVo5?=
 =?utf-8?B?Z1V2N09wcEwrZEhBdHVETE1qMVNoWUJLYWRGSlBGRVQ5cDM4dlBqamtzWG5H?=
 =?utf-8?B?QTV6S1RhbHN4SkxBd1JUbHNSMkJsL1ppelBMWE5SQWkzSm14dXVnZzIzb2hH?=
 =?utf-8?B?eHp2cFRFbEdqMURwVEx6a3cvVHpTd0NCY1VHQTUrOVBhRHhPaWdjU3oxUjZr?=
 =?utf-8?B?L0tpdDFpVTJXZjdMa3JrYXR4Nlc4d2wxUDJzSHBTWUpUeDFzdFhoMGl0TVp4?=
 =?utf-8?B?aC9lSCs1MEVPZGo1dDNlZDhnckhHUXNmRkt2cWhwQkQrbWFRRVBGWm1HNXVT?=
 =?utf-8?B?VGNaMWhENGVnSUFKaXNXbWlLeEVDZGZKc3R2NDBSTEtRZUpMUlVzREVyZWNa?=
 =?utf-8?B?K0dzUlBlODUwZS8xbzRaTllpUHR1MzByZUg4RGxraDk5RTJ5T2RjWVF0MkVs?=
 =?utf-8?B?aTRqUmdvMjg5S3NFbnNodnBBMllYQUlWcEZGQzU1LzAwb0hidXIxa0dmK2g4?=
 =?utf-8?B?elgrV3ZIc3o3c2ZjZHZYbU1TZXUxZmY5ZDZvUkdDS0pzRFVmc2dqVWQ3OEZa?=
 =?utf-8?B?M2FQYUk2emFnb0IraDZVNXA3c1pTV2tRdkNOZ29JR3lLa0YzUEhpeG0yczRF?=
 =?utf-8?B?eURCbzNWazcwb2hvWWlOR3JUVU9GRUJ3MjQ3SjY4d3NwNHo3dERlSW5YbmRY?=
 =?utf-8?B?WkU2VVJPMUtjTTFQM0kzcy9OT3lkejJLdDFXb1U1aWI1Z094Qm05QVRYeFpC?=
 =?utf-8?B?cnZ3dDBpaWN2WDh6MzRTSTFEeTczRnpaSXpCdEFZZndiOEt5Mlk4ZjRZOTZK?=
 =?utf-8?B?bUJlQytYV0pWRHFIU1I0aWNNeWFreWRQcXQrRit0c056VUVXRmc4aTdrb2Fm?=
 =?utf-8?B?TzIvK1VDYnhpR2lWQWN5MWlFaUNUempyWGZyc3BkUmNSTmRSWXhtZExWWjlD?=
 =?utf-8?B?VXBYRjJBdWh2QTdjVHpIT21SRktaUktDYUtSSHlzbFFiSGMyL1ByTkJRdEM1?=
 =?utf-8?B?S0I4Y05kWTY3RzJmZFRxMEFUdlZzWFZUdHMzNVBGSmN1ajh3WEF6YTZnb24z?=
 =?utf-8?B?bmVjYVhMWUtqUENFNTZWczk1cmpKc1lDZ0RKN0FGTm13SW0rWHl2MzJBV09Q?=
 =?utf-8?Q?bMiNRKr5qG+am?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZTZ3grYVVqbGZOcGNORFZMUjQ4bit2U3VreE1wYWVOQVd3cGF6T2dPWjRy?=
 =?utf-8?B?Q29uYmc0QXdQZXE3S25ydld1bGtPNmhmU2JZSzhsbS9Tb2s0UTNUQ1VZZUpU?=
 =?utf-8?B?Z1VYZnNpNXNXMXZJeGdtZFljYVF0QURYL2xBNGhDN3pNbkx6azNKYTFRRWgv?=
 =?utf-8?B?MUtSMlJxVnZ2dHBNSVVRQ0JDTHBwcWYzMUNZT1NDU014Z3NLVWY1TUxJVnR4?=
 =?utf-8?B?ektWbXhOZDI4Y09NQ3BnMTFnMG1DOVhNbzhKVlA1T2QzNlA1ZDNWQWlEL3po?=
 =?utf-8?B?NUY0VjRSMGZSck5kK2huUmdoN0JVeWRlOFJhOUZNVTQwNy9md1orc2o3QVl3?=
 =?utf-8?B?d3VHVGJldDhkTkhNLzFwclFNQUR5OFBlK3ZZbXltVjdNV3NBYVczblhzSzFw?=
 =?utf-8?B?UEJyWkpRdHZsMGlwTzNOMDVqbnl5S1ZDSEZSTk9JZUNYRk9zUU9idzJuR0Q2?=
 =?utf-8?B?N2QzT2hOMTE1YzRPSVVhR3FUVU44a2RpMHg0RzY0U3lBVGRXRUlJVWNxR3lO?=
 =?utf-8?B?QnpyWDI3T3Ezdy9paGY3YXRSQlB4Sk1QaHpKVy9CUFhmNUNUeFZYQkRManVO?=
 =?utf-8?B?NzlMUlRwTkpKbnNDYXY0Q01QSEZvYllPWmpadTM3ZWZqMzlBbzlCSEwzZjJD?=
 =?utf-8?B?aDcrNWRaUjVKekxmVlIyODREeXF5ZlRxWWVKVkNHdkdzdUx5eHovRTYxRTZV?=
 =?utf-8?B?WDFvcVBGbTZWaW5rS0pkVXk3MHdiV1pCOGp0bmF1cXM1am9HMmtrZUV6RG9C?=
 =?utf-8?B?bkxhUGpoTnZtYW1mVE9reU5IckFyUVlsdGlxWEQ4UDhDZ0xnNnk0VXRsT3Yv?=
 =?utf-8?B?MXM4aEJHeUJ4a0tMVmt6VzYwUTBIeDNId1BIVm15ZlRXa0hmZHgvNitJTmpo?=
 =?utf-8?B?R01TYm5UekNSbDhRNW1ZNlI1WGRXc0ViVk5zczFOMCt4NEhnbGVXckpMelJx?=
 =?utf-8?B?Wmp2V2kzNVpqVnlUemQrL3BWRnRyNElXdnRoUmpJdkxtdFIzQ0JHZDNIRTN2?=
 =?utf-8?B?UGNyVUFqdDltRng5OHFaWWxVZmRpYncxalRFdURlS25HeCs0ODVZRE94S1pV?=
 =?utf-8?B?MnFId2JRL2F3V1EwaWlBcnI3Z3FPeXZ1WUhiR3BQR1pPdlFpYkc3bmRwQnpO?=
 =?utf-8?B?NlRHVzR4ZlNNRWJGUXVYNnpnMGhOT2FoQTcrRG5TNkVvMzhjYXNMNlUxN2p1?=
 =?utf-8?B?R202Zk56SlR1WE5RR1RFL1BLMmV0VlBEclc0YjE2ZVJWa1FyZGEwTCtvV3Y4?=
 =?utf-8?B?YmJPZ2EvRjhLQk1MMXUyemlpV1ZidFVscFhDNnRSMzM2aFMyeEp5WGc0Qjda?=
 =?utf-8?B?blBtVHFGSFpZTWVXRy83cUJpQk9XYVkwS3k2VXNGcm80M3BQQy8za1FOeW1z?=
 =?utf-8?B?ckI5NzZyR1JtOHpRR2MxNmt4WHQrTUwrcU9LNDN0UHg4VGo0ZUtJMmhacnlw?=
 =?utf-8?B?M05tSGFjQVpkektyQk1ZenBKcHFrS3gwZXBFRWxvQ20yVTR0Rjc3bkdpZk82?=
 =?utf-8?B?TkFuUHQ4MW9jVkFwRlkvMU9RR0toaElWaWlaRVBFK1BRZ3YxWHJZTllNOFF4?=
 =?utf-8?B?aWN6RVYzcHFpcThlamNKMkw0Q28wQjJnS2ZxKzMxZjJ2aWI0a3N5V25PWlNL?=
 =?utf-8?B?VGdYeldCRDhZcjJZZHdyQmltKzBHTmg5Uk1vVXREK2NnaWpxbzNoMUFiTGN3?=
 =?utf-8?B?NjFPeWZVUnRLWjdlWGhoVEdwdituZ1d0STBwalI3a0Zxa1pDMU1mMEI3TkI0?=
 =?utf-8?B?TFBRYnFIQ1dSRXBwY3lIc0pVbTFqN25SRVFvTGJPS2Z0OFRoOTFZZlNraFQ0?=
 =?utf-8?B?KzJCeFFvWUxuVXhkanhaSlRDZm9JamdpRFQ1bENJeXcxdXI0RzhiTW9aenhk?=
 =?utf-8?B?ays0dHdMUk01SWdZQjRkT2crMjJsSmV2ckg5SFFYVCtIUCtmY3dWajZxeE1x?=
 =?utf-8?B?bVJaRzFMbUhWQlNiaFQ3UlJEaHhta0ZIS2ZTOFUyci9Ia0o0dDJQdkc2WlIv?=
 =?utf-8?B?bTYrL01FNi9EeTFjeTJQY05sTkQxeXA2bTM2WkhVdWcxWlRjOVBwSFhnbk5x?=
 =?utf-8?B?emJEMmduREd6WDNwV3BLbWVYU1hiMmQ3S2dLemE2c281bVU2MGRXRlBLaHN5?=
 =?utf-8?B?bFBkNm1HRkR5d0hVcUVWaERyaTUwc2Jkcjd5TExZY2lyTnRnSy9VNFJxNmVz?=
 =?utf-8?Q?9A+U/HZGlDmc9cChZue4hiU75aISTp2osDhrg1qjTsic?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 181adfcd-8fdf-42ee-ece0-08dd12e29f97
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 15:04:30.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47PSEcO+PLorUhB42E9eXDqUCVEBG4zIV8c3TibAdWMe4kuA4f+Aakr/kWN6Pfrj66Vy+7SCy6/NbGSYEfbGlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6499

On 12/2/24 14:41, Krzysztof Kozlowski wrote:
> On 02/12/2024 14:07, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>  &hsi2c_12 {
>>       status = "okay";
>>       /* TODO: add the devices once drivers exist */
> 
> 
> Is this still applicable?

Yes, there are other devices on the bus (the Maxim max77759 pmic, charger
and TPCI, the Maxim max20339 OVP and the NXP PCA9468).

>> +
>> +     fuel-gauge@36 {
>> +             compatible = "maxim,max77759-fg";
>> +             reg = <0x36>;
>> +             reg-names = "m5";
> 
> 
> No interrupts?

There are interrupts in the stock devicetree but they didn't compile out
of the box when adding them to the node without any other modification and
I didn't try further given the device worked without them. I can try to
get them to work for v2.

>> +     };
>> +
> 
> 
> Do not add stray blank lines.

Will remove in v2.

Best regards,
Thomas Antoine

