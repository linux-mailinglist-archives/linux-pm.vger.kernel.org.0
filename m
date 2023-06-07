Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7087255CE
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbjFGHgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbjFGHfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 03:35:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230BF1BE8
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686123276; x=1717659276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VaH7RqnCTFnvrqOsKpb6bpbWqwgBmEL0yf3zG0Cv2dc=;
  b=hepq3LyVD6kGaByURBMz7gueER7E1jQGa74VONhzSdgWcqC594oPqolm
   YsMXZ+uwru7eUVQBErK6pHxM8ERPaZQz2wa5u5YFxR4kTMnnCo5ZrG4eN
   TgYj3nFeluNtbY6g28P5pSwCsIMXBmv6WGaGMSENj0PnoOCeYhDuSnX56
   rB25OZyrI+uDEhQ83iJO1VuNQNfW11NNtk6HAgP2X+UHv3MVvsqTxqrDZ
   nAml9or294deGx8vCya6YwY7Pck2LFHQ9TAtp7Bgd7YHhi39RScWV6lhr
   CguDPYZwKGaHqxKlw0a3CpmSHsmvWWwGLTBemf+FwgoGNA61qNan0lM62
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="360238406"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="360238406"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 00:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703502139"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="703502139"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2023 00:34:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 00:34:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 00:34:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 00:34:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 00:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLoCs0LWwFF6izQdjMP3fPGevemc0LfhiVDJZExpUaVNvrZWOCC7ihF+dx5WWCY8EbnUC+Gqm5JsMyesekFncI5qL/GhI5khQCIXqYPFPLxageA3BEZ5TCAXOZuvYdecTuYuBIPJizMRygpwCyZuwuHgC6i2EUEMUvDrv/HlRiXq0aCLZIPmd5xrxtu0/3nR5z8lDDF/fk1WoJjexEeX/r+4jSgtcSU66uWQIQZU91KX7cz3aiZx/3oEEs+S5ow4SnTQPnkKKaYMqSM8aHhIhEEz9vZ+fnU6mzDtovN6vRSl/0aRtJ1KiMViMRhNcxEIj19sANI8XwxLKjYm41iCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaH7RqnCTFnvrqOsKpb6bpbWqwgBmEL0yf3zG0Cv2dc=;
 b=WZCv1peWcnC9Oi6/o2DlOCnKYFjotIDJdm5rtpPeI7GKQ5Zg1y5tWZMtjf3nm3xnwp9geiJCtUj5ZIzkkiKWR5ThPtns/WTd4GMrJyuMAa+XrSoaeiS0D7NKKV0gKAYTG+P0OGkmqb0ANpqYxKOtoEQyqJNAg0QXNNNMEhLSxWvAx+BLnDLZNfXH5OcEhhjsQEwq4XAQghRHT5DqktZkRovGOO/u65qtlHIGHSFfJkpR4x6CBmSCnwWQXLG5Ftz3+p7kNHFILA/KRpzryRoSLul3qozDEwxHOSnU//gBDnkXgIrj41uiW4bXIw3IzGBnlzD6Mss3NCkencDlR09YAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 07:34:27 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%7]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 07:34:27 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
CC:     "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] intel_idle: refactor state->enter manipulation into
 its own function
Thread-Topic: [PATCH 1/4] intel_idle: refactor state->enter manipulation into
 its own function
Thread-Index: AQHZl8WIHgf7hN/afUeG8ujxGUN2sq9+9WyA
Date:   Wed, 7 Jun 2023 07:34:26 +0000
Message-ID: <0626374836562df9925e440fd8dd7444d36f7025.camel@intel.com>
References: <20230605154716.840930-1-arjan@linux.intel.com>
         <20230605154716.840930-2-arjan@linux.intel.com>
