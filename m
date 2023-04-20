Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA576E8C92
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjDTIVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjDTIVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:21:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD235BB
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978904; x=1713514904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r0utzL4yIlXukP/MAPpl8w3mHS0RJLp5zWL78d9Ei1w=;
  b=SR2U7FNlmqlceOExcrOeyGGHSdxZhUG/ZIqPmpGHj9zBkJpACZVPvzue
   NQwQDJxcaZe+CH0DiGiYDx4zZj20jUqduG/iXSPJ94PTt8AQSomBDchIX
   rRqeCqMm1L2swLjhDLmkP3cPbTT+WP2FhCyd/0X9v9dGZsm/We/Lo4f8Z
   uHBgsOzkGh5EkidmesIGic25A5A3lxrpSsLSeukjZfaSIJRSCrkzhShcI
   WVkYgr9ydvsgCndBOEGfiKFq55FTJ+lVCLBWQKbWvGQu5LaeQGNz+M56V
   /EKSktWOoMBJGpLidmHr6l2e8sa4DfIzyYQNSVW2v3U9SX0MGjvGf13+7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345673078"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="345673078"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="724343760"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="724343760"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2023 01:21:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:21:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:21:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:21:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWfr2274WPEwBI1/094K5UputkYrb3nCCqSjp2socn5hdy3glaWhsHhwSx3jvP0YU0E3lu62SCBZNrt3XswydhdHqOLNwlcpjFKl+/zh2aNXi1hLo5Mv62mm12/6nXTT6RoKFqWn6+yZD03pPY0CIa3+ZsNnjXQw3irXOcamRP+J4nMM9+R9KzV1sAVCsCp+BWB0XY6zXwX9ZrRqMdntz9dzy6dxHYdVh5ohmcE1FR6aVRkywRrev8JsJZ+hLxef15O7RB5eSdje3uqE83WDVe7z0LXAZDxuHgjSOoaky3cy6L4fRjIfbKUetCVCG2z/UJCaQXjGczpbkqlNimXRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0utzL4yIlXukP/MAPpl8w3mHS0RJLp5zWL78d9Ei1w=;
 b=misx8NbfMK15Gombf5QnXbss2pgitrC9/Wmju/VxDdn5MSH3YlJErGu+NS9CWgW+fCdadwRphif7TDHhcnzaXgFEvtsfEKkZSk8loCiJ0EXupPI9/RYkGVF89GPpMCxGYduy0GrdsDMHcoj44h/6mL+/8Ie+obJRfqlazjOeDin8SjhpwEHpJ8nQ4v2in6HUlwJGdKaZ2dIbGikJQJBb7MYOx17vYUgotg/LCQUeBKq0ZwpTGv7QFV0St8Uj5XeBO/usDHW4q6jhBY7/wD1ONFgm0af5B69ZPRfyFhU7PjCYBg4Ans9b+NLvVpcCztcHx1kDhJUu2zv8YMDNJ+oB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com (2603:10b6:a03:3ef::16)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:21:41 +0000
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da]) by SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da%6]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 08:21:40 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] intel_idle: cleanup
 'intel_idle_init_cstates_icpu()'
Thread-Topic: [PATCH v2 2/7] intel_idle: cleanup
 'intel_idle_init_cstates_icpu()'
Thread-Index: AQHZc1P5Z41lmqfK9k+mZos3fuMovK8z25kA
Date:   Thu, 20 Apr 2023 08:21:40 +0000
Message-ID: <ab665937824492ef03819cbedb06ceb154b23e37.camel@intel.com>
References: <20230419143947.1342730-3-dedekind1@gmail.com>
         <20230420064718.1981936-1-dedekind1@gmail.com>
