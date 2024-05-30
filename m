Return-Path: <linux-pm+bounces-8424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3A8D4D17
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66047289827
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3576817F504;
	Thu, 30 May 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GYOC1Ru+"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2034.outbound.protection.outlook.com [40.92.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5917F509;
	Thu, 30 May 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076818; cv=fail; b=aLU57A7LtLjbjo7k6He3Xt74+6GyL2CdS2mGTtpG+gor5oDc711efT+y91YCXPinP522CaUxhQvdqVDmCk+IQ81dSjco/EyPux2P0MHax4i814tL5t9xy0YCQzYotur9uWWoQbEM4DYiYJvf+7vMGNbte6MXIYEHFYvpgPa/I+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076818; c=relaxed/simple;
	bh=3YruPonh07HsQiyBUO9v6yBv3eseoDsAjzaLMK8+yKI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pIRoRNfd2kXjEC8zdSwdb9a/G5t4u1FE+gmu6P3mZHUKkoJMKTEBkICffI1Yk3xM8aBm/RTLJ8dq4fUH6uWQGpLkydvTALS4FA9KltAUFfs1C9sVDq7z5A/F92OhTVdTb2MMVDXmGSpEMDS2C6kLvrzY/XBnOS59Hm3rFLWw/KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GYOC1Ru+; arc=fail smtp.client-ip=40.92.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmqn3DpWWkOK3xLGFeq7CaZkvvy8hBD7+t8yoeEzx0KPBOy2Nx0IekjHVCe6jquN+uR3l7omy9IUzjJPa7tM9p3x7HCuGot2vyj8W6FQHddyFZ3CfeKqX7tJg48nGAfTLOMnIZFI4r4my87eJ60QrQBmmjXKJPW77JN5lJFDgMepKYgpnrr7KPhivyWNoszkDiiXWLeHMF4q1nkjcXWGmzfeULbqyGtX00+lzTUZBlLu+7y/DIJTk3gJG0hyc4mn19SCcbQ2W6je2iHbsGXWyG/lNl50ZHYfCYAtozIlgRNHlKcJebfhzBEO3iJz83YEPwDjHlKGWsj5/RXxEWLUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY2OC8shRJHLKToGEXDWJISBYUeLJYfN0yd6+/9+hAc=;
 b=bEfxWE9Nr5vm11tgwX4GKz0M7jgY8olnJTuaDaeZKlFk0tVB5QNEyOie7gdAwF8WAT+WcgO8vnkV3TKSBxsXtYwPj9e8/FkleHERQqy3NPTADGMkIVPCb82TkuuMyt4+Q2kLBnfZRbQMX44N+DTUAuJay07mHf1eqO8pCYPetEDP0vNqerRzRuvN92QYXFJivTPE2etj2AC2ORVYhxPtDla7x3rddxbZ5GFKxT46VREWK9p5awXTPFec2688emZ9NNGYIfrse99mYMCfP+TrGMJPUQi8Roefgb870m+g9PddfHeAcmb2TkWpjbHutKw/d+6ZOiUYPWYWcagP0NbioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY2OC8shRJHLKToGEXDWJISBYUeLJYfN0yd6+/9+hAc=;
 b=GYOC1Ru+v1ZqFemzKNeDbVF8KHp8fwKEQfiHH2/aZIMZQAhDU0H9LPSrCpIDefkWV7naxIvIKLwprGYbhdhEAMfJKtEs8r4UtEFFW/fJiUpdiiPwcr7sGUp8UgdJQzaZvNmOMjWTLSDguDnrHJWfb61O2kTKF3kLB9jxvG+ad6qoYtgLooVAUYRpvWgU8Hce9ICCGz9idxQfyVYK6JcOC5NmdjBk1QzPaXJmbYFGBt43m1s6MbjeqHOLECEXZv5T7RnLB2El+5KaybQ/CzZ6so2hnY8DF+D05RD/WUWg/iCvgiYE4eN1kUOCgPDIlAJ1Szqf8nnTy3xjG2Wl54k7Aw==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB6008.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 13:46:49 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 13:46:49 +0000
