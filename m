Return-Path: <linux-pm+bounces-16594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3CB9B3634
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F351C25191
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4F1DF742;
	Mon, 28 Oct 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j8ssGj0i"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F41DE892;
	Mon, 28 Oct 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132024; cv=fail; b=HZqcrtij/G+QdQc9LTFYdtx2IrI/KE/mgEbRyNuiZtj8LL+t/34nNOYSILhj2CCRb/wgRCS6ye+mKzZnY9BIsEboG9HQyGR3Syj/n5K6EBOgE9J0uJLxCouCyW38RkYZKXMyUNJmkA8qnvY6bxshQ90KwSS+16uFLrkJ0RExdYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132024; c=relaxed/simple;
	bh=jkOp+3jgl6bKoLZYimsNN2CtMgH9+jkE1mSWri2L4cI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEuqcM6oIa6iFM6iF5jk9alefCL/cvek7UgZgShWw/27/beTSqiNFU1sczF8LXWD8WtNfhkvvHOHhuwBXYSY6w7XaKNbYrvRVGyUWZKCD7ctqMLIfxWm9Ph8pByOkpdL+OZxSKQxUUgqPt319aSUrWa/zK3QnayehlDc4lia5fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j8ssGj0i; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXxKHRaZbgRDOHrLGihpwuibrGHmK6Wzj2HZ/CHkyF8bz2mRCTmCE+UBj1S2HbCcamThrGGDTP9Lsd0eoOWenA8ndF5OHWGWPDF+HHxLVM15wciLw/THU/iEFpHer+P3TwSk1e2rs83bRKd9GEi82tejrkN8psXC0+J6yU2i/mZ8hSHS/zJ/+jkicW7haXlQdIgXQ+fHPrut//Eaf2zR2pTvZQoQoLWR7x7ZVZtUfNMbhfFs/ymYjFLqcXetE89waq736iIxuqZ7DULjhGUMnUxmOnwoTnTMn94epInKOt8gNloiHuRIrtA7fPAFHtwPSsXZySlJwr9jzC57S7xkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jA1NGnlOme0y7zK6QujyYQppNneq8GOqB1mC+AMKQ8=;
 b=cX3gv4dam/H43wroxHzeKQ+pXvpBOmdYByaNPTtax8goVly7ab3fx2gh/POVs4iYU3m53+nvCMlKkSwafXBNfP//H62KW6FHUybScxQmMJmlZWNOKEQdH8j4/9nFU19CNlJlGkxGinrxyQf+8lqgpT4i54monKr+6mJFrtlRwwiYRaxHf8PTd2yNXf3huMeEoxAOckZ98IBWEQx+rVLIIV4vESqXBbmlW3+Bkjql+wYc/J5elQdcGuBGuNopyW22WKvVZdNMk/wMrptjHWQ2L1FGwPWF+0VbN7QH7VfUfC3CByWp3eQLmRtbyt6I6+yet+ldTZu5E5q4edWWKm7ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jA1NGnlOme0y7zK6QujyYQppNneq8GOqB1mC+AMKQ8=;
 b=j8ssGj0iyoTxT7V9pjLZTQKxtPRVRJDJ/5HPp9ZzMo19fP7PtVwe9fVFfsYtJcB4s1xAqQJ57f675f22CXutEhriEpJUkTrRwPyt4GNCp+S1JqpQyH3FJ7thiiGssTbsCUWYmFNNZ75CSOndiTLUJ21THN09rPlElAoOp3dhQJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 16:13:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 16:13:37 +0000
