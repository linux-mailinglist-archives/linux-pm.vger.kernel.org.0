Return-Path: <linux-pm+bounces-32729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D004DB2E3F9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28AF6828A7
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03034165F;
	Wed, 20 Aug 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kcjc4e6J";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kcjc4e6J"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE4255F26;
	Wed, 20 Aug 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710623; cv=fail; b=sKc+HX+TcNpD3Ng6HGs9ZXP6mYaGiJXnfYxdFiH86pZmq+qtWgbRUQafigy28t+9WZbOxv3whcCMYzYYqpYRkl0oKGOR+beTZ2JbwyW1f2zJ3g7U5oTGvdSeHIm0lkhAD3Usfw7+OuIbLrKKtB1aGgAoLRJSxWOEBBeNgFQF1fw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710623; c=relaxed/simple;
	bh=ljtAJjf4B+yFVwjTyOuxuC1XpkJt+5k9zNqHVWDJMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t9ypMg+mUja+JGeGNEH5x0BM55zhgcuxtJBa2R8yFlhmmfacU68YU8mV2I2CUNK4sSgPCjWhZ3+N7ibMmGLuf1suSN89za30tG4WAkWx2K5qQB7ui3BcdxUQsPONprqfkQLJbriVCgvTCjK/hs2Jzf6GW1S73UoYoqdSF96sOtM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kcjc4e6J; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kcjc4e6J; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VvkZaXVA2PuEvxYKxOYK7J8fRkZSm2BHqZUxpeJGXo8pZYTdMcz7p2SxrqFZbJUJi7iIXMY9TgDRmPIeCypJ37Nax5maxWfXU+3qh4Mb9Fv5XByMPQMebzP7XRIFFtpL2Mivco0hK/UGamzOjwYunnLn7F34dqdyg3lmzs29scKKQAiVW2v+a6PsyDYxg6RXQJ8lOi2K4P7V3mzACQbMBYbdNAIwT4+O/eFhgmJOJu5S5/bUOA5KV7MmppgqYFCaxeNt3jtluOqIBdnKMYLR7LOyailGfmmKLz6qGtMSTKkC1uybFCKd5Yo+g5P0II/JpM8VCP2xxGfZqfYNgdEerg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nph3a5WnQs0jOv1fzKNsf4irCvrU5SJR/pfkiCHp+/k=;
 b=vuVlx/RqNBhLmkFx5cnHSDnJg6BQruDIenCuARJJ4MtzQA1TCBhdRgSqZlN3SasOUuBQkTaz3HGiNUjhohx+IIp9YX9FXXZhBw/JRqv6ZFs5a5UWofjHN8IniofQCxwAARPT0RlEa6xdvtRjW22yQnLeqCz+7nBcGLQ0Gefaf+3BRrN//7PFR2bzBTYGbcAAl4tiyxV7S5VrdTtIRpJeq7oZXjunPZNuH9tmmQi1d2MCEHiyvhWIUmpm1zX3MGeGLk9Msr4jfpnaBdwZlJPqjJejCTib3deFJhgH7X6hmrdWtKeaq6nFKFDB+eG/lCGriqIPZGJswOW6Y6w1TMNbBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nph3a5WnQs0jOv1fzKNsf4irCvrU5SJR/pfkiCHp+/k=;
 b=Kcjc4e6Juwx6dFNUWZJwIAHbym2wB74q9LrpB5iYdiH3+EKN7wCvXPkE+8OCR+6aZ4PGz55RDSJxHdoOSL6q5+IuxZwJquXwo+4TfzfFbRx/SGUpXxSR00cEAqq7VDECn8rClsIiFP6eshg7IpxMWHxNsrupboQhpwtxN7WrLpY=
