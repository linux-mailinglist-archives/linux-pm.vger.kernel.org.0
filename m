Return-Path: <linux-pm+bounces-15725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A49A0037
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 06:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F991F22963
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5A15ADA6;
	Wed, 16 Oct 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cmgrp0s/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32221E3BF;
	Wed, 16 Oct 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053210; cv=fail; b=Sl1/c/GJtwM8b9wApWG7N87Z77rvExq+V8P+oFO+Ra/Z9uZLJdT/5AhZET8hzggLqdkkTBHS+LKFMpTD1gOWrUWCyW/MCEVBcPSqf4/7E+d/2OEK7mQfStX3hYFCfEsVGbNW9LgKYJ3Pyo7pGeBHeQJvgzdB/pbZPucDmzTfGn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053210; c=relaxed/simple;
	bh=Px843dG/smKvGNEnugXmKksVpGM4b7FfkSvm1c0drQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7DcsT4DrKwu58OeDzko1l2fSp9+rLpr+Haqi3ixJ/Ow6Tzz/Kolf8L6HrbFcNXtQgn0Fen2/IH057u5Na9s2Wf9lxcg1ZfYM+A4JtxIq83HqRBKDkgRZ9jhWYEz0n/OeyQ9fuivA+02ZDashnzxsfwmTRDlgu0mXlj+F6QnEoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cmgrp0s/; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygyP4Vy6pabWs7a8LFOl77prH691DQSCRMy136BbrZndhGhRZPIHKRFczoXnCLFCuCCGf9WLEOZczZ2CIL860HTATuunPWPU/lzpyiwkY3h9BueeMMleWVUL3YFu3TGCzqdJcVtvZhduyuVHzqJhv3qPH7OMX7wqbpKluaxI7fKod5jPH7/+z79Rlo6s8/LMnzybGXLtsr/vrXDuscsXEvB06dQz3KZVJld84ln94NoJm0W54Sr7xdnwhrr6vPmKw9KMqcwhJDHAlfp7y6VL/dnQl3YxmM3YL1dI/B1my+ZQ6cQmM3Ey2fQhb5M8ArcEyI6s1+fDqcNz0irB2+RHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed+z17gy1nUzFnYYuMeK9qh63Mf7Ev10Xlx+tCVXkgQ=;
 b=wrmlLjytLdeRrgO26sP3E5vohQfVvIzXhQqMqvMw0fD2ArdZQt55bSaCFhQiEdOXc7GqNKiIRkd3btxOf2WyA6W4hXiRAFMiBMiHaIvkNFRz/Br/5ykEALbj0C/7CZ0JfF2a0maGJ0N+sp789gaguf3MjS80p9z3nfuJza4/JYLnL3ZbgqS7BDxtkzHWdv4mMR76wWMOx3ETGg9U1MVPh8bhP7wdZee/F/7HYG4K0eKQBL93cC8mGXT24pVsWMiTfq1i4E/tpoc2IF/rVXQCtyIFCHUottWfQekaDw/GytdZw/154mGJ23pkIb+iDw4jpilUpgkkaO9Kd73bv6/28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed+z17gy1nUzFnYYuMeK9qh63Mf7Ev10Xlx+tCVXkgQ=;
 b=Cmgrp0s/5kJpvj2Ry1cyp81g6zf0S2yKu8VIQALGps2zGp7GmIcLMx5nJ9wo0xJ073HQ/oMP2+bBCxMO9igkoUi34GBnudQzgjUU62FGNPD5zm4u12ECUCuneCKFjfEZoEG5QWKTdCrLqcO/zMVvEvk/rv5JQK9/q4FzNHnxwEc=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 04:33:25 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 04:33:25 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Ugwekar, Dhananjay"
	<Dhananjay.Ugwekar@amd.com>
Subject: RE: [PATCH 4/4] cpufreq/amd-pstate: Drop needless EPP initialization
Thread-Topic: [PATCH 4/4] cpufreq/amd-pstate: Drop needless EPP initialization
Thread-Index: AQHbHM6c8jHBO2HS1UOD2ZpG3n4+rrKIzu9Q
Date: Wed, 16 Oct 2024 04:33:25 +0000
Message-ID:
 <CYYPR12MB865502F3583B68501F87C0B29C462@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-4-mario.limonciello@amd.com>
