Return-Path: <linux-pm+bounces-9943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384B9167E2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2030B24A79
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33114A619;
	Tue, 25 Jun 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XMOr3aGR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4973463
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318709; cv=fail; b=kaPZfYi95cZ3u8yFERxljNzdBJ9LX5C/BdfXkAQSryFc7YBlGUsBRhpchz4H2GYPnrMz9EgeDuG8bYBhh/e2SuGzPmInpWY67+P46U/8okII8ppDJ2cgPaCtGw/yi/zmvwKlmRIBMx3UZlz3k+gCG9oyuUUqvB7unenfgG9gynk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318709; c=relaxed/simple;
	bh=FN0ybjy/jpxSH2sPhS3WeHDOftXxB0uVqS/0QRI6PsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toSpBm2/WKnbtDjhvRO+nySKH3+AtmeVbrQHylyUUiaWkHCcOmEcLBDyB0Uvws/qDGNpmJk1Mtwh6IZoHUHxXGp9OXXxYslATf8NEsMgqcgFgvTSu+lYub0ZZ0pGfvxe1s247DEnX1h/XSafTwnA5uCFI40hHoUKRQPu8JV6eSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XMOr3aGR; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKJ49qOoadWu3XFP0+Lu3QzfN262CEn0EsoB1Tdbnv9/5WKFrmN8bJgMrxfb1PfqedgSagqenFAc2O9c3BYywLJgdIVuCsl0lg3rAMgVi8diRcA5PxIn55FAVSTdNK2gnNisYnWlHnVVms1VsSEPROkUPPEZCyXO3Xil5AXpSb0W/NZ0ucO08UtT5HZ6zwskMMzeiQqlRkSnvbAhsfpN5zxUEbZcoMBb+duUtUFq7sK8sumU+GZNSps3A2lBbe54mUIGtaC+mc9xFozgPJR+zSLtK8QLLWVPfsfbdHrZ0kQOqMGYp5mFqi+BVYA9B+JPbxnA651OE1MTiJfpzdAw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI5f8T/vOOYHVQVLNwStycqvKfy55R4AVbgzBBNlGX8=;
 b=aBEdgglDvyQTo8IX8YezlDUZRv3FqrdwouFUapstVa5WA9FEsuRspdNMtlKxpvGroutSXdoRcjzXBzfrlRMs4Jp8WW4omuZHTt4NaA7iWVau2+h9mjqWNWQgkNceafKmWK7speIkt/CGivyQAmWQZrDySFGls0nGB3yjoZfuHmIBesowXUwKBlIH1UJZkiBhRM+S4Xpr+mVJ2wh3toackyD4VJZaIfHFFC9cQ079AXeViMQ3/rV7Ftny7zO+0VPIYe4MN/JXnJEvBj6pyOcc8KItYL61rklJ9BfrvAVle3GToEIkZ+VO8zbfBni/NNzY6MizPmOV8pvrUPRPk73LEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI5f8T/vOOYHVQVLNwStycqvKfy55R4AVbgzBBNlGX8=;
 b=XMOr3aGRKZ/tQjhOyTyqdjRjEy4ykG3lGoMWAAeMI8fwJPbKvqBqrPEkWEtLKxYnAeJIvzvvJyG00GFnhjRRi60Q5N/ddJYiz0vBb009X/fi4udZn5A53XDti0WqSxUnoI+Q1afyaPLy+XLxFySLrnhy2fKXILrl7/yy/oIFvGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 12:31:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 12:31:41 +0000
