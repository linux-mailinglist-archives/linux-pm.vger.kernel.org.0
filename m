Return-Path: <linux-pm+bounces-30325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B406AFBEB3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 01:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498783A3BEC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6E265CAD;
	Mon,  7 Jul 2025 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Xqq3DXC/"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010067.outbound.protection.outlook.com [52.101.228.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472627713;
	Mon,  7 Jul 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931646; cv=fail; b=hfuliB0fVaMquEvbzTdq4dwECtc6SWwKo4SDlqAb8yEFmpUKvNJ7lo2pPea2ezes/+5mFw0JZ4ncY/QxTiX2yor1bxqNpTR1F6WWOa92KubsG/n4Z05hkxsCpmsvnxuZd4QtGkqvNNecPUbNz5Mh0N+WaPyCiPUssbIcYEjueGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931646; c=relaxed/simple;
	bh=aT0Vu+9AWjuTiIr2SLgElnxIkmH0tnn5fgROa4wN9R0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=P8zQ/kSVCqu6YsoyQVh1fiRc24/fXb7WoJb2oSNGrTmx/VFryW8mI0HE6oBvRunLd6rDRIUhsLUQWPVXh8Hf39TH1Q5mbaEr4LmPzP/yEH+ISi875tCVl9fEDWmwREY0H9Ns5xZ5ddPyj70K0os9yzfLIIb0Eo8lj6ysqj+AXsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Xqq3DXC/; arc=fail smtp.client-ip=52.101.228.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaCDIxotSH7GK+alMy2nCy2XDprkxKj/lVtAFXten5jGIJCIWy4EELJlE1dTxdv6rUBp4NhAWao4JfjO5tcUqDmGLqRzdgWDqWhAKIkzXtFVeneZYKgCacJMMDPu/3y/z3RDJQ8k7dmOQuBL/5S7sSpCcCJ6pVCVxKNeUSooz3X50Q7R48AwWoBDQdBh2lWig+uQFoYn3C+s3udezQokiS2a2sQ/o7wX6fL6UJNlHc9t/D1dCf01u4m1SEy19cBNdd9wMLJfyOAZG+JwKA6T9Ljn8JE5j+jYAF3WgBAENi7UJgKEHCoNMuMSDjcahtV3fNkqgEviGeOlz+DV+vTwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re+dY1eXhlRDTh5Rzy6RqYJgsWGNix0trWsU2CFTV9M=;
 b=gPks1mFc+oGNOtfYoowCO7AA3NadBC4Skp1lN233Ms98gaOcaV5RcvEZTQcI8eK840YJjiMu1wuWpT5e8Xw159iH6rOOr5w8a4RfTlYKzsvsV20UA+ig0mTODdkHquYWVG7kl7HUm0UGjQXGkFdaIr5olEsf5M0RBfwhSvCfH4k2dEr9Oj/GtiFJ4NG0gScBq6cOAHHswhWHMJ7ck5zWwrjFQHhER4JcvmrHrc8qf7eH3XY2+xenf2Ma6Jk6Ad2/mQ2bGvMpdFJ4vREt/XDQVEkvdx+5skrrwavbdMSHNpxf8rQHNhopMNIws+lwO0Uv/jV6RyJJTtY8t229nqhKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re+dY1eXhlRDTh5Rzy6RqYJgsWGNix0trWsU2CFTV9M=;
 b=Xqq3DXC/eF4qeGIXIqbsCsVGOQkMgk5XqFilKoBVdrCPsKcob06jJBLA8rQSIYOo36Gv5u9Hc0D/QSO7SrziCp8bQGwatL+g+Eg6GicIRzw+IieZG7sR4bjX8CJrcImA2uvnno44K9GOvqyyAPd6pkluaqniL+tzHRRNM5KWGk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB13299.jpnprd01.prod.outlook.com
 (2603:1096:604:34f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 23:40:39 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 23:40:39 +0000
Message-ID: <87y0szmux9.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pmdomain: renesas: separate R8A7791/R8A7793
In-Reply-To: <CAMuHMdUtrzd1yQpdQcDuFECZipzHob=RNGUMKZSPoq-zGXemxg@mail.gmail.com>
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
	<87h5zucac8.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWzSY1FofgbveAZumuuyE6B=Ub2Zxpd9_ks_d9KmrVYtA@mail.gmail.com>
	<87wm8oq3mu.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUtrzd1yQpdQcDuFECZipzHob=RNGUMKZSPoq-zGXemxg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 7 Jul 2025 23:40:38 +0000
X-ClientProxiedBy: TY2PR0101CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::27) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB13299:EE_
X-MS-Office365-Filtering-Correlation-Id: 951fd59c-2f6c-4725-23ba-08ddbdafadc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lS95KnJI+otSJ/ix92Fh3xlifdjERCQIzhkD6TCt/oFFAx40ryXPvnxupzhK?=
 =?us-ascii?Q?x/MgKcKw2+h3Epj78IjI3Qc/ZYAnrfJLFsjun+a8iLWndEEIdvf/BFHFewWT?=
 =?us-ascii?Q?FN7+GRC1i4cAaCq+yImk24NsNcGLr42gt421m7OCjKUEdm3VoVDF2fDhPw6C?=
 =?us-ascii?Q?fVsCIIL+HFK+Libe1vDVtazjH8fsNUCX9F2g233+k3gz+WNLa7HsPS4ADg7V?=
 =?us-ascii?Q?wFCMMuxPKTEreBbI3IojwQscdafgL+yk0kvFm4NyQfCjHXKt4BqKWaCZtTdW?=
 =?us-ascii?Q?omCbB+OQlzi10nmX+xS0pwIyTIEEzCak9I4OxYTFmaHC/EIEVV6fKMqANBqA?=
 =?us-ascii?Q?1qBkL8Z0tb9urHwbDaNWaYeLJmWpm64iTAM1tgZ5Qp9yRJv1ggMU77/jbp/V?=
 =?us-ascii?Q?S52VxCs6dARfj1JjgFSMj17HLoIGlAiTGWv76oqJvmx/y3wCAweVaefUyq4g?=
 =?us-ascii?Q?uJeWC2Uj9fHd/Mgodex80iuSeTp/fo4ueSRBdYaCSMr+8zC/DZrkzoYE43jO?=
 =?us-ascii?Q?aYuvnvPZZu/4C4HaKauQqZ8i5eDTaV2UKTVUfoV4pT9xIduNhunYICVQd5fS?=
 =?us-ascii?Q?mhUqsOBXuUHLlvaHW2mPxum8CKDOPvPhegf/LnRKRpSbc1+n4AtTI4Q12UMG?=
 =?us-ascii?Q?ppvyvUZg+MV1KbhTI6OhtJEFb8BMregTOujNDjBvUlEpoqn61ACIvLGZIw5d?=
 =?us-ascii?Q?0Hrp8UME50h2pQggJVpBGOB1aYl96mkikV+HzsEbSvexdA2UGdau92wedFCj?=
 =?us-ascii?Q?JZ+568vfaAxdCwdSXUJP4xGFxQaeBxOehPtdz8x6w72t1athHION26nIj4/5?=
 =?us-ascii?Q?+zrQbNZJtsgVnRzF29W69rtGw7MyE6DNDGBmVJvl5Az+wx01VmGBcUoveIrZ?=
 =?us-ascii?Q?GmifbyV6ax0p8H0TqVRTpsU0YA2ukHe6jztaiBQ6jLe51FZjeh6qqtUz56ah?=
 =?us-ascii?Q?FJ7EhtYNKjCE0DNtYYzfV+pZLPcS2G28EEwYyW9v7rg/jV6FUrh978EoU3ku?=
 =?us-ascii?Q?ocjEtBY5yOyR1ZtDblXs6EmzrgdGahR59JkUdxKxBoo6REFgIXdxutVPrcy5?=
 =?us-ascii?Q?0r5sYPIZAFSTmy0cnuP0eOCCakBXYimBNLYOz3YzL9Hfgr4wXjA1kMP6I315?=
 =?us-ascii?Q?bFQ/KWDQrz0ik4uNMb2at4q97zMr/++U7gZg3YV3NuVZ5tHunRw3am2yC2oc?=
 =?us-ascii?Q?y6qJTaZgJddbaaVZQGyB0PN8Y5yndk8wFmHyx+vmj4GEUge++3Ahzgj5JBH4?=
 =?us-ascii?Q?XaG+KtzdyvVa2uHxhXrpiqU86f10sIwnjgX/ut9PRqtfQCGk8YML6WFqwTVO?=
 =?us-ascii?Q?QELkgHUNk5r6VCm0eOm7/81bTMg6cpJOw5v5024J/Au9bw0tqJqvRNV0BLwt?=
 =?us-ascii?Q?ZPAIS81Zh9jY7rh/qiI+Za1ZWtIsXM9hHVHekoH+V10fy0ELhN0M91fk+4op?=
 =?us-ascii?Q?1r2RdF8++j1lIUxffcNr0r8fiSIRGY6SqwEI82N21zkujeRhmia9vA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4WtsLmovfCQtIJa3fcIRgu/GqPH2Uj8MTIgCo9AAWIySAIr1hjmxWl3huhR6?=
 =?us-ascii?Q?UZuxIJi15SgeAXUqQ9HnM1jLuXWVchca9tYdX9XqNv/qjNJVQ0oX8kiMMtCr?=
 =?us-ascii?Q?oS380D0w5WE3yVG8BqfbNGkD3Xqe31ykaT0AV4EXGFqlbRgHw3Wc/765l1H2?=
 =?us-ascii?Q?5+Pd3R5NRr5C33Xw5vOF7fXWYyvPJTDPy3QVgRGJCCsx+PIcQdIqTILA6tDr?=
 =?us-ascii?Q?4YUjxB8pmPxzK95OWSA9nzCtwnEWYrc5LBVPYbAEKd3bSXMTVNfTwTJMBEVv?=
 =?us-ascii?Q?rBeWU2Uvr+HD3LSAuqqDempqVfHW1CYn5LdsOCB3VLJ/naxm0QIyLS4AfXWF?=
 =?us-ascii?Q?pF72T/suLvp6xKW99b9fw/fe+chq87tDhCAmhaJ9G8/jPLEKOK1KumZZy+Qv?=
 =?us-ascii?Q?Y49od8RI43waSvXVNf1Ke2ZfwZt777Cz02VfK1KSC8NTa9Qus2CFstaa3IZW?=
 =?us-ascii?Q?rQVBeMCjcpoqWNJE4bb6hAxDOwrmZ/noXhzX0ldH6yDiFXnFt9m9LVFVvmrW?=
 =?us-ascii?Q?umIBXvkefYkE+B3Nn+1XMUVBBm1kE2hrk41Wq4+VOONGBk4SWID8Y7uaMBHX?=
 =?us-ascii?Q?VGdElCGA3zgFSCWZ9Gu3ugzM99alvrjOgQ6YS9pgsT07incABp5BFzghUGAD?=
 =?us-ascii?Q?UOYToJsNCsIKbtklETDl+wR6WWk05h9UPlBsl8wKTvtgRGdVAABsgrChKWdo?=
 =?us-ascii?Q?IJoO6Ea5ADLsql60P8cYEnJIjNRoCspsqN4raPQP45QSyTX3gh8NSsK5ldE1?=
 =?us-ascii?Q?SJI4p+Ub1VY/0E6ao+qScTzDOehlX+LiEgc7yCumTjirMgxoHlZAGa+r/KF/?=
 =?us-ascii?Q?LoD73kpym4EaH7ayEuVGmwp6oq2w/U+K1Foa0Nbr0tCkkFTDRC1/6PtcOqGU?=
 =?us-ascii?Q?TE4rrScCWNMM2/QpIXsKBUad81J9ccFtqKqvqAoP2z9/prUPq1ULrTULXqGz?=
 =?us-ascii?Q?7BnnBEh8ATrXHlhiShbGuaQlW9+NdV6DpStgCR0IaVKAEMBpNJTtE6hIfrfB?=
 =?us-ascii?Q?8cH4mhLCUsWy34T15WH3kiGX0GteAwDNZ282KfdS/NMS6w7ZQpa+Uv9m3lOH?=
 =?us-ascii?Q?ncq3slDvVq8UJg4kJQTVPbD1f0PEJSk+xxcbmkMATsaHTALfxY8YkC1cbIqZ?=
 =?us-ascii?Q?VWdfBymWCduuSUQm28e9DP9SSBiTsVYg0B9ElMVBlFQwHnY2EdJmJsQijaM2?=
 =?us-ascii?Q?spEIdBMTKU0WjNU0YA33QnQtjVfUu0BJn+QLqvz54KGlYjkOsHSETENxNX04?=
 =?us-ascii?Q?VGq8Qm6cm6M4X9IjSUA9N/E01MTSYJbq9t21xwKcCi3OUPwohtTpvAQP8QWz?=
 =?us-ascii?Q?bQd+lTJNXZtUYYc39MxXV0fLwq+whimGddPcPPXn/fS1rImolwPvyl2GUWpd?=
 =?us-ascii?Q?TafEsMG4yOHrpT4oHzP341ZxCJDGFoeoqtcrqWXCAB07bmTzB/ZZQZtpK3Nq?=
 =?us-ascii?Q?+8wDhRp8Vo6Xkgc5Yyh9lBy4noxYlK7fzpEFx84P3XC3Npo/38hd4zc+rk4h?=
 =?us-ascii?Q?5GeGprFd8Ran/p3udtSndghL6DE/YTEcdJMlrZ/Y+R43zirCpp6UMOXDOvFN?=
 =?us-ascii?Q?p1cv19JZuoCmxcyvgzZaKCvA5Um4Ql1oLPK6EaG0lx2FvlTSOq2yTrKMPtAI?=
 =?us-ascii?Q?Dd3W6ZnC3HkZOm5nQ2cpF40=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951fd59c-2f6c-4725-23ba-08ddbdafadc1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 23:40:39.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9PxmzD15yYkmI/VvvhWGtnSiDX28z1szjRo6IYVVIwawH0c3TqZXnGN+8EKHcL0eaxUfc8B4aOje3R8260QxGRpTiXe5GMvtY6JVKkGo3ptdTmoPhG3vRlnF3Bh/PPw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13299


Hi Geert

> >         [*] System Controller support for R8A7779 (R-Car H1)
> >         [*] System Controller support for R8A7790 (R-Car H2)
> > =>      [*] System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)
> >         [*] System Controller support for R8A7792 (R-Car V2H)
> >         [*] System Controller support for R8A7794 (R-Car E2)
> >         ...
> 
> Is that really a problem? This is shown only when compile-testing.

Not a problem, just a clean up.
It is confusable.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

