Return-Path: <linux-pm+bounces-33898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C105DB44B72
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 04:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4887B1C809B5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 02:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB181DE8A4;
	Fri,  5 Sep 2025 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="a5VUL67h"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023128.outbound.protection.outlook.com [40.107.44.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FF8834;
	Fri,  5 Sep 2025 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037827; cv=fail; b=tLNF7IYIef/tAeMG42NIidDx5FQSle03qwin087SLlcLkUrjk+CDwJmTxk2bcQtaaSOlVjVDx4oWljqu36rPcGPCdclXGj7L9s9iTdDEbsYvvtUCwLHXTSKbjyEyCNeY6K5ie0665tY+yyo7V9tgRzgddIdoElmK1rG5BDSYqfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037827; c=relaxed/simple;
	bh=HUeOFiMvaNbvuqpoJX0hjGRxPL0qxS2seYMcEFssNVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qYCZ1OuxDc3cP0ydE94EOnK8HBhh9KfCHo4zsKAPCuQQQiFZAC6CVehzSbcAeC6aaekEPc76KeHZN6EnzmFglDxAuyqm2JmdVuN30aRhwfZWqgDfXPDQj6PpGCjHMYUOJxlZ63qvvEEWGWap6vBfl1RjOV8kAqWUoJCyZz+tQw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=a5VUL67h; arc=fail smtp.client-ip=40.107.44.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1D2eegkKw4+mCTky/iZmvkPLaiActxJdbhUdxIvog/pukD4hrrWAs/1z/RCMvF5L1rHxoNQN0n4pJRnFurZEgfF/24YYuqMz0QwIDT+tYthl8Zju01+L0q5Bdz655GKu5cE3wdzRsSfnwxJYSsSs7Jhhq+bT5/pPTb6anwGc0Omo4ZZSFzuluhF2cbtz9nI3Y282MrUicw39F1Fqc6Q1pfOs659AAOFIBn0OkX0m6HYnAtnzSHKyl84yTFMD+0pwxHye+I/d03cs2nGd4xwW2Wf82gIIQFRfOVy3XkvMz7e2JITo7t1yjlR4FRLvmZcUdZls3nGC83vAKb+kdmbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrAcpKaow+1jf0FfON4G6WRqtYiAVAWah5JsgOE4y00=;
 b=ukZzjGHmWtlI8zJgkXSL3AC66V3Xw8cN+Og8+3JUoL+M045vhQZvHui5TNRbQc/1epLCsc5l3psE4MUWHdSE/z48A09cY4X5peZajSXWGuEoMdtPHa0ZQ6R/CAcidERFm0hOsgr9RuvUoDWWLO88sVPJB21z+ogikULFrtYtnxZX/HaDhtpuBcHDq4lGsFvLymFQqH4fc2J+d5QjrZDEUf1jlACNqrBDy678IxbLu2KV7xXDVTWunEoX2QNgIAUUec3fARV0CD4iOx2TIyvAo1Cf8qigzo0PBmKDeK6VqaztcqQk/XLMK+icyYbOiR37SEAvw9IBru0AxVNErOvHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrAcpKaow+1jf0FfON4G6WRqtYiAVAWah5JsgOE4y00=;
 b=a5VUL67h4hY4dJJ1iNrU912oSWpR+a7ARmCtK2A8oZ3/vb56/zOoEoteG+aDzaUATu5E8h/JJXHrFlFhomGsnikdrb8Izci8U9uxoMLFU8K3zFToZmEYgQwZ6txCnjJKiu94nR3KIxo1axl1dcO5aBFOdKl8FVfNQARnX8G26mII023XR3dkcw9KPBzffmJZoR+Tp1uozpqIEywLzDsruRh0JdEcLLHOqH4vUTFQJ7DCcMXXvMahhSuHYrd12C3tMX7q8TK7Kq7ivQm6FEwjtYYSA34vDNfmEyQRwmP9uwcgGSFp1qd8mHt/3f806Uwn/0Ft4okvaMghsF8njMpkmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by OSQPR03MB8675.apcprd03.prod.outlook.com (2603:1096:604:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 02:03:41 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 02:03:40 +0000
Message-ID: <5477f412-22bb-4a2e-8c78-192d8171d5e6@amlogic.com>
Date: Fri, 5 Sep 2025 10:03:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: power: add Amlogic S6 S7 S7D power
 domains
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "hongyu.chen1" <hongyu.chen1@amlogic.com>
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
 <20250822-pm-s6-s7-s7d-v1-1-82e3f3aff327@amlogic.com>
 <cce649b1-511b-4895-84be-2c85e748cfa8@kernel.org>
 <CAPDyKFrE8CafoKDkdHQKf=yxJjNcJUu9vFrpAASQYXhtUg6cVA@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAPDyKFrE8CafoKDkdHQKf=yxJjNcJUu9vFrpAASQYXhtUg6cVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|OSQPR03MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1f748b-1149-401c-08cc-08ddec206f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2ZhWEJSR2tmOTZUUUppQXFvZGtOa3MybExYZ21hQW9EeXJlTituSG8wNjQ0?=
 =?utf-8?B?VHFwYjZtanVUUE5ZMHhvSjJvS3pKeEYrbFRDeUwxdjg4WmhIVGpjWUdRQmVm?=
 =?utf-8?B?bDl0Y2xuQWdHYjJLQk1MM2F0QzJPWWZvYW9YZmdDRitPZHdNWXBTU0tVTENN?=
 =?utf-8?B?OXJDWkN0U0tjRElVV2J1WHYxZ1NMRDhTRlZiaUg3TnhqRzMzMVdubnhydXBm?=
 =?utf-8?B?VDRZLzhZQ1QvdC9zaE12UHZsdDIxNzU0dTJSTFNxVFAzZU1SdUhNbCtCclhI?=
 =?utf-8?B?ZE5aa2tlUGgya2NEcExSZGhabU9aa04wWEpUbFpxZi9wWjVHd0xYWUozdzNx?=
 =?utf-8?B?Q21ta21YUkdpSW5NYzBDY1FvN2N3VE1IcTRXSFBIYVQ5ZTJZeGdGczc3dHY5?=
 =?utf-8?B?dERNSWlDN2xWZDFWU2h5SmJOYXdCQVhrb0s0QWJRTExzV0xKV252azFveWh2?=
 =?utf-8?B?WU5mL29TWW4zYVR2SUxqZmVNUmhaNHlFU1QxSEpCcmdlYjRpazMwUFRHZmxj?=
 =?utf-8?B?UForZkY0L2w4S3VFejNvbXl6cWZyMkFhb21YaUlYdkx0dVd2QjZBTUZTK2Rw?=
 =?utf-8?B?VUxYYS90RXkvOVF5MDRyNjQwMXE3eU40VzhITGhmYkNLeUxjMUdRWkVleXRW?=
 =?utf-8?B?a0w2TXdEb2N4U2VTR0FYRDAwZmpGYllobW9FWnROKzRNdFh3TDE3eHZ3aGVQ?=
 =?utf-8?B?NWh3SHdIY1RXUFcybmlkOWJvR1BEMDNqdWhDZ09aVjNmUlh5OS9vNVZEQ21j?=
 =?utf-8?B?dERiR1JyWnV0TWZzdFRDOTVnNDR2eWJ5eXo3L3A5dWJVb2R2dGpkdW1CQ254?=
 =?utf-8?B?RmhJeUd6Y043YWJRWE45WjlaTzROS0R1eUNaTWQ3bkYvWFQ0d2NoaUorclJo?=
 =?utf-8?B?enRUbklsS3h5bEZxbFlVa2ZCSjFyRkFQeG8xdzVWRHNiWDA0NlBSNkFXekRY?=
 =?utf-8?B?UXkwMHcySlkwVjMvMVJJa0NtejJzN0pReGRyOHFiQVBlSERaRWFTM0ZVcjJT?=
 =?utf-8?B?V2dXVVBPNUppNVhZYzVlTHFlb2MrWkIvNmhWbGh3d1M0c2cyaDlwZ2xWTXRz?=
 =?utf-8?B?NmJzMnc4NWFpQmcranUvbnpvd3pWWVRTbjc2MEJGTjdEZkt0bW83THpaTWFV?=
 =?utf-8?B?dFNPZ0FkTmVqZkpyMUw4MjRQanFhZGoyYWpuQVFGbDYzbW96VU5PbWRLNVVD?=
 =?utf-8?B?MndOdGhneHlzYTRHZllZRGZlN3d4OUMyR0xSRlhJY0Jwc0swK24xTVRzcS90?=
 =?utf-8?B?L25hejNUb1RnV1dUcGFoekwydDdvbEs0Q2lUQjJES1g2dGpQcDkrU0FEWnNR?=
 =?utf-8?B?MUwwQy94RFlPZ2xOTjkyUEVqZDcyNFZVTEFhZ1JjVnorclZ5aWRPaGRTekNT?=
 =?utf-8?B?OUxOUDl0ZlJMNzdUUzN6dXl1KzZIK05oZ2ViVXVKRlZYY0NWK3ZzalBWTFFH?=
 =?utf-8?B?WStQQTRwZkw4OWYxekdhWTRUdS9IeEVCMzRiTjZabkk1cjBZMTNoSnpRb29y?=
 =?utf-8?B?cFFrbzhWTitSRGdNakFkRTVvd2Z3SW0veUI4TnBDNTRkdzhSRldGeVdkVHhJ?=
 =?utf-8?B?VG56UlFVMHRxdVdpdkx5WW9vMldPUkxieXNMTUZEcjhCWUNFb05WTjhuOVph?=
 =?utf-8?B?blBSWFJUc1MwMXRiMWZwNUFwUGJKT0hxSm1IZk9IVzIxbFYwVHVtNjYyZTlL?=
 =?utf-8?B?S1RtZ2lacUdRQXNzNkVyMlpsWWZRWjA0cGhIeEgzSkFEZER4YUxtMmI3N2RT?=
 =?utf-8?B?anhmOTNsVnBqYUhSN1ZXTXRwMHFCMFltaXRvOVpncUpCclhPM2RZdnZueHZF?=
 =?utf-8?B?c29YdEgwV2d6WTdhT0s3VFJwUTVyY25tQjVCTUtYblFPTmZxeHBhcHpSL3Nn?=
 =?utf-8?B?VjhyMkY4SXJCUFRjWktuZFdaMlNhdWovZEZoQVFqdDR4ZzFtK1F4NnhGWU1y?=
 =?utf-8?Q?YtUcnpviqto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3RxemNsUG12bkRlZ3pKemo3czBDN1BqYS9yeDVzVHF3R045NHhvT05zV0gv?=
 =?utf-8?B?a09oU0RmMy9abXZEUysySlRNRmVGb1psVzMrVDNQalVBYUNhZHVtd0daZUNV?=
 =?utf-8?B?SmYvQTlFSXo1RUZTRzlNL3dQY2VtUnV0ZHpoTWdVb000ZlpVcWxwM1BGTkY5?=
 =?utf-8?B?U0FIdWVUbFQ2Wmp6TW9FbDNxaUlJdXZoMU5qOGlSVU5FMlVrc0xFYUE4dzFI?=
 =?utf-8?B?T0VpcXBNcXBvYWt5cjJFT3JmWmZWSDI4c1VFYWlhVHZ3alRraktSdmdBbHhM?=
 =?utf-8?B?M2JzQzVDdElVWGJ4L1dia1E3Y1o0Z1ZDUld0T1l4U1pkcFlmQTJUMmxEUFhH?=
 =?utf-8?B?Mk9OdWUrLzY4K1BhaU5vdnE0OGRlOU9yMHlwdXdza0ZpbHNWcFVYdlR6ajd2?=
 =?utf-8?B?MUZ0MXhOa0lTMHVTcEg4Mm81eUoyS1cvZzhyeVU2Qk5VRmZnU1Zqak1jelhP?=
 =?utf-8?B?WlJ3UG1vZVlzUXBVKy9WU0ZodmlhdGorR2FSUHY2bEhPeUdIYk51MHJqTVBZ?=
 =?utf-8?B?QVErT0xPdHdoU29USko4cUhTSmFoU2s5MWFFcXNOUVY5d3ZKTEZ0QlFWK1E0?=
 =?utf-8?B?cHlxZmdoRUwvQ2orOGljZllUTCsvdW9ZYUptbEpReXNhUWU5WXc3cGF3ZDFY?=
 =?utf-8?B?YkoxdzBxOG9hb0lISUJOdi9VRmFKTmdQeTc2S2JycGlzMlF5UXRwNldDbDha?=
 =?utf-8?B?aWFZY2hjRW1YUnpaV2krVWx5aGZhS01IQ2FUdjFGV0toZnp6dEhpbi9FVTVt?=
 =?utf-8?B?clZKUkV2S3dQSSt6WW9PSDlTcXl5UnllN0dRMThjMVJNNmROUmYwcm42bGhS?=
 =?utf-8?B?aU9HSTFHMDdyYWtLREdGWUJWa1dBd3h1d2JTa3dKZDFJM040YnpxSmtEcWhT?=
 =?utf-8?B?QURlRW5GVjVGZTlxTFNIdzdVbXZZRXVIcndhanIvd2hoZjdSbmcxSWdvMWJ4?=
 =?utf-8?B?dUNMZk1zOTRHQ0NCNkM3cVhBS2QrL2wzdytsZ2FTUUdpQldwdEl6VmtJSGtE?=
 =?utf-8?B?Nk05Z1Q3TDB1Unp1NFBOM214RC80d3lxRVFkRjBIOUNhdzdKT3prd3ZEZjJ6?=
 =?utf-8?B?aDEvK2x5VUxsZ2FWamczbTc0TlFNYi95UW9zYjNmWE5WaFduVExwUzBZSWc5?=
 =?utf-8?B?VUFzSGozYjNWNmNSR3U2MU9haE9Hb3ZPLzk3b3d2NHltUU1seVVYNEU3M2x3?=
 =?utf-8?B?N0xsKzhsakd1QmYydzNNbHp5OVFGL1JNVGUxTE5jL2FnVmlXbTV2RnFaSjVp?=
 =?utf-8?B?TWczcDhxSTJ2RHRqbCtmbnJaa0t4RlFQc1gyTmcrOTRZeTRkOFdiVkpkN2VT?=
 =?utf-8?B?b3FxMW5BQVNYSWVHVUhUNHozUUo1SjlHazlzVHNtU3Nua0tFRGJMOExUdmNY?=
 =?utf-8?B?eExXYmRlN0tOTk9JVVZ2NEJrUlh0Um5weHpCRWNNMWs5aVBya1R3emErYzJC?=
 =?utf-8?B?S1REcEhuVjBkOXE5V253UkJDNTJXU3N1TFUzWlZHSVUrZlQ2TWhvdnJWdFhx?=
 =?utf-8?B?Wk5LMnQ3clY3OFJZM1plbXlvOXozRVYwb2ZEMWZxWlhpWkQwNVVpSUV2N0ha?=
 =?utf-8?B?dTYwcStQRVVsUWx2d09IN3EyQzNYMG44VGVmdEtqa3c4LzdxZ3p2ZkRqTzgr?=
 =?utf-8?B?Y3BnZU1QRnBVU0ViNC96VndJNWtYUjdIV1lhZDIxS1BTWnJOQ3NsY05SVm5X?=
 =?utf-8?B?YlRCdGhlbmxlZ2h2bmtUczNJdCtwR1NYQnpHWkh3TEV3Tys4QnFuc2FhS25n?=
 =?utf-8?B?dU5TWXNyNWd2WEJqN3Znbk9HR21hc3hSbjI3R3BPaFg2TENEaVllWDNtdzBl?=
 =?utf-8?B?SnNwTFltbGRPTnVhTkdUSE9hcE8zeHd6QWNVVVhnUGkwWUM2dzQ3UEdmY2hP?=
 =?utf-8?B?ZC9MZmNma1FPRkkxSC9DLzVMKzRtUTcyS1I1Q2ZVVVc1aUlKeHpIUVZLdGNT?=
 =?utf-8?B?bHk5NVZjVW1XYnV6alFKUTBRT2hPMENneU02dUtIeFJNK1ZrNTYwMzFPdGEw?=
 =?utf-8?B?TGhKMFE3dFBKK0tDcFhjWFlVc1hxY0dONGtid2ZkazBOTnhYMkh4dUVqR25o?=
 =?utf-8?B?TmJ5NWRhenF4RWxxRmtuSFg2ZmNvbmNGcFZrbHpySVg0MDZyR3ZROHhkbFlw?=
 =?utf-8?B?aFpCdVp4RDRLa2hVYnlxdTlKckJyMUxRVzdHN2dTNWU1YnpVS2RLMlVISnU0?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1f748b-1149-401c-08cc-08ddec206f38
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:03:40.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7JYC7uaXkorMQy34H027T9fDUUEuyXP6rmKanBXcZdncNDERpFZoVQ3GvmzPeJyMz72o+F+uwNEep/Io9/r/Ms8d99leGI1EtfNZfaeFd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8675

Hi Ulf,
    Thanks.

On 2025/9/5 00:15, Ulf Hansson wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, 4 Sept 2025 at 13:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 22/08/2025 07:39, Xianwei Zhao via B4 Relay wrote:
>>> From: "hongyu.chen1" <hongyu.chen1@amlogic.com>
>>>
>>> Add devicetree binding document and related header file for
>>> Amlogic S6 S7 S7D secure power domains.
>>>
>>> Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>>   .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  3 +++
>>>   include/dt-bindings/power/amlogic,s6-pwrc.h        | 29 ++++++++++++++++++++++
>>>   include/dt-bindings/power/amlogic,s7-pwrc.h        | 20 +++++++++++++++
>>>   include/dt-bindings/power/amlogic,s7d-pwrc.h       | 27 ++++++++++++++++++++
>>>   4 files changed, 79 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>>> index 15d74138baa3..12b71688dd34 100644
>>> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>>> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>>> @@ -24,6 +24,9 @@ properties:
>>>         - amlogic,a5-pwrc
>>>         - amlogic,c3-pwrc
>>>         - amlogic,t7-pwrc
>>> +      - amlogic,s6-pwrc
>>> +      - amlogic,s7-pwrc
>>> +      - amlogic,s7d-pwrc
>>
>>
>> If there is going to be new version:
>> Please keep alphabetical order.
> 
> I have just applied this, so please send a fixup patch on-top.
>

Will do.

> Kind regards
> Uffe

