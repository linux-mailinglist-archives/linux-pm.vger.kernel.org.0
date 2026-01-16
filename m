Return-Path: <linux-pm+bounces-40968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133CD2C621
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 07:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03F54300502C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19842FC037;
	Fri, 16 Jan 2026 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dkjgd2tY"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8C287503;
	Fri, 16 Jan 2026 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544021; cv=fail; b=MfxtbHOjQyM4WxOAnHwVun4Arxw9Rc+wNfT6IvMWOvyKjsq/yCB0G6tW3gXccLfC0CHvW6QzgLV1XOHAolS01pdiqcK8kJbgsil5piAU64/EgPFwBeQdkcM7GtL1Rr5Vyzr0hDYWg54dCR8vzp9/RvYjPN3ai5IiQdZ/0AYYtO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544021; c=relaxed/simple;
	bh=KNdnKsOG8tw2Xz6yxrASCTy278bUgZBClfd9+Msf1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+/Oq6qz9yb+5Cxl0r5J7+rqOdCRZF9dffsWlVm/7HRVTlVYOmGcSeBr3gEioWa7sla1SDwx7N0D0ghYYNAhu+3b7AHxcTyUXM4hPHXOHbS21UfEVU3lOOKKYvMC2gMv6ntFngGKjO3IMEiqztBzOEvjBv9S6h/tVm0HguOeh5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dkjgd2tY; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl+RG3AY6ihbC3xHgwSxygZ10eAl390M8eCSiP4Fa/Kd7h87kHV0AGEfixLikYj3XO82BNVlJQ+1+GEaardmghoVcqa6beA7Z0Vwyp8uGyf9fLoxwZKMSQK87vr2NkKFiB0ZQ2qCLY++oKzb0lW62jZ+U9dG+IsrE4kZnQU2LJSqSzJLIY3J4jsyU0DTHiLCNITl9RIY0Dlc/5BfEoyYVOz+eaGFvw2o3+BzvnDBYoJ72VEHk8sLPmOFlhnKw3cVQUe2JTcCHmkuuLmUEfT9XpSa0BEI3MUgRkjKoGuTIa87PTkj97/KcHqpSn6fcwPZrk5Fy+TuDzX2yTKRItLrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxXhjDTfvRLo5H+URkHo7JmEtIDED0gc+laGRIq3oAI=;
 b=Cn6LSrGMGiu/dFrNTAJesPHpwblDTErhpj90RCvOf5I9SA1i+gcfMUD0XLGZ2fpa7u68j52U+vcFRzb/EBRtKTSUtIVR3jrt8klx+dvrOHapHxADMAXUM4MSrA4V1A1zvw6KuBgLhYAbTU3RjoNrqrh8oHtrGHqpwUPe2hckiSxKAcXtI58GlSUlXId/B6GSOdJZiNPO8zJhqIcNURoocmxMCxInmP3qXDpA6r/K+kXze5F5LrBrEykSTc1mB9QWXD6xj+UyQ21vVjtckwMe1vmbGSitcNVsbtiW2rLttyAUfgBRwL2nZCMe8NvmqfL2xXhnH/f93Sa11ZRjQpQ18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxXhjDTfvRLo5H+URkHo7JmEtIDED0gc+laGRIq3oAI=;
 b=Dkjgd2tYKql52vUa2IZZwAEnusFKV2sSG4AuT1UcdLzbQbRsb7e1zew+qWDIUqSa5U1O5Mi4HhWPiR78uq2lq8Pj+oB8Q8BthQLntle0jUqP9PDqw8bjZvycnQWv030LUByG3k0om0pJNzdrGB50EBjw5a/67kzQxmofKIu/7UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Fri, 16 Jan 2026 06:13:37 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 06:13:37 +0000
Date: Fri, 16 Jan 2026 11:43:28 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Juan Martinez <juan.martinez@amd.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, perry.yuan@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kaushik Reddy S <kaushik.reddys@amd.com>,
	Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix MinPerf MSR value for
 performance policy
Message-ID: <aWnXCDYEzFlyijWv@BLRRASHENOY1.amd.com>
References: <20260107211919.38010-1-juan.martinez@amd.com>
 <25a4653c-4d95-44c7-a957-c3ac9da214ad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a4653c-4d95-44c7-a957-c3ac9da214ad@amd.com>
