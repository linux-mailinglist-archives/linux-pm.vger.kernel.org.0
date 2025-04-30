Return-Path: <linux-pm+bounces-26461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57722AA4DEF
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 15:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6891BA3FEC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960725DAEF;
	Wed, 30 Apr 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="jZsjfbsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D772FC0B;
	Wed, 30 Apr 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021112; cv=fail; b=ZgBFCE1F4Uwg93SQU67HCmuDyEYEblNlgC/7nJoJ5MwUxiVcMRrRFN1hVLNFhzZ76kYxHq8NvFueZNxdfbfrhS+OcVxNpG5oWWsIi2DPo1879/EvGFFG2B6LuCUSnCdh6RVcBR+jX6B3vZRpplTyVtwtkv/tYY7yOUVvrOflX7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021112; c=relaxed/simple;
	bh=2a4zwiGRN6rD5vetd6q3tRJ23nKgZpWHMQe0PaJCygM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AQEdS5YgrgWbaKz8uNZFFwY3HqppY2f/6hbQ0KLURzYAvp7zXZsbVEcWuHuMr1yjNTQ/i2SJcYEdhjw21WCRAs2sFktswxYK8EBOVsPMtxh8euzVy1RGPYTS6yQh9lD/HnwXfQcb3kP1MKEgiF91xuq68JvEJxu3XS7WNhWrlJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=jZsjfbsO; arc=fail smtp.client-ip=40.107.22.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6JzP5nFqfMAfoVPijJQMoH8cjXWkHbCRpsSHeUaE/0z7LT0ROcYW4/7yatlBHliFB89FaEnTM6aTkLfsKHADZO/kp5JvkRgfg9O31O5BVlrAL3eRvWy3WeNhPx32AOwgUoXlLnlrq3i4KbuwkrvbU2M8s73DU4M8v+TZ/JLQbKfijOL2koc/azbyy1LU9he+cNLEAZfJoUIvlCvnbjDzAKtPCpd/bIwDYkn9z7FeYR71LfSVt50u/XONwthoqLOz9O6UDtrl8Gt7u7lxPOKZzUBMpssxtceq/vak2WNiuUL0W7KgQmSht6tLsHuMmuzx2sW0ps/H+4wMQ0bnkeScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeEgz8JsrWUzK4yDXCS2y2ahvaSoQVjdU0EIw060QsM=;
 b=r8XzxuoPlbbceXcflQNkCx6IBXodVFkvpn16vL+MdmuIcNe5SLZNiLQjytogFSqGeGXNmwbSTt20h/HeHgDtTkWr85jRwDoGoG/59zTcXgwciws/HUa342kDgwl2xoztyEbiaRPkg6H0kE79bMYXIEbPEWJhcCF6540rJkutmj7m8eghkim3p6/avk4gsCXia0X4MvSFhc3xNSS5/4+r67XJXLN1lhNdxa95IE36Yle9YSSbFeO2NG+9E2N6R2Md1x0QrsFpzS4GFAL/eOqhce4U9LF5542xVLwSxRk8tNe1Pkli+KsnBqIg4hyak8o0X6hF9XFiyaWh1MyziuD04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeEgz8JsrWUzK4yDXCS2y2ahvaSoQVjdU0EIw060QsM=;
 b=jZsjfbsOHu+ei/5GL71qbHiKdhl/7E/yfpxIkCNOdZoGvzvt2RgjT8qcJVSfzItevjOC/NPLivW+GCU0hZkVwNgdxIIqPROdTsC4b5CfbI2Zt/q32svzOzeBLB/QPm+0I/nKnOtsI65DuZTu8MChFaKf6VZSmlMkyz3EOtdLpbTXvoUXSNsCjTKcSNH0R7yoE+wBBNgnyT3FAoPTvo8slLaFdCd8xaVQLGoOWZst5lRa47scti5Y0o4O0ol4zwIgteMneVsskqqfIk5HGLDV7TD82t4F43O+qoiVlVJVOG3hs0V/eTdqUvdzBNndyFpRryKO5rdVPtlKpZZG+55X/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AS8PR03MB7601.eurprd03.prod.outlook.com (2603:10a6:20b:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:51:48 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 13:51:48 +0000
Message-ID: <a781a7bc-5dcb-4d28-9997-87404fa8c675@uclouvain.be>
Date: Wed, 30 Apr 2025 15:51:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] dt-bindings: power: supply: add max77759-fg flavor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-3-50cd8caf9017@uclouvain.be>
 <20250422-tireless-swine-of-fascination-6eba8b@kuoka>
 <57bb1dfd-02dd-4aa4-a560-264875ded33c@uclouvain.be>
 <8dce8a71-cd99-43eb-8003-b7c4f9a4cdfe@kernel.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <8dce8a71-cd99-43eb-8003-b7c4f9a4cdfe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AS8PR03MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc70ed8-ebfb-4428-ef23-08dd87ee26c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXQyVmg5M3IxTFgwakM1VXBCbTk5NEJ4TUxBN0xhNG9kNUJOSW1IUG5RMmFR?=
 =?utf-8?B?UEFRSjhodk5PaXlka1FPSGhiMlBOcUdmajhXMGlwelYyYkhmanc0MW5DTGNt?=
 =?utf-8?B?cGt1VHdDYjI0T1hsTWMwSWc0ekdJcURUY0hDNHdCL1FWYTlBK1lrRUxCZHFG?=
 =?utf-8?B?LzErTDFXNVh6aU5OM3lhelo0YVJya250M2IyZ3B1L3pxSi9DNmtSMmM4SlpQ?=
 =?utf-8?B?RlZucEs0WURYbFVvVURIS1hXcFZYam1DY0MxcHlyRTd5blliWnpJSzhDdlEr?=
 =?utf-8?B?NTQyZWdXYmlOckJrVE1lVEpkYjBTNml0SG16SVgyRG50WXlXVUFhV2c4KzUw?=
 =?utf-8?B?ZWNSUWlzOVJXeW9NOTQ3MVdQVXRWMGVkNWFsR2xRcUxKdXNSSUV3QkZiUERl?=
 =?utf-8?B?NEpGOCtLb3NWRHZwMW5EZ0JjdnU5QVZaUEJRSmpDaXJKQWx5ZHpsWjNqMjJm?=
 =?utf-8?B?V2ZmVG4vVHltZG4rYXJicFNjQXlkbUVEQmYyY0VVZ2RQYWE3UVdWNWxoK0g0?=
 =?utf-8?B?bW44Y0lIQ1pvQmcvV2ZqZ2lsUmRTSnNjcXVGdEtKb041djkwTTFMMFJ0VFVB?=
 =?utf-8?B?OHFCTktxa3pBdEpQU1RudXVpSWwzZHZhdFRhb2dPTEl4Um5tRW5HVXJqa0hG?=
 =?utf-8?B?SkFLcEFsYUl6Tkt2SWQxRkpLSW5ldXJxa0RYaUhRSUt4Q1RkRUJTcnJ5ZTNv?=
 =?utf-8?B?dkYxV2dEM1c5bDNoZVRmQjVhcUp3dzJCTHFBa3IzbENyN1Q3WERXL1NpQUNw?=
 =?utf-8?B?SkxDSUlaQ2ZzeWExMnFhQ0dleExDU3dGRE1zcDUwdzhtRXpnZUhlRFVxUm5J?=
 =?utf-8?B?RzhSQnNlSFpYU3NCU1ZKRXdkMGJzeDh3U2xnZzlwbUJDb080R0dWRXI3SWQx?=
 =?utf-8?B?cE5FVmo3UWljU1l1MUY1WWZ6eTBZN0VRVk9zNkY5K0tOQ2doUkNZU3Z2VWt2?=
 =?utf-8?B?OUM5Tnd4aWNES2FHVkVLTlFKa0E5c0M3a3B1QWhlaStGeS9YT2ZETXJqR2JR?=
 =?utf-8?B?RXRUUllZYjdBNmF5OVRpdWUwd3BGWjlmQXNNVDVMZmhYSFNmSHREN2QrY0R3?=
 =?utf-8?B?WjJONVJxa09rL1lkWk9PUjA0QUdFK2Y1dkNlWEwwcmthZFE4WGF6U0s0dlZN?=
 =?utf-8?B?a3BnMDFjT3llb3p4bi9jTnNBL0hkZG9IQWlBTmV5K3ZaYmFHcjJ2Uy9aaTN0?=
 =?utf-8?B?NW4zVXhqeWt2WTRJaktTWDZFTmw4TVA3SHV3M0x2SnMzRGgzUGEyd1RhdzdV?=
 =?utf-8?B?V1N6MmhyREdaMVUrb3VlRytaVHZNVmdDT3lqMVA3UkFuc1g1TEVWcUxKcFdv?=
 =?utf-8?B?MFpadmxEZzd0VUh2STQvdlRPYkhBdFJrYVMxSkU4UVJSMXRSeGs4NGw5bUNN?=
 =?utf-8?B?d29HQVBsZTZPd0orellZSXVIV3M0VHBoSlZLaDhxR1F0UGV1VThySmtJckxz?=
 =?utf-8?B?Z2ovSHYrVkVDZHdYTXByaVZGdVFKK3dMcTZvRFRGMFFVeTIzd0UzVmYwMGZi?=
 =?utf-8?B?Q3JKL1VCL2NjZm9BcmExQmc4TU9FZ3hZR3Yxbm1mVXZFSnBZZW9BWVdyOE43?=
 =?utf-8?B?bG5lQ0E1ZU5oRW43WVFHYnRJQ0hsdmZWWmlNQWpDaUJCV3NRanlBMVg5NWZP?=
 =?utf-8?B?QXVZdmJtdmZUV3pJdzlROEFIUll3VzJzSUJLNWhLcTRFeDFjL3NkcjZOYy9P?=
 =?utf-8?B?QnNYeE1waWxGRDNUa3hCUEJkdVFRVDhEMVJyRzAxdHJwOERUbnV5N0E4c3Vo?=
 =?utf-8?B?bTVZaXl4MThqODFwcG1GVDJMVkorL0V4R2hBN1lNYnpvL1lOeEQ2SUlBeGpK?=
 =?utf-8?B?VE1vTDBxQUpuV0FWcEs5KzBmTm1HWU1MVDIvWDZzeHBLNGphY2gvbnhBZnN5?=
 =?utf-8?B?d29BT2NyaDcvU1AwWE41My9jRDgyTWJwdGtLZ3d5bWpMZlVsSENkWlB2YlRY?=
 =?utf-8?Q?37MUncbFxVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmViczB1VUxLZG1UNUZUT2w5QzBUbGFPUGJkNWZrV1p6MmpPMDJJZTVtaUdy?=
 =?utf-8?B?Um82U0RlZWVJSHRWSEZJTWdRNVdoVW1pMnFoaUpGUlNPZEdTQldnTUd6WWYw?=
 =?utf-8?B?UHZlQ0dDTmtxTmx0dHpCL3pzV1EzVGFXQTF6UlJtQnBhTzVBajc5b0F0T0Z2?=
 =?utf-8?B?dnhpVUFsRXlxd1BIVTJsZnUwdGVXeGkza2tGcGJmL093b0syUWg5alZBMlRs?=
 =?utf-8?B?ZmxZdGZ1WGV1OTUrRzdMTmZBQVV3dWJKYSszTldFMTkvYjhVaHpHSnV0aS9C?=
 =?utf-8?B?RXNINHJ2OEFxdTBvR1NLVmNXbnBhRWx6ODUvZkE1VWI2Y1p5ZnZPRGl5MmZq?=
 =?utf-8?B?N0pUVWlyck5Pb1BCc1ovUm9veW1vYmdzUFdzb1dzSXRWMStDRHR6aTNqcHhE?=
 =?utf-8?B?NDZVU3NEcCtBY1ozZngzcEFVOE5SU202b2RiVnhCQjUwNFF2K3JIZ0ZOSkk2?=
 =?utf-8?B?LzlJMHBqMnJMSHF5cWNpT21udUNFZWN6VEMvUzNvakl5ZGRSaVN3Mm1ZbzR2?=
 =?utf-8?B?QmxEK1NpSUJUQWVIWERYNFJ1alhSQ09EN2RDcVROMTZmUmdUaHNEQ1pESnp2?=
 =?utf-8?B?TlFaVTBBMStidHh3VUNPaktaZ21pVE5GMTlhcmJ2Z2orREtkTTF6Njhub2E5?=
 =?utf-8?B?aHM4ejYzNkxxTFFKNzN5dkRKYXdQODg4NkJaV3RwUVppL2gyQ1VNelU0VWk3?=
 =?utf-8?B?dGJUSlpqK0JrV1NRNHEvUEFjWGpnaFVFdVlRSUZOb21XVUVDL2ZxcEs3SkxC?=
 =?utf-8?B?akxiWXBwN09PalVxaHk3YktkOFcxbmFhL2FvNm90SHV4cEw1L0JJeUQ3NGZV?=
 =?utf-8?B?NjJvS1ltbFZlSjV2bkpmUlMrbWZBTnlPOUpxUmJidUw5M2R6T3U4RENyNUdQ?=
 =?utf-8?B?Vm5ac2JIaHJHZVlHWFdkeXBaVUFQc3FadDhEbSs0SHdQMFhORXpUYkJuQ21o?=
 =?utf-8?B?Uy9FWm5YWDhBbENzOVVGUlNJSnR3eEtXV0NkdVA4MHNIZ0RudVRjV3FSN2tr?=
 =?utf-8?B?NE5WL2lWbFRCVnVkSEt1Z1ZoVHMxQTl5RHBQZDVHT0ZZWk5lZmJreGpIaVVS?=
 =?utf-8?B?dlJ5K1FxZTZzTXNBcjFWZFBSYlRWMVdrTFR2N3JnVUwrUmxuMlpiNTh5SnNS?=
 =?utf-8?B?WTdvUTFBZW8ySnNyRUdVV29TTmllOEFwSlFtbEJVVkF3ZnJlQ0dNSnJBVTFq?=
 =?utf-8?B?clk2dFBhQUlnWEViYjB3T0liRjdGcFJkd043eGZ2Q3YzV0MyTkcyM3Nna295?=
 =?utf-8?B?MnZkcFZOcFN2cklxZDdWTW9IUDVVQ3doTlJMUnErRVJFeWtBZTJ2Uk9IM2tL?=
 =?utf-8?B?U0MvdWlybUlORXE0OHpyMWFzOFUzV1JVWEpRd2NYUWxBWGxLd01RWTc3NkFK?=
 =?utf-8?B?UEhRWk5RYjN2U25GYitXeHRONHUrTzlFM1Z6eU5BdUF1UGZuN3J1OUJHWjVH?=
 =?utf-8?B?cm5RYnc0SlRZendJblpWVlAxWmRKaTVjSXhwY3AvV2hKbnF4bWJTU2tZY3o1?=
 =?utf-8?B?MnhIaWVXWUtJdnFlSE5Oc3RnQTBsN05xdUdBbXZnajdwanhoZlRNakdUL25P?=
 =?utf-8?B?aTNsaXhXQVJyYzFicjJWU3RXNnowS0YwVHNqRk40Q3lIc09xWEpzSEdQRVhN?=
 =?utf-8?B?OHIzODhHZ3NSUStGWXgzRmJMb09yVFMza1lLN0c3dW9Jb2Jvek9DZEc3VDJS?=
 =?utf-8?B?WXA3ZXVVdjNXc0ZoZGxBbWp2RDJTSThwd0ZrME50enBsY3VPVStwUnk1U2pw?=
 =?utf-8?B?MjNYeXpsa0NDZlpBRGdBVTVwU25Ib1l4Zi9tcW5KN2ZZUmlMRHYrRFV5UFg1?=
 =?utf-8?B?Q09DTWxDbUdGTXNGdm1MbGcvTE5wWGVzRmt5OUdrbG5nQkhsSUlGWTNSUzc2?=
 =?utf-8?B?VFpkMUplMGd5ZW1zWkxlMlR0Wk5QbkUxenlXeXErV2tiU3FtTEUzWitBWUMv?=
 =?utf-8?B?eWZYMWJzSWdTbWREeEJaQWlsc2tEaXI1YktnajRQOW1KZ3pZS1NzZ3Q0M2RC?=
 =?utf-8?B?Z2s4RFRqU2ZUaXZDMjBPNVZQLzJmMk5oQ0V1bjJQYmNBN1k2YTdqeEx4TmtO?=
 =?utf-8?B?T3BVK25IT0JEaGtmU0czNkplQWVzTWxMYldyN2RGcjlhRXRyUlByMkp3SDlJ?=
 =?utf-8?B?RS9ZelJkUVp5WFk4MWFGeWVoTmpDRERudE5nbEcweUoxM3VSUHNDY0Yrbndw?=
 =?utf-8?Q?sf7rF6HJgPY0qJapJM6acgvCM6g6JnrbGfH8k1QxToUx?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc70ed8-ebfb-4428-ef23-08dd87ee26c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:51:48.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpbI1QCv4AUOpZ2/QUftT9G1sZ0A5A5OjarVFWdXiljtdk6I2+EGkE7W5mB2hltRFuL4Y8kMKW9xktkLgY9nhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7601

Hello,

On 4/23/25 15:45, Krzysztof Kozlowski wrote:
> On 23/04/2025 10:05, Thomas Antoine wrote:
>> On 4/22/25 12:05, Krzysztof Kozlowski wrote:
>>> On Mon, Apr 21, 2025 at 08:13:34PM GMT, Thomas Antoine wrote:
>>>> +allOf:
>>>> +  - $ref: power-supply.yaml#
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - maxim,max17201
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          minItems: 2
>>>> +          maxItems: 2
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - maxim,max77759-fg
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          items:
>>>> +            minItems: 1
>>> If there is going to be resend, drop minItems.
>>>
>> Will drop it in v4.
>>
> One more thing - your reg-names are now incorrectly constrained - where
> are their constraints?
> 
> You need to test your bindings and DTS before you post. If by any chance
> community robots found more issues (e.g. you sent something untested),
> you should address it.
> 
> 
> Best regards,
> Krzysztof

I did run the test but I obviously must have done it wrong. I will check it out
such that it does not happen again.

Best regards,
Thomas