Received: from DUZP191CA0063.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::7) by
 AS8PR08MB8733.eurprd08.prod.outlook.com (2603:10a6:20b:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 17:23:36 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::43) by DUZP191CA0063.outlook.office365.com
 (2603:10a6:10:4fa::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 17:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBjuzWMiy5LIQWl/O8uTUinNcC2y5g5WmQc67Iw7tAgJeVBPz07aPpyFmgO/zszsPzwclAIh+HRe+3DpzhV80Cy5smoeGXmUqoSocjjM47cIL9sEP/fWwioOWX2OjlJf8105tOGUei0LOi61e+A7YsQdlOqLAeX+DAJu8qlLXusZyfJ7zYnM0qXNyHrn7f2XuaF/8nTFoBnA5OPlGMUcQu7sElE+ILC9uXKsq1b7dYJyLbjEoz+y7qDHaP/HiE5UVgtHj87NzkdDwrvEV8wtxHO3MDGbUMAnLhUk4SYChUEkpMEqYhtUpauex3nI8vpBCP8qsIKABrdeOXComuuC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nph3a5WnQs0jOv1fzKNsf4irCvrU5SJR/pfkiCHp+/k=;
 b=c6EmcrJnXrtwN1NgIJzyUrKzaMXlshBWQo1ZfDrJXzDxXZVZp5+kf/8h4VLMzyQfnCEU6zj/7fNBk+rPdhwcWkfcT1nmToEE+/pN8YcUiE+04oCyQUqTMIoJf3sgIFR/nbdY+EYdSFc5BkNGJHF5tsLtst1+fME6eNz+l5zbso3tNOELp4uY7s4MFjs9srpmrfSWGmWcS2yxypzXEajtiBUFjUrycEtFyDqxpmRNOjnYUPGgXOO5exR4jDnldiw9UbHZiqsqO9DbCo0VdGsyeFq8tEphi89z9biiZFHw1LmL3SkOYSPTv1OOtahFrPUrrbnF5RjXPGDipkNDFiT6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nph3a5WnQs0jOv1fzKNsf4irCvrU5SJR/pfkiCHp+/k=;
 b=Kcjc4e6Juwx6dFNUWZJwIAHbym2wB74q9LrpB5iYdiH3+EKN7wCvXPkE+8OCR+6aZ4PGz55RDSJxHdoOSL6q5+IuxZwJquXwo+4TfzfFbRx/SGUpXxSR00cEAqq7VDECn8rClsIiFP6eshg7IpxMWHxNsrupboQhpwtxN7WrLpY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8924.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 17:23:02 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:23:02 +0000
Date: Wed, 20 Aug 2025 18:22:59 +0100
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
Subject: Re: [PATCH v3 3/5] arm64: save/restore SCTLR2_EL1 when
 cpu_suspend()/resume()
Message-ID: <aKYEcwKODLsevnTj@e129823.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-4-yeoreum.yun@arm.com>
 <aKXlkdHeBo+erWcB@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXlkdHeBo+erWcB@e133380.arm.com>
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8924:EE_|DB5PEPF00014B98:EE_|AS8PR08MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dce9b5-894f-445b-511a-08dde00e4b9d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?OJ7KJZT4jz4/8lCXyD0jDYM5ZCDLQzhflUZLwTbq1PRlEfw43CyZbNsjh1L9?=
 =?us-ascii?Q?mfWjQnTgctdMGMEVlYVH025+rsGsO2tie11bDEmx5JXgRYr5r3auX1lKrNRt?=
 =?us-ascii?Q?BQuVcjWUrPTbXrOgs+k18+IUTv6FmqTjfu1r75hb4EE7HXNqoT44bwNGoLAS?=
 =?us-ascii?Q?XXeSMdxai6UjpPZGIPY5+K85Km/PRyzAZxlIM3X3DwEyXn8q/iQVJP7CInvN?=
 =?us-ascii?Q?a+ZKNrQmJ7Q1fDA+d0VtvNHUsNYooTaE8joc3qpR99Xiik1W6a3rjUTckB91?=
 =?us-ascii?Q?t8wFbaUB2zScjosWHQ2us6zxQtWBfh10gHBzvrsXw3lSMPOa7snyalDnvuBW?=
 =?us-ascii?Q?Y9E6nySbLD4wZqIffKyFJ35Ylu6MhImdPJ1pJ0+cTf8cWC0r3fXwNLa9ih5S?=
 =?us-ascii?Q?xenwAirp8+RooKySXupuHzJk/+ytWZd8JXacqpsq1lk1/Juz8aKdz5QwHHaU?=
 =?us-ascii?Q?m9WrDS5/blrElW+0m9HyTwsHbuMnwLQDMhB7joS60S+poJtd/AU827hOFfYA?=
 =?us-ascii?Q?F4dcKSD+OBdpAagI5U6LOojuraYREo5TJgBqszbNAO8n0q8pBRVxNwsQJPaM?=
 =?us-ascii?Q?uiVPzW0LAvRtD0NKnN7+0RFvcI6MfpVBT8DhqmnRPU4tziSnJBKt3lfL89Ea?=
 =?us-ascii?Q?Z4IYgVeuVTdNYOujbdB96DVrcfd4VzZQH1zUWLWGaIqpkOAqu0QB7/09nWBp?=
 =?us-ascii?Q?MgiYoKU0o/WbRorkKalQ2UacAF2ELB2ZqMswJtkfJi0+EofsNF/pYlxUdqvD?=
 =?us-ascii?Q?2jl03EVUbic7jOCM6ahmFvyKcq64uPtE2eGlAtodRgGKDTxzsXM4opddn7/i?=
 =?us-ascii?Q?XZ2+1PlOAOv5oPWm8Kqe6Y2+/jGGWV6VAixymkLy+7ZN/3XBMmEFNz2CTVu5?=
 =?us-ascii?Q?xk4XRd/8z9jAgdZZ0VCYb5a8C/NZav0oI+N2/8OLf8JFMd0yrjf7HxEmzuNR?=
 =?us-ascii?Q?3IjCSaa2/OmOVy67KR7CFCSz17BP6wKadoX3DiikQRvIr6ku3G5U+5vByi8u?=
 =?us-ascii?Q?QSp0daUvQB91GjWEk8dQTPJH3Hc9vku85YrVWRFDD/71EtcdFoQ0ukSAdVap?=
 =?us-ascii?Q?RBTiVm96nYDQXqkX5t1ef1yeBCWMWUt5Zq2mcVTqvElxbhJIVU9YM7XqAJez?=
 =?us-ascii?Q?FO2HrdNOQSLgRbIMuSTRfxCNk849QGJKJBFM+me75QRoix/BTIMbxOmWmFvG?=
 =?us-ascii?Q?krLl3QNz4RsYT0mqf7YXTVaU9ZKX1EhBQJdn/EP8WHqkbyK4sWkLNu5q7f84?=
 =?us-ascii?Q?nhKHLC0zJHmu37i3ikniXCrL8ykTYYrPzSxE2W3A1hwzsThiYVmWJ8FDo6YJ?=
 =?us-ascii?Q?hNfIh7/UVyX7er0oThz3htznNdJnhV3RLmf0fzRbRJbrXdfr3HuHowjmPhug?=
 =?us-ascii?Q?0ZFeuZeG8Ac4h464AJOfjfsAVwFMd9r670xgsLlWJ0l0h9iJfSJ6Xdyrg1Xx?=
 =?us-ascii?Q?ZXP0gPw745s=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8924
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a68e2277-dc89-456e-3ba8-08dde00e3756
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|7416014|35042699022|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6AWhh7GuOsnAM57+RTW6+gq3+kntqUN3Ym6r2eOSVBDRwPU6Fa0J0x9mp6n6?=
 =?us-ascii?Q?YFB5maTX+PINwzcVmhEBWHzd9dSy6iTAKqArU+QiumLdNeyICy38GlX2+tY4?=
 =?us-ascii?Q?CUpzBL7kaWgi34OTHJSCdvE2EVxszGU+3/GU7vGUD8FDpaRtJJnoe4B7DtwC?=
 =?us-ascii?Q?QDr93AkO+TWBfOEz2thCe8uEVu+kt0sYzgogLN+JgB1O32B2w84hDP0iucXH?=
 =?us-ascii?Q?BFTXt2ruzzOCmE1RNQsYoo2bKJJAWluss/bboHEkYhVsaYj2KAlVZFi1yoyW?=
 =?us-ascii?Q?4WHQpzPO4cQCcxLQJ0GwSwM2Ii+o5csi0GUFGU0pIQSoU4uW3YG55rZ9jK7K?=
 =?us-ascii?Q?nuZzeblymSwdzut6UNH4bkmpSW+cMeyL63Z+93tLT7d1j+q7P0H4PbNHV+Er?=
 =?us-ascii?Q?YYyuv9uL+ieiNqqVktO6+dbIIHAGOlATfXJZG2FaNiT6y2XHLXpgv7OLCc9T?=
 =?us-ascii?Q?Dfau57qsqMHcWq2jvsUhHtE4P0v0qwGmzlHnQfBj1R5uBcL4+3/v1ULNZn3I?=
 =?us-ascii?Q?70SAXlT++LJEQ9bZa8hgJSsg93IKY1CTd3jiOuMWdo5cENd7bulXKS6FqG8A?=
 =?us-ascii?Q?ExSktxCqYCs8QGiG9XU3+pu99R91BPiQuV+m3zUMWyzJ4qKP0iMXugEFja5q?=
 =?us-ascii?Q?OT2r/8ZRdc7J7SxNqLRsd7pltj+zUUIToPP83orLmv5zOuP+VbAEEA4ssq/A?=
 =?us-ascii?Q?crqkZkrlVKeI/MoaI9aRPcRLKsUOkMiNif+7blOjCL6wrnewqWFZEe68YeVP?=
 =?us-ascii?Q?VUjM7xSqpBfdjn/C9EEgJl+qCBHHsL4+81MVgfRADQ5FQTzLYW3R+UKi8/QM?=
 =?us-ascii?Q?OWGhcaG6Q6a2YbZxLrjtQ3i63ffdpxpeg93QsphwueC4aVu60bEeIGkOGdOP?=
 =?us-ascii?Q?xbMZvBLkNceOR425n1hgNIcaqpF3W7B/heAJmMIRP4hK13fpysxg1Z2Ouewr?=
 =?us-ascii?Q?i4wtjLi77Vhd1j+UJ9Omon7JuUcEqfJ0WgvHjyH/NrHCc2A4WrMjhto8XO1C?=
 =?us-ascii?Q?jk3RXvC+dmHSKyh9OPkIM2Dp/McktUYdHEtvFMWw82DLnOsNAWmHzeflKBTD?=
 =?us-ascii?Q?LZgGFfOyCvBOH6JctqyuuYru2CWIm4oZ/W7k2Vze+oKnNbC738wVFrA0NlBv?=
 =?us-ascii?Q?eBt2C+vqptS+a/1f7nKLijZuvgnzVE5O3TWP35kSzuTUN574j39c0nzRyGSr?=
 =?us-ascii?Q?8lHjpfMTHXCu3mnasyBQgtPyCZfZq9tEwYm8GNOUrtfJhk227nYJbN72PjTh?=
 =?us-ascii?Q?4qwto1nXZ/ay2xSh0ESmqj7oNrQk37swFDZmPiaduRWbWyq9zO6Wl+IPc/Qh?=
 =?us-ascii?Q?eI4ckMlevXCgb3uesprykdDL4qJ1286dAbkLp9WX1PIswc0RituCa56S1gXu?=
 =?us-ascii?Q?pmpjp9+R47PvKzFmm4FD8bq5JPLwJB6unZomcYwEv9EqRWUIwOfpk4APaTkr?=
 =?us-ascii?Q?r2PNrgifavpBZMrF3e63sOs+FLpoU0exIMFzyG2WLNMQwpCveREEfADpQ5wA?=
 =?us-ascii?Q?vQBw512oGQryTFcOpdC5eLL8eJ3FTY5YWRIr?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(376014)(7416014)(35042699022)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:23:35.8261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dce9b5-894f-445b-511a-08dde00e4b9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8733

Hi Dave,

> On Wed, Aug 13, 2025 at 01:01:16PM +0100, Yeoreum Yun wrote:
> > SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4
> > and serveral architectural feature are controled by bits in
> > these registers (i.e) FEAT_PAuth_LR or FEAT_CPA/CPA2
> >
> > Save and restore SCTLR2_EL1 when cpu_suspend() and resume().
> > so that configured value can sustain consistency before suspend and
> > after resume.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/suspend.h |  2 +-
> >  arch/arm64/mm/proc.S             | 26 ++++++++++++++++++--------
> >  2 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> > index 0cde2f473971..eb60c9735553 100644
> > --- a/arch/arm64/include/asm/suspend.h
> > +++ b/arch/arm64/include/asm/suspend.h
> > @@ -2,7 +2,7 @@
> >  #ifndef __ASM_SUSPEND_H
> >  #define __ASM_SUSPEND_H
> >
> > -#define NR_CTX_REGS 13
> > +#define NR_CTX_REGS 14
> >  #define NR_CALLEE_SAVED_REGS 12
> >
> >  /*
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 8c75965afc9e..f297bea7103b 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -87,8 +87,14 @@ SYM_FUNC_START(cpu_do_suspend)
> >  	mrs	x9, mdscr_el1
> >  	mrs	x10, oslsr_el1
> >  	mrs	x11, sctlr_el1
> > -	get_this_cpu_offset x12
> > -	mrs	x13, sp_el0
> > +alternative_if_not ARM64_HAS_SCTLR2
> > +	mov	x12, xzr
>
> Looking at this, maybe it can just be a nop for the !ARM64_HAS_SCTLR2
> case.
>
> (So, alternative_if ... alternative_if_else_nop_endif, similarly to
> what you have in cpu_do_resume.)
>
> The memory used to save this state should not be accessible to anything
> less privileged than the kernel anyway, so leaking whatever was in x12
> does not really feel like a concern...

Right. I'll change this.

Thanks!

>
>
> > +alternative_else
> > +	mrs_s	x12, SYS_SCTLR2_EL1
> > +alternative_endif
> > +	get_this_cpu_offset x13
> > +	mrs	x14, sp_el0
> > +
> >  	stp	x2, x3, [x0]
> >  	stp	x4, x5, [x0, #16]
> >  	stp	x6, x7, [x0, #32]
> > @@ -99,7 +105,7 @@ SYM_FUNC_START(cpu_do_suspend)
> >  	 * Save x18 as it may be used as a platform register, e.g. by shadow
> >  	 * call stack.
> >  	 */
> > -	str	x18, [x0, #96]
> > +	stp	x14, x18, [x0, #96]
> >  	ret
> >  SYM_FUNC_END(cpu_do_suspend)
> >
> > @@ -120,8 +126,8 @@ SYM_FUNC_START(cpu_do_resume)
> >  	 * the buffer to minimize the risk of exposure when used for shadow
> >  	 * call stack.
> >  	 */
> > -	ldr	x18, [x0, #96]
> > -	str	xzr, [x0, #96]
> > +	ldp	x15, x18, [x0, #96]
> > +	str	xzr, [x0, #104]
> >  	msr	tpidr_el0, x2
> >  	msr	tpidrro_el0, x3
> >  	msr	contextidr_el1, x4
> > @@ -136,8 +142,12 @@ SYM_FUNC_START(cpu_do_resume)
> >  	msr	mdscr_el1, x10
> >
> >  	msr	sctlr_el1, x12
> > -	set_this_cpu_offset x13
> > -	msr	sp_el0, x14
> > +alternative_if ARM64_HAS_SCTLR2
> > +	msr_s	SYS_SCTLR2_EL1, x13
> > +alternative_else_nop_endif
> > +
> > +	set_this_cpu_offset x14
> > +	msr	sp_el0, x15
> >  	/*
> >  	 * Restore oslsr_el1 by writing oslar_el1
> >  	 */
> > @@ -151,7 +161,7 @@ alternative_if ARM64_HAS_RAS_EXTN
> >  	msr_s	SYS_DISR_EL0, xzr
> >  alternative_else_nop_endif
> >
> > -	ptrauth_keys_install_kernel_nosync x14, x1, x2, x3
> > +	ptrauth_keys_install_kernel_nosync x15, x1, x2, x3
> >  	isb
> >  	ret
> >  SYM_FUNC_END(cpu_do_resume)
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>
> Otherwise, this looks OK to me.
>
> Cheers
> ---Dave

--
Sincerely,
Yeoreum Yun

