Return-Path: <linux-pm+bounces-23213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCFAA4A95E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91213189B988
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F51C3BF1;
	Sat,  1 Mar 2025 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hyLyQ0VK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB31C3306;
	Sat,  1 Mar 2025 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812602; cv=fail; b=Gb4yIsH7v5IPWnfoGATjT8WyDvYL1ItWXm5M6HF/MbuuoNnaKUNN4elKVpzoGdGmeMCi7wCzsqTPgCNjJDUpzHw2DVAwQN8ukOG7E7XBNrhZzKd8FSwm/VAU2y8oOUgiaFiSahJGL74Q+uCHtpG0uKljGVRo/Cnz0m0hI1Etc7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812602; c=relaxed/simple;
	bh=wEaPJm3OUziq3yK5muzwWQZ3p9Z/J/3nhlsneqsvOVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toikR5LwCO6VGsXFqCava0nJfO0Wux/N+opaf2tdQaiTQPjw5p4zKvbQb3OfQafOFJxvf50zTmR5O3VhfHjF/+uzygTsgv7o2xTMzV+MydvSzgARSEsljltzwnNuLkOuPoSsaO+OGPS8mx1ZiUEri98cDZbgjwq3HXa14JAmjnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hyLyQ0VK; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEei+Lskc3LlDU8odI7krMU7Dd09H1COZQkvcb9maXOC/ujQ5ckPVrMDxzdZ4u7VIq5cix3YSXm8k+W8CNSLQeibe2Kqa/nyEYidJWPJ6XhU2jK8OpX58q3g9s6mG9XiWVVAgU+uUyLOxb0+nlHdMl+e9LiwT1Vu3JtjP1yIPobtre8VES9p8ZQ7ovNZGw+B0MbAD/ZFiL2S7wtgSQ2tI0uDO+X2oHKXP0GqzeNhGcQB34q7/Apzn4AtrywcIC96QveootmWREHL5XalOuQyU3Xgvqe/8QALIq/HJKoKTGCiGJZ2tyeVpFBNb7DiU8qAhdgu6MMvPeNxbTOptxspLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybx1wxdjG2oelSKO5Rnka7+5SwRuRhbxXOp7pMvtri4=;
 b=g89oEgClQzjL1K6D0F4ZMoe92quc4VnSnXYlhmxmvYECuWTu7KmMUwJYFmmkZ1LitIaklsxnIYKEwsMmyJGgl6xEq9AJMaqDBHiEe49uLwU0ofphtp4U5r0zYxBMivyZ6iwdJ9GBI6BlS3dX04V7jyss1f3rRKHjwBkORrpCzjpSn4AnuwSgfBHWa5gn52humUAspgOaxZXT2Lj/tYmG7tciuFyZKwe/O3BELpkgWaJGh7iwf30HpOh9ZAFEKONPo14Dcd67j+7lcYI6qv6cSQ1pLiB5HKg062w6waL0adlyuiT1a2EeJ98MOQLyPMn0XD5AcWYO9vFdKRKuwwekQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybx1wxdjG2oelSKO5Rnka7+5SwRuRhbxXOp7pMvtri4=;
 b=hyLyQ0VKmBcn6SUPCUZBHsispXuyhPk9ZHqSJhXEnCGVMw0AzfqeXf91vhjCn7IXeAkGhwSrqCFa1LyA7ZmFbBRCRDumWxqNKgebh3C6R/InV4Y4lH62aHLJr5iw0fz/P7XmqCA5G9Sv0SJuKiWQXrS/xBnMjouPtbjm3HDn+qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 07:03:19 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8489.025; Sat, 1 Mar 2025
 07:03:18 +0000
