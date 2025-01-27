Return-Path: <linux-pm+bounces-20982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3279A1D9D6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C51680B4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A4152E12;
	Mon, 27 Jan 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xnzFcBe/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576213C809
	for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992606; cv=fail; b=XCoEX4kLdI5WLniXhMkRvkHvzB9lK+Zcr51sIaoBJn6cI4F3r+6dnb4QOuqpL5D8dGRWibn0EfoovTz894qTlODpxJBYYM8CNdHbqAWB5WX3EucT3XgDJKpMsoqbj8H57tYChLyUPyoBfPSeTasRvyihIoy8e2qE/gx29EBk4NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992606; c=relaxed/simple;
	bh=XyFvYYTGxwQnTONJdqD1e6tstx3waUcFN1nERXYFto8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3oEhluEBoyqhib1N4svblIXxeO1aQn6dXKDK8uKvNSXa93KvVLhjhVUjqnRzGuU4M8MKQMRzaSRsOQjtvu+WZQbAMObC4MYMiNxb+Is+J0OFdISyvkeYzebmjNk5DsFDnGImLxB+C9Hz63+igItpUedKLwO5Y6NilbOPdFj0ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xnzFcBe/; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CygRlpydx3Hj50w0i1hXTxiDA10EHgjMljOF7u+zrE2Wyo/1f4rt+wjwimzS+cIJ6pS9sdAKw/drBV6D3M1FbStbqehwuHex+PQAr10wDgPlAzVBt09ks05G9e4eMMKEsEuJlQOJHz8l68Xr0iVEvzSnCuV1zBrDP2zozkr3sz+DzLz2gHg3Xy+57VPthR+cCCQyY9cmVg98atOjYpFejxO7FxZXQvU0POvN3uyUDaUpbg6u5zhzJNzXo3tiIY0jWjypked5Brw7s3vENqtdG9tBgjaHj21+U9APTRcIIOW/pWzjJviZvkho1vjt7n4/dthYep6LSHooqU9nZn2BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/ujWZVio0KP7UNkgIcWeSmLIVlKlCdKfWYrPoNn4jg=;
 b=hR5Gc2MwS4/rxNvS4nsQIJA09xmxMsPntuXedrJrrxWm9Uxs6YoMzEXge5y/DlUbPltHTviwZm3EuzO/I5bIqtWltw4wgbr0caT1+pcyXMX/K6AdIwVkuBv1ZCoigkYbXX6IJNMo4GkIznoFPEvsSm21cJvuNtzxk+ppl0/OZ+WTkz3psQSeygJ9z2AVExGsByKfG1P+3FVkEEdOm2AJ8mP7V8pBqO3qazkGqT3MqQIcw30L9P9RIl2NdKLBKmDSUdsMNxkXAive4eA6qyfMROwXZ5nck4ESYyp5ut9mQ2xSWPn3WDeT3PCvHyMMDJ6sIK85Py6if9R74E8eptGPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/ujWZVio0KP7UNkgIcWeSmLIVlKlCdKfWYrPoNn4jg=;
 b=xnzFcBe/td3hBmSpdRLVSQ+EtKrxIwNBn3R35dNhn1LkZL75fusP/Dy3ebbEaJl+ihUujV7eg+Z34YdRTCKn1/54UOXr+0FHYhkq2Bw4TidTaoZ+Ez+IYJvm8OTVJSJ3VqmIKucg2oH73+vAZaxKaoOPTRwD9fyGOfGp/Hh8+AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 15:43:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 15:43:22 +0000
