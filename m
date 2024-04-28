Return-Path: <linux-pm+bounces-7232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A58B4AB9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5131F21673
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5C5380B;
	Sun, 28 Apr 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="chWBuI8/"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9D53807;
	Sun, 28 Apr 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714292931; cv=fail; b=M5xWA0vgNBRBSxv5+5fB7f8xSw9uJbn5L3+WpKnSNmii/1VuZ+mE/Mx3uBtb6NO6RNosvcxyYGg5Q5JPUQDL9eswjs06bO1kZGMpwJNZwpV93uc5DkFVzz8gRDosyHxEwZLc2/aopgrr6ANnu8QgoWicXT+a3WO2D2fpCIgF5GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714292931; c=relaxed/simple;
	bh=ogkw0Vt4ODmbZa3jCzquroP7SHcTyp81DkvoQxiMfnw=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=lt0DdNttJYlqwBOcE0Oxlv+DtOhbKV6bXk+7g77xHPlV1s1YNMNjRn/+FnPRl3i1YfqRFB7kNcem7U0yWXkB9V8z5CEjHOLPIJvqI+P+TjQW79A5i0lelmyTsr7nc5ghEX3L4f1bouJmAVcAGDBypv0NAzYO6rQyJM6QG4d4BfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=chWBuI8/; arc=fail smtp.client-ip=40.107.14.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MksL1OjG56hmwMpeaSjtPhH8Qy4/tE29Mt/oqEbFW38CAV/ur4AP4B3qW0d61iFDYKWe3ocylx0us29cFJ0g+dM9NYs4eTIQ8Z0uhUrJciYvBQK8mtr5ry4807RHpT7B1JttG7eKdN5PotHGBK0U2D8aXLN+q8KKmtaTSQZ4NpXAlBL0ITA/bPV5zwuO6XRLCFjexteVboGsqdPl0kCQjAzUDXfrYkKMxHCfK/jd97Xbp5op32letmG+kF8etcrb1SnimBfkOFw/YX7xVwWdn4K2Fdmyp6EJwU935uafW3EJzN7bxL6WuP938AQDsmaa2w0Hfwv0lGSwPSRnppdAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddL+H7gfL6kK702PSO3E8tiJYxYPDySQgKXJlGORC3c=;
 b=Q6FCgOSzTR5KOhbK8oyvCZI/gYrGLURflOj+xII7fxX2JvlBKBFyOaWD5pmsP3sUMqqUFC6kRwkXJWzd78GquMRUN/d+SlJfUrGDGvARPuc5l7HeRzleix6afhAGgkeIVe5Tbepz4we39bhq+kv/SpYj0cUhP4VH+EbNehx5KrhJkAYiFpGhMj9xzXUvSZi5EAlsyNq+ca3ami9fqa6VLI/zCr4fFzogoDocHcyNJ+lZIpo/l5AWf5QPQGbSFQxE2emHHGEfEbalsH8Y+zT1e6xPAO0lzR4bgqGL+v5QQNw8jWHhG4H4hLM+5HZsJcJbsQ1euxMLW03JyV23YRzbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddL+H7gfL6kK702PSO3E8tiJYxYPDySQgKXJlGORC3c=;
 b=chWBuI8/2cdT3FVwIvQ5y+NgSDuILaPeuGmFHnE7IQDFLAvWk9w+etcXxhqD68FSEXBff3xIYC+O+gVyTpeJcRo/GWXisBEIN9+l8Ls8jGL+K+Q5Jnnw1GZ+nDguJsq61HbGEhh0rosb7ilhEW2tmGjbZQMxC6cLOeubrzSNfbnjWD6SxRkoJvnj7lz4S/en2EnfKhder1ldmM2SKoIEhHSwsD04piSP4tmqKMXx2DnoOt9Lob5Aby4T4PW5tMkXDDnhC5fzWzbsNWSsJnDXWnk/Vr2oS1ZFqI1oWRy9/JnOAId7H2L5ap/n7I0OIcYy/aXXN44jWa/ggWNG4Qq4ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 08:28:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 08:28:44 +0000
