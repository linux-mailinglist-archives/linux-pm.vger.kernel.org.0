Return-Path: <linux-pm+bounces-19313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8349F3373
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023821887A88
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6D24B34;
	Mon, 16 Dec 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="we/DnGJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700E288DB;
	Mon, 16 Dec 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360330; cv=fail; b=DoEGuAvOspRB+veUoZUhUBxJqE8bt7qgNNAW23gdo1p0elu4dERoJtS9Y4JGtg5Xwrwnveg0hW2849oCIlppvv3pOc6waL2xG2lVs1leEQlztzeKj7p3wf54n2xPoMPtGzULt0ZgR5ZBleYoMXElW66LQTFcVw/kECLIdNQHk6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360330; c=relaxed/simple;
	bh=zK/n1NcC55SWLVK7zWbabHYjiHFwkTQ8PmU89Lo4ajE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OpPkQySz9JKJKQ5ygf+TQFVM7SBiz+OtyaqBuPUp1QfF5Nr2xtTNAhmGwrLtcVrxN94uMzXqsZ745eYFFwYu6E6Q0sMNMczbiwWWRMNIstfF8vIeyyCWfcItYi2xAHEWbdUG+JH02lfG0V14UDNdg04m02zptSjg6lPyKqj0MJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=we/DnGJH; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZWYLTNw8hteIRfkJpRpChlg3Ce0lnCG8sCnqa8u0yA101A7LRoIZT1Hnmw/q0X78o9ABhPyIcD5gicOecUwp/4biIjzYVUhXWtua9u/ULXJQhRgNfq9dKUeZQboa8vnJTLbqwdt4QgemMzGsDcVI7izac4CcnFiWS1swkd+KI8Txm+VVIXkyfCaSUKGaZnrr6+xrM+Kz89lviGFtWOuHcM5y/12iX2Tt2tj36tu6H0CTQtASi6F32X2x5DAYy/OQHC1xUJ+6z+3DfeCOju5bZ4L5ytF0U8NqaC9MuK1QtVtGmzqJi2+eHEX4zJbJA5+CLlgt4Rpu6tlqPvjnYNFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LUWr2BpKHjL4aZzTvLVyDdLei7w0XjjtkPLplwceTM=;
 b=gG6kin0ZnFuXIq1iW+a/O0r87d5jXc2zhBn+2dJTjsT9X1CRjMHOpSd7vV1zuIT1EXfvc7Lk+ETCPWeQFZtbMwm/5nMT06MjLzzdgcv3rC5ulVpsFrJOcws4ALQdUXwU5r/zNO90IF+OpTcoaIBedBQ5U9ujpA56n+lAmOkjV3vaoLeV0q1wPWBoIOiAfCwT4dYcYPTPYtBj5nrkB0bgNMaVSuRcPx70gjZMQj5YbqmwZwcnid4qce1PekTmnRf5ZghzA0necKrM+WWE297F5lCMqTo1Qwq2HvjKKCvzHRG6YcrFJmdCjd8aqUKWQtIp+GFaplXxsmVYK3L38+sEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LUWr2BpKHjL4aZzTvLVyDdLei7w0XjjtkPLplwceTM=;
 b=we/DnGJHb+pZBoByHqLXg1vA/BzehRf05RkHMhXQkVhz4Rr5vHgpqUuxdPim3kg1dsT3wmcZsAJrBQNy77WbBbO4+6utkVK+J9GgEuPv2KuQgZ6drczFu8xPnyoGt/4WijMhAmT9EQ0NTnigDmLlPdwbFcX/jSRD3oX4ALG4E3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 14:45:25 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:45:25 +0000
