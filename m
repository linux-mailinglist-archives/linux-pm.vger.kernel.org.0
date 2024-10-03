Return-Path: <linux-pm+bounces-15125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4498F943
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C60D1F21408
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6201C174B;
	Thu,  3 Oct 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZfW9SggS"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020136.outbound.protection.outlook.com [52.101.85.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48951BF81B;
	Thu,  3 Oct 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992469; cv=fail; b=UiT9f7G0D+pbNls3eZIY0l5AoV5MshmYfHJP7YV5M5Xh+tzFF1ebwpl8QWqNhrRKp/C0f45I3wo7BgD/mFByz7rMYr+e2SNNXaCWL8WLCN1efl3r1Y4xeVBRe7a9cm8fn7D+/theiCcXZkGN8DffiC7rS6gCwX7ffWmiEVQKtrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992469; c=relaxed/simple;
	bh=i4bUPkR29YwVLK2U7+/ClAa53tHARzvjFzfdWRLyXbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADOtcfMYzLBsvWohMkuOELcHDVK4IGfVtwi6/RmxUsWv6vaLEPoL2jAFYrsK8rfifIZxGCL1F9BHk+3bD73+Oyv7RhgHQxEiUL2+OZLdPNOJYyIkE55oTaXwySwvhGvFN+Qd+HP2admnQjnOaNdecy7q5WBhMNIpNaXasgCDwDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZfW9SggS; arc=fail smtp.client-ip=52.101.85.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdvJVlU5hIA71ClKc9JUnXMGh1hynPbByzXlpo/o1hpei3iEA9g+oxCkRLtlsA59bOKuZfCxLD464QO/JxPAyRntOB6dh0gEaiNy0Cpzy6yGgnrHzsrkwDNhOqm6uCn2k+aNa0q7gZsbVe05Diap2W5ALVGkz6wwHZhhcmH0jj3NNqyJqc3CKfdRdGqHRlG8k0qbP9YTE7gFeCtAWH5OZtgo/tvTsYgCuygyENi5Dt0JKq+7o9len13gXbIJUTFLfY8/QVwn+BR7H029oJ8eaIQeFn56y27X+2B0BLEKJftXHXdr5+J8QpqQuouG2VDDZtOVTQCtrxh9YTJB7xL6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E1AjJKhOM0IUOFQeLJ+4HJqiIefd5c27xavrC/mSUQ=;
 b=yQcQKUjQrFP8c7smy1gEuOta9N1zm4e7qOqxn6Hg9mp1HIoyY6w96ZvMOJW9lJ+NyVPNaJ8L10P5PEEA7Em00WotBtE8jcMp2HKmxaWZ3lJJwPB0oIaN/otR7tP5DrVbEA/If94Wu7/VeNusfFxAOM66exQrBp4QwIf9yf6LwmLCXg3dXn2nCOGgD0kzKIYWPNwRyO46nvjMRtW4ds2o8TaXgBm2CKyGotIbq7g2WO6fOaBMAGV3QGda5jGMd7qTYxCf+Zar4xhXSlop9jQqP9+ceYZrTaGfd4P0Bu29X/bRwRjcXFKficOK2EHP3x0Yw9qEBNzwIwqA3pt+uDKd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E1AjJKhOM0IUOFQeLJ+4HJqiIefd5c27xavrC/mSUQ=;
 b=ZfW9SggSH3acpl/QssY2YCKuIhVQvEzJvveRSbM5N/B+UzxV7nWmFWqr6lnjBaNStZ54lN7tJQoXJ2yXUlvOnykyqirO/Hr31CgIvRKHH/KsIuraOw9mAlocMYxc7HgWqKi7B2/3zW6Z5XfbaqlMEAnDc5oef8hETeJK2LJOZyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN6PR01MB4176.prod.exchangelabs.com (2603:10b6:805:a9::14) by
 IA0PR01MB8378.prod.exchangelabs.com (2603:10b6:208:488::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Thu, 3 Oct 2024 21:54:25 +0000
Received: from SN6PR01MB4176.prod.exchangelabs.com
 ([fe80::da3c:af32:2ee1:dcdd]) by SN6PR01MB4176.prod.exchangelabs.com
 ([fe80::da3c:af32:2ee1:dcdd%2]) with mapi id 15.20.7982.031; Thu, 3 Oct 2024
 21:54:24 +0000
Date: Thu, 3 Oct 2024 14:54:22 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, 
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, yang@os.amperecomputing.com, lihuisong@huawei.com, 
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>, 
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zv8PKlr_PJgxazro@arm.com>
X-ClientProxiedBy: CH0PR03CA0425.namprd03.prod.outlook.com
 (2603:10b6:610:10e::27) To SN6PR01MB4176.prod.exchangelabs.com
 (2603:10b6:805:a9::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4176:EE_|IA0PR01MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 599a8c13-f6ba-4d01-68ab-08dce3f5f20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwlSxWrODrw+QyoCfPdavtadN2Mgo1EXfXjC18AXLyxL22DAKyD3RIyVMgPl?=
 =?us-ascii?Q?j1RPjQ4qfbBw9N7DX5iBGRmY3bWgkWYgZG67HDQFG2QTey8GskPK9r22zy0U?=
 =?us-ascii?Q?hJ2JEbeV6eHYY1KzQWHePM6iQkk846W6YzmzOMSYbk5+6CY877nJLxC0zL52?=
 =?us-ascii?Q?2fIUS9TDrgYRPbJFa2zx4Xqo+JKGjaTKMv4yF5/2fy2jaIpWqXuY35cEGOrg?=
 =?us-ascii?Q?+oab59jlJOkTBfwOr1HMIlPkwytw/ZRHQmRlYz7Q0I6DCjAbelaMiSJL45GW?=
 =?us-ascii?Q?6bDhjaUmFGxUmMYScUziq2Fde7XIrNO/0iO9rZf9HQMQfkRMmBXl54zNbxVs?=
 =?us-ascii?Q?NUWIlKzP9tHdJZDS049p/jLEzsVWJVvK3CdrfSFgdUCFFvp9LwSvjWfoGW2B?=
 =?us-ascii?Q?6Tqe294+M4doUrX9zPIpxldvdnWqzktiMlgkkq5E+H9DwKjGmsMmaiuSxEcg?=
 =?us-ascii?Q?BDIti8VM3V0hZ+N3mWcE04H5ocjp5bridJo1JYK+lOZ0fd6Obz/wcv+WJWN2?=
 =?us-ascii?Q?Xvg27I5OF1LJkJ9V4522U/2JNtTBaVjtn6w6g+T5Ch3UCAEdQnX62WlyhxtU?=
 =?us-ascii?Q?JdLbviTKgk/TjsZbesfmvWh8uyJ33wTMEom4VizwGHCm9VExnK0SJn4qg0Uc?=
 =?us-ascii?Q?6K4zHx0Xoc0riiFimfgRp8T8B74oEOZ9xETjhLOEsVOi9kfmt/xY1DUI+8DA?=
 =?us-ascii?Q?qF8F1Z8mvLNWoTFqG5YLiq/x2cAViTw2BieEJ9iFn/b5NaOHpeLP3+Cwahf+?=
 =?us-ascii?Q?VPpS6+AHbV3qiDeJYbHQh9/ZAtqglRGe7iThXEqJgl+NvdD4Sgf2JvZ72TB8?=
 =?us-ascii?Q?fbE5sHc48GEQ+sDIL2NiHO1u0OyGwGbDAv8VSaX/0JKY5gLF7iNVRZ5ZUm0D?=
 =?us-ascii?Q?AAGdjLO8ww/brqv2TARVD6a/g5YMKREHVbehFz9VznxjaEjI6lN9LqtQy4KL?=
 =?us-ascii?Q?LpXexiNsCYPPR7fLZtL/9c6R7yK/EQjlCLBdHKC8JAIhXTPGC9YKVAqRjyhR?=
 =?us-ascii?Q?RbD4sAmA+bBNG6eWlW8KMJOSD5mRtVZHiLpTfzPBQ5dvG3oBMp49dc8OpvpG?=
 =?us-ascii?Q?XQui3z6e1g/XUBVesPfohsY3m0VVnn6vuzkWnP7movpv7Ai4EddFWxLDb8Ev?=
 =?us-ascii?Q?h6VpwRPiB5Bqf4e6l2SY8wW5iwuK97fsqEyCKjAIYFOpCqDsr7xvuvM8oC75?=
 =?us-ascii?Q?3M7WbykqlbicUUhNkxT3XyB7BxT5TijjdDh3/R5uEslgJYMxm8dWlnQHCMiC?=
 =?us-ascii?Q?gwQ8tNDsClbjppDRT+Z5iRaUIaZrd7M32zIY2ur9XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4176.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfzIVBnqsldUyXPXInAl1C2VZ3jGC1KQHfqc8RcgatpTMgWwVguFiunri9iU?=
 =?us-ascii?Q?a13BV07VbRDEvofYfV6PA0KZLxOVwHZZ38ARifkOXJob9CkyhnKcvOX8UfGZ?=
 =?us-ascii?Q?LHznSPxZa4YBkwNw6dryhebnHRH6302hNrIKPOq0a0bh5mfORnwSH/E6L0c1?=
 =?us-ascii?Q?3PZS2yLL29CjSnwYJCGr/BlTD4HTO/ExkmeU257h6K6xVBW4KX7gz+6pslCO?=
 =?us-ascii?Q?QKjIYEG7mJY+Sz9CxNqQadMWjFGNdoeSesU7UtaMHX2GZSxZVbmrKkxS5OpW?=
 =?us-ascii?Q?lGvtKpwIw1TuTYkWmwpD9cBZ9vQa0rkl2STaLS24unqQ+pfR/FDBL71ZayLd?=
 =?us-ascii?Q?pUZhbhrJ6ZlsyH2MMFkicwlbWmzwKPw5cth94ox5Xq7gQP0S11iX9IB1ek7B?=
 =?us-ascii?Q?1+slrtAHV5Cb3pJjntC9Plow4j4bt4J3Uxkrnv+arke0DeV2g3vXSw+jxE7E?=
 =?us-ascii?Q?bAcy06JnyNZ82mULU8oD0GNc55Zt01efM0I/TeSKX8oK+ZhlEFn75fcbaCCm?=
 =?us-ascii?Q?FUQaABN3LWhrbSQNILsEl4wYyg+WRSHwLZOIAv8/r/B3vmqQ15KCzGzmurDC?=
 =?us-ascii?Q?u/EElVfreBWL2dvcOXyx0ayOUN8Xen3sq1c7pLaVlRLP965sOYNzMqPpi1Ku?=
 =?us-ascii?Q?Dtp6VSiajTwGq+msmdW1CW4omkihVAGaaNpCHSVUKcTbvouk8+EzPNeTR3AI?=
 =?us-ascii?Q?pJBl+/bxJPOVGDNI+lcOfzq3fq3iQQD5N1Gi6sA11P/jxREKLK0gMwtje6ro?=
 =?us-ascii?Q?NLbYTMQ5bAiS/+ftnuwdftRWKomO8MGwV0uUBNJRJabIV5djy65pVV0mAzDb?=
 =?us-ascii?Q?W+isOqBr0ZxzqduEkg5TdLYXEFQYMF5xNV0QLz7QnTpvHBQNoRj9njwFQE93?=
 =?us-ascii?Q?BID3dIIuDum3mcc6wCVnNbnvskXNLo85usy9t7fS2qw0t9HoBy3BSitbmAPr?=
 =?us-ascii?Q?Rcl4aFo+0PP+/vmhmIdIjDf2ptOW2NyoK5w6zNz4D+8SoI4dtTv9xnUbO8FW?=
 =?us-ascii?Q?nUn9e0IJgqlFZCrcxkYobMWTyC+TmXaWV3avG9xHPqfrv7KrzFLCOZoWcEti?=
 =?us-ascii?Q?S7pqaeiwI91Fj/RmiVnPyuVYzDI6W/N1Cwk2CXUvaAUbG6L95fozkPh1uPIn?=
 =?us-ascii?Q?fOCIxbPBvlMqs7kdsWQ0PIcfw/AzOOS/z4sB9Gz8WHRIsE26zfpMYKqarvFi?=
 =?us-ascii?Q?+58c4n+F7/nZ5jv4zKoNKQneqcvv43AhH+XOMWNLApQodbcQVeldbpgOLYug?=
 =?us-ascii?Q?7wNkvhQzXVrTWUuaFMLtHmVnd9L5VThcwQsBkRY6U0ghuQYCEy6QVTkociTM?=
 =?us-ascii?Q?o9KlvsRhRmQ5sIlBlf8WNoyR+vsCh85cX/vROJyX40KyZ4+AC8YUdltK12sY?=
 =?us-ascii?Q?POsS0HMkGrrBtYln69ANxEd9NaQ08ldR67N1d55tVl3Bnbi0607v7GDNA62H?=
 =?us-ascii?Q?8NsfI+D+zG1AiI/uppDit0bXFGkBbBUezKCXv0YUXTwXkyS4sORQTPqECyEQ?=
 =?us-ascii?Q?hpalGXEaDdBKfPMLjH3L6b5IF8/SYQA5W0eEmxBdMJWzNnUwl1CHznpN6vYg?=
 =?us-ascii?Q?2l44FywCq1TsQjRqSn0p0IfBywdJydg07NQg2Vsfe8CRWasrU2nEj8B95Mr3?=
 =?us-ascii?Q?aFkWq2fOYHKN1257Ar1WUwA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599a8c13-f6ba-4d01-68ab-08dce3f5f20c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4176.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:54:24.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J20k8oxnvp5YaXo/t4NMQLiVc4Wm1Ugmxal6OsW+Be+uwwGkUo59yXpey9+cGU/30P01fZHpaz0QlLTNjTXnrbhaCiG0uFuMtvHxnkOz1CCRNyU7fx53LrjFzMKHBFv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8378

On Thu, Oct 03, 2024 at 11:39:54PM GMT, Beata Michalska wrote:
>On Thu, Sep 26, 2024 at 04:21:14PM -0700, Vanshidhar Konda wrote:
>> On Thu, Sep 26, 2024 at 12:34:01PM GMT, Beata Michalska wrote:
>> > On Tue, Sep 17, 2024 at 05:41:09PM +0530, Sumit Gupta wrote:
>> > > Hi Beata,
>> > Hi Sumit,
>> > >
>> > > Thank you for the patches.
>> > Thank you for having a look at those.
>> > >
>> > > On 13/09/24 18:59, Beata Michalska wrote:
>> > > > External email: Use caution opening links or attachments
>> > > >
>> > > >
>> > > > With the Frequency Invariance Engine (FIE) being already wired up with
>> > > > sched tick and making use of relevant (core counter and constant
>> > > > counter) AMU counters, getting the average frequency for a given CPU,
>> > > > can be achieved by utilizing the frequency scale factor which reflects
>> > > > an average CPU frequency for the last tick period length.
>> > > >
>> > > > The solution is partially based on APERF/MPERF implementation of
>> > > > arch_freq_get_on_cpu.
>> > > >
>> > > > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>> > > > ---
>> > > >   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
>> > > >   1 file changed, 99 insertions(+), 10 deletions(-)
>> > > >

--- snip ----

>> > >
>> > >     ..
>> > >   freq_comput:
>> > >     scale = arch_scale_freq_capacity(cpu);
>> > >     freq = scale * arch_scale_freq_ref(cpu);
>> > >   ----
>> > >
>> > This boils down to the question what that function, and the information it
>> > provides, represent really. The 'unknown' here simply says the CPU has been idle
>> > for a while and as such the frequency data is a bit stale and it does not
>> > represent the average freq the CPU is actually running at anymore, which is
>> > the intention here really. Or, that the given CPU is a non-housekeeping one.
>> > Either way I believe this is a useful information, instead of providing
>> > stale data with no indication on whether the frequency is really the 'current'
>> > one or not.
>> >
>> > If that is somehow undesirable we can discuss this further, though I'd rather
>> > avoid exposing an interface where the feedback provided is open to
>> > interpretation at all times.
>>
>> Would it make sense to identify that the frequency reporting is unknown due to
>> cpu being idle vs some other issue like being a non-housekeeping CPU? Would
>> returning a value of 0 make it easier for tools to represent that the CPU is
>> currently idle?
>That is an option.
>Another one would be to return an error for those cases. This would make it
>easier to distinguish between valid frequency &/| idle CPU vs tickless CPU
>(EINVAL vs ENOENT) ?
>

That seems like a good idea but I suspect it would be confusing to the end user.

If a user runs `cat /sys/devices/system/cpu/cpu2/cpuinfo_avg_freq` they would
get an error in some cases or get a number in some other iterations.

Thanks,
Vanshidhar

>---
>BR
>Beata
>>
>> Thanks,
>> Vanshidhar
>>
>> >
>> > ---
>> > Best Regards
>> > Beata
>> > > Thank you,
>> > > Sumit Gupta
>> > >
>> > > P.S. Will be on afk for next 2 weeks with no access to email. Please expect
>> > > a delay in response.
>> > >
>> > > > +               cpu = ref_cpu;
>> > > > +               goto retry;
>> > > > +       }
>> > > > +       /*
>> > > > +        * Reversed computation to the one used to determine
>> > > > +        * the arch_freq_scale value
>> > > > +        * (see amu_scale_freq_tick for details)
>> > > > +        */
>> > > > +       scale = arch_scale_freq_capacity(cpu);
>> > > > +       freq = scale * arch_scale_freq_ref(cpu);
>> > > > +       freq >>= SCHED_CAPACITY_SHIFT;
>> > > > +       return freq;
>> > > > +}
>> > > > +
>> > >
>> > > >   static void amu_fie_setup(const struct cpumask *cpus)
>> > > >   {
>> > > >          int cpu;
>> > > > --
>> > > > 2.25.1
>> > > >

