Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45527126634
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSP4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfLSP4k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 10:56:40 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FB424684;
        Thu, 19 Dec 2019 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576770998;
        bh=0Pm5xbVaCxs8BDWE0AO/AkoMPEpTLLpRh/fmzyxzbF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bnqBIiUy4j5hReIcnJ1Aa5+6wUnMNyffAY6ipdL/QrxnTmUigAlxRz6QOW2rryaPq
         hiDHB0rjuqHIPp4m9YK0KoSFhkYptXQQN823tOO1csR5B0Qi0PlF5rb0JE6KzczAUX
         6DVqWIuWRZFyYxJOnSAjlrT//vVvvmae9zj5Rl+E=
Received: by mail-lj1-f169.google.com with SMTP id h23so6771436ljc.8;
        Thu, 19 Dec 2019 07:56:37 -0800 (PST)
X-Gm-Message-State: APjAAAVG+tnftBzsnQMKp+yE/4+O5AbKnKxm9rM7F1Y7Cm62534Ol+J2
        7ec4mn8seOJscR1M+ZYfCT7RGmCct5+x7zrmfO4=
X-Google-Smtp-Source: APXvYqw8UuQ8CeDdGTa+yq+fueXLPj2or2MBA76QCS9H6ZvUM5VjqXYcfJm4ct6mpIqZ9sOfI/iQa3U7SPy7JJPRzkY=
X-Received: by 2002:a2e:8551:: with SMTP id u17mr1719854ljj.165.1576770995892;
 Thu, 19 Dec 2019 07:56:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573761527.git.leonard.crestez@nxp.com> <CGME20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d@epcas5p2.samsung.com>
 <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
 <c1c03b30-d82a-6f2b-156d-0e1948e0df5b@samsung.com> <afd618d6-d78c-a989-2d1e-60c368ec267f@samsung.com>
 <VI1PR04MB7023A61DD48302CF0E0B3B81EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <b8fc116f-d99f-37c6-ce07-aa0f844ac604@samsung.com> <VI1PR04MB7023423D8D5D633074978430EE520@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023423D8D5D633074978430EE520@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Fri, 20 Dec 2019 00:55:59 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3epdWS_4kezHbvqmZPuUUbRs_7YGeofhB7yAL2tkh59g@mail.gmail.com>
Message-ID: <CAGTfZH3epdWS_4kezHbvqmZPuUUbRs_7YGeofhB7yAL2tkh59g@mail.gmail.com>
Subject: Re: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 12=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 11:33,=
 Leonard Crestez <leonard.crestez@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On 17.12.2019 02:08, Chanwoo Choi wrote:
