Return-Path: <linux-pm+bounces-39295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15003CACDB8
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 11:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAF43064BDD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C402F49F0;
	Mon,  8 Dec 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P7QnYCLd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P7QnYCLd"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D83101A6;
	Mon,  8 Dec 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189565; cv=fail; b=oyUHuceTtP7+menIInsM5oN3WwJTUV3iBhJIoQHQB4swlfwbaGxbB9P5jGXX4nsTOItJixoEFZeXb9lyCFGFeK0p0AFgPww4Qfw2pQPuMwFtxGV2Y+NigvI7XM6WXKfBXgIAYDqNZT1Z/OpKII42qtPSu/MvV3zSYG39skcRsU4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189565; c=relaxed/simple;
	bh=3MEURXP0qtUaZGv4WEp3nr7tP95TQyX1UB6cxkBi5M4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VAcBet8kVmDcGbj2Scti5lWAOgGuinDS+e3P9nxhTah0DZ4NvGWpfLKy20bi+qGO7zlcifd6I/JXdN4cXJQTMbdYvQTQJhUt60ZyUR4c6j7EtnV0J7qKJqLihzZzOMyK/Qfu9+OwuPh5XRhEUL2OvQMRTn31pGQoVDfPx560Gko=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P7QnYCLd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P7QnYCLd; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W+EOLr1DIBT/Vv7UX1BkVyMDznP9X2iuWJgJLglJmothPVOHwPBMFcXToGREw/d6qhT4oErSwB3OfIVpDZD/NxXOQQ/yfZg9+8hHAnfVmx1wN6CiyOsoDTF+GHGn3uIy7BlFgrHh4WX8hvnmqeFliWzxeijhQTjjkHpUF7cMYCp6C5Li0M3RIowhBb34/6qVccXmXnFAUC4lee9wRpW1sdL3tn/jkcuUMxNC9By5LK8TDceDpZQJtg0HAzEA6SjrPkLSP4q0UKT6berWgycAvS6+Cgeo7Rm7Ajednbe/MOfA/48yzOTszQNBVg/f3cX+epDF85A3uOg7uSJUUnhAtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+aedqkP3Fe2mK7cAwCd5K1j2Xp6W8YW0TFaomvwNtI=;
 b=vHay3U45roQk0gbZDInO7FVTlDpnAzCVjTUOhjS0usaRFvgpbCYSTIohXJQUbDog2ePyXeoIbldRKwRtsXCAvpobUfMaOrci/pn8xTr30ddcOVd5JCfG+76Xj7SmvgkQOX0eftyj/UGEsv1WdPmUq1cZmUA1X55C1zCDCz9nbpHhmXD9fi/xcOboyH7rZKejbUE2h1btHdUj2gPX/7Mzsm79hs1wf+hN79gLhyaGBH+J9vVvEWcsTIKWx3iaHiTnDfgTcp3MXjYEp+mbpLf6mvrBumAwFbkxC3zoIoUMnbUY4wQP+RBoIu40wCSDJmfbqJ4UK+JEFlKI0FFFQksF/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+aedqkP3Fe2mK7cAwCd5K1j2Xp6W8YW0TFaomvwNtI=;
 b=P7QnYCLdWfGTOKezDTTxj8nTTu6rd1+Dp6Jy3eQOZJ0sN6KMvL7Zp0IBvXHYbakKduixK1ZBU2Rx5FnzyqTx+wfOyD9R1lvH/Ia6/qpduaxMN2ktmbXmne2hHfgn+PkWAM7q136Mw6+ryuxaWXmTmz3ySvn/JNYN87BSV1QsQaw=
