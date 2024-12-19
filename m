Return-Path: <linux-pm+bounces-19547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CD9F86B9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 22:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1932189741C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A8206F13;
	Thu, 19 Dec 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="odoGIGlY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C001CD1F6;
	Thu, 19 Dec 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642507; cv=fail; b=sMkDwlOj/sa+q6NmtnLQVd9y2P63gm+wVi1EF8vJLab+RlYaQChdKDaTUxBwONJwPXGO47AWeyJlUGu/HtogYnV+gSlbaVS5yITv4oq9B3ZE3NlXi/EiyDAwW921CYEwJjHk8Unz/yVVPhmUz7BZNDTJ8IdYqNXYqMuOu71dYRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642507; c=relaxed/simple;
	bh=Qoy9DZS+BiRXqxAjGqDV2WRuDMVUG12zDRcbTZ9UYQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pOFhDgtDV1/yeZgrd/2pyWDhyFaYmtAnHXIZDK4K+k42mxWDSwoNGxgCieYBS8/iCnLf7SbnT8Wad6tBa3MCMXDVdqericHmOBMX4pmOculoDn1Vd8cof0OWKXCJrPrA24TRPGVf+PKa6oMmjAXxUqK9DKBYIiDh+CvRLJf3CfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=odoGIGlY; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQv9hgD/RWPHp70bgxkBSD0JoEdJubvPemd9G0xNRwx9UGpsbj27OOlByM7ZculO10Jh39dPzR9RGEJ0IGkbg2ZTxEAgWnOQo5GtOkPhs2O4wwdZjNlJ3Ykop03vWZVxiytswGshCmmqtzAuf0OHv5iGfDUhWSYF/WZ7KQrOsClSa2DQOZT01rW6QBuk/jcRNckamtoZN1h9umhiWMckks7J7vlxv5F/kqyQVqyqHe4XH1Dd4Wfp8Apy5YPSScRinjueD+yZIUfqgM1u/Ocl5aLt1eNnKm4czPwchvAdzRFZfSvl41f8vV67fWTVKOvYSsJI0oI8acl3X0N9o2ySlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr3pQDAaxkP1+CJM+7m7PXFcvAzg6OnYaEKRwMbY+fM=;
 b=x6kYB+gqk4KWei5bS5GeZPQbRB3+REm6KSUWZqNWT7d+gntZ3cKVK26ISy8cUwWRUS6G9/CBjuDDRMidRgCRhTuE55L5lF02kWdGArOBuLMbh0KIUCX6O4ClIQsMvhtMl9jvohk7bU5cY7B2JHkUS3bZ39iu0McwQ1Oajg3EmUAKpJuRtIoEoqgzrIIITdjzEYZjppfeQze92GiKR8HI/BU+QweTkqgrSCdDcX8yxDdbpOipWteyINF5xgnbqIY6YBxPoe9LvgGUO08Uu38RucgDeF1n/gDMOm223xUPZ8x7qMdxyHuv4tewR5jH2sN8mAPLkhlZ7RNbTaVZ3f8P9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr3pQDAaxkP1+CJM+7m7PXFcvAzg6OnYaEKRwMbY+fM=;
 b=odoGIGlYbWxC+LcbL9JsL4KpU9Gpqn0klmO+z3Dl1I7khdt/Nne+HuSMsBWq4UcIwLeQ4Ij6n+n8H7bjBwS9/fZFxfgWS2Yx0HvDUr7w/yqC2PNAXvoo1zHsaGppt6nhVBe6N3EBNAePCB+AVr7JgFl1w53wYnnzIh+bJOhTMtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 21:08:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 21:08:22 +0000
