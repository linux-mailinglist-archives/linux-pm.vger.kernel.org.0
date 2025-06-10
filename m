Return-Path: <linux-pm+bounces-28387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D807AD3A93
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C82617A4DF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E41A2D3A7B;
	Tue, 10 Jun 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CTYxun1d"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2026.outbound.protection.outlook.com [40.92.42.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AD2D1936;
	Tue, 10 Jun 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564394; cv=fail; b=X+99ZTtl9ba1F3hLhHkkFKIhwRVBR5kGitRGaFG38a5ybJmqF9JODBOzC1hLggD2vE3jbo6/qRI9GvmUEYD43veL1I0L6JxJ8gTtr/C6RIuuqbScP5RKW9x5dOmRkI4QmCPKzvL5LH8u7hEqzlrpj7temFXDL9vEj+T+E9qm8AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564394; c=relaxed/simple;
	bh=pF3r/2aKP/shESIy1Kmhx/tahgUU79/I1ASz8Z863kE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0Z2g8DiRetlSV3KrOolpT36zTknQMdzGG8t/bCDwct0AdGMJKG8wC+Aq/OKZGIeAyc3DK6mEfG06xqE2Ezfi18oDznlmIPnzCKlHkw1I5gFM26QS9YRSTheHiovZT+YlXxnk11yxiMtz3w7PtfrDMdlLaTR0mSR/siwVQQ8GNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CTYxun1d; arc=fail smtp.client-ip=40.92.42.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4QQ23ZQjOA7AiHwM4mwLsOm0rSn1Ea78/cNz+VGB8H1BX0+qnQFUQeeSdUF+7OHRXlkxtoB019KDjVoFeDTcNRWg6LGC6KvUtZMv+3hU6LM2syV2jiPewOffWtt2/3xJOm55vNotoni9XvcywtQ2YNgJNn59mN1vDLZ6tWJDW6B38JILvb0d/TgPQk93OVG+fV3jszOXvytqD7SSUPZL5uyk7r7kNRpfwsSGsJm63GsKIUdtpyKvNRKt0R9fTdbgC6krXGUbdvtboF4YIdhXRn2qWFWQhS72Gv9RbqQcYynvXVdcAtfmKYGZ7pCGm4lcgTm/GeaVtrq9RvnO/qb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0N7bxGH7AEgA/eIhml4KaCiUhKub9dDNJO+qLuCI/E=;
 b=XPSgswYCrrKWpmjImCn/IZcHlL6hB1V5qphW6VVDaJRQYY4+hhLHgNOOEp5IXckVz36MobYiSCNGPQwhJNShCVDHTxtVt1OVfdGyszMcM1AQ+LCOpRfAopebeoltHSdI/aY98Psc3kL6TfVQudksmCXV7yA5+TegTot1JWUbnVz56ez2cSj9m5mD9p/8jqjN3ZlpdLCwkBZjvta6OlG78oVNaEWJ+TeCcZV++j8L2NA+VoXJsyPTqC4sJS8QbSzlrBBFhN3DguPLgC4dUbgwPIV6P+DFn1VrHNgPwA6Qug57EmYvt5M5akIWr9gfkyfACrl/S39OuI43jVf6rFHUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0N7bxGH7AEgA/eIhml4KaCiUhKub9dDNJO+qLuCI/E=;
 b=CTYxun1dfJLTztprzOXaxXf9XeiWAO3db0Gd80OnXVKsCRl4I60W4FXrRVtuMx1UW/BWgu2IF5xDj5u0pI/8MgvfUu63TANviwhv7I3XHD2MZC+9YSr94L/AEnI4LEwffwjpoHevGuCyrcL/6i9vcfVYg9SAq+ROchHpJAnVgru+sq8B2wE5FJWHvjv+WlEZejCsH0LQHfYB1vjFdcEHYMD8gdlXsaL2Ph/0QwnpQaCRk5hcpdBqSTwfKt3BCEA4MAT/4UUGv8nDhvbtYPb4xP5zaFfIXW2GGLXqJxkp6Kh7J+kZn5TjK68kjo/R4F2ry6HkamkCeTqjNWOGUQ6H2A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA3PR19MB8167.namprd19.prod.outlook.com (2603:10b6:806:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.15; Tue, 10 Jun
 2025 14:06:29 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8835.012; Tue, 10 Jun 2025
 14:06:29 +0000
Message-ID:
 <DS7PR19MB8883BEBE4168DD1682F858749D6AA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Tue, 10 Jun 2025 18:06:14 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] arm64: dts: qcom: ipq5018: Add tsens node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>
