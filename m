Return-Path: <linux-pm+bounces-37232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD85C269D4
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23F11A65DD6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC452E7BB2;
	Fri, 31 Oct 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w7BuWHf3"
X-Original-To: linux-pm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533A1898F8;
	Fri, 31 Oct 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935866; cv=fail; b=OfkWIIn0J8VDD1I8ejScDZYfXgvLyoAyLlb2yAtyroP0KpOKziFGOfFOssvcQl1HEAaTg2p8zM2kJ+St9ahUGzf9Yzgb9Mi1KLBVvHvgjkkvFMTj3kGY8wsr4KhGonRgKJmzubtMqD03M2/+3xjLGcDpdfOqnSwdWd5FS8315V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935866; c=relaxed/simple;
	bh=UVCPafpwuiSi7M5NwiY+qZXRUWJZIYjfeiltkAXJIn8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krPx2rkD+mFXYdo17quztIWPOMqLbvUKr8/xKCe1xsF+Nb/xFDyc/LCJU2qZ2rvtY2sl6H3WUh+6pDaMb+2neKvHro5OMVWCUbTYuqf9FnQKb7mLDNopsjw8F4AROpFtDHINNPgFBEKmgfm/irI4OIEiqBeDJhn4GLIQbdwfPMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w7BuWHf3; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1kiiHkSzfFXrzapJUPehQoVhomSm08W7BWbADQslnilX6IqitBrM08BgqUlYGowktom6VDXKzdQOStIqIzke0aSqdcSs7gFV3IjhT0f8mrvXlnMCsz01k4Q1i6t84vz1BfjUPyOxwbMdPVFtuOSwuEsBfQlOG6G1tP0cs/vH4KR9vm1uIBtQh1nMurCg3CB5J1kTiVdXgOTMpgqLJnt3sDRSV5xwPSjCfm9gGsX4AElD4UN60AhdFSPkWe2VSDo/ygo1MYqtzAVOVOALe2MJsIcQgpdfLJZ3tUMfuZG7y+wn8UKzb96G3L3spfeTz4MqWpGNyn6JCr+GE9h6XjsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfiAQqLSFO7DPRaFPGThA+RXZLPPks8HIOeQ4HMu3ZA=;
 b=oL8VNm/Shh5jgDsK5kwA6QqxVCa3RJJnz3Z8MX2XUlTrptDPBS2Da03NiKeafSe5OnLrIx8Oa/ZUIVUhFahyhbNmdqnJ/+IHvR4dg9/N1i3+gZGHFNCMfntJrMpCp2W/PKWqohwfB8sF/wHX9Ms0KVrj4hdZbnxZWpjeMNKdjnWtZXntWZLPV9tataJVTPlqW5WlL78+4DlaSqU3f4nM4iGJ3eCOpvfGesxMIqlYtdZLyBQsmQeK63Tu1gEHsGSdXK42aPN6xLRccbzZgq4uZIr09vrXzgeUaDfqtYCjrl2h+MrRRglPxgBJFEqAUA5nFeTmIJbsLePg3SahNUlAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfiAQqLSFO7DPRaFPGThA+RXZLPPks8HIOeQ4HMu3ZA=;
 b=w7BuWHf31TXBsNT4UOKPvsSwiQscWgoWaG9ZNoN4DUn0WJDcFj1iEO6W50SFlSfSiyON1TA+0yAVWp9GhlfJDOCVZtyS32E+gaOXPeZpCp+SsRM6ipGBXKklHY9gKvCD4P604woMZwP3+pORAP43LSNQXoNl+734P9Lsq3rCPW8=
