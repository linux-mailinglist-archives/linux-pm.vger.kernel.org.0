Return-Path: <linux-pm+bounces-9064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713EC9066A4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4AB285BEA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2813D607;
	Thu, 13 Jun 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQNwbiiB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F513D605;
	Thu, 13 Jun 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267125; cv=fail; b=F6OFRPkPzwsPqnuYMDd6brWT4ZdqJpuhRj3lFfuBhdBsTga0h7zWB0eq18jafBapaXhwDtAiazOFTVeSIxGVAaqwocsI2uxs/r8J++3yvW6hx46WGoD9cXFL5zr7oqdcjVfqGKuSUMqsEvAiYJO+OIg+0PrJhNY2E2BMD41QuHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267125; c=relaxed/simple;
	bh=qC7uT5pILWSPycU8gg8uszykI1YqLjtzmBs7cjsTIb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+y6Al1CRammxGerd3lOQc6Xa6fo5CuxyFitVtDrxNvAE6fO45UVzlUpHA5Bde4WwK4xhDgOHhotegnbL9eLaODmk0aqOy9Vi1pMb4WB+cHL7V43LCmP4NZQI8dsrikxrArmLHsxfxQhLiZKbG/O44NUscjRLnJIkOCclBmHnEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQNwbiiB; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9/++uKPBAiQhaNmdZq+vM6p9IM9XBbRSPICavaSWJd2F2WAZ9gJfNgG3Yc2SpextpbdfPkV8dEYTzZ5V1EQLImLB6T9kTofn41Me3/6j5t1JiR1Q6JPDOWZPDyMWHNTA6vv3eb7n1L6PbQjItTCOKDD3IJD7KRzktgc9iY75duPXpcz+OypgvU6O2EJzG2gmTBcP8LhX2bcuiwcEOdKm0wQMHjA5eNcz5wkrrgUReQUKj4SZ1nhpLqZA31qnVymDgbAkEevPWiBowjHJWe059GEUBxZRs5SLg89RYia/FYiRJCViqEU36APTFerYBdvqNvovrxw64BI1V19WYUG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMJvvV45XhohDlxGjYqdlmL8sPvSMlfNFigkn9c4gh4=;
 b=ob8lwGmm+EYbMFz2UIvZD+dVIZ/MdgtrMdTEOBtBX6jc98DAXJgv/piKrBMBg2SBhTf1WCnd1GJtoQSGjpL22URlIZgbjq7iZHTLLOvpTLCSoUKiIGEyfoMObZXe9a4zzXiN5XCUK0Bsw9vN4s6riFon3Oo54iANnfdxBbswKIGOFK9yIENWxw9NkuKRYM8aWDEiqglBDSuxoFy8xiUQWxpzjuuIiSjt8B+nlZKBCquW6i6LQEUzunhAiTGUM4AsJC0Flh+cv+v1zcsmpttFz8iyLIR7c1A9lSOTKL68vDlN49YE8gJc91eHSu3rKykm7sKB8tWYoZLZjpgjG0w7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMJvvV45XhohDlxGjYqdlmL8sPvSMlfNFigkn9c4gh4=;
 b=hQNwbiiBM4xqb2WICuNn/63c1DfBdzAGUNV58Gi7T0KQj6l6dNYSVTNB0yfD64aeVPaEreyb0762RwLLCFxz9lC+2v3wQbilbzz4l38PTd3rpKj74Fu+DihvmagFjzpIjHemdNz0gZbd2GtzGrizFuqphrH17u3365fkwT7e7W8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.38; Thu, 13 Jun
 2024 08:25:17 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 08:25:17 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/10] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Thread-Topic: [PATCH v3 09/10] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Thread-Index: AQHau90imlAas0zRJUWLqEKNsndOS7HFSr+AgAAPP/A=
