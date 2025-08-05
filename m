Return-Path: <linux-pm+bounces-31972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5D4B1B940
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A1626E94
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090F299A87;
	Tue,  5 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MHm1iMEx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8629993B;
	Tue,  5 Aug 2025 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414549; cv=fail; b=bJm6qjy7YW2lbYEqNBPy2Tuk+i1xPA3X1uDo6yTqB4VODcZhbvlna6xIGp511RuZmi+fhduf8Bj8iGjtBWi2s5eO007hJPbjkWXwJWwCDQKwsoC1dJOehyOehb6+0gFoYDS/0MX1rICrOW+D8fhQEkjBsiX6HSc/zT25PnoLCa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414549; c=relaxed/simple;
	bh=wWVn0lDu3Q2u7GptKqT97zsCwK97y/JI5Z7eDSQyVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E4xLmBYvW3JDVCxFjHbCeVEIUzFtDo18CDB1HDGwyapWN69Q7zFfqOreQLS74v2hxm5m/ON5AievrbOVOMKwh13id0BK+KviZOosLhV1HNrWIqAFtPNT1gP1RBWpyjLpBKLWvCUdSMMIQhWkIpFr37gpfSHPUsK7ZJsRYPzws60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MHm1iMEx; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylajIqxWZIsg04Dj1yfU5OcGXtaoNbhqQtPxlRxgcvTWWyHozazCR4Ay/o5pPYky+EnEzW8jBumbtKY4nh6I+qINg/bIqaNsUj3Rf7jyfv0HWJjS9WH3UmumuWLYDHsVbU5RVvSzDHtcZxtB6+JQn6lPUWz9YLvturaLW3oskP67kQCP8gjEk2IWt7Na2V5EpG83y6CLt71vtq0MsIyfQN4nSyWt2JYo/9VjZZFLio9SmWljrpjjt83o8DSUNnREwKUYNJeq2I0YtcKFR3hwn/fcBainxhn3AEM6fKiKTYzKFRBqLKmLcxNtA5d2ti1bYUcXPsT2zaIZHloDTgCcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K15Tfzsa8HrQUD/EayzFLy8cGr1WysRmykUNwgTvn/o=;
 b=Z8z1ercY2gUh+lmKZ6Tlb0jvGPaEomT+XEGaFoOYD+MgYfHHUgjIygg+2WXx12a266VPq+oe4VI/h5VM+klKQpUFbKMfe5466gEl2vSkj44B4QGaMQYZRcOJRZB+xkrnMSXeRhjxcCPmesGvZJTAakrlCYCTvMfmn4oumsEAVbSIlhc4rSiobwsdqkcAoCpgLF2KfxbRG+YRuIjrtgE8SaJERffdtztPwmoYK63bfVZcHrt1KP7QdbueKh4u8OUID7Z4kKjT2a2sQwbEOsWTp9pa+2+FDsg4hWmATzlGXms5Hpna6E1SPRC0N9wMgQY4KwkoRKAXDYzUhvn8kTSGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K15Tfzsa8HrQUD/EayzFLy8cGr1WysRmykUNwgTvn/o=;
 b=MHm1iMExDWcHxtwX35HB894cwAdz7Azy28UGZwM+0waUWanaWD86zpxtU6Kya4pOdCS6pmAlQEWBnbjKFrucymMC5aTwaOXcdJhKZkLLSkotBvMX/00sAzfwh8cGqNfxgkjoRK4RewrboT+pBekLzFMQfjYTPEzyuw52dsUOKHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Tue, 5 Aug 2025 17:22:25 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 17:22:25 +0000
