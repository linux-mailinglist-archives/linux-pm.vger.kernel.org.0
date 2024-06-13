Return-Path: <linux-pm+bounces-9101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1312907A49
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CF1F21AAA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB214A093;
	Thu, 13 Jun 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3iOB6LN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C56F06A;
	Thu, 13 Jun 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301222; cv=fail; b=Hg8VbA6VHjY03C/1/y0/kudp9TP2eNA+zABTWayk90tevxArI18iNSWwkn4VGn2isn5dh0DoMSmnYQp0rXiwBnqJ0tystGhgY5Wrn3+td9jz75EBpYOx4tI2gCM7qc3AThla8rr33621t6yiTNRn+ukZA2AR6znFJs72xOBpAIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301222; c=relaxed/simple;
	bh=yVt9rt5XOHwq8WEVQZqQKoXO58K3AVC/mQdjtLgCXaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+DmWaAFgueDjlfOtzArK1Uh70pZyQl5jWZKhrpRwyWQvPUiNOYeNa25TY4im5mIIApTxeL1gYK816SrmBYTYLPuouQgQaYp0Zz292icXX5/vzS3B++0I/OA4+HBYdn5e4KbcOn8wjPCgmxnEiBk93dzZkrIylN+OI0/KBOJxv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3iOB6LN; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUsimkRr3Tdc3ypQLM5JXtzE+I+4EmG68UrCiUYDSX/fqVfdcKIhoMUpCkaSMR79NbdNT+rInwCs0K8VGyBsLduMFiisQp2ke8/c6YFsLP8wSnFdmeEO6yCJ8z1jENrzFoKBzSn79SxcrOm6s41jO48yY2YuabyQCmEi9dtqKweoz7Z8b4f1GOLw59dbTtzncNsvx1PloW7hbvY0KxZyRw/hGMT0k9JapjEAvw+3fGsM8kf7/T552Zzkg1EpJEqKG1+OlSamEo0Goe6cmuP6dxFQ6Zi/RhGfcninjpe/JFBwog4AlGFZpUtH2sybgGQ6ns4zrhlYZMw5Zs7Xfiakpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA6A+vsrINmbUyIP0INankM9IikFW9RCjTQGRYbdbL4=;
 b=PjGaHOm7Ej1JXZqAH/ibt4Biydm8FI9yFa909B3VqrgOtA7K5rNSqyEN/nqvrDrovD2Zrg71j8/jbEM/kQxQW1rOalgF0aNw7gvr9Xb1DABUtO8IBoSfKLGfWqa+I2rwf9QzxlzKS1VvW+yezSHj/xUHHRwf8WE3UsNOKTmXCya6wEILc04q9XjPWoKrUtQYd/x2yPuhEjj7uaNeV851xZG7lRMvsCr7fvqaP1F4v5pO3RqVtH2RegfZM676cR6G2sVe43nuyn2bYI0c8J+oh9CGAYgqMrVgagGX4OtOlBBZjaGAjknu+W7BVprLEuZjzyIRMNyI/SEKlif9H8bLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA6A+vsrINmbUyIP0INankM9IikFW9RCjTQGRYbdbL4=;
 b=x3iOB6LNWUfkIM2sQ4E8pMikzjpfoxVFk//pmngH9KFbg5r2mSsQLw271LBX0cUGgsUb1ISo/HmcwRns1TxWMpK6rGdlJpIcWIatQYTjQ4NNHviTr6m5UrYHoxBOuAksj0NMz2RpLS/jYbAv8hzy00EZVra8R5eTCFXhtljRQ8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 17:53:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:53:38 +0000
