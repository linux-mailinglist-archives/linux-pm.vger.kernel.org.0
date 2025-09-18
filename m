Return-Path: <linux-pm+bounces-34958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA09B849B7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228EC4A668F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F02F5461;
	Thu, 18 Sep 2025 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="UULKuDDN"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023103.outbound.protection.outlook.com [52.101.72.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6301285043;
	Thu, 18 Sep 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198972; cv=fail; b=ETi8t9I7CEIjuitbb3J4mC+zG+bpX32EHvmqGWOfsfLCrqcX4wbCdPZ/Z+gPKacqR/RdnbaJ3tEE85iRdY1axbTapTyOQ17TH0dRgwADF6lpKw4zuZJK211niEf0iFU8XX4HSOECAmeZDCAF+jUIpXhHpTB+VZE5km73Ymk9F+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198972; c=relaxed/simple;
	bh=XRXlXwTh0atVMx9+yHDhHxWz2ARPVQzkCNNF0FXWE28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K1UEMJMEcWxtKsw4jhrZGweVIVpzypSbIaqJIg0uyRimSX2T8KWe3DXfYfyNRMqMJNr5cxp98dUGMgLTSZ8nHcXP3Kl8vNC/jzv09UNtJ7dq2Hd9o5/TtQOOU7PtKJRj3pm1XsLn4znH24u/9RsEfh3e1tUlcqCVszu4OQdAdg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=UULKuDDN; arc=fail smtp.client-ip=52.101.72.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah2NQqexgdIaeUeOUgk3+CnglzTISdun5zXYvURlYvjR2cRJiT1PZTuZBwc970jox1n8uXfQ4Ww726qlRzbUPsZsfPBbtbusVIzijhYWjEOqr4NYv3pJ3qpNFc3iPVwwaKhFFY9pznmGuyZmVbLeDxXbGeeS8CAza4C0lZIA2uWeX2h8zjvJqZUKRe3J7SgJ5w1fIlns6vDbmMolj3Yf8BO9YyyUS2UOqU0CsDWeHC0jubZyJAyDlKpvGBsJKaWSQ14hgFfMiZ3B8a2W0TXCDbd4v6nNEmFjCJuBPRU1lwF/t3x3rX+PbOvWXMTsZ8XDroYQKfAyJLi4slyllNhRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFMVRcGiIG7EznEyktP/liE8SaL08VaO/m7qTSCF1XQ=;
 b=HTUbcjTQp01cM+lH2F/JSs7WgNB4k/q610dXhMMw6b97J+X7OkysrR6yCNK9CPOXh2CV74mvOr2mjYuHMEmXZPyL5T1Z7tU2YMWSUh/dYrhf17sUBdAcuZuEk4GDwe+QctDbNVbxir+85bxRgQE0qjDvSeF+31sbjkdS/ihc2AZI6yh3LC65YdFPOjci3QiVZN6bMEOmw0GqrQRyPXvSosqC1idstYhh5d0EUKEqschW42fp8hCelN5vRK0dSvkQe/Gkbmpf897hExn/8UzgPAQ+YQ8xM+SFZcF4rw8NfVJcApCmgCgGxrFIaPE25Ey76Y7K0gAsMZ6bvUNII+dlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFMVRcGiIG7EznEyktP/liE8SaL08VaO/m7qTSCF1XQ=;
 b=UULKuDDN1HiSAvcM791E4wgXhjW6YrwqlCTp02EjvmizUaW4JZIFMQZn6GExH0Oz+j/6pnly7XVf2RQk4BH0yroNXwJI6KK2xD7rXtnDLh+DbF9pTN26H2OVU63gbz4Tj9RU8g9+1T3EOcHdYHvVuZL2bLhhfMO8yToAoZoRWtkOaeG7puzPU6QRZ0PwnD9HbNTCMIOIdEql3yPmaLha03msIU7iA2LwT/6B/LK73UI4XPTn+YTG82tHJrkMtwIIo1/p6oObdFIiR5eria4kMaaS4bjU1OIffzQeC8CXUiByWxR/6HUu4GcJvo7mVgmvSzJaOomO/1Zrj4RfjtqOIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DB5PR03MB9928.eurprd03.prod.outlook.com (2603:10a6:10:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 12:36:06 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::a45:7933:dd0a:8889]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::a45:7933:dd0a:8889%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:36:06 +0000
Message-ID: <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
Date: Thu, 18 Sep 2025 14:36:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
 <20250915-presoak-answering-2df6fca532ad@spud>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250915-presoak-answering-2df6fca532ad@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::8) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DB5PR03MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 178eeb73-9478-4294-f18e-08ddf6aff001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnN5bkFXcWRHaHJPRUFrUUpyT3ppa2QrT1NueFNsWXFLRUNyRE84UEdOZVZH?=
 =?utf-8?B?WDlxZklYUGh4c1RjTmFGdSswTkZrejhRV2czSE1CTTZaRFZWUkIxN2MyNEZ2?=
 =?utf-8?B?OFBIenFkNDRtWWhobTVJWWFmRDBGeW9TYzRheVFjS09Zc09IRjRybk00V0NL?=
 =?utf-8?B?NlRSV0xaeS81L0NUNTJEWStNV1ZyQTArRG5xSTBqUk9URXk2RW1ib1paMlJD?=
 =?utf-8?B?WHFTV1lVK3pQMHMwV2lPaGJQbXo1cC9PSjZoN2JqNUtQMVVlS1dhZkxYcUcr?=
 =?utf-8?B?bmVvY2oyRXVVUVUzU1kzNHIzdGJwc2hYM0pHaFhES0tiR2EvQ2h3bHdWV3oy?=
 =?utf-8?B?SUl5d3ZnSlVGZ3I4RUxiSmdPY1lIV0VFeHVRNXcwSi9UVG1HQWoxQkx5VU1L?=
 =?utf-8?B?ZTlRWVUwZmhsRGRab2ZuMXVJbHZpZXZTak5ydk96M0M1Y2poQUY1RkJ2amE1?=
 =?utf-8?B?eWsrMVNUajUxd1V2T3NNSUloUjdNM3o1U29vT3YrSHltUjQvNGdyaEY3cmE4?=
 =?utf-8?B?QTZ4eVc4em9NTmxMZHpucDV6UkVOSE1McXZJQU5GMVBKWElJbkU2MUsyd3h5?=
 =?utf-8?B?SU50ZE1aL045L1FDMVFjTU1RUnd5eGpBMWlWL25NSG1tZFp3SEtVUFRhNlFD?=
 =?utf-8?B?Z2ZRelVXRDhDZFhZd28zNzE4bFRLZ0NQRVJmS21YN2t3YzBHZDVQTjZQOWZi?=
 =?utf-8?B?U3IrdWRtMEErS1Z1UUVkMXFGbS9FUU1WS0dLWWlEZVMrMGxRWUgwdWNzc2w4?=
 =?utf-8?B?TGUyQkN1T3RuZmQ2a2EvMUJlZGpwY0tLcHRDUVZaaEhsMHFRNWhjdTZjbHhX?=
 =?utf-8?B?RitUbE5ub2RteHBxQVdvS0RTZ3MrY3RnSnJWeHFpS2lHYmF5QkN6VmtsYlRn?=
 =?utf-8?B?cVovd1VQcTBRbDdPWktkVll1WlFqR3JqOEJNN0xWVmx1RlMxWnBoRGJLU3dN?=
 =?utf-8?B?dG1GelV0OVhDMkVEY2lrRDZFSXhGQ0VaVGxIRXJzY3p6ZjVGeENYajBIdUZO?=
 =?utf-8?B?dmxPdERsRGVNOHZlZ2N1WUdLblVjT0VHK3cyOHNyU1RHTzN3NWR6d0tvVUIv?=
 =?utf-8?B?UE85NUlCSGRUWENlU0I5NUVCdVg3ZEtLbjNkTmJnemNsNzlYTk8xNXNaSHor?=
 =?utf-8?B?T2NsbVVSRnRVL0xhYXVTUER0T3Z4elNIMllBZG5RL0tQNlAzMFd5Yndrb2N2?=
 =?utf-8?B?QnpWTmg5RldoUjdFNUNSMy8yUVdlS0Uyb1VxNUdrVGxQWEZTNU5qNjcveFcv?=
 =?utf-8?B?S09tME5wSlM5MFY0bmxrUGpmc05ySmhieXp5aGZWTmVkSFBLZ3NoMW9OSEpt?=
 =?utf-8?B?b2J5eWl6ckJ2SjhvbmlIZy9sdWtUem13VjZmSzVGcTVQSmhDREpVTFhsUEI0?=
 =?utf-8?B?QU9wMHU5WCtOM0xYSGZIdjJSM2o5YWZydnBhYzcxZjhmbU4wZ3NPaUtqT2x5?=
 =?utf-8?B?Q3lqbys5ZkNmRmhmL0lqRkxjSlFVVDJqdDI0QXJnWlFBdkl2U2tmUlp4SS9N?=
 =?utf-8?B?TENGREZscmE5QVpYbXM3TlR4SXRaMGlYbXFrNTNoNGJXRlN4MnUrL29NK1Zv?=
 =?utf-8?B?bTZkK051b0ZFVTlHYTByc24wTXhpTGR6Y1ZnWEliUTk2dWJkUUsrSy9KbTdO?=
 =?utf-8?B?dnFkRkdUN0RuSTV1TzR5L2puWHNwdGpnOVhrZzVkd3dLb3ZaUW1hZWt0MW5J?=
 =?utf-8?B?M2FjOEQ4dVVLZHNCZzhVRVp4TWFKcFFyTmk3Z3JzeHNaRnY0R0dybWIwMEVQ?=
 =?utf-8?B?MUtONy9RM05aNk0vQVUyUkNhVTBlK2Z0emFGK0IzYVdMNEtBRWM4empzM2hR?=
 =?utf-8?Q?l/mFJl/eXVI+ambnllF5WR/1TjqRX9AwbtYOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3hKL2pLMUpzb091SGNiUjExbTNVV2ZOUXE3SG9lcTliN1JBcVJPY0E4WU5N?=
 =?utf-8?B?V2RXVWtaMW9XR0hTaTRZNjA0dE1oNzY2Myt5bExHNW9iN296c3pPSDZzcWFm?=
 =?utf-8?B?TUE0c3V2bDBVb21BRnZQcG1kSW5OWlRxVnpJL09XcTlRMVlrcW1hT3VJYk52?=
 =?utf-8?B?OHZaNmlRTVMxN1k0NExhRTFML0pObjB3bzBvbGxpYXkyb25SNFd3OHIwWUhN?=
 =?utf-8?B?L2RMWjNnZXg2eURXVnVlcXJrOFQ5eTc3bTJrU3dqNU82MUxKbVdBNnkzNDNr?=
 =?utf-8?B?TFRxUjlOUFVDcUx2TkVUQVRqeXQ0a2ZhblQvUWoxTklIQkR4dDh0WDZtUVFT?=
 =?utf-8?B?VS8wSFdjSDVrdEtVQ2J1aXFlblY4Qnd2c0lWeWJZdERQbTlRdkk0OFNad0Nm?=
 =?utf-8?B?VmJmSGdyOFV0NjJEN2FIWWhvTDVrOGNORnl1eGdZc25xQkJhaEltRy84c29v?=
 =?utf-8?B?UVBjQmhycFV2NFkvcFdqeE9aVnpZanUzTVRkUUwyeUxOQi84VUdwU0hITjVh?=
 =?utf-8?B?NnNzVXVZQmZXb0JpcG5iZXd5czVQZHBDb3AycGJsbkJHYzZlS25heTFrR2M1?=
 =?utf-8?B?RHZKYU16SUxnWnY3RVBvSUU2YlJXQ1NhMUlTcTFIRFdSa2drMU5SamxvemFO?=
 =?utf-8?B?Q2RDa2pDRDYvS0xtazE0U2ZUYmJ2dzlsK3dEMlZhUmsvZlBkdkE2N2VKUzhq?=
 =?utf-8?B?K0MvNmxHMUhBZm95S3dLRnZhak5wR3JBa0puQkV2S0wwQ2VwTndMQTNXams3?=
 =?utf-8?B?eHFNZGpYTEtvYjRwWll1S3NSYWtlTjY2RUpQTW5BMDYwREx2REZvaUIzcitw?=
 =?utf-8?B?cDZ2elI1b3VFdzhDYzRLSDk5M1JYVWVpSEhtbDJleFFlaitZSkoycEJ1MnRZ?=
 =?utf-8?B?WVl2OTZQYzVsUGF5VVg3SU44YXNuVWI0Y0s1eVBmSTVXVjlXQlJWTXhQVHUw?=
 =?utf-8?B?cW0ra08vNzBMSXNKNlVWdkdhbWZTanIwRjZwRjR0SlJaWTJpdHFSTytrS0Zj?=
 =?utf-8?B?U01lY0Q3ZmNUMUpuM1lWWlRlYnpHbnEvNDNpa0dUSnFqTkNwbDhxcGpBTG8y?=
 =?utf-8?B?ZlNKV2UwQ3V1Ylo5ZGc3dzRyYnNEV1VrWlZ3S3JVVUpKZmtrYzZ2Mjl4ZGN6?=
 =?utf-8?B?NXFjZklHV2RtcVhRYVArWU1tNmVnNGFXcld4U2REWkQ3ZjVDREFHK2hiSlZh?=
 =?utf-8?B?ak9jd2lSeHAvd3NGSkc3THp3WlpSRWs5dHdQL0ZValk3NXdVR2Ywd2pXVG1I?=
 =?utf-8?B?VWlCQSsvMmpRM0JEVklMUkxOYnI4dW85NDB6YnQrQmNJbDlreFM0Sy9tQVpu?=
 =?utf-8?B?NldkbmpQVmE1aWw2MEhDcWFjbHVNVGFUZzN0RXRod3BEV0tIQm1mTWlEaFlm?=
 =?utf-8?B?aStmNzJzY2w1dGQ0RS9qQm1GRjljV3JZekNTWEFnaXRXaS8zYnNZM3VLV0tz?=
 =?utf-8?B?M25PK002K1RBM2xlOTRXZDJxbTk5L1pCZSt0a1pIRGJONm1BdkVGT1V5OHQz?=
 =?utf-8?B?WEpWTGRvYS8xY2RpYW1kMXMvbUM5M3BjYnhnWTZYc0ZWSjQ2YXdBcG9USC85?=
 =?utf-8?B?UzQ3RGo3QWw2OUV1Q1M3MXNSaGtRSkpUZGl0WWdHSnliRlJqUlF0aUtmODk4?=
 =?utf-8?B?cUllSitVeTRBVzJRbHEyY2Zmc0lXYUdsVE9xSEQyRnZQQ1MvOElnYVdjaU44?=
 =?utf-8?B?WEFvZkU0c3FRY251KzFqdWFHL2xxUXdNeGlEMkt3d3ZJYWc3M3NmWVhYcnIx?=
 =?utf-8?B?Y20zNUthcjI3NkRkdlJVRXZhY0JsY2kxSmJXNXFKYnhoOXduODRRUUtsRlFo?=
 =?utf-8?B?UWVFcy9UWng3NEtOQ3c4aWRWL0xyNXgybW5OKytqZ2lUNXBrZGV2S0t0bzFX?=
 =?utf-8?B?VzUyQUI4bFNaMzlvRWRZUWx0ZGlIbWZPMWgyNUJyY0pVaENYeWVuUzRrNFha?=
 =?utf-8?B?bjQwT0hFeitXNXZLTW42THdjaDRSemRlYWlUaHU5SC9CVnBwMU03OWs2eFYw?=
 =?utf-8?B?R2ZMcnpRcnRWVHJLYWVPckpJNk4vS0p5bjhZQXJwazg4aHRNdXRXUUxMM3lC?=
 =?utf-8?B?UytCWDVwU201Ky9sUzk3VXFJR2RlZnhETEJyZFEzYTNBaWR4T1BuY2hmQ0tM?=
 =?utf-8?B?eGVmT1F1WnRPR2xXOEVpMENpcVpRdzFNUjVJK2JBbmt1K01LN3Iyajk5NzIv?=
 =?utf-8?B?U28wbzFUSG9iV2JCV0w0ajQvK0xSR0UyUjZzam0yUkUwcWc3SUgySCt0a3NO?=
 =?utf-8?B?cERKMzRtWFpnV1BaMWYvYUFXb2VBPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 178eeb73-9478-4294-f18e-08ddf6aff001
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:36:06.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYD4IzAuh9Xw5egEcZNbpS7BzzKT7c6/XXICprGgLw8R2eCVi6U4PQ6c15FSYge7lPKXveaXVz7KKsVRh4iMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR03MB9928

