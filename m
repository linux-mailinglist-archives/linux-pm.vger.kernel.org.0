Return-Path: <linux-pm+bounces-7610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46198BECBA
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 21:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3234F1F22F9D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35016DECF;
	Tue,  7 May 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbY5gw62"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFC150999;
	Tue,  7 May 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110712; cv=fail; b=KaJR+CKlnDdP1wcaQKHAiNTlWVIBVzSE6owH8ZtwdCW0wQXyNF/oK9bhJM2DfIQM/DntyMMNd+FXHxNkEgOagHo9zrXkKnmsjdKNG1I+yS2st+c8MqLsMkMFXGoHANmj2fxSVB7WGO+4VAOYiTuLOJrxLuq7+nePnLXWfAn+Nnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110712; c=relaxed/simple;
	bh=1ji5rWUYXDMgTFGAYqs7rEGtpcwjHEcPKOzHUmNVDBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gBjFyf3TzAsgNsdYUjMwjGtwv2I0pCgzmNWygHzqdLoZp308DSsqh2t9ULxtqIkF5FNDid+JwWMht5MuNA/thCWIvrDWt7HnXEpOzBI4TqjjqHxvrkfw3yNsNUH1J8ynOaaNmJUMwYIqFtO124caSUVsD8rx3IdhQ9wVD5dWJKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbY5gw62; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJMSJ7EPzLIIX27h4AxwCycCRxkhPvqHyTfQxYHpgbHlshPegRqhoxbdpRk3uwvCYroXMZhcrQ/FEPOgi0t/JtbzyKlgQxxbbsGHjInzVKTKcr/wRzncK6xKRIttzw1nBJ9hLdznkZ4w14ajPi3aKcHHYuIw4usJ4ihT3kwAkLbSZabTCuxOe/CNSg5+Xax/tH1tpqUUVd4mcWXOnUNFonoOvFzs9xDbOoUTo2W5OnbkpILfhe+K+priXsMOHa9GdrFQyPqTm/k2l+M4+jaYduzwqefDYVsg4LYhElWulNNAZagnLMdH+ikRa31f4XyYgNfiXTWLykGV8mbrFGnkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKIrsaNRl8Hot2PN5kSodQmdSgxPXr4cBjZffQVc96Q=;
 b=OsZ6U0Kz5akb5ym4qgBgg3gn4H8X3cGFnHB0qYwx3OM920s0gwHZFIsco0Moxqn+4G5pj59iG/oZ9/032hkR/bFBmNMeWzRkAqnK7TuH7+dZm2NmX2vZwga79P9YxiqCNfLVmsQjGpPtrRD/vP191Im7zk5a/m5el1A7ogjQ2TFRlhnfcxEkgPL7yxe5G2EGS4xskFPv5DbHjqrKdtNmUW0u+l7NZb5Oz+9V7odxgqO88M2HvuCaJZhWQvp6eQtATZURM+D5VbFytod/DMIMfcIoFuRFH4ZXV45GFpnXydAKJsxDuhcXwN8XbeLNvY++2Wk0+dTJbFlQ6bYEe/vg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKIrsaNRl8Hot2PN5kSodQmdSgxPXr4cBjZffQVc96Q=;
 b=FbY5gw62KPYJMCbgPBy21XCtu37kPKWxnxZRL+16yEeazFTGi1ZGQCv5jPDU+sltBrDEdNbKMPKQTTDaAGPDOT+ZPFaJhqphNsMOUcfKdHNbujSeAQ9NlRzAcJD30Qn5T/Cdv20QIPdNdG4HXNpYWMWGDuzCyDZxaYXizJuuiW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 19:38:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 19:38:28 +0000
Message-ID: <e5c1f325-ff15-43f9-bb79-bcae71693b81@amd.com>
Date: Tue, 7 May 2024 14:38:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue
 which limit performance
To: gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, rafael@kernel.org,
 Perry Yuan <perry.yuan@amd.com>, Gaha Bana <gahabana@gmail.com>