Received: from MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Fri, 31 Oct
 2025 18:37:41 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::22) by MN2PR04CA0015.outlook.office365.com
 (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 18:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 18:37:39 +0000
Received: from DFLE100.ent.ti.com (10.64.6.21) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Fri, 31 Oct
 2025 13:37:25 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 31
 Oct 2025 13:37:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 13:37:25 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VIbOkT163299;
	Fri, 31 Oct 2025 13:37:25 -0500
Date: Sat, 1 Nov 2025 00:07:24 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, "Maulik
 Shah" <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
Message-ID: <20251031183724.2opdnjya7gu6fx6v@lcpd911>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org>
 <20251029081014.443psmqznd2pqm4i@lcpd911>
 <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
 <20251030164542.atnhs4wgk6ggmmly@lcpd911>
 <CAPDyKFqTS6-69QfqdPtRrbkSqwxEnO1CPXLnRvM6WsOKNZgyQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqTS6-69QfqdPtRrbkSqwxEnO1CPXLnRvM6WsOKNZgyQQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: e0af65eb-486e-4894-fe1f-08de18ac9201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7fgoWfFWthDAXbvawLZP/hCpV3izLCRT3sPcGl2gYRLayu8A8RCY7hypLq8w?=
 =?us-ascii?Q?kYBDkj/9GQhFr9n2TL75VYtKjKxP6aI2HMF6IH9fTCSeDsvfd7kzcYmIdYQp?=
 =?us-ascii?Q?RUal2GCWqBnEUKUsYaMJ/fo2R4D9fj7mn0qe2rpMpjM/Oy8pbN2EOs2M7ojX?=
 =?us-ascii?Q?ZELfhP3RtpCD2GEQpD/8iLAPiO3IGiK9ws6e3U7/syQ/7SuMKv+WDGV7P5rg?=
 =?us-ascii?Q?g0tMI/lf9vXEoowXgEt68TkTj4xnPQeOclCyWQql1X71StUYJoCGjHGiLU0o?=
 =?us-ascii?Q?xnfHjdgjIR+RxuJClS4ft7fR39EovWbzqslI0Hk2FMm74EfOuTyV05NsVRZU?=
 =?us-ascii?Q?P2YWuVlEbRD1uNBajZ/YGIlP2iY+GgveluQqepdpGIXmw2Sv7nhRSl1EEUCe?=
 =?us-ascii?Q?86BidHVj+9QYL0QXmQKeY0OVJq1wHZFOA51frQJSGdL51KELHmP7HDQMgXnw?=
 =?us-ascii?Q?gbqJREd2VQ5vm8ywmkh3AWRcoI+3ItTUiTAAVgU2BTk5hV6r3mrN65pkhP9v?=
 =?us-ascii?Q?0bzZS7r+yWdR8W0JarxQoyqB/KOB3mUB7qllpwARoMvk5yPAzji6YuZR7jdU?=
 =?us-ascii?Q?Yo3w21MNoRu0N2zdZlvHKZIKWSyryeNrPDFJEdJApl1xgWejmc2WLZFtpSk7?=
 =?us-ascii?Q?3Dwy0EtQQO+6IxUDZ5Ywo+HKbP28pYG/eB975efd4gK7PUcl06MZAQrpnoS7?=
 =?us-ascii?Q?wBXQ4SHGqtjfjWfN/YTCWoanDE16sEb2Yt+LXUzI+nHSg6c82rlxhqyX8EF9?=
 =?us-ascii?Q?Y5IkEqyODkFB7PHdCr51P7RVzhu8l1Al23QR4a3TBRfic7NYwW6QUwl95ley?=
 =?us-ascii?Q?JKDoCYl9Rf/OWPEzXswblhv1sCXvhj1BhQT6ZahpVb6p7DVFWPs68F1y/N7o?=
 =?us-ascii?Q?fN7sHwco8o2vo7NpXAx1DX4fhjgcGbxsE1MNdyDFvYk6BFeNP1/wEvHDn3LK?=
 =?us-ascii?Q?uUxeHJEzuZWrnrenAeNaTKCwyNiEZebdWLD54xBodFzd3TTUL9yLqY0oJzPR?=
 =?us-ascii?Q?Iyqd2gRSB2qy3A/6NJLPzidTWcsyKygYahCzTjQy3KQLNHPPbQZFKtTFV03+?=
 =?us-ascii?Q?owobvX+lUoNRC98xufpiJ2hiANcgjJ0MkhZhgL+kDQ0P1Wn+y0wera9rz0rs?=
 =?us-ascii?Q?JFbaCatawrwTKDB5k+QALCtufkoXkI9kNVbx/+A9E4VeBopX1Si7LWpmU6iS?=
 =?us-ascii?Q?Wr6q8UokmiSOyDyLxd5tSOtcv+acPd2w28sCJbhGpJw5BQePAjAkWqTqoTV6?=
 =?us-ascii?Q?UPgedjZwxU+m7KulFS7WvZ23rN3bzeiTcnR6CO4tVMKOW18vUuLi6FmxKcGa?=
 =?us-ascii?Q?35jGaogbKk2EQsP7CIXso0lbddWsIokePX+aDxQ5iS3n63Mr+Uc9d05rfvSv?=
 =?us-ascii?Q?EKIUVEYUVBvIIcXtcEI8SbaqCuxKFYrvl61pgJw2l/s6uC8Evq10u0nn6lEc?=
 =?us-ascii?Q?mmx9pKsgSVrMvhxGeJV3Tr0QwdaQ1YII9SFbv+mXJFse5r3kRelyujCOEZjv?=
 =?us-ascii?Q?jA6F5iWGoeIWIK8tILj8dK7JavS+zJKryv81g4fF3lkbTFZZ8ikfRnS0f/G7?=
 =?us-ascii?Q?OB/nzHJoCPOfkXvoEV0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:37:39.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0af65eb-486e-4894-fe1f-08de18ac9201
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008

On Oct 31, 2025 at 14:47:29 +0100, Ulf Hansson wrote:
> [...]
> 
> > >
> > > > It seems an overkill to me that a userspace program be required to hold
> > > > open this file just to make sure the constraints are honoured for the
> > > > lifetime of the device. We should definitely give the freedom to just be
> > > > able to echo and also be able to cat and read back from the same place
> > > > about the latency constraint being set.
> > >
> > > So you'd want a sysfs attribute here, but that has its own issues (the
> > > last writer "wins", so if there are multiple users of it with
> > > different needs in user space, things get tricky).
> >
> > sysfs makes sense, then would it make sense to have something like a
> > /sys/devices/system/cpu/cpu0/power/cpu_wakeup_latency entry?
> >
> > IMHO userspace should decide accordingly to manage it's users and how/whom to allow to
> > set the latency constraint.
> > We already have CPU latency QoS entry for example which is sysfs too.
> >
> > >
> > > > One other thing on my mind is - and probably unrelated to this specific
> > > > series, but I think we must have some sysfs entry either appear in
> > > > /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> > > > state that the governor has chosen to enter based on the value set in
> > > > cpu_wakeup_latency.
> > >
> > > Exit latency values for all states are exposed via sysfs.  Since
> > > s2idle always uses the deepest state it can use, it is quite
> > > straightforward to figure out which of them will be used going
> > > forward, given a specific latency constraint.
> >
> > I disagree regarding the straightforward part. There could be
> > multiple domain heirarchy in a system for eg. and all these multiple
> > domains would have their own set of domain-idle-states. All of them having their own
> > entry, exit, and residency latencies. I myself while testing this series
> > have been thoroughly confused at times what idle-state did the kernel
> > actually pick this time, and had to add prints just to figure that out.
> 
> If I understand correctly, most of that confusion is because of the
> misunderstanding of including the residency in the state selection in
> regards to QoS.
> 
> Residency should not be accounted for, but only enter+exit latencies.

