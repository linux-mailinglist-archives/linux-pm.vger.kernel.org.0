Return-Path: <linux-pm+bounces-16256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F79AB757
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6550284C18
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E61C9B9F;
	Tue, 22 Oct 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pE4WltK3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E613AA2B;
	Tue, 22 Oct 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627338; cv=fail; b=PqsDza+vkIgSLSGbUKujYuAiBPRc6+DKr81kY99rrqysnWVHc/xFh8TBTLonGEgHGcNJS7Zep1++/sBSItJiSBIX0NvuT0GQCJK9KjMHjqMa5w761TC1o+PSQhi6RaeOHqBZpau73hyYe/ZoCVlMCZ23p570pJ1Bqg+va6nB090=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627338; c=relaxed/simple;
	bh=K8EK+4gdc48e2Cv/28L6VEy3r9gJFvqhWMqBi9+kD0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4qqUng753bZDEl6VV6lTy+OkMLPfIb/jagMiwoooMom2rIkRNbZ2/glDwnAMycdMuDts18uSuQrfQ/7uOeaXSoKljZ8pBynDexciEH7u0wS6vuIBAWTu4/ccYRXuiB3y7UmCElARC/0UByXna43jVbFhV0wCJBXHRmsru+Pwl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pE4WltK3; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us0LKSsJJ3EKDEyMsRgHwxIobqNVKe+VPan35fXPfjEyRWEYuwMiaSn+jIsqu5t7KuhZH5bwNBVjzxGmngokwIeiutUNMhCZrWeoTAXFy45fiUYrLJxScA8j7tyPZ+EhFQuEZvjbfDmu7tqI0SaXrsgu8Yjf0lNMjp8Vkwb8pCpVGaaJnh9y+yVIE3TsywsJjPJ6E/g6WtUn/UXyYvAHS3OISHW6Yq7mUujPebin4FBkIbhSovM7PysApQEOw3AIcWOdKWovcUfVQegS1bGEzA1ZgvObAoXWzh/MMwfWVBGK941LW2UMHA16go9xMqNTeL0is/tZ5E9Tb3yMw3Ek2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meHHftdT1GpdBt4pLUoJPnqpyGpAuC+vnMYjzxX3Acg=;
 b=WWEKiot8zLQMHUc719PonxKL/07JOr8QFbDFSkcN2flCOx7c3ixBJOvQaNOosYKhNcHRvLyIJY3X0p3lAn64GLUvC44Qdz/BRTCJj4ImfgN9gsOGcU8/ecTklwbLQKflLVnjz1YTzPJK90zj4BkWvf7uSTq63YJe6ysqUqJhpE7erSrJXXeGsXueyoOsHz3dqEQ9v5FjOcehSmrle4YhJDzgkMa0Qe1ANE82ewl4/1t/TkRseTtMed03xUSM4PBElxswAzRywQWeV3JZSusPYMxW7GRHYAPBE9vQ669prhbDNyyJuHgs5lAv/6HtztCq/Ypnx/ZIZ6eL/Rz955yhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meHHftdT1GpdBt4pLUoJPnqpyGpAuC+vnMYjzxX3Acg=;
 b=pE4WltK3+JMwUZ+OI2CMyl5Fin82eTNBUH1F/T1TPBxQvoodAKDMc7dw++OYVCINkQMwf0zhziiykN3MabimBZfR0OATk5kNf4fdr0sGdob//aX8NpkaB7HM2ps0Q4RUq4Q9OkAkFtpic4wF3s5gnAZCHB2AK3dlmtQPxF8+WIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:02:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 20:02:09 +0000
