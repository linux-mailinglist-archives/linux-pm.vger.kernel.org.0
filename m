Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D597BCA6A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfIXOjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 10:39:33 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:18498
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfIXOjc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 10:39:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwzRuL/Uo9pIhjKUDgYbMgMCAtxwc5nMVISBfFOCeQHbRtpL0w4cUnDv+nc4afslPxOGEyZq2KNWl81x6xmfpOUgHH7tsYJ2KhDJP5a003YFipTiJiOBIIh7OAfjOrMc14cZhqgKzIgPYjatG6OFPrSI4K2suj3tfni6USD8CFgQTYzAi7oThF/JKvc1vShJK3KcOGFHutm1x9bJWclkQyXQZjzVwrnHGIYihCIbk20OxpgGv51cPZPrUpvNd+B9F/XEGHN7swpt+9clEDev5Gq/4C4YCRHbQ+ww8iI4JZainQZCIZRt8ZeQVvIccxm4uMGT7iGoFESyOIqrqrE1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaPTX1+ECsNDZKD4Sxs1jnEBpRZlfNPnnBPcigeOdoM=;
 b=VXkibDDfu2Rj3qZy+cF7bjqsXSJA9Ytqq+y9hcXbn3vA1oIeNF6FgogmzZPS11gmlmeLXWD2YZH59E+qI0l8BEMlQoHC+MG6mC98NSENE1uJnVGH+VnBZ7AEiS09Y9zj/aW6cjF8IdwrvBxm6cuiqMhgCEeCZGnr0HY3tBJ6S56FHbb9kyE5/BBM4khoms8fuh+84D10C3NESTP6jzIOVfEXXO7CF6aNc7Xp5vH4Dwh0yx+mpies7AXOI6U8C95AQg4XHaO0c2kMHdlUodZQudK370VOXpmMeEVTGcjDWVYo50OnpNgXATUrkDlkuaz9FMPjf4DlXSr0V49XLVMaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaPTX1+ECsNDZKD4Sxs1jnEBpRZlfNPnnBPcigeOdoM=;
 b=KoiPiDTU8DhFbvVRKOxJGoC6pQvWspIm2auaOjl/51NgE8Oq6fDADVV5v9MR2mDzWcSC8+xaMVlQ9uWOZUElJJUjN6SLfZ+YKpIo7ScQvMxIxXMcpv5kAhLxbGHnElK8dnO73MwUZnlQDxH9fWX6kFM7xi2lh7+sAAvp8Iiz5KY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4591.eurprd04.prod.outlook.com (20.177.55.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 14:39:28 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 14:39:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
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
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect
 properties
Thread-Topic: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect
 properties
Thread-Index: AQHVWcA+RMYwTA9YVU2r3Zx7nMHKVw==
Date:   Tue, 24 Sep 2019 14:39:27 +0000
Message-ID: <VI1PR04MB7023FEED855FAA9707790B3AEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <3f27038292c09c8bf07a086eac759132c100aedb.1566570260.git.leonard.crestez@nxp.com>
 <20190917201956.GA10780@bogus>
 <VI1PR04MB70237046A8DF88936C7A83F8EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAL_JsqLj9FdoSwt7HZwoX42GS9RJ6Zeze=bUZs-tia2oS+OzUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce9c6c68-4e0b-4d2c-a673-08d740fd00d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4591;
x-ms-traffictypediagnostic: VI1PR04MB4591:|VI1PR04MB4591:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4591898A5BBBF7DF6C2F5795EE840@VI1PR04MB4591.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(3846002)(81156014)(81166006)(8936002)(66446008)(66556008)(110136005)(54906003)(2906002)(66946007)(64756008)(486006)(446003)(256004)(86362001)(14444005)(44832011)(966005)(91956017)(14454004)(76116006)(8676002)(476003)(66476007)(66066001)(478600001)(305945005)(229853002)(55016002)(102836004)(6436002)(74316002)(76176011)(7696005)(71190400001)(6306002)(71200400001)(9686003)(4326008)(52536014)(33656002)(6246003)(53546011)(6506007)(186003)(26005)(316002)(5660300002)(7736002)(99286004)(7416002)(25786009)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4591;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 18YlBvV+s61lLpf1ZQAY2KyKIFgmp4qX1kkSon/Xq4npXXYU7N84Ih/CaBS4h4mAE/uX8y7Uf/WblSbyNxl9JkN0gYO4Q+QTc1nKqxViLI2mnyqqsG32gUw2chqdbYg6P4UrOAJingAyT3iGxACFJZXlhBnP0Yt7IFNrbWMoKAKrWxw7Oj0XkiyrWvpv8GqNH8dnpCNWJ/JMHHSxx2NzAjj88JkpKPg8cN9S1XqloZF+gLkbFIFcBsJnebLYsUBLFkb/IlCa4H+Ds5jcQihd8VI0mHYMqdoKk+qqGKYKVXNM1wX4ZKRW4X+ZnOlLb2D2+JLAstU/rHw+x5aYdiPZC0aXvPcSeKKMcjiQSDbnsXR+fnioTpLZHWM000Pdlf8igudc2F/BVw48CqME9LlkZLXsg5jb6vGrjuA10CttnYwR6XxSjxgIVwNRYVSF69LO72pwq6WgX0HA9hqiAvpshg==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9c6c68-4e0b-4d2c-a673-08d740fd00d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 14:39:27.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7/RSfCIig0Dw3r31dT7xigl+fWGtBlCr0qVU/z9L/IdynQtNrovbY9n1GdU9bwOWxk5DU/s1LDf6+ZDNMyrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4591
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24.09.2019 00:04, Rob Herring wrote:=0A=
> On Mon, Sep 23, 2019 at 12:42 PM Leonard Crestez=0A=
> <leonard.crestez@nxp.com> wrote:=0A=
>>=0A=
>> On 17.09.2019 23:20, Rob Herring wrote:=0A=
>>> On Fri, Aug 23, 2019 at 05:36:56PM +0300, Leonard Crestez wrote:=0A=
>>>> The interconnect-node-id property is parsed by the imx interconnect=0A=
>>>> driver to find nodes on which frequencies can be adjusted.=0A=
>>>>=0A=
>>>> Add #interconnect-cells so that device drivers can request paths from=
=0A=
>>>> bus nodes instead of requiring a separate "virtual" node to represent=
=0A=
>>>> the interconnect itself.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>> ---=0A=
>>>>    Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml | 5 +++++=
=0A=
>>>>    Documentation/devicetree/bindings/devfreq/imx.yaml      | 5 +++++=
=0A=
>>>>    2 files changed, 10 insertions(+)=0A=
>>>=0A=
>>> Please combine this with the other series for devfreq support.=0A=
>>=0A=
>> I understand that having two series which add to the same bindings file=
=0A=
>> is odd but the devfreq and interconnect parts are independent to a very=
=0A=
>> large degree and devfreq can be useful on it's own.=0A=
> =0A=
> To start with, I'm suspicious of any 'devfreq' binding because that's=0A=
> a Linux thing. I somewhat expect that the interconnect binding should=0A=
> replace the devfreq binding, but I haven't been able to investigate.=0A=
> =0A=
> Design something that matches the structure of the h/w not how Linux=0A=
> drivers happen to be structured. I can't tell what that is without any=0A=
> context around adding a couple of properties. Nor do I have the time=0A=
> to dig into each SoC vendor's bus structure if it's even documented=0A=
> publicly.=0A=
=0A=
Device tree binding files are organized based on linux subsystems but =0A=
otherwise there's little particularly specific to "devfreq" in this new =0A=
binding.=0A=
=0A=
An imx NIC or NOC is a physical component of a SOC which can run at a =0A=
variable clock speed. The device binding uses standard clk and opp =0A=
tables in meaningful ways so that first part is reasonable.=0A=
=0A=
I also want to implement an interconnect provider but an "interconnect" =0A=
is not a single device but rather a graph of discrete buses. Some options:=
=0A=
* Add a custom virtual device, easy but not upstreamable.=0A=
* Have a single icc provider device use the individual buses as =0A=
"proxies" for OF parting. Implemented in this series but not very pretty.=
=0A=
* Pick the "main noc" as the single interconnect provider?=0A=
=0A=
Alternatively the approach of defining the graph in the driver could be =0A=
dropped and everything could be described in DT (quite verbose). This =0A=
seems to be what Samsung is doing:=0A=
=0A=
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D176291=
=0A=
=0A=
It might even possible to use of_graph; this is complicated but the NICs =
=0A=
and NOCs do in fact have discrete ports with assignable properties.=0A=
=0A=
 > I also don't follow why you need 'interconnect-node-id' and if you do,=
=0A=
 > it should be a common property.=0A=
=0A=
The "interconnect-node-id" property in devicetree identifies nodes from =0A=
the interconnect graph; for example the DDRC node identifies itself as =0A=
IMX8MM_ICS_DRAM.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
=0A=
