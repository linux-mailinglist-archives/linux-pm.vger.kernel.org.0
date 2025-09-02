Return-Path: <linux-pm+bounces-33629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6323B3FD4C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BD2C18BF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F02F3C1D;
	Tue,  2 Sep 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dz/JlEU0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dz/JlEU0"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4528505D;
	Tue,  2 Sep 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811200; cv=fail; b=KqytbZDHgEI+gNs6ghqBNWSqmmsgDeh7gMfwvcsAlpwVwb7ArM7XCp604VAcuXJn9/fl11CMWr+F+dh6OyWQm2p1/M905YjZnXc6FZLC0gUoM6OBQ+mKFB/AyfVN5b/xhWO5R6W6sVBBrgNfzj9byoQD9/ALXEd9JZiXZrn6H2U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811200; c=relaxed/simple;
	bh=oJZCHkE+sM0UxdGsJy6eW7GI0RGPpYgIV8PAZYSikQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uq5+ssFlXSWN/zOPj2Y3gHFk2c2i7irOKwpA9faqykycIxsmNhrvoHoXfO6cw6vHfp3rzKwuf3lZSv23qqG6/Z5RGJxppiqWkycrDE0IKKU5SxL4Ri/nc9r1AAqFoHi/sbrDgfRAD+S6eGBHIenLNrZto9ZqBTM75V6s+InUrsg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dz/JlEU0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dz/JlEU0; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=po1FJyLRP/nimXd43tXDrvtr2+AZcYnlZGH8Hrugi1TXaXKQcXx0IWznxxuFev3b9A0DPApgQygVLor0wGCm9wjtFzx4gVlS2gUmvAkrSQmPucDl2bualh9BPFBJhJd1NXqvoWrQSrBi/92GMizyYJ/KX4zgzlmacF9it+oJ386+lUBXIrsPBpU9Wajz5AR9GezfwSsmUJsPIjVaa4yW5KHmxjzIRxAR5kIyGVMqCpitg19nnZ2yERQ6VhSJW2tPMQD+aGwLGMmrPewZE7EQ7orvYQfk22t6JGKxod4EJsjmOqlE/EU2p4bKHAhDLJhQbLKd4o6lxaG70S9AoMKCqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwdV+dehK2QOZg6Gt2pn37MPgwsFmhnDm8kfR1mWyZc=;
 b=OyXr+mk/Ia6RJOZ8Tcj5q3cptrLTTEd/QirK++PP51cCOcH4YVUFX/9PGrufc4f4L8BNPJrE61aA18OGF+DnAZNaI2p6a959EjtIpCJYTglzuDS9AZBIk6rmYAQQA2Sgh57R8V78gPpKDgISYCFlm7g3B9YMwYE84iYpc8ZaSNB3T80N+6Ygs7jMfij7WfElzN/8XEJCWIHdMCePLv3f7mY9YXeCA9InjCnpv9/24XVKm3/pfIQqkKCSACs6wTwgbCaUTrKw88HptvH6aEYSX48PAp5Nux8Pa5txZC3YXGPOH9otZSwqltcuT3QLMEsDw/s2giZNHX1C30kmsfqInA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwdV+dehK2QOZg6Gt2pn37MPgwsFmhnDm8kfR1mWyZc=;
 b=dz/JlEU0jU6bVU2S0DV/SFmjOQWOl/KXIDpA0qbGXYoE3K47Gacq5Sm+xrFzFXLM48cPMAl/2xwmMEJ2S/U2N0Ax8rSaEKc8tFmKsbgFQuyLUow1coxmlBpJrIDbnAeXS0nLA/3mYqO1t6rvl7Xkxzt5H5pJ2/ttKr/wApgfM/k=