> > On 12/17/19 12:09 AM, Leonard Crestez wrote:
> >> On 16.12.2019 05:18, Chanwoo Choi wrote:
> >>> Hi,
> >>>
> >>> On 12/16/19 10:12 AM, Chanwoo Choi wrote:
> >>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
> >>>>> Add initial dt bindings for the interconnects inside i.MX chips.
> >>>>> Multiple external IPs are involved but SOC integration means the
> >>>>> software controllable interfaces are very similar.
> >>>>>
> >>>>> Main NOC node acts as interconnect provider if #interconnect-cells =
is
> >>>>> present.
> >>>>>
> >>>>> Multiple interconnects can be present, each with their own OPP tabl=
e.
> >>>>>
> >>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >>>>> ---
> >>>>>    .../bindings/interconnect/fsl,imx8m-noc.yaml  | 104 ++++++++++++=
++++++
> >>>>>    1 file changed, 104 insertions(+)
> >>>>>    create mode 100644 Documentation/devicetree/bindings/interconnec=
t/fsl,imx8m-noc.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx=
8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.=
yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..5cd94185fec3
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.=
yaml
> >>>>> @@ -0,0 +1,104 @@
> >>>>> +# SPDX-License-Identifier: GPL-2.0
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fprotect2.fireeye.com%2Furl%3Fk%3D8570eb5a-d8a45732-85716015-0cc47a33=
56b2-92a5b92cc514d07e%26u%3Dhttps%3A%2F%2Feur01.safelinks.protection.outloo=
k.com%2F%3Furl%3Dhttps%253A%252F%252Fprotect2.fireeye.com%252Furl%253Fk%253=
D0c13f3e0-51df3f45-0c1278af-0cc47a30d446-77e809543b673ffd%2526u%253Dhttp%25=
3A%252F%252Fdevicetree.org%252Fschemas%252Finterconnect%252Ffsl%252Cimx8m-n=
oc.yaml%2523%26amp%3Bdata%3D02%257C01%257Cleonard.crestez%2540nxp.com%257C2=
d1f1868afa140702a6b08d781d6ab68%257C686ea1d3bc2b4c6fa92cd99c5c301635%257C0%=
257C0%257C637120631307418544%26amp%3Bsdata%3DH2q5nQlKYyLIivkBYUTaRD1Nu3Wcnp=
hPJny3k%252BK%252BGFE%253D%26amp%3Breserved%3D0&amp;data=3D02%7C01%7Cleonar=
d.crestez%40nxp.com%7C769d8e354f3b4d00b84508d782854a17%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C0%7C637121381290437871&amp;sdata=3DHYMJJHWyiKRhf7GDjKo=
OwjDpcZuYqlFlmRrDZnIRx5w%3D&amp;reserved=3D0
> >>>>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fprotect2.fireeye.com%2Furl%3Fk%3Df7cec483-aa1a78eb-f7cf4fcc-0cc4=
7a3356b2-4154a3c43886f5ed%26u%3Dhttps%3A%2F%2Feur01.safelinks.protection.ou=
tlook.com%2F%3Furl%3Dhttps%253A%252F%252Fprotect2.fireeye.com%252Furl%253Fk=
%253D87c672dc-da0abe79-87c7f993-0cc47a30d446-414d3b4d0127419a%2526u%253Dhtt=
p%253A%252F%252Fdevicetree.org%252Fmeta-schemas%252Fcore.yaml%2523%26amp%3B=
data%3D02%257C01%257Cleonard.crestez%2540nxp.com%257C2d1f1868afa140702a6b08=
d781d6ab68%257C686ea1d3bc2b4c6fa92cd99c5c301635%257C0%257C0%257C63712063130=
7418544%26amp%3Bsdata%3DT6PgQ1DWI4OLOx3gifRRt%252FNImdVrgDUoswZ%252FNKw3oR8=
%253D%26amp%3Breserved%3D0&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7=
C769d8e354f3b4d00b84508d782854a17%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C=
0%7C637121381290437871&amp;sdata=3DfIbrUUOUtZ5nt%2FH1tm3dzaI1J%2FGn5Gc54ms9=
3HnBnQg%3D&amp;reserved=3D0
> >>>>> +
> >>>>> +title: Generic i.MX bus frequency device
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Leonard Crestez <leonard.crestez@nxp.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  The i.MX SoC family has multiple buses for which clock frequency=
 (and
> >>>>> +  sometimes voltage) can be adjusted.
> >>>>> +
> >>>>> +  Some of those buses expose register areas mentioned in the memor=
y maps as GPV
> >>>>> +  ("Global Programmers View") but not all. Access to this area mig=
ht be denied
> >>>>> +  for normal (non-secure) world.
> >>>>> +
> >>>>> +  The buses are based on externally licensed IPs such as ARM NIC-3=
01 and
> >>>>> +  Arteris FlexNOC but DT bindings are specific to the integration =
of these bus
> >>>>> +  interconnect IPs into imx SOCs.
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    oneOf:
> >>>>> +      - items:
> >>>>> +        - enum:
> >>>>> +          - fsl,imx8mn-nic
> >>>>> +          - fsl,imx8mm-nic
> >>>>> +          - fsl,imx8mq-nic
> >>>>> +        - const: fsl,imx8m-nic
> >>>>> +      - items:
> >>>>> +        - enum:
> >>>>> +          - fsl,imx8mn-noc
> >>>>> +          - fsl,imx8mm-noc
> >>>>> +          - fsl,imx8mq-noc
> >>>>> +        - const: fsl,imx8m-noc
> >>>>> +
> >>>>> +  reg:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  clocks:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  operating-points-v2: true
> >>>>> +  opp-table: true
> >>>>> +
> >>>>> +  devfreq:
> >>>>> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> >>>>> +    description:
> >>>>> +      Phandle to another devfreq device to match OPPs with by usin=
g the
> >>>>
> >>>> Better to use 'parent' instead of 'another' word for improving the u=
nderstanding.
> >>>
> >>> I think that 'devfreq' is not proper way to get the parent node
> >>> in devicetree. Because 'devfreq' name is linuxium. The property name
> >>> didn't indicate the any h/w device. So, I'll make 'devfreq' property =
deprecated.
> >>>
> >>> So, you better to make the specific property for this device driver
> >>> like as following: and use devfreq_get_devfreq_by_node() function
> >>> which is developed by you in order to get the devfreq instance node.
> >>>
> >>>     fsl,parent-device =3D <&parent devfreq device>;
> >>
> >> This is only a "parent" in the sense that it's assigned to
> >> devfreq_passive.data.parent. The "devfreq" name is indeed too generic.
> >
> > I thought that 'devfreq' property name is generic.
> > But, it's not proper for DT binding because DT file show
> > the h/w and the relation of h/w. 'devfreq' property name
> > has not meant h/w.
> >
> > So that devfreq core doesn't force to use the specific property
> > name to get the devfreq parent instance on DT. Just, devfreq core
> > will provide devfreq_get_devfreq_by_node() function.
> >
> > I developed it on devfre-testing branch[2]. Before I'm sending
> > the these patches, you can check them.
> >
> > [1] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fchanwoo%2Flinux.git%2F=
commit%2F%3Fh%3Ddevfreq-testing%26id%3Df3678b4e6b75dccfe8bb87d005da2d68c70f=
deab&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C769d8e354f3b4d00b8450=
8d782854a17%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637121381290437871=
&amp;sdata=3DR21Tv1QgofBvMYb2VaxFjKSerwQ3tl8kakcYRyALmgM%3D&amp;reserved=3D=
0
> > [2] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fchanwoo%2Flinux.git%2F=
log%2F%3Fh%3Ddevfreq-testing&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com=
%7C769d8e354f3b4d00b84508d782854a17%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%=
7C0%7C637121381290437871&amp;sdata=3DuH0d9LvrbCHgZJdrPJNJ8c8w45J7x1QyM7t5I3=
j%2BpSw%3D&amp;reserved=3D0
> >
> >>
> >> The DDRC can measure bandwith usage and I want to use the passive
> >> governor to make the main NOC match OPPs.
> >
> > which one use the passive governor? And which one is the parent
> > devfreq device for devfreq device using passive governor?
> >
> > In my case, it is difficult to catch the relationship
> > between devices. I'd like you to explain the detailed relationship
> > on binding document for user.
> >
> >> But at the bus level DDRC only has AXI and APB slave ports.
> >
> > 'DDRC' indicates the 'drivers/devfreq/imx8m-ddrc.c?
> >
> >>
> >> Buses on imx don't have a parent/child relationship; in fact there are
> >> even a few cycles.
> >
> > You mentioned that 'imx don't have a parent/child relationship',
> > Why do you use 'passive' governor? It is difficult to understand
> > the hierarchy of imx.
>
> The imx8m has a main NOC in the center between the CPU and the DDRC
> (dram controller) with many other peripheral buses around the NOC.

