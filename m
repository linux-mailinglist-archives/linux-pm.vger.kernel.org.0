Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75653545A83
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 05:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiFJDbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 23:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDbl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 23:31:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C426647A
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654831900; x=1686367900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ByA5IuU7OLsItsqKRkZ+5rACeC2sNk5fD/XPWMOPuvk=;
  b=CAsNjeyCvjes09eGVYu0si7/KBrpDgGDldpBRQP9hao5bjUuPQfrImAU
   YpkVT/HIjBucV7DLs8H3cjIqNBdTmcldFtg/kypqkBjQyAetfXJPEYlUV
   Z1U6cOiMtvXiQ5VHHdreNkzYLHAMMdLV8DKhknlURve5vy/LW1BQFnP/B
   HyHnXt00Kj9F27CtJbsPHjBpwJN0+OkPCpL6BHg9khs/SIFEPl45kADAY
   gLx9ezHRJmFNMx4sGTcwjuub5MpTIdRQ5qKgfJ+j2tDE8s88DV44z8S3W
   GCX+AaY0zKpnX6zbHwjj9a6nwPSgmgvv1VzzB1UNaOMQyy/+0ii2OiAWL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275024191"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="275024191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 20:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="533899809"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2022 20:31:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 20:31:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 20:31:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 20:31:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 20:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkHaZXLPh4GneT9Rxcw7pU4cmeZsEaZ02gSVjQPnyQDGWfv46Iul/OmV1QWa87rlyhTtti0w9pSlTf4JkiaoZI2K/7sgMDlERJwSTnbMeBIq+ADh10MC+HgXVCV0Mt3CuGIc4Hds+BItspM2KVBHUnVmkEKduLpBPrZbFXEnIe5T44Dnuiw5CKeNTeoHacfiwdKHsEMz1FZQlZSbt3sukGmqZj6w+mEIq0EXs1oEyCePeYly5cxMNXRLfiY8ELe7uL9kHy9GC1rEknHbZ7v8G0sDo7RhIPzNP790lNkWkkmTJlia/xs+2eI9SmV+9JrnkK0F3tK6+ZS/kyEovLt1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByA5IuU7OLsItsqKRkZ+5rACeC2sNk5fD/XPWMOPuvk=;
 b=NzOmKM3aKdb+vQIyh0tUB56kTqg9WPZRiri6RB4BRkOGCu+6L3OhuOZfpBdOypjAAvAxR5fd/2u7OEqVp+htlXirtyROA+6CyzUY5Im5BvQQ+jJXfvnhOTStUzqsgVPIG1s20xMlqVKDUrOoDHsox8zDaI14stq5VhS0JG0mfJtv+eyDW+miEzJP9zYimLmKHriiZyWRErsZ5GEt68rX9w79VXk+22aeAtiqCLWOKRd4Gtrtu/W73y42zkWarbVGrQ2m6NSXcxEROuPLdqkzRgLfXP2Ta/OnvLdG5SAZQyFp9ZpqCd7916lFXToCKO1qFAid/XTHqQTwhkP2d3T/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Fri, 10 Jun
 2022 03:31:36 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::ecb3:4e15:2d91:bf37]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::ecb3:4e15:2d91:bf37%5]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 03:31:36 +0000
From:   "Sworo, George D" <george.d.sworo@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Topic: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Index: AQHYdez4sg2jmwWTEkml1K+XDmCpS61HeTYAgAB+DgCAAA+SAA==
Date:   Fri, 10 Jun 2022 03:31:36 +0000
Message-ID: <de55f764d1f91594d2abd61b9058ccbe45cf8035.camel@intel.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
         <13a8ee34a67ec8a59e926c91894365e8d512d260.camel@intel.com>