X-ClientProxiedBy: PN2PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: faee37b5-4c5e-46a9-b44d-08de54c6626d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7XcQp1STHicEppUbMci6dco+WLYegrMJ9C28+B2s/y/e23AS3Yv1YBrPi0Y?=
 =?us-ascii?Q?I201aEejhcUL2xnKfSfdGqPtTwWEZK4gc/+0HqWAa9whBnP31ckGX2lILCWL?=
 =?us-ascii?Q?XkM/31r034WX++SqLQp4mrok+I+CpsP+kwH5KNo1KQ6pKxdT+hQJIMV4OuYq?=
 =?us-ascii?Q?pgBDb3dtKvpFvPEjSVqW6OCfpJ5UB6MkDj72zl6LPfjs2ZCzRQlaHGpfKAmR?=
 =?us-ascii?Q?Cf6YPeO1Oh6F6ihcQxEeXfGh59EHO1yCD3KhViOPpKYm6iGNqsUSHxqb0fi7?=
 =?us-ascii?Q?gopu4DcldtWHnonqgE58KTG4kIbXuSmbnBBD2VwyIySqtHiP3cxz7vT3rdNq?=
 =?us-ascii?Q?YKfH2xHD0suq62ZibumHmDXMOBLDWA2x4t0YBp2xBGemO1HNjSJdJhx+8LzM?=
 =?us-ascii?Q?pPmzavWVfp57YkoH2+pKoRA94K1X7geRFygYGcMV76f8sY8QABgDwALB2y+/?=
 =?us-ascii?Q?BK51q4iPx6Vb2vBiQHOY6IUdoknb90VGFO9VXTvUFE8/CIcYrRx/fzXJfrYv?=
 =?us-ascii?Q?anrQJvs9Cz47gs/y/Sqb5CutGxqhhclzZvM/6/J+ac78dnLckIBkrwFbDG95?=
 =?us-ascii?Q?FfM3lC4y23B66XbEl/eFk496F/6EvzbghFVcLUBvWUTyDkNxVOBAid86klGT?=
 =?us-ascii?Q?OvcTfMLNJNojlJovgrpHmnB5nRzzZX3x+OQzQdh8hdvo+XM+BXb5Wm6WHXo8?=
 =?us-ascii?Q?QwCm+GkyW9h3hoRAkyr+QUUqeKqCEULc9DH5Q/rEky06e2cnyKZSIHECB9jR?=
 =?us-ascii?Q?y1oy98q/50LI8HdA1nxFKlI+GtUDg62vNiv12y2uSKCSvtHojszNPFOOeOGQ?=
 =?us-ascii?Q?PwcGia+cVP0BMKCGpYtVfF7OOjNhEHBhaoGMmFSy9Q0F3vKNQhTIJBSoEwfN?=
 =?us-ascii?Q?ktmPqJQM+NetAj/Lu4cHICLbl0m9YwpsmLwlzU3RMvnxY0S5Uc500qMtY7em?=
 =?us-ascii?Q?sGx+E9u6mrwjKTP/mcYW8K+/+vkc9cz4eNytXIwy4uARem92DziQm7W+FGHp?=
 =?us-ascii?Q?XfTfRywcc4naP3BX8yRFWxC3Px4cgN/3wc4rH8pMUF4kxpG/ovmhxz4YgkI6?=
 =?us-ascii?Q?Rdx7cwLhk1WTa1oEshTw+DJU1voJqAZj2CbNuAKMVnEdZFCyfVij39dwoklr?=
 =?us-ascii?Q?MVEVKOlxw/NNFxWoYETV4hck6lonAGsyQ1U3wUaaYwTtPpZHfME38qLDVaAR?=
 =?us-ascii?Q?fsQe5hAjO1+AOse6Qw+akEkroitsLsKk09zd98FF8qV5ihZcSS5fM+g0Rkyh?=
 =?us-ascii?Q?KaSj7Q2uetXNpfX5dLWI0/5TqMBw9Zm4+yaO6OXuxZ7Rlkzf0A5IpJ62xXZs?=
 =?us-ascii?Q?3MqAe21Rik8q740aTtTfFA/cD3BOo+4Ia2Y1mOi+05PUFeo43KJTD+zrX6tf?=
 =?us-ascii?Q?954O27xdIUneMKiQNMROyWoaqaxdt91zIjQD2VQMoOoVLtU7j7hixfarYz4S?=
 =?us-ascii?Q?ifbsMwBT/kR0L56lEtqyfgW6eEmqfj7Bbi2a+tKlQKxvO39K2q02bjqSSwGr?=
 =?us-ascii?Q?HDce4CUzZdHJCwRKmxWAJPMfVFxncmMuPZ8zQoHlYfJxs247G7kQv10Iahh3?=
 =?us-ascii?Q?hrHXxdcYZ18PGGsJtn5wJL0XtZR6+RekCM9hioDE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpm7gqXqs2xDv9Cchf5IdX15PSCX2n2z38nBym6lYK51M/YcM/lyIk7MT6Tx?=
 =?us-ascii?Q?ZLlw95E1zXQAdVpNahw+8uJIfC1W1BinfZ7vFX0mUtfp6y5rvn4UQ8mFkgd5?=
 =?us-ascii?Q?V3RswB7f7TtXDFuGYZvpWQ734mpMBieoGq/59mD1YDqctFgqaeDYmK/cCc4X?=
 =?us-ascii?Q?8QrOdAjCaE41ROSlCzcsR4Jx7Y4MwkqSsey+r1xDhzufQOb08MdvIKVkxzF1?=
 =?us-ascii?Q?r8TTF/or/YI0xKbE++SKWx9HSBz28tJeaFzsq69IQIdRFTuE4krDVuTl5NjK?=
 =?us-ascii?Q?eMajzVvbIwdcPkql40Z+JIG29thtBHgl3OxwqTEzn2Cqz4hALfB9IE7pVvzv?=
 =?us-ascii?Q?wjnA+Gucvonc+nCsbU/aUe8f4b3PMz2aCAGkWSfJ0zEaWMdDRk/qabMyQEtT?=
 =?us-ascii?Q?Fh34VyRwu8LRAluMiF0I+d504zlGKaAXywbzdTyOo2kOxA6SNOgeEo2KlTvB?=
 =?us-ascii?Q?HkBrleP1vfcjjgNxVXjeZDRiU0kueLomy7mUfTMDTK/tOPTnaNmslaT1cPhm?=
 =?us-ascii?Q?OBGBiT4q3zW7xE7b5bZs8C0zVqwXRaMQ0vWsf+gtGYU2P1+n0Qpm3A+U/WWG?=
 =?us-ascii?Q?gPNpV1wb1ES9h3M7MyDRONHbeAKO3DqBcWwmrSNLwh2FZUiDhcqcmu/oIks5?=
 =?us-ascii?Q?5XXWmqSmXaO3F6ONw12JLJZKR7Ll+gDwK5+2mqRteIWfsykntkGe/El/CZjc?=
 =?us-ascii?Q?nMHY5GVp6xLR3ZVW8p5lrX9OjHOtt1k2lxKF38dP2inJ5lNdvFjFvOtLLWM3?=
 =?us-ascii?Q?h2eEk6aue886ZrBTDvI5rZOiU0fFaa3BpAvqMZ6D3dwz02RqjRz9HxOl9L70?=
 =?us-ascii?Q?QplFgfqxChgx5cmSbHQhh9Rr125ZDxL0XkVfjnPJbDpeWmopbB0dnkHYLNNS?=
 =?us-ascii?Q?1vYAjIx6mi3kWC/stsdovZp8MYqTXd3dHYbVOAnzyutPngaPeXaGhxgqhLZc?=
 =?us-ascii?Q?olj6q2grVTBSIElCynA65UUnwVc5McMeql162XNoblzZEMxwqRBPBV6bcQtU?=
 =?us-ascii?Q?J/I+6dg3LCsEyW10D9+tK7vnElwjVGSWroIBxxdRw+Pe8VbvXnrYBOl8ooMD?=
 =?us-ascii?Q?VNbUwm2DGtMXbQ1g0Ln0D7Ltidtw0EY4EkpwqpeJ7n6P3qM/Y9n5juMeiVVN?=
 =?us-ascii?Q?GbeA2ox6+XF15xYjC2O7eZHb7CPZP1pUJjWi0WIBJm/U6Ud08bPO+FibQVON?=
 =?us-ascii?Q?ctaFFXPiqvaJcFBvAhGxl00FnR+3doLFRWuKzT9JtKmIDPC921T0UGW+JSdx?=
 =?us-ascii?Q?NsD1lKBsQtwVGCRJFtlUGqgP+VjZgf8ziqwCxBShTFUUCC5wVkAUCnjGU3uq?=
 =?us-ascii?Q?9FeBxpHsAmLbKiAadiLCzT3i4SmME9xtA3a0BprAB37Eg0NgAcAXwA3EbPAw?=
 =?us-ascii?Q?yDItWbS/NgFUMzBLp3Npzf4yW/iHJu3rMK5ncFgPQ+k2YQRL5ustxUnu6tQW?=
 =?us-ascii?Q?dd3BVruGmm4PJndqjRc7ZMeg19hPUN8vYi1oY3Lzq6ifJT19IlMNL5q1vBVb?=
 =?us-ascii?Q?76l4s9nMVYCTInHGUMVQtKchYmCzpdvPwlEFLUqz8Q+Clu3sZ7qz9p5f/sfV?=
 =?us-ascii?Q?ZiQf+uCI9EEaHaoXFfG9QmA4bfjJABzRK4cH4q5rr1RWht9TzXcTRIvWBzX8?=
 =?us-ascii?Q?4eN0sM/5D80VY1pbqkKy8ccFkTdcNrL/FBkGunJED1IdPR/+sibE6qwHom+M?=
 =?us-ascii?Q?e9kINK0+ZMcqPmIxYlYFsEo54DAHqmM09BpE6Wch8+i5wYL8tzUB3JGm0iqK?=
 =?us-ascii?Q?OJHcuLo6rQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faee37b5-4c5e-46a9-b44d-08de54c6626d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:13:36.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt9/asUJD+t3ep+b2MjYEcUj/Gb8GYGC8ftL/AEQzUYVHoTBFI9atLaDJwqeM2QgyNiMCxUqIftDJF2v9P+rKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

