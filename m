Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF6861D7C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfGHLEF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 07:04:05 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:57155
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727517AbfGHLEE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 07:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFpji26yOGrSjsAttjgL2sci4oAQyZkxB6UNZpzENkI=;
 b=kUdxhT/l+uJRV5xCmrJgx287l7BoQnWWwO0QmoUVLizh0I1jPS65Q3BvTX+tjGf8mI4oiO1AvUmslb421WjlFkEXV098NznWetNcTIkbkBwsyjaoieUOQNHlevdmAY3xfROikg1iSwgxnLgbD3ucStERlT/7r7NpqF8iOW2lG/o=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5136.eurprd04.prod.outlook.com (20.177.50.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 11:04:01 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2052.019; Mon, 8 Jul 2019
 11:04:01 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Assign max supported frequency
 as suspend frequency
Thread-Topic: [PATCH] cpufreq: imx-cpufreq-dt: Assign max supported frequency
 as suspend frequency
Thread-Index: AQHVNWKKfVJcms96j06437RrlyrVzA==
Date:   Mon, 8 Jul 2019 11:04:01 +0000
Message-ID: <VI1PR04MB5055565FFF1241B61B47F22AEEF60@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190708074624.910-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a118af2f-cab3-40f6-b412-08d70393fbd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5136;
x-ms-traffictypediagnostic: VI1PR04MB5136:
x-microsoft-antispam-prvs: <VI1PR04MB5136CA6473C9EBF43909DEE1EEF60@VI1PR04MB5136.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(76116006)(91956017)(66946007)(73956011)(71200400001)(71190400001)(33656002)(66446008)(64756008)(66556008)(66476007)(66066001)(86362001)(52536014)(5660300002)(7416002)(55016002)(9686003)(305945005)(446003)(486006)(74316002)(476003)(6116002)(478600001)(68736007)(7736002)(53936002)(3846002)(6436002)(8936002)(4326008)(81166006)(25786009)(229853002)(8676002)(81156014)(14454004)(102836004)(14444005)(15650500001)(53546011)(316002)(7696005)(26005)(2906002)(6506007)(256004)(76176011)(54906003)(110136005)(186003)(2501003)(99286004)(44832011)(6246003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5136;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CQVNjzs9p6teEmSCfF9SvgX65rZGVuKpXKT2r7muCeBnkJq+INo0WFEesSOBGezWQGZEag1oI7MXu2LxC+DbgL1v2VmzdqPuEfMl4929wZXRCWLRkhxlVZsaQMMZxtWMJ3GKw/L+n8vH9F8WVjEN1Lgx6zirxUUiD5cQYnS+TsS6bLs8nGMMYy4untTFamQ7pDxnSYWn8mARvJ9n0IxakErc1AlSNqliTB4ITc9RabQzFB/5gLrhoSfKQVmyXNk20W09OyhK1O5MilXZIaQzOLilJEo7ZeDDjjC2ssm8CKfpMr6hxbNK/TISN7uw2tjA9qfN378xMDF2d3EukC4Iq/d2EwIELBo8kRd9sfF5Y8aYW2BsYHDLhG0VSaZQvT2NJ0Ejj9rjolN3qFXkdu7UEpOIs937qsm+35R66m/ynU4=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a118af2f-cab3-40f6-b412-08d70393fbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 11:04:01.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5136
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/8/2019 10:55 AM, Anson.Huang@nxp.com wrote:=0A=
> To reduce the suspend/resume latency, CPU's max supported frequency=0A=
> should be used during low level suspend/resume phase, "opp-suspend"=0A=
> property is NOT feasible since OPP defined in DT could be NOT supported=
=0A=
> according to speed garding and market segment fuse settings. So we=0A=
> can assign the cpufreq policy's suspend_freq with max available=0A=
> frequency provided by cpufreq driver.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufr=
eq-dt.c=0A=
=0A=
> +static int __init imx_cpufreq_dt_setup_suspend_opp(void)=0A=
> +{=0A=
> +	struct cpufreq_policy *policy =3D cpufreq_cpu_get(0);=0A=
> +=0A=
> +	policy->suspend_freq =3D cpufreq_quick_get_max(0);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +late_initcall(imx_cpufreq_dt_setup_suspend_opp);=0A=
=0A=
The imx-cpufreq-dt driver is built as a module by default and this patch =
=0A=
produces an error:=0A=
=0A=
In file included from ../drivers/cpufreq/imx-cpufreq-dt.c:11:=0A=
../include/linux/module.h:131:42: error: redefinition of =91__inittest=92=
=0A=
   static inline initcall_t __maybe_unused __inittest(void)  \=0A=
                                           ^~~~~~~~~~=0A=
../include/linux/device.h:1656:1: note: in expansion of macro =91module_ini=
t=92=0A=
  module_init(__driver##_init); \=0A=
  ^~~~~~~~~~~=0A=
=0A=
As far as I can tell late_initcall is not supported for modules.=0A=
=0A=
Viresh: "max freq as suspend freq" is something that could be useful for =
=0A=
other SOC families. The hardware can suspend at any freq; it's just that =
=0A=
the highest one makes sense because it makes suspend/resume slightly faster=
.=0A=
=0A=
Could this behavior be pushed to cpufreq-dt as a bool flag inside struct =
=0A=
cpufreq_dt_platform_data?=0A=
=0A=
Only a few other platforms use this, most others pass NULL like imx. But =
=0A=
passing custom SOC-specific flags to cpufreq-dt makes a lot of sense=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
=0A=
