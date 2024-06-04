Return-Path: <linux-pm+bounces-8572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864A8FB2F9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 14:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE475281FDD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F1147C9E;
	Tue,  4 Jun 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U13jcXgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2062.outbound.protection.outlook.com [40.92.107.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB89147C91;
	Tue,  4 Jun 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505604; cv=fail; b=klcRulsNdd0F8khbDWbR9fr9aUo/3yCia6Y8PgdT2uq3UcIT6tHSTk+4Zc5rA0cxYTTbS7MUfT+cx0lSnMLOI8H93VApwoj3mGoi7uhpTst5y036/OkkJa/fw/l9gCQ7AyQgWB5ArkBzC3KOPY1I/n45hfEsLh+C8zRuIICnKFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505604; c=relaxed/simple;
	bh=6z6RDZlpP8Ikel/3sNieKU0tNHFYItjerYZWAxSNtvo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qFa0m0A4E2Omxxlu+EYr9qQWhcxlyDLc6CgGDzlgkiQD+uwhdfqfM0db2fvmlgdEMNkevu9NT3ogVah6I5s+CbaWH02TFS/QZKCQoMMnH3hGU/s5jSoDGocfiMFfBcGjXywOzzUjcgNq2XvhpdJH5BrPWmXyN8axqliL1tt5s4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U13jcXgb; arc=fail smtp.client-ip=40.92.107.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC9OU/urPwyV47SHq9ZCZA5vnhWSzZOYkJlTf2wv9x+wBLJC5DsvV03/ftnoM7FsXK54i+BDB6RBaZRiXyQS7ncDH/h5nD3KgKJxBycproFI08FXnutvhHloTumOBTuK7yuh05nhTnYYKm1eK5uYmq7k4RAMGfxaRzSmVczGOMWkV710cenEwkiRUULr/ox0tSMCRPe2QV4HRPZWTw3LE64PDav4qN8i/QPWk7WqhZLMQ0pXKRHD6cnDTwGOt8+PmofXT0o+BW48nnCMkGOvIqzKqaxTLSnRPfqWyjNxs4/kfF0hJ1sC87Ea3pzGgyvoaNYkOXXQMgfQ9XHoqZSA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1cNEbeG1wdPdrghu/oHKokJc7AylRp/n1AT06GG5/s=;
 b=DCDoApOreR9ZQarjCSsUrc6VdBaGa5PxE/Qq/3XGZgrnB+6h1VOLz97zL7A0q6Y5dqJRgo+Cr6LHsHmWRFbbz6FIR4mHXjesxz1xnXbX1c9y8QLy2NE6TdQcLr2IipzjvqXXGCfIqWaeEK4TDpfbI0fEL7LG+Ema/VwPcE1O6e6PR1mCHq8bGE0LcmvZgj1MQa6LM5P/3W01CiGMlyZeb+bCzVRpjfcMwnupBNoBXfk5+/85tO1rSbfxqiBam0ohRmjWa9xLWJ990497QUpJPoaN3MBo0xJuoC4YU5dgLCt2txxUd1TgR8+xC4JqsUfzzqSBf7HNgBWdaOJpVpqCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1cNEbeG1wdPdrghu/oHKokJc7AylRp/n1AT06GG5/s=;
 b=U13jcXgbqtj6YCIrqjvmq/v0Y0gMh6DWagX1Sn9NBsbGgPfTax8w8CmyK5ed1MIZIa+wy1GENRJb2u2rurO6v4RDheUKeHlyH+NwWXxh9MxcYK3h7KDnV0aV5MRo0Z3yo9vAqGksE9E9/rrIPsycN04Bs8HY5bGv9JZgff11/5PDg6rZKQYy5aXK1jdMll7dIXDqhs52gV0w8ESxQV1p8e46HUFE9CcR+4qlAmWZCYVz5hfUaZQWbrPwn9OZonNSbd4hkOqQiM5KyDh/MfrnF38CpuEK/O6iALnpbobZtUnM6/9NXLwq4U8HnhrYoV2l6mtfqLblb5V2WQ1aahsvgw==
Received: from SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::8) by SG2PR01MB4386.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 12:53:12 +0000
Received: from SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 ([fe80::7155:e92c:291b:fc1c]) by SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 ([fe80::7155:e92c:291b:fc1c%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 12:53:12 +0000
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
Subject: [PATCH v2 0/3] riscv: sophgo: add thermal sensor support for cv180x/sg200x SoCs
Date: Tue,  4 Jun 2024 12:51:43 +0000
Message-ID:
 <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RGPwRmNW0xhNYHbvPyk+wFYN+hsaXf/g]
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::8)
X-Microsoft-Original-Message-ID: <20240604125142.22298-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB4218:EE_|SG2PR01MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e5a0d3-632f-483e-01d6-08dc849548b4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	5Eal7oXGwZhiFIcnZ13C+bnHkFrB3GrkxHuPG7slUya0OItEDUTTaJKrd1NGaUVQB34NYOHHBTS//Lf7SKrW3vXYlFfEty+20ux5CeKM2kvVvXFHDpiYsVr63ZTy/Z8MdmRkIwBEv0EPypvADGKg1gGu4odzzdhviY5C+MUQTBvoZ6P/jnTlteqiEstUC93utnueaasYSdcml4aMPUCtMWwAlCFCFU0fAE7uKQBPV8GdkHf2zh8Zq843LhI3Q/4poMbThG+ysicpTJ/NfAMEnTCNowDbEOieeGoE4cSp229LJIyhVmJ9hC1LYohjKLrBHvX5tUt2qjThos9/GLmfRW0fhB0i+feWqti4hIEWKFFNbRr2XqoVm/sd8RK/RTx4F7BbNcyAksgo/ROSQu3E6X/uvFcoOAJEfYO4A60cCV+ucb2nAMpN6680dGnyMQmloqzqNPCrBqnjfGA7DG5ZDrhmSgao3/1XVtjoixTYJmWCoOagTy4Y5vpocgZ++rGbYeHNAlLv1R52i19Xxr3Li02/oG/sNGLBYRyxewWka/XJggVCwApSlEbsg5K2Q7tMBGgSh3jyVkpceDDs/yXHZyu6tdr/vbwhcy9qb/cru3A=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coSOwDVY2DyVawXXANUPCeCo5vuaMlgTpYESkhG+wVHjSOQJXhA+HoKKLbpm?=
 =?us-ascii?Q?sB/zpjiFl9BIOOUB5P27+vsasimunoXaVqsTxCyUuviWP4m0hWdyO6E1ODKI?=
 =?us-ascii?Q?VQaCST9JIYSGEmPwH/YRgX3ywNoUYuEzpvNALyngkzbAGx6qyQnS8MQDIWL8?=
 =?us-ascii?Q?UdTwHTtw8+FzRtOjEOW252NPFcA604sobrMgpsg3O47ZQfnzpaU1d3wCpUJk?=
 =?us-ascii?Q?S+Kibrgq3jAHNlqd5G1hidUrjdgnzme9uzSBAdwG+1n5d4JPtxA5uZbY1y4F?=
 =?us-ascii?Q?IiMc88jciIByLdT9vvyKgkJ4M3Jd5LGzdiDN1kd7PHxdosNEQIbEWUAsoNO5?=
 =?us-ascii?Q?y69Z/7rH9Yen52laauhT/sBHyMb3OQViBVTaxDBu05MTdYyDIjZpzMljqwPa?=
 =?us-ascii?Q?CwUC6/AHJ2Dxo0ny5pogoAIm+M2E7lI9PXHIhF9OtMR3QmdQacniyIVohz0Q?=
 =?us-ascii?Q?peL7MJL3paRVwfuPzxE5r2yN2dCY8YfqZRhywc3sM5NUmm58vzMC/Rud/6JT?=
 =?us-ascii?Q?ToK4n5ZNyUgAsytvzeypiwG3VM0oI/ASL47txqhlO1EQ+rEejtjQghrOzW/x?=
 =?us-ascii?Q?6zVVSGzcqNNLjRyxbajdea0WWjZ5t428NjiqZAwDNVVJCgou3q+dPGw6szkI?=
 =?us-ascii?Q?jepWtugwm8unqpvrLfNOoLDqkkxKDjEc6UV8NC0bw4b48ZmZjR7ZSjtOnG5k?=
 =?us-ascii?Q?kX41t55m8WGJFXAjTr2fjHnBRG2rU7Ge//vyP7BbO+MqyH2TTRVFViACCV8J?=
 =?us-ascii?Q?yWIcR33CBxAVR/XjygxhTwR+rrwIYI8KYA9tdpzap+58nbFHzx4Sd/KpWFf2?=
 =?us-ascii?Q?LIzvfirRdtFPd12HCikKi5iZc3HSMk6y6NrdXgGcF/50SVT+UxmXB1lB96VG?=
 =?us-ascii?Q?w21CA274ETvi/QBa+aDqsOPukaf4vvjnUDsbnBiDBqh50hvy27X1t5ZFANNz?=
 =?us-ascii?Q?ndvenzqEW0U/+JnqM1GRwRV2/2rRJQBaVpFHwR1DNR6oeHKhzyEnOS0wmiAX?=
 =?us-ascii?Q?HxZ1oCb+pjSn1tuz1ajX1mWAN61ISuiQ69LwyL6jxxUFvjvXePIIS2kN0yyl?=
 =?us-ascii?Q?XRZb7KwmBgrE1tcYzxba5WJjN0KZcix9UH3jQNxY1J22kq+e7ZOqCCXTzSXL?=
 =?us-ascii?Q?8rZoyGRXlgIn3WK26RDNV2l3rq5HVW++/NLsAaD+PL54jjTdYGmwQiFpz2/O?=
 =?us-ascii?Q?L2IvPOdXekAiYRwwBpGqTZojyXrgHGM822pK4H3QpFL0hv3pZopM4YFhkaE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e5a0d3-632f-483e-01d6-08dc849548b4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB4218.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 12:53:12.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4386

This series implements driver for Sophgo cv180x/sg200x on-chip thermal
sensor and adds thermal zones for CV1800B SoCs.

Changed from v1:
1. style and code improvements
2. make sample parameters configurable
3. generalize document temperature calculating formula

Haylen Chu (3):
  dt-bindings: thermal: sophgo,cv180x-thermal: Add Sophgo CV180x thermal
  riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
  thermal: cv180x: Add cv180x thermal driver support

 .../thermal/sophgo,cv180x-thermal.yaml        |  82 ++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  30 ++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   8 +
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/cv180x_thermal.c              | 262 ++++++++++++++++++
 6 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv180x-thermal.yaml
 create mode 100644 drivers/thermal/cv180x_thermal.c

-- 
2.45.2


