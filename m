Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD36A730D49
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jun 2023 04:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjFOCfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 22:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFOCfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 22:35:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81292110;
        Wed, 14 Jun 2023 19:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686796536; x=1718332536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NeYThufZqc76Y2yKiHihuhnBGvyN7TpimkCuRXPNCho=;
  b=mBi+l7jvgGd2nZiBXbQAXkpng3fdcd68Ds6EoGRolUdLn/WywzuQjZ//
   cLmPD/5KT5fHk589wUFK35/vfEWZsOBiCuXyqqdnUeys0wMPsNEe0TTgC
   9zJn99l4lF483WDaQUBHfaINU+WpL1A2E05NwNMZN7C3mwAIpAPwJkGWK
   Y8VkE4r2UyZUc6ycaav+gbABXgJIEazItcI+wBor4MiExXsdgZouSrtQq
   UgKBBSZdbLZ1dKxgb6t+GbmK6iDjJ7zrnvagHNSOTR2GV1ME2jifCV1Cw
   5zjGINqNAcCBlj/4FH9xdGUDfwj4MABNHzSWSVQr7cm91AY8ekgTM14v9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361272175"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361272175"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 19:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="856754795"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="856754795"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2023 19:33:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 19:33:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 19:33:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 19:33:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 19:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4LrpyLzTeC8rthkv++f2y6Ll8tLYl3AHp+HbQCN6UkCWU+Rs9Esun5YYZogWffc2JqETS5gjfXT7zYhMh4cZRzENwEBCLkbSjetvjdLNjL11BNom2pgL+w23EYcquiCaaViD4QWbJzs2HRZdJsTO4Ju/buJ6WIpIMNYCdOb1DejLvg5dx/Wn7wEcdbQ+6LMRoO3qs9SggLIHxnHwIfZKnTHkYtG8kU3T+aYyUQhDUj3WGmwy/weO1B2GgKey0rvJiWx8bka4zE/MPUjrolD2E4M5hkFeqpvimw/JyTpRHNZ3JMBwDoP8GKUhCRM82x9fFvrhRyTEZacHNLd6Ma84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeYThufZqc76Y2yKiHihuhnBGvyN7TpimkCuRXPNCho=;
 b=HUF79lDom1juAtPolB1x38V18aJglU2H40Gt0oOc/RZIXXSNDBaJSQxN2bf/atTzKwuWdW7RnRV+3s7AqUZPEjl1P/NXN022uWN7pUWV17KVrZLOzZuOpcq1J8azCaijZwoJojyiZizYBJQRj0GS8ogzxjwceSgaIUUoEVQqfKBNjYaH7ZAf/jwqjkklJ0i7OsPvYPIYGPT8PFQAGB2QgPaYRxgh0M/L2SH3FLuWxvp4Pq+TcG+9aVmkp3BtkZJFL++Dm8XooQJd/HYuc6RQzYM0UuWqdWzFVMD1McT8HuB8D5IjxeUrLhcQRP3JbftNPkgoxdZLhXW7JkfnwXRyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18)
 by SN7PR11MB7440.namprd11.prod.outlook.com (2603:10b6:806:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 15 Jun
 2023 02:33:47 +0000
Received: from SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::1500:c465:9094:c772]) by SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::1500:c465:9094:c772%5]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 02:33:46 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "b.krug@elektronenpumpe.de" <b.krug@elektronenpumpe.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] thermal/intel/intel_soc_dts_iosf: Fix reporting wrong
 temperatures
Thread-Topic: [PATCH] thermal/intel/intel_soc_dts_iosf: Fix reporting wrong
 temperatures
