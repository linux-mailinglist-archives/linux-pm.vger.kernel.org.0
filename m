Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE623DF6EC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhHCVcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 17:32:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:7376 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232604AbhHCVcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 17:32:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="274844540"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="274844540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 14:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="670663895"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2021 14:32:32 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 14:32:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 3 Aug 2021 14:32:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 3 Aug 2021 14:32:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C34EnpMMP6Hs+1JM9n23EDZBd+L1j1M+u1AKHey+pOukDV1byFrP5OeepTKBPjKr1duGUIxXc20pH8lk0kfLfjmsTrRaqhxjgcZSYe82RFU2q6KRn4+qmzH6Gb6bZGILEKzo/5ktA/iJp7V5rbqtxbaaqEwciavFfnhQPz3XlZ8ttIzC/CTeSqbdXaXfBiCizc8KkuXDXW1FxxSU5WPF0Kz0FlBgvbMg+lFBB9GwFkI3mYW701GOCAlsjwvI75hnmMd+fIdIToljUIN5mGfzruWi3KJdoOLQyv49CFnYrGvAdEaFK/AW8okqEFn3GnUfB632Oyf4SrJ/Lfg/pmNBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poPLlURJwWSrOCLoM/m3/n3hSXTrH3Y64vv6zh+m4Fw=;
 b=Tz4rV1iuMwvQQdKmhaI0ATEHWLCiu13BvLmyOikGni9QiZiBYkPtkHFW9gdqBOen4YpWhDDuF3XBnVmsdNglbejfmRwweF1KOoVzkPWycnims10RwnlfIc5YJvNIfleYPbwVYwvx6qOWwpquSRNBH3xlDDsc0oGWDGrdsybTxjD1UCFNOb8N4pxdRJWkCpKpOr9nAMDlj2FBNntldAv8wMWY12HRImQ0d5+Yt3PUenS0s6mlj58yhhSYvYd4eUwQ9kQIHWQs9+ugG7TSW48BKwgYsADKf5TA+2PulCmQok2RQQJ6pnnythW0xHeT9G/ZQyTUAJhgo8lHT83ky2Z2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poPLlURJwWSrOCLoM/m3/n3hSXTrH3Y64vv6zh+m4Fw=;
 b=M+nNd2kV+2C3sOkX/EFB3+M1PNMkL7U30w3F8Qh4OM8fr6QVoNchve/MdtQqLPn22Z273fNcqUHvY0NAaTS7wdt02oFkZCM+AgwKnaWqTv6HIJw1POTvC2z0HwUn5O/4SzjipfYFyyckvhPbt/pvymJOrUpMVctWO7l9SOwoZ/M=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5063.namprd11.prod.outlook.com (2603:10b6:510:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 21:32:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::9556:fff:9e66:26a4]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::9556:fff:9e66:26a4%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 21:32:29 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 25/26] intel_idle/amx: Add SPR support with XTILEDATA
 capability
Thread-Topic: [PATCH v9 25/26] intel_idle/amx: Add SPR support with XTILEDATA
 capability
Thread-Index: AQHXhVR149TJzWjXb0+t+rLnICh8Iatb2nWAgAZ5AIA=
Date:   Tue, 3 Aug 2021 21:32:29 +0000
Message-ID: <9660CC2A-F09F-49BF-B5CF-7288B726C88E@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-26-chang.seok.bae@intel.com>
 <f17eb0da-c77e-cc95-b88c-6947a68f5f9a@intel.com>
