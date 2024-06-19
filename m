Return-Path: <linux-pm+bounces-9626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621C90F71A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE381C217EE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F787158A3A;
	Wed, 19 Jun 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CO6kC0Yc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C47156C6A;
	Wed, 19 Jun 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826022; cv=fail; b=LqhgC7R++1J4LBU7htGfo1YxmulBGL7vjxXEblzBkN+KKaZyp/vS4ttY+uaIKqfh1uZnfXK24MqpiUhp908eOrWmzblOeugYoMHI4rwGlWlLRUUfInTJ5CNStL86UW1aThUmYh2lpGujEaHTGDC84i2B6/b2r/rRjAjYoV+iwHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826022; c=relaxed/simple;
	bh=L1kjiQV0om8OTaD0LlQdbmVgN7qhAZlbNZ1lXwqgxCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LHjNhpt28K0D/55pCeQZ/58qITKreyeKLfAqauTGxe40TyboyK1/nBh7MFkgGf48A65S15eSIqNMxD+2/jCaRQ8NuzDtlz+dXeSd7HSg+dMFpfJSjBfKA8L92GtMJv16IyYCnrZ5heUmFQwXA96YfAwrD8c2+YxvRXULui5LzUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CO6kC0Yc; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8QzG29Uze4ybEOCp8S1l45Fhx2K/c/dNLM+d88GjD1Z2REaf/98BBZ/b9EwWTC855plR/Zn0VO1+WLpar9VjAlwHCF6ImXx5rGmoSDU5LD53Ihjvu5xiC2JOhgxJ4zmwwgO8Pn71aj2zQ/626kcvzpuUkRhncUBkafbgUbVGQclpaT6vJWt+foTbco4Rk1+02wKMNwe80Nsr9yG4y19QIH2ypux1gFFuUNgop90zLbnlGEKkhGKQYp5poBKNg0/8Nmy73eKJsWb0Qr0JgKerOduueDcpnEA1DNffVskXfjCSL1LNK5qwil5Hhma805Hoc96SjKhIEaT36pyikDZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTMIaAZcNQIwiBsmCYbz20CHvtnbQkuLzPtYsdwaOME=;
 b=ffxqLTkrJxFsV20ae2rWNbfEfgADxZ/gZgO8nPjulsv86WR4zksIvw8PPFhvmEYr0mg2wZhx1kowhDfdMXl1g0MpbQxo8bvB5RLwd/LHaf58hOmlC1AjBTOvNPLuPPxxdzyQqEBvrjbR3ZJk73WCpAUc8ru7xq8xRPn2EhtuJDbhHco9MHULJl2rClaNgqv5ypwGd/SmLk0s6il8wmi/2HiwUjcmESpQweCeAVBuTcVZ6Gzqe/MIY4d7cD5eiclWE1d/jUkuCQR0c/WN2a+Ol+1WIWTNZWWc43byt186mLP0+lrZAHvPkyC15d+5qiVw9amiTnvsAgY0lZFU38PC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTMIaAZcNQIwiBsmCYbz20CHvtnbQkuLzPtYsdwaOME=;
 b=CO6kC0YcS5jF5pgFyAyEfczhfmqCmLs9SgYo/9pxGYzPChlMXxGJ5y+8cfPLCt7wrK6c/fSrJQwPE0GlHAbfDdVUMKJ6F7lO6dLp0upgFFY0VHM64P8DMr/MTWiU6ziNhFf3eYIS9aBnh1hZXeaL24mLie1nhe5/S+LG4XzQIuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 19:40:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 19:40:18 +0000
