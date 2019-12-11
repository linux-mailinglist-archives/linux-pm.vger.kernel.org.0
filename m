Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6611A662
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 09:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfLKI7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 03:59:55 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:29450
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfLKI7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 03:59:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2hcdJO8G9Ju9o78KJLoxfOJQcBUpMmplX+TzbRMixMpZAlCkcR9Cn6/FkkPLAXjMWtqmLb41ZfAi1xktCDkxXQX1gyRWTGQy3/u/u9+OkG5pUOv3CNJqd+WcUkQwtIuT7vijCA1XhQrzJc9pLCKiHWaNW44WJx7HoYgUtPOstu5E5QNoYEPwtDy0pw3PhtZ6ComdcTGTbzVOaQgMwJXJu2jkqIKlrjmstylggJv8HAh/2vTdUc5JvqFEpzn+ztXu8MafSL39DFVKF5czpcD2r0Av8NgdoL8aIZqoJzht/K8NutTdbIBTKy/CTa9rZO/wvOW706NuLOGU2EPrnYuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01GuNmmQQZnuFVzIR/0Btt9cZnTxzBKpEOspwvfJOjQ=;
 b=FI/fxT/YKc9ixpw2Zho3M8WvaxzHKdSA6T6qXhwY866XlOU+HkNECJ4CRE22Vv3hWk3MLrG1jKup6dhwlww09KHrqWOXaeYxpdh+rYdwIX6lWNb1Y6c6Ckm5EBLlROdPSUYY1kctXCKzyBS/0eXiKobDqSNFqiGqHiQvgAJ838AHGkjNPpGpzn7LjUXFQsFhK5PON43A/5sRU6OmqrW8m+vW3it9nv4El/mKxFotRS2ddQxa+djR0x8RLqXaTwAbMd4DRPHsZiA2sB4pOj5QvAD/8Eke/z/RUJ2AIY6IvcFy+Rrbz3bT6jn67auyqVSFH/l+byhSYbovhTfHZIBpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01GuNmmQQZnuFVzIR/0Btt9cZnTxzBKpEOspwvfJOjQ=;
 b=efJl5ByfjO5YNXo5q/IZaJPTGWNPvRveVi8ZXbBjoq/f95QHzZ1ITKhR9O191mFuy1RgZLKpgfFkA9WkU3fTUKqXSusPODu/Ou/o1ZfQitgEMugdXgzKNM0eg8bvRXN3uJoT68uP2e+keRThmBFVCIt9t+z33/rDDD2pDYx6Flc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6546.eurprd04.prod.outlook.com (20.179.253.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 08:59:45 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 08:59:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAACPMEXAAAqbAgAACrQEAAAAfUXAAAG2mAAAAIzIAAABNT4AAAAalAAADxrOAAACJ1gAALbeWIA==
Date:   Wed, 11 Dec 2019 08:59:45 +0000
Message-ID: <AM0PR04MB4481EDA9EB0374E698A6754C885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <5310126.hg2rr5Fjtk@kreacher> <7233060.oySJ2cjCuV@kreacher>
In-Reply-To: <7233060.oySJ2cjCuV@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae0b08f9-7d0d-4c85-7ce1-08d77e187816
x-ms-traffictypediagnostic: AM0PR04MB6546:|AM0PR04MB6546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB65464DD8DC77F14B46DB96F6885A0@AM0PR04MB6546.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(52314003)(189003)(13464003)(71200400001)(81166006)(8676002)(66946007)(81156014)(478600001)(5660300002)(45080400002)(44832011)(9686003)(8936002)(55016002)(30864003)(110136005)(966005)(33656002)(2906002)(186003)(66476007)(6636002)(6506007)(26005)(52536014)(66556008)(54906003)(316002)(86362001)(4326008)(7696005)(53546011)(76116006)(64756008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6546;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQ5hOD5rNSOXFJukCRDsgNUggnTQSiBe/tNUUPvdAUYlzdKx63f/Di2cpHBAVc+0FUadnsLvloN2JPSIVamh3R4WRhuiAUQBv16pdLX4RsRPTHPiWv8IxtXelvL4/dtyN558yigfS2Bh723gR5doBTUzLqjxoEHp8GebVzfkUl3V62WTSjFs4iC//r2wQoy1ZPKQ/bP/4+nMSLuzHDbocyJ9j40HO/nwu2pZYjEPKFbmTnB9FfnL2y3ypzFXlbpCxbLD4RZXfqm5lin7Yzy7CFOglOBg5svesXLBH4zL77Se94wP7GsOBUnnkMLhMIVM2aOnr8Q3A17AMQg7WMzhpdAaTe/Nhxq4DX3dsBAPqtrgVxcSz3nUcL6tioEqd2qINcxU6NieslXbN85pY28JnvAd1GruK+Z0TCqfTGQEau0/drVtghUkJycNJ+zHv+VWsyYpowFDrdFaJDX990tVm3SbrjFJH9WoKkjndFWh6X/glteDFeUVa9l3qYWOzc/hlp+I7hs1UCgaujfTUzzCRA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0b08f9-7d0d-4c85-7ce1-08d77e187816
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 08:59:45.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb+y8i1Q3cpA0D91X17Ved+ybRFmHc9nAGwqkKlKVC1FCWUN0vy7EbrgMrlK29AeHv2SCsqS0imK5xY0+xOAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6546
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
>=20
> On Tuesday, December 10, 2019 11:39:25 AM CET Rafael J. Wysocki wrote:
> > On Tuesday, December 10, 2019 9:51:43 AM CET Anson Huang wrote:
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Sent: Tuesday, December 10, 2019 4:51 PM
> > > > To: Anson Huang <anson.huang@nxp.com>
> > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Viresh Kumar
> > > > <viresh.kumar@linaro.org>; Peng Fan <peng.fan@nxp.com>; Jacky Bai
> > > > <ping.bai@nxp.com>; linux-pm@vger.kernel.org; Vincent Guittot
> > > > <vincent.guittot@linaro.org>; Peter Zijlstra
> > > > <peterz@infradead.org>; Paul McKenney
> <paulmck@linux.vnet.ibm.com>
> > > > Subject: Re: About CPU hot-plug stress test failed in cpufreq
> > > > driver
> > > >
> > > > On Tuesday, December 10, 2019 9:45:09 AM CET Anson Huang wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > Sent: Tuesday, December 10, 2019 4:38 PM
> > > > > > To: Anson Huang <anson.huang@nxp.com>
> > > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Viresh Kumar
> > > > > > <viresh.kumar@linaro.org>; Peng Fan <peng.fan@nxp.com>; Rafael
> J.
> > > > > > Wysocki <rjw@rjwysocki.net>; Jacky Bai <ping.bai@nxp.com>;
> > > > > > linux- pm@vger.kernel.org; Vincent Guittot
> > > > > > <vincent.guittot@linaro.org>; Peter Zijlstra
> > > > > > <peterz@infradead.org>; Paul McKenney
> > > > > > <paulmck@linux.vnet.ibm.com>
> > > > > > Subject: Re: About CPU hot-plug stress test failed in cpufreq
> > > > > > driver
> > > > > >
> > > > > > On Tue, Dec 10, 2019 at 9:29 AM Anson Huang
> > > > > > <anson.huang@nxp.com>
> > > > > > wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > > > Sent: Tuesday, December 10, 2019 4:22 PM
> > > > > > > > To: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > > > Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> > > > > > > > <rafael@kernel.org>; Anson Huang <anson.huang@nxp.com>;
> > > > > > > > Rafael
> > > > J.
> > > > > > > > Wysocki <rjw@rjwysocki.net>; Jacky Bai <ping.bai@nxp.com>;
> > > > > > > > linux- pm@vger.kernel.org; Vincent Guittot
> > > > > > > > <vincent.guittot@linaro.org>; Peter Zijlstra
> > > > > > > > <peterz@infradead.org>; Paul McKenney
> > > > > > > > <paulmck@linux.vnet.ibm.com>
> > > > > > > > Subject: Re: About CPU hot-plug stress test failed in
> > > > > > > > cpufreq driver
> > > > > > > >
> > > > > > > > On Tue, Dec 10, 2019 at 8:05 AM Viresh Kumar
> > > > > > > > <viresh.kumar@linaro.org>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > +few more guys
> > > > > > > > >
> > > > > > > > > On 10-12-19, 05:53, Peng Fan wrote:
> > > > > > > > > > But per
> > > > > > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dh=
t
> > > > > > > > > > tps%3A
> > > > > > > > > > %2F%
> > > > > > > > > > 2Fel
> > > > > > > > > > ixir.bootlin.com%2Flinux%2Fv5.5-
> > > > > > > > rc1%2Fsource%2Fkernel%2Fsched%2Fsche
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> d.h%23L2293&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C6f4490
> 0
> > > > > > > > be3404
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> e7d355708d77d4a16fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %
> > > > > > > > 7C637
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> 115629475456329&amp;sdata=3DXXhwvuTOBb3TLmerwkr1zKbaWNA8xA%2Bl
> > > > > > > > W%2Faw31
> > > > > > > > > > 0AYcM%3D&amp;reserved=3D0
> > > > > > > > > > cpu_of(rq) and smp_processor_id() is possible to not
> > > > > > > > > > the same,
> > > > > > > > > >
> > > > > > > > > > When cpu_of(rq) is not equal to smp_processor_id(),
> > > > > > > > > > dbs_update_util_handler will use irq_work_queue to
> > > > > > > > > > smp_processor_id(), not cpu_of(rq). Is this expected?
> > > > > > > > > > Or should the irq_work be queued to cpu_of(rq)?
> > > > > > > > >
> > > > > > > > > Okay, sorry for the long weekend where I couldn't get
> > > > > > > > > time to reply at
> > > > > > all.
> > > > > > > >
> > > > > > > > No worries. :-)
> > > > > > > >
> > > > > > > > > First of all, lets try to understand dvfs_possible_from_a=
ny_cpu.
> > > > > > > > >
> > > > > > > > > Who can update the frequency of a CPU ? For many
> > > > > > > > > architectures/platforms the eventual code that writes to
> > > > > > > > > some register to change the frequency should only run on
> > > > > > > > > the local CPU, as these registers are per-cpu registers
> > > > > > > > > and not something shared
> > > > > > between CPUs.
> > > > > > > > >
> > > > > > > > > But for the ARM architecture, we have a PLL and then
> > > > > > > > > some more registers to play with the clk provided to the
> > > > > > > > > CPU blocks and these registers (which are updated as a
> > > > > > > > > result of
> > > > > > > > > clk_set_rate()) are part of a
> > > > > > > > block outside of the CPU blocks.
> > > > > > > > > And so any CPU (even if it is not part of the same
> > > > > > > > > cpufreq
> > > > > > > > > policy) can update it. Setting this flag allows that and
> > > > > > > > > eventually we may end up updating the frequency sooner,
> > > > > > > > > instead of later (which may be less effective). That was
> > > > > > > > > the idea of
> > > > the remote-wakeup series.
> > > > > > > > > This stuff is absolutely correct and so cpufreq-dt does
> > > > > > > > > it for
> > > > everyone.
> > > > > > > > >
> > > > > > > > > This also means that the normal work and irq-work both
> > > > > > > > > can run on any CPU for your platform and it should be oka=
y to
> do that.
> > > > > > > >
> > > > > > > > And it the failing case all of the CPUs in the system are
> > > > > > > > in the same policy anyway, so dvfs_possible_from_any_cpu is=
 a
> red herring.
> > > > > > > >
> > > > > > > > > Now, we have necessary measures in place to make sure
> > > > > > > > > that after stopping and before starting a governor, the
> > > > > > > > > scheduler hooks to save the cpufreq governor pointer and
> > > > > > > > > updates to
> > > > > > > > > policy->cpus are made properly, to make sure that we
> > > > > > > > > policy->never
> > > > > > > > > ever schedule a work or irq-work on a CPU which is offlin=
e.
> > > > > > > > > Now it looks like this isn't working as expected and we
> > > > > > > > > need to find
> > > > what exactly is broken here.
> > > > > > > > >
> > > > > > > > > And yes, I did the testing on Hikey 620, an octa-core
> > > > > > > > > ARM platform which has a single cpufreq policy which has
> > > > > > > > > all the 8 CPUs. And yes, I am using cpufreq-dt only and
> > > > > > > > > I wasn't able to reproduce the problem with mainline kern=
el as
> I explained earlier.
> > > > > > > > >
> > > > > > > > > The problem is somewhere between the scheduler's
> > > > > > > > > governor hook
> > > > > > > > running
> > > > > > > > > or queuing work on a CPU which is in the middle of
> > > > > > > > > getting offline/online and there is some race around
> > > > > > > > > that. The problem hence may not be related to just
> > > > > > > > > cpufreq, but a wider variety of
> > > > clients.
> > > > > > > >
> > > > > > > > The problem is that a CPU is running a governor hook which
> > > > > > > > it shouldn't be running at all.
> > > > > > > >
> > > > > > > > The observation that dvfs_possible_from_any_cpu makes a
> > > > > > > > difference only means that the governor hook is running on
> > > > > > > > a CPU that is not present in the
> > > > > > > > policy->cpus mask.  On the platform(s) in question this
> > > > > > > > policy->cannot happen as
> > > > > > > > long as RCU works as expected.
> > > > > > >
> > > > > > > If I understand correctly, the governor hook ONLY be clear
> > > > > > > on the CPU being offline and after governor stopped, but the
> > > > > > > CPU being offline could still run into below function to
> > > > > > > help other CPU update the util, and it ONLY checks the
> > > > > > > cpu_of(rq)'s governor hook which is valid as that
> > > > > > CPU is online.
> > > > > > >
> > > > > > > So the question is how to avoid the CPU being offline and
> > > > > > > already finish the governor stop flow be scheduled to help
> > > > > > > other CPU update the
> > > > > > util.
> > > > > > >
> > > > > > >  static inline void cpufreq_update_util(struct rq *rq,
> > > > > > > unsigned int
> > > > > > > flags)  {
> > > > > > >          struct update_util_data *data;
> > > > > > >
> > > > > > >          data =3D
> > > > > > rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
> > > > > > >
> cpu_of(rq)));
> > > > > > >          if (data)
> > > > > > >                  data->func(data, rq_clock(rq), flags);  }
> > > > > >
> > > > > > OK, so that's where the problem is, good catch!
> > > > > >
> > > > > > So what happens is that a CPU going offline runs some
> > > > > > scheduler code that invokes cpufreq_update_util().
> > > > > > Incidentally, it is not the cpu_of(rq), but that CPU is still
> > > > > > online, so the callback is invoked and then policy->cpus test
> > > > > > is bypassed because of
> > > > dvfs_possible_from_any_cpu.
> > > > >
> > > > > If this is the issue, add another check here for the current
> > > > > CPU's governor
> > > > hook?
> > > > > Or any other better place to make sure the CPU being offline NOT
> > > > > to be
> > > > queued to irq work?
> > > >
> > > > Generally, yes.
> > > >
> > > > Something like the patch below should help if I'm not mistaken:
> > > >
> > > > ---
> > > >  include/linux/cpufreq.h |    8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > Index: linux-pm/include/linux/cpufreq.h
> > > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D
> > > > =3D=3D=3D
> > > > --- linux-pm.orig/include/linux/cpufreq.h
> > > > +++ linux-pm/include/linux/cpufreq.h
> > > > @@ -599,11 +599,13 @@ static inline bool cpufreq_this_cpu_can_  {
> > > >  	/*
> > > >  	 * Allow remote callbacks if:
> > > > -	 * - dvfs_possible_from_any_cpu flag is set
> > > >  	 * - the local and remote CPUs share cpufreq policy
> > > > +	 * - dvfs_possible_from_any_cpu flag is set and the CPU running
> the
> > > > +	 *   code is not going offline.
> > > >  	 */
> > > > -	return policy->dvfs_possible_from_any_cpu ||
> > > > -		cpumask_test_cpu(smp_processor_id(), policy->cpus);
> > > > +	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> > > > +		(policy->dvfs_possible_from_any_cpu &&
> > > > +		 !cpumask_test_cpu(smp_processor_id(), policy-
> > > > >related_cpus));
> > > >  }
> > >
> > > I will start a stress test of this patch, thanks!
> >
> > OK, thanks!
> >
> > Another patch to test is appended and it should be more robust.
> >
> > Instead of doing the related_cpus cpumask check in the previous patch
> > (which only covered CPUs that belog to the target policy) it checks if
> > the update_util hook is set for the local CPU (if it is not, that CPU
> > is not expected to run the uodate_util code).
>=20
> One more thing.
>=20
> Both of the previous patches would not fix the schedutil governor in whic=
h
> cpufreq_this_cpu_can_update() only is called in the fast_switch case and =
that
> is not when irq_works are used.
>=20
> So please discard the patch I have just posted and here is an updated pat=
ch
> that covers schedutil too, so please test this one instead.
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
> + *   offline (in which it is not expected to run cpufreq updates any mor=
e).
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

