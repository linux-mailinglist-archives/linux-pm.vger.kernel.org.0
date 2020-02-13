Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8377815BAAF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 09:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgBMIT3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 03:19:29 -0500
Received: from mail-eopbgr1410120.outbound.protection.outlook.com ([40.107.141.120]:38630
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIT3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 03:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsHHDVVFTisn9OPCitXa11S8TnBETtVWzUF4P9LIOTGO/PI6nhKjSddbK5hzqmfrw3PTsvS//gtqjv7A25H7mAPuI81Vf/YjAB1ajpldOd2XEPMFc5oMsT5KCXJ1J0FFAqZ6qKwvFK+90UKyWcsaDP7xV34CQB77YnEr8ARJI2RfeOKobzbsj50nCNhhPmYmjVluNVWJ/dMrd2/O5NXr5+8BRzdkJGmvRMN/FBR2SVkrBANG5ad3uR4npIIJAnDeb0Cx1MwLEwl/XA5G4UndxDDYwGfkza37WDBAl2FvDz2vWL3nbvKyVrxKtEi63aWXk/ZdVpCAKACEPswp5z7uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyZmR6k38T84XxhSAXl9Sc6xSRT6TOmoFT/K75fOWH0=;
 b=PXVH49s0+CgF8de7rQg2BPOP5Q7roIt50NH9K9I+jnOgqEuyHeMpiGIqmhFOx+yNbFSjPXB5lorzz+hQ5WjJ1XB2TwaDHTt7W7nv9qdMVIWC4jwF45uXWgO0t48hTPNTiuknVIwT1DaPje/DyPfEFAMhFWFbdJ1sBUdgM4JLS+Z9LzRX3iJw880ZT5xto2yE/I7CqK+es0zO6VHrUU7CJE8ZZA/pfjhm4/bsQcsKDx7JEU3wF+04XGOuLhR0wIfXnHAYfUbFV0Mq4RFpCS94KlphHXMaT/be/NxGcCosPAxqFjfINzHiRlGYAOUjt4qJCmjMI0GgRiD7f/JhG6R4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyZmR6k38T84XxhSAXl9Sc6xSRT6TOmoFT/K75fOWH0=;
 b=dtLI/dR8f6GkdFozyt3O9BhViRPKqEZJ73+fSlnwUaoP2UkzD6dQvwB2ioPL2kGjb6m1iqfmAkujbWfwRy113b4/HlSdA6lpDozQnTOxMJau2yNZrcdMqkmU+rzw5vVnm8JH6PghNXGuIE+jWH9zxo3UpGULbpC9xgwZDKpZH78=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2448.jpnprd01.prod.outlook.com (20.177.104.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 08:19:25 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49%7]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 08:19:25 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
Thread-Topic: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
Thread-Index: AQHV4fayiTaau8ihhUy+TTF4eL34vagYyHCQ
Date:   Thu, 13 Feb 2020 08:19:25 +0000
Message-ID: <TYAPR01MB4544B49ADC69B7B14B250E43D81A0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c60b681-bb5b-4ac9-08b2-08d7b05d7048
x-ms-traffictypediagnostic: TYAPR01MB2448:
x-microsoft-antispam-prvs: <TYAPR01MB2448FB137E8572E20813AA41D81A0@TYAPR01MB2448.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66476007)(66946007)(81166006)(66556008)(26005)(186003)(76116006)(66446008)(478600001)(81156014)(64756008)(6506007)(55236004)(8676002)(71200400001)(8936002)(7696005)(2906002)(86362001)(66574012)(316002)(55016002)(33656002)(110136005)(9686003)(52536014)(5660300002)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2448;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AqwzBGzttDxkIckEbulpL3glnTKLITvTkQG6c9bvcaEKcFZDLjweGDxSahdgYG4Aj9wf0wHoLF8UY1yrJrGIdhZwv9B8QcqrpGERhqVrnre+h0PeZ6GlCL8gvYx43R1oO1B2psGpJD73Ace3xN2or9arcSlfin0yJuoimQZSRAfvzH8QmaBU776bp9nUDQjF2z4eqNTNJhTWWgiwKIXeRFcQ9fsQ3bqreAZIdMA5rlcQsD9SKaM6Z2y9EllcPnZDFQs/4JYDWRhbeG41xX++KOuMl7DYkpidxe8/55Jj8EFyU61ZMJtfTaLp6w3F0E++PEB41JcGKVk9y6IJPwmJjky0OHyPqZQPEGfo+UrzDo1jsa077tSQAl9NS2TIqSwtKr8r7T+8mdNSQ3D4nz7BBc2S/Q6YrSVQCZMjv6/Lc5sEdQRDbhJzdvNJxxE6Ndhv
x-ms-exchange-antispam-messagedata: C6EKQqadG5dUdLI0T71F7DYlSvJZ64Z1GuRI2wgc1ISy1+Ty1cVrCqW29IRKJxbJp/gN36Ph21w2Rr3jPkvPBfftgdreSAiF9tn2xa7B+IcpBi8yecV8K+wDvpNnNPoKijvq9x2ecCZ0Kb6DIZIssA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c60b681-bb5b-4ac9-08b2-08d7b05d7048
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 08:19:25.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOpKrT82NfeQPo2byYykZiZ3M54FbGAXbVvVs1giupPle9qbM7k3GAwsLQGJLF1yztn7SPqtSG6jUFl5KrnPLv7uaYVRM0xfVzClBMCJNoy0yVu6TA68yGx/Suxb3UTp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2448
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmlrbGFzLXNhbiwNCg0KPiBGcm9tOiBOaWtsYXMgU8O2ZGVybHVuZCwgU2VudDogVGh1cnNk
YXksIEZlYnJ1YXJ5IDEzLCAyMDIwIDc6NDkgQU0NCj4gDQo+IFRoZSBkZXNpcmVkIGJlaGF2aW9y
IG9mIHRoZSBkcml2ZXIgaXMgdG8gZ2VuZXJhdGUgYW4gaW50ZXJydXB0IGFuZCBjYWxsDQo+IHRo
ZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKCkgYXMgc29vbiBhcyB0aGUgdGVtcGVyYXR1cmUgaGF2
ZSBjaGFuZ2VkDQo+IG1vcmUgdGhlbiBvbmUgZGVncmVlLg0KPiANCj4gV2hlbiB0aGUgc2V0X3Ry
aXBzIG9wZXJhdGlvbiB3YXMgaW1wbGVtZW50ZWQgaXQgd2FzIGJlbGlldmVkIHRoYXQgdGhlDQo+
IHRyaXAgd2luZG93IHNldCBieSB0aGUgZnJhbWV3b3JrIHdvdWxkIG1vdmUgYXJvdW5kIHRoZSBj
dXJyZW50DQo+IHRlbXBlcmF0dXJlIGFuZCB0aGUgaHlzdGVyZXNpcyB2YWx1ZSBkZXNjcmliZWQg
aW4gZGV2aWNldHJlZS4gVGhlDQo+IGJlaGF2aW9yIG9mIHRoZSBmcmFtZXdvcmsgaXMgaG93ZXZl
ciB0byBzZXQgYSB3aW5kb3cgYmFzZWQgb24gdGhlIHRyaXANCj4gcG9pbnRzIGRlc2NyaWJlZCBp
biBkZXZpY2V0cmVlLg0KPiANCj4gUmVtb3ZlIHRoZSBzZXRfdHJpcHMgb3BlcmF0aW9uIHdoaWNo
IHdhcyBub3QgdXNlZCBjb3JyZWN0bHkgYW5kIHVwZGF0ZQ0KPiB0aGUgdGVtcGVyYXR1cmVzIHRo
YXQgdHJpZ2dlcnMgaW50ZXJydXB0cyBkaXJlY3RseSBmcm9tIHRoZSBpbnRlcnJ1cHQNCj4gaGFu
ZGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBTw7ZkZXJsdW5kIDxuaWtsYXMuc29k
ZXJsdW5kK3JlbmVzYXNAcmFnbmF0ZWNoLnNlPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCEN
Cg0KUmV2aWV3ZWQtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEBy
ZW5lc2FzLmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
