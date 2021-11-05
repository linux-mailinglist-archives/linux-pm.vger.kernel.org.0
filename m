Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E902F4466B1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 17:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKEQJ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 12:09:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:36614 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbhKEQJ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 12:09:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="232179959"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="232179959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="490375239"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2021 09:03:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 5 Nov 2021 09:03:59 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 5 Nov 2021 09:03:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 5 Nov 2021 09:03:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 5 Nov 2021 09:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHLKMCMAZD6ITwsJpjNGXcAsh1XRBMrQ8wSwrjkVBMtz+CYiSxVFVzl132BBazF4SZX214+wCiPgQ4FRN9PRNNDIRpNdOZQEOGjXkWsPyxe0rD/4kHtNT5Vd5xMPbbXDxxMAoBIEiYvfBzy5Itiiqu13lPSqAZYoibV7/HbTZCk3Inu/xcZiyOhYQMeuGnM9K/t8QzhbevYRjhLOgkWMa3odPZGOgE/2PqLl0H1f4G1iBjS6+5B7MZYQ/CdJdbjP/H7Hw5oIbxOptYJIZCjELhxo9GmDCuGKY+l3YN60vYZWBcMnvnrNSs/KuidLX12pHC68mvYGeTspw9GmpOtTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sySoicYh/XShejlR1aLAoj8mfVMDJKQDvSADs3mxM7M=;
 b=SU36vb4lcAqebm/ep94UNVHl5emuvCGFlWTd81y+KFCtgeeCjvY3NPZirFkH7IV+Wcm1AwqlMg9s1wzUatJp32fHWMzGTNnOc2e99C223u+6DmuQkXawpFjFuA0PknxXx1aiOw7t9SOQS/zWY+zkCryploM5TAQStKaZey6WwpXFco/FV2+9xuxMMNYiqGJtRX5oc4gb1TNYVckgwIa08og4shK34RY/AMVr+Jtynt0IgNjsR60rS8XyuqOVp8Sc2m5d34TqvXuWZyRvRV0Q6zXAxqjy2H3kZ4My9GF70vm5fFQz9LV7HYxn2FFi6D3J6Erc1d8SK8LZQmBhlpZnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sySoicYh/XShejlR1aLAoj8mfVMDJKQDvSADs3mxM7M=;
 b=lyze4e5Af8UsIjynO+gToaNFshzlI3P9Y1ioT0eEhNkR6385CGxRxt3TbqS+hA/z8lqdXNvVtZ9Z58Q4PKurI6dZhdKY+670aNX8VkKc78tSZgSqa4mqIH8r1OHnom3YAUCyHx6ZCKi6RWWxxh/khhRBdKlWanEjmH/mkkq6GnA=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 16:03:56 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 16:03:56 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/4] intel_idle: Add SPR support with AMX INIT-state
Thread-Topic: [PATCH 4/4] intel_idle: Add SPR support with AMX INIT-state
Thread-Index: AQHX0c/APbc/D9rdR0CrtVWzx46Eh6v1AK8AgAAZKgA=
Date:   Fri, 5 Nov 2021 16:03:56 +0000
Message-ID: <0B7F49C0-B850-45BC-BEC9-60DF3E2D88C5@intel.com>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
 <20211104225226.5031-5-chang.seok.bae@intel.com> <878ry24qpb.ffs@tglx>
