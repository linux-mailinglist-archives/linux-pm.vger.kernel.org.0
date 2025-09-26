Return-Path: <linux-pm+bounces-35457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF20BA35E2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D4D1C05341
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F82F60A2;
	Fri, 26 Sep 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukB8iKnL"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40C2F5A34;
	Fri, 26 Sep 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882805; cv=fail; b=fumUbCCDdk123V4wliCucIkAo0rOLTD6yb23U0HDBZJJ93SfvCAp5bYH+h9xzxQnkL8dJOMRuW/c/ePE4aE8zBTAxq6DSwIVYXQOxn0ReP4jLJXzN5ioPzCXBIV08vGfP/+lpY8SGMUaqRsus305KaYG596k6acdFOkqjYNSpcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882805; c=relaxed/simple;
	bh=PlZmYSRtFTagqtNTANy1ICNWYhn1D3pFX+tqMEFiWTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqM+taBIr2vS/CC63YMnh5Tg4IgKZQmtHIZHcph61PSV3Vn2m5QTMlMbB/YAOzbJjjWl3juYdjdfyVuZegjr02/kN9bdMTMiEOmOxYBRfFLHi1WYPZ4utKFGZXIFJEJqfN573osvGGu01fZIWi4mLG7lw0qVjQehv2CKMzmHzHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukB8iKnL; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xersG7kSGdvozG/mHqVGe3FjBLqvI4t4WEJNGTaqtdEzr+zXy0xhGZrIlB8blvhC7AIHd6RY26UEmM2AVq6ZTPqv3c799+tQcDQf5xym/TZOUb+UKVrDHA2bKZ132BLKeTmOPMZp188T+32CbynSG5v/2sJ8oxUblZWI85YenfVQJ9SA8wrmP+33VA++vBkgHtfJ3MJpei/bg2b99UPERopa9xRjj1COOlBxMEuiCjLqFEw4kkEMA4tle58wlpuvPSZxXzQPnihhW+a5FFodwAAeVy/aeT6M7PZS1oC07KShZmOAFy9q/BnPkfwR1l9CGDzRnujNAswlXGvjnomOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zt6Gpt7GV1B717yYLhqfi9JyAUJ+U2wYzBeBNWWWls=;
 b=MtYp6Lbi3w1PIVf0H3pPDNjOjPNTbkMJOTFV84POAVLrqZNvcS5zPx/sLUuWce97U1HEbu4GnyXTKaOYzvyUhTbe5pQmicPfPpL8TbhKp97xqHryGTwuURH0VwZTKkcT85vnn5BPd5Pl+rXjsSNwbLIbkOmLQ+esOPO+e3HELMHviyU9IOCL1TxsgCSLxdsx6fYiD8d2stWeR9TLifCZnw3yBZovu/oiSN2wTZbaxnsu1MvYLeLhHT3BQjsEcrvbTiYvEcTtb4vizHq6dvaX/K+yydirQqVRaIaOOb7Yrm7W1L/Jo2WW3OzrhgXkr5/1xG3j18ML5gDeurhLETn/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Zt6Gpt7GV1B717yYLhqfi9JyAUJ+U2wYzBeBNWWWls=;
 b=ukB8iKnLznemCCjCyl7kJLtHcBSvr4v7U3/hXKrP6xLFwNTbUSn7Xm2DWUkkBMERurKLIs2WkOrYORNNXKraD2f2UnDsyuWjb1CoSoxbIGRl+igzRUrG1LmCAucb+mjjKE0JIssqr0vltTjZso5MdSD/A2DMnpBvxTD0dN/ZXxtaeYVUKxcXNNPaDiy+2RFvxOBJwzdVpPVl45y45LCP/gtBfPHegIu9fkXqlxeyzUqtNUo00hQcRstcgP3w8hpSti6xzBrJgn3CpUiX6C7mrvIoDeol8XOwrvL88IkOj2iHxgcwU+3cz70zm5odx1KpIf0Zq73bzmCKFGuvK04uGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 10:33:19 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 10:33:19 +0000
