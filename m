Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFEFE4DF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfD2OjM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 10:39:12 -0400
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]:55918
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728253AbfD2OjL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Apr 2019 10:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kukXZhIjP/zz5+hf4N+Hw/S45uro0quH3sMR7x4XmlM=;
 b=HxKajFDSTI9yHQGaJFpKcwZsqxhvWCT7STOBKDN3yhOd3WXjo+TvoeGV17hrc/aajisxuraNq83qb/DRDhIS4g08r5MMe0VjPhviuZs9qB9h7UZZi1TIEQS0BiyGutXAM415wUDeuf4BMeMH9gA1ywH82CEUMoVTOYeBBTZkGC4=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6515.eurprd04.prod.outlook.com (20.179.254.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Mon, 29 Apr 2019 14:39:07 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::f56b:2fea:d9c0:7c2b%6]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 14:39:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
Thread-Topic: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
Thread-Index: AQHU/Hhau/GWEJEX5Ui7EZG6LbfZoA==
Date:   Mon, 29 Apr 2019 14:39:07 +0000
Message-ID: <AM0PR04MB6434B2BBECCA6B2644CDF044EE390@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1556313614.git.leonard.crestez@nxp.com>
 <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
 <CAPDyKFpCCapBfNbsR1Q+nyg8aenVJWxj9qmTCCCfmONZR3t1sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1e42ef9-d0f1-472c-4e96-08d6ccb06f81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6515;
x-ms-traffictypediagnostic: AM0PR04MB6515:
x-microsoft-antispam-prvs: <AM0PR04MB65157CF1A0B61B4F161AAF45EE390@AM0PR04MB6515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(26005)(91956017)(66446008)(66556008)(7736002)(305945005)(478600001)(6506007)(7696005)(6246003)(53936002)(76176011)(74316002)(102836004)(68736007)(53546011)(9686003)(229853002)(66476007)(64756008)(76116006)(73956011)(66946007)(52536014)(99286004)(316002)(110136005)(54906003)(33656002)(6116002)(3846002)(55016002)(66066001)(6436002)(14444005)(256004)(2906002)(4326008)(4744005)(5660300002)(486006)(86362001)(446003)(8676002)(476003)(81166006)(97736004)(186003)(44832011)(81156014)(8936002)(71190400001)(71200400001)(25786009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6515;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4PMhhZBiRwQK3VDe37Q9ndFfSYDXS0oU/zvHXI4iA2TUzqN4F7z9skyyHZPP/RTM/6zux5l51Lp2rORhBO3RjgMBYcq92sIHiv+fUE9e3Hu27KjyWFYvs1FnmggjpMOMAAkrqgB3RwpPyDQP9tjUV+8Wqw7YWi0fhNipWfcpIzLTQchm27INfNWUnAhHerbskgtri/VYwGT9xWy61NRV1vBU500Rvt99OrqcjgHFfOJ0QQY+iEExBbFrpklozVEVGP5kVroI1e/35hyMAFJHbOJhyo0tgOJ8nb9Rc8H44LRGnUDInx4ZRrtivM1LI4fkcIGIJlskcZ/lqFS82yp4L1fb7rLIwkKmFQU8GfT7RNuMZf3pK5M0OJAi4bXpYx/qKuIjptgBfo7XZcemshLDPl65YERL/HGubh3GBPwYSbY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e42ef9-d0f1-472c-4e96-08d6ccb06f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 14:39:07.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6515
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/29/2019 12:11 PM, Ulf Hansson wrote:=0A=
> On Fri, 26 Apr 2019 at 23:38, Leonard Crestez <leonard.crestez@nxp.com> w=
rote:=0A=
>>=0A=
>> This is for power domains which can only be powered off for suspend but=
=0A=
>> not as part of runtime PM.=0A=
>>=0A=
>> @@ -126,10 +126,11 @@ static const struct genpd_lock_ops genpd_spin_ops =
=3D {=0A=
>>   #define genpd_status_on(genpd)         (genpd->status =3D=3D GPD_STATE=
_ACTIVE)=0A=
>>   #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_=
SAFE)=0A=
>>   #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWA=
YS_ON)=0A=
>>   #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTI=
VE_WAKEUP)=0A=
>>   #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_=
DOMAIN)=0A=
>> +#define genpd_is_no_runtime_off(genpd) (genpd->flags & GENPD_FLAG_NO_RU=
NTIME_OFF) >=0A=
> May I suggest to switch the name to, GENPD_FLAG_RUNTIME_ON.=0A=
> =0A=
> Other than that, this looks good to me!=0A=
=0A=
Then it's easy to confuse genpd_status_on with genpd_is_runtime_on. How =0A=
about genpd_is_rpm_always_on?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