In-Reply-To: <13a8ee34a67ec8a59e926c91894365e8d512d260.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5091fa-0bc2-4862-749b-08da4a91b92b
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW5PR11MB5881F6EE7F19AD205F9F7D46C0A69@MW5PR11MB5881.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWR+lus+DB5yVn5B749LR5yfsEk/O41sHtuLUPT0DxcWFpp3ZDj/n2j4DsaQbcKgTzxF1vj1gkv2bl9purXgR4P35vvdk0PbLRAO1rKXcVdeVqpZJHVMXG4HCU9hfidVlKmz7hiYaRPIexW3e2FZLpYiLa1jriVYUJFDdoQEdrBIbxGREFqf4Ir4bsqzA12TtKK+6qPsd7DKZ8Ktqbg8O1PqkkfB6tLkuRIVW93y6LKUY2U01xvChyU9pV9poVcy3tf5zWjKSDbYsB++/D5dpJBEgrj9XcVLt41kN7faFDf2n1PKD6qzbo4j98XYsJmWzWKXhqLuK+8f2Z/xIB4Kd3DZcqHqyVIWgFjT7B2WxUrZdFhwDXumeFG5vQHooS9lGwhzNyjZ4vciF5fxV29hU33t0/hNYWEAgTHStYLhZz6BKA0xdwZM7eeCz86gAZ4F7gW4by8fl7FM5YZHi41qb+GVBCP+YTq2iGjl+KI9iD2umSLzmks0m+esPD8rkx+nuB7+euAsJJKitk5nTrKn3742rZuVRbdlq4fY6Sx9F65YAZD4X+6yLBAVcS5KURWw5k2v0J1SnLWGlCL9s8k8SBCzvwm0Tkx1hSlKKvmachQzGjbgxbgTJ3dc70nZQkMlKpou8hGFAmXe9iXEr8LHcuimIxJ0cdzc7mBvJh18aFPBbyhIICo/QZlSrrLRNBGAmkvA2B8s98Y2p6f0W2L/IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(6512007)(26005)(86362001)(66446008)(76116006)(66946007)(64756008)(71200400001)(66556008)(66476007)(508600001)(122000001)(6486002)(110136005)(82960400001)(2906002)(36756003)(53546011)(38100700002)(6506007)(186003)(8936002)(5660300002)(2616005)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW5wNFJxOG9GY0NRNm9wdlB1ME9oaFpvV2pLTUpWclBabzZNcDZKSk0vcjVF?=
 =?utf-8?B?UXgrRWNvSHl5QTQxcEpoS0JIWEJKTzcyaWZkRzgrdUdZUWdHbWNrRUtBdzhT?=
 =?utf-8?B?VDNzZm1WM1BnU292MG5leVNiRUFOWmdYQ2lpUXh5REJQSFEwMVQrdm5CTWlR?=
 =?utf-8?B?MVladHIrVjMyNDJxcCsrRnFSbTBOcUpOWGh1QWtDVDVqNlVIT0czWVA2NHZ2?=
 =?utf-8?B?bUFaTmk3T1JRZFBISzYxdHd4MkFJcnBSNEtEUWFUVjhLbTRBZ0c3NHRyNG42?=
 =?utf-8?B?dkhzVmhaWWdWK3NrNGt0MTc1bVVKdTBTMkNFbk4wVTQ2SkczajZTczZxZWRC?=
 =?utf-8?B?U0FPbVgzNS9hZDdML2Facy8zTTVCdnBZTDNCdW42WXhNZmJFKzFQNHN3dXQ2?=
 =?utf-8?B?Ynh1WDZEZ2NpWGNUY1NadnZ6RWFIWW41TkJtNVh6UGhVdTlTUGQxaXB3OVlo?=
 =?utf-8?B?R0lGUFdZM2J3YUs4U0dXY1Z3MCs1Z1V6eTR1cmVYU0tyNVRzUDFyK3FNY29u?=
 =?utf-8?B?cXVVbGJkTTluR1p6VW5wK002OEViTU12L3B4QmhZMnpvQzdhM1ovSUhYUjdR?=
 =?utf-8?B?NGN1RXVQVEttSDh4Sm8rclRQYldUL2FHdFJGR1NvTG54UWp4SENoajFpd2Vm?=
 =?utf-8?B?SnU1Tks3NUxTU1I4cURVRjVNM2JMTWY0VkdJWENob2ZyMVN2aWpGeGF1VGJM?=
 =?utf-8?B?bDM3V2NtS28yZnRYU2tyN1kwWEh5c2g1aTdBVmxma2J2ZlFkZkFZeU81SUFC?=
 =?utf-8?B?d2RCQlhLYmJYb3FOd3pPa0JZVXRZc0Z0ZE5pZDlYWm9JaEhvWmVxTjVwb0NY?=
 =?utf-8?B?ekxyeGdiZFhRZXZiMERQQm1ibDJxc3pVRksxeGtLWnFUS0R4RXJadVBLVHNN?=
 =?utf-8?B?SFZXQnF2dkgvZjNZajRlMVpmZVl5UTlXTFB0L2MvbEh5OUpTd2xDUXhZcmNt?=
 =?utf-8?B?dHFCUGRKaXloczV3MThaNUhNODZMRTN5RVY4amJ6R0ZJaDRETjBYTm93Vkhr?=
 =?utf-8?B?MHkzQTVHWGJHcnBMVHlseDFJOGt0K3ZQcWxUalVsRGh5NXhIaVJPNUhBdnlQ?=
 =?utf-8?B?N0lseHN1WmdtaTFvaEZRNnUyZG9LVHBrbG9EdjVxYU9oS0hrcVNQOHlDc3V3?=
 =?utf-8?B?dVY2N0NoT3RqVWhMdVllVlptT3dIRWZhaGJpVWU4aFdNK2k0d2NBbnJSUTVD?=
 =?utf-8?B?MGtyMy9mcE5xcXF2VVQ4dDRESExGeEpBQUdXMjZxNEdCVjdQNDBCeW04MzRQ?=
 =?utf-8?B?YysrLzJmMk9TWDVybFZpMmh2RWlnVTgzMDB0aTJVYndWWFdSaHN1VWpxS3FC?=
 =?utf-8?B?RmJDQ1cwUGEwTnpBMmRXOC9ZR3Q3Z3F5Wm1QTFB6ZHN5ZmVkVzU5eHhMOXc5?=
 =?utf-8?B?dkcreEpudXgwSXBxd29pVU92SFd2UVdTS3kwdk9kOW9aV2lseWRrL1dVRDhH?=
 =?utf-8?B?QS9CUEk2TXlGU3o0dnF4MVVwK2dmVUYwbmZWYXVkZlM0bllwdi9walg5YnBF?=
 =?utf-8?B?QndLeVhMdG4rdk42V3ZLRmIveGx2U0ZUd1VYRXF1angrei83aHNVWFV6OEtQ?=
 =?utf-8?B?anlhWWM0T2NSdmJEZmdtYVF5Sk5uS21BUWltUFpVWmhQWXl6WTQ2b1B3emZF?=
 =?utf-8?B?TmVOZE44b1g1YmtIS0tEaXgrU3F0RUVGODNEVUlTT0s5b1hqa2tPYy9nSGlE?=
 =?utf-8?B?U01vNEJqYlBabEdLNFMwUjFPcHVIUGdFS3N3TXhoVHdOemplQjR5SGw0NFFR?=
 =?utf-8?B?Y3liZy90bW1qT2VQdUNkQkVnZ2RSL2xXNHlHTVY0SFhnRnlVcmFiM2RBSlI3?=
 =?utf-8?B?WnQ2UkU0L2NMZGVPSnRVNmRDdDA3TW1VZUNweUdML2h4bXBNNW4wdlNVTEhh?=
 =?utf-8?B?TXVzMkZPV1AyWHVoQkxxa3k2WE8wUUZXNERTNDRDODJhNHZramFseUhTU1Nt?=
 =?utf-8?B?anlOUTdhWWtHMWduZnYxYWZVN2xlZnZNWUtPRFdYbkV6QVNKSXpRdUQwZjBI?=
 =?utf-8?B?TFpoRUdyWXluMXY4UkZuenlGYThUMDlRL2tJaDRGZFpRRFZIZytRdE1FejJY?=
 =?utf-8?B?NzNPRlhXZHUrTUVpZ2JNMnVWTXdzRDNQOEV6emlwY1pwenJXbWdHcHZZQmRR?=
 =?utf-8?B?RjFucmpvUFZTWVk4WkpOY3Q0SmhETjRobE80QUVvanJxWDI1dlhoT1cxOHgy?=
 =?utf-8?B?dWhWQ2Y3QVkxb3hSNlJIZTlHYUp6V3ZXVTU1VUJ6ajFZem80VW5MbGhka2VX?=
 =?utf-8?B?Z3ZuOWI4WlV2VHZONmUrN2k0aVFMUEVKR1JoQzFDMDZkNnh0MFk0VE1zaHJs?=
 =?utf-8?B?QjdrdjNUaFBWaDljWWtSR0JkQ0lSY1ZKenZ5NzlzRHQ5KzFZN0dCUm5uZUYx?=
 =?utf-8?Q?Hk4/J4cG9J/TEsG5pMrwQdQoWKbq5SMYbZG07?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EDF55590F37C04AB68EBFF4B074B290@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5091fa-0bc2-4862-749b-08da4a91b92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 03:31:36.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+kNaqOzHx/1yiYuDNnbib+8lWq37XSY/nyxf0Ryjn1uT77D2VuPnqY9Eovp9XiD07y728D+7dkPrhnqA+gg7ps0ZfE4pAxZK2XR1wObd04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDEwOjI2ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+IE9u
