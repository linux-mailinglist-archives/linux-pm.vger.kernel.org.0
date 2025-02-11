Return-Path: <linux-pm+bounces-21773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514DA30320
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 06:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460453A86BF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BB1E5B68;
	Tue, 11 Feb 2025 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMko5Ljc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1A1E572A;
	Tue, 11 Feb 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253504; cv=fail; b=foVEQ74zMxMFuD/qADsuY2FL8CmxwJW5B0OyC4dcl9zE4mmMUkUqchktEpJnltnGF501Tua2B1FQMZjpy8Ytd4vFtvVBFCmJIndv6rsB1LbLyLwuqJyP7LvUhK7bV78Jtc3Adm/hHY2A//TrlXd5pSs6lgY7XZvnYMJF5ezJ15I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253504; c=relaxed/simple;
	bh=pzfynnb9zh6gqD6od/MEqNFgF0HgEhxm8rWxs5/tuuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bzh0YxGuGxiNkABooPsN645cGW1wQOgBNFV8fKJzL0HVJ0nrAydIDpvx5ZeyD0cKa+H4N54NnaT2FpnADHcCds5qvo2OPfVLOIhJ6gJJk1Lufm1ucfugen32/0Mr62oF5bob87IEnxBoelAGhhUmtdwFUqLERUmP/k87T/K+T0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMko5Ljc; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yin20gyJFErXaAnBl6PVWblhehe1ofGK6jN3/dzVeCQWzzjcEwS2KRjtWL80c7c9PVW+M6NtbZQUyg27hVjGdrFeGwqj82V/e8elY2f4X5qVTGtUaP6DugM2rSuHO1XH1Tm0NCZ2ZGjPjKzi3QqSRknrTmIDqhGdmJ4cOS2RTfOAB9AURGVnmrrZHo/y3kOR61khaFubNpndsi3s3BOn4vvE3dX3iB6mpVYbCYCKcZ59hDV5APpUuQtPv1X/I/C3sm8YwORYgeVB5o6WOFDFLFg9ERptCrYJtq9pKwlfL1YdNU9bd4cPXpotaPWo1GCauSX1OOnadAdEOY57yTIpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MKzpjC7oDGIVghPFujS/20xyvM9YzMVoIglicXh2RU=;
 b=RIEXr8INGO+BKS6DPkGnhZgBHYQbULjIbcN57wQ4en84TrTHC5c5jwhVTSoV+rEh2PmUGnRzPQU5VWbyCsKxZ/dcxI7fkibFm6w0tG/fc0gF6HO9aKIjbVHnVYwIzjeGcjT/iTuZErfwqES5sJ7+AN/QAQu/z1xLqVC98xXKMrVXA1HIgK+XC6yE3o1Hcu/lec9/udp4On4h8BA/HIy3TZ6ToPggAah81PtWqIU+JnlApgnqHVSCFM8fJqIIDkMMf/MAobBhzGGiwAUbNhXNZKy1eyd4oIUBmdKmTJBIEi+MKE0IzqCpvOLfF27rxfWLuIJeZIvhuUJcnNEEwc9a8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MKzpjC7oDGIVghPFujS/20xyvM9YzMVoIglicXh2RU=;
 b=uMko5LjcWlGR2xQVYj8A1TQy8Vf8ebS+mggnh7CeV4f7aBK76/+AVwWM5r5W028JXMekxmyqsSS88sbQqqY8WoDfSyIdmYyDNvj8DBoM+jRsX7JSr7cvSS/YTlsuNRGipVwoBMhvLFOeNPGeoxMuRpdKi1Q52v/VmLQsqCLkR9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Tue, 11 Feb
 2025 05:58:20 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 05:58:19 +0000
