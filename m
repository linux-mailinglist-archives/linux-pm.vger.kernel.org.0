Return-Path: <linux-pm+bounces-33699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA0B41C83
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5137B409F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9D2F39D3;
	Wed,  3 Sep 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G5opgIoK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G5opgIoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCD2D6E62;
	Wed,  3 Sep 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897221; cv=fail; b=UGSzwkD77ikCkOhvqGDX7XW0Z4clKyvnVPiffxq8vMmc8UmoRfaBVJgn0wkuA3k68W8xQQGpxKPW7sZl0bg1WPJ+4063z4aN/bmhfOkw/2ZmhFX9ekgNbGFma3+idKtyz809KdWLMDNsoDlFQPwgBJ8024CPU0LJgUyD/HXXL/8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897221; c=relaxed/simple;
	bh=fp+ifIu9CBJOjlYKBtVOPlCHb97uFuhGRpnqEv/3tUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UA9zTuwzh7yROVdijs9/Ax2zJhnhzrn46hPUSVQ8HZGbQrdWunJGIcggVECSGvuYuUohFRVTc3hhUfqUpnNmh39yIk6rpCk1JpFWTx76rskExQYsw9BY7WjNtguj5Vtqgs/aglfyyH3Cp0r4balVhuFAIm/TiJxyq3YQTJ3NBZc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G5opgIoK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G5opgIoK; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W5AegtLvUqpBnVcHkphWdPsGfhHxKGU5Kyqz5LEGqZ1q+ZyNNG/SR9ZLazSn3I/LT2OtGgMjWUYZ5pvJA6Yv+8APquu8656IIFwhXWB0Q82GZL078GiS/hXTyNUvAuZ7KRyj4q1Q+LrXl7s2ZCCUH7h2xZiaNWa2LO3SiIvHmtY/4kGQT+bvjVboXxIuPq6ZDG+dpPnStooh+m1tJSPaudfC6XYoQ6tMWQ3ZrIU2p7wNwQsq+CkrDLPJqSbSCRgJwxyaysGkxqUsFruqOUCQd8EKV7cC1G7Y0lVzTexm1iBLOjpD1+crWmYdQJ9ZcDwLaoivbwWaWMpto2cI5suIcA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6hjx6JTIisbyg9ueYMXZURwpMUcjlMifdyqim6pQDA=;
 b=s3t1stzGA1OGdJIKC10QGOMNmRDWXdQki8DDbVKhbadGLMrCEZbfuk5/WsWJmh6DtZM6GtQAC44rxfseaQqCfmEYDDtKTNmmk+aPJ4WcGpvJ5ft5d5SAyOcB219dQ9ZMZYuzrQ20BVVob+7RhVscHjmDyo1tSoC6QbKjuXis+SexUJCnYr7PR13HweMVbg7WpWRvhG/E3WyjVKPIE9migVQfJkFeafBNB3qvUFciLhWn1EHDaTd/hrPF6S1+DZ/bgq8Me1JtOWfOyVBFn8QNUZ0Cw6MT4AUHU2OKGq0Ue6nuKBYuIljcjOjHiT9Vg45oLAlyXhQnCiQR7RES5dDt7g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6hjx6JTIisbyg9ueYMXZURwpMUcjlMifdyqim6pQDA=;
 b=G5opgIoKuSkXKGZYbIM4mRmHSnaAxFGQU8rTLW6LvTjyUa2D5XN/9e7sei6u3JoOugeXIAlDjyhdFlI2eEn3a7oFcQe97V93yq58v/wT9AviL5hP+0iYpPBm+WomZX7fBFKJav+SzLX7XX0+XixB6lWW8FZh9JFav68o9gA51Ws=
