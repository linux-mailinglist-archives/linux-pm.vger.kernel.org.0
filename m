Return-Path: <linux-pm+bounces-15728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0D19A0045
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 06:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BC31C21F37
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 04:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9927442;
	Wed, 16 Oct 2024 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oNE+7Ert"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F921E3BA;
	Wed, 16 Oct 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053930; cv=fail; b=eT/qhhtzeUAF63RjMegyh3cDEgH7a0f/sqXvX+O9Y9gQI+Wnl61zth9pzJQiC+9obBMWG6df4Rkwu6w7Ll1oSPpOUitUhaXdLWyeUMD/pSv3TwR5swBLj9O3fTHqWuaIOFUaM8BHJHLaoMGt3mNkpfgilBSBM5riI+/x3cPOaZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053930; c=relaxed/simple;
	bh=RJzXH/mj8iUz15ECiGHzx8k9kFdhtPn3iQa3qlQBXcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tcCnEDu/XXQdIoEZWYXZAnPf1Gbp99L5fXuK097SZCezUvZJZ3JVlqZI6OadzUrUCZyk6epQP5+7OZnrwr/DAkFOzv/05xfoGtKVlBfjeOmDUY8FxO/ZG9sIEfZTLbD+9ZH8EnImO19ufwu7vvddtCxwHWPOasFcAKvBdh3rRfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oNE+7Ert; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlEzgKse3ZWD/A36jy/3Xrs1XGDpQXs8jDLaHRiuhSP3RYFJ607XqZA4V4qr8ff+DkdKab1tzsdl88ziaN47Vh4Ov0JkKC0fHEGbFVxZ2E1BZEvg0Kmsi+8cD5/s08BdnNyFgXq9eeLyBvuVSSRhxALEheogUvHUqq1SrqCT+XviZh2liaIuz1+39cLQkKaPIZIXb8pBxMhOQ2SKheKODrAgCWxQZBBoiTR3zglf+t9KSDO7I2cme5BgrfU2oxT91Ku4cw4e5yFRiaQawsFPBZy9F5kV7jIzej1diAUc5pecUdtA4m8L9XbqN1F/EjjDkoytYBHazk0DQQTRxTEf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF81nu3kMP++DqalIhiHwiQEhWZK01JKYhAHvo9exMk=;
 b=HKdFfnAnuqurvhByQYgCYtH+mSOiFI2+eGchZyiJhnlKsT5F8yN4eY0S7pkS0HKn/iZnAhYYdnLZAgpTCQunTA/OdtnqxFtF/3WyucQfwfH4YShExyZAr3f/nRKp9Z/qvGJ7uHKLuZ8gQUYb/vkzik5LfDOyAWlZwpjr1PpkZ3TuWiw9T4Le9PxJC+1YrF5RSC71YnRQlWgkuP9VASXRpGnvHg6T6RpptGSZixvH9Fw+0+s4LyYv9d1QhfXAcR69Is8s8l8QngVut4tHR1w0lpCyW9VuCKkP7ZxMECqSzB7T789C+181U5ogoWTabsgWCSoKxQ2slVuAQxIwhQXNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF81nu3kMP++DqalIhiHwiQEhWZK01JKYhAHvo9exMk=;
 b=oNE+7ErtcuxYLEylLWUve9fLsIa/ANAivBA7BTjEm7bBovilLS9hj6xKCr7ko7Wbdc7/47wI+pkEU2Py22A1dH1QovDH1DthwivSRXLCDqyQY1CEIqqO9xUmPDAJd5VVbeDOO7pprObPYtXbd43x73gUF3/nfddoykbFMdPsn+8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 04:45:26 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 04:45:25 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Ugwekar, Dhananjay"
	<Dhananjay.Ugwekar@amd.com>, Peter Jung <ptr1337@cachyos.org>
Subject: RE: [PATCH 1/4] cpufreq/amd-pstate: Use nominal perf for limits when
 boost is disabled
Thread-Topic: [PATCH 1/4] cpufreq/amd-pstate: Use nominal perf for limits when
 boost is disabled
Thread-Index: AQHbHM6XLLN/ko3K9EmAdE2U0ib/fbKI0rOg
Date: Wed, 16 Oct 2024 04:45:25 +0000
Message-ID:
 <CYYPR12MB86556623B937ADB57FF4E4939C462@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
