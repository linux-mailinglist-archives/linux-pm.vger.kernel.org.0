Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D76E8779
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDTB2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 21:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDTB2w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 21:28:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654D55AB
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681954131; x=1713490131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E41gjSzJ6/eoOviJcnWFd8qBv7xnTAZYR1x09ZnDOPQ=;
  b=BmNosbFLQSUxCM7x/MU7JZlsBiWGxM00xZXc4FPOPH6suZsjEtAAczLv
   3vI48O03fPtld4YONNvojh3BFVKi95avLP0EJqhVOs/qibx32mV6i4fVe
   DIuwpfEktG3M8r/yENOoS+xyFsn/TvWlcrLhvCQpgnfEp3y3Q6uHs2lZ4
   cZiLfPeTTKVlACfWAr9F8mmEhb6gxv8RP12zoszBOKF2T4sl9GHPrOvSJ
   ugpqrn3GzctjX5k8QJXZp/EkkvUwvNRjpzRbMQK6XSMkMYb1He4AWHvWe
   5Md409RkUODOsX/RIWO2ZJ9pVHu+560tLiitxyC3CKmgWDm2Wsv86VazV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343084245"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="343084245"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="866044671"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="866044671"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2023 18:28:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 18:28:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 18:28:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 18:28:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 18:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrkkeRsQYKnhFENKN5zSuK5KpPy+yqKOUsLWdCXk0NdgKiQsX6YdKVQEX2ktmA9ksKDKwU7uTXjcgjFeAG7hMGV+dLaaNto5Tb249/w+3Q1O1I5dfMYP7BlXceLEm16LWkoQNxRoz6+HEr5pI6J19YkSgqw9kUpaigJtmkTgbJFAfR1JVjJXQcgyu1sCjgXUWRX3071WHgKshQvcyOvhZtUkqRGANGEAsiWEWD7XZf27rEOh2Av+75LNiXUjFw1lFWioxFXz8J4TfLF1z38HhOSBGH0qjifWNZzdUwZ1jBPNxyYP/PavwJG1nThs6SBwjzSWf9r6rK1Sv3oes9st2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E41gjSzJ6/eoOviJcnWFd8qBv7xnTAZYR1x09ZnDOPQ=;
 b=NX4D491Pf9eXds7PrYkke+ebgHAxD4von/LcYv3oB5XO6iCrXrVZAz5R7nYnfB4RfHEQ4m2ee/76FPIJI1apdyQR0QfoE4k2eZJ+RU3Mt9B8HVQlHvlqRcOK8cJMzJpjmWOwlSnEs549wjeAsx7XF6HJsmtxu9DL1637OJ5mF58PT7R5/ZKZW3lbVKcUniP99II10X8R1amND1fuDvs/nlpZjHefqQvPT5GNpt7bYtEYKmThG+iLcanJQLDmI49FqAJT3ZZulMF+/F203Z/Z89MxbaXdrNDlBRavwKeJ51xDYIVsXcDqpn7nsoqtrJcouV3CYLjmcjTlcbVaJcBQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DM8PR11MB5621.namprd11.prod.outlook.com (2603:10b6:8:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 01:28:43 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%4]) with mapi id 15.20.6277.047; Thu, 20 Apr 2023
 01:28:43 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/7] intel_idle: cleanup 'intel_idle_init_cstates_icpu()'
Thread-Topic: [PATCH 2/7] intel_idle: cleanup 'intel_idle_init_cstates_icpu()'
Thread-Index: AQHZcs0GAFk5IWtUEk+LazcY0qeIEq8zaUaA
Date:   Thu, 20 Apr 2023 01:28:43 +0000
Message-ID: <23589d6f490edf87faaa998a2a3f9898832a593c.camel@intel.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
         <20230419143947.1342730-3-dedekind1@gmail.com>
