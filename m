Return-Path: <linux-pm+bounces-33707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6CB41E75
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E913A6B69
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98533991;
	Wed,  3 Sep 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DEua+FtX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DEua+FtX"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22B2857FA;
	Wed,  3 Sep 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901368; cv=fail; b=GPfKB2RzNIV1Un76ALYUCPY3Q86JchNqX8uQS/oR8OdgfDHCzRvxGPNQBbzNZ13y2iuisQwD8AWI4PBshUhDRIIJKjlKXaeXtQuo8gVPU6WveCrvm9d5TPeQYI1nWdU8oSMWK0ZUrEwz1pOls7K0tg86QoTQceYooJRXDkuChsk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901368; c=relaxed/simple;
	bh=Q3NdlTvbLJAqDew3DeIkA43nVbPVHdWHo4LGmqYROpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tbWGpMKPHvMjdOi/ENOumZP195SNpfooQCXuiMtI1WNYIfVIKANFIJK+7qhBRxzMSv6NfmNGuDBUsagF2CjQY4kMY9G0LdxxvJYLx+u/X3cUNIM4bDsuHcSCsanGMJ6fKXSkyVuTVyVD6VdXFj68L5rLaTvvFu1uCynREoodUKE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DEua+FtX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DEua+FtX; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tWmxeWtSPMkXSKAS89VuBZBfsZf+MF4J4D4N3JzystNvAUjFG2pVKfcaJcAB93Tip2XwphmRGeu80YfNgP0uomLW0WkJk6Z86xXr8PtSlsifljN2FAhGvg5OwPCrUIhCVIcPGGP2nm1KIyEIGAKrQ7cu6g1OZ7/1d2Bk0kCJhhQTKcJesceCe6PKP2O/dMgxambmM/bxJ5zRGO2FEyKV/PRHcE/aMFx7YZgEZeLavkpjMaB+M9AvNh84iMUpVdeEvfWDERsTWvDm32ZSkw4v3+byHJ5wR8GUJJs/FU3phaUg1LDtIio/60mi0LbQM2GrvPzqJBD37Wk3SNehb5ayfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3NdlTvbLJAqDew3DeIkA43nVbPVHdWHo4LGmqYROpA=;
 b=kPQg299aGM4QbquLRLFdpReH5oqnYtfsIo2pRw+B5BgA4EybmnPswgLGoBQgE2Y3MmXVoUcpj/TWtiIFq8MuT91EpRgMjGkOHZiww5pExVaVvbd+Y6p75JbL2p6fvJo9oGlntPDb6fSv8fP0VTtK2AI1Jd2RUh2MzsLnC9OfKESFOeQy+Yq4vA88bLsh9ctO8jBXeB6N++nBrz8/PnlD+fayHIe7bUb2/x3leSxifnI0BgGkSUxts2VizgcLKMeBurfOXhSiTw9OX05+0gFcsFDHGCbFQh3cdA6Mc7vwBzOVgsHy7E96zwSWRMsnerKfL83rihe4bLCM+D/thQgZyg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3NdlTvbLJAqDew3DeIkA43nVbPVHdWHo4LGmqYROpA=;
 b=DEua+FtXQQwDUa8iMhZ2A9W0CY1SRJGVxMXoSXETcyM4wYuyiGCX9gNWYRgBort758Fklm0r3clpndmZ8WwreZP1FeUsW4WS4dZiRdgCqqoGRLWQ0+eZScgb1+okNw95QRjgl0csPWiN7g1op6+M3fQYvEqrdVWBZIQNAO1/4dk=
