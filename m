Return-Path: <linux-pm+bounces-15118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238298F6F9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 21:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A501281FD6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6D1ABEB8;
	Thu,  3 Oct 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jJApTJp3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467ED38DE0;
	Thu,  3 Oct 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983391; cv=fail; b=RF7mGLP8Du4wL7GhV4dzympxmZm9N8AclK5UQODv8Nfq733KP1oJbmk1qnSOUb4BjvJ+z4o84rNMXK4+MIXRiUkrEovky6s8/+9pJ/V6fWD3YjYbscSuGICX5hjp/2nt+WiDbN37XL0FYREwUbHWCxht61SnNwgs7JcMrssPMmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983391; c=relaxed/simple;
	bh=VJS9pGC8axvCYvTcV6gTfIxZqfwFO5vx1ubR3Jya1yo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlmGRGCpTg0Zla3eZpctt7/pPdXvtOGfbtgrT3pOzb9URcxaGmzerw9l0fBUEfvqIEFp0Y/UN41PY16amqh/93EP8ftOWNNpYoFms5hOxJhTkvxyTajXXfETHjAxEGmWzWUYpfRmPuOWawhwk9d+X0XrdGNLnGJ82Xm/ghkBPj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jJApTJp3; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7YvP7zUjWQFIJe8dzed97aZWnXp2K6X1Ne+e0XAkQSfvyatgiQ31tcyMFS/Scqib4ggXrZPgEQinclGe0caGvfCzPPAqrr4DDIuWK2ESICZ48slJ8YA6QK8cPuFrkiYoBhJOgI7XI8jMJvGwsesI0STxECzfJjOJ/SDveatb5xXgoMQzewAM+pqMP7h09/Z2OwIi8B/n2/af+p6ZwP7m9csX5ts3R2JPz4fzy/SA/MyMjK0515t9lD0eQMhYydH3AUMExY4V8NyhhVHxT/YKaYXR4BGNNkuBuIUpaziLPB8C00AN0wEGkhQry6t7Q2F0xIe15tR94LaqB6HRvvLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eqU2N3zyjXJtkKrDlV+G58CtG6C9F1+M4LNYpLAFjs=;
 b=NxiIz171PdqZ236F7xFGqrbWsaTt7le1V81FAq9QREb48jq4oPi8897kfZJy6QPilEaMxJVE2Sef6jrthK6FSR78uFXutYn0/zH2bvdxD98I2/TVZhkHivqq3fmPst0RBmoAonBZdHQorJbS/0l6rR4mT8Xez94gmdTfjEfRz+Dz6SL+QVpEuptJQsKfNPbnljF59deFc9R2+vDArV4BED3jVPwvEX/PvTxc1a2YrhehpeFIArBaSS31sTcwpLwCY9PREvelUED467uXos9PPeeNqu+jHAP5/WcWz8EesDfA1HW2O+ypFIZbsrAHOJSNTupHnmQM7pysaiJr5h8mtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eqU2N3zyjXJtkKrDlV+G58CtG6C9F1+M4LNYpLAFjs=;
 b=jJApTJp3pLXLArN3BkIzWoTEU5JGO6f1Xi0O5jZtK8JqGarx5kDZPW3W5PQQAtHiI4SMCsZy3JLgrX/meJYW9s3QvxwVXZXM5DOleA3h8NkMoZFTVwJhMmlOhiSDZCZi4SJN+3FEKch+VnUxYKcr7lPjqT++Vxtu+c2ewzpnbU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 19:23:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 19:23:05 +0000