Message-ID: <30558310-59ab-4c92-b3a2-537eb3605196@amd.com>
Date: Mon, 28 Oct 2024 11:13:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20241028020251.8085-1-mario.limonciello@amd.com>
 <20241028020251.8085-6-mario.limonciello@amd.com>
 <c7cac2dd-8fc8-498f-b3c5-bd95900e881e@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c7cac2dd-8fc8-498f-b3c5-bd95900e881e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: cffcdcd0-4556-4964-d567-08dcf76b7a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VoYmxOd1N3aGZYOUNTZCtySGt6Z2lFSDJ3Z1dCTURLSnRDRUxSbTczWWVR?=
 =?utf-8?B?blRnMUdrNzBVMkwxaGpRRFlIajR6TFdDMVlaejdkSXRTa2VkWlVDblkzbnla?=
 =?utf-8?B?WkxTZW1TRnk3NU5zbmtmYXM4ZmN6V0FDZVdmRndhNnRMMTVwR1pteGtUcFo1?=
 =?utf-8?B?cTRLL2tlVFl3cUJZTXFzOXVOY3VsSS91elpKWU53YlhRLzZPM1dSRW5qcmN6?=
 =?utf-8?B?V2RuU3ZiaEU3UTZJd2pQRUU0bGVGSHRrSHZqVlVxeTg4VlZCcWxnSENqWVBx?=
 =?utf-8?B?bnhVcnhhVEpjWVFwSlVhT1hNK3R5WkJZRzJMZnRXalpUeHkxWENHd2VLZytP?=
 =?utf-8?B?OE9jVWJacGhPVEtBb29lbnRua0prc3RiNlNFc25DWFpOdVFucDRSRmRFS3dr?=
 =?utf-8?B?Z21SYkduTkoyTkdmZzRQdE1oR29VNWY2M2tiV3RtakFNaFoxTDJUVE94WFhI?=
 =?utf-8?B?eit2ZjNnYWp2aGdDSGp4VnIxUjVZcU5wVVhGamJzZExKQ2t0c3FrZVRyZU15?=
 =?utf-8?B?SlV0KzRvSGYyTmpDRVpEK0ZRL0EvODBqU1VpTUQxdjZha1h6SUw3VnB3Q3pl?=
 =?utf-8?B?QlpGWml0RlEva1dGeUd1S3NVVzNhd3pyUWEvNDEvRS9HM21scW82ZlRjTDg3?=
 =?utf-8?B?ZVlwQnFEMnpCYy9CZDJzUkx4SEFqY0xMZS9uUWtwQWNjeGp4QTJIcEJSK2tx?=
 =?utf-8?B?ZDZwTWFveTdKZlpKYzYyWHg1U3h3NjFVNFA3SFA4V2s4ekNTMXl0OFo4TCsx?=
 =?utf-8?B?bi9IUWhXbWloU3FGQ040U3Z2TXN1cXljWEk5Tlo2bVNrMjRYVkhYRXF6SlNu?=
 =?utf-8?B?eGdMaWpiMytEQTNuckpzd2s3N2NYMjRMb2xzS0pIZ2lTWnJrT2hWSGpqZU9k?=
 =?utf-8?B?VThiM3lEQ0x4NEYwMy96aERET29ZSlRZcHM4L3ExWFcyY09MUFdXa0ozZlJs?=
 =?utf-8?B?ZmdTZ3lQaDBSNzgxNXpVaWpRbENBRzJVV0liYXhmWVBLOW81VDJDa1JZUTZj?=
 =?utf-8?B?UDRFYnBFK3JsdlFaL0M5VU1SM2dVZ1V5T0xwSndpNkFhY2R1U1ZmYkNUb2Ux?=
 =?utf-8?B?SzJZbXlpT095ZUpVMDRIcVpUeWg1LytNSHFiRzBVMTV2TGMvZHRYT0JhV3FH?=
 =?utf-8?B?N0dBVC9CbUI4R25sRWR3MHEvbXEwOWhoOWRjaTNzUWI3N0ZhaGFLVXNhQ3Fo?=
 =?utf-8?B?RUxFZ2JBam8zNUx4SEVSWndIVFErdUY1VkVzZ0F3R0NDY3VZSzA2RDlybjVF?=
 =?utf-8?B?MGdtWm9Hd0xSbGNJODl6L1VveHhTcjIwRTlweEd0WkxuYkpkWGJVT1RKVS9Q?=
 =?utf-8?B?ajcvL1VLYVRJWi9kQmRoa0l2N2pKeUF1L2I4bzR0TEZQelJWSC9uY2FBVHJu?=
 =?utf-8?B?VXY3bFBkSHBicytmak1tb1JGektOK25lOGY2N29uWnhuSFB2bTQ5RDN1Ui9W?=
 =?utf-8?B?ODJkNEp0TTZIV1FFcm1GMFNaNGpnQ0VIZjBycFcyWmpFTkpNUnJyTVF6OXhp?=
 =?utf-8?B?SnJGb2hSaS9rb0N6MGpva1dvNjlGWmZHSFpybVdMZ3QyYW1EVWVIbHVOQUl1?=
 =?utf-8?B?SXRCUEJUdjNveGFVdmN2UGpMcmUzUkFQVWgyNEhteTFKSkY5UmEyYS9HT2lZ?=
 =?utf-8?B?ZFBtRFdJVVE1cmREdmcvaFVGR3VlNjR3dk1sSUFJQi8wd2RVSE5ocWE2eUp4?=
 =?utf-8?B?M3V5cllENm1xbUt2SjREdmh6ZnJBd25oRFN0WThSWFVYMG1kS0VURkQ0ZkRX?=
 =?utf-8?Q?zrnnFm67mV9Y+U0pHx9N4GAk7DJeudeWhy1R/Fx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFdrbGlHTVFQbVJmYzRzVHVIb0ZYRUJoK1FvWU8wdE5Md2FyNGVLVEl2eGdl?=
 =?utf-8?B?di9nNnlZb0R2VHYvaHJ6TDc3N3R6ekI1M3Z2L05hNmo5blhjVFFYalJ0c1lJ?=
 =?utf-8?B?K2FGT0VJb215SzZodFJUZmZQQkQ1d1U5dkZ4WEZCcURETE9HQ0hjTE9NU3Vx?=
 =?utf-8?B?RnZlYkRmQUtMT2R3VGFqZW9sUStDSENGSHMvOFFlU2w5dnVra2UzSG8vR1ll?=
 =?utf-8?B?UzFjdXBDN0xRN0dhOEhJWElLQ1Fpa1VpNzR3eklZbDRhNWZBQSs5cU55dy9a?=
 =?utf-8?B?bzl1Zm5LREJ4TFlDMHRlNEZlVHJvS2VldCsxK2hFMG52cWdKbmpFOXNmeHNi?=
 =?utf-8?B?R0NVdEpSM2twNmNXc3k0NmJoa0FXeTkrYlZiY2kxOXQ2YnFBRitKS2FPZjcy?=
 =?utf-8?B?YytJMGJyRVdwdEtRNzhUdmkyZTlZOE9STHFENVBEM2pYUHlNbjJnRmFqSi9y?=
 =?utf-8?B?UGp0VVZGWUF2ZmdUQW5QS2d6ek9rMVBaWThOZFdZZVJ4T2haOFU1Z1Y2WVNq?=
 =?utf-8?B?T3NvZFNwWnFLRVBqSEdmdUlHWlhLNVdRUHpCRkFUL3ZRTzBWeC9BM0ZERDkz?=
 =?utf-8?B?TkxueVFVWERnQjVnemdjQmFFZE1GeW82TzVDaElzMXUzVFRMR2RoNExieGJs?=
 =?utf-8?B?OVZBZGx4SU9FZzdYVjNSYmNCYnVKc3R1ZGdYMWJudjdSN3JNLzd0Smk2RmJL?=
 =?utf-8?B?Tjh0NzJmVnFld3BxZEViUnZsdE0rbmV5S0Y3UUloNjVibTUyMnRPck13RC93?=
 =?utf-8?B?ai9vMFA5c21zdmdlcXllSFhiME1QNXdKL1FmdHpSVW9KK0phMGoyZVp5YjRh?=
 =?utf-8?B?ZXFoakhQL0N6RHZCS0M3WVUyR2kxMXFvK2V4eGRzemxldk1NbXY4cU10TWkx?=
 =?utf-8?B?MDQ1NUNpdG9HaWF6OFZUNmU1RnZ6OFhzN0wvV21ZdXZBR0tqNUhXZW55SVN0?=
 =?utf-8?B?UWZxODE1VkJMOHFkbFc1RzNDcWQzcGdxNmJrZ3BTRDV1NlJYN2pUMGJkODhm?=
 =?utf-8?B?L21YdHNIM3NBa2hZNHhUdmFHQXRNWE1PeHc1b3Y1OGZEMk9Fc3EwZlhrOVlC?=
 =?utf-8?B?WHBPeEN1R05QSE1MVS9ROWV4bzBobGl6NlA5R0VRWVRmVGhtTVJ2Z3d6REY2?=
 =?utf-8?B?SWpyenQ3Y1hWV09sWVJDb2lxSzNZcHNySE9YZTkyRlZrcjJjcmdMdXZNSlBO?=
 =?utf-8?B?QUptYnJGRVRUNUlZWnRpYW9jY08ybTNNSkY0VjhIV0gyQ2RuYW1xZXVkZ3Y2?=
 =?utf-8?B?dTVCSTdMNXZ2M3hKUHRyZ0RrTVYwMW1IT2hYQklIN0NhWVNwNGFaRlZQaDV6?=
 =?utf-8?B?Q0JWc0VYSDVValdnckRiRkRlVGcrTlJ1cC9pdmpIcXBnRmJIUDBrN3E2ZHNl?=
 =?utf-8?B?U3dNY3JBSVJGd0xMZk1CbStSbTZPb01xWm5DQVNwdVcrSzA3cWVwcjJueHFX?=
 =?utf-8?B?d2Exdmx0RmJGOVJMa2xtQmcwaFdDWTJNUmN4a1ZLSWUwUGpGdERlZ0gyN0lO?=
 =?utf-8?B?UEhIQWd5ZTc0ZE1zSW5aNkxuRHhtdEpKUDVlWUdEM01takRUTHBBNTRkeXhu?=
 =?utf-8?B?V3dtM21kUXoyeW8wZWZQMUhZUVd6NWRqS3BLS3lZU0NLanN6TGN4R2hwc0l3?=
 =?utf-8?B?NWd4RnU1WjdkZGF6ZXR2bi9XT004MERCVndzYTJCcUhlMUI1SkF6YnU0S1dF?=
 =?utf-8?B?Zktsdlkva0JHYUwxeE1CMnRtZURFUys5WUlUc0VpRXFvWU9qOWVlK2QwUmt0?=
 =?utf-8?B?YUFJRDQwNXBYa083VXR0SHBsRnhtQmdaeE85cVdPT2RwQzY3K1ZFUGIzTk5T?=
 =?utf-8?B?TnQwaTl4YkJFVzR3OXRmOVBCYVhZbFlOSHBaRVVBdkZEaFdwS1pReXkvelY1?=
 =?utf-8?B?bDlyTmk1OEZiYkM5bFdxUmp5dEtFTS9TazROMURHKzZxcHFQT3E4VEZoWm51?=
 =?utf-8?B?ZnJoRUNiNkZkMnFNVk8wcHRWQ2R0ZFRkUUlBUVprNmxHd2orSTFZM3hqU1FN?=
 =?utf-8?B?a21OdUVUa2R2WmovdlRTVlJNckZzcDNEakYzb3JXcXl3SnFVUkkzTCtaK0xN?=
 =?utf-8?B?QmFEeVdjM1JobnJLbGgvN010SmFMYlpUSzUyT1ZWdnhNL3NlWDNocEVsNjBU?=
 =?utf-8?Q?kXXL2eaJhdZkt8WdiRCl+bg3z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffcdcd0-4556-4964-d567-08dcf76b7a8d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 16:13:37.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiYLUsQ8cyUdGu2Esri/Ev4AnpGSZX7mrJtFRgtIgBfF3IqcwE+zeklsM1nNjqV5/plQeuusLn9nNbugUyFGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765

