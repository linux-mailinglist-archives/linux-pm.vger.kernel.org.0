Return-Path: <linux-pm+bounces-9000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C02A904DBA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CF81C20A7F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DF16C6B1;
	Wed, 12 Jun 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LsFIWwzU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BA45948;
	Wed, 12 Jun 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179939; cv=fail; b=tNcBGpKIGzRY5QZc4hKaI+OJtgrf3jpk1sZRqzY5qrN6Dz2W2BNDpX8jEFdkzWz7RwZ/urZMG+BrwtKppnzqoFDSUhc/sM7oI7mJkRao1/ivcfe+iw6kgGq160JCIo9kGBLfwWDNID3SYMUxO7KvnBJ6JwM2HAOnXDnln2LUpSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179939; c=relaxed/simple;
	bh=u8opVFTucgBWlVQ9QovYBXf65OWFF0pzuflaPgoPQeI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn3pYTY2C2cEkF9YC1hz6dIph6qR75Z5qgz4TjA+iuZ4KObxBl9XF2i43dqil0HQz530X7+BKDhwkzif+g9o5ikwvwkf66G2V10navyrr/WkcAlGy3wwYeadtE5FVS+b50iuFMVQKHPJjOcwExH45+9qN4u/GHsBKWFTZkvsL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LsFIWwzU; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaESELf6Zi1nwByn5UgtJCzwntLSOz0vTRvyn/dphAmilMfnMTxf1mrCRtlJVd3bUljCrcKOEs8cnNQKvLq42/apAK1U041eelHYHg53v4JvL8XVShd2yjAJNgQCkf4fvzyQNgKiSniTSgl35G5Ak1HrOmSvv7ij/P/eMwuyosW1krFHUIRYuYbbCCaQ0X1cRSWNPGFJRa+BZ6n1hUNK77SqH5COanurT1QCB0yrCtdWWUI7ptSxnQNi38DYOELJNh0Se3h/BjeiCFeUjLNQVosv1DY2F1C+U+9/81mrPN+7lS59/WVMHjDHPRKG78F6YXTx24+pANQScIzITSi/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTyM3sqKI/xtRqAewFQpg+zRzcfjQWnUOoan6Mfc3pQ=;
 b=ivXJRda9t6eAtPKznCy/PIX7znhCOY5d+B/50vAZaIEZGHQ1fja2XCaT/pBAEpPtUCef7XkZGs9uUrM4SV74chBG4Nbe0Pnp8hSrybXF3JYr6w42aFXO6eHLt+g7dblE7P0E4RX6tSsW+aPX8s3Aifxi4bppxzowoKmtkEXfr7JgGQ5wRDJyHW2+VNFI6/WaZvfQ6KOXEagKOU3Ud1qXfGhFTJvKWjAi3QGA8ivuUZn7uog7LbyWPAmVBIxsUxlEqoT9pknQ6XJ2ZYYEU4DJv8JpeHmZ5RDh0tQdW5Uut07+zWIg12W+nYVmiHi8D7+6bdNwd8P/rlf6rR1sAcePpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTyM3sqKI/xtRqAewFQpg+zRzcfjQWnUOoan6Mfc3pQ=;
 b=LsFIWwzUC/lTzHF7UYpJaQnqqr5F8HnTEaX1gYcAGktAN7AbjC3Z/PiYD3Cg3maZwQ1GGKMWFgIiHUiUwk3xgl6jzyw5Yq3yyoPBm96+tZXPcuRjm5fAwzi1eAB+nXZDXXoM7OGkrf9ouFkYeqK6qJhp5C50INJk4TYH2w7tN+c=
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 08:12:12 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::b0) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Wed, 12 Jun 2024 08:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 08:12:11 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 03:12:02 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] Documentation: PM: amd-pstate: add guided mode
 to the Operation mode