Hello,


On 9/15/25 7:31 PM, Conor Dooley wrote:
> On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
>> Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
>> Controller (TCPC), NVMEM, and additional GPIO interfaces
>>
>> Use max77759-fg compatible to avoid conflict with drivers for other
>> functions.
>>
>> The battery node is used to pass the REPCAP and ICHGTERM values
>> needed for the initialization of the fuel gauge.
>>
>> The nvmem cells are used to get initialization values and to backup
>> the learning and the number of cycles. It should work out of the box
>> with gs101-oriole and gs101-raven which were previously running
>> Android.
>>
>> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
>> ---
>>  .../bindings/power/supply/maxim,max77759.yaml      | 78 ++++++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..4d45739fcaf26273ec57b60049d6d0421df38efb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim Integrated MAX77759 fuel gauge
>> +
>> +maintainers:
>> +  - Thomas Antoine <t.antoine@uclouvain.be>
>> +
>> +allOf:
>> +  - $ref: power-supply.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max77759-fg
> 
> Compatible doesn't match the filename, why?
> I assume the "fg" is fuel-gauge, but can this device be anything else?

The max77759 is a multifunction chip.
The following compatibles are already used for some of those functions:
- maxim,max77759 (for the pmic)
- maxim,max77759-gpio
- maxim,max77759-nvmem
- maxim,max77759-tcpci

