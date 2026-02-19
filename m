Return-Path: <linux-pm+bounces-42881-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMxKJb5Tl2lPxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42881-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:17:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3748E16193F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD4E3098816
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289D353EFD;
	Thu, 19 Feb 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLGBCWCF"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F540353EF6;
	Thu, 19 Feb 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524876; cv=fail; b=m1Zf3csFpA9mDP3bK8BXSfQcxEaaQbhXPuTdQ9YaqYA/PuiFLJYTAnOuKx1peCPt4ODJ5WtNMEVTwcvvL0mliVDKsR6vGEHyeKEqfm8YbTl96au3WX5GH4UMnwXAYbPlBTbveMCrfROmRK4WabNsiwvgEsxk2MDZCtX/wpVXsRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524876; c=relaxed/simple;
	bh=oVtxchxpQCWtZR/rkt7xPEnC2qqIzz+JTxVcOnqn7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amB0NTo3iG5jZcbF8hsmMixAZhIRYfnhwcWUTNN+SmZetTIkkrTbTPopEh28bTIR40oIHjN6uYmMJzlqfUoUHWX17UxZp2toxzFI9+3/Ur6ifGde76y88MtEZQm/2KA92icd8UfBakGyPu2s88lyykXk63IyqsTOdYVGqq/FIwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLGBCWCF; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWPHuWObLPikECDeRQxcsdYqIYlBqlWpCbWeGXew8bkDxLUgfBWb/y3chQJzldiv5f+xlKYU0BXg0V5cZ+rgbKY1QPRSvErt08gPJPbnAbxSvK592X5A68obdUjMBDzTpR6j7gVAYSrGraUrIAaE3uip9MIjb2IMECctlKCOEtXGtu5M7FYCS4QUe0YU6ZqWY9LCuP+84nkeb8jFgfTS7hmvXOlL/qi2TPsp/NL3e+DLTjLRcp/xMXbOgmM1unONF6QDuqrVt8/q+McpcieOE1OH5NlDr7mPjz2FX20HjVI3ttul+rlwqax3BajW48r8le32fDhKBXePwW2u2815ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNCbye3nURuG4Ns/Ble3NmpKlDV18gteLUVZ/fHupas=;
 b=PcPo65IUzXinRA2DltrZUQuG4FPUVnpBZ+LjbFhWeWHsRYZlz+/XNV/u+JvakHfETwsnOZVf3AXXeUpXMneWy4xWOubB+h7gZqvpIBUh/3ROHxKvREh4dnD3GXUY84D+eHK0TvuDOl/mGXkGvl13QP/Pp5E4yc81an0uUrsqyFWoUJhOVKUY1FsuW+9vQEdLQyDWHEkYAGO7LSVwMpi4xWjNug3zpsoCh8Kit6WpDCb8ZS27HA5F6YYCCi4cLV26wIEvPzBsN1LhtA/k2cddjD0E5nERnldpT1+abY9pPjfurUnF244+IOLbIgMIsV7v6IQce86ktH8GKj93PDcvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNCbye3nURuG4Ns/Ble3NmpKlDV18gteLUVZ/fHupas=;
 b=eLGBCWCFQz1/d2SzfODG5YCKf80Bg0ltSVoSSiTX5WBfImEIimCYY4RLPfUr7HQpEP7dNbNcOXgYjtu4VtvVddAhOmUC94UrWZqbkbViC8+Fup4mH1ReN9AoopbZi2y6stFh8Db7lJqPi1A/Mh8HpXVWhFvM2qCofenUs98t3M3Ei1WK48CDoVaxdGpyo/9vL5xYdHR+Jicl2Pg/3mfruINnsZPJ+80LndfnxzJjrF423StSWjVoMMRbY8dlasMPjmax/Xzz96xZTU2H0Gl7ui/b+PRbytFtwsInUBn+kBzxt1Vr/36a/FWuok7Bi8+DT5R9PhbuwUYzbW++KFN3mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 18:14:22 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:14:22 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antoine Tenart <atenart@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	hariprasad <hkelam@marvell.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 05/12] bitmap: switch test to scnprintf("%*pbl")