Hello Juan, Mario,

On Wed, Jan 07, 2026 at 03:24:31PM -0600, Mario Limonciello wrote:
> On 1/7/26 3:19 PM, Juan Martinez wrote:
> > When the CPU frequency policy is set to CPUFREQ_POLICY_PERFORMANCE
> > (which occurs when EPP hint is set to "performance"), the driver
> > incorrectly sets the MinPerf field in CPPC request MSR to nominal_perf
> > instead of lowest_nonlinear_perf.
> > 
> > According to the AMD architectural programmer's manual volume 2 [1],
> > in section "17.6.4.1 CPPC_CAPABILITY_1", lowest_nonlinear_perf represents
> > the most energy efficient performance level (in terms of performance per
> > watt). The MinPerf field should be set to this value even in performance
> > mode to maintain proper power/performance characteristics.
> > 
> > This fixes a regression introduced by commit 0c411b39e4f4c ("amd-pstate: Set
> > min_perf to nominal_perf for active mode performance gov"), which correctly
> > identified that highest_perf was too high but chose nominal_perf as an
> > intermediate value instead of lowest_nonlinear_perf.

> > 
> > The fix changes amd_pstate_update_min_max_limit() to use lowest_nonlinear_perf
> > instead of nominal_perf when the policy is CPUFREQ_POLICY_PERFORMANCE.
> > 
> > [1] https://docs.amd.com/v/u/en-US/24593_3.43
> >      AMD64 Architecture Programmer's Manual Volume 2: System Programming
> >      Section 17.6.4.1 CPPC_CAPABILITY_1
> >      (Referenced in commit 5d9a354cf839a)
> > 
> > Fixes: 0c411b39e4f4c ("amd-pstate: Set min_perf to nominal_perf for active mode performance gov")
> > Tested-by: Kaushik Reddy S <kaushik.reddys@amd.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Juan Martinez <juan.martinez@amd.com>
> 
> I think this change is reasonable, but I'd like to get Gautham's comments as
> the original author of 0c411b39e4f4c.

The active mode performance governor was intended to run the cores at
the highest possible frequency at all times.  Originally the min_perf
was set to max_perf, but we observed frequency throttling in TDP
constrained environments as mentioned in commit 0c411b39e4f4c
("amd-pstate: Set min_perf to nominal_perf for active mode performance
gov"), and as a result min_perf was lowered to nominal_perf so that
the frequency doesn't drop below the nominal_perf as long as the
power/thermal constraints allow it.

This is the behaviour that is desired by customers. So unless you are
observing a performance regression when the min_perf is set to
nominal_perf, I would like to retain this behaviour.

When the governor is switched to "powersave", the min_perf is lowered
to "lowest_nonlinear_perf" by default to match the description in
section 17.6.4.1 CPPC_CAPABILITY_1 of the APM volume 2.

That said, I think we should document this in the code as to why the
min_perf is being set to nominal_perf when
cpudata->policy == CPUFREQ_POLICY_PERFORMANCE.

Juan, do you want to give it a try ?

-- 
Thanks and Regards
gautham.