Message-ID: <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
Date: Tue, 25 Jun 2024 07:31:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
 Linux PM <linux-pm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: d06ca29d-7c59-41c1-4a5c-08dc9512c452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1pnU0FjQm9xa3ZkL1ZQd0xtV0xQck1Vc21tMGk2Rk1DaGxNdWE2UDdsTSs3?=
 =?utf-8?B?b01SM1VnOTZNcnNVUmxIdUY4M2lrbmFxSmhlQStTSlVqdTN2SHlhdWFXbGxt?=
 =?utf-8?B?MXMrVVF3Y2Q0MTJ1aUJGb0xPeWxIaGtxV2ZjeVl3dHdSdVRQK3FtQ2trWklC?=
 =?utf-8?B?MG1OSXVYcTFLLzlkNDZMajcvSHdWMUdEaGVJb1ZDQ3ZWcEQxem9GMmdjQ0Vw?=
 =?utf-8?B?UjNLdDd4SnBVZ0ZmeW1aRHFmMEV2TUJqSmliZCs3RHhiV041VXhwLytTUXZh?=
 =?utf-8?B?S21LeXdGYTFFZ3pZalJhTjVzcmlzMTcyT0ZvdWQra2hIa3JheEREelBNYko0?=
 =?utf-8?B?TzhrU0VkdzdWaHlCelJvcWphV05mMW13aFFST0pvNzJ3RVN4VDJReVZYQ1Vu?=
 =?utf-8?B?dVJieHRnRG9LVTZXV0JpY3J1clluYkd6R2RwamRsdmpja2NrZXk5UXUrbnhj?=
 =?utf-8?B?U2xzcjVsTndYZE8yRUJ1RzRYQWhOeDZrTytaT3M4S3ZMT3ZYWFJTYVhZTFB1?=
 =?utf-8?B?UEk4czAxOUlBSmJCNm4rOFFmeDcvSjdzSmdTVnBwbXNDcTZnQ1ZnbmZ0dnRT?=
 =?utf-8?B?UEduRlllTHl4SVJYdXBJT1ErMlV4ZzBwaVVXRFVGeitVY0ZOVm9Ec285QmlX?=
 =?utf-8?B?eVpheHRkb2pqQzBNVzJRRE1YWENlaUJDLzRGekJOUldLWGc0eFE5TGxDbXVC?=
 =?utf-8?B?cXlxK3NWVnVwaVdqZ0VJZ1gyUmhQNU5HNHR2amRnSDNqbVBBK1FMNjRFTDhT?=
 =?utf-8?B?a3UzK2h6NnRteDl1QjFwN2p4YmRCUVJTeTlpQnpPTlZXV2Z5WGtyd2ppV1RD?=
 =?utf-8?B?QktCc2phY2hyKzVxWjNGdjFJa2NxdFljMUg1WlJhWGtFQk4yd3ArQ1FZdjRh?=
 =?utf-8?B?OVU0U3pod3JzcmovRUpFMndvZTZBbkxuYWMwZkluYVZ0Ym1jWFc1YURCVW1D?=
 =?utf-8?B?SlNqOFdDUkx0TVR2WlR4V1o5ZGJUejZWMTlFYlZDZk5HcHJpV0RsZ1JDOU1x?=
 =?utf-8?B?eTI2bS9rT0swZ255cCtuelRzSGw1WVlING12L25Pd0o1bWRZL2xsTjhYMlp3?=
 =?utf-8?B?UFBaMTRkcS80elplaWh0aFp1RlM1RE9TMGFweGdVMkZiUW9abWNVOXJtV0V4?=
 =?utf-8?B?OCt2ZmpuMGFyQ01JK25XUmlXcldNWFZhQ0tndTM4bTZ1YUl6bWEyNG9tT0xT?=
 =?utf-8?B?UEZneVVpTmtmSnZiNW1LZm8xdU9hZU1UOTRhTHFFY2xiOXNvTUpiK3lJekVt?=
 =?utf-8?B?NTg0clBjVHJKNFNFQlJVR0RZb01jNCsyamVZUythQXhHSWJadExwWHhaUUlE?=
 =?utf-8?B?UmtNSDQ3OUR0a3VJbmY0UkhDa2xDSUhrQmtPZGxmczJCdHBUOHlGVmhnVysr?=
 =?utf-8?B?S3c4U1QxQ0NMR1VQVVMwY0xnZkx3ckd4eW1FWXNXUUxhMGE0K1pkTjcxMHIy?=
 =?utf-8?B?ODh4NnlndnRYeXhKbVRGVFlEa1Q5cjUra1VLTzN4RnU2dWphdUxZQ241RVMr?=
 =?utf-8?B?MGNwLzNVNmh3RVh6bFJHQWkyZDdCZDg3UVRLZnlTaFVHN083RHdUS3Q4TWpu?=
 =?utf-8?B?VG9RWG1UZnpxcjZlOWFZU2E0YWJkRzFpZlJITG1vMWRIOXRTdWo5djk5Z0hV?=
 =?utf-8?B?d2xGQnMveWxWSk8wU0NCQ3VhNzZSNmZ3WHJIMEFpbVdRempxNW9RNUw2cWh2?=
 =?utf-8?B?OWtzOGtMMGtXNzkyUnl6SnhxMlpncHQzNDBkR01aS0ZOalJxdjF3SnBBYW5Y?=
 =?utf-8?Q?CrbFlFsWic3oJQvGiR2Js59+xqwo3wON/mkqDkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N25hbjAvUkRGSlVZWGdZOWw2MDdBK2lMYTVHNitMdHA1eFdLZ1NhR0pyN2FY?=
 =?utf-8?B?UzB2bGNwV1AzdGxWUjN0NzZGd0VXb013WjI0Rno0VG4wRVQ5TTAxY1NRTGI4?=
 =?utf-8?B?ZXJSTlUwUUpodjRFakV1K1FrTUxxZ1ljOUZCSGhZYnhIaHNDdDJoUFQ4S1RZ?=
 =?utf-8?B?NXlvYXRxSTZsbTI5Wm9qaGNCVTdZN0ozcG14Rjc2bmJ1QzlWK1hjNWwwNklu?=
 =?utf-8?B?ZTEzVDVpeVRBcHRKbWdjaHhhT1FiQXk1QmZyM2JKZ2QvMG9uNVRnOXNMS1ho?=
 =?utf-8?B?dWU3eG50MmJCWkNFc0JBZWN6U2xWblJVSUV5VTN2alBiVHRDZEtvM2ErUU1H?=
 =?utf-8?B?QkJ2RWhWVlYwQ25ZTU9zSEQ0eC9VREczbjJBd0xqR0txMzFyK041UXllZHVN?=
 =?utf-8?B?OUNLVDhZYjI0cmdqMFQrWkpOZXlnN0F1QVhMWjJXWWkydW04RUE2RXpEMHV0?=
 =?utf-8?B?MVlFN0s3L1dIWHBqNGkxcURiTG5vNEZaR1JHOWRsOFZzWVZqcmpUT1dYRG1q?=
 =?utf-8?B?aVpyUGErcE5hQ3hLZ2N6cXl6RjFsWEJ5bjBERzRsN0NXeE9EZERJa3dmTjlD?=
 =?utf-8?B?Q2VTbUlDNzQxbituM25pZmplV1ViVkt5bkl6V1RmNURCVzdNaTl0VDhLVmJE?=
 =?utf-8?B?dUhHTzc2OG1JcExKbkExcDY2aVhUSkNVdWxOdHpETFpVTjdJRUR4Rm1tajZD?=
 =?utf-8?B?N2tTZ0Jsc0pIY3JyaWsxY1lUMUs4Y0c1SGJIZ2kvU1ljY0drVFRrZlRBaTU5?=
 =?utf-8?B?UEFEU2pqYzNjRnluNWN5Ykc4Ri9xN1QvK28wWGF2YXpJZmcreG5iaVkyQXpu?=
 =?utf-8?B?V3BYbzlJSEpwbndWVk9VVkJhWFNnQzVYWXVjMjNPVmdxazRJZ1ZjOWpZemd4?=
 =?utf-8?B?OFpOVTkzK1Q1eFo0VUQ4YlRBZGt4aElENHZaenVueGxXSFNMaGg2TC9wUEFR?=
 =?utf-8?B?R3plSjlpRWI5OWMyUzBtTDNVSE5kTFY2TlRBMkpaSW1Heis4cW9vVXZzaWNy?=
 =?utf-8?B?MFgzZjdWOSt2WDVuTzQzbGIrWW9FWmlaZEdacDB1MnBueDdqWllZeUZFL2d1?=
 =?utf-8?B?M0xhV0o5MG8vTUQ0YWd5NFZDdnNnczFLdERrengwMDR0WUJWSnpQTWdYYjR3?=
 =?utf-8?B?NE8rcW5UWFZDZDZ5UzhqSDlJTGxNRWJuSzJSVmpRbGVoNldKOFFCa0tnVHhx?=
 =?utf-8?B?b2JZK2VhR2EvRjNsNWZMQnNvdnZLcDE1clBieS9YbktPbDNUZkMyVDhpekk2?=
 =?utf-8?B?TC9XSk1uMTZNYm1jZzJ1alExSDF5M2FOVCt6M0VBSDJPY3E3MmxTN2JBT3hw?=
 =?utf-8?B?emFGMXpqZmI5WjlVVWxPU2x1UWNNWHc1c1U4bzROY1ZFdEludWVic21Rdng3?=
 =?utf-8?B?RjZ2VmhGcFh0SzkyM1RSYmtOQ3IrdDJudjh6Zlc1MGhzRUNCSFVtRHRUNTlu?=
 =?utf-8?B?dnB1RG0rNGFlU3VyUmkyWXA5bjZRR2lzejlQdFAra1hhNllVM0xMNXBLSXNB?=
 =?utf-8?B?Wkh5ZVhZMjNxY0VFcGpTUkFIMTBDRlc4MFdMQlFMTlE4dGtRYlhabnpGSE5E?=
 =?utf-8?B?N1MzNGc4azdJQ1hwSDdBMllIN1VTQXJ3TGQ5SG1zN1dXRlFLMXo3VnpIUGIw?=
 =?utf-8?B?MUR2VTJjUjJZTGhYSmJiL1RHeTl2WWFHZFZ4SjJ6Vk9Za3MxNGUyaXZMdWMr?=
 =?utf-8?B?dUdzZWRjcnFlZkxSOFpWd0FuMitBR2w2cXdwcm1zbzZOWk1ML3NINC9xakI4?=
 =?utf-8?B?Qy9jUE5xRzJhWTFxQTF2LzEwQzZ6bnJnWmtybnlRd2hnMHh4YWVHRzNUQlVK?=
 =?utf-8?B?ekZtRmZPQklkM0tnVlRYMVdiME1lalVnamhoU2gzMkVia3B3ejllbEUwZGZw?=
 =?utf-8?B?OFJXR252WlpvZmhVZ0Y2MW03aHVweTJuQlVrK2xyNU1XWGE5ZU1jbUVjeTAz?=
 =?utf-8?B?NFNtbVRTYTRSN1ZnRTdXT2Y1c1dHRVROdXEvZFB0VEtZSk9LNk5STmJUTU5Z?=
 =?utf-8?B?MjBSNXNDK2RFSXc3REttY0lMaDB2aWNkTE9jbW5hR2QzQ1dGbk9nWWdWMnM5?=
 =?utf-8?B?SDFQK3NxTmFPTlJwdldxZVZwV09RN0VwemkzOE1LRGhQZmNqODdZWlBzYzQ0?=
 =?utf-8?Q?LXmUne4PyxnyKjQbOMn/m4575?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06ca29d-7c59-41c1-4a5c-08dc9512c452
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:31:41.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcSRRuhDCVg+CrFFe8AUIjGqKItvoraSvqsT6f/x2HpiN8CWyQDobRPbdXiDwic/Ec94GOA12PYLvU7J/Li1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

On 6/25/2024 01:30, Viresh Kumar wrote:
> On 24-06-24, 16:34, Mario Limonciello wrote:
>> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
>> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
>> policy incorrectly when boost has been enabled by the platform firmware
>> initially even if a driver sets the policy up.
>>
>> This is because there are no discrete entries in the frequency table.
>> Update that code to only run when a frequency table is present.
>>
>> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: Sibi Sankar <quic_sibis@quicinc.com>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Dhruva Gole <d-gole@ti.com>
>> Cc: Yipeng Zou <zouyipeng@huawei.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>   drivers/cpufreq/cpufreq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1fdabb660231..32c119614710 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>>   		}
>>   
>>   		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
>> +		if (policy->freq_table)
>> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> 
> I am not sure if I understand the problem properly here. Can you
> please explain a bit in detail ?
> 

The core issue is that there are drivers that have boost functionality 
but don't have a frequency table.  As pointed out by Gautham there are 
also drivers that have a frequency table but don't advertise boost 
pstates (CPUFREQ_BOOST_FREQ isn't set on any frequency).

So what happens is the driver may have choosen a policy to have boost 
enabled but when cpufreq_online() is called it gets "marked" disabled 
from this check introduced in f37a4d6b4a2c even though it's previously 
enabled.