Date: Thu, 19 Feb 2026 13:13:57 -0500
Message-ID: <20260219181407.290201-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:408:f6::18) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: c508386a-8ecf-42c5-2808-08de6fe2b491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqH8gL71rVdkbWVvVmMWRR8GvTKaueq0oQuNQXr6wtKE3Vm+Jh9lJB9rXM1i?=
 =?us-ascii?Q?KElrAFf4YAJ6WM5ndsRi59tQl0FAsepKFMSiTzrqAOX0HcY6WzrwyW6FlRcT?=
 =?us-ascii?Q?ks8otu/mP8QJjrxq24zUu6nHez3esnpJ+DQi98hJW8IivmykqwmVRyXZQcSi?=
 =?us-ascii?Q?7GkZkGglANqlo9YsBsXLsRD6Bx45xWpAQklu0msDSMYeZKsGhMlAEbs66CQo?=
 =?us-ascii?Q?Dzp36cwvQEuBB2YaVXWjonZVGXpFnEHQKTHnQXyZMdYEux397uMHrH4oRcQU?=
 =?us-ascii?Q?PBkKJ6L+55sFJR/dyvj21VUEvbgrKwWrVoFu7DaOfJa1tNl4HtSoVgyKGz+u?=
 =?us-ascii?Q?XDYTKI6fydCf3uzD2qfvUmADoMZcvLXxK3IZznRhJJWlOze1CvlEv1X5jHPe?=
 =?us-ascii?Q?tsnjrKOP2TPIAsNLc8AU4FBKY/8CHMmPeAiS50oeWQYMsuYrpFoEdjUBQkSl?=
 =?us-ascii?Q?+pVYIrDMNw52ae1zVNE54HYyqaHLfjzfmbPQ3ugzzPWOiNeVzmfNtr4/mEYC?=
 =?us-ascii?Q?EGXM9l4o1lqcNnn9lSszqKQZtsZi5x9ShPlLcs4P3EXE0xhcMoxL3DbhX5LZ?=
 =?us-ascii?Q?5mGdf1U+5f+LEW4pPKVYxtNyIdLe4VLR/+sY0EP4dYRoQujgvKng7YlQPOZC?=
 =?us-ascii?Q?rOdTOzd8yXZK2zH9OZlFIEkFLB4KzF6yPkcG9+Em/5PJamQrLFW2Do5nBicu?=
 =?us-ascii?Q?VnFXP6NuX/dWnAZ2d2ZuxicOvD/Cpwvr6C8eH3zuOst0RGxOQcFChvoa4hlo?=
 =?us-ascii?Q?uZAf5Cwy6lTalpdMC8Bb8o+gfoEmYlwz9ZytNHFE3nCpNGtg5WOWh6z13f9s?=
 =?us-ascii?Q?wE8dK+7LHrgLgwAPMJmnsEeEMo9vFoFyR/5xhFl6JWZRCyxi8N6b0pgZ0wNO?=
 =?us-ascii?Q?xO0x5g2C7zXUxbtoQ2jc/pY2+cd9cQm4C6r78EIqu2k8O6OG6l6RUFhJ69AI?=
 =?us-ascii?Q?DglDJiQVv+YMdNdNjALEW4MF4jfudXEXzynwwHADUUmhVGtRghUeM7i+uyk+?=
 =?us-ascii?Q?kWn3Dub+bDCtawJNY66ajz3fCnL73M/zO8oJ5OkmDb6r+KZCTcMQXT46VGI5?=
 =?us-ascii?Q?bvtzybny2jQ40dE21O88Ug+WL+u29TGlIM6iRMZ5xU+e7YvQLAvFP6NbEoyt?=
 =?us-ascii?Q?4v7mQw6aSkC/JU90BoVJgIuRLS/rEXygMgUg/diT27uHK9t/zZyzu5fMMJO7?=
 =?us-ascii?Q?Z5ungWblmXQoeQ9sOZY6Hy5ppDbWvuWxYO39+ifgE10PFSKBMEzcP7/r8DcK?=
 =?us-ascii?Q?ZvOd6/ckPG5nZPNC4qUmJnoHhRLXLiOF3ATkKEvYvRtvQQtyG01F7/a0EL1f?=
 =?us-ascii?Q?lNaMZjR8SeNRV8tED/DNXufJjFQ5yWalNdC0tBC9XdnDLsCEW53BoBm9on9f?=
 =?us-ascii?Q?dKBBJRAXhEObb2nmglVBWi1Z5FV4l2xYlNmHHbI+QkFIZ6yek7i0nKgQ+tIg?=
 =?us-ascii?Q?pnqqcvJiD0lzW4g/fZcL+wayk+Zwm4sunPVam3iFxQn2pb/xleVNwjvKYgKz?=
 =?us-ascii?Q?9p7JoBZAP0AFtWqd6ZSVq3HqVYZKHyb76k6QAJU7kAPeJNNj6ub7ZRFqMEkI?=
 =?us-ascii?Q?77nFPBnwv4HnOKSIuw/gNWq1mumTj69lL5gEdq9AMTp8KpMJcgW3pRbIgvgH?=
 =?us-ascii?Q?yA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgWy176FJwp2kcpmyl/qvfQglbADR7e+gix4Fv7JgNyMSLd+6c3fIJ7SZ4Z2?=
 =?us-ascii?Q?y2iwbxsEBprze02ELDc1EQ6A5L8eavkIMPoxuSmsA/ggJpvX3e8LOj5/uhb+?=
 =?us-ascii?Q?0CRT8o6bxCpXP8kbuNZ3r/gKm53Np2Co5Ii+46Epb1OfM6okLQoAHZqrK6wh?=
 =?us-ascii?Q?KCJIbPx5ccNQQlnesZw25yg9fUh/FRrH4wsU4zPihNFZqr5y7d28AsfJ3D+l?=
 =?us-ascii?Q?u9/xgRsOJ8he02P2sT5b35AFSFYup3LhMODlAHdDsLKn20h+22F5Ip6LFnZ/?=
 =?us-ascii?Q?ejqnBtaMsBoBkD2h9LaGYd45VGS/NFV6y50AHlq4NyKcgS0j36kc5bkREDm/?=
 =?us-ascii?Q?aOYvKLOFZAy9vVSdMHAhvbGPbpTFuZ9OFYhPmk20fxd/DkA9b959YI01CwFf?=
 =?us-ascii?Q?8dGa5qByXRYpbEtwfhFCY+RiLHbuS28qd5WwrO6ivmqiN1KerSxp0YBOuvi+?=
 =?us-ascii?Q?IR6+BfFVjxarPyPGViupMZqgS3KB3r4zzqXCsUL4Pa/h2CDzKifIQEcNPjzW?=
 =?us-ascii?Q?DtnRwebYmL9ao/HVkXmIbXlzdSYNfIIuPJ7rHNlApUR8ZJkwJ3rmaGWTUsvr?=
 =?us-ascii?Q?UAzLzkpkjDd2w3TGCLte+vxXI0J7m50DNUPD4G3NujVy0zB+he2XDKfqqD52?=
 =?us-ascii?Q?0QXFFmwGUT/L49q/Do2ty36i22Vh3CIkiHzl1XtHH9VEAGIsmJzyDTgn/ij8?=
 =?us-ascii?Q?MoZsePtRjfiTsnxxjw7LsUDb1s7EQoJFSLsGvKhrkKtDDIPc2LBUNhj33YD/?=
 =?us-ascii?Q?0R5no3Z9RcNWzbFGtAVWoUDd0Uo3J59nWYzqPMiL1tEbZyNw6vqTIXp9phII?=
 =?us-ascii?Q?hSL8n5p4TKyZSh44pCxv44c1E5uznggwqbwMEswMH5LgiL2mhnLcpGGH5WJK?=
 =?us-ascii?Q?64k/7q745k6+jPs3MamwTjMkRIEIruyC3b0fhd5RzcG+IU9ANzJaCskOwQ1d?=
 =?us-ascii?Q?Vrm9xFIFYuTttyknvf9Wl/Ylm4/XvPVmIzlBf3m6K682jg8wDDhOGMHRgFbl?=
 =?us-ascii?Q?XH+kiygh5XsYuaLPv4FUAkkVQWK3OgXWa1GLnMbyWUFBj79j3s7fydMMeRmo?=
 =?us-ascii?Q?GkeB58nsueLBKwUTXi7BoLT48qtqifJ7Ay+8+vjIExYFjYPJEolVPk5EmNyk?=
 =?us-ascii?Q?ODr05T0XzM/cKR2i7GSkM4UDMglfy2nR6ZOiuU/tEoNV/BWHSiPzR69iI4X8?=
 =?us-ascii?Q?/eSiSahbheslY6P28UpQsteCREB3vfMdj8sMLtJYKbCGSy7MAO1+z1z3kU4I?=
 =?us-ascii?Q?kzuyhu7eWXQHy4Ii5JXAZd3Yo/qDB8tVAv5SIYXqIgwK2jsKHyS2weSaoenJ?=
 =?us-ascii?Q?vMbF8hvYzRVOAdaGuIMpzYE+LOL71iqSCNUBjD5ixQEUEVp8oFiAeI+m9U6K?=
 =?us-ascii?Q?KqvEicAJWQtfZTr8FwmUmHWlTn/XJ3zdLZCupmQ6x6MG2L3TozgTTPuEDQeV?=
 =?us-ascii?Q?zudElLdTd2tLFv7DihLgIYMeY7CyIVHDu+MukVmFNwSvvh6xJxBMykB9csqj?=
 =?us-ascii?Q?kAbA11PPaFtTJNutrwdBseiWxrguWv7dLIzJAmnW9/hUTGjr2sLKvtaKVsWZ?=
 =?us-ascii?Q?90DnRJD6iwTxd5Q/k2HsNdojoJk1MGwYCmB8/fwC0UFYEQFfXVlizXQKfiBi?=
 =?us-ascii?Q?3NEFxUFfy8/KiWrRf4BrtpH20ayp27yY3SPSvUqlkSWIh2VwaIly6XhfhYUF?=
 =?us-ascii?Q?7ubPoYdnUasnLAawIiz1uqYampg7ReVFhaZw8a8wwZPwha+02QvVPaOdLr5i?=
 =?us-ascii?Q?HEDdFFpXwyckHcRA2oo6Ssj/NhcIEmVD8jzxogGpJkhP6iC1oOvq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c508386a-8ecf-42c5-2808-08de6fe2b491
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:14:22.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW5kltigjSarLYW60Eej1Zndz5rJ3IxpVklqyckHyc4e6VoIV97XrDQV8Fie2AJF+no1om3CLisJOGH7PHELzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42881-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 3748E16193F
X-Rspamd-Action: no action

