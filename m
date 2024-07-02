Return-Path: <linux-pm+bounces-10318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D996C9237AD
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A70FB21811
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251A14BF97;
	Tue,  2 Jul 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QcKtfGWz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6B16419;
	Tue,  2 Jul 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908705; cv=fail; b=LOQq3+JO3JccRr63EpJSzA7bpRdUjQD1RfoRBnOQ+ypo83EKNrRARBUE/uBi+7VrOH++rHH4RheWQIEMdvNzzSg2TZdkuixNVlq+AQrZTfq38nXUqtAdOuN1MpNXB/gHIyIXLU5Pm6JmE0ZUmRfkrCpv2HaGA/7uD3DBsu3Jj+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908705; c=relaxed/simple;
	bh=8O/ra42mM6v0PdpMXRQF3zvwgTMvNwwZKFtmXDmAC+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKXFC/7+VcVd9dIjE2v5n9ip07Ugs9OmkvD1cL9gAK+rORGlMOkWUXrrBJSCdXCZjbMLzFLFErmIikHIrxyD/MiKfu4xUp5muD8bkdCN0ycQcHWnfANvW6EpVnEhjsWKWdi1r7zFcljlyHk4py3f86iN3QHj76U48XZEtxo34Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QcKtfGWz; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTqMWnuCi690fqhapNJZxfmsJm1s9XYqzHb4aAXKiqrSW7dOCifixNyTFp1/wtYBDIx0I1Sh1Jht50iR+4XIOoT1Ym2Hn/ZL2ZCjpZcrEotUN3uwR2KbTHkbSGBBXUg2b+8J1UUA/7PicN0RwzgMj00AR84o84RqC0jba10PtdayHpNMKfp/Ggg8qHDXU9EZv0SRHyDRcIPjMi/rcXpPgsJfCKPDEk7Kh9vEILZ34U3uEHvaRRZIGgw41raGWwtAK/vodElAJcEUwAeQ0qG6Hi+TWv87J/BrTEPwL+rOvdcHnjVoY4GOisvLuWrxz5Ali8EAD4F3fRcuIhT+fyEDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i40Xl0R781g0SJ8rxd/8OHqtdfimuZ4orhdEc9Ui9Jk=;
 b=DxECpKr2G+MKvUdXqD4JIhWbZB/79PACQOPfu1TzmoXNsqRz551sYJQyn/yVbVD4imvEWVOvwSogRWUtmOCCOLuwXnYWXtUnZEv2s75B7uMXtVVbvbzLIXqurtJ7GWmxOi+ExxpeQ6sVxVJw2BshUyFACYB95vOEwoy5ujUICRNX/rQyznvlpS6byBP3WqKfKeG4x6Mi78Tnl9fV8eTlJR4N/CWDwv9RyoSqan2WXsurYo9o4umMg4sJ/c8YGBUwPqf8pmAe5kdSrZMiw3ndCt2tCMCtsSSB+qbtrF+GprwFE+zHxyVNN5/chI2L5rBu0B+wC/dVa1aeIdUVaM8xCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i40Xl0R781g0SJ8rxd/8OHqtdfimuZ4orhdEc9Ui9Jk=;
 b=QcKtfGWza2b7Th5EGc5UZCU8TWTbxz83/lQjDZxPtZ5/L2b3AI6wrlLI5cPgQ6ITuYbNhXnF9PdSM9puyZqPoYmgdd3YNQG/tvxwuY/JQ02hQA3kfsFJL3uiga22lDbt/qthD1cFHfMGjlKIOMbr21vvPZaX0VHYypn4HCGabuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 08:24:59 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 08:24:59 +0000
