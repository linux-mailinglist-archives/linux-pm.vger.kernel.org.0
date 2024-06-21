Return-Path: <linux-pm+bounces-9729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980D911AAC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D06C1C21C80
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C624139CE5;
	Fri, 21 Jun 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XjkCmPvG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A483207;
	Fri, 21 Jun 2024 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949284; cv=fail; b=o7wvL0Zloib1tp4/ocRGlCAVwN2L3Hbams+6QlJ0SPzgcoVZBaIAGH83z6NZEP/xKzmO0NquMUGGLmng2G9n7nmvfh1mVJMcelkB+BpA/kK6ATWphT3TfaGzPuj9VNt+DxxQpy+RNCRCPYGIPkgdorXthqfGu0C2QvHfVfknlmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949284; c=relaxed/simple;
	bh=B2HrHOQde2/sMS6ryIsCp0eGy6Y0TybEDOlI8ewJslg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nG2ymN0tEenpeZRtr/wqTf8lYsOL5UptySpQxpYizqhCJAf80KmYdpUfJUYpvySuLTy67nEB46rLzCKdVUGYtIGnm9jdxCcxT0PJKmalMvirQtdI4YfUf3xKMh5ovexJSX0944c08pOoeyzV84sBaCr9v3bP8iYO+16JZkxzTAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XjkCmPvG; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8RflvpkuQp8bJxMcg1eT/BOD/hv9CjjBgnBWUoZ9IU32/kMSwUD7GVnLY/KHRC4Hd7TUV9VMQMD1nNEbaVlQMxj9plXSaz0L5QvkSVnqDxDLEYRuDJ1E1VPiWl6H9lTs90+voDOYU0bUvqgch4k3fbCrC/yCQRli6RRNtqt6XLYuiKlvOkPyamFrUjpvJxcai/68l320Ld60sH9UKcG/Ah7oIQWRPxwazNqClvVO+x/DoNs4ezmDq1319L1BNql+pxp5l0oKGa18ZJGA869yvvpYJ0fMzBo7CxdJR+c6dBeKOvvZF+XZ2kRrwsld5O5aF3mTL5JNptJrusUuSM/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmXvIw/zBtg1z7yWc+jiT66A7m90x7vOOSnz+2RSY5E=;
 b=YVjrsvY1hje/PJ8BaFO9QaACZwqt8YSZPuC5SFmS8uuBvvIRUFIbEW4NEso/MQoxbkuGsFWrR2BjHZsAQsInnHZl1Nda1yUiLPooE/jUA15/TrHFg4uY8fVu5/S0zWv1duspuPWdZmvf8K95lL0dBM+WD7teuz9V6VvAMbz75GkFjUvizzN4t/AQYKIjdy1nCLLC1SC1z5f6tw3BeTC+/JZMoS6JwoMR0EFqF60SgUn5YuJOHVXW3PhVvcUl6FGDvfMiwWpu+RO/uRzf8dajhzzkgehcD1A5Avhu2I/Fpph28HoUDfpg9zi58Iu4RT4oivWFEP91WH5YN/U0i8dQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmXvIw/zBtg1z7yWc+jiT66A7m90x7vOOSnz+2RSY5E=;
 b=XjkCmPvG0r6JkI5m6/K2DbFkoBaznf9goKq+0qV/mUTzA5TvxXqjNhW8e0QJpTSUpC9rLF4Daq6O3x5pW61SeTpF/9Y0rd9wHGcK7Yw+k9vBTTURzGK5Zq1gjgZtx/slmzpsBkm23r1dpQI6TNbwnJi130MeHtYV/Hkux6Dkk+I=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.35; Fri, 21 Jun
 2024 05:54:38 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:54:38 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>
