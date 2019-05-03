Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA812CEA
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfECLwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 07:52:02 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:7078
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbfECLwC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 May 2019 07:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL9tHpfERm+wBemS2dF2mrgoaJJVNfuFwRvN38GFaCg=;
 b=SblWqdZQBBHEKgDz4gt32ZmACKLZpMcmp54X++vH0StVQ4jjtda8ww1gb4VBdyrZZQLrC1eBlRXprrMACCQ8xq98XrSxw1NB1BJJq1JbGR2+ucsrhsxT6nZuST4ouee2UAf/UttonZPcv8iS085KPhOZt9LplwYkOmeSpCFG3us=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6611.eurprd04.prod.outlook.com (20.179.255.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Fri, 3 May 2019 11:51:57 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 11:51:57 +0000
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
Subject: Re: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHVATiQtlzuIooEwkqEvC93VXXdZg==
Date:   Fri, 3 May 2019 11:51:57 +0000
Message-ID: <AM0PR04MB64343A9439DF8FA943BFE2D4EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <20190503065026.qwroewhu5lxckqgl@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7a28f38-3903-404b-9a00-08d6cfbdbedf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6611;
x-ms-traffictypediagnostic: AM0PR04MB6611:
x-microsoft-antispam-prvs: <AM0PR04MB66117A615FDD7AB9F1BF5922EE350@AM0PR04MB6611.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(305945005)(81166006)(486006)(476003)(8936002)(3846002)(256004)(33656002)(7736002)(91956017)(5660300002)(6116002)(229853002)(55016002)(446003)(6436002)(4326008)(44832011)(9686003)(99286004)(8676002)(478600001)(53936002)(52536014)(66476007)(66946007)(73956011)(102836004)(81156014)(64756008)(66446008)(7696005)(66066001)(76176011)(26005)(6506007)(53546011)(76116006)(66556008)(74316002)(71200400001)(2906002)(54906003)(86362001)(14454004)(6916009)(6246003)(68736007)(71190400001)(25786009)(186003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6611;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jZk7JGdsmdmpBrMH02tNS8OouJJhUj/qwQJg6Iv/DZ7UvEbRYfXvHzpI+xjDINHPQhwY0k21n7zmpkRN9AQIF41ETBpcAeuivT8d3tsnUzP8G9Wb+pwOAY4S/VQIU162I324dAOxxVINVMScVwKf8xu5gT3dET3TxB53S3oiaIcs/RhD+DrQP4ebU3TNmqX3sehxVgxvKr+cbUsjwMn7PZqyKUi2HVR+mWzsfAy2v6oBpOj/0DXjLIHDyDGeeBw3DcetD4MgLADUB2Rjht+67e3icKA6Hs2av1zrKuGrF8gmn81+PoBqo+xPB9udHFM0aW+ZLODSz2BoAzuhXekAVoX/cdqa2qKD70E0MCJrKtoMM20eR6bl4X6AsOEfZsujA209KtpO/h4s2vP64d729UpibTmC1Nu28raKpi7LjIU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a28f38-3903-404b-9a00-08d6cfbdbedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 11:51:57.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6611
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.05.2019 09:50, Viresh Kumar wrote:=0A=
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
>> It seems that cpufreq-dt insists on adding the opp and regulator itself=
=0A=
>> so can't actually call dev_pm_opp_of_add_table and then=0A=
>> dev_pm_opp_disable=0A=
> =0A=
> Well we can surely implement it someway if that is what you want, like we=
 can=0A=
> pass postinit() callback in platform data to cpufreq-dt which can get cal=
led=0A=
> after OPP table is added, etc.=0A=
> =0A=
> But disabling OPPs after they are added isn't a great way of handling it =
as=0A=
> well.=0A=
> =0A=
>> so implementation was switched to opp-supported-hw.=0A=
> =0A=
> I will say that this is far better than disabling the OPPs after adding t=
hem. So=0A=
> this is a good way of doing it.=0A=
=0A=
The intention seems to be that dev_pm_opp_disable is used at run-time =0A=
for stuff like thermal issues while init-time opp selection should be =0A=
done in other ways.=0A=
=0A=
Is this what you mean? It's not very obvious from API.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
