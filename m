Return-Path: <linux-pm+bounces-32728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B23B2E3D6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2897E5E5E62
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D62DC345;
	Wed, 20 Aug 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F8bzdeK7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F8bzdeK7"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F425BEF2;
	Wed, 20 Aug 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710328; cv=fail; b=PmdXsJ5MzijGO0NpY7jCSo7PE6xuVm4cguzoyZhDjQWZ7pkc3L/cugGcOoocGZMQRyA/92wt37TySjpxM0rr38SoUhCQqwI72e2InUFdn5nsx+B3t1SRosNxQMXuXpNaRQJGAdBKDdmBtX80hW4uo+eXgqGChUrJyH7NdTo7pbM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710328; c=relaxed/simple;
	bh=8ITwldPQE+LeDVn4klSUidMD5Zu1sVFjcf7GVqPl7gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pHzvmkW4zC7gy1mBcXZf+Louw3bjIir6MrMriSJNzJaaEgSHOkUX0m2nhEiLFz5g0Nt+HXlqyxL6JLKmjy7FaeLkIle6YMqe03C/yCbq0RXFnoWRv0sluDsDXkCdWTLPF44uzNk0mrz7aqgDuHJ3zPrPfFpEvGzedPMDrf5J3sw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F8bzdeK7; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F8bzdeK7; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d27WfPZZURJdLWd34ygF7x9aoQPSEnaFsk7lco4U2U7QArNie9dCUtngTt4yerAyirz4TiipON8D7L30fOXaVC9cJrrchSuBaB12GHm+irHAgAiPna/xGoacLypya9WJOEIIMq1ZBMQohe4UxXQk+xPGYHI2TDm80dCHOfULUcI4MlCyPeA2RBQ6kr2eD1csZGGbXPR/uYCkNn8a/xQJ0TKi6DBL6OcqS8o9Iz+RenRpfhJ+wgQ0UvGmK2pWJBL77RrvH1myIoSFRMBJSbnS7K5uzF6hHIFMagS/E2HcNj+vDtX/8ilRx1B/nFdieTyjBgK5rowGs171Bp4L4igXnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ten7+3I2CzEd7Pp1S4am9H+T9mZfG5d5evFbuWshDQ=;
 b=Yrc5Ta6iE/T6pCgPHqfDigo0FZY4VANxCav2CUnmiCX32G8wAkdl50vu6rjAaEnHlxaBHsNvxIGVbquUC80ZjQw0LavD4N3uneW/8rupbRuwuPMXwmwgJr4Fhd08xLMN7Vb47UAiCjnt2QlzZTjwMt5fc5dUhgWl7yLOQBrmeuz6tRhMSrNskxsC2NtH4/giAfHthrg8kIgZqkTxFA5kcYvX9Uza4P8FgKZvwOsLLcQEPiMl/Tgzcmljw4rmq78xvQcJjPYqIW+abhhDPNYYHyD+8MTVVAianSVtGqkNRD95T4bhhTq6jPUQJmb/R9nxAHkqbnmyTr8IP1XM1k8syQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ten7+3I2CzEd7Pp1S4am9H+T9mZfG5d5evFbuWshDQ=;
 b=F8bzdeK7X9Z+PONy+APV+UMbzCr8njWIuBGhLJC12mDcRxxf76HkTBHfW0V/mOVOBlrIbK10JMMUTdDBlvLhj/pmesgU336r60f9GZedNgyW/2uvZyoHdPCzT0kRoEs6NOzHr6I5Cs5aJp3rSQOBlWYsx9Wo19wNftGE5cnYK0U=
