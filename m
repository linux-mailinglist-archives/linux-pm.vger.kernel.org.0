Return-Path: <linux-pm+bounces-29591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE493AE9DF2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98D95A2D02
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602152E1C5D;
	Thu, 26 Jun 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="j7K4A/jM"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022118.outbound.protection.outlook.com [52.101.71.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C352E06F8;
	Thu, 26 Jun 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942709; cv=fail; b=eJYMwi6aWIEL4YUaCBtwRwg6+Q88MxduODjV2pqwPkbEfCsk+ns3hODT4bdsFi+3QEmxpHWmrVKSNV/j4HEumkZTni5lsB6989Dww0mIau5Tvp0CzZWjH/rdbm4ian4BLpnMouo5rvlAKtuhKRL+8fHcMT9XqdI83qKBQrg55hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942709; c=relaxed/simple;
	bh=ZZl0VnQGBlIpCSQ8MzPRcZb3x8wlvddYZmpKOyrIn9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sMnbyEftjN9xFFZfuIHpGzdIytRpZRbeiua57smO8Y+T+hiJ27QuNB5XAYRfbYKLnMKBzU1KbN1FQzgqmERT8W/npHowJXWhIrcgwV0nDz3CKzwYZKvTbzrvzM/n78dpnpSMCs30NUYtC8vek1d6cUGjYyCb7tcnL3N+H1a/OzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=j7K4A/jM; arc=fail smtp.client-ip=52.101.71.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCe/9WY/DsVUweuttvskY0sDKnDqPZjj+Ankn990manpv1BsTrx6m8Jdk33xYx4BU4qg1eV91Xx0EBW6fvwH63wIS02nNS6OFAToI2PPYXPa+z4iin73N+TzPVF9/C6ZMg3KtU0BErDFHsB+ZnQThydR68DMS0ctrMeMeZFkzAZqOSCp8LxAO/pTMJw5DyjW5RcuRJksQJ9FLiKHcpr3DyzUWszyokXKI0jFLN6pVvs6Ga82Ya75r5aySpigBHkJRZG1sNs0BX9IWbetzLXXN3B9EHxwhqxVpUgINFXunOa+TKWeR4krzU9D9273tLI+OUZ23AZGbg2TUSf/zkTQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBgfTZipCQlDQwuSPxUPi4TPHf23nA4QBxGdC19BXAk=;
 b=TO/67VK015R1b5ou/af5cQZpgHDuQFmIHxpTMUPpPOE2Mim7rPrMsfBtIifj5r4Rju0I0GJTpBOZw62OhhH+71qSYkWuIWaW/0+3HrFFLTw4820XRyws4lTIMbnKA8+UruDjugGGQvlxjbL/K8XdUEl08fRQJHwmpDkIZN06S+L6S3anhYL94EYy5JN8nlCqC/EVz0Uhfijil1+uAxDf3P1o2B3e6VOS6LwIaZGgoevkXkwGhZ2Cu0dKjTg+ZlhxWxy1+8AiTPivF7BtEtn06UmV3xAJ2uBv6y86T9mNfR8e3g+grOIXrWLI0/gLxQZ6vqSsv0GY76xynxqzBKBTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBgfTZipCQlDQwuSPxUPi4TPHf23nA4QBxGdC19BXAk=;
 b=j7K4A/jMV+M1j29GQ1pXjjayLaHsPHRzBceL0w/uF75qHsfxMrZ0Vxzo/IqzZO6cBlYKFq0JxN+5hdg6KmsBDDasZQY3OKs5pBL86jEdYT+tZ9LIVkxXc/BNV1jlAxWIwa8tgZnpk1DGTG2RBEmqxSmo5A8MRJeIHEzr7Ow57copQK2CSYKBqKM06kbZlsP61ZtZb1yZWIpJ/2EqoKuIVQx8m+je87e32UjwK7KfWOnBTBY/hy5h930QJ+C5B2WARWwcJ3tid/6eTZjO7zOxL/MviCTiEHs4IFXueI8bmLQc2ydkmJGVUa3oKo5/GxsQr0LdjtmxU3fz6NEOfBPZxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 26 Jun
 2025 12:58:23 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%4]) with mapi id 15.20.8835.027; Thu, 26 Jun 2025
 12:58:22 +0000