Message-ID: <5dff1719-c4e9-4ebf-ae0b-73b9de98df05@amd.com>
Date: Mon, 27 Jan 2025 09:43:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled` (Dell PowerEdge R7625, AMD EPYC 9174F)
To: Paul Menzel <pmenzel@molgen.mpg.de>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: linux-pm@vger.kernel.org
References: <2b811df7-5278-4cfc-b8a0-7d6d72d3358d@molgen.mpg.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2b811df7-5278-4cfc-b8a0-7d6d72d3358d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d261118-9b90-4a06-84da-08dd3ee95426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUZxVkNiSWJxanZwT3h1ajRWSEQxZkt4S21yaVA0UXVqQVlMTWpVTEZtM2xw?=
 =?utf-8?B?Y1FydkRZVkorZGNIWnpJU3BsTnhLQ3o2V0ROQVNwa3RwaThxSzlqdlJEZ05m?=
 =?utf-8?B?clpMY3ZvbUZrQytVMG82dFNCTkVqVnNLa3EwT2s2bVJRR2RYOUVOdzRnV0xX?=
 =?utf-8?B?NjVQT2Q0NjJaUGo0TngyWmwzaENCMElBMVB2Uk1vRWhqWVBmVFZJcFYzOWp3?=
 =?utf-8?B?N24wdUR4NmsxUnhqcy9iNWdPUXlxamVHeVBuNEFObmU5TGhaWXhiZytibHpi?=
 =?utf-8?B?UVlWOXVRcS9HWjRJRVE1OU92cDZnTmlSbTY1RlZoemJ0aURxNFdHVC81S295?=
 =?utf-8?B?NEhuRDdObE50SkVKTkI2ZXJBbGM3d1RkWFF5UklVODdyQUNBMzhEVGFkaTBP?=
 =?utf-8?B?T2VQMFZnaTBYbFFVQ08wLzVhYTNIZ1lFcit5QXh6aG5YelFsTlAxQ214WDVK?=
 =?utf-8?B?aldQZzh4SkMvZzk0ZGxwZkxyMkZiU3RyNGNWdWErY0p5RFZXa09QVkFDazVU?=
 =?utf-8?B?RnVydEZZZWl1N04yMHhpb0pjQlNjdlE5VWp4NitZaW9NR2h1NXJkZEdCTTFQ?=
 =?utf-8?B?OHlPdWhJSXZ0UjZBbHVlQkxhUENqTzZsbkxrU3RFVzhKSzk2T2RpNTYzT0VW?=
 =?utf-8?B?UURrVWplMU1CQ0l4MWQreEt6bDN5U1JyQUVEYW5wWXhKdkdQam9nd21FVkFw?=
 =?utf-8?B?d0NMQnZUMWJjdXBCWk0wd3NXeEJzRDJ1TXowZUFCeUxMOWxjWVN6TnQ3ekZh?=
 =?utf-8?B?ZVBYZ0NmYjBpR2E1K2NtK01oUmNpandaclI0OHdWMXpUWVRwdUVzYlhDR2Nt?=
 =?utf-8?B?TUVvMlEzdmg4cXhxTU1LUGl4eUFoeHpyV1VxT0dJdHNtRnEvQlgzc2E4enY1?=
 =?utf-8?B?ZDE1WnRUdHNkRWVwdUZmUFdrY3c5eklMRGZYVXpYV2FMckR3SDIzR1U2QkJL?=
 =?utf-8?B?Y284bmVnZHA3NnltczVOVFFDWkw2cS9CSnVvR0Fld2JIL0NHcmZmdzJBSnVr?=
 =?utf-8?B?VGRnajFaRnVEa0p1NW1FSGVaVkxmODJvaEJobDZqblVZUHI4U2NSZDBoN0ta?=
 =?utf-8?B?d2NyNXk0cC9hUXNwNnBEMWJwTG5ZbHFpUERxanB2N1FwYWhIZm1YY1huTjdz?=
 =?utf-8?B?Q3h3YS9mTExmUFAxRUIrYThqUCt4bm10RVNkNndCUnpxcU9Pd1FuNzMrczV2?=
 =?utf-8?B?YWVTcEZHY0hjNCsxUUV3ck5sT2pmYjE3UWNCNkJWZ2NkNWJUeXJXY0ZhSzY1?=
 =?utf-8?B?enAwd2c5ZjNTcW9ZQUNTR0ZPRWNYM2R0bUZVdEo5dWNnZ0pNOElrUy9wbFhp?=
 =?utf-8?B?d2VMVEoycTUzdXVXYkdBWFlnTmJXRnNCRW0vZmpBaDEyYm4xYTREaTZubWZh?=
 =?utf-8?B?dGJHUkVUcWhlMWFtbjVVd1I2cHluWGJuSzdZUnhvU0NzSzJTNTdLMDk1VVlX?=
 =?utf-8?B?SytHV0lWUjVHZUhyT2EyMzhFSlVDamM2Tm1CWnlpbWtsU1puWDNNcGJFcW53?=
 =?utf-8?B?ZEhadjlQZHVwWGR2ekdta2hYcjMySml3VEV6VTVTc21DNVoyakJqa3BOR200?=
 =?utf-8?B?TDl3K0JpUERFNkxaRFY3WWs0NE4yR0lsaVkzc291cnVHbXNtVzdUL0ovdFdu?=
 =?utf-8?B?aTdPYnZyZjJGZXFNM2lScUFOS0ZIVXNER2lINll3clZPejZDZ3UwV3hBdXRF?=
 =?utf-8?B?a0lLU3h3RlBxZlIzM3hiMFM2TUxnSE40d0JJNWFWUzhhN0dKY21LMmdpMFNP?=
 =?utf-8?B?SUlKbkZDRUxLRHZxb0JHcTIvSi9NQlJiUGgvQVdsdUhXVXFsSXg1aFIrL2hG?=
 =?utf-8?B?b2RrSWo1ZjJFQ1oxbktNYnE3Z1d5aE1zVkJoSHN4dEF6UE9kZlFwS2pCK3pE?=
 =?utf-8?Q?NVtrjTmEH3GtU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5SMFNmUVRvTXhoaDRwaENsYng4Wll5VWk1Q1gzSVZRTHNZSnk4V09CWU1O?=
 =?utf-8?B?bjliaUVDYjFnUDVGdmlNTnF2dURLSGZXdEw4dThKVkM5T0ZYUStxRVQzTm9B?=
 =?utf-8?B?Tm1rbk5wSVJtWGdjOTBEcnJvbTNkUVp3VE1pb3ZYMHdDVUJ5V3RMNGlLMTZm?=
 =?utf-8?B?RTR3bzF6YUIrMHRkQ0xwb21Kcm5GTXJPUHhwMmRVckF6bGt5K3cvV2psbmhO?=
 =?utf-8?B?R0hsY3U5TWY4RmdwNlEvb2N6c0tlb0JhRHhET0k1MnFOdm5OTzhxS0FKUW9C?=
 =?utf-8?B?OG1DT1NWUVo2Ynk5R094Mlp0ZVhnaGMwK2d6QVFvTHpPY3YzTHVjcW1vMHJ1?=
 =?utf-8?B?WWFQYmZvNmk0SlNnSnZidDZCME54SytoOHVzdHhHd2RVNFduWlZISUZMQUZF?=
 =?utf-8?B?OWJwaWVwbXBIeEdSZktJNThHZzlDV0RqNml4RHhaNmg1L3h2Zm4wK210VGJW?=
 =?utf-8?B?MUc4QUZUNWUyTWpieGF5b1B4NTJNMy9HTnBHd2pOclBJN3FQOUZXaUV1U3d2?=
 =?utf-8?B?R2Y2aytGdkkvZ01UV2RvcXlzNEFOV0tDNjBRQVk1SkVkY29mUGNZQk03N3Uz?=
 =?utf-8?B?L1A0c0VkaUNMc1dMYkswV2k4amswZUtqUm1oL0thaE02QXhlUGhoKzdCQ1F4?=
 =?utf-8?B?aGIrYkZ1NEZOb1poWGRMRHl6Wmhtc0hZY3l4ck9qam53YnRmNk5sOXRkT1py?=
 =?utf-8?B?MHA5VER3cUlDdDNCd0kzajd4LzdxMG5mZ1lKKzEveU5Jck9ja2pDV1FFdWli?=
 =?utf-8?B?aXlRUDZnYVZ0cTk4VEFRUmZjbG01cVU5U0dqY1ExQlRUUW00RXRvd29UR3Zz?=
 =?utf-8?B?Q043MGVrY2JqN29mby9qRXpJWkJqL3k3VWRUOHRTVk4vblNFelFPT3JEVDFY?=
 =?utf-8?B?WGRVOENUbysvemFaeFFNd2ducGs5SXQrY3JaWWRUWVhnUkN4NEErbEtKN2Zn?=
 =?utf-8?B?cGo0KzFNQWtQSkFNd2xRbzlzTGdLMlNkWVc0ZVhkTWVlT3NnWEszREtya1Jp?=
 =?utf-8?B?SDUzMGw4S0p5VGxQLzZ6TTM4L21URGxDeWV6ZjEzL0JKOEw2cC9iR09rd2lF?=
 =?utf-8?B?RU12UXIvSDVTWXgwa0s0YWRvVHB4NUxZaE1zSjg5R256eG41QWdrT0F1QnFh?=
 =?utf-8?B?ZVVrdi93NXpCZ3hvalFUZVJZYk50T1RyN242aU9jVXF5MVRuMWdmZ0ZhVEdm?=
 =?utf-8?B?S2F4SC9TbkJ0NVEvQk9TSHYrYjRKUEFNOERMQkZpRnJ6ek1yMHo1UHQ2Z0RN?=
 =?utf-8?B?OVh4RFdNbVJiNTNVWW9DTy9iRFRrU3FuVEIxOCtyTUF6RXNpZjQ5NmtMeFZD?=
 =?utf-8?B?NkYyTC9lYVFVQ1JVOVpUVEdvb3RzM2ZMMHVqME9ycjkvbmZUNVk0YWR6SlFZ?=
 =?utf-8?B?QSt5ZkFnVXB4VmRWeGsyaGQzaTNMa2JzRUEvblNtSW9RNXBkbW1iT3NvRDRE?=
 =?utf-8?B?RmxTK3VGbVY3WDlqSG1uNjBMMTh1L3ZsTS9BZG93d3NnR0NPL0RoWGpCMVRj?=
 =?utf-8?B?NFFwOVArbHJ2b0NwNGdJWWtYcTA5enRsKzRTN0l5cTI2US9hRTI0M0N4ZTlD?=
 =?utf-8?B?RGhxdHl3MUVudXZibU9LZ1FkRUp5UjZrMkN4bTdvUWtOR2UyOFMwT25KaFJG?=
 =?utf-8?B?Q29oc0hTV2ZVNE5GNXpETkNReVBsdTFacEhWSEJKdHR1bVk0KyttYXpCTHg3?=
 =?utf-8?B?LzlGditWTGlxUVU2Q2pxWWh0Tm1iYnhpQktDYzRKUW9iVUc1NWR4ZzRPaDNz?=
 =?utf-8?B?L3hOanRERENOcGpxdy9DRXhicjVQZ2E0QlllaDN2aW0wVVlYaDVtN01ncHZn?=
 =?utf-8?B?enRnNnBoU09DNkVqWklkTW9vV2laQlljd3lsdC8zL0JRYzZtdk5kOUo1R0VM?=
 =?utf-8?B?VkZJcGRZWmU3OUp1RC9GVjN3ZUFFN0VlbTJCWnlhbjBPWkt3Vm1nNU1JTGpi?=
 =?utf-8?B?VmZ5ZWRiUEpsQ04xUStSL01VdzNjUW1GMVl5ODdxTE1sTExLek5Sa2M0S2Ry?=
 =?utf-8?B?MFJvNmtSZDlOMXk1WXdqVnVxeHZiSmFNNnJ5K2IwRWcyMUZzNDRqcVJSK3p0?=
 =?utf-8?B?MGFmS1RsVXM1SklIbDFaSlhQSTJJMEk5T1U0L0JIdVNEd0VUWGFscjlndk9F?=
 =?utf-8?Q?egmX+GgEtA5gF8nLnjyJT2dKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d261118-9b90-4a06-84da-08dd3ee95426
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 15:43:21.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsTB5veYzlZ1qFeTyEzD1kDglARMCkbKdU+DN5ySaHAwR8EuVF+JqwdVHY9h0nsXJO1LmFnu7tN5qxZxg0jKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

On 1/27/2025 06:41, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell PowerEdge R7625 with two 32x AMD EPYC 9174F Linux 6.12 logs
> 
>      $ dmesg | grep -e "DMI:" -e "Linux version" -e microcode
>      [    0.000000] Linux version 6.12.11.mx64.479 
> (root@lucy.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.41) 
> #1 SMP PREEMPT_DYNAMIC Fri Jan 24 13:30:47 CET 2025
>      [    0.000000] DMI: Dell Inc. PowerEdge R7625/0M7YXP, BIOS 1.10.6 
> 12/06/2024
>      [    0.000000] DMI: Memory slots populated: 4/24
>      [    9.487804] amd_pstate: the _CPC object is not present in SBIOS 
> or ACPI disabled
>      [    9.733516] microcode: Current revision: 0x0a101148
> 
> ACPI is enabled. What can I do about the warning?

You can look if the BIOS has any options for enabling it.  They might be 
called "CPPC".


