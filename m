Return-Path: <linux-pm+bounces-10370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438E9246AA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA6C2814B7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CEE1BE23E;
	Tue,  2 Jul 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T0VRRjvY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7A43152;
	Tue,  2 Jul 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942573; cv=fail; b=TrUsgKEeAVFhUVs8hbW6ib32qbsvxJQa+eWZvTvy4GO8BofsV7HNWOkHNrIRBnqvpOKoFd3b2b8E+c8+E7aZRhz0eu/LN56PA5T5P8tq/ipWA3OO9Je+yOlNUpxPLa2pz7WqaTmxS17LuHtKkWBHFo4CNJPcwCqEiy95wpf+nPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942573; c=relaxed/simple;
	bh=oKg9ebt1whrwN7ZoGIQrFNQoBwVTBwh4Fgpz1xtq+lI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+xGhFIWfTxdg9Bslbxlte1vJjAgMhtNahOW7LerQy09K5ZfM8zpT19u6I4CNhiAGMYYD4LGfBPGIJIisklEokymodKjpzwmBUEqr1UxZnD0u+xrVJ9q/VunkufSeudO1BfH8B1Zs2rxSML0hSOjTkzpMjHkudlt+08MGh6XNiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T0VRRjvY; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5UjKuW1QWF/D9UNVcl1SNBVczQKPlbx3ZxbHT0SQA3tzvDJTGzorVrjaID1sTGXSOYospiO8FnOdICbf/9Xtxhl+qaa2eilFHZkC934oQZG4jNgyraAAaZtQVnFQoyrfxN/Y76jtAmZX9aTk3yE9vXoI7DMbkKcvi3V9dutdUVtBb6plSrCh34XusuItWvBxaKTGl46JDxegXK4Y+/vvCFLI79yPMc49EWQX+uzC1WS7rnY9V0HxH0XDA7lkplP9lTCH/KfXvwUWI+B58AUeVARq7a2wEphwniuCkYMhE+4tHRM3Qjnlkxzw8RcU6OIOXYLpL6jusC9RGk2GZoYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sbl29XiGI33JOJ7xF8z05QdDAaKalfOjCJQYbFkyx9A=;
 b=TK1aT75RLxL79NJS9VF30yRL47M4mDxhmNe6a1qSL3witd8mS4VbQ2xAGU5NVQRKjs4srtTKYpQzESwDWZ0+Qn/gJHSFGyk8FVrUpB9JknUw9GzXoXKgYZT0FtQ/Asn6Lb5w6EOlXO1Wdkb2yHNIw1mfzLgfgYjfBkWH1m3kujem/NY2yR5RfH5E+XXD9ilUCirdx54Pa7SJRDj9uXPoGDoYxiT0PBbMbGJ03OMSgSsV6SmQNwE2yf4/12TpCk9F1WhFmHRTocPKJergRdr3phj8RTIfQiy8fXoEFe2ZDr9vY53vrgIY8HgoKCq/mXKsjSm/lzRDQ6Pub/NsP7DvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sbl29XiGI33JOJ7xF8z05QdDAaKalfOjCJQYbFkyx9A=;
 b=T0VRRjvYoFHiv/Jy2uArn98lViaD5946A4zwP8VpNH7a00460Tg/jrag5uHlbWJb08ZG+Iu8kTdBbxO/VwZPgp37DgIBSEOAh40qDl5pTBBSr/uqZqGXwfVnYsS83QEdOqkCv2sF/Zb8MUfyYDvGTaNspGYQ9gIADxsqQAAos+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 17:49:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 17:49:28 +0000
