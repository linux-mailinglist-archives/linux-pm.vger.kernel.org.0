Return-Path: <linux-pm+bounces-9954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437E91696E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B25D1F21D16
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16416A95B;
	Tue, 25 Jun 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TUO6WK1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B816A945;
	Tue, 25 Jun 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323522; cv=fail; b=ZicmzOU77MMFAAbQTA2z3WjF1rOJAhQmeD43KXZtXpFqSqwXnAfgwtAu0pcDexgcGO5dwm2uthuRhOsOJOfIUMI8VP9XA8PnWSWFBlcpaXvERZWBzrwvAmRHgQ+0gH2+QV63bpfPkIZ1NemwPApHG6tuqHSXqrVr3s1GgpeI/v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323522; c=relaxed/simple;
	bh=R5797TomuUW9AD6aqUaHbQMO/w6odiwxyqm27ZHIpfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXq7o1R6CV2IoRO8xDjZzBCq7Iu/rp1j0dMDAboH3pdkO0VARFtY74lEAdHD49FyxJaxqEcuoWzataZLcenntPL8y4efHEZyTPPLFW0jSsDlqCdZ5cAVtIE9PJDFxEotQ1ehPMzPdP3ziVDQYcOvfWCy2cLJalAYp2A+4YUNnj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TUO6WK1e; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khmYTz+/tw/vptsmwo2SnmXGI7oLD1OKL0PeGLplHHiDonHIGNPotid2On6C/D8kG5ra/KtGGAqOnJoO3wdAmBTnp4+gBZduMHfKIVmTtcg0ql358lgC8aFxvlOG7ritKEvGiylsn3UUs7EmDk+ZksRdWFvaCGSTX6AJNy81oXGRLEc8Zp02/+anEBR5EcHPxYJtMQjv/sMGVXVOsvn2c9FwQi3YE5mxxfDS+gZBCZP2EnBcY0Q/jD41XZ9+vung7Z7V8JpYzYmmhDbdjRPzR1lFibTIm1hhMVozl9aB9ABd6dsV+enmFXcYGNqLfZKb+GS9tJ5rANQyNwlFY2iOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5txOzo5IZ1OZQ2Ua/6gV89+PKqGA1Hr5+ECx9NcrVNo=;
 b=EsmYV0Vqz8sRqhYLxyyfFPEg0Vm9H+4SuKF1A70sobHQtLWvOIOrYFr8oRnZoZOobswXbXZHhiKRvzntbDbH8Pv9gFYIF1cTH4laeEbOtjdGzCgwY+ZvdQGtuPdPpWpC7g9jMQ6vEkJc93vJuzxT1Uj9EUzXGBon+VvDdjIeTwfImAAmkhtHWEOVKoCfh5T60+4SdQdiezmurJxIE72MdMaNznI7LE8BG+UE5fO5SyGVUV39alE/4l8PiYz+pRm8g+xj1c+M5jLPsiGCwqwTLvyyHMbKNYoQoz6CC1I64uoSStikQXlehYu7fBlxIZq2nWF2BNE7Kjrz02AQDsIUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5txOzo5IZ1OZQ2Ua/6gV89+PKqGA1Hr5+ECx9NcrVNo=;
 b=TUO6WK1e+kuiOrMFwHXhgZmMo5qsssz2ilJwVLesCw4NsoJk7ljYAJGGFJl/rKKn+Fj0pkNeLOdByg2Y14gbwtEyzquuRciuVSA8/RViBoUJUEl+wCQfrI+DB2tgj3GuMfvakBvNkbFMjO2zc2sqOgsrZpHPEYr7iHTwro3pLFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 13:51:58 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 13:51:58 +0000