Message-ID: <db13cc70-0bf4-4c4e-8002-b1aeffd3dfbb@uclouvain.be>
Date: Thu, 26 Jun 2025 14:59:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-5-b49904e35a34@uclouvain.be>
 <CADrjBPr4QNQPBddcFBe8V4u7G9YW0vs=8jyxEuQ1gVDt1zcfiA@mail.gmail.com>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <CADrjBPr4QNQPBddcFBe8V4u7G9YW0vs=8jyxEuQ1gVDt1zcfiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::14) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbcfe8c-7147-454a-aedb-08ddb4b12196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um1xeU52eUFxZzkxTVhCbWMvekZJV091R01CMjVLWlNacDJoWGduNnN4SGEw?=
 =?utf-8?B?ODdnRXlkRXN5TXJVeEl4TG1mTW1tc3daT2RpVkk0QndDd1NMMDVVVW9QYjN0?=
 =?utf-8?B?S0QzMGJ4cXRKNTI5UWNsSUlrRThmK3F1VDVDTHBLMWNOa2FyR0pYQTJQY2tU?=
 =?utf-8?B?dkZERmxzbWNKU015Wmw0amF1Z2NUTmVjWGZ0dkpmb3Q0Vk5RKy9rL0luZXR5?=
 =?utf-8?B?RXRFSlcwcWdHOE5UQW1JOWhxV2tkZC8yb2Nkcy9iRlIzR21FTmY1dGw4bUJt?=
 =?utf-8?B?SFpzMEhXaTVVQ3U5TkZKMHFLWFZvL3dnMDhrZEk4Zk1uR2JkVXpmbjcyTCts?=
 =?utf-8?B?dnNrTzZVaExoNVNMWUxyQ3BzT0ZjZFlwK05LQVQzK0VocExHenl4WlZEMno1?=
 =?utf-8?B?TGgwQmUraGNJSG1BK2J4bVU5K1RqK0dUZjc2UTVYRTMyTDdsbndDV0ptRzBY?=
 =?utf-8?B?SVFzNGR3aHB0elB1TU94K3FpRnRDd0lGT0kwdnM2VnJEekJEQmtkZS9EcHZ4?=
 =?utf-8?B?Nk4vTzR3THBiNFhwbmE4ekd1NW5qRWFzbk1wdGdwZG5ZbHVHNTBqK3RIVGtS?=
 =?utf-8?B?cWt6alhicEdvM2JCcjR2ZWN4SE5vazFiN1NXTUpLMFc3Y1k5SlVJemlsbmNx?=
 =?utf-8?B?TUJXSUJOMm5HelVuZjdaT1RNSHErcTVhTThWTWVRUk52NDBjakJ6MlZtdGND?=
 =?utf-8?B?Y3lBRW93TGsweGpNNU5mZnFEazZhZUM2VXQrWHgxbGJRMlZvc29uU0hRSGl5?=
 =?utf-8?B?WTlGVFZmMkluKzc1RWs1eXU4QSt6WjhUQnIwRGpqczMwRjFYOWhSRUFQcE53?=
 =?utf-8?B?ZlRRVU5hdUhLeS9IcHVoT3F1dW9ualk5aVRVYWZBZG0wWUw3Ulg4V1RxKzVj?=
 =?utf-8?B?dXd4dERNeFp6bFhTaG0xNnBSZHV0LzBLc2x4TTZvTTFSbDlSTG94TWV6em1v?=
 =?utf-8?B?UjQwVE1mSTUxQlF2aktQV2hZcSt1U2lBS2F3WmZNcEpFQmcvM1VWeTY2cG4x?=
 =?utf-8?B?WkZ5bm4wcVBqSVIwdmlQaDFrWnhyK3c2ZlJjS3dJaDB6anM4azZ0Q3BhSkhI?=
 =?utf-8?B?L2UyaFY3dW1QTkVEZ0FveEhWRnZHZ3VzSVNHWVBCZ3lDbmtiMHFyZHczVUo4?=
 =?utf-8?B?KzJIUlp4R1p1c2RHYnNiVDZkK3FTcmNJM085OVhDTTJqQm9CdWdIRTlzL0hs?=
 =?utf-8?B?d1lyeVRJNFlqbUFaOFVnYmNwQTZKckZFOVp6WGNzN1lJNUlCNmkzSlRMUG1O?=
 =?utf-8?B?WU1DRXRKYW40RHN5Q0JneVlpSmNUNE1qMWh3eEU5U050ZGdSb0N3bFFaMzNl?=
 =?utf-8?B?TGpEeVluU0FieFcwRmYrcFk4cy9JemZhMisrMFZQaFlDMS9BZkcwQ2w1M05Y?=
 =?utf-8?B?UmgxYjVkQjdGZzlYcXQxanU3SXo0QjZVTkJpbzBOOWNubHZmcUFYVVZUcW1V?=
 =?utf-8?B?MStxNlFwZVd1QnYxS1JtL3drSjkzQnR6blNNc3VleENGMWtWWDNObXR4a1A0?=
 =?utf-8?B?QmpBMS9WM2d0VnBKS2ErSDRQMHcyNWhvbm05K3R4K2hxS09FMDJZVzBNTm4x?=
 =?utf-8?B?QU1CaHpuLzBXa0N5RTRRV1p5LzN1TU1zMHFha2FDNWRaYkg4QWhMbE1haWxW?=
 =?utf-8?B?eEdnNzhsTHQwTzJNc2ppQ280ZUNYM05tNkpOQ3lMUjVqMS90aU9lM3BlMU9C?=
 =?utf-8?B?cnhEdTllWTAzamt0VDBLajVYNXczN2NidXFlTlU2TDhKYk9JU014ZDZHVnhX?=
 =?utf-8?B?WWp0TlZ6cmEzU1FFWlczMlNDSTBVekpaY2tSZjBWNGNLV3VUMDBBUEgzN1da?=
 =?utf-8?B?L2tXd1N1TmQ5WEZMd2JVc2k1NE5BZ2UxWXgrRzBrSWdxc0JiQVlBMDRvMGRP?=
 =?utf-8?B?T2RiOG53Q2hPSW0yYmRQUnpzZFVHWCtKUEZoTjFHayt2a0RHVGZYencxb1Jj?=
 =?utf-8?Q?isWlwUUCVA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THEyeWY1OERzdVZVMjNobWNQQ2kxUG9hYWVMekJGekFBUC9nb09ZNVpQWG05?=
 =?utf-8?B?YmErSkdXdVVNTHFxVjRKc0FxQ0Q2UVdjQ08zeW5tdU0rbk1hdHEvTUVyeThE?=
 =?utf-8?B?NXV6bXZBUjRQZGtwWmRxbEJaVW5xWVFoMXR5VGdmcFN6b2kvaHR5TmVPa0V3?=
 =?utf-8?B?UXZkN0ZUOUlTRWk3RGFhV0VaZFRVQjdqb2lIMklmTGRCODlzdGhYYTFKOW1m?=
 =?utf-8?B?ZythMDNDbTlFUUJ1a3hoUERvZ1RFVldlcGJ6RlZ4eDN4V01GbkxEMHg2MjRk?=
 =?utf-8?B?VjdzYjJ0Tmd1ZTczT0dsOGpTRVJqR2hyS29yVGJaTmhITHg4MXZqZVJTM3NW?=
 =?utf-8?B?K3Bhd3R3cFhaU0R3TG9aVFkvRldsaWhxTWNsSTdYSFZteW1kaDRudWNYZ2x4?=
 =?utf-8?B?RUFEdUxza1ptSjIyUS91WGtuTVg2dDRlWVUrNUVhSlQ3SmpGVDcwaUpxSmJV?=
 =?utf-8?B?d3JrNDFMYmtOeHRYdzBmK1V6Vm51ZFlVckl0QlJtanZvRVB1OVBaZkc3Rmly?=
 =?utf-8?B?R28za1Zrc2lWM0pPMkFoRWVBK1ZxaUlYTmVlYmUxUm5BWVExNWFQcmNmK0dr?=
 =?utf-8?B?bmxqWnNuUnpzeEttS0U2Ujhiczloa0VnVkx0bVlHVGY5SHUwTWpaWVB0a3JG?=
 =?utf-8?B?WXdocFVVWUNONUw1blVGQ2lJZ1N5aUN3NWtCSDE0QXRTT3NaUERKWmdZaXRa?=
 =?utf-8?B?S2hEdU00dUNMT0t6ZjZFUEY1cUdRcFFvR1hZaTBuYmRHVlp0MzNNbE0zSU9R?=
 =?utf-8?B?di9acEE5ZGZ1VFFBdGE5RG1xRkRJNGFiZlBBSHB5bmdOdXJ1aVJCU3d6bU5x?=
 =?utf-8?B?dldWR004SW5QRTFNVks3N3ZsT24vL1k4Ykczd0JOSU1lNXhRNStaUG5wZGlO?=
 =?utf-8?B?bHdEZEE3dlRwQlN4Y3czazkrMW84VnBvRjQrSS94U2hUNFpwVU95dzhOeVR4?=
 =?utf-8?B?aDhFM20yVU51NDN6Sm41akpWYStOQVJKS3ZxUXQ2dURZMi9DNGJyZlNCVDEv?=
 =?utf-8?B?aE9GRGl4SWZQOHV4a0kvamRvazRURGlRMWhEbkRRLzRqTVJBU3RVUzZqSmZq?=
 =?utf-8?B?ZHpuV1BJZmd1TFI0bm5WU1dxY0dleENEWkcxL1M3WjZPWGVRcmIyeU10azBJ?=
 =?utf-8?B?ekFqR2JRdDllbjRJMGkxRDF3NjYwN2dHb3Evb09LT3p4ODlHbzc0eWVTUEZn?=
 =?utf-8?B?WWQxTTBkSmhnM3dpZFdNcjVaYlJxUDBnVkxDejkxRTlweHJ0NEZBS0N2OHNq?=
 =?utf-8?B?eEZVRGorbVF3Y29xTzV6UG5vRTl1NHZQdWFvN1IwTDlnQTY3cGdhNE8vUndl?=
 =?utf-8?B?WWVUSG1acEl3bHkwbi9LVlNNb0E4TUlLVWNYVS9BQS9NMGVJSXlxR2hCRkdP?=
 =?utf-8?B?Vk42ZlVCVmVQbkhPZkFsZkwwS0R4bjRHd0YrU3IxMkdBQ2h0U3BXSzg5b3dE?=
 =?utf-8?B?a0J6SnB0NGVrOXFqa3J3d3Q2V2VBdnNVS2hJVGNEcG5nd3krbWhpZTZhNE5B?=
 =?utf-8?B?WjhwUWpSclJqUE0wbFVKb0tTaEdjSFJnS0xONWRYRkpta1VjZUJ1V0xnamFq?=
 =?utf-8?B?Wjh6S3BFWUZ5MmJoMHZQdHFCWDZENkdFNUxRMFVGcHYwNlc3c0lvcGVEK0hy?=
 =?utf-8?B?Um9lejZDYnNiT012VmdDbDhuaEtvbDZTSHBPb1hTRnNqRFpvTXZ0QXFCejEx?=
 =?utf-8?B?Q25iUVVkSkZ3SjM1YkFlNkJkSk9IMHcxbkRyczgwWjhvZ3BQZkJsc2E1VkdO?=
 =?utf-8?B?RXBNL09rVllyNklSS01Ec3ZJd1VHOCtCajRVcU1TalIzdHgwU21CZitEL05y?=
 =?utf-8?B?NW5LMHYwL0dnL3l3L0pwY08wMUo4MVR4K3ZyT1piS3JJR1FXbEJHWkR5RE95?=
 =?utf-8?B?Zjc1bmx4ajFXaVFEQjR1bnB1ZnV0NTNSRDBJYld1WHA3N2lrTkxqT2lmcVFi?=
 =?utf-8?B?NUlyOGZZdTlXS1ZIYlVkRjY1K1RlcHg0R3ZINXB4ZDNHQVluMTZLOTB4Zzhi?=
 =?utf-8?B?MGNKRGVaeU4yZk1YNTNtYkZrQWxnTDlTbVV3Q1owL1Mrb1A5SDlzdWdIMFR3?=
 =?utf-8?B?S0x2eFVZa0kxNVNGTkJnMDdEYTRzV2NxcTB0cnM5cVR3U0dNR3czaVB5T3Vz?=
 =?utf-8?B?OEM0N1BqNGxpZEsrU0I4TC9JYzFJQnF3eDlhc3luc0p1Rms4THdIUEtKNjBY?=
 =?utf-8?B?QWtmeHppMEJJSUJTV2NnNE1kYW5hNkJIWktGSHpxSWNyUXNQWTdzazJHNzly?=
 =?utf-8?B?NkhjMkdobVdKNGZmNFFwVlRYWFFnPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbcfe8c-7147-454a-aedb-08ddb4b12196
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:58:22.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auQZAjfuU51VzgxOCJNG99MK21ItyI0l8KjSKfWMyd0V43PCh8gXjaMvA0ZLTSJqoWuOimekvsNTg6bjG/nAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

