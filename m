Return-Path: <linux-pm+bounces-22379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57378A3B0E4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88847A5190
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB71B4145;
	Wed, 19 Feb 2025 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLxQNPc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167FA4594A;
	Wed, 19 Feb 2025 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942732; cv=fail; b=TeZYamTdil0z4ADcAknism0Q84iLtCTAXjNvhjdzH7z+jKzHc5GDH1+3R8TjJmB85JQO7cxdpi355oANkaRvLz63ngB67NC6/NWUC95EHR++a1N1Zt2tSPWykg3oyvIHA9MwQFFXHEpLtH7Xjsr1PAmAYaEMJ1H2uh6iDhJGSao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942732; c=relaxed/simple;
	bh=O+bnXFbWjtK7AwM6f1CzG2g3upOkj3N8mgyDFYkOWQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aH+WNiXzVxVjsTDshc7DFS07QS/pKQ+OM5i8pXn/UqtQH2S6Upgi543zL/avx2kV20jywsQKGQF1TKpqTPn0+ZfBmUzK/eSN5XiXB9Z/IbP8dQMrgaaqMeUCdQHixCl9oN5QxUZ0Ros+mh+2Y4oaf2nnDgpV+Wq0FkKcDQgepY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLxQNPc2; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgTvC6hvHbgEuruAYdfZuLXv5ZFAglMJonXPTSFRJwxKUetAoHOP91RqnXEXlx5Zu3yJ0hJiZ1tf4b0FbYMRVcuoopMadZbjgGb8ax6yiNkDjg+ygVxXEo/BpnXHewMqHbHUAPN6VcnNSEyBxfjqwdYxpwP7tzVLuIhtKc+SrjEe9/aFxuuOnWC9Ui5KUlH4ku+GaJgoe4x6BYomYvrLj+8JIPTzoKSwgWnjAZBTZDjCvpmvvmVbY2z/UK2uuMn0E1mz2Uad7irYbLDYQNNOVjGGjnaIGal9paBDngXDCVbwkoWWT843QTG1SXLkxQTxtPmfRQZXXSZw87aKvva8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK0zDjrVOyOAW4I+lB/rreaAD/4sARFW3JBr+5q9Hnc=;
 b=wgeIZ4+oJHMxGJiDAyrHJBa2of8J6SDjt1FZENJtZPqz2R++phdorCoj0EhapNVKhyfEfpKQv/G8SOPN9PSvTCpc0GaTvVOQNFIlJ/xXgsD+NYylhvsoMMNV71Cl3hKijvWgJlIhzConvBnbWprL/7U6pb5Mkv3rHGtj2SqXq/9oUCoTiIxq5jr6bY7O6zvNiUajuDPpBp8dM3Y+/l0AjOHZMwhD81mv/5i9WIwCp2IuHSVPiEMWxeu7oJp3pDGi3r7SB0JF9uhPpFDf4vO+AGXmgUgzMhzKW9AfI52ngK1W3qnk/9wrM3UHT/36aQtEMHuwF+rnbJYNnqrpFDRL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK0zDjrVOyOAW4I+lB/rreaAD/4sARFW3JBr+5q9Hnc=;
 b=kLxQNPc25eEpTUkt0Z/V0NUZQl8swH9ZR6NYAjyFNoZsG6HQVAF31rKqK7Q8u/DBQ4Kdujk+StoIiMp0QxLzIwNd1QAC2qio8pPGQUGk80fJPUyVp7neM2C/WjuRPgrneTYfR7FPPCaAWY3LyECufx0XRK8WTQNO047QrlXZY1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 05:25:29 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:25:29 +0000
Date: Wed, 19 Feb 2025 10:55:20 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 03/18] cpufreq/amd-pstate: Drop min and max cached
 frequencies
