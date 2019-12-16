Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC91208BC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfLPOfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:35:47 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:63393
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbfLPOfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPcO1pLSu4ZkjnyYYNStIlQ47w8CAN9kHnaHlNaCJeAU+0ReIYMwxHrlvTPKV1j0AEvriqDuV5oUJmJvCrU0tlnUtyUv+HEMfo2SePPr3i4L0CcntdmnTn73yMV27T2ko/jSmmxSsjit0MmX4Fx3oKX+ewojnU1h8Mt6Mu8OG1BXiewFq/C0/mPihaePmzozWeagme3mwOLE2YqYrbJ8633weOZm1MVne4RLf3Y45LDv3m9G1KaTodcA6h16ofofl2rUm98r8ST9dHNRBOMebnTx44/8E0NYE/uUHC8de8NggPJyXVvZe283pWoOOoLXobCDFaEoPMSSE1xbySzsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxaAqFX80L1buzhWJZDDzjc1AnduXYvz5s91FeSRXxU=;
 b=ULpIs7Xv4mXlqUrA9WqS/b/jid5mUEOxdrAD+pnFv3DcZzUS6nZLs/dp/PTeKkPrLuo+Qi6OJqJ5xxz92H2JYGq90SmotdDN7cGSgbe8gcNrteQhO6ppwLJ3ScXPi6y1onymPSjSKGd7Tti884qPryN4UM9o7wJbkrCQgc/vqvUHEKw4PreeR7QBEzlKDu0ZHF/3I6Cp+/Juq92CudQdrH9hXakgAshdOLuV0t/ZztCEdI3OxCPhaO/usTFnoxGfcvMienuvRs+8mrz2mF+Fnv1LXG6vRQqgc23HryiPsDaY4frTCqzmrSt8fpvcSKSakXjYtCgpzTxgZtx4UGe2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxaAqFX80L1buzhWJZDDzjc1AnduXYvz5s91FeSRXxU=;
 b=DX+6a4icQ9ymbNZ/2JNoTz4z45Bd0esNw89gqdKWLvMJVXczqPeKri8+LzT9qlwchY1Puh1q4n34KWerYKaqTEcMsDLd/6hC3kQFeR9rNp78kSb7TEKTqc8j7dzFTIeXQPl7wJNXitnTNVBjPrZuXHPKMLYhe8d94DgGNQAdWjg=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4077.eurprd04.prod.outlook.com (52.134.123.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Mon, 16 Dec 2019 14:35:43 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 14:35:42 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
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
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v6 5/9] interconnect: imx: Add platform driver for
 imx8mm
Thread-Topic: [PATCH RFC v6 5/9] interconnect: imx: Add platform driver for
 imx8mm
Thread-Index: AQHVmyea6vLOQFY6S0eW72n/jayYZA==
Date:   Mon, 16 Dec 2019 14:35:42 +0000
Message-ID: <VI1PR04MB702351C3615C360AF5A643A3EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <60d36b71294d162d25c9f889177cab30e41d5ae7.1573761527.git.leonard.crestez@nxp.com>
 <537baef4-d3bf-8de9-d168-21af0062b30a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d4f113c-6dde-4463-de75-08d782353ae5
