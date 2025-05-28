Return-Path: <linux-pm+bounces-27728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE58AC68A8
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0971FA2136F
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36E8283CBD;
	Wed, 28 May 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jDXx0PvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493F10E3;
	Wed, 28 May 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433470; cv=fail; b=XQSFAVrQ9YOH8B5HhV+kevXWbcHUDOtyvhgzXCqDeyFpntDkpSqK61nEDkOJRqzJwOADJD2oFVqI5OZXLG9ry9OcMMtb6Qvq7s7Z/oABu5wHdoEu2Dbn6aGRcg418XPxgp3924lbLJauXmTXKnpdYLAX9bPidHgUZkjIMkCkoys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433470; c=relaxed/simple;
	bh=7fTNlncQUsrIYYpnD2dxUC2BfJOsSIkc/IYEEnEFnCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F3F/HJq1F/JG/P9g2UpAqFIQYgwUPx8R0VpP0nBRtkIH3n343y1Ta6tZO3dE8yKAFRGjPsrDjFzv+TtR0J4E0d2o+oihduqgHx1orISmAyhyQdQ9Brk65esoyhR6BhWuoywbqL770sF9j+nVlBOGtvyaXnNren7RcIHtWSCy0aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jDXx0PvN; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHsmJKR16f28dqkA1eNF0fbwtA66netCGTBpatfee/G6gLivJLXiZPljER16riBruR1GYnoFtxD7LQAkZK+O7ULdMTfm/EyBEJ3UQ6BCpRzUJ7nrNH3ngKWl9Q8j/0f5lKvqUCWivXt6zOglKF82uEVqidDZifSC1lD6TfJwVOkaQw/cH8MedEYO7HocG1ZMaPprXg4yeTpcdCeWUbU1CTE3QG9UhePiSyYFhwHjZebIA2JO+5m4VQvLWsj3VGHbwgT88zT1SJA3GW0DD206NCx3P1UkE67dN9eZFbqknMZhDDTwD/pcI/Ec1GlTAPTikJ+T+W3K8/JUKBhUo1rR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpydmyc0P3lard+IItVX4qRdae9xB5SSBUn5XxSNJUI=;
 b=Ba7D3QLBOK1DWCtVIws3Kcy0+VddzoNP4izY9TUDR5QDDiUpaYAQQ/IfdSvQ14ctqeKRMl9NLLolgQxWW+tCnxrZeincZTA5lPLS8csW60X+2EJm1ByzKP70JJAHIZ5iEkGLrITrNaucF98K2H6pvR7kpOK2U8ov6yhiH7u6APyGOG7idTsE4ARFtENQ/IXXSoE4Wixw/dHmbdZ9hJxaUZzVOIaMBMZWtbUAc1AqLu6kmY2DAMDeJXst8CfY13zMj2pYfmjmqBhj2Jy1WupPi5lASMwjAVSPeFsxflkkXCtfh5S1QenhBmjA+ss8wmF1KAvkiJdubwIx0htLAmLFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpydmyc0P3lard+IItVX4qRdae9xB5SSBUn5XxSNJUI=;
 b=jDXx0PvNByc+rEBTq0UWi1o86ey5ra0gkgSuBBOL/ikX6D880l1wQVcdD0L5bOU6r3HCVwt9JpyFVQF5A/rMIcX2CyEdm7KFi3LIUTQKdj1MMMhI+SR0fNfRvgOtHUAWRDeP4bkLtss1Ayr88YIJY2CfVwvrw6iEDZn4JJ//WwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 11:57:46 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8769.019; Wed, 28 May 2025
 11:57:46 +0000
Date: Wed, 28 May 2025 17:27:38 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adam Clark <Adam.Clark@amd.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix max-frequency computation
Message-ID: <aDb6Mgg3TqyR2IRT@BLRRASHENOY1.amd.com>
References: <20250113044107.566-1-gautham.shenoy@amd.com>
 <aDaB63tDvbdcV0cg@HQ-GR2X1W2P57>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDaB63tDvbdcV0cg@HQ-GR2X1W2P57>