In-Reply-To: <20230419143947.1342730-3-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DM8PR11MB5621:EE_
x-ms-office365-filtering-correlation-id: 45f80c7e-718b-41a3-db6d-08db413e9426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9x/7LLpQ5+Fv+woK2utjX+fe+V7wL48OOrePMpksUF/mdgnURdYZ4xZsEkcGvWiYPRcu8Dqw5dy1Kc+3VY6GP40jKUAlGWYHDy66WbniGMrM5q5dHXucWA4346PL5F9DXhzK2lw3uKluofY7JTOtOHi1z3HjlceESle4WKZdm76x0lt2iuL8EbodEZ/EETbFH6SWQYKflVND24RI6z+i+NHKkqgYO38xJ4hPscZEFn5nW5HCD6SnY8fmH0WGVRxzI/v3OQcZ9f1FNlmBXZK0lkKZViOapDN/BeJ3U1vxs4mTTmNg7NAKVjTcDlgWfXl3mr7S3kB9SvAbbs4GXhftZHrX5tIDZL9D/O0niNwFoA4+o7v6EKfixG4/f0TukurAYZkDn7JajnTz8vXrjXv8W1yXH155AN67UB6dxiu26wUVr7aYcD2VjOv2dgkzMIwFeezawowNWzuAU2uQ6sMykY29gzkL1wWgsgnCFgaKr9VF6/1N/BajzqA1VmAVd4BblHYP/AQAIlqJYKKuCUy2IZ1ukQqIqgeds46/Rbyi2TS+NK1S2apFkfRnTEraBLyxUWBkEn4H5zHPkG/uOsR87waqhggs0x2Bj3zh+wrrknPK8pqrdPuW9W+7/l4OqLC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(316002)(91956017)(110136005)(66446008)(66556008)(66476007)(66946007)(64756008)(4326008)(76116006)(186003)(6512007)(26005)(6506007)(2616005)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(6486002)(478600001)(71200400001)(86362001)(36756003)(38070700005)(82960400001)(4744005)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21nRkkwaVNMS3ZlOEpLZlFZQ1RZTXNjUFE4THZYTXJFN1l6M2Q4MkFXTVlm?=
 =?utf-8?B?SWNuZVhTV25Gc1FvdTk3dnhFNUtlZEEzeFBEVmJ1bHllR25SSlVjZ3FXREY5?=
 =?utf-8?B?NEk4Mi9EUFFXZzRTeDM4WXdkZG1sWkxxcUtFcXg5SlVmR3hadVEzS1hCOFFT?=
 =?utf-8?B?Q2FHYnpDRlNKNHU2YmYybnpPdEs0UHBic2lVN3RBZ0VkNlltM0xpQkx4d3NH?=
 =?utf-8?B?WFB3aFhyMG1qdHQ5VDBrdkpFdCtJZWtFY1hvNVRQSEtDVVhsS3RZSmxPY09q?=
 =?utf-8?B?T0p4QVpweHVyMkR5RUQ2Mmw3SXA1cFN2LzNkb3RYK3JsRnNWeGs1VDEwQm9u?=
 =?utf-8?B?TjhhTm1ra0VJQlhzNTIzQWpJSG1jK3k4dUpDTCtNVkxPOW5ZR0pCWVJWbUc0?=
 =?utf-8?B?QW45Y2U2QXN5SVFiWENmNVZEcWFpMGpBTnFEbmNkVTBOVmZCSC9Vd0pJVCs4?=
 =?utf-8?B?b1M4NTc5K2h3bVBnVjF1ZWg5K1p0ZDkxczZNM2pGRjFERHhhR1U1Ym95azk1?=
 =?utf-8?B?b05qaFg0RHkrYVpFdURqbC9vcmRRL21vcWsxc1JQVmd0bnBOcEVCaG1XaGFq?=
 =?utf-8?B?eEdNYUJOODFISDZCMjBuQkhoRUM3dDIrQldaU3Q3RytjS203RHI5VU5QVWRB?=
 =?utf-8?B?TEhpbHlHT0Ezc3BENWhmTUlXMVJ5YTRjYWV3Z3lRbWhlK0gvSEVxZmRYWm9Y?=
 =?utf-8?B?clppZ25KN0hDWFZQQjFHelRKQ3R5TUNpNENIY1VuMjV0aXdKTi9XaWNJNFVq?=
 =?utf-8?B?M1dYNkgrUVYzUzBTNFNYRFFqQ2ZieUxsTHJnVVNPeWZzN1lQa0FFVE1LY1FT?=
 =?utf-8?B?YTZDVytob2l0T0ZBaVBpRkhwN0hRV2p3bGh6OFdDWE45elE3Qll1K1ZndjUr?=
 =?utf-8?B?YWd3VDFBR1p0MXdIOHZKODFZQkg4TnBKQ210cjd3MDNSeDF3SnBGdERSZUI4?=
 =?utf-8?B?V3lZZkdndFVuY081TG5aenUrUjN4M3JiSVIzOWJxbTFiL2dwNml6R3d1Y3Vx?=
 =?utf-8?B?QlFoVW82MStEbUlzMVZuZWNucFVGUDVFUEszd1hxSmlQd2dNYnhWUkZaSnl1?=
 =?utf-8?B?WkJCdmZCK0Y4YkhkZDhjNS9XV1BiZUR4Um9GS0VDbCs5b3JYakw5U2lUZUEw?=
 =?utf-8?B?QnNUQml5aFRYYzhUNC8ra1dpeXM2eWFyVXRJYUhuekdoZXU2KzdXd29uR2FG?=
 =?utf-8?B?UTh1SFBGTmRpUXMxRlJ5cndndlAyMWxjZGp5VkoxMmJwZWFNeGYrVVVyTHlv?=
 =?utf-8?B?QVhwbVhSRW5FU3Q3YVFkK2NOREczSXhOcFZVUno0eStZNzdCS2l0czVCK3lo?=
 =?utf-8?B?VElwbHdQanRETFZFR21vS2xYeHBrdUxaYmN6ckVjdmE0UlJKemJTb3F5N00x?=
 =?utf-8?B?Y2dGSjljQ1pLaVArY1F4OVBHRVRPbjZJV0JUL2tVZFVJSFZkYU5kRXpXNEps?=
 =?utf-8?B?Y21FdkxHNHJGZEg5SzRta1JSSDdJaHBHOVlnWUp3bTlraW1SYmVORnR6OHN3?=
 =?utf-8?B?eGVQVS9EOFpHM2s3ckZpcS9ucEF6dVZ2RlB6dGNHcmlQbjhMZVNtSC95RWFO?=
 =?utf-8?B?cWpJejZLSmhJZ2Jia016dEVYbzh1VG9PQlNHRUtWTnVPeEx0cmh3OTVqZUJ6?=
 =?utf-8?B?U3lJVjdlZTl6dS9CWERYTjl6SUM0aWV0djByS0Q4Y2dTZEUvd3B0cTFhWnJN?=
 =?utf-8?B?NU1YVmJIZGFVelZKdTZmMUhKZEJCUlV6bENDZUNlR3FxenZGcElqcjlXcHRw?=
 =?utf-8?B?a3JoR0p0MVFRZTJoR1Z3bktOV3loV09XazlNNXh1cGZQNTFOOHJxd2pLNnoy?=
 =?utf-8?B?QUU4b2VBSytjNGpEbE1JYkFVNFk1QXJxbnhabkdkRkJPdHZtSHdXa2JJMjYy?=
 =?utf-8?B?QktmQitsT2piNUQwZXViWFBOakNxa29PMFpRaE9OQ3htbGVqT0ltakJNbUUz?=
 =?utf-8?B?anpCWk9ZS0liZFZyY2txeFF0MDkxMkE2eDcwbDBJUHRIbVc5aDByb29OTTli?=
 =?utf-8?B?Zm1mZ1RkTDFheWNicFNGejRRdjYvMHAzM2tzVjdKOVFqeDVNOEZsWVRqMHhF?=
 =?utf-8?B?U0ljUVFRUzFVQjQ5VHhGNW90MDAzNlUvSzdQaEJrMEVlVHhHNlBUejU2MnIz?=
 =?utf-8?Q?fnSqXb8qqpENqm/QeZSSNKrtk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB634234C8670429E015A88D9C0FAF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f80c7e-718b-41a3-db6d-08db413e9426
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 01:28:43.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hozeg8qaQyX3GsEaWpVumKo5fwQEyhfrF6WC8sYXSeX9bva6lIfeL/SatozcJjLmxanmazjuU7smf78qN1+KlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5621
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

