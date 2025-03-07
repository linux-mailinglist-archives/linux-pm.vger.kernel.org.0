Return-Path: <linux-pm+bounces-23611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C26DA56303
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 09:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77188167DD2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159F1DE2A9;
	Fri,  7 Mar 2025 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HRrnFvYl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003631A5B9E;
	Fri,  7 Mar 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337630; cv=fail; b=RLNsrJH1CE2aoVNHWNQMN/hw/KTzrCwmyLuXqpgNOIiejnt1WQ+rsW6+WTE8uVtixYBg2MdrDyE4Jv1jK1uQ3KBu2FCq8QKvRmrmswWnPTDf502bEq0/8m1IjW3auaaugQS1bL4zi3ICQmSr/F3l0j5l9VvJsJCBo2rrwehwlt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337630; c=relaxed/simple;
	bh=MPchCrT1LSgqTyBqyeguGJSWleSReY6qaYcfET/6Zng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L3AptWBb0/jioPLXywOORGCszHVQquoUfEYivr/E352P/YiWLH44E67InQZ8T01zxsfA5klKbj+EfiO16wj6l2ksLLvhOUOpuyV4+cWzbjL7FGIUA8FJhYswsa5mCBn5TVCL2SQrly08dc/VoiNE7mBSJWghZ5BBU6ZinLh3OA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HRrnFvYl; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3FvEFyDon0AZCp0R2Bn5iUs7Bsg5omeENwWeuD4rbYsIE6G8WNh2/4BUA79Kq/Xp/iKrjqIgu1UffH7H2Om2Q0PVE2oPCiyLzYpy23pcGEveE2sKGhzZBbKoPgtnbP71A9EjwIJqiXf986QV1G773cXx4hS5zx4SXlqkeugJeCv6gpmZexyeNKSvG/qvNsHXKjyBbb5rQ61/mqVrAC1dPCeYmENXssEJehJszs8fpRoxMq8oMRONTe0XA0VzSKqGo8XpXvKV9LcWcJH0QgCByDMLFmukuK5Kc0Y3NI2+cU7XvXwp5g5pLc4woSqy3LNqjLdZFYXz3HoTE6wjkaLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2pl64Jxz6sB5SJVJNatoWJtfWx08CWm8fsu3XebO6s=;
 b=fqlgYREGCNhbe0v+GkBe+Xu/fx7pxfxdEuAAxX+5zNwk9y4XA0x0i9VNXerqIGJMHTfKXrwKxscFXT4iYwWEbrxCvCTyYKt+WGKark/MHR7mvlWHN72MAqYSEg4I/C3USSZUiNZd9qm+bbJE50jkP1VDcmrW5JLxOKXSHPgicQlSbElCA82h0oFczuQIDP8l5bHxrSKCxvB8XboKI5bmfJjgosbBpJ9dVvw4l7HybnwAc82k1XS8LylfXw/IyZnJaAikxNCg1Hw74kPhPYuh+vMXynepPXCLBcgooGczBXVuXY2jyNxIZr+xQXQVzgiKCwcb7fvRjfi5bNLLxOlycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2pl64Jxz6sB5SJVJNatoWJtfWx08CWm8fsu3XebO6s=;
 b=HRrnFvYlyS3fAYOZM+/pxk4v2YCL5pYzwrSueQJBoruz4toPGxnuLDYN5Kb+4kJy9tsCXqbNhaOL/JXKB4FstPj8Nb7Q4ZOgQoSAWUiwuwSmr7mTz/FkCVTyqbAZ5xTKt/l6fKBilD4rxrSwnCVidCbErcE8vhGPN3ExO8TZt4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 08:53:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:53:44 +0000
Date: Fri, 7 Mar 2025 14:23:34 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/5] cpufreq/amd-pstate: add kernel command line to
 override dynamic epp