Message-ID: <25692922-7610-49bc-b33d-c799a13995cb@nvidia.com>
Date: Fri, 26 Sep 2025 11:33:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devreq: move governor.h to a public header location
To: Jie Zhan <zhanjie9@hisilicon.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Robie Basak <robibasa@qti.qualcomm.com>
References: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
 <ae509446-4703-43af-a48d-9c72da0b3813@hisilicon.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <ae509446-4703-43af-a48d-9c72da0b3813@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::18) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fb8862-b3f0-4de5-81af-08ddfce81bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTR3WXFqRjc3Q2hQT284MFhYZjVhR2QyaVlkT0o2VTlET1YzMGVFSkU0SlQ5?=
 =?utf-8?B?c2Q2NlYxNmdseGVUeHVGWmEwb0NkQ2hreHNaVjVzaVNodjg0MHQ3NkxFblVi?=
 =?utf-8?B?d2dNem5VbzR4VE9IS1FMSkE2Yndqb3hiNHJ3VVhkNDlVdXZXS2NoOExMeWxr?=
 =?utf-8?B?UXl6VDZ1QVR1ajdSaHJaQnJ5KzhYV1YxeUNpTFpFTHlPdGY5cWpENk0rMXcz?=
 =?utf-8?B?UzRoYkpFTlNvSDZCTjYzRUtibTlxQWxKSFdHVXBnMjYycVNTRGxHeHhta2Jn?=
 =?utf-8?B?bmpKa2RtUFdkRnBKRjRJODVZanhPQjlEVVF6dW1IRE85YVRJdy9QYmQwMkVh?=
 =?utf-8?B?dFhYWFpzUngvV0daeC9vN3ZtWkJlNFVBU1d5N3hrK0tJbDZNbTBBZ2JUT1lB?=
 =?utf-8?B?RWUxcVA4cHVIMGplYVNwVjQvUHg1amJPS0N6VWZLeVZxZ1QxRS9GQlJ1bCt2?=
 =?utf-8?B?LzUwQ0o4bmhxOUlYY1oxZklwWTFSbDNVZkZic0FlYW9vbDEzV21wbWowdDBY?=
 =?utf-8?B?OFAzZWY1RFA5Wm9Pb0s2V3NJU0N6N05sMHJIUDNYV2ZHZ01wQ2dKaEtmSEpS?=
 =?utf-8?B?WmxzZjB0L0o1YnZDZnhJSzFMNzJmNThTNVFZbWVxRGlBOFBDMG1RajdETnZI?=
 =?utf-8?B?T3hVVzZTeXhaYVBabVhESHFXaTIyMDdOcG5aeHJsWXQ1cFFXUTNqUDVIMTN5?=
 =?utf-8?B?bi80ZWV6WE5lRGMzUFBTYy82bWV1RUVKK25YdVkzV2VJUHo5RnpxQ0QwbWgr?=
 =?utf-8?B?eXF0RmVrYzV5eHI1NElmVk1NVlhHcVZvMURQWHNpb3hLS1c5TnV4a3p0bStN?=
 =?utf-8?B?U2dwaE8rdUF2azFTRkx6S1I2YmNObHpEUjFBb2pHYUlVV3dFV2pWblA1SWJ6?=
 =?utf-8?B?V205TUpqZXIyelJEUXZoU0Z2OFE3cC9ncExkOFloOS94dEd3akRPVVd2b2VH?=
 =?utf-8?B?em85eG9TVjN1b3hRb1VjZUk0MnJDbEJNZG51SVFobXJjMU1uQXd1UWpOdkt4?=
 =?utf-8?B?Zzkwenh1SW53ZlQ0TGZXVzlJR1BDWVJWYmV5blp3ZkxHejQ0Q2pLdFhUWGpu?=
 =?utf-8?B?dWNYdFNkR2VnUFE0Skp0YVFqMUh5N0t2M3o0RytpUWVHSkVvNnpOZ1VKNmp1?=
 =?utf-8?B?RWY5U210S3hhcFFsUHBjdFJBVUpBV090NDRNOFRURytYTTJtSzg4dkIzYzdT?=
 =?utf-8?B?b0V6Q2VTL1JtRkFVVGR1VWtabE53OFBZUVRsenZ4YVdnYVcxQmhnL2xrY0pV?=
 =?utf-8?B?RXNzaUdmOEVqSVFiOCt2VTY3UklMY2FlQXF3cHp6M3E5R2xObHpmb294ZXBZ?=
 =?utf-8?B?bFRRUms5Wkp3OURZTFpISVpkaHprd2U2R2xDNnVEVzg4bnpqR3JPZENnZ0tq?=
 =?utf-8?B?amVPQ1RvbS91c0NVcWcyNU5WRE8zaXd3R0lJbXFQUU4rNWczd3ZXSk51Y3M0?=
 =?utf-8?B?dnFxZzFEMEZjSjJJaEJFaFJBSUNucllOdHMrNWFtWGc1d05VaTZVZWwraHIw?=
 =?utf-8?B?dUhiNllObnFrMm9qOTA0V0lLWkVtZkxuUFhTb0ZXTHlxM0JJRkJJRDM1eDE3?=
 =?utf-8?B?a0VFNDI2dm1GdW1wQUZGYkZVeTVzOW9IeG9KV2hRWm9za1dRZEFGa2NpWjRJ?=
 =?utf-8?B?ZTZ1YlM1TWdYb29mSE8zNU1QMXFjbGxMOTVBMjBvK3AzOENlWi9RaS9SMFFi?=
 =?utf-8?B?QzIyNm53OWduYlU0aElvS0RYZFFtdEx4RFRVS21XMjc4QmU0WktyQ2FIU3ph?=
 =?utf-8?B?OTY2cnBLaVlEcWlUL2lEYzlpWWZyWXlzRDIxSTZ6Z1JWYWkzV1RPVGlmNVRG?=
 =?utf-8?B?enVEbVpqcmtlaFdnSS91b25YNkZmZGNiY012eXhtWk9uSG5KUWtPZHJHMFdp?=
 =?utf-8?B?Q25WMEpzcTBkSDgrckJ2LzFZcXcyemJsNXV3MVBXK21yaDBDN0NpelJOOTR1?=
 =?utf-8?Q?mO/nzXYOiCXmZV64uIkCD+Hcs7Z0fwbg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1rNnFtNGJoQ2sxNzdjSXFqMExrcnBPdXk5dHdIVzFvWXY1NEY3dXZiZ0Fn?=
 =?utf-8?B?T1FGczFKYzYvZTdnN1JzNndDaGV1MGdLZjJxQVVsWkI3T3I1Z1pBQUtudnZm?=
 =?utf-8?B?SExOejFMcGxVVURyM25UeUw2cnMrUmZnR0tsKzhIYmtrbS9mUklaWUhqUjJK?=
 =?utf-8?B?S1NPcGlSbERzQUhkUlFLVUZsOElqMGhuMjVHRkI3cHpoQ2NNei9qcFgxTGFI?=
 =?utf-8?B?MWI0U0lrK1N3RC9hdXNHdHkxUFJLWGxlUWE1K3hCUE5yZVpXcHF4UU5nZzFr?=
 =?utf-8?B?VkxWaS9rTGtkSDFITWxYUzBiRWhlTElwL08waGhSVHIxQjQzampaSlNISFhH?=
 =?utf-8?B?ZTZLaGRoWVIwYTg3YnJDYjNRN2R3TG9wRjZrRWlsYnFxcG5yTzV3aVQ2UjlD?=
 =?utf-8?B?bXlPSWgrUW14aGFDWXZhOWdJbncwU1B0c3owc0ZlME1uQUpzcURsajRYYyta?=
 =?utf-8?B?d3JLYWRmZWRVNEg4MFc5R2VhYklxSlBzOVFDUURhVW1ySTMvREhtZy9KVzZO?=
 =?utf-8?B?SHBrRFd6enV5eWlMRXMyT1lackp5SE5oMVVhekg1TXJMWkROcGVMMFJJMkFr?=
 =?utf-8?B?VDNBcm5UUy8vTFFsN1QvMExYUXc3dklkbDBISms2SUNXYVZUa2srTUxpS3lV?=
 =?utf-8?B?OGZkVUgxSWVJWlA0NVZ2NVdGTjRNNXI0VXdiRFdsQXhFZDNJbVNTU2xmVW1u?=
 =?utf-8?B?QW5sYi9aajBycW9jNmo5NzI5SEo5TWNmWHV0N3kwc0NXWGhPaC9vQ0Q3aW9D?=
 =?utf-8?B?NlpRQjhmVVpFMThDWjFGSzNiTDFwbXZQek9tQWpTVWZzQks0YkpreVdoZWUr?=
 =?utf-8?B?dnZHT2plZ0t6cldDU3lEUEI5RzNjWGNEQWlPdHdRTWZ5T1lpQ1UvZUkxVE90?=
 =?utf-8?B?NEw0WVBRMG5jTlA0QStLUjVGNW9SdHM3eWo3S3c3dngraXRxNVpOekcxSkhv?=
 =?utf-8?B?dEJxeVVGb3lJaS9XVFA0cWdDczVzblBxRVBpdzc4SmpTUUUrS29NOWZGaGZ2?=
 =?utf-8?B?WVBYT3pqbWtneHRyTnVDM2czZDE0ZEZoWDJMay8wdkloMnprWVpMZzR4Ulpo?=
 =?utf-8?B?bEhaa1lrYXBDNkRvMXhOR1Q4aDRHZ1l2UUtaSGRZY2paWFlsRURRc24wMWtx?=
 =?utf-8?B?d1VmbmNhZ3BoMmJ5UzlJbm1JWkRXV0EzT0tGUmlyQnU5R2sxSmJsMER2Y0Qr?=
 =?utf-8?B?UEhYYzc0a09kTmJ5WkVmRXMvL0hncURPK1JsajQ0bUo5QkhYV3VrTGlVVnkx?=
 =?utf-8?B?cHB2QWUzOFNFalQyWVFGNG1vUlZFNnBBZ3NtaWVQMGthRGQydmhIVDZYRWh6?=
 =?utf-8?B?RUg0ODhUOWxkNnlmUnpBcGVVQUlzWWptZEZRVkZHZDh2eXdZTHo5T3dQd3hM?=
 =?utf-8?B?cDd3ZCsrZzI4SFFmM2RzK1dZbnFoUGUwVHJpdngrcTRZSDR1dlRiYm1NMkRL?=
 =?utf-8?B?eXF0UU5aZE11U01NaUc2MDI4QXdhdkRTYlNnTjBlWklMUnpmL1JYL1V1U3Vz?=
 =?utf-8?B?aVE4UVRkSFFrZE4wME55UU9XUmhZaHBTU3NlWDlRbExCT2p4Y21qWHQxZnJh?=
 =?utf-8?B?QkVYc2RLWGNwN25KeWxhOVozdXRkUW8rR3MrZVcwbUMyekpVTUN3WWZLbzM1?=
 =?utf-8?B?bWpoSTcwNmZacWhPNmhpY0k4cjdTUXFTZXNGdU9FUWx6YzZ0VDNTWlIyeU5o?=
 =?utf-8?B?YlFoMEY2OVBpZ3MrVEZyZ3I4Qm9tRkRCY2l0anZIYmdVaGhNRlAyby9BWmxK?=
 =?utf-8?B?UDRsVTVRRm1oSy9seFV1THM1cG90TVM3SnlTYkJmdWNPUmdaM1dpVDVoRWFv?=
 =?utf-8?B?aE1GNFIvOUhQcmFpWkdlUnkrbjdrZkFxQmVaTktPOHdnYmpHOUtBTnNacWtN?=
 =?utf-8?B?cjZLYTh5dGt2K25SM2I0WGZMb1hhV3dCTmFVKy81STBzK011U1BvbEk5eWRG?=
 =?utf-8?B?S1dMVkFqcVk1OWlqRHZYTmQzZFFVdDMxNmticEJUbUQ0Rk5tNXBBNWJjUlp4?=
 =?utf-8?B?b2NMcW55V0F2eUVRU3pxU1grR2dleXdVeUtkcVNQei9CT0QwZERuR0R4NW1U?=
 =?utf-8?B?NzZieGJaQXd2cXBMOVVZNWc1NGZ0TnRIOUx1Vm9KUGtXV3A3eENwUUhzd0tq?=
 =?utf-8?B?cHI0ZlFqV0R1dDFucVIxWUdXcXkwVnUrYUlIeW1aaTE0WFRFUzkzME80VGdF?=
 =?utf-8?Q?JW9EuFsYAV0Eil5mEx+ZLbpw6W0tfv1bAcEmgkASzHeI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb8862-b3f0-4de5-81af-08ddfce81bd6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:33:18.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bjj1038tbsxkTSWDJ5pAxakJSiPFjFLmeS5sQFv7627+rHwmNsy8prCdsFb6Mujpvixyki3iSEPM/TnZWgfr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679


On 26/09/2025 04:16, Jie Zhan wrote:
> 
> Hi Dmitry,
> 
> On 9/3/2025 9:43 PM, Dmitry Baryshkov wrote:
>> Some device drivers (and out-of-tree modules) might want to define
>> device-specific device governors. Rather than restricting all of them to
>> be a part of drivers/devfreq/ (which is not possible for out-of-tree
>> drivers anyway) move governor.h to include/linux/devfreq-governor.h and
>> update all drivers to use it.
> 
> For out-of-tree module compilation, can it add drivers/devfreq/ to the
> include path?
> I suppose this is unnecessary.

The kernel header/source package created for most linux distros will not 
included this header because it is internal and so in that case it is 
necessary.

Jon

-- 
nvpublic


