Return-Path: <linux-pm+bounces-42882-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJg/NMpTl2lPxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42882-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:17:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB416194F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C302B309EE95
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480D3542EF;
	Thu, 19 Feb 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yfe9usz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BC353ED5;
	Thu, 19 Feb 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524876; cv=fail; b=G2hgeYYS3oHR2pKOBU2bEo1MyQITVtViKSWyhfFd/J5fxnaJ3MZ6TTKhLnHEeGRSDR5Ac4WQTGpavsMIibDam6Ch+g6lmXU12noppqxCKe/3DofjulRXRBhdWlpuRH9Rf2yuJI83z4F6ZesDJgVPUq/6B59ZNL93EEDmLkwMquc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524876; c=relaxed/simple;
	bh=uHB31LX4UUR5zBf2SuKw2bO/L7Zc0YEw8A/EuunfQaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9y3CYYDmXi5oAg8bwUnwrGN5icpU7/1WVmeGLnQuS+StD7aCY/ngTspVKFO2Qp2iQIzywgvN97F9jDFKLuGz17/eBHuGuOAQUBagd/rNuPuTx0gJvxwvjA+ayvbFJ1EQRcNOlRwJ6awrBP5swZIU+6yzbELAxT/804srZxtfPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yfe9usz3; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px1flyDUKJM2g/RXOJWGat5WnfMYw3Xt5lHjc2nN6wxwVWrwAH2iMLbolp1Ifs2tdqnuZ6vgqfpTfjrnHWTL8duLFDyp0mCUun2Rnib47/x1VUtE+BcGZSY/aiyDBuAWJasXTa//mrjK83m+T82oNGLLv+25hn1I1Kq4uH2cTnoNdj9VPE5O0KidbFf1UA5iAlvZpVMc1xN73nHzXoFO+AeGUu6/KerojEIU9xIBhp21UViQYhKlayR5iVIz8q+HQk7D9YhzOnl2JnNOcr3mp3aa0AMoCZkHmnddFNRN8pWy+NqGQzid/CNGNu/pHQRoRx9P98XBQ1YnTi3cVisqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggTuWLcxTb76jKEtMfh1qRnuxf4JXevmw7IvbsO7Ry4=;
 b=Qr/zElfzDHDD/cZyccNWiioEB/dqOCGKFBKl7SM13EYaWyVoSs/5viTvQo5Ec2aytaSxlaL9GSF5NRBOea1IXb9jMphDZHSTLTMUMK886xH2gv7s68j1U+kF8FfJWoEhmG73F8L3bzJ9FoPDSvX6lb3XT6QhsA2fx7PNyOBS8ifLhVBBr+H+vcVEZFlFqVh6kaS4RBj8TWXsuwz/+KslMEjfabQU2/G3N0FiuUg2BVETGKK3kkHHHSBaMp5bfzIgOzdGFbJYEtHHt8QAWQdR/R+wRwn0oYpqfKvOjVI3mSxADEbs3e6ge59Au8gBhhguI7OV3UqxHhXcSExOxYliKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggTuWLcxTb76jKEtMfh1qRnuxf4JXevmw7IvbsO7Ry4=;
 b=Yfe9usz3F69/CFfMgW/+oaonfVIPPPYnW5pOZdeXloAmr8/ydkXE+9pTC4PWZfHc5RifDpExqfNvyD0tFabWiAxyEqT7k5xFGGqqa8ty0HaxkjY338dNVGg8HhttV3Ie3nCSeMEpc7dDkrm2ErUIMK7Da0THOwLjfUlXLaj+QdI3+xxpEcgtrEGUHQLIMOwNDPH3oxhN030iNDOF0g7pA/Y52iWRCaIpHObLVCW0wao7ae6LM6+9G+D69tfMKn8xsmxlUUCFrck2ly1h3HfJAJADEwrHL4gNniN94aC32brWXTQX/iEBaqqpaU8hGXyKCbZ/yKBvxH8LhSo2Lpv+8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 18:14:24 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:14:24 +0000
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
Subject: [PATCH 06/12] bitmap: align test_bitmap output
Date: Thu, 19 Feb 2026 13:13:58 -0500
Message-ID: <20260219181407.290201-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:408:f6::21) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 759fca25-ac55-4623-62a0-08de6fe2b631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3kUUsBYXSz4s64b5I3srMS1OX7JXIRpC6UrxaTBTyhTaRjY+XVAGaEkFzgWY?=
 =?us-ascii?Q?HoNZQEBXQOTiNSapE8R1dOmKAR3ZP0fUlwlMsia1bWYI2n1zpWrd6wVKGOGS?=
 =?us-ascii?Q?t4ru78IwpPZH0Yv4IjLOZTHYHuKOoQWkmadUmrWxn1tONiOuYH05KfXCK/SB?=
 =?us-ascii?Q?Z8Wlf1lwbJxXS9PnnsTbGw0+cWT2bxGzITkJpfnB3kDRTiPWMS6cUS6Ddid7?=
 =?us-ascii?Q?x2jgsnOm4q2xqDMFWPVWOQC23TSo0qs7x/qrwx7OKrLY9cxE76/vfPUt9cin?=
 =?us-ascii?Q?MIZES8Up4n9ReRGQLAhDC5g0UbOI64kkzokNqgIuau/WWKjvhZDoQHPGsd6H?=
 =?us-ascii?Q?18DSaJodozRcfXkBoU8rS26+JpqeU39rXBJbPtFY0o74GGiN3W2SHRC6UDQ1?=
 =?us-ascii?Q?p7Uk2cavowEPJc7Ep0R0fZM3SvkSWTPIDFIhO80m+MwNHYmbrmKTNhMrJjig?=
 =?us-ascii?Q?kdtteOuZFQ64FygdDvbRmmNj5fObN/rEjUeW5/V+E2t9T3WEAPgPqc6U0LmI?=
 =?us-ascii?Q?mz20wtTlPYg+VjwY+MPDcNxJryaxek7FsSCojOnvDqTaxXMZW3wWLwAT33C4?=
 =?us-ascii?Q?TQUkEwnbYLY2m1V8VKHVfQx5GG2jNYN3S7oGjlEfBfHe8nhdQAV8JbdpuTWM?=
 =?us-ascii?Q?hg6mkKuEOs/Fgzp3ho+c/HqpJGcLUM0JzKLWeby6R8v7W08WASORt4ocYF9m?=
 =?us-ascii?Q?VrHkVJE5pwf1mdQQnGjVaGnTgNZupr6wh1AfDuS1fem+1Yxv/+9xA4umGQPZ?=
 =?us-ascii?Q?HXAHBzYpwAXgbkgzayvbM7nTyeDTVOLnvMLNTEm0JVobZcvZSJqlVME8vyFq?=
 =?us-ascii?Q?TZraBBHKWb9mzFJJpjrdHPHxzVLmwLBbuNOeQ7+7OB4Y7LL1P65diZWyGTf6?=
 =?us-ascii?Q?5al2jvponEEi8hEfGLut2YYNivZ87nJvLUrb8BM3Ma67LM6PnegRm5wjTJkF?=
 =?us-ascii?Q?ir2JhdzZRo9t0p8jjt7lC6m/2i0GRqHHGF32PklgK9+0YjAeJCVwkzxKXAho?=
 =?us-ascii?Q?5LZaeIDR67LVuUsesc5uhw/4Og80KxYV6Jt5lMLDHiHHpL2+RRe9yUOKjGks?=
 =?us-ascii?Q?zQtJT2RhliD1dMNk1gwompjtmcLi+cfnvrFBQkoTTymcATAFSS4lFvLZ9vAh?=
 =?us-ascii?Q?RyAJCMfx8nK9YApDoqdV0OyE0fqrtsNiNQuw/xTWO0kzqz5aBJLq05Vh41vn?=
 =?us-ascii?Q?4xoMhsogl0kusw7be98mssSLKHuoDny2k3i6TaMOMwRfv1py7YEMHZdHWYya?=
 =?us-ascii?Q?Ml2Mjailtuws7gr8UyKoXdJbBcgot9eJYauh8AT+hmXgvp/XFIsFNJpT5fr+?=
 =?us-ascii?Q?MZ6w83d/odl2jj4FlOGNCbBjyzWhKRc6HrSzQR0HmjUX0LDLNxhGUUcRkLg1?=
 =?us-ascii?Q?zX2QEN4HLoyKeuyOpReEm273j3y7AysV8EWjc/UrZ0Q4kcJH/dQCbVYKZnZx?=
 =?us-ascii?Q?fcYMaMa4F+rjeEwvxLTeSo2cmOr8cbDrUHlqdVM+PxNovqWkGluf2xuT25vh?=
 =?us-ascii?Q?UsvPWFr/b9o9pzNj6qlSr5W3lo635QmPULzqFAsjppGfwjhmru0RUJiTySz2?=
 =?us-ascii?Q?yl0eyj+dpsBKeYGRAd+i2WgTEg3DUTX07TzEf46ABte9Zox7a92o+ioeByOw?=
 =?us-ascii?Q?FA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lxcj0jtJfTMjXhPDsnUjO/UFCXIE2o/icc5hSD+KTGv1XxsVRsojGWjIB/sY?=
 =?us-ascii?Q?gbmTmp3AmCItBTDsJZ4Kp9+h/kci7V9kZ4ebT6Ysb0klcMQfdZLYK6EiYl3i?=
 =?us-ascii?Q?8ysxCwyDunSRWhLvVPxnVGw47XWDD+HtVHWix4fhhGz/Wtm8NsTtgX6blRHK?=
 =?us-ascii?Q?fECkPBrG5xsSzcVjEPIOa+nK+gOVCS7hdbco195s0a+/YWia8FKwxGC8HcMA?=
 =?us-ascii?Q?LZULXK4s4Yyh790aI98nLLbsc9IlG9XEcC0tdKHkuSC3j2If9hvPJVdMKGeB?=
 =?us-ascii?Q?OBokDqGKPnwMKGNzsVICqgbsUB0GthrrLogM5Z4WJkaexMzrUO1anpECQPBX?=
 =?us-ascii?Q?r2kMEeYkej5qJ4QpJumDw3LjbjXfGcM95DXVcwg7cr9OXc6Mv1JczWpsF47v?=
 =?us-ascii?Q?wfA0JTlv7ecV+3y4NDY1s7gOBrEyFCPvQBjvhoCI7HnOZZr76MYumfskvpEn?=
 =?us-ascii?Q?ycPjwOMo4el78l8ax+vwzQss/Q4YuB4waYSIVtCrxREzVWcKMEaZn3sfc+/y?=
 =?us-ascii?Q?RLq9FOy8j2SXqyBivv2qAY5xvbCPn/grWc/khy6tn2p7urTDGJfRRhMJoV7v?=
 =?us-ascii?Q?GlsVAN7VTpoDVKu+6YCFcR/U/Jjl72Zw4reUWb+sbkl6IyrtrYWAwWv9TI1O?=
 =?us-ascii?Q?c3FkYIoHkc7jzs1H5q7ur6EG9fG3BxBDlUzWbk1zoxmFqyZlSkbduHxwpUug?=
 =?us-ascii?Q?F3VXH9DV406o36Qj0YMZNBDReq7KTKj7XwRsNlO/QKshgqtmD17qljtFXuhu?=
 =?us-ascii?Q?FEOkcDKAB87Prejw0m3HV8Spr3hXQe38ahWmF2Igj3QuCNuIClev733iXmvr?=
 =?us-ascii?Q?dXkl7VoB+ZLXZVjSKoBUB3phgxXyevvy8QuMCjuQGXeEgrP+MBezHKScLfkQ?=
 =?us-ascii?Q?Jcw1SnmLzsGGK0mu/Un3oVX7ezeAdKLHJIzW4D8pIb2m2MLXMooZD88APHad?=
 =?us-ascii?Q?HONKoSMEfkBLmEFd4qZrGBz7o++5ZCg3tsOo0O6aNZQ7BTF8XA1T5u0i4VCl?=
 =?us-ascii?Q?HIP5XpwXxsCPBd64CFAe2fuu1NP2UuMRN7OrgHcJcXYlfFtb7nmjDUlkUnfM?=
 =?us-ascii?Q?5s7JP61yV+pnV/rrCbsJ6/M2Zcf72aYdQ4Gxty2WlyuxVax3I09lDXLvzPLT?=
 =?us-ascii?Q?86dW0pSIInhze7K5/eV11SgHddULyARqrQ5yvmhBi9vkixZXnvjMXOlMMTu/?=
 =?us-ascii?Q?lOFXIF6lJuHmKN1WzjSX6h/MsG8U1fVXz3d0MFKN9xpDva8qAI6SgS1SN4pb?=
 =?us-ascii?Q?YU6/gKxCpghhE0WZH8boQ8EkqC0yr42JGIAsUSHcQJY9vCC1qPxhl4FzW8HY?=
 =?us-ascii?Q?LBgH9+c3uc3/fhlTUVbCMXbh/1t40zBsDPb8ZT/4lviQhy6rxHKoqGBgyVQg?=
 =?us-ascii?Q?oQHDGB9r40CoFKSAgPb3cXoJNA44wbn3RU2Ei/j0BQDqxmzMLCWaQzCgoMHS?=
 =?us-ascii?Q?KhBDHwk6xcfcv121MjfKVuo0tU77dVGvacu8NdVJYC8a7XhwO86un1BV9sRc?=
 =?us-ascii?Q?n0VCgiS8erVKLY8bipVSyTunOWdFkZtSp3xzSEteabtfrg3jpm3hGTQH7MQm?=
 =?us-ascii?Q?STSE8IAPGVqEWVHPjFstFX2Qp0LAymcoAUQq9NVEKLnpx6zDRr5+mtYXAPJO?=
 =?us-ascii?Q?G0czoKrBJ1pd1QJD3hUJCl/wQ1rCEanDA4jniLm8Owc355JgVfZUdul/cSSA?=
 =?us-ascii?Q?uRhlVpM0rPArHC0auoH1A07PdsO7QhwbwvcOh1xbJO9u+sOv7jypDmktNPud?=
 =?us-ascii?Q?m8Eo9fHhequWMnnMJN6DESWgADVuqsR3Et0xrLZyfn36sS34WKqz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759fca25-ac55-4623-62a0-08de6fe2b631
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:14:24.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g/6RyEInvbsunOOtWFbOE+F2fzomZIv1c4z5M7h2kW8SFf961vqePbaQo+mWMm4F0IsPsiKlsDEAf39yEmudw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42882-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 2DFB416194F
X-Rspamd-Action: no action

