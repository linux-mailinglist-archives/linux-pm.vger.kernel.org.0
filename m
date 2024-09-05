Return-Path: <linux-pm+bounces-13735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8896E4B2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 23:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F1D1F2372D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9901A7275;
	Thu,  5 Sep 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WsvKZLnt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC6165F0E;
	Thu,  5 Sep 2024 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570873; cv=fail; b=Hi6TKERZTsQkeWrVBwFWjEBpYQAaZe83w1j0HK3i788U6QwDp72HmZVlgEyOerQUO5bNkDE1MHwFjLMK+4Vn5gjlY2wDcSqaEtEaVxcRMNTAcxiMJWc/7+D+q3OAXNdLuJZE5MrhTd+FvdwV408bySqgm8u4RzW82TCqcJwdDns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570873; c=relaxed/simple;
	bh=TpVYGzflAHQttFJr+5LHrx58iMYRTtFkzVuycCpZ/BY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOktws3PKdKO1iWxp5DdvRrGoUZmoTef9z7Ed++CSTeamNx++mu3veDbPccqYMOzSrZr1zFPb556saku5H4Ig7W80r7IEOAilwg/gJVK8JOXKw24GjvImurLSXEaYdOS2ntNNspETj6Stz4NKr29zWgZI468L+kdIRaWbPlw7uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WsvKZLnt; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTlO69fbXJZg6OZZi7bMIY/3er8W40EDMPm+FQCYv8IkdPj15xwMD6Omsv/qMBcO+vyS9oSkp80tF/MpOZJ/vRekqvArZSvUDAwcMrjeHT+2Mb8tINHrd8uHAwpwAR3Y7S4cd3Ba45InJNk8YsKxm2AEEe8GQC7y7Z06g87xxiHYXmxsIOzy0aDZ3tGVAsbTBG/9ltoeaG0rXcd0T0eopIrHWxiUsbLKysoSXN/W7cWcKH45qPtnfgIDVQRSpP1KIila2x4HdOVi1HRjJNselmQWl8SlIjTiTwizB5tpLIxDDiO5LLcAgNdx/SKfp4dmP8tWUrU7UIVZ1tLlheZOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez1ZU456IITWhUKH+MSTFDh1+Qn0sPmfcHg7ORsYlIs=;
 b=Zkq6/DYL0jsD3fT798pJsZqHPJBv6YyYq6jXzFMPdwIGnZ2tPVrCT0XszLdHV+NgvL7Tkiq4yJs72IEUZejErDudX5OjWG7YbrwURW2d0P3XpjfknmcT1anEfTm8gx3Fq3s47ecMTLSjqEyadjt/hdGowgcRzjRhu3C6tSwCgMwzbimyBZf3SI+OfUsg7t1cP61vS+wbPqkX2gF424RDE3SRPCmFcycoAXWGEhQ2c4VThtJDmXPcIopQk0W+AUV42oG0EfGXu36JBEpYi/tDdLmGrtcMOYr8cIZ2Eq2stPm8P3xGZpDoqxkUnUjkLhZKX4ifN1yw/0xiDeQa7nBmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez1ZU456IITWhUKH+MSTFDh1+Qn0sPmfcHg7ORsYlIs=;
 b=WsvKZLnt51Kzlva+oQS0m1CaKyOWQq9M7HF49Y1UxHXmE5f7NVJvl3bbskf8Tzur80oLZWDMjCKTCAa0EEPHSC+dvxipUxMbzsaadHvRiB6iKAyNxgmNB+yY6TlNAVDMU0BPv5deQiGqwEVSu5t5j6jG+RZWygbKrnS+Y1Fx1Sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 21:14:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 21:14:29 +0000
