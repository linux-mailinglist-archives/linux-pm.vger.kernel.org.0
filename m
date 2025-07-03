Return-Path: <linux-pm+bounces-30091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12FAF83F3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B9E160ABD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2726528ECD1;
	Thu,  3 Jul 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="YylCKVtj"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6323A9BD;
	Thu,  3 Jul 2025 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751583783; cv=fail; b=Yh9aivyEsUujLFMoJgzntUGHMl3nlzA4NSPLfmS8QO0TtlIC7VNoMyYOMZYTfygwIrxmdzmsFzV0+qdReBoantQsPx6UPeqWL8VwQKKYAgBKUwiVZflE2u7q8M6UUwDGjfwL3Sr6ThkQz4RIKkAnQbPAh6F267/rXvukqO1+kmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751583783; c=relaxed/simple;
	bh=Q/Fb+ONYz85e93GTyBhiEanep6LvBiGzohQVbIci61Q=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PiJiwpregu5OkgfZrS3wUbP91CRjF/xGWQVoU5TlXWoh9Qt7UVnPgG42LsBKniuknw22wS5sqou2rhG75AGg6vjvuw2wu3uKlXq0Ekhx2G0CcYTKPWrWLSDxmrSqQJnUs4mhxNuwVWvj8gyO8p8iWFCMc0aVp3n5EBvc4QPq3Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YylCKVtj; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWF9AP0aozVIFLZv4kwGmr8Rq1Mn/5mAG2CwsFgPRrHCI6UQJazQ9FzXKkCbLR9HeaKihs4bUW0L80bMUiP0WV5TuZ9ELDPQ36MXyyZj3qamplXg6F19v428y64byCiJHBXdCZDbh1AGa/jwSgTEmuTF2vWnqqR/QbXVLeID0GQykHQ+D5zugS3FA6/yJfVce6CQgUP5mGZJlIFim6XroGJH05azL8Zi1uJNZIvrLhNGo1V3zmaYLLARTrwIPlR/HuXGTSxGeTOwazMLMWzoYeqarYOONe1jTc1Ba6v3BJvj73lLDp46bdRjqvBs08HCMwk/LRkuTyDCnVp28lBk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPPrH7eFU/6FKBcSO12jUy4G44f+g2YtOMxLx8VZGEU=;
 b=UodPpF3dplq3A6Mz73KUUb5oWf/Up6Dlnp6TNFrYI5USjlD5mYX6Q/EiocH0IsFeG5u/UyEhgsXdcKADQk2neQzaPEoriMDPqoFM6XHbR8qW3RwVRjLnt51RoGOMlH8od8unkMjbaHuLIzFOwCCAXAvsuzMaT1qc6pEFIm97mudCCkU/bVi3bcxMM12iTU4X0qKYDa30DHm34zuX8Zwm49Lb+U8hBsKqqvQxMSCNsjs9HGZ+z7mNCAGDzlcO2PBzfBcuGGnI2705uAuKeXgNzsCXhEdsz2oj4q/NwmNOAM2xy1pmZfnP2pvhcRLYamSVj2Q1GT4HaZAi4lZlDGb5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPPrH7eFU/6FKBcSO12jUy4G44f+g2YtOMxLx8VZGEU=;
 b=YylCKVtjUEXVR+jgaqt6vG3wlJ1INKEzKp8hFUSX2J+1Q4r3apEnBpATkfLN6FNwmrMzB47mlNeaNmASJ6wttSBxVpO2NHEPrjoUGPAAEY/CKTjT+p9KaLTZcFF6z88GQeRSyAWJYHl5j9eGlhMAejrobBw6cJeHqg1As7gtg2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSZPR01MB8468.jpnprd01.prod.outlook.com
 (2603:1096:604:189::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 23:02:56 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 23:02:53 +0000
Message-ID: <87wm8oq3mu.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pmdomain: renesas: separate R8A7791/R8A7793
In-Reply-To: <CAMuHMdWzSY1FofgbveAZumuuyE6B=Ub2Zxpd9_ks_d9KmrVYtA@mail.gmail.com>
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
	<87h5zucac8.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWzSY1FofgbveAZumuuyE6B=Ub2Zxpd9_ks_d9KmrVYtA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 23:02:52 +0000
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSZPR01MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: d55a272d-d3b0-442b-25f2-08ddba85bd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5n8MOmPyEwcgbWvy6qUyXa4ixyFpcGjNoMqk+iSN9cahBxehZ6t10M5TwYGA?=
 =?us-ascii?Q?Sps0Cknrse9RmEMNXbJN3VEiH6SnXIsbHDWNYLQvQ8itxZR/kRgzNTIQwAws?=
 =?us-ascii?Q?CCxkE3KsClMUspT3CUmPFSjyevg0lLslWcKGpdFNlFGzbsNsCraJiCKsrqKy?=
 =?us-ascii?Q?Kp2yj2Wu10r+WMQH7SatBVFmr0S9IlbWVx0aw6MFZdZu8dSDuCW6yD3PJras?=
 =?us-ascii?Q?eD6pf9/xtxHB45CiHxob0Locv6847GcosDewr3CjxtKuxnkbPE8yFZ0LQB3G?=
 =?us-ascii?Q?RvkjXefcyPJUCDePmFuQ6ma1MIsyAlfXhDdGvuvHi5uqH/SVa5GnUDvPbL+r?=
 =?us-ascii?Q?DXixRg463ceFdYIUQlTcU/mOESW8nKF7GQco7sXGNSguQuA15/ycn+2Dyo0Q?=
 =?us-ascii?Q?+5o2XOvXcogobGxt+JYPvQ5TPS06OGuepAVHk+ZPi91dcD308bPMDXsfq3Vg?=
 =?us-ascii?Q?OS1ck6KInAt/cU9LwHQHTCToK24r0JNIes9HnKIAMelKuuViUpMV4iwrP4Qa?=
 =?us-ascii?Q?an0t/yKks0JLz2uY16IpV+jCi+9hEPPOq+V8Gux48+8K7ysmWeMnKm7l0tiJ?=
 =?us-ascii?Q?2WKkwV/bQdqT8xncGVrXRLzkRFs7JzuRyiyGsqKDZl8Al25S4a8lHXW6joi4?=
 =?us-ascii?Q?MPo0rv54EdfQtAHYxUW2fYbUAjoYOERv4fqA/FCXFWj0Y3vphT/CuFXM+C9Y?=
 =?us-ascii?Q?YH7PtJycjUgJb7BE+A157g/X5yv04vtpUSZ7OjWKD0XunzCgTcoUnYtvRhrq?=
 =?us-ascii?Q?x6H6QZNcReR1hn2xqN4hz1OYgNviL34cjtyiNU2EUCjMW0g/DccFRZZzrX/A?=
 =?us-ascii?Q?C5isT+w5OtPU5ZGouMXe3kqmiWH+cMGoJ7Ij38Tx56kHvR0OZdbwPsO0fjDR?=
 =?us-ascii?Q?9V23dSkCEnboe7DG3zb8U7I2kGBccFARM8UHzEyQ1Q333wfKS7Ezf8+f/bPP?=
 =?us-ascii?Q?8rasL2dJQM4SbqLK7ykCHQbYkdHeBofyTu5f4bG3JWLwyn0IVbsN6Gt1Mkmp?=
 =?us-ascii?Q?dYBkdsc5ken6HoDKy/7tPr+OliD2VcxaUf+a4q1tRL5rgIhrk8or28m01FF4?=
 =?us-ascii?Q?g7ING+M0UObfYrTYIZLE3GCO5sXXRRw1jh9sj1Y4fMlQxwhN0pjEkopGZnop?=
 =?us-ascii?Q?wAWko3QWny5ctYtG+LjA0Kp9xCluK/R2RRJ900FoUeqk4D7E1aNEp7owEVpD?=
 =?us-ascii?Q?/591/fyim5Abm5XgGMEJgXWAepaUBmwO7TErtSZQ94ob9cSGite1Oz5s+msU?=
 =?us-ascii?Q?P8oyPYCfFVAXLGKybPlGHC0GjgBTvs0QoZymsMDkWaA5SRgivdxpkzcmHRFg?=
 =?us-ascii?Q?9Sr9U8Zj7S4FOacIPErttEvdA271nsU1/6eeikFKDLK5gsqCuXEGOXVdY4UZ?=
 =?us-ascii?Q?FNb9b0HWel36HCwudGWeQqQNBpYghrzYwmomIWBGcc7m6ua4Ruh5I7uZWNPH?=
 =?us-ascii?Q?gc806IvQLJJ7IdToUopqlvg0S4LWw07n29xYGls/fd/rwskReaSnCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?On9u36NjVkYApUvBGk67wHuM+YDQ3EHIgPYuFcPkeRJDrWQ9RdK6H4ZWPqLl?=
 =?us-ascii?Q?UCFzJYNoiHk4EcPTGra5UupPZMjruejwxp03fBh79tbmlkwjm3qDFiepZROu?=
 =?us-ascii?Q?Gi0HfxPDNgV6zhkB+diS4sAHfvi8cMVsCzjgQhB9lbTKUq9dob25VYSx1eC3?=
 =?us-ascii?Q?jE8VjQUDqqL8UIfbUy1HzfWPhjPx53rvHxODYAsKtsqWJ31khcpPulVn+5YU?=
 =?us-ascii?Q?/vzkBhMjiddLN68F3S5k7XDxjj++ftIXEBeKPSEq4wCS/7SpfX8711Pza3K2?=
 =?us-ascii?Q?PRQZjXib0sr0YsX0DoRN6UYXrrJN888P8mwi8k8IEJJQazG7SdfJXsVjSGQu?=
 =?us-ascii?Q?5mjtAIOyFDH+LScbx/t7Jc0hJt2d4YoMBxHn7a3x4sqMMTCibmPdI5Om1Clm?=
 =?us-ascii?Q?rM/rMhIVWtAdV+NEyf338/OyoqGG3N2764G2LYH1LTd/hl5eJeAYG2q7uJaZ?=
 =?us-ascii?Q?Mux0ud8C8LiH0OZvcNYx2FphlZGOleecf+eJtodHtYEwE/PEFcOicRQLyv3R?=
 =?us-ascii?Q?FQI9K8pzPKfqXJY84FAzWW9Xryu5I64GRxQ7596czfAnMHROtv1PmChvLeyf?=
 =?us-ascii?Q?qL8wbF3CZNg7bxYVv/AacKS4Rl9Ne4AgcKoGLBjpD1vnaEa6MXr1viKzt2vj?=
 =?us-ascii?Q?ebDDN7MFFtFwy7jT0flXXg+iD0FgDPegwixtG8AwqT0Pxt6KDXQ0ewG4ErFC?=
 =?us-ascii?Q?JKYVrSzSuoZQi/jkHrECR5pJvTxWsZQ4m/tUkcAc9Mkng48cuneNt0nfGOfO?=
 =?us-ascii?Q?gBcBBguxAJS8lB8M0zvPEm3INHeLla4MsuWJsWzRk1v0tGO3VksXuE/FnGdA?=
 =?us-ascii?Q?/YSQFGD7FUYp/UM5kMwaZORqSekf8DoXD/wzv/60L27sX9eiIdZhl7xJ8rnq?=
 =?us-ascii?Q?BIcuWErvfLUAZZDxEHHp8K7nfOo1ZUQ1ZA0Gv92x372/XXLj7NlYrmtbIGwd?=
 =?us-ascii?Q?bheOHeh4oAtDBV7qsDdKEM+izxACSmAO68SRCM5WB+Oz+pDxa34pbLoosAbt?=
 =?us-ascii?Q?MlPAq1uKvT4+K3DQU/42DtanYuvuE2ERfDj6F2gq79XjqUHJJXSzeG8wUbPy?=
 =?us-ascii?Q?4Fvi5TtYHnbx7lvjgmwhXJhmIaT8y6eDYPLyCrebHgErqc3LQ0hmxUkKgTQa?=
 =?us-ascii?Q?7dPrBc5bZJ/5up5+Qz3B/0uAL8yaM0xq8oGL5ETT1w7sdQJEtIMDDAHdaCYU?=
 =?us-ascii?Q?zABbcwfC7AUaSEotIAP8c2unlMby5x9JMYdUyYlDMHQOGYyE1TZbdVYUTT2c?=
 =?us-ascii?Q?gEcDs/st4Gg2dBK1+ACq5M1P/hjz6DLyYZewEQ+Kxd1t6wXAd8tCMkZQ6k7O?=
 =?us-ascii?Q?1ZQB4n5GNlJPpDItykTbwkEYzPswPdDJ+yPpfjM8lotjWul7V6fkgG6agcA3?=
 =?us-ascii?Q?qTdayWNIjCLcpaRntKkYHbQtVJ671w1ebFcXfXYNYPliMT+G0goJtRLb2inu?=
 =?us-ascii?Q?b/1HLXMKr5ywjWlQvNEdaY0CjsV9neMTOm/g9tjTOxdTLfnyUVEIe6Z1KfFP?=
 =?us-ascii?Q?4jJvBhgwUR9y6fSe6fm7PD28Mc4h4LYeP8ehHSkMV+knFVniiFFobxCL+A63?=
 =?us-ascii?Q?sjxCa6IxKEcLcBtbo1SJdCHkPo+p/YwoWh+ZmOpZh4+wO69fUpodOzRl1eIQ?=
 =?us-ascii?Q?IJxvgBX9A7/rdCX+YJPfNYw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55a272d-d3b0-442b-25f2-08ddba85bd7d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 23:02:53.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l71ymGymqCu+SWW/aSDrxwfwrPRFnNepL3xR6kuc55vn+x4ge5Towa1QDN1wT6ffAVqz3dVb1bcKCLyGQ+12bQb0WM4DjspA4oUq0KnsuBzsy7MOZ0TSGV9jno3g3vDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8468


Hi Geert

> >  config SYSC_R8A7791
> > -       bool "System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)" if COMPILE_TEST
> > +       bool "System Controller support for R8A7791 (R-Car M2-W)" if COMPILE_TEST
> >         select SYSC_RCAR
> >
> >  config SYSC_R8A7792
> >         bool "System Controller support for R8A7792 (R-Car V2H)" if COMPILE_TEST
> >         select SYSC_RCAR
> >
> > +config SYSC_R8A7793
> > +       bool "System Controller support for R8A7793 (R-Car M2-N)" if COMPILE_TEST
> > +       select SYSC_RCAR
> > +
> >  config SYSC_R8A7794
> >         bool "System Controller support for R8A7794 (R-Car E2)" if COMPILE_TEST
> >         select SYSC_RCAR
> 
> When configuring the kernel for a Renesas platform, all SYSC_* symbols
> are invisible symbols, which are auto-selected when needed.  So I see
> no need to complicate this internal invisible logic.

Hmm ? Yes, but it is for Renesas case.
non-Renesas can select it, because it has "if COMPILE_TEST" ?

I can see like this (via x86)

	...
	[*] System Controller support for R8A7779 (R-Car H1)
	[*] System Controller support for R8A7790 (R-Car H2)
=>	[*] System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)
	[*] System Controller support for R8A7792 (R-Car V2H)
	[*] System Controller support for R8A7794 (R-Car E2)
	...



Thank you for your help !!

Best regards
---
Kuninori Morimoto

