Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91651755F8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBI0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 03:26:19 -0500
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:55521
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbgCBI0T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 03:26:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZqDuuo7gB01O6obsL7YYZcL9LBcnBt/9JMLkd7MXzDubGXzGhFkxKt0tYAdmNwie/MbRY9LW/xNDLikQZnKwJszzvGjd30xN19/XA3BDj7DqtRUPbbur0MblXht/5loH2prIus91Etj0XvgB9clxLKLtwJDo/FF0YzH3KFlyvg6LEBOb07iWb+UzBluyNy/PJ91JbhjT4htmlqwZkrCzRcncCN2HGbUG3WWRwYoGoFglbK94JqhZqMjKVHRCK3NPmJHWfNardWxeKRy1FTnxdJ1TI10Eyt804OiULfoHAeVWVoPNO3Hh/DMASvle78PSCVlA0hnlQqhdpQJG/hprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ACdaGopONiBvmA8JYS9jezNfrXgF5XQcoM8cnnkrY=;
 b=j0Qi4VkHgltbCEcnVdnlqDtR64YLv6CLlK4/NOW+wT+0SEz276sGULyv9SEozRXlG+apDvJuN7K2/ARUUJpVsyVG2DnjvjNgQvKGPS3qEt3mcinCaTFv8ulF06ytTurk2u9d/FfsFFNYoaY0CipqfKRgu1PTDq0edByMA5ZI82DD/nrKDx/HO9MLwJ0Z14IJVJurUSClotzrJrhDrSa0JPKKaDV+pH1nlhd3KcmM4o5WIpDiG4fCAuZ2zhyEMeUraPErlkLR1BuNNC0LLm8f5tbXzJNxPdmjkGqCdNuVfGj0W/082dl+WUL4+K/iY8W5CqCq0CV6v5D0PjQ0N5mYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ACdaGopONiBvmA8JYS9jezNfrXgF5XQcoM8cnnkrY=;
 b=WB1cvaKOgi+O9VRBeYsBQNXeG5v1xLhxKTClBvZbskVMovOk7M1UJupn6Ct/xt9Gi6+tEYqko9brOJgJasBxM6NwHI0OI2jWHAbKgrpaKNu/JVUjqhBM9s/ddXUwArsOwXGhP/NEOGPghnb7eanSkjCjROU2+apmDJpHDQKd8z4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 08:26:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 08:26:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] thermal: imx_thermal: Use __maybe_unused instead of
 CONFIG_PM_SLEEP
Thread-Topic: [PATCH V2] thermal: imx_thermal: Use __maybe_unused instead of
 CONFIG_PM_SLEEP
Thread-Index: AQHV8GgP/M8Ol/PK50WikUZ0uCvNYqg08kkAgAAFMJA=
Date:   Mon, 2 Mar 2020 08:26:14 +0000
Message-ID: <DB3PR0402MB3916DC28A21BE0B9B8BFFC25F5E70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1583135410-7496-1-git-send-email-Anson.Huang@nxp.com>
 <20200302080700.ubnboqklhbva7bas@pengutronix.de>
In-Reply-To: <20200302080700.ubnboqklhbva7bas@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c595519-b6f0-4511-c5ab-08d7be835f2e
x-ms-traffictypediagnostic: DB3PR0402MB3786:|DB3PR0402MB3786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB378604E6D3D981CE6F836E37F5E70@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(7416002)(71200400001)(4326008)(5660300002)(86362001)(76116006)(66946007)(66476007)(66556008)(64756008)(478600001)(8676002)(316002)(66446008)(81156014)(81166006)(54906003)(6916009)(55016002)(9686003)(2906002)(8936002)(6506007)(26005)(52536014)(4744005)(186003)(33656002)(44832011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oTmnKuzFuwxyLBVDL6G3ejZz0WGu7nTc80oVRdJnoMIBAAM+yEWKm9nvml1mYA4O1C2CeLbXjhMxgjNgXl9kCev6bAkgkC6iPf+y9oi9vRZ8RgoarjauzfPK3RRYDS4npTF5vwN+j1QUZlrVVt554IFayGYU6RCC989fIDtbmnopTzCzOuYX1Ucw2sE9RL6avpr7gOsn9U24rE7zS4/AtKhhU0HFaVr41gyKWYJgAZSv9pfpdiKmSZ1veR9ZqEV6J+b5jQAi1u6sEK7olnNiHR0D99ukk8WFGaIMGsY3USTmwtlabzak5+GxCFR3LJ6T7vLKQlrA4RE2TdJ2p3uedj+7sc6KJfnmALyO+Ei/jtNc4PNQDeThOlCp4meBvYfdq4XnewIg1Q+pugKsWoMLyUfVpdUWqrMgFD0QOg56EOBKhWBzgB5jqWkROTOjdGVS
x-ms-exchange-antispam-messagedata: zM95ygmJhx3kQZNrdWtQkTsNyNcYVafYIvb80zP01qvp+dC1CfwnjDkckfxQxgfePqeitpuniOWO+BTbuOZF4iE8mY/T75voQJaXlAs/UQ2e1bDblILfTpH9U+IjfhwBux6YuBxz8EHL1lDY3cLcKA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c595519-b6f0-4511-c5ab-08d7be835f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 08:26:14.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeaFaIicIQnmJgt7/Th0Rkp7akHLhV+2bWzMJbCfGAxsb9O630qtHy9zJikihbMPeda7iqBlgg7i93IP9XJgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFV3ZQ0KDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gdGhlcm1hbDogaW14X3RoZXJt
YWw6IFVzZSBfX21heWJlX3VudXNlZCBpbnN0ZWFkDQo+IG9mIENPTkZJR19QTV9TTEVFUA0KPiAN
Cj4gT24gTW9uLCBNYXIgMDIsIDIwMjAgYXQgMDM6NTA6MTBQTSArMDgwMCwgQW5zb24gSHVhbmcg
d3JvdGU6DQo+ID4gVXNlIF9fbWF5YmVfdW51c2VkIGZvciBwb3dlciBtYW5hZ2VtZW50IHJlbGF0
ZWQgZnVuY3Rpb25zIGluc3RlYWQgb2YNCj4gPiAjaWYgQ09ORklHX1BNX1NMRUVQIHRvIHNpbXBs
aWZ5IHRoZSBjb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IA0KPiBJTUhPIHRyYW5zbGF0aW5nIG15ICJv
dGhlcndpc2UgbG9va3MgZmluZSIgaW4gYSAiUmV2aWV3ZWQtYnkiIGlzIGEgYml0IGJvbGQuDQo+
IFBsZWFzZSBkb24ndCBhc3N1bWUgdGhpcy4NCg0KT0ssIHdpbGwga2VlcCBpdCBpbiBtaW5kIG5l
eHQgdGltZSwgdGhhbmtzLg0KDQpBbnNvbg0K
