Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D890522D43
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfETHjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 03:39:36 -0400
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:62528
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbfETHje (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 03:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77zTwIuPuuuKBpj8chyvnGVXgAxU/Dzl2XPvhGZ52kQ=;
 b=V5BnSzhsPDglQyVlUL1lazzLGiV6YRFSXFnIzit0zMf+2S24brvz0u0jWMhaJBeaJcvfIaOZnqQ3rlSK5TUL65sWkxPLhMQya0PUhg/2bnt315im/st/T9PCJQu7mtm+1IHG8bPXRd8DbrtJu/GdnIwTvAd1oEwlbqf7G5YutOs=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2769.eurprd04.prod.outlook.com (10.175.46.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 07:39:29 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 07:39:29 +0000
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
Subject: RE: [PATCH v3 3/3] soc: fsl: add RCPM driver
Thread-Topic: [PATCH v3 3/3] soc: fsl: add RCPM driver
Thread-Index: AQHVDtkxsC35JTlHSUaXSC6F++m+MqZznP0AgAABClA=
Date:   Mon, 20 May 2019 07:39:29 +0000
Message-ID: <AM5PR0402MB2865E57004468965FF2003A2F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190520065816.32360-1-ran.wang_1@nxp.com>
 <20190520065816.32360-3-ran.wang_1@nxp.com> <20190520072630.GA3674@amd>
In-Reply-To: <20190520072630.GA3674@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad2f9331-cc42-4956-765c-08d6dcf64aea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2769;
x-ms-traffictypediagnostic: AM5PR0402MB2769:
x-microsoft-antispam-prvs: <AM5PR0402MB27696651D7F99F6A0D103932F1060@AM5PR0402MB2769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(8676002)(6116002)(81166006)(33656002)(81156014)(316002)(8936002)(14454004)(3846002)(54906003)(256004)(14444005)(478600001)(476003)(486006)(2906002)(52536014)(68736007)(446003)(26005)(102836004)(5660300002)(11346002)(6916009)(186003)(6506007)(99286004)(229853002)(7696005)(76176011)(9686003)(4326008)(7416002)(6246003)(53936002)(55016002)(6436002)(25786009)(74316002)(66066001)(71200400001)(66476007)(76116006)(73956011)(66946007)(305945005)(7736002)(86362001)(64756008)(66556008)(66446008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2769;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IxLiABcay4Wnda4BpGKbub9oBLyDcwYrRP0W+GmYtxJ3trxdfC7M7IJh0vxwTSgORGas3JBXzm79wZhEb0LPjKkjycnNNTcXbvC6u4s4azod69WYp/PNLWeFSyWC74X0NgKOYZFwadpg2vWwaoHzFwJ+RFhbaPVBYI1pKFQEFYy4kLAdrjbK4WpfEj9s3gVQNV7VBrD8bGB7C4tgujm602dI2Is6H4SgAcs00j73iBtH7cDn7hSpQbis+Zi/wMGr6Mc1rSACG2lsPOJkjWvhiizxcyTA3Zq2Y+iSE0KBoGfeGMO3p0RgLiLro6WzXqCBSE9r6lwv5rvaf3nSTW/EeD4q49M3MaYkurj+3pnub5b6uieIU7UtLSpQ2veIu/2Abmzh4fMggdi0fGYIWWvuf+F3XT/x70oXd+RKIHTktyM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2f9331-cc42-4956-765c-08d6dcf64aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 07:39:29.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2769
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavel,

On Monday, May 20, 2019 15:27: Pavel Machek wrote:
>=20
> Hi!
>=20
> > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > Control and Power Management), which performs all device-level tasks
> > associated with power management such as wakeup source control.
> >
> > This driver depends on PM wakeup source framework which help to
> > collect wake information.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
>=20
> > +// Copyright 2019 NXP
> > +//
> > +// Author: Ran Wang <ran.wang_1@nxp.com>,
>=20
> extra ,

OK, will update.

> > +	rcpm =3D dev_get_drvdata(dev);
> > +	if (!rcpm)
> > +		return -EINVAL;
> > +
> > +	/* Begin with first registered wakeup source */
> > +	ws =3D wakeup_source_get_next(NULL);
> > +	while (ws) {
>=20
> while (ws =3D wakeup_source_get_next(NULL))
>=20
> ?
I just answered this in v2 mail thread:=20
"Actually, we only pass NULL to wakeup_source_get_next()
at very first call to get 1st wakeup source. Then in the while
loop, we will fetch next source but not 1st, that's different.
I am afraid your suggestion is not quite correct."

Regards
Ran
