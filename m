Return-Path: <linux-pm+bounces-31946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F98B1B023
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 10:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16563B33C5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 08:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1402512F1;
	Tue,  5 Aug 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="VscHYmxc"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023126.outbound.protection.outlook.com [40.107.162.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CD22173A;
	Tue,  5 Aug 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382065; cv=fail; b=L4tout6TVymym/WHJjrx0BlrWWSIrFEBIsFvMb8ehIJzMCzFi2+PnQAx1hUN9lglERCy83JVMEGHIRRzlCf9v5+DiBNrGqah4TcGcuN7fqsNxe3WwnKRjTmqqRv41meeSL1JSG89fi7Q5biFKTxbdQ0kmt7torDby0PkvbZvRcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382065; c=relaxed/simple;
	bh=hXuoJBbG7z/2orTi7CyapP1w673tiDlAZSXq5ZC5op0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVuvaaRabtjovWzoZ9YrTrdAVyH9lLZvuT9I9V1F8Xx0LapGZpv81RRqnmRsQ6qxC3RWyt88rVZpQQQvrURiiPEkaIDq9003Yw2D9mdDakPdIpwUru1CqPZtrVPCaHMT7HJeZIuw2ec9PWs0pEyi7sguCs1JqI9DChOegyreDBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=VscHYmxc; arc=fail smtp.client-ip=40.107.162.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMOnK0Kvb1lj/TVz4+GUmaL3BZ7Zwpch/cES81zp6IclLSMrtgrIV81ngw6Ut7Z94mSkt6B3N+JKcPVPPmzBKfhOQk7D6ep+17Vldh9zUJzKy+kFilhBCb8DhuswaIS2OB0BeR6bsf8OucParW/JPo8KlRFl34/TR4wu6GN9J5GTjNwzagfnTbHHwMB31STd7kJVYf5xghv49237aG94O7GUZ0vNCH+1uMBaUgiOhBg4Bt1zEnSQGG6zoyWN4R09qtDnjjrkQQelo1zMx7tV+6Q95CT0s3w6hrBi5b7vOVKUlROGCVkHeGdnewkKv4f9zGdNlI1dAcow+lH1a/uZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD9EpZaivAm90NanCD9PITPxQrEU4Vgfy1ahi2/aJ+A=;
 b=Y04BXAdrgY7I/vqSAgdfsvGZgJVLnDAxYr0atsgUkwWRJ1LtdnAht/Rp96fc/EH9vX66wvRcpER0wdtXVVIpw0QVlojHASmG+gzhiZjduZ+cP11jAZCHzHOqhB25zyYtqun5Qzf3ZvsxF5g0c91+VfNg5lMV9RGGYsLeVMFOK/B2D0bomyxa5oUG5yaZBMHtvmVTpB9Leooa56MRZccs32jgnjyrmcF8+HihuN34P/LEww75h5juNGoGYSlovAHLReprm7BDa6K2R+ZZ0ZcD6R9Mpqa6CL3juz5KopA7LoOmER7DdqB8QI/lUtsIQZzDERgyFZdYnu15/DNFoQtwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD9EpZaivAm90NanCD9PITPxQrEU4Vgfy1ahi2/aJ+A=;
 b=VscHYmxcAYuTohcrnDTEBIBK5hM5DX+p8VDpcQvdaLejR1xwQUnjZlg0BU6QpVfQ6L5IEzNDFgKTylHg55zt6jf5b/B0Z0K9M76BwVCV2QvsqlXauh+Do0hWm97IRd7ndMYTzPq2Lqlnv2ca/2h0jCeAMGoF7YEPyeyn7zmkGPOAHoXwHrHQhBB/QSFipZDZMMV4sS3suFT+6nLlhGKjtrEzZz2gNmlCURHS/bImxBc6vI7Z4v9n8T5yaqQvdNm1hUqC+tnqP7/o7+hbx2xr7pAZi2xvWEVg4qDruAOXwfq7D/bNrwfaIZqOAQMOYD8w2WP/+5M8fIN/GS4gbvp45Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AS2PR03MB9491.eurprd03.prod.outlook.com (2603:10a6:20b:599::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 08:20:58 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 08:20:56 +0000
Message-ID: <e63913df-6808-4822-a3a4-870b650f10d9@uclouvain.be>
Date: Tue, 5 Aug 2025 10:23:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] gs101: MAX77759 Fuel Gauge driver support and
 enablement
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
 <42de1ed3-073a-4058-971b-a9a8c473d9a0@kernel.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <42de1ed3-073a-4058-971b-a9a8c473d9a0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::10) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AS2PR03MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bebd21-d4f9-425d-6714-08ddd3f90095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHY2bzRsZ3BnWnhRc2w4OXlOR3NPYllxN01KYmhRbXdQK1B3K0FpU1FSUXUv?=
 =?utf-8?B?ajVOTUwrOG1yeEVJbE9YLzBkTmpzbTNhNDI5QVdUdnB6eEJ4SkdIUkNhbkpH?=
 =?utf-8?B?SXZjVUpnM2RJdVdWQlozOFh6a2pLb0xqb1E3V29VaUdieWhuSjRKd1lxNTBG?=
 =?utf-8?B?TjNIN0swOWQ4cXNUN2JuMkpSOS8wMlRiWGU5aVFHQnlDeUdFL3NvSEpxdUM5?=
 =?utf-8?B?aTZJMFJia0UzVGx6YU9Sdlg3YTJlcDNFUFFxOEVqUnlwUEVqeWxvU3Z2R2tE?=
 =?utf-8?B?UTQ4bVVhTmdIa1ArR1BZS3Y1M0xuV3locmg1QlFHT2RoQm5VYkNJYzR1VkNu?=
 =?utf-8?B?T1IwSUZ1WGZpSmZKTzRTR1dPaVdTTjRxSGErcVRObVRSQVJyMUo3K0dSMWhl?=
 =?utf-8?B?S2lWMnRWNHg5NkdvcTZ1ak52VVVsbW5rb0ZIVEpXWDVmVG1wMUtDUEVJdHhQ?=
 =?utf-8?B?Smx4b2MwL1lyMjkwaEQwK25ZekN0RkJ4R0dZMWdpRXltbStLQi8vZGZ3K3RJ?=
 =?utf-8?B?MUk2TUZBb0NSWFZpYkJaU3hKNzVURUlySVhPMW8zeTkzdTFQbDZpcU5JZlhv?=
 =?utf-8?B?TDh3eWk1KzF0L1dETXRKYVNyYTVWSld0Nm54U1hWdFBkVW1FVXlweWlnY2kx?=
 =?utf-8?B?WTRjNFdlVTE5Y1RVd1JybDRtNjdiS0Y5ZlNGZmpxM0Nkbm0vcnduU0FmdjN2?=
 =?utf-8?B?UkxOMDNaamxidTFSQ2Y5a0VIZUpwbWd2WkEvSEdpWFArSlZCd0tOcGJUazly?=
 =?utf-8?B?S3hXQUQzQ1pGWjlTcVNjQ3NGVEM4TnVScXFzMjZtWU1zcDQ5QjI0UUZGdFM5?=
 =?utf-8?B?R2N2bzlwL0Z3UUZYRmtqZnVjakdFWW5PWWoxQWdzTHp5WHp4NnhpSzVOQzNq?=
 =?utf-8?B?R3l0ejcwOHgyd0NMckdLbnA2dlkvVTNGYWlmRDZjaFQxOUN1MVBlLy9sSHlZ?=
 =?utf-8?B?blVXWHNoRmdrajZwSHExdVVJOUlkRXB5Q0VPc2h3MnppMURGU1RHT01sU21D?=
 =?utf-8?B?dU9TdnJLOS9FOGpjckZpeFBsR3VYVlJHNlZISFNUUEc1Rm8xWjUyWFVJOVVh?=
 =?utf-8?B?NzBqdWFOY0F5akF0U1Y4WC9nWnV1VldBcnluK3ZCUFk0V3BJZXZPUkgrT1Rv?=
 =?utf-8?B?dkJDeVVyUWVHbVZuWDZxVWNETWRGbEMrR25WbHpVa1ZHUVBSS28xV0JUTGVW?=
 =?utf-8?B?OWpoUVpVMW1jakRzMEpMR3o0Z2pOazk5ZG1yMGFrN3dPZWdYbk1mN2JGaHgz?=
 =?utf-8?B?UDY2Qnloa1RLKzJQd2FSd2RYVy95RXRoQVZWenRaMTV1MlRJcmRVckRwY0VG?=
 =?utf-8?B?bHVJckdBNkQxdU9KWnYzMmxLb0VMK2xld3ptSmZhQ3dUZTdmcFlsbVB2NGpL?=
 =?utf-8?B?dFRWMFhUTTdDRjFhL3RNbms1Z250MzJFdkNVdEEzZHhsZGpHRUtlWUE2aEVO?=
 =?utf-8?B?SGh5cERqWWpjRjJJa0VEb2tTZm5kMWJFM0JQbldBY09mdHNyck5pQ29nV0po?=
 =?utf-8?B?b0RRdnVaSVdSeGtVcXEra0JidzdwS29xNy9HR21zVmpRM1NNVXp5YnFuUUFJ?=
 =?utf-8?B?MFkxclVCc21SUmtJV2Z4OUZzQnJyeE1aRVJvNDc0ZTgwdnQwbVRMcURsRE8z?=
 =?utf-8?B?TjJhZTlEYTZ0dzdvWWljZTRUWkQrWnRzWTZJeEZGL3MyRVBxUWdtSEVQZjhG?=
 =?utf-8?B?WTF5c08yTGpJc1RPem9NWTVycjdkNFpUbHNXc1pvdDF2bHBGbXh6M1lNa1JJ?=
 =?utf-8?B?dDVFUmlMV0JjNEdkNDk4YUVkVlhOdXMvWWRBcnI1bStlZ3RDdlVxUjRCblJt?=
 =?utf-8?B?WHpNclk3RUFhMU9ZMGk3ZzNOU3l1T1diZFlCTko4VHhVSGxHOWNQc2Jpemd5?=
 =?utf-8?B?K3JGYTBoNDZ0cHZEN0RYT1FsMUtBekN2OHVYRXdONERWaWUxV3FVcFpodWxG?=
 =?utf-8?B?RnptTmh4ZUlIbkU2d21UaVppOUFvcnAzdlJWZC9lT21Nb1pKOWx1NnZWcTRM?=
 =?utf-8?B?TmZNVU42QUd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUZrMS95QTFYY1lGMTBjUFo4dWRvYVJ1a2E3ZDU0LytVcVZpalh0dmEwMDlr?=
 =?utf-8?B?dW9Ud2JnTjRCNk1JUDhMRngwdWNOMEN1NjBnY1ZucFQ5NGIwVUl2Ulc2WFBY?=
 =?utf-8?B?MytmSnNYQks4VjNHWEtLU2xiNnh0TjhtM3pWWUpHamhIMmdBcS9GZjhud0JQ?=
 =?utf-8?B?amowOHBWUUkydDlwSFBOM0QvNGowK1J4aWsxR3lqTzdvaGd3Q2pqL0t2TVdZ?=
 =?utf-8?B?d3hhbTQ4S2hmTXBHRXlTSk8vamxwYzgxUng5blFjbGJyMXQ0djRTc2xDWlNa?=
 =?utf-8?B?dmN4YVNOYjN2Vk8rVEJDS0p2SWVJRnZuUm1lRXZyWkY0bWZXUVB2SFk3Y2Ja?=
 =?utf-8?B?TC9xdDNXREkrSm9CK2kralZCbGlkZm1wbzNUTi8xaDBLajJJRVZNYWFuVndC?=
 =?utf-8?B?VjFka3NDV0U1bmVyeXhEUTZXanJVcUIwbnJ5blh3dy80a3phQVFscFpsdjAx?=
 =?utf-8?B?T0dndTRUZmVMVzVPKzBOOVB0emEvdzViVDU2eDdqRUorUUtnT0RrNkozWGlG?=
 =?utf-8?B?TFFnZnJNSTI5bXVxU1FKV3p4bUp2NENSQVc3emh6MXZHcEtsNUROVU1abGtM?=
 =?utf-8?B?aGdtT0x6elFFVEJCK3BCSTVJVFRLTExMSzY4SzZMSC90YlNYWG4zNCtTWWZi?=
 =?utf-8?B?dUhHMzg1cHNCYXdLT1RnQkVCQmpqNWM0TVM0Q3dSU1d1K0kxcmo0QmZFQTVv?=
 =?utf-8?B?d2ZQQ1RDWFRtMVdDamtDaHFnMytTdktZeGNKS2loOGNxR2wzZUprMUx4N3E0?=
 =?utf-8?B?aFVNcXFmUVhjVXR4aVpHbmtjcG94TGRjK3YwcFRtR0M2VFlLTjVxekl5TDBF?=
 =?utf-8?B?SUVDR25JanFHWVNydEFFZTk5SUxpM0VlU0t3T1JlaC9EQ0FYT3VxZjVCMTlm?=
 =?utf-8?B?UlU4Ri9xcHZZQ0R3aWdEckpRWTlHSjNucjhNRVFUOWxJSnNmSHVWNXplUnB6?=
 =?utf-8?B?K0x0RE9ZWmF4M2tud1dyTytQOGQxYmxLM0pYVCt4bGcxa0hLazgveUErcWFH?=
 =?utf-8?B?dFg1QldrOXdNUXQrRXVya1NIWmxrSGF6SVp3SkY1bzVVUitLR0l5RHo2Zm0v?=
 =?utf-8?B?Y3dRcHQ4dTdNNTdld09SMVE4SEl1SFZyNU90RTBTeE96M25idUxzUXV4R2Yy?=
 =?utf-8?B?Q25hU3N5SG92VnRpMHIxQURTamJReTRoaXRhTC8veXFrdG5vejRuTG1lcnJM?=
 =?utf-8?B?SVh3eGhWSHg0OHhsRTcwSTVOalQwTFVpR0hFR2wyNkJSQWhSTExYY0dxNEZQ?=
 =?utf-8?B?RWhlUW5oamtydEVTTXZjODZBdW84T05hdkxvNnVOMjlRSkhrUDd1NlFPRTlE?=
 =?utf-8?B?YTRIWkpsZVZ2aFFaeDh2Wm4wUHhIRSswcTh0UUJ3VkVJR21ZOWJKaXZrMnFU?=
 =?utf-8?B?QlZIckhvMjBZWGR0WGd3WWRDV3hqMW1xTm1QNEtGWXBiSGxCUlJ2ZVVEc2xQ?=
 =?utf-8?B?Umk0NmhERVgzSER1eWJOZldrcWtIYk9ydEQvWTVhR3gwTmpzU0YwSVoyMzdi?=
 =?utf-8?B?NjVSS1ZuZFRTSXVzendGVjIzRzlMbVlvZlM0ZlRwSTlKeEdLSS8wOTJuZnlj?=
 =?utf-8?B?aExtYUlsOGZHYUNMem9SaFRyZGFzTUkySktCNDQ3ckJXZmhnNVM2d1JZdzhu?=
 =?utf-8?B?SXJhSU81U1RqSEJySk5WUy9BS2MyM0xyN1RBS1hpc0liTzVnR0oydmJMUW1L?=
 =?utf-8?B?T0NWRy9jeU90RHIvVlFKWC8rSlZUMElFUEJqUlFqZHNmM0p3T2ZaQkYxMVdo?=
 =?utf-8?B?VG1OeU13Y29SYk9ha3FmWEczRkVLMFhGU3RyaTNkWEJybjZUOEVNVTNqT0VZ?=
 =?utf-8?B?bkRiV3ZYem1TcDFWU283RlI5REpCc2hhQzJZd2lOWFBVR1ZKMDQ1RlE2MlNR?=
 =?utf-8?B?OWwwK3BFMkFIZWo3eVE3YjdSbTF4cWhaL3hMME5iWmJmREJtSDMrMmVJVWUr?=
 =?utf-8?B?Vm8yS0t4OFIrcTNhM1gvVjkxeGJEK01uSzhDc084VkhrczNlMEN2czk0dzJs?=
 =?utf-8?B?UzJTeElmRUl4N2F6T3JBM09WeFJKYUJuU0VCTGNTTExkL0tTN2ppSmp4V2Jq?=
 =?utf-8?B?R3VYWjJuVTJYa0k3a3p1Rm1aRHhFR09zRlJsKy9ZMUNQRSt6RVNld0dvb3V1?=
 =?utf-8?B?Vml4Z2lIQUlqUklCMm1Gb0xkUUpla1Z3YzAvOGNiWlBQbVBMdHFNWEFLTUxG?=
 =?utf-8?B?bWRlSUdKVGMvTHZPSE1MMyt2dCt0NUFDeTBmNnVPUU9YQUNtdDBVZllxRk9y?=
 =?utf-8?B?WkEwTDNEUUc5UUt0OGNJT0ZpYzB3PT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bebd21-d4f9-425d-6714-08ddd3f90095
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:20:56.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgPYdK/4bd+IALGkdZCmaH4oA7g0YF33G8hxYzp48lMdQHp3I78viocPgeR9eMnkZtB3zI0YA7PmFCCx/5xq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9491

