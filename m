Return-Path: <linux-pm+bounces-42156-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLhKEyKkhGmI3wMAu9opvQ
	(envelope-from <linux-pm+bounces-42156-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 15:07:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D916F3C64
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3D63080B19
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7053ECBF8;
	Thu,  5 Feb 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MRGWL2wg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MRGWL2wg"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B93ECBDF;
	Thu,  5 Feb 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300010; cv=fail; b=jHpAhAzGQ1+qxY7r5WDY6Puqv9+Bx+FSgPl7Ifx/opMx3baWRQrVB+e1u6cIkk8Y91s4MwCe/TZIE82mYtuNcGQy/oaihdrs74TEQsTAVoO1+uNJ6V9idKTUNWMCRXon8iM30qFwsK623HW5DGkQlDhdhixLWEp5EHZLP987sAg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300010; c=relaxed/simple;
	bh=iNa+Z9H13c/3VgtpLjT13x70kmsQqyG4SGK6699blak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sds/ejhmSlRMv/HzuL5WnVDAjhQp1C1UpTEpk7gl//zJBPUCw8XPsjGC89rrS7UAJBqi4O1GwsLvomM1Zec5z3fAGXfVuZnJ7MPsyeOxeIjpSB6oH80+coNlxYIB0qqzSqFiqVdi2W/O2FAvdNeUGYTh4qq2IxyM1z3J1QRw0T8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MRGWL2wg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MRGWL2wg; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KAUskp1dOZbAAH5xg3CilW+HAC0pA7GPQLP9ggnBL3xZSbPZOwHJsDGRzTlZsIlLCpeQX9OyaqS0fqpJ2NNehRprs7vo7f7TA5ILaxNUIUjiT9awo6FC9uhQ8f9l5qGjdGvMbzcWWlXh6du9VDYQYcGssAQ1No7MVYi6hPJY6IK9xJjer/qNtfN26wXSB28Xz0Vlr0cf90JUrij7W64NWnd4UB4I6FIXF+E/S29L2MhftwVhh6KdxRVQI4cE4j2uE8+ifYDErpMLeLAIaDDMrf1EYf8h/JhEd3XlqzqpmGFK5665CGtemiKGRuWxyCO+23hlxUJXqjyLLVAZQfn/tQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPlhclYY6ISBRDL9NYsIMNt+ZOVY7YaAUJm8+xNpD14=;
 b=BKMIvooP3Z1d+vEcAGXFNDUDmPKU7ottAFFhQzAGQDpUW/3D+44Dgu3+KlbRbV658+M4BkvFFSKYOihDygeamszkuB6+LxexpLZ/GlCo7gCZdgJw7q07L4KX51S5tCkUY09zyi9SeSBA4VV0K8dONHPxTd39bHRqAnegtNm0EGj0WjUUhlyH5lxixei6WKZwVl8M7nrNGSFz6crPEUVMimyW95iYE6t9T+ZFfYcFe7f0V2f8nqRZ/y6O4K+KKjO/w4353geAy3cAD+safbhLYiyJspQbesYHyz6NrU4ju3J4HzXogzfcK5FubMyENU4D+KAz1cUN8LrFGKtocG1xLw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPlhclYY6ISBRDL9NYsIMNt+ZOVY7YaAUJm8+xNpD14=;
 b=MRGWL2wgiUVRXfmNxM3mxvF5UlAX3DAuMhKNnFKG8a1z3c/a+te8eRJleWNjOVX4cr7KZ+CEw1K3qlm5mEHd88uMOmpvIzValLe10fCYYTYZ6m7NwSX8pgHzNvdyhwh8xE+mkkCNcTM/uK6VZwS/TktzHRADX4E12DBpx3RoxG4=
Received: from DU2PR04CA0052.eurprd04.prod.outlook.com (2603:10a6:10:234::27)
 by DU0PR08MB8346.eurprd08.prod.outlook.com (2603:10a6:10:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 14:00:01 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::f1) by DU2PR04CA0052.outlook.office365.com
 (2603:10a6:10:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 5 Feb 2026 14:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10 via
 Frontend Transport; Thu, 5 Feb 2026 14:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrZpAOD2DOzry/hOA7FIy4ZsEGwnmxQNGtSFR3mzc5o+NnjeDQlTQoQWTkj63bevvWkA1HehsjxRLnGrePHdiBVr+K2D7ssCv35GBMPuoA2hyfJH9P/j6VSSiFaRYo/5yKTGn5JPzNSPE1RMQvfHP8FjTUXFqTcbV+v5VAwFu+B7N17Nj2JagD0yIk7U/9XHn0yge+VShoMFyK/IofjkDBFE57dM6gwRGZnMmhI/Wa0sKG2Zud+vgs3Cf+xZ0CkCKWWn5zf9hBpethaNVq/NC6kMAGQZsJbL9IOvOdgiikifWSFw0P1FMCmGwysXenskTD4/IjRbGK6Sn8J0FjQ86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPlhclYY6ISBRDL9NYsIMNt+ZOVY7YaAUJm8+xNpD14=;
 b=OyjhOgK8lhkuCYFItGZ37HnRVSJpTLKoe56PzpCsUoZDrMLHIknjDVKDlz/S1A5CWNo/EszJkJtTMjICaHmSigE9rQXcwkYZTjEBbNXLC+dT6SHdBDC3lj8HGGPSimkaS9ujpQACAczfTAFAvzNPEC1BxqaZRIct4aEjeY/Ywr/09Nm12MJcypXfW+8qwGafQ030MDGDKK0+nEPmEdD6hWIhWZL+AqC3GMzOvoeK7QiSnRsbJaOB+hr4sElPO0DZt4qVlBHFt3YqMIZ4ilV9Pc/C59FXM67lMHJaNVp1QPgXHUMf4NlVdTO4hnPH+V+841q463tFOKRt0YiOB97I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPlhclYY6ISBRDL9NYsIMNt+ZOVY7YaAUJm8+xNpD14=;
 b=MRGWL2wgiUVRXfmNxM3mxvF5UlAX3DAuMhKNnFKG8a1z3c/a+te8eRJleWNjOVX4cr7KZ+CEw1K3qlm5mEHd88uMOmpvIzValLe10fCYYTYZ6m7NwSX8pgHzNvdyhwh8xE+mkkCNcTM/uK6VZwS/TktzHRADX4E12DBpx3RoxG4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBBPR08MB10386.eurprd08.prod.outlook.com (2603:10a6:10:534::8)
 by GV2PR08MB9254.eurprd08.prod.outlook.com (2603:10a6:150:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 13:58:58 +0000
Received: from DBBPR08MB10386.eurprd08.prod.outlook.com
 ([fe80::dbf7:8c18:3fce:e74d]) by DBBPR08MB10386.eurprd08.prod.outlook.com
 ([fe80::dbf7:8c18:3fce:e74d%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:58:58 +0000
Message-ID: <1ff87fbe-6457-4ea0-918b-dbf109663dc5@arm.com>
Date: Thu, 5 Feb 2026 14:58:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cpufreq: Add boost_freq_req QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126101826.94030-1-pierre.gondois@arm.com>
 <20260126101826.94030-3-pierre.gondois@arm.com>
 <28f83199-557f-4305-baf5-01fb4fe2cd2c@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <28f83199-557f-4305-baf5-01fb4fe2cd2c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0421.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::12) To DBBPR08MB10386.eurprd08.prod.outlook.com
 (2603:10a6:10:534::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DBBPR08MB10386:EE_|GV2PR08MB9254:EE_|DU2PEPF0001E9BF:EE_|DU0PR08MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: a3645634-7130-4681-802b-08de64bedb19
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VlR2Z1NOMmRNbzRwTlVDaFNRRk5tQlU4ZzV3VDcrcDFFYUhWWm1MK0tFMDds?=
 =?utf-8?B?OERJb0JraGxUSEJSZy9IdW9tN3BFK25ieTVSay9md1NMd3VaS1lySG4vOFUz?=
 =?utf-8?B?S21sTndydy9Sc0FqZmkrVWIrN1g4eWFFSUcxMm9jcG1WRkR2KzBPamdzeTBK?=
 =?utf-8?B?WkMxWC8wT0w5bTFvbjZjU2UwQVdnVEg1cmFJUmpyRGpyaCtVUi9rOHNRS3c3?=
 =?utf-8?B?ZXFXVUFXdXRPMEppR3JLOUVlWW5QMXJsSHQ1cHpyMXh3ZTRLV29sRU9aWGtF?=
 =?utf-8?B?OWVBalJOSmZUSUVPOXcyRzhqc1AyeU9pOG1MQ1NiRjBiTGdQUmFkdzNha2VZ?=
 =?utf-8?B?SGVaZUthUnFCQmtPTnIrd29NV2o3NDgvOW1GQXpCdjFXQWtoYVRneW1BWGlm?=
 =?utf-8?B?VTBEYXA1Z0k2WnpPa1VpMXFzZXRqVDB4a2pVVWw4ZU5IWC9hbmZuQ3VSaVdw?=
 =?utf-8?B?dStPOGs3bklBYVV0OTM0SGtZKzZTVWtKSFh0OTh3dFNtUXZSWWN4VzRBbVl6?=
 =?utf-8?B?NHlPWE9CTDdGeVBvMExuRlNTK1pUdHVNZmc3dmwzaCswWGZHbFNLWlNmaDlQ?=
 =?utf-8?B?K2NNcmFlRlY4SzFJWTBlVUhiVm9nVjZlRFRHSTI1Y0RMN3FIZUg4dEZMWGFu?=
 =?utf-8?B?cG1kbWQxd2IwcURyOEUxa3ZnbVBZU2orQmlSRWFoWVoxUUtZOTV3cS9IM0ho?=
 =?utf-8?B?azg4OE5QTm4rTVliV1hhZ1UvVFdhRXdGQy9EK3NPa2dQY1FMWSt5KytvZndz?=
 =?utf-8?B?U2tKRDBIdGlhbDNTOXlvM0VYZ1cyOGMwbjlZWTlBMzFRRTVnTEIyUENIZ3NZ?=
 =?utf-8?B?NjR4RWZaUmNCQlJkc3FOSjdnWUpVakszWWdnRjR3TStxekZOcDZNZmo1RnlZ?=
 =?utf-8?B?c0NuNXI1ZlZ0aVQ0L29OMzdTU1dGTkRlRTdpNUN2M2dyc0ZWSFFuNHFabnBz?=
 =?utf-8?B?SEYzMGdCZDVPRGFkS013SXVFa2xQUmViK3ZmWk9UZmNZR1VVbzBFZGh6SHBs?=
 =?utf-8?B?UVlwenVuWmE4WkltR09TaFlmREpuQUZKLzFMc2VBVVVBdDhQaGJ1V1hPM0h2?=
 =?utf-8?B?SGpSMUQrMDVqVmk0MlVDZ1RFSlRRUHpjaWowZXBXUWFFZEdJWWZLdTQ1TWls?=
 =?utf-8?B?Ri9kcU1VU0JkRGhWeUR4QlBSRkN6WlVrUG1YVjdEM212d1JrL3FmWm1LbWh0?=
 =?utf-8?B?RE03dXY1OWJLdkxyMnIyQ3c4TlRTRXFlUzBvUkQyM1BLNU00YjNOSWhpQkVZ?=
 =?utf-8?B?NWFiZ3REV1Bld3RZNzJOaGltTVF1SnJTUHlIOWVZWEpNM3UvdEtPL0J4L1RO?=
 =?utf-8?B?R2hkV3hNdzhuY0xYRWpWbHM1M0xSZzg2SE5BajgvRTVXaUE5Ri9MbEJkZDQ3?=
 =?utf-8?B?azBOMDFvNjVjRDZJOXFxVi9MV0ptREdkUEUyYnErMG1aUklwa1hhRk5hQ294?=
 =?utf-8?B?OHgrVjBjazhtUUovV0NtN21jUGF5ZW1GY1VRMUloM3ZWY3BxeHQ0MElrNXc1?=
 =?utf-8?B?bHRmRmZ3YVkvVzVRMjA5LzByV3Q2N3U4L2R4QXN5SWErT0tva1pkL3F5cU85?=
 =?utf-8?B?Y0ZLQXFtNG5rR3UvTkYzRmlING0wTXBUQlpsdHArM2krVjV1dDB2QitabFZO?=
 =?utf-8?B?c0U5NDkrODB2anBOMlJCU3pDOHdCN0Y3TjU4R2YwTWl6ZGZOZjJnSW1NUHov?=
 =?utf-8?B?ZGErRG11alFNdWhNUndUa0I0eTZkN2xmWlJKVFZDTlY5YkNWUmZNMjJEdjhV?=
 =?utf-8?B?TjdvaE1xYU54NXN4QnZJTmdON2VoMTQ5UlFYSmtoMEQzRDF1TVZhaDZCQTVE?=
 =?utf-8?B?dVk0cFBsRFNxMVVWTGhQK3dFaC9Ga29qOGNENUZnbzFmSGVCTlRET0xCdUJH?=
 =?utf-8?B?bTF2NVBnUWw1RVNIN25saVArQ3JURGlxbFR4ODk4aVpBR0dUOTZCYS9MaDdE?=
 =?utf-8?B?NVU0Vm5mQm1WbXlvcFd4MTROL0Y0Q2c0enVQTEcxdHVWRnFQendsMzhjMmwv?=
 =?utf-8?B?dFovQ0ZjUG9kc05iZU5ZbkNkS1BhU0FXMDRGVnAvVW9ocExKd0l0a0FwUDQ0?=
 =?utf-8?B?QjFPclZ4N2J1bnBaUGw3ZVJoVE5lYmcxSWkvVzBaL2xEOThCR1ZsMzhXZkkv?=
 =?utf-8?Q?mhlL9q0/B0FrZZYKpLPxRD4HD?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB10386.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9254
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8c66f89e-2f66-427e-c859-08de64beb52a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|1800799024|35042699022|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmxyeWVtUjBPbVFvSEloRkJrMThJYVNsSjJDcEs4dWxvb21DYVhQT0VWNkhY?=
 =?utf-8?B?emEvWURKOHZZeFUwY0V6a1l6UVNYRWR6aWtCa25PMlh1b1FSZC8wZVhJY3JD?=
 =?utf-8?B?c2YrU3U2ekFXemZJaWJhVCt4LzR5ejRheVMrQ2h0SDdzQk5TMjdNckVhWmVK?=
 =?utf-8?B?ckpMOGRaWXFpa3l1K2NGYUZoRGZkTmt6S05adVYzc1VRRE9XSHdBZUQ3cUNj?=
 =?utf-8?B?MDMrb0x6TW9USk0rbXZKYXBzdXZJRVpNTnRyeU4wbGFZUmNnSnF2Z1YyZVdx?=
 =?utf-8?B?eGZvWTNXVnhpbWJzS2xyWEZSMlpoOUI2R1FUMElNVHlFZEJhYVMzZTk3ekJr?=
 =?utf-8?B?OFB4eStYTFd6bU1uK2IyQjR5YmVOU2pYQ1BjSXZ4MWtBL0hEQU8vRXZ6U2lI?=
 =?utf-8?B?TmsvcCtnUmlUTmlBcVB4TGlpdVpZRHIxZS8ybUJ6L3JqYjhaYjRxZFVkc201?=
 =?utf-8?B?WGxqZUt1bDUwTks3ZXR4NllxT2xaQWdlTndZZUUvYzRZYW8vVTlXdmxTOEFE?=
 =?utf-8?B?cnBQV2dLWUpCODVTUGhCOXdKbnZpb2ozOGlmZE5KMTAvUHJMaGVZdlM3TmVu?=
 =?utf-8?B?c0I4U1c3ZHdrVjJubXM4RFc5Y0ZodFYxTXEweG51RDMxdWluYlhhWDRNb1ZV?=
 =?utf-8?B?aDl6VjFNaDJ4UjR1cXVjT2dMRUwvalY3TU5KY1V3UTJpVjBaL3JIWVA5QmZB?=
 =?utf-8?B?MVc5RFAwaHNFNXNxYy9OZ2lScVNNMEVBVjNvczF2QUV5eFU4bzFqbmFROUpC?=
 =?utf-8?B?WlJVZFJVbE9WUVhWT083TDkwZjdRMmlwcVZxai9MR0JtbHRsK2RHOW0yU0ZZ?=
 =?utf-8?B?N2c3RWJWMHkrNVE2WlloTVpSMXBER1ZoQ3hnV05xYTR0UEJVVFlqUVBiVjFG?=
 =?utf-8?B?Wmo4a3RjbzFnRHpwZXYxTytKZjV2SU9CclJHQ2ZPbGh3cWloak53bS9BbmRH?=
 =?utf-8?B?TnFlaDJTSEJaT0VSU0RnbXpnQS9VV2RVWG0zYUhHTkpPbXh2SzNCcERZK1lO?=
 =?utf-8?B?K3l1WlV6SjhvWGN4L0lRUnZ4dVRHRXphOUNsSi9UK3BkeDRoUjJDMk5XbElr?=
 =?utf-8?B?aEZpQjNSZzZoWVMwRWhEUEMwVEIxK1U0YmI4K3FETmV2UTBvUHlqbitFWUFs?=
 =?utf-8?B?VDZYMm5qa0N2MGVEei9uZEkyQWtxUFdJM3c3QktmRGNRcEYraFNPc3Npc1Zv?=
 =?utf-8?B?L1g2UTJwTythYTBtay9aeHNVeHp0QXUwV1M1SG52blN3SEgrYUhZYldLYUor?=
 =?utf-8?B?eHBOWlBwNHQ4ckJPbDBGM1g4VVFyZ1hhSXMrbzMycXUzU1NnVmxXS1czbitt?=
 =?utf-8?B?K3FFOFZ5UFhDSDU1TTkvWHE4YXNUMXdYb0RneDFoWVA4aVJDM1g0S2QwS3dP?=
 =?utf-8?B?NHA5SlNIcUwwUFFrb1h1OE8xamp1b3VtWE9aU3E0dHNWTjkrZDJrVVl4MjQ0?=
 =?utf-8?B?alRvRXV2Yjk4cnFJOTA1bHBqSWFEczQvUjVCMjVQdmpJK3Q0aXBGU0dNKzhB?=
 =?utf-8?B?NktBeWMzQWJpTVVXakdWdi9kYUJqSzd2SXZ1bFZtZk1kOVN3WWttYUtySWt0?=
 =?utf-8?B?aXZTa1djLzBoVmR6bG16NWpxTmZ5eHdpTTlIWkFLc25lVzRwM01xZHpTd0pv?=
 =?utf-8?B?eklnZnI5Ullhajc1QXJRR1RNeDBGZHVmOVljSmxvT1NTQ3FWaWxVckp1REdQ?=
 =?utf-8?B?WGkrN09aUWxYblozVDROL2t1SmdQdno5cStXVjdtd3RrYzJpeFhYclFEVHBV?=
 =?utf-8?B?SndOM0RTL2FHSkFCSUUwdnVJMi94S3BQTUtLMlZCOTNsMUcxV0hRTUU5aWVn?=
 =?utf-8?B?NXZyUHBVd0p2TjdvYVVpTnpSeWdJWUFaV0VvV2ZlbTZtcGZtQjFuTWtMM2dD?=
 =?utf-8?B?UnFMV0lBbGhEQlBRcmovK1N4ek1iaXJ4VWxlWHJSaDlvakVOcUhBSGp5a1oz?=
 =?utf-8?B?bGMwbkpreUN4aW9YdXlnRC9kQXd1d2l3TFZLcndqc3c2Z09uMHdaZHVFc2hz?=
 =?utf-8?B?TVY0eE9UVzh4cXNpcGx5QVlCQUFlamEyeXlsd3Vpa1Zrdm44cXBVRzlyMUpG?=
 =?utf-8?B?WTAvU2hwZXdIQzE3dUF0QVJ4T0hNOStGd0dZN0FITms2bEthRjFTdzlqbm82?=
 =?utf-8?B?TDRmU1hja3dUL2NkRXlqZzlPT1prWkErTHA2eEdLUFl0U3pvdGtoZC9YMjFB?=
 =?utf-8?B?SWphaUtiQU1wQjNNQnFvd3VqdkNTNFhxYVVGdDBhRko1VEU1VW44bjZhQ0dH?=
 =?utf-8?B?SFZIa0RoN285M2Y1NjBET2FsNDh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(1800799024)(35042699022)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NGO/xAnCYdE/AYf4wn+QNejLOceOhVqroZPs/WHDtdG2YcZJxA1p2kx+1T6wN0QXWORXxEFGIw0xwUGaHkZdZnMLDqf7tlzHB/To8jOsEzxcWr5/oQBNYk5l/zFtrDUKzyIx97NM+PbUrnlMiRtHcawlmhXg+RhkCgqnXU4zWdEVnDhQWvK4KpT60ff1xP4eaV/h3ujcNneIOupTlUH7U2gz6qi8EEM+fDLDp7t/no25Jpxg7a3ANCcLGdOKs+R+XwnB+li6d0In/jKYWvL7xf9Lq035gzUzpOPpw8PYhEcz75bCscej9U5KyNHoZH+kfzBtZv8yLn4sNz7dtIXnDPwQ6VDg6EPaw1oibRmCiRF4AwALcdQVUnvX1k4TKCrN2LyfqBKCM/MT3KrmszLi8Q5xKCUIC88GE3cdKe5itzpQPJsQXLBgdls4H4qem3DH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:00:01.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3645634-7130-4681-802b-08de64bedb19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42156-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9D916F3C64
X-Rspamd-Action: no action

Hello Lifeng,

Thanks for the review,

On 1/31/26 05:00, zhenglifeng (A) wrote:
> On 2026/1/26 18:18, Pierre Gondois wrote:
>> The Power Management Quality of Service (PM QoS) allows to
>> aggregate constraints from multiple entities. It is currently
>> used to manage the min/max frequency of a given policy.
>>
>> Frequency constraints can come for instance from:
>> - Thermal framework: acpi_thermal_cpufreq_init()
>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>> - User: by setting policyX/scaling_[min|max]_freq
>> The minimum of the max frequency constraints is used to compute
>> the resulting maximum allowed frequency.
>>
>> When enabling boost frequencies, the same frequency request object
>> (policy->max_freq_req) as to handle requests from users is used.
>> As a result, when setting:
>> - scaling_max_freq
>> - boost
>> The last sysfs file used overwrites the request from the other
>> sysfs file.
>>
>> To avoid this, create a per-policy boost_freq_req to save the boost
>> constraints instead of overwriting the last scaling_max_freq
>> constraint.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 40 ++++++++++++++++++++++++++++++++++-----
>>   include/linux/cpufreq.h   |  1 +
>>   2 files changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index db414c052658b..c8fb4c6656e94 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1359,17 +1359,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   	/* Cancel any pending policy->update work before freeing the policy. */
>>   	cancel_work_sync(&policy->update);
>>   
>> -	if (policy->max_freq_req) {
>> +	if (policy->max_freq_req || policy->boost_freq_req) {
>>   		/*
>> -		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
>> -		 * notification, since CPUFREQ_CREATE_POLICY notification was
>> -		 * sent after adding max_freq_req earlier.
>> +		 * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
>> +		 * notification, since CPUFREQ_CREATE_POLICY notification was sent
>> +		 * after adding max/boost _freq_req earlier.
>>   		 */
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   					     CPUFREQ_REMOVE_POLICY, policy);
> As we discussed in [1], CPUFREQ_REMOVE_POLICY notification will be sent
> here without sending CPUFREQ_CREATE_POLICY notification before if adding
> boost_freq_req fails.
>
> [1] https://lore.kernel.org/all/a615ab13-bd54-4051-ae61-2bfe8b59427e@arm.com/

Yes right indeed.
The following condition should be more correct:

if ((policy->max_freq_req && !policy->boost_supported) || 
policy->boost_freq_req) {

  ...

}

>> -		freq_qos_remove_request(policy->max_freq_req);
>>   	}
>>   
>> +	if (policy->boost_freq_req) {
>> +		freq_qos_remove_request(policy->boost_freq_req);
>> +		kfree(policy->boost_freq_req);
>> +	}
>> +
>> +	if (policy->max_freq_req)
>> +		freq_qos_remove_request(policy->max_freq_req);
>> +
> Thses two 'if's are unnecessary. It's OK to call freq_qos_remove_request
> and kfree when the QoS request is NULL.

Ok


>>   	freq_qos_remove_request(policy->min_freq_req);
>>   	kfree(policy->min_freq_req);
>>   
>> @@ -1479,6 +1486,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   			goto out_destroy_policy;
>>   		}
>>   
>> +		if (policy->boost_supported) {
>> +			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
>> +							 GFP_KERNEL);
>> +			if (!policy->boost_freq_req) {
>> +				ret = -ENOMEM;
>> +				goto out_destroy_policy;
>> +			}
>> +
>> +			ret = freq_qos_add_request(&policy->constraints,
>> +						   policy->boost_freq_req,
>> +						   FREQ_QOS_MAX,
>> +						   FREQ_QOS_MAX_DEFAULT_VALUE);
>> +			if (ret < 0) {
>> +				/*
>> +				 * So we don't call freq_qos_remove_request() for an
>> +				 * uninitialized request.
>> +				 */
>> +				kfree(policy->boost_freq_req);
>> +				policy->boost_freq_req = NULL;
>> +				goto out_destroy_policy;
>> +			}
>> +		}
>> +
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>>   	}
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 0465d1e6f72ac..c292a6a19e4f5 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>>   	struct freq_constraints	constraints;
>>   	struct freq_qos_request	*min_freq_req;
>>   	struct freq_qos_request	*max_freq_req;
>> +	struct freq_qos_request *boost_freq_req;
>>   
>>   	struct cpufreq_frequency_table	*freq_table;
>>   	enum cpufreq_table_sorting freq_table_sorted;

