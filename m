Return-Path: <linux-pm+bounces-24448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A8A6D91C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 12:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E4D3AA87B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F825DD16;
	Mon, 24 Mar 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lD+2HuCZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EFBA53;
	Mon, 24 Mar 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815545; cv=fail; b=UGLTUaWINFPiKfma+v7BQlPAEm55N4GmRDcf0CR+UQpCQzg6QzZBSxwxGONNHGVzNxzRenb/oy3i33saB93g5w/MyZHs2aZUKJsNddXAXlhENkh1y+ZuM7lRln/PWK1KbnECn66IZ/iawJkRiSNjs1AWGUfFYODfKuutxMp+vQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815545; c=relaxed/simple;
	bh=iT+zRoPdJl5xC6ZgDUcb+ru2r3c14JWuth95dwu7Pnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlE4lGwqqwmZoUKCnOSLK4BXzfOaSZmwFj9dgiGUCl0A242QqrevT96Q39mCSys82JLWv7W6R53MQNrCFPZ1KF0Pe5NmeV4A0ClLs527crBrnhNwme7VFuBCvnOm6lpR8LoSs+7Su+oiDSYfJymG/Gx9IKV9sg8Qiu2END9WPQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lD+2HuCZ; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiffqeenhb8bnf18BptJlxSHHrZDZuEbjFpZaTPhRZr5FQbdXgisAYmA6fT5RfRdaXIpeMD1ewTRWu/LKWn5TbsMdQYqneg08Z4V4svzzahI/Sb/NxlS1xVwt63XIwb1yjm0SWAPio0czJC3D4pVekyW7ztR3/jnDxe7QtgwduXMBrJ0pkkuf5cfVZuBWBG0S8AiqGWXn9hwgRSS03XkobgQrtCZUr7CwTlXP4kmIPnJ3cqjJJARQMsNgqxlVuwuO/TrfzK7vw0DmSqw1NkGpgPman/mzGx1J5/JStUTHwNA7DpOFY1HkCcoYd7ApoDz6VN4H7rDi/DVq8EHOVoj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxoXErn1X/lySE1KB0g3L9rCWgqHIZKpXf4cKzVmm3c=;
 b=kMd2k6fP7jhsZtDZI3V9Un+u76x1IfgYph/CWdnSTqwo6hyS8w8jrArz/j6z2MuDLxT7i3f9+1N9ife0Kw5edQ8kc3LUm1UNTc9GDfM8M6TWoIaRps/C5EJL5WH3AXKwdWbzNCsjgUebrKlILtiM/EUbV1gAkl6T/bMsnGog3+4vMukei3mW2r4SlYzWHH0k6KPEdVGCd0/6piuMAi5+nENQQpD8AkyrHbP/vLhmbHu1ur82X7cNuFGkdV+Kg1R7ZNVFA7C6HJXXgjNHvLceAYOpwEqLlHkJvaaQav9cIgWEuYDp2U2N2JYOo6rl6yBjf8bVFkGPHgZEtwZ7ZaGcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxoXErn1X/lySE1KB0g3L9rCWgqHIZKpXf4cKzVmm3c=;
 b=lD+2HuCZmVKaWSKgInhq+30cwj8BYuqJhfuFMCD1WD0hzz6EY7t9ilDQ2KJi8RjLw4Eb6ssLPlCqSN6VZKlXK+o2rWYPVe2ylzDvIa0qpLfc4Mb6yFah7bvtZdRT0G+lV+xwPLe9ls1+8fhIh31yKYYd09CQvcjmsDPHrSwK8T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 11:25:41 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 11:25:41 +0000
