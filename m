Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA336C15A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhD0I4W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 04:56:22 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:13191
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235062AbhD0I4V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Apr 2021 04:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI8Q5ofkHJOuvPcMsD+ve18+w/gCqYG+WOrSeOv9vl1eUV7SegTzKX63tb7RU9buBztzN7Q/17SDhlviTt8TA/yeyvtEHHe/3ad/Q7CfSqrONAgDux5qhphaKdnwoMQ+PE+/R0infcBu+61ZZGHGIRQrtDzKYhZGGT9LM5QRy1B+VlaMiC1f4uRhCDWknBmtAXgz71gyMGXGtNDkDGGIDE+AbLB/QHbbamy2Mx9qrwA53znlpM5yIpMXiGELWb4Gl9Q6K+KqhWnISQ9aTHJ1dligITmxvs7Op6Wmly96ABjuPfju+caU2HQ1C0slxAdas4iDeSXRYFJCUPjySQZe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi79MxZSBauP2YUdAPnQBFwJcZinaATQkZfTD+FPbcg=;
 b=N/9V5Q79qCBtJteFMH0DioJ1R7g50JcQ4Hb85xNfPV9Ra47aN3pYgCq9qjoElu/yzrlIuHPIZ8AP/+tJD+yX0iwoNfP/+Oj63k5xx/jvoK5JfFVZr6f7A7JJYpXqbESHJ/rDvW8QoNblryqdxR1hWWUJ/vXJaMFsff/hBmLiFXivClmaRtyxIIAnJSES3r4wW7VvO5EbuYR+n2pwY08PUM9GMWz+N3bBfxF5pKUK2u8aZRRb8gdmOTzoW+YRQyQ3e3RqBRZmBPAh8R8acc2qfkLq7yqVpNk3AUcLu4jov9MYhXljNgtjkXCAzWQ/W3XREYEUdSjzW3S7dKEUzzZo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi79MxZSBauP2YUdAPnQBFwJcZinaATQkZfTD+FPbcg=;
 b=GkVlNyFu8VR9OABGk0qBHTLr9W2SPNShiEDz9MKnbK77mctuBxUUyyNEjjaTzat66/+zXJd8KWbvbBHhg1zFv+NZDM46zpkz+r9PPQtgRtiESpZqNGXU6OmTo0WDEpTusDuV+Cz+K3t0PzaNqIdEKxPfAmJUNnYKz+bw1zx50Qo=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DB6PR0402MB2934.eurprd04.prod.outlook.com (2603:10a6:4:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 08:55:36 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::ddbd:8680:c613:2274]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::ddbd:8680:c613:2274%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:55:36 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] thermal: imx_sc: add missing of_node_put for loop
 iteration
Thread-Topic: [PATCH 1/2] thermal: imx_sc: add missing of_node_put for loop
 iteration
