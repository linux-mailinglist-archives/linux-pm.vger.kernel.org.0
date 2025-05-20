Return-Path: <linux-pm+bounces-27401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045FABD3EF
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 11:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AAD17D629
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93732268C69;
	Tue, 20 May 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Unn5tbsg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974920E6E2;
	Tue, 20 May 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734818; cv=fail; b=vGOCAKlloUYGkAg57kOVswbwJ/8G/q5JbhfNZy9aA2bh63SbkbFcmoIC+vq9I7TReaWVvr9dvFRNCcEXKueaEtuZGH92etb7yvTvG4xAmJkMlByOjwQWBt4GGjC2tAcQwePV5tgLmmtXipRXcnWoEtgt+I+pOvIG7dUfRRq4aUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734818; c=relaxed/simple;
	bh=tZoCCv+rAqj1oQRLBflaIVTr1WbUJAbOIgZ+xOGdn2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tIrH84cSCXPLYuSsX2O2KUOE+6CfWd6Pe8Nwej6B0Vrvv8994PfuIriTf/b/IvOa5qqhnICS5KqhM3/X80OhItTGjVF5EcrBZp6m2zjzPahJo2nO0XIfh1QEuAEUHZ/OTj4BTruyhoqZgh8C+XHS3cLBY42LA12Q8GbixLUuek8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Unn5tbsg; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NskF7qACGfHeQ9YfnsiJDg+uM5DAy6TXsHjO2QDL8EnekthBT0bkEj0bJUQjNZadrVJ9uENQ8JuXRrUjcuOkrD3X+AzLbQ/eogdRR2p8ONXjIWTBpMjoBdkiu9Tl+2laZQDIytQ1cxm/RjvBPCtnBqu8ETNMOUJg4A1Dr+inbvKrUjOJLsl+VYGU/LVUB0i5rz2q7S0Mgd1O7Kyt9IbB63UbI9cJmoSFxaj3XNRg3W0HBvjMmoESIS6B7eXs6VOoJbIOjvbsy3QGSUh2phVW3wn+CS5RLb10LrLAO2odk6dW/dshaI1YPo5Ev8PutVsd7fAw8FA6MLCbxD5ut/M6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYH91N/ZPXmJcCZDbP0cXpGK43/Ly9je2uTKuerSv6s=;
 b=w5ZM5zhNDs+KhMYRPZ29hwoigkaGCc0k6lw1bYHFNxCr++VS/YUr8yHEdziq0L3tnKU6P3Jak7UIOIigHnz9ZNoy+6Gnke46WzYjYIOTHf95FJAQWm+imAnE2MfDsC7+rnRN+21u1Y0Yr82G0JUjFh6aZoFI9UC8ryDFdCJOrcXIK66n67gs+8Mx9OHrWOLHcEacuhLQ4okctxale0jwClW9318eIBJQJ6W0aWIXCOyKklGt0cuydRTOqHV/dZtgJPQQbjXV1/F7j1nerrSNLZeI75+L3ECZI0Rx5CQzPsHjwcDc/jbSPzrFU55LvaT6d6ORlQLgZKl0ELiT1BIPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYH91N/ZPXmJcCZDbP0cXpGK43/Ly9je2uTKuerSv6s=;
 b=Unn5tbsgBXZ/MDGhMKCCzIVhGJc+mRkdNnoIKzK6+JNbL61+KVFGmLlIef+cMSkqliJEmoueWccE1ZKogUPsueZJgiOppWr1qQcm+3C6bSwDBZkqOlMMka0MCthx89k+a+KXlOSWbtSMVcHvXv3j/+8BT/2TFmBAsgyp4QzJV157n0v5W0CGfuNFaFiZYCz+VXPQTT2Uwa0dy+t7DouBWvMiR/8y++/eMirtSfJRyNHTSUs6/mew5Z7gHzdYtAmqjEFDEEQtXboUi2BElR2MYhc+22WZvdyifIw72HONCjHYxUZf8Sk3BFfBzZtgjL2B16cGgtYgRZZ6oThXIBX0HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 09:53:34 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:53:34 +0000
