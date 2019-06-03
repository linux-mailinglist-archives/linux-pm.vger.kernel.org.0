Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAE3290B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFCHBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 03:01:50 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:54410
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfFCHBu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Jun 2019 03:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cTcybyy/laTx8Fnxm++C1AasKL6tShPyWsyaIHDJjQ=;
 b=XSTxrHG4x96GQCnVTfRDaJe/UErlcFKpM3UqeNGGVVzLHyATBAwBlDy2e6b/ul7misDNg9WkBkF+F08BMO+EJx7HYbko4H8EVZrGtvVqYsHfaBqXBA0UUe9tEorwEniY5CX6GrxVBqf0Vyu8dnT22234w733+3HNmm71+mVomN4=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5934.eurprd04.prod.outlook.com (20.178.205.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Mon, 3 Jun 2019 07:01:41 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 07:01:41 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] cpufreq: Switch imx7d to imx-cpufreq-dt for speed
 grading
Thread-Topic: [PATCH 3/3] cpufreq: Switch imx7d to imx-cpufreq-dt for speed
 grading
Thread-Index: AQHVFhaPrvUUJ34dakS8wduWS4Ia3Q==
Date:   Mon, 3 Jun 2019 07:01:41 +0000
Message-ID: <VI1PR04MB50551BDB2D0AA64D7192D98CEE140@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
 <8787934ff35e7e55837f2caabc0d5bf65828d971.1559131365.git.leonard.crestez@nxp.com>
 <20190603053850.tkskdzcloir4k3kw@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 833eb814-1d3e-47ed-f24f-08d6e7f154de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5934;
x-ms-traffictypediagnostic: VI1PR04MB5934:
x-microsoft-antispam-prvs: <VI1PR04MB5934AD7F403112BF93505CC8EE140@VI1PR04MB5934.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(6916009)(6116002)(53936002)(25786009)(476003)(68736007)(44832011)(102836004)(53546011)(446003)(5660300002)(486006)(76176011)(3846002)(6506007)(86362001)(7696005)(316002)(4326008)(66946007)(8936002)(81166006)(99286004)(26005)(64756008)(66556008)(66476007)(73956011)(66446008)(91956017)(76116006)(54906003)(7736002)(74316002)(8676002)(81156014)(2906002)(305945005)(186003)(14454004)(478600001)(52536014)(229853002)(66066001)(256004)(71200400001)(71190400001)(33656002)(6246003)(6436002)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5934;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a6JFrAJb2Seq5vkcv0+KypBdjvTTuvafsNAOfrMHKyzJyHcscVxpkJZCjETdjkXnb+d4nPJf7o5MFwq6PyAs+3veL71pHn/5MrTnTUTTh1f/BMb/dJSbr+fwl0lqyBXyhFR7n0QUENebcAYnwcPcIYzXZKCR0qeMkM7tGyeixCkvTpwGCcQgSEBCvDBVA8IFRr8fZuQIt8jvTpm3zu1jSJ8LQ5M1KTDxa9Nt/8YD5pAyQIObRIp4PbeFj3HsHnE7bmwk0LyHYGRpz595WqkfC3eb6or7ELSkoT3TIizqwAZQkNZ5Z2KeMjfKmxLqhsHTrlszJP2HkForvr6BZ9cTwzMKfeLqG+8Zc/9T+nI28TS8sqtZ9zufjJoADy8xgjYbierbjJ01EKTXo+pAB2StF3r5u19Xh4d6MsCQBZgTatQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833eb814-1d3e-47ed-f24f-08d6e7f154de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 07:01:41.5526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5934
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/3/2019 8:39 AM, Viresh Kumar wrote:=0A=
> On 29-05-19, 12:03, Leonard Crestez wrote:=0A=
>> This driver can handle speed grading bits on imx7d just like on imx8mq=
=0A=
>> and imx8mm.=0A=
>>=0A=
>> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpuf=
req-dt.c=0A=
>> index 5061503cb0a1..ce26ffc18ce6 100644=0A=
>> --- a/drivers/cpufreq/imx-cpufreq-dt.c=0A=
>> +++ b/drivers/cpufreq/imx-cpufreq-dt.c=0A=
>> @@ -18,10 +18,11 @@=0A=
>>   #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)=0A=
>>   #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6=0A=
>>   #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)=0A=
>>   =0A=
>>   static const struct of_device_id imx_cpufreq_dt_match_list[] =3D {=0A=
>> +	{ .compatible =3D "fsl,imx7d" },=0A=
>>   	{ .compatible =3D "fsl,imx8mm" },=0A=
>>   	{ .compatible =3D "fsl,imx8mq" }, >>   	{}=0A=
>>   };=0A=
> =0A=
> What is the purpose of this array and can we get rid of it instead ? I am=
 asking=0A=
> as this driver gets probed only if the platform code has created the=0A=
> imx-cpufreq-dt device and it shouldn't get created for other machines tha=
n what=0A=
> is supported.=0A=
=0A=
Maybe it will be useful in the future to add .data here if a chip starts =
=0A=
using 3 speed grading bits?=0A=
=0A=
It can be removed for now.=0A=
