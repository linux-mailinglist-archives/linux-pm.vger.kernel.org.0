Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4C124B5A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLRPQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 10:16:37 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:47337
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbfLRPQh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 10:16:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3aHOKAA65y/Vzvu9Vg7n4mEQu/1aJof5pD+U0qzorMAu9Z8NyzjMscvlfzrM9msc3ntdLflnTplhktgC+3iJEeysNo6+842GHNhPsHN67rTSa9+n5nnfFxFWx4U7avBTULuh+6aA381aEhR+0Q6WlKrVIoe62xCb9KpyHsHIIRprVKyvIwFSF3lrfkoDiMAYGogGTtJAzi6MjFcRuEsJjbrPbxPiyzyB/elSrDsp95lATgoMrelFqkaKNvDFV4nVhCoeXy5AqJWxhqrsgGgzrxLHQ/Ir6tzwgisrSAQJZ4iSJQHUE+LaBydgYFjcwYHedjQOklJTyEa0mQCBEYAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjLb1UkcxbFXKoMkYjdWULaugUZuv2tdgS+eMiN6ZHE=;
 b=Kr2224qWZKqN0NUcvb7WZ+dSTJjwUDjCFynhePjSws4QWsVy/xTtC+JJT15isROh6BGn4ljW2uLqTYWjHpRAq4fwhtm+7gwiBgfSjfSeGEp2b+95MR+JBaijgjIrIRSUPbOV3RV6TO7v2El3Rw7jYbsmVRBsM7DwuiMGHctT+60Sm9yoFtu7vyCJ9mCsZJuLMGotbTaSm1PnZqKfQXWIFufP96NuuJawTQUNjd4je/l2XIU8LsNyOvfMpiOG6iyeB37UiZzt86PVb2IV4O2c2vwvg42HI+Bknd8rsuZUVe2p4mb+GNqM+tiFAOcDuvRReetNF1fU5N0OjGuk6QVMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjLb1UkcxbFXKoMkYjdWULaugUZuv2tdgS+eMiN6ZHE=;
 b=boR98jZhTVGAqm9MSvbXJ4Q9tDreqfGu46TnMb+5cNhVoY8g4aDEvNGaI36stu213W+gB3YrapYG/VRh1uOo7S/1Wg+2KLmc1twEMjsKAmhTjWYG7N8OqUyPCoWX7R7dxKqCBW8G7Tlr1rPDIn4Rdr2FN9SENYSbJ1kaLQQgIR8=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5088.eurprd04.prod.outlook.com (20.177.50.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 15:16:31 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 15:16:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Adam Ford <aford173@gmail.com>, Jacky Bai <ping.bai@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
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
Date:   Wed, 18 Dec 2019 15:16:31 +0000
Message-ID: <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
 <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05e0c1d9-121f-4760-8b6e-08d783cd4300
x-ms-traffictypediagnostic: VI1PR04MB5088:|VI1PR04MB5088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB508814979321F75DF86E12A8EE530@VI1PR04MB5088.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(66946007)(478600001)(66446008)(64756008)(4326008)(66476007)(66556008)(186003)(76116006)(91956017)(316002)(9686003)(2906002)(86362001)(7416002)(54906003)(71200400001)(55016002)(110136005)(52536014)(81156014)(53546011)(81166006)(7696005)(8676002)(6506007)(33656002)(966005)(5660300002)(6636002)(44832011)(26005)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5088;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTNe3onRwr8mntau+5rV50+0PjkcRkvzWXCOcROfiBaEbLTwlmSf89tInYpDF0GGJzC1/yDPSHwTP16pIaiWXl4yHhpXAs+3OAvlkJQDNnQrRnBxPBXcxWKm6V5Q/dYzju0cKS3a+p+oflJ4PphWNC4y+8ImGTd03p/CFc4dRoZtKPhU30PTPaJuU029rtshaqEof5UbawdYweIXGv+AiVWK/mVSaN5OqbDnUqYoHJ7dL4gSxft27PHrorqLt0YMtU7zSE6oJa65gVZ2/64RUdeiIQwnvSNsL6a5lY7sZEQT/z/gRv9+FqzJvlqLn5dNOxh6bae6xsEJwjmOPqwbqFRARa9HQu5evgcs3RL9l0gS+1cOzlsQAVzSHf7Tcm7yTaMcNTNuxAAdxhfbgfDa1Dpe2Dk2CADX1eqWHFzsV6Rh9nknW5gs6Ll8h+danH5OcYofWBV0B2XS/DXFn426oGpZhgQ+gUEe3X/65vimt5YSKEg+9/KBF+xXEBKRZnuFKpUSq0WU46pXu39xvSwOjw==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e0c1d9-121f-4760-8b6e-08d783cd4300
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 15:16:31.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJgE2uQ4dt0EWoEzHD6zfXz+ACQuzs/ZY/pHzBM40fpMibr+IcCpTkZvgxWpqnH5Q1GjYHUSk083dAT8djYb7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5088
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.12.2019 17:05, Adam Ford wrote:=0A=
> On Wed, Dec 18, 2019 at 8:44 AM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>>=0A=
>> On 18.12.2019 15:35, Adam Ford wrote:=0A=
>>> On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nxp.co=
m> wrote:=0A=
>>>>=0A=
>>>> This adds support for dynamic scaling of the DDR Controller (ddrc)=0A=
>>>> present on i.MX8M series chips. Actual frequency switching is=0A=
>>>> implemented inside TF-A, this driver wraps the SMC calls and=0A=
>>>> synchronizes the clk tree.=0A=
>>>>=0A=
>>>> DRAM frequency switching requires clock manipulation but during this o=
peration=0A=
>>>> DRAM itself is briefly inaccessible so this operation is performed a S=
MC call=0A=
>>>> to by TF-A which runs from a SRAM area. Upon returning to linux the cl=
ock tree=0A=
>>>> is updated to correspond to hardware configuration.=0A=
>>>>=0A=
>>>> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are h=
andled=0A=
>>>> manually: the driver will prepare/enable the new parents ahead of swit=
ching (so=0A=
>>>> that the expected roots are enabled) and afterwards it will call clk_s=
et_parent=0A=
>>>> to ensure the parents in clock framework are up-to-date.=0A=
>>>>=0A=
>>>> This series is useful standalone and roughly similar to devfreq driver=
s for=0A=
>>>> tegra and rockchip.=0A=
>>>>=0A=
>>>> Running at lower dram rates saves power but can affect the functionali=
ty of=0A=
>>>> other blocks in the chip (display, vpu etc). Support for in-kernel con=
straints=0A=
>>>> will some separately.=0A=
>>>>=0A=
>>>> This series has no dependencies outside linux-next. The driver depends=
=0A=
>>>> on features from the NXP branch of TF-A and will cleanly fail to probe=
=0A=
>>>> on mainline. There are also plans to upstream dram dvfs in TF-A.=0A=
>>>>=0A=
>>>> Leonard Crestez (5):=0A=
>>>>     clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks=0A=
>>>>     clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE=
=0A=
>>>>     dt-bindings: memory: Add bindings for imx8m ddr controller=0A=
>>>>     PM / devfreq: Add dynamic scaling for imx8m ddr controller=0A=
>>>>     arm64: dts: imx8m: Add ddr controller nodes=0A=
>>>>=0A=
>>>>    .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++=0A=
>>>>    arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +=0A=
>>>>    arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +=0A=
>>>>    .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +=0A=
>>>>    arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +=0A=
>>>>    arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +=0A=
>>>>    arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +=0A=
>>>>    drivers/clk/imx/clk-imx8mm.c                  |  11 +-=0A=
>>>>    drivers/clk/imx/clk-imx8mn.c                  |  12 +-=0A=
>>>>    drivers/clk/imx/clk-imx8mq.c                  |  12 +-=0A=
>>>>    drivers/clk/imx/clk-pll14xx.c                 |   7 +=0A=
>>>>    drivers/clk/imx/clk.h                         |   1 +=0A=
>>>>    drivers/devfreq/Kconfig                       |   9 +=0A=
>>>=0A=
>>> Since there is a Kconfig change, should there me a defconfig change?=0A=
>>=0A=
>> Yes, you need to enable CONFIG_ARM_IMX8M_DDRC_DEVFREQ in order to test=
=0A=
>> this. Enabling as "m" should work.=0A=
> =0A=
> I enabled it as 'm' but I was more curious to know if we should push=0A=
> this upstream with the rest of the series.=0A=
=0A=
I skipped enabling because it's very experimental; maybe after imx =0A=
interconnect is also enabled?=0A=
=0A=
>>>>    drivers/devfreq/Makefile                      |   1 +=0A=
>>>>    drivers/devfreq/imx8m-ddrc.c                  | 465 +++++++++++++++=
+++=0A=
>>>>    15 files changed, 670 insertions(+), 10 deletions(-)=0A=
>>>>    create mode 100644 Documentation/devicetree/bindings/memory-control=
lers/fsl/imx8m-ddrc.yaml=0A=
>>>>    create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
>>>=0A=
>>> I applied the whole series against 5.5-rc1 and I am trying to test it.=
=0A=
>>> I know the 4.14 kernel NXP posted on Code Aurora is capable to=0A=
>>> lowering the DDRC controller to 25MHz on the 8MM when the video is=0A=
>>> off.  Since there is no video support yet for the 8MM, I was expecting=
=0A=
>>> to see the DDRC clock to be at or around 25MHz.=0A=
>>>=0A=
>>> Using debug FS, I can see the dram core clock is still running at=0A=
>>> 750MHz, and measuring power, it shows something consistent with what I=
=0A=
>>> see on the Code Aurora kernel with video turned on and the clock at=0A=
>>> 750MHz.=0A=
>>>=0A=
>>> Is there some way to get the dram_core_clk to drop to 25MHz to see=0A=
>>> some power reduction?  The same commands used in the Yocto build don't=
=0A=
>>> apply here since we don't have video.=0A=
>>=0A=
>> Current upstream driver just keeps current frequency by default. Try the=
=0A=
>> following:=0A=
>>=0A=
>> cd /sys/class/devfreq/devices/devfreq0=0A=
> =0A=
> can't cd to /sys/class/devfreq/devices/devfreq0: No such file or director=
y=0A=
> =0A=
> I did some checking and I found:=0A=
>      imx8m-ddrc-devfreq 3d400000.memory-controller: failed to init=0A=
> firmware freq info: -19=0A=
> =0A=
> Was there some prerequisite patches I needed to apply before your series?=
=0A=
=0A=
You need a recent version of TF-A from nxp ( upstream). Try this:=0A=
=0A=
https://source.codeaurora.org/external/imx/imx-atf/log/?h=3Dimx_4.19.35_1.1=
.0=0A=
=0A=
Or this: =0A=
https://github.com/cdleonard/arm-trusted-firmware/commits/imx_2.0.y_busfreq=
=0A=
=0A=
Support on upstream ATF is not yet available=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