Message-ID: <754bdf5a-8047-47c3-bacc-238d2d2a593f@amd.com>
Date: Thu, 19 Dec 2024 15:08:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
 <4239407f-2676-45c4-9730-70493e56e36c@amd.com>
 <CABqG17hUvdo4ShQzWPWpfNqJFiDCDHmApPnHahtTt83B1Thg9Q@mail.gmail.com>
 <CABqG17i93frSsRp4wHCPZSNn-yW9sookHvTy6qCExZXKs2D3gA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CABqG17i93frSsRp4wHCPZSNn-yW9sookHvTy6qCExZXKs2D3gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:806:22::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d6f238-221c-4cbb-c0df-08dd20714591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlRmTGw4cUlOWDBydkVBd0xkWUlPUDl2dFdhZ01MemIwMGU5NzN4Z1VSVnFs?=
 =?utf-8?B?L1l1L1MrSTlxMWtIcTlmRjBzbXREaEw4K2NZM1JwemNNSjlRblR4V29xWVdD?=
 =?utf-8?B?OUZ0MWd6ODllZ29sV0hpMFFhY2JseDhIVE5OQjRQTy9SUnR1dXpWZWMrTUUv?=
 =?utf-8?B?ZjlRMnZWdnVLaEluNDMrN2lhUm9najQwTmk0bEJXdlRSck5yMjZnd0V5U0FS?=
 =?utf-8?B?d2ZnZUZRU0NpY0grYlBnNVFUdGhhcXY3T2NkWVJvSzRzMDZJSGo4T3ozbDBt?=
 =?utf-8?B?TnVyQ005ckxPQk9XbVYxaU5FcmYwWXN6SVBzb1R6eElrVm1mUXhWZUJZMCs2?=
 =?utf-8?B?Z2N5RlpjSG0rbTdjUXEyQTdDSlVZZVpDUHpkcEh0c0c3Zi9tc0lhdy92L1Vw?=
 =?utf-8?B?U1A1NHJQdzZFUytxZ1BYY1hlSkE0dEJOaDJKNEhHclIyRHBjMDFPbmNWOXhy?=
 =?utf-8?B?TTJ4VDAvbHJGa2hvWmFzN3BqZGFMYVdCT3JBRStKNWx6VENoeWhoM2xRY2hP?=
 =?utf-8?B?K0JzV0J4emdXMVVFdVhQZGk3N2g2cDBnM3dCRlR6Qklya1lZNE11UlVxV2t2?=
 =?utf-8?B?MUNhZE56d1p3aThCKzBEaFh2b1lUbXpkaFZYazRCMlpRdDYydC80WkJzQXdF?=
 =?utf-8?B?TEFKQTdIbWp4RjNqVkt4eVE4TVg4cWgwcU5Tb3RkNzRlTUhrK3Vib0lsSGQx?=
 =?utf-8?B?bHI0eHQ3Q2x3cWtsSVBJWGJ0QmxFZGxFZjlHeTdTVXp3VWVjTTRCQ3lpYlUx?=
 =?utf-8?B?Vll3YXRsV3poNVRsN2FKUVZ6cmJTdkFMSlY2OVVVZENVY2FraksvbnVTUTl5?=
 =?utf-8?B?YUxuL1JjVE5ZTi9KUkd1NjlWVTE0TWNueklJRExFRGo0bkVMTG1RTzFwRlZW?=
 =?utf-8?B?aHE3MDJ6ZjBnTlpkdnJuV2tBRjk4cEYzS3h1clBSK01ub25sakV6Q3NzMFFB?=
 =?utf-8?B?VkErYXRKeUp2dGZZTW5odWJWL3pNMUtvelJmM2dGeDgvMUhEK3lqT2RyaWpT?=
 =?utf-8?B?dTVDMEQrSEQ3eExaUHNWYlQvUjQ3MEFwL2JMNElXd1Q0SEJaRTM0ejd2MU4v?=
 =?utf-8?B?YmRIRVljSmZQbXBydWRwVlQzM0lBUFllN3hsWVZ5YXFUWCtoZU1nd0ZybzNQ?=
 =?utf-8?B?VjJNRC83NXFkR29ZaEZkRit5R2VnVTZ4VjNsWTR0elBHd1VWdnhYRFIrQjFG?=
 =?utf-8?B?dm1ud2x5TTg3c1VCanhvZURNMHo2VFJQVU1wVjRlTnNYWGErZndLNUYxUkNh?=
 =?utf-8?B?djZaUGlEQjJleTlWTEVIYkFISXZhamhLSUtzRmxaTWtCVDFjNmlTeEZMVW95?=
 =?utf-8?B?bHVpTmJ2b1E5WWdLL0tXVFZQLzlRYzErcWd0aGYwTHh3L0ErWHlEdEUyQWk0?=
 =?utf-8?B?dTJUaGViV2JYYURWMlJaVmQrZ052VnVyakhaOVdyc2pkNjZzK0VjTmdFa3Zp?=
 =?utf-8?B?UEdpMVFuZ3IwckhEWTFBVko1L0RDQ0dsKzdqUmx2N2ZCQUxYQmhMaEFFRmVF?=
 =?utf-8?B?cVNBa3RCcS96WkptWmpBR2FTWDZtV21jU05odWk5QzRTSVliamlzNXdRYWN6?=
 =?utf-8?B?d3BKRS9OdGx4Y1V1MlYrWFRjeU15cVdLcVFnbzVLa1cxU1AvZEhyUmlMVGFO?=
 =?utf-8?B?Wk5rZEtlVCtBSGd4U2s1QTRqMnRHbWEzQlNaY0xiT1JwQTNWdWNKajV4MDR3?=
 =?utf-8?B?Ty9kNkhvZm53TVRvMUU4TDBobTgyMC9vcXIyNzdHejdkUzAyQ3JKSWo1L3Bw?=
 =?utf-8?B?d1FNWTZnRFd4Q2pUbm5YZE1WOWNFUk5FTENIcFRBUndVMDZkY01xT2IzbTRh?=
 =?utf-8?B?QkMraG9TY1VPaTgxTUx0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3NJVDlEbnREVkRUK0F2WkFoeUNEY3U4cyt1YVVVL29CZE1aNkpoNk1ObVpF?=
 =?utf-8?B?dXFiQkdDSWxldTNTelBnc0Fwa0QwWkoybUIzYkQyVW12NkNjL002bHBIRmRx?=
 =?utf-8?B?OGVHT3lPVkhzZENSc05HZ2dEcGZ6WGczb0FYaG9sMTJua0ZsN0RNS0ZnNk1q?=
 =?utf-8?B?amcxOWV1OUIxaFBEUkZpL1p3VHpYRWQ0c1JqekxlVFNpakxrZ3V5YnZZVDFZ?=
 =?utf-8?B?T0ltMTN0S3dEY2xuaC83WHk1bGwwY2FGdlg0b0ZuUWhqVDlCQVd4b2hpUkFo?=
 =?utf-8?B?Ti9Bakt4blhwem54QXhsQ1hScDRsTDFVMCtmeVZjVnplTDJHR3J1Rityblo3?=
 =?utf-8?B?Mmk5cVV5SUpjM1JBSWhSMkxlQ1BEbi9Xd01mRTdpVm5qc2ZoRks3ZWFhQXp0?=
 =?utf-8?B?SHlpK3A3RzRRYWtVZTVHNjJEVjJnOGtaRDA3R3dpVFVZN1pua1ZCbms2ZmZ4?=
 =?utf-8?B?bWorYWlXMTRhbk15V2NhYkVBK041VURFTUN2RnJ2SStBY2FoaWF5RjVwRVow?=
 =?utf-8?B?QmZ3U3lyWk9waDd4bXMxRTI2NXpwS1NFVWVZMFdLc0xaVTFVNVg0eFVVTHE4?=
 =?utf-8?B?eDRIS0xCcThWSm5mR2cvMlJYOW0rdjM2ekZxcUtEQlluZEFpREFlZGowd1VT?=
 =?utf-8?B?ckdFK2V3OGFBTzRKakIrcjFJclNPcGtHdmc2N2V0eHVPUThYN3lycW96ekFW?=
 =?utf-8?B?b1NMcUdITnBUOWZZWVE5TmZkeVhrQW5rdDNNN2V6anRNaFRJOW9DSGMyaC85?=
 =?utf-8?B?WHlNdXJWa0l6OW5DRWJoelJ4Um0wbjZXcEZ0TXdTUmJBWGpqT3F1RnJJQk5r?=
 =?utf-8?B?VnRNVld2TWViczVjeS9lTE1vSTJETWVTRFErTUVMdzBPTWswanJQeHNIS09T?=
 =?utf-8?B?QVBFY24wY2VnMlRpMkVTQWMrQUVoaXJnelRnRS9MaTRGdzg1ZzhXejVCNThM?=
 =?utf-8?B?UzhZNDNWV1N6OUgxb05leDRoZktnWTNHRzZKQWY5SmttWHdidWlRZGkzeTh5?=
 =?utf-8?B?S2JwVUtmYlk1UkNSTDk2aWl4TGdoVHRIUzVlVmhJbU5oeWhJaitRd2xWekpJ?=
 =?utf-8?B?ZWRONVZHbmRkTjFOcDZoTVI5OUlFVUVVT2F5WnZPSVJ4UXZWWkpEdXFUYWIr?=
 =?utf-8?B?akNrTzhTZnoyVE9tTUxKc1BjQk4vdGJmbW03UjhHVE9KRTNyRGxSN3BucnU0?=
 =?utf-8?B?SjdhRzJXTnlxaFV3RlZWbjVvR3VaM1JEb1VHRzduTDljZHBLTDZYMGtud3J2?=
 =?utf-8?B?UDlRaXlBWVFwby9rK0VxR0wxa1V4NUhiTFVRZ3pISlRBajBFT3NPQXFOME95?=
 =?utf-8?B?RDZPdDhzY2xsUDdKeTZhUUdZbmJ2VkQxQlpMWjVhZFdwaHZQeVFiQ0VFTStN?=
 =?utf-8?B?NWRwV2d5ZmtDOTRLRXhqT3ZQZmhBNDV4UmJCSVc0TTFScVNFdzVRb0FvM0ND?=
 =?utf-8?B?bW1INjV0cExNc3ZDbFQ4WHB2RHQ5cldMdFFEQVRmNS80U3dNNjZZaDNaZ3JX?=
 =?utf-8?B?NGZkZXNpc1d4T1hMV1RDMVJVemwzbUsrTHFzK1NsenRsVGEzcTd5SGJORDcw?=
 =?utf-8?B?bHAxd09Id1NNd2RtWGdtRThPRFBGdDgyZkE1WDhJNnR0NyswSmovUlptVEk3?=
 =?utf-8?B?cEY1M0dJVFovcFF0QTM1dy9BUHNSSzF4cSt2QjhmSXZTVzBXcXg4WElrZU93?=
 =?utf-8?B?ZTBYaWFsM0REZ3FGTjhMM1NicTJtVXMycURhbWRlSng5R3RqS0dHQk5KOVha?=
 =?utf-8?B?Rm9VK05DK3lyMzNmam9USyttdXFxZjllNDJLcWNUNlUwdzJ5L2o2UjBYeUpD?=
 =?utf-8?B?d0NuT2FFSURpeGFjbUM1QlV1SlVzZ0ozc294WWp1T3Jvbk1rZmtKR1JkTUpj?=
 =?utf-8?B?WmtPNncvempGUnhTemtRTE56Y0N1Y0F5NVErbW54MGEzQmljaTNHOFlaczRv?=
 =?utf-8?B?dnQya1BBTHRGMWlzY3lJVlJEajc4azVGcnVnMjNnSFg5RWhBaEVDWHBpQVFW?=
 =?utf-8?B?WWlhUklOZHBVaTR4bW1hRVRwWVFISGpjbnNJcStEL3BsampmckhZSW5FOXhT?=
 =?utf-8?B?M2g1bHpGWHlEQ0tqL0hQeDJydkhMTTVLemlhZFVWTEs1Q0VxVGhKdjQvbGpz?=
 =?utf-8?Q?S5IZVNG1j6qN2eXjNJjP3zEUJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d6f238-221c-4cbb-c0df-08dd20714591
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 21:08:22.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAaVzhuaa7cmKPjSbSVnIeWRztzMusq0GNmOc2xyoBnJy+4A6Cn7WwFh8m9jN0+NIeBlNM6JDa2DWvZWXRY6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On 12/19/2024 14:15, Naresh Solanki wrote:
> Hi Mario,
> 
> On Fri, 20 Dec 2024 at 01:40, Naresh Solanki
> <naresh.solanki@9elements.com> wrote:
>>
>> Hi Mario,
>>
>> On Fri, 20 Dec 2024 at 01:02, Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> On 12/19/2024 13:21, Naresh Solanki wrote:
>>>> The previous approach introduced roundoff errors during division when
>>>> calculating the boost ratio. This, in turn, affected the maximum
>>>> frequency calculation, often resulting in reporting lower frequency
>>>> values.
>>>>
>>>> For example, on the Glinda SoC based board with the following
>>>> parameters:
>>>>
>>>> max_perf = 208
>>>> nominal_perf = 100
>>>> nominal_freq = 2600 MHz
>>>>
>>>> The Linux kernel previously calculated the frequency as:
>>>> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
>>>> freq = 5405 MHz  // Integer arithmetic.
>>>>
>>>> With the updated formula:
>>>> freq = (max_perf * nominal_freq) / nominal_perf
>>>> freq = 5408 MHz
>>>>
>>>> This change ensures more accurate frequency calculations by eliminating
>>>> unnecessary shifts and divisions, thereby improving precision.
>>>>
>>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>>
>>> Thanks, this makes sense to me.
>>>
>>> But looking at it, we should have the same problem with lowest nonlinear
>>> freq as it goes through the same conversion process.  Would you mind
>>> fixing that one too?
>> Sure. Somehow my eyes missed that.
>> Also observed that current calculations yields zero for lowest_nonlinear_freq.
> Sorry I was wrong. it's not zero. Its roundoff version.
> 
>> After fixing that, it reported frequency 2002 & 1404 depending on the core.

