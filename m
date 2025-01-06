Return-Path: <linux-pm+bounces-19976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B8A01E9D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 05:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81BE1882AC1
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 04:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C869416DEDF;
	Mon,  6 Jan 2025 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+51VPJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07C4A04;
	Mon,  6 Jan 2025 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138633; cv=fail; b=Bq+w4BoLIQTRdhtH5pB7BYBo8e8rUeyq00f2KvsG9Mbi5+bYX8FUwwBhGF/zn4oX+kJndgMb/rzFNioEz8x6nqG0IoOyXtiPupqxRte824hVVlM8kOHJl1AMBo7rMQ9EdMS3ZGT8I6QXLdewxRQOVMx4wz6qhJgIlYx7usn50Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138633; c=relaxed/simple;
	bh=Owu1dn+gE/2idXBv+qptTHvGpXGLV+olxnTLwKQmGKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRBq9zNneoC0e8AiOGjOXEyj1t1M89NS3JkPaeJzPjWPq3f8qsqzxWtt+0KV2Eizj4qiw92rdjgwcN31+vdHfl/EBtaD3tL/HgssnwoMcJCbuy8UQ6n4vfyHi5qjSfWz32/wQ109oqu1dU/yOzTt1d2YdMNJ1PSatqeVyTI0mac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+51VPJH; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vortac97lGEECDVdvY+WaZaEnA5YSddYgsPVEmV7x8EeYA5S2h0yDVYqDf+ie1l//C4ujHMiUdV+Jeyb6jum+gW4rAThHqpIlDeindpuvR81TkDbU1p6uCVzEwNA3b0QJ8tXMO+3fYYsTfL4mGKN7VOLxmvG9DayB91AfNrcXBwmqImbaeNb0jNmJHqYt/bz40Aogm5C1Rck6rsHTbOmI7654RdyjF/q7iXq7l9DYpTm/pIj+RXwJlOsXUVjZ2Bm1QNUisb2xDwCJICYdSIDwSNJ0Vv+ZLBoZ1+IrGRDelsNysExNKA6nEVcxTzHpWJ4+QiRkJoo0n9UwEtIYejuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdewWIiWet4n4DOV/isHxxVy87YSVe6Kgy9/vKpXzvI=;
 b=xoYuoxRB6hC+0sG2kekdS/ZVolQoJLBppXJYlOgv2SiBOPjVs9xTC0KND8XCl+NOvoyZGtkwtjN3h3DBV0JNDWwsop6gZ2aW+RrFvHH5Ytg9p+2azf7jd9wVHV/Il2hglFoN9/y4pTSR29fodvP+3i8+a4fAbY3IAneyK+sByGy+UdNeZf2UADoT+xdzZxQKjHWf5yDsu+iGuzfattWdMunmWXmGsZ2Om+hzsxvotnW8c4jB/EB3tk59W3hajOJklwtmIZ/VPl2ewVDiAKPB0IEImQYVAYsqvgzjqDf7wFK8xetCoWOYEh3VvO9uPEGpSQ+l0/IbZQwJz8fHOStgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdewWIiWet4n4DOV/isHxxVy87YSVe6Kgy9/vKpXzvI=;
 b=Z+51VPJHbUn5ORYlzXhyvkriL2Uo5kOOliom3eLts0ETb1CTwa+uuRovl5Wn3RNKZkzGcfjngbE1BY/hJNSNHJWK1OzQOdC9CBFOfmDtawrIFKzFbbBe3DtMXr8c5rzAi0+T0S4GFmoR5QP9kMCHePvlPwLOuieswL8eXX2ilHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 04:43:45 +0000
