Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2E3CBB4B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhGPRkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 13:40:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:8968 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhGPRkW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Jul 2021 13:40:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210756429"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="210756429"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 10:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="497072286"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2021 10:37:26 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 16 Jul 2021 10:37:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 16 Jul 2021 10:37:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 16 Jul 2021 10:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j90QiPyVeh+5dbvZTndomNihuEgIf25c0t/w6rwEEUS7pKTpLC5KMlGk3XqEed4ZFpNAfYm9LXlJQ6bt9ifZgWOIRbQ1pzHUURWCACoSwsPYeLtF1cXWShK62AbaY+EmzKPyoXj7ch6+MA1mACm/s+kCXLT/3mEdUw2ObjfhmM5hi68ztA5Bqew+fW3ft7jRmpqgBvukC79mETo2c4zUkVseQ0t2K1agctrtu/8PUlGK3v0i41PLAgEUTLnxITQQ/vasVUgz3E1UdWrfOjkdyRVFRqxu4TiU8On7Qe2mdsRWQzywNgoSPyNvbeCx+pco2+KErKFNQKPU/+3cKqDxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tH36GJRqRocy54r8hyTFVbm/p3/bgpKOn+qwrD/Kb4=;
 b=n7CnuBv8AKWCfTlUNxEevt74vB7huKf+kErfzBM2Z76BBFel9UwgGGA1+Y+K72nPBlLKgs/AhuFvTro25ninrW4AZhF9DV3e6REDQDNk1+YUZvEQP1nUcbNABg3OJaXjQFDxJ6H1bU6ngEXsP4Rjc3Ref+WJ6ivPBBtY0VXMs506MaOOBgitaZzxIgyzkVKNm4Q6qlblyC2uWrGHXOWPXJXfwtpl+Bn7lJyaE6ojMZqWU4myLQOhObFb5tpx5r2inxfIUlj1U1OP/yFBOtbabRwpBZqBTeMTqMIm9+Xmton+ZdsX0yJ08oUtYSkTg64nmUxST8v4CcX4V0+o45QJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tH36GJRqRocy54r8hyTFVbm/p3/bgpKOn+qwrD/Kb4=;
 b=eU0OTiQN8RaBRFsNzQUxXrJ3Deg4hUGuMTXoPTSfB2uYjHBMtqMZQWAPXei9PRq7HfPVd5G/NJyOB6S1sPH4QY/InXnhEMY3UnUGfS4cHhJNw3/5sJd7yjR3eXfdzChcJ4wQzbttqrPRtwzBGzSMkinsxS+rAREqdkR6lGBF8O0=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 17:37:21 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 17:37:21 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Borislav Petkov <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v7 25/26] intel_idle/amx: Add SPR support with XTILEDATA
 capability
Thread-Topic: [PATCH v7 25/26] intel_idle/amx: Add SPR support with XTILEDATA
 capability
Thread-Index: AQHXdYzLquGrZ/mas0SvbUeUtZR5WqtF5oOAgAAAwYA=
Date:   Fri, 16 Jul 2021 17:37:21 +0000
Message-ID: <984DA584-7E7B-4775-A03B-8E640549E671@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
 <20210710130313.5072-26-chang.seok.bae@intel.com>
 <CAJZ5v0he2O=AAuravL8pppzBd+OTd=oGWH2Sv1JFhDfqET160A@mail.gmail.com>