Received: from DU2PR04CA0348.eurprd04.prod.outlook.com (2603:10a6:10:2b4::9)
 by DU0PR08MB9750.eurprd08.prod.outlook.com (2603:10a6:10:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 12:09:20 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::69) by DU2PR04CA0348.outlook.office365.com
 (2603:10a6:10:2b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 12:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via
 Frontend Transport; Wed, 3 Sep 2025 12:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiNGZ+r9v1l+4eyW3SXnMy/UP5Cb1b4NDBSqNXU3MmLfNxvr90nxJGk7Gei8NBPJarQjUoAF5WGJ6O44sQk3TUPwt6XpaxI2RAEKJ8/JTYguchhSBKZpvLIV1Yh7pfEtWLgrd0EBgjKd//kScDSO+1R/RbwnmRxD2DojoTJ18a4GIoiU1a47xijzIwL6xcxoK06hizgAUUEeDKz/pTqjliiQOfQHWnzs3qWhB0rQI1jUgszP+Y4Np587OmFqhOJWcKmi4zyPz3kHNN157Zh/zZuYd8I5Xv6bQ/tn33FpDo4GaE5w2Ty3caHchjN+irGe++1kOtVQC0GC+Sy69gZNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3NdlTvbLJAqDew3DeIkA43nVbPVHdWHo4LGmqYROpA=;
 b=lslWwBReRZplJWlHVuph/BIHFwcDZaafr5PEUNz4VLbzWlSH/NO3E9JzLrMD3aXmFK85O8fHIZvDvHU9R9WgWd4CkzXr9hc7tmO/ibj6W+I3KAatuF0hRXfCtE9xhBe0fKKiau2nwpfRubLRHv4SDZv0nlQ7DxXPf6smdX88a1GbkJ+vb3VLdZ24iC+ia9eOgzMzNzxxOlx2927HpXfvDCjXoCalYq/5LsB0S2tGNZ1Wv64YzPUtLjPNF3gEbjKCLH9VTOmrS9NfkgHOwpUroUfkhFY9RqFlmhueOMgGwWzK22vDAZfTMejU1g+nLbTrfXcmUYKMz+Mwast0SQrGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3NdlTvbLJAqDew3DeIkA43nVbPVHdWHo4LGmqYROpA=;
 b=DEua+FtXQQwDUa8iMhZ2A9W0CY1SRJGVxMXoSXETcyM4wYuyiGCX9gNWYRgBort758Fklm0r3clpndmZ8WwreZP1FeUsW4WS4dZiRdgCqqoGRLWQ0+eZScgb1+okNw95QRjgl0csPWiN7g1op6+M3fQYvEqrdVWBZIQNAO1/4dk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBBPR08MB6137.eurprd08.prod.outlook.com
 (2603:10a6:10:20f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:08:48 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 12:08:48 +0000
Date: Wed, 3 Sep 2025 13:08:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 0/5] initialize SCTRL2_ELx
Message-ID: <aLgvzKeEPn325aRO@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <aLW5OIgv8/bvvY9E@e133380.arm.com>
 <aLXjVNCbT6YeWlSS@e129823.arm.com>
 <aLgd0/7peYBA4z87@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLgd0/7peYBA4z87@e133380.arm.com>
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBBPR08MB6137:EE_|DU6PEPF00009529:EE_|DU0PR08MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 454f6507-fba5-4b5a-099b-08ddeae2b6b8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?iZkmKaqAd0LtT4oN26GVgKGlF1AVPfKIRZXYySYNf6OkV7OiGIa4d7J5JbRy?=
 =?us-ascii?Q?wmimjvlXIXFDZ6u09WNm41t9NXXrzrtCHfajAQpekJxixJ02iuIdhL51OWrA?=
 =?us-ascii?Q?aNAv1OYDFpWO1O9YI/RK1YZJz9SMm5ablSZP0hzOnqdRmg9t2ypkWDvBt80f?=
 =?us-ascii?Q?TY5PSQkMG2weO2WQ7v/Tm26yLcM/+M5BaCADjNU8lezu28FRKeNyjfg2X/H4?=
 =?us-ascii?Q?dtSHr5AnGFesQESrs+jEetPBypLndMQIbi7kqY7OXQVcLPlf4DXvSg5JgVN5?=
 =?us-ascii?Q?YsFLp8K/Oymi5rXjxbw6smkv2lVVbRVsynVnUF7r2P+uzW/duwOieCrFpJSR?=
 =?us-ascii?Q?MYT1hvqkyHbEc50LnS4cLTz/MWxboztvnyhrvMFfVkunRNUqtwUx5FjREzrd?=
 =?us-ascii?Q?k3u/k7GOhTioHG1iOD7b2ITcPlOGw0fMSWkYqW1KT9cNLZeDk3rw3SRMxo7F?=
 =?us-ascii?Q?xvPXEBEX+uSKZKxBbpAR+df6LUxxONBqRgzwCGGRV2WmlqAKLpcRhSFKH9I/?=
 =?us-ascii?Q?DtNSIeNPolC7OP8OqKdVjCmWBBUQLKlyXB/CWpnItuZzvYfYbdHa7e8KeU+R?=
 =?us-ascii?Q?b+jSd6ZE6t9bQlGdAs3TfHryccDLBTsFdxMDgk5r8gRGEmQUwO0cZgz1M73N?=
 =?us-ascii?Q?0MoBWj1CAwAuSpY9wj/gF+EE/xDHA8HREDdIoeN5pgFaM+qYdoAagAmHlB8A?=
 =?us-ascii?Q?zYn5JEXM65MLb4EnGGOF9lEZlHvKE74zeroZugiuxq2+ERknpwr7RE8XvRzZ?=
 =?us-ascii?Q?PPPtqTinY570/GyZ4XqXU+locBiMtUFEh+t9I3A1zE9oUTgYLrgH4yrvu5A7?=
 =?us-ascii?Q?cgZS/zzfpvXb7aBRCH1F7XV05YQZgEKHshoVyNrxIh48K8OZLIK6VO0oSzdw?=
 =?us-ascii?Q?KpKID8DO0bGLXGfrbo/P9R4rgeBMXEV5MLNmixXp52KSH23hk9OXIG74fQVP?=
 =?us-ascii?Q?mOofRJsJfQz8Ry2pD6XGQoUrZa1B4qS693bjfxFbtExmRW6rhQDUMfF8Te3H?=
 =?us-ascii?Q?MWvaepYAODG2oVWmwDYDKRZxuFmQQy+lKpoOlUZAFZyNIIfpnvWkIiuPgSIX?=
 =?us-ascii?Q?FYtWhrBwM/UoxsQSQ5/83RV/LGZxWxfU/som2eS6TKg8tPKVz+GfOmYbiju4?=
 =?us-ascii?Q?YHk9vLO5n0LWBwuz0SSChYPDvRpu2pSG4uwOpW3VBxt1IJ69CjeQK5C4Lz+u?=
 =?us-ascii?Q?8m+PZ4eKZT60PKV+6b4N4zdNsRwvHSLrhGlBc8FsHXDZl460Pr7Wn7wL2kPF?=
 =?us-ascii?Q?Ku8K4lnr+ZlQXTQsoLSD6eK9xl53BYSKE54wJeEP/n16aJAvQrWn4CYGt+0Q?=
 =?us-ascii?Q?zt0nfhzqhiaqZCto1nSwXobfGi2BbXgtTES5ph4KM5kydAts/xet4zSef12z?=
 =?us-ascii?Q?AMthXAevdJKDXi9JxvP1q7HONUg40r9TqMV3kBgfzaWtf9KiZJelk+qHXlPH?=
 =?us-ascii?Q?/89rdOguImQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6137
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a2789604-ca4d-43a7-f432-08ddeae2a333
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|14060799003|82310400026|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ebNwoiuY2GAHCmWGvFA7k2zLHObELCttoYUsr08/W/HNeCi/KYj++V20PKa?=
 =?us-ascii?Q?IiO0o8NgMODCFVh1Iz8v9Qvn8hXYA5NzFpLJxxIzRUYiSBJY+afhWdUnrq96?=
 =?us-ascii?Q?UQQpz+gO6rzAESnvwW0yTmkiso8B68r+X6KUdWQnEHQo0h6i+ljSZHLIk0SB?=
 =?us-ascii?Q?/adGs2njq4AoBSx6xqvBghYO60p7UkCPTAqGZNQvmSSMh/f7NkbNzbqiI96J?=
 =?us-ascii?Q?bV6sPbBLuieNIRhB7uzHM5pIgz6vkt5lNYJzicW4YP4GrMG/TBvpwpv+YiTC?=
 =?us-ascii?Q?BoPI5rZvSBr0W+0IuGUPng9J/8V6mlGqMf2kkD8Sq9R4LKBFMFLzaGWEdvRr?=
 =?us-ascii?Q?i3LK+4AjaT7+2Row3OEmUzgG5OsJ2iFDaMC+vmeAdQV1DRrZV0kZciAnEFG2?=
 =?us-ascii?Q?tzz7q110JvvVlxl2OxtFfxTl7bTT9Yhfo4KBWhUv3qeEl8VcBFwgBaVWDMDJ?=
 =?us-ascii?Q?6k1nfe9bQ0ED+USORUdmlLQmVPkRslW1WCVTR1If3Auo2Cd41LoJ83L5NFYD?=
 =?us-ascii?Q?zGl1zr4A8/wpb5EOTUPoO4vAD1ZFDPmLAuh/fwC//TAr7rjyUuCwY5FqA8t+?=
 =?us-ascii?Q?MCrpJ/d8omY/mcu1wtgofcowH8zIy3z8uQCiw087bCZfxO+St95xaVNcwzdV?=
 =?us-ascii?Q?4VwwEUGGbCXM67FEmUOtO8aI92nyqHLrevWgZVIoRfiuhvGzRExRO+eubQPv?=
 =?us-ascii?Q?aXr2lBDS97c0Rs+Bq2b5QUHhDCQ3pMid1aqaHWemiQpXmolqBeo2hJJz4vQM?=
 =?us-ascii?Q?xH7JoS8Z7ARIB3LQMds1NB0Vmzt5XWSzT6H+4PkjC8x2WFpRUghl6WL4k+96?=
 =?us-ascii?Q?8/T0NSciN2+Eqa8kF5hmZ/w1yDJyBwJNz5bJTo4jXMeObIdvRx3IjQNttq7i?=
 =?us-ascii?Q?XOD2vV10oxVyz1d3EC3s4aWaR4qXOdJ8/JDQtfqZJQm/hK4/jwCnMJiijjcY?=
 =?us-ascii?Q?mUFlxRKp6QNkbwkLF/dGGDq7DUxHUrAX5kab5dvn9Y7xIp4quu3d8J8RR2SX?=
 =?us-ascii?Q?0poLU2ZBhJvpPBJsQv7l05EmDpn8VNiGcvjTZMkPkiOPASb1zjt7rtRuTi6L?=
 =?us-ascii?Q?md/OyZp1yXJaEeZVg520UZowccjhnivweMzrGs0TV1FS6jsS2pn/BP5P5cNn?=
 =?us-ascii?Q?hdXjeWsXpn29vuie6YbSxMuwSg6dCjyjuchBmVBti4R88BZkeBQINq5rNMWJ?=
 =?us-ascii?Q?K9K+YU4KRxqbA2KEmwSe6xJ85u/TDc8kEgu5jbmOTLMUiqOi5kuJvWuOcDz1?=
 =?us-ascii?Q?qEDsCBmQrwFf/v8wDxmGyrTQGNMHw2VHbc+bAfuNiTVmbNZggImsIoytqdBD?=
 =?us-ascii?Q?Dm+df2E8WjLkCS0+Ftto1wlIPzSSxncJQG2UnP+xkIrHIhsBKOJ19Q1sml4J?=
 =?us-ascii?Q?cWlcI3FXVk2ALynRWEI/UsRIfHT5e6dyqH/FSzv1jVdUFZBf+1eDnNOrLeft?=
 =?us-ascii?Q?IhYbY2CNDPR++/hLVKR+7Siv1By8DK+qnPvN0OkN+B1XG4cNBF9KrHafbWK3?=
 =?us-ascii?Q?VkpUK886zyXb/yns0lMmuhh3UWvyNHAolHLI?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(14060799003)(82310400026)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:09:20.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 454f6507-fba5-4b5a-099b-08ddeae2b6b8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9750

Hi Dave,

[...]
> > > > This series introduces initial support for the SCTLR2_ELx registers in Linux.
> > > > The feature is optional starting from ARMv8.8/ARMv9.3,
> > > > and becomes mandatory from ARMv8.9/ARMv9.4.
> > > >
> > > > Currently, Linux has no strict need to modify SCTLR2_ELx--
> > > > at least assuming that firmware initializes
> > > > these registers to reasonable defaults.
> > > >
> > > > However, several upcoming architectural features will require configuring
> > > > control bits in these registers.
> > > > Notable examples include FEAT_PAuth_LR and FEAT_CPA2.
> > >
> > > This looks OK to me now, except for one or two minor issues (see
> > > replies to the patches).
> > >
> > > I think we will need a way of testing all the code paths before this
> > > should be merged, though.
> > >
> > > Have you tested all the code paths, or are there some things that have
> > > not been tested?
> >
> > I've tested for pKVM, nested and nhve and crash path
> > (I do my best what can I do for modified path).
>
> Was that just confirming that the kernel boots / does not crash?

Not only that, since the my last mistake, I've check it with debugger
too -- set the SCTLR2_ELx as I expected.

>
> What about CPU suspend/resume and hotplug?

Of course It's done both enter/exit idle and hotplug with related kselftest test.

>
> My concern is that most of the defined SCTLR2_ELx bits won't affect
> kernel execution unless the corresponding hardware features are
> actively being used -- so while we know that the patches don't break
> the kernel, this may not prove that SCTLR2_ELx is really being
> initialised / saved / restored / reset correctly.

That's why I've confirmed with debugger whether the SCTLR2_ELx value
sets as I expected... personally I've done as much as I can for
test related for SCTLR2_ELx.
>
> > > Since this code is not useful by itself, it may make sense to delay
> > > merging it until we have patches for a feature that depends on SCTLR2.
> >
> > Whatever I pass this detiermination for maintainer.
>
> Sure, that's just my opinion.
>
> Either way, this doesn't stop anyone from building support for specific
> features on top of this series before it gets merged.

Okay.

Thanks!

--
Sincerely,
Yeoreum Yun

