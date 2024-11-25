Return-Path: <linux-pm+bounces-18091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B869D88FD
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F541613A6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A87194AD1;
	Mon, 25 Nov 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hzsirqMq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55157171CD;
	Mon, 25 Nov 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547846; cv=fail; b=poKXsqX0qhEJVsoQ0O4JETJV9aPxG/JXSyDN4d2Kg2PyrcHsbdSjAdh3WcnHcWxjNkK0ws1+7yiMU9qnxsbIkdgTSKFsTU/nmCosMzNiasln4DNz1INbF13ic1KHQukkgXhIA5Zw444WFLp1VcDMZ0Si2YB/fdPaNRoro1FU7xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547846; c=relaxed/simple;
	bh=lVcO3wLi3wdCDl2GOCC7zy2REvZndkwuh1qhWq9oen0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aeDUsAoPspNZKHQPv/sTelvMLq7u1C0ArGR5vwU7hgOW9qnvr/lDCI+Li/D4eTfK2PCdBgRBmwvm1WV9N3/ZFp05vBWQFGNGh3kck6VQM/q6havJcWjY+rbn1mt29O6yWdWnIksyT7CZn5nlP9uUDy99qyvoS2ZLeoVydJZDqHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hzsirqMq; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdkGu9E1kxuh2g2jMUDhgX2NOqvoatulkXFDF6aawcQwlgh+NHC20mEqkIDfD5CUorRl9dxCt58vMVmwdxVUhbsXnIoq+hYUreZMWwVFL2ZzUMNHPHRmVqhnHXr/DcgFWVLpJufDGh2TfY7rU6I3il/738QIhIbuChBQArV23kYnws+et+GWxw6k/OCr232cCu2uv+quxPTi/X1b368U7y1qPBPsw1xHhcJjUAEQJA5zTLlkqRHb9vQFOYxrCdqEK6oIh1VYtbpUB/Zv5K/I9j7m6KePetmzb7R3qez+MLWlWVFDhIote6Cy7/3JARFaZnp6HISkxTNGWxTzHEA1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVcO3wLi3wdCDl2GOCC7zy2REvZndkwuh1qhWq9oen0=;
 b=g3axgBNXwfSYJYcN/uxknPP4Pb8fz4sGL0WdczOTzSiwS5JewBiEn/3Lytvxe4d43AlcAV717KuK/VvpqMZScGPIGoB2uWSmH0Vp9buA/ZUsayBGjlheO8g9jKKQCrcAq7BIJ/gAYYTErleKa1ngIpnlZOqjjAHE4OxNj4CO5PvDOOnMeF6lwSkI6nRxno990MbL4XycGMalREo287LOdXtRxFkW4b19mEKzhFzDOCdNkMfEmAtaQIfe35FJbxBDM5jCsFQxudoXq/yhgkUxiBeP7pb189NRYajKHaBEQSEWxnIIUUjJZyTYWh+r74tCtAIUIMwvRTE9OG2bym0jKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVcO3wLi3wdCDl2GOCC7zy2REvZndkwuh1qhWq9oen0=;
 b=hzsirqMq6mKRQ3Ugona3ixtUcia17vHtrBDoi7H46BX+4Icj27ZLnoS/s2QAwdy2Tut2IlIYSNWt0hOfIdHvBFW8wrOKCYipF3vHE83pifqGflA9vMnnRI/23AEaEnIF89U6reNY3t5PRWvyvIBJ23U/klEJSGnUe5ERf+qSdjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 15:17:22 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Mon, 25 Nov 2024
 15:17:22 +0000
Date: Mon, 25 Nov 2024 20:47:13 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de
Subject: Re: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate
 on AMD platforms
