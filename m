Return-Path: <linux-pm+bounces-40667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55478D13738
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7BE23001830
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1152DA760;
	Mon, 12 Jan 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TNMt+m2G";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TNMt+m2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCF7082F;
	Mon, 12 Jan 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230327; cv=fail; b=N5mxQiO3N1cxxWWqP0Qqb0dD0IcZnOJxVRBkxboFtP9PQQHVfS8UqYIwuwFHx3nThNkhm7kmiyY68X7LhQQOpoikKJyGqlgLrM3vwBc4aHtR0ZyzR/3SmS2FE7uco+jkBj1oIEhhU07aXJDG7Kae2v4/Dd0YbUpUdq36YvRiXB4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230327; c=relaxed/simple;
	bh=qKyQj19NwvPEpL3thfhJ7hiJNSgWcS3DRh2D4kIx+as=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kbkBH8hq7Bo/7CQKh2lbpjqs9cU7psMLq/tY1cO0Y9xcXOOLvxjoBiw1A6MdN2Yz8DKUv0D/rciyMZ0mZux5RGgfDBveXrEI1D4LZ0PChgSjrWskuWzIXzTEaaPHEsYAtxLWSMWCwM8TNlrLRzMQnagdyHJu6ZF7T00Pu19m3Dk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TNMt+m2G; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TNMt+m2G; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KDWRDuCINXCFuJlY+mVjth3AoyiDGM/U2M6F8u9ayN+s062rOPK0xJnhX486Gm9wt1EsmbOoxJaYT3xCODO92oU6KBq3Y3EDgvAZt8ES0y1UqoyQaDDrHruAR4/ukrtuDOYA7E+IlJLR/DgJxJawUKLK6Bpkmz5l6UJ+z6nzOVXffVMa4VZR3EcuLswm6uDgq8puau68dHEWMpIP4HTye7m31WhULwj+qJ9bJvQ1BNgYETStI4nhB5gAH2NAc2/Pu79sgyzvW1wD9l7CITE+0G+7PVSv+JSQ6XOPLIoa3ca5oe/rUNmTAjQX695YNiNzxzhIfv+HetG+fBux2dQ1Mg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE2wPADicH6SEKrrY8P1ExKrKL44An7ct5jtPUhH5+M=;
 b=imBue26o1OtOzr233wQ8+P3aO6/rPuFm7KfIkvgzsgi2lfMrQbzDXZlxT5wDf1iwdsC1gdBK0h9vg1ybEE4YL3BaVXAatYsMxUdN/HK53eOu6MPE2/W9Y3G9Pzus58SqrPmpvK0GHRkiSZRx6BoDZm1SWGt8EldVGrsobiUoD7kZhSCj7Pa0OCv6n+D19s+fUjtpwytu7CHhCUQKjwpmj34rwfoHffrpnBljESZ/SdaF+iKIcf2O0qCIxctKZvgXSlAo7XFQT/v83cObHneXSnx4QQOUnx0+ID+b1Q2i3Pk59izNf3mA+OF74HHbK7L8G3oFPkU5GFmobNVZwf2AGQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE2wPADicH6SEKrrY8P1ExKrKL44An7ct5jtPUhH5+M=;
 b=TNMt+m2GY96foehE7A2gCLeHHYoG26CeTSEyHKyKWO92f3WJ45mciUnytJdBOPocwnXvXY+9fjRbMH0y96pwnZcTh3IUeUDoEEfTYZ7vTtPI6geLGlykBLgsiQlQVJL39RKhQRy8YSOYKDilD7wJ/8lWwGufvTmJg3guPNFJU7g=