x-ms-traffictypediagnostic: VI1PR04MB4077:|VI1PR04MB4077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4077D32B33E3C0DDC8B19F5AEE510@VI1PR04MB4077.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(9686003)(66946007)(64756008)(66446008)(66556008)(66476007)(7416002)(76116006)(55016002)(316002)(54906003)(110136005)(71200400001)(33656002)(8676002)(81166006)(7696005)(6506007)(53546011)(86362001)(5660300002)(52536014)(186003)(478600001)(4326008)(26005)(8936002)(91956017)(81156014)(2906002)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4077;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LCgNjNbpIvcc1nyETWfPr+SupogvMVUGLnOUTp3308qJ+bEeG3j0SX4WSdbnohHoso6uYs/CXWTyJtgXAb41mkMddWe7bQkf7jEv0UBiSARnuom1bzis3xc1b2eIZVS57NZt8RJmlngZkQA1zC0o5epQath/QEiUld4r5dSHnTa9IbFsFPS0XQmP+Bh6ZVZoCfMCPVHgjJVgwawzs5sPgt8TC+kOWIa1rZjYsJcj9dYMbjw2YiFlLmJUR0xhwA/TgTm2EaDe1KenAh2CPVgk/vxSh7KtLEKglASCP1pGpGCsE5U+eY8elSZHu02il/bCa4a9FPQhUs0AVNvw2rWaIYBvwErjeTaTBsBp/IcaqdoVspYw2YXJlGf2s4Z1BAiQdhFl+YXCtpLgL3yW7gtiyQAl0uMK31J7L60PKjKB85y5sU22HXDzzOkfCD0YMsPs/1qr5cBEyoWsMDYyo91o0Xzf1XcbLJEkAVQhDHfTyewXDyt1KVGvNnnC9lYupLCe
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4f113c-6dde-4463-de75-08d782353ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 14:35:42.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jF9cGhZv/3JPAKRwVo+9duJE6EMGym2jkNlsatBO9dG5Sa2e4wnK234Z0c/ezFW2LvSWqhpCQ9lOZrx3PQcRGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4077
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.12.2019 09:35, Georgi Djakov wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 11/14/19 22:09, Leonard Crestez wrote:=0A=
>> Add a platform driver for the i.MX8MM SoC describing bus topology.=0A=
>>=0A=
>> Bandwidth adjustments is currently only supported on the DDRC and main=
=0A=
>> NOC. Scaling for the vpu/gpu/display NICs could be added in the future.=
=0A=
>>=0A=
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/interconnect/imx/Kconfig          |   4 +=0A=
>>   drivers/interconnect/imx/Makefile         |   1 +=0A=
>>   drivers/interconnect/imx/imx8mm.c         | 105 ++++++++++++++++++++++=
=0A=
>>   include/dt-bindings/interconnect/imx8mm.h |  49 ++++++++++=0A=
>>   4 files changed, 159 insertions(+)=0A=
>>   create mode 100644 drivers/interconnect/imx/imx8mm.c=0A=
>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h=0A=
>>=0A=
>> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx=
/Kconfig=0A=
>> index 7d81d3c83a61..15671fe7f600 100644=0A=
>> --- a/drivers/interconnect/imx/Kconfig=0A=
>> +++ b/drivers/interconnect/imx/Kconfig=0A=
>> @@ -1,5 +1,9 @@=0A=
>>   config INTERCONNECT_IMX=0A=
>>   	bool "i.MX interconnect drivers"=0A=
>>   	depends on ARCH_MXC || COMPILE_TEST=0A=
>>   	help=0A=
>>   	  Generic interconnect driver for i.MX SOCs=0A=
>> +=0A=
>> +config INTERCONNECT_IMX8MM=0A=
>> +	def_bool y=0A=
> =0A=
> Can this be a module?=0A=
=0A=
Yes. I'll turn this into a tristate; at the very least it would be =0A=
useful to check modprobe cycling.=0A=
=0A=
By default imx boots with bus frequency set to "high" so there are no =0A=
hard dependencies on interconnect.=0A=
=0A=
Historically in our vendor tree we had boot drivers which made bus =0A=
scaling requests (like sdcard and ethernet) but I'm not sure this is =0A=
strictly required.=0A=
=0A=
>> +	depends on INTERCONNECT_IMX=0A=
>> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/im=
x/Makefile=0A=
>> index bb92fd9fe4a5..5f658c1608a6 100644=0A=
>> --- a/drivers/interconnect/imx/Makefile=0A=
>> +++ b/drivers/interconnect/imx/Makefile=0A=
>> @@ -1 +1,2 @@=0A=
>>   obj-$(CONFIG_INTERCONNECT_IMX) +=3D imx.o=0A=
>> +obj-$(CONFIG_INTERCONNECT_IMX8MM) +=3D imx8mm.o=0A=
>> diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/im=
x/imx8mm.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..acc002153729=0A=
>> --- /dev/null=0A=
> =0A=
> Thanks,=0A=
> Georgi=0A=
> =0A=
=0A=
