Return-Path: <linux-pm+bounces-22764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5226A41511
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD64916DADE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E27083D;
	Mon, 24 Feb 2025 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mx5sMXgN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA628DB3;
	Mon, 24 Feb 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377172; cv=fail; b=bKMsazESW9sRq0xydRUC031QlfOJbJcvo2dxB9VzCcjJ/WhUGqYBTcgPpMpnKtLKusZf+oGliCf1MsgBhf2tRsPzDyjf8g3Xj3AqIw1xLHNH8woBnBxLvb3523vRsRmqvWXb2TwvYzwjeNBDs9HFYRu4mnQ4fX9sC9e+eZeXy+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377172; c=relaxed/simple;
	bh=zmm55X2+PPpLvFynRPNsKtmiTzycI2rf8uh5kVHs/fI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwqOm5/W511gW0l7qrfzt2dxVy/v/q04dEEYf30uUc+eyxyr4wvsFOJEyj9Q5dIxjQara8bYOKI2jLYXMF0SgfI3aBzHFjEc5lbUgCTRpcuRBVTwHMEDvYKzo4v2N79dqNDPh6UJbJLcdc/qeAbRYfS5LNl9AQuGW1OVNlmx6s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mx5sMXgN; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQNMMtOviHJZCZExg8Q34pJFZJAbwXhsKkfHDJ9kr0XIvI4ffQd9sWMn1sjG3eqgVnyW2deF62wwutOkD+eiJltZ3YJU9uu0r3QdLs2NIA+CS2MB0pbidMsjuSer/FNEJCfsw4yh0c0FLH5hNQRgxBJmUDTfppjxRDJGsWUqdb0J4rBBlPPQ0BY6QbqQW96eEBkv0o092XtuHyW1e3bu7ZQrontkzj1f+MenAgofSrFfVg2wpouGuQlCdhNzA57mj4Aomnmoa48uYHlWicWu16auyuAMBbcuritLBvKdc4zCa+DRI/bM9G5ILVwWAcnJaoyUxegR9xtnzjCqsTKm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbyKR6oEjEGDATo7n2StIUwfp3xQjLPI+mJ2A350/Nw=;
 b=HOIc11iiNsWVgeS4T0BAGDyCJz/cFm8SWGZ92jRGWxiyNrADBdJIroETuVhoaaod1kCE6f4TxKDJeMtzBc+bORBffdD/vAAqJVK3QuF2nnzipIDJTxX9BtE8i4s45VGAI2b5l51Z526kvm4AD78KTessvFEVyWYFYgJfheazhhpUaRjxSw5UjMAQuCpbGLCasviXzFPunwAwo5nVI462ZtQjFoB2bE/a0JStCPYCV1bVYPxh5bUEDfo4rdIo7Or4RrnGsJDDz6nn6HLq+C+cdwqwGu95Lzl4euffB1hD3Xu+bvJmamBXlgBYax4uS8RuEJ11GihnPecBVPKo6GjDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbyKR6oEjEGDATo7n2StIUwfp3xQjLPI+mJ2A350/Nw=;
 b=mx5sMXgNXHkZZiRUKR2msYdBXzSwvWADiG5/8cJ8ka5hgyUljRQ3WZYrXcPoOGFKw5gVd0jzd5vONZYGd2fngFb4M4Yp6G2Lnceu5b5bj8vXRzFu9wgiZHg9YFcGmQPuwi17YwWk7f58Z8bM2QZaMxFLm3z9gFAuRZOGBqmx140=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:06:05 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 06:06:05 +0000