From: Haylen Chu <heylenay@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH 0/3] riscv: sophgo: add thermal sensor support for cv180x/sg200x SoCs
Date: Thu, 30 May 2024 13:45:50 +0000
Message-ID:
 <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cQ3jW/g3C7Q1BfwcPDhtIk1/9H67ozDB]
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To SEYPR01MB4221.apcprd01.prod.exchangelabs.com (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240530134550.53088-1-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfc1afa-a33e-4838-5274-08dc80aef483
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|3430499023|1710799017;
X-Microsoft-Antispam-Message-Info:
	636ijNjdk8rygGeLAK9skaIS3f3kqQcu+SLuKI/0n1HxBFzbA0HHkeS/+ypAX4bJAo/YnJUEQDNkCqWGPK3sk1BByJgv0Xm5E4BiYTH9v7NHq2v6c4f9oCgVUljxchw3SlREwGGOL/IQXwmM2z7U0LuoHRsq/aR9ojgUq/ame2FzVU7SrukBmwSr4kPDzbq9ArESED8oiYkEkSBmvS5xUB4U/sp+AXd6nJ0oPlh6slLlbsTGi199U1KCAEWRa7+JjAvr0c1a0dsv7uq6U+H/8sWcUQzwqnSYWECvvp6hDaSHKUJNNK2SvkW78hcuZuBSudOwJs2uD/Xi9vjBGh6FrlE6a+Sh5w7mCfuUS3zL6Y3uGNJc0BAOSE1nVPHlKrp7oHi7DeLKTvNWbk3S8VfW153wEWnl8MxbWKMXQdHZH3NmtfPwh/rmrP+IwG6hdVbKtDFzzZYEYtKNWbn4VaI3KlpAmNQvCXYM8xfaBoKK9PpNnafIm6kJpLxpZv5U7d7ATLlkA8XyBQ0vcn/+Z6XEHL8Uo2ResRi/M3FWID3h9lOxa9ZMmBBZAK+UAeG+2HwwXlFKSqS7C0T4R8/YnhaqbKBX78L+3unfVFpMLb7gHow=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/yrEv0iZ/BDMkd2VE/RaUd9jrRPOjH10WsBUUCGw7sLsEjiNn9IYQoXakXse?=
 =?us-ascii?Q?A/Zb9qoVIiVi8Y2xe/Aok1sBISZG6xxfQj43A9q7y6QP8Q5CzTUz3SwCDVSE?=
 =?us-ascii?Q?5h/cvGdhi/w/TGrUgDr41wHhjw9/TWT5ww3JWJI1xATM30S9A3itiIWmzWcV?=
 =?us-ascii?Q?1DD2gsySmqJTvzYRRTFEBRJpCfa7H2GJ0goPoPNM3iJLXNYGB3yuUb86h0SQ?=
 =?us-ascii?Q?WDHbu12PypwVTaNQr3vet1gLpOfCcJzE7bEfIEXRnnj+wZ7vXRNJGc7wbQce?=
 =?us-ascii?Q?8nRWStndZYCGSG5QC3PvCK1S3pa4VjevPMbgUDETs7hmSJokTySMm59AA1lu?=
 =?us-ascii?Q?RHrh/EZf7sZ0iQK+SUoZSdh++HSh/0fwpGBI4c52bhXVZ3tROnw7CxSXAAwz?=
 =?us-ascii?Q?AaX2EKJQx6+BqPzCFAsisdTQGr8StAEHNiNTjtdlk0cLO8x/LKa8NwMBvFWA?=
 =?us-ascii?Q?E0vq3Ezy2W+SQ/rkeAgOxxu7k5oDkWY8u3M+j4pukgq93p/OAqGbHl4kFKD7?=
 =?us-ascii?Q?0amjmEjt+MFnNWPojnuE4BhHP0YhPeZWnyHp2SD9klA18BMZzeVQbYm+cW18?=
 =?us-ascii?Q?+vzSLhvY4uwJeWyz3a4UVVc87wzJPf4FfCboX+PkG+tbyHPL8hn/djjggAqM?=
 =?us-ascii?Q?j1dMkV4DbAb/lcSC05AMY7PzfYsmB6YNaW6olsXX7Hr1A3rVqQEcG/OkfJ1/?=
 =?us-ascii?Q?54REPcXNJGaYu4b4CDiwFqLZaNtN2+OGbMx5CdhacjUeNVj9pyZMWv488iKQ?=
 =?us-ascii?Q?oTTR/FfDPVNFgI1o1B6+753uK4eopYpLdgtmLA+otf6X1unf7NUZawp5PyGf?=
 =?us-ascii?Q?r3cw2UmFeIlDegiNQkqcJca6A6wUWmEXTosWFOriONdtOsMsndsF6ac9m3Cr?=
 =?us-ascii?Q?48A1cXRxq1ZLuo9mi6/7F/nDEhb/89a7X7U6pjQutSudb0F91mQBlzpi00gP?=
 =?us-ascii?Q?Rmui/GuDW9LF0I+BlMjVMAJmU0+nWVz/6p3eGsusixFkp/IchjSKzdboKu9F?=
 =?us-ascii?Q?l3Q5c/lcJIY0Dogg62aBJjM0/T3bQ0m3g3dJ0+zSEjim+ZFGnKgRmjnxsliw?=
 =?us-ascii?Q?w0vv/CHEneL4Akkkx5p/GzdUIj6JVhDsu+8gJhOEGdUsisPWlpvnHV4WfpC4?=
 =?us-ascii?Q?AshNnW67P+AQh294UfRwH8q9wJtbQKNIYJ7xspGJBzFN30y55FuYZkejm0j0?=
 =?us-ascii?Q?xoQOQGksbRRTGFtIqUgKecG1fr6aABw6nQaQ0Onga42rBiyjPoD8BbT0V34?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfc1afa-a33e-4838-5274-08dc80aef483
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 13:46:49.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6008

This series implements driver for Sophgo cv180x/sg200x on-chip thermal
sensor and adds common thermal zones for these SoCs.

Haylen Chu (3):
  dt-bindings: thermal: sophgo,cv180x-thermal: Add Sophgo CV180x thermal
  riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
  thermal: cv180x: Add cv180x thermal driver support

 .../thermal/sophgo,cv180x-thermal.yaml        |  46 ++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |  36 +++
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/cv180x_thermal.c              | 210 ++++++++++++++++++
 5 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv180x-thermal.yaml
 create mode 100644 drivers/thermal/cv180x_thermal.c

-- 
2.45.1