Message-ID: <b50d9b7b-dccd-451e-91bc-fde0c467977c@amd.com>
Date: Tue, 22 Oct 2024 15:02:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] x86/process: Clear hardware feedback history for
 AMD processors
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-11-mario.limonciello@amd.com>
 <ZxdGIFv5MPMX1HPo@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZxdGIFv5MPMX1HPo@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 56878bea-ad71-4814-d67d-08dcf2d46908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3ppWjA5R01iUkZoTFZlRDhPRjN5c2ExSnVmUEExNlVwVFdpeVRualQwcXc3?=
 =?utf-8?B?QUtjZFJSTTluV0RXVU5yaHlZTXN1TXdhajExb2IzRkVPenp4YkV2Mkc4TGt0?=
 =?utf-8?B?bGg4S29LcmdNRENDOHZBNnl0Y2w1RXF0UU9RTnFOWlAvc2VPRkxNU3pZVE80?=
 =?utf-8?B?UlFFbm9RNFJWNldjR2hTOUVUUlVaeGs3Q2MyL3paVy9zWjdEU1RJOWkzVG92?=
 =?utf-8?B?Yi9HM0tZSHpEeTFhdS83Q21LLzZnMkUwWXdaTUU4NnJQbFBXSEU3M2d4L0FX?=
 =?utf-8?B?T0lwZ1VJY0MxRXRTWHFtUW04ZHR2UjVvS2RpYk1BdG1OWS9yTWxVUCtDaDZz?=
 =?utf-8?B?bWo3QUpobVdDT2VqR2JWUXlMTC9XTWw1cWp6VXA0K2Q4ZXJTMVo4R0dEUE5M?=
 =?utf-8?B?SEpxWXJDZ3BqSlBRdElyV215di8va2JxY1JKRllEN2tpeW1aUjhlZGNVcXVN?=
 =?utf-8?B?WmFqNTlieXVyNXVlTE9qWEkrYUZ5bHZET3BVZ1R4WlpYaXpBM1ZWcEhYc1dn?=
 =?utf-8?B?dTl6ZFJHNFMwWG9qTDBVbnRXRmlLTk1DMStSanVFTVRDUTVVTXRDbXNybkJH?=
 =?utf-8?B?OENTTDB5UEMwdGtwZzJ6aVVCL3BWZnc2d3FQZ3FrNjI3NWxmakRqQzlzOE9o?=
 =?utf-8?B?VlhsVHIrQm53eWNJTVhBYkZQTGJhMENndXhpNlBzanpvVy9FTnVUSjRVbmpv?=
 =?utf-8?B?WFBBQWlyODd4L3BSWXZ1RDZjNkh2dUZyU1pwckhNTHpqa1JXQXZPMER6Mktp?=
 =?utf-8?B?eXdyTVJvUHh5d1BCdTBUNkg3Q2taMGZscWh5Wm1UcmRBenRDNlhlcmFrdXR5?=
 =?utf-8?B?OFdQdHVmUVVZN0poTmRwcjBQNEQ4U2NjcC9FR1JCMG5iL1dkb2h4VUlrcU5O?=
 =?utf-8?B?a1M0aXFoTTZWcTcwSm5vMnlzbmZmQVJWWHh0R0xXNkx5OUhxNmpONnJscmo2?=
 =?utf-8?B?SXYzWVpXTVlsT3ZPQXFUWUpBcm9jV1FGQlQyWWhQd3NiTG9GeVI2Z0xyZU5l?=
 =?utf-8?B?WVF0c1ZheXBRR0syMWRodWJoeFYxMFBrU0V5dGRDbmxvTlFYemRPK0JRYllM?=
 =?utf-8?B?NHJMU2pWVlVodWpQY1VJRHdaVFVYb0IyV3E4K1BMSkMxRzJUOXpXTldNUmxK?=
 =?utf-8?B?Z242d296TkpnQVo5QmtEOVdWOENmYS9VYkNCdXJUa1Qra2tnVGYyU0hvZ2U1?=
 =?utf-8?B?WUhHZmRYd203eEpodjBkVHJtVlJNRVpvU3VEY2ZqV0JLbU43TDhVQnF1NGM4?=
 =?utf-8?B?aHNkWDhUNkxPdWxEdzRYbWNDeFA5RGZnMWR4cWtPVUdONXo2Y0pFNkJESmx0?=
 =?utf-8?B?Tis1MWx5VXRnNmhZZnVDTVB5N0tiTmprYS9LNm5tSmJqcCtmSktoTktOSXRC?=
 =?utf-8?B?T3NaejRHL3Y4UEg1T3FKVjczMDlkcmowZExGcE1tcHVOLy81UHZyL2xHWWJJ?=
 =?utf-8?B?VnFpaGxsOFptcnY3TVdlWWdDaERBOGdIT3YxVkVUNUxlRGhFUkhmdlhjVnp6?=
 =?utf-8?B?RElGbU1oeUpQUTNjMnh3RDVSYmt5QmRMVDJTc3pWajJpUFR0RnByWU5KTmdN?=
 =?utf-8?B?Y01ORk14WDNwUHpjbTFMV1gvSmYyYVY1NHNDNjNERlNzbHc1Q3NTRm12VmR4?=
 =?utf-8?B?NlJ6bmNwNURXcDhHUlNxUmRITlJvYmg2ZENXMFp4MENqSlp6TVRyT2ErUGx0?=
 =?utf-8?B?ckhTd1p3MllWL2laeGpXUG1JZGNwVWxXQUpzbXFvTFZiRGFIWXZNdjd0UlNy?=
 =?utf-8?Q?czhm4cQNhzzxgDMTembsFwz/VTtcxd4FCBaX6zP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0l5ODNuSEJuSmxmQWFrdHZFemRMbDJpUHJuUGUrSGQzTEl2U1pQZzFOZ3h4?=
 =?utf-8?B?eHFNUUJuckhsRjZSR0lSQ0M5Z1NLbVhiRTNOMGt5ZzJjU2EwNXZBSEpoS3hm?=
 =?utf-8?B?R0NhV0FIVENLaHdlditNYmhhL2FzeG9ocXRiVGJ6SjV3Z1FiZlNOemNsVEcw?=
 =?utf-8?B?eFFSdzFqUTdFeUNKendnNW5ocFpLRjNjckQwazdFTitoaEZxcDdkcWVIYU5K?=
 =?utf-8?B?YlRIL2IzZ3ZCTEJqTGRmWm93RUY3UU01NlhCcmt0TU9MWnlEbnJXL1BBNk5L?=
 =?utf-8?B?dkh2Q0c0ZzMzQlBLZG1EMWtIQlNNVTZTV0g5U2NrSFptSnJoZzkyWGZRSVYv?=
 =?utf-8?B?Zk5pQzZoMWFXc2M3WWsrRWpDR1J6RTU1SjVBQU9PT1VqRUxBMXMvRnVMMkZT?=
 =?utf-8?B?V2YxS3hreFZqVXBFU1NXSUpkaU95NVdTcTVLazdrZjJFT1R6WnUrY2MrOUVl?=
 =?utf-8?B?eWh6NmplODJrSFF1RG01ei9wZlBka2ErSndJYWdmWTRXM3R5c2wzK2NZdC92?=
 =?utf-8?B?ZHZQaE1NbWoyaEcvV1lQK0I2U3BHeE1UWjRnbzZ6UzVuaVFBdFRzTGI0b3pH?=
 =?utf-8?B?SXhGVmtkTjIvNmNrMHBUdGtWbHgrTU94cVMzNEQ1NEtvRTF2K2FwZ2dyS09D?=
 =?utf-8?B?Y1U0dmNOdXdGWUsxR3lQR3BPT0lOY0twSWhNSFRxODI1V2EybjM5WElKM1pZ?=
 =?utf-8?B?cHBLRWJOenQrUTlkOUJLOGtrS3BLamRma0JaZ1hSZ3ZUSXVrckhLbHFHMldJ?=
 =?utf-8?B?N0FJVFR1R2ZIUVdMdXVMMTUyVGgzQWJVUGF0dWZzVG9SRnlkOGR2bEM0ZGN4?=
 =?utf-8?B?QXd6UDJlaVZnL2ZscEVkMTJjV0NOM0lHTVVrTnJwNG4yQmxsSFlHRkxRLzJj?=
 =?utf-8?B?aXRYZnRvNHNzNW1aVmxiZCtFcWNPWm9iWlJ1bDlPZGhybkliMnlnQWY4VnUz?=
 =?utf-8?B?WGdFMFJFVWo0Tms0eXRwdlR4c2VsOGpVRmJVTVovRWxKUmV0R01uM0xiRnkr?=
 =?utf-8?B?OHd3THJYeGZzSUZRWWtPZUpvdVNEU2M0SUVIMCtOb285cnYrTzFKTDQ4OEU5?=
 =?utf-8?B?RFgwVkZwV1VrOHIzUzZ5dFZzNFNIZnA5aHNnYVdyN2cxZjBQdjQ1UTlWbjRJ?=
 =?utf-8?B?alFGYUZIVVgrVHNPMlNoVHhsbWltcktZRG01dnJVRVR5c1o1bHh4RnNaMkJ2?=
 =?utf-8?B?WGJmZjdzeFA2WCt2U2JzVkVZQllJNGZyZVdXUVN1K1VMUW5rVGY1dVMzcjdx?=
 =?utf-8?B?ZnQ5S1lkS3dScjR1UTU5akFLN2w4ZS9NK244V0t6Mlc4WnR4S0FiSVFHekEr?=
 =?utf-8?B?eVJUUFNqSE5YKzBOemNheVJYYWdZVm9NZ3liam5QTWxhbkd5UHJZZDZsZmlE?=
 =?utf-8?B?Y2dQc2liT2EzNTBDWWRtdU1pMERUVFVKd3E2U2JWbzI1UHVIVm5KbHgyeHlD?=
 =?utf-8?B?MW5sNEFWSW5Yc2NVeWptWVhlaXNLTCtUTmdZUnVxNmFFcGpvOFluViszRWk5?=
 =?utf-8?B?azdYNkllbTlZN2FMQkRpTWJ3RFhnSU54V0dkam51ZDZITm1BYmVRUjJaRlFR?=
 =?utf-8?B?ZlRwM0g4dWJhcTZSem1NNFBFZHpJZVF5Szl5T3NaSzRTMDdsSHd1MUhBMjN3?=
 =?utf-8?B?Y1lBNVdNZ0dCK2hLbngxVk85OGNVMzJTZ0xnYXpoQ09CS0JrdzZ4ZnBUNVFo?=
 =?utf-8?B?RlkyZkZaS3U3Uzl3TGJzcXQ1MTBMQjBWUlF2U0lDV3BlVXdTNkloQVRLbDM3?=
 =?utf-8?B?TjltQ0lDZ010c0lMeVhyMHdLWEVSSGJHSjB0TjBNS0pqZEQ0NUd0NklkL0tS?=
 =?utf-8?B?cjQyWnpGYmhvR3g1YW90NTJHdmhtMXMzU0ZCbHZSTUdPU2RyVzlMSHhWVnN3?=
 =?utf-8?B?SmRFUFMyMGZuc0RGZnl2TlJVT1U5ZytLRDJPeHNDOVEybk5TUDNZMEVQVEFO?=
 =?utf-8?B?NUtLMU54SlpDL2pENXBlVTBjSit2TGxEWVlLbHo1dVFkR3Z3VGVFOThvY3dL?=
 =?utf-8?B?UDBlRERaNStIZGtodDVkVkluNjJ0UDZQVVVENDNBOHFlY05naXlkNTZ3cjR0?=
 =?utf-8?B?SS9HNjRuaFVzNjB1R08wK2dJVzZyWTZIZXE4MkdybjlUMWdiWFJmTm9acXcz?=
 =?utf-8?Q?4ApIeu5FIwtyc+/ZTmBrOnpNx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56878bea-ad71-4814-d67d-08dcf2d46908
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:02:09.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcBIzjck3VC6g4RD5hNfb2qcnCobBWquaRZEe6CGWu3d3seFZEWu7WMsA3jsJHpXbVRlf5F4BSD0iR5/DkhVwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

