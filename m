Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171227EB0FC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Nov 2023 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjKNNhD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Nov 2023 08:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjKNNhC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2023 08:37:02 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468ED46;
        Tue, 14 Nov 2023 05:36:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnk6Cn9YFxaNYujxJj2PHLGr+lcdhJlmx0VpbwukMitFt6JHiXF9439dntzUTqjUDSlKSpr/KcMpxzC6sAWgydX8DY+a6bVsKRgu9LA7VrEnJDs7RTajxmx4eTfUBc2vRoDdk0/G4jcM/I1t/8sWzAw3abhA73LPOJaoTmQDCoxCzehYjHMVpYd9hVqC3sfLKivkE5rCXMhA7qlAWpUjprp55kTgFw02hXvWK0/3L1OhNPrAlRMDWwtdbiQQSgyYWGkM6fMoGrI2NARpffhCycPs3/ak2mOt4H/wOsm8F98Ea6KhVULKq8O6n5lKkvBBzm8GcO5Gjf1shPe/M1lKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5jz9NVnS4+UlHgrWQ/Qd2Q3aHLQq82HHmMgZYSHU9s=;
 b=QYPKC/bxAtQ7Hw/pRK7ouTBfq+ry7BSVsu89UHoUTjRctk+9nvGynKfKrRkqrKRlSid314FtieOdeayfi8m6WLJ8CrvdCoLH6QSCQYdD+LygQl17+xqa3X1475lA7G5PKY45PKkUweApjomCGtV5vHipx31PtzY4VDMVBkL1+u2RRRMrrFskZ6R0iCp8uq5Nwq10R5Fltuha1+QUS6GzNFRGVfQTsVv4Svv/JRi05Qnu58OETjC5cS7d+YOZAgECQ6whpaqjW6XU9L4VETcHiux1JhY6OUsEMHAaVAdAx583Z8PEBKrNmySQorVY4wRfeYUeq56F1DvSiTdxM8Fw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5jz9NVnS4+UlHgrWQ/Qd2Q3aHLQq82HHmMgZYSHU9s=;
 b=iOnUoQn1RqwHPgWjBHUv1lo5eg9GgyZgTD5zo2FkIJ0cxiNiv+ZKwe5GhO2jKqXPXNU2VJflmWxZMpNqEpR/JWvXg1hQ4NVO67+Xv+iZPs4AScmNXdslpeJBTxcaC1z/GHQa0ZQOOkwYA171/Eb4DMoEZGqndKxTz/Qdf5+Yk7s=
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com (2603:1096:101:56::11)
 by TY0PR02MB6832.apcprd02.prod.outlook.com (2603:1096:405:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 13:36:50 +0000
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133]) by SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133%4]) with mapi id 15.20.6977.028; Tue, 14 Nov 2023
 13:36:49 +0000
From:   =?utf-8?B?6buE5YaN5ry+KEpveXlvdW5nIEh1YW5nKQ==?= 
        <huangzaiyang@oppo.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        huangzaiyang <joyyoung.wang@gmail.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIFBlcmZvcm1hbmNlOiBkZXZmcmVxOiBhdm9pZCBk?=
 =?utf-8?Q?evfreq_delay_work_re-init_before?=
Thread-Topic: [PATCH] Performance: devfreq: avoid devfreq delay work re-init
 before
Thread-Index: AQHaE7ktw9S+4MHEbkGRU6+y80L/AbB5wDqAgAAUYIA=
Date:   Tue, 14 Nov 2023 13:36:49 +0000
Message-ID: <SEYPR02MB5653E9452D4BC57B10384D54A3B2A@SEYPR02MB5653.apcprd02.prod.outlook.com>
References: <20231110093457.458-1-huangzaiyang@oppo.com>
 <fe8f6f37-2534-6481-cc34-e561b3b7a510@quicinc.com>
