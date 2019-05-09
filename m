Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB618763
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfEIJED (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 05:04:03 -0400
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:41968
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfEIJED (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 05:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvJEZvcf+/zKQ9BGas0DqEcVVrbh1g65utD51tDgLKk=;
 b=mFvhM2nQ5d4nR1OZ/i33zpQVpUzO2fEHfIzcB9g5J5AKTS4WeUuoVCd6zng2GYE/hIeLbqbGBbisDI1bXJuIlpd/j92I9Qsnl8lVflPkkbpXQXl8wnVQoQumBUbArF28YBkhmUdfY/QH1CLBL7AmOdB8xbdnpmGeWaYYQbkaYJE=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4276.eurprd04.prod.outlook.com (52.134.91.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:03:57 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.019; Thu, 9 May 2019
 09:03:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [PATCH v3 1/4] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHVBNwYbcAcEPdpgkaJW0PvBwINFA==
Date:   Thu, 9 May 2019 09:03:57 +0000
Message-ID: <AM0PR04MB64349B11B2A914F705B6D302EE330@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
 <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
 <20190508035402.7pbikzpkzxxesmlw@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71a42e18-3478-429c-edb6-08d6d45d4536
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4276;
x-ms-traffictypediagnostic: AM0PR04MB4276:
x-microsoft-antispam-prvs: <AM0PR04MB42761E359C3148878C04EA10EE330@AM0PR04MB4276.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(66556008)(66946007)(64756008)(66446008)(73956011)(66476007)(8936002)(68736007)(486006)(446003)(102836004)(52536014)(44832011)(7696005)(6506007)(26005)(76176011)(476003)(186003)(74316002)(53546011)(4744005)(99286004)(54906003)(33656002)(256004)(25786009)(71190400001)(55016002)(71200400001)(6436002)(6916009)(6246003)(7736002)(2906002)(53936002)(5660300002)(66066001)(3846002)(6116002)(316002)(8676002)(91956017)(86362001)(76116006)(81156014)(81166006)(14454004)(305945005)(478600001)(229853002)(4326008)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4276;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cnCCRj2TTFaxyOUTmxMW9/zuFaHrZlAb41wy8eShKBt4t9QV+/6XLNfrWjUDnMEk/3zBh3ux5ceNSeqeJqxllXcbBMneKVlV4Iu13niCPn8wQlRWevUNpEAh8U2zVMqJFNP4aNrz0nLgbpXaswllvYhcnznVS0IzzFGp0M3kwgj1jvYpf5bOQPjrHCMT8Syi7udl8M2oXaGGGiDWDkR7FRUepWnQ8nJByAuxPfht7F7DSTiuoVZsd3UVyKGZcqrtj2bCpT2Oav+pKMdXhBo+GCzZDVK1L2p78p0gqShOw2HFyDgF1OFBZs2n1H2nwnUZnJ+32B2JJ3aSf0F5SsZP4bZJb9pNsSfMkDL8wQFcTNfsutXyXs74of/vrcZ0f0SIUpYJy2t4ZyJ7EGCdj0GtaRwku6rUSkUwPUPLoL9cEfk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a42e18-3478-429c-edb6-08d6d45d4536
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:03:57.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4276
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/8/2019 6:54 AM, Viresh Kumar wrote:=0A=
> On 07-05-19, 13:52, Leonard Crestez wrote:=0A=
=0A=
>> +config ARM_IMX_CPUFREQ_DT=0A=
>> +	tristate "Freescale i.MX8M cpufreq support"=0A=
>> +	depends on ARCH_MXC && CPUFREQ_DT=0A=
>> +	default m if ARCH_MXC && CPUFREQ_DT=0A=
> =0A=
> As I said in the previous version, the if block above is redundant and=0A=
> not required.=0A=
=0A=
Sorry, I misread and thought you were referring to () rather than what's =
=0A=
inside.=0A=
=0A=
Is "default m" otherwise OK? It's a reasonable implication of ARCH_MXC=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