Message-ID: <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
Date: Mon, 16 Dec 2024 20:15:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
 <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: b21c0329-98b5-49ac-629e-08dd1de0466c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEdaWE5MaCtkd0pndzJ0VzZDYnV4RE5rdk42b1pIQ05ZYUpYRGE3eEtsQkFI?=
 =?utf-8?B?UHdWbDdHNjRpUzBEbDlibHdsSmxYc3BVUVpmR1UyTGxveGJQOVFtUGYwTWF3?=
 =?utf-8?B?VE1SeU1Yejh4cXZmTWJkQkd2OEhlSE1UOVZJcTdSRk5HZERvcEgyM2NQb0VP?=
 =?utf-8?B?NUNXSEZmd2c2OEpjdUxiVkt1S01ETTBiVEdzajB2OG13SW9aZzJHazIvS3dF?=
 =?utf-8?B?Y0NocUdYVzVKUXNJZ1lSLzFGeGNmeXUxaGp3VmRmNk42UlV1RFM5QXoxR29q?=
 =?utf-8?B?RTNTWE5SZjQ3T2cwVXV0ZGlraXZ6anY5OEdheTE3NVZnNEZDODVOWDlManhN?=
 =?utf-8?B?Vy81YVJIZTNIejgzb3FtcStsdjZDSklvSWx2eGtJdmp3dHEvSWNJaXU2MmtF?=
 =?utf-8?B?bWdNeWJOUCtEN1ltNGZiVURZaSsyYlNZR1Q3SU1SbnViSnArMmQ0UVlZTzFJ?=
 =?utf-8?B?V3ZqakpTN1dTeUFFQmRrY3NEWnRZWnNBMUVCeVlpRDZvaE5kYnUzblk4Y1hp?=
 =?utf-8?B?UzBDUzZmb1g1WFlNTHpTTEJWUG54b2RZd05ScVhiSEJFVEdTUmNBR1kyOE90?=
 =?utf-8?B?SHoyRXNrV1NEYTNnOEZHeGhJYnZUbHdiRlBoWjk2WVB2TnlxclZoaFRzOWtt?=
 =?utf-8?B?SGVhR1Y0YlViRHB0c3FQaG85NTMyMEJ2Tmg2VXNDR3hZVXJUbW1MQTAyeHhU?=
 =?utf-8?B?QTFIajlJejgrT2R5RFFEMThtTy8zejlWKzV1cUhGck9iNHN4RnduTnBGcmVU?=
 =?utf-8?B?ZjZpUHRGaGRmMGREcWdlVS9lMWRzT2ZaZnlkTTNLcHVsMmc1TWJCSHc5WHRI?=
 =?utf-8?B?Smdac2s0SEUzY2FDWXVRYXpuNDVqYlM5UlVIb29jSHBFZzNGbXBRaDdJU1Nq?=
 =?utf-8?B?dXh4K015SDJ1eWRxNTNnOXBmVjIyZVp0Qndid2U3RFpYVnFtV2VBWGMxblNI?=
 =?utf-8?B?b2dURHJHMXdYU0UwUFo1eENmcG9HMkNxMm1GVGNsNE5KVFlMeGVDa0h0L0lP?=
 =?utf-8?B?OHFSNGMrVmRMS2ZycXpkVk5MU0U3RzkrV3k5dS9OdjY3eU5md3E3QndhcFpP?=
 =?utf-8?B?ZWExSjdBS2tuMWZDTVp3MU41eFBHR1BqZ0xoci9KbGhIN1V2N0ZUMkxOUlZT?=
 =?utf-8?B?WkVRc3pzR2xDbFpyZnQvbi9mOXhyUXdROW1IV0FlekVHblkrWThYQzUvbWJk?=
 =?utf-8?B?Y2FGUGxTOHlIaU5ha2FNYW9TSlVQZlpvaW1YTGN1M09KUWFBV1d5ZkI0cWNr?=
 =?utf-8?B?MUJTMUgxb2dKNDZCbUVZK01hRTZVaDNxdFZYaGZVQmNRT1lLS2s0OS9raVZU?=
 =?utf-8?B?RDkzR0tjd3FUWlkxeHBYblUyc3diSzRLTVZaOWQ2VGkvWGM5UnJyNEwxN3pt?=
 =?utf-8?B?OUFSaFlnaHFqMXdGWnczTjNMcml4VEFCNWhLVzdRTFNscUVSdGNmQUpnWEhN?=
 =?utf-8?B?bCtJRnlZMlRaNTdyMVBDTzArWllRMm5UbFFWTDN2eWJyMkl2MjY0QmlYaitQ?=
 =?utf-8?B?MTY2T3RlZGIwMno1OUZHRDZPc2c1L2M2VnBJTHZPKzVOcU43c1VEWGNJL2sz?=
 =?utf-8?B?dXBFbW1TUTRnY1AzYkNiRXM2cXdEeEdHODMrTWMxWWlNcXUycGNXNGlkSWJ5?=
 =?utf-8?B?Q0RlNVBXMUJ6YkRMNlpRM1c0NzRmcFFRSVgzREM5TGJGZXFDOTBadld6YnI4?=
 =?utf-8?B?QWJUamVpeUNLaE9BTjNBWUpmcHlsRG9ycElWRi9makx3UG1lV0lDdmpFOGJW?=
 =?utf-8?B?RkdScTNwK3dCVlBCN3d5Qm9SY1dEYU03UldiMXp4VDBkU2ExSi9DVXZseDhs?=
 =?utf-8?B?d29EK012bkFFZWxoVWszZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE8rL3lIb0FZa283dS9pOTlESlFCWWRBUy9uM0NzdEVBdDR4Q282cnN5OUdV?=
 =?utf-8?B?bmRjWlFhYTdxT1ZGWDZYdHlJeWpMaElGRGxiZFIwTkVZeVFoOWlpVjhyZDFr?=
 =?utf-8?B?SXpKMEdzUk1lU2ZrN0s0aC9nRW8wRzJpN291ckcraTVESFp5QmNtSlpPbnNM?=
 =?utf-8?B?K04wdm5sR3ZoY010RE9zc3NzZjVHdmw2YkUzc0lnSzE2SWtvQkgybUFtV1FB?=
 =?utf-8?B?V3dDZG50bmxsVldSVnJLb3FGbERlYTJhOTdBQmVjZ0hxLytZRUJsZGp2NXV6?=
 =?utf-8?B?anMvTi9aQzU3WUxxd2NHVnprNktlK2ZlK0psWmRUY1R6bkZvdEJERjFIRW9Z?=
 =?utf-8?B?R2d3Y3BjNkVDdWYxS0xIQlUySDl0ZGNvOHRFWCszaW5BQ3BxRys4OGhuV2xR?=
 =?utf-8?B?N2FUd2Q2NHRBNjF1YitHVW1QZzUwamZlMEhidU1KeW9oWkwrTnQxVHl0MGNo?=
 =?utf-8?B?YVg0cWJSMmdMeDRTRGViVXN6ajI2alR4NE5pems2Ny9RQ2ppVFE5OW5Iazhh?=
 =?utf-8?B?YmRVMGgvYURmbHZSWHNlZDFDV21hU3Vpekt6R2k0T2drelBQa2ZITE1HTEdW?=
 =?utf-8?B?cXpUMmpwaVhybjQ1d3VnZ2F0bVh4VC9TMmplZWEwZklnUERBL1JsNjcrZ3M2?=
 =?utf-8?B?NlUyVVF3dlk4akpaeSs3YW1CV3BMSG9yQlA0YWJOWVpsVE84VmVONm9aNjlF?=
 =?utf-8?B?UkhJOTJjYndHZEdLZlFwY245UVpzVkJMeW1EOXJhS1NMcDMyME0yVlY2Qk1z?=
 =?utf-8?B?QUVqeDF0RG83SmZLMUJLUTBTSTE2YlNsa3JTMHN4aW9lNEdSY0ROVTJMc2Jh?=
 =?utf-8?B?cGd6QkNud0tLL05QQUM3MXptdDd3YUtkdjZHNXdHaVFOaWNtMlpFZVRqTW01?=
 =?utf-8?B?ditQUi9IRVRVVzZ4WEdUbldVRzdpMGVaSjZEbDNuclltM1oxR2dGWWdvMG5p?=
 =?utf-8?B?clJyQ09UK3lGdG9KdnR5YVJ2RFY3TE81SFpwVkU0RTFSZ3FTbzlmSGExTVdJ?=
 =?utf-8?B?WSs3b1ZJVkFsWlBXWmxCcDg5dVlIRWI0N2YyMzQwRThkWFJkODYwcmVXRURO?=
 =?utf-8?B?NG9wZURDMVJBOThOanV4Y1pxOGx3UFhxVWlQblFzeEQyM1kzdTUyOWJkQStF?=
 =?utf-8?B?M1JubWFQV2ZwRVNIK1I3cVllWlgyd01HeEJSR2ZRVjZLZ2tXWFFCaWJlN2h6?=
 =?utf-8?B?bkJRVG1QUVBFZUxqc1pKUVdvTFhQaitpTFZrMjd5MFJiYmc4cEpBUDBDWGFz?=
 =?utf-8?B?elN2WkNXczg1eEZ3VjdPTHVMZmRzOUw2K0oyaENITEFjRGx5cTk2MzdHdWpQ?=
 =?utf-8?B?U1hzRVBTR0FVdGxwa3pKQkpHOEhTbTdGNzVORjZkRmVLUENBMy9DVldNSUto?=
 =?utf-8?B?c2NTU05kK1VVR0pTaHN0VGdlRm5LRXJFcVRTc21MVTUyeVpBRi9ReDhDSWYw?=
 =?utf-8?B?bHRVU3RXN3Ezdys1L3hBaCswbWxwYUxya3FsN0lNWUkrZS9ZUTRLUFlsdmVh?=
 =?utf-8?B?UXhUeEpETmJIRUhnaElLQTFSU0pQVmFETTZDU0xPTXdwUlJ5UlRYL2YvSVp6?=
 =?utf-8?B?M0lkTGVFQU1IT1lwYW5OTU9Tc1lRc25yc0M0bDdDNXJSV3BoaHVkdk9vUitC?=
 =?utf-8?B?T0grcm83czM1T2NPY3liTXJ3VlkyMjhTajJSdUhoSG5MN3lZeGtMVERCVG54?=
 =?utf-8?B?eXpiaWMxVzMwNlFFaytNNVppK3pRc0drbSsxUmcyK2RPUjRKbVEvQlh4QWN5?=
 =?utf-8?B?OUQwdWxtVStXT1QrLzZGMU0ycGZoVHNTcVo5dHpFVUNURURsbFhDa3RpSzZ3?=
 =?utf-8?B?bFFRVUpZSnF1d2N0TEFQZ25PbHR4TndMbC9NSTAwVVU3ZGFQYlE3TFRUNUk1?=
 =?utf-8?B?OUJRVGFpMkJscjF3U1dXK3BYMHoybDhPQjhtMzhMaE1tUUFsUGpqVGlpdDdR?=
 =?utf-8?B?ejF3TnBXMVdFQXN2YmhVU3FjV1dDdjBreDJsZlpON25JNGU4aEFITjhxUlpM?=
 =?utf-8?B?aXY4VGNyZ0N0SGFJalF1NjV4TEFDcSsybzdkS3hnenpYKy9wb25LWkNNZGdr?=
 =?utf-8?B?Z1JHczJodHVKWndvYTFFbmpmbDYwRkhML0RtVExwTzg5ZG53a0RVK0RJcTRs?=
 =?utf-8?Q?xFKopGM8BXD0ucr3XGU5eLKXI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21c0329-98b5-49ac-629e-08dd1de0466c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:45:25.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daI3LDhzbGXSSfljFQzyJmCfoOfdSHAQ1Ul7J4QWkedo1YYwCHGIAj/5o9T8F29+3tZ+YUYpTmXJo++t0WGUOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

