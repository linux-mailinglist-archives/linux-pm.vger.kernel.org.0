Return-Path: <linux-pm+bounces-27119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F2AB6545
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D1F3AE3F7
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B372216386;
	Wed, 14 May 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fz7a9Osd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85720B7EE;
	Wed, 14 May 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210019; cv=fail; b=pRFLIRTZnZUQiHlvQmJVVy8RakkzKHeO0nxJ0Gd4uVxDRFEhDqaBAtEG92vOuHz8TdAMzkciV+EcNxSuq+Q8mfYGylgh6kjQSdtThy3uwcUzWCeRTv9fyPsjxEb+Li2rGWexLwnpBx0/AX+UawczkrMWAlKZ0ojGDavERbheM+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210019; c=relaxed/simple;
	bh=8aPEVciDhPxk3t18OUayc0s/iYw487g0PI3OXldnTcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ka+FnGa/FbseQGRJBjOynkQ6xNW/jZd/Rw6d4JCrEovBX10yw49QNb3kgqtvau7QQ495P8fQVYcSJCKgU1akJ9qDt3Bb6uqEkDKymdpZxfTrf6vGSy7hf6pG2QFG404/libyq9Pam/mnaCszdliVKCIDIGLHuj7lgn/bmpz2My8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fz7a9Osd; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1Q0Iv/FGtypZ5azrBrCOg1bHNS3GZPN5uMkvwZYY/OwsfaT8I8Lbltb2oXHg62X6DzkQmxaUGvaznncokEcF8DtcJJZSSR+gc8/Y/Ruvl+pOOIbax1C6t0mTKxRmVgioA6nFbYhpmDq4+kHXF11fj3bg0K5wnu1wIdZXIl/4iQlRHQsOCRzWg9Il+Bcg93pcqbL9ITU7h5FuFh15rum590RmTh3Wr5hcly9azSjtKfP71cl7270UjK2xa9Kps+jQDrx5K323e6GFUVdA9ys84XyNqKP5+AMX9U4tcXRB1muUB4sdOVde4ZFxY5EEQqt741cRUvn2PuG101aH16XzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1EKTFMxnFAsI63vti+HJDxvzj/r9gyV9q2aF9AMePY=;
 b=J502NgAA6N/osB4h+kxT6tmo/wzEqOKAgNePcA8GljROLfKKoBK6h7KCXAXb0Wfk2II7l+aCfSqXC6WzmW7ITxPIFXIy+iS6Ybagz+bf1AxnuuO86U6OtlsaiMdH7reWSoImV5kld7aClLcMSKDYWaJQ1nA3cPg8OxFjgSlpq/YFBq+XyfcBSZj3C+oBG18YK5/K/PCwUKQoD8I9R9/Y5mRFsjNeuEmSzQ5ThtxaXcXSRCAzAm4mGTjX6vMC6qionDiuuX/qsuXoHd020mRk3SS7xfGNnZfgL6zfDzhx5s5iz3cNqhMvr+4QjY/ymvqJ9Z97SOndxetnx6DJSSYVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1EKTFMxnFAsI63vti+HJDxvzj/r9gyV9q2aF9AMePY=;
 b=fz7a9OsdJKVk/ykvczxlFpgWzTWY61BJOgDCo0Cup/A/tDFtY4RnWcw74SuDUUvUam77CklUJF6jGJzFKVp35owo28s1/oH5PXJdolY5HJwhj3TyYgh1U79+bd86wjJsltC2s+tRgP9ZW91tdGskKKC6wclQKrtu5NcFFxpT0hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 08:06:54 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 08:06:54 +0000