Date: Tue, 5 Aug 2025 22:52:13 +0530
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
Message-ID: <aJI9xbIllYV7ON8S@BLRRASHENOY1.amd.com>
References: <20250731092316.3191-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731092316.3191-1-spasswolf@web.de>
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc95657-b9c4-47a3-070b-08ddd444a529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8lI97FGbJmpZITleLVPrZJDfBZoRqJWlUhzctUJBLyj8ugbpxOGUSJCytN+?=
 =?us-ascii?Q?/6wr/8gFs+vLjla8j4/WARGB0GQhO78j7XMM14x8ukUPll2quTVTjBbddCY1?=
 =?us-ascii?Q?chPuQDdilkL6wpMt8VAe8zNG1W+an5JwQ/UmIPtXrfcjkYXXKGy1QsSn+wB1?=
 =?us-ascii?Q?rE9EPnDLde5NpnD1ILk1oM6A9ORGX3tsBH3c1kvIX4kSF0tqECOAFLxMNshw?=
 =?us-ascii?Q?ZjncYiP5BgVua4VUFFbQFyWDPXB5qMAEPDUl51cSQc+S7c+sraZU2JRdM3sI?=
 =?us-ascii?Q?eRJ9nYU0p0yfkDKaY0KLOhoH5QFEygGQ2ElrhH0eAqAPMsjdQILRIJ7v3iBE?=
 =?us-ascii?Q?sK4klzUcHar+XQ3kFfDaF4qsmOnAj83jEaTRgLc+83eH4T7SbhcZAOKxbQTM?=
 =?us-ascii?Q?fTQ/BcrfhYRgqYW6WCoK5tb5bG0MbKErmVzIZiuDsR7sW+Gx26opM863EsOn?=
 =?us-ascii?Q?NJkrKOpkMItVG3bXiwQy7Qiv6NaQixwFNF7YcxxPe8NsiDZQ8Y0BGUUm7gqy?=
 =?us-ascii?Q?EWOk4CTLAirsh1qtJ0Ph/t7WdgE/moA7rfDIFgUxINSvd8ih1M11tjdClopx?=
 =?us-ascii?Q?xeKn2uYjAmYPw6u+VyTANVbeO/TMQvB0YTks72vsVkRtq8RiS+cgfzdIxINB?=
 =?us-ascii?Q?GE/hZMkmi6YsiUOZQh1HXlvfwk0vDXuKUxCPB27ALa/5NIFlO9JtRtrAY64V?=
 =?us-ascii?Q?d/yecWsH6Y0iGjXWpKOZc3DB5BsQCrkggTbX7nwCoYCqeyPHcpOaVYBhch0Q?=
 =?us-ascii?Q?vfd6zUwnRewZWcnzXaZcsC211QSbXY17mWNpotH34vEWyf1+885OnbrNGjHt?=
 =?us-ascii?Q?hkb35cYcQVYbC0cJ2PuPnw4SFPX30wDWZ3YMhbUN7LzauiXP6sYSE7FsWlyX?=
 =?us-ascii?Q?/PCUikpckSLCace95QmmpO/648GjQptOM7lSMKkY81ElWu+b1JmaOdFk3w23?=
 =?us-ascii?Q?Xhz6TAXcZ8/lyA0dYw6a4TMON0pv/WOtNmI1jjsH/Bh2AkvC+W+fBzgy1WEf?=
 =?us-ascii?Q?ujMFo9/Y6J4G5E0i5ThTXB1kSKRtq8u7Eu1Z6NcRAq9DO9CWgP1P2rr9heYL?=
 =?us-ascii?Q?fzUaGpzEq2uo8y1xVuhqF/MdU4xWIN9/8487v545r0vbWwkYhkDeUIW8jxnG?=
 =?us-ascii?Q?54ZMIniRif8SJvCavHi9p6Cz3z1eC5lzA5gFiqz77g5IN1ZnxR5QLfgqA0Av?=
 =?us-ascii?Q?+egZlQWMMsuI2V3ikWOXVC9BAHZW6uOtOLqK2i63rsKE9MQDExD7e0SPlUTk?=
 =?us-ascii?Q?FXCxz5AV4tLx2afW7YMDL6cdT9Jr8BKEbUQum6cIVF3nrto7R6Gsx5RFqBIS?=
 =?us-ascii?Q?nF5LYtU1K0RLiuA2v5+jN/akiVIRMBvmZ82YV9lq65Bl2LrBXUeTiAGOHS6R?=
 =?us-ascii?Q?5d6aHnk2Z5vc3MwflBpGha//xGWbcVtU0QvbFsK7x0ffMTqwKu5Lp2aSOIFI?=
 =?us-ascii?Q?tbfy6+rurMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCZCDj4rWobUs1ZQFGUB7Hu1iY23KNOoTiZ8w7u9rvYEvpqo7Vt0oaiLzk2c?=
 =?us-ascii?Q?BgJcCkm9LkukyGFokpwlP/fR2CrKo3WO4ikOdvmZ4yTYgMwCz3twrtxPHNN7?=
 =?us-ascii?Q?oVR4NoLURUhSatPSi+IPCV5ljj39S43+JbLagXnI0QJICQ1LqjFXhVD53hJ9?=
 =?us-ascii?Q?CEPm6QGYhn7Rmv/ZNNLJeKNOfL+6RKcu7IaoyoPdD3USmmzl2NflzZ/pkwPK?=
 =?us-ascii?Q?Y6IHSZlcflJgE7J+E/5znfYlEFsSjV7TQz+QAtU/S0/H8n/xmmmHu8ldqtqu?=
 =?us-ascii?Q?/oTJnLtS1n12ZPyJ/RxQ1Kj1jQygdd3j9fZVJZpuEpeBHNQ5B2Va2/gxaOG0?=
 =?us-ascii?Q?j3vzlHWSzZt0EPubYeZtXT/va5I/q35Pc9yMA4Jia1zDIYvAMX/WsTtubg/a?=
 =?us-ascii?Q?Sj+26RpUvBEj/yUtqGRg7/C6Z2S8jfGn583G37EWH4ryP0TAzP/0v0vC0ELl?=
 =?us-ascii?Q?DEWx4OHc6lnlE1Ro4i+fIOgLpH+v02NKowmZScZ65nlk8yCMrI0vRKvSdjlo?=
 =?us-ascii?Q?bWEsBHyPL8G46KKmMniZFcA1KzfkuVUvyLTPQBMfWQPWhrWJQ1+m25UxijYk?=
 =?us-ascii?Q?l+dFj4JvmFKAjwPWNwz22XdcfV9f9lkITrjIggXTqXAePonQBeu4721u96El?=
 =?us-ascii?Q?tQRi26YGJGw6dvYg7YK2sYpYu6ecerxGd7/41cx2Sl+xhnqJNMsH3hLdl6RJ?=
 =?us-ascii?Q?iOODX2K38jkW/l4dE4pYEJpGVHoO+tVHYCMVKqghVOZPFrBfuu8nTnRRO1ve?=
 =?us-ascii?Q?ja7hCqnkozgswUULS4aqM+/BGVJrohdoaB9P73jrQtLZLJmYFfQjG/Q2SIkd?=
 =?us-ascii?Q?duVEgO2s9h/aM3Ahc4Goaiqb5DUE4njSxQ/sAH+PloV7oV1EDjejOjLlvROI?=
 =?us-ascii?Q?/bkqx4cDPAdruav4u+qfCbpZAEJs/6wpD5Un1FHttQc7AfqegLhs94Pl+CAf?=
 =?us-ascii?Q?T/nCpwg9SCtyFQVhxPQxjFe3/8z1mYePcqjjRmtnquHaZBbb9OuCz8YRSAYm?=
 =?us-ascii?Q?OU9cNjz6DuWhYzrDt5pjTptuGHSEmpD5k55vjcR5ifwwm02OcxYHP9YrlBwq?=
 =?us-ascii?Q?YsYGr0xfmfqOKU5PlQd6TM8WM8Rpo8pfJPP5/SIo827x3M53rKTnxYYkm3D2?=
 =?us-ascii?Q?/wm6pNjaZBfYNRl3Hn8/Yvu7nUvWjbGSmNJULfzIWVf9lkFQ/5RVPMj94cIu?=
 =?us-ascii?Q?1M40/ZmOWyyUBN6obFFt1tKkfprmGyfkHELx6HEdL/uAci48jS+ltvLO5/C8?=
 =?us-ascii?Q?DwNct1wVQJuFgTAvnzeAfQxFSlLQv6ETe6nx+Jgq7KARxzfgyJ/r2N/WXe2t?=
 =?us-ascii?Q?sx+Uv9Z4F24stWDfv1QcVKoBn1ipcW9d9qKPUPxzradxUe5mlQ5055NgwusI?=
 =?us-ascii?Q?2MPU6rr+kAL3Gwve9t1qJyyeOP7hoD5Cn7ReO3tv54q/ONUCPqk5C6WFuh8m?=
 =?us-ascii?Q?m+CLieqhweQA+oZdrCo2uBC2UxGqmv9FyWCEzuX1iNpL1e3jACffSFN6Gzdg?=
 =?us-ascii?Q?C7goa68m1G4BvryWRnBoFBXZur59JlIH5afJeXWsKhd7/w/j8b7O8PSb4PUY?=
 =?us-ascii?Q?IcjheM85lypjtRHlrHtfwtqsaob8kk3K939hvMtH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc95657-b9c4-47a3-070b-08ddd444a529
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:22:25.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjKlhPggwHI/D2eWs9GbTYFKXIlTv70cyjQp9R8DAOSEzFttNklKDjfPa9xTk4ihVumdNCS7I3GQBMPwdnr6eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