Message-ID: <8a59f3b2-48b0-4a62-ab54-61f8d6068cbc@siemens.com>
Date: Sun, 28 Apr 2024 10:28:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5.10.y] PM / devfreq: Fix buffer overflow in trans_stat_show
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Johnny Liu <johnliu@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0961e8-fb40-4bbb-bb46-08dc675d37cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzJDTFR5VmdaUHJrVTgwdnhUb2hZNkJ3RVoxNng0R1RlQ3Z2bnAvaUpWTEU2?=
 =?utf-8?B?eGwxSVhNYll0MnB2cjRmN3NUazBiNEtRU3BBUEg1aXpjQ0x3WGZ6YnBWU1Fr?=
 =?utf-8?B?YnVMOFJZSCtsZ2pQNHVjQ2UwVDNOaStmVGZ6c3JMamE4aEFnUVVYTFJNdUN1?=
 =?utf-8?B?cmVURDB3aTRPZFk1aWhWV0NZb2ptQzRpUzlrTlhXQkFDT0FoNEJmaG03bHBK?=
 =?utf-8?B?c3JhSXBxVnJEYUp3TTJocUV2T2lSSjBvUEp4ZVRkK0VlRnEvb0x4dG1HOTVH?=
 =?utf-8?B?dnQ3eTVuYS8reXZHb0lCZ2FsQVVRV005Zno0SFVHSEFiZ0FrelZjNEl3N3FI?=
 =?utf-8?B?cU5aZ0ZnNDBhZzFtRXg2N1I3VFFNaThzNXZLMFNxNHdhVDI5S1ZZUFJRWWQ0?=
 =?utf-8?B?Nkl0bldKVlkrLzZHY09xYWZ6V09aVUpWd1FUeDRuSlpJS0wwVTU5Rmg4eDFY?=
 =?utf-8?B?NWQ2dnlXU09DRWZIa1FOY3VsbDNoWWxKS20yK2RyM1E2bUt2QURMS004QzdN?=
 =?utf-8?B?dFpvOXZQeXcyd2thODVOa2JRRkhydFBkeG1OdkRWbE5uU3Q4ZlIxaGdrNjA2?=
 =?utf-8?B?OXhlWElTazcwVndXTDFxc3E1cytKaWtYSDE0ZklDRXZOOXNRZDRGT1BIS3BK?=
 =?utf-8?B?bnlseTNqRlFCeW1PQlZIcTZjWmhpZEdKTi9PK3gwRDBaenpRS2NvTU5hVG1X?=
 =?utf-8?B?d1pZSzdjS242Wm5pZGlJK0hWaXpOWEFVWjFnS1hWa0hERjJTeVMwb05pTkhI?=
 =?utf-8?B?WnEya3hSQnljRjNiNDZReW5BUzlzcjFFZmVsU3BGTGc3ZnlPY2UreEt0WDJ3?=
 =?utf-8?B?WTZCVnQxTGdQUXlvL05TV2FJSmRRbWVIMjBFV3dpMCtuNzVPTmpITVZFTzVh?=
 =?utf-8?B?OG4xQjJRVXFQRW5Oc3BSc2xYTnZVcTJqQXQ3TlpkU2x6OGhocFc5azRCNnJT?=
 =?utf-8?B?M3RsMS9OT2Q5WGE0VmwrbnNkRWN4bFpmdkJINWwwMk1xbUxhbkFaZHpTS1Rm?=
 =?utf-8?B?YjdNRTdjMXVRV0hEWFV4ejJEMDZselR3c3FmV3JzVXZ4SlJjQS8wZVpWYUpy?=
 =?utf-8?B?VzdpSzRWZ2ltcGJhZ3V6NFhsMUtTYjJHM2FCY0NhdnAzYnNacEh5Vk5HQkVR?=
 =?utf-8?B?UksvU3d0RUNkQlZ0S0Q2VEM2bzV0QTlnWXE5cFcxWEVWbUx1V1lPVVNUNTJY?=
 =?utf-8?B?S0VKVzl6OG1YOWdIb3huTmN3bkwvUHE4Nm9Nd0lHajZ5dGZscG5yQ2J2bXVl?=
 =?utf-8?B?V2NtZjM1MzFRS0RtVHRFSHpwVDdQNWlURjJXSGxlQW5IM0ZxUlVJU3VMWXpE?=
 =?utf-8?B?L0ppam51MG5NbWZXUUluNWxmWXBaUWtNNzhYbkFEYVJ2VzVacitXbDE5SVdq?=
 =?utf-8?B?YWZIQTdMM2ZkMTE1ODlQeDZDREw5T1lVMmt2a3VmcVF0bzdqdFQxZ2R4by9k?=
 =?utf-8?B?QXZydExLV1htSWZXRFIwajVRc2NNVk05WTJYN2Yybmw1bi9qV3M1SVB4MVdk?=
 =?utf-8?B?cnd2bVV2WUJYeFhqZmR2cWVObVFCdXppL0VnNEh6c0U0bGNTbVNrRGpQd3kz?=
 =?utf-8?B?QjJKV1lOam1pWDRCem11VFFDUUJlRXd4SmRlR3RFNG1WY2llazBZODl3MDNO?=
 =?utf-8?Q?1Mxdos5tXI8qkodraQRehRS/5K6EDcJDOjTnuiCTkop0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWgzT0FLRi9qRDI0SzAzUDY1RGNoNjBRQ0VpenRjb1pGelY4NFNtNUEybEdU?=
 =?utf-8?B?S1VMeFFSZk5Fa1pLZzZqK1ZFbnBsbXVvdjI5V1oxQlpIN0R5MHNSd2NlQ05W?=
 =?utf-8?B?NTl2ei9vN0M1U2tDL0k5eEN5dnVheUgrS2ZVRFhaL0dQS3ZtQ3RUYnROVUVB?=
 =?utf-8?B?ME5ESzNIR2FTOXREaHdPQTA0U1Y1ZDUzRGhsVGRhYVpydFJ6dTZ6ZzdvME11?=
 =?utf-8?B?Q21PMkMzKzR3Q2lBMTZaSGxGRmZ0WDBsL1hjTVJLcXdMdTB3bjNDSDNtQjNr?=
 =?utf-8?B?c1VTb2FFNGp2TC9GZk9mZ3RMdjhVR0dvdTR1UUhwWFZxSDYrczdLWWtsNWI3?=
 =?utf-8?B?anVZMi9JY2FqRzQyeUtsWDlGd1d0cE8rR05IUDJUa05oalZoU3hGRGhpazU4?=
 =?utf-8?B?ODhmR25XN2doeTdaek9EeWtIcVJGemdZTjIvY2cyYVlqdlJSQzA3dE1LTUND?=
 =?utf-8?B?NFc5Zlh6Q1hoOGV5RS9ic2ZHTFFxdmU0L0dtRGMzRm0rNEIxbnZPU2ZmT3Nw?=
 =?utf-8?B?eWt2ZUZNMlc2Qmw3WkhSMGwrcnBaM0ZDS0Y3RWFrc0hiQzZZOXZQR3lwdGM3?=
 =?utf-8?B?QlZsT0p3MTcwOS95MlMyRlJIaXVHY0pyWWExdERzMjdFRU8wQUNEb2FEWWZM?=
 =?utf-8?B?V2FoL250QjN1bTZDMS9lc01lMU1GQWtWV05NMjFEUk9McUYyMzloYk5ib0pD?=
 =?utf-8?B?Snd2SEZ4a2JQQk9VbncyRDI1MW9DVmY0T2JUMEQ1RVpwdXAzMjdzbnpEd2tq?=
 =?utf-8?B?N2wrdDJqcytNUnNhaHpiMERINWtSc3dDbWREbDZwd29tWEFJYkdhWUVMazJW?=
 =?utf-8?B?RVg1cDdUb2Fua0MvcEkrQ2R6aUJJbG1sdE9NamFld0JmbHUrSExOMkh4VEl0?=
 =?utf-8?B?eG8vWi9CQ1J1TEpxK0xiSG5sSnEwMTg2Z3pTa1Y5SWhCSzZmb1ZDVUozK2NZ?=
 =?utf-8?B?WHdMRXRjYTcrTVZrcmN4VU9pL202ZDMva2ZTWTBYM1EyaHBnNnVhc2wweHRL?=
 =?utf-8?B?RjFEUTBNVithdXFGRHJrUm1nZGZnclM3MmsxT0pWMG1wVVVjV2hEL294UkFE?=
 =?utf-8?B?R2lRUzlqQnpvSTRYbnZvTkUwRThDNXRQbnExYTJQekpaMkRJK1l4Rk9GTUpO?=
 =?utf-8?B?Y0VHOVJxRFNIWmlWbXNzb0ZkL2Rkam95L0JPU3A5UUU1cUdhQjh5MEFGTlhR?=
 =?utf-8?B?YU91RWpMOHdoWGtUWUpxTEtHdmFyWXB4QzB4akVkVlhFa0ZEK1ZKb0hzQ1Vr?=
 =?utf-8?B?b3dZcWFWcmRkSnpLV1diMjQvUmhKUU5Ib1U2QnMvYU1iSGRyZkpNQm1VV2ZR?=
 =?utf-8?B?eXBtVUR3cHBCRHpibG1DVmxiNEZFbzNuSUpmNWVxM3ZORjR5aHB0c0hzajdq?=
 =?utf-8?B?RWp5MGVBWmoyNFZVbWo3L2xrb1hiek1sSGpxRWI5YXZIWHR0SnBsZTVOZjNT?=
 =?utf-8?B?MnVWM3c5NFVmNTlrcjNpMWd6bFBiUjJQRiswVEVSSEFEMjNvcUFyd1RSUkZk?=
 =?utf-8?B?UEw2a01qdCtTV3FuUzRwNHNmRnhvcmRTb0dDNEdMOGNic1pOV0oza0RISlJi?=
 =?utf-8?B?MzU4OUNnOXFhdGpYYW9DZUt3YkkzRWdXbnM3c2l4OHRZVUpxUStsUk42VWEy?=
 =?utf-8?B?MG9mMGc2MEM4ellnZEtHSXExU2FUMlI4UFV3Q1VTU1YvcW95QTh3ekxDbFpt?=
 =?utf-8?B?bG1TanpnUC9Id0JrUkZReDUxTVk5MGdmMlR3QUJtZE5NcEtaaG13b0syTFVs?=
 =?utf-8?B?S1IxbTNqcno2NEdxVzE1ekh2TXd0ZDdYNGpjNkh6Ky82RytncUtpRkFScWlv?=
 =?utf-8?B?TElnMUVIdWt3TVFNd01uUDR6MnIrZ2w1TlhDTXUzdWR2NFlTcVd1ZENIZ0FK?=
 =?utf-8?B?Q2d1M1RHd3dCUlh3TllkZVdUVCtEZVE2ZVNYMEw0YS9zVDJZdUdrOVptd1Mz?=
 =?utf-8?B?aHdGUlVJN1hpK3A3eFlXVTBtMk4vQXh5dnRtdysyZEpWaVM5Y25BampxOHZH?=
 =?utf-8?B?Lzk1czlKdW8vcWgrbllwTDBOc2ZMeXVCL2E2SStCT0ZBYVdXUjQvYUNvYXEv?=
 =?utf-8?B?UC9vRVJUQ3RQV1BYbDJpZVNhL3gzdURWNFc0ZkVHckpsU01HMlFMdlc5cURr?=
 =?utf-8?Q?uHjfFYrOpV92WvJDP8gcO15m3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0961e8-fb40-4bbb-bb46-08dc675d37cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 08:28:44.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVniWVMBxUB79k+1yK+seYXhcFOFF6ipFxfsf/yMOSJUf9hbC47OU4Ws6Uj79gs5zsNgRasOyRfKogi1JkHBdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7558

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit 08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4 ]