Message-ID: <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>
Date: Thu, 5 Sep 2024 16:14:26 -0500
User-Agent: Mozilla Thunderbird
Subject: linux-6.6.y regression on amd-pstate
To: "Jones, Morgan" <Morgan.Jones@viasat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
 <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:805:f2::46) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e340b05-95c9-41c8-94a8-08dccdefbab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWlRMlc3bXp1L0dXZFo5NTNmSUFCOUhXMEpFREEzZUpIeTZuZFFBY0hxVDdi?=
 =?utf-8?B?TE1XZk9EWUpCSXZWU0g3Tkd2dXdzaWdZSXgrRU55clN2dmFIVVZBdytJV3Nv?=
 =?utf-8?B?bnBBSlZrc2VHT2JMbnFCTVFscmxlbjBJMGJ1WmRQcWEyOVc4anlsaUhHOUha?=
 =?utf-8?B?dHlCdlM2RUk1Y2pIemZ1QkRiamRIVS9yUEpTVmcydlhTdjlQYmFCejF2WVRQ?=
 =?utf-8?B?d0J3OHRNaHV2a3M3NDQrT2tFNWY5TWR1bVVvYTBrVGxFK1B5VEYxOHZRMVlt?=
 =?utf-8?B?WkJQRlB2TlNvNS9nRlJzTTkybDdNQ05aZFl4STNHdWJIeXVGQnRRZGJEZlhz?=
 =?utf-8?B?cTczb0JhVVlKb1dnc1BUVjFXOFRCOHJONE1VSTRvaUIzRFRDRzBOTGliMXFs?=
 =?utf-8?B?OUJpSDBCL3E2TEdKYjd1VGlTZW9mS1FlbU1kUmJMNGhhRHFmbExyQk1pd0J1?=
 =?utf-8?B?NXpUenRhZm9vWVdkTldPVHdDK3hSRmRQSkZWb204ZnVONWZoTEtIYnBqWW5G?=
 =?utf-8?B?T2RSNFVVNFpsZFpldzNnd1FRM2p5YkZ2TmVIV3NuRHMwaVlNWGt3d2kyRktH?=
 =?utf-8?B?RFBiNmMzWkZ4aDFXUlIzYXVYblV3RUlpRG5LbW5ocW1oY2xrL09YY1NOWjd2?=
 =?utf-8?B?ZmZDaHRoOEpFZTRMdVNiKzdvUlpxakFFc082cXdlcHRNK0RSbU1XdTJDM29L?=
 =?utf-8?B?bEUvTGZqSWVUMGZ6MjFsbmF4ZE9LUXVXOE5LMTY0UEpaMHdPaFhGU1VCNThv?=
 =?utf-8?B?Q1dYMGZDdE1JSXpiaFVVeDNrbVNHYnZYYUdpb1BtaWRUWGIyaEgwU2NVSHcw?=
 =?utf-8?B?NkoxTzZIN0pJSGhKUU8xdUxRdlAzNFhpdmNVVlNENWRMQm8rUVBuTENuMnJn?=
 =?utf-8?B?VjV5c0cxK3JPQmVpam9aZVdMVGJnR1FrNXBNRk1rYlZRVFBUOWdJVlRsSkkv?=
 =?utf-8?B?cjRvTU1GNmRKZ0h4L21BZHBGRU1kOXZTYmlKRmdqdjBDa2QwRWxHV256RmYz?=
 =?utf-8?B?Y0xvdFBlTGlrREhQUmNyQzdLeUQ2N283bG41d2RhSm9HcFJqTERHMGkvUVh6?=
 =?utf-8?B?RFZoUmJWZmRGNm12OGZDMkdkYzhVMkgwZndkR3NMZ29LNW84OFlJR09acEY5?=
 =?utf-8?B?aVcyUmIyYnlyUU5oRWZNa1RoV1RmUTdKWW82RkUxRFVOYm9LUHByYUJFdzZS?=
 =?utf-8?B?bGZ4cW9obU1RVnhrY0VWUjIrSUFJSStGckdrNzRjbnZEemZiVlhzRlZrcWtO?=
 =?utf-8?B?V1d3bVNsTUtqSmF1cU4yaDhvd1FuMzRSSHZNRXZJb3VodEh4UGpMajg4aHdT?=
 =?utf-8?B?TmZMQllYR3BRUFdYR2N5bHFZOFVaU0NaMDZYblR6dW9IOEllQWQybHAxRlBw?=
 =?utf-8?B?SDlmNnBhS1BBdGFIVmdrWG11cTFmbU5qeDhZaFpXOU4wN3R4Uld4ZzZEMGQ1?=
 =?utf-8?B?SDFoQnBFejljaGRmNzVCMmJTTjV2emZJWUtLWjFidTBVZmZYOVBHcjdmWml3?=
 =?utf-8?B?M2tLN3lvY09PaUlmVDV2eW9TQW92RkpBb0l6ZC9TdFdjbjlBYWdJNWw3R0F5?=
 =?utf-8?B?UTFaYUhpSi9TS0dUZ2xCUStsVXZjcndUbHlPaC9VVnRJeHFJajB6TS8zaHRr?=
 =?utf-8?B?TFdWRy9HK0NDcFo3Ynl4QVBnVE1UQ0dmRkVjQUhleVNzNjNvQUk5N0o0VGp1?=
 =?utf-8?B?SmN3MmMrS21kT3Z0VXNNUlpxdVVqV3hjOWNpUTV4RzhWVzdmNS9neEthRzJZ?=
 =?utf-8?Q?LmMGcuhMCl6jawbgxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0R0TmhMc1hKZUx3UXMyZnRhbWFWb1pjcE9aNHUvWktBY0h0V05RRDNVUzNi?=
 =?utf-8?B?QXJNRnN3Q2J6WncrSnpVMkdsZjVjVFhHbnpPYkZDZVp4aFdqYlNUSVVQU3Vp?=
 =?utf-8?B?aDRKbEtNWXg5U3lER21VZzNDSm5UM0dRMFRHQlZNM1liM0JOVVUwZk9aNXRM?=
 =?utf-8?B?d3FGblFKeUx3YnoxcjdwYW91SjlickxhampjY3U3SmZPcG5kc0t3ZndLNzRL?=
 =?utf-8?B?UUJLTHFPdlEvbUxVQit6dHhaZmRmRW1DVWxFK2ZxNkFtS0NLeGxCQXRLS0VY?=
 =?utf-8?B?UEd0TlB6VUpGSm9aWTE5alNqMDZFbGtXMkhYTVB1cGdIYnA0VU5kQlJUclNq?=
 =?utf-8?B?WGlFYUtGYk96YmZzMnNyMjh5dWYyYzBNenFkN1ZmZHFJZ0RYNThQb2xibXN0?=
 =?utf-8?B?Q1VITjZyaWtGd1JXeUpQWVBYK0R3eWdKVXFUZk9BV01SQjJtN2J3WklwL1oz?=
 =?utf-8?B?QmdkbXRDcHcxNjRhcUVDOGVXK1BwdS9ydFJOR0FWend3eE1Da3B5SXNncDhm?=
 =?utf-8?B?VXJobDRyTWdGU3FGc1YvM0dpaXV1TCtMMDdldk9WM2RMOVYrcDJhTlVPUWly?=
 =?utf-8?B?aXFXOTJ1OStkbmpUa25SdjY1dVdWQWtrSG5zSk1ETHEzVE9TcUpUNUUwY25P?=
 =?utf-8?B?aEpxeGVTY252N3dzWnFITGNmQjR2bmdnYmg1UE5mcVVCMzZObTdIM0RqajRZ?=
 =?utf-8?B?Tzk2TVJxZm9oZ1YxbFpDU0ZlZTlXTitIMUFZQ3BsdFNmS05FbnZ5RDFSclJI?=
 =?utf-8?B?SkQwdE5nb0NLS0Q0Q2ZlWng3RHNNOVpHeXFCaWxZcW1DYWMvTVFjaC9rY3E3?=
 =?utf-8?B?aml1K0ZGSEVkbXdhblQ3Mld5M3ljbzlFN0xvaVRjTXpzb3pEV2JncHA2ZmZB?=
 =?utf-8?B?ZDgwN2dEME5EU0h6Q0FmZVR6Syt4ZldpbkhlMnNnYlhjTHpvSC9uc3orcnlH?=
 =?utf-8?B?V1Zlc0FRWGVGY2dKZG5pNTh6emVFcDFYVnc1QldEUGJQd2kwQnFIcW1kZnJV?=
 =?utf-8?B?NCtHNVBKZHQ3c2JDZklOWGRwS1lOdStSQmtYWE5ya0x1S0U3TEV5YjR0Zmor?=
 =?utf-8?B?d3hzRmhUMndPQUF6cis3UmJ3Z0ZPS2dndjgrOHhqL3JMYjJXZFZjVFhRZXNn?=
 =?utf-8?B?QS90c0JxSnZPYVJVditEUDJ0M2hod2JKZzZmTmlyOWVHRFk2eW5aUlE3ZkdK?=
 =?utf-8?B?Q1NhWldTWEl5L2x0UDVLZUNnK1FBSzlzQWtMeVJYdGRnd3M4K1p0cjFQcVps?=
 =?utf-8?B?ek94Rm9jeHhra1NMOWlxRUE2bGlQOGxmdCttL21VcWpHYkVVZ1pBb0tBQUUx?=
 =?utf-8?B?UFRCL3dxRnNRTmNwbUJud0d3dTRLaHcrOTlRUnNGemJ0WkhaeitYdFpEbGkw?=
 =?utf-8?B?WlByOTdkT2N0UTY3L1dZdWJpWXJiQkVuc0oxWFREL2lBNWNhWHJ2WCs4L2ZE?=
 =?utf-8?B?M1FGbzFXVmEwdk9id1l6Q0djalpXbjBhMkg1WVUvTitDZ3NNTEZUanlZcVMz?=
 =?utf-8?B?TTNzWWNVYVV5dGxTV3BGSExIYmMxR1pQL3ZWTC9tLy92T0oxRG9ubWhyM21y?=
 =?utf-8?B?aVM3Y2R6cCsySm1JVWdPV2JURnhKelo4Q3B1emxQTzY2UEJEbEl0YU5GT0VI?=
 =?utf-8?B?RTJKcWs5TjkwdzNRUHk0bk9pM3IvNDd0M2wreFR3L0hHY3hNclE1TUhxbm1H?=
 =?utf-8?B?NllML01RYWprOWhPT3M0R0IveGZ1Wmh2MkRhVFpWVHBwSVpFMERlcXNscG5K?=
 =?utf-8?B?M0VDVCtLdi9BRitkdXhwWUtkTjFwZEplS2RqYW94RFhIaUVDSmI0Vlczbi9n?=
 =?utf-8?B?OHVDQm91Q3Jremlzdzh4UmJjWUZId2VKcGxhak9OUU9YWnFRSnptYkRCa3BH?=
 =?utf-8?B?NjNtLy9BS01TenNsZGJPN3JQQjFjVDFYTHZiMjZrS3FyQUxiaDR4NEF2UUIr?=
 =?utf-8?B?OSt5VFp5ME5aR3l6REJ0SzkrVUNiSjlEcG9pWnVxeVRyU1pvcWR5Q2tqeVV1?=
 =?utf-8?B?bFhKaGdtakMwb0E2WUgrRkZrZ3drVDBqeTdaS3BDMkcvdEE4VlhPMyswTVFl?=
 =?utf-8?B?YWY5dU5Ua1FpNTUwaHhLMTF2SUhnN21ZdVViMzZGYXdyN1lJeWk2NldHZVl3?=
 =?utf-8?Q?DCN3WR1eSWidlEtU8rNmxiXJe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e340b05-95c9-41c8-94a8-08dccdefbab0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 21:14:29.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXEiaisDxeE0yr5OhLWRDABS8xmLtedsBw6PXvT8kk2WU7UW6Pn/41EV4VhuzwUmsla9kJvQxsIfqX8mOw9wCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

