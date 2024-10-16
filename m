Return-Path: <linux-pm+bounces-15791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAE9A10EE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 19:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4DD1F22010
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A83212EF4;
	Wed, 16 Oct 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Wj3r/++"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55E18BC23
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100999; cv=fail; b=ny6rRiORAkpF9cHd5zxgaV2awl1MENvmoW/frSFCiV1qqbIuzp3X48Gk56fGntnhP8++Jw8zrxnvPzIhRRQ4mTc0RIPhfYidYiraP+zgHk5ByIQJVYnK2V0QK4B176qaAawCCKX6zgago9yLXQK0kzeVA4nOTiqAMYSR6woHUQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100999; c=relaxed/simple;
	bh=HD/XXmV9L3r9uru7Uzx11rhTERo73zZI2moDTYuBKLY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=QdvKBfsXPV+0RHu3lBZLvf+6aS5JzqpFJImxVDBNJocEjC5Gcyy5XqMPE4vVThzA5Ig074wjxdDDY6ZU9FW8w0b1mPBg7x5Bb67fLnHOS301ADv/AjmAnR2M4Fl42UJsaOcZHPMyPz9he3yjjaNG+6KJQj9FKBIza2koRBRoQuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Wj3r/++; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd0nCahxgFoZf1ZfeTSeQqUKG8elM/O9tJRHWHewIcU0dzs3GneGBNoBzGpq8200UTFdgd+SWAb+5WENzwgBiCtQ53Zk32X2eQWcxS6RwXCB99cE+Y7uL407M37RG6PhZQol6yiCkhFQLA2Nn9DVJoWAW/MHRC3RmWnPQFVdLLNfclLtjb1Kwny7kyFoS9j/M/vsN9gYHriD8Yc97k6W5J40/vR6VaUOU3SgVfkEf80kVCW7sMw6CIFoKLmseH2yPqadLepmw1mbMmVWjYrzxppK8+sY+134gcjIY7TyMz25surEbjOBECncFyR1NgesNS63+xvU7I21o2/eStHUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YouOvcw58dqAUHThopDoybhflIb8TJfwknL6jRki4cM=;
 b=V4InCn7iJMx4hLUxwDM40dYsJeXOgwhJ/3alpjNvMmm04ZoEejrphkyrFtiamMjMw6DAt/IrJS3l7F5d+g+ko1IVfOHhpy+/BFQSBG6ENq42wimJ/mOIqVkzf00NA6kOZ4AYCQzCFcrIyTTDU22ZuJ5CnKEx4fBreDLE4CFgX+wOROurrmtj9lwXqxFPzBO+Krj10h6K7LeQ3ZFQjdPq1GDa0VIS4fIrmvxU7+cOFafhF23TWMtm3EISgWSX9nUBKaoadkWs3+A1ydYkykCU72nRnm+mR8+hHHwcNUjCqr5lHus1fmTC2prOJ+k1dA8emZaCgEuRNwaYbsjDGA3Ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YouOvcw58dqAUHThopDoybhflIb8TJfwknL6jRki4cM=;
 b=1Wj3r/++VV9Bdf9AdApEM53fa3PyEPELbMYws40ceqiQVyiKyZbr+QMXyJWLfCIWb2pdnF1pN2drpZcuDSwP+d21NyGrzKlw9q5T7qOaKp8KaGOA0OwQna58J0Hjfrud0KFdrLdZpWkMVD0b2hKOJByOAAjaA5OqskY7vFw8+f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:49:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 17:49:50 +0000