Message-ID: <Z8q0DgATVY9YQ9Xe@BLRRASHENOY1.amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304152327.1561017-3-superm1@kernel.org>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fd688f-54a4-4e96-0466-08dd5d5590a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ARMJrN8YqtmUMw8MZUPKsQhT3M22V0dkoDHbAZoKZnt9e9NA3Nj9hC/5MXK?=
 =?us-ascii?Q?ae8VqoDEts/HKtLUVrdXQ8Sdmu7UG/hIfXi7Wg7IJNMi+ATV95yMkL4Wsl7I?=
 =?us-ascii?Q?Qy0K0QtgMeNpzIqteQz8S69gjJU4hYZMKJWNlXLZqo0/hxzkyecjtfDoJNd4?=
 =?us-ascii?Q?5julWlSV3TxIswm6n1QEPzwIil1po8TzsmwdX+XY+fi1bl6ypcyWHxv+W1T3?=
 =?us-ascii?Q?pJv8IB1357QRK2D1wGo1R0uKSe+CB4F7gYIuQqFbPirAdN3qP3WlFzHQs4oc?=
 =?us-ascii?Q?6/SogccMAzZ4itkCuuRMoas6jEq3CeN1l2ie4z3/ud3tuKtheQMOj/fmhq9p?=
 =?us-ascii?Q?fwUDgoOQYNyX+urCiYMvBcqzqu5tEfM0uRzh0ZX09JVr3TnSZ8ImO5h0VIAa?=
 =?us-ascii?Q?tJIJWI5gvkik2czmp+iWfJ7hz/Z1AaSpEnITA5md96T59secB3bgWBtMC/H8?=
 =?us-ascii?Q?cbf7avn+DrtWXPiZCC7/nSEbcqWWeSw94wubnv8C9HBxUjUyWaHIoXtDL2DF?=
 =?us-ascii?Q?lMH/1evMTHZLmcXSTMmbGtFALOJOE8Rg2mxx4V4+hXVqA2N+ADFNdXw5vFL+?=
 =?us-ascii?Q?BHJNaCG90/QfEnsyUC65gqks8Wbk1Jil2bhz0J9NS0KZjf0jOpMkf/hxsOCA?=
 =?us-ascii?Q?hRGLAAF0kQOruXWjTYb8xqd95iwkAm5xBSbv9U5ZsW6CxXurkTtzXYBHiibM?=
 =?us-ascii?Q?MGiEHRnHRGpXGSQJAjL2W7O1AEniFx/tPYqsLBypJMJWRJCmXtzXMnkBAc7k?=
 =?us-ascii?Q?z7BnntduVG/NniYaD2ry2WGFz0a/DLt3XFChy3oduJ8Ku0Pk2Xhz7qxQ8dX4?=
 =?us-ascii?Q?5q2Tg5BhXzbDhnpV7rJn22UiYaCwsBF79gXppdfQGwIkd71zBYyuRQmtWoW/?=
 =?us-ascii?Q?frmqPBpBkbxDqZQFI6T6cY9/s2tgKunzI8uvvxMdFxSrPj4LwelKwjsgOBsC?=
 =?us-ascii?Q?2f7SkvISb+IYz1s7TCtalpydP/mk0SRZiG21f1KLX72jCTQgxgxSr4CTaa8z?=
 =?us-ascii?Q?AQwoeFd63OFTOMlTDZkoZdDK60+HMRwGwsWTmusBPHvsy9G8/EI0tIFFzlyx?=
 =?us-ascii?Q?Sdq1XStrYsyya9yeVB6SiETwZV1gyuQEGqfEst1VuWFlDxvkOO0pUt2sxacc?=
 =?us-ascii?Q?E7NCqTxH8HsTYjK9tXKsRUmu4tqB1QgsCta6uYUeDZY/PDVAQAdVMxg31w8f?=
 =?us-ascii?Q?RJHplFDq7kk4Khjp+BqiT4u4jj0PnhUQimsVWQbgxd+W2mAMEX7Bo2H4OKNf?=
 =?us-ascii?Q?5ga/JV4gOiXb3wXgof8FOtVRsRYAdkjuzuTGEwzrN3fa8BzVgo5KZWo5h9CB?=
 =?us-ascii?Q?2tdJ71OZGNuO5PVAPkVHhh7GDjHUHnI+PiMwzCxIVLTdDyM/RTqID4lIvVHB?=
 =?us-ascii?Q?Fo218sx4kx21Lz9chRQKc8I+aghJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8pECbSLYd8N9YCpFGKuJjglrw7FWWGIseqdfe3zaUJFnT7WV6RpCK4JGB2HU?=
 =?us-ascii?Q?pENZi+ld+yxqg2pXrobanwId9kZbH9NaT0l4N3R52QFDCFgZUXeJYmakXsTt?=
 =?us-ascii?Q?985d3LMc3gqM2DJrBmzG+dpzgNSW/AqXZJlFqNjr58QCjM5Cd6mkzVXDFTxd?=
 =?us-ascii?Q?iMaDHsBSkYrbiExF7PJYRyHOIUD/rkcd2kN4+ZoEryVhDHmHchIG8dvdLVWO?=
 =?us-ascii?Q?rzoCr2hRGzKWya7lpaOFKUy1wkW2uVBgmm5TDF3BHAZ9Izc8d6NAyO2AWMcT?=
 =?us-ascii?Q?OpGJAlYwLDG6oKoz2vEohuhOlwUrLgokTFleCNbdGUYBHzriqF9FQCHVFOHC?=
 =?us-ascii?Q?TNnEocZ71hRHOFQfbYeZdDi6+Hyay8vkIGqyazzJ/VXnkIGSy+OWSGIH5ikU?=
 =?us-ascii?Q?xAnNJS3gg4USpXb8zaHJ1xjO/a2rr1GO9eYN2ZElNrwUTkTD2gqmrIYX4fdr?=
 =?us-ascii?Q?cmz3ij/nrf5aSR0bneRhBxBbhHsyMutSrDYu6rFKDh0+PMX9E5ACXie5vffJ?=
 =?us-ascii?Q?ChYM6fEHLzHqQmZOyRFtdSIM+oVFuu9M08Peuu0KldbO6tH4qEC0kjZY9KZK?=
 =?us-ascii?Q?oH1dim1SvfAs4VMOY2e1B0mF8jpFa128C3zR3jUDlV2JJnghIZ1BMW1nCrdo?=
 =?us-ascii?Q?iMG8WsCGEDcCdPWEilG1WcFlHCaUVnNftDJLEmJxuCBhwZGqmCo2CnXb2B8B?=
 =?us-ascii?Q?M/VQubj04IEPyUSMKxpZuHN6FDzZ39H2UQxYKYoipn/2jKCYwkRwKNO/qqMh?=
 =?us-ascii?Q?WsXlQfLkpsF+HIyUQNW4PERCCiMQvwrhvEG/D5uVgayoE/wA5nkNb1wWJPs5?=
 =?us-ascii?Q?TRI5FbOVt+DeOQpqupGX3oH+hY+l2H5gXLGbSO/tmtKOPVZNb1xZtojKbznW?=
 =?us-ascii?Q?aPrpCyETYxwA6vzOI/eOWRN5qT5trv4OzJm7eikkuomjw/nE7hUCBgZFTs/J?=
 =?us-ascii?Q?a7blp84Pov+ik30es7KSkMHSqMjAOeqFyT6NHgN2+ElnB+bHFMzI4mq7uQYa?=
 =?us-ascii?Q?0lqpU2oe6p1jmL0HJ5s3F2OBqI4d/iypFpgltlbOv0b1f9Yu/HWwvyWHhmIm?=
 =?us-ascii?Q?yrr72fnDIjuC0qDszJhTph4VM/PpfWbbxdY0xdeknRqxp7wcHgE8KK2L6sBC?=
 =?us-ascii?Q?TSjPCROX7kOLFh+V1KrGc9Qu4Ix/JZw4wdZY6pQBCdc+CzIj0pVJVdOJ/nYS?=
 =?us-ascii?Q?lH25C3eMyTAQ7iOkRoem/ngpV7rpp3+cLsGILvRfju60xFuFwEBqESnwYltQ?=
 =?us-ascii?Q?99IRIDIVOCNMXfUlHHnht8JblOu+WxctbkqA8u5aem2OyRPBZZ0fTNnXHmcj?=
 =?us-ascii?Q?T3SnEjrv8qXtVlvN8FKVrNMV+CPfqb0U1M2wN1VjUPq7SgJ+b9zPtNfl5scQ?=
 =?us-ascii?Q?O+XFl6omNxEs9bKm2bSOr9RjxTogj7TOlKsPYB0YOU+MUGv+4MIAojz5d5Nz?=
 =?us-ascii?Q?C/ej2zZDTBgIpG1sUT3UzWkyKEI1w+ZNNY8f/wP/BPwgOtw/E30MxYYU2f2j?=
 =?us-ascii?Q?3TffSn29aI87bdUIrl2ZmTXo4gPRtuhL/02yZROsQ6E0sslHX3d/rRtfII9B?=
 =?us-ascii?Q?/5g964IvE7a1ISwjxVRbsbHzupH0Qw0aj8AuqirW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fd688f-54a4-4e96-0466-08dd5d5590a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:53:43.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUi4VhxpmvzRvT8xrK5EOUHlorqoRpa7By3gEOzj8Q2tQRDQm+XtH/EcmhE7aFdoo30V3cNxOt/Obey0OQA+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

