Return-Path: <linux-pm+bounces-10330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE509923B2E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E34A1F22A34
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82810157493;
	Tue,  2 Jul 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/U8Jb85"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3311514DC;
	Tue,  2 Jul 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915410; cv=fail; b=lbSzKDs2+obpoEK3iSAOkk4L1yWd7Zc11PzOLFo2cOwk0zWt+1bEajmguYcyE4GFdf9DFeWBZiiEwtrJPfA4hnwdrVoD894sl60oI9iUSYAD9VkWSq0ug/s09B12OiKc0clpnpAaeuGrlzOLFfttlu8zHEKgCmydqvrq/u56sbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915410; c=relaxed/simple;
	bh=nCnRFEsMath5fR53iaFqg1jQ3PHXWWcHhVt17tQ9X9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2KyGJK5fNTka7h8u+jsbdbbdr2CvNMfokpZ7im9Cu3ZDr52IYUhqyCvuVPZdRsKI+MX7TJM6DrkV+E2OIIgUEQWyg2VQrkl3bSMhjUA13/GV6G4qlRiLTGzJLW7jpX4WXC6GgA0fze6ovIseL+5eegG0vTQr6ag8panV078iNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/U8Jb85; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbt0G8PLtki0Em3ZbB4QOBxXbVPH6qYzgOKBWZFJ8iP6H4IO+X8pIcJlqC2qqmYIDPnBGAje6/VkFSb2jNI//V+Z+Y8FKlb2KgRb8jG0myT222PtLEnjmWm0Bol5KaP52lhd5n/npHnu7SqGVgXxfqKDL/Nyd/rAlY5miAtM0qipkwTWD8Ro5Ucous9oMpTPvO6E0UdClapAfw+7ELt/8LE1nDZnZEMQC4AyNbJkHMZmr1ZwQ7sW2H02OAOLHd4Fe0e0sLPblWOx8/xpUsmQ8P+evYnBf+5mzcwyAy+QFmyErcfyjHRolitEi7h4Os/XEBr0meqndAvgMUUXeElPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZm6EaJwJOM4P86W8AlQ56dcfFdUME7zBVQveWA93MI=;
 b=byxlztOpnBmryGdSngY62e/UKG9XOkmr0M3cNAsQa6ZG9kCL7zbfLuAHQsdO845gqitiNucq+V+FbmuqgNzGXWg+j0HjW0Gt8EuB7Lmkh9ackOZ766qyEJk+rH6cuYl4mOUp1LcHR8DLQ5+JWS51/FNJgX+3DvFPC9FaIM1Kv+xIjwroyQ3RshXVsxXmNdL4aA6k9sHimBBB6QGxhFMmHV6L+Ou3nZbn/R1K9bILBOHWcxdzMz5KpgpJOeXakRb8TlJj+bLb5yN+bfwZQW8UMks3cEY3El6tIEUY2JuBVGgavTp65qjE8atxSTGISqhlXIg3p/s3hySe97q1myP/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZm6EaJwJOM4P86W8AlQ56dcfFdUME7zBVQveWA93MI=;
 b=s/U8Jb85l9pqnWiEpl/Kye0vZO8vZ5iZSZmU0QbGPufnQnn8oLk7hy43s3lDLrv2oOQ3OJO+lL0vjqFHaIsfJ7w1TbK+uL4L9299f0hnDtPXWOZNNB/3OVc4fwHPnggKHrTFKmkKvhoZ719YeRFAzF17YHP5u5TfvDFIIECx/uU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 10:16:46 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 10:16:45 +0000
