Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B46E8CA1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjDTIXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDTIXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:23:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4804C26
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978974; x=1713514974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2eY49iAJbEjFg7bNatjkslW39fhpufQCIzyYVsRm4V4=;
  b=gexrdbaPVra2P6skqEkk7GzZQyrT6WsH6lARsotGSyz1wSOaHpHFkCz1
   vEoAkHvVkzvVJcMNTUzxZ3c7CQmoIQprE45629qfCbROVlmmVc53YD0if
   RfXYOMdfjKk6xQCde+zQIWIv5I+XFQLiHwOSrnBeHXDncgYSgPv8AcTcC
   lQD+MzizQPNe0uiA+Oyakt3xShPjz/7D0JR1UH3yXVyFPC4FcDW7g/m4N
   CM3SD+GDiH4x67+egd6v9ZEmTqUz8LAPwE7d/Uih/1selNRqHaeKmOsOr
   i2sNCCQnJRtvqK/SQFa3w0qsbWZJ1sHGjpumvg917RYVo3LTN4OUi5npm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345673489"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="345673489"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="866145082"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="866145082"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2023 01:22:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:22:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:22:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al3nXRtT/M02Zl7l9V1rxlrJYKHsUVPibh+73jf902poIg3dostFAVHUom9hhu4QJgWbI/aQXRsRTrbtMWOz8V2oJjQie4SWFk/Ao4SN3Fqs0fUWpNsJmMCBOabO3sfYnV81SW5xLb5N7LKyYAa3pakl383k2KJ6X71Zho23vwMMNNMmWRNGI2pfwYdI3MqhAgy0w2aTtVcahzud8g0HrM8M+vaA+I5PdOSXM4oZo7dl7ZGQn/bBNKsqaYSvn6+Dr8Y15r67BiN08D8mrEwyc8IBDOTJ9uXBDJ2CAvLr79lQZV1uLz2ukJn6viX2y0VHAPJUlop6YvA+g+GILvjoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eY49iAJbEjFg7bNatjkslW39fhpufQCIzyYVsRm4V4=;
 b=JmNiEgvb4gHjwWOV/PUXHfVRQrOrjlz8QTfPiDLwesrCBhduJ5O/a5fGgKeKqtF8zG35+XyvdtBLI8YS3Ju5O2XP0w32LSqjhaQYyE5xe/a86wwz/trIAAwjrZmw82yNItSRRiT7ZNL5HzuK57Exi+DGwYUjRKFKq8xlSnPQQbQwVhqP90+kpbHVHkZSqmY6g2zcND6/rieHVVNz6GhsM1ZgNSCVRbNLmcgHDkZ/YiVi9NZ0lLfxJJqBH/c+PFP6D3U66IIM3iMgAzuvdjB41BtK632Hh0sVJAT27zS/pEUVwRKxO/i+/DH+yKSIaLZpolRjCH1YV2jUsETxsPoesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com (2603:10b6:a03:3ef::16)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:22:51 +0000
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da]) by SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da%6]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 08:22:51 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/7] intel_idle: improve C-state flags handling robustness
Thread-Topic: [PATCH 4/7] intel_idle: improve C-state flags handling
 robustness
