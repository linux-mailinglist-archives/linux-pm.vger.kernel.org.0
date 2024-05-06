Return-Path: <linux-pm+bounces-7534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F100B8BCEB7
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B481F2496C
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E0B6EB76;
	Mon,  6 May 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FlxtB5b8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110A44C66;
	Mon,  6 May 2024 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000954; cv=fail; b=IZaSvV7/P7Uvd8z21ImtaYvSllRIn/tqcSpyI9D6Ky6p6EUTUIGhdAYNVKfxVg9YKepIJn1jmvjolQlwPwAqoD5LzRhwSEqkyTqL83rwVYw4iHuuaaVZf0UdYXK2F1SfsUm+l1hWAA4kpEQ5We0BR98r0zTG6LXwWZOz8MzKO5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000954; c=relaxed/simple;
	bh=rGeY4iCc3LgkhlHIeDTWEWwN1+wqHg46ky4n1JuMOXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gT6A7GSDWyeV8+wGgjAohymCWQdABsFqo0KwRNlZS/CxWVrp6XBkMfMUD7Un8tCDJW1fmhsWPfRix65m6FhcX0e5+hgaGNtHkFoUgzUpXPzrzhAPOros6JdC3V+5WnSKUNUPMW0rs7nSCDaXMk+QV60Q64QIokZ1iqZGvMNOPvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FlxtB5b8; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGuVXsjDsWkyGnaoUI79QkIa8Sgt6J5yvXaWI8g/kVwDPouBUwwN+CpoaPEuiCD7fvXEe2lJMh6QhWgOQet8/xjc8Gc1jSvoMtIcAhVMbmLXbPQGIObmasUN5QYQfMayC5zqI23wcrhBa5sfoeOvaSG2ef3YE61cn88kcoXyKTfkf7ijdBqOSt8olbpJiBrOJR/m4LaEqIk9XpRq43iCvl7tMXLz1Hmcqr32gcdv9r2J9dFZJf5owlreEWcIHBdmbrrzRVngUXVcZlfeTUizjwUmd4Ud9Iq1zMtU/5wDU00rILf5hHKlpULflT+i/0Q1Z9mvon7rav8Wmb2KNZL1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q2IBjsxeIoBEtJGf/NnlB7NeNc6qAmN3Hhj+1x852A=;
 b=klgatMu1ISh8ScoqDy3RBWluYfGsgr1KZWN8q4vyhpzDUXNVD49gADjPMpFtDfcapj/IVQpy9TxMLEdYzCEbfuvUAo5m7dOrNNGihSy4tdf4OXZ2epv5ZM0SCA+Wg9EVUuSwBeyrBB6BMGGsHH9gituWupsOWidzB3np87iZkCUX/4RxzFGU/u1Luim2DwiejCVmJBcV8yrNUVi7ah9nKwQPeHIsKX1cGDYWo9R/R8mQAobjQbUFidGGHzgYELkMAXcOT7SxMq2GJyAeLj18eWng2GBguPo+QZy2gUnkHGtP/MPGGRKq944F1NUAcz/oNryEY2kCymk6OW9HioZZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q2IBjsxeIoBEtJGf/NnlB7NeNc6qAmN3Hhj+1x852A=;
 b=FlxtB5b8xkPexq1EpFtp2KKyTAGe0olYzHk4iss3Rf4PijhSeslCQViB107gkMN1rH0reo9cuqPtV7uderqFivqSKsn0H53uoKHRIpkuz9TGLWmvXPXkk+Cq0regc5kAUtMjoUyE3tq/8e79qgp7wL3VjZP+7aYXWTreEHUbwDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 13:09:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:09:10 +0000
