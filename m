Return-Path: <linux-pm+bounces-39666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BC9CC9370
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 19:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F19E3002171
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F319E82A;
	Wed, 17 Dec 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MpRveV+4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MpRveV+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA520B80D;
	Wed, 17 Dec 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995058; cv=fail; b=TQ4vBlHVJWkLTw7rBhc+/rTYe/39+9fwEGEo5PLbOXt6A4MSJ5Qa6lTmWGzuz+5je7gxMaQJsSabDgNVr91iUHH5wzaClQou47paTDifmtmDgvUkg+oVID1sFiDxjI1DhFBIgwFNkd1pzO6M8fG8tiAf1ibCMedSYDUbvBYFLAY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995058; c=relaxed/simple;
	bh=Ixq+hqUO7FjrQAeMSaXQd6widHbMGNB0RkcL0kNt6Rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T6wiGhocRK/gVyInbzNIdW/iYIojMUGyf8KfKP7osIcXzDTQ2rFhSdLEL1NY3ca8+IIyZKvj3qiDwdXTE00EgYqV1Zj7aD4Gckm6jGCQtaIES8gzzpZItk0NwqfVgFxwMc1l4OXRh2717RfsHfbW1joNyKajl/nvKk3qbz9O9Z0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MpRveV+4; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MpRveV+4; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21)
 by DBBPR08MB5884.eurprd08.prod.outlook.com (2603:10a6:10:1f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 17:37:32 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hPyMW/V6FpnUKhYkW+vFMB7VP1lyUmQCZuUSPF+cNP0xyB52S/AFLMkIYo8NL/SrV4UqD9oRHw/apS6ukl+Q1vwAVSrfO4GjqGPTHMcBK0gyvHk7MlAx8/O8Xo2lUA25eZlu0QpPyD+zOUQHuWZtxAJAf6pU93s3B9KtSwiD0y3b5LV0vjNXvvf3GQGcg9McH9UeZ8xwE06CnLgC/c2anhKdPwFYoUJ6gh1Kzbk6TUihAmZ6Nascufdj9Ev+ZbhVZ8j9QLnDj41qrL66Fb/6C/A/6cR4JA3WkwAlugts6lHNtBEnpuH4KH8pd3qDVzmiUoZK7hkyWQED+eHqSQO6qg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFZ1hM5eIcU/8m1BDqG6tfZIFaUSJuz+TfGBFezCtJ0=;
 b=wwkyRrHG386edntA6HKS3oL5bN2554u07gN4MnZ+w7WMaycT2U1RPQg+J4aHLtVmQ3wzN6CTHMk92cRLRjyV8ioFirkXEOGgfhkrzyszwQWSQAayeNKvnUyNRr4m+CzVqlWMcM9z+ZqM+MpC3aDcZSe4s2mCCAisoXa258qz8Ry3iv9BiZ40wzAacyajfPqUrx3P3Y1fqR0ojFySlj0jH05huDU2V6yQxIEc4buk/nqzY854NhENfpCW3vRI68pwgRgLwgMB8lOvDqs+DthmaQKjlsAXIn49hIqAbaTcYFJyzBo4IJI5QJLBM+eKcvdbIL8C2J/j+4nN0UJLYX67Yg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFZ1hM5eIcU/8m1BDqG6tfZIFaUSJuz+TfGBFezCtJ0=;
 b=MpRveV+4jlOQTLGUCSUZOTdMlzks0fHfwZxeC6YvNWpXqEUpr0Hlreah6ynb6r5yAUxfI/+Z83qkS85Nw6dLwf0vM17Eo0WW3swInSkIU6kC+hoW0Ys5BE2jUPafvsX5W4bLnefQH6JRMu7WW5UHdG7gKnqgOng35qqoAB0twlc=
Received: from AM8P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::33)
 by DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 16:23:20 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::2c) by AM8P190CA0028.outlook.office365.com
 (2603:10a6:20b:219::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 16:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 16:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWgVG/ZYA+dr1aNOzZLhYMbyOS1dmuwIbYdkdKka2e6OaYEuKFp9izjqhNWDJGk7+YHE5dRR2EfCbWHdD/3dHeypFupCrLdh0Bb5BEGCay2R41denwEkAQpzyF2hFRHZa4J58hM4PMDXNppYqCjsWrOkhxjzX+tw/XUEzwd7Rrv9D5pOecPngrztziOxDQ81jNNXAJ6pnSJzof6WPRtdC2vwCEnfOxpgcpg6W8RYQahnLw3bhLJPvnQ2+Ei1kks2aRSSP/lp5QD89f/MD5RNDZdeWaOH6isoFhUa0FkRTs5UQwtsQyBseVr3RaZDhH1mHrCz9a9ByKMTlcvhYfLXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFZ1hM5eIcU/8m1BDqG6tfZIFaUSJuz+TfGBFezCtJ0=;
 b=yfzRd90iw6jIulgQbeAFeDrgMaXglaGd3NPQaoYOmWQ2PmaQtxYUh0292CfPLGqWphbWXXZugVbfxaAcr441VehQhMq/6vIkhRbECiqgS2C86RGvPZA1e4fkro8wj3i92H6xXvcJ+gQaHYjTBYkRxwr423j4Ali5ffdcMiLF+DpAUzTGfZtuXtEMjwlOc6+Za4LAJemOvslTdpS8FWf3sohiO4p91kxZR3MqIXJ+cDSdOm3Ea3HMbBFQj8tZlHAEhuuLBvbvAB68GqsgsJNkIrUIXCyRRjY6OT7As6DP9bVa180udKlNkIXCzSnAjEBf22dcTYqIiOXawrQCXfAYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFZ1hM5eIcU/8m1BDqG6tfZIFaUSJuz+TfGBFezCtJ0=;
 b=MpRveV+4jlOQTLGUCSUZOTdMlzks0fHfwZxeC6YvNWpXqEUpr0Hlreah6ynb6r5yAUxfI/+Z83qkS85Nw6dLwf0vM17Eo0WW3swInSkIU6kC+hoW0Ys5BE2jUPafvsX5W4bLnefQH6JRMu7WW5UHdG7gKnqgOng35qqoAB0twlc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB11545.eurprd08.prod.outlook.com (2603:10a6:10:606::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:22:17 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:22:17 +0000
Message-ID: <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
Date: Wed, 17 Dec 2025 17:22:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
 <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB11545:EE_|AMS0EPF000001B4:EE_|DB9PR08MB7511:EE_|DBBPR08MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3252d4db-2999-4ff0-7071-08de3d889711
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bHFnb0pHREZCc3p1eFZmQ0gwdmI4NnhXOG5ObWlLSzBEL1JiZzZWRDJ6STdp?=
 =?utf-8?B?dmJSVzk0eVNyc0tJWWpVTy9YdEdaWFE4VGhQcC9pTzA5RFlJa0krUE4ydmNo?=
 =?utf-8?B?RUtMOVlnemFCcDA3YlFNNS9leHE5a3M0YkcwSWJZMzVYaE5RS01xaXdmSzVC?=
 =?utf-8?B?N2tvejVFeEJYTGRybHpEMHo4VWtDUkNRdmhwMkxjbUpCaUZGNDFVS2FQT0Jj?=
 =?utf-8?B?YURiL1NMcjQ2MU1rK2xhNEVFcnQzVXdUeXp0Y2pCbUZGY21CSFN3ckxqRFRj?=
 =?utf-8?B?ZERNVHJRTlhkSmgxSkpSOFNMT2NqNVJESkt4Sy9uWmNsRSttMFd4b28rS29S?=
 =?utf-8?B?N21FV1BiQW9HZktSc29RRTRSeGgvTzNveFhqKzlEaUU4MXVnbHJkTnFPOC92?=
 =?utf-8?B?Q2Z4ZXhPWGhvUXMzMjNkTFB4anY2Y0xrZzJMQmc4dWl1cWxIRktTU1k4bHRu?=
 =?utf-8?B?Y0V1MUhRS0wvTGplVjdNQk9JYWJYd2grdlVvZklYNzNMSFFZTEhlcTdVcmtS?=
 =?utf-8?B?VUFJNHFJZnRaRDluTSsxTFUyQWN3cUU2bEczdEFHNEEyWXpScG5rODFwQWRM?=
 =?utf-8?B?d25rWlBEdTZGNzNOUkpaRjZCTkRKYlZ3Y09JYXdob2FnOHRSbUQ1WnRLcXpj?=
 =?utf-8?B?NkFiU3QyS1EveWUzNHByQU9KZGVkQTI4WURpd3JZdGNsd1Z5dlNKM2U5TE1H?=
 =?utf-8?B?QTJzcktQS0NTUGtSWFdBcWM2bFJBWGRmODVTSFZQUHpscWJiSi9qRmlPYTNo?=
 =?utf-8?B?ZHM5VTV4dWNJZnNDYnlmZ2ZJbDRYMEgwVVEyNk5kWWo5eFVPbEx2NWV0dE9Q?=
 =?utf-8?B?aHZPbnFURWFNZGh4WHNrNlN6aDAxU3FZS0dSWnpXT3QzSnJ3TnhtaG5rTDdh?=
 =?utf-8?B?d0tOVE9wTGhnemdGNTdZZ0k3WWk0MkN1M1FaQVFwRnMwTmpJWk82ZTBsTUt3?=
 =?utf-8?B?a3Y0cTN5bVVwV3lwd29seXljVU5pVnFMeVRrdjB1YmxWR1QzUHpLYVYya2dr?=
 =?utf-8?B?N0k1emo1VG9ybDQrRStkNTZpVlV3eWJzTDBKeGZLdTZmZ2RtM1h0NkRiaU84?=
 =?utf-8?B?a3AvL1JsSGIrTnpBbExUNVE1V2lVVmhmRUZhY1NFcS9ENDBnZ3FJZHFuYVZS?=
 =?utf-8?B?RHBobitXU0tiK01STFZZaWNPR3pYbDlYVmEyUitNRlBuTEwrb0dJWGZ2aC9D?=
 =?utf-8?B?Vk9zZUtuMlRBSUNFOG14Uk1ySjhNUHNoMTRVYWVPaTdDY25DMmZMYVMzUHhl?=
 =?utf-8?B?d0V0V0cxU3VDNGtIR0syV0tIRE9aZzhqWnJVOExkYWxuRHliVnorUzY5dlZL?=
 =?utf-8?B?d3oxMU9aMnNoRFd4Kys3bmd6ZUh0eE0rQmJIeHpmUVFDZ05tSXdXRHU1S0p2?=
 =?utf-8?B?ampPWUVGWlV3YmYxZ25KcGlyR1dCNnRiNlprSndDK2J6YWdFVTAxK083emJk?=
 =?utf-8?B?U0VaRm1CNS9tdGxLWHFrMnFvZVpZem5CUmNBcm1ReFl0SDU0QkpDV1lDTGt3?=
 =?utf-8?B?QzdvTGlIQUVtWE13MDVCcS9HeWQ3WFJkMG1PWmdUdUJuR1ltMDQ5bDlDQnBq?=
 =?utf-8?B?NzdySlNKZHZIRm5YK0wvdDJUOTlWSW1PK21KQjE2dXRuYXZKOHdLTGViQ0V3?=
 =?utf-8?B?bUpzU0hTeDc1Q3U0OUFJT2FCa3Q3aEcrdXYwc3R0MmdWb3l6VTNBOWFMUVJ4?=
 =?utf-8?B?UGdSY3paUUw5OTB4NXVNOW12YXgwNkJCV1hXRGIzdVpOVXptSVpyUGs3dXhh?=
 =?utf-8?B?L3lkbTd0cmc0Q1JOZWpMOVZWVE1DQWVzb1AzTFlxT3ZITmE0RE5ha2ZZUFVa?=
 =?utf-8?B?MFBsNGc1cGVlUW91UDFNT0hOL0lhbjhQY2tJYWZrcEYzNVUvdndNNnFuT2Qv?=
 =?utf-8?B?NFJOeUcwcTcrY094SWRxRVV3OWkyTVEyM3h6RnlwdU95bDlHTEl1SjN3T20r?=
 =?utf-8?Q?luG3YmzTCH5hYw+4Ux0Q4noi0nwxTboS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11545
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 9c52dccf-f860-4773-0630-08de3d8871e2
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|14060799003|1800799024|7416014|82310400026|376014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Tzk4djJTamNYSkFPVlVyQmQ5QlJiZXdoQW1EOWpPZ1ZyQWlDeWY2d1FLS3gx?=
 =?utf-8?B?U0ttNWJCSmtTY2JWNUlIV0ZDenZySzFQZjYrMVdCRnBUaFpyUVBOd1UrVzNh?=
 =?utf-8?B?NEU0WmVtS200VmUwVWpPbWptZzZ5d2FnWFZ3bmpwd2IvMDd3NnFTaEZkNlZM?=
 =?utf-8?B?Uk01T2QySk5lRHY4MW13YUIwa2J1YXBQRFFjdS9zODE2bzF1elZ5TENIbE5O?=
 =?utf-8?B?OXlxUUw1SWVKLzNZenp0NXZCMGluRkVLcUpycXJvd2VYN1orSXlZUDFnaitM?=
 =?utf-8?B?ZzlKclpqZjhsQ2x5SW9kWmxFRWRIMG1EK1oyUTluWjBGZVN6UURWSUxHME5w?=
 =?utf-8?B?RVVFeDQvZWdQUlNHMUVoMGxSTzVZZ1dXRTdJY01KdlM2N0U0bjRheE83Nk1n?=
 =?utf-8?B?bDZaZ09yTUtQWFY2dG42ZnUyckh5UEFlOGQvQjI1V1QwUFNpNU5mYUFSVjdp?=
 =?utf-8?B?M25DeHo3YzBJeVVQcmROR1VTbnNhVE9icmlWaWZmbUxrWXhXTkl0eTBITVl2?=
 =?utf-8?B?UzNBWGV4WkJKMHVhelhKNktqU2pyV0U5ZVZwVWdkRXZEN0c0VFJpVnB4T0hV?=
 =?utf-8?B?bE91VmVRRTRrTHJUZkdrUUYvaHlQM0plbXBTR1JReENabHZGMHRoU3dObzhI?=
 =?utf-8?B?YUNXMURSTy83TGNQV2lRWU1YdFpETkxqS0pNWXdkYlNsalE5ZkZKbHMyMDJ1?=
 =?utf-8?B?M21EaUxYc0d1QWRuNmJPYzNJa3c5bTZKc2c3LzhXWEZ1Q1RiclQ4dUhsM1VP?=
 =?utf-8?B?VWNubzFEQ2Q3LzVMNERvdGlwMTdTam1CdmkxaS92c21OWWozOHZhbEduc2Yy?=
 =?utf-8?B?VmZESFIzbU16blh0eDNaWFZJd0haN1lZMVB5d0pXaDBSVThuZE1YeVRla1VE?=
 =?utf-8?B?d0xRMFRNTnVXeG1Xajh4Y0FrbUdMcm14K3FjZEpoUzBaT3Z4VCthUm1uQStk?=
 =?utf-8?B?U3k5Z2ZCYm4vOTdsazYrU0s5VjJwNU1jWjA2Y0J1ekszamJWSW1DUUFQTmZa?=
 =?utf-8?B?T2lwVVNuWTdCV2x5bXZ3NCthYWFoZ0ZrWEllNXU0OFkxZ0pTWXVSZEh1THJG?=
 =?utf-8?B?Ni80M2NkaXJKMEttdkpDQlA4S2I0S09QK3IrMDRRM3pKVnhFVHZSaXFUbFZC?=
 =?utf-8?B?eHNNckNVdkhtcmRSRTB6TVFUUEF0MmppdENBeiswTFpubFZLdTM2ZFF1MnhX?=
 =?utf-8?B?UW9vZ29uc1hNeW1GdDNyMUYzL3pVbmU3alU5ZmFSYnFMYlQyNmhCMVFiRTlt?=
 =?utf-8?B?UVcxV0hSUUU2ZkxBSVUxQm83Uml0UExaa2NmTkZsNk5taDdIY2ppa01ENXZ3?=
 =?utf-8?B?b09aLy9sWXdFL3RMYXZRaHRSejJRTlZzVDRUY003anpNalBhMlE0UE1mbS9Y?=
 =?utf-8?B?TXlzZitPR2svdmdKLzhUUGRBTHVCd3Z5UGE2ckZVN1QxeSsyWTFTeFFNTDBy?=
 =?utf-8?B?UDNTVnZOWEpmY1dQQU1KRzRiZi9INEp4V0szUGV1b2tzMXNVZ0dHN1NublFw?=
 =?utf-8?B?R3NNbEN1cWhmRGlMMi96TGU1OU91VW9yak12Wk0rTkxpQlpWNmtCK2MzaGlM?=
 =?utf-8?B?R2lSMG9rWUZPR1JhczRVUUYzTzROcHFtdUpZYWx6dmduSzA0enRTMENLbUtl?=
 =?utf-8?B?WXNyUHBFbW1WN2ptb3pQUnE2TFdqNG10a1IwSkpGNzUwa3p5bTZlQUhTUWIv?=
 =?utf-8?B?Lzg2cSt6d3VWR2NFTVk5dllBZ2RidFY5RjhoMXRRVjhxTmNmWDBRazdacGR0?=
 =?utf-8?B?dzV2L05xN0YzcTNXWktTaEdpNmpweElpdDZFbCtJZVk3VDhSSDZHNHZsaVJQ?=
 =?utf-8?B?MWJqU1h1dFVYV0JtaWF5cXhsQjFrNG0rZHBIV1RuUWpSTG41SHNoemxrTkdB?=
 =?utf-8?B?dm1yZit5Umxaa1RueVM4eS8zYnVxZHdETVppak1lQklrVk5NMFRLNlkrMTRn?=
 =?utf-8?B?MTlVb0djeGQyNzN1aXZuQ1QrY0RzQjVxbGh2cXNLL3ZCamFlV3RKQlFJTjFQ?=
 =?utf-8?B?aldlMGsrOERHaHZEbVNvOStOUmtwOUZTczFDTkVEYU9FSGtxWEUvbG1IQUVR?=
 =?utf-8?B?cEQ3YjhTamZtU3VoVUwzWFdKbEZ4dG1vR1l6VTRCRzFBWERZMkZQYmg3ci9B?=
 =?utf-8?Q?X1Hg=3D?=
X-Forefront-Antispam-Report:
 CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(7416014)(82310400026)(376014)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:23:19.1503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3252d4db-2999-4ff0-7071-08de3d889711
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
 AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7511
X-OriginatorOrg: arm.com

Hello Lifeng,

Thanks for the review.
I wrote a bit of text, but IIUC you already agree with what I describe.
This might be more to be sure of what I want to do.

If you disagree with something, please let me know.

On 12/10/25 10:26, zhenglifeng (A) wrote:
> On 2025/12/8 18:59, Pierre Gondois wrote:
>> In the existing set_boost() callbacks:
>> - Don't update policy->max as this is done through the qos notifier
>>    cpufreq_notifier_max() which calls cpufreq_set_policy().
>> - Remove freq_qos_update_request() calls as the qos request is now
>>    done in policy_set_boost() and updates the new boost_freq_req
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c   |  2 --
>>   drivers/cpufreq/cppc_cpufreq.c | 21 ++++-----------------
>>   drivers/cpufreq/cpufreq.c      | 14 ++------------
>>   3 files changed, 6 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index b44f0f7a5ba1c..50416358a96ac 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -754,8 +754,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>>   	else if (policy->cpuinfo.max_freq > nominal_freq)
>>   		policy->cpuinfo.max_freq = nominal_freq;
>>   
>> -	policy->max = policy->cpuinfo.max_freq;
>> -
>>   	if (cppc_state == AMD_PSTATE_PASSIVE) {
>>   		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>>   		if (ret < 0)
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index e23d9abea1359..3baf7baaec371 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -597,21 +597,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	caps = &cpu_data->perf_caps;
>>   	policy->driver_data = cpu_data;
>>   
>> -	/*
>> -	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>> -	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>> -	 */
>> -	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>> -	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>> -						caps->highest_perf : caps->nominal_perf);
> Why remove this?

This is partly a mistake.
As you suggested below (I think), policy->max should not be set directly.
It might be better to set the boost_freq_req for all cpufreq drivers, 
which should
result in setting policy->max.

>
>> -
>>   	/*
>>   	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
>>   	 * available if userspace wants to use any perf between lowest & lowest
>>   	 * nonlinear perf
>>   	 */
>>   	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
>> -	policy->cpuinfo.max_freq = policy->max;
>> +	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
>> +						caps->highest_perf : caps->nominal_perf);
>>   
>>   	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>>   	policy->shared_type = cpu_data->shared_type;
>> @@ -776,17 +769,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>   {
>>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>>   	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> -	int ret;
>>   
>>   	if (state)
>> -		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
>> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>>   	else
>> -		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
>> -	policy->cpuinfo.max_freq = policy->max;
>> -
>> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -	if (ret < 0)
>> -		return ret;
>> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 65ef0fa70c388..ab2def9e4d188 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1514,10 +1514,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>> -	} else {
>> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -		if (ret < 0)
>> -			goto out_destroy_policy;
> I think boost_freq_req should be updated here, to solve the problem that
> this code originally intended to solve.

Yes right indeed.

>>   	}
>>   
>>   	if (cpufreq_driver->get && has_target()) {
>> @@ -2819,16 +2815,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>>   		return -ENXIO;
>>   
>>   	ret = cpufreq_frequency_table_cpuinfo(policy);
> cpufreq_frequency_table_cpuinfo() may change policy->max. I believe this
> isn't what you want.


cpufreq_frequency_table_cpuinfo() can effectively update
policy->cpuinfo.max_freq, but directly setting policy->max should be wrong
as it bypasses the other QoS constraints on the maximal frequency.

Updates to policy->max should go through the following call chain
to be sure all constraints/notifiers are respected/called.
freq_qos_update_request()
\-freq_qos_apply()
   \-pm_qos_update_target()
     \-blocking_notifier_call_chain()
       \-cpufreq_notifier_max()
         \-handle_update()
           \-refresh_frequency_limits()
             \-cpufreq_set_policy()

FYIU, we should have:
- max_freq_req: the maximal frequency constraint as set by the user.
   It is updated whenever the user write to scaling_max_freq.
- boost_freq_req: the maximal frequency constraint as set by the
   driver. It is updated whenever boost is enabled/disabled.
- policy->cpuinfo.max_freq: the maximal frequency reachable by the driver.
   This value is used in cpufreq at various places to check frequencies
   are within valid boundaries.
- policy->max: the maximal frequency cpufreq can use. It is a resultant
   of all the QoS constraints received (from the user, boost, thermal).
   It should be updated whenever one of the QoS constraint is updated.
   It should never be set directly to avoid bypassing the QoS constraints.

Whenever a cpufreq driver is initialized, policy->max is set, but the
value is overridden whenever the user writes to scaling_max_freq.
Thus we might think it should be replaced with a max_freq_req constraint.

However if boost is enabled, the maximal frequency will be limited by
max_freq_req. So at init, cpufreq drivers should set boost_freq_req
instead (to policy->cpuinfo.max_freql).
That way, if boost is enabled, the maximal frequency available is the
boost frequency.

------

Summary:
-
policy->max should never be set directly. It should only be set through
cpufreq_set_policy(). cpufreq_set_policy() might be called indirectly
after updating a QoS constraint using freq_qos_update_request().

-
boost_freq_req should be set for all cpufreq drivers, with a default value
of policy->cpuinfo.max_freq. This represents the maximal frequency available
with/without boost.
Note: the name "boost_freq_req" might not be well chosen.

-
Any update to policy->cpuinfo.max_freq should be followed by a call to
freq_qos_update_request(policy->boost_freq_req).
This will allow to update "policy->max" with the new boost frequency.


>> -	if (ret) {
>> +	if (ret)
>>   		pr_err("%s: Policy frequency update failed\n", __func__);
>> -		return ret;
>> -	}
>>   
>> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	return 0;
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>>   

