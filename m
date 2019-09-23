Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610F1BBDC3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfIWVWx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 17:22:53 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:60083
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388117AbfIWVWx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 17:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXBgHV8PT+RgfrFox7fTSVFfHAHcoAiU8KadqMKvMnD31x1SoQDeT0btvmMzt/WB+AwOL+UGDXJZ1IsZk6Pb5EPuDe3sAqZ+XDdT7+aW1m6TL406hSjLGUWuY5r29PLIZX5KBRgBt4XILGs22Hp+iRB7GITShxp8AAQTx2Z60HiMpd+adb6eKUAZMsdi4memQcslEJMd/kLPGdfm6uU8pc1JzHzCgVuuzb6goCkLNFP0sslD7M8ArewTuN4yUm4u/NGPF0IMtsNMP/9VDm87Hys7FMTnj/WvW8INd7HpwvoXTHk6/Q097sMY0w86UXpBC1axDAF6uwFSc+qrKd/BYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WkgFVCu6l6w0LNhI6zd9HqQOgO0mVRm6PYkVke1oXU=;
 b=AzQrY3oZWTeZeDhRgFrgau3qm1au9XjEQ7rAKnSDn2Zp/nAiAowznBkNGHbhlR2SfsK/1qmnMzAbkCJsHvwHQkOkaAKHFn3kq2juGXljikN/ojVZWHcG+FDXsmvRG5yR0oe5fSpoyyOASHkqz5IEj8U2jJddAEYroJMcWqOpYw43Zag1CtIUWyYr/JBvRj/TJCeVqr8iMA2IBS9cLxHsS6lc+7+umkB+oC1CUIuQLnFloTobxMNZRY1ohGglsQjSY9mkFfqWCTUcPAj5vodK4CjbNMsYqutk7jX62cE5V/Hm5qxDb5NHyvFuwkbYPVHnCBdi46MgYH9+Z+kpyAxDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WkgFVCu6l6w0LNhI6zd9HqQOgO0mVRm6PYkVke1oXU=;
 b=jiNKkvAcCsmmlkufZqYP/A0qQjIXi8UBxUXyxKUn30daruYdht0Qff+2MiUy0N7oLraa5d5zIms5Ba6guxn2/qlZqiYRrmKj7RO+C+jjGBa7Zx4WVEhYIFwFG2+I17J0TadntW21i/7AEflC2U3UzYWYkNiyb8Mf6abLGgyZDPI=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7101.eurprd04.prod.outlook.com (10.186.159.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 21:22:45 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 21:22:45 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFCv4 0/7] interconnect: Add imx support via devfreq
