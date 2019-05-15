Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109351EC48
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfEOKrT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:47:19 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:61093
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfEOKrS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 06:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u9BqwUmtDDu/KWqvz9XBAfdpofn+dPb2LSJams+++o=;
 b=An+G34YOUBZ4G4GnMsTsHP0unKBd6Yv1gxCPeioorpVdXafdKk/PVdKSKqkZYDclIefSywRMNTQOiU9Avtsdx5iAOn6LQSQalZgSB0MUnrNpQ2d/brH6Q7Csr54iVTswNELYo8++kYeKeyH33Gk16sZwSBE57p81sySkG4YAuJc=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB4775.eurprd06.prod.outlook.com (20.177.192.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 10:47:14 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::b431:2268:b6f:7fe4]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::b431:2268:b6f:7fe4%7]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 10:47:14 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v4 0/2] Use NVMEM as reboot-mode write interface
Thread-Topic: [PATCH v4 0/2] Use NVMEM as reboot-mode write interface
Thread-Index: AQHVCwuOATExu6UvfUqtdyRmrT15Qg==
Date:   Wed, 15 May 2019 10:47:14 +0000
Message-ID: <20190515104658.25535-1-nandor.han@vaisala.com>
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
x-ms-office365-filtering-correlation-id: 471b9fde-d6a9-4f82-c4ca-08d6d922b0d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DB7PR06MB4775;
x-ms-traffictypediagnostic: DB7PR06MB4775:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB477512209358F64ECC29CC6C85090@DB7PR06MB4775.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(1076003)(50226002)(68736007)(2906002)(6506007)(386003)(81166006)(5660300002)(53936002)(36756003)(8936002)(52116002)(6486002)(99286004)(14444005)(71200400001)(6116002)(71190400001)(4326008)(6436002)(256004)(3846002)(81156014)(110136005)(316002)(186003)(26005)(25786009)(8676002)(64756008)(2201001)(66556008)(66446008)(66476007)(478600001)(66946007)(73956011)(102836004)(7736002)(86362001)(66066001)(107886003)(2501003)(6512007)(14454004)(476003)(486006)(2616005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4775;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u3MFSbHHy04oHL46+mRp/ZjIwrIk9X70ggC+ePQEnL/3xiYSLjeDRvq6bSShHRd5a8O7MWJca5KR15EqJnXQpWGyXgayftag7bty2yLwJvd1l8bPoAWH/aboP6EtSHheTiMJKP3m4qP2dxKdBo0J5JJQb9a0kmyeRMwUwtveYVz6rHu2c7C8obFQ0u2oZLbNvvGLz+XlpYYsjfqDyNho5CtT0C0wj744slAdKSYk/bHX0to4DAV4ar+2OJoR0kT3Doq4qp1UfCutUDnwGQRVXbmeLXKtHWySrCjc/anMX4OlD4t4js6JxDr3xoPZdCh9e4tuV+1nalmCpbn+jKwBhc1oNXsCKC3/CsQn0b/jDOX1vYTVWity1viPSXuobr8VlLlEoaoQp7KupAnMsw3w1unSZWzjttGCmLvUWzRisqE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471b9fde-d6a9-4f82-c4ca-08d6d922b0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 10:47:14.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4775
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RGVzY3JpcHRpb24NCi0tLS0tLS0tLS0tDQpFeHRlbmQgdGhlIHJlYm9vdCBtb2RlIGRyaXZlciB0
byB1c2UgYSBOVk1FTSBjZWxsIGFzIHdyaXRpbmcgaW50ZXJmYWNlLg0KDQpUZXN0aW5nDQotLS0t
LS0tDQpUaGUgdGVzdGluZyBpcyBkb25lIGJ5IGNvbmZpZ3VyaW5nIERUIGZyb20gYSBjdXN0b20g
Ym9hcmQuDQpUaGUgTlZNRU0gY2VsbCBpcyBjb25maWd1cmVkIGluIGFuIFJUQyBub24tdm9sYXRp
bGUgbWVtb3J5Lg0KS2VybmVsOiA0LjE0LjYwICh0aGUgcGF0Y2hzZXQgd2FzIHJlYmFzZWQgb24g
a2VybmVsIG1hc3RlcikNCg0KRFQgY29uZmlndXJhdGlvbnM6DQpgDQouLi4NCnJlYm9vdC1tb2Rl
LW52bWVtQDAgew0KICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLW1mZCI7DQogICAgcmVib290LW1v
ZGUgew0KICAgICAgICBjb21wYXRpYmxlID0gIm52bWVtLXJlYm9vdC1tb2RlIjsNCiAgICAgICAg
bnZtZW0tY2VsbHMgPSA8JnJlYm9vdF9tb2RlPjsNCiAgICAgICAgbnZtZW0tY2VsbC1uYW1lcyA9
ICJyZWJvb3QtbW9kZSI7DQoNCiAgICAgICAgbW9kZS10ZXN0ICAgICAgID0gPDB4MjE5NjkxNDc+
Ow0KICAgIH07DQp9Ow0KLi4uDQpyZWJvb3RfbW9kZTogbnZtZW1fcmVib290X21vZGVAMCB7DQog
ICAgICAgIHJlZyA9IDwweDAwIDB4ND47DQp9Ow0KLi4uDQpgDQoNCjEuIFJlYm9vdCB0aGUgc3lz
dGVtIHVzaW5nIHRoZSBjb21tYW5kIGByZWJvb3QgdGVzdGANCg0KMi4gVmVyaWZ5IHRoYXQga2Vy
bmVsIGxvZ3Mgc2hvdyB0aGF0IHJlYm9vdCB3YXMgZG9uZSBpbiBtb2RlIGB0ZXN0YDoNClBBU1MN
CmBbICA0MTMuOTU3MTcyXSByZWJvb3Q6IFJlc3RhcnRpbmcgc3lzdGVtIHdpdGggY29tbWFuZCAn
dGVzdCcgYA0KDQozLiBTdG9wIGluIFUtQm9vdCBhbmQgdmVyaWZ5IHRoYXQgbW9kZSBgdGVzdGAg
bWFnaWMgdmFsdWUgaXMgcHJlc2VudA0KaW4gUlRDcyBub24tdm9sYXRpbGUgbWVtb3J5OiBQQVNT
DQoNCktlcm5lbDogNS4xLjAtcmMzDQoNCjEuIENvbmZpZ3VyZSBgYXJjaC9hcm0vY29uZmlncy9p
bXhfdjZfdjdfZGVmY29uZmlnYCB0byBjb250YWluIA0KYENPTkZJR19OVk1FTV9SRUJPT1RfTU9E
RT15YA0KMi4gVmVyaWZ5IHRoYXQgS2VybmVsIGNvbXBpbGVzIHN1Y2Nlc3NmdWw6IFBBU1MNCmAN
Cm1ha2UgQVJDSD1hcm0gQ1JPU1NfQ09NUElMRT1hcm0tbGludXgtZ251LSBpbXhfdjZfdjdfZGVm
Y29uZmlnIHpJbWFnZQ0KLi4uDQpDQyAgICAgIGRyaXZlcnMvcG93ZXIvcmVzZXQvbnZtZW0tcmVi
b290LW1vZGUubw0KLi4uDQpLZXJuZWw6IGFyY2gvYXJtL2Jvb3QvekltYWdlIGlzIHJlYWR5DQpg
DQpDaGFuZ2VzIHNpbmNlIHYxOg0KLS0tLS0tLS0tLS0tLS0tLS0NCiAtIHNwbGl0IHRoZSBkb2N1
bWVudGF0aW9uIG9uIGEgc2VwYXJhdGUgcGF0Y2gNCiAtIGFkZCBhIG1pc3NpbmcgaGVhZGVyDQoN
CkNoYW5nZXMgc2luY2UgdjI6DQotLS0tLS0tLS0tLS0tLS0tDQogLSBjaGFuZ2UgdGhlIG1vZHVs
ZSBsaWNlbnNlIHRvIEdQTCBzaW5jZSBHUEwgdjIgaXMgZGVwcmVjYXRlZA0KDQpDaGFuZ2VzIHNp
bmNlIHYzOg0KLS0tLS0tLS0tLS0tLS0tLQ0KIC0gZG9jdW1lbnRhdGlvbiB1cGRhdGVkIGFjY29y
ZGluZyB0byB0aGUgY29tbWVudHMNCg0KTmFuZG9yIEhhbiAoMik6DQogIHBvd2VyOiByZXNldDog
bnZtZW0tcmVib290LW1vZGU6IHVzZSBOVk1FTSBhcyByZWJvb3QgbW9kZSB3cml0ZQ0KICAgIGlu
dGVyZmFjZQ0KICBkdC1iaW5kaW5nczogcG93ZXI6IHJlc2V0OiBhZGQgZG9jdW1lbnQgZm9yIE5W
TUVNIGJhc2VkIHJlYm9vdC1tb2RlDQoNCiAuLi4vcG93ZXIvcmVzZXQvbnZtZW0tcmVib290LW1v
ZGUudHh0ICAgICAgICAgfCAyNiArKysrKysrDQogZHJpdmVycy9wb3dlci9yZXNldC9LY29uZmln
ICAgICAgICAgICAgICAgICAgIHwgIDkgKysrDQogZHJpdmVycy9wb3dlci9yZXNldC9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvcG93ZXIvcmVzZXQvbnZtZW0tcmVi
b290LW1vZGUuYyAgICAgICB8IDc2ICsrKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5n
ZWQsIDExMiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS50eHQNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wb3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS5j
DQoNCi0tIA0KMi4xNy4yDQoNCg==
