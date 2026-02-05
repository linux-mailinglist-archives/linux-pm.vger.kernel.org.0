Return-Path: <linux-pm+bounces-42155-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JGxMhmkhGmI3wMAu9opvQ
	(envelope-from <linux-pm+bounces-42155-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 15:07:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BEF3C56
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D153046BAD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A063E9F8D;
	Thu,  5 Feb 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="glSEh4Ej";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="glSEh4Ej"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB6283FD8;
	Thu,  5 Feb 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299999; cv=fail; b=aWlvKiT7GHC5oMBG5YaeiU+qlOoFh8+zbuhkQP5mSdm805noPM+fKEWMgFvqLaxQ1YMS3iO2rmmJot85BPCuNI6bGN9+Us0sgFeJG5rjPO9OdVPADGGuokwWVTPmwt/nMW8puB0wApovKOO+sZLWO5pWWhGEw73ZrpQMdq4u0pA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299999; c=relaxed/simple;
	bh=XX3O68LvsOk7RvhIBefOhfvj/DT+C+qGC0gX60+nBSw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHel4VoiD6iB1M/sDjoJtrn/TwK0nByIFQ8HCIb3Es90Exa3MQth9i23xNUoFlzqmbGmVs6Bap47kKcl7HVyTMtCUrXgpBVLtCzkGY6/ETbJLcv6XeERmMrnsstLsbvI2N2pD7w3nipjvDJJoboyVaOZ7IGT/qQgoYzTmAA2n2Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=glSEh4Ej; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=glSEh4Ej; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VycanehzQFH5STfMb/hzIHftWlV9MDfXUBZcNiIqfzVelNUDNcx1ME01e2LBGTZgIcUt2UTeqCzusd52jCiTHFT+p0up0N5IsnsLdbFlfw9ixnrWFRwk4sros2KVLdBxv0A/B6tc7WKD0NLo/ILZIJSiji6AXtYLP9WXjM2pfG7Lsv4VGYZJ8M3kvH4UtIetssz7Ax3MozvmUG/eokml2c4JSZxkuYgl/klmC3zScb3s9ohkqicchNJruBWisSoRluAg/o54yPIw15+R/3MjrjctOZ3qKENLHyZ3vN80qFtT/YfgUUcOn52JNASl/QfZsqR+ltV4MW1H8bV4z0b3jw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8yFGFmnKZB9fRCVVeY2q7B2R3kFQufUPvjqqS1pWAs=;
 b=WB8Z6AzLsEAuggaGRA0lyNRqq8IPl4yXTHuA+Ip6fYZT7tjGtJeZwFhdMSopQiPcxDsKbZQ6wNQftlxXWILlptQueAncL2QRMArIRV4p5zSVgsXCiQ9CTIi3lvwisBaEyqMdPAB022LJ5lk5ZG4glRX0h8BAOrbtpkIL/6F4A65Cmly2MciTCAUhriTgG8OhdV3WMmznbK9NGOzBFrPJtbKCMSDBOQNJach8sNyN3WYDAk0ZoaxMNtCMSg+Bvj8gmULNqAMFv6mbTE7rTxvZ4xAVkdR02FIOInG4nfT7ngjW8BfPoInrXzx2ytCr+7meZnNm2b0z20MAP/di2eTQEg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8yFGFmnKZB9fRCVVeY2q7B2R3kFQufUPvjqqS1pWAs=;
 b=glSEh4Ej6to8O4D1PPqVi0tnjaLFp+XYzZ51wwMw/tBOBDLq7TabhHaH1yYi9GGPGVb4rKGXxg9KhR94T7dFNWqEw33VPKM2SybxZsPAQJPZ/07ILYCJ7ZbC26UlzCecj7mAmwHc1S1h6mRz7vXuBbZhvEtib91qi7qmz3PjNo4=
Received: from AS4P189CA0028.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::18)
 by DB4PR08MB9862.eurprd08.prod.outlook.com (2603:10a6:10:3f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 5 Feb
 2026 13:59:52 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::23) by AS4P189CA0028.outlook.office365.com
 (2603:10a6:20b:5db::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 13:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Thu, 5 Feb 2026 13:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QonbQUlzO3j4tMjxKxL1sMmQgCCBT/BV9z0e7ysuCv20SYG49SAe9JbEN3A3YZahW8O6plkOPTDyLpXTQtWh3fVw6n7GhqQYcfHEpyv/FZ4HrldHBQ+bs1i+SKq4VcsnueOPr5iNZbFjcfE0xKxxBONWFzowKVYntVLBPNZs5FR4IIJ8zbj8umbkhZwdfP2QPe3qA5ccT14LAAWNw7l53+y/nieGjFRddQ5QrQu6ThBCRN4djRsaGkJ/+UIvePOv4i0unyKJyWF7pVyDD3o6vmzWn9GLfmmkW4mYxviG3FycFVy1wODg+Nqqq81KXCOeAoQbHtmf5jJXdZ6k3b1oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8yFGFmnKZB9fRCVVeY2q7B2R3kFQufUPvjqqS1pWAs=;
 b=PZZFhB3cypZsDf6PQgEDvFWYXSuthp65S6yUgnaVCnhEVRdv1WbkBMFhiKcFyAE5lMFo3q6maQ5K9RqGQ/6GC6Q84WSn0Z3TNLUgXIOLdeNN51K6y86kGo9azdjDzbtT9Y7WU4kcS+aZzICi0VZ//qkVM2r5b/XIzly/fciI9WEl4QXyHQEdp9K2sXnAp5doBnbORGMvmopDO1KE+L/K0fWhKsz3iThUxua+IuKlfyj4IgDYSuI+Jj6SF57wDBTQVJBt31AFwypk3ZW2xk1Pwr9uMLXMTEdw9M9sRQoQVluUzevRfsk8ROS3zzWHX3CWqVEIlBH4AAy9O/pylci7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8yFGFmnKZB9fRCVVeY2q7B2R3kFQufUPvjqqS1pWAs=;
 b=glSEh4Ej6to8O4D1PPqVi0tnjaLFp+XYzZ51wwMw/tBOBDLq7TabhHaH1yYi9GGPGVb4rKGXxg9KhR94T7dFNWqEw33VPKM2SybxZsPAQJPZ/07ILYCJ7ZbC26UlzCecj7mAmwHc1S1h6mRz7vXuBbZhvEtib91qi7qmz3PjNo4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBBPR08MB10386.eurprd08.prod.outlook.com (2603:10a6:10:534::8)
 by GV2PR08MB9254.eurprd08.prod.outlook.com (2603:10a6:150:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 13:58:48 +0000
Received: from DBBPR08MB10386.eurprd08.prod.outlook.com
 ([fe80::dbf7:8c18:3fce:e74d]) by DBBPR08MB10386.eurprd08.prod.outlook.com
 ([fe80::dbf7:8c18:3fce:e74d%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:58:48 +0000
Message-ID: <12bcfd60-63f5-4804-b40f-b87ec1a8439e@arm.com>
Date: Thu, 5 Feb 2026 14:58:46 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 3/6] cpufreq: Centralize boost freq QoS requests
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, sumitg@nvidia.com,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260126101826.94030-1-pierre.gondois@arm.com>
 <20260126101826.94030-4-pierre.gondois@arm.com>
 <5cbc4987-f2b5-4dc4-8b90-c7aca60e6574@huawei.com>
Content-Language: en-US
In-Reply-To: <5cbc4987-f2b5-4dc4-8b90-c7aca60e6574@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To DBBPR08MB10386.eurprd08.prod.outlook.com
 (2603:10a6:10:534::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DBBPR08MB10386:EE_|GV2PR08MB9254:EE_|AM3PEPF00009BA0:EE_|DB4PR08MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: c15b6e03-8f29-4551-65f5-08de64bed5a1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Y2xMYnd2VlNqYzhtMmxLb3BYRUwwOFg3WlozSTdhTW1CYmdycCsrL0x4Um5T?=
 =?utf-8?B?alhGQUhiOUVpTlJIRHZHVDNRa0V5OG9WT3NFcHRhS1g3N2VncnFlMG0xNVV1?=
 =?utf-8?B?ZHNjb1NGSW9HaGZab3krWDZTbk4yc3hqL2txWmNmNHNmdGJNeDVJdjZpWGg0?=
 =?utf-8?B?cDBleUN4Uy9CZkdyK3VwY0VDN0RiZ0xQeFNBN1p3WXJwSGxzRmtHdVJMaUZX?=
 =?utf-8?B?NjUrUXQyOEFGT1prUVBtaVRFSUFtQWs5aHZxNktnMFBKYWNsWGxHZldIYlhR?=
 =?utf-8?B?cWtmNWJvWXo5Q3EvQ3hDVkFTY3RlT2doT2NEWVN4R3cyUVNjSVcrYzdaQ1I5?=
 =?utf-8?B?emJsZjV1a25ud1NmTGk5Wmd0akR6ZktmWHB3OHovVzUwZ1pBM0FlblliTW9x?=
 =?utf-8?B?c0tMM0tYL1BJeFlNVjI1VEt3TFQ2dnBBd1duTjFmeEdVOUdiMnZCOUQ3OHVW?=
 =?utf-8?B?Z0orWWhIM1FXQ0lVYkt5L25ZWGtXU3h0Wjk2OVhBODlyc2kwSUp5a1ovR01O?=
 =?utf-8?B?c0dyczhDSktwSkJwS2U3ME5wc09nVllhNjJDZXdSTzJHbDM3UVZpTVB5MmZh?=
 =?utf-8?B?OUdJR0VaUkluWmhMajFLbmdBQlhFb0RPYnI1bEhqRzBjQUo5U2VrVzlaR0xV?=
 =?utf-8?B?MXoyWCtxdVhOZi90QjkxSDAyZ1p1Z0IrUVZ6d2UvMWhtZkVBWjkyUzNlV1ov?=
 =?utf-8?B?bkdvUTMyNGgwb0JpU3ZWbXFlV2FtUks3VXlmRUVtM2dwQml2ODN2dVp1QnQ2?=
 =?utf-8?B?ZUtKaHVDRTFuNWdBcEZMZWluVjkwUkJtOTJJQ1lYb2U1QWVqMzIvV3IvT1E3?=
 =?utf-8?B?Q0U5T2ozdml2dFFlaVBRUUFYRkgrc1h6QVhqcDhETXV4TEEzaVZqMFlYdGxM?=
 =?utf-8?B?eHN1UWdncFpONTN4cGV1UGdsdFYwcEJIMmp0R2p3Rm1oSzBtUm1CZnd0cERn?=
 =?utf-8?B?em5WWHg5Qi92K3ZhVHEvNS82SFpKdWE4TWV4ckdkK01nbGZwRjFOT2U3MGp5?=
 =?utf-8?B?OFVTOFFPdXVXT0N3bTFOQWhUd09LOUQ1MUZyMWlYRmZablNocE0vdlR0TkVG?=
 =?utf-8?B?S0p6NVBPdXBsN3pvOHk0bzlSOFZJZmdQM2ViQXArcXZIa2xsMTlKWUljUFZP?=
 =?utf-8?B?b3BidlNxTVZhVlBHV3JFR0orSEYrUEticGh4SWN3RkNyaXZsUFhRMWFSSjVi?=
 =?utf-8?B?N3Q4RlFibG5Bck9mdGVPWVNjdXlGTCtacmVPNEZyRktYVTRIMVlkUXlWWmQy?=
 =?utf-8?B?OTZ1bmkzc29FNmtQSWowZ3lEM0Y4a1VLb0twSFhKbVFqdEx3WEtwNlVEVzgr?=
 =?utf-8?B?SENIckw3T29BNEdvdUhxRU5YT2ZvS2M5eFpqNmhrcDRzRS8wbUpZRGlpZ3Vu?=
 =?utf-8?B?SDROVlk5dUlmRG9xU2wvQmFSbnV6SklBa2t5ZWpoSGlpNi9tQnZsZkw2dXdF?=
 =?utf-8?B?VGoxeW54T1NGczdOdis1YTQ2ZER5T1h4Y0VsNzFsL2U3aXdSWDB6aEJ3QXgy?=
 =?utf-8?B?a29sWTZFZG5YUlN4Y1dGRmwybXVLK3JyMzRkZDl4NXBSTWU2TzlWdVFYbnJP?=
 =?utf-8?B?ZXhhSmRjUFlhZW1mR3hxUW5RRWNKSWt4UGIxOGZEUnZ4VDU3ZlR6YkI0OWZH?=
 =?utf-8?B?UWxLTSs3Y0lHdTZsc2g0dUFUR001R2UyV2lBbG1FUVZTOE1YZCttc1JwRERY?=
 =?utf-8?B?aWdiUGgzZ1VITERRTk9DeTQ0Ni9KeTBBTDVwZmlTcmowd0VuWkVXZFQ5T3ZF?=
 =?utf-8?B?SEhudGhhRGd2RFNVeDBpOHREd1JRb1IvcEttc0pRd2pSZk13MW0waDVwR3hS?=
 =?utf-8?B?SWxuSGVIN3lnUmhaRlpxcWFmVUZ4bHY3T296aE1ZRitqMUgrSzdHYUw0NEwx?=
 =?utf-8?B?eFVRWFRWVWkwV2dURmN4ei9DaEtFWUlmRFBBZ2kzV0QreDNaRE00dHpvSExR?=
 =?utf-8?B?dW15VjU2V0UrN0EwZEFxZm91WE9rSXdIL2x1QUVWck9TRURHZ016QmRTajFz?=
 =?utf-8?B?dkY0RmRVbm0vTXFxQUNPVlV4T0MrdGtHSkd0QVZtV2h6MEQwVFJXN3prWXZ1?=
 =?utf-8?B?eDZGSnZXYjNBM3piV3RxNDNzV0pnVVNIYzFXNE9yWk1JQ2pHYXVWYVdVYUpI?=
 =?utf-8?Q?e938=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB10386.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9254
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6752d6f0-7117-4f03-2e18-08de64beaf86
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|82310400026|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtnbkFuZEhCemFMMzR3YlJQUWpFaXp3WVp6empla1FXcDZoaS9OUDcyWlBO?=
 =?utf-8?B?K055U0ZGcUExNDlpRnQ3U1FUYUZta2NVemc0c04wckQyNUtQbDZTWlIwbkha?=
 =?utf-8?B?emoyRlFoMUo4T2Z5TGFlUVI1UC9GZm5ReUxMYkZHYVdmN0RweDFZL2FPZ1JK?=
 =?utf-8?B?VlRkZmxUT2hGenAwYjlha0w5N2x2Q2NPL0RKUkhla3hsQm1NN1pxdUQwakMz?=
 =?utf-8?B?Z3daWTVpN3E2YTNyWmJIdEhrdTBQMFVTZEk1T0U1VHZNeDJHRWJpUmhQQ1RL?=
 =?utf-8?B?RWpmem9oMVBOWmhUWFY3Qnhuci92cXY0TmdxamhSV1dBKzhqc1U1aGREQzli?=
 =?utf-8?B?M1owVnlkMGlqVHVGRG5kNEhuM29aR0xubmFFbVIrbCtBOUI3TEtJYXBDd21M?=
 =?utf-8?B?cmFJRHdLQmt4RllScW5SMlpoQmRuUHd3WnYyYlB1NXRFSmI4UmViUW1uWTBB?=
 =?utf-8?B?VHR0d1Rwdzl1NVA5N2R3bElFek5rY3ZDaDJjNGNSanhsRW1penFQMkRQR3Rm?=
 =?utf-8?B?YWZnVGF4alU1eWxKN1p1T3Y2NGd2d3dtSlI1SllTQXNvcVJuZWxKWDRuNGxP?=
 =?utf-8?B?MVlDUldNL1E4YXNKdlRoSHIxMk53cHZyTGM2R0JsbHJSU2c0bGYzWWJsRHZH?=
 =?utf-8?B?WU8zODRmQklQaE50MWVhZzBXMzc3ODg3Q1BGMU5YWWVUdzNnbUJjb0VVNjZU?=
 =?utf-8?B?L3c5TFkvbW9SbWxHaFcxL0xsUnIzOVJzMldBc1piUzMxVjVkblpValdiQmNQ?=
 =?utf-8?B?WXhudGlsei9kS3NmSGlFa2kwN1NZYTRzazVrWjZ3d1pvVHgrTVVHYXlDSWNm?=
 =?utf-8?B?dW04WEVQMEphRG1TdXJGdjBydWZlTkNLTStkTVppeCtFNlM5TmVrbUNSUTI0?=
 =?utf-8?B?bEh5NDVrQUFqRURYWE1pREpLdEFNdGNpdnBPSElEV0N0dm1PRWw5OVZoaUpr?=
 =?utf-8?B?UGFLZDRaQ1VvNWcrZ3E4S3c3NHpSU3JGUUxJN00ycjRwTFF3Tk1MMW1XL3Jw?=
 =?utf-8?B?cG9jODBNakdRcmJaYlVLYVZiQXAvVTBlLzdVaE9SVEg2RUpReVBPTTdUclZ4?=
 =?utf-8?B?a0Y5MUNyWmVYTi9GeEFHV3NHVVJUSENJSU1qbFFMc2t6bUlIMlBFdTBYdGVM?=
 =?utf-8?B?RE1VRERGZ1Q5L1NQRU1jcnMwVWVVRTdWSXRuSXkxSkVqZDVuOExxLzZLeGxV?=
 =?utf-8?B?UlZaNG0vdVJGYWtiSnZrN0VsVTltd2o0bVBnVFBLN1phQUl2ZHI2MFhvc0hU?=
 =?utf-8?B?bzN4NmtpN3ZaMU5yWmk3czlLK2w3WHVIaFVjcWFpRG1QMEJ5VUtaMFIrOVBi?=
 =?utf-8?B?WXVyT1FYUEJxRERRZkl1VW5WWVh3T1VyVUc0MEhJRDJxeFhTRmNVeHh1TmEr?=
 =?utf-8?B?SUlqRkxJRWI3NzhkcWhpUFVsd2ZqUHVvK0NGRlNEVXlVSFFMTGMzcXFUS0g5?=
 =?utf-8?B?MmxLaTl3b1pkVlpDVm9jd2M5Y25Kd0c0QWdVYStTbjhiblBjaFlpM2Z2N20z?=
 =?utf-8?B?ZUh6TXlscTJJdTFiZ0pFb3NvekJJWWwvKzNwVkR2Z1R3V1N3SUJmb0cvVEk2?=
 =?utf-8?B?dm9MTEhOMEVicmlYZllZbmZ2dVI2V1BncUsrUVA2MlM5THo1RTNPSzlUZC9p?=
 =?utf-8?B?Qjk1N3JLQjkxcU9jMWVZeG44aXZTNWQya2o5UGt6SXkxTWMvLzVKTzVOODlw?=
 =?utf-8?B?WXhFQTlrOXF6RnpaWjUrUWZGUWxVRXhCVzROemVYR0JPc1orQ2Nyd3JTeEdk?=
 =?utf-8?B?bzRXbHY4L1h2Q25ZWGJzV3NlTWlkTWhkbXVYcS96UmpkaUxhS2F1N21FSjFK?=
 =?utf-8?B?UXVVcFhsdVJZcitSTDJMZGRtMkxOYnU0OTJ1SUJDTEJVb1VvMEhCT3JuZmE4?=
 =?utf-8?B?QWNnVmNaSThjdkNBKzJQbGhYUG1sQ1JINHdMb0Frbmg5Y2dzY3B2VE5kY2x0?=
 =?utf-8?B?WnJaZDdCUG1UT3FlazZTTWxQdHhYM3dQTHd0OGsyb1dtK3dhU1RLOGo0UE94?=
 =?utf-8?B?a28xcmtoaUp5MDFVMHFCQTBmUGxjcGo2WjZTeTVXdWtVTEdBRjlvaUhUWUs4?=
 =?utf-8?B?UVU3NmQ4a3RLb0NoY0xqQzByNmxxVjBIaWFlcXVmWmRZSVhNdnZLVElSRkxJ?=
 =?utf-8?B?SFByUnpWcmpsVEtLMFR1VDkwVWJQSStoZFd4TURNbG9CTEpMOVY1bzRianU5?=
 =?utf-8?B?c1dGZFduV0xLK2pvU2gydGc1Qjk4ZDQzbG9FSFJBWTRzUTVDQjlPUWl4RFFZ?=
 =?utf-8?B?L0QzMU9LVTFBMUNuK3VDQWVxSXl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(82310400026)(14060799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UarXszL01HuTidbbe/S/zcl/xsOnEMsf5ud+F+1nHsdjCgSF6vYUojMcK0YLRx+0qnBLtW2ToRJPj0c/sIWwdG86O0vBClhdXhHl+fxI+FTmolobEvP/IXd5pryPso9UWhteeQc0z0kjTNTb6ARDCa24nY0Tl7RhIxHqpAFsK950LUNHuxV0e/vq49hApcBBDvVX3FusD7exS38/Da2DW5VfcvL3qiYXT8zWDinu8o0vlAPJw4NlGEmkKEdrs44xP16WA+mDGojC3sClgw4Lq2Et8pxPYvrpbD0qh/nmEtCJYVwK6ALYk5Dc4FKCVDsLoCZTJPfu86sDmfMa1ffDfT4XKdV7EqNVRxgiCKfqfRvMjwMtTCx9+qHKAIltO/xJqFU8Usb/lKCupyueL0LUcD4zS0sldtphS/3GI+LkEcsi13vOWVpHk8iYK3sb76ZZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:59:52.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15b6e03-8f29-4551-65f5-08de64bed5a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9862
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42155-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5E1BEF3C56
X-Rspamd-Action: no action


On 1/31/26 05:11, zhenglifeng (A) wrote:
> On 2026/1/26 18:18, Pierre Gondois wrote:
>> policy_set_boost() calls the cpufreq set_boost callback.
>> Update the newly added boost_freq_req request from there:
>> - whenever boost is toggled
>> - to cover all possible paths
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index c8fb4c6656e94..505da5b00e575 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>>   	policy->boost_enabled = enable;
>>   
>>   	ret = cpufreq_driver->set_boost(policy, enable);
>> -	if (ret)
>> +	if (ret) {
>>   		policy->boost_enabled = !policy->boost_enabled;
>> +		return ret;
>> +	}
>>   
>> -	return ret;
>> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
>> +	if (ret < 0) {
>> +		policy->boost_enabled = !policy->boost_enabled;
>> +		cpufreq_driver->set_boost(policy, !policy->boost_enabled);
> !policy->boost_enabled twice.

Yes indeed.