In-Reply-To: <6e960ad57d31d379f8b0b631581b078fb9b272ea.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <6e960ad57d31d379f8b0b631581b078fb9b272ea.1718095377.git.perry.yuan@amd.com>
Date: Wed, 12 Jun 2024 13:42:00 +0530
Message-ID: <87jziuzijz.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e91f17f-c001-4fc0-70a9-08dc8ab75c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|36860700005|1800799016|82310400018|376006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhrrHO7ImkvPD3dRCmp8wUCuHJhOQ2whBRxoIR6KdlSkX7C8hvhXwSUv+THn?=
 =?us-ascii?Q?jcJ6sdvFD16EijkM8m6ItSl6yEsxFeZRofqyLW3Est4q6l3ciMvNQsfE5lOr?=
 =?us-ascii?Q?RI0StdGZPKbTJF9pB0TlfUz5XsJPXPrR0b6IPFgbYdxVMzYotR+Mmcm4wjcE?=
 =?us-ascii?Q?YuEMRKtKFSUJDYQLIdb2oxioFPCjoM7T1uSYK0Fc+7nYnYsjuoRVkCsyAslg?=
 =?us-ascii?Q?fVqeAEUA9ynt3nKb9560ATzcc+/mHr3x4XehIFecj0YSyKMaHhg6Km81pFCl?=
 =?us-ascii?Q?Zz1ayOukv9WSFVUhrQmby1/zWApX3df9VmFy4aa8JK8gNok1PzGrMdqNxvvZ?=
 =?us-ascii?Q?/N7vCMahChJL1ftnIketA19qdE72nQG5qs9HoJr8m1/vp0Zw72Q6CyvxELqg?=
 =?us-ascii?Q?dFFOnBn1pUQGuIwgbEGDtxfZ/6hJWnfYmdY78ep0cEroTGu3zIcUkywsYBws?=
 =?us-ascii?Q?epJWfm7UJp/GQMSrU/epIjeP2fA4PVTKenT9UzNOGgDCrm5z0HSsTUMBUxmE?=
 =?us-ascii?Q?iXqNVcSHsfEybGOnpGJD7xCZ0yWc9kUATpMVe0LVrU9qaqBJdmgv/kG9APgu?=
 =?us-ascii?Q?6HxD5RkP52XNqqucBdsUwf45N3QIP8uv5nu/0gQGlihCGlgDTtZkVa6cgIn5?=
 =?us-ascii?Q?/67mTbW9zx0PaxmaYS1seaVUgtZpi/xHisRorjLkRoZLYV5fygbKJmjd+0cQ?=
 =?us-ascii?Q?SzyE6zRiTrp9g1L8W0epn7olVayi5MKEVpnXae2TtZVns0HCzSES1dAULWC0?=
 =?us-ascii?Q?bUVj3SxweipnraHSxag0ZJC/7U6HHSLhFQ0Kk0TQvu/Y8PWNesNEHBxmi/ay?=
 =?us-ascii?Q?qfqYzl89BKUO4d715jRRlURr/J/92fV7xwdFtAFxP6farn5s0tPbdhkWgePe?=
 =?us-ascii?Q?SEIDn+VSkd2L7R/jf59oH8ekUL0k++8NMtQ7LgIuceXpPytpXua9Tf5P2KtK?=
 =?us-ascii?Q?s6IwQo5h4y71Jlr0nF2ZUWN/6AdZ06wv5wlo/rloSmwvPr5Nhrk8Kx8sjGZc?=
 =?us-ascii?Q?Z+94LFgv4nnSKQJ3fbcKw0HPmIx4fKHKadcmUtzFa/ShbZLEv4sWdjfK1itJ?=
 =?us-ascii?Q?k4ECZJjBG9+1cC7VZNMYSXfgjF+f/mqbyBAh3iYRgjv6Fcfgc4+T8aZi4J4b?=
 =?us-ascii?Q?Xqj7sDv+GNpPQohlm+SjeB7kdg529z7fgtHvLexPBN5eY6MMkWk6qhVmAabX?=
 =?us-ascii?Q?/+QS4jM+MqIkuOoOt4N5splScrKgaJe6XZTZtDqHMQON8r49OUA+xLvYDKxI?=
 =?us-ascii?Q?QH35oNBBUhzUc+IwyAGF936VYqLpnBqoxi5mfrg7/Wj42Xgd4G2TFTPMpqCS?=
 =?us-ascii?Q?uqmLQ63jksM1JdZwfmowK7kBfJt2aTUrVJcepEJeeG+jnazIV7bhNPsb6xwx?=
 =?us-ascii?Q?0M0wbBDf6B4/JWUPJ3tAwhLBVuHJdCvAnvVAyvWT1ptWKq0Yng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(36860700005)(1800799016)(82310400018)(376006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:12:11.2555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e91f17f-c001-4fc0-70a9-08dc8ab75c8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

Perry Yuan <perry.yuan@amd.com> writes:

> the guided mode is also supported, so the operation mode should include
> that mode as well.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Thanks for adding this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index de83e742738e..7eb35ad21c7d 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -406,7 +406,7 @@ control its functionality at the system level.  They are located in the
>  ``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
>  
>  ``status``
> -	Operation mode of the driver: "active", "passive" or "disable".
> +	Operation mode of the driver: "active", "passive", "guided" or "disable".
>  
>  	"active"
>  		The driver is functional and in the ``active mode``
> -- 
> 2.34.1

