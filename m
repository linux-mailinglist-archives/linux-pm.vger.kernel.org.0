Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAD723C55
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjFFI5P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbjFFI5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 04:57:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB58F4;
        Tue,  6 Jun 2023 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686041814; x=1717577814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qUKy12JrYl6g20WY14vqRQZRI0ojXrwgYvP7aGLIybw=;
  b=f0Qn6GBxd+zDgNN3YjpY6HUJAY3I0KK4C/HZgqYHJWYJyCLNtkvAqRfc
   W9l2FFxhZSXJClgL/Jwi/sjJG1NmbJYJSgDoKumDcTv/Ruqaelygi3bcc
   UIWsr9AfLX1fkEILhhAaGHaUuLEOkmv6G8rv0J3nZ1EFcQqHN3mhJjCfe
   gDbJ2ym/CKnUlF0FbImOIaJQAD5z00YotJ+E0xwT9imfhpct9Jkw50jEZ
   uNoPxELmx8q7ve4guPIHc0gqCQ0PmqwpOYMufn8F6SqpUJbu1ptk4oUpD
   AMk9t2ZTGam002HQofWzlBFe3abc+jJWPLSi6yzSl5jkioFiyJ3/jkQ1W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384917900"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="384917900"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 01:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039100482"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="1039100482"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 01:56:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 01:56:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 01:56:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 01:56:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 01:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2uOPHRGr38KtOUU0OAn9rDRfa/n2Nz8dD+0qe49oy0084wjFI9XpHSfz+W8CfukZTm0CbhlCgk/a5Ge+F+ic84dgipoEJvANZaPhmDOpxX4Clh0+Q7yvoPEnZBVgHidyoo6e2qfFgk21CzeKk3bfNb7zrPpFlCdvEF6wz4TbNuja/IL+60k+rV50hHckyod7gUDktnRvaR73VG1KBPcL0p65EdGgREPcOLJheU07OJ9CJsya9qM04moakzmKbikjejKQpcVCombm5DFhmXAvEv6C2qW/xl/l3TtPYHsNAY6zcHgjfdRHeetfwAlUN6NcaOyH2D9bmjyY5VmCQAWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUKy12JrYl6g20WY14vqRQZRI0ojXrwgYvP7aGLIybw=;
 b=VnRCbVZt9QOTXjxpavFPfPwrqISunOC227T6tY3gvwtleZHbXsH3vPzEunIx+v9de2dsBQAcAw7WPqusKBX9htBp5hO4d7vQneg8X4pRpdPs3aN+mU68/kmoegDrKlz1NtXE9VQYJpgmu+o3ipdzpfsnQNaqVXzIKO0KhpceSNGQE0InMEpPISzHHiO2Pwey2waMxDPfAB+l0DnH4pQGj/kTXtKZvpOmR0Ca5FYQDrVVZlij6jUl8/Pqx3om53JZl0sPJkCo42XWiUAp/FYeJkGGGAdGdF3hq3LhcSRmAk87J80eXm/QgIL9oppvNA7NomQCUwU/YdupqcHtYMr1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB8480.namprd11.prod.outlook.com (2603:10b6:510:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 08:56:45 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%7]) with mapi id 15.20.6455.027; Tue, 6 Jun 2023
 08:56:45 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Fix a NULL vs IS_ERR() bug
