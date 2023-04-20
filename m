Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677CE6E8C94
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjDTIWV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjDTIWU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:22:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E51BE5
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978938; x=1713514938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eoJZSXd3Y6M/kQFnEk3RMt1YL2yQXOglWMjwxLvGOV8=;
  b=WCxUxrS31gXVdHGovgt4ZPo2gdtiNEbRBoXSyYGmFyuu/r2IRbHqXmDI
   LfA1EEWNPf3EMcU+oVriY2fOmhK53izjiyyMCPInPPrKZYZXhmzCNxqPU
   ACinrERPJRizB3b12EMcuXpvO75ARzReNOvoxnxhXO+NcI14C1gNVLoSB
   AM7FvgqsI2LkYYftbOIM7YYcmtEAiM4CFpGUcIIzWVSsD3EkL4SIbz67c
   beE6YSNOL5XW/a6YlDQQZDVUeNy4D1hE81TepLoejWv4fQR++y5VbA1SC
   bw1Sz2/2a7GOg/4B4BkKWQdhdwI4dwfInJ+n7l6IGp1hWNmk1u+/RsH+S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345673150"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="345673150"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="724343907"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="724343907"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2023 01:21:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:21:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:21:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:21:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7dFp6qTZhZg39tXCQNrO+P9isdVe4gjd74+ptdXn9A0ZBNhG1vuOUhzF9x8/BA3Ec55ekZRskZFQFbGvTVhQTPQGhzVrpPKRBueFSQykN4QPSetJaL7ZZ6RiTJxFp0KYd/qHKAt8Q0aH4XlnPFBEf6b6+/NbVHdVMBwQ861ldCdDImBdfG1cVx613PzP/nnqnIaqAhGcxf09ismUXjgcqqbjNLTG7LMp6LJJA43G6gToHN6iL/qgShkd7diK/ylpmV74ZclZFW9lDjfUV827jp10fEjpTIBlnl57hd/eH8GfX9JTT9urcQFoSZGMAiX8/iplpJeH6mazojX43kHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoJZSXd3Y6M/kQFnEk3RMt1YL2yQXOglWMjwxLvGOV8=;
 b=IelKZF1k+RTxrxYWQouChUA5d8aiq8oSW+HrRFDeoFXJFnJ9rJRsEbZOYqxP+2FYgNyJmAMTvovbvKK+CW0UYu/EGLw3tYJeWIwcDnxHXY8hf6zgUmhgve0TehURI7wVsP7zuV2SUoFq4UJ3kELTkKXAZpnRUW8yEYTdOrUVhCWXd3GmBYwerT4w3Kv1cxWAEyMYxbjlxsSqzT7PdB6LqCJrHIgBO8pyV/AJRdKmK2pclju2Tg/lSRW/xXJ/X3AVwbyEFnINVzf6yEhF6agH6UeucYB/Of10J0CkNjrD0tOjl4ZqzjpirOOZv++Ggh1HZptSE+tCMtwpUiB2j77HWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com (2603:10b6:a03:3ef::16)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:21:50 +0000
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da]) by SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da%6]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 08:21:50 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] intel_idle: do not sprinkle module parameters
 definitions around
Thread-Topic: [PATCH v2 6/7] intel_idle: do not sprinkle module parameters
 definitions around
Thread-Index: AQHZc1P8VDEOTgEPNkqcrOLeJTrmk68z26aA
Date:   Thu, 20 Apr 2023 08:21:50 +0000
Message-ID: <820a4c48273d56db4d2c7a9c5de671f2c844c039.camel@intel.com>
References: <20230419143947.1342730-7-dedekind1@gmail.com>
         <20230420064721.1981956-1-dedekind1@gmail.com>