In-Reply-To: <878ry24qpb.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32a4f2a-27d3-4429-f376-08d9a075df66
x-ms-traffictypediagnostic: PH0PR11MB4870:
x-microsoft-antispam-prvs: <PH0PR11MB487056A1B688C2E2007D4CC1D88E9@PH0PR11MB4870.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXAO1KE6S/6COYZN8DVXTkaFGjucG7/SCuQN0+XXvYygnA6bTOFp8Rs/xbCHn74cXTkOEJ9F1hmNsS4TImN/w+QF/88Bhyvo+idm0gVMMrdlzC0CRov8/kHfQ+er+B2DdKPpzpk67cUttakEkH4xxK4vt8vYIDwiMguwyckxzLpEfLDIjRshTC2rdSwEQSfkkqRqfEgdws/XK93wB0EpAfGmMaJAhRo1WjoQZgzgm0h/TC5sCsp5jpvo9HSeXf8bML8LTbrrmXiObqN0366Z5c/0FKYN8nQ7hRDZFnfco7Ad3UzAmbYaryc0XRjN/Yk3fSBWuovU3quzULJBXaEpvAE39fMVhpfEmklYmEKtos8rAAMPDJc9nuZFmvm7xVEpadAcbysVNkqI3MqFSTkyDU5NuRVizIQT4eWWQpw1/B68v5udgLR+CMQ3Nt9Jo6j7aYbmx+JDq/QPBSTmH0fw6LV6TzGqwwSecWuOLSz40KsTiAf97nPWTc425ClCQ35sCO1JlMAWINzPt3ox3fuTMEcNw3UIO/hTYUFtFDym8BZhQBw4wi0O+Nflum7crdHprXLfQ7UnO6lijQZs74tBktx9MqsvYhLMDwyHekID0mvQuOzMMaS2+ib+nGmA4vUEGnkLdhwubXeanct3w5c/uI/8sPQ3NHNkvC5J9yczuJAzQjD2gsOe++vves1HwEXqvJ1hpR27AGoAP9ssFSHhfY3wUGpI5iGuP5+KnDyV0g1NYilTL/3YZRHPW/6BLqCP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(26005)(36756003)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(71200400001)(86362001)(82960400001)(6916009)(54906003)(2906002)(38100700002)(316002)(6512007)(6486002)(4326008)(53546011)(33656002)(5660300002)(508600001)(8936002)(38070700005)(6506007)(2616005)(186003)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FPEuJf/scqck7Ks56QyXk0n10kDI2vQE0P0Op0fO0TiBd+DwmR0iruJxKpmv?=
 =?us-ascii?Q?/znxvC51cr83Ihs7AO2zNNUOiPvavSHiPZdcO3gKbmQOcuUhgmN3xZG4LHFJ?=
 =?us-ascii?Q?S8InzqF5nHwnGVC7QH3gG9zSR+NuLMRDCggihGSHw9aBVlQDGrfceRhSetef?=
 =?us-ascii?Q?O7swnNu48RMkd7F+FZoupVu3vvXJ3dLg31UDQ+ey/DHkpaf1qugDdvtXjDeJ?=
 =?us-ascii?Q?9yoKy5K3iCuwSldvwlFAFk5lWba2oolAbjHFpDPwi3AhbfdzFl8mCciV1yU5?=
 =?us-ascii?Q?/OPqYljHWREQWb+6kroWZ5KqTBeAh8M7CpAyIWSFKLB85G4Q2H++JWhgUyJU?=
 =?us-ascii?Q?pedYssI1dGQi/SjkQUnALR9ARDOXU8OXTmNsoIKauOwoCtiodGLDH1t96i9g?=
 =?us-ascii?Q?WPumi2hVRsSNDfVxj3WuwK3iJzYIbgYrS841k+Z5YurYmaY83xjHCfSdlTQ5?=
 =?us-ascii?Q?NWXAmPkN6KZqZlivI6DvUTCIxYObEx9K+exMSDYlkPINrmqvp8Mv/HUGS04L?=
 =?us-ascii?Q?cQ7+X2lluQgFIe/calpvCBixluTYhpjxJopWdrF8Ng25b8aSzZIzV+S+wjNM?=
 =?us-ascii?Q?V3m5gbhNhV2F0728U32M6gfoY2/y2xc/Z5AFz8pzRS/pr8T3G2Pz8ifBmzn+?=
 =?us-ascii?Q?aIcAi1nZceCcAJccrEIRFrs8JfRVYaeLQfvwwBO8madayxfvutDCdQF6bcbM?=
 =?us-ascii?Q?zl0EQEUZ2q+gXp0R6vJaevSxRhAK4Kp3rS/pyL+Cj8fXyCOt57PPJbG/b/Qw?=
 =?us-ascii?Q?f2zBONpN2BV/eNp1T84TeJ8IKbD6QW6XN1wJRGawPEf8QbllbzZgSK4/X7vS?=
 =?us-ascii?Q?D7mxG8wBNupGwWYiNyV02FRZn0EgC/DKb8Nr6oRK8slTmTs85j3jPVrwrqgs?=
 =?us-ascii?Q?jkkH0Qr3p86XpaO0LFmS/V8qqOKRmBYk6xQDK1b4ntmH+1uV86riYpcg9nZ/?=
 =?us-ascii?Q?DBsNFi2eatY6/lT6d3CC/K1H1171dXKLbDrzmYZO6XXwgfHkS5tkidvTv0j9?=
 =?us-ascii?Q?op0zv059G3gdgiizhHeQKKwOnb8AG2o533ALSX9EhBLs07tc617ahJ8/BlOo?=
 =?us-ascii?Q?Vwm4RaI43eN9j/0CDiT1cWNKYiq51dXZD4rZcaSXVVZZpzcykE2XwK1bAHkn?=
 =?us-ascii?Q?41e6UtpCzqEKi8LVO3g5svwAq31MKcMwnEOI3S4DGxjntV1Ir+Dr2ujFhU4X?=
 =?us-ascii?Q?CGdSc/jYmfJswWWtscnn7f614I6oebZlrloZ3LPLb8vZEcGq8JH7BHjQVh/h?=
 =?us-ascii?Q?rvQZWMJW8roYOWYxE+4Pgo/bMOdvG2As9NjDaxLk+MRln9jf7iN7teT+HoOv?=
 =?us-ascii?Q?a1Pz8GOJLCpYz10NaHZYMtgg/yFMyPXCHvmwT4yTfWRS8X1sbHzpx/gHxHUq?=
 =?us-ascii?Q?uZ2lELe+8qvpinUwvuAGFu3y/nA9Ue2tU7yQ3v3jtXUHw9tz/94lzZMfqgBZ?=
 =?us-ascii?Q?5BsqZ8GErjq+R4Y/gsDQWWhkBAjtXhbVwnRlxOvnDPww8GLsaxkVpekSj4b3?=
 =?us-ascii?Q?ZLZUxcFVJohOnjYb91qwhoyHh+lXrsuoWLuj72nVf4bGEgq/dNOOESEEjPvD?=
 =?us-ascii?Q?hNhgD48A+x6rlZWsqKR2/BWQyAaoCzC898/AdDDjMfQNksUHRh/FageDCIEJ?=
 =?us-ascii?Q?x8Au7T7WdCG9bm2ZqOGlkhqdsf2UDRCHTKPgWWBpHFVWxoCbXJkfhAXZM1ov?=
 =?us-ascii?Q?NEIcPf5Fe+EXSHfmUcbecGfXsLQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05FD707CD61BFC4B9E78939D8A4D2867@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32a4f2a-27d3-4429-f376-08d9a075df66
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 16:03:56.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vNHfTP8rw5AfgQWpi1ntQphBnFNnb/VDxH/itstI9egmbeAf0dxjKuHmyn9+C6kMf+Lr2neYBBrAhEcpicYxWGXQNjqaIjninAaj151h2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Nov 5, 2021, at 07:33, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Chang,
>=20
> On Thu, Nov 04 2021 at 15:52, Chang S. Bae wrote:
>> +/**
>> + * intel_idle_tile - Ask the processor to enter the given idle state.
>> + * @dev: cpuidle device of the target CPU.
>> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
>> + *
>> + * Ensure TILE registers in INIT-state before using intel_idle() to
>> + * enter the idle state.
>> + */
>> +static __cpuidle int intel_idle_tile(struct cpuidle_device *dev,
>> +				     struct cpuidle_driver *drv, int index)
>> +{
>> +	fpu_idle_fpregs();
>=20
> That's redundant because arch_cpu_idle_enter() is invoked before the
> actual idle mechanism.=20

I think the way this series is shaped makes confusion, sorry.

Since PATCH3 and PATCH4 are in debate -- which approach should be chosen, i=
t
was decided to post both and let just one of them be selected. E.g., if PAT=
CH3
is right, then PATCH4 should be abandoned.

I think PATCH3 is better. Maybe PATCH4 should not be sent together to avoid
such confusion.

Thanks,
Chang