scnprintf("%*pbl") is more verbose than bitmap_print_to_pagebuf().
Switch the test to using it. This also improves the test output
because bitmap_print_to_pagebuf() adds \n at the end of the printed
bitmap, which breaks the test format.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
The following patch adds more beautifications to the test outputs and
shows the before/after.

 lib/test_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index c83829ef557f..2d9b71ad455c 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -544,22 +544,22 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 
 	time = ktime_get();
-	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
+	ret = scnprintf(buf, PAGE_SIZE, "%*pbl", (int)PAGE_SIZE * 8, bmap);
 	time = ktime_get() - time;
 
-	if (ret != slen + 1) {
-		pr_err("bitmap_print_to_pagebuf: result is %d, expected %d\n", ret, slen);
+	if (ret != slen) {
+		pr_err("bitmap_printlist: result is %d, expected %d\n", ret, slen);
 		failed_tests++;
 		goto out;
 	}
 
 	if (strncmp(buf, expected, slen)) {
-		pr_err("bitmap_print_to_pagebuf: result is %s, expected %s\n", buf, expected);
+		pr_err("bitmap_printlist: result is %s, expected %s\n", buf, expected);
 		failed_tests++;
 		goto out;
 	}
 
-	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_info("bitmap_printlist: input is '%s', Time: %llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
-- 
2.43.0