Fix buffer overflow in trans_stat_show().

Convert simple snprintf to the more secure scnprintf with size of
PAGE_SIZE.

Add condition checking if we are exceeding PAGE_SIZE and exit early from
loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
stats is disabled.

Return -EFBIG in the case where we don't have enough space to write the
full transition table.

Also document in the ABI that this function can return -EFBIG error.

Link: https://lore.kernel.org/all/20231024183016.14648-2-ansuelsmth@gmail.com/
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Original found by someone at Nvidia. But this backport is based on the 
5.15 commit (796d3fad8c35ee9df9027899fb90ceaeb41b958f) where only a 
conflict in sysfs-class-devfreq needed manual resolution.

 Documentation/ABI/testing/sysfs-class-devfreq |  3 +
 drivers/devfreq/devfreq.c                     | 59 +++++++++++++------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index b8ebff4b1c4c..4514cf9fc7a1 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -66,6 +66,9 @@ Description:
 
 			echo 0 > /sys/class/devfreq/.../trans_stat
 
+		If the transition table is bigger than PAGE_SIZE, reading
+		this will return an -EFBIG error.
+
 What:		/sys/class/devfreq/.../userspace/set_freq
 Date:		September 2011
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 216594b86119..93df6cef4f5a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1639,7 +1639,7 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
-	ssize_t len;
+	ssize_t len = 0;
 	int i, j;
 	unsigned int max_state;
 
