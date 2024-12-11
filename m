Return-Path: <linux-pm+bounces-19040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B29ED233
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B703285018
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39591DD9AC;
	Wed, 11 Dec 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZoEGER/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8C748A;
	Wed, 11 Dec 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935070; cv=fail; b=tIhEmbE8FALPp26AuIiHyhJammewcdyBlOo7t/gVOqzLzr1qPlbp+XbhCJwpvG6KIZmNzyLpHTpM/TnCtcAvVLhsEYh/Ujfj9oF0RfM/i/L35ysdPs5AITeDQ2UwHRvCYo/VCJNoUth1Zy/eu7T8UHEwpU6HdZSZLySxzBvk8b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935070; c=relaxed/simple;
	bh=AjMA0P79gUHsax1i0jt9uVRkEnag7pXbRPfXbOdq6GM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kyol5bc+Gu6OjACnSxRkFHnXKK8Pp2r9in0/dCFC36ItwnyHWIhMMNynN6Dpc1Hut+El3zELvT5+wqY+1NfKIo74ilsjCssrxnwh8HpFfwwNfxQFynoyilte96T4XnpqLn2n4UrdL0acgYvb7WwwVFGasj4hEY5t79SAuqkuIbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZoEGER/b; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8AwhcFXFe9mLugH5n7TfKHI4QkxIhmr0dt13DnfeODLfzxCEEe0QSyNDrXARYSNvxYQkXLO1p4wnFC4TPnxPEqLu7TiWaMLi91g0ASD8Hp9s/eyyQ2zbqoLiGy+7PuZjw3ABUg98USSPquBZyoJOlBPhZ4PpNTAT/FFwcDIJh9L4ykI2E1aqbaiEd5QKtyq9P0w2PuPS+PKDG7lfSUnpkBGbbrvk+ep1rIOZYSxe+x2WV1SnsLBd38KuUJZi5ygmOG3Ffq/YBHfw0kLN0SWX618if68P7N9MLzCGX6QJruoK7SccmbW2FmylT2i2JUzNejnweX7XZIt1FoUiVl57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1Oy4muuVuUZ5FN1HCfU7ybBGx162wa39Wlk1uTXl4I=;
 b=D4xriUhbX4/WPRCFjy8BT2SpXaA3l4PTs8CLNS7LeMTTbBoxSkKSFdJi+snbfXz2LcKDMLXVHzs9uey94mBCFAKpaNnuFZEo1XDi19lE6HRnduA4TltPqPisT6fKUJ3ihGp+oOIg9j1KlMwTmjmq/ZOt64yfpSvPnfyuTEf0PtR6lnh3BjGMpYb7KFCJuV/sBR97kyzbAMTu5GkPj7xTWbVKEvScxJw8cQQ7wJz84MuVY4fn06EI5XKolmZSczWPu+Dq3KxQ6IfMZrsZYYWMISn65alcW7hDQZ1aSdqS1sKoo3n1FKR0vBO1L86UQGk0n/TWdMidI78BZvpyl+DtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Oy4muuVuUZ5FN1HCfU7ybBGx162wa39Wlk1uTXl4I=;
 b=ZoEGER/bbzYxSIOzcN7E6FiaT/4xQJB2AR/Z1kb6xvbh1gWtIYvwYcdRJq5TCp7I4g6f0DyTWY3pS+ujnDGUNdBVgMWCmF+saGdro0jSDrYBJ/I/YZqEk/tb3QIZfx0SkQLU61qs1MzDCeycjqkwQPPjAl76Kpf89FYWRwmg0oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 16:37:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:37:46 +0000
Message-ID: <08f23b24-75f4-4d5f-9d54-002e13bca1c9@amd.com>
Date: Wed, 11 Dec 2024 10:37:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Use CPUFREQ_POLICY_UNKNOWN
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, gautham.shenoy@amd.com,
 Perry Yuan <perry.yuan@amd.com>, rafael@kernel.org, viresh.kumar@linaro.org