In-Reply-To: <20241012174519.897-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d708e23d-d1c2-46ad-8279-ffb50f82b73e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T04:44:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH2PR12MB4229:EE_
x-ms-office365-filtering-correlation-id: 3c0939fb-2f74-48e3-ba8a-08dced9d5a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vi/U+SHaehNtbs/nvhuRgybSUQPK619MJR4yS5lyL/aOzQ0Wh6qja2tOyZqR?=
 =?us-ascii?Q?sdloxFz5XoODK44PpDKuDAwZaibMLHxDwCEPZYgNCkYV2fMkq7Ozx8Fog+lI?=
 =?us-ascii?Q?CVgCfpzaUei6dr3tjeQEHxufXKHXTc2clm4/q1WmUe7AZK0Czqfa+CEX+TnS?=
 =?us-ascii?Q?k0/jnIILq/B0ZPwgps/SuVpU2bNtN0LaADu0+gnyWQ1BQb3rjKk3+CY7SW1I?=
 =?us-ascii?Q?S48UBRivdv7ZAQaDEUxjtw+TkoL3iU4DodeXlF6FWPt1BTgIZM8wv2N/1Ob8?=
 =?us-ascii?Q?qeQV2/+YGM3ZtSJuJbvdT/MPwphFMU1jKsIdj187tdevOn9iI305mkvgyhI+?=
 =?us-ascii?Q?OUk+ZbpTOVUuo+k0WrRmZjWS6OHL+pFW1pTVkUOYMXCccKlEK49PzGWLehf/?=
 =?us-ascii?Q?7Yt8Duq6aFqv8hAPPRSO0hzebxWZUKXwaUJuJi5AdXHA7iaxqhAv71QBD0iW?=
 =?us-ascii?Q?lJ7ITZodQusA3k3mcKoNckmY2y3hwkYJ2S5vT6PhMLswQjC1qelZrDWWfB2g?=
 =?us-ascii?Q?mrLSH41eD0H1hE5LhM6+HaB+M8erGM9AHOq2KiBNMWn6bQi+sloKCeqL3ep8?=
 =?us-ascii?Q?gGFNgk5VZjWnIm4SYHVZo9G5jyrf8pvljUZqJID9cOVGuE3SaYJ/qWc3XdfX?=
 =?us-ascii?Q?avM1QYj1UgtSTJVCaCS1ENMy4dd7vvXdFL7ZrlQ5WZQYzMgMqMnvWADUU561?=
 =?us-ascii?Q?K8GcvxE5WRl0uuy4EvGojaf58nLIOsmaaY7t6DZvI1HxzXPH3h3QOdg9UNsV?=
 =?us-ascii?Q?tLrUjJTCfOtsDq45gu9tagPRKf3Nfgf2/2LwtZ5dWMgbMWfYAFBjtXoI/X4Z?=
 =?us-ascii?Q?+zPzQuCs1QNm3cUYnRk22oLknjNG38GTphbuKYLXcdmPxEFDdTKo8bruZenE?=
 =?us-ascii?Q?nj7/TGXL0NjziuUhPd9OTLnARdWRRmpH8KmH4tDilrZ529iSyMZWeSProie8?=
 =?us-ascii?Q?uXa2d4WgSYfdpJG1wT3vmF0Rc3WcZWMCmPxt6+0Ri44bGWAkAQLMXQr9n9kE?=
 =?us-ascii?Q?2WP3oUgI6jUA5Znred8BsGVwmgOLBN9Q0vi1pVgsNTGs8A1Iflo7rP89bvOX?=
 =?us-ascii?Q?ZKhmEnP2g6l4CFqHNDEVPiGf8rxykC3rnu7J+bBlTluCgkUCDa7HYiyP8TC7?=
 =?us-ascii?Q?Ov4uf0mJQ3QKxyhJImV1b+F+fbq3wRDomSHaf9lNEj250g2Myyy/Dn7SUhP5?=
 =?us-ascii?Q?GNNSRbXy+cSMQgrXJL/lm63CG41VbLsV6HC//gTX202MSA5HWLMjaFqecB0L?=
 =?us-ascii?Q?KVDhmZWXuKb9+1CQrNiLX6lg0tP22q2ZMJMn9W0Bfc+jqvWgw4bkE7E3913r?=
 =?us-ascii?Q?z0GRNpm9DdssHH/dnZfMxxJThdfYIWSswUdxK4hp8CI3IQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9abArmgRPFfffaftRlqZPtL2EFHf2SP51yMmhTta1ov4/zW2BUX6Mh+0EiCo?=
 =?us-ascii?Q?69gGQ8vBf6xToCb6zRBuEPNZp5GYE9AfiUkTO/znrZbBOg2fQIRWxOgr1zv7?=
 =?us-ascii?Q?aMrLe7hc3Zrxq6ne2fvqjspIICbNkPxbJAOJzbQg+PYZE5QfXpr2KO2mG0tS?=
 =?us-ascii?Q?X67IMPpqHlkgETScqEN8/0r2GgKYyEm7kSnDWqs0kAVHS05ztGgmpybUJorV?=
 =?us-ascii?Q?mPKcpwEFpaeWN/IgSh4IMt9SaFLhrZfCvzrMs9+ZAwH1MG1juUWFqP8vHxDF?=
 =?us-ascii?Q?lXA4xD9z4cRVVqL+Jtr0VdTuNlPUGFJnu8oEmp2hmwMNVF8fHyPxQ/WU/5IZ?=
 =?us-ascii?Q?uHlpABoEa54fKo9fsbOpw591/ACqW8vVgERc6fPCstfJvLwMoVFGnaamMED7?=
 =?us-ascii?Q?ftmjWpXFVdFcu8y8MVd6FMvtBIqgdaZvq8Si7hHtPvYkQso0sgB+M4sy8hr0?=
 =?us-ascii?Q?+nDGIxEzakXz5eMmzghqfVwi69Q6fhwlce03E3J8b9DW3W8IUKctYl5KGDbj?=
 =?us-ascii?Q?EMWQDBuwW5ZZ8LiiKQKo4V/YfpPN15euCree/VeIdNx9m94meb7g867nB3H4?=
 =?us-ascii?Q?3mp3uTbpstCIOlz7OkTvIb7OQRBcv6yCO+yTu6xP+2DDD9CVWoUHo4FsWL3M?=
 =?us-ascii?Q?5QZ5AV6KvgRE97g6z3j42gqmrhLW4ktS+dEuTXKoW1I05K9v5TwdptyJopQA?=
 =?us-ascii?Q?qTjEesKPND5Zz6C7fR6Ma2EkN6hk/cMlEU31v+RUIzpLy1PSo/OMVsYnM4e7?=
 =?us-ascii?Q?AcOWVg/tRMZVzOa2I/nMaljHeo2vtf/LcAJ/xTuJi6zxN+borbjXPPcfSCRI?=
 =?us-ascii?Q?7Uqlc/as+RgiC5lhCVCZb9ZlSEqnTtJ4bwhrdDzXJOrRtIjD3EfPXNDjhdOs?=
 =?us-ascii?Q?5LKdaDzTXjQ8LpwT0PzoUPfjxsRU/FpLY+CsoPrWJWRr3TqioJAJ9wH8pcIT?=
 =?us-ascii?Q?b649u0zFKv+SxaaF3bxPiZ84AdRR5jwBVoEJZZHZy0VUOUNJGoNKtxcMmMdg?=
 =?us-ascii?Q?5n8va2DhdjICCCU8kSor8A1ZjOWeVH7y4qKWAcCkelRJqIXbGl3X4QpyinHc?=
 =?us-ascii?Q?YqhlLDiZOZWGG2wr5PHlVNxAy0hpzxpJTqMbEVLdIT7aV9uFteYKap6d0Aiy?=
 =?us-ascii?Q?xNF0m3WFz0s4s4M2SeiWeq8v+V5Tt+zQo8WZhrG1fNFa7KXNWAG+cSGVk0Dp?=
 =?us-ascii?Q?wd0e1MqVPSgNqv6t4hYEhBORQ4PlrJBlEA3GC62n3/EHGROnJWTZlaFCKFgy?=
 =?us-ascii?Q?ww7ytRMlC5Ro7xpcb+NNWBunE7xOdYksCd1VYlhtL8mrwdfnoIyUf+Zhw26j?=
 =?us-ascii?Q?TyaxUgyiXxnC9owlI32b88zpLs54iaQ9VqYfvZe3QLowOrhP/27jKh2av6QB?=
 =?us-ascii?Q?gdvmEKsBBdg3LcE4E36R/P7sG+ccNeb3zyvUh9XfdjppDSL7xiHA1Akmo/V/?=
 =?us-ascii?Q?rGSJIsnBo+Klp0SdITUDjP2hWlDTU6W62JEJ/k76Tjmcldv+2rkl/jw45Viq?=
 =?us-ascii?Q?UoCsPGYUd3djnSK1gE+GGndGFVpq5z2tuLvmtUQ5o1LAqryx7n8tGKH8Ghv9?=
 =?us-ascii?Q?x7GzE4v/6svz/VbgLhs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0939fb-2f74-48e3-ba8a-08dced9d5a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 04:45:25.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R0X4GKJ9uR6kxNwRdnp0OFr1hdo0L+mJ+EekBqZiz/I8j0usH3JyYWhW56IqflPp3RC0iH7bj6ZXQ5PqjEcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Sunday, October 13, 2024 1:45 AM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; linux=
