Return-Path: <linux-pm+bounces-15827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B09A19C1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472FF1F254F9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 04:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2635A117;
	Thu, 17 Oct 2024 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D1MDmSnw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318F224CC;
	Thu, 17 Oct 2024 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729139568; cv=fail; b=CqdyLT3Az7Ex4Ts9yaeeGfegwQaNeyKWKYUVXtYlhOHrMs2jso+Q0oNHk3cZpNfWHt+cREyveRpfiRQ9XEjCUP3/8Oxc8JTB88z5y52WpyMjjd1T6E6v3Iz+/qF+RWP+LWeB+B0x7D9WwfDn/2IexxDARRM3xSGnyMQnYpR8A2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729139568; c=relaxed/simple;
	bh=I4QbZ9LFfa2aolWTStzEZQTsEeqXedNxJGU4TxIzBw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhIXHDssNMjI3+Ld8EyADQ6O/sp4mOffdOinpH4Y9on3SODIajiVIXCghGDCzpPp20F7zYc1UERLMyHhfcHsy0ATeuP7VVqXG50rqgTDNC8I/vUEtpjLJW5DZuAL4nCTQJHSH4xdkEuF0m6HWm3kV4TYWzIHucRdjdpYDqWTXbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D1MDmSnw; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZNvmwANhoAgV+7/kIu2JjqICd/bGv2cBqtaWrM47YKD2qpmQazzoUIuFH4N7SnMr1R6zXygCIyWEH3b8x9x0cWJ13y2rv6O4QhzhpW/SJyhs9vTkqmltgXvCMfJLjMM0xsZ01PoFXopfgREog2fSHsbCresZ2pZbUMPrdqjZdRvC6RfleFOBWL66VMMLXreeIB+dyPWSu2kEOiS+HBBMjn6YW/oiBOIqq9Hf9rB9te4Vw5Yqia9Lm/JA+HubpHQSeRQz4X4KI7x4b9umT/T9p5/IKk76L/c7nfdtKfmpbphW9rkW/ayIu1k7drWml/zTk2WI88DnJbQt/1DmEmjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCxolrBAoU2DCLHuyaprgyeruios8XXrgaVSL0+D/F0=;
 b=nrs8EXk15Q3P5zQ3n+GhNv6JypORSwYDdOyXG/aHONhFhjij3HGpFQS8xfQJvTH4Kevgks2BOdxSYNRWGWM0dd8tRqMXF8JXchhIR6NCrhJfbHkUobvwpApmVVVeW0euneAu45Tw6OsSn6NdSnCqN02VKIMZYShAV4te1YHCsDvxtdK7ph/skrZgDp9QAUb3zx3W8GojyvYyoY2P40y1Vd6iQnJWYIzv1IxcCsIWIsYGyo3Ofr9uPA1e72hZPD1rupbc5Wgj/sjkkQasyhZalCZ5EEBs8b+z7+6WyoUyM04ilTL4xDGbFHE2j6+Fpbg5Y9SLgjOnputv40ealLv/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCxolrBAoU2DCLHuyaprgyeruios8XXrgaVSL0+D/F0=;
 b=D1MDmSnws/F7B3zV3KyMhLUoKcPqpGb2KZ/5uRDZHrti86H9Di1Svi+BgLbDU0RmqT08TVViOfWj6A/TU32qgzVSBxrAyNho49XS2/6leLp76KhU8YhC4Js2qfyovpHtzEB1nXSDBCv7PScbAb+g6RtnyMeyMWwrqrGp4Eh303o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Thu, 17 Oct 2024 04:32:40 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 04:32:40 +0000
Message-ID: <db3f2bfd-803b-4725-8e8a-3ca24d4149db@amd.com>
Date: Thu, 17 Oct 2024 10:02:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Set the initial min_freq to
 lowest_nonlinear_freq