SGksIEFydGVtLA0KDQpPbiBXZWQsIDIwMjMtMDQtMTkgYXQgMTc6MzkgKzAzMDAsIEFydGVtIEJp
dHl1dHNraXkgd3JvdGU6DQo+IEZyb206IEFydGVtIEJpdHl1dHNraXkgPGFydGVtLmJpdHl1dHNr
aXlAbGludXguaW50ZWwuY29tPg0KPiANCj4gVGhlICdpbnRlbF9pZGxlX2luaXRfY3N0YXRlc19p
Y3B1KCknIGZ1bmN0aW9uIGluY2x1ZGVzIGEgbG9vcCB0aGF0DQo+IGl0ZXJhdGVzDQo+IG92ZXIg
ZXZlcnkgQy1zdGF0ZS4gSW5zaWRlIHRoZSBsb29wLCB0aGUgc2FtZSBDLXN0YXRlIGRhdGEgaXMN
Cj4gcmVmZXJlbmNlZCAyDQo+IHdheXM6DQo+ICAxLiBhcyAnY3B1aWRsZV9zdGF0ZV90YWJsZVtj
c3RhdGVdJw0KPiAgMi4gYXMgJ2Rydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdJyAoYnV0IGl0
IGlzIGEgY29weSBvZiAjMSwgbm90DQo+IHRoZSBzYW1lDQo+ICAgICBvYmplY3QpLg0KPiANCj4g
TWFrZSB0aGUgY29kZSBiZSBtb3JlIGNvbnNpc3RlbnQgYW5kIGVhc2llciB0byByZWFkIGJ5IHVz
aW5nIG9ubHkgdGhlDQo+IDJuZCB3YXkgYWZ0ZXINCg0KPiAgdGhlIGJlZW4gZG9uZS4NCg0KaXMg
dGhpcyBhIHR5cG8/DQoNCnRoYW5rcywNCnJ1aQ0K