Message-ID: <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
Date: Tue, 2 Jul 2024 12:49:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq
 setting on shared memory CPPC systems
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com, perry.yuan@amd.com,
 skhan@linuxfoundation.org, li.meng@amd.com, ray.huang@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Arcari <darcari@redhat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: b246d07f-fe5d-4cba-6680-08dc9abf51dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdMNXkydmVzM2E2Y0w4SnI0ZDl2VWZBSG1hb2xMdmJ6RXBmRFJGeGRZeVFy?=
 =?utf-8?B?WXNVM1lkcVc1TVFEb0lLQ0ltSlRaTjdqak9DVytmZjI5RUNtNmZta1hsdWpu?=
 =?utf-8?B?ODBQNFpwSWw1b3BmSDhRcFkxOHRkM08xWndDZGY2RnIwUDM3TGZZZVdGNDVQ?=
 =?utf-8?B?UlhibnlPMyt6TUtTSTNzMDBiS3NnRUo0bkI1S29PbzdJMlhRY0E3R1k5NFly?=
 =?utf-8?B?bGEwS2lPWGJ0ZEFLdkFEQ0I0U2ZCdWhyOFVzYVhuVitUZSs5RktUelZuaGJh?=
 =?utf-8?B?OXlYUUpiQ2V5WWkzNDk2V3BSRVg3bEQvc1NRNm03NGozZm1HNXVGbVdXZHZp?=
 =?utf-8?B?SnUwMTZKVGJybFpsS0tvakpZL3pmNWdHTVBSWTUxbUFoZm45cFRPYlBPZU5q?=
 =?utf-8?B?ZnQ3UVRaVFdHdzVJNm1HQlBBbDZ0em9XTGliaUN6NDRMZWFobzJ4Z3ZJZi90?=
 =?utf-8?B?RmVwK002cEg0ODlvWWFCcmc1dUpFWCtuaXhkSVp2TUVwSzVURGtTSVhablYw?=
 =?utf-8?B?STJDL1lSWC92c080amRJdTNYTHNhaU1MR2YrSVhyek95OWoxMGMwMWwwMkRI?=
 =?utf-8?B?ZlJ3UitqRWR5WWxQTTljTU5PQzM4dTVLeHlKNUt4b085eExRZGhPVUdidnZo?=
 =?utf-8?B?WmdENVg0MGZaWTRWa3BxeXlnQTVnUlc4SUw1cWQzTjNUalpyaHdhMSt6TVQy?=
 =?utf-8?B?QnhnTjdzQk8vVnZkOEVzbSsxVTJnTXRpUGV2U1F3VkF1MURvbkNqUC8vaUdE?=
 =?utf-8?B?bEFyZDc3RHAvVkRpeHIxaG1XZ3FCQ1hxSnk3eVJQcnRTRGV6cDFtbFpjYlkw?=
 =?utf-8?B?VGh0c2FKVmFsenlVNWlxVDI4TTJKQWF4ZGExQTFoNWxUTFBIYm5iT0t3SjB1?=
 =?utf-8?B?Q2hnNVBsczhDT1B4d3RreEpJclM5QkJqVXYyQnhTTHE4azF5eXhOTWFJTnIw?=
 =?utf-8?B?c1p3UHNNbmxDbFJxajh3bXR4Q2ZrVnU0VFJYbTFoSWxCeEdBaTNMMmVmNThB?=
 =?utf-8?B?cjRJdDdhbzIwZXBlRGNNbjQ2VnBWYUdyMGhadGthbGdMNmJZZ1BYTTBHTG85?=
 =?utf-8?B?Nnh3enJwdCs5OFR3N1pDbWc1UVBOaWxEc2pneDMvMDB1eGFBMHg2TjN6dzNB?=
 =?utf-8?B?cng5MjBEZVJ4YlNHVS80aExpaFBBRDdFdVhEU0dyWlRWcHp2TjZSY3ZRYkxk?=
 =?utf-8?B?QU5Vb0xpNUVwaW1WdTNrOFJER3I5MEVYS29QU09GRnlTWlNscUltKy8waWFt?=
 =?utf-8?B?VE9NaEVQUzkvMnUvUS93Y0ZhdmdLT1Fldnp3L3BsSW9Kc1BGOUNtRW9OY1o0?=
 =?utf-8?B?S2dMK3cwcTB3RUFKNGp3Wm9Gb3cyOTB5MGZQNzFEYTNLelp0WmI5d0hDK0x3?=
 =?utf-8?B?RllUMXNWMWdpcm5VeEVMM0gzL2FTQ1hiSWlUaWQrMjFTL1RFK2s5M1pUU0pR?=
 =?utf-8?B?TEMzTGJsdG8wZWFKYjNaQ1BxTGhad3lNZzIvcDM2cDdiUnFYNDZoVlh0clUy?=
 =?utf-8?B?ZTQ5bnhXU0pVNEFvQ1orKzVsY0RiQTA4WlJTMFppTlFIUnNWckhRT3R0Rmdq?=
 =?utf-8?B?bDA0bTJxTHZUaFBLWFR4K09QdE45WkJHUzJZR1BiRWtZWUZLbHNiN0RLYVpS?=
 =?utf-8?B?NTBpZHY2aGE1UHBxcTlFL0dORi9tM0NtNE82eEtPNDd5RzBSUXArNzM4UVBR?=
 =?utf-8?B?YXdNV2NsWXViWUpndEVZdWxqSEFzSzBWZmhyRkZFRHM2UGF3UGN5cG1aSnZZ?=
 =?utf-8?B?c2RXWWg2SXdhREU5YTlYWElVUXhQN1B0VzVmUzk3bk85WHBDS1RPcmgxYmtn?=
 =?utf-8?B?MUIvQU9CeTlYYnFXZlFzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVB3c0FPVlhUKzM0aUdwTmhFV3YwVmdZK0ZrUGZIbEEycmxwK21JYW96czJV?=
 =?utf-8?B?WjIxRGlwL2JxR2xXaTVNMnJMV2ZqSGpKVGdFNStrV29STldUd3VqYTBENEtt?=
 =?utf-8?B?TjZxYjV4OUZqdVBnUi9kSTBBZ0tnSEJxd08xZjlCLzlheE1SUllyMkxrVjN4?=
 =?utf-8?B?VVg4ZHNDS1hFcmNVdm5HYnFCRk5YUWVhVWNUcjZBN1pONlNQSTBpbzhFbXpy?=
 =?utf-8?B?cjVHQm5GSDhpRUdGeGVHd1BDKzVxbmNZVmVaOVBoa0hLWE90TkRTM3I2dnpa?=
 =?utf-8?B?eUo4eE9YUlAvM0xpWFZjaFNMcmtTTm5nSkZvQTJyYi9ic294dGlNb21KWVlO?=
 =?utf-8?B?dzIwRnA3clRwZlFLNUVjd1pLT2lVczdpNTdiNTFHN3F1M0UzTWExY1c2M0xn?=
 =?utf-8?B?VDMzcWUxR0oyajFUMjRWUTE0M0lJODBuc2NvVWlnYXhVWGJicDZ3aTRwRE5z?=
 =?utf-8?B?amFVdkJ1b1lVWTlJVzdscVJSWWJvbzFuU2hHbS9LQ1ZLNklLZ3NsZU5BZE5X?=
 =?utf-8?B?aXRKSldMYWxMWm5lK1VUK1FzclM1Q1lackEwdVpKYVdoYUloSzJxc1I3K29m?=
 =?utf-8?B?MlZtRThKbE9CR1BGSWtxZE16K3FwaEZlY0FVdDdobDlFRFVQUkEvMWdYZU05?=
 =?utf-8?B?THZCaG1WVWwyNWJWbHd0ZVlBdFEzdExoSGdpUkRyM0d3VlpIQTlmVHVnTjl5?=
 =?utf-8?B?dEtld1NIZENsaEFRaDlkOVgxUHJsQmpXOHVyM1ZMa3NJWGtXbWR5cytXUk01?=
 =?utf-8?B?cjUzMlZCQWJQUGNiSUY0L0ZkNzdDNitab0tncHJscXJIeU82QWFOMVB5MnFa?=
 =?utf-8?B?YzZnM2QyNHlHY1RJTC9Zc0NNdG1MNDE2eS9OeXBTL2tMNlcyYS9lV0JleXZz?=
 =?utf-8?B?dE54Z05KNGRQVU9QNFVSeDlEcWxVTmVNNmlja2lKU05BZWp2ZnFlOGlnT3lh?=
 =?utf-8?B?UmJPQnA1MXBxdGZDOG5xYlVDR252aDR5UTY3YnN5c20yVTdic2Fibk1mMlgr?=
 =?utf-8?B?c3hJSE8rNzRhQ1VZUW5LMVlrVE5DcTQ1N1Ixd2piaktETm54Skl2blk1VFpT?=
 =?utf-8?B?dCswRHRUWkhLd2xqeE9ab3RXemYzNVBrWGx1ZGRPb2x1ZUtnTFVXN3dmQzVW?=
 =?utf-8?B?ekZybkdLQTB4bTQ2cHIzNjhCTndCUC83NHZxcCs2d1AzK3VLeVFIRnJHL3pj?=
 =?utf-8?B?eWJoZFpLZUNkaWRDN1dKSnVQc0luSUhPVTBSV0hXOGI5NDV2VnJTYTNFQjgv?=
 =?utf-8?B?dUhteEVlZzZXTGY3K1cva0lKQ0xqZjhFSXNvcjZPTE9QZEMyYm8vRkZKNWls?=
 =?utf-8?B?NEtDVzdIMGVIMWJCbVZEd3czZHBpYTA3RUJ0VWRuRGRpM05PeUVLUXNPK1E1?=
 =?utf-8?B?TDY1Zis5ZmRSNEpCdUxzQ3liQTVRV0xjR2t4THNMTmY3MmQxeEdrOFh3UmhM?=
 =?utf-8?B?YzNoazBVVW1lQUZ4bzd4LzRHcExKMlVVTW1mbkE0ZjZyVHM4b3N5N214aHJV?=
 =?utf-8?B?UlZwOTVHVWVjbTRlbVdlTGhka0tWL1pEd0xPZzNxdzJ1SnEydHEzalJYV1pU?=
 =?utf-8?B?bFE4TVByUFpRWTZLS1dlZVdOV01qOXpHeTRCd2IyWjlUU1hwaVJwU2Rka0Jo?=
 =?utf-8?B?eTI1eFlCeEpRdEpqbVUrMSt4QWhpM0NIbDVjVzV6T2dxYjRBNDAxa2RVcTBT?=
 =?utf-8?B?anI5K0JsalRqT0Z6dWxYMXNoN0hwQkdzckpKYmZTQmVDWndkVmp6VlVidGs1?=
 =?utf-8?B?cGJUNVNrN1ZCSGxqL2xqdnBnZ2wxVmNweFk4S1Jld0krRHhJaFJPMElEUWRl?=
 =?utf-8?B?RVRhcUpYd2dNRnQ3ckpSd2pFUFdQSU0ra2lKb2F5QWF5WG8ySDEwRCtueC92?=
 =?utf-8?B?bWVDelRGKzBaN2FZMlJjbzI1NlBMZTRXNTRic2NkblZJazl0b24rUy9qV2Q0?=
 =?utf-8?B?aEhoODJFUXcyckFKSk92YldoOElGa0FxYUtnQmxGMzJWOWorUHp0MWFEYW1h?=
 =?utf-8?B?bG1NRWdYVENnMWcrM1hUUnlxTG5RUjhVaUUyN1REM0FIL3MrV0xIay9uNWEx?=
 =?utf-8?B?LzdVaTlpZXhqaE9lTm13ZmJ3SHR4dEg4UTBLNWYwdnFkcGtoSlpmK3JHVHRO?=
 =?utf-8?Q?h7Npk8+UEVxknKSQ4srYVjseT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b246d07f-fe5d-4cba-6680-08dc9abf51dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:49:28.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Fnw8n8IF2/SDQXDaOXhsMjPSnGqIBVRHVXrT736zG2VXGQLzyXS0/D0fbpI6f4JnQbhJoYegAdI1AhHS2ibrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