CC: "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v12 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
Thread-Topic: [PATCH v12 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
Thread-Index: AQHawim3E1OHB8D/nUmm59qB2QcSdbHRtl0AgAAAPhA=
Date: Fri, 21 Jun 2024 05:54:38 +0000
Message-ID:
 <CYYPR12MB86555AA94369C4A20B39F29D9CC92@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <851f4e8b2495f35f2ee1e848844dbaabb55411f4.1718787627.git.perry.yuan@amd.com>
 <87le2yvoqn.fsf@BLR-5CG11610CF.amd.com>
In-Reply-To: <87le2yvoqn.fsf@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ade51b54-4c36-43ea-ad1b-279ea0947eb2;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T05:40:03Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB7503:EE_
x-ms-office365-filtering-correlation-id: a6da6844-6522-4d5c-b51b-08dc91b6a2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?InURqfcZaGqW4ybCB594pqFiiSDPyj2/9fWdIuw6bNGhTRdjZcc4D+152/IZ?=
 =?us-ascii?Q?phV9//xoZErUvPZpmcGPzkrWoaTaWr0wVVHLjHu/X+wMFFqT6uyuAG/OxUre?=
 =?us-ascii?Q?dqeGxPQDm2THCN6i4tfqyq6QctrgHPEnu7BQgECN/aUJScdz+0G7yAB+fop9?=
 =?us-ascii?Q?+1xmtmrAciANUyYZ6nWezKUdWacfIrp47kJ3eNRwHc9pOLJKricxblD9IjST?=
 =?us-ascii?Q?G67sy3YnOe5/O/Wh/CU1oaiMfme9zQR5EvI81WICmWFtYDodciYJKogbCnDi?=
 =?us-ascii?Q?9HfoY3lCUn2sZdGNB4l8+OKTEFMsdN9/CR+1ZgH6JrRTnI5CVdTnDPdMqqe7?=
 =?us-ascii?Q?S4AjC/2fDgWEpH2+AN6AiIElAV8GgZ4pojt73IoqHx428T5RzE3q6z9k/eUB?=
 =?us-ascii?Q?aYd3n5JFnkp0kDr8pLGpYoM5MCt3oq1MywkkQ0ChOU/D2qdBNuGFtpKhCqxH?=
 =?us-ascii?Q?4d+G45vnklsjYUGKTxQIzJyAiIDbJVMYSmln4zpemwO3U5GMJb44ngWvpQr4?=
 =?us-ascii?Q?rekMoimT/mW9dcEmQTh3voynl5sWx1CXLr/jwYal7w4wSR79u88R6cYeZxWt?=
 =?us-ascii?Q?Kavv47e+Sjc7284G0t3JrGsBtMxE3/No7akovcsj+7qET9AcPKryUrCZ2pGb?=
 =?us-ascii?Q?uJaQYHUEduVa6YSa/shirxcSUjILwG1w/4Is/G2eCezqoxvq5J23IGaN2Ifg?=
 =?us-ascii?Q?vt6/9zKXT8DdGQgsHABpxZtXS8f5gUi7yhyWOm3l9NIXwkdVRCSRG99ptR+L?=
 =?us-ascii?Q?pn3t4JStBnERfLNnXXBjRvuWuLCuVBfDBH5FcZhwuKiV+A4C3Qct8JOwFlOt?=
 =?us-ascii?Q?vbfV7SVJYCuL/v28YzcKWVp0ZICzLaVujvw6iBmpy357MAzQ7eHfEXPCK+iz?=
 =?us-ascii?Q?K8m1o7XS66Uif8M8HvoCmYSYJKhbHqa8LQx+vJnIboBYmGEMdk/fraHlJXEg?=
 =?us-ascii?Q?KIU1i0Y6tiIXCOlrJvW4IqliBGI9xMOYawLQ6x/dB6Obhyuf6IU1QBWPzxP0?=
 =?us-ascii?Q?3GHPNkBrhEM8vloyCD5b4G36f2LUmxDte0cutDA7rdf653a7O9w2aZFtomMQ?=
 =?us-ascii?Q?XGFnaUWVxQIaIiPwPp4yOXkl4Gckx/odjw7YUqdNj1HU90wNtrlkjXxU+DG+?=
 =?us-ascii?Q?euQQWhkWypNgxHF4V/AG7POtli6GDfK3nfe4MNjU0HGAC0gDXFMCnehbd012?=
 =?us-ascii?Q?68YPCVH1mcCAuosbHIIMUCkv3JppojpNxywIOyBLqYG0E7Sszfwty8WVyeU3?=
 =?us-ascii?Q?GUUpYizypjRNn7Fmf/Uf5knA9DcVN3j6PAocCO9PdVgZGpcNuKTwi676E+gn?=
 =?us-ascii?Q?13j7rdO5jz4mJEb9289MXFTmfzPK4ymra6pF8EpvY+nFVQWcGi+06Rp3rNvy?=
 =?us-ascii?Q?Oqvg4GY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cLqJNj8z8pF04Ds8m80g1cZEl2JAJvP+HTuzI2LQHjeRUDoMO1B41UhyJMvL?=
 =?us-ascii?Q?8A+ON6Ze/opTVCX1NfoqsTQt0Y3kUckbfxxBd5FocBilJXsvudl+jO2TV+9/?=
 =?us-ascii?Q?y/q1pTuu73mk0eA5EAnEAaTlB2oetBXhAGXRqsfaujE93ZNz4bZppkAeL3zu?=
 =?us-ascii?Q?pFGO1vw1+7l4ElXNrTt9eiMjnoVeej2Nroonq0RL8Z85b5XXwvWe2va+2skH?=
 =?us-ascii?Q?rXotkO5mN1T4QG+8c1PHJHr4uNZS5ftMgGMS164e9pCSLLC4As8UxwYiA1uI?=
 =?us-ascii?Q?bDdiRDAbIKOgk9rpM5b6Cn5DKWBE8ljsQe0rgdrD2kxG6dqQ5A/tHwcehZt/?=
 =?us-ascii?Q?3XSu5FxVFp/5SkTdI2gZFrfLczVDjCk9XVC+F6oDGYlbW4J7cJ322d0sgBro?=
 =?us-ascii?Q?kWdbOF73FdaTXma6ea+meJYYtB6OGebfi/hdOKTvaxyPWziZdi51wIHCQVYU?=
 =?us-ascii?Q?B0UDz+imH1jvFBluiTROfBBWKgFhn88bC/nDTaH7j/NvDigmUm9ak5X45+S1?=
 =?us-ascii?Q?a2m5bZVB2It7KqgguhSnQjVxX7yR1NXgGeptMOODzigKoMNem+TP8ozoe1ob?=
 =?us-ascii?Q?ns3gwNr9TgVgXrhzQ7s1yFACjLvo+D8R0Fu7g0wg7FGtl+wuc5UDjaqjZ6q7?=
 =?us-ascii?Q?tPqGZIMBo0ZLDSQBIXXZ41qPaIefvfRQ/tRaAq2rFZ76WnqrHXG3q6eXIvXU?=
 =?us-ascii?Q?CQuYX6E45q5nGErsRq7w30Y1HKDfwI9Ex0AMvLOW6UQ7HNiS3CnGoEOSydCm?=
 =?us-ascii?Q?8zi3SG6mYy1TM7RwaBuY8DAco2/wFt8MiLXxiocSMDycViedx9/ukK4sFsJV?=
 =?us-ascii?Q?+iRp5XZ085ZeJGywwdLxCkOe3MN+OXl5cQJ1FJ1+XxoO2oKc3PtWEq8V86HK?=
 =?us-ascii?Q?6wZSWYsQN+USM6te3AAgNtpdjeGycOjUpvQuYNAOOAn8pxw/ci58Hsc1fpLX?=
 =?us-ascii?Q?htW/XbuW7O0K/gVqH7J64yzB6kKecC5KawEcUS8hKhwNhnR9gK7YaxaeETSm?=
 =?us-ascii?Q?YtxSTBSDtL6GpP3H+p3vYnVWfCgpebJTr+bn7ZFcDYkrtWuwJKB5sl7jYK+w?=
 =?us-ascii?Q?ov5KDwuh9uSnhtPn89uHLWoj4lHg3JR6/iH2QJw4CrFWn+pvx3F7IO6Y88j4?=
 =?us-ascii?Q?E8v02cLxE1eLV1dhJwMN5zgGZxBbwgNVS1nYSMzztgSAqaNmvFDiJzeMwHhK?=
 =?us-ascii?Q?tP/yXP/SF59UfezS9MZEhvnh772qgzfdXLHgfsUSX3axZum5EQWuAZ8KoqFj?=
 =?us-ascii?Q?1sO8Fbvgc3orFWa33xB/loYM/Ur3tYkvqB0a/CpNXSiaJtA/FMrRwzAfCKr4?=
 =?us-ascii?Q?bH/yPepgUsTASt6D35WvGs4+jis52rT/DL4xGQPhLvxkkaASjxptxwXCblPs?=
 =?us-ascii?Q?f2nzjs5RIB/CYHVVk2r9D/ZvYtGdbu4YNNLvj1HK1oX0xSG4e/GQOY6szPM4?=
 =?us-ascii?Q?ilW5+PUgYCRdYeOap7jrwIPkySp0ya5jyDgQQjryytlSdVUIRk+gvwH3bV6E?=
 =?us-ascii?Q?YqpLz8uxPdTJ6YUSSOl0WrTOzopPUG9SOa+hoSfcQLKjJRG0h9pt1WBUoUo0?=
 =?us-ascii?Q?VY3b1g2SkdnThjLutpk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6da6844-6522-4d5c-b51b-08dc91b6a2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:54:38.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnefNtdGGCRexU3DH4HAp8XMOJNaqD89jqC+XnJYw3sCD1lqAAYQPDPjFyZ1G2Y4hYbATMNXbKInRKo255tulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Gautham.

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Friday, June 21, 2024 1:39 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
> Limonciello, Mario <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org
> Cc: Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v12 6/9] cpufreq: amd-pstate: Add set_boost callback =
for
> active mode
>
> Perry Yuan <perry.yuan@amd.com> writes:
>
> > Add support for the set_boost callback in the active mode driver to
> > enable boost control via the cpufreq core. This ensures a consistent
> > boost control interface across all pstate modes, including passive
> > mode, guided mode, and active mode.
> >
> > With this addition, all three pstate modes can support the same boost
> > control interface with unique interface and global CPB control. Each
> > CPU also supports individual boost control, allowing global CPB to
> > change all cores' boost states simultaneously. Specific CPUs can
> > update their boost states separately, ensuring all cores' boost states
> > are synchronized.
> >
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>
>
> Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>
> With this patch, is there any specific reason why we still need
> /sys/devices/system/cpu/amd_pstate/boost_enable ?

