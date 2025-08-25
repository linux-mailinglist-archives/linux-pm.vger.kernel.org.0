Return-Path: <linux-pm+bounces-33054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F40B34DF4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 23:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC5E486AEB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2882868A9;
	Mon, 25 Aug 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MEJKdxmU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176F1991D2;
	Mon, 25 Aug 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157165; cv=fail; b=i1RdC+UYasxV0QsQavLh0jLmx2lTUvA3DYT3ikLVW6ZzQT1X4Ucy7mp6JCqq5CuoioAZqUParfPS36lm7RoYSrj7wfHL9+MnKkOcNGgU4G1cQRe2MXlhWohu7grH2PW4S+DMgQAWsPftQdS6dXtvxm2WTlT+rLYIFGcnokV2QGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157165; c=relaxed/simple;
	bh=b8pNQo9N70+OXflQKlQUmH7Liu8MinrStK8tmVMQtpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hzNaSjPOvHecB1YwvM9ii2fQZEomrc1I/p2mijIVw1QCUOC/aymlMD0A9+IkE16oMwgZxgPfkDBigB8NYcXufro/3eLYIoqHoA7iEk+u8gDCg8m+XzkxCj/aJO7pZwMMmCyNbalW+QJ601BzIaxRWFAKCsOaxGm1O/DM9Msu2wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MEJKdxmU; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6wziyyk16T9RqmXK4G29UqHwn0V2dd8haNSC+Ml65/o3SsR2lDPM0OtX4WY/tiLJuZasgQU44TQAdI7/FLrb51KPLoH4ZKzFHP6LFKSaovQfEzmq421xSX1TTBxKbSMlQS0NcCQp2yYr0N2PTDT/AePtirTg7rWBOOQpl0247mN0cZa25pjs7Q4YgsU7UFZzgzOYXp8B0/yh1WW7V+et/Nw61Ty0dYPUNLzJi7ttQdw1m35u/zxrSIGD+w63318fSreqpoFnRSdnxq2yNlO0H1Hz7eSfARiz7KD8PFkd7r+0k8HQdbVbHGCPaRUSwnyIazOERV10pvrnwytk65E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9paDY7QyhI8WTO+/0FXNaksvlLOW2r3I6g+B7NwTDxg=;
 b=B/Fc0aWvSRZB1zlRfKCUctiXlc2vYs8vP6VfmthN30jziEnZKXfkoy39+q2lIBgV4S6b3vW81UixrEF+XfNTqHDfv3q/qOED05Rcq1RnwPivTyS1FKMShi5nmHfuiySWbhYNjI7vq7Iu06FcXinpKPjq6xwphkk3Islzv22Pxev0V+d3ljJKKzsGsTd8E58oK2V5IbZgR0ry0ZIfKIxZFS+ObPdgRz2I26XmSecni7sjHoVCz6t7wZ3TerG09tyA8NPZggykuXHXuhUR1DLFl+SBi7aow6sia5GMrmQHPI9EZCTBLGiybqxmnNoC13iSqmx6sKBuyDc3OVZ5WLJ4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9paDY7QyhI8WTO+/0FXNaksvlLOW2r3I6g+B7NwTDxg=;
 b=MEJKdxmU0M5YzSvXmmNSDJc+tPK0MdvqFrmnWCI+VQ8hsuiDBivYYeWCTO+m8rRzmA7T8xr1bquJLoj5AAW5I16snl86FmUjH9esguAcjZI9H2ASkiufVR2K7fI/S6lMRBIKZuoXEYfQC9g24ucmvlCZ5x8RakKus45Cu4JT4BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 21:26:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 21:26:00 +0000
Message-ID: <75046094-d3b7-49da-af8e-3747ae9ed272@amd.com>
Date: Mon, 25 Aug 2025 16:25:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/x86/amd_pstate_tracer: Fix python gnuplot
 package names
To: Kuan-Wei Chiu <visitorckw@gmail.com>, ray.huang@amd.com,
 gautham.shenoy@amd.com, perry.yuan@amd.com
