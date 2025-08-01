Return-Path: <linux-pm+bounces-31757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB00B181D2
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B161896F0A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA6231832;
	Fri,  1 Aug 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GIZeW8ci"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6318179A3;
	Fri,  1 Aug 2025 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051555; cv=fail; b=Hhxb38l1JNKfC+hLtQZNFzmKc5cDe06dTyenl/c/VR3BeaRZGg11053tvmTEOIhukCesrv1++0kmdAQ0aLcVJ0ZLjw0w/ciTdPT7GQkCtfN3IdIAd7oHUiryrAB/7aLx7Dq2LVU4U658SmYwmybe/O4BFqg321/uVW8pLoc2wyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051555; c=relaxed/simple;
	bh=jjrb7C79Ex6lN8/iPHspI94fzEDicnyWBDshw2mCdSk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKII88yh2jh5jsJSfIbcuF8jVmGvxPtakZ0HxaaREgY+GjXEtwYNUiuIj2GKa/L9BBxTica7eG22f7IFrhMbdhcjUiU9Cg0e2AaTW/dOzJ1/47aDBnYvaboeTKOqcHKqjds5aTo8CgUsyo/m3svvw0rq509B82txRiYrnqREihw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GIZeW8ci; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUgUGHQgeT7hClnkxE2eCr46gSj+zwkD0LAwQPqc8nkSrOXmUvzKP3B9+6LKZu2QD2OtWAR8dIr/iLRlDdjt3+bIjeG3VYHEVAZVr7mnb+191RMYPj+9SvzLwCis6nDGsqN0byJTPbYlK41Yb0O/i3vDVD3dA5jO7taDDJjsFSt8WOtbZGyL0FArnMFtwIkJCptd80/4D3pOO79kfZVWzP8OnRXxt+IiTpUXKy7bHI1vw2/0nRxSamKCzyH+n9ts6LpftInPu2GS/2dZCY4qmprLPeUkm6ugfLKyS/6SYP3TIZmjgGvAWufFkJfE3sU6Knwho5CqqpzZEiteDC2X8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb6749OBLPKlltDZbx5flSg+BBhKMJjd5oJXMwbP1F4=;
 b=QuI6IPcANCh4cl8axSD37EV7mT23/EV5ulQNo2+HF5WPuKcgwCpNV8mv2vjX4W1pQCEIbXD/obxhgQEhyxnKzCtriNQltxy0eHzPHE0OO/6gGXC+0t/zG8bhtRn5PRuBW9vORqi92vdYZl2RBQfPfDOMPHe0n5UxIPHNnlK0UHaVwT4EZdgzkIHv77Cl3ptHl4hCCsKoietBCnDGAMpHvFwOU0+bPmZNGrBdRQiB32oIyqeMsz1t+birxOYTM0HbcQQTpLnoV7PG6lY5gRHGrVh34SbADGe9jHJB0RzgMjpY56GCCKddrhnHfvVNBpi65TgAMF4GzupDqJBLtnSfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb6749OBLPKlltDZbx5flSg+BBhKMJjd5oJXMwbP1F4=;
 b=GIZeW8ci6XDlh3wat6fzst5r2yVii1pZFjyACx6FS0pfUrG1Ne+wGYw9jbWXBi2y6byqtj3d1i3mAS6JGfDTkv7PdL52mVnnze4/oaSamb3Da+onRYqAPELRdRmT+i1+BLpr0BgJYx1u/Hl3Fe5TS5P4znG9VuKmVUnP8y99RmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 12:32:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 12:32:30 +0000
