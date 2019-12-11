Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB311A849
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfLKJxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 04:53:49 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:64321
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727493AbfLKJxs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 04:53:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+YEUgfv6ceKuvqRypGH3jMptpIxFn247OJJTIq2FH9OpnAYs2xDnZhdGfmVQaoZfQvke+pz7x8bF9DOQS9ke/NHGPJiyvT7CcRD2WwaS47fPGWzwYlKEpm3cgMBxw9t3VTjM4xA+cQNUsZ2W6sUMRJ9Ha4flDqWNB4W0vVbixX11d0MurAjf1ErvxCzXoTcPvcLdcE652XqznlaUaDgSxH5GuW0TXZ9heZG2LYR+/2l98N94eJhWYkYABwWzlSi31BNUUhaOIDsRnDowcfmmbCeTnrdAIYxWHFCuEBlT4PS9nKsBhmTb8QccZGbGhIt00OpYMvUx4rAQ8tNY0ZqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLGWhMFsw5imsU/e9+ztTyVw/Fu1KfXEin0IYzil0xE=;
 b=M082h4KACAvs4WCgoax1WCWmlIQnz3wAU7BAlHE/95cF9a/mTq4xV0XkkBm/cp5ahjOrVkm8CLeXVIXQxurosp3jv6VRbQq+5c2vlZ3VZ6/TiftCPwAARueLExuUV5XdgtFfEpkOoDH8/iIQ+MT1LUW8u0ovuIcM7LzPASjjiN3BszbMkRf+a3Bfrwv28dZWRwiItjjXAWyoF80tD7HpwQSMdEYMIAzyQvxcnUd5r0XfP8B0xO4kSPp/2jQVAp/veJ/UBkyk+wuQ/cerLJv2+A3z9B7L5O+V+4N0q6gOP8mMKY5zMM1ZIotiOitfq+Rl/F9ccyjs/Dd/NNwPzkwqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLGWhMFsw5imsU/e9+ztTyVw/Fu1KfXEin0IYzil0xE=;
 b=nsjewIH2tmouzkhcfS3PaXEbYVgk6q+xlqhyG9udWEdB+MgNC+2+SYJkDfhbo5TUrphjEh9aaDh/HRYOtwC4+b6NcL8/6HHsXmfnNQ0MVKAfHL0a4Bamf2hWpTfhhMzodXQmKZPDw3zJxUsRQpZ3G58tsbmtv1oFLkbtbOL0svE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6864.eurprd04.prod.outlook.com (52.133.246.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 09:53:38 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.016; Wed, 11 Dec 2019
 09:53:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v6 0/9] interconnect: Add imx support via devfreq
