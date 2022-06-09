Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F161F5456B3
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiFIVsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiFIVsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 17:48:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2494E113B68
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654811280; x=1686347280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J/iqsh/cx4RmlNEQ5Tf4z4xofRI+c9vATCOulI1DLac=;
  b=NRHSf3P0oSUJy0wiwzRVE1YYE2vCMRwIoX+DASPq+2jeDzycXgQ/+nJH
   uS8AMVXIoOoEPmOEC4w6ooIa3lWDLeQuuPQ+z+c3X6lLoCRTOGpkGWYLN
   DouwXRpGHLitbKrHKnODT19lZAv1Am7gGGYpwpo1Brzxq6REb8dMiFC1V
   934m3u2sDIaydjdNFYu0oxJ3Ie0L9JyLXZDD44d7RbahuBJM7dllwK3D/
   zQ1CjVIQ9pQIynrpRoEcY69MWgWqqUSBW49Yo1JtGSVD0kxm9mS5zoFC8
   YxhHAFevBqNAH8il86ANkcMHcrcSGSNSBcRnbuNL1hQR6l4LxPG4nx+d9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339182610"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="339182610"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 14:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="671528541"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2022 14:47:59 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 14:47:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 14:47:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 14:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky9IawA2pMFOHiB35QAWLw8FRKllc7t0PQYOOXCXUyKbLOhMm5C8GpiC7v1uJlJR4ycVNcdG77AyTzn9w5YieBUak+rbodochNbQg0sD809425ZzU6ANQsbswxm7MNnJUvgOdIsFTt8mJRUGhH+UOh9KoiZ1xfCs5QJXn7pbOPwRt5B1alru5+QhLYzi8MsHOo3GCCGsshedfNCiYpHHcAJNuyd8ffj5O7WVVeWIOQ+ciZj+l2OlpXoA09orPjwyWgWY0t/KD5PSiO3NjDg3hJnKO477eE5WGW8dBI0s7Dc8Y1G5G8QkZqYuk4oCzjhCTG2Qe7asJsXmwJOK4Rmdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/iqsh/cx4RmlNEQ5Tf4z4xofRI+c9vATCOulI1DLac=;
 b=Vd8xCvLLFhRcFR1/8SmBahsKKz+P51MHgKthg37i5hMnSGWiDIMu56Ko6JL8BAIlcrjchHQXmphRCGwTrUwd8tMgmfHREv19lKU8nVZTMNkaYA7RVUqWl0UDGkI4f6gJC857g2xQmLfdlmOvUqYwI9YTQGPyR4d4+ZM9r7/kBFv9q8YbGtc0Amzv9rdFYS88YBSsfJXTVeC+2uQpD8NQNgjnjp1AIHMBj1krFBe55taDeGiJMt0xMOs3HhFCGC232SDM9tkMGopiIo3RNS2ArQWXSOPE333KNUuFRBCQ4oAdDjiSOdI/S4ejpWwiRsMozs2FSFZmkvVMCRsLoquAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 21:47:56 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::ecb3:4e15:2d91:bf37]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::ecb3:4e15:2d91:bf37%4]) with mapi id 15.20.5293.019; Thu, 9 Jun 2022
 21:47:56 +0000
From:   "Sworo, George D" <george.d.sworo@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Topic: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Index: AQHYdez4sg2jmwWTEkml1K+XDmCpS61HeTYAgAAjbICAAAywAA==
Date:   Thu, 9 Jun 2022 21:47:56 +0000
Message-ID: <abfe8223dd06766d4297cbef0728c84f1e7d3aed.camel@intel.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
         <4060997f422b18a01eca3c8d0d17b39fef7e9e5e.camel@linux.intel.com>