In-Reply-To: <20230605154716.840930-2-arjan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SA3PR11MB7654:EE_
x-ms-office365-filtering-correlation-id: ed3b2dfd-aec5-4151-ade2-08db67299f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4EWMQj6AXfKQybNLPLWLaR9edY5xEhkq1+v0JD2YqSyk6/Knx+WxrUXxZbSJHp806cbmTSMwst0Id6QwFdTn4+JHP/sm1QzIXWLqLn9jBST5l5HVb3xjoDchFbDdCAOjJzclacEK/v2WSRmiTJ7DXJfw4eH88DIsBgUEb8VP7Tf5hYqm3z91n/fyykWbvNbp0Y5NjBSGTkGIPPuh+WvF0h2FmE7U5CLkp+gCXPB7vFQbvNK5iLtfAMmZXvpc9YSAIXt3u2/v6wfY2XVcOItRqTEhXYW2MiUxktf7fmo7dFGSDDVEx8FqNDEh7effC7MhEXlTn2wE+fkvVhPrMnmtQns050C6jgvr1hz1rj/jJJNCZ/gVui5qEFoYPhRdSXNujrZGXhEV9hUl6fr6aHldpUyYv9PNwG3xAz/uPSFMs11iSRckAKdsRThhyuD+QSwZl7MJwNc45jtXaKnYN+23Lou7DrCKYYr4DiezVma8L2SPW4L0d5TLQI2y1lc9x7SlekmHn4zCIX+ms1FB/vI6/i66RpZVZ5KeC+z4MkEXOlsBRN9f+lMdI8yR5yTHMRk8iVaTtclWVrIR4tIiy3TB22wgFq8BIVx1JFMn1GsKzLMK3KUz1mxjqAmC6mu2ZbRb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(6486002)(38070700005)(71200400001)(26005)(83380400001)(6512007)(6506007)(36756003)(2616005)(86362001)(186003)(38100700002)(122000001)(82960400001)(110136005)(54906003)(5660300002)(4744005)(316002)(41300700001)(478600001)(91956017)(66476007)(8936002)(4326008)(64756008)(66946007)(76116006)(8676002)(66446008)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFAxclZCOC95Q1hGYUVWQ0xwTHBEcDB1QmlyWXpRT0RheVE0ektXdHg1TmJU?=
 =?utf-8?B?OXdEdWVZVHg3SDhId01yL1IxN3E2QjJhQ083YnBVY2ZYeHpQVDJxVENoMTVD?=
 =?utf-8?B?NVc2Q0l6OFpZVGkyQjI2N24ySGtyUUVTWDJsK2VFUVhCQmRETFJFZWMvY2xz?=
 =?utf-8?B?WFlFUWdWclBzZWVPVWFUMjBKclFYR3JOMTVwenNSd28yWFd3WWxxYmZYOHB6?=
 =?utf-8?B?RDZYR2xwRldrNWN0VVNSYk1qWkFxb05KdkdBVHdGUUZzelZ6UlZVRWEzZ0FB?=
 =?utf-8?B?WXJSblFaZ2FoOWtBaTI4MjFDNFhNK096TDZmVUJQdHU5ZmlSNFk2b2lqQ2h3?=
 =?utf-8?B?MzhWbUFGZkpNVi9BOUE2UVdmT0U3T3ZJdVM0YXNqUElHUElBV1JsRzZMY01I?=
 =?utf-8?B?L20rSkZjTlpoeGF1NERuelBaaW1WNmpocDVYNmdtL3JLQStSbjFCWXhOUWp5?=
 =?utf-8?B?cjFBSDlxNXNxeW5ERmFqb0xqOFkvNHJ6bCtPcEgwb283eUVjKy9ET0ZudWFt?=
 =?utf-8?B?ci83bGd6ZSt4SUZyUlNuN0JlYkpxRWFGK003UGpQaVhNQmlNYjlzMUhmU1Fw?=
 =?utf-8?B?cTVWSHJDNnBWazN1RWlzRlpBekQ0ei94ZHhtdEFscTFoYTBBL2VtZGo0anBo?=
 =?utf-8?B?NUc3cVRPbk94VmRmV09nd2diV3ZFNm5SdVJBU3FjR0tZcGNUc1hIRDlxdHlC?=
 =?utf-8?B?dVF3VEZHTkhVZnM1V2dYSGhka1kvQzZpQTZxT2xsNUV3bDNEWHAvdTZDWlY3?=
 =?utf-8?B?RWlyUkJubVVGR01WN0FJSGlvQUJUdWxjZlBsbFl0WmFxQk92VFAyZ2orbXd0?=
 =?utf-8?B?VTVBRXJ3VlRSeitBSHJCbEU3UitBdGh5QXJoKzR4VG1NZHA0ZzloaGMzMnF1?=
 =?utf-8?B?bVpENGVxVEZvRFE5UkQrNWUyWFJJb2RYN00zSkorV2xWb2RoaFpUbnhPMU53?=
 =?utf-8?B?QkVkWllQdEZtRWtUS0ZTZ1FHb1pYK1BvRTdLOEUrYnYxYTY0ZHJLdlRoK0Zk?=
 =?utf-8?B?ak9CNGRweWRtdEZIMGxSNFA2NkRmVGdQc0lTT0ZuZy9FQncyWUhFbWRPdG9j?=
 =?utf-8?B?TUdyd3BzMitkNHpLU0lacGRxdkswQTNEUHhMM0RySWJ3NjhWbW1YR3lPa2xU?=
 =?utf-8?B?bFZsaFlEUnF6YWpqdGYwZHFLQmpqV0JRNERnMHpPTTFHTHhvNFFQZ3BBMjJS?=
 =?utf-8?B?d3kxcE5JeGVXbExhOE5IYzdJeHBFdmRJOW12REg1Q2ZzNk9Ed1ZSSTR1Qy9G?=
 =?utf-8?B?bmNMSDZBaFFoM0oxMVo5MW93RUN0VXhwREtNVkg5RytrNklnam04cm8zOWU5?=
 =?utf-8?B?SnNDRXhUYnJPZ1ViTEVsNG9NWGlKV3FKcFJlNEFoVzZvczR3a1hNR1N3a0ZF?=
 =?utf-8?B?ZDhSTUJsbFpCb0hjUFFtSjZFYyswVXM2T3djc2lzRTl3VDdQQWVvUmM3QnY4?=
 =?utf-8?B?UTVyR09XN3FmU2ErVENBaGhXa3hEc2dEbnluTGVxMUt5WVB4ZVZCU0FWcExa?=
 =?utf-8?B?WE92ZVJLQ0xITlFxMGVZeTB0S3BrYVJ3RDNnZElWNHNZSWV1NkFSdkVOeG9z?=
 =?utf-8?B?bktZenU3SHJqcVlTZ1FmR0NERTk4Q1JnUWFjZTlPUlp3ZStwdWxRL3I0aXFp?=
 =?utf-8?B?bjgrdTlqb1hodVdVaWhGRHY3S204cThlc0hERXdJUk9iemlqdU90RWxQbk9W?=
 =?utf-8?B?akdzbVhPS056aU0vREV4U1YrSHlOOHkwWENqSURHNjM4YmwxcStKZXZtY3E4?=
 =?utf-8?B?MUd5Y3pFckdQYkNURmF6ZFFQa3BpLzhDS05BUCtUTm56UjVrSExmbkpvSTg1?=
 =?utf-8?B?OXlBejh6NnhJbmFUWUlSZy9GSWxaOEVWNG9OdnZnK3ExbmFrbXIyVWduMks5?=
 =?utf-8?B?RXlYSWJpa3ZIdFhBdFFWN0F1RFdwelVTMTFDZmkwZDlvcm9zdmxvSmoyUFQ2?=
 =?utf-8?B?WG1sZlllU1A3T1FnSWljdXV0aWxqSUhYTVFPT0JJOWFiZ3VaZ1NhU1d6KytM?=
 =?utf-8?B?T0lhS2V1Q29mWFRkdkNKeDgzNDZsT0J5eDZCZGwzMnZPdG9QRC9EcnNlL1Rx?=
 =?utf-8?B?OGtMYTd2VHpXME5IK3ZuSlZXbE5lS1BaUHdWcjNLekJ1OFBtMksyQjNFc2Jh?=
 =?utf-8?Q?2xhsdSEbOQiI3KPz65TOF+LwX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5E228817656644CA44EBC2788C24373@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3b2dfd-aec5-4151-ade2-08db67299f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 07:34:26.8067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fMydxN0BIpMrpk7faSgEg7fal/eQCGKlZ2YSmDGTUpnIi5Tztu7DucyX8PR/OtWBq28dVoG2Ven+GXjrzJbpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SnVzdCBvbmUgbWlub3IgY29tbWVudC4KCk9uIE1vbiwgMjAyMy0wNi0wNSBhdCAxNTo0NyArMDAw
MCwgYXJqYW5AbGludXguaW50ZWwuY29tIHdyb3RlOgo+IAo+IMKgCj4gK3N0YXRpYyB2b2lkIHN0
YXRlX3VwZGF0ZV9lbnRlcl9tZXRob2Qoc3RydWN0IGNwdWlkbGVfc3RhdGUgKnN0YXRlLAo+IGlu
dCBjc3RhdGUpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBpZiAoc3RhdGUtPmZsYWdzICYgQ1BVSURM
RV9GTEFHX0lOSVRfWFNUQVRFKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIENvbWJpbmluZyB3aXRoIFhTVEFU
RSB3aXRoIElCUlMgb3IgSVJRX0VOQUJMRQo+IGZsYWdzCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGlzIG5vdCBjdXJyZW50bHkgc3VwcG9ydGVkIGJ1dCB0aGlzIGRyaXZlci4K
CnMvYnV0L2J5PwpzZWVtcyBsaWtlIGEgdHlwbyBpbiB0aGUgb3JpZ2luYWwgY29tbWl0LgoKdGhh
bmtzLApydWkK
