Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832521D0917
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEMGzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 02:55:39 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:6197
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgEMGzi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 May 2020 02:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrXyYq3/ceNKiRxD8ZV9eFMh7VwrKsCDfRapuDwbBroGXk8p9s8/mqDHuQ054/NNsYWpytMHiWg55yrk7vb6OidU3hm0Gd6N7LK2EkR5f0UQ2AVGG2XWRFkHBWsiaLS3gNuovgQcuY+2EueUwszl5r7Pk7acMwQlflwPduDutVG4PvH86UrZLx9+a55GJYbRpHmmSLf0pHuSfgl8hceQFF1KjmL39X2H2A9V/KiKZd//uZp/PAdioai3OMvFLht1/zEK9WtZ6xjenN1tNNZEZlyUlMMdn65NCmgfDL9FgOzz5+eRDTdoGdkuj4hZzrKlxmqMGxWLdgzWxooQUynrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c2Yzw4kRMjBQ8JYRZ1YuBfjY8Idal0B9Izj7kqlOUg=;
 b=dATQjH8kthuGhaTrSeDdWEh0UeYwjmGG/8YUHoK99To7OljumtRc2E+FvpdjnXphjVnX1EoWeuNz4m4SCsV5ItTc11B/0ux6iToUpMiK7Zem3iyMGNdDSpjkKqd7Wj4gVJryRJBQCsbIQ1Hx5ScJQkWhwLkgf+iFNMvTS+jm4smcYAj9ydau3vzMwc8KIqXXsq3tUaKl9pOHnTLntb9Wiim6aKvso06Jb/rH12uCl3WWRLQuwV+P0MVO+BTYAjasqNGRXUd4TCMe4PQEGxKc/58mwtjv/J73cqZf9THVM1lwAFglpqpxAv0br8lZSG+zjZHN6qbDs3B0CyuP4N8yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c2Yzw4kRMjBQ8JYRZ1YuBfjY8Idal0B9Izj7kqlOUg=;
 b=H3f4+nIZtY0G5u+KWvyBL1t6P5juPTq+ODIhvhycnCQA3mTQOOGYTgtQWD5kHT/9ti0iUjaV7TBwDrJqdh6QwTtbInpuRyWuVuFV2jEJjL7E7RiHCdmIBNxGruERzuariKOsM3hQqAw2VzqYzfYGo35QjCvs3h/vjcKNLLv7e6A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3769.eurprd04.prod.outlook.com (2603:10a6:8:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 06:55:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 06:55:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
Thread-Topic: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
Thread-Index: AQHWDtWuHhuFKGSv1ECuhQdSmjVzK6iCZy4AgAFNxdCAIhNSMA==
Date:   Wed, 13 May 2020 06:55:34 +0000
Message-ID: <DB3PR0402MB39167476CE5FA107505A78C5F5BF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1586480844-19227-1-git-send-email-Anson.Huang@nxp.com>
 <20200420183512.GA5483@bogus>
 <DB3PR0402MB3916B60832507A72F39750EAF5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B60832507A72F39750EAF5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e591871a-57d0-427b-c039-08d7f70aa2ee
x-ms-traffictypediagnostic: DB3PR0402MB3769:|DB3PR0402MB3769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3769A305ED54C1760B2B2C1FF5BF0@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9XtqJBZ0j4IBcYfJEbBmotp6dKCj7EjRMQJLbbGEfT1jD2Rn/7k04G2Ud0iubX3xldSwWM1P72aDpSWsp+fMcZiQcqDKf4cVaUTOOtBPAKNMFYRBNw560TrjJRMa+fPDOXkJP8MyDtSJ+Xo4ZW88RN7csIfdhJ/y1UgnYjU0liqdbzAlzACR0ChDbpOW1jUhKTNdgo0VsVjOnW/FivD8l3rofYeDdsUF2Hm0txlL5mNLX9KbFzyjt7h+d6UQd6TDM0H5EYHxn9uRQn6qF9q7BwBv9J/ZOXGAMr6L0hb46bU2qOOd3SHr+g8E4Cpa6m3P38hZlQk8KoDcItGZflnoTKpXuUzs836h2akacZm4gpuAQ3IEFSMwflN3iUs/p/EAdChtAO3rQSRSF6HxfGAoUI5ooNYvOKkdpTaV4Ow0/df86EupI+6MWeoi8NoT9o/YYw+HI8XzO1D5w5h2TYVjLOGgTlyMbmc4D37vasbMoI33tDrCXgYlhX+3/3EjFIWKal3gpz1ryAGyVxqthBkWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(33430700001)(6916009)(55016002)(4326008)(8936002)(52536014)(5660300002)(66476007)(66946007)(478600001)(66556008)(66446008)(33440700001)(76116006)(33656002)(64756008)(54906003)(316002)(9686003)(71200400001)(7696005)(186003)(26005)(86362001)(8676002)(7416002)(2906002)(44832011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LW4c1UDqc6VBmvvTnwL+FTUtMrVAQvf3LNO+iehSQhrpig8uc/lyINhccsdaERLmzFh+9XLR63msbPcPel5Csd81wDPix4Myvi0QBhJ27gH0T/iRJ3GnOuemVfysAEqMEmiuBwr3zUetMWFoOoLc5g4aDt68lvXqzseg9sLW/gvUtflS5Aswtr1U13sKIvvbi0QEUkcZ75u1VBtPw0w7fyGxOdAj8PacxH5F/uNxJSYPEQnrg1RbD6Rxbfx7apdmQ7n68LZ0dBmFYHuW+Rk8Xj23BlW7EQYoB5g79vtQkzzop0YPGRevFWcXYzE1TOkC0Ytu/wxu1TPR2hXEQIllxKM+bWnjUVzoLXs3kEuXofXb4Hl+6ITcg0KwGOPlj2CjiihDDki2KXYf+S0AZD8vOJ0PvCI2Sgc8gFFIVdAGZC+E6D7agXdroxcQVyPH8IBeJuO1XJ8Dul+QvSiGOK2Js+ux/m05pXzb2ZMq4wC7iu4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e591871a-57d0-427b-c039-08d7f70aa2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 06:55:35.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZNozB8sYIG2UzAi6yIQ3dYvBNBmddacCaP9p+Lab+NuAnFRUBG/OqCiRPOyAA2u81jhqvjQ9P0KdwiZFjFkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Rob

> Subject: RE: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
>=20
> Hi, Rob
>=20
>=20
> > Subject: Re: [PATCH V2] dt-bindings: thermal: Convert i.MX to
> > json-schema
> >
> > On Fri, Apr 10, 2020 at 09:07:24AM +0800, Anson Huang wrote:
> > > Convert the i.MX thermal binding to DT schema format using
> > > json-schema
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V1:
> > > 	- make clock property optional.
> > > ---
> > >  .../devicetree/bindings/thermal/imx-thermal.txt    | 61 ------------=
--
> > >  .../devicetree/bindings/thermal/imx-thermal.yaml   | 96
> > ++++++++++++++++++++++
> > >  2 files changed, 96 insertions(+), 61 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > > b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > > deleted file mode 100644
> > > index 823e417..0000000
> > > +
> > > +title: NXP i.MX Thermal Binding
> > > +
> > > +maintainers:
> > > +  - Anson Huang <Anson.Huang@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx6q-tempmon
> > > +              - fsl,imx6sx-tempmon
> > > +              - fsl,imx7d-tempmon
> > > +
> > > +  interrupts:
> > > +    description: |
> > > +      The interrupt output of the controller, the IRQ will be trigge=
red
> > > +      when temperature is higher than high threshold.
> > > +    maxItems: 1
> > > +
> > > +  nvmem-cells:
> > > +    description: |
> > > +      Phandle to the calibration cells provided by ocotp for calibra=
tion
> > > +      data and temperature grade.
> > > +    maxItems: 2
> > > +
> > > +  nvmem-cell-names:
> > > +    maxItems: 2
> > > +    items:
> > > +      - const: calib
> > > +      - const: temp_grade
> > > +
> > > +  fsl,tempmon:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > +    description: |
> > > +      Phandle pointer to system controller that contains TEMPMON
> > control
> > > +      registers, e.g. ANATOP on imx6q.
> >
> > Really, this should have been a child of the system controller. Not
> > too late to do that, but you'd need to keep this for compatibility.
>=20
> Sorry, I don't quite get your point, can you provide more details or exam=
ple,
> thanks.

I guess you meant the tempmon node should be put inside anatop node? Then
DT files also needs to be changed? Right?=20

 anatop: anatop@20c8000 {
         compatible =3D "fsl,imx6sx-anatop", "fsl,imx6q-anatop",
         "syscon", "simple-mfd";
         reg =3D <0x020c8000 0x1000>;
         interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 ...
 };

 tempmon: tempmon {
         compatible =3D "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
         interrupt-parent =3D <&gpc>;
         interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
         fsl,tempmon =3D <&anatop>;
         nvmem-cells =3D <&tempmon_calib>, <&tempmon_temp_grade>;
         nvmem-cell-names =3D "calib", "temp_grade";
         clocks =3D <&clks IMX6SX_CLK_PLL3_USB_OTG>;
  };

Thanks,
Anson