Message-ID: <086f6284-46b8-4cb1-8b19-009ee0e10af3@amd.com>
Date: Mon, 24 Feb 2025 11:35:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL
 enums
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-10-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-10-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f5ddff-662f-4ece-d82f-08dd549952c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3c0L0pXVWZNcWd4Y2d1OE5STGFrV1ZmN3luR1FkOVFoM0FZNlVKTUsvRHZ6?=
 =?utf-8?B?MU1XVG0waE9YeU0zZVNrT1IyNDl2bUJnbU12TEVUQ3VhWEFadGtUOUR6d0lF?=
 =?utf-8?B?QUwyUHFMdkFtZmY1bHJZVm9DdEEwNWZlTElVWG85Rm13U3VXMzU2b295OWhY?=
 =?utf-8?B?cFBVSlBkV3hqbFpPRHg5SzVvbkJqVE1QYjFBUnBjSHB4M0NHTkk2ZmdHNkZY?=
 =?utf-8?B?OHNQVllScC9COUxsa2s5RVhpR1NNa2swVzVlTUdLY2Y0UytLUkFoajYxUVdj?=
 =?utf-8?B?UkV2aXYwYVlXSnl3elRVS3JnMytXTjRLd1VpQmNTR2cxRGZQRWJXbzdmeXZj?=
 =?utf-8?B?VEVkLzdWbTQwaWRGUUVpY01qSWtOT3B3dlZtYTBOOEVYN01aMWxDbHdKUVhH?=
 =?utf-8?B?YWthS1QzSWJVME9tMHRleE1kN1hEeEpRUGlXUURiYzIvcldKeElQaHY2ZlZS?=
 =?utf-8?B?MjlQeDZLeDc2VmZ0WDJJKytYNm1JWjdnaFRBU1hycFBoWlQ5U2Z6MFFqUDNT?=
 =?utf-8?B?U0ZGbUpkSFE0MWxGVGgrWDV0VFYxQ28wcnMwVkQwVXpMcXVEZmFDTmhFTE1l?=
 =?utf-8?B?cllDMTFzdTNOYWJVdFcyTEZEMXJ1QW9ZZU9pRlB3V0ZVYlNDZzBybXd1TlFr?=
 =?utf-8?B?dFhGK3oydHU2Y1VzRWJRRUlOM0lDRk9aMTRxcW5lRHpTV1d2N2tsMGhiZ3di?=
 =?utf-8?B?SzlXTHNxZzQ4cC9VaGtyZnU5ZnpCZEpEVituUlBmS2IyS2R6Y1JnM1VDbEJq?=
 =?utf-8?B?QUFNMG1Vd3NwSG4vcXVwMWZTUlEwUkIvQU5iRzNrU2ZOMzdnOWRJbi9KR0Zv?=
 =?utf-8?B?YzB6R1V0aTVkQUVSdU9SUW0xQnpFcTBNL0JWUGd0RnJ3VDZ1STJKb1E3Y0FT?=
 =?utf-8?B?TkRXemZFNld4Y2VTaVJSamRaa2wxbkw0ZXBvcDJPK1BEcUNJSG1EbHVhdURV?=
 =?utf-8?B?a0ZNZmlQa25rOWRuNFhVR25CYUJUT2hmSU5OSFFUSGREcU5vcDdzRHVjVU1n?=
 =?utf-8?B?bTdtcjRtRmFwcVp0K01rWGNVSkdORHF0eE95YlM4K2RqWmIrM2xxd2krUDNy?=
 =?utf-8?B?c1NVRTQwdFUvbDBPQ1pESnhSWS9FRjBaRDZkdVNja29EcjdEK1Zha0I4Vklh?=
 =?utf-8?B?aER4Rm8wZWh6dlJoS0VCZUpWSWhzN2RYTDVWSTJqc21wcC9zazlPNFpEZWVM?=
 =?utf-8?B?UWdXWUpBZkZvMVhHL1RiZVZvekZHcWZWbVJZdE9OTXJSSDc2VUpTM0FmMkQr?=
 =?utf-8?B?bzcrRndYQW9MVWpLNlV3eENrekdrSnRoeC9ybUhnS1Ewb0J2SGhTVmRPZEh1?=
 =?utf-8?B?UGZVNmRJckVQemlvYkZmdStYQUNnUkZSbmNMU3VLZTRjM0xJeERRSG45VEts?=
 =?utf-8?B?b1Z0UitCaHNFL3h1TXFBdlZYV1RQY21MUE1GMloxQjBjcG5RNFl0bzRaSmlQ?=
 =?utf-8?B?Qllkd0RGYVlpZFlnUllhUHJ0eW1KTDlhWEVSd3pxbCtJZ204YjZHU1BmZGZT?=
 =?utf-8?B?MFpBT3FlZDNyRWtvTEFaTmY3NGhBQ2JYd21yWGhENDF2L0JnclBXSXRrUCtD?=
 =?utf-8?B?c2J2Z1VKWHpZa3RSVU43ZmNBMFM3Zm5IcVBzTjlPTHNVY3VJUnJhVUV6QmZM?=
 =?utf-8?B?TzNYaFQrei9ZSE54WEhVMkZGVDVLdUVTQXVZYnlIWTJoR1RvdUgwUklMOHo2?=
 =?utf-8?B?aER4cUgxaGc0eDJSZ2dYcnA2Mmk1Z3l5REFzOEg3YUZGYy8zcnZrWE50VjhP?=
 =?utf-8?B?SDNuK1ArL3M1UktVekhYdWx4ZzVNVVJFOVVBOGlQVU5VQ1RMVFJNUGJwNzJk?=
 =?utf-8?B?UGFTb01PMXBZdnYwMmswaTFlaUNoV1pneE1ta2JOejJySkh6VllvV2ZJNGVN?=
 =?utf-8?Q?W8nr1KOCrpZH3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZJN0ticEFTS1Rqb3hvdUVudFRZNzhnU0dtekppUGI4aDBWWUVOU2hJa2N0?=
 =?utf-8?B?OTlvelo3Q0RkNFFvbUE1bk5hSGlGOWNXNzhpOGVOQ1cvR3poYVJNbHQzc2JU?=
 =?utf-8?B?U2wzSVI4MlFNNksxR2tmTEEvT3RUaXZXQmRITG1MM0hXcDcxZUowY2k0TlNU?=
 =?utf-8?B?NVJwcmRidzNFUnhraTVMZFZmSTZBMzJ3Uy9rc0E3cmdZUHBTd0RqVFVic3NL?=
 =?utf-8?B?R2U0azI3Kzh4S213UTQ0OXVQbmJGV2c5bkdqMEp1d21wVERlaGkxYndMbDBR?=
 =?utf-8?B?RG1seVgvYndUcXh5SnRYaUpwVFVsVHl4Mm1vSFhtd1Qzb0Zsemw0U1hiK2tJ?=
 =?utf-8?B?TDhnbnFmTHdBdUlkMWxpVzR6S2RGN2NtZHFYbmZDdFVHalpaSVFneFRWc0pl?=
 =?utf-8?B?cHk2QU90WEVBdjRSU2dvdFg5Zld6ZXNjUFRYbHlLS0xwaHlTRmNEd1luVG5N?=
 =?utf-8?B?c2NDV2NPd0hSdXpDS3dqa0x4c0IwNENjTEcrMWNRQ25LbFlic2ZIZ1R6TmZB?=
 =?utf-8?B?OVhmWFh0VDBQekc0YzE4TW1SeG1wRm4xZDNmblk0ay9CcExHUk9RdndYMTc0?=
 =?utf-8?B?KzhQb3VWcU9CTGVPTGkrb3N3NjM1MkxRdXVBTWZZRHE1MENyZERPNnF1Y3hZ?=
 =?utf-8?B?Q2p1aUtwb3FMY2c5dUpRbUJWWk1PR3dlbFdCenA4WFVGUjIvUVJHVUNZVVVP?=
 =?utf-8?B?MEFsWG9melM3NFdGcUV3SlppbTJPVWp6ZkMxdDU2bDlvdGowM1RjYWw4cERu?=
 =?utf-8?B?MVNBSWhtdkhTWkhEejYzTTg2d2k3SnR4cDRnUW9kU2k1bzQwSkREV3VxeVNF?=
 =?utf-8?B?WlR1U2lwb3ZlaUtKbUlnU1ZSdHl4UTJMZkxMK3NySGo1d2ZxR2xDODdWdkh5?=
 =?utf-8?B?eVFLa1dhL1lJNldDQ3lmOVZqcWZtUjZpbktoZHo0VnJoY1p6TDVHTWkybHJV?=
 =?utf-8?B?bjVCTzBxaFNSaFRLc1NNcUpzdTc0Z2dyQVY0UlkwSkI4YTJiQjFjQWVyK2M5?=
 =?utf-8?B?dnlmT0RaUkFjVCtkNWJnUVNYQ2NHM2pLT3pTWVNFdFNhTzc2MGc5N25zNnNI?=
 =?utf-8?B?NCtCdjlSQkRMWTlOallPaW1UdVY5YVR5YVBFdjBWbGNzU2l1ekJqc29ZaHhQ?=
 =?utf-8?B?ZnlqSytHRnRTaUlmWitXR3BSVU5LZnAwRWlHTmdFbVRXak1OWjlyZHA3YW1o?=
 =?utf-8?B?dGdZREJxM1lpcWtMVzZ2UmRHZVNOVTVqUVNZTVcybi9ENHZ4U3hpMDZHRDVR?=
 =?utf-8?B?UUJUUzViNlFnUTV5ZmQvZVEwNzFnK0JYamIwZmJIeUxPamFPMHN1WHhaWWs1?=
 =?utf-8?B?V0M5U3pyeWw4UTA2b3AxY0pOSG9ONzJ5S3M5TlZnWGtIK2lMSW9HVWQwZUpM?=
 =?utf-8?B?eFhSTEJ0MXhPVGlQcFFNK2syS2tJbEpRSERmWS9aRUFqdUQ4M2tBYTZldElm?=
 =?utf-8?B?ZVMxUDVUM2hhN0xzNTBBWUk2dTlQdFFVSjZRV20vZFA2TWMyOW5jdytseCtU?=
 =?utf-8?B?dk1McXZxcjYwODV0MTBPZzhjYTVNcmtjRGxFNVVTRUsrWmRCQVpnQTZCbGY3?=
 =?utf-8?B?dXh4OEs2OXZSODdlTUgvMXgxTGJlYkRWdWtSYTQ3V2t0ZVJST0JGMVNLNEFz?=
 =?utf-8?B?UUo2T0dScjZRQ1V3Vll3bDhla0VlUUpoeDlMN1RjZVRKd2o1K2NUOW9ZNkNN?=
 =?utf-8?B?bmJoYzk3YU5Qc0VRbzUvdkRJLzgxV0dYb1AvWDVBV291YUU4c1l1djlzcStp?=
 =?utf-8?B?SXJUYU10V29VTk5hNVpuMEd1L1lEWmJXV2k5djliSDRydHAxMkJoUW1icnZS?=
 =?utf-8?B?Y1d4ZkFoUjJnS0d5c1ozeCt3NklySERSbjRPVmF1eUpsYUVabzVJNGd5VEcv?=
 =?utf-8?B?bWdGYU8vN1YrdEo0WjhYZWUwY1RZTytXN1c5ZkJ0QURLeHNoUnRmRVJMNjF3?=
 =?utf-8?B?bDYxU3Iyd3VjODd3RFlLcDJiaUhoam1ZWFRYK3RxMTYzNzZGNU9PaFg5NW5J?=
 =?utf-8?B?bkR1aXNicVh4elFiUXlFY0RuVUNxc29VdFNlZ1dBYzlGRnFQL3FOdTdLMmdr?=
 =?utf-8?B?R0l5VTU5aHFHczQvL2pGSGhRS3IvYVFuSGFMb0ZZaHFXUHIwUjE3UFFIWTlN?=
 =?utf-8?Q?tjsxhzkrry5ZMj2ZTVhPlqMV3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f5ddff-662f-4ece-d82f-08dd549952c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:06:05.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mrqgRcrPx6FzmgAuyiqOeJiDQDzOcA1tCHYZWspCrVQTupyc4JJWc7wu1X8W8s69jkZ0pY6ODd2qcmSyPjwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