Message-ID: <a9fd04bc-bd13-4bea-97da-2ed3beeb78ce@amd.com>
Date: Fri, 1 Aug 2025 18:02:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: linux-6.6.y regression on amd-pstate
To: "Jones, Morgan" <Morgan.Jones@viasat.com>
Cc: Sasha Levin <sashal@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Christian Heusel <christian@heusel.eu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
 <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
 <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>
 <2024090834-hull-unbalance-ca6b@gregkh>
 <2ffb55e3-6752-466a-b06b-98c324a8d3cc@heusel.eu>
 <2024090825-clarity-cofounder-5c79@gregkh>
 <534cb3af86bd4371800ebfb3035382c2@viasat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <534cb3af86bd4371800ebfb3035382c2@viasat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS5PPF6BCF148B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 122ba1d6-c5b5-4f74-ab29-08ddd0f77b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2lJWm9nWk5rMG5pQ01SZDd0cTBRZ1NIU1JlOS9CSGlSL0dheUR2YlJOWS9U?=
 =?utf-8?B?eFpJVmRrdWpiL1hQZnNVZEtqRWRiaEN3OFJrZDdKTHMvTC9oVVQ1N1RTVVBF?=
 =?utf-8?B?azZBNnJ6c0duOEJ6Um9HZDF3RUJIZ3Yxc3RGcmw4aXRObkphdzFhSXR0Vlpa?=
 =?utf-8?B?SXRHM1A1ZWZUMUY5QkJydDNFZTRLUmloTnBqOVVxcE1HVzQyMGZ0UStSdUxC?=
 =?utf-8?B?dlVXM3VSKzVFTFl4NjBqSmNtWlVyaHUxQVU0MDZaNlhudFllUWIwdVlNQWF4?=
 =?utf-8?B?UFY2Q1lBQ0hENVlQcHk1RlA1eGVnL3EwZGdWcGkyVGVTQUZtQ3RnRmtESGhD?=
 =?utf-8?B?Y2x2NVRkYVR1c1lOMGk5V3BZVklXNXBKZnRvc1B3cGgwNTd2VzNBSXlJYkdR?=
 =?utf-8?B?c0xFSTJBV2R4eTNhTXQwMGR3SnJrOGlDZXo3NUk3OHV6VVlHRjdOYThPdzN2?=
 =?utf-8?B?UW8xUkR1MThkRjd0Ymx1RTNmemlucmdhNkxPenE0azdCWmtvNGVnbmdUeU1w?=
 =?utf-8?B?NXN3alpqYWVwSkdLNi80Ujc0MUhQNVp6bEliV0J6R1BXbXhqZ3JQUVNhR2JY?=
 =?utf-8?B?azhSdHBJYTVGQTkzRWRQbnFhMlVJbXBoOEJrMkhmTUswWnMyQWpvb1JBYmRm?=
 =?utf-8?B?aVVFSmF0aTZVOEFvNjhMQlZvT2NZWEovVHRYRnpFRk5WQ2xmb0ZQVUtPSVg2?=
 =?utf-8?B?Z0R6SGNpcjZSaTFhWEx1RXVZNmd6WjViLzRUNVpPRHYzNE9zaU1NU0lZOUFq?=
 =?utf-8?B?TEVlcVZvRGNndmxiWjduR3lJcDhCeG1SSU54SU41MHdrR0pydW1RbVN2eENM?=
 =?utf-8?B?cEQzTW04aE0ydStEQVIyeE4yZExVNTZGUmFUTzE2M1pWWG1SSkZJUXYzMFdI?=
 =?utf-8?B?R3d5NzNyQ3NHeXpGNUlaZFlnVGtaTkVLZWFyNWo5aHF6bHMvaHF5TXp2RG1p?=
 =?utf-8?B?SEFsT2MxK3gwOUZQanVsRjNTUCszRWI1RnNYOW9keEk5RGxlb2Y4dU5vaXR0?=
 =?utf-8?B?aUMzcHVJTkQ0bktqMG9nMlErR1RtZldTT1QrMWd1Yy9CU1FvTVdzamFmQVlF?=
 =?utf-8?B?SGtOVnlvVTVob2o1RllZSkwzYWZDSjJRQUpvRG9nbThOQ29pL3NiNUZTL0tO?=
 =?utf-8?B?c01RZmdPVVN2NHFLN2k4cnR6bXZhRWpKVzBpcUczLzRjNXhlY2l5Wm5rV1lW?=
 =?utf-8?B?SFVjUjFjTUdPaE1PK1JuNzNmbWk3T1pISFNMUVVCR2pZUThyYXZrMHlTQXgv?=
 =?utf-8?B?NEVtSUF1cTJCdytPNVBvaDlWVmVGTkZpZ09VSUdWNXoyUTMySXgzd2w5R1Js?=
 =?utf-8?B?OG93VXdLL1p6S2c3cTlOcERBVmRicENFaDdxRTZGVGJmUUZHWDJoRU4wWWs5?=
 =?utf-8?B?c2Q1cWZibUUzb1dtbFdudUlWbWZkNGgwU0RvMS9Ed1hUV1lxVFhDVnpIbVJn?=
 =?utf-8?B?TkpzUzRVeC95cUVMVmFaQ003TVdNSWNvL2ExSlVnZjA0d1AwTmhRRGlCOEpZ?=
 =?utf-8?B?M0JuTGU3ZEZPNEZER3pEdlNJQ1ByMnBTK25MZ1hiVnBoQ2VvZlZLbEF0Q3pM?=
 =?utf-8?B?bEVtVlVpTWZNeEhRWXNGRlZsMzcvazlPNDB2QUxzZWlkTVhKUTdIVlFtVHpC?=
 =?utf-8?B?RGJIR21ibjFUMGlvRkxLaE43ZkI5N0dCZ3lDaUFXQUZqeU5NUXdwbHFORDln?=
 =?utf-8?B?Z3pUSkprY2E1U0ZDZ1lPMzJ3VkJxR0JaUndmdHBBWnRTU3VqVmhxUWQyV2U2?=
 =?utf-8?B?VzRxa01nb1VnSnJ6WVFRald4anVDMzV3SzZaR24xZWhGa1RVUjM3WVF0V09z?=
 =?utf-8?B?ZUpBU0Y3S296d1lHaGtHM1YvQ0VnRXFJaU9Hd2FxSkJtdXJCNSswRDgwWjNB?=
 =?utf-8?B?T1dxV3NyUWNDQXk4eFI0dFVzUGtHMEtiMGs2VmdFbmMyQm5UNWI4SkJDSk5j?=
 =?utf-8?Q?OK4zJczpMAs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNXRDRDcDNxR2ZRL0xHS0Z1STduSVlRcXhjb0xDb2FrMjdjQjNSTkdIZ3ND?=
 =?utf-8?B?V2FUVWUxS2pWZkJIdjZZaXFMYTRqTUgwandQRGcwR0hBVFIzMWoxTnRDVzJh?=
 =?utf-8?B?QlFNbUl5SXdhblZxN0pDYmwyU29YdE1TbjhQV2o2Ym5xUFIxMWNwdlhXY2lB?=
 =?utf-8?B?eThqUy80MGVhQUUrRERuQnVVK3hBTFNwNnhJZGlmam00VDcyY2NkOFFYeGdr?=
 =?utf-8?B?TUc4YXBZV05xOHU1elJtV2FSUHVYT1VTMFJQYVJ3eWFHMGp4U1V6QnVKNDZ4?=
 =?utf-8?B?Qkk5SFliM3dJQTE0Z3JRKzN4UWRYVjlpV2FERHZQc254TWVSanNKdTJOZGNi?=
 =?utf-8?B?V2hMbXliRVNxbGtZRm5pTUtEQndPcUhETXp4ZExVdEluTHF3UzlrazZVM21j?=
 =?utf-8?B?ZysxWnNzelFubGRmT2w5VWxHK2ovcVdSbTZPWXRTaXRRQ1lUeWJ6bVFudWVY?=
 =?utf-8?B?b1pvTFp4UjhYSURwT2JLSzhVeFVwN2E4eXRMTENHUmFQV1NTeVJvMjNKS3Zo?=
 =?utf-8?B?TTJIVnBaRmZ2UjBhSUJhSkRxT0lveXljc3JUSWg3bXM0ckhTUVR5SDl6NERS?=
 =?utf-8?B?RlpxaGFpVENYYmRyelFROWFuR0RhR2lFT1o4S1gxaGxnRWt6OXkwRnMrYmdl?=
 =?utf-8?B?YkxZYkZTQzhvY1hrSms3ajMvejFuOUEzdFB4Z0Z1NmN6WlExOGRUaUF1bWVN?=
 =?utf-8?B?d3cxaFN3emNlc2Qxd3N5UnM5ZXVWUEJwR2ZhNXVqU0duOGxUaHBJaDNVR1hu?=
 =?utf-8?B?OCtsY1JadzFuNHBZUG5qc052Nzh4R2dSbzNlT29yQ2xnajRyeTFDNFhMZmtj?=
 =?utf-8?B?TVZ6WG80a0lsTS9tWFZOVTRwYU1GUXlOOThGM0FxL283aUFvQUx1V0hNSStI?=
 =?utf-8?B?Y0EyUWZXM2FUMVhSRUttQVRSdkpUbjc1dzRGN1lkRXNHeU1xQXdiNXd5dXY3?=
 =?utf-8?B?Z05YTDJKZ3RObGEyZVhJaXRqcFFFWHA3TmNKTllTL3RCN203K2VraVNvSTVt?=
 =?utf-8?B?QjFueEpNNldkSGhSbG9ML3NBdngvWjZLbW9IbFRhMEdFZ08rNVZsekRaSVlZ?=
 =?utf-8?B?UVpxNTBBT3hRK21JamNYTXVKaW5qUThHd213WGFUVk1laFdkdWsyRFI1eTVr?=
 =?utf-8?B?dlQzR1A4dExMYXY0K3BzZTRGSnJFTDU2Y1QwZU10aStIVjFnbTlScENobW85?=
 =?utf-8?B?aGdIdTJPOGR5MXpCYURVS2FsM3NlanBBZ3NqRjVKNE1DdDBVUnN2cnJnV3Mw?=
 =?utf-8?B?cUx4VHRtalc5WkxHQVYxZGpIVmRnNmFyajU1N2plQzlRcHJZZmxGbXcvOUZw?=
 =?utf-8?B?dGU5Z0RibGNaUTZ3dk5yZlBOZzNkc2NmK1hGdjFPWGtKK2dkMHo0b3ZWWlcz?=
 =?utf-8?B?Q3M0UVpzbEk4dWJEUDJ2VTBLUUNrOVU1YUpLN2hqOEJkMzZJOUtzaWpCcm4v?=
 =?utf-8?B?ZEtMdlFZMkswaXYrSDZ0NU5odklia1Iva2QrRzJxaE5uZEw2Qi82bHd6UGdl?=
 =?utf-8?B?cnhzOWdaZ1hIaDNDQU4veWVwa0pPN2V4QU5SQ05xakZLanpXb0YyL0ZucUM2?=
 =?utf-8?B?MkdwQ213NjFCekJEVkdFVXQ1dzBsTTlFVjBuaVhDT2RGWnpHSTMvQ0RGTjY4?=
 =?utf-8?B?MDNnbHYwanJiU1JSU3ptM3E4Y1pZRVUzYTVISnN1WEc4TU5OSzhqQmNGTG8r?=
 =?utf-8?B?UC9KdmxZRkhHN1F2VHZnZ0RGdVpkMjYzR1hqWEdaM0xCV05lU3g2Y3VJcXFO?=
 =?utf-8?B?RUcramhQMElmdEJuVC9Qa2VUQVBZLzBxWnZBbFpkaERxZmlNdnE3UXozOW5x?=
 =?utf-8?B?dWd3dWxSbFVNTVpEVXBPdkRkdDRRT3ZPcW9GRU9wTC9BZjNYZEp1TS81Y1pG?=
 =?utf-8?B?OFZyVmF1UFdmK04yeHhDQjBrTytLS3EwYTUzWTN3VXFvcXQzYmZta0F4QWFJ?=
 =?utf-8?B?a0dLUFFOTGxMUDdsZXlTWDg3M3pZampEbkFWS0JsSkUwdUxYWjUxZ2RMQkxN?=
 =?utf-8?B?a1FUMUQ3TExORWVSMFdJalNuek9LWGVoSmV0c0tGdkZ1OGY2R1drRVI5VDRH?=
 =?utf-8?B?MzczR0FtSGRiZXZ5WktXSDR2WFR3ei9CTnJKVUdmeWRhOExMc3R5a2ZnZkdS?=
 =?utf-8?Q?JCzZGqRdOsUaJdpls7TXzVsfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122ba1d6-c5b5-4f74-ab29-08ddd0f77b13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:32:30.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWy8BXHqWGW+wwl6X88skw1R7mEnCB2mFS4c0u8X6u9ShXlkeCjQSLa7pDHGIpV8CDYPJFc6j1DjhhWq+rgJ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6

