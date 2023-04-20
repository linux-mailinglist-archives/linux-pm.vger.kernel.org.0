Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51066E87AE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjDTBut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 21:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjDTBuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 21:50:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02B5FEA
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681955436; x=1713491436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VJO6jtNst79/IhU6ZPa4+WbJAs2oO6MeKK2tVrLEE0E=;
  b=C8pRwnc+KX3Svi26oQF0wA4AI9okVasC0Uj0x71efWgyJHvdDftsbObt
   Xz0LRgdZEyUkGvcLrOzxFFZ+uq39k4AimN3+vhAh1WMfZxPo9cIFEFGHb
   Uk/AgyAA1dXRNHlysF4C+Atfzx8xk/v54vmDNCdZAChyBwztU6uYAvW5u
   im7tQd+nbPx9ZnU2mi1iFN61yazDfE9nLtLu9vtvIlhR6QUUEPMLxwE3/
   vvJW/jA8PE8jegHLPdgJoS9pi5Z3gdA5q2VQkfbi6zhxrD5U9lB136aFz
   amB4iPY2wtCBSSWvmTTVl+sxXe68eOlDgkJUrR5WCyUWxJKHAld9nUE74
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343089043"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="343089043"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691721273"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="691721273"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2023 18:50:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 18:50:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 18:50:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 18:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdEPCVvFXQJf5MEQ747tg6kVZdg8bZwVF0VqXVEUG00WGOi7exZGmsh+vR+OoIIrYT7FkZHKVAQo1I7UHt3Oz6bO8FL4ej4ZwhmDAVjUYc03+HP9NbIJY38nwpgPMhu8CK3+sjH24oAgYWg9dW5sGLo9f7F9EMU0WYVKN+461htjxTFnHwLZKsy4cTA3IObZ6IeG7pI9P2BZ82I/EKuWNq2YIhHupHWFRiTlJn6AoUf+aln0XWr+/qpDdIFI4ZZdaKMWj3Tsen4sy/C80DsKMSqqgAZOCtVSWl+NPpr7d+YWoMSR3rkLFamTqUOJmEY1qac6FIEjpSaSCko1qqBkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJO6jtNst79/IhU6ZPa4+WbJAs2oO6MeKK2tVrLEE0E=;
 b=YWDyjFEwTW2Vj2jga1/kB2nySSizzZCwAUg1cmmfVCdMmPPxm3/ykBH489J4F46BkUBkP02UidBASpfIL6M+DjcmFXkOWbxU4UtjWShl5FQavyVpLLRbCtGINoNiOoA161zeDwSrfbkZgT6VO9AvagkdKsCgHMQtJRwnTzfzt76hGr0hyZYd1I7G5Yp8ONzDkZSrcK12q60rXKgiZ9nH0jr3d71ZuTlk6SUDFnmM+Flre5UzyL8SM6/HSeEGS87dAw+xJ6bh1XXJSz7N4Cm0dYyOODOkdXANRpqcEPnnsuR+mjjVT49ZM4qY+XhQfxqZHNgaHHANS5rwJxx8VtNxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 01:50:33 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%4]) with mapi id 15.20.6277.047; Thu, 20 Apr 2023
 01:50:33 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/7] intel_idle: improve C-state flags handling robustness
Thread-Topic: [PATCH 4/7] intel_idle: improve C-state flags handling
 robustness
Thread-Index: AQHZcs0F3GR0n+VkNUuocKN2VRMMzK8zb2CA
Date:   Thu, 20 Apr 2023 01:50:33 +0000
Message-ID: <35a8253cf195fc804acee900380e31da5680f0ff.camel@intel.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
         <20230419143947.1342730-5-dedekind1@gmail.com>
