Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C117723F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCCJTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 04:19:32 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:33863
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgCCJTc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 04:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYydUbvdP7P4Y9vK5BxqWJsNdP9U/NrPDA6CEkoX9yWhfEaOEW9L/i6jey6Q3OOpdC9ASXnACa+ONliBMR+Np+Bzqb9R72SfcR3YiIKZ91ef8RcLF4Lpn+levwoVxlOCORYwbow1aPr+y2XkXDbG7L7ouss17GYss1hjZYr/BeZHiBU8Z3jrXMWGke1W82ryUAZ7cdGgbR5j6tA5Z5DAEiXJyfcqxYySd0VBqlugQR776zB9mkJMQDi+u6eptkq9l5W2fPfXuBi0oZmB3gtBXnXF/UcDzwNQw7gu9tClr4/FjunK3KALvFBCDQQ1P4UJ3eYv/z5GNTD75rxNvPDRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IWWxYBs31FH0KLcntFDl3bBxDAmEtxYZToqgZ+YYVs=;
 b=jQNFI9EXw99+InpPIC8qqf9hRMRmX1mPcAaYFcfgdz/1Oh3L5DItPX3+4fWaPos745duXr4TirlU/N3K66ZL1JXyz1/mtuPhWG/dKzn4ZFDCxL2QtYku5FK8KH8xwpw8ph+8P0sG12gmRb3n3rZhyMAAmUTD345KOuVF/oO6s7I3NeMsWdMxIFs7qWwCkV3qmIIdIsblgWZAMveIToUOiF+cYG2eqgqeyhtfyE8AQFe52sj5jXl+p77ilwA51NqIgnmcxuQghKEvaWOZct7PNWewX0E8ZP+12z4DkrbGJ8G9Ejys3q0KzMtl6WdyvV4REQQTa7YBYIeGiWI+1h5upQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IWWxYBs31FH0KLcntFDl3bBxDAmEtxYZToqgZ+YYVs=;
 b=emRn13jTm0nunDVZc2pURz3/nH1hEAHBoCI7AZVcYcaKerg4vU8mbbj2Do6MGIAJT2h/BbcNi/x67r3llIJ1sAK1yFbxToIZQa7/EnI9IvFpOCfzqLHrb7qp73Lq0KueutuyewM86vizEnDy/2QkLrp6grm4esFtC9P3vdSqqTo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3932.eurprd04.prod.outlook.com (52.134.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Tue, 3 Mar 2020 09:19:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 09:19:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] thermal: Remove COMPILE_TEST for IMX_SC_THERMAL
Thread-Topic: [PATCH 2/2] thermal: Remove COMPILE_TEST for IMX_SC_THERMAL
Thread-Index: AQHV8TNBiUH3WvjTAUmeBGRiRlmISKg2le0AgAAAk6A=
Date:   Tue, 3 Mar 2020 09:19:28 +0000
Message-ID: <DB3PR0402MB39167043F11D385FEC628A97F5E40@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583222684-10229-1-git-send-email-Anson.Huang@nxp.com>
 <1583222684-10229-2-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerNLQ11UR8AW2DcKC+9rh39KPWJG2uRiWGuwbFbyqPH72Q@mail.gmail.com>
