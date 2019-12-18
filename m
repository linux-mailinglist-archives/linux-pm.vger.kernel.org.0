Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BDC124D11
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLRQW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 11:22:27 -0500
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:28644
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfLRQW0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 11:22:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clRIXXL0G13Nnuh3UVWQEy1wE9Ys9ILspf7HFrwwSCDg2Z5g2+NJODBvg3ysV+xADyC9vkTIJyurb+nTMrBBPLRy3cu4IzB+DKWuznlgxFWxpe9Ht9lcutmwmrGy49b68w4cu0uA4XIowJUhbqe9VxH6NUASUq1xl0h48tG4YqH7hGUq84N1ZQ7pq84q7zU2g32p3ie7yDW2UT0AyONp+KK18aZughyRXythaJi5TOiHZt+AkOWeYZX9o+u5+AOFYhDwGnSbJiqwwtsLi5gcUX83+OeO/4A9fcHYXWEQ5oXPENBabtmuOlQFKmsuDUq+Jn0LeFJD/TpDKFXfDVvj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKdab3p6OxgZ99tL83gL2haeWlKPxNNLswcCH4jOCPI=;
 b=b9XT7tNKXlZxD0xADeS3AHCIeN8BC3XgGPTwstg79wcPPP8BN83inG/ElaeoncL/wZjvqbxfSk9LedFmVD4+dDbr20ymWsCZsVRp0LhAF4Z0rs2iqPRzljYgESFI02gsg1z8Q9m2Ge1066di+Xz4VbCq5UjlHG4SNYc4t0OXGwdmRbR2Net3BkQkNY0LOmybKfx2m0Hm9NMJKV84gjOkMcPJkkMGhtMiyD2whrY+4kwJAUgpTAYYaS2wJFIPjdA8NLq89UU1GzHFrugeGwZbtiW4Rkykz5KmDdtSkpSCkXa+PNzmlQA120Zvvjm0+YZkBDZQK9JFGXpKTZBWP20JhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKdab3p6OxgZ99tL83gL2haeWlKPxNNLswcCH4jOCPI=;
 b=TkYNmdIx4K96VFR4tSamqdd5gKZYTim8pBN7TsX2bsAtQpT5wf4U/BYvpSdgvo5OIeZ4hCWqljl517Zyd9ldIUAz5lu6dewGtY6mDa43Urlwptf6C+lI3jFjERS3aUsrtgV1gB1Wc8Jp6vyg8rCv+cuiNn2dVBHkVmovRSzzTaw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5693.eurprd04.prod.outlook.com (20.178.126.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 16:22:21 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 16:22:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Adam Ford <aford173@gmail.com>, Jacky Bai <ping.bai@nxp.com>
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
Date:   Wed, 18 Dec 2019 16:22:21 +0000
Message-ID: <VI1PR04MB702379645745FB697033FE6BEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
 <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com>
 <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xKHJAb8k1A+WC3EUOmgLTx-Kbjw_5EsmwyhDkkOKCsmGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20fc3907-ca29-45c8-c1a9-08d783d675bb
x-ms-traffictypediagnostic: VI1PR04MB5693:|VI1PR04MB5693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB56931FE04880016924AD6C04EE530@VI1PR04MB5693.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(45080400002)(55016002)(110136005)(54906003)(71200400001)(86362001)(7416002)(316002)(9686003)(2906002)(966005)(5660300002)(6636002)(33656002)(6506007)(26005)(44832011)(8936002)(52536014)(8676002)(7696005)(81156014)(53546011)(81166006)(66446008)(4326008)(66476007)(66556008)(64756008)(478600001)(66946007)(76116006)(91956017)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5693;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8kk0StQWxHRAgR/85IEuqKJUyt/qXeuxRStcwKAocaQ3eJUfUDY/eaD/eBjnKPBe3fwC83rto49mOspPkM4vSGdPslt9Xj7Is7Q88/A5gHRnbLe6zrm3CAcysnWYRvvXqyvtxoy7AdbEU7MRwM7SbT9NZphsOpnp/EAKF6k50erBohBrrUwcFPMT8gpZKusf+1RiicI9Kniz/pHc4mJm76MP7wH2J2cqLGVllUsR8BWqxPrCZuCv8yPQyit5AxHAxb2MdjGpsakiqoi2SreDjb3oSsPQLmIqkrstSu7DD97QisiAIdiIgW6B7yhTLJXFm82/wWM/E0y/nmvmGA0O+Tigpqt78vzzmZ/x3SLssWD/fnD+INBHzLXk51+0Nl8Yawb1W5+cDvBRihFOnr+RvTrbgq/Pl2lhFDH34wPUgb40ap8h8VjcDiwvseOfeIy3gIZb+epmlvI86Azpt0rMIi23mLr29QMdIEllrFfRsYFhw8b5fOUXS/dQu4HyBsTbhyZ72uWJZ9UfxK93QmuHA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fc3907-ca29-45c8-c1a9-08d783d675bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:22:21.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdRdvQT2rZ19bgfhFpR/ZInT9hDPHhoTQFJwlBth/u4+CRw/pbNfV1FhxpUrqW7roX0tLR4ntqYoXYmBFbK49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5693
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.12.2019 17:37, Adam Ford wrote:=0A=
> On Wed, Dec 18, 2019 at 9:16 AM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>>=0A=
>> On 18.12.2019 17:05, Adam Ford wrote:=0A=
>>> On Wed, Dec 18, 2019 at 8:44 AM Leonard Crestez <leonard.crestez@nxp.co=
m> wrote:=0A=
>>>>=0A=
>>>> On 18.12.2019 15:35, Adam Ford wrote:=0A=
>>>>> On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nxp.=
com> wrote:=0A=
>>>>>>=0A=
>>>>>> This adds support for dynamic scaling of the DDR Controller (ddrc)=
=0A=
>>>>>> present on i.MX8M series chips. Actual frequency switching is=0A=
>>>>>> implemented inside TF-A, this driver wraps the SMC calls and=0A=
>>>>>> synchronizes the clk tree.=0A=
>>>>>>=0A=
>>>>>> DRAM frequency switching requires clock manipulation but during this=
 operation=0A=
>>>>>> DRAM itself is briefly inaccessible so this operation is performed a=
 SMC call=0A=
>>>>>> to by TF-A which runs from a SRAM area. Upon returning to linux the =
clock tree=0A=
>>>>>> is updated to correspond to hardware configuration.=0A=
>>>>>>=0A=
>>>>>> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are=
 handled=0A=
>>>>>> manually: the driver will prepare/enable the new parents ahead of sw=
itching (so=0A=
>>>>>> that the expected roots are enabled) and afterwards it will call clk=
_set_parent=0A=
>>>>>> to ensure the parents in clock framework are up-to-date.=0A=
>>>>>>=0A=
>>>>>> This series is useful standalone and roughly similar to devfreq driv=
ers for=0A=
>>>>>> tegra and rockchip.=0A=
>>>>>>=0A=
>>>>>> Running at lower dram rates saves power but can affect the functiona=
lity of=0A=
>>>>>> other blocks in the chip (display, vpu etc). Support for in-kernel c=
onstraints=0A=
>>>>>> will some separately.=0A=
>>>>>>=0A=
>>>>>> This series has no dependencies outside linux-next. The driver depen=
ds=0A=
>>>>>> on features from the NXP branch of TF-A and will cleanly fail to pro=
be=0A=
>>>>>> on mainline. There are also plans to upstream dram dvfs in TF-A.=0A=
>>>>>>=0A=
>>>>>> Leonard Crestez (5):=0A=
>>>>>>      clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks=0A=
>>>>>>      clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACH=
E=0A=
>>>>>>      dt-bindings: memory: Add bindings for imx8m ddr controller=0A=
>>>>>>      PM / devfreq: Add dynamic scaling for imx8m ddr controller=0A=
>>>>>>      arm64: dts: imx8m: Add ddr controller nodes=0A=
>>>>>>=0A=
>>>>>>     .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++=0A=
>>>>>>     arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +=0A=
>>>>>>     arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +=0A=
>>>>>>     .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +=0A=
>>>>>>     arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +=0A=
>>>>>>     arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +=0A=
>>>>>>     arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +=0A=
>>>>>>     drivers/clk/imx/clk-imx8mm.c                  |  11 +-=0A=
>>>>>>     drivers/clk/imx/clk-imx8mn.c                  |  12 +-=0A=
>>>>>>     drivers/clk/imx/clk-imx8mq.c                  |  12 +-=0A=
>>>>>>     drivers/clk/imx/clk-pll14xx.c                 |   7 +=0A=
>>>>>>     drivers/clk/imx/clk.h                         |   1 +=0A=
>>>>>>     drivers/devfreq/Kconfig                       |   9 +=0A=
>>>>>=0A=
>>>>> Since there is a Kconfig change, should there me a defconfig change?=
=0A=
>>>>=0A=
>>>> Yes, you need to enable CONFIG_ARM_IMX8M_DDRC_DEVFREQ in order to test=
=0A=
>>>> this. Enabling as "m" should work.=0A=
>>>=0A=
>>> I enabled it as 'm' but I was more curious to know if we should push=0A=
>>> this upstream with the rest of the series.=0A=
>>=0A=
>> I skipped enabling because it's very experimental; maybe after imx=0A=
>> interconnect is also enabled?=0A=
>>=0A=
>>>>>>     drivers/devfreq/Makefile                      |   1 +=0A=
>>>>>>     drivers/devfreq/imx8m-ddrc.c                  | 465 ++++++++++++=
++++++=0A=
>>>>>>     15 files changed, 670 insertions(+), 10 deletions(-)=0A=
>>>>>>     create mode 100644 Documentation/devicetree/bindings/memory-cont=
rollers/fsl/imx8m-ddrc.yaml=0A=
>>>>>>     create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
>>>>>=0A=
>>>>> I applied the whole series against 5.5-rc1 and I am trying to test it=
.=0A=
>>>>> I know the 4.14 kernel NXP posted on Code Aurora is capable to=0A=
>>>>> lowering the DDRC controller to 25MHz on the 8MM when the video is=0A=
>>>>> off.  Since there is no video support yet for the 8MM, I was expectin=
g=0A=
>>>>> to see the DDRC clock to be at or around 25MHz.=0A=
>>>>>=0A=
>>>>> Using debug FS, I can see the dram core clock is still running at=0A=
>>>>> 750MHz, and measuring power, it shows something consistent with what =
I=0A=
>>>>> see on the Code Aurora kernel with video turned on and the clock at=
=0A=
>>>>> 750MHz.=0A=
>>>>>=0A=
>>>>> Is there some way to get the dram_core_clk to drop to 25MHz to see=0A=
>>>>> some power reduction?  The same commands used in the Yocto build don'=
t=0A=
>>>>> apply here since we don't have video.=0A=
>>>>=0A=
>>>> Current upstream driver just keeps current frequency by default. Try t=
he=0A=
>>>> following:=0A=
>>>>=0A=
>>>> cd /sys/class/devfreq/devices/devfreq0=0A=
>>>=0A=
>>> can't cd to /sys/class/devfreq/devices/devfreq0: No such file or direct=
ory=0A=
>>>=0A=
>>> I did some checking and I found:=0A=
>>>       imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init=0A=
>>> firmware freq info: -19=0A=
>>>=0A=
>>> Was there some prerequisite patches I needed to apply before your serie=
s?=0A=
>>=0A=
>> You need a recent version of TF-A from nxp ( upstream). Try this:=0A=
>>=0A=
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsour=
ce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Flog%2F%3Fh%3Dimx_4.19.35_1.1=
.0&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7Cc07fadd829994fe6293c08d=
783d02fa9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637122802480130351&a=
mp;sdata=3DdVovGr1ttwrnSz39MPNNVg%2FB8HV5AjrHXGbksO3XvVo%3D&amp;reserved=3D=
0=0A=
>>=0A=
>> Or this:=0A=
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
ub.com%2Fcdleonard%2Farm-trusted-firmware%2Fcommits%2Fimx_2.0.y_busfreq&amp=
;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7Cc07fadd829994fe6293c08d783d02=
fa9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637122802480140347&amp;sda=
ta=3DQ9KPq60FOxJ7GflwupNaXvbqHIR40Ej5GxeY%2BhHI658%3D&amp;reserved=3D0=0A=
>>=0A=
>> Support on upstream ATF is not yet available=0A=
> =0A=
> I cloned your github branch and built it per the instructions in the=0A=
> u-boot readme file.=0A=
> did a make clean on u-boot, copied the bl31.bin to u-boot and rebuild=0A=
> per U-Boot's instructions.=0A=
> =0A=
> U-Boot booted and Linux booted, but I still get:=0A=
> =0A=
>     imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init=0A=
> firmware freq info: -19=0A=
=0A=
Which version of u-boot is that, upstream? I'm subscribed to uboot =0A=
mailing list and I see that imx8m support has its own separate issues =0A=
but my familiarity is limited :(=0A=
=0A=
I've only ever tested with NXP uboot and the NXP version of mkimage:=0A=
=0A=
https://source.codeaurora.org/external/imx/uboot-imx/log/?h=3Dimx_v2019.04_=
4.19.35_1.1.0=0A=
https://source.codeaurora.org/external/imx/imx-mkimage/=0A=
=0A=
My bootloader prints the following BuildInfo:=0A=
   - ATF 70fa7bc =0A=
=0A=
   - U-Boot 2019.04-00019-g4d377539a119=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
