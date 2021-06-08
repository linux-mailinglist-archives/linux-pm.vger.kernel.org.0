Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4564439EC56
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 04:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFHCw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 22:52:28 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:36114 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230233AbhFHCw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 22:52:28 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1582neCe003636;
        Mon, 7 Jun 2021 19:50:29 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0064b401.pphosted.com with ESMTP id 391qkqgag6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 19:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAJMZqGqzXL1V1PQAjFBT0ah8Ubu6v0B1v2qZv4SJMjcP17t5lSJjWQ7CBig3TZM4wXmiCGbiM2A5tGewap0fq2VExTbFGP5jgb9ILxxyI8ct/MU6KzF8QRH5pMpd4y+wVnRR4GlpniRrjaeZv3jVREGgZeNFdBc8nk8FqKWfVMQY7ugtpdlIZHMtp5APJzwEQ1eyuDgY9lkVvHlvkJ3cX8u2XWt7/b9qvEWSqz7t2BQxfGAG4wJx5sP0ZGT8umF8UIU5NFCcUJRtkwM3zsK38pThb5Ux37SXs0AVXkLm5JbE0ytxxdHruxUnEGsbCJx7nBS2w7MDeT9GApJiYg9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPWgOFOeBOA7V32k67cir/QCK8a6CI3n/sReuhMNUVE=;
 b=AppV40/97cbq35jQK2lnhhFdZDS0QKGUuzBbCQOddKGX1k7Sb4bQjfwF3GKqh+H4fQyEuWZ9ykuzllka4iw3WF/qlbBJwUd8EWuG06wtV0ExmVhHXFk//KcQ5GalpzowCaaAA6ZuqM52g9Y9fit/uX2RdUywk6dZXoL8oY8xghRU8PBab4MsTVe78jC1u0jqdCWsZP8rSj5kbbdduVbXOm5z6L4DWsdpeMK9aIVGSR2HfZ4/FLO+4Zwgy8Eqdq9gnubtePJHjdPwnVv/tDw2wYZNaSXffEDLui0YxwS050wZpELsFPkjU2Z0hXDF/jen9CczsdLJg5LvYoKj4/gVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPWgOFOeBOA7V32k67cir/QCK8a6CI3n/sReuhMNUVE=;
 b=JyCsiqTstQ4vraMBqLNivfT2Qo5NQhkBokPZMuDpLUmkWSuRsdZ9GjFv6R+RxsRTUAUbYxAcnta45cGlXRwn+2oooXP/MljcIle3KcHAiijqHKOkEtdlcZVjPuOTOYE9JrOhNyBqh45rNVUz08CNVrraw7gyb0i2SVWedDYvbvI=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1243.namprd11.prod.outlook.com (2603:10b6:3:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27; Tue, 8 Jun 2021 02:50:26 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 02:50:26 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Thread-Topic: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Thread-Index: AQHXW2piNMZm7X449EajuzK9DUU2o6sIbnaAgAAiY3eAAB+HAIAAtA61
Date:   Tue, 8 Jun 2021 02:50:26 +0000
Message-ID: <DM6PR11MB42025552629034A22B8E5BC6FF379@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210607065743.1596-1-qiang.zhang@windriver.com>
 <CAJZ5v0iYtNP54mUFs5VbmHxuXYjTBMrbCZ5CqfaHShnGdd+3Jg@mail.gmail.com>
 <DM6PR11MB42027F9DA1B3E9B6BDFA5194FF389@DM6PR11MB4202.namprd11.prod.outlook.com>,<20210607154138.GU4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210607154138.GU4397@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06fce5cf-b028-4340-af97-08d92a282b8b
x-ms-traffictypediagnostic: DM5PR11MB1243:
x-microsoft-antispam-prvs: <DM5PR11MB1243A381D1EBF530ED5EBCDEFF379@DM5PR11MB1243.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bSYiEDNUBspsIXgAkASsFhDyLV2Q5Pc3nfSkg7dusl8QR4ZHIn+yV90foo3PGLaEQpfiPsn+mGLaZ6IOCL/Gb0MnNZpNIPbPGSUMALsNMY9hiqZTKzAjKgWpCY2KRm30rbPCt9LaR4HzHx0beQxZDoBavsy8GnxQVTAHM+MqeHEhPYGgSwmIbNj72OKjABcVsZw4rDTurhRToocvXJ4wNreWmOxwHxQnZUzlepDnDN9bQXponYzwkI8fDMona3/lF2XbrQsMaPzotGUSAjePNIR5aBOldOh+0osRr2tpXg5YPNWEQmjFAeEJdMgEi/tl9kvkIyiyLKHuu9B3BfEnhlnEl7gfcbz3vZvleg/sHX5Jb7u04CoXj7yzBkqwhw4dROgnbTbUHbeCHYmZepLxCY84nBFG6SOt7RuPKrW9O/YFqTe5AFdDgIoVleJY/BqRvAVr23MY1FZgoypM4BBFSTzhHQXIzWNaM7dvnxORwKxQQ1dXPT++LEHLa3S2fHrznIIa2cVD0IW1NksNyPPduD87i51FfIvKt7uRVu0v/cj3tT3M07ce+I7/qV3MGwLwefNNlbwdTw217Ay20ASKsxR8Yi/AJtl9qMAQxBwjBvYOePL3Pn5q5sYrIDz9w9FfysV67PgXNIrOTnf2bPdzdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39840400004)(346002)(396003)(2906002)(7696005)(5660300002)(55016002)(66946007)(76116006)(66446008)(66556008)(478600001)(54906003)(64756008)(9686003)(26005)(52536014)(122000001)(66476007)(83380400001)(6506007)(53546011)(8676002)(186003)(86362001)(71200400001)(4326008)(8936002)(6916009)(38100700002)(33656002)(316002)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I5mRTQLJ0Xq5U5Pk0zEhTlMOAAYlAYW2Bofji7dyKglr8zbo6sXZ8U1chyL6?=
 =?us-ascii?Q?iI9njX3yETSdVGRhx1MIvhoX5eCNbSAQHR8Qy0OyhDbIc3s+D1lUCI2d3Y4F?=
 =?us-ascii?Q?OVbLEdULQJoXPI5pWrpWFvvD0ykPWzmHWrGOfI8FvgMEhzky7X0HTY40PzXK?=
 =?us-ascii?Q?0kVaVL4i7SFpGJ8uwAlUT24FIB1puipNqjqj5FMYHmrfuhyHubYWQK92WTUZ?=
 =?us-ascii?Q?oPGUvHCLFFa3FCpWzkUurXMF9v6kgLCoWg08dgM3LY49Db2xrMVMp9lDtPZm?=
 =?us-ascii?Q?Dlq8AR/3D3nGe98qkRz1dhraiXQbzmsFfRRnE3kBVdSCClGeOoM+JV6Brm3l?=
 =?us-ascii?Q?LKSlawhCWTUuy85aDBZO6WgBGcC0C4VHLPaXiFGBD359ZWuok6SqHKb3mp0O?=
 =?us-ascii?Q?7fpn8byjtuCgCl/cXZRcjGGuZJsWcrKoMvmHZ0IDePROBDmxeNavdkwzB5rb?=
 =?us-ascii?Q?tLwanMh86lDqu8irdgdES+cQGGjKz8go+tZS3OfHc38LlNWVcE2nGrrrCaOp?=
 =?us-ascii?Q?S38PsUkK+nWpDsD8IvJk3IzgN9TugdkeRR1gXyrsrLrp3Numl9J7+lzpb+4m?=
 =?us-ascii?Q?KileQWP4yvisxzSMtZGNkJwqxCavOWuMi/QDFHQeCqQCfICAKs9C94VF/T5R?=
 =?us-ascii?Q?wnmrljuynXe55edl3eJw6raW0z07+eg4/sV8IEJCkvSgeOxMxgLgf1Z1tcjV?=
 =?us-ascii?Q?UAWuVT/nARtpt2tUfOrm/16Sba1kvtQ+Pf6HAjnvFfeezg2GTcVUqSZnH3sB?=
 =?us-ascii?Q?ZAwFUyP5UBu2+91nrZQ7DlvxImONvQGZp5CJ8B/HblEfZSfovzUQtG0lcPW0?=
 =?us-ascii?Q?IQ4PaFn6N7C2A7WkWDtR9o2n+3Th8rso7dfVv8Rs1LZfY0jGgzN9tLh4QQO7?=
 =?us-ascii?Q?wYh6k1Oo8a4hmSbY1YY2AoEUp1x95tLgjwHlz5suhNKFOw4NKTu5HX04Jo+3?=
 =?us-ascii?Q?1pPjz1hchNATw8Kwf3SxrNltHBOL/HOAyYiSf0MBxmQ2KasaugKpZ6JdcX4k?=
 =?us-ascii?Q?CArtiKvDL+U6LU6Z/SbLKsBGy3ni5m1av3dfez3ZwGsKzodeIk+imEtHkGO/?=
 =?us-ascii?Q?pUqluPv/7EXXSfAPkFAX7MK3C83bSGhBclbRyagJiAWVSB5Cod4pJlELzfmj?=
 =?us-ascii?Q?JMTAk0lLeoXdZqhT0klEc1rUQWcerlNmSyIK3jh/XRQG8QVOZm2U7MymXHN/?=
 =?us-ascii?Q?vVT5K3rXgiuilvi0TJ0i7yvm/GfESMSI10wq+xmcjMgsAq4vD7mYg9ibSyIX?=
 =?us-ascii?Q?m0HMPW/zFuoIKk6pmtvJhwC2gOVZ63+n2FG+rdFV+iL9bwPMuL6UvZaz4hzM?=
 =?us-ascii?Q?rPk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fce5cf-b028-4340-af97-08d92a282b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 02:50:26.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9DScbjwZaNxg2MJBZgD8cNvGYc1YaFPdhpiRuorNk6wlKXbB9u03+elWXiGPOWWCYbmbRrBHf+FlaWEhhEZ1l/1pw41/6k/hLe8Vjs5iEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1243