Thread-Index: AQHXOfs4usZN6sm0pEq44rmzzqWam6rIEc0Q
Date:   Tue, 27 Apr 2021 08:55:36 +0000
Message-ID: <DBBPR04MB79307DF87746E3D5540910FD87419@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <20210425174831.164332-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210425174831.164332-1-krzysztof.kozlowski@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84abc281-b576-44db-5d7e-08d9095a397b
x-ms-traffictypediagnostic: DB6PR0402MB2934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2934DDD55B103F7A9650FD5387419@DB6PR0402MB2934.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyd8ZoPBIITPy6XZYcYcciTq6qq5wMAqHLx31f9tTr2gjT490fci/K7tk/YoY2i2GYvzVs5eDZ08Lj7C6VzdCT2Wk9p8ywTekvY8x0VqAGYi6hBPHSugAL7ZtrV9rPp5O8Q3daHtfKtqliK7de+BKTsvUkXC7xtlbASMvRi7XOMWJ/pRAQ1mBw1b438CvZHx17nb4qcetm/owyX+hCbYl24IaNHbu64KL2MjW0lT3g7cXK4O8oEeCvWH01jYwydcyOlrZF1MGR2ucCk3QNZ6dvZeYDyv9/e2Vl6zU2LtpajsMmaxyEYGG5Hg7JgNo3xs0IwCe6hXidarJE+Ng0kw+wO35XxayW60EXu2Og9Qa3N4Njgwh21XuZUAxqGNrY+IRn6spQ68kSe5SjQfCNkQLDGVW5OCARV0FuBHZdGgo/Hco9p4wU27uSD8UySZTuJw6Q24HuqIhFsWG3u0tQGOSc86PM32emhZTlhE5ZkT81+8sHIYGbcsoxZs46MPRbXWhx+u1WH4PPWJgTDRAkhitncsojlLO5BHx/MyY8GZNxNPKIhWBNF0q9eKNt98XMtXg58wdxnBpy+6nHp5Vhw3CusufL0qIiYOD4eJisqNodSA6Wuv98ppP2t83QWfMi2rK97JMxh3Tqm2wY5CUoUQZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(498600001)(55016002)(6506007)(186003)(26005)(7696005)(7416002)(8676002)(8936002)(76116006)(2906002)(64756008)(66946007)(86362001)(122000001)(66476007)(38100700002)(52536014)(5660300002)(9686003)(33656002)(110136005)(921005)(83380400001)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OGRRY2d3L1k5ZTZTbDdmOGNSTVd3UnR2bXhPQm1JeExPK05HSm5oSkJuZzl5?=
 =?utf-8?B?aVZVTFg0OG9TcVhZQzE3ZndLN2FQbDk0TUh3Ty9SSHN6VS9RVS93STk3WFU4?=
 =?utf-8?B?UXR6c1c5Q0J6blgxak4xRE1jdFRvRW9RV2Q0R2ZzOHhhaEJ6SGdEbUNtMW01?=
 =?utf-8?B?Z1JxZGtOam81VFNQR2g2MUVpQXE0YW43eFdRdnh6amNyckRhQmNaZzMreE4v?=
 =?utf-8?B?M0ZNdDdmYTEzV0N1WU9MRTdXS2p1Q3pXTStoWFR1V3lUOEdJUzI1eTVkTWhv?=
 =?utf-8?B?QysranlJeHZkME5DbFdRMHhrUVEwdHFSMkF3YU1Nd21Ed2lvdUtaQmZrNGtX?=
 =?utf-8?B?U1FGdXNyYWRHY0VsY0s4Wm9GdW9Sbkp6M2xzVUJxMzZLRzdDKzJCT3EzanB2?=
 =?utf-8?B?RExJOXh1RzQ5dlcydlBjOVlnR0xuSTZtTnJMRUFyUllEVXhXTGtJalc4TzNw?=
 =?utf-8?B?L3F2OFpUQUdua0piNnlIV2pyS2M4RHRuOG1jWktUQmY5amVOcFJkNUNkVGpC?=
 =?utf-8?B?a0Z1ZkhVazNMUE1WZmJFS0dLKzhZbVVYcmtLcnZ2YkVnbWEwWTA1VlM2b2hH?=
 =?utf-8?B?VHRNa2tWc0Q4RGFiWFBmZzd4T21CTm1naGxoSlNRSVBMNUhwcGxhUS9hdXlP?=
 =?utf-8?B?NFVCMWh2eFZ4ZEtFSEVzZUZHdnU2aHNrdjkxT25oMHRybUt4U0RwNG9RTGJL?=
 =?utf-8?B?RWtrZzBWUFdDQ0Y0OVdoenp6aFlyL1VORWlVVzlEdFNOVnJXZTBueEplKzlt?=
 =?utf-8?B?Vko3VWpyeDhxYzY0SHFKaUEzMHFVL3hseC9FeUZaQkdCcUgwSTFFUmJZU2Zh?=
 =?utf-8?B?VmpsVDY0QWVMZklmRnB5UTJCM21ndGJublJtVXE0OU9FSHI5bHk3S3ZpWnNw?=
 =?utf-8?B?TVVBTUVpOGpkY0VZVWlkdmsyYmVUQkNGdTF5V0Nid09qdnYvMk54eS9jeElx?=
 =?utf-8?B?aVVCWlRMb0V5MGdjeGRZd3VIZHpEd2w4VE5nK0puM0ZQamh0Y1hYUnFPL2Ra?=
 =?utf-8?B?ZG9vM0ZLeEplMU1mQmtLUTU2anlFMENCQjdzV1B6eTRvbEhEUlhsamE1NzYw?=
 =?utf-8?B?YUxmc1ZubERNL3Bac2UzY2dsalBlS3NyS01NV203VDI1b2Jkd1NjWmlVTHN4?=
 =?utf-8?B?VTNFT1ZRRkRpTjZieTNYTWpYTlNqZEQ1UHc0dU4yS0ZHNUx1c0hKSDhyMXho?=
 =?utf-8?B?OUpyckl3ZzhsVFRzOTlVVGRVSDNFUC9PckZaMHFTOXZaWTJ2SE04U3VQa1pJ?=
 =?utf-8?B?bGRjbGF2WXhBOFhKMjJtRHdXY0l1bTZHZG8wOTg4Q0lPWlVSc2hGQUYyRVNB?=
 =?utf-8?B?eTRBSUZtNmc2V1BLN2w1dWR5YnhnY1Qva2Y2eFJsd0s4Z0hUUWQ4M3dJdXVZ?=
 =?utf-8?B?MWh2MUw3Tmh5VXJuRjFMSVZKU0RPYXhTSEtJeTVOT21lU2F4Qks0Um9ybU5W?=
 =?utf-8?B?ZGJXbEQ0SFlPUzI1b2EwdXJiNHhzcEFrQ0dmUW84MDNIUU4vVXI0TUpvQ3VH?=
 =?utf-8?B?cnA4VzN4b1hmdkhkQlJVUzJxTE1xR1lyZXJYOVp5RFFndi9FR2t2WEY3NE5r?=
 =?utf-8?B?elRmREFEeDJ1T2dncjkxZ1BlQ05iVWRwQTdlUVZWUmhIcGlHOEhxNm56bG94?=
 =?utf-8?B?ZHVmRHdKTm0vek8rbVRoVENwLzdvNEhaQ2l5K1gyZG4ra3o3QkhrZWt4ZlA3?=
 =?utf-8?B?TS9kZStWdUkyckZwM3lTZEdKanJEQ01ZQTFYYVhtTW54ak5uenQ0MG5jYTc0?=
 =?utf-8?Q?/EP82QuE+DRSAlHNspvMq2roMFHIB1BWxWkjDzC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84abc281-b576-44db-5d7e-08d9095a397b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 08:55:36.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfRoxNk8lIk5lb3O8YrzdjNiJAOVyNV+YX9K4ZE8CEw+yeh0XMnK90FkoZMEdrmbCKUdmaz4Fnl3RHhHpKkvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2934
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSB0aGVybWFsOiBpbXhfc2M6IGFkZCBtaXNzaW5nIG9mX25v
ZGVfcHV0IGZvciBsb29wDQo+IGl0ZXJhdGlvbg0KPiANCj4gRWFybHkgZXhpdHMgZnJvbSBmb3Jf
ZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZSgpIHNob3VsZCBkZWNyZW1lbnQgdGhlDQo+IG5v
ZGUgcmVmZXJlbmNlIGNvdW50ZXIuICBSZXBvcnRlZCBieSBDb2NjaW5lbGxlOg0KPiANCj4gICBk
cml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJtYWwuYzo5MzoxLTMzOiBXQVJOSU5HOg0KPiAgICAg
RnVuY3Rpb24gImZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlIiBzaG91bGQgaGF2ZSBv
Zl9ub2RlX3B1dCgpDQo+IGJlZm9yZSByZXR1cm4gYXJvdW5kIGxpbmUgOTcuDQo+IA0KDQpSZXZp
ZXdlZC1ieTogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KDQpCUg0KSmFja3kgQmFpDQoN
Cj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1h
bC5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJtYWwuYw0KPiBiL2RyaXZlcnMv
dGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+IGluZGV4IGIwMWQyOGVjYTdlZS4uOGQ3NmRiZmRl
NmE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJtYWwuYw0KPiAr
KysgYi9kcml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJtYWwuYw0KPiBAQCAtOTMsNiArOTMsNyBA
QCBzdGF0aWMgaW50IGlteF9zY190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UN
Cj4gKnBkZXYpDQo+ICAJZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX29mX25vZGUobnAsIGNoaWxk
KSB7DQo+ICAJCXNlbnNvciA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnNlbnNv
ciksIEdGUF9LRVJORUwpOw0KPiAgCQlpZiAoIXNlbnNvcikgew0KPiArCQkJb2Zfbm9kZV9wdXQo
Y2hpbGQpOw0KPiAgCQkJb2Zfbm9kZV9wdXQoc2Vuc29yX25wKTsNCj4gIAkJCXJldHVybiAtRU5P
TUVNOw0KPiAgCQl9DQo+IEBAIC0xMDQsNiArMTA1LDcgQEAgc3RhdGljIGludCBpbXhfc2NfdGhl
cm1hbF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJZGV2X2Vy
cigmcGRldi0+ZGV2LA0KPiAgCQkJCSJmYWlsZWQgdG8gZ2V0IHZhbGlkIHNlbnNvciByZXNvdXJj
ZSBpZDogJWRcbiIsDQo+ICAJCQkJcmV0KTsNCj4gKwkJCW9mX25vZGVfcHV0KGNoaWxkKTsNCj4g
IAkJCWJyZWFrOw0KPiAgCQl9DQo+IA0KPiBAQCAtMTE0LDYgKzExNiw3IEBAIHN0YXRpYyBpbnQg
aW14X3NjX3RoZXJtYWxfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IAkJaWYgKElTX0VSUihzZW5zb3ItPnR6ZCkpIHsNCj4gIAkJCWRldl9lcnIoJnBkZXYtPmRldiwg
ImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFsIHpvbmVcbiIpOw0KPiAgCQkJcmV0ID0gUFRSX0VS
UihzZW5zb3ItPnR6ZCk7DQo+ICsJCQlvZl9ub2RlX3B1dChjaGlsZCk7DQo+ICAJCQlicmVhazsN
Cj4gIAkJfQ0KPiANCj4gLS0NCj4gMi4yNS4xDQoNCg==