Date: Thu, 13 Jun 2024 08:25:17 +0000
Message-ID:
 <CYYPR12MB8655A58B8ADA2C68D315337B9CC12@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <97b65a2294154dd469377a7a76ee738de7bf7aef.1718095377.git.perry.yuan@amd.com>
 <878qz9jowi.fsf@BLR-5CG11610CF.amd.com>
In-Reply-To: <878qz9jowi.fsf@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0d406709-2cb5-48ef-a029-cdaa74d2da8a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-13T08:08:23Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS0PR12MB6463:EE_
x-ms-office365-filtering-correlation-id: 4bbcc998-6202-4b1b-3dc3-08dc8b825b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KOV2H9bJZz2XGgVtoXW3LhBW4YBzT0ZRNaokfX63CZ9io/uoq0yLVeyAuOV6?=
 =?us-ascii?Q?hiqYZvxlaqoGsPHZXcI38XzGXXMd4QGbRqxWWytCnL1idpn9pdv1yDCYC6Jw?=
 =?us-ascii?Q?GANps4X9o0ZA/rx2Wcq1UF+UQfegRBoMlM1ufj/7I7gb+M9Cmw8dOQI5v2/y?=
 =?us-ascii?Q?RF3LPwrBK/0NEa097i0IbbAAU0qsLTr2KvPrHhlyK2cTqQOk/Cc2HiYv6kLG?=
 =?us-ascii?Q?dyABaa40M5Md32iDEgmbo6OihvxwKSWuwcTHGL7SaoI4OxOyaccxZTcm2zBC?=
 =?us-ascii?Q?YXLAkaQU5lJhjUiDOkHZA4VTyGEHeoLBRyDXwbGEbzmLrthyl4y1CB73LsHN?=
 =?us-ascii?Q?H/9OgZ1MfhjuHE2ECqTabqLs22QlvUKTBeea3JYN9SQwpPMdsM7XO25Kj/l1?=
 =?us-ascii?Q?aP40ZyzkzH0QMTok1oeIQ8FIPBcQVrNr38ckompSWTRXLkf/FbuSEfFiHUjY?=
 =?us-ascii?Q?nRlvG/8tJW/u23QWqTA3HFsxufd8Wh/6dYNOfTPUjYhf/SR5smsCTQxp+811?=
 =?us-ascii?Q?6wuxptpkjKDCZsy3N+u6EUCcwXUUuyl/PUyWt6nNWzuyPYVgI/y2cUVUCepQ?=
 =?us-ascii?Q?bTWYOcqj1zu0FVws4f6ruTnpu6PIcWE3Mo3gR5uINMLxBvh+ecJyspSxsPHL?=
 =?us-ascii?Q?av43Cqj8cehgt89ExkSw/hMu+WhShrYiB7l1mTQ0uIBoYjj7mObLAOO6jIjp?=
 =?us-ascii?Q?dnRYP/MgDuwkoLXhpxRTEsbi9TtqV1IqFC74bhdHsGuIaUVsALKGqLlo3CJW?=
 =?us-ascii?Q?f4X74N/OTuWDUuLMqCLMp9x3J3Vv2ZEQrYGJYS4LgP6PhEJOi60y4/J53+DI?=
 =?us-ascii?Q?Om5X4Q4q/15A8V5ZRWEOi+b+kDEcuI6Oar8BWCAbsq0M5r6JnNUoPhLIi/pl?=
 =?us-ascii?Q?rfOoaVmmPHQbauHwCwrhxcPndtLJQjW2lMRQ+tdDSikyvfXp2L0Iiz9A/ZJV?=
 =?us-ascii?Q?Cr8+LO9D+d/1utEeytDZctRIP0peuHrncIHgxPcg3h1VrD08AvQRtTEDkWZz?=
 =?us-ascii?Q?jqnIdx2PsxeMOzs1gIhn7nSjxF+oprie6pSav4VWSPuTYfNa3NLSkz5WTfy/?=
 =?us-ascii?Q?dM+btfOw6sKQe17kIMPQx9yCo0fylePFo8Tnt5yjb2YAJpN7mx0FWhOfoGcE?=
 =?us-ascii?Q?/YKKg/Xzwc6GU8ojyvTZU3QSDHVjFzoKPRCUpFn6mq65lt1ydlhods0PR6EX?=
 =?us-ascii?Q?mqvhbz0J6j0YwOcTW0seHQvnl8twRycMahrKkKCiAy/KIHydig6teGxqf5u1?=
 =?us-ascii?Q?iO/HHQU4jPTzlpfW1wq6ObAeOYYdNipVgpFcrDMV5k05iJSGzMSm23FBmU3O?=
 =?us-ascii?Q?rzwTWgc6aWsCaAx6BF6lLFMGb2q8hrI5YqGAKmzywcnA3w7LR7oX/oD4k+V2?=
 =?us-ascii?Q?2gV1p7eLlEZD/Bu6Xq5mGfwn+NB7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jzEldf0+GOk4q0nNvUguVokIC+YiS5+XMvtNdJZq35rJM5tVMXvWw+P8anXM?=
 =?us-ascii?Q?NkjPqIp4LPl4TG1lGkHdR19PoPp1Kxe2kozRgHC5f6uiKgnazP4TfuOrcRTR?=
 =?us-ascii?Q?iyBnkfnSiGbPjdgABp3Hljv3dzeb0VrVb5PIG0e9AzHcN3m0G0T7zuNwLWJ4?=
 =?us-ascii?Q?0RusTjsqpS4/lfWCcc9Z7lAFirryhw/2+U8tcBVZ7yb+4Mzxy0F+WlBCbQLf?=
 =?us-ascii?Q?OjLdMJ6TmE+eyWgqNfec/Vq2F7uWeA/v/V8qITO4sNlHycXYX6yVg3HZlREC?=
 =?us-ascii?Q?MQ4ie6tW5dj9QDTpF8U/ue1n6TX4x7Lbb/OPaZLr3/7/mG5Q9DYBQZH5EIkK?=
 =?us-ascii?Q?x29khO0PWbkZhypd5F+S/yryITWo/cL0ZJAX3wgMzbXP4p/gXGp7ST4CBsJE?=
 =?us-ascii?Q?MI3/Eqs5IX6FuiOvNcnLx2kvW7iMVfiDFF6JnrUwk5oTyorP0Mpi9kDPia35?=
 =?us-ascii?Q?OWn+TwiZEdWNygx5Bl13XZ8uVEm7k8bKQeZm83tSx3UWa424tqZriS/hvpBJ?=
 =?us-ascii?Q?bo5pULNWep35IVfeeGJRVAdlGdtQdSweV+ol3VgYhDwJ1YEOzo1PlcUmDK+b?=
 =?us-ascii?Q?yuZaZia2d0y+Vua6QUVoa+nsIl+dvC7JUA/vIUM/z/NdGNfgvpAdxMCt9/cF?=
 =?us-ascii?Q?ekd5tgdrGRS3zfd+UBji43naz1FhCqIspVcxmlfzY1NeXmHQ6YR5+ltLmm27?=
 =?us-ascii?Q?dfvUFwU5tZ56CbnhjOmpP+3LWbWhM5AcYCBWEfmlgEkBFfcP5qXI10O/s9IA?=
 =?us-ascii?Q?xtgsr0CDGD6yCQG5x2rGGq5dR/FNr13OTR2oo81wwO9Fp/393uhv9H1lISUA?=
 =?us-ascii?Q?oQxDuGGUX7vqD/xbRLCuQ/H0GFiO+qTDEQWYRYPjZz2murAltjSFsTPJP2O3?=
 =?us-ascii?Q?u8aCIbg0xeol5aN51u5Ei8askiBatz2/DGzZznxBcAJ9Jq1o4V6yceAKvxs8?=
 =?us-ascii?Q?pyGym8XOFZbESORAgrmgdvXqAoJw50GEN5FJ5BsJClc29FKQ0GPpSQT8eLZR?=
 =?us-ascii?Q?fJT3Dh6OaP+ajN+QlccnmpPQvCV+lS0i627sdCMU30aOV9XzqX0YIhud+csI?=
 =?us-ascii?Q?7hPgNNblx9NWChT/zFfsuHVB9KkMvgv5CyRHJtSsGHtYrDlf0SNvIRGZxl+k?=
 =?us-ascii?Q?5+XBOgbL+tRuVhnKC43Zrhz0wikAYezuURXYjHdLOK7NclJM/EPqoZU2Te1g?=
 =?us-ascii?Q?huQn6Oajwribm1TsQYqMuacCXUBypglIKa1C3QF/UCwOiWAD/lM4ZnbClhy5?=
 =?us-ascii?Q?d3hNCS+I5iF6Q/j4SPDUQKL0yZ1zyJRwwn8MbkKtWXb3gW+mzDdodYDEjTtc?=
 =?us-ascii?Q?PsgogYKGMS+FD9q66Hrb4ScAf92m87riZrbrIIgwdpXYpqPqcReAb8Yv4DZG?=
 =?us-ascii?Q?BiSFwEwB5JZjvV5634rzExwFlcQZnkAWbMb48wYhWvZxpjVx3fyjm7BMWVt/?=
 =?us-ascii?Q?TgON4w9FJodSaPObLa5kWyJiHclciUz3kWX7qMmqhMrOR/PvlumIU0dsnZLi?=
 =?us-ascii?Q?p8+oJBChyoRCMQRKZdfnfZEef2XJkTxP1neYpclnbrPxaiHwCMH1cVMnmxm8?=
 =?us-ascii?Q?E+zG0RfwuAbxjRuX9xk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbcc998-6202-4b1b-3dc3-08dc8b825b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:25:17.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3Y9GjsSWFecfAP0ffVKdZ1Mz6MCZk8obyPsvZ5LjVQ1FqlpuCafalKRTD45TecrbuBCh8c4Q5Ys/cXZsbWr9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Gautham

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, June 13, 2024 3:14 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 09/10] cpufreq: amd-pstate: implement
> heterogeneous core topology for highest performance initialization
>
> Perry Yuan <perry.yuan@amd.com> writes:
>
> > Introduces an optimization to the AMD-Pstate driver by implementing a
> > heterogeneous core topology for the initialization of the highest
> > performance value while driver loading.
> > There are two type cores designed including performance core and
> > Efficiency Core.
> > Each core type has different highest performance and frequency values
> > configured by the platform.  The `amd_pstate` driver needs to identify
> > the type of core to correctly set an appropriate highest perf value.
> >
> > X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
> > processor support heterogeneous core type by reading CPUID leaf
> > Fn_0x80000026_EAX and bit 30. if the bit is set as one, then
> > amd_pstate driver will check EBX 30:28 bits to get the core type.
> >
> > PDF p274
> >
> > Link:
> > https://www.amd.com/content/dam/amd/en/documents/processor-tech-
> docs/p
> > rogrammer-references/24593.pdf
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  arch/x86/include/asm/processor.h |  2 +
> >  arch/x86/kernel/cpu/amd.c        | 19 +++++++++
> >  drivers/cpufreq/amd-pstate.c     | 67 ++++++++++++++++++++++++--------
> >  3 files changed, 72 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/processor.h
> > b/arch/x86/include/asm/processor.h
> > index cb4f6c513c48..223aa58e2d5c 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -694,10 +694,12 @@ static inline u32 per_cpu_l2c_id(unsigned int
> > cpu)  extern u32 amd_get_highest_perf(void);  extern void
> > amd_clear_divider(void);  extern void amd_check_microcode(void);
> > +extern int amd_get_this_core_type(void);
> >  #else
> >  static inline u32 amd_get_highest_perf(void)               { return 0;=
 }
