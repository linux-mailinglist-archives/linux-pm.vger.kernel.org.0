Return-Path: <linux-pm+bounces-32028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC8FB1D2B2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 08:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CB5723E2D
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B321CA1C;
	Thu,  7 Aug 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4BFrH2Tu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461984A06;
	Thu,  7 Aug 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549735; cv=fail; b=N7uteznXTJBYWdLVsykDJOKgVF3fnxmG1fOuus48Zrw+rlXcNV9z0ZfsipLpYOgIf0LnHkSfBJNXU2kuPqzHsuXNpnI8f1Tszj+HJYicONFo18AzcfE08Z1S9RAe/EW6phlh/Gh3dLNwu8iB4lW5Yx3oKydCl69hau9cyyurhiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549735; c=relaxed/simple;
	bh=824k25Cc3gLXP69tMVpEdIucaiYI++DgJd46yD5FFbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gcMnT8ZScuqev26RLuQ1iwrz23XXcDd0XP+r1BL670vXBlij5wCv6KG6Lsx4ijeki9iRBD47+P16uPdefU4qN03R7CbRfatsB1Kl65VzVsGcjjdBp6QkK1O70aCnJvhEwDXHTy3vy8UHa530tpFgoLNzSAE1o+Ienb6fyD8vNUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4BFrH2Tu; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhIMn7XKsoUnHoJ6LOt4LkjFDNNIYDeJgMO2ayU59vB+gCr6IeSQuETy/qAsSM3H8f7m/VDZjf/dCF4f4HRvCkQmqihVCety81evW7sp1htDb2ENRuIrd9r56Q4flylcGaL4FuFB1FRM/UFKnDgJKKhkfCZ7NzTRB3qWr7cYMfl21yyqjDDWJGFhgq6pTPRTlFY0RWUJpdjmhTKXGO/KIbgU1kspQ09JOTFepAiRCH1iTbj4HSiypQpPHz3zhcIseMpRP3IzB61UubTcjfYwQ0O1Xp0nW1t3gOMOz1j5tvQ7zqgYsIXVbgsMM789AEYAi++jsdRjp/BlpmmP2hMfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6/jxE3fnrw5/AMlRn87Ag3LE2U6/ToK98hQp0BRntQ=;
 b=ea4JDNg91tpoMjRukcxo3DPMNaIQCjwLZmPjG7Ny+Iry2MUj0S0VWZKnZt/IXhT/Vr5e8WYAovh1+0Wo7z/0AtfiOcT1XVQTOKtV7nTG0Fyp98X0m7oxPCuWSSiuIfVSz7qOtFeJe+aDVgAiHiGYYa8sISMRjkGwS2rgTt+OuKnph+CXy8FV3Y/kjx6FU4/InT6TiXJIw3Y689bB1HF1VpMotCTKLUOxD8Vij4DlRaDVQ2D7S2iBk5o4/w4zD4G8Yh9n43KXkUHRKp+8Kw8ImBqamqtEVwK6moBpiNFpSPzAaVO/GQ6AGgMv5oAHK4ICn7XjwHGu2ILWFcdNP/QfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6/jxE3fnrw5/AMlRn87Ag3LE2U6/ToK98hQp0BRntQ=;
 b=4BFrH2Tua/XS1f+4sSu3CtWVzba4o9Lw22g0zbGxP8boWxYBk6LtwInQkGKyw/iyEBCn1c2MEHBHRQpknyC6xnNb0NLpEU76mrsENjTgzKngbonfUyWN29DCgWGYu08EN/p+1o5xdaatsGDUQsQ433GMrxO419XRp3ijj6qO2lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Thu, 7 Aug 2025 06:55:31 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 06:55:31 +0000
Date: Thu, 7 Aug 2025 12:25:23 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-pm@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: loading amd-pstate-ut kernel module crashes with PREEMPT_RT
Message-ID: <aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com>
References: <20250731092316.3191-1-spasswolf@web.de>
 <aJI9xbIllYV7ON8S@BLRRASHENOY1.amd.com>
 <d501ba67cbae1113c50fccf97155c1fa67a533ae.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d501ba67cbae1113c50fccf97155c1fa67a533ae.camel@web.de>
