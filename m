Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994B21264CD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLSOcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:32:04 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:13414
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbfLSOcE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 09:32:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb4DuD5iuEvrg48pmcMJFf+BEqFGJl/po9NILSCkvAyZ1JcVpo4SCOiR31TBMBBV6HBPLDOkiAgFnb86HItNygLebpNHkMtP0xsc6EHHm8fpKIun7xqgtU5HWLXxGMsNCJh/7L9HJwAJjNNAFwu1HTmw7AEziQQrq/eO0d3JPGJ0G05UqvxmCVdwlh6k1yu+0Sp6+KxyfPHOP5qC+OsW6/3mx6WGlBjrSTrkMuAwBK2KlQ49x03GJFY4Jv+gHjDHmR+TXYBXD8cVtlAjx/8wXOtx0ZDF70X+lGT5SSyEvUysWxBn8XiOg3CD19OPk1CCFsATRSjfmKhvlL3Ija+K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc1T/65v0qYnIC6SuRuQqjeRzDQjNcIK9gM0QwrdW44=;
 b=VSBHRA7kYRrSuZ8fl70xbsW41P5eKO+Jb+lC/vdKTiTD+EhJDM/fMMUMz8/6Jv/9Wm3t+TcWxUpSz3cTYyKBB83RJ6D0FtfKv+/wZWvWWUYCDd6kF/cs/WB87CjRkXGOq3eEPdSJJFoEXnMniWbdavdPqv05RSUWu6gexxlFfCqT0by2WESvhDlFF4JuiXULar0qDpeTwry/omnPglIR0HMLu1euTKjreaNRmKfeWlDoAfEtMKR3mMmInEKfAM0N6lu/tVbiJpCeCQeBc8ptc3Z/Zt93KcSVKqVa/fhmZJn+kabzdJuAZJdSRqGHl0uAUKvNN5f0slxEn9ukH6+e1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc1T/65v0qYnIC6SuRuQqjeRzDQjNcIK9gM0QwrdW44=;
 b=TpVVtdaBOwnAi1/pbGrcLGe30OiJHmCuHwLANKPM13mLOtboOUQFF4yEXwXXrhIPWDcF7Ht9gqubGttvGOwM2P2nU9Ok5mXZvegR3XoY/1ArujlDjEqHEmffbEUcdyzhP6Fa1qlP8qE0r5Jl5sj0g/jBObk6G7BdpiK5CnR8vUU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6304.eurprd04.prod.outlook.com (20.179.27.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 14:31:58 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 14:31:58 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
Thread-Topic: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
Thread-Index: AQHVmyeXQvJfRqjmjUWtYoVDBCNHfg==
Date:   Thu, 19 Dec 2019 14:31:57 +0000
Message-ID: <VI1PR04MB7023423D8D5D633074978430EE520@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d@epcas5p2.samsung.com>
 <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
 <c1c03b30-d82a-6f2b-156d-0e1948e0df5b@samsung.com>
 <afd618d6-d78c-a989-2d1e-60c368ec267f@samsung.com>
 <VI1PR04MB7023A61DD48302CF0E0B3B81EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <b8fc116f-d99f-37c6-ce07-aa0f844ac604@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09a745d7-76ee-4245-9999-08d784903432
x-ms-traffictypediagnostic: VI1PR04MB6304:|VI1PR04MB6304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6304986D49FCFB6E7FEEFB7FEE520@VI1PR04MB6304.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(199004)(189003)(51444003)(66556008)(86362001)(2906002)(966005)(9686003)(478600001)(45080400002)(71200400001)(7696005)(52536014)(76116006)(91956017)(64756008)(26005)(66476007)(53546011)(66946007)(6506007)(5660300002)(44832011)(316002)(54906003)(30864003)(66446008)(110136005)(33656002)(8936002)(4326008)(55016002)(186003)(8676002)(81166006)(81156014)(7416002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6304;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HAnrmU7BbOTzNrfK02UvmrqrVgmaUx5Db8ISjsm1i8b7DTLvpZz0Dzgt565nd6n9Bu2XBXFeXiOWuTqNgELAO+5cQ98NMAEC4plmvjUr9CqBQj8pGq8gUjR8zGD6godFwWA6GsoC7aEWnE8dBldmodkZLTfHj1kGO8yULYX+QGkYb/TO1S0IXb8zEhku3OSBfTMOPrgUQASD+M0ZimnUNf6/tSIgGTb5mWmayY1cu07bnRArXe57N2XjG9i6Fh20Cu2fzCA+tv1DaR+QMpqcXGWcmpVp72IuYyZCP+pE9NokYEl0+3kf5xjlAjayKCYt9qO2dwyq95SeOj5lgp1aW9M6LX/j5DeQjOCzToeUcqWpEY2i3onFu/GnM8lwJKGoeoFwy1vILCQMTZdE2J9gmd3PlQzMNM+ofTp7BG92A9xcw+GiUeHeWVk7vr+MPJVUrQjMB3vTlVVpC10L8Eq+vBObgcEX68QGKEOFVF9FA4ZdIMwtBsryTYjuXrHc8UOvg9sxsfDbzt0dojmILSC25AvCV5jmBIezClCRRmPRGTbyT18DKTUGv3x/t90NJxD3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a745d7-76ee-4245-9999-08d784903432
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 14:31:57.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+jAanrU/4ZgVoAXdDEkX0XH74qv5dvD29rYFFVg9cenK+S9vQvn5UvEm6FN26lrEd5l+ItdJzDn5InYtTQOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6304
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17.12.2019 02:08, Chanwoo Choi wrote:=0A=
> On 12/17/19 12:09 AM, Leonard Crestez wrote:=0A=
>> On 16.12.2019 05:18, Chanwoo Choi wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On 12/16/19 10:12 AM, Chanwoo Choi wrote:=0A=
>>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:=0A=
>>>>> Add initial dt bindings for the interconnects inside i.MX chips.=0A=
>>>>> Multiple external IPs are involved but SOC integration means the=0A=
>>>>> software controllable interfaces are very similar.=0A=
>>>>>=0A=
>>>>> Main NOC node acts as interconnect provider if #interconnect-cells is=
=0A=
>>>>> present.=0A=
>>>>>=0A=
>>>>> Multiple interconnects can be present, each with their own OPP table.=
=0A=
>>>>>=0A=
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>>> ---=0A=
>>>>>    .../bindings/interconnect/fsl,imx8m-noc.yaml  | 104 ++++++++++++++=
++++=0A=
>>>>>    1 file changed, 104 insertions(+)=0A=
>>>>>    create mode 100644 Documentation/devicetree/bindings/interconnect/=
fsl,imx8m-noc.yaml=0A=
>>>>>=0A=
>>>>> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m=
-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.ya=
ml=0A=
>>>>> new file mode 100644=0A=
>>>>> index 000000000000..5cd94185fec3=0A=
>>>>> --- /dev/null=0A=
>>>>> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.ya=
ml=0A=
>>>>> @@ -0,0 +1,104 @@=0A=
>>>>> +# SPDX-License-Identifier: GPL-2.0=0A=
>>>>> +%YAML 1.2=0A=
>>>>> +---=0A=
>>>>> +$id: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fprotect2.fireeye.com%2Furl%3Fk%3D8570eb5a-d8a45732-85716015-0cc47a3356=
b2-92a5b92cc514d07e%26u%3Dhttps%3A%2F%2Feur01.safelinks.protection.outlook.=
com%2F%3Furl%3Dhttps%253A%252F%252Fprotect2.fireeye.com%252Furl%253Fk%253D0=
c13f3e0-51df3f45-0c1278af-0cc47a30d446-77e809543b673ffd%2526u%253Dhttp%253A=
%252F%252Fdevicetree.org%252Fschemas%252Finterconnect%252Ffsl%252Cimx8m-noc=
.yaml%2523%26amp%3Bdata%3D02%257C01%257Cleonard.crestez%2540nxp.com%257C2d1=
f1868afa140702a6b08d781d6ab68%257C686ea1d3bc2b4c6fa92cd99c5c301635%257C0%25=
7C0%257C637120631307418544%26amp%3Bsdata%3DH2q5nQlKYyLIivkBYUTaRD1Nu3WcnphP=
Jny3k%252BK%252BGFE%253D%26amp%3Breserved%3D0&amp;data=3D02%7C01%7Cleonard.=
crestez%40nxp.com%7C769d8e354f3b4d00b84508d782854a17%7C686ea1d3bc2b4c6fa92c=
d99c5c301635%7C0%7C0%7C637121381290437871&amp;sdata=3DHYMJJHWyiKRhf7GDjKoOw=
jDpcZuYqlFlmRrDZnIRx5w%3D&amp;reserved=3D0=0A=
>>>>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fprotect2.fireeye.com%2Furl%3Fk%3Df7cec483-aa1a78eb-f7cf4fcc-0cc47a=
3356b2-4154a3c43886f5ed%26u%3Dhttps%3A%2F%2Feur01.safelinks.protection.outl=
ook.com%2F%3Furl%3Dhttps%253A%252F%252Fprotect2.fireeye.com%252Furl%253Fk%2=
53D87c672dc-da0abe79-87c7f993-0cc47a30d446-414d3b4d0127419a%2526u%253Dhttp%=
253A%252F%252Fdevicetree.org%252Fmeta-schemas%252Fcore.yaml%2523%26amp%3Bda=
ta%3D02%257C01%257Cleonard.crestez%2540nxp.com%257C2d1f1868afa140702a6b08d7=
81d6ab68%257C686ea1d3bc2b4c6fa92cd99c5c301635%257C0%257C0%257C6371206313074=
18544%26amp%3Bsdata%3DT6PgQ1DWI4OLOx3gifRRt%252FNImdVrgDUoswZ%252FNKw3oR8%2=
53D%26amp%3Breserved%3D0&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C7=
69d8e354f3b4d00b84508d782854a17%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%=
7C637121381290437871&amp;sdata=3DfIbrUUOUtZ5nt%2FH1tm3dzaI1J%2FGn5Gc54ms93H=
nBnQg%3D&amp;reserved=3D0=0A=
>>>>> +=0A=
>>>>> +title: Generic i.MX bus frequency device=0A=
>>>>> +=0A=
>>>>> +maintainers:=0A=
>>>>> +  - Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>>> +=0A=
>>>>> +description: |=0A=
>>>>> +  The i.MX SoC family has multiple buses for which clock frequency (=
and=0A=
>>>>> +  sometimes voltage) can be adjusted.=0A=
>>>>> +=0A=
>>>>> +  Some of those buses expose register areas mentioned in the memory =
maps as GPV=0A=
>>>>> +  ("Global Programmers View") but not all. Access to this area might=
 be denied=0A=
>>>>> +  for normal (non-secure) world.=0A=
>>>>> +=0A=
>>>>> +  The buses are based on externally licensed IPs such as ARM NIC-301=
 and=0A=
>>>>> +  Arteris FlexNOC but DT bindings are specific to the integration of=
 these bus=0A=
>>>>> +  interconnect IPs into imx SOCs.=0A=
>>>>> +=0A=
>>>>> +properties:=0A=
>>>>> +  compatible:=0A=
>>>>> +    oneOf:=0A=
>>>>> +      - items:=0A=
>>>>> +        - enum:=0A=
>>>>> +          - fsl,imx8mn-nic=0A=
>>>>> +          - fsl,imx8mm-nic=0A=
>>>>> +          - fsl,imx8mq-nic=0A=
>>>>> +        - const: fsl,imx8m-nic=0A=
>>>>> +      - items:=0A=
>>>>> +        - enum:=0A=
>>>>> +          - fsl,imx8mn-noc=0A=
>>>>> +          - fsl,imx8mm-noc=0A=
>>>>> +          - fsl,imx8mq-noc=0A=
>>>>> +        - const: fsl,imx8m-noc=0A=
>>>>> +=0A=
>>>>> +  reg:=0A=
>>>>> +    maxItems: 1=0A=
>>>>> +=0A=
>>>>> +  clocks:=0A=
>>>>> +    maxItems: 1=0A=
>>>>> +=0A=
>>>>> +  operating-points-v2: true=0A=
>>>>> +  opp-table: true=0A=
>>>>> +=0A=
>>>>> +  devfreq:=0A=
>>>>> +    $ref: "/schemas/types.yaml#/definitions/phandle"=0A=
>>>>> +    description:=0A=
>>>>> +      Phandle to another devfreq device to match OPPs with by using =
the=0A=
>>>>=0A=
>>>> Better to use 'parent' instead of 'another' word for improving the und=
erstanding.=0A=
>>>=0A=
>>> I think that 'devfreq' is not proper way to get the parent node=0A=
>>> in devicetree. Because 'devfreq' name is linuxium. The property name=0A=
>>> didn't indicate the any h/w device. So, I'll make 'devfreq' property de=
precated.=0A=
>>>=0A=
>>> So, you better to make the specific property for this device driver=0A=
>>> like as following: and use devfreq_get_devfreq_by_node() function=0A=
>>> which is developed by you in order to get the devfreq instance node.=0A=
>>>=0A=
>>> 	fsl,parent-device =3D <&parent devfreq device>;=0A=
>>=0A=
>> This is only a "parent" in the sense that it's assigned to=0A=
>> devfreq_passive.data.parent. The "devfreq" name is indeed too generic.=
=0A=
> =0A=
> I thought that 'devfreq' property name is generic.=0A=
> But, it's not proper for DT binding because DT file show=0A=
> the h/w and the relation of h/w. 'devfreq' property name=0A=
> has not meant h/w.=0A=
> =0A=
> So that devfreq core doesn't force to use the specific property=0A=
> name to get the devfreq parent instance on DT. Just, devfreq core=0A=
> will provide devfreq_get_devfreq_by_node() function.=0A=
> =0A=
> I developed it on devfre-testing branch[2]. Before I'm sending=0A=
> the these patches, you can check them.=0A=
> =0A=
> [1] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fchanwoo%2Flinux.git%2Fco=
mmit%2F%3Fh%3Ddevfreq-testing%26id%3Df3678b4e6b75dccfe8bb87d005da2d68c70fde=
ab&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C769d8e354f3b4d00b84508d=
782854a17%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637121381290437871&a=
mp;sdata=3DR21Tv1QgofBvMYb2VaxFjKSerwQ3tl8kakcYRyALmgM%3D&amp;reserved=3D0=
=0A=
> [2] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fchanwoo%2Flinux.git%2Flo=
g%2F%3Fh%3Ddevfreq-testing&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7=
C769d8e354f3b4d00b84508d782854a17%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C=
0%7C637121381290437871&amp;sdata=3DuH0d9LvrbCHgZJdrPJNJ8c8w45J7x1QyM7t5I3j%=
2BpSw%3D&amp;reserved=3D0=0A=
> =0A=
>>=0A=
>> The DDRC can measure bandwith usage and I want to use the passive=0A=
>> governor to make the main NOC match OPPs.=0A=
> =0A=
> which one use the passive governor? And which one is the parent=0A=
> devfreq device for devfreq device using passive governor?=0A=
> =0A=
> In my case, it is difficult to catch the relationship=0A=
> between devices. I'd like you to explain the detailed relationship=0A=
> on binding document for user.=0A=
> =0A=
>> But at the bus level DDRC only has AXI and APB slave ports.=0A=
> =0A=
> 'DDRC' indicates the 'drivers/devfreq/imx8m-ddrc.c?=0A=
> =0A=
>>=0A=
>> Buses on imx don't have a parent/child relationship; in fact there are=
=0A=
>> even a few cycles.=0A=
> =0A=
> You mentioned that 'imx don't have a parent/child relationship',=0A=
> Why do you use 'passive' governor? It is difficult to understand=0A=
> the hierarchy of imx.=0A=
=0A=
The imx8m has a main NOC in the center between the CPU and the DDRC =0A=
(dram controller) with many other peripheral buses around the NOC.=0A=
=0A=
Here's /sys/kernel/debug/interconnect/interconnect_graph on imx8mm:=0A=
https://gist.github.com/cdleonard/84d103dafc9131fcb8ca9a494822a131#file-imx=
8mm-svg=0A=
=0A=
A lot of stuff is omitted, it mostly just includes high-performance bus =0A=
masters.=0A=
=0A=
DDRC has a performance monitor attached which can measure current =0A=
bandwith and feed it to an ondemand governor. I want to use passive =0A=
governor on the NOC so that it matches frequencies with DDRC and scales =0A=
proportionally, otherwise if NOC is at low frequency then dynamically =0A=
scaling up the DDRC might be ineffective.=0A=
=0A=
Perhaps you could explain how parent/child relationships work on exynos?=0A=
=0A=
>>> [1] [PATCH RFC v5 04/10] PM / devfreq: Add devfreq_get_devfreq_by_node=
=0A=
>>>=0A=
>>>>=0A=
>>>>> +      passive governor.=0A=
>>>>> +=0A=
>>>>> +  '#interconnect-cells':=0A=
>>>>> +    description:=0A=
>>>>> +      If specified then also act as an interconnect provider. Should=
 only be=0A=
>>>>> +      set once per soc on main noc.=0A=
>>>>> +    const: 1=0A=
>>>>> +=0A=
>>>>> +  fsl,scalable-node-ids:=0A=
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array=0A=
>>>>> +    description:=0A=
>>>>> +      Array of node ids for scalable nodes. Uses same numeric identi=
fier=0A=
>>>>> +      namespace as the consumer "interconnects" binding.=0A=
>>>>> +=0A=
>>>>> +  fsl,scalable-nodes:=0A=
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array=0A=
>>>>> +    description:=0A=
>>>>> +      Array of phandles to scalable nodes. Must be of same length as=
=0A=
>>>>> +      fsl,scalable-node-ids.=0A=
>>>>> +=0A=
>>>>> +required:=0A=
>>>>> +  - compatible=0A=
>>>>> +  - clocks=0A=
>>>>> +=0A=
>>>>> +additionalProperties: false=0A=
>>>>> +=0A=
>>>>> +examples:=0A=
>>>>> +  - |=0A=
>>>>=0A=
>>>> Is it enough example to understand the relation between=0A=
>>>> imx8m-ddrc.c, imx-devfreq.c and imx interconnect driver?=0A=
>>>>=0A=
>>>> In my case, if possible, hope to show the more detailed=0A=
>>>> example. This example seems that don't contain the ddrc=0A=
>>>> dt node (imx8m-ddrc.c).=0A=
>>=0A=
>> OK, I'll elaborate explanation on noc binding.=0A=
> =0A=
> Thanks. If possible, you better to add almost example cases.=0A=
> =0A=
>>=0A=
>>>>=0A=
>>>>> +    #include <dt-bindings/clock/imx8mq-clock.h>=0A=
>>>>> +    #include <dt-bindings/interconnect/imx8mq.h>=0A=
>>>>> +    noc: interconnect@32700000 {=0A=
>>>>> +            compatible =3D "fsl,imx8mq-noc", "fsl,imx8m-noc";=0A=
>>>>> +            reg =3D <0x32700000 0x100000>;=0A=
>>>>> +            clocks =3D <&clk IMX8MQ_CLK_NOC>;=0A=
>>>>> +            #interconnect-cells =3D <1>;=0A=
>>>>> +            fsl,scalable-node-ids =3D <IMX8MQ_ICN_NOC>,=0A=
>>>>> +                                    <IMX8MQ_ICS_DRAM>;=0A=
>>>>> +            fsl,scalable-nodes =3D <&noc>,=0A=
>>>>> +                                 <&ddrc>;=0A=
>>>>> +            operating-points-v2 =3D <&noc_opp_table>;=0A=
>>>>> +=0A=
>>>>> +            noc_opp_table: opp-table {=0A=
>>>>> +                    compatible =3D "operating-points-v2";=0A=
>>>>> +=0A=
>>>>> +                    opp-133M {=0A=
>>>>> +                            opp-hz =3D /bits/ 64 <133333333>;=0A=
>>>>> +                    };=0A=
>>>>> +                    opp-800M {=0A=
>>>>> +                            opp-hz =3D /bits/ 64 <800000000>;=0A=
>>>>> +                    };=0A=
>>>>> +            };=0A=
>>>>> +    };=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