Thread-Topic: [PATCH] powercap: intel_rapl: Fix a NULL vs IS_ERR() bug
Thread-Index: AQHZmFAmLmrxw9Kv0UWkmgnI9n6Loa99eQIA
Date:   Tue, 6 Jun 2023 08:56:45 +0000
Message-ID: <8e34bb46e770408efd5b207fb293af7c06832a94.camel@intel.com>
References: <ZH7s0qNJ8a/KHjvQ@moroto>
In-Reply-To: <ZH7s0qNJ8a/KHjvQ@moroto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB8480:EE_
x-ms-office365-filtering-correlation-id: 9d21bec5-7b85-4355-888b-08db666bf4ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xhMKnAEowUbMDkxSB6Mlt4N7mj8lD/J+0fnhAHTYlNYfvDzxjL8twPAYnleYuy9PCGpvhyerFey7z0aiYYPbNeQWoFVdWLbOqBdGAF/Qz1MPkGsC6dsWV6TqpxwaGOygMFYjAIDRqrUX3+Xc1+FXDB8qBQfLDlYP3rCVB3eddACmYxAmtgmA74YtE+exx5lz/7Sz2y7sztDU1GysGmSJs7T0OT5U4kXsPXwAuAzf2OCLKPmXKUNP0wCpc/1ufYxoXnrIMc+lXYCtQm9G2tZO9iOjozOO4/xY8gUAP7DI09jWUxhOeHieddVKm/ZvxSdtMIKxGzwwgEPwPjcAIkezY3cLljHBx6EX7qG6r/niHI1pnmFAMvzAku3DrG/9WsSMIuDAjXgo5BLDzPc8pPaFbxJY5e5yzNb4Emhj3R+u5HfBBGBaxJxIJnLwLAPJ0r6B/a58ooEhiUSQ3FegfMpO8yfiKcCFafoie6CbdM8ZZGqZRzVJhwkBgNfckRy0cdfQ314qpJrR2M++jXcvCpVFKTpELcn3EKg8vK4LOKsQkezO9/r1Y+/6yTv8k6rOFyZb/prWu2bqZttOtEGoNa2IxA1SgAhuHRWDBWcw2Zt4GJvie3V+KMun+/h10iW1fyZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(41300700001)(316002)(54906003)(122000001)(82960400001)(5660300002)(2906002)(64756008)(6916009)(66946007)(76116006)(66476007)(4326008)(91956017)(8936002)(66556008)(66446008)(8676002)(478600001)(71200400001)(38070700005)(6486002)(4744005)(86362001)(186003)(36756003)(2616005)(38100700002)(26005)(6512007)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGFWcW41WFdUN0ZaSGhKTC8wcFhJa3VyQkR1NzNEbWw5QWdJSjJENDA4dEhp?=
 =?utf-8?B?eW12UDZoMHVxeFpQazBleVkwcDNnaDliWDRTUmxySG1vZEEvRlA2cE1JaDJ6?=
 =?utf-8?B?WWlKd25yb0xQYi9odUpUVldTMExienJqSGFwTTF2Tmx5SWFmY0UwUTBCdWh1?=
 =?utf-8?B?ZEw4Rmhmb0loeXQ3MnFvaWlHSmwxYmlEV3pjelRXc1k1L2VlTi9BcWRqYzJ3?=
 =?utf-8?B?S1cyZXljNWZlbEVRUzk0QmdtZzhMOWlxckJhTlNRM2x5enpMQ1FzNjRwRCtZ?=
 =?utf-8?B?ejlRb1J5NXkvaytmOTE0UXd0UGRseVpHNmJyelhPSFU0cnVyd1lST3dtci9z?=
 =?utf-8?B?QU16bStLYTZxbjJJa1BJU2M5ZytJS3hSY2NRZUtIT1JkeHVCK3BBMG9yS21y?=
 =?utf-8?B?QnFlSHdENFA3WDBKc3ViN29Ub1Z3WFU5K255N2dDSEhhMkZUMGdzOW01TW5C?=
 =?utf-8?B?Nk5IcStyalFIdWFwalBacTV6dVBhcS82TjV0bDMwcmFvZ1pkaHNZdUs5N3lI?=
 =?utf-8?B?a3NmeTFWN281MEcrSUducHAvNGpqRXYxaHBsWWxjcFZNUVNyUi94UTYyU0V0?=
 =?utf-8?B?WkVEMzI0ekltaUszcEVIaFBzd05TV2prTHpWTnQ4NWxkb3J0RWVPRFJNZG5D?=
 =?utf-8?B?SUZiYWdTVFFVa0ttaXBNSU5tVnVmcmMwSE9lb1pGSDg4ZTlyam9BU1J5aThK?=
 =?utf-8?B?MXZ1SFhLbnpnWGNVOElwd1kyYlMvYW5Cd0RBaWdRUSs1SlAvYU9IU1pWY2kx?=
 =?utf-8?B?UUN2ZHhyK0VsRWt1ZGIvZHVHRzduUkdIOHk4T2tXN1lIOWVTcEtkUjNTUTI3?=
 =?utf-8?B?Y2x3WXlQd2hQK0l2aUhBVWdnNDE5SUw3YXJ6SDNTMVFhS004RkdxakNUNzBX?=
 =?utf-8?B?em1jUU5iM1dhL0IzNXVnSUhydndRT1lpSjFRTVhzZ0U0cS8wY3lnNkdMd1o3?=
 =?utf-8?B?cTRXRFgxYjBqNThoQWxOREZkZGRKRUx2TFRBU3ZXNXltcSs5SXg4UTJTcG5u?=
 =?utf-8?B?VW9nQzREaktsQWtpbVQrdzQwKzQ2NEZBNi9xT1hHRHcwYTljOU04RUIxUEpR?=
 =?utf-8?B?d0k1Ty8rSGlPb1c1R3pqTmxqR0tLbFhFclFOWUIwMTNMQ3JhZzluUUNHNlA1?=
 =?utf-8?B?MFBNbm1tUnM5UFBIaUJuVzVZRjhLMjIzNENmTG9XcTJRUUhjdHZvaWNoRWZo?=
 =?utf-8?B?WkVhbUdBYmlablh6ejFIZE9OM1RTQ3BVenVmR2dpVlFSZnNPMVNtNGdQblVs?=
 =?utf-8?B?TDVlZDd2TGxnbU5zRXhwcVZrKzJRcmhMY0kxdmpha3NsZjZyUGRkNStoYkFk?=
 =?utf-8?B?eVFibXhiUURFU01na2w0dVhsNms3aTVUaGQ5Sk9zK2Rjelpwc0J4SU9JM0NM?=
 =?utf-8?B?QUhJeXN6alZGeS9JVWIrZmlXSTNPVkNnbVUra05lSGtwdWhpUWRYUmdTOTZv?=
 =?utf-8?B?UUxpNGxuSTdsOGlVV1dDY3lNbzRmVkpMNzRlcDJ4bG1RZXo1UlljelUwMDdI?=
 =?utf-8?B?YWJVZGxMYWtPNHFJVVpjRjdtaHpCK2JFZHVPWkhDZVRUc2JQUnVtN1NXMGNs?=
 =?utf-8?B?ZnhGd3VpMjNyTGVEREtCaVh5U3VJUHJjMmtMMVErN2tjOTNEeC96TXNsUVZP?=
 =?utf-8?B?VVdvajAxMVl5SnhTN0NrSTNQRFFtS2dHeHA4MnhlaldJZmhYNWZRZGV0L1B3?=
 =?utf-8?B?a3J2Ti9ZUms2aGJaejJVKzZMa1hUcWxUYm9IWExzSGdQZUZ3STdxN2xVZDVI?=
 =?utf-8?B?SGJUalJtMXowOVFydkh6ZWpzVW1tRmU5dWdPVzZuWlBnQUs1TThjVzk2R3Ix?=
 =?utf-8?B?RzdtZWhlMXZpYUV6SFBtSnBwWTl4ODRrUUo1eGNYV3dGNWhDREo5MXlTSmtV?=
 =?utf-8?B?b3ZFUGR0QjlCaFRnQ2wzWjBLNE5JRU1Scjh0QmdsMlVtcEVaWlp5Mlk2bkNv?=
 =?utf-8?B?TXpmSk9xZncydnpTcGxwa1h1NlgycE1za1NqOGJVcFZ2US9tWUpnT3EzVm9u?=
 =?utf-8?B?WFNuTWhyY0ZqUDRXOFk0UTJSNXp2Q2RXWlZCa1RjQXlKSW8yckVJOVROU1pG?=
 =?utf-8?B?NHg0RHhRYjlESFpxUWM4UFk0TlZNMXF1Skl4bVUwWjVDTXlkR2VUQmpRemha?=
 =?utf-8?Q?R9SF1phk8K7Y4AXJEYGyUyhl+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <107BDA7DFB0B184692D4610A4510AEF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d21bec5-7b85-4355-888b-08db666bf4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 08:56:45.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsQR02DbZIgIR4BxOcfiK9FlDKQu7OFZRwXk2ADaIBXRxrBFsTung9ZP4ysLgo45bRjKhjMIw0u3CSUl/7Mvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8480
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDExOjIyICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGUgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgZnVuY3Rpb24gcmV0dXJucyBlcnJvciBwb2lu
dGVycyBvbiBlcnJvciwNCj4gaXQgbmV2ZXIgcmV0dXJucyBOVUxMLsKgIFVwZGF0ZSB0aGUgY2hl
Y2sgYWNjb3JkaW5nbHkuDQo+IA0KPiBGaXhlczogOWVlZjdmOWRhOTI4ICgicG93ZXJjYXA6IGlu
dGVsX3JhcGw6IEludHJvZHVjZSBSQVBMIFRQTUkNCj4gaW50ZXJmYWNlIGRyaXZlciIpDQo+IFNp
Z25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCg0K
QWNrZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVp
DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMgfCA0ICsrLS0N
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMNCj4gYi9k
cml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfdHBtaS5jDQo+IGluZGV4IGMwMTYxMjdiMzQ5Ny4u
NGY0ZjEzZGVkMjI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxf
dHBtaS5jDQo+ICsrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF90cG1pLmMNCj4gQEAg
LTI1NSw4ICsyNTUsOCBAQCBzdGF0aWMgaW50IGludGVsX3JhcGxfdHBtaV9wcm9iZShzdHJ1Y3QN
Cj4gYXV4aWxpYXJ5X2RldmljZSAqYXV4ZGV2LA0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoA0K
PiDCoMKgwqDCoMKgwqDCoMKgdHJwLT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZhdXhk
ZXYtPmRldiwgcmVzKTsNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCF0cnAtPmJhc2UpIHsNCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FTk9NRU07DQo+ICvCoMKgwqDCoMKg
wqDCoGlmIChJU19FUlIodHJwLT5iYXNlKSkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0ID0gUFRSX0VSUih0cnAtPmJhc2UpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGdvdG8gZXJyOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoA0KDQo=