The fuel gauge functionality that is added with this patch is very similar
to the functionality of the max1720x which is why the filename was chosen
to fit other maxim fuel gauge chips pattern.

Maybe it would be better to use the maxim,max77759-battery compatible to
match the filename? It would also fit with the already existing
maxim,max77705-battery and maxim,max77849-battery compatibles.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  shunt-resistor-micro-ohms:
>> +    description: The value of the current sense resistor in microohms.
>> +
>> +  monitored-battery:
>> +    description: |
>> +      The fuel gauge needs the following battery properties:
>> +      - charge-full-design-microamp-hours
>> +      - charge-term-current-microamp
>> +
>> +  nvmem-cells:
>> +    maxItems: 1
>> +    description: |
>> +      Saved fuel gauge state. This state will be used during the initialization
>> +      and saved on exit. It must be initialized beforehand.
>> +      Its layout must be composed of
>> +        - RCOMP0 (characterization of the open-circuit voltage)
>> +        - TCOMPO (temperature compensation information)
>> +        - FULLCAPREP (reported full capacity)
>> +        - QRTABLE00, QRTABLE10, QRTABLE20, QRTABLE30 (cell capacity information)
>> +        - cv_mixcap (remaining capacity of the cell without empty compensation)
>> +        - cv_halftime (time-to-full characterization time constant)
>> +      They must all be aligned on 2 bytes. A valid CRC8 checksum must
>> +      also be found at the end (polynomial x^8 + x^2 + x + 1).
>> +
>> +  nvmem-cell-names:
>> +    const: fg_state
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - shunt-resistor-micro-ohms
>> +  - monitored-battery
>> +  - nvmem-cells
>> +  - nvmem-cell-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      fuel-gauge@36 {
>> +        compatible = "maxim,max77759-fg";
>> +        reg = <0x36>;
>> +        interrupts-extended = <&gpa9 3 IRQ_TYPE_LEVEL_LOW>;
>> +        shunt-resistor-micro-ohms = <5000>;
>> +        monitored-battery = <&battery>;
>> +        nvmem-cells = <&fg_state>;
>> +        nvmem-cell-names = "fg_state";
>> +      };
>> +    };
>>
>> -- 
>> 2.51.0
>>
>>

