Return-Path: <linux-pm+bounces-23821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE8A5B94D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 07:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D3C3AFD7D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCF1EDA2B;
	Tue, 11 Mar 2025 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iB9888xZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4E13C3C2;
	Tue, 11 Mar 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674906; cv=fail; b=TM3TGr8SZEBOl101ngpOCTdr0cSIA0kWgYn7NyXmdP5J8i4jkDH0bUSMptxLGaj3LH4UqdRpVEm/Le9YhZ/qkbA9RH2r1vsZ41MHMVKqbuLd0XqtUKL1L/BgifXWVCLKGMWVOIdWO5Ms6zVNT4H3GHBLNCtswMTVV9oD6a1hg48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674906; c=relaxed/simple;
	bh=3LxbpnV27cC+DYj4WY9LX9CDWvThitFQBt77L15Np68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HCT2GhjkT+hC0ND6brfjISaVafwV2kAx56jmoU7zPOgMjw9RzgXhOdn0xSYtj4akmw16JkJsv/xzlfPRqQeUjC+srVSFCVb3iD/zWi3o/D5YSoDu7PRRu2t2X15x1dkIXTpfjOGHQ5SCSv5o9010WrAwT7N356A6E5aCSMtGITw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iB9888xZ; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvkWYEFhxPO/SzpeWwDYaE/6pq8GL2XvmYg7pjtUgaiLcldGUsYIL1HYoiV/G3ej8WQVEsAjGpVQ/ftONQYfLUU2xwfsMMUlKmJpX+J7X4Go1SkkoWIvqG7MMv3BRW20A4ftltTFbX59b8YItprKq4LQ0mynaraF+q4OGttooqMv8ED8nwneJ5xN/yaUIThvYr2ePeCtKD2jIFE+tlDY55lO+uTahiL/8wo9xIGPaA4OJsUhSR6dnR2RT8biavB3Byajr9HzOrgGRo3BwKgNVsSZRWoMbfCN9xgnjO+DBQuqQd4778TD/2Bl4jRNhisSXrudnULpr3f/EQ2ijnAadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BufKGy9IC7F/T7m5/CNtjvTNx0IqN0GOnwf3TUO/pQc=;
 b=ySp0BVhxzeV+7pDrCxmFXwATR0A8RIwHEg9lxDWQ2STylhgsffiuTbXGe/8Up4REJmmTHgtIyA1cJygWTgQs7CtdKVmNj1aVc4kQfEh9qSvXt4UkWoCK3JVrtBHEQhG/joTkY5jPK+e2GbmcuVDo1Ep4YORB+w8w6pPLBJ0ZR53DdKGjK5IQfl44LE84FGqyBfBJgRsaovuOquyENHveoFHGmB4svfJS85EehpW4NAvHZOxiEz+1Sr9pmqZz/XVSSdbHtrvc3d4MR+OyurIwmsfnBRORVAZ8xqBzp2X6vUL0TjIGtg9LAAXWrtpCQ0s1z/e+hx2iixHGrDXwmvB+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BufKGy9IC7F/T7m5/CNtjvTNx0IqN0GOnwf3TUO/pQc=;
 b=iB9888xZiNwcYSO44BpJsUS4GScymbNfXghFLdfgOuOyiO0CoWhFCH9X11B0359PgrEXh60VCfpeRTcEJRir5z7Mk/R7sqwPAJOWwXlzJhSCvzQNkQxLMMHoX07OobgN3LzqGCW+fN1K2fxEWBave8bgM9V1ef82ubrChG0DLpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:35:01 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 06:35:01 +0000
