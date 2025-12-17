Return-Path: <linux-pm+bounces-39659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868CCC8F97
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C6A314A84F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DBD33858A;
	Wed, 17 Dec 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q0FBF8ub";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q0FBF8ub"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21929BDBF;
	Wed, 17 Dec 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990579; cv=fail; b=oOO2ANpk+Ki/Ive9nC3DvWuyHA+Hj+8Coc4lQ5IO2fvjkT1pMt3uUPBk7OhQq/wZtlfeuSf47JZ6KzEp4Zkpv6i5zMNPyLQ8XIi2OFiYii8M8fjpLmYjJDudQwwb1ELIFiOmxLpFSWoElH1f8JuNz3tgiTJWSygxzyx4rNUZIUg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990579; c=relaxed/simple;
	bh=apRiXgWOJJXfZjLK+XqEFE99s0HlEODl4nnMcgavgEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gzg5b/CTm+SmtAKPFZB0gkGeV6O7jU3BRcZDhLpjpMN4GJ08mzR+lL+7vIKi/9nJPJYwQkkhsD2yCb8tj2/YnNxng4r3w4ANfxFDQDPzzbLPRdMqayvNbxBL2FYdb3sBTL3ncdxS9JD9G6fE+cHdLe+q3MgWUH+ncBwh3gazwXw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q0FBF8ub; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q0FBF8ub; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=f93NLXu4SCNebxeaAFvL/uPrXC2f7+0b3jABEMjm2TRcoiqBRla1GeBs9l9OdIUmSWze4p+jl1D9BWirM92jo3p02JIJ/1+TNlmuxikY4H1E43SY8DpDEQK6k/2gVIoagwbvlrkqTedpslaQWjojY9M1ZuTw9nSQfXu2CVdUuGHrUincRg8p2EHcbMTSF82EGAdkP0P29bK+bxYog4z338FWEZ94oTtOR1xfrAI+s2Ni1H5D5xBo0hV9BL+16PydQA3ciV3BfsAruiHpwPqFO7xIiqqUC4o0/UgM+rj50Juudr1ohMuE0U8mnCGqgeRjHNRRx7WtTNPZ6hxnVt/ITA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqMfwfSlPtoC9zIrQTFAYTbJiTs9u+l2NLSlVm7spy0=;
 b=epSinlMQfh4kLvTeNTpOQcGI8rIQZFI7uyEvuOkEPsm0iUAwmKzH4Azp1FLeUn/jG/bSCv4xRDA7BGvVmhtQKn0VKZeaqP4D/K6sZuqB0c6xHlbzCutOS17xSJ/5RnCG3f+dmcjLNWdC/rdXb871pwTmMtkj5NFOrPxlUOpWGguVjzheDPrdWPvBySjZdG8gh0guLMg0VexML7yO7kFsncUqor3UUOOyMkLgHInCDrRLPvQREshJnR/0RJ/ZAqVCW0dsH6+oQH+/nekI1jKaKIMEjxQ2uOEARqEuDmBaYX9DwHsWQrYahp8uZQFCAtC2Nh7OwfiNF9V/Pj689f9dHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqMfwfSlPtoC9zIrQTFAYTbJiTs9u+l2NLSlVm7spy0=;
 b=q0FBF8ub+4UCT9VCj+yFF26+6JWny7rsTe9zedG5uOs0f3FdDfdCTNyTWdc/GGJzaGHqAzZenprPIeaSjLZfS/AqqhORo7Gm2P2rHdnLoI9JbgHlNJDIlxIAGkuZiosaYXFMFjqE0NVGXY1qK+bMVfRo75Ma6oacknLRgQaNs5E=