Message-ID: <819f9f59-6d80-40c9-a7a7-1b8485fa45f2@amd.com>
Date: Mon, 24 Mar 2025 16:55:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-6-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250321022858.1538173-6-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a86059-8d3b-413f-6001-08dd6ac69bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHdWSEw0bHBmWVg3cHczb3BodEIzMkRiYUxCZjBpc29od2d0NlFmZmdjcjAr?=
 =?utf-8?B?RmNncnNjUGhRRmovTmFzd1Q3RE8xMGNDYVhQcFAvVzFmVFE3cEFoVGhGY2lj?=
 =?utf-8?B?WnlLWFc2alQ1SU5JWVVjOHp1bGQvSnZBKzd2R1J4S1VxVnFNVjhPNUozUGVD?=
 =?utf-8?B?TjQ1akpuU2tGVkRRVlFlZmtoYmh3MXY4cUlaYUpUK3hQeGFNc01wWE5MY2Fu?=
 =?utf-8?B?cVRZV2FMMVh4ZVozb3h3STNEdVh1QkQ2ZkJybTFnRk1sdzBKSjBPSWtoR3dO?=
 =?utf-8?B?STFabDNOb2ZpSEJVRzhWOTdnc2RHOGxUTENSNnU3Y2VWVXpSdHYraG1EdUNE?=
 =?utf-8?B?b1pKc0RYYjBFKy9LdDMwdlhTNy9EWm9pTnpaUzFZbzVEM1JyVDc4UU5LR1RU?=
 =?utf-8?B?UnlUa0szVi9lK0pLOFVJNkJEQkFwYVNBNzVpQTBWM2g0TTZwcmlGTytzRC9v?=
 =?utf-8?B?Z3pMb3pGUzdHLzQ3MXM4VG9vaDFDTm4wT2VtMktZNzNYOEVkcjFSMWkrK3Bm?=
 =?utf-8?B?MmhvUlNNV0hzMW8rT1hKSENpVk5nTE5aTmd4RCs4SUUxZHpPSnVmZjUxNG10?=
 =?utf-8?B?R3V1aDM2MkZHeVpGQzBldmtmRzUzWjdBZVhYa2VrbnJiVDF0Zk1sOXBRM3p2?=
 =?utf-8?B?SzJzUjFOY0JHVFZQNFB0dks4QUdhb21sak4ydllCQ0s4QTdxUkcyUlh2b3Iw?=
 =?utf-8?B?a1o4TXZTTkUrVklBQlZ6aXcyb1lGMXZUTlA1N08vU3dTSk16NUFySTk5SVEv?=
 =?utf-8?B?VENIRzVRRHNiK2l4cUgrM0p3eVNwUzlTbldiSTdjcjl1UUpNekUyYmFmWHRF?=
 =?utf-8?B?bEtBOVUva0NUOTdNTmhiR0dVVFppOHNEVkpDMGNMUDI3RCt5NWlOZmdiQWZu?=
 =?utf-8?B?aXJMdVU3TDhYZkR3TEZDZXRCTzZVRFFtZC9UTGVtWFBvNm1QSDc4S0JlbUJv?=
 =?utf-8?B?NGNhelZoUlNsbTNMbldZYTVrRnkzajNjemQ2d0dKcFZUR1FhdWR0cXQ3ams4?=
 =?utf-8?B?R2M0aXpFdFFhZXRpRzZGc1NCS01wUmRkSDZzaUZDeGE2ZWI1MlVCWFFNcUFD?=
 =?utf-8?B?TVJJQTFpcmExdGsxTzB3SjJGK2VMYkdQMVJYb0JmeG9sZDdyOHJ0U3VUNXRW?=
 =?utf-8?B?QkdGREs3RVUvaFRhd1dkS3JsWDVYd1BqMVMwRTFzSXpYQ2F5b3NZa3Q3WEdM?=
 =?utf-8?B?b0dCOWRadzQ2dmxtWTBZTHJIaC9ZVVh0VmZDY0dhR2Y1NnN1bUdEWjVBU3dj?=
 =?utf-8?B?Mmh3WFhNeUk4ZVdLUGdCdWI2VlVxdU5XVFl6RjlvWHJHdnZYektrMHpVRm80?=
 =?utf-8?B?U0E4eGNCUWpaZ3UzV0xxcG04MG1ldHZ0eU9VeHZDYUkvUEZCc1pEa09pN0xq?=
 =?utf-8?B?Vm5HZWR1T3ErSzdTK0lkdHVZWFg3QUJwaEJmVmVTTU44U1FLUFJYbFRrZnQz?=
 =?utf-8?B?TjFGalNya1F4cHpxRjUyV1BsMmhxa3BlYTNna3IvTnVjOVNIUG8zOUdPa1BH?=
 =?utf-8?B?WldzbURteWR2aUdjbVRZYndCdkFSeUIzOXcrZEFQelFscTdjRDNLaWZlMDhG?=
 =?utf-8?B?aXR1OStId0xtUnZKUkdMUkhVbHFCeGxwNFpUOG91OHQyK3g3RHYzRGJWbzk3?=
 =?utf-8?B?d3hsQVNEWHVDeDNWVGIxb1J1aDRTdTJYekRhRFNFNDlzYWhyUmJaVU5aWTd3?=
 =?utf-8?B?SHZoYnR4b2pvdHcyZ1JKV1dEMUpudWVORmtvWVluUGhTQTVOa1pFN0FCbGVC?=
 =?utf-8?B?RnkyMFFzNFJsY2hzTEsxK01PY0U3SXg2QUhnOTdUTG1OeDl4R3haVlBNMXF1?=
 =?utf-8?B?Yk9HNU1GZ21VL3lOaEJwQ0JTb01DK09Ycm0zbkc4K1NrUkRBYWlEZHFDRmEv?=
 =?utf-8?Q?JKCdIiGxKEhhG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVRKclNyVndoQ3NLc1V3RFZFam1xaFVzZTBsVzg1T0p1UkdsMERzWkhWRm5o?=
 =?utf-8?B?dnk3WXZ0eGEraW5aODRpbEhFNExnczR0ZjI1OTVoaWplN3JFbjczeGJKZGZL?=
 =?utf-8?B?dHBhZFlLZFJmeDVyU2dsVWUrL2NEQ3I2dTVGNWd2VU9UQXRkdFpNaGRMN1Vp?=
 =?utf-8?B?ZFBaTGZ1TnNSRzBicUZrTzlMZEtXS0s4TmRPczYxMzZScVZMbGhpYzBOeGh4?=
 =?utf-8?B?NjB1TEp0M054OU5IYklVblNmc00yN0Jjdy9NcUVWWS9GL0Uvc1poQXBxOGxT?=
 =?utf-8?B?WkFwUm9pRFlkcHRPQ3BmaUIyUUYxL043UDBsOWRFUWdvcEZhR2crNU1uNHNn?=
 =?utf-8?B?TmFnQ2szWmNaelhmaE5kNmc5cCtHby9KOHIzaDlWWjAySlRhcWRxMWthRm91?=
 =?utf-8?B?VnpqalRsVCtEWDBqVlJ0VHlHZHRmY3J0Q29XbzhlYnZwVTdHOHZwWXgzM3ZS?=
 =?utf-8?B?cXhwelpKWGF5ZEVkZmVjMGZxT0tTdlZCNWswQkdTNGgwcnRndWRpcFFCWjRP?=
 =?utf-8?B?bHplZ0YxQ3gzVW14R1BDVDhzK2duaXRsVm5qMUNpSXhOZ3dMZzVrMFJHaW1X?=
 =?utf-8?B?QmZ4VEdSbDhwN21LZTNpcXZsa2dWS3NQR2Z0LzAvMUo3QVNRWnF4UEhUS3h6?=
 =?utf-8?B?Q1pzdnk5R2Qxd1pKeUJ2STBNV29PWm9ITTNxNGM3UVloWTVBODJEYzRPZFIy?=
 =?utf-8?B?bkt6K3kzVmlEdWJ3L2ZlcDZvSzE1dy9OSmFHY1dGdFNQa1dEVmJxQnc1ME52?=
 =?utf-8?B?UU05TWhRZThneWdnNUMxSjV3Z2NoeW4vMEJuN0NoaUgxTmYvYmEzeUQwR0Qx?=
 =?utf-8?B?Wi9TRGxRNm90WEJlZU1SZnE0WGcrajFwUVRNOGlqUFlWelVCblB2enVWem9F?=
 =?utf-8?B?OG9xeDh2b3hzdWdNVWw2K1FidmxEbmswdHZuTnJXM2tRVVc0UWJyTFZNRjdD?=
 =?utf-8?B?Q1FENFhSZzZXelkzYlF2VUY0R2pKdE5lakxrM1dlTTg0cVhPczA3WVl0NVM4?=
 =?utf-8?B?c0I4czZtVUVzWlNkUFJDcktLOXpyUC8rQXM5ejExbVdnTlV4aGlsU0lVR2Zv?=
 =?utf-8?B?STFTZjlWV29xamhadUlGM2hLTEdJVTVXT3B1dTRkUkp1V0xyQzhvZHVBR2ln?=
 =?utf-8?B?azMrWnZqNU9URzBLSldBSE9QRXhpOS9qU2tjVGQyYW9WcUQwS1czQ0I3MkFN?=
 =?utf-8?B?aFBYaXAzR2hQQ1dZUHB0SWhVM3ppSnFYWG1yUWpPWlZjWEttVTFKQmdmLzE2?=
 =?utf-8?B?aUY0Z2dNNEt6bVdnTkYvdnJ3aUZaUVJTS0ZxK3ZUdDVVUnVBdDZKdHdqbGVz?=
 =?utf-8?B?eWJocVNzSDBodkZuNzdSK0NscStxaXU5REFkdTdCQ2JtZWlQSEpadHdXbmdO?=
 =?utf-8?B?QUE0azJ1ME5WQ1hTN3BIUmFmckdTd0t0Mkx0bXN5S2I0MHVQT0xkWndjMnFu?=
 =?utf-8?B?Q0t2UmhoT2NSNW1KeDNScUU4aldRWFo1cDFqZW5xeHV5MHhjcUxqcE1hbmZ5?=
 =?utf-8?B?TWZMb0FHK1JXNDBTdFFmTjBOTjlzNkgxRUlUcFBDaDdHYzBKSElKdWF0dHlZ?=
 =?utf-8?B?dW9LUU14bC9vZ3ZCUkh6UE9naVhUSWorTHU1NGRWUWY0QUlpbXJ2SlJMakdO?=
 =?utf-8?B?Q0VVUS9jNG5QOU9IQzJrTFZFbkxSd1dhOGx1d3Q1VWIxQzN1ZTFqZ210K0wv?=
 =?utf-8?B?UUFlM1NPTHJ0cGZCSXppMjF4QnhaUHI0ZFoxNExWdzF1QVloaFR6RGJZWVNB?=
 =?utf-8?B?VzlMT3pKbWtHaFAxZVpCa0VmOGt6MWhQOG5mbGwxVGwwTUZVdnRrdTZSbmlT?=
 =?utf-8?B?NklPMXZUdG5xSWZPaHFLSFNNSWVnemgvK0ZPZXlRS2JUWjkwWFFDR29mbXJY?=
 =?utf-8?B?QzQrOE9JTGpNQlhyb1gxbHZGdzBDalJXbkJsbmRzVHdVOUpqS09DTjVxYk5q?=
 =?utf-8?B?bVFoNTR0WTVsVmJPdXByUEZsYnVCQ2dDU0VyOVlrSXNiU2d4QllTWVZpWEtQ?=
 =?utf-8?B?SUd3Sm4wY21EdnZxSWdmc3hhRWMvZGIwNElpdTJ4T3NVTTlZenVLbEF0Vnlu?=
 =?utf-8?B?c1Vkb1dUWnN3VUtjeXdGNUUrVjBNWTBJNHRpTkNBc1lwUCtNL0VMeXVpSitY?=
 =?utf-8?Q?9Lm3iS6LiuwSM3yaSgvpF3BiO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a86059-8d3b-413f-6001-08dd6ac69bf6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 11:25:41.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4sxySk8JhEyFeegR3YpBBJS7i1cBDvdd4Bl0ZF+0TeLcf/q6q+RBZllP/gkWyigXWbyoQCy+ED5v7hn+Qg1Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

