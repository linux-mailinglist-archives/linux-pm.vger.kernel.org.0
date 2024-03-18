Return-Path: <linux-pm+bounces-5071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733487F03F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B066F28452D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC056477;
	Mon, 18 Mar 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="V1zcml61"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2DB5647F;
	Mon, 18 Mar 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789134; cv=fail; b=EhdfQuyH/jLKNzKY6y45NYxU2phzFH7/KKouMguw7iyr8z2RY/Y5xPwshc/awatMCxetmd4sD2MH7EBVP43UWiTCI2P62BhKOxGHWtEV1FwxIlKp6jo/z8JtUOKi8zsJ5Prz43rW4MkwKYj/cSlDIqFK0BqQLJfY1T0kSUXwnr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789134; c=relaxed/simple;
	bh=TRqYiPj18U/gPqdioQFKJe+ZcbbabQxyqiQlOOmznFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbWcofoexCYFlUsqxF+w8hd8DfXlT0l4SH3imArWHJJCiwCB/YS/bmLipWueMHmxpsBDBNjhThGZuaqy5dmS7l7EoCgndw7dM2YO9EEfBOlayXq5PanAL1PEXp7r0P9uNpUmwh0/Kj9e9yC2LoVOv7WdRHKy2Ry0b7C5wuqiKpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=V1zcml61; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I9gfcR010955;
	Mon, 18 Mar 2024 12:11:46 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wxk77hs10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 12:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktiy+ZgBJmyOxIi1Az0qoJdMKqCrAWtRexeUNCRFeG7txkoUTetxZv5vYFDuVlinxdbAfYmWl84HzmzUmFWijelasEWqAC1kvJvY1yaaupxlh/eXSPFwvbH+rVdU5iJoWKsirwhsKdv6xdgnV5qtFEnKsO4FokxGllx/07MwgrR7IQzgaAArmEfE2k8P6ViUqnlJmClkxQ0JVIdVaOjb58nFfVwvrly+qg8x9UnaAcX9/yWLK1e5VzvyYYKyL0Dhfi3IGjm0cHTB689axw8i/79ae9vQrmT1mmgrtTciprGF5FreynJMNfPcjxS2ojtspb118EDgi40rVbgVWAA5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYYvLAucVmtdCB/OeFagG82yvEcG17jclp9/MH32oqg=;
 b=lbmWwiUgOwW35P0vQDZG0SVpr4rB8w/UI3HZd5ZtEUhxb/yXVNmyk19R/dJiNKN4SW0bWwTEJuAVjzxXcCO1QMfkx3isLxCE+CNG4DH+Xq54mj8VV3Y6RJAsd4CKw47m6Lpp21UAorLW0EYhgA2keOjRou0Ugtquvo3zR0c2omdeO6MMbq6InLq4gibiIHkQd0cEvUQaanU1H5PMxXekbcKWKevBLK1sCnf4nFriChKw/Nx9k4u+r2cGTCJUPpqESn+g5FjzpYM7Sd9CmeKsJjeOFo/bVkayB+Cpb7FN9xvSq5KiyDfdWW1InvUkZf/VlxudL/EWcKFFxichsDNggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYYvLAucVmtdCB/OeFagG82yvEcG17jclp9/MH32oqg=;
 b=V1zcml61pGe+6hEiCVMhFx5M0UzAilLZswqI0u0n8xnoBgJefI2ymXBVQBk1sc0Rhmh0G7uhOIVDDJUk4c72GpgCODlWa9kERuprAZX0Z4yU402Hu8egPNXeH6n3z8RQAdEkmUn0k4Lzl/oKThjCRZdo5V5APKFTvTZpLyloGx8=
Received: from SJ0PR18MB5088.namprd18.prod.outlook.com (2603:10b6:a03:437::9)
 by CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 19:11:43 +0000
