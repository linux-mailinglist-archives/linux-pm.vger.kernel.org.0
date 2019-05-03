Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236EB12ADF
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfECJox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 05:44:53 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:33601
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfECJox (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 May 2019 05:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgjsFt9CS2wYblioVnW9GXVgsBc7Lxls5TP+tJdMSTg=;
 b=sY8KpSTvAH+KsyJjtsSLHvWgKlVYbYdgjOKkIUddQbWvK4OuaZUQG1ppEgdjPcndRTJ4j5hNm/07/y54CtrZpFkz9iiJsA5UvZqsW920N56EsXi7WymjKnSnZh3nTJPlQshfDVBJ8NdjodaoezXEDfmNeskblwmksBQpTS+aLJc=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5026.eurprd04.prod.outlook.com (20.177.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Fri, 3 May 2019 09:44:48 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 09:44:48 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [PATCH v2 1/3] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHVATiRBI3TxTCIzUmxtrShT8luGA==
Date:   Fri, 3 May 2019 09:44:48 +0000
Message-ID: <AM0PR04MB64345196835732B019F1D885EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <df3a41d8bf57b8dd8f8c17599eeca98d6e43962c.1556836868.git.leonard.crestez@nxp.com>
 <20190503065227.afqgmylbjwhg2mc3@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02c6117b-65d7-47bf-3a3f-08d6cfabfb72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5026;
x-ms-traffictypediagnostic: AM0PR04MB5026:
x-microsoft-antispam-prvs: <AM0PR04MB502644CF3D3FD5305C9C076BEE350@AM0PR04MB5026.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(102836004)(6506007)(81166006)(186003)(229853002)(446003)(3846002)(81156014)(71190400001)(7736002)(476003)(53546011)(486006)(5660300002)(6116002)(71200400001)(8936002)(14454004)(66556008)(66066001)(64756008)(44832011)(73956011)(66446008)(66946007)(6436002)(66476007)(76176011)(7696005)(6916009)(8676002)(99286004)(55016002)(478600001)(305945005)(91956017)(316002)(26005)(6246003)(52536014)(86362001)(4326008)(76116006)(68736007)(53936002)(256004)(9686003)(14444005)(33656002)(54906003)(74316002)(2906002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5026;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +3SbIyqczB4WcVuMTIx7eEqlwDW7paAcWNyhRKdjgHVfhIHl1BNQW2ujWUqcRAyy12ipAxyujYyGzCGyUq26zgFGQymSWu1Fe10zAJFYKFOaEzM2FZFSSB1WfyUJWs+OBbyI5a4lTBMo+Hh9A3w7cjsbJxpmsMHgzB8gFRBMQWnLvEXfln0Bk8K43ByVkxyyVakAiHcQQ8MBo47RSU7WmYosv05L/pcnqaESoV97pJvTuODz9rMlCwtk663zrIbY1p/6sMKgzH9H1ZAF44zJ9swN4oljmzFOy+ZWfSze/x1xz+5iFPYPBiII4DWQ4SvnJxE8myGkMqYeJZilQ5QsRNE979bo4okNJ6o0Tmmeep+UPSe9KfI76412DIA1V/6RM+SCpgA9QNzdQ5hbWOGLP/7qhdaquxvWuERv9q8Sncw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c6117b-65d7-47bf-3a3f-08d6cfabfb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 09:44:48.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5026
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.05.2019 09:52, Viresh Kumar wrote:=0A=
> On 02-05-19, 22:44, Leonard Crestez wrote:=0A=
>> Right now in upstream imx8m cpufreq support just lists a common subset=
=0A=
>> of OPPs because the higher ones should only be attempted after checking=
=0A=
>> speed grading in fuses.=0A=
>>=0A=
>> Add a small driver which checks speed grading from nvmem cells before=0A=
>> registering cpufreq-dt.=0A=
>>=0A=
>> This allows unlocking all frequencies for imx8mm and imx8mq.=0A=
>>=0A=
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm=
=0A=
>> @@ -90,10 +90,20 @@ config ARM_IMX6Q_CPUFREQ=0A=
>>   	help=0A=
>>   	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.=
=0A=
>>   =0A=
>>   	  If in doubt, say N.=0A=
>>   =0A=
>> +config ARM_IMX_CPUFREQ_DT=0A=
>> +	tristate "Freescale i.MX8M cpufreq support"=0A=
>> +	depends on ARCH_MXC && CPUFREQ_DT=0A=
>> +	default m if (ARCH_MXC && CPUFREQ_DT)=0A=
>> +	help=0A=
>> +	  This adds cpufreq driver support for newer Freescale i.MX series=0A=
> =0A=
> "newer" is a relative thing, it won't be newer an year or two later. Just=
 drop=0A=
> it.=0A=
=0A=
I meant "newer than i.MX6". Various attempts at adding explicit cpufreq =0A=
drivers for newer SOCs were rejected in favor of cpufreq-dt.=0A=
=0A=
I'll change to mention i.MX8M explicitly and update if 7 is added.=0A=
=0A=
>> +static struct platform_driver imx_cpufreq_dt_driver =3D {=0A=
>> +	.probe =3D imx_cpufreq_dt_probe,=0A=
>> +	.remove =3D imx_cpufreq_dt_remove,=0A=
>> +	.driver =3D {=0A=
>> +		.name =3D "imx-cpufreq-dt",=0A=
>> +	},=0A=
>> +};=0A=
>> +module_platform_driver(imx_cpufreq_dt_driver);=0A=
> =0A=
> Why add another virtual device-driver pair here? The only reason why we h=
ave=0A=
> been adding it was to get deferred probe to work which doesn't look like =
the=0A=
> case for this driver. Why not do everything from the init() routine ?=0A=
=0A=
The imx-cpufreq-dt platform_driver reads from fuses (nvmem/imx-ocotp) =0A=
which can be theoretically be built as a module and also has clock =0A=
requirements. No sure we should rely that the call to read from nvmem =0A=
never returns EPROBE_DEFER.=0A=
=0A=
I'm not sure which "init()" you mean, the registration code is inside =0A=
soc driver and at that point the fuse driver might not be available.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
