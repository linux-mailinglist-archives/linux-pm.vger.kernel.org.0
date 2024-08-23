Return-Path: <linux-pm+bounces-12788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B895C416
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 06:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE24283D77
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AAE3BBC2;
	Fri, 23 Aug 2024 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p/Yuhp1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30620DF4;
	Fri, 23 Aug 2024 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724386413; cv=fail; b=EF+j/EkPqk0rwmf5pawrXlYTrZTR1kxq8TezOO4HHyZXx6C4x9h/72hIb5RC5J8z3lSRPKsDW7q0FcTH9azDsaPCGipg4HxXBmgF8sqNUIrCUM90ULt6GJzBnvTUPKqetnLDekmtAjXA1GucOM0FkFo1QNCJ4YErty2ZMkiRwng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724386413; c=relaxed/simple;
	bh=yHeFpLKV6avdr4WDXqCTRop0xGcTBHLbxOKzKe7PxCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i396EDtjXZZUKuXWKIM+FsmxGWMLWRTPQ0JY+eM1IH8zwiSO4EV/na+4dS6yxYB55qjfIu5PPNcgwwWJZVd/o6Jh0pJKyXUoOg88Qx0RfDlD8d+XJYnM9s0iRckpF18HsgXzaj7K8XRDogBuHIkIt1dCzbemAtNmkUTU7PB2V3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p/Yuhp1u; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbWqQT4530dOytpfJGamF+d9uhhfVA0sSSQXZmg5roGzqO/U6XWHBkoiaalFEeYLPAQFoC+V0RHwQ9kNHPgvW05YFz8WN6cw9emADdQ4qOT7LjHNBFB45oW0BfBiCzD91ZfTfizcXPCea8ag2G1EMCbXMqCMSfnY6mUUQyABKvdF8uE0Wme7UoQ19LDexkJpdTv5Acs5dcyNnU6x0JNbLsBxqrTShn/FBMd+VfqQ20u+X+vi1PnxLjLqoHJBOkOwUgMfrjxU7pGFy6Hy3hAVt4WGDGxBE/FXl+dFMtE6x2K3nJXu8SzhKzSO6UPTMGC26glx07u0MwhrYd/A3xpEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1X2XcVGbxFepsm2bqWOcBqhdYjZPb2r/ShjTJaqWvI=;
 b=L7Oc+Hp9cJwL669TdzovLJzI0NNZo/A+oCHXYhnfxxO8T35IpWOhW2nMAf4fE/5ctgf20KWiKEtQNdBadYP24PzuRQQQ/vJu8zf9WZrIQPgdeC2fulmaoYqh+qUB4vJAYcWf33OntWewrUkVcSqgmc7ZTMyQt0R10GBRgEGomJfYdhMJCzUHMK9Gpfp8v76kSVBAlfwusGubpnMMA7TPQIG5E/8hFbXsi9nERemOwzLPEGNSr7HqWtntoydHrHAr7iFA92hui3c/lozJGx9KCmdxwRnHtjvtsAV0g9veNFCJ3nXU60U1EYA1rPKIGHlqLE5egJWKzkXzPc/wBJDnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1X2XcVGbxFepsm2bqWOcBqhdYjZPb2r/ShjTJaqWvI=;
 b=p/Yuhp1uDaiyKoqPfjYvra7b1Lj19YbVnty3WeX06K5q9pG4Y6+0aRADfOa/O3ivu3CmZ8c2oGq92rgAlibN8GT2GVqiLk48g8eNsFzuIlhngctIysqz7rFrzFdQMrs1NwGCv4CNdWnrrBU1B/1bz8p1HVYI0qS4ib4sNKg2gxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 23 Aug 2024 04:13:29 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:13:29 +0000