Received: from SJ0PR18MB5088.namprd18.prod.outlook.com
 ([fe80::856b:425a:817:23ab]) by SJ0PR18MB5088.namprd18.prod.outlook.com
 ([fe80::856b:425a:817:23ab%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:11:43 +0000
Message-ID: <8425a1a2-8453-b705-2c14-a846fa05ae21@marvell.com>
Date: Tue, 19 Mar 2024 00:41:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXTERNAL] Re: [PATCH v2 8/8] arm64: dts: allwinner: h616: enable
 DVFS for all boards
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin.botka1@gmail.com>
References: <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
 <20240318105153.2c666647@donnerap.manchester.arm.com>
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240318105153.2c666647@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To SJ0PR18MB5088.namprd18.prod.outlook.com
 (2603:10b6:a03:437::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB5088:EE_|CH0PR18MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c395e5e-1b70-4e30-85c4-08dc477f3f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UUdldwt4AZuO+VpCMnR7ZC/f2Xr20UlwdHrl/09hW+Z1ybglYllxgTtGiB7gA8U1iPAKPMLUDRuhFZpXPbiH7886dkvBTAuw2EYkFOnwLsLEyNCyjgea/yCZ+tN2Yud1Bcb0FrH4rfTcH/tMTJiMe+GMptfSdSaupepCPb83RttkEqEuNwenS/Cado+9vQ3jzeXmO7ZEiqOU0zd0rAjGrzfnybfv2VANadNEkZR0jGQQG1rvPrGYNqcqmuC2666Zd71j8a2GogjFsON9AQjsq0KSzpLpqmNYK2AtnZ9WQIExcOLebjOEX/Jo7bw8CgA07vWstM1w2GIJW5TUvj33I4U63Gh4HqOHS07xnqJUHYafXdLLO7arlHqFiBvag6kxbfHn5uFAP04gTfLeDiEtrWTTkL9EQ29AtUhISd4RJ4bXrALW88op146AC2S6bJ2s2QA1m86/4uTNWoDT/q+79y/V/JUG4bzm/RAWQP1ibH/mQOHQCU0nWLl7dN7xzK78DElHUqdhCKGSa+kily4mvZ+/2ZLche5cCnUgeZbi28mUXxe3kgsaAqRjPX9jnyXlHPNBym11I8Q4kVG63O2NDHXb8CzqBtHxceV+0dkM7qXJVlSve2GTUR3GltSzKT48KP/EqZs7QB7EjMNmRt/vheJgAIM59ALTG2ZqhVUXJSU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5088.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3RJUWdpU1JGdnRHUE9yMGpWZ09yN1c2aHloWTFKOFREcWdGMXNKbTJpSEhn?=
 =?utf-8?B?aC9LcUp4WkxJT3ZJTXFjTmh0Ky9qQVh3cWRiOXpLQU9EdTZSU0VvUU02OFFJ?=
 =?utf-8?B?SktyQ0hyR0JkVldpc3ZDWEQ4akp5UGUwVklDWjNYMzhqMVp1blFQUVlyTFda?=
 =?utf-8?B?aGVGcitRc0FTSWllSmtYU0YrT1FiWUk3K2tEOG1zRkNUNHc5Y0pWUUwrdE9i?=
 =?utf-8?B?VmQxYUFmS2ljV1RRTE0xcXdIRG9mdG5oWFFtcEZEMEN3a3A1QmpQREUyUS9M?=
 =?utf-8?B?VzNpeWdFWFlVWVc4SFlHSHg0aDBWSDJtMEZGUlR5aDJjS0ovaWN1QzVEK1JV?=
 =?utf-8?B?SXhNcDBtMXptQ096UHkya1EwR0tBSXFCSU1GNkdMRVZwa29YSHh6OVUrUktq?=
 =?utf-8?B?TTNEbXV6elNHMWhGZ3hkNVRJRWJ6ckNqcDhiTE5FTkNJY3NiY1B2ZlVWVzcz?=
 =?utf-8?B?Ri8yaVZlMzgyelZLK2kzQWNFa0hwVEh3YU9KY3FSdm90TkZ2Q2M2SmpHbm1X?=
 =?utf-8?B?S3NHRnd6ditDWEt4clVuM2xWeUs2b3UrYVh2dXBYQ0dHSG1TOXlhcVRwN0hR?=
 =?utf-8?B?TC9La2lIQ1NkNXdvVk5jcmhzNk9MYjBRRWY1ZEIyQWNDNWNHRE9ZZ2NnOXJn?=
 =?utf-8?B?SmxtVmxDTkIzUFEybjZnNDh4Z2J2QzQ5OGt4dlhVVk1mQzBWMG9TcXdNY294?=
 =?utf-8?B?L3A5MG5XaGJyMklkSE9sNHYwN1c1czhuYVA5dkUyQzIwRXpBZ1cxV2x4bXd1?=
 =?utf-8?B?bFo4Sk0yQmF1ZnlIai9QQkNLKzF4MTFRU1IwUkdxUjNteDRQSHVrWGdOSDRx?=
 =?utf-8?B?dTh5YnFPNE1CeUw5NHdFRUpGRDRSY3lWZzBnN2RVWnVWWG1NTjhmdUIzTEZt?=
 =?utf-8?B?S0RhRzE5U0R5Z3poSGtuTTF3L2pxbmg5Znp2cTl2QmgvR25Sc1VLZ3F1RFI5?=
 =?utf-8?B?dC91YWVhTmx4QTZIc3VaN1RmYTNNSGlVUWRrY1NKNkVaelp6NHlzc2JGQjFN?=
 =?utf-8?B?OVVETXVEb21ENkRocHNDeVJVRVI5TTJNUTdXcjk4SFZrZzhuWi83MHBML1Yx?=
 =?utf-8?B?RndsNDMxM1Z1WDgzbE1wNndyck1QajJBbXBGSzgyM0ZQUm9sa2FZeHdWdy83?=
 =?utf-8?B?aHgxdVpFSkNkc0pTNnQ5dmEyVnhybFlWUmdWN2VKS05WQmRKQ1puR0tDY1o4?=
 =?utf-8?B?bmFrSW1lZ2NEVFdxazQ5STBkRjNObUY2VU9QVWQyWHZqcTU4RHZFYkhwM3cv?=
 =?utf-8?B?VEZ1bkRyd1RVRitGWDl5SWlHeTkraURhWE0vYWpFQXRFRWpseHNJbEI2R1o4?=
 =?utf-8?B?SGo0QkxqcHozVVJQTlM5SkZVTXA4RE54NWM2V1VqcmJuOUNFNUhHRTVQemV1?=
 =?utf-8?B?cVpVZ0NIQVVISURFSlZ5VU8vNEM2MUN2OStFMGNlUlZINEhqSFFwK3p4elhr?=
 =?utf-8?B?NmZJVkplVEg0QnUycUFWQ2VIQ3Z4RzU4M29xRm5tY1U4R0xHd2MzRi93Z1Jo?=
 =?utf-8?B?a1dYUjhYS1doNThDL1oybFZFTEtDcTZnY1lqNUg3VzlXZTVUYnlwYVkwU3k4?=
 =?utf-8?B?cHJBMVkwTzAzNFFMSTBCRkZNcExKaUt1VE02a1Zmb1R6WGowM0JYM3lNTktZ?=
 =?utf-8?B?QVlSSUJyeUNRZTNlaXJ4aDlIRkNRSXdSYzJ0R3RJeGlaOExqVlFLSzhOYTRw?=
 =?utf-8?B?ZW5TeFJqQld0K20zK1N5bjR5ZW5zaWxvYUVWRFlydFlIVUN3K294Q2dBVzB3?=
 =?utf-8?B?UFUzRlprVDVUbmlDTjRpc2JUTFdtYUlrWm82ZXoxZnA1WGM2djdpZWJUZm0y?=
 =?utf-8?B?Z2xzNTdpRjdhczZWQ0pIMlRIam4xQVBkK2ZvOTZrZEFUSUovSHAvSTY0KzVK?=
 =?utf-8?B?TE1VQkkwZTkzcnRTcTNxZG1ESDh6Tms0THR4QmZpOEZDY2FzUUFrakdaTE45?=
 =?utf-8?B?NGh3YTZWcGJpTGdUTnkyekd5K3JrRU1DUlRzdHJKR096dEVEMU5Nc1d5WVVN?=
 =?utf-8?B?OWVoSFNBUXlvb3ZyUkZ3eWRDY2psS3BBcFZOUkU1VzVvaU9XRjRwKy9ZQkNp?=
 =?utf-8?B?QXJaU0Nvem9EV2xqQVovTDBXN29jM3lFY0JibnlGR2Yva28vQTMzNmxtdUZH?=
 =?utf-8?B?UUhjeVBwODFhYlM4eDlVeHVOczgrQk1VcUdEVi83eU9zOUQ0VjZrYnR4K1hv?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c395e5e-1b70-4e30-85c4-08dc477f3f6d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5088.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:11:43.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xspq6J9FmD6NlbxOfKeA3mbkenOS2PEMcOw8sisttU3Y9XFpsGppc5/+PUfIxHJ7EepqmJncK/FzdFD3hbjfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4339
X-Proofpoint-ORIG-GUID: 93aFjKIBn_ZMEx5V0ztb1-9OgdLt_1dM
X-Proofpoint-GUID: 93aFjKIBn_ZMEx5V0ztb1-9OgdLt_1dM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02


>>
>> -----Original Message-----
>> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Behalf Of Andre Przywara
>> Sent: Monday, March 18, 2024 6:42 AM
>> To: Yangtao Li <tiny.windzz@gmail.com>; Viresh Kumar <vireshk@kernel.org>; Nishanth Menon <nm@ti.com>; Stephen Boyd <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>; Samuel Holland <samuel@sholland.org>; Rafael J . Wysocki <rafael@kernel.org>
>> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-sunxi@lists.linux.dev; linux-arm-kernel@lists.infradead.org; Brandon Cheo Fusi <fusibrandon13@gmail.com>; Martin Botka <martin.botka@somainline.org>; Martin Botka <martin.botka1@gmail.com>
>> Subject: [EXTERNAL] [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all boards
>>
>>
>> With the DT bindings now describing the format of the CPU OPP tables, we can include the OPP table in each board's .dts file, and specify the CPU power supply.
>> This allows to enable DVFS, and get up to 50% of performance benefit in the highest OPP, or up to 60% power savings in the lowest OPP, compared to the fixed 1GHz @ 1.0V OPP we are running in by default
>> at the moment.
>> [Amit] Could you please elaborate, what test were run to see 50 % performance benefits?
> 
> Currently all H616 boards running mainline firmware and kernels run at a
> fixed 1GHz CPU clock frequency. If you happen to have a good SoC (bin 1 or
> 3), this patchset will allow you to run at 1.5 GHz, which is 50% faster.
> So anything that scales with CPU frequency should run much quicker.
> 
Okay, it would be interesting to see results of some benchmark here.

Thanks
-Amit