Message-ID: <cf835a26-1a76-4cf4-840a-c0bc6cb03452@amd.com>
Date: Tue, 2 Jul 2024 13:54:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] AMD Pstate driver fixes
To: rafael@kernel.org, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, skhan@linuxfoundation.org,
 li.meng@amd.com, ray.huang@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 872229a8-8d38-4c2d-78c5-08dc9a7075fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlpZOEN1cEVuWUJPbnZDd01QWjkzYVVybkcwNEd3NndreW5yaEpWRnk0TmJT?=
 =?utf-8?B?UDUxVGdGQitBQ1RkVkliOVd1cGF4NURua2Vsc01GU3pxcnJiMW5PeDU0OFJ1?=
 =?utf-8?B?M04wMTJXVk5XT0xyUXg2MTZqRk1zTnh5NE1TbnpBaGJxTHcweXdKa0pYQXJB?=
 =?utf-8?B?VjZJRTMyZytJTEtRejRmTUtxTkFWbXloSFI5aTFBSzljK2FFc1BOYkgwekVi?=
 =?utf-8?B?NWl2QzBBREsxUlhUNXZaeWZnMGswVytGWThYMFg0eE5peHZhVFBVQzNxbVdi?=
 =?utf-8?B?bWE5c29qcHVXbEZpeHRyODVoUHAzM2N4cU84aW1kbFhlaVdYNGRzS0VFcjRF?=
 =?utf-8?B?eWZJNk03V2Y3R1ViNnp6NGgxVmlFeHNzQ1FHRlJFelptQ1FHUXpkc3lhOHFK?=
 =?utf-8?B?Uk9sdm9aTmI3Wks4SThBR09DNXUzdUZ2SUZVYzZFNE9IUWR4WEVwdDNZcG1a?=
 =?utf-8?B?cysrSzZ0ejA1OFRvOFNxcXBYdHpLdHVOanNjTCtsVUNUcTNLYVZtTTZYN1R3?=
 =?utf-8?B?ZnpQRUdKdnFRVTlHQ1hjdUdpMHdKOTZ2ZHdJcVVoQkNmcTRhSVZyajBQSDgr?=
 =?utf-8?B?SmVqVkxBMkc0RGtmdTU5YzAvQXFMTUhhUUcyMnQrQVZlME9seWd1RnZQV3p4?=
 =?utf-8?B?VysyL3dHUFl6TFU1VUVGYW1YNERvZXZlb0g1VGhNelhUa2pITVRjSjJjOEJZ?=
 =?utf-8?B?TE5uVzBVeitEeUJaTFkwMFo2WmhlcU83T3ZXRzc4MTk4NGxILyt3YnptZ3Nj?=
 =?utf-8?B?Sk9NNk1oSkJla2l6Y2ZKczF2UGN5d2RxVGN3dHhlejMyRFBvM0lCeWNxNEd2?=
 =?utf-8?B?by9kR1BJdTkzZlBxN25uMCtqaHRQaFBlVUdHRFpnTUgvbis5cXMyTFFWVURQ?=
 =?utf-8?B?Uk1maWExUXl4K1pkSElSaU04TmdyNUVaalBVQzdvNHJqaE5HRmQ3cmZ6TEtD?=
 =?utf-8?B?Z3lLMllLUHNjdFJIRmhWaXA2ci94OU9hUExGL3JJUmtjWlFNNWMva2hwck9m?=
 =?utf-8?B?UjZvaUtBcTdaeXpoNHJqU1liY1czdVg5MHJPVDh4dnJMSjZUYzBYV1A5ZFBx?=
 =?utf-8?B?ZForaU1OdDFtWm5LYXk2Zmh5dTdtOEdtYXVjTkJBVUtZSW1kOXUyTFJKS1lD?=
 =?utf-8?B?cmZzVXdtcEFtZGxHKzA3ZEVzd3BuM2pZL1FJNUhVSXU5eFRoNzNxU3lVaWcz?=
 =?utf-8?B?SmdJWENkYUtNZ09XeE1NOXlEZ3BOTTBRdDJpZi9tN3Q2Zi83eERPRHJCRHMy?=
 =?utf-8?B?eEQ4WVRtckVOTEEzdG11THJqYmV4dFlqK1FXWW5lR29VYXU4Z0dhYno2c011?=
 =?utf-8?B?MGgyOGFCeEJmVGp2R1c1cFBJSEF2QVFrcVp6L2ZOQkVBNWdGaU5XcVlLWis5?=
 =?utf-8?B?TjJaQWtJdU03RklIWW1EUXdlUUxIY0dmUUZvY09uY1c5OFhQQUJtUlFVV0Uv?=
 =?utf-8?B?UDZobEI2MTRvZXgwMFNTdEpjRWxoMldTbERxdG5Nd1VyUVhhN3l2L09BSG91?=
 =?utf-8?B?YXgzUGhCaUhnTVhua3ZucndQWE1LdmNVb3RFWE5SaDd3Y0ZPdW9Wb3Q0ZW1O?=
 =?utf-8?B?Y0tKcWpxdVBRQlV3VDE5TjRITkx2elRYck9rd1ZSQ2kzQm9lOUp5UldCZzBw?=
 =?utf-8?B?N0RteFowYTFPWlpZckd3bGV0K0ZERE04ZWFxUVJHRDdJRjducklNK3huU2Fs?=
 =?utf-8?B?ZzkrM2h0TjZoenpLRTU1ZWF4Zm1nbE94L2s3Y1F3ejFicnl0ck1GUHR6TzND?=
 =?utf-8?B?RHUwRUFRUjlLSmpYL2J6aUVjNmRCaGxKMk1SSUdUenNZaHRzdWs3dU8wcjZJ?=
 =?utf-8?B?ZnhnTG5jSFg4QzVkUjlyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnIrZnhqaElBWkxibTZEVS81S0g2TGR4YW1Odnk0bGwyQ0p4eDB6NlBoNENR?=
 =?utf-8?B?T1JEdkdvbzEyWVRCQkF2UmFOcEFMU0lXVmVKRXpKN05WSi9HS1NmTU5Nd3VD?=
 =?utf-8?B?TXdVSmxCK282OE5BWkwxYlJheHNHV2VGaU10MnYvT1lEZUpQZDdIT0RoRlYv?=
 =?utf-8?B?dkJ4bEVKa2YvRmNlS1JJcmJ0ZnloYlVSRVZ4VE53ckF6aldJVTh5VHNDcnZI?=
 =?utf-8?B?c09WTE5rcXJYZnY4WXNaWUprd1BZK3B0dkVhclJOM3B0eEN1WnpYdVNSME1m?=
 =?utf-8?B?YW9lSEF2bEtUQndENFU3OTUxbi9WVktEU0Z0QUtpMXgzTkxxOHk1eEY0Z1U1?=
 =?utf-8?B?eDFoN0Q0TkcrUUZPVjMxSDdmMSt2TlBsOWpGQnNyVWRBd1lleVJQTUVxSHNh?=
 =?utf-8?B?NDkvUGNjVHdGSmFTTCtZMVZCYXBjN1VsbHM1UWFMcGhpSHdoaWRMNDE4QTJx?=
 =?utf-8?B?cWpleDJYaTdPQnNzUXVQWEc4bGxZS2FzcWxrRjNEK3pqektVRVh6WWpVVllE?=
 =?utf-8?B?MHVJRHEvY2gzVGREaW1DVTExM0tvcWI1bk9UcTB0cEVzeVc0VWduR1BVVzhY?=
 =?utf-8?B?OEpwUVFuL0xPT042UGg3RzhCbkJnSUZyd2tUSkJLc0t3bVExN2R2RGpDbXMw?=
 =?utf-8?B?NWFxZFlydGQvQklxdVhHUTNHNVNOem5ZenZtYm9HbzEzdmx0TmVKaVJ4NFRN?=
 =?utf-8?B?WHRNbTdvbmtTQ2pWQ1Brem5jL2JsNlMwd0FGNXJremJsdkU3WjJyR0ZaQXRX?=
 =?utf-8?B?ZExWNXFsdFdJblQ0d3crRU9qaGRuZnVKcDdVOHdQb05XcjhuQWszWDJ2K2da?=
 =?utf-8?B?aDhCOVpNMyt6WGR6TGJpbFMzWDBsYUZnMXZ1Z2hpenFTblZYbnNHQ1NGU0Iy?=
 =?utf-8?B?OGg4NFcvV05hc2JoVzZLS0g4UkhmVWc1QyswV2FJUk5MNWUwOXRtZ2V2cHJE?=
 =?utf-8?B?QVE3dVdPbDVYcXR2c3FUYURvOHo2WWxkRE13LzQyQko4a3dVbmFscVE1Yjhy?=
 =?utf-8?B?aVNYM2ZuRmExZGxOd282aDQxak1ibFN3anhRQkVnbDVjUkh5dlNIY1lKeGJu?=
 =?utf-8?B?cm12M2tMT0JtamVmOGN5dnhYSGYyNExmbUJ4S2V5VDROU2JKZ1VWa2pZRFF0?=
 =?utf-8?B?N0tjQlNMRzRYcE9kNGRkdmJBODVMQTAwd09vZHpabFBhNHl2dXRrRXdRMk91?=
 =?utf-8?B?cjNTb3NiSkE3U0ViRHpBeXdDRzlzeVl1dnlPbE5lbzVIeGNGdTc0WmxIaEtz?=
 =?utf-8?B?NGRONnlaYU5UQzdNNk4vZDA3dTR6KzVadlhyUVNweFphUExsMy9XWFpYYTV4?=
 =?utf-8?B?QmtPYTZXd1JqemVYN1ozUGtOZDdMZEF1VGkyRjRTZ1Q1WXdEOGxpM0JRNFhV?=
 =?utf-8?B?RXllYkhOR3ROVFRPYTA3d05raHo2NVVSUUlMUzhXVGFCcnFiNElQNGJjdm1R?=
 =?utf-8?B?Qy9TRDZFRXh5dTJza0FzSjMyZ1drU1o3ZFM3R2FlTjFaU2t0MnRvSjRrN3ho?=
 =?utf-8?B?OVB6b1BReW1ad2Z2TEJXMXIycXpUdnpHa2ZzRVRrd2ZxSE5RVUxicHRSTjhP?=
 =?utf-8?B?S2NvRGFROGQrdldkb3ppckNaWDNFR2RaZlh0Nlpla0E3UDZqZW43M3Zjc0JH?=
 =?utf-8?B?N3J2NnMrK3hxVmszbU1qdTFhbk5Ja1ZZRUFFbDRZdVNJWHJNT24ySHhsQnEz?=
 =?utf-8?B?Wk83eWwra1d4OUJjcTJURGhhMVNWOGVoVXAwdlVhTzJuNlRvMXcvcTl5RG1r?=
 =?utf-8?B?WjF3eTI1UkUzSEdCTEJ0TlNjUWhzckt6cE53bFdINXA3V3pxU0VzV3I5ZXNR?=
 =?utf-8?B?bmVkS1pqV1h6U3JMdFpSdVhET1BpZWpYSXhwNWxLbFhFZ3RLYnZaVG4vRUcx?=
 =?utf-8?B?UXphSUNKRnY3ZFRmMW1uODQxS0tiQkkzWTdzQ3pVU3U2cmh4ajJweEx3eXk2?=
 =?utf-8?B?RzVpTWRhSmNOS2pDbGtiOGExZHoxb05TNW5DUjN6ZXkxMGo5T1ZFUjE3alQ1?=
 =?utf-8?B?ZTdEQ0pWczYvdWVUbzFuOU9rVGJBaWxrMDN6SDlUbjdsL25lUFZXZWdnUExJ?=
 =?utf-8?B?OTZvYzNOb0phMkxPNzRxN0NSdEpTU1JHTDZKRUlJV290UmFzQ3c0NExyQWJT?=
 =?utf-8?Q?IhE1cF3j4xnDV/+8uQaEEmG6e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872229a8-8d38-4c2d-78c5-08dc9a7075fc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:24:58.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A0vXHGZAdRPsQPtRSRXG+TQXQIwew0LRlQor/GqUAJ37hvbYIFg1fU7OrHn+XdsPAS2qcMw+tmnmsJBdi7Svg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