Thread-Index: AQHZcs0F3GR0n+VkNUuocKN2VRMMzK8z3PwA
Date:   Thu, 20 Apr 2023 08:22:51 +0000
Message-ID: <b1c8217552e4a6aa6cb83fef1e8bb9d0bc9c2791.camel@intel.com>
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
x-ms-traffictypediagnostic: SJ0SPRMB0033:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: 69b3fabd-840a-43c3-9138-08db41786ef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qH2DtLDHbt+oq38uOJkkYniU/b1eHlZk+rlubXcnzgsFfFIeSsgaTGiUrXUIllNQ8wgRIV54HPKf8SVLDqpCcPeh58vC4F2wqyWs6NJ0JK/3DPO93ajDavy4U4zwOYdk4nItilPVQqrsZu9enNV7VHljpPWBpw2+5h44bhsNmZOVgwlVcEKA1+p9iAJyKq7xjsNxLqD9pI+cajn20lz3/9bfHiONtEQ1+/FSXwzb0OOVHuq3xfThb7gDk9iv5kKV9+gQ71s0/UuDF9aybGGWTe6aUYtfIIVfyMAhPlxjBYkdJ4zvPxCoaAetfBGXOaxLGBDQA/8Ld7QcdQHCTEBXfU5dC4z/9wUTWWMLRFhzGKBmCz6oUAi0NQD1Osj9DVjXgUDao/drqg4AXDIZTJK+NwmaMHzPG/sxkUc42P7x5r90u75iRnSEdvQDS7xOX7scZ3QpGqkfwRRMw0rgelo72kKJFYGCNSx33aQRWSaATUnULOLrFUKUF+gGZi3auEJsNiY5he8tu6QoF06SwT8QEXaqEUvvNGg/QYNY4mivbTKdUPpARVXRNwuQhezbqg3Wh+1O1kL+BGKXxM8H6vcZAo30wE5I1Sde4o+EyKE7OSegwKKj21tyXKf3y7zP9ecJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(36756003)(186003)(26005)(6506007)(82960400001)(38100700002)(122000001)(6512007)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(71200400001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzhwUEpjYVo1bExBazVDeHY1djFSZGJmZ1RKTTlmcVl5RldLVHo2NWljQVZO?=
 =?utf-8?B?L0xnejZDd1FlTTdrVzEvejVZZG03NXkvdzNobm5kSWI4d0NxQXhia3R6cDNB?=
 =?utf-8?B?STBZV3BpNmQzcEx4c09lZ1N6TWtxWjQ5b0UwUzdWZ1ZEYUhWNFFIVko3b0h5?=
 =?utf-8?B?dkVlMkF6TUtnc2JQVmpsY1NFVkpGbTQvS1RJZGVuR0xFd0dYRnQ4ZHFzaVJ5?=
 =?utf-8?B?Mlp1MXFFQTF0ZmVFamJCamhEaHlzaTM0Vk5zc3ZOYm5xSFRuNllYYm9udVRK?=
 =?utf-8?B?T05RZVg2RTRvMXhEMkpHeTBMMHpEdWk2YnBtRTcxV2xMbktvYlU5a2srUVBL?=
 =?utf-8?B?WDFVMFVrNTljbmRjYnRjVWdralVlOTJtY0I1WEZtSnlEUWE0Y0xGZTlKcHhL?=
 =?utf-8?B?Zi83OE1xY01ya3N0cFYvUytWZlMrRVJPb0kyNUlPeG5VNVRtNlE2UUpxdGNU?=
 =?utf-8?B?d1JlNStOdFVGbXhWZjE0K2kyUWR4YmZtU3Z3eGVsMElyYWR2d0FtOVZMS2VW?=
 =?utf-8?B?MituZzhOamx2a1FmTHhIYUZrTERLSkZmQU9obm5pWmNnYThZVEM3aU9HdTRW?=
 =?utf-8?B?T3JkRDJQVDZjS25lUFlmdnc4blFhdDJPaUg4R3QySm5MaVFsODNCaENIV2ZH?=
 =?utf-8?B?dEFiMkxmY3h4YUUzcWE0eHdLWnFpQUN6RTJESHR4bjhWZDNNRVhtalBCTmVm?=
 =?utf-8?B?QUZhcmNZZFRHODhKalI1OENJU1BoQmsrM3owT3VNaHdGSzZxNUppOTFpSGtE?=
 =?utf-8?B?dldsQ0NveUtZZXdWRGF3dXlma3pVZXBiVklCbnJQWDRXRkxsNUlSU1BYdWY5?=
 =?utf-8?B?bTFpVEY3WWhxNC9wU2VwZzZML25xZGg0aEF1SEp2WTE2a1E1T2syK0tuUmZR?=
 =?utf-8?B?Z2ZnWFI5dkFsdmJDVzdyZE82RDJ6OWdxNkJYMkowb1YvZldwM3RGWFJEZ3RB?=
 =?utf-8?B?QXgzVDhXMW4xU2ZDY21mUDM1aEJ4azJxd2RHdWNaS1BMN2dEdld6M2hPU0Mx?=
 =?utf-8?B?clZORlNIYUtGQWk2cWF4dTFmd2pnRlU2bXdZMGpsRDFFeWl6L2Jua1psMXlq?=
 =?utf-8?B?b0NiZmppa0RPSjl2cW9wQTU4T00wekZFUXVkRXpWTy9PanlOVGQ1YndLSTFP?=
 =?utf-8?B?dWZtb2V4bkpkdFVPTzdCTGtSVVJMWjVwejlyK0QxVyt5QndwREVkdjIwZjlM?=
 =?utf-8?B?QUowUmxSc2l0amxvQmxaT1pySGpFRjBKZXRMYVdycXZyYksyaVY5S0todTA2?=
 =?utf-8?B?VGJCRUJNUGFFcUNBRzQxSDZ0dElHWmJUWHAzNEU3aDZyOUV5V2lYQjBROUlM?=
 =?utf-8?B?bFJkWGtqQ0JEek5iMlpVQ3dUbFBBak0xenpSclcwYnFGZC9ycCttZGVlWk5y?=
 =?utf-8?B?NndrSWJjRDI2WFl2K1o2VXovNy9oaHJEMHRVSXI3Nm5iN1Q4Tllqdnl1TU51?=
 =?utf-8?B?RXVKU0o3UXdxeWMzTkJ2RHdUeEpicE9HNWoxVWFaUHV6ZFRCcUJOL3o3c0FN?=
 =?utf-8?B?MGRmeENnQk5oOXRRVDdmOEp3d0NMcWJmTHNUZVEzVk1KdVBORnN2NnNIeHJk?=
 =?utf-8?B?dnBaMTJ4Q2h4ZHQ2S0RjdHMvUVdRWlNOdUN1Yk8vR0I2RHhLVGZVSWJraVha?=
 =?utf-8?B?dDlSRTEySko4NDNQbGFOMm8wTlBMTGVLSGtJcjRsdDI1Nyt0MU5PcWVMWEMx?=
 =?utf-8?B?cWx2VHJxSUo5S2sxTjdUVTFMRjYvQWNQTDlGYjI5MnVlR1NTeEhXa29jMFpU?=
 =?utf-8?B?VzR1c08rb0pLVmwyV1VBa25ESEN6T1NTaUFPL2JHbGNGTlZnN2l5bkt1M0RI?=
 =?utf-8?B?eDJIcWkvY0Fyb3JpcHY3WmtJUVZOSFU3Y3V3NkNIL1hsZzBHMEFZU1hRb2g5?=
 =?utf-8?B?Mi95ZXZUNVRRaSsvN1R6VDFCdlMvWWVNS3U3bldNTnFrK01STEZrc1dWeVAy?=
 =?utf-8?B?dkZ6bG9Jdlo1S2Yxck55N0xTcWJuNFlMT1NGUjVVOUwwYnphdmRQL0lyOENj?=
 =?utf-8?B?cnB6Nmlkc3kwWjlYOVV3azkrbWxoSlRlZGhKSXVhaEpUM2cyTnd3RU5hNlpS?=
 =?utf-8?B?a2VUZWpwdVJIeG14cThUcEVGYWxoN1VBWkFoQUd5RVFrMDgwT0RLVTRFZVBE?=
 =?utf-8?Q?VLd4AdjmZ8F/kFmWNM8hxu23x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA9C37F5C84E740A5247BFDD4E29402@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b3fabd-840a-43c3-9138-08db41786ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:22:51.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/i82EeduN0hiilDRUWJjPuDu8ssXAVSc6xs3zexm2gK+0ezt22B1IMmjeCKYZg4JdXj4QjLsSh2YqYWPDuXdQ==
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
LmNvbT4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgQy1zdGF0ZSBmbGFncyBhcmUgY3VycmVudGx5IG11
dHVhbGx5LWV4Y2x1c2l2ZSBhbmQNCj4gc2hvdWxkIG5vdA0KPiBiZSBjb21iaW5lZDoNCj4gICAq
IElSUV9FTkFCTEUNCj4gICAqIElCUlMNCj4gICAqIFhTVEFURQ0KPiANCj4gVGhlcmUgaXMgYSB3
YXJuaW5nIGZvciB0aGUgc2l0dWF0aW9uIHdoZW4gdGhlIElSUV9FTkFCTEUgZmxhZw0KPiBpcyBj
b21iaW5lZCB3aXRoIHRoZSBJQlJTIGZsYWcsIGJ1dCBubyB3YXJuaW5ncyBmb3Igb3RoZXINCj4g
Y29tYmluYXRpb25zLg0KPiBUaGlzIGlzIGluY29uc2lzdGVudCBhbmQgcHJvbmUgdG8gZXJyb3Jz
Lg0KPiANCj4gSW1wcm92ZSB0aGUgc2l0dWF0aW9uIGJ5IGFkZGluZyB3YXJuaW5ncyBmb3IgYWxs
IHRoZSB1bmV4cGVjdGVkDQo+IGNvbWJpbmF0aW9ucy4gQWRkIGEgY291cGxlIG9mIGhlbHBmdWwg
Y29tbWVudGFyaWVzIHRvby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydGVtIEJpdHl1dHNraXkg
PGFydGVtLmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhhbmcg
UnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCg0KPiAtLS0NCj4gIGRy
aXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRs
ZS9pbnRlbF9pZGxlLmMNCj4gaW5kZXggNzNkZGIxZDhjZmNmLi4xZGUzNmRmMTVkNWEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxl
L2ludGVsX2lkbGUuYw0KPiBAQCAtMTg5NiwyMCArMTg5NiwyOCBAQCBzdGF0aWMgdm9pZCBfX2lu
aXQNCj4gaW50ZWxfaWRsZV9pbml0X2NzdGF0ZXNfaWNwdShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIg
KmRydikNCj4gIAkJZHJ2LT5zdGF0ZXNbZHJ2LT5zdGF0ZV9jb3VudF0gPQ0KPiBjcHVpZGxlX3N0
YXRlX3RhYmxlW2NzdGF0ZV07DQo+ICAJCXN0YXRlID0gJmRydi0+c3RhdGVzW2Rydi0+c3RhdGVf
Y291bnRdOw0KPiAgDQo+IC0JCWlmICgoc3RhdGUtPmZsYWdzICYgQ1BVSURMRV9GTEFHX0lSUV9F
TkFCTEUpIHx8DQo+IGZvcmNlX2lycV9vbikgew0KPiAtCQkJcHJfaW5mbygiZm9yY2VkIGludGVs
X2lkbGVfaXJxIGZvciBzdGF0ZSAlZFxuIiwNCj4gY3N0YXRlKTsNCj4gLQkJCXN0YXRlLT5lbnRl
ciA9IGludGVsX2lkbGVfaXJxOw0KPiAtCQl9DQo+IC0NCj4gLQkJaWYgKGNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfS0VSTkVMX0lCUlMpICYmDQo+IC0JCSAgICBzdGF0ZS0+ZmxhZ3Mg
JiBDUFVJRExFX0ZMQUdfSUJSUykgew0KPiArCQlpZiAoc3RhdGUtPmZsYWdzICYgQ1BVSURMRV9G
TEFHX0lOSVRfWFNUQVRFKSB7DQo+ICsJCQkvKg0KPiArCQkJICogQ29tYmluaW5nIHdpdGggWFNU
QVRFIHdpdGggSUJSUyBvcg0KPiBJUlFfRU5BQkxFIGZsYWdzDQo+ICsJCQkgKiBpcyBub3QgY3Vy
cmVudGx5IHN1cHBvcnRlZCBidXQgdGhpcyBkcml2ZXIuDQo+ICsJCQkgKi8NCj4gKwkJCVdBUk5f
T05fT05DRShzdGF0ZS0+ZmxhZ3MgJiBDUFVJRExFX0ZMQUdfSUJSUyk7DQo+ICsJCQlXQVJOX09O
X09OQ0Uoc3RhdGUtPmZsYWdzICYNCj4gQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpOw0KPiArCQkJ
c3RhdGUtPmVudGVyID0gaW50ZWxfaWRsZV94c3RhdGU7DQo+ICsJCX0gZWxzZSBpZiAoY3B1X2Zl
YXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9LRVJORUxfSUJSUykNCj4gJiYNCj4gKwkJCSAgIHN0
YXRlLT5mbGFncyAmIENQVUlETEVfRkxBR19JQlJTKSB7DQo+ICsJCQkvKg0KPiArCQkJICogSUJS
UyBtaXRpZ2F0aW9uIHJlcXVpcmVzIHRoYXQgQy1zdGF0ZXMgYXJlDQo+IGVudGVyZWQNCj4gKwkJ
CSAqIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZC4NCj4gKwkJCSAqLw0KPiAgCQkJV0FSTl9PTl9P
TkNFKHN0YXRlLT5mbGFncyAmDQo+IENQVUlETEVfRkxBR19JUlFfRU5BQkxFKTsNCj4gIAkJCXN0
YXRlLT5lbnRlciA9IGludGVsX2lkbGVfaWJyczsNCj4gKwkJfSBlbHNlIGlmICgoc3RhdGUtPmZs
YWdzICYgQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpIHx8DQo+ICsJCQkgICBmb3JjZV9pcnFfb24p
IHsNCj4gKwkJCXByX2luZm8oImZvcmNlZCBpbnRlbF9pZGxlX2lycSBmb3Igc3RhdGUgJWRcbiIs
DQo+IGNzdGF0ZSk7DQo+ICsJCQlzdGF0ZS0+ZW50ZXIgPSBpbnRlbF9pZGxlX2lycTsNCj4gIAkJ
fQ0KPiAgDQo+IC0JCWlmIChzdGF0ZS0+ZmxhZ3MgJiBDUFVJRExFX0ZMQUdfSU5JVF9YU1RBVEUp
DQo+IC0JCQlzdGF0ZS0+ZW50ZXIgPSBpbnRlbF9pZGxlX3hzdGF0ZTsNCj4gLQ0KPiAgCQlpZiAo
KGRpc2FibGVkX3N0YXRlc19tYXNrICYgQklUKGRydi0+c3RhdGVfY291bnQpKSB8fA0KPiAgCQkg
ICAgKChpY3B1LT51c2VfYWNwaSB8fCBmb3JjZV91c2VfYWNwaSkgJiYNCj4gIAkJICAgICBpbnRl
bF9pZGxlX29mZl9ieV9kZWZhdWx0KG13YWl0X2hpbnQpICYmDQo=