Date: Fri, 23 Aug 2024 09:43:18 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 0/3] cpufreq/amd-pstate: A set of fixes
Message-ID: <ZsgMXv3sQgcw3aNl@BLRRASHENOY1.amd.com>
References: <20240813095115.2078-1-gautham.shenoy@amd.com>
 <e53159a9-3451-4255-8fa0-bb9aeee09fce@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53159a9-3451-4255-8fa0-bb9aeee09fce@amd.com>
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: df1dcd93-802d-4023-ac7b-08dcc329f15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ByaaeKMQ9LLt1Wn80XG6TiOSDC4Xm2eQ000O21nLRhphzY6Lw3SqRARDLJV?=
 =?us-ascii?Q?09ZWlFyCWQxN26Cc5xeYZVKNXaGTj/emIX4bczX/4du+4C/RhYCBF11Qxbat?=
 =?us-ascii?Q?oZ2x5ZcJ33DRtbE5DZ41+6FujyzrKMeAbjWP8kg+WxEaqpjIZMXvnpXZnY4+?=
 =?us-ascii?Q?zFsy3D5ujKxLQn7ifTcUuCzFPW0BFCOgPhRGXC+FhRFaGZpMXpxOaFIVZ4Al?=
 =?us-ascii?Q?/tDjNUHRq93wZCYiO63rOQpTp4KesKJ12v0J+tiDvG89U/Xf5Siw8gYnriap?=
 =?us-ascii?Q?QezeJGVAFGE/Z5E2knIGXzapM/qlTNGzt4dlxBAVpqzgV1mt5vwDz+s34Nuz?=
 =?us-ascii?Q?Aat0KN8+ceyNWQ/mH6AAnjYkRHGdNFu0TD5ALgp3kEGnzxNFKjIlBEl8wnRJ?=
 =?us-ascii?Q?eQzET3jl/4O4/BNnZZImaSBu/q88vuR+wCjdV3d/oNlceaJyEjkvfAKUYMnl?=
 =?us-ascii?Q?foVLjLU8AsFJTqCmv8haS7SW0+yQoO60nGPgtGTYsF/6BW6GK3Pwy8o2L9vB?=
 =?us-ascii?Q?tk8N3y2Ux3dMkIssXafSGHgAUMA/xiny6cqABsgMEH4nXR45LzLndP8qmVo4?=
 =?us-ascii?Q?iY6agxDtrgQXAusQVqwb+WwsAwJcIm9kzm85ZK2p02pukEhpvaq1VziHmbG/?=
 =?us-ascii?Q?M4rg4yOjc2c0RsbTncDSiowKnTWi6LjKHDtfWAajvlCU3d/bGI9/mcnuzhda?=
 =?us-ascii?Q?1rt3P6Sti7rKjdkobQIlmLGStRarQfHKCoSEsG+ZosrRr99Iwy8n6+xAs3QT?=
 =?us-ascii?Q?oiKK517QzIX4V5BOyVCmp0+PkckWejiOpNDsaWuQ58VzB5EvtWlxYc3oxNLl?=
 =?us-ascii?Q?O2kFH7z56gC3fNV941Own8YLo5KjpiULwgdXnpmF51Idj692gmpCtpFF885O?=
 =?us-ascii?Q?DKNElQk1ztN3v037wdf1rJheb6EpHMehgC/wXw4eXyJJ6Wvrwz/csd6laNHC?=
 =?us-ascii?Q?s+EClIZiJlG16Fh8oRpzdGlcDY3YNGvM4vZmMk/np5UprIPpxCRK43TSkotB?=
 =?us-ascii?Q?QiVmpxt9nZfw4kBlh6L6Tce4TuGeuS+jDyvtezCj8vXU/YbriFp6OCoF7vZC?=
 =?us-ascii?Q?CudqQHTAVqpcTPob+TnfbvhVDnV+8rb5MhDE94hyAiHZgXJ7yjeQHsm1IS9a?=
 =?us-ascii?Q?o0QqjfjSnkfZMsPeaq3QfxWZxTa59wnHrmKezZaV1/lrsgBU3GzGu9pwkbjT?=
 =?us-ascii?Q?JL8SDT8zd1S9hU7fCWRtwIEYeEQgvwJEwLB2oWjEu7nIpINx8+P+AwuHj5z+?=
 =?us-ascii?Q?+UQDHkWY3EoAN1VUu1MawajjyhYvSTGdLnsVvpwUpW85eNutoySTqDNOcHm4?=
 =?us-ascii?Q?2XyIjRlMxNYnwETHDqeXlvEy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUfb1vFZaKIH3PWLptwaVntGn6Di0MlEzTaYj6uJcmyf2psaCLe6YfUueMZm?=
 =?us-ascii?Q?RZXtRx764dH86q3a+wB236jaCiP/k3XzVlEj3xixIixhpuv3qqGiArXVRfbX?=
 =?us-ascii?Q?j+ksGliDWTByuTHtRXG0RpKi0hxfvlsYh51SjuFzW+ArTcNAXLRh1xGBWC7W?=
 =?us-ascii?Q?vanomrpONHdY+pvSAYHLu06WhjxmqQSZxMdij47GUY3RWSGpdTlzCex6wdsM?=
 =?us-ascii?Q?OSUUfWxU2zo+akhv17XAwzIbMfA6oh7B6mDsPoOVJLzkGEMDEGON51NMLSOf?=
 =?us-ascii?Q?Ta4bMWbyz1I5TJl4frQYpWly78GTpyM++cMZRFCMhw2LmGMNclybFb4IbWH/?=
 =?us-ascii?Q?KEa1eaSFi5/1pCRlYJfUAUrBLCrtc5pedsr2ZMz8SIkNCwv8GNAN5//N+U8o?=
 =?us-ascii?Q?bsIL6OhB//XHpxX/frGvKQw157URAOeRi04wup5ym+cBITk7G7DVZZdHWW+v?=
 =?us-ascii?Q?rQZJf8aclIId11qv0ik8NTrUY68R57/RLozJ5dKAHJSChfNj2au9c2QwQM8g?=
 =?us-ascii?Q?SX3Pipsx8MZ2mqRZfeDChFqKEHZmXDq5XHh8YCO61JdJ7p7o9lUCwxy1Zlaf?=
 =?us-ascii?Q?wTRJBrJIHqNecXteR+W1UvYE/Y0J1DTVf/t52OgpUcCtH0jw/oGNI5aYkjuH?=
 =?us-ascii?Q?ESo1LkPGA0DLtuNCbyZOtUZaXw+e6qeiDdUUcXLQ4KnR9xTsoSHnUMaWj6Wn?=
 =?us-ascii?Q?Lru9Jhz/KDYtZou+Gd5vLapi2N0AeheIqFYGwjDdKjCLuizGvCEViQqr/jWY?=
 =?us-ascii?Q?wwMeTKP/fpdN9Mrz+SXKWR9jhldDJH3p4wMKAPDmF3/flfH+m8v5SWcPxfJy?=
 =?us-ascii?Q?aJ/tzGLKqu05Dbz9/lF0CVro6ZD+En0fU0hKTIQ0z7AnSkZqBigUYUHY8uCD?=
 =?us-ascii?Q?ZOsuUhLU7FWuADTMNd2pcuGGrfaZnAUe8gKMloqaYnFx/SEnFc7niD6oh5G6?=
 =?us-ascii?Q?XlkPRfDkDU/CB9S35xSh7TlObdTAGmZanRsVT27mUdCTGPnhTCONMdGOKsPQ?=
 =?us-ascii?Q?eVnPo4aoQ4RPOUQqURNFFjxVJAR4BaJipRf/sblnpOZ0o0g2XIr6dl6Wg85H?=
 =?us-ascii?Q?f5LpFKypZQofxL6YTYCnet/luIBsLWdgGHf2szULjdA4PSqNlCwJG7Fo7MpD?=
 =?us-ascii?Q?lySK3gu0A1i78v2ieZv5+LYvqLoukl2rFHuifa3fTaImnzN88z1+SdYMz/j7?=
 =?us-ascii?Q?g6SqFLmbtgr0NV+SK+okzpqlpec5n7zU2aMDh63eSohBz66SVCbmEGdyof93?=
 =?us-ascii?Q?/D3sZYEzppvleqJHKX+P11DCCbnp13tuwA1pGq3KcOZnLSGc1B8F9Xl1awUP?=
 =?us-ascii?Q?kus6oybBmKAd8WUygFbpFr+BOS4GxQsQNH5GE3F+7artx4/zwyHGpoY2S93O?=
 =?us-ascii?Q?HnNBNbMIAHyuLtxYAApew5m/y/XUI8T16OYV6qWJQUYD/d2yBcgV1FjKwBZy?=
 =?us-ascii?Q?KBoWxUpfEj8YQPcQBvJp4wjcZVOBp7z+pdnpqqkomcvaojuNVRQt/6PudFT/?=
 =?us-ascii?Q?an+WzkLhV6AHRLNj6R9tMf70auAHmnbHEYvcTqscOIJY/XWTqyoNj5Z61NNa?=
 =?us-ascii?Q?X2+q3VAPR8sxTWi5E5nTJFf8nULJGyuMze/0D6iy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1dcd93-802d-4023-ac7b-08dcc329f15f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:13:29.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dilSrcUB++oUrfMogzqDDY8zyGwComNN0Tbslj88sb6EJq/SkgrQvJZh6y0ZlI+wL6fQuZnC2fvJJCxyeSAuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

