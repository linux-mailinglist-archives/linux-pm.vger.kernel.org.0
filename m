Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9834D1CBD12
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 05:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEIDvX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 23:51:23 -0400
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:6188
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgEIDvX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 23:51:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEQJyFCMiXMZ4TG/KxboPyLA66+xKEgFV9cyNED4KIO68vuh4ygJL4npNQPZNewMimCeNvspLm66+gbRwKyv7JBWDsGzH6QMp4496OKD+ZnCiZaeRAXNhRL7sn1E3qnpO/N5IvAAjO6cZ3lIZBcuXsm3d/wqw17vcIkou3qj/SxgPox5PO+4BwUS6oqfABPbwGo20rRNzC/U/jpB34H4jvGzg/RuUwxJOELMSPyiz/m+eZz2Utj5XhcWbyGDjJl6Gf/Rf0FJGI5nMv5fIUaLNdvOXiHDqR6lUJNBJrI6oxamCoDUiYc634SXhnEm9MNhaw+hf2ESvTd2irJoBwJ6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DKw5NJaPrlON8tfFVdPcd3XhjIarmoMZ3zdAUVzwa4=;
 b=nGLcRkZ8z/pQsaOmSzp+2RXsgr4x+t+a0HpP7UAkssW5pwzrARTpZtKTz0PgRhl7MEm0tQZU0/PLMQz82b1DEFDIDTOcFmV44Gyfdu62A9DFl7WbNL9K4UgT7voam75Sau62InZOMxTS3jsNstGiFf+lUeamL6+XjHLG+3tTp6btkAZ0H45oZZ8UTfpiCTZpbU6MHQtXxqWqvQWvLTT8T4pc/O2hTOlo9ZKn5bInhtKGblRRpaOYXlCfhOHTat02UHSn/wrsng0/TvnpIMA3AUlT59KTJzyOJ2n+Gr+TmfjZJ3l/krJp5mZViqviAJ4NTAnrTFgbhsXvCRZr1r/NIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DKw5NJaPrlON8tfFVdPcd3XhjIarmoMZ3zdAUVzwa4=;
 b=UXMb0PIef1Kza28lxicKeSqK9Cmzd5+xjdWy73boJEiyelFQEgpZVItnQ33WmsL5k2gDehCla/fUYT2vShyu97T5y6AZsmLNEJwTxCDQqYSeXOiuiiRcqGlzueZYY6gYc8P4/rVPUzBe1eLrTbDK0IXCXxqwabq3cYkGIFXFoEA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4310.eurprd04.prod.outlook.com (2603:10a6:209:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Sat, 9 May
 2020 03:51:19 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2979.033; Sat, 9 May 2020
 03:51:19 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH -next] interconnect: imx: Fix return value check in
 imx_icc_node_init_qos()
Thread-Topic: [PATCH -next] interconnect: imx: Fix return value check in
 imx_icc_node_init_qos()