X-ClientProxiedBy: BMXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::30) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb86646-c02a-4d54-385d-08ddd57f6618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iOGWBXtRCM30NmntX2/i+nr9ROQLHrRh4Zo2FMqtKG+Jm7UqzCKkpmSoUMNX?=
 =?us-ascii?Q?72g7b6Ihj7XDVX919NrEOZB+Y/I9+9UFoVqS8PKj4MVwTe5OqY7P0VoSVbNZ?=
 =?us-ascii?Q?lGt509PzHTJmrlQkgSqDDvjpZ9dERpo69KmrhteaROKmwIAsHapUSvGXE7at?=
 =?us-ascii?Q?wu5gJLR60qcR6clcYKtEwxT+gjNg/Hik/OHDisjXvNJyORNZejWcngEI/7us?=
 =?us-ascii?Q?J+vaJpZbeML6qFQPtZVqx+39GCvcayKguul0Jj4W3BKP2jp76xGGMv4SRoKG?=
 =?us-ascii?Q?SI6tb9JqydMHZLP8eFQi3zEwENubUvamEbXf7caZBq+Xelv0fe9cPzlVHlh1?=
 =?us-ascii?Q?vYuYO+WLkafNSCRQsFTDZxLee8jdKYVEicPBcqO+u8288UaPApUWBewVeZ3l?=
 =?us-ascii?Q?oHcsVVU1qSARw2/ZJpN1rOaJP7/hSLotWcXNP43RuNtIqoUEB6Hxn9AwsePf?=
 =?us-ascii?Q?98Y2Wts06r4F03qv2jOKQO3A0FG6/QUrgw/GO8MB8WKeArx4o9eOlBY0SjCH?=
 =?us-ascii?Q?+jW1sZsER8aATP5RN2RqiPdRCjTGTNvaCCKHUG9gc88Jelnzb0pOXdwF/q/f?=
 =?us-ascii?Q?0eLOofdZ9zglgXb2F5vb/cYoKOjjfP48HR+S+1/XPTXUVZVIos3qW984+/pJ?=
 =?us-ascii?Q?++uAzrqRK9vO/rnB7hPT8CxSYwrAUbfEKEuprCIvwcfzF0cu8DpDAT6lcl/D?=
 =?us-ascii?Q?0hHJ9P7ublt/+Eqp81t7C3vMMvEjMmoim8bH+K3KEdtWkcpnv1vJZLqlh4rs?=
 =?us-ascii?Q?LwZ21QHK+bYzstlxvoFef0lnwHksfEmidh8V9hg1IqRMbqABrt9Uj0W4q4Qv?=
 =?us-ascii?Q?XLXSWneOo/BUhOIBSnVjRgd1v8R2M8Zite09vC6Zv/CYfSwaA5ChiFfdouom?=
 =?us-ascii?Q?uESccMm9EOnoogpgpsokYVjwkiLI31dwDm5Y4Wm0xmAwrBbg9jOyqdrfvo+5?=
 =?us-ascii?Q?E7Gacq4M5QqImQRUdhVZRBypBkYgnEliB6QbM/rMSr+IBXIuV4dkpeN9dIiz?=
 =?us-ascii?Q?4f50V0kvDfKrKq1G2j8ncoArv61by2GvcEuGa4OaCOaUxhK0Vi9hhMR+z08x?=
 =?us-ascii?Q?2nCevLDHOaAixFtzkdpTGuonhWqOrooJojs8XkE/qy4ddByxK8EPos0V2XYZ?=
 =?us-ascii?Q?P8q3po3kkJIrG10BjlMWqgUDwO38GtbQJ0ugMhgUs1W553ktF7OWMNX7yUcY?=
 =?us-ascii?Q?wZ8H71fEgvNETJLIhO4dYwNWdAOXq16mm0hYWL7YXbIJY4+RpZ1xXK7S3xYj?=
 =?us-ascii?Q?jrAm5lyGe6Tklrq/rN6hnry80j76OzAPYBiWmdVBWkuIYu+XD0ElSH3TiiSo?=
 =?us-ascii?Q?aHpBc0EiF21YIOjnREqtrkWYZQuo7HACfo2Kt7Ge8tS88vkMzJb8RqCHrGqH?=
 =?us-ascii?Q?dp2bZYyLjhaPETjWTLxG0khi0ra8SaRls9QfQl6PR7gpPQwmjTO+EO1saDDq?=
 =?us-ascii?Q?HQh11QWsaPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ftuxqhFB//Zly5fbbRnRon5Iw89m7SvZwu80dfy3RPx2WVj0JxQy7NOoI0G?=
 =?us-ascii?Q?qId8RPx8QRH8v0x5NmG4NvfS0W6KLryVVoO8AxoQueYAP+AUjIeWm5FxjSJU?=
 =?us-ascii?Q?FqeUNKLJMLHQYLm3U26cSxSG2Xb06e9D3HhUq6woDZUbwHKNXR2IO0acc0AJ?=
 =?us-ascii?Q?pkVygQnqBRu9PilYY+6vBLzvQDiA6Pxq9g2XYZqx5Zh4U6Wna+5CpXJdRei6?=
 =?us-ascii?Q?8+p+vcfcZ9AlYS+J9xx1f24mkKd7NsYGglg8n4UWQDnFT9Ay4QOf7XSkQJGS?=
 =?us-ascii?Q?9QYDWJPoeF3SU0Vrfl+hDx9bRPMU8WsWFgk+hfCClGZ/q5f5XN7vH4GeLu0l?=
 =?us-ascii?Q?ldwMhfQ/c4kkfWhUx0CoD9Z4bNVTWVKVvq4Za9fRG0HuuWc0g7+tXwgK9NeA?=
 =?us-ascii?Q?ufvqCPdjf3XRngcbSkaucyCX63ociGsy+PV6GbPLcCSZxbezzqXC3hOR23mG?=
 =?us-ascii?Q?x2s6pP6QxVAiYvoLWSSOMNtJNwwIQlL1lemCMvoNfs3U1jZk4pzg42fKNHFs?=
 =?us-ascii?Q?1WcW2cYMWp2/Ld4q9EWUc6PV5x+U3DBriwdFyuG9qe+t38WV/ObSt/5heGKT?=
 =?us-ascii?Q?wa11lIoPSMNAgYkYTP9xQ9YoYxI5jRk/zMeX32GGmJ6q1Y5ayxwTh16GuEEm?=
 =?us-ascii?Q?qrkm5y5Mf9UoHJ08e/u16f6VTtFVwBaqjRDqDYnlOWZXEoyE9PqPHGmTNT4c?=
 =?us-ascii?Q?RV7LUlV60R1HYVTXMRlWutV7C6SU8hqyrUpl1MTB3wqrWIP8IoF3zZyuwcjQ?=
 =?us-ascii?Q?qlYOGo9FZB6gJYs+MHqcmIAAwGuq/WiXHn7FRK4LxxsPr3kRKUuqUNC6+gMk?=
 =?us-ascii?Q?MrafjNMIIRYncI4Icux6awhpt70M5j9KHfNwhwQOITrQoIHb+uoIUDO4Hzaa?=
 =?us-ascii?Q?TlUd9Q3vRT8BxzkmBQa3Td8FAuJKvyK64Bur5qcRRwcYLVR+FSvwaAPY7M6G?=
 =?us-ascii?Q?XOd7BgvUhnV7V/BHpIu7zSTcmPMMGB9bwc+X34xmk8pcFUG30YDVwEr0wyjd?=
 =?us-ascii?Q?kam4Z1UaDsPSpkOYPtQ9H4aQIG6sA9AGpTWtqXm57j1q+2vNYTCd7NnVb/XC?=
 =?us-ascii?Q?dlyxFh9guMWf7GXhQBcQqSw+eUk/LTAe9L0tMNaWDLhEovjWgciL2M5nfQBL?=
 =?us-ascii?Q?x+wphsatfai8rXSjnELCKAcvzz4iZeTZrrfAz3+ygvpBW2ie1xmxoAlSHLPA?=
 =?us-ascii?Q?bjJrOAYsuiMhvJPWIaSakPi0TuNM3M9VwW3STtE78uLQTMG9BKe9XXpDFvZH?=
 =?us-ascii?Q?GHLwA8p0MIMvXUiA2N5ek4V8AwJfdBROshCSPn8eMBYWFX1G5hJ1z4FWWkYR?=
 =?us-ascii?Q?pTEJvwI+I5rGazll/gP7jX+6aLocvSRGpI3+bLgxHhfvOu2v1hcSeBV65VZi?=
 =?us-ascii?Q?eAeG0Cs/bnje9jE3Mnu1eVytiph7eFxb6qETufG9XyBXadOjihtD1b/++EC+?=
 =?us-ascii?Q?S7HcZRHPJs+2N3qApJFh2GLnuAQAcXQVDIGuruKPD+yey0/emzAb1Gm8vm8b?=
 =?us-ascii?Q?DUuhAhP6gDDNlJZbdoYIseTMxq9ulv30SBo+5rwt39U7p7N5chdMQYq4a59w?=
 =?us-ascii?Q?2s89ElrZJWGdTfd97eHYDlHX0fCcvLnZSA+9FnIn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb86646-c02a-4d54-385d-08ddd57f6618
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 06:55:31.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LruZ2RNmTfLsF4cPQMh3GVIQv9uMeQcKjHRPfvHgRC7+Zi7ys8ip/ctv940CD7oEaEyP8l+Y+XryDYHG5gBY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