Thread-Topic: [PATCH RFC v6 0/9] interconnect: Add imx support via devfreq
Thread-Index: AQHVmyeX+HHYkDJzz0q57HQmhjkEQA==
Date:   Wed, 11 Dec 2019 09:53:38 +0000
Message-ID: <VI1PR04MB702367B475FB20214F27F1F5EE5A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 840d64dc-923c-4da7-0c2b-08d77e1fff31
x-ms-traffictypediagnostic: VI1PR04MB6864:|VI1PR04MB6864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6864EC617298EC2B5A998EC7EE5A0@VI1PR04MB6864.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(44832011)(45080400002)(54906003)(110136005)(316002)(86362001)(478600001)(66946007)(33656002)(7696005)(966005)(26005)(9686003)(6506007)(53546011)(186003)(55016002)(5660300002)(71200400001)(7416002)(81166006)(76116006)(91956017)(66446008)(64756008)(4326008)(66556008)(2906002)(66476007)(81156014)(8676002)(8936002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6864;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2yXplm93UfRqIqcCHApMKZoCm/jUgeYwElkqeojuYfpOxCjfWCWvB1mlWCEYrRrHdWBIgiiwTxlTvJ4wyyemb5M+bnB4Y/yfTau3BvLGhs4Ar2DatIIGqElduGweiFg71eE742RCm2FhFQ2kMfMTwGhcCLesmfPGolhMxrIcJEIOxW7NUaUlC54x14WYz/NLDbQjMaeubDz7baq0eG9OrjnnM9QnqUJRDOGetx2YqDAC6ZVZR33zpbIGOVd9icOIg4k/fdhiz132YAmMXmiNM1lWPr6nEcJBQF4kYmauQE7WbqdmQ21XBFmFg/Gjm0aKGXpLONbYAvLQCLX7g23ASxxdhDcZvy+xIRChBKo4V+M5k2DEwuwO4993HwCIVaSoDtzJHKGqEQ1em7I3JQKAc3Dx9iH5w1h6Gvd8e5JhPeNlbcwjUuU8I3HHyOjZThvgg0uql5DN6jkWJERWV2Ji5dz9BAzzuiY4kjfAzAHWu8=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840d64dc-923c-4da7-0c2b-08d77e1fff31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 09:53:38.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdBup5KUSv3i7n3pPnnGFzD4tR+qlRXAMgJNSL9UJCyfD40EeGaIMCOmAxR8qlp2BFZWWiHPq8OVJznVOPwWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14.11.2019 22:10, Leonard Crestez wrote:=0A=
> This series adds interconnect scaling support for imx8m series chips. It =
uses a=0A=
> per-SOC interconnect provider layered on top of multiple instances of dev=
freq=0A=
> for scalable nodes along the interconnect.=0A=
> =0A=
> Existing qcom interconnect providers mostly translate bandwidth requests =
into=0A=
> firmware calls but equivalent firmware on imx8m is much thinner. Scaling=
=0A=
> support for individual nodes is implemented as distinct devfreq drivers=
=0A=
> instead.=0A=
> =0A=
> The imx interconnect provider doesn't communicate with devfreq directly=
=0A=
> but rather computes "minimum frequencies" for nodes along the path and=0A=
> creates dev_pm_qos requests.=0A=
> =0A=
> Since there is no single devicetree node that can represent the=0A=
> "interconnect" the main NOC is picked as the "interconnect provider" and=
=0A=
> will probe the interconnect platform device if #interconnect-cells is=0A=
> present. This avoids introducing "virtual" devices but it means that DT=
=0A=
> bindings of main NOC includes properties for both devfreq and=0A=
> interconnect.=0A=
> =0A=
> This depends on other series for devfreq pm/qos and ddrc:=0A=
=0A=
It took a while but all runtime dependencies are included in =0A=
next-20191210 and the compile-time dependency on =0A=
DEV_PM_QOS_MIN_FREQUENCY is also included in v5.5-rc1. This series is a =0A=
bit old but still applies usefully so I thought I'd ask for additional =0A=
comments instead of a blank resend.=0A=
=0A=
Georgi: can you please take a look at this series and suggest what would =
=0A=
make it suitable for inclusion?=0A=
=0A=
Some dubious aspects:=0A=
=0A=
* Existing drivers have multiple providers per SOC (for each internal =0A=
NOC?) but this is a single driver for the entire SOC topology. Not clear =
=0A=
what would be gain from this.=0A=
* NOC DT node implements devfreq (because it can be scaled) and =0A=
interconnect (to avoid virtual DT nodes). Maybe the devfreq NOC scaling =0A=
implementation could be moved into drivers/interconnect/imx?=0A=
=0A=
It is quite different from qcom providers but hardware/firmware is also =0A=
very different.=0A=
=0A=
> Changes since RFCv5:=0A=
> * Replace scanning for interconnect-node-id with explicit=0A=
> scalable-nodes/scalable-node-ids property on NoC.=0A=
> * Now passes make `dtbs_check`=0A=
> * Remove struct imx_icc_provider=0A=
> * Switch to of_icc_xlate_onecell=0A=
> * Use of_find_device_by_node to fetch QoS target, this causes fewer probe=
=0A=
> deferrals, removes dependency on devfreq API and even allows reloading dd=
rc=0A=
> module at runtime=0A=
> * Add imx_icc_node_destroy helper=0A=
> * Remove 0/1 on DEFINE_BUS_SLAVE/MASTER which created spurious links=0A=
> Link: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fpatchwork.kernel.org%2Fcover%2F11222015%2F&amp;data=3D02%7C01%7Cleonard.cr=
estez%40nxp.com%7Cff0127cbde3e4e6f6c8508d7693eb8d5%7C686ea1d3bc2b4c6fa92cd9=
9c5c301635%7C0%7C0%7C637093590418229667&amp;sdata=3D0EN1w8RtXHgyvXpRnOovEkW=
ILoVlQ%2FEXJ0zdOOHI%2FgM%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since RFCv4:=0A=
> * Drop icc proxy nonsense=0A=
> * Make devfreq driver for NOC probe the ICC driver if=0A=
> #interconnect-cells is present=0A=
> * Move NOC support to interconnect series and rename the node in DT=0A=
> * Add support for all chips at once, differences are not intereseting=0A=
> and there is more community interest for 8mq than 8mm.=0A=
> Link: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fpatchwork.kernel.org%2Fcover%2F11111865%2F&amp;data=3D02%7C01%7Cleonard.cr=
estez%40nxp.com%7Cff0127cbde3e4e6f6c8508d7693eb8d5%7C686ea1d3bc2b4c6fa92cd9=
9c5c301635%7C0%7C0%7C637093590418229667&amp;sdata=3DbsJqXPVJSszKJf%2BXdqFT2=
E8wriuKQU00sWwkRqZYmn0%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since RFCv3:=0A=
> * Remove the virtual "icc" node and add devfreq nodes as proxy providers=
=0A=
> * Fix build on 32-bit arm (reported by kbuilt test robot)=0A=
> * Remove ARCH_MXC_ARM64 (never existed in upstream)=0A=
> * Remove _numlinks, calculate instead=0A=
> * Replace __BUSFREQ_H header guard=0A=
> * Improve commit message and comment spelling=0A=
> * Fix checkpatch issues=0A=
> Link to RFCv3: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11078671%2F&amp;data=3D02%7C01%7Cl=
eonard.crestez%40nxp.com%7Cff0127cbde3e4e6f6c8508d7693eb8d5%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C0%7C637093590418229667&amp;sdata=3Dc9xKEw9Fjlv%2F=
qDiWKr7zOUY5zZMWXjNyApBd94Nidnc%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since RFCv2 and initial work by Alexandre Bailon:=0A=
> * Relying on devfreq and dev_pm_qos instead of CLK=0A=
> * No more "platform opp" stuff=0A=
> * No more special suspend handling: use suspend-opp on devfreq instead=0A=
> * Replace all mentions of "busfreq" with "interconnect"=0A=
> Link to v2: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fcover%2F11021563%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Cff0127cbde3e4e6f6c8508d7693eb8d5%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637093590418229667&amp;sdata=3D1tEQS9BaHRTjdUYvZ=
J9%2FJG2BQQGl6hkbPWxiIZ811FY%3D&amp;reserved=3D0=0A=
> =0A=
> Leonard Crestez (9):=0A=
>    dt-bindings: interconnect: Add bindings for imx8m noc=0A=
>    PM / devfreq: Add generic imx bus scaling driver=0A=
>    PM / devfreq: imx: Register interconnect device=0A=
>    interconnect: Add imx core driver=0A=
>    interconnect: imx: Add platform driver for imx8mm=0A=
>    interconnect: imx: Add platform driver for imx8mq=0A=
>    interconnect: imx: Add platform driver for imx8mn=0A=
>    arm64: dts: imx8m: Add NOC nodes=0A=
>    arm64: dts: imx8m: Add interconnect provider properties=0A=
> =0A=
>   .../bindings/interconnect/fsl,imx8m-noc.yaml  | 104 ++++++=0A=
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  28 ++=0A=
>   arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  28 ++=0A=
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  28 ++=0A=
>   drivers/devfreq/Kconfig                       |   9 +=0A=
>   drivers/devfreq/Makefile                      |   1 +=0A=
>   drivers/devfreq/imx-devfreq.c                 | 187 +++++++++++=0A=
>   drivers/interconnect/Kconfig                  |   1 +=0A=
>   drivers/interconnect/Makefile                 |   1 +=0A=
>   drivers/interconnect/imx/Kconfig              |  17 +=0A=
>   drivers/interconnect/imx/Makefile             |   4 +=0A=
>   drivers/interconnect/imx/imx.c                | 301 ++++++++++++++++++=
=0A=
>   drivers/interconnect/imx/imx.h                |  60 ++++=0A=
>   drivers/interconnect/imx/imx8mm.c             | 105 ++++++=0A=
>   drivers/interconnect/imx/imx8mn.c             |  94 ++++++=0A=
>   drivers/interconnect/imx/imx8mq.c             | 103 ++++++=0A=
>   include/dt-bindings/interconnect/imx8mm.h     |  49 +++=0A=
>   include/dt-bindings/interconnect/imx8mn.h     |  41 +++=0A=
>   include/dt-bindings/interconnect/imx8mq.h     |  48 +++=0A=
>   19 files changed, 1209 insertions(+)=0A=
>   create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,i=
mx8m-noc.yaml=0A=
>   create mode 100644 drivers/devfreq/imx-devfreq.c=0A=
>   create mode 100644 drivers/interconnect/imx/Kconfig=0A=
>   create mode 100644 drivers/interconnect/imx/Makefile=0A=
>   create mode 100644 drivers/interconnect/imx/imx.c=0A=
>   create mode 100644 drivers/interconnect/imx/imx.h=0A=
>   create mode 100644 drivers/interconnect/imx/imx8mm.c=0A=
>   create mode 100644 drivers/interconnect/imx/imx8mn.c=0A=
>   create mode 100644 drivers/interconnect/imx/imx8mq.c=0A=
>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h=0A=
>   create mode 100644 include/dt-bindings/interconnect/imx8mn.h=0A=
>   create mode 100644 include/dt-bindings/interconnect/imx8mq.h=0A=
> =0A=
=0A=
=0A=