On Tue, Mar 04, 2025 at 09:23:24AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Add `amd_dynamic_epp=enable` and `amd_dynamic_epp=disable` to override
> the kernel configuration option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`
> locally.

Even with this patch, the user can switch the dynamic_epp value via
the sysfs file.  However, it is useful in case the
CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP value is switched in the future.

I suspect that the servers will prefer to have this feature disabled
by default (they are always on AC power!) while the laptop/battery
operated devices would prefer to have this option enabled by default.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  Documentation/admin-guide/pm/amd-pstate.rst     |  7 +++++++
>  drivers/cpufreq/amd-pstate.c                    | 11 +++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec85..1afe6d8ab09bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -392,6 +392,13 @@
>  			disable
>  			  Disable amd-pstate preferred core.
>  
> +	amd_dynamic_epp=
> +			[X86]
> +			disable
> +			  Disable amd-pstate dynamic EPP.
> +			enable
> +			  Enable amd-pstate dynamic EPP.
> +
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 2e076650dc77c..8424e7119dd7e 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -438,6 +438,13 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>  always be advertised by the platform. But OS can choose to ignore that via the
>  kernel parameter ``amd_prefcore=disable``.
>  
> +``amd_dynamic_epp``
> +
> +When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
> +autonomously changes the EPP mode. The default is configured by
> +``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
> +``amd_pstate_epp=enable`` or disabled with ``amd_pstate_epp=disable``.
> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f00fb4ba9f26e..9911808fe0bcf 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1928,8 +1928,19 @@ static int __init amd_prefcore_param(char *str)
>  	return 0;
>  }
>  
> +static int __init amd_dynamic_epp_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		dynamic_epp = false;
> +	if (!strcmp(str, "enable"))
> +		dynamic_epp = true;
> +
> +	return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
>  early_param("amd_prefcore", amd_prefcore_param);
> +early_param("amd_dynamic_epp", amd_dynamic_epp_param);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> -- 
> 2.43.0
> 