Hi,

On 6/5/25 3:00 PM, Peter Griffin wrote:
> Hi Thomas,
> 
> Thanks for your patch and work to enable fuel gauge on Pixel 6!
> 
> On Fri, 23 May 2025 at 13:52, Thomas Antoine via B4 Relay
> <devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>>
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> Add the node for the Maxim MAX77759 fuel gauge as a slave of the i2c.
>>
>> The TODO is still applicable given there are other slaves on the
>> bus (e.g. PCA9468, other MAX77759 functions and the MAX20339 OVP).
>>
>> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
>> ---
>>  arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
>> index b25230495c64dce60916b7cd5dcb9a7cce5d0e4e..84fc10c3562958ab1621f24644709e85a9433b9b 100644
>> --- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
>> @@ -10,6 +10,7 @@
>>
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/usb/pd.h>
>>  #include "gs101-pinctrl.h"
>>  #include "gs101.dtsi"
>> @@ -188,6 +189,15 @@ usbc0_role_sw: endpoint {
>>                         };
>>                 };
>>         };
>> +
>> +       fuel-gauge@36 {
>> +               compatible = "maxim,max77759-fg";
>> +               reg = <0x36>;
>> +               reg-names = "m5";
>> +               interrupt-parent = <&gpa9>;
>> +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +               shunt-resistor-micro-ohms = <5000>;
>> +       };
>>  };
>>
> 
> If gpa-9-3 is being used for the interrupt I think we should also add
> the pinctrl configuration for it. Taking a look at downstream the pin
> is defined as
> 
> &pinctrl_0 {
> /* [MAX77759: FG_INTB] > FG_INT_L > [XEINT_23 : SC59845XWE] */
>         if_pmic_fg_irq: if-pmic-fg-irq {
>                 samsung,pins = "gpa9-3"; /* XEINT_23 */
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
>         };
> };
> 
> and then the fuel-gauge node declares
> 
> /* FG_INT_L -> XEINT_23 */
> pinctrl-names = "default";
> pinctrl-0 = <&if_pmic_fg_irq>;
> 
> regards,
> 
> Peter


I will add this to the next version, thanks for the
catch.

Best regards,
Thomas

