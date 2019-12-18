Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFB1249F8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLROom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 09:44:42 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:29485
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfLROom (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 09:44:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXd1vMvWJbUUz+hu81eRwKQMM133w37ya9YF9vHMp82fVuvpckP6QIiZBLS0Uzk/4vvha2OiHgtjwNkxYGX7pVR7M4JWudBjoFAUnGOxjqM5rt9AMXq6J5eeTznM1xLiZynaLWP/njjDPNTT7ZOFiwWAz534coOQg1tPQw5yKL3zuOUimteqpifi3/PCSzOXGiaImmwyn+/bxfiNauYiRzCRNsexE3CusaZC4eCUXWKVF+IKdSZMrBvmG/6YavYApcWxY3ajv0fYQbp3innJq99C1OSunmupaWtemWFIfhUQJMFSR5+FXvA4SooYTnk0zXl0S1+jJitNd9Fqpr/ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdV3EJ+hp+kdZ/ajSy90qb5vqDrqZMwVp3BywZUxBiQ=;
 b=KQkhGEVbHT3I7wvst2dZ5UNCrJCWnA3z4WdwUN6YN2cQhLbnMOGhiO6d2NUS9zDXPGPofJ60g72FakKrutXDWakI5PU8vhh51PjMjRETFMf6QSJtsYtMeubzJh9rQrF+cHmevNEUcHrohQ6Lp9ESgmjzuNEgG0UT64f+0tL/yMcI2ayFDPXeF+Jg5nzAcmdfOzO32chBVhj+M3q71OKHoeuZayuXTIVhwG//etqTrVIndUco5gMhwrBzS02DX4Sqmoj8zj1uPX8P8n2TsGjj3SEpvseCVtAvVETuaYXJmN5pof18U7wOruNVE3OCKi9IRM5xKbP1zQI06PARmntiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdV3EJ+hp+kdZ/ajSy90qb5vqDrqZMwVp3BywZUxBiQ=;
 b=KQcLaQL0kYgO6MN1Gvk8Bsz5SXvords0o+lE8kckM58AL2vh8Lh5FzlhBwbquBF4A4UhSgWSd0iOWlXVaD7uTmfl2g8y28l4mQVjUos67F/AnaTHc2ocM7GTW3FRgnzLqRjWYE9ReFLAREAlDhavJxA4aZ1jqgcQDbrtc6RjAPA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5280.eurprd04.prod.outlook.com (20.177.51.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 14:44:36 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 14:44:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Adam Ford <aford173@gmail.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
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
Date:   Wed, 18 Dec 2019 14:44:35 +0000
Message-ID: <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
 <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d15f8f46-dc57-43df-1189-08d783c8cd80
x-ms-traffictypediagnostic: VI1PR04MB5280:|VI1PR04MB5280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB528095B35C00D0C5DBB43D5EEE530@VI1PR04MB5280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(2906002)(66946007)(44832011)(91956017)(8936002)(81156014)(8676002)(81166006)(76116006)(5660300002)(33656002)(4326008)(64756008)(52536014)(55016002)(66446008)(66476007)(66556008)(9686003)(86362001)(966005)(478600001)(45080400002)(316002)(54906003)(6916009)(186003)(71200400001)(53546011)(6506007)(7696005)(7416002)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5280;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbpKrkgxlJfwurAKcCP2Kzj1ht+H/uYijVK73xIqvp2MnhJR4KJPxfYwGM/Qkxx9t5X4uqhgy9tz6hHLtaBNXsf7RLdr2NQVeWYlNlEIx+Uln3mNe35O4F4pMRPirgySmc3juXCwp6+oEiFrOdZRzoLi4NqATyhFDxBNCVfjGMoplyEWh8Y7B+WGAqe+v/58gVkEb45Gt47GpfZsmLvbnH9xMi0Bmih+DVDoTJx3D2WprvWR8Trj0mSGfLG+60GRvxe9/svqoZTt71UzKm872OZkcBWuYAG2NYd6nzKHE4NiM8CKlDmNQ1RWkKFK/G2UOOW03BBoQudxXbJxSOGkNn/cJcItYq2TCcz4fkdYsv9EaEagn8apK2KJrE9IrdXDDDpOegEZF1IlNTlVkIszS6ba7yAZW8kx7gSZV5Fybu8HH3/w7NIZlAR8OgfcL00KSrunBlQl3Tsu6qwZ3GBit2X6cOMHYuP3mAeWJifjX7Yrkhhu0tIp12Tz6W7NdtY1+MOdABOvZiqalvRwSf6ZvA==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15f8f46-dc57-43df-1189-08d783c8cd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 14:44:35.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOF73bfyDwOQJcFjPsOPV/mfgK0bBJUiNiEbwJhGrOhu43SkYnr7AZshDY1lnJ6NIiELPLGNbCpgYlE6v2YQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5280
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.12.2019 15:35, Adam Ford wrote:=0A=
> On Fri, Nov 22, 2019 at 3:45 PM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>>=0A=
>> This adds support for dynamic scaling of the DDR Controller (ddrc)=0A=
>> present on i.MX8M series chips. Actual frequency switching is=0A=
>> implemented inside TF-A, this driver wraps the SMC calls and=0A=
>> synchronizes the clk tree.=0A=
>>=0A=
>> DRAM frequency switching requires clock manipulation but during this ope=
ration=0A=
>> DRAM itself is briefly inaccessible so this operation is performed a SMC=
 call=0A=
>> to by TF-A which runs from a SRAM area. Upon returning to linux the cloc=
k tree=0A=
>> is updated to correspond to hardware configuration.=0A=
>>=0A=
>> This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are han=
dled=0A=
>> manually: the driver will prepare/enable the new parents ahead of switch=
ing (so=0A=
>> that the expected roots are enabled) and afterwards it will call clk_set=
_parent=0A=
>> to ensure the parents in clock framework are up-to-date.=0A=
>>=0A=
>> This series is useful standalone and roughly similar to devfreq drivers =
for=0A=
>> tegra and rockchip.=0A=
>>=0A=
>> Running at lower dram rates saves power but can affect the functionality=
 of=0A=
>> other blocks in the chip (display, vpu etc). Support for in-kernel const=
raints=0A=
>> will some separately.=0A=
>>=0A=
>> This series has no dependencies outside linux-next. The driver depends=
=0A=
>> on features from the NXP branch of TF-A and will cleanly fail to probe=
=0A=
>> on mainline. There are also plans to upstream dram dvfs in TF-A.=0A=
>>=0A=
>> Changes since v6:=0A=
>> * Replace ARCH_MXC || COMPILE_TEST with ARCH_MXC && HAVE_ARM_SMCCC=0A=
>> * Collect reviews=0A=
>> Link to v6: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11244283%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637122729275120308&amp;sdata=3DZEZnG6pijjj4MObC=
99c6%2BvC8BFEfT1KLVxbJCNocoWw%3D&amp;reserved=3D0=0A=
>>=0A=
>> I'd rather not fix COMPILE_TEST with ifdefs for this driver, if anything=
=0A=
>> that should be fixed in smccc header. ARCH_MXC doesn't imply SMCCC, it=
=0A=
>> also covers some very old chips which don't have it.=0A=
>>=0A=
>> Resending full series because that's the standard method.=0A=
>>=0A=
>> Changes since v5:=0A=
>> * Fix a dram_apb/dram_alt mixup in imx8m_ddrc_set_freq=0A=
>> * Make clk_get_parent_by_index static (kbuild robot)=0A=
>> * Adjust messages in imx8m_ddrc_set_freq=0A=
>> * Use a for loop inside imx8m_ddrc_check_opps instead of while=0A=
>> * More elaborate description in dt-bindings file.=0A=
>> Link to v5: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11240289%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3DmMqglPQign%2B6NH=
gmDYoZ74%2FZeThGI6%2FgNkajo1VaHTI%3D&amp;reserved=3D0=0A=
>>=0A=
>> Changes since v4:=0A=
>> * Restore empty _get_dev_status: testing shows this is *NOT* optional. I=
f=0A=
>> absent then switching to simple_ondemand governor will trigger an Oops.=
=0A=
>> * Keep clk registration on single-line in clk-imx8m* for consistency wit=
h rest=0A=
>> of the file.=0A=
>> * Drop explicit "select PM_OPP"=0A=
>> * Check for NULL new_dram_core_parent=0A=
>> * Rename "out_dis_" labels to out_disable_*=0A=
>> * Use dev_warn on imx8m_ddrc_set_freq error paths after SMC call (where=
=0A=
>> operation is not abandoned).=0A=
>> * More elaborate error messages in imx8m_ddrc_target=0A=
>> * More elaborate checks when fetching clks in imx8m_ddrc_set_freq=0A=
>> * Rename ddrc nodes to memory-controller@* as per devicetree.org "Generi=
c Names=0A=
>> Recommendation"=0A=
>> * Defer perf support, it requires perf changes to fetch PMU by DT=0A=
>> Link to v4: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11235685%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3DLXG4bo0l7FOttZIo=
lJE73CK67AAAW72xfx8yq3Vld7o%3D&amp;reserved=3D0=0A=
>>=0A=
>> Changes since v3:=0A=
>> * Rename to imx8m-ddrc. Similar blocks are present on imx7d and imx8qxp/=
imx8qm=0A=
>> but soc integration is different.=0A=
>> * Move dt bindings to /memory-controllers/fsl/=0A=
>> * Fix dt validation issues=0A=
>> * Fix imx8mm.dtsi ddrc referencing ddrc_opp_table which is only defined =
in evk=0A=
>> * Move opps to child of ddrc device node=0A=
>> * Only add imx_ddrc_get_dev_status in perf patch.=0A=
>> * Adjust print messages=0A=
>> Link to v3: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11221935%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3D%2FFGddgm7jq87j7=
tz6gNd%2B7V%2BGX4KF5RaPsnXK2kITdQ%3D&amp;reserved=3D0=0A=
>>=0A=
>> Changes since v2:=0A=
>> * Add support for entire imx8m family including imx8mq B0.=0A=
>> * Also mark dram PLLs as CLK_GET_RATE_NO_CACHE (required for imx8mq b0 l=
ow OPP)=0A=
>> * Explicitly update dram pll rate at the end of imx_ddrc_set_freq.=0A=
>> * Use do_div in imx-ddrc (kbuild robot)=0A=
>> * Improve explanations around adding CLK_GET_RATE_NO_CACHE to dram clks.=
=0A=
>> (Stephen Boyd)=0A=
>> * Handle ddrc devfreq-events earlier for fewer probe defers.=0A=
>> * Validate DDRC opp tables versus firmware: supported OPPs depend on boa=
rd and=0A=
>> SOC revision.=0A=
>> * Move DDRC opp tables to board dts because they can vary based on ram t=
ype on=0A=
>> board.=0A=
>> * Verify DDRC rate is changed in clk tree and otherwise report an error.=
=0A=
>> * Change imx_ddrc_freq.rate to be measure in MT/s and round down from HZ=
 in=0A=
>> imx_ddrc_find_freq instead.=0A=
>> * Split away from NOC scaling and interconnect support.=0A=
>> Link to v2: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11104113%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3D3hh0dR1h4Esc6qo7=
9QQKH%2FkUQjrOUgLANR0PcIz1Pss%3D&amp;reserved=3D0=0A=
>>=0A=
>> Changes since v1:=0A=
>> * bindings: Stop using "contains" for "compatible"=0A=
>> * bindings: Set "additionalProperties: false" and document missing stuff=
.=0A=
>> * Remove (c) from NXP copyright notice=0A=
>> * Fix various checkpatch issues=0A=
>> * Remove unused dram_alt_root clk from imx-ddrc=0A=
>> Link to v1: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11090649%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7Cb7adb366b79f4c564c7908d783bf23ae%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637122729275130306&amp;sdata=3DHj6NEmoaRHoR%2BQ=
pFoUDdTlybO%2FSTatO2fFo20UGLJf0%3D&amp;reserved=3D0=0A=
>>=0A=
>> Leonard Crestez (5):=0A=
>>    clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks=0A=
>>    clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE=0A=
>>    dt-bindings: memory: Add bindings for imx8m ddr controller=0A=
>>    PM / devfreq: Add dynamic scaling for imx8m ddr controller=0A=
>>    arm64: dts: imx8m: Add ddr controller nodes=0A=
>>=0A=
>>   .../memory-controllers/fsl/imx8m-ddrc.yaml    |  72 +++=0A=
>>   arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +=0A=
>>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +=0A=
>>   .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +=0A=
>>   arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +=0A=
>>   arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +=0A=
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +=0A=
>>   drivers/clk/imx/clk-imx8mm.c                  |  11 +-=0A=
>>   drivers/clk/imx/clk-imx8mn.c                  |  12 +-=0A=
>>   drivers/clk/imx/clk-imx8mq.c                  |  12 +-=0A=
>>   drivers/clk/imx/clk-pll14xx.c                 |   7 +=0A=
>>   drivers/clk/imx/clk.h                         |   1 +=0A=
>>   drivers/devfreq/Kconfig                       |   9 +=0A=
> =0A=
> Since there is a Kconfig change, should there me a defconfig change?=0A=
=0A=
Yes, you need to enable CONFIG_ARM_IMX8M_DDRC_DEVFREQ in order to test =0A=
this. Enabling as "m" should work.=0A=
=0A=
>>   drivers/devfreq/Makefile                      |   1 +=0A=
>>   drivers/devfreq/imx8m-ddrc.c                  | 465 ++++++++++++++++++=
=0A=
>>   15 files changed, 670 insertions(+), 10 deletions(-)=0A=
>>   create mode 100644 Documentation/devicetree/bindings/memory-controller=
s/fsl/imx8m-ddrc.yaml=0A=
>>   create mode 100644 drivers/devfreq/imx8m-ddrc.c=0A=
> =0A=
> I applied the whole series against 5.5-rc1 and I am trying to test it.=0A=
> I know the 4.14 kernel NXP posted on Code Aurora is capable to=0A=
> lowering the DDRC controller to 25MHz on the 8MM when the video is=0A=
> off.  Since there is no video support yet for the 8MM, I was expecting=0A=
> to see the DDRC clock to be at or around 25MHz.=0A=
> =0A=
> Using debug FS, I can see the dram core clock is still running at=0A=
> 750MHz, and measuring power, it shows something consistent with what I=0A=
> see on the Code Aurora kernel with video turned on and the clock at=0A=
> 750MHz.=0A=
> =0A=
> Is there some way to get the dram_core_clk to drop to 25MHz to see=0A=
> some power reduction?  The same commands used in the Yocto build don't=0A=
> apply here since we don't have video.=0A=
=0A=
Current upstream driver just keeps current frequency by default. Try the =
=0A=
following:=0A=
=0A=
cd /sys/class/devfreq/devices/devfreq0=0A=
echo userspace > governor=0A=
echo 25000000 > userspace/set_freq=0A=
cat /sys/kernel/debug/clk/dram_core_clk/clk_rate=0A=
echo 750000000 > userspace/set_freq=0A=
cat /sys/kernel/debug/clk/dram_core_clk/clk_rate=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