Message-ID: <d0bb03bd-5cdc-4729-a7c0-4cc143f48b7f@amd.com>
Date: Thu, 3 Oct 2024 14:23:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq/amd-pstate: Set initial min_freq to
 lowest_nonlinear_freq
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, ray.huang@amd.com
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: c7179512-2b45-4f0d-fa66-08dce3e0ce72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDFXN0QrUllENmVUdlNVbWhKVFRqRDNUczA1cTZlT2tEengvVzhkcjN2R1B6?=
 =?utf-8?B?ZEhCeUtIOEdEVkVlUzVUZW15KzZrckc3Ni9pZDQrWnpsb05iSE1KTEZSQmNj?=
 =?utf-8?B?RFpJL1N0ZGdyNGc3VjhPUzJHWXVnTVNWQjc3Wlc5QVdpdWhKYkRtcHgzMWh3?=
 =?utf-8?B?UGtJR3k5UHZON2ZJZDFZRGdVMmNRVnQ5YmZEQmd1dG5wWFJTWDU2cjZJdTNL?=
 =?utf-8?B?ZXNjU0g1eHBKaXZubHhDcUJJMmxaMlZ4NWpKUS81KzVhVnJucDYzOVh5M2Ro?=
 =?utf-8?B?SDJnb2dxdDJzclBVYVVVSHpFR1puU1AzdDRmY0xlRVBOYzgyMGkvQ1E1RTZP?=
 =?utf-8?B?UmZNVW9mTW96YTUvVDUrcTFJdkRsZUhTZi9iQUFiMG1yTTlrV2NwU1ZsWVFv?=
 =?utf-8?B?aFVBOVZBRGl4Y1VtWC9yeFkzc0gvS2duZCtKNVhKZ3F5cXRHZ0k1Q0tjY0xk?=
 =?utf-8?B?K2g2U1dBdmdXaHF2R3FqcXdaZW11dFE0MDdKa05lWVVScENBc2N5dWU0YlBH?=
 =?utf-8?B?S3VmeW9qNGE0MGYxemp5ZmJFV1duSEtlNGt1bk1oeWxLRWlTU2JocVBHcTlI?=
 =?utf-8?B?aGhINnRqaFM4M3lJSHhuWEIwdmVyQkU1TjJkWGdPUDA2dWFuaGpVVmhvQlVp?=
 =?utf-8?B?akl2eTA0aUY2cHBTRTUyR240b2xldnZTZmE1cEpHRkxFcWVlUTdKUExLdTJD?=
 =?utf-8?B?UGZuOVJpZHF3SkN2Qy9mdHJTRmhHcnVrbnM3WnBUM3hzOEs2RDkrKzliL3M4?=
 =?utf-8?B?bHZEQnVYUFZla0hjVmx6amt1bVJvTTVSczZRZTczZGVBYXdkUHFITmg0MHFj?=
 =?utf-8?B?dWlWRmZlNlgwVFVIR2FKVkFiNGFBUVFDUWphWU9oN1NmYjhSOFpTNTlYa3JY?=
 =?utf-8?B?VlpTQ1QxNFl3Qk1ndjhGSkxrYUVZekQxdHdwc3BlMW5pbXI1NlBQRW5OcThX?=
 =?utf-8?B?UU1lYjhFQkdYU0JYWVNuRFBVV0VlSmlzdDZwc3VYK3NabDBrSGNYSUdPejVH?=
 =?utf-8?B?eko3UXBRWURHSndOTER3QWx2RVJrSFd1QUk2TCtsRHZPVE1FalU4T1BFU1RP?=
 =?utf-8?B?STNxSlM3alR4cDBCVHBPMTM0NDFPYzlMdmtkMVBGQlZtVks3S2Y2ZWQ5TzFY?=
 =?utf-8?B?T2g4Mk9KZFRTQWdsT2k3enBWRWFEeTRuQnM3cFM0UFBISUdCdzZya0tqaXdT?=
 =?utf-8?B?WkxXek5USzRIajRIbWhDR2xlUmpNcHVLUmRaQzBZeXNDa1BMOUNaSGJNKyti?=
 =?utf-8?B?S0JDZXV1TVR2K2IzMitxVFMzWmN3dENkRy90anErbFk1RmgzZHNsRDBtNldK?=
 =?utf-8?B?QkJZdkNjM0FSS1V1N0lUY0hETkZQU3FWSXVtV1crRkREd1NoazkweEJ0SlNZ?=
 =?utf-8?B?Z0R2byt6a3hYTllTRDVlNWplcnYvOEpxbkRCb0gyVnYxOHFvYkppZitFWDNK?=
 =?utf-8?B?MDEyTlZDTERQQ2g2YktZNmlpd3BJbk50aDVIYlpMMEJTTVBmbkhIUG4vcERV?=
 =?utf-8?B?SnFGaFFyNGFreGNHOWFhSlhwZkxIWk9tRXF5TU5mWndac3F0U0F1YzljOGhR?=
 =?utf-8?B?TElPam90QVorK3pjdmpYdGVJTUw3S3NoUG42dEpoa1dCcUEyUFhqU1pBRGVD?=
 =?utf-8?B?ZmZBTnFsOURtMnRxSW5YV1UvbjI1MVhROGZCNDVZN3VmWmQwenVzeWMrSnpH?=
 =?utf-8?B?eldaeHMrY3lodUJGSkgwc3I3QTFsUzZnNFAvTXAxb0RkN2llZEluMnJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGRCZndTSGlpWCtwYnhxQW1ZYlhCc215RHNVYkJNZHRNRjdDZ0RMRTBYSGkv?=
 =?utf-8?B?WmdXSjErbFE3dG5FSTFmVW9lU1dQR1pqRlQ0QTcvNElnc2hVTWZvb1JmdFh4?=
 =?utf-8?B?Z2lGc2QzOWNjSFFPRG1UMlUzc2pjb01EUi9aalgrYUUyNHFzSnFwNjJLQXBZ?=
 =?utf-8?B?OUgvOXNuZlgrNzljQWhIWnlYMG54MVBqdWYwbURTYnE1ZXBSRjFVOVFzQncy?=
 =?utf-8?B?YzNzZFU0Ymx6aHplbWFlVlEzbVRTVGhRdVdrbVlhT09DaTREVS9uSk5kU01G?=
 =?utf-8?B?VEhpaFF6V3FONG9MeUUzL0RFQXFjVHhOeGpaOWNjNm5MYVRqYjEvNFA2ZkZ2?=
 =?utf-8?B?SkVOWTZ6U2tGeHpWcEcyQ0R5RmoyY0hXa2pJRGM4SEZ1NE03VUR3cTNCcXBO?=
 =?utf-8?B?Y2ZETEczQmZPTlNCSXkxMUxUdmg0MjhiK2VLUTlUWHE1RFBZeEVvbXNrNHV2?=
 =?utf-8?B?ek91b0lpbGxIdzV5U2ltY0FIbHBMMzZ3bEZDbmdPMGd3cnVqQ1hHZzFRV2xM?=
 =?utf-8?B?aytXcTNHdDd4TXFvMXlDL2pqTzR0OHR6R1duR0RiRWZweUFDelA2QURlTmxr?=
 =?utf-8?B?ZE5LODBNWjhKY2tib2ZQL3JmY01OelNYVGtHbWE1aVV3U0hVVFh3T1pJeEZr?=
 =?utf-8?B?blRIakFjcVIwbmQ5aUsvZ2dLdFlsazF1V1Bya2hCYm1xcWlqQUp2bXU1aUFY?=
 =?utf-8?B?bUIrVTdIVnZCWlZFUjNzTkVwanJORWRRUzdKd1hGMlFUMlVkanhLTXRIOUZ2?=
 =?utf-8?B?Z2tvYXZ0UjNmZzJNQks1Ky81TkM3ZDZhV0F6LzBTMGl1dnFpcS9ZMk1RMy9a?=
 =?utf-8?B?MnlNTjFJKzNwWENTY05oSVFMNEtaenRoSnFjMEY4b2RVVDBDSmUxOFJQaWNy?=
 =?utf-8?B?aWEzbXJod2pMbWorc2FPVnM2c1dOb3ZqRzh3R3BpZEViTzBjMi9RNCtHUWs1?=
 =?utf-8?B?NDB6b1RHd3dmN2lIWERQVm95WE9YWVRDQ09sUmxrYW5wdGhKR0RmRG9tRWN1?=
 =?utf-8?B?dHQybDFvaThHbmpLbUU2NHRHRUhBdkFmVHhHRzRIY1JkcTRtdjRGT252eHAy?=
 =?utf-8?B?S1lraDFsZVJQR2dxazhnRkVkdHVIRWc2VlpQYkx2bldNMjFveDJVRDU3d3Rm?=
 =?utf-8?B?N3VtNzVGMFd2MytNNTIyMURmZTJPRTBHUU1Rb3JSQmNpQmZWSzI3UXFLNndK?=
 =?utf-8?B?QXhEcytTbVFGZ25odmZIdGFuT1h3RjNXTkNDWENSM3RkdVVtNlV3ZkErL0hO?=
 =?utf-8?B?VHltUDhTQmJURHJXVUhIVlJrTi8xaU5pTVFHRzFYa0Z3OWtYVExmOW9yVVh6?=
 =?utf-8?B?VGpMZWJFYktNTDZhYnVUVGI3SC9EaWl2OUR2Tkg2ZmxXdTFKYTdERlB1OHlK?=
 =?utf-8?B?d0VvMTRBUDczbEF3UGVzcnplN3F1VnZRYmRVc25mbkJGNVZuckpwNXF6YUVn?=
 =?utf-8?B?SWZ2RFl3YWJYU1B1OXRqQXJLQ1dCcjN5dUhqdTRiaUQ2eDFKa1gvdkNoRzRs?=
 =?utf-8?B?dDJjTGR3c2o2RDUwUFFFeUZ3Uzk1aDBhSkVrQkUwZk5EbEUvaDNwb2MwQTBT?=
 =?utf-8?B?R2UzNVZ4QWxGUC9Hc1BWUVJzU2JpNm94VnBGWDJ1STFRbFBaYStSZ0RxY1Zo?=
 =?utf-8?B?T0xTL2ZjR0lvSHB5ZUYxeEF1QnpFdXU1ZlJ4QTlEWkRiM3J0NkFoaExRRDRI?=
 =?utf-8?B?bzVKT0xQUnpvNHFJRHpQWGFyVjJOTUh2WXVTWjBweGo1UXJWTFJOSnBFN3lm?=
 =?utf-8?B?YnVIMDF5M2NRTFZUdzB3SlY1em9RTFlJK0ZGQjdnTDMrSDJFczdJK0QxREdn?=
 =?utf-8?B?NVo4ZlNWREJKaFBTL3BNNjljdFRYNlB1cGY2UkRJRTdyT01DNzhUVkZpMXZT?=
 =?utf-8?B?MDFDVERjczZnWFJVTXpLclFYcXduYVd6dVVPNFBTM0VsRXZFVFltWEJhRC9v?=
 =?utf-8?B?RkFFOEZTQm9zVjdKNWVjcm5HNDBIZzQ1bmVvT1lldVVHa0xkRS9QZVhnWUx0?=
 =?utf-8?B?d3duZkVHTllkc0l2TmF0eVRLeFBTdWR2MVlGbytxODhmV3RQVnBZM2lteVZh?=
 =?utf-8?B?K2p0TE40RktnWFdDUGZGa3VjWTdPSTRJVTloakh4U0dKcEZzU0hDR2hFOXR5?=
 =?utf-8?Q?jdHAtTU0ZWhhcgnLp9rwtMEGd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7179512-2b45-4f0d-fa66-08dce3e0ce72
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:23:05.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wc2HIuaxAwFgewAXgHBaMS+3m3VaCYk7aP6GXtUuHluXcDslodJiwVVuLaZxXTEJpMCHgpTWwK3Vie2m0FLLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

