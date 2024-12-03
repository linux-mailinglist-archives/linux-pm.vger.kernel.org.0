Return-Path: <linux-pm+bounces-18438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1489E192C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB2028752F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABD1E1C05;
	Tue,  3 Dec 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="MerHWp9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2090.outbound.protection.outlook.com [40.107.20.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A6E1B5336;
	Tue,  3 Dec 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221470; cv=fail; b=W2xcfXTaoj/FT53nFo0f6SH7CLJ50YRuc91x2A6VNqSIZ3UfBJMeTe/RdbLTNGw3Igs1Cu5ZvBPm9L3EKDGi0Cjx4dWtVvR/CIFLGUPSLA/DGxExjTm+7Obqq2MVuZ8sg5/m2AhsBWsyYfG40JxRhLwsIu8nRT9k9vLveeQoz+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221470; c=relaxed/simple;
	bh=s1IAhiKAMfbV4V4cE1v1AIGpGWnBs4ZWUSI+lW68Mhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sc8CULlxLeuG4qBDSiuwe1DGoH+WkbF8GnZcZJki+6a4dABjrGJ+d0bTloF0vxtO8PvL1d2GcY8FWfssqPBD3hlHx+MBByU/IC6JB1ue9keBouz5QvBhfoZd8B4PjNUOzQd/O/3lPgID4Zmq8Z96vdrslNVOTgZJYps+79uEZ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=MerHWp9T; arc=fail smtp.client-ip=40.107.20.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMb0zJnGVUAhdvwHgwUa9fhCqbKtUWIusAkxAePowy8qQA2Eg9/dyZZ8cctIdYzRoQZRAOMhAtgpZp2no9MfWOu80Wr+RnoF7OEESnyRWs7GZ/GkmCXTvAluBKEK1pOXFcfwjNSnd8RcGiGRsw/JImiXnVa3ZArkFHiZ9oiIRmsaG1DzOsPKltBOLc5xlxw83FTE/u9Wa8ia5sClyW+q5arjJGmf91pB7QLABwOXpDTriXJaG1GLHHHmXYCrZ7X7sNx2U9Mod3Lq2k7AYAHw9snODGf8pt8TkurDyFhLJINHvL3tjTNNiqGHbbCXP2kwC7juEFgrepVUJpo82fnkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lms3eAQIvFdZRyNDCU3C27FqLFuhMcPmxckF36LATyc=;
 b=Iv4+xlV19AN5dCJk+22kStkVtBYvIvecyKeI2UjRZ4DwMjDM6fwK+8t2CfuRK1ZrNwu1+r856jdOxkGJuW2FYo+nPowluB007LydBCb2pzJn8VZ21xFCUB0igz1653xiVQGTz/pFpTV2BY5uxrJkMCkAu/GfQk9355CvxOi59t+q3a6Lb32yQ7Z146XIqKdJ3xLVHlqdcEjAW04/aKRYC/rHOj+0YAZDkDAEH1no5/JpydwFvf4nLEMPQ7UCDIaTw9Ixup9OK7SDGC4f0ivUq1SRfe/WXx6RCbVy0n165Xl/VkCO0umoSoXma/xKx53dR/2hDteTBzmdUcQahadLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lms3eAQIvFdZRyNDCU3C27FqLFuhMcPmxckF36LATyc=;
 b=MerHWp9TTss/BythT+DtlZ6VVfua+F1uG7iDYtavId34WvGlzsnqD57GYDKRYhe1ZVzVIYGfCMy076ntKDD4lJF3GJINpJRkghUY/qGIi9kHkOhYMB/qfmbw+5vePBkUiylQXLAdjhoZqlL1tfMDISAUHTRWR2NHTYVyqaAx0BV4k7u/kBo8YOYhN1b1rjcdjh58iPOCBA7xUjJBFhMr9V0ZHNKls6ElaeoOaxvR5IMhbQnwp6WFSWQ+jEAqGKCFMUotDkH5O88D6rX/e11p5nwt8fDIc7/PrWbEyKtL4/FInzAXj1QOB0BEilBNxkNjMlPv0TMSn7461N/LcPfLow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DB3PR0302MB9064.eurprd03.prod.outlook.com (2603:10a6:10:428::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 10:24:24 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 10:24:24 +0000
Message-ID: <575b3275-b2fa-4e5c-bb6b-759394b02e18@uclouvain.be>
Date: Tue, 3 Dec 2024 11:23:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
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
 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
 <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DB3PR0302MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db1632c-b56f-4e23-d966-08dd1384a85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUVUdE9KMTBkNWFDR3NuYXJPb0lzVy8vWGZZNms1amJuc0hpOUFZL2t3WVhH?=
 =?utf-8?B?YUF4MU9PcHJ0Qk1qTlhsK2t4bG9HYUNxQWJHSlpFd3hiaS9CVm04WFNHY2N3?=
 =?utf-8?B?NkpDRGQ0RFZTYitodzZmMlRoY3lSai9DZk1ISU5Db0VSMEZUNlFtUjZLLzZG?=
 =?utf-8?B?WklwM1JZZmVqZ2dBMEgzd2JvTGNqTHJNa2JqUzBFbzNFK25rbTlTNWRVQWJ6?=
 =?utf-8?B?SjcwTW8xU1lHbko2Yi9KNXEzall0c1ByS0hPR0lnVUZZWVU5dUZ4aThGaWIv?=
 =?utf-8?B?bWp5RlRGQkNZZW5iUjNpWGE2MTk1dGRVREZ5ajhKT2FNQ1RJbFRFUCtrSzlS?=
 =?utf-8?B?cjRtZ21vbEdGNm5XTXU5R0lxYjZvc3EyL3duT21NUkRlN0J5S01nbG96ZWxO?=
 =?utf-8?B?eE4vcDJMUzRnd1pZWGZBSnB0NjRoSnArQWJZSnUvc3FBOU1WSWZHTGNOYk5M?=
 =?utf-8?B?Rlp1TnFyODJTbnRXeUFTSWdRUHhRUEU2dkpLSUR1bm1Lb3E2QkpURUQwTHcz?=
 =?utf-8?B?U0ROVjR0cmk2YXNjVG8vNlVRM0lxR0NnRGU5dkM3cHZ1M3pUNnhHSVFwMGtt?=
 =?utf-8?B?WjNKLzZReks0cFYxWlpqNmJROThDRHRrMXFFdE9pVmZ1cDFvbzhGejU0blBX?=
 =?utf-8?B?QjFwYUtGWVBOTUhUcDB4VStQRjE4NmsrSC82UWlMeHkyWG5YL2xPbThVdFln?=
 =?utf-8?B?Wko5WC9GeEdwdGlORTAvVE5nNVM5MDJyZHlZS1JLT25LUktRcnYxU05vSnNJ?=
 =?utf-8?B?dzF3R2FQbWRudEhRTXMvZHVQekdmLzNvV3lHVXhnMXlzSU5FRlA4VVhVUXBz?=
 =?utf-8?B?SHVTNUpkcUp0ZjN6dkhzTTJLa2U5UHh2SG52MzZWYXRtSmF6ZUpPVUtoNlBv?=
 =?utf-8?B?Tmc1SjVVNUs0VW9PbWQxb3JrVEJ4ckNrWEVWUy9GM29sWlU1ZjdxMHFJUzM5?=
 =?utf-8?B?OUVLLzd2SEFRK29CTFVNWHk0SVRDdkR3Z0JSWGFFSFJ2TWo0OWFrYzJIOVk5?=
 =?utf-8?B?dGdCSzl1b1lMbUJna2tIeFFNRjM4NllLQTE1T05QYm5KMVJBS0JTQW5YOUdJ?=
 =?utf-8?B?YW9DVksyOEgvYXNwaXBaTHM5cVBOVkxYanJyR1BXVEJnZENxMHpFcUdjVzV5?=
 =?utf-8?B?TlNSYWNSTXZEK2t5Y0tmaXhiait1cmU5YjBCZENHbjhEQm1kUVMyWmc3M2Vl?=
 =?utf-8?B?QVMveFl2dVNwOTF1TTVCUUZGeFdSaTdxYkZ0MTY5aVQ5UmU4eiswOUFRNWE5?=
 =?utf-8?B?K2hkMjgwdXhMZ212UlROVEF1a2pSMysyblllemlmYkdrdDdpVytKdnlTTzhY?=
 =?utf-8?B?R1g0RHh5RVFBU25mM00yaHYyWEZVRGFMQWU5Tnd3cnQ2a1RUYkI3bkxVNzZY?=
 =?utf-8?B?OERRVXRvaStua3JtMW1NVWhOY3phNDhKaVp2YWMzWVVLTFpZZ3Q2YXBiSmxm?=
 =?utf-8?B?cWxOK1lER3Fab0tWajZmdWNrYk9TV1B5V3dsODlDUitrNTBOQjBrZHlMdllE?=
 =?utf-8?B?K0lTczJNdVozbFkvYWRlTEhBSng0MHArVU1YREFGdFJEd2dRYU9ROTJwYzlp?=
 =?utf-8?B?cG13RE5ZU0N6aHg2SlVOSGZEaWlWeFVHYmhSUmZkYjgzWGRFenFxZ3lWUzVB?=
 =?utf-8?B?Nk5RUzJCbGwxVnAxd0pGakRhVmJySGpnaElCd3NIM1gwNVowRG5Ybk9hVWdJ?=
 =?utf-8?B?MkQzUUhyQnhhMExvZ1JaWHdHRjh6ZjAxUWpDa0xTalNHV2V5SHNWRkpHb3JR?=
 =?utf-8?B?Y2pYUXdBWVpieHIyZ0FpbmM3bWJCV3l3b0NaZ2FqL09vaFR1Sll4cit1eWFN?=
 =?utf-8?B?YnV1SmIxUktERTJWV1BBamcwNEwyWGpnZkRNa2dhK0J0Z3Z4NkhhTmI0Y1ZQ?=
 =?utf-8?Q?67kEcYrfP7jLl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0FVTHh1dXZTdC9jZnBRN21DTkZialZaU3YvY2IwMjhNTFhJdDdWc1FFU1VB?=
 =?utf-8?B?YmtROHdiaWxMK09xQzNiR1FncytkV245V29Ld3RwYnVOb0NiNHBja0JZaVVF?=
 =?utf-8?B?Z1o3bnpPeFZnWHNPWmlVRWZBUVY2TzNPNEw3ODRyK3cwZ1FYVUJCWFFLR2Va?=
 =?utf-8?B?VHlyY2Y1cVBBcUUwSlJueEExRlY2RlNDOHMxSXk0UmNkSzZVZzRoSERrSHpN?=
 =?utf-8?B?Z1cwbHo2ZzZvRWZ1blpaOGUxdTFSTDl5TDZkYTJ0ek1JVTlaeXRHVDAvWHZp?=
 =?utf-8?B?UmlNanphKy90WWM2akdTY1JtVnNEbzFQT3JXUjYyelVvTkRsRXIvTzI4UVRY?=
 =?utf-8?B?a2ZmeEw3VkxQTy95L0JEUnIrVEZiV3pHcDRRT21QQkIwRU9hbGVGcXZyRURM?=
 =?utf-8?B?Q3pnTGxBVFZFVG5BZ0V1RFltYXdkS1I5QVdGL25DRXNiclVRczBhZGtLaDZP?=
 =?utf-8?B?WkpwbkNub2RyU3NpRzdaMko1L0Q2M2lxSVBRbjQzOUFtYzdQTTdYTE1pMFdF?=
 =?utf-8?B?ekpLUXV1WC9NcnRnSlo1cFBuSEF5VHZJb2x1TlRSWDhYaEdDTW9DZjZhZVhI?=
 =?utf-8?B?K2dNRW84NzdERlpPL21HNk1CeVBnd1BqdVZBVWlCL3BqV0c4Mk5YNG1Ebk0x?=
 =?utf-8?B?VlV1dUZWaHNJbWRhRmVLQUE2RGRicDNhYjFtSlUySXMrZTQvSHRzYW5jK2Vq?=
 =?utf-8?B?RVNGbVlnYnhSaUQrZ202ZXhtYlpVWkZQSmswQjNvdGZveDg2N1VJUFBudEtI?=
 =?utf-8?B?QmRIZlhpVVUrbnRxVVE4RWZUM1pkUFNVdm9UZFZ6dlZ1b1h6amYzM0wxQmc3?=
 =?utf-8?B?RHQyWnlRQmd0MzhHVHFpU2F5c1hRTDBybDVDYm9sRnVoR3B0bjZLNWd3WWUw?=
 =?utf-8?B?NEcwQWRVeFJlOGZVM0pITzhlTkg4VnFxMTFlRFN1d0N1UGl5WmJLbXJpMjNa?=
 =?utf-8?B?dkU1Tnl0UllZZGVqVHo5WTNYb1RLRGs3WWo3ZnhRMnN4TUcwUUg4QXAwbDAw?=
 =?utf-8?B?Rzd3aVlhblNPMmFwdjlLMVppcmZrWWlGNHNoQStxT082RkR3U1pLQWJPWmRE?=
 =?utf-8?B?amJhOFZ2VkhTMjdDQll5d0daVmRuZUx2K2tqUVU1dGlzSVdCZ2svUXNHR3h4?=
 =?utf-8?B?cFdNODlKZnhXajh6Wkh2dzFJUk9jT1gzdi85ZkNUQ2xRWkdUWmNXVmJpOE1M?=
 =?utf-8?B?ajAwd1oySVI2cjdQTkNHYStQQmtxaTdLSEFDZmEzQ2c5NmxiVWpUMFZwY3VR?=
 =?utf-8?B?cHdBSlhiVU9XN05lTEFQVm1KYXEzbzNCNDBjLzY1dk9SZ0xia3dLOCtiWTVT?=
 =?utf-8?B?R0VBQ0xadWx6Z0xJbEtSZnFRNmdsdlNtTTRjaHN4NU1SS2JHWGMrZitpaUIw?=
 =?utf-8?B?T29HK1d2S1FkYllJZFhhVkZQRHBKYVQ5Z25udlZwUDRRNlY5aUF4ZEdQaXVh?=
 =?utf-8?B?STJBYm5kMklvUEZQYlUzbEdaQ3hwc0xTN2psK2FER0R5bWdCRzBVUEtBR0dI?=
 =?utf-8?B?Yks0b3AzVU5FTUFJZ3orSS9KanQ2Q3lURTJvQTc5eWVhRUl0Nmg1QmMrY0pN?=
 =?utf-8?B?YlZOYmd3dzBZRlFVb3ByNXBOeXp2RzZOVFljVDZpWXlYdSttU1U0UnZ2dWNn?=
 =?utf-8?B?TTl4My9CelpLSUt6Rk52bTFaSnpGRkhOQnhXSVFaYjlNZ2VLUnd6Zzl4cmF3?=
 =?utf-8?B?eDdpNE9XdjM5dFZSMXN3MTlJUTNvS0Q0WGRpN1gxSmwwOHFpb1doWm9mQUV0?=
 =?utf-8?B?MzE5a0JFb1BYUG9rY1F6OGd5NVdYOTZzUWY0WWRYTDhBVGc4bXl3aUtqYkpo?=
 =?utf-8?B?YndzNHRYakFianRRSmFrNldQUFc4MEJZVzJKTm96RzhlZW9MY2FzYlFDM1d1?=
 =?utf-8?B?RTFjdk5wRXdyeW1hdFVkalJXK2FXSGFuQjRldDFxUE5MSHh0RkE0WGNiN3JJ?=
 =?utf-8?B?TlM0VmVGQ0JGY3lDaFlDTXBLdEhKZ2tnZTE0TzZCbEV2cFZhUmFFVmRtZk9t?=
 =?utf-8?B?L1hYRWhqRUxwRDkwVW5IbTYzWjhVUDNsa3Zsa0FFM3ZoakRUNDFnT1JaUlR6?=
 =?utf-8?B?VGx2NUNabERjVWR4WEUzdHY4Rjc5eGoybkMwRlhkRDBxclprdUJxc04zSllG?=
 =?utf-8?B?c0FpQVpvVUdVdTRuZ0E2ZFh2eW4zU2lvNS9XSmdRbCthNFByL3cxaDR6Smlu?=
 =?utf-8?Q?N7ximnP8ofJ/Hf9UU4Rc6kFfEY9gWLKmTLfwFYcqiI6k?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db1632c-b56f-4e23-d966-08dd1384a85c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 10:24:23.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LO6TtyukR09RaKEBwNlh8HnqT0FDPtpcwSVywnf0zM4yV2ASQI9wlJIEL1tnvsgVgNp/HPWdtpYG8YTYpSTEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9064

On 12/3/24 08:12, André Draszik wrote:
> On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> As the Maxim max77759 fuel gauge has no non-volatile memory slave address,
>> make it non-obligatory. Except for this, the max77759 seems to behave the
>> same as the max1720x.
> 
> What about the battery characterization tables? Aren't they needed for
> correct reporting?

I checked some other patches which added fuel gauge and other bindings and I
couldn't find such characterization table. Can you point me to an example or
explain what it should contain if there needs one?

Best regards,
Thomas