Message-ID: <Z0SU+cv9UyXfQdS1@BLRRASHENOY1.amd.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
 <20241125135454.GE38837@noisy.programming.kicks-ass.net>
 <55157183-b756-454c-89b7-aba05a293b3f@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55157183-b756-454c-89b7-aba05a293b3f@linux.intel.com>
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4087aa3c-256d-4442-bd4a-08dd0d6442b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jDjZ5s8RGtw8a5/chURz//N3+rdNyh5MfJbPmVES16FhTsqM8ZpXUWJtNdi3?=
 =?us-ascii?Q?cubXj4SYOaS0YTpzSWW+cCCZWzdwUsvzyCY3cESKtmnOUS9YEKsbQDWEaX+b?=
 =?us-ascii?Q?MNKh+ZEV0Jun+krL32EJE10XPiGy7lH8lN27yvgbWd4+5l6deyTTjM+O539A?=
 =?us-ascii?Q?FUisIyxopfVzkWh2iR1fbV80AUSbz0gzHL/sJveTjVUuRxpuYTcsBjM4v4RQ?=
 =?us-ascii?Q?aLa60ncqMVC++d+gtsJE103qQIxEd8W9KOZhDDRiSy72W3vLu6lnYQrW7kH5?=
 =?us-ascii?Q?q2e+lvWuCZUYhBtlZdiMKbAXNKbciniXl3RXvzmGoxlP4BfUbmC9JJCaaDQ4?=
 =?us-ascii?Q?g8OmMCVx+ppbtlovAVu/B6zk8sGEZv2l4tbujTsByOfGlZCYv0yTxxADUzSY?=
 =?us-ascii?Q?tqF3LPwOqZBhzd2HgMzJSqG/nMhCN5mc77Xw+oP70A17HNgfzKAyy3ExtxXX?=
 =?us-ascii?Q?YQapof4TY7r6+5gQbOJetEs3ytGg9jWiZUskvtUljEXZ10Mk9JyZv89PqUxv?=
 =?us-ascii?Q?tLEEMxUtSZ/UKOMs3jtF3OJAaHFGNczSvladblOlgBT5MtIaA2QLjNwjxkJ2?=
 =?us-ascii?Q?7NU7nTOlAEM56KP9T3DKE7C/2TpFbuAjMvXBbks+q54CAeSoHNQRO/e7Q9oB?=
 =?us-ascii?Q?uvIP0YUtP14xSv3Vu8n2DyaEz9ZoN2YbdJbCvruaWsMxiN7gtA8FYCcGB2me?=
 =?us-ascii?Q?K/7RJLiBZhDmo/7ugoOx+8KgyqqMONPatgFlExeddfmEWGpPEtgKh1HStt2P?=
 =?us-ascii?Q?/HZKMeFfTHwqwd1QNgFJtMc7w/W1CONZn65jrlVwnncA2VSE0poAtprd/91l?=
 =?us-ascii?Q?q9V8ulp8W9waQwMoJdSZguiYyhDI8soKCB342mIcDC1+z+p2TO18pGf/GaFL?=
 =?us-ascii?Q?xIHVmYQRUHDukTNV0qhnddbY/rah8gwCMsXk3eOfBG5bOA8Ckua/r8VsgcHp?=
 =?us-ascii?Q?1savz2qI8PCW9txE0eQm65pOLC9UmL1B8UZRcQ62BFbjmgc2K2w0Nq1FNmUU?=
 =?us-ascii?Q?mA4TExnAvrodASJ6qoMMYYaoPjbCq9aknOhk4q7kfvIUeUGmdBkOzwWB2fo2?=
 =?us-ascii?Q?1RRJTswyh2IlZE3VpyeBJ3zCdrn4ueF+HLL22HA7rLh3mTZJEII2Vu1OcVZE?=
 =?us-ascii?Q?akX5Q6f6ZRBhf4jjXNPZPAiwe1HHsh34vLaawODxVnSnEcIPEK9Ddg3Yf/p2?=
 =?us-ascii?Q?NhbLw8WA7R8Dq8RApk0wMLQnV63wMOcJbM8w5toK2eVxRUGelThF0iHtuLF1?=
 =?us-ascii?Q?6sk49UaauiJJIo0LqinLjnLORz2B6YVJRuloD5wdzeSSjbNS0LKGgcx2k4Wa?=
 =?us-ascii?Q?n6lqHTUkPQcZlArbYza+x4U4fq2Dmdsl1A+Vlw72SkZU9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvbVaCP08XQhJ/1ss344W1/UOWzWw0k0fl4ZYDIRAifjNebcNhbPn5GazWde?=
 =?us-ascii?Q?aLfORioculEJEcDdgiY1miu7ZxxbWlM+4XEJwtexLIiE1ivIFN+e3gNiB7uo?=
 =?us-ascii?Q?LuiVe+O2NXHIcXwrFnKaQhBB+4ebeEKiel4ythyBeFAEXnF4BLVjlaH3Ank1?=
 =?us-ascii?Q?DRfUACFZs37hM34mstiaEtPnyzrsorWqdt3GqY2nByu1qUi/iSCEIwGFXx2+?=
 =?us-ascii?Q?zKeYnRV4hN4uE/t6p4N7n9wVR0SJZ7hv13JRaZ1PUdCT2nHU5mxGXb+AZCpm?=
 =?us-ascii?Q?UCagpK6zWhzSdWUsP5fz6mymVkLf58nGmCdoaRrebRiepxc64hbZQbia/94R?=
 =?us-ascii?Q?M54Fy8xnwMAAOtfWHIMRkfIMaP84I27nfiv5mURDIhvuoXtJ5QP+iUW48Ozw?=
 =?us-ascii?Q?Iyr7YEcWsRdaWgfxLPEXBrV/P80Ttzf59Cd3HIGHRUEJ0UurLJmDPAYfic9r?=
 =?us-ascii?Q?q4ypsB1wqhpEYiNWnuKeVbCCKeaxX+KMuVNIxOIYCxDnydm+VFcbWYF3B/oR?=
 =?us-ascii?Q?C8MSNla3hjExjdFRIMcZ7U5izBMaOImcBRCuyFkUlCKREg1QjKzQnQciZLXe?=
 =?us-ascii?Q?8mNYIwiAdiYzOJw3ZQVNDLIW1oW57/DdIwiI+ZefiBeaowbpGQhQ/ED9E39V?=
 =?us-ascii?Q?9+rwJ7X2J/iVJMF6plSDl9sGBck9aZPby0VXzXY//6wCwewhh6Cv0ivgeQgl?=
 =?us-ascii?Q?i+ZQLdP/v2ffTYqnHh+zifHFnDzNh9a7fJsizSXQRWSJyQdg0a4YDAH7lmVC?=
 =?us-ascii?Q?F0SIEv/uNuNCfi8jlgs9ZQp1ynIcobiObpwMo+8EAL4mhzbaj+GXtmWPYqA7?=
 =?us-ascii?Q?/hyRMBmjtlr0d4GJDvrMFanSzW0Tx1Cqn2yhneIgwfg+dNTSrkuAyjkaIZ0Q?=
 =?us-ascii?Q?tM1gN/t9IKK2k0dF+qVC/D/pLAbM53gB0n1ov3GnzneAAPGuBcBjXVjIl25s?=
 =?us-ascii?Q?BVgqpswZeu+y1NxrkX6yQD3o74R+pM6ASxNp453r4ddnhIeFs9rEKxeY1muO?=
 =?us-ascii?Q?SD0TfDsjzh4kJqjdYtYJTO4ckucikN3Px/ISeJJrI+1H0nMxFDYKZITKx408?=
 =?us-ascii?Q?2vgiHqzepxlHAPRrcCu9VUq/FOVsKyzsdut7+MtH/oeCTWUblYNuqvN4h1Y4?=
 =?us-ascii?Q?mDR7xivafd7kZxYPcDrciqrw6lwoKaxc7zJ0jteEqm8F/t0/d+TmA+h1pMXL?=
 =?us-ascii?Q?PvDG6IdpoLN19+Jq+zh3PvXmZux6gdZOdWmNEeAClQnXRWs6EaYjnNCYkuS8?=
 =?us-ascii?Q?kKN67qKAUnQLPGi/SomwX1szTt8dv9WnxcGrgb5pFP34RluOAhVtbYKwPqdO?=
 =?us-ascii?Q?7dwPy/zHU5iXDScIQ5d9v658GL0DCd/AZIDKwv17zM2gx7WNhIWfTpFvaF57?=
 =?us-ascii?Q?iQeybGAfc+Nahd3khUjnQZqgiMk6V35SKWR2QPcBHdb6SNnzqFoPU+Fdt5WT?=
 =?us-ascii?Q?elw9oCSoV9GDjfufSqbAuh/NUmrxmreFYboijAVHjP3r8N/ZmaJGjypj/2Iz?=
 =?us-ascii?Q?OPDHyVRYYeqBr9AFNwtOepu1WxPrr2iQqHN3rXwrbK6+Neye15tl0X8lnJmH?=
 =?us-ascii?Q?3oev4KZfoaRLb73we6tiF7rPLtnmCgHIh4/ezjPA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087aa3c-256d-4442-bd4a-08dd0d6442b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:17:22.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHXyQgkN9kZK75MDKvQnT+qS5wTr7gAasQuuqQppxAejqId1HlAboLkuqcu82TJMmKIE+l20asRJayS0G8vXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

On Mon, Nov 25, 2024 at 03:56:25PM +0100, Patryk Wlazlyn wrote:
> > So I don't like this. Less exceptions is better.
> >
> > This *SHOULD* never trigger on AMD anyway, because they recommend IO
> > port C[23]. But if their partner BIOS engineer does a wobbly and they
> > end up in MWAIT anyway, it *should* all work regardless.
> Agreed.
> I thought relaying on BIOS to not put FFH states there was a concern.
> I believe Gautham confirmed that AMD would be fine executing that,
> it's just that they prefer ioidle (or hlt?).

Yes, HLT or IOPORT based idle states for CPU Offline are
preferrable. But FFH based idle states work just fine.

--
Thanks and Regards
gautham.