In-Reply-To: <20241012174519.897-4-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7164857d-0dc5-4a0c-b6a1-45986135e80a;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-16T04:32:10Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS0PR12MB8765:EE_
x-ms-office365-filtering-correlation-id: d6b8756f-34e1-4ae4-73a9-08dced9bac9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cy02ZHEWVXWsgUrXdtXfuNlJeQNwJqNuvohhCf4WyjdD7tOKY8XIKRETbUFB?=
 =?us-ascii?Q?C44k9n9kSfBjsDlmsX5/Dx4eKsdUabdFsKniHQMGtmdq1IV1C+PnKViiIPDG?=
 =?us-ascii?Q?K17GgVaERf9ym23H9Qqd722MZOhcQou2bX64P121ObX6HR9195UL9GkhF4Ro?=
 =?us-ascii?Q?x9EVKvMl+74BH9HzWs+TVP8iGuVLQaPfLLQREWCO9pydAdkYXI+COQmPyxVN?=
 =?us-ascii?Q?icG4v42ZCW2Htr0kSNEdB/KqiLOHW8QsSKTCXZSuqCREFHE6KZQ6weSa+vBk?=
 =?us-ascii?Q?VsVWExTopDCnLUXwf+kGBlO1ijFxLmwG1BrgjxC/ORsX2VAyDLaZty5GwCly?=
 =?us-ascii?Q?qYAvJkJt6i2avgtbem/w180T/xmM5a8qYrkZkLtFfrj5Y9ujp/Kk41FJQuRT?=
 =?us-ascii?Q?M4lF1AbjDCNeGLvMph4ywlD4I7UufM1uVnVeg6LypHlJaRDYk7AfLAHGEOqg?=
 =?us-ascii?Q?u/YK3JSBiF9R/K1ObC9u84/Fi7KieJP/OmMfF+Jk+yzVDpx9dvvxNekTUKbn?=
 =?us-ascii?Q?dUhAnVYkfe8uiPZ2oRp8VpPX2CDcYvxCyNFAtANWnzOqyKbkwtubAbIc5uUr?=
 =?us-ascii?Q?geCPHJ911DWGe87Md2zJZ2YlbgB3mf5zT5hxllrQeGH3fE+y/ec2VjjkbSf/?=
 =?us-ascii?Q?YSBVzLxOFMXHjD5eICgjB97x/vcYxA7HPvvuWvqoWLM2aDo0wpigieFL5uLe?=
 =?us-ascii?Q?3HOTPzQS1pGkXon+qoc8Jn5lRklxopuXPvRlNaEdaXdwd0guQVemAnkFRIvR?=
 =?us-ascii?Q?++xjzKyun1mEqmTPJ6uyLW6HHiag4yyQ0O9espdw+5VKC2QtH415H9UAOUDu?=
 =?us-ascii?Q?KgcjYC4Ee20yO/05afjyZLbLlC/AJCb/PpeA4BzmNbJ9V6IY+jwbFTZY7gRf?=
 =?us-ascii?Q?lDRLq6x570MTH54P62wHfsDOxnMvxwgr5BXhpNPi6Y9f4ut+dJRd3U52uDop?=
 =?us-ascii?Q?gdNdNieyuY186Ig7jicr6oqc2M0E5znH8xuK65RJA1xvFICmdi7ff5KH1FzN?=
 =?us-ascii?Q?gI0IgO5aom6WQzoYgw5b4r/DZGqxkhkIiuLhi0SZr7UmcJw9fNtj8S0l7RSx?=
 =?us-ascii?Q?snVOhl5GXxf2usWnoJ4F3/QXdovyMp65twpmzIyKB41hgEApcyCKrL7sD1/M?=
 =?us-ascii?Q?tigNQZYM29e3NVJPs/1cFlueI8M0jwiS9yllOqgC0QQWhVnwyD/0qtErrsCX?=
 =?us-ascii?Q?y5BsW1UWAkjcQ6GFpzadYsyyLZiTwCMyTbdrR6LFAIFAI3pSsyjB/2ukFKpQ?=
 =?us-ascii?Q?gTWyWoZGwny1/d6VjhgfGoabT9lGkdInchr8W17NUesf8ERahcHpYOD3y6/F?=
 =?us-ascii?Q?/7BR1cqGHvWYfpTevAZQA2E1H0WICYDTDo/yQfoYmvSjiA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z+RxCAHZcPP9P1ukadXtvcHz9tYq7hNOAOOLC/smM5uGY+03JUkBKxAJtPM6?=
 =?us-ascii?Q?vLOFO51JNJGWFxArXvgozR3xdXl9RNmfot6xJYCK5PJikyXlHuzY7xX9BvZE?=
 =?us-ascii?Q?LxcxQBBoROIpNEG1diU7cOywKarIG495mkZfEW14kqs62iybUJDFnvTkxJkU?=
 =?us-ascii?Q?Z0/fZM90Yo5+rPoVA4lITjO1eVWgSVFjc0UYDS+5uMh6Jn9XL38KgEBwgpjP?=
 =?us-ascii?Q?MOnuVzz+/N7QJY7Q2jC4HfR8oEJsl8TdS9ImXaR8rjDUVK0xanHRV9qVTKnc?=
 =?us-ascii?Q?L9Ul3Bs59qCu5gjKDruXOQanEItferZh3eL8/HPMO2nLi7xko4/O8aFSfmJe?=
 =?us-ascii?Q?PEve8J4mIcgMqaUt/nq1Uu0ABOMgW0pFYToBFCkStE6GVBZDzVa9g+t8GSk+?=
 =?us-ascii?Q?XQcaT/0O9Smj+tYjOUc6u8NglGX+oXdPQnn/0z/MtBNtn1Da8UR1m/r5j9+f?=
 =?us-ascii?Q?RZHYMVyJVoTc/xolQBSuRL7H82z+c2wl5Kw8R2BtuIx0PlSLTqvBNEX/+d7X?=
 =?us-ascii?Q?eoeJSIY8kZQTPl7GzhxTUF7sDUYjxE5y6sGI8ekQqq7ocjVhyhF/Ifv6pXqb?=
 =?us-ascii?Q?WDdftgGOitRCzd9W71GVpDkhqAmdN5wMnV7Pioy7k/nl/nD89ibbXhayM+jT?=
 =?us-ascii?Q?P84FCoUJwSsy6js8HAF36b96Vvo70tqgZamCQeoxAwrv0LLWsVwdK54HBhb/?=
 =?us-ascii?Q?iMyou5gpSd+a1l90bj0lS8D81q1EXa0bl7xzwsnhz02BlmPjhLvysTiSRkqw?=
 =?us-ascii?Q?BjnQSPfteSOmi7cLBzQPLoycEepxkAHXY20dmBO7NlowOroYuM2xD1ovDIdW?=
 =?us-ascii?Q?t56voA4Jy74IYFU9dBgAbOqGkGYARPoegzgpvCNKXJdiZxD4xuHo48IpXEfI?=
 =?us-ascii?Q?sARy7rcbgPEGllXwxgCKhMV4fA8bMvKceSYQ9kZlWlkIPwnd6MMyv6M+O8CO?=
 =?us-ascii?Q?FrwMLNydJ+bg/UNYjYKZmXsSLIXCvmW/7TknrhPQGYFAkggU2Is1W1BRDbqI?=
 =?us-ascii?Q?iwh66P1DEu4gjjdsjcaGV4ROq28XjduCa6pTeJhhIm8a8568v7Ri6ZPQBqMr?=
 =?us-ascii?Q?+93hqwghvAG1fo6T3qgBdeYVwnCCY4CZISTODganm9PlasVNQZoAPk4pEpL8?=
 =?us-ascii?Q?TUTVPzup3OYjtIkdDd63ff19ZV9GJJEAQTTfE2ZLEdNV2HTxuVKQnHJN7CDH?=
 =?us-ascii?Q?CUXHbmCHgTEE92wtzzXTBA1QYdIL8BT/3ekV/cNFKJsQaqhqOpGWLsh5wwCc?=
 =?us-ascii?Q?lDtWfXR373szSFaL4sbRSo380U2MRTzI8kFugfJA+/CKbCycepsN3MvP/3On?=
 =?us-ascii?Q?4J8hDpPPE9z+8OcQ0EKOXquE/kDRIouprOwtEcEOXMOIqyhxnbIvQen9e6jO?=
 =?us-ascii?Q?zehU41BJJDI4IhrIdTpFQfz6ZL1qG5yAiNYv6mNZmAXiDGY4MCsu04253sRz?=
 =?us-ascii?Q?HZcgwcZF/ldvGT0AJXb48CacjDHop0gQ2K3xg57oH5fd86mziINJLH0pfvNr?=
 =?us-ascii?Q?mDDZ/GpBNx2fNBfYNKXH1spfYnAHIW1CFcRjDDvjsOHON+CETNt25YqmLCf7?=
 =?us-ascii?Q?fgwRGxwLpK2HTbHqW6M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b8756f-34e1-4ae4-73a9-08dced9bac9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 04:33:25.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dl/Iajs7Z25nGMIBvK5xayngcljjBu5P3wFxo/ze4PvKZwAVIKERZuDRUhhzfUI0PUxWcblhpGncupwtjiFiaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Sunday, October 13, 2024 1:45 AM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; linux=
-
> pm@vger.kernel.org; Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 4/4] cpufreq/amd-pstate: Drop needless EPP initialization
>
> The EPP value doesn't need to be cached to the CPPC request in
> amd_pstate_epp_update_limit() because it's passed as an argument at the e=
nd to
> amd_pstate_set_epp() and stored at that time.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 8d2541f2c74b..90868c8b214e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1528,12 +1528,6 @@ static int amd_pstate_epp_update_limit(struct
> cpufreq_policy *policy)
>       if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
>               epp =3D 0;
>
> -     /* Set initial EPP value */
> -     if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -             value &=3D ~GENMASK_ULL(31, 24);
> -             value |=3D (u64)epp << 24;
> -     }
> -
>       WRITE_ONCE(cpudata->cppc_req_cached, value);
>       return amd_pstate_set_epp(cpudata, epp);  }
> --
> 2.43.0

LGTM, thanks.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

