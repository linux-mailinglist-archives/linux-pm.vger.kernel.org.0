Return-Path: <linux-pm+bounces-12600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54344959435
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2C91F22288
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 05:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF37166F28;
	Wed, 21 Aug 2024 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aE6v5/IL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD061547CB;
	Wed, 21 Aug 2024 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218908; cv=fail; b=tdBncG7igumOQMceB3EU1SYGDN6zH8cADQHgyMyFjH9G9Tjf0xnZLehguDl0dSCg3a2fboXmwxNNRiC5SSRmwTORMS+8ErSHj59vLba6pTn36JMfMR/YE81g0z3JeNEyu6wbCwSswUPkGZ52JjvnOWn0cgeTnHUGjPoZ7MRF//M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218908; c=relaxed/simple;
	bh=jvMSAMAdSheznXb/K4X8oWIQK09olZFngUgSf8DmmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eeTawC/GvnYU4sAfpkqOV9VovqPZ6WHpMt6Xu6N1q1cS/4WY97ZgKdJML5QJHo2xagQDAjUfy4bgnl0gQKj0wir2ZpglimSkVfu3eBVlUV3F3wNZnhxL13zFicRFQT7pdjBgYsdUhPHAL3rsAkswq9OmSLwWMuO1JNrPP7Oxhzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aE6v5/IL; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVFnhhShWxetlX9sLl9+j45x5Y0ErgY+pO9/C3+6zBBjKzyvdRzHnR4CPXlIJZXKa/bYtk/GUj9Yh5+2ZmhI1AOFmjVJNDuRc7y0oYq73YzE8OTHlrbnjD/WzkLSNZIq/eAjap9LeNeF+2wc5+kyft8VNi2ymS4pkfz+clGkZ8cFfeyqRM+I/TKccpLvz7hS9C+9hArtvVN9lgJ4pF/2rhR0xmqIfWq8ilzCsu/cmub66avchd5k6+nxSbPO6msDV7pwIVeDX9aCDzxOAZZlFtxHIG8eKLDTZ7OSgLr7fMQAMkbLS50zr/JO4aEnBJe/jzKPEAYuOwTV5x0jVLfaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpu1jWovat4uHhYEUOB2DtoraGMnVgqBJAwB4v4OUnE=;
 b=FCU1eWnmry/LlfXcnwD3kEL0lCE/9y2r6GGQ02ko//WR9JedtJwCSpXO0rh6NncEbDxxiomgNG5cWaDERbwq2V+uZiQRihhKvFkrIuYgF3a4HgaWnOkDpiU3EOFD6ZPaNcEtBUFcWKN2rQwYKrxJaX6pmwNlH5EnNkHrvZ0Bj+7mvaFIZx1BGde6wDGLVjDWBbGd6MfHvvlOjg/7Dni1vn6gbf0vT3svXyOKnpuEC+9VmS3Z0zloxVgj6XmZ2YKvtMCVEQ0Jo0bVWezh83b9B1S50oNu+RStPNz6EJqiKkR74uxKrf7TdNkMO5GNThg7IMwRZgwI3q3lJPY6HQhj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpu1jWovat4uHhYEUOB2DtoraGMnVgqBJAwB4v4OUnE=;
 b=aE6v5/IL+jEHdNoEamENgLuclqCLfCpZYdUP6P3NxWMfjp4tthdcRJStYZIs8iRMRmvQLkE0OXcWD0T+X33oGtLpjTUiJcVGSnvW8od2t4qwAjIw3lyOnOyC2Ffuh3K1GI7bggEYBSYNVb0oxlFnYXvnA5vk85qummzSGWNY3xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 05:41:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 05:41:44 +0000
Date: Wed, 21 Aug 2024 11:11:32 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Xiaojian Du <xiaojidu@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 3/3] cpufreq/amd-pstate: Remove warning for
 X86_FEATURE_CPPC on Zen1 and Zen2
