Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2311825B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLJIhp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:37:45 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:17501
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfLJIhp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Dec 2019 03:37:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5UEawYu7DNT+wKPPEmLLg423JaiLyTld1Wk763fNlTgHXnHZ7b6ghu3oI3oQX2UScvTigcOoriy/I1iZKHP2s01+667IlYCHOpyPAeAP08vdLUQ8m2ZxYXTy/nuSDxQXX9JXz/HcZGRw8Z5D5zOLw5/YYrLV8lLqAWrsaW4pyCQPGoC0IDvgMxTIyS27s1B/o+evkfiBUZZK/Q+Kaxmvuq0/1wPRC/+Wg+Zge5/xQ6yswCbbGU2yhoJEM3uE7cU4SdxzeHROPxqZDq7ZUrw38dJqCJUi6X9ukxLJPr6GI7wtfQa9KKrqJvJ6rPINvCNdkViQ+lWh/PKPWhnImhLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QfVd3uhw/o7+hiba9Y272K8MUHEYRn5a8Vdl8sF0m4=;
 b=DY7zKFX9u0r7Gg//C0Md1QLMVka+78r4js1M8ZQD549AkfsTcUfz4j2dF63L/nhQjBksenIufmwEFsfpIsocP2NGGGOe0iNcME/iRZli8XMMPZCXlhLdmzMuYNQ+c1hLaat2zOtB4TFm3DJcOvZFmpH82WNW/Yiwl5cQlBvpkDmVRs7fg2gR8+MufnRu7/4il2QXMc3hCFF1X3Y28maSdpuAFm3IQAqEZDD/UlEGAEOqgKpe8T0rV8KuXrkc9FQdsf5D3tc6wBEPonvHi0MH4/vnLnOZS0mho2XE5YXcF42WHNc3jafxXvl6iR7OFROf8OKT4ucjOtRAOMi5ZY0lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QfVd3uhw/o7+hiba9Y272K8MUHEYRn5a8Vdl8sF0m4=;
 b=r5yTGuS1VBHFWrS795zUsW0SaKUUYSWCxgCFQX1Cc72vROFl5Tcef4dK/eo5CCpfmtIY6WcA3Vq24sk8F51OA2EcZ5EX/t0JrimRU5IqxN3WL8TB1tSFeWPjru3ErGvEo6Vpql7NpfUh/LYAezx0meITC6qR2TcvQXYtOW2xeVY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6818.eurprd04.prod.outlook.com (52.132.214.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 08:37:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 08:37:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAACPMEXAAAqbAgAACrQEAAAAfUXAAAFw3gAAABwtQ
Date:   Tue, 10 Dec 2019 08:37:41 +0000
Message-ID: <AM0PR04MB4481685AAD330AEC475CD204885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
 <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
 <DB3PR0402MB39164E6ACFEAE98961EB70E4F55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191210083601.e4rrj6kyndku5u2z@vireshk-i7>
In-Reply-To: <20191210083601.e4rrj6kyndku5u2z@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49158ab6-3aeb-4a91-8d9a-08d77d4c3882
x-ms-traffictypediagnostic: AM0PR04MB6818:|AM0PR04MB6818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB681897222E6D2B92F3FA501F885B0@AM0PR04MB6818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(55016002)(71190400001)(2906002)(9686003)(66556008)(64756008)(229853002)(54906003)(305945005)(86362001)(71200400001)(52536014)(76116006)(66946007)(66476007)(6636002)(5660300002)(110136005)(478600001)(8936002)(316002)(6506007)(33656002)(53546011)(66446008)(186003)(44832011)(4326008)(26005)(8676002)(7696005)(4744005)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6818;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNV5mZxfBSdBahImapg3QMZ6s28CFdHOuLNhEFV5vR1L0WEhrrY1XRig8B7EbXEowIgWqqCmxQyOL9XuDK2NsKmf6sYuMag4QDeEvu/IzVtyqq7IU8SEiF9ZrM0D66pO6AC2UrwchX9ND1RvXc6nbtJ4KwJqTnnJ8q1kKgiebhy4WKcnmHmaXXlWcQmuF2y3kB6h7hAZNGmdrOl7Iug8foA/dnCNrtrnKjl/Cd5Fmd7D1hGPvnNg9BQP+tp1xdem9QQ4WN1rV03/8BWVhFDOhZbKDdzVHaeVro4+c5d65WYbnxgvO9o4W7lyDkDqebKUVZKSAFVlKmTHtT0M/W+uRkBVkAEKG6eS7tXsgfqs0GF7/2Jcp7lYHB5b3cHBrUAAjRNd1lz1Briij4kx4uxrUXC1H9JGCZ8/n3jURZ+V+cWcLqQ1tZN2zVJIJLYHHp7q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49158ab6-3aeb-4a91-8d9a-08d77d4c3882
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 08:37:41.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DBlXHU22Y+sX3tTGpLkV0Y6vP16myQUcKxugV7cJcyudbipO/95QvhSPV3llBFoKlx4olS64AF8ZKkBZrhGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
>=20
> On 10-12-19, 08:29, Anson Huang wrote:
> > If I understand correctly, the governor hook ONLY be clear on the CPU
> > being offline and after governor stopped, but the CPU being offline
> > could still run into below function to help other CPU update the util,
> > and it ONLY checks the cpu_of(rq)'s governor hook which is valid as tha=
t
> CPU is online.
>=20
> An offline CPU should never be running this helper as its hook is cleared
> followed by rcu-sync.

sync rcu might be buggy return early when do rcu_reference_sched?

Thanks,
Peng.

>=20
> --
> viresh
