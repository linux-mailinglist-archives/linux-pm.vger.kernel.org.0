Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAEABE87E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfIYWwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 18:52:21 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:18307
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729604AbfIYWwV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 18:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYQRc5aDVQ0K7KuiXzf27hya4rZ2XcmipvfCgGEhKHT1BNSYOcqNFpigUu9RIyLQIyAel7Y1HOEyI6YjrjTdZSHcWdE2yFjoiZraCcXnwZFoBBGZBpunZrNQVCoUSGpi+ZL5z4Zb/P73szgQD0ekG5nHva4A3a1jVQakIn5X6R77/5p2maQdkrct8ERbwLtsaM8YQ09YqAfi7Gfp1ME0M6ZOZTZ5bqZhommpoFXRS0ziUeWxXuCEKctZvJfqSFs9+PLg9cyi9DdLusQ6oxZ/1Vo6MFXZPldKta3FmrUYitiBtb5kgc9YfIJiT/TsebXT8QOpIBJfEl4usym0WrQRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5iSq2nhxfuvjfq1Lf5BigNX4+LfIEyFcWYeXnB3wug=;
 b=ePDeRR4o/QRLJ0iuVAeDKNoH8elQl5Q8vO4I/14X9+qwAcYtclctJ4HOdYVzCEZvqeE1JbYoU7aYoTrU6NXUSq3cyuqJmMyRznDERZtLFpIc4GfDvgsKWmxXEjdx8BAQ2cir2DJfP0CaVmnf4mBDTldCzU4k1kF51jMhekOYWiP2ghXj3/AgJG2kMnNz7J5Kw0XIKw270tgBVoSo8BJ0wqtYFAkkQ0ezotcY/oD7quy/UAlOz31vcBmACgC2jBP2mhNnfY//sB2hH3ynzJfDoi3rYW2rbMI3SQGwqFx2Z/csiQOSdjhkvjOJQMXtLn5EYEKcnM2w6qwPPjOqkOZAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5iSq2nhxfuvjfq1Lf5BigNX4+LfIEyFcWYeXnB3wug=;
 b=KX1OfuXCteKzavdrvy1vBXiefRILpVLCldp0cwuwslbs4wFIZLdFlmSfu0OYHQBATfcr/ReZnfa8UXG97CmZHAVTp0o0IRdHY01A17Ey5heZnlQFftb1DJTFVtjVxksZ1me+oy2lfwYzW3SYftm7zw89lLSa48FUn29CH7Au98w=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3040.eurprd04.prod.outlook.com (10.170.228.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 22:52:15 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 22:52:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv4 0/7] interconnect: Add imx support via devfreq
