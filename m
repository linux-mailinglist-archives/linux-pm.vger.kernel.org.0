Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E33DF709
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 23:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhHCVn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 17:43:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:18453 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhHCVn2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 17:43:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="200960922"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="200960922"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 14:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="441397318"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2021 14:43:14 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 14:43:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 14:43:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 3 Aug 2021 14:43:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 3 Aug 2021 14:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2zRuZpOFPh/wR5U8ZUnnSzOBzJPXKKFp2EnBznSpR9KYa8Kvb1BvmFh5kWR7TgkvP5tdV/lp2UBO51e9+5vQV9rm/rzM37DlDOU+OPMjIqh3HwnqDYZgWSbLvD06rG9jp7WIVa9dnPw4Lpfyobhk9QsbqesN66ReagacSD1Z4/CV+2NwjIa7rrR6cBUr5h75PlVQg0JDAh+PC7vr3OhAoMajrzP079z+TpJ1OVObOWy+Dphwu5R+F8duCW4k5Pf1n1z4hpkxE/13/ncvQXvbHMXEe+wMfBqxM7JuYSg65fvkBmZSED6wjtTwR7myP/r246taKgIw4LYAAG3TkL5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxKy0OhibYp9yXodvNVhGNqRgYDfl+/r3ESw84t2RfA=;
 b=YXl2z0AvBJ+nmBu8t2yfetvry3o3upbem/BGGCkUHkG2ka56mhCOw7MXaNUgWFTlgMf79QZjw+6zbTIyEfntzc0oC8duL4fG/JU/6ihOIBVTjSaKdiHaxG/PTjlF6FeOnpkiOtDD20MOOe6Pm1rTWdDyQ7A5uiXkdnt6y5S3H+etDiM7lZ5e3n6h7ombLZd3QfRh75K6ANYVuK/c2hwnbeC3Z1YIRs2uqCvKqQyRj41QOTucLSpdiveUXPevQmBj8sIqJwGQKfbZTs4OTNgMYWXmC67TZjLtfT7U3Hl3Hi+6ttMrO58zJBz0SMt1CmVCfaN6NM9luuAdRASBBt66Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxKy0OhibYp9yXodvNVhGNqRgYDfl+/r3ESw84t2RfA=;
 b=DoVO8UKtlE1w44Js24IazbsxP7p1il9dGIAb6l035tJdiLr5H6Hp8YTlelqAERmNx67JXIWykDegoPOJSKrX1KmQgiHLHAgIDUkwIWtTPLQkvNDMhh0lMZWMepYpuCyic5sfb5JAt4toLbBAywO52Bns4oZCZjLhb4YUIhZSfSI=
Received: from BL0PR11MB3506.namprd11.prod.outlook.com (2603:10b6:208:31::24)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 3 Aug
 2021 21:43:11 +0000
