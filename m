Return-Path: <linux-pm+bounces-16180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE059A981D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26BF2840C0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 05:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74024770F1;
	Tue, 22 Oct 2024 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OOUGKrBy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8910E0;
	Tue, 22 Oct 2024 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573886; cv=fail; b=dfxZK56BaGXPWdCx17DxvN+GpxqpCwxcBu6y0Mp+faeWffZF9jSQpIccTye4YoOCF9f+XaGHcxbmjuT4Wob0p6CI4wukyWiCrBpynwK+SJnmPnbrcrTy2tzUo11ue2Q7xo2La50r91Eo3kp2iZVPpPrVpy4RT6xjFoMsT9k9tBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573886; c=relaxed/simple;
	bh=rFEc1IJr6x3XVjhLoclorCGbr+siWLUzUkQtwUrJC8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VJnPjm7V6cwNvsyNbgtcsx8dXDvfPJl9vV/iOhpqJ8uZBkTkQygnr5REdu1I4WNGYllrINAOmZicMaCdQDgCgB7xJMPzPL56a34mk87DVOEJKmOepD4yQX4RU5HWRiYLmp72AWopw1SzGArXtlnbqCEG6dZy7N/CploPtd/GGqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OOUGKrBy; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2xZNcMCyoMTC0u6YMymvCpMijhT0S0InLbMuYc8T7MfFRPNIRydiRfv61yR9kIO5Mw5K2mT9fe4EZGfWAyp/K75OFII1MhkdDO38knQXKnsEwzjNUX4LqjWtN+Xu6encYQJvLF2kzMfSj5gtGTR7tJFvP8jUVvo24AJOJYK2VHEEbc1AP7yeFubUZcR/+KZnkuGtJFr3eDmEajBgHvDACDBxPr5xdvKYnIS7VcJJ4hNXJEIwCPtD7TcsXQlONtLi78kdf10DujF/BRtNxsVrzgMiFTecEJnj1K/NUJflYphnF/AKMaR+fr35MTsWc28pfftGWwRDPFfMRMB9OY6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdWQPQRYVx61EDm6tBnUJLiUcY5TjcQ39SS2rUHVQGM=;
 b=MlpApTngba4SL8DOrWEeVuv6L8w4x0IItaEh0wRCK9jLZjQKMtftMTQXXQs1JOxciz5Kgvw5O7KzWeTs9IKXKI02+mw12UI1t9HUuOgEFl+ZvzEaATUHrGzewphGZ5fbIuJZjCFbFHsH+qDnXHgLm5TybBMBRjnyOsAuhuMEtlUCNWa83eZ1CUHQMKjg//0MVBWETKGaPWh7eqEVz7QsxEuHjOb7wJC8vAnsnoHTxf417Gxpa/9hpyq4xahy0wdLI/9Q2xTPVbA5Sh00oUWDr1F8/niiDgJ05EjJkWuV5TbQT0eD/JKOhvE4sA/Vn0DDxeHY4OzVibwTrQLFm8ucZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdWQPQRYVx61EDm6tBnUJLiUcY5TjcQ39SS2rUHVQGM=;
 b=OOUGKrBymR4LlCHmSgyfj2zU3HXq0TtK5hoEz8/G9Uc0KhQTdkrK2bAf8QJfV+dPyY46TCOcAD5aw91PObno8xXRdjfaH/wSynrxLszLFykvQpzQpZDLgAcoYc4xJt0uCWRYsT90LQjeUT+A5XsssREZqdRuoHHsZbjiI0h/rso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 05:11:21 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:11:21 +0000
Date: Tue, 22 Oct 2024 10:41:09 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] amd-pstate: Make amd-pstate the default driver on
 server platforms