Thread-Topic: [RFCv4 0/7] interconnect: Add imx support via devfreq
Thread-Index: AQHVWcA7xPiNhLrdqkSG10Lu7U9EhQ==
Date:   Wed, 25 Sep 2019 22:52:14 +0000
Message-ID: <VI1PR04MB7023ADED2210DFCB81E588CFEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <VI1PR04MB702373BE28E4404C7F2CE75FEE8C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <02d3fe6a-53a6-3290-deab-d79e940978ff@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6ad8b2d-4548-4d2d-9302-08d7420b0281
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3040;
x-ms-traffictypediagnostic: VI1PR04MB3040:|VI1PR04MB3040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB30402C769EFAF5820F61CF6EEE870@VI1PR04MB3040.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(4326008)(81166006)(81156014)(33656002)(55016002)(186003)(7416002)(14444005)(256004)(74316002)(316002)(102836004)(54906003)(305945005)(76176011)(53546011)(6506007)(7736002)(99286004)(7696005)(9686003)(66066001)(26005)(486006)(110136005)(66446008)(64756008)(66556008)(478600001)(8936002)(76116006)(66946007)(14454004)(91956017)(229853002)(3846002)(6246003)(86362001)(71200400001)(6116002)(44832011)(52536014)(71190400001)(66476007)(5660300002)(2906002)(6436002)(446003)(25786009)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3040;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IaZpNTogoaHWclceYZwk6/OlKPaxbi/wnOtkw3zmDDpxaGjwAdHGL5KaAb6TGx1ryPTQs9SLMCGG6myiA6SP3Ax/p0EFp2ZXhN1DdCzDWiIRFc4gE1eieFRRObP99uUFRNIe6ybyiKOUE6dasEshvxsmRy/z5cuhl5nAOcagnF+FbRhT50dmFA71qiErASSqv+ch+mimtZZhq6RA+QHSt604anrfw02CKJt2VFBf0OL/GWqj6alxIr3gajWeagJkF6bBOzuJHhVZ/HxOsFf4yix7nBc6d/D3M8t+bQnWUwwLkRrPIrEIwQ8Yk+tzWkvmtmZKgpQZjV0HCA//CttdGkTyftMvp7OJlFZ5hyN8qsbAMbVUedFke2A0SvIw5z9+08w+scHPCUS7ujbDZftFIQ0KUAhExZayFwrfKk89A9g=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ad8b2d-4548-4d2d-9302-08d7420b0281
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 22:52:14.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbW8rqqIPs/WQJNoLGRiP4wb3GKcAiOaVtaxJzfMbGrskYjId03JFZUrRcRwebm28qNaCsFPaGOJ7PtZz8Pf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3040
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.09.2019 05:38, Georgi Djakov wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 9/16/19 05:34, Leonard Crestez wrote:=0A=
>> On 23.08.2019 17:37, Leonard Crestez wrote:=0A=
>>> This series add imx support for interconnect via devfreq: the ICC=0A=
>>> framework is used to aggregate requests from devices and then those are=
=0A=
>>> converted to DEV_PM_QOS_MIN_FREQUENCY requests for devfreq.=0A=
>>>   =0A=
>>> Since there is no single devicetree node that can represent the "interc=
onnect"=0A=
>>> new API is added to allow individual devfreq nodes to act as parsing pr=
oxies=0A=
>>> all mapping to a single soc-level icc provider. This is still RFC=0A=
>>> because of this=0A=
>>=0A=
>> Any comments? I made a lot of changes relative to previous versions,=0A=
>> most of them solely to avoid adding a virtual node in DT bindings.=0A=
>>=0A=
>> The only current interconnect provider implementation is for qcom and it=
=0A=
>> uses a firmware node as the provider node (with #interconnect-cells).=0A=
>> However there is no obvious equivalent of that for imx and many other SO=
Cs.=0A=
> =0A=
> Not sure if it will help, but have you seen the qcs404 interconnect drive=
r?=0A=
> There is also mt8183 interconnect provider driver on LKML.=0A=
=0A=
Yes, but only yesterday. The qcs404 driver involves multiple DT devices =0A=
so it seems closer to imx.=0A=
=0A=
As far as I understand from reading qcs404 source:=0A=
=0A=
* There is no struct device representing the entire graph.=0A=
* There are multiple NOCs and each registers itself as a separate =0A=
interconnect provider.=0A=
* Each NOC registers multiple icc_nodes of various sorts:=0A=
   * Device masters and slaves=0A=
   * Some nodes representing NoC ports?=0A=
   * Multiple internal nodes=0A=
* There is single per-SOC master list of QNOCs in the qcs404 driver.=0A=
* The QNOCs can reference each other between multiple providers.=0A=
* Each NOC registers an icc_provider and a subset of the graph.=0A=
* The multiple NoC inside a chip are distinguished by compat strings. =0A=
This seems strange, aren't they really different instantiations of the =0A=
same IP with small config changes?=0A=
=0A=
This design is still quite odd, what would make sense to me is to =0A=
register the "interconnect graph" once and then provide multiple =0A=
"interconnect scalers" which handle the aggregated requests for certain =0A=
specific nodes.=0A=
=0A=
>> On imx there are multiple pieces of scalable fabric which can be defined=
=0A=
>> in DT as devfreq devices and it sort of makes sense to add=0A=
>> #interconnect-cells to those. However when it comes to describing the=0A=
>> SOC interconnect graph it's much more convenient to have a single=0A=
>> per-SOC platform driver.=0A=
> =0A=
> Is all the NoC configuration done only by ATF? Are there any NoC related =
memory=0A=
> mapped registers?=0A=
=0A=
Registers are memory-mapped and visible to the A-cores but should only =0A=
be accessed through secure transactions. This means that configuration =0A=
needs be done by ATF in EL3 (we don't support running linux in secure =0A=
world on imx8m). There is no "remote processor" managing this on imx8m.=0A=
=0A=
On older imx6/7 chips we actually have two out-of-tree implementations =0A=
of bus freq switching code: An older one in Linux (used when running in =0A=
secure world) and a different one in optee for running Linux in =0A=
non-secure world.=0A=
=0A=
NoC registers can be used to control some "transaction priority" bits =0A=
but I don't want to expose that part right now.=0A=
=0A=
What determines bandwidth versus power consumption is the NoC clk rate =0A=
and clocks are managed by Linux directly.=0A=
=0A=
DVFS on the RAM controller (DDRC) is also important. That component is =0A=
only a bus slave and frequency switching requires a complex sequence =0A=
inside ATF.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