Mmm, I wouldn't expect that.  Is your APU heterogenous?  Or is this a 
BIOS bug?

Both with your v3 patch in place and your patch not in place can you 
send me the report generated from:
https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd-pstate-triage.py

>>
>> On a side note, I'm also observing that the highest_perf is set to 196 which
>> should not have been the case as I do have cores with value 208.
>> Seems like amd_get_boost_ratio_numerator needs some addressing for that.

Ah this is something that is quite confusing about how AMD client CPUs 
behave.  There is a feature called "Preferred cores" that uses the 
highest performance value to indicate rankings of the cores.  This means 
that you can't use the value in this register to calculate the 
frequency, you have to use the pre-defined scaling factor.

The scaling factor is listed in arch/x86/kernel/acpi/cppc.c and the 
correct one is fetched for this calculation.

>>
>> Regards,
>> Naresh
>>>
>>> Gautham, Perry,
>>>
>>> Is there something non-obvious I'm missing about why it was done this
>>> way?  It looks like it's been there since the start.
>>>
>>>>
>>>> Changes in V2:
>>>> 1. Rebase on superm1.git/linux-next branch
>>>> ---
>>>>    drivers/cpufreq/amd-pstate.c | 9 ++++-----
>>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index d7b1de97727a..02a851f93fd6 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>>    {
>>>>        int ret;
>>>>        u32 min_freq, max_freq;
>>>> -     u32 nominal_perf, nominal_freq;
>>>> +     u32 highest_perf, nominal_perf, nominal_freq;
>>>>        u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>>>> -     u32 boost_ratio, lowest_nonlinear_ratio;
>>>> +     u32 lowest_nonlinear_ratio;
>>>>        struct cppc_perf_caps cppc_perf;
>>>>
>>>>        ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>>> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>>        else
>>>>                nominal_freq = cppc_perf.nominal_freq;
>>>>
>>>> +     highest_perf = READ_ONCE(cpudata->highest_perf);
>>>>        nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>>> -
>>>> -     boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>>>> -     max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
>>>> +     max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
>>>>
>>>>        lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>>>>        lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>>>