In-Reply-To: <20230420064721.1981956-1-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0033:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: ab9a62b9-e1b5-420b-fa37-08db41784a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kx4KWz1INOArYDoaszH9kxAdaLkvo9SQhWx2CCaUfaW6PGbD6LweUBdW5UhrKrheAhD51TSNMNAz+6j+8fHpm5OahVjXOroMXAc8lx7y0PM9udDQ4HiEZYH2m8fPNwKCaSG0KQu+RRcxUP/rUFBaLdRUNdwmGmZ0byp2qTlz1oOOjJd+lpuO1Ohhh3rHbrsHkqmsq/iQXdenxH1SOjlbFjIh41KP4sSw2xCF+VRNhA1IQVQRAZZFOJ1HviWug3eJBTeg3NEEDIo8jyQItThainZT7RLRrDWXWnf6OR3EGFgFxHtaP5w4WWzMQHV9d7iE2sCvoMiUize4HdXUBnm9aIHIjD1AMEMWfiHVWA1HtjQRiqvmh0tUwuctIa8jiF28mWCdbE56vIZRSP5VQVbYhBsQP0o3P35gN5gHEz10WiLxgKSaF43SuD/Gs2q7dMkOUNxuOhH1WyrVNB20XdFq4lbO8ftJHlU/ebH/pARojtAwXg00ymy5MXyvwVVZFvHDbQ9OOeD/KZiaE3+SuUfMk0LiXlNOLpooXbxg9cLs/Nlo1VB5B6kIyN1iguz8e5wv/zHtvWE8H0fgrXKE2bcUbSiwKyTyo3b9gm2mgu8hKai3Dufd0bTLa9GC6dCRkTI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(36756003)(186003)(26005)(6506007)(82960400001)(38100700002)(122000001)(6512007)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(71200400001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRtYW9aN0NLd3VSek0wNzJSL1FCd0JsR0xoSnBOTmozS0xiMUw2dWdDT2hP?=
 =?utf-8?B?cmtNL1J2ZzM3cHRXd0dzSGs3bGVQUGtuSlZPbEhibGRBSTErUmpqQzI4Vmtu?=
 =?utf-8?B?UHM1UUtCVGg1YXViTlFnVjFycHljdXlXS0V0OURtakFrR2pKeVBsQlljbnpY?=
 =?utf-8?B?L2tSTjZIbkxENXJQckcyMmsyeWhHdHhiTk05ZmU0OTVyMFA0ZDdNeU5kM0p5?=
 =?utf-8?B?NE5pcUFRYUp2VUNLS1RVUXhDR2ZYQndnbEZENnFkSlNKZEpHbHNHWk04RVpU?=
 =?utf-8?B?MEVidVdVdGVUQm1FN0lHc21xOGVwNlFET1hGZU9vVHNWNWlVYldCRlVROG4z?=
 =?utf-8?B?M2FvYllveVBOUGFaSkJLOWNpT05wVDdYd2RPTjVDTFRnRGNwbzUvSDNPWC9n?=
 =?utf-8?B?OWU1VC9Tb01UdXpQWDlOdmMvY3pDVFhCS2VqbVg2MHAxRnFUbDhReDdrTERh?=
 =?utf-8?B?OEJMV0drU21ocThjSEVMbDRmb0tqL0JtUTJERjdmZ2d6REhVVks2QzQ4L2xI?=
 =?utf-8?B?bDQySzZudWViUkJXV0E5TmdReXFMekdHREQrY2RMV0ZJQWRDK0pSUUNnb25n?=
 =?utf-8?B?YjJWRm13aEJraUNKZ3FmVFN1TEVzeHVrbE41ZEJYTUNPWnlDSU5yWVlzcGZE?=
 =?utf-8?B?TmpaaXBjbTMvdkZLTE1yZ2k2bzY3YTVTOVc0aStQdW1WZXBFM2JEenpseHE1?=
 =?utf-8?B?RHJNMFRRUXM5UnJOL0s3VlQ4VVRqREJTa1NncjJnSHhvVnlXWFFoaDV1Y0d1?=
 =?utf-8?B?T01WeDBTc3ROYlU1ckpIRXU1aE1YTHpEUEI0YkwrazdPdmJ5ZXVxdlR2RUt5?=
 =?utf-8?B?S0xQdTNrd1J5L0RaZHhRbFZ2MGRBWXJpZU4wNlh5VDZQWUFYczFFVGhKSlV3?=
 =?utf-8?B?Z0l3OVhoS3YzeHhCT3RIK3ViMEYxZFZLUlIwckdnZFg0V20wOWxkaG43MDFr?=
 =?utf-8?B?eWlEajJOeVhyWlJoYVB3K1dmZ1REdEVxa214NWgwSXJCMHpOU09YT0dHN0Rp?=
 =?utf-8?B?TjlYWithT1JhQlI2NWZta3g5M3RWRlBsbmxreCtBaE1xaGNpaGVIZDBGaXZp?=
 =?utf-8?B?UHZMTjVLUmZFQVVFcDhOYVdYd1lxR2NLaW9Jdk1kdWpKdFJ1ejhHWU94ZFZa?=
 =?utf-8?B?V0JHTVdMQVdEQmIxM0RZcUZUQUpDM3ZvM053UkhianBZdVpKNXRYYVM1aVBx?=
 =?utf-8?B?QkZjVWY4SDQ1eEU4dFBkaC93Q29Dc21DWml5R3BEcTI2YkZpNVJtdnhMU1hv?=
 =?utf-8?B?Tm9qNG15aEU0UE80R1d6NE1HSUFYa3ZmazBveU13M1ZZd3I3OWQxTmlJdEV0?=
 =?utf-8?B?V2lSc1Vac1BGQ3AxenRHYU41Q1EreGVLZ1ZaMEZ0Y21IcThoSXpwb21JVHkx?=
 =?utf-8?B?K1FOZUV5WlJVWDFQZG5EMHp4L29ZNkpiR2oyYkw3YTRLNjJQbmNYajN2Zk8z?=
 =?utf-8?B?VUM2aUJxWXRiYVRjL3Ntc2lLOTdEMDRlbEwweVJYWmtqalB5UkltZ2svWXJx?=
 =?utf-8?B?OU5EWS9ORk5vdFB0Y3hBK2lGUFkxSTdKTmQ5WmRYNjlUS3ptc2RTK1FEVXdl?=
 =?utf-8?B?RGVrUTZvZ0ZRaVJ4UEJJcnh5S1h2V2c1aUgxYjdJcFNqL1A0cUVaNGdLaVVp?=
 =?utf-8?B?NWQ1eWEzTlhJSkQ3Y05IK05Jano3Nm9QZWZOZWtYeU5ZRGxkVGZDTWdUWXFF?=
 =?utf-8?B?M0hIQ2E1UUVXNGlZQWdvdUk4emVqRzhtMUhaUVlGRi9IMmc3S1dqMlY3MkNO?=
 =?utf-8?B?N1JnMmx4UjZIaHpzMnRaSFZ0N09rOW9QK1ljOVRPS3VZQW8vVTFROFRaSmRo?=
 =?utf-8?B?UGhkWis1bWtpUSsrczBiRHhuV2hqZTl3Q0JNbmwyV2NaNS9wMGcyR3psTElh?=
 =?utf-8?B?dUhIMjNFbDVLYWdCeEdQQm04YldsUWEvSjMremI0TFlOQXdocEJ6RjdkRjQ4?=
 =?utf-8?B?R1FWbVVGMEhjNlRPV2NUa2pUY2JJMUNqSENFY3RDQ1NFeitrUklFOFZTcmF6?=
 =?utf-8?B?U1A4UVR6LytRa2FHUUdjeG16RlYzeXM2S1hLZ1QveTlGOHZ6SmgvUmNNSFRx?=
 =?utf-8?B?bDZMbDdJczUvbm8xNXZwNTZpcnV0d0pDRVR2NkxPOVVCcTJjS1pwME9XaXhJ?=
 =?utf-8?Q?GarcMtC7lB2shTtKq791c//74?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44B07AD163D9554ABB99A9607C1AC924@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9a62b9-e1b5-420b-fa37-08db41784a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:21:50.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ujn0b2vjB/puRNvXqs/fxnbcJhtmuquzwkSMuTz958NuahY0ZKiY25wXp0X3U4Ro0hY/fkhq7Hsn8TF0mRMXQ==
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
LmNvbT4NCj4gDQo+IFRoaXMgaXMgYSBjbGVhbnVwIHdoaWNoIGltcHJvdmVzIGNvZGUgY29uc2lz
dGVuY3kuIE1vdmUgdGhlDQo+ICdmb3JjZV9pcnFfb24nDQo+IG1vZHVsZSBwYXJhbWV0ZXIgdmFy
aWFibGUgYW5kIGRlZmluaXRpb24gdG8gdGhlIHNhbWUgcGxhY2Ugd2hlcmUgd2UNCj4gaGF2ZQ0K
PiB2YXJpYWJsZXMgYW5kIGRlZmluaXRpb25zIGZvciBvdGhlciBtb2R1bGUgcGFyYW1ldGVycy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydGVtIEJpdHl1dHNraXkgPGFydGVtLmJpdHl1dHNraXlA
bGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50
ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCj4gLS0tDQo+ICBkcml2ZXJzL2lkbGUvaW50ZWxfaWRs
ZS5jIHwgMTAgKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gDQo+IENoYW5nZWxvZw0KPiAgKiB2Mg0KPiAgICAtIE1lbnRpb24g
J1hTVEFURScgYW5kICdJQlJTJyBmbGFncyBpbiB0aGUgJ2ZvcmNlX2lycV9vbicNCj4gY29tbWVu
dGFyeQ0KPiAgICAgIChmZWVkYmFjayBmcm9tIFJ1aSBaaGFuZykuDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMN
Cj4gaW5kZXggYmZmMGQxN2FlZGE0Li4zNWJkMjg0Zjc3NjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0K
PiBAQCAtNjgsNiArNjgsNyBAQCBzdGF0aWMgc3RydWN0IGNwdWlkbGVfZHJpdmVyIGludGVsX2lk
bGVfZHJpdmVyID0gew0KPiAgc3RhdGljIGludCBtYXhfY3N0YXRlID0gQ1BVSURMRV9TVEFURV9N
QVggLSAxOw0KPiAgc3RhdGljIHVuc2lnbmVkIGludCBkaXNhYmxlZF9zdGF0ZXNfbWFzazsNCj4g
IHN0YXRpYyB1bnNpZ25lZCBpbnQgcHJlZmVycmVkX3N0YXRlc19tYXNrOw0KPiArc3RhdGljIGJv
b2wgZm9yY2VfaXJxX29uIF9fcmVhZF9tb3N0bHk7DQo+ICANCj4gIHN0YXRpYyBzdHJ1Y3QgY3B1
aWRsZV9kZXZpY2UgX19wZXJjcHUgKmludGVsX2lkbGVfY3B1aWRsZV9kZXZpY2VzOw0KPiAgDQo+
IEBAIC0xODM4LDkgKzE4MzksNiBAQCBzdGF0aWMgYm9vbCBfX2luaXQNCj4gaW50ZWxfaWRsZV92
ZXJpZnlfY3N0YXRlKHVuc2lnbmVkIGludCBtd2FpdF9oaW50KQ0KPiAgCXJldHVybiB0cnVlOw0K
PiAgfQ0KPiAgDQo+IC1zdGF0aWMgYm9vbCBmb3JjZV9pcnFfb24gX19yZWFkX21vc3RseTsNCj4g
LW1vZHVsZV9wYXJhbShmb3JjZV9pcnFfb24sIGJvb2wsIDA0NDQpOw0KPiAtDQo+ICBzdGF0aWMg
dm9pZCBfX2luaXQgaW50ZWxfaWRsZV9pbml0X2NzdGF0ZXNfaWNwdShzdHJ1Y3QNCj4gY3B1aWRs
ZV9kcml2ZXIgKmRydikNCj4gIHsNCj4gIAlpbnQgY3N0YXRlOw0KPiBAQCAtMjE1NywzICsyMTU1
LDkgQEAgTU9EVUxFX1BBUk1fREVTQyhzdGF0ZXNfb2ZmLCAiTWFzayBvZiBkaXNhYmxlZA0KPiBp
ZGxlIHN0YXRlcyIpOw0KPiAgICovDQo+ICBtb2R1bGVfcGFyYW1fbmFtZWQocHJlZmVycmVkX2Nz
dGF0ZXMsIHByZWZlcnJlZF9zdGF0ZXNfbWFzaywgdWludCwNCj4gMDQ0NCk7DQo+ICBNT0RVTEVf
UEFSTV9ERVNDKHByZWZlcnJlZF9jc3RhdGVzLCAiTWFzayBvZiBwcmVmZXJyZWQgaWRsZQ0KPiBz
dGF0ZXMiKTsNCj4gKy8qDQo+ICsgKiBEZWJ1Z2dpbmcgb3B0aW9uIHRoYXQgZm9yY2VzIHRoZSBk
cml2ZXIgdG8gZW50ZXIgYWxsIEMtc3RhdGVzDQo+IHdpdGgNCj4gKyAqIGludGVycnVwdHMgZW5h
YmxlZC4gRG9lcyBub3QgYXBwbHkgdG8gQy1zdGF0ZXMgd2l0aA0KPiArICogJ0NQVUlETEVfRkxB
R19JTklUX1hTVEFURScgYW5kICdDUFVJRExFX0ZMQUdfSUJSUycgZmxhZ3MuDQo+ICsgKi8NCj4g
K21vZHVsZV9wYXJhbShmb3JjZV9pcnFfb24sIGJvb2wsIDA0NDQpOw0K