On 8/1/2025 2:14 AM, Jones, Morgan wrote:
> Hey all,
> 
> I think some form of this is back between 6.12 and 6.15 on our fractious AMD EPYC 7702. The symptom appears to be that the core will not boost past 2 GHz (the nominal frequency), so we lose out on 1.36 GHz of boost frequency. Downgrade from 6.15.7 to LTS (6.12.39) seems to fix it.
> 
> Keeping an eye out for other threads reporting similar symptoms on recent kernels:
> 
> [    0.000000] Linux version 6.15.7-xanmod1 (nixbld@localhost) (gcc (GCC) 14.2.1 20250322, GNU ld (GNU Binutils) 2.44) #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1 00:00:00 UTC 1980
> 
> # cat /proc/cmdline
> [snip] amd_pstate=active amd_prefcore=enable amd_pstate.shared_mem=1
> 
> # cat /proc/cpuinfo
> [snip]
> processor       : 127
> vendor_id       : AuthenticAMD
> cpu family      : 23
> model           : 49
> model name      : AMD EPYC 7702 64-Core Processor
> stepping        : 0
> microcode       : 0x830107d
> cpu MHz         : 400.000
> cache size      : 512 KB
> physical id     : 0
> siblings        : 128
> core id         : 63
> cpu cores       : 64
> apicid          : 127
> initial apicid  : 127
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 16
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sev sev_es
> bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass retbleed smt_rsb srso ibpb_no_ret
> bogomips        : 3992.75
> TLB size        : 3072 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 43 bits physical, 48 bits virtual
> power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
> 
> # cpupower frequency-info
> analyzing CPU 76:
>    driver: amd-pstate-epp
>    CPUs which run at the same hardware frequency: 76
>    CPUs which need to have their frequency coordinated by software: 76
>    energy performance preference: performance
>    hardware limits: 408 MHz - 3.36 GHz
>    available cpufreq governors: performance powersave
>    current policy: frequency should be within 1.51 GHz and 3.36 GHz.
>                    The governor "performance" may decide which speed to use
>                    within this range.
>    current CPU frequency: 1.98 GHz (asserted by call to kernel)
>    boost state support:
>      Supported: yes
>      Active: yes
>    amd-pstate limits:
>      Highest Performance: 255. Maximum Frequency: 3.36 GHz.
>      Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>      Lowest Non-linear Performance: 115. Lowest Non-linear Frequency: 1.51 GHz.
>      Lowest Performance: 31. Lowest Frequency: 400 MHz.
>      Preferred Core Support: 0. Preferred Core Ranking: 255.
> 
> Regards,
> Morgan
> 

Hello Morgan,

6.12 to 6.15 unfortunately includes a pretty big overhaul to the 
amd-pstate driver.  But I'm pretty surprised to hear this regression as 
we have had a lot of mileage on it across a very wide variety of hardware.

That being said:
1) Please capture a report using amd-pstate from amd-debug-tools 
(https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git/about/) 
both on a good and bad kernel and share them.

2) Can you reproduce on mainline 6.16?

If 1 and 2 don't lead an obvious answer:

3) Can you please bisect?

Thanks,