In-Reply-To: <20230420064718.1981936-1-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0033:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: 05578d99-5c73-4e3e-a478-08db41784458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12/+AfjJd9y+zD94FiZ0O9Al7Gk4eEpnOL4ZcwafSxTeravzCcNiVnvt4Taw3tJO173MDlrNw6/veHPTw1EawJuzlifF87QSv3pFEzGeWBpyJFLs0v5N9INfx0YrDzRS8XISyT7hMY5U4rJIOokQrBVPy/E1wMdrKVVKTexC/oZmF/Ik4ch74XscozLs/Fu/HXSNOHZh0tGKMd+6h09k5x3rI1dv/w2kBIXjx5+kQOInU5ZdwKL/Bhrjf2/4vOMl/ychNOYZhi3mIsZ/T3tFVYzHbMxZvDhRGbGVUBh5hMWI+wutScU+rfhuDKOFVYT1sM3821g35CghGoi24gL84Xz6tron1vUVm8M8JVoCLiBVMFcheUgmF9UBieHX3NVy0JWVs3ObPNiKuTsEQeE6YbiJXNmpLptIvgRkeF8rL9sFib72UDFnmk3n2kA/IQNn/Oo5Uy0u1vjd4eqqxn0wJD3Q6Wjr6jBnexFpCnuM9e9i0BupA8yu7gc95HAY/DNsTRQv5AbouKpZaDy4HTQjocpL007QurqUIW7R1Oi3D1FAivTh0n+fpI8aaTS6SOoMRua0y5dq0zeV6T7Vb3Vb3MwcySilfGE791m3jsQwUlEbDnTxjh45fEQh2BqRL/df
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(36756003)(186003)(26005)(6506007)(82960400001)(38100700002)(122000001)(6512007)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(71200400001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enNBL1ZQM1dTemt2VFdCQ05TTjBqQzRCbGF5b0FQMXZ2OTYwQXFMNlBkaGNF?=
 =?utf-8?B?aG15elgzb3pqVERIeWtSN1E0Q1dnYWxSbUpSVVhzYXRRcDc5VGJSd2hzNDYy?=
 =?utf-8?B?cTR5aDVYVGhudC96cEFmcW8rRkVIWndYVjh4SHMySnViN2FwdWhRSTR5eVo2?=
 =?utf-8?B?TG54b21MLzlXb3NKUjFCSUFSQ3U3OVl5ek5HSUFKaGVnWDR6K2JQN3dRMklZ?=
 =?utf-8?B?dFFjYWVqSmdCRThBNWVtUEx0T0s1cEMwM05CemNWMEZLRmxBTHhqTS91Smp2?=
 =?utf-8?B?aGsxRWFWc01lSWN5YWlhVjE4K25yWHNiUXVkL2pzUWx4bm5lczVzM2ZwUG9F?=
 =?utf-8?B?SFN3OFZlcDdpcjZLcXVzc1B6UjRUNi9Na1V1WDVKREMyMDF3ZkQxbGMwN2U1?=
 =?utf-8?B?cVB0S2dXbEl1cmxFd2pQSStTeG9Vb00za2VIK1R1disxVzJBVW1tZitnZFJL?=
 =?utf-8?B?bURFTTQ1NlhtWHlwMzk4WmxuZVo2bFd6c1hBTnk2QXJhQkMvTDRBbmdGN0hu?=
 =?utf-8?B?MGtEUHRKSlhtTTcrVUZndHJERHRuQXJDclRzSnFic2RXdUwydGpnOEI1amg3?=
 =?utf-8?B?ZHd0U0gyMGh0aDdhaFVVRldHSHpuS0xzRTJGRWRtVkFieWJvSlNWNkw2WW44?=
 =?utf-8?B?bDdhWHZqN1F0SHVTTm15VnBmWjBSUVc5bmpVeGx6MFdNaEVmUTNXUUhGajg3?=
 =?utf-8?B?SmxCTDJhUVNWOW9JSEkzUFRHc0FqUDZ3cXlGNEVyQWxFMmtha3hNb09zT2xT?=
 =?utf-8?B?VGx2L1FiZUhKSE5sclFaS1ZTWlFyNE1ySzJwbHVtdGxjZ0lGN2w1TmZSRldM?=
 =?utf-8?B?VEE5M0lmRGluUEs3SUd5aUtRRE9rTC9NVGZGMUdialRzYThLY29EdGRoUllX?=
 =?utf-8?B?bWZ6UDlGRjBxLzF0NXY0TlRSUVZZZGZ1Ti9QdERYUW9mQU1EeC91OVRNWFVX?=
 =?utf-8?B?dmlZK3ZpaHJKVHQxWURaRzFPaERnUUtleHl6VXgzckFJa0NWMDMrbHhJQWZN?=
 =?utf-8?B?Vk4rRTRZWXBHcDR0VnZ4OFkvbWlTalBmeXJoYVViNmRXRU5tRkQvaEVMK0M2?=
 =?utf-8?B?Snc5ZU83YlNKNGF6eFVYdm9DcEh1YkZsNmdFcHZKU0xHQTRUanltWVBicTAr?=
 =?utf-8?B?KytLOW8wWmxTT0lneW9hU0w3VGRtMzhuMStJcVEzQnRnTGRMOHUxZ1FNclZ6?=
 =?utf-8?B?VldZNGhpK2gvRmtHUFpDcUpsQ0x2dm03MEcycklILzJYeWZmd1Z4S1ptUHdq?=
 =?utf-8?B?UlpTdGorampjSzdhZmtWZWlKeHJmU0ZTYnNaQTlzU2hDbTg1SGVSTjNmZ28v?=
 =?utf-8?B?YkN2VFlTdnVwR2YxTjRvek02cnJJZ0pKMUcyMVJXQ0tZb1RUQ01WNkt1T2pR?=
 =?utf-8?B?UXUxOU1CdDdxRk5VY3NCTkRmaStHdDMwOEhvQk42YWZDMG9NWHRjazRUeUo1?=
 =?utf-8?B?dlBnOFRhcU5oQ3hLaGk2cU12QmJVc0t5bDZDRHZtdEFTZE92R1VmZmNnNFc1?=
 =?utf-8?B?NmpFR2JVSDY5eWl5dTRpandIeHI5U3FsMllRM2o4dW83ZlU5czJubjBRNldY?=
 =?utf-8?B?bDMyajBSUzNLbDdUYXJuVklZOWwxT0lSZ3VocnYwZWo3L3BzQWNndHltakRE?=
 =?utf-8?B?Z213SWRlUWtIVkRjSmhnVlFWRkxvMlRwMXk5VW1tUXhNVkxSSGUvUkdqbXRD?=
 =?utf-8?B?R01CY2x0NDIvaHFJYUxJNDdDV2FnZEY5a09OQUkzRGtQZFBFd1JLVFlMcWhS?=
 =?utf-8?B?bktIVTRUbXhqOUlROVlwMDhDYkF4cXJtLzl1N1hoMnhUUlhLWDMwNUNUQU1u?=
 =?utf-8?B?STVyWUZ5aXM3anpnRWhhdlFMbFhqSnFOU2ErNjBrdnh4dFhEcWpJOUVpZDZY?=
 =?utf-8?B?dnpJQVZrVDJHKzl4ckdRdkJnOENNRkNaR0RhNVVPQ1dUMEUrcThoRnRucUNI?=
 =?utf-8?B?cjMxUFRFN2lGOWFaT2RqbmhNRjNQZndWWnZYWklyQlpNSlE4OVhFRnJOUHhV?=
 =?utf-8?B?TUpHcENoeTZFanlmMlJvUENPc2hqeFRhSW40djlyTm8yM0gvdWxLSCtQUXAz?=
 =?utf-8?B?UlMwSThUenlWTE9USkJsczZIYnVVcFBRM1BWNmJCZVErYU9oWGROVVM2d0Uz?=
 =?utf-8?Q?/UMkRkZ+cB7P0T1UADz0lHdrv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05FB308AE570E641A84FDF635121EF6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05578d99-5c73-4e3e-a478-08db41784458
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:21:40.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aLt1LEdGjdubDb6d5CQe7WRPEJDn00G6bZIb7liICOd4ADBxUvoqJTQn5iuO9XYfN2uBAgmSFHlG0JoZ2k60A==
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

T24gVGh1LCAyMDIzLTA0LTIwIGF0IDA5OjQ3ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBGcm9tOiBBcnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGxpbnV4LmludGVs
LmNvbT4NCj4gDQo+IFRoZSAnaW50ZWxfaWRsZV9pbml0X2NzdGF0ZXNfaWNwdSgpJyBmdW5jdGlv
biBpbmNsdWRlcyBhIGxvb3AgdGhhdA0KPiBpdGVyYXRlcw0KPiBvdmVyIGV2ZXJ5IEMtc3RhdGUu
IEluc2lkZSB0aGUgbG9vcCwgdGhlIHNhbWUgQy1zdGF0ZSBkYXRhIGlzDQo+IHJlZmVyZW5jZWQg
Mg0KPiB3YXlzOg0KPiAgMS4gYXMgJ2NwdWlkbGVfc3RhdGVfdGFibGVbY3N0YXRlXScNCj4gIDIu
IGFzICdkcnYtPnN0YXRlc1tkcnYtPnN0YXRlX2NvdW50XScgKGJ1dCBpdCBpcyBhIGNvcHkgb2Yg
IzEsIG5vdA0KPiB0aGUgc2FtZQ0KPiAgICAgb2JqZWN0KS4NCj4gDQo+IE1ha2UgdGhlIGNvZGUg
YmUgbW9yZSBjb25zaXN0ZW50IGFuZCBlYXNpZXIgdG8gcmVhZCBieSB1c2luZyBvbmx5IHRoZQ0K
PiAybmQNCj4gd2F5LiBTbyB0aGUgY29kZSBzdHJ1Y3R1cmUgd291bGQgYmUgYXMgZm9sbG93cy4N
Cj4gDQo+IDEuIFVzZSAnY3B1aWRsZV9zdGF0ZV90YWJsZVtjc3RhdGVdJw0KPiAyLiBDb3B5ICcn
Y3B1aWRsZV9zdGF0ZV90YWJsZVtjc3RhdGVdJyB0byAnZHJ2LT5zdGF0ZXNbZHJ2LQ0KPiA+c3Rh
dGVfY291bnRdJw0KPiAzLiBVc2Ugb25seSAnZHJ2LT5zdGF0ZXNbZHJ2LT5zdGF0ZV9jb3VudF0n
IGZyb20gdGhpcyBwb2ludC4NCj4gDQo+IE5vdGUsIHRoaXMgY2hhbmdlIGludHJvZHVjZXMgYSBj
aGVja3BhdGNoLnBsIHdhcm5pbmcgKHRvbyBsb25nIGxpbmUpLA0KPiBidXQgaXQNCj4gd2lsbCBi
ZSBhZGRyZXNzZWQgaW4gdGhlIG5leHQgcGF0Y2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcnRl
bSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQo+
IC0tLQ0KPiAgZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyB8IDEwICsrKysrLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBDaGFu
Z2Vsb2cNCj4gICogdjINCj4gICAgLSBBZGp1c3QgY29tbWl0IG1lc3NhZ2UgKGZlZWRiYWNrIGZy
b20gUnVpIFpoYW5nKS4NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lkbGUvaW50ZWxfaWRs
ZS5jIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KPiBpbmRleCA3MjZhMzYxZGE0MjIuLjE5
MDQxMGZjOWNlNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KPiAr
KysgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+IEBAIC0xODk0LDI0ICsxODk0LDI0IEBA
IHN0YXRpYyB2b2lkIF9faW5pdA0KPiBpbnRlbF9pZGxlX2luaXRfY3N0YXRlc19pY3B1KHN0cnVj
dCBjcHVpZGxlX2RyaXZlciAqZHJ2KQ0KPiAgCQkvKiBTdHJ1Y3R1cmUgY29weS4gKi8NCj4gIAkJ
ZHJ2LT5zdGF0ZXNbZHJ2LT5zdGF0ZV9jb3VudF0gPQ0KPiBjcHVpZGxlX3N0YXRlX3RhYmxlW2Nz
dGF0ZV07DQo+ICANCj4gLQkJaWYgKChjcHVpZGxlX3N0YXRlX3RhYmxlW2NzdGF0ZV0uZmxhZ3Mg
Jg0KPiBDUFVJRExFX0ZMQUdfSVJRX0VOQUJMRSkgfHwgZm9yY2VfaXJxX29uKSB7DQo+ICsJCWlm
ICgoZHJ2LT5zdGF0ZXNbZHJ2LT5zdGF0ZV9jb3VudF0uZmxhZ3MgJg0KPiBDUFVJRExFX0ZMQUdf
SVJRX0VOQUJMRSkgfHwgZm9yY2VfaXJxX29uKSB7DQo+ICAJCQlwcl9pbmZvKCJmb3JjZWQgaW50
ZWxfaWRsZV9pcnEgZm9yIHN0YXRlICVkXG4iLA0KPiBjc3RhdGUpOw0KPiAgCQkJZHJ2LT5zdGF0
ZXNbZHJ2LT5zdGF0ZV9jb3VudF0uZW50ZXIgPQ0KPiBpbnRlbF9pZGxlX2lycTsNCj4gIAkJfQ0K
PiAgDQo+ICAJCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0tFUk5FTF9JQlJT
KSAmJg0KPiAtCQkgICAgY3B1aWRsZV9zdGF0ZV90YWJsZVtjc3RhdGVdLmZsYWdzICYNCj4gQ1BV
SURMRV9GTEFHX0lCUlMpIHsNCj4gLQkJCVdBUk5fT05fT05DRShjcHVpZGxlX3N0YXRlX3RhYmxl
W2NzdGF0ZV0uZmxhZ3MNCj4gJiBDUFVJRExFX0ZMQUdfSVJRX0VOQUJMRSk7DQo+ICsJCSAgICBk
cnYtPnN0YXRlc1tkcnYtPnN0YXRlX2NvdW50XS5mbGFncyAmDQo+IENQVUlETEVfRkxBR19JQlJT
KSB7DQo+ICsJCQlXQVJOX09OX09OQ0UoZHJ2LT5zdGF0ZXNbZHJ2LQ0KPiA+c3RhdGVfY291bnRd
LmZsYWdzICYgQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpOw0KPiAgCQkJZHJ2LT5zdGF0ZXNbZHJ2
LT5zdGF0ZV9jb3VudF0uZW50ZXIgPQ0KPiBpbnRlbF9pZGxlX2licnM7DQo+ICAJCX0NCj4gIA0K
PiAtCQlpZiAoY3B1aWRsZV9zdGF0ZV90YWJsZVtjc3RhdGVdLmZsYWdzICYNCj4gQ1BVSURMRV9G
TEFHX0lOSVRfWFNUQVRFKQ0KPiArCQlpZiAoZHJ2LT5zdGF0ZXNbZHJ2LT5zdGF0ZV9jb3VudF0u
ZmxhZ3MgJg0KPiBDUFVJRExFX0ZMQUdfSU5JVF9YU1RBVEUpDQo+ICAJCQlkcnYtPnN0YXRlc1tk
cnYtPnN0YXRlX2NvdW50XS5lbnRlciA9DQo+IGludGVsX2lkbGVfeHN0YXRlOw0KPiAgDQo+ICAJ
CWlmICgoZGlzYWJsZWRfc3RhdGVzX21hc2sgJiBCSVQoZHJ2LT5zdGF0ZV9jb3VudCkpIHx8DQo+
ICAJCSAgICAoKGljcHUtPnVzZV9hY3BpIHx8IGZvcmNlX3VzZV9hY3BpKSAmJg0KPiAgCQkgICAg
IGludGVsX2lkbGVfb2ZmX2J5X2RlZmF1bHQobXdhaXRfaGludCkgJiYNCj4gLQkJICAgICAhKGNw
dWlkbGVfc3RhdGVfdGFibGVbY3N0YXRlXS5mbGFncyAmDQo+IENQVUlETEVfRkxBR19BTFdBWVNf
RU5BQkxFKSkpDQo+ICsJCSAgICAgIShkcnYtPnN0YXRlc1tkcnYtPnN0YXRlX2NvdW50XS5mbGFn
cyAmDQo+IENQVUlETEVfRkxBR19BTFdBWVNfRU5BQkxFKSkpDQo+ICAJCQlkcnYtPnN0YXRlc1tk
cnYtPnN0YXRlX2NvdW50XS5mbGFncyB8PQ0KPiBDUFVJRExFX0ZMQUdfT0ZGOw0KPiAgDQo+ICAJ
CWlmIChpbnRlbF9pZGxlX3N0YXRlX25lZWRzX3RpbWVyX3N0b3AoJmRydi0+c3RhdGVzW2Rydi0N
Cj4gPnN0YXRlX2NvdW50XSkpDQo=