Received: from DU7P194CA0013.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::29)
 by AS8PR08MB7741.eurprd08.prod.outlook.com (2603:10a6:20b:525::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:25:58 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::cf) by DU7P194CA0013.outlook.office365.com
 (2603:10a6:10:553::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 10:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8 via
 Frontend Transport; Mon, 8 Dec 2025 10:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkJCGhIbsOEXXtENBbupZM3jVbOCRPdv3VkA+U7qmgV9gu+Ol+srfmE8Foc19Rx/LEDfCU0HUVCHYjzOcNozmShq6eSZWPCJMFdo2Fl05ZnO6WI5dOnlVe+uVV7PmyIYKhXn/8Hqx/Y/3OFWotME9I50tD9FsJdZ8fCmY/GGjDBX26T5GIovtpfNgoAApFvzw/nuRy6aptfVCEAj/XkYruE7N9dOdflsDmDZmvJEYY05YN04C0291QjPdcN+49r/wMQDMLWrnAJ4YiT+RnwtPrL3TH8Tb1Q21vQv9zQdq5YZXgcKDXQV0eXLdWaNwa1Vs1MtrSjXaE2rdgkrmJmlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+aedqkP3Fe2mK7cAwCd5K1j2Xp6W8YW0TFaomvwNtI=;
 b=Suc3Xyja4B9OdLJzWPfzDeveZcOidazTGfrrbga7XACnvGZuOTXlfD8pyRPJhuvMLcnevHXO8SbVrP/9hPaJxPFnDRAfJYPJt8jQ+BYB+ZTtrVu0QIHImAWnkCISVaq3zucxPSdpyzgmjFuntSFHZpj9TNzbqocvRm/I1yWJHbkQhDk+lkXe+d8ZrxlfW7u2xwOeFc+VFfVG5rFzzZ/FcMV48rn+xC0t/Kh+U4TepAAtDuGvmCZuScAnVKSc9oZem/ubbwbSp37Ou1URqOfQkRQ7vhLiSvQRcWT+5WhO9TeSIVijQgVpW/SAsyR5Jn7mS7ZFtzMhE/tIYA8gH/INqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+aedqkP3Fe2mK7cAwCd5K1j2Xp6W8YW0TFaomvwNtI=;
 b=P7QnYCLdWfGTOKezDTTxj8nTTu6rd1+Dp6Jy3eQOZJ0sN6KMvL7Zp0IBvXHYbakKduixK1ZBU2Rx5FnzyqTx+wfOyD9R1lvH/Ia6/qpduaxMN2ktmbXmne2hHfgn+PkWAM7q136Mw6+ryuxaWXmTmz3ySvn/JNYN87BSV1QsQaw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI0PR08MB11688.eurprd08.prod.outlook.com (2603:10a6:800:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:24:56 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 10:24:56 +0000
Message-ID: <79542da3-62af-4715-a725-c0c1ee8c6be3@arm.com>
Date: Mon, 8 Dec 2025 11:24:53 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 3/4] cpufreq: Centralize boost freq QoS requests
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20251204101344.192678-1-pierre.gondois@arm.com>
 <20251204101344.192678-4-pierre.gondois@arm.com>
 <5dded7af-51fc-4766-957b-1af044c52159@huawei.com>
Content-Language: en-US
In-Reply-To: <5dded7af-51fc-4766-957b-1af044c52159@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::22) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI0PR08MB11688:EE_|DU6PEPF0000A7DF:EE_|AS8PR08MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c77232-7254-43d7-5517-08de36442d76
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bVVxSVQwbVhDSlVvQUI3QmE3RjJLNUJ5a2pVNndGNGlJOWcvelFjeEZITkps?=
 =?utf-8?B?STRocXVpNE5wNmE1TVYxTllZR2JkQXVoaFIxMW1TcEttbjlNa3hWbzh1VW5L?=
 =?utf-8?B?YkI3ekFPMWMvL1RPY1gzNWllRGE2WkxpakljTG9aY1htY0UvSklDWXdha1pu?=
 =?utf-8?B?L3ZaSmFpS1JVK2lOeXhtWWpIZUtVME9JcGdjeWlDVk40OVlwcWw3dnZHeFNr?=
 =?utf-8?B?ZUs0UUZQc0Z4MjE0dEJyTUFqdjRMN0svS2IvQzI0Yk9nT3J1YVIwTXROd3g3?=
 =?utf-8?B?Nnp1Z2VJMnEvbkpwSGlRaGo3WnZaVmQvak9PR0hqSkFPMDlJUGpxdncyQ3VO?=
 =?utf-8?B?NmFvbnZ4RnVTZzdmN2pqd3pLbHBxTnFienc2UHZtbVA5VmU5dzRtM0c4QS85?=
 =?utf-8?B?RDZ5U1I4T3FVcGVvQXdpSW1CaDRMMS9jUTZNWkcwc1RqRjdCT1R1SG1Ta24v?=
 =?utf-8?B?VW1XRlh3WktiQ1dJTXMzajFNR0dNVk9SK0VIK244MENTL1dpQ3NyNk1zYllT?=
 =?utf-8?B?YTBhUEg1Mit5Ui8xRGFVNkNnWTlNM2h4eDF1WDhEZkVOcUN1dUpuK0tTamFa?=
 =?utf-8?B?K1J6RThrYlp0d3pqUEI1M0d5V3V4U0pFRFpJc0lhZUhGK09OYlM3anBmd2VU?=
 =?utf-8?B?ZEN5bEovNmxSdlUzQXdpQ0w2anQxVzNLTnV2RWtEMkwzdU42QkFrdGROeEtB?=
 =?utf-8?B?ckhmOTZpcnAxaDVFUFh1aVhNKzJKYnIzTWlza3k4N1MxUXcycVdYZWxzMXY0?=
 =?utf-8?B?UDJ0b1hKOTNCSnpJMStud0tyalRqMEk5M2N5Z3Blb2xiSzVMTms1bFE1aS9Q?=
 =?utf-8?B?RFNyMG1MNGVhbmVxeXpaL1VrcjZ4b3RXSGp2NHg4UGN3OHhXWWVWODdrU2Fp?=
 =?utf-8?B?aFl6WXFDeml5MTBxSWRnUU5LMitxa0JiZTlyM2NhR1EzeTQwcFl5YVhzaUVY?=
 =?utf-8?B?LzZSdWM3N1k0Vm1GOHVCSjFwejhibStMajZ1a1dYSjJsWUNZMWVKeG4vZzZB?=
 =?utf-8?B?OGtSZ3FCdUpwZ0NhQXJON29HQStvc1hSNlltUE5TQTBrOHlPZE9Eand4d200?=
 =?utf-8?B?STEwblIxK1lhbkJOWGZwVFBvek0rVG0rdXFsZGpmNXRQUGt5aW5nY2JJaitp?=
 =?utf-8?B?cWFGb3BIUEVwbjZ5SjZXWURDbHIwM0hvNkFYcWF2TUw0eVZXVE10UGtyY04v?=
 =?utf-8?B?Y2F0eTJ6eGxVQW5EZnVCSDRQb1dBTTJ3azdsOUhLTWtlNDRxelJRVnJCTzRx?=
 =?utf-8?B?aVNXMVN4VGlzdEdlYWtFMVFGQUdlLzVJSjVJaStEUlRobkNLS2FUUGhOcFRT?=
 =?utf-8?B?MnI4TVFseVdzMjUrdGVpV1B6ZTQrWTQ4N1pJYnpUZmdBRXFSK3NDOURKeGda?=
 =?utf-8?B?RGNESERUVUdxV3R4MGUwMzh4SUVkVUZvdUVaaGxuQS9OUTZ2NHFwSDJZU20w?=
 =?utf-8?B?dXVHRlJiQ3ZjWmVHa1BEcGVLT25SVGpoWUo3S0RqQXZ5OWwxOGVNcmp4TSs3?=
 =?utf-8?B?VEpIQnBsdFRZeFhMS1FmRTJjazFScDRZUVNLTXNIWW5RWFpZREFTRXc4Y3Bn?=
 =?utf-8?B?dHpBRVJ4aEdNbUpEeSszNC9aQlBLeHJKTk4yZ2M4dm9Xc2IwbWp4WXB5QkU3?=
 =?utf-8?B?SjlUYk5makxGMUdvb2Y3Y3pBSzVsRWVkaHNYb0lwOWIwdkcyYmxQLzNGaGk0?=
 =?utf-8?B?T3dWbTU0R1VjNzhlbUxteFdtbjM1bXNvUWNndU5yQVcrWVZhaHk2ckdwSXE3?=
 =?utf-8?B?V3F1NzFLK0U1Z2MwQVlnUGJON3EyVXNQVks2S3JtMnRuSTV4TkxaQ1JPQTBG?=
 =?utf-8?B?RXR5eVN6V3FOVjZWT3g1anpoUEkyOWd6Wks1QVBlU0hPTWFoNk1JTE1MRWM4?=
 =?utf-8?B?WGZJdnJwUXY1TFYyRnZFbVBaaTk5b2kvMlF6SkFsNHl4QUkwVGJRTUtHOFda?=
 =?utf-8?Q?0h60Gz9KAtr6QA3/DgpO4LaBn9nXOhnY?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11688
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	74152619-3bf8-495f-b6a8-08de36440833
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|36860700013|14060799003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a25mYUM2bkkzQzE0NzA2R1paOElsUVF4NUl4aWszQlZiWFFYVGlRU2p2UmZs?=
 =?utf-8?B?WUhRKzNSR2JvSjI2WXZEMnlIVXdudnBXTFE1QTBENTNhR1pPdVdWQmVHeW90?=
 =?utf-8?B?WXhrWndxVWlySG9sZ2RlMXRHdnFkMThvN3lERDZSYVpIMk9EbVZOS1FuT3NV?=
 =?utf-8?B?eW82SmNtam5wODFMQ1hEamlxUWxFQXVVRktoTW1UMFM1d0FVckNTVnZUY1dW?=
 =?utf-8?B?QzlOVW90UGhDaHpQZVllYzVTb2VXVFJFbkJkdVRyVlNVaUEwS1J2VHpFaFAy?=
 =?utf-8?B?aDZpYTlJS0JEZG45K2FUdWRudlpjMnRHUXRncTBlYXNlWGROU3ZXamdEVmFi?=
 =?utf-8?B?ZDlmUzZyNXpVM3RUUkRMbVRCcDNiaUM1N0lvY3V4MkZKbkk1MmRUNTFseXBB?=
 =?utf-8?B?OVErVGw4dHVTeW54V1NlU2RUbWx4KytDSzJkLzhzZkVjNmc4Zm5nOUszaXJj?=
 =?utf-8?B?V2I4ZGVJMmtKbFBxUERudkJVVjRXSEFaajUvQ1RtY0JsMnNhWS9VVEliNS9N?=
 =?utf-8?B?MmRCdmh0MVF4V1hYQlZRakEycEFyNG1PNDBPSFFJbkRpcklNYnRDeDBkcXl5?=
 =?utf-8?B?bCtRY2VzbUlsNXozL2t3dmRSL2tqTmlJUXBxZEl2SE5lTGd3OUljT2Q0bUhz?=
 =?utf-8?B?ZUNWalhIRnBpT2V2Z1p0L3ZLZnNSeGoxMnRlR2VubXppaXhiNkVRQm5xUUs4?=
 =?utf-8?B?eG8zYzU3VjR3eDQzd0loQ1pyN0ZDdXUzUmMwenlpNzE4bXVUM04wMy9ycktP?=
 =?utf-8?B?QWFLUXVFaC9GaVRoUDI1TkhoN0Uzc2lTTEltUUlmUG9tMTFOMmZMVFAzZ2w4?=
 =?utf-8?B?V1Zpa1lSTi90Mkc4M0NRRklhTnZ1UVdER2RFckV3U3lkQmpycWxOT0didS9L?=
 =?utf-8?B?enhuV2RmV2hZRXBxN1MzZHJTd0lRZG5jOXoyZlQ1QWZUQ1hFelo2aWhQMG1E?=
 =?utf-8?B?TXVLOUt6SStDTS91MHprMklCcWpUUUh3ZU9xVkF2VmtCMWtnOVVDSVorVzlK?=
 =?utf-8?B?dkhZTytvaTZEWFlzSWcxL1dreC9iV09QNzZ1UjF3TjZPR09MT1RsdHdCdWVW?=
 =?utf-8?B?Q1JHby9oeEIrenQ1NlRPcHZCL0pjbEQ3amt1bWlGdkQzZklDMWt0dmEvUjFs?=
 =?utf-8?B?ZVhJSDJuc3NrZGludE5pNFBUMTNjTGhaOXBGM3RockcyZEk0bENva1VraEh2?=
 =?utf-8?B?eDZkNlY4WStlMjVya09mR3pMWUhSS3I3ZTVKQm1ydGJUZENzcVNWWWpDcG9o?=
 =?utf-8?B?QnNwc3NXNUY1MzVUZDlMbXlCSStKaEJtcXAreUk3aFVOTU54dzFkck53ZlpM?=
 =?utf-8?B?Z2xqTHJZVlVBMk5zSkh1cUpGeWMrQkd0b2s4ZjJBbUVQZ2hzaWw5dVZqbG9R?=
 =?utf-8?B?Y0lwdDFnTjJLKzA0c2VILzRIZkNNUGFoVWI3dGpUUTJJNVMvbUpuTXowdENk?=
 =?utf-8?B?Yi8wdXROaUxrQzNJNjkyVlBqa2xvcFRDMGhSTEx6TTVpalNvOFMyYXFEc3lJ?=
 =?utf-8?B?V3hwbmFjUXRpK0VkQncrTmlWSmZzeHJBbFQ4WnZ2bkg0QlYvd2E4ZlNudjd5?=
 =?utf-8?B?QnF0TGRTM3MzVlp3Mk84TXdpQ05ObFlQR2FJcHNTUlJySXpiMXRqRStDRWZE?=
 =?utf-8?B?QTJJWHBDMWQ5eWR2cjlQSklBb0VQMmgyVWpGTmozVTY4R2UrUmtiTU1pQ3lE?=
 =?utf-8?B?Y0d4dFl1Tk9xbzdHN01yR0NqVmhIL0s3RHJUS0NNTDIwbFFwL2ErT2dMK2Qy?=
 =?utf-8?B?ZExFUWloRy9BYzF0SDh1ZjBFSkdMN1N1anFuL2Q1SHhWUXZOWE9oWjlIcHdD?=
 =?utf-8?B?eXh4N2VJTzhjUHE3NHBPQlI0ZVlKSEZZdWc0UGV5bHBPbWNsNFhjaUczSUlL?=
 =?utf-8?B?OXV5am15eUdSYStndnVCYnlLeWtuUUVMSERWSTlUYmFyaXVZNkhJMytZbzZ3?=
 =?utf-8?B?K1V1RXMyNFRLVUhVRDFvK3RkOHQyVUVqZk1TV2dxTjFSdGJYcDcvMGhWOXEy?=
 =?utf-8?B?SDNBREZwS09YZW1LejloUWY4eTRISDhxTjFDVjhwVmpIRVVIc3lDNFkrdjdn?=
 =?utf-8?B?enNiQ3U0ak9sM2tiNlFkVWpLeTgwOE9hUlNyMkJRMTlKZFA4QjhZODdLSnZP?=
 =?utf-8?Q?TxNo=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(36860700013)(14060799003)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:25:58.0574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c77232-7254-43d7-5517-08de36442d76
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7741


On 12/4/25 13:02, zhenglifeng (A) wrote:
> On 2025/12/4 18:13, Pierre Gondois wrote:
>> policy_set_boost() calls the cpufreq set_boost callback.
>> Update the newly added boost_freq_req request from there:
>> - whenever boost is toggled
>> - to cover all possible paths
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 23f64346b80f8..9d98b98e7981c 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -603,10 +603,16 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
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
>> +	if (ret < 0)
> I think policy->boost_enabled should be set to !policy->boost_enabled here,
> too. It'll be confusing if users got an error but set the enabled flag
> successfully.
Yes right indeed
>> +		return ret;
>> +
>> +	return 0;
>>   }
>>   
>>   static ssize_t store_local_boost(struct cpufreq_policy *policy,

