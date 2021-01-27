Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9163052F4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 07:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhA0GOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 01:14:25 -0500
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:42945
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235467AbhA0DTX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 22:19:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOt2DpSbZV3Mew8L979ZYQ0o6oHZVphVEVEPxbqC2bmNa1jE9r4xOmQZ07NyLEPrdk1qTDbDDjRgvMaihQmh2TEGHYuhH2W0GP9QWWfsflpjjxDNEc0AakNPSjP2Tei4FBB1YCGXhfqYyj0N+iFym38LgKFXW3ZVf/+wzv98XRV1cpswIfDC0khn1FOLtjsMB0kBEmXk5hIwa/NyAf9p+W7EsvSb9+G9DpjPhQBFcUb9MR15iTp1Zt10XDO3QngoYWBgJZRnlJAeYWG9eDq13IrpZ9+o+ywCfkGSZ6+Vi4FPc84QTDyxkgRkazxXDrLw4fmJ1cZOkvwd/u/3OHCdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht0Ha2BwBsMevZIJ5BoIzg0RD+ZGU+MdIbWJXoyxECA=;
 b=blw1Yd/rBPjhqtX8sqDVvlqt0aoRWQEqnS/MDjt2jbMUCjgAARS7YxvAnyeiNIMCpoeDv0QL57eEln7fRcQW82abAwTUgUXBQJaXUC6Fu1YpdJufBMvS3avWokLZDQgoomSdOCAs8L6YE8jAmI+uVrXCvKCLJDprpPGQm1f8EQtyYSI58yJk8wSHx7kivc4dzl5eH1WXqJs5hYtfP7YWIFqqIyTXw3ZR2IeBAMSTE/2XIpkGvvTVKCMiPWsdHInNc1QWNy1OCbGr1Y6e0W0a4cXR7wjS4EcLvE/rgdkgh6lax8CcMcdr4+uQ6OjC6Xa5875a78SUXEcRDFGA9zvMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht0Ha2BwBsMevZIJ5BoIzg0RD+ZGU+MdIbWJXoyxECA=;
 b=QXGb/uHbcdxKTt+qvcCTaJuQ4FpyoNQXswDkdkKPotQcYTsE/xn9Yjqh9dCNkOdwCIR2PvKzEA5eDbydTZRLI6pJIMCmGoOj8cj0k3eYmOTqd0qTE6rGLV7XP1PpMbskQvfE612mORJsy9UWZW6oTK4mzOha/YYrtb9TnYvjx7A=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3030.namprd11.prod.outlook.com (2603:10b6:a03:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 03:18:24 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 03:18:24 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBQTTogcmVtb3ZlIFBGX1dRX1dPUktFUiBtYXNr?=
Thread-Topic: [PATCH] PM: remove PF_WQ_WORKER mask
Thread-Index: AQHW8s6id2HiVZdI2kGFxo0iWoaVzKo60HTf
Date:   Wed, 27 Jan 2021 03:18:24 +0000
Message-ID: <BYAPR11MB26324750851DA9821B44CF66FFBB9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210125041828.20965-1-qiang.zhang@windriver.com>
In-Reply-To: <20210125041828.20965-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98935e46-3336-497d-dafd-08d8c27234f1
x-ms-traffictypediagnostic: BYAPR11MB3030:
x-microsoft-antispam-prvs: <BYAPR11MB3030DE57A4225E479717E8FAFFBB9@BYAPR11MB3030.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpAePhuKp8Hqugoht/moH1WWL59szEAyDTchnXm1CXuN+E6P1rv0dMPKG/jRcPJkvngdUAexEkIBW/5eXbxHHp8N7bRSxVn1vNWHjv/zpQDX9h06tJlp2MHQ5vXC7k+tgfrXeVoMrogIt8DmgTqQpiC76TI8dGvVqHdqgH2Rf8JaV98q4XeqYxo6oiMrEMAdUiCd0pA9svW7WbCEmPOBRuraHaDHCSnNtn2E8/o8n9LsjeeoxTlUD5pJIO5TQ6v/M6dXUB0v5V3yDO/4Ms9y5jvtwuTes4OL14GRerrOPapUYWXJNTYzjznUQ5x6oe2nxxro+2TkVqtGw7pj00MJ8t5XjrBN/GJPoqOLPGXXSDgD8OkHJ4AEsmj0tAPRWrrAzN5LYrcQXU+W4CUaC+BXgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(376002)(136003)(396003)(7696005)(316002)(478600001)(224303003)(33656002)(4744005)(71200400001)(86362001)(54906003)(2906002)(91956017)(6916009)(8936002)(9686003)(4326008)(83380400001)(55016002)(76116006)(5660300002)(26005)(186003)(52536014)(66446008)(66556008)(64756008)(6506007)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?dUhqYlpHTnBDcUM3SWpHUGtBQnowUzl3MDV4VWlFNmhUME4wQytRS3hmWVRR?=
 =?gb2312?B?b0gwcm9hQUN1Yllhb0JnZFYyQm5yeE44VkxQakk0aExxQWJ0NTBxQldGc040?=
 =?gb2312?B?QUdlbUVCMm9EdjZJRHZaWWVpdEFkRWxkbzBYa3dwRFZCWmJzeDJnVWhLT1or?=
 =?gb2312?B?YmluY3hwdmpYOTFTckRFWHhwVlZodEhxdTBEMEJ4c0dqbEk3UW4yL3BDbklt?=
 =?gb2312?B?MEw4dy96ejRNdGp3TVFYN1hSZ1lzZURwYVNvM2hSMFYxays4ZUd2S2dmMWR3?=
 =?gb2312?B?cWxPZzlvQkNQNmJHMHNCc3ozL3duaUdGK0YwbXpPOWVxZDNMYzlEemxwSUZS?=
 =?gb2312?B?MWVsRkNWQ1lWcWdjN2RHclArMUlJSmtrdUp0ZDF6S3QvZ05ZMmRUWGFQWEZa?=
 =?gb2312?B?Z0ZQZVRtVCthMVppWWpQazA4L0RuTXhrYmFicDlYOGtFdlZ3cjRITkpqRjR2?=
 =?gb2312?B?OGhRa0l1VVdkN2Q0M21QSXdQdTdCOEdja3JZdjhUSnhQQVhUbHRXNEJnUjJQ?=
 =?gb2312?B?d3NxcGRLbnlWY2xDSEJ6dHpFM2ZzM0Q4SWxYV3FGRVNrWkttL2hGaDlNVGVw?=
 =?gb2312?B?V1lqMk9iLzV4NFJ1UnFxYURzY2V3RUN3YUMzUE5zSndkdzJoL25FS080cld6?=
 =?gb2312?B?NHBBRWQyZ1RLM004RmJ1Zyt3c3hMa2kwSE5uam0wL2RTZ1hncGVJRExOT1Br?=
 =?gb2312?B?S0FSRFBETkM1VURQNVllaCtITmtKY2tFcXNjbm1HbVVrREdiVTkrQk5QeW9z?=
 =?gb2312?B?dHNTSzdRV1BzV2FQZEpKWUdQNENzNUY1bTZrOEI4RVNiMWtOcVdiUG9ZRkY0?=
 =?gb2312?B?aEJRd0dURVRFM1VjcG54aXJlREU3YjE5OFRRYTJiMXFNMkx1ek9VWFFBa3Ay?=
 =?gb2312?B?dlJqTUVwRGtCSDM5cU43WmpxbEJWQ0R6UjdkSVZaS09xUEVtZjMyWkZ1dm9W?=
 =?gb2312?B?ZXV3QjlIQ040N1F6RFJMb2RnSmpSdTNHT2plRXBod1RwK1hkN0c4WXAwS0dD?=
 =?gb2312?B?SVRPR1hpSmxQTmhUZEdqdEx3ZnVxUnZsNHZyUjkvN0lvaFRFNEhDZThYemNz?=
 =?gb2312?B?Nld1ajNRenp2dVI3VDE3blJ3b0QxMUVaNW41SHJqRzlMWlFhVzhtdkVOeFZ2?=
 =?gb2312?B?ZDZQb3RTMHpaTnNncXMxQlhUbjk3T3daKy91a29FSW9WNEo0cUxGVzAyUVB6?=
 =?gb2312?B?bW1xdmx1L3pnL3RzaDdDeDFpL25kMWNlaUQyVmhwNnpsaGFacGlZSHlEdjhG?=
 =?gb2312?B?ZkRkN1ZXbWJkTmZJeWJ2eFVwblM2VnA5UEVYZ2h5dmVkTWwxUGV2aitwNk1l?=
 =?gb2312?B?czEyZUJSMlZ4UFpuME91b0NrdzRVUlBQU1RoWHFHVjVJYmMvR2Zydy9sYlg4?=
 =?gb2312?Q?AMr+0z0RDvEb0hs/b0+t0piPxtlPMtpM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98935e46-3336-497d-dafd-08d8c27234f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 03:18:24.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OR0fcDxafBj0b0k9I/kYuZKUwuc1rUKl+a9e4LOhwZwS8aiZAcwhmdxAGCQrklhBKotJoj7aSXkJCpVHfz9II4oEJf1PKAgnX4Z/DWL+IPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3030
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IFpoYW5n
LCBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4NCreiy83KsbzkOiAyMDIxxOox1MIy
NcjVIDEyOjAwDQrK1bz+yMs6IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tDQqzrcvNOiBsaW51
eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6
IFtQQVRDSF0gUE06IHJlbW92ZSBQRl9XUV9XT1JLRVIgbWFzaw0KDQpGcm9tOiBacWlhbmcgPHFp
YW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQoNCkR1ZSB0byBrd29ya2VyIGFsc28gaXMga2VybmVs
IHRocmVhZCwgaXQncyBhbHJlYWR5IGluY2x1ZGVkDQpQRl9LVEhSRUFEIG1hc2ssIHNvIHJlbW92
ZSBQRl9XUV9XT1JLRVIgbWFzay4NCg0KU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZy56aGFu
Z0B3aW5kcml2ZXIuY29tPg0KLS0tDQoga2VybmVsL3Bvd2VyL3Byb2Nlc3MuYyB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2tlcm5lbC9wb3dlci9wcm9jZXNzLmMgYi9rZXJuZWwvcG93ZXIvcHJvY2Vzcy5jDQppbmRl
eCA0NWIwNTRiN2I1ZWMuLjUwY2M2MzUzNDQ4NiAxMDA2NDQNCi0tLSBhL2tlcm5lbC9wb3dlci9w
cm9jZXNzLmMNCisrKyBiL2tlcm5lbC9wb3dlci9wcm9jZXNzLmMNCkBAIC0yMzUsNyArMjM1LDcg
QEAgdm9pZCB0aGF3X2tlcm5lbF90aHJlYWRzKHZvaWQpDQoNCiAgICAgICAgcmVhZF9sb2NrKCZ0
YXNrbGlzdF9sb2NrKTsNCiAgICAgICAgZm9yX2VhY2hfcHJvY2Vzc190aHJlYWQoZywgcCkgew0K
LSAgICAgICAgICAgICAgIGlmIChwLT5mbGFncyAmIChQRl9LVEhSRUFEIHwgUEZfV1FfV09SS0VS
KSkNCisgICAgICAgICAgICAgICBpZiAocC0+ZmxhZ3MgJiBQRl9LVEhSRUFEKQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgX190aGF3X3Rhc2socCk7DQogICAgICAgIH0NCiAgICAgICAgcmVhZF91
bmxvY2soJnRhc2tsaXN0X2xvY2spOw0KLS0NCjIuMTcuMQ0KDQo=
