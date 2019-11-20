Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8185C103DE9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfKTPEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:04:36 -0500
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:33239
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728864AbfKTPEf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 10:04:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvZBEOj9A8ZJe7OxuzxfXhf2HGU2KVVLoslwRe2fHSOjmOPwA7mB4i638SlBuq/iNHJ7CD6Dh1ZMH8ah4Q6X7FKBfHUcQrhb2RLQUgVMG2/tu/Oc7Q5Um7gZHEZ3Ts8oKBbDedVgHhJxBfWEk0wFDPOBzksbkRfWEVI3KYykvdkqmnjgDCKSc8DAosl162249n5rjzS27UXzd0+0bGBtqYQ6Jo2tZnUT0vqk/Nup0GTHJExB9kZyCc91SNOPoiNHM8fDRC26uvtTj+Zk2YxV+UNwAiZvanX0q3MvK1Wz3Q0jE04exdvBg8qR7T1fc8m6jxyKGOcKcuh8KZYy0Yt6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEy6VFUqKO7/sYosT1DOO4YdjRu9+pCyq6qi30pzkJM=;
 b=d3/NWg0XgQ4HNzAnP6v4U/0Cwih+27LKT2N3IiQj0zsCcBmyJAj3HGbfkC/7FQ10JhfwUpl1+NfxWO2yIh4iDqIz8HZh4lJeDDxDHQDF4ssdB0FUZUsbpjhAwMqh/HyU+hhg8pHAP6fdWulNo6MoXISkOGngy3NiqBifP4trp6ldJL5XEKybMviKwbSoyL8v8cgtKtb72zllbnR6QwPpD20mSTBmtX7rJXrBTukDnk3yAu8bXAi4sL5bBJp+QpmrC66SYI0LVmBx3DDpIgulPgS5JLbWIbplBeCqzqW2CzKH5zbeto0E6n7XJK8DZcIjy0Ikxj/zZjvh7K5gFfBTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEy6VFUqKO7/sYosT1DOO4YdjRu9+pCyq6qi30pzkJM=;
 b=rb/aD47ws1jXCG/NX5+jrG2H25W3jThjsBfeJh0FBRkTnTme79aYopEdftLklmDlGEE4oEri3uUms2Xk3kJ65o+iRn9Wh4gyNltDMYkNGwMX56x3gaz3b7X3acHH+0lmXxwzHsquemDQ37ZkELwPJ0eKQ2fqajxVJd9Zhakbq7Y=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.50.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 15:04:32 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 15:04:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Angus Ainslie <angus@akkea.ca>, Jacky Bai <ping.bai@nxp.com>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
Thread-Topic: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
Thread-Index: AQHVmyeZDID07b0oVkajwef04uXjmg==
Date:   Wed, 20 Nov 2019 15:04:32 +0000
Message-ID: <VI1PR04MB70233920AC838AD88E1ECC26EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <e311a376e6aec0c380686a7e307d2c07@akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76422b5a-e3d6-4c9d-6d68-08d76dcaf2eb
x-ms-traffictypediagnostic: VI1PR04MB4718:|VI1PR04MB4718:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB47189C8781A6263B17FED9D2EE4F0@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(74316002)(7416002)(6436002)(2906002)(54906003)(316002)(44832011)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(186003)(26005)(4001150100001)(6116002)(3846002)(76176011)(102836004)(4326008)(110136005)(486006)(7696005)(14454004)(6246003)(52536014)(53546011)(6506007)(305945005)(66946007)(86362001)(476003)(8936002)(14444005)(229853002)(966005)(33656002)(6636002)(81156014)(81166006)(7736002)(478600001)(5660300002)(99286004)(6306002)(8676002)(66066001)(71200400001)(71190400001)(25786009)(9686003)(55016002)(256004)(446003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4718;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4t9P8Z3aFxX5EcO4ALXEBZPaUZor2gZYEpscTDDgem7/UOhpzhkZFJ5DY8fzbA9jlvAFmPC9Gy/YOQbMJsJjWxZlwhKHTImExQiIjXKzYthwUvKn8uJ6X02RIlHbqk5DkIZ7Rg6O6NhEpcToHpaJNFTqmEZ+6IWOAhdUoi/SePHUD4Pde/S93vCQcI6W3ekrqar50K9tf9N2jhS+3TjPYsusaMdOEsRIr9bTyCmdOVS9rtQaIc6rE+dWS5Hv4NEwBAcbznOi5r6n3NuwZyKeXcQXBSa8gv8/uFv7eeCQzyqIrdr5wXgkvn8bsKSeN4YGPJaHH0U64u6Og9wJV4oBC03Tj0msoxEiYLGletRtXTlkCcw91dufityJuiWD0jGukOAqGdleP3u5VjvLxTM6OOCoW6aDWSXI0bZ0hqws+Rb1cCs+9S2wA4w2/VcObb3npFOz3+kh7xnK1h63rl2qgppSRQxLtEl86JXDyyw1uL0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76422b5a-e3d6-4c9d-6d68-08d76dcaf2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 15:04:32.1167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDF2fscqIc315saebDGbAjIwgXlvoVO4xN0KhIpPFadaQQdPPiobu2MZVKfWB1sNOIdmdL6okQRR7VE04p3VOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.11.2019 16:08, Angus Ainslie wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 2019-11-14 12:09, Leonard Crestez wrote:=0A=
>> Add initial support for dynamic frequency switching on pieces of the=0A=
>> imx=0A=
>> interconnect fabric.=0A=
>>=0A=
>> All this driver does is set a clk rate based on an opp table, it does=0A=
>> not map register areas.=0A=
>>=0A=
> =0A=
> Is this working with mainline ATF or does it still need to be used with=
=0A=
> your modified ATF code ?=0A=
=0A=
This series doesn't perform SMC calls, that's done by the imx8m-ddrc =0A=
driver: https://patchwork.kernel.org/cover/11244283/=0A=
=0A=
This particular patch allows switching NOC frequency but that's just =0A=
clk_set_rate.=0A=
=0A=
DDRC frequency switching requires the imx branch of ATF (v2.0 + ~200 =0A=
patches) otherwise you will get probe failures. Source for imx atf is =0A=
published here: https://source.codeaurora.org/external/imx/imx-atf/=0A=
=0A=
For your particular 8mq B0 case slightly different setpoints are used =0A=
and the fix is not in any public release yet so you need this:=0A=
=0A=
https://github.com/cdleonard/arm-trusted-firmware/commits/imx_2.0.y_busfreq=
=0A=
=0A=
Is "mainline ATF" an important criteria for Purism?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