Message-ID: <1dec4dbb-e64a-40ad-8160-68326f0e31d0@amd.com>
Date: Tue, 2 Jul 2024 15:46:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] perf/x86/rapl: Move cpumask variable to
 rapl_pmus struct
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, kees@kernel.org, gustavoars@kernel.org, rui.zhang@intel.com,
 oleksandr@natalenko.name, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, sandipan.das@amd.com, linux-pm@vger.kernel.org
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-6-Dhananjay.Ugwekar@amd.com>
 <20240701130232.GH20127@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240701130232.GH20127@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::13) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 179d9a1b-aa01-41a4-b9cd-08dc9a801373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGI5cGdnWkUvVXVRaEgvbG43a0lLT2VSTXo0RHNRS1JzUlZOYUQrNUJrUjky?=
 =?utf-8?B?cjRyQys5MXg4VUdHWDdYYjZQZmZMWm1GanNzSWpxempNMWUvVnZNR1dKOVM2?=
 =?utf-8?B?WWZNSWVRZ0pVa1JNWmJDcXYyMnhCM1ZqWlR1d3VFR3NEdTlOMUVFYVgzb1pE?=
 =?utf-8?B?NTR1WldCbFFqR2QycmJjbnQ4QWx2N1AxR1hwMEpvZTlpRkNVcHozMDRYMUNh?=
 =?utf-8?B?WXlteVphOWhpbVBrYzk2dXhXMk1kV0tFU2dKR1RGTTlXOHBGazU4aTlQWlVv?=
 =?utf-8?B?N1hSM01ld3g0YzUydXlQVzVGbTJHLzQ2cFBNVlJZdXk3bW5va3g5SjBES1ow?=
 =?utf-8?B?U1h5Z05JYlZsSU1wTUtXY0JhMjJ0cUhVTk5iSEZ0TWdtVGFqRzdRRzJTeUJS?=
 =?utf-8?B?NTN6RU9WT1pxTHh5QzdndWtzaFA1cUtyaXFtaktwYlJGd2hUbkRlL1ZBRmo4?=
 =?utf-8?B?NVl6amRWYjZMbW9qZzVzYTVZSkFOOHRyamJZYTVDaEdzWTFxUFBZRWFOQ0lC?=
 =?utf-8?B?anNKeXhKZFI0R29IODFMa0xaM0VmMlJsemdjOVY5ZmtUMmZ6dmFCdFF5QVk5?=
 =?utf-8?B?SDBzRGd2d0lnaFBZamRsVjd5S1ZoSURTaFp0bzEra3ZRM1NtSzZtSDBrWkNF?=
 =?utf-8?B?NU43V2JxY1pLRk11a29WVG5BUXBPcnNKMWVhR28welNHSW84VVRpcUN3MFJR?=
 =?utf-8?B?VUQrdzdqaEpKOTJ0YzVhZTdkMmNvSStCWm9abWlleUMxa3FDU0IwdHpaT0Z5?=
 =?utf-8?B?NEQzemY3QjhMWjcxSXBqZ3l1ZHZqSUNzeXFteXA5MDhiaGRPRE45RytyN0cw?=
 =?utf-8?B?WjdrMnNEOTFwSnJpVS8yTTE1anE4NFRyVW1Pc2Q5MkhwR1FUclRzbWdBTGV3?=
 =?utf-8?B?YnNLVDB3WVpZSUd1TFVWN2Y5RWg1WXlZbW5lVGNCT3N6d29wUEs0WHkwMmd0?=
 =?utf-8?B?SmVlbE5UdmtQeVRleGdrS2lsNGl5V1lCSXU1cExDWFFHTVV0c3REQUZMd0pq?=
 =?utf-8?B?UGZ4OHNmSFlVQ2FqZW4yc2NGZXlXZEVheHpVUUNNeDZTNm5HdDlHNXhSOG1s?=
 =?utf-8?B?czJoZmpEV0RwNHd5azh5TTdiQ0pIbzU0TE9VK1dmTmtxUmtOY1JEZHRVcXBm?=
 =?utf-8?B?QTZXMmZJREtCMmlZYWlnelBmVkQ3MmFsZWpJWW1ZZk4zbFkvNGh5NUlEVTJE?=
 =?utf-8?B?RFNFclBqeTJOWE5xMk5EM3lwMFZyeUNrTlZWUS93RkRwRDZOd0ljb05kT0xw?=
 =?utf-8?B?amM0SkdoUlBjdG1wSDlWV1dKMkk2TnN1ZDJub1ViTVJzYlNDNTJsN09NSHZT?=
 =?utf-8?B?SEhHRHo0amN5Y01DZUJSaDRhYWxZSmE2VTkzRkdaOEhLZXFSVFB4RTJVNzNk?=
 =?utf-8?B?aXJldXZwMXVoc0pTM0g4UHRreCt6Z1kweHQwTVJNc0hPRzdZalQyQi82NjlE?=
 =?utf-8?B?V24yWCtzbXU0azFGSDFqQ0V0eTZpMlI0OEJ0RmtEcjhSYXpoTTIydUE2ZFBp?=
 =?utf-8?B?a0phbUxkU0hkaFltYnRrczF3Z0UvQ3lIbDkrc25yRUxCTytjdEx5eElqZm5y?=
 =?utf-8?B?UmFBSHBURG1XOXRvVlkvaHlqNHNJU1NaSnA2Wlg3NjZwajNuSW1ic1pxcUFn?=
 =?utf-8?B?bUJIVzBDTEY4aS9DL3QrUDdMS3hXOExHNHJEZG85SEUxS3lYVUEzeVBkVDAv?=
 =?utf-8?B?K1RLc0MyeXZzS0hRWjRmbWVtUjJoaWlObjhjNmtVamV5UlN4T3lKQ21mV1Za?=
 =?utf-8?B?aXVHbWIrSEJjajgzWnNBZFVJa21BTUlBRWJqUnZvVEo0SEZXU3Z3aE83ZTZi?=
 =?utf-8?B?MnYvZ0xhVHVFSW5XVjFtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0FoZ2RYcEkwZWRUY3BwS2NqeS9oMVhqOU1JZnk4MjR5eVhqUjNTT3Z1OVU2?=
 =?utf-8?B?S3ovWFpWOGdoRzJmdHFtRzdCaDFzdml4cDNQWlJVQWZBSFE5bGwvV1BBLzZr?=
 =?utf-8?B?bzRqWHgwdVZKMFh6dGZnQ2lLRFBvOW41eTlRWlJ2M05mQ1FKbHlHTHVMSFhG?=
 =?utf-8?B?NVhMcWhYMSszL3FaQjJRd1VvVkFCc1hLc3NQKzhMcUUwbzgrc0Yzc0dhQ3Jm?=
 =?utf-8?B?VmxTeE9rS3ZrQytJWnRJQkp1YlJBSFFMR01MSGVXNFVKZ0RrbGdxbjI3ZXBW?=
 =?utf-8?B?blpGcklGcDgzM2NnZlJSTm9PSjZOSUl3VTRXRlY2SVluU2pGNlZZNXYvMTR2?=
 =?utf-8?B?WlptY2Y5c1ZXajMxRnNYWUFZWGp6K1R5d3RXOVJlSUFLYVM5TEEwbHB4a0sz?=
 =?utf-8?B?SVVRZTFJaG9KRHV1Vk94a0tqVkJ0WjVVck9QRUlnM3J4N0lnbVZwb29oT2hW?=
 =?utf-8?B?VXVWU0dveGdWTTM4WnE1YVhrVU1uaHZTUGJMcWp4OHJjYjNOYSsxd3lDMFFl?=
 =?utf-8?B?WHJWR2ZSVjkwek9YMkdTOGpRektYVjN2SWpFdEV2V3ovZnNtcThhNFNFMER5?=
 =?utf-8?B?Uzk2ZWJBTy9NWnA4aUx6WDZnYTh0UTNQTEdQS2lIQjM2Q3B5Y3pQRnBRam13?=
 =?utf-8?B?VlFQdFk1UTBaMXBHOVhERHJRcU1LWTR4cmsvNjkrSW1YWG9Ka0RuQ2MvYysw?=
 =?utf-8?B?TmJNTjJBMmJYRnJzNmFKYW1RWjcxZGRDdTV1dFpna0hkQWx4NDk0REduNGRO?=
 =?utf-8?B?OTgrTFU2b0ppaHBtaEh5bzBWeitneThqRjV4eDRtVEtPYmJuUXVMYndaNS9j?=
 =?utf-8?B?Zi9VMWJxcTNQU3BxSHY1UFdyb2Vuc1ZLT3ZJS1pEdG03OExnV2JLM2xiQmU4?=
 =?utf-8?B?SUtFVDVrc1V3ZTlCaGtTY1ZUbGZweDhEbnh6dFFNb2FwWEplanlaaFpncDVp?=
 =?utf-8?B?TVdLRXpsS1JXcnJkeWlORUhhUHZNRUtXdnFKZURJNDBqOUE1bzVYSlFLWjFN?=
 =?utf-8?B?K0hnUXdXRUo3YVppQzVQa0ZRSWZWOFFmbVpxTVFKOUloNXloT3hBY25aVVlK?=
 =?utf-8?B?U25lVE5DNXN1NVpxcCtuUHBhTjNIQ2oyRFpjTzErS3RVMkJJWGZ0ZmxIQktP?=
 =?utf-8?B?c2E1ckJ3NkdwTzZaeUt6L2FoaUhxcytIRjdJNlhXejgvSTRvTGlxdlFSd0V3?=
 =?utf-8?B?Z01OYlAwZnpxZTJHQ05Rdjk4cDRVZlZ6dU1SMitZUzJjQVpNZS9zM0J6Sm83?=
 =?utf-8?B?SCtieG9MZmcyYy9lOGhIWHN5M3U1clBGd2pDeXRqNXArdUo4UXMwVmpWTmJX?=
 =?utf-8?B?ZVQzYmNXeXdqRlZPRkl1a3U3dTBnYlhESy9DbXZFb2dqd2Y4SmFKN09EcG5P?=
 =?utf-8?B?bUxQSEhhTjlmc3BUYTE1WmkyTXdUTDI3OUhUSXUxenVKK20yT2Z1VG8wOHIw?=
 =?utf-8?B?R0JJOVQ3and2QXBvWlNTSWV1Z0tFeStVNDJ4RUNkZ1lPMC94Wk9EV2dZYUNC?=
 =?utf-8?B?SWllOE9ZVTZDZlgrdkdTQmo4V2pqaEh1VEU3aHltK1FKZy9XR0oyVk00UmpO?=
 =?utf-8?B?WExPcnUwdXRrUmhkMGhYR3BWakR6MkhlVXdIT0ZLb201L1FFWC9HR3pXazJF?=
 =?utf-8?B?MkVKSlJHOWE5MUsyY3hxcVpEUlN6VVhRa1BWRFUxSkJDdEJ0Z1d2WUgrTm81?=
 =?utf-8?B?UklxaTlEQ1JwcDJpSEJ3K1FQTnVWNUZlRTV5OWwzTFh6T0laOW9BcGFwK3BU?=
 =?utf-8?B?Q0w1Wk9tay81NHBHcDBWUTBTeDJNYWdFNHJ1d1RhMnJ3eTVSalB2NkdCWUNa?=
 =?utf-8?B?S1lXaVIrYkJyU09UYU40bktLakJnNlFhR2pWbHZ2KzN0RTRpaUdmV1dubk44?=
 =?utf-8?B?bVI3WHFBZ2JRQWllZkdocjAxcDYxYk16TGRuOUk1T29OZWFLdURVZWVxbjQx?=
 =?utf-8?B?SUFtdDJUc29melkrOFRJcVNmZ0FVQ0hOS2F0YXRRV0RGWlBOUEdZVXdCalVJ?=
 =?utf-8?B?dmhYbHVBNHRWUWlXVm5lZDd2VXNHU0M0cW9NcTRFTlJZY2JRdjJGUngzajYw?=
 =?utf-8?B?OFppUXlGekgwaGpGUnJkR3kzUmsvWXZSTVJ4STFWOTg3c3F4ZXJWRW5FWWp3?=
 =?utf-8?Q?tk15mJoqXmHkjv9fpQ60YAddo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179d9a1b-aa01-41a4-b9cd-08dc9a801373
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:16:45.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTX4fCSxqGa7juHuHUQBdF5sjJsC/iDzLDH3yqxF8B8MIlsP8+kwi4TqaY0tSWa02ydWTpcC+axZPuQsg8aV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

Hello Peter,

On 7/1/2024 6:32 PM, Peter Zijlstra wrote:
> On Mon, Jun 24, 2024 at 05:59:02AM +0000, Dhananjay Ugwekar wrote:
>> This patch is in preparation for addition of per-core energy counter
>> support for AMD CPUs.
>>
>> Per-core energy counter PMU will need a separate cpumask. It seems like
>> a better approach to add the cpumask inside the rapl_pmus struct, instead
>> of creating another global cpumask variable for per-core PMU. This way, in
>> future, if there is a need for a new PMU with a different scope (e.g. CCD),
>> adding a new global cpumask variable won't be necessary.
>>
>> No functional change.
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index e5e878146542..be139e9f9ee0 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -119,6 +119,7 @@ struct rapl_pmu {
>>  
>>  struct rapl_pmus {
>>  	struct pmu		pmu;
>> +	cpumask_t		cpumask;
>>  	unsigned int		nr_rapl_pmu;
>>  	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
>>  };
> 
> Yikes no, please use cpumask_var_t and alloc_cpumask_var() and friends.

Ah yes!, I did not know about this API, will use this in the next version.

Thanks,
Dhananjay