Message-ID: <Zxcz7RiUxhETNYNM@BLRRASHENOY1.amd.com>
References: <20241021101836.9047-1-gautham.shenoy@amd.com>
 <d5d8783d-472d-4266-a0cd-e9eb7ba3cbac@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d8783d-472d-4266-a0cd-e9eb7ba3cbac@amd.com>
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01d07a-08f0-4913-886c-08dcf257f77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejUSYcI2RzTMzBhCgoG7zhPSa/Yy88aKTNY/3VQ4LsjzeeCdPvxEpc1y9n+A?=
 =?us-ascii?Q?INKKxV6u1NisGAwAiCGtcFcF+Qcxckyqiah8DCB1ZW/QEDqN2zNjYwa1m4EU?=
 =?us-ascii?Q?8JQhtf+T2NpUemOCPuWz7L41fEhtIpx9lDqXg4SCSGdb2rM04aLrMKgwpiE/?=
 =?us-ascii?Q?9P5f+qI6pw0Q1xghfdoRDJWSfhVFDZT4jsGVkJmzPL7Befvk3xzZBgTbGtJW?=
 =?us-ascii?Q?8n4nFdJGqJ3PHnD1M+F+YMXuw7q4s6VkmgzTc7o/yJzDwbfA9p1ij99NCW9l?=
 =?us-ascii?Q?RGsm/JxuozH8uoyFzeo96eazCCv5NGQqmjnIytxb4JoAGIqbQ8d2rv+VdlBd?=
 =?us-ascii?Q?rca4XcK/8ScdkmqOGwmSScB+u2t3Zy/LykHAQT1RE4aIF9DNvdaNH67Ns/AE?=
 =?us-ascii?Q?7xVVePkGaX2m968wv6EVIFyGRhO5rvCELuTWhWjBUZIH3UB1gNuW/MwaW36v?=
 =?us-ascii?Q?uUOqvrVQvy8yndea8bqz3pAwYQ8BQ/6FiowJBSLxkX7Nxt27UAcvcDoJijyn?=
 =?us-ascii?Q?bgzvFY4TFUYSTz4o9g/E9HReKM4zkzuj1nF2RW+B3X2N0+kegDv7y0HXDq/n?=
 =?us-ascii?Q?MDGcwHmgHflzeQBPTcmU4bvcnXEbl265fdJjkMsvarbVexr8o5vPzetmj5pI?=
 =?us-ascii?Q?xqSgI6VHbKqIKmVEV4CC2wdbRLLHVIjBFIJsD7v3PYiGhh7t7qVB1Dqt6eRE?=
 =?us-ascii?Q?5zXx+wAqDPhJjCzrtas6eb+gNTYGDZINvrLWzE38Btm33ml5appvHVX0HsfK?=
 =?us-ascii?Q?SzHFsOza58tovUl0x1NS/XhoBJAxjXhloC3GzPRp98OaCdq568TXwuOFC4xq?=
 =?us-ascii?Q?8z63nGvVNliRWbsKcYFezwhTz+xRmosSBNlgGBCYuGmMFu7mje0RBWDQ4qgB?=
 =?us-ascii?Q?cVUh+7bxbDlSqwI/bAdkXiRfzgEWGw2P3Uo8S5Rv7E96iVYF9UbMczOJ6SEW?=
 =?us-ascii?Q?MsTNh03IHcPxF/v4QwnFsWdEnv7zVyKbCSKXzVDG64ZjO66C7bXFs3U2GYVI?=
 =?us-ascii?Q?No3TsvjI0ZYgejtucNhkBHqOS0Sht1zbY9eWaD6sUtDGqYRL1npfNeNWd6di?=
 =?us-ascii?Q?sNlxXsHR5H+p4agCF4Bmf0XQStlG18xQ1NRUMT2VqYfzrXtYjYWab39HcqER?=
 =?us-ascii?Q?B5OYif90WTDyGoj6ZxRcPzPtpNSplFIHP7Uw9dmv+odFzV71dUFPMVcx1W/F?=
 =?us-ascii?Q?gf1J/mTbTArxaWWBqADBY6ZxGPokf1Wmt9SffKBe/wOFZRJmMHjbr1t4EJfQ?=
 =?us-ascii?Q?XhU7beBe9g4Hpz8+pkKYU+yhLVbYw6i4u4q/0tDa3DRgmdpQhlmnn7kwheai?=
 =?us-ascii?Q?3p37Fd1F4pKj0VIOSpxUHPCj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LshnEkKj/oFMXEjk4f4I9V4y/sgKMZvNNjxfEkukHMSZpF3UB1tryqBXlUQF?=
 =?us-ascii?Q?sK8q8sQq1vjWW85AYx0P5GwxxwS+HD5uOLCyMkrSgyixFjh4crekMfTrA0Fp?=
 =?us-ascii?Q?qxa9VwspPsDWtZbj2CWtrdAbHGBUEhVgGV/xKiXeuar1ATRZzSuP/yPQq5gz?=
 =?us-ascii?Q?D/wouRKfM+Y02emoCBWn+2Q8XprvWewm5riscbbnl8PVEmDMRBNKwqJQcBxi?=
 =?us-ascii?Q?ap5CEDDt3/br0K7+2NZwbArrDKqG413h1Be7jl8Qp1/Eog+6Asph7ymg2InJ?=
 =?us-ascii?Q?GoPekVl6oKW+Lz/OXjJO+C0LRHzu2HEx11Go+2B7xDQMo42bHVfAU2orVGTr?=
 =?us-ascii?Q?XZPwMMg6uSaHqIKJJ4em5DsZu1WKEfOghdSwiBNp8VAGsidui/KQamUCCL4Z?=
 =?us-ascii?Q?ibQrIPPit65FlA5EdDsNdfA/msaPYKlX94+nf55nlUcoAQ+Kso357VomILzz?=
 =?us-ascii?Q?4gM1FrQsj6fd6JscF82zupfHFCyq1YVFHRyTym6+nSLyNhAss56eAclH9fGf?=
 =?us-ascii?Q?KX7xo76KKEBfh9W8LZ0Rg3NUXtb3FbwxaDdvVFjgYYJTBph/MIppSBI/FzsE?=
 =?us-ascii?Q?HZjlFUMuJeHgjJU0gDIQeJzm7t+w2PZ8kb3ByToQWjiFuKv26kUxPmKbd3xc?=
 =?us-ascii?Q?HJdYoQoAkg6DL8YCgFg0nW+lQFTxB+wdOnEv4O+1bX+Ipt/rIw91iT2NCwFE?=
 =?us-ascii?Q?3AYbvcOOaZmhbKnZsQ+a9NEEjAcxeZioZcZEo+fD8j9Nu6IVbz1VtKEFRvUQ?=
 =?us-ascii?Q?wrSbkSzmfyHqrYJAc1cVzBa+ZlTH6ybQJgkYby1apkA/shKparqwXOnKYGWk?=
 =?us-ascii?Q?kkClhbuoddO2WIOdL+vhqZP0SuBRA9xpYnQIeW84IFBPfuupT6QgESICuVi4?=
 =?us-ascii?Q?1dpWqcVj37iaG9EuuSmvtwj/WKtsDuuGoFMudB1acpmqayzxOeGHlKdVI67x?=
 =?us-ascii?Q?COUWUKrI0v98Qj2NCdkcl8j4VsfbNlyY79O5WM8M02iLV6gQAO5f4sZO2HWZ?=
 =?us-ascii?Q?URI0zz0D68Tj/kZckfqxQRd+e1aZlr9H3rtgJVCiCPp2aEMNLpH8VcYpeZK+?=
 =?us-ascii?Q?LKACFyJ54H3gsstjaUmd9uH2VjScKjUSuVih3QC3ZHtRPy42ImC6ducHJIru?=
 =?us-ascii?Q?WjDQF0oRk8SqhNqMJmYUYTKM50zLi/5w2/Vg54kyCqHFrB6rPBwEBJbxNlse?=
 =?us-ascii?Q?lRf1qpCEKawqxVrCKAgXbGw+XoKX29/wl01DF+wd6DoYuKhiAuo+xIt0MhkL?=
 =?us-ascii?Q?enT9m4BjpoxhgUZCs9Scc+HaYib4X9/F7wpq/hnNxJ7RUQda1NThRENXJFVc?=
 =?us-ascii?Q?1Cyegf6OcjKl5vprhyNH6oUaHL7oPZAeT6ehdHMp0IGhEAJkDcwlfZjWviTH?=
 =?us-ascii?Q?hLtqXbTntkdSelQFrGFUA0J477h2hX8HbuYl0DT/iVPagoHR995nmljof2BK?=
 =?us-ascii?Q?NXS2FR9xi1hOlBcrtVDZ3K137W3V2WA1K5117HK65AiLrfxK/PM2q+BFAOjD?=
 =?us-ascii?Q?AjobWVKgXo5C1YZZLFtDwjl1MQwV9zksKM7M6vqbiZ4WfB32d5hXuqst/Vs8?=
 =?us-ascii?Q?Cv5rY2CFWGQrKtITq5XLkJM3P3FUtZowd5b9Yrk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01d07a-08f0-4913-886c-08dcf257f77a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:11:21.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HygtEzYdb9T89fxuOWoRRhBzyvLAGhLFH/Zj0KXI+Uo6EkMYp6JDaNXltF9pG82i6gc1AJmn5N4ZyYCFUCWc6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