Message-ID: <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
Date: Tue, 25 Jun 2024 19:21:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
To: rafael@kernel.org, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, skhan@linuxfoundation.org,
 li.meng@amd.com, ray.huang@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c02118-5347-494d-c2bf-08dc951dfb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUM2TzBUMHNRQ29DT0dYWW9JNzhEUjU4VVVPR0k4a09WSGJnODMzcmtwUitR?=
 =?utf-8?B?ZUZQTHlpSWVUL2x2OTY3Tmw2OHRSMlhjeDc5M1RwcUMyUHdKcGxsODVaZDhy?=
 =?utf-8?B?dUdHTXEvdVllS09wNWh5TmMxVlg2Sk1ZVXhpdnhwVk9uQWxFN2c3NFhsMHBV?=
 =?utf-8?B?ekYySWt6eThZbWEzY1NleGI5SXA2alhPbE1SVGdnMzNyK2YwUWVsYmlET1ox?=
 =?utf-8?B?d2F0WHpEUFVjMUlEZ1didXAvcFJTVDl3WjFkTG5nYWlLc05PQWpELzlKejNj?=
 =?utf-8?B?QkNtQ041aW9jcmRCVHhheTdSTEErU1VhUjU4cmFBcU5tclMvSVM2TkJEWDdn?=
 =?utf-8?B?clRNV0dxczZWZFdaT2lJbTJJVk5obS96N2t5UnV6My9aL0hnTWdvSlVpUG1y?=
 =?utf-8?B?ckFvRm9ab0luR0ZrelorR1VvRjNScTV5NDhPNHN3YUJ1ZzU3clhtQ0RudWpN?=
 =?utf-8?B?Q1d1V2oweDdyTkZkODhsT3VGWTJMSjlPeWUxUWFiM1lJeTF2Zm5hdUI4a1cw?=
 =?utf-8?B?TFp2aTIrbEFrcHhQTmY3SkROVVRlVkVqNDlwTm1qTEEvSWQ0OC9LbEg1NlI4?=
 =?utf-8?B?bnZQOUVVd2c4U2M4Zk01T2MwUG5qVFBLcUdWWkdXSVVLeXpWbkQxVzR3VFQ0?=
 =?utf-8?B?RnZLRVp5VCs0aWl1TU5vVHZMYWdHektlTGlxMUlWRWdZVTZBTEhJVlJXOVM4?=
 =?utf-8?B?eFZYL3QxUnZUSy9LNGl1dGNsTVJ1ZFVaRUUrbHdTcXR5MkM3TUJJQlJJRUg4?=
 =?utf-8?B?RzE4eXdZNGsxbERBckNKVU5FOXltdUtTYTI1by80bUUrcGgwYlUwTDJZaG1o?=
 =?utf-8?B?anVlTDhadXZwTXkvR2xPSWVHS1B5MjNTQ241RmNtaVU0Z1dFdm1aY091SDlq?=
 =?utf-8?B?Y0luczNYN1k3ZkJad05yWWFOTTAvdkZmSVZ1cnVtS2xYWVcrN1dBZTkrd29a?=
 =?utf-8?B?S1FzN3htNTVmT1N6TVpodUNyNC9RY29jMmxhcFo4UUhXdHdJS2poRXc3TUdZ?=
 =?utf-8?B?eDdra0ZCNk1NTWw2Vzlnb1lJT0gwNzl6d0RkL1VZZEcxR1RyS0RNUGhNVTl0?=
 =?utf-8?B?UEg0VVM5RHhDYmwvZ1d1L1RYWEVSREJvTElEZzd4NkQ4WHZQbHZFaGhtbHJ0?=
 =?utf-8?B?dlY1b0piUVNJNEJmeFViU1I5SVc2S29kN3Zjd3FxcHVQcEVrdWpOYjhjZWpH?=
 =?utf-8?B?dTJrQWNzTnk1cldLcXZLMmp5WXNoL21DTEN0bUZUMi9PRUticWJiMGwreUph?=
 =?utf-8?B?SVNlWUFldEN5alVHM1Voc09VTDZqbnMwWGRuZVlkZlpzeVhLU1VWOFJjZU1H?=
 =?utf-8?B?cWZYa21YTGFyeU0xa0R1S2orM2UwUFRSK2w3a2VDVXNMeS9TdURZSzVjWmdx?=
 =?utf-8?B?dWs2QWpkNEhmQUYxc1ZkRjJzMEd4NEJDWEhpMWdLNGUrb2g3Ylcvcnk3SUov?=
 =?utf-8?B?WWkxODc2M00xUzlvRVVmSkhyblJsN1dXRFJEODFqc3BUNkU5ckt4Y1h1bnpB?=
 =?utf-8?B?YVFINmpObTdqKzI2Q1VsajVYbGhyQ1V3UU1iKzhPOEV0aUVZRVcveDNKeGpP?=
 =?utf-8?B?aWloN3VEWHhRVG9CTGJKb2F5L3QzNS9UaWFqelpJM0VmRmI0NDVFOTdOd2Fv?=
 =?utf-8?B?QnhrYWl5ZzBLS1hRdkdBdXlvU1F5TEczM1d6cDBUT2lWNEU0ZlM3Ny9sZ29V?=
 =?utf-8?B?ZVk4SzBUZXhSVTlJUW81ZHlOVE1JRFg5ZjIrSHVwNy9RTCtMeW5aNXFvNFRC?=
 =?utf-8?Q?/aUE2NkCKjE5AnkTQeYvBUAYelrsQWZ7c0M2nMA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1lraVN3YjZCcWZNeWx5SkNkTDlrSitIdFZDOVlkUWVQd3loT0pKbGM4SVNn?=
 =?utf-8?B?eVVaVlNFaUg5Ni84K1kxOHVBeC9DK2loVE5FdTFkNG5zYWxZM0ZtVnpkN1Ri?=
 =?utf-8?B?TDR3R2YrL21JSngvZUtNUHMxZ29qYm5QcnE0NDVsYXJmZC9XSWovb3c1d1JL?=
 =?utf-8?B?M0RhZ253ejlDc29qS1lEVTZTakEzZXA0S2llQWpwNFdFSUEvUDI5ak1MNnpY?=
 =?utf-8?B?b0kyeU1EbWRScVRBYUYvTmVqNHNsbHNvTlJBLzJvN0ZWajBsekw5d3BkZXdR?=
 =?utf-8?B?N3ozT0N4KzB6eXc4U3k1dDJjK0VFVEp5b3ljckdZSEl6c0VHQW9yUWExeUw4?=
 =?utf-8?B?UlpYVUVCVFppSHQ3V0hOczZsQWlqS3pZTWVQTERKQ2tvYXNhYUlyb0tnZ2J0?=
 =?utf-8?B?M2M5dUdOU2NlL0RhZ0MyYUpLeW1jZWlIMURZKzhxS1ZweGhpUVFaMDRjSGJV?=
 =?utf-8?B?dloyU0ZUcGVOZVkvU05vRmNRVXBwWGFTNzUzeXBjWG1yczdxU2twVUhYZFNO?=
 =?utf-8?B?UFgrVCs0R1FnUlNmWDFRQXo4V0VCaldTQWU0dkdWK2NDN2pyTjlTWXhVdXZ4?=
 =?utf-8?B?ZnhENVZVY2ZrUjdjZGZUTE9mSmhGaGU5TWtjbUVQLyt5eWR3SUxIQ2VnRmF2?=
 =?utf-8?B?L0QxK1ppaFZ0Tm9IMThkK2srQU1obmgzWGxYbk0wS0hJcS9zT25DMzUxMGVN?=
 =?utf-8?B?d3N0dzYvQzF5cUdYUUtQQWIra01jcUFxZWVRUnd0c0VIV2FhSHFjMENrYWpm?=
 =?utf-8?B?TkhnTlYraGFxQndDVGNLM2dQbXFVbFRHaXlmZkVMSzV3V3REN21kTkExL1VK?=
 =?utf-8?B?N3dDblVwK2hMODN1djlIZnVCK0hrVEZWNkVZdDFiY3ZIcDJrMHR6N3VnUEky?=
 =?utf-8?B?ZlJTa25EcW1ralhMVXlMZHRNbHFsSU1kNmltVTUwZmlhUjFtQWF6OTk5bjky?=
 =?utf-8?B?dWVvWWI5d05Leit0YjBKcDBVTHZvb0ViUTJzalNCa0VHNFl6S1JLL2V4QUox?=
 =?utf-8?B?eitndXZSaG9YaXFmWjhyMzFIU2VVS0JycW1FQWliS2R4Ylhodkt2WjdET1J3?=
 =?utf-8?B?YVVDNzVYUjNNYnU5eHpJUTBoZmh2QThuSEUvb2pZOFVlSW4xYk95aDgxUVNT?=
 =?utf-8?B?YlVSRytNT2JSVzNUUXZuYXFGWmJJVDhYUjZ0VnZHelNnK0gyRjA2VFBmOFB1?=
 =?utf-8?B?bWV1NkNRTWxnVkVBbXZxR0NwL1pNOFBsb0p4aXF5aThBSlhWQ2FiVkMwYUdS?=
 =?utf-8?B?V0JKQjFCZjRsNUY0eEF0U3g5SzBaTHhOb1VtS0RzM0hmZTEvTzZzZ2ZVaFlD?=
 =?utf-8?B?Qld6SmxMd2hFZ2YyaVRSZGJUTDNKWngwWFhVTm5GZThQbVM5YWdvWXozMFVB?=
 =?utf-8?B?VkhkNlJQYlBvRW1ScnN5NGQ3UTc3MWZOVjBkZVg2TVgyNURIK1hNOC9DL3ZV?=
 =?utf-8?B?VU8zRkpHRnJJMXJGWlM2WXczbHAzSmJnSUd0aENWbUhSeWx2R2FPa1d2OFJB?=
 =?utf-8?B?cDExTWJ5UDJyd0k0QTYvRkdJY2NQQnErdVYxYVdET2dzY3FFZlVBOTZCd29s?=
 =?utf-8?B?cXZoZU9rS1M0Tjh5NUI3R1NZZkZkSE5QZzI4OVRwQmdpd2p2SThWT1lVRGND?=
 =?utf-8?B?MjByRFBNTlpjdVh1YmpqRnhjSTgyTWw2Y3AwVzE3amtmSkV3MWtWUFgwbEN3?=
 =?utf-8?B?enUyU1RSanpVUXg3Z0NxR3FrVVpINXdLalBtNnJIZVgwcVZtS29GTWoxbzZR?=
 =?utf-8?B?Tlh4QVFYdG51WXVTRUI0QXZrTGgzU1hJM2FPMXM1WjQxS0c1MEpXd3pMUisw?=
 =?utf-8?B?YVNxaERpL0hYY0x4VFQ3K2lzTjU5d0VGVXVNTkl3a0NLWVZqaXVLM0FOVFhz?=
 =?utf-8?B?WFAzOEE1QWNwUTBLbWZ2anpQSitkZm5oL3RUaXEweGF0dTVDdGVXbzlWQUlv?=
 =?utf-8?B?ZUNLV0xlM3c5ZEVoNXFsMHF5ZC95QnVVRXVxL2xyNGJBVmV0VVZNNVZwK2Zn?=
 =?utf-8?B?OVF0SFpOdEh5eS9ybkt3Y05iMFRLVzFQU2dIR3g5RUNkanpBVWFhb1ErMzVD?=
 =?utf-8?B?QTRaMnl2QlUva2N0OU5maE1uK0dTU00yTVNCaVhjclFFWU5SVU5NN0xweGZx?=
 =?utf-8?Q?FFXEqlpc2yHSRP2YCYQMDLjXC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c02118-5347-494d-c2bf-08dc951dfb4e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:51:58.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxvc9z75mEvUXHKwecbKtbKIiNKW4Amq4XG657rotlCpw2mdVxQW63LzGB2fOWaeurYVQaAVsFYEIEkPwnfYBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

Minor modification, the commit subject is supposed to be 
"cpufreq/amd-pstate-ut: Handle the inconsistency between nominal_freq and other *_freq units"

The second half disappeared due to the word wrapping I guess.

Regards,
Dhananjay

On 6/25/2024 7:11 PM, Dhananjay Ugwekar wrote:
> cpudata->nominal_freq being in MHz whereas other frequencies being in
> KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
> 
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index fc275d41d51e..66b73c308ce6 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -202,6 +202,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> +	u32 nominal_freq_khz;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -209,13 +210,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> -			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +		nominal_freq_khz = cpudata->nominal_freq*1000;
> +		if (!((cpudata->max_freq >= nominal_freq_khz) &&
> +			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>  			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>  			(cpudata->min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
>  				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>  			goto skip_test;
>  		}
> @@ -229,13 +231,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (cpudata->boost_supported) {
>  			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == cpudata->nominal_freq))
> +					(policy->max == nominal_freq_khz))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, cpudata->max_freq,
> -					cpudata->nominal_freq);
> +					nominal_freq_khz);
>  				goto skip_test;
>  			}
>  		} else {