X-ClientProxiedBy: OS3P286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ecfec1-8275-4fdf-60da-08dd9ddedc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYtgzNwqWFYaQNnZFAZZSk6G9tkitQs26149Zow8XcxE+6sh5/24n8GB2oHv?=
 =?us-ascii?Q?MCKsnGHNquIJwHp/6KeAiGiB3Jyk7JKCqb3w1Y34IxsWOVlsHR4XaiGeemqh?=
 =?us-ascii?Q?fgVgHpeJ0RqvOstDQOzfnJyCfC+EG/2TT6U0WRmFDafW7DzUoGDB3wm+eqHN?=
 =?us-ascii?Q?5xtvZx/vv/cpEUfv0BNiM5ildsgftUFVuY9nmgC0bQbZvEInnbSe3skWOt7X?=
 =?us-ascii?Q?4yRuhCp3reV9lGYdsEJBciwf+eGL1oPJfNEEp6d0UR9cB4050/16GQcPE6pE?=
 =?us-ascii?Q?WkpeGmnbZ9V3xHfuYBmYCIXaAuksmnvOjY+mqci4yCS5eJ3kqJ3AikE7Vd7t?=
 =?us-ascii?Q?2NVRtTBIKVZN/MZtIE3OlWGltlGVM6G/bRNq2dDVxaNXDydiTUfK0qUdA5Y7?=
 =?us-ascii?Q?2SMp0oSF8HKt5maMEaQmhe6zV6d4DOAarNtp768xltqnxahPnKYl3KyCx+41?=
 =?us-ascii?Q?2vK9QKPccUdOq775ZLxLZjcHnHo1pHyxmP2sxwP7cipcPpZcVRXiFLFreUz4?=
 =?us-ascii?Q?9ylL7SS4bpUqvJ0pzi2ZJcmHOE8WEdA5PD5yz2zXOhhC+d1gsgQF9HU+CvWk?=
 =?us-ascii?Q?90us9X9SqYFIqriNbcKku4myrxwOQOkmeJXYnvR4EXnifY/C+xnIpunrr2q5?=
 =?us-ascii?Q?C7/1IC4JI7X6R1+UJGgaAmO6ncX5+iIqnnEEQdaj6z577gU2DdXP5293a9QZ?=
 =?us-ascii?Q?SJznEIq5Mj3X8jFwSbNUbz/qUggVmrIp9Qc7lUw2UKrC/xsVjIQTHtLh17lj?=
 =?us-ascii?Q?Qjd+TXdr2hk/yA9DAzKL5MKHtI4WN+QlQjTZ5Vv86TrsHxBKOErQaFrC0yft?=
 =?us-ascii?Q?VgbMkhUy22FMPA9xY5J/6wY0aXHpk9MY8wcz3mJZB3BMX2uF3hfWBrg+0xJX?=
 =?us-ascii?Q?tnuDEST+2gjLxXAOPXrY9zkw5sZcLTa2qZ60WCRmT2Ke07Gm619hZY/JWHPA?=
 =?us-ascii?Q?Y//sXjZg6IPQaHK2Q2ZLzQm3LFF0uhB4b5iZmg8DT+IkYp2TPOWZcxR8gXQ7?=
 =?us-ascii?Q?+40XZoS8/VSmk9byDk7L97cJQNyJaQ0WYeiyeUF3p9Z0yZCaQV6UaTyn4BTG?=
 =?us-ascii?Q?9Rb3mKK7/0tvei8MTIivKtwnincT4d22sRe7nEuGzv89NLsaXvS82zhsDiTS?=
 =?us-ascii?Q?89TY8fnS11ttaOGTHyuotT98JycN6re8bVPdYVEeXoag38nKRcqjY1gsp3+m?=
 =?us-ascii?Q?+yV+Bxt9Szshp63Nm2B7BIKWvLqZoXmqd+J/AFojQYdWQQfMt6oLCuJuoZoB?=
 =?us-ascii?Q?C9h79ps+U4LgnBF+hpblj8OEF5jc1e3f367ixv6ow6Xp80sAqWLm93goNCFM?=
 =?us-ascii?Q?XSI2vNNuBk15e6Wv+MN5GODNyKb6I920MaIbUnaEo5Xm1/4tmdI28yQkwCLu?=
 =?us-ascii?Q?cXPRu8NB1e369fy6gcbBKPB+82hrHjA3fCxorbD4vLK35Z+xC67sA33BV4PL?=
 =?us-ascii?Q?BX0H62he6mU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nx4NFdYRb0Yz3Ib9APxlPBPhuLEyO0b4I4VQBqj8zibR0QyRKUMYgyZ+cv69?=
 =?us-ascii?Q?vmp53shiY93lkiGka0oSVfwCYnpFafuaN77VyiE+A1VvHk2lJZLVAv4aycKa?=
 =?us-ascii?Q?/Vv3cIhxUjM+eMk7HxmqZkUUtoj04k7CdpRblFVZshlnRWH4lLKD2Xx5qmiI?=
 =?us-ascii?Q?cG5UvRk2y6yCZ5g7nEhaowltRdN5yv1xzYUDt+6R2YNAw70Sjkuku1XxXIhR?=
 =?us-ascii?Q?jUo5eg/0EttvNMTRtB683HA5Zk9fAMiLIo/NvTi+nFqvzXDAGa3+0MSmGj2n?=
 =?us-ascii?Q?AjHJGJQwHVB0mfwdlN24B5Nf2ZiM9daqqhHph67TdBhrtCAhTi5k1et3E0s6?=
 =?us-ascii?Q?B1BrTofsX0Z7N1Zl2QLpwgFbzfqGRQ0vc9uQ/rKD9ycWXnB4v5VkhCkhQxWa?=
 =?us-ascii?Q?+lLZeOHGvwzk3UwFZ5oilVreB8zE2mGw5eck5rsKDSW2tMHGidVmenO+FUMD?=
 =?us-ascii?Q?tAuVVtyVuVc8qUqEjjPT3mf+645PnC/4DI4aW9EoTSR8je/KSMUF98ba0WhT?=
 =?us-ascii?Q?nXTmhdPauEQuD2+VHq/sYpihqOb4FW0M2sYoI/jmCxG3hHcSfldpsPJUFG/1?=
 =?us-ascii?Q?KlM7WNVM9qHbQodil5R2SiB1hK0MT5INDNOsnxUWL93RV/Dd+umsAYewXSi+?=
 =?us-ascii?Q?iTzd3lDaIIGocv/C4o+g5Eb9mqBy5DAxxa9OLa1l9B41E5SGmJAGCXBvM7xW?=
 =?us-ascii?Q?MqLZIMaPNucBc9g91jrr/TSGaqvymiIyi2tBOCOa5oL1hE9Izs+6otFRRew6?=
 =?us-ascii?Q?bkyXWcb9Jr5ER+5EHsdkO+YcpurNsTKMfvfkMcGW8nqEA+5bm1G+5AEXlbMb?=
 =?us-ascii?Q?W4vCccGjh0w62JYuXTpEXrYxxHfsz2627/GZROXSHi/j97/m6lt4EdNbOz/B?=
 =?us-ascii?Q?7a6ib5pCKD7YMsvHBWkKyRE6qLt5iMEZ2G2VjdnXyWIG/QvT7dPq/AwJ/Gzj?=
 =?us-ascii?Q?oNpV7MEnXtlksdeC+bTiXAOlQs6URRxdWu2R7DedrBAecSIVbKarTWsGp6Q5?=
 =?us-ascii?Q?klsMNxolKO+TXcg7Xft9Tl4kYj7w0K0x6G//Fkq9/7v/KhbTffDphp4Z5Wvp?=
 =?us-ascii?Q?yJtUKx+bcpq32z7KYxsuHqEbLKaCUZxsGPBlBECrO4N80ypxbuWfTVYKPyII?=
 =?us-ascii?Q?bxVw+ZCjS8fatVEwMhrVlsA6KCra6Be0kTvjnnWOhAWPaoGZE0m3Fx5ieA2r?=
 =?us-ascii?Q?VB26DY18phkCXP9I1APr9xoIiT8rDXi19KdqppEMAjwZlVNKUe31kfhyxQE8?=
 =?us-ascii?Q?XbBwKh7GQJmgj0fz+4kCRhyDNzH29+DMLcHThuQ+Aj+gMwr6a/UAPHax883U?=
 =?us-ascii?Q?n4Ed82GB7fjDxerH5apl4Nbm6/MCcLjKHfrTOKUb4jEq9EKqFGq3CB/QMZAr?=
 =?us-ascii?Q?0C9e1Qw0jVMhGBr9YcTmy/RG49UI7Vh8p+vMpPjK8FcjroYMmpbS2F0jMfeL?=
 =?us-ascii?Q?bnYXqkjn8dAC8oTLJNLsJDkvrLotoMY/Ykp1DiWevBKSKomQBA4L+pMVY+CO?=
 =?us-ascii?Q?cQeAc5wjRrj4Ugetpe0QQA38x00yo+9vWogSKg4krR0mpkQ2n0+WxVGuuTbK?=
 =?us-ascii?Q?MWkcQElm7RkOIq01Y5gZndRLoPIPhIjAdiJtYVsS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ecfec1-8275-4fdf-60da-08dd9ddedc46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:57:46.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +55cPmSlaDHtOvmLEbfj3YNQL889xudfad2jOGdK4KWcmCYBifyR17In4QzcOD18Ly9wBUHfqLLv7pbfrCDlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

