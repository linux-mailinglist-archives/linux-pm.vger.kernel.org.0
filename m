Return-Path: <linux-pm+bounces-42636-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sV5nIaJYkGkDYwEAu9opvQ
	(envelope-from <linux-pm+bounces-42636-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 12:12:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE4213BBC6
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 12:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E26C300955D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26A22FE0E;
	Sat, 14 Feb 2026 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CVxN4dfW"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694712D21B;
	Sat, 14 Feb 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771067550; cv=fail; b=F7sFjE0adMIYrcU00+ojIiFb/EvDsgI9k815Im/IbUha/rHwwG1DyIuTK258d6fUOYv7UI/D0+3aj218CndlUyL7XJ0hc9D/XhQ1TBakv8oQNkBplF6eUTp2SnmFRy1LLaLA4mpb0NhBPmDy+CaJjdjaRvvFTOAZQKTKw3WSQvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771067550; c=relaxed/simple;
	bh=M8JrPg3KcxftmzCCLGcG0rdkaNXXIDb27xxCppIUTgI=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=dfX22y6HFBD4fyU9hK2fDwAJbjdmcusrmQ7uAX9D6o0syrU/fYlK4Qg5qPbQ+XjWKFu4zD/HyBpmtkPzWNykaGE5953as6rhSbKrfI5FvazC1RmvPc7E8QwWfCmlU98t9HIV3hqH+bq0XuVxxDvr9uGYD6okMAom+O1i6LZafv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CVxN4dfW; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKnNXYDzsZER6u0ErvhC2App0NnkKCvI9pWkDfmxQGyVIKllIwqKN/ZXVbSxr81lzsOSuM9sL2pJjaFy6dAuDfI7F1jzwEZ5bgR2b/8YBTt23jUbR3TUW8hwpjEP/2ExWC46y2+YeQsBH+o53AZgNJy41Vt+HRIuJgJKphmx8XMvGJ/OzsPBp8eaMLdb/Q0buCpTU0CUHkRVJCowOZMI2xQSP6dWQt+tl8SId8ywtB75dexn2vdr8XYY04uPAaO1+uU8dnQCxADeB/1t49Ra4PcW+ZWwF7yOR8SuP19stUrSZmx+sWdGmpbOZ+IEJ/N7ZBbAsJvizepkL2mQhEaiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipxXaByoa7Ccg1aX02zT1LPIUKr//1l7392ImuA4ueQ=;
 b=IlM4c3P24fpKIHyoImmT93a0KLduiei/sFy8mnHjkGGkzXBXjYsof9kHqj5c+mkO/cu0y9KuNGEPsxNTinlCkQjGTrWJolhkiBO9XUxE2Bg6GzlYs8Iby9VLMzf6FNEa1NBN8uWw0JyELAEVAIcIvNGQjjljNAbYaaagV4FIAirUwLLYchExUIFkb29UnPV5SWi+TEW9Jar/G1PWR/w4ycs+brozLP4MOtTHRdymRFMOiKuUT+Or2gH3CIJRjJgnxEMi5995WrG4nsTogIxrEbPRXh8hj3nQWqYrjyy0BAeSZMVHDLlZ5HqlZ/oGtS9m4/VqyxSldXQRH5gRDTs5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipxXaByoa7Ccg1aX02zT1LPIUKr//1l7392ImuA4ueQ=;
 b=CVxN4dfWQYgDM4iDXoFWdsYqiU5XtRyrP8JUlcDx2wlUvNiHSzW64ysjfS9kO0yIac49bKeRPJrML+I5gzKVb6B6z4Kr78rk4vk5mDtj2NBRYol7ruPPYL6E/8WQmynD1xVCpNVrXyUl+L+Vt2XTX0270ee1oDNMOIDzfvoeoGIKeRwOw2AZSGy+oOjXZ5nKEnAxwz7qXXrwkRDBsyfogV/zKPSXyfR+FvZmaZmvuVqhbUKPIxd6hMF8m89v0muaTGgQww1iYMWr1WUOs6vSHLW40IlIM1lYclJgfrHw7ifJsb/xk+BphoYzi2Ct+U4hXIHrTI1X/K4JyK3G0x0rzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 11:12:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 11:12:25 +0000
Message-ID: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
Date: Sat, 14 Feb 2026 12:12:23 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cpupower: Add support for setting EPP via systemd service
Content-Language: en-US
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 615f25fe-4b68-4886-1707-08de6bb9ee7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHJCdmNvblZSc2RGc09UNVdvMjMrTHNGSGNESkhacUxHd3preENFOHIwNlhp?=
 =?utf-8?B?OHRFWW9QM3VWZVpaeHQyZWYvbllreXl1eTQ0bUxuMmg1N0p2dFUwdkRiT0VQ?=
 =?utf-8?B?RnF6K2R2ZGtmU0NmUEk1Q2p2TWpwb0JxWWRqbG5YbEkyUXJDb3FXclFHdEY5?=
 =?utf-8?B?ODdCdnA3ckNpV1BSUVg1MndQN214OVI0Vmg2cWJZZnV2NEdLcEl0WkJsREo5?=
 =?utf-8?B?dUxqOVBLL2c2dzhYUTJ2NzFPMTJmKzBBVk9teTZwTTNaUXUwNVNTeFlidTI3?=
 =?utf-8?B?WWcyS3JZZXpxSUxhTWxHcVBNaThkQWcvVnN2cml5K0FySjhVY2czNFlsT085?=
 =?utf-8?B?UmVkZnErendOVUJONzJ0b3I4U3BRT1RYcExyMW1jRXJxUmh1RCtONmhRVGRm?=
 =?utf-8?B?ZHRVb2xMQWJmZXdSeTdiNjUwQTByUTJTaFBUVER6NytOSW1JR1lPQkhWNW5p?=
 =?utf-8?B?akhqL1E1VWZQTmthS0dSQ1FKK0NMcXFUNkYrbk5YcmFJOUdOaWhRWEp4SHY1?=
 =?utf-8?B?d1ZMQ1pXbEFlZk5rUGEvdXpTTDdGN2xvUGdqRGFISVRwVVVESEdIOVM1L3dE?=
 =?utf-8?B?VlE5emxBTmNWVU1NTks1dGsxYklmREpweSs5TE9NSHA1c0NldFI2aFkybEZR?=
 =?utf-8?B?YjJiaW15dm9PbVQwbkpXVEV4OE9qQWN3RFkwTm84cW9jOGdXZGhyMGtJNm1I?=
 =?utf-8?B?aGc5aU91OWFScmNSS1pzRVVheGZUaWFzcEpSd3hNdnV5WHNQTnM5ajZoZXda?=
 =?utf-8?B?cUl2ZzJZYmFoVm03bnI4SThDRTUxRGJDMEY1djBhODRrcE1DSnpSVDNBWk1t?=
 =?utf-8?B?ME9DNU1DWEtEMXg1eFF0L2pqTnpmbTlyVGN3eklNNmh5ZSs1M0tvRGdHQmxq?=
 =?utf-8?B?cXJPWnVoSXFjQldCb09QVW9NUVU1cFpvSUhwTlBiTkxBRG5jSDNEMERWd2dl?=
 =?utf-8?B?bHgxRnB4TzJHaXg5bUhDaG5uVzczTythSk5DZWMwV0xQVDNyZmNDRWJQMVhi?=
 =?utf-8?B?Z3JGbE02aXBWN1FRU25Ta0Q3Mk1BaytjakF1blVMdU9Fc2xYcDBleEZFWkRT?=
 =?utf-8?B?Wk9iS0FIZXN5bGtkNlBaVzM2ODhNUlRTRHlmQ0FjTEloL2N5TVFkWlduMERI?=
 =?utf-8?B?T1pNeGZjWjQxZThITjkxdlk5RDZNYlg2U3FDOE9sUzY2a21FV3NUR3FSamgv?=
 =?utf-8?B?dGY0S3ZmcHQyck1GNk5iVlNjTXZYdEZBTDRsaklQaXUwMDJNSkdjS2IrQzF5?=
 =?utf-8?B?em5DRDJQd2RqMmtDMDBaaXRkZU1uZjdrOWRLWEFtNFhKOVZFOXRSOUhFNk9S?=
 =?utf-8?B?MFg1RGFxZTFKTG5zQ1F5QkZJd1Y5NVBibmY0UFV4dXdsOVhhdE16YVV2c3Bx?=
 =?utf-8?B?eS94SW1xZzhOenJhM3RNUkNWTkZnTnpDSUxGN3c0WFN5cGF5MVZERENqWk1R?=
 =?utf-8?B?Rk1XTnJCU3hKbHMwK1hMMytTd3hrdlNxRUkyRGo5SmJqWjk5NTVETndQcGlH?=
 =?utf-8?B?bmx4bEVzdzFZb1l0T0dqTkRIdk1jZG9kSmZha0Mxay82UTNEcTVrL3NMV2du?=
 =?utf-8?B?RUdyZ1VMU05FVkJiS0ZHQkhOMG1Fais2dzJqYVVLM0gvRUN2NlZDdmw5dUx1?=
 =?utf-8?B?WWt2UTl2aGpidUpybUZiQ2Y2QkhxYzJwNTlWRklJcnRNYU9sWnhQUXlkZk5N?=
 =?utf-8?B?c0VWbWlRSWdMVUN3TjZtTUJSeXIyNFlQcTdWci94UkwxclNaNFJkd0x5bjVk?=
 =?utf-8?B?S0VPVEQxUVl5bDhnSFhzQ0VyUklqcnhId2ZMeDlVYWtvakg5WTJmR09uWm1P?=
 =?utf-8?B?alRScG1CN3JLSWdacGdpb1hleldrQk5rVDhnK296MDRjVGtLK2QxRzQvZFEr?=
 =?utf-8?B?cUlYY3Joa3BQY1NnbGx5Y3dMYVhncGlMZWlyYVBqcWFBVmI5NTdmRW50cGZC?=
 =?utf-8?B?eXY0NU5hcGViWWdlcCtkVWFYY1hqK0hMQ3orNVpSSE1IUmxlQkJvYXkxbC9E?=
 =?utf-8?B?K2RaY21pMWhib3RraFVvb0FXd3Y3ck91ODB0QkU0WDdBZ2tKRTZXanhWTE1J?=
 =?utf-8?B?c2c1VnF0bWdzMzRhcko0N3FxZlNmRHR5Q2s1dkl6aEl3T0d4MHc2dVNwYmYv?=
 =?utf-8?Q?WN40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eThjVkxLamppUE5sVzBCMGYzQWw0Tkx1SFJLUWQxdVZwOVRVN2JiVEtaL3VW?=
 =?utf-8?B?WjdsZ1pORnhZb3pPTVhnS2lsMHBUb1hXbXF3c21YWE5BSk1HQUE0VG5MYjlN?=
 =?utf-8?B?L09DOFJISDYzQURxZGpJSXZUTVBTYnQva2NaK3A3V1ZXUXlFMXRpcjVEaGdF?=
 =?utf-8?B?QjhtZkk2Wk9CKzFnWUtaeVJsbTBnNkthd3lraUNwMzY1TFdyWkZvV0dkdDA5?=
 =?utf-8?B?LzVucUpUcU0vTHR5ZDd1OWpQU2NyVmkwVmloV1M1SHJJVnNZTmdzZW00clVY?=
 =?utf-8?B?QXRVWmJucEpGTHRRZE5CSzVTRkZ1MEtQVFJjNm8rRUtuNTM4RlpPT0prZk5I?=
 =?utf-8?B?OWp5N1lBSTFlNFdkVitydTRoNDBkRXZqYW4xUU45Ry9wSjRiZFhHNzhDOTBr?=
 =?utf-8?B?Z1JaM2N0VW11K0RKWmtLdkUrOHV6Mkp5SFNtbWllNlVxWUQvVHZ1YS95MUNo?=
 =?utf-8?B?S3l0T1B5N0wvQmw0eHVDN1c2RGUxaWppSEFtalZ6a3pFWWJqb004MmdoTXdz?=
 =?utf-8?B?enVNTlpUazE4Z3VqaUh2VjVCZlRTNTBHekJsU3pNUEc3R0k2dTI4OE96SkxC?=
 =?utf-8?B?RWZGd2dCZXNXaXFCcjZvYTltYVgyS1FaSktEZ1QvaEZtOEpJZkl5dklSK1NG?=
 =?utf-8?B?cXlzc0xFaG41NTljMGtiSUVuc2JxWFN3c3BhNHoxWkJuZG5YRE0yTmdBbmNK?=
 =?utf-8?B?WmRNdm03SzN3cnhlYWtodi82bmxHbjhkUFlnYVZaK2ZjWW0xU2JWTS9qL2tI?=
 =?utf-8?B?UG1VV21LV1dybXJ5dVB3eDhQdDRydnpya0NrekxuOWlNTGh3WElTU1hNOHF3?=
 =?utf-8?B?WHUweUNHUGxtaU1SbjE2RFN6b21YeGV6V3psODVTc3FqOHNKcllZcG9NdFJo?=
 =?utf-8?B?NVZrN2JPYkU0Z3YzaGc4YXNyVnBUc05GRWh2Q0grUi8yVUFxdDVkNUFDSGZM?=
 =?utf-8?B?d3ZiOFZrMHYzZmlsVlJyMC90RHNQTEhBaDBvbUk0ckM4Tk9kRkNWUkI5aXQy?=
 =?utf-8?B?OU9POGhCRnNWeDVwM1lKSWwyQ09aS01QM0FPVDhGa3UvZUFvdmlodEt6YnA5?=
 =?utf-8?B?Q05lWDhaR0Q4RTBaRlh0RTZzclIwNUQxeVdJS1NXN2Uvb0J3bUMzQTdTUDg1?=
 =?utf-8?B?Y3M3b0ZRUUtyQ29idDhhdFBWQ0ZNSDc5NVFXeEcrekh3QzlscHNZa3pQakFj?=
 =?utf-8?B?eDdnck5xYXV0Vkl1SnRzbkFOTURNd3ByQWpNWUo5TXMyd0tUUzdNR1hiLzRi?=
 =?utf-8?B?VTdQNlN0VzB2bTdDTnlHUCtaZEVKWSt2amdxTUJBVk5jVzNFRTBpeEx0N08y?=
 =?utf-8?B?clgyd05YbkNPWVN5dHZQTlJGWGNjdzRLK1g1ZWRzcXBaTUVMNGVvV2QrVnlB?=
 =?utf-8?B?YVBseWFjVVlSUXZGaE9lVnFaMk1BYXZHclZYZm9jTE9QdGs1OTBBOC92ZDhF?=
 =?utf-8?B?YWZKVFptWkZLQkl3T2hHZXVnVHRrZmJuOUVzQ01zemtmMmNqbFg5QjBGWUh1?=
 =?utf-8?B?VHVWYjQzR3hYQW5CSXEwZCt4NkVrTXVIb2FLZytwaEhNR05hRG15MlNHZm5L?=
 =?utf-8?B?bFFUVGQwaFcrNkk2cTkxbzJWWDcwdFcwbjNyZlRIOVR1aUVrd3dERGVxQXRn?=
 =?utf-8?B?Q3BlTWhFWWkyczNMUHdhQzZVa0xyRGx1UW96VVNMT0doWSsyVFB2SnkyQThr?=
 =?utf-8?B?eU1MVDlqTE1QWTRWeWtUdnJJZXhuTlBMdjljUVJlZEpYNEhCTEFUOWZIOTNv?=
 =?utf-8?B?c2JabXJpRkwycUQ3cFNzSERGZ3ZOcm9iUitSMVBHanV6dU5CTGtxNW1xWWc4?=
 =?utf-8?B?TThlNmhMOW9hdGFJRkFIcTZXWnFJMGhqYUN0TEhXMmMyazNGZk44RW95VGdE?=
 =?utf-8?B?eFVBeTRrSGpJWFhkaDkwNkFzZnNjT3RHbitmdksrYm9YVkU1MHQ0cFNtU2Uw?=
 =?utf-8?B?ZnNqWmtCYnllSzMvT0E1RzduVFIrdEpkb3d3Si9aR2luWjRKWWxMQ2JNWVZh?=
 =?utf-8?B?ME5JWVVZd29YTi9mZVdGMlM1STJJVEV2eUlBd1lFU1NNQlAwVVpFcnp3dGtW?=
 =?utf-8?B?QnplVkliV1djNEJncWFJY0tLTGhjYThJRXVhRUFOOWFsQW10WUlleGgwRGtM?=
 =?utf-8?B?YzZpdmVQM3h5dkttakxDT2h2bUo4b3RGMzNNczJoZ3JoY1hrTVhMaXdwdmZE?=
 =?utf-8?B?TzRDZDByOEo3MStTNXFKRmFrZ0R4cWhzNkRxeldraFZ2ZHNlaVFYN1RYSWtW?=
 =?utf-8?B?dm1DU3V5V3NmZHplL3dnOVEyN0JRNHhObnJKU21UV1VlNklYdkh2UHdLUWtF?=
 =?utf-8?B?MVV4OS93T0JiZEJFOFl5eS9BWXFrcXBjMkJFcGdJTHJaTGd2SVlaQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615f25fe-4b68-4886-1707-08de6bb9ee7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 11:12:24.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzdG9KSFoJQFxRXF8VoU8dafANBI3W7qFg1qBNS6dRPv+BfaZxj0ezauEJmx8tY6uEZArG5qiRrPjOvDAf6iVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42636-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Queue-Id: DDE4213BBC6
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

Extend the systemd service so that it can be used for tuning the Energy
Performance Preference (EPP) as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tools/power/cpupower/cpupower-service.conf | 5 +++++
 tools/power/cpupower/cpupower.sh           | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/power/cpupower/cpupower-service.conf b/tools/power/cpupower/cpupower-service.conf
index 02eabe8e3614..abbb46967565 100644
--- a/tools/power/cpupower/cpupower-service.conf
+++ b/tools/power/cpupower/cpupower-service.conf
@@ -30,3 +30,8 @@
 # its policy for the relative importance of performance versus energy savings to
 # the processor. See man CPUPOWER-SET(1) for additional details
 #PERF_BIAS=
+
+# Set the Energy Performance Preference
+# Available options can be read from
+# /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
+#EPP=
diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cpupower.sh
index a37dd4cfdb2b..6283e8bf275d 100644
--- a/tools/power/cpupower/cpupower.sh
+++ b/tools/power/cpupower/cpupower.sh
@@ -23,4 +23,10 @@ then
     cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
 fi
 
+# apply Energy Performance Preference
+if test -n "$EPP"
+then
+    cpupower set -e "$EPP" > /dev/null || ESTATUS=1
+fi
+
 exit $ESTATUS
-- 
2.47.3

