Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075038ACE9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHMDCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 23:02:37 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:38464
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfHMDCh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 23:02:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+PGLgAZXB53PYrZ1HGtCKWUJAfMyP/fxoPgjXwNRjDIGI2SXpaoWcPxKTuR8BjsgTRES/CZWnBDTfpSqmmU5Qd1lnQF3jreb2xpW6xUYE4VYLFnnT7vMV5MKC0eetZ4LUWDiUI2QzbE8qQWNOkkqT3WnothRwsj4l5+vuLg7YGhQ57qs07fy/CjL44zZIpat/6Rhgj76GMOQMLz5uCSIE0CEeMuc1VyvnGlHpbbeSQfNyEExzpl9qFZawbXx0oL+SZMQNLV9Y5ERLgb7+WWHPQZZ3NhTRCWxrMoAcKYPHHLFPdCVpiF5bCB+kCdr0NbcpRrE/LX5xiPxlDMTFEH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amZvjLJBrshvm4Udxpp/gtStDQG++4jpFLEWjjBh5Lk=;
 b=fJojtRXU0kSOkwHfEL638o2uW9GbbSI8ZFUvJkwo+1MFc7EF/0vM8kxEdD1+aoLxxmP4rPxUXf7ta2PUGjOqywd2vnfUbAuVfB0Jq+vv34lWCQjfpUrd4qeMzRS108kBJKgAM8QSFL4dOJe2wEwB76+ZoSCrZCjyJic3AZyPNmuL1RBRYLi/nN4d+HHs5lBTbm+1BZkBo5GAPZg1fRUMTF4SbCZfYNz3jCI9g9kt02Am32rtaKYpevNLsI2NjnjDOeIisdBPfA1N8NXQ74eevZx2wFBQoKta9wrPnWhv6YKroUAY/V6zvh242VkCvOa9NvcMAtnmLquFNmggpf776Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amZvjLJBrshvm4Udxpp/gtStDQG++4jpFLEWjjBh5Lk=;
 b=Y+mFz0LiS0Cxp6PX7eYHPgI1Cizo5ZxghziWlkxgY4+Kdyp/UmFaCWg3rzk1+/VUa3EUg1nsTEPZg9fWGvAP50lUndEEQoPT/IJ9C09AtkZnIfpnb1Y0ROb6X4l0ccDF+mL9CVS/zjgOvNJeOago6f+scXmv1lP3n9PjBp+l9wo=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4445.eurprd04.prod.outlook.com (20.177.55.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Tue, 13 Aug 2019 03:02:32 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970%2]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 03:02:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur Swigon <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/7] PM / devfreq: Add generic imx bus driver
Thread-Topic: [PATCH 3/7] PM / devfreq: Add generic imx bus driver
Thread-Index: AQHVUT6/NClFZjcCl0WOnsdNWPX55A==
Date:   Tue, 13 Aug 2019 03:02:31 +0000
Message-ID: <VI1PR04MB7023485353FCBBD7F8BEE8F3EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <dbdd1ae60993d5fe73ce5b446b2c7d559c981cf1.1565633880.git.leonard.crestez@nxp.com>
 <cover.1565633880.git.leonard.crestez@nxp.com>
 <CGME20190812185005epcas3p10a9a3dbb90489534222e093c63f27900@epcms1p3>
 <20190813023338epcms1p307caf6727399e9f3e320b965fb95a603@epcms1p3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a3bf337-1683-4c9a-9b11-08d71f9aaf51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4445;
x-ms-traffictypediagnostic: VI1PR04MB4445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4445582CCC325D2E79ACE7F5EED20@VI1PR04MB4445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(66946007)(53936002)(71200400001)(478600001)(81156014)(110136005)(71190400001)(7416002)(81166006)(99286004)(316002)(64756008)(76116006)(91956017)(66446008)(54906003)(9686003)(229853002)(6246003)(66556008)(66476007)(5660300002)(55016002)(6436002)(8936002)(86362001)(2906002)(52536014)(4326008)(26005)(102836004)(4744005)(256004)(74316002)(14454004)(305945005)(7736002)(186003)(33656002)(6506007)(25786009)(2501003)(7696005)(6116002)(76176011)(3846002)(476003)(66066001)(8676002)(486006)(44832011)(53546011)(446003)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4445;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lqUfeRrqDsAxKEiiS9w0zrHbWgVbH2wqp7WEk+hQq5h2CmZigGFFG+vB0gdECWiHBCdu0egnWtZdse3oPXgQF2YVSaAOipmzfZVqECfi6KcMbV/dyjiLf4JqdWcnJ0/NGadoWni8BCobix70vqKrR1Nu/Ry5FDiOSYepadMwJJhLBaYDx+T6kvKvphF+ihSnMP9k8YBUA78l2I8RTz+psu97s8/m59srp8sveE+MIDgNK1breRzUawWYwxJXy81hz5c6d/4vYJaa82gdHJOiK4C8PdjMRpExv/FJbKIYYDFpROBbXnV1tPaDvAmZqMc35G4Oc8fTAv9Ec8BL3tLMgXhxmGEzR8p4osNhaS+n393Z+f3XGr6lmUCy52CqCkW7CwUUMJ69QXQ6HFemREl5gX98M5xaf18ZE3ugjod/11s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3bf337-1683-4c9a-9b11-08d71f9aaf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 03:02:31.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0aHh/Ym4ijfXC6hOmdtcAflDZmettUtAPPm9ioVNRXECQPYEsEx5IyLnjNFTz5s7a1wCHHZnBkL9rlT9XOiBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4445
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/13/2019 5:33 AM, MyungJoo Ham wrote:=0A=
=0A=
>> Add initial support for dynamic frequency switching on pieces of the imx=
=0A=
>> interconnect fabric.=0A=
>>=0A=
>> All this driver actually does is set a clk rate based on an opp table.=
=0A=
>>=0A=
>> +config ARM_IMX_DEVFREQ=0A=
>> +	tristate "i.MX DEVFREQ Driver"=0A=
>> +	depends on ARCH_MXC || COMPILE_TEST=0A=
>> +	select DEVFREQ_GOV_PASSIVE=0A=
>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND=0A=
>> +	select DEVFREQ_GOV_USERSPACE=0A=
>> +	select PM_OPP=0A=
> =0A=
> Does it support ALL ARCH_MXC SoCs?=0A=
=0A=
Only imx8m currently but out of tree we support bus+dram frequency =0A=
switching for ~10 imx6/7 SOCs, all other than imx7ulp.=0A=
=0A=
When imx8 was upstreamed as the first 64-bit imx chip the arm64 =0A=
maintainers told us to drop stuff like ARCH_FSL_IMX8MM so there is no =0A=
per-soc kconfig more specific than "ARCH_MXC".=0A=
=0A=
I guess we could make it depend on (ARCH_MXC && ARM64) but the ARM64 =0A=
would eventually be dropped anyway.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
