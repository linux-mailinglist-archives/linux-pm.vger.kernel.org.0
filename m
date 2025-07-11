Return-Path: <linux-pm+bounces-30678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B27B01A65
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F8E8E19BF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B4227EFF5;
	Fri, 11 Jul 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P3vLaWPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2C288C0D;
	Fri, 11 Jul 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232526; cv=fail; b=eu75gyXAQ00r/h3xlO/65BaM4mMsh2VFwQ1FVTT8OIHvOs6gG5JnkvGU1OkEEZWBqwHlweVbWJ44qQ6ACXMUmNLFXzqLu8Z3jy84Wb4CTOS9SNRgq4MpgkX0ucR30nWIy8vm0wgVUEv/zG++8mBU6XazFNnqUG6vyXRGtYvSAtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232526; c=relaxed/simple;
	bh=v0xZ/8JvPGKRV61Vtjv5PHrE9PGbbRcj79qUEa+ZbwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccMH60PCJU9kxVBxDuq8hWc2bQouxKH+eqMpqwo1x9fE5BtlsF3j71ZHBVU5URNhvxqRj8nfKxhTZ/HV3C0OAxgs3Nbn4Jx4QgKw/Z9O5QyU6uYy/bBFukGcIoYRytuAdKEaWlWBGtR1CQotuh1GrGkgT9ryO1jGsJ41cf4cXYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P3vLaWPi; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9CrZrQO0J+xMoGB9t5nz7TTBRl3lyelrTcK+FpoiZ4e2JFPj8wXF6F6KXv200VzpPlyljdUc2MSElgR2ZDgT1Rk4r82mV4JwPSwP0GGK69iiLTHeVJihDs6avYh74FNFbhyoiyL1HJU0LFeiwfwLAj8hhfJpxcfz4SPaMjGWvAwurPU95xXIYXHfwsqKtuMoA+2k2fo38oVkzOvLalMzIriAJz4PHmV8rJSrERDj4jRKj0BQ5fRk1ApPW35kdn6YfKzhmm4jP6/XH5hvYG3rVlfE+P7sAeCOCcGDtJV2vHNBjAldzNMix37Vr8XaRKjZbAn5ZC05bsy5Qtlcb0QUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAmH4/FUxfDsJR3V4/wR2mXrcAALdrnoSlyI5It13Eo=;
 b=wd3Y27yoH4ULaTq+TQBu93HQT1OCl/38gD2RBPSxQ6BsDq2h2YzPO7TniM5goTQ0J2QEqg/+ilEDX3aFz0mqy4BCD/Oo/V6/TWaofZhzBajy55jrYXQ6JEQkgSD034945S5gaFLnweqHp/j38ScrKO6MemLUISy4dlcGNHUXwPuwn280cybd9slJrV065yHGdhYSVvRtHAtuxsTc0q0CpL7jrC/PIJjlLMbsc4YdrKLtmxeGBt8obGXyQ2asKHhPaeUJUqc34bzOI5za9t41Ppp5g1jFUmH9VFPD+Cm2K8JLioFMiOTRD4Qp/YQUlzIUqH+x9jOWhTjysvY24T9JbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAmH4/FUxfDsJR3V4/wR2mXrcAALdrnoSlyI5It13Eo=;
 b=P3vLaWPiZRSZGMd9b94orPIlrsLg+poo4byuojvOTlfl013rcgk49/sbvddDWwFfM1KOY3Px7CdVBPi/V/RoMPlmZP3JwFDG7H2C0PToknyyBRpRUCL+m1JZhhnFtgtwVTqPr1Nl16FPt0Cfah+u5XhErJbMnAWC28ZtRtJN+tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:15:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:15:22 +0000
Message-ID: <c5f7f536-1eb8-4a6c-859f-313a8f000ef3@amd.com>
Date: Fri, 11 Jul 2025 07:15:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] kexec_core: Fix and cleanup for the KEXEC_JUMP
 flow
