Return-Path: <linux-pm+bounces-8969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 816DA904439
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9505B221AC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565227711C;
	Tue, 11 Jun 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dhm+zNm/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD086BFD5;
	Tue, 11 Jun 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132825; cv=fail; b=SUa+Vtk08iAcL4YZjEHXnjyfpJiaM5cTKitxQ6muxF2JQN+U2ypwt5WWWMHELIsz+vA7/IkUySfEBznkGf06QqaT5SF3K0gz2thTtuYmt8P+2HMDhcuhWvfYcYzzhXCHVrOocyg62XWa9I/8GVYJBLEez8uDo5U/aXBvRfYz7uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132825; c=relaxed/simple;
	bh=C/qO4fVYF+aiz9sgrEVlcrJDbvkjC9HTXpzJfqSgmig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QY6yDL0jgnLqb6VawB9kR5qfb8vi1XPLu5x0LkAvwzOPcDpLmpr4SVfwsEV7z8wkwkJyraiSE/CAOqWraVVg2lZ2mweEXlfFjy8ZhHrpLlS3jass3RQz86iDm/MqiSEo0fUZmyJ8aoKQ+olopr6NVL6sQlw+cZdfKxjNq2xNcDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dhm+zNm/; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUS0uPXg3PspnUgsNZ25qCA77KwaeNRBhrCYPdT/pvl+I/3N/LaCsK8KwoTID7wGGKwzgckFcgwA/GoMQvjWaJbenZRJOlPCav3xbqg24XN2/Qkp67e0SVEOGQnD/Thg5EF7QVRczQUTzTkYvPZXU7QA26lnSMPEhOAKPw+OS6Jt1f1cC2zrOEZHnLPXhXDSG2SLfDACw3T3KAVYrpYkoSEO7AZ5kEVBSl/JFiG5lCaYYXwvMH0EU5V67Hg6P7lO7emUAhZ6gz0wlBKKn0hSPJL6diB/VOUBmNpGDSmkacxlfIpBrs1PzBxGzYkmeeHULaw7Uc81ginGFag/8CG8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH4Kb1KbOHjGCpl2ZyJcgXukh9igfsbU3h3M0sIJJDY=;
 b=JZsZvV3fZYA/6MyIFeKzwuSRpeTzRCvtAWfCm49pC/AZxyoSwqosMc63NpRUGuIVOKsmAegJBBtEjgfM9sUNEZJyW6EDgPm1Je9JLy5JLDRfJP/I7H+VOafVlNV6pPhnvjQJM8aV5ygnJUKsPSxKqKNtnxNg+cGUoOw0mB+p521AIkY++6niUg/zytXc3iaq6mWcs3Sof15a6JFWz4FoJZTaAGyLHQ12E4VW1iibGFJAOl/eoC/sYAzrCb1VNLVkgY602aZ7CTF3iZkR1b9UnQgZuxfiXkJNeHC/5pvS30QIqz4aCjS3FYdEX1zFBbekXRP0sscq8a1EJKDkQLZY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH4Kb1KbOHjGCpl2ZyJcgXukh9igfsbU3h3M0sIJJDY=;
 b=dhm+zNm/vjqs5iSprWIqnJTL4umroYap6V0RUSahxL9zfVeeIDxYjvBPuARhgnmECvYZOH9FoR89usoNvolfwtW7NEvD3PO4JL6XzKMTfH8KZyiYKwHro4Ym0pmiXD9AfiF/1wrrphoooQOtqkVboYOhnFnKGHJynd5Mx4LexrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Tue, 11 Jun
 2024 19:07:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:07:00 +0000
