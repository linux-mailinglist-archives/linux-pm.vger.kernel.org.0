Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08958139D68
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 00:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAMXgU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 18:36:20 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:4103
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbgAMXgT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 18:36:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiBTZespsvVnGsIK8gRVdlmTIOTSstG2qZtJQXLym4ZFWORRf7H6AsfWAVHMRCcRjiqwBnlNWwaNj3hLQbPR1VuZi/QsRfSpu/8H5VIC+2C74/2p39JgbND77pTJfFP0OIxKwPqfGyHICmKIi8i9LdeJT8ozHfVLORwrGRTvmGOL0lqgLdnq3Owd+F2Zc4MfLUM4NtZK+vMW7zmCUtT+9xEmRF/923CqBeXZaD6UUfrwEY07FD6P55OKU7i0sAHn4Zum8tAHMx0ePNZyH0EA/d7B/J7RFQtM6eiAD5fTN+GQ6PiVYUrw7dA+faidZ/9TIjq5tpQKCvGJkS9GKvQgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBcr3JFxTFWVKfBSwbzdjFdBQWKyWIglpxV8lsEnUvE=;
 b=b1X4nJK+2GZp6W3vYaMMfgLjIqGAZ6nXOauvH8NaTBYLzjEUrC4Sgitu7sbTMNb/Iml5caYTSdhgt6K6kCxlTX2m2PaECJPqRjY/WHwSoYSOsGAVHFb5ayhyqikmbTf3yy3iSihBWlF1fsy5uLkJN3RBIKJh/SG3Eg1AYbbFU5e6jTCGF4gpuBb4XAOPHxA9D+sql2DGl2Xfo1CdF0PGx3S1typti8M0jrCayGyxkaqYHgYvDZhrKVqhEyT5a9PzePYiIsNUjIfb72SIdkHnspiassP4+jhl3kvqMhskwqxQydLzX6TKqTmGUoqodCf6RXJ3a2Xhtf1nCa0pzuz8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBcr3JFxTFWVKfBSwbzdjFdBQWKyWIglpxV8lsEnUvE=;
 b=Z8rI6xoeFgKdS++ZTJwF5pPEVdXPvlc0qi/UZp8yGtNyMHWB0k3x9zOC99zpGrD1rowJ/ldgvez6X5WjoCkPVloKgQsrIauTg8lM4RX9IL2h426kWBJ2Pv+CVmuEGWteJovbN9QIcyv+yfnUCUZkV+lYhIyZuKD50e7CDqI9Lds=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.52.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 23:36:14 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 23:36:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Adam Ford <aford173@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v7 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Topic: [PATCH v7 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Thread-Index: AQHVoX4nPagdJ4eJVUSp7HmX0gzdZg==
Date:   Mon, 13 Jan 2020 23:36:14 +0000
Message-ID: <VI1PR04MB7023DA37F366D4C770D7312EEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
 <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com>
 <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xKHJAb8k1A+WC3EUOmgLTx-Kbjw_5EsmwyhDkkOKCsmGQ@mail.gmail.com>
 <VI1PR04MB702379645745FB697033FE6BEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xLOgh+E5Gw+2v4RUuZANHa+CkW=ACHL5NALMcSRfRY8eQ@mail.gmail.com>
 <CAHCN7xKjpN_XEGLj-1jMG5mBbF=su67k+10frheLt+L1XaR0-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bb61ad1-ffc5-475a-59ac-08d798816112
x-ms-traffictypediagnostic: VI1PR04MB5008:|VI1PR04MB5008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB500814450E981AB616AC0B7CEE350@VI1PR04MB5008.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(33656002)(966005)(66476007)(478600001)(76116006)(6636002)(8676002)(91956017)(2906002)(7696005)(81156014)(5660300002)(66946007)(26005)(186003)(316002)(81166006)(64756008)(66446008)(66556008)(7416002)(52536014)(53546011)(6506007)(110136005)(44832011)(86362001)(54906003)(55016002)(9686003)(4326008)(71200400001)(8936002)(49910200004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5008;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQ05yYtgxdahpYOUdhdK5ZmEv8yqnaCYl0Sut+RJ/lRBVpnoZpbm6N69bbVALnSGw+jXLf4Cm1gfT3F8uJufMzCZs2l35P2rc0Aj0vEUbCGepjqHcXa3Egab6as+AJqvQrdQ2eyF1QiK+jfHf5XD5jQSM6H0hm6WxDKY344wsc67LCz/ADtlhXonjjhW423eMdyyP4zxq9J6hOmvioEdci4adwBYoLGpsu/byx+5TY7twXlZth091IF27oJ4//fPrXogoIJctzFfLwwSZBU+Q34LQQK41MGP7FX9HoHR7yrWCzBs1YfXLg1ny5QEzN8M6AfmS1appOs42N7NoVbtVc+niRmZphaEMzwp1pKeVls/95FhJfQWkN+aS23+UsTm6WwumVNVhhaahlZ8j46EmI1MvRxhSlqg0DAMQnGCD8HARwDJvih4e7oPJ34c4kIC61qw6z4thKRTuA9qdSrwdKdPmFDKhAj8b0lQG0FKZCXkTahDjZ9qpImakx1PMgtV8vmucaTZqx9oghiRUqzflm/gt1J6GlEikIyfb2N80WHGCdGUBk1ABu9x7Y48gMj+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb61ad1-ffc5-475a-59ac-08d798816112
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 23:36:14.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoHJBx8XEs9CgRU2+dIJG56rop9Y9lL/5D31ObxFoPLEErKMCyv4tupsxQBwHe3LWyyePWoR8OgrWA+rhvwAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5008
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.01.2020 20:34, Adam Ford wrote:=0A=
> On Wed, Dec 18, 2019 at 10:42 AM Adam Ford <aford173@gmail.com =0A=
> <mailto:aford173@gmail.com>> wrote:=0A=
>      > > U-Boot booted and Linux booted, but I still get:=0A=
>      > >=0A=
>      > >=A0 =A0 =A0imx8m-ddrc-devfreq 3d400000.memory-controller: failed =
to init=0A=
>      > > firmware freq info: -19=0A=
>      >=0A=
>      > Which version of u-boot is that, upstream? I'm subscribed to uboot=
=0A=
>      > mailing list and I see that imx8m support has its own separate iss=
ues=0A=
>      > but my familiarity is limited :(=0A=
> =0A=
>     U-Boot 2020.01-rc4-00244-gf39abbbc53-dirty (Dec 18 2019 - 09:27:40=0A=
>     -0600)=0A=
> =0A=
>      >=0A=
>      > I've only ever tested with NXP uboot and the NXP version of mkimag=
e:=0A=
>      >=0A=
>      >=0A=
>     https://source.codeaurora.org/external/imx/uboot-imx/log/?h=3Dimx_v20=
19.04_4.19.35_1.1.0=0A=
>     <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
source.codeaurora.org%2Fexternal%2Fimx%2Fuboot-imx%2Flog%2F%3Fh%3Dimx_v2019=
.04_4.19.35_1.1.0&data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C5babd2cb3fec=
4dc0a21008d795fbbc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637142780=
735473321&sdata=3DLhleGMcJzjiNsPbVxmPbvgRVMnl%2F2HxUqVYKcgCFiEg%3D&reserved=
=3D0>=0A=
>      > https://source.codeaurora.org/external/imx/imx-mkimage/=0A=
>     <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
source.codeaurora.org%2Fexternal%2Fimx%2Fimx-mkimage%2F&data=3D02%7C01%7Cle=
onard.crestez%40nxp.com%7C5babd2cb3fec4dc0a21008d795fbbc4a%7C686ea1d3bc2b4c=
6fa92cd99c5c301635%7C0%7C0%7C637142780735483320&sdata=3DenJQ9hgVkIG7frJ9v6Q=
BQAgJBL8j3hWB7RAKa8XhPaw%3D&reserved=3D0>=0A=
> =0A=
>     I will try your versions and see what happens.=0A=
> =0A=
>      > My bootloader prints the following BuildInfo:=0A=
>      >=A0 =A0 - ATF 70fa7bc=0A=
>      >=0A=
>      >=A0 =A0 - U-Boot 2019.04-00019-g4d377539a119=0A=
>      >=0A=
> =0A=
>     Thanks for your help.=0A=
> =0A=
> =0A=
> I wanted to try again after everything was merged into linux-next.=0A=
> =0A=
> I am using the U-Boot master (as of 10 Jan 2020), with ATF from =0A=
> 4.19.35_1.1.0 from Code Aurora.=A0 I have tried your ATF, but I don't see=
 =0A=
> any change in behavior.=A0 I have made the DDRC a module, but I still get=
 =0A=
> the same error message.=0A=
> =0A=
> [ =A0 =A02.204554] imx8m-ddrc-devfreq 3d400000.memory-controller: failed =
to =0A=
> init firmware freq info: -19=0A=
> =0A=
> Is there something else I can try?=0A=
=0A=
Yes, the NXP branch of uboot from Code Aurora (my commit hash is above).=0A=
=0A=
I understand you want to use uboot and atf master, apparently they both =0A=
need to be patched for this feature to work. It would still be =0A=
interesting to validate.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