In-Reply-To: <4060997f422b18a01eca3c8d0d17b39fef7e9e5e.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 760f2eb2-7c46-4bfd-b30e-08da4a61b691
x-ms-traffictypediagnostic: DM5PR11MB1899:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB189939FCD724EB2B3BEDCC17C0A79@DM5PR11MB1899.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rm9pbxk9lQeg8uu9LgMYHADE47qUOdw/AV1LXuQzXNQ97S3xDbBrsVSvMhoHO+XwbUEF4+086PU/NcSk+yX5+IvDm/UoYkSIvSdQmy7SyivzAguZySGufMmjBue24YKrCSS3ECtPCipRQtXl86PQFaaGuRbnHRr8KnEQ6hwJ5LCVLPMLC5yJ283yVxR9rot+VJFwVQKdW1hXe9lfUTdBfhs8/5cPJZ+cVwTgId3JjxfOVAghcjHVSdcgOWE0/hIiAky+aljI/k0dpckBe4AyVB//r487xIx2UwOc5gQ/h6Wsr4CSlYgF3VI75iWfHyvKY4HJsBgO4w3Hzydy4P+o9brZViK76+zWIv7I5rJ4d4gaep9/Ib85LLvKH/y7Pm/zl7aKD9fLE7sMVK5AR3d4vSjcg93ikii6SmWxOSQSuvSqpAYLPpc3JlaeI7Llmb2xwFwLwXXqoAwrv/Q+yohu5G43IXTBzY4vMi4ppiCFDaOCvnUIah5FlaAhjXpgvMf/+vsleKtIPJTyptZNO3DutmoqgC+1omMp40GU5uconLDvblwB4bP27Ece3E1S1JTyX8H7LN1tB2dNUxjoQ1WFVigsnfgAhKaLH2+eu6tjYs8qjvjB5VsA9LMJBSNPz1oNgTQpJmRsmbv+UTd4kD4d+7TloZS9ylRQ6sN12Wp7tPyicpp4tOvIZppA0NiedIQEttg78LyvQ1JvCgsxFA4vVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(66446008)(66946007)(64756008)(8676002)(2616005)(4326008)(316002)(36756003)(6512007)(53546011)(6506007)(26005)(38100700002)(86362001)(8936002)(6486002)(38070700005)(5660300002)(110136005)(508600001)(71200400001)(186003)(76116006)(82960400001)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3BGU2ZTL2M1bnIwT0F6YUIyOHM2aDBTaXZYQVpLdXFLWDU5OFN5NzNxQWsv?=
 =?utf-8?B?R1o3RVZ3TlN2cmQ3OHU0K2F6RFVUWkIzTm41VlVCTnFhWGxCcUlrMDFoY2Rp?=
 =?utf-8?B?N2VDdVNmNllhSGw2amRDaFVYWDN1czBuQVZkOUNtOCtTWEhqc25pUnpDSm9X?=
 =?utf-8?B?MmhwSkNKUmhUdnVyVDludm5taFU5WHd1anMzZXZvd2srZ01sSStybHMrcXVx?=
 =?utf-8?B?Sk9oQzFLeEROeEMzR1NJQVhYYjdvK3lBUmpCdkpqWlVhRjNFMHJGazlJMUk1?=
 =?utf-8?B?dVRTb1BvOVJ1VElRZG5NQjhTcHRYd0RxQ0g1QzBobU5FN3VacU1hWitaUERy?=
 =?utf-8?B?TW14Wklnb0xwZlBxMEpPRWwwN2NLK0lVUGRpM2R4RzBWWkFBOWNSVmZCQ2x0?=
 =?utf-8?B?cC9palBBVm5PTERoRzNRNW5SVmgzYmIwdzVseEpxUkMvWjF2bDBhT2thMUhP?=
 =?utf-8?B?UWg5VkdrUE9WcmxMMGNTZnJHM2VzbGVSQ2tNZTlqdzBiU3I5N2hHN2FnVG5V?=
 =?utf-8?B?OTBhUGdBRUdaYmE4TkRLeU9DaFNGMmtGTW1tNFhrejJpQkliY3lQUFY5YWx4?=
 =?utf-8?B?SlErUklRUmRIODdSaklrUi90WW55SE9OOHRrM0UvNWo5cmI1TGlQdFdab0dk?=
 =?utf-8?B?MUFHUjFtdjVtSzRpZTR4VHJUTTdnSDdwdUJlRzdJcjc2QldVZlBaekp2ckVo?=
 =?utf-8?B?ZzNWNUxQSXFxMENIakthZXY5U0psV0lhZERRY1FSbE53TkVva0Z4RmY2Ui9v?=
 =?utf-8?B?bjFCT1JwOXRNbUtLdStScGM3Mi92Ri83bU9JU3U0OXN6NmZZR1p4TDVMTmhl?=
 =?utf-8?B?VVBEN2RMWVZNZHU0RXNIZGFad3dodm1mNC9YTHJXMHBpV3U4eVRIQ094Yngz?=
 =?utf-8?B?Rk9oNG9KdDlPYjZabHAwVEM4OEJLRjFPMndKMG56N2lZTzY1eU9jNVdFT3dz?=
 =?utf-8?B?SnNWWk1RTHVrU2VldnUxYTErTVQ3OE1VajNIaEZLYTN0a3BXRGNBU1RGd0Jy?=
 =?utf-8?B?SGtoWk9PR2lXODRQKytCbDUxK0NrU1ZERWNUNE5wdmtxWE1nVzJvZjhhMHho?=
 =?utf-8?B?cFNmWVNTdVVvZXZsWklBUHM5U0x5emNRbjNITXpJMlV3VGwyQXRkdkE0Uzk3?=
 =?utf-8?B?RHRmK3RyQ1ROQ3pQZTNOdnkvWkJiQWxOTnMzUEFlVXZpNVVkblkzQU8veVU5?=
 =?utf-8?B?U1l2NzNxU1MrY1UvS3IxOHVpRjNMbE1sK29PWVVzRUpOUm5wOEw5bHN6d2g2?=
 =?utf-8?B?dHQ5emN0MWlpWFVwRXdLaEJRemwwd1ZDMzhQaTZCUXBoejlmaTlZbmE2T0NK?=
 =?utf-8?B?Zkt6VGR2UmxNbGJ6aXZPKyswZ1Fyc2ZXTTRleHBiRkcxM2c3aHNoMVh5ZmVt?=
 =?utf-8?B?SmEvTlpoVUEyalZjSFdjWUhaR3NzSWtjMHVDUFo2dnhKamNWb0sySGpKWmVR?=
 =?utf-8?B?aGU4aFhxSWlVbmh3QmNqVUFac2xCTzIweVYxcnh2QW1lTUE4OEFEajhHNjNh?=
 =?utf-8?B?THNISEdrR1dZOStSL0VMNW5ubHUrdjJ4azN3NHRwUnpZNzZ6MjdzNVlwY2Jt?=
 =?utf-8?B?eTd4Q2FzdGZrSEJoZERjWjdiSFllTGlEVmFhMFladUsrWER0VnVtRkRjaDdH?=
 =?utf-8?B?T3gxQlNEM3dGem1QTVdpaE5NWHJLUHh0RXZqK1JrSHBKUzlGNThHcVp4VmQx?=
 =?utf-8?B?cTdleC9wd0JyZ0tkb1dxZmVOL1hvejNSL0J2c2hud2VPVDdBbG4yTTZoOERx?=
 =?utf-8?B?M0Y5UHZMS2JSNUFhbGMwU3V2NGgwWmRER1B4Uml0cUtXYVZOYVdLU2NhZTJx?=
 =?utf-8?B?WmswMzlLenoyUnpjK2lvdTQ1VnBYWEVKYjRvSURzSWVVZURTYkNSMlJIM0Rw?=
 =?utf-8?B?eGp3MXZlOGsxbzI0NVEza2FuclpvVk9Lekl1RmlLdFlyNGRZMGVSNHNEZ2ll?=
 =?utf-8?B?dExGTEZSZk4wd0gyOUJZelFVY3hNOFlvTGMzNXJSSEt1UkNQeTdUc3NLck5K?=
 =?utf-8?B?WjBteTlMYVNQZjBzb3NSc3VzV3pCL1NwNjYrS1IrU2Z2S2JMZTF6cEF5Q2xq?=
 =?utf-8?B?OWd0VTNxbU5RRzc4TmN1ZTZKcUttaENlbFZ0ckhqT2JuOU0rYWFsTitCU2tv?=
 =?utf-8?B?bzVRMjNwU3lpTEFRU0pMTmhKU3k2Y2RxSm5tbmRyN2dWRUd5K2NBYk5Kak5U?=
 =?utf-8?B?UXhxMzJqTEpYblZwTWE0VGZSQWJNWWhTcDJXbmRaQ0Zkc0UrbXRsTTAzMEJG?=
 =?utf-8?B?N0tjSmg3RUVBNkoxVjJmTEJnSzc2dFdGUE9DMEJaNjY3WDNZaWFWa3M1U3dk?=
 =?utf-8?B?QnRKaGtwQzFWbnVyeXIzQk4yWGIrVWY1NW8vZVZtRW9KM3YyUU9FU1lLRkRJ?=
 =?utf-8?Q?cFslsbkxWgYBedzAKJnWp1uUgPChLXVD44y6Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <164C6A6F5A48B84DA41435A3D05DE8F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760f2eb2-7c46-4bfd-b30e-08da4a61b691
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 21:47:56.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zY9cqHLrJL6uS/REDgQtq3LWswBcJPp+A1Rk1M1jCIzJrVcUUSyOCYcRKv/eWy9u58/6V6M5wzRAbPPS4aMNCScHIHn4AwZo/E1D5XyTY1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTA5IGF0IDE0OjAyIC0wNzAwLCBzcmluaXZhcyBwYW5kcnV2YWRhIHdy
b3RlOg0KPiBPbiBUaHUsIDIwMjItMDYtMDkgYXQgMjA6NTUgKzAyMDAsIFJhZmFlbCBKLiBXeXNv
Y2tpIHdyb3RlOg0KPiA+IFJ1aSwgU3Jpbml2YXMsIHNob3VsZCBJIHRha2UgdGhpcyBvbmU/DQo+
ID4gDQo+IFllcy4NCj4gDQo+IE5vdCBzdXJlIGlmIHRoZSBSQVBMLU1NSU8gZHJpdmVyIGlzIGxv
YWRlZCBvbiB0aGlzIHN5c3RlbS4NCj4gDQo+IEdlb3JnZSwNCj4gDQo+IFdoYXQgaXMgdGhlIG91
dHB1dCBvZg0KPiBsc3BjaSAtdnYgLXMgOjA6NC4wDQo+IA0KPiBJZiB0aGUgZGV2aWNlIGlkIGlz
IDB4QTcxRCwgdGhlbiB3ZSBoYXZlIHRoaXMgY2hhbmdlIGluIHRoZQ0KPiB1cHN0cmVhbSBrZXJu
ZWwuIElmIG5vdCB0aGVuIHdlIG5lZWQgdG8gc3VibWl0IHBhdGNoIGZvciB0aGF0Lg0KPiANCj4g
VGhhbmtzLA0KPiBTcmluaXZhcw0KPiANClRoYW5rcyBmb3IgdGhlIHF1aWNrIHJldmlldy4NCg0K
dGhlIGRldmljZSBpZCBpcyAweEE3MUQgaXMgbm90IGF2YWlibGUgd2l0aG91dCB0aGlzIHBhdGNo
LiBCdXQgd2hlbg0KYWRkIGl0IGkgY2FuIHNlZSB0aGUgSUQuIEJlbG93IGFyZSB0aGUgb3V0cHV0
cw0KDQpPdXRwdXQgZnJvbSBhIGtlcm5lbCB3aXRob3V0IHRoaXMgcGF0Y2g6DQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpsb2NhbGhvc3QgfiAjIGxzcGNpIC12diAtcyA6
MDo0LjANCjAwOjA0LjAgU2lnbmFsIHByb2Nlc3NpbmcgY29udHJvbGxlcjogSW50ZWwgQ29ycG9y
YXRpb24gQWxkZXIgTGFrZQ0KSW5ub3ZhdGlvbiBQbGF0Zm9ybSBGcmFtZXdvcmsgUHJvY2Vzc29y
IFBhcnRpY2lwYW50IChyZXYgMDMpDQoJU3Vic3lzdGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZp
Y2UgNzI3MA0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lO
Vi0gVkdBU25vb3AtDQoNCk91dHB1dCB3aXRoIHRoaXMgcGF0Y2ggYWRkZWQ6DQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpsb2NhbGhvc3QgfiAjIGxzcGNpIC12diAt
cyA6MDo0LjANCjAwOjA0LjAgU2lnbmFsIHByb2Nlc3NpbmcgY29udHJvbGxlcjogSW50ZWwgQ29y
cG9yYXRpb24gRGV2aWNlIGE3MWQNCg0KPiA+IE9uIFdlZCwgSnVuIDEsIDIwMjIgYXQgOToyMiBQ
TSA8Z2VvcmdlLmQuc3dvcm9AaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+IEZyb206IEdlb3JnZSBE
IFN3b3JvIDxnZW9yZ2UuZC5zd29yb0BpbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+IEFkZCBSQVBU
T1JMQUtFX1AgdG8gdGhlIGxpc3Qgb2Ygc3VwcG9ydGVkIHByb2Nlc3NvciBtb2RlbCBpbiB0aGUN
Cj4gPiA+IEludGVsDQo+ID4gPiANCj4gPiA+IFJBUEwgcG93ZXIgY2FwcGluZyBkcml2ZXIuDQo+
ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEdlb3JnZSBEIFN3b3JvIDxnZW9yZ2UuZC5zd29y
b0BpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3Jh
cGxfY29tbW9uLmMgfCAxICsNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9j
b21tb24uYw0KPiA+ID4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4g
PiA+IGluZGV4IGE5Yzk5ZDllOGI0Mi4uMjFkNjI0ZjlmNWZiIDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+IEBAIC0xMTA5LDYgKzExMDksNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgcmFwbF9pZHNbXQ0KPiA+ID4gX19pbml0
Y29uc3QgPSB7DQo+ID4gPiAgICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFMREVS
TEFLRV9MLCAgICAgICAgDQo+ID4gPiAmcmFwbF9kZWZhdWx0c19jb3JlKSwNCj4gPiA+ICAgICAg
ICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFX04sICAgICAgICANCj4gPiA+
ICZyYXBsX2RlZmF1bHRzX2NvcmUpLA0KPiA+ID4gICAgICAgICBYODZfTUFUQ0hfSU5URUxfRkFN
Nl9NT0RFTChSQVBUT1JMQUtFLCAgICAgICAgIA0KPiA+ID4gJnJhcGxfZGVmYXVsdHNfY29yZSks
DQo+ID4gPiArICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJBUFRPUkxBS0VfUCwg
ICAgICAgDQo+ID4gPiAmcmFwbF9kZWZhdWx0c19jb3JlKSwNCj4gPiA+ICAgICAgICAgWDg2X01B
VENIX0lOVEVMX0ZBTTZfTU9ERUwoU0FQUEhJUkVSQVBJRFNfWCwgICANCj4gPiA+ICZyYXBsX2Rl
ZmF1bHRzX3Nwcl9zZXJ2ZXIpLA0KPiA+ID4gICAgICAgICBYODZfTUFUQ0hfSU5URUxfRkFNNl9N
T0RFTChMQUtFRklFTEQsICAgICAgICAgIA0KPiA+ID4gJnJhcGxfZGVmYXVsdHNfY29yZSksDQo+
ID4gPiANCj4gPiA+IC0tDQo+ID4gPiAyLjE3LjENCj4gPiA+IA0K