Received: from DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) by DB3PR08MB9010.eurprd08.prod.outlook.com
 (2603:10a6:10:42b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 11:00:14 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::68) by DUZPR01CA0020.outlook.office365.com
 (2603:10a6:10:46b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 11:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Wed, 3 Sep 2025 11:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP08KheTYfLtmOgQkm1HoO061nZ+zxDHaXIc/0WkEXoEUHmYwostXZ3DK2I9xKAV/3uic151xvvA0KCvAk/8RRwg5OQNsBdkRkb3JjRbwVlfY5tn0idg0edcS1WxDeAStybM1FwdOz5ZHjotymsmo/fn+08vslpr9xfoLp0MnNmdZuHLNuL/x6KJAACn/tmprekRNj9XJ7kGUw+Jv8esQJQLnIJKS2ikzcmyTFgA55RokSqAZmijYZQjrWgD3ftRb5ixOl4Hu+HTA6bz5zNpiVxysIhsD2qKfAntx33TNDC68xQdORtCHBPbozEIS98Q6GRAFkBYRijcEGo6DWRNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6hjx6JTIisbyg9ueYMXZURwpMUcjlMifdyqim6pQDA=;
 b=JPufzpNRW3HXVs4E1Ewww5gAXz2+ONeQBHorufPUNGCXcmOoFis5ONdnW7fOOPiuWvJDdJiZIvyFkZtJ2Nh5BtQ5GkocZcgngz1lYln5qZE1nw7MxYTyIO5Gu9OMotqN1ngmAhsWbl5F7UET/L6PeBltr5O6kNP0/lQmLDpP9hOBax0MttnTDSP1vDWm96ks3jYKpPZFXeJBk1Ot+jHuj53awwOQ1IaRSgUZpTEbka4oXBHONrkNGCnKkE5tZy5/r4h7UDm8XWO0lL8LM1O9PZeknY1hJyBQwHluKgNP5eX4f6xi8M49FCEjoBHT2LN3ftknkgLS7DI+RadjYCo5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6hjx6JTIisbyg9ueYMXZURwpMUcjlMifdyqim6pQDA=;
 b=G5opgIoKuSkXKGZYbIM4mRmHSnaAxFGQU8rTLW6LvTjyUa2D5XN/9e7sei6u3JoOugeXIAlDjyhdFlI2eEn3a7oFcQe97V93yq58v/wT9AviL5hP+0iYpPBm+WomZX7fBFKJav+SzLX7XX0+XixB6lWW8FZh9JFav68o9gA51Ws=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAWPR08MB10060.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 10:59:41 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 10:59:40 +0000
Date: Wed, 3 Sep 2025 11:59:34 +0100
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
Message-ID: <aLgflh4bnmxMbx9G@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
 <aLW4A3rTcJvA0c+j@e133380.arm.com>
 <aLXmCJOuxCHVXEYx@e129823.arm.com>
 <aLbJeQf9LKXFTxzS@e133380.arm.com>
 <aLbPjmy/ZYSd+wzA@e129823.arm.com>
 <aLgbvWYeCr5l1MF6@e133380.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLgbvWYeCr5l1MF6@e133380.arm.com>
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAWPR08MB10060:EE_|DB1PEPF000509F9:EE_|DB3PR08MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 906075f1-df12-4d47-339a-08ddead90ef9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?elR2N2lCZUx5bFl1WXdlU0J6bGg1QUxudHdwZS9GbDdYay9IZW1pL2MwZnJQ?=
 =?utf-8?B?TFk2R3BOMUhncFE1M1p2ZmdSN2pzMEU1MzRTalZMSGE1UHZsNXc0Y2h5NHE5?=
 =?utf-8?B?YVA5NUQxQXF4TEJGdW5OR1lhM1UwcXFFM1RKVCtWYk84NkRGOUVLTk9vMVhJ?=
 =?utf-8?B?aEdZZEkwNzJyRHR4UERLb1ZWRjVpQlFlRVhxZzJTUnpveGk1NStZMktpM0h4?=
 =?utf-8?B?RENnaHVjMEFpdy9iZVVoUkYwY3AzQUZ4eVhKcXFwdCs2aXl6QmRrbDE3Q3My?=
 =?utf-8?B?NWw1QnY3UW1aN0FmWi9ROGZVT3c1b3ZrSGV5UzBKV0luLzdxbEMwYW5PTUVu?=
 =?utf-8?B?akhjL0FZMjlad0lwSjZ3TU9uTGhIb01yQVVpb0E1ZFdXOUNYYlRFcGhzT3V6?=
 =?utf-8?B?NjFJcGhpS09LRHBZQWx2ZjlQRVBoYThBajJ0S1JmTEtxeno4R1dkSmtmTU1s?=
 =?utf-8?B?OEowVVlpSmJmeTdsd3doL0ZhT0ZxbmZaTGNrTEM4R1hnbWQzVGVyeUNZM3Ni?=
 =?utf-8?B?dHAwcVZ2Mmp0ek16dTJGRFpURzQ5d29Sdkd4ZS9Ga1BNWUhpdEVndDNuWlht?=
 =?utf-8?B?Q2ZNQXJ6QXZNelZpQ1RHY21yNkl2RHlPTWpmNzFYRGIvaDlISFZwMHoza2Zp?=
 =?utf-8?B?b1htTHdTK0dWRVp5dGZMMnNCdWJ2NmlCYzJRV1U3bkc0Q3FQQis2RjJrdTdV?=
 =?utf-8?B?QTc4ekVUNWFManRuSFQvVWNGV3RZbnVkR1h1LzE2blZoRWdFUWN4YzhXSEpz?=
 =?utf-8?B?T0MxVW5qTXg1QXBxOSt4RTgyUURMVGlzR200cVdiM2tmNDNRM3BRMEpUUmJR?=
 =?utf-8?B?eVN1SFJkdmxVUnIwS1lJcWZyZWh1MHBZeVlqb1daeDd6WXJHNlNyVFB5UytW?=
 =?utf-8?B?VXU2bGwvNENiSGN3RWM3cngwYVVrMXc3YkxULzd6dllvd29FaEdWUi8xcWpR?=
 =?utf-8?B?OWdjRjczbmtGb3lNMTlWWTZyTnBqRktLQXh4ZjZWeUJlQVVaMHBMMStDWHlK?=
 =?utf-8?B?NjF4K05SVTFsK1AvT0pDaStwYVFha2RXL0U3Qnh6UlhGeDlGcjViL1ZlcWZk?=
 =?utf-8?B?SS9RWHpuVmYzYzVuam1EdkZ5Z0IrTUl2WUZsZzgvVUkvbWF2S1A1TjFPaVNE?=
 =?utf-8?B?Vm5pZE5oSkd5dGhDWEZlMkVtVXRISXM0clZ5SjdOenNFYTd2ZzBld2hlcUhz?=
 =?utf-8?B?cWxud091bStJOGpRbjduMHJ1N1ZleWljcDRidkJGMHVwWjRwWXlWMDlVTHdq?=
 =?utf-8?B?UWtTOHBqS0N2dTRPcHdYOUFJcTgyOWlmdXlFTFdnemw1c3NFc2N1eVV5Z0dx?=
 =?utf-8?B?blJhRVV5YUJhSHE5Q1hXUjVJajVBYzM1bWtiVk1mbXBXYmRjWkJYY0Q3QkdW?=
 =?utf-8?B?ZUtOTjlFT1JFQm95dmNQWHo1YTZpN09UYkFUQlp4SUljUG5hcHVCV1M4Y1pD?=
 =?utf-8?B?WGFuQnpBU2dDcnhrTVdQZDlhVGROeVd6VUoxUjl5QmJVU0hVdEFtcjVPVGwy?=
 =?utf-8?B?WWpqOWZNOWlBZjY0Z1Ezc2VKQ0p1YVpWakplN2RabTJLWmovYytCU3JuZ0JO?=
 =?utf-8?B?SmNCeUo4WmlnQ3A0M2J1dTUwVjJqVjJhTDdtdG1vZlk2Z2ZOb0tEdWVwZDZV?=
 =?utf-8?B?VEF5eGhGa1NhdTJJNUdGblo1dmNwa292bHJvbEZpRmxvdDREWi9hMWFFMWFu?=
 =?utf-8?B?R1crYVk2cFY3L0VlK3U1ZEkvSkUxZVl3THU0cnYwZi84L2dLZzhLUlpsNzBE?=
 =?utf-8?B?QVJHT2twTzJZNVlKeUw1Q1hKaExLZE5JR1NTUDdUa2xVWHJ1KzAyOXA5dmtz?=
 =?utf-8?B?ZUxWZEV0WjN0UUdhcVZrNm8wT0N6ZTY3eVN0TDdqOC9PaW5FbGEyNlB1Nk5R?=
 =?utf-8?B?cWIwalo2Wk9vbWs3OFMxNERZRHREM0F2ZTJyak5ndlczUFp5Z29NeFR6T2VX?=
 =?utf-8?Q?2h7SeCY5+QY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10060
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ba6a5e2b-8c6e-4926-65ff-08ddead8f9d8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|14060799003|376014|1800799024|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZyanFzTEM4Zm1xcmZ4SGk1T2ZGYnA4aHBwdHNpaHQ0VVRVRE9uRXVCYmdu?=
 =?utf-8?B?WU41UmtmQmdaRXB4Z2cyTlVCQVZUV0paajh1eWJOdWM5OFlBL3B2MVVrcUtw?=
 =?utf-8?B?M3FkRTk2Qk12RnU3cDZMVG5LWHhwY3lYT29DeTRFZ1hwMHhWVUJQd2dNYTVM?=
 =?utf-8?B?dzdyOEpPdUI4UmtHSnM5RERQRFY1dFUxbzRLRHNab0trZzdyS0pFTjFzamt2?=
 =?utf-8?B?QUdPVVFxNStsL1A1TTdHcmVLNWE1ODdhWW8yUmwvUjJPdmpwVjIyOTEvVGJx?=
 =?utf-8?B?YmsxUTF1eHpIR2V1cVNIRFB6QklWcHFYaUVYV0RadTBlR3c4QlFaYitNeFRr?=
 =?utf-8?B?cVZlU3Q4djFDQ0lKSnJpY0dKOHFKb21qeUJGc1FnejE1dVB5L3E3SGNKNEJQ?=
 =?utf-8?B?eWg0Sjc3WTJLOUY3WnVrVTRoQUNrUGZ4a0N1aEpWbExsaHd5Qkd4eUZNTEMv?=
 =?utf-8?B?WG9HUERqUXdySXBoc2xaQXpLQ0thczlVK1AzdGpqeGh6YlNwY3pEcGR2MVhC?=
 =?utf-8?B?QmdGdkREdzdnL1pmZnYvYWF6TGRiY3lKWEI2STg1WFVVRjd5MmJCMmhvNXNq?=
 =?utf-8?B?dWhTc09aSEVQSjRnT1p2WWJSY3ZJSFVsVG5reXIrWllnZ2F6K0MrTzI1bE9C?=
 =?utf-8?B?ZGhXQkhJR3RVNFVEdzBJcnN0Zmpyc2RuOXJNWXl6ZVovMGd5MU5mbHk5TzNq?=
 =?utf-8?B?MUZGQ2VzekIyc3Q5dU02Ky8zVkt4SW1wMFlXNmkrVTdPUnJrSjJhTjFyOUZP?=
 =?utf-8?B?cjZ5SS8rdnVKRDM1UzF0UXBOcHBWVE5ObVVQR2crU2Z5OGhWSmdqWHg4OSsr?=
 =?utf-8?B?VWRXb0p1WkVDMjZYc25nRjZXWlBxWmpHdjNYejlXTnlVeWtZcnFHbFNhSy9n?=
 =?utf-8?B?ZWp3Y296dHNRalVHU0Z4V0RzZ2hpY3NKcy9Nd0pkQU9hZW9HdVRXTjZDb1hK?=
 =?utf-8?B?bHRvLzJMK213Mm5nYzNBaFV1MUZHQ2VkemxDSWxSSXh3M09vcmF1QjNUS2NB?=
 =?utf-8?B?SEMxTWNMK0pvaVAvdEQzUVBHV0Y3YjYrYXk1NlJZNDVSM3RHempRNk9KSFRK?=
 =?utf-8?B?TmdJM1pyd1JqVlBzU0xoL3VmVzIrWWZxcUsxajd2U1QxTDkrcGU4ZmJRNHV2?=
 =?utf-8?B?ZWRra1ZIU3AwV3lIbnZFOWJBbEhRdjdMbWJYaTBoUjRWVTd4eXVkam9lZlpT?=
 =?utf-8?B?ajE2UE1OcmNVQkRLYnNERFluQ0hLcEpoTkw0Q2hsYVl5aUFDVjBTZHZDNWVv?=
 =?utf-8?B?aGxpVW1lcUVnR3JLczIrNVpXem0rN3ExS3B1T2FjdTVoOHlDb05sQXF6TFpt?=
 =?utf-8?B?eHAvNEg5c01YUkJjZVdqS0RLbVEzVTM0cEc2T281RlQzd0NUbHZzK3ZmZXNp?=
 =?utf-8?B?VW9rQmp6K2h4NjhPUFd6YXZrWEtjT0NGT0xKd25pT1ZlUVY5djVyQnpjckdW?=
 =?utf-8?B?UEJBS29JNzFueHdHZkY0dStpdUJXWTZsTVQyZ0pMUzF6a0RCc2hZdGVOdXZa?=
 =?utf-8?B?NWkxckZJRWJsM3ByYU41N2k1eEw3ZEJRTk5ONnZaSzdDWHJoWHFsWTI1VGM2?=
 =?utf-8?B?eEtLRmF1b29TSEZtUEVwY3lENENuSWF3ZjJiNHl0RzdTY2xtT0NTdFZLcnBX?=
 =?utf-8?B?RVZudjV5WTZjN2tvdEZRcHdvS1JJUnE3ZkZjOGVCLzUwNGo2VFN1bG1oalBS?=
 =?utf-8?B?c25hRklTbUtSQ1NvNXRXMExWY1JvQStvc1FVMW9MRnZOdnA1R0NQSzJXQkRD?=
 =?utf-8?B?SUxJTmM0RmJtSERjK09jelNkVlBFYkZMUktsKytoTHo2bVppLzZkS2FjQ2do?=
 =?utf-8?B?SFFLczhhUHVyMzNiaEhuVzVkUTVZWFJHNTdKcVQ0Mit2VEFGVUowNkZYSFBV?=
 =?utf-8?B?aDBYak1jV3BRM0FhTFJIQkcrcHRMUWludjZwNHNsd0hJdlhIdk5vRzFmdEN2?=
 =?utf-8?B?aEtiMzJBaG0xRTlIZzQ3QnFKWDMxL0JERnNqYkFvbmF0UDJpTEFEaU5HL2lm?=
 =?utf-8?B?ZFlGQzlOOXRhd2hzZGw4L1FpTGlmc0xkdkpMT2J5WTlqYzRNVStncG5QY1NU?=
 =?utf-8?Q?eL3wrf?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(14060799003)(376014)(1800799024)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 11:00:13.5382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906075f1-df12-4d47-339a-08ddead90ef9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9010

Hi Dave,

[...]
> > > > > >  .Lskip_indirection:
> > > > > >  .Lskip_tcr2:
> > > > > > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > > > > > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > > > > > +	cbz	x1, .Lskip_sctlr2
> > > > > > +	mrs_s	x1, SYS_SCTLR2_EL12
> > > > > > +	msr_s	SYS_SCTLR2_EL1, x1
> > > > > >
> > > > > > +	// clean SCTLR2_EL1
> > > > > > +	mov_q	x1, INIT_SCTLR2_EL1
> > > > > > +	msr_s	SYS_SCTLR2_EL12, x1
> > > > >
> > > > > I'm still not sure why we need to do this.  The code doesn't seem to
> > > > > clean up by the EL1 value of any other register -- or have I missed
> > > > > something?
> > > > >
> > > > > We have already switched to EL2, via the HVC call that jumped to
> > > > > __finalise_el2.  We won't run at EL1 again unless KVM starts a guest --
> > > > > but in that case, it's KVM's responsibility to set up the EL1 registers
> > > > > before handing control to the guest.
> > > > >
> > > > > In any case, is SCTLR2_EL1 ever set to anything except INIT_SCTLR2_EL1
> > > > > before we get here?
>
> [...]
>
> > When I look at init_el2(), it returns to EL1 via:
> >
> >   mov x0, #INIT_PSTATE_EL1
> >   msr spsr_el2, x0
> >   ...
> >   eret
> >
> > In other words, from init_kernel_el() through finalise_el2(),
> > all system-register accesses are made at EL1 (i.e., SYS_REG_EL1).
> > During this period, it appears that only SCTLR_EL1 is modified,
> > so the code only needs to care about the accessed register — SCTLR_EL1.
> >
> > That’s why SCTLR_EL1 is reinitialised at the end of finalise_el2().
> > Otherwise, the MMU bit might remain enabled, which could cause errors later
> > when launching a VM under VHE.
> >
> > However, the idea behind this patch is to initialise SCTLR2_ELx
> > the same way as SCTLR_ELx.
> > I’m not sure whether SCTLR2_ELx is modified during this period.
> > If it is (now or in the future),
> > it should be cleared/reinitialised just like SCTLR_EL1.
> >
> > This patch is based on the assumption that there may be modifications to
> > SCTLR2_ELx during this period. So it isn’t about other system registers;
> > it’s about the register actually used during this period.
> >
> > Am I missing anything?
> >
> > Thanks!
> >
> > --
> > Sincerely,
> > Yeoreum Yun
>
> I think I missed the SCTLR_EL1 reset in the idmap code after the
> enter_vhe label.
>
> Actually, I'm not sure whether there is any architectural reason for
> setting SCTLR_EL1 to INIT_SCTLR_EL1_MMU_OFF here.  "for good measure"
> suggests that it felt like a good idea but there was no known reason
> for it.  The commit message for the original patch doesn't offer an
> explanation -- maybe Marc can remember.
>
> This might be a defence against speculative translation table walks
> using the EL1&0 regime (but the architecture says [RNRJPP]: "If an
> implementation is executing at EL3 or EL2, the PE is not permitted to
> use the registers associated with the EL1&0 translation regime to
> speculatively access memory or translation tables.")  So it shouldn't
> really matter, but in case buggy CPUs don't implement this rule
> properly it may be a good idea to turn the stage1 MMU off just in case.
>

Thanks for great deep insight :D.

> Since it's there, though, it probably does make sense to reinitialise
> SCTLR2_EL1 at the same time -- but can you move this so that it is next
> to the SCTLR_EL1 reinitialisation?  Otherwise, the purpose of
> reinitialising SCTLR2_EL1 is unclear.  It really should come under the
> same "for good measure" justification as the SCTLR_EL1 reset.

Okay.

>
> However, I don't think this has anything to do with putting things into
> a clean state for VMs.  KVM defines the reset state for all the _EL1
> regs explicitly -- failing to do that would be a bug in KVM.
>
> (See arch/arm64/kvm/sys_regs.c : sys_reg_descs[], kvm_reset_sys_regs().)

Right. I've missed the reset sysregs when kvm is launching.

Thanks!

--
Sincerely,
Yeoreum Yun