References: <20240507174810.46709-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240507174810.46709-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:5:334::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8101d2e1-f5c8-494f-1b2c-08dc6ecd44f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SklkeEFvMjVoeENZNmxxemtsdkw3SVM5Q2NLcWJSN3dUZkpPYmorWFVvbGVh?=
 =?utf-8?B?UkNDajQzY2ppREh6NXc0VSsyZEUwYWk0V0ZlajdRd3gwZ2l6djJjRXhqdkkw?=
 =?utf-8?B?SlBsK0N4NmJPVU9KZHZkUXc5amxKS3d1VGFRUUt6NHptMHBwSHlzSHFxZFps?=
 =?utf-8?B?K0ZvM0pOYjNBcGpLUitCWkxhVldocEpnM3FRZFhabS9zdjhGdVd3Qmo2NkU2?=
 =?utf-8?B?eTY4TEt6QzRaQjV1Q1dQVng1SU1aMDdUL1hLcDFjMVd0cXhLYWRobzVUSXc2?=
 =?utf-8?B?ZENQOVRDdC9NNlA0OWNUblVSMnYvdTROTktLOTRMNGJMVTJLUjkxZEw0Q0dO?=
 =?utf-8?B?Z2NqQTBaT3RYUDUzZjRFMnBBYVJRbW9wMGxKUXhpeEVGdWxCbDNTbUFoY0xN?=
 =?utf-8?B?dTczekZYdkxpQUYxMDY5NDNOTnVvV1Iyc0xwNHFPa1B4bnZuZkZlTVNyQm5J?=
 =?utf-8?B?YWhBejFYQWo2UlAyR29VcmhHdW1PejZmdzVPd3Ywbm5oWWpVL3FGR0NzMUNy?=
 =?utf-8?B?a3p1bEZJdTNOaGE2ck5hT2RUWi9oTURhbU1ieGZJdkswOUZWNGNtbytPbEJP?=
 =?utf-8?B?TU50clNpdmR6VlJkWmpkTVpkRGFSK1B6MGRteC95TXhnVWRTZmhqUDh2Yk53?=
 =?utf-8?B?VFduRXJtbW9aSDlmbFpRZ2JGT1IyQmNvYmFCRGoraytuMEZCQjZXS2QvWis0?=
 =?utf-8?B?Tk1OZ0R5bVJzRTk2TThmTDhReTE3K1ZrVzRzYzNBeVVBVDNtY1BKQ1JMd2U4?=
 =?utf-8?B?REg2aW5TUGhBZC9ZTkR5OVBDUVdHcWJBb3d4dHorYmxYSCtxUVJCTStaS3NO?=
 =?utf-8?B?aWcwR2ZqU1F1L0JydUF2U2tJYTlwcGVoM1lhN1lCZTNXQm1hcFRiN1AwdVIx?=
 =?utf-8?B?WVZ1VVk1bTRyNjNGSDNVdmRZaGlZWUpnWGlmWi9pR0dYeDQrVkVPUm9ETFl3?=
 =?utf-8?B?K0xBUUgva0h6YkprU2FkbW5RMXJGVzVYLzRUZHhTYzh5V3BvQzJMQ0I1QnpP?=
 =?utf-8?B?ZVZMb3l1QUtpWCtRR3JKMytueUxCeGFYb0FpdFp4enJQMXJzZ3R2QUhZMTN2?=
 =?utf-8?B?VGhleG9jSEFDaVhCamhIdGxuTWZXQnVOUEpmaWFlQUtEY09wM1BrMjU5UmpJ?=
 =?utf-8?B?OE92d2U5V0dsT3JsQUVwVEJ2TkU2cEF6dlZWUmw0YnlVRXF1U2pHY3FGTUdC?=
 =?utf-8?B?c1ZTaCtZLzZRRG94TUxvekMxalVuTEJvNk9VYkZJdGxKWHgrWmNoUTUxZGlC?=
 =?utf-8?B?eDFqVjhNaTlYVHhzbWl4cmVKVTlzRHdRTjlQZWQ5cHF3NStlMS9KZWJyS21P?=
 =?utf-8?B?YkQ5NHV6cE9yc1VVTjRBS3cxT0FGMTQ2ZzErdEhGT2tPTEpTRDhoaFRicmVp?=
 =?utf-8?B?TmZHQU1nMUpGOWxWQmpKaC9RbEFlQmFNbnUyR2M5Z2RiNi9hOW4ybkNNQWJl?=
 =?utf-8?B?eVZkR1MyWk80Ly9Xcmc1TGpVVWlTdUtROCtzRlJGWUgwalFYenBmV2ZkRnZo?=
 =?utf-8?B?NmhZMzMzbDU0by9XaW1wMm5LZnU1VG84UGdGeXBzN2JIZUNuUzgrSHdzWTgz?=
 =?utf-8?B?YTArdnpSYnRpL2xtdS8vT3BrTUhtaDgxemh0SFIrR0pPcEE5SmpxS0xNUFJX?=
 =?utf-8?Q?/dEhBRMrDemDi/6zAFy8pYEzxJ3n86FWqb2/rLUV4U2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3BhU3pPbERZU25ZbTB5Sy9mTHJIZ3l0WTlyQnlaMEx1L2tabFFJMmlyMGJq?=
 =?utf-8?B?ZVN2TmoxcFpSMGpCSzlHRGtsQ3ZCekhlS1FvNS9BcDlTVTc0VlFtZjVZTzE2?=
 =?utf-8?B?ejdFTEtJdEplTm5MTVdlTy9UQ2wzTWZpS09McnJ4enIzcitQdjNZY3FsVWpW?=
 =?utf-8?B?eWUzYWpvc0krYWVWeFhteDQ5OCs5UHFOYU5ZbzVQM1pTUU5zU3Vzc3M5ZVVo?=
 =?utf-8?B?OHZuM2hrSklSRTlrMGhQY0lsRHpjN2NObUo4VnJvY3l1UGhjUjJtMjZCcWYy?=
 =?utf-8?B?NTNlR3JlUlZ6TGkvd0RTa3ptMkFuN2ppbW5RMXRzRGhES2EwU1kySHhRWUQ5?=
 =?utf-8?B?MVVjbGVEYzhDRE5XZm5EWnBOR3dHQy9oTXZsL3gvajRJcFlvWWdwMXFmcDdS?=
 =?utf-8?B?TVhQK2xDVXpiMkFvQ2Jkd1JwdC9BYVZncjlIRGc4TzRibHFDUUQxWDJCdldI?=
 =?utf-8?B?eFRZaWpZdm9jUTNLK2ZzTDVUL3RYOHNvK3JoZXBDVWpXenBTVWtJT3B4Y3BI?=
 =?utf-8?B?WkRaODhTbDB2OTNEdlZHL1R5aEF5OVQwQ2t2aitPNDM3SFZPeUFZWTFoMjVH?=
 =?utf-8?B?azV4TlZQK0xvM3B6NU9ZR3lDalRXTVAyQmJLbWFGem5mVWNVM3pZN01aeFRx?=
 =?utf-8?B?L291WGZGaC9IUHN3ZzhEa3dSVml6VzNFekZLRXdva3ZKelg4UWE1dTJMS2M1?=
 =?utf-8?B?UWUwM2VBcy9XbVBPWjlORVBKS0Y2NjE1UU1aQkFSRHpUZHNtN3VGM2JDaDZq?=
 =?utf-8?B?RjFmNURyS1RMMEZIVVI1UExuWVlyNjRXYmNDL1BjZ2Z0dVRpcGNqNm9vNVo1?=
 =?utf-8?B?T1g3YU5sWDlMMno1d0VqOHZ6cEhZbFFNVEQwSldOdXdINSsrcmtjbWhPSmRY?=
 =?utf-8?B?R1gzd2pHditta3JHUFQrTzZlWHNtUEVrazBlLzFsTWVEZU1pL0VQRHpwdlpz?=
 =?utf-8?B?QURFTnQwV1NNS1ZaVGhERkYxd3M0UnB2UUtVT0pYRUNWTWViVjRBWko3OHZa?=
 =?utf-8?B?MDdOUE9EYjFvcDlSdDMybGlyZWZkWnhGQWd4ZnBES01yU0JVakVPRHZMcjJN?=
 =?utf-8?B?UDdZaGdhUW1GZTRoTlBwbGF5RzY1NTdjZFJubWlFUDd3Y3diQ3hQSE0xY0pJ?=
 =?utf-8?B?OVg0OHZpUVhYeDZ2cnA5aEJTaVFBVDZaTnY1UHg4bCtlYWVnRDYxRktSNHRU?=
 =?utf-8?B?STRLcWZ2Y0dDU25tTkhaa0Q4YWV1bGNsZnhVTGxpYUhSTHZFZ0g1TUQyelM3?=
 =?utf-8?B?N21aTmJjbG5wR2VDcW5RNjRzRkFZbW1sYjJvSks3RHVaYktvaGFNT1dHcXd0?=
 =?utf-8?B?VWhUbWVHN3BOaU5uVmk5SG5ORVBJUCtxZWlha0ZZQTByL2xrS0NsR0doSjdO?=
 =?utf-8?B?WVlyeER6bi8yeGNtVTdOTGF3a2kyRFUrajBveWhsK2RHRHhJZk56TjBDdFBs?=
 =?utf-8?B?eTNYbTh1ZnFvTFcyQmxWUFZPZDdJSjY4ZGR5Qlh0cjAwVUFldFlXUG4xa0Ux?=
 =?utf-8?B?dmFrUFp1dGNvTEcwWG9hdXJnbGZ2OUtYSGgrd3lBdnh5U3ZDUTdPT0M4V2lP?=
 =?utf-8?B?aGxMTVQrOEczY3NrbGFNMFZ0U0g2NVB1bWc4RTlybGl1NCt0L2ovWGljVkd1?=
 =?utf-8?B?L1hQeUNReDBhR3VTOTZKNjg3NGYvaHI4dXZPc25qcHZKTlFnTGY2a0kvWnBy?=
 =?utf-8?B?T1loNjFoT3lkallQNU05aS9DVjBNZmNTU3FCK0E5UG1OL2ljL2ZEQTErQWpv?=
 =?utf-8?B?TWVSdjYyUVVjTHJnd1BUTWdkRk14Vk1RN1ovSUVCaUd4d2NXa1RiaXZNV2x5?=
 =?utf-8?B?T1haaFJYSm1aWm1jMTYzU09QUUV0U0FGVllka3NkTXNXMWxWUlJvdkpYQi9R?=
 =?utf-8?B?TjZlV1o4Z0R4UGVrRjRuc3QrQmhhNCt5QU5oYUNYTlNMeG1paU5PRS9RaFV4?=
 =?utf-8?B?WWhXUmpLbGMxRWdzVG5rNG80KzZ3eENad1YrMHBlaGlBYURrTGxiQU93Z3JN?=
 =?utf-8?B?ajVnVjdqK1BXYXdpUzUzZGxvb05zaEFVd3laaUUzd3JIemFOTklOZnIwenI2?=
 =?utf-8?B?My80L0ZwT05RaWZWNTZLSi9YQmNzcVExcTdJQU1OQ3FwVk1lUWpvTXJVMHB3?=
 =?utf-8?Q?+YLk6wY4Ardd5YZTxF1VCo9ot?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8101d2e1-f5c8-494f-1b2c-08dc6ecd44f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:38:28.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGKReOdsjLi9VN63CB7f9Va3NKOF8+z42QVq0Pwut7CXPL0EyzQqJisCa8igLuhYVZ85xNN56/iyOqfmtW7Cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

