Return-Path: <linux-pm+bounces-40359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A81CFD49B
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 11:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F250A304C917
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B0322B6D;
	Wed,  7 Jan 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aIlO3MVD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aIlO3MVD"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB731E0EF;
	Wed,  7 Jan 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783109; cv=fail; b=pSPxdJXvmhcJvTHv6HGFHueRJzBcdPXwouhjVBW0Wa79M8/bzH619zuRt6mMK2XEz+KctBx8RbVx4kqdC4TODXdLDl/DBt9H7Kq7p+rQErqBOolS5E7z0iyHmWpQwz6Sj328uT2NivvP8Fh+O1EUGizw/caFe0u19+ggp9Gk2uY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783109; c=relaxed/simple;
	bh=dhG+cxtxJn1BqXS/DtKne/4d8JMLrNyA6/+X2spzc7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fAXCdtlHQx14cZKaPGQLZaXdMQ4Mzi4zTfyVFa5bp2ZWTAvpMSMfb1pzatR7rfPWbrvjQaTkC/DB7Lzv/ZjPOMt1sZBYBmiU76viQ/2gnQpw2CRXrZBFJNSx2/qy8yE9NX/kGaxkeuNLBQH2ecv8UbXZLJDHtzQLpCLz7FeCYw4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aIlO3MVD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aIlO3MVD; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Gs6DAUCwNsjQb4UdlpnNSQAf8axnrujUQNxR0kVR/91r76GBf4xtzMlyy0WGjtWe6QWefuYsg2CENIhB8vsAkfZ/scET++dcP9w3d+POdNB3XsiUPfAJpFgGfM1toSPjBDQ2TM5joU3PYa5OXFeMDGMMB/gsQ/e4h3IhdUg8PcQP71JdtEaN9lV3Z+Y5XzJOTI3Ya4wqbxmqWWw29P6CY6cV3hzn0pKPFntO6iPHbkAH8/quNFnqy56OpVaBbfBOPyrfySXvmpuXICKXJRS95Beignx/nhG1ycSJRUV+ub4BA0aBWPHTOb9s0qlnryNbJpAFwDak+eRAKHjKo7nrCg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApOcyLxzuLZPUUA3vkjdvUm/KksP15sYc+UeAS4Cj1Q=;
 b=RM1t4htzU2daMbK+nJS5PYw+AIOHKQA2rQ3a096Jkp8X1wSutFeeBKZ8rVUKJfb6QQo7tRnExTJdGYFlILT8GStSYAXwh5rAkmFjEer5OQl+uCA7Z6tjCk0ByVUZutvWgx2yy3jRtox8uRpy1e2jR2OGfx1ZBk0YVnXuAY1rcAFxLto6m1k0DXm8efwihC8+WQ+k9eIuN7qkTjPmnfET8mwq15034KbzH1FZGHlACDQTYVI0dX50MOPvknabkcZGqXXH/HXhcApAapX70l4SeLjTSQjsSIi0NjksNlWAvtbtUPGC4T2GN9YRPeeU2xOwZZyBg/O3YEvk5E5g8ChYXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApOcyLxzuLZPUUA3vkjdvUm/KksP15sYc+UeAS4Cj1Q=;
 b=aIlO3MVDUfTjwCXE3ATRSnlos9gEm9gTqZIt8DXbEhyA77On4pGlbfaJm9SnvJHeF9O1nwNbXPYTMNMldHgAUpcq2cHdzormAaG9lzfs9+oHPnTX/QFlELiWaI5Cdqv8OyS01DcJpL2B0jbvc9dIb3/FJVesTHHGUsUTYU+SLl0=