Message-ID: <ZsV+DI4IxQCSTWGY@BLRRASHENOY1.amd.com>
References: <20240813095115.2078-3-gautham.shenoy@amd.com>
 <20240813095459.2122-1-gautham.shenoy@amd.com>
 <9ca4054e-a130-b65b-d2f3-3ef84c997dfd@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca4054e-a130-b65b-d2f3-3ef84c997dfd@amd.com>
X-ClientProxiedBy: PN2PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 4434dfa2-fee5-42be-3170-08dcc1a3f0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vC81a88PIW5463Vz0vhNRCJd4TejqpAty2j1LooORRy1cumD+zO2MJDFiOZr?=
 =?us-ascii?Q?1lAC8SvrCDQ7pXnDdwuCfH14CbdVonWl2ZlqfZhuxOrNwE0CfzznliCzNJeb?=
 =?us-ascii?Q?4KMJ1BMfNL+wI1lhLgqBN/1iWFdsO8rueeNvWKKFwdQ/0hhPH2FLJuPWy5Ub?=
 =?us-ascii?Q?nFRn1GH/d27rUXIEuxfKkfxFKbgn+ddq468BWIe5onHU8bA7zMvrJaQRl1Ay?=
 =?us-ascii?Q?S+sXJjdHbNFzjevECEI+IAOBBM384VB2k63WBcMygD2da1luiCqEDyf8c+sn?=
 =?us-ascii?Q?yZFzaGXSOjL6bx9ubGxqC4vvS3mfARkFKWBQ4KTRgqgqLrDhyinglVVGYHRI?=
 =?us-ascii?Q?zJ8FysIMUD6JbFSIqPc6bB5HXhx+/QKQP6tGI0gsGEwa1OmTEQR625o6Jz7G?=
 =?us-ascii?Q?gtFwa+33mnHw7Oo25JiEhigyWevGHX0N+9ZoTAm181VMTSxLb9zl/o0Iy60E?=
 =?us-ascii?Q?76XcJ/I5DL7XJXNWIT0spsvBpYRRV3tSeb17mOHDepHrRP6xi+ZX8QLD6h4e?=
 =?us-ascii?Q?ZG9BccRQZ1I1Q4tQ3VsSbHpLuK/hCufcoNeLeRsHIOu3Q7phoUPyRNyECYnu?=
 =?us-ascii?Q?O0cguubFWcdZAkN4W3SiLDTQSlw6S2/uVcxLXPayp6ekYUQ+9K0MrfvzvX2v?=
 =?us-ascii?Q?Dxn0Oo6NFJ/JykJ9LQVsoOS7HEiUyGTxEjPXJuWDblk2CBEXwpeeio42orJY?=
 =?us-ascii?Q?Y7CA6s9ddRhn8SEvehCZhYZ4R8f7RkCfSVVvTZZRYD6I71xn1n2mWZRB/CZ5?=
 =?us-ascii?Q?9xg7x41i4ktCvTxcgyf6CIWPgG/wYM8n/XXaT5AtML7juylhA8O7mdzm0DoI?=
 =?us-ascii?Q?FNiGwrRwDlGg4cOzgZYC8ZujRTKzRjyO7LjEoLubsIj/sEVewlDXlshqM44C?=
 =?us-ascii?Q?ktUR8hCCmAUDqGu5NPqXGqnx9O1sHRvw4zxlmZbnc8akAY1Q/3F90arilAQT?=
 =?us-ascii?Q?e3MnTVxpLUYT7Ebj87m/fV6NllvwIVIeZ91mKIAxC4CTkOU15QhqLftowGwW?=
 =?us-ascii?Q?kucXJRZtwZ8rySeFHO7vw8SZaXeVfF819lcTfA+Vjf7/oiOUKMK3Kq6jnN/y?=
 =?us-ascii?Q?y+PGirkzA/ks3mRcqFxBQn+Hxjdc7Tu7iHz45NuHqWxyJQlgppW/A7JpYcUd?=
 =?us-ascii?Q?5YnfZHuh2zBol9hE89pNv4+C34PhfNJvULgznEOJqVSSEYpGAloKLB+VYPly?=
 =?us-ascii?Q?yShti0xYeSBRYcB9/q1NdHuk3J5SkSvDE7kAv9kPgm6zbFvXySceqAUdOfCt?=
 =?us-ascii?Q?1YP+Zv0Dt4+xqFCydPqqlJEpKQpVlepqPTw1GZiEMLbKgWkiKiACUfRZxS8r?=
 =?us-ascii?Q?KZ2AdR/uySpxCab3KyPWSms9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6sfgG0+NtNhsyuoV3Cgr3wXhPMuMvphcUA81sk8/DL1lmCmLEC3sNDwY6Ufj?=
 =?us-ascii?Q?yOBoY95pMtm3XjvYbyaWEf/dWhXcXfDTxHlTRbYDw2y07FDmSGaz/AKRu9Bv?=
 =?us-ascii?Q?Rtnr/X4Zv6Ybb2oRUXIh1n90ZvOuL4HiYrn60/oo8MSqTvSFZy6T1mzbtL+g?=
 =?us-ascii?Q?E/TsfPJoBEhGE6V7CxE5m9qXttGP3DSVqxL/5adMyMQC6kmOv3kzFRPmEth1?=
 =?us-ascii?Q?xxNKcCdWU5s23l30lyDeBk7UhXG0v3mqJcmWU4nM60aZInBW504l+SO3sgia?=
 =?us-ascii?Q?qSS/aeTG9Jeb6JK6JZxcFkmMEJehak0CDyIKNOWggYUg8xd7akQiU5HsrBTG?=
 =?us-ascii?Q?kE9Nj4qVn//Exw1SmZ2ibwlJv6EIQv0DsLzMlLwstZhxpXuQUmCu5yMdHnMm?=
 =?us-ascii?Q?UeP+vYB3Rdhs3ZVUCKVppFz/BN6mFny0E3DANidd8WRyueIrJfWNd1iVELLB?=
 =?us-ascii?Q?Azv/g9VMuHkN67dFfY9qf4xUd6HxfBPFrPQAA4BQBgVQlAPQ5IKAenN12Arx?=
 =?us-ascii?Q?VRgEKhXkB9vkOyspDo7zmB5lzhdEDFWHepKVL/vrwMY8OfSYk+xG4Qc03DDq?=
 =?us-ascii?Q?1tqGHOQVkI/gmop4JYxlNNEjLg3dZc9P3T2DY7g90ynQQt0AInmem1KWJA0Q?=
 =?us-ascii?Q?YTLvr+A80kDD6n69joZlAklIZQpV0Nt59pOpwbRjIPdAXP//oim+1gKgpEZI?=
 =?us-ascii?Q?g17vgkuZKPXnYmZb1DKAMPuJFlS/iUHtIIlBj8EXQm2Yo9b7+EVB9r+OZUlQ?=
 =?us-ascii?Q?oGqsJH/gzQR2ZCQyVdTronWbnVuKFNdAT7iJPzKd9U5PdBUoruqhloBvS6Xq?=
 =?us-ascii?Q?Dq+o/j4HllTD+1jSjuTTutLsBozxKpslxXzDvsx7Bh8SESlidGv7UmJelb6s?=
 =?us-ascii?Q?a048ozbftSHLD5DK0FkGaxJnFNnT74jE+cpyLz9urf0q01jc3w/uV7/g++o/?=
 =?us-ascii?Q?ujaLE+8Mn8WFTNnYcsR98cgolY5JuyZ6IFGTXt+grpqyMcnaYPhU7qw0QfoF?=
 =?us-ascii?Q?MiJuSgUsMqsXHqL4Xsa+x+Nfrjgj2OLkYeZ7irtMhVhoKZyld19nQvKMwDTd?=
 =?us-ascii?Q?y22k+bpZUL1C9jpUe7G3u4ZLi3miV4vBhzfeb1suD/RSS8Xni+twZe7pqjI/?=
 =?us-ascii?Q?kh3BYx1695i/moO6m1C5hboHYVUr1HpVonelvxrtHWKfzTJkwpGALo1oF002?=
 =?us-ascii?Q?Y03Rc3WlUhj8jmCY3Q8tSxKcmdDYZWVa3duqIfnCT6HMMJrZZsWdY2y83dBq?=
 =?us-ascii?Q?SKQdY5YF3OU+oiA2AJkPyRw9tuMTFD+CBWe9F8ztOTZ+Am0s6K/VTTnGq0Ws?=
 =?us-ascii?Q?5hY2wjWi01t6HoEAsE/azXpty3S1wOFUo6k092rNQ2kIEX6ODOFijL1P3/bP?=
 =?us-ascii?Q?xtitRPLxLnnxffqlvEj6MarHAAL8XBAea59b84tFEezodiPLsOiwLYm8Yjh8?=
 =?us-ascii?Q?C8KUdZy1drNr2j29kTij3ZMWOMLYfV3fsQZxA0SsjwrMl7L29EHJ//4Fr8/H?=
 =?us-ascii?Q?02ePgLhNZG8KTnZaqXFHvo1mOWspNwZyZ9SsFHDL7Hm92BWm0nmLE8D8r0K3?=
 =?us-ascii?Q?BjKP4php5EWIpvBKy3556aDChn23eK9to8eUxm1F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4434dfa2-fee5-42be-3170-08dcc1a3f0a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:41:44.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl0RC3qTB1jKiL0ck/BlodWKRm6NinoH1LNJxWNLZoKXxFbzHp68ixF+LYoOOWIscZdWlYYls3TNyTxFRsrWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080