On 5/7/2024 12:48, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> To address the performance drop issue, an optimization has been
> implemented. The incorrect highest performance value previously set by the
> low-level power firmware for AMD CPUs with Family ID 0x19 and Model ID
> ranging from 0x70 to 0x7F series has been identified as the cause.
> 
> To resolve this, a check has been implemented to accurately determine the
> CPU family and model ID. The correct highest performance value is now set
> and the performance drop caused by the incorrect highest performance value
> are eliminated.
> 
> Before the fix, the highest frequency was set to 4200MHz, now it is set
> to 4971MHz which is correct.
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>    1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>    2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
>    3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000
> 
> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

One of the reporters on the bug also confirmed this helped them on 
6.9-rc7.  Here's their tag:

Tested-by: Gaha Bana <gahabana@gmail.com>

> This comes from patch 10 originally by Perry in [1].  As there is a regression in 6.9
> it's pulled out separately from the rest of the series.
> This should go to 6.9 final if possible; otherwise 6.10-rc1 and CC to stable
> at that time.
> 
> [1] https://lore.kernel.org/linux-pm/cover.1715065568.git.perry.yuan@amd.com/T/#t.
> 
>   drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fbe57d356ee4..4859902eaf1a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,8 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define CPPC_HIGHEST_PERF_PERFORMANCE	196
> +#define CPPC_HIGHEST_PERF_DEFAULT	166
>   
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
> @@ -264,6 +265,21 @@ static inline int amd_pstate_enable(bool enable)
>   	return static_call(amd_pstate_enable)(enable);
>   }
>   
> +static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
> +{
> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +	/*
> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> +	 * the highest performance level is set to 196.
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> +	 */
> +	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
> +		return CPPC_HIGHEST_PERF_PERFORMANCE;
> +
> +	return CPPC_HIGHEST_PERF_DEFAULT;
> +}
> +
>   static int pstate_init_perf(struct amd_cpudata *cpudata)
>   {
>   	u64 cap1;
> @@ -280,7 +296,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   	 * the default max perf.
>   	 */
>   	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> +		highest_perf = amd_pstate_highest_perf_set(cpudata);
>   	else
>   		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>   
> @@ -304,7 +320,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   		return ret;
>   
>   	if (cpudata->hw_prefcore)
> -		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
> +		highest_perf = amd_pstate_highest_perf_set(cpudata);
>   	else
>   		highest_perf = cppc_perf.highest_perf;
>   


