Return-Path: <linux-pm+bounces-21929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D46A31F32
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 07:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43041887D30
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E71FC114;
	Wed, 12 Feb 2025 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KlipVyox"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998841FBCB4;
	Wed, 12 Feb 2025 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342361; cv=fail; b=sf+YtG8k4/6GpgJWTpk0AVVHkVcmx7IOET+LG6IhiCCItaIxCQxUPz+T4+1IzSzaEWDebakdsrpPRzph1MRfQVbbvPFWz9XbAfla+qwnwc0nAUQ4s1ACdXE7ViZWLyFVn7tQzIeiIpxlwkiVUt++1KVLDkQtUNeFr0pqxM+P0Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342361; c=relaxed/simple;
	bh=/Xjm9CbddFoTbQNfhsKO+7vO/2TXjcnM+6PaqTtFy7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eWP6JiqZRVWKYOrro2R1pv7nn2NnIBrbtoHlKeufe/oZ2D6qp73l4g8Pqj0eKvO1rAD7jWVAMlaLDfMxxvaOv+sNM88BG32SPqtdYgF6G4QHyTgig6fHCqq/lxZL2FDBaBAYbJUUQuQBXY1b3ITtwl0B3bNM5arSSpL7iRWDHSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KlipVyox; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pp5+5o0cBny6Ht4L6LxQ4rl/8V8tTEurhkeGxCgK9rtovakBk2pOk+K27GbUNQXURhGEjH9ZLYuWegs6PGJxeSVmBVYvkpM/1IrAuilDhfmoWHWxjmceNnap7Yh+Gv3OJh6t7EYhBENMqLA9ku/MrxBS7j5McrLhx+eNjsjTGP9E0VQNvtQ6pobLENNt8WpBLoJwh2wdJalcuWUtNalZ/eZMLINz29D0Ntxy/Z7cZF2E/sWVnAwNxaJw39kPiX9vHKho9oBgKZ/Toi8687RHl9WJw0e/F5j5NfmQ1zjX6TDSr4fyx+q4Mwya/tq4pj9Ri2ryVM5i4+tvPdAOwDR1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QReH2uW+/oZB5t7PDQK8CZMEE8CKKLxEMCX/V6d5MRw=;
 b=jiJLUVklbqLo+V2l3UNKKr0vnvn5H3Zo8hwDx4puVLFPkGyCjY64XAlvahKA6ZHI+uOsHJvElEvKjj5rAcU5WeFsz9fmaN3pJsl/O8R3nM9N4vl8+Hml0cXQ0oQLQQiRmVL9WYP69AR1cBx2bsVB2JNRJeSNL8cGSeLTpDW7Ljzxh0CLZzO/PqNhmZo5WI6JjrqIr31lwOhDapuWFc1YrpxNdJHgpXqV6rXYMpCTB290QQjmSC/DXclw0vLfqw4wHOipwSRosBQOMgi8f/lHWYV3Yp3K15e+Wvs9Pc8F5Vit74tqYJ0/lakR0NGhAQcWkUb/hAZFAv0GFGkMiWhQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QReH2uW+/oZB5t7PDQK8CZMEE8CKKLxEMCX/V6d5MRw=;
 b=KlipVyoxHzFsF2c0gl8tHSfMw4nOn59FTgrEIs9kUNsi8rof8E9Hy9aj9BYrMl/wInICY7KyFRWcvSWD+a2ReUXT6ADl4CUE45oXU4Uj1yauWqsJeP/dr2uxzJKb063D+BT8afGFRutA/9wvRGD0cRRsE3ng9T3MgLAVehU691A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 06:39:17 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 06:39:17 +0000