References: <20241211122605.3048503-1-christian.loehle@arm.com>
 <20241211122605.3048503-2-christian.loehle@arm.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241211122605.3048503-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca098aa-b442-45ab-24fe-08dd1a022449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjBOSlZJYVMzZmNRSkkzUE5DeGFBVHBOb2JGMWFsSHVIcTE1ekxrSnB5U2Vj?=
 =?utf-8?B?aThJbm9jc2luQ2ZqSkljOXdzdi9Fai9QKzVvYlZ3Q0ZUdFYwL1ZxQ3A1NEY2?=
 =?utf-8?B?aGRvWkJ1WXJXTEJmYWk2MzdIK2JGSGw0bE04bFhoMjhNVWZGdHhYZ2hiZWtQ?=
 =?utf-8?B?SGRnTUsvTUxMbm9KTXpMdEJSM0wxQXM4cThBdlphQzBmVWlubnhZV2cyQi8r?=
 =?utf-8?B?NzllWXlLT2duSE1WTW13Q1RUVjFsS3Z5eHN4UnZ5MFJBdnBvc08yTFpPd3hD?=
 =?utf-8?B?RGhFZXVCWTRLckx2ZFZ3VWg2TnJQSjZDWXo1YlNhSW82NXZlM212SmFvUExM?=
 =?utf-8?B?NkJ3TU45VU15Uy9kdGc3amgzeFFKWGNZakM2THU2WXdXbzlaRlVRTUFrcUdE?=
 =?utf-8?B?U2Y3anIxUWM3QUFLTW8vTlI1alZ4L2RDNmtWNHFSYm8waTBSd1Yra1RhaW1p?=
 =?utf-8?B?VHppMXJGc0hLNGZZb2k1ZGFKbUNzV3A5NlNmOEJ4Yy85YWNxSUp3c09Wajc2?=
 =?utf-8?B?VDIzS3d5YnRmWXd4Rk1tVE9uQlhSMkpKSkNONmdPT0owNEloc0F6Y2ZtMjVX?=
 =?utf-8?B?MjhIRUI3a3dHSThiZW9nUGNLeEJ6bHJYdW1VR3RyOTNVTmk2UzltZzJLSFpC?=
 =?utf-8?B?WUp0ZHh3aEhlenJXOTArTHJ5QXE3TEdIeTQ5ZkVDQkI2REREenlaOUpHeGdE?=
 =?utf-8?B?dGlhRDBoWGZZNDMwaWhZaFFONXZLYityQU45TUVZaGFXV0h6ZTV2OWhXNHNS?=
 =?utf-8?B?WVY3dUxzTlNTUmZTdXJyZVB4UWl0bU5Od0NrZndueGVOUEVTakJVbmpGZU93?=
 =?utf-8?B?bUQwd2UrME10Wm12ZzVJTVBOR2J0eTVBRFBxeXhRUFkwcWoxZDJPOWsxN2xQ?=
 =?utf-8?B?VnhRY2Z3aVhLZHFmdXpQZGdkZVFleFpZK3ZpY0xFTVdtUWprUWlGUGN5UzZL?=
 =?utf-8?B?U2puaXpiU2JWNTJORHlGNGdxdkFYSi9PN0R6T3VZUmFIODdrN0pMQ3ZSQnQr?=
 =?utf-8?B?WTNSaExyM2RUVzN5VnJXYlFNWjJwaFRYQWxSNnJ4Slh3VE5oVklDVThCTTBj?=
 =?utf-8?B?dDAwYWRqcjh2dnVDdW9FYVI4K2JRaW43d3ZMYU1yd1Bic2hEclZOR3cvT3ZW?=
 =?utf-8?B?VENZdUFveXduaDJna2FFYTRqWURKZ3pXaGd2b3FjZy9mMnlsMWllTU9YMmMx?=
 =?utf-8?B?LzFKZjZwZjh0ejJqemw0aHpISi90NnRBQnNCUGM1NjVHNVBmN2VaMVdBT2pD?=
 =?utf-8?B?aGEyMFYvZHdrR3RBbVBJK1hlL0E5SU1FOWh0YmJhWjJEN3RDK3Bmd2FETmlp?=
 =?utf-8?B?VmNjWWx5R3Z5OWd1NkhMWElDUzRZKzhDaVdUUE4wQ2tWNllWTkMrSDRxRjlZ?=
 =?utf-8?B?bmFRRzBpOVRtOWMwbUdPQmhaOHZ4ZVQvMERyL2c0M28vSnpmWm0vbXgydlJz?=
 =?utf-8?B?TGVLUWtMT1AzL1JMQWdnYTdmdEJsUmxESWZKZkcxMU5rSFRmckl3dzhoZWky?=
 =?utf-8?B?SHcrcmhsZmw1NTZSbGplZ1JPQ0pkODFSMGhtKzlPYW1kQ0Y0RlFSeGRJamhs?=
 =?utf-8?B?eEg0Uk8wZzFZZllkUUllL2pDMkJIS2cxWWpJdUNuSlJncFdaU0NWWEdwTnc0?=
 =?utf-8?B?bUw2cDVJa1RXcUVkRXRjMEVIaVBmZnNDR0Y0Vm9ZdFkveVNDOGptNnJkbEQ3?=
 =?utf-8?B?YUdVemNpUUE3YnRRZVl4Q2hNUFMyemlBT2Vmd1JTclR1K1VpWjhVcVlWNHc5?=
 =?utf-8?B?aVJvK0F5UG5yY0hMTTFDK29pL2RsTjE1Y2pMVGY0eVI4Z3dqOGoyMmM5NkNz?=
 =?utf-8?Q?+P/qCKTMV4NgynJaLxur44aGYTxvggrYEKixs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SllEWTJlZFgyemdrYXVhVEgzNkJQUnN0bzF1VGY4K2djdHRjOE0yZHllaEJi?=
 =?utf-8?B?RWxWQkNZRTFzUDJueGNBZGZaUDYvMEY2YUdSWFZJcVZvaDNnSndYcUsyZ3VM?=
 =?utf-8?B?RElxOFhHK3EyUkd0dlFIWW5KK3g0a09nUStaWWoyeDZ5cWJWRjB0Y0lhTFda?=
 =?utf-8?B?ZWg5NitIc2Irckh5L0hva04yVHVqZnAxQWdFODdYeXpsNjRwYzYydW1VOXU0?=
 =?utf-8?B?bFZBdFY2NzZnQ2gxcEgxUEMrSFVTWDdnT0hOZDg0dDkyVWpwWFJ5QVJobnBP?=
 =?utf-8?B?aC93NTR6US9LVzFTVjE1STk3dDJMeU5VbEQrUXBDZkNIUjdDQ01FRmhBdUlH?=
 =?utf-8?B?STdPMVk1Z3drRU15aFB6akpjZFFRc0dsdHNrY2wxSStKZ3VsdEFmbVgvWkdu?=
 =?utf-8?B?RDhMc3J2SmRjOVhyOHhjT3owQndFK1NFNmRUcmVEZDNKWEtiWDNwOWVnNDRv?=
 =?utf-8?B?U3JxYlJISW91UDZhcXNGN3pVMHUwMDZiTDlIY216aWNoRTVKcG12NWhDdlFp?=
 =?utf-8?B?NEFSRTlIZUdTQnZCNTRLZHB2cy93R2pmUHVUQVc0ODZDU1FCWUZwT3pBQXBs?=
 =?utf-8?B?ek9yQk1yeTBuVXhBY1VmL0g5MXBRV1kwVU5mMEQ0aTJpSkVsckZUVjVCMHVn?=
 =?utf-8?B?K2puT0dNSW8wTWRFQm5VcEo3bHQ4TVJJbGIxYjhRRDRQazFMeE1JQmZnczNj?=
 =?utf-8?B?UEt0VVhLa09reEt6TzljYW1maUNSWkxlR3lOWEdMNFBmMXUydmNjOXBqYVZC?=
 =?utf-8?B?K3A0a0ZsYm1nUzBsdjRYeUtENWd6WWE5anJjSzJwb3RoZUlIVVR6SmtsWEd5?=
 =?utf-8?B?VmdMQTByQ1hPZU5nbFBGbWNLelFPNGlrZGw4MmhtK2V3UGxnR1RRZGw5Y3hL?=
 =?utf-8?B?T1VxdkdIeHhZNnV4RjFXS3I1a21KenZLRkp2aGcwWWdIZ3c5NVdwR2swWSs5?=
 =?utf-8?B?bElRK0FNYVFHT2tpcFl1czhaekdFTmtBeGk5T3JydDZ2ZVJka3NzbTg4b3pT?=
 =?utf-8?B?cVptbTNpQndkc1NtOVZqdDFaRXE5Y2ZKQUZVMTJUZ1VKQ2ovKzNKME5BRWdv?=
 =?utf-8?B?Um15STh4T3dtMDlVc1VGYkZVLzQ5WHIxakVoNHp3VUg4SVV5UlJ3S1NXTHBQ?=
 =?utf-8?B?U3BSY2VPY25OVnduZjlGNlVneTN3MFYrK3luN0srVWJmRmFXWjROdDhWYlYy?=
 =?utf-8?B?U3gzVEtFNTdvT2tDQTlRNXNjNzVuU3RVemF1eW5Jb3lwdStEMFI3VzZnZ0NZ?=
 =?utf-8?B?ZmJuaHVWV29CWUdVUzRiMmlVNGloRWFOYitqdWdRUmJFNCtrQlRjSm1KUk5w?=
 =?utf-8?B?TzI2elY5ekVZWGMybXZ3dkR0a1dmK1hQM0JEbTg4OE9HZGRnaTZ6eHNXcUgx?=
 =?utf-8?B?Qm9WbERTVysrZnRIVlgrWDZ5VEpmWTExVDBkZ3ZJbkR5eTJ2VlNudERmd3Vm?=
 =?utf-8?B?MHpwS1NwVFpHVTdGOTFYWnR1aThjMWZvaENMSFkreTFUYS9zZktYSmp4OHIy?=
 =?utf-8?B?Z2NDTHlneXNlSkJSUm5ieUFPRXZSM1F2TEtnN2JqMk9JL1BPR0JaaERFVXhP?=
 =?utf-8?B?OGR3WSszdlVUU3FHSXZUbEYwbjZPSnVRZ0JjaGZqZEdKdS8wSWgvSEJKZlFZ?=
 =?utf-8?B?WGxyUTFob0hTWXQ2Z092VVRyckoyTWRLY1ltODVJVUJ6MlZFMDk2MEZzaklD?=
 =?utf-8?B?b0Z0VW1KSk8yVUpkOHNQNXErbzIzS0k0VjZrZFh3d0pPM20yWU10THZmc1F1?=
 =?utf-8?B?SnY2RldXbkFQbVpwRkJXbEdtK3FIVExFcGNjUUtRdzRSK1drRDhVZGU5LzV3?=
 =?utf-8?B?YTNkZFFqVkh6WDN4Vy9RWUVuUVdrc1d6Mlg0RHB3N1AzdTJGUlFZekNPMmN2?=
 =?utf-8?B?V3NNTlg4UEtGa0FUVjZyczBnRnRqQ1Nlby9MMEFwSGxGRkZLUzBjZmUxS2lw?=
 =?utf-8?B?aWVRaHF4c2dPT0trVURYRzNkZTlQVWgzTFc4RlQvSTA2bU9JT1pOQTJiS1Vj?=
 =?utf-8?B?SjNhWGNHejVMSXp0b2ZxcTBhdXBLQ09sZ1VpaG44QmNUVVF0T0hOdVVPdDdU?=
 =?utf-8?B?QnZHcVhPSXpxVDJweld5Y3Y0dzNCUkNwWmJPMHdjbldSYzE5ZHNITnc5ZFhW?=
 =?utf-8?Q?b+PdRKgmZPWJlBkJzRmEe++Np?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca098aa-b442-45ab-24fe-08dd1a022449
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:37:46.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALolZB8X4k79OFOJyStqsIoJxcqrw9ORDfuiUHuGiuFvcuLOm/vQRyt49DNOX8XsBI5XY6m88VszsxZVK03Osw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422

On 12/11/2024 06:26, Christian Loehle wrote:
> epp_policy uses the same values as cpufreq_policy.policy and resets
> to CPUFREQ_POLICY_UNKNOWN during offlining. Be consistent about
> it and initialize to CPUFREQ_POLICY_UNKNOWN instead of 0, too.
> 
> No functional change intended.
> 
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: <gautham.shenoy@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7630bab2516..546e69cbdf76 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1449,7 +1449,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		return -ENOMEM;
>   
>   	cpudata->cpu = policy->cpu;
> -	cpudata->epp_policy = 0;
> +	cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
>   
>   	ret = amd_pstate_init_perf(cpudata);
>   	if (ret)

Hi,

Thanks for the patch.  In this case it's actually not needed though. 
Some of the in-flight content for 6.14 drops that variable.  This is on 
the superm1/linux.git bleeding-edge branch (which content will promote 
to superm1/linux.git linux-next branch soon and eventually come to 
linux-pm).

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=bleeding-edge&id=b8321230569dc17852a7f7adc7715ad07538cbeb