Message-ID: <088e9ed8-2970-4efc-b1c4-ae84053e6ab1@amd.com>
Date: Wed, 14 May 2025 13:36:41 +0530
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
 <aCRMT0TlpFvpRGYk@gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aCRMT0TlpFvpRGYk@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::35) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ac358f-fbdd-423f-480b-08dd92be4a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGRtbkJCVzkvd1A1L29ZVjdPV1p1TFBqR3F4VmZSRDdGTDYrZ3JnTnAxQnBU?=
 =?utf-8?B?U0tJMHlzQitCNTBrZ0lqbzFUN01lRytCK2xRWXptaklJNmU3QU9FUUp3Zndn?=
 =?utf-8?B?YngzN1hSSm5hUVlRTGNjMWFrdjRPY2dXcWk5MEZjQ3BpME80RzRTaFpxb3gr?=
 =?utf-8?B?MWE3VjNDWngyRTdFbkgwR0dRTkdtcVdoTWdxMk9tSVlqNllKR0Rpc3IvNUhx?=
 =?utf-8?B?ZjJ6aW54M3NSckFwTCt1SG5kalBsUDlCWldXdGtyRG40NHFia2xJclRaaDNs?=
 =?utf-8?B?SDhSc3BRaEIyaVZQbk42U25JSUdqK0pyTG9uK0F2TVBmNmhNck00aGtFUWU4?=
 =?utf-8?B?U1QzMGwrZmtXeGV6UDVEQnI0RGFZcnFPSFBHZWhOSlJQNHBtbHBRNUtaNDRF?=
 =?utf-8?B?UU1yMm5EZndsRkc4K2xuVDdFaXN4ZWVHcG1UNXU3YWN1eVRjVEo5VTQ0MEVt?=
 =?utf-8?B?TzN6WXE0dWZGbGlhU2RnZGtXUi9XamVTQzVXTm9hT0ZzK2pybkxUYWVScjdh?=
 =?utf-8?B?MFV0aDF1ZFYxTnZqc3p4czVoSUxKWTM2dFZnWXRhM1ZWd2U3cDVZU05zWG9U?=
 =?utf-8?B?Yy9BdHpxNXV6SzNxakhqQTlmOE9sRGoxWUZtdjFub3Q4c2xwdGNha2dHZVdB?=
 =?utf-8?B?Tjdwd1ZGZnFYbmtxZ3p6MGxhTVlISm1ndkdHWDVoVGwzN2ZkN1pncTRrdjF0?=
 =?utf-8?B?cUFSWHIxRXc5S2N6TjNpbXlsTDErZzQrRlNtYWd2akpYenRxL3JUUE9rMDg2?=
 =?utf-8?B?Mlk2UmpOOENvbm4rUGhFTmdwTTZXUlVUMGZTUWJnR2Q4UWIzRDFwM0NEdVlX?=
 =?utf-8?B?Mkw0M3ZCZmwvSFZjdGpSTzllZjZsS3J5U2cyY2JKRHI5aVF3Q0cwN2JlNW54?=
 =?utf-8?B?ZHdFV1NpY0lHOE51aHZtZFE5dDdsczJqWWRyK0lUYUErZVoxZWV0VmZBTlNq?=
 =?utf-8?B?cVNYL2pETXdkNnlSTS82ZURtSkxKOVJMaXhkZkxEckZFeWFrMHlLMmZLbUNx?=
 =?utf-8?B?aVExWFZsdnEzaU9pMU9GRHpvWWZsL3JueXZjTEF3RitvR0wxYnd5RUlqSS9m?=
 =?utf-8?B?NGFCdVhwR0NhMWNkKzZlOGZpQzFXdkN0NlZkSW5YUzUvS1laSTNSbnFBMGpw?=
 =?utf-8?B?SkZ2b3RLdWZrYlpUM2pnOFlpRXc4T2ZVOCtkOUgyanJMWG5MRUt0Rm9aQ1BU?=
 =?utf-8?B?bUg1U00yenBrRUZVTzk1Wktqb1E0ZloyNEFjQ3M5M01ES2E4T05oMzkvQkho?=
 =?utf-8?B?bWVjZzBLb2ovWDhFUXI3Ulc4Z3pFbDFsUHNSSGd2bzRvNng4Y2liM0wyMjR1?=
 =?utf-8?B?ZjBhYWdUUDJ5RmEvTkM0Qy9xcUhXVnVLYUI2R3BjcHpyVk56dzZ2Y1BvMEZT?=
 =?utf-8?B?dVlqL0FBa2U0SXVVV2hGSkhHU2gyTmxWT09XdUZlRVZrMUN1RFhLNDVmU0ox?=
 =?utf-8?B?YnZMSEpTZG43emI1Nkx4T2ltQzFkcXZWSmd5NS9SWDk5dGJFNldBaXg2TWUx?=
 =?utf-8?B?NnVIMDIvUFpnNHh1bnQyckNiSzYwcURZT0VIT25Uakp1UTVEelViMG5TR2ts?=
 =?utf-8?B?Ym50OXpwT0VYVWc3WHN1OHljTWZtTTdQazY3ZWc1WWpkbEM1OEhiWDdJM2Fa?=
 =?utf-8?B?c28zY0hOSHRpTlhnQ0Nya2cvcUt1enoxL01LNnBNMUxpZlV2akY4T2IxNHhr?=
 =?utf-8?B?b2ROUjZ1NXRMQnNRaTFQdk9yeGMrZWJZTThqbzJzUlV4ek5JTkJKcXRKYURV?=
 =?utf-8?B?cUlhQmwyQmI2RHlvbzdDMmRYb1FqNklqVjF3ZzB6UXJZZ2xvdVgyV1FmUXRO?=
 =?utf-8?B?Tm10YXo2NXUvaUdzVEh2c2pkeFIvcDJHZHUwbXVFa3MxU1BRQWh1VTRxS3F5?=
 =?utf-8?B?WW9OVFBIWjFLK2FJbUM5OFBZazZGblY3RDBsVTBKZnBWaDIwTi80SlI0MWVI?=
 =?utf-8?Q?mafAw9UJp2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkQyMUdrNzl2bnVnZUtoZXNqQlVLVUwxR3dnR0RndUF5UWVOaEhhMUFqSzF4?=
 =?utf-8?B?dWh1RFJscUJsbENtNDhRVEpnSk80cms0ZTRwUW1Tc3ExUDIxUFNMWHVoZzQx?=
 =?utf-8?B?KzM4Vk5BWE5QSmlLNm1qVkZFZ3A2NVBoNGlBMWQ4dUs4enlnWFdsRUs0V3Mw?=
 =?utf-8?B?T1Q3Wm5FVVBqRk5KcFludCtVcldCRSs4Q0hFZnRqVTFLTVhsZ0NkWEJCVzgw?=
 =?utf-8?B?bGpPZnF1Z1gyTElQZHYvdjA1V1dLTWtFWE9GNVl5SS96cTQvL2ZUSmh3RHJq?=
 =?utf-8?B?SGwvdC9mZDhRWDRQa2tZbE5YeEFoS2ZqeDVleVVEay9lSUErQTdWVmpDUzZL?=
 =?utf-8?B?TWRIUytYL3NMcnkzYjh2MjRnb0hSWXQ5RDVzMGpLWVp6U0ZLbFMzSTZaMlhC?=
 =?utf-8?B?UDdacXphSVc4elI2NkpFb2JmbnJQcjk1Q0xieGhoUkVSWExXMnIyRW1ZMGIv?=
 =?utf-8?B?VDNsemUzSjBxL0MyVkFOdE9aTTFnWjRIQVMrRjNMd2VHTk8zem9QTXFxc2E5?=
 =?utf-8?B?aDhqblV0aVdscjJwN0JTSjdhTDB3Rlo3Vy9ldlVkd1F6OUNCQUQvVzlxS2NI?=
 =?utf-8?B?cTFGVjUzRjdRZHRHZXNCS2ErTHNlL1NCSlpIYW9CN1lzR0tib2QwMVRrS1Ay?=
 =?utf-8?B?WmNaa1FLQXZMTks3UzlFTFM5OFV5Y1Zrd3ZrSGVJQVJqQWFMOFBUaUZSRVI2?=
 =?utf-8?B?Lyt4U1pYQjRtMFlJcWFqa1dzaGUzcjU5dGxBU3hDMUp6ZGpzaGI0Qi9wbUxs?=
 =?utf-8?B?WW9LNDFuY0MxVjJOd2hPQ2MvRGYyeDRjRGdxeVNhMURmUzFuTzNGNytQVkkx?=
 =?utf-8?B?Y2ZEdVhXRjB5UTJzTXJzZGNTNDJ3d2RvY3NDRXpzSm1IdG1YK3JSczk2Rkl6?=
 =?utf-8?B?YWVnV003eUJLOC9mUlhKRXljZDVEWDc1cCsxL1R3b2liblFhakcvdjRjZHNC?=
 =?utf-8?B?REUwamkyRnVUZ09HdktwSmNyYVQ2OWZPY3E3M2RER0Y2UThOd0xJQ3pSME8x?=
 =?utf-8?B?a2FnTjJFVjQrdDlyU2wzdllBQXhTcUd1RDc3S3gyTWt5dXl1SDlhOEw5c245?=
 =?utf-8?B?NFpENUhoS3luUTRCaGV4bGNWcnBtQWlXYkhTUnMxcVE4eGJBRXZuTnBtbVJm?=
 =?utf-8?B?RFhGSVBkcEhJUWJXeFpJUHB2TGZzbEYxUHlzNGQwaERvVEVENHoxV3ZRejJp?=
 =?utf-8?B?YkJOSTRtRWVRVDRtK3VZUWNlZFRvcGZQVU5mNXhzbXUwVUd3TU51RHFlY0FZ?=
 =?utf-8?B?MjNsU3FydU1ESHBMNEd4R1RmSjA1RDk1YmdQSmxUTkwwWEtQTzdVTEdLcXhG?=
 =?utf-8?B?cjJsQVplZ2ZXSU5MTytNU2UwRzFMSDNOcWpWbVdVZXRVaXc2MHpJYUViSmp1?=
 =?utf-8?B?bGs3VUZNK3U0aFlkWWMzd0oxdkhsTjhId09SVEZmSUs3SGxPcTdBVjU4aHRE?=
 =?utf-8?B?Y2dTNXRXT2U3c3RzSm0xYWhSOEFDek1NcDd1cWdpNWZMZ0xjUjY5eC9uMGpW?=
 =?utf-8?B?dFFBdjh6blBMQkFEbVlKYmt1RnQzYzVWQUJ6d1RHRUxVUEFkTmxvZGIzMUNh?=
 =?utf-8?B?STlTNkhFM0lCRzY4M05UZys5dGVVWHNhNWFlVmJzdnFwbVNnbXFJeWxkV0kr?=
 =?utf-8?B?QXBqSTZHN2VyaXdmQkljdFhYc3lITFlWYVVzamgrVmpMY2pMczNWa2lXVEI5?=
 =?utf-8?B?MldYMGdUanp6Y3RHOGFkVXVhZC9wR0p1SjA1alZwMzFqK25mbGYrRjJPT3g3?=
 =?utf-8?B?UUU0NXRDYWVka21lcUpQREs4TGpaTlFwT3R0OWE5RG0zUVZDNlUwTWN0cUFz?=
 =?utf-8?B?QmY4by81NTJUaGdjdUdsQU5YQTRxcVF4UEoxd3RTeVBVMkNJRC93a044SUt3?=
 =?utf-8?B?T2lhQ1czUllXbUJVOStnOEdkRzQyWnphcmdJTmtkelh3S0p2RlZSYW1oYVhu?=
 =?utf-8?B?bElDcnZUYzFLS3ROWlFNcG13TEc1VXNudmhybDZtNGRURG81YkM5enJJelVY?=
 =?utf-8?B?QTlXeCs0aHlDYTdNeURseHh2d0xzZEpnakVPbDVEYmg1WHNTZ01zRExlNUFi?=
 =?utf-8?B?aTROUzFValdzUTROMjE1Wk5NQlp6YkxNWUptbHRtOEdKWUROY1FvOFNJNCsr?=
 =?utf-8?Q?0aVu8h11XwkERJpeKHuG0+yWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ac358f-fbdd-423f-480b-08dd92be4a30
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 08:06:54.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/miMET2s0VHwpWgHQaPhagSZvB9TEAAWn7ZxzwQItmUj4OJMrNLNS4p/O7Kpjf507FEHsuW9jdH6jOgueZBKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294



