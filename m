Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE473A0D23
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 09:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhFIHHF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 03:07:05 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:10092 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234564AbhFIHHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 03:07:05 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15974d5i004817;
        Wed, 9 Jun 2021 07:05:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 3929drgqtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 07:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjdgQAr3VgFrR36iapeYpy3LRmcEwsxQ3XENJzH7cOp6m6QacjkEedA7GNW0n90svmascZj/dQio8Wk1ZePYkkyfKJG2MNQlsh7Dh4iQ9+2L52qxZrrmaD3ueTyATTNrMJ3kQJ5yHWnr1hr7ohzOJkZRdkfY3wsu//6nGSt25vcNHl64fWgU6GLkgmZqlSav3ud5h3sTsr3IX3M/FuDliNR0W91L38dhDaSa8LBjiu10Plq4sCvdQd/j81N9XeBFi/Z+WcYna2Fw9Ecz7KjqWDUaXlB+c2OojXeEulR3P+4ycHJKiGLD8F4cWD/Z0bjzaCxzmGnghrfB171EQu+xFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTQnJie2TKksZTvENDh+vKe/1Rzm3ivEuSdahQ8wn80=;
 b=BwOoTl1k2vzOnyGtyeoIdbyAdn202tWKN8Yj5tugP7bc13VY8eeAPAFiIIpa+a7jd+xHABt9NF+PdW/1sNvM8d/JJD0qR9NZvAhVJQgDKc3rd1G/kX+Ldf18Dlsj+0EFyH6NeHGkahd05PAEKdPfaJqjgOtMJmQCmpu5qvvo3K9Els8bEj6mV2wjBl1kALZYr1hXIwq1CQKGLEQ4d9XmbJQ+SnAUtUP4l6MRWh/OlkeYXQkeFsQvLtzNBSegMmGK0hIFyUz2GR6+rVgjHKWzchyPUcJYGxPcIklEcUxX0pII/vYKjg36n1wjke/P6o2p9UGeDd2DrJn4fpFQZIxrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTQnJie2TKksZTvENDh+vKe/1Rzm3ivEuSdahQ8wn80=;
 b=Z2TMytNY/diaKiwP12pS1SquCjGkSi0JlqesyDs1Y+JwGDJCc4ZBj9HxToXFlrCg57MWuuT1U5IcjHitRolRKbjtxb2N1d2/kwEQ8FUgPzB8TvsJFlXEGh7vsMK5ENaVqFs8cGL6KLMjN+9UuE1SueR60lvHv+3Rh/bRMePGhxw=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB2809.namprd11.prod.outlook.com (2603:10b6:5:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Wed, 9 Jun
 2021 07:05:00 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:04:55 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Thread-Topic: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Thread-Index: AQHXW2piNMZm7X449EajuzK9DUU2o6sIbnaAgAAiY3eAAB+HAIAAtA61gAAqAACAAETmFw==
Date:   Wed, 9 Jun 2021 07:04:54 +0000
Message-ID: <DM6PR11MB42027C12072631D259569FCAFF379@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210607065743.1596-1-qiang.zhang@windriver.com>
 <CAJZ5v0iYtNP54mUFs5VbmHxuXYjTBMrbCZ5CqfaHShnGdd+3Jg@mail.gmail.com>
 <DM6PR11MB42027F9DA1B3E9B6BDFA5194FF389@DM6PR11MB4202.namprd11.prod.outlook.com>
 <20210607154138.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <DM6PR11MB42025552629034A22B8E5BC6FF379@DM6PR11MB4202.namprd11.prod.outlook.com>,<20210608045624.GY4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210608045624.GY4397@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af570e62-c496-42d9-908d-08d92b14e299
x-ms-traffictypediagnostic: DM6PR11MB2809:
x-microsoft-antispam-prvs: <DM6PR11MB28095F694941C309C4BA6766FF369@DM6PR11MB2809.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CSYjhNIZwwlFhJm7ntrfbag/4gVgD+fO+QO6Xwq0fVIDjbPdAJbpGlU+b/+zLa2YAjN2ziZeC/b00v7AE90FnPb4aeL1BoNaST5Faa3/ArBDBTQ7tqF2vk8qq98oikumf58DDDFLrwefQRi4BNhBaibvQnYaAToQYc9hH6eeku2C9YidumvojTwnPpozZu9SCDAFmj1lNOgXOKVkbTKZ3lUr4GckbvVIMXsK/O0YnPF297yliPCA9xYL6LVxPIgZBIO0AJsEwVzJXoDTZR1Ouc2RJxrP9ZuSvpV9xNlWbIccW+7nTSWPy0g0bqJ4OiI35f9HyLTDWby28/C9tPWlCmrgcJZqtgWka4l4sZ0UVJyHdsUzqFzFXxIcj4eXo5K2sJbYjGBPWLZ3fKJy7KCOvq4EhNsSZNOcWiE7A1Nz21fdmxTcCjf7qcGKmUuYrg85UkGp6rxA+6pwrSTpF+382D0DKxZugIeabvQcQAE+RDqlTuASaf1QXr0MKeyXJNm+OoeW1gcXvnUZ0dMbxizF8KROFOXvGZbAEHbwzPaG9Enp05g9xLoIPDyGD4dEtO9/O4er+fNnQNfTebmS9Zuxk5Vp/n9raciIK/5daJizRSojma+cW792KSyFpJVDZ/EiMCTEdAyW0+GGjscUgkNrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(366004)(136003)(396003)(346002)(478600001)(66446008)(55016002)(2906002)(6506007)(66556008)(8936002)(33656002)(4326008)(64756008)(5660300002)(66476007)(53546011)(52536014)(8676002)(76116006)(9686003)(86362001)(83380400001)(186003)(66946007)(7696005)(38100700002)(26005)(122000001)(316002)(71200400001)(6916009)(54906003)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dsnlDzkrYdI8/u6jAsIcrC8XkcZdnpNrgXsJ4CuYMpIfZTzA1z6/6uQOwGo?=
 =?us-ascii?Q?Vj5BBpP6ymZDVrBWkaDYWet6422W/ZV1OpCwrKyxJTS8y3Niht2QRL0/qKMe?=
 =?us-ascii?Q?TS5jzr5fGnOv6zcZzTbTjzlPeG8VunsMpfQSes4+l+UQ1HQDK+Ve07i7lepL?=
 =?us-ascii?Q?6zaDgu+XtXUZaDwMuCWZe8Xcv7QQvslFLkSI/gcbhXVI6Klba+1wHcVITipE?=
 =?us-ascii?Q?Kn/MfOx9Ho++c2/fe2YdCWhtWQ6Hs53p41Qew+y5oAg6Viw42AECbXO1kmds?=
 =?us-ascii?Q?N3uCLMcoGNvAiHhWB+tG5/7QXBHfsa/RcquEehKT3ZuNuPmr5wiFXEcI6B+n?=
 =?us-ascii?Q?xnxjc3A1VzpKtGJQ4Gv606x0FMdW2DwrQwHRBoHzY1iutqimw5H85m+FR85U?=
 =?us-ascii?Q?wLSoiAPe/T0bRebbSHqTxamnv4KvSAyuLwmEMWvOGodqit8e5TirICtRzYqf?=
 =?us-ascii?Q?ZZ1jH0UIaqBO2mJTwYGSdi6+5Nrw9NMOhAnfy6bhnWNzCwlkRO92d++EjqTs?=
 =?us-ascii?Q?welcEEGTJ4nCQnPMHnEkisfCq+WC7w6hCVZvv26y6sbwLITlh4hyxg1tDEYc?=
 =?us-ascii?Q?XdPhAXUQAsB2pc+CpQu5k1bvl+tVtuEh7C+z+8WejrltvCVza0Tb69PpTaSD?=
 =?us-ascii?Q?RPJgfsECZaLJusuAVy3mY/QZiO8Xm+L+N8JK3slQPkVk0+pdAOimZhtgF5u9?=
 =?us-ascii?Q?j82EaYl/TiMNYnRWYxj7Gl/YgpTFAMngtXYuS0GhAMvb/MOMn3K/cUNHewHs?=
 =?us-ascii?Q?ZcKXTDDnDpwiQ4M8loxgaJ6l+8qmyoF9cwgM2MWF7QeT3xR2R/wzN4YkwsFm?=
 =?us-ascii?Q?65cYSfajRe52aVOExSbslE0FPlUM0weReJdkJQb17b/h4Z8o0lIZge+ShMND?=
 =?us-ascii?Q?W3X/4M6tCcHGRGaFZLffwcfl5B782oy8dJzfPBobNgHPlzVibojnSdLyaM2G?=
 =?us-ascii?Q?MAq/gk1mk0PsApxNL0AC87UfTPMwI7PL3sp1VbxwBID0o4eS7QfadvRgDYGb?=
 =?us-ascii?Q?lleOuCBEl3Ot8tSAaqOju3hJdo0vYLcAHaipR6NDE5lmrT3YxqREsEXJ/YeO?=
 =?us-ascii?Q?D2Vd3SY8Tihsicblzv8T/6VNjzfcppxdaO9EjoXT9rypS0wTVU42ZYLyY16r?=
 =?us-ascii?Q?jqmrxYqTFLwyQ7FzdvovtVAcX4paDgtvKoPoNglSn9NEXDv6++g7uGhJGKHk?=
 =?us-ascii?Q?3mOpAgc4zw+kEviQEDqttiIsqaxWi/yhu1CJ8bxBWCe8B5EieQR6ZHPWqav0?=
 =?us-ascii?Q?C+JGj8X5vyRfmvgna4/ZhF3sdvqbviSKKWCXQvs1RcxzEug6aN1sDvrav5PO?=
 =?us-ascii?Q?TqA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af570e62-c496-42d9-908d-08d92b14e299
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 07:04:54.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqZiuBF90vfZ1xveQsfjfnJBoWn3L7GIKgB0WX3rba7MsIHZIj6JcQvhWPsktFY22OjcYmEgoo4hIPa8BiDhpgk1gnXrcGZAfpe9iqutU5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2809
X-Proofpoint-ORIG-GUID: F80LoD2wO5juJhhxCWZzP3oTtvZfDfbz
X-Proofpoint-GUID: F80LoD2wO5juJhhxCWZzP3oTtvZfDfbz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090027
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Paul E. McKenney <paulmck@kernel.org>=0A=
Sent: Tuesday, 8 June 2021 12:56=0A=
To: Zhang, Qiang=0A=
Cc: Rafael J. Wysocki; Rafael Wysocki; Len Brown; Pavel Machek; Linux PM; L=
inux Kernel Mailing List=0A=
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) wit=
h rcu_read_lock/unlock()=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Tue, Jun 08, 2021 at 02:50:26AM +0000, Zhang, Qiang wrote:=0A=
>=0A=
>=0A=
> ________________________________________=0A=
> From: Paul E. McKenney <paulmck@kernel.org>=0A=
> Sent: Monday, 7 June 2021 23:41=0A=
> To: Zhang, Qiang=0A=
> Cc: Rafael J. Wysocki; Rafael Wysocki; Len Brown; Pavel Machek; Linux PM;=
 Linux Kernel Mailing List=0A=
> Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) w=
ith rcu_read_lock/unlock()=0A=
>=0A=
> [Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
>=0A=
> On Mon, Jun 07, 2021 at 02:11:37PM +0000, Zhang, Qiang wrote:=0A=
> > ________________________________________=0A=
> > From: Rafael J. Wysocki <rafael@kernel.org>=0A=
> > Sent: Monday, 7 June 2021 19:45=0A=
> > To: Zhang, Qiang=0A=
> > Cc: Rafael Wysocki; Len Brown; Pavel Machek; Paul E. McKenney; Linux PM=
; Linux Kernel Mailing List=0A=
> > Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock)=
 with rcu_read_lock/unlock()=0A=
> >=0A=
> > [Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
> >=0A=
> > On Mon, Jun 7, 2021 at 8:57 AM <qiang.zhang@windriver.com> wrote:=0A=
> > >=0A=
> > > From: Zqiang <qiang.zhang@windriver.com>=0A=
> > >=0A=
> > > Using rcu_read_lock/unlock() instead of read_lock/unlock(tasklist_loc=
k),=0A=
> > > the task list can be traversed in parallel to any list additions or=
=0A=
> > > removals, improve concurrency.=0A=
> > >=0A=
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
> >=0A=
> > >This changes the reader side only AFAICS, but what about the >writer s=
ide?=0A=
> >=0A=
> > Hello  rafael=0A=
> >=0A=
> > In the case of holding read_lock(tasklist_lock)=0A=
> > if there are a lot of tasks in the system that need to be frozen,=0A=
> > the read_lock(tasklist_lock)  has not been released for a short time,=
=0A=
> > when clone task,  we will acquire write_lock(tasklist_lock) and insert =
task to list, if  Ifcan't get the write lock all the time.  the hung task=
=0A=
> > may be trigger and report warning.=0A=
> >=0A=
> > for example:=0A=
> >=0A=
> > copy_process()=0A=
> > {........=0A=
> > write_lock_irq(&tasklist_lock);=0A=
> > ........=0A=
> > list_add_tail_rcu(&p->tasks, &init_task.tasks);=0A=
> > }=0A=
> >=0A=
> > >=0A=
> > >What exactly is there to ensure that the updates of the list will=0A=
> > >remain safe after this change?=0A=
> >=0A=
> > The RCU  can guarantee that the list can be traversed and added at the =
same time,  and in the read critical area, it is guaranteed that the task s=
tructure will not be released.=0A=
> >=0A=
> > In  ./Documentation/RCU/listRCU.rst , it is also explained.=0A=
> >=0A=
> >  Maybe we can ask  Paul E,  Paul E what's your opinion ?=0A=
>=0A=
> >Although RCU does guarantee that the task structures are not freed while=
=0A=
> >an RCU reader references them, that is only one of the questions that=0A=
> >must be answered.=0A=
> >=0A=
> >Changing from read_lock(&tasklist_lock) to rcu_read_lock() also allows=
=0A=
> >all of the code currently under write_lock(&tasklist_lock) to execute=0A=
> >concurrently with these newly created RCU readers.  Is that safe?=0A=
> >If it is safe, why?=0A=
> >=0A=
> >For example, the first pair of hunks in the diff -might- be safe because=
=0A=
> >"todo" is updated while read-holding tasklist_lock, and then that value=
=0A=
> >is used after releasing that lock.  But I do not know this code well,=0A=
> >and it is quite possible that something else is going on.=0A=
>=0A=
> Thanks Pual E=0A=
>=0A=
> you mean is the rcu ensures that the task_struct is not released  but it =
does not guarantee that some members of the task_struct object are valid.=
=0A=
> There may be the following scenarios:=0A=
> In rcu read critical area,  when accessing some members of task_struct ob=
ject , it may have been released, when the task exiting.=0A=
>=0A=
> Is my understanding correct?=0A=
=0A=
>Yes, that is a concern.  The freezer code would need to be checked=0A=
>carefully to see whether or not the transformation from read_lock()=0A=
>to rcu_read_lock() was safe.=0A=
=0A=
Sorry  for the noise I made, there is wrong with this patch=0A=
I read the code,  when accessing members of task_struct in the rcu read cri=
tical area cannot guarantee its effectiveness.=0A=
=0A=
Qiang=0A=
=0A=
>=0A=
>                                                        Thanx, Paul=0A=
=0A=
> Qiang=0A=
>=0A=
> >=0A=
> >                                                Thanx, Paul=0A=
>=0A=
> > Thanks=0A=
> > Qiang=0A=
> >=0A=
> > > ---=0A=
> > >  kernel/power/process.c | 16 ++++++++--------=0A=
> > >  1 file changed, 8 insertions(+), 8 deletions(-)=0A=
> > >=0A=
> > > diff --git a/kernel/power/process.c b/kernel/power/process.c=0A=
> > > index 50cc63534486..0f8dee9ee097 100644=0A=
> > > --- a/kernel/power/process.c=0A=
> > > +++ b/kernel/power/process.c=0A=
> > > @@ -48,7 +48,7 @@ static int try_to_freeze_tasks(bool user_only)=0A=
> > >=0A=
> > >         while (true) {=0A=
> > >                 todo =3D 0;=0A=
> > > -               read_lock(&tasklist_lock);=0A=
> > > +               rcu_read_lock();=0A=
> > >                 for_each_process_thread(g, p) {=0A=
> > >                         if (p =3D=3D current || !freeze_task(p))=0A=
> > >                                 continue;=0A=
> > > @@ -56,7 +56,7 @@ static int try_to_freeze_tasks(bool user_only)=0A=
> > >                         if (!freezer_should_skip(p))=0A=
> > >                                 todo++;=0A=
> > >                 }=0A=
> > > -               read_unlock(&tasklist_lock);=0A=
> > > +               rcu_read_unlock();=0A=
> > >=0A=
> > >                 if (!user_only) {=0A=
> > >                         wq_busy =3D freeze_workqueues_busy();=0A=
> > > @@ -97,13 +97,13 @@ static int try_to_freeze_tasks(bool user_only)=0A=
> > >                         show_workqueue_state();=0A=
> > >=0A=
> > >                 if (!wakeup || pm_debug_messages_on) {=0A=
> > > -                       read_lock(&tasklist_lock);=0A=
> > > +                       rcu_read_lock();=0A=
> > >                         for_each_process_thread(g, p) {=0A=
> > >                                 if (p !=3D current && !freezer_should=
_skip(p)=0A=
> > >                                     && freezing(p) && !frozen(p))=0A=
> > >                                         sched_show_task(p);=0A=
> > >                         }=0A=
> > > -                       read_unlock(&tasklist_lock);=0A=
> > > +                       rcu_read_unlock();=0A=
> > >                 }=0A=
> > >         } else {=0A=
> > >                 pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs /=
 1000,=0A=
> > > @@ -206,13 +206,13 @@ void thaw_processes(void)=0A=
> > >=0A=
> > >         cpuset_wait_for_hotplug();=0A=
> > >=0A=
> > > -       read_lock(&tasklist_lock);=0A=
> > > +       rcu_read_lock();=0A=
> > >         for_each_process_thread(g, p) {=0A=
> > >                 /* No other threads should have PF_SUSPEND_TASK set *=
/=0A=
> > >                 WARN_ON((p !=3D curr) && (p->flags & PF_SUSPEND_TASK)=
);=0A=
> > >                 __thaw_task(p);=0A=
> > >         }=0A=
> > > -       read_unlock(&tasklist_lock);=0A=
> > > +       rcu_read_unlock();=0A=
> > >=0A=
> > >         WARN_ON(!(curr->flags & PF_SUSPEND_TASK));=0A=
> > >         curr->flags &=3D ~PF_SUSPEND_TASK;=0A=
> > > @@ -233,12 +233,12 @@ void thaw_kernel_threads(void)=0A=
> > >=0A=
> > >         thaw_workqueues();=0A=
> > >=0A=
> > > -       read_lock(&tasklist_lock);=0A=
> > > +       rcu_read_lock();=0A=
> > >         for_each_process_thread(g, p) {=0A=
> > >                 if (p->flags & PF_KTHREAD)=0A=
> > >                         __thaw_task(p);=0A=
> > >         }=0A=
> > > -       read_unlock(&tasklist_lock);=0A=
> > > +       rcu_read_unlock();=0A=
> > >=0A=
> > >         schedule();=0A=
> > >         pr_cont("done.\n");=0A=
> > > --=0A=
> > > 2.17.1=0A=
> > >=0A=
