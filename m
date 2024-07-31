Return-Path: <linux-pm+bounces-11733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11415942553
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 06:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D9C1C2173C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015218EA2;
	Wed, 31 Jul 2024 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZBW5UWTx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DC17BCC;
	Wed, 31 Jul 2024 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399681; cv=fail; b=efRY9qgDUdzNH5npDhlzNWXTJhdTFJNJk8rBuHPHsTn/cHHAiyPLkgVmWMheRF8mDWz6is6vX6QhIHA7sOBsKtF6UsTNsOWXnsFadf8TuAH2q8HUBANg3zkCdURAZrkpJgnq152HnTBdYbZiBKeo9xRaiAdDHae9g54qY9nI4fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399681; c=relaxed/simple;
	bh=EZwkIAVCmxm2kDGdR2bkG5Nc9I8LYlhzVQ0RyR6wo0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZ2Rw1KzBw0lW9K8DxDnk18LINt7ycGNtDMjvt9U0b3HBHLVaKMlfRrNg1z9MLkVU7P/DuMDPG+LO5aMQIWNL6pWwOXFlYGkVS6XC8dGF7IKnuu/oVAc+kdlRKDaQIv1zT8XtTSilu8RazoC8Sr/JqQOK05/4ZRVnC8HKQnazLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZBW5UWTx; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euRPoLlnu6FGc9J7nNQBhi+NGcwKMD0mIs+J32un86ztCqJNzs+lKmCijZckNFxO+MhT/ZUf0zmaG+w2RoM2uk1fpEH0ZQaf+BFbohpNss/dE4be4lrGGxQvL3y7KGswDy5d0DOGisIDPWt3Kn0sOIYLcMz0C5EREj2S35nCEJ2sfmQr90LtmuVo+uFqWVdGltUPp9YraVxKFVNS7buWdICcPmkHWqpT5sH2tBzG9pkGtshFM84BKdaIqnT+zxGp7I4H12MGy7WSU5PSeF/im0JE1etkkRGNZ1cGszRwi6yXZEMKp2aJAwu8wLfYbtzcu5VqbzYu+3xyH0xLj5AYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sophfbIB+rlu7JM/8TLxako2u+xhIyjhkrUEsDPtKOU=;
 b=OFD5i397WGbc1sjdg2+aLHFDasqIhl44WskuIfz/bKiiqx4E54ujzeJRQXfLjfJb/Ddzgk4PRAO8V9HNCyribcnr+gKocmAxIn22Sj7cNDGFk0UFH6N1kNVLGsqVeHDvxpQI935ZlthVRAiaazH3AlX/DkVFSl1kY2jURXWN/BZnJ2q7s400ZWWzsHr/hB+miEeTptz3qBQFSBKYSaM8axmexpTrx9ZjBYvb7VmKfkTgbXpMOulp55iCHOQJqxKdJ5Mbm1Z+Txm5zv4eBoqwbdM34wAtv2R+cMFGR5/oiO7DpR+2tSio/J7bWQSGfH+liPr6htltJLUQ2npYmYmkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sophfbIB+rlu7JM/8TLxako2u+xhIyjhkrUEsDPtKOU=;
 b=ZBW5UWTxD7rPBdJR6I4L9/MC2Yiq8HeXCAGn+lFncIe2QKj6x64mvA9TNb1lRviezCAyftc6hzPLPa9s1Jv7+RZZ/TnVeYOog/iNmU6kBOFUNWVshu5hKEX5AHPoB7s9VQUKinkq2Lof+mqeu109FCotAK+rChDgltSFipOAT98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 04:21:16 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 04:21:15 +0000
Message-ID: <7e2275d5-19dc-555e-e8e1-ed79b408c0e3@amd.com>
Date: Wed, 31 Jul 2024 12:21:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
Content-Language: en-US
To: David Wang <00107082@163.com>
Cc: perry.yuan@amd.com, Alexander.Deucher@amd.com, Li.Meng@amd.com,
 Mario.Limonciello@amd.com, Xiaojian.Du@amd.com, Xinmei.Huang@amd.com,
 gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
References: <20240730140111.4491-1-00107082@163.com>
 <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
 <2c2569aa.47a.191062d0d40.Coremail.00107082@163.com>
 <9c229562-06f8-fad8-8f3d-a236733ce699@amd.com>
 <51a44058.3913.19106dea781.Coremail.00107082@163.com>
