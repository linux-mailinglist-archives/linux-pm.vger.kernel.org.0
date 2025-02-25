Return-Path: <linux-pm+bounces-22863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD69A4340A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 05:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3970189B515
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 04:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267642837B;
	Tue, 25 Feb 2025 04:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3u5Cmzy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EE2F2F;
	Tue, 25 Feb 2025 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740456446; cv=fail; b=Ipq7VS6vL+YK+mBuqXjQjyH3/1XyEp0ActQUwKZ9aWcewpQWws3POLwdnnWYTIAphh6nez8CAps14sVkCqY/WYfWpa8IejFKfNTVIyZtHN1ypZBcV1MaDgCyMqtEtj8kzinxH/hpkTBf0/tIq7MkabP9zKXTiAiVWF7kCUfo+h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740456446; c=relaxed/simple;
	bh=y44vDgRP4sFbC/1mjuQQx1/oBMf0B/P6fKBCH2w8bjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CK55vCli6WEfvIWX4EDV814fun5cdvwu+StS+wz6nnVhbqm3nMub0eVeHtQmapiC7Su3wsuuPcfOKIQLhzZWaVhPfkHsz8vHlN09y3vZ0Q7fHK2nBkWHWO7xltJ27bF6YHGCNcVviLlf0fg2JAMD6BwGFAvMLqGzY2lA9eNHAUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3u5Cmzy; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dag9SRCYVu1w24FDAi312+K1QRtGlh3t/lguai0vnxk4Xz/3btMdzlAQnD38Mcz4IwF1AnjTviSvz3/zVJhZFhKCu4l1wTiY0MYavI7uTWbuc2s8+e8CIChCrPSeALWvGzK801IDPApd/4DXFVGfpWThtTZ+wpHYnlqOu/I5Hf4JWh8NI26CLxeLHLtlHYScUo58QvvhSP5BWx14y+0sOJzP4L720Ef9kYfEeFIoW0kl/QPaIbMz6oaf7f3SS2WbO//7YSP1r+8h1xcXhYdvr3/4h651B0E1Rbpd8l7C+tcpzurQ8DU85xFj+UnDyuBjhugmN1dt2+KvKmEspmwLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmsytX81DnXc9wt8FOg1z2pD47T6SPGTeMP3BuSTWcU=;
 b=AcY4Xoz5YOcnFhmECNxfLFH+XUccSWkJDvTgblFzkE13Pir26dBJ08AUJmf7lPuhxTThP9C38kJ1En5XBGYDyKqpuz8Bs7KzdiOEzYBXGlFbyvF2oBWmkFi0Bi3hQ5ANKrogOWARkOJlqoha/uS7n9KKrqAd1M1fOVWfE1cZPv9ylVq/jzaJpf9Mh4iteFtRPECk/PyD2ZpTeEjtksvRdCMPFD6AjBp+ijEmxi6xOhn9p8Sg200QNub0EVQDS8jQUqsbeFTQmkkR8YBixYru2/F+q9g3lc3EBhBzATwg0VJSxAZSbGlambBkowzzY8trfiFsHvM+KLPaT2u3d5u8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmsytX81DnXc9wt8FOg1z2pD47T6SPGTeMP3BuSTWcU=;
 b=G3u5CmzyRsljNe/+jabKXXXTgeajJR2STXT9P3xW7DfznXQHU64Q/5nssuMR0UoAI2HESnwWsTdNV74il7iul48UaHPn18XRv+ZjPr10wD78EUfcBvHW9+KiG07EQQu7ACDXNvTu1vCJWA9h9sbv6q511OaNGSlpvxAbkThT7U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 04:07:18 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 04:07:18 +0000
