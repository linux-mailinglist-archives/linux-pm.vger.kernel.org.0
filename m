Return-Path: <linux-pm+bounces-21530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A81A2C0DC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 11:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2DD7A2B90
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB91DE886;
	Fri,  7 Feb 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GqpSyl34"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E28197A76;
	Fri,  7 Feb 2025 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925068; cv=fail; b=UbwBDlP3ugIfbsXqyGjBGkaB42yfjy2Dek2d6tGjn+bQCDAHyhPI7titoCZC6sIBNMx0D3qRMQ6I3zvQElSWcnkVPPlaTg6urGACJ0DaOcGK1B9f7LjM4NGq+qp1OpdUy92yyrgPT79C3z87t/Bcg2ZSHbOfsBLjFm7rxlJkAAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925068; c=relaxed/simple;
	bh=W21MXiHckhAdQP23DSUi2hqq15iL3LDs0Av2I2ENpWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AJq5eL8NuEV4cGZcQkgD9gWtkoa0cUUCYi9ohAiFKIQ9XRYvPoU1j6zQvbh+BQgx8S8xAmZ62vb5OojPo/BpmmhYFfrNNfRERZNzdQ5Q0GX5n96f+Ibd/HjpkdOv169axVxZZphAGKGKESaXn2VtwAqJQieBRuryqYyJfFPZMls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GqpSyl34; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfzG/F+gJ2czTFMP4hLiVC8xdYYzF8LVpqK6AvBRnPqy1Zro5E2mIx56d6dykJGuRwIg1tGfP695ddAuhHAieaMZLpgmHJIRrgRWU1AOjrswUfYdKg5l1705vglaIrkVvYYT+XUN3nSwSOljk8OD4BzSQGpvUMl2aN46nU8yCotWTEU4neDITbqsk11W70sV3y+57st4Nr25oK1G8iQypX0hEv+mEs8zdspeh4973O5K7JA/6Tcu++H5SplyetajOmk3O7+Z20hoilm2RtnHOe7IFqbN6w9MA584Wrrh3s0fb8VIhpgMmghHfnx1IwU+5mCfseb+H7wicjp98ywizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FducS96BzjUdgna9aY+fLlfw4fSKsM74D/yppwyFhhk=;
 b=SxRdqQjwrVj6ONNVbNEBalqImM95iDbZ6hPxTgPn3I3NI88fnXIXfwG+XkrU8WJ95suI8ww4L9zJ3zOFAoGVgVdJxeUsTLGdGMNEQoNR5sDXIUmg4jZ9eZu5ArgDBdAzWWrwqVn/uBU+PrtLXzzE7Lf8fcBM8K7M2gfBwSM9dgcckFCmL1zAyR66QN8kiL7iklw5Tfklj71+iOLsSb1+ns/4zjV38oSixf/OGuNoicajbULffNKbWfZ+kad6vKicf03w7R9Lc4+FVqKGMdrBr8IvHGmeB++Omf2T9MhoZBmfvaG1zbqrDZQfdwalZcv+qEFfQ7WXB5GNRP86rZ6DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FducS96BzjUdgna9aY+fLlfw4fSKsM74D/yppwyFhhk=;
 b=GqpSyl34RyIc8DfRHQIP80TVIovc80+GDLcjBvo+HfnGreLqRoHc13xSS91+1n7r+rvcY3v8W8ig9i5T8HClJLnIzrCwdYDoXeg3m0Kge0jO7qU3rP/ao1broJbOL+x2Q17RvEGV3Jstnmp31lSaWXtu8mPUdDq4OgEqMoEh4Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 10:44:24 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 10:44:24 +0000
