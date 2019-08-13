Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B275D8BC49
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfHMPAB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:00:01 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:31851
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729060AbfHMPAB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 11:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/b1AE7vjIJqNqPNdlUquZJzsx45yqlq3MhhaN+/uD3i+EKm1H3sH6E6pQdbkhkgOZOGYUlxPeXysTKqfeu20pdGSMAbb4w2r7FLaMgc+uvHvGH73lMEONkH0SuCQPavG25zZ7reVMxb5MFk97VurCyZYRezGkYtIdWDZlmJ5+KmTmBs/D+j/HRzyagHKP4H6k6kf/dpcjB+QnDMCVBJ2ZTcgHgPP8j8CiUohwgAkzJ5yUAvViIozzsFT8q5EqFOGFzvLEO4dZY2YHqj+cbiKAsH2Ief0+5oKxIGFKXDmowEm5WBkZnUXoSNO/ZppguWLuWyHGgffpb9+/FB+DTYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDiILO7SooLmClTeL9XDv9DJ76g+A5SreUDfpe+zN4I=;
 b=AC7xpxg6fUrOannUh5rWXCEzg7lDvrfuleI9f0d3Izf9Gwt0gaRI9aUAaPC50Vq63ZqwfM+0IUDcC3B8a+UdKtBKN3vpODaR2rX+WMv3c9mDXF9URyVfymaRCqGsELQM6HzzuWCOFPmYZtPDcRvt6mxEGAH+L7L1jCbuxSqBN6AeNYwAc/olieLTOb7MbTYJFfOMxFr7ODdSkIzoucK15j+9DgJcTKmJKVJnXgHujbw5jgpGc6zxYUHEjQ7bDemaYP7ztkKffy6R60giVjG4FLSytqEvp6KfOjRRkbioCn0tsABloF7HY7+ySm+WfyhZCCbqF2bIxvYkk0eqTQr4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDiILO7SooLmClTeL9XDv9DJ76g+A5SreUDfpe+zN4I=;
 b=eCchaYVjbxb1tj2sx7I6c+U3tzvwvvwZTdTd4h3kX8OaEq1ojBIFoMEcTK/+A14UIlA/FCW64FV+kT27rwFytPtj3IWs0jmD8Gm13M4katpUu6xn/P7FhAzXlD1fWF9GmtLZCwfvzvbYxi+fKCp9lEI92NRf8jjwTI29JziPd+o=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5231.eurprd04.prod.outlook.com (20.177.51.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 13 Aug 2019 14:59:56 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970%2]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:59:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/7] dt-bindings: devfreq: Add bindings for generic imx
 buses
Thread-Topic: [PATCH 2/7] dt-bindings: devfreq: Add bindings for generic imx
 buses
Thread-Index: AQHVUT6+xLIyJJ3RiUKs8c+X3Pwpzw==
Date:   Tue, 13 Aug 2019 14:59:56 +0000
Message-ID: <VI1PR04MB70237460E84C4F8AC9EBE582EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565633880.git.leonard.crestez@nxp.com>
 <97b0bff95ddb85b06ef3d2f8079faa36562a956d.1565633880.git.leonard.crestez@nxp.com>
 <CAL_JsqJWpQN2oTm8Q2_Gzd0GJ+YZoc9j-zh-U1s4eGhMxDEmEA@mail.gmail.com>
 <VI1PR04MB702300C8C78BC033D16EDB85EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAL_Jsq+BDO-J12BddWw-KbhjTx95p58qqpUhhKzUHED6vFK2TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c39602a3-02da-404d-71bd-08d71ffee7ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5231;