Hello,

On 8/5/25 8:20 AM, Krzysztof Kozlowski wrote:
> On 04/08/2025 16:26, Thomas Antoine via B4 Relay wrote:
>> The gs101-oriole (Google Pixel 6) and gs101-raven (Google Pixel 6 Pro)
>> have a Maxim MAX77759 which provides a fuel gauge functionnality based
>> on the MAX M5 fuel gauge.
>>
>> Add a driver for fuel gauge of the the Maxim MAX77759 based on the
>> one for the Maxim MAX1720x which also uses the MAX M5 fuel gauge.
>> Enable it for the gs101-oriole and gs101-raven boards.
>>
>> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
>> ---
>> Hi everyone,
>> I decided to completely separate the MAX77759 and the MAX1720x. The
>> reason I had just modified the MAX1720x initially was because I
>> thought at the time that their difference were much less important
>> than they ended up being.
>>
>> Their common parts could be put in a common MAX M5 files which could
>> prove useful if more chips using the MAX M5 are to be added.
>>
>> Changes in v5:
>> - Separate MAX77759 from MAX1720x for clarity
>> - Remove voltage reporting
>> - Add initialization of the chip
>> - Add device dependent initialization data
>> - Add access to eeprom for access to non-volatile backup data.
>> - Link to v4: https://lore.kernel.org/r/20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be
> 
> No changes in the bindings? There were errors posted due to lack of testing.

The binding has changed a lot due to it being separated from
the MAX17201 binding. I tested the new binding and found no error and no
bot was triggered as far as I know. Sorry if the changes were unclear.
 
> Best regards,
> Krzysztof

Best regards,
Thomas

