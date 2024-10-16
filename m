Return-Path: <linux-pm+bounces-15727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A19A0042
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 06:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F5F1C21E62
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 04:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21774187850;
	Wed, 16 Oct 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vllYKLqJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C56E60B8A;
	Wed, 16 Oct 2024 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053760; cv=fail; b=oKvH2M3gyMcNtse/n0FWayefABNmOPo6ysAABRg6sq3pjtmP9pqP7msBbGsU7QuHqrAxSFgARvDwjvwmqYFPkiB4e0u2ktjbUVOboIQdZD775zbGDJiArAH42Eotm37zIT+6q4zznAshqEYsKzmc3m02wVLwatVdrYJauI+1LBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053760; c=relaxed/simple;
	bh=JSivYBjnO0N1FbfAItPdGyY6oLMxMSMEEpFdWr7o6a0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GENl0RdShB3x+YhmxkiXwUHP7Wshjvqq0lxsxEciBExoq1T/2JIdIODdirC2n5EpQRFAsPUVfYOokM0/GRAASbV7eGdmtzXflR1LV2qC3AFRCWV7d21Yu4F+XQh09O6coxUOEPVCqxJuiqNKxpNh/Zp54yJdX4akdj/Nf6lgV8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vllYKLqJ; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOsVwDAAuLYx+M8QOrCwy7Ncsl+o06qiP1ZS1sm/F7MYxKuz0h8NQqF9d3HHMuPB9Po6qdT0P9D96n/K1Tl4drLqjg63oCSoOeVK9Mch+HXq7RWydU3bHU3wivOZHeREYYnx4fl1SxU2ceSTPjSE2xcIn5x8JX/hQLWfb32ZH/AuKPztLV3+0T9EuJMzqKbXa81ZhKptAZo2psLnb10EmIZuUnCpeABb9kbIybnj1vHOxNRJJTtQ4ZjskbkunSk3a6osJKzz1PENOIKbirRcEItUysXEgI1XMK535LheBGHRqWVzc2rBWtjq6Ef1WXaS52lD7JOAyejh8Cmz1+MXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYKLDl10Gh2/vm+Xtt3+8XuKqIVWfND+j0JTHGD5vO8=;
 b=ZT7UnXSwnfKVSONiv3FBTn+TPDZtiRkE+kMKwNQH4qPj2kx4oDV2zo/FG/9FSsJDTR965Fq5nh1G3PgtGISRrF72ZHazLfDiHvvKGAgwIcPezqNz6R/pN34xH3NoO5Y3/kyBmWZ99vxzmV3KOb7zhG0T2MTaVUX23xm1HLMUy2jrS5Wfe3xlc38eyClfXwJAc2t0LOsY+H4W1bVFZ+07/r9KsY7u8i9D2T21O/v4dgbi6HWrBuD3XUukU5Df+DjPzPwaKPYYxaNh8PDLHczMwGXNzfjdlXWpIdaDeNXn5Z0ODaGpPB+aVeOej489k7XybXetDR3ighrdMyw8AwW/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYKLDl10Gh2/vm+Xtt3+8XuKqIVWfND+j0JTHGD5vO8=;
 b=vllYKLqJ0jpAPx6kok6tRHfvVfWntk67a2r+6xinjaPnGmdYzGSrtp3PnrOmwpQPQrNyUs0angZpFRhdTwNSaJzNwd2L5VDwtdOqvfk1/tpMf+wj4U762g8/Zx+PCiaDIsuujGH8VhBykY0xxXCD9mfM0tWUjUF81puDQZ8x7bQ=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 04:42:35 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 04:42:35 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Ugwekar, Dhananjay"
	<Dhananjay.Ugwekar@amd.com>
Subject: RE: [PATCH 2/4] cpufreq/amd-pstate: Don't update CPPC request in
 amd_pstate_cpu_boost_update()
Thread-Topic: [PATCH 2/4] cpufreq/amd-pstate: Don't update CPPC request in
 amd_pstate_cpu_boost_update()