In-Reply-To: <CAHLCerNLQ11UR8AW2DcKC+9rh39KPWJG2uRiWGuwbFbyqPH72Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 838999f1-bd1c-4504-2980-08d7bf53f9b2
x-ms-traffictypediagnostic: DB3PR0402MB3932:|DB3PR0402MB3932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3932A6C8758B09FABA674A6BF5E40@DB3PR0402MB3932.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(2906002)(52536014)(44832011)(316002)(478600001)(5660300002)(71200400001)(86362001)(76116006)(66946007)(66446008)(26005)(9686003)(54906003)(8676002)(81166006)(4744005)(186003)(4326008)(7696005)(64756008)(33656002)(6916009)(6506007)(53546011)(66556008)(81156014)(8936002)(66476007)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3932;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQjXGruNA53Aw2uzmiTEiBs/ODbL5J6+0h6wF+IXqiyeS9fyeZmSfHflmBlgBmDPJZN2aO6rWZdrJ7dNZszD6aT+mu8ckUl1Za1oUiCl98L+yP/p6D4yfggCSrsquWD20rriBWhnsWCHqsfectIdYleqlCgnmz+PzbIWyS+8LTBBr5r6YpkjGe+6x/Tldk1GI24vwFcK9x26BCnADyoybR/W89Yi5nkBLfRGRmNMWTz/f3B/2zrYTvX8CMVdoZGMAIvUoIWPAIR2hmxLC5ZHsTvi1T9gtH7ep7Gl/NaHIuUDuJ3+OwQy4IomFkJgN+qaV6+1ejtHJufwcFDe540HIvoJin9/MY6NnZwUBtKq2uIuAJima7Tt31EwFduH+ZpdaPOD0Hf7aJIhfPXOuLASAT9QAxWMiXi/Uk0bh2trpMBs7uJpoT8zQcBQb5P+JHM2
x-ms-exchange-antispam-messagedata: LvXjn0rcyz0E7EAwncfTJHIcVfm+fwH9ivBsEdF0+V7MT8MS/qOzdG6m3egbDVWZUrG2Fe3U1Bf/jygFZe4wo2eDclEhmIppsZRmcJcOXDr41YMSjbPziiOcVSmDHZQX3OutS+3maMAxCoKNjIV5fw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838999f1-bd1c-4504-2980-08d7bf53f9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 09:19:28.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56+wxjcgTgWyFU1c08n8MvmaKQUIz7Mu+2g0cyIc/2pQFWFGqruPZgkm4e5hzrj8syj7Qj6G894KlHHjJzLfBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3932
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFtaXQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gdGhlcm1hbDogUmVtb3ZlIENP
TVBJTEVfVEVTVCBmb3INCj4gSU1YX1NDX1RIRVJNQUwNCj4gDQo+IE9uIFR1ZSwgTWFyIDMsIDIw
MjAgYXQgMTo0MCBQTSBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6
DQo+ID4NCj4gPiBpLk1YIFNDVSB0aGVybWFsIGRyaXZlciBkZXBlbmRzIG9uIElNWF9TQ1Ugd2hp
Y2ggZG9lcyBOT1QgaGF2ZQ0KPiA+IENPTVBJTEVfVEVTVCBlbmFibGVkLCBzbyBuZWVkIHRvIHJl
bW92ZSBDT01QSUxFX1RFU1QgZm9yIGkuTVggU0NVDQo+ID4gdGhlcm1hbCBhcyB3ZWxsLg0KPiAN
Cj4gV291bGRuJ3QgYSBiZXR0ZXIgc29sdXRpb24gYmUgdG8gYWRkIENPTVBJTEVfVEVTVCB0byBJ
TVhfU0NVIHRvIGltcHJvdmUNCj4gY29tcGlsZSBjb3ZlcmFnZT8NCg0KSXQgaXMgYSBnb29kIGlk
ZWEsIGJ1dCBJIHRoaW5rIHNpbmNlIHRoZXJlIGFyZSBtYW55IGkuTVg4IG1vZHVsZXMgZHJpdmVy
IGFsc28gZGVwZW5kIG9uIElNWF9TQ1UsDQpJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY3V0IGFub3Ro
ZXIgcGF0Y2ggc2V0IHRvIGVuYWJsZSBDT01QSUxFX1RFU1QgZm9yIElNWF9TQ1UgYXMgd2VsbA0K
YXMgYWxsIHRob3NlIG1vZHVsZXMgdGhhdCBkZXBlbmQgb24gaXQsIHRoZW4gdGhlIGNvbXBpbGUg
Y292ZXJhZ2Ugd2lsbCBjb3ZlciBhbGwgaS5NWDggbW9kdWxlcw0KZGVwZW5kIG9uIElNWF9TQ1Uu
DQoNClRoYW5rcywNCkFuc29uDQo=