On 7/2/2024 3:14, Dhananjay Ugwekar wrote:
> On shared memory CPPC systems, with amd_pstate=active mode, the change
> in scaling_max_freq doesn't get written to the shared memory
> region. Due to this, the writes to the scaling_max_freq sysfs file
> don't take effect. Fix this by propagating the scaling_max_freq
> changes to the shared memory region.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Reported-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 43 +++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ad62dbe8bfb..a092b13ffbc2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -247,6 +247,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>   	return index;
>   }
>   
> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +			       u32 des_perf, u32 max_perf, bool fast_switch)
> +{
> +	if (fast_switch)
> +		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> +	else
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +			      READ_ONCE(cpudata->cppc_req_cached));
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> +
> +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> +					  u32 min_perf, u32 des_perf,
> +					  u32 max_perf, bool fast_switch)
> +{
> +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +					    max_perf, fast_switch);
> +}
> +
>   static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>   {
>   	int ret;
> @@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>   		if (!ret)
>   			cpudata->epp_cached = epp;
>   	} else {
> +		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> +					     cpudata->max_limit_perf, false);
> +
>   		perf_ctrls.energy_perf = epp;
>   		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>   		if (ret) {
> @@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>   	return static_call(amd_pstate_init_perf)(cpudata);
>   }
>   
> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			       u32 des_perf, u32 max_perf, bool fast_switch)
> -{
> -	if (fast_switch)
> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> -	else
> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -			      READ_ONCE(cpudata->cppc_req_cached));
> -}
> -
>   static void cppc_update_perf(struct amd_cpudata *cpudata,
>   			     u32 min_perf, u32 des_perf,
>   			     u32 max_perf, bool fast_switch)
> @@ -475,16 +488,6 @@ static void cppc_update_perf(struct amd_cpudata *cpudata,
>   	cppc_set_perf(cpudata->cpu, &perf_ctrls);
>   }
>   
> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> -
> -static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> -					  u32 min_perf, u32 des_perf,
> -					  u32 max_perf, bool fast_switch)
> -{
> -	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> -					    max_perf, fast_switch);
> -}
> -
>   static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>   {
>   	u64 aperf, mperf, tsc;