Message-ID: <51a73714-3611-4254-a5a4-85d35efd371f@amd.com>
Date: Wed, 19 Jun 2024 14:40:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718787627.git.perry.yuan@amd.com>
 <851f4e8b2495f35f2ee1e848844dbaabb55411f4.1718787627.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <851f4e8b2495f35f2ee1e848844dbaabb55411f4.1718787627.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:806:d0::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 336402d3-39f0-4c61-8c1f-08dc9097a5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWNEOEhBVXd2R0ROc2NHUmtSM1c0NStaMWFFOURuSWJ0MWRtZVAwK3Q1RFE1?=
 =?utf-8?B?VXpkcG5CQ05vN2g1VVMwM2pqQ3JPNHNnMzJKK09WRUFCN3VyRys0ZGdBWlRo?=
 =?utf-8?B?UXNTNDkxUTYzY1owRTNOKzEwK00xSUNKdUh0dTczcVNQMitJKzlYRS9uNWkr?=
 =?utf-8?B?SERtSVhBOTBqTEMxNDFVY0ltT051anJ5V3F1U0J1dzRzR0RsK3Q5WGNtS1Fi?=
 =?utf-8?B?d3dZNjVScGdGaEpXTFJMbFFNdzMybGx2eWRzSmp2MndtYmszUExnNmQyeGhP?=
 =?utf-8?B?SzdnWW5wMjFNTEh0N0ZhYWR5UDRiZDh3bGtrQ1FLMmtaMFpyU25Xb1N4ckFE?=
 =?utf-8?B?YVNXQTZOTHljV3c1cUNSVktxc3N1aW13ajh6djAxYW9YLzRyRWkvbVorTVJ3?=
 =?utf-8?B?MTBOODhRbTQ5SnJpd09uTzI2TDF5N1lWS3JYVnhEKzZtSk8rOE4rdUxCbHls?=
 =?utf-8?B?cGZxY1djWUlPVU9FL1VSOXRxSC9FenRoRjBMeE0zckk0aFZaNFdOSWZxaHRz?=
 =?utf-8?B?NmRVNkw4Q0ZpdVlaNktyVk5DMFRiTVA1aXJnbEZsM1JpRElXbm1YVit3QVhH?=
 =?utf-8?B?cEU4cXl4RmJGcmdYZW5XaVRnYUY5dVJQbU9hTENxRVVxc3VJS0I2TGtGUGpx?=
 =?utf-8?B?S0hjVUNESGRTU0VQQ2lXME1hYklEeFRMSXl6STZxMUhIdUtqZkp2UGtLT1FZ?=
 =?utf-8?B?NWpFcy9FYng5c0dVSEVZVU13ekdZbWFQQzZTOE9qT1duVm5odmlKQlJjYm04?=
 =?utf-8?B?SWtMUG9jOS9NaFhSNXZBMC9yMFJWWUtCeTNpaVpGbVJiTFo0dG5ubmcrdGdB?=
 =?utf-8?B?V0NBclNQdUd2MTlRMTJzR2doSW9rOENsZU5ia3NvRDlhU1B6Q1dpd08wQ081?=
 =?utf-8?B?ajcrSFVBc0k3YWJKZjdpTytTYWFXRk1UampiYVp1RTFZWGJZY3A5ZUtsWFJx?=
 =?utf-8?B?RjNhMVhIN0h4Y21TNUlnLzhjbDBZbGx4R0VWb0krTXlGSUZRYkh2U0pnN1Rq?=
 =?utf-8?B?QnluTjN4bmMyc3FQQVg3MStJVmJJZTNRenRCTC85SWJVeEF1NEJYZS9DVEE1?=
 =?utf-8?B?b1d4VFZvN3VaN205OFdyeUN4cnlaTFdoU3ZOMHV4VU9Gdk5zUWpHdHJKdmth?=
 =?utf-8?B?Q294MU5JWGRZeVpWMXU4dTl2MG41b1JBYWExRmM3WWZuY2FHbjdFSS9DSXdu?=
 =?utf-8?B?aVZTMlpyaDliSE00alRSV1NxUTd1a2NVdHg5MWRScjJSWVFTczNXamg5U1oz?=
 =?utf-8?B?Zm1ha3hwVnhpbSs4YzVPS3EvNDF1dlcwb1lUamFDenR5TG5xV05EZHRiUjlx?=
 =?utf-8?B?eW55T3YzY2hZM0dhZUNkSm83MVVac0hvL0tYWTZvUmNOd2FnbU9OVmh3Wnow?=
 =?utf-8?B?Smp1VGxwNU9PbXREc0ZPbWVCOFAyb1UvY0ROaWtsZ1VWeU1YTjh1MzRET3pK?=
 =?utf-8?B?dUl0M045MWd1VnBOaXJXSFB0YUhMcWZia1pkMzZ0aDI1dGRINnNkeERYQ3hM?=
 =?utf-8?B?QUdNWS9ZSUxjc3NDOWt3UnE0NTNXeCt4U0k2WCtMRE1sekZ3WXU3SVdmMi94?=
 =?utf-8?B?TDE5VFo4bGg2TzA4a1N4eXl1UTJUY1U5WHFnQVBsWEFIM2dhUkIxY2YxV0xj?=
 =?utf-8?B?WCtLQzlIYjVvbHpCdXk5aWM5YlBEWTBXNi9LMDZVVFJWVnhVclIrTGE3SDZz?=
 =?utf-8?B?d2U4cExvcEtOWURBYzRJUHZFbDRIR0JsZExpYjhaMlh1RmNCWGxFWnd4RVh5?=
 =?utf-8?Q?CGo6rKLPlAdhQgO0hDPl34ko6tXJC+YkGw99JDJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGY2QTAxcVdZQXB1WEhzK3FJRGZrNmVuQ09UcXUvR1lwSzZsdkJrQUtVUE1B?=
 =?utf-8?B?UUdlUXFpNy9IZDQ4cSswWE5BNlRHSFN4cm8xYlRBa3I3d0N4TnFUODVFbDVI?=
 =?utf-8?B?aWR6U0Fib2drQnNQamtmSk1JRk80UmVTdTkrL1YxUkxqQkEvQjJPVk1kNkpN?=
 =?utf-8?B?U1l0N2RVL01PQjJjVXkwLzdTTzR6aWhrMHNYNGJXWW9zeENYQUNnMHl1UDZ1?=
 =?utf-8?B?U3l4R01DMHBFTW9tVHVTSCtoZ01aKzZTZEtaRzM5dmNPeDAzR0VqaklSb0cz?=
 =?utf-8?B?VjZreERVb0RkQm9zSVBkck9SVVc2d1BKQ0hIek5NcEZhQlJvQ1R3Vk0yTWUz?=
 =?utf-8?B?M3poWjhWVXBJREJEUmRoS1pma1NsdFVOWmlsWGR4SjZ5NHBQbysxeWxMSkJE?=
 =?utf-8?B?aU81THhXcmtQL1BhQTVyTzMxUm5pdFI3V3JJaC9LMmdnc1lKZjNKcHFuT2sr?=
 =?utf-8?B?MEMyWXkwUUJDLzhwMHJnUllJR1hRTXQ4NFpzd2J4ZVBZa3RGQzdBUkdiTWNv?=
 =?utf-8?B?SUZIaG9LcmlNdnRWcUhyRmJvdUY4VS9NQnlhN1dLSkNLQnY5TTRwL1d4ekpw?=
 =?utf-8?B?Q2QwS1hIL0h0MUZ2enR6U0d4VWt0Q2R4dy9MZDNhWG1nVVVKUWhBdFVJYjFl?=
 =?utf-8?B?SWdVNm54UTcwOXNsNjU2STlrRERzWng0SnhVMXVyRFB0SVdPMFVvM3l4T045?=
 =?utf-8?B?cFlvOFFLemw4ditVNmd0NGJiZW9zUnM4azBLNEhsdG50T3lPMGxGZnlrMlZZ?=
 =?utf-8?B?ZStKR3lvV0JoOXJISG05bDhXMmZzWHNzWUtJQldZK1B0TkNPOEJOYjNMeW5F?=
 =?utf-8?B?TkhXKzlQWWlhb3JyY3RmY2ZBVHJkNCtzQkhXbUdlNUdralBLN2JWUnNEK05F?=
 =?utf-8?B?TURYRFJjZXZsdGhMcVZEcUU4cXVIR1Z0dVAwY0dEY2Q0eFlXSk9zWitlYXpY?=
 =?utf-8?B?TVhyYWFuVE9XK3JDRXRoWUg1ckVXOEUwUTFJWlc3NkxlblVLVTlIOFNPWS9y?=
 =?utf-8?B?RTRvcDVqTHhKN2laNjVFNk9FYWU3ZUZrQlhYQkZqVXJrcmc5dFlxYTZWNGps?=
 =?utf-8?B?Wm5iSkZldkxCWlVrcTlLbjM1UDY4VWVqL3hMVGdHcjBaSlRiUG9NcFUwOGJw?=
 =?utf-8?B?NUsydzVteUc4QTAvSWd1dEhGQ0JWeXF6OHlxek9Bd1lNU00rbFFLUU9hbGtY?=
 =?utf-8?B?UG53QUU4VnJ2LzgwbnAwS0dXdkdTTUl6d0NmOVBvYzRDbno4WmVTUC9YMlpB?=
 =?utf-8?B?VnJyTnZNbDJmbWdTQ1IxWWk1eXkvOVMzeU9aUnl6R0cvYXd2bzJNR0w3MDlx?=
 =?utf-8?B?Q3dmRUhxb0s3R3QzN2RwcHVWaXF4bmh2dFdMbzE3a1RvTVRwd1NSOWNRaG9r?=
 =?utf-8?B?bHVVNThYdjZKV1NIV01oUmIxK3d3SHlCV2JtVlpsazQ5VzVwQkxWU3lJVHhN?=
 =?utf-8?B?dmE4WXpsMXBkeXBCcmNWc0tCWnNFdGp2Ujc5d21ObUdNbWQ3TUhBbXBFTURZ?=
 =?utf-8?B?Qk9TdWRrY2cwVERMTHU0cWVlWFA5NTB6M085akQyeUtOY2ZoVFJrSjZkeEtj?=
 =?utf-8?B?cWV0SXM3NHphb1Q1eUtPUWF6a1RxMW1jd1o3MXBWdDlpRnNyV0NiY3BxMmtC?=
 =?utf-8?B?YWhuRnNPM2t0MWhLYlQ1eWZJWlhNZFpEYWZuK01IL0cvcDQ4RXZiOGtWUFpq?=
 =?utf-8?B?ZkdITkl6QTlLeWo1aUhMenpQblZtaWhESFg4dGdRSVFuSzVGaWQ1d2ZEaEZy?=
 =?utf-8?B?TkhNZVdrMnNhRDdxdFFLQjZwVFZFN1RTNFhLV2pMcHFDbmtCSnI5WUg4TDBa?=
 =?utf-8?B?UGNJRG1VdDU1Y1VrUW9nYWxMQTA4SVhvQ3ZjY3lvdXRaaHFMTzdzTWhlWGdy?=
 =?utf-8?B?d3huM3oxWXhmZ3diWGl6bmlLNnJzNURjZkdyZFhONXlSUmZFVWdJeEV2eDJZ?=
 =?utf-8?B?MUdMYnJOamVOSWFNSTZDcHJBQTRjNytiSTYxVkJtWVdSTEVxUUFwQ2QrQkZU?=
 =?utf-8?B?b2creUVPbEpDM0xsTE1ZU2J3M1UzcXBBd1Z0QmxnaU0zeGlGVklkRk85QnVu?=
 =?utf-8?B?dUdDMFhsVTV2OHg0dThqUHNXd3p0ems3YlRpVWpZUWM5bWc0Wnh4QUtFK2p0?=
 =?utf-8?Q?rKNdbMBv//Sko8SeH0gn16JQ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336402d3-39f0-4c61-8c1f-08dc9097a5c3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:40:17.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWl2dSkApSPohlDiVqE2jMygI+0TfYrj6DOXoaE7aLcTUMWgudXS0eK0Dqpu+RVWXRdFSIm23gKgiPNm2aVJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

