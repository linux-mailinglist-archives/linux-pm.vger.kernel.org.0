Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE4C20A3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfI3Mb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 08:31:27 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:8454
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729603AbfI3Mb1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 08:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acOnNiP0kXQIivQZfmE5c5/rQer1AdNbi0puPBqUSJ5hdfhC2cd7Ye2lbxbUxeh+FbN0uh0B7CE7LlBa4+wmdaLusWfXrrhdn+6431OtPEvguRrwtoKDKN6mQeb18cV12PF3+jh92/NOWuctNrwwHObAxjFcduTG4Ys+h6fb9MmU9JdvJrEtR44g2LTi/jdF+uvIlIevDLlJdOsFcSCHJF8nMExZcYA+CNabHOIf3JKKa9YD/CkCmEaHtvjxLpMovLDF5tReFdoJT2dhO7OYAQrLd5vRuMjY925eNgQbRB2RHCsoCveTpFtXViMyvFzeKda2j5k2I787u+h+yTLk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0YK9BBMsjkmMIV4HXbw7SWLBrnTFXp4wwng71Bm87g=;
 b=HK2BGHf3+vDfxUe1j8l5MGCO8XIcrAqN417PjBXq2nivey5smptHRBLpH5nLejnrGKWKET3nnWyLMLyROpUi3Y6eH4KU/+8skHNAxpqES2N8Dk2XeG0h8hYMuR5QLLCBSnd7ilbsQhEh1rv5+a1EcHU5rwYqWCSOPRbp5zvuWbW5tEHRrGhRLHKZGBXf+qVQHrkmd/eQ2l64gxigtzkeTw9sWQshi/lexIywIVKQAdn0kHVw3ClLxQCCuYNvxZpWxRBrBuIi6JQuIHWghG4RCzl4FKXCuJ0Rb7/G4ex+ofpNvnDYLHw3ZSuHs4vmeeGa+ogfJgUPkoqLi9vGk55qoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0YK9BBMsjkmMIV4HXbw7SWLBrnTFXp4wwng71Bm87g=;
 b=sCk4wRHw2L6iWPpr+to887nENynCYKSbeUr3YpdBvQII1UzssXMkATuP8UqNrPc/plptN2Nawv0tTEdC/fTTIx1tCOf9PSLOXXMWcqrw5zzub77L4J9+Y5HlULouSVrUDRsLwGZxYH6/t4ag/KNNUZ1FsmM0+YUQyLUtpjUtPlM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5295.eurprd04.prod.outlook.com (20.177.51.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 12:31:22 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 12:31:22 +0000
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
Date:   Mon, 30 Sep 2019 12:31:22 +0000
Message-ID: <VI1PR04MB70230CC67539BC41E08F4956EE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <VI1PR04MB702373BE28E4404C7F2CE75FEE8C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <02d3fe6a-53a6-3290-deab-d79e940978ff@linaro.org>
 <VI1PR04MB7023ADED2210DFCB81E588CFEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <a1f04769-9547-58e6-2bd0-5b6a5864fbf0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e72abba1-5040-44fc-fee5-08d745a21a64
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5295:|VI1PR04MB5295:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52954D75E141EBA4EA10DDACEE820@VI1PR04MB5295.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(256004)(316002)(6246003)(9686003)(33656002)(25786009)(6306002)(186003)(55016002)(229853002)(6436002)(8936002)(26005)(52536014)(7696005)(110136005)(7416002)(99286004)(6506007)(102836004)(76176011)(86362001)(14454004)(71200400001)(66066001)(8676002)(44832011)(5660300002)(81156014)(81166006)(74316002)(53546011)(966005)(486006)(4326008)(54906003)(7736002)(446003)(478600001)(71190400001)(2906002)(6116002)(3846002)(66446008)(305945005)(476003)(64756008)(66556008)(66476007)(91956017)(66946007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5295;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6ui7NHeLubAqlbvzcZzWP0wudAWqH4gxofYatZIf8+wthggWvnSx/+ky4Cs7PnCpJ7qfUVp5PkmPuIDp7sDjpAke7zKvid2HpixHgmZw38d0yMKiZ3xEZ6xFSAgJaZQ5LVqVmbBgDkY1Cbdh3bMUFoP6qjuXcfaEjwXadbQ7YflVZUazSxx92kNlJi+OSyOfA3fpnlOz/UXVMiTkRSTG4S4/mytfloCnNxT1cBo+KZlLBXCB0d92wUt20s8vMXnXwpe4HGe7Y8stVugZ4nYYDiesY0whRwaYSW0ICxM4nfzyCi9md66oRu60SfJNfHyRRcsDirLH+5dceQgT3I5jhhSl91Zqu/vEeDcXEkv604ObfLlz2OZ/ECOrr8AlzhoKTOOCkkkIUK2F2QLqxFgBEmc8Kq9hcclDUH5u15oGgtsgkGZDZ3ndx5flH6wre21wHzvHzxAX+PgEPipQZzbNw==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72abba1-5040-44fc-fee5-08d745a21a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 12:31:22.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vunRFL9t44QpWdgR4U8JXPJc7tf2+QD82dkCZ+O7y9jG4xdI4T8TEEiq77z3Bl4GSkFo4fXUJbnLdCfigsMwyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5295
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-09-26 3:52 AM, Georgi Djakov wrote:=0A=
> On 9/25/19 15:52, Leonard Crestez wrote:=0A=
>> On 25.09.2019 05:38, Georgi Djakov wrote:=0A=
>>> Hi Leonard,=0A=
>>>=0A=
>>> On 9/16/19 05:34, Leonard Crestez wrote:=0A=
>>>> On 23.08.2019 17:37, Leonard Crestez wrote:=0A=
>>>>> This series add imx support for interconnect via devfreq: the ICC=0A=
>>>>> framework is used to aggregate requests from devices and then those a=
re=0A=
>>>>> converted to DEV_PM_QOS_MIN_FREQUENCY requests for devfreq.=0A=
>>>>>    =0A=
>>>>> Since there is no single devicetree node that can represent the "inte=
rconnect"=0A=
>>>>> new API is added to allow individual devfreq nodes to act as parsing =
proxies=0A=
>>>>> all mapping to a single soc-level icc provider. This is still RFC=0A=
>>>>> because of this=0A=
>>>>=0A=
>>>> Any comments? I made a lot of changes relative to previous versions,=
=0A=
>>>> most of them solely to avoid adding a virtual node in DT bindings.=0A=
>>>>=0A=
>>>> The only current interconnect provider implementation is for qcom and =
it=0A=
>>>> uses a firmware node as the provider node (with #interconnect-cells).=
=0A=
>>>> However there is no obvious equivalent of that for imx and many other =
SOCs.=0A=
>>>=0A=
>>> Not sure if it will help, but have you seen the qcs404 interconnect dri=
ver?=0A=
>>> There is also mt8183 interconnect provider driver on LKML.=0A=
>>=0A=
>> Yes, but only yesterday. The qcs404 driver involves multiple DT devices=
=0A=
>> so it seems closer to imx.=0A=
>>=0A=
>> As far as I understand from reading qcs404 source:=0A=
>>=0A=
>> * There is no struct device representing the entire graph.=0A=
>> * There are multiple NOCs and each registers itself as a separate=0A=
>> interconnect provider.=0A=
>> * Each NOC registers multiple icc_nodes of various sorts:=0A=
>>     * Device masters and slaves=0A=
>>     * Some nodes representing NoC ports?=0A=
> =0A=
> Well, all nodes are representing ports.=0A=
> =0A=
>>     * Multiple internal nodes=0A=
>> * There is single per-SOC master list of QNOCs in the qcs404 driver.=0A=
>> * The QNOCs can reference each other between multiple providers.=0A=
>> * Each NOC registers an icc_provider and a subset of the graph.=0A=
>> * The multiple NoC inside a chip are distinguished by compat strings.=0A=
>> This seems strange, aren't they really different instantiations of the=
=0A=
>> same IP with small config changes?=0A=
> =0A=
> No, they are different IPs - ahb, axi or custom based.=0A=
=0A=
On IMX some of the buses are just different instantiations.=0A=
=0A=
Would it make sense to standardize an "interconnect-node-id" to identify =
=0A=
middle nodes? For example if you have nearly identical "audio" "display" =
=0A=
"vpu" NICs then this property would make it possible to map from a DT =0A=
done to an ICC graph node.=0A=
=0A=
>> This design is still quite odd, what would make sense to me is to=0A=
>> register the "interconnect graph" once and then provide multiple=0A=
>> "interconnect scalers" which handle the aggregated requests for certain=
=0A=
>> specific nodes.=0A=
>>=0A=
>>>> On imx there are multiple pieces of scalable fabric which can be defin=
ed=0A=
>>>> in DT as devfreq devices and it sort of makes sense to add=0A=
>>>> #interconnect-cells to those. However when it comes to describing the=
=0A=
>>>> SOC interconnect graph it's much more convenient to have a single=0A=
>>>> per-SOC platform driver.=0A=
>>>=0A=
>>> Is all the NoC configuration done only by ATF? Are there any NoC relate=
d memory=0A=
>>> mapped registers?=0A=
>>=0A=
>> Registers are memory-mapped and visible to the A-cores but should only=
=0A=
>> be accessed through secure transactions. This means that configuration=
=0A=
>> needs be done by ATF in EL3 (we don't support running linux in secure=0A=
>> world on imx8m). There is no "remote processor" managing this on imx8m.=
=0A=
> =0A=
> Can we create some noc DT node with it's memory mapped address and make=
=0A=
> it an interconnect provider? Sounds to me like a more correct representat=
ion=0A=
> of the hardware?=0A=
=0A=
This is what I did, it's just that the initial binding is in this series:=
=0A=
https://patchwork.kernel.org/cover/11104113/=0A=
https://patchwork.kernel.org/patch/11104137/=0A=
https://patchwork.kernel.org/patch/11104141/=0A=
=0A=
The nodes are scaled via devfreq and interconnect comes "on top" to make =
=0A=
device bandwidth requests.=0A=
=0A=
I think using devfreq is valuable for example:=0A=
  * DDRC can support reactive scaling based on performance counters=0A=
  * The NOC can run at different voltages so it should have it's own OPP =
=0A=
table.=0A=
=0A=
> Other option would be to bless some PSCI DT node (for example) to be a=0A=
> provider.=0A=
=0A=
I don't think this can be a good fit, I want to support different =0A=
interconnect nodes with different underlying interfaces on the same SOC.=0A=
=0A=
There is no abstraction layer in firmware so abstractions for different =0A=
interconnect midnodes should be in linux instead.=0A=
=0A=
>> On older imx6/7 chips we actually have two out-of-tree implementations=
=0A=
>> of bus freq switching code: An older one in Linux (used when running in=
=0A=
>> secure world) and a different one in optee for running Linux in=0A=
>> non-secure world.=0A=
>>=0A=
>> NoC registers can be used to control some "transaction priority" bits=0A=
>> but I don't want to expose that part right now.=0A=
> =0A=
> This is very similar to some of the Qcom hardware.=0A=
=0A=
NoC IP is licensed from Arteris which was bought-out by Qcom. =0A=
Documentation is not public though and there are likely many differences =
=0A=
versus what Qcom has in their own chips.=0A=
>> What determines bandwidth versus power consumption is the NoC clk rate=
=0A=
>> and clocks are managed by Linux directly.=0A=
> =0A=
> So you will need to describe these clocks in the interconnect provider=0A=
> DT node like on qcs404.=0A=
=0A=
I already implemented the nodes as devfreq provider and DDRC even =0A=
includes ondemand reactive scaling support:=0A=
=0A=
https://patchwork.kernel.org/patch/11104139/=0A=
https://patchwork.kernel.org/patch/11104145/=0A=
https://patchwork.kernel.org/patch/11104143/=0A=
=0A=
I could just pick the "main" NOC and turn than into the "only" =0A=
interconnect provider. Something like this:=0A=
=0A=
if (has_property(noc_device, "#interconnect-cells")) {=0A=
     register_soc_icc_driver(noc_device);=0A=
}=0A=
=0A=
This would get rid of the icc_proxy stuff but fetching references to =0A=
other scalable nodes would require some other way to identify them.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