On 5/14/2025 1:24 PM, Ingo Molnar wrote:
> 
> * Shivank Garg <shivankg@amd.com> wrote:
> 
>> Warnings generated with 'make W=1':
>> arch/x86/mm/pgtable.c:623: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
>> arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
>> ... so on
>>
>> Add missing parameter documentation in page table functions to
>> fix kernel-doc warnings.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  arch/x86/mm/pgtable.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index f7ae44d3dd9e..8a5bc4545ad3 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -614,7 +614,7 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  
>>  /**
>>   * reserve_top_address - reserves a hole in the top of kernel address space
>> - * @reserve - size of hole to reserve
>> + * @reserve: Size of hole to reserve.
>>   *
>>   * Can be used to relocate the fixmap area and poke a hole in the top
>>   * of kernel address space to make room for a hypervisor.
>> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>>  #ifdef CONFIG_X86_5LEVEL
>>  /**
>>   * p4d_set_huge - setup kernel P4D mapping
>> + * @p4d: Pointer to a p4d entry.
>> + * @addr: Virtual Address associated with p4d.
>> + * @prot: Protection bits to use.
> 
> How about using the same capitalization you already see in this 
> description?

Sure, I'll keep the capitalization consistent with existing code.
> 
>>  /**
>>   * p4d_clear_huge - clear kernel P4D mapping when it is set
>> + * @p4d: Pointer to the p4d entry to clear.
> 
> Ditto.
> 
>>   * pud_set_huge - setup kernel PUD mapping
>> + * @pud: Pointer to a pud entry.
>> + * @addr: Virtual Address associated with pud.
>> + * @prot: Protection bits to use.
> 
> Ditto.
> 
>>   * pmd_set_huge - setup kernel PMD mapping
>> + * @pmd: Pointer to a pmd entry.
>> + * @addr: Virtual Address associated with pmd.
>> + * @prot: Protection bits to use.
> 
> Ditto.
> 
>> @@ -745,6 +755,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
>>  
>>  /**
>>   * pud_clear_huge - clear kernel PUD mapping when it is set
>> + * @pud: Pointer to the pud entry to clear.
> 
> Ditto.
> 
>>   * Returns 1 on success and 0 on failure (no PUD map is found).
>>   */
>> @@ -760,6 +771,7 @@ int pud_clear_huge(pud_t *pud)
>>  
>>  /**
>>   * pmd_clear_huge - clear kernel PMD mapping when it is set
>> + * @pmd: Pointer to the pmd entry to clear.
> 
> Ditto.

Thanks for the feedback.

> 
> Thanks,
> 
> 	Ingo