In-Reply-To: <20230419143947.1342730-5-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SJ0PR11MB7703:EE_
x-ms-office365-filtering-correlation-id: 2cb5ad4d-56af-43d0-0d3f-08db4141a0ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1R5+WWUPZVpYsixByMbAzlouwFU0pMibR7Ey93piodtZl8wnxKKlvk35ZhlqWIq2fA6zfTrl3zy0HFIY6ZDbK+9Pxt/K+QCTpNFIX6wwZ1RWO/89EQsftkobJl2G19SNN+gVNJoOv1OdyT/5+6TCXGlMQ9hApMACjersjo9D+XH9w64WaWUdbuli+/sH5FTU8MpykKmQlFabpXRtFnnHs9ObU/rmpY+2z1YvoQvsH34ECBfrB/W+S6ZtB2dhQitu7vPN1n1DwRlm/08/92KHSdumzHghndiHCNuqFqeSESS5hjw6e3uIHqJBg2yjUIDzTMeG1xkZ5R5iv+KcGlW2jW4pFm7pbH6ph5XXiDZ1AKPcX6UbiwsdPvyKyg0yBKRSzl8J1X+nl9lW6xBFcpZNhPVfvzmoTAj9DWFtAKbKk60ZbT4f5Js80yZ2UR1aMrXiZkJ3pmLYud37YrRHGAmC8DTUD9oTijLzvOA8etu6YdHbIUWZC/wjersCtWJIZrSSH7LR7e6Kh6P772WolYxtWS/tmHOuD8Gx620E3+05BoqCmqhyW91KW472/asW4/6SzA7aWYYjRbJgIkvd1mQ/eFJpbViS2z75DXrPrbswGdxTARVzlI5UoqzNyVNoHos+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(36756003)(86362001)(38070700005)(2906002)(6486002)(71200400001)(83380400001)(2616005)(186003)(26005)(6512007)(6506007)(66556008)(478600001)(66446008)(66476007)(76116006)(91956017)(4326008)(66946007)(122000001)(41300700001)(38100700002)(110136005)(316002)(82960400001)(8676002)(5660300002)(64756008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG1NSEU0VVhZNHI5SC9CUExVWU9qN1VwKzNTZTNXR3FnVzd0c2pJTHk0MGVP?=
 =?utf-8?B?VzlQcElHYVgzd0pUTExPY0tTZlR3cDRoTXJNVU5RUzJ4cGhtU2hFT1NNRllL?=
 =?utf-8?B?T2xQbFh3NGJRVlJvblhFeGF2dmRXaTZJVVBrcERtc1hRdG9pbWhaMkpRcDQ1?=
 =?utf-8?B?YUROVDJBcExtQnh4dlYrL0lmNEc2TWhXTkhRK2RvbjN6ZkUzZ0czaytmeVlY?=
 =?utf-8?B?dFVlYm1UR0pJa29EWGo4bmhZdUNoNWtxVVcxZzlMYTQwTWhKYURqODFMampR?=
 =?utf-8?B?VHZ2MkZ1THl6SVVtUDlHV2syOVB1aHRlaFhIejZNTFBpM1J2anBzdTJBTG12?=
 =?utf-8?B?ejNKRzdtc3JrVk02Mk83VHhWN2UyWWtTeE1ENHFwbzMwVGVBMlQvVEZJcEZp?=
 =?utf-8?B?ZnJYWnBzL09wZ3grMGxjNHM4SWZIY1RuTGFWQ001b20rWERpdlN6TC80dENJ?=
 =?utf-8?B?SjNiY0NXTms2MlhIUUhDdk1Kam5NcmZXV1JUL0YvVjZnOFMrU2RmK0d2VHAx?=
 =?utf-8?B?MEdDRTZQSGU1S011MXlsbjhvNStEaXZCcVpWODN3ZjFYVHZGcDBtRUltZFMv?=
 =?utf-8?B?Y0R5YXQyb0ljQUlrdHdBNFh3UXFtL1I4WkJyTk44YVZKUm9lbTR0R3RGdzlj?=
 =?utf-8?B?cVRRaDA4eVhoREtvVjFxcmcxZGtBNzRaUU9YRldWOSs4bGF0S3EvZHdMUzA2?=
 =?utf-8?B?UWZrbitpWUpSRitpdlBqSWdDaGVEVjFGWStzWUk2dU1vUklGTzlrcisrVDZQ?=
 =?utf-8?B?RE04K1RrUlFHRk9KaVVXdnR1VkxPSHZLTk9qc3UyMzd1QlBXM1hsdjR2dXQz?=
 =?utf-8?B?bWFtQndvZlh4YXdDNUhRRDFZSEM5cFZybU45RFNFTFNMQ3FRZ3hOUFYwTm9y?=
 =?utf-8?B?bTByRWdDeks2S1lXbDJMNkZBNGdrMjNXaG9mbHpSbldZdDNOWExsQ2phVzhq?=
 =?utf-8?B?Tm1Rc0R1cFAwV1V5Nm1GWEw2WFROMFMxenkxZ1I5aGtDM1VwSWo1QnU4WkMz?=
 =?utf-8?B?b2l2KzhxVWMyTTZkVENyQUdQMzBEY3RwSmhzQ09aNEhIVEZzOW9zR0Z0Ykpi?=
 =?utf-8?B?TklRRmFUa2JsZmZrdXN3YmZYNDRnZlF1THRhVzk4V1A1M09zdm1PVitCeEVv?=
 =?utf-8?B?WDZBZW5kS2lqWTk0bkNjYjlwdDFCOUkxY1VWS1hGU2hVdnZZTHFZSVhDazYr?=
 =?utf-8?B?S3hmdEI5SFJEWTI1bmxzZGNqejJSSlVVQndrZ0tzaE1ZY1pIRnlnRFBrWmFH?=
 =?utf-8?B?aHB5NHkzZURnSTFRZStJR01tSWxSQmNGS21xODZ1Z0k2b2V4RVlpUytGV29J?=
 =?utf-8?B?MCtwMTdXdy9GQ2I2SWtaOGducHBhYm5OQVVHZ2p2QVg1TWg2VFVRNktQMXhM?=
 =?utf-8?B?WGg2OUhza3RWQnpXUUl3UFBMMmNabXFXcFF5Z09WQTNmTVdVdHZiWkVnWFN2?=
 =?utf-8?B?aXkrRFNvcDQ2K0ZmQVM5L3EwMDM2bkY4YkRra2hobjZTWDR6VWxNbExJbkw4?=
 =?utf-8?B?OHI0YURSaEtoSlFlcW14cmNzS1VTd3BoYUZHRGhlNnlJUm85bktybGhaL3lR?=
 =?utf-8?B?Mkh5aVNCWTFhKzRLWkViQ2Q1MzN1SXVhaXhZN1FaNTl0czl3dVorZDNuOW1O?=
 =?utf-8?B?dEdDeGE5Y3hvbVliVmovS1M0YW9DWVVJMWhKT1h4MFRrbzZvdXBNblJiYU1R?=
 =?utf-8?B?aWVKTFNKR05ReWJ5ZGh2Q0VndnRMZzJzRDNMR0p4UFkwSkpIdkZQUE1ZeEZ2?=
 =?utf-8?B?Q3JWTVNTRXNCQ2VZUGQzWkN4OUlIK3FpS1JSVG50WHRrWWY4ZklVSUJBSVFM?=
 =?utf-8?B?YzlXdXlvcVh0Skw5TFFFSENLdm5QeGZLV2VBc1ZRZjg4ejlwSmNqZjVMVTNJ?=
 =?utf-8?B?djIreEEyRVVBTzZUQWg3QTdVdmdDb3dmbTNLbHpQbndnaGlOaHg2aEd0Nllv?=
 =?utf-8?B?a1M5U29NNzVNTTFNUjlQRzRtZkp3Um92elBKdGdPamhFUjg1N1kxanJQOXNI?=
 =?utf-8?B?eTAzblBDT05BQlVkcW81MjNOVVpjMml3eWZkcHp5eGRpcVZjcnlXaDZnTXJz?=
 =?utf-8?B?Y3FzVS9oaWZjcVQwRjYzbGtlcEpjTjhVNDArYi9YdWl3YTROdGVKNkkvU2xZ?=
 =?utf-8?B?S2JKdTc1ZGR5SGxvNVljUkRySWZJWkd4VGs3TWVXdTc2NkljOWpDT0IyWjh0?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A312845969074BA6B2097AF86C0801@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb5ad4d-56af-43d0-0d3f-08db4141a0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 01:50:33.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxFFR/lCQ7Mrs7+Ki6TRwesuQ1L/G+ISfs+t9Vn0ViJWCXoBO0uLzSfkKBk1VaXf+0u24r0ZTZZAff/B7WwB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTE5IGF0IDE3OjM5ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBGcm9tOiBBcnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGxpbnV4LmludGVs
LmNvbT4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgQy1zdGF0ZSBmbGFncyBhcmUgY3VycmVudGx5IG11
dHVhbGx5LWV4Y2x1c2l2ZSBhbmQNCj4gc2hvdWxkIG5vdA0KPiBiZSBjb21iaW5lZDoNCj4gICAq
IElSUV9FTkFCTEUNCj4gICAqIElCUlMNCj4gICAqIFhTVEFURQ0KPiANCj4gVGhlcmUgaXMgYSB3
YXJuaW5nIGZvciB0aGUgc2l0dWF0aW9uIHdoZW4gdGhlIElSUV9FTkFCTEUgZmxhZw0KPiBpcyBj
b21iaW5lZCB3aXRoIHRoZSBJQlJTIGZsYWcsIGJ1dCBubyB3YXJuaW5ncyBmb3Igb3RoZXINCj4g
Y29tYmluYXRpb25zLg0KPiBUaGlzIGlzIGluY29uc2lzdGVudCBhbmQgcHJvbmUgdG8gZXJyb3Jz
Lg0KPiANCj4gSW1wcm92ZSB0aGUgc2l0dWF0aW9uIGJ5IGFkZGluZyB3YXJuaW5ncyBmb3IgYWxs
IHRoZSB1bmV4cGVjdGVkDQo+IGNvbWJpbmF0aW9ucy4gQWRkIGEgY291cGxlIG9mIGhlbHBmdWwg
Y29tbWVudGFyaWVzIHRvby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydGVtIEJpdHl1dHNraXkg
PGFydGVtLmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWRs
ZS9pbnRlbF9pZGxlLmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9p
ZGxlLmMNCj4gaW5kZXggNzNkZGIxZDhjZmNmLi4xZGUzNmRmMTVkNWEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxlL2ludGVsX2lk
bGUuYw0KPiBAQCAtMTg5NiwyMCArMTg5NiwyOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQNCj4gaW50
ZWxfaWRsZV9pbml0X2NzdGF0ZXNfaWNwdShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydikNCj4g
IAkJZHJ2LT5zdGF0ZXNbZHJ2LT5zdGF0ZV9jb3VudF0gPQ0KPiBjcHVpZGxlX3N0YXRlX3RhYmxl
W2NzdGF0ZV07DQo+ICAJCXN0YXRlID0gJmRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdOw0K
PiAgDQo+IC0JCWlmICgoc3RhdGUtPmZsYWdzICYgQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpIHx8
DQo+IGZvcmNlX2lycV9vbikgew0KPiAtCQkJcHJfaW5mbygiZm9yY2VkIGludGVsX2lkbGVfaXJx
IGZvciBzdGF0ZSAlZFxuIiwNCj4gY3N0YXRlKTsNCj4gLQkJCXN0YXRlLT5lbnRlciA9IGludGVs
X2lkbGVfaXJxOw0KPiAtCQl9DQo+IC0NCj4gLQkJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2
X0ZFQVRVUkVfS0VSTkVMX0lCUlMpICYmDQo+IC0JCSAgICBzdGF0ZS0+ZmxhZ3MgJiBDUFVJRExF
X0ZMQUdfSUJSUykgew0KPiArCQlpZiAoc3RhdGUtPmZsYWdzICYgQ1BVSURMRV9GTEFHX0lOSVRf
WFNUQVRFKSB7DQo+ICsJCQkvKg0KPiArCQkJICogQ29tYmluaW5nIHdpdGggWFNUQVRFIHdpdGgg
SUJSUyBvcg0KPiBJUlFfRU5BQkxFIGZsYWdzDQo+ICsJCQkgKiBpcyBub3QgY3VycmVudGx5IHN1
cHBvcnRlZCBidXQgdGhpcyBkcml2ZXIuDQo+ICsJCQkgKi8NCj4gKwkJCVdBUk5fT05fT05DRShz
dGF0ZS0+ZmxhZ3MgJiBDUFVJRExFX0ZMQUdfSUJSUyk7DQo+ICsJCQlXQVJOX09OX09OQ0Uoc3Rh
dGUtPmZsYWdzICYNCj4gQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpOw0KPiArCQkJc3RhdGUtPmVu
dGVyID0gaW50ZWxfaWRsZV94c3RhdGU7DQo+ICsJCX0gZWxzZSBpZiAoY3B1X2ZlYXR1cmVfZW5h
YmxlZChYODZfRkVBVFVSRV9LRVJORUxfSUJSUykNCj4gJiYNCj4gKwkJCSAgIHN0YXRlLT5mbGFn
cyAmIENQVUlETEVfRkxBR19JQlJTKSB7DQo+ICsJCQkvKg0KPiArCQkJICogSUJSUyBtaXRpZ2F0
aW9uIHJlcXVpcmVzIHRoYXQgQy1zdGF0ZXMgYXJlDQo+IGVudGVyZWQNCj4gKwkJCSAqIHdpdGgg
aW50ZXJydXB0cyBkaXNhYmxlZC4NCj4gKwkJCSAqLw0KPiAgCQkJV0FSTl9PTl9PTkNFKHN0YXRl
LT5mbGFncyAmDQo+IENQVUlETEVfRkxBR19JUlFfRU5BQkxFKTsNCj4gIAkJCXN0YXRlLT5lbnRl
ciA9IGludGVsX2lkbGVfaWJyczsNCj4gKwkJfSBlbHNlIGlmICgoc3RhdGUtPmZsYWdzICYgQ1BV
SURMRV9GTEFHX0lSUV9FTkFCTEUpIHx8DQo+ICsJCQkgICBmb3JjZV9pcnFfb24pIHsNCj4gKwkJ
CXByX2luZm8oImZvcmNlZCBpbnRlbF9pZGxlX2lycSBmb3Igc3RhdGUgJWRcbiIsDQo+IGNzdGF0
ZSk7DQo+ICsJCQlzdGF0ZS0+ZW50ZXIgPSBpbnRlbF9pZGxlX2lycTsNCj4gIAkJfQ0KDQp3aGF0
IGlzIHRoZSBleHBlY3RlZCBiZWhhdmlvciBmb3IgYSBzdGF0ZSB3aXRoIENQVUlETEVfRkxBR19J
QlJTIG9yDQpDUFVJRExFX0ZMQUdfSU5JVF9YU1RBVEUgc2V0IHdoZW4gdXNpbmcgImZvcmNlX2ly
cV9vbiI/DQoNCnRoZSBDUFVJRExFX0ZMQUdfSUJSUy9DUFVJRExFX0ZMQUdfSU5JVF9YU1RBVEUg
ZmxhZyBhbHdheXMgd2lucywgcmlnaHQ/DQpJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gYWRk
IGEgY29tbWVudCBhYm91dCB0aGlzLCBzYXkgaW4gcGF0Y2ggNi83Lg0KDQp0aGFua3MsDQpydWkN
Cg0KPiAgDQo+IC0JCWlmIChzdGF0ZS0+ZmxhZ3MgJiBDUFVJRExFX0ZMQUdfSU5JVF9YU1RBVEUp
DQo+IC0JCQlzdGF0ZS0+ZW50ZXIgPSBpbnRlbF9pZGxlX3hzdGF0ZTsNCj4gLQ0KPiAgCQlpZiAo
KGRpc2FibGVkX3N0YXRlc19tYXNrICYgQklUKGRydi0+c3RhdGVfY291bnQpKSB8fA0KPiAgCQkg
ICAgKChpY3B1LT51c2VfYWNwaSB8fCBmb3JjZV91c2VfYWNwaSkgJiYNCj4gIAkJICAgICBpbnRl
bF9pZGxlX29mZl9ieV9kZWZhdWx0KG13YWl0X2hpbnQpICYmDQo=