Received: from AM8P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::23)
 by MRWPR08MB11826.eurprd08.prod.outlook.com (2603:10a6:501:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 16:23:01 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:219:cafe::c6) by AM8P190CA0018.outlook.office365.com
 (2603:10a6:20b:219::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 16:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 16:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVA0d3ERwN4ieJcjqSCZaZcKJc20yQgYnOlhgWmZ485ErX2FWX0qKwKkDGRFx4LPgsy2VTq6AJzXNfs7te/xEmupb6Tu2VRQH9r13iKe4KUPPS/uZ3Ori6uR/EGYQMe53lOXRy+g7L45at9wm8DQvyNwDXAa4sWBpzEQTRKJmz8Q0d7+64fUx7T2xpVirz7rmbRWA6aJyuagU+5kXLTqHXkw4LUFtMYDU+ta91QdaPQlQQIBgL2gPQHD2cszx+xPM8FcpDyW8yNXulLt27rsjG6IrwInGnbeUin5zJhfPywq6VncZKxc3x+ZzUXzFpVYprbCoM3clMf/70NhwJYYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqMfwfSlPtoC9zIrQTFAYTbJiTs9u+l2NLSlVm7spy0=;
 b=QrQeDuiwMiWvdanYvDHV/OAUItVvMLPcqrjsH/sMy7OQJqEqt9c1eGpb0FaDYC2aGXUIukuzOgI6mUfhQONM23tS32qdBkkL0+4Dlb00EbvrL7PZDB0D5erwDZF7AImeGdGYQJQpHgYWEBSCu7tJFRRhWiP4zM1Q+v71oD65kDKssE+MMInDT/lNtDeFOsQCXSSr6rI/ESVJ6QSUWEutNiWiOlx/i/y6WcdEXDxqBmxRlV3qFeQuXqsvO6HxD5Qv23XGElpbS9jjMu3eodUkFEVVcUUshhwqKPZxVVnc2cDNG6oQFX2Xp0SS1wPekCdZvs6UGAGyipKOSdsTlHCDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqMfwfSlPtoC9zIrQTFAYTbJiTs9u+l2NLSlVm7spy0=;
 b=q0FBF8ub+4UCT9VCj+yFF26+6JWny7rsTe9zedG5uOs0f3FdDfdCTNyTWdc/GGJzaGHqAzZenprPIeaSjLZfS/AqqhORo7Gm2P2rHdnLoI9JbgHlNJDIlxIAGkuZiosaYXFMFjqE0NVGXY1qK+bMVfRo75Ma6oacknLRgQaNs5E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB11545.eurprd08.prod.outlook.com (2603:10a6:10:606::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:21:57 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:21:56 +0000
Message-ID: <a615ab13-bd54-4051-ae61-2bfe8b59427e@arm.com>
Date: Wed, 17 Dec 2025 17:21:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq: Add boost_freq_req QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-2-pierre.gondois@arm.com>
 <416196db-ad73-42d3-8e52-bc120a822f31@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <416196db-ad73-42d3-8e52-bc120a822f31@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::12) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB11545:EE_|AM1PEPF000252DC:EE_|MRWPR08MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 2860a0de-b17a-4c95-40c6-08de3d888b9d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MlY2bXRwQTJ5R1poQU5yWmJIVno5R2pjajdaZ1pBUW5RMUVXMFlseDFGUlNs?=
 =?utf-8?B?SlNOeUY0RFF3aktFRlMrbGxpR3RzRnhqU3YybEtEMlFRMjNLMDE5bmxuV0xi?=
 =?utf-8?B?cTRleTRna3B5QmI4Ky9Cbk0zMzJEamY3a2NEdXN1Ty95OG9hYUlQR1JPZ0Jx?=
 =?utf-8?B?SUN2MGtaL1RQNmJqWWE0T05OamxnVlZLZFlOSGE2MWlpcEpDZVhsNE1RSjc1?=
 =?utf-8?B?SjhYWUZyU0s3R0trRDNweVI5MTNvdmd4ZEtjU1piTUtCRFpoZWJDeDJSbXlj?=
 =?utf-8?B?VWdaTm5MVGlJZHFvTVdEVEpYM2U3Z0FReEdYZkp5Ti9VWlBFVzlQczRZMmhH?=
 =?utf-8?B?MFNVY3VCWUFpVDExdERUa2p0V05yVlpuU0FLc1E1UDREMk9ZWVU4a3k2dEZ2?=
 =?utf-8?B?eHRRZUF3UzdpSzRpS3l6VnNTRVhhdmVyMFU3dHdZZUdmMUlBWXdPbVJhaUxw?=
 =?utf-8?B?V3BtUitYZFZlVFRxOVhaMlJUOHVNRWsyK0x2ak44T280Z1h2MjNPUldhenFY?=
 =?utf-8?B?T2VaaU94NlFXK1VFQllLL1o0TS9JZzBoSkdJQkJmQ1UzWUxXN3FYYXEvRmpR?=
 =?utf-8?B?SUdiWFljOEsycFFsc3JYc3JIb3RHdFZMYU5yOUcwZ1JoaGpnUmFxZGc4Y1pk?=
 =?utf-8?B?WEE0S3FaSU1WR0dSU2Y2MEFiM3I5MWs0eFZkbHEvb2QvZ0hpdW9icFRWRXBN?=
 =?utf-8?B?NWRwZlZ5UlJ4ZXYxcnBRTlZnZ0F0YURyWnRCS09tb1kzNWVER3lscy9MajV1?=
 =?utf-8?B?TmZIdGFlS1ZsbmpySVJLaytLVEo1V3VjbE1kWDVURlhJZ1dzTlluYWdnQTJS?=
 =?utf-8?B?UzZncDZrNWlYNDVjK3RqVFYyZUw4cERkMzZiTlVlMUwwMWlRMlYrdkNzTDFP?=
 =?utf-8?B?amFrSHNoZEV6L3N5NzFvODJBZEFkTVNZNGhLeExvNlltVURJN216ejAwZEhT?=
 =?utf-8?B?dFdtVUpaMHRTM0djM3lGbmtBOGcxWUo2QlRkNGwvY3o2R0tKSHc3MFh4Wko0?=
 =?utf-8?B?VjdYV01RaEVzV2Rzb3NVc29yVHpEVFhGR0tmU3VOS1ZhY2tBY3d2NW0rY0VK?=
 =?utf-8?B?UWUrYXdLdW5mMjQ2VVpRejRNM3EvK1c3ajRHM3A2MDk0SXpSTHhxcGNGaUd6?=
 =?utf-8?B?Nk5KNUpyV3ZoZ2pCMG45eUVNcm90UlY2ZVJKbURKcTRERkZGRnkzN2NwYVJI?=
 =?utf-8?B?b3V3M0krODA3aGxpMStKbVpKMkZjQ1V6d0ZuSmh6aFg0VW1TSGFWT3ZxN1h3?=
 =?utf-8?B?RG9iUU1jTkpPdW80R1M2cWhkY2w0czZLS0xwa09lNk1VWkdUWTRJSVhZbVZk?=
 =?utf-8?B?WFdodEtBczJjTUxhNGJCKzQrZzZuNTVRcUxWbER1RnBjZE5NZnVoU0dGZW0v?=
 =?utf-8?B?SGlmSGFGYVpvVjk0Q2tCNzFwcEJOSDhSalZLWUxCNUc5Y0c0MG5XdEpLaXRX?=
 =?utf-8?B?WmNsZUwrUGdPeDc0NDJmQklrZjRVeTROTkNnYk5HbUNkOGRkaHpQU1RzSThu?=
 =?utf-8?B?UXpGa2VGVXJiVkV4aVhMRkZkUyt4K0FHSTFvNEFJYnltNHJwT3VRV3pQdVQx?=
 =?utf-8?B?UG15dkcveUgwK21yTTJEcHpzYXpHNWVoTXpGVjdRRzA2MVc4Z002Q0MxeDVN?=
 =?utf-8?B?MmI0WUI0dWowSmNqZ21RcUFmdjdHZ2x3NzhDQStUNEdhTHZlYUF6R0JITXdr?=
 =?utf-8?B?Q1BJVDlRdDM3dUc5SDNDcFRzeTRRcENPdHNsNXFkSjh5dWp0UG14V3R3a1FY?=
 =?utf-8?B?VmFrT2NnUDlEd1k4Q1Npa0RtSko5NCsyYTE4VHBpdU1vdWlVdS9SS2txWHBl?=
 =?utf-8?B?UHcxNG5aeU1ZN1BKS3BhcmZpRlVGT053cnp5bU5iWGRiMWJMYjlPMTBTQ3NB?=
 =?utf-8?B?MTBXT0ZsR21FeDlYSUd5SGxmdHpTb1diS3lHeTZYNlVDTGI1V3UraEVCK3dH?=
 =?utf-8?Q?x8e3WzxKnxmFMwazkAMyKrQ1q5V6El7g?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11545
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5d08be6f-ef0f-4bb6-08f2-08de3d88654f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|14060799003|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDRhcklVQ1IrOFc0dnd2cXhvU3NDc09BeGJtb0Z5dk94NXE4cTBEcEdVZ2lK?=
 =?utf-8?B?bzZRMDhTOHNxbzdlRU05QXo2L1ZxUHBzS0FMVmJaZVJldFhpTmljUFZ6TS9z?=
 =?utf-8?B?UHkvcWowUWNHQmVKVVRPOGM2T3JYRVovN2QwSUFEZ0NOek1XMTJ1ZTBiVHRa?=
 =?utf-8?B?aXIyUi9PVnE4OHcrV3VweDFJSkhnVjZFUlVEc3BoY0xmc3BFVmVQRmh4Y0dC?=
 =?utf-8?B?U3NKUGpNNTlpM3lFU0E0NlF1Zm1Gdis4RXA0d3dLT3Rwc3QvYjVxVHl0WXNt?=
 =?utf-8?B?N0tuRnJZWHJXVXA4S0V1dXRLNjBqS2lkeTZXV1F6dTBvZUJKakYyekhOcGoy?=
 =?utf-8?B?ZnZSWktkZkFhV0I5YTgrcWdkdmdBcHFjdUNQcEd1bFlVdlpkZnhYY3BjZ3Vm?=
 =?utf-8?B?Q0xUSE1hejRiWHEvQjBLNFM2b1haVEd6TTUwTTlWOC9LckNjT0RrcjYwT1Fw?=
 =?utf-8?B?U3FvbnNKYmlkMlJZODdhM2JQL3ZYZVA4alBOazFCeFExWjkweGVCYjB0aHo0?=
 =?utf-8?B?TlIxZTVJU2VLazBQOWI5bHVPNkt5MmdYRUJobm44MjFvckRwaFYyUUNrMWFG?=
 =?utf-8?B?SDJqNCtCS1pVcmtzL0ttanlxcjlWZlRyV0lSdDZQUkd0Vm9QaDE4MGpJRjRm?=
 =?utf-8?B?Tm1xOTV3RE9hTlBSajdvV3haNjBpUGZPUGR5bWZXSU94c3BhNFNuRVlSUG1E?=
 =?utf-8?B?TzYvQkdja0xxd1lMcFhjZFlPbHgycENaK1BMbVFad3REblBRYmc3RlB0bDBN?=
 =?utf-8?B?U3ZVdEhqelR5ODlKY1hoak00bWlDTW5VeXFEUkllS0FFMUhxZGdhMkNySDZm?=
 =?utf-8?B?ZFZwZVd4T25lWDFnVjVaRFdJYXhDeEpaQWRNeFVqa3pqSFd1WStPMmpoSWNS?=
 =?utf-8?B?bmEvekxrbGI4MXBJa29JYWVUNStLWUQ1eWRXR2Y3SzVWOEhQUVF5N0haSVZO?=
 =?utf-8?B?TGt4RlpLTy9tenVCdy83UWY4bXpvNWFlR29wRStuNk1qOHVEc2xndytKUS9W?=
 =?utf-8?B?OEFnT0lvOWlPTFJjaHhWS3RxNFdTSjQwSndvYVdBdU5xYllmUWFJSzl3THQr?=
 =?utf-8?B?RldpaDl3eTVBRy93QkVUVVlpMmlZV051dHNGYnBlM2w3VlB1ZGUwTTFEb2Yy?=
 =?utf-8?B?c1ZlRis2b1FwaThXM05sSGM2a3Q3ZVlmQWI1aTd1MGs5SmRFKzByVjhrQmdY?=
 =?utf-8?B?bGxKOEhoRDJ4a3V1ZWFTZmdOTG9sMUc2VHZVOEtsTWRicXkzczF4OWErejNm?=
 =?utf-8?B?K3RheGlQNUpkbHZJTU1aWmNtVmVxMFIwWWhOUHVDa0xsSmVMR01pL2wwSk5s?=
 =?utf-8?B?aVlXSXM5NzhnbHhVdGppVXhGZVVVdmR4bVVNUHRDeU1naUZyS2xnc0dwWTgv?=
 =?utf-8?B?L0g5K3F5VVpPSWllMFpTemZ1Rm9JdmRveWUzNmI2NU0vbEJMZW1RWmREMEVw?=
 =?utf-8?B?VG9oeFd0M2c3MUliTWdRVGc3ZUM5dFczYWluVmY4L1dMMFI1b29nNGJlWG1B?=
 =?utf-8?B?YVhrUnI1SFp0UUgzQnJWRnRYOFlJbk1XbjQ1ZlJtSVRaaFR3WlZCbDBjRmNT?=
 =?utf-8?B?U0lMYkQySmxncmJGeEJoUGMzSXZXZ1U4M01TY1MyZ0pGU0c5TUQ1dVlFd1Ir?=
 =?utf-8?B?K1NXUHBNcXZDcDNkdkFBMVAvZitpY251ZUNtL3VuQkpUWU1TcmltM3IwR1VZ?=
 =?utf-8?B?V3ViVTFzdzhJUmRkOUM5anowQTZGQWxRTjNpNHBMT0NqdGFBUGhrN0t0WUFu?=
 =?utf-8?B?cVdHVmltaUxyUnNyQ0ZOTkpNYk40ckIyenhMY3Z1aEcwQk56ZzMxUG0zZDZJ?=
 =?utf-8?B?VnhnMUswUW04Z0Zpb2Y3NDAwMXNLcFYrdFJ6WUlxNVg4S2NFVlB3RU9kQ200?=
 =?utf-8?B?M0NkUzBxT3RUMTRHSXNoSjBlQzZzNHFuenNZTEhEcVhvRi93T1ZVVERYSEF5?=
 =?utf-8?B?WGhYd2NucmdUek5JdkdNSVhXcEdBMGJZaDA5UUh4YUhBUHhUTDBld3FWdW05?=
 =?utf-8?B?eE5uTitoKzlYRzdTUEZ2STNnOVBYUGRNcTcvemlyZWpiMjZhaUFLUjdxVEVL?=
 =?utf-8?B?VjRKbzNpdmdmVHNoRXJLS1kzVzNpbEtEQUloVDJ1c2UwNkVwZmdBSVdhMVNN?=
 =?utf-8?Q?AF+s=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(14060799003)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:22:59.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2860a0de-b17a-4c95-40c6-08de3d888b9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11826


On 12/10/25 04:01, zhenglifeng (A) wrote:
> On 2025/12/8 18:59, Pierre Gondois wrote:
>> The Power Management Quality of Service (PM QoS) allows to
>> aggregate constraints from multiple entities. It is currently
>> used to manage the min/max frequency of a given policy.
>>
>> Frequency constraints can come for instance from:
>> - Thermal framework: acpi_thermal_cpufreq_init()
>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>> - User: by setting policyX/scaling_[min|max]_freq
>> The minimum of the max frequency constraints is used to compute
>> the resulting maximum allowed frequency.
>>
>> When enabling boost frequencies, the same frequency request object
>> (policy->max_freq_req) as to handle requests from users is used.
>> As a result, when setting:
>> - scaling_max_freq
>> - boost
>> The last sysfs file used overwrites the request from the other
>> sysfs file.
>>
>> To avoid this, create a per-policy boost_freq_req to save the boost
>> constraints instead of overwriting the last scaling_max_freq
>> constraint.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 28 ++++++++++++++++++++++++++++
>>   include/linux/cpufreq.h   |  1 +
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 852e024facc3c..942416f2741b0 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1359,6 +1359,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   	/* Cancel any pending policy->update work before freeing the policy. */
>>   	cancel_work_sync(&policy->update);
>>   
>> +	if (policy->boost_freq_req) {
>> +		freq_qos_remove_request(policy->boost_freq_req);
>> +		kfree(policy->boost_freq_req);
>> +	}
>> +
>>   	if (policy->max_freq_req) {
>>   		/*
>>   		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
> If adding boost_freq_req fails, CPUFREQ_CREATE_POLICY notification will
> never be sent but CPUFREQ_REMOVE_POLICY notification will be sent here. So
> maybe something like this is better:

Yes right indeed.
However cf. what you suggested in patch 3/3 I believe, it might be necessary
to always set boost_freq_req, even for drivers that don't actually 
support boost
frequencies.

This might simplify this patch.

>
> @@ -1365,17 +1365,28 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>          /* Cancel any pending policy->update work before freeing the policy. */
>          cancel_work_sync(&policy->update);
>   
> -       if (policy->max_freq_req) {
> +       if (policy->boost_freq_req) {
>                  /*
> -                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
> +                * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
>                   * notification, since CPUFREQ_CREATE_POLICY notification was
> -                * sent after adding max_freq_req earlier.
> +                * sent after adding boost_freq_req earlier.
>                   */
>                  blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>                                               CPUFREQ_REMOVE_POLICY, policy);
> -               freq_qos_remove_request(policy->max_freq_req);
> +               freq_qos_remove_request(policy->boost_freq_req);
> +               kfree(policy->boost_freq_req);
>          }
>   
> +       if (policy->max_freq_req && !policy->boost_supported) {
> +               /*
> +                * Send CPUFREQ_REMOVE_POLICY notification here if
> +                * boost_freq_req is not present.
> +                */
> +               blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> +                                            CPUFREQ_REMOVE_POLICY, policy);
> +       }
> +
> +       freq_qos_remove_request(policy->max_freq_req);
>          freq_qos_remove_request(policy->min_freq_req);
>          kfree(policy->min_freq_req);
>
> ---
> It's a bit verbose, but I can't think of a better way.
>
>> @@ -1476,6 +1481,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   			goto out_destroy_policy;
>>   		}
>>   
>> +		if (policy->boost_supported) {
>> +			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
>> +				GFP_KERNEL);
>> +			if (!policy->boost_freq_req) {
>> +				ret = -ENOMEM;
>> +				goto out_destroy_policy;
>> +			}
>> +
>> +			ret = freq_qos_add_request(&policy->constraints,
>> +						   policy->boost_freq_req,
>> +						   FREQ_QOS_MAX,
>> +						   FREQ_QOS_MAX_DEFAULT_VALUE);
>> +			if (ret < 0) {
>> +				/*
>> +				 * So we don't call freq_qos_remove_request() for an
>> +				 * uninitialized request.
>> +				 */
>> +				kfree(policy->boost_freq_req);
>> +				policy->boost_freq_req = NULL;
>> +				goto out_destroy_policy;
>> +			}
>> +		}
>> +
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>>   	} else {
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 0465d1e6f72ac..c292a6a19e4f5 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>>   	struct freq_constraints	constraints;
>>   	struct freq_qos_request	*min_freq_req;
>>   	struct freq_qos_request	*max_freq_req;
>> +	struct freq_qos_request *boost_freq_req;
>>   
>>   	struct cpufreq_frequency_table	*freq_table;
>>   	enum cpufreq_table_sorting freq_table_sorted;