On 10/28/2024 00:52, Shyam Sundar S K wrote:
> 
> 
> On 10/28/2024 07:32, Mario Limonciello wrote:
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
>> provide behavioral classification and a dynamically updated ranking table
>> for the scheduler to use when choosing cores for tasks.
>>
>> There are two CPU core types defined: `Classic Core` and `Dense Core`.
>> "Classic" cores are the standard performance cores, while "Dense" cores
>> are optimized for area and efficiency.
>>
>> Heterogeneous compute refers to CPU implementations that are comprised
>> of more than one architectural class, each with two capabilities. This
>> means each CPU reports two separate capabilities: "perf" and "eff".
>>
>> Each capability lists all core ranking numbers between 0 and 255, where
>> a higher number represents a higher capability.
>>
>> Heterogeneous systems can also extend to more than two architectural
>> classes.
>>
>> The purpose of the scheduling feedback mechanism is to provide information
>> to the operating system scheduler in real time, allowing the scheduler to
>> direct threads to the optimal core during task scheduling.
>>
>> All core ranking data are provided by the BIOS via a shared memory ranking
> 
> /s/BIOS/PMFW. (as you have mentioned it as PMFW in the entire series)

Ack.

> 
>> table, which the driver reads and uses to update core capabilities to the
>> scheduler. When the hardware updates the table, it generates a platform
>> interrupt to notify the OS to read the new ranking table.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/platform/x86/amd/Kconfig      |   1 +
>>   drivers/platform/x86/amd/Makefile     |   1 +
>>   drivers/platform/x86/amd/hfi/Kconfig  |  20 +++
>>   drivers/platform/x86/amd/hfi/Makefile |   7 ++
>>   drivers/platform/x86/amd/hfi/hfi.c    | 168 ++++++++++++++++++++++++++
>>   5 files changed, 197 insertions(+)
>>   create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>>   create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>>   create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
>>
>> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
>> index f88682d36447c..c3f69dbe3037d 100644
>> --- a/drivers/platform/x86/amd/Kconfig
>> +++ b/drivers/platform/x86/amd/Kconfig
>> @@ -5,6 +5,7 @@
>>   
>>   source "drivers/platform/x86/amd/pmf/Kconfig"
>>   source "drivers/platform/x86/amd/pmc/Kconfig"
>> +source "drivers/platform/x86/amd/hfi/Kconfig"
>>   
>>   config AMD_HSMP
>>   	tristate "AMD HSMP Driver"
>> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
>> index dcec0a46f8af1..2676fc81fee54 100644
>> --- a/drivers/platform/x86/amd/Makefile
>> +++ b/drivers/platform/x86/amd/Makefile
>> @@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
>>   obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>>   obj-$(CONFIG_AMD_PMF)		+= pmf/
>>   obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
>> +obj-$(CONFIG_AMD_HFI)		+= hfi/
>> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
>> new file mode 100644
>> index 0000000000000..08051cd4f74db
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/Kconfig
>> @@ -0,0 +1,20 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# AMD Hardware Feedback Interface Driver
>> +#
>> +
>> +config AMD_HFI
>> +	bool "AMD Hetero Core Hardware Feedback Driver"
>> +	depends on ACPI
>> +	depends on CPU_SUP_AMD
>> +	help
>> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
>> +	 selected, hardware provides runtime thread classification guidance to the operating system
>> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
>> +	 These capabilities may vary due to the inherent differences in the core types and can
>> +	 also change as a result of variations in the operating conditions of the system such
>> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
>> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
>> +	 resource allocation, leveraging the diverse set of cores available.
>> +
>> +
>> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
>> new file mode 100644
>> index 0000000000000..672c6ac106e95
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# AMD Hardware Feedback Interface Driver
>> +#
>> +
>> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
>> +amd_hfi-objs := hfi.o
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
>> new file mode 100644
>> index 0000000000000..a92fe74b415e3
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Hardware Feedback Interface Driver
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
>> + *
>> + * Authors: Perry Yuan <Perry.Yuan@amd.com>
>> + *          Mario Limonciello <mario.limonciello@amd.com>
>> + */
>> +
>> +#define pr_fmt(fmt)  "amd-hfi: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/gfp.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
> 
> required?