On 3/21/2025 7:58 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Ensure that all supported raw EPP values work properly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 58 +++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index e671bc7d15508..d0c5c0aa3cc94 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mm.h>
>  #include <linux/fs.h>
>  #include <linux/cleanup.h>
>  
> @@ -33,6 +34,7 @@
>  
>  #include "amd-pstate.h"
>  
> +DEFINE_FREE(free_page, void *, if (_T) free_page((unsigned long)_T))
>  
>  struct amd_pstate_ut_struct {
>  	const char *name;
> @@ -46,6 +48,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
>  static int amd_pstate_ut_check_enabled(u32 index);
>  static int amd_pstate_ut_check_perf(u32 index);
>  static int amd_pstate_ut_check_freq(u32 index);
> +static int amd_pstate_ut_epp(u32 index);
>  static int amd_pstate_ut_check_driver(u32 index);
>  
>  static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
> @@ -53,6 +56,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>  	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
>  	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
>  	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
> +	{"amd_pstate_ut_epp",              amd_pstate_ut_epp              },
>  	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
>  };
>  
> @@ -239,6 +243,60 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>  	return amd_pstate_update_status(mode_str, strlen(mode_str));
>  }
>  
> +static int amd_pstate_ut_epp(u32 index)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +	void *buf __free(free_page) = NULL;
> +	struct amd_cpudata *cpudata;
> +	int ret, cpu = 0;
> +	u16 epp;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
> +	cpudata = policy->driver_data;
> +
> +	/* disable dynamic EPP before running test */
> +	if (cpudata->dynamic_epp) {
> +		pr_debug("Dynamic EPP is enabled, disabling it\n");
> +		amd_pstate_clear_dynamic_epp(policy);
> +	}
> +
> +	buf = (void *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = amd_pstate_set_mode(AMD_PSTATE_ACTIVE);

This causes a deadlock, as we are holding cpufreq_policy reference and calling set_mode(), which 
needs to unregister the cpufreq subsystem (i.e. needs all cpufreq_policy references freed). 

We might need to drop and retake the reference around set_mode(). Also make cpudata variable NULL 
to avoid anyone using a stale cpudata pointer later on by mistake.
OR 
Directly call set_epp() instead of store_energy_performance_preference() and eliminate the need 
of policy ref after set_mode().

> +	if (ret)
> +		return ret;
> +
> +	for (epp = 0; epp <= U8_MAX; epp++) {
> +		u8 val;
> +
> +		/* write all EPP values */
> +		memset(buf, 0, sizeof(*buf));
> +		snprintf(buf, PAGE_SIZE, "%d", epp);
> +		ret = store_energy_performance_preference(policy, buf, sizeof(*buf));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* check if the EPP value reads back correctly for raw numbers */
> +		memset(buf, 0, sizeof(*buf));
> +		ret = show_energy_performance_preference(policy, buf);
> +		if (ret < 0)
> +			return ret;
> +		strreplace(buf, '\n', '\0');
> +		ret = kstrtou8(buf, 0, &val);
> +		if (!ret && epp != val) {
> +			pr_err("Raw EPP value mismatch: %d != %d\n", epp, val);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_pstate_ut_check_driver(u32 index)
>  {
>  	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;


