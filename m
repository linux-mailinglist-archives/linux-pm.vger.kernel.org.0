Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE34D70EB0A
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 03:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEXByB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 21:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEXByA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 21:54:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91237130
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 18:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684893239; x=1716429239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ID9XDY9ZZ6VV/5izvZWnZyzDhZy2A4dq/FHvic65Y5g=;
  b=HVKWTTU4o8PnI8TNCtx1hfvMJwkNxIGyyrhlB1Vvx5tHYnJWKkJcA9cR
   o9OPmqWIQKj56LH81xj17nAXBNUD7uZ4cqrP3y2CO0THFk0iGtBZ9bTiE
   jE0RqWl3eLgAf7nsiIVbb4BOLnFdPEtrOQPCHdbhk3tzA4ZeTPKZJqQ61
   psuvMJfHvnuUd1a3hW94lG4vt9bNPu25G4TQeaymbDxT1Aa0Chaa7UREr
   OKJRBGXa5hWLFCaHqXuffEy/YQ5iGziUE5k/xv5msJ/dhSbb07K3K/pSR
   FkpNhnNxnLet5mjt3Tl7vi5bHDXSnM/2Hp8v5Ny2q8aBjVkgjEKF7QbHz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="338008018"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="338008018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 18:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="698330633"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="698330633"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2023 18:53:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 18:53:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 18:53:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 18:53:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 18:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSg1uSzrEkLWkWNXoD8zUYdGW5+4wW0OdGUWjcwHuirJ01+CUx7Ktbt3djrmL5QV13MLSjDbGBmCHb3Qq1W/25qrKNGYMl8zUbCS0/jUI7bqhGtofudBPzad0ZqpzHskkM3F24SxlJThsbkeBjzlavgIZ2LtyLTv+KbSUrXgj/C3PcjFWIepLLrer2NmQZ8NuIUba/ZAERGYP0bV+2nuXNUUMpknSz1KpOiM9M4LsKqCq4QKzbORBDay9BFhFibaJdCiWNfkOqFYGiydeRiTpDgd25BPA0z7j/JuPJxPPvycsoCjD+lppt6VXckmlfg8xGgsTpDaB2n73seMN6Fyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID9XDY9ZZ6VV/5izvZWnZyzDhZy2A4dq/FHvic65Y5g=;
 b=O+yW7cL4KurZ2VybomLBe5nrlpKEQpEvQdEzbOToaFA3Bsg6hzRyf6JOLgPkbG/4d1rhG3ouweIiQh19tCYwE0kfNSgAQplYEdJzcUjzg0y5ZNs8jQ+Ry67WoHNEzEwU/KkaPxgKRvklxnpofnMntAtfFZlODtOgI43gM5OTpc/FmWLxq2c02CI7NiOGN9lrh4jbAM7ln95BEXXi+0OQ7VuL1pjjaaTaAYhMNurfpxfSwS5dDKjqIRj3MiWjVUOJfeNRehrnquLV73ZbmmjFNgk/Oj6GpHj9hAbMVmBpxj614S93qoDuPKQ8nNMYWvIuWH3hPuXkrRI2tmVtTO76rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18)
 by IA1PR11MB8175.namprd11.prod.outlook.com (2603:10b6:208:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 01:53:46 +0000
Received: from SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::e3c1:901c:38ca:f756]) by SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::e3c1:901c:38ca:f756%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 01:53:46 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Thread-Topic: [CfP] Power Management and Thermal Control MC (LPC2023)
Thread-Index: AQHZjNCv8wyznZ9mSUSkvn5B9y8ecK9oq4SA
Date:   Wed, 24 May 2023 01:53:46 +0000
Message-ID: <717fd5f97da6fd3ac6fa323220ab4a948db1a174.camel@intel.com>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6604:EE_|IA1PR11MB8175:EE_
x-ms-office365-filtering-correlation-id: 198230a7-d875-4f83-b939-08db5bf9b624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Suk/Pl6qlvBDIngtdP+aITdhIzSZ0JqjrL+W0sPKCyFmFvYyDJE0dNjPeHxF0Z0+SqvmJsIlo/tUCCmAtTFOhMxm40TGReb2TrzHKVncOA2TRkBNEykfyFDM79Tf58+ssn3nIxObACahDUyyZ1LMsqvcJJYXe0PRlXwdBuxO7bwzpbzTb8JvgRRMNLJ4NTprABWFNgSDUbGlzJbX1Vbr8MSVM59QyY2bZSxS6ETGNhQ5ZkCdCn7Fz8rqDp6mPK+F+bTuL4Zo6ExWB0IefqTPAmVcsYlRT18LuJfulm+q9EvY+4qlLI4xkSPLjdpYSYCy9V0KgGu4AGEB4Sxv7WOq+NcqaCdxENzYsWrH8Kia+x5rt/l1ryO7dPvyytUMrlDb/5UzS2lnNwOB+re11Qyp90sA5WC+NwkDFs2Ig5HEHk/S+uOy9/CLWppJir6vH+r0rDbNPEC8x+LmWZm8d0VuXRlmxe407tAXCyTr0tfCN2b/le5z8N66LOscweX3YPLPvnK5BEjrlaidBaqeJe8DYK6cj/EOaA6bptfBPZG/iOBAc/RA04Ghsw2iATg2ba+BVveb/CPeySb0+hLFfQ0b1pdx8EnFS7pY9irCYBh5DTOFQFY4TL9P93wZm1TlXkeK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(2906002)(54906003)(4744005)(7416002)(5660300002)(8936002)(8676002)(41300700001)(91956017)(110136005)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(316002)(4326008)(71200400001)(36756003)(6486002)(76116006)(6506007)(26005)(6512007)(122000001)(38100700002)(86362001)(2616005)(83380400001)(186003)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUJQNE5waTBXVTl3MWpmSWMvaVZadVlzSTMyajloRytHSlNDM1VvM2psajdE?=
 =?utf-8?B?a2hUSVRSektDN3NBTEYzR0ZDTytaL2VTZGxjMXdhNjdkZnhMb0p2MGN2V2dG?=
 =?utf-8?B?OVY1Qm9tRlhoRHlyV0tuWUwvRUU3SzJJZEtmSGdXNkcxdXZaME8xTXFSZ2xF?=
 =?utf-8?B?Tm9KYW9KdUFLZlRTT2Q5NExBZ2gyK0hjU1NwMTVDVm9IZ3lJTGxSQlRwM08v?=
 =?utf-8?B?TElCUEhNNDIya2I3QTc3Z0ViWmZYOVd6OUpMUXJOa0wwaHlCb1h0d2ZUN3ht?=
 =?utf-8?B?TUtZV3ZVbURPVUJVZ2t1eDBmMDVDd0xmZ2xZdnFMcjdENW10SlBKVlZjdElx?=
 =?utf-8?B?QXhXUHpnclUyMHlHOE9pVXN0bzh0S0dIK2M4b1ZmR1ozeGdHNTdzMHhmWWtk?=
 =?utf-8?B?Y1lteHEvT3hSZ0xkczVHeVltQ1BwV0J6RmFqRUxvdHhHLzB2cU5ZZ3JqNnBO?=
 =?utf-8?B?VkJjRjF4M0xVZjlYRUNkbGg2MUMzalVpTXJxVk4venNNWEJ1SExnVmJVeTNP?=
 =?utf-8?B?bGxDSXlvaXV1d1kzZ3M4dGpMNFFOMG9UQklIRTFuRE4yNnFvdVBKMHdlb0wz?=
 =?utf-8?B?TkV3Z0lGK091ZEs0UnBKcFlGVVF5endxeit5Sjc1WHhBbkFWSGRMYmZQZm9I?=
 =?utf-8?B?V0NoKzJ1dzFFSDhHNlNodlBFWDc5MVhCODhTeGpSY1VDWDRoeFNqTWkzVFo0?=
 =?utf-8?B?ejIrTzZMSlFZV2lyM1cwOEVZQTRZb2xrZmk5WndvWnZucVhBNUVFM0p0eW9W?=
 =?utf-8?B?MDZmdGp1TVlGL0Z4K0gwcWs1VFptbmpxY0k5cUtkY1d4bGZ1RmZvMnl3M3BZ?=
 =?utf-8?B?elBWK1N5OGt6alhOdlRSK2RzNWZ6RGF4RG44b1c2SHM3R0w2Q0xTK0d5U0xY?=
 =?utf-8?B?S09tdU9MUzRuRWk1MGl6N2RtWWRhVFNWcUZLYmU3TmF5S3FJbUpIYWUveWQx?=
 =?utf-8?B?M3IzSVc5dVJDd1hWVkNYcGNuSzVObHpOMS91MmxlYnFnZURrUk1nMER1Wm0v?=
 =?utf-8?B?YXBudGxqaCtFZndpWlpZY3AzbTRGT0wwYTAraHo5ZjgvQ1UzcnM5dDdNcmxh?=
 =?utf-8?B?ZHNiK2czVGk0WU1LMFUvZzZVa3A4MzBkZXRFM3pGbVVkOXYrZWJDY1YwWkpw?=
 =?utf-8?B?eXpyb2FUbENoT3hTR2dXOTRHVDhMaEtBSlp1RzZvaTMvZ2I5c0duMmJHUlVy?=
 =?utf-8?B?YnJDR2hvaVVnbTVGSm1VZnRnRGpaczZuZHVPRXc4QTlaNmdDUzNhWWRpMEph?=
 =?utf-8?B?YXBHcDkwK3JYQ0ZqN04zd1dCRDZpOE5RZ0tSNzNqTnhlRDEvc044ZHRXQk5H?=
 =?utf-8?B?bmpwUTFRTGc4cmhxVXB5WXNhU2x4cDlZRXEyMjEreW03dmxzcVVZVXhuNkJx?=
 =?utf-8?B?QVFhNElMdG5xRGZ2WmhiUHo5TVZBQkNsNWtta28wOGlTSkJHVGlRby9wbG9j?=
 =?utf-8?B?RzUrK0VtaDIrci8wRWdySWpZUHE4cWZHelJQaElHTi93N2lkcVRiY0pVc3g1?=
 =?utf-8?B?dm1lVzViZXdFQWlOS3Z6Q3pXeU0yWUo5SmpUNHFmbVpxMFVBN0o3b1B1dC9N?=
 =?utf-8?B?NTB6OER3c2xqeUsxd29IMEUzYnJaZTZrSlpPUmE4T3JlZW9ZWUxJYksxMSt1?=
 =?utf-8?B?ajFkMFdFUlhNU1YxWXhkeFhUcWhoM00rbVhiTW9nYnkyMENMN2hCa044azhq?=
 =?utf-8?B?cG9jZHpLL0FpU1p4cEdZcGpyenBwWkJnTWJvbHYxanl4NjAzMitMU2FSVjJS?=
 =?utf-8?B?MDlqZ3NnOWtDYUlIRWd4WVBPbWNVSXVSNVozWEJESjhNUGFMODM2aUtwdlhN?=
 =?utf-8?B?d0RhaXRPZ0RQVjZsZHI1bUhYSTAxYlFCN1o3aC9IdXh3aG14TG5Va1BNKzdU?=
 =?utf-8?B?TjFuMGV4MGxDMnNVNDZJVWc2TnArVmltckNOUncySUhNRENyZll6SEdmdWpz?=
 =?utf-8?B?dHRickRnYWtLRGpydkhCeWNvRlllNEl0b3ZHYkdQTy9ycEVHakFSRmJaUkdZ?=
 =?utf-8?B?MnF6aEZTLzc4TmY1R2xCN1pkV09mZzlmY3B5Qm1SUWp2bkNmMUxaMGVCNHlR?=
 =?utf-8?B?UXp5bFBxN1lhdzQrNXNWZVQ4L2VEZnNyN0lnUHRiNVhBdlEzcFNVMjZpUkZT?=
 =?utf-8?B?dTMwT2NzaWtHbVBGN2dKWmtTSnlzcEFJOWM1RmM2SkhLNTdZdnE4emdSbHBu?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92BF6B335FEF4F409501DEF48D6C749D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198230a7-d875-4f83-b939-08db5bf9b624
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 01:53:46.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVXepy6LQwXSO25p8WsZjkwiXT7i+MKY3mbONuNZyagAJLXyxUxvQno7FA2u7vKhp++GJpYZBcH90EMrpU/g+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJhZmFlbCwNCg0KT24gTW9uLCAyMDIzLTA1LTIyIGF0IDE5OjEyICswMjAwLCBSYWZhZWwg
Si4gV3lzb2NraSB3cm90ZToNCj4gSGkgRm9sa3MsDQo+IA0KPiBJJ20gZ29pbmcgdG8gc3VibWl0
IGEgUG93ZXIgTWFuYWdlbWVudCBhbmQgVGhlcm1hbCBDb250cm9sDQo+IG1pY3JvLWNvbmZlcmVu
Y2UgcHJvcG9zYWwgZm9yIExQQzIwMjMgYWxvbmcgdGhlIGxpbmVzIG9mIHdoYXQNCj4gaGFwcGVu
ZWQNCj4gaW4gdGhlIHByZXZpb3VzIGl0ZXJhdGlvbnMgb2YgaXQuDQo+IA0KPiBJZiB5b3UgaGF2
ZSB0b3BpY3MgdGhhdCB5b3UnZCBsaWtlIHRvIGJlIGRpc2N1c3NlZCB0aGVyZSwgcGxlYXNlIGxl
dA0KPiBtZSBrbm93IGJ5IEZyaWRheSwgTWF5IDI2Lg0KDQoiaW50ZWxfbHBtZChJbnRlbCBMb3cg
UG93ZXIgTW9kZSBEYWVtb24pIg0KDQpJJ20gZGV2ZWxvcGluZyBhIHVzZXJzcGFjZSB0b29sIHdo
aWNoIHB1dHMgdGFza3Mgb24gYSBncm91cCBvZiBtb3N0DQpwb3dlciBlZmZpY2llbmN5IENQVXMg
dG8gc2F2ZSBleHRyYSBwb3dlciBpbiBwYXJ0aWFsIGlkbGUgc2NlbmFyaW9zLg0KDQpJJ2QgbGlr
ZSB0byB0YWtlIHRoaXMgY2hhbmNlIHRvIGRlbW9uc3RyYXRlIGhvdyBpdCB3b3JrcyBhbmQgZ2V0
DQpmdXJ0aGVyIGZlZWRiYWNrcy4NCg0KdGhhbmtzLA0KcnVpDQoNCg0K