Message-ID: <09c02c68-1bd0-4627-8bed-b1276a223e3a@amd.com>
Date: Tue, 11 Feb 2025 11:28:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] cpufreq/amd-pstate-ut: Use _free macro to free put
 policy
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-7-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-7-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: bacccec8-af09-4671-f719-08dd4a611592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitQTUV5V0h2S0wwa1hEYkxnaUIvZ2F5Z2szeWdVNHFlZ3dvM3FFWDQ4T2lZ?=
 =?utf-8?B?bWJaUjZvejBJN0NtQTY2dGxJV2RJWWE3L2pwbU1nTkNyN2Y3cFpRUk9GNG93?=
 =?utf-8?B?SmdGWFc2K2ZrcVR2ZHVFNEZlNExkcU9JYXZCZE5KNm1lVzdmS2liQnpmQjJ0?=
 =?utf-8?B?V3M4eTJkMmVsdG4wUGVkQ2hCVExXV09MSmRpeTBSZHR6VFBhRW1nQ0huVFhM?=
 =?utf-8?B?RFhPdEdkam9EaDYvUDRsOFBvK0lVdzlkd0kwakJVRHgxM28xNU5pVWVLaWVH?=
 =?utf-8?B?RGRmV1VndnA0NVcyVWR6clVGR3gzcWc0ZU4vNVVLcHlMU2NFb2QzS1FSNGtV?=
 =?utf-8?B?WUthV1AzMi9nVVRwOTRsY1FpRDhwdUhReGhLTkFkMlNvNUkvUkg0YkhxYk9m?=
 =?utf-8?B?aXpXSURYTm1UMldxM0U4ZUE5K1daYlkyV3M2OGFEUDZQSUZYb3hqSkhqSjZE?=
 =?utf-8?B?a0JPNnlnRHVnSU1YZkFjcnRCL09EMnNHY0NuYW9IMjArcC9xU0hxMDc0cXFO?=
 =?utf-8?B?N24ycVRMdlllUzZIUkVPNS9UaGZVeVdjSFFoRGl3d0lXSW5rQmVBRWpuTCtE?=
 =?utf-8?B?eHZqMGtPN1lwbSttM3hLbkZXRjNHSDd3K1VOcEVKSmJPWVRscEJGTElMWGNK?=
 =?utf-8?B?Y2Uwd3VSWnMzNHRCUUpHRnhpUzZBUVNsVkJBSUNISmNpQlZlb2czN1lzekEz?=
 =?utf-8?B?K0FRZEJoUXhtaXdhL29CU2JZMVlXRWRDbStuampJNDJNUXJQei9aR1BNc3c5?=
 =?utf-8?B?N2k4QU1ENlFzWmZxNmcra3BSSk5uQ3BlZFlIRmpuUGlEM09IT3BHK1Z0N1NF?=
 =?utf-8?B?czBCQWZzMXBwQmFSVlRsQU9YUHBqVWY5WE92UjJsUnIxUFAvV3hYbldXTmFJ?=
 =?utf-8?B?OHFXTEZLVzFiSmlHVm9ZUTZnSG9qZHhMbGp3Njl3cEpDbzJqYTBlNHgyYjEv?=
 =?utf-8?B?b0lQNzRFeDMvKzRXQnllTVF1bXVxbE14OUQwWHUrLzVjaGZ3azZZVkQwRmpy?=
 =?utf-8?B?dnhRVWNCOXRhS0hsMDBqeFRlTkFScHNGbFhsTmxEb2tTaW5DS1ExUW84VTNZ?=
 =?utf-8?B?OFhYa3NoTHd5dDdaTzM4SVJ1R2krZjB6SW5pd2hLUUc1L3BmendIc2Z0LzVJ?=
 =?utf-8?B?L010ZUR0TDBoWlJQUEdOL1M1Sm1IZkhEc2NaMENiVVF0KzhRSWJGUUY0cFJ0?=
 =?utf-8?B?VFpzMGJPcW5SZTVCMDdTRU53QXZheVJMelUyczd5clhDUU84ZFY2WVZITnp4?=
 =?utf-8?B?MHFtSDZUelpYbkZSUWdXQlZzNE9pMm9mcy8xT0lXWlQ3UnJYR3F0anAxYzRY?=
 =?utf-8?B?bndwa0FlQVltQ3pTaU5ucWQvdHB3WUV2UDZCQlg5UTNOTUpjbERqSXZqOXRO?=
 =?utf-8?B?MmN0YXd0dUN6eW9FbnJsaVl2ejJ2TUdFWDN6UTJUMHpGUXJOdnUrZDliSTkz?=
 =?utf-8?B?MVBFdTl5YkJsMkFXWm1zOUhzNmc5ZDlNMzBQeWpMeE53dzh2RHN1MEFCOWVh?=
 =?utf-8?B?UEJ0N1ZZWjFvM1FpTEZFYW15MmtOc00zRlpmbjNEMTBFR0JHZkJiL3dhREtu?=
 =?utf-8?B?NUxYaWdLbXZEL1NWaUY3eVVIM2psNTM3N0tESnZ5T1Z5Tjh2VGNjWURzc013?=
 =?utf-8?B?QUYrc3JlZDFXK0VORXFYNmc5NWhIL0lyUnZReUFTcTVBNU9iK0hMMGlOckpH?=
 =?utf-8?B?c202T3FYRVhaZDRtbHFOekl6YUQzMk1RbVN3ZVgrRHFPQzBERkJ2Q0xmTjF3?=
 =?utf-8?B?NndqMDZ3ODlDL0wxbHYxZWhnekVuNGFER2ZMMnhZZTdwUFBReUlNbURxSGI3?=
 =?utf-8?B?eHJlajZhV0R1c2crU2pNRkNPaTloNy9NalhJbHpESy91YXdtMThDU2lpYVhE?=
 =?utf-8?Q?I6hVT6ROQ/eWi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3JUYmRlSDZ6RG1ySUJMQ0pidGp3d3F2c2VZdGxwdTVmdWJnMm1jeHFVQlFT?=
 =?utf-8?B?MVZmeDJWaFRZQmpBRXZFZysvUTQyb2xBOUV6b1dITFhSVk5Ic1VuVXQ3T1RT?=
 =?utf-8?B?VE9MRWpXS3FNTmk0bWNITlFGTjFRWFBLZFYvWFNrc3NoS3dFbW8xdUdsVzdu?=
 =?utf-8?B?b3RHTFJwSVBjeW55WHJCWjhSclpiVUNqMTJaZDk4K1U3WExYRHhYQXV2WWhE?=
 =?utf-8?B?YzZwazEzdnNQZlVITEwrZ3Y4bkMrQVNYZ0hhcHoybTRqWWh3RWxKbmxVazAx?=
 =?utf-8?B?cDR0UytMTWNYUTVvTTYyYThDZldDd2VRWXJ6NjlOL3BPQWdidzJhcjIzcHRK?=
 =?utf-8?B?NWJxSWZmaDNQVzJ4bkFUeGhTTko3R0xKdjdTSzJBbktlWU5mRlZqVHpwcFJk?=
 =?utf-8?B?Y1NQME0zV0FjSlc1dTJPdWY2YUh4SUlzeSt3eDU0WHo0bVdETmlQQ1BRNlFO?=
 =?utf-8?B?a3dwYjhRUSs4WklqNHBDekhWcUs1SUxTOUNiNC9vRnBsTG1ZZUVPNnJvQnBy?=
 =?utf-8?B?UFBWWGpUbEFrQ3RTa2hzd24xUWloOGNtd2VpM0RIVVREaTJxcDhqYkhNd3VC?=
 =?utf-8?B?U015WFVST1NsWEh2RHh4Z01iMm1xTWR4WmpCSlhEdWFFQUIvZ0oxUVdwSnBC?=
 =?utf-8?B?Q3dva3BNNzAwOUo2cXJmbTdZOGRTOXQ5N3Y4RW02K0JGRjdNcWd0ZFZXZU1u?=
 =?utf-8?B?RnVqQWtqaXczL0ZDZkNpTkZzVW1UT3JHelJEdVlMckY3S3c3dUc0NG9rOHkw?=
 =?utf-8?B?OGg2VFVIaW5NaVN1SzZUa2tBVGM5Vm9qbDNmL3EzTS9pYlNGT2QxeDQvcHBD?=
 =?utf-8?B?YkNGanZ1QXMzcHQ0eC9KVUYycExCRUJxYXMveWpWNDNpK3RnK3g3Q0U2cHVl?=
 =?utf-8?B?eThMWWUrNCtYQUg1NDJzYzM4WDFNWUdVUjRnbUdpd3l3SUhpbmRudDcvK1ps?=
 =?utf-8?B?QXUvQ2VzUktJNTc0ZUtlMEwyTkg3N2ZWRjJZcUZSZVFYQnA5RTNiZUtwbXo3?=
 =?utf-8?B?cXJaTUFZSlhKeS9QU3lTMDdzd1RHMTZBZEZjRjdpV2NYcFI5cm5rZEdPbWwx?=
 =?utf-8?B?K1Z5V2JXVU1QMDVzZmJ0SjluMG9NNDFCek5DNXZDVmp2UDBTWlFRNS9qNGY4?=
 =?utf-8?B?WGp6VC9wcWhsekRTK25ySDRVM3dWclF1UWc4UlA2OFMycWpSaUFWUktrV1lK?=
 =?utf-8?B?OWtKTWlIY0NoVEZQb2ZQeTg1ZzZ1M0lwSENMRkhkWDc1YW9kQW5rSG90L0JR?=
 =?utf-8?B?WURMU2p2T0hLdmRwYy9uQWtHVFp5ZE1odFdwZURUbnhEVGVuYjlFZEt2VkxX?=
 =?utf-8?B?SGRmaTJESW02Qi85OGZacXVpaFRKa2dYK29JUWg2bXAxc09ZWU4yUm1TSEVK?=
 =?utf-8?B?NVdubHNPcFNlb3pDclV0cndNVjhPSkxTYTNVVHhKeXVsREN0ckxhOUFwTVJy?=
 =?utf-8?B?b01ON0dVak9UYnVJY1lnM0gwVmxMb0lFTmlENUpQM3EvSWN5RklyekN3MXJp?=
 =?utf-8?B?V01oeW5acUpraVVjREM0alg3UGUzNm93TVcydlA2aStlTVN4SFRsejV5TGlP?=
 =?utf-8?B?T0RLcDErQnlJSHEyYmJGNU12S21oaEFOdTZsVmYrSDFRSndYL3J2NU5STnFR?=
 =?utf-8?B?Rjd0U00zVXhybThjc1FabE9OeUNpMkZkRHdqVzBOK2FZN05SRkg4UG1LeEJi?=
 =?utf-8?B?NUZXOXlvRmJISk9tbUJsR2h1NU5Rc0JyY2tYaWlQSnlSbk5KdGtrQUt1amho?=
 =?utf-8?B?QVRyZmlCQjJrU2tNandhbVZOdzgxaVptdncxZlp6a1NtbzhmUHNpeEZXNXRW?=
 =?utf-8?B?b1paczlmdXJnb0FRR012SGJ3eTk1NzdNREZsTzAvN3pCTnJYSWk1QzdrM2hC?=
 =?utf-8?B?MzVmNmtVTUpSbFJoOVQzQzc1azljU21Vd1IyQy9oM3hxOHA0Lzh6eUdmekk3?=
 =?utf-8?B?Qjh4R01ORzVZQy9oTXQ4MUxCQldZMnYyeGpUa25zNTB3M2RKVXBMcXNkTU02?=
 =?utf-8?B?ZjVZem14SjJGWUVFYnZhbWpPMzNad1JXYzB0VSsxbHdTcUxBaXY1T05FSSs5?=
 =?utf-8?B?OUowek1pQXZCZkl6ZXVTeFlpVFh0Y3Jld0YvUkVKZ0pnZVZ3T3IycWhpYXlx?=
 =?utf-8?Q?KhERhxIazA800tc2G5vyUErpw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacccec8-af09-4671-f719-08dd4a611592
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:58:19.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7Nxm86xXvS1AVvAJfv0kolH4TBuUtETYL57IYlWvsyWtrvRZKnuracnIUy1Flkndu1JdiUW13Bs3YbqZm8teQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Using a scoped cleanup macro simplifies cleanup code.

Looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index d9ab98c6f56b1..adaa62fb2b04e 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/fs.h>
> +#include <linux/cleanup.h>
>  
>  #include <acpi/cppc_acpi.h>
>  
> @@ -127,10 +128,11 @@ static void amd_pstate_ut_check_perf(u32 index)
>  	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
>  	u64 cap1 = 0;
>  	struct cppc_perf_caps cppc_perf;
> -	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
>  
>  	for_each_possible_cpu(cpu) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
>  			break;
> @@ -141,7 +143,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			if (ret) {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
> -				goto skip_test;
> +				return;
>  			}
>  
>  			highest_perf = cppc_perf.highest_perf;
> @@ -153,7 +155,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			if (ret) {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
> -				goto skip_test;
> +				return;
>  			}
>  
>  			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> @@ -166,7 +168,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  		    !cpudata->hw_prefcore) {
>  			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
>  				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
> -			goto skip_test;
> +			return;
>  		}
>  		if ((nominal_perf != READ_ONCE(cpudata->perf.nominal_perf)) ||
>  			(lowest_nonlinear_perf != READ_ONCE(cpudata->perf.lowest_nonlinear_perf)) ||
> @@ -176,7 +178,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
>  				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
>  				lowest_perf, cpudata->perf.lowest_perf);
> -			goto skip_test;
> +			return;
>  		}
>  
>  		if (!((highest_perf >= nominal_perf) &&
> @@ -187,15 +189,11 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
>  				__func__, cpu, highest_perf, nominal_perf,
>  				lowest_nonlinear_perf, lowest_perf);
> -			goto skip_test;
> +			return;
>  		}
> -		cpufreq_cpu_put(policy);
>  	}
>  
>  	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	return;
> -skip_test:
> -	cpufreq_cpu_put(policy);
>  }
>  
>  /*
> @@ -206,10 +204,11 @@ static void amd_pstate_ut_check_perf(u32 index)
>  static void amd_pstate_ut_check_freq(u32 index)
>  {
>  	int cpu = 0;
> -	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
>  
>  	for_each_possible_cpu(cpu) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
>  			break;
> @@ -223,14 +222,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>  				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
>  				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
> -			goto skip_test;
> +			return;
>  		}
>  
>  		if (cpudata->lowest_nonlinear_freq != policy->min) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
>  				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
> -			goto skip_test;
> +			return;
>  		}
>  
>  		if (cpudata->boost_supported) {
> @@ -242,20 +241,16 @@ static void amd_pstate_ut_check_freq(u32 index)
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
>  					cpudata->nominal_freq);
> -				goto skip_test;
> +				return;
>  			}
>  		} else {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
> -			goto skip_test;
> +			return;
>  		}
> -		cpufreq_cpu_put(policy);
>  	}
>  
>  	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	return;
> -skip_test:
> -	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_set_mode(enum amd_pstate_mode mode)