On 10/22/2024 01:28, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Mon, Oct 21, 2024 at 01:02:49PM -0500, Mario Limonciello wrote:
>> From: Perry Yuan <perry.yuan@amd.com>
>>
>> Incorporate a mechanism within the context switching code to reset
>> the hardware history for AMD processors. Specifically, when a task
>> is switched in, the class ID was read and reset the hardware workload
>> classification history of CPU firmware and then it start to trigger
>> workload classification for the next running thread.
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/include/asm/hreset.h |  6 ++++++
>>   arch/x86/kernel/cpu/common.c  | 15 +++++++++++++++
>>   arch/x86/kernel/process_32.c  |  3 +++
>>   arch/x86/kernel/process_64.c  |  3 +++
>>   4 files changed, 27 insertions(+)
>>   create mode 100644 arch/x86/include/asm/hreset.h
>>
>> diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
>> new file mode 100644
>> index 0000000000000..ae1f72602bbd0
>> --- /dev/null
>> +++ b/arch/x86/include/asm/hreset.h
>> @@ -0,0 +1,6 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_HRESET_H
>> +
>> +void reset_hardware_history_hetero(void);
>> +
>> +#endif /* _ASM_X86_HRESET_H */
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 07a34d7235057..658c8fb4e25df 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -57,6 +57,7 @@
>>   #include <asm/mce.h>
>>   #include <asm/msr.h>
>>   #include <asm/cacheinfo.h>
>> +#include <asm/hreset.h>
>>   #include <asm/memtype.h>
>>   #include <asm/microcode.h>
>>   #include <asm/intel-family.h>
>> @@ -403,6 +404,7 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
>>   					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
>>   static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
>>   static unsigned long cr4_pinned_bits __ro_after_init;
>> +static DEFINE_STATIC_KEY_FALSE_RO(hardware_history_features);
>>   
>>   void native_write_cr0(unsigned long val)
>>   {
>> @@ -481,6 +483,12 @@ void cr4_init(void)
>>   	this_cpu_write(cpu_tlbstate.cr4, cr4);
>>   }
>>   
>> +static void __init setup_hreset(struct cpuinfo_x86 *c)
>> +{
>> +	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
>> +		static_key_enable_cpuslocked(&hardware_history_features.key);
>> +}
>> +
>>   /*
>>    * Once CPU feature detection is finished (and boot params have been
>>    * parsed), record any of the sensitive CR bits that are set, and
>> @@ -1844,6 +1852,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>>   	setup_smep(c);
>>   	setup_smap(c);
>>   	setup_umip(c);
>> +	setup_hreset(c);
> 
> Since setup_hreset() just enables the static key once when the
> AMD_WORKLOAD_CLASS feature is enabled, does it make sense to call
> setup_hreset() in identify_boot_cpu() instead of in identify_cpu() ?
> 

Good suggestion.  I'll change this for the next revision.

> --
> Thanks and Regards
> gautham.
> 
>>   
>>   	/* Enable FSGSBASE instructions if available. */
>>   	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
>> @@ -2410,3 +2419,9 @@ void __init arch_cpu_finalize_init(void)
>>   	 */
>>   	mem_encrypt_init();
>>   }
>> +
>> +__always_inline void reset_hardware_history_hetero(void)
>> +{
>> +	if (static_branch_unlikely(&hardware_history_features))
>> +		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
>> +}
>> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
>> index 0917c7f25720b..6a3a1339f7a77 100644
>> --- a/arch/x86/kernel/process_32.c
>> +++ b/arch/x86/kernel/process_32.c
>> @@ -52,6 +52,7 @@
>>   #include <asm/switch_to.h>
>>   #include <asm/vm86.h>
>>   #include <asm/resctrl.h>
>> +#include <asm/hreset.h>
>>   #include <asm/proto.h>
>>   
>>   #include "process.h"
>> @@ -213,6 +214,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>>   	/* Load the Intel cache allocation PQR MSR. */
>>   	resctrl_sched_in(next_p);
>>   
>> +	reset_hardware_history_hetero();
>> +
>>   	return prev_p;
>>   }
>>   
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index 226472332a70d..ea7f765c6262a 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -54,6 +54,7 @@
>>   #include <asm/xen/hypervisor.h>
>>   #include <asm/vdso.h>
>>   #include <asm/resctrl.h>
>> +#include <asm/hreset.h>
>>   #include <asm/unistd.h>
>>   #include <asm/fsgsbase.h>
>>   #include <asm/fred.h>
>> @@ -709,6 +710,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>>   	/* Load the Intel cache allocation PQR MSR. */
>>   	resctrl_sched_in(next_p);
>>   
>> +	reset_hardware_history_hetero();
>> +
>>   	return prev_p;
>>   }
>>   
>> -- 
>> 2.43.0
>>