Received: from BL0PR11MB3506.namprd11.prod.outlook.com
 ([fe80::5cde:1548:5ca6:8c31]) by BL0PR11MB3506.namprd11.prod.outlook.com
 ([fe80::5cde:1548:5ca6:8c31%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 21:43:11 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC:     Borislav Petkov <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v9 25/26] intel_idle/amx: Add SPR support with XTILEDATA
 capability
Thread-Topic: [PATCH v9 25/26] intel_idle/amx: Add SPR support with XTILEDATA
 capability
Thread-Index: AQHXhVR1DSZEuva7TUW+8JtOx9XY5Ktb2nWAgAZ5AICAAAGqAIAAAGlw
Date:   Tue, 3 Aug 2021 21:43:11 +0000
Message-ID: <BL0PR11MB35066FED42DA00B3215D8D5EE0F09@BL0PR11MB3506.namprd11.prod.outlook.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-26-chang.seok.bae@intel.com>
 <f17eb0da-c77e-cc95-b88c-6947a68f5f9a@intel.com>
 <9660CC2A-F09F-49BF-B5CF-7288B726C88E@intel.com>
 <eb14ec3c-55be-95a4-605d-92a2f36434f9@intel.com>
In-Reply-To: <eb14ec3c-55be-95a4-605d-92a2f36434f9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 258366e6-2692-4f5e-6797-08d956c7b0c2
x-ms-traffictypediagnostic: MN2PR11MB4710:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB47100B6F64E49226209D787AE0F09@MN2PR11MB4710.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f90Gp8raIQOVO0qwq+p3v2d7wpZ8iqUKCTkY2ttpRP0Qhk4q4UHZU+7x6FmJ9rc7gHkSk5I82/0AAtlyMkoss8cQQHfwMyyWiSNIto/ZT1NDb6qYnt1v69v3dKt1ApLatZl6UjS7Mt+PsTc8JemJ9LpOPEorYz+Vn4xU/WmTUN5MS+J6gToEqYCI4fyVRl+TmIxr45Ldo2MYWDBY/dmX7A6PHiNxG6lyr/Bm0KuWczS4w9UR58ZhFwHIcl1o+k1c+O6c1t+aRCbFEXxrrZr8o23iJljxyOuTplX6g8mSJLCcCYoCBGIe6JxmlGnWeqqowITwOw59XkS3dtVfinVNiTj0G6wJLUlfHgyI53TOnEaNIL0DSCIFnJFhFgs7viQR7tgkz4wMYA/3OvL4FZQ3j8mHlim5foicI1XV7cN3JA9d8pZ+dNqtTQxSaMySs5q/bjHcstOUHlmDpfE7V5dj7fr6HL3LZzP8sKM/zRu9mXak8AS/IAxdrQGrBZK9vV2ebHZvD+1ppEf2fxPpVx1GZ4ehhSj64lbUOLRLJcLGaFOautbOnWm1aDCkYJwrOG4ZFsDBCqz0Mbqox7G+e/Bnmdfmxj4ByjQum+vUr3Q2MkIVw67R5ooCxszAOgh29q+rz5ZiBcVxEEZEGg0CZA8BxcaFnPLAo5MAQKozl6YusaIOsR87GAm71GOqEDzrfcJzCUuu6IKcGZU/u1hPgudowA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3506.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(71200400001)(4326008)(76116006)(8676002)(8936002)(38070700005)(5660300002)(54906003)(478600001)(6636002)(66946007)(2906002)(38100700002)(558084003)(66476007)(52536014)(122000001)(7696005)(55016002)(66446008)(9686003)(33656002)(26005)(6506007)(86362001)(186003)(316002)(110136005)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZTZ21VVFU5QjUzOTVIRi92WGZxMGprZ3BieE9LejZlczNmZGI3MjAxa1VT?=
 =?utf-8?B?V3kzQzREWkZEbXBtLzNkTkxCekhIZ2hkWW9ERmJDSEU4aVgrK1FhMDkwWGxD?=
 =?utf-8?B?MDFJbmlXUEUvSUR4UzFzVGt1OVRubnRsOCtzOWp0TktNY0VMZ3RaZVlWWGYw?=
 =?utf-8?B?NTBCS1cxV29JVGpUOEgrOTljaEt6bytrdjc5RVJZWUdkNGVqanBOSU14KzMz?=
 =?utf-8?B?ZFYyeEhXK2hSR0pzUlFpc0xGRk00WVB5dkcxMW1ZY08rWWFMdEVzd01Sb1Q3?=
 =?utf-8?B?M08ra3hwK3U1ejQ4UWxuaUM4VnF1dVhlTHJybHVyeDhWeUdXa3lMSUVOczk5?=
 =?utf-8?B?a2VVUjFHRkRQa0FhVXo1WDBpZ2xPRlVKdmxjdFZBeWlJUDNXSTUxTlhkT043?=
 =?utf-8?B?bnNkV1ZsVzhLZ2RXT2tzRTFqQWtKVS9sQ3VPZzliWlIvY2wvYjhVR1R6eG45?=
 =?utf-8?B?Y0g0NWt1UHBwWEI5bzkrZC9IVVdlbFhXOUNMdytVS0ZFRk01d2VIZmdXeW1K?=
 =?utf-8?B?dkRlVHFxaU9WY3hSd0FkRE9jNFpBSW1vcFErczAxU04vV0ZlL2hMbTZTMFZt?=
 =?utf-8?B?c0ttNFJsRnBJM1UyOUVqUUlrUlBCQkZ0YkVSUnNJYytDMDF2djlCVGtNNCtN?=
 =?utf-8?B?b21BQ0llSGc2QlM0TzZ3YjFyb0l1SWJBbEtOdi80QURXWDkyOFo2VVRacCsx?=
 =?utf-8?B?SUdBWE53MjJ1N0hVMndMSHpyeWNYM0J5TXVNUXA2ZEE5dm9yQUdheFhsY29m?=
 =?utf-8?B?NGx6TUFMcHlxU3poSVhMUUFiVDVqUS96N216R1E3OEpGQ2cwbklwR09oc01n?=
 =?utf-8?B?azIxM0wwUmZ0V2hPeTF2eHVzMEdlOGc2Z3V4L2E2ZHQzaDlCKytIZTMyckls?=
 =?utf-8?B?dzRWeGxVVkZ2dndraXd3akpSKzNacnU0T1o4ZWQ1UWdLeUsrUkptMDc0Z2ZE?=
 =?utf-8?B?ZEc1c1VLWWJpZ3RYa2JNQW1EbS9JeW4vb2M3eVVOQlRlWjhteDFnY2FDaHIv?=
 =?utf-8?B?YU1ZMUZLS09jdHlqcDZXdWFpQ0ovRlRBR0RDRXlmeE5VVXBxM016M1BlNzJY?=
 =?utf-8?B?cDI2ZzdkNkNpcUN2QS9aZndBY1lpWkYrY2xmMEl1MUk2UzJrUWdQbXRMWTFt?=
 =?utf-8?B?N1hXbkpIZHJTUXhLd1RnTitHeXBtQVJmNThsQlNOQ1U4YWpqTWJ0S1JwdkpE?=
 =?utf-8?B?QnpoRm0xYkZHSE5zUzNMUWgvN2Vpa092bEtxQXo3Q0J3RU9meGZVWnJJb210?=
 =?utf-8?B?WUUrVWNNRzY2S0R4d2dlUVBhNUxRcFY1QlZYWWEvNzFEUlBFS2M5N256Znk2?=
 =?utf-8?B?RGhCYmZsb2NMM3NjNk0zei9JbGJKSmhsOUlMNmpvQVF4eVBuUzYwSjNQQzVE?=
 =?utf-8?B?VWVUVk1uV3JtYi9wK0xRcG85RkxhWWV1eFRNUlo2d0hNaDI1WmJadlZCeXFj?=
 =?utf-8?B?OHVyVUsyc1h5TTgvSEZnY0pPSC9KYXp3alo3S1hzS2tZeHBEQVNLNzdWNmJO?=
 =?utf-8?B?OTEwTTlFS25yaDhLaFEyL3ppWE9hb0gwK3NyVjJOYjVBRHBTc2NkZmU2WUF0?=
 =?utf-8?B?bUdnZm11T1RxWm4wdXFQWEI0VHFMNm1ZY3BRbG5JSERGTVU1aXE3Y0lrYnVM?=
 =?utf-8?B?Z1BtNG5HeEJlNk9sVnZWVkRCZDhhajdMME1GUUdORDI3STUvSzdrM1lEaGtq?=
 =?utf-8?B?SFZ1UEkweHNwQmE2L090enhUZk1TNXNQNnJsTnNWaFdhaktsWEgvOHpQdnpX?=
 =?utf-8?Q?fFM61/fBG2nt3PvAP6RVkMhKdNQEtyIQoL2f8k7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3506.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258366e6-2692-4f5e-6797-08d956c7b0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 21:43:11.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fjsnf/GXK5vEnpZ75Rtm1Xnso024pC6JMk2aCmPOGsYmg7IiMtyjkj0KxvTs1oSu4qutMEFmwNfD78j+LPhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBBbHNvLCBzaG91bGQgdGhpcyBoYXZlIHNvbWV0aGluZyBsaWtlIGEgZnByZWdzX3N0YXRlX3Zh
bGlkKCkgY2hlY2s/ICBJZiB0aGUgcmVnaXN0ZXJzIGFyZSBpbnZhbGlkLCBzaG91bGQgdGhpcyBi
ZSBjYWxsaW5nIHRpbGVfcmVsZWFzZSgpPw0KDQpGcm9tIGEgY29ycmVjdG5lc3MgcG9pbnQgb2Yg
dmlldywgaXQgaXMgdmFsaWQgdG8gYWx3YXlzIGNhbGwgdGlsZV9yZWxlYXNlKCkgaGVyZS4NCkZy
b20gYSBwZXJmb3JtYW5jZSBwb2ludCBvZiB2aWV3LCB0aWxlX3JlbGVhc2UoKSBpcyB2ZXJ5IGZh
c3QuDQoNCg0KDQo=