Message-ID: <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
Date: Tue, 20 May 2025 10:53:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
 <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250519101725.k644wzizjwygtwa7@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: eebebc1f-1c9b-41eb-5477-08dd97842f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmc5WTFialRZMmhNRHJDTXBOcFVMb0ZvWW43UTA1NHpRSjNXSmlKT2N1SGFm?=
 =?utf-8?B?WExJRlRTU3I4bys1ZktEUHI5dU1Lbk5FMFdRS25wenBJTk4rVXZKd1UxWlc1?=
 =?utf-8?B?cDlqbjl3Z2FySU4rYmpNSlAvY1BTMFdpU3RTckNGWWhENGlIa1c1TlVwVnBT?=
 =?utf-8?B?d3grbDA4U0RLaUthM1YxcGkxcVc5eEI4T2w3SU82Y2J5K2RuUzhVSy9iZ3px?=
 =?utf-8?B?QWNlbWFrbFFwNko2cEVCMm9XNzJNd0NoY3VlZmJ1a3dlYjFObjdWWGVkVi9M?=
 =?utf-8?B?RWVYenQ0QzJzZ1BhN1lMV2dveUlJZzQvcWliL1NOL2htR1hhbTVqYm44VUZE?=
 =?utf-8?B?QWZzS0ZLR0JxUllMbmY1MzNGK1JUVnRac0xxdmJZb0txT3ZxMm9RODY0QjhB?=
 =?utf-8?B?SWxneFA1OTUxUjFrR056cFNlLzE5bU5ZN1N4MU1tWk94Mk43Q0RJbmlRR3Vt?=
 =?utf-8?B?U3puODFIZU9RMUUwa0ZJKzdzWjMxWVUyYUU4TlJmNUxZcDcxN1QzWDJIaTRY?=
 =?utf-8?B?Y0pMU20zOHczN2VBdGgzRHduc1J0VjI5L0l3eEh6bVhLRkVCNmE3ZWQ4TWZD?=
 =?utf-8?B?clRIaGhSbERTajlxK1NMWWU1S0YwR1NUVFFKQ2lONEM3NXVRYWU5T05VWm1a?=
 =?utf-8?B?eXZYWk5mUGtFMG0rQ0hTdUc0aWZwbjdOUkNjTm8zUGp5NUVnbm5PekY4Szkr?=
 =?utf-8?B?RHQ0WHFhNFFsUUpZeUZHYzhtQ0Z0cm5GNkpZOW9SVko3MnBrOUVPc3dNRkJG?=
 =?utf-8?B?VlhhZVdrdi9zMzdJQ1IzM3gxOHBPbGxTTC85OXJSWUNWRW9kVzEzZzVMdXNL?=
 =?utf-8?B?WjhDenU1c2haVGEzTVM2am9zV0xaSzNIZHF1RFp4NkExc3UvVEZ0SG9QU0pO?=
 =?utf-8?B?SmlJSHovRjdONTM0RWR6Vi9vajRhU2tOeUFCWEVaSWhSS0NaazBQcDVUaEZP?=
 =?utf-8?B?dWY2NGhURnR6ZUIwMmlWUTZNcTErWWhlMTdaZFF4Z3poaVVBOENDUlJIT0Zs?=
 =?utf-8?B?V01MUlRBWDhvbDgzRnVxQVdRL3JhZ2xtenpSUWdtVmdyS2JlbThrVDVQcjZU?=
 =?utf-8?B?SDcyRDc5QmZIVXZFVzVnUTdpVy9obFhHaFcydjBxcjdZQ1RhVTgyRitWRTUr?=
 =?utf-8?B?UTBEN1pVS0dwMVV4WUJYSFptLzY1WmRQU0QrMHRCWklRWm5lL1ZPOWY1UXNL?=
 =?utf-8?B?SGZSY1RaTG8xeGR5anIzc015T3l4aDQzVU1EVDh4RyswNE9USCtDS1krdWFD?=
 =?utf-8?B?SmhGLy9Sa2hHTXBIcXlTemQ4ZzlGU0lyZUZKazJXYi9pN2wvYWlYWkcvOE1J?=
 =?utf-8?B?QlBsRllzTE9NK0VzWDhJMHJBUUFiUzd0dEJ2ZlZKUjVaRWw2czhva2NDdVYx?=
 =?utf-8?B?ZDBvVHExVmh0WU5wN29DbW0yajRaSTVjVlhkN28zWmlYWi9TdE8zeWlsMm53?=
 =?utf-8?B?VWhNRDJ1L2pBN0NTaVRCd0RuWlJyOUM3My83VUJLRHVNZ01nek1zTUJnd0FC?=
 =?utf-8?B?ZE1kOFJxd2hKRnplb29tZW85NWhYZEFiOUUyQnkyT1d2ZTV3T0N5WktXTFFa?=
 =?utf-8?B?VWtjWVRCOGdhcWN2bUdOa1pwRmd4QS84SGpacFRUQjBVK2RVOUZXRWRmNFlY?=
 =?utf-8?B?VUUyLy9GSjREUE9aZEJwYU4rQk0zQmRlR0p3Q1hnQ2NWRG81MXU2UlVkYndV?=
 =?utf-8?B?R1Y0cnFiR0MvY0hKVlV2UzFoUFFvZzRmNGlka0JpN0wxaHFQcXRPNC9jT1RX?=
 =?utf-8?B?cFJkNkh6Z3N1UnRiYUVPck1ZY0owbC9ER0FLQnNUOGNTaXZYeGpSd1RnR0ZX?=
 =?utf-8?B?MWpicVpJK3RmYmlIMHdKc053REZjMklmdy9VanFmSzVuekd2Nkh5aE15ZW9V?=
 =?utf-8?B?Y0R2c0JvQS8xUXpTMTFYM3N5b093Y0MvYnZKUG9lWkdrQ3Z1YW9Tc05qbE15?=
 =?utf-8?Q?UHLb7Ib8W3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzZzYytRZGwrK0JMUDVvZzlTN2M4VllFSmVsMldnNFQ5Vnc5em5hM1o5eHdt?=
 =?utf-8?B?Vm1IcHJNSW9sYjZhZlZ6Z0xQMEViV2NZQnhUYlpyT1BVTk5mbldxdCtkM2Nt?=
 =?utf-8?B?elpraGtFbnZaYVppZkErOWVHcVlWU3lURGhMSUN5UFZKZVJMdUg2YUZ4LzE2?=
 =?utf-8?B?N3JkRXBPV2hhc1U1ZVhsL2tZL3pKd0RlZWFtbjFjUmR6SXhKNnY0dEdNM2xZ?=
 =?utf-8?B?QTJjcmNWb211Ujk0WE9uZXdsK2p5S3cva0g5aGRnYWk1dzZVeHlHdmFKeVN6?=
 =?utf-8?B?UkVZMFVBcGx1UTlLN1RGcXFrcUs1b1EyL1NDRTZNc2hnb2tFRWsyVnYrY3JC?=
 =?utf-8?B?M1E5SXJWaXVaRkdEcVlHdjNrcDVSSVJNano3NHRoL01Fa2NFTnZ4S3lRQ0Y1?=
 =?utf-8?B?NjVjMWxnaWNqSjIxUVRsY29ERXBpYXVWc2ZFSzRlY0tqcDF0T3FvdThCenVs?=
 =?utf-8?B?Z0l6elJUdE1xWmhXQVN1Sy8rRmdLOGRiWW5hQTdHQXp2aUJPYXlXbllnN3VD?=
 =?utf-8?B?bVQyZVJiMDUvMGpsNHQrcjRaenVxWHJOUEhTdStLZFZwb0dBaW1BUmtWOTJQ?=
 =?utf-8?B?LzNKRGJkdDVTbEZaNjRZbVNub2dyL1ltdHFiZlNXUjhqdjluS2VHaDg2TzBn?=
 =?utf-8?B?cVJFTnpWZEF0Vmkza2w2bUwrRHBVMjRYQjl0NGxSUStCZVpzYWRNUTJCUyti?=
 =?utf-8?B?QnRuM3R6YmVYcDcvaDNwVmFKcEtDUHFvQTVmanBPaDFQazYwTm1ETTdiTVRJ?=
 =?utf-8?B?ZVVKSlhvNGE0dmdwdDBYNUg5RjBqbHJlOGViMGZ3MGYram9XWXNrTEpGSmJC?=
 =?utf-8?B?YkNaUU5WRWl4c2wvL1I4bTFvVEdJYlAwaExpdEs4ekgwYTdIMEVhaEdVSHJE?=
 =?utf-8?B?clV1cVMxVUJER3dEdSsxeExaMjBhOFA0VzI5NWZZQVpzOCt5Z2N5Y1N2YmlV?=
 =?utf-8?B?QWVNcmQ5a3B2eVM2VFVNZkp1OXZTU1VybVM5elV4NFJaOUZ3b00wdmJ4Rkth?=
 =?utf-8?B?eSt2d0VFOHhmR2MzV2gyZ1RIdGtuRXdoRCtWekUrckI3ejY5SEN2a01Hc2lm?=
 =?utf-8?B?Q3NKdHRVQnczS2ZiTjZwbkhHOS9GaDgwKzhLQjZLMWxvVmkyU2xxSGZiSVFB?=
 =?utf-8?B?K2owQXV0V0tZT2VmZVBvV3RncWhueEpKY0tWc2VsaDhIeGFQV1FDTDlaR1kr?=
 =?utf-8?B?MkF1djNVclVkaDVCVGlCTkE5eTdzU0Q4aHNCVGRibWFsMjcvUnlIOEdUOTVt?=
 =?utf-8?B?dUZSa1NvaHNqckFIc2RLUzI3SmpGUWtZMXRSUDczVCtKdldqQ20xS1FrV09N?=
 =?utf-8?B?aVBSWHdNNVdsTm9jellqZW16bWJIWGlVUmgxcWtBSHR3dlZPWDhSOVRPYmlZ?=
 =?utf-8?B?M3hRTTM0Ry9YN1ZlNGs1b1hLc21SblF0OFFWei9SNUdNZ3pRbEc0bE82WElC?=
 =?utf-8?B?Sko1VHpTTGtUVi9KNkJMeTFJdWd5R1hCdFJqV3U0MU9tSTlLYkY5UWN3Yk9N?=
 =?utf-8?B?bkZZUVRsVlZaemlUZE8xVmJld25YUFF5a3dkekpDa1lPTVlvWC84ckI2NWRG?=
 =?utf-8?B?MVhKZVRiOHUvdVpoWjEzejdBSTl3ZHZ0SzhueW1tYWNDRnRRM09Wd3lGNGlC?=
 =?utf-8?B?WHNNR0w2aGlOdjZMVlhjY29NZXJieEhFZ1NrbGdIeE9jaG1DcDBzVUtVeGdp?=
 =?utf-8?B?VGc5NWgzQ290K2VMQWFZYkR3WUdYck5RRzVTQ094WWVDUCttNGtlb0oyMWJm?=
 =?utf-8?B?RHJFVFU0Um5ndk45Z3Y2cnVwRmFvL09leXNRbkxDMHZHNlZBWktnTW9MQk5j?=
 =?utf-8?B?THJkY01YRDF5NkJpZU9ISDcrZi9Qck9WNS9DZ2dHZWpnV0d6dGgyOFEwRTVj?=
 =?utf-8?B?YUZFMmpZc1dvdm5lNGx4UFpMVlR5UCs2RlJ3cGRob1BPWHAzbERFT3NWOXR1?=
 =?utf-8?B?eXFDbDd0d0VZL0R1ZGJ6amJ4TkZ5VzNFa2s5TlQ2YStOY0pHVkZkalRiTVpm?=
 =?utf-8?B?dnd1czdtQWk3dkJHS1BwTjdXSytRSFZnMy8vdkFWVlQwOTZIdGltOHRYLy9n?=
 =?utf-8?B?VE5HTkdtV2ZLYlpFN2pRcnFPNXVUcW9EVXVZWVhlZWlRVm1mY1FXNXAzMlhH?=
 =?utf-8?B?RkRrdEx6OG9IOEFQMmZRYURMdWNCRGt1VVN5NVI5Y3cyU0dVVUNZWm1saWwr?=
 =?utf-8?B?STY3dkwwek40NUNxR083QkhLelZmQ2daazhrdUF3bS9MZDVaenBxTGhPa2kw?=
 =?utf-8?B?VDFSQk5ZR1JLRTlBSWZia3dCWXlBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebebc1f-1c9b-41eb-5477-08dd97842f2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 09:53:34.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG4ClFFBFkD7Vw4ARJ/M0Ie141z0iICKdXtCBRN102YxBgCBSCbjn90AmjLkPt6uuyzpWZN73i8xg9fw7iA7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205


