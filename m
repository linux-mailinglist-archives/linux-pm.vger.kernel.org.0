Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA21B9788
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgD0Gky (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 02:40:54 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:17287
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbgD0Gkx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 02:40:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTl43Xia3GkLKWUKjUGTy35379PI8YWD0J9YYJPsvoRR1lGXFGN9imA4yK7ZhBdXd0NG0dTuQGoD6bW8FIPAvpXXkF4erz8g722pUlZJ62okj3PGlwy9PT1Q4u7vOPkc6Q5cc2KAvMnRG8vg7W7AI0kXiDk8+/9lhurTiIOi/zXrWa+sg+xSy1l8lvy92zcbQ90/SlM+UQ92cHmyfpMIc6ymmVvl8Bmq/8o6RNjkvUfrPS9lHgsu5Qp10H3hziLeZNrICIwcJN28OmkGyCAGVWsUj4TDl8NA6LH1dcqI31RjkByObfUGwV7u9t7/id7kUWhgaXrj94BIC6axombdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOLqgno/KMv+TgrH9znHKGOOAd2FOk9jAuhZPrMGEfw=;
 b=a0PlAyY9ddh0Twg37ArcgDGbq2rGIlezcynKv/J1sqNW3k9gy/scU/SUbpinMujZRdMCLArxCtPzu5A6TQ7vh25boWTUuXDcGrYDURXPo908aL7ezD+yGqPwGJ7/cfbpNfjRuIWcRh2BPw7zpjFdACvnmU212U28AYefVgHN/Usr7uTFv0dMUTQWBa+fdKelMCASIZ7hAMvzbL/LuyXgvTlhM7Dv1FXWDsPtWK4G5iQpsbiqFdUkHPSUj1G1mwK2F3aMHEl/P9Nbm6mwGW1KYo9H59jXgDZSH0ZY1g/c8wn2Li9Qcbqr7SP8MvKma3IE3+4o/dq4lU6MzR5jA2iC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOLqgno/KMv+TgrH9znHKGOOAd2FOk9jAuhZPrMGEfw=;
 b=avU2u4B4Glj/NXI00vhL22Lrs7RDyqF9YdgCeytYVh/fBnj3jD7gIyJoIlIqsIjxVqWjm0r8GTfUT49YumWrs3vbpaqUvYv+/7pq0SQv53MFJVI0MpXYF7iOKgRMz7ZWLyfMrchgakq9wTXMJzUElADf35iOmunQbZfLJ81ZPaY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3803.eurprd04.prod.outlook.com (2603:10a6:8:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 06:40:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 06:40:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/2] dt-bindings: firmware: imx: Move system control
 into dt-binding headfile
Thread-Topic: [PATCH V5 1/2] dt-bindings: firmware: imx: Move system control
 into dt-binding headfile
Thread-Index: AQHWG6ON2FILnnPVpkiXZVEUYRccAqiMfhCAgAAH9uA=
Date:   Mon, 27 Apr 2020 06:40:49 +0000
Message-ID: <DB3PR0402MB3916E21104F4D0DAF84A4B33F5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
 <20200427061121.tsybnbqrzjpy7f3a@pengutronix.de>
In-Reply-To: <20200427061121.tsybnbqrzjpy7f3a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24665c24-286a-4b11-0c4a-08d7ea75ec7b
x-ms-traffictypediagnostic: DB3PR0402MB3803:|DB3PR0402MB3803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3803724CD336369A7518EAC1F5AF0@DB3PR0402MB3803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(7416002)(71200400001)(4326008)(9686003)(55016002)(44832011)(5660300002)(54906003)(8676002)(81156014)(86362001)(66556008)(66446008)(64756008)(66476007)(6916009)(52536014)(186003)(66946007)(76116006)(478600001)(6506007)(53546011)(26005)(7696005)(8936002)(316002)(2906002)(33656002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jN43100xHcqPtpO3zPbJcWGcCDBMFegbGY82ACd/Gcv9bEh++29HE3KRs3BpOenpFtscF9ZQqptbG2fgas91/aaAAhsP5G3sfPQewRswKfwkSOjF0GEMwAdQ97U6LchAMG61FRtxey2abVeH7rB2oKl0vAfYEkMNNrZWi7Jtk4g+j0isMdxDcqB8t34YQtaCsJkTw7H+zQ2xP2/6jJJAn3XjhTbUC0R1gejOFy8SN3j3gTKakjgFZxgpmfSSrBXX2rsq5xAp7PrQF5fE1Xga2mLDb8VZLtLze2DkL6rb89oIL6TwkgCsoK8ueDPMWMi1cCCJjxaps6SWfLp6i7OUAow8CoLASguDM3LL7v3tvLSE2C/18TjV8VseKKC3UPsJsg2pu4ZZemcfwDKlj7TitVXI6Z9XAfbYx012I+Y3Y9BFYLDtrd/BU5MvrCjnkFBY
x-ms-exchange-antispam-messagedata: WdPGZ4BJ8CYSjilq12IyP7PFKIdzEUszxbADLMB2u8JNEJOW1KhwhcosTlpnCoO1sbESmHmtQPUnF/4hAx3kkJTnu0X+aZlxcj2SfINkTy5SX80bLvG+TCWz26LRVrrgBsx9BBx9Zvnigv09idk5tKrZ5MGv0Qe4Zq8Yxh8wwrG0+yx7xhtOGu4DEhw8duqbOkjntcQ6ifvLmkKzcF8ORcP9Dfh+e6yR28332BJsuPXjt35/sIBYRS/nrCAp9qyCVrqfnGNv5ubyN4uwsEO29p65JUdgGljuJ/jhDj1CCy7k3FyGdVTSOX5nlIu6HiFHhz8vrXq3T+O2hoe3UICzi/qcb8IxaeIMjWsLNjdI0bf15/MLEc/JFQz+QbgI6Oetouw4RoxSwwHqmnfLTYTm6tjbIzMP+GFDURMRhbsOu9Fq8MUuvFVBkPm/C2PSP4WaeI9xUXHkqx7trewsNfXfwGqrZGaLI9FFGd7uLqdPYfuMfD7ckVMt/5sr+famKI9MrYqnQSzB1eEVwlZ6wgpNAEz2jp71TFaiQ384VqH85fkwSz4bcx+8YKL8YEfXtdYgGNN3qmPTNkB7KdIGzFGavZVypfcCwUal2JhWMFlULEONpAPAYPtuqFW/LGV4FIWp0USYv/vUeiSIWrjGkGKmK9HeTvq7RBZl0X8VAjWSH6xWsvytE/Z1MmkgvXn+URUfHMXgcmoUfr4GpLV5dqM4R5pjxco1HtiLsyie3pt5y15J5CIaQindiIqqwM9Yem8PQG8Xx42KBPuPSdl7hX+vY4fN+SdQXxX5ZnK+s7qmOds=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24665c24-286a-4b11-0c4a-08d7ea75ec7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 06:40:49.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqUB4v5WHV0AWolZ49A1t0Z9l6s8Sfyp+HGwDfrLkcHuOFB4DJxa17JzdnBPjM4Y1+UzXG++wwOrBINENBr41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3803
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Marco


> Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: imx: Move system contr=
ol
> into dt-binding headfile
>=20
> Hi Anson,
>=20
> sorry for jumping in..
>=20
> On 20-04-26 16:11, Anson Huang wrote:
> > From: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > i.MX8 SoCs DTS file needs system control macro definitions, so move
> > them into dt-binding headfile, then include/linux/firmware/imx/types.h
> > can be removed and those drivers using it should be changed accordingly=
.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > Changes since V4:
> > 	- Use another patch for new added system controls and PM clock types.
> > ---
> >  drivers/firmware/imx/imx-scu.c          |  1 -
> >  drivers/thermal/imx_sc_thermal.c        |  2 +-
> >  include/dt-bindings/firmware/imx/rsrc.h | 51
> ++++++++++++++++++++++++++
> >  include/linux/firmware/imx/sci.h        |  1 -
> >  include/linux/firmware/imx/types.h      | 65 -------------------------=
--------
> >  5 files changed, 52 insertions(+), 68 deletions(-)  delete mode
> > 100644 include/linux/firmware/imx/types.h
> >
> > diff --git a/drivers/firmware/imx/imx-scu.c
> > b/drivers/firmware/imx/imx-scu.c index f71eaa5..f3340fa 100644
> > --- a/drivers/firmware/imx/imx-scu.c
> > +++ b/drivers/firmware/imx/imx-scu.c
> > @@ -8,7 +8,6 @@
> >   */
> >
> >  #include <linux/err.h>
> > -#include <linux/firmware/imx/types.h>  #include
> > <linux/firmware/imx/ipc.h>  #include <linux/firmware/imx/sci.h>
> > #include <linux/interrupt.h>
>=20
> You don't need this anymore here or was it a needless include?

I don't need this anymore, and since it is going to be removed, so this inc=
lude also needs to be removed.

Thanks,
Anson