Different subtests print output in slightly different formats. Unify the
format for better visual representation.

The test output before:

[    0.553474] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 202
[    0.555121] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
[    0.555121] ', Time: 1278
[    0.578392] test_bitmap: Time spent in test_bitmap_read_perf:	427864
[    0.580137] test_bitmap: Time spent in test_bitmap_write_perf:	793554
[    0.581957] test_bitmap: all 390447 tests passed

And after:

[    0.314982] test_bitmap: parselist('0-2047:128/256'):	135
[    0.315517] test_bitmap: scnprintf("%*pbl", '0-32767'):	342
[    0.330045] test_bitmap: test_bitmap_read_perf:		252294
[    0.331132] test_bitmap: test_bitmap_write_perf:		539001
[    0.332163] test_bitmap: all 390447 tests passed

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/test_bitmap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 2d9b71ad455c..2eed21bf4346 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -520,8 +520,7 @@ static void __init test_bitmap_parselist(void)
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
-					i, ptest.in, time);
+			pr_info("parselist('%s'):\t%llu\n", ptest.in, time);
 
 #undef ptest
 	}
@@ -548,18 +547,18 @@ static void __init test_bitmap_printlist(void)
 	time = ktime_get() - time;
 
 	if (ret != slen) {
-		pr_err("bitmap_printlist: result is %d, expected %d\n", ret, slen);
+		pr_err("scnprintf(\"%%*pbl\"): result is %d, expected %d\n", ret, slen);
 		failed_tests++;
 		goto out;
 	}
 
 	if (strncmp(buf, expected, slen)) {
-		pr_err("bitmap_printlist: result is %s, expected %s\n", buf, expected);
+		pr_err("scnprintf(\"%%*pbl\"): result is %s, expected %s\n", buf, expected);
 		failed_tests++;
 		goto out;
 	}
 
-	pr_info("bitmap_printlist: input is '%s', Time: %llu\n", buf, time);
+	pr_info("scnprintf(\"%%*pbl\", '%s'):\t%llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
@@ -1395,7 +1394,7 @@ static void __init test_bitmap_read_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_info("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("%s:\t\t%llu\n", __func__, time);
 }
 
 static void __init test_bitmap_write_perf(void)
@@ -1417,7 +1416,7 @@ static void __init test_bitmap_write_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_info("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("%s:\t\t%llu\n", __func__, time);
 }
 
 #undef TEST_BIT_LEN
-- 
2.43.0