Hello Xiaojian,

On Wed, Aug 14, 2024 at 05:29:04PM +0800, Xiaojian Du wrote:
> Hi Gautham,
> 
> On 2024/8/13 17:54, Gautham R. Shenoy wrote:
> > ...
> > 
> > This feature bit corresponds to CPUID 0x80000008.ebx[27] which is a
> > reserved bit on the Zen1 and Zen2 platforms, and is expected to be
> > cleared on these platforms. Thus printing the warning message for Zen1
> > and Zen2 models when X86_FEATURE_CPPC is incorrect. Fix this.
> > 
> > ...
> >   	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
> > -		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> > -			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
> > -				warn = true;
> 
> Some models of ZEN2 APU/CPU require this warning info, like Renoir (Ryzen 7
> 4800H mobile APU/4750G desktop APU,
> Ryzen 5 4600 desktop CPU), Lucienne (Ryzen 5 5500U mobile APU) and Aerith
> (APU of Steam Deck console).
> 
> So it has to use model ID to narrow down the coverage.
> 

I checked the publicly available PPRs of the Family 17h models 0x60
(Renoir) [1] and Family 17h model 0x71 (Matisse) [2]. In both these
PPRs, CPUID 0x80000008 EBX[27] is a reserved bit.

In fact, David reported this issue on Matisse system.

I am happy to retain the warnings for specific models which are known
to have support for the CPPC MSRs (which is what CPUID 0x80000008
EBX[27] advertises). Could you please share the model numbers of those
that you are aware of?


[1] PPR Family 17h Model 0x60 : https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/55922-A1-PUB.zip
[2] PPR Family 17h Model 0x71 : https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3_06.zip

> For ZEN1 APU/CPU, this warning can be removed completely, because ZEN1
> doesn't support CPPC.

Agreed.

> 
> Thanks,
> Xiaojian

--
Thanks and Regards
gautham.