Actually, if this dt binding document contains the relationship
between ddrc(imx8m-ddrc.c)
, imx-bus.c(bus) and interconnect node, it is more easy to understand
the hierarchy
of bus/ddrc. In my case, it is difficult because the binding document doesn=
't
include the enough example. But, I'll expect them as you mentioned on
your reply.

>
> Here's /sys/kernel/debug/interconnect/interconnect_graph on imx8mm:
> https://gist.github.com/cdleonard/84d103dafc9131fcb8ca9a494822a131#file-i=
mx8mm-svg

It is the interconnect node graph. I hope to know the relationship
when bus(imx-bus.c)
uses the 'passive governor' and which is the

>
> A lot of stuff is omitted, it mostly just includes high-performance bus
> masters.
>
> DDRC has a performance monitor attached which can measure current
> bandwith and feed it to an ondemand governor. I want to use passive
> governor on the NOC so that it matches frequencies with DDRC and scales

I have the following questions. If you explain the more detailed descritpio=
n
and add multiple dt bidning example, I'll expect that I can understand
the following my questions.
- Which one will use the 'passive governor'?
- DDRC is parent devfreq device for imx bus(imx-bus.c) using passive govern=
or?
- Why imx bus(imx-bus.c) use the userspace governor?
- Which the relationship between imx bus(imx-bus.c) using userspace
governor and imx bus(imx-bus.c) using passive governor?