Message-ID: <Z7VrQPIoITcnw1SV@BLRRASHENOY1.amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217220707.1468365-4-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc1dcaf-e5a9-46b3-57ce-08dd50a5d27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cMR8AIe7aXRU4J8mrw1ZdHh4vygYRYgBBIDFXLTq32dDRBPegpa2dI9vPtrN?=
 =?us-ascii?Q?ElQJEkh96lOE11wnnQd5JeikcDME4Qu3uyjqgsNixagG1eX6pPqf81//Twfy?=
 =?us-ascii?Q?Njsa8PVm9pZm8bywTREk8KcHEuvs1bXW8DocH7Z8/Dw/5qwzlVE9BpA3UXKG?=
 =?us-ascii?Q?MebAyCbceHL7O8jvaI8Si9CEYpYmYC04iUBfP2UoorcqO2390ztLWJgcnNC+?=
 =?us-ascii?Q?YhZDHgZKMKB2GsFC9vmj4FMEm9NL8baNwl6Nu9HMKLAnSGHD2bt+zDAKQkrz?=
 =?us-ascii?Q?VLgT4GSrpcwior2fACZj9fV4GjmoJPLgoXXIy+0LG3TWd/D7RVl+7lr22Eq2?=
 =?us-ascii?Q?ZemAo3Dj05fdsEhVM//BPgW9jA9D7fYIk6salKWnRQv8bgQNBJz22uXNJ7OV?=
 =?us-ascii?Q?Ynu8z4VhyJ/ERJf+LPkbwmxqjXWURhPgEdTnVL63FceIHFCJB4nT4Au5yk89?=
 =?us-ascii?Q?6kHvSV1wMFp5ETFQwiT7FDiF5PASbYjkbSvjyofQ7AMf+gBCPoI2kgUbr7Ky?=
 =?us-ascii?Q?ktd/jrsnPKyYbNm1UHqCAkJbKHKxs7bfxiZNmH7wNLGszSB1mv4/OIVpT06E?=
 =?us-ascii?Q?rPjd7oMIRe6jnUJkDJYP+P6VfxucyI7WbEBuJQ6QJNF6sFG4GhLQYVa7HN7y?=
 =?us-ascii?Q?5fnu8wnfIs3coovspEINABMqOx9QlK4M5GNEAdtORToRvSIB/kOL6J6Mf9yI?=
 =?us-ascii?Q?ZeUzOO5eLZaTaBqQ7ysipjnVL90Em9bxvXiQiIBnXFTvdkzfrRkhU5e2pjb8?=
 =?us-ascii?Q?HZHaEQcTArFBc5JgJ7mf9YmXNCQ7o/qoN/SxJMnLkQd7IBqO+N85LqQqeeoV?=
 =?us-ascii?Q?5MA0BpI1qev7sAMNl+GAY22C+0dhxkn9lc9t93WaEN3MSvn20+/NDV5hmJ1Z?=
 =?us-ascii?Q?R+8UNW0awMfyNjB0grjjPVh4Y75VhN25asAcD5VNXEuZ8GlQb9rFoQTyW2vs?=
 =?us-ascii?Q?ce4NF6tWLZks3msqpjvjB6eYmtg8+l0N1k4L7OwAaPCqPpPxfwhJro+4zmqk?=
 =?us-ascii?Q?MVMfEZmdjv18swQsbzJvXWoMXLp4ZWr0m/S5LqkyJvPfqYhN5BnFt59guNV5?=
 =?us-ascii?Q?yhr4cWoJPfJsuG8S6+bS1xDUPolQtbeT9vzvSGCPFVcct7366anxxJWgOv1F?=
 =?us-ascii?Q?4PwolAk9NC+eD8bixoEwgxHACOXxOriJntfVR8lrSymah30Lev+CjGmGtO9G?=
 =?us-ascii?Q?vuqqROp/TxV36Z/ruv/aO7IK/tGAebMAko2m9DmsaMWtXVfQT0UC/bgS1GHk?=
 =?us-ascii?Q?oEahK9wWMm3RcwS08JWI1hvOjrQGfhEAvAJTbBYPd/KoCMdU4rZ1sEqp6fUx?=
 =?us-ascii?Q?2pLkJkCFbTccTN1k7vqvezjO1CCmeEMoqs4+UHYQLuzpFyKyClgJcC0uL0es?=
 =?us-ascii?Q?zPk9uxo+JidDZNPZrxxhwXm8zi7s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q25fEpjtUjJCT1+zexaupLmjEJ/dH1ShEoiXGybkIVF41S+x4pVsz1busu12?=
 =?us-ascii?Q?qRlm1CQloeAFwidTze/27QEJBQhp7HKOTTy4HVZE+/mEAP2TjgbrqWTLkh/1?=
 =?us-ascii?Q?qLHbyniRPPxPG4g+jzC9Y1xh5jr+tIK3OvG0MFbTlhkxMqjqfxnFZBObZu6P?=
 =?us-ascii?Q?Xh4d+5IUe+jRWNPhjlMI2lgyDgraubtqw1x9UMA3FyMr25ccmsc6Hy9/YjH8?=
 =?us-ascii?Q?o5bjzUTUiZmPpwuOMM0vfKoT+mFIYA4Yj2T4UY9qULo0TtWIKzpzh81rCeBI?=
 =?us-ascii?Q?vN41LG8NC3v/7i4PffZCfsS/xVO254a21Vq90v2ioDqcbYlndDTYDaGQjRDU?=
 =?us-ascii?Q?2TQI62FyY9JWQMIknLHEAo3qeObFm5GecDgV/YlVswPm9HeJ66DUHnwNSy0L?=
 =?us-ascii?Q?7A40hvbpH/e3gpXLP58/cCMEPKonx8vpNq8rf/7nZZ6Xj5+Ff076QInNr4+a?=
 =?us-ascii?Q?JZHeAkiUkIsut4Rc3dt83j+SRCQzLvHuMNmZZepF2A7p9QfXbAsp0u2Ex5fU?=
 =?us-ascii?Q?WIRO/pbYgnMv8ZS6t+oXFVzJf/LbhXO39FJnAHbD4+a2u7ZXoZ1zLxC4gu4s?=
 =?us-ascii?Q?jC68lY5yj23skpX8tm3Y3tbwRlZfFt3QDVGyXZMieaNKdMu2dOfSh8OXb/u9?=
 =?us-ascii?Q?kEWlQxKKakLJqyxY0CK6h4oaR3+4fGsx2AaYsNLklNARdODu4vum+uV0XlOy?=
 =?us-ascii?Q?/iHBX0QGp57Tgq6jVpV+zS2lTnw1rKQGgkksG3rw3PI270d8aCZSXJXUERM/?=
 =?us-ascii?Q?uZsAQbdA/UtnUO/85hgCef0FbArK/XVlROyp5xMBNhR072lAHo46cQjzuuO3?=
 =?us-ascii?Q?AGmhiCMqTpZQ6AiMnwDwshRDsgL6ERHkDY7SieHKZrvkCQhrT20HkfeFGgq9?=
 =?us-ascii?Q?Wvs7VGs6I1H2380w7bO5Yi23I/ewzkzCuQP7fTOsFuQFl+1kxz6ZrHi4u3cp?=
 =?us-ascii?Q?1shsExSrWO/FVVspu0WRyv9ByNJ4z/sz0lLkE84RmWDbdSNLFRYOvBeZBDB9?=
 =?us-ascii?Q?RoZzhl1gbMo3NwokZd54nnGZAw9af0M6oSMCP0qZRnDK50jeQYqNSNUEg6X3?=
 =?us-ascii?Q?gOGvIcFlvms0eK5s5Z522tEmBnDiN99L3AKeE77otQLY6C3sx7uXnzEeGqmf?=
 =?us-ascii?Q?1Y6hPuQxtZk2XrZCF86cFuHaLfQyEoJYYqJbf9mbwqp/JT8UlEtkG86nb3k/?=
 =?us-ascii?Q?Iq0bj1W+DWM3vRA+LDHbdI1rDxeoYtM4pMrtwnpKFo1Z1QyR4rQm3f+h3ZW1?=
 =?us-ascii?Q?Siyzbyk1cZ5/JVJofqxd6HJI1WqdnpeyNewipwBMw1m00ATskWgWSWuofz3M?=
 =?us-ascii?Q?Gfn2AlIod4K50QFWuFq1/WTVxOxQBTVXbDL6H5eBsvK1KOmFTMeWUNGWohgI?=
 =?us-ascii?Q?G8elhgG0LqrCUWVzexEjxgf/XAcYkRSDY5/eBZRYNRS6L9UixvSkBmk853qe?=
 =?us-ascii?Q?ylBLxINFRv8lEZzpkUFre/5H3LeC3c2nrd7uih6PjFsqmAzhOH7o8tOV7IeI?=
 =?us-ascii?Q?Out92zAqe09SjfBV5b/XmWi4JIj2tAxFLwCN4Ndsm8jjtX2gVil9805EEesK?=
 =?us-ascii?Q?/hS1SbSbE5yI3Fx4OPE6Psdvs+vlJYaVFIH8sslC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc1dcaf-e5a9-46b3-57ce-08dd50a5d27d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:25:28.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnef8aSzmDaR2WgIFw50nT+K82swfrSVyvNG+mkeGEiR6E7RCpccKNtR4q70IESTf1dUWgPl7jnApPB7e8g3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

On Mon, Feb 17, 2025 at 04:06:52PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Use the perf_to_freq helpers to calculate this on the fly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