To: "Rafael J. Wysocki" <rafael@kernel.org>, kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <5046396.31r3eYUQgx@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5046396.31r3eYUQgx@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 0270ff6c-04a5-41f6-14bf-08ddc06c39f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkh5OVVkS0UwUkNyWVEwY29QTEN0UnNjRXZYNWZzZkVmd2t3S1luZ1JiT2Fn?=
 =?utf-8?B?QVVUQkJ5elFCcW5ST1R3QUZhaGZDa21DeXNOdWhaS01TeVRBSC9iUTZkNWxu?=
 =?utf-8?B?bGdodDJSR3UvYWNaWEc4ZDcwTERVOWdvTzV0emk1bVBQQmwwRVVWTnZBc2U4?=
 =?utf-8?B?UmVqcWl1Q2tqTUJFWm1HZGpjdi8xVmhTZWpVK3JmZWpML2FsMFVVN0dWNUQ5?=
 =?utf-8?B?UHJObmJPWEVZQjFWY2VNbnErT2EzUnphdmk2TWNwWEduVXdTeDBSZjBRa0hD?=
 =?utf-8?B?eWpianh1Q2NsaDdSTHk4N2FPTnZMaGJMcWEwbWl1ZStDNEdRdGtrVnpJVFgx?=
 =?utf-8?B?SWNQSnFFWlJhYStYdTRiWHlnSnFOUEpDbUg4dkR0cU1ISU4xUldpcUlRMW1W?=
 =?utf-8?B?T0EwM2NuSkVmNGZUS2V3MUx5Y2RTREl0T1Y2QUlGN2pLT2NwVXQ1VXlhanJ5?=
 =?utf-8?B?WFJjTE0vZVdJeTNUeWdCc0ZOUnpBUEFkblBQck00MS9rcFQzWno2U0ZqNlBq?=
 =?utf-8?B?ZWdTU2hlOGdNTGpadzh3bDNuVkp6UTNhVFpKMjVDOXhaQVRsdTlBV1JXU2Vo?=
 =?utf-8?B?VnF3THZmdEZxQ3NXaDZyemdxdVluYVBKcUROTzYzZE52ajVqNndZL2ZORW00?=
 =?utf-8?B?U3E3Rk4rc3dyM1Y0OWxYZUlSektRbEt0ZGRmMjVUMkFTL3AybWZ6U0QvdTdt?=
 =?utf-8?B?VVduZ1hUMmFRZU5ZRGNqTm56WSt3WTRFaXlwQXk3WTgzTDRQa09ScTdpM0Vu?=
 =?utf-8?B?ZHR1cFBtZzY4aUNYSEFicUJvNUVmcDhpNGtreCsybVJ2WTl3bVprdjdtTFEz?=
 =?utf-8?B?VE9hVGlEazJSWW1Cb20rUVB5SS9scjZoQUFKZFJadnZDUklOYkxPekEzNDRl?=
 =?utf-8?B?a1NEL3FyUVBNT240MER6RGcyVEN6Z3FWSWRxRWtuYmJOZkN3L3BUQ0M1Mkpu?=
 =?utf-8?B?V0g3Yy9jSDVRZTdvMjlkMDh1NEl4c0hDODBDam1EdUNoVlZkSU4yUGRhTXla?=
 =?utf-8?B?cE1IS0szdkhxekdZQ3VDMzUzMis0cVBXcGQ3MXArenBuYXgxMTRIc05SSHFV?=
 =?utf-8?B?a29sbVhlbk5mSmdMZzFwWVlLMEFRZlBKM2pRSktvYVB1TnIwbkc4c1ZIMzdv?=
 =?utf-8?B?ZVJOYUxwSU8ySGgxQ0pQZUdMQUx3RFhjUWRVck9sdnRnT3dsWS83bUtxZENB?=
 =?utf-8?B?TEpGZDVwbzZXV3FJV2ZqbklUcXlsSzZxbHBobUVLQ2hwKzIxL2J0NmZJY0N3?=
 =?utf-8?B?bmJRM0w1SVlOTXZhVFNFQTY2YXdZRW9jb3hpMnhlUGVGZ0lQc04zWVRRTDNp?=
 =?utf-8?B?bU9YTmdudzMzQXBvQU0xZG55emdNZ2E2WmdnSHhnbUJTU1BXc1JONjVrTWQ5?=
 =?utf-8?B?TkJ6REtjVjh3cEVIaStQMUZ0SDgxZkJEYXlSV3NTTlN2NDBaKys1c3hMZDY5?=
 =?utf-8?B?S2pucVF4ekVlZktKeFliOXU5aHhFQmVPUGZEOUhEYlIwRllLMmZTM0FYU0VD?=
 =?utf-8?B?YmJiWFNtYWc3RDFNNGtzK0dhL2ZzN08zbFFyOGd4VnFvRDlDd082d0E2Vksv?=
 =?utf-8?B?bkVLbnV4YmVUOUkwMy8vZmdjZ3VUYzRvRkFEMEhielJvSWpnTEcrZGJneXVM?=
 =?utf-8?B?L1RoelJjZ3YvSDlSQkdHdHpkNVVKcmpsU1ExSzJWbEQ3NWtOYzc2Z3dtdlQ1?=
 =?utf-8?B?RGprdnZsY2p1ZWZnMXRFdDRJbTVtODE4Wnc4SFdUYzY0NVBQQjFKcHdtTUsy?=
 =?utf-8?B?YVJaU2drMk41UjZnK2s5d3NFR203WHZLSkJTTVhYbW1qcHE1bU1wNk1YVDJS?=
 =?utf-8?B?Mmg0S3ZHZEZtS1MxWEk1WVNhbUlHbU9HQWVyS0ZWdU0vdENOcjlmRThSZ1Jl?=
 =?utf-8?B?T0FibnBvZExGa1NFMHk3T1IyS25HQklDdkJ4ZWxzcWt6UStpdDNlWWowZ3RC?=
 =?utf-8?Q?GxSCQzq576k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2FzY0w2WWI3bVN0anVTbmZMalBlZjk5bTJvRDFpK09xVE5PRkF2dThTSnBj?=
 =?utf-8?B?SmhWMDU4cWhid0JmcUdpS2hXT0hydSt5NFdvdWp6WGdKd1I3VTZURXQ5UElq?=
 =?utf-8?B?em9Gc3NEZm1HRTdlSVc5aVA0NXA4REg1ZVBiSi9ES2psZDBDNEw0UzZEK0Q2?=
 =?utf-8?B?NWJ3Tk0wdExGRXA4YWVERFNJZTFkNGVkZEJtajRTSGhEN0VIekQ5MUdOYlBM?=
 =?utf-8?B?eVR1Ym14WGdaZmNBZjVMbzBqTHRoMXNRVURNK3dQUittRzFCd1FNU1NJS3JR?=
 =?utf-8?B?blpSV09zK0NiT24yVDFPMGdrczVOZE93WFVYbEtUVnhiaG9SQ2c3NGtrTjhS?=
 =?utf-8?B?OTJKc3Z3MXN4RGN6OEpOYm1iZmxlczMvVEFGYVF2ZjE4NlFvSXhHZlRJaFFD?=
 =?utf-8?B?SmovZmlNd0xtb1AvVlRIYmpPRkR2Y2JUQTY2Z0xPbWUza1VxVmwrTGNFa2xL?=
 =?utf-8?B?V0JpeU82aDEyUHJqbVVBRXhVV0dpdnJYNFRpZ3NLWk5WcXdoV2RtRS8xckU3?=
 =?utf-8?B?dXZjR0o4YkE2djBmcGE2c0psZ25JRkdIU1hvb1k2b29QRjBQc1dlbzBrd3k1?=
 =?utf-8?B?cTlxSzRZVG5IYkNCSG5UanJzU0k4cGhiSHBlZWtmU1pwWENCUWFJeUZwSCtX?=
 =?utf-8?B?UUNKVkptM01rNW9KZ2ZSMmwxaUYxL2dwNkZucWlXbElRT2hJZVo1bFJad3o1?=
 =?utf-8?B?bWY1U0FGKzhqS0RHSytaRTJWNTJRWGdFZTVVVnVXdW8rSmcvZjU3b3Vqay9S?=
 =?utf-8?B?b2daVi9oMjZkM0Fxek5VdmdxQXFpUHM5eEUrZXFUNXQraC8xWVYwdldveHNj?=
 =?utf-8?B?UHVHSlRKbUtUOG82SWNYYkJDczFJZWxYeDlCekhqZ3hwYVQvM3NXa0pXa1RF?=
 =?utf-8?B?Wkx1MG40S0U1cHQvT3pEUzc3bTMvbmpaemxtY0Q4UzdHV2NrZldDQjBwTHZo?=
 =?utf-8?B?UEZWZ3liS2tBV1lxY0NzQ2thNm1ZMjVtbHRwV1M2TzJUQ3Y4TVpqZjNqLzV6?=
 =?utf-8?B?cW4zM1J3WklSTVNzaExka0c4dWplRDNJUjNHYmZ2U3JIYVRuNDNaUyt5dzZv?=
 =?utf-8?B?azg0dGdralhaOVI5SExGcytmRUdCN0ZkV3hGa1VpQTUzckdOMlRlbmcwdVUx?=
 =?utf-8?B?cGRwaVhWc2xLMWpmMzZNZnUveHkrNDl2bzZkeHR0eUljWlRVb2ttemdQRTBy?=
 =?utf-8?B?UWtIc24vMXRXYnZYT3RxdVBvN0ZweGVFL04vMk9QVjJ4OEF4Q0tEcnZXOXhV?=
 =?utf-8?B?Z2hXeG1RZGJpOU5EZWZqRk82QWhiM3FSZWV0dEFCZ1g2Skp6TFN6NkU5V3hX?=
 =?utf-8?B?ajBMSlhaeENtRG1OcEcwckI3b1FUcHBtdm5lR01OdWNGbVFpMlRIZ0lNczBX?=
 =?utf-8?B?L1B6ZlpkZXpiQzN0RDl3V1ZyeDNqdDRpMDZnQnpxS1ZXV2QyMUd1dlJod3dv?=
 =?utf-8?B?UWsySEszMVZGZUdxY0RGVXVuZHlMTG0waFlWdlZ1YzdUYW1nTFJDbGh0UHMx?=
 =?utf-8?B?bWhrVzhJNmxwOFR2czdPUlNPQkphTXdxdjRNSjRCdy8vckk5dHZML2NkcTdC?=
 =?utf-8?B?eTBJS3RON1pJME5JUk51SVFDcVBkcEV5RlhlZkF6b0ZMSG41Z3ozTFZvUE81?=
 =?utf-8?B?T1BUenVlU3B2NitKZ283cHlHSmFSMFJUSVR6ZTRmUFljQjBxTGZzSElCKzEr?=
 =?utf-8?B?a2pLaHUyRWthQ2w0VGVWOG5aMUZwclExZ1lDSkZxNWpxYXFUaXpHN2dVM0c2?=
 =?utf-8?B?U2VoTnE1ZnN3WGtCZWp2eldhZjQvZzZaRlg3NGo3T2dlblVDS2pPQld0c2tw?=
 =?utf-8?B?MFdBaWJJZnMyeWxidlhnSGUvK0xmcHNXd09jeTY3L21TUEpUazUvUlM5OFFZ?=
 =?utf-8?B?ZHo1cWduYlU0QW1SRzU5WUVsL0xlVm4vZ2RPNjdqb21zWllBVzliVWp5TEV0?=
 =?utf-8?B?NncwOW9qcWVNS1RoZGQzakxWeHVVbXMxZkJrU01YM3J2SE1ZUEZycjQ4dHBG?=
 =?utf-8?B?WkZtQ0tpK0UvYVRrREtOblBZejVBamg0NFBQZ1YxTmZVNW5OQittZ2tBVXVG?=
 =?utf-8?B?a1pHL3BYUnBKc1lRa0ZGUXRBODMrYUw3eVZ2SENYTnIzUFE5U0g2WjJWWEo5?=
 =?utf-8?Q?05TUeJtRKxIUSYcpBHtS+NQX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0270ff6c-04a5-41f6-14bf-08ddc06c39f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:15:21.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcjQOZLc/luV6W7f+xFsqwZt7owpTKGWeZ+qpdfdxUGLe5B2v56i3X98vWnAnsdRyowjJ3FH85YOQhGSJezhtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

On 7/10/2025 9:08 AM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> These two patches fix an error code path issue in the KEXEC_JUMP flow (patch
> [1/2]) and clean it up a bit afterward (patch [2/2]).
> 
> Please see patch changelogs for details.
> 
> Thanks!
> 
> 
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