In-Reply-To: <fe8f6f37-2534-6481-cc34-e561b3b7a510@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR02MB5653:EE_|TY0PR02MB6832:EE_
x-ms-office365-filtering-correlation-id: 75710f3d-b221-4ba4-fbf5-08dbe516c106
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjzf5kXpg6ePjUGFEl7JI/S0VQQzR2bti/LjRCZiLVavH72mtqxn8pxpc2vVLf2PYPAnCIH57aA5rMjM/uy/MhVRbaR/KpyBWDYGBSDVJlEnOi4EHYQw3SQ+biYcUQIvXWH8nUePvasPwI6mjudSCxKpB1XWsUGGpgxyZHLaCV0KsfJ2NFMY8lL3g+p4SUl50AMQvF+sOchIA8Ul1OYQVYsAUI7V23RYwDJoaGS30wnK5Bz26LcFqxXU8UQiNgzzDVpHuMqT2hUf+c5BX42uCuq+PveFcMBvdj/61FvEUieXvq4jp4FCu3mbGp4x3oWmbwHdksGfxlKeRwfTUSPPXgu7T7QUdyZEwmfPQJ1LFHQFysczLrQDO5lbJa/wQCnsvTAlJgMsU2faQRnGSjtlWoh9T65usCWnnf/80ukZueWh2Mz+PCl0BhTgIBnCQTh3DfqTEY95pY63h+JIKtgLVncyXYcPYawiKETel1GP0RQRzP7pzis0idyb9HyBan2GNMngBXJdV5bhHIFfFS6ggXgVh0uh2yY2Fv9rUFFuuxXmH5bslay4V0Z5DaIlPMcPxo2XkgppZ894uU3ktflY4/DTdBAzTSyoSqdR37PdZAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB5653.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38070700009)(122000001)(76116006)(110136005)(224303003)(26005)(53546011)(7696005)(6506007)(478600001)(71200400001)(83380400001)(66946007)(966005)(9686003)(567974003)(86362001)(55016003)(5660300002)(52536014)(33656002)(41300700001)(2906002)(30864003)(38100700002)(85182001)(316002)(54906003)(66556008)(66476007)(8936002)(64756008)(66446008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVdmSUZQZEFmQVN6TENVSGdYKzVPeW1MK2h4T0h4YXhXa210dHRFZ3JwNHNk?=
 =?utf-8?B?ZlNwQVRTOCsxa0tQSUYrL2NZNmowd2FCRXIrTmVVa0Nnc1ZCM2VOOTc2NUYr?=
 =?utf-8?B?UFZLSFEvL1MrMWltQ3QxWTFMR3gxeG9TQkIzSjJDOTVmYm45dXFQZHFkVlh4?=
 =?utf-8?B?dS9XYlQ1SGJkNUhWUmFwWVRFY3pNSzhhbjdHenlnWG8rRllJYUVDSXViVWFQ?=
 =?utf-8?B?L0VjOXJCNkJYYWtWeVQ1M2VYRjk1RVpvS25oVFhZdENEL0JOMVVab1FDZjNj?=
 =?utf-8?B?SnJFcUxDVUxWcjMyRU56MDlQS04wSUZDLzF0R0pHZFkwdG85UXdJSFpIRi81?=
 =?utf-8?B?cnJraGVldVhjMFNjQ0tta3AxNUFMQzJCUUdvcmRIdFV2QmlYVDJjZFlWaHJ5?=
 =?utf-8?B?bVYxWFBIbExJaFM5ZlovLzVZRmJOTWkyQjFaSmovRndydzA0K1ExT25JSk5Q?=
 =?utf-8?B?aWpldW9XNFB2b3gwYTd1cytnbnN5WnBtWDI3YkdzNVBYckxXUTVzYklLbnps?=
 =?utf-8?B?UDBEZ01yS09ucG5vVjVDK1NjN1VUNDYrQ3VWSW1ZRkVjWGJuODJsVEwwUTVV?=
 =?utf-8?B?NzB6YnBMM2RXdTFuOTJnUWtOam5tbWU0bGJQa0xvdUsxRHZJbW4zWFgyazUy?=
 =?utf-8?B?QXdMN2dDN1MwYmxaRXN6QnVWR3AzaTZQd0RBMkpqMG1ucDF5RkVaTitBNlg1?=
 =?utf-8?B?L2lkMmVaSUVMb3dQemdQWTJ1WExMbjczMUtTWmVmcjA2ZkxOd1cxNHoyMVFG?=
 =?utf-8?B?ZjZZazI2SE1Ca0V6RjhLVmJVYzhwVE5WRHdXNlNETCs0eHBQeUlFT1BWK3J1?=
 =?utf-8?B?YnM3QWp1TVN3bjFJUmYwKzFGaGRFdUNaL2ZheXZLaFRTRzUxTnFpM0R2UzRh?=
 =?utf-8?B?MXY1UjR5dzBlK0IyQk1pTHFaWEsvc1ErMUIyUExJVUoxRHg1a0FjdytyN1BH?=
 =?utf-8?B?Lys1d2d1eFRiUFZwQjEzT0pXcmRoaGszR0FNYTlSVW45bkxJT1RlUkpCblFx?=
 =?utf-8?B?bWl6YmtTMURCNDZ1Q09EakVMdzRuWlNFc0gzUk9YNTFUZzVDajNKK2N1ZnUw?=
 =?utf-8?B?TnpiUlpZOHB6ZzR5UW5sMmtGQTJpaWdvc2xMWFQybGNJWlpzQ2VsZnpZdFd1?=
 =?utf-8?B?WW5EMmExNUcxN1JvdHZCckxxdHp3QXBQczhldmRoNFdGczZ0aDhTTGxHbXhs?=
 =?utf-8?B?dWxCWW02dm1yVlBvTVBReTdYRHlKZFFsbUJ2L3dXZFlxUjhuaXFQTExhakto?=
 =?utf-8?B?T3JRRG9iblRha1FMV1Zud1dPb3N6Z1l0OG9jUlFpTllFS0hxWkIwUTQxbWt1?=
 =?utf-8?B?b0dFSW9neWtwNzIxck1JeTMrL3lQZ2s3SnJYTUJRTUhQSWtSbXdQOWgxM2RP?=
 =?utf-8?B?QjA0UEVleVNzbGhCRFZGaFBhM0FpekJ3dTMvT3NJb3lkWXVwR2hCMTRVdzU2?=
 =?utf-8?B?QlFJMm1aOFNGZ2ZXNlhpMnBSTFcrZWVuOGFxUmcyVWxzNlhLWnBIUU16NlFr?=
 =?utf-8?B?Y1dsMUNUKzhVaHZzNlltaTdhWklFdWQ0RnUySDJOdG9FYzhLZ3lITmJvNVRM?=
 =?utf-8?B?ZzhNVDgzVXZyeXRSaUhVQzhUVUlqbnRCUlhiUXd0OFlMZVpZUDVaZHJxdzRP?=
 =?utf-8?B?SHcvLzZjQis5aHZZelNndW1SZU5xUWtyU09nVzRKZUI5S3duWm1EZHJtM2tR?=
 =?utf-8?B?Z3dVU1kya0k5U0lrUE8wWkhoUlEvbWZNWVBxYlVWM3FQbkR6d0gwNnpQSk9T?=
 =?utf-8?B?dndhTlUzWHZRTUVodVZaWllJMDJaa0NwMmVaU0Z1N1hTdmRTRHpNdzhJS0tq?=
 =?utf-8?B?MHlZcmVhbU02TXBKelR1cys0Mlcvd3liQ1BiaEI0YjJ0VkZzV1crbWcxTTEw?=
 =?utf-8?B?alpyV2xKZ3pkN3dsOWVqeitzWkI1TXdEclNZQitySzFSdGExV0tUenpzbklv?=
 =?utf-8?B?dGdiLzZ6dmg5V2o4MWNKVTNielNXMU1tY1B4eDhPckUzTTExSXFtTmI4UVIz?=
 =?utf-8?B?UWloUW5CcldNd01SUWM3OVRLTzVFdEdibGNwcTM1V0ViNS85WHRMQWN4NmJo?=
 =?utf-8?B?eTRSK2JHT1NiaW9Fc05USDJoQnlCL2FsVmhqZmYrMSs1VS9PSWU4VHlCWkZB?=
 =?utf-8?Q?rmujnjzia2o+1ojPD9IHSKDp3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5653.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75710f3d-b221-4ba4-fbf5-08dbe516c106
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 13:36:49.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCrPKwtiBeYgt16RKCxu2X56F9tzRqs8veSreMd1R62OS6vjkgYMO4yCsc91PuoUDLQT3s/3BBkV9TzR4baD6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiAxMS8xMC8yMDIzIDM6MDQgUE0sIGh1YW5nemFpeWFuZyB3cm90ZToNCj4gRnJvbTogaHVh
bmd6YWl5YW5nIDxqb3l5b3VuZy53YW5nQGdtYWlsLmNvbT4NCj4gDQo+IFRoZXJlIGlzIGEgdGlt
ZXJfbGlzdCByYWNlIGNvbmRpdGlvbiB3aGVuIGV4ZWN1dGluZyB0aGUgZm9sbG93aW5nIHRlc3Qg
c2hlbGwgc2NyaXB0Og0KPiAnJycNCj4gd2hpbGUgdHJ1ZQ0KPiBkbw0KPiAgICAgICAgICBlY2hv
ICJzaW1wbGVfb25kZW1hbmQiID4gL3N5cy9jbGFzcy9kZXZmcmVxLzFkODQwMDAudWZzaGMvZ292
ZXJub3INCj4gICAgICAgICAgZWNobyAicGVyZm9ybWFuY2UiID4gDQo+IC9zeXMvY2xhc3MvZGV2
ZnJlcS8xZDg0MDAwLnVmc2hjL2dvdmVybm9yDQo+IGRvbmUNCj4gJycnDQo+IA0KPiBbMTM1MTEu
MjE0MzY2XVsgICAgQzNdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0
IHZpcnR1YWwgYWRkcmVzcyBkZWFkMDAwMDAwMDAwMTJhDQo+IFsxMzUxMS4yMTQzOTNdWyAgICBD
M10gTWVtIGFib3J0IGluZm86DQo+IFsxMzUxMS4yMTQzOThdWyAgICBDM10gICBFU1IgPSAweDk2
MDAwMDQ0DQo+IFsxMzUxMS4yMTQ0MDRdWyAgICBDM10gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJl
bnQgRUwpLCBJTCA9IDMyIGJpdHMNCj4gWzEzNTExLjIxNDQwOV1bICAgIEMzXSAgIFNFVCA9IDAs
IEZuViA9IDANCj4gWzEzNTExLjIxNDQxNF1bICAgIEMzXSAgIEVBID0gMCwgUzFQVFcgPSAwDQo+
IFsxMzUxMS4yMTQ0MTddWyAgICBDM10gRGF0YSBhYm9ydCBpbmZvOg0KPiBbMTM1MTEuMjE0NDIy
XVsgICAgQzNdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDA0NA0KPiBbMTM1MTEuMjE0NDI3XVsg
ICAgQzNdICAgQ00gPSAwLCBXblIgPSAxDQo+IFsxMzUxMS4yMTQ0MzJdWyAgICBDM10gW2RlYWQw
MDAwMDAwMDAxMmFdIGFkZHJlc3MgYmV0d2VlbiB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzcyByYW5n
ZXMNCj4gWzEzNTExLjIxNDQzOV1bICAgIEMzXSBJbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAw
NDQgWyMxXSBQUkVFTVBUIFNNUA0KPiBbMTM1MTEuMjE1NDQ5XVsgICAgQzNdIENQVTogMyBQSUQ6
IDAgQ29tbTogc3dhcHBlci8zIFRhaW50ZWQ6IEcgUyAgICAgIFcgIE8gICAgICA1LjEwLjE2OC1h
bmRyb2lkMTItOS1vLWc2M2NjMjk3YTdiMzQgIzENCj4gWzEzNTExLjIxNTQ1NF1bICAgIEMzXSBI
YXJkd2FyZSBuYW1lOiBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gQ2FwZSBNVFAsIFdoaXRl
c3dhbiAoRFQpDQo+IFsxMzUxMS4yMTU0NjBdWyAgICBDM10gcHN0YXRlOiA4MjQwMDA4NSAoTnpj
diBkYUlmICtQQU4gLVVBTyArVENPIEJUWVBFPS0tKQ0KPiBbMTM1MTEuMjE1NDcyXVsgICAgQzNd
IHBjIDogZXhwaXJlX3RpbWVycysweDljLzB4NDI4DQo+IFsxMzUxMS4yMTU0NzhdWyAgICBDM10g
bHIgOiBfX3J1bl90aW1lcnMrMHgxZjAvMHgzMjgNCj4gWzEzNTExLjIxNTQ4M11bICAgIEMzXSBz
cCA6IGZmZmZmZmMwMDgwMWJkZDANCj4gWzEzNTExLjIxNTQ4N11bICAgIEMzXSB4Mjk6IGZmZmZm
ZmMwMDgwMWJkZjAgeDI4OiBmZmZmZmZkYjg3YjMxNjk4DQo+IFsxMzUxMS4yMTU0OTNdWyAgICBD
M10geDI3OiBmZmZmZmZkYjg3OTk5ZTU4IHgyNjogZmZmZmZmZGI4Nzk2NjAwOA0KPiBbMTM1MTEu
MjE1NDk5XVsgICAgQzNdIHgyNTogMDAwMDAwMDAwMDAwMDAwMSB4MjQ6IGZmZmZmZjgwMDE3MzRh
MDANCj4gWzEzNTExLjIxNTUwNl1bICAgIEMzXSB4MjM6IDAwMDAwMDAwMDAwMDAwZTAgeDIyOiBk
ZWFkMDAwMDAwMDAwMTIyDQo+IFsxMzUxMS4yMTU1MTJdWyAgICBDM10geDIxOiAwMDAwMDAwMTAw
MzI2NThlIHgyMDogZmZmZmZmODlmN2E5YWU4MA0KPiBbMTM1MTEuMjE1NTE4XVsgICAgQzNdIHgx
OTogZmZmZmZmYzAwODAxYmU1MCB4MTg6IGZmZmZmZmMwMDgwMWQwMzgNCj4gWzEzNTExLjIxNTUy
NV1bICAgIEMzXSB4MTc6IDAwMDAwMDAwMDAwMDAyNDAgeDE2OiAwMDAwMDAwMDAwMDAwMjAxDQo+
IFsxMzUxMS4yMTU1MzJdWyAgICBDM10geDE1OiBmZmZmZmZmZmZmZmZmZmZmIHgxNDogZmZmZmZm
ODlmN2E5YWVmOA0KPiBbMTM1MTEuMjE1NTM4XVsgICAgQzNdIHgxMzogMDAwMDAwMDAwMDAwMDI0
MCB4MTI6IGZmZmZmZjg5ZjdhOWFlYTgNCj4gWzEzNTExLjIxNTU0NF1bICAgIEMzXSB4MTE6IDAw
MDAwMDAwMDAwMDAwMjEgeDEwOiAwMDAwMDAwMTQwMzI2NThlDQo+IFsxMzUxMS4yMTU1NTBdWyAg
ICBDM10geDkgOiBmZmZmZmZjMDA4MDFiZTUwIHg4IDogZGVhZDAwMDAwMDAwMDEyMg0KPiBbMTM1
MTEuMjE1NTU2XVsgICAgQzNdIHg3IDogZmZmZjcxNjQ2YzY4NzM1ZSB4NiA6IGZmZmZmZjg5Zjdh
YWFlNTgNCj4gWzEzNTExLjIxNTU2M11bICAgIEMzXSB4NSA6IDAwMDAwMDAwMDAwMDAwMDAgeDQg
OiAwMDAwMDAwMDAwMDAwMTAxDQo+IFsxMzUxMS4yMTU1NjldWyAgICBDM10geDMgOiBmZmZmZmY4
OWY3YTlhZWYwIHgyIDogZmZmZmZmODlmN2E5YWVmMA0KPiBbMTM1MTEuMjE1NTc1XVsgICAgQzNd
IHgxIDogZmZmZmZmYzAwODAxYmU1MCB4MCA6IGZmZmZmZjgwNDU4MDQ0MjgNCj4gWzEzNTExLjIx
NTU4MV1bICAgIEMzXSBDYWxsIHRyYWNlOg0KPiBbMTM1MTEuMjE1NTg2XVsgICAgQzNdICBleHBp
cmVfdGltZXJzKzB4OWMvMHg0MjgNCj4gWzEzNTExLjIxNTU5MV1bICAgIEMzXSAgX19ydW5fdGlt
ZXJzKzB4MWYwLzB4MzI4DQo+IFsxMzUxMS4yMTU1OTZdWyAgICBDM10gIHJ1bl90aW1lcl9zb2Z0
aXJxKzB4MjgvMHg1OA0KPiBbMTM1MTEuMjE1NjAyXVsgICAgQzNdICBlZmlfaGVhZGVyX2VuZCsw
eDE2OC8weDVlYw0KPiBbMTM1MTEuMjE1NjEwXVsgICAgQzNdICBfX2lycV9leGl0X3JjdSsweDEw
OC8weDEyNA0KPiBbMTM1MTEuMjE1NjE3XVsgICAgQzNdICBfX2hhbmRsZV9kb21haW5faXJxKzB4
MTE4LzB4MWU0DQo+IFsxMzUxMS4yMTU2MjVdWyAgICBDM10gIGdpY19oYW5kbGVfaXJxLjMxMjMw
KzB4NmMvMHgyNTANCj4gWzEzNTExLjIxNTYzMF1bICAgIEMzXSAgZWwxX2lycSsweGU0LzB4MWMw
DQo+IFsxMzUxMS4yMTU2MzhdWyAgICBDM10gIGNwdWlkbGVfZW50ZXJfc3RhdGUrMHgzYTQvMHhh
MDQNCj4gWzEzNTExLjIxNTY0NF1bICAgIEMzXSAgZG9faWRsZSsweDMwOC8weDU3NA0KPiBbMTM1
MTEuMjE1NjQ5XVsgICAgQzNdICBjcHVfc3RhcnR1cF9lbnRyeSsweDg0LzB4OTANCj4gWzEzNTEx
LjIxNTY1Nl1bICAgIEMzXSAgc2Vjb25kYXJ5X3N0YXJ0X2tlcm5lbCsweDIwNC8weDI3NA0KPiBb
MTM1MTEuMjE1NjY0XVsgICAgQzNdIENvZGU6IGQ1MDMyMDFmIGE5NDAyNDA4IGY5MDAwMTI4IGI0
MDAwMDQ4IChmOTAwMDUwOSkNCj4gWzEzNTExLjIxNTY3MF1bICAgIEMzXSAtLS1bIGVuZCB0cmFj
ZSA1MTAwYmFkNzJhMzVkNTY2IF0tLS0NCj4gWzEzNTExLjIxNTY3Nl1bICAgIEMzXSBLZXJuZWwg
cGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgZXhjZXB0aW9uIGluIGludGVycnVwdA0K
PiANCj4gVGhpcyBpcyBiZWNhdXNlIHdoZW4gc3dpdGNoaW5nIHRoZSBnb3Zlcm5vciB0aHJvdWdo
IHRoZSBzeXMgbm9kZSwgdGhlIA0KPiBkZXZmcmVxX21vbml0b3Jfc3RhcnQgZnVuY3Rpb24gd2ls
bCByZS1pbml0aWFsaXplIHRoZSBkZWxheWVkIHdvcmsgDQo+IHRhc2ssIHdoaWNoIHdpbGwgY2F1
c2UgdGhlIGRlbGF5IHdvcmsgcGVuZGluZyBmbGFnIHRvIGJlY29tZSBpbnZhbGlkLCANCj4gYW5k
IHRoZSB0aW1lciBwZW5kaW5nIGp1ZGdtZW50IGNvbnRhaW5lZCBpbiB0aGUgZGVsYXllZCB3b3Jr
IHdpbGwgYWxzbyBiZWNvbWUgaW52YWxpZCwgYW5kIHRoZW4gdGhlIHBlbmRpbmcgaW50ZXJjZXB0
aW9uIHdpbGwgYmUgZXhlY3V0ZWQgd2hlbiB0aGUgcXVldWUgaXMgZXhlY3V0ZWQuDQo+IA0KPiBT
byB3ZSByZW1vdmUgdGhlIGRlbGF5IHdvcmsnaW5pdGlhbGl6YXRpb24gd29yayB0byB0aGUgDQo+
IGRldmZyZXFfYWRkX2RldmljZSBhbmQgdGltZXJfc3RvcmUgZnVuY3Rpb25zLCBhbmQgdGhlIGRl
bGF5IHdvcmsgcGVuZGluZyBqdWRnbWVudCBpcyBwZXJmb3JtZWQgYmVmb3JlIHRoZSBkZXZmcmVx
X21vbml0b3Jfc3RhcnQgZnVuY3Rpb24gcGVyZm9ybXMgdGhlIHF1ZXVlIG9wZXJhdGlvbi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFphaVlhbmcgSHVhbmcgPGh1YW5nemFpeWFuZ0BvcHBvLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDM2ICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEv
ZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyANCj4gaW5kZXggYjNhNjhkNTgz
M2JkLi44YWU2Zjg1M2EyMWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVx
LmMNCj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPiBAQCAtNDgzLDE4ICs0ODMs
NyBAQCB2b2lkIGRldmZyZXFfbW9uaXRvcl9zdGFydChzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkN
Cj4gICAgICAgICAgaWYgKElTX1NVUFBPUlRFRF9GTEFHKGRldmZyZXEtPmdvdmVybm9yLT5mbGFn
cywgSVJRX0RSSVZFTikpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiANCj4gLSAgICAg
ICBzd2l0Y2ggKGRldmZyZXEtPnByb2ZpbGUtPnRpbWVyKSB7DQo+IC0gICAgICAgY2FzZSBERVZG
UkVRX1RJTUVSX0RFRkVSUkFCTEU6DQo+IC0gICAgICAgICAgICAgICBJTklUX0RFRkVSUkFCTEVf
V09SSygmZGV2ZnJlcS0+d29yaywgZGV2ZnJlcV9tb25pdG9yKTsNCj4gLSAgICAgICAgICAgICAg
IGJyZWFrOw0KPiAtICAgICAgIGNhc2UgREVWRlJFUV9USU1FUl9ERUxBWUVEOg0KPiAtICAgICAg
ICAgICAgICAgSU5JVF9ERUxBWUVEX1dPUksoJmRldmZyZXEtPndvcmssIGRldmZyZXFfbW9uaXRv
cik7DQo+IC0gICAgICAgICAgICAgICBicmVhazsNCj4gLSAgICAgICBkZWZhdWx0Og0KPiAtICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiAtICAgICAgIH0NCj4gLQ0KPiAtICAgICAgIGlmIChkZXZm
cmVxLT5wcm9maWxlLT5wb2xsaW5nX21zKQ0KPiArICAgICAgIGlmIChkZXZmcmVxLT5wcm9maWxl
LT5wb2xsaW5nX21zICYmIA0KPiArICFkZWxheWVkX3dvcmtfcGVuZGluZygmZGV2ZnJlcS0+d29y
aykpDQo+ICAgICAgICAgICAgICAgICAgcXVldWVfZGVsYXllZF93b3JrKGRldmZyZXFfd3EsICZk
ZXZmcmVxLT53b3JrLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmll
cyhkZXZmcmVxLT5wcm9maWxlLT5wb2xsaW5nX21zKSk7DQo+ICAgfQ0KPiBAQCAtODMwLDYgKzgx
OSwxNyBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2aWNlKHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gICAgICAgICAgICAgICAgICBnb3RvIGVycl9kZXY7DQo+ICAgICAgICAgIH0NCj4g
DQo+ICsgICAgICAgc3dpdGNoIChkZXZmcmVxLT5wcm9maWxlLT50aW1lcikgew0KPiArICAgICAg
IGNhc2UgREVWRlJFUV9USU1FUl9ERUZFUlJBQkxFOg0KPiArICAgICAgICAgICAgICAgSU5JVF9E
RUZFUlJBQkxFX1dPUksoJmRldmZyZXEtPndvcmssIGRldmZyZXFfbW9uaXRvcik7DQo+ICsgICAg
ICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBjYXNlIERFVkZSRVFfVElNRVJfREVMQVlFRDoN
Cj4gKyAgICAgICAgICAgICAgIElOSVRfREVMQVlFRF9XT1JLKCZkZXZmcmVxLT53b3JrLCBkZXZm
cmVxX21vbml0b3IpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgZGVmYXVs
dDoNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiJXM6IFRhcmdldCBkZXZmcmVxKCVz
KSdzIHByb2ZpbGUgdGltZXIgaGFzIG5vIHNldHRpbmdzIFxuIiwgZGV2ZnJlcS0+Z292ZXJub3Jf
bmFtZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPiArICAgICAgIH0N
Cg0KWy4uXQ0KDQo+ICAgICAgICAgIGlmICghZGV2ZnJlcS0+cHJvZmlsZS0+bWF4X3N0YXRlIHx8
ICFkZXZmcmVxLT5wcm9maWxlLT5mcmVxX3RhYmxlKSB7DQo+ICAgICAgICAgICAgICAgICAgbXV0
ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsNCj4gICAgICAgICAgICAgICAgICBlcnIgPSBzZXRf
ZnJlcV90YWJsZShkZXZmcmVxKTsgQEAgLTE4NjAsNiArMTg2MCwxOCBAQCANCj4gc3RhdGljIHNz
aXplX3QgdGltZXJfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwNCj4gICAgICAgICAgZGYtPnByb2ZpbGUtPnRpbWVyID0gdGltZXI7DQo+ICAg
ICAgICAgIG11dGV4X3VubG9jaygmZGYtPmxvY2spOw0KPiANCj4gKyAgICAgICBzd2l0Y2ggKGRm
LT5wcm9maWxlLT50aW1lcikgew0KPiArICAgICAgIGNhc2UgREVWRlJFUV9USU1FUl9ERUZFUlJB
QkxFOg0KPiArICAgICAgICAgICAgICAgSU5JVF9ERUZFUlJBQkxFX1dPUksoJmRmLT53b3JrLCBk
ZXZmcmVxX21vbml0b3IpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgY2Fz
ZSBERVZGUkVRX1RJTUVSX0RFTEFZRUQ6DQo+ICsgICAgICAgICAgICAgICBJTklUX0RFTEFZRURf
V09SSygmZGYtPndvcmssIGRldmZyZXFfbW9uaXRvcik7DQo+ICsgICAgICAgICAgICAgICBicmVh
azsNCj4gKyAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICIl
czogVGFyZ2V0IGRldmZyZXEoJXMpJ3MgcHJvZmlsZSB0aW1lciBoYXMgbm8gc2V0dGluZ3MgXG4i
LCBkZi0+Z292ZXJub3JfbmFtZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18p
Ow0KPiArICAgICAgIH0NCj4gKw0KSGVyZSwgdGhpcyBjYW4gY2F1c2UgaXNzdWUgcmlnaHQsIGFz
IGl0IGlzIG1vZGlmeWluZyB0aGUgZGVsYXllZCB3b3JrIGRhdGEgZXZlbiBiZWZvcmUgc3RvcHBp
bmcgdGhlIGN1cnJlbnQgcnVubmluZyBpbnN0YW5jZXMuLg0KDQpTaG91bGQgdGhlIGFib3ZlIHRo
aW5nIGJlIGRvbmUgYWZ0ZXIgREVWRlJFUV9HT1ZfU1RPUCA/DQpCdXQgYWdhaW4gaXQgd2lsbCBi
b2lsIGRvd24gdG8gdGhlIHNhbWUgdGhpbmcgYXMgaXQgaXMgY3VycmVudGx5IG5vdyAuDQo+ICAg
ICAgICAgIHJldCA9IGRmLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZiwgREVWRlJFUV9HT1Zf
U1RPUCwgTlVMTCk7DQo+ICAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgICBk
ZXZfd2FybihkZXYsICIlczogR292ZXJub3IgJXMgbm90IHN0b3BwZWQoJWQpXG4iLA0KLS0+YWdy
ZWUsIHNlZW1zIGJldHRlciB0byBwdXQgdGhlc2UgY29kZXMgYWZ0ZXIgYWZ0ZXIgREVWRlJFUV9H
T1ZfU1RPUCwgYXMgZm9sbG93PyANCkBAIC0xODU2LDEwICsxODU2LDYgQEAgc3RhdGljIHNzaXpl
X3QgdGltZXJfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqYXR0ciwNCiAJCWdvdG8gb3V0Ow0KIAl9DQogDQotCW11dGV4X2xvY2soJmRmLT5sb2NrKTsN
Ci0JZGYtPnByb2ZpbGUtPnRpbWVyID0gdGltZXI7DQotCW11dGV4X3VubG9jaygmZGYtPmxvY2sp
Ow0KLQ0KIAlyZXQgPSBkZi0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoZGYsIERFVkZSRVFfR09W
X1NUT1AsIE5VTEwpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfd2FybihkZXYsICIlczogR292ZXJu
b3IgJXMgbm90IHN0b3BwZWQoJWQpXG4iLA0KQEAgLTE4NjcsNiArMTg2MywyMSBAQCBzdGF0aWMg
c3NpemVfdCB0aW1lcl9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICphdHRyLA0KIAkJZ290byBvdXQ7DQogCX0NCiANCisJbXV0ZXhfbG9jaygmZGYtPmxv
Y2spOw0KKwlkZi0+cHJvZmlsZS0+dGltZXIgPSB0aW1lcjsNCisJc3dpdGNoIChkZi0+cHJvZmls
ZS0+dGltZXIpIHsNCisJY2FzZSBERVZGUkVRX1RJTUVSX0RFRkVSUkFCTEU6DQorCQlJTklUX0RF
RkVSUkFCTEVfV09SSygmZGYtPndvcmssIGRldmZyZXFfbW9uaXRvcik7DQorCQlicmVhazsNCisJ
Y2FzZSBERVZGUkVRX1RJTUVSX0RFTEFZRUQ6DQorCQlJTklUX0RFTEFZRURfV09SSygmZGYtPndv
cmssIGRldmZyZXFfbW9uaXRvcik7DQorCQlicmVhazsNCisJZGVmYXVsdDoNCisJCWRldl9lcnIo
ZGV2LCAiJXM6IFRhcmdldCBkZXZmcmVxKCVzKSdzIHByb2ZpbGUgdGltZXIgaGFzIG5vIHNldHRp
bmdzIFxuIiwgZGYtPmdvdmVybm9yX25hbWUsDQorCQkJX19mdW5jX18pOw0KKyAgICAgICBtdXRl
eF91bmxvY2soJmRmLT5sb2NrKTsNCisgICAgICAgZ290byBvdXQ7DQorCX0NCisJbXV0ZXhfdW5s
b2NrKCZkZi0+bG9jayk7DQorDQogCXJldCA9IGRmLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihk
ZiwgREVWRlJFUV9HT1ZfU1RBUlQsIE5VTEwpOw0KIAlpZiAocmV0KQ0KIAkJZGV2X3dhcm4oZGV2
LCAiJXM6IEdvdmVybm9yICVzIG5vdCBzdGFydGVkKCVkKVxuIiwNCi0tIA0KDQpJIHdhcyB0aGlu
a2luZyBpZiBpIHB1dCBtdXRleCBhcm91bmQgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgYXMg
d2VsbCBpbiBkZXZmcmVxX21vbml0b3Jfc3RvcCgpIG9uIHRvcCBvZiBiZWxvdyBwYXRjaCwgc2hv
dWxkIGNvdmVyIHRoZSBjb3JydXB0aW9uIG9mIHdvcmtkYXRhLg0KDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMTY5OTk1NzY0OC0zMTI5OS0xLWdpdC1zZW5kLWVtYWlsLXF1aWNfbW9qaGFA
cXVpY2luYy5jb20vDQoNCi1NdWtlc2gNCg0KPiAtLQ0KPiAyLjE3LjENCg0KUmVtb3ZlIHRoZSBl
bnRpcmUgYmVsb3cgdGhpbmcuLj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gT1BQTw0KPiANCj4gwrHCvsK1w6fDl8OTw5PDisK8w77CvMKww4bDpMK4wr3CvMO+wrrCrMOT
w5BPUFBPwrnCq8OLwr7CtcOEwrHCo8ODw5zDkMOFw4/CosKjwqzCvcO2w4/DnsOTw5rDk8OKwrzD
vsOWwrjDg8O3wrXDhMOKw5XCvMO+w4jDi8KjwqjCsMO8wrrCrA0KPiDCuMO2w4jDi8K8wrDDiMK6
w5fDqcKjwqnDisK5w5PDg8KhwqPCvcO7w5bCucOIw47CusOOw4jDi8OUw5rDjsK0wr7CrcOKw5rD
iMKowrXDhMOHw6nCv8O2w4/DgsOSw5TDiMOOwrrDjsOQw47DisK9w4rCucOTw4PCocKjw4jDp8K5
w7vDhMO6wrTDrQ0KPiDDisOVw4HDi8Kxwr7Dk8OKwrzDvsKjwqzDh8OQw47DsMK0wqvCssKlwqHC
osK3w5bCt8KiwqHCosK4wrTDlsOGwqHCosOTwqHDi8KiwrvDssOKwrnDk8ODwrHCvsOTw4rCvMO+
w5bCrsOIw47CusOOwrLCv8K3w5bCu8Oyw4bDpMOLw7nDlMOYw5bCrg0KPiDDiMOOwrrDjsOEw5rD
iMOdwqPCrMKywqLDh8Orw4HCosK8wrTDksOUwrXDp8OXw5PDk8OKwrzDvsONwqjDlsKqwrfCosK8
w77DiMOLwrLCosOJwr7Cs8O9wrHCvsOTw4rCvMO+wrzCsMOGw6TCuMK9wrzDvsKhwqMNCj4gw43D
uMOCw6fDjcKow5HCtsK5w4zDk8OQw4jCscOPw53Cv8OJw4TDnMK1wrzDlsOCw5PDisK8w77CscK7
wr3DmMOBw7TCocKiw5DDnsK4w4TCocKiwrbCqsOKwqfCocKiw4bDhsK7wrXCu8OywrDDvMK6wqzC
vMOGw4vDo8K7w7rCssKhwrbCvsK1w4gNCj4gwrLCu8KwwrLDiMKrw4fDqcK/w7bCo8KsT1BQT8K2
w5TCtMOLw4DDoMK0w63DjsOzwrvDssOSw4XDgsKpwrbDuMOSw73DlsOCw5bCrsOIw47CusOOw4vD
sMOKwqfCuMOFwrLCu8Kzw5DCtcKjw5TDsMOIw47CssKiwrHCo8OBw7TDk8OrwrHCvg0KPiDDk8OK
wrzDvsOPw6DCucOYw5bCrsOSwrvDh8OQw4jCqMOAw7vCocKjIA0KPiDCs8O9wrfDh8ODw7fDiMK3
w4vCtcODw7fCo8KswrHCvsOTw4rCvMO+wrzCsMOGw6TCuMK9wrzDvsOOw57DksOiw5fDt8OOwqrD
lMOaw4jDjsK6w47CucO6wrzDksK7w7LCtcOYw4fDuMOWwq7DksKqw5TCvMKhwqLDlcOQw4DCv8K7
w7LCs8OQw4XCtQ0KPiDCo8Ksw5LDoMOOw57DksOiw5fDt8OOwqrDiMOOwrrDjsK9wrvDksOXwrvD
ssK6w4/DjcKsw5bCrsOVw73DisK9w4jCt8OIw4/CocKjIA0KPiDCt8KiwrzDvsOIw4vCocKiw4bD
pMOLw7nDisO0wrvDusK5wrnCu8Oyw4vDucOKw7TCu8O6wrnCucOWwq7CucOYw4HCqsK7w7rCucK5
wrvDssOIw47CusOOw4nDj8OKw7bCu8O6wrnCucOWwq7CucOJwrbCq8KhwqLCtsKtw4rDgsKhwqLC
uMOfwrzCtg0KPiDCucOcw4DDrcOIw4vDlMKxwqHCosOUwrHCucKkwrvDssOGw6TDi8O7w4jDjsK6
w47DiMOLwqPCqMOSw5TDj8OCwrPDhsKhwrDCt8KiwrzDvsOIw4vCocKxwrvDssKhwrBPUFBPwqHC
scKjwqnCssK7w5LDssKxwr7Dk8OKwrzDvsOWwq7DjsOzDQo+IMOLw43CtsO4wrfDhcOGw7rDhsOk
w4vDucOPw63DlsKuw4jDjsK6w47DiMKow4DDu8KjwqzDksOgwrLCu8K2w5TDksOywrnDisOSw6LC
u8OywrnDvcOKwqfDisK5w5PDg8K4w4PCtcOIw5DDhcOPwqLCtsO4w5LDvcK3wqLCu8Oywr/DicOE
w5zDksO9DQo+IMK3wqLCtcOEw4vDsMOKwqfCs8OQwrXCo8OIw47CusOOw5TDsMOIw47CocKjIA0K
PiDDjsOEwrvCr8Kyw67DksOsw4XDu8OCwrbCo8K6w5LDssOIwqvDh8Oyw47DhMK7wq/CssOuw5LD
rMOTwrDDj8OswqPCrMK1wqXCtMK/w5LDlFlFU1xPS8K7w7LDhsOkw4vDu8K8w7LCtcKlwrTDisK7
w6PCtcOEwrvDmMK4wrTCssKiwrLCuw0KPiDCucK5wrPDicK3wqLCvMO+w4jDi8K2w5TDiMOOwrrD
jsK9wrvDksOXwrvDssK6w4/DjcKsw5bCrsOVw73DisK9w4jCt8OIw4/Cu8Oywr3Dk8OKw5zCo8Ks
w4fDq8OTw6vCt8KiwrzDvsOIw4vDlMOZwrTDjsOIwrfDiMOPw5LDlMK7w7HCtcODw4PDtw0KPiDD
iMK3w4rDqcODw6bDksOiwrzDu8KhwqPCt8KiwrzDvsOIw4vCssK7wrbDlMOIw47CusOOw4rDnMOO
w4TCu8KvwrLDrsOSw6zDk8Kww4/DrMK2w7jCtcK8w5bDgsK5w4rDksOiwrvDssK0w63DjsOzw4rC
ucOTw4PCuMODwrXDiMOQw4XDj8Kiw4vDuQ0KPiDDlMOswrPDicK1w4TDiMOOwrrDjsOWwrHCvcOT
wrvDssK8w6TCvcOTw4vDsMK6wqbCs8OQwrXCo8OUw7DDiMOOwqHCow0KPiBUaGlzIGUtbWFpbCBh
bmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20g
T1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hv
c2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNv
bnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8s
IHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0
aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBw
cm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
ZG8gbm90IHJlYWQsIGNvcHksIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlzIGluZm9ybWF0aW9uLiBJ
ZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIHRyYW5zbWlzc2lvbiBpbiBlcnJvciwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGUtbWFpbCBhbmQgdGhlbiBkZWxl
dGUgdGhpcyBtZXNzYWdlLg0KPiBFbGVjdHJvbmljIGNvbW11bmljYXRpb25zIG1heSBjb250YWlu
IGNvbXB1dGVyIHZpcnVzZXMgb3Igb3RoZXIgZGVmZWN0cyBpbmhlcmVudGx5LCBtYXkgbm90IGJl
IGFjY3VyYXRlbHkgYW5kL29yIHRpbWVseSB0cmFuc21pdHRlZCB0byBvdGhlciBzeXN0ZW1zLCBv
ciBtYXkgYmUgaW50ZXJjZXB0ZWQsIG1vZGlmaWVkICxkZWxheWVkLCBkZWxldGVkIG9yIGludGVy
ZmVyZWQuIE9QUE8gc2hhbGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlz
ZSBvciBtYXkgYXJpc2UgZnJvbSBzdWNoIG1hdHRlciBhbmQgcmVzZXJ2ZXMgYWxsIHJpZ2h0cyBp
biBjb25uZWN0aW9uIHdpdGggdGhlIGVtYWlsLg0KPiBVbmxlc3MgZXhwcmVzc2x5IHN0YXRlZCwg
dGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBhcmUgcHJvdmlkZWQgd2l0aG91dCBhbnkg
d2FycmFudHksIGFjY2VwdGFuY2Ugb3IgcHJvbWlzZSBvZiBhbnkga2luZCBpbiBhbnkgY291bnRy
eSBvciByZWdpb24sIG5vciBjb25zdGl0dXRlIGEgZm9ybWFsIGNvbmZpcm1hdGlvbiBvciBhY2Nl
cHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFjdC4gVGhlIHNlbmRlciwgdG9nZXRo
ZXIgd2l0aCBpdHMgYWZmaWxpYXRlcyBvciBhbnkgc2hhcmVob2xkZXIsIGRpcmVjdG9yLCBvZmZp
Y2VyLCBlbXBsb3llZSBvciBhbnkgb3RoZXIgcGVyc29uIG9mIGFueSBzdWNoIGluc3RpdHV0aW9u
IChoZXJlaW5hZnRlciByZWZlcnJlZCB0byBhcyAic2VuZGVyIiBvciAiT1BQTyIpIGRvZXMgbm90
IHdhaXZlIGFueSByaWdodHMgYW5kIHNoYWxsIG5vdCBiZSBsaWFibGUgZm9yIGFueSBkYW1hZ2Vz
IHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gdGhlIGludGVudGlvbmFsIG9yIG5lZ2xpZ2Vu
dCB1c2Ugb2Ygc3VjaCBpbmZvcm1hdGlvbi4NCj4gQ3VsdHVyYWwgRGlmZmVyZW5jZXMgRGlzY2xv
c3VyZTogRHVlIHRvIGdsb2JhbCBjdWx0dXJhbCBkaWZmZXJlbmNlcywgYW55IHJlcGx5IHdpdGgg
b25seSBZRVNcT0sgb3Igb3RoZXIgc2ltcGxlIHdvcmRzIGRvZXMgbm90IGNvbnN0aXR1dGUgYW55
IGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFj
dCwgcGxlYXNlIGNvbmZpcm0gd2l0aCB0aGUgc2VuZGVyIGFnYWluIHRvIGVuc3VyZSBjbGVhciBv
cGluaW9uIGluIHdyaXR0ZW4gZm9ybS4gVGhlIHNlbmRlciBzaGFsbCBub3QgYmUgcmVzcG9uc2li
bGUgZm9yIGFueSBkaXJlY3Qgb3IgaW5kaXJlY3QgZGFtYWdlcyByZXN1bHRpbmcgZnJvbSB0aGUg
aW50ZW50aW9uYWwgb3IgbWlzdXNlIG9mIHN1Y2ggaW5mb3JtYXRpb24uDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+IE9QUE8NCj4gDQo+IOacrOeUteWtkOmCruS7tuWPiuWF
tumZhOS7tuWQq+aciU9QUE/lhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7pgq7ku7bm
jIfmmI7nmoTmlLbku7bkurrvvIjljIXlkKvkuKrkurrlj4rnvqTnu4TvvInkvb/nlKjjgILnpoHm
raLku7vkvZXkurrlnKjmnKrnu4/mjojmnYPnmoTmg4XlhrXkuIvku6Xku7vkvZXlvaLlvI/kvb/n
lKjjgILlpoLmnpwNCj4g5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM5YiH5Yu/5Lyg5pKt44CB5YiG
5Y+R44CB5aSN5Yi244CB5Y2w5Yi35oiW5L2/55So5pys6YKu5Lu25LmL5Lu75L2V6YOo5YiG5oiW
5YW25omA6L295LmL5Lu75L2V5YaF5a6577yM5bm26K+356uL5Y2z5Lul55S15a2Q6YKu5Lu26YCa
55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu25Y+K5YW26ZmE5Lu244CCDQo+IOe9kee7nOmA
muiur+Wbuuaciee8uumZt+WPr+iDveWvvOiHtOmCruS7tuiiq+aIqueVmeOAgeS/ruaUueOAgeS4
ouWkseOAgeegtOWdj+aIluWMheWQq+iuoeeul+acuueXheavkuetieS4jeWuieWFqOaDheWGte+8
jE9QUE/lr7nmraTnsbvplJnor6/miJbpgZfmvI/ogIzlvJXoh7TkuYvku7vkvZXmjZ/lpLHmpoLk
uI3mib/mi4XotKPku7vlubbkv53nlZkNCj4g5LiO5pys6YKu5Lu255u45YWz5LmL5LiA5YiH5p2D
5Yip44CCDQo+IOmZpOmdnuaYjuehruivtOaYju+8jOacrOmCruS7tuWPiuWFtumZhOS7tuaXoOaE
j+S9nOS4uuWcqOS7u+S9leWbveWutuaIluWcsOWMuuS5i+imgee6puOAgeaLm+aPveaIluaJv+iv
uu+8jOS6puaXoOaEj+S9nOS4uuS7u+S9leS6pOaYk+aIluWQiOWQjOS5i+ato+W8j+ehruiupOOA
giANCj4g5Y+R5Lu25Lq644CB5YW25omA5bGe5py65p6E5oiW5omA5bGe5py65p6E5LmL5YWz6IGU
5py65p6E5oiW5Lu75L2V5LiK6L+w5py65p6E5LmL6IKh5Lic44CB6JGj5LqL44CB6auY57qn566h
55CG5Lq65ZGY44CB5ZGY5bel5oiW5YW25LuW5Lu75L2V5Lq677yI5Lul5LiL56ew4oCc5Y+R5Lu2
5Lq64oCd5oiW4oCcT1BQT+KAne+8ieS4jeWboOacrOmCruS7tg0KPiDkuYvor6/pgIHogIzmlL7l
vIPlhbbmiYDkuqvkuYvku7vkvZXmnYPliKnvvIzkuqbkuI3lr7nlm6DmlYXmhI/miJbov4flpLHk
vb/nlKjor6XnrYnkv6Hmga/ogIzlvJXlj5HmiJblj6/og73lvJXlj5HnmoTmjZ/lpLHmib/mi4Xk
u7vkvZXotKPku7vjgIINCj4g5paH5YyW5beu5byC5oqr6Zyy77ya5Zug5YWo55CD5paH5YyW5beu
5byC5b2x5ZON77yM5Y2V57qv5LulWUVTXE9L5oiW5YW25LuW566A5Y2V6K+N5rGH55qE5Zue5aSN
5bm25LiN5p6E5oiQ5Y+R5Lu25Lq65a+55Lu75L2V5Lqk5piT5oiW5ZCI5ZCM5LmL5q2j5byP56Gu
6K6k5oiW5o6l5Y+X77yM6K+35LiO5Y+R5Lu25Lq65YaN5qyh56Gu6K6k5LulDQo+IOiOt+W+l+aY
juehruS5pumdouaEj+ingeOAguWPkeS7tuS6uuS4jeWvueS7u+S9leWPl+aWh+WMluW3ruW8guW9
seWTjeiAjOWvvOiHtOaVheaEj+aIlumUmeivr+S9v+eUqOivpeetieS/oeaBr+aJgOmAoOaIkOea
hOS7u+S9leebtOaOpeaIlumXtOaOpeaNn+Wus+aJv+aLhei0o+S7u+OAgg0KPiBUaGlzIGUtbWFp
bCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZy
b20gT1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkg
d2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQg
dG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1p
bmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBp
cyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVh
c2UgZG8gbm90IHJlYWQsIGNvcHksIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlzIGluZm9ybWF0aW9u
LiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIHRyYW5zbWlzc2lvbiBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGUtbWFpbCBhbmQgdGhlbiBk
ZWxldGUgdGhpcyBtZXNzYWdlLg0KPiBFbGVjdHJvbmljIGNvbW11bmljYXRpb25zIG1heSBjb250
YWluIGNvbXB1dGVyIHZpcnVzZXMgb3Igb3RoZXIgZGVmZWN0cyBpbmhlcmVudGx5LCBtYXkgbm90
IGJlIGFjY3VyYXRlbHkgYW5kL29yIHRpbWVseSB0cmFuc21pdHRlZCB0byBvdGhlciBzeXN0ZW1z
LCBvciBtYXkgYmUgaW50ZXJjZXB0ZWQsIG1vZGlmaWVkICxkZWxheWVkLCBkZWxldGVkIG9yIGlu
dGVyZmVyZWQuIE9QUE8gc2hhbGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBh
cmlzZSBvciBtYXkgYXJpc2UgZnJvbSBzdWNoIG1hdHRlciBhbmQgcmVzZXJ2ZXMgYWxsIHJpZ2h0
cyBpbiBjb25uZWN0aW9uIHdpdGggdGhlIGVtYWlsLg0KPiBVbmxlc3MgZXhwcmVzc2x5IHN0YXRl
ZCwgdGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBhcmUgcHJvdmlkZWQgd2l0aG91dCBh
bnkgd2FycmFudHksIGFjY2VwdGFuY2Ugb3IgcHJvbWlzZSBvZiBhbnkga2luZCBpbiBhbnkgY291
bnRyeSBvciByZWdpb24sIG5vciBjb25zdGl0dXRlIGEgZm9ybWFsIGNvbmZpcm1hdGlvbiBvciBh
Y2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFjdC4gVGhlIHNlbmRlciwgdG9n
ZXRoZXIgd2l0aCBpdHMgYWZmaWxpYXRlcyBvciBhbnkgc2hhcmVob2xkZXIsIGRpcmVjdG9yLCBv
ZmZpY2VyLCBlbXBsb3llZSBvciBhbnkgb3RoZXIgcGVyc29uIG9mIGFueSBzdWNoIGluc3RpdHV0
aW9uIChoZXJlaW5hZnRlciByZWZlcnJlZCB0byBhcyAic2VuZGVyIiBvciAiT1BQTyIpIGRvZXMg
bm90IHdhaXZlIGFueSByaWdodHMgYW5kIHNoYWxsIG5vdCBiZSBsaWFibGUgZm9yIGFueSBkYW1h
Z2VzIHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gdGhlIGludGVudGlvbmFsIG9yIG5lZ2xp
Z2VudCB1c2Ugb2Ygc3VjaCBpbmZvcm1hdGlvbi4NCj4gQ3VsdHVyYWwgRGlmZmVyZW5jZXMgRGlz
Y2xvc3VyZTogRHVlIHRvIGdsb2JhbCBjdWx0dXJhbCBkaWZmZXJlbmNlcywgYW55IHJlcGx5IHdp
dGggb25seSBZRVNcT0sgb3Igb3RoZXIgc2ltcGxlIHdvcmRzIGRvZXMgbm90IGNvbnN0aXR1dGUg
YW55IGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250
cmFjdCwgcGxlYXNlIGNvbmZpcm0gd2l0aCB0aGUgc2VuZGVyIGFnYWluIHRvIGVuc3VyZSBjbGVh
ciBvcGluaW9uIGluIHdyaXR0ZW4gZm9ybS4gVGhlIHNlbmRlciBzaGFsbCBub3QgYmUgcmVzcG9u
c2libGUgZm9yIGFueSBkaXJlY3Qgb3IgaW5kaXJlY3QgZGFtYWdlcyByZXN1bHRpbmcgZnJvbSB0
aGUgaW50ZW50aW9uYWwgb3IgbWlzdXNlIG9mIHN1Y2ggaW5mb3JtYXRpb24uDQo=