Message-ID: <2dbded5a-b353-480c-a2ea-ed246f5c0b27@amd.com>
Date: Fri, 7 Feb 2025 16:14:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] cpufreq/amd-pstate: Drop min and max cached
 frequencies
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-3-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae2bde9-1237-4688-1f43-08dd47646320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkM4QVc1eTljSGJNMVN3bDNtUXJRU09tN3Z6OGlveGQ2a1ltaWx2VUhuUTJl?=
 =?utf-8?B?ZG5ZUEt3V1JZZk1iaDNZMFltY1dKSkE0c2lHR2U1aUZMN25ZZU5BMUllZm83?=
 =?utf-8?B?RldzN3VpMkYyMnl3MDh5SGgxMkgxTktRcllSdGYwYmtza2R2VVpnZ2R4cXJs?=
 =?utf-8?B?WkNDNFJOU0tSV0x2SVV3NnNHRUxZcmlQTVExQlkrRHhuTDRsa0tWYlI1Y0Jj?=
 =?utf-8?B?YW52dnlXTlRKaUNRQjlZY3Q5MzJ0SmFBWDJsV0lRbmlIZE04QkE5N1ZSZDd4?=
 =?utf-8?B?UlMvZXE5djU2ZndvNStBZjBTOWkzRCtzTkcrL1ZMUUxBbXFITW9sOFdLQjlY?=
 =?utf-8?B?OGZHMmJpUDFLYjNGeFFHOU5kckxQZlh0Q1lTOXM3WWpwcXlXY29wL1RkbG5R?=
 =?utf-8?B?NnZZTDFJdGhNcUNrdGh2T1BTK0pkSktxQ2pSd0dzQ0xOYnRGNnowVkxjMm95?=
 =?utf-8?B?UUtwZVZuU1BtaWc2K0NvNXJJUkNQaFg5R2dsYWYreTB6aDRTYktQZEw3aC9H?=
 =?utf-8?B?M2RXUzFnRE10UjJFc3lIcElDdVhVL0hhbnBZVngyRDdKcFdTbDFheDhEbXVa?=
 =?utf-8?B?Vjhoa0lVRUlPUlg0Q2RSZ3VQRkJveUczTlpheFQzSEVpUHE4UXdzMXpoVmVE?=
 =?utf-8?B?RWw0dGlma0lVckE4KzFKWUt1enBCaHZYVHNZcng1VU0vY1dxSlAvaVpvdUU5?=
 =?utf-8?B?KytjU1dnOGt5TUNicmhRMkczbStTcUp4eTVobVZCN1ozSmQ4S1QvK2VSU0JP?=
 =?utf-8?B?dnJNZjBldUNYWEV4ZFRrNDhZNTl2dHVudFJzY2R4ZkhWbjBYSWJpOUlsUm1Z?=
 =?utf-8?B?TEQ5ZEpzZUNRWVV6SjZJR3FlVTlZbzk3NTdabU9UOEU1ZWVxOThHS21wV1Nl?=
 =?utf-8?B?bkNhbmgwL08yNlFIRWpOdVRROEVqajhyRjdwMFNSblJDNEdFN1dQa01iK3Bt?=
 =?utf-8?B?ck5Dck1lVVVtalhHRkhrdytSSWlxbW5id1NsYmZiREFtYWRiaUJiaythbzRT?=
 =?utf-8?B?d2Z2bFhpMFFTRUwyb2tSMUJmb3lCZ2xOYVdyaVJ2Lzd6bDRxcy90Sm9zaTVE?=
 =?utf-8?B?YWZTSy9XWm5uYWpQYTUwK1lvMFQ4eC9VM013d1Z1SkJMWVZtd2RiUVhpcktm?=
 =?utf-8?B?NXE4MkY0UVY1a2pwWHZUTktPRjB6ZmRKSE40VTlSUWhwU2puNitMaUNMSUJU?=
 =?utf-8?B?T1F6alZjZ3VMdWt2cHVoajA1R3lyNjZwSHJKbXg4NWgwbDAyN1hSRVZGdmlr?=
 =?utf-8?B?bHlDS2hPSys5cEw2c0c1ZWY5bHE0V1dZNHoraGU3QVV6L3NEbVBtTzN2aXZv?=
 =?utf-8?B?Mnh6QWtCcGxhbk5Td0lMSGY2V3ZiSnFWTmhLOXBZbWI5LzZGdUNhLzcyS2Fx?=
 =?utf-8?B?Uk1tOTBpUlFnN0w5WHp1U0FnZ2lLSGoray9IMzNWM21Xb1F4WFl6MlQ2UWNw?=
 =?utf-8?B?VzJ4WldDYURaN2xnRTh6RVZRMFU2UGVNc0FwOHowSjR5RnIrdUsvMGx2SUJC?=
 =?utf-8?B?MVgvRUZoc2pDWEFXVDk2YmdlcEc4dWtoUEN4d29zVW1tUWFJbzhIUG9peWl2?=
 =?utf-8?B?Qm9WL0RYaHJXamMvRGhwRHorRHZVWDBFV0o4QkZjY0t2RFVLUzUzSTBWZXg1?=
 =?utf-8?B?dUJKQ2owbWJ3c2FQalZuaVhjRmxyNHRPWjFidCs2ZFgzODNuZDJxN0ZxTmVz?=
 =?utf-8?B?Q0t3NXV3OGV3b1RUNGUvd0xSMGdGNXJWbUVpT0w5OFZ1REFaaVVKRGtwZytu?=
 =?utf-8?B?elptdVI0UHFldnE4eUN3dElOUks4Q0c1dnd1WE1sR21mR0Fpc2pYdlhVZ1R5?=
 =?utf-8?B?T09qeEMweVdSRlFueEVXRjMvOFdSNUJVTmZTeUxrODJYdEtjRG1QbnZ1K2tW?=
 =?utf-8?Q?tb3hdJjQR48DN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STdWY0dIcGlIRDNhQ1VwL3VQd0Zic0RnSGIzbjYzTW5qaDRmMmF4U285cFZx?=
 =?utf-8?B?TEdnZURtRk9welhSSW5NS2tzR1lSblFjOEtDL3NGYkZNbHFacjJjOWI2T1Br?=
 =?utf-8?B?bjNQbWgxRmc3VWVRV28zdmVwTXhFWDg3ZUJyRzI1R3psdFJKb2ZZbzhZYnNT?=
 =?utf-8?B?bGZQaVZzYmhSOGNId0hmVkE3d00zWTFvT05vYUltNzFnM1c5QURNZEFvSXp0?=
 =?utf-8?B?VXdTd3ZwMWZBcUltVE85SkJOWjNPdm1ERWhVOTh3UlZWNFRVNzV1V1ZXQWtw?=
 =?utf-8?B?NU1oN3FlcExNajNRTzRXRGV1Ni9mbXlodms1NDBLL2I1d2VlVW8rWWtVa0l0?=
 =?utf-8?B?WEo3NXNQZXd5S2tBSFRiODQ0a3IxV2dBallTUC9uczM3czcvY3ZncUlVYW9z?=
 =?utf-8?B?ejFlTWtvdHArNmR0WWtUbi9jbGtudHE5MnlRbFhFUTFId2tYZE9HSVh0N1pR?=
 =?utf-8?B?K01rVm52SEdQY2lONVJDRXZoS1Q1bjFjblJlRGdEYk9xWHhqdGptTlFQSlJO?=
 =?utf-8?B?QjFFQU0zWVhlSE0wcFo5cURsTTVFVkc4RGlMMy93SnJQKzE0MTFFWXllNWZr?=
 =?utf-8?B?M3MvZ3NzbUx5UTVvbkUxRzE1VHRaMFdyK0E0L2JEbDBHa01mZiszWmJBL2NO?=
 =?utf-8?B?TVpxdVJKUU5TQ0RqNG1RWGtweWQ1eUZQTFErcFliNmtvSlpxR3NTa00rVE9Q?=
 =?utf-8?B?TVlMUWN5WmZkSHpFdXlpRC9kdm9mSXE3VSt0RXM1RGNyRUFNKzZCSGNsYit1?=
 =?utf-8?B?Mm9TTGRuNTJrM3BmWDZZSnhqVUg2M2FTYkpBYWYxUCs5b2RXd1lydWhGZU1U?=
 =?utf-8?B?Q2FMZDhTUnQvV0wvTlZZSk9ZVE1GN2hrWU1rZ0J1NldXU2RqdVJqMExDSUpx?=
 =?utf-8?B?VjZQUnZYa0pHbnNIRUxhQVBkWXh6Yk9LOE9KcnRhYUFINnVRN2trNm9jN0tj?=
 =?utf-8?B?RXU5eXpaVmZBVkdMVG9FcWNCRGRGYy8xQ2xJK1ljcXRQaUpuNUtxNThPMFpo?=
 =?utf-8?B?dUpYR2c0aEtTTlY5dzJ5NjMzeWZxSlJBV3lUZGdHbENTa2Y5bHFIVE1FODNL?=
 =?utf-8?B?ald5NklDcEJoNFF5N2NLbEZhQm9ERDNVR2NFcWdCenZTTXVQaTBVSDcxS2di?=
 =?utf-8?B?K2I0K0xRMnhDKytLMHR3aGprY2RFN1JqczdpZGl2RW9MdElhUGRJMXdXU1pl?=
 =?utf-8?B?WUlnMlRNaXdtN2R1V3RYOXdtNDduY1JOVFUwUysvaU1sUlhJRUF5RXZYd2xw?=
 =?utf-8?B?Mmw5U2pMQ0JXQjhkcDZaRzBJdXpCYmFYL292bjVZa0xuNVlUWDBpY3VESlNO?=
 =?utf-8?B?a0o4eVdMOGdiM3NGblh4MmZLQ1VsRXNPMGlkU1IzK0tndlp5a0poUmZvZk4y?=
 =?utf-8?B?TXM4ekw4MmtLRmp0M3RKWnVOeEpYL2k2UjlXT090SzBvKzBKWCtBcENIUGdR?=
 =?utf-8?B?Z2hCbkdVZEtuRmFWNWZkNG9ZeTduTE5UNFRzZmRWVDMxSHo4a3ZCa3NscURn?=
 =?utf-8?B?K1NKZzhFWXV3UEtxdkxXVmk4TGtjUnJyNSt5b2RLM3VudldDQXVQQlBlL29r?=
 =?utf-8?B?U1NRdnBLRWxQRXBpeU53ZFR2bmVJeW5ZTFREaC9ZZXliWk4vUDhzTlZBd1Fo?=
 =?utf-8?B?WVdJaURjcTRDazlvOTY0MzRVQmNQTkVZaEpmc0IrcXRSL1lCcVZCZ3hsVXdG?=
 =?utf-8?B?U1ZJRHQyOEhzZC81RnRRMTRMbDlncG1rSVltSkxJdkVhSkRjU0d1Z29ldVY4?=
 =?utf-8?B?ekozMXZSMFBVUmdvbW9IY0FjSFhnT01KRjhoTGw4amtsRVUwenF3VkJvWW1J?=
 =?utf-8?B?ZHFuUSs1ZGc4QTRWY1VvSG83Zm1DS3NSV0RvRU1rTTFIMzY4VVoyL3NBQjRw?=
 =?utf-8?B?cFNSTlZYZDZHUW50RUlrZEVSQUFJRVU4clgyclZRa0c3MnJOTjdVNjRoRlly?=
 =?utf-8?B?QlBhdndEQzlvb0lhY3NGTW5aUGtodk5UTENhejNVNW5oRzlZNHhId1hLN0t5?=
 =?utf-8?B?cEhvL2tZM3htcTdHS044R2tnTnRrODcwTVI5MTB6d3AwTXBqNy9STWZXajVt?=
 =?utf-8?B?Vk85TFhDck5nK092QmdoTWZuR2MwU2FVZ1hZaDdJZFFUN3VkSDIycTIwMi96?=
 =?utf-8?Q?lgLtzlJzsJ8aOTWnlKqPKLCfF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae2bde9-1237-4688-1f43-08dd47646320
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:44:24.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NR5WPiVe5WWTjklonV4rnHxjGC94dFp/tPCfLi+By5t3Bj+s0NpaBpXinK+7ax3afzPHfStyYkyQO0SmUT6aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