To: Mario Limonciello <mario.limonciello@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
 <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
 <f54901f7-fdf9-409a-bbd6-6b08db00e125@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <f54901f7-fdf9-409a-bbd6-6b08db00e125@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5a5c94-1b6e-4ac1-23a8-08dcee64bc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9uWnZaK0czRjBKYnhrSjdCcEdXMGZkdld0MzlQenA2Y2hRbkk1RzFjYkU0?=
 =?utf-8?B?TXhWUVlWek5Ud1BsT3NQTGtuYnozZkpMZGRvZnBIS3lkWWJyZmdKbTlCcUhN?=
 =?utf-8?B?dUxPU21mRzc0NVhWZWpvVk13K3p1cGs1RmxHaStwaS9nTmFhUHdmRnprQjNV?=
 =?utf-8?B?cXdoRnE3em83QmdoOWIrVHFOUEJlREJRejJkc2psZG82WUR4QUNrZ0tLd0dX?=
 =?utf-8?B?aVc5b20rT090eGkwbjdaekVPYmFMaXNNK1N1WnlLZXdzQ2lweTZMOS9yUlFl?=
 =?utf-8?B?eTNvSjc5blF2aFJ5dUQ3d1oxSjU5NjJLYWxROUZFQXd6OXoxNTJtSWpYYkdw?=
 =?utf-8?B?TWlaUzJ4aExsZjdCZUQwd1lEbHlVdVREa3A3MEpRNXZyaWR1VU9vOSs4dmpK?=
 =?utf-8?B?OVkwc0g3SHZSZWFiZzZSZEJ4WEMybTN1N01zUFAzd3pBWGJub3kwdU5PbHAy?=
 =?utf-8?B?NVVwempHWXExZFZmVWZOcGVXTE9ZZ2ovSm5TUms2d21KWS9mSytyaE1wOVho?=
 =?utf-8?B?UHdqT3NydWlaTU9rUDdERHJMYmxxbytUaWRvTXgvem9SY1JLeFo5MGhjaXg4?=
 =?utf-8?B?elNnSFVyVXFpWHZMbUpyZnprbW5xcXJTYlBkZjFtQUpZMnFVOVlGRkNtRzJ5?=
 =?utf-8?B?UUdGUnlTckpjQSs4K3V3djRsU0pEeEg1L0lsNHFlTFprWEdTTWtibEl4MUNC?=
 =?utf-8?B?bUlMKzRIcXkxWHZoWFJESlNIVXlORGFuZ2RORzlqUUEzbHAxaEVuZG9Famd2?=
 =?utf-8?B?MjRlOUZ6UlExenpWOVA2K1VUcHBMbGhGRmtPcnRlYmJxMEQ2a1lNaXZXSUhF?=
 =?utf-8?B?T2p3UWFWN0dLNGRWMjVDTUZIOUt4cmlremxmQzAyNWFOUXQxY0FKQStabjRJ?=
 =?utf-8?B?b3hiR3Jma21pT09yZ0xsTk5nckZLMGV1bWxiaHBuSUJlc29vTXVnLzhBLzJF?=
 =?utf-8?B?VmpXenFIK3JKTncxNkZ5UktZeWhEZHVDcXEyUWRwcEFoY2tIbmFiWjNrY1RB?=
 =?utf-8?B?K0RkMVgrYmpnOG0wR0hoOGMyeUtZZEdVc0hSM2NlOXZxR3NvdGZCWjdkSkJZ?=
 =?utf-8?B?OUc0cDJJL1htdkVIdVRXb3I3RmRFSVkzR0pWU2R4TXNkV290TG5wMWczKzA1?=
 =?utf-8?B?eVRFdEg5VWgwSGVXL05KN0lORFJqa3FGcFFrZlZBZFdzaEhjOHJVR1EveU1Q?=
 =?utf-8?B?VHVIWjYvYk1obTBBbjI2TmlDTXRuSURMQmlpUjRRVTJCM2QzdmFYMC8xdmNy?=
 =?utf-8?B?eHE3Qk1HcGNnM0FDaUlVRjFWQkhneHBUTDN0U3dpdktUMEYyNml6OEJBWFhC?=
 =?utf-8?B?V3dYZmZQOEJuMS9xek4xbzJrZnRxVTZkSUgvRFpKbXJEYzFKWGNkNjI0clZ4?=
 =?utf-8?B?cVlJc2lIMXB2SzlpSmtSWThHQTg5RzNoZGpKcWlaTTZISElReGxDc0lTYVFH?=
 =?utf-8?B?bzhFQW1QZVMxRml5VkI1T3FtZGVYQzVFeXlMbVJrbWlPSzAwV0ZleUpJdmla?=
 =?utf-8?B?YnNHa3NscDR5V1BMTVJWVlp2VE9uUXJvVFRUaGlKUjYyU0pCTHpXbHJvaHBI?=
 =?utf-8?B?bjhhRy92ZS96ek9lMXpSZVAyWmZjazIyeXB5WjBhV3hweVRNaTVaTzMrYTJF?=
 =?utf-8?B?THdFMzFSTVlHbTFzZUVxdG1aZTArakg1SURTMVVURnZOSXpVTlJPL1Q0YlJz?=
 =?utf-8?B?elNxcmtDOXhRclh1WXlNYmQ4YUlVSjQrelZ6TVRhdE00TExZVzlURmJlZWMw?=
 =?utf-8?Q?ES9Nup6TZUH+dnU3X9eM5n9WKje2pcuUhNkZPIx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTVDNEw5dkxadkFRZWR6Mk9VRGsyS3FndS9IMjFvM3lRVS96UWhSWVV1YmdM?=
 =?utf-8?B?QUtIcjBCWGpoMmV5MWIrbjZLOFRTR0E1bFNwdlpJaDdRbUxxYlhuT2lwQ3hn?=
 =?utf-8?B?ZS9XU0VVM1ZSY1FwZWtSeHlvWEdCWTRKemdJanM0eXJ4YU91Y2g4Nlk0SEk2?=
 =?utf-8?B?N2kwNnRPUUtnVkV2dnNWVXYxNVF1QUpuZ3h0R3JKWVZCRmMxd1Vac2Q4QUhD?=
 =?utf-8?B?c2ZWVG16NFZqbFR6bnM1OGhkRXhrNjVvQkMxUHBNaytlZldHQlZESkIzSlZz?=
 =?utf-8?B?UDhTVC9vK3I5Szcxek1TYzlMVUpWWXJGMkVsN3NDRENZU0IySXVOWUUyc3Fm?=
 =?utf-8?B?SjlCU0RYTFR2YmFEd3luTmt5OW9JU0k0UGtiSUdiVlZlVXd6dzFndXpXdmZl?=
 =?utf-8?B?MWl4SzNMN1VtQ0RBcUJ2Q2ZudVNlTWxLTjhzNHZBUW9YOHI3TExOU1hzMys3?=
 =?utf-8?B?ZC9uRjhuWE9zaG0vb2FIVnlnODNuVmFoeE5aWjFSMzhoSUYvbW1vYXRNWit0?=
 =?utf-8?B?QytRQnJyWjhZVXNWZEwydUtOa2QxanhCU2EyaDFFeTRPV2lQNU9IbWtWeEYz?=
 =?utf-8?B?cndRRzlNQS9zWENzQ2tRYi9LUnAvL25MRkRNQjFzN3JFUFBrMFZGSUNMUm9l?=
 =?utf-8?B?UjNvN2Z5T3hPWHpIdEpxUVRJNmxOTlR3dzd1ZEgwQUFsOVl4WjIxQUdzZnhX?=
 =?utf-8?B?L2tSVWF2VzZQS2crVkUxT2s2N0RYd3kvNFVXa0RkVHh2VXBLUUwvUXBhRmxl?=
 =?utf-8?B?azhxazR0cCtPR1RKTm5IQVp4b05xMFRZNUhlbVpFS1V0elIrOHdablhwYks4?=
 =?utf-8?B?djZZcGxrcTA2dlFuUVNJNlU2YzlJNzZycEJ2ZFhLcjlucmtXQzRnQ2NQZjN0?=
 =?utf-8?B?UEd0WU5nZjI2azZmdFlJTDB2Uk8xeHRrcHRXblhZaUlPbDg4TFNVcWZTL3NG?=
 =?utf-8?B?cFU2WUNpVUI2bWZ3TXVDOHBYUGIyZUZycDFLWTZjZjFVUSttanVtd1pheXhP?=
 =?utf-8?B?b0R6TnhpVXBYRDVTZGNGNzFkbHRDMnpzWEFxNGNWa0srREYwTmhzV0p1TE9s?=
 =?utf-8?B?a1NpT1U3USs5UGt1bDM5TzJqVzJsWVNMZFR0czRhODRWdWM2TXB5TTlZS1BT?=
 =?utf-8?B?bHFKNGlDTkVucUdUZzRGOGEvakVPdTkrRnV0d1JpWmU4NE93ZFY4YWpDWEFr?=
 =?utf-8?B?YXFFV0hwVzdUaUQ4YzdLdi92TlVjSjhKcTBJOEIzNXJEM1IrNkdKMjZNcllm?=
 =?utf-8?B?cXRaYkpLQ3NCeGNZWGtteis0SXhRb2hBZk1XSmpQMGVZSXhKYWFrRitHTmRN?=
 =?utf-8?B?ZFhCbUkwSE82M1BIYnBua3VXbjZJMWtzbUsyV1lUUm1Hd0NCaGJENldnTE9N?=
 =?utf-8?B?THppeXVJdU1SK1FhUEZ6THIweTJJYWxOK2x6dE1tRXNjUGN3Y0xhc2ZzK0xk?=
 =?utf-8?B?TFlsWUQzeUNLY3lsajdEa0s1b09lTW1uTVpMa2Q3ODl6V3ozYk9MeUxVMkMx?=
 =?utf-8?B?Q0hkL01sVW84RTVoN2FRbjJFaXFCYWdnV3R1U0ZFeFZLclMySzVVWkMyRjVZ?=
 =?utf-8?B?WTFpUy80YndHeVVXY0F5eWpOOXZEeGdjZXhCaGowaUlad3IzUXBhQWkvd25W?=
 =?utf-8?B?T3ljVFY2ZVpZbXJwRi85SlhHaTZHYk0ydC9RN1g5S083aG9HWk1FQWZMQlRY?=
 =?utf-8?B?M3c0VVZ0K1dlRHhWT1VLQ3VXeVpjMTJOZVd3NklQTmdORklpdmxLckRQNVNn?=
 =?utf-8?B?NEFmQlo1UjJxaHZYRUV6cjBIcWRncFoyNUpiU2I5cUxiTlVYcUR6bUl3NWRm?=
 =?utf-8?B?MEE1cTFuL3BuSkpUc0kwdVlwRm5WdG5OamZ6QTl0bVhTQTVpVXgrZFBGSkl0?=
 =?utf-8?B?Ui92RTVIRWhpN04xK08vcExuTTY2UTl0ZU15OGRHVlRwVkR4OFpISkZJdHhk?=
 =?utf-8?B?SVdQL09DSjNZOXpXa3Vqekovb0ZaaHVXZ0RDV1JrdWVzTi91RExVTUlCMlRM?=
 =?utf-8?B?NnYxYmdDRitZTjBZenVNOGRZS2FHR2VEVlIyZ2w4emNFQjBNOW1Uak1NUkR3?=
 =?utf-8?B?Y2tleG9BbysyK0tpd1U5STk4b3dmNjFVNE9JVThPcmNaYnpnVFA5dlpGR0xt?=
 =?utf-8?Q?+vEnLb2/o/ZdCHv1rnW4Gwsvc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5a5c94-1b6e-4ac1-23a8-08dcee64bc2d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 04:32:40.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKVdAo5hTAaAb3Xmd6s6DVYjm2gIbEqHUW9MuukgzoxayjClHU4Np75PSElfBKzgDR5lXpuQaX2ogMyzWSkFzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