Message-ID: <4ac22d9f-484f-447c-8113-d6a698b0bc73@amd.com>
Date: Tue, 25 Feb 2025 09:37:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL
 enums
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-10-superm1@kernel.org>
 <086f6284-46b8-4cb1-8b19-009ee0e10af3@amd.com>
 <5a5b00ae-f5e7-4642-8ba2-e5f2f472a794@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <5a5b00ae-f5e7-4642-8ba2-e5f2f472a794@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fadb3a-d8cf-4705-edf3-08dd5551e4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TElZdVUrelR6MVowUzUwMHk0ZzhPaSt6aU5qRDlkUDdxbm0vZVBHbkVhNDdx?=
 =?utf-8?B?VUJVUGcraHQrdHVUTlJIQzdjSkZaaldxQzVjKzI0VlVyQmZmbDB3UUhWWE9K?=
 =?utf-8?B?aFlaTDFKQ2xveEl3a05TSnQ3eUZZNE1DaGhXWGx0a000dnozMlFuSlZYWGNJ?=
 =?utf-8?B?NEpSMW1ydnNtTUE2T2ZjeE1aT1ZpdTdwd3lBb1lEd2RscTEwZ2d1MW8wNjRt?=
 =?utf-8?B?TzdYeEp6UGI0UWlQaE8yQitsUlBmdG82VTR4U3FlTWJZWDlOOHJGRnlBdTRx?=
 =?utf-8?B?SEJpZWV4Y2RydDgyUHhlc1VIaDZEZExUQk9OYlVuQXdrdGk3UW1wQnptb1kv?=
 =?utf-8?B?YnYxVEMyQmd3eGpnUVdXa1V0N3VPWnhPVFV5NW5mSThHQlZQUHNzbGFFd1Ro?=
 =?utf-8?B?d09UVDNlZGY0K0lXRGJxMy9aQnllWXB6TlhrRmpzMVNSdDFsV0o0WjFlNCtH?=
 =?utf-8?B?MFZla3RvaUhhdjU4TlZvODdBNFBFTk1maGZuc3lFWG1DTWZidkZmMFVSOC8r?=
 =?utf-8?B?RTQ2VTMvck02WjdjZEVLZlo2M29SUG0xaTBHeE5PQWEzQjl3c09rWDY4bVFr?=
 =?utf-8?B?UnJ6YUxRWENHZDhXKytjM0pCNTl1K3hxdm5jUnhadXpWMzNVS2pkOUVqU1BY?=
 =?utf-8?B?b0hjKzNJWmtmVW44cjM3bW1IdWdLR1NJYUtWbFBMeU1CT2JaZml1b1dIZUFs?=
 =?utf-8?B?elkzU2VjVnlZWm1DY2tEK1lBK3hJTWhaTkh2YnhmTjhsbUpBZUFxSDk4NkZp?=
 =?utf-8?B?NnlnU0dKTzlqdnlpYjNBRWlDL0dXSGFqQVVkOS85S3JNR0ZZY21EZlJkN1R4?=
 =?utf-8?B?andUaWV0WnVhZm9LWW5taVpybnQ1WmVHL3RVMGZsWm9hN2hqR0hYT3l5Q0RY?=
 =?utf-8?B?eDdTVW1KOVlmQlZLNXorNzlXaFdtRTRQTVdpQ1FtTmtsUFNycFY1MmYzSjQ2?=
 =?utf-8?B?Mm9nUFV5bUp0MFRVN0Zzb1g0WGVmNDRZT0h4amIvVUVibnpkOGRXY0JmYm1L?=
 =?utf-8?B?OEZkSGUzOXNkU1NjeFFjSFlNY3JFTW94QmVmOVBIam9TL1dqc2hKd3hRVklR?=
 =?utf-8?B?WDRhYUdXMUtTYjc1RmRzSGc3M1BicEpTVmZ0UVdJNTFwbldubmhhVlhkZ3NO?=
 =?utf-8?B?UVRUSW94UStRK1ZTNXJKZjJRZEplK0o2dDVmemdVbWlOTFZUN0I3Z2N4K2lP?=
 =?utf-8?B?YmlmYXo0anA0S2ZMWmdZdmNjMlJCNTVEYmZtR3RNbGR4a3NaY0VHME9HOFNC?=
 =?utf-8?B?aTdUdGJxRlc5Tm1paFc3UlQwQTlZQlVNTEp2aEdBcDRRcGNoZDFQQ3VEbXRy?=
 =?utf-8?B?NUI5dWtUM0VDME5oVUE5M1VNZy81akFZNkErN1BXVUFLMkhPdHZONk9uQkt3?=
 =?utf-8?B?ZHRPZ1IrU3hXOEg4WU5yenZGUHN1dTM2OTJKTVVXNlBHa0ZvaCtQUk44ZmMz?=
 =?utf-8?B?N1dDZFRPdFRaSnZZWTVuTUZDT2FYNitUcy9JMU1QWFJzKzFjbG9GbDlKZWUr?=
 =?utf-8?B?Ri9vNjk0OUptem03WTFiZ1BHSVlENjdzOEdYc1oyeW9sc1dwbXJlc0NXd2Vx?=
 =?utf-8?B?MytBTUQwdmhsNk95ZFhDQnVocVVXL1huZ2pKWk1LSWpnYUxNTGpQNUF4bmxR?=
 =?utf-8?B?ZjdOblZScWhyMEgvYXFJN3pHQWtHdElHOWlUN0FKKzB3UGVPK2Z6Mldyam5E?=
 =?utf-8?B?c0Y2NnJMMml3U0pjd3RlUmFsSk5KRDBKQitTaDZYcnBEd1dSNnNqNW83bG02?=
 =?utf-8?B?NUorZkZxTmtxcTNpN0pJWmlPSmNLV0Z2ZHhNWWFjOUxUenpsN0cvcDk0SHNI?=
 =?utf-8?B?b2NGWXAwWm1xUGlvSUlodXYxNW1EeDVMa0dCMWxrcGJ6VGlhR3Jnclg4UEs3?=
 =?utf-8?Q?XhZtwQhk4GMd5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bSt4aDQyNnRQNFlTZDViVUlWNnVadncrZWpDcHMzbk42Y3kvN3FDL0hoYm1k?=
 =?utf-8?B?b3k2K0ZONWJUalpaS3JxRTh6L3BVWUZma0RlT0NMVGQrWURhZzJ0ZmdPUUxC?=
 =?utf-8?B?VG1WV0V3MXNDZHRGRTRlM1h0dnJyQTNMZ3NaNzdkc1lhck43RXJ5YXlmRTVT?=
 =?utf-8?B?Y3E5d001cFNUZ2hlblU3Vms1UkMzcXpxVE5vWFdqaDRPYzFpcTdpTDFoWjNQ?=
 =?utf-8?B?V2RIYjN1RGp0YXM5NmJ4aUk5RE85N2UzRGRJeVZva3BxWWFQNEJGVWpXNWhY?=
 =?utf-8?B?M0lKY3Frdkxid0paWmk3cEN1NEN2azBIOGZmTjNjeUdnV2EyQ3o0NHoyRUlj?=
 =?utf-8?B?cExSNmNmamtBeDU2cEg0RG50UTJKNi9mamttV2NibkRKaThPZ3h5RkxWOVVh?=
 =?utf-8?B?bE02RURXUk40M2xrUHRrVk5YVExKcDQ2TEl1YVduc29pWjdVMU1NblJuUVVp?=
 =?utf-8?B?MStGYTgvSUM0MnZqRFFFTi9idXNjaDA3VzUyME9zQ0MwY2s0TXdQUDA3bVA4?=
 =?utf-8?B?QXQyUzdhRjdCRzF4YmM2bXdydzdzSm84dW12cGsrWnhUbFBNSE9NekVZM1NR?=
 =?utf-8?B?SHBTTkRabGE1MW5WbFFaemtBV3BQSHNLVGt0K3FkZDJDZW0zMS91YWNwcXVp?=
 =?utf-8?B?ai95bHNMdVFLRFlXL3kvSVg3SlpOZTF1ZlBUR2ZqUHEvVjhUS1JuTXBaWmJs?=
 =?utf-8?B?RVMrc2JjMGpuQkkxSThkV2ZLNHBENk1FNlpBRUFRZFZaekNYSHJsb2E5MU1E?=
 =?utf-8?B?LzV1QXg0eFdqOUtmSkU1b3E1YWZHTHBaWTRHTittSWlPbk1vTFVxU1BWV1dW?=
 =?utf-8?B?QUlxeXhOMlVUSVFlZ0tzcUtHT1pIelVTOE1pWXNYeW44MDgwRGw1WllDaERR?=
 =?utf-8?B?bi96MytDZjRkNnVRQ2YzcjMzdk9FdFJoUUlGbnd3NVppZDRJOXpIenVsZ1NM?=
 =?utf-8?B?VzQxYzBzcFNZQmU4Rm52aWJiVm1jUHdrdXhYTTE5d2JJaVRoKzFhOURMYTVQ?=
 =?utf-8?B?TjBnMkJqZ1NUVS9RaU5uQmRMKzB0dmtzUW91L1hQN1ZZK3E2d24xZjBRaGVt?=
 =?utf-8?B?WlU0S1RlVytjNE5lTkRiWGZHOU00TlBaZEowVGFLZ1Z2dURoL0JvWXgrVDhV?=
 =?utf-8?B?bkh4MXZSaXBsbTNPcW1idlB4T1RqV0FBN1padFdXcHUzV3RwZ0pBQTA0bG5V?=
 =?utf-8?B?eUlFS1pkUG9ieHFWMmJ6WGJYZFdYZUFnb1c4bXNzbWVWbjkxOVQwTUtDU0FM?=
 =?utf-8?B?djRuUWlVUTBFZ2x0MVVsYUdYcitDam5ZdkJVdGdMdndyVHRmR3BQNnNKbVkz?=
 =?utf-8?B?b3VWMjdRVzhpbXpEYi8zTHMyMmhLQ2Q4UDB6WE1zVms0SnE5bURYMlpXOVRl?=
 =?utf-8?B?cW5od1AzRXhGcVdiRk45T0pmNGFweGJEUzVzdEhTaXlGTi90ZDdXUEcxZ0t1?=
 =?utf-8?B?MXBleEt2amVQZ2k5R2ZkSmNaSFdUVjR4dDllQ2N2b0phL3J2NHhYbWsyNTdU?=
 =?utf-8?B?enZQSlVrN0hiTXQ4UjFacEZqUWxsVzY3cDUxa1ZvR0xGdFJ0TWY5ZFViK0pq?=
 =?utf-8?B?WkloVVljOGJBRHBQUVFWWVZ6a3A1Wkt3eTdTMUQrOENnNWdFbUJYSFB0TGZK?=
 =?utf-8?B?UEVKMGFFMTF1dVZtU2hzNFYxMHYwaG4ydVVxNjBlTCtvY244RmFqdnA4a3pm?=
 =?utf-8?B?VW9QUWRWVEVYYngva2plN3VLV2JlTXBZbnRpeGl2bHV4L3VvbzB5Z0VmZHFa?=
 =?utf-8?B?VGFCV3ZaMlBML2dBTnFBRHMvOTdTd0kzTWN1Q2VoeWZpdEVFUUxzam9XenBC?=
 =?utf-8?B?YTJtd3BlUmpwOUh2T3FCWU9MYmdpenFGRjlWdFVFVEw4d1FnYlliT3lzZ0Zm?=
 =?utf-8?B?MzlzMHZKcG5Xb1B6RjRkVkVZemNvdkNCbHE2TUhuT0lwb2FGaDIvYmtUSW5X?=
 =?utf-8?B?L2VsamlOUUFPaDg4ekFmSnNPWUtNdTl6UHRFS0cyNEowdFBBb1F6ZmFoNXZu?=
 =?utf-8?B?NkNrYTZXVTVCdStJRC9yT043cHZ2d2VUdkV5c3JCOTFOWWVLcGZNd0tpV1lN?=
 =?utf-8?B?QTVubG4vSXVqU0NQN0ovWFNxV2crdlZlZ1NKY2ZxZmRVUTEyMys3clBIeWdm?=
 =?utf-8?Q?UVSXh6++337TiPC7tzRIYPVmb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fadb3a-d8cf-4705-edf3-08dd5551e4d9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 04:07:17.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjdmx5XNV1m4KHMn5qA7NbcxXXmyk9vuNz2Detv4FoYEA1Nc+BMkfSTl6AdNaDwG7F6AQJZCyQy8Ng7XiSngLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596

