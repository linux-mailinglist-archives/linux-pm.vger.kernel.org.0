Return-Path: <linux-pm+bounces-30000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E1AF66D6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 02:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA601C43D1D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 00:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C6F1F956;
	Thu,  3 Jul 2025 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="cAEhfwis"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011014.outbound.protection.outlook.com [40.107.74.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C502DE6F5;
	Thu,  3 Jul 2025 00:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503017; cv=fail; b=dX0/hEWaT0ZdRVnoDmzKZ6tN+HUtHZJO3j6kv3Pt/4iiIRw/B5bPHBCb95Mr7fBmUCFTWZqMcgAAFBeUQC3f6OHakz1vivIoIDs03jjIf1vSrLHNvD+/7cuVBDz9i3kBS3FjBmH15cT87/i+u0qnHqDg5ssCC6cHFKBm31OAkVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503017; c=relaxed/simple;
	bh=u5ZarQi/J8VrcTTwRd0I7kMgo75A/BxoGIbIDXlrswQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YiLt9s89kQEdkSX8yk4RhbORdXYreYKUyRi8D/gBbSuHjaPA7f/YXQRaSAgQlQ0MZpzT1QizIe1FWg2Vt61g7uyJg/AmxVqailBb5QrYOklTxvI50GAljubyEUGJsbnhAdnnmK+9BbzlkCZmIVwVn9Gulj999RbtvIS8AIj9imk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=cAEhfwis; arc=fail smtp.client-ip=40.107.74.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQjHbqratkGMCsvjoAxhPEByjqr0SHatnXIm/yeXVFJcgo8a3u0CNSPPvnQnAn9CL38Y3gszr0Cn9YRHrC6JWw1VtU//lsH6p4hPcREJFwhsIyK82aY+dJPa13nzKWDfK/80B2ZmFHdWnsPYtcK+qLgu47wwFOm+m74+M2mMl+C3SNhV7oGmmqFkKcHUW/SESxusfcJLKr3rEcD01Rpms2DctCGGpRqwxRDRwffgHlndPPiWfaBXLUjCxp7EPGRjpMMuYDMbzJ/gI8jnDz9Wlm13mYyEOxtxa2bk+Mu07JYLLJ6tP4bQFBGITWnkBcM/uT6rYV3jPWAU1qVa1mUpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxHY8qne40JJGWIu8JPNIEATqpyDkzf6alJTY3pBBug=;
 b=ip7VlR/w201cFMQTFl1o9IuYh6OvZ//VkLy2Mr9CKqW6A0z7MyE9loassn/XLPh7A3he8F78oYba7RTi5Lq8d1GLdtiXUk9yjUBz+syXNGHTCcKqJV3+2Vw4HXBSAys4J3jFhhYAk/1hIdhAk/2q4Gt3mtoPBMxDP8Ir0rGHjdZD4CrtqgD7rieG117FkuXeHyVAGp1OPOIo+gUbZVDgcLlSOXkakSb/WUNELCeDXDu2hQ0DVj8NhVrEatAvGELYrUhZrtPpgZx4Jbm9G5DgTaLVxdGDBsQdVatIGcg9X3N2TKUfnLWc3Y0MtshzzopYXV+ikCfvTwj3UUXM05klMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxHY8qne40JJGWIu8JPNIEATqpyDkzf6alJTY3pBBug=;
 b=cAEhfwisSJhj70z8iJwxKV7Qb/8/Dae87vzGBVb7lCQP5tolt1nGTU29JCNTI30rpAzqDO39jhnyTXgWa/NUtIg6Q8rn1RNGgOZ75SJOIgP13eGonBL8Ms8Lqk7XLuTBzTaj8XJkiIaE1ba3KKRR3b4fMqubmRLwRG7QmF2QsBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6054.jpnprd01.prod.outlook.com
 (2603:1096:604:d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 00:36:51 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 00:36:50 +0000
Message-ID: <87o6u2cdp9.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: renesas: sort Renesas Kconfig configs
In-Reply-To: <CAMuHMdVwN9UBso4dx9hTwrBbf84JWkvHUJqg_ZR9aVp8zk=7rQ@mail.gmail.com>
References: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
	<87cyajzdij.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVwN9UBso4dx9hTwrBbf84JWkvHUJqg_ZR9aVp8zk=7rQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 00:36:50 +0000
X-ClientProxiedBy: TYAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:404:15::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ac9980-f7a1-4a3e-739a-08ddb9c9b363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vy1XgntDrNtjztrsWT3nbjmSSezcUgaE4XF5Vh4dFZJ6M2ttVToec01w6dMV?=
 =?us-ascii?Q?pqujWbrbu156/jjK8aL9cXk4qbp7EQhhZd2NMTPX6IK8yhs6090Ifs+sBfFk?=
 =?us-ascii?Q?GwSEYvtckb62GMEoG8yHarOaI8hLS7BpDZdvlZjX98nZ29XWVbmn7LKv3HHy?=
 =?us-ascii?Q?8kMhqJwe4eLKkw1YvKDxJvFwO49U+rRjnKLTqyQUNr/dVyt3md81+0j2ctQp?=
 =?us-ascii?Q?pr6FhPlTbw6TbKyrSx2Sog3F1C4joh1DlwddBVyk0/sfr0pa/M28/GJMQydN?=
 =?us-ascii?Q?mQUwx+z5U8bGhZDiR0eM9/8VbHwvqUFdJ755SWMKqyObapQeUpu4g12GANjJ?=
 =?us-ascii?Q?gdgLVaRJwQyL7q9H/vixJc1ksNfOyyxBOSNeaCMqmJh0qs+gDQ4qrJwv+nDU?=
 =?us-ascii?Q?jmEXMQXkoRAXfInO7CgUQPrayrSejVlS36or5IfV+VcjUYdf3xWpTjrH+Hfq?=
 =?us-ascii?Q?ZY2QhBn1C7BsW3k15VZ4zuCuBlG4wkPcOL3jGD/G6vPnNYwiRNcORtMtexM6?=
 =?us-ascii?Q?2+znqFG/RtvLRUSnxRCsjfoOaO6ZlWXXiZ3+CHW/8hi+691ONWa7RHK8IIex?=
 =?us-ascii?Q?ByJ+W8mhbBqlyNe1VNxikhTTnnOR39KrDA5dbhImrR2qZ0jUzVIlD12//ohR?=
 =?us-ascii?Q?pYOaN4SwJsUkQX4q0pLVlGssAoD68sXp8WZ5zjVfiZrfeHq7WhT4p0B3ri/q?=
 =?us-ascii?Q?X36ubEJ0eMcAtZvct0v/pKHuO3rVcc9UtsJGrcoMmsvd021ydYzhPRbHyI9y?=
 =?us-ascii?Q?WswBD6gtbOOyobqjyr6qIg1LtB4NbVIGavrax9rUP3UtU/WriQ+0+kt3rRaO?=
 =?us-ascii?Q?5GYxIXdz8xg43ofm8w+WKONuhoA70RBPUuNUoIXDdjS7bAmGlaSSpMMcp3R0?=
 =?us-ascii?Q?t94sv/VemFs+NmyZvOnEweOaiMdssv+N7p2YhqBtisJgD4Wx16d7pxhaYKzx?=
 =?us-ascii?Q?4/N5Bx4+b38urCjgx8k6dXXt1WNwHBI1ICKA8+ocn46hA8Aln7XFo82Wl+YC?=
 =?us-ascii?Q?6U4j4pSunfUnSwcKIE/RCMIt1MpvCt4vD84BycjyI6ZcfauWyJ++HrMrcdJa?=
 =?us-ascii?Q?V+NWgk+58qjZtl1rdWQ9Jcz5i4D+XG86oUK86ymU/X2UjA4NocHwR07Td7y5?=
 =?us-ascii?Q?4VvhfnCn0bXCc2UozGyC28EVwm0LGCmI83NCjT9zMYNAe1TmKxh4mMZ67Iqk?=
 =?us-ascii?Q?7jrcGPNcKyBbrovCHFmmW/VXUCB9OEij97xMneVXksyrEfG/Po834NBl9Z+Q?=
 =?us-ascii?Q?elk+vH9cIdkCi9hiCzTBquoUHa53T/YsTU7vZ+rBLr4K1slJzGxaYNZ9BcxZ?=
 =?us-ascii?Q?RjtiAIZKtyO7wLfesCF62TCtF9mMUg/QV4JlZaUFhB+nGFYsFkOXvjHQgXHB?=
 =?us-ascii?Q?2Z3uZUE7TLSMboZ3e0v8VS8QNS5SqIXDnWbgTu17AKlswYPLhg+xkD9bhPWo?=
 =?us-ascii?Q?CUe5BzAcbCj7IgQ37q5ETrI2kGB/Yhy4gLdNYQqeMqKtXRUT1vQRcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhenV7V7HXsCPNWWnsyc9fj1PZ5D3svMqXnOBcTWMtAcpnZ/Tq40/joWIUtS?=
 =?us-ascii?Q?VVZaxh9rbvMNDiODuVMU2TASIq6kNBE2N4w03OPfWD6+IzKt3QCJ0+/r8mpj?=
 =?us-ascii?Q?ttrW0F7URwvYDstAa5EYJWWubEKVWE5xkoa40BomTY0gdUFn26L9aIrd577U?=
 =?us-ascii?Q?CU75QqQzzb0LA/JJrH1x/OLQ+hCwS6glbrFQ5Fj0U1ky2LJEiEEqc7fxNiqw?=
 =?us-ascii?Q?0zD4258oes5Ff+KHqtaqmCrAP1DfgJ8JofF3QtjjltLufPjO87lED3pg999b?=
 =?us-ascii?Q?bC9wdKuUsZqnRHjIgHauTAUx87l7jpxWxFdXkqu/p6k73OOMptoq4rZWKrfA?=
 =?us-ascii?Q?VmZQ+4LgkOtsHZ6E8uXiTv8eI70kT+Vg256WHlvjzQxcz75W+hT9aePE93+P?=
 =?us-ascii?Q?chsQMLkE+31jyGMCNUyg3VDwvYz08X4SCvm1e97xmVAekKn/u1Qw9tQ+J29x?=
 =?us-ascii?Q?uD4E0WcfgZ12s+cYNMAZQSy+duQDr6bcQvZmxdafN8hJstJwOv2ldvZwg98l?=
 =?us-ascii?Q?E8iyUpEa8qS3tmQ3uyw7nzZD6iyOdWadiP/MhnM22gnQjBjUFjLMtV6hYwX9?=
 =?us-ascii?Q?xgtwmqIHfwqikUclmHkmcCOyrANopot4tD/hTUtdtAG89vIf/Dw06wfVMyjy?=
 =?us-ascii?Q?CcAhrZv4V6vgVOH5apFCFc4P86HRCg5gPfKtvM/D62wV6+lQRDuXGEzklaso?=
 =?us-ascii?Q?LLZRL/frN+1VZxhPwnDL/fPaXY3bWWaYNa/rn2j2uX5AJzH2cEDWDyxPFgqt?=
 =?us-ascii?Q?VZYu8IlbQennfV0zj5ehNBaObk3WYAvQbUXnqqTlVkWn/bMgO+Mov7Opx4Z/?=
 =?us-ascii?Q?kIJMYyBpHzJvyCNZ6mW76/AX2CD6DRbSd+pELfWEDQs3CpkJzEbet8JVYNAV?=
 =?us-ascii?Q?FZBTEumuWejEcaRuWuEzwBJF7NAq7EWPsmQyjzCN9IZXJD78L2XXa/fy7VsQ?=
 =?us-ascii?Q?636sKjeifz8O03XEKOTiqRT5gFat0OvFCstcGaGJZEKv+TW4l/3UXE0qn8lP?=
 =?us-ascii?Q?+aepdn3YPWL3eQsyZPmXnvJxrj9vnne3fTWKehFMEwyt6NDLuYJ04GgZ8r55?=
 =?us-ascii?Q?ICaMTK9ybU9vp0lIhBgAPu+r0MgkAUMCfnxB+dA+gWhxuTdJqyziLXQ3Il93?=
 =?us-ascii?Q?/oh0NOg5PEck1bwn8tm2h6ATh/pW4M43HnEHI24wNYSuStjtPiHy90nouNDe?=
 =?us-ascii?Q?kDI3aNPD17ogMqJEOy3vtjwQ3+BvXodKONkJ8ZkNKtT8KTC6TlKztHfovP3i?=
 =?us-ascii?Q?rjLLtk7aTsPaSf1hkRaifzoN9kYooD6cbKfGvbL989AW4doZWbd9SGngj9G0?=
 =?us-ascii?Q?zX3G4GWtFWLe3CjmdK0u1fFBXScJJeJtGhCelf5IOaE+MCGs40lpemN2edH2?=
 =?us-ascii?Q?zXLi0Z3BeTDY/VjoBadcwm9x88pIhkeyElnM27caJrvc0pkEMg90NA8fYcJt?=
 =?us-ascii?Q?qVBIoCTbYJqCxcMDkjEawBPWc55sNJy90VnkevKE5VRdwfLQXHaNk0ykLqxX?=
 =?us-ascii?Q?/nVPF/7xwxvuDFVctZ1y7NfM8KQHEIyagFKe0Ez+hg7T47LSG5Lj3uMJs6Wg?=
 =?us-ascii?Q?7nNnZlCq8DEQ98Qw/Jvv9I1cNsRINy3qiyQxKgPGtViEeFEsKDjQSh5GShbl?=
 =?us-ascii?Q?Ym83z0D89/pymsK7W17+Zls=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ac9980-f7a1-4a3e-739a-08ddb9c9b363
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 00:36:50.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvCfmAjQPWskdg6OX2MWO6kcmFNHK6d/KKVs5Rmz+OYTKjjeb2ce5wYSp0QjzwYqKiDl8jPk+REDHQqO1uzDiKk7EJXOLj3F6tyymDhdhu7C26VQGVx+BUja/cN2yQwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6054


Hi Geert

> > > > +# SoC Type
> > >
> > > "# Family"?
> > (snip)
> > > > -config SYSC_R8A779F0
> > > > -       bool "System Controller support for R-Car S4-8" if COMPILE_TEST
> > > > -       select SYSC_RCAR_GEN4
> > > > +config SYSC_R8A7791
> > > > +       bool "System Controller support for R8A7791 (R-Car M2-W/N)" if COMPILE_TEST
> > >
> > > "R8A7791/R8A7793"?
> > (snip)
> > > The rest LGTM, so
> >
> > Should I post v2 patch ? Or can you adjust/fixup when you applying ?
> 
> That is up to the PM Domain maintainer (Ulf).

Ah, OK.
So, I will post v2 patch.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