Hello Mario,

On Mon, Oct 21, 2024 at 08:05:17AM -0500, Mario Limonciello wrote:
> On 10/21/2024 05:18, Gautham R. Shenoy wrote:
> > Hello,
> > 
> > This patchset contains two patches to
> > 
> > * Prevent frequency throttling on power-limited systems with
> >    amd-pstate active mode with performance governor.
> > 
> > * Make amd_pstate default on EPYC Family 1A+. Based on tests, the
> >    amd-pstate driver performs well enough on EPYC.
> > 
> > These patches are based on the "linux-next" branch of
> > https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> > 
> > Gautham R. Shenoy (1):
> >    amd-pstate: Set min_perf to nominal_perf for active mode performance
> >      gov
> > 
> > Swapnil Sapkal (1):
> >    amd-pstate: Switch to amd-pstate by default on some Server platforms
> > 
> >   drivers/cpufreq/amd-pstate.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>

Thank you!

> I'll queue this up for 6.13.
> 
> There were previously two differences for server and non-server:
>  * amd-pstate not enabled by default
>  * amd-pstate cpufreq policy starting in performance mode vs power-save?
> 
> This series adjusts the first for at least the newer parts, but I would like
> to ask does it make sense to also evaluating changing the default policy to
> powersave as a follow up, or should this policy delta remain?

We would like to retain the policy delta for now and retain
CPUFREQ_POLICY_PERFORMANCE as the default on servers.

--
Thanks and Regards
gautham.

