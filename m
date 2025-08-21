Return-Path: <linux-pm+bounces-32798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB4B2F4E9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA97189F7C1
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DE2F0C40;
	Thu, 21 Aug 2025 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LBdlyClt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LBdlyClt"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931A224225;
	Thu, 21 Aug 2025 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771289; cv=fail; b=Om90yZm1/xovApAR5M7s+diQSsw2BELgqWuZQxE/u8bvETh7crNcPWOH74szNcPP4XJtcpWAT+kRUIDk50R0a1ueM2xzOQ5GzCE3UmxYuoslYfiqcp6e3S7rVuaxHffPcj6l0DdLgwfZwjfWQfWA7gv9QXW9HG8zHC79bRU+li0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771289; c=relaxed/simple;
	bh=u55nPSqzDgHGNheegBYeWOskFlQ2rumq+Z+EsQigOuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sHyNc7z548P0AVBn/UmkDd1eZcPQdcx6szBykpzWtO/TL0fcvNceDytp3X9d3kpbW7eOKpFDnp2YRYdPqHn7zyavhCO8EpYuxYXKsbLjBrVnEuRjmhHb5x+VHTGz8TQRYgFfexPS8ZWwnPemQByiI06crlFSd/iuFt/9I4NbGSY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LBdlyClt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LBdlyClt; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sA2NhPefSoOTwRWsVwwTDE3dPQ11WawsqmkYCKEiBwG32Gj2Nd+sYg1BG3VCoVZJoL1Rja3KfScOEG1RJIAq64zvki4MC9trx1wHUlnqxPIZWUNeoN5G3zS/uuQ2RRtxg3kh5HbUXsAATkunJllpe9JQEWRUv0cvMDPNnoZ0td1iMnwYZtM2H4dS5wkydaS3rgeTI2utVtFYVU86LxAjpYtYjiiQ1DXxuoji5dNYocIpUmvffgR480QwspAxrcJVuk15Y8Dxu+O65gfX6iaPe/kV13ME3Jopt03uMpnmqLHw4odHAT7dZ+0p1FO71KC8hHW2XqnEgX+kGNOBD9dXGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcNJydDGWrnq0yv5mmGU57GiL2w5vFu26ohlIi/6SI=;
 b=rhmQNhlNiYgNSGraMbVgs5AEqgCplIo6O+aWAIMJ3vPP9fh/w+hFlps0W+nnAu2MaMFs/4qJjWbjQNTC5UDmxE3E15jxnKhBaN3PXgtou2xeOQe/WVk+csprtY41whWCP7NTXM89SF495MEoW7YKn2EGYbrmV50j1S3TKStcC0lT9pR+Qjo8hWK0m2mFd6Tjvh0Dzwle3W+IrIIfXbGGDpSTqM8mMpXdil+TVERcUBwIlCsbRPuJ6c27SY5XWr8/+0QMlk0PZLDJFZdM3YP0KGZhb3YTVWMrl6c0fu324B3UdCofuSCIeiu5bKFRGITk9lYBpXjd0f9AigR/iifinA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IcNJydDGWrnq0yv5mmGU57GiL2w5vFu26ohlIi/6SI=;
 b=LBdlyCltNf1uqkpilM10Jl37YJDBZYRa80Nh9uXHu8ytiU0oL2nUF28EB2GmZKeku/IohPt1Ci+MItAApXoOfBL5UXk7BhRO4R7rKGRgqTh5AtTrc/ejdqGpZUB15UR+i+3RAVs0+XTC/WjOQdPa4dtBShHEIxbJ6Hc1ayDcjEg=
