Return-Path: <linux-pm+bounces-40424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB19D01623
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 08:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6435D300FE22
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C733C53B;
	Thu,  8 Jan 2026 07:20:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2119.outbound.protection.partner.outlook.cn [139.219.17.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5C275B15;
	Thu,  8 Jan 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856834; cv=fail; b=cKp5g49QUoIKIGOpN189/uu4fRudtwRIxDQJJgA3rYFFvjgGPSKi7sz/7fxJw8dZM5/tNaRJ9UP+2vZvaOkJwEkS9oAJT6ASxd5CtxXfQMS6DnePt6VjlWn5lVZRoVh63MEOy96UfSBuSCbOKJiBjeC8E0s6kOWBHB5p6ItTKM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856834; c=relaxed/simple;
	bh=8YS7cAERguh+0qJpZFSD7TPl1/71Dirr95Pk+7xiU8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/QGRhUiq+AeRN2/TSJTildWT/GyJowgtCXxsEzLH53vxcQ7Nk9CgYCCsUE2ShW9TPH/ZMzZApS/ee/pdYoBd41K/ebchxC5mHjVqNkj9cmw1ri3bAKzMA1wT90cM3NNWd1hYeoXoPoJ+JkwhBQsslMqwJzeITAhmvxFlw7VI0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVVhKeMplCtogZnQBfp6msEJ5EnrWv0+alyMO+byaNT10Ui+N1uWksts8aCcBfMUoUeOd7qRE3n3jXcUCk+Z3ew2VUHM9zV0pXxadMYDtAO3DmH/BEERAhBC75XpKuAOhRj5BkpSW6SlCrnIhG5L5CmXHCd1mAlQRPNh6IVByZL9P/rbcU8XwU/5+kelglhJwkqctebVf5UeY40rjT4ET2vXha5/H41zPFhn+VrOTUIvnSCPFJkT7QdaYBcgLrlz0fKF0DBHpUsb4RAUdZ3XlCZoM0UxzIOR/fevH4wHOhXvM2JHrV4RMStRC96284+wyziE1ICtPHXIIL0nU/ARjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQCJLsIB/71gsvi6bnKwRVwWdeeuHsPQ9cn3PgABLAY=;
 b=XIzFZZ2Liw+5ZuJ6v10oKgdCibftNkGoJTnK5yCPCf1XAiyvExU7jJjx+1qxL8IAuzGpTA7pn3H9nDdRgHMhJBlx5ANrOTi6BmRg0VhAHovmdfptSGby30cpmj/mmYVlew7e42geC3eKCbXBgKV0R3OttgEO8RkPhcTSQtXsfAlzhWZtRF8xab/90P+BCnhrqSXH9+y8j8xtAes/PfzlAh3YeuZx0wZnHNOzOqFwf0cg+caWS/mX8bRNMtx0CbkSY6AshmEmsPNMcPIbuwhrYVDLXBNhGsGO66B8V3D1MJjxwznvxCBFN0NtFSun3cGiW69x9jUuwUHSb/raBE00Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0842.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Thu, 8 Jan
 2026 06:48:07 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Thu, 8 Jan 2026
 06:48:06 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "rahul@summations.net" <rahul@summations.net>, "anup@brainfault.org"
	<anup@brainfault.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"pjw@kernel.org" <pjw@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "rafael@kernel.org" <rafael@kernel.org>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "jms@oss.tenstorrent.com" <jms@oss.tenstorrent.com>,
	"darshan.prajapati@einfochips.com" <darshan.prajapati@einfochips.com>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>, "dfustini@oss.tenstorrent.com"
	<dfustini@oss.tenstorrent.com>, "michal.simek@amd.com"
	<michal.simek@amd.com>, "cyy@cyyself.name" <cyy@cyyself.name>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
Thread-Topic: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
Thread-Index: AQHcfu35VvAr0fQuSkK4e06gnDRDPbVHn32AgAA3xQA=
Date: Thu, 8 Jan 2026 06:48:06 +0000
Message-ID:
 <SH0PR01MB084174DCDA011CDD9D6557FFF9852@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
 <5nfljdaewlmafydt5a3jijjlr2krszbnadmjkpkgo7in364yzy@tiejhive2siv>
In-Reply-To: <5nfljdaewlmafydt5a3jijjlr2krszbnadmjkpkgo7in364yzy@tiejhive2siv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0842:EE_
x-ms-office365-filtering-correlation-id: 8f83bf15-d8f4-444e-1fb0-08de4e81e117
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 5oolhL16zFdMQ0QWdgM//yZbTvozrDY2oLmQpxSqjiD2xm9U3p02844fwdF/gwnWJzLQyEEpil+IdJ39leaRlOJv4oNxfmM+lFB/g6m16nrEepbHoJOHs3VKSxkxMlcxd9O2DM2XeCBb9sNdgJ7rcezd9qNRFC8NCVo1UZfqfU0hQlQuzA4abUQ1y7YhhKwFC4vBWcwANOukkgQN5EhHETe9Lx2ZseTrvqriGg3JQjFRy6T/DlUwdk3mPNTFVEPNzllRZZC7YQQ6Fqru1WASnw4ZAjR/r6nKpppd3H/Wix3cLmzVH1GPZpRSZ/C+CuzdESilu3zcMv6z319tLU099w+2LZ5wO0UaEqWGpFnbUg6O3wOwdeAE0n9c11kTyjXQxdHTdyMWRzmjxi4EK0UymW8MHORsF3vM4IuA54Ozp9ggizul7KL0hwswaSV1D5bU5xaC4PVYK5+PNx8TvqHn10+69X0eICgwSdNSx6TxCzR0vV6aWg9Q4f6tzuo7KWgD4lALDP9gu9fRq707Hf+nrYI3vrfunsB1fVLeVnuM6dpQtHD321wFnWUl1WEHqFWN6vPht/iGGNADbL9RWDZ8zbjXkxbXJKguDP+XZljDZgQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2n0fQCJ8tPuqnXAreHxEqrhqTRd/FE7NVJYnbA1RiGD5fIuZRAYlMCmI7lzJ?=
 =?us-ascii?Q?+GKPNos6lscbpop0Nwv/c1K9yagigljuTMUTsXQzCx+So37QA0yyTOFUsztu?=
 =?us-ascii?Q?VimracuAM+QPUNxg4E/Bbxmc5C8nJV5sJUNyyi6lWmEZx58KUE33dXkD01/a?=
 =?us-ascii?Q?yedB8nyPkxkq/D4AeWhWdH1MhSNrM3F+187wfgg5F4OAJ6Dqmox3wCyDuMIv?=
 =?us-ascii?Q?4CUBx08SPFkh2W58UCR9kBULvAgHaAHi71xD9Q3LM5/lRHXO4IQn8AuNKpd2?=
 =?us-ascii?Q?LAsyKGTCoZeONYbEPkzGHWdyrBwABiLoyIok0O8jTW/xj3SEUXtthgBM9/hc?=
 =?us-ascii?Q?kYpXUwfwcrCeRw9/fXSVWgYzf/S3PUzy12yhqf6Ad6VujQWrVk7N2Js1KuZX?=
 =?us-ascii?Q?Ve6IHktXegAnsSa5RDvSwMf1h8Z4IfdNAsUyIMzw358+q4dd4bUqCXEfL+wu?=
 =?us-ascii?Q?GtXVfYozeUG4siwhn/6rhqD+7LslcLLKRtfG/fnWrXlTSdP92Rqxscsjsvqm?=
 =?us-ascii?Q?NBrHTA2RPrkc0bmyoSCep+t0mr8wd4nybFopUwLu9R3YjHA2bt1qbuG7hhg0?=
 =?us-ascii?Q?j62+qNPTaVevpX3Dk1QmOGyTskwccEOpnJsd9KPP+OMQcqqAYM6/QYEbOPp/?=
 =?us-ascii?Q?UbXBH8v3lMRVcLwrHol/fxJDRqnb3J3xVfhy5c8vW6cSPHAob4yK2TdJdVdt?=
 =?us-ascii?Q?k8DhsJR/oESLLhdTxmBwtG/6BMmaIt88jC8UmlnOTqAWf+bIyr+0cOLhAOeY?=
 =?us-ascii?Q?KpYdlkBun3H1ARrvm/hLp/QRukbrIq5vRDnHTqJQVY6vHcJvXQrZaUjv5Ql2?=
 =?us-ascii?Q?Dx6LfWqrS+zjnA15ky6bX8yTa+Su3FfwoPP67wR0wSmg4vPCHcjA5fhI0zhI?=
 =?us-ascii?Q?I01PLB7TiqlvieB3u1T82rooQ/KVVeDER4okbvtE/qXp0yRa53OHyK5CavRd?=
 =?us-ascii?Q?yqsj/bDRuYdBYI8Q+U1B6kio747zgNDuGFghartPBBbqotfJ36pdZSmI2wAI?=
 =?us-ascii?Q?BhHjCzIQTDwxERDwTge1wpm63S5h6cZfJY2aPcEmxleN54FAT00/p96s8t48?=
 =?us-ascii?Q?qqvAU+JDrhD2nXlf6m0iFdKeYxQIiUlJqPWRFT+8aciNuaqwGiV3S8UtvEs6?=
 =?us-ascii?Q?7h2ia3+GxuIzIZZnh9o6DzCtLvpqRoCBD+bAnWRvvzEMfL0zhV03Xp2MI4Fs?=
 =?us-ascii?Q?p1VSwD2XWew1h53cq4s2/HbW5UErFjH4BgJD8CxPd4OpqO4XSBlmWpkVl7Qz?=
 =?us-ascii?Q?zfJlIZ8JccLCTCLT2Jc0g69Soq2sU5I+jACEPxdPEhbFUu3mHt8CirXVAGod?=
 =?us-ascii?Q?wEKaPBRgqN6ZdkQbC9KJomAS5XF+IxMXU8OaDqQ+44Tlak0qUH4dqoSHoDP1?=
 =?us-ascii?Q?wpfg4BlHG1mncg1ek8YqDekcJnNhccpom/TWTuRmMRwq6RcRJsWRZkxmkeFe?=
 =?us-ascii?Q?XaqR6xvFmUHWhiuAOLddcmiJ6RnNHFs9QIXeponVJnUL5Cm7qlzPAbA+SL6d?=
 =?us-ascii?Q?GqxRywCNHHp79loGBAPYLHd9/c0/koLotrlOyijiI4Y4Xk1rxwd4jilIELZ2?=
 =?us-ascii?Q?UCTTDZ400+fXNCcmIYU3vtWey/VSariSXYFG1Xb7V6QuMtvlepf18NSQ/Gyf?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f83bf15-d8f4-444e-1fb0-08de4e81e117
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 06:48:06.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S351Tiko76vMGiWF+hxn+ruFhu52+GwlvDTl2HdhrreLvKRwilEPa/DQmiHRz4XxW8fcaKT/8nUFsg71YIQCHu9O/DIf0YSrYfqMPqL05s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0842

On Thursday, January 8, 2026 11:27 AM, Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:

> On 06-01-26, 17:21, Joshua Yeong wrote:
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig index=20
> > 78702a08364f..9aaa1f71000e 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -4,8 +4,8 @@ menu "CPU Frequency scaling"
> >  config CPU_FREQ
> >  	bool "CPU Frequency scaling"
> >  	help
> > -	  CPU Frequency scaling allows you to change the clock speed of=20
> > -	  CPUs on the fly. This is a nice method to save power, because=20
> > +	  CPU Frequency scaling allows you to change the clock speed of
> > +	  CPUs on the fly. This is a nice method to save power, because
> >  	  the lower the CPU clock speed, the less power the CPU consumes.
> > =20
> >  	  Note that this driver doesn't automatically change the CPU @@=20
> > -65,7 +65,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
> >  	select CPU_FREQ_GOV_USERSPACE
> >  	help
> >  	  Use the CPUFreq governor 'userspace' as default. This allows
> > -	  you to set the CPU frequency manually or when a userspace=20
> > +	  you to set the CPU frequency manually or when a userspace
> >  	  program shall be able to set the CPU dynamically without having
> >  	  to enable the userspace governor manually.
> > =20
> > @@ -134,7 +134,7 @@ config CPU_FREQ_GOV_USERSPACE
> >  	help
> >  	  Enable this cpufreq governor when you either want to set the
> >  	  CPU frequency manually or when a userspace program shall
> > -	  be able to set the CPU dynamically, like on LART=20
> > +	  be able to set the CPU dynamically, like on LART
> >  	  <http://www.lartmaker.nl/>.
> > =20
> >  	  To compile this driver as a module, choose M here: the @@ -147,11=20
> > +147,11 @@ config CPU_FREQ_GOV_ONDEMAND
> >  	select CPU_FREQ_GOV_COMMON
> >  	help
> >  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
> > -	  The governor does a periodic polling and=20
> > +	  The governor does a periodic polling and
> >  	  changes frequency based on the CPU utilization.
> >  	  The support for this governor depends on CPU capability to
> >  	  do fast frequency switching (i.e, very low latency frequency
> > -	  transitions).=20
> > +	  transitions).
> > =20
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called cpufreq_ondemand.
> > @@ -367,4 +367,18 @@ config ACPI_CPPC_CPUFREQ_FIE
> > =20
> >  endif
>
> Unrelated changes ?

Hi Viresh,

Will remove the blank space in V2 patch.

>
> > +++ b/drivers/cpufreq/riscv-rpmi-cpufreq.c
> > +static int rpmi_cpufreq_probe(struct platform_device *pdev) {
>
> > +fail_free_channel:
> > +	mbox_free_channel(mpxy_ctx->chan);
> > +
> > +	return ret;
> > +}
> > +
> > +static void rpmi_cpufreq_remove(struct platform_device *pdev) {
> > +	cpufreq_unregister_driver(&rpmi_perf_cpufreq_driver);
>
> Don't need to free mpxy_ctx->chan ?
>

Ok will update this.

> --
> viresh