Mario suggested to use global and PER CPU control in the previous thread.
So now we have one global "/sys/devices/system/cpu/amd_pstate/cpb_boost" an=
d
Per CPU control "sys/devices/system/cpu/cpuX/cpufreq/boost "
You can see more details in the cover letter.

Perry.
>
>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 1c2320808ae1..299e52d4b17e
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -699,20 +699,11 @@ static int amd_pstate_set_boost(struct
> cpufreq_policy *policy, int state)
> >             pr_err("Boost mode is not supported by this processor or
> SBIOS\n");
> >             return -ENOTSUPP;
> >     }
> > +   mutex_lock(&amd_pstate_driver_lock);
> > +   ret =3D amd_pstate_cpu_boost(policy->cpu, state);
> > +   mutex_unlock(&amd_pstate_driver_lock);
> >
> > -   if (state)
> > -           policy->cpuinfo.max_freq =3D cpudata->max_freq;
> > -   else
> > -           policy->cpuinfo.max_freq =3D cpudata->nominal_freq * 1000;
> > -
> > -   policy->max =3D policy->cpuinfo.max_freq;
> > -
> > -   ret =3D freq_qos_update_request(&cpudata->req[1],
> > -                                 policy->cpuinfo.max_freq);
> > -   if (ret < 0)
> > -           return ret;
> > -
> > -   return 0;
> > +   return ret < 0 ? ret : 0;
> >  }
> >
> >  static int amd_pstate_boost_set(struct amd_cpudata *cpudata) @@
> > -1868,6 +1859,7 @@ static struct cpufreq_driver amd_pstate_epp_driver =
=3D
> {
> >     .resume         =3D amd_pstate_epp_resume,
> >     .update_limits  =3D amd_pstate_update_limits,
> >     .init_boost     =3D amd_pstate_init_boost,
> > +   .set_boost      =3D amd_pstate_set_boost,
> >     .name           =3D "amd-pstate-epp",
> >     .attr           =3D amd_pstate_epp_attr,
> >  };
> > --
> > 2.34.1
>
> --
> Thanks and Regards
> gautham.

