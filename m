Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB98198BC6
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 07:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgCaFjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 01:39:23 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:6262
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgCaFjX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Mar 2020 01:39:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgQXf2Fl25ycUj4nRg2/WInfEJesYqGFqNjtmjM3gZThy98izNXeKXjuOsZ0mPSAkvdLQzl4aR3xZ/pQekEK06zbNJ+T5JAVZXSy7+Z7y/xku4MAuM16UdoYxXASOb/jEFevCAqCIakhDcAWGRKIjBh0q+4iQTp9ZQc/ddDQDXxpb9FxbaM12wBLUkRBAPffMnY+oU/a22lw8Vq2OkSJfJa/haycBRacXKVE6NJZDZ9R6xii8wz6K+227LbEFhMBEsmV2NQKletLFue3puOr6t+KRWi4g5/TEgVIehbMRS/dpyeXw6q4zvG5mFcK2CTvvXGuCmQ2YVmrqn3u368sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFIFwMhLWlC+3K0tL+1qnejOjC0Wfl42hoGUb6LJ5E0=;
 b=mp3sNcWnf+3PfHp7D6s0W6SBv3vNObTZJC6VVa6TzI/gu99iWAvn+yxGF6Zi2dRxgMyvKTMoXjuVBnExk3wxFCobYei+PJZ6CajC1tPikPV+vnh9ildHACCeQWcMZHsO2YIoCc8IMsqB+ssUdyHDW80Csp0L2qre/O25xvah8MX+6dpw2pbAwvCe/yuVC9C8etIvHNg6akl6FuZlzUMtADSQ19iRRkcvFS0mMeV6l6g4ZRfURhKi7SD/QYSJUPO+7PXSLMKocUbpzTvxZUBqfD2HzpHhmnfoF7eZlt0Y0alXqJA/bXdq4dv8hU7F53i6cxbk+kId2H0hNl6vjMl9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFIFwMhLWlC+3K0tL+1qnejOjC0Wfl42hoGUb6LJ5E0=;
 b=RecqDkoS5u/Jg3atIKofAjJ0ujYViqgHjQzqqX1/Ygc/GTJSjqe6JCikLu2ZWSrlrl92uOVLUBuNLZx1cmGtNCLSlOb5aP4zbDnwx+utestgV9/aytebH642MJnAoNrYc39ZFtKuWGf5+Z9mG3krrVphzeKR0SXrWk2MLo7zhxE=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB6206.eurprd04.prod.outlook.com (20.179.26.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 05:39:16 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 05:39:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        =?iso-8859-2?Q?Guido_G=FCnther?= <agx@sigxcpu.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: Re: [PATCH 0/8] interconnect: Add imx support via devfreq
Thread-Topic: [PATCH 0/8] interconnect: Add imx support via devfreq
Thread-Index: AQHWAxSOJJ3Vtmx7MEGSdS7BbhbpUw==
Date:   Tue, 31 Mar 2020 05:39:16 +0000
Message-ID: <VI1PR04MB69417C069AEE65B1195C100FEEC80@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
 <1ae21355-df95-44e5-b8f6-14af7aa4fcc3@posteo.de>
 <20200327113646.GA93181@bogon.m.sigxcpu.org>
 <9a84e745-3560-cb8a-4b1a-139b914c5a95@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c923362-c724-42e6-66cf-08d7d535da21
x-ms-traffictypediagnostic: VI1PR04MB6206:|VI1PR04MB6206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6206369E87691389DF070BCFEEC80@VI1PR04MB6206.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66574012)(5660300002)(53546011)(71200400001)(478600001)(966005)(7696005)(33656002)(110136005)(55016002)(186003)(45080400002)(4326008)(26005)(54906003)(9686003)(316002)(66446008)(66556008)(76116006)(66476007)(64756008)(6506007)(8676002)(8936002)(52536014)(7416002)(2906002)(86362001)(66946007)(81166006)(81156014)(44832011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jhh5w/FRKbU8XK/lg02+DKWhGF4bscojjOp1220uOqefObUGj9X90fF5slQFQ4cApYFrGnmhCzcbTIKHAzXxzYBSDXsFCWgQnVrIY33PH2zrCxU17uRurAVS5doBy4WjVcr1TrnjYxh0OE5OEd9NVBDu7vF/UMgRT67bUd549aUSUF9y50t+wkcQ9T6pbP0T3gmvbcLd7KBn9fE3OO2uMGERhHJer+KJd3yXMZfNtAsO+OGY3ENqH9x64k3hvyocoR3/S4QsdNbE9dRi7YjU7LmZZAHW7b7Re+rBFfNMMPWAL99ZwR9IVgO+wZCOqBZyFb1G6dGd2WHRydzS2uChr7qdyhoN2StcMoP0PUlXX91Ms6w4gS9uqNDof/ebT8DCRIurlQGutxON0jvwTm2qJq5dWpVguBNWLfiLz8ScmCXaRwSRQyD2HlDUjv519rUb4nuh3b9cUVGP+Ku2LspiHsv/EhCzfdWsdY5hqFE+lzpRr2i5IxTk2CTuTJcXHD14tia/ODltk7pkLB52ERQmsg==
x-ms-exchange-antispam-messagedata: 1sLAvyLVfnmVcn4o8e5UoIWPxEwQi6PgQ1zqzp/f3OE6VvTC1WtGQbC/lZryO4Dx3zXnhXdO+rlKnexEBfZ1j2cbe3CuHbbNcStKIx0JKXk57I86zvn4Z3K7gJwx1dJugZja0lcXKCP6L/MU+dxzMA==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c923362-c724-42e6-66cf-08d7d535da21
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 05:39:16.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS5sMP1SY+y5kQbpCm+q5g0XibdCmff3ltuEO7qGe9sAH+ff9GXUtcuSLnQAdnVYRXyytSWumXj+mTskavQOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6206
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-30 11:52 AM, Martin Kepplinger wrote:=0A=
> On 27.03.20 12:36, Guido G=FCnther wrote:=0A=
>> Hi Martin,=0A=
>> On Thu, Mar 26, 2020 at 02:55:27PM +0100, Martin Kepplinger wrote:=0A=
>>> On 26.03.20 03:16, Leonard Crestez wrote:=0A=
>>>> This series adds interconnect scaling support for imx8m series chips. =
It uses a=0A=
>>>> per-SOC interconnect provider layered on top of multiple instances of =
devfreq=0A=
>>>> for scalable nodes along the interconnect.=0A=
>>>>=0A=
>>>> Existing qcom interconnect providers mostly translate bandwidth reques=
ts into=0A=
>>>> firmware calls but equivalent firmware on imx8m is much thinner. Scali=
ng=0A=
>>>> support for individual nodes is implemented as distinct devfreq driver=
s=0A=
>>>> instead.=0A=
>>>>=0A=
>>>> The imx interconnect provider doesn't communicate with devfreq directl=
y=0A=
>>>> but rather computes "minimum frequencies" for nodes along the path and=
=0A=
>>>> creates dev_pm_qos requests.=0A=
>>>>=0A=
>>>> Since there is no single devicetree node that can represent the=0A=
>>>> "interconnect" the main NOC is picked as the "interconnect provider" a=
nd=0A=
>>>> will probe the interconnect platform device if #interconnect-cells is=
=0A=
>>>> present. This avoids introducing "virtual" devices but it means that D=
T=0A=
>>>> bindings of main NOC includes properties for both devfreq and=0A=
>>>> interconnect.=0A=
>>>>=0A=
>>>> Only the ddrc and main noc are scalable right now but more can be adde=
d.=0A=
>>>>=0A=
>>>> Also available on a github branch (with various unrelated changes):=0A=
>>>> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fcdleonard%2Flinux%2Ftree%2Fnext&amp;data=3D02%7C01%7Cleonard.cr=
estez%40nxp.com%7C52eb55181dce469eb85608d7d487bb93%7C686ea1d3bc2b4c6fa92cd9=
9c5c301635%7C0%7C0%7C637211551737394247&amp;sdata=3DA0l5FBF%2BT3k7H5HMtRMfX=
8WfVSqQm9jijgr8aexCoUA%3D&amp;reserved=3D0=0A=
>>>> Testing currently requires NXP branch of atf+uboot=0A=
>>>>=0A=
>>>> Martin: I believe you should be able to use this to control DRAM=0A=
>>>> frequency from video by just adding interconnect consumer code to=0A=
>>>> nwl-dsi. Sample code:=0A=
>>>> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fcdleonard%2Flinux%2Fcommit%2F43772762aa5045f1ce5623740f9a4baef9=
88d083&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C52eb55181dce469eb85=
608d7d487bb93%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6372115517373942=
47&amp;sdata=3D%2B%2BGWQTaQLLk98yFRHJ0o3Sks9DHGuKv7twBvn89f1Tg%3D&amp;reser=
ved=3D0=0A=
>>>> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fcdleonard%2Flinux%2Fcommit%2F7b601e981b1f517b5d98b43bde292972de=
d13086&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C52eb55181dce469eb85=
608d7d487bb93%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6372115517373942=
47&amp;sdata=3DJy2%2FI3CE1H3ilmLvZAVhjlPHO3KRNK6%2F9dX%2BS124ROA%3D&amp;res=
erved=3D0=0A=
>>>>=0A=
>>>=0A=
>>> Thanks for updating this series Leonard! A few questions for my=0A=
>>> understanding before trying to test:=0A=
>>>=0A=
>>> Isn't the ddrc_opp_table missing in these additions to the DT? That's=
=0A=
>>> what I want to scale after all.=0A=
DDRC OPP table belongs in board file because it can vary with RAM type =0A=
on boards.=0A=
=0A=
>>> If I want to keep calling the "request", now icc_set_bw(), in nwl-dsi:=
=0A=
>>> I'd add an "interconnects" property to the node, but what would be my=
=0A=
>>> interconnect master? i.e.: interconnects =3D <&noc master? &noc=0A=
>>> IMX8MQ_ICS_DRAM>; At least it's not obvious to me from=0A=
>>> interconnect/imx/imx8mq.c=0A=
>>=0A=
>> The NWL DSI host controller is fed by DCSS or mxsfb so any bandwidth=0A=
>> requirements should (as far as I understand things) go into the display=
=0A=
>> controller driver since that's what fetches from RAM.=0A=
>> Cheers,=0A=
>>   -- Guido=0A=
=0A=
This is correct.=0A=
=0A=
> Thanks a lot Leonard and Guido! Here's the tree I'm running, which is=0A=
> your patches based on Linus' tree, with icc request in mxsfb:=0A=
> =0A=
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc=
e.puri.sm%2Fmartin.kepplinger%2Flinux-next%2Fcommits%2F5.6-rc7%2Flibrem5__i=
ntegration_devfreq1&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C52eb55=
181dce469eb85608d7d487bb93%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637=
211551737394247&amp;sdata=3DFM8JoOuNa2gg09XVJ%2FLTLqK9rlL4hAwig2iM9cMYFhg%3=
D&amp;reserved=3D0=0A=
> =0A=
> The path from icc via pm_qos to devfreq does work (which is great) -=0A=
> however only after setting the minimum frequencies via a governor - I=0A=
> set the "powersave" governor.=0A=
> =0A=
> After that, frequencies are both set to high / low correctly.=0A=
> =0A=
> My impression was that I should be able to use the "passive" governor (a=
=0A=
> passive devfreq device?). What am I missing with using devfreq=0A=
> correctly? Or do I already?=0A=
=0A=
The devfreq governor is something else: it's used to make one devfreq =0A=
device match frequencies with another devfreq device.=0A=
=0A=
Setting the default governor to "powersave" is correct and roughly =0A=
matches behavior in NXP kernel.=0A=
=0A=
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>=0A=
=0A=
Thanks!=0A=
