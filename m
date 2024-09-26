Return-Path: <linux-pm+bounces-14848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D562987B9E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 01:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187ED1C227EC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0901B07CF;
	Thu, 26 Sep 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JQp3WQXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020098.outbound.protection.outlook.com [52.101.56.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE81B0139;
	Thu, 26 Sep 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392885; cv=fail; b=gtl0XXfLC3eji+a2tn03QeySOJVFLXGr0IbdVt8JD+fFQ2fX9VbYQwsXn0y4nogZotHqj1XtwuZ/qcf1/siTf/i9FXVOT/DkO4j7GWRtdXtFAgmgweIWYA4sY2KBbUfRgxCbAH2JdVCScX1hV3bX7XONpQOOYHlT/ZSnLS/+dAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392885; c=relaxed/simple;
	bh=o0sZeMntCz8dIeVR2UXJoLLf0ElC66EB6+wuFmGHu0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L68kq1MZHAjrl4jEnurp1Zh7yuAuQZSWf6Zyg4D87caeUxkTWIXk4JLl1w9YI1AbcuqLs+MdvIYgLTj9MIuyev1Os7xJfCvN8aHIDX28zF3T9Swz+lAh1oFszJnEDwu6R348yANYPcgL9fl3o0hoWwA0sFVqHFge3Gk4TBiLUSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JQp3WQXG; arc=fail smtp.client-ip=52.101.56.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnwczXRZZBggsqBh0daDcHiI+kB0yhogv6yU71zkF91+BbWbLo57m+9/xr38WVBafy34pGhW1PbbmhIAYIbWF8YbOjbagQzCDp+xqTIoMcFObx2lwwa8Wddmk4uOSp+zHCkHIuDWlWUFh75ERdl6AnjPlXmuDimmfV7XgkSZ/fp3p5LjfkBaxjNtJuN0r/mc9sPGYGO3KOedXdvlUaQh6ARZLhxXWdfhqp0oDeuKnoTpZxDx+gGSGK1i6CJ3YkZ7Dv7TQLaghIww9GrsECVWrdPqCAQGXK8Vlh9rYX+hdDqIz+rG3NIgONNbFeemQQLXvi/5YQComlhOkRXrp40Stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4fbF3aD0BVOW+fevBFiua4ZLqcAFXyOs8DYAEWN5bo=;
 b=uigmqH6eCXhucIhL876c3Fu5t0zelR7zThSHJd8VGWJ78WoZT8MQJN9moSxfnZ3eA5SN/9mfx4I5JWyqkAWdEDwHTYGYr1wX4w6PlP7N20bGb+D72hlt3iC+74QiyMKsgNqIYdjAdXmnaaNODV4jrmGfIMhH7mGyAdPxzgvbqAPypBpzREIT4nybRPGeXyXNLrLYDot/YEE0JjuDyDz7hAzjDZjU0L8QtbhIlYAPgOmicSE2uJVbn9v58D+JDTP+Sqj9y6AhARgaRQgOsIkqDSzjFf43LTNSVJV9hYD1ZX8xUeSjOdC4ZpsOgJvylMOs0jv4uv+Rjcni9dEmee+8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4fbF3aD0BVOW+fevBFiua4ZLqcAFXyOs8DYAEWN5bo=;
 b=JQp3WQXGsCGSvYdDnZHquMFxrzyLUXRZvO0ENq/PHfDBtjsNS/lesOkPTFewU3Vr3I5A/mkQX4sx3BEuHC4ENqFzZAoKw31ql3SgtOlJ3Tag6aUK8ER++6o2WZxtKFUOOLVxHSx30pOZUzMfYE/VCApS8/fAMlGJx5vSE211a50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6SPR01MB6.prod.exchangelabs.com (2603:10b6:5:ba::32) by
 SA1PR01MB6720.prod.exchangelabs.com (2603:10b6:806:188::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Thu, 26 Sep 2024 23:21:19 +0000
Received: from DM6SPR01MB6.prod.exchangelabs.com ([fe80::5771:a8b1:95f:eb68])
 by DM6SPR01MB6.prod.exchangelabs.com ([fe80::5771:a8b1:95f:eb68%3]) with mapi
 id 15.20.7982.022; Thu, 26 Sep 2024 23:21:18 +0000
Date: Thu, 26 Sep 2024 16:21:14 -0700
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
Message-ID: <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZvU4mR_FZa7jXUgk@arm.com>
X-ClientProxiedBy: CY5PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:930:1c::31) To DM6SPR01MB6.prod.exchangelabs.com
 (2603:10b6:5:ba::32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6SPR01MB6:EE_|SA1PR01MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ad9b60-643b-42ce-a324-08dcde81ec93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHLCLHJvUxwOOPoJ+kEwyeYLIBjDFmK2egxRklcoV+D46rTiHHK/l3hGkted?=
 =?us-ascii?Q?YxJdmmkmTExXA821oCpGgmtJc8LAZG8Qn6z7Naj/LeS5mfRmzsL/BgHY8Q+1?=
 =?us-ascii?Q?UDn4b0pATu3DzH0vRVkzzbXIN8fVUzGbTicQ9LBpJq5stfo9c2OWNrCLtjU8?=
 =?us-ascii?Q?3EpQzJx5ek4JsppyU+QzvKD0mjBp+h6zpZAorfEzsLGlQXPEdkvl5EG6Iz7i?=
 =?us-ascii?Q?S/gUtiHAJLiaB1O2DFvv0X7UgGx2I5OuiWur/nv8W7vaXIcJDQpJXOBfW/D4?=
 =?us-ascii?Q?V8CPnY9ZdIU6j6Ekr8F3kZWZ7vmNHbxliLxz9VOjzTS58xal7x2pTA+FITlT?=
 =?us-ascii?Q?x41Zr1YhVyBQvyEKBgfQqwOp9mby6JcPAo2/YRen3UKm1zs3jHLtIWQhr9rj?=
 =?us-ascii?Q?/tOTB7qLCJd2v9AyZ+F7QfdFFzM98zMZCjrBkSeysoDsrI8Ymdwc1G47QB7t?=
 =?us-ascii?Q?zLrA/CkALToEvqHBBZ8vIVKHQhlBSOl3EkGXTSQa2pMtMFnwsI62zDXjuro0?=
 =?us-ascii?Q?rvys6vrgfLUEoSB/F2NFq30x780f8/BxlhS0ZL5LgGnJEEUdLmGGjhvO1mTZ?=
 =?us-ascii?Q?IoPF3TpsdjHPnX3kaCkE2QXdSgX52dPj7jJ90EU/F8M90Ds6NSN464IYbD6o?=
 =?us-ascii?Q?HKXzhzr3vH5v/EI7TZwY43mjup174NnRRQB/pTeRjRoVX4lqrn8VylrKSgU5?=
 =?us-ascii?Q?hWy4tbXi24LsR/UoaxwAoKR6TXx/hR7xfDPipgsvKS/G+FfU/U2phSOAeHmv?=
 =?us-ascii?Q?EQhboGURjXtUXFyfMoMDRIveSLMRX/vcZnflb8yxqtsH+6P3/Th5WkHihnyX?=
 =?us-ascii?Q?Q370unfGRTkp2C+IxxuD7W0MYqTzqhIYabsHFRZzhY5knTmaFG4f9PX8CB7E?=
 =?us-ascii?Q?EoV0Lu4K6+wMn+odi4iWwPlkdrmaQDuv6FPSN9sjdo/Ge+yrvTkjfcuE3zBO?=
 =?us-ascii?Q?KjJylWk8HGfJ1EyBIikB3qtivgR/SqL+32Cx1mVEeoRDny/186ZqVuyLFG+I?=
 =?us-ascii?Q?gS7gKPEFc2TBRWUZZSmcP9Jv1WQq5esNq1SCVGFFIdMMqxm8/LwKa4lX1/+U?=
 =?us-ascii?Q?3xkYxw9hKydrogjczj3epQBmmgqI8tykRy3VQPZku8BBWvVtq/HyZ0HDio8U?=
 =?us-ascii?Q?qxCuT7RgrwgpoNS1PAKOm5pi9Q7HLbPyKes0V4BW1rbkUBvs3nCqFuNl0syp?=
 =?us-ascii?Q?AbkRuRaqM9UYsBb7nCD77pFOc7s4QKNkTQh8M5EJY7/vyBkizYseR5QOr+Yn?=
 =?us-ascii?Q?ke2V+8cF11bpYIfUh6AxouWSCj6w2pH+LEHmTxB+9PaHaqxJRXx/LnlLeCHc?=
 =?us-ascii?Q?i9ACEU55KDcMPAJJhV5jmCdBleofmINrV+6P7yZUMhuOFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6SPR01MB6.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwggQcFG8yvr6iII/ZBEg5j6OYOEcrEFrLOc8HdiAhq9Q3pe7DcDn8n+8QVa?=
 =?us-ascii?Q?zj7b6KuYm5BgNPw4FOQS2OwwabN2ufu/+PX5ZzQBsYVdEGIzQMJxjaSbOJ3g?=
 =?us-ascii?Q?04UUY6TkAlkSMFwT+w6xH6spuaQg33zFqR/r461FH0O+7L21pularXn/2osn?=
 =?us-ascii?Q?XWrh/Nx5wYi+Dlgh7Zlj/TQaoC83FlOnc/ZMPRZcFG8iz8VECc0aqthYkJ4Y?=
 =?us-ascii?Q?mMCF9PVwBxLHTYlVku3DrqbDqrllUntm+nwWSIwFM7GqnBqPVPqjg7ZhcEK9?=
 =?us-ascii?Q?xbATJYjQMT75RRGSj8s45U6rbD4fBECJI26OM16V/XygijEjDa0qVdv/XhYh?=
 =?us-ascii?Q?O6EELJ2DGrYnEWjSeXyJ9qFCUaFk2TnfHq3oW7UjdAoRLfIrDZ1xOPA9Si3j?=
 =?us-ascii?Q?u2HEsKC8IC4JkcU7vsdODZpl3mQzA5hAS3gUJb6c4fYOks8hNRRW1rZyKPCH?=
 =?us-ascii?Q?e8wCxvVNwpR9S9cy44O/eDEkSWwDMT16ANMefIse41dimm0AY+ISqs4E5wPV?=
 =?us-ascii?Q?TGo4ppOc8z8FmPE91+jCHMEPZlxcem//GnffFL6b3iKh4Vda0FNWXDYoNsIp?=
 =?us-ascii?Q?TebyQdNEnqyPiOaaKUU/i6HlBgRd5lRz9+CIOADyKBrXVL2aJf5uALw7IVwC?=
 =?us-ascii?Q?IlgiKIPR7x/jgerOjzfIjY+t62rRL9wWh2B38QvZxJAtHo82Y5SvaYRnU5P4?=
 =?us-ascii?Q?Q0NYzZj+zNANXMTfskRtSzzivxurPQohlCxgfv9yOAPEwOfiuI7FJEqv8NhR?=
 =?us-ascii?Q?6gqDKvU29WMmhPCr2Z1PzpKopk9ve3mp6OtVIHdLPUN7OFEmfR5mFDpuZyAS?=
 =?us-ascii?Q?K4QwIZXCXxjK9M6QRvwvD3TQogA+g9E1f4cr9PBIK7OmWTrV/zd/aSsnFGuD?=
 =?us-ascii?Q?OsPcsCILVW9BvE74TloBYci9paZv/0o8xUTEnWkfx0FQZEBXegbZv8ikaKtD?=
 =?us-ascii?Q?k7w4I/9E9BHSamOb/ltS0Qpmiq6UpNdOEM0ZFF5ox629DhnijzIiUOVpCsBt?=
 =?us-ascii?Q?iw+ufRUkIaqvJPfOV5YnAoA7pfgtbuUhXSeVI2qYq67bbTEDQGwd3bJZgos9?=
 =?us-ascii?Q?+5p6y++ZWiH25LRKaifwLjHaSkA7tihPgOTu4JhRV+ZXpbpnSgPb2y8+C8hj?=
 =?us-ascii?Q?csDlX+VNeRCqoUvUa/32S5ByzCJTki0N9ndVfpkVOHVLNiApGyeXAHaZO9M9?=
 =?us-ascii?Q?k8kNHiSpqS19WFKObJZLh1lQsFGkgMENulpyu5IMwKOorkYdOmu0Vl/SKNkE?=
 =?us-ascii?Q?rv0yv7LKgUlsXrq8wHwn9az7AEKy63lv8q0amxQ24pYe2rx01rFX6W28bqUZ?=
 =?us-ascii?Q?xwaiiqTzUvU5lS2JaiRV3hgRpACq8kzg/oNygB3vt4Q1keYCyyg2fIMGH8rF?=
 =?us-ascii?Q?yqupK3WMONyHnREswpZ9MAsfe6qDTM1iChvTVrq2BSPLjwIQotkL9LIWYGnG?=
 =?us-ascii?Q?yUQkYy4mgB9HmRd8LKn/jJewnlqWYyFuv4uWMmB/U7wVquEdDgTHxQzIiJpU?=
 =?us-ascii?Q?io4EqZnvbwhUTRgh/l1AhzbqLXt7FWl/9LfjJtQqy5WKoc45Gu7DYNs/5+TS?=
 =?us-ascii?Q?O+9c5EcI1PN8xzaNCoNOhqy8IITaVt9+GnI2QtfaGRd2Z4OZrY2Re7/Ij+cl?=
 =?us-ascii?Q?FTpTC8SOmCmu4JgzC6uJ2as=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ad9b60-643b-42ce-a324-08dcde81ec93
X-MS-Exchange-CrossTenant-AuthSource: DM6SPR01MB6.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 23:21:18.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndl9858LaycDe8XMwZydWbGiGwB6Z2bbBZHVbJdDt70iLlwAORXfrZkr8RZSmxaPAnCopE6aPm1j5BIYN7GlQU8JVPwvMMmRLBnRmGjNCcAYZRnkfY4inSgjumv4jjsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6720

On Thu, Sep 26, 2024 at 12:34:01PM GMT, Beata Michalska wrote:
>On Tue, Sep 17, 2024 at 05:41:09PM +0530, Sumit Gupta wrote:
>> Hi Beata,
>Hi Sumit,
>>
>> Thank you for the patches.
>Thank you for having a look at those.
>>
>> On 13/09/24 18:59, Beata Michalska wrote:
>> > External email: Use caution opening links or attachments
>> >
>> >
>> > With the Frequency Invariance Engine (FIE) being already wired up with
>> > sched tick and making use of relevant (core counter and constant
>> > counter) AMU counters, getting the average frequency for a given CPU,
>> > can be achieved by utilizing the frequency scale factor which reflects
>> > an average CPU frequency for the last tick period length.
>> >
>> > The solution is partially based on APERF/MPERF implementation of
>> > arch_freq_get_on_cpu.
>> >
>> > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>> > ---
>> >   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
>> >   1 file changed, 99 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> > index cb180684d10d..22e510733336 100644
>> > --- a/arch/arm64/kernel/topology.c
>> > +++ b/arch/arm64/kernel/topology.c
>> > @@ -17,6 +17,7 @@
>> >   #include <linux/cpufreq.h>
>> >   #include <linux/init.h>
>> >   #include <linux/percpu.h>
>> > +#include <linux/sched/isolation.h>
>> >
>> >   #include <asm/cpu.h>
>> >   #include <asm/cputype.h>
>> > @@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
>> >    * initialized.
>> >    */
>> >   static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
>> > -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>> > -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>> >   static cpumask_var_t amu_fie_cpus;
>> >
>> > +struct amu_cntr_sample {
>> > +       u64             arch_const_cycles_prev;
>> > +       u64             arch_core_cycles_prev;
>> > +       unsigned long   last_scale_update;
>> > +};
>> > +
>> > +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
>> > +
>> >   void update_freq_counters_refs(void)
>> >   {
>> > -       this_cpu_write(arch_core_cycles_prev, read_corecnt());
>> > -       this_cpu_write(arch_const_cycles_prev, read_constcnt());
>> > +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
>> > +
>> > +       amu_sample->arch_core_cycles_prev = read_corecnt();
>> > +       amu_sample->arch_const_cycles_prev = read_constcnt();
>> >   }
>> >
>> >   static inline bool freq_counters_valid(int cpu)
>> >   {
>> > +       struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>> > +
>> >          if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
>> >                  return false;
>> >
>> > @@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
>> >                  return false;
>> >          }
>> >
>> > -       if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
>> > -                    !per_cpu(arch_core_cycles_prev, cpu))) {
>> > +       if (unlikely(!amu_sample->arch_const_cycles_prev ||
>> > +                    !amu_sample->arch_core_cycles_prev)) {
>> >                  pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
>> >                  return false;
>> >          }
>> > @@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
>> >
>> >   static void amu_scale_freq_tick(void)
>> >   {
>> > +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
>> >          u64 prev_core_cnt, prev_const_cnt;
>> >          u64 core_cnt, const_cnt, scale;
>> >
>> > -       prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
>> > -       prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
>> > +       prev_const_cnt = amu_sample->arch_const_cycles_prev;
>> > +       prev_core_cnt = amu_sample->arch_core_cycles_prev;
>> >
>> >          update_freq_counters_refs();
>> >
>> > -       const_cnt = this_cpu_read(arch_const_cycles_prev);
>> > -       core_cnt = this_cpu_read(arch_core_cycles_prev);
>> > +       const_cnt = amu_sample->arch_const_cycles_prev;
>> > +       core_cnt = amu_sample->arch_core_cycles_prev;
>> >
>> > +       /*
>> > +        * This should not happen unless the AMUs have been reset and the
>> > +        * counter values have not been restored - unlikely
>> > +        */
>> >          if (unlikely(core_cnt <= prev_core_cnt ||
>> >                       const_cnt <= prev_const_cnt))
>> >                  return;
>> > @@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
>> >
>> >          scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>> >          this_cpu_write(arch_freq_scale, (unsigned long)scale);
>> > +
>> > +       amu_sample->last_scale_update = jiffies;
>> >   }
>> >
>> >   static struct scale_freq_data amu_sfd = {
>> > @@ -189,6 +207,77 @@ static struct scale_freq_data amu_sfd = {
>> >          .set_freq_scale = amu_scale_freq_tick,
>> >   };
>> >
>> > +static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
>> > +{
>> > +       return cpumask_available(amu_fie_cpus) &&
>> > +               cpumask_test_cpu(cpu, amu_fie_cpus);
>> > +}
>> > +
>> > +#define AMU_SAMPLE_EXP_MS      20
>> > +
>> > +int arch_freq_avg_get_on_cpu(int cpu)
>> > +{
>> > +       struct amu_cntr_sample *amu_sample;
>> > +       unsigned int start_cpu = cpu;
>> > +       unsigned long last_update;
>> > +       unsigned int freq = 0;
>> > +       u64 scale;
>> > +
>> > +       if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>> > +               return -EOPNOTSUPP;
>> > +
>> > +retry:
>> > +       amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>> > +
>> > +       last_update = amu_sample->last_scale_update;
>> > +
>> > +       /*
>> > +        * For those CPUs that are in full dynticks mode, and those that have
>> 'or those' to match with if condition?
>Yeah, might be.
>>
>> > +        * not seen tick for a while, try an alternative source for the counters
>> > +        * (and thus freq scale), if available, for given policy: this boils
>> > +        * down to identifying an active cpu within the same freq domain, if any.
>> > +        */
>> > +       if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
>> > +           time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>> > +               struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>> > +               int ref_cpu = cpu;
>> > +
>> > +               if (!policy)
>> > +                       return 0;
>> > +
>>
>> We can skip the rest of code if policy has a single cpu. AFAIR, one of the
>> previous versions had similar check.
>>
>>       if (!policy_is_shared(policy)) {
>>               cpufreq_cpu_put(policy);
>>               goto freq_comput;
>>       }
>True, we could but then this case is covered by cpumask_next_wrap
>which for single-cpu policies will render the ref_cpu invalid,
>so policy_is_shared check seemed unnecessary.
>>
>> > +               if (!cpumask_intersects(policy->related_cpus,
>> > +                                       housekeeping_cpumask(HK_TYPE_TICK))) {
>> > +                       cpufreq_cpu_put(policy);
>> > +                       return -EOPNOTSUPP;
>> > +               }
>> > +
>> > +
>> > +               do {
>> > +                       ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
>> > +                                                   start_cpu, false);
>> > +
>> > +               } while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
>> > +
>> > +               cpufreq_cpu_put(policy);
>> > +
>> > +               if (ref_cpu >= nr_cpu_ids)
>> > +                       /* No alternative to pull info from */
>> > +                       return 0;
>> > +
>>
>> The 'cpuinfo_avg_freq' node gives 'unknown' value for single CPU per policy
>> as 'ref_cpu' increments to 'nr_cpu_ids'. We can use the same CPU instead of
>> returning zero if no alternative CPU.
>>
>>   # cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_avg_freq
>>   <unknown>
>>
>>   ----
>>       if (ref_cpu >= nr_cpu_ids)
>>           /* Use same CPU if no alternative to pull info from */
>>           goto freq_comput;
>>
>>     ..
>>   freq_comput:
>>     scale = arch_scale_freq_capacity(cpu);
>>     freq = scale * arch_scale_freq_ref(cpu);
>>   ----
>>
>This boils down to the question what that function, and the information it
>provides, represent really. The 'unknown' here simply says the CPU has been idle
>for a while and as such the frequency data is a bit stale and it does not
>represent the average freq the CPU is actually running at anymore, which is
>the intention here really. Or, that the given CPU is a non-housekeeping one.
>Either way I believe this is a useful information, instead of providing
>stale data with no indication on whether the frequency is really the 'current'
>one or not.
>
>If that is somehow undesirable we can discuss this further, though I'd rather
>avoid exposing an interface where the feedback provided is open to
>interpretation at all times.

Would it make sense to identify that the frequency reporting is unknown due to
cpu being idle vs some other issue like being a non-housekeeping CPU? Would
returning a value of 0 make it easier for tools to represent that the CPU is
currently idle?

Thanks,
Vanshidhar

>
>---
>Best Regards
>Beata
>> Thank you,
>> Sumit Gupta
>>
>> P.S. Will be on afk for next 2 weeks with no access to email. Please expect
>> a delay in response.
>>
>> > +               cpu = ref_cpu;
>> > +               goto retry;
>> > +       }
>> > +       /*
>> > +        * Reversed computation to the one used to determine
>> > +        * the arch_freq_scale value
>> > +        * (see amu_scale_freq_tick for details)
>> > +        */
>> > +       scale = arch_scale_freq_capacity(cpu);
>> > +       freq = scale * arch_scale_freq_ref(cpu);
>> > +       freq >>= SCHED_CAPACITY_SHIFT;
>> > +       return freq;
>> > +}
>> > +
>>
>> >   static void amu_fie_setup(const struct cpumask *cpus)
>> >   {
>> >          int cpu;
>> > --
>> > 2.25.1
>> >

