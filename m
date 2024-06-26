Return-Path: <linux-pm+bounces-10012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBF9177FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B41F22144
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421713C81C;
	Wed, 26 Jun 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z/w9ZMlc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932C13B78F;
	Wed, 26 Jun 2024 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379354; cv=fail; b=Qk42ys9oohdG/UeWGTbYaVpbogRD0RxfA+QtJTBF0XyiwM1yg6jInFFDQbk1EUHNz7rwxSWxilyPjSXjpWjwR12iznYFgqkLDbmc2vddkhpIVSfe+C/vHyhmPsmDIrYJjUnwmE25KXQfPNROSwEpeFPHEHtqMA0ofuc5KvJgLrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379354; c=relaxed/simple;
	bh=etQIkA8ny/fu+t6IYNLMg+Ftp8n7oWT7Ks0s+4ye+xY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HfHR7Dxa70+SFePjUkKj7hxOBlQ27SlIm4Qa1qVq1G7Atf13WaGB7ZQrwaEY8bnnkUaA876qkerklHih1YA4JHo4BoFS8btPZagvMaVkuIUboob9p9Hxw99k4B7saDnDkPxDKKbE0SOV0vwQfG23ycgRuhdmsE7dJv5hO/Glc3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z/w9ZMlc; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msRerJhLrVwruMoTuG3XZbovprrb7XrpZ9r93FJKdXa6awfvJcEykFOZA2kXHZ/8JHrYG7FvBLZKPd11o3EQ8Wm28kmBiEDGJQbBluupcObWrToMKjUDrUfkNBLzm+CgMI06g2vTK9MGYvnKAux33/7PVsU+Nma1M9AbeqIFM3ebDue06kzay7rvSl1qmdgvRF+hrphpaKUitch2/FAZDM8dqnGVU1het5jkrqylfUYOLQn/sOhJD73wi1WzdE2npQJJgMlMmJ2zrJEos4SSEr8dZftSo8h1Cw6zfoPyspqIfdXRzehNlhzPLX1wiXnHBVYnm4yR8sd0E9ZvLq3hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etQIkA8ny/fu+t6IYNLMg+Ftp8n7oWT7Ks0s+4ye+xY=;
 b=MWvRUivhZ1sSTihz+nZYGz7X0ESbQyh9XGdmnyFNKWpzamcb9pfScuiElT0YcTIdv52PtDjZqk6WDXY8nSPXj+PDFFL8UZ/BEwuOocu4syzo2kERW+2+lkIOrOQAbRXWL5jSstyMd/EiA1MPtV15bV1p8HxqNNagr9/ceqVVikz9KRss/pYK3wwuxiJD8+Sr/yYfJUCevNemL7AibMKdLbDlJKn45gEbCqHd4gK5i2DZKleYpgVSmngWwcIb35vJ35mNOPe7/ypDqh/L2sogZb+7uswE29m9WJgiMqM28csYgnIvoKqfh8RgBRH379lu0bU43bUh9/TUxxw4cJ0HFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etQIkA8ny/fu+t6IYNLMg+Ftp8n7oWT7Ks0s+4ye+xY=;
 b=Z/w9ZMlcUyvizyHxRrHSi951CjrYcbpwcDvSrZ7BYpG0i1SSoFCFqPX9sVbLyhG17WUUI4eCRpPUHkapFgue3mVwV+KnZrAfqzdtUkQT/7jWsV/mhldR8h0aEa/siPuyWsqzdff4QOk+0wwgz13EAY88IVyb24psILDWR/jEl68=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 05:22:30 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::a8) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Wed, 26 Jun 2024 05:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 05:22:29 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 00:22:25 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>, "Ugwekar, Dhananjay"
	<Dhananjay.Ugwekar@amd.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "Huang, Ray"
	<Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
In-Reply-To: <DM4PR12MB6351BDC3C062E65F0B26F7F0F7D62@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
 <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
 <DM4PR12MB6351BDC3C062E65F0B26F7F0F7D62@DM4PR12MB6351.namprd12.prod.outlook.com>
