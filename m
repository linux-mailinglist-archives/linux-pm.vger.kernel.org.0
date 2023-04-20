Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBF6E8C9D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjDTIXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjDTIWz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:22:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECFB4C1B
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978964; x=1713514964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o6pkJJIHyLMOYd8yaeMd2uyVgagcbPQsHOciGi8jLs0=;
  b=DsAHluYmO4JfpfkUdTmro+wqF75Lv6KS9ElqGW+swfiD9GDjMbG0bgT2
   N1DWXs3UwijHPfaUJchiWaGfjSAVyV0FPQsa3wsW3FNOqVftyeqv/6ntZ
   AFXWabSxt3QJeXA+TxOPzsRq9F0Et7j6b+J6a2ZefB4BCO+Ratvu0JwqV
   AT0fs9qKXxF0PSm4GtThxAbhDAq4xxds/SKwNLDWHN3qjROEsc1B5qhbN
   AvLi/VBpw10rdNU4V9LAeig+Xh4N63igm9L5s1eayDbe3UyTrwykDgfD5
   giVfPWS1G0nlTw49j1CZCz4lbuCk4HdwKkYkJDSgXF+DYPj0a2U8OSeSl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345673437"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="345673437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="724344365"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="724344365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2023 01:22:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:22:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:22:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W93tu5KT11H+eB4wOn9D9HlPgYZdzjxRckDifIMfwRjhKZqyQs2PZyjN9MfDyr0AHRdj4lA5mPsq2Uz64QPIH1g5YNtv5jIVSoY/7cShRHbxMvg+5W+O/eqSBQ7QkVnzE7UYFs+8gWWRTanoghL0T39g8TTjbjFIcbTZRIWrGwQWXUExgCQopaYAhgDM9l9H9ctiELa0p3kEFLRlGiuDZvRSsaMtRb8sRiBIA9lEHjXzWilaKYh1IKNaqq9vT1I5to8GZ3DDH2FB9ZetgnI+oTZUc45WhVR8KD5hwbwNRwqfp09nqhZjiKLV0pPU77KuXnoObLa4JujctpBCUi+KgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6pkJJIHyLMOYd8yaeMd2uyVgagcbPQsHOciGi8jLs0=;
 b=AJVWm8VfnuH7lXFmOd8kBFoEt1kP3XQ7JxQf6N5rdgyWfpjUKFxpJ6PI6lRQyATU7zPpqw+4yGFoQQzVZlyuK93Tm9mityxOSBL8lKgeDSx7p9znfjSE2OX9Se2DLHBDlxDkW+kF+FJIVbtigAr4LVeZOABL15LeDoCnJHtaxeJOhL/HsbC+fnSafPF7BZY4hkZYqb3eTcZ7QeiNeypxx1wTC5rIXqQFcEAllGlKXGK0JLkXQU/FD494WWBAbfKSPThU/p7+10QK92fc6soiOemOEfG57ddmA3TgSav3T/TzOfmOIISAJobdyz7HDKAbQm/yXk8ERh3EV5Wlq0wH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com (2603:10b6:a03:3ef::16)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:22:41 +0000
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da]) by SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da%6]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 08:22:41 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/7] intel_idle: further 'intel_idle_init_cstates_icpu()'
 cleanup
Thread-Topic: [PATCH 3/7] intel_idle: further 'intel_idle_init_cstates_icpu()'
 cleanup
Thread-Index: AQHZcs0EITcs5ciTlE+cdib0sFR4Xq8z3PEA
Date:   Thu, 20 Apr 2023 08:22:41 +0000
Message-ID: <72a22649b8c9489fc3fe27a9ac100e99b15a7530.camel@intel.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
         <20230419143947.1342730-4-dedekind1@gmail.com>