+ stable
+ regressions
New subject

Great news.

Greg, Sasha,

Can you please pull in these 3 commits specifically to 6.6.y to fix a 
regression that was reported by Morgan in 6.6.y:

commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest 
performance value")
commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate preferred 
core support")
commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest frequency 
issue which limits performance")

Further details are below.

Thanks!

On 9/5/2024 16:09, Jones, Morgan wrote:
> Mario,
> 
> Confirmed. Thank you for the help! Slightly different refs on my end:
> 
> Remotes:
> 
> next    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (fetch)
> next    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (push)
> origin  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (fetch)
> origin  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (push)
> superm1 https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/ (fetch)
> superm1 https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/ (push)
> torvalds        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
> torvalds        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)
> 
> Patches:
> 
> git format-patch 12753d71e8c5^..12753d71e8c5
> git format-patch f3a052391822b772b4e27f2594526cf1eb103cab^..f3a052391822b772b4e27f2594526cf1eb103cab
> git format-patch bf202e654bfa57fb8cf9d93d4c6855890b70b9c4^..bf202e654bfa57fb8cf9d93d4c6855890b70b9c4
> 
> Results:
> 
> Linux redact 6.6.48 #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1 00:00:00 UTC 1980 x86_64 GNU/Linux
> 
> analyzing CPU 56:
>    driver: amd-pstate-epp
>    CPUs which run at the same hardware frequency: 56
>    CPUs which need to have their frequency coordinated by software: 56
>    maximum transition latency:  Cannot determine or is not supported.
>    hardware limits: 400 MHz - 3.35 GHz
>    available cpufreq governors: performance powersave
>    current policy: frequency should be within 400 MHz and 3.35 GHz.
>                    The governor "performance" may decide which speed to use
>                    within this range.
>    current CPU frequency: Unable to call hardware
>    current CPU frequency: 2.09 GHz (asserted by call to kernel)
>    boost state support:
>      Supported: yes
>      Active: yes
>      AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.35 GHz.
>      AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>      AMD PSTATE Lowest Non-linear Performance: 115. Lowest Non-linear Frequency: 1.51 GHz.
>      AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
> 
> And our builds are back to being fast with `amd_pstate=active amd_prefcore=enable amd_pstate.shared_mem=1`.
> 
> Morgan
> 
> -----Original Message-----
> From: Mario Limonciello <mario.limonciello@amd.com>
> Sent: Thursday, September 5, 2024 8:12 AM
> To: Jones, Morgan <Morgan.Jones@viasat.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David Arcari <darcari@redhat.com>; Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com; skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
> Subject: Re: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
> 
> Hi Morgan,
> 
> Please apply these 3 commits:
> 
> commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest performance value") commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support") commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest frequency issue which limits performance")
> 
> The first two should help your system, the third will prevent introducing a regression on a different one.
> 
> Assuming that works we should ask @stable to pull all 3 in to fix this regression.
> 
> Thanks,
> 
> On 9/4/2024 08:57, Mario Limonciello wrote:
>> Morgan,
>>
>> I was referring specfiically to the version that landed in Linus' tree:
>> https://urldefense.us/v3/__https://git.kernel.org/torvalds/c/8164f7433
>> 264__;!!C5Asm8uRnZQmlRln!aIZEDEbIUKD7OrxN0b0KjoqKYDL2yMkwk4EK7x_oSnyHQ
>> 6MEq7yt6JHjd0TD9DgEYEWDcF58OKL8c7G11bT3dSqL8eM$
>>
>> But yeah it's effectively the same thing.  In any case, it's not the
>> solution.
>>
>> We had some internal discussion and suspect this is due to missing
>> prefcore patches in 6.6 as that feature landed in 6.9.  We'll try to
>> reproduce this on a Rome system and come back with our findings and
>> suggestions what to do.
>>
>> Thanks,
>>
> 