Date: Wed, 26 Jun 2024 10:52:23 +0530
Message-ID: <875xtw2s8g.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6e6aae-9524-4816-05f9-08dc959ff975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|36860700011|1800799022|82310400024|921018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gyvSyVCLLSPgF+ZtXdrZphH6S3Im/vLM6zvjP+IeWO8wXE6qnnf6nBsT5dt9?=
 =?us-ascii?Q?zn86hAiJgLGC4TJyuU1poZbe2COwvfwaVAg9TOVqm+zzi9gCMjHxCioINXfb?=
 =?us-ascii?Q?xaUjAk4aOHhwPgLoRHgaGhR7vY/QCx7l60h+01QgU4sI08c0ICBN+wl9mnEf?=
 =?us-ascii?Q?llpg9Z8NP5iBCJICht99EQsVFsBfNh6bvYRM68hj4MmMzmtz79y11o2VLZRc?=
 =?us-ascii?Q?b/fP8EqeyAoWp0RuZvJspWNQxIeB00xdmQ+vGV/rxg/C5hTeZALZuCdzEHZF?=
 =?us-ascii?Q?1BxQrs+TAxlWDNHdi17K+aDuT373mwpxZGG4LSYd9Upio3WKfguzkopP+W4x?=
 =?us-ascii?Q?F2tW6LsNPJ70a9sMQQbIYkxqHeUz1OIGUR6k9XohyYMH8tpYeqIUVBEhEehP?=
 =?us-ascii?Q?sY730i84Adj8S7Uv5OtEuAIc/0IZxD4AQSDTg1sZu5wNzfd5p2pRhJ1xyEyK?=
 =?us-ascii?Q?pkIZNVbYhEJiYrAvZKjJlaKELGQvYWtFLOokEN8yWrF182qIbQlD4jLy43d8?=
 =?us-ascii?Q?2uB2m2tt3qWNqPSiyecEPJ0OLZ10nu1w/CQmWHnEdOLPjcsZ6TlBazXtHvU1?=
 =?us-ascii?Q?CLpKJQkBuLdAg5WMczXUjekhapgtKXZVNrippI4yW9fwFfSHETY8AN7YJp+r?=
 =?us-ascii?Q?LWZV1YmXiE708GETVSLcTrnBUOXzXMUwd1QY/WpuOptfNndEOBP1Gkgr9RUR?=
 =?us-ascii?Q?GuUcuZtYnLcCoYnZqAr7ILkIGI/6jGEdlDDZBsUiSOQhmAO4/lFi6dJLB1Fw?=
 =?us-ascii?Q?h/B2Wu+VpRhvdnZTelyyTntd9bLtBlWQpjoUbJA9AKPX6C+M9vgY5TlMQeKm?=
 =?us-ascii?Q?pnbqSe+0ZlkjysyrCJKaKS3d/F1Wfa7mWf+1FpLLnR58yd9GaNdTmxhpxW+Q?=
 =?us-ascii?Q?szVET4do8f8ac39TFRaFu/I0yNPccqWKrrvnzZ7PLC4J1fk10qb/A2bR4YWQ?=
 =?us-ascii?Q?Y+0JbRXExfS6WI+TcOlnY64FixKSwT6Wq59lBRXkBSpnM9lcp7MatmV0GlYE?=
 =?us-ascii?Q?KZE+2Eh69eX3qWHZQGpgvl2epjaTtRON9qBJJMVqJwSyaDBxRaNIkjXCa/K0?=
 =?us-ascii?Q?cc0POz5+4X27+iahESGnuKTNhxFdMactYZqnnSdQpq5X5VpyU0zQDFkkR3v2?=
 =?us-ascii?Q?HSKC+KFc23HKQeQy52VxWKrXNHEMTyuGVDGO02SLNnC1Ofz4UIAG+15XxQtB?=
 =?us-ascii?Q?4zbd5i/krIkNl/VVhBkrd49+a2XMtPTp9+SS+mk8uIMD6o/KS7J90zr+8olw?=
 =?us-ascii?Q?8c/rCEp2vuHvoF9G4Q451ihI0yJSf9M8bRycyo8DY6RYdS9zETkkBSi1RFYJ?=
 =?us-ascii?Q?7sHn0BwXiXxlPHu+nZqQwSLSzBkem3G+lohvtnjFsiX4F66NApdwe8WN9BHS?=
 =?us-ascii?Q?t5yAoA0AZhSoq2trxjlMbtA/jTPjRj9QIFs5J4kZHbG0m+j7WKGedM4L71UT?=
 =?us-ascii?Q?X5jqu4rP8f++bqiJL4B+8H73autMFNcx2d2VE9UHhxNQCzBnPDJ8Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(376012)(36860700011)(1800799022)(82310400024)(921018);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:22:29.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6e6aae-9524-4816-05f9-08dc959ff975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356

"Meng, Li (Jassmine)" <Li.Meng@amd.com> writes:

Hello Jassmine,

>
> Hi Dhananjay:
> Sorry for the delay.
>
> I think the correction to this issue should be in function amd_pstae_init_freq() of file amd-pstate.c.
> The value of norminal_freq should be consistent with other
> values(max_freq,min_freq etc.).

Perry wanted nominal_freq to be in MHz since it is not exposed to the
user via any of the cpufreq sysfs interfaces.

IMO, it woyuld be good to to rename the variables to have their units
for better readability along with a bunch of other
cleanups/code deduplication. But can it be done separately ?


>
>> -----Original Message-----
>> From: Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>
>> Sent: Tuesday, June 25, 2024 9:52 PM
>> To: rafael@kernel.org; viresh.kumar@linaro.org; Shenoy, Gautham Ranjal
>> <gautham.shenoy@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>;
>> skhan@linuxfoundation.org; Meng, Li (Jassmine) <Li.Meng@amd.com>;
>> Huang, Ray <Ray.Huang@amd.com>
>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
>>
>> Minor modification, the commit subject is supposed to be
>> "cpufreq/amd-pstate-ut: Handle the inconsistency between nominal_freq
>> and other *_freq units"

How about:

"cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons"

Otherwise the patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.