Cc: jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250824200902.163745-1-visitorckw@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250824200902.163745-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:d3::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c3ac2f-10a6-4a7a-afd2-08dde41dfce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHZ4Qm5Nek5sQVd5bGlSVkVvclRLVG9QNWNuZnhlRllmVzk1MlJSdlFBODhN?=
 =?utf-8?B?Ry9FMXpCTytpV2tOOS9kUEdUV2xOcWhSUmFBbFJ1VEMvUkVGMDk1ZTJPQkZM?=
 =?utf-8?B?eE1oa2d1Z0Urb2N3VzRKUXZFcXhrMkF4MDU0U3Y2ZUYxOUF3NFVYckJWZDBK?=
 =?utf-8?B?NjhFODBjWTU3bDU0L0RmK2NDaXBkZC95S0RhUkUzU1U1ajNXamRmZFJXaTh3?=
 =?utf-8?B?R2VicCtBRkhJVWZBQllzN1ZXNkhLVEE1WnlGaHU0dEhNNnhaY2ZNblRhWDhX?=
 =?utf-8?B?cVJxMWd4TTdzWkN6cXRFcVc1WGs0UnRDdyt5NDI0TU50OTkySGErVnF1a3hV?=
 =?utf-8?B?dHpFeWVTc1hHZmtWTjVvZ3VNV2plNi9sY3ZBRU4rM1MzcnMwUi9NWnVBSjBN?=
 =?utf-8?B?WENQQUoyR1NYNStPOFdGVmFYYUdBV09tbVZOTG9rdit3Y2t4RG95ZVFhbVgw?=
 =?utf-8?B?a3pTcWkzZ0FXNkxCaHRrYVV4elNXY3VNaGNVbWM3cHB5QUJQWWNOY3owYXRw?=
 =?utf-8?B?NG1McjFncHZndkxYc010eFVOYXI4cHpwSmFzb0hlaEJ5Z3pGa1lveENTd0cv?=
 =?utf-8?B?bFdWNWNZUGZQMHZ1OFhKNFlKUnA4NkUvaFBrZVVNY3FRTDhxeGQrVWYzM1lh?=
 =?utf-8?B?QWpMVG5WQ3RwRTl1WDI2c1Y3bU9EaTQxVXV1Q29GS3pBTnE3bmpZTThnUE9P?=
 =?utf-8?B?eThkcEtrWFdqNWZjd2VadUpJNGtBa2lteVlyUjJaZzBuMnpHYjN3VytjclZV?=
 =?utf-8?B?YTF2NVRFVTNuSERQWmtuT21iSXV0TU0yQ2ZOSVUvZ1pPZzQxSjBTVVp0N0ZU?=
 =?utf-8?B?Wk90WUtseXo1bmo4dXZrT1kzOWN3Z2pFRWNjQk5jY2RqbWIzM2J6WHVTM1l4?=
 =?utf-8?B?UXFWejVzd3R1bDFlNWdSSVRzQmJXUUc1MVpQNnJNaGNDdDRZOSsraUMxa1hw?=
 =?utf-8?B?bHRQQkRrLzM3TW12STZLSzZYV252Z3NVcnQ3aGRjQUlubnN4dDdlTitsM1lD?=
 =?utf-8?B?MStSQTUzcUpIUFhLbjVHM1U2b0gwa2VYOUdxeGNTb1lnS2dXOVFoaGlsRHdt?=
 =?utf-8?B?cVNQNUVaU0RFNWlzcFd2aTh2aFBNcVppdE1LSFVWWEFnUXVPOGlZNUczcys3?=
 =?utf-8?B?YlovMDlqVHpMeDZlNnR2U2pjdm5ZZmZxTU5FaU1ud3NYanRNMTk1VStsbmRr?=
 =?utf-8?B?RElTK1hBaTZEbGkzblNNZHVsTzhVbGE1blNGWEs3Y2g4aitQV0kwNkFwQ3Bj?=
 =?utf-8?B?YUdPVEpnWk1HV3c4WlVMME9FVkM1dGlsZ0wvQjU2eXMwOEE5VmVmbm1JWE5w?=
 =?utf-8?B?YlVsZys4Z0xJZ3J5UWM5cW9zQTl2VTBMWGhWZEM4ZExuVlVWNkx0ZHpGR3dT?=
 =?utf-8?B?QS9Wa1lIREdlL2hSdFlYV3pLbTV1QzdQRndXV0p3bXVqZWl0elllZUxvb3Jk?=
 =?utf-8?B?MmQveTRGQ25pSS91cDJKa3oyZ25QTzFMclNkLy9Ja2tSeHVpZ0U2OGFvZVow?=
 =?utf-8?B?NVRuRlBBT0Z1bjcyYmI1VjBvRHNlMWJTODVwUVNtVi9IREVYMFJNTjkreTlX?=
 =?utf-8?B?UGNsVWk1cUw2b2FEVFRCbUFLcVhHd2VlQkQvdEtnei9kT2JYNyt0VisxR3k1?=
 =?utf-8?B?L2tkQjl5SkN5YSttWTczZFkwbkJnZjJndWtkTnVYbWhhLzBpeitydEpjNGMz?=
 =?utf-8?B?YURFWElQOENGbXJlVG1ORE5SNjYvMWdkcThXRHVTekVzd1plVmJueFR1UUov?=
 =?utf-8?B?VXhFeWRKQ2w1aXppcHVWbng5T3g4KzNPR1ZJNmpBTTdUWERwNjlIcDk3dEJt?=
 =?utf-8?B?Ky9WRFdxZ0d5eUVUMHozc2RCdkpRR0V0RGc3akxmVnJYY1NxMUcwYm0valVh?=
 =?utf-8?B?L2VxMitiY2prK2swai9EeWwvMXRhNlYybFlZSGVheEZ6emhGeVEvdFp6Z3gv?=
 =?utf-8?Q?8mCTW9J8gOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1EraTlES0NiMU9wdGNlMjJDMFQ1MVF1bmZxWUcxQzBUUjhOSE5EMEtkL2dR?=
 =?utf-8?B?bGZJZ2tvRWVDSTZYZ3lUdkg3WVF5bWhxSUFBYmNSbStXWHp5RmdjNHQxMnRn?=
 =?utf-8?B?Q25UTkxKdEFBR29uM2V3dlBBN25iVHliS0VEYkJCMG05R05PbThTbVlhZFlZ?=
 =?utf-8?B?bFZxb3oyR3N1TXZia3VTSE5pS05Wc1Vhb2czYy85YTBZaGhhM3I0NTIxa3pT?=
 =?utf-8?B?Tmp2eURkOTRnWWNLQkorNFZPYkF4ZlVjaHRORkt1eEJTT0RPN2FUK3ZvM29T?=
 =?utf-8?B?dDlUbnZIZXNrWXM3aE5TaE85bUp6eC84cmJlNE1aYkc0Vit6UUF0d0lTR3p3?=
 =?utf-8?B?SHpTYXRkRXc2YThFSlpJOG9GUlh0MnIvUjl3R2JiMU1yNlQxTXVneHRaeER4?=
 =?utf-8?B?cFFaMjBjMGZTMkJmeWRacXJpdXIxa0QrVWZmQjc2blNMK0dOc0ROLzFOK1RO?=
 =?utf-8?B?cllUZXN3V0pxWFBoSHJLcU1sZEJybTg4cFY0bHNNYVk1TjNzTkZrQU9kd0tS?=
 =?utf-8?B?a0YwVGN4dEhtNUJZTHRUZzVOdGhqTGVIekRvNFpGVXhROUczeW9RMHpJalR0?=
 =?utf-8?B?YUIrM2dDQXFLVy95QjdUTm96M3ljbmZWMjBDVTNQQ29veVpNQnl4aFI2MDVn?=
 =?utf-8?B?Z3p2d0QwU0F5NmVGTitoWU1WY2k5ZGxxRGhiY05tdUJyT1QvcWN2SEtQTE5N?=
 =?utf-8?B?Z280QnlPT2k0WmdZcmRuVE5XNlJjT2ZZTlJsT1hUazl3SkIrVlV3a3hPZlZB?=
 =?utf-8?B?cU1LaU9Jc0wybFdQVlArNGpRNHlaK0FxL00xQXVCUk50L093ek9yOWt3VDJ0?=
 =?utf-8?B?bTlDdGRPV0d4QnYzRWlBNUZLUk5RUTFFZW14OVlkeFVDSEVDN0NQcFR2TWdt?=
 =?utf-8?B?L3ZhY3VrL1BPN2tnQklXWktuWkZFVlB0K0l5cmh2L3A1ZnE1KzFNVHJTNlZV?=
 =?utf-8?B?VCsvaXRiMlcvd3V6OUJvNmRCTVYzazErZ09LbU9qamxzV25IYU9qV0lQWXBT?=
 =?utf-8?B?bFdmOElTck1tbFhJMEEwUE5icGpqbEtoenYrTFRialB1TDFRaU5PQWovY3J1?=
 =?utf-8?B?Ny9WVnk0aHdRV2dabVBIYTRLeFJPOWk3UVNVT3Bxd3Y1ZHBqeVhkUFpROGJa?=
 =?utf-8?B?SE5JN1g2SjdhWXZlQXF1NzN6ajNqTmlQb3ZpT2xVb2JNSlo2SXJEd1NFZTdq?=
 =?utf-8?B?RDFMb3h1d0tPdC9YSm5id0FkZURFT0FnalRrMWFRcFY2eTJQOE1lQk96Qnht?=
 =?utf-8?B?ZlB5eWpEeHIwVGE5M0NIT2FrZWsvQWFINWVWd0hTT05yRnlqa2x0T05BdUxa?=
 =?utf-8?B?TmdzTzRtTlJSd0I0YnZEQzhYQ0I1am5wWG9waEI2SFZlYnJ3aDFNTkZ1Q1U2?=
 =?utf-8?B?L0lLQk5EQlZBamlRRDJNSmVLb0ljNlgwVXhtK05wNkRCVlRIUURkWm0yYmJw?=
 =?utf-8?B?VmxmQXJXaHJvcFl3VzJ5aTdtRG1ENGMrdGtpK0dWQkFhMmQyWExnNjFKTkNU?=
 =?utf-8?B?c3JQNzhPWVBsUk1YUktqZnJhMklEbmx1ZjR1RE1aNk1pWW1LblpBM0tpV2Fv?=
 =?utf-8?B?Rkk1NkJEZC9rcEh6WSs1bjZueG5GcU1nbExwUzFxNVkwd3MzZVZtbFgzN29F?=
 =?utf-8?B?RXd5eVN1KzdEV3pDQ2NJUUVYUDFGTTRNeGVUYzcxWmpHRkNSemgxY0dNWmNs?=
 =?utf-8?B?QkFsbEx6T0pldVdiL21SakN2dUIxRTFtQldCNEpWWHdwa3ZWdFg4aGRDOGha?=
 =?utf-8?B?elNvSHFjYmlTMkJJUDNGQlMzbndNdmF6dFpQNHNMVGMxTUJaZ1BIQVpvL3hR?=
 =?utf-8?B?cFdmaVNoMXNNZDZKQVg3T0JWUytHMU1uNlFRU2NUUUZjUk93NFFXMC9jNkRy?=
 =?utf-8?B?OGlRZ3kvTmdIYXowWDMxRGROaWNYazFIVkJjY2o3N3AzV0tpakxPRVVFZFVL?=
 =?utf-8?B?WW5heGhZRWtQQzJFbmo1aVBSM1dXL2FwOU8ySFViVldvL3F0M0FSUUNWZ01N?=
 =?utf-8?B?ZHNEQnFaU3BXeCtRM01OT0Roek1scE16aTdLck9EdEkvUDc1ODhIMHJST3Bo?=
 =?utf-8?B?YlJxaEZYUmVkSWh5S1ZrV1JkNE5XUTdNSm5Xc1BRYWEwOGZTT21qL1FFc0Z1?=
 =?utf-8?Q?F5bhg1kryC9jdd45CIsOODPgD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c3ac2f-10a6-4a7a-afd2-08dde41dfce7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:26:00.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPN9Zm5w2Bo6pDW26Llfr7CNXuujeOEemULjU4t7C27nuPG+rwDHXT/KfcYsC04h9E6rs6pcNwG5mCqNVQ08ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

On 8/24/2025 3:09 PM, Kuan-Wei Chiu wrote:
> The prerequisites section listed non-existent packages
> "phython-gnuplot" and "phython3-gnuplot", which may mislead users and
> cause installation failures.
> 
> Update the names to the correct distribution package names
> "python-gnuplot" and "python3-gnuplot", helping users avoid confusion
> and saving time for those following the instructions.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> index feb9f9421c7b..875b086550d1 100755
> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -11,7 +11,7 @@ Prerequisites:
>       gnuplot 5.0 or higher
>       gnuplot-py 1.8 or higher
>       (Most of the distributions have these required packages. They may be called
> -     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
> +     gnuplot-py, python-gnuplot or python3-gnuplot, gnuplot-nox, ... )
>   
>       Kernel config for Linux trace is enabled
>   