On 12/16/2024 7:51 PM, Mario Limonciello wrote:
> On 12/16/2024 08:16, Dhananjay Ugwekar wrote:
>> Hello Mario,
>>
>> On 12/10/2024 12:22 AM, Mario Limonciello wrote:
>>> The limit updating code in amd_pstate_epp_update_limit() should not
>>> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
>>> so other callers can benefit as well.
>>>
>>> With this move it's not necessary to have clamp_t calls anymore because
>>> the verify callback is called when setting limits.
>>
>> While testing this series, I observed that with amd_pstate=passive + schedutil governor,
>> the scaling_max_freq limits were not being honored and I bisected the issue down to this
>> patch.
>>
>> I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf
>> field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is
>> equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed
>> cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq.
>>
>> I think as we removed the redundant clamping code, this pre-existing issue got exposed.
>> The below diff fixes the issue for me.
>>
>> Please let me know your thoughts on this.
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index d7b1de97727a..1ac34e3f1fc5 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>          if (min_perf < lowest_nonlinear_perf)
>>                  min_perf = lowest_nonlinear_perf;
here^^^
>>
>> -       max_perf = cap_perf;
>> +       max_perf = cpudata->max_limit_perf;
>>          if (max_perf < min_perf)
>>                  max_perf = min_perf;
> 
> With this change I think you can also drop the comparison afterwards, as an optimization right?