Message-ID: <79024a39-63c0-4d86-ba48-618f59df729e@amd.com>
Date: Thu, 13 Jun 2024 12:53:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] Documentation: cpufreq: amd-pstate: update doc
 for Per CPU boost control method
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <f0c47cba673261c7d868d5236d3ffb15ae092e74.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f0c47cba673261c7d868d5236d3ffb15ae092e74.1718262992.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:5:120::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e521ff-6be9-4fb1-b6c2-08dc8bd1c0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEcxK2p2bTU3Ry9qZ1puRTJIWjg5c09ndzJFUVNEZG5hbGRDYTR3eS95ajdB?=
 =?utf-8?B?bHdhclcycjJhdXgvYzZnUHo4Z0tYdEMyQU9EVkdodTZXMlRySENrMjU0SFFa?=
 =?utf-8?B?UUFtWFJvSEJJZGJwUFdnVVROWDV1c1h2Um9nS3FxeTRDOGZEbGJBaUJ2eEpQ?=
 =?utf-8?B?cGlXTXRJUFRacmZtWE9jL0s0dmdvMDZZT3c5WEhmZENZQkxUUjIyME84TFZw?=
 =?utf-8?B?MEVoMEVlSDVjRys3ODI1Z1poSzVJRXArRFBtbjFvT002L3E1eCtmNXAybWVS?=
 =?utf-8?B?WWwzUnArcjFNR2w0RXkxRmhCY0RPelNPK0orbG1EdkM3OSswYnAvUmUzYnRJ?=
 =?utf-8?B?ZnZYMi9XL084NTZBL0RWTU4vYVp5eGVBdEtjVVM4RHFoV0psbHdyell3aGZs?=
 =?utf-8?B?Z3ByOU1iV3JnS1RMSU5yWktyN1hocTlJd0orVUZQWndTQ1EydzR1c2NjNVV4?=
 =?utf-8?B?SkoyRVRPTWFJbGxvRytKZ0FjYndCRldqcWFZL1B5dXRidHVvRjVqMUhYbVF5?=
 =?utf-8?B?ZENPTWlhRURuYytoMUlyWlJydkJzWjRyV2dYM0xzOERJemcwVWZwT1NYYjkr?=
 =?utf-8?B?dDYxcEhvbGd6NGpTeWJjenBUZFhTNlNtTW1xWnQ0Z1hyWnNMSGhyZFp4U2dn?=
 =?utf-8?B?R21RdGQvaWdQOGo2YXArc290WmZoRXVITGIxd05mbkJrc1M4S0s0WWFkVld3?=
 =?utf-8?B?REFtSWhveU9LQjdvcVhrTjBLbFMzak5EMWNDV1RVSnR3T2p3TGpKejJoL0o4?=
 =?utf-8?B?dmt5L3NCWjhTOFdrYlJUc25IRTVzaXdWcHNpNWkrV0EyZkFUa0dCRkZkbWkr?=
 =?utf-8?B?VGRHanJ1UHl1eU5uTEI2VGhxVDA5c0JxN1NieVFydXArTEowdXZIbVpPcWpI?=
 =?utf-8?B?eXQ1NDFPNzR2ejlldXU4K1VLS2J5WStESTdFY2lUR2Z3cU14TEl0WW4yQUl6?=
 =?utf-8?B?OVl4c21wbmFkdnpBK1V0czQ2K1BJM0oxNWg3UEs5OTNSUDJJdFhNOVUzb3F1?=
 =?utf-8?B?TkJvNjdKdnprSE0wcGROeStPdUNLTDNVVXo0T0dNeVR6NjMyKzRiYmpKNWJE?=
 =?utf-8?B?QnVaVlFDN09BT3ZVQXQrNW9jYWZrYUNNeXRjRkFic1dKbFpGUEgzY2x3NUhH?=
 =?utf-8?B?TkpKRkRBaUQzUzlUbkRkSGpOR3dvdVlSL2h6WXdlK29MNmkwd0x0bFR3eVFw?=
 =?utf-8?B?RkQ5ekE1d1o5aVRPSHdNREZaeTAyd2s2V1czNXBHMm51L0ZPQWhUV3k4eWZM?=
 =?utf-8?B?SzZVWUlRSTFKS0UvMTVwbW1rVElRbkk1YUgxUndwWTJrZEM3bDhVa0tTVitR?=
 =?utf-8?B?WTRUcktPL2YwZFJQeEtBMnVPbGx5Sjkzdyt0OWJ5V2xIRm85SDVrR2o4MjRS?=
 =?utf-8?B?cHBTS3IrTkhMcjJQV0ZqQTdLa3lBV2NDY1RWd0tvYyt5aTRISkUvQ0Zuc0d4?=
 =?utf-8?B?amRDK1NBZFczcXh3Q2o5ZVFuT2ZudWFtTkF5bTlJN2J3YU5xTFAwR0xCM0dv?=
 =?utf-8?B?b0JmbzBobW9oUSs5WWtWMzEyeWV4b28xbGptUERCMFRlUFVFYW1ZVTY0cnhV?=
 =?utf-8?B?d01YcFVPM1ZPc1IxdlFLYk1BTjdtZGZzbzlYejRJWTk3TmV4NUw0a3RPV2I5?=
 =?utf-8?B?cWFGNUt5Y3IrR1JTdkhTQkVqSzBhKzZtcHNlYWtNY0Y0Znh1Y1BrbmU5dmpq?=
 =?utf-8?B?MW5hZ1QwNEUwcjExb3F1YWtOZjF1N0x5eEVJRXVwdnpNVUh2QngrT3hIVTdL?=
 =?utf-8?Q?lLzmyP2AnpHBHTKpJwmeAnRP3fgiHyFogCVCdBk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWxtNDRtcDhkbThLSTJlMEdya094VXVISWhPbW5ObmNjMFNTMkZDenFPZWkx?=
 =?utf-8?B?Q1VNMGE5SXNiU2hnL1RJd0tTZlJrUEc5blA0R1hiTWZ2Nk5VTmI4OEdoY250?=
 =?utf-8?B?S0VCWWtVckdBZGNWQmpoQXpPQ05rS0Z1M0RYVWYvc3E5eGRSZ3BPVHB6MG1Y?=
 =?utf-8?B?anZpaDlPMlJIM2M5aWZpWXZxeEdSUVdqMHhyZk5xaEJHRURYeHVsS0FENmlY?=
 =?utf-8?B?QVpqZFV0K0hSemtyb3BFTnpPUGwvUEdpcVEvbm00RmtUODR3Q0J2ZkdNYWZi?=
 =?utf-8?B?NHh5RUZSYnNJcTNZVHZxUXpDM0hCSlNzTUtvT21ZR2QxYlhvWDZZdkhNK1Vz?=
 =?utf-8?B?OXQzMGJvYXIvUERDQnc2dmhrRi9mSE11VUVodVlCT0lZNWVpdmR4N3dKc0JG?=
 =?utf-8?B?Vks3RUR2UUhjejJwVmVncXpDK1FEcHhQek5Fa0MvQWVSVEM1UHNLQ2hwWEs0?=
 =?utf-8?B?QlMvcmpjK2FseFl6aDBZaWR4RHg4R0M3ZHZ4c1g1MktZaGRIZ0NlWEpsVzE2?=
 =?utf-8?B?eW1kNEdPaVRwODlnWHJMRDdwSUlnVTBlK0dJTFFZMjdoQzQ5VjNKMk9rTWFP?=
 =?utf-8?B?M0FNdXhMenludFUxblRqMmZZMy9mMldkSVRmZURYdHovMkdTUHNjV2dDaFlE?=
 =?utf-8?B?eHNrWmM1eVUxSGNZbXpiM3Q3Z3VNbEdEVmJ5cFl5MmlzcytHN1NuSGFJcWVw?=
 =?utf-8?B?MFdaYzFXWlluM1EwcWpXeC9IVExJMzhZbXNENFNBeFEyMGtaTVpQS3cwWjVZ?=
 =?utf-8?B?cjkwNVovRnYvcTdPM3VCSlUvVW5vOXJHYlppamtGTXc4aXFwWmtTWmtWQkcz?=
 =?utf-8?B?UlNrNlBiTzRxNW90cG1nRjlTQ012M0RwR3Q2STMyZXB5Q0habG9zVWNJYVlo?=
 =?utf-8?B?cEF3SXBqSkRtSlREQnpZUDVsUFhoZjVZZExHdlkvT202Nk96U2UvUzlLMlRL?=
 =?utf-8?B?bDBsV3YrWjlvWVhIcTcxYlo2UU1VUmluaWJCWEZQY1A5dlAwblhhMWVQT2Fl?=
 =?utf-8?B?UFhOWWU2ektnUkh2bW9ibE1tazAvUGdMV3RyUXhtTVowNENoVDQzdE9nVE9B?=
 =?utf-8?B?Z3lSR0lpbmRZM0dRSVpFUTM4U0FBUmRCMFVqRm4rRmNjYzc2VjF5RDNmSitl?=
 =?utf-8?B?bVdPajFRRWtyeXBrR015N2ZoQ2ZKYi9SQmZWVTJSeWZkTFhMangvZG5CakRi?=
 =?utf-8?B?cFRIaWY3c2dqMGhINFRZSVJudVJsekdpcHBSMEJ4dHZBVkMrc3IwRlFqRTFO?=
 =?utf-8?B?RHdzWnAycE03QXlSc0p6eGJhc0p2bkFkdFdDVFBxU1hPNk9NekM0ZWdxV3BZ?=
 =?utf-8?B?S2d3Unh6RWhaTWxjWEJyRDE3Q3Jkc3JBaW1lbnVjcU9aSmFSdzZqZnE3WnZi?=
 =?utf-8?B?aGNlNHBJZVkrKy85UHM4TlVwK2gyNStqZWp4RjFBOXVjUVlpdW1kVldpbEVO?=
 =?utf-8?B?b0ZuMG51SUpQWXVZQnJ4ODk3OHRnT1BYdm1aVEpJbTFIQzFUUmdnUVBkWSt5?=
 =?utf-8?B?WnBYVk5UOHlvcG82WHpWWkd3bTNkSjQyYWR6WmpNWHd5NmRCbEtXeFlKRHdT?=
 =?utf-8?B?dDRPcXRRWS90RHhIbWc0MEJzK0ttMExQSnM2UllySEordmtsQzkvb3J4SmNt?=
 =?utf-8?B?OExVOE5hSVZLWllRRmJ0eXFMWURVb2d1Rjl4RHAyRG4zMUVvM3lqclZDMzhK?=
 =?utf-8?B?UjdLWFFCRDRvUEhadW1IMTkxaDM3d2ljb1VyWlI4MFBsUUJsMWFTMDdiNWdj?=
 =?utf-8?B?R090QTNiVjZvMlpkeWc1YmZWVDJpRFM3RS92RFk2UEhpZEJzWUVRdUJUSzZG?=
 =?utf-8?B?N3JiTVVWOUpOTHl5ZWIySGYybUJYbDRtbzBqRTdNSVNnMThWd1VQU256Um5Z?=
 =?utf-8?B?ZzgwSEJaNHlyNC9aazgxZUJPLzQ1VHlkTzlXeXFBRE0yRUFMWm40TEpCV05C?=
 =?utf-8?B?ZzI4N3J5RUdQZjc3dFdWanArYks0VFZoaFVlTVVJb2piZ2Z1NS9NdVduZ2pG?=
 =?utf-8?B?aS83UDdKZGZRWjBjbzBESTk4TjZQWlBTdU4vekhodWM0Qy9CaTlyOTBIalZy?=
 =?utf-8?B?UWtWL1R1TzhEMXdrckVNWXB1bTZTY0NUZmhITmJtWmdmd2ljZlpBVnZlNVAr?=
 =?utf-8?Q?8X/clxr3kcZVFqiZEIdC0q8bR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e521ff-6be9-4fb1-b6c2-08dc8bd1c0cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:53:38.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJkke4na2tpracenPjU+OiRxC7VIKcmuOdue/IgBs/pXm/kVtJ8L+YnksNxIWPCSz1Tg0qL3HCf3jLzU8hV9ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