Message-ID: <5ac00f27-5573-4326-8d4c-9073d97246ff@amd.com>
Date: Wed, 12 Feb 2025 12:09:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] cpufreq/amd-pstate: Move all EPP tracing into
 *_update_perf and *_set_epp functions
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-10-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-10-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0245.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 644e4da7-6bad-4fd7-1fca-08dd4b2ff8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHRUYXB0eldpSXdyYnA5TzRQOGNNRHJIeTJkcGFvWmszeUlFdXdVRGdJU0oz?=
 =?utf-8?B?dWxZdVl5Z3czTFNWMUlVRlNYSjdQQVBtK1VQUlpDZ0FRQXdjbWVnalk2T21l?=
 =?utf-8?B?QUM3TG1abTB2SlBnWG0rK1V0a3J3M3pKYXNab2RvZ3IrQXEyUFRmTXQ0aDd6?=
 =?utf-8?B?czBvVnM5aVZpc2VDeHhLbllQcDBYb0RYblB3TlYwK1U4WFJLTk0wQlJMbkgv?=
 =?utf-8?B?dXpTbzN3Z2p3Yko4STFqQ0lTVnRURjJhczdWcUJvN0hwOWdjaml3c25XRk5w?=
 =?utf-8?B?d1hZQktVQnJvQk5sZmlJZnBkdWN4K3VpYUkraXBvb1dBQ0pVVjE1TjZTODQ5?=
 =?utf-8?B?SzRkbmFwb0JibDFpQ29ySnMrbU9oRDVOazd0aXNadC95YWFQN3RNUmNzamNS?=
 =?utf-8?B?Qk0rY1F0SWZnQWZFM3pmdStQa21hMEV5UFpFWmsvd3R0OE1HQmRzNys0cnpD?=
 =?utf-8?B?Mm9lWEZyRTVGcGhzb2ZCTGdHSkVLc3pzeVF5eGNDQ1EvcVdlbUdIdWZUa01Y?=
 =?utf-8?B?b3JYdE95QmFjSEFDMnRrZnNnRnRhaDlEY2lzVVU0N202N2JORk5LV2FKK0Jn?=
 =?utf-8?B?VXBjYjlaOVhlZDVEQytsQlJIMlN0anlwSVNPeGtjRkczaStuQWpqbTdkNDJx?=
 =?utf-8?B?TlpqOTNBY3ZJaXFEN2I1VkQ2a1o0M1VvTlJUZWFZemhVdmRmLzlKVEIxTFBh?=
 =?utf-8?B?eEkxL2QwNEhYZk9mVlRkVG9EVFk5SEFocGtmSG5peS9scTJJR29NT2RwMjc5?=
 =?utf-8?B?SysyNkN0MDdjNnErYzZycVM5MEVkMFppMlZqdjhYOXprTlRqdFFjVWs2UGJj?=
 =?utf-8?B?bzQ4dE1FTGRGd2JqZExRZ0xoUVNYcFRHYU8rci9NVHJ2azVuT3YzdC9EcTZ1?=
 =?utf-8?B?R2xMQUJqalVtRkJRd0h5TUFtOHlqSUxaVkxmbDZBeWd0S2lnYThTbkNMKzJp?=
 =?utf-8?B?OWtoV0ZLWW5idXR4YTRXWUpvMkNpUGp1SWFyMENZbFlpdnFBRTJ3M3RncnBZ?=
 =?utf-8?B?SjFFNktmckgveVBCQTlJSTNyaS95RTl1NDk1Z2NzQVN0VURMeUdPeGZaN3pM?=
 =?utf-8?B?S2g1M2s1NkVwZzFab1NIZUk3RVE1c0pCeERLand3V215STl3eE5wR09FMFo3?=
 =?utf-8?B?VkEyUmYwaFpiVkVPZHNIU3FpZG94d0o3MjB0VVRzQVdzSVVvb3p0MENPVFZv?=
 =?utf-8?B?ZnUyOTJ1cUVuNXhoUEgrK0ZqSmRoWFJRTFBwL1ZPbzY2S1JWemtOT1RaZGFt?=
 =?utf-8?B?YXhqdUtyN2NOV0gxem9nYmpjNmZpVklHb3o5b2ludWNWQlZoTjZBT3FVcktq?=
 =?utf-8?B?dFdIMHZaNmFpVWpnUmd5THpCT01ORFlGTDFrN0lkYlhMSGRiYjVGNWNPTzdz?=
 =?utf-8?B?U1QrNWNjNHVSUW1rRHhacDZnaE9DMWJVdWwxbUN6YmtPQ0pjRWs1MmJVbEhF?=
 =?utf-8?B?VVMwUFRRRmRSejU1akVlZUU1U3JlZWhFZjR6aTAvYWxtYSs0bmIwalljaG5K?=
 =?utf-8?B?QWZ2TUJHMmVVME1xOHpNdFVGc2NpR28zU3BNTk5iQmtGWWlkQ241RW9VMi8w?=
 =?utf-8?B?L2xSYVMxVXJMUVNIVEo1RzRPV0lpWDRXaC9mUTZZNE5MVXRFU0wyaGx0NlBQ?=
 =?utf-8?B?djRxOXpINkVJT0hDSjVSdmxFMGNQbW1US2h0ckcvZFE0djJnNkpVK2p5bWFj?=
 =?utf-8?B?YWcyQ3h5UW04TWNvOCtndE0vUUVSdDE5QnRVZGNlblladFRDckNJUFhtamp0?=
 =?utf-8?B?d1VGWE5OdlVUYkd4NWlncGtGNzA3dFB1S05EKzZKMDVGVlpCTDQ0S2ZTb2Na?=
 =?utf-8?B?c3dKZkJPNVMyL1BuNVZnVTQ2WE1LczFFRWw4ZTM2Mlh4S0hZdGxySU1uMmY3?=
 =?utf-8?Q?BWpybs/EYP1MC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJ6ZmZvUnp4amZkY0o0Yy9NblVoa1VnNXFJRUlHSHM0SXBad3BROFBGRUtG?=
 =?utf-8?B?a0hXc0l2MnlCT1ZzajVhZUZwMG9sd0hLZW94c0JFNDFWR0dRZVVjcStNbVJk?=
 =?utf-8?B?YUk2SU1kSmtNVnF1RnFPaXBUN0VpdXZhc1dUdGhJNHNzc3hDQTFObVplMEJw?=
 =?utf-8?B?SHRPM25DTjVCUmYyZFk0bGhLNk1mQS9tK2tpNWdLQVpmVnIxVU8vUmdZZVUx?=
 =?utf-8?B?eEFGNTRUN0Y4aFptZ1JVa3hGYyt4Zk1XZ281YW03c1A4THMxNmFRaWVadjNo?=
 =?utf-8?B?aTZuQ3pBd2plSjVNazQzYmpyRGhxMCsva2RaNzVKWnRKeC9YWTBMSnhuN1dV?=
 =?utf-8?B?aCtMU1JtNVpGeGZxK0FndThVSEpYNmFRcUV5ZGorTXV0U0lWVnhIQ0U1WmE4?=
 =?utf-8?B?clBCdlJodHk5Z29YTzd6WXRyYUxUbXpxTHpXWDhWby9IL0dlbW9CVzh4V1gw?=
 =?utf-8?B?b0xxZGdQUjRHUi9td2VSZjRBMFlwQzVQb0MxMTZiY01penVvMlhUZE5wRDZv?=
 =?utf-8?B?UitPWng1c3IvSWx2czF4a1hWQWpKRjhkd21Od1RMUVRDeHVzS1N4MExMQjVk?=
 =?utf-8?B?RTZETHhYdTI1czhYWllPY3VweFU1NnhOa25rUmRVK0dWUWZJRUZrWHJMZ0VF?=
 =?utf-8?B?UzQvMTdpMFUxSlJ0VXFtVXNQWFBDMWlTYkYvZmNrcTU4TkdXU0tCNkdoek56?=
 =?utf-8?B?MkhxNCtlOUs5cnZSUWlsK0hWS200NDdBT0tDUmtCTUZ0YU9qNkp0Y0VVcnd5?=
 =?utf-8?B?VUlNUkJlU0FROTY3NHR4U1JJRmJlWDdoc0FUMkhEWUdOWFVwZ3hmTFhTSk5B?=
 =?utf-8?B?UERBbzJaM1d5OG5jVVpTTkE5R2ZhVTI2V2pZNldFTkhmU213eFZjYkxORlRB?=
 =?utf-8?B?TGxIVG5FQ0xiQlZZT05OZE9vTEx2YlhtSnZucmJlNWxxejlrM1VnMWwzbE5O?=
 =?utf-8?B?dERQNEdyQmdTblVkbHBhSDVDTjZwYy90R1ovVWZwNUhVUGhtWEs1dGN6aE85?=
 =?utf-8?B?WTNYbUd0bGREQU9yWmdaSFpHWGg5MGhtMC9hR2orM0FURjhRTG1GdExRWHdn?=
 =?utf-8?B?eXh0OVM0bEh0YXNiWjM2MC9HOHR3V2dWNFFEYjRXS2NCdmVuN1BzRmxVTFAx?=
 =?utf-8?B?anJxVXdmNHVGSnBHOS8vZjF0NGtseUtWRkxLL09KVnVML0JDNzA4ZXNoblBU?=
 =?utf-8?B?aFhRcjd6YTFacEJBZXVrSitoV3o4Uit5SjlmQUFnRFVYN2M3RHRnN3pzSC9j?=
 =?utf-8?B?N3RVL0ZyQm4zL21kOEJxUEowTEE1dHA2Vit6cU44NVU2bFpvWDNlcVU0cGk1?=
 =?utf-8?B?QXVvVUIxSUJqMUpKUVRJN3hDTUlKc3VDVFFELzZ1M0VOd2NrL1pFM2R1dEV2?=
 =?utf-8?B?aWpYMGxOS2ZGeGQ3NVlhZTNGaVp5citOT3hFNEtXTlA2dSt1MG1SekU1WGNF?=
 =?utf-8?B?aEhDMEY4ZTdtMGk4YzFEV1JnWE9YSGk5NVc2dXU4QWtWTUdCRDV2TVJMVGRq?=
 =?utf-8?B?YWRuZzNTZGJiS3ZudGI3ZG5VdnV2bHJvb083ZWw5MkFUQjZ6djJZU29TVzRF?=
 =?utf-8?B?M0lxN2J0MHVKUm1BaUNsYk9GRzU0VFRMZEU3Ukg5QWl6allGRkgxMGRkeTJE?=
 =?utf-8?B?R2FLMENhZTlkV2djbkUxdVNyaSt2cTlVVlUzOWNDUy92NmVBZ3Q4WjQyTUFW?=
 =?utf-8?B?Vzh4VWptZElmNTlrSk8ra3lHdVJtQlZiejlBZ2d1dWpDSU5jaU80TzRwOG1h?=
 =?utf-8?B?YTB6U01KVStjMk14QllxcmdyRkVHOG8zcDVEQXdQTEZtVmpCOTFtdEQyRmd0?=
 =?utf-8?B?OU5qYU9CZjBTU25hRTlGRmJHTVpxa0djZnpRYm5rMnVtRmZmTUU0aDBqWEZY?=
 =?utf-8?B?NytKR3AzdkFvbXFFVk5hbUxheFpZSGI5MXNoWVBkdUJWOUtlbkE2UkgvQ1VN?=
 =?utf-8?B?c2tTdU1tSXJGK2J1eHN0ZWlJTmFSalpMUlh2a0VxcG16d2orZjI3UjVBdmoy?=
 =?utf-8?B?YmtPaHUySjJGUUNjMFJGSkxXNk9SV1ZUaUloUnNiTDRKQm1KMUsxeHZzeDlj?=
 =?utf-8?B?T21SbGErYittNXRmQlBDMU5MSThjM0pCT08zZmcrekFleFU3ZnNnVlp2eGMy?=
 =?utf-8?Q?PPRn7O4zzjw3AOxwDdteNMvyg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644e4da7-6bad-4fd7-1fca-08dd4b2ff8d8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 06:39:16.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFaT2eOf3lSlV7oQWd+X43BJQ3BelCeGLdbhRHE2B1C17vZYJKH/1luV4Kl42wBMA9DG0rF4//hcT8+ze0SIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The EPP tracing is done by the caller today, but this precludes the
