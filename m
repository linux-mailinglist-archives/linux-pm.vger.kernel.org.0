Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1E307A64
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhA1QMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 11:12:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:54410 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232119AbhA1QLT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Jan 2021 11:11:19 -0500
IronPort-SDR: hUsK3BeZV+p9/7MpZbya0F0pJMLIIo7mqZqWG2aUVGmYZ5Zcbqlc2CeBQctepcBA/VbrQluL99
 S/NvxA9ULSag==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="159432059"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="159432059"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 08:10:36 -0800
IronPort-SDR: /ENsKvpeYEdDIdPt8AcVMudMId0Wu6nsTAcBOV9E449hAgPNWL7XACpZ0DFCIEy5f5mB8DQdnt
 c+LJ2Xr+6StQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="473883681"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 08:10:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 08:10:35 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 08:10:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 28 Jan 2021 08:10:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 28 Jan 2021 08:10:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiUp5tHHfqKjxtgyTKpBMxS00aF3PPE+edU8gZnMCzexTsCJxXN2oyVWbkj8lOWYLZ4ERaSDTkmQIN6m0Mya89ES0uhTt/W4hT6jidmGt5YFFniyyJINLSYgCmTmjlt7kpoSp7VhkU9J1Q7qdvwv+00T6K8ZO+6fNYohijMY5X/1EsvqcqYABeqrwjQod7ow6fTztUFPo5XqVeKHu0D5LCKIye1OsI7RjZDeztyGf5g9vYl/VM613YujEdm/JldWqEFS3w3oIK5VxFAJcS4fdUBRf4hzrISt2VQe0/d4Ib4HIBwuFpzRMgbKCI7loL/+bI8F2dgiCBPRexqu9YzftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFxJa1URClB+PuMmTUBmafauvXjz+oDimJtiC7QYd6k=;
 b=oCqkNjk3HJx9EZm0c97PBcvXATOZyejWZMHLtP9N0ex3IhTrLqvjwieOKiCaEHQWoKKRKA6F2gtstfFrQmNYkc+m7cHh9ejJf8fFOzrcOfw8LXFs/1rcmZwRh1BbaHnmM1whABMgxLbP5s9N8aB04018MSokSc6JOsQNgRS/jauqOOJf5wxiF/OUxDpXHNDQoVo2BF2Jx7BVt32kd5RAldSBTU/dPTPv4huiFVOULqSJeR6lEHzdKed32p319oB3u5pj3E9vRCIu6uVoY9l3clbvvgwiSlMPkILmehUiYtnas5EuGBDT9MztdUwti9Q2gQlAEPwyHoydT4M+4SeZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFxJa1URClB+PuMmTUBmafauvXjz+oDimJtiC7QYd6k=;
 b=B0vJ/8sbib3SaM/kLbRPJlE0yodHcEEK63aiDzSI5MYmrSOMjAkDpzH6PHFuYpC63PiqEVGwaxqu2jT2Lg+0dXMJWr50x/fMIWVFw3gy9nF+UMTYit9CzMfL6qbeRyOCKLHDFln3J57ExIJmdIezf++zbr4vlR+06JQRd5aANYE=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 16:10:32 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 16:10:32 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Sun, Ning" <ning.sun@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from
 the ACPI S3/4 sleep states
Thread-Topic: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from
 the ACPI S3/4 sleep states
Thread-Index: AQHW09NfsxUKqrZ4BEWmpCpTWD5ZDao9GrIAgABd2QA=
Date:   Thu, 28 Jan 2021 16:10:32 +0000
Message-ID: <E5AD5576-1E14-4B7A-AFF6-B3BB2E9335DC@intel.com>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
 <20201216174146.10446-5-chang.seok.bae@intel.com>
 <CAJZ5v0jbz16DQg6CZr1hp-ZgUJ6gJOw=4AUaGeqeUk2UD7U_Fw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbz16DQg6CZr1hp-ZgUJ6gJOw=4AUaGeqeUk2UD7U_Fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca8d7376-d1c6-417a-4071-08d8c3a73d0a