@@ -1648,7 +1648,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	max_state = df->profile->max_state;
 
 	if (max_state == 0)
-		return sprintf(buf, "Not Supported.\n");
+		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1658,33 +1658,54 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len = sprintf(buf, "     From  :   To\n");
-	len += sprintf(buf + len, "           :");
-	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				df->profile->freq_table[i]);
+	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
+				 df->profile->freq_table[i]);
+	}
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
-	len += sprintf(buf + len, "   time(ms)\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
 		if (df->profile->freq_table[i]
 					== df->previous_freq) {
-			len += sprintf(buf + len, "*");
+			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
 		} else {
-			len += sprintf(buf + len, " ");
+			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+		}
+		if (len >= PAGE_SIZE - 1)
+			break;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
+				 df->profile->freq_table[i]);
+		for (j = 0; j < max_state; j++) {
+			if (len >= PAGE_SIZE - 1)
+				break;
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
+					 df->stats.trans_table[(i * max_state) + j]);
 		}
-		len += sprintf(buf + len, "%10lu:",
-				df->profile->freq_table[i]);
-		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%10u",
-				df->stats.trans_table[(i * max_state) + j]);
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
+				 jiffies64_to_msecs(df->stats.time_in_state[i]));
+	}
+
+	if (len < PAGE_SIZE - 1)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
+				 df->stats.total_trans);
 
-		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(df->stats.time_in_state[i]));
+	if (len >= PAGE_SIZE - 1) {
+		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
 	}
 
-	len += sprintf(buf + len, "Total transition : %u\n",
-					df->stats.total_trans);
 	return len;
 }
 
-- 
2.35.3