From: Xiaojian Du <xiaojidu@amd.com>
In-Reply-To: <51a44058.3913.19106dea781.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To CH0PR12MB5123.namprd12.prod.outlook.com
 (2603:10b6:610:be::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e96689-995f-4d9a-9266-08dcb1183778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0kxTDgxbVhuTVJYM2J5Mk9OVmlTc2tLV0h3b3pwbUhVYlRRaXhVRWxpLzZi?=
 =?utf-8?B?K3kvZXRmcWI5aGZ4aE55cEdwdjFZbW1rb3JMSU9iQTl4YmI3aTU2NStISmNK?=
 =?utf-8?B?anJDL0JnSExPM2JjVmJvcUtWSjRmeDBDemNNRnpPb2dnbGdFSXNFZjEvZmth?=
 =?utf-8?B?YnZFdXF3d0NrUU1jZ0ZWUzVuN0dhNE5YV3J1ZDhONmtCZE9yRGk1U2FnRlRq?=
 =?utf-8?B?V3JaWHJvekxkSkZidXM1Mmc5di95UEVCMnBxeWtsaFJNeTA4MEZLMkV2TEZH?=
 =?utf-8?B?ZHY0cHRVZHZFaXl0UGJmTVVxb2YzVnk0NFNPeVdWUitBbmo1V3liQzlTYXR1?=
 =?utf-8?B?Y1Z2QXRxWWdjRG5ZYXZPMi8yU25aSElSYkhmTk56QmUxOGNBM0NXYzE0dmwy?=
 =?utf-8?B?Qnl1VWY1NWlMSmw2Qm9SYXRpSmhiZWIzajZpc3JDTjlZdnJSK1ZRQnRoUEEy?=
 =?utf-8?B?eFVab1pGSStDWlhoa3hkajVNZlh4ZmpaMGE1bm5WVHpTc3A4cG5sNEdIR3kz?=
 =?utf-8?B?RG52RXVnb3h5c3RyV0lNalZ2cWVNa1VkeXZOUmo3Um5FckEvcHVBU2kzckRy?=
 =?utf-8?B?QUtpMDlZM2czTzhjbWVLczlpaHpGUEtadXNrZFNNdlI3czNLbVdYTlVSTnRt?=
 =?utf-8?B?STNmOGlwTFdvbXgzRlM4V2IzbDRFME0xOWFiUDIwak14QzlVdmRwUk9TQzlV?=
 =?utf-8?B?b0VGSWI4OWVvbEFndWdUY2k4STFRNGlPWTRmM0w3QSswYWpVMmZvWXdwdjk2?=
 =?utf-8?B?S0wwZjYya2k1L2J3YWxPb29GUkh2VTdWRlpyNVNITFBmL1BpRS9lVFQyejJt?=
 =?utf-8?B?eFhvMU4wajNYNlRjTmdhRHI2bHpndXVvM1pGL2hyNFFGVTArYVVqUzQxL0d0?=
 =?utf-8?B?MEhqanlWUWtBcnUzWlRiUmFFZzJxd1JSSVZIR2FsRjFoOUQ0cXFtazB2c0xK?=
 =?utf-8?B?VXpXdHczRXQxV3dsWkZib1BiOHR6T3BJbkExSldwRUJpR1lkMVcrdHdNR09D?=
 =?utf-8?B?ZlZyaDcxNzFBZmUwdzZjUXkxNE1QRThwcktmUlk0K0ExQnRyWk5KVmpZY2xY?=
 =?utf-8?B?YVRSTm5CSElXZFFNaUxrc09leUU3cFVVL1hjYWErTDlnbU1vZHhYcVdKdnNH?=
 =?utf-8?B?Yk1pdUtYREpOVG1MMFV0MUJmcy9nNE9kcmlyb2RIU0pWZS9KdjBRWnpobmxy?=
 =?utf-8?B?UExyaTExamJITWJDdEF3VzRIUlhDVnFYQ1JBNEE1emRjMHJmSTlvWDYvOHJH?=
 =?utf-8?B?clU5WVYyaFlvWkdyNTJQSXZ6TTFhQ2Y1RHhsN1JvVHNGVmt2QnNPWTZra0Fa?=
 =?utf-8?B?dWFBa1NhSHdOd05SZ3NsTFhwTGVSUG0zOFl1WVNLOTREMllJa0paVGZmbVF2?=
 =?utf-8?B?VWVjYWR1amI1WkV0QUlLbTVvTHljTzNxTCtUZDFqYmV3QkhPNVFQanBWSnM5?=
 =?utf-8?B?UW5Fc3dYWjlNZVlRM2Myc2JZSEhMRmp6MG9GTHZsb01LZ25vMDQwQ0tQdDQr?=
 =?utf-8?B?ZUR4dldWa3JrM05VeEZGZ3FDQzhTQi9ybk9UYVF5c0JVaEp0M3ErYkFscnpv?=
 =?utf-8?B?QmlMZk94WE9oWkNkdStCV2lKdjdUWkxBZGEzTHBpcVgwWmJaNWhucGFtbjBt?=
 =?utf-8?B?aUs0bi9NT21VdHpCb2plaGpaQ0oyQVBIRzE5V2JOK1ZsQzV6aGNWWUtPSFlr?=
 =?utf-8?B?Q0RFYnhTSnZ2aGprREg5QURTa0szbHhlNS9pZnRRUWpPUEpaT2NqTkM5OVl5?=
 =?utf-8?B?YkZXNG1jRVpLNlhsZ1ppZzNvUTh1NXB4Tzg1bkl1T0tickdoWkpUK0prQXlT?=
 =?utf-8?B?N3AwaUlJMkwvWmFQVUFtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGN2ZFhOWjNzMTNoYUNIY0d4TVhoMkJqUzdpZHhHMlJKRWNaSElwRCtrMHVj?=
 =?utf-8?B?L1pVNlpUdlhGdTVXQVNxcDJwUWp0a3F1NW4rd2lQN1piQlQydElxVmFMV290?=
 =?utf-8?B?VGp6Qk5Ma3NyTWJqRlZqdSs5ODNTZk9ZTnRobGIxMXFIUmE5eGlKQ01LSUM0?=
 =?utf-8?B?WjBBNHNCN3JNVlNkdGRVVVJ2MjZLZC9uT253dnNwRjlkcm85ZEkxd1VQVDIw?=
 =?utf-8?B?RWRhQjFFMCtyWWY4YnRtS0pKczBaY21BcnRRRHlhKzZEVloxKzRsOFo4aXgw?=
 =?utf-8?B?WUxWNFZWbTluczdBUWlvU1ZLanYrdUxoWTNkNTFDMHlsOHpBU3k5NUdiNWx4?=
 =?utf-8?B?aHd5Rk1XRXpCN1JyL2FNZ3FkY1VRNHVtRmoyYjB1eStlUXpwOHhyeWM0N0pa?=
 =?utf-8?B?NWxzblI0QmtOU1YwdXh3ZGhLYkxOQnNNS0VHOXNKU3J4TWdJRGVwWXhKVm9C?=
 =?utf-8?B?V3AzVnVJMzZYbkRHa3pwdlpuY0VPT2hBaHhuMWoyaktoVFUwMCt1aWIraXFO?=
 =?utf-8?B?aEkreUxRVjZSQzJsQ3dPL2FSZ2dTWHlCZXhyUGNDNEk0ODEydE1VQVBRSVFy?=
 =?utf-8?B?NGNMRW1XbHNuYzhlVllNZXY3WUlCa3Y4R0pQVW95b0dMR2JOVTJzVlFMMVFY?=
 =?utf-8?B?Ymh2SStHaVJ6MVJYTmUydS95ZFhnN1g0SDBJeEZ4MzJDWkpBNW12enAvaFFr?=
 =?utf-8?B?VjlrQlJjS05pTTJFWHJZVE45ZTdnalpQWlRlZnVMNHJMZVQ2U0Y5bFQycHcv?=
 =?utf-8?B?c0hOZEM0Q2RZaHZjc3FhUXU5TmZHMXJ3SVNkVGZiZmZGU0FkTE5ucGZ0UXdH?=
 =?utf-8?B?am1uQWRLREVsNnpZQU02WTVNS3g3bGl4OGxOZGx4NDFBN25OUGFBOTRuazJI?=
 =?utf-8?B?THM4Tk9EaGpXQVlGN2MwODFTNEVRQm0yL3hIVGoxamd2aUJmUzBHU3E5aml1?=
 =?utf-8?B?aFIvVmNRVlFLN0o5NkIveEc0c0luN082dExQRTlXcU5wQ2kwMzBXWEpma0Vn?=
 =?utf-8?B?d0J1U0RIRVRwNmhWUDZnZWlaUDRGRC9IVGxBUFlJWHE1WlQ0MGNISG16d3VK?=
 =?utf-8?B?UmtXb1ViUmpRbTFkVlR6RnRNbmhKOGNuYTJ5d1FVRXZHUk9DNXFNSzl2cGdu?=
 =?utf-8?B?SWQzTlpyZWpLRURDUFc3cGhyN1YwSUZqbWFnN3pDUjNISytyRVo3SWwwdVVW?=
 =?utf-8?B?enFEakRWckRJNFV6NHB3aUhOYkNGOHRwWlJrRUp5VWI5KzB4NUxqTlBLSEVt?=
 =?utf-8?B?Q2ROZmRKcEZYbHFKT0tvNlpXVFlqeTFHejRyd1FFTFBPYW5JdFNlNHRrdU1t?=
 =?utf-8?B?TUJ5UzhHV0VhZ1U3V0xiWmpGdkZYd0VacTlMbFZJY2NJbE5WNmErNHE3bmdw?=
 =?utf-8?B?K3VyODF1NzYwWmsycno5TXZrWkhSMkRiR2FLM0x0OGNZMVJKbkxqejVjemx3?=
 =?utf-8?B?clpKQnlSMVcvUnR3MXBBZ1lzUXdEZG5xYlkxMitBQkFTWC9kTW1uckpCRGd5?=
 =?utf-8?B?ZkZsMHZWRXNkWWpUM0NjOU5vQ2Zic2kxQ0FXczVCK1Job2s2YVlEaFByMTVE?=
 =?utf-8?B?NUs0bHB5Z21JOVVqRXBXRHp6YTNBdU1URkxydG5FT1pMMG05bysvOFIwc0hB?=
 =?utf-8?B?NEIyN0JLY3kvRlU3NEM1YVQ5M3JHWDRPZ05IbFN5SDlaZ2huc0pwakQzSjFG?=
 =?utf-8?B?YWNFOVVHa0hOS1JzQU9seWwxSSszc25hS1FDVjlGNmNnMFhVYVZwQTRKV3dw?=
 =?utf-8?B?Vy91di8xa1N3UEpZVVE0OW9hc1RwTW5JTXpzY1Z1cWJMcFFVYXdtUk1VRlVm?=
 =?utf-8?B?dmVYdFNEbmp1L1lTRlNTMStONFNqRzlPcHBqNmFoSlVham55K2w3MW91ZUw4?=
 =?utf-8?B?S2EzNWUreFVrd2xWRHpLY0NZTkxvZG4vUysyQ3BvWTdodGFwWS9UNG1WYlRK?=
 =?utf-8?B?SWc0TkdPRTVVdjJkV3IwRHVFRFpPWkxJcjNuK3NWaWg1dEdBVDBFUWxQYVFq?=
 =?utf-8?B?UjFMa0xBdUVSNXZZSzBJUUYzNjhLU3ZpZ21qc2kzMTc0SklzRStCdExFR0NX?=
 =?utf-8?B?NlRFRzJ6V1JqcEZ3Q0lJT3FLRGtkbXJpMTR5cCtwa1dGMmRXbVlLNFhQb0R6?=
 =?utf-8?Q?EYFIaz7RtN+aXalbiGcZMcUxJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e96689-995f-4d9a-9266-08dcb1183778
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:21:15.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXAFFokMGPyAM0rzL39sSr1n+esRoDwZ2/F0Xe//c5mNIdFSiDQqlikAsNg1/wA74VQvXSsqQ+ntPrbIyrPcMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647


On 2024/7/31 11:39, David Wang wrote:
> At 2024-07-31 11:16:14, "Xiaojian Du" <xiaojidu@amd.com> wrote:
>> On 2024/7/31 8:25, David Wang wrote:
>>> Hi Du,
>>>
>>> Thanks for the quick response
>>>
>>> ...
>>> I feel that you are arguing for the warning and the errors separately.
>>> Separately,   I agree warning or error message make sense as you explained,  but together I feel confused:
>>> Receiving a warning that CPPC feature is disable by BIOS already notify users that amd-pstate would not work, right?
Warning is not enough, error will guide user to switch to acpi cpu 
driver or seek more support from OEM.
>>> Is it possible, that those two condition coexists: CPPC is disabled by BIOS, and  amd-pstate could function properly?
>>>
>>>   

No possible, the current amd-pstate driver is based on CPPC feature.

Thanks.
Xiaojian

>>> Thanks
>>> David
>>>