On 6/13/2024 02:25, Perry Yuan wrote:
> Updates the documentation in `amd-pstate.rst` to include information about the
> per CPU boost control feature. Users can now enable or disable the Core Performance
> Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index bcc0d9404c18..98e43c53c387 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -281,6 +281,26 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
>   firmware, if EPP feature is disabled, driver will ignore the written value
>   This attribute is read-write.
>   
> +``boost``
> +The `boost` sysfs attribute provides control over the CPU core
> +performance boost, allowing users to manage the maximum frequency limitation
> +of the CPU. This attribute can be used to enable or disable the boost feature
> +on individual CPUs.
> +
> +When the boost feature is enabled, the CPU can dynamically increase its frequency
> +beyond the base frequency, providing enhanced performance for demanding workloads.
> +On the other hand, disabling the boost feature restricts the CPU to operate at the
> +base frequency, which may be desirable in certain scenarios to prioritize power
> +efficiency or manage temperature.
> +
> +To manipulate the `boost` attribute, users can write a value of `0` to disable the
> +boost or `1` to enable it, for the respective CPU using the sysfs path
> +`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
> +
> +It is important to note that modifying the global variable
> +`amd_pstate_global_params.cpb_boost` will override the individual CPU settings.
> +
> +
>   Other performance and frequency values can be read back from
>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>   


