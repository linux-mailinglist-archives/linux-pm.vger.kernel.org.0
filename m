Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3CE1A09C9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 11:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgDGJLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 05:11:11 -0400
Received: from mail-vi1eur05on2051.outbound.protection.outlook.com ([40.107.21.51]:24653
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbgDGJLL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Apr 2020 05:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIAGM21XwbpsZATPe4BeDEgZo+pBkPoDCJBtQjCUMWeRKA6ozjzwVnnQn5Y5u2OEal0hhdWLi2BzQqidWO1fHhZgs7SGuuD4fqIrtel9Mcv4nEvg7FBr3/WxUXAzxlXB3v8BRF4bYAFqeUa52iTX/ig4iGSA/dbsh/K9bypsTx+HcvULVmyq5ue/vHnHUvUp1m6Qv5xWviiO1Mmi2a2cuBJB8ThEJPHWF5p1pJehkiLT9HzcNIkzCqNGoxFat6MNdXMfvr1lJayY29wkYIbxqXymBjnYSt8DyLldqnSgk9wxwsFV2/K5mjvAcYlQSAun2dwYQUlBMDRC/hGCmp7jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rBKPniWx+ylQ54Xkc1Drcnv51MYQVgQ/kEfF8Ifuhk=;
 b=NMskiodPJsmRl436JkSXgaTzA4Y1+HL3CysVpbOZC1Y/T0H6rJIl/MqN7gWvL2dQTFi2PXRmHaeJGMKUfXl4B64c2yI6NnKomVHONdF/iC9Rg66S+1KNLcV0zxlyImyAu5FiG6nMEQO867qwG5GV4EyFPJsqi2rsWTM8a5qt1h8JjVVaUenEe497/6G2bczJ0B8gvBTdoVv0frqqa/5I6xxMrmwMbYuspDVhwt5+Yi3IXVSnizP/0Y+WuWte0cat7Vf4UBd4dy13oYx2HHLxBKfbMjv5mMcTvS+fvj8vGz1LaROsbqbekZrPnFneX6Ky66G32d+8fCXsXWnyGj9JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rBKPniWx+ylQ54Xkc1Drcnv51MYQVgQ/kEfF8Ifuhk=;
 b=AjhSBOJvEpHMnzImjWDJTePqN2nb7sx++6u4ZAr0OLdCsS0ptfTP2ZyrNsDtOqwm7R2UZF5GKYsf702+HWBwfjBFkA8MNGGR+n+Tp/XhKN8TCf10f0DU9aWu6qt9Hh6ZFw2lSycoaSDVLTBUNPLh38YpMUckX08dNpTyFBGTO2s=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB6095.eurprd04.prod.outlook.com (2603:10a6:803:f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Tue, 7 Apr
 2020 09:10:29 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2878.016; Tue, 7 Apr 2020
 09:10:29 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Adam Ford <aford173@gmail.com>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 8/8] arm64: dts: imx8m: Add NOC nodes
Thread-Topic: [PATCH v2 8/8] arm64: dts: imx8m: Add NOC nodes
Thread-Index: AQHWCDKCwo8em7bdXUyT4tjIdLJwuQ==
Date:   Tue, 7 Apr 2020 09:10:29 +0000
Message-ID: <VI1PR04MB69417FFDFF452FC46889B686EEC30@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
 <c167baa48d6830cf32b9ac51968eeadd684ebf2d.1585751281.git.leonard.crestez@nxp.com>
 <CAHCN7xKpwex8MQbTFAYKjGPQbQ1uOe7EywASmcakg8F_2w-iuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e7681b7-d762-4354-17ec-08d7dad384dc
x-ms-traffictypediagnostic: VI1PR04MB6095:|VI1PR04MB6095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6095F346EEF0D3DF7A6FAE11EEC30@VI1PR04MB6095.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(81156014)(81166006)(7416002)(2906002)(6506007)(7696005)(55016002)(8676002)(26005)(316002)(53546011)(9686003)(91956017)(86362001)(76116006)(66946007)(186003)(54906003)(44832011)(66556008)(66476007)(66446008)(33656002)(5660300002)(478600001)(64756008)(52536014)(71200400001)(6916009)(8936002)(4326008)(45080400002)(966005)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgW7M1Q/JOT+0LVMZ1BqywpQjqdJbVAZKmLlOrAnD1+DvFwgYjKOfjYxPWiH7rxTXdiKqkJ8iSv1h2yrwoZ+9PG810Fz0qd+D8dfcVSaEc1r+o9UJ3YZxN1CV+1PuihYV8ZrS2LFpdMamizwUEcxT/nD9429WlEginkXTD/7o6drEZwA/H4eyZsI8xcdrmMecu/P3BDxfQB1c1iWuflfqMPOhgSCdN7JnEADtqlnK8/6a6L8mLuPCcIpNG3rPm2gOMTeu0/divyBfBrA0nts0YYikWaVAyYFHnnHcZpAIGkPt1FRZ6aMJMoNWwOFYvNInCJ4eYputI9LjIZZusLjGPlmhJvRZ4dA0E5ftcvaExlymVJzOYPjFi07Ahbff84w5dpuoiAUrG5KfS8BqKmq3O5k51aNiW3FtqViWEtpuWvZVEnbrxSSKFkknwdgjUZbc/A+w63PGj24KafY9vDbEesovEREEnHN5Z9S8hrCy5I7ojPCq2Qmlx5sM6vgiFnsYhx06TYmMP+3GDz2fTeL3ax+K4lffzShl3o6nRgN5XSjQg/7ct5qYold4DKSD/4v
x-ms-exchange-antispam-messagedata: zbShVds7BkhxoLZsJpRct38cmVN7ZTje5f4fvrPUVQOsCIF/NIQBe6PK5Rhatd8o5N0E6Wv1kDNiy/DfeOFz/doyTQsfr0wOkg9LMmaob22R156PykgifSSffeqD8ERJCGO4byN5jwC9eaGG1EX2qg==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7681b7-d762-4354-17ec-08d7dad384dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 09:10:29.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAjxY31OtrgFtr+Y99uuHs0HdMLuVUfCX7GrD1rTyGt5VHk3uYnPhVHUyR+R/0rbiYVNtZMFqV/uN4GnMetChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6095
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-04 4:25 PM, Adam Ford wrote:=0A=
> On Wed, Apr 1, 2020 at 9:35 AM Leonard Crestez <leonard.crestez@nxp.com> =
wrote:=0A=
>>=0A=
>> Add nodes for the main interconnect of the imx8m series chips.=0A=
>>=0A=
>> These nodes are bound to by devfreq and interconnect drivers.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++++=
=0A=
>>   arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++++=
=0A=
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++=
=0A=
>>   3 files changed, 72 insertions(+)=0A=
>>=0A=
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot=
/dts/freescale/imx8mm.dtsi=0A=
>> index 175c28ae10cf..41047b6709b6 100644=0A=
>> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi=0A=
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi=0A=
>> @@ -6,10 +6,11 @@=0A=
>>   #include <dt-bindings/clock/imx8mm-clock.h>=0A=
>>   #include <dt-bindings/gpio/gpio.h>=0A=
>>   #include <dt-bindings/input/input.h>=0A=
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>=0A=
>>   #include <dt-bindings/thermal/thermal.h>=0A=
>> +#include <dt-bindings/interconnect/imx8mm.h>=0A=
>>=0A=
>>   #include "imx8mm-pinfunc.h"=0A=
>>=0A=
>>   / {=0A=
>>          interrupt-parent =3D <&gic>;=0A=
>> @@ -860,10 +861,33 @@=0A=
>>                                  status =3D "disabled";=0A=
>>                          };=0A=
>>=0A=
>>                  };=0A=
>>=0A=
>> +               noc: interconnect@32700000 {=0A=
>> +                       compatible =3D "fsl,imx8mm-noc", "fsl,imx8m-noc"=
;=0A=
>> +                       reg =3D <0x32700000 0x100000>;=0A=
>> +                       clocks =3D <&clk IMX8MM_CLK_NOC>;=0A=
>> +                       fsl,ddrc =3D <&ddrc>;=0A=
>> +                       #interconnect-cells =3D <1>;=0A=
>> +                       operating-points-v2 =3D <&noc_opp_table>;=0A=
>> +=0A=
>> +                       noc_opp_table: opp-table {=0A=
>> +                               compatible =3D "operating-points-v2";=0A=
>> +=0A=
>> +                               opp-150M {=0A=
>> +                                       opp-hz =3D /bits/ 64 <150000000>=
;=0A=
>> +                               };=0A=
>> +                               opp-375M {=0A=
>> +                                       opp-hz =3D /bits/ 64 <375000000>=
;=0A=
>> +                               };=0A=
>> +                               opp-750M {=0A=
>> +                                       opp-hz =3D /bits/ 64 <750000000>=
;=0A=
> =0A=
> Out of curiosity, the 8M Mini runs up to 750M, and  the 8M Nano and=0A=
> 8MQ run up to 800.  The 8MQ had a patch to increase the assigned clock=0A=
> speed for the NOC to 800MHz=0A=
> =0A=
> See: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
git.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git%2=
Fpatch%2Farch%2Farm64%2Fboot%2Fdts%2Ffreescale%3Fid%3D912b9dacf3f0ffad55e1a=
1b3c5af0e433ebdb5dd&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C32c365=
5718e4459028e008d7d89baa31%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637=
216035403876452&amp;sdata=3Dz%2B5afsPGbCk4HkRp4nR6QepOrm70Fi5B5dohyvaquxo%3=
D&amp;reserved=3D0)=0A=
> =0A=
> The 8M Mini and 8M Nano appear to be setting the default speed to 0.=0A=
=0A=
I'm not sure what you mean about this, the noc clock is required for =0A=
mostly everything.=0A=
=0A=
> Should the 8M Mini or 8M Nano do something similar to what the 8MQ=0A=
> did, or does this series negate the need for such a patch?=0A=
=0A=
Instead of doing assigned-clocks noc frequency needs to be tweaked by =0A=
adjusting OPPs in this list. The devfreq device for noc will overwrite =0A=
other frequencies set for the noc.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
