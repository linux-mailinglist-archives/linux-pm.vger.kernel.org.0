Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E56229E2
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfETCPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 May 2019 22:15:55 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:32482
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfETCPz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 May 2019 22:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Leql0F4HY/Qi8RQupnp9smr0mCdyoDM/R5FK7F/0AUg=;
 b=iYO1AG+VzPCb79eIu5+LP7u0A1B7z0wMRg1jejiXnOel5jiSpUwp4Cw8MEKuUiYBjLIM+Odf8san5KT/2WMcsVx2hrv4e6x+dqf5qUEOz9Aonf9x0aY4uwKht1lw/6C/wqqqH8dH3RpjsCqJ3WI8aoO1Mlvaagy701EXQbHcR+8=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2820.eurprd04.prod.outlook.com (10.175.40.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 02:15:50 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 02:15:50 +0000
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
Subject: RE: [PATCH V2 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
Thread-Topic: [PATCH V2 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
Thread-Index: AQHVDGHy6riuNjMX8Emng4J8Z2yFlqZy/KSAgABOAOA=
Date:   Mon, 20 May 2019 02:15:50 +0000
Message-ID: <AM5PR0402MB2865ED4DFB84BF2AE85EF0ABF1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190519213457.GG31403@amd>
In-Reply-To: <20190519213457.GG31403@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb738bf7-bd63-4a94-d47c-08d6dcc91457
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2820;
x-ms-traffictypediagnostic: AM5PR0402MB2820:
x-microsoft-antispam-prvs: <AM5PR0402MB28209683DF9DC204FB00E4D2F1060@AM5PR0402MB2820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(366004)(189003)(199004)(66476007)(66446008)(76116006)(66556008)(64756008)(66946007)(11346002)(446003)(6506007)(53546011)(4744005)(486006)(73956011)(476003)(305945005)(7696005)(26005)(99286004)(186003)(76176011)(66066001)(81166006)(81156014)(8676002)(54906003)(102836004)(7736002)(8936002)(68736007)(9686003)(6436002)(229853002)(478600001)(55016002)(14454004)(14444005)(5024004)(53936002)(316002)(25786009)(256004)(33656002)(2906002)(7416002)(3846002)(6116002)(4326008)(52536014)(71200400001)(74316002)(5660300002)(71190400001)(6246003)(86362001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2820;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VP2r1rc65WSFI5jZupwR6kx226WYNoqlBtLUPFzb0NGGbxb+WP1wUwPjj5jxW/qxxvClnav/lD1AZXuv0dkYHf3pUs6mMzh0vW2+psB3yAT2nA0DKeQmT60V8//8ezP4N0M/xPjkaRxS/1KHB8iVvLRSBSz0d8FMY2430eBoaX8MXJdTr1ERSC1H41hheEkcPoMO02JQseBVnNu5QG8hSETAK86ehdfUZwI162En03HdmfljIdWQ6ZTXTAK3P+3fjQ1gUMJN8yynTqC+/rmBtypW5u/mlS1ger7s70uYCQAHv9nKHA+qXBzHTee1UfRimqbaWKgxJM0n8Qs0NhH2vOXL312Lr51n5++8m3XRkNIXhdOiQZTPJPPryIVKiOUhSW3Jhsv50NZoAP2VnB6ZiG/pLuAZjDK3d7aE5J3+GC4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb738bf7-bd63-4a94-d47c-08d6dcc91457
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 02:15:50.5690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2820
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavel,

On Monday, May 20, 2019 05:35, Pavel Machek wrote:
>=20
> > --- a/include/linux/pm_wakeup.h
>=20
> > @@ -70,6 +71,7 @@ struct wakeup_source {
> >  	unsigned long		wakeup_count;
> >  	bool			active:1;
> >  	bool			autosleep_enabled:1;
> > +	struct device	*attached_dev;
> >  };
> >
> >  #ifdef CONFIG_PM_SLEEP
>=20
> You might want to format this similary to the rest...

OK, will update, thanks.

Regards,
Ran
