Return-Path: <linux-pm+bounces-10089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D159919E86
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 07:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7AE1C21DB1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 05:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE3175A6;
	Thu, 27 Jun 2024 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JvtCUw/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C72139A6;
	Thu, 27 Jun 2024 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719465424; cv=fail; b=P86ERNk/bV2f9vk6yenNnGQ8yDLUKAPoYIDrZBdR4mXwWzBJhr6piQNysB+d/nbyzEzzCTItscaN49F/iqQsvxisoMgOAhr4TrAur+HMr1UJ/kDmVz+0yAjigrFdHSRDsDQ/x1O/NbcM3caxeHZtJ+mPCRg7WfPmhHUmCMj0Idw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719465424; c=relaxed/simple;
	bh=AK9iPs2TOyQjRDpiQlMxarY99hwXLFyK2hW/PLbps8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WALqKQ7wfCV++W76VfJC+lx68Qok2UU/7QUycHTJexIVu8JVlZNtyYeSw/mQ11+77flB++f0nlppylm9+4YbmYFBjQ0SljTg8HyPYlnKFWFNV+b/cDqqAwnT0k0SbkgXTG/cQ+MdiYysu7RAaBQ/COQP9KeneuZdGZxjUzfI6g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JvtCUw/b; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkU1GeLy0I64TxjD4AB8CVk6RS8JvSJKbp+Tbk9fsiT8wCT90WVNJ/92OBg/g4Yg2lb8D2P43ep/cpdx7U3TvWh8ORYqHYEdCSwoxIS8QG5UxTL2L+wAY97HW8sUFY/ROrI41pcivoi9mfHKu9V7VzfS5t5Dq2xF3qAECaLOAJJg0eQV0ALlf4aQm4VP7y06pyL745Khd4hImmrcKbkcW9luUlOZB5gm/JGy8TWN/mmJHJJW+7GKvkc6ZAhRE+yq6Wcl/vFtWBN1zBGFYFnC1psVt8v7cPw4dya4Ajlg81LjXI1rAF7rlwOLHmQKtsXqcbKVVDODh/7xKlFazJDDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyrfrugIPQ1jpFDyu7SaIEo+pzXhuHAJPFBjViWJXi0=;
 b=Hc2vbO8nRGi+WSvl8kKnFFF+EyTOX/XbAd9dz9kVir96P07PbySQ0EJlzhKdyf2UcWF9Q0sizJochJ+Mk69p9x0MBEnGA7hQpDJp9dcfUVWBUgVh+VcotOHwyiZNH7TKivk+WFrAVYfriQOZ9GE6y8giLdxQaim8BQG7ig0XhLrO2sGnzFi69hZ7jZUhTOcolF3hArZA9QBLk9Vl5P9lY9D6M4SVOp9iKn2LDkCMM8mTCEcVBMXnWe/gcbIpdiVgRnFkLi179j0dunA+WNK3ZbmzSghvj3+en2WhQllYJ2FHX12vN+QhJ4ZYV1Cma6thRhQbUe2SoLmzqI2ZF3YQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyrfrugIPQ1jpFDyu7SaIEo+pzXhuHAJPFBjViWJXi0=;
 b=JvtCUw/b4ZhOiyUrV89hr2Fmw5ujo/+5vO/DUu5aq5Rn6hZYK89jLmVFYSo1zpm840TBWN0XDnN8Jm5IrtdlxWQhs37/lmWL0r1L504ayN3YnzclIoujx70eHnZoyuZwwebeR80rnbar1zrn3zs+r0T8C7efHaPw4iK+VHGs7oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 05:16:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 05:16:59 +0000