x-ms-traffictypediagnostic: PH0PR11MB4885:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48856F194919D902CDEA5FCED8BA9@PH0PR11MB4885.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfufvBBM5t1o94a82g4aLVgDdq8NNzFdYoc3CHTCiDYCab4MaT9cS/aNCHAmVts+DSs6l3hCNc4jVp7k4tmxPfYOI+gL+MxktXqhsOe7+/kVi2VNpcz2U5Y4zJDAWYwGr39jXNj9ek6hogr1sEG81UQoZnacZvrlwStekQwyAO4D87uQ8vOF+BtgirVkMWKiapjMagMUTKMZy9ygvBlIwq05sIFObEjTc/OuVXBCzK0WWXJaJa+BoXVXwxE5tvUXAaks19QXrBc+c4J83EsR91SX2gn0Ugim4w+8HsMSmBl/8XxHHJ8ZKG4NFj1NNqUwETUSfCxqrCYneh41TLdXonV5p3OCCDns+TO0DejZnA7znyC7Q4VGtVT6SvozVsRQsJMKz9DKXukPPbVFBUa23i4B5JgoMkIGKxhAfFPDVX7tgc8H1iNZYEssmP8cBJY7wODhp3BZdfGTDLGztfZ7i+7F8X4sh/IsxzX/pU1pkPuFKjTvje1u9wdUvgl/yRbA7IXIwXPUt3Ijahvdaj52MdqJ5XCLLk88p/jJFpFqHzIMawaPEPY97N2nQ+z9+owkJiu8sFKLR8BU8ZT+ejYvIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(6486002)(33656002)(91956017)(7416002)(186003)(2906002)(86362001)(8936002)(6512007)(6506007)(4744005)(5660300002)(71200400001)(478600001)(54906003)(36756003)(6916009)(4326008)(66556008)(66946007)(66476007)(64756008)(26005)(53546011)(2616005)(8676002)(66446008)(76116006)(83380400001)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v4EKn/yUojA22bhew1+J/K/2cW/JQB7r3XgPD4FHwmvrsgALkYUNJsZdSFgg?=
 =?us-ascii?Q?WV6EWodv6bFvRUublB++bnJf0hp+8e9aC9O+75hsr11OWp2G+BGQiSBD+JZJ?=
 =?us-ascii?Q?WOTQMLCkC3QGA501LlK3LfMjfTpbVCJEkRir72HwBzsMbvVKXy0CDNcxYW6d?=
 =?us-ascii?Q?f7zEjrS33Nwa1eN1SDps1Zi88L8xQZ9W1YqXqkGufnYbcag1SenSyx2Q5q8r?=
 =?us-ascii?Q?8aK/hATO87Brkyug7DYKYiO4pw2JGbNH72hY986mj+5+G4e6vANdvX5m9ck1?=
 =?us-ascii?Q?Jj/MXhGKETgcpuRlUe7VKJq7MVFoOoC+um8LiSlvL3TNRkRnxMRvdNkGdGnL?=
 =?us-ascii?Q?ZBCB0Uo8OkFbyQnPNwucjvxuPhi7giYCrNmfJjA1Vxgz/ddSmkk3VbZkoVUS?=
 =?us-ascii?Q?ZdNwDspCflP4ApFKvMVjEbWjhraMft2osAzC6F6aWumwHMCZ1YVuOVJ5tISa?=
 =?us-ascii?Q?8jVgOJeQe0TiBiVKttSs0AtuiCYrosHWcKuE8GMZUji769M2swb5DAFgOoAn?=
 =?us-ascii?Q?fL8qxfVKUQ4iq7A9xyiVK07qQ2grmYsnSjAx+T/cXxrPotXFSlNMISU4qtRE?=
 =?us-ascii?Q?KCikRum9dreLHUIRFOCBG7RTw1Z/qOXH+36Hf6tqk4XNNNt+pbX/sh29v6JB?=
 =?us-ascii?Q?qJ0S+GPselcSIn6qgPcr6Fwet1p4mN273NAMdElcuOjnDhhVd21y4xLqlpqT?=
 =?us-ascii?Q?BArzkTczJUxulw60rCE0AvrlqSHnTWo5uYpKV+/GVvk0K6QSf9K3j6ldU2PU?=
 =?us-ascii?Q?bapHTLdoAxJEbA/UZP1/Ek10e5xtI0aNBhf8O3U9w8Xqy6knxU/hGd2EsfPD?=
 =?us-ascii?Q?0m86wTyvlVug3uKYwBr3me8iTmQ5UJkBB0csvWE7DwYSRogz0SO5qB9pOjM5?=
 =?us-ascii?Q?ZvVyalmkI89IeMF2HebgA1FQ+mrMc/wb+jHGjRMEhypv7ztuh8n5NRCl9ipC?=
 =?us-ascii?Q?zPsiYY75v0m/FPkGCu6g3QEv3O57wnjrd4xOQ9NddazZnUlGRIirIDAbByYe?=
 =?us-ascii?Q?cY6aGJWSVMfjQxw3wqb0oIOeAy77MVT5XJzQQWAnrSWo2BS5T5h0gjamRw7X?=
 =?us-ascii?Q?aQ/JyNFTYB/9kLyERFyuk/BnaIiWjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80B41AF9BD59E748BAE5959E1CE4E76F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8d7376-d1c6-417a-4071-08d8c3a73d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 16:10:32.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Wf/F19pqruWnryeeHwhd+kMTM85ukH5TPC6GvW9otMllUpBWMRqH/0C5PWpuszZDSdX4iYvNJwSHy5rSDsEAW99u8KuxOTz9r+NS7HeOgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Jan 28, 2021, at 02:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Dec 16, 2020 at 6:47 PM Chang S. Bae <chang.seok.bae@intel.com> w=
rote:
>>=20
>> +       keybackup_status =3D read_keylocker_backup_status();
>> +       if (!(keybackup_status & BIT(0))) {
>> +               pr_err("x86/keylocker: internal key restoration failed w=
ith %s\n",
>> +                      (keybackup_status & BIT(2)) ? "read error" : "inv=
alid status");
>> +               WARN_ON(1);
>> +               goto disable_keylocker;
>> +       }
>=20
> The above conditional could be consolidated a bit by using WARN():
>=20
> if (WARN(!(keybackup_status & BIT(0)), "x86/keylocker: internal key
> restoration failed with %s\n",
>        (keybackup_status & BIT(2)) ? "read error" : "invalid status")
>                goto disable_keylocker;
>=20
> Apart from this the patch LGTM.

Thanks for the review! I will make this change on my next revision.

Chang=