Nope; will drop.

> 
>> +#include <linux/smp.h>
>> +
>> +#define AMD_HFI_DRIVER		"amd_hfi"
>> +#define AMD_HETERO_CPUID_27	0x80000027
>> +static struct platform_device *device;
>> +
>> +struct amd_hfi_data {
>> +	const char	*name;
>> +	struct device	*dev;
>> +	struct mutex	lock;
>> +};
>> +
>> +struct amd_hfi_classes {
>> +	u32	perf;
>> +	u32	eff;
>> +};
>> +
>> +/**
>> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>> + * @cpu:		cpu index
>> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
>> + * @class_index:	workload class ID index
>> + * @nr_class:		max number of workload class supported
>> + * @amd_hfi_classes:	current cpu workload class ranking data
>> + *
>> + * Parameters of a logical processor linked with hardware feedback class
>> + */
>> +struct amd_hfi_cpuinfo {
>> +	int		cpu;
>> +	cpumask_var_t	cpus;
>> +	s16		class_index;
>> +	u8		nr_class;
>> +	struct amd_hfi_classes	*amd_hfi_classes;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>> +
>> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
>> +	struct device *dev = &pdev->dev;
>> +	int idx;
>> +	int nr_class_id;
>> +
>> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
>> +	if (nr_class_id < 0 || nr_class_id > 255) {
>> +		dev_err(dev, "failed to get number of supported classes: %d\n",
>> +			nr_class_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_present_cpu(idx) {
>> +		struct amd_hfi_classes *classes;
>> +
>> +		classes = devm_kzalloc(dev,
>> +				       nr_class_id * sizeof(struct amd_hfi_classes),
>> +				       GFP_KERNEL);
>> +		if (!classes)
>> +			return -ENOMEM;
>> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
>> +		hfi_cpuinfo->amd_hfi_classes = classes;
>> +		hfi_cpuinfo->nr_class = nr_class_id;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void amd_hfi_remove(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
>> +
>> +	mutex_destroy(&dev->lock);
>> +}
>> +
>> +static const struct acpi_device_id amd_hfi_platform_match[] = {
>> +	{ "AMDI0104", 0},
> 
> Space after "{" not required.

Ack

> 
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
>> +
>> +static int amd_hfi_probe(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_data *amd_hfi_data;
>> +	int ret;
>> +
>> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
>> +		return -ENODEV;
>> +
>> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
>> +	if (!amd_hfi_data)
>> +		return -ENOMEM;
>> +
>> +	amd_hfi_data->dev = &pdev->dev;
>> +	mutex_init(&amd_hfi_data->lock);
> 
> devm_mutex_init()?
> 
> using managed APIs can help remove entire amd_hfi_remove() function?

Ah yes, thanks!

With a managed mutex amd_hfi_remove can be removed until the final patch 
in the series for debugfs support.  For v6 I'll drop amd_hfi_remove() 
until that patch that it's needed.

> 
>> +	platform_set_drvdata(pdev, amd_hfi_data);
>> +
>> +	ret = amd_hfi_alloc_class_data(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver amd_hfi_driver = {
>> +	.driver = {
>> +		.name = AMD_HFI_DRIVER,
>> +		.owner = THIS_MODULE,
>> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>> +	},
>> +	.probe = amd_hfi_probe,
>> +	.remove = amd_hfi_remove,
>> +};
>> +
>> +static int __init amd_hfi_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (acpi_disabled ||
>> +	    !boot_cpu_has(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
>> +	    !boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS))
>> +		return -ENODEV;
>> +
>> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
>> +	if (IS_ERR(device)) {
>> +		pr_err("unable to register HFI platform device\n");
>> +		return PTR_ERR(device);
>> +	}
>> +
>> +	ret = platform_driver_register(&amd_hfi_driver);
>> +	if (ret)
>> +		pr_err("failed to register HFI driver\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static __exit void amd_hfi_exit(void)
>> +{
>> +	platform_device_unregister(device);
>> +	platform_driver_unregister(&amd_hfi_driver);
>> +}
>> +module_init(amd_hfi_init);
>> +module_exit(amd_hfi_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");


