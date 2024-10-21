Return-Path: <linux-pm+bounces-16098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D49A69F0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8087BB20FD9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19431DF74B;
	Mon, 21 Oct 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dtBYNT/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843C1DDF5;
	Mon, 21 Oct 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516566; cv=fail; b=pJipkNIE4Z/Uze90u14BkpBl5swqxThQR1DDWf13BzZ54TRWY5kmmCJuzDeAwlZK9pWhcyOm1qw/xQ1wjbKquVq/qAoT/VSqfgobIlTK/ZGZE/x4EAZf4WUaMug9ZJn09s3sbSgjy/86UibRCXaoNd6iWLBxxW0JtH6VXb0ffe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516566; c=relaxed/simple;
	bh=nYRZD6qq5D7F89Mhbl9+80qyOQ8vwOq8Af44G/BcwU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQSIie91RVUccNkJSfsogFdEKsAZb1q8qurq+WmMWpJUKZ3cxw8jE8cPO61yfiyPsSvdS3Oaz9+v5VboFvPlK66cGN8d3Lpe9vEDGD5MZf8XP74055485SK4oXDp6LZgyDMm7q2BEzZZVBQdbeaHICFP3Py+aEm/vWBaJENgNiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dtBYNT/W; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx79n0HWhd3erbNoEHxZE570x3XW23sYriyPNEeTte65ADaJ7zjRqF3I5H/RFFbOfEsboE7SE2+2ZcrlSd4haqFZUyZzkHkBQcwNltaWByxN96EhIDN0/j3qTbeWrZp6ZsvF6KBlY/dRgLmNKSnLFoJX3vr1jkowNCJcAAFzqLqPJM/3V4cNGQt1jU+U7sZ0cu9MSS0xV8v9HXT3DE0X4o86CafyjH15r0kdJAAyi0CrSEugjJVN0Ak40s3878jh6HTXq2fY9MjtJ2gkFSqPMoLIyDLS64hy4io9CrI0EWUV4ymMb3LjVcQhFvGBDRpwolsTJJveLA+fTayBGP6k3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll5BP7lLvCF85yOjbIydzNytfczXHKh7ZTs59Wg4bS8=;
 b=w5MYYjzozs9BqRfRnOL2awlUwwr4OvzAtJvrz3PPERFLs/48hLwlTGOTbH7P1YwmFBiRez0lUZpcP6J2Nlok3ACr4t2o/cnPIRP5FEZtth7AVxmJHX8J5FsQaQOPNPSUy4jFonaZKu+qZApvwqo5NhijAB5mbprGCgtOh0CKaNEboF2lqBj205HpJ2YDSJaD1eB+9kHB9p3HFIjA6cF9bjxdH5IgfhBnUd8OGhA/8Y20UEQoyhAxSRAu1RbyzcL4LWYkbDId109AL0pcTHi74twazVtI8jzVW5ZeKFOhX7EqUP7D/xeFHIJ3AmosDGsKhCSx1JbEST7funAkcHYGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll5BP7lLvCF85yOjbIydzNytfczXHKh7ZTs59Wg4bS8=;
 b=dtBYNT/WMUsTx9Dl6t/hOFdm7mUuJSSXweCiGjayNjKMT4O0WQejzePUQLqjl8MC9fCx9oVg1xvwJJW8oJTtiZ1ry7BtCsrrEV2kh1a7V+1+PF2dNvqwKlmp3Bg8WuaxIuSdHLSBQcQyXfRfz0uWtJHaETEy2rndYDfsRp2kcb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 13:16:01 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 21 Oct 2024
 13:16:01 +0000
