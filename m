Return-Path: <linux-pm+bounces-28144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647AACEDB7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42603ABDD6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CD2144A3;
	Thu,  5 Jun 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0qolXr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74827214815;
	Thu,  5 Jun 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119654; cv=fail; b=GMHuXYEyD0FF4L9meo62dbgVNEDkD9l1ioa/90bnL2oHmQwCG0ID/N4VNgMeT54wvTM4GcSlvHVT5I+dN6+i/yBFiQFF9xghW32dsAgiWTw/4tCyrDCzTV669gRX0U7b0Y3cSbTPjrwy5rM9vwqVpkjjGXWXvgGDTSuvgi+UV7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119654; c=relaxed/simple;
	bh=nfy8Xqo7czwKEnwPRE24AtjR8H8XwFH9Qv40D2cz+Dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F9a5ypysHlsizYa0Iwuf77uVaRpFgCT1zu5/bsfUQZmfk9hnDxZGkPmNrqIlR9MaNlKmhR4XPSeBkWKv43U7KFrjLhbjBaoNO5SdwsZ7OW4yl+L34Br1zA5WwE4hlKmbMkV8VyA5ZEiPOS8SzmrVfDKGIQxdDvTrh/K2MsYli1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0qolXr8; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IldHF4nrqCCXBfpCAylm/ci8h6ZUPVJ+FlnStnManJCLae0kDjQdNhYJ7vDwJ6A8Bgyd09kC2J1yEqSOZ3weKJWn/MUwp6YCkiGrgjy9G4qX9HMCXeBkEzSqtjGYzrY8y0P6C58teIwUCGsCGgahUG8/Cg66/z/eBWMjIyzHQFlhG9xv0Nv7TDtBraRycTvPBm2lwXaHfQm7iSD77l5dnwJiqXxQHTr91cdDWphYnYmIPz7fx4K9lmThi6qCogNseK+TklZTtGz+5BmK0W9+jT7UqJ3pHymdvfsxI2VsBp2/MGfMs7ETI5o3A4Yqet8Qrx6GAg1wyg7Fi0qkEBfg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3elcrMBCYDy8qqFv7STaRJILHNcFA9wUxJEK1lLj6ZM=;
 b=r67lvYFEnrkNBXYpl43pWv2LOhxvOnkCMdACRtC2YZNB6X08oD5Ki7V4nE5vC2Pu6JzHLv0SVI6vtwxDxgmrAXjFHV/4LiJUako0ko6en/pliypBNSQBOaevcsbxz2RuBHnC/exavmtk9h44Lm0uerI3WxphMwsP3vMTBUzZ/nvqrr6Lq35fLh2uxa26LtXUOEUnk1JT1aMmjF9FtzDjA4h8uoaEeV1pDk3ZW6ldbYJp3sELcsvAtL0BZ2amMLu3MA+8tKMifK5vOPOGOc97re+TGjJLSD815JNY7YrrjFci77qpBkeqcuB2DPMnqe+cSDocmJIXlDXY9GrbC9v+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3elcrMBCYDy8qqFv7STaRJILHNcFA9wUxJEK1lLj6ZM=;
 b=r0qolXr87cDbVydG9gsT7zdRPznUB9uiodudb571yRoUYyl5fIk3XIgxlkjJ6LU3RsdKT8MF1qLFjfzpTQC+BPeRSaC+ZEPtLWTKokn4KvaaHcftGkcOiIIpsc2gEENCROe6Std+HAsjKd2kiS7HNp8MlWKo/aU+v/P/Sejt3kSSBXPZo7cTjNrvR/1WWgq6qhrpdGAmJE+FBrJriPeBjkFQ5bP08f4GpnQK+fHGe7tsS3acHJgC3WTSXW0147eJmfTHJ4Tuo3CrU1wmCenTz4nDJjkxmSW33eil1EsN+ixYY/3tIEEPYoOKBOha7l83yo66eiz7pqXjjgxvz19kzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 10:34:07 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8769.037; Thu, 5 Jun 2025
 10:34:07 +0000