Hello Mario,


On Thu, Aug 22, 2024 at 03:41:30PM -0500, Mario Limonciello wrote:
> On 8/13/2024 04:51, Gautham R. Shenoy wrote:
> > Hello Rafael, Viresh,
> > 
> > This series contains three fixes for the amd-pstate driver for 6.11.
> > Could you please include it in your tree?
> > 
> > These patches are based on linux-pm/master with the top commit
> > 7c626ce4bae1 ("Linux 6.11-rc3").
> > 
> > There are three patches,
> > 
> > 1. To fix an uninitialized variable in amd_pstate_cpu_boost_update()
> >     from Dan Carpenter:
> >     https://lore.kernel.org/lkml/7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain/
> > 
> > 2. Use topology_logical_package_id() instead of
> >     topology_logical_die_id() definition of the later function has
> >     changed on some AMD processors since the inclusion of the CPUID
> >     0x80000026 parser:
> >     https://lore.kernel.org/lkml/20240801124509.3650-1-Dhananjay.Ugwekar@amd.com/
> > 
> > 3. Remove a warning for the absence fo X86_FEATURE_CPPC on Zen1 and
> >     Zen2 since they don't have the feature defined. This fixes the
> >     regression reported by David Wang:
> >     https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/

> > 
> > Thanks and Regards
> > gautham.
> > 
> > Dan Carpenter (1):
> >    cpufreq: amd-pstate: Fix uninitialized variable in
> >      amd_pstate_cpu_boost_update()
> > 
> > Gautham R. Shenoy (2):
> >    cpufreq/amd-pstate: Use topology_logical_package_id() instead of
> >      logical_die_id()
> >    cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on Zen1 and
> >      Zen2
> > 
> >   drivers/cpufreq/amd-pstate.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> 
> Thanks for handling these.  I'm back now, I'm digging through my inbox.
> Assuming Rafael didn't already pull these I'll batch these into my
> amd-pstate branch for the robots to bang on and then send a PR after I go
> through everything else that happened.

Thank you Mario. I will be sending an updated version to Patch 3
"Remove warning for X86_FEATURE_CPPC on Zen1 and Zen2" to incorporate
feedback from Xiaojian.

Please merge the Patches 1 and 2 from this series.

--
Thanks and Regards
gautham.

