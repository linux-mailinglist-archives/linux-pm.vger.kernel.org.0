Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8415BB45
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMJMh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 04:12:37 -0500
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:6112
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729531AbgBMJMh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 04:12:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3jA5A2gx6WEg6uNgfXuNrad6d1np8ShaXqJdTGoaL0++Jf6Q0AvY+yaV6eeCVMRDZEPbCnI8gkvBhtvOI5t5kGyfW3BUdSQSmuD7cfGX772n7C5XUfnvgP1BdB/tFzVnlW3TWFexksQ49iFWT9y0T/VGm5QhbHjB5OR34VeY9i+w4Nc3HhgCaZVNoPKdA5RQMEKIdpX198Awh478WJyKuGBNXYMds5of9PbBPWL5UfuG+co+LU3Xn53C58rxrH0CEAos7PuOfoZUS9tv70jQKKGCRK1rpk8HSyPWQgxyS0D5z5neudOgT2sb/GOvGhweOD11ntRC9V50T/0/FbbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNWEQrDjRso15dCGz5gBQK1kGzqAQc2Qw2hDo+rLw0M=;
 b=XNiLlBG2yupEnksYoEKzPezGc7WcUJCS3KMMJQB95Yo30tD1v1ckqmRRTv4HHdaiStG2a1GcDljltvoJXIkRqcIemj10S/Aq5LRkIurMQOEdyq7ZVLteGKBqBRHz+wfVBDdJLYr+6o1aKT3muZxA14BjU+P+NeDIJORsUHmrzhqum5LDt+BKz8jP+cudBt04fznasR+QXu/D74Sd+euduy8xsEChcl0+zr/hsYtUw7YBYa0+6oxk9KZ14vWtMVEDdsKucPSdrJXNgPGUPOUDf9lQh4rSOMVSIHouiI2kk/r1GnGLe0GujPxRl7keWf7FmQ7KC8e2nH46f1vCKuqxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNWEQrDjRso15dCGz5gBQK1kGzqAQc2Qw2hDo+rLw0M=;
 b=EC/XKk4qczjVbBYgYHXbnsadiq2W1MEtSHdX51B4n3zoNGDvna6VwoY1rKReeQeGixCPSOzHF/+RAhi3njyNLPfR2iMk8zVjLVQhyJTZsYPB1/B01mcdt+BAIlyu3yz+bltEses0rb8oTow0OpzsGHesA4AfdYBTb6GNxOMuZOo=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4320.eurprd04.prod.outlook.com (52.134.122.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 13 Feb 2020 09:12:33 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d095:a19c:d6b5:da57%5]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 09:12:32 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QAAAkWqAADlKDXAABAwMAAAokcIQAANYbIAAAMUC8A==
Date:   Thu, 13 Feb 2020 09:12:32 +0000
Message-ID: <VI1PR04MB4333FD2725CA091989CAC979F31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
 <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200213084819.jveurrsvtv72ssug@vireshk-i7>
In-Reply-To: <20200213084819.jveurrsvtv72ssug@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 344cd507-3e39-43a7-3c6d-08d7b064dbf9
x-ms-traffictypediagnostic: VI1PR04MB4320:
x-microsoft-antispam-prvs: <VI1PR04MB4320F2C57EBCDEB52917B0A9F31A0@VI1PR04MB4320.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(8676002)(66946007)(9686003)(55016002)(44832011)(64756008)(66446008)(66556008)(81166006)(66476007)(316002)(76116006)(81156014)(186003)(52536014)(5660300002)(2906002)(33656002)(8936002)(4326008)(54906003)(4744005)(86362001)(6506007)(478600001)(7696005)(6916009)(71200400001)(26005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4320;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKLF93GZ+V+re8wGHG29eTr5M2omCk19La97OuK/cFr+WTbb4W5z2oiHW2pMYFEcjyEp4AtBqTc7kx/RG86NTbqNmcNg6TzxlNu8jyGqxyuNkW/OnuGi/+9ZF9kJK3M9+ZWJ96PpRW8By0mwfi15HHnFQ20Irm7WgyCy4D6/pCCuRVaydD3Fa94vATdNbFDBp9SQgCVyBRAiZgPWfbeJ6+ax+zaSQ2G5w8ZhKY5pzjFJRsTjm3nJmZ5wnH0BoxMI1AXpWwP/EhsEElAZoWokz5WmTJAy6IKu+KyI4QBNgG4Zz1OAGp+4l0xTLRp3xVXedtkBgivuyuJ6xA1j2QsAkDr1bVgBc05KDCoDtlvqjol19xdWYh9vJgkjutMGliqAT1LYOA4kag1tQPo0QP2Wcoml8b2tqjGmxcZeG+W7qE2W3/HUpBI7FyH8W7wn+4SK
x-ms-exchange-antispam-messagedata: 94seMYHlf7zfamI93nycrgwczVZQowmdIr/uCIZW0swVpOj+qn9JQ5ZkjD2uKm8tfCPKA+kXQ8DMjZ6dMbTo9DiVTgd5ZGQXMvrVQXpQnqbYT6iuWm1rrtODbmlQYpd5gdJyesrYwtfq4Ynaep/Z5A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344cd507-3e39-43a7-3c6d-08d7b064dbf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:12:32.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dw7HSvEDRH6MRJmIsP8EkwXnE2uPDJmKRKi62azdL1Me0/QiISIAIrFWaTqHDEugqFwxFmKBrS+OMeNSuInjjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4320
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVz
aCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjDE6jLUwjEzyNUg
MTY6NDgNCj4gVG86IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiByandAcmp3
eXNvY2tpLm5ldDsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogQXNrIGZvciBoZWxwIGFib3V0IGNwdWZyZXEgaXNzdWUNCj4gDQo+IEkgYWdyZWUuIFdo
aWNoIG1lYW5zIHRoYXQgdGhlcmUgYXJlIHNvbWUgc3Bpa2VzIG9mIHdvcmsgZ2V0dGluZyBzY2hl
ZHVsZWQNCj4gb24gQ1BVcy4gVGhlIGxvYWQgd2lsbCBpbmNyZWFzZSBzbG93bHkgYW5kIHdpbGwg
YWxzbyBkZWNyZWFzZSBzbG93bHkNCj4gKHN0ZXAtYnktc3RlcCkgd2l0aCBjb25zZXJ2YXRpdmUg
Z292ZXJub3IuDQo+IA0KPiA+IFNvIEkgY2FuJ3QgdW5kZXJzdGFuZCB3aHkgY3B1IGZyZXF1ZW5j
eSBpbmNyZWFzZWQ/DQo+IA0KPiBUcmFjaW5nIG9yIGRlYnVnZ2luZyBjc19kYnNfdXBkYXRlKCkg
aW4gY29uc2VydmF0aXZlIGdvdmVybm9yIGlzIHRoZSBvbmx5DQo+IHdheSBvdXQgSSB3b3VsZCBz
dWdnZXN0Lg0KV2hhdCdzIHRoZSAqVFJBQ0lORyIgaGVyZSByZWZlcnJpbmcgdG8/IENvdWxkIHlv
dSBwbGVhc2UgZXhwbGFpbiBtb3JlIGFib3V0IGl0Pw0KSSBoYXZlIG5vIGlkZWEgd2hhdCBpdCBp
cy4NCg0KVGhhbmtzLA0KQW5keQ0KPiANCj4gLS0NCj4gdmlyZXNoDQo=
