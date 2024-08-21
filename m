Return-Path: <linux-pm+bounces-12598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C467B9593EF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 07:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6E21C20A24
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 05:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90E15852C;
	Wed, 21 Aug 2024 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqVFw0Z0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EEB1537D1;
	Wed, 21 Aug 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217315; cv=fail; b=DTq/ABX486dd6jBvD9quhnYRPceS4ZhOT0to/Qt4Ds8iWEC4deVP8/ehOePpiaP3FGchoxilMgjjTiwGfB1z1ahaW4lxrXPmX2hsDMCZEVuZ7OhMCZ9/iy1uxlejIlyMI1jNMyEIseO3F0rvEOKfqX/lxsqxN3jM4e/dT4txQSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217315; c=relaxed/simple;
	bh=uYW2gcdVyYdIQn7P5ynkEb9L+OilIEU4FM3QBo+4aeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hbldGNWKM5gBkNdwj7yiML5KV07t059jy0woHuQ8FF5Jak1AR4N3nhSs1/FIpAPSpUPOZjET5VOse4xq3tHtBlMk5aL0mr3f8bRC6f+AI2UagRGqrp8AZsHAC1z62rsWh6Q73gKDebOHUf5OZ7rb91+DtpwCqBaAbW7CChTeSGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqVFw0Z0; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caDgBGOgKWAjr3HY3iq4BYBd+B6U20akHmYBrIPKoiKxuo7Ser5lbzM+c0Y4bt1ch7CMVBVkUZoPns9+kZXU0P7YMqf/OP8xIJ4TpcEzUknVGxyyrIrd537yPNOXU3wUEawXd+/TVQd4Aq+dsmTavVcNpWyHGJndh6HlYXzg8piIU4jOMfagldJXL51eaCDcogJzfJmiWb5rBWS+z3q2BCWf9MHf2zHg9oyP8XUlOFD4631yRck+YJ/ruVVbD90tafeVZLV/SHOJXcy0Un4tA8Hi8WEm9K+uzSTu2vAbE5iGGmdsVyKHJd+SwLZTZRr8FotCqJTpEfn2VFQcVG6mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/029JKWXHwyGh3AWeRuPIpA3ZGxzzs9QkiPCNJrdP8=;
 b=X611O6M6CUJHFMYG9f0KhhKSgPz/MDLgVSS+h2wJadxoAjZKxl0/g4+2xJfx2of6atfSRwZOtdDGYbzIaVAUntQEqVtp/WwsXcOtjwRt8L/FGXHF9ZX7N/tc2usIBBURLMMjQ0cwHvyzMgqTRRetLdAUDaPPQqeNtxGYywCBRWwMtUpHfpKo6jNmuuodVMMZRU+tEBZUBmrBqlYCV9Zy9rnD50K+9v1FkO1uwbHCj+yY+EiGzuQJqLzS2z7yfuMo1IDQyXhBnAMzk1OvBGt/6b98uSlw2Mc5weT/UblxTxX0irvWtc3rZalHDIXV1swYpu4dPLj5BEci6D3pNl5f1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/029JKWXHwyGh3AWeRuPIpA3ZGxzzs9QkiPCNJrdP8=;
 b=uqVFw0Z0vym48baiDDSycuHPqXLLyclBHHd6RW0pvqjJ1ND5dT41XFKQSr+IMCvscJgKq+tIg5xpNAK/YCslZi5DYD0GSmFyG5T10EAqvMPPnUHBL1iJFUH4bBWGYGJ9i7eLkFusvO3TKkpXHLY4/z3thBhyIQDZmgB0SEII7Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Wed, 21 Aug 2024 05:15:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 05:15:11 +0000