Hello Manu,

On Tue, May 27, 2025 at 08:24:27PM -0700, Manu Bretelle wrote:
> On Mon, Jan 13, 2025 at 10:11:07AM +0530, Gautham R. Shenoy wrote:
> > commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> > boost frequencies") introduces an assumption in
> > acpi_cpufreq_cpu_init() that the first entry in the P-state table is
> > the nominal frequency. This assumption is incorrect. The frequency
> > corresponding to the P0 P-State need not be the same as the nominal
> > frequency advertised via CPPC.
> > 
> > Since the driver is using the CPPC.highest_perf and CPPC.nominal_perf
> > to compute the boost-ratio, it makes sense to use CPPC.nominal_freq to
> > compute the max-frequency. CPPC.nominal_freq is advertised on
> > platforms supporting CPPC revisions 3 or higher.
> > 
> > Hence, fallback to using the first entry in the P-State table only on
> > platforms that do not advertise CPPC.nominal_freq.
> > 
> 
> Gautham, this got recently pulled in 5.15.179 [0] but it seems to have broken
> what max CPU get reported.

Thanks for reporting this.

> 
> I hit the issue on Ubuntu 22.04 with kernel 5.15.0-140-generic. My read from [1]
> is that that kernel is pretty much 5.15.79.
> I rebuilt it with this patch removed and max CPU now show as before.
> 
> Here some output that may help, which is what is mostly down to what is reported
> by /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq . Posting the whole
> lscpu hoping that contain more useful data. Happy to provide more if needed.
> 
> Ubuntu 22.04 with 5.15.0-140-generic (affected, note CPU max MHz: 2000.0000):
> 
>     $ lscpu
>     Architecture:             x86_64
>       CPU op-mode(s):         32-bit, 64-bit
>       Address sizes:          48 bits physical, 48 bits virtual
>       Byte Order:             Little Endian
>     CPU(s):                   128
>       On-line CPU(s) list:    0-127
>     Vendor ID:                AuthenticAMD
>       Model name:             AMD EPYC 7713P 64-Core Processor
>         CPU family:           25
>         Model:                1
>         Thread(s) per core:   2
>         Core(s) per socket:   64
>         Socket(s):            1
>         Stepping:             1
>         Frequency boost:      enabled
>         CPU max MHz:          2000.0000
>         CPU min MHz:          1500.0000