Received: from SA3PR12MB9198.namprd12.prod.outlook.com
 ([fe80::bb2c:e2b3:89d1:9f99]) by SA3PR12MB9198.namprd12.prod.outlook.com
 ([fe80::bb2c:e2b3:89d1:9f99%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 04:43:39 +0000
Message-ID: <d7290507-bdb2-4bda-a33b-0a9459b9533b@amd.com>
Date: Mon, 6 Jan 2025 10:13:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cpufreq/amd-pstate: Set initial min_freq to
 lowest_nonlinear_freq
To: Russell Haley <yumpusamongus@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
 <d89bfc1b-37cb-4d8b-b944-8dc385915bcf@gmail.com>
 <62f0402c-89a4-4ca8-b443-fbc9cc3b2055@amd.com>
 <1bb556a4-6b9b-42ae-98d2-15c8986cb88d@gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <1bb556a4-6b9b-42ae-98d2-15c8986cb88d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To SA3PR12MB9198.namprd12.prod.outlook.com
 (2603:10b6:806:39f::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB9198:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d7432b-6169-4426-62ab-08dd2e0cb0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFpQeEJJMTI4bmR4T2ZrZXJpK2hWNHlkempDd29Kaklkbmx1TlVqQS9sK0xr?=
 =?utf-8?B?Mm1zczYwNk1lbzl3NW1UQy9FUkx0azIwaUtSNDMzc1k0VjgvcHlWTDNHcXNz?=
 =?utf-8?B?a1Y4Sm1DR0hjSFMwU0ZicVVsMENlSHZaWXBjcURZenl4ZDlnWloySTJMT1o1?=
 =?utf-8?B?VlZVU28rM0pkWnMreFdyb0dkV1pVbXZCdTJ4NlBRY0k5d3JzdG1aRklVZDFK?=
 =?utf-8?B?N3h4OGFjemFQNE9aUGttREo0aUh4UXpTaDNnUmxsRDA4UlcwbVhYbEpXaDBo?=
 =?utf-8?B?d0U0S3ZYZE9Ybk9TTHdaUXByZUpUdUFSVlJ5Umd6S2t0N0NCZmxVVkkwb0NU?=
 =?utf-8?B?NHFvR09WZHZmaTRwc2pGZVM3Uk5PWWx2YjRCa3kvWkVpWU5qa2xBTGI1ZzVj?=
 =?utf-8?B?SE9TdEZwR1JjZDhFbFE1cURVVExORmpUN29iZ2xobE9QZkpGOGsyc3cxTUZm?=
 =?utf-8?B?enNuTGFBcCt2YlgvUGZzVnVTOUdtRUtiOTc0bzlkTVNxT2lXK2VxU1gzU1d2?=
 =?utf-8?B?SktaMkc2b2lkUzNxOUVVV2RNeUZ1UFExa3RocmlYZEFMVGthSkdsTHQyZ1Fo?=
 =?utf-8?B?U1NKZHZjWit5Rk1YUGdURWprcXdhemoyQTVSbWhwSVlTN0JnWnpydDEzRkcz?=
 =?utf-8?B?K0dkdnQ4TzBRbkFaM05IV29HNWVjSkNld29DZkRRZmx2aHI1UStZNi9wMjVa?=
 =?utf-8?B?WElubkpJMVRRSDJiT3JJTlNUZDZ0d2RyckJIRVdoWkhyQkF6ZTZaaGtwSXZm?=
 =?utf-8?B?UkFaTldOSktmTmpMNUpRb0VGSXUwRVNya0kycUxvODB5R255cVYzcThXMW51?=
 =?utf-8?B?QzFsZDFHdEttMkNOR2craVh3alhUcXFMeWFQb0ZNaXRyanhWTUxoditsdkV5?=
 =?utf-8?B?OUc5WEpUdlNUYVFRbDB6N3F4TUhaKzQzNUthQ1hOVmlmNFBSdzhGZk1obk1U?=
 =?utf-8?B?NWZjZ0JhU3FoLzNwTXpEdmJWczlsUzF1NEF2Sll4cFkzWVRnVTBxajJkTFZv?=
 =?utf-8?B?L0lnYUdjNmxEcDlMVFNsMFhPaGpqemVjRXVlMlM2Q2t6WlJVbUl6UDV1aUtk?=
 =?utf-8?B?YWloVUdzZGdPOFF4dHJxc0lNVG5MUStzYm54MVhDRFRiRERvNW1GMlRYQml0?=
 =?utf-8?B?RitmTysrMytsSHhLWk9lOFpUemkzV25tTUxVakZUQS9mNVJ2SjRPSUk0TE5y?=
 =?utf-8?B?U2RacDZFVW1mU2Yxb0tjTDlnVVNxR3VLRGM0dzhLWDBRVjBrTGdoQW9lSDcr?=
 =?utf-8?B?UUdROENhU0cwU0xIaDlCS3JQL3dtcGI1czFTRVFlSTJrdEJTWDA4aEhjTUhP?=
 =?utf-8?B?bHpKaERMTStXbEpCbEhGclM0VG1GNUF6YUpvYXFwRFVzdXQzV0VjWW5hU3pn?=
 =?utf-8?B?OE5PYVc3cFRNcm8vKzBPYkd0YTdkRkFjVE1tUk9QbTB1OHBSZk5ESWVRVk9P?=
 =?utf-8?B?WVNHT051RENyWThlV2t6UXE5TTQ4ZUpNKy96ZElkbXUzU0lmbFl1RS9Zb2o0?=
 =?utf-8?B?Uk5meSsyTm9oQTVyQlRYcEhWWTFyUGRhT3pXaW1GbDA3RTdwY3ViSmxLSUJR?=
 =?utf-8?B?ZWxJMVd0WEtOOURsZnc5K1k4NXNkNWIxN2JIVXF6YXJLUFZEZlpobjlyU1RB?=
 =?utf-8?B?dlJabEUweGlPYnFmanJ3WEVxSXl4N0VnUnJXeklseVRRUFNrMDlTRkRvR0Qx?=
 =?utf-8?B?RjZ3UXRPZWoxSXlOVEtmQ2xISG41MHNsMkgxYjRhOFVVRmhxS3NUMTZES3JV?=
 =?utf-8?B?aHBCR0wwNldVaFJxWVlqR0lCM1FGcGVDSUF3OWM1NWFsVTNIVDJQMmQrTXZo?=
 =?utf-8?B?SExIbGtwS0N5V2RZY0JKeTlYeThZVk9rRW05SUZIN0dTeWpSTGh4VEIxNm51?=
 =?utf-8?Q?I1Tu0cT5urIdo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB9198.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25STmJqa0llUVFvNmt3QXkyVE81UVNsYzVJbVBxTWtuNDg1NmRFWEFESHNJ?=
 =?utf-8?B?NU41Z3R4bWlJamJrMUNTcWovWWwzektmZE1nYXlHL3hGZk15RkliVDVnUi9H?=
 =?utf-8?B?RUVGeFBJWE95M2djSkRsZnFzaHN5VlRJNWg4U1BtLzJpL1VaZE1TR1MxYUUw?=
 =?utf-8?B?aC8yZlBsVlp0WXIxU3VmYnNrVUptV3M3MC91MUNxM0IrYjY1QklLVmxoVUlJ?=
 =?utf-8?B?aTFqRFZTUVBpQkh2c0NsMnhXbFIrdjIxUzFEczZCeS8zSnVZVXlkUklNbk1X?=
 =?utf-8?B?K2N1UXJ2N2xNZWRQTXduYlpwZ3VZYU5McXFrbDc0T2xYYVI1SmV6d0F2Umda?=
 =?utf-8?B?KzBHWmlvZW16NHZVWTltRUI5ejlLMmJnY1M2SDdBT25URnh0T0NwdjNWYmFY?=
 =?utf-8?B?bTI5eHdyNzl3Uk1uK3hkd1pXZGF4OTBzZWlSUHY0QndsS3Y3Z01mMW9RWUdT?=
 =?utf-8?B?U3BYcjFhMnNiby82N0prdTFsYUtGL2JqdkNDNC85UnNPc0FWRmR3b1hBeDd0?=
 =?utf-8?B?eXh3cXNKY0ZUeEVwSE83NUhDM3QrTzg5N3lxd3dDYVRYUzNENmhBanFrS1hC?=
 =?utf-8?B?Mk84QlhKR2V4VCtOTENRVUV5dHFBZHlkR0p0cVZzQm1WZlhZV2NEdWt5K3dS?=
 =?utf-8?B?WFJQVTNiV2FqRjJyc2ZjN0FONVMzZGFYWUlXU0FmMFRRbXhLWlE5UzU3U3pK?=
 =?utf-8?B?ZjRRSkxHQmhRUk1UdXdzZnFVUjcrSlQ0NHhPRFhMTGxRcktteCszZ3pHMkxx?=
 =?utf-8?B?aktLaGZjaFQ1MEt3WWVzSXFKZzVHMnYxK3dmTlI5bElybmVCMUp6NlhKV2h4?=
 =?utf-8?B?RGErd0hTa3VpSzRGYjUzVFlxNmF0Y2VEeUZ4UDJoRFR5czhmQ2twd2VKQ256?=
 =?utf-8?B?czFjelFDbXNqajNobFc0dWdhTUZ1RDJnVkN2a2N5Q05XQVNjNnZpYS81bGov?=
 =?utf-8?B?NmhBY1ZDbi95TStDR213QXNhNDdiYS9TNWtLTWo1UnNNOHh6dkxxUEJTekY1?=
 =?utf-8?B?U0p2TVhSZmoySEN5ZEhPOFY3VmN0N01JRTVJRjcwOGpCazMrMHZkUm9CVVNu?=
 =?utf-8?B?bUlEZzkrVjU2eVJhTUdaUTg2T1J6WFZBb1RONVBBZ2NLZjhQY0hqNjBaOXZv?=
 =?utf-8?B?NlBvb0lTMXN1Z25aYkZ6OCtuWkcycUoveVhBWkhnekgvMzhjbTBCSEVEVkRE?=
 =?utf-8?B?TUIxUG5rVTJCemFDN1ZGSlNaNlMxSjhGVCtpMEdjQVp0bVY5NzlKMFpVMUpS?=
 =?utf-8?B?TExSazMzaUVISU9DNmNmM1dhbUFCZHZJMDY3V3NOOVVyVDQvTUdSNDNJUjZE?=
 =?utf-8?B?dWF4TUVlaitCd1ZEd3VwLy9TRUVMUXhCZWk1aUJ3WThOQzhBenpTak5wYkZ2?=
 =?utf-8?B?Q0Rpb3ZJK3RJeTF5KzFzYmQ3WjRNeVhLNDVPZGJxak1JZmM2TXFrR3Q1MlNO?=
 =?utf-8?B?eDVsbVFOS2N6RDlpMXFFTExjdk5PSmJvZUcwbDFyYVg5Rk1hUVdRL1NqNTZ5?=
 =?utf-8?B?aHNvdERuekNjTkV5UnoxOTd1Szk3citONHBvVGJ2NG1SUHVDcDgyMUJtWEJo?=
 =?utf-8?B?NnlRSWdGSXVrdUc5empBbUFMS2JUYlpKUWJkWWhkWGdzL09PMXBGNUViOG1r?=
 =?utf-8?B?clMvZEtoZ2JwVmxSU0RSWkJiSzNzMU81bEtVTVM1MHc1b1ozbUNoV2pQSGdF?=
 =?utf-8?B?WC9YeXJJS1FyYklBWmdOWCtET3oyLzV5TXQzVkxQTldmYlZYUHZDeFcxYkk3?=
 =?utf-8?B?NmI3aTJpbEtqVjdIeTRjZHBvRFdhVWZLUjk0ZXlDM2pqaGZDVFZlYzNhamNw?=
 =?utf-8?B?c0pJTVVRMEZ6dkw3LzJIREhQZ1FzdGxTcU1CcFhkbHU1NG4xUlo2ekxHc0tT?=
 =?utf-8?B?alBQcndBLytUS0VlZk9DYktveTB2NVZOMExnMDQ3YjRPNi8yazZqVDNCd3Zl?=
 =?utf-8?B?c1EyV1R1MzhDNnM1Yzc4cHRrL1g2bG1qWUpqY1o2ZCtRbnhRbzh6V3dSMkR0?=
 =?utf-8?B?d3V0VU1OT0JNQUhYOXRLT3p6S3dzV0prU29RYmFwVzRTdlBUSFR0T2RnTHpZ?=
 =?utf-8?B?WWw0VzUxZVR5K3hWeHN6UUFpSzNXQ1FocTgxSy9aLytlY2tSTG8vRFJnZU9E?=
 =?utf-8?Q?Ds/tbYXm5MSzj06ikM6GdN0WK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d7432b-6169-4426-62ab-08dd2e0cb0c9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB9198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 04:43:39.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/oLVoUyKLljRqA2moMCjQGbn776a3x3/0AsYrKDSfjhQQfdtrCuIGALSh2BHHi2yw6ALqdfyfWYi2DVuaTEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

On 1/5/2025 9:07 AM, Russell Haley wrote:
> 
> 
> On 12/8/24 10:35 AM, Mario Limonciello wrote:
>> On 12/8/2024 01:54, Hanabishi wrote:
>>> Hello. Maybe I'm too late on this, but I have some concerns.
>>>
>>> On 10/17/24 05:39, Dhananjay Ugwekar wrote:
>>>> In other systems, power consumption has increased but so has the
>>>> throughput/watt.
>>>
>>> I just want to bring up the fact that this change affects all
>>> governors. It sounds good for the performance governor, but not so
>>> much for the powersave governor.
>>>
>>> So the question is: don't we want the lowest power consumption
>>> possible in the powersave mode? Even if it means decreased efficiency.
>>> Powersave by definition supposed to make battery last as long as
>>> possible no matter what, isn't it?
>>>
>>
>> No, the powersave governor isn't a one stop shop to bring everything to
>> longest battery.
>>
>> By your argument we should set the EPP to "power" by default and "boost"
>> to off by default when the powersave governor is enacted?
>>
>> All of those are far too aggressive for a default behavior.  Setting the
>> lowest nonlinear frequency as the default lowest scaling frequency is
>> about having a good default that balances responsiveness, battery life
>> and performance.
>>
>> Like all knobs anyone that doesn't agree with it can of course modify it
>> from sysfs.
>>
> 
> If the documentation is correct, the lowest_nonlinear_frequency *does*
> result in the lowest battery consumption unless you are running one or
> more threads at 100% utilization until the battery dies. In that case,
> lowest nonlinear frequency should result in greatest number of
> instructions retired when the battery dies. I say instructions retired
> rather than work completed, because "100% until the battery dies" is
> only stress tests, malware, and damn-the-torpedos concurrency frameworks
> that use spinwaits.
> 
> If that is not true, then either the documentation is wrong, or the
> CPU's reporting of its lowest nonlinear frequency is wrong.
> 
> I am puzzled why the CPU even exposes frequencies below
> lowest-nonlinear. They should always be worse than PWM-ing between C0 at
> lowest nonlinear freq and some deeper C-state. 

I dont think we can assume that idling at lowest frequency would *always* be 
worse than going to the shallowest C-state (considering the c-state entry-exit 
latency), in terms of power, performance or tail latencies. This might vary 
between different systems and scenarios. 

Testing software that has
> to run on much slower CPUs, I guess?