So we will not queue irq_work on the offlining CPU in your patch.

When we met issue on CPU3, it is CPU3 has irq_work pending,
but the SGI IRQ_WORK interrupt is not handled because irq is
always disabled, see stack in idle irq disabled state.

[  227.344678] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.4.0-03554-gbb115=
9fa5556-dirty #95
[  227.344682] Hardware name: Freescale i.MX8QXP MEK (DT)
[  227.344686] Call trace:
[  227.344701]  dump_backtrace+0x0/0x140
[  227.344708]  show_stack+0x14/0x20
[  227.344717]  dump_stack+0xb4/0xf8
[  227.344730]  dbs_update_util_handler+0x150/0x180
[  227.344739]  update_load_avg+0x38c/0x3c8
[  227.344746]  enqueue_task_fair+0xcc/0x3a0
[  227.344756]  activate_task+0x5c/0xa0
[  227.344766]  ttwu_do_activate.isra.0+0x4c/0x70
[  227.344776]  try_to_wake_up+0x2d8/0x410
[  227.344786]  wake_up_process+0x14/0x20
[  227.344794]  swake_up_locked.part.0+0x18/0x38
[  227.344801]  swake_up_one+0x30/0x48
[  227.344808]  rcu_gp_kthread_wake+0x5c/0x80
[  227.344815]  rcu_report_qs_rsp+0x40/0x50
[  227.344825]  rcu_report_qs_rnp+0x120/0x148
[  227.344832]  rcu_report_dead+0x120/0x130
[  227.344841]  cpuhp_report_idle_dead+0x3c/0x80
[  227.344847]  do_idle+0x198/0x280
[  227.344856]  cpu_startup_entry+0x24/0x40
[  227.344865]  secondary_start_kernel+0x154/0x190
[  227.344905] CPU3: shutdown
[  227.444015] psci: CPU3 killed.


I also met CPU1 offlining have irq_work queued, but CPU1
not trigger issue, because SGI IRQ_WORK interrupt is handled.

There are multiple path to run into dbs_update_util_handler
irq_work_queue, the path might will enable interrupt, might not.

Seem do_idle is the only path that will trigger cpu_die for HOTPLUG
ARM/ARM64.

So do we need to use idle as flag to queue irq_work or not?
In this way, we could still inject irq work on offlining/offline cpu, until
it runs into idle to cpu_die.

Thanks,
Peng.

>=20
>=20