> >  static inline void amd_clear_divider(void)         { }
> >  static inline void amd_check_microcode(void)               { }
> > +static inline int amd_get_this_core_type(void)             { return -1=
; }
> >  #endif
> >
> >  extern unsigned long arch_align_stack(unsigned long sp); diff --git
> > a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c index
> > 44df3f11e731..62a4ef21ef79 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -1231,3 +1231,22 @@ void noinstr amd_clear_divider(void)
> >                  :: "a" (0), "d" (0), "r" (1));  }
> > EXPORT_SYMBOL_GPL(amd_clear_divider);
> > +
> > +#define X86_CPU_TYPE_ID_SHIFT      28
> > +
> > +/**
> > + * amd_get_this_core_type - Get the type of this heterogeneous CPU
> > + *
> > + * Returns the CPU type [31:28] (i.e., performance or efficient) of
> > + * a CPU in the processor.
> > + * If the processor has no core type support, returns -1.
> > + */
> > +
> > +int amd_get_this_core_type(void)
> > +{
> > +   if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> > +           return -1;
> > +
> > +   return cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT; }
>
> The 0x80000026 parser doesn't have support for discovering and recording
> the heterogenous stuff _yet_. Eventually I suppose it will get that and u=
ntil
> then amd-pstate will have to discover the core type by itself.

