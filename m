Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF640812A8
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfHEHBV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:01:21 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:40966
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbfHEHBU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 03:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQK/kRJinKgvce2T3hkzKlDRSUg/MNV0n9ChE53g8MVRAzCmLGjG6HG3j8eyP90xnrUZ4BxCdLFqfEzOHxZ8yLVtOBM4Qpog9dYur5jGlK1Hiqpz3a7rE4SBDXML1tDbn/OHSFDcUpOIwGw5l3p8sWcIxt8o51fVL6BDwh7K/SIzXX4jSD+PRheDHcvLUxwYQKPhXba17CiVVZID55Jof2g6c8NwjyUsZbsChwk/ibBxBqWCBo3KoegHveJc64NkQTLWnXHG+s92AmiH3WO1odhz91Htqh6qSrDygJpzY4NtOEkq2WP7TxHLAvlJfP+8eCw4eDZTVY73wHNo7bpj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFqAhCJJhFO9aWaSGKFKnIZ6BTHSm8+TnDF9WJn1enw=;
 b=jJAj9+w1XXdDfDNwGRHWqJRJ0OGzCTxJsl3cpiyAvPElH+4iG3FAPbQPZ6pd6y+cjDBmsbegIeTZdSrNzTaZqJFIzLSby7AOm82rGYUFOud3o9fJimXboTpy7/mJ5Ss8GGrqtVIhyaeqPU8gYbKgo0FvgQO0sQhshpi5t/BA8eBo88YjA9WLIhi2mYNZsMcejtb803d2+ozFfFZbas7Lv8Udm8MukNc8tAkWeStwige0DXZxhTYpoXK3UoCNNZBRykBoZFcj4pCM0A7ijhrn7+d6m7n3KjbH2l+ATintIarFnvHIWbTajD1nmnpjqRJen0CuE4dbA6eTjTaW4+gSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFqAhCJJhFO9aWaSGKFKnIZ6BTHSm8+TnDF9WJn1enw=;
 b=BRBPHGG6RjnxdqMlfsSmrPKkfnKIxojoMMY5IGOxyByPSdnD8pZOSLXqZIB1PRDdbfzuLAuHtlMO+WWLlUw0NjJhyyv3ndmjIn5/60jfyJTbJaFzUFe3nC5UaVkkhNESC47Yx9G62JzpEZlXRpkDMzd1h6nDYW+lq1QQqwqKbeg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6947.eurprd04.prod.outlook.com (10.255.225.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Mon, 5 Aug 2019 07:01:16 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:01:16 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 2/5] thermal: qoriq: Fix error path of calling
 qoriq_tmu_register_tmu_zone fail
Thread-Topic: [PATCH V3 2/5] thermal: qoriq: Fix error path of calling
 qoriq_tmu_register_tmu_zone fail
Thread-Index: AQHVRn7Ux5+EnIaAuk+tgS95vYqSbKbsKgfA
Date:   Mon, 5 Aug 2019 07:01:16 +0000
Message-ID: <AM0PR04MB4211DB8BE9466954147295BA80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
 <20190730022126.17883-2-Anson.Huang@nxp.com>
In-Reply-To: <20190730022126.17883-2-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b1e869-34bb-459d-084d-08d71972b608
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6947;
x-ms-traffictypediagnostic: AM0PR04MB6947:
x-microsoft-antispam-prvs: <AM0PR04MB6947939DA69A147C0634475680DA0@AM0PR04MB6947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(52536014)(7736002)(305945005)(316002)(14454004)(66476007)(2906002)(256004)(76116006)(8936002)(74316002)(66946007)(71190400001)(71200400001)(7696005)(64756008)(66446008)(102836004)(446003)(3846002)(558084003)(6506007)(11346002)(66556008)(26005)(2501003)(81166006)(81156014)(110136005)(86362001)(6116002)(6436002)(99286004)(76176011)(478600001)(9686003)(6246003)(44832011)(55016002)(229853002)(8676002)(66066001)(186003)(5660300002)(4326008)(25786009)(33656002)(53936002)(68736007)(476003)(486006)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6947;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TWKOyV6cX2D42wwET2aAIQ4DVxN5X/E7Qc63lKxFRYYq23ICG72b7tOGpdJmKVUe6PArzQB8jcRMZdGCZi5U4Z8Q26YenFBj1sS9cllL8MhwZJdFMpPlaRIR7XO/Frrvz3cm9+JVejATAmXKJ7z4HbqR2IzRPWaUwwcMH/7mEDwlIMiPEWfJ5AxjPtieb2+YmpEQz/wUF3jFsk/yVebG5JY+Oprjuz3LIlehlybnS5CRcKO9mKtgT7D9kXCxfUAbBovDUnPCtKnutmUby3NQtJgY9bmcyxk27EtIsSuvCTO06Id0tpriOg4B9J0rJpo8xUVknTBihlNze3lGP3G7fT2c1enDvwKkaXi1e/cOemgRiy3ot/MsEJEKZ1oz95dkm6rU60suPgQwFVhbMggGUJ29supPyJ+0cZmK6ni0yK4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b1e869-34bb-459d-084d-08d71972b608
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:01:16.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6947
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDEwOjIxIEFNDQo+IA0KPiBXaGVuIHJlZ2lzdGVyaW5n
IHRtdSB6b25lIGZhaWxlZCwgdGhlIGVycm9yIHBhdGggc2hvdWxkIGJlIGVycl90bXUgaW5zdGVh
ZCBvZg0KPiBlcnJfaW9tYXAsIGFzIGlvdW5tYXAoKSBuZWVkcyB0byBiZSBjYWxsZWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg==
