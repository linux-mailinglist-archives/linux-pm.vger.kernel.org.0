Return-Path: <linux-pm+bounces-27170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F7AB7C81
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 05:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D353A593B
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 03:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081627E7C0;
	Thu, 15 May 2025 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EGmvLmJT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075721F9F51;
	Thu, 15 May 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747281303; cv=fail; b=sUH6gr0wQLq8CP9weWnPop6KcuI5zwMvQVvv8U/4hzNlHH322N5ZKkoMzA8LC7ER7cCKgcxcGJUNv02RU53Id9KlwzWat3RIuppkSvWH6uLx2D39FrQoeteikRREiYklUcwL/6yrG/nC1152kdKB6st1+y3I14RB7SldOE5Ts6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747281303; c=relaxed/simple;
	bh=HHwF9XWhxKhYM2DqzYUjoYXmJB+ooxgNak2MRNlc1uY=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=c3sB6FD02sS3jqwIy3FiPz4KMrrn//3MNZ0ao8GBB4m5XZKYH/sDETLpJNNVSnFUhzRiS4QNr70sBhfoOI/9P/Q36AUBiLoWdkXVWlfNZJz3V57JKdjXrpcwqLnQVeHoz3XmmcGXZGdR94qrR6l8sLkIv7Jrwdz8LM7BeMYwDbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EGmvLmJT; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmHHtDtWP/wfqvjcUZqWXVxpOfJ6SWPdYDqyhwZjjf7DUaKfntlQyqQAIE6gOmr37AXQNXIVqb9vX4zvhUiQ0sQtz5LM76e3EULqlS5eCo8jtyU4/vEQkAk6MbnuvYGBIPN1/msoD6qQ4dO8EnzLVNanFFoDW/dndccN8HSp7bA/TyrWOSDv43Jv39miRqf3TgxJUH/HL2Qlu7GKDlf6WPnhyK8rWrCcy1isiwFWmKgcphfCBym94mdSuMyMxmdlHj96gqOVgJyvrhixrXnbb9XFIypeJRTV8QVbD9KQcf+8uGj3Intu02Mgc0GFUIImPux25GJ0L44BDKNn/Zb2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZw6bXe8A5HSvfqHwGJiPzU0iaqLxc0ULtjcpqSW5kc=;
 b=dDdNuExG46dVZM7np0CtH+S2OYrPSqVb8GPtRGV/76cRaugFZxPJ6AwnPZlwX9rIevVpsDCuRKz67pRUaBlBamjsYe/PK6uolNMaqcEmjQI14Ix7VDvcFS/Tv2IEhKWpYOObWspvzKNOlV8s9L0bqsimz4MRnimOMQvKHqeJmt5ceA9QgzEP5cHHdAcIqJvp0QFEAeEX+VnZ2gkAO05aKvSqPymGpOuZyoQ9Zs5skDL6uqmPZUSK/lOPiO/LA1+bnXgbNqqqXqYBcSpNU5F8dVs6kilxEm/Ys2CORRHUnqBQTF66comrVCJeZ77tw68TozFa63g95T5B1Ndmxb+7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZw6bXe8A5HSvfqHwGJiPzU0iaqLxc0ULtjcpqSW5kc=;
 b=EGmvLmJT/JXpEJ57GU7TUWcf2jp39Pz31Eq3nejo9+0egKahH+kkH9De6Hx8YTUjVEAuKsoNlmXeHsS2JBo6L87AUqOumk8VqLHMQuhJHJynZFd0xRjW/yZ0rZZoZoDK7SPPd64VMqGeKHgRMOHYvtbYIb+coi17ykkA7JxgPk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Thu, 15 May
 2025 03:54:57 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:54:57 +0000
