Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3019339DE65
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGONi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:13:38 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:39052 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhFGONi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:13:38 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157EBdXb026769;
        Mon, 7 Jun 2021 14:11:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 391em1r7qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 14:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV116PhK3ykajM3jN9waupVufUx5SG9UrimtL1kTdZa4nmVu87pHocvTgvDW7tKnW8u7zWy3N3VkwYbyzlM9ueGvJ+p2m/MR3AuNfVYDg1WFI64VNhnoVuJ8ZkKefFLJdkidLw5/mja9GEgWGGkkZXUBUJWHFGL7pI3JjUOlgXiaceDfpIkSp/JGDJDsQcdcoEYPQpsyP3vzSM8dfIu+pZlAbbGeeUXOmvXiGdldip74zrSiqU+G6V2IhQR+du4rMgujBoE4LEqDpE+u/DzPg2tAOEL8i1SZ599GzNXbo3Wt8gyBrNcctzUf8gTts4epKRbSfDGkIEQeqmnPKToaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/3o4OcI6wMoZj3QKzUMuL3k96lw76Swr5rAd+7jBec=;
 b=iY8xvrrDDdcdlqBA7Z+w07JvYATrXfHT9ZdSwbD+t3MaNDlTFjwN/F5uDHLsi1/5m1HnfHnsyBhTjH+JhPHVdQ0caIzk6uCoL2lGf+I84F3uZkbp89EojdubjdlClo9BPPPE6n6ORow+Dpx/DJCk12FAcxdmcEabWTEnxDhsfk/R+N9E90rygu5VVC1nupeHGt/GZEoybUtHaji2eEPeXsuyzA9py4bkNEf8HLLSPlvSo3W/UX0pjCznPywZpRrXeVG1pCRCX9VWiLyoE37Cy07FThvno2LOBRe5f8Empz1sJlrsYoEKBGMSWvtvKtMvmVXyMczhaEnHmBuZC8VKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/3o4OcI6wMoZj3QKzUMuL3k96lw76Swr5rAd+7jBec=;
 b=EI1xnFFy5I714iiW7afwlwVierHVyRx4A6Ukminl8xz/WWhcSfHVdIkeIj++VH+b06ntlGwT5DsklRbY1GiLUuXKcUu1baSptXpqWiDDSpXB7nSpxA7lf9xb29PeQ5mT8jRS0IAm7OAJZF3o4C22R+QucdSGlN4u4+fZnBq6KVo=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1433.namprd11.prod.outlook.com (2603:10b6:4:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.25; Mon, 7 Jun 2021 14:11:37 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:11:37 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Thread-Topic: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Thread-Index: AQHXW2piNMZm7X449EajuzK9DUU2o6sIbnaAgAAiY3c=
Date:   Mon, 7 Jun 2021 14:11:37 +0000
Message-ID: <DM6PR11MB42027F9DA1B3E9B6BDFA5194FF389@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210607065743.1596-1-qiang.zhang@windriver.com>,<CAJZ5v0iYtNP54mUFs5VbmHxuXYjTBMrbCZ5CqfaHShnGdd+3Jg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iYtNP54mUFs5VbmHxuXYjTBMrbCZ5CqfaHShnGdd+3Jg@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [240e:305:7882:5579:1fd:e8d9:ca6e:a0c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d2922d1-9934-4a37-9e56-08d929be2a2a
x-ms-traffictypediagnostic: DM5PR11MB1433:
x-microsoft-antispam-prvs: <DM5PR11MB143343E322F69C4BC882C8A4FF389@DM5PR11MB1433.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2g/SSUTH3oZig4OLzSFBE9SR/O8OjihdLvKMcZMBHdLtprdTUeHtEYminNXQH0VlR4PRwzTf4tyNDLHD6VA9DwNRoSEzxUIarK8gASo3W7wPFN2oArnl9vWKMLWfFfRvpAHUAopXFh7IaHOlSpZ/gxqXbne6AyzHqavqLHqDsTD/D9panpWoC4GH96HqIsXAcW7Oi/Gl+z9X/Yc31MP+34Ebb0MK1A/8SlQy9CQWV4ARpuOy2DGpETNtmcai7KZY3ZXSuQMCl/+EazLG4IpT50HZR1KVczcbRFPiH1vEVfQg2CNRw5V14/JOmYsD1/Bnd6xAckZsrNfoj97gwx69piJzNMjTgQY0qES8MLV9qSlXoFMvaaWsdD1jb2n3G8verkcWQsZNKttJFOncwJtyWELiJsY4V4U8Rqq9rnMDuSBuHF9pyLa61fGL8xWoEDipbRwXawWC2zY+zzUcF9vw3Foq63qhMVLd18+TeiDp8DP5GZRbzMTPkDvwfoaLNp0KmMBVLmnGRBlPRUlnffariY+hFCseGbqCLyLDjD57eYnFc9Uag/MGgZ5dewQixy44Yk7J3pYT2u2yK5/e2mQ/7lkvtkvjfaIuIeENJ9Y5AUrzDDx0daZGpwwNLJxZxe3dzl9bpazq2Nz8Aodlyo6uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(366004)(478600001)(5660300002)(8676002)(8936002)(91956017)(54906003)(64756008)(66946007)(66556008)(66476007)(66446008)(52536014)(2906002)(316002)(9686003)(86362001)(55016002)(4326008)(83380400001)(6506007)(53546011)(122000001)(186003)(38100700002)(71200400001)(110136005)(33656002)(7696005)(76116006)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OGmzrtNfcCo2LTaCtwLbEgwyOC6qe7qzCfSfWCzaehCyD0xzRas0dz2iQIcU?=
 =?us-ascii?Q?qSA/al1T+l9xlxEOl2tPBo/isCHi4lwc6+yOc7j/ZdJx7o7S0HIME1C3d2Vy?=
 =?us-ascii?Q?gTphFJNnGk6YtSIGd/iHha/T+NSB/WrWqxmJGCT3B0PRG1WHMqPSFw/BvjJZ?=
 =?us-ascii?Q?5dUf2NBY2UriT6dLefZ0mmncK0qY3Q6VMINlg8+bNRl/lmHLnTadf2MgWjd3?=
 =?us-ascii?Q?AgHr18e4i2Xa4IoAp5pPc8o1vASE4kJbfKYlD0eB8wIF3GvU93I0XhV6O6Dc?=
 =?us-ascii?Q?rkytL+mGwpP9GZaovW0BnkWXg9ZSbycDeaGi/19nxqyU9PC4sfHKFbO8bmXk?=
 =?us-ascii?Q?0r5gv+1htVJWQaYQTPjEFaXgXcvhg+lN82o+JjX1v+5mV8ZtbxmWeOwmhfZV?=
 =?us-ascii?Q?u2trGmdew1FN5R5tXdqUIc29pWI2Gud1vQKjCwYj+0Iu2M9RdzvywQ/iM89j?=
 =?us-ascii?Q?35rZe7U9CMkr7r8ONS+jyyPjxzaOVpyCF/bquoBUr2nzPNoABIgXHKgJPA7f?=
 =?us-ascii?Q?R5bBc8lVPbwCmxUsgZE/wKEgJShEbo6FHPrCBTfj4DG2kAlSEWE20YvVnj0g?=
 =?us-ascii?Q?55L9vkcQ5slBeH8TnrDms3DS+4JydLv+7tGAgmsRC1fsk5Z9w9Kj1w+/k/UJ?=
 =?us-ascii?Q?dGlkhD7vzM2BpSSl31ShWHlwrv+DOJ1N58+im8cd271hZRQBP3XfdRlFU/Ww?=
 =?us-ascii?Q?K042cBM4DSlFrTARh8kbpEqtzj/VkFWMgN4X0acQGRdT96ZJo5M0gkQrgSxE?=
 =?us-ascii?Q?plq+jE1PY73ONJVSAV9889RfAJdU9HK1BtWVBJhV7XdpScEbwaMS/Xhlei+h?=
 =?us-ascii?Q?YVZ0J0N5o/GeH+Wl8Ik7seA0XLSuo/P4wZSrp8kT2g+DwzIr+BCGtXqCPjsD?=
 =?us-ascii?Q?/laXtNgV8vZ88/AtODsU+VEOOBlQMdgWZ2LA1ZQXZuj7x0q2tuK/PnY+VaJ+?=
 =?us-ascii?Q?yAHCvuFiePz2I9za4bogwNMySip5eMbEtqb220HA8ThecT84d8SDoDxOb4XN?=
 =?us-ascii?Q?olZRaPMIw501DlDrkwNMh3JGrIms1E0KJULfzzHUXVAv0mOQmZmqs18bj3l+?=
 =?us-ascii?Q?xqa2A75njT52M6Vi1YwiHlzNbZeoYNstsggInhEA9uFID3RMsWKpjMqApsNx?=
 =?us-ascii?Q?mV/XtOp0MLF5O21ajZNukd8/UZeiiPdoIY+NdTA3dBMe1UvT70LB3aa7+/8G?=
 =?us-ascii?Q?Il15NjKTo/+F3/VFRZDo0oIkKRp6csEy5AK2ldrAxWDT8EcEwdrYNuQKP8gm?=
 =?us-ascii?Q?RJNLvcJYA0vb+SQ2y5iVUlLTBk10D5AWRn5le5jgNuQw8zrd64GyK/2Clwgw?=
 =?us-ascii?Q?ppzqAJwivtLxk1ehf2AZrhM11FvjakRhOHoTF42K07DklMRbRuuluf4EOkAp?=
 =?us-ascii?Q?UIEXVic=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2922d1-9934-4a37-9e56-08d929be2a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 14:11:37.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7+Qdb80n3FpcSoiOYbWUJk1KDZ2zjf4xucwkBnB1jZTxmM4U0e0GbEnB/ojDOEmUITRbiWSLTxH75aI6GeWKh7zsUoWe6C5NRp6ieMwJuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1433
X-Proofpoint-ORIG-GUID: SiUI-DkTPCsSNm1wmGLtS1DE47pj_oMP
X-Proofpoint-GUID: SiUI-DkTPCsSNm1wmGLtS1DE47pj_oMP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_11:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070105
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Rafael J. Wysocki <rafael@kernel.org>=0A=
Sent: Monday, 7 June 2021 19:45=0A=
To: Zhang, Qiang=0A=
Cc: Rafael Wysocki; Len Brown; Pavel Machek; Paul E. McKenney; Linux PM; Li=
nux Kernel Mailing List=0A=
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) wit=
h rcu_read_lock/unlock()=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Mon, Jun 7, 2021 at 8:57 AM <qiang.zhang@windriver.com> wrote:=0A=
>=0A=
> From: Zqiang <qiang.zhang@windriver.com>=0A=
>=0A=
> Using rcu_read_lock/unlock() instead of read_lock/unlock(tasklist_lock),=
=0A=
> the task list can be traversed in parallel to any list additions or=0A=
> removals, improve concurrency.=0A=
>=0A=
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
=0A=
>This changes the reader side only AFAICS, but what about the >writer side?=
=0A=
=0A=
Hello  rafael=0A=
=0A=
In the case of holding read_lock(tasklist_lock) =0A=
if there are a lot of tasks in the system that need to be frozen,=0A=
the read_lock(tasklist_lock)  has not been released for a short time,=0A=
when clone task,  we will acquire write_lock(tasklist_lock) and insert task=
 to list, if  Ifcan't get the write lock all the time.  the hung task=0A=
may be trigger and report warning.=0A=
=0A=
for example:=0A=
=0A=
copy_process()=0A=
{........=0A=
write_lock_irq(&tasklist_lock);=0A=
........=0A=
list_add_tail_rcu(&p->tasks, &init_task.tasks);=0A=
}=0A=
=0A=
>=0A=
>What exactly is there to ensure that the updates of the list will=0A=
>remain safe after this change?=0A=
=0A=
The RCU  can guarantee that the list can be traversed and added at the same=
 time,  and in the read critical area, it is guaranteed that the task struc=
ture will not be released.=0A=
=0A=
In  ./Documentation/RCU/listRCU.rst , it is also explained.=0A=
=0A=
 Maybe we can ask  Paul E,  Paul E what's your opinion ?=0A=
=0A=
Thanks=0A=
Qiang=0A=
=0A=
> ---=0A=
>  kernel/power/process.c | 16 ++++++++--------=0A=
>  1 file changed, 8 insertions(+), 8 deletions(-)=0A=
>=0A=
> diff --git a/kernel/power/process.c b/kernel/power/process.c=0A=
> index 50cc63534486..0f8dee9ee097 100644=0A=
> --- a/kernel/power/process.c=0A=
> +++ b/kernel/power/process.c=0A=
> @@ -48,7 +48,7 @@ static int try_to_freeze_tasks(bool user_only)=0A=
>=0A=
>         while (true) {=0A=
>                 todo =3D 0;=0A=
> -               read_lock(&tasklist_lock);=0A=
> +               rcu_read_lock();=0A=
>                 for_each_process_thread(g, p) {=0A=
>                         if (p =3D=3D current || !freeze_task(p))=0A=
>                                 continue;=0A=
> @@ -56,7 +56,7 @@ static int try_to_freeze_tasks(bool user_only)=0A=
>                         if (!freezer_should_skip(p))=0A=
>                                 todo++;=0A=
>                 }=0A=
> -               read_unlock(&tasklist_lock);=0A=
> +               rcu_read_unlock();=0A=
>=0A=
>                 if (!user_only) {=0A=
>                         wq_busy =3D freeze_workqueues_busy();=0A=
> @@ -97,13 +97,13 @@ static int try_to_freeze_tasks(bool user_only)=0A=
>                         show_workqueue_state();=0A=
>=0A=
>                 if (!wakeup || pm_debug_messages_on) {=0A=
> -                       read_lock(&tasklist_lock);=0A=
> +                       rcu_read_lock();=0A=
>                         for_each_process_thread(g, p) {=0A=
>                                 if (p !=3D current && !freezer_should_ski=
p(p)=0A=
>                                     && freezing(p) && !frozen(p))=0A=
>                                         sched_show_task(p);=0A=
>                         }=0A=
> -                       read_unlock(&tasklist_lock);=0A=
> +                       rcu_read_unlock();=0A=
>                 }=0A=
>         } else {=0A=
>                 pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 100=
0,=0A=
> @@ -206,13 +206,13 @@ void thaw_processes(void)=0A=
>=0A=
>         cpuset_wait_for_hotplug();=0A=
>=0A=
> -       read_lock(&tasklist_lock);=0A=
> +       rcu_read_lock();=0A=
>         for_each_process_thread(g, p) {=0A=
>                 /* No other threads should have PF_SUSPEND_TASK set */=0A=
>                 WARN_ON((p !=3D curr) && (p->flags & PF_SUSPEND_TASK));=
=0A=
>                 __thaw_task(p);=0A=
>         }=0A=
> -       read_unlock(&tasklist_lock);=0A=
> +       rcu_read_unlock();=0A=
>=0A=
>         WARN_ON(!(curr->flags & PF_SUSPEND_TASK));=0A=
>         curr->flags &=3D ~PF_SUSPEND_TASK;=0A=
> @@ -233,12 +233,12 @@ void thaw_kernel_threads(void)=0A=
>=0A=
>         thaw_workqueues();=0A=
>=0A=
> -       read_lock(&tasklist_lock);=0A=
> +       rcu_read_lock();=0A=
>         for_each_process_thread(g, p) {=0A=
>                 if (p->flags & PF_KTHREAD)=0A=
>                         __thaw_task(p);=0A=
>         }=0A=
> -       read_unlock(&tasklist_lock);=0A=
> +       rcu_read_unlock();=0A=
>=0A=
>         schedule();=0A=
>         pr_cont("done.\n");=0A=
> --=0A=
> 2.17.1=0A=
>=0A=
