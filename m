Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266A0162213
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 09:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgBRILV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 03:11:21 -0500
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:64449
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgBRILV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 03:11:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc65fpjc2AtqGuK8lPSmKYqinfK42bit7OlEEKFRGlz+brepV55+znVGrzz9ouXAd5D/a0OePM5mjGftmUX+2gB9B1s9iZi6/L939d18S8zmxrzyruKqVS4BI8YS5QcUfMsoEyxS6yT6rW9lcrz6ytHqji7BXL2AgNQZMjb5YQx4FrxoKIgvWayylv4/97vOgN8/5g2zTFBrf6IMdmG+pj1oUHEvx2xJ6Wz7KFELeFvJUP2Me3M1kycs5mHzpHf8g5nhXtKBP1W+Z9YG+xic+odRBIHcz0vUwjVCQLQv7U8XDVGjP051aM9E9nvhh93bEk93HpuWlXwhTJH8jljRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntJjgxUZPVZjKP2rMHjoqXtdwsVmYaSuuaJ6B4S+J8I=;
 b=L5CKLmLFGkAs8qEol6+skzsXOe0TYU+csjyk3qmag/Ptybjf/+B1sF1VVAgJGA2XfO1uEDf9nPDSNGulum/zBxPvpLJKsR/LiiGS/xYHof4qTSj8Pe1btUzEb9n3vGh4cOrETLVd+7MB9YmkG6JxCXSBXIp8Bl5zp6JJzQ9ihS8XPXQZBgAQNo/fIVd1QDB39spL03IkSynzOXdBK1zIaiy8zwZ3/sISfg48gB+BOkgiyQgP3L87hWyfADtoyMD+yIzf5us8o/tjRGO7jbA/GnE3pTAhL2LEuFLAcL41KRZONsVwbMJKK3izjAIucJ709/3tAv5HqiB39l0iiluvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntJjgxUZPVZjKP2rMHjoqXtdwsVmYaSuuaJ6B4S+J8I=;
 b=P3hMbDeYw4C72xUdHemjlBujcXp6ZOST777aGbSHxJYj0GKR3Oy69plgvtyeBGnH3U2x1l1DwZLbKMIMijE183aRmKg3jqOFINk8qBOUxOZNNj6EXKlT+nYAsxu0R3ROWx9x2EOi66ZumSpWVw1x1a6Tq89RcoJEfOKtPVHFQHI=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6126.eurprd04.prod.outlook.com (20.179.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 08:11:18 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 08:11:18 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg KH <greg@kroah.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Thread-Topic: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Thread-Index: AQHV4TRn3BXs86jgkEan911jMn55C6gX5NGAgAi8gwCAAAGMAIAAAGYw
Date:   Tue, 18 Feb 2020 08:11:17 +0000
Message-ID: <VI1PR04MB53272E34586DF3BA2981E4DD8B110@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1654227.8mz0SueHsU@kreacher> <19064076.ICumzjfW0v@kreacher>
 <20200212183827.GA1900941@kroah.com> <20200218080314.GB30350@b29397-desktop>
 <20200218080846.GA2186559@kroah.com>
In-Reply-To: <20200218080846.GA2186559@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [101.229.0.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5f426e4-362e-4580-b98a-08d7b44a21ad
x-ms-traffictypediagnostic: VI1PR04MB6126:
x-microsoft-antispam-prvs: <VI1PR04MB612656F173C758446EFCD6A68B110@VI1PR04MB6126.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(2906002)(9686003)(52536014)(33656002)(54906003)(66476007)(66446008)(64756008)(66556008)(76116006)(8936002)(7696005)(66946007)(316002)(71200400001)(4744005)(53546011)(6506007)(86362001)(186003)(55016002)(44832011)(6916009)(81166006)(4326008)(478600001)(26005)(5660300002)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6126;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDeKNJkMNjmToSMF5dCVB6Zhkgj0z7ebLTu0qIV2eZ77iub2epbsKo32UAwUlZ8btaP6gmTwGiI4UaLSQRWwZYx5jwq9DHuFfs1T9YOpaSFGOlcLF9Xg97rPSf2WEEzHc8E26orMWtKjlK/w4T9SuSJiKGDPI5HUk7PQQ9SInKz2Gsxeksxm4jU6H9h76Aw2m4gkZc1/fEBubwsfssL9pQlAcHsOik9jR3SK974oo6fANHWgAhtyGTWAaNzEAT5p2wg6oDdANg2M+lKGEmbRgx1m6//fgcezNEl36y8yHqxeUMFNoHKdMlWl2i2JH0ixPEk2cePSf20ulcIFVz22CNUiutCfXpnONT7kaYnOkyLnIW22ACSorwqMGrx7JK2Z0iHBFp0zrzMZ72VCqPlSNYAGlFP4KGbClCtCHUDBKZjYZeuJBlQ+2qMFVDPYEJHv
x-ms-exchange-antispam-messagedata: VPVygAvhrvnIZj9v9SluGpcbzk/3W9swEKr+6qGdU9jjWu1K2ca9Jv9xy0cJKdKyyDrmn9KqjBJ0Z208de2+d5fOgXLMFOgnxiHY8nCcwdFb7pgj5VpHIHWM6GnyMPXbbUQfAk59DV8zQF19LlOvVw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f426e4-362e-4580-b98a-08d7b44a21ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 08:11:18.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMWuuBK5balll026jYM+fyecfH3gRRULKw/BM2lXikKqtJzTzqVT6xpmdu69PqlqEYqmnVn9FOKnQM21jRdsUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6126
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=20
>=20
> On Tue, Feb 18, 2020 at 08:03:13AM +0000, Peter Chen wrote:
> > On 20-02-12 10:38:27, Greg KH wrote:
> > > On Wed, Feb 12, 2020 at 12:28:44AM +0100, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > Call cpu_latency_qos_add/remove_request() instead of
> > > > pm_qos_add/remove_request(), respectively, because the latter are
> > > > going to be dropped.
> > > >
> > > > No intentional functional impact.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/usb/chipidea/ci_hdrc_imx.c | 12 +++++-------
> > > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Hi Greg,
> >
> > With this patch applied, the usb-next can't compile pass.
>=20
> Did I apply this?  It looks to need to go through Rafael's tree which int=
roduces the
> new api, right?
>=20

Not yet, I just try it at my local for my chipidea tree.

Peter