Content-Type: multipart/mixed; boundary="------------rQsNx0vKpeB4dwiWHL6EEj0K"
Message-ID: <c5ad88e9-434a-4399-8e21-3c41e9295e93@amd.com>
Date: Thu, 15 May 2025 09:24:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc
 warnings
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 yuntao.wang@linux.dev, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterx@redhat.com, sandipan.das@amd.com, ak@linux.intel.com,
 rostedt@goodmis.org
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com> <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
 <aCRgRxmO6rsR-0k3@gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aCRgRxmO6rsR-0k3@gmail.com>
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 60954551-4607-4436-18d6-08dd936441e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFFOUEU4MEQrcGpJanIxUlM2WSs4U0FZY25NMHBtc25tbDVDK3g5SGdCME1N?=
 =?utf-8?B?RTF2YjVQVUFCa0FxUHMzc2FjdTZvNFhrL1NQbjdhRXZmR281UU9xSkRnR3Zm?=
 =?utf-8?B?ZXJJY3pMVitzbUdyQmlnL1hzQkJjRzJWamx1ZnU5SzVwZGJlTmN0Smg5Qm5t?=
 =?utf-8?B?OUJWOXRLb2V6Mit3NGwyc04rUUdiKzl5UDRES2pqOVg4NUw4eW4zQjgwOS9y?=
 =?utf-8?B?M0ZqcExOSThQRWlVbXBNZGtEMkV2WGVrcFZxNWNWUWptL2VhZWpKS0dBSnpt?=
 =?utf-8?B?ckFXazJDL21wZ1p6aDhHc3N2MWNJMDJkRy9HdWp6Mmx0SloyMWpRdWdCcUZZ?=
 =?utf-8?B?cGdMNE91MkVwMWFGampiOE50aDhBWVJaL0RoNWo0SmNXSUNPRzJqS2c1K09n?=
 =?utf-8?B?YXJDTTNZU3FYL25WYngxOTI4bFZwMWpjY1NiQ040K3BKMndWZ014YzJRcjhj?=
 =?utf-8?B?Q1dFTWpMMFNRbldaQW96bjcyS3FScDM3WEVHam5tL1V5dldGQmczQXRYYlE4?=
 =?utf-8?B?Mjl5OWhEb1ZoVG1uSDRBdzVEdUQyc1E5SG54L241NGtKNzJJdGUwWDZ1Um04?=
 =?utf-8?B?MHRqN09qYkR3UGp1VTMyWVRsSWNUVlRFYWp3Zkk3K2pYZ0Roa1JNWmNEdlNk?=
 =?utf-8?B?SXlMNk50dTB2MDBaUDlhbXFpRkErZE0rWlM2VTlVV3plMXBqVmxLeWZWNFhj?=
 =?utf-8?B?VWpyUUd6RGVKT1JoYWRkcHJVVWtmeXcyVUtxenVMTEZSVjM5YXFNL0hFcGFS?=
 =?utf-8?B?bWphdGV2UzJLRkVpd1NmSTgvbGZ1OVlpVEFldFNjV2V4TVJ0VDgyaTRNQ3ZP?=
 =?utf-8?B?d2FVZGtZUWM1TmdYdFJzazNwcEl0UXYrRlJxbE4vQU4vcDRWSHBTVDJrUVIw?=
 =?utf-8?B?VzlWY01YcjVyTzh6VXdFQnlUejBlZkpOcmJiUHo0ZytSM0hHWEJnQ00vVWlF?=
 =?utf-8?B?U1pXS3duTkNKK2x2QWV3R2lCZzdaMUxibmVUWXNlSUZDRzNHdWplZVo3bVBH?=
 =?utf-8?B?UWhBK01EVm1GbzFuRTR3cTV1TXhHRkhlWTRCaFdJSVlhRFptbGYvQ3dYeUJ5?=
 =?utf-8?B?MjlhSG9UTm5Fei9KcUpJU0tpUmZ2ek5DTjNsbG9ZRWNmSW1nNWNROVpxNHdj?=
 =?utf-8?B?RjJGakhMWnVwTlBlUXN6b2ZsS01iWjJENDc0QlRXYk9BOS9sUHJ6aGdjd0hm?=
 =?utf-8?B?dUt3K2lLeW5TMis3Ulh3ckJ1NGE2RzdURndNNGxzdHIzeHo1RjlrYi9USmF3?=
 =?utf-8?B?VCsrTVhtZDZRMEVhbjVyKzBVZTlwZTZHMGpkYzVLOHlaMzh5TlpzaUI4cjVu?=
 =?utf-8?B?MWYvWUV4UW5pMEIwZk80TEk5dHdON2tvVm5jaW1GYytvQjYzMmo2VDZvTFZW?=
 =?utf-8?B?Y01DV2dpcytMSEZ0Vzg3THIxTWhLcUk0dkRrakVnVjJwd1lkTGt5ZnJhU2xm?=
 =?utf-8?B?RG52M29naXVid2pqTExteWNTMHd4bFJlY2lPaG5xS0JDWHNqT3RWUFFGc2M0?=
 =?utf-8?B?WHV2NHhHTGk5d0ZCZFd3RzdWM3hRSUVmV0Vqd2YxakFKRC9JMHQwbkRXZFdk?=
 =?utf-8?B?TzlYZXp2dExOUFRyMFkrTlBzamlBdUh6eUc2OVhsWGRwVGFzSmV5VHM2MVZL?=
 =?utf-8?B?aTNzaGhLTGJXNE16Y2liREU1VUkwU0MySlZMRFdYQ1ZOVXlXRFZzNGNjNzE2?=
 =?utf-8?B?TUhIRUhSU21UbUZnd2lZRDhrWDU2SDA1MFBTU3RhTkJNZUd1S2dvM0lTVml6?=
 =?utf-8?B?QWhGcFhjRXczb25BeWFueTMxUUdzaC9tQi80SThpM3hzR1AyUlNNQmtOOEZL?=
 =?utf-8?B?cnFydFpmZkZsRGRsV1B0dnRpSjNBTmpMOTMzVlZnMU9VcGRabVljTXIxRXd0?=
 =?utf-8?B?cVpEdTh3K1A5eTZNZVJHb0FGUEVkSlZYdE5lZDRTYzBpUWxTZmh3VDVaTHNJ?=
 =?utf-8?Q?YJvWigZY6s4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THNTTFVVb0t5bFdIU0lJWmN6cGo1ZUw0cEhKdFc1S3JJeStTdjFUalRqejNr?=
 =?utf-8?B?d1NzT21SOTN2c3I3MjlFbmI5eUNkSDdDOTRnM05YMGkrNE5XNW1mODdMVUlN?=
 =?utf-8?B?UW1tcERBQUlhNDhraFduSHJsTTJXaEVpY0xZY0NQTG81cXF1MXJWaUpMODIv?=
 =?utf-8?B?VStYbXJFbGJRUi8vRmhFOUNWQ3VLLzlWWFhDekNGRDI4WHI1U1R0bUxCOWVv?=
 =?utf-8?B?U1hDMmgyQ0ZUaWJwOC9OS3gveEhOYmRxRTlsTzU1S0xsYVE1VmZMeC93bjE3?=
 =?utf-8?B?WUx1Q09iMmdrdGNnZGwyVWZrOXgycEh4STJBREk5NFJxQzY4K3ViS2FYaTZ5?=
 =?utf-8?B?c3pFQ0tvdWN2eVlHQkxCTkRuM2t2Z3huSlZpRmZJS3RCYzNFWVVtZWtuejRv?=
 =?utf-8?B?dUs2cEg2eURoNkMwQ3FjOVhWdU1UVUZrYUlVTjZPc1VRYkhZenVtU2taanQr?=
 =?utf-8?B?ajNkVU14eDJYUHprZWhSalFNTi9YTVoyY0JBZ2VWQk10VW43ZmZEMnRSUEZJ?=
 =?utf-8?B?UWF5dFJjT1oyMjgweUloRllmZGlKOHFleVI4ZXV4NXFyNk9zQU1nYVdkQWY1?=
 =?utf-8?B?YU52NkNoMnM3MU9zRS95UGhhU1ZlU3dBUnBwbVZTRHJUbU5FRE5NN2ZxNng1?=
 =?utf-8?B?ZGIvY3dlaHBvTnc1VXFZcmVkTG0xck02VlFiVkwxMFE4ZFhSRlQxa3RXcWxF?=
 =?utf-8?B?YjZBSHpIR2t3NUdFTG9ua2l5RE9kRktKcmVUbVA0enBFMDhsR2htQlBFVDIv?=
 =?utf-8?B?OGF6SjhtajR1SmR5Vm5DQzdXZExLU1crcENCL1hNLy90cXRoOW4vQk5GbWx1?=
 =?utf-8?B?aTY1MmdERzg5T0sweS8vUi9HRWs4TkpwNndpUHZsM0VQMkFyK3hoeXVGSXgv?=
 =?utf-8?B?dUFRWWpzKytrQWQremV5N1pvTW1aN1lKN09UdTJwRFF5YkRYK2s2Skt0ZUpj?=
 =?utf-8?B?NTdKVS9uaG96c2tPNHRoSndYOVpTQVFWWjI0c3BRZ1JJaVlyUnh0azZjUEhw?=
 =?utf-8?B?NkhDaHIxY0p2RE1TdmpCZnZZdFBPMGo1YjduVUxEdm1ha3ROSWd2ZmNYUU5w?=
 =?utf-8?B?OXRYVUFhMC9iK3hja3IyZHpGS0g4M01CQ3ZuM1lSTGdWREJoaW5lS3lWd0hM?=
 =?utf-8?B?SkNoNHdaSGR6cXhyRFB5aWUxSzFHNitpQ0l2eDhxRTMwWlROelN0RzRFMzJL?=
 =?utf-8?B?QXFsNGtZZHFhQVB0OFhhMThsU0Yrc2pSeUJsdXdsSm9sb1Z1ZzAxNTdjWVpx?=
 =?utf-8?B?SzBKaGFralQrQzBkWEc4OFNGV3JVT2NTejZqZVljYUUzYjRDMnZjRXU5dnly?=
 =?utf-8?B?bEhSbVVZS3BDZWhSd0Rhd3FCb3drWXpMVUNqYVBoTlN0bTBHWWMzcytLSmg0?=
 =?utf-8?B?UFA3MG5oTTVqT0FIWDNML0ZDWUMyeDc3cFB3UGRVMG02Y1pEU1dCVmN4S3NE?=
 =?utf-8?B?OWJIUmxaT2ZLTE15L01NajhxMEFleHdZN1g1MzVJN25vdzBqNlZVc0dGOWFD?=
 =?utf-8?B?NTRQU3hreUQyR2hRZExDNGl2RUFvL3BnSC9xdmZtRnViemllbjI0Qml1VjNP?=
 =?utf-8?B?ZEJ0Y2ZKeDd0RUkvamZ1NXBBWGJBNnN4R2VGK2p0MXVxUFU2aURtSzNGUkxH?=
 =?utf-8?B?MklBVnhBeWZHQXlsRmVENzVsdURwSWlsUUpObG9sRWJTWVFJU3JuTUJrdUdL?=
 =?utf-8?B?MjBKZ0V4b0JuVUQwZVRRT0kzVUR6NGVBamlYdTIvRy8wOTNMQ0lWZW5yVGtE?=
 =?utf-8?B?NHJnd2Z2NUNOZmNWaS9INFV2WjhRbWxNMGNuaUxncVI5bDZEOVRRa3ZBY2tF?=
 =?utf-8?B?eis1OFJTUFk4ZXljajBvajhQSDR0SWRFN0F1cHpsTldMS3lKRTdIek5GWkp1?=
 =?utf-8?B?QVRYcHM1bkp4MkRWbENRZVlXMkV6cU5hTkY0a01RM1dhSFNFZzE1R05pNG9i?=
 =?utf-8?B?QmVwdjJMcTZXMzhEWUxkRGFPTXBNN3M0bkhSdVZtenJWeGFqVUxzRU1BWmtF?=
 =?utf-8?B?YS8yeUJJdUsxaFUzWjM4RzZWNEgxRStXSDg2U3R3V3lmZ002elcwbGZpZ254?=
 =?utf-8?B?YkFJSjZjd1NMRGpDeTRwbENPRDhTaE9lQWZxK1BJSlJBZjAxYUJjVTlOMnYv?=
 =?utf-8?Q?gyYkTb8lL3zyQTKCXRtTAkJfQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60954551-4607-4436-18d6-08dd936441e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 03:54:57.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6x1tyGz2Q54tTomA9RPwInYijs42oqRXh2qjs44jTs9Umas+rWviFSwIBGClZAkW01uY6U13sKXdcyc0AQ82Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