X-Proofpoint-GUID: TdWh6clPy20A4mapYAdpK-ONMUroAxRz
X-Proofpoint-ORIG-GUID: TdWh6clPy20A4mapYAdpK-ONMUroAxRz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080016
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Paul E. McKenney <paulmck@kernel.org>=0A=
Sent: Monday, 7 June 2021 23:41=0A=
To: Zhang, Qiang=0A=
Cc: Rafael J. Wysocki; Rafael Wysocki; Len Brown; Pavel Machek; Linux PM; L=
inux Kernel Mailing List=0A=
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) wit=
h rcu_read_lock/unlock()=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Mon, Jun 07, 2021 at 02:11:37PM +0000, Zhang, Qiang wrote:=0A=
> ________________________________________=0A=
> From: Rafael J. Wysocki <rafael@kernel.org>=0A=
> Sent: Monday, 7 June 2021 19:45=0A=
> To: Zhang, Qiang=0A=
> Cc: Rafael Wysocki; Len Brown; Pavel Machek; Paul E. McKenney; Linux PM; =
Linux Kernel Mailing List=0A=
> Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) w=
ith rcu_read_lock/unlock()=0A=
>=0A=
> [Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
>=0A=
> On Mon, Jun 7, 2021 at 8:57 AM <qiang.zhang@windriver.com> wrote:=0A=
> >=0A=
> > From: Zqiang <qiang.zhang@windriver.com>=0A=
> >=0A=
> > Using rcu_read_lock/unlock() instead of read_lock/unlock(tasklist_lock)=
,=0A=
> > the task list can be traversed in parallel to any list additions or=0A=
> > removals, improve concurrency.=0A=
> >=0A=
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
>=0A=
> >This changes the reader side only AFAICS, but what about the >writer sid=
e?=0A=
>=0A=
> Hello  rafael=0A=
>=0A=
> In the case of holding read_lock(tasklist_lock)=0A=
> if there are a lot of tasks in the system that need to be frozen,=0A=
> the read_lock(tasklist_lock)  has not been released for a short time,=0A=
> when clone task,  we will acquire write_lock(tasklist_lock) and insert ta=
sk to list, if  Ifcan't get the write lock all the time.  the hung task=0A=
> may be trigger and report warning.=0A=
>=0A=
> for example:=0A=
>=0A=
> copy_process()=0A=
> {........=0A=
> write_lock_irq(&tasklist_lock);=0A=
> ........=0A=
> list_add_tail_rcu(&p->tasks, &init_task.tasks);=0A=
> }=0A=
>=0A=
> >=0A=
> >What exactly is there to ensure that the updates of the list will=0A=
> >remain safe after this change?=0A=
>=0A=
> The RCU  can guarantee that the list can be traversed and added at the sa=
me time,  and in the read critical area, it is guaranteed that the task str=
ucture will not be released.=0A=
>=0A=
> In  ./Documentation/RCU/listRCU.rst , it is also explained.=0A=
>=0A=
>  Maybe we can ask  Paul E,  Paul E what's your opinion ?=0A=
=0A=
>Although RCU does guarantee that the task structures are not freed while=
=0A=
>an RCU reader references them, that is only one of the questions that=0A=
>must be answered.=0A=
>=0A=
>Changing from read_lock(&tasklist_lock) to rcu_read_lock() also allows=0A=
>all of the code currently under write_lock(&tasklist_lock) to execute=0A=
>concurrently with these newly created RCU readers.  Is that safe?=0A=
>If it is safe, why?=0A=
>=0A=
>For example, the first pair of hunks in the diff -might- be safe because=
=0A=
>"todo" is updated while read-holding tasklist_lock, and then that value=0A=
>is used after releasing that lock.  But I do not know this code well,=0A=
>and it is quite possible that something else is going on.=0A=
=0A=
Thanks Pual E=0A=
=0A=
you mean is the rcu ensures that the task_struct is not released  but it do=
es not guarantee that some members of the task_struct object are valid.=0A=
There may be the following scenarios:=0A=
In rcu read critical area,  when accessing some members of task_struct obje=
ct , it may have been released, when the task exiting.=0A=
=0A=
Is my understanding correct? =0A=
=0A=
Qiang=0A=
=0A=
>=0A=
>                                                Thanx, Paul=0A=
=0A=
> Thanks=0A=
> Qiang=0A=
>=0A=
> > ---=0A=
> >  kernel/power/process.c | 16 ++++++++--------=0A=
> >  1 file changed, 8 insertions(+), 8 deletions(-)=0A=
> >=0A=
> > diff --git a/kernel/power/process.c b/kernel/power/process.c=0A=
> > index 50cc63534486..0f8dee9ee097 100644=0A=
> > --- a/kernel/power/process.c=0A=
> > +++ b/kernel/power/process.c=0A=
> > @@ -48,7 +48,7 @@ static int try_to_freeze_tasks(bool user_only)=0A=
> >=0A=
> >         while (true) {=0A=
> >                 todo =3D 0;=0A=
> > -               read_lock(&tasklist_lock);=0A=
> > +               rcu_read_lock();=0A=
> >                 for_each_process_thread(g, p) {=0A=
> >                         if (p =3D=3D current || !freeze_task(p))=0A=
> >                                 continue;=0A=
> > @@ -56,7 +56,7 @@ static int try_to_freeze_tasks(bool user_only)=0A=
> >                         if (!freezer_should_skip(p))=0A=
> >                                 todo++;=0A=
> >                 }=0A=
> > -               read_unlock(&tasklist_lock);=0A=
> > +               rcu_read_unlock();=0A=
> >=0A=
> >                 if (!user_only) {=0A=
> >                         wq_busy =3D freeze_workqueues_busy();=0A=
> > @@ -97,13 +97,13 @@ static int try_to_freeze_tasks(bool user_only)=0A=
> >                         show_workqueue_state();=0A=
> >=0A=
> >                 if (!wakeup || pm_debug_messages_on) {=0A=
> > -                       read_lock(&tasklist_lock);=0A=
> > +                       rcu_read_lock();=0A=
> >                         for_each_process_thread(g, p) {=0A=
> >                                 if (p !=3D current && !freezer_should_s=
kip(p)=0A=
> >                                     && freezing(p) && !frozen(p))=0A=
> >                                         sched_show_task(p);=0A=
> >                         }=0A=
> > -                       read_unlock(&tasklist_lock);=0A=
> > +                       rcu_read_unlock();=0A=
> >                 }=0A=
> >         } else {=0A=
> >                 pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1=
000,=0A=
> > @@ -206,13 +206,13 @@ void thaw_processes(void)=0A=
> >=0A=
> >         cpuset_wait_for_hotplug();=0A=
> >=0A=
> > -       read_lock(&tasklist_lock);=0A=
> > +       rcu_read_lock();=0A=
> >         for_each_process_thread(g, p) {=0A=
> >                 /* No other threads should have PF_SUSPEND_TASK set */=
=0A=
> >                 WARN_ON((p !=3D curr) && (p->flags & PF_SUSPEND_TASK));=
=0A=
> >                 __thaw_task(p);=0A=
> >         }=0A=
> > -       read_unlock(&tasklist_lock);=0A=
> > +       rcu_read_unlock();=0A=
> >=0A=
> >         WARN_ON(!(curr->flags & PF_SUSPEND_TASK));=0A=
> >         curr->flags &=3D ~PF_SUSPEND_TASK;=0A=
> > @@ -233,12 +233,12 @@ void thaw_kernel_threads(void)=0A=
> >=0A=
> >         thaw_workqueues();=0A=
> >=0A=
> > -       read_lock(&tasklist_lock);=0A=
> > +       rcu_read_lock();=0A=
> >         for_each_process_thread(g, p) {=0A=
> >                 if (p->flags & PF_KTHREAD)=0A=
> >                         __thaw_task(p);=0A=
> >         }=0A=
> > -       read_unlock(&tasklist_lock);=0A=
> > +       rcu_read_unlock();=0A=
> >=0A=
> >         schedule();=0A=
> >         pr_cont("done.\n");=0A=
> > --=0A=
> > 2.17.1=0A=
> >=0A=