On 10/3/2024 03:39, Dhananjay Ugwekar wrote:
> According to the AMD architectural programmer's manual volume 2 [1],
> in section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
> as "Reports the most energy efficient performance level (in terms of
> performance per watt). Above this threshold, lower performance levels
> generally result in increased energy efficiency. Reducing performance
> below this threshold does not result in total energy savings for a given
> computation, although it reduces instantaneous power consumption". So
> lowest_nonlinear_perf is the most power efficient performance level, and
> going below that would lead to a worse performance/watt.
> 
> Also setting the minimum frequency to lowest_nonlinear_freq (instead of
> lowest_freq) allows the CPU to idle at a higher frequency which leads
> to more time being spent in a deeper idle state (as trivial idle tasks
> are completed sooner). This has shown a power benefit in some systems.
> In other systems, power consumption has increased but so has the
> throughput/watt.
> 
> Our objective here is to update the initial lower frequency limit to
> lowest_nonlinear_freq, while allowing the user to later update the lower
> limit to anywhere between lowest_freq to highest_freq for the platform.
> 
> Currently, amd-pstate driver sets the cpudata->req[0] qos_request (lets
> call it amd_pstate_req) to the lowest_freq value at init time, and
> cpufreq.c sets the min_freq_req to 0 (which also gets resolved to the
> lowest_freq eventually). Writing to scaling_min_freq, only updates
> min_freq_req qos_request, while the amd_pstate_req always stays same as the
>   initial value. This leads to the amd_pstate_req becoming the hard lower
> limit (due to the nature of priority lists used to manage the min_freq
> requests). Hence, if we update the amd_pstate_req to lowest_nonlinear_freq
> from amd-pstate driver code, user will never be able to set
> scaling_min_freq to a value lower than that.
> 
> This problem is occurring due to the existence of two different sources
> of lower frequency limits, i.e. cpufreq.c and amd-pstate.c. Removing the
> cpudata->req[0], and updating the min_freq_req itself from amd-pstate
> driver at init time fixes this issue and gives flexibility to the driver
> code as well as allows the user to independently update the lower limit
> later on.
> 
> So, add a callback in cpufreq_driver to update the min_freq_req from
> cpufreq drivers and use it to set the initial min_freq to
> lowest_nonlinear_freq for amd-pstate driver (active, passive and guided
> modes) and cleanup the old min_freq qos request code.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]
> 
> Dhananjay Ugwekar (3):
>    cpufreq: Add a callback to update the min_freq_req from drivers
>    cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
>    cpufreq/amd-pstate: Cleanup the old min_freq qos request remnants
> 
>   drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++------------------
>   drivers/cpufreq/amd-pstate.h |  4 ++--
>   drivers/cpufreq/cpufreq.c    |  6 +++++-
>   include/linux/cpufreq.h      |  6 ++++++
>   4 files changed, 30 insertions(+), 21 deletions(-)
> 

Thanks for the series, it looks good to me and from my testing works as 
intended.

For the series:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Rafael, Viresh,

Can I get your A-b on patch 1?  I'll take it with other new amd-pstate 
content coming this cycle then.

Thansk,