Message-ID: <b0682b62-a690-4776-b2bf-444b6838cb05@amd.com>
Date: Thu, 27 Jun 2024 00:16:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>,
 Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
 <peterz@infradead.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-3-mario.limonciello@amd.com>
 <87msn7ezoz.fsf@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87msn7ezoz.fsf@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:805:f2::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfac03c-55b7-4b9b-fd90-08dc96685edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amk2WTc4VFFobllOYzRIdXFuRkVNSEM0OWlOays0WmtNckpzTDVrSE1nT1Zo?=
 =?utf-8?B?eWtVTEJJc0Mxdk9mVFZydGVoU3phakM2N2dGbkF6STNaaWtMTmgvcUdWS3pM?=
 =?utf-8?B?TFh0QVdGNWx3UTc1QlloaU53ZTlXRGt6TXI5VFl5LzNCbjRCS3ZLZTl1M1pm?=
 =?utf-8?B?dWxncjFjdUJKL2RST2lXbzIxVitxRW9JcG9LMk5nSmh3N0FrWC9DUjhxRFRV?=
 =?utf-8?B?YjJKU2lNY21ZRmd6N3lrdEo4azRtTzVRbXBjVHlqWVdRbjUvRmhDL0lNcG14?=
 =?utf-8?B?cE9jV1p3QmxQbGk0dG1EY0VVekFFOXFQTXpWVG5BTXo0NEdKVUNwMGxTampu?=
 =?utf-8?B?U0VVaFJHZEdvUGFHSTdaZmlxWlNzUEZJQ1VLSm9kWVlnT29EaHh0YVI3Y2pS?=
 =?utf-8?B?RWpodytpTmNOVTIyeDlsT0h4Z0NTbTJMV0g5dzFDTXJWazNxTHNtTmtCNkps?=
 =?utf-8?B?eVpnaGRHSS9DZW9VWk1UVzluVHJoUXlMRXlvSDdvbzFqYzNRMDZJT3l4aHZn?=
 =?utf-8?B?bjY1RzJLcUNKQUMva2Z6RnlxWEl6RWhNa25ZNnFORG5HcU5RenpxdG1VeUcx?=
 =?utf-8?B?NEFWU3VsNzdEZ0g5VENFNnJmNlhJeUI2Q3NMT1Y4MkY0Z3I1TXcrMVFPVU9D?=
 =?utf-8?B?dnFFOVhRWGRrdGpZYTRXeWVpeHlSYTh2SzEydUFhYWd3dC95VlJwNVlIZ1c5?=
 =?utf-8?B?S2dHYmhPbnlJd1Q3T0hNYlBteHdBU2dLTk9GdVVtWE50TUE4VGwxTVYzeDVs?=
 =?utf-8?B?Y0I3MXpZZ0tYdkR4SU12a1FlTkNsdFQyeTZoaXRLUDdSUEtOR2VRbFRiZGRR?=
 =?utf-8?B?aXBseWtsQTliVG0va2N0WTJMZ2ZlVVRqZDdTOWg5aklIa2UwSExZWFhna21C?=
 =?utf-8?B?Z2hZOTZRaVg4ZkltaU5IeC9RM1NKRmtHN2g2SFNMTzB2cElaZVFLSnlmSVdY?=
 =?utf-8?B?REs2akNBWUVxcEtkWVZuSjh0cXY3UW5HajRyb2hpcUhTVG5ndlNJTEhFbzJF?=
 =?utf-8?B?Yi9ZR2hRUUVnK1VPZUh1RE4rY25FekJzVmxIMzg1ZEs5OVJaMHI1Tm9Zc0Zl?=
 =?utf-8?B?T21FR3NLejhPM0FUSTJySnh2TU94OTc2bVEyU2ZPNUNEU1dBeVBFV0xVeUZh?=
 =?utf-8?B?YURIZEc5Q1EwZVY2dDNhN21IKzRzaXY4djNxMUI2UFpxaCt4MG5ZL3gwSGxy?=
 =?utf-8?B?SmY3VlBobUh2YTVSQk1mZEozZ3lHR2dXUmpJQ3VLeGQ0Z2Z0YzBBVzhHVHpn?=
 =?utf-8?B?NTF4dTAwMmVWM09DWkliZnVBb2lLWDl2Vmh0dTFlRGN4M0ZyUGpGSisvQWFm?=
 =?utf-8?B?UnZaYzFwUTNSSEdlTmRoWE1MKzJsQ1Z6dGYvVFBza0xOeHlhV1pQWjI3VkZH?=
 =?utf-8?B?WjF2Z09hQ0lvZ055YXZ5bkdQbDZIOExXZlEyYjc2U205dDRWd25hNHlJVHpL?=
 =?utf-8?B?cmpQLzVPRlZ2SEtrSlRaMFp5MEhPTUZySDk5R1dGRjh2cTFKZ0xjM0xkOFda?=
 =?utf-8?B?Y3RNVVNxeWR3YzBRVnVtYWRoRkZrK2Z5bG9vY29TTXB5VmJnTnhxM29FaGRt?=
 =?utf-8?B?a3Q1THFzUGFvUEtkdWsrem5CYlFIVnlER0lQT0taRE5yM0lRK0JycWRGcjI4?=
 =?utf-8?B?RXNPcFREaElQa2Rld1V1R3ZSVy9TUHVJVGlvR0hYQWhXcUFqRkJOdFQ4ODM5?=
 =?utf-8?B?NTdlZnFiYVFxN1cwMmxidmpMd3N1QnJUeE9DbXc5QUNRdzg5TFRWYjBGU2JF?=
 =?utf-8?Q?BT+SAop3C3FM69Eo+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEpkcFdvR0dKSDVicS92M2wrUlRGSzNFTUJNbmZsc0xmN0Nvcm1FRzhXZHFv?=
 =?utf-8?B?a3gwZUdTQWpGd1hpemZ0VkZJUFdic0U2ckZHdmI5VVRUbDFaK1JuN2ZLRTVT?=
 =?utf-8?B?Q3RrZFVWTUFUODhHdm54ZlV0eHRQanRiSHJRSFcxRTU1enZyNkNMOCtBUlRa?=
 =?utf-8?B?ampWeTlrd1dNUS9OYVJTdk9hbkVvdHVQT1R5Rk4vcnZ4WVQ3N3dNNE1JeWVm?=
 =?utf-8?B?OGMyaXZoN2k5eE02cGJRZ2R2RFJmek9vcVJpZ0dNS3pGYTlNT1dTR1RRZGRz?=
 =?utf-8?B?M1BGU2NrMXprZkpHUjRaUGhka2lseDlUdmtob0NENXBSVFZ3K0RDMXBSN2sv?=
 =?utf-8?B?ODIrM2RUVzBYU1E3aGF3QmNDcVplWjJxdDBoYkttTXlhN296ZTRPN2pwM2tj?=
 =?utf-8?B?dWxmT0U2eFFQMkZxaHh1Yk9UQWhjR2orVzBIcmVubXltMnBPQlRBcXRBMUJ6?=
 =?utf-8?B?TDRuTk04UndvRmg1TUh3Y3QrTkpYZDZTWm56SjVqRGUwdkpGQk9qQzkrZVRS?=
 =?utf-8?B?c2E2dW9lbXdtQjR5ZmQvTGFEMmJiK013Um5ZVFVEUUJYWDQwd1g5aTlZRzdQ?=
 =?utf-8?B?eE96cUYxSHBIUnNxSm5VT3NhejBWVUovR2ZXdWVjUFYzaTF3RHd1MGJLUUox?=
 =?utf-8?B?U2x4d2NGcld3Ni9pTFFYUjFpMjJLWnJtY1pSWStJWFhYK1lVMkpXQ3hjTEF3?=
 =?utf-8?B?UHBRMVB5QzRtR202RDk4TlF6RFJ0bm9yWTVPTWlWOWgrb2lrSXpVSmJPZXZ2?=
 =?utf-8?B?aDl3Zmt6TTg0aDQvZHA3WUFYRkJKb200MkZPS1hFajMxenZiZC9mZE5abC9m?=
 =?utf-8?B?bUVrSHI4ckQ5bjdnZjFRNmF2T0lWSURSZyszUHdySUl4aUpYZkVCdVU1ZnVK?=
 =?utf-8?B?K1krYnJZT2JOSWJGdUhkT0dUR3AyTElLbDArMGU2Uk93a1FtbnNoRlpxdGwv?=
 =?utf-8?B?UGpScU5JZWlUSzZlUEd0RURJeHZNc0JScy8vblBhSjRwNUZSTzhlTjhTRjRM?=
 =?utf-8?B?R21tc3U5c0Z2c1dlRFpJOFF3UkIzL3Zmb1hoL015bGtVVE12KytZMlQwSkZY?=
 =?utf-8?B?RjZVUlJLb293L1prRVM1Wml6Um55S1VvYUNPak01Y21uSGhKSHM2ajhHelZ5?=
 =?utf-8?B?ZEcvcVE5dTBlVWNJN09uWTY1L2dkY29Ia3J6WGc3ZEloVmJWYkhhMmlucUJj?=
 =?utf-8?B?VmU3RXl3Vnc5cGJ0SFlFZlgwOFFDK0IxMXJBdGRsZjRYRE9LOTNObmc2VVhJ?=
 =?utf-8?B?R01IRnVJZFVHYkpQL29GVGlkL2g5YU94TzV3WVhCdWJZU2I0aGo2Z0NLQ1hK?=
 =?utf-8?B?NGRjZld1b3ZRcm43b3cxVjBZbTg4ZURuUURmNjNiMUdwM3ZjbEFSWmM2b095?=
 =?utf-8?B?LzhiVXJGenl6aUxCbnYwNllrMEE4ZnVHbU9VamM0Q2VHWWpWcC9mTC9pNE8r?=
 =?utf-8?B?enloM2E3VCtSRVpHQmd3TkZaUkFwRVV6STdGTG1PSFhuRHFIUERORVZTeDk5?=
 =?utf-8?B?d2JqVS9HOHhHNHd3TGFBZVVRVlFVOHVDVGFqaE04dTlyejJGUDAwVlhaZENz?=
 =?utf-8?B?d2RLU3hESlpLM2wzSWNVUDNFVW02Z21Bc09RM1ZiNkJyT3VrTWhLLytIeFc0?=
 =?utf-8?B?d2J2K25KZEgwdzdSNU1hRStUNWlpQW5OWUlvRExmc05nZExTdElXTFZxQ3Z3?=
 =?utf-8?B?QlpnS1krSW5QVXk0MmtyaGF3TXZSZ2ZSNjg3L3pMMWxJNjFjSDh6cGYvSjF2?=
 =?utf-8?B?djA4dzUzUEtCRWVyZUpYYVVBSXAvZEl5MzkybHh2S3pwYUZtS3N3WWxMVVZL?=
 =?utf-8?B?ek1SQWVubm5zaHRGdkNoRjc1K2FxTFNMbUw5WDVMZEYzbkVJSnprVzRDY0lD?=
 =?utf-8?B?QkUxUjZkbVo1TFh4M3B1a3o4QnJTZXRUa0ZpTHBYMWt3UzJ0eVZNcFkwaGxD?=
 =?utf-8?B?ZGIvUjlCL2dvaU5TVzFiYjlLZDNoUTZXUmtIbkppZStYY3NBRm1BT2pZYkpD?=
 =?utf-8?B?aTlVM1I1Z3ZlVnBlVTE1c2RXVTFaeldOZkk5TnY3T2FKVDNIUzNsb2ZUeVZR?=
 =?utf-8?B?UlZwdUxSSUxqenR6Umw2UlpFZEFuYVdBaUM4VCtOMGpRaUFuT3l0MkJmTEZx?=
 =?utf-8?Q?AmrObPiiS1D5WDfSrJZfi56g6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfac03c-55b7-4b9b-fd90-08dc96685edf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 05:16:59.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29ZijzJHPZGUn2g3X+nLC85vmDqBW3CuT6vAMJFTTwOuZLLdu8d/YFP4/Dh3MJ20FZkx6RmzitDal63kR5y9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On 6/27/2024 00:12, Gautham R.Shenoy wrote:
> Mario Limonciello <mario.limonciello@amd.com> writes:
> 
>> To keep consistency with amd-pstate and acpi-cpufreq behavior, use
>> amd_get_highest_perf() to find the highest perf value for a given
>> platform.
>>
>> This fixes the exact same problem as commit bf202e654bfa ("cpufreq:
>> amd-pstate: fix the highest frequency issue which limits performance")
>> from happening on acpi-cpufreq too.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/cpu/amd.c    | 16 +++++++++++++++-
>>   drivers/cpufreq/amd-pstate.c | 21 ++-------------------
>>   2 files changed, 17 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 8b730193d79e..e69f640cc248 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1218,7 +1218,21 @@ u32 amd_get_highest_perf(void)
>>   		}
>>   	}
>>
> 
>  From Patch 1,
> 
> +#define CPPC_HIGHEST_PERF_MAX		255
> +#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> +#define CPPC_HIGHEST_PERF_DEFAULT	166
> +
> 
> 
> 
>> -	return CPPC_HIGHEST_PERF_MAX;
>> +	/*
>> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>> +	 * the highest performance level is set to 196.
>> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>> +		switch (c->x86_model) {
>> +		case 0x70 ... 0x7f:
>> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
>> +		default:
>> +			return CPPC_HIGHEST_PERF_DEFAULT;
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Should this be CPPC_HIGHEST_PERF_MAX ?
> 
> Without this patchset, this function returns 255 on Genoa (0x10-0x1f)
> and Bergamo (0xa0-0xaf) systems. This patchset changes the return value
> to 166.
> 
> The acpi-cpufreq driver computes the max frequency based on the
> boost-ratio, which is the ratio of the highest_perf (returned by this
> function) to the nominal_perf.
> 
> So assuming a nominal_freq of 2000Mhz, nominal_perf of 159.
> 
> Previously the max_perf = (2000*255/159) ~ 3200Mhz
> With this patch max_perf = (2000*166/159) ~ 2100Mhz.
> 
> Am I missing something ?

Yeah; this is exactly what I'm worried about.

How does Bergamo handle amd-pstate?  It should probably explode there too.



