Return-Path: <linux-pm+bounces-34151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95265B48C07
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A59818897B4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07831EDA0F;
	Mon,  8 Sep 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ElvvUGQm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ElvvUGQm"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A173F9FB;
	Mon,  8 Sep 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330600; cv=fail; b=d/UxVt8NhQuffwpt1ICCsRqqFWZ34VIQOBcuFgtCH4K2hfjlzq8msXtfSZKV1bkdZpIhKnfUhB/tKf1iNbRshso4+jRdpAYZNKcS22KosVFcCu6+TB041C+n4X7YF81g0isE2p2x+SAJiAv4Ey/h9olEMCWaLYN3SyNg3hvAFZs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330600; c=relaxed/simple;
	bh=2lDiT+3iwo2jzh5T7Lwo9+7z7q7wf1Cc9WT4606lU3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKbN2KQQEK6B/K6YSHMwV0tMRraq6pOKLcVROKb04dNsFBqIXiI2GKO2zE22cPJXZRxw/vDPktRhih8QaQTfRDNVkLFcx5MitVeTKAhqPDrGvw0Aecd5wP5wPPB5C7rPIDgrV9vElYNF4ZTrbQNu1KVdcfq8OqkmYxuxWTZ3PsM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ElvvUGQm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ElvvUGQm; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pOfcSSmqNlUaEkhIpzJ3/9Z8zERqETyiECRqAkoIWN2wqlx1qr0cC6n1BFTXk5AWXqjgPsGBPMcpKPD1sGBIhZbo5L6AdGGuyIiMdZp0fQB2WkHWCBdN/kslrsfyzEKzcszC2sX/cGw20gVBKRBIdFm/KV2ND12p+Aw5bKkq4ZAJKRTPHEJGdtLsu102Xb0LE7Vl5ke+cdRnk9U5FkUw6iTo2M5qczY4Sh8HDXNKysoX+x/fyPFxNIMuWOgnteFSow009MMMo29cO/nVgPE4q2/fLguYsrIkdAnov6MZOErIjb+g9+UKMoPzyiUS2pXO8UMSQb4I5HVCLlMfU6lneA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUGJP8x3EPh02gJ+Eu+rTxfR3Hj7+dBYi80c01SB4eM=;
 b=R/qDqIaPBJv/6vb8Oavv8vMHigXhKCJSRX7WJGv44PobZ/kmWFk67+trvrWiu6OdcJ4Gz5nIFEb2Lgjjkrg0OuMpGob94m9ZzikB6mkjERdQqZ5jSRJflrbQ2cmqwvjiAA7F1v0amVBNMXXuVidbNd3HzKTfjlbYidbBtIb0eIF45yeKd3h3CO/RkJ/GoAHiENRZkGstbM1oI9o5g1wXCCiUz9xr8wLFHVDLMIvcOtvuAkcM8dOMw+n/Ze88XoOn7rhRs9HyvLcXKFHA+rtQnuJtKUSkF39FprEaAiFWUFwgsABKZ2vb5S21t9m0xymxvYlIzU7pdoNB3BBmxSAGww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUGJP8x3EPh02gJ+Eu+rTxfR3Hj7+dBYi80c01SB4eM=;
 b=ElvvUGQm31fJts0FjFZ5F+84bJqS09ZDIL8+XAcszah9KeNO5ldmnDnnKQKn+YksAayASj8jxposL7M/gtCokYXAFfRMcpeqgSS0dEwbiIl7qfu3GeQ4rCRiwkBnWuRtw1MobWuQKHhABItJGA5mMbWiixzfjpNwNaTqtPl1H6c=