Thread-Index: AQHWJa29IiyE1sVgb0mWjOX1icTJP6ifHq6g
Date:   Sat, 9 May 2020 03:51:19 +0000
Message-ID: <AM6PR04MB4966FFE3C487D217A91B070280A30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200509030214.14435-1-weiyongjun1@huawei.com>
In-Reply-To: <20200509030214.14435-1-weiyongjun1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2e96bff-e72d-4dd5-66da-08d7f3cc3ba5
x-ms-traffictypediagnostic: AM6PR04MB4310:|AM6PR04MB4310:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4310A3330355AEFA6DEAA26A80A30@AM6PR04MB4310.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 03982FDC1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRgs61Ry4FsLLaaxZMUZjlydhcnkUS4CIz8gMQR8woVeBpL5u8vnpTpjkulfQ986IREA7qYkm+FoDoikJwb3cHyejW2wETEhGoGEcbAVHc4/wl481NDFxr+r4dFPgNtVOvr0YUJkMpkmQZff4mYyRdQqztVyflX/i/QYB4foug+ZE95spY4VKLAYie6FXxRGAeHNS+gEvB6ADoQlYqLOVEqM8bUA9t3XAHJrq+hPl0J3g/1jRdYutVxLLeReqiAouHy4ZCfAd7LWyXwfqZMpoLFH2x4uJhlWCBjeYo4gXhgoQ9wOsT4G3v35mldItlEAoiuhKZHOkoDE5XkxkWIPvdK2Kur21rj+vSPb3oQKTealJfa7otfV8VgVMxIoIXfylKAs6tqJ8fnYebq/tiLT51pfJ+uX4+hLUEztna+UEgS+kk6OMBIsLo1K9pdoKnoY4jxxEeS4ppFDBnFqninHzwVt6eW9+zsMJH/s98zTVwR/2tISeYRUzvEB+Nb8qzdynL7z/TOITH+rRVhCTI3bHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(33430700001)(86362001)(64756008)(66476007)(478600001)(66556008)(6506007)(52536014)(76116006)(33440700001)(4326008)(66946007)(316002)(7696005)(44832011)(5660300002)(4744005)(66446008)(186003)(8936002)(55016002)(6636002)(26005)(2906002)(54906003)(71200400001)(7416002)(33656002)(110136005)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gbcHeIFuhjU1Rus+s8OQXmRAYE3B6jE41einC6fyBTjJ8LYuFdtqEOE2thRgFkMjFCja5oZqMGlly4SUto1O1eYrS6F7UMJLE3Tz/Ju49usi9pLRFuEr82z00I78wU1l8qwwjVCvgJQPhcQ40eTvRALG2JjVFkFRYUTVLuKoHZnc5uSAfbfmQqUpfZLtbqPKqsS7ZfqmthKs7CV2xlaXazxjxzFdHxZDkN7mF3kSJJQov6dwAEeOxmqDi4J6d9QCq88zMQlcZ4TmZ/d/eTU8zvbS8FnQGaDGj94c+URURD/3By0xbRotBs5MY2xAm2r9sueWIjM92LiJOCPZt807vpIJovoGlaNZFBtUH6zeKoRpeGtrQDgukNwbLJHazVntxp4X7PcUmVz4OG20ZpS3rIEMplgCFle2iuUHLu9fufN4702LSSUvwApdRdHf74G2NqZizehlu6wNaCWbAcyXXoHZNUbDdocdtoTFRFL2v0ucUwdwNQWvvTmHKL2eR6oG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e96bff-e72d-4dd5-66da-08d7f3cc3ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2020 03:51:19.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKPlzNSvPrJ7lIE/2UgcXQvx7CKDVJhqk9SZ0ohueLCfjNUM+Nc7rir2BdjiOvZbg6xKt+g1O7GXrT5lDHOctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4310
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBXZWkgWW9uZ2p1biA8d2VpeW9uZ2p1bjFAaHVhd2VpLmNvbT4NCj4gU2VudDogU2F0
dXJkYXksIE1heSA5LCAyMDIwIDExOjAyIEFNDQo+IA0KPiBJbiBjYXNlIG9mIGVycm9yLCB0aGUg
ZnVuY3Rpb24gb2ZfcGFyc2VfcGhhbmRsZSgpIHJldHVybnMgTlVMTCBwb2ludGVyIG5vdA0KPiBF
UlJfUFRSKCkuIFRoZSBJU19FUlIoKSB0ZXN0IGluIHRoZSByZXR1cm4gdmFsdWUgY2hlY2sgc2hv
dWxkIGJlIHJlcGxhY2VkIHdpdGgNCj4gTlVMTCB0ZXN0Lg0KPiANCj4gRml4ZXM6IGYwZDgwNDg1
MjVkNyAoImludGVyY29ubmVjdDogQWRkIGlteCBjb3JlIGRyaXZlciIpDQo+IFJlcG9ydGVkLWJ5
OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogV2VpIFlv
bmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hl
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