--------------rQsNx0vKpeB4dwiWHL6EEj0K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/2025 2:50 PM, Ingo Molnar wrote:
> 
> * Shivank Garg <shivankg@amd.com> wrote:
> 
>>>> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>>>>  #ifdef CONFIG_X86_5LEVEL
>>>>  /**
>>>>   * p4d_set_huge - setup kernel P4D mapping
>>>> + * @p4d: Pointer to a p4d entry.
>>>> + * @addr: Virtual Address associated with p4d.
>>>> + * @prot: Protection bits to use.
>>>
>>> How about using the same capitalization you already see in this 
>>> description?
> 
>> Please review the revised patch with suggested changes.
> 
> I think you misunderstood: why are you using 'p4d', while a line before 
> it's 'P4D'? It's an acronym, and only used lowercase when it's a local 
> variable. 'p4d is a pointer to a p4d entry' is doubly confusing in that 
> regard ...
> 
> Same for PMD/PUD etc.
> 

Thank you for the clarification. I understand it now.
I hope the attached patch looks good now.

Best regards,
Shivank
--------------rQsNx0vKpeB4dwiWHL6EEj0K
Content-Type: text/plain; charset=UTF-8;
 name="0001-x86-mm-pgtable-Fix-W-1-build-kernel-doc-warnings.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-mm-pgtable-Fix-W-1-build-kernel-doc-warnings.patch"
Content-Transfer-Encoding: base64

RnJvbSAzZjRmYzJjY2M3M2EyMjI1ZDM2YjJhMjgxMThiNDM0YjVjYTk2YTdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+CkRhdGU6
IFdlZCwgMzAgQXByIDIwMjUgMTE6Mjk6NTkgKzAwMDAKU3ViamVjdDogW1BBVENIXSB4ODYvbW06
IHBndGFibGU6IEZpeCBXPTEgYnVpbGQga2VybmVsLWRvYyB3YXJuaW5ncwoKU2FtcGxlIHdhcm5p
bmdzIGdlbmVyYXRlZCB3aXRoICdtYWtlIFc9MSc6CmFyY2gveDg2L21tL3BndGFibGUuYzo2MjM6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdyZXNlcnZlJyBu
b3QgZGVzY3JpYmVkIGluICdyZXNlcnZlX3RvcF9hZGRyZXNzJwphcmNoL3g4Ni9tbS9wZ3RhYmxl
LmM6NjcyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0IG1lbWJlciAncDRk
JyBub3QgZGVzY3JpYmVkIGluICdwNGRfc2V0X2h1Z2UnCmFyY2gveDg2L21tL3BndGFibGUuYzo2
NzI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdhZGRyJyBu
b3QgZGVzY3JpYmVkIGluICdwNGRfc2V0X2h1Z2UnCi4uLiBzbyBvbgoKQWRkIG1pc3NpbmcgcGFy
YW1ldGVyIGRvY3VtZW50YXRpb24gaW4gcGFnZSB0YWJsZSBmdW5jdGlvbnMgdG8KZml4IGtlcm5l
bC1kb2Mgd2FybmluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFt
ZC5jb20+Ci0tLQogYXJjaC94ODYvbW0vcGd0YWJsZS5jIHwgMTYgKysrKysrKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jCmluZGV4
IGY3YWU0NGQzZGQ5ZS4uZTkyYmI2MWVjOWQ3IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9wZ3Rh
YmxlLmMKKysrIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jCkBAIC02MTQsNyArNjE0LDcgQEAgcHVk
X3QgcHVkcF9pbnZhbGlkYXRlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBs
b25nIGFkZHJlc3MsCiAKIC8qKgogICogcmVzZXJ2ZV90b3BfYWRkcmVzcyAtIHJlc2VydmVzIGEg
aG9sZSBpbiB0aGUgdG9wIG9mIGtlcm5lbCBhZGRyZXNzIHNwYWNlCi0gKiBAcmVzZXJ2ZSAtIHNp
emUgb2YgaG9sZSB0byByZXNlcnZlCisgKiBAcmVzZXJ2ZTogc2l6ZSBvZiBob2xlIHRvIHJlc2Vy
dmUuCiAgKgogICogQ2FuIGJlIHVzZWQgdG8gcmVsb2NhdGUgdGhlIGZpeG1hcCBhcmVhIGFuZCBw
b2tlIGEgaG9sZSBpbiB0aGUgdG9wCiAgKiBvZiBrZXJuZWwgYWRkcmVzcyBzcGFjZSB0byBtYWtl
IHJvb20gZm9yIGEgaHlwZXJ2aXNvci4KQEAgLTY2NSw2ICs2NjUsOSBAQCB2b2lkIG5hdGl2ZV9z
ZXRfZml4bWFwKHVuc2lnbmVkIC8qIGVudW0gZml4ZWRfYWRkcmVzc2VzICovIGlkeCwKICNpZmRl
ZiBDT05GSUdfWDg2XzVMRVZFTAogLyoqCiAgKiBwNGRfc2V0X2h1Z2UgLSBzZXR1cCBrZXJuZWwg
UDREIG1hcHBpbmcKKyAqIEBwNGQ6IHBvaW50ZXIgdG8gYSBQNEQgZW50cnkuCisgKiBAYWRkcjog
dmlydHVhbCBBZGRyZXNzIGFzc29jaWF0ZWQgd2l0aCBwNGQuCisgKiBAcHJvdDogcHJvdGVjdGlv
biBiaXRzIHRvIHVzZS4KICAqCiAgKiBObyA1MTJHQiBwYWdlcyB5ZXQgLS0gYWx3YXlzIHJldHVy
biAwCiAgKi8KQEAgLTY3NSw4ICs2NzgsOSBAQCBpbnQgcDRkX3NldF9odWdlKHA0ZF90ICpwNGQs
IHBoeXNfYWRkcl90IGFkZHIsIHBncHJvdF90IHByb3QpCiAKIC8qKgogICogcDRkX2NsZWFyX2h1
Z2UgLSBjbGVhciBrZXJuZWwgUDREIG1hcHBpbmcgd2hlbiBpdCBpcyBzZXQKKyAqIEBwNGQ6IHBv
aW50ZXIgdG8gdGhlIFA0RCBlbnRyeSB0byBjbGVhci4KICAqCi0gKiBObyA1MTJHQiBwYWdlcyB5
ZXQgLS0gYWx3YXlzIHJldHVybiAwCisgKiBObyA1MTJHQiBwYWdlcyB5ZXQgLS0gZG8gbm90aGlu
ZwogICovCiB2b2lkIHA0ZF9jbGVhcl9odWdlKHA0ZF90ICpwNGQpCiB7CkBAIC02ODUsNiArNjg5
LDkgQEAgdm9pZCBwNGRfY2xlYXJfaHVnZShwNGRfdCAqcDRkKQogCiAvKioKICAqIHB1ZF9zZXRf
aHVnZSAtIHNldHVwIGtlcm5lbCBQVUQgbWFwcGluZworICogQHB1ZDogcG9pbnRlciB0byBhIFBV
RCBlbnRyeS4KKyAqIEBhZGRyOiB2aXJ0dWFsIEFkZHJlc3MgYXNzb2NpYXRlZCB3aXRoIHB1ZC4K
KyAqIEBwcm90OiBwcm90ZWN0aW9uIGJpdHMgdG8gdXNlLgogICoKICAqIE1UUlJzIGNhbiBvdmVy
cmlkZSBQQVQgbWVtb3J5IHR5cGVzIHdpdGggNEtpQiBncmFudWxhcml0eS4gVGhlcmVmb3JlLCB0
aGlzCiAgKiBmdW5jdGlvbiBzZXRzIHVwIGEgaHVnZSBwYWdlIG9ubHkgaWYgdGhlIGNvbXBsZXRl
IHJhbmdlIGhhcyB0aGUgc2FtZSBNVFJSCkBAIC03MTYsNiArNzIzLDkgQEAgaW50IHB1ZF9zZXRf
aHVnZShwdWRfdCAqcHVkLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdCBwcm90KQogCiAvKioK
ICAqIHBtZF9zZXRfaHVnZSAtIHNldHVwIGtlcm5lbCBQTUQgbWFwcGluZworICogQHBtZDogcG9p
bnRlciB0byBhIFBNRCBlbnRyeS4KKyAqIEBhZGRyOiB2aXJ0dWFsIEFkZHJlc3MgYXNzb2NpYXRl
ZCB3aXRoIHBtZC4KKyAqIEBwcm90OiBwcm90ZWN0aW9uIGJpdHMgdG8gdXNlLgogICoKICAqIFNl
ZSB0ZXh0IG92ZXIgcHVkX3NldF9odWdlKCkgYWJvdmUuCiAgKgpAQCAtNzQ1LDYgKzc1NSw3IEBA
IGludCBwbWRfc2V0X2h1Z2UocG1kX3QgKnBtZCwgcGh5c19hZGRyX3QgYWRkciwgcGdwcm90X3Qg
cHJvdCkKIAogLyoqCiAgKiBwdWRfY2xlYXJfaHVnZSAtIGNsZWFyIGtlcm5lbCBQVUQgbWFwcGlu
ZyB3aGVuIGl0IGlzIHNldAorICogQHB1ZDogcG9pbnRlciB0byB0aGUgUFVEIGVudHJ5IHRvIGNs
ZWFyLgogICoKICAqIFJldHVybnMgMSBvbiBzdWNjZXNzIGFuZCAwIG9uIGZhaWx1cmUgKG5vIFBV
RCBtYXAgaXMgZm91bmQpLgogICovCkBAIC03NjAsNiArNzcxLDcgQEAgaW50IHB1ZF9jbGVhcl9o
dWdlKHB1ZF90ICpwdWQpCiAKIC8qKgogICogcG1kX2NsZWFyX2h1Z2UgLSBjbGVhciBrZXJuZWwg
UE1EIG1hcHBpbmcgd2hlbiBpdCBpcyBzZXQKKyAqIEBwbWQ6IHBvaW50ZXIgdG8gdGhlIFBNRCBl
bnRyeSB0byBjbGVhci4KICAqCiAgKiBSZXR1cm5zIDEgb24gc3VjY2VzcyBhbmQgMCBvbiBmYWls
dXJlIChubyBQTUQgbWFwIGlzIGZvdW5kKS4KICAqLwotLSAKMi4zNC4xCgo=

--------------rQsNx0vKpeB4dwiWHL6EEj0K--