Umm I think it is possible that scaling_max_freq is set to a value lower than 
lowest_nonlinear_freq in that case this if condition would be needed (as min_perf 
is being lower bounded at lowest_nonlinear_freq at the location highlighted above). 
I would be okay with keeping this check in. 

Also, what is the behavior if max_perf is set to a value lower than min_perf in 
the CPPC_REQ MSR? I guess platform FW would also be smart enough to handle this 
implicitly, but cant say for sure.

> 
> As this is already in superm1.git/linux-next after testing can you please send a patch relative to superm1.git/linux-next branch?

Sure, I'll send out the patch once we finalize on the above if condition.

Regards,
Dhananjay

> 
> Thanks!
> 
>>
>> Thanks,
>> Dhananjay
>>
>>>
>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v2:
>>>   * Drop lowest_perf variable
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
>>>   1 file changed, 5 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 3a3df67c096d5..dc3c45b6f5103 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>>       u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>>       u64 value = prev;
>>>   -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>> -            cpudata->max_limit_perf);
>>> -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>> -            cpudata->max_limit_perf);
>>>       des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>>>         max_freq = READ_ONCE(cpudata->max_limit_freq);
>>> @@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>>     static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>   {
>>> -    u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
>>> +    u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>         max_perf = READ_ONCE(cpudata->highest_perf);
>>> @@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>       max_limit_perf = div_u64(policy->max * max_perf, max_freq);
>>>       min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>>>   -    lowest_perf = READ_ONCE(cpudata->lowest_perf);
>>> -    if (min_limit_perf < lowest_perf)
>>> -        min_limit_perf = lowest_perf;
>>> -
>>> -    if (max_limit_perf < min_limit_perf)
>>> -        max_limit_perf = min_limit_perf;
>>> +    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> +        min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>>>         WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>>>       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>>> @@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>>   static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>   {
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>> -    u32 max_perf, min_perf;
>>>       u64 value;
>>>       s16 epp;
>>>   -    max_perf = READ_ONCE(cpudata->highest_perf);
>>> -    min_perf = READ_ONCE(cpudata->lowest_perf);
>>>       amd_pstate_update_min_max_limit(policy);
>>>   -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>> -            cpudata->max_limit_perf);
>>> -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>> -            cpudata->max_limit_perf);
>>>       value = READ_ONCE(cpudata->cppc_req_cached);
>>>   -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> -        min_perf = min(cpudata->nominal_perf, max_perf);
>>> -
>>>       value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>>>              AMD_CPPC_DES_PERF_MASK);
>>> -    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>>> +    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>>>       value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
>>> -    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>>> +    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>>>         /* Get BIOS pre-defined epp value */
>>>       epp = amd_pstate_get_epp(cpudata, value);
>>
> 