> proportionally, otherwise if NOC is at low frequency then dynamically
> scaling up the DDRC might be ineffective.
>
> Perhaps you could explain how parent/child relationships work on exynos?

Right. So, I wrote[1] why exynos-bus.c have to use the passive governor
and how to make the hierarchy/relationship between exynos-bus(parent
devfreq device
using devfreq governor except for passive governor)
and exynos-bus (child devfreq device using only passive governor).

[1] Documentation/devicetree/bindings/devfreq/exynos-bus.txt

>
> >>> [1] [PATCH RFC v5 04/10] PM / devfreq: Add devfreq_get_devfreq_by_nod=
e
> >>>
> >>>>
> >>>>> +      passive governor.
> >>>>> +
> >>>>> +  '#interconnect-cells':
> >>>>> +    description:
> >>>>> +      If specified then also act as an interconnect provider. Shou=
ld only be
> >>>>> +      set once per soc on main noc.
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  fsl,scalable-node-ids:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>>> +    description:
> >>>>> +      Array of node ids for scalable nodes. Uses same numeric iden=
tifier
> >>>>> +      namespace as the consumer "interconnects" binding.
> >>>>> +
> >>>>> +  fsl,scalable-nodes:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>>> +    description:
> >>>>> +      Array of phandles to scalable nodes. Must be of same length =
as
> >>>>> +      fsl,scalable-node-ids.
> >>>>> +
> >>>>> +required:
> >>>>> +  - compatible
> >>>>> +  - clocks
> >>>>> +
> >>>>> +additionalProperties: false
> >>>>> +
> >>>>> +examples:
> >>>>> +  - |
> >>>>
> >>>> Is it enough example to understand the relation between
> >>>> imx8m-ddrc.c, imx-devfreq.c and imx interconnect driver?
> >>>>
> >>>> In my case, if possible, hope to show the more detailed
> >>>> example. This example seems that don't contain the ddrc
> >>>> dt node (imx8m-ddrc.c).
> >>
> >> OK, I'll elaborate explanation on noc binding.
> >
> > Thanks. If possible, you better to add almost example cases.
> >
> >>
> >>>>
> >>>>> +    #include <dt-bindings/clock/imx8mq-clock.h>
> >>>>> +    #include <dt-bindings/interconnect/imx8mq.h>
> >>>>> +    noc: interconnect@32700000 {
> >>>>> +            compatible =3D "fsl,imx8mq-noc", "fsl,imx8m-noc";
> >>>>> +            reg =3D <0x32700000 0x100000>;
> >>>>> +            clocks =3D <&clk IMX8MQ_CLK_NOC>;
> >>>>> +            #interconnect-cells =3D <1>;
> >>>>> +            fsl,scalable-node-ids =3D <IMX8MQ_ICN_NOC>,
> >>>>> +                                    <IMX8MQ_ICS_DRAM>;
> >>>>> +            fsl,scalable-nodes =3D <&noc>,
> >>>>> +                                 <&ddrc>;
> >>>>> +            operating-points-v2 =3D <&noc_opp_table>;
> >>>>> +
> >>>>> +            noc_opp_table: opp-table {
> >>>>> +                    compatible =3D "operating-points-v2";
> >>>>> +
> >>>>> +                    opp-133M {
> >>>>> +                            opp-hz =3D /bits/ 64 <133333333>;
> >>>>> +                    };
> >>>>> +                    opp-800M {
> >>>>> +                            opp-hz =3D /bits/ 64 <800000000>;
> >>>>> +                    };
> >>>>> +            };
> >>>>> +    };
> >>
> >>
> >
> >
>
>


--=20
Best Regards,
Chanwoo Choi