On 2/20/2025 2:32 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Enums are effectively used as a boolean and don't show
> the return value of the failing call.
> 
> Instead of using enums switch to returning the actual return
> code from the unit test.
> 

One query below, apart from that LGTM,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com> 

> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 143 ++++++++++++--------------------
>  1 file changed, 55 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 0f0b867e271cc..028527a0019ca 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -32,30 +32,20 @@
>  
>  #include "amd-pstate.h"
>  
> -/*
> - * Abbreviations:
> - * amd_pstate_ut: used as a shortform for AMD P-State unit test.
> - * It helps to keep variable names smaller, simpler
> - */
> -enum amd_pstate_ut_result {
> -	AMD_PSTATE_UT_RESULT_PASS,
> -	AMD_PSTATE_UT_RESULT_FAIL,
> -};
>  
>  struct amd_pstate_ut_struct {
>  	const char *name;
> -	void (*func)(u32 index);
> -	enum amd_pstate_ut_result result;
> +	int (*func)(u32 index);
>  };
>  
>  /*
>   * Kernel module for testing the AMD P-State unit test
>   */
> -static void amd_pstate_ut_acpi_cpc_valid(u32 index);
> -static void amd_pstate_ut_check_enabled(u32 index);
> -static void amd_pstate_ut_check_perf(u32 index);
> -static void amd_pstate_ut_check_freq(u32 index);
> -static void amd_pstate_ut_check_driver(u32 index);
> +static int amd_pstate_ut_acpi_cpc_valid(u32 index);
> +static int amd_pstate_ut_check_enabled(u32 index);
> +static int amd_pstate_ut_check_perf(u32 index);
> +static int amd_pstate_ut_check_freq(u32 index);
> +static int amd_pstate_ut_check_driver(u32 index);
>  
>  static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>  	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
> @@ -78,51 +68,46 @@ static bool get_shared_mem(void)
>  /*
>   * check the _CPC object is present in SBIOS.
>   */
> -static void amd_pstate_ut_acpi_cpc_valid(u32 index)
> +static int amd_pstate_ut_acpi_cpc_valid(u32 index)
>  {
> -	if (acpi_cpc_valid())
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	else {
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> +	if (!acpi_cpc_valid()) {
>  		pr_err("%s the _CPC object is not present in SBIOS!\n", __func__);
> +		return -EINVAL;
>  	}
> +
> +	return 0;
>  }
>  
> -static void amd_pstate_ut_pstate_enable(u32 index)
> +/*
> + * check if amd pstate is enabled
> + */
> +static int amd_pstate_ut_check_enabled(u32 index)
>  {
> -	int ret = 0;
>  	u64 cppc_enable = 0;
> +	int ret;
> +
> +	if (get_shared_mem())
> +		return 0;

What do you think about adding a "cppc_get_enable()" function in acpi_cppc.c so that we can 
run this check for shared mem systems as well ?

Thanks,
Dhananjay

>  
>  	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
>  	if (ret) {
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
> -		return;
> +		return ret;
>  	}
> -	if (cppc_enable)
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	else {
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> +
> +	if (!cppc_enable) {
>  		pr_err("%s amd pstate must be enabled!\n", __func__);
> +		return -EINVAL;
>  	}
> -}
>  
> -/*
> - * check if amd pstate is enabled
> - */
> -static void amd_pstate_ut_check_enabled(u32 index)
> -{
> -	if (get_shared_mem())
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	else
> -		amd_pstate_ut_pstate_enable(index);
> +	return 0;
>  }
>  
>  /*
>   * check if performance values are reasonable.
>   * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
>   */
> -static void amd_pstate_ut_check_perf(u32 index)
> +static int amd_pstate_ut_check_perf(u32 index)
>  {
>  	int cpu = 0, ret = 0;
>  	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
[Snip]