Thread-Index: AQHZnqgkQJacw38/7kqic4Rx2B9wPa+LJkqA
Date:   Thu, 15 Jun 2023 02:33:46 +0000
Message-ID: <5e2a0ed13daff9b73f0754ea947bd832b3503cdb.camel@intel.com>
References: <20230614100756.437606-1-hdegoede@redhat.com>
In-Reply-To: <20230614100756.437606-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6604:EE_|SN7PR11MB7440:EE_
x-ms-office365-filtering-correlation-id: 0da00062-7767-4ae8-302c-08db6d48f1b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GSaukWI7prGrXp0Hiq97BeZz+bhlKujM6+Fu5d6n71LARAnpR573KqrMYXfA7R4prhXYSEVCyYiszjZLAF+/V6bC2QMS7oW/B0jvPE0bW12xs5kW0IkVfY2g2w7vUrdRp7cYLvmBTPPvhW1p1nzk95nMsALik4SxETOzE8FUbICjJcSAbP6yTZdTSjjlstdX7jsJDFFRGwz6tyHhepS3St4QH+ue5c97jqLDai2BOpnh5iCSTI6HtmTkOK2ybKFPgSa4nlE2i+nfX+91WV1iZE5ucACDMiA0/N5Dw60+4ItxnBw+5u2V1OjQSKtSyPzxDN04yQ/PAAYFEURkRKmC2IGZRds47z1EEzH3CRDGkyKqtPP6fNrSqLaEGVVV2qhWJGxwnZwCaqJbXStigg7jaRyktzK9H8/vCDvzNtSmfdGFjqtRza0oxeBztUVds8H+Oafb5X9uWktwsh78eBlkS0sfq0q6qrZfdQMqpKoiAtvrHyHvGiSO1qH38dgFI2C+0KzOukfo9F6t/NFkZyLzUGMXNDblCjezvRNHj3mXiuKKVECX5076HbUcJas3lH1DPpW8t+zuY9JmhuUX9uWYpb+DWviM3ubo7cLLC7KfK4+HnoHDrlty0qEseZGm6l9D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(54906003)(122000001)(110136005)(66446008)(71200400001)(82960400001)(41300700001)(8676002)(478600001)(5660300002)(8936002)(66946007)(2616005)(64756008)(91956017)(66556008)(38100700002)(66476007)(4326008)(316002)(76116006)(83380400001)(186003)(6486002)(6512007)(26005)(6506007)(86362001)(2906002)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG1tNm4yOXNJM1FodEtEeGw4NjNHN1paS29zRVZTcGJIZDRCWjlvamQ5NDFX?=
 =?utf-8?B?b0ZvNjFzamRBanRoaTUveUl5OGY2RG1GeHF2dkV2UFRpcmxZQzFQcExReEZD?=
 =?utf-8?B?OHI5Qmx1UWZCbmVDSmFzUGJ1WFlXSDNDckRrejYyUUQzTWw1c0xOSkt6TWVN?=
 =?utf-8?B?VHE0bit0MUpVMlpCenIvOERWQkw2Rk5JWlFOUjJrdjIzMjNFZlVpenNnZVdk?=
 =?utf-8?B?Yjlrd2ZteTBTM2lFMXpjMXg1NWJhR2Q2NGFUUU9rQjRzekZpOG4wTndta0hy?=
 =?utf-8?B?MUFoSDJNZDlRQnc5VlR1UVpHeXFlcjNERDZqV0JPeExTS0V3WGdjTW5qQ0VL?=
 =?utf-8?B?aTNKNjFuMTJNQUZNUnlhOFFoRG02Y0RHWGc3YVI2cmVEVXlaRUhYdEE5a0JU?=
 =?utf-8?B?VURtbDFpT1ZUVVhtOVhBRklNalR3Q0ZoS0VOZFVsb2JMYlpNYTJJa3ZxZnpz?=
 =?utf-8?B?ZWpjSG9SdjA1eEhiVTVVVklyMWEycTJacC9xSGJOWGhEZDNZSXJRdHRQV1Jk?=
 =?utf-8?B?VHBBMHgySjljWjZVN2w3ME5jWWdqRklsYmdJUzdPU296L0xLKy81WnBsVzFK?=
 =?utf-8?B?bklTdnBIMGN0dU8zUkZTdTdsTncwV2c4N01RSFd4cVpjekd6aG1HTXdFSUpn?=
 =?utf-8?B?ck9mejNkSE1NaUNkUWVoOXJ1eU12b0VGS3ZTWU5lbnQvU0tCZjgwMlM0djB5?=
 =?utf-8?B?Qm4zZHpiTWZSYmRHOTJpVm5JT2NhV2tld2pFRWFhVzc5TlhjRnZhQk5FTnIr?=
 =?utf-8?B?a0UxcTNSaVNGcVRFREJCQUZaNjUyeXdvT3JLOTJTRDJuQVBCK2tPbHJ1eVB6?=
 =?utf-8?B?Q1RoUkRxMWJzNWx2MjZoREFSdVdGeUs3SW9zemFaQzVQU3REVkwrenI3UThV?=
 =?utf-8?B?SVRjZlE3Q3ppaER6UXZMbWRPMnkrRHJ4OTJ1YWRJUkdlWWprakZsdmZJSlhR?=
 =?utf-8?B?c3Q3UzhkVDVDNHJVSkMxS0hyUVRHVWRkbm85NFVpTkdGOHViK3NDaGowNGRL?=
 =?utf-8?B?eHkvdGx5MEpwNGVXall0ZjBGYVdwSjhCdDNucFlhMkNyZnZBdU0rbml2czNY?=
 =?utf-8?B?RVdhaFJ4S21kNGFqc3F1aERLWHpBd2NCOWtrUHJjdGVlNG5TRGptbElmKzZo?=
 =?utf-8?B?ZHBhYkg2ZUdMQ2ppMHFmUUxpeWhRZitkdUs4Y3RnWU51MVRnK25ya1lmMEd2?=
 =?utf-8?B?RDFTejdFU09GQVovaEZ5OHgweUxZY3pPa0FkMXB6cm04eDRlaFQ3cWFEbE9Q?=
 =?utf-8?B?ZzdPMGljeUNaOCs0cXRNQ24xM3p3SzlEcHowRmZGYWgyc1ppQUN1K3ZidzZV?=
 =?utf-8?B?SGcrNlp4UEl3OUV2VTR3bDhwSnVBRUszT1JBUVZyMVlSenZCUFpXVHlXM2gv?=
 =?utf-8?B?a3dFYzdQZ3B6TXVlS2YxMHJGbmFoK2FpSXFJdGZ4REFmOVJjN1JhdzhlZDg0?=
 =?utf-8?B?blZIYkhCTXMxVFJNTzIxSmhZVkx4aVkweGI2WmRoODhSSmRNUjZlSnorVEtl?=
 =?utf-8?B?RXJVdi9xUGUvaWIzVEdscnhTMDBSY052Q3c1R1RGUzhhT0N0RUpTQUg4L1Za?=
 =?utf-8?B?a1ZBNXdacnBaUnVnUkFRMy9sOURBbSswTU8xM0l3dnJSZjMxV1JBcXRpZnRT?=
 =?utf-8?B?WnFkbThCYlNUYWZrTDJJdWdNVHdNOUs0VFcvR1Zqb1cxanhhYXBJNHloVjdZ?=
 =?utf-8?B?cGM3K0NlaFRuTzN6YURWOGd1ZDR4c2M5b0U5ZjdaMkhURWtPZWdRR0ZxWkpN?=
 =?utf-8?B?dit0TzMvMFhWWVFmenFXVS9VTjRZRHl0ZWxabmlnSlpzRis0MUNSU3NNTzhK?=
 =?utf-8?B?WDZDMnUyWTd3YUhzODZIUlY0Ly9lRzhqS3BONXNIZldvbXJaRjdzb1Rmc2Zl?=
 =?utf-8?B?YW1ZZitKWm5CNG5MWjhDWklZMnlwNXlFaHhKQkJNV0o5S2VrYUJnOEZyOVRP?=
 =?utf-8?B?cDZna29NaXdHcWFkODN4OTJhSUdSL2VmUzJCWlptYi9kU2hWVUpZNjVHZVZD?=
 =?utf-8?B?SGIvSi9IcHE1Y201TXM0bUMvN0N0YUFGWWYxcjdLUmdLZG5RTDNGNitPWmky?=
 =?utf-8?B?R2tBZE1LOGpJZklIbTByRldZZ0tIZXJTUzBVekFRVzFEelo1d2I0RWxFeFEw?=
 =?utf-8?B?M3I0NGYvNkIvbEY1UEo4YlpvZ1FlMWdmZkdIekJsY2Z6WnFYbHlZMG9sekJv?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36411A0BC053C04D9B79905D1B046FD1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da00062-7767-4ae8-302c-08db6d48f1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 02:33:46.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOyzTVZ6crzoK7QUm7pBABSLYCl/F7poAmACsYXyNrd4Qj1+9a725CZ9+3U2rcmDA81w/N2JG6aNMVmz9X8LTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7440
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEyOjA3ICswMjAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
PiBTaW5jZSBjb21taXQgOTU1ZmI4NzE5ZWZiICgidGhlcm1hbC9pbnRlbC9pbnRlbF9zb2NfZHRz
X2lvc2Y6IFVzZQ0KPiBJbnRlbA0KPiBUQ0MgbGlicmFyeSIpIGludGVsX3NvY19kdHNfaW9zZiBp
cyByZXBvcnRpbmcgdGhlIHdyb25nIHRlbXBlcmF0dXJlLg0KPiANCj4gVGhlIGRyaXZlciBleHBl
Y3RzIHRqX21heCB0byBiZSBpbiBtaWxsaS1kZWdyZWVzLWNlbGNpdXMgYnV0IGFmdGVyDQo+IHRo
ZSBzd2l0Y2ggdG8gdGhlIFRDQyBsaWJyYXJ5IHRoaXMgaXMgbm93IGluIGRlZ3JlZXMgY2VsY2l1
cyBzbw0KPiBpbnN0ZWFkIG9mIGUuZy4gOTAwMDAgaXQgaXMgc2V0IHRvIDkwIGNhdXNpbmcgYSB0
ZW1wZXJhdHVyZSA0NQ0KPiBkZWdyZWVzIGJlbG93IHRqX21heCB0byBiZSByZXBvcnRlZCBhcyAt
NDQ5MTAgbWlsbGktZGVncmVlcw0KPiBpbnN0ZWFkIG9mIGFzIDQ1MDAwIG1pbGxpLWRlZ3JlZXMu
DQo+IA0KPiBGaXggdGhpcyBieSBhZGRpbmcgYmFjayB0aGUgbG9zdCBmYWN0b3Igb2YgMTAwMC4N
Cj4gDQo+IEZpeGVzOiA5NTVmYjg3MTllZmIgKCJ0aGVybWFsL2ludGVsL2ludGVsX3NvY19kdHNf
aW9zZjogVXNlIEludGVsIFRDQw0KPiBsaWJyYXJ5IikNCj4gUmVwb3J0ZWQtYnk6IEJlcm5oYXJk
IEtydWcgPGIua3J1Z0BlbGVrdHJvbmVucHVtcGUuZGU+DQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1v
ZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQoNCkFja2VkLWJ5OiBa
aGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCnRoYW5rcywNCnJ1aQ0KDQo+IC0tLQ0K
PiBOb3RlIHJlcG9ydGVkIGJ5IHByaXZhdGUgZW1haWwsIHNvIG5vIENsb3NlczogdGFnDQo+IC0t
LQ0KPiDCoGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9zb2NfZHRzX2lvc2YuYyB8IDIgKy0N
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfc29jX2R0c19pb3NmLmMN
Cj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfc29jX2R0c19pb3NmLmMNCj4gaW5kZXgg
Zjk5ZGM3ZTRhZTg5Li5kYjk3NDk5ZjRmMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1h
bC9pbnRlbC9pbnRlbF9zb2NfZHRzX2lvc2YuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50
ZWwvaW50ZWxfc29jX2R0c19pb3NmLmMNCj4gQEAgLTM5OCw3ICszOTgsNyBAQCBzdHJ1Y3QgaW50
ZWxfc29jX2R0c19zZW5zb3JzDQo+ICppbnRlbF9zb2NfZHRzX2lvc2ZfaW5pdCgNCj4gwqDCoMKg
wqDCoMKgwqDCoHNwaW5fbG9ja19pbml0KCZzZW5zb3JzLT5pbnRyX25vdGlmeV9sb2NrKTsNCj4g
wqDCoMKgwqDCoMKgwqDCoG11dGV4X2luaXQoJnNlbnNvcnMtPmR0c191cGRhdGVfbG9jayk7DQo+
IMKgwqDCoMKgwqDCoMKgwqBzZW5zb3JzLT5pbnRyX3R5cGUgPSBpbnRyX3R5cGU7DQo+IC3CoMKg
wqDCoMKgwqDCoHNlbnNvcnMtPnRqX21heCA9IHRqX21heDsNCj4gK8KgwqDCoMKgwqDCoMKgc2Vu
c29ycy0+dGpfbWF4ID0gdGpfbWF4ICogMTAwMDsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChpbnRy
X3R5cGUgPT0gSU5URUxfU09DX0RUU19JTlRFUlJVUFRfTk9ORSkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBub3RpZmljYXRpb24gPSBmYWxzZTsNCj4gwqDCoMKgwqDCoMKgwqDC
oGVsc2UNCg0K
