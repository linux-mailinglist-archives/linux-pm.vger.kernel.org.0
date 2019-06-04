Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23CB350B9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFDUN2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 16:13:28 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:38629
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfFDUN2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 16:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQgKmCxWL5uhQ45PzO7xtWZM46pb7Q/3ek6oP6HpdLE=;
 b=Ge1KY/QopbO+9dx3fpfw4kheoxlYFGetUaPH6en5wddTmcGTHqfRyHqhkzzlE4SGEtaa5DitdxkNdLyjpytRNhpCj2rl+WAkUEbI8YLgwL37LO5w2fJWKz9W+NGceTCsW/n3SeO/gxZTGn8MTTuYjoxWQVWnw0QTWHMAKJSdPv8=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5919.eurprd04.prod.outlook.com (20.178.205.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 20:13:18 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1965.011; Tue, 4 Jun 2019
 20:13:18 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Emilio Lopez <emilio@elopez.com.ar>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Thread-Topic: [RFC PATCH 0/3] Add support of busfreq
Thread-Index: AQHU2dO+g7FtRU5+MUaLzLMJn01eLA==
Date:   Tue, 4 Jun 2019 20:13:18 +0000
Message-ID: <VI1PR04MB5055E9AB9BD3D68BB6C1F6C2EE150@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
 <8af96425-a6f5-0114-7abb-c2a67b952e1b@baylibre.com>
 <AM0PR04MB643434FB6A26B4D70F52F350EE080@AM0PR04MB6434.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167B9EAE9A741AB0F20E30F5150@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc6a45d7-1d39-4d95-c153-08d6e92915a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5919;
x-ms-traffictypediagnostic: VI1PR04MB5919:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB59193C94A656BCAFBD65F5A3EE150@VI1PR04MB5919.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(52084003)(5660300002)(6436002)(486006)(6506007)(53546011)(110136005)(54906003)(74316002)(33656002)(44832011)(7696005)(7416002)(476003)(186003)(6306002)(71200400001)(71190400001)(55016002)(26005)(9686003)(66946007)(73956011)(102836004)(66556008)(76116006)(446003)(64756008)(66446008)(66476007)(52536014)(91956017)(76176011)(3846002)(2906002)(68736007)(316002)(7736002)(14444005)(66066001)(256004)(6116002)(478600001)(305945005)(966005)(6246003)(4326008)(8936002)(53936002)(229853002)(25786009)(81156014)(81166006)(14454004)(86362001)(8676002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5919;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7OLi5rOxRkW0300175HB9h8BZ5hRv16J792FSldcyWlvMol3t6WpiUHs36sfW5JIxJHE/29sM0upHznrxcuSWVuRXPGBeyR3dyR3zTiE2c/Nlz/aOKtokL3ZQ/wEykn342jZIPGLH8pRUv9VodSjjdspHjwh16Ikb7JFU58OEgY+fV19kVDZ3+/IKa4RzIJ3hwU0esnB8IVmf/xGqVtHrZ/xbS02Ljy2TDgTfzgNAh28PdDtT1yM0BeuVMGEKaxUotnGHIeJ/60XdVyt+TrBOibWVbuEzucUkiSY9livj83VohG5HvUVUT/VKNDQG9QKRdNaX0E0DryGTQvtRqL/W29P0ZEs+J8yLJReIXaiDh5mlH6mVTfvUzKmPoCI2FmnhYeAT7t5YNr1t39bfGF9+wrPJL2ekzBNjcmHFwHnVKU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6a45d7-1d39-4d95-c153-08d6e92915a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 20:13:18.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5919
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/4/2019 11:44 AM, Anson Huang wrote:=0A=
>>>>> As exemple, this series implements busfreq for i.MX8MM whose=0A=
>>>>> upstreaming is in progress. Because this relies on ATF to do the=0A=
>>>>> frequency scaling, it won't be hard make it work.=0A=
> =0A=
> I have similar question as previous reviewer, is there any branch that we=
 can test=0A=
> this series?=0A=
=0A=
I've been looking at this and pushed a fixed-up functional variant to my =
=0A=
personal github:=0A=
=0A=
     https://github.com/cdleonard/linux/commits/next_imx8mm_busfreq=0A=
=0A=
It builds and probes and switches DRAM freq between low and high based =0A=
on whether ethernet is down or up (for testing purposes). The pile of =0A=
out-of-tree patches required to get this work is quite small.=0A=
=0A=
The DRAM freq switch is done via a clk wrapper previously sent as RFC:=0A=
=0A=
     https://patchwork.kernel.org/patch/10968303/=0A=
=0A=
That part needs more work but it could serve as a neat encapsulation =0A=
similar to imx_cpu clk used for cpufreq-dt.=0A=
=0A=
> And, from the patch, it has multiple levels description of fabric arch, w=
hile we ONLY=0A=
> intend to scale "bus" frequency per devices' request, here "bus" includes=
 DRAM, NOC and=0A=
> AHB, AXI, should we make it more flatter, such as just a virtual fabric a=
s a single provider, and then=0A=
> all other devices as nodes under this provider?=0A=
=0A=
The imx8mm interconnect bindings describe many bus endpoints but all =0A=
requests are aggregated to a single platform-level OPP which is =0A=
equivalent to "low/audio/high mode" from NXP tree.=0A=
=0A=
It might be better to associate clks to several ICC nodes and this way =0A=
scale NOC and DRAM separately? As far as I understand an interconnect =0A=
provider is free to decide on granularity.=0A=
=0A=
As a wilder idea it might even be possible to use a stanard =0A=
"devfreq-with-perfmon" for DDRC and have interconnect request a min freq =
=0A=
to that instead of doing clk_set_rate on dram directly. That could bring =
=0A=
features from both worlds, scaling both proactively and reactively.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