The PPR doc need to be updated to use a new one,
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/progra=
mmer-references/56713-B1_3_05.zip
P119

I have added the cpu feature flag in [PATCH v3 08/10],  it will be fine to =
identify the core type for pstate driver with one line code.

>
> Even this, I find the bitfield way of doing things more cleaner instead o=
f using
> shifts and masks. Something like...
>
>
> int amd_get_this_core_type(void)
> {
>         struct {
>                 u32  num_processors             :16,
>                      power_efficiency_ranking   :8,
>                      native_model_id            :4,
>                      core_type                  :4;
>         } props;
>
>
>       if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
>               return -1;
>
>         cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
>
>         return props->core_type;
>
> }
>
> > +EXPORT_SYMBOL_GPL(amd_get_this_core_type);
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index cb59de71b6ee..fa486dfaa7e8 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -51,8 +51,9 @@
> >
> >  #define AMD_PSTATE_TRANSITION_LATENCY      20000
> >  #define AMD_PSTATE_TRANSITION_DELAY        1000
> > -#define CPPC_HIGHEST_PERF_PERFORMANCE      196
> > -#define CPPC_HIGHEST_PERF_DEFAULT  166
> > +#define CPPC_HIGHEST_PERF_EFFICIENT                132
> > +#define CPPC_HIGHEST_PERF_PERFORMANCE              196
> > +#define CPPC_HIGHEST_PERF_DEFAULT          166
> >
> >  #define AMD_CPPC_EPP_PERFORMANCE           0x00
> >  #define AMD_CPPC_EPP_BALANCE_PERFORMANCE   0x80
> > @@ -85,6 +86,14 @@ struct quirk_entry {
> >     u32 lowest_freq;
> >  };
> >
> > +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */ enum
> amd_core_type
> > +{
> > +   CPU_CORE_TYPE_NO_HETERO_SUP =3D -1,
> > +   CPU_CORE_TYPE_PERFORMANCE =3D 0,
> > +   CPU_CORE_TYPE_EFFICIENCY =3D 1,
> > +   CPU_CORE_TYPE_UNDEFINED =3D 2,
> > +};
> > +
> >  /*
> >   * TODO: We need more time to fine tune processors with shared memory
> solution
> >   * with community together.
> > @@ -359,9 +368,27 @@ static inline int amd_pstate_enable(bool enable)
> >     return static_call(amd_pstate_enable)(enable);
> >  }
> >
> > +static void get_this_core_type(void *data) {
> > +   int *cpu_type =3D data;
> > +
> > +   *cpu_type =3D amd_get_this_core_type(); }
> > +
> > +static int amd_pstate_get_cpu_type(int cpu) {
> > +   int cpu_type =3D 0;
> > +
> > +   smp_call_function_single(cpu, get_this_core_type, &cpu_type, 1);
> > +
> > +   return cpu_type;
> > +}
> > +
> >  static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
> > {
> >     struct cpuinfo_x86 *c =3D &cpu_data(0);
> > +   u32 highest_perf;
> > +   int core_type;
> >
> >     /*
> >      * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
> > @@ -371,7 +398,26 @@ static u32 amd_pstate_highest_perf_set(struct
> amd_cpudata *cpudata)
> >     if (c->x86 =3D=3D 0x19 && (c->x86_model >=3D 0x70 && c->x86_model <=
=3D
> 0x7f))
> >             return CPPC_HIGHEST_PERF_PERFORMANCE;
> >
> > -   return CPPC_HIGHEST_PERF_DEFAULT;
> > +   core_type =3D amd_pstate_get_cpu_type(cpudata->cpu);
> > +   pr_debug("core_type %d found\n", core_type);
> > +
> > +   switch (core_type) {
> > +   case CPU_CORE_TYPE_NO_HETERO_SUP:
> > +           highest_perf =3D CPPC_HIGHEST_PERF_DEFAULT;
> > +           break;
> > +   case CPU_CORE_TYPE_PERFORMANCE:
> > +           highest_perf =3D CPPC_HIGHEST_PERF_PERFORMANCE;
> > +           break;
> > +   case CPU_CORE_TYPE_EFFICIENCY:
> > +           highest_perf =3D CPPC_HIGHEST_PERF_EFFICIENT;
> > +           break;
> > +   default:
> > +           highest_perf =3D CPPC_HIGHEST_PERF_DEFAULT;
> > +           WARN_ONCE(true, "WARNING: Undefined core type found");
> > +           break;
> > +   }
> > +
> > +    return highest_perf;
> >  }
> >
> >  static int pstate_init_perf(struct amd_cpudata *cpudata) @@ -384,15
> > +430,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
> >     if (ret)
> >             return ret;
> >
> > -   /* For platforms that do not support the preferred core feature, th=
e
> > -    * highest_pef may be configured with 166 or 255, to avoid max
> frequency
> > -    * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1)
> value as
> > -    * the default max perf.
> > -    */
> > -   if (cpudata->hw_prefcore)
> > -           highest_perf =3D amd_pstate_highest_perf_set(cpudata);
> > -   else
> > -           highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> > +   highest_perf =3D amd_pstate_highest_perf_set(cpudata);
>
>
> Without this patch, on systems without hw_prefcore, highest_perf would be
> derived from MSR_AMD_CPPC_CAP1. The value of the highest_perf could
> have been 255.

Thanks to your reminder, highest perf of  systems w/o hw_prefcore are 166 o=
r 255 because of the long history.
It  still needs to use  hw_prefcore to identify the CPU otherwise the highe=
st perf will be incorrect on some systems.
Let me fix it in v4.

>
> This patch changes the behaviour and sets the default value to
> CPPC_HIGHEST_PERF_DEFAULT which is only 196. Am I missing something ?

Some new clients system update the default highest perf value to 196 from 1=
66 from power firmware, so the highest perf need to match the CPU
and update the value in pstate driver as well.

>
>
> >
> >     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> >     WRITE_ONCE(cpudata->max_limit_perf, highest_perf); @@ -413,10
> +451,7
> > @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
> >     if (ret)
> >             return ret;
> >
> > -   if (cpudata->hw_prefcore)
> > -           highest_perf =3D amd_pstate_highest_perf_set(cpudata);
> > -   else
> > -           highest_perf =3D cppc_perf.highest_perf;
> > +   highest_perf =3D amd_pstate_highest_perf_set(cpudata);
>
>
> Same comment as above here.

Will get this fixed in v4.

Thanks for your feedback.

>
>
> >
> >     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> >     WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
> > --
> > 2.34.1