[..snip..]

> 
> With 5.15.0-999-generic (5.15.0-140-generic without this patch), max CPU is back
> to 3720.7029, which is also what I get with 5.15.0-139-generic.
> 
>     $ lscpu
>     Architecture:             x86_64
>       CPU op-mode(s):         32-bit, 64-bit
>       Address sizes:          48 bits physical, 48 bits virtual
>       Byte Order:             Little Endian
>     CPU(s):                   128
>       On-line CPU(s) list:    0-127
>     Vendor ID:                AuthenticAMD
>       Model name:             AMD EPYC 7713P 64-Core Processor
>         CPU family:           25
>         Model:                1
>         Thread(s) per core:   2
>         Core(s) per socket:   64
>         Socket(s):            1
>         Stepping:             1
>         Frequency boost:      enabled
>         CPU max MHz:          3720.7029
>         CPU min MHz:          1500.0000
[..snip..]

> 
> 
> Thought to post here instead of [0] to get your thought on this. Am I missing
> something simple to get the right value? Or should this be pulled out of 5.15
> LTS?

No, the patch has a bug. The nominal_frequency returned from the
get_max_boost_ratio() function was in MHz, while cpufreq maintains
frequencies in KHz due to which the computed max_frequency was
incorrect and thus as a fallback, cpufreq reported P0 frequency as the
cpuinfo_max_freq.

Can you please try the following patch on top of the original one?


------------------------x8------------------------------------------------

From 13d5c28823ed03353059801281d3b22e9f139a8d Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Date: Wed, 28 May 2025 16:43:33 +0530
Subject: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()

commit 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
modified get_max_boost_ratio() to return the nominal_freq advertised
in the _CPC object for the purposes of computing the maximum
frequency. The frequencies advertised in _CPC objects are in MHz but
cpufreq expects the frequency to be in KHz. Because the
nominal_frequency was not converted to KHz, the cpuinfo_max_frequency
that got computed was incorrect and the cpufreq reported the P0
frequency as the cpuinfo_max_freq.

Fix this by returning nominal_freq in KHz in get_max_boost_ratio()

Reported-by: Manu Bretelle <chantr4@gmail.com>
Closes: https://lore.kernel.org/lkml/aDaB63tDvbdcV0cg@HQ-GR2X1W2P57/
Fixes: 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d26b610e4f24..76768fe213a9 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -660,7 +660,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (nominal_freq)
-		*nominal_freq = perf_caps.nominal_freq;
+		*nominal_freq = perf_caps.nominal_freq * 1000;
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
-- 
2.34.1


-- 
Thanks and Regards
gautham.

