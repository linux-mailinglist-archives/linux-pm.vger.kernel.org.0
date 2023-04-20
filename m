Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5536E8C9A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjDTIWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjDTIWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:22:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C2244B0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978954; x=1713514954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fyAmd9v6qNSHBEMIv2U5FaCXIimT0udAffk63vMGys4=;
  b=N1wSiHIM+RsF2UEsmRF05bwmHCC/Rb4TF9Rv/kKnyf73WRQ+aT2Nav6o
   W3T5/rCnxadEJLjcA2pWcSuDHE2IPdNPEUyFZdFFZoj7uHQfgcHtdn20+
   kDmLz/vY0SoVGhj7sLyE8cKfvxxs1y4AOBPW9sM52aYMdKHMZ4MSftOBF
   57LNofadZ0kwXPEXjHroTQCBmRmfnLQ0psIdJX6KOkWFQZrrZyWMpG1pr
   1n+X2xclMhVjK1HA/L5pDGsosyHEqmiRVs9aXZGanaBTWsRTCa4U1J8XS
   gdVWSJt0PDSdgMSaAuLtkTecdw2qYEumJMczhULKS8k5zPC02wT8TFYxm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431949554"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="431949554"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691815334"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="691815334"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2023 01:22:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:22:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:22:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGUmimuu+2yzK44B7zaFv3seH0J5VTSkN2maShQy9kZ9LF5XkOuRhEgl12kSh8Ofm+xfHYHc9A74jypEGVNvnqZt/aSAbtm1DpI/P/QdgNulUC1ESUmxHYhv8/+sF8835BsrgCDwX828t+ydCf7JoeNDwXlZR2ZIFUDyUM6iI72AQIZ0FzEekwJURH2NKv6UQa4UuxYOwFf348T5tvxdydIfxh3Mb1KDL/Pw82RWoxCbO0Oc1d7gmiPr9gyy/6noYJdutYsHxN2K83jBYJvPnwAd/E2F3YMltnvmmX+SlbVsmwqN1lmprok+H+U3XyGyGZasAv6flmE7jk1UqMm7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyAmd9v6qNSHBEMIv2U5FaCXIimT0udAffk63vMGys4=;
 b=c4z0ygtJl21tS4QBJOylzVM62KRCEVz+j5m+f4edf4h4XrFCyHd6FMxImQ5F0b5ZXYLjKUN2cSbvV00amTQYJOOj84fS64lQmF4pBjcmhPzBY6f/SnDjH1kA4Vp7OuoE+YqA1Y/PJ47ht7Py6B14LR8WyLBS3Rs3r6e2ZehqRz22qBcCfEfOlWB37YjqjiPzLKx5eVKxjscepREBbYJivjFa3KsAe5+T0bGmDjPaT9fdFbETjq/6K6M0iWff3+zxH2VbEfiPkRJ+cdDVZQvaVsy0o4mbZWEceci4WTOJbWEBCrss+bbdcXb4D9N8x7toObyBN77iMwp7ITrCc5DAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com (2603:10b6:a03:3ef::16)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:22:31 +0000
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da]) by SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da%6]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 08:22:31 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/7] intel_idle: use pr_info instead of printk
Thread-Topic: [PATCH 1/7] intel_idle: use pr_info instead of printk
Thread-Index: AQHZcs0GkGO+tYRAhE63pj7En855uq8z3OUA
Date:   Thu, 20 Apr 2023 08:22:31 +0000
Message-ID: <3e87964c4a3b9a4694e0a3a334540e47bad1fc71.camel@intel.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
         <20230419143947.1342730-2-dedekind1@gmail.com>