Received: from DU7P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::10)
 by DU4PR08MB11077.eurprd08.prod.outlook.com (2603:10a6:10:576::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:23:12 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::ca) by DU7P189CA0008.outlook.office365.com
 (2603:10a6:10:552::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 11:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/QyDsLfzMCyukn3syV1TwmZIq3ADtHf3+MeVtsnS5em6v6pA4FqH0s3uQBswM0qQ5Q4gFgkZZjkPK8mE76wlO3wfgjFJhk7v6l6rVwaKj4WFsnB1MuhU64jIx/+Hy3NZPYq5q1eDBRCT+KRr/NBgI84w/2Z41FlE+Y1zKVjkGYFqrCPUfrlQ3Q/mYQBiIQv2SQX1u8QpSNghdeSLHmhOnX2CPkZQuCzm4hkFUgejByoesdctRIG00JaDt+YrqmL6FBZiSx9Ky1ZCSU4Urz4Le4Lih01IEHZBXpFRJbhI1Z1R6CpqVqyeYPC10v0YfPSayqiE9GuiKjzTmuvHUw84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUGJP8x3EPh02gJ+Eu+rTxfR3Hj7+dBYi80c01SB4eM=;
 b=tcesV2wT+7D3HAv2QellxU2NjCtRLLQLOIa1uhtR163SRpfraOVNJFVB8hqe6JGuHjBzSbrjQ7xVkUnLn1kz6VP5dNBttEaVw0UUG6mse8PJtH9loyrW0BeZj+Qp4RZYyKlm6Ja8B5EY1FUeh5CFOE4TWV+/V60n93Qn6oyeA/HUazdAXrLlOqYmpPhk761DiquyQFO2Hd7kRlh753VjuKvOhDN77KujX/3+dQhsODpultUUs0izQeIi3+eyoleQhzip9g4qmnC+TkH8LkSPSoG96kN6SrvygGxEGF6y1kYF1+TKEsgqUOV0CQ6z4ibN58btiqYQho1JbM09FZwCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUGJP8x3EPh02gJ+Eu+rTxfR3Hj7+dBYi80c01SB4eM=;
 b=ElvvUGQm31fJts0FjFZ5F+84bJqS09ZDIL8+XAcszah9KeNO5ldmnDnnKQKn+YksAayASj8jxposL7M/gtCokYXAFfRMcpeqgSS0dEwbiIl7qfu3GeQ4rCRiwkBnWuRtw1MobWuQKHhABItJGA5mMbWiixzfjpNwNaTqtPl1H6c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB8748.eurprd08.prod.outlook.com
 (2603:10a6:20b:544::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 11:22:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:22:37 +0000
Date: Mon, 8 Sep 2025 12:22:34 +0100
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
Message-ID: <aL68enBTkmsjJGPy@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <aLW5OIgv8/bvvY9E@e133380.arm.com>
 <aLXjVNCbT6YeWlSS@e129823.arm.com>
 <aLgd0/7peYBA4z87@e133380.arm.com>
 <aLgvzKeEPn325aRO@e129823.arm.com>
 <aL630WeBwWoUGTBp@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL630WeBwWoUGTBp@e133380.arm.com>
X-ClientProxiedBy: LO2P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::36) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB8748:EE_|DU2PEPF00028D00:EE_|DU4PR08MB11077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9022ace6-a29a-4ec3-1252-08ddeeca188f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?86TCVSm8xvOEFHkfBxBX5ba0i4J+QCJj6DIRklTZfxf4HZHq6aIQNnQaYfi8?=
 =?us-ascii?Q?mG5NLRLMWE1yHnjmtsOR43wBqcC/O7o3wnLnc3sc6tvkfS5e+GvkY76nJ3kg?=
 =?us-ascii?Q?mBa/tl5n54qn5GfZd09a9hGCu0dQrK0QaH6CBt8J6pzNZibtA7Z4/0QD7hC+?=
 =?us-ascii?Q?u1sgcQdog8a1qJpt9Dmg68Qm5P17hLzSo5a73Tw+2NnyiyVYIc78rIop4Mqe?=
 =?us-ascii?Q?8021uF9pUamtL9i6qu7G37s5Od1zOB9rMF8X1F3r//ewEK6mhhSmvw7ndZU/?=
 =?us-ascii?Q?ZTpTEFOyfxIHtELeb0gNdp3L1kdWb5gTw8KchVkLUgNy6hMqqTK273XwyDVV?=
 =?us-ascii?Q?VntbJKixhU1ZTIzKto6E2l3IQjh0EQIxiNZb4GRfFNF0cQszRxw8lZvmKDt/?=
 =?us-ascii?Q?y+3D5OUl/Tle0JYdW3uHHcPcqR1VMFd4iuFNkv29zbPNEAm0N7XbA8gavyFN?=
 =?us-ascii?Q?fhpKpt/7Bv1sadvRGTLiemIh4B9Y7f+6+cLWrh0TOY9DAvWubKZhS6H4rE89?=
 =?us-ascii?Q?oSmQ78s3tdHt2hd5/LgiAoCI/Ud1pSb57SomOAbM3WVoIrXF/nGo/GYmKar0?=
 =?us-ascii?Q?HlE5VlNyZwPsHO3c0VoJc19Ou/8GL8LGm8DvgGjK4Gkyqg99G6wUjoLx/cLc?=
 =?us-ascii?Q?LM5ytHM/LuherU3EXDhWhzwGn7kA+3tA3z2H2lFoKCZG3Q+0Ri1vsE3Z1Lsu?=
 =?us-ascii?Q?V6fQFJi/pIUKVjn1QW7lqG4E9L+0x/4unHLbLSnt5mNe/+K1QtSBjoaiHzhh?=
 =?us-ascii?Q?q1Zb0Y63egdVN8/baBNbBQUCYHbdu0Araj+EmdFlafmmCKkYoGeG4/97xTd5?=
 =?us-ascii?Q?KN70SWkMI7ppF+jMQrGJC+booG8FSSIi3xUxOGBMfOL7KaBFb0xL2ND8jd+X?=
 =?us-ascii?Q?cqZlmWdNfXQfd7iHhg5iGmTRni1LLoaQerQ3Sp9MEaAWKICgI2EgHH24Oq4K?=
 =?us-ascii?Q?kFkStEuVO6oPVMgEfZlmYEUQoQ7X5rEan/k21fZ/VVmEDzOc08g5SdIzuO9P?=
 =?us-ascii?Q?gx3kJYUAX5uMxIQMBHBPHhf1S25BYLnC/Y5orEnPJK718kKUPhq1lpnwCXJ2?=
 =?us-ascii?Q?4SY2QSYt//QTkDsFEeFxQ6G0lE0Atksx+Dd/0TvvvtHlUhkkboxQd2CUo+wW?=
 =?us-ascii?Q?mnrsiDfPXEfkcHI2hmoRfBNv60USDTaBjLqyQp3PcN/WfzCJimtKcMiZTdju?=
 =?us-ascii?Q?e9EnW7xjPMM5bn0NA++Vop69EL+vHuGTNP0TwTXorViW24lQGYmkSjPIeVwi?=
 =?us-ascii?Q?MP0BY5tAfmsRdRHVVas91Myk34Pj2n4kKQvTlp4U3m4LGV3/x0/NisNYjk5I?=
 =?us-ascii?Q?sbhGe/hgQJHZO+aik3EBDky7+pfu8+iIgK1kN+5LL1t6azKKhMO9qrHhOd3L?=
 =?us-ascii?Q?LXs9DnAXnU5pW4CRmALl5Rd6VUfTEhdebgMN9ef+YBKelkISKxL4r+7jRlgw?=
 =?us-ascii?Q?oGZC0NgmguA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8748
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	49b1b88b-d7e4-40c6-c2b8-08ddeeca040a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|1800799024|35042699022|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kk8+EkQEhLdn9Kttnz7oFIbmNLw6IDPrIySrLAKvYRHyYcHEJYgbfTOO4vQz?=
 =?us-ascii?Q?kOKxVvCkbv+cpG2s6o/WLh2SHuNhebPTEIam5Z2n5b37HnyqeM4dpX333JHB?=
 =?us-ascii?Q?ICMj75ceW2rgroqrOTXYf7zq+p0N8KThoH/w15DkUBEBwf47XIkPEvlfSPvq?=
 =?us-ascii?Q?gQWQL2INhCdr8zj6fDThwStopNUW2DKZkGqgnt5CGQyh8DDr4z/2XktxWciY?=
 =?us-ascii?Q?v4DZHDo9Oue/yHArSdKA3B4NqzJv4pvbwvt65vH4acqQLfJuIXUWaka6PghA?=
 =?us-ascii?Q?I9sDMggoUschyE3D3Q35toWS8s4lCz7Wnbxra1uXNfdXI+Wz93ou1AaalbdM?=
 =?us-ascii?Q?qGJ6Zy4vWhEZpXMVrYw+hQ7wvA9dM/OGkQJOnoFoQksFuoFsCXL0n6z2+4Li?=
 =?us-ascii?Q?58q8A4kmM8brbp/UU1G0n5L3uXP/lOvmEJCk9Axv5cq0AUzGWLA5ioiSyAuF?=
 =?us-ascii?Q?VNh3tUmR6z5lMXMYlBXMVj6Yt7nkz6orU2skeUyXMdYFKiFPcT2lnT07607Z?=
 =?us-ascii?Q?nQuFof5ANgiRadyr7jg7QzMClxfsjlVjDnnhrntrdDRFeuzWfersn/Qcuc5V?=
 =?us-ascii?Q?jh+YkBHh8R09QNJGXGUwLeSkJ3ErrhR8RTeBrHNiRTfahG0FLtnOuhCMS22z?=
 =?us-ascii?Q?3/Xi2JZoqZ2wI3stBAcZAjWdUdm3axGJbSdXL0Mu8AT7I+elBrwrd2eLRP/i?=
 =?us-ascii?Q?/TjuFa1T2AIe253L9N+zXy/Jm6GgB1COWOC/4yKArjlGPuj9KvkOmSdCMNfP?=
 =?us-ascii?Q?FVmMFC38kzKJOhnhpUIZlNOeA8rkwajX4B+cfhdeIRDFj1Jr7ELzSqwPtZV5?=
 =?us-ascii?Q?2BA7SDPJm3ZZ2wmtBlLdlhSGNO14VLexWvC3qAqR9MzxjGvGi9bB2u83zr1x?=
 =?us-ascii?Q?dN56EVDS8zqLKebtLDSjBf05wDMLWz3kHUyy4Q8T7TT8q3fmRM4Kqz26Xh1o?=
 =?us-ascii?Q?hXjUVbhnt2BYYrwaSioI9czjkeikPco27UtuFdj4Q8QTsGGBw1pXrxcJ6k1i?=
 =?us-ascii?Q?LLg806EzOeH8NO9vBtj81qsp5Fdqb7TOmy1GlBUYOcQ3IQR03GlvJV4r3VZg?=
 =?us-ascii?Q?hkz7ZZ4idr4lLGyjA8pVeZEeb7sSy5ngQrufhvs8ycczwhlKnVPe7MQtwd7w?=
 =?us-ascii?Q?VaUnJmtBFuPUdyn3IUV498inPHUl7NBy543TIVp6o1I89T3QRN1n0tTsmoNE?=
 =?us-ascii?Q?J0JPPgQSMJWxtZ7Sk2gdLkMDu5duRGJUZCRZrQtCoYZYeCuYWnDNh5tetsWN?=
 =?us-ascii?Q?A/e1LN8udBvZ4FI71zrM4HbVGbYQnaiP53tlym9B/xTzwyw2eE029hXQU9Vn?=
 =?us-ascii?Q?fpKgXktAO6ppEnlL7vWoQoMVSRW+gBQ0FJQTyPtEbWXPKPn7C41R8Mk1pX8i?=
 =?us-ascii?Q?PJqMZLSvE9aIJuRUh6c6opWhAdP5sKefSb873aVpgh0qJBgS4czB5gacZWhG?=
 =?us-ascii?Q?ANw6kAn28umhAa9Sgm9FRC+oDx33FN40OOUww2Wmfj3fQ9gg1/O1xqNQZ7dX?=
 =?us-ascii?Q?09JI3IfKW5dIKNny3JZSwF+WHpj/wFAO97Fe?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(1800799024)(35042699022)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:23:11.8317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9022ace6-a29a-4ec3-1252-08ddeeca188f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11077

Hi,

> [...]
>
> > > > > Have you tested all the code paths, or are there some things that have
> > > > > not been tested?
> > > >
> > > > I've tested for pKVM, nested and nhve and crash path
> > > > (I do my best what can I do for modified path).
> > >
> > > Was that just confirming that the kernel boots / does not crash?
> >
> > Not only that, since the my last mistake, I've check it with debugger
> > too -- set the SCTLR2_ELx as I expected.
> >
> > >
> > > What about CPU suspend/resume and hotplug?
> >
> > Of course It's done both enter/exit idle and hotplug with related kselftest test.
>
> Were you able to step through these paths, too?

Yes. with debugger and some trick with:
  asm volatile("b ." ::: "memory");

checking a cpu idle (by not loading any work) without any load and
checking cpu-hotplug with kselftest's cpu-on-off-test.sh.

So, by hitting the "b .", I've stepped in and confirm the SCTLR2_ELx set
as it intended.

>
> > > My concern is that most of the defined SCTLR2_ELx bits won't affect
> > > kernel execution unless the corresponding hardware features are
> > > actively being used -- so while we know that the patches don't break
> > > the kernel, this may not prove that SCTLR2_ELx is really being
> > > initialised / saved / restored / reset correctly.
> >
> > That's why I've confirmed with debugger whether the SCTLR2_ELx value
> > sets as I expected... personally I've done as much as I can for
> > test related for SCTLR2_ELx.
>
> OK
>
> > > > > Since this code is not useful by itself, it may make sense to delay
> > > > > merging it until we have patches for a feature that depends on SCTLR2.
> > > >
> > > > Whatever I pass this detiermination for maintainer.
> > >
> > > Sure, that's just my opinion.
> > >
> > > Either way, this doesn't stop anyone from building support for specific
> > > features on top of this series before it gets merged.
>
>
> Looking again through this series, I realised that the requirements for
> this feature are not documented in booting.rst.
>
> Does the following patch look good to you?  If so, feel free to append
> it to the series (with your Reviewed-by, if you're happy with the
> changes).
>
> It's probably worth double-checking the bit numbers etc.  I wrote this
> some weeks ago and then forgot about it.

I've missed this and Thanks for your efforts.
The bits you documented have no problem as far as I checked.
Let me include this too in next series.

(I'm still checking your suggestion to use .ifc. as soon as finish
this. I'll repost it according to your suggestion)


Thanks!

[...]

--
Sincerely,
Yeoreum Yun