Message-ID: <182723d8-73b2-45b8-bd86-9ffdbee7130c@amd.com>
Date: Tue, 11 Mar 2025 12:04:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250304152327.1561017-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: ed18e0c5-2d70-41c6-ef9c-08dd6066d9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hyZ2JmTmN5a1RleTZNWWJHNVU4SldJZG11SDhubjl0dWpJQ3M1UzI2TEx5?=
 =?utf-8?B?c0lFRmNLYWplcUw4NW8wVlYwQVo3ZHpIeTgxaWtERnZBb0VKcmRYMGhMMS9V?=
 =?utf-8?B?a2M4SzlFRmlSUmc4TVROQ0V0di9jMUV3TDBoLzF5TStCV1NzbVd2dTlrV2VE?=
 =?utf-8?B?MDFQMng4SmJ3aWhyaTlWdTVyT21pb1o5Qk5vNjlPbkNSTGpYQk01d25sRDlt?=
 =?utf-8?B?cTZadXk3WDQxU2Vlcjh5TW16Zy9uVUUzenNCUHBlUS9hNGdnWHVzeHBTeUVF?=
 =?utf-8?B?SllWNXJmQnFSNTdDZldBdTF3UFNjQXRoa0Y4NzB6UGtCY0JlVUU3SlFldWFD?=
 =?utf-8?B?MjRnZjdZWGgxL3NQOGxydS9iQnJRaGZxdXhSZ1U1T3R2ZmdiRUlneklNUTA3?=
 =?utf-8?B?RThDNjRxR0dLaDhzaGIrbDJmVXhPVHRYdkZMV0ZkbHAxSlpKMzVjQjJuLzV2?=
 =?utf-8?B?QkIzNmhDTTlHblBjSFk1WlBVaXpIZ3BqS3VZbk1jZ2NPVGtXa0lsaEo1ejds?=
 =?utf-8?B?c2dEcE5UUmpBVHU1R0NFcVBnKzdhYmZjamtlMTVnYmpPekxXUi9OOEpGSHBT?=
 =?utf-8?B?YUtQa0FiMml4L3pSOFVPbmpxVEhjWmhiVmIyMGVjcFBtRFM0V2prVFcyRnNL?=
 =?utf-8?B?RzBpYm8ycXNleXRncnRBWEdsRSsyWTdHT3pIdmtEVXI1Z01VclBUV3FkR1pC?=
 =?utf-8?B?K1FwYWFCTGtFbkVscm0rU3BpVGpPNFRCRFh6aTB3U2Nvdng4cmpZMXhlWXVM?=
 =?utf-8?B?bm5XWDJvNWtuSk9SS3h2bEJTbVdvMmhkZ2hQeVZ3cTV6c1JPcmg1K0hCMmY1?=
 =?utf-8?B?SWNqNThoTmdYdzViOWxIOGowMUd2MGl5eURTM3ByNFQ2YUlOUytjNitwQnE2?=
 =?utf-8?B?bjQ2cDMzcmtPWUxmNHNtc3YvbVcydWxQWTlIRzk1MFRvSHZ0cHVNbHdiZmNJ?=
 =?utf-8?B?VFdKQ2lRaUFKVjYrNWNVb2Rjd0xKckFsYWo1czVwbGc0RVIrYXhMandyZEJN?=
 =?utf-8?B?ZVVYRkN5Z0Q5WVlxeHZZenIrSmV2QjV5dmZZVVpLcWZsdk1lUFY0Q1dkV0JI?=
 =?utf-8?B?UFFTNlRlYWNvNE1KUDVYT2NvLzFHQTc5aGo0QnEzWktPMmJYOWtCRDF0aUI5?=
 =?utf-8?B?NXpDbER6Tnliei8xRmY1VGlZT3RRWmo0S1c2WWxUV2pQQ055d0h1ZDA1enl3?=
 =?utf-8?B?ZitqSGxaZ2kzdHIvUngrZE1uRjh4R0xDSzVvbUlZMGthR2ltdUNzRU0rKy9m?=
 =?utf-8?B?dXpuNWJoMFF6ZWZPWTB5dTlia0xnOVgxVnFZWEdURlduUUpwZEVnKzlFVWRi?=
 =?utf-8?B?UTdzZ1RhbU9mR3R1Z1JpOTdzR3I0bUp6V2ZxV2NWbVUyb044b1JUZzhHSnE3?=
 =?utf-8?B?eWFEcHFEL1NtMjVVcEYveXFOUG5YMnNPV2tnWDd6RThqQlB3dExDVFg3cFpX?=
 =?utf-8?B?dzNtK014ZHAwK096WkJtdTc2Um5udGdTbzN1V1pDWEwzbGx1VHBHL3pEZmdK?=
 =?utf-8?B?ZEZmb2pEQVB5Wm5WeVpuU3FvdUdDUXlIdUEvK0JBNGlyM1RDci8rYWRtUmpo?=
 =?utf-8?B?UWcrS2R5dTZTTkNjaXhpbWNDTm1iZDMyQU9HTVRNRHNaYkRzQ0hucWhxZ1pV?=
 =?utf-8?B?SDR3MDMvcnlqNmh0dmIxem9HdzM0MHFVK1ZCTXkrTzRQSXhwK28vTGxRNHFu?=
 =?utf-8?B?SWhVZ08zQXgrRkFxTE03Tk5wbzFqc2pMU0l3TlpnMWFhTitNUzU2Rm5VVm1j?=
 =?utf-8?B?N0RXT0dzS0JpWWY2bjhlRXJiMHFST25ZTjVTRVdtY2lZSEFCcHlydGdibFdn?=
 =?utf-8?B?V2pOamVXM1VtNklmR2RFQ2ZNa2M2M1JjaHp5V1YvOG01TTQzbEtxREVPYzZH?=
 =?utf-8?Q?auXEpd4SjVX6b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVpsTGk5TjZtUmpESHB2TEVabXdac3ZjZUFzYlRWaHVvaHVSWTJwdUJwQmNX?=
 =?utf-8?B?cXhSY29yS0pkVHUwUzR1VDJBd3NycUV4bnkrQkpBN0VSS1Q4OUhGZ2FYZXpP?=
 =?utf-8?B?VEVjYlEveHVtNjlKRys0TnJTT0g1MEg3ZE40enpQcm1rQUh1RGw0WkhBVzQw?=
 =?utf-8?B?d01IcnNmWE5PckJpTnVVdE5wbzBxRkRyMVlxMUVRcWt5TTlocnBLRlhFeXRJ?=
 =?utf-8?B?ZUF2OU5MeWwyQ2xlY29oMGVwV3BzTW9TUForSEZpSUtxT1hVb1hZb0dFWHU5?=
 =?utf-8?B?WEt6ckdkc2ZscFBaT0dUT1UwY0VyUkNSYWkwTEx4R1NmSEhSVVptNk1OOFNp?=
 =?utf-8?B?VWNlNUZURk5qTVBhcmRIQmhidE12NythWU56TU15R3RQR3YvS1NJK0wrL1Rl?=
 =?utf-8?B?Z0gvelM0bjBVbkFZNnllK0xIQkpzT3ViRXZOTWZ6aEhaTFJXTGIwL0cxM2Q3?=
 =?utf-8?B?ZzhVQ3NMcW9jTmlpdVlMaGdMdWFHNkNRd0lUVUZLL3RmTVNuZStvYU82N21y?=
 =?utf-8?B?M3FsYVN4QmErK1l6emNLdzkwandwQlRyaXgxeitORTlMaUZKN1ZXWXNNRU5G?=
 =?utf-8?B?Z1pCYzI2OTFoOUc0UGQrMW1jV2JSTUVNTEVSaDlOVjNOK05GTHBSb0hlZGhS?=
 =?utf-8?B?NXY3QVpuNVZSUVV1eFBoU1FEUC9pNjFadEh6UkVnRDhlUUwyS2lBL2RvVmhG?=
 =?utf-8?B?NUJiQ1lyVDV4YWFVUXBObHZjVmRCUmFFN2FtbXVrQkFVZjhLOEp2bjhDQ2s3?=
 =?utf-8?B?aDVQRmdZNVdCbDdEUWUzdUtjN1RSR1NRTEVDUUFOWkJlVWtETU5KbHZEQXNw?=
 =?utf-8?B?bHRidUNmaGdNQlVIRXFNWHZoaHJYcFZuZjFzRUZLL251N01jaHlnUUtWa052?=
 =?utf-8?B?MjIrenRjcTFweVBIUmJTMTJXV1BDdGZtL2pJamFiRDRTTlpsYlRmZE01aHlh?=
 =?utf-8?B?QjNDU3g2S0dEN2Q5bGlBZUMyYzdSdjQvVjN4WXgzWEdYaUJ3TlVRZEVNRmlR?=
 =?utf-8?B?T1hmWmV2UTUrSTdzUkNlRmFOdzdQSDhtbDdXYVI4dGczT1Q4NmJXQkVpNDBL?=
 =?utf-8?B?WFFoVnBRNFZmNzNCak1jaUxtVEFHNkxoWE1ZdS8wSTRRcVBWd2ZuZndSSXJj?=
 =?utf-8?B?anUvbWgwVmRkNUVXWHF4YkhWdkZldWpHWm9OU281SkJvMzdDUDJqa21GaW9X?=
 =?utf-8?B?QndLdWE4bDhZYXY1SGpQUVpyNHJlcy9yZGYzS1g5V3hPTGdlcDBEWGEzK3l2?=
 =?utf-8?B?RlIxYm9XcHFTcWs0RlBNVnRQMERhRzcrY1I2dG5NMDhZckUvQzdkTVhUZHV6?=
 =?utf-8?B?MlpqSkFPekNkUXg0TXhWSFh5SmYxVUpMaEFhU0tLTUZCd0xGNEFDaURtd3lE?=
 =?utf-8?B?NVoySjdGZk9zMWNVOE5kd1laSFNDejFaMDN5c0dhVEFXKzNFYitIeE1IdHQy?=
 =?utf-8?B?aW1NZU1WVjA1SUtmeXJ6S2FIR0NKcWlMOVB6NExEL1V0bVJTbU9TRXBDNFV0?=
 =?utf-8?B?UG5OVHM5dXFZcTFWRXNoU0JFR2UvRlo0NGFrbkRsdlZscC9TTFJ6WVNEb05t?=
 =?utf-8?B?MnRvNlJ1WW1TcC9qZURreXhzY2pJNytwQ3RSZ3RxOFRDWW5ac3JyL0N1emdO?=
 =?utf-8?B?ZUpYWS9xdHFXYVJqQnVwWS84TGV6KzRNbGRaR2JoMlVUczVPYWZrY3AyRDVK?=
 =?utf-8?B?Zmk0OFlBUXhRNEo2T0JhWTZSSWE4dFRFK3JUV1o3L0gxL2VqZW5lcUgxUkVm?=
 =?utf-8?B?S0l2b0g4Ums5S3FDbjBGNVZnOFN1NG8zRGFidjBVc09DQ28xbVpZeFRnZEg5?=
 =?utf-8?B?aUsvVXYrNlcwSWNhWTNiZDJxenhwWTJUblZYNmsrNDdKNVlVbDJVYzBDT2pY?=
 =?utf-8?B?aFExcUUxQmxPTEFlN3FIM1A2ZWZRaEVkTUxuZm01NmlXMEFnVlVwTTU4SWxM?=
 =?utf-8?B?cklVcE82bnBUVlJ1d0tIRFpYSmNpY294aHRJVXNlSWRnTnZES2g3b2tqUHlR?=
 =?utf-8?B?b1RLbkllMzRmZDVuR1I0eUcybEdrcWI3bG1VMFU1WGtmQ0Y2azdNejhhWU95?=
 =?utf-8?B?WW1JZXo4emM5bmxPSUZ0UVF1dlFCbWpkQnFyQ0RuQzJyeDM3NEVRUG1XVTdr?=
 =?utf-8?Q?jsSFZzPG8sVMzisw4NQ6T9hg6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed18e0c5-2d70-41c6-ef9c-08dd6066d9cb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:35:01.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ern8WOdHf40t100cuCJ4TsWyJIKdmjHOmNY7M6/wadmSsa64wBdCL5mkjV/CfQkme37JlnGjTdO3C2T68ms9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

On 3/4/2025 8:53 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Dynamic energy performance preference will change the EPP profile
> based on whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust
> EPP values on plug in or plug out events.
> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Change defaults to performance (AC) and balance_performance (DC)
>  * Default Kconfig to disabled for now
>  * Rebase on latest branch
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>  drivers/cpufreq/Kconfig.x86                 |  12 ++
>  drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>  drivers/cpufreq/amd-pstate.h                |   5 +-
>  4 files changed, 155 insertions(+), 9 deletions(-)
> 
[Snip]
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e98ef41083ba1..f00fb4ba9f26e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -36,6 +36,7 @@
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
> +#include <linux/power_supply.h>
>  #include <linux/static_call.h>
>  #include <linux/topology.h>
>  
> @@ -86,6 +87,7 @@ static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool amd_pstate_prefcore = true;
> +static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;

Is there an #ifdef needed here? I see build error when X86_AMD_PSTATE_DYNAMIC_EPP is not set in config