On 19/05/2025 11:17, Viresh Kumar wrote:
> On 09-05-25, 12:04, Jon Hunter wrote:
>>> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
>>> index 514146d98bca2d8aa59980a14dff3487cd8045f6..bc0691e8971f9454def37f489e4a3e244100b9f4 100644
>>> --- a/drivers/cpufreq/tegra124-cpufreq.c
>>> +++ b/drivers/cpufreq/tegra124-cpufreq.c
>>> @@ -168,7 +168,10 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
>>>    disable_dfll:
>>>    	clk_disable_unprepare(priv->dfll_clk);
>>>    disable_cpufreq:
>>> -	disable_cpufreq();
>>> +	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
>>> +		platform_device_unregister(priv->cpufreq_dt_pdev);
>>> +		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
>>> +	}
>>
>> So you are proposing to unregister the device in resume? That seems odd. I
>> see there is no remove for this driver, but I really don't see the value in
>> this.
> 
> This is the failure path and the driver is trying to disable itself
> here. Instead of using the disable_cpufreq() (which isn't designed for
> this usecase), I suggested removing the device itself as the driver
> will be unusable after this anyway.


I understand, but this seems odd. It would be odd that the device may 
just disappear after resuming from suspend if it fails to resume. I have 
not seen this done for other drivers that fail to resume. Presumably 
this is not the only CPU Freq driver that could fail to resume either?

It makes the code messy because now we have more than one place where 
the device could be unregistered.

Jon

-- 
nvpublic