Received: from DB9PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:10:1da::20)
 by DB9PR08MB9945.eurprd08.prod.outlook.com (2603:10a6:10:3d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 10:14:41 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::da) by DB9PR05CA0015.outlook.office365.com
 (2603:10a6:10:1da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 21 Aug 2025 10:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Thu, 21 Aug 2025 10:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPRvXS1sG5NUjEtSlw2+HBe9pJZdtSBWQGrSsPYEj0LF2c3KQlsdX16WrJX7OPGgqX1OKgY1GPIDxMo76TW/C7YVO334NEctd23I200Cca/565kfVJdbZdRTgXPWBb60TFjsLR1ZMMTN+jfAVatJGQO4SkiYYNgtYPw/ftmAJfdF0kYMvHvTOIJlcTfa2+bi64rBdhrnIGKZPZnGPFhnIlu6OZW9zyitej0TGa7VXDq/Ctb6A1h7KOhA2BMhhJld8RsnQ/xp7DAb/tw9lnH756qaOAw50xPxj/Lu8tet62kIUNT06UKPHEeiumezWiwtVQZ2xtyVJUXwcJyb4MqJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcNJydDGWrnq0yv5mmGU57GiL2w5vFu26ohlIi/6SI=;
 b=GL951S9ALKx8u26+on8yQ/GSWX4Igj888+IRTB5urEKrvLWeFrAIBpW7XLuatxpiruw7239y5DlgA2JkZoNfBmS+s4rYfiTng9SOFKN4jthjL1LUqOMPMY3YGz2tVmP0a5t4WuhQXiSLP7RT42i+/fCa+7ClbIqm/Qm+22cCGj4XjQfQrABmUuamUpN8TYW4E0JfiRRDHD5DRNpFTZbMRLst5YBE6Xmdi9b197BZzqLx3Ifq8yUgda+7zGCnQuEuoEOkOwP7RP2+7EM8F9rGTSzCYqtGokcOyDGHu3DClKRMHmxB1liMrluyJkL+kR3cR0STG4WPyzacjweeJqc8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IcNJydDGWrnq0yv5mmGU57GiL2w5vFu26ohlIi/6SI=;
 b=LBdlyCltNf1uqkpilM10Jl37YJDBZYRa80Nh9uXHu8ytiU0oL2nUF28EB2GmZKeku/IohPt1Ci+MItAApXoOfBL5UXk7BhRO4R7rKGRgqTh5AtTrc/ejdqGpZUB15UR+i+3RAVs0+XTC/WjOQdPa4dtBShHEIxbJ6Hc1ayDcjEg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8037.eurprd08.prod.outlook.com
 (2603:10a6:20b:573::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 10:14:06 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 10:14:06 +0000
Date: Thu, 21 Aug 2025 11:14:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Message-ID: <aKbxbCNW8JNBEh/3@e129823.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-5-yeoreum.yun@arm.com>
 <aKXlnZ8HXHBZMj4T@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXlnZ8HXHBZMj4T@e133380.arm.com>
X-ClientProxiedBy: LO3P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8037:EE_|DB5PEPF00014B89:EE_|DB9PR08MB9945:EE_
X-MS-Office365-Filtering-Correlation-Id: 5960d588-97a9-4b17-250e-08dde09b8b09
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?lkW7gjnhCyTYj8h2oIgSgl2ZH2t9tgi0CM3Dar/dF1qgpe4Fogpk4oi5bNgu?=
 =?us-ascii?Q?gCq7972aLnNiS12B7okm4A6Hs64067AkED4KheSmd7DcOtUcrjScP1QWhZZi?=
 =?us-ascii?Q?neoHzCHz2aJ0QKdaMJnqpK7WhOo6TdC88tOmyzYJQWqYO0aCwPS6auSz2hKl?=
 =?us-ascii?Q?mUcifBh9D+nNIu1LJZgQSVJOrPly4fgQ+HsJqisSxwVIej8DhsMtCMsNL5/b?=
 =?us-ascii?Q?HOIRHpRu39V4Sg9QMkkuA46ZiI8gPn/v2+dyjJ1w29BpmCVje+R6YBWiS7kp?=
 =?us-ascii?Q?FptsaMM5Uej2h99koWwg+zb32jW64CdcXdPHOz49d5s8gInKE6iN26fPz0V3?=
 =?us-ascii?Q?KV3ega1p+H/X5q5OCVHAaYewZMWUNBMSKal0ODdkfrAQxbWwiBmSEF5Ho9kc?=
 =?us-ascii?Q?naNUAEQ0Ptz06+yNUDovniz9LJe4vctNPAHZHvWXanGG763srUfvESiH//hR?=
 =?us-ascii?Q?KesMI0JEvBwaLLFU0hVqpULuAzsvG0nWeXkVDyMVVSdltRsMa0Zva/r1Q9t8?=
 =?us-ascii?Q?CRCNOK9I8ryqonrdF+JK0tJl+Q3E1V2PawW2NzMmncHq1yCRoV0x+I8lwL/S?=
 =?us-ascii?Q?G9Nk1Rx2/oB8v/mxQmWhrJIaeuPk1xUHXR4anl4UCPlcnpJ0MTxGaHfKE+7K?=
 =?us-ascii?Q?6HDPNR5eC525W/9x7b6O403tA9RatXR6i0qcPnEt9rCPI79GZ6PsVPZP/yH+?=
 =?us-ascii?Q?UN9yPO1OtnjKavjGmRwi1hKWQsBJbXU7bcE5JRraGymmKJty58EJLJ44upan?=
 =?us-ascii?Q?VTssRBE+e3hjlBjLzmUStUj1bMuB3AHb7M/3TU2djI1q37JZcACXUqUOtvXt?=
 =?us-ascii?Q?yZeSE/vY87iALQyM8j1+B3fSFvqe8xOb1e3s8bKEhMOPZd2j5u09TH+U8MXb?=
 =?us-ascii?Q?DNLGtoVDmPj4SHgBjwbq4ylBn2UXXtHNA67keZboajwu5V/6fJw+xiuGQWgT?=
 =?us-ascii?Q?mcrf3nP75mOLUFxokyXdZhVOuWfzYn6ij/l2/XacO54vXvsbDvj9LrTE+92C?=
 =?us-ascii?Q?j5fTo4hrwjdMW55OoCpbE7vbspjwKZfiW4GMTwXDQaa28ZvhODSZHx2TR2zX?=
 =?us-ascii?Q?Rh7DEfSnSX5UZ/ORlFwwrRMwyIxvYxWQFzcR6zvbDE+2BCC6PYPnOiBhh5Zt?=
 =?us-ascii?Q?lagPA49FgmnTdNRptK1ZAN1E8s7r0tIuXvqOhq8wG9l7oE6e4k2Ee5CG7H1e?=
 =?us-ascii?Q?itYTPdaRV08JL8LdipW0dT3ZYJr6YFxg0ehW3DXveaeZGc2pY6tLcv8wdIRm?=
 =?us-ascii?Q?ag/nxNacjy5P7KLH2yECZxl6Fw0yycC239NV4FTGnQvkert2mlAjKIMZ6LmL?=
 =?us-ascii?Q?+PwDOmLRc8v5RBcI43B0h6DUHENCOsWixTEHV5o8QTXpew5qEFqfmKFLDv1H?=
 =?us-ascii?Q?/HA/H2gWDlOvze+a4PeecUkPQhZPDVx0D4nnZ5kMcTRGwhMZJdRfy8Pexnkj?=
 =?us-ascii?Q?wvi05k2W8hA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8037
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2f183a27-397c-4c69-61f2-08dde09b7627
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|7416014|376014|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vb5UBDM+O2HOg81cB4OMNXnVubs+FPHDnOBT6dj2wd5/9z8mEbzApOpXWbC6?=
 =?us-ascii?Q?CsMT1+arICjau2bnX+iK5nj8OMS3c/Hr1J5+HZF9LPxJxfQKjAKs2TvaVPro?=
 =?us-ascii?Q?EbqZDggDMkGPjMAx4i8EL/hS7K+nA49AruBYrR1JfoOQO5EPqttbsJeCjBfG?=
 =?us-ascii?Q?ddZzrbhomsFCs9VNduh87KgPK71nY0Ck41wmYvQ2AibW7bj+40DotJHlkE71?=
 =?us-ascii?Q?xPt7tJSRRJMa7QFYYgBVohUB+p0jSD0JHQu9xIewdTV+YOrlmh28p1k3w48x?=
 =?us-ascii?Q?j96gWM1/yurmil+fX0oRGFNOsedEWVO7F8fo+jkrwwDIWSoRiZlSCEsG1l82?=
 =?us-ascii?Q?ozOYXa6GOL6as4P6Wi/G+sFizBvV4krtzgpw1ZqcQXB75vxFCzIA4/msAxH+?=
 =?us-ascii?Q?HAUBj+nhgycazy2aBlw1H0co+aKhNFcPa8sBZ2JftsbfPJkQdlAB3fw5odGl?=
 =?us-ascii?Q?ZO/z/JFprgFHFt39PKi96urx9lsq7nXzpwIWUXLzG4LCuZP3fD3C4c39ixtL?=
 =?us-ascii?Q?vbDJ2DRhMzTbZvZPVGqdoq7wJgfXYRoDGbx3d165iGwy8ZLzFO6Gp5kVnyfn?=
 =?us-ascii?Q?WZBRP3GPwMzaY2YyetzWCbu8Horblqq/xCH0yh9HJQ6SOV4FJggOdqzfx95J?=
 =?us-ascii?Q?n7wYp8wGdM2kUa4UjtSVUTpJzaFBh15FQNo59kw9/J35FuTMYmJ/GyRLZq0C?=
 =?us-ascii?Q?kB6mCQpl+Lc53lqvsrVjs3IgJJV2jHArrfRoW7B5bKRBfZaNTbiYg3oay+nK?=
 =?us-ascii?Q?NUaFvU81jAe/mwsaXiS2+r2tjUkjvZSH/nLMuvV4sdE34lzu9FykisiZLMvQ?=
 =?us-ascii?Q?UMnCuEKFRjtaMxTGnjkzrOTETyBfWHUBAcLAsIGF18AwJApl6PDsn9IW2oPY?=
 =?us-ascii?Q?gmj9D5XKN9SahuBjbrbiMUtPvmhfMHQsArO9yuwHv6YEb1S7V/9NcsVwy38f?=
 =?us-ascii?Q?nPyzl+AWGRuY0rOj8hUCGJw9UhlC/Xxmv6Qi1a5TmaRXlGc0XZpuIvx/II/9?=
 =?us-ascii?Q?T/Br9Qv8c1+EyJferabJPjxvfg2MY4u7VvXLymAKvl43W03hJBaaIgc3UIz8?=
 =?us-ascii?Q?2tsw2kB97lKjK0emUvUZCZ+5etRog7uTVxeb7QNiFFPilqS5/KTDuP2XbuWM?=
 =?us-ascii?Q?U9GneuTMYJzunQm/Eb/0abQY1o7beVq/nto1HiV81Roae8F6ZLDYy9H0nPGR?=
 =?us-ascii?Q?fxNDIGkvB9vuNx3ECVVwswUsq3xAJypUgeHGv3kXvrQ/TsPVPDvwZz24/xzq?=
 =?us-ascii?Q?xgxWPjm1Yi3FWOW1I93tKiIkBvfOjyywr1bFw3yQ31wQqib/yadJqjwsDUHx?=
 =?us-ascii?Q?qmDs6rDmb5VIWnw9aDeSVRoXxcxpaRuht2g3l8odzGjAG/7tl1ttkbHxOlyW?=
 =?us-ascii?Q?aaSuyG4OaI7gAcy5qcNVUz158/NVfJXOhYOfQVKwO1wRRYx75AbL87I8ZvXv?=
 =?us-ascii?Q?C/x0RrRBuHvz8x5oTYhCdkw07BGpb1SMNSht5rlbtR27Up8ByUB2kxs3ICup?=
 =?us-ascii?Q?Xj0pr3TT0nuUmsaVWTtdH5snDtLX5sYA1sUq?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(7416014)(376014)(82310400026)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:14:41.2669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5960d588-97a9-4b17-250e-08dde09b8b09
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9945

Hi Dave,
> Hi,
>
> On Wed, Aug 13, 2025 at 01:01:17PM +0100, Yeoreum Yun wrote:
> > SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4
> > and serveral architectural feature are controled by bits in
> > these registers.
> >
> > Before, launching new kernel via kexec, initialise SCTLR2_EL1 explicitly.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/kernel/cpu-reset.S | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> > index c87445dde674..123564af345b 100644
> > --- a/arch/arm64/kernel/cpu-reset.S
> > +++ b/arch/arm64/kernel/cpu-reset.S
> > @@ -37,6 +37,12 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
> >  	 * regime if HCR_EL2.E2H == 1
> >  	 */
> >  	msr	sctlr_el1, x12
> > +
> > +alternative_if ARM64_HAS_SCTLR2
> > +	mov_q	x12, INIT_SCTLR2_EL1
> > +	msr_s	SYS_SCTLR2_EL1, x12
> > +alternative_else_nop_endif
> > +
>
> It would be better to do this based on the ID regs.
>
> Although the previous kernel _shouldn't_ have used SCTLR2 if the
> capability ARM64_HAS_SCTLR2 did not get enabled, it would be better to
> enforce a clean state here for the new kernel.
>
> If so, maybe one of the macros that you already defined can be used
> here?  (But it's also fine to open-code it.)

Ah got it. I'll change as your suggestion
Thanks!

[...]

--
Sincerely,
Yeoreum Yun