Message-ID: <135dcf22-bfd1-4624-958c-599f0f3d49dc@amd.com>
Date: Mon, 21 Oct 2024 18:45:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate-ut: Add fix for min freq unit test
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241017173439.4924-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241017173439.4924-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a3c4a8-c4c6-4844-a90c-08dcf1d2823a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXUwZkdndDdGVUhqS0NSOHBSR3h3aGlLbisyVzh3N0dCa25wMGsrL0UyNk9k?=
 =?utf-8?B?emJ1MjFod3hMclFrNDNMVENFQWIzNXBTMkRERXdWa2NJeWNCSE0ybnc5ODE4?=
 =?utf-8?B?dHZzd3dRdHVWZzNEY2IrWW5mWnRuZ0pDM0E0M05uK2NNT3VKN2xtSzVEdkho?=
 =?utf-8?B?VDdYYjloRFR1SjlIUFoyWUF5QTlFZ1psLzNnWExXcDhNQk1JTDVibEF3dlhW?=
 =?utf-8?B?ZGFMYmNTLzFQYlF2RVAvZjhzZm5mTVNFYkhjQ2pURVZPTndRQUUyUE90Sm42?=
 =?utf-8?B?VEdFNnUzZjBYcWxqMDV4WFdUblFkeFhFaS9PRGhnZGxVa1E0MXQvZDB1MFYr?=
 =?utf-8?B?OEVFdVNvc2Y1QTl6a2hTdkN3YkVFVTRFd3RMN29KaklicmpiOWY4MGt2MzdG?=
 =?utf-8?B?QXNseTZ2LzZOM1B4ZTlVVW9VeGY2NldkeWtja1lZa2xIbUEyZGNDUXl6cEdh?=
 =?utf-8?B?eEVUWjFDbkgydFp1cnd2ZXR0akNyKzVBWUtySEphRGJaWHNORUcvVW41VTVv?=
 =?utf-8?B?Q3lJOGdIV1h3ejZ2OWZUYWJGVTJncFpHelVCeEluMzhLNTlOd0tMYXRCYy84?=
 =?utf-8?B?VEZuVTRib1JZWFNaOVdwRy9WYWQzNFV2M3pLQ2cyOGI2Q0hjT0hlTzh4aU9S?=
 =?utf-8?B?VTBRcnZUNFlVd3BscVJVRVVIRm9wRVBEZm9DaTJWNjBtcGdmMHcrc3piVkVI?=
 =?utf-8?B?MnlFWGtUc25jY2pEcXF6ajV1Uk1BclQ3Z29iT1RxQ0dZd0VlTDRFZWQremc5?=
 =?utf-8?B?clNSZFcwWlZuMllBSEt4WSs3T2RGMkp5L3dqK0FrRHRMdzRUTGJRRjdoMkFo?=
 =?utf-8?B?elJWeS9lM0JhZy9YNEJaVm5MeWdWeHpQUEw1RWIreHh3ZlFJb2FseHo4TjNI?=
 =?utf-8?B?NUJUT1lNRkdlKy9UbFFyMkQrVGVjZVNMalcwSlZWSmRBSEc0bnV4cHRlbDhK?=
 =?utf-8?B?R3I5RGZMSkxpTzJ1MHloTlI1MlIwRXc2amxHcWFtVFk2elpjSnlNZzVzZXpt?=
 =?utf-8?B?TjJHOGJJUC9JM0RLeThUU2NwQVpWdGxocDlxbU9zSW5Zb3pMbnBVQmh4OWNh?=
 =?utf-8?B?dnc0V1RCRm4wbVNpRzNvcmhZRUtqR3dURGVJMmVnQ1J3Z0NnTWZZSGlGZXRO?=
 =?utf-8?B?Ym5FRWZXejhIbkxTbmVjc25LZEVqME9XNm9kcTBibmx6blNORXBQZXZJTXJ1?=
 =?utf-8?B?WDhxTXBnVzdqYXJTbXhGNklLNlNSN1BxN0lodXJrWUJqaDVYNnFvaTA1L3V0?=
 =?utf-8?B?czJFekE0WjM3bGZaaVl2eFpQcmtia09YQkJqdmpaK1JtZkVQVzF0S1RRZVR0?=
 =?utf-8?B?eVN1Y0QwME5VSW80R1ZBalVrak9raFVvaHBidElXcHQwb2V3eEMzUXYwdXRq?=
 =?utf-8?B?TjlIYnkwRXNwTXJwZ1FHaStpWmowNG1Zazg5RFVZbTNKR1BjRlFuTDdDTlRt?=
 =?utf-8?B?UkNUdGZmQmZDaWJlVjZ2cm9kbVc1YWFKYXRzb2ZIRTNVM2FldFNiSGlNN2pF?=
 =?utf-8?B?VWlxWUdwY1RIK0pPS0VNY1dhQU1lY1I2TmMxbDBENGpFZDZDcFJ3T3ZMNXEz?=
 =?utf-8?B?alBBTjhwTktQOTR1WlFkZVk3SXk0bEhMdm93Vjg2NjdTQ1g2cW5jS1JNVEFp?=
 =?utf-8?B?eThnakJWQUpHOGZ1OVlyVEN2VkZkdkFIbSt5Z3h4WmIzZm9uYVl6aklhZnpy?=
 =?utf-8?B?TlRwZDZpbDJEV0k5NTNwWTJpSVJ0WHptR3dJa1VGKzBVcFdmMkJuMUI4c1l3?=
 =?utf-8?Q?wV8xVNlAkdjfvVBWs/Vu708cQL3yug7bq3FW720?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy9sa2p3NmN6TENwemtYZkxZMjNCSW5KK2lLYURZT2Q4N0dOWDNPNC9KdGtE?=
 =?utf-8?B?b09tL0JsNVhSRUhVK2ZHSG1LWldrYTkzdTlVNXBLRmdOM0RUaXJZM3FUZWFS?=
 =?utf-8?B?N1dhNWQ2WDB1YkFRYnJuR3lxYnNCQmVqSlJadWpSU28ydlAyUis3SGVzR3Jz?=
 =?utf-8?B?OExpb3oyY0RISjZiaERFMnpVUHdMcVRCMzE5SndiVVRCWkpNYmpCa0F4TGp2?=
 =?utf-8?B?bzhxWUt6ZDNHWlVCMXNwZlk0d0kxeGViMDhOT0Q4djlBM1BwcDVQajJmMGEw?=
 =?utf-8?B?cDVyWlluVm5IMUZhQ0hhWUxjV3JpSWQ5cklHU3djVDFVMVBvaHlzanlKQ3hG?=
 =?utf-8?B?eEpsb0VNVG9QV0FZNXllbGoxTlk4NVhLUWgyZEdXYVNlMTNwWFNNbTMyWkpT?=
 =?utf-8?B?N1poQ1kraGttVnpWV1c1K2Q0ak1MZ1dDMmlVZ1g3clBEZ0RSUGdlRnpBY2dP?=
 =?utf-8?B?OUVrbGZ1R2wyTjlTRmM1ZVFNeVpSN1ZlY0txYzFrbkszY1ZJYzAzT2FqdUN5?=
 =?utf-8?B?bmI0SWlwOWhmQ3BzR1BHSk1Makl2ajQ1elRwMTVubFM0SWxienlGYTNTWG5P?=
 =?utf-8?B?ZGkzMS8rVE84dkFkYm1iTVhNc3ZkVWVacFY0MW96NFZYSjZLVDRYWHVyZ1Nr?=
 =?utf-8?B?Mjh1U3NhMnpuQ0IzbXVYeTdGMFNHNmVVR0xMRWFaNmhIM0VUMFpRZC9nYXU1?=
 =?utf-8?B?dDg2cnpOV3FnR3pyY1ZMTkRVWWtJeFdBWnYyZ1VsVGpGaDBHb2NLYVpQQ05i?=
 =?utf-8?B?ZURyUWlmZE9Zd2p5b0lIUHlNRjVaT0tlbWVGelZJYWMwR2p1ZW9yQS9UK0VF?=
 =?utf-8?B?ZGd1WTNqdzVveUI3KzVNSVVqY0FnOFNGYnhrTEFnY0k2aUhnM2NYT2ZrdVJJ?=
 =?utf-8?B?WUhsVEJBYUUxMEhNcS9XK0NVUHU1UzB3bVp1eWJnREJqWnhwbzA4SlJLNXhN?=
 =?utf-8?B?U3VFdUFDZDZLYmRHTEpNVC9LTUdMWVJzVHJPVml4QnNwSGFiakJ4OEF1T0Rm?=
 =?utf-8?B?SFpoQytLQ0dDL1dPbjlEbmN4VE5ORVRLYy9KTzlkMlJpVlVaVnBqaUQrWGI0?=
 =?utf-8?B?Ni9FQkhvMmEzUElHUWhBYThIcFhmMHdTMUU3S0srZVlxcVA5aTNrdTc5T1hp?=
 =?utf-8?B?b2c1SGM0VHhBcm1SRXZYQlBmS3NkdjdxSlJEY1NOVi9uSzNXNU9VRmorWHVI?=
 =?utf-8?B?ak4vWEwzRHh0ZHJkWFcwaVo3Y0ZjK0tEdkNEcWdVSWt0d2ErdzJYWlBjeXUv?=
 =?utf-8?B?Zmw2akc3M1V0cWpsM2ZNNkhLZHl4V28wZW1zcUc3bzRVeUx4VEhBWUNYdTBo?=
 =?utf-8?B?d1ZBdUdWbEJKSXBxVEJCUFRYR0dwaGVVNjdBU2pYcTFRSmdSbzFVemV4OFFM?=
 =?utf-8?B?eDRRR3RWTVVjUXl1TGVUcVVSZ2NiRCttdmJCaHFDWU1hMURGNi9nNlgvQnpF?=
 =?utf-8?B?L3d4dzJuVkkvWlRNdW90K2YvcysrVENYekxjVXp2NzNlTll6c0ZUVWtnMnNa?=
 =?utf-8?B?SkVEMytTbGVKYVErNDExaGZRd1BYRFEvM1YzV1grbWlqdUllOFJSNE1jSHlT?=
 =?utf-8?B?M1JHb28rUzlnU3BNZU0wVmkvMjlLVHBJaGMrWVpUYStYeFVwSGFhVWliQTc5?=
 =?utf-8?B?N08rckYvRmNTNDNOQ0lHa0QxaXlnTUhSREZCNXlNczZhV0xoQ1paWlFNUzdp?=
 =?utf-8?B?Ym5hN3pFTVVPVXZrcFJiWTMrTm1PN3N4cERUaitxdkV2RlRlUGo5VTVUY2Y0?=
 =?utf-8?B?S1NtQ2VVYVd6cDFEd0ExUk1rTVpDUEwwdFFjbFV4ZGtLYlBBNzEzaEZFMFFp?=
 =?utf-8?B?Q2NBeWJyRlFMSDNnemZXcTBvaXpNOEpIZnAwa0poaDhmeU9nbmhDbkN6QjJo?=
 =?utf-8?B?SzgrdzltQWtOSWhQMS8zS2liMGlibGcxRkF2dndlQWU4YVpJbkt6ZXlTdFBn?=
 =?utf-8?B?eVpldmFreHNOQlEzWXNBV0tTNmJ4N3FhcGhqVWZzaDNNdHIzR0I5VVRGLzZq?=
 =?utf-8?B?bllUK3lHalhpYmRwOXhVeUJEc3YxQTJSSXUyS2pGUFVmZkQzL1NKVGpxUUdm?=
 =?utf-8?B?R0R5WGxFa3JLVDI2VU1FMWF6OFp1ajAwRWgvMVV6cGpnSGNiUGVkcVdGQTlw?=
 =?utf-8?Q?UoItWyC0IcIfzEypL8pAO6zD8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a3c4a8-c4c6-4844-a90c-08dcf1d2823a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:16:01.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 834VpnwKS2qg1hpXPAF3CSna7zhskLcHHkqs+jCIGhHRTaFdrpuNHWTJTWoF9ohx5UaL/SAnT0WBnpsc2UOiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

Hello Mario,

On 10/17/2024 11:04 PM, Mario Limonciello wrote:
> commit 642aff3964b0f ("cpufreq/amd-pstate: Set the initial min_freq to
> lowest_nonlinear_freq") changed the iniital minimum frequency to lowest
> nonlinear frequency, but the unit tests weren't updated and now fail.
> 
> Update them to match this same change.

Thanks for the fix, looks good to me.

Regards,
Dhananjay

> 
> Fixes: 642aff3964b0f ("cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f66701514d906..a261d7300951e 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -227,10 +227,10 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			goto skip_test;
>  		}
>  
> -		if (cpudata->min_freq != policy->min) {
> +		if (cpudata->lowest_nonlinear_freq != policy->min) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> -			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d, they should be equal!\n",
> -				__func__, cpu, cpudata->min_freq, policy->min);
> +			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
> +				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
>  			goto skip_test;
>  		}
>  