Message-ID: <c5fe5144-f014-4786-9f56-a04743d1a6d2@amd.com>
Date: Wed, 16 Oct 2024 12:49:49 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Second round of amd-pstate fixes for 6.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2e8763-9fa4-4986-e918-08dcee0aeeeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eENOZndPZmRDWjRmUnRMUUpHaXRwS1RNeGpUWU52ZHk1elh1c2Jqd0M1YTRJ?=
 =?utf-8?B?cjNlUGNSbHJMeEZsenJSVklRMWhPR1krK0E5aXRGTTVURWVlTi9USmpTNXk4?=
 =?utf-8?B?RjFWL1U3T29iWmdsWm45UUwvcktWQmdwUGFnRHIzeFpFdUVBamQvdUNaQ2I0?=
 =?utf-8?B?ZWd6RWNuTVdRUlZ0aDRCd05tRS9wV2UxekphT3oxVmkyT2U0ZXJhc21JaFpB?=
 =?utf-8?B?OENjK3pXK3RWNWFFdy9CcTBKZE9LRW5Zbkp2K0dzWlphVGhORm8xMzVoa1lG?=
 =?utf-8?B?c0YzVkcxMjcvdHJrb3QyTTNYUnQ4WHJ2dDVsWHpDU0hNUVBmWlUvamFSWnV5?=
 =?utf-8?B?Z2UxOExOL3U2UHJrYVc0Z1pMa3hGWEl1elg3VEtCZnVuL2RUbW9DZ000YWdy?=
 =?utf-8?B?cFQ3YVZ3M1YrRDB5bW82L0V2cHUxK0ZEVXVaL2RrL2JTemUxY3RVVFdMdW9t?=
 =?utf-8?B?VFFBUXFxYlI2ZE91YTZ4QjhQMGxVOXMwQy9CUDBhQkxYek1aRUR5RysyYXJx?=
 =?utf-8?B?bFJoOEVabFZsUzJjTGVSWVdFSzBVakFYUHVOWjVVYm5KclcvVHhSQlRwTWtN?=
 =?utf-8?B?c3dLUHZvTDZaK1p2SWowV1BsRkk5VWVTYTlBVVBiaUxwZW1pN1E0SGN5cFlq?=
 =?utf-8?B?K0ZldU5VNEtYaUVGbmVvVUNlYUhwOWpVaDdMSDMyOFJEWGZLWFJVMzBzWHpI?=
 =?utf-8?B?NmpobitHSkhIWTZ6b3JGT3Q1WUc2dy9hK1E5eGpnVUhBSGdXbnlpMlRnSFJn?=
 =?utf-8?B?TDA4T0ZFL1VybXhkdXFRNXFhL2IranFtUTdCWlFWMFlISFFHek4zYjcrYnBw?=
 =?utf-8?B?M28wV1IwaDlZREI2NkZIQXF3dFBJUXUyd1R6NDZvOEp5UWREZ3kwNHRkS0dQ?=
 =?utf-8?B?REE2U2UxSWNrbDd3aEpEZzl6QWlqMTNCSFcxNjYxaXpsWlM5eUlSTGNrT2ht?=
 =?utf-8?B?MkN4c2ppRGN2cGJRRVJuTXMrWGphNENxdDhGRjdxc2EzRmRjWXQ2eWttSmFC?=
 =?utf-8?B?UUVTbENkMXRHUWFzbDlEUFQzOEl0cUpwYUdNZzRZMWNRdFR2cytaSWgxdFBV?=
 =?utf-8?B?SHBiOVJNeUhXZ0h1YzZHZmVZR3RTU2dJRzRlVnRBN0dJc2lkU2ZPSkVXZm9h?=
 =?utf-8?B?YWgwazJSUmZsYmhOdUN5Y0JUTmNtY0YxbTRja2ZVdjRYd3N4Z1c4OGtHaC9p?=
 =?utf-8?B?VGtjQ2tuNjgrV080N2ZFQWJyc3g0UWhQZW9VNFhzdmE5S0xOZTM0NFRYSkl4?=
 =?utf-8?B?ejN1aERCdStTbmtIUldUQmViMFhJaGM3bStUUDcwQU0yTmluWWhFVTU1enBv?=
 =?utf-8?B?MWUyaHU1aVYwRzYzYVh6SytpWThZWE12eUxqWlJpZXp2Y3BTOExndmJlVTls?=
 =?utf-8?B?RzRnV3Z2UnZGVWlKVVhDcHlXeHd0bjcrMThxV0RTUGpWd0hMeW9GbXZwcWU1?=
 =?utf-8?B?WkNxYlVodCtsS1JHbVY4N3ZvMHBSL1BlTy9WUm5malFtbC9Mc3dGZWlUcnNJ?=
 =?utf-8?B?TmNPUUg1SGw5T0dOMDZIL09PaWFpQWhmTGgrT0hZbzJsNlBsNkQvWGxrM2RT?=
 =?utf-8?B?QU51WW1PK3JLbFVmM1RpYXZrQkNmUjZuZkQ0NFdHSTM4cHpZeGVtNnBkVmtS?=
 =?utf-8?Q?ujNHmYAcYrT73l3QRPTsurYs+mo9Z9WH9wf7H+6FKcbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjQwNE8vVWtxMnN0Y2pNcm5CcWdvSVhBY2tDbUVTMmtJakJiNlhWelhGOTJP?=
 =?utf-8?B?NVhZNEUrbDFHUHFzc3A4WWdybUg5bVJTZWxHK0FIQlB4Uk9XdVcwM1RLNStu?=
 =?utf-8?B?d3B3b2F2Z0VmN3FsMnhtY052eWdWNm9yWXcrem9YWld4WWRPYUVlNnBUejl6?=
 =?utf-8?B?MEtYWkcyTTc0SWFiUjRwK2xMd3F4TlMyZDR1UGVhM3lmLzBVZk9xUVFBdUhm?=
 =?utf-8?B?OVByQzdTQ3Zma0dmVGR2VUJNWVlVTGwrZk10VGRjaFAyRXJGY1A5UDhLWldL?=
 =?utf-8?B?M2JQR3RpK2NKY0YvV1J1Y1JLZGlVaTVpVEhrdWNtUkZyQ2RNbWY2eHZWQlQ5?=
 =?utf-8?B?YUJrOEJiVm9GVGY1eC90SnV1VVdqcnJhL1c5dm5DVGtLd3ZWaWswVU9ZUEJo?=
 =?utf-8?B?d2lzbkNjS2dmOUh2Sng3MmZwUVBNdWMxRS9KelhxWTA0cmptT2w5b3JnWWJs?=
 =?utf-8?B?YlV5MS92NVYxUDBUdHdYeWJMM1I5T0g4UHhrYXVVUDRuMHlNVzRGV0hERER0?=
 =?utf-8?B?N1o0ZTB6RHJERDFXeHRVSytLbUs5Yy82Y3dDanJTa003WllSUk1JRG1lbHRG?=
 =?utf-8?B?VFZTZUtDWXBhNGo4NnNTVUc2bmY1dm1qeWU4a3MvZXlYb3ZsWnZkREVBS21h?=
 =?utf-8?B?SnlTa3NSSmJJNDBCVHREVjBwdm1oNVNoaDJ3cGpFTG80bmdMV2FrRWxucVpN?=
 =?utf-8?B?L1dRYXI5NG1QbmUwWWUxd0hjcVg2cTdRQjRyc2N4empwNWswUFdrVlFFZlB6?=
 =?utf-8?B?WGJxWXJ4anR5TnNCVHg5VUpNeVdoMXltUlhKZUtrWGdBYnp2ck13bXF2cEdC?=
 =?utf-8?B?Q0NIWTNXOHI4MFpLY0FSSk1mMFJTWUpkd2VOaWY5U3RxMzUwZjhXSHprV2Jx?=
 =?utf-8?B?ZytRKzloTjRqakhteXhVcGd3Rmh1TUZDb3JFMDBCMEs2L0NSalRwNGlHUzMw?=
 =?utf-8?B?ZlVhTFNVYkJmQTJWSm81a05CTGk3bHdmMmlMQmNvUmYvRnUyT2phZ0xkZFlv?=
 =?utf-8?B?aTAxNTdDdHhCYnMwaVBabzl5K3hCZWRwZy82Z0pLemtwMklKV0xHLzdBRUFa?=
 =?utf-8?B?eWYwMmhTK2dzd0xjMUNoNVRnWlVWS2Q5N2pGRndBYWM5bEN5WG9VMGwrM1RN?=
 =?utf-8?B?VE5DbXBqRU4rR0JtaVJ0WVFjSHU4QWtxb0lXVXptekIxTHJ4Y1laRjQ2NVNG?=
 =?utf-8?B?SG9rVVFxR0E2UEdlZ3k2ak1YenJBR1dvYVY5TUxBb1V4UUk2K2g4YkpBNFZ3?=
 =?utf-8?B?QTU2TzliaFJDUFFjbFBtQkNMOGpMK1dZMllrNVlTSFlETjRmcXB3RlVNRSsv?=
 =?utf-8?B?Ukx4R05wcUhtZVI0NnpyUnZ1Z0hZcU9Hb1RtUjc3eGpJQ1lYU2I1VnJBU3ow?=
 =?utf-8?B?a3JZMENNSDRLaU1TRSsxbk4vVmRZVFR6Q0lPYm1meUhhZlFvZEQwdjF1U0d4?=
 =?utf-8?B?eGZQRzAzTnVXeEx2ZDZPbTQ5aDFWSXB2UXpXUVVhTE5XeHVIdGlvTHFKemJQ?=
 =?utf-8?B?aVVnQitWazFoZVRxK1dzNU90TkNVdFF1THlKeFRjT21jL2UrcklsNmE4ZG9j?=
 =?utf-8?B?RUQraGhwWjRqb3lpSVhsbS9rbC9BNitVR0h0NGgzK01SSHR0VE5EZXNMREs2?=
 =?utf-8?B?UGNBbnd2b21zVjZTUi9GWVhHbmZaL3ZGckdqQmZiblVENzNCYVlRSkxRWlZk?=
 =?utf-8?B?R2hLUTU0blBBWmQ5QlZ4M0NTY05kY2hyeUtDQ2ZETnlZeUFkSmRDQ0t1bHZu?=
 =?utf-8?B?VkZjblNNK1NjWUNIQ0x4MUxTZkZuQWR6SFJwSnc1WklKUE45a3YyaklmRVgy?=
 =?utf-8?B?RHZiUXZWek43Mk5OYjVKdGdzMjg3UjFZYXRCTDZKK3NDL080OEcxOCtQc0s3?=
 =?utf-8?B?RmNJRjZETXhjRGFCa25FTytvZGxiVzExbGMxc3ozS1Z3bTVxRUplV1d4dHRo?=
 =?utf-8?B?SUR0RjdVcGpVN1J3WmVJNnN4ZmR4TDR0bzQ2RlA3VnBQUnEzQjRNS0RuTFgr?=
 =?utf-8?B?TWZpNkk3MUF6NlFmOHVnRWtQTjhpekNtclpNOXQ0QWNGcTllUm1OMGcrRE9o?=
 =?utf-8?B?V3VicVFyNGtDTU5nbG5EdjZLMG1lc3FqYnM5OHZBSFFTK1htbkMwdXAxUk5r?=
 =?utf-8?Q?ogS3Y36eO7hfmpvdkjs8tq1Qp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e8763-9fa4-4986-e918-08dcee0aeeeb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:49:50.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCHXmvAyG64csQzhMEg6d56eMeMSXzqjM1vtNmYD1JRqTmrraPQ/B6uMkNTILhB2SMhUkWgCZtqgnYOnsnIfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

The following changes since commit c10e50a469b5ec91eabf653526a22bdce03a9bca:

   cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory 
systems (2024-10-07 11:32:05 -0500)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.12-2024-10-16
  
  
  
                                                                 for you 
to fetch changes up to 18d9b52271213890da295a7c63ef8880ed570cd8:

   cpufreq/amd-pstate: Use nominal perf for limits when boost is 
disabled (2024-10-15 23:54:15 -0500)

----------------------------------------------------------------
Fix a regression introduced where boost control malfunctioned in amd-pstate
  
  
  
  
----------------------------------------------------------------
Mario Limonciello (1):
       cpufreq/amd-pstate: Use nominal perf for limits when boost is 
disabled

  drivers/cpufreq/amd-pstate.c | 20 ++++++++++++++------
  1 file changed, 14 insertions(+), 6 deletions(-)

