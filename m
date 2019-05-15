Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315881EC4D
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfEOKrZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:47:25 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:61093
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfEOKrY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 06:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r54AwftpI7UmhWN40o91BXoJitUTqd+cCRlfhGz16Wg=;
 b=NImhMCYxXhO3nWcRDdVHtX0a2ibl4GfgafqtPD61I5ELjpy/i0g8GLgirj2s5mZZGdfw4GGCnS6xm4ZRt60/0agReWfJ4T4Pd5gf00lANca4juby+7pA/GAjFmarzB+8qoQH87k3qPgVXB9JkHa9MbHrwGWCVt5dgrHhpHa87vw=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB4775.eurprd06.prod.outlook.com (20.177.192.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 10:47:16 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::b431:2268:b6f:7fe4]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::b431:2268:b6f:7fe4%7]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 10:47:16 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v4 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Thread-Topic: [PATCH v4 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Thread-Index: AQHVCwuP61JINGm00UuEGyPYjcnSfw==
Date:   Wed, 15 May 2019 10:47:15 +0000
Message-ID: <20190515104658.25535-3-nandor.han@vaisala.com>
References: <20190515104658.25535-1-nandor.han@vaisala.com>
In-Reply-To: <20190515104658.25535-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::51) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73cda900-28dc-408e-2daa-08d6d922b1e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DB7PR06MB4775;
x-ms-traffictypediagnostic: DB7PR06MB4775:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB4775ABC67F077DA7859DEF0B85090@DB7PR06MB4775.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(1076003)(50226002)(68736007)(2906002)(6506007)(386003)(81166006)(5660300002)(53936002)(36756003)(8936002)(52116002)(6486002)(99286004)(76176011)(71200400001)(6116002)(71190400001)(4326008)(6436002)(256004)(3846002)(81156014)(110136005)(316002)(446003)(186003)(26005)(25786009)(8676002)(64756008)(2201001)(66556008)(66446008)(66476007)(478600001)(66946007)(73956011)(102836004)(7736002)(86362001)(66066001)(107886003)(2501003)(6512007)(14454004)(476003)(11346002)(486006)(2616005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4775;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YnkE/7b6jekbebMJoAF88kuwYkzL4h9DaLVguEGhThRmzR7U0BtGgdDkfvZ6bCxHdOrpmukSgXcBxZ+EvUQKg/1dV6CR/8y0qrcwHG6/JaiByxsjyQE0WqAD4OPI1d0Z72Sm0DvRI6leaEOZTOZ3kdL/Ywuu+eRdlilS+hE8+MIFBRBub4au6hxCjzVkBtf2dCfgSVnG4jZELpJiwBhOKnEorcT6i4bm+vrYAV0xr5daepovz5VXWucg/V0dD1x4gUNB4Pj1NN2gAjEeGlYUxyKZZt1sq8dcfCzwasccGCMpHRy1ZjoZhneuMQJL6NeFABQQvrm6zy4mlAwvTqc31KGfCY0MMp6mfF1jhZq0rWt1pENJ4SSfsg4A3BGFHOYsO2CgL7rYlb+MNCO/q+Kbg6p3qQP4vVtjIarUglztXS4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cda900-28dc-408e-2daa-08d6d922b1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 10:47:15.9148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4775
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyBkb2N1bWVudCBmb3IgdGhlIE5WTUVNIGJhc2Vk
IHJlYm9vdC1tb2RlDQpkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IE5hbmRvciBIYW4gPG5hbmRv
ci5oYW5AdmFpc2FsYS5jb20+DQotLS0NCiAuLi4vcG93ZXIvcmVzZXQvbnZtZW0tcmVib290LW1v
ZGUudHh0ICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDI2IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLnR4dA0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252
bWVtLXJlYm9vdC1tb2RlLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
b3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQpp
bmRleCAwMDAwMDAwMDAwMDAuLjc1MmQ2MTI2ZDVkYQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1t
b2RlLnR4dA0KQEAgLTAsMCArMSwyNiBAQA0KK05WTUVNIHJlYm9vdCBtb2RlIGRyaXZlcg0KKw0K
K1RoaXMgZHJpdmVyIGdldHMgcmVib290IG1vZGUgbWFnaWMgdmFsdWUgZnJvbSByZWJvb3QtbW9k
ZSBkcml2ZXINCithbmQgc3RvcmVzIGl0IGluIGEgTlZNRU0gY2VsbCBuYW1lZCAicmVib290LW1v
ZGUiLiBUaGVuIHRoZSBib290bG9hZGVyDQorY2FuIHJlYWQgaXQgYW5kIHRha2UgZGlmZmVyZW50
IGFjdGlvbiBhY2NvcmRpbmcgdG8gdGhlIG1hZ2ljDQordmFsdWUgc3RvcmVkLg0KKw0KK1JlcXVp
cmVkIHByb3BlcnRpZXM6DQorLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgIm52bWVtLXJlYm9vdC1t
b2RlIi4NCistIG52bWVtLWNlbGxzOiBBIHBoYW5kbGUgdG8gdGhlIHJlYm9vdCBtb2RlIHByb3Zp
ZGVkIGJ5IGEgbnZtZW0gZGV2aWNlLg0KKy0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJy
ZWJvb3QtbW9kZSIuDQorDQorVGhlIHJlc3Qgb2YgdGhlIHByb3BlcnRpZXMgc2hvdWxkIGZvbGxv
dyB0aGUgZ2VuZXJpYyByZWJvb3QtbW9kZSBkZXNjcmlwdGlvbg0KK2ZvdW5kIGluIHJlYm9vdC1t
b2RlLnR4dA0KKw0KK0V4YW1wbGU6DQorCXJlYm9vdC1tb2RlIHsNCisJCWNvbXBhdGlibGUgPSAi
bnZtZW0tcmVib290LW1vZGUiOw0KKwkJbnZtZW0tY2VsbHMgPSA8JnJlYm9vdF9tb2RlPjsNCisJ
CW52bWVtLWNlbGwtbmFtZXMgPSAicmVib290LW1vZGUiOw0KKw0KKwkJbW9kZS1ub3JtYWwgICAg
ID0gPDB4QUFBQTU1MDE+Ow0KKwkJbW9kZS1ib290bG9hZGVyID0gPDB4QkJCQjU1MDA+Ow0KKwkJ
bW9kZS1yZWNvdmVyeSAgID0gPDB4Q0NDQzU1MDI+Ow0KKwkJbW9kZS10ZXN0ICAgICAgID0gPDB4
RERERDU1MDM+Ow0KKwl9Ow0KLS0gDQoyLjE3LjINCg0K