In-Reply-To: <CAJZ5v0he2O=AAuravL8pppzBd+OTd=oGWH2Sv1JFhDfqET160A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc5743d1-c1c6-41bc-de88-08d948805dd0
x-ms-traffictypediagnostic: PH0PR11MB4872:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4872975E13E4E29640088988D8119@PH0PR11MB4872.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKOGm1F+Rk158TbHmOhuG64ArBGNELaOymwt9DOxB+Yk8sZ7/De1EQ+V0otf9QlykY4056OuGDccx7vtLP44fUR8YUBwbsSxQLUq/t12Yfv9JjP6sXfLqzcFdhrgDhG0G/YIHog39F97zaVRAuSXImnCDxXT4IexNEbjjLw0Fil0Bdor7TJkMhEFhwl4CFVEJTX/3/zCvKlvSCuH+Dk2E5W+2JPDeqicjviqCqWRX8u2HyT3B5lDd17wb9oDDWSsZvvKD/9/MwBisTKBNlnfDPVje3qSL3Gw1J7RJrT0FOdz5ES9dhngvLrKR83k0Q1s+FhI/gkpockwrHfc+0NOt1qRLzgzCDjTjG/tUOnF1fSl+8RByDW8Tb25geAf4vv64hh8ffjLj25YU2qKZ8lG35PXecYdaI5L2W9tcxHecWGG0UykENGMjw5SCGO4MxGiq39uJstTTOkWVXci2Gyhmhi2f8FJAG6YVETsDcHl/VBLrevr9XAJq8/loIsw5TPJfDjfU1oyVmdCocfJ9dkoKzFQf++ZsFckDzhDtYkQJqf1OjLdLmijsc/n1BZ0+xm7lWoBxVtwzBpVW0WuJqnlrClw6S4M9YdELgSVyTt9Ja6qT+ZtoVGichyZUaFuopb3wZvNtkIeemrSUPTcR2deIDcxEC0xeYp4kElo0xS+p4BYkdO6Uw7HWnbyKe6MsBCnwxsYA0Qegr+5lQUCjnxfQ3RiR52bgF5QWvOQxqa3uXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(316002)(33656002)(4326008)(38100700002)(5660300002)(2906002)(8676002)(4744005)(8936002)(122000001)(54906003)(2616005)(6512007)(36756003)(6486002)(6506007)(53546011)(6916009)(478600001)(66946007)(66476007)(76116006)(26005)(66556008)(186003)(66446008)(64756008)(71200400001)(86362001)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vpZ5S0x9xCPCFLT4OH3ddQknIqYHKB7yKDF+PDuTRG4SK/B4PmM9REv6wBb0?=
 =?us-ascii?Q?OkL5v3D7QfqglJdCt3TcwJ0yL15zOIF268K8P79+wZ8q8pY4qWEg/fqLfjWQ?=
 =?us-ascii?Q?ka7PsUmTxuxxg2j6YM+ba6qNu8KRb5rChAiSvPvSJUlpj0zic3gb4cIMnCMJ?=
 =?us-ascii?Q?MhpDaGIzgOokxF+9Pp9bYTs8P4CPULn3pnD/SaLrF1mqjXsx6TYOTKuEZSLB?=
 =?us-ascii?Q?3Beznpu5Fg5zC/N7luZu5BNx0Ohjh2TqXjsfv7yHkOm5R6NKtphCuUwRXjF2?=
 =?us-ascii?Q?kMNlK0RYOgytiQ/RRIqFHWwcQ9GreUM0w+D7mSQVsiJ1H5940NSziIwAuKJr?=
 =?us-ascii?Q?643fAC/P8b9A3KFoMLy0YZt4euaN4UDf+PixPhU80v0FwtgKbrKVcWHcvJaF?=
 =?us-ascii?Q?ZpVKiBPAAvmJskAfuCCB8CZ8UrovyBH2BRlun7YshXdp9trXUeMGEjbLsK5+?=
 =?us-ascii?Q?IMLzVM0d68+beG2A6ZKv6I6RAgwobOf/SJ6YsyRU5/l9lHlt9mBQ0cr56RNM?=
 =?us-ascii?Q?upQgZBsihGtTmi73BHg8LjWp1+g/VMsr7QQmjjAinozD6KeQa4DzoqHIpUOJ?=
 =?us-ascii?Q?IwlpmruGlBfTsNeijLPGgvQ86u3MIZiuLUtc1HLVUwFj4jTkzg1XISkOioBx?=
 =?us-ascii?Q?PysbUo5FShV1Sm1L7FQvqI3rMT4uD6T9/vfNPOJLUDd3FowXzRSRFbo1Y+L1?=
 =?us-ascii?Q?F3y4n8RWArfFbonl8MlZ1Y6QwkK6x2jR/Z6BgxOaE+lYu4KMW04QzOhOssBz?=
 =?us-ascii?Q?3GZsIjoNAV9XAscM/tvRAFDhsuhFW1JIAaoCyUy1MI6qClZmA7PhPiIMNrVJ?=
 =?us-ascii?Q?QThYNDhV5mdCspKg1JLXWXKrv3Xu6vOn8/w3QhNYjOnqm2qMPpNZ/50BhciX?=
 =?us-ascii?Q?cOBc7bNNQS1ES96bIq2HH9cTlTmavVRQW6IJPpj8qa75L8xplcTTQ0e7NBQc?=
 =?us-ascii?Q?wzElEb2syDkDpxqAoD82XobsD634LItHSgd4QJMxsN2yGx+CcmheyuB+H1rF?=
 =?us-ascii?Q?H55Im6sd4ql1zySYxsWg/N1BbXT6/9i1A36PjwQM5KLT1aaPF7AQ5dFa9h/t?=
 =?us-ascii?Q?1Tk5nlSXbhbg+c9Q0ZdMdl2tnPV+sF9uKgKaB+zf2BFFoYP+4Q3tzIFOMSI9?=
 =?us-ascii?Q?TbyQTY8kvgAPUBi4lC7IGt04zYDM9dlCKRv1L9R0IWDQsldnpfQ1Gh/ac5hR?=
 =?us-ascii?Q?YbqU0nRRRXr5n9cyNlb+LtROml4xslkTb6y8HrfWpC06fy2+QIHiqc80BgOC?=
 =?us-ascii?Q?HyuxG7IbRW6ACjZGrNayYAcl8KHHM8aGyqifzWTbpWppOUVCC0VrKPGOdGVI?=
 =?us-ascii?Q?evwex0zU4X1emd8fSEuXd4XC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD26AFB28995A84FAB05F65C90CAC4D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5743d1-c1c6-41bc-de88-08d948805dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 17:37:21.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoYGakqIGwellM7Cg20L3sSnS2sRNg2Dp/Jp1Skc/CS7lbQfONDL7A5XuEoI+KfMy764O3eFVDC6/kCxVK6mgvPYV1GxQ+IePRu93fF2Rf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Jul 16, 2021, at 10:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sat, Jul 10, 2021 at 3:09 PM Chang S. Bae <chang.seok.bae@intel.com> w=
rote:
>>=20
>> +/**
>> + * idle_tile() - Initialize TILE registers in INIT-state
>=20
> The parens should not be present here.

Okay. Perhaps, I need to do for other changes in this series.

> With this fixed:
>=20
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
Chang=