Received: from DB8PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:10:100::40)
 by DU0PR08MB8348.eurprd08.prod.outlook.com (2603:10a6:10:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:18:38 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::33) by DB8PR06CA0027.outlook.office365.com
 (2603:10a6:10:100::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8 via
 Frontend Transport; Wed, 20 Aug 2025 17:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhtiG1uP1Gp4vzpxOmluXAuSJBZEwoYiyx0C5PYYlKLw4Xgx7Fn/XVpPco7GnYiwRWY1AVtIUbLFg0MbrvbE2BvXLbgZZD6EhCNDFaInJf+gvlQWHcdkRO+L/6RQhpO/TwCy7jEj8H29mtVlyKH90wW2snj/34sm68RKf3yacDoXeeQiDi40416/SB4wxTgZBbNC6Xv4BCnGgJ9vRSdWUH/Gv5ZDcVEjIo6l2SIHYfeJDWjjwEe6qnYkLuMgP/gRY/puoFUrntoptlMLnON6Vler5eo0ctS45VeImAvXt2RUxD5+ZYQxva/fS2rrEg+d6j0LRUlgPkJrnF9ulTiX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ten7+3I2CzEd7Pp1S4am9H+T9mZfG5d5evFbuWshDQ=;
 b=a600bGY3VmNmGGVk/2E3HrojaR5tcDINqXNNjOyPuNexkdV2LZaSt2DSyvduM3mq+wh+JhNZoO4U/hglA1Dd9WKrO7sMzJwUpOY+VUwUy7+PhUTZqZLKz3YLvNqrNl3Nnff2RFhxjs5me3SwOjOIb8q/eFY+DafeJ98qPKYI/JD712woIjtuEHOuAhcgx7KEYH4K2WMwdizBnUDFe32enk35CSIPA8cZt6YWRpPcbI8qy2BLPJd8KmR0wKeG5hFijn8eTZC+eVktAB4yaf5i8f2CmJza7KJSXJUu/+pSVDGL2O96WyNMRWCT3c4xiWYh0nVfurWNnvQyHK20qLmB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ten7+3I2CzEd7Pp1S4am9H+T9mZfG5d5evFbuWshDQ=;
 b=F8bzdeK7X9Z+PONy+APV+UMbzCr8njWIuBGhLJC12mDcRxxf76HkTBHfW0V/mOVOBlrIbK10JMMUTdDBlvLhj/pmesgU336r60f9GZedNgyW/2uvZyoHdPCzT0kRoEs6NOzHr6I5Cs5aJp3rSQOBlWYsx9Wo19wNftGE5cnYK0U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB6442.eurprd08.prod.outlook.com
 (2603:10a6:10:259::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:18:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:18:03 +0000
Date: Wed, 20 Aug 2025 18:18:00 +0100
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
Subject: Re: [PATCH v3 2/5] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aKYDSOdW3kGlpkxv@e129823.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-3-yeoreum.yun@arm.com>
 <aKXlg1IMYUd7kQDv@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXlg1IMYUd7kQDv@e133380.arm.com>
X-ClientProxiedBy: LO2P123CA0034.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::22)
 To GV1PR08MB10521.eurprd08.prod.outlook.com (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB6442:EE_|DU6PEPF00009529:EE_|DU0PR08MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b0b424-5ce1-42b3-e3da-08dde00d9996
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?H2ESpCj3EaPVcKW5YIEjALu7+KjPMSDk2zS+h8d3jwondcNwmGeO1xhbVdz3?=
 =?us-ascii?Q?vLLOpFQVFp/rdeTT1iO6r95SSeK2GVfL8L4/P8f77iuHDUKBh/hEZ/meHKUZ?=
 =?us-ascii?Q?ZL1fSeTw8tThPgQAGTzpLonjvcV+48OQKwh5ccYCuldUWx+fnv0MIngiYtcx?=
 =?us-ascii?Q?K8GxKuY5kCZyR9yiA8yIEkNtiRk+jj4e9UgMdjXwplHFX2MTTy5aHXcbI14c?=
 =?us-ascii?Q?fOAjVntxruC3QVGkiXDZCyD4EEJ3VMSe6luFAWqRUmqob2uTMXLasrm/FQNz?=
 =?us-ascii?Q?Ufz7uLh0ydHy8S7rpZXe+BDI6VcPK02dVkh1IP2Xi6g85RIpAV0zSwF/xtyA?=
 =?us-ascii?Q?EAUD9piq3qgc2ojYry6qHosWWIQUp+k5EZH6TmLXbQHmS/qH6P7Faw0vGsHq?=
 =?us-ascii?Q?LZQJsjn1GZdBH7wEGaNJd9UfRH6R+Fil+u/uQ57Fgy95e+IJVf3aZdneno/h?=
 =?us-ascii?Q?J7cVzrTSRA6HWWiZSwPZsYOY+VLrReeE7ZkJu+4cNyfCEJ902+01q7TgkzCj?=
 =?us-ascii?Q?B++oUTDkpwFFUYuuqL/eonzSIH6JlcPEwzNsqWnxMdL9twTn2Hi+LK4IK5BA?=
 =?us-ascii?Q?bablK/GdHzTqhURWh3/lHszBn8AGFcCPrZCxx0SCn5rRjJddb2CLe8wvtXHA?=
 =?us-ascii?Q?IM8N0jCF0euZZjJv8BgERm8g8OeTCB4HJLrcSVaqbeH8jj02RHQkGcbxz2oI?=
 =?us-ascii?Q?R88KjFxZCTsBLDaspKJwrSfAaZcNBhxf6bkpJtbzrpNVV+dBgMAp4E7pPT6Q?=
 =?us-ascii?Q?uHqC3tMFnvGA4G+29FOJLK6a1DPVNdG2sOCk8LhTCHbONDpQMMUqtKo3ZGjN?=
 =?us-ascii?Q?YsvjG27aBzzl47gsNTV3EAHDEi4h+bsj+h2980wi730+ili0dg3qJnhUjgbV?=
 =?us-ascii?Q?lNmJ18+TVI/i9Bg519v7lUzCcdGfJQfKWNd/rYjT5QIWcdbEafDQqN4HFNzp?=
 =?us-ascii?Q?wqoJHA3QrFUsT5/FrV21724NN4fzSPAoQ7q0Ovo2RDyoxaWfRQjmeNe4XMjg?=
 =?us-ascii?Q?YYuVqtrNEiPUuMTPwh54P8aZm5r+FSV5Bs3TiURONYtmsRc7kJVPRlQKmV3/?=
 =?us-ascii?Q?QAuJJyfEt2+3BFA+NiseS9A+nW5CsaGfUppK+Z9z1AtB+Dircp+raA1jC9+R?=
 =?us-ascii?Q?J018LmdD3Myuo/+DAurtI/3j3eDatis+59O8YPvBHimWtw+GD7OqeOeFYhw1?=
 =?us-ascii?Q?gb1OsHsDZ50Zeza3PZHkDSaTAcr0pQtp8iab8MnypHix4HT56OsoKyGiZDGe?=
 =?us-ascii?Q?gzNybg2DV8bQTkXW9FwjFpcnorMKKbNm61z2lRK+1UUjzEI90orzQbCNs6uP?=
 =?us-ascii?Q?uHo/im11fgYIyFy5HyrOn65XemfUkyPe6Aio2EUaFFob9yknl9M1WgDyptiZ?=
 =?us-ascii?Q?HsN5fQG1hACGSWd27UIhVZfXYzMCK6tf2WSQ8x3O+V7PwCe84sYL31Lwg7zr?=
 =?us-ascii?Q?0/qMx2TJQJ8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6442
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e90d05dd-0d43-40c9-02f0-08dde00d8561
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|35042699022|1800799024|82310400026|7416014|14060799003|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QDnUNBQaITXMde05Aut2g2LUK+vqG74pibFGY+QGK5my0bD/sOw05bzQRfkM?=
 =?us-ascii?Q?PdYsoF26eCL4UkMusK9ok3wLhmfig0bGZinGclVrAQte7WNGXl3PwTBFvwlW?=
 =?us-ascii?Q?JYLt6k9209rl9LQBzakaozWVElpCtBpnDG8JHvIZ56X4xKxFK2Frc5JYyTKM?=
 =?us-ascii?Q?x6LNJk1xQHzmh3hjXSIBR0WCgu3iZ9T6ObcpjLglYIX0Sapw7pBUqkf5pmm4?=
 =?us-ascii?Q?wqZNxwjFD8JXzrD/5ePPnof63BqBW8as29pfesER/+f0L8Hz/9GZeqXsrsAj?=
 =?us-ascii?Q?zvXuYviLQAQQVq4tGlLuGhxvGWnivBV4cDjjZTpLREmNovSAI/UaOQV2kRyV?=
 =?us-ascii?Q?dLmpHuUne4eo2LMYVsJF4I9UxDmN40No4+FHq3HAfok72bG2ow12/aHXCTRb?=
 =?us-ascii?Q?TqQleRxV1RS2T54TSRltMCieMrOnusDqPqpy4l5TKCs9Vyf8nVJf5t5mBG9j?=
 =?us-ascii?Q?tDalRcpiys6f4vTR9gy+fsJ58QIA2aABllqoH1ccCqkBsDn7XEPDriJckhGl?=
 =?us-ascii?Q?3kuxxuETjSWLMraOq7kJRqOceyQI3wdFC2FNB7IdonThnyKU8DmaO43Y320u?=
 =?us-ascii?Q?+ZuYz132Mjjm1M8O3/6zRzhEta08/awqyKBFi86CgVNVTZKYCixKemTvt4hP?=
 =?us-ascii?Q?GXKgGAG7nplzxQ+RbDq1aE6JYV7dgR85cBNX+OG0JFfBIsJcPs5eew2rD/T2?=
 =?us-ascii?Q?YUSaL7SQKFdR3Zx0a8rMs3oqNQ+FTlrzyGCy5fqgd1zFXYu6ZicCxQP7JsOj?=
 =?us-ascii?Q?LU9YqFPbSXNxmxWhhb2CQhVLV00Mcxp6QyLchbhsrsM7b7C0dqY2EjnMKbyj?=
 =?us-ascii?Q?AobYpfT710RUB/HpLkGR33MpDq7aWsFGhxalgt/Am/uvD1Ow4rYMkA2eRq7a?=
 =?us-ascii?Q?cnQYyyIZiJ/E5YzX4XvHyoeE4jXn31NDr/yxdeZcFXPqf1D5ZHWwBTdeBZvX?=
 =?us-ascii?Q?7c8JotYZNCXY75rZWbkzqvzHZ3xRkJGUME1gi2uoAki7/gy87VXT48KTVRlM?=
 =?us-ascii?Q?V7r+hY6coSEgpyQa9EY8lJ21KlRFytUOppyO+axAYlofP9PFr4kvPx4Serx0?=
 =?us-ascii?Q?aTnhOSpMcPhNotjQPVQPvv0XTwZedqQwaa3iXOGR/fYxjxue/kPo+It+498E?=
 =?us-ascii?Q?0xMgchFjFdSK4zZhoU/ihV69D4ck4LNpKWaO6rOFuUqrASbGqWLsTzuz57/J?=
 =?us-ascii?Q?oUZXqfwcsEZxHbJHpd/RRDQ9b4pwEAnCLOibj80EvDWa0ZN5CvhpYspOWw4B?=
 =?us-ascii?Q?cP/SpCxbmzzaZHXeZFr72phXUDXf7mhqb0dAfH4fkVSA9kXwi/T0lEK/M+fE?=
 =?us-ascii?Q?wg+CqIIV8fo6MtjsdNLcS1Wpz2Ax+0lnZV6MtpReWWtaEYpa99u8sff6/4mc?=
 =?us-ascii?Q?+laC+kpDYtBkH0GWi4ymfHD6mkDjKJtzS+hPMNBMDEvDEhN9Tv857AQQIJ4Q?=
 =?us-ascii?Q?sADOhK1LYeKkSDP7nYiPkymS5fABRpBZ0EKGVYICE3dKW+HgvF2VEvS1JKJF?=
 =?us-ascii?Q?lpQGQ5tfoE6QAiPwpWpYfLXMBAQDSpglxQn7?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(35042699022)(1800799024)(82310400026)(7416014)(14060799003)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:18:37.1345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0b424-5ce1-42b3-e3da-08dde00d9996
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8348

Hi Dave,

>
> On Wed, Aug 13, 2025 at 01:01:15PM +0100, Yeoreum Yun wrote:
> > SCTLR2_ELx register is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4
> > and serveral architectural feature are controled by bits in
> > these registers.
> >
> > These register's value is UNKNOWN when it was reset
> > It wasn't need to be initialised if firmware initilises these registers
> > properly.
> > But for the case not initialised properly, initialise SCTLR2_ELx
> > registers at bootin cpu/vcpu so that
> > unexpected system behavior couldn't happen for
> > improper SCTLR2_ELx value.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
>
> Please note significant changes under the tearoff line or in the cover
> letter.
>
> (Merging the __kvm_host_psci_cpu_entry() changes into this patch is a
> significant change.)
>
> >  arch/arm64/include/asm/assembler.h   | 22 ++++++++++++++++++++++
> >  arch/arm64/include/asm/el2_setup.h   |  6 ++++++
> >  arch/arm64/include/asm/sysreg.h      |  5 +++++
> >  arch/arm64/kernel/head.S             |  5 +++++
> >  arch/arm64/kernel/hyp-stub.S         | 10 ++++++++++
> >  arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 +++
> >  6 files changed, 51 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 23be85d93348..eef169c105f0 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -738,6 +738,28 @@ alternative_endif
> >  	set_sctlr sctlr_el2, \reg
> >  .endm
> >
> > +	/*
> > +	 * Set SCTLR2_ELx to the @reg value.
> > +	 */
>
> One-line comment preferred:
>
> 	/* Set SCTLR2_ELx to the @reg value. */
>
> (when the comment is short enough to fit).
>
>
> Nit: can you follow the same indentation pattern as the "set_sctlr"
> macros that appear above?
>
> (I know, cond_yield etc. do things differently.  But the sctlr
> accessors feel like they should belong together and look similar (as
> far as possible).)

Thanks :) I'll change it.

>
>
> > +	.macro __set_sctlr2_elx, el, reg, tmp
> > +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	\tmp, .Lskip_sctlr2_\@
> > +	.if	\el == 2
> > +	msr_s	SYS_SCTLR_EL2, \reg
>
> Er, should this be SYS_SCTLR2_EL2 ?!

Oops. I was lucky when I test it. Thanks for catching this!

>
> To make the code more readable at the call site, would it make sense
> to have:
>
> 	msr_s	SYS_SCTLR2_\el, \reg
>
> ...?
>
> This would mean that you can get rid of the lengthy .if...else, and the
> assembler will report an error if the el argument is junk or missing.
> (The argument would need to have an explicit EL prefix at the call
> site.)
>
> (At the moment, the code silently uses SCTLR(2)_EL1 when the el
> argument is junk, which is not ideal.  Where it is easy to detect
> stupid errors by the caller at build time, we should try to do it.)


That was what I tried However, msr_s is also macro.
Unfortunately If I apply your suggestion, SYS_SCTLR2_EL2 doesn't expand.
IOW this macro expand like:
  emit(SYS_SCTLR2_EL2) // -> not the encoded hex of SYS_SCTLR2_EL2

So, I've used this way..

>
> > +	.elseif	\el == 12
> > +	msr_s	SYS_SCTLR_EL12, \reg
> > +	.else
> > +	msr_s	SYS_SCTLR_EL1, \reg
> > +	.endif
> > +.Lskip_sctlr2_\@:
> > +	.endm
> > +
> > +	.macro set_sctlr2_elx, el, reg, tmp
> > +	__set_sctlr2_elx	\el, \reg, \tmp
> > +	isb
> > +	.endm
> > +
>
> Maybe we don't need two macros here?
>
> __set_sctlr2_elx seems only to be used in one place.
>
> The isb is needed when setting SCTLR2_ELx for the current EL, but
> the code at the call site knows whether this is the case.  It is
> hard for the macro to know, and it feels overcomplicated to
> explicitly check CurrentEL here.
>
> I think it may be better to open-code the isb in the places where it
> matters, including inside the __init_sctlr2_el2 macro.  (Compare with
> the other __init_foo macros here.)

I see. Thanks for clarification!

>
> >  	/*
> >  	 * Check whether asm code should yield as soon as it is able. This is
> >  	 * the case if we are currently running in task context, and the
> > diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> > index d755b4d46d77..c03cabd45fcf 100644
> > --- a/arch/arm64/include/asm/el2_setup.h
> > +++ b/arch/arm64/include/asm/el2_setup.h
> > @@ -48,6 +48,11 @@
> >  	isb
> >  .endm
> >
> > +.macro __init_sctlr2_el2
> > +	mov_q	x0, INIT_SCTLR2_EL2
> > +	set_sctlr2_elx	2, x0, x1
> > +.endm
> > +
> >  .macro __init_el2_hcrx
> >  	mrs	x0, id_aa64mmfr1_el1
> >  	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
> > @@ -411,6 +416,7 @@
> >   */
> >  .macro init_el2_state
> >  	__init_el2_sctlr
> > +	__init_sctlr2_el2
> >  	__init_el2_hcrx
> >  	__init_el2_timers
> >  	__init_el2_debug
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index d5b5f2ae1afa..0431b357b87b 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -868,6 +868,8 @@
> >  #define INIT_SCTLR_EL2_MMU_OFF \
> >  	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
> >
> > +#define INIT_SCTLR2_EL2			UL(0)
> > +
> >  /* SCTLR_EL1 specific flags. */
> >  #ifdef CONFIG_CPU_BIG_ENDIAN
> >  #define ENDIAN_SET_EL1		(SCTLR_EL1_E0E | SCTLR_ELx_EE)
> > @@ -888,6 +890,8 @@
> >  	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
> >  	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
> >
> > +#define INIT_SCTLR2_EL1			UL(0)
> > +
> >  /* MAIR_ELx memory attributes (used by Linux) */
> >  #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
> >  #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
> > @@ -1164,6 +1168,7 @@
> >  	msr	hcr_el2, \reg
> >  #endif
> >  	.endm
> > +
> >  #else
> >
> >  #include <linux/bitfield.h>
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index ca04b338cb0d..c41015675eae 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -276,6 +276,8 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
> >  	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
> >  	pre_disable_mmu_workaround
> >  	msr	sctlr_el1, x0
> > +	mov_q	x0, INIT_SCTLR2_EL1
> > +	__set_sctlr2_elx	1, x0, x1
> >  	isb
> >  	mov_q	x0, INIT_PSTATE_EL1
> >  	msr	spsr_el1, x0
> > @@ -308,6 +310,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> >  	isb
> >
> >  	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
> > +	mov_q	x2, INIT_SCTLR2_EL1
> >
> >  	mrs	x0, hcr_el2
> >  	and	x0, x0, #HCR_E2H
> > @@ -315,11 +318,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> >
> >  	/* Set a sane SCTLR_EL1, the VHE way */
> >  	msr_s	SYS_SCTLR_EL12, x1
> > +	__set_sctlr2_elx	12, x2, x0
> >  	mov	x2, #BOOT_CPU_FLAG_E2H
> >  	b	3f
> >
> >  2:
> >  	msr	sctlr_el1, x1
> > +	__set_sctlr2_elx	1, x2, x0
> >  	mov	x2, xzr
> >  3:
> >  	mov	x0, #INIT_PSTATE_EL1
> > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > index 36e2d26b54f5..ac12f1b4f8e2 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
> >
> >  .Lskip_indirection:
> >  .Lskip_tcr2:
> > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	x1, .Lskip_sctlr2
> > +	mrs_s	x1, SYS_SCTLR2_EL12
> > +	msr_s	SYS_SCTLR2_EL1, x1
>
> Is this code only applicable to the VHE case?  (I think this is
> probably true, but it's not completely obvious just from the context in
> this patch...)
>
> Anyway, the pattern in this function is to transfer the "same EL"
> controls over from the kernel into EL2, which is what the block above
> does.
>
>
> The next bit of code looks strange, though.
>
> If we have committed to running the kernel at EL2, why does the code
> reinitialise SCTLR2_EL1 here:

When init_el2 returns regardless of VHE or not, it runs at EL1 by

  mov  x0, #INIT_PSTATE_EL1
  msr  spsr_el2, x0

And as SCTLR_EL1 is initialise by consequece code, and this syncs at
finalise_el2. and This will be the same for the SCTLR2_EL1
(although there's no modification of SCTLR2_EL1, but in the feature
that would be).

So, In case of VHE case, the SCTLR2_EL1 which was set by the code before
finalise_el2 will set this value. and it writes to SCTLR2_EL2.
since SCTLR2_EL1 is initilised for SCTLR2_EL2, this should be cleared.

>
> > +	// clean SCTLR2_EL1
> > +	mov_q	x1, INIT_SCTLR2_EL1
> > +	msr_s	SYS_SCTLR2_EL12, x1
> > +
> > +.Lskip_sctlr2:
> >  	isb
> >
> >  	// Hack the exception return to stay at EL2
> > diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > index c3e196fb8b18..4ed4b7fa57c2 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > @@ -4,6 +4,7 @@
> >   * Author: David Brazdil <dbrazdil@google.com>
> >   */
> >
> > +#include <asm/alternative.h>
> >  #include <asm/kvm_asm.h>
> >  #include <asm/kvm_hyp.h>
> >  #include <asm/kvm_mmu.h>
> > @@ -219,6 +220,8 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
> >  		release_boot_args(boot_args);
> >
> >  	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
> > +	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2))
> > +		write_sysreg_el1(INIT_SCTLR2_EL1, SYS_SCTLR2);
>
> Maybe drop the "unlikely" in this case?
>
> Compared with context switch, this is a slow path -- so keeping the
> code as simple as possible is desirable so long as the overall effect
> on performance is not significant.
>
> (It works either way, though.)

Okay. I'll use as likely.

Thanks!
>
> Cheers
> ---Dave

--
Sincerely,
Yeoreum Yun

