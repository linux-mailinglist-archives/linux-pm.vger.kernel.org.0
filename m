Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0037E11AC7F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfLKNx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 08:53:59 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:62161
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbfLKNx7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 08:53:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc0NS3JxDQJUAS8V8h/GpQfCZ2iLDDT3nsyJBUeNfKI2oxIkJxH0oQsMwOGkKVR46AmzauoOd9LKBNJsSuTlRSuaZrWwSTI7VWNpU4THNWgRyopqG69UsPIB/+eNGtf5nBYGnNndKdH6f+wi/51qrYR1v7sA2zQ9Bb45wOD2TpmM1JzgBvMmwckbSRqem9ytOW8ua6nSr1fcQxUJreR73RZsTYW8klMD7VJljyoBp1ZhImBtU2Jys5hz1oR3rcmDaudxHYRkQLivCZQLYjsO7+rJi/n5DI3uWIs3+FXWGd4WhLPcsgEOSZPSlYykjvHy2xwXRqQwVYa5YctMSI06Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDwd+HwhtvMtyQOYIQnVNrMQHGgRrNjpEwdyyhATexA=;
 b=ZV/vo59BTT+NlruauYlgeiPmzppNGGP25xsHATu6nFSolvGib7nay9VmClAv6pzF97YDEvl/UIOARpbVQP0xodCTiBMn/4VYle/Idv5wqmnFSqvbDzu2uoL76fJ/0Tr0CoLR8OUssp3ostDgMwCoptXatJ5k+0M9VuIWR1RFUsoT+NxvUifb/LjfRzd61wp60Xi37J2VMRhW99s69pVFaSvyXtJ40Ho9gEBMkOdGCpMuwd80c2PwGXUQMCdhQUj/K9nNCcmOgE51n0yDR60UxKIiBPv2fa/3pUba9N57GcGIMvrI8+ePIE1CGA9Dttbja8ks2cFRTRFnx/ae0NV7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDwd+HwhtvMtyQOYIQnVNrMQHGgRrNjpEwdyyhATexA=;
 b=LYiKSNtWgdwKa4c4FghtWUf+OPZLBOLqaDnMiE/TRwNkxmxTTHs3dTSrCJzrmP86ja1thJytqUN8V4POtJ7Xo0QMdSyxP0iwQw5HLLMpmlivUjg0SiOlcorvxmlhgu6yLvEGSbbf2a4SyfXRbJlFGP1fBdcYwpx232LUDvB91eU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4161.eurprd04.prod.outlook.com (52.134.93.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 13:53:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 13:53:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
 offline
Thread-Topic: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
 offline
Thread-Index: AQHVsA3EDzSFHj7KNU6J91t89hdJZ6e08PAA
Date:   Wed, 11 Dec 2019 13:53:50 +0000
Message-ID: <AM0PR04MB44814D98FDF152FB6D186B13885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <2691942.bH9KnLg61H@kreacher>
In-Reply-To: <2691942.bH9KnLg61H@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bcacbb9-f9c0-4d52-e61e-08d77e418d79
x-ms-traffictypediagnostic: AM0PR04MB4161:|AM0PR04MB4161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4161C1C75184AC25B6CEEE19885A0@AM0PR04MB4161.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(189003)(199004)(9686003)(81166006)(45080400002)(8936002)(478600001)(7696005)(81156014)(26005)(5660300002)(55016002)(186003)(6506007)(316002)(54906003)(52536014)(44832011)(66946007)(966005)(66556008)(86362001)(76116006)(64756008)(66446008)(8676002)(71200400001)(33656002)(66476007)(110136005)(2906002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4161;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SSrciHdnColGpIGfBS4Kx6VlYiN4zkIXAKrZG6xxHdHszCDJpmLAUPDVLraX30b0G8CmtltVJuZZgOgfuoM6RO0c+u/gtpRNeNnFLvrVa9WWg5+o9zhvPrOLHQgJfzppvoCoebrpKDrPqYEvzKEAz+HEXOIjvLtsMmIMcSfYqUV1ILXQGoBUj0W9EjyVbm1ntVFfJtAj00zZCzgYQlVFeKgmA5R7G0w30mKxWHdBMBQ2SAyDoxC00YEnPI7RvAkyhuOX3rERx/K+GgNKMefyKkf0tHfCzijFtBAfHa2jaHdcdkNywq65K9Cg1vkEuumnB//pku3hMujgtCEf/bFO1Xq020KmRcEIHBI8yEQP6K4nZCLIsvfaczF8mwDi9/YxJqQP0FA/pyDl3WrHirLcwXiZN0MeTr3Uo6sQNb3dOJ6UmPGQPCeTyAXEfOIcwn6S6TckvMk0nOB8hPdw3XsfMK49knfB3izHkkSyE2o248k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcacbb9-f9c0-4d52-e61e-08d77e418d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 13:53:50.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+Pgkz1qCW5thpuo+9UagH+rfe+giw++fmM0Nb7A63gpRiZHX6NNDLecpELRQtc6k7Lex8B7dtwsLbdFv0ONMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4161
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
> offline
>=20
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The scheduler code calling cpufreq_update_util() may run during CPU offli=
ne
> on the target CPU after the IRQ work lists have been flushed for it, so t=
he
> target CPU should be prevented from running code that may queue up an IRQ
> work item on it at that point.
>=20
> Unfortunately, that may not be the case if dvfs_possible_from_any_cpu is =
set
> for at least one cpufreq policy in the system, because that allows the CP=
U
> going offline to run the utilization update callback of the cpufreq gover=
nor on
> behalf of another (online) CPU in some cases.
>=20
> If that happens, the cpufreq governor callback may queue up an IRQ work o=
n
> the CPU running it, which is going offline, and the IRQ work will not be =
flushed

"will" -> "might"

> after that point.  Moreover, that IRQ work cannot be flushed until the
> "offlining" CPU goes back online, so if any other CPU calls irq_work_sync=
() to
> wait for the completion of that IRQ work, it will have to wait until the
> "offlining" CPU is back online and that may not happen forever.  In parti=
cular,
> a system-wide deadlock may occur during CPU online as a result of that.
>=20
> The failing scenario is as follows.  CPU0 is the boot CPU, so it creates =
a
> cpufreq policy and becomes the "leader" of it (policy->cpu).  It cannot g=
o
> offline, because it is the boot CPU.
> Next, other CPUs join the cpufreq policy as they go online and they leave=
 it
> when they go offline.  The last CPU to go offline, say CPU3, may queue up=
 an
> IRQ work while running the governor callback on behalf of CPU0 after leav=
ing
> the cpufreq policy because of the dvfs_possible_from_any_cpu effect
> described above.  Then, CPU0 is the only online CPU in the system and the
> stale IRQ work is still queued on CPU3.  When, say, CPU1 goes back online=
, it
> will run
> irq_work_sync() to wait for that IRQ work to complete and so it will wait=
 for
> CPU3 to go back online (which may never happen even in principle), but
> (worse yet) CPU0 is waiting for CPU1 at that point too and a system-wide
> deadlock occurs.
>=20
> To address this problem notice that CPUs which cannot run cpufreq utiliza=
tion
> update code for themselves (for example, because they have left the cpufr=
eq
> policies that they belonged to), should also be prevented from running th=
at
> code on behalf of the other CPUs that belong to a cpufreq policy with
> dvfs_possible_from_any_cpu set and so in that case the
> cpufreq_update_util_data pointer of the CPU running the code must not be
> NULL as well as for the CPU which is the target of the cpufreq utilizatio=
n
> update in progress.
>=20
> Accordingly, change cpufreq_this_cpu_can_update() into a regular function=
 in
> kernel/sched/cpufreq.c (instead of a static inline in a header file) and =
make it
> check the cpufreq_update_util_data pointer of the local CPU if
> dvfs_possible_from_any_cpu is set for the target cpufreq policy.
>=20
> Also update the schedutil governor to do the
> cpufreq_this_cpu_can_update() check in the non-fast-switch case too to av=
oid
> the stale IRQ work issues.
>=20
> Fixes: 99d14d0e16fa ("cpufreq: Process remote callbacks from any CPU if t=
he
> platform permits")
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flinux-pm%2F20191121093557.bycvdo4xyinbc5cb%40vireshk-i7%
> 2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C969872a0d7014a14b0
> 7b08d77e24e5b7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 37116569251293496&amp;sdata=3DjEVM3d8btZpjqEhAKEF40PC8dxq4qjQbYAN
> Xi%2BA8a8o%3D&amp;reserved=3D0
> Reported-by: Anson Huang <anson.huang@nxp.com>
> Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Peng Fan <peng.fan@nxp.com> (i.MX8QXP-MEK)

> ---
>=20
> Peter,
>=20
> The reason why I want to address the issue this way is because IMO the ri=
ght
> place to do the check is the cpufreq governor.  Governors that don't use
> cpufreq_this_cpu_can_update() at all don't need to worry as well as
> governors that don't use IRQ works.
>=20
> The cpufreq governor is given an opportunity to update the frequency of t=
he
> CPU and it needs to decide whether or not to really do that.
>=20
> Please let me know if you have any concerns.
>=20
> ---
>  include/linux/cpufreq.h          |   11 -----------
>  include/linux/sched/cpufreq.h    |    3 +++
>  kernel/sched/cpufreq.c           |   18 ++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c |    8 +++-----
>  4 files changed, 24 insertions(+), 16 deletions(-)
>=20
> Index: linux-pm/include/linux/cpufreq.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -595,17 +595,6 @@ struct governor_attr {
>  			 size_t count);
>  };
>=20
> -static inline bool cpufreq_this_cpu_can_update(struct cpufreq_policy *po=
licy)
> -{
> -	/*
> -	 * Allow remote callbacks if:
> -	 * - dvfs_possible_from_any_cpu flag is set
> -	 * - the local and remote CPUs share cpufreq policy
> -	 */
> -	return policy->dvfs_possible_from_any_cpu ||
> -		cpumask_test_cpu(smp_processor_id(), policy->cpus);
> -}
> -
>=20
> /*************************************************************
> ********
>   *                     FREQUENCY TABLE HELPERS
> *
>=20
> **************************************************************
> *******/
> Index: linux-pm/kernel/sched/cpufreq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/sched/cpufreq.c
> +++ linux-pm/kernel/sched/cpufreq.c
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2016, Intel Corporation
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
> +#include <linux/cpufreq.h>
> +
>  #include "sched.h"
>=20
>  DEFINE_PER_CPU(struct update_util_data __rcu *,
> cpufreq_update_util_data); @@ -57,3 +59,19 @@ void
> cpufreq_remove_update_util_hook(int
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);  }
> EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> +
> +/**
> + * cpufreq_this_cpu_can_update - Check if cpufreq policy can be updated.
> + * @policy: cpufreq policy to check.
> + *
> + * Return 'true' if:
> + * - the local and remote CPUs share @policy,
> + * - dvfs_possible_from_any_cpu is set in @policy and the local CPU is n=
ot
> going
> + *   offline (in which case it is not expected to run cpufreq updates an=
y
> more).
> + */
> +bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy) {
> +	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> +		(policy->dvfs_possible_from_any_cpu &&
> +
> rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
> +}
> Index: linux-pm/include/linux/sched/cpufreq.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/sched/cpufreq.h
> +++ linux-pm/include/linux/sched/cpufreq.h
> @@ -12,6 +12,8 @@
>  #define SCHED_CPUFREQ_MIGRATION	(1U << 1)
>=20
>  #ifdef CONFIG_CPU_FREQ
> +struct cpufreq_policy;
> +
>  struct update_util_data {
>         void (*func)(struct update_util_data *data, u64 time, unsigned in=
t
> flags);  }; @@ -20,6 +22,7 @@ void cpufreq_add_update_util_hook(int cp
>                         void (*func)(struct update_util_data *data, u64
> time,
>  				    unsigned int flags));
>  void cpufreq_remove_update_util_hook(int cpu);
> +bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
>=20
>  static inline unsigned long map_util_freq(unsigned long util,
>  					unsigned long freq, unsigned long cap)
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -82,12 +82,10 @@ static bool sugov_should_update_freq(str
>  	 * by the hardware, as calculating the frequency is pointless if
>  	 * we cannot in fact act on it.
>  	 *
> -	 * For the slow switching platforms, the kthread is always scheduled on
> -	 * the right set of CPUs and any CPU can find the next frequency and
> -	 * schedule the kthread.
> +	 * This is needed on the slow switching platforms too to prevent CPUs
> +	 * going offline from leaving stale IRQ work items behind.
>  	 */
> -	if (sg_policy->policy->fast_switch_enabled &&
> -	    !cpufreq_this_cpu_can_update(sg_policy->policy))
> +	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
>  		return false;
>=20
>  	if (unlikely(sg_policy->limits_changed)) {
>=20
>=20