Thread-Index: AQHbHM6ZJONc2+RN7EKLR0S891klibKI0O5Q
Date: Wed, 16 Oct 2024 04:42:35 +0000
Message-ID:
 <CYYPR12MB865575C121660188BDD977B89C462@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-2-mario.limonciello@amd.com>
In-Reply-To: <20241012174519.897-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1ac9b090-10d6-4dba-99b6-40af80a4d243;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T04:38:39Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM6PR12MB4337:EE_
x-ms-office365-filtering-correlation-id: 503ebf00-7102-435a-8760-08dced9cf48e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dAdw6BcleJN3A8RAlXOM+EP0z3hR/cqjoTe4FjUa48zFKs497KO6/a4Wjdb2?=
 =?us-ascii?Q?LtsOk3ZrOVpnR6GWLehm8YkkmNXykPAr4B0ywnGgfeJw2FQJ51GIHtNyKIdC?=
 =?us-ascii?Q?YoCPs2n9E4wfyfOcRgQOsv8rp38yjyWR6pX4gwphAken62WUqnliVFCbu5Fr?=
 =?us-ascii?Q?Z3XW1yj7CjHYmIUR+4bk2bHZuvrI+DEjF5kLUUA9REdYwphJzWISJsZRoiM+?=
 =?us-ascii?Q?sXRM9qm2jD7qi87pCK+xZSMczom4LBXZNm0uM9n3IRW7vqrDydqn0AE9uWmE?=
 =?us-ascii?Q?20P7WVX8cbEZ4g3H1/BM8R0WL+mri8B8v7h9bGJdfHx1Rq/cwvu6a+iO5ucQ?=
 =?us-ascii?Q?YtCtPoTrpg8lhUhLJ2SvpZnRwRwtO4G0VHCpjX38X+4bgXEE0KVSbK7oKqys?=
 =?us-ascii?Q?0Q0tWR/DhkAzorh7IEMTxW/UqeACY+a6IEKb6Yf0Ct+Amr9Dxb8cAL1jfuXq?=
 =?us-ascii?Q?yaPY386/juBrptTaZoyGo8farU8vO3Oxprrkel+MlfZV58z3Fa+EohLIvdOI?=
 =?us-ascii?Q?0BnkGP9iccnAru9PpBq2+CnZ9PjP+fY+xl924bSO18WUnjBENGhXVCpnr9WE?=
 =?us-ascii?Q?5mEg7Qc2A2a04r0m+1gj+QtSLnDGTgD9D8gRnBtlz64hw1+iXdQZOHWTlJl1?=
 =?us-ascii?Q?m7EegdROZ41n4Mto+zSFAD1HDJCQsARPON9CLBAgfK1T4ikJcjYZHwVIxLAn?=
 =?us-ascii?Q?CR45bnK+uNfdXzAS6keQ1SBJGrpoPlO9BEpKPue30pFDwn496OWTCGgpV3TC?=
 =?us-ascii?Q?Ml5ovCcQ9H1bIAyNMQ2EUm+uEgm6fy5MHzZ3GFsuBiq2QSHDpzMrp85YB2YD?=
 =?us-ascii?Q?O3oagJ9ooogQM+98aievWpdInMvO9uFv1qKjHSrc0jYOmqyCjPLT54znSAOh?=
 =?us-ascii?Q?QsdLK4tATUCunAgAPMksE+3OUNUZtha2c4TLQhlTLrBGwDmyq92JOd2EDEWh?=
 =?us-ascii?Q?5R3cZGaIJgafeYEFdifqxRvMVzTA/HdFhCcnLhRrhpR2gmsXEaJbn5e64pKi?=
 =?us-ascii?Q?z7HDdoyhXNe7xqd/aH1rhVjNBZPWH3XIQmPolLNRuaTfiu1jgl0AzVVIppTf?=
 =?us-ascii?Q?oM+gZPYmSadALs+tsIZrA2XpmEo7pueyQF5IHCf2HqR8wBeLC2l4S4BfJsOs?=
 =?us-ascii?Q?jjJWKZowD/KuEpp1CzuNk4E4VNF5pp2MOmXO8LjNfoTEUbfKyAxaujpl8jj7?=
 =?us-ascii?Q?0jpV0h65BJ+Bu1u3LyP5DeFbYdsk/ehD2+apTAH8KOOk8uFhjO/HJodclQW6?=
 =?us-ascii?Q?RTTenP+S8BwcbKyhTk43ZgjzMNC1qmXjRpK+IlBGxfmxSvMtBd7BIjtygtKt?=
 =?us-ascii?Q?0CmbutC0DgFy1qUYfVVlu6YfllVoVDJCiO2zZJpzcE1Xfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n+0TUA+myCAfqFoz7mpBZspBYd5YlQAH2RVA58I3GGGX8En0D4BUbbhGuJm2?=
 =?us-ascii?Q?UkE78gSHq53eJjUjxKXZ2jJoJo3WF5tLSNM1TbBFZ9Ck0hhw5DMTMzSO+MQS?=
 =?us-ascii?Q?/2jHQIFYpFB6PID134dLaDMI9iV7jJnv7NABaOxSd0FDyLRmUmTO9qt1xAa/?=
 =?us-ascii?Q?Fv4OsEgWs3Yzs7AUcq8j5DRzjNyP/zTweoujhzANpp2E8jrBTEn5n5NWxZV6?=
 =?us-ascii?Q?5QhavfUKJvqCib6vTV1ikSwrk4s5K01e2XdpYaDpWWr2yjzAtxaz98zn6N/t?=
 =?us-ascii?Q?X8hN/o7nlNGu0z2l51sVbuKMSiN8W/3mg/OP+z7Ssln4AWO7EyxST3W2v+WG?=
 =?us-ascii?Q?sDvpA9Mjqd6tY6X/3RP+NTfh/N9gQu9qtpKst1YAC+iddmebT8WGUr2uGAyF?=
 =?us-ascii?Q?YIjUpfgC46/4TCX0sQ4FdoPQQadsr2yaBVCEFSpuFhte2iURJMp6klNG1MAa?=
 =?us-ascii?Q?yZ5vml1EWXId9y5HHypfRpRQCgGpFGpQU/EBIW2xx7A/4plB447l4UcWwlH4?=
 =?us-ascii?Q?LeBZhZThaU5TcS537nc7PJ4cciMi4S0XBLEghKZgCeCrrlv4J37JoGRjC8fy?=
 =?us-ascii?Q?t7NmYfU8oh+dOzvNTeXuak5qlWnYTOvNK2OocMOz1rCf5FxddOAJwBrvgtKt?=
 =?us-ascii?Q?UkhMBTaXhK+wJyYvfU9NGQwrX0ahUBdkowsnEFOamr4FY5P+DkNWyznw1ZWU?=
 =?us-ascii?Q?lWOiyVCuSWKk0LKsTzvjQpq/wj4PkjM0/7hYnNI5cA7HzX3xYRwMMSK6WPKY?=
 =?us-ascii?Q?JMNKoi8U7j1zBcz7J3M14lJaLAYN7cAyvVkaXLCmhb76vAcWRC8reqSrKgBE?=
 =?us-ascii?Q?/C7fNDWtf3fKIa+Mtegx27auKRBXNT5S9F7+UTxO3UR3ewus7DPs2lJcTphN?=
 =?us-ascii?Q?0zsrS9C3d/IrJ/5VTRl9coGt/7QA62d4P88ATUGbmJ3sFnstarncl6ZApDjw?=
 =?us-ascii?Q?kUBPkhEBX7bOK5zDczyMpMWJXBYYXLW2syods//ozYQSwB1iv4poJVSFQ2j5?=
 =?us-ascii?Q?DXcDAUfk/FjM9oa93P17EiQJw3UZGxxLV0+OncZtvqg0GavKeSBLBPAzBECC?=
 =?us-ascii?Q?t7U+kTwqqd8N5YMeeM6fsXZUmIJMbwPUepFGgDJ40CbHidBi8mrfEVoLHnvq?=
 =?us-ascii?Q?tgQVHlguVcOVG3CoOnCM/fyyOtwmBSztF8YwNKiH+b0xq6PMH1CXqB8+ZIg2?=
 =?us-ascii?Q?/cFk/47DhS/E/W1AII12IScKWhEQ0xCAbJqm9Xc7s6/aG53mKkSjUsJXkZZV?=
 =?us-ascii?Q?g57qZh14ZcpQEQiZLORQxakIJ3Rj/Wtus42PXoM6ki0TUDZlXL8UISYP+Zje?=
 =?us-ascii?Q?aBV9Eeq76GHDN3OuUa7Flvarycd4IPBuruJUvwWxtpy28c4wjCwsWa7aoJuC?=
 =?us-ascii?Q?qN2jl/1I27ZBQagA7mFHH1smoPoLDwxTIu5t/mtREM84RqDY8FokRC7ZClgq?=
 =?us-ascii?Q?U6LyOIkF1bm6fMvmcGkhVH5DbIf7mY0q/6k3dDShhAnjAtnx95gHS6rYf9on?=
 =?us-ascii?Q?8mjk7p7N1cAio84JLQ2BCQEJ+/SQqHvn2x8n64eG/o2FMCYNCmUnSj6LApvG?=
 =?us-ascii?Q?mFIt9YNagMtvZyH9IE0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 503ebf00-7102-435a-8760-08dced9cf48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 04:42:35.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYMNyNyRB37oFu4WYOAoNFs+5sb1Senv/J2DEJpVVLgUMYZX+v9i5kO61mGuY11UF5mHbxkubH8YOdGs0EeQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Mario,

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Sunday, October 13, 2024 1:45 AM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; linux=
-
> pm@vger.kernel.org; Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/4] cpufreq/amd-pstate: Don't update CPPC request in
> amd_pstate_cpu_boost_update()
>
> When boost is changed the CPPC value is changed in
> amd_pstate_cpu_boost_update() but then changed again when
> refresh_frequency_limits() and all it's callbacks occur.  The first is a =
pointless write,
> so instead just update the limits for the policy and let the policy refre=
sh anchor
> everything properly.
>
> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boos=
t state")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> dfa9a146769b..13dec8b1e7a8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -665,34 +665,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu=
,
> static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, boo=
l on)  {
>       struct amd_cpudata *cpudata =3D policy->driver_data;
> -     struct cppc_perf_ctrls perf_ctrls;
> -     u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +     u32 nominal_freq, max_freq;
>       int ret =3D 0;
>
> -     highest_perf =3D READ_ONCE(cpudata->highest_perf);
> -     nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
>       nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
>       max_freq =3D READ_ONCE(cpudata->max_freq);
>
> -     if (boot_cpu_has(X86_FEATURE_CPPC)) {
> -             u64 value =3D READ_ONCE(cpudata->cppc_req_cached);
> -
> -             value &=3D ~GENMASK_ULL(7, 0);
> -             value |=3D on ? highest_perf : nominal_perf;
> -             WRITE_ONCE(cpudata->cppc_req_cached, value);

The original idea was to update CPU firmware MSR register to limit Frequenc=
y from lowlevel,
If the not updating MSR,  could you please check if the boost off can limit=
 the frequency
from power firmware?
If the limitation is working or not needed,  please pick the flag,

Reviewed-by: Perry Yuan <perry.yuan@amd.com>.


Perry.

> -
> -             wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> -     } else {
> -             perf_ctrls.max_perf =3D on ? highest_perf : nominal_perf;
> -             ret =3D cppc_set_perf(cpudata->cpu, &perf_ctrls);
> -             if (ret) {
> -                     cpufreq_cpu_release(policy);
> -                     pr_debug("Failed to set max perf on CPU:%d. ret:%d\=
n",
> -                             cpudata->cpu, ret);
> -                     return ret;
> -             }
> -     }
> -
>       if (on)
>               policy->cpuinfo.max_freq =3D max_freq;
>       else if (policy->cpuinfo.max_freq > nominal_freq * 1000)
> --
> 2.43.0