Thread-Topic: [RFCv4 0/7] interconnect: Add imx support via devfreq
Thread-Index: AQHVWcA7xPiNhLrdqkSG10Lu7U9EhQ==
Date:   Mon, 23 Sep 2019 21:22:45 +0000
Message-ID: <VI1PR04MB7023C5382635F6959EAF9330EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <4440b392-d968-4a54-2ea0-ffd5beba02d1@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9ff94f6-e142-42ec-3549-08d7406c2d36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB7101;
x-ms-traffictypediagnostic: VI1PR04MB7101:|VI1PR04MB7101:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB710123D6905510EEBE2D5376EE850@VI1PR04MB7101.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8676002)(14454004)(6116002)(7696005)(76116006)(64756008)(316002)(102836004)(446003)(66556008)(478600001)(9686003)(26005)(66476007)(99286004)(6246003)(7736002)(305945005)(66446008)(25786009)(110136005)(7416002)(2906002)(476003)(186003)(91956017)(71200400001)(71190400001)(8936002)(5660300002)(256004)(229853002)(76176011)(54906003)(33656002)(4326008)(86362001)(14444005)(44832011)(74316002)(486006)(53546011)(6636002)(6436002)(55016002)(81156014)(66066001)(6506007)(6306002)(3846002)(52536014)(81166006)(66946007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7101;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jdy2i6brLVbS6tOAxIC/z0rAv5FlK08RfDi5zvcwrXbxaqvcT+ZTrtyOfTZA4vkQY+cm2baAB1JFK2v6963b6hr0IG7DMluAPwVwppKStpqsQo+eb0/8SaKVoOQA4FbfK/qEHKmC51N0AO7aptfM1BZxtUUWSSNVSZ06jlU1aqkvG6tQGhOz5fXq3YtQkhB3+C6+Rs+2jfLqonH9lWQFdHUHXAI9gmXeRH3ZbAwEjwb+LzSp9ULb5JDb3HIzggx2Woqj7ly49/t7vOtOwgyzMXQ8gIkVOg6l92tCXcYc4C/yP6lQxA4LGE6dq6S6zrgW3cMY/1bJPWKOGuDwr6Hw98P3jpGYsk5fVkFs8Bpn7T3sks85VpOTBEp7ENTYRwoGGw8vGNokYYAuidYNELLSNm+2sxx/F42LRxIWdSYlj38=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ff94f6-e142-42ec-3549-08d7406c2d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 21:22:45.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOuS9ilYoZSSLw5cRRHs0clzmYMeNRc3ntRF3PirmclsLjfvAZWKVKZm+OkxlrM6fM99kU0iDgikav956AYShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7101
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21.09.2019 09:07, Martin Kepplinger wrote:=0A=
> On 23.08.19 16:36, Leonard Crestez wrote:=0A=
>> This series add imx support for interconnect via devfreq: the ICC=0A=
>> framework is used to aggregate requests from devices and then those are=
=0A=
>> converted to DEV_PM_QOS_MIN_FREQUENCY requests for devfreq.=0A=
>>=0A=
>> The devfreq parts are posted separately, this series only intersects in=
=0A=
>> devicetree.=0A=
>>=0A=
>> Since there is no single devicetree node that can represent the "interco=
nnect"=0A=
>> new API is added to allow individual devfreq nodes to act as parsing pro=
xies=0A=
>> all mapping to a single soc-level icc provider. This is still RFC=0A=
>> because this=0A=
>>=0A=
>> The rest of the changes are small and deal with review comments.=0A=
=0A=
> on imx8mq, probe() fails:=0A=
> =0A=
> [    1.082847] imx-ddrc-devfreq 3d400000.dram-controller: failed to init=
=0A=
> firmware freq info: -19=0A=
> [    1.091434] imx-ddrc-devfreq: probe of 3d400000.dram-controller=0A=
> rejects match -19=0A=
> =0A=
> in imx_ddrc_init_freq_info()'s check:=0A=
> =0A=
> if (priv->freq_count <=3D 0 || priv->freq_count > IMX_DDRC_MAX_FREQ_COUNT=
)=0A=
> =0A=
> That would indicate that I'm missing something in ATF? I'm pretty sure=0A=
> I'm running your tree though.=0A=
=0A=
What is your board and uboot version? I tested on imx8mq-evk (SOC Rev =0A=
B1) with NXP uboot. For example this uboot release works:=0A=
=0A=
https://source.codeaurora.org/external/imx/uboot-imx/log/?h=3Dimx_v2019.04_=
4.19.35_1.0.0=0A=
=0A=
It is uboot which trains DDR for multiple frequencies and then passes =0A=
that info to ATF. I'm not sure about the steps required to enable this =0A=
for 3rd-party boards, should be same as for busfreq from NXP tree.=0A=
=0A=
Getting this to work on a 3rd-party board would be interesting.=0A=
=0A=
> Does anything come to your mind what I might be doing wrong? Am I=0A=
> running your "correct" linux tree? Remember I'm on imx8mq, so I don't=0A=
> exactly test this RFC of yours.=0A=
> =0A=
> Also, how are your plans to rebase / update your ATF tree?=0A=
=0A=
The ATF changes will show up in a future release of NXP ATF branch, when =
=0A=
that happens I will drop my branch. NXP ATF releases are on CAF:=0A=
=0A=
     https://source.codeaurora.org/external/imx/imx-atf/=0A=
=0A=
> And since there's a lot in there: what additions are necessary for this=
=0A=
> devfreq to work?=0A=
=0A=
devfreq imx support here: https://patchwork.kernel.org/cover/11104113/=0A=
Interconnect support also needs PM QoS support for devfreq:=0A=
=0A=
     https://patchwork.kernel.org/cover/11157649/=0A=
=0A=
> Lastly, how do you test? Is /sys/class/devfreq supposted to get populated=
?=0A=
=0A=
Yes, and only the devfreq patches are required for that.=0A=
=0A=
# cat /sys/class/devfreq/devfreq0/available_frequencies=0A=
25000000 100000000 800000000=0A=
# cat /sys/class/devfreq/devfreq0/cur_freq=0A=
800000000=0A=
=0A=
You should be able to control frequencies manually with the userspace =0A=
governor:=0A=
# echo "userspace" > /sys/class/devfreq/devfreq0/governor=0A=
# echo "25000000" > /sys/class/devfreq/devfreq0/userspace/set_freq=0A=
=0A=
This series allows devices to request guaranteed bandwidth for =0A=
themselves through the interconnect subsystem, without it DRAM freq will =
=0A=
still switch but you'll have problems like display corruption as it =0A=
turns on before freq goes up. You can check that probe worked by doing=0A=
=0A=
# cat /sys/kernel/debug/interconnect/interconnect_summary=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