Received: from DB9PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:10:1da::30)
 by PA6PR08MB10782.eurprd08.prod.outlook.com (2603:10a6:102:3d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 10:51:30 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::f3) by DB9PR05CA0025.outlook.office365.com
 (2603:10a6:10:1da::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.6 via Frontend Transport; Wed, 7
 Jan 2026 10:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Wed, 7 Jan 2026 10:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbwG8Ln7C+h9XZNpGhE50FQEBLhEGGcU/FIqDSTYrNsZY0NoP8oY5yL8Yhy66hmiVTZCGa2A+oMTcPPwYpza/qWn0WJZeUn8gAZ6ryidYVR56s4DwxCYcbMx2v72eEX9DpLLF9/HvITrUEvHR4DjmsX0rbe81AFvj1MyeQkD34TUXHqOvkvc8tzkrZkQNAU26ZdsS35EO+05P6q+Vk8+GdIh6jrM+6Ipk8UwMzctie12U/7brGCv2wZwcCOlxBG2nIeJVYcP/kWbBX5kbutCwAMpJoZq9wy/9/Sh/jeTDOz4s6VAHwKmVafQNOfDFbszX5sqZq5WUdr/ziVjgdGMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApOcyLxzuLZPUUA3vkjdvUm/KksP15sYc+UeAS4Cj1Q=;
 b=YRm/cEtGtoh5BKs5uFXdQqROj1cD4PVAMJGg2HBqq5eAR2wQC6SIVHCjy7uqe53/NK9XEBWQsbtj2bo219OAXXqzkbayOvCZ/GDdr+7dttjioZv+oXIjQ0TAgyKP8d+A9z1BabhAUf3TdkX8PR40EXGBhcraiiEwHxStZRjgco5G5ec88aR148MdwZ+Hb/psMD+uuvcHXwQxGsxd0VDMQXDuvod5LwTkxluATgBzBLdDCrnM2b8+6aOQKNtwf9H05h5T8SaFz9fsmsSEpdo5wuUHdOg7VcOlLh4sDc2hH8/ZzSInbnvcUjpSA0zs5t13mN3If2da9XllTPe+dHR6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApOcyLxzuLZPUUA3vkjdvUm/KksP15sYc+UeAS4Cj1Q=;
 b=aIlO3MVDUfTjwCXE3ATRSnlos9gEm9gTqZIt8DXbEhyA77On4pGlbfaJm9SnvJHeF9O1nwNbXPYTMNMldHgAUpcq2cHdzormAaG9lzfs9+oHPnTX/QFlELiWaI5Cdqv8OyS01DcJpL2B0jbvc9dIb3/FJVesTHHGUsUTYU+SLl0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU5PR08MB10802.eurprd08.prod.outlook.com
 (2603:10a6:10:526::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 10:50:23 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 10:50:23 +0000
Date: Wed, 7 Jan 2026 10:50:20 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org, pavel@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
	ryan.roberts@arm.com, yang@os.amperecomputing.com,
	joey.gouly@arm.com
Subject: Re: [PATCH] arm64: fix cleared E0POE bit after cpu_suspend()/resume()
Message-ID: <aV46bBotl53gf3Kb@e129823.arm.com>
References: <20260105200707.2071169-1-yeoreum.yun@arm.com>
 <af65f271-5af9-432d-bec9-e44638db9b9f@arm.com>
 <aV4uDW2p+WBCitwl@e129823.arm.com>
 <f555454a-3eb9-4537-8f69-66ec36931966@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f555454a-3eb9-4537-8f69-66ec36931966@arm.com>
X-ClientProxiedBy: LO2P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU5PR08MB10802:EE_|DB5PEPF00014B9E:EE_|PA6PR08MB10782:EE_
X-MS-Office365-Filtering-Correlation-Id: e1960fd2-aca6-4ad3-2aee-08de4ddab6c3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?y+s5jdfDEgJr7lJ0lsLMHn/7aQegQ/dPoROA0RaLu+23qypKlj5QzXaff6?=
 =?iso-8859-1?Q?K15QK5I2vzUhAdemJI547wRzkp3KInVBzIRJ7l2IFZGPTDOZBZYkM1Fg7N?=
 =?iso-8859-1?Q?75Q7dIbUnpxF1j+KwsXYqmfihKfSGuVJmp4RlS13P1fgGLWJPu/7tHuek4?=
 =?iso-8859-1?Q?JSBdsazx86n5h9RGiyv2XiIyj5nsOv+MyyDzHbsjwkvXIPvEOyYjJkHw/L?=
 =?iso-8859-1?Q?gtuQyHM+o3+4cD1q9A1MF4ukTtdH7B9aL+VmcEIkgklIOzYhxD9P2KztB2?=
 =?iso-8859-1?Q?Jr3oSmM03ZayiuHhYkpPR1uL5YrPNipoBIUOhzUNSJ6l07rXOJAADh2NN7?=
 =?iso-8859-1?Q?UaDoAharOZ3UUAGW7d6KZQmyofFaqbpd8MQoyasqTa8xi9/ASp3Dcd821V?=
 =?iso-8859-1?Q?wc/c/LHn0E60vYxN+XwPzXh2+UavMMFd76fljrl+iblyAqfXkqt8R+qK3y?=
 =?iso-8859-1?Q?s4g40pyxo74po8FeKVn13UyG5l+yvfjdMBFNqJ3DxFDBdaCjS5f5bSet7U?=
 =?iso-8859-1?Q?mrKc4Cj3h51tQN3PxJB9c/rzwryvBsQ/L+8m3jX/fbD8bhNHzJJeD6Lwth?=
 =?iso-8859-1?Q?zpfh0X1l1vNPYrQymys/IKTYN7463z1LsuHc6uFo/e0tZyDQocpMj4Oym9?=
 =?iso-8859-1?Q?KlRujDODDDE8ITLUmUzYUmI6Liy6CcDVh86jpTukieSepLr4Nfq+FLwX1Y?=
 =?iso-8859-1?Q?p876I6Qyzqf1vYh+Ktf89bIgJG093Frk85xtiCRMhx01q5eaAUUqji6Pft?=
 =?iso-8859-1?Q?IjjixlelB17Z7Hi0WpWmmYbZk/39ROyIckHb+wApBZ4Qla6ebznwcSZoqu?=
 =?iso-8859-1?Q?hPSF2sXvvy1QnJSxDYSn958cK+8TPEteBJYd0x1cLG1xfjT632DISzIVCR?=
 =?iso-8859-1?Q?RDucCRv5PR/19qgwoxPdJlS7vF+L0joNnC9TFFizI7LrVc0hL2ynVPm4bN?=
 =?iso-8859-1?Q?aeyx4entLMJh+gPcKn4dT4WdHdpT5l2Hvr4TvFLVmQmVeODaHwJkATN9aW?=
 =?iso-8859-1?Q?8baQDx6cOyYuBaR6KOMpLWtMWUpkS9GcA3Yw+6ZOE5ZG1lvKn6SBUHH4f+?=
 =?iso-8859-1?Q?ui06JHvrqwVPa2Rm2et7KqelRYa9aR5IUBv7PxcCxiqitBtfrb3uaipeyk?=
 =?iso-8859-1?Q?cHz7lFQZERhI5LX+PUqSA45PMrIizdaWETegQBBBLbIWd52QJL2JGmsuaj?=
 =?iso-8859-1?Q?BfhvSgCu3mZhtV8lM1MFwFXBhX89lDTsc6bAi+hgY13zA6Gd7PL2z0Hgt+?=
 =?iso-8859-1?Q?3vXY2wNvc5v7UkHFBbznib3FVjFxji3D+ALRuzodq0luzwZfyZ+k6OA6MM?=
 =?iso-8859-1?Q?b0dGcUYR0zISEeXRxsPwsu4lp63o1LtgwTjYvqZHdFqwKLPiUgZnfev3N9?=
 =?iso-8859-1?Q?MnVEteLNo21/az9VObxCvcM8JQFT8kEkzysDG2fDJUFcD0mJobXNx0YuIa?=
 =?iso-8859-1?Q?Vj7N3dNaPxP0BZjsbZ2PJ751aARcj48HljQeNNSr3IeQ/FGii+4OfgxQ4e?=
 =?iso-8859-1?Q?l+xh0Qak+SLYH6eXuV348P?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10802
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ef03090f-c909-407d-4479-08de4dda8f40
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?JWWOnv0iirrzK87YlC68ZFzrzVZ0gwvbeqc0ToaNTwcDsjzaHOskcmuDBt?=
 =?iso-8859-1?Q?z51a7hL1O03hycxuv1a3J9YoWnmJwc+fbT9zyqHbraPhbOvAamwsT0nVLA?=
 =?iso-8859-1?Q?bP+4dDIOtrEo7hkAJJUKLaxkgeNACoKDVNYHN3NWhqY2aOVs1Mxs8fV5Gm?=
 =?iso-8859-1?Q?JRWnd0vE1bGxYT5aIZjU7NWedSfHlJDibiMTUmmCodYQG9oBwU3UVdPcpt?=
 =?iso-8859-1?Q?qUeNTj22utaJ1t29T/KvYjfK8irF0KcOf2TaeJyuMYDJFuu07lKvtBtRga?=
 =?iso-8859-1?Q?ToCevYPAy8F5I7w55IYMWQwb+oglbLuiMWnj+hPI7hMWHDtPIQza7YUpFw?=
 =?iso-8859-1?Q?dijg8QE982LmZZoKcPk6zacpCuPFT4XdQvNo3DOepfVEuqba0kkyl6Ldog?=
 =?iso-8859-1?Q?EdHocqHPN4c3FaETZe9c8fWwapuVJNvlhirXOKOYsdcxpZn69lAA4KF1pl?=
 =?iso-8859-1?Q?m0flu7gNA760BC4rXQusj47mi6fLC5i6nnobxdHm2qsgQ5hwsBntlt9CFD?=
 =?iso-8859-1?Q?EzoCuHY+V3HIGPyVjUnvZfbvHD6jl1h1n+WxNbNsx8ZV9rF2cKTHHhLRxT?=
 =?iso-8859-1?Q?iVAe88ZL9Da7sE0ByUXux0/DmodnDuX9A9m+r9APhh+v+kby1rFg9gegG5?=
 =?iso-8859-1?Q?GaiBRVAyCeCbYOnzD5JYYuBSWv9ype4T6pdSUKnbST7tLl6R/YWOoWCm8F?=
 =?iso-8859-1?Q?3+RZuFqwiZpP7heWtgbhWloo9dJHBV5V9M9567frNh1v+OgQaFG55Tjrwl?=
 =?iso-8859-1?Q?FyLDrLa4MiIKFh9Hd8ExjhqcFmpJmh6GSKipKcH/GZpbdQregJrnEQCZmS?=
 =?iso-8859-1?Q?TYs+zyowNeaOOZ1q0eK5mDhR1KS+DU8E4Iu3Sc9X0ehoUFwMSIxlB4uoXw?=
 =?iso-8859-1?Q?uuf1YW14SvATcjvv8a+uPLNm2P3LbPPmF+zTBDbZKaL47MON+G22LvyPR4?=
 =?iso-8859-1?Q?zi5AeCsOz0ByISHSUkNXoD4VxNQVyFtaYe4Kyhwb2PKAeX6s2f1+JkDRa1?=
 =?iso-8859-1?Q?ON8Pq6xneBWQ6nY40TyH6YzxLGIAtR1pjr4dNA9YWAWEd8hcGo60+Dwt4h?=
 =?iso-8859-1?Q?X0Vd5mQemy2XnxwgyGk1FBgHbocrp8UYAZjZQFbgLWcHm4yq6kKiUxv6aN?=
 =?iso-8859-1?Q?goFBoLKAvEhsWTtFVW6BtmpPDO01eqZX+t21hCkU4dmWyKFq6P9RInC+Ch?=
 =?iso-8859-1?Q?MglO25EZCNxKPBfIeL6F1uPad1zQV2SH+jG+71cdhTZmlUAS/DwQQzBZLv?=
 =?iso-8859-1?Q?hcq0h8WIK9zcLqkTQNkhWmtcwUwLi2yKu19jvtJPcM74LbfsAY46DrCxw2?=
 =?iso-8859-1?Q?pr2+eWFkq2XPlie1C0hs+X+9mjJN3v1rvDQsprZGQznGP8yS/xeDJuip+k?=
 =?iso-8859-1?Q?ktAKxHRLxzrgIq3yHDY2H7my1Yam3RxKHwd3u+V4ngidNCTk2kxxkHZNUb?=
 =?iso-8859-1?Q?SuboImA0poLI4ye29N3bzPwC/wTammH82ytCUR0PBaboNLL8huTy5xG/9D?=
 =?iso-8859-1?Q?y25GU6laferPkWZUIEooYWApF7W+GP0NOjHg7blhhe0EGEnddGx9ZO/UwV?=
 =?iso-8859-1?Q?KwHWyROMigfwhQ5s1seDD17cQYlKtyPyLM/y2iNrmkFPHzA+3cwskmYwWN?=
 =?iso-8859-1?Q?+4bYKXyvhrxuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:51:29.6608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1960fd2-aca6-4ad3-2aee-08de4ddab6c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10782

Hi Kevin,

> On 07/01/2026 10:57, Yeoreum Yun wrote:
> >>> @@ -97,8 +97,11 @@ SYM_FUNC_START(cpu_do_suspend)
> >>>  	mrs	x9, mdscr_el1
> >>>  	mrs	x10, oslsr_el1
> >>>  	mrs	x11, sctlr_el1
> >>> -	get_this_cpu_offset x12
> >>> -	mrs	x13, sp_el0
> >>> +alternative_if ARM64_HAS_TCR2
> >>> +	mrs	x12, REG_TCR2_EL1
> >>> +alternative_else_nop_endif
> >>> +	get_this_cpu_offset x13
> >>> +	mrs	x14, sp_el0
> >>>  	stp	x2, x3, [x0]
> >>>  	stp	x4, x5, [x0, #16]
> >>>  	stp	x6, x7, [x0, #32]
> >>> @@ -109,7 +112,7 @@ SYM_FUNC_START(cpu_do_suspend)
> >>>  	 * Save x18 as it may be used as a platform register, e.g. by shadow
> >>>  	 * call stack.
> >>>  	 */
> >>> -	str	x18, [x0, #96]
> >>> +	stp	x14, x18, [x0, #96]
> >> If TCR2_EL1 isn't supported, we store and reload an unused arbitrary
> >> value. I think it'd be better to make it all conditional and add it at
> >> the end, something like:
> >>
> >> � � alternative_if ARM64_HAS_TCR2
> >> � � � � mrs� � x2, REG_TCR2_EL1
> >> � � � � str� � x2, [x0, #104]
> >> � � alternative_else_nop_endif
> >>
> >> Same idea on the resume path. This also avoids the noise of renaming
> >> existing registers.
> > IMHO, I think it would be better to sustain the change since
> > it seems more simpler to maintain  and x12 is temporary regsiter
> > so leaking whatever was in x12 does not really feel like a concern...
>
> Leaking is not a concern, but I don't think it's really easier to
> maintain. We can have all the conditional registers grouped together,
> like DISR_EL1 and soon SCTLR2_EL1. This avoids renaming a bunch of
> registers every time we save/restore a new register here.

Oh. I overlooked that point.
I'll follow your suggestion.

Thanks!

--
Sincerely,
Yeoreum Yun