Date: Wed, 21 Aug 2024 10:45:02 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powercap/intel_rapl: Add support for AMD family 1Ah
Message-ID: <ZsV31mN9AIJBfCey@BLRRASHENOY1.amd.com>
References: <20240719101234.50827-1-Dhananjay.Ugwekar@amd.com>
 <877cd4vijs.fsf@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cd4vijs.fsf@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a10384-bf65-425d-c200-08dcc1a03b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnKKNHJyAobJfC0buo96bM0HrsH0+/T/Nm41MwNg5lEVPAktuQFftrUTM9UZ?=
 =?us-ascii?Q?pvmedZ1tZEXz0VdFBDDaMNtBa3pa2E7tJgCgD/qrD45PWPfB+nxPjeQMJht8?=
 =?us-ascii?Q?W5dSzVm8IKTzprfZF+JddK+rEYfsJHNDJClecHmwNM/cTWG7bQ1baJbSjbdM?=
 =?us-ascii?Q?++F8jO1l+a0nKG1S8bQdIhob475FoFTrJFdn9MMKO98v673XlXUqsQ7rAdLC?=
 =?us-ascii?Q?lSSfh0BW1FqJEp73bfmfP7UWPYlUx6wE+rmN293Yz64wX03knXvzbf5roSuI?=
 =?us-ascii?Q?keOnYbMSf7xCHmku4tK7aZvQzyaYUGspcG1rOp7IdVSp745qMu4393V1V9DG?=
 =?us-ascii?Q?56KVUR1tFb/Y3+tGYgHvt7rFWaoRWJ24NvGCVyMbdztkDB1xxvFp0jGBEfov?=
 =?us-ascii?Q?K/ttk4eOjTY3AgRAJp1xBKpV4Icg5y1x1mcM7SidgVD+0ujESbnm9OBzJPgX?=
 =?us-ascii?Q?NwllajRDTFrA4bRG2lmj4QebAjAg6ROzin+kBX+CFU7Sy4T4pcjZz1QnLqkt?=
 =?us-ascii?Q?FCylEBSKnIGzFGfnqh5rB3DgOVg1kgCZ6Shm58FZpul0PGicdhBC+MUwVRyE?=
 =?us-ascii?Q?N41/qAZV04LAzfR0NeKW07P2PeEvHJXl20mtD4wCjLE0l8QmeN4rkkUGfM8t?=
 =?us-ascii?Q?XmI5A2aw003dQccYKKr4gYyi49CVORVovNctIJQA3lc/01J49mqMwGmEVb+O?=
 =?us-ascii?Q?8lsIzTfewp5PyBL0gWBTT1+tLKsfgJR/LDkNcVS0PWRiB1BPpIQpIcICG97F?=
 =?us-ascii?Q?rdvFDgKgw+JPIamZIARr4L2pujNByK+frJrIliEYAkRD2wiN7ASuTtgOmCSY?=
 =?us-ascii?Q?0XeLBUn7onCN7pgLW8eX25MOt76OaQYO/ew1qbZ2GJOvzkYovOrl7ZwnlLPp?=
 =?us-ascii?Q?0+TuBCcR7lrZvbVuM3u5Dm5NVbJnP+EKXq/feD7pGp91tAYRz2H9oDVrpF6r?=
 =?us-ascii?Q?LaTo3ZiT60jLtvOqvXjMCx0s5nh5fXaIwhpxiNUpFDEycIQ1SKQvi1/hk0WY?=
 =?us-ascii?Q?7q1Q5/WNH9BghyfzHvoL2N2HS+2vDtTuJ92dBzdZG0ISQUb06p5YDT2lZr/g?=
 =?us-ascii?Q?I39zIptGtXUOl+x9rq5M4OvrkpEyzNAqQI5SW+5qzEPr5V6lrQXzucSSfbMS?=
 =?us-ascii?Q?zMZPUiIL5J7+08jg1NvKCLZ7y8MfSToGnGruXv2WRogVvmNo9DM7buXNeC5Q?=
 =?us-ascii?Q?KoUwWn/IVmlRGeQB+ky0Uc7/QXM64yRIBnyEeXx0v86l7YN6It4/A6v+BK+V?=
 =?us-ascii?Q?blGYpIEYlxa4zPcGwlEBXQsQke59liZBEirWl9Bk+x3w8wcVt5DJa7cQ6OEU?=
 =?us-ascii?Q?8V9iNuTj6UZSI8Qr3QkBt/b84gVQ8l8CYXO5tpTQ7a3k3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NmWiBmhSdd10M8z6mmaPVfPsnlNStg3mr+rmYWtYEzkzSO8fy2l8sLLa0fEp?=
 =?us-ascii?Q?jBPSrOL9Fqi+icWNtpqpzuWn3OZHTbbOPa+gkKhVnkf1raAYVqhxbp16hSe/?=
 =?us-ascii?Q?1VArTEydApR8ZRqH27X3kDeP3DMow0b/VZwdM2ZMWsaje7yG+DHYwlyfBqlP?=
 =?us-ascii?Q?SiDogJzDWAwQcHkQfQDEoDnTv9Cc6pOgnT4npoXr2T9bwcAYWGZXkjGOEFtR?=
 =?us-ascii?Q?txDfeJdHhWYMtrrXWNonlRi9rgS0Ns13eC2sD5MHvw/WBuf5GPxxrZJnpp8o?=
 =?us-ascii?Q?1PmGOrO+uXmuzkneZYCrhVThHXrrqKuy1t1o0ZRJsoxTiIAvanzRB/TMkkXE?=
 =?us-ascii?Q?3399uZqxz8hFgfyOk4ilnyw/g7fuz34nzT4AnVECope91rpSFqUqARqPK2le?=
 =?us-ascii?Q?EApiWtP/kwQX6VTfM5Wg3CJUR3BykgBz3l4ddgXEmOIhCtUEjtNmaHAGDo6N?=
 =?us-ascii?Q?r3uVjbYhkjcDADlgkVqQEMzh5Y0VFJKEs8Ra83uG8ihQljgM8zbm6R1V//Rq?=
 =?us-ascii?Q?NX/+Kur/v+rNow3HHzuLiECnJsbKXRTi1EXWgi2J3Ht0q7mrwGHkKhCRHy1F?=
 =?us-ascii?Q?FOBCjU7NYkxcbqF3uEMw9KyhEH+aa69lDYYoiWGPit4QGpyXj6ax2cBhv34a?=
 =?us-ascii?Q?dclMwp/KO1nRZ8X3ONWKcOMtNaih2wRs+5rPwzA/SG2k/C12AUKn6RJZwRi3?=
 =?us-ascii?Q?qEGxfwafko3HXNMB/r+jdCPdjWPk8GYM4xgS97tm48AjZLgsT2HN++JJuU6h?=
 =?us-ascii?Q?lIqLwipL7uvx7JVFZyPxPoQ+N7ZE/EuUPSxb+PBHQNb4oOqFrqtDJvCPZDpe?=
 =?us-ascii?Q?nV4pkdqp87nh1yD+b6cm2+KBhiciqG0LPIu+OfA0NEzbNAIRAH0D65OUx9/0?=
 =?us-ascii?Q?iUvN0LCJhrLieuxaW7CmasaOqHqSn1rUA7Q06tNdm+gY5ipxzjLTPsyh6ryC?=
 =?us-ascii?Q?Auxh/ogv/Joritg5VQXVQkEk5QzZaDFSliPx7Ywgx6lPdxQOXRZ817wc+Rlq?=
 =?us-ascii?Q?mTwYHOlgQCpQ0t+DYf+5tVRFMJDW1h4gWxg8lkmeY5MzvexpBV8bYYjim3DC?=
 =?us-ascii?Q?nBvToBEeokAWjkukMtD4zSY2YhVhvJyhwUO/GhZqZ/b6hyTDQhAOSUGpt1C2?=
 =?us-ascii?Q?68p1sA2w1oWpjHffpaLjn5sVx6r9tt5ODWBf/+DhrU78JEujWPPCJ22ZE4RG?=
 =?us-ascii?Q?CH0LZ0eVgNmtMFd6+pMaBnvlBI6xoOfyUUOQ/6X+EnAKO2B75ASMTihI19Mp?=
 =?us-ascii?Q?FyHFXMzeKIyNO5xW/ai4p+Q6OEemR4YsZMUIV9SfHXr9V96D7MRsj0+8t28f?=
 =?us-ascii?Q?jdZV+NCw2+g/mM2IHxif8TmI+aGZXvxiJu7Mdt4ZF2vc+p8IAH5fmMVLmMzY?=
 =?us-ascii?Q?D7e2SVQ8t3plsucW6hVbyadAN49KONqmiosb5P4HWiQj4a/OVVQVituR8c1X?=
 =?us-ascii?Q?BcW6gchB8kq7pMuskQ9T2qAo0FdDeGYdB/Brp0LLUPXzUZ4icr/pL1m0wMQ4?=
 =?us-ascii?Q?uTPK2bbe15gqegXwVP+hOxfw9kQUjutUooXWZeXsP1daX82QwI4JfL8606qV?=
 =?us-ascii?Q?WegEwQ5yi1GivFkqHPba0z5IUGEAQgtjTxBTp/OS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a10384-bf65-425d-c200-08dcc1a03b24
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:15:11.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Joyty0decz/7ThApH2sqZTg+eyy1LQHyqWrFS74Z5FqtdsSvpWDGCzWzUR/XJcPAvR8y4SyaKOC3ue3DQorDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

Hello Rafael,

On Mon, Jul 29, 2024 at 11:36:15AM +0530, Gautham R.Shenoy wrote:
> Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> writes:
> 
> > AMD Family 1Ah's RAPL MSRs are identical to Family 19h's,
> > extend Family 19h's support to Family 1Ah.
> >
> > Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Could you please consider this for 6.11 ?

--
Thanks and Regards
gautham.


> 
> > ---
> >  drivers/powercap/intel_rapl_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> > index 2f24ca764408..1622f1d6aed0 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1285,6 +1285,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
> >  
> >  	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
> >  	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
> > +	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
> >  	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
> >  	{}
> >  };
> > -- 
> > 2.34.1