Hello Bert,

On Thu, Jul 31, 2025 at 11:23:15AM +0200, Bert Karwatzki wrote:
> When loading the amd-pstate-ut kernel module (which is supposed to test
> the amd-pstate cpufreq driver) the following crash occurs (most of the 
> time the loading has to be repeated several times):

Thank you for reporting this. I haven't run amd-pstate with PREEMPT_RT
yet. But for the following issue to occur, we need the schedutil()
governor's sugov_update_single_perf() (which will eventually acquire
the read side of the cpufreq_driver_lock) to race with some call that
acquires the cpufreq_driver_lock on the write-side, thus forcing the
read-side to take the slowpath which can block on PREEMPT_RT .

The amd-pstate-ut has the amd_pstate_ut_check_driver() which will test
switching between one mode to another. These mode-switches involve
unregistering the driver, and that callpath involves write-acquire of
the cpufreq_driver_lock.

So the race should potentially occur when the following code-path
through the amd_pstate_ut_check_driver()


amd_pstate_ut_check_driver()
|-> amd_pstate_set_mode()
 |-> amd_pstate_update_status()
  |-> cpufreq_unregister_driver()
   |->subsys_interface_unregister()
    |-> cpufreq_remove_dev()
      |-> cpufreq_policy_free(policy-cpu-X)
       |-> write_lock_irqsave(&cpufreq_driver_lock)

running concurrently with the schedutil governor on another CPU.

sysvec_apic_timer_interrupt()
|-> try_to_wake_up()
 |-> ttwu_do_activate()
  |-> enqueue_task_fair()
   |-> enqueue_entity()
    |-> update_load_avg()
     |->sugov_update_single_freq()
      |-> amd_pstate_adjust_perf()
       |->cpufreq_cpu_get(on CPU Y)
        |-> read_lock_irqsave(&cpufreq_driver_lock)


Here, the read_lock_irqsave() has to take a slow-path in the presence
of the writer, which can sleep on PREEMPT_RT. But this is illegal as
this is invoked from the interrupt context.

Can you please check if you can generate the same lock-up with the
following script without relying on the amd-pstate-ut driver?

-------------x8------------------x8------------------------------
#!/bin/bash

while ((1));
do
     echo "disable" > /sys/device/system/cpu/amd_pstate/status;
     echo "guided" >  /sys/device/system/cpu/amd_pstate/status;
done
-------------x8------------------x8------------------------------


> 
> Bert Karwatzki

-- 
Thanks and Regards
gautham.