Message-ID: <451e4beb-4485-4405-9c69-741a44c9d13c@amd.com>
Date: Sat, 1 Mar 2025 12:33:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/19] cpufreq/amd-pstate: Rework CPPC enabling
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250226074934.1667721-1-superm1@kernel.org>
 <20250226074934.1667721-18-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250226074934.1667721-18-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::18) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cdaf37-84d9-4953-b485-08dd588f2554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGQvRTJZNkdmQXNiRUhGQjA5TEIxODlXbjJ4algxRG1iVGpNTVE4YXVCUFNN?=
 =?utf-8?B?M0VCbS9OT3RwL3ovZDJ2N0cxU2hFM3hWRGZiQTVMRU9xYVpSN0NYTnVNQkE2?=
 =?utf-8?B?ME5hQ1gvczZHQnhWOWJ1Ym4wSHRxTHlUM3RSMnZPaTI3ZS9tN1FGSkNjU3RR?=
 =?utf-8?B?OWtZZGFnMDQzZC8rNHoyTDJaR2JBLzRuT3plYmJSZG9BUEpRT2pqUVp1SkVT?=
 =?utf-8?B?azlOaGpVajUzWHJKSnQ2YlNZR25rMGtwQlNDbHVyUEM0d2NyOE4za2Y2TUZP?=
 =?utf-8?B?bkpGYnBVRDlWbi9rdFo5Tm5LanB2U2lDMVBkR3dVbXVwNWgwdUticm5SNkhw?=
 =?utf-8?B?d3VWd2R5SlA2dnY3aDlTTUFrd2FPWGlPYzRPRkhsRTBTRm0vWmlYc1JPVGlr?=
 =?utf-8?B?bmpIaGdJa3NhbzZjRFA0YjVOTm1mTmNsVzVSaXZ0Q0JIUGJKQXkwaUtlTndD?=
 =?utf-8?B?b3I3QmlmVUxmaGd5dC9nQXA2MTNVbWRoeUlqc1NRTTk4NlRFL0RhS2pndWFD?=
 =?utf-8?B?d2ZTS09hdEFSUVNQbGp6ZVg2L0lUdWNZK2NSQ0xYTk1rM09mYjBYRE9hNVVa?=
 =?utf-8?B?VDRxQ0MvSVh4emtBcmFBSmd5YTRZSno1a1dJYlB3QUJFOGE2bnVwbzVGUldP?=
 =?utf-8?B?emNyN0pPc2M5eUQ0ZVFCeEQvNjc0OVd1MmZ0T0pLUTRDeGpiZEhGcjFoVkl0?=
 =?utf-8?B?ZXgxQlZ4Y3pOeXovbTg4R0hGdW1QYWZSSS9WTTBDQVprSjhqcmoxOFNweGFJ?=
 =?utf-8?B?aDA3Um9jSmJOUElINzZIVllUSms3bS9TeGFMU2NCbEZqRm9DY1dkd0tUSXJa?=
 =?utf-8?B?NkVnYS9pYkFENnAvR1N1elpqZm1lQTd6a1dXL25YNDJPbEFrL2NQT0pBZ0VR?=
 =?utf-8?B?ay9Eb2Q0Y0ovUDlCaEF6K2VzUjRTMzB1cTFqYmIrYkt2UmV0emJXeVdMcnVl?=
 =?utf-8?B?SS9BOEJMQzk0czJQRmZqWFpoVU90RlBhQ0w3UzBTbUpqY3JkZnhKMEdpcWVk?=
 =?utf-8?B?Umh2b0wxV2d0UDlxMW1MQ0crdHl2VjA3bEFNZzh2dGhRaTczVlZ4UDZHSDVj?=
 =?utf-8?B?R0NsNE4zNGQzQVFGZU02MG5INktReEo5SHRlbTErYldzdVZHdXI2WDVJYVVD?=
 =?utf-8?B?dzE0TWY5cmdLSXlXNGpZN3dTVVA1aHpnZjFZZER2bzY5RE9NVlJuMCtUcjV5?=
 =?utf-8?B?VzZ4cU00Wm5sK1l6L1BPeWE3YXNYQjQ2MTY0MVE5ZHhYTEJrbXBDRWh5UnRa?=
 =?utf-8?B?V0gxTmUwMXpWOXc3OFVBVGcwNEZFZm9XOXQ1SDV6YnFIVmJqUjkrKy9GMkk5?=
 =?utf-8?B?QkVRKzRzUDlhRDg2R1l3dGRGSmgwZ3gxNjlaekhkbVdQYWRESnYxSkRoOUQ1?=
 =?utf-8?B?Tm5oK3crcU4vYVJCT2gxeFMrVGwwZXZKc3JWd1g4ZU9yLzdQQm42Wlo5b0pj?=
 =?utf-8?B?anRvdHNOaXdTdUEvcnZrWTRaZ1VPa2FsWXBNR05oQUZmQU55VGxIR0lTM1Rx?=
 =?utf-8?B?eklRK1RTTlFocUZoVWVOMy9BTFVVakc5blFRMnpnb0loN0RNTzA3bkpVQjVY?=
 =?utf-8?B?cG53NFpaWHFsZmZVeThIaFlNWlZReTV4bUlFNnRQRHAzWUxPVHZzK0JHejNV?=
 =?utf-8?B?NUZGbkZXVzlUUmI5SjNPOVBSeFg2cWRNV05ReWVTNjUrN1FzM1NCcW1pRFJ6?=
 =?utf-8?B?VjVGakFXUEdlN2lURGZhcnI5ZVRnRDhvWjMwZ3pKQjU4TTZPdlIwcVc2eXNn?=
 =?utf-8?B?TnQ5dXZJSjZka1RwQUxRWEgvSUVUOERreU1pQjdhNUdqYzJsanE4a0RMZVNo?=
 =?utf-8?B?NGpyYlZkVEVqcTc4dEtLMGNwdndtaVMwZkJKRzJucGFaRFc0UkQ0Vm9qV3k2?=
 =?utf-8?Q?U09gumFbREVvP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG10aC9JQ2RzMGtHV2Q3OERvMCtZMEhpcjZ3Mk9kclZIczl6eFRLSmNvUEVG?=
 =?utf-8?B?S3lrZlRwSk9qaDFMbHdidStwTjQveU5VVjRxVE81UWVLejJBOWxpcldHMXR3?=
 =?utf-8?B?U3VTODY2V0xjSzFZZFlrQ0o1Y1VCL2tFU3ErOHVwWVdmSlZ5RUQ1UGxnZ0Y5?=
 =?utf-8?B?SjRrMEZaMUNxK2pGUC9lbHZEeG02YnNGdkxkVXFjR0hyL0VwdXdqZGNrdnFO?=
 =?utf-8?B?OTBuMWRLeHhMd1BTTHBqeGMvNG9nYldaRXd2SjRQN1lTQ2VkK3lmRDE2eG1F?=
 =?utf-8?B?OGhZeXY0R0lSdDVLK2VjUlpEUDFlU3Q1MGMrUlJqZ0FITmhLSUJkUU5Ydm1j?=
 =?utf-8?B?MHVrVDVERGxURUpaUkdaRkJiTlR4eHIvR21FUVpJaVMvbXl1eEZlUElyVUY2?=
 =?utf-8?B?Tnk2VkxVaTFXQ1dvNlNUd2hRdTIxcDl5M0I2aEVBZk5uMFk4bThOYW8vUXkr?=
 =?utf-8?B?endTd1pHdCtnbzN2bzdEdDNGS2FtanZGcktzZ1J1RUhmNkl3aXVCSHd1Z1Vl?=
 =?utf-8?B?em1vMnpjM01jaEgvTk9sUDRpd25QMFVjc2l0dkNIbll5dnRZczg4TU1pa2l6?=
 =?utf-8?B?OStrUEpaMG5TNjFlZlFlTDdlWm1aRjBZbnZyc01hZVU2RklJd3B1bUVhN0xI?=
 =?utf-8?B?TjRmWDAxYVZteklvSGFLZWpvM0JQeERnKyttSDFCeTMyR05KanFvb09xRSsw?=
 =?utf-8?B?SGhuZUdZU1lCSTNhL0pJSWpnU0xPaDNBUjluM2pOUm1TakRzaWE1dkxPNjhN?=
 =?utf-8?B?RVdoUTJUc09nZHN5dFRzOGg0N3NoSklkMW9KbmFPRnlVSGJHc2ZNcVd4NU9N?=
 =?utf-8?B?clk1YmtmZHByQjF6bzUvNk8wcUE5N2tmN2RGTmMvcXFwMENJSERSK0V2cTA2?=
 =?utf-8?B?QytNVVdjTll4aTFmK3A4KytpaTdRSlpBVitEUlNSRDhBeDhHK3NFY0RvaEwy?=
 =?utf-8?B?RkVWRC83VTJ6QnNtdko5a3JqUFVYNWV1QTgvcy9KQXlSQWU2emRJeHdZLzk2?=
 =?utf-8?B?a3BIQWV3R3B2S05SR3RsajVmaXZmMmdlYW5kMlJBTWNwQy9GNTJPY01GaVlt?=
 =?utf-8?B?N0R2dEx2RGNldEluUzRMa2JRd1JEaXlnVVBheEcybjVqK2RkTzRNY1gwYXNY?=
 =?utf-8?B?OFNGaTJZQW5xYTRkNHJUaHdRckFOdzVxUDVSNXF6SFFHcnZyVW44Y2hKSkxL?=
 =?utf-8?B?Y2VzZ3VEeEVvTVRKNU1zTUJFTXE5YTJZUWlNaUdqVjFZV1B1UDhDWm80YjlM?=
 =?utf-8?B?RGM0YkVkWGI3dXNKUzF2cmt0ZnF3dDJpN0lJeTI2UDB4bzBFSjg1RTlsUzBk?=
 =?utf-8?B?bGFJNnhCL3JxUlVXRmdycis5bHYwaC8zQ1hCbjlUU3RSMUlUV0F0OHMwQTZu?=
 =?utf-8?B?bXlXcXhKK1k1dEo3d3lCa3d4VVdNc2t4dXNZUDdWR3VYRjFncEVWWVBGM2ow?=
 =?utf-8?B?ZkZQb29Eb3pkODNzbkNSN0NnakNIUGRuV1MyemdrekxUZHhjVExwU0FLcDNJ?=
 =?utf-8?B?NTFQYTErN1FHdkVweW5qcnlka0xpaFR5Sk9WZDBzaVhCK2txZWJlNUdzRzFn?=
 =?utf-8?B?RDBEVGFNUzc2R09OZFBUNkkxSVJEU3pPcW1NV2xlMmxCZlIyZjFlYzEwWGJa?=
 =?utf-8?B?UnJNRjJIeVhVeU1WUTNabkI3dWw1RTFpd0NsMUVLb0VZUWsyNlpoeXZIVVFP?=
 =?utf-8?B?UWJ3ZmxpRTRSNmswZkxhS3c0ODlFV1lKdlNFbnEyV3haazRFZnQzei9NaWVy?=
 =?utf-8?B?Z3lFYnRqMkMxOXI1ZzdQcEJ3TjVwcnNKSktZNXJPZldySkNGbE9LNEsySHBE?=
 =?utf-8?B?ZEhJazZ3aVVLelVIT1hwbWZSMlBNbDd1MWw1b2ZxSkZ4Y3lBYzY3VU5MV2dY?=
 =?utf-8?B?R0FrRkEwQnk1UXJBWHNxVGdyUmdGd3hkb0RnUUZaQVZoc0xMSlFCM3I2SVg5?=
 =?utf-8?B?V2luOGJobjdYbi9UZ1MyL1FudWFGSUx2d3pVMm43SmJieURtYjhZZTZ1cWs2?=
 =?utf-8?B?Ni9ZTWZnQzdOek9rdHpydnBoVjE5WGtXOXI2cmdUR2lEeDlsTDRNWmdsL3Bh?=
 =?utf-8?B?RkJEL2JJdHdWQUQ3MXl6YUN5WE9OY2JxQWZzUHpITHNXUTYrNHExTVlxT0hL?=
 =?utf-8?Q?ssEyZS855BhATReItfstq19c7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cdaf37-84d9-4953-b485-08dd588f2554
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 07:03:18.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LusJmALnqM849V0U5ke+/nGHFCWmRrbclx4DPn24Er5y7+SN2gJkDYZHl0xf+pen4qnWTTteWSuPDB4KrWxs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474

