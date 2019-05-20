Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9723007
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfETJSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 05:18:03 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:17579
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbfETJSD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 05:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wjq3w45GRiFI2//a7t647tCKQUdF8+Ggx6O/vEK4e64=;
 b=AAZiQse/9fx1IdhbxGlYWJ2xnUx3C4b3lKPUTLS3pHBeoZI3NREuShxXWZqsfW9T7kNct6zPqXAPHw3chSsVPGd/n7Ic4qEVWDaLYVtmrMhipHWsc+IbHiuXWzGErMbogezjWGwaRVvga1IBixjFjL/Bu1E9jznqexUHp6Mh+mY=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2833.eurprd04.prod.outlook.com (10.175.41.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 09:17:59 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 09:17:59 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Pavel Machek <pavel@denx.de>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V2 3/3] soc: fsl: add RCPM driver
Thread-Topic: [PATCH V2 3/3] soc: fsl: add RCPM driver
Thread-Index: AQHVDGHzIQrvIPzRX0ytn5pxhdLuLqZy/bMAgACX+4CAACV3gIAAANBwgAACRYCAAAHg8A==
Date:   Mon, 20 May 2019 09:17:59 +0000
Message-ID: <AM5PR0402MB2865E28B2E2296CB878ACEA2F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190517033946.30763-3-ran.wang_1@nxp.com> <20190519213844.GH31403@amd>
 <AM5PR0402MB2865EC5E1EF12C6C1D3C5566F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <20190520085647.GA9748@amd>
 <AM5PR0402MB2865F4574B19761848B001F9F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <20190520090748.GB9748@amd>
In-Reply-To: <20190520090748.GB9748@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0451e86-49ec-44c6-b934-08d6dd040d87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2833;
x-ms-traffictypediagnostic: AM5PR0402MB2833:
x-microsoft-antispam-prvs: <AM5PR0402MB283301A6038AA2B3C9115EDFF1060@AM5PR0402MB2833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(7696005)(2906002)(99286004)(86362001)(6246003)(14454004)(74316002)(53546011)(229853002)(6506007)(11346002)(9686003)(68736007)(446003)(476003)(55016002)(6116002)(3846002)(305945005)(102836004)(76176011)(486006)(53936002)(6916009)(6436002)(7736002)(66476007)(66556008)(64756008)(66446008)(5660300002)(66066001)(33656002)(66946007)(73956011)(8936002)(7416002)(316002)(25786009)(186003)(76116006)(54906003)(71190400001)(26005)(478600001)(81166006)(4326008)(8676002)(71200400001)(256004)(81156014)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2833;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ImH+jFa5VWy3XrIpi+JhjHUOysWf7NmzT8XE2im6LtT3xp4u6FcHv9ZtYjXfnKaIks2K4mNNmtdR4PTYOTOY/gvOjvn6fO9cTKxd9eWdyc+hBtomrxrahv6fwXIaJ81f2BM2YFY290fT/+UW77feNt8GNYfVXu/j14+1UpENd9LjquMTspSrlVF4usRimpKrEdAt/YMg4fU1vt1gTs7wE+bBfFzcKSJtX8W16JvE2cwe1SicBo3a7mIFqpT2u1VTx1UvYgToqpNrH1k+Fk/UWZpQGi2o6/+PJ8Rka58LM5Bkas3Mu03HH3sLT4t80K5JTA3L2PfoIewHsyUVuEcMU/pCFpxoCfrp+hWb/e6e0m4ZqXLZQlcbrWQMkchxCHM16+Y3/y79LZbGopZbMAa6qMRYqJX3HQQzg7jbj0dSg4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0451e86-49ec-44c6-b934-08d6dd040d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 09:17:59.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2833
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavel,

On Monday, May 20, 2019 17:08 Pavel Machek wrote:
> > > Hi!
> > >
> > > > > > +static int rcpm_pm_prepare(struct device *dev) {
> > > > > > +	struct device_node *np =3D dev->of_node;
> > > > > > +	struct wakeup_source *ws;
> > > > > > +	struct rcpm *rcpm;
> > > > > > +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
> > > > > > +	int i, ret;
> > > > > > +
> > > > > > +	rcpm =3D dev_get_drvdata(dev);
> > > > > > +	if (!rcpm)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	/* Begin with first registered wakeup source */
> > > > > > +	ws =3D wakeup_source_get_next(NULL);
> > > > > > +	while (ws) {
> > > > >
> > > > > while (ws =3D wakeup_source_get_next(NULL)) ?
> > > >
> > > > Actually, we only pass NULL to wakeup_source_get_next() at very
> > > > first call to get 1st wakeup source. Then in the while loop, we
> > > > will fetch next source but not 1st, that's different. I am afraid
> > > > your suggestion is not quite correct.
> > >
> > > Sorry, I seen your next version before seeing this explanation.
> > >
> > > You are right, but the current code is "interesting". What about
> > >
> > >     ws =3D NULL;
> > >     while (ws =3D wakeup_source_get_next(NULL)) ...
> > >
> > > then?
> >
> > Did you mean:
> >      ws =3D NULL;
> >      while (ws =3D wakeup_source_get_next(ws)) ...
> >
> >    Yes, that will be the same to my original logic, do you recommend
> > to change to this? :)
>=20
> Yes please. It will be less confusing to the reader.

OK, if no other comment, I will work out v4, fix this and extra ','
=20
> Thanks (and sorry for cross-talk),

That's OK, thanks for your time.

Regards,
Ran