Message-ID: <a7ae8fc0-5e53-487a-86c6-f49dc6623688@amd.com>
Date: Mon, 6 May 2024 08:09:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/chrome: cros_ec_framework_laptop: new driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 "Dustin L. Howett" <dustin@howett.net>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
 <613369f9-42c5-4a59-b83f-45bd1773ffe4@t-8ch.de>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <613369f9-42c5-4a59-b83f-45bd1773ffe4@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3f255f-38c7-4dc5-f1c5-08dc6dcdb7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGcyWmFNQ1JhSGtSR1dSUG9DdFhIeDRWaUVGV3VpTzlmOUZYbGdtdmM1UzRr?=
 =?utf-8?B?UkFiTStvRTU4dzk3M3d0LzA3SEs3UmIvRW1CakpybHIrNE50WHMyTVNnb2NP?=
 =?utf-8?B?QkpnVTF2cS8ydUgrazZtYjcwS3RqOVBXMnM1T0FYMDdFblVsdkxjN2hOMTVo?=
 =?utf-8?B?UVl2SkUxZ0ZWVHI0c05BVFZ2YWxJWElyYngxdXlaSjg0R3BVYjdIR1B0L25o?=
 =?utf-8?B?ZTYxc3ZxODJLSDA1MWcrc3ZvbmFXaDh2ZFdNWVE3K290c2F0WDVuRTNBbndM?=
 =?utf-8?B?bmxxSEdIbkVqbktTRGV2ZzlpK3JwcFhJcXZZOW9RMlYrNThoeFEzTU16NFRB?=
 =?utf-8?B?cEFFOVkyRDVqSVp6QTF5VFhuMVVYdGJod3dza0ZLaDJYLzJYWHc0RXRtdW9s?=
 =?utf-8?B?SHJpbGNYbHFEcithMW4wdGFrRm9RNUtXdzFUTFg5UXVtZkgwMFI0L0RQVDBu?=
 =?utf-8?B?TG5PMURranpyVTlFeWF6VHU0RUpxajM3MkpmTnBpYVNIZ3ZTb1ZNUDJYL212?=
 =?utf-8?B?bTc3bVgxbHhqMmNicnQ0bWIzcktUS3V6dXBPZDNuVFVqa2o0bGJ3UmZQNFhF?=
 =?utf-8?B?QVBvVmZDa2RHTkJHK2ZEVUU0ZW5GYkxWYWJJT2U1U1g0MUJ6Y1pzays2RGI4?=
 =?utf-8?B?YXEreGprRlEwM1NxUlBXaDBXRXZMOHRaUGovMW9OY0xoR3ZSbGc4RDlOZ0U3?=
 =?utf-8?B?clYwK2s2Z2VucjlHNFdkWmxFUld0UksyQ1JqUE9vZWdsMit6VDV4Y1g1YytC?=
 =?utf-8?B?SHMwZVdsb2taM2MrcXhaTk9PdlZtRlozdEtYeVp3eE5kcWN3a3VDNVlMUG13?=
 =?utf-8?B?SUM5YWx2U0xtU3VCalA3N3pJL0tWeGoyR2NyRXhzNkRoK3N1S3BnUUVSY3RX?=
 =?utf-8?B?elJsaTFSOUZSOTk2MHQvem5heWZTTm5ERkxxd0lCMXFCbmNpVVJrRHgwbzFu?=
 =?utf-8?B?UTVIVzF6ZVoxMnpaaVZ6NUZweUFWWmoxQm9valFFWitvWkxSSGFNSkE1blRr?=
 =?utf-8?B?bFcxSis5UC9KbTR4c1RjWUtsVVRjQ0lZeEM1Zi9jRlg0SWc4RzF0WTR4Wmx2?=
 =?utf-8?B?QWhGQWY1RWErNGo5d0ZjRFU0Vk81MjBBUG1mYXdjZ0N0Qk1JMWV0MlNTdHFa?=
 =?utf-8?B?aHpDNmdISVZPSjNKc3U4MlkvNFZrTHNKOFJPc0M0NWk0dG9nbitKa0t1b21W?=
 =?utf-8?B?anprWUtpWGNyWW91empnOVp6TCtuMEN5YTRGQXlkQkFWbkxaYzh6aXQxYlox?=
 =?utf-8?B?Tk4xU0xha2ZQakFCTXVUZC93SmJGdXVtVWZJd0x3Q2JKbFBkbE1oSzFJdnpO?=
 =?utf-8?B?Z3o0K2VhQjArV1BNbWZJRGJtRjBDdUNVcDlTTURyQ0RlWjF6QTQxa1ZLOE1Z?=
 =?utf-8?B?R05RWFh1TnovalRCbnBSa3NhRi9iVDk5Z08rbHdZOTU5QmJPR21lVE83NmRt?=
 =?utf-8?B?VzV3bU1SQXNJTDVRT0VDNkc3ME1VWGxFV05xNVJPOWtHenVGTGZtRmxrMnFV?=
 =?utf-8?B?dGxTbkhMWkhvTnVSa0ZsODJOR1FqaVQ1enNnRmhhNnJaazBqUkdxdWVsZXdE?=
 =?utf-8?B?MEJKaVBCTjVscmVDck4vazhpVGZ6cDJUdStvb3lRSTh6WVNpVU1sYXFkUzlI?=
 =?utf-8?B?ZVQ5UEF1WXE1ZXhkYmdMQ3ZMekt1QmZLRDZrVnBDbnRTMURIOWQ3Z21IZlZH?=
 =?utf-8?B?YUhqcTV4UWxiNnBhVkdnNzVJSWJLcVg3K1g5WmRBS09tM0JUVW5nVTRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk9PdzF1MzdWcTdCdTNEQU9jMitUaFNzZWlWRmR3NER4K0crMzdkWDErdlR4?=
 =?utf-8?B?c21WbGhPUTIyRWo3ZU9SbTlqanBkTEY3Y2xQZ2Y4a1lvTWtIdGZwd25hRVVv?=
 =?utf-8?B?SlRkMUhPNjlFdUFvVmpRVm5rdmJLQlFXL0xLUFluMGZUN3hYVU5FZkJrd21C?=
 =?utf-8?B?aGExUjVXSmh2OVlEWWZBVkF4TSs5WlVEVFZaTFNiMkhHSFRPNUxZNnN0TXFs?=
 =?utf-8?B?bk1ZcW9rdWdYditMYWFTSWMybWtEb1RsaEV5SVl0bjliSjhQWEd1ZWJzL3lo?=
 =?utf-8?B?bjRPeVc0ZTE5eXRIaTVhajJWdVRkOXF6NTlvcXgzN2UrL3dPQVdTMEp4Rmwy?=
 =?utf-8?B?QXI4VU0xQ2tLVkIwdGg4cEF2eW54aVIzWW9EY24yY2dJNm9HZkExVkVxWkkx?=
 =?utf-8?B?STk2VWxmaFlkYlNhUnBucXE2MVZ6QlJ0MDNiNlhBN0Y2eTh4Mlc1dlNWVmlU?=
 =?utf-8?B?S2ZwcG5PaUQ0N21FM3g5R3Y4YnZ2dnNnc0ZlUFFMMVE3T2dJMGhhNkMvaVAx?=
 =?utf-8?B?eVhvYUtibVRPS3lIdDlpSS9jakJZczZGTVBMeHhtUUJaODhHOXJ0eWNzSE5h?=
 =?utf-8?B?S2hQRVQ0OXZZeExHa09ld1hsUDhhVUYxVXJkZFdtaCtjcStLWkxlc3ZpUlZs?=
 =?utf-8?B?c1NsR1dTR091dWp0aG9yL1laTWdURE5MUGJ4QVBiYS85RFdSTEZBdk94VXhl?=
 =?utf-8?B?VG9WR2pOeUxxVUdhdnVZejZDbS9xMGdqVlpMc3NZKzhzZ243UVRLQ2Jpa096?=
 =?utf-8?B?MHZidldldWxWMk1HTllGTnVFRW1vTXY0Qk5GYXd3MTdIS0UzeldRTGtvRUpV?=
 =?utf-8?B?Q2NyZXRFWGsrbUN6L3VDczlVVnp1N084bExxamVrMGZ3T2tjWDVCanZmZDdQ?=
 =?utf-8?B?cUJ6bms5VlhOajU2azFuVU9CODhYN2pBeVZVME1zWkpmdmlBV3poRE9TM3Rh?=
 =?utf-8?B?UmRCZGc2ZmIvbXMyU3ArVDJTaS9jaU5qcGlQbUxaOHArMFlvcDdCS0VIamJW?=
 =?utf-8?B?OEhsZWRxa1hJYTdqT3RxTmhYTzNOOTQwYUxFcllzZ2hUSU9NT2l0QVBOWUVD?=
 =?utf-8?B?MVRWemU0YUlqNEw2dldTM0szWTVFY0p3MDJuSVpuS1Q3ODlwUUdlNWNnMGMx?=
 =?utf-8?B?SGhjYzhLZkh6ZEwwRVFkQWREeEsvQXcreGo0Zi9yV0N3ejAyRW5NMVlaL1JX?=
 =?utf-8?B?MmpZQzJpTlVtUEgxR0NNYTBiWDBFTGY1dTV0aVNZYm9scGxYQjBQbVRZQ1Q5?=
 =?utf-8?B?S2tvK0I1bzMrS3h2SU9lcnhEUlFMaUthUVY0bVh3UDk4Y21GM2QyRzFjb0s4?=
 =?utf-8?B?RWtzTGNJZGRoUHNyWUsxRUdaVTVtYkxwZGN1Y2MyUFRWc2JrdXZvZnpxVytv?=
 =?utf-8?B?S281eVpWZ0tGejEyS3oxbmxGTnJIMVhTemVHR3pUSEpGeG1KYVJhVzhwa0dZ?=
 =?utf-8?B?T3JpK0UrZ2U4SW9Nb2RUTWlaNWFyMlgzVkxhWmNXU1M3ZmFia1RMd0NvZHha?=
 =?utf-8?B?SG1maHhBRktwakMycXg5YndQYWtvYjdxUHluSExOWS9aTHZWL1JvQUhOSGJl?=
 =?utf-8?B?ejJNUnNLdnJZTzRTMWdzdEJaUGVMTVhqYzZZUkNzU2dLL3ZhM0d3TlFtZXFp?=
 =?utf-8?B?dWRSOFJrMWVPdkhSQ2lyRTJnQ3ZaanRjN0VVMmJDdjJGSWlXZnlxK0htRGNx?=
 =?utf-8?B?ZFZnT2hEUHJVM2NmYi9iaDA0dlVtTWw2b0xUODJuc2IxbG9wSU9jNW1NR21w?=
 =?utf-8?B?bHdsUkgrNFlUazdsTnRCbzZ2Y2V3RzREZHVhZ2ZvWjltcWptSndoUUFRMHNr?=
 =?utf-8?B?VXQvNHp6d25sS2laTEk0Q0tROXdqK2c4Sk1ybHdCUm9PTDJZdGlSNTVLd2sz?=
 =?utf-8?B?Qk10aUZJUzJWY2RON1MxV282VnVNbW1WVWNXTHBCOTMxNkF4QWhlRlgwcDla?=
 =?utf-8?B?Q1Vja2wwN0NEUnFnR0pZd3ZycVhwK21tRFpGT21TY2t3bVVQeSs3czZ0V1h0?=
 =?utf-8?B?cnpzbGtYaWhQNnRLOENVYWI2dFpPVUtkdWxQRVlZdmhuNmMxRUREd2F3cndu?=
 =?utf-8?B?enRSK2dleGJLd1hPK2FiODBCS2k0SEZ4Q0RBWlNiZUg2aDRJOXJXejU3QUha?=
 =?utf-8?Q?3rWuDtlgfqtc92M0ZOJOl0452?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3f255f-38c7-4dc5-f1c5-08dc6dcdb7c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:09:09.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKcWseJJqIzPaxSaMywo5d5ttcmhR46kUDXtmmXb5W3WYtwTA+dnwd0Qwgpgw25BCsTaS5YmD2N+sjItKatJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144



