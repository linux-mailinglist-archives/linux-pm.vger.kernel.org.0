Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410D65EFA1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 01:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCXaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 19:30:21 -0400
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:35918
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfGCXaV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 19:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yus0hqsvB3SFyix89B/+/wzENC7tP6fQkHYE1CCPz/4=;
 b=CJAVocrQMw8MKpTSmrKjZUINt9sF3CNwXb9V/Y7ZVxdL4rhkWvc2zfPj9Zr/DDv9MwMJC9nc8UK+rvmBJeA2x4hBQkKUJ1XrSzjQ4uw2X23eE20p2jUuycGlSI0Rd+PODt2Fy2biEb1QUp+05QU6RK46bkMlaw4ALAh/P0ZyZd0=
Received: from DB7PR04MB5051.eurprd04.prod.outlook.com (20.176.234.223) by
 DB7PR04MB4474.eurprd04.prod.outlook.com (52.135.138.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Wed, 3 Jul 2019 23:30:16 +0000
Received: from DB7PR04MB5051.eurprd04.prod.outlook.com
 ([fe80::6c98:1416:8221:bdfc]) by DB7PR04MB5051.eurprd04.prod.outlook.com
 ([fe80::6c98:1416:8221:bdfc%4]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 23:30:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv2 0/8] Add imx8mm bus frequency switching
Thread-Topic: [RFCv2 0/8] Add imx8mm bus frequency switching
Thread-Index: AQHVLYSy6nskEZuxAkK/D6W15Np9Kw==
Date:   Wed, 3 Jul 2019 23:30:15 +0000
Message-ID: <DB7PR04MB505163FDCAD7BE9A0C71A65EEEFB0@DB7PR04MB5051.eurprd04.prod.outlook.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
 <CAGETcx_63KnP75qySbhX_P_=o4=ox9J8AsBqKsFHeQRjCpSeJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab7d3c21-fcd0-4dec-f3d7-08d7000e677a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4474;
x-ms-traffictypediagnostic: DB7PR04MB4474:
x-microsoft-antispam-prvs: <DB7PR04MB44747D726410411C799F1058EEFB0@DB7PR04MB4474.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(316002)(33656002)(54906003)(6246003)(71200400001)(71190400001)(66066001)(110136005)(305945005)(6436002)(55016002)(74316002)(2906002)(229853002)(446003)(7736002)(44832011)(476003)(9686003)(486006)(4326008)(53936002)(66476007)(99286004)(91956017)(76116006)(52536014)(6116002)(3846002)(66446008)(66556008)(14444005)(5024004)(66946007)(256004)(26005)(478600001)(64756008)(68736007)(186003)(76176011)(73956011)(53546011)(6506007)(25786009)(102836004)(7696005)(5660300002)(14454004)(7416002)(86362001)(8936002)(8676002)(81166006)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4474;H:DB7PR04MB5051.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YiEVzR6a2lUhBOTrgHR6PJn0o465+CX9X/KBA4qHirQVDW53vdX+jQp/SNRpHx+ETm8SQBJjh1xl0jrVoCFjIr1/1qWJie0Lm5+1GkC1Q3vY0M9YwYg5Aghj+7l4CaPGC+9qru6yogKlUqI+kr1FyH0PJzl6NDwHm8siN2aU9X2ahNFuNhkFQ6yXbbMeCRaNq7u7XqSDI7Bcjs0tE7dp0ytUwBnTWv5IutinGoFBDGTuejWZbS0wgUQg95dV5e0sNTOkMOSU5iaGXv5lGk8VvicQUy5j7xqGACwFvLMQeEdr8+GEYb75HFE4bRiieI9vL/lkSd2NrUtAfy6tu5XeBjNFRSlsQJ2aBTCxFapsxIHhDmOVbXB+hVsaLtInuzoBWrEGRfYp675WkbcArWERlmlCgK9FxpapT3rFONCkGzI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7d3c21-fcd0-4dec-f3d7-08d7000e677a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 23:30:15.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4474
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/4/2019 1:20 AM, Saravana Kannan wrote:=0A=
=0A=
>> The interconnect and devfreq parts do not communicate explicitly: they b=
oth=0A=
>> just call clk_set_min_rate and the clk core picks the minimum value that=
 can=0A=
>> satisfy both. They are thus completely independent.=0A=
> =0A=
> Two different parts not talking to each other and just setting min=0A=
> rate can cause problems for some concurrency use cases. ICC framework=0A=
> is explicitly designed to handle cases like this and aggregate the=0A=
> needs correctly. You might want to look into that more closely.=0A=
=0A=
The clk framework aggregates the min_rate requests from multiple =0A=
consumers under a big "prepare_lock" so I expect it will deal with =0A=
concurrent requests correctly. As for performance: frequency switching =0A=
shouldn't be a fast path.=0A=
=0A=
>> The clk_set_min_rate approach does not mesh very well with the OPP frame=
work.=0A=
>> Some of interconnect nodes on imx8m can run at different voltages: OPP c=
an=0A=
>> handle this well but not in response to a clk_set_min_rate from an unrel=
ated=0A=
>> subsystem. Maybe set voltage on a clk notifier?=0A=
> =0A=
> I think if you design it something like below, it might make your life=0A=
> a whole lot easier.=0A=
> Hopefully the formatting looks okay on your end. The arrow going up is=0A=
> just connecting devfreq to ICC.=0A=
> =0A=
>                          Proactive -> ICC -> clk/OPP API to set freq/volt=
=0A=
>                                        ^=0A=
>                                        |=0A=
> HW measure -> governor -> devfreq ----+=0A=
> =0A=
> That way, all voltage/frequency requirements are managed cleanly by=0A=
> clk/OPP frameworks. The ICC deals with aggregating all the=0A=
> requirements and devfreq lets you handle reactive scaling and policy.=0A=
=0A=
If icc and devfreq are to directly communicate it makes more sense to do =
=0A=
it backwards: ICC should set a min_freq on nodes which have a devfreq =0A=
instance attached and devfreq should implement actual freq switching.=0A=
=0A=
HW measurement is done on individual nodes while ICC deals with requests =
=0A=
along a path. In particular on imx we have a performance monitor =0A=
attached to the ddr controller and I doubt it can distinguish between =0A=
masters so how could this be mapped usefully to an interconnect request?=0A=
=0A=
As far as I understand with devfreq the ddrc node could use "ondemand" =0A=
while the other nodes would default to the "passive" governor and run at =
=0A=
predefined default ratios relative to DDRC.=0A=
=0A=
> If all of this makes sense, please take a look at [2] and provide your=0A=
> thoughts. I've dropped a few patches from [1] to avoid confusion (too=0A=
> much going on at once). I think BW OPP tables and having OPP tables=0A=
> for interconnect paths will be something you'll need (if not now,=0A=
> eventually) and something you can build on top of nicely.=0A=
=0A=
I found it very confusing that you're assigning BW OPP tables to =0A=
devices. My initial understanding was that BW OPP would map "bandwidth" =0A=
to "frequency" so BW OPPs should be assigned to links along the =0A=
interconnect graph. But maybe what you want is to have OPPs for the BW =0A=
values requested by devices?=0A=
=0A=
Looking at the sdm845 icc provider source and it seems that those =0A=
"peak/avg" values are actually parameters which go into a firmware =0A=
command!? It makes sense that you want interconnect to be "below" =0A=
devfreq since icc_provider.set maps very closely to what firmware exposes.=
=0A=
=0A=
 > Interconnects and interconnect paths quantify their performance =0A=
levels > in terms of bandwidth and not in terms of frequency.=0A=
=0A=
On i.MX we just have a bunch of interconnect IPs for which frequencies =0A=
can be adjusted (in hz) so the above statement doesn't really hold. It =0A=
is up to an icc provider to convert aggregate bandwidth values to =0A=
frequencies along the path.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