In-Reply-To: <20230419143947.1342730-4-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0033:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: c603875e-5e04-44a0-fc60-08db417868fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDpZht0tAM+rxTHGNVZt/Lbk7nhsO3Qc0djVoMD2dFuUdXp8x0t/0FViLP5m08zL/P7uhixeh/fK5JCYz+3Lktf+rgjn0WsffE7ekj4z2YL8kO54Y8S++dVesRtDQnIi7svr5LvrC52FdDCJoRPa/0xrxnowN4pyorfyA2+zcgwatX5HkQgY5vsM8uSAmOVnUZ3aTsf7cCB6G0B++AlPKsiRWABOFwMl9XJnR0L22n4gZT3pMdEnpTZOyIHwtibp0am3AZDF7jv9KwKYTRX1rCAtutZuejUmrji1lJ2pFXl9g/E85ZCYOv9S+9LRw+qNVw7v1hcI6udh25g7sBjrN3ymTFMevfRQsDh6xY+zeRHF7qbyyu/jhEEqLGU8Aq2totTskwOegEAnN65iFfKFL0yAAXpL9mnop6WH8+g9qOMzPhAwZt7SgyKTvU54vnkTI/OLtOu9exZ/85shNhJJr5l6oxb+eulFDrwAFGfrAfO8EVbYx10g+RtFmBK8bLk8p0K/1xfyqiAThDWBcAnd9/FXCyIAVhpnMwn3EqV2rdgTClxCeubTx0rnw0Wlh+lejuKTpeq1nwiZZQIWqzSkZBHere5Y1ULMocD0D8NjstK7RPJ2GQAwM2s76mJIe+US
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(36756003)(186003)(26005)(6506007)(82960400001)(38100700002)(122000001)(6512007)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(71200400001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS8xYktWMGU3aDUwc2lEb3BraE1GNXJ0aTViRjA3aFcrcGVzR3hvVHVxWXF5?=
 =?utf-8?B?dVdJdHhCSEswc3FtUnhMVUw2eDZldGhVUWIzcGltWVp4N0p6YmpYMFEyQXM3?=
 =?utf-8?B?SS9zOGRHR0ZDUWgvRVRTLzlDbE5meVRMWXpLVXVMN1VVN0FJazNyN3Zxb1FO?=
 =?utf-8?B?aEswOFZEREcxZi9jTnhZS1E4ZE9XYm9ZdW4zZ2loV1dVakt0Q3RhTEZ1SmI3?=
 =?utf-8?B?VS9valJjanBGaStHa3V3dExiV0d3SG5ZWXNtWWZZTEtaOStuZVBkTVllZDVC?=
 =?utf-8?B?WG5EeTdVeWtDMk5nMW5nSnBwMDhIbGRtSzJWTkhiZG02WDJmSCtVdSsrU3dS?=
 =?utf-8?B?RWNYdkFhczFWMzRtR01xMzlxZVUwQ2tTQUdLbGdvUmZJMUpWUXN4ZWwyR1FL?=
 =?utf-8?B?NEJEK0JFYzZFSGhVcTBEUXhrTWlqREM4NWNwWjZTZXhXMkdMMVJhNUhlbzVo?=
 =?utf-8?B?UFNjaUc3MDRrbjBvNTdkSnFNNFpZOVNjS2g0QmlWbCtQNnJCRjZFUUw2VGRI?=
 =?utf-8?B?dmJtOEJ0cmJxL0lqRHYyTWFhUkU5dU9rU3cxSFFRQ0NLdkcyV0tsNzREemtR?=
 =?utf-8?B?eFlMaXJ1STZPVUFtZ2hRRk5ZNG5aWitiVGxDeit0dUc3Z2pkc0szYmdjMWxW?=
 =?utf-8?B?REJJNHR2L2RXVlNFc2dVRUgvNHJFYlZhVXRibTFmcittZGNxRWhGMG1QeEto?=
 =?utf-8?B?REZzV0g4YmZGMlI4WjcvT3dmMVBTbXhBUVRMNFBBRkVoajFpV1UySEVBRllr?=
 =?utf-8?B?ZnM5VlpjR2Z6TzRIWjMvU3kxU2kzMFp3TldmclVsZmpoQkNuaFpVSkllSFJ6?=
 =?utf-8?B?R0FjaFFuTnhTb2duMDh0UjR1L0srQWcrc0d5MStLN0dQemJpWmdaeUVWZGdV?=
 =?utf-8?B?b29mVzhwNEI2aWs0dW9nRGx1RURUS2ZkWmdPSWpuSGdRVWdDS0J4RXdGTVcz?=
 =?utf-8?B?d25zQTlWUGZibVFrOVA0RnBxRGZOd3k5TnM4QXloU0FVTzg3dTF3N0Z1T3h3?=
 =?utf-8?B?VEdoZ21xVGtUemkxT1JIRktxSGlSN2ttTnVZVTZXMHJLVlU3NjlURlQ5YlF6?=
 =?utf-8?B?bUVhWkFacU1wb1pzNmN0M243eW1lckRaR3BhaCtxaGZZYkUxdEZxcEFwOFVI?=
 =?utf-8?B?VzU3VFlockJqQ0dYdGYyQkZLVmRxc2xFdTIzN0U4U2FXalFheHJvWFppRHFM?=
 =?utf-8?B?Nit1anViUDhkUHlnZ3N5MGMxVzY2NnN3SmZGYzdvdVpseWdZRHdGdklYT1Np?=
 =?utf-8?B?eFUxbThWUjlkNVg5ZUpqaTFKZXRwUU16T2NCSm94ZnJaQ0RETDd2OG9jMXNp?=
 =?utf-8?B?SGtNNzVMaU9vbk5NZ0NldGNrY3M1ZFUrOUNLYmhIMVJLZXB6NmxhR0VXcUFr?=
 =?utf-8?B?clJ5L2IxbENrTWFCUEZuWDN6Vi92WUNvUkNXelQyT0xqV3p3S2pOZy9wbDNi?=
 =?utf-8?B?R3F3TWJ4U3pFQlZ1VjNGZUw3dGpmckRkY1JoTndFTVFqS1Nxa0pPakRiNDZ1?=
 =?utf-8?B?QWJxRzNuTlRESzRYMG42K1FZQzRVa01XSVV1YmJyYnhFempCZzlkZGE4L2xU?=
 =?utf-8?B?NWwyWVJyYUFQem95QS9NbEo3ODRnU3VJdk1YbTdOZlprWlhBb2hWRlVIdmlZ?=
 =?utf-8?B?bTBQRFMvN3dKT3hmbmJaTTRMdXpUUzM0M3BNM0VZTHUyWWY2Q0lUNjdkaytw?=
 =?utf-8?B?TnBubkJkVUNSUTVjcUJZY1Q2ek5PYjJpTUpKTHREY01oYS9JVFl2dHFRUGoz?=
 =?utf-8?B?QXA2eWVFUVIvcEoxT1JheVQzaW5nOGx6ZENtK0s5L1diRkFlU2hYRHh3Qjhu?=
 =?utf-8?B?OENWMWpJRHNVM2hkUDRvNmhZWlpyT0VZenVUekh2RW5XRnlORFZWSWNEL2xq?=
 =?utf-8?B?Zzcva1Y2bFJuSjNPb1dnVWF3NkhKVHJiMG03SjhaWmdKWVJyanNlKzNGVVlS?=
 =?utf-8?B?MWZwWVJuamM3SUtJakJlck5IM1E1WlBFWGIwbS9MZ00vbHRDS2Z5Zk9BaGFU?=
 =?utf-8?B?NDNoL0lSRmNYOXZVOEg5NUhSSGwzS1dEOEs2MmpMZzFTazBZNFBycGFKaGtG?=
 =?utf-8?B?YmkrSnBlbDhRZGk1Qm1WOS90YVhxQXJqaDB2dUc2dUVyVU1lQ3FycnJBOUhE?=
 =?utf-8?Q?E0bIjmLscOzbTsB8imlaSkgc8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E22BE9245D27DF459640039567AACBA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c603875e-5e04-44a0-fc60-08db417868fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:22:41.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVI6FI2zWaADdktzclA4wkpONzw0hfkenprpYEPk3RHIQldN75NPbQyvV+ez38yYPMaW1f32jOoncAlHjLivEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
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
LmNvbT4NCj4gDQo+IEludHJvZHVjZSBhIHRlbXBvcmFyeSAnc3RhdGUnIHZhcmlhYmxlIGZvciBy
ZWZlcmVuY2luZyB0aGUgY3VycmVudGx5DQo+IHByb2Nlc3NlZCBDLXN0YXRlIGluIHRoZSAnaW50
ZWxfaWRsZV9pbml0X2NzdGF0ZXNfaWNwdSgpJyBmdW5jdGlvbi4NCj4gDQo+IFRoaXMgbWFrZXMg
Y29kZSBsaW5lcyBzaG9ydGVyIGFuZCBlYXNpZXIgdG8gcmVhZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFydGVtIEJpdHl1dHNraXkgPGFydGVtLmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPg0K
DQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3Ms
DQpydWkNCj4gLS0tDQo+ICBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgMjQgKysrKysrKysr
KysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUu
YyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gaW5kZXggMTkwNDEwZmM5Y2U1Li43M2Rk
YjFkOGNmY2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysr
IGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KPiBAQCAtMTg3MSw2ICsxODcxLDcgQEAgc3Rh
dGljIHZvaWQgX19pbml0DQo+IGludGVsX2lkbGVfaW5pdF9jc3RhdGVzX2ljcHUoc3RydWN0IGNw
dWlkbGVfZHJpdmVyICpkcnYpDQo+ICAJfQ0KPiAgDQo+ICAJZm9yIChjc3RhdGUgPSAwOyBjc3Rh
dGUgPCBDUFVJRExFX1NUQVRFX01BWDsgKytjc3RhdGUpIHsNCj4gKwkJc3RydWN0IGNwdWlkbGVf
c3RhdGUgKnN0YXRlOw0KPiAgCQl1bnNpZ25lZCBpbnQgbXdhaXRfaGludDsNCj4gIA0KPiAgCQlp
ZiAoaW50ZWxfaWRsZV9tYXhfY3N0YXRlX3JlYWNoZWQoY3N0YXRlKSkNCj4gQEAgLTE4OTMsMjkg
KzE4OTQsMzAgQEAgc3RhdGljIHZvaWQgX19pbml0DQo+IGludGVsX2lkbGVfaW5pdF9jc3RhdGVz
X2ljcHUoc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYpDQo+ICANCj4gIAkJLyogU3RydWN0dXJl
IGNvcHkuICovDQo+ICAJCWRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdID0NCj4gY3B1aWRs
ZV9zdGF0ZV90YWJsZVtjc3RhdGVdOw0KPiArCQlzdGF0ZSA9ICZkcnYtPnN0YXRlc1tkcnYtPnN0
YXRlX2NvdW50XTsNCj4gIA0KPiAtCQlpZiAoKGRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRd
LmZsYWdzICYNCj4gQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpIHx8IGZvcmNlX2lycV9vbikgew0K
PiArCQlpZiAoKHN0YXRlLT5mbGFncyAmIENQVUlETEVfRkxBR19JUlFfRU5BQkxFKSB8fA0KPiBm
b3JjZV9pcnFfb24pIHsNCj4gIAkJCXByX2luZm8oImZvcmNlZCBpbnRlbF9pZGxlX2lycSBmb3Ig
c3RhdGUgJWRcbiIsDQo+IGNzdGF0ZSk7DQo+IC0JCQlkcnYtPnN0YXRlc1tkcnYtPnN0YXRlX2Nv
dW50XS5lbnRlciA9DQo+IGludGVsX2lkbGVfaXJxOw0KPiArCQkJc3RhdGUtPmVudGVyID0gaW50
ZWxfaWRsZV9pcnE7DQo+ICAJCX0NCj4gIA0KPiAgCQlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9LRVJORUxfSUJSUykgJiYNCj4gLQkJICAgIGRydi0+c3RhdGVzW2Rydi0+c3Rh
dGVfY291bnRdLmZsYWdzICYNCj4gQ1BVSURMRV9GTEFHX0lCUlMpIHsNCj4gLQkJCVdBUk5fT05f
T05DRShkcnYtPnN0YXRlc1tkcnYtDQo+ID5zdGF0ZV9jb3VudF0uZmxhZ3MgJiBDUFVJRExFX0ZM
QUdfSVJRX0VOQUJMRSk7DQo+IC0JCQlkcnYtPnN0YXRlc1tkcnYtPnN0YXRlX2NvdW50XS5lbnRl
ciA9DQo+IGludGVsX2lkbGVfaWJyczsNCj4gKwkJICAgIHN0YXRlLT5mbGFncyAmIENQVUlETEVf
RkxBR19JQlJTKSB7DQo+ICsJCQlXQVJOX09OX09OQ0Uoc3RhdGUtPmZsYWdzICYNCj4gQ1BVSURM
RV9GTEFHX0lSUV9FTkFCTEUpOw0KPiArCQkJc3RhdGUtPmVudGVyID0gaW50ZWxfaWRsZV9pYnJz
Ow0KPiAgCQl9DQo+ICANCj4gLQkJaWYgKGRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdLmZs
YWdzICYNCj4gQ1BVSURMRV9GTEFHX0lOSVRfWFNUQVRFKQ0KPiAtCQkJZHJ2LT5zdGF0ZXNbZHJ2
LT5zdGF0ZV9jb3VudF0uZW50ZXIgPQ0KPiBpbnRlbF9pZGxlX3hzdGF0ZTsNCj4gKwkJaWYgKHN0
YXRlLT5mbGFncyAmIENQVUlETEVfRkxBR19JTklUX1hTVEFURSkNCj4gKwkJCXN0YXRlLT5lbnRl
ciA9IGludGVsX2lkbGVfeHN0YXRlOw0KPiAgDQo+ICAJCWlmICgoZGlzYWJsZWRfc3RhdGVzX21h
c2sgJiBCSVQoZHJ2LT5zdGF0ZV9jb3VudCkpIHx8DQo+ICAJCSAgICAoKGljcHUtPnVzZV9hY3Bp
IHx8IGZvcmNlX3VzZV9hY3BpKSAmJg0KPiAgCQkgICAgIGludGVsX2lkbGVfb2ZmX2J5X2RlZmF1
bHQobXdhaXRfaGludCkgJiYNCj4gLQkJICAgICAhKGRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291
bnRdLmZsYWdzICYNCj4gQ1BVSURMRV9GTEFHX0FMV0FZU19FTkFCTEUpKSkNCj4gLQkJCWRydi0+
c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdLmZsYWdzIHw9DQo+IENQVUlETEVfRkxBR19PRkY7DQo+
ICsJCSAgICAgIShzdGF0ZS0+ZmxhZ3MgJiBDUFVJRExFX0ZMQUdfQUxXQVlTX0VOQUJMRSkpKQ0K
PiArCQkJc3RhdGUtPmZsYWdzIHw9IENQVUlETEVfRkxBR19PRkY7DQo+ICANCj4gLQkJaWYgKGlu
dGVsX2lkbGVfc3RhdGVfbmVlZHNfdGltZXJfc3RvcCgmZHJ2LT5zdGF0ZXNbZHJ2LQ0KPiA+c3Rh
dGVfY291bnRdKSkNCj4gLQkJCWRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdLmZsYWdzIHw9
DQo+IENQVUlETEVfRkxBR19USU1FUl9TVE9QOw0KPiArCQlpZiAoaW50ZWxfaWRsZV9zdGF0ZV9u
ZWVkc190aW1lcl9zdG9wKHN0YXRlKSkNCj4gKwkJCXN0YXRlLT5mbGFncyB8PSBDUFVJRExFX0ZM
QUdfVElNRVJfU1RPUDsNCj4gIA0KPiAgCQlkcnYtPnN0YXRlX2NvdW50Kys7DQo+ICAJfQ0K
