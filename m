Return-Path: <linux-pm+bounces-33560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4AB3E20F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 13:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A96374E28BC
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073032143E;
	Mon,  1 Sep 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="e1/LYDHm"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012055.outbound.protection.outlook.com [52.101.126.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B971E3DC8;
	Mon,  1 Sep 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727506; cv=fail; b=j7iPpgSdL+jLM28PS6aAD7G4idr/31Us1hbAWrc+vYnTCpUMyqsRTihS6j2yDE9ofVQN9Z8bFFhDO9pr2i2IpXV8oDzQhbu44Lxv2if0nL7jfCulwNq0uV7x976tZC5W75w5ba3DdxELVnxLFyYKW88OMsdYnDTPa2ROo/XZHwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727506; c=relaxed/simple;
	bh=pocAf4PfbEjLbi3E/I60fZqOilnPSyJvqWXoX+F+zFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGYpOtfARuaSh2bB5BRsT5/ikLjECoDijd0eJGTpzxxHedE5qmmeEiK9sBuFrhe26xudzMqnSxr7mI8ipU7gFtEjScuyCA6aIF8qOD6yEUvU+qIzxKUyq4Ylo6/W3Bt1SPrhQsM8qfR0CXqMF54PTA13SxQFKrLT1V09AR9saiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=e1/LYDHm; arc=fail smtp.client-ip=52.101.126.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e06+5zmk/ydpKdEiRhzvv0MLIZvLI3cWbEpVQDxscQn0/3gsgfO52oiBbc5LhzZP/tMkreUkYM7wGtMirIVxNAfYVut+5TTHTAujPUh1Z+2MTAx+7MCgWKLy69brPttbGPZaNJ4lCyIgEAnVLLzouAt0R4nEx8pY9pXfcOuAE/05bnfmetxtT6ZU44AEU67WQJYCG7TQb7ptEu/3cEiLBiBjRfxeKlHWVzM8DGvIVblMaftBJm/RU21ly/2zaisSkS62YqzkXDk9oVn4h1dwFAVEVjH2trL+NFUf4X2xakLgd+EtVVb3nYX0L4YGDXJ6YiQKpPz0M1yeiDIVSNu6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kAQINRZqO040vBDiDNu3atgxGShIQG6aCcru7239nk=;
 b=EFhO4+ll/PoC0dcWJrmhHnCbICCM88X0LyhCW5MAOeAcdYrI5yTz0+kesCpxHbXFMfzYnmSBJdku4Io56jEF1fvZnbAcdIsVc6bBNYYyPDOsQ/Fho+U2fazqkYx0vbCYNaoVv3FVOLRh50CHJQsatxlZrJDR7OZnef0yraZhf1NSy3rZRumSb/fdWIhmrmSkpk1o/OOUa9UG01FY8gKCdCenw8MAvr8SWQDJxS0WzDTWvw1CQuLmbXtQ0oclJBj55hHzrZUBL1zNpiPbqis6eXEKLfdU4qaJbBrXRzT84wqqIPKXtux0f3bNxRtIMSQYhumryIjgPWb5SQ9OdqMdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kAQINRZqO040vBDiDNu3atgxGShIQG6aCcru7239nk=;
 b=e1/LYDHm3sEF0//8DpnLKtMEJ6p9/aBz7kgOO/XGLZCE3NKmxtU+o4BZcRvO4wWbcArKQbNwamilJYON3tknvGwM5bFWhjHptcuEej3hOX4PVjcl3KbNaxVeOiJWdajKWlZ1mMNcelCGrpRMIEJgf0Ib3rtyq9ap6stv/BokfeOig2IZFPv9XySQ2D0RySKgjiUqEjMfYOcI6h06VpYxaPX5a+1cAM2W8wdqQocO+AKCMdlmlxZ5avDdBpd6OB+OJIH/Vl0KGJsmwlQDdmNaTQDrcR0oFVCdYH14U4SDpddmYxIseJ3InnNWdmlGXjkIuJ6o+QgW8nQL/j8rZp3e8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SE3PR06MB8105.apcprd06.prod.outlook.com (2603:1096:101:2e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:51:39 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:51:38 +0000
Message-ID: <993a2758-3756-48e6-a18a-ebb13a5ff41c@vivo.com>
Date: Mon, 1 Sep 2025 19:51:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Use int type to store negative error codes
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250830093458.642881-1-rongqianfeng@vivo.com>
 <20250901060824.6zenbu5wdko5rot6@vireshk-i7>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250901060824.6zenbu5wdko5rot6@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SE3PR06MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c5e6ed-6e43-4cdb-96c2-08dde94de8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3NscG9tUnRSMHJ4dW1QME5IQ3h4Q2ljL2xiL0kyVHN2dlpCS3lnanlIY2R6?=
 =?utf-8?B?OERidEtYMllVVEdMd20wUituQ0FQN3Vpby9JQWZDcWorM1UxV2Vtd0RGeUsx?=
 =?utf-8?B?UzdNUFdNSWhGNU5YYXcrejdETmI2QVZnWXVXRnhGYms5S25nT0JabVNleWRQ?=
 =?utf-8?B?bGUrUWJYbCtiK0l2RG1zS2tJa2RrZ0NsVWxQTzFzNFNYR1MwTk44NEozZVlm?=
 =?utf-8?B?bHlMNXk2OFV1UDdqejdnNTQyR05sRTdOM2x4VkpnTCttZElDTENGVXdHMWJk?=
 =?utf-8?B?WElrczZtOTNOWk9BL3hWRlFEK0xoKzlaWVFBK3VvaFlJT1QzeDk1WXNKT3dq?=
 =?utf-8?B?VUxGMHV5WkVFTDFPMzVsMzMyeFVlMVM1cENhOURUOThHVjlLMkkzNW9MNUts?=
 =?utf-8?B?TExxaXVOQnVFTllWU24vNkhZenFkNGdQV0t2V2E3Y0ZzcTZ1bW1Tc2wyMkc0?=
 =?utf-8?B?OVRJRmVxaEdod2RISlNMUlRPQm5TdkJ1WWxpSStJVENINTJyRG5pNTZVVi9O?=
 =?utf-8?B?T2MrVTkvR29ab2RGN0c4R1MzU2laQ0E1UzVwRVFDN2QzL09BeEZYMkVzcjV1?=
 =?utf-8?B?WjdVRVdhbmt1bTd4aDM2TFZmQnFJUG5XQ2dOb0tGR2NXSmZsOUtNTDhaTmVk?=
 =?utf-8?B?a2FkR0c2WFpURUtxMUxOaVlvZk9hMDc1ckdjbGoyN2xjcTlLcVZBR1ZGMmY0?=
 =?utf-8?B?RnpHTlZIM0ErbkNiRENNa1hNSkJjRUN5QjJ1QnVGVmJiVmpLNEJIU0lOZzRQ?=
 =?utf-8?B?d09hZDNRRXJndUcvWllsdytoSjd0WFZ5cmM3NExKNjlQZVNLU01nYytPYW45?=
 =?utf-8?B?SklUbTlIanp3MGI1Rlhvb0xaYmlxOUVRdDVYRG5NUkhjd3JxamtTMlVjYUV6?=
 =?utf-8?B?WjZHV0JmWkdpQjd0OWpFbHNmblpaZVRERy81UEFHRUc2K0JkNGJwcXhlQUZq?=
 =?utf-8?B?VlFUOExSTzEyVm9DVGZXa0JtV2V3Z0RSV3hNWU9Dd2tuSkZDK0VuZVQwblM0?=
 =?utf-8?B?SVlHTXQ0ZEFoM2ZIcjBvTW5LWFV4Q0ZWSUpheG5mSlhFTjBLR3F3RTA2TC9x?=
 =?utf-8?B?N3BXQ0IwMk9wcVVCdFB5em03RmNQemxhUnl1amZTcTFqK3Z4QzI0VjBZNHR6?=
 =?utf-8?B?aWJseEdKRDNtbFNNLzJCMVh4Y2tabXFKZk4xangvMGVCTFIwcU5jRnhXRFlk?=
 =?utf-8?B?MUxVNFhGUzVCVkR6K2xiWWpxdkpmZDVkOTFlWVBjWGVGNG45cFJEcWxzK0w5?=
 =?utf-8?B?dE5McGUzQmlZcnFGbEhGQjh3MFZwVjV4TGdCWWMwMFcvK1haYndKNXNNaEVN?=
 =?utf-8?B?em8zRjZyTmo2OFovS3BXcy9Sb04xZVhnTVIzNlJjbFdJTXhpYndhU1RtbHlk?=
 =?utf-8?B?cHEySUxGVXpGWUpEL1NTNDNmTVB3M2xHdmxPYStNUUt4bGU4YTQ4QWJOczBs?=
 =?utf-8?B?dkdsaVdoSGlSY0t5emxYMnl2eVZYMC9EcWp3VElRemlCdnd2SXM0ckZtbXZq?=
 =?utf-8?B?Y01rZmQwOUNYZHlTa0Y1eG9RMnlYdE4zU1FqN2o3SWNRMFhWUSs0Mi9qR2F6?=
 =?utf-8?B?TElqSE91Wmh5SktXOHdISzdVOSs1NTl5TVVWMkxqaUJKUGNuYUpkL0swQ3lI?=
 =?utf-8?B?dFp6My83MlRkSXhFN3VKdzlwT0p3WGVSRmhCa1BBUHEwWjZWRWNHanpNTmU0?=
 =?utf-8?B?SUtKakJCYlYwb05VZ1BNZXIwaW9GRTNxS2tLK1k2T0g5cFFRWElmcFk3Sit0?=
 =?utf-8?B?UkROUFBzUUV5L2NNVUFtWTVBUHdZYzhuMlVnMENJdG9GT1JaTWNzQ3ZuZnVO?=
 =?utf-8?B?aGhNY1lJQ3BSVS82aFA3aEhIZWo2cTk1ak1YbU5nS3o4Q044bGxRaWVITys4?=
 =?utf-8?B?ZlBncmdObFJVMXZLbXgwdWh1UkFNbXFIeVFKV0kzc1Z4aE1ZVTM1SlBnZ2k4?=
 =?utf-8?Q?LsTI+Vo5NeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtOQVExUXpEUHYvaUtFZThkTWFlMXBkZ2wwck81TllySmZCNHkvVUpmQXA1?=
 =?utf-8?B?eGhXZWUrMFJwQWtWOTh4N0x2NGtOQVNrOUNLWWlrWGNNemNRanFRQzZkQWNn?=
 =?utf-8?B?Uy9xWHdhZk9LbmhYc01CMk1xWFYxVk1qeTg0VTYxREQ5T3daRkY3SjhMSjN4?=
 =?utf-8?B?MnhEaDVTZzEyZmpkN0NFbXp6aG1WdUZJN0F4NmcvWFpjaFRDS0dmaWkxeWlY?=
 =?utf-8?B?RDZuMVZIamRCVlZlb3hnckphQ0swUmRuanlsM1dNa1JSU3piaXgvTUhEMUxw?=
 =?utf-8?B?cTVQY2dTdm90Nm91TmM1RlJ1UXJvdE8xQTRBVytaczFnN1lJdllNQUgvbzJ6?=
 =?utf-8?B?WHZUbzVUTWd2WXFVZFVGMDI0YzY2V29Bc3F4RWJoQVcxbmZRanM2YXpISnFa?=
 =?utf-8?B?b0U2ZkJCM29ERE42dWgwNG45UDV2eHJtazA1WWdGaThlM1NuWFFla3FacHVF?=
 =?utf-8?B?ek5SblpBaWFtSFczNUdxcGY0NGFJeWw0WHk4aHk3VXFkN1BZbWphcHB2ZlA4?=
 =?utf-8?B?cUtpQ2FzLytzMndNb2dVaEVFNWFJcEJEM3hkZG1kV084aU1EZmhvd1ExSVlL?=
 =?utf-8?B?QVhtOVBxTnNSRytuK1o4akxtUUk3M05HWUxQUW1DUTJ3TXpCcFBaOWNUVU9D?=
 =?utf-8?B?YzNGWnJwUm0ySzVtaEJrbUlmMUh4NHZIT1U2UklQaVBOUmE4VVBRUWx3bG1C?=
 =?utf-8?B?bTJQQkVTU2Zjenk0UWF1UWhYaWtJVExLMFlGeEZYcFVvUlpkTlVabGpvSkxj?=
 =?utf-8?B?cGpPSW9DamxDdjB2aXhQd2RETTlyOTFFbSszZlFhOFBFOWNpLytSK2ZPZVQv?=
 =?utf-8?B?ZVJmV08weUdjdkpaSHlqb3Rac0picldBOFRLdE43ekplVGtDbWZIVitlcHYy?=
 =?utf-8?B?WUlsakxPc0VtQWlHVEw3bXJWRXlQcHZ4WEZDYzlKb1lxWnFEcXZ3UWpzOTlE?=
 =?utf-8?B?OWNqUW9lbWliY2ZXN1dHWkVWRGlzVFlaMHgyWjJlR2tvVFdpQURGYkVNVWlB?=
 =?utf-8?B?WWpCeGZBQ1J5aTBvUEhrVlF6TEdpc0FYUG9tTSs1dDZCZEJQVnE4K2poMk0z?=
 =?utf-8?B?VkhJaUk1QzFzTGNXdjhNTTAzWDlHbUFuNkhWTEJ3aTYyZVJXNit1bzRGTVNR?=
 =?utf-8?B?TUIwS3ZVVFliNGZ6K3hvWVV2UnBEa2M5Q2dNZmJNak9jTjJMNFJEd2MyY0xL?=
 =?utf-8?B?VEJ3ZG01czNPUFpQdzFnRTFaamNPa1hpWnl4WGowZUppVU5JTkpxcDZYTyti?=
 =?utf-8?B?Y2V1L3BMQmR6ZjZZSXI1MzM3WGY2QlQ2ZkZicEF5M1krbk56MS85WURvYmV3?=
 =?utf-8?B?SE5HVHhKMkxxRjFnNExvd2dQZCtCYUVsUENnVkppSG5XRmI2clBnN1ZybThh?=
 =?utf-8?B?dmZYMmJITEVEb3lWRkVCSVNjVFU1OXo0elM2UWxGcjVkM1NXdnB1b0ZXVUxW?=
 =?utf-8?B?ekJaM3BQemhxdGVydFQvLzh6U3hjUnJwVWJmeGo1QnRMRW9ybDl6aDJveUFN?=
 =?utf-8?B?dXRuNm1qMmZvOHZVcHIvUjErRU9oeXZDTjk2dmJGNDdFamlnN2pVSzdsajNk?=
 =?utf-8?B?aURabDNoMk1VUTdGVWE2NTQ3cXRiUi85U3RCdU95cXh2ZUtYZTViYVY5R2FI?=
 =?utf-8?B?QTh4WXhVOUNrb2RNa0RXTU94MHpOUko1MXhrNDRFS01zMFkvd3RlQ1F6MHIr?=
 =?utf-8?B?VmZXTGZBb21KUDZZUEd0bEhUZWhlbVdIbUFyNTFkNGtVSGxUVXpsb3ROQzZD?=
 =?utf-8?B?VGxlUHl0dGE1Z09aV21kVHdtVVUxNTZRbm1JMFNtQU90K29JVklkb1pVc1Vl?=
 =?utf-8?B?WHFBdmovbGdHblduMGxEOGJGUlNSeVFSaHVhWEN3dDlxQ002eW1iRVJ2OFha?=
 =?utf-8?B?aVVKQk9IWU53RWhSbnZaNWVZdEczUjd4ZG0wRjFDSE1tT0kzb0NTNDc5TWNX?=
 =?utf-8?B?ZFltNUR4dEM0cm9zRXhtb2RldlNqekxYRUhoOWxoenpUT2xLOHdjRnM2OWlq?=
 =?utf-8?B?Mnk2NXRCbVM2dWFrcXVORUdNMENHaXJaNXlsWWR0Y1VCa1dPeFJDUmFlSXBl?=
 =?utf-8?B?MEVjR3VBUWFYMUFTVFpFTWtQaURLZitzaTYrWVBlZGpFN3VlZFY5Mk5rNTRH?=
 =?utf-8?Q?R59IoBd7/9iAJjEBV4+Vf9n0I?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c5e6ed-6e43-4cdb-96c2-08dde94de8bf
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:51:38.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ciqbzco+3E6Q+UVWHQ83XyC8HVNgDgctF5MHTwiSEbZcUGfg5LDBtxpjYi8F6t/bHSj5mdpHCRqwMEp6gxFumA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8105


在 2025/9/1 14:08, Viresh Kumar 写道:
> On 30-08-25, 17:34, Qianfeng Rong wrote:
>>   drivers/cpufreq/cpufreq.c       |  2 +-
>>   drivers/cpufreq/powernow-k7.c   |  2 +-
>>   drivers/cpufreq/speedstep-lib.c | 12 ++++++------
>>   drivers/cpufreq/speedstep-lib.h | 10 +++++-----
> This should really be three different patches instead.


I will try to do this in the next version.


>
>>   4 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index a615c98d80ca..f47096683abb 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -914,7 +914,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>>   					const char *buf, size_t count)
>>   {
>>   	unsigned int freq = 0;
>> -	unsigned int ret;
>> +	int ret;
>>   
>>   	if (!policy->governor || !policy->governor->store_setspeed)
>>   		return -EINVAL;
>> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
>> index 31039330a3ba..88616cd14353 100644
>> --- a/drivers/cpufreq/powernow-k7.c
>> +++ b/drivers/cpufreq/powernow-k7.c
>> @@ -451,7 +451,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
>>   	unsigned int i, j;
>>   	unsigned char *p;
>>   	unsigned int etuple;
>> -	unsigned int ret;
>> +	int ret;
> I would rather do this instead:
>
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 31039330a3ba..72430c3c5500 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
>          unsigned int i, j;
>          unsigned char *p;
>          unsigned int etuple;
> -       unsigned int ret;
>
>          etuple = cpuid_eax(0x80000001);
>
> @@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
>                                      (startvid == pst->startvid)) {
>                                          print_pst_entry(pst, j);
>                                          p = (char *)pst + sizeof(*pst);
> -                                       ret = get_ranges(p);
> -                                       return ret;
> +                                       return get_ranges(p);
>                                  } else {
>                                          unsigned int k;
>                                          p = (char *)pst + sizeof(*pst);

Exactly, this looks much better, and I’ll incorporate it into the V2 
version.

Best regards,
Qianfeng