References: <20250610-ipq5018-tsens-v10-1-3a10a5a2642c@outlook.com>
 <f123294b-b944-4723-bd74-713970468d51@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <f123294b-b944-4723-bd74-713970468d51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX2P273CA0012.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::24) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <7abecc74-ff4b-4b6c-a0fa-8c185d07b20b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA3PR19MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c4e3ea-f560-4b48-fa2e-08dda827fe7c
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnpxiy/k40MKpm6IShHTEdBe8tshc2UKkUchF985hM2kWot/rr6QAuruuiHPySNi9k2jCtyxjtLCbKa30YrJ4t36uyZ1SHtxCug48pTX1utInukXrSSaZ0tTrTEx+S4cnllbIIo1kucMLvo4sznSnoXIBVWGXFZVxHmvPA3Vkz0RZ8E7e0ydOI3wMwv8373MDlrEPbdOB3dy6ifwkgeysANglqfypaq6loVqITO3uXksuIp23nSxaYAp7WhF//EE1pbFcJDkfD9mzNw+yJErQxqG+FDkEhT1CKV2UtQRb4ZNFRSXFMwKQ1e+kDJyLCZYXAw95NCzc4ADussIl3bcXBVEq6q8hs71he8/Pb0B2tJi7vGe+DYl2aL8l4cRfEGAEm815dyN7+OzEqjst7U70OCXQfyMyn/90UTl+46RdI+N/EyvEwj3hmNnJC6uM95AQTykQoSmrdZb7FtR295iGgKTVMhmmTcy6t33bq8PG5X7p/LoEZuFJBCbeHxa2whBudagFdOlbAYMHX3mJhVXkjEr90RH4UB6Ejv3L9PAMaAmZI3xIC9JbsuofH22VorjGPen3K/2Zkeeu0OjEV2bPKdzI0buZkSlwvoGVF1Dlv7XSNkcgKrCfcWJpRDRS3/8f/UKzH3X/oCpjHWRQpIMfuvddGhroMuzs7sXwChsSqKHrTrl9fvqyY+1b7aqpgqKMbpy0HNaHx4aVkqjr0e299FcjwRPe6XsVqhzIICpxzW/PDmiXFTiGpAMHmEa0Mg1QRE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799006|6090799003|15080799009|13031999003|7092599006|8060799009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkVJd0lwQnZCSnZpbm0rWk83MkpPcytkd2htSk9FVkhrbGtBemVHVmVMUDNU?=
 =?utf-8?B?OFhXVGNPaW9FYnJiMkErTTdJYXIwR0ZSTmJKcjFxcEN1OTQrUlE4N1dQYjBo?=
 =?utf-8?B?ZWRmYjEyN3FzTHpHV01ESjNObTQvR3gvZElxTDgyTnFvWnVkanFaOUFBaEVW?=
 =?utf-8?B?cWhMOSt3cWZXSHZydVQ4S1QvcmtKa2daQkVTZE9vV2oyelRvZW4rL0oxdWkv?=
 =?utf-8?B?cUtQSlRpVDBEUVpPK2xMbTFBNXlEL1pob29Danc2NlpFMFVpWkMrK3A5TVdp?=
 =?utf-8?B?dXZLY0NoSWhsMUdnVVVWdjRma1VCbjVaTi9JamY2VTV2N3J6RWFjSjVjSldQ?=
 =?utf-8?B?TVAyWHdSWkQ3NHBVM2dnZHVJSlB6ZFA4Ymk4R2d3QWxOVEFNS2p3MjhNaklM?=
 =?utf-8?B?aHZvWHhWT3NhSUVTZ2FWQzR1R0J1S2dmUUV1MnM3S0ZNOEJEQnpCY09EUlNm?=
 =?utf-8?B?eFdVUHRiSEZOV1FQVnpFMG9FU3M1THpPTTVGQW1zMi9OS1NnbVN1U1Y4LzRM?=
 =?utf-8?B?QUFyR21xakVQNjVGVkx0dEJ2NWZqVVFZM2hvSnlCNzF4WFFiSm0rQnFMOXBt?=
 =?utf-8?B?S1FFcDRKbzBaSlRvVXZINjFTMW5raHV4VkRoY01DWnJPREhiN0s3ZGh4SG1X?=
 =?utf-8?B?bDNLZ2dvTTN2UkE4QnpjTG1rMzJ3blRXOE4weE8vMUNPMnI5eldPMDBxTkdk?=
 =?utf-8?B?ZExKSjdyQm8vVGZLc1YyZ0NOOWkxbndmVWQwRUFidU1NWHhyMXRKT2Q1OVJw?=
 =?utf-8?B?WG92YzVrZmxlSWZTYTJpcm85K1N5dnkzVGhXaHRIQ09ZT3cxREJaNk5GUjNT?=
 =?utf-8?B?SnNJM3B3d2FiTEVJalEydURHKzM0VGE2bUIvK20xTEJVR1Y4SVlRTmJhTVFC?=
 =?utf-8?B?cHBZS240ZFcvRTQxbUZoV0VVVFVoU2tlMS9JZ3BZVmVoYjlZcVB5V1VnYVYz?=
 =?utf-8?B?NWEwRmJBYXVxZXhJWFRFU0MwSTE4b1U5VWw5UTZsMU5VMDBmaExwT2QzNkdK?=
 =?utf-8?B?NFZuUllFZUtzOExJTW5kS2VzNkN6Nnp6eVB3Qkg5VU9xakdsLzdKT0dxRW5j?=
 =?utf-8?B?bFVPT251a3hQeUxjbU4zZWM1NFVOa0NFZ1VNNUNObS9yNmFRSm51THhxTnBw?=
 =?utf-8?B?U2hVT3RsbStZaXBjWjR2dHpuNlR4UjZlZkJKZWQwYmMwQXhOeEV1QmR1NldV?=
 =?utf-8?B?Z2VUUHYwN0FpbW1QaWF1dDdLV2VZaDlKTUhINlppdk8yR1dLSXRQSFJpOXlQ?=
 =?utf-8?B?MVlRbnZXcFRORlNMV0IwVGxEQzErZTZhTWtqVm1ablR4ZXVoOGRab0Z4N0ZW?=
 =?utf-8?B?Q1lqWkM5TWd5bnk2TnlVSzZTV0dGU0dlY0pKUEdXZlhlN1VRSzJ6a1c4NWYy?=
 =?utf-8?B?MUpVR2pIaUNzdlVBTSszelc1NzJXa0J4cGk3Zk9sN21qQ0RzWklxdUV0OFgx?=
 =?utf-8?B?TDIxd0VOaHhHTmQ4am02c3lZTnh6SStESWVCZjFkMVNYNlRhazlTb1hUSXcr?=
 =?utf-8?B?eVJJd1JYMDVlZ2lkMDMyc3YxbzZFQS91Um1EeWptU0dWTUtWREROVzVnMVFZ?=
 =?utf-8?Q?2UCI6hFQ84embgArVxNQykLeI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FqL2E0cUUrdXhnZ3FEYnpXSG5VLzd5d294UEQ5aXlnMjJPcFYrMk55Q1Vl?=
 =?utf-8?B?RzR0VExRdnZJbzZRSmhkNzMvd09WWm1ZbHVKYmFQVER3UmV4MnRGSFNtMXd6?=
 =?utf-8?B?c0d4bVJ5Y3h5UlI3aFVyS3VlN0FUTkx6SmgyMHQwRHNhbDExa1BUNWFvK3o5?=
 =?utf-8?B?eFhwaGJncVFqOFpuUWRKYlN0ZFUzOWZpUTlFamdhaXJOTE15ZXppZkpXV1E2?=
 =?utf-8?B?SmVTWjQvbkRNWFpScjZ6U0MvbWJSTkVtVzIwZTF3c2RyMWFmYklNVEhRdjJr?=
 =?utf-8?B?akluaFJBcEJnV2VZTW5STXhTTnJuRG1OdGlXS2JYKzdHbllodkhRZWpwTXll?=
 =?utf-8?B?aDIxZkNJNTRZNG1CY1ZOMHpOR3pRUndJTnJiQW1id3VudlYvRGFSc1FVUkIv?=
 =?utf-8?B?amdQSFpsL1pxalhpbFhvVmNYMDVVWHpFYUZ2QWFBcUJyeWZkUDlYUjl2OFNa?=
 =?utf-8?B?QytOcmNNOTBId0hPeTNKTEZnUk93MDNOS0w2dnFHVW5VTVBmS3phZTlqR2Y5?=
 =?utf-8?B?czc2SHlFMERhVWQ3N3hpeHZCZmdBWHdrdWdaRW9VUFdwYytTNmo4Z3VXTHdq?=
 =?utf-8?B?QWV3QmNYR2FVdzA4NFUwc1ZmTHdhblhCT0pDMDduazNPaVVuUC92NGhUVitw?=
 =?utf-8?B?UVUvbmc4aXNBS2pDSVpqdCtIeEdIblROV2xHZE9ubDBtUmVMZ2lMcUpUWVJx?=
 =?utf-8?B?N2VxallybGI0RitIOEViQXNBQS9IUVlVeVdOV1Mxc0gzUjR5UVkyNVRodUhJ?=
 =?utf-8?B?TmU2a0o4S1gxeDJlN3lWMzhlYVZ0OWYwdndiNVZ0NmhuRjhXZEdEdEFwNU1N?=
 =?utf-8?B?cHRkVFNaKzd5bVBTa2ZmaHpkSzRZc3REak5UeUJQdnRPTHY2cjBlQncxRTJz?=
 =?utf-8?B?K3lweGd3ZVVMbkdsdEpqVzViVmRqRkl0b2J2UnZHd2hpd3o2QzRqTnN6d1pl?=
 =?utf-8?B?SFlEWGZFNVhmTnM0VkFMbHcySDgwRVcwenNnS2xXMko4REFDdmQvcUxxTGdt?=
 =?utf-8?B?dndpcG5pa1FQNzUzZ0Ztb2h1Qm83WmpSTkZuYTYxNG0ybDFYU0JoTE5kTTRy?=
 =?utf-8?B?MlpJZzMzZHJhcFg3Rlk1SVJPUysyeHlTakJ4aUZBL2hBSFh1b2Q4b1E3SXFM?=
 =?utf-8?B?VEZXZGNDL0pHTHo2WnlZWnI3ckNkWW5XV0dKRjBoa2lmZmdhQ2JKZGhJZXRC?=
 =?utf-8?B?dk8yUEFSZU84REM0TnEzZ1B5dUoxYUZIbUFnSkplaUx2MDEwdG9tVUFxTG11?=
 =?utf-8?B?SkFwcDZ0SGN6OXlSRHN2UUZXMGx5Z2ZNL2JQV2JGV1BLREpGSzkzWmZRMDJK?=
 =?utf-8?B?VldHMkZmQWw5Z0pDdGFBS1lQTUo5VnJxK09hRXZJdTd4QlptTzNrVmh6RWdr?=
 =?utf-8?B?aHJyOTZGbGRid2xzMHBrSHYrRk5PNjJpdWMwRjF5Z09hSkg1RzlOM2h5WWhm?=
 =?utf-8?B?SjhuTjNMdW1QTVFLTHR1VHJDN0N4bWJ1c0Q5VFc5L1REYmh5M3pOa3RLeEtq?=
 =?utf-8?B?MlJIaFJtcytRS0lJZjZXU1lTYzFsazU2V2dTQUNNRnovblRuL2tTRnlEeW1C?=
 =?utf-8?B?U1RQWUl6cjltcXlVbzVRMG9vSlEvR3BRTVV6TGxXMDZ3a0RWWXU4bzZyWWtG?=
 =?utf-8?B?WmEzTjI3YmhtcU40MmR5T0JOeWpRQWlrNGE5ajNtNm5YV3RPWmZBd3VVWDZs?=
 =?utf-8?B?MmFuMHFsc3Fjc1lsMXJMNW5uZFJSaWhpQjUyb0UzQkxtY2wybXQyaURTZUVs?=
 =?utf-8?Q?dkD17FFQshmYKBni1649PgUgkSz9YEdaTjMNsav?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c4e3ea-f560-4b48-fa2e-08dda827fe7c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:06:29.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB8167