Message-ID: <9826e66a-3474-4a00-967d-b7784ff60be4@nvidia.com>
Date: Thu, 5 Jun 2025 11:34:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
 <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
 <20250519101725.k644wzizjwygtwa7@vireshk-i7>
 <49e7d006-e9cb-49da-a4cb-b73a08f6b792@nvidia.com>
 <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250520100218.te5i5ltrx43zjsq6@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: be6a808b-3c1f-45af-66ea-08dda41c7fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGtHM0lnTDhTRldQcW91WWV5VWdmWHB6eUg0U2hpcW1lbkZDekl2R2xETnd6?=
 =?utf-8?B?QUdyam9tYWFhZm1SOTJKM0g0SkpxZXJwWFpLcWM3R1F0cjZtNVA0Q3RQL0Ns?=
 =?utf-8?B?eFdxaGhLeGNGRHNFeU5seE14MzdBa0lOeVh6UlhHbHlzdFBZZlE1U0hOdHRE?=
 =?utf-8?B?MDlXZklZeWlaV2h6a0Y2V3VVd2Zrc0xqV0V2c052U3pkbWRMQzBla20vZk91?=
 =?utf-8?B?YmxCd3lndkd6TGtFcktIYllFSjZPREg1R2xTTVZLYkp1Mm1aRndoMzYzUk5H?=
 =?utf-8?B?eSs0VlVjVlgyb1NPRXQxbzhYdlJpYWF1Ky9scnFhV3UrbEpMVk8yQ2FXUE5t?=
 =?utf-8?B?MDkrbFBMTUxHNDFqZ0J3TGl6WUs4bnVJU2NMR3NRVEx6Y1pkZFJVelpjL0pT?=
 =?utf-8?B?a3IwNkhsNmlSVSthVnZBaStFN2tHVG92aVNUUzZMSXV0WXdobUQ2Y1I2ZWNZ?=
 =?utf-8?B?WFBSYy96K0pTanI2bEhTNHJVSXNwcUJtT1hCWjlPOEgvYmRXSU03bVMyenBK?=
 =?utf-8?B?VWxNMnJnRWJoVVhlR0pDcnl1YStmVGZodS9yMnZRWjc4S1pqMytuWEtGRUw4?=
 =?utf-8?B?emdueDhQZW1QQktQQmpkckE0ZHdEMHkxMHBZMndWNUFmQ0ZCVldIRDh0OG1E?=
 =?utf-8?B?VE1vcVhheTlxeGZnN3p4aVc5c0ZTa2tyZnNsS0NVNzZieDlaVGRoRXl6K0FW?=
 =?utf-8?B?OTVaN3ViR3ZJV0xGQVNmUjZ6M2dWUUJJb29EYUZFS0xpbEdhcGtlbWJlMy9Y?=
 =?utf-8?B?bk4xdjJRWXNwemMveXJIYllNbnJ1MW96a29oc3VGUHFVSFo1bDFIeDE1eEF3?=
 =?utf-8?B?VmFFdjFpVGdZQm1hM1dHdzRCY3dIMWxuVSttUEYxbVJPSVZNTGFLMVVSemZY?=
 =?utf-8?B?aUFPTkpWalpmMDMrRUgwSys4RitlOTZqZWU1NXBLV0FVNmZ0a1lHcTMrU0dp?=
 =?utf-8?B?d0swUU50VlMyUmVVY1FPTk01ODR3WmhwN082c0thOWk4QW9BcDBRZWFacWMz?=
 =?utf-8?B?U1BFTUZFa0JpcW1INDF0Wlp1SzV3REE1eEErVlloZkh5bko5bzZPdURSdmw4?=
 =?utf-8?B?MVdDUTJna0JhQnFrV2J3ajVNZEQ0eVppOXBqTUM3N2czKzRsRkhZMDdEeTR4?=
 =?utf-8?B?SXJaTWc3dmIxMnBkRUExZjNkZGplcVA1eWw1T2xDL1pLTXFPMzN4T1VnYUsr?=
 =?utf-8?B?YktNQ2NwcFczUXlCY3grWE02a0hoSnZ6dWh5Um9PS1hPS2xDdTNIUDNWcWo4?=
 =?utf-8?B?anp5aHRMcUVFV1B4TWpmYVlxZFljK0hVQWJLRHNpN3dwRmVYVG10VEZkUlpR?=
 =?utf-8?B?c3RDS1pRdlFURlNUaU5jNUtBR0FtWmlBUDIzNmwrOXcrMkQ5T283aUd6cTZV?=
 =?utf-8?B?MkY4QXJydXFQYVdLVEpyeUxQSDd6TEtyL1MrZHk1U0FLdmdEMGgzMVNGY2ZN?=
 =?utf-8?B?TDQ5Qy9QaUhlZU0vc1cxQkQ4c2xveVdSelExd3E1WG02U05zd0huU2pPZmto?=
 =?utf-8?B?eXpHZjBVNGN1Vy9nVTZEcXp3VWhyakNkOERiYVZ0c05SaDBMR1A0a0xRTzRY?=
 =?utf-8?B?Nkk3Ty9lWCtVVWNqZ1l0dnJhZEwraU1yL2RCcWx1RHdkcFB3OU54VHZrOXNF?=
 =?utf-8?B?LzlCM2k3N1BLOVRPaFBFVkFuZXNiWlBEalRXSmRRK2hrT3E0QThFbjlsMWNI?=
 =?utf-8?B?bnlDTWpIQW9rcjhNZUw5Z3FxaVFPYk1CV3B0bmthUDVGL24rV0Y0WUpMQ0dv?=
 =?utf-8?B?YXh4Z0ptQXBKYVdpbEFra1JqSkFVZnBFQnJtZlJCWjFQb1lXaGJncXFkdEQ1?=
 =?utf-8?B?R2lVak9vNHhxS011ZWI5Yk9vWHFUSlFmUFlOWGtYczB0WENtRVc0WDV0L0JK?=
 =?utf-8?B?MTZkbVNhSnQ5UGl0dzRENGhPcDBTYUhkQlhMUlNIeXZrOU41RDdRVm1KVGwz?=
 =?utf-8?Q?7k0ru1H0nvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZ0MDFUdE11cnZZQXFjMFpXa1JId0o5QUZIb0Z6cmZTbjlSL3UzMC9CajNs?=
 =?utf-8?B?c1Uzb0xWVGFzVDBxUU4vcEVDeVJSMklpRDJ1YTl6alhzS2RMc0t1a1JQWjZK?=
 =?utf-8?B?REd6YllvbC9LNE5yOXRvQlZVcURGK2tPbFpuMmZEOTRCaUNBSFhlakduNzNC?=
 =?utf-8?B?RWxZM3JuZjJGVnpQMVprbytQS0tydnJHQ3FzVnR5OGFkNWdWbkh5SWo1RVgr?=
 =?utf-8?B?VzJ6S2YrcDBEdEZxeVB1SFMxYnVmbDRKWnFkRHJ6VHFIOUdTd1huS0NTOU5z?=
 =?utf-8?B?Q1J1RkYzWEhGQVBKcnkwY05KMjNKbGI3cFdUR0hMWFVmQ0NFRUEyRkJMUmty?=
 =?utf-8?B?WlRRSTZQcFFnTGd5YmUraFZOWHdLOEtCQVo2K2dTNG4vdUZEOUNUZURUaHdr?=
 =?utf-8?B?UUJFWG5uNE9uOHdBUTNJYy9FbERTdFVrN2E0MnFFODBPeG1MVFc4VTRUVjI4?=
 =?utf-8?B?bUF2ZmhQenRlYTRUMW5RaXUzTDN1OW9lNmE3SHQyVEFjWnBab0tscTJBYVpG?=
 =?utf-8?B?WWxWcDZSbEFWVnVvcW5CbzhQbldaMmRDdFpQakQzVU1LZGRNSXZZTS9RUkJx?=
 =?utf-8?B?U0tuY1lVQ0VFaUFKSEdQYWtaSEdQekpNb0pQTFFtTmJQZ2d6eTFQNXlrUWVF?=
 =?utf-8?B?UGdWZmtORWNHbCtwNUtCaTM4UDZGd2lBRkZ4WUlxKzR1bEsvMVoxc1VxdlVh?=
 =?utf-8?B?QWJsNGUxa0pVZm5pZVUzeWJJQWpHSlE1Y291Nzg5RlhKb25vd2tXdG9XOWFB?=
 =?utf-8?B?cEYzeEpNemJBbGZXd2ZLVy90UG9yMHhjTUM4V3FOTFNId0RmM29DSVIyNU12?=
 =?utf-8?B?TlZ6NU9yUXlDZGRTb0pmVmZlRU5DU29QZUxZMjdTN2c3UisxN3Z6d2lrbHF0?=
 =?utf-8?B?MHBsVlByU1NGdy9SajUzLzhVYmFicXdvVHB4eVFYQmQ0N2o5ZGZNTnhuZDhw?=
 =?utf-8?B?RWNwV3FNYjBodnBDZnZ2Z3lzT1ljbTJWQXhTTnhqczdkRDR3WEN2MXN0UUF3?=
 =?utf-8?B?VTV0aFd2NjhxZXM4d1NLMUNIUWJOdzdiQ082Skl5bi9SYVBUdEFJK3RuUFlJ?=
 =?utf-8?B?UndWSCtwa21TLzR2M1hMQm1pZzE5RmRtMVkxNWxlTDNKRUpBdTV0b3pXZHp2?=
 =?utf-8?B?dHBhSHNEOWUwRHdYQS9GQ1NZM2tZWUZJeEdEWGowVmlma1BBL2JWOS93ejBi?=
 =?utf-8?B?UFIxZnh1SWZZY1JQNHcyQjdnS3pHcS91c0pkdnY2Mk5PU2JsYzhSSzFNbVMw?=
 =?utf-8?B?YXphbU1DcHVvS21vOU5pVHJVbnd4U29UbnEwaXpxbHZTL01SeU9xMEcyTUhK?=
 =?utf-8?B?RUYzS1haR2Q0OHNYdEcrS0JOT3hqK3JpV3hmdnN2VWtmWUtGTmthR2wzVzF1?=
 =?utf-8?B?WVIyRmN6bXZmS291TldPWnFFNjdDTzZORWVIaTJGU0dNYlRnc0pWNUJUUnB0?=
 =?utf-8?B?c0lqV2djVE9scmZMem1oNzRuWkI3MVpPa2xDU0d3TlF2bFlZK29ZZCtneFZU?=
 =?utf-8?B?N1IzeVZUcWRjbUwyY2FxVEpEODVMZTkvVlorc2IwbkJkRjNXSEx0VXhiY1d2?=
 =?utf-8?B?RVpoUmVtcW1Ocy9oYTEvWE1abmErMUg5SGVSZFFXUnlEdzBSYlhIcWZ2YUhE?=
 =?utf-8?B?SEt5R0xhWW1HaGhyeXh1c09nc0crNXVpK1FJOGpsQjZHKzJzdHV2WDRYUVRE?=
 =?utf-8?B?bFJTeDVZVzZtUzN3ak1PZFhHbDFFMHhISHE0aEdncHJycDBMV1lsaXhqR0hW?=
 =?utf-8?B?b2ptZVJ5YzU4TGNUZmc1Q0ZCVmJYZFJMUGJRQXVvQkh0c3V5dXBNQlhabnpN?=
 =?utf-8?B?VFJyL2tOZGN5OHZRRlUyS0lIeWRzRlE0My9oeWRwS3RiS2NhMXVOcVViM2cw?=
 =?utf-8?B?aVdLUndlc3NPVlQ5ejhvdFordFk0bjhOZDg5MDk2cEkxR0k3WXJsMHVOYmVm?=
 =?utf-8?B?WEVuYkM2cG5TRFVkKzNVNUg1Q0Fod1V2TXRtZEFYVUtaWWUwUlBlQ1EyeTRS?=
 =?utf-8?B?cE5BdnEvVEFFWnNRVHliOG9LSlhOMWNGSU9va28vMmFmaTM3WnJRSDdrZkFl?=
 =?utf-8?B?QW0rR3BZek8vK2VJQjZqcEgwWE00NUF2YzIwUjNLdi9tSzljY040eEZ1aUli?=
 =?utf-8?Q?tGeJm/MC0MnqsUDdxz1sjs4z7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6a808b-3c1f-45af-66ea-08dda41c7fe9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:34:07.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnEC85gKVM/snk7VdWxqRya5LRb++WX3mABE1mQmRPU9WqYNL0KQjCWkzaw+H5QYg0W4pzE6FZQWAN9lSt2KlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870


On 20/05/2025 11:02, Viresh Kumar wrote:
> On 20-05-25, 10:53, Jon Hunter wrote:
>> I understand, but this seems odd. It would be odd that the device may just
>> disappear after resuming from suspend if it fails to resume. I have not seen
>> this done for other drivers that fail to resume. Presumably this is not the
>> only CPU Freq driver that could fail to resume either?
>>
>> It makes the code messy because now we have more than one place where the
>> device could be unregistered.
> 
> Fair enough.
> 
> This driver, along with other cpufreq drivers, can fail at multiple
> places during suspend/resume (and other operations). If something goes
> wrong, we print an error to inform the user. Should we avoid doing
> anything else (like everyone else) ? i.e. Just remove the call to
> disable_cpufreq(), as all later calls will fail anyway.

I think that would be fine. Given that the tegra124-cpufreq driver is 
the parent, if it fails to resume, then I assume that cpufreq-dt driver 
would not resume either? Has anyone tested this?

Jon

-- 
nvpublic


