Return-Path: <linux-pm+bounces-32188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE8B2154E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B19C18833A8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB92D8390;
	Mon, 11 Aug 2025 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b3L72VZS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b3L72VZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A2149C51;
	Mon, 11 Aug 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940273; cv=fail; b=nMG175oxPEiV353yBmoiZ1RsLfCGv5WbEu87QtfBO3XMXHxbfU3pkdkXaoZLt045FTh6nybFlbhbFEmP6/GmBoH5Z48ZXnX43yyuJguBLSADXZsItlZzxUQ5kN8XrkYEJx0isXm5oDLfH/zIgtOdUblNFtmwlHWMEosq5R1X9mQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940273; c=relaxed/simple;
	bh=1DH2olFzGbX34QvPOcUvgDiPO4lK++SdyIuZQh3SY+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmKP6KFXAjID04Rz5OVQRuevWEL4sJCpdQr1cFSFg5D/4MIzhXMK+j97ZGtYpEISZDNxoOKBsGed7Q3f0y7+YiONbHtrnbeumy29P7U4Enulw2hL9bDd/tub61thss1+jgf+Y2ATdMdhQ2y74n7p60XJEujKIsWU/0IpuVS14Ek=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b3L72VZS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b3L72VZS; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=he8OqD7X4WCxsd162OttvE5CFyihN9IF2g7nQI1In5CqHxkgJ03PlisR8e69dKFYXWA0cEt3TBoe8mfQAVBjsqSoie5+PwpLAyINMd8DjwhDymWUUicN5TFJxOOx0ZIo1xOEAITyilFNiIBkXtE6N/2joQcVid1U1Kk83L91PMJzrFm/tizuQx/OVqmXxXX0wg6+NU75rpXGt5FJtep7i6ajzKfWspoYnOaq0gWJyymGVoFi0UEpOQfAPk4jLbCJR2A/8Nm3gnnrmj5PNkmFuDjpidu+hxvMGH3p4+o14s+s0oqsLMfBrsV3a9yjWRfY448nxpqNgXnIfRpBQ+y5Jw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR4yeeTr7nabnpZW0VWU3W9GLqusTT2COidqLR6yjyY=;
 b=CQQO30l77Em6eJaU+z2NuVKCeCf+mxHRqiXKyj1GsISbhVdtkoy2tWeEbKKZhQS/LzmAdOyeM10CQ8+W5A225KYosNvZgiJniiEZOZQjzSCoqf4ka84i30lIfFi1s5m4mXKf84+0GmbI5hFdxM5VnTEFBvoumVraVhT/iqgroqlF3hZYyeD/8p8zvklNfMlnD8KDAfO6CigSijzMxvljy1Rajy/VJDiqtD9/9k8isNOHgzPyUTs/SuxsXPP9tB9p01ii0h1c5bTwfRbFfe15rLWZcaLU7lX3kmldfdz//tRAX7RFwppylUOcyXRuYTK7pfAKyzjgzLCt4/LmO2TR5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR4yeeTr7nabnpZW0VWU3W9GLqusTT2COidqLR6yjyY=;
 b=b3L72VZSFgbseH0ShBNJazkf76mNdlGNuBYMupbLWMgVzLHPMjP5yhOL89x4hHZVBqwp35M+uzZjj8DIl97pDz7KaKv5+876+DiRvv8WhacZG8jgt7mdUJRHfqlGeRLePRCCmMNqb/coypNCTzXEF8tua7QiQ3M6yuJXjyZcgs0=