Message-ID: <7fb679fb-f043-40e0-9a66-ce8045386135@amd.com>
Date: Tue, 11 Jun 2024 14:06:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] Documentation: PM: amd-pstate: add debugging
 section for driver loading failure
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <18032dece7cb9089bf82f2b37c7ab781148d70be.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <18032dece7cb9089bf82f2b37c7ab781148d70be.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: cc28bd45-9671-4397-ae0c-08dc8a49abf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YklxV0grQUpVTEdNMDVOL1Y5bDlIVFVSUlRXRlFvNmV2aFg2RmtHbWFXU3NN?=
 =?utf-8?B?RlVtemRoMzJVb1lOVXAvellFQTZwWmlzRU1mRm5sOExMcGtPRDFWWHJQM2Zk?=
 =?utf-8?B?WmJya3NxWG1td0ptQjlLVWhHTUszTEI3MmVJemtTM1JDVGU2Y1VDb0kzN1pJ?=
 =?utf-8?B?YllBT0FDaUwwaWZITEc1aGQzakpNME5GSytLS2I4dzdnVjRjdzgrcUxIQ2VW?=
 =?utf-8?B?VTlUZjExZW5tN2lSNnJERmRHaTR1NlArd3gvVm04cjRLekVTWVhLOHNHZnc1?=
 =?utf-8?B?dk50SnJYVjJVN2c1STRyd3RlRmtqSUMyTFlXalBxdUo1Zm9kU050bWg0VGpx?=
 =?utf-8?B?aTQxUTV4emFhUFFjeHhwaWxPWkpkRksvSGtmZXJTRnBGK0Z2cXJKN3NpSDdu?=
 =?utf-8?B?SVMwR2NJV0dIVHMzRVNXdk5pRDdlRUFobCtUaE5ycE9TS29GalpDT2ZKNXVP?=
 =?utf-8?B?Q1lJdXFpSEJBUGlaWjJHR3lJMXNIb2VjV3lzM2lDM0Z6c3JRNEZFYWVNeVdv?=
 =?utf-8?B?RXIrNWZJSTJIcEc5NnVZWlIxT0QyZ01QWXJHS2FncVZrQnZncFhPenI2Z0NN?=
 =?utf-8?B?UXh6UDZOVlhvY0pQRmVmOUg4VG1TU3VPUjAvRzgxbzNDMHVSdDBOUmNPNjg1?=
 =?utf-8?B?N1hwMWJXQ25Rek83Z2Q1NWpkakNlam84cDB0RUxDazV2bHRubzI4V2twMHhF?=
 =?utf-8?B?N1lBK09JbjVMbjlZQjlJNjdvL2s3RXpaeDdTekJ3RnpXTG1UL0dIdklSOUhK?=
 =?utf-8?B?a1VJTUQ2dklOSXJOSUFFV2M4V0FPWXM0cXROWnNBck5KWkRBai84YkVRRHZL?=
 =?utf-8?B?V0IwUG01MjZqVVdPZEJtbEduZExQSHFJWS9zT250MWVpbHNWWk12UzZtdUM4?=
 =?utf-8?B?MUREWmFybU15TllpWDMxcDNPN2xhS21tUUVocHVlU09WaXk5amtQQXZNT29l?=
 =?utf-8?B?RjI1RHhoNVdNM2hjbWw1VHpCbDFoejZtRTYzcUQ1RytGMkd2S1J2aThBQVZW?=
 =?utf-8?B?b3FYZzJJNXlFZkp1ZFZXTTNlckswaHFyNXFxQkFKV0xvbUJVMnRZeGhLWm9j?=
 =?utf-8?B?Qy9oUWlOOWFrVnpYSmcvWXFEZkFyZkdidkx3anRXR0lDTzd6Tm02eW5BV3kr?=
 =?utf-8?B?MEVpRXpvNld0UGdtOGY0Rk1adUF3TTNhRTVxMmRxVG5MWCszajd2U3g4dGc2?=
 =?utf-8?B?ZDdMc3A2LzJPOHdZS0p5YXk4bzY0Q2FVOUhuYnNnWlN0MzNGWHgyQWVHak1q?=
 =?utf-8?B?ZDF0VjNMMllRTis4NlErTVJLakVpdG13NFpxK08yY0h2OHBUa0RLT1VSTVkx?=
 =?utf-8?B?QUwzV1hYa1pza2VWVTNCSXFGS0IwWTVVb09GTDF1cE9xKy9QaGxGUHFRUXBk?=
 =?utf-8?B?VkFKdFJpaVhUcHplekhraTNCSGxIOGoyVmlVSUVWUU42a3BoUkZhVWo3Vm9S?=
 =?utf-8?B?ZUNid05WZ2xqK0ZxZVhwM0t1T1FpaVpUSXJaMzJwalVZcTlpdlZMSEszUDZS?=
 =?utf-8?B?OWZaRWJrK3BVTGlMVVhueE1udU5PZzVmamYrZlJlYkYwWHlDankxQ0hIdVo4?=
 =?utf-8?B?Wm9LU2RKd3MrRkxUdVpBN2dRTFprNCtmblkzMFI1ajJSaFNIYy8vZ2tDZXIv?=
 =?utf-8?B?U3E2NWI4RG50VjA5S0I5RXRSTTBmM0N4SXVISTFiYXJ5UFA0N3pra21TVWM1?=
 =?utf-8?B?ekl6d0FXNVh5cnJtOVAzdXZEQmpOOXF5RUU5MkJ4bGZMYko3ZDdsNmxaTU05?=
 =?utf-8?Q?AiV1ynjLYT+4orNIhCeIjs+APRkRHn8wuPCmd29?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1o2OFFBZDBYcDhpTHpNUjBva1ZvbjlJM3dLSTFwektENzJoN0FFaVZIakQ4?=
 =?utf-8?B?Y1NTZWZ4aEpJYTFLQW9VaDFiazJUU0RUeE9QdzZOREN0V3ZMc0xXd0pXbVVK?=
 =?utf-8?B?emVyS1BXRTA4eVFYY1hHRnVwR2ViTEZnMHhlZkdBTHJuckZ0RHZTcFZqa3Bs?=
 =?utf-8?B?czV5R1dRazB3Y3BrVGFDS0FFbHNVSDBxSUhGK29WMmxMbWp2cURiVTE0QmZI?=
 =?utf-8?B?QitNODdvQjZ6andaVWhDYWZ3MGJBb1JRUjFLTmFkUjFsaXBUYjU4OFlVcGNF?=
 =?utf-8?B?bTgwOFFSSXlwdVR6aFZVNnY2Skxad3Fld2dGQ2dhMExhYWowVDczT3R3RUxz?=
 =?utf-8?B?ZCt4cWtVTllXcDFPVzNCMG5FRE1NUTJ2NkUzTWpaZkRLeUNUdHZyNjhDbHlF?=
 =?utf-8?B?Skl4UXVjc2lRQlpZN3VEQmFvbE9JMkhhOWtsemY2cG5jbEx5dDh6ckV0R0Yz?=
 =?utf-8?B?aUhTUW11UjhycE9FaW5GekllSXFXU0g0UXlEQjFQVDJWMENNbzc3ZHZFS3I0?=
 =?utf-8?B?SVg2MmVoZ1krblNvNnZXZndOU21rWkwrcGpGQnFJU0ltZEE1U09aWXBYWC9x?=
 =?utf-8?B?dFY5VTNQbkFFaVA1VDFVR0dWeTdDSUJVTDBxY2dSd3VGV1g5RFB5b2w0N0U5?=
 =?utf-8?B?bUNUbjZrcUdKOVQ2RTlwSldxeHQrelZMYnF4SWRSY1BTNysxK2N2MnhqVUZU?=
 =?utf-8?B?bUp6SHRKbDYrRVMvNDVsei9ONit1QVlod0JyeHMrL0lDKzcxTjlJdklOVHlU?=
 =?utf-8?B?WS9wZzg2QW5md2lMQUNxWUl3NGlGZnZEa1NMM1dmV0xWT3pCYUZNRG1zbk9L?=
 =?utf-8?B?bEw3dzFqYVlCNitBWlEyWXFiTUFxOGZNZWRzR1hiSGlyTTJ1M1IvQys5dDZD?=
 =?utf-8?B?K0NqTWEyenNiVDBra0RtVHB2c1oxaUN2OHNKUEsrd1pud2YzSGNCMG9tcm5R?=
 =?utf-8?B?VFlmazBRRnRGaEhSa21XZFdZaWdiMGRna2FLb2RSdG5heUpkNFZLMFVmTXhm?=
 =?utf-8?B?K1BxbFNtekVsbVJBTFVhZkpVNFlXRkhld2JzcjdQNi9iTk1yRW94TVp2ZDZL?=
 =?utf-8?B?REUvL0pkVXh3ajRCUUlVbXRrcVQ0NE1iWElkOGUrWEh6VXVDZTlhRURxVzJF?=
 =?utf-8?B?VmVHcm8xbGgvZHYzRTdqM1UzbU8wT2RXN2xXMjRaTmI4VUE1UjIvTGl6Q2tZ?=
 =?utf-8?B?VlBIZGl2NHh0NTNLZjI5NXh0ZzhLa1pLTWYwQXdYcWRCZnAycmlxTnl0dnQv?=
 =?utf-8?B?U0dVSnRPNWxnQ1prd3lMbVRCcGhCSmFQYWRwOXUrOFdHTFJTdFlaQmhlaTV4?=
 =?utf-8?B?UHRzSGtvcHZMR2dlTVkrL3FLaEhHbmxzNTVpL2Y3SmpyWjZ3bTBlZGlBOVQ2?=
 =?utf-8?B?RWJ4eFo1UHVRQ09CbitUdnNpNWdObkNtOFhBdnZDcjVlaVNFQ0pyejhJbnJF?=
 =?utf-8?B?SWtVQk9PNHlrNjcwbEpZdWFUVjdmK3M0U2JMdmM1LzF4RGlJSFZRTmgrNlJQ?=
 =?utf-8?B?L3pNZHRoTWJCTkRZZTdTbGhLM1ZOUi9ZdGllTlZ4THlOTURLdkppQW54djNR?=
 =?utf-8?B?VkVESkZ0Wnd0R0ZkczB5aWxnUnpzdkIyNldKcUk4NzBCZDFTQmtRaUF3enBp?=
 =?utf-8?B?U3BTUGZaT1lTRTNTRis1Y281dHQ4T0txalptSmVvYTRNMDltRWcrZEdXaXJR?=
 =?utf-8?B?a0M3ZW0zengzOWhEMFZSK0pEMklmNmNKNWVhZHVWZXF0Z1pTemtlMmlianQx?=
 =?utf-8?B?Qi84cXZwMllSalhldE1YNS9kQ3VWczhhM0tHV3FQQ2RvZmRCUmdJdG04ZStH?=
 =?utf-8?B?UHZXVjZ4aWRNbndVZTVRTG5JYi8rRUhFVDJmL25FMEdvUml6SitxUHJoNEJV?=
 =?utf-8?B?UUlzV0s0aG4xSERQc0tZMVdXMlViSFA3V0MrQTR1cHJZaHF1cDU2b3pWYlhj?=
 =?utf-8?B?Rzd4ektQeUkxZ1VMZzNoQjlvdjYycWZQWG5LajJWMExETjBLYTlIcXhyeUNm?=
 =?utf-8?B?Y3ZHWDdpbzQ1TW1jM2ZESTBKM0pLS3phS1lGclN6TmY0YkQ2Q3BRQTRFdG9R?=
 =?utf-8?B?ZmhIY1R0MDRFZUFUZGpRbmNZcTVnQTVlT3pvU0U4STBUTEJBOEwrcDQ4dXk0?=
 =?utf-8?Q?b+/WvQucpP5F5tHyL0N2F66+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc28bd45-9671-4397-ae0c-08dc8a49abf5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:07:00.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po9XjjGNPhROtjXa98lOBPdn4cxeNW9MJ4wyD02wzKVE0VB7jbz6GRzB7GKtQ2Il0wJM74pJsb32vvTjxYR8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