Received: from DU2PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:10:3b::16)
 by DU2PR08MB7326.eurprd08.prod.outlook.com (2603:10a6:10:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 11:06:31 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::a3) by DU2PR04CA0011.outlook.office365.com
 (2603:10a6:10:3b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 11:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Tue, 2 Sep 2025 11:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNCieBYMUBTc3A0JlGsYIgQooYLZxGlY9nUXJ9ZzAlW43zDIpnXHYTnobJe9zl6kB2W5JxKeaa+i9rVJnAKCg8XVD9C/PJnWbehD9CdfMbNnYxT1TCrNHpO4kTBV0Qzsr/DI9ae6Zh3QNAKMY5f8entdNc6D5CUj8yIDriIEmU5KXpEo2f6hOwT84dvwGsH9GJBIARCrPemDXpBxclrkk1PcXJ8r9H4Y6Cv5GpTE9H3oqTeovVJisg7KsOGaf6CAcX2LP4I9ilHDAtHV7kzVPTtm7DdDuWNRQkVAky6uXOnsDZrxsexyx/rzB0F/9YZvj2L6Kv2UPebqwaRsnchhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwdV+dehK2QOZg6Gt2pn37MPgwsFmhnDm8kfR1mWyZc=;
 b=hwy2X3dKYX7tDlJwnpucQDUe4RlF2hRiVGoXJRiStbKTUFhAi+3XE6t9IwJ3+7hsDBx2sM+na+hINFQPW3IVOiKy21V5CzZQvpXItR6PBYyis7qY2a5xWlcQiMxOXac1jHOisRoVRn5U8WPK2jqb6Danfn5pTiQB0EPOOwwL775RexIPgCcVuBuGxOHlCRTvkSKxFq0McEdatcEpHEZHvstVu2tImFq618LlX2il3XULAuaoR2byBk1Sq6SxzNNH+Ix3t7JMS19nJ2lpvSJlfKqkSInUNROuDgg8fxCmoHXAk1gAUfaEwjr/SkXvrbiUk0Vbmog7B+rV9OKpqHE3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwdV+dehK2QOZg6Gt2pn37MPgwsFmhnDm8kfR1mWyZc=;
 b=dz/JlEU0jU6bVU2S0DV/SFmjOQWOl/KXIDpA0qbGXYoE3K47Gacq5Sm+xrFzFXLM48cPMAl/2xwmMEJ2S/U2N0Ax8rSaEKc8tFmKsbgFQuyLUow1coxmlBpJrIDbnAeXS0nLA/3mYqO1t6rvl7Xkxzt5H5pJ2/ttKr/wApgfM/k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB8069.eurprd08.prod.outlook.com
 (2603:10a6:20b:588::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:05:54 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 11:05:53 +0000
Date: Tue, 2 Sep 2025 12:05:50 +0100
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
Subject: Re: [PATCH v4 2/5] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aLbPjmy/ZYSd+wzA@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
 <aLW4A3rTcJvA0c+j@e133380.arm.com>
 <aLXmCJOuxCHVXEYx@e129823.arm.com>
 <aLbJeQf9LKXFTxzS@e133380.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLbJeQf9LKXFTxzS@e133380.arm.com>
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB8069:EE_|DB3PEPF00008860:EE_|DU2PR08MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 882dd958-5d74-406b-8999-08ddea10c58f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Tk04Mlhkd1ZJV3FIelo3eno0ckMwNmhudGs4MmJmRmpwZlJack5jbDlPK01h?=
 =?utf-8?B?bC9DUE9sRXNURy8rVzBUY1JodXQ5K3NyV2g0Y2Fzb21yNkI4aHJkNjd5Mi94?=
 =?utf-8?B?RmxqcEw5b1ErYTljb1AvVElMSDZodFZvTllpdTZCYzZiYkpkVWtjcms5VXF1?=
 =?utf-8?B?OFFVcmhsZ1FrdzZRZnFINzdDVUVrYXBsZVRuL3A2eHU3RWttZjgvSXZaWW9H?=
 =?utf-8?B?VHVZbENzTGtydXJNcUNMNUZtdkpOeFQvUm9lRytwOVc1cXNveHdJdzZRWVBk?=
 =?utf-8?B?R0x6WUFnK2RGcDcvL0x1cjd4ZW1RSTBYMXIrQ3lleTg3NkxvR3RkR0t0WDRo?=
 =?utf-8?B?ZnR6NUIwL0VxZ1QzSlVNb1IwKzUxV1hpVmlUTi80T09PVm9FeTY4eXlXR2Ji?=
 =?utf-8?B?ZzdkcFFSRUtkRG5xbWNmRlgwc0IxT0hwdkVYOWJXREFRZDh2NDdrbDZhWENY?=
 =?utf-8?B?YVpNbUxPUWcrUGtEdHpMVFQwM1FjSkJGUkFzSFh3clNYZlVTdk1rOHp2T0t4?=
 =?utf-8?B?ZkdLR0lvVEFTRVNaaE5HaDVSOFltTzd1YzlDSjQ2NjUyVUlMRHBnUTVTaWpy?=
 =?utf-8?B?ZGNFMDYycjRDNjNPM3dkZStzdncvZG9rY01hNnk5RDhEWXV2dU8vZmZQS040?=
 =?utf-8?B?ZzdtMHM1UHQ4M1J5U1hVMVFjTnJjLzBTT2lqVi9vNk1xTnY4Z1NoQ2tuSVRv?=
 =?utf-8?B?QmZEcUVhTEVkZGNrLzZaZXVoV2gxT01USG9YNEsyM3BXOXFwUnFzNmtQQ2gr?=
 =?utf-8?B?c1k0OUhTQm1ycitxNExFclcxYXlRWXlMQkZZSVdsRkpjQUZBUkxOdzVJV0p1?=
 =?utf-8?B?amdRcGFoQ0llSGRRZ1p0UTRUUEhWT3VwQWkrZE8rM2o4LzBhdTBpQmNPYllu?=
 =?utf-8?B?MVc5WXFPa3gyb2E1WHhYS25IQ2trN1JaN2xITVBxK0l0Z3MxSGk4Zzl0VCti?=
 =?utf-8?B?aGdiRytnZnZvM1QyVUVNNnVaTi95OHN6T2RKUTZ4TXF3YUFTWFYxdzk0d0Qy?=
 =?utf-8?B?dUFjdjFvcGZiL2FqTnNuY1prclAwVUc5R2NnWXEwZGUyRzZ4T0tiN0UxYVVk?=
 =?utf-8?B?NVZiK2NSeVZWREtxN2xCd2hnYVZCK1BZNmlCYTNTTm1KUXRxZnZjbExiSDhE?=
 =?utf-8?B?bUEzbXQ4UlhCR3FRS0w3QjhFOEt6d3BCWUdDTmdSZE1ELzYzaThweGsrSjBv?=
 =?utf-8?B?UlE2empKczNBQ2N6TTUyVnA4T01ZVDNmY3JFdkxSeFd4V0ZHdC9lYmFiQnZl?=
 =?utf-8?B?aEpiUDJ1MlVJZTBpNGVGNHdYYmNkTGtrcUxQOXg2TVJFSmRraXBvOVVVWWZi?=
 =?utf-8?B?QS9lYVh6MURzOTV6SW9HcGRQSXhQek02YXpLZERvekJDZG9vY3pCbzJTVld1?=
 =?utf-8?B?MWxTRzg1cm5tUTdqdmxaSFJHRWh5elhXcGxxdjRPTk5GRzd3a25KRmpiekhN?=
 =?utf-8?B?K1Q3SG5QenpSdFFUZW1DTzZaYTVnN0d1Q09jbFpaTEtYd2prb29rVGpDOFB2?=
 =?utf-8?B?eHZpRmhTMnBRdWs5S2VWbWRHOFBnUzJ3ZUZka2Vwb2lvSkUvTEpJZUY2TTJr?=
 =?utf-8?B?SVZjeWtOTllHQ2VzT2NRRFlkdnY4aDJFLzF5QW4xRzdmdDZxRmtDUlpjRy83?=
 =?utf-8?B?Z25vY3ViR3pWNmJwT2xSQ25QdkdVZXNKWXdodlQ4anJQTG1UMmoyRTNPdStD?=
 =?utf-8?B?S05tWUNiME9yQVJVNURzam1TT0xCajVVNjBIY3pnYzFIUU02aitPemVSNStU?=
 =?utf-8?B?d3BsZzdVWlpDUFZmd1o2ODNkeHovRS9GWms4OXA4cUMyVzVsM0oyZmFIMHRS?=
 =?utf-8?B?S3oraDlwK3IvV3VBRnYvN2d3bmRJc3lRUElDVmNyN3RySkpJMXJwZFllT2tx?=
 =?utf-8?B?dC95UUJPWHNHb2oxdVZNSGNMdk51bGpJamgwVWJ4YjJVKzloaWJIUTZKSUlk?=
 =?utf-8?Q?IAr1zMPTv8M=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8069
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	699a96f1-b1c0-4368-81e7-08ddea10af04
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtRSnpUNDgrK0pxYXhyODA4Y2xEUjFPQStuTnZZRFdBWCsxaGNCUko1R05P?=
 =?utf-8?B?MjJPbUtJR3FlMm9rTDdNdEw4N01GQ1AwejVmQlByeFZESGdjcVJYMm1abVBp?=
 =?utf-8?B?aUdERU83Qy9jdk9CdFlrUFRHMHBtNTVOS2gyeDU2Q0wvbnJnbFdNeHhJRGZZ?=
 =?utf-8?B?NVhoSTJKbFh5WTBHRkQrL2pZcUJNNmYxcFRmUGhkckxFWnJMYzBrLzJlOWRY?=
 =?utf-8?B?STBldUgxeWRxVzFjQmxuSzNwZUpSR3g1OWtBNUVGbTZxblNPSFhMZzBUTkV5?=
 =?utf-8?B?bXhITFA5YlNaaXRUNU12Qm9FVFR5TXJvZWczZEFUa3h4WUpQNVBFWktQeFM5?=
 =?utf-8?B?Z1VVN1VwSUxUK0hRdUZJSTA3czlCS2RYZk9yMWZqS1NCVUd6U1NXT2huQ0o3?=
 =?utf-8?B?dzdoRnl3ZHZuK0k3NEZkNmFNeVJFc1U0S0wvMXhTYnBRTGhENGtXcVNGYW5z?=
 =?utf-8?B?UWtDMW9PR25Ic0F3TS9pU04rSU1tVVZjL0ljYnZIaGFyOGRqeUJpSERMdEE3?=
 =?utf-8?B?L3ZUQy93bUY2T2I1ekJiM0RtZjdnOSs0YlpFUnVRMDdoZlFBbGVBRzFaSEp2?=
 =?utf-8?B?M2pmeWRFa3FxTE1SdGxnNSttMkVKekdwOVhySU54TWdlU2xSclp4YjF3R3ps?=
 =?utf-8?B?Y2JTdW5jaENPaGVMdnM4QUNnbURqZnhYWHBBcVdsd2VnU3gvRmg1am1zVkRp?=
 =?utf-8?B?NlpZbm01a2tOaExQQTNRN056UndTdlVqb20vU3RoNDVxQ0VFL2tldytTY2lN?=
 =?utf-8?B?LzFDSXdCcUdOK0k1d3ZoUTlaWUdLQ3cyYXo0dmRFYXEwV010KzNTdEg1QUwr?=
 =?utf-8?B?V1VXN2diMDhKTVFHS2VWRGc3N0E5VkhNYWUyUENZMXNFNkZ5UHRUcWd0ZGpB?=
 =?utf-8?B?Yzd3aGFaWXo0dzJUNFZDM1MwdzJaQWRraTBPZ3IvYzdxcDBVbUJrUjdVcVRX?=
 =?utf-8?B?YUY1eWFGS0NndDdjTm8yMml3UmZIUlI4RVlwdC8xbkY4ME9WR0kzUkZ5eEtr?=
 =?utf-8?B?NmJ0V2pKUUM2ZnVpbStJUU9lOU5BVnNwVTFTdEJjTDNPOVZVem8zYkRjazh6?=
 =?utf-8?B?V0NNZ2RUNlJDZE83eVBDcFM3ZC9oc1NMZEdHMUxDbEFqNlNtblQxRUhsSE5N?=
 =?utf-8?B?VGk4RVVvZkJGZW9iZVdldnQ5NXlCOFNOYzYyL0pabkI1UGs0RmU2UHNDSC9W?=
 =?utf-8?B?WnJlT3daQ0xJb2F1cElnWmRCbU9CRmp4ZnBXOWhPS1M5M3NHUzIySE9NS2FX?=
 =?utf-8?B?MkJUUC9mT2VRekE5bVA4Nm94OHZTeDhXNitGaEVzQStzSXRuYmREYUp0WTdv?=
 =?utf-8?B?ZjdsUk9jTm5PV0VHNVVCaHZwZG5JcHRJM0RkRTdyRkZDeGxLdlVndUpDcHRB?=
 =?utf-8?B?ZVM2UXVENWIyNFd6aWsxK00vUGhpdGp2MGxTTXFwMzJaYyt3L3U1QlU1b0tI?=
 =?utf-8?B?MnZmTjliUGJOdERtMUsrSGQrcVFzTHhlSy9iQzRmdlppWFFNTWQ0Ri9NNHFB?=
 =?utf-8?B?NGdEenJiZXN3WjZVcG9WUERUVjRpY2s3N2pBZ0pRNDRHcmM5YTdybGlNZU90?=
 =?utf-8?B?Z21VV2ZtdEhrTXF6S01BbVFYSDJWcHVReDJJQkNWZXU1YkQwVy9NaVpmbFVX?=
 =?utf-8?B?dmdxWmJyOWg5c09IcDYvSDJyV2xoRytqRmZRNGphY2JPaVFEYWV0U1FUdHhV?=
 =?utf-8?B?VEpodmszb2xlRHNSZmJ3eFY3amI2WTBXRjRHUVp5ckF2R2ovTk5HbXRINkpR?=
 =?utf-8?B?UXNJTE9qNUU4cXNjcjgrTWxvNms2Ky9NcWpvLzhPMTFtQ2ZrRFhxYW5QVHlr?=
 =?utf-8?B?SGtIRVkxZWZzSXhseVg4a2lhUjZYWnFnWXJ0ejF3ckMvREJmTEF2N2hlUTl3?=
 =?utf-8?B?SFNjOU9RYW9DcUFSbXhsdlpHeUNVODVaMHo0RWhpTFNXQXZQSzEycXdFRlIz?=
 =?utf-8?B?dlJuQ3VQQzMzNUlXMTJ1T0VUdUN2MHJ0d2J2T1p6cnY0L1Y0dy9tYlh6RVE4?=
 =?utf-8?B?MjQzMWZEOUhWY1JkMUFyeXJ2RHVNQ296WnVBT1JzQkt1cnVKdDU3TUgwKzVu?=
 =?utf-8?Q?sIk7h+?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:06:31.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882dd958-5d74-406b-8999-08ddea10c58f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7326

Hi Dave,

[...]

> > > > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > > > index 36e2d26b54f5..ac12f1b4f8e2 100644
> > > > --- a/arch/arm64/kernel/hyp-stub.S
> > > > +++ b/arch/arm64/kernel/hyp-stub.S
> > > > @@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
> > > >
> > > >  .Lskip_indirection:
> > > >  .Lskip_tcr2:
> > > > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > > > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > > > +	cbz	x1, .Lskip_sctlr2
> > > > +	mrs_s	x1, SYS_SCTLR2_EL12
> > > > +	msr_s	SYS_SCTLR2_EL1, x1
> > > >
> > > > +	// clean SCTLR2_EL1
> > > > +	mov_q	x1, INIT_SCTLR2_EL1
> > > > +	msr_s	SYS_SCTLR2_EL12, x1
> > >
> > > I'm still not sure why we need to do this.  The code doesn't seem to
> > > clean up by the EL1 value of any other register -- or have I missed
> > > something?
> > >
> > > We have already switched to EL2, via the HVC call that jumped to
> > > __finalise_el2.  We won't run at EL1 again unless KVM starts a guest --
> > > but in that case, it's KVM's responsibility to set up the EL1 registers
> > > before handing control to the guest.
> > >
> > > In any case, is SCTLR2_EL1 ever set to anything except INIT_SCTLR2_EL1
> > > before we get here?
> >
> > Regardless of VHE and nVHE, between init_kernel_el() and finalise_el2()
> > the kernel modifies SCTLR_EL1/SCTLR2_EL1 (since el level in this period
> > is EL1).
> > and at the end of finalise_el2(), kernel switches to el2 and
> > if VHE, it writes the SCTLR_EL1/SCTLR2_EL1 to SCTLR_EL2/SCTLR2_EL2 and
> > initialize the SCTLR_EL1/SCTLR2_EL1.
> >
> > Although there is no code to modify SCTLR2_EL1 between this period,
> > as SCTLR1_ELx, I initialize the SCTLR2_EL1 as init value for the future
> > usage.
>
> I think that we don't need to ensure that all sysregs are cleanly
> initialised; only those that can affect execution in some way need to
> be initialised.
>
> Once we are running at EL2 with VHE, we don't switch back to EL1, so
> the _EL1 control registers don't affect execution any more.
>
> If we did have to clean up the _EL1 registers, then this code would
> need to clean up all the other regs too, but I can't see clean-up for
> anything other than SCTLR2_EL1 here.  Is there some cleanup code
> elsewhere that I have missed?
>
> Cheers
> ---Dave

When I look at init_el2(), it returns to EL1 via:

  mov x0, #INIT_PSTATE_EL1
  msr spsr_el2, x0
  ...
  eret

In other words, from init_kernel_el() through finalise_el2(),
all system-register accesses are made at EL1 (i.e., SYS_REG_EL1).
During this period, it appears that only SCTLR_EL1 is modified,
so the code only needs to care about the accessed register — SCTLR_EL1.

That’s why SCTLR_EL1 is reinitialised at the end of finalise_el2().
Otherwise, the MMU bit might remain enabled, which could cause errors later
when launching a VM under VHE.

However, the idea behind this patch is to initialise SCTLR2_ELx
the same way as SCTLR_ELx.
I’m not sure whether SCTLR2_ELx is modified during this period.
If it is (now or in the future),
it should be cleared/reinitialised just like SCTLR_EL1.

This patch is based on the assumption that there may be modifications to
SCTLR2_ELx during this period. So it isn’t about other system registers;
it’s about the register actually used during this period.

Am I missing anything?

Thanks!

--
Sincerely,
Yeoreum Yun