In-Reply-To: <20230419143947.1342730-2-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0033:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: b3133437-def0-46d9-428f-08db417862e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSyETK3Wgfnn6UWJcZJVHX+Dvw0CKGe4UiRjhZBPr6ooqG20Ax4whr5V+oREGkPG7Wql7cyR9hm8Eo29hbHc2I1NDEijTGV2QESt3xJfJ4A+s8YtHDgotEGkYVh2bptqvnoSANdj6UukVCx9aPYXqxU5dylgoFg4diwEiYXXvOhJFHCkAEQBfx0DhIGzJB3lg/x5mhIpZZs6UGCvFrKLuit+5xVPqRBbw5L7vIc0/vbQBWIbm0T0EK3J86eDuHpTPDL7hPuOfbQiyny8IF0JhCoe+bq7JvbIW0UgoiQ9G7i0WfXxP3Q+4Ad1YROEwjOrxooUixRcdLs6Q+qHRDbzY63dKqj21SKPb8JCkkr9bxjpC1yUgUSvcyg0Ou7dul3o63rWDJ0PEmsqHc82ka6Owz+P7+kjkEyI++1kmhFQYXapU4wWb9rRldyVkhIuOpA2GYLV0NVeAEBE6wtZkHCz42ouASc7Ybeh4794qAOPAn9pdIq4CM3HS9iR76X8eu0FeDBY/qFBxW1jlUlciEGDiOQQ9x4OWfCehm/0JNhkdVi6TVFdYV/4geMuc5gb7KmKIE7WkphDSV/v3N+l1WMbMBbT6r2a2+EtXdIlVcPnn1vLNNl/tlZXLWdyq5LVs5Ry
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(36756003)(186003)(26005)(6506007)(82960400001)(38100700002)(122000001)(6512007)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(71200400001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGhDODIvSHlKYWt3TmxoMFA0YURaQ0xlZllFNzlSNXBIbk9NS3pTTWIvenJq?=
 =?utf-8?B?MkxJUjR6UEpwTWpHaC9MMFZxcUdpNlF4YUpkdVVBM1dLOGprKzRmOEFINldr?=
 =?utf-8?B?UGNuV1duWC9BbTkzYThWanExdUxBMVFDaXNWYjk1aGJzU3l4d25oMGxoRVBw?=
 =?utf-8?B?NkZvOUZxM1JQYXV3T2JGanNYZmJ3QWlIRUhtYzhBRXZpNEUvdXVnZWgzZDRE?=
 =?utf-8?B?bVluRVBRbk9VOW0wRGZ2Vk5oV2dTcERUaWtyTUxxa2VpaWx0QlI0ekJSeXRl?=
 =?utf-8?B?a0piNEhpL0lYREVUT1UzQm8xMGd3T3dab2NEcm9ZY0xUYmUwRks3aDA3SW9p?=
 =?utf-8?B?d0Z5dklFaEpHMlJDV0JpZ2llUXQrVXplb1hEMWJSYWtyeFh4ZjZCRWJDMUdT?=
 =?utf-8?B?QThaU2NndkJGNGYyb3J5Z3BORUF2MWtzdmNIMDRkaWh0bk1seVhnVjVubWh4?=
 =?utf-8?B?am4rM2VnV0hCVVlkTWZuOEFMWUhxODhmNW1iaWMySk5iY3pBcExrQlcxRWpQ?=
 =?utf-8?B?L3B5ZmNDVU53N05ROThsTmZVd09yTTNDNm82cm0wZVh5OFduemVvWUZ2WjNV?=
 =?utf-8?B?aGg4RzlxTzhsOGN5SUg0YzFYemZCQ2puNkQvYkRXYURRNUhDM2dIa2E2a2Fk?=
 =?utf-8?B?SVBIRDM3UUw1YUNNaDhOM2o0dG1aL3c0M2EzdW1WVWYxYVN3Wk9PTlFBck5Y?=
 =?utf-8?B?SWVldG1CejNqOTdxb0NQbWtOVU56YnVBNmJ4SFQxTXp2VXJjbHpDdnQ4MVV1?=
 =?utf-8?B?TnUrNEtWWGJRSkVqbTM5Z3h2ZnJUaFdJdGNtZ1RteFBkVm9lTkx6VmtkQkJi?=
 =?utf-8?B?WjVFWHNmWDQvVmpPclN5Tk9IekNDRXJaS2FObU83SHZJZXZLSGZvcStkQ3JP?=
 =?utf-8?B?bS9aOGFraW5Xam4rNXJVbDdIcHQ1NXMxYktON1RKL3praUdPVkp4aGpnSEpq?=
 =?utf-8?B?S2dXZVVkNGQ3cUp5dThqMkMwSjNKZCtTOVZmSWFFWGcrVmdiZmgyMEZsa2sz?=
 =?utf-8?B?bUVjYUlRaVpFdDZBcDdxeWp6dzFQRk5iZGRvc2dhdmszWmZjSWVidW1sTlBF?=
 =?utf-8?B?OU9uUVVkblpFK3ZYbUdXVHRsWlZpQWtFTjVFbjRnK2thckc3RXFYcFozRVdq?=
 =?utf-8?B?bUwrYnVRN0FOYnVUU2FENnBwZ2pXdDBmMk1ZTGgrTjVMblZmbzJ5akt0bHBt?=
 =?utf-8?B?RUZXd01pUmMvTndEc0VjNGlmaFVBMURCbythYnovaURieWg4VEVQeDR5VnJY?=
 =?utf-8?B?R21lYXFlN1piOWF6T2dJSTNJRGlLRXdyNEhWdW1aenlNeEJVMElxeTZoRGZq?=
 =?utf-8?B?ME9Wa2ZQa2ZlL29UQ2JOdzd3QkxJdkhQVXg1TU1UU1VCQXMxZnVDWDh4aUth?=
 =?utf-8?B?eFIzeGtSWmlvTThPd2QvQWdqK3M5RHZudnM2SExSdmYyUnVIaUdxS0Y2L0dO?=
 =?utf-8?B?TkorSU15YTBBK1NiMDdYUTBpWGd6ajdVVGZXbTJwaFlJT3ovaEhXUzNBb3ls?=
 =?utf-8?B?MG9IQlowYm1LaDV2VEpLbzFLTCtzSGdtQnowcE04TUdNR096U1FmZllMdFlV?=
 =?utf-8?B?RHF6RTFJRzFRV0k3VlVEZVMwWi9KU1hKL0RtWGlxVGxmNkJtaGFKZGx3TFg3?=
 =?utf-8?B?bHdjRzVnM0lXbzJvYXhZTmFxelV1NndjQUxNamR1SmhrOFBmbUNVYTZTOHpD?=
 =?utf-8?B?RllWWEhCN0lQbkFlOUZiS08rVUtKNm51VUh6aGE5b2lsSDlGM0NYa2YwNERK?=
 =?utf-8?B?cUU0YXhxMU9Kektndm0xcjczZjhSUkgra016NjRuWVQ0SUpYcE9rU2VjSFhK?=
 =?utf-8?B?emtCdDV2dlo4SEtEbHpxN29uSDBjWGRIcnYveXNPOC91Vk1sVEdpM2NBa3Fn?=
 =?utf-8?B?R2tPVllVbC9nSW5lS0FSbk4wT1k0U1hwMnY1amxRa3pGVldrR0I0dW5MWW1y?=
 =?utf-8?B?NythWVprWm1QQzdOMFBlcXdLcnhuYmd5L0JtRCsxbERueGt4a0hwVDE3MHZR?=
 =?utf-8?B?SDlXRXhpZG9SLzhveXYyQm44K1J0M2FXUUJvNDN4a1d3M0RWRDdhVEJYV3pV?=
 =?utf-8?B?R3c0ZFZjYTk2bzhTdXIvYXR6NEd5K0UrNFJ2Tk5uZzVtWHVxMERWS0RtYVU2?=
 =?utf-8?Q?k4b57JNwRiBflf2gINsRR3CR8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C0F68932D80F4D81E277960479A1B2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3133437-def0-46d9-428f-08db417862e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:22:31.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOkrgbeQvuL5SPszGjVs5DslvT/qb+nxGJNFYyBvAnXytHgcn1I7XRfWjX7ueygUL13xC433KAPxM0zQBTsUVg==
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
LmNvbT4NCj4gDQo+IFN1YnN0aXR1dGUgJ3ByaW50aygpJyB3aXRoICdwcl9pbmZvKCknLCBiZWNh
dXNlICdpbnRlbF9pZGxlJyBhbHJlYWR5DQo+IHVzZXMNCj4gJ3ByX2RlYnVnKCknLCBzbyB1c2lu
ZyAncHJfaW5mbygpJyB3aWxsIGJlIG1vcmUgY29uc2lzdGVudC4NCj4gDQo+IEluIGFkZGl0aW9u
IHRvIHRoaXMsIHRoaXMgcGF0Y2ggYWRkcmVzc2VzICB0aGUgZm9sbG93aW5nDQo+IGNoZWNrcGF0
Y2gucGwNCj4gd2FybmluZzoNCj4gICBXQVJOSU5HOiBwcmludGsoKSBzaG91bGQgaW5jbHVkZSBL
RVJOXzxMRVZFTD4gZmFjaWxpdHkgbGV2ZWwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydGVtIEJp
dHl1dHNraXkgPGFydGVtLmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCj4gLS0t
DQo+ICBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gaW5kZXgg
OTM4YzE3ZjI1ZDk0Li43MjZhMzYxZGE0MjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWRsZS9p
bnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KPiBAQCAtMTg5
NSw3ICsxODk1LDcgQEAgc3RhdGljIHZvaWQgX19pbml0DQo+IGludGVsX2lkbGVfaW5pdF9jc3Rh
dGVzX2ljcHUoc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYpDQo+ICAJCWRydi0+c3RhdGVzW2Ry
di0+c3RhdGVfY291bnRdID0NCj4gY3B1aWRsZV9zdGF0ZV90YWJsZVtjc3RhdGVdOw0KPiAgDQo+
ICAJCWlmICgoY3B1aWRsZV9zdGF0ZV90YWJsZVtjc3RhdGVdLmZsYWdzICYNCj4gQ1BVSURMRV9G
TEFHX0lSUV9FTkFCTEUpIHx8IGZvcmNlX2lycV9vbikgew0KPiAtCQkJcHJpbnRrKCJpbnRlbF9p
ZGxlOiBmb3JjZWQgaW50ZWxfaWRsZV9pcnEgZm9yDQo+IHN0YXRlICVkXG4iLCBjc3RhdGUpOw0K
PiArCQkJcHJfaW5mbygiZm9yY2VkIGludGVsX2lkbGVfaXJxIGZvciBzdGF0ZSAlZFxuIiwNCj4g
Y3N0YXRlKTsNCj4gIAkJCWRydi0+c3RhdGVzW2Rydi0+c3RhdGVfY291bnRdLmVudGVyID0NCj4g
aW50ZWxfaWRsZV9pcnE7DQo+ICAJCX0NCj4gIA0K