x-ms-traffictypediagnostic: VI1PR04MB5231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52316504812CE809F110E4CBEED20@VI1PR04MB5231.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(66946007)(99286004)(91956017)(33656002)(71200400001)(71190400001)(305945005)(14454004)(74316002)(7736002)(66446008)(8936002)(66476007)(66556008)(64756008)(76116006)(7416002)(478600001)(86362001)(66066001)(81156014)(6116002)(14444005)(53936002)(55016002)(256004)(8676002)(5660300002)(9686003)(316002)(2906002)(6246003)(6436002)(3846002)(229853002)(25786009)(446003)(76176011)(476003)(4326008)(486006)(7696005)(110136005)(6506007)(26005)(53546011)(102836004)(186003)(54906003)(81166006)(52536014)(44832011)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5231;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +oivDm7qkUVaNWKCnrwGa50AJ3OiLZat36kPCpfPuotVYL9Hy4LhV+aOEbUPh/31WPjiHbL8ti+6tNnv00cz+Z3W7ecZnh7tmLyHw4wKAWRNoZJ+KLnBGSzz5NqVVOyB4ZG2IGghT6symAah0cn69QAR2dHmBODmgA7TRDpc6S4BZXKhT5mbgsh8eYPvFNdFHBSu0VlXwOvyEi9V4KcsijXufw1JMrzSrWWE9A/q57RZ0RyfY1ZNk0tQ6HEE9T/KU2A8jLv2b7Gwbz3mK7xAv1CmKuyPCDMddkgEHZS61HfzjN/A7eqP1D5D8nTDiG4vXa9d13AkuoO1stmGsPuvkYj4W6x0xKfnrqAIYjgW6fp2wkhkyI+oh1Y3WcfMVTiTYCOA4cALQxqAZx9uxKGZh4Fno51F2Rin2Ieqc4f/OWU=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39602a3-02da-404d-71bd-08d71ffee7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:59:56.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiInde8124Kwa7NBBs23Kt/FEE434S4IjjBy8vPBb/r6S1s2kFZ+caytrxh8/G1HI+hcZoUCCj5mfOL0tU2Q9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5231
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.08.2019 17:06, Rob Herring wrote:=0A=
> On Mon, Aug 12, 2019 at 7:32 PM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>> On 8/12/2019 10:47 PM, Rob Herring wrote:=0A=
>>> On Mon, Aug 12, 2019 at 12:49 PM Leonard Crestez <leonard.crestez@nxp.c=
om> wrote:=0A=
=0A=
>>>> Add initial dt bindings for the interconnects inside i.MX chips.=0A=
>>>> Multiple external IPs are involved but SOC integration means the=0A=
>>>> software controllable interfaces are very similar.=0A=
>>>>=0A=
>>>> +description: |=0A=
>>>> +  The i.MX SoC family has multiple buses for which clock frequency (a=
nd sometimes=0A=
>>>> +  voltage) can be adjusted.=0A=
>>>> +=0A=
>>>> +  Some of those buses expose register areas mentioned in the memory m=
aps as GPV=0A=
>>>> +  ("Global Programmers View") but not all. Access to this area might =
be denied for=0A=
>>>> +  normal world.=0A=
>>>> +=0A=
>>>> +  The buses are based on externally licensed IPs such as ARM NIC-301 =
and Arteris=0A=
>>>> +  FlexNOC but DT bindings are specific to the integration of these bu=
s=0A=
>>>> +  interconnect IPs into imx SOCs.=0A=
>>>=0A=
>>> No need to use the interconnect binding?=0A=
>>=0A=
>> The interconnect is represented by a separate "virtual" node which might=
=0A=
>> not be OK. There was also a recent RFC from samsung which turns devfreq=
=0A=
>> nodes into interconnect providers:=0A=
>>=0A=
>> Is that preferable?=0A=
> =0A=
> Virtual nodes are not OK.=0A=
=0A=
Then I'll try to make the "interconnect" device probe from a soc driver =0A=
and turn devfreq nodes into interconnect providers backed by this same =0A=
singleton device.=0A=
=0A=
Still separate from this series.=0A=
=0A=
>>>> +required:=0A=
>>>> +  - compatible=0A=
>>>> +  - clocks=0A=
>>>=0A=
>>> reg?=0A=
>>=0A=
>> This is deliberately optional: for some NICs the GPV register area is=0A=
>> not exposed in the memory map. This is unusual but an accurate=0A=
>> description of the hardware.=0A=
> =0A=
> Different h/w blocks should have different compatibles. GPV is an Arm=0A=
> thing and I'd expect FlexNOC to be different.=0A=
=0A=
The imx reference manuals call them both "GPV" though layout is indeed =0A=
quite different (and for FlexNoC it's not even documented).=0A=
=0A=
The h/w blocks do have different compat strings (imx8m-nic and =0A=
imx8m-noc). They have a single binding document because didn't want to =0A=
create two nearly-identical bindings, I assume it would be fine to split =
=0A=
later if needed.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