-
> pm@vger.kernel.org; Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Peter Jung
> <ptr1337@cachyos.org>
> Subject: [PATCH 1/4] cpufreq/amd-pstate: Use nominal perf for limits when=
 boost is
> disabled
>
> When boost has been disabled the limit for perf should be nominal perf no=
t the
> highest perf.  Using the latter to do calculations will lead to incorrect=
 values that are
> still above nominal.
>
> Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge amd_pstate_highest_perf_=
set()
> into amd_get_boost_ratio_numerator()")
> Reported-by: Peter Jung <ptr1337@cachyos.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219348
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 30415c30d8b4..dfa9a146769b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -536,11 +536,16 @@ static int amd_pstate_verify(struct cpufreq_policy_=
data
> *policy)
>
>  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy=
)  {
> -     u32 max_limit_perf, min_limit_perf, lowest_perf;
> +     u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
>       struct amd_cpudata *cpudata =3D policy->driver_data;
>
> -     max_limit_perf =3D div_u64(policy->max * cpudata->highest_perf, cpu=
data-
> >max_freq);
> -     min_limit_perf =3D div_u64(policy->min * cpudata->highest_perf, cpu=
data-
> >max_freq);
> +     if (cpudata->boost_supported && !policy->boost_enabled)
> +             max_perf =3D READ_ONCE(cpudata->nominal_perf);
> +     else
> +             max_perf =3D READ_ONCE(cpudata->highest_perf);
> +
> +     max_limit_perf =3D div_u64(policy->max * max_perf, policy-
> >cpuinfo.max_freq);
> +     min_limit_perf =3D div_u64(policy->min * max_perf,
> +policy->cpuinfo.max_freq);
>
>       lowest_perf =3D READ_ONCE(cpudata->lowest_perf);
>       if (min_limit_perf < lowest_perf)
> @@ -1506,10 +1511,13 @@ static int amd_pstate_epp_update_limit(struct
> cpufreq_policy *policy)
>       u64 value;
>       s16 epp;
>
> -     max_perf =3D READ_ONCE(cpudata->highest_perf);
> +     if (cpudata->boost_supported && !policy->boost_enabled)
> +             max_perf =3D READ_ONCE(cpudata->nominal_perf);
> +     else
> +             max_perf =3D READ_ONCE(cpudata->highest_perf);
>       min_perf =3D READ_ONCE(cpudata->lowest_perf);
> -     max_limit_perf =3D div_u64(policy->max * cpudata->highest_perf, cpu=
data-
> >max_freq);
> -     min_limit_perf =3D div_u64(policy->min * cpudata->highest_perf, cpu=
data-
> >max_freq);
> +     max_limit_perf =3D div_u64(policy->max * max_perf, policy-
> >cpuinfo.max_freq);
> +     min_limit_perf =3D div_u64(policy->min * max_perf,
> +policy->cpuinfo.max_freq);
>
>       if (min_limit_perf < min_perf)
>               min_limit_perf =3D min_perf;
> --
> 2.43.0

LGTM, thanks for the fix.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>



