Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF502DDC83
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 02:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgLRBBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 20:01:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:17180 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgLRBBp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 20:01:45 -0500
IronPort-SDR: U6kwtIUjZTaNpNB+bdA524PnoN6LLt6uoybyp0WMVpzFfeHs44gwl5ab6qoU8VA6t0SIUjOn52
 CNDe0zf945Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="155163506"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="155163506"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 17:00:54 -0800
IronPort-SDR: fVlGQWctfbGpolvov+dxg37/vmvckhKyHfhj1Mnma2Ixc7x5b1gIwzZjO4Zg4TNLyxrdMUQNjC
 evbP9xQGnUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="413692348"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2020 17:00:53 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Dec 2020 17:00:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Dec 2020 17:00:53 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 17 Dec 2020 17:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A49+Pz3NHw6hZql+FHEXUZKXfr8qJAOxen5Iz4VO0U8YwypdotuEm2bSWo120QigHCntJzdzGxDqtQDEczp+F7f/mfGru5L/j2+D1m/VueHbSBSHATKQJNTlxlj/cB0n9K1bz1vSrzQIrQOIdcQCgsAFIJpQrIMTRrjPd1L6glq5MWPjXx4na2Fk3b3rsDp2MYhp7An7R97CDi6jhe1a+SteVPrTR3ywBCVlx5ftnpP6ExNnfoZV9YM0kz/CNqxlBbu1fY/JGSDS5ueKufhmO8f90UuNp37tETZAew1+IsfqhWqiLL7OyybHVlilJRgGxGO49lAemjR9X+QN1iV5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zZX0KzjTw5odVbTGoH5LBVldg24ucj+4Qj+kI0YmHc=;
 b=f+RnL1AW1Piq87pbqU62dfSuKHAgBuVb+6qkqLJ2MpK+M5z5I/xgp7rncbZiz/C7Lc7OM8wzHp7pcscMB2T1okJi+Q8T8Sh7ngVebL57cyKbAJCMrYZ/l9Cc/8bN0rFwGbi9gMrKmnWBZZKlcI1iy/kxYwynf0PyVWMkIOLikhsf4sHUN+UmXEhXlqA6p7Zt9D/SQjq8VSSAT80OO+jnJ3d+hGUtW8pJlXDwtjpOlxPVzvC4qJnoQEmtH9lrzHOUpYFz5po1Xx9k/6SHOWt/AUhT9lOb0oY3Iv9OvlSj6q6J0HAqG1oatkBQbhrHHrPYHZH7+yTUAwCrw0subYP2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zZX0KzjTw5odVbTGoH5LBVldg24ucj+4Qj+kI0YmHc=;
 b=LxUxqChsSkfYKzJVKt7E4KAcEyOdyjh5A5G6ZeUdlXpoZ6AcemURpdM2oUl3tHrW2uC+ccUUlAcdc7183xCx7vVwB8M9fliUFFRNwggXwJICNVzMLTY6C7gl4PNfqenDHG0J8P0DETUGB5Aqmt4NJqcPdQlO7vTdcwtUpMtdyT0=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4053.namprd11.prod.outlook.com (2603:10b6:a03:183::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Fri, 18 Dec
 2020 01:00:37 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 01:00:37 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Sun, Ning" <ning.sun@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from
 the ACPI S3/4 sleep states
Thread-Topic: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from
 the ACPI S3/4 sleep states
Thread-Index: AQHW09NfsxUKqrZ4BEWmpCpTWD5ZDan7qMcAgABh8wA=
Date:   Fri, 18 Dec 2020 01:00:37 +0000
Message-ID: <B1489F7E-D62F-4693-93E6-42A13D528F10@intel.com>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
 <20201216174146.10446-5-chang.seok.bae@intel.com>
 <X9utCNc8p61tRXU4@sol.localdomain>
In-Reply-To: <X9utCNc8p61tRXU4@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [112.148.21.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a5fe86-d995-43bc-65aa-08d8a2f054df
x-ms-traffictypediagnostic: BY5PR11MB4053:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4053C41303B8AC0927FEEEBFD8C30@BY5PR11MB4053.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jV1nLXkEOz/dBWakcBQ//S1PUkLy0PNj5iUOQbo12rUSikjpPAbpm+uo/1yblnhRSMbeej4SJV7R7j0zQxR2tq7mW9tztuAQLIvCAYKKtnCwT1esjRq7Y7tQvA25D8CoH/GQO4w6C9ooHTrQVmmE5KZBPf9HXZcPS2SaD5YtAdWOW4TkKzeZ+ksZ5M3bXFk+7ZEWYc9VSYHB0XgWDNEmHrjU99Y3IVf34cXMIpsEOTy8CDknyE6SNYKwnpV8ksCsPg04TuG291MIFqCx1kAjov1BZfZ/2Or6fbcF39kYWjyK+CXR+7xe/4SQgnirqAfdwVtTi0CIylXBzfI13Vg/IhISghNzl64z3YUrgILax79ErzZ/MJzBZ5QX1M15T2n/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2906002)(86362001)(66556008)(186003)(7416002)(33656002)(91956017)(36756003)(316002)(8676002)(4326008)(71200400001)(66476007)(8936002)(26005)(53546011)(2616005)(6506007)(64756008)(54906003)(478600001)(5660300002)(66446008)(83380400001)(66946007)(6486002)(6916009)(76116006)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aBJwai3VNHqj+G1hH/23oKYVlPPC3dOgezVDF7wzRXIooYE18N2rSu6+Ib/p?=
 =?us-ascii?Q?tVG7ovld94WZhYe49A+JtZRNjI64/wfw6tyHoQZB0CU3BgzZBW3tbv1GsdyT?=
 =?us-ascii?Q?UlC3h46uhLJ/eROS/FpqtQ0SZSavwEtQHQk/NCFadXeVb6/oolKmlvSQHFBa?=
 =?us-ascii?Q?/RG6Is02NhKR6348M0qUHvlen/h6w45x8tsBwAdpK2AbziG5any5yTBbdNVm?=
 =?us-ascii?Q?Y/4xTmviMvPjwSIYZymYQxxSB5ypxHIWVWCmq5xKPGWEsuLbLK10UKfGbLhw?=
 =?us-ascii?Q?JU7KM4DNglpDFpTzTNWf6A5ri8zEZtKeE0SqnK3Q58mFuM2dkPMi6kXjbI/B?=
 =?us-ascii?Q?GK8MqHV03XYln2sT75dzNS4HlVBEJXdIxUMj5jOtTHUHAjhj5ou/SFW41tZ3?=
 =?us-ascii?Q?Y4SKb9MgGzYrpPfuoyFoyElrkGsPkHZl8rNC6sukvc3ZwTLsqRn87AJAbX3L?=
 =?us-ascii?Q?cOKjAtHzLJaRqUjvNTNkD6zET9+oW4UAZ4EuLWjpYqLBm1PSoo+K5C/lTv+f?=
 =?us-ascii?Q?kL1ivSxyyqedHrfne+lC9mMoHpSsUuEA4OX5pqnDd1yXdwJqDo6k+YxgcM5z?=
 =?us-ascii?Q?rcKy4cd2CR1MtrjIRW+N0gcYg9f2y8rdfA6SgCadvrCfc2SnS12o21xJve+z?=
 =?us-ascii?Q?3CNXdyyUvSmr9yEXrAPEip+bFFH5eLhzLtfQ6kngcAcuq1Vd+Wwi25oICJDI?=
 =?us-ascii?Q?fJJZVVS5CSI8RDQiFWwwXf1xGJG3ujc25gwGky84A+sl+DfrcnXN77pA8Lys?=
 =?us-ascii?Q?h+HzARft4gKCrNLj0SrUYj2UO3+LLtPwJX5v4EeYXCI/lgJFknHVeU+AP+s/?=
 =?us-ascii?Q?4XXZFnVY3tbKK8vVVvcW74mHPrpZnF+NptQM9irSd8o5mmPO+TuVqmvY0O95?=
 =?us-ascii?Q?d8S2QdAjE7gkiKVlbMqmhdcR5oZxOtd2CBDxkHdPLu7PASnNKqWNk6JNCkVn?=
 =?us-ascii?Q?c0Pwh+Od63T2+apB7WhtMLt9PFydnfa9jugKflJwNVtByoVl/z2v99kXNU6F?=
 =?us-ascii?Q?GTWn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <693A802E304FDC4699C95F88E0E774DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a5fe86-d995-43bc-65aa-08d8a2f054df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 01:00:37.1183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68nT5iYVtMsB2skv2OwmCT0EN6G90mpjneq8y8RFVoEuHj3GZUgaU1xtjOApi6q//T3VqZfMQJHbOviVyjnapbx1M3AdGt3TdIj6MUr5ehU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4053
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> On Dec 18, 2020, at 04:10, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> On Wed, Dec 16, 2020 at 09:41:42AM -0800, Chang S. Bae wrote:
>> When the system state switches to these sleep states, the internal key g=
ets
>> reset. Since this system transition is transparent to userspace, the
>> internal key needs to be restored properly.
>>=20
>> Key Locker provides a mechanism to back up the internal key in non-volat=
ile
>> memory. The kernel requests a backup right after the key loaded at
>> boot-time and copies it later when the system wakes up.
>>=20
>> The backup during the S5 sleep state is not trusted. It is overwritten b=
y a
>> new key at the next boot.
>>=20
>> On a system with the S3/4 states, enable the feature only when the backu=
p
>> mechanism is supported.
>>=20
>> Disable the feature when the copy fails (or the backup corrupts). The
>> shutdown is considered too noisy. A new key is considerable only when
>> threads can be synchronously suspended.
>=20
> Can this backup key be used to decrypt the encoded AES keys without execu=
ting
> the keylocker instructions on the same CPU?

No. The backup key itself is inaccessible to the software.

Thanks,
Chang