Hello Bert,

On Wed, Aug 06, 2025 at 08:52:01PM +0200, Bert Karwatzki wrote:
> Am Dienstag, dem 05.08.2025 um 22:52 +0530 schrieb Gautham R. Shenoy:
> > Hello Bert,
> > 
> > On Thu, Jul 31, 2025 at 11:23:15AM +0200, Bert Karwatzki wrote:
> > > When loading the amd-pstate-ut kernel module (which is supposed to test
> > > the amd-pstate cpufreq driver) the following crash occurs (most of the 
> > > time the loading has to be repeated several times):
> > 
> > Thank you for reporting this. I haven't run amd-pstate with PREEMPT_RT
> > yet. But for the following issue to occur, we need the schedutil()
> > governor's sugov_update_single_perf() (which will eventually acquire
> > the read side of the cpufreq_driver_lock) to race with some call that
> > acquires the cpufreq_driver_lock on the write-side, thus forcing the
> > read-side to take the slowpath which can block on PREEMPT_RT .
> > 
> > The amd-pstate-ut has the amd_pstate_ut_check_driver() which will test
> > switching between one mode to another. These mode-switches involve
> > unregistering the driver, and that callpath involves write-acquire of
> > the cpufreq_driver_lock.
> > 
> > So the race should potentially occur when the following code-path
> > through the amd_pstate_ut_check_driver()
> > 
> > 
> > amd_pstate_ut_check_driver()
> > > -> amd_pstate_set_mode()
> >  |-> amd_pstate_update_status()
> >   |-> cpufreq_unregister_driver()
> >    |->subsys_interface_unregister()
> >     |-> cpufreq_remove_dev()
> >       |-> cpufreq_policy_free(policy-cpu-X)
> >        |-> write_lock_irqsave(&cpufreq_driver_lock)
> > 
> > running concurrently with the schedutil governor on another CPU.
> > 
> > sysvec_apic_timer_interrupt()
> > > -> try_to_wake_up()
> >  |-> ttwu_do_activate()
> >   |-> enqueue_task_fair()
> >    |-> enqueue_entity()
> >     |-> update_load_avg()
> >      |->sugov_update_single_freq()
> >       |-> amd_pstate_adjust_perf()
> >        |->cpufreq_cpu_get(on CPU Y)
> >         |-> read_lock_irqsave(&cpufreq_driver_lock)
> > 
> > 
> > Here, the read_lock_irqsave() has to take a slow-path in the presence
> > of the writer, which can sleep on PREEMPT_RT. But this is illegal as
> > this is invoked from the interrupt context.
> > 
> > Can you please check if you can generate the same lock-up with the
> > following script without relying on the amd-pstate-ut driver?
> > 
> > -------------x8------------------x8------------------------------
> > #!/bin/bash
> > 
> > while ((1));
> > do
> >      echo "disable" > /sys/device/system/cpu/amd_pstate/status;
> >      echo "guided" >  /sys/device/system/cpu/amd_pstate/status;
> > done
> > -------------x8------------------x8------------------------------
> > 
> 
> Yes, this script also causes the system to lock up.

Thank you for confirming this. Let me see if we can delink the
cpufreq_driver_lock can be delinked w.r.t access and freeing of the
cpufreq policy object.

> 
> Bert Karwatzki
> > 

-- 
Thanks and Regards
gautham.