Received: from AS4P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::14)
 by DU0PR08MB8978.eurprd08.prod.outlook.com (2603:10a6:10:466::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 11 Aug
 2025 19:24:25 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::d) by AS4P195CA0023.outlook.office365.com
 (2603:10a6:20b:5d6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Mon, 11 Aug 2025 19:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raosPda8D16c+Hk17YgGdsfuN1Hl/CFp8b3aJ10e1t2UubCaXH7xOu8rTxwnr4Njpzc78Dy3p6hIRH2QQwFJczWO4/ydXhk3xbL5IEvtjbDyNHSVbrOfkGiEQpT0JxM6c41YE5FnYr0QLNZJkFrInIUFdcr39ZP4rpIDcuQEg369ApBBzycCj8QRx9gp8jYup/kRGBa5S5JSsFaLUn9iVvhyL6xIdYHuYt2a6zD8Owttmf2R4IZhdgpqWkyAKC/PiXbDrZfFQs5i016p3+8u+8wPl8TkhlKC6WlbM8HLk9/I3E8cMJJSq/dj20tu+3jAcBFYC98l958k3dN+DPjxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR4yeeTr7nabnpZW0VWU3W9GLqusTT2COidqLR6yjyY=;
 b=Vra8GK+PxVrKOvXlnvKx4f76EUJWcK3NFSiSe5p0D3b16f7OS5gkEjnfmRnWZTQojOOcOjSfdgZIWSC6qHGnMZ7kzSH8HJQaoCXg2hgAm96kbqMbVri1IRoxi8iiVKdKqKePI7rYJvpaguPotiImaEs52YTCv5ttDQFmCKLSmWQlLe7SOACDYk0F/7RSui1O116tZUguPVpwgJJMcLjPulfa61NzK5AEjGE0AkM1R2VB2ta799zzSFufVDZYegP5sfjndZOCyFB3e6vxNFs0nh4CC6ZWJ0WV6n3OTS2Jr3sfj9YYg8hlheb9PdiSctcr5fImYasYi3Fy6/k0enpOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR4yeeTr7nabnpZW0VWU3W9GLqusTT2COidqLR6yjyY=;
 b=b3L72VZSFgbseH0ShBNJazkf76mNdlGNuBYMupbLWMgVzLHPMjP5yhOL89x4hHZVBqwp35M+uzZjj8DIl97pDz7KaKv5+876+DiRvv8WhacZG8jgt7mdUJRHfqlGeRLePRCCmMNqb/coypNCTzXEF8tua7QiQ3M6yuJXjyZcgs0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAVPR08MB9259.eurprd08.prod.outlook.com
 (2603:10a6:102:307::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Mon, 11 Aug
 2025 19:23:51 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 19:23:50 +0000
Date: Mon, 11 Aug 2025 20:23:47 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	Dave.Martin@arm.com, ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 2/6] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aJpDQ71/f9zdwXbf@e129823.arm.com>
References: <20250811163340.1561893-1-yeoreum.yun@arm.com>
 <20250811163340.1561893-3-yeoreum.yun@arm.com>
 <86pld190l2.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86pld190l2.wl-maz@kernel.org>
X-ClientProxiedBy: LO2P265CA0356.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::32) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAVPR08MB9259:EE_|AMS0EPF000001B3:EE_|DU0PR08MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: c113668b-6c3c-4bc8-01ee-08ddd90cadf0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?2T38NgN3X+M+cOpx6XB2eDuKYV+zcvOFMihs/XrR3hw/vU2u8wnN5bOE5Y24?=
 =?us-ascii?Q?8EYusHhyQreJR2eAlzcLf/CU1UbKnOrJimk8fTUhS/YcAp2R0gk67tuPASI7?=
 =?us-ascii?Q?eWygMaAepd9sULqlBJsSBn9FHioRpX56c3LdWUEfxqoqiabl77Bou1PDHqjx?=
 =?us-ascii?Q?RB27yx8v8FAAeaWXi5be+jb7Kb0r0ZWltNUUvy2LaZCubqGzKwfHFnqvbz7o?=
 =?us-ascii?Q?l4sc2cT3JD1WVm9os3056kU7K1b8ZPqm6DvIjKH3gmSHLKCG7LaV3JVmT6F2?=
 =?us-ascii?Q?i3dLGpELWhaHbkb5YUrCNEhMah3M2vdvbMpsH/FGCTK6x9c6URwhPnWqV3SJ?=
 =?us-ascii?Q?R+pXC6mYLx/FiCjnbUFHvhbTTekl/zN7qo5itEiPZNlfsiPQ1YAlK2knvLjR?=
 =?us-ascii?Q?4LPyMpxff87NNCEWdzgnbiKWugvXw/sgavIySCLMcu3U/YZBVdn5slUak7ZX?=
 =?us-ascii?Q?Oqr51n+vlirYK7z/zEzqIPcL7KoRa/+TusqtNivNXjY9BcpdTr672RedwaDd?=
 =?us-ascii?Q?ePMHV/hjuWlJd8XwqLiFIBACR8H5MowCIaOC9ICB+8nT1DmDJ/Eb4UX3wk1V?=
 =?us-ascii?Q?clIAIlZIRYplzGDicKGMChNf6dxQSvziwEIrK2Qo7cMvJBBdVJpAsMhIoDhd?=
 =?us-ascii?Q?F15NJgMMZP2LWLIezE5VSRpoIwxUqVmpyuznhTc8ZzCMxoWOjo15xxIyTlLd?=
 =?us-ascii?Q?5fItkC4Coi5CLbtUwDPN7Y7D1AOvcmgfdOZomGkQAe9sAPapgiGpmDVzsU/M?=
 =?us-ascii?Q?07ZTIC4HVSlIe0yzEhJjuWJZVFiZKEaZ7j0QCr5ZQPdeHnMsAcyUZcYD6+0O?=
 =?us-ascii?Q?74jCLeET5DSwrIJ7NbdBvpZjJtZj+94fB2ZGZm6EwjTdeGjVt0dJuDU+NXDO?=
 =?us-ascii?Q?JFkfYy7Wp5cVcNgLHOJGIiJC0JIxQtzyhHnzu4OxVPdK/yr0V1p2VRfgUNPn?=
 =?us-ascii?Q?o1peOQUfZHZjaI1cTBBRwGLKXGKFyYsb+oFFZ0+twmjkZJR0ytMoDQT19XBA?=
 =?us-ascii?Q?S56BZZ3JMV1qodOuiDA+9BI28uHAogE3ffoh8iJlIRquONab8YrU4Tt/qFG/?=
 =?us-ascii?Q?dRqfSqiuS2cb5onloDGUpEMJIhtxkw8G5Q3HvkIEHdYx5qQGa4G3MoCSHlRu?=
 =?us-ascii?Q?TIYR7mm/El6RnDyPkizci95CzDAdsuPky+M3yIMgYFGOni4zwZ64oYURQFGQ?=
 =?us-ascii?Q?wj4xHA++qzur19azsKBnOxtxIe/+WZ11oZeKDcMK5g0xaBopxvLXxaf+oVls?=
 =?us-ascii?Q?DAa4VZCSKHsOwsNXPZdLwCjkqkrIzohUOjdf4cMYgAg+e8z86tCMjJUZxCSH?=
 =?us-ascii?Q?vDugIdM+7rF/bBEbMtMfBs1QzlRCFtxUcuLlkRaL7ipeI/zuQVxYbBOQblY3?=
 =?us-ascii?Q?bfnmaQQLm25+oRu1oIx9NwOeM8k85wJmQqsQDeaMogsM/WiI6A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9259
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	795d5c30-b982-44bf-fd39-08ddd90c99d6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|35042699022|36860700013|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyGmSYBUvJz5KdThLbdb+/VvaY5D8ybhuCv2vSQBqwFCzLZXm9xC34MwjFQL?=
 =?us-ascii?Q?eiCjzOjljNgMS1eHmpYqbwQfGbZQW88qnv38woYLkhT8Y01iFYzACpzh2rvl?=
 =?us-ascii?Q?47H/z//FqIrQPOAUWaG3ySW6s7MVb2eLttdxZda18MFZqelwC4fdqf18Eqrk?=
 =?us-ascii?Q?3+vRfRksaCAPnA6z40m1RmeDDn/sZONSnt4GR8pnsNCTPty+vxb0oAGdaMVV?=
 =?us-ascii?Q?ZBtUhaJgoDvUjZfLp+SROzMVWtB3YRqrTM09EB+PxkkTmMTkXcpDGUqRn+P0?=
 =?us-ascii?Q?Eqsve1l3AH7RHvw2055RPg6qz4NO6egDAvUd/PLJ4OkpLkorg1sz7wvmajbJ?=
 =?us-ascii?Q?qm2sWdrwkFC0bkPXogAn9V0qj3NqoiCqZxvsk3qNoyBdIM40iLoTQO+GwmIn?=
 =?us-ascii?Q?jAklwQjYL+poqLtcUISc+ehIojzssHbr/+JdZFogKD4vhEHlafcdytNyTICy?=
 =?us-ascii?Q?6FpwwrascHjuWfeW9FHXzrI0odR+7FSs7e/Kbr6R6WLI/K7CWFpqCy6451xB?=
 =?us-ascii?Q?Ky3WQSsEXh1DlQ3wCOGRJ2lYFdcGzuxY7O1NEcabNBkwhIKZoN6oQLVG0DdM?=
 =?us-ascii?Q?3xjLOMlTkFycmd9sNt+cZmoBDlGAxgt29Z/L7jFNGZZ5nwLbu5etrCUkv315?=
 =?us-ascii?Q?rCKPhXJ+y9dNh6BhADbZUHGgq4/HL+9vh2GFM3l+URepM/S0/tDyem8k/Qeo?=
 =?us-ascii?Q?OyYizgrSx1HzA1snel+9hiR1jEvUlTid1qx1nb3yD+NAM6Sym0Dc4DIDl/L3?=
 =?us-ascii?Q?p5A3Tmdws2CSocmHh0MEXSh/Km8FLRfXaPHuj9c5IJc76sC4eXrRAVcd7VXX?=
 =?us-ascii?Q?D7LUfZTJtK/zCymkrTaJyr4fkX7rqYl6f0deYJYx23c3oFnhIZzT0FEtmfoC?=
 =?us-ascii?Q?Rzh6vV7UgUKiToLCsYOVjt4AopTqdFyHrZMUUb5EzAkpulpVgMgRT/Xv6YfJ?=
 =?us-ascii?Q?vmUFMassKrhvrnQLlDE6wxJOAlDLL7KJv3aO5Gih9SkOJvgEZ69+dy6482In?=
 =?us-ascii?Q?itmiYPqbXQgXl6HiXUU/GVu+evheCiqfBj7Xq2YbLruIB9ZmwrwC1uO8vONz?=
 =?us-ascii?Q?fWffM3kriF+5ldb5/dhWw4765rvXNS8wSKljw3c7zjwfGSefoijmkYTAKGhy?=
 =?us-ascii?Q?MDjrbJ7tO/eYIJkB82Dph8YT7Gv+qzk66CqwNTzBWiL7asJNtXeL5iDGrDfz?=
 =?us-ascii?Q?IIKCxGuqiQQn55LP/NqmJ83uW4nbGRurqwKdwaOFwiOoUGErFxzMM1K48r+z?=
 =?us-ascii?Q?2sMErx4sASGIq6s1mVSm+griTxLNkaOdBtiqGChY38vI89DM/ppjsoqYk7Z/?=
 =?us-ascii?Q?vcaDsGAwM6Y7QdvfDwY6e3S/8puh/CxJb0UJn9xs2/x9sBoH8a8orvOUFEWB?=
 =?us-ascii?Q?w3bY5oD7qV0/HROyVuDeFsDF3FnJQxT60gdrQTLhnLupKZRnj+GrJOQR9N5O?=
 =?us-ascii?Q?fDMJoNyxtRk6BFf7awLWkho5kRnvPB5LOQ/QcT2UU7+6laFyA3xDSU2nEHyx?=
 =?us-ascii?Q?DqgEliZl93+EFGkTXSsus/9RaXQupDOxFMW2?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(35042699022)(36860700013)(14060799003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:24:23.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c113668b-6c3c-4bc8-01ee-08ddd90cadf0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8978

Hi Marc,

> [dropping ry111@xry111.site, which bounces]
>
> On Mon, 11 Aug 2025 17:33:36 +0100,
> Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > add initialisation for SCTRL2_ELx register at boot time.
>
> Again, please expand.

Okay.


[...]
> >
> > +.macro __init_el2_sctlr2
>
> Writing this as __init_sctlr2_el2 would read vastly better (yes, I
> know most macros in this file are similarly braindead).
>
> > +	.macro init_sctlr2_elx, el, tmp
> > +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	\tmp, .Lskip_sctlr2_\@
> > +	.if	\el == 2
> > +	mov_q	\tmp, INIT_SCTLR2_EL2
> > +	msr_s	SYS_SCTLR_EL2, \tmp
> > +	.else
> > +	mov_q	\tmp, INIT_SCTLR2_EL1
> > +	.if	\el == 12
> > +	msr_s	SYS_SCTLR_EL12, \tmp
> > +	.else
> > +	msr_s	SYS_SCTLR_EL1, \tmp
> > +	.endif
>
> I don't think this is the correct place for this macro.
> asm/assembler.h seems more suitable, and already has that sort of
> things.

Thanks for letting me know the proper place.
I'll rewrite it on there.

>
> > +	.endif
> > +.Lskip_sctlr2_\@:
> > +	.endm
> >  #else
> >
> >  #include <linux/bitfield.h>
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index ca04b338cb0d..0dff7593e50b 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -276,6 +276,7 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
> >  	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
> >  	pre_disable_mmu_workaround
> >  	msr	sctlr_el1, x0
> > +	init_sctlr2_elx	1, x0
> >  	isb
> >  	mov_q	x0, INIT_PSTATE_EL1
> >  	msr	spsr_el1, x0
> > @@ -298,7 +299,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> >  	msr	sctlr_el2, x0
> >  	isb
> >  0:
> > -
> >  	init_el2_hcr	HCR_HOST_NVHE_FLAGS
> >  	init_el2_state
> >
> > @@ -315,12 +315,15 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> >
> >  	/* Set a sane SCTLR_EL1, the VHE way */
> >  	msr_s	SYS_SCTLR_EL12, x1
> > +	init_sctlr2_elx	12, x2
> >  	mov	x2, #BOOT_CPU_FLAG_E2H
> >  	b	3f
> >
> >  2:
> >  	msr	sctlr_el1, x1
> > +	init_sctlr2_elx	1, x2
> >  	mov	x2, xzr
> > +
> >  3:
> >  	mov	x0, #INIT_PSTATE_EL1
> >  	msr	spsr_el2, x0
>
> This is missing something: you should resynchronise SCTLR2_EL2 from
> SCTLR2_EL1 in __finalise_el2, rather than relying on whatever you've
> set in __init_el2_sctlr2.

Thanks. I'll add missing on enter_vhe().

--
Sincerely,
Yeoreum Yun