Hello Mario,

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Use the perf_to_freq helpers to calculate this on the fly.

I think there is a benefit to having the min/max_limit_freq values cached.
These values help us avoid unnecessary amd_pstate_update_min_max_limit() calls in 
majority of cases (where the policy->min/max values didnt change). 

For the cpudata->min/max_freq values, I think there is little value in caching them,
i.e. only used in amd_pstate_cpu_boost_update() and show_amd_pstate_max_freq(), which 
are not supposed to be called very frequently. 

So, I propose we keep the cpudata->min/max_limit_freq variables and remove the 
cpudata->min/max_freq ones. Thoughts?

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 14 +++----
>  drivers/cpufreq/amd-pstate.c    | 74 ++++++++++-----------------------
>  drivers/cpufreq/amd-pstate.h    |  8 ----
>  3 files changed, 29 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 3a0a380c3590c..445278cf40b61 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -214,14 +214,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> +		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>  			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> -			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
> -			(cpudata->min_freq > 0))) {
> +			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
> +			(policy->cpuinfo.min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> -				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
> +				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
> +				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
>  			goto skip_test;
>  		}
>  
> @@ -233,13 +233,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  		}
>  
>  		if (cpudata->boost_supported) {
> -			if ((policy->max == cpudata->max_freq) ||
> +			if ((policy->max == policy->cpuinfo.max_freq) ||
>  					(policy->max == cpudata->nominal_freq))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
> -					__func__, cpu, policy->max, cpudata->max_freq,
> +					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
>  					cpudata->nominal_freq);
>  				goto skip_test;
>  			}
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 573643654e8d6..668377f55b630 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -615,8 +615,6 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  
>  	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>  	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> -	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
> -	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
>  
>  	return 0;
>  }
> @@ -628,8 +626,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 des_perf;
>  
> -	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> -		amd_pstate_update_min_max_limit(policy);
> +	amd_pstate_update_min_max_limit(policy);
>  
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;
> @@ -684,8 +681,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  
>  	cpudata = policy->driver_data;
>  
> -	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> -		amd_pstate_update_min_max_limit(policy);
> +	amd_pstate_update_min_max_limit(policy);
>  
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
>  	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
> @@ -717,7 +713,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  	int ret = 0;
>  
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> +	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
>  
>  	if (on)
>  		policy->cpuinfo.max_freq = max_freq;
> @@ -901,35 +897,25 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
> -	u32 min_freq, max_freq;
> -	u32 nominal_freq, lowest_nonlinear_freq;
> +	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	if (quirks && quirks->lowest_freq)
> -		min_freq = quirks->lowest_freq;
> -	else
> -		min_freq = cppc_perf.lowest_freq;
> -
>  	if (quirks && quirks->nominal_freq)
>  		nominal_freq = quirks->nominal_freq;
>  	else
>  		nominal_freq = cppc_perf.nominal_freq;
>  
> -	min_freq *= 1000;
>  	nominal_freq *= 1000;
> -
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> -	WRITE_ONCE(cpudata->min_freq, min_freq);
>  
> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
> -
> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> -	WRITE_ONCE(cpudata->max_freq, max_freq);
> +	if (quirks && quirks->lowest_freq) {
> +		min_freq = quirks->lowest_freq;
> +	} else
> +		min_freq = cppc_perf.lowest_freq;
>  
>  	/**
>  	 * Below values need to be initialized correctly, otherwise driver will fail to load
> @@ -937,12 +923,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>  	 * Check _CPC in ACPI table objects if any values are incorrect
>  	 */
> -	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> -		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> -			min_freq, max_freq, nominal_freq);
> +	if (nominal_freq <= 0) {
> +		pr_err("nominal_freq(%d) value is incorrect\n",
> +			nominal_freq);
>  		return -EINVAL;
>  	}
>  
> +	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> +
>  	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
>  		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>  			lowest_nonlinear_freq, min_freq, nominal_freq);
> @@ -954,9 +943,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int min_freq, max_freq, ret;
> -	struct device *dev;
>  	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int ret;
>  
>  	/*
>  	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
> @@ -987,17 +976,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	min_freq = READ_ONCE(cpudata->min_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
> -	policy->min = min_freq;
> -	policy->max = max_freq;
> -
> -	policy->cpuinfo.min_freq = min_freq;
> -	policy->cpuinfo.max_freq = max_freq;
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1021,9 +1004,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		goto free_cpudata2;
>  	}
>  
> -	cpudata->max_limit_freq = max_freq;
> -	cpudata->min_limit_freq = min_freq;
> -
>  	policy->driver_data = cpudata;
>  
>  	if (!current_pstate_driver->adjust_perf)
> @@ -1081,14 +1061,10 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>  static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	int max_freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -	if (max_freq < 0)
> -		return max_freq;
>  
> -	return sysfs_emit(buf, "%u\n", max_freq);
> +	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -1446,10 +1422,10 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>  
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int min_freq, max_freq, ret;
>  	struct amd_cpudata *cpudata;
>  	struct device *dev;
>  	u64 value;
> +	int ret;
>  
>  	/*
>  	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
> @@ -1480,19 +1456,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	min_freq = READ_ONCE(cpudata->min_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -
> -	policy->cpuinfo.min_freq = min_freq;
> -	policy->cpuinfo.max_freq = max_freq;
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
>  	policy->driver_data = cpudata;
>  
> -	policy->min = policy->cpuinfo.min_freq;
> -	policy->max = policy->cpuinfo.max_freq;
> -
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
>  	/*
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 19d405c6d805e..472044a1de43b 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -44,10 +44,6 @@ struct amd_aperf_mperf {
>   * 		  priority.
>   * @min_limit_perf: Cached value of the performance corresponding to policy->min
>   * @max_limit_perf: Cached value of the performance corresponding to policy->max
> - * @min_limit_freq: Cached value of policy->min (in khz)
> - * @max_limit_freq: Cached value of policy->max (in khz)
> - * @max_freq: the frequency (in khz) that mapped to highest_perf
> - * @min_freq: the frequency (in khz) that mapped to lowest_perf
>   * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>   * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> @@ -77,11 +73,7 @@ struct amd_cpudata {
>  	u8	prefcore_ranking;
>  	u8	min_limit_perf;
>  	u8	max_limit_perf;
> -	u32     min_limit_freq;
> -	u32     max_limit_freq;
>  
> -	u32	max_freq;
> -	u32	min_freq;
>  	u32	nominal_freq;
>  	u32	lowest_nonlinear_freq;
>  