Understood your point on the latencies, however the point remains that
in a multi domain , multi idle-states case, do we really have an easy way to
determine what the next choice of idle-state the governor is going to
make? We don't even expose the entry exit latencies in sysfs btw...

> 
> >
> > When implementing these things for the first
> > time, especially when one has complex and many a domain idle-states it
> > would indeed help alot if the kernel could just advertise somewhere what
> > the governor is going to pick as the next s2idle state.
> 
> The problem with advertising upfront is that the state selection is
> done dynamically. It simply can't work.

I understand it might be done dynamically, but as IIUC the only
constraint being taken into account is really coming from userspace. I
don't think this series is taking into account or even exposing any API
to kernel world to modify the cpu wakeup latency (which I think you
should, but that's an entirely orthogonal discussion, don't want to mix
it here). So as far as "dynamic" is concerned I feel if the userspace is
having control of which processes are setting the cpu wakeup constraints
then it's entirely okay for kernel to tell userspace that at any given
moment "this" is the next s2idle state I am going to pick if you do a
system s2idle right now.

> 
> >
> > Also, I am not quite sure if these latencies are exposed in the
> > domain-idle-states scenario ...
> > I tried checking in /sys/kernel/debug/pm_genpd/XXX/ but I only see
> > these:
> > active_time  current_state  devices  idle_states  sub_domains  total_idle_time
> >
> > Maybe an additional s2idle_state or something appearing here is what I
> > was inclined toward.
> 
> That sounds like an idea that is worth exploring, if what you are
> suggesting is to extend the idle state statistics. In principle we
> want a new counter per idle state that indicates the number of times
> we entered this state in s2idle, right?

Absolutely, having a "global" kind of a place to find out the s2idle
stats would really be useful.

> 
> While I was testing this feature, I used trace_printk - and afterward
> it's easy to digest the trace buffer to see what happened.
> 
> Kind regards
> Uffe

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

