Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F351621F8
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 09:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgBRID0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 03:03:26 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:28325
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgBRIDZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 03:03:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLZ+Zt3tDsA3sb1D2ZkeqJPmgRgoW+HYYezYdsKP8ITzlEWunCuu03K95xrodo4jhsMsBVDKs0gLHmz96DVEZiJ0u64xcTWTCzLgwCIPxm41DjbZxcA7WAyB9rF+pHPE/iqhfBfnMIoPO3eZlKSdMFgcdexf7w/ZVh9jLLO4itBESS1M7LZmkqwCJ5YvFuLHA/1fL/YMUEy/vnCsXaH9pnLcJ5oXihadTAi4nL1J0N9yDkQoHwKvKxU++HcW2vjDh2vuBknvPVyRNzMCLmPAAzgoJQXERM4Y3elVL7oBl/BDyA0IOS1GCTX766t2DzhM6qgRpcK4aRk1J5VO8h5oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16Br2kpiLMSh0/S1ibk6sri7P4dEzNk2pcC68P2NoUs=;
 b=FC46FonkXHtXsxihNT10fIpjtm1KO+3CguLBUwvg1LFxTEYoudoBqDyY3VoyDxT/5p+if3iU4o5GNNy1OaMRtdZqzTKXHBvhctgwHrFBhCWolAQLrrT59Zl0eAYgzUecfwuDFKFJt4BGQOcBr+7RNDxylGz/poH00aRhgUjZX7YQfFVjrmxODXGpricIQWWai/bBoPmn8d+CMGF+fSYrfjYzfWhZMO6I1wrB+jE8UErE4NQRJ/7YgRp2EInP5ES2awKPDrY2jWAj+YWjhhJcD5HUKxafsmlHpMYIY14l83XTOP7gl4K+R90aF+pYOWmTRIWz9E9PtqLaOIOZ1wfn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16Br2kpiLMSh0/S1ibk6sri7P4dEzNk2pcC68P2NoUs=;
 b=lmHkZkEpx1W3KoDRuRxUP6qnDDy5lJDJIYgjbwZFHRQcvsy7/iHs/usUixGPRQfhVGlomr4ZkyOjKXddzGghEZp0XKio2kX1VH63bLQMIR2qkhKY1MgzfcTATKrV1CRIidCiC1LLiGgwK5u8J0Ym4RCU+tOuUpviR44GLaOKjIM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (20.177.49.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 08:03:13 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 08:03:13 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg KH <greg@kroah.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Thread-Topic: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Thread-Index: AQHV4TRn3BXs86jgkEan911jMn55C6gX5NGAgAi8gwA=
Date:   Tue, 18 Feb 2020 08:03:13 +0000
Message-ID: <20200218080314.GB30350@b29397-desktop>
References: <1654227.8mz0SueHsU@kreacher> <19064076.ICumzjfW0v@kreacher>
 <20200212183827.GA1900941@kroah.com>
In-Reply-To: <20200212183827.GA1900941@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04ceddd4-c15a-43da-4683-08d7b44900b1
x-ms-traffictypediagnostic: VI1PR04MB4799:
x-microsoft-antispam-prvs: <VI1PR04MB479974CC4D66D9149F3D2EFB8B110@VI1PR04MB4799.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(186003)(26005)(316002)(2906002)(53546011)(33716001)(54906003)(44832011)(1076003)(71200400001)(6506007)(81156014)(81166006)(478600001)(6486002)(76116006)(91956017)(4744005)(66946007)(8936002)(9686003)(5660300002)(66556008)(64756008)(66446008)(66476007)(33656002)(4326008)(6916009)(8676002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxsnkHhSeM5XVEnLF8sUxgsxmetM0wFIeNGyMemvKA5moqtz8cGahg9L7jzwABAKeBWSyo4ytapdLisxogFWz4vegBLJGhzug0IW+1g8mYtpt5HVUT2btAn232C+Vr7djIC57FxUL2PzVjmZAdVigrEPQFpp9v+wiARqghFk13YfdDJoRgJk8NbjMZPl39BDsDlTESthITEvZp3XG8ye34R0DlWKuC5tQhwhRDvcdmN7ScSIhcgfQrTXS/Cplnkrfgxvcm8jGi7ovH91uF74zCllMxiKGzeTT5qyDbYf1p8cye3PEUNWyzhkkUfXKjIB0hDhm/CA30B2I4oZ7o9ut8SdRIOIrJ5Zi82D8zZvETlO2hRG/47rIWPIBaihjAsYa6n/do2ca/FXDDHc/yvekVV//XgGLppzaxIZG+KqaJed9hdr8PXorHxXgOnoCd3v
x-ms-exchange-antispam-messagedata: J5D/dTc8h546uJLR6d0qd7nLsQErNHARbN+h10w1D/PGbLTyv4/sIp84QpFAlAf4aNhG/8CXo4/BT8FN7pzglXYYoYrMOrQyRzQePstCrY9tF8WI9/sB0skmD2PqNQqaJRCmkpDP5WzBSSkplVDWyg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B3641F5F58C8D4ABABD9F3FE98C7F05@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ceddd4-c15a-43da-4683-08d7b44900b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 08:03:13.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 568mV9jvQUDAvsnCbHLUcobou5og9mKf9cE64gQwiTplYcHKPY1FgWbE9tUxzG/cYHKnKCkswtxH504TzHZisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-02-12 10:38:27, Greg KH wrote:
> On Wed, Feb 12, 2020 at 12:28:44AM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >=20
> > Call cpu_latency_qos_add/remove_request() instead of
> > pm_qos_add/remove_request(), respectively, because the
> > latter are going to be dropped.
> >=20
> > No intentional functional impact.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg,

With this patch applied, the usb-next can't compile pass.

--=20

Thanks,
Peter Chen=
