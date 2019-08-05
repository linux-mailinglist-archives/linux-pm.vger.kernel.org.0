Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17DA812A3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfHEHAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:00:43 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:22020
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfHEHAn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 03:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7uFjzgw/B55jV44PMP6yh0CeCu+R5jXKYjJ1IginFvzFf+KSKGjbFRa/pame5j/H0R/8ITkfJTAtsb6Ff31c1zmMuGuinP+eZ3EKD4P8qDizGs6L2d6kFv4k5E7eITCd44zIIlAUOvRpMZKSJsIHv0fJYF6vyeMwJPguZgQuVb4D5ILfZ4tAGX6gUgxhYmcEGQ8P5hcIgiNTKAtUp4qoN0AffpL0DCSg/NWwteucNwWDM3Fl80eVYnBGqEyVOn1GTjcX43wn5C1woiOoeYg0oTVIwU95n5jYXFySgf295YILRgXwyQrTD3obEgk7ibnqb94bQ/H7SH6yTS93SJtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emf//9XX5rEjTDLwFnDdYcqR3JOz99mvztNwBsSXm7Q=;
 b=iVpBFGMgtbI9CxAzZXk5vMtEUQZbHTK/gqx1wWNhSlEmFndBgljMlPDOInaDhTVZ4BF+Lri73P41Fsa1RujqriN7R9vOKOi0xlFO3v83rDAsT0zR4qcAXZ9NwAUvO7fbrsVRkqmEZLPTvzdKKR+gASUM1NhJYytVweuUSZh+wsvI2IRDB27IcSDEdQE2T/4c3vLh8kZ3ufFOYg9fUag93AMHDaCklI94JWUq/dikc1NtkhgwWekRnrF+4XSEzQ6JhopGjYqEcmDiYHOGnKfme2bsYuit+KTERB6W8v0cfusr9rUQ7PyWP4SA/vfLI372P1ZyKyoWf+hwrtiuGtVXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emf//9XX5rEjTDLwFnDdYcqR3JOz99mvztNwBsSXm7Q=;
 b=LOnEYYo8sCHBK9a5+Z8YlYfCTPtlsqW3hL62gr1XI8zb52st0rn/aIqCqgPn8I1YrCzIvZ1oagNuQhQxYJbpu2VW1YY0QDesKvYJkHiVIhkDPKeM2/LMKalRf4H4h7ONB04NRoVYIeMw6+bo+HvzqB0xrwVYao+FBN2lRGvevAs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6947.eurprd04.prod.outlook.com (10.255.225.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Mon, 5 Aug 2019 07:00:37 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:00:37 +0000
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
Subject: RE: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7T5OGYuqP7WEuKEtk4ncRMTqbsKdIg
Date:   Mon, 5 Aug 2019 07:00:37 +0000
Message-ID: <AM0PR04MB4211DA900C624AFE404946F480DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
In-Reply-To: <20190730022126.17883-1-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9090ce06-f01f-4ba7-5b93-08d719729ee9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6947;
x-ms-traffictypediagnostic: AM0PR04MB6947:
x-microsoft-antispam-prvs: <AM0PR04MB69473D54C520B8F80EF4854B80DA0@AM0PR04MB6947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(52536014)(7736002)(305945005)(316002)(14454004)(66476007)(2906002)(256004)(76116006)(8936002)(74316002)(66946007)(71190400001)(71200400001)(7696005)(64756008)(66446008)(102836004)(446003)(3846002)(558084003)(6506007)(11346002)(66556008)(26005)(2501003)(81166006)(81156014)(110136005)(86362001)(6116002)(6436002)(99286004)(76176011)(478600001)(9686003)(6246003)(44832011)(55016002)(229853002)(8676002)(66066001)(186003)(5660300002)(4326008)(25786009)(33656002)(53936002)(68736007)(476003)(486006)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6947;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lCRjsAKM1qQ6OEGyytjSWZ9sQifVkwvMFrA6BOqlSiwiMJi5luzaKNZGMratgQRSL5FT/nxbsRztmdGFHco9XK+xyb0gerraSYNcBI0fTvt7/fKLD9Q35nk7fqaZW+NNj9xy6fCQM7NCbjynJzt8Lhwm38ZRr1Q+/At9wliDWB69ajXEPFCEEMQSE85aohJReeSnxJNfuLE3oeoOng8T2AFFJ1v+6aAXmpwPs6Y1KwIfzi9z/jcWQiPyN032n9AB9hfZhbMC/XhJENenHx/oLq3/zqXArv7iVQLNKcwYqt8GoUJKA9lCai7CvkXUgdJWnvKG1HuKOIpFJwDdWJkEvGzUWpc0mF/DPUHQhv+m5ZmPyFTEtiVBR+wTEUBelEgQ+ApzgRyac2JxTgiG3494Nv7/1dIuqp+BNrvmnFvxiCI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9090ce06-f01f-4ba7-5b93-08d719729ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:00:37.8174
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

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFNvbWUgcGxh
dGZvcm1zIGxpa2UgaS5NWDhNUSBoYXMgY2xvY2sgY29udHJvbCBmb3IgdGhpcyBtb2R1bGUsIG5l
ZWQgdG8gYWRkDQo+IGNsb2NrIG9wZXJhdGlvbnMgdG8gbWFrZSBzdXJlIHRoZSBkcml2ZXIgaXMg
d29ya2luZyBwcm9wZXJseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4
Y3B1Lm9yZz4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5j
b20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