In-Reply-To: <f17eb0da-c77e-cc95-b88c-6947a68f5f9a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32e62206-30f4-47a9-962d-08d956c6325f
x-ms-traffictypediagnostic: PH0PR11MB5063:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5063621DE389A17A5F6190B9D8F09@PH0PR11MB5063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IObvAlodlRZQMCdRhullDJhzmtHGFMgmUCTMMD4sWqlGnuRiTfX3ehfRVTCgXpGNjSFhiNWbA86ttavgnqIYvvQ9rIt96v864yCmeOObFiEQNht5F6wZ0K3zVPVaqCvOIOhnwyxgd/BOLH6iebRzdteX1UBTzMdlBuj7pHrNWPlqEKLC1QLP8prYT3keuN5ZlVb+7TxhJVACdKVsKh8eT7Xbz3zwpRl8aQlCeAUIpW8VvNQlQ/qciAvX7Itz3QgAJCxowWBWNSuvMXWn/ZzCa7b1Jb2788R6u0VSZD5cPqf5+G/hNv4qndVsy+IGB9cxtwpSr4iw4MAv5RQvKW1CLCxmZ/QLQuqW0DQBLkz19mXt4oFaKTn4vRJAJpdceFSqxwZo47QgnlIphX0fY801+94eng+1L+BW3Z2hUG+u0kJLt0dv2QyOPq2fdNt16v9mFKjf2HpNR5iYDuH25qep9mZtwwMsP5E8qkW2FUBzAy9hjR6EOD/pXLQ7BPMjZGd5oELrHc24yhQLHs1apo1wbUNydIX8zpb5dk5hpoYt33uZv/1lPTL0I3IU54dh2lxa82B+MfkDk1bIMsg9RDMiFXMxOzY9LTw+IgI0ev82HFDtwMPx2HQKxvxyJ07veMytySne3/UXNPICVgDIneU0OU8tLSa4MbgoJtJIq5Out+ZImumMqGJjv+FR6gyb9X5+X/OeQ9F+eW9Ol8pGlY8bgGtxIhHBfc2KDTvq0/kbWxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(83380400001)(2616005)(5660300002)(6486002)(37006003)(6512007)(54906003)(64756008)(66476007)(66556008)(4326008)(316002)(36756003)(33656002)(71200400001)(66946007)(76116006)(2906002)(66446008)(86362001)(478600001)(6636002)(8676002)(8936002)(6862004)(186003)(38100700002)(122000001)(38070700005)(53546011)(6506007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LD07wdXwYLwq/TmkMEnf6VsAMiMzV4PffOdL7wGaI4j2BX3WUsWnufYYWszE?=
 =?us-ascii?Q?PmvkLIb48wNOKkPNKnL0f8+oJWqjnhn3805nFWW/l4Ew+6TQ4bjozG/cgC2f?=
 =?us-ascii?Q?wHsUt4H0KeSCppYWM2GR/Fsj49dS4e4Mk4h2vSfn6+MQN8PmuspKFRTuSToD?=
 =?us-ascii?Q?UCklL6UOUS8JxlEG1Cp52YO7Pk5GspYWN2U86jVfn20CGX31+YDBPe/6aE5m?=
 =?us-ascii?Q?gOWPDKuD+7ZG3h3/MhYPvxlMV2/yfNDF540IE3DHhqUevg1Uji4X/6r/bGaA?=
 =?us-ascii?Q?7F4NTT0nH5H71W+GIfkXN9onGD4FJJGfAOiF/FF3LO8yOFnqxvRZNjwMptgV?=
 =?us-ascii?Q?BEiGaPY3N3+z3H+vpPL9vPBDDNhrOHAYbuVQEoYMnbLMQx6lcKC4knIXk1jO?=
 =?us-ascii?Q?iNEiwwFb+2BWA4DZB/hJW8p0gVJt8KPABtXup4ii09pvs+3NReMjtc0VuFOM?=
 =?us-ascii?Q?0Wgyl0dRobqWYVyNIGB3YAVLqz8lFdh7qH/KUYGOHa//Z1HjuyVJb9ZCg7uT?=
 =?us-ascii?Q?KKlRWG4hGiyTojVHm627gBNKIlM7H6VRvC6IiFs8bXWIVtcFsCd1A2uXnfhI?=
 =?us-ascii?Q?G16UbfvI3Kf78S74jA73Rlx+8Zh8bL4fsepJgFXPj2dgV5zmAuJSoMz+TTad?=
 =?us-ascii?Q?Vv1Ek7js2G8apLxNnwwMsoE1KJzVbS/lfbJoVV2mVPY77abW6dvXxD9bx52j?=
 =?us-ascii?Q?QgRt7Z6sIEZWJSptBIG9X7GK7OIh/HHaICp5c5/nfE8UBOAh5f6+UMw/durf?=
 =?us-ascii?Q?SgnEb9Mvv/FIBcx9bAAIKQDOJBBBbOfMWhrkVuS8QnZbpCEd+18iGUrtJZAf?=
 =?us-ascii?Q?yvWWhqvEvSFEopFgIUoPjYyvDFbzI3HEXkKTcC5MLhqkJzDdrDoQX6jYTxai?=
 =?us-ascii?Q?6TB1tQ2YJOtX1YfGsI3NWr9W2aBHnzimj72gX2Wo24UEpyLaOqSEHv3TBuxu?=
 =?us-ascii?Q?75T+WB7yv/XbfbzqLgc4HO+A2pAhqjiTKKex4Z9Zb8N5jeEEcU7A8uWqshVZ?=
 =?us-ascii?Q?F7soiLHMW+5kgFfxFQKDCvCymygH0UyXMM1i+UkXIy+J88tss/OPETjr2AnR?=
 =?us-ascii?Q?+u1NopZVFZzAJMTO9pWhauOoLP0BSUbWnv01KeSSztcPFJZEjiEqgF1SLeXj?=
 =?us-ascii?Q?eucbECm2C3LluSBaRkhrAGzLYXSohfipBR+QP3XYtGkZ9B43hOMpNW4Gnzgy?=
 =?us-ascii?Q?zv2kypo92RMN8n97NcWcHKE0z0FDbNHSfnyNxPjmCbhzt0s1Xp+AfmoOAtv4?=
 =?us-ascii?Q?TwkzrQNFFLPtgNpGqT5p4/JwOIyUs8gxUK9uQVId60A1ljWLXoVHU4RDLHuc?=
 =?us-ascii?Q?vLj2o5oFyVDzYEP9sUbH1xr5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3C21616BCAE3948B907DE61429A3D62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e62206-30f4-47a9-962d-08d956c6325f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 21:32:29.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ae95JverNDepV4SVuAARjf2Y2CWAOJ/z/Ol16tI7WS2nmhsGsJWJ2XpwIprgiEumjYmy0tgZl9zmunBc3y0ciCgxPdgwphIYws8IRKrJAms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5063
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Jul 30, 2021, at 11:41, Hansen, Dave <dave.hansen@intel.com> wrote:
>> +/**
>> + * idle_tile - Initialize TILE registers in INIT-state
>> + *
>> + * Leaving state in the dirty TILE registers may prevent the processor =
from
>> + * entering lower-power idle states. Use TILERELEASE to initialize the
>> + * state. Destroying fpregs state is safe after the fpstate update.
>> + */
>> +static inline void idle_tile(void)
>> +{
>> +	if (boot_cpu_has(X86_FEATURE_XGETBV1) && (xgetbv(1) & XFEATURE_MASK_XT=
ILE)) {
>> +		tile_release();
>> +		fpregs_deactivate(&current->thread.fpu);
>> +	}
>> +}
>=20
> This isn't obviously safe code.  There's a window in there when we have
> bogus, destroyed FPU register state but where we might be rescheduled.
>=20
> I would assume that preempt is off *somewhere* in this, but it would be
> nice to make sure of that, or at least mention the requirement for it to
> be off before this code is safe.

I can see preempt_disable() in this path:

$kernel/sched/idle.c::play_idle_precise()
--> preempt_disable()
...
--> do_idle()
    --> cpuidle_idle_call()
        --> call_cpuidle()
            --> $drivers/cpuidle/cpuidle.c::cpuidle_enter()
                --> cpuidle_enter_state()
                    --> target_state->enter()
                        --> $drivers/idle/intel_idle.c::intel_idle_tile()
                            --> idle_tile()
...
--> preempt_enable()

> I'm also not sure TILERELEASE is *technically* what you want here.
> xgetbv(1) tells you whether a feature is being tracked by the processor
> as being in its init state.  tile_release() gets a feature into its init
> state, but does not guarantee that the processor will *track* it as
> being in the init state.
>=20
> TILERELEASE is not documented to have an effect on XINUSE (init tracking)=
.
>=20
> XRSTOR, on the other hand, is at least documented to affect XINUSE.
>=20
> It sounds like we either need a documentation update, or a clear
> explanation why TILERELEASE is being used over XRSTOR.

TILERELEASE impacts INIT tracking at least on the first AMX implementation.=
 I
agree that the documentation needs some update.

Thanks,
Chang=
