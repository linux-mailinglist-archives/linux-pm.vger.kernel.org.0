Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0902B1B29C7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgDUObZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 10:31:25 -0400
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:25440
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729206AbgDUObX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Apr 2020 10:31:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTz2YPm6VYDbR/HdLyGcoWC7R3fn6whXZMZ+q1bVVbt8IwCCYdtryvGxndncQb+8ElpulF6M7zyDlQ3PUzWOb69gxGQgkxZlYqAjg6/mTIbQcj70OjgD1CHmMrQjL6Nssi1CgstIy5/qCxf1OR4+x9274YrArxaMh01V+l4xuVIcZAf80BOb7cLjYHOrR5J/fFycy3Moi2BIqr3nMxrCQZ/tUF0BELhk5MJoGVeV/dC/17SyWzQffvB3fX+1pYcFX7gsOYqWV1OH+vjomJ4KA7BZAP5flf82ygI2o/dajX5auKgL3PtOhz2PT3OUVrzLqKF/swRWaHdiBWTXpz/uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU13+WUaDHSv9p7Nw+Nxw0lh+DgYNdcrNFHJ/qMmWhw=;
 b=I55nzw2KNrcyUB7iPYJtlmvFWXec0I9Vz+BCc83lydlr9Va/kv1TvZpxd3zIvNiCjW+Y99oEBB5jdj/m/WPcbnUjhyhvhc08YPv0fMhQBYgraxtjmZGMdl+IBvE9wAktSBQr3wCSJnQykcFT2GSagCuHdHbIaCwoYKYo6qzOdUJFUmcsphtnmKJNimmSRyN3WgnZl0P0626boil1vSQa+XwxPIBT8KPnU5Ym4GlMdC9qrlg6Ua1Y8SXL40VdWEG0NeaCiePjXatiu4jWQglcSbA4CRxSC5m4KLFR+cmdrnFPNWNibLfsxVQsqubqMMPTl1MLWSkqXXAFujahv4mZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU13+WUaDHSv9p7Nw+Nxw0lh+DgYNdcrNFHJ/qMmWhw=;
 b=iLB7Qk01aqjSR8LdgnBCj7kFvQX7LwzBCaSQlLsIDe1tFr09UyPWIaHL6pa3H+UYLaoF7cXVzARje2GTmTABVM59V9m6mbE0mWYAtEd7zl6HgCi3CObot6UR+FN51PEaaOHPX3C7MeU7+XLdVV8TO3pS+szQ98OQjHuZSPMBwJQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3691.eurprd04.prod.outlook.com (2603:10a6:8:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 14:31:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 14:31:17 +0000
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
Thread-Index: AQHWDtWuHhuFKGSv1ECuhQdSmjVzK6iCZy4AgAFNxdA=
Date:   Tue, 21 Apr 2020 14:31:17 +0000
Message-ID: <DB3PR0402MB3916B60832507A72F39750EAF5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1586480844-19227-1-git-send-email-Anson.Huang@nxp.com>
 <20200420183512.GA5483@bogus>
In-Reply-To: <20200420183512.GA5483@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75e0848e-9930-4c6d-339d-08d7e600a749
x-ms-traffictypediagnostic: DB3PR0402MB3691:|DB3PR0402MB3691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36912FDBFFC18F7789BFC55BF5D50@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(186003)(9686003)(6506007)(86362001)(54906003)(7416002)(8676002)(4326008)(81156014)(26005)(71200400001)(7696005)(55016002)(64756008)(66476007)(66946007)(66446008)(66556008)(33656002)(52536014)(8936002)(76116006)(44832011)(6916009)(2906002)(498600001)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNx4v3QJzjTy8OndEy1RfW1XVrhEnqaRKW9vNETLm80zgl8e2t1Fk/b2eOFJATClWyBKf4Z5V7GuJFTpMoFAdTrluqWNh+h8CagKor9bXgSm5FbLKwNOaspwK+jB4Iggu6IvLonp+x3+mgx7tJpYUom+znzK1B4UA+8yLIxsvzz7dZk747qVmkq/nWONqLC5kAMaYq+g1QKguZbbHdZo50PJDVXuPhQsPV/YAsE4t+fntxR3rZHpHT/8CZfGs4ld84Pp7ZY1NkMMdBM0YACkJjGr4mZusq9N4PLd2aoz1QDdx/hns4kVJKHS/xRkgXA0zMDalikPhclMKl+5bAR77zzmtWpcqsfODCnUbUcRLPP00cyFKjzd8VMJk8eNoCz8gjnuo6ABJROB88dUrCzs2KPW7MH4VNw5hmGxJMG91AvKkzgWuEodVOeJ7I39aFXe
x-ms-exchange-antispam-messagedata: 69Azka5k0n2Z7/ScLT4sKSg6/89XFnXYjriTCSnKXfeEaQucdOdS1OUq3ai2dGSK728McBV9G+ZO8mCrRAFt8+EYjx13L6JRO6ullyXYwuRjAV1ninpaZ0PImVE4mfK++m8cPwUcJaPdRNC2u2rGwIrsHMjKPxN9h3P1xah2d4LjGxDkwhEnFTD2Hjh3vcMiP8Zr/DyEdJzEdH3inHaZwSbDN5pAYe9bnVzml16pJHq5V7dTTNE1zS7LoXaBtrHEJmICO8jzyvWc/pNiVdRrdbfQu10Qs0s2FrdOBLUVyAsAP1eBZAcfay/mofDvj83PHbpslxAlK70LanR44VyGdStDCkz8KCT/uuVHbvIPSyr8m7XZIxRomDCFwXWFKEAHuepEzkii65FiF8rA+YnA7nyM7VFZNi1djpjXdUNhotj9Z6Qy8WYX5smh6OugdEfD0fYY9dHpB0844wgMNqgYpSAMsP7lhQtHEuqAq52BGBKaZ+9jg/S9Q/BTs/3HsuYM6WOdfgG+HJ3517bQfDVSAqWnJd+adgM19nMM1kgfe3oeqfcmuDmPTcRBF93bGEsjyuxuh7O8xPyEThNpbQnQ0+c67LqAGNOz32yf+IUr5jQTT+LeT9Xda37rvFRcFFbMvybjdjQlUWsS8dWhKP5Puzm/A2h6FoekYK3YkFtxawU0nqZwGLfaxnDkEeE5LaiX+nBIZFW4Mm2ZJwCNxl4ntjrhLVrb9Tnbkm2BJ3p/iYl5pi3VcA1KyJhhrKfXLuAPVDWXChwoS8/WnB4/wFPTlnez8rASQamMUQF8R6dQ6mk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e0848e-9930-4c6d-339d-08d7e600a749
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 14:31:17.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgm0UrLLbkXpnleBqWuTzfo5VXLHwSzEtVhoGPI+YuAviOI8OsZ/bwn3chNaEyLViIIGfHG2mvdJyfr4cxVczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Rob


> Subject: Re: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
>=20
> On Fri, Apr 10, 2020 at 09:07:24AM +0800, Anson Huang wrote:
> > Convert the i.MX thermal binding to DT schema format using json-schema
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > Changes since V1:
> > 	- make clock property optional.
> > ---
> >  .../devicetree/bindings/thermal/imx-thermal.txt    | 61 --------------
> >  .../devicetree/bindings/thermal/imx-thermal.yaml   | 96
> ++++++++++++++++++++++
> >  2 files changed, 96 insertions(+), 61 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> > deleted file mode 100644
> > index 823e417..0000000
> > +
> > +title: NXP i.MX Thermal Binding
> > +
> > +maintainers:
> > +  - Anson Huang <Anson.Huang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6q-tempmon
> > +              - fsl,imx6sx-tempmon
> > +              - fsl,imx7d-tempmon
> > +
> > +  interrupts:
> > +    description: |
> > +      The interrupt output of the controller, the IRQ will be triggere=
d
> > +      when temperature is higher than high threshold.
> > +    maxItems: 1
> > +
> > +  nvmem-cells:
> > +    description: |
> > +      Phandle to the calibration cells provided by ocotp for calibrati=
on
> > +      data and temperature grade.
> > +    maxItems: 2
> > +
> > +  nvmem-cell-names:
> > +    maxItems: 2
> > +    items:
> > +      - const: calib
> > +      - const: temp_grade
> > +
> > +  fsl,tempmon:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > +    description: |
> > +      Phandle pointer to system controller that contains TEMPMON
> control
> > +      registers, e.g. ANATOP on imx6q.
>=20
> Really, this should have been a child of the system controller. Not too l=
ate to
> do that, but you'd need to keep this for compatibility.

Sorry, I don't quite get your point, can you provide more details or exampl=
e, thanks.

Anson