On 6/10/25 17:08, Konrad Dybcio wrote:
> On 6/10/25 3:03 PM, George Moussalem via B4 Relay wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> IPQ5018 has tsens V1.0 IP with 5 sensors, though 4 are in use.
>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>> and nvmem nodes and adding 4 thermal sensors (zones). With the
>> critical temperature being 120'C and action is to reboot.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> [...]
> 
>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,ipq5018-tsens";
>> +			reg = <0x004a9000 0x1000>, /* TM */
>> +			      <0x004a8000 0x1000>; /* SROT */
> 
> Please drop these comments

will drop

> 
> [...]
> 
>> +	thermal-zones {
>> +		cpu-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
>> +			thermal-sensors = <&tsens 2>;
>> +
>> +			trips {
>> +				cpu-critical {
>> +					temperature = <120000>;
>> +					hysteresis = <2>;
>> +					type = "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		gephy-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
>> +			thermal-sensors = <&tsens 4>;
>> +
>> +			trips {
>> +				gephy-critical {
>> +					temperature = <120000>;
> 
> I'm not sure whether there's any firmware/hardware measure to shut
> down these beforehand. It's better to have a software trip at 120C
> than to not have any at all, but you may want to try and find a
> case_therm or so thermistor for your devices..

these are the temps as defined for the critical trips by qcom. IPQ8074 
has the temp set at 110C, while IPQ6018 even higher at 125C.
They've also defined lower temp trips in the downstream DTS files.
Should I try and add those? I could check if the driver supports them..

FWIW, devices I've tested don't go above 70C even under load.

> 
>> +					hysteresis = <2>;
>> +					type = "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		top-glue-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
> 
> 0 is default here, you can drop all such entries

will drop

> 
>> +			thermal-sensors = <&tsens 3>;
>> +
>> +			trips {
>> +				top_glue-critical {
> 
> underscores are not allowed in DTs (see:
> Documentation/devicetree/bindings/dts-coding-style.rst)
> 
> use a hyphen instead

will update to hyphen, thanks!

> 
> Konrad

Best regards,
George