On 2/26/2025 1:19 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The CPPC enable register is configured as "write once".  That is
> any future writes don't actually do anything.
> 
> Because of this, all the cleanup paths that currently exist for
> CPPC disable are non-effective.
> 
> Rework CPPC enable to only enable after all the CAP registers have
> been read to avoid enabling CPPC on CPUs with invalid _CPC or
> unpopulated MSRs.
> 
> As the register is write once, remove all cleanup paths as well.
> 

LGTM now,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>  * Drop unnecessary extra code in shmem_cppc_enable()
>  * Remove redundant tracing in store_energy_performance_preference()
>  * Add missing call to amd_pstate_cppc_enable() in passive case
>  * Leave cpudata->suspended alone in amd_pstate_epp_cpu_online()
>  * Drop spurious whitespace
> v4:
>  * Remove unnecessary amd_pstate_update_perf() call during online
>  * Remove unnecessary if (ret) ret.
>  * Drop amd_pstate_cpu_resume()
>  * Drop unnecessary derefs
> v3:
>  * Fixup for suspend/resume issue
> ---
>  drivers/cpufreq/amd-pstate.c | 179 +++++++----------------------------
>  1 file changed, 35 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f0d9ee62cb30d..89e6d32223c9b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -85,7 +85,6 @@ static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
> -static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
>  
> @@ -371,89 +370,21 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	return ret;
>  }
>  
> -static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
> -					    int pref_index)
> +static inline int msr_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 epp;
> -
> -	if (!pref_index)
> -		epp = cpudata->epp_default;
> -	else
> -		epp = epp_values[pref_index];
> -
> -	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> -		pr_debug("EPP cannot be set under performance policy\n");
> -		return -EBUSY;
> -	}
> -
> -	return amd_pstate_set_epp(policy, epp);
> -}
> -
> -static inline int msr_cppc_enable(bool enable)
> -{
> -	int ret, cpu;
> -	unsigned long logical_proc_id_mask = 0;
> -
> -       /*
> -        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
> -        */
> -	if (!enable)
> -		return 0;
> -
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		unsigned long logical_id = topology_logical_package_id(cpu);
> -
> -		if (test_bit(logical_id, &logical_proc_id_mask))
> -			continue;
> -
> -		set_bit(logical_id, &logical_proc_id_mask);
> -
> -		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
> -				enable);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	cppc_enabled = enable;
> -	return 0;
> +	return wrmsrl_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
>  }
>  
> -static int shmem_cppc_enable(bool enable)
> +static int shmem_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	int cpu, ret = 0;
> -	struct cppc_perf_ctrls perf_ctrls;
> -
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		ret = cppc_set_enable(cpu, enable);
> -		if (ret)
> -			return ret;
> -
> -		/* Enable autonomous mode for EPP */
> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
> -			/* Set desired perf as zero to allow EPP firmware control */
> -			perf_ctrls.desired_perf = 0;
> -			ret = cppc_set_perf(cpu, &perf_ctrls);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	cppc_enabled = enable;
> -	return ret;
> +	return cppc_set_enable(policy->cpu, 1);
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>  
> -static inline int amd_pstate_cppc_enable(bool enable)
> +static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	return static_call(amd_pstate_cppc_enable)(enable);
> +	return static_call(amd_pstate_cppc_enable)(policy);
>  }
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
> @@ -1069,6 +1000,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  							      cpudata->nominal_freq,
>  							      perf.highest_perf);
>  
> +	ret = amd_pstate_cppc_enable(policy);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
>  	/* It will be updated by governor */
> @@ -1116,28 +1051,6 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(cpudata);
>  }
>  
> -static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
> -
> -	return ret;
> -}
> -
>  /* Sysfs attributes */
>  
>  /*
> @@ -1229,8 +1142,10 @@ static ssize_t show_energy_performance_available_preferences(
>  static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
>  	ssize_t ret;
> +	u8 epp;
>  
>  	ret = sscanf(buf, "%20s", str_preference);
>  	if (ret != 1)
> @@ -1240,7 +1155,17 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = amd_pstate_set_energy_pref_index(policy, ret);
> +	if (!ret)
> +		epp = cpudata->epp_default;
> +	else
> +		epp = epp_values[ret];
> +
> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = amd_pstate_set_epp(policy, epp);
>  
>  	return ret ? ret : count;
>  }
> @@ -1273,7 +1198,6 @@ static ssize_t show_energy_performance_preference(
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> -	amd_pstate_cppc_enable(false);
>  	cppc_state = AMD_PSTATE_DISABLE;
>  	current_pstate_driver = NULL;
>  }
> @@ -1307,14 +1231,6 @@ static int amd_pstate_register_driver(int mode)
>  
>  	cppc_state = mode;
>  
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret) {
> -		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
> -		       ret);
> -		amd_pstate_driver_cleanup();
> -		return ret;
> -	}
> -
>  	/* at least one CPU supports CPB */
>  	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
>  
> @@ -1554,11 +1470,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
>  							      cpudata->nominal_freq,
>  							      perf.highest_perf);
> +	policy->driver_data = cpudata;
> +
> +	ret = amd_pstate_cppc_enable(policy);
> +	if (ret)
> +		goto free_cpudata1;
>  
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	policy->driver_data = cpudata;
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1650,31 +1570,11 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> -
> -
> -	return amd_pstate_epp_update_limit(policy);
> -}
> -
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
>  
> -	ret = amd_pstate_epp_reenable(policy);
> -	if (ret)
> -		return ret;
> -	cpudata->suspended = false;
> -
> -	return 0;
> +	return amd_pstate_cppc_enable(policy);
>  }
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> @@ -1692,11 +1592,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	/* avoid suspending when EPP is not enabled */
> -	if (cppc_state != AMD_PSTATE_ACTIVE)
> -		return 0;
>  
>  	/* invalidate to ensure it's rewritten during resume */
>  	cpudata->cppc_req_cached = 0;
> @@ -1704,11 +1599,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  
> -	/* disable CPPC in lowlevel firmware */
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to suspend, return %d\n", ret);
> -
>  	return 0;
>  }
>  
> @@ -1717,8 +1607,12 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> +		int ret;
> +
>  		/* enable amd pstate from suspend state*/
> -		amd_pstate_epp_reenable(policy);
> +		ret = amd_pstate_epp_update_limit(policy);
> +		if (ret)
> +			return ret;
>  
>  		cpudata->suspended = false;
>  	}
> @@ -1733,8 +1627,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> -	.suspend	= amd_pstate_cpu_suspend,
> -	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.update_limits	= amd_pstate_update_limits,
>  	.name		= "amd-pstate",
> @@ -1901,7 +1793,6 @@ static int __init amd_pstate_init(void)
>  
>  global_attr_free:
>  	cpufreq_unregister_driver(current_pstate_driver);
> -	amd_pstate_cppc_enable(false);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);