On 6/19/2024 04:16, Perry Yuan wrote:
> Add support for the set_boost callback in the active mode driver to
> enable boost control via the cpufreq core. This ensures a consistent
> boost control interface across all pstate modes, including passive
> mode, guided mode, and active mode.
> 
> With this addition, all three pstate modes can support the same boost
> control interface with unique interface and global CPB control. Each
> CPU also supports individual boost control, allowing global CPB to
> change all cores' boost states simultaneously. Specific CPUs can
> update their boost states separately, ensuring all cores' boost
> states are synchronized.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1c2320808ae1..299e52d4b17e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -699,20 +699,11 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>   		return -ENOTSUPP;
>   	}
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_cpu_boost(policy->cpu, state);
> +	mutex_unlock(&amd_pstate_driver_lock);
>   
> -	if (state)
> -		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> -
> -	policy->max = policy->cpuinfo.max_freq;
> -
> -	ret = freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ret < 0 ? ret : 0;
>   }
>   
>   static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
> @@ -1868,6 +1859,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.resume		= amd_pstate_epp_resume,
>   	.update_limits	= amd_pstate_update_limits,
>   	.init_boost	= amd_pstate_init_boost,
> +	.set_boost	= amd_pstate_set_boost,
>   	.name		= "amd-pstate-epp",
>   	.attr		= amd_pstate_epp_attr,
>   };