On 6/11/2024 03:52, Perry Yuan wrote:
> To address issues with the loading of the amd-pstate driver on certain platforms,
> It needs to enable dynamic debugging to capture debug messages during the driver
> loading process. By adding "amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  loglevel=4 debug
> amd_pstate=active" to the kernel command line, driver debug logging is enabled.

Here's some suggestion for text.

"
On some platforms if amd-pstate fails to load or operate properly users 
will need to turn on extra debugging messages.
"

However - I would argue that the messages are the wrong level if they 
need debugging messages turned on when it fails to load.

Something causing a failure to load should be pr_warn() or pr_notice()
IMO.

> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1e0d101b020a..de83e742738e 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -472,6 +472,19 @@ operations for the new ``amd-pstate`` module with this tool. ::
>   Diagnostics and Tuning
>   =======================
>   
> +Debugging AMD P-State Driver Loading Issues
> +------------------------------------------
> +
> +On some platforms, there may be issues with the loading of the amd-pstate driver.

This makes it sound like it's by design.  Of course it isn't by design, 
so I would instead say:

"If the amd-pstate driver fails to load, additional debug information 
may be necessary."

> +To capture debug messages for issue analysis, users can add below parameter,
> +"amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p debug"
> +to the kernel command line. This will enable dynamic debugging and allow better
> +analysis and troubleshooting of the driver loading process.
> +
> +Please note that adding this parameter will only enable debug logging during the
> +driver loading phase and may affect system behavior. Use this option with caution
> +and only for debugging purposes.
> +
>   Trace Events
>   --------------
>   