> information about whether the CPPC request has changed.
> 
> Move it into the update_perf and set_epp functions and include information
> about whether the request has changed from the last one.

Looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-trace.h |  13 +++-
>  drivers/cpufreq/amd-pstate.c       | 119 ++++++++++++++++++-----------
>  2 files changed, 83 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index f457d4af2c62e..32e1bdc588c52 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -90,7 +90,8 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		 u8 epp,
>  		 u8 min_perf,
>  		 u8 max_perf,
> -		 bool boost
> +		 bool boost,
> +		 bool changed
>  		 ),
>  
>  	TP_ARGS(cpu_id,
> @@ -98,7 +99,8 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		epp,
>  		min_perf,
>  		max_perf,
> -		boost),
> +		boost,
> +		changed),
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned int, cpu_id)
> @@ -107,6 +109,7 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		__field(u8, min_perf)
>  		__field(u8, max_perf)
>  		__field(bool, boost)
> +		__field(bool, changed)
>  		),
>  
>  	TP_fast_assign(
> @@ -116,15 +119,17 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		__entry->min_perf = min_perf;
>  		__entry->max_perf = max_perf;
>  		__entry->boost = boost;
> +		__entry->changed = changed;
>  		),
>  
> -	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
> +	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u, changed=%u",
>  		  (unsigned int)__entry->cpu_id,
>  		  (u8)__entry->min_perf,
>  		  (u8)__entry->max_perf,
>  		  (u8)__entry->highest_perf,
>  		  (u8)__entry->epp,
> -		  (bool)__entry->boost
> +		  (bool)__entry->boost,
> +		  (bool)__entry->changed
>  		 )
>  );
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2aa3d5be2efe5..e66ccfce5893f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -228,9 +228,10 @@ static u8 shmem_get_epp(struct amd_cpudata *cpudata)
>  	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
>  }
>  
> -static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	u64 value, prev;
>  
>  	value = prev = READ_ONCE(cpudata->cppc_req_cached);
> @@ -242,6 +243,18 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu,
> +					  perf.highest_perf,
> +					  epp,
> +					  min_perf,
> +					  max_perf,
> +					  policy->boost_enabled,
> +					  value != prev);
> +	}
> +
>  	if (value == prev)
>  		return 0;
>  
> @@ -256,24 +269,26 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  	}
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	WRITE_ONCE(cpudata->epp_cached, epp);
> +	if (epp != cpudata->epp_cached)
> +		WRITE_ONCE(cpudata->epp_cached, epp);
>  
>  	return 0;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>  
> -static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
> +static inline int amd_pstate_update_perf(struct cpufreq_policy *policy,
>  					  u8 min_perf, u8 des_perf,
>  					  u8 max_perf, u8 epp,
>  					  bool fast_switch)
>  {
> -	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +	return static_call(amd_pstate_update_perf)(policy, min_perf, des_perf,
>  						   max_perf, epp, fast_switch);
>  }
>  
> -static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
> +static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	u64 value, prev;
>  	int ret;
>  
> @@ -283,6 +298,19 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  	value &= ~AMD_CPPC_EPP_PERF_MASK;
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +					  epp,
> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  policy->boost_enabled,
> +					  value != prev);
> +	}
> +
>  	if (value == prev)
>  		return 0;
>  
> @@ -301,18 +329,32 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  
>  DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
>  
> -static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
> +static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
> -	return static_call(amd_pstate_set_epp)(cpudata, epp);
> +	return static_call(amd_pstate_set_epp)(policy, epp);
>  }
>  
> -static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
> +static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
> -	int ret;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	int ret;
>  
>  	lockdep_assert_held(&cpudata->lock);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +					  epp,
> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
> +						    cpudata->cppc_req_cached),
> +					  policy->boost_enabled,
> +					  epp != cpudata->epp_cached);
> +	}
> +
>  	if (epp == cpudata->epp_cached)
>  		return 0;
>  
> @@ -345,17 +387,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  		return -EBUSY;
>  	}
>  
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		union perf_cached perf = cpudata->perf;
> -
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> -					  epp,
> -					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> -					  policy->boost_enabled);
> -	}
> -
> -	return amd_pstate_set_epp(cpudata, epp);
> +	return amd_pstate_set_epp(policy, epp);
>  }
>  
>  static inline int msr_cppc_enable(bool enable)
> @@ -498,15 +530,16 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
>  	u64 value, prev;
>  	int ret;
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE) {
> -		int ret = shmem_set_epp(cpudata, epp);
> +		int ret = shmem_set_epp(policy, epp);
>  
>  		if (ret)
>  			return ret;
> @@ -521,6 +554,18 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>  
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu,
> +					  perf.highest_perf,
> +					  epp,
> +					  min_perf,
> +					  max_perf,
> +					  policy->boost_enabled,
> +					  value != prev);
> +	}
> +
>  	if (value == prev)
>  		return 0;
>  
> @@ -598,7 +643,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  				cpudata->cpu, fast_switch);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
> +	amd_pstate_update_perf(policy, min_perf, des_perf, max_perf, 0, fast_switch);
>  }
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
> @@ -1546,7 +1591,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	}
> -	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
> +	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>  	if (ret)
>  		return ret;
>  
> @@ -1588,14 +1633,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  		epp = READ_ONCE(cpudata->epp_cached);
>  
>  	perf = READ_ONCE(cpudata->perf);
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf, epp,
> -					  perf.min_limit_perf,
> -					  perf.max_limit_perf,
> -					  policy->boost_enabled);
> -	}
>  
> -	return amd_pstate_update_perf(cpudata, perf.min_limit_perf, 0U,
> +	return amd_pstate_update_perf(policy, perf.min_limit_perf, 0U,
>  				      perf.max_limit_perf, epp, false);
>  }
>  
> @@ -1635,14 +1674,9 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  	if (ret)
>  		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>  
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> -					  cpudata->epp_cached,
> -					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  perf.highest_perf, policy->boost_enabled);
> -	}
> +	guard(mutex)(&cpudata->lock);
>  
> -	return amd_pstate_update_perf(cpudata, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> +	return amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> @@ -1668,14 +1702,9 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> -					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> -					  perf.lowest_perf, perf.lowest_perf,
> -					  policy->boost_enabled);
> -	}
> +	guard(mutex)(&cpudata->lock);
>  
> -	return amd_pstate_update_perf(cpudata, perf.lowest_perf, 0, perf.lowest_perf,
> +	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
>  				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>  }
>  


