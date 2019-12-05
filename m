Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E5113F9E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfLEKpi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:45:38 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:22351
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729018AbfLEKph (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 05:45:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV2UEgtDonKdPZ9qcK9HDo6/S7dgMHXiNmWzlYNVsRY+8qYygKOri5huEiQRbb0jVl+8WDiEQ1KINGMTAhHXPtgiUwla8iLwf48awn0jRO36wOcZXdWAMtAOlqco3EYILZBteJ7jDJLEBxZj9YjgIIfx+jfZZHle6fJGP9OcbI1qvEtdldqRux587kI8myKk77nyGAxL+g8Jws638lFWzkZVDFLoYS+qD5AGUZ2FJfqd9MUqBiniFDvjJd7wApPdaC5UuyyVFZpnhno+z5FM6L4s38PLGtUxO2hLYODiIJB15gagZ8E1pYUxoQqXcbL0Lc17nCkLwxzuC69teUKFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uQEZLJvLjeaUfXUCpfoZzFOzk8Tq7nlBZN6oWqYezk=;
 b=XagqdnfFOCb5y8j5ja4weKG1kC+IzzmCBqzbJwtyMmE6Blj04M84edyUBCc7UigtPgpj4hsMdfvOBgn08x9ta86GA1vvQChCAT16mTVbXDxZYesuQjkUOV2AZXBu/+3a05r45A+ni/8bFtCCMX7EMVBwl6Hrp1O5AHXMP+zlXv6dG/EjUPWqvct43G0xYerMXWd+1/fLJgnq19/VT/kmhtLuh1g/Xvy3q4DD8jEsps7cQKrTujscXvPseAfXETgq9dzQVSw05oKRCfTYD6MigMpPMjMDbyQz48zHI+vCGE9pPDG2cAF/p6pE95ijUF5pxG9M+UOCIaz9MutId7XKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uQEZLJvLjeaUfXUCpfoZzFOzk8Tq7nlBZN6oWqYezk=;
 b=XqZ9DzCrIzpkMdY2zAtINWRGmR3voWFshtfag3L+p7RigcuEKrOgwoEZurDxRweqzfUm6ss1guDKeycckIxAzM8Pdzx/mGWcpDJPRTUSRVO2jjLrUYLV6Sl05ee43tDSF06hyMGhTv23MpEQTAgvY7So+m7BqmFs6AywwOvh/iI=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4269.eurprd04.prod.outlook.com (52.133.15.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 10:44:50 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 10:44:50 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>
Subject: Re: [PATCH v2 0/2] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCH v2 0/2] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVq1ODGqHmiL8jsEu7/mnmp5h39g==
Date:   Thu, 5 Dec 2019 10:44:50 +0000
Message-ID: <VI1PR04MB7023F70C008F07482DEFD9D5EE5C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1575540224.git.leonard.crestez@nxp.com>
 <CAJZ5v0jEuecAUS_BmxEWVdiMXEKh0ScxH1UW6udONxzqL+c3Vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b058152-2c0e-455b-7c4b-08d779702799
x-ms-traffictypediagnostic: VI1PR04MB4269:|VI1PR04MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB426913C2B4C84705DF4A6C5FEE5C0@VI1PR04MB4269.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(66476007)(186003)(102836004)(55016002)(305945005)(5660300002)(9686003)(33656002)(966005)(25786009)(53546011)(76176011)(6506007)(44832011)(71200400001)(26005)(2906002)(52536014)(478600001)(7696005)(45080400002)(71190400001)(4326008)(91956017)(64756008)(99286004)(76116006)(66946007)(110136005)(86362001)(74316002)(7416002)(14454004)(8936002)(66446008)(316002)(81166006)(14444005)(8676002)(81156014)(229853002)(54906003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4269;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aP63YP9xvsi3oxqow8ZA6PpzycuinKqf1nOfuIBgxmog7pRyoS00KbzsT2tivQmUPlzqxXzMFWo9DOkIicFzFCXIxPQpeQaBSGgNQWEnrp5mD8Dts2Yv6KRxDhJ2ebK5E/J5uHAHRV5Pf85DC7tXy8BAWPUWQZEYVShwf7mk4mBNUiFmlOvtBt9h9dAqTsf3ZNTWv1scQ33TqorrPsbzXi6DOZYjfVP6oqwfGP+x68tJhiJ5S5rWXLmrHx12M5FkGTxqB+UTeb7FMxt0wB4zMb5fvROsdPSxQ9jmNONxW59hY6nLRI/rqT95+CC4PFA1oy9qXelQe46QEp9AWlOwlxS8073BMOT+hcQCbNRRsoXaEkT3ucHP/tDzK8be2KyzqvV74sdTJSKwaZJ0zsGDjjkYeAzfq0Raz2BEdMSYum1+uPJRec9MBB8hTwmhdJy8H6O9yc2cDbNHyxlwj6ePid+hl0XhcSrVu/XPJqz3TY=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b058152-2c0e-455b-7c4b-08d779702799
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 10:44:50.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aeEFi28hpqpcBULXnMr/aJLdyrVjC3bIctdmcYdXkGyYdu8jpwEO951xL7fuexffQ+uyhiCicxvk7l9zHSAZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4269
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-12-05 12:13 PM, Rafael J. Wysocki wrote:=0A=
> On Thu, Dec 5, 2019 at 11:05 AM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>>=0A=
>> Add dev_pm_qos notifiers to devfreq core in order to support frequency=
=0A=
>> limits via dev_pm_qos_add_request.=0A=
>>=0A=
>> Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,=
=0A=
>> this is consistent with current dev_pm_qos usage for cpufreq and=0A=
>> allows frequencies above 2Ghz (pm_qos expresses limits as s32).=0A=
>>=0A=
>> Like with cpufreq the handling of min_freq/max_freq is moved to the=0A=
>> dev_pm_qos mechanism. Constraints from userspace are no longer clamped o=
n=0A=
>> store, instead all values can be written and we only check against OPPs =
in a=0A=
>> new devfreq_get_freq_range function. This is consistent with the design =
of=0A=
>> dev_pm_qos.=0A=
>>=0A=
>> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx =
and=0A=
>> need to take devfreq->lock, this means that calls into dev_pm_qos while =
holding=0A=
>> devfreq->lock are not allowed (lockdep warns about possible deadlocks).=
=0A=
>>=0A=
>> Fix this by only adding the qos request and notifiers after devfreq->loc=
k is=0A=
>> released inside devfreq_add_device. In theory this means sysfs writes=0A=
>> are possible before the min/max requests are initialized so we guard=0A=
>> against that explictly. The dev_pm_qos_update_request function would=0A=
>> otherwise print a big WARN splat.=0A=
>>=0A=
>> This series depends on recently accepted series restoring=0A=
>> DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:=0A=
>>=0A=
>>          https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fpatchwork.kernel.org%2Fcover%2F11262633%2F&amp;data=3D02%7C01%7Cleonar=
d.crestez%40nxp.com%7C265c079a936b4c2a9c6608d7796bbc16%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C0%7C637111375932506745&amp;sdata=3DuI0if7aNnedxEsMlNQ4=
sCDOElVBxCp%2B%2BVGaeZC0DaMk%3D&amp;reserved=3D0=0A=
>>=0A=
>> It would be great for this to get into 5.5-rc1=0A=
> =0A=
> Not at this point.  The earliest realistic target can be -rc2.=0A=
> =0A=
> Does this still depend on anything which has not been included into=0A=
> the Linus' tree to date?=0A=
=0A=
This series depends on DEV_PM_QOS_MIN/MAX_FREQUENCY and that's already =0A=
in. It also depends on a few other patches from devfreq-next:=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=
=3Ddevfreq-next&id=3D1d81785fd070088c952fd9f0d8cb4c47c192122b=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=
=3Ddevfreq-next&id=3Da2b3d24b75036c44a5509e9ec3a5c14672e98c73=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=
=3Ddevfreq-next&id=3D0f68bfe7d58dfb49972f93768f9fdd97ce205844=0A=
=0A=
It doesn't currently apply on torvalds/master=0A=
=0A=
There are some interconnect patches which depend on this for proper =0A=
functionality but we can figure something out with icc maintainer.=0A=
=0A=
* https://patchwork.kernel.org/cover/11244421/=0A=
* https://patchwork.kernel.org/patch/11153917/=0A=
=0A=
I personally always test with linux-next so RC schedules don't affect me =
=0A=
very much.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