On 5/6/2024 1:09 AM, Thomas Weißschuh wrote:
> On 2024-05-05 22:56:33+0000, Thomas Weißschuh wrote:
>> Framework Laptops are using embedded controller firmware based on the
>> ChromeOS EC project.
>> In addition to the standard upstream commands some vendor-specific
>> commands are implemented.
>>
>> Add a driver that implements battery charge thresholds using these
>> custom commands.
> 
> It turns out that standard ChromesOS EC defines EC_CMD_CHARGE_CONTROL.
> The kernel headers however only define v1 of the protocol, which is very
> limited.
> 
> But in the upstream firmware repo there is a v3 which is much better.
> 
> The Framework laptop only implements v2 which is also fine.
> Given that v3 was only introduced late last year, it seems better to
> stick to v2 anyways for now.
> 
> So please disregard Patch 2, I'll see on how to use this via a normal
> cros_ec driver.
> 
> There are some other Framework-only features that will use Patch 1,
> so feedback for that would still be good.

What other kinds of features do you have in mind?

Considering your above finding I think it's better to put patch 1 into 
the series of "other framework only features" that will use it so it's 
clearer if it's the best way or not.

> 
>> Patch 1 adds the general scaffolding and device binding.
>> Patch 2 implements the battery charge thresholds.
>>
>> This series is based on
>> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>> Thomas Weißschuh (2):
>>        platform/chrome: cros_ec_framework_laptop: introduce driver
>>        platform/chrome: cros_ec_framework_laptop: implement battery charge thresholds
>>
>>   MAINTAINERS                                        |   5 +
>>   drivers/mfd/cros_ec_dev.c                          |  13 ++
>>   drivers/platform/chrome/Kconfig                    |  11 ++
>>   drivers/platform/chrome/Makefile                   |   1 +
>>   drivers/platform/chrome/cros_ec_framework_laptop.c | 173 +++++++++++++++++++++
>>   5 files changed, 203 insertions(+)
>> ---
>> base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
>> change-id: 20240505-cros_ec-framework-10e627c46a0a
>>
>> Best regards,
>> -- 
>> Thomas Weißschuh <linux@weissschuh.net>
>>

