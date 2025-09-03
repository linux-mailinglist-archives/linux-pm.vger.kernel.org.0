Return-Path: <linux-pm+bounces-33683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7EB4158D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B6F1A85774
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E082D73B9;
	Wed,  3 Sep 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ATEK88zo"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447442A80;
	Wed,  3 Sep 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882246; cv=fail; b=J1ozH83GxFSPFT1np67faI2PfhZumd5lhW8kvBYkSgL7tSBcHTCr0hFIYy7B3yy2YM1TGY4tOwhhyHQbIOBmt5hIrLxr7F92WvdfOzbBoMenL70eUm2WMX5JvtLwy4mnoG0WTO2JDh8sHOcBOgBsXP/6abYfXcFysvJQfvWVjZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882246; c=relaxed/simple;
	bh=cpr2I7+DtuVISn7IkmzKFExAeC8xFp/wZBtt2C3fHPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQZv9eoAmjnBEfyuB00n61wQloCLwOsZSchoq7sqavuwksOusVjRiPATU2v7f873zKa0ydV1ea21wrGaKNMQtA29ZDyoMfoY3QE46xq0SdffHHUxmAnDFygX5P13b+zIPQ+U2gXzZ79nFkBLL2igrYRvb/4lg72/twuAKDoASpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ATEK88zo; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fODOKOsWHI+r6jIArKs2i94GGsspFqA1wFk8FWTARzJdKfjdVkge1g88hjzsowmjqmpxBr+rzQ+43XKNrxmkeql5zyBrCRQX5uJhgC67niep2H8jnktLDqnvmgnI9z3P5eO9b6rWItH65VntkaX/dlpWZR/dS348r6MMIq42hzdJtwf6Vk6vWPNpW58a1zBt26b1dEYmbNxfIkCWq6pC4yreFIz9kQt3jh0czbvzSkGPmIJmyxDFTdkp7+3SC9YUosxLkO9pNe5ZfDpVgjlo6ZJqOOojiw8bvtWRoIkfd6rG0OZLpDZ+2vJ4pOzWGCzjqabTi8ykd0bsl5AyP1pskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ8BOUrYGHFMgLU76xl7VeH8nkMcqbWCeifLwU3kuoc=;
 b=nyc4kBp83WHO1HMTEdLzqkcMlhwBLP/4STQ06y7K3ovIEa2iBQ3SY3iY7zi3oPGBCWkSb+dS5attcvXeNXxU1Q90HiDb3wu3rZG65YQ5uU14TUdANTJk5XVH6UHN3/ArDew/SAt74oTzdbClkfFlB0h1/7MTaA8B5foquNoqXv0bb4qiwV96tPAKzwMP9A7trcyX7FjHZwc3C/bgJDcj5n8cZ5lssJxy/3n41Q173Rt1CbOpHKv1UdxrKYEdgd1CB36hwIgNV18/prp0KwVpQDZE2xyQYiTfCob18VnbcxuozwJFRuH61QLwuhqAyq+P2Oy3cB/yesMh1NLOXV17DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ8BOUrYGHFMgLU76xl7VeH8nkMcqbWCeifLwU3kuoc=;
 b=ATEK88zopaRita4xoX6jLdrrhJQD0cvgL1XENV0pC/lag0ypGDg5yIwLBANT/S6ds5sQmS4pVv6aw0JeMVO2uoJOBu5KyHLa/RhZfiOFBy5yBkDky+NAvekGV0xrFlsNCnggPVHECp75KWj3RxeC5Hbgg0APNnCArAvqOOxJjIMBtBH4C0eC0X02ZOt51OxKxQRcpdw2a9lbvo1OUX1USZFypEtO2uuN5fJQOU3OfreX3YQIzWUTO9ovXE2bfzxYgHPYk8ZLPlISkD00euv8p6Uzw5G3Dyjulmd17g0CJQf4ccnfpLJIh8oMdY0DNddNzS42XvmPVm1OBRx4RI6GRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5257.apcprd06.prod.outlook.com (2603:1096:400:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:50:39 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 06:50:39 +0000
Message-ID: <6492c8cd-715f-4fad-8286-ffc1b4ea930c@vivo.com>
Date: Wed, 3 Sep 2025 14:50:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cpufreq: powernow: Use int type to store negative
 error codes
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-3-rongqianfeng@vivo.com>
 <20250903041447.6t7q5ddoqwm3og4d@vireshk-i7>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250903041447.6t7q5ddoqwm3og4d@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dddccc-0dce-46f4-4b1c-08ddeab63110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBna25rc3A3Ky8zcUdJUDR4bWdtWnR5REJHT1JETU04dk1hUWM1Z3FjWmtD?=
 =?utf-8?B?MmloL1ZwTWgzL29tRWdScGZqQ0k2RkJZQ3VCTzBma1hMUUhNRi9vUFV1Z1lk?=
 =?utf-8?B?NmpLM2tsV0x6V3BzVGh2SFJIRXJyY1R1ODUvbCtlSVJhNEU3WFgyYmtPL2dX?=
 =?utf-8?B?TitWbUhFcnFDcXlTQ3pIb0lvUE1RalRQRDFvb0pVbzh4aDNnc2FVZ0gvUGRO?=
 =?utf-8?B?YXB6bDFGRXRjL01JbDBkTVBIUzhIeEZVdmdmcGNoT2ZzNTVJcjBSVFB0T1ZJ?=
 =?utf-8?B?ZHRaOE8wam1McU03bGozSVBMeFlweEFyb2hlRTZ1WHRIQ2V4MXJqaGd2L0gz?=
 =?utf-8?B?NGV6Vkg1K1lqVWxPeGppRXBGTlBCV0NVUGlocGxlamdPMjQxVkRzazJIbWhk?=
 =?utf-8?B?NTdtL2YzWUE4VlUxQ0IwdHZQMFVpcHU3M21SajNmWVFxWDVmTUNJNnVwRE44?=
 =?utf-8?B?cEtJUnNueEVUUFMrMW02VG5oR0NFVnUzdkY2MnQ4OFpackNYZU9XejFCdU1L?=
 =?utf-8?B?UDN4REJiUElpNUJ4Rks1a2hmUWZwY2hZbXBuZDk0N21MQStQWTd6RGlSY1gy?=
 =?utf-8?B?dHFpOG40bkR6Q3ZwZmpQU0VGSExkM3VtTnM5REFZSHJjWlI5azRDWlBzbW8v?=
 =?utf-8?B?VWxnU0Myc0NTOGtvbytwS2pvRG4yRzBsQjROcXl2UldlbS9WM01jVHBJYkVy?=
 =?utf-8?B?aFRLeXhQTy9LMU1pM0ZJZEVKYjJWR3crdXdWVWw4OUZiMVF4QmxyUGRXa1dM?=
 =?utf-8?B?aFhxTUxHVkpLNHdvNUhCY1A4NGRESmFJVDdtTE55anZJK1IvSk00dUV6bXF1?=
 =?utf-8?B?N1ROMUN2c0MwTVhDS2VGUWRTNzkxMnA1d2QxMGRWMDVBcStKY1VrZHg5RTlh?=
 =?utf-8?B?VS85UmVod0pxVHllSE1LemtFVVpPSUtFUmEwclRPcWdmc3Z5SW52ckRJaVZL?=
 =?utf-8?B?aGJVWE1lSEdLMHJ1VUlqOHZzTUIyaTZGUHlSZjJFYVlBNG4rSVpvaDJvMGJY?=
 =?utf-8?B?LzMyZVRqWFdGTVQ3eWtjYWgzVUhZVjVTa0lQWE12WWsyalowL1hnNjBNdHZj?=
 =?utf-8?B?c080UXBqbk1HWkxoNUVHdUY2TnEwUHhaaG9tbHJvbW9NNzdmUCtESkV3eElE?=
 =?utf-8?B?ZVZjLzF4eXYrVEtjbnpmbFJjRmsrUUFxbVRBaGZjSEttSURVSXdWR2lLSkFa?=
 =?utf-8?B?Mlo4TUlJQ3lWWDUvbWpDWllXNWoyOElXZU9kZW1salVUZm45RjM1ZjhtNWZ4?=
 =?utf-8?B?U2MvOXNuRUNvam5ldUdZSEJtTjJpMDIwNWZLV09raitjTGNXeEt3YWpteS9U?=
 =?utf-8?B?TTA5RDRYRXBHTmJNeC9nRTRmaTVSTUpaZ21CV2x5V01oLzEzcGhrMCs4bFdC?=
 =?utf-8?B?RmFsMnFSNklKV2R3MFJCSE1wTlc5QjZ0dE5tWnlxaCswWHpYcnh6K1A2SVB4?=
 =?utf-8?B?QWxoREVVa2U3MDBtc1hjV3dDeXROSCt1K05vS2I0cjI2R1BVaWZEeExPNkQ0?=
 =?utf-8?B?Wjk2UjBPT3M1NXM4N0xXeE8ra2dYbGxyUHlpK3crQTFOL0tQTTRTSkZaeEtq?=
 =?utf-8?B?ZXhyakx3TkwrNmNvSmJHK054OEMwRG1STGJGalhvelV6TmFBZTRJcVo5bzRD?=
 =?utf-8?B?VXA3OHhtNWlnd1d3b29idTlTQkdKL1NHSStYMEl6ZktKOElIKzBxV0JkVmNn?=
 =?utf-8?B?b3hLajhDeFNuL3VXMktHd0ttNGlMQ1BTRlZWNkV0TkNUcE9scmg0RWcrclY5?=
 =?utf-8?B?blRBbXJGeGgzeDBJMmZyUm9QQkpEVjJrN1lVM3pDU1RVd1Yra296RlJoNy9r?=
 =?utf-8?B?TjVaQW91aFpMN1JhblJ0VHlua3BvUEZRWUlvZkhRcEVIcmdFemVuSzUrb3dv?=
 =?utf-8?B?RW51NHhhdUJ1ZjByQlhmR0xwZEZTck1IcnFCaC9DZUVFQkU0WDVlVldiUE4w?=
 =?utf-8?Q?PJ+XbLue2WY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SURhTk1KMXhXUHZiZlAxT2orL3d4L0tRRlhqMTdrcmVUWWpHOE9MaTdqZHYw?=
 =?utf-8?B?cW43emFQNXlTd01GZ2Vsc1I0Q1FWUnJRa0RQVWN5UUcyS1JGbFNSUS9TZUZZ?=
 =?utf-8?B?K2lFZnVjWFhZdW9PTit3QkFBL2dUb282T3dlRVh0Q0FzbnJnTllxcjkvZjBE?=
 =?utf-8?B?UkxudU9saHFrV2dCVisrTWR1RWlmem9LU3hqTUZyb29kRmxhbVhodVRQcGhY?=
 =?utf-8?B?T0s3Y3BHWE53RTQ2djZtKzZickNxWS9jWm51OUZqdmxsdmo3R0t1QW9kSjJI?=
 =?utf-8?B?UXlGVUJTeXRSSU10Y21VUndiVDhZN2dUSGJ4NHNYZUsyVHM5VFVTNW94RHV5?=
 =?utf-8?B?NmVWbGp2WEZrVGpFcURubjRBWUdCWHc3dTcvVEtrK1F6elhxR1NZWnlGV0ZM?=
 =?utf-8?B?VmxCdjNpU1FNUmJRNThGOXJheUh6UlBEaDJ2a0hIZFhYRWx5c2hyUVVsOWZD?=
 =?utf-8?B?R1VmRkdRT1lqVEdYVTAwdmpBTmMxQXhES1JiQlV1ZzJmaVRCTUhtY2Q0TzRF?=
 =?utf-8?B?RkVrTWQ0dDl3RkMrSVMva21TTmNBVGNqeDFSMUpCTEV0SlNNSmM0a2h2YVE1?=
 =?utf-8?B?bGRZUUxNclBmWm0wTHltSlR2ckZVbDY4MXpzTDc1OUY3WFhYbXRQdENiRGxK?=
 =?utf-8?B?SkxvN3VXbUx1bUhGSDhHc1IzcHJGU3JHVU9PeEw2am9nWlZyZCtuWWJYY2lY?=
 =?utf-8?B?Q0FLVXFvRTgwck9NbWhnRTN0NXBteURoazUycndqVWZqME02WWV4R0ZEbXRH?=
 =?utf-8?B?RHBoVVU3emZMVGNEdzJIbkRoR084SSs2U0pBbm8xNVlrTnJzckIxTUNTVkdC?=
 =?utf-8?B?R25UMEV6cFhxaVVwdnJXVXJweUxWcGpjaWwyMlgrNTdHSDVXbVFnRjZoTkdD?=
 =?utf-8?B?VjRYVU15SWpIWGtmaWNheVRuWElYL1REOXRYQ1AzVGhWS0wwUmxnLzJjUEpV?=
 =?utf-8?B?UzdsMVkvbjBQYkt5N1VzS08xNWgyazNram1hTXJHeVZTSGhrZDg3bzRRMkI5?=
 =?utf-8?B?MThhT1hFaFN1MFBxUXNuaUpISDFMNTBNeVNYaFdRekg1ekswMFF5dk1lSGZt?=
 =?utf-8?B?eUI5dHVXWlkzbjR5VGhmYTBsMzFyRm9BTUNhQnlmQVl1bldYVWIralg2TTFV?=
 =?utf-8?B?T2cwM0MwOUMvTXQySFU2RHdUNnpFeDJzcGIvYS9oWExCTFRlTjZzNlozTVQw?=
 =?utf-8?B?aHM5cXpKQWgwakN3WUxvcWdGOGY1b29pWTBWY1VRMnJISlBGZXNwUHo5VHZP?=
 =?utf-8?B?aGNJcCtWalJNMk4wRWhEZjdoL1ZrbUd3ZW5nQkdORlVQYVdyYUY5YVNjc3dR?=
 =?utf-8?B?cUdBNVdtSllUaG0rMDRnbS8yTndOWXFCdEpNcnJkYW1lQXJvT3kxZ25SbW1i?=
 =?utf-8?B?TVlidVc1aFFrR1lzOVUyV1R2NGVwRkNIVjZ2aU1pcDlIRWhHME50b1VTUE1O?=
 =?utf-8?B?MFpHOGNERlBuekR6aE4wMW95REd0MnVsY3ZpdHhrNXR0Z2RWcFk0NS9LQ0NL?=
 =?utf-8?B?SkJ5WUJGRk1OZHVmZE9vUzdCOU8xbSs4SzJjVk1VUjVmaEw4dzBOUnlFVGtZ?=
 =?utf-8?B?ZG9UT2YyS3gzVk5jZnNPVUhPYTAydWw1U1dhaTZlWk0zNzBUcG5Tck9mUVZF?=
 =?utf-8?B?ckhZa2FDWUpuVWE5R2lrclFGNHlPUENHYU13WmRkR1U4dlh2SUdqVlA5cUFH?=
 =?utf-8?B?YmRycElONUNqczhVWG83ZVIxOWdsN1J2S1J3TVNKdWtBc1hnZFJHOGUva2tz?=
 =?utf-8?B?aFp3Q2o2Wm5OWWJSY2EvVytJd1FKZkFSbjV6K244azJZcWN2N21TTG9xU2JB?=
 =?utf-8?B?eGlUZjVlZFlRbjJadURudjk3ZUxtbkNvRStSRGlHRTZpSE9Fc2pnYjVwdlhh?=
 =?utf-8?B?ZFZ1cm1SWmwrbHhRYWZ4dkVTRmZNVTNWMmxYd09tbG5JQWFDSEtWVTc1d0Nw?=
 =?utf-8?B?U3M2ZzRKNVJEOHFlWkYrKzBLR2JsbkhnRFF3UURPTXJvZjNraFRPNVVYUGN6?=
 =?utf-8?B?Zm0vMnFVby9FYUYybW9nSmtHUE1VNEdTOW50Y2xLTTFDS1NpQmFVVHlWMFJ3?=
 =?utf-8?B?dDBic3RBaGpwNVFVZHpSZXlWSGxaZFNKNWx1ZU5NR1JBb2xNMko5OGQ1Z2dw?=
 =?utf-8?Q?cSLADeKGq4WF2QRvti7LTgG+t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dddccc-0dce-46f4-4b1c-08ddeab63110
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:50:38.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwVse3fNj1624frv234uPAsBkJpU93Wfc5VMCRKd5ghVx0eC+JU9hRYYONiUBsxsDR6r7ia043p4D3UntJ/bmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5257


在 2025/9/3 12:14, Viresh Kumar 写道:
> $Subject is incorrect.
>
> On 02-09-25, 19:45, Qianfeng Rong wrote:
>> In powernow_decode_bios(), the 'ret' variable stores either negative error
>> codes or zero returned by get_ranges(), so it needs to be changed to int
>> type.
> You don't need to mention this now. You are making a different change.


Okay, since this patch is no longer part of this series, I will send a
patch for thismodification separately later, thank you.


>
>> However, since the 'ret' variable is only used once and can be
>> simplified to 'return get_ranges()', it is better to remove the 'ret'
>> variable.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>>   drivers/cpufreq/powernow-k7.c | 4 +---
> There should be a `---` line in between these two statements, you have
> corrupted your patch somehow.
>
Ah this is my bad.


