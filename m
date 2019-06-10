Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11A53BF3C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 00:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfFJWNY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 18:13:24 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:59108
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387661AbfFJWNY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 18:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcs426KQQT8AXDvvtK2FT5l7jebrfloU1FwB22/C1sQ=;
 b=geYhGqRKcQd+2eoPyG0Dbno3r1z0JJ2TLeVU1oRhoBqpStCu2xDeo7jvP1uYDFtO2H3apxpqHzym0gnLtcKa/I83K8aOakZhuDcZQL+0t09pEK0uxBR1aCAgATT9qTpxGhzstuzprEEbVN49intuOFhMMeuL04f7Y58sWgPZT08=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5903.eurprd04.prod.outlook.com (20.178.205.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 22:13:19 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 22:13:19 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Anson Huang <anson.huang@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] devfreq: Add generic devfreq-dt driver
Thread-Topic: [RFC] devfreq: Add generic devfreq-dt driver
Thread-Index: AQHVG5qgW7bYhI77qEiHOX6sZ3/rjQ==
Date:   Mon, 10 Jun 2019 22:13:19 +0000
Message-ID: <VI1PR04MB50558EF0387824D6AAEEB18EEE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <e48d7e3d71166cea20c3c200300e0ffa6d26d085.1559737589.git.leonard.crestez@nxp.com>
 <20190606031526.xknv5qdoqufim6tr@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ffef28a-33dd-4d16-dfde-08d6edf0d81c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5903;
x-ms-traffictypediagnostic: VI1PR04MB5903:
x-microsoft-antispam-prvs: <VI1PR04MB5903257E21B0E87A5AE2BB5EEE130@VI1PR04MB5903.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(8676002)(73956011)(68736007)(66556008)(6506007)(53546011)(66066001)(6916009)(102836004)(81166006)(7416002)(66946007)(81156014)(229853002)(53936002)(99286004)(7696005)(66446008)(66476007)(76176011)(64756008)(33656002)(74316002)(6436002)(14454004)(54906003)(478600001)(71190400001)(71200400001)(256004)(76116006)(91956017)(8936002)(9686003)(55016002)(305945005)(3846002)(6116002)(186003)(25786009)(5660300002)(44832011)(86362001)(52536014)(26005)(6246003)(486006)(4326008)(446003)(316002)(2906002)(7736002)(476003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5903;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BN0YsFUwBdM0S7X5dzwFSkrOD83UGMpiTsNBh0I+3GSjbFUcPLGcLNiI2i+2rW86dFlRk+0RAl58CLByRW50oavKZNkMEFgYMyEoTMcfpN9TfOW9MyXoLZkpwRyGJULM2Lyisz2DLD+3j3fHUS7y9cErtyX3LLWjEyMYjrMhLYD7R/29HgGoOBKyfWzbQDxBXGOsVeQDDyhorjWz4LhJzkKXXOPvXqFzTM+j8Pg4/YHeHDybF/e7KlpNBTSXfVa5BK3TCjL7mSO/8u4yLS5rhr/DKHpO5gCA1mMlydK0Bqlsyl4u39cXljEcZo9IGl9PjteOwQFpcEvbL7Ip1fDGjKnVUDMJ4NGJH/ejMdhhBaHjLvFoVGMFVfXSkSXKi9KkA0GdGAUDHUnlbQm5t/BdaeT7ofPTC7h4d8SoSMQjSEo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffef28a-33dd-4d16-dfde-08d6edf0d81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 22:13:19.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5903
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/6/2019 6:15 AM, Viresh Kumar wrote:=0A=
> On 05-06-19, 15:31, Leonard Crestez wrote:=0A=
>> +static const struct of_device_id devfreq_dt_of_match[] =3D {=0A=
>> +	{ .compatible =3D "generic-devfreq", },=0A=
>> +	{ /* sentinel */ },=0A=
>> +};=0A=
>> +MODULE_DEVICE_TABLE(of, devfreq_dt_of_match);=0A=
> =0A=
> DT can't contain nodes for any virtual devices, this will have similar=0A=
> problems to cpufreq-dt. How is this driver going to get probed ? Who=0A=
> will create the device ?=0A=
=0A=
CPUs are special devices, I'm not sure the same issues apply here.=0A=
=0A=
If a SOC has multiple buses or frequency domains which can be scaled up =0A=
and down then those can be treated as "real" devices and probing them =0A=
from DT seems entirely reasonable. DT could look like this:=0A=
=0A=
+       noc1 {=0A=
+               compatible =3D "fsl,imx8mm-noc", "generic-devfreq";=0A=
+               clocks =3D <&clk IMX8MM_CLK_NOC1>;=0A=
+               operating-points-v2 =3D <&noc1_opp_table>;=0A=
+       };=0A=
+=0A=
+       noc1_opp_table: noc1-opp-table {=0A=
+               compatible =3D "operating-points-v2";=0A=
+=0A=
+               opp-150M {=0A=
+                       opp-hz =3D /bits/ 64 <150000000>;=0A=
+               };=0A=
+               opp-750M {=0A=
+                       opp-hz =3D /bits/ 64 <750000000>;=0A=
+               };=0A=
+       };=0A=
=0A=
Instead of a "generic-devfreq" fallback the compatible list of =0A=
devfreq-dt could contain a large number of unrelated compat strings. =0A=
This would be vaguely similar to the white/black lists from cpufreq-dt-plat=
.=0A=
=0A=
There aren't really that many devfreq implementations so perhaps it's =0A=
not worth generalizing very much. I should rename this to "devfreq-imx" =0A=
even if there's nothing imx-specific inside it yet.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