Forgot to mention the v2 changes,

v2 changes:
* Add reported-by tags (Gautham)
* Modify patch 2 to use amd_pstate_update_perf (Mario) 
* Modify commit name for patch 1 (Gautham)
* Modify commit message for patch 2, from scaling_min/max_freq to 
  just scaling_max_freq, as scaling_min_freq still needs some debugging
  to work correctly with active mode.

Regards,
Dhananjay

On 7/2/2024 1:44 PM, Dhananjay Ugwekar wrote:
> 1. Handle the nominal freq units inconsistency in amd-pstate-ut, which was
> leading to the below error on inserting the amd-pstate-ut module.
> 
> [ 4982.498864] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
> [ 4982.498873] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
> [ 4982.509151] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
> [ 4982.509155] amd_pstate_ut: amd_pstate_ut_check_freq cpu0 max=3709000  >= nominal=2401 > lowest_nonlinear=1903000 > min=400000 > 0, the formula is incorrect!
> [ 4982.509157] amd_pstate_ut: 4    amd_pstate_ut_check_freq      fail!
> 
> 2. Setting the scaling_max_freq on shared memory CPPC systems was
> broken in amd-pstate-epp driver(amd_pstate=active mode). The
> scaling_max_freq value was not being propagated to the shared memory area, 
> so the frequency capping was not being honored.
> 
> Tested on a AMD Zen3 Milan machine(shared memory CPPC): 
> 
> stress-ng is running on the system to keep the CPU utilization at 100%
> to test the scaling_max_freq capping.
> 
> Before the patch:
> We can see below, setting the scaling_max_freq is not taking effect.
>  
> linux/tools/power/x86/turbostat# ./turbostat --Summary
> turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
> [Snip]
> cpu0: cpufreq driver: amd-pstate-epp
> cpu0: cpufreq governor: performance
> [Snip]
> Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
> 2620    100.00  2620    2026    0.80    164935  0       0       0       0.00    0.00    0.00    176.07  249.18
> 2580    100.00  2580    1995    0.80    162208  0       0       0       0.00    0.00    0.00    173.27  245.37
> 2584    100.00  2584    1998    0.79    162379  0       0       0       0.00    0.00    0.00    173.42  245.68
> 2577    100.00  2577    1996    0.79    162146  0       0       0       0.00    0.00    0.00    173.15  245.41
> 2578    100.00  2578    1996    0.80    162025  0       0       0       0.00    0.00    0.00    173.07  245.46
> 2575    100.00  2575    1996    0.80    162115  0       0       0       0.00    0.00    0.00    172.96  245.41
> 2576    100.00  2576    1996    0.79    161998  0       0       0       0.00    0.00    0.00    172.87  245.32
> linux/tools/power/x86/turbostat# echo 2000000 | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> 2000000
> linux/tools/power/x86/turbostat# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq | uniq
> 2000000
> linux/tools/power/x86/turbostat# ./turbostat --Summary
> turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
> [Snip]
> cpu0: cpufreq driver: amd-pstate-epp
> cpu0: cpufreq governor: performance
> [Snip]
> Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
> 2620    100.00  2620    2038    0.79    166103  0       0       2       0.00    0.00    0.00    175.44  250.96
> 2566    100.00  2566    1996    0.79    162038  0       0       0       0.00    0.00    0.00    171.79  245.23
> 2566    100.00  2566    1996    0.79    162289  0       0       0       0.00    0.00    0.00    171.76  245.59
> 2571    100.00  2571    1996    0.80    162034  0       0       0       0.00    0.00    0.00    171.69  245.44
> 2566    100.00  2566    1996    0.79    162179  0       0       0       0.00    0.00    0.00    171.62  245.41
> 2567    100.00  2567    1996    0.79    162028  0       0       0       0.00    0.00    0.00    171.57  245.46
> 2567    100.00  2567    1996    0.80    162037  0       0       0       0.00    0.00    0.00    171.53  245.41
> 
> After applying the patch:
> On setting scaling_max_freq at 2GHz, the CPU frequency gets capped at 2GHz.
> 
> linux/tools/power/x86/turbostat# ./turbostat --Summary
> turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
> [Snip]
> cpu0: cpufreq driver: amd-pstate-epp
> cpu0: cpufreq governor: performance
> [Snip]
> Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
> 2551    100.00  2551    1956    0.80    165998  0       0       0       0.00    0.00    0.00    171.34  231.22
> 2713    100.00  2713    2078    0.79    175801  0       0       0       0.00    0.00    0.00    181.92  266.13
> 2594    100.00  2594    1991    0.79    162183  0       0       1       0.00    0.00    0.00    173.99  244.50
> 2606    100.00  2606    2003    0.79    162632  0       0       0       0.00    0.00    0.00    174.81  246.51
> 2599    100.00  2599    1996    0.79    162168  0       0       0       0.00    0.00    0.00    174.05  245.46
> linux/tools/power/x86/turbostat# echo 2000000 | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> 2000000
> linux/tools/power/x86/turbostat# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq | uniq
> 2000000
> linux/tools/power/x86/turbostat# ./turbostat --Summary
> turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
> [Snip]
> cpu0: cpufreq driver: amd-pstate-epp
> cpu0: cpufreq governor: performance
> [Snip]
> Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
> 2010    100.00  2010    2030    0.80    165565  0       0       0       0.00    0.00    0.00    101.22  173.52
> 1975    100.00  1975    1995    0.80    162042  0       0       0       0.00    0.00    0.00    99.03   169.88
> 1977    100.00  1977    1998    0.80    162559  0       0       0       0.00    0.00    0.00    99.16   170.20
> 1976    100.00  1976    1996    0.80    162243  0       0       0       0.00    0.00    0.00    99.09   170.08
> 1976    100.00  1976    1996    0.80    162490  0       0       0       0.00    0.00    0.00    99.17   170.16
> 1976    100.00  1976    1996    0.80    162056  0       0       0       0.00    0.00    0.00    99.11   170.17
> 
> Dhananjay Ugwekar (2):
>   cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
>   cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory
>     CPPC systems
> 
>  drivers/cpufreq/amd-pstate-ut.c | 12 +++++----
>  drivers/cpufreq/amd-pstate.c    | 43 ++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 25 deletions(-)
> 

