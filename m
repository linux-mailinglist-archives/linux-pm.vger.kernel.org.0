Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1FD77F5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfJOOFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 10:05:25 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:27997
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732261AbfJOOFY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 10:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHYpO7qi9pBk9mCFkDJ/blAw5akkeosQnd3hMeZ85wYvIPktMwaRAzJT1HQTnW/UP1yJISkf3RCZ4vd+P/A9JvPKfPV+Py1O17xttMFL2xRT5ZGKAjIYs+ppF0gVFww90rJSwwM+zu5EeDm9P24BkplnVNXUyBHiP8V3Xk6FWiEaOpxvOSxWUgPK4TvqXUYxl6KEjY8LSFj/K8lHpCa9tG745R007yWhqe+1zs24o3fmZVh0op8Cc0tsXomhQx0dHpPWO4xXcYqHmYHxFHq8Eyeavb5171BDGAZZ7kd6oqURFGPVuv0CFHu4dHnx6O5E7n1Qzrkn2ABDvGJlV+Q0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNAyDx7tTWEvGVsJ9RMoZAwr9Gu9P2QfdGzY76byj+8=;
 b=kaScIWZNNfeGlmwfXorvswSd72VZ8Jjf69tqzMtu3UC2JBGUpsgM3l8mPc1n77PR6ZrXjeIePTB/dLLz3TPTZx4r/Rmba88e3cDHHx46Sw2wOpE762CQ5gOK03XbzAcx8ms12lJI6vnMOiOUzU50XGPTkZz+nwCV4zrfUvIqxoBv1hhuJUT2SzK3k95+qfk6TXmIgJ780umGA3cwn8MNV8cA2mmc4aYhble/eI9yJ1jAN+6gKVKs5A+XwLYCH9Gvca2iNERMJx63PjwECOv1y9EeATssQuD37BZNnZoV+SlVuJNTWKqasKLkEUH9dUe+Kgrnv/y1uD3GQNatWX3mFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNAyDx7tTWEvGVsJ9RMoZAwr9Gu9P2QfdGzY76byj+8=;
 b=UbXCapYBjzjt2zuWgDkHCHsisUGOvV4tR754MToj2gFM0MBeH6UelPq4UK4mPg1/JTWJRt0i1jlGnQ1dRejw4uXo4SwoXOPU4VUDSaUwoi61wXz2KTMG40XMJ07mG/jINe3Dh9SG6QwQ6byNiguCI9dMv8m45LRaqF2zMaYcKEQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5104.eurprd04.prod.outlook.com (20.177.50.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 14:05:19 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 14:05:19 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Angus Ainslie <angus@akkea.ca>, Jacky Bai <ping.bai@nxp.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Martin Kepplinger <martink@posteo.de>
Subject: Re: [RFCv3 3/3] interconnect: imx: Add platform driver for imx8mm
Thread-Topic: [RFCv3 3/3] interconnect: imx: Add platform driver for imx8mm
Thread-Index: AQHVTEWKNFF2Yqu6YU66bS83yX49og==
Date:   Tue, 15 Oct 2019 14:05:19 +0000
Message-ID: <VI1PR04MB70231CD1535CBCB699F045D4EE930@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
 <cf265add1502a75c4d6e6261ab1570c665e82c83.1565088423.git.leonard.crestez@nxp.com>
 <a2e09a9b-574f-8410-423e-0b0d8ea5c2ab@posteo.de>
 <VI1PR04MB7023E441FEE0D9288CAC0F44EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <be41481b-5184-7878-b25e-41b7a1e1b2d5@posteo.de>
 <7c1452f3d8c13aeadcabf7807049092c@akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8f470be-8a9e-457b-c8a2-08d75178b69d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5104:|VI1PR04MB5104:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB51049CAEEEF43457D07D6C77EE930@VI1PR04MB5104.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(51914003)(305945005)(14444005)(316002)(256004)(71200400001)(71190400001)(6636002)(81166006)(86362001)(91956017)(81156014)(7696005)(76116006)(74316002)(54906003)(6506007)(186003)(76176011)(110136005)(7416002)(99286004)(66446008)(14454004)(64756008)(66946007)(66476007)(8676002)(8936002)(7736002)(53546011)(66556008)(66066001)(6436002)(44832011)(3846002)(2906002)(486006)(6306002)(102836004)(5660300002)(4326008)(966005)(478600001)(229853002)(26005)(6246003)(25786009)(55016002)(476003)(52536014)(33656002)(446003)(9686003)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5104;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNKlRh0rxhbVMavRutyFgtg/5KNHJIifWsZe9pHBMUENuGTeFLc6/Ay7qwOc6qiiRIWs6ODA3aAqNkxPGf1LM3k0GZyIi+hIRxYIxom/uiTuJckJy4vU8kCgAEYP2zw/xq2KIzNbsC80uTr//8QnLCLgVuyqd9t000w0dS2kto/7/Wj0mUaSxnEiJ2QGiJ3gFvXcO9QepVl3R6IQGugjN+qdwl8v6TdyfzWwYO6Ec77YB5Rp4aXsd9bY04sOlrQzT7KQxAl8oXU1Y08dWM6GQS6kCKkYfU9vbx2yBkaEddR70ohmfUVwaJM5AGkEpomZ5C7O/sE2lGKlCYNHjN8f424a6J1GDWCtFTBSoBaW1qhJlSQj+yrDS3Xh12tI2Ky1D19FmaAFwBdRO7gtsf/spdaLc0jww6bh/AxV4QPaOicwM9qeXsR99hpsXUFBP5XvG2JjVZq7OHrsjLgFrZZngA==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f470be-8a9e-457b-c8a2-08d75178b69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 14:05:19.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gexdd1OBQgJPwUQmq1EjMa21UaBtCmkzBsijMu7geVSqBZzLhuVN+5yKdktAphcMPu9rn7cL0ozMvLT9fxASiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5104
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.10.2019 17:43, Angus Ainslie wrote:=0A=
=0A=
>>>>> This adds a platform driver for the i.MX8MM SoC.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>=0A=
>>>>> ---=0A=
>>>>>    drivers/interconnect/imx/Kconfig          |   4 +=0A=
>>>>>    drivers/interconnect/imx/Makefile         |   1 +=0A=
>>>>>    drivers/interconnect/imx/imx8mm.c         | 114=0A=
>>>>> ++++++++++++++++++++++=0A=
>>>>>    include/dt-bindings/interconnect/imx8mm.h |  49 ++++++++++=0A=
>>>>>    4 files changed, 168 insertions(+)=0A=
>>>>>    create mode 100644 drivers/interconnect/imx/imx8mm.c=0A=
>>>>>    create mode 100644 include/dt-bindings/interconnect/imx8mm.h=0A=
>>>>=0A=
>>>> Do you plan to add such a driver for imx8mq too?=0A=
>>>=0A=
>>> Yes! The topology is different (serving different IP blocks) but no=0A=
>>> functional code changes are required between 8mm 8mn 8mq.=0A=
>>=0A=
>> Thanks for the update, that's good to hear. I'll get back to you when I=
=0A=
>> come around to test this and wish you good progress until then :)=0A=
>>=0A=
> I've taken up this work while Martin is on leave.=0A=
> =0A=
> I've integrated your u-boot and ATF on our board and I have a couple of=
=0A=
> questions. Our board is running imx8mq B0 (Rev 2.0) silicon.=0A=
> =0A=
> It looks like this line limits the training frequencies to 800 MHz and=0A=
> 166 MHz=0A=
=0A=
Yes! This is due to a hardware errata which was solved in B1: DRAM pll =0A=
can't be disabled. This means that instead of 25/100/800 freqs are =0A=
166/800, and this requires code changes.=0A=
=0A=
> Does 100 MHz and 25 MHz not work on B0 ?=0A=
=0A=
No, lower rates require dram clk from a composite slice (dram_alt_root)=0A=
=0A=
> I added the ddrc_and noc opp as well as the 166MHz opp=0A=
> =0A=
> I also added the interconnects ( do we need them on imx8mq ? )=0A=
=0A=
The interconnect stuff is not required to switch dram frequency, it's =0A=
for device to make minimum bandwidth requests. It an additional feature =0A=
on top.=0A=
=0A=
As a hack I configured FEC to do so but a saner example would be to =0A=
request bandwidth based on display resolution and color depth.=0A=
=0A=
> I had to add a hack as the PM QoS was limiting the bus speed to 399MHz ,=
=0A=
> if you have any ideas why that would be appreciated.=0A=
=0A=
You probably need to set ethernet down (which is awkward) or better just =
=0A=
drop the interconnect properties and test using the devfreq userspace =0A=
governor.=0A=
=0A=
> The driver is probing=0A=
> =0A=
> [   12.136537] bus: 'platform': driver_probe_device: matched device=0A=
> 3d400000.dram-controller with driver imx-ddrc-devfrq=0A=
> [   12.147259] bus: 'platform': really_probe: probing driver=0A=
> imx-ddrc-devfreq with device 3d400000.dram-controller=0A=
> [   12.157382] imx-ddrc-devfreq 3d400000.dram-controller: no pinctrl=0A=
> handle=0A=
> [   12.164197] arm_smcc rate 0 800000000=0A=
> [   12.167880] arm_smcc rate 1 166750000=0A=
> [   12.171778] of: _opp_add_static_v2: turbo:0 rate:25000000 uv:0=0A=
> uvmin:0 uvmax:0 latency:0=0A=
> [   12.179994] of: _opp_add_static_v2: turbo:0 rate:100000000 uv:0=0A=
> uvmin:0 uvmax:0 latency:0=0A=
> [   12.188311] of: _opp_add_static_v2: turbo:0 rate:166750000 uv:0=0A=
> uvmin:0 uvmax:0 latency:0=0A=
> [   12.196606] of: _opp_add_static_v2: turbo:0 rate:800000000 uv:0=0A=
> uvmin:0 uvmax:0 latency:0=0A=
> [   12.204930] imx-ddrc-devfreq 3d400000.dram-controller: events from=0A=
> pmu imx8_ddr0=0A=
> [   12.212403] Added freq 0 25000000=0A=
> [   12.215742] Added freq 1 100000000=0A=
> [   12.219177] Added freq 2 166750000=0A=
> [   12.222648] Added freq 3 800000000=0A=
> [   12.226105] device: 'devfreq0': device_add=0A=
> [   12.230287] PM: Adding info for No Bus:devfreq0=0A=
> [   12.234864] driver: 'imx-ddrc-devfreq': driver_bound: bound to device=
=0A=
> '3d400000.dram-controller'=0A=
> [   12.243699] bus: 'platform': really_probe: bound device=0A=
> 3d400000.dram-controller to driver imx-ddrc-devfreq=0A=
> =0A=
> Add seems to run correctly until it tries to adjust the clock to 166MHz=
=0A=
> =0A=
> [   19.555482] ddrc checking rate 800000000 166750000=0A=
> [   19.555489] ddrc checking rate 166750000 166750000=0A=
> [   19.560442] bus: 'usb-serial': really_probe: bound device ttyUSB0 to=
=0A=
> driver option1=0A=
> [   19.568751] imx-ddrc-devfreq 3d400000.dram-controller: ddrc about to=
=0A=
> change freq 800000000 to 166750000=0A=
> =0A=
> And the board hangs there. Any ideas on how to get past this ?=0A=
=0A=
Please try this ATF patch:=0A=
=0A=
https://github.com/cdleonard/arm-trusted-firmware/commit/783fc2b2c4266bfdb5=
218e4d9b6b2bc90849e0e9=0A=
=0A=
I tested switching on imx8mq-evk with B0 SoC but a few additional =0A=
changes are required in kernel to support switching between rates which =0A=
are both backed by PLL:=0A=
=0A=
* Mark the PLL CLK_GET_RATE_NOCACHE=0A=
* Set the rate to 166935483 exactly (to match clk_get_rate)=0A=
* Make the rounding in imx-ddrc more generous.=0A=
=0A=
I will integrate these changes into the next version.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