Hello Mario,

On 10/16/2024 8:27 PM, Mario Limonciello wrote:
> On 10/16/2024 09:46, Dhananjay Ugwekar wrote:
>> According to the AMD architectural programmer's manual volume 2 [1], in
>> section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
>> as "Reports the most energy efficient performance level (in terms of
>> performance per watt). Above this threshold, lower performance levels
>> generally result in increased energy efficiency. Reducing performance
>> below this threshold does not result in total energy savings for a given
>> computation, although it reduces instantaneous power consumption". So
>> lowest_nonlinear_perf is the most power efficient performance level, and
>> going below that would lead to a worse performance/watt.
>>
>> Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
>> lowest_freq) allows the CPU to idle at a higher frequency which leads
>> to more time being spent in a deeper idle state (as trivial idle tasks
>> are completed sooner). This has shown a power benefit in some systems,
>> in other systems, power consumption has increased but so has the
>> throughput/watt.
>>
>> Modify the initial policy_data->min passed by cpufreq core to
>> lowest_nonlinear_freq, in the ->verify() callback. Also set the
>> qos_request cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0),
>> so that it also gets overridden by the check in verify function.
>>
>> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index fa16d72d6058..117ad5988e8e 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -529,8 +529,20 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>     static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>   {
>> +    struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
>> +    struct amd_cpudata *cpudata = policy->driver_data;
> 
> This /could/ be a NULL pointer de-reference.  It should have been initialized after the "if (!policy)" check.
> 
> It's a one line change though to initialize at the right place so I'll do some testing on the series though with that manually fixed up and if there are no other problems I'll take it.

Thanks for catching it!, last minute changes led to this oversight. As we 
discussed will put out a v3 with this fixed and a comment to explain the rationale.

Thanks,
Dhananjay

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> +
>> +    if (!policy)
>> +        return -EINVAL;
>> +
>> +    if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE)
>> +        policy_data->min = cpudata->lowest_nonlinear_freq;
>> +
>>       cpufreq_verify_within_cpu_limits(policy_data);
>>       pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
>> +
>> +    cpufreq_cpu_put(policy);
>> +
>>       return 0;
>>   }
>>   @@ -996,7 +1008,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>           policy->fast_switch_possible = true;
>>         ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>> -                   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
>> +                   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>>       if (ret < 0) {
>>           dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
>>           goto free_cpudata1;
> 

