Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B31CFFD
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfENTeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 15:34:17 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:23269
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbfENTeR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 15:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjlb1F565UolY8iB+CdaT0Fa4CFl8wrCMHACaEWawDs=;
 b=bGKa/Zt6Sz7T74NDy+M+hswY82qqEPoAjVZvPpqiwrxr+vZ8typ90hPdF6lMB3jODIZP3V/FAZdvyFO5tQfj1bsXnPzUhfOwnYgduNBszDUQdUWm89jBqr8G/JLE99e051Cd7qToyTBYDdcMjEbGs1qMdQP2mSNxhPniuDmDJCU=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4034.eurprd04.prod.outlook.com (52.134.124.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Tue, 14 May 2019 19:34:10 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.010; Tue, 14 May 2019
 19:34:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Emilio Lopez <emilio@elopez.com.ar>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Thread-Topic: [RFC PATCH 0/3] Add support of busfreq
Thread-Index: AQHU2dO+g7FtRU5+MUaLzLMJn01eLA==
Date:   Tue, 14 May 2019 19:34:10 +0000
Message-ID: <AM0PR04MB643434FB6A26B4D70F52F350EE080@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
 <8af96425-a6f5-0114-7abb-c2a67b952e1b@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b581bec-232e-4e02-5246-08d6d8a3234f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4034;
x-ms-traffictypediagnostic: AM0PR04MB4034:
x-microsoft-antispam-prvs: <AM0PR04MB40348DFC8A9DAE6AA1C15C4CEE080@AM0PR04MB4034.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(446003)(316002)(110136005)(54906003)(74316002)(33656002)(71200400001)(71190400001)(4326008)(66946007)(25786009)(55016002)(68736007)(7696005)(476003)(86362001)(99286004)(486006)(9686003)(6506007)(53546011)(44832011)(76176011)(7416002)(6636002)(305945005)(26005)(229853002)(186003)(6436002)(66066001)(478600001)(14454004)(256004)(8936002)(52536014)(6246003)(53936002)(102836004)(5660300002)(8676002)(81156014)(73956011)(91956017)(66476007)(64756008)(81166006)(66556008)(66446008)(14444005)(76116006)(7736002)(6116002)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4034;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wPqGYTShWwbwZBwFTLFsyajA5OR4p+TDB+/sPgqTbWldVAU55kzWd/FsnmjqDj29B7mcV3piCEBXmb4L3BGkWV8yhjE+SnyHgmR1RJkBeXailv1EcAWX7VB4vFHMdYjtBknpFyGCOwWrrhQoaAXvczwoRggYroF0QaeSqgPfvM5MRI9jzU0GtUEM+8Qtr/IwHVNEXYfOld9zJgKXSv2memqlOI+Kco3fQqS6pBya23bN7DQ/dYK4bx/5N+V5bwyp3KyqHnOazRkH52AIfZz6fg/UsgLUC/wGjl0ILFpkQFifgHaHaAjCKK8ZY8Hlelf8J/G8cmazdLLkmyCDnXhmFXzk7VCC0DQwZxT5yW7AGbYOKCiexvjMFXKfarVNZS4f/XVdXQrg2wfzvhZ4isXkKrs7dJmgO7V3JVcUohS278s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b581bec-232e-4e02-5246-08d6d8a3234f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 19:34:10.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4034
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15.03.2019 18:55, Alexandre Bailon wrote:=0A=
>> On Wed, Mar 13, 2019 at 12:33 PM Alexandre Bailon <abailon@baylibre.com>=
 wrote:=0A=
=0A=
>>> As exemple, this series implements busfreq for i.MX8MM whose=0A=
>>> upstreaming is in progress. Because this relies on ATF to=0A=
>>> do the frequency scaling, it won't be hard make it work.=0A=
>>=0A=
>> It's not clear to me whether this series actual scales the dram=0A=
>> frequency based on what you said above. Is it just theoretical or do=0A=
>> you have it working with a pile of out-of-tree patches? Would be good=0A=
>> to include that pile of patches in your integration branch that I=0A=
>> suggested above.=0A=
=0A=
> The current series only introduce busfreq generic driver, and the=0A=
> busfreq driver for the imx8mm.=0A=
> As is, the imx8mm driver will just be loaded, but do nothing because=0A=
> none of the drivers have been updated to request bandwidth using the=0A=
> interconnect framework.=0A=
> =0A=
> My intent was to sent a first draft o busfreq, to get some feedback,=0A=
> before to send a more complete, and fully functional series.=0A=
=0A=
It's been a while since this was first posted and imx8mm now boots fine =0A=
in linux-next. Is there a more up-to-date WIP branch somewhere? =0A=
Otherwise I can try to hack this series into a bootable form.=0A=
=0A=
 > In addition, the current clock driver of imx8mm doesn't allow dram=0A=
 > frequency scaling, so if busfreq driver tries, it will fail (should be=
=0A=
 > harmless because any other clocks should restored to their previous=0A=
 > rate).=0A=
=0A=
I'm confused about this. In NXP tree the actual DRAM switch is done =0A=
inside ATF via SIP calls and involves corralling all CPUs. Do you want =0A=
an "dram" clk which wraps the SIP calls required to changing dram =0A=
frequency and root switching etc?=0A=
=0A=
I've been looking at the busfreq implementation in the NXP tree and =0A=
refactoring just the "dram freq switch" behind a clk might work nicely.=0A=
=0A=
This would be similar to the imx_cpu clk used for cpufreq-dt and it =0A=
might even be possible to upstream this separately from the rest of =0A=
busfreq logic dealing with device requests.=0A=
=0A=
=0A=
I haven't done a very careful review but I noticed you're not using the =0A=
OPP framework and instead redefined everything? It's not clear why.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