IFRodSwgMjAyMi0wNi0wOSBhdCAyMDo1NSArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+ID4gUnVpLCBTcmluaXZhcywgc2hvdWxkIEkgdGFrZSB0aGlzIG9uZT8NCj4gDQo+IFNvcnJ5
IHRoYXQgSSBtaXNzZWQgdGhpcyBvbmUuDQo+IA0KPiBHZW9yZ2UsDQo+IA0KPiBIYXZlIHRoaXMg
cGF0Y2ggYmVlbiB0ZXN0ZWQgeWV0Pw0KeWVzLiBUaGlzIGlzIHRlc3RlZCBvbiBSUEwgU09DLiBU
aGFua3MNCj4gSSBoYXZlIHRoZSBzYW1lIHBhdGNoIGludGVybmFsbHksIGl0IHNob3VsZCB3b3Jr
IGJ1dCBJIGhhdmVuJ3QgZ290DQo+IGNoYW5jZSB0byB0ZXN0IGl0IHlldC4NCj4gDQo+IHRoYW5r
cywNCj4gcnVpDQo+ID4gT24gV2VkLCBKdW4gMSwgMjAyMiBhdCA5OjIyIFBNIDxnZW9yZ2UuZC5z
d29yb0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogR2VvcmdlIEQgU3dvcm8gPGdlb3Jn
ZS5kLnN3b3JvQGludGVsLmNvbT4NCj4gPiA+IA0KPiA+ID4gQWRkIFJBUFRPUkxBS0VfUCB0byB0
aGUgbGlzdCBvZiBzdXBwb3J0ZWQgcHJvY2Vzc29yIG1vZGVsIGluIHRoZQ0KPiA+ID4gSW50ZWwN
Cj4gPiA+IA0KPiA+ID4gUkFQTCBwb3dlciBjYXBwaW5nIGRyaXZlci4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogR2VvcmdlIEQgU3dvcm8gPGdlb3JnZS5kLnN3b3JvQGludGVsLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8
IDEgKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4g
PiBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+ID4gaW5kZXggYTlj
OTlkOWU4YjQyLi4yMWQ2MjRmOWY1ZmIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3Bvd2Vy
Y2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50
ZWxfcmFwbF9jb21tb24uYw0KPiA+ID4gQEAgLTExMDksNiArMTEwOSw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgeDg2X2NwdV9pZCByYXBsX2lkc1tdDQo+ID4gPiBfX2luaXRjb25zdCA9IHsNCj4g
PiA+ICAgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFX0wsICAgICAg
ICAgJnJhcGxfZGVmDQo+ID4gPiBhdQ0KPiA+ID4gbHRzX2NvcmUpLA0KPiA+ID4gICAgICAgICBY
ODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChBTERFUkxBS0VfTiwgICAgICAgICAmcmFwbF9kZWYN
Cj4gPiA+IGF1DQo+ID4gPiBsdHNfY29yZSksDQo+ID4gPiAgICAgICAgIFg4Nl9NQVRDSF9JTlRF
TF9GQU02X01PREVMKFJBUFRPUkxBS0UsICAgICAgICAgICZyYXBsX2RlZg0KPiA+ID4gYXUNCj4g
PiA+IGx0c19jb3JlKSwNCj4gPiA+ICsgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwo
UkFQVE9STEFLRV9QLCAgICAgICAgJnJhcGxfZGVmDQo+ID4gPiBhdQ0KPiA+ID4gbHRzX2NvcmUp
LA0KPiA+ID4gICAgICAgICBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChTQVBQSElSRVJBUElE
U19YLCAgICAmcmFwbF9kZWYNCj4gPiA+IGF1DQo+ID4gPiBsdHNfc3ByX3NlcnZlciksDQo+ID4g
PiAgICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKExBS0VGSUVMRCwgICAgICAgICAg
ICZyYXBsX2RlZg0KPiA+ID4gYXUNCj4gPiA+IGx0c19jb3JlKSwNCj4gPiA+IA0KPiA+ID4gLS0N
Cj4gPiA+IDIuMTcuMQ0KPiA+ID4gDQo=