On 2/25/2025 5:35 AM, Mario Limonciello wrote:
> On 2/24/2025 00:05, Dhananjay Ugwekar wrote:
>> On 2/20/2025 2:32 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Enums are effectively used as a boolean and don't show
>>> the return value of the failing call.
>>>
>>> Instead of using enums switch to returning the actual return
>>> code from the unit test.
>>>
>>
>> One query below, apart from that LGTM,
>>
>> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> 
> Thanks!
> 
>>
>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate-ut.c | 143 ++++++++++++--------------------
>>>   1 file changed, 55 insertions(+), 88 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>>> index 0f0b867e271cc..028527a0019ca 100644
>>> --- a/drivers/cpufreq/amd-pstate-ut.c
>>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>>> @@ -32,30 +32,20 @@
>>>     #include "amd-pstate.h"
>>>   -/*
>>> - * Abbreviations:
>>> - * amd_pstate_ut: used as a shortform for AMD P-State unit test.
>>> - * It helps to keep variable names smaller, simpler
>>> - */
>>> -enum amd_pstate_ut_result {
>>> -    AMD_PSTATE_UT_RESULT_PASS,
>>> -    AMD_PSTATE_UT_RESULT_FAIL,
>>> -};
>>>     struct amd_pstate_ut_struct {
>>>       const char *name;
>>> -    void (*func)(u32 index);
>>> -    enum amd_pstate_ut_result result;
>>> +    int (*func)(u32 index);
>>>   };
>>>     /*
>>>    * Kernel module for testing the AMD P-State unit test
>>>    */
>>> -static void amd_pstate_ut_acpi_cpc_valid(u32 index);
>>> -static void amd_pstate_ut_check_enabled(u32 index);
>>> -static void amd_pstate_ut_check_perf(u32 index);
>>> -static void amd_pstate_ut_check_freq(u32 index);
>>> -static void amd_pstate_ut_check_driver(u32 index);
>>> +static int amd_pstate_ut_acpi_cpc_valid(u32 index);
>>> +static int amd_pstate_ut_check_enabled(u32 index);
>>> +static int amd_pstate_ut_check_perf(u32 index);
>>> +static int amd_pstate_ut_check_freq(u32 index);
>>> +static int amd_pstate_ut_check_driver(u32 index);
>>>     static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>>>       {"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
>>> @@ -78,51 +68,46 @@ static bool get_shared_mem(void)
>>>   /*
>>>    * check the _CPC object is present in SBIOS.
>>>    */
>>> -static void amd_pstate_ut_acpi_cpc_valid(u32 index)
>>> +static int amd_pstate_ut_acpi_cpc_valid(u32 index)
>>>   {
>>> -    if (acpi_cpc_valid())
>>> -        amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>>> -    else {
>>> -        amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>>> +    if (!acpi_cpc_valid()) {
>>>           pr_err("%s the _CPC object is not present in SBIOS!\n", __func__);
>>> +        return -EINVAL;
>>>       }
>>> +
>>> +    return 0;
>>>   }
>>>   -static void amd_pstate_ut_pstate_enable(u32 index)
>>> +/*
>>> + * check if amd pstate is enabled
>>> + */
>>> +static int amd_pstate_ut_check_enabled(u32 index)
>>>   {
>>> -    int ret = 0;
>>>       u64 cppc_enable = 0;
>>> +    int ret;
>>> +
>>> +    if (get_shared_mem())
>>> +        return 0;
>>
>> What do you think about adding a "cppc_get_enable()" function in acpi_cppc.c so that we can
>> run this check for shared mem systems as well ?
>>
> 
> I think it's a good idea.  Would you mind working that out for after this series lands?

Sure, I'll take it up.

> 
>> Thanks,
>> Dhananjay