Received: from DU7P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::30)
 by PA4PR08MB5981.eurprd08.prod.outlook.com (2603:10a6:102:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:05:19 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::94) by DU7P191CA0020.outlook.office365.com
 (2603:10a6:10:54e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 15:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 12 Jan 2026 15:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C96mWpu3H2813sHrsAIzg3uIQMn+uV8K4m/uWp3Mzsk12LzA/FhyPG+5yTTgjOcoYrU/n3JxurYZNqwpBO1jVFRef9iUzXRZ7eqCBBYB+JlnsmsgOYAWiTjJVGNTg4FO1WQF1qQip/ho9LULKkW9JRKoCXx8SqRixMHz5vETw2FDBrN4vnISjl4ZcdXDDqzZ/P9VRqrQiaOomTsUscZT4MWFpmb4BYGUBWD9rwJYVirXK8HkW++QpcDJ0wQj5/bLMBOXykpARFQCxK2bwgJW2KZyA4eKUsB4qXkCsR8aP/3by9eI7zDm9zEHWbFAF/CzZ32L3smqzPVjL10wHWiqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE2wPADicH6SEKrrY8P1ExKrKL44An7ct5jtPUhH5+M=;
 b=fOSlIC+zP9lDM9iO2ikalB+oASmQrjcGaWHTxRsbGysMfxOxNzK29PqOg4HjO0GvlAJvEhpXz2gZdXhCDctVeY3EvMEwf/bXUaWP3RuDwCmfxM/GkUX+nfO1J7NGi8HQ4zmanvSpCtP/YWzqCNcoUUdBbf9UMl0pUxjjtlSQP6Df6CFxQW3V729XLU+Sk9UHqi8JkX134QeSwSFxPKfoUYRnEX4o47V9AG9tO5gmvn4GvwOxcfNoEWF4vo61V7BwOOyJseU3I17pZWon8iyPkOCreXKHzpXPm+O1pWqISwX4Xuwr6EkmCUeUNFslTy1q6ENjevDRwdreDqFvESRsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE2wPADicH6SEKrrY8P1ExKrKL44An7ct5jtPUhH5+M=;
 b=TNMt+m2GY96foehE7A2gCLeHHYoG26CeTSEyHKyKWO92f3WJ45mciUnytJdBOPocwnXvXY+9fjRbMH0y96pwnZcTh3IUeUDoEEfTYZ7vTtPI6geLGlykBLgsiQlQVJL39RKhQRy8YSOYKDilD7wJ/8lWwGufvTmJg3guPNFJU7g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU4PR08MB10984.eurprd08.prod.outlook.com (2603:10a6:10:573::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 15:04:16 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:04:16 +0000
Message-ID: <5beee62b-7b96-4a0e-b85c-400246256aa6@arm.com>
Date: Mon, 12 Jan 2026 16:04:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cpufreq: Centralize boost freq QoS requests
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhenglifeng1@huawei.com, Jie Zhan <zhanjie9@hisilicon.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-3-pierre.gondois@arm.com>
 <p4t3tvjiew7hmeibwz36h6htt3kkpv5c44b3thcdygltatubsa@jxjwycjzbnyt>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <p4t3tvjiew7hmeibwz36h6htt3kkpv5c44b3thcdygltatubsa@jxjwycjzbnyt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU4PR08MB10984:EE_|DB1PEPF000509F3:EE_|PA4PR08MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c330ee-0980-44f7-4efe-08de51ec000f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?clRnanFjU21uaVRPVWMzSzU0eThZU0JYTG1FZTQ1VFVJRjI0ZHJ6SlZzSGNn?=
 =?utf-8?B?NkdyRnp6dGxmVlgrQmZEU3hXVS80YXRTNWRxZ3RnRFpOMVN0Q081c2N6WkJ6?=
 =?utf-8?B?NDhwRzBOTzRiK3Y0RllPL2JURWhzdjJVUFJJRTVpbk92QlpCWVZHY0RJZTNW?=
 =?utf-8?B?aWNHSkxrejlqNVBreHV5WGtUa3JoU1hwR0w0OWorY0xZU0ttdG12VktBaXJ5?=
 =?utf-8?B?aEJMbXhPczBFOEt5Yi9GbUk3WnMrc2dXMjU4R1VYei9sNkVVSzlxSlhPV3VI?=
 =?utf-8?B?SjlteUF6N2k3MG9jL1pzTmNaOE90YWRkZ2VhR3FhS29EVnpUcXp6Mm1BWS9w?=
 =?utf-8?B?cjJIUXZ1dkNqSytiVDZQUlRUS2ZQd1VDUytUSXhPUDFTL01zNkR0UHhVWW5Q?=
 =?utf-8?B?OEgvZmRkTlRPdWg2UDE2VURoM2xzQldESWlmWEZ1WlpDTXlJTUVMOHI3S0o4?=
 =?utf-8?B?ai9UUDM1K29VVTFpMzNlRVFPTGJ6eDRxalRVdm8rR3JtZjlzc3U3UWM2dTMx?=
 =?utf-8?B?RHROQUtuajc4M0xoMkJnZElZUllEUThHRjlnblNybjdySDRmNlhVLzFCR3Ux?=
 =?utf-8?B?eFkrM09rZWVWMHlvNys1V01xcG8ySndobEcyN2x3NEFoOEZLWUU3T2JuRTc5?=
 =?utf-8?B?RTZMTkR3MFRZcDZwM1hJQW5aM3hyRmkyMFBmdFRPYTQyVXNBYktGTG1sZERt?=
 =?utf-8?B?NEVzNm05OG5STms5RU5KM3JTY0puL2Z4TmoxZFV4MncxbTlRZWt4bGdqU0Fn?=
 =?utf-8?B?Ry9iN3c5ckdaVlVjWXVYQUZtWGd4WWRGMHVpL3N6RUJyQ2xHYUhRclhQZ2J2?=
 =?utf-8?B?ZFVHTUUzZTY4dXZrZmhySC9KQWJkbkRDWmJaVWUydlIxNHRhRXR5ckM0Qmlo?=
 =?utf-8?B?ZkpRczlHQTlLOFRDcnk1Ymplc3Z2ZHFlajhHWFVUeXFMeE9uM2JVQ25QcVRo?=
 =?utf-8?B?UFNoL3pEWTdBRXVtYUJJSDdOYU14cVVBWTJJSHpjcHUzemlTU1I3UlRXN0tG?=
 =?utf-8?B?U0hmK013OEFxUVAvTi9zMGtPTmEweFEyVHYvMVdCS2syWGZ4MlBzcmtySWQx?=
 =?utf-8?B?OFh2SVBjYzZ5eEZjdU4yVnRvVjZtZjlCWFJremVmbk9tZ3V1VUptKzZIR1Ru?=
 =?utf-8?B?N2NDa3Z1dDJydzNQbEJSWDgwNFNDK1NDdVJ1QllQQTNUNmRjdktldGpNRnk3?=
 =?utf-8?B?UEwvRzZmdmdYYllhbXlSYzJValZKaFRBN0RLRzRLanY5T05VVmhFSGROM29M?=
 =?utf-8?B?b0hYSjQ1amt1U01BNFRuOVJhVmJ5MXpQZ2dFNU1EVVBUMVg0eThGd3RmVVE5?=
 =?utf-8?B?MWkyTFlxYVJoVE1KdllKYkFUenB3d09OZ2xjcUpTMzNjc3I2SUo4RWIrVDMz?=
 =?utf-8?B?OHEvZ2hKMkRIU0ZnQWFFeEZ3Wll1VnRrRTcvcXIxUHQrMVRnOElYSk1uZHNY?=
 =?utf-8?B?QXVtRUVQdmlxOGxPWkNRbGY3MFIwbHN1MnJmK0djVHFDRW1yMjBOcCtCR2Ni?=
 =?utf-8?B?T1NZNUhIZGY0OTN1U3hYQjRGNkNkaXRGbGZ0cHhUSm55VEpZVGxGckttc1px?=
 =?utf-8?B?ckx0MTBQT25qeHpIdzZrbFNPdnFYbHgySjM4NVdtbFl3ZFRHcVl0amFNSkYz?=
 =?utf-8?B?VXJHTlpMd08zVGxodGU4bnNMbGE0cUVCdk84T1Y3MnlDajhmRnZRMXJmcE92?=
 =?utf-8?B?M1hVNFpaZzhwRC9LNnpvdjFhZzVxV1dsbWhzQ0R5NW8zNWhJWndIdEJzTXBx?=
 =?utf-8?B?MHJzWjJMS1JtZjZ2NWgrN1U2QnJMMTc5MDNUWHFjN3lUZkdCWkxDVFJvRXA3?=
 =?utf-8?B?WUhrTXczZjc0cnhubjhGcHlkOXFZRVRrR1R2YXJtbkMxd29yc0sza0N0N2lW?=
 =?utf-8?B?dnpxTHFIWHFDbzdRZWRUMDAzYVhOYmNpQm5QVW9sczM4eldVNUhWZ3JMSVJm?=
 =?utf-8?Q?Mv1ZLtGn8lQ5t+ya/xLf4h0BJHT95PZN?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10984
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e1b4e050-2322-448a-7af5-08de51ebdaae
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|7416014|376014|35042699022|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Lzh0ekRmejRxOUlmSEVXNkhZZ1psS3dldTZQamxFNFgzTmpMREw4Ry9Bd0cr?=
 =?utf-8?B?NVZKeUJIVjhCT0tKbDBHMVhGWHdwaXMxN1dzK0lab2pvMG9FYUdrK0VNNmNB?=
 =?utf-8?B?cWNoVlBTSkRPa2tjM0V4RngvS0lPR09ucnpqVmI4UWVIeHJsY3FzMk1BSVM0?=
 =?utf-8?B?UDlzUzBaWnlXVGkzRGZkZlRLWUJVVzkzYnJjRnRvTFR5dU9QK05QNFhsUU5a?=
 =?utf-8?B?SE5yUXVFb01mQXU1OENZZWlNTXhiYkF4RVRhOCtKK3hxSFBkYWVrVGV3dmFq?=
 =?utf-8?B?T3BWdjBnVDkzTkhUVU44a1ZFWlBmRnF0MTBmTTBwYzN3MFVkSDJMMWg0cFlJ?=
 =?utf-8?B?cGNWYWJ4ZEVkVlRyY1NObFBrNExObU1HVG5GRlhIdGNFUVMwMVljMllabWx4?=
 =?utf-8?B?YUh0ek5BdklRckpvSGxybks2dGtkMDlaRjR1dDFGYzVxZlgrTTh6eEpTYlkr?=
 =?utf-8?B?amdvcHR6cmNNcmh3RDlVV2VsK3o2MXhXeHNwV0VVMkl4Z2NjRis5OGo1dGFk?=
 =?utf-8?B?dDZHRWJoejlMMFc1cE9yM0RMMnhLbjlmdDE2VDI1V09GVTd2U0lxeUIrWTRo?=
 =?utf-8?B?QlNtRVdoVXRCbXprNGh5eHA5YTRkQjc5QmNHM3FDY3JFbUp1Tlhib2FFRTRE?=
 =?utf-8?B?bUxCWVo4Qm4yUTRacEZVRythVEJVOEhjbGNESU1od2RpYThVWlhQWlBsYkNz?=
 =?utf-8?B?bWs0MVFqR1RScTNRMSs0VlpFNStnNTZ5eFduVXlzR2tCb1pHSXlzNW5MVURI?=
 =?utf-8?B?Mnh4TFJVbDAvWjJtUkpDZVJBZUYrM2grUElGMXE3V1cveTB2UnRCNlhGT3N5?=
 =?utf-8?B?ZTEwWjRwcnZWV3c0dU5PVHoza2RlVTdBc1FCb1dabjlNRDRMWlNGY3NObFd2?=
 =?utf-8?B?L1FZTm1YVEF6eHQ0SzBTdUVoVkdKV0RyVVUzdDg1WUR0UTdQSHkxdVRnUHNw?=
 =?utf-8?B?ODRSVnRwVzBKbEZzc2ZRMGhzbjJDZUJhclBDRDg5R0NCSGVZTm9Xdkw5cGdG?=
 =?utf-8?B?VDY5QnBFd0hvdVdLbEQvN0FpZEtyckt1b0JNcnpwZHoxa1A3bnJzdkZYODFK?=
 =?utf-8?B?UkM4dmpvaVY0bkR1MnREMnJ5YkFzdEIxSkhuMWVQRW5vbGZFRVdHNTlXTGdM?=
 =?utf-8?B?a3o4b2JoaWxxMmZSL0daZ1hKT3ZERHlFcnZBdndaMGFPSHZDeDVNZDcvTDZU?=
 =?utf-8?B?d2pCU0daQjZXU01YekNmNW92YythNVlvRkZxWmMxbzhjZnoxWkZzZWxYT2l5?=
 =?utf-8?B?YjFVcXl6V1U1L0EvN3pEcmNRY3JvekcwNk81WXBubWFONHF6b3M2cWMyUnVu?=
 =?utf-8?B?RVlYVFZnKzQ3NmRYNEhKZEtsZ3NKVnNGdmVud0hxUlhrZis1dTU3MTFJTkJH?=
 =?utf-8?B?Q25PUVFiS21PbnlpbTBveXhibUdoNGZ3eFFwcGd1cXRVUDdIWGVxWnNpUFFC?=
 =?utf-8?B?a0ZjSFZSM1VhUGNReGUzcTZIYy8rNXpyRWpRS3JKVzR0d3JkSDM1UEl3d0Nu?=
 =?utf-8?B?ZWdtRnN2OHNjQzhnZ2NwR1R4ckNjcnR1MkhIeEdUL3NtdjcrVURwaUduVVVC?=
 =?utf-8?B?Q0p5VzZWcE5VeDd0dzU1bFJIQmhJdGdLTlFwVG5PRDV4cHpPWWhUd0QzRXhZ?=
 =?utf-8?B?V2Z5eUNLUGNWUnJIcExMbHF1ZHBQRG1CYURlS2NVNlpINkdJUkhYK1phZ05D?=
 =?utf-8?B?UUFmam1qdy9peERUS0x2Mm8ybDh2NkFoRGNkaDNnRDRPbnRKTjhMRFpNLzZW?=
 =?utf-8?B?dFMxa0o4eURYbnJyTi90UXdWZHdhMHp5bk1iWXJsRm9ZbTBlL0RGcjdoRVBF?=
 =?utf-8?B?dlhUQ1lWemJVZlhCa1QvWThPVkc4bnNwUHBBS25MYjlqcEd4V0hXT0RYSkps?=
 =?utf-8?B?TjJzMnF6WVdFMUlkZlZqYVNpVXpJeXh4L3YrODRDVFBJWmF3NnZwOHpwc2NR?=
 =?utf-8?B?ODBEaWsrdHZEZWx4bHh5K0RrK3ZsUndVa3B4Y2xUVlBwaHU5THpEVnpRSlpy?=
 =?utf-8?B?MWNkTHRYVHUwdks4eEFpem9tMzhVdVlUblhpMXFua2RYcnVKY2phS3RKQ2dS?=
 =?utf-8?B?TytteDlpRXdWakZMMFFkbm1uNGdJRjRCS0FLdFRRT0NZRTF4WEdGc0thRTd4?=
 =?utf-8?Q?wDKo=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(7416014)(376014)(35042699022)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:05:18.7309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c330ee-0980-44f7-4efe-08de51ec000f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5981


On 1/8/26 06:10, Viresh Kumar wrote:
> On 08-12-25, 11:59, Pierre Gondois wrote:
>> policy_set_boost() calls the cpufreq set_boost callback.
>> Update the newly added boost_freq_req request from there:
>> - whenever boost is toggled
>> - to cover all possible paths
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 942416f2741b0..65ef0fa70c388 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -603,10 +603,18 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>>   	policy->boost_enabled = enable;
>>   
>>   	ret = cpufreq_driver->set_boost(policy, enable);
>> -	if (ret)
>> +	if (ret) {
>>   		policy->boost_enabled = !policy->boost_enabled;
>> +		return ret;
>> +	}
>>   
>> -	return ret;
>> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
>> +	if (ret < 0) {
>> +		policy->boost_enabled = !policy->boost_enabled;
> what about calling set_boost() as well on failure to reverse prev change ?
Yes right indeed
>
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   static ssize_t store_local_boost(struct cpufreq_policy *policy,
>> -- 
>> 2.43.0

