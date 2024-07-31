Return-Path: <linux-pm+bounces-11745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51A942BBB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 12:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B60DB20C2D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC31AAE13;
	Wed, 31 Jul 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tYIBqhha"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841E1A721F;
	Wed, 31 Jul 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420751; cv=fail; b=pzhIOsWQOYwikOLwn+xJlmqDIzxD4QeQfStb+Q8AY3JW3MGLzRrZ/ZXxJMV8KUwezXNkt2HyqjFFVEnNpj3g2XWeIhC6s7UomHs/2MpfH7GSls/0tuUfPBbJ5Zs26xlKwmJEPM710+b9qYXjbkDr84mfrHxd4KDKlTmGoWKPFOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420751; c=relaxed/simple;
	bh=gRu5k9ZvWZy/x6Ub032euLKZDeK6K6Yib9fvbdivls8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N3lNlIfmBYFfSjhlQW7HrelEbQmC2EDnpt57SIh0FWKAMgA6wxzec14sVSlat1LnX9fu/2Qut2F0bD9kIBabi0sYr8udq4rTHIqSAE2XB7crSNDMB2YYTXhM5IPSoifYd+8R3tQbhinmnj+p86C1prXAsFGrPSyTicydYK3Ijj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tYIBqhha; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igYgk88D75BK9CuhrcRtgyn3IxxMip7OvFk3jWfuVJp9bRK7aQNBbeqV6h4L4vuTyRtkowisv2W6oENxnoqzZ5UUtYiTMjv0Mmq9qvVoEGj6jRbkONRrT94OEFXLbRgqdAd+NHnahrpXjfH/SIqXwJK5W5t7dFrkTJn/n1tDkeZofB8DKnA5qJeDSsk8vtd90o+IZb3JSvTmhtrbnOqiphhBEfcJk+L2QbunZcvLi+VsMcZahhiWNfU/fh+E7HUNdll7sKIrPgVHIE3NnVNSrcf3euttmTyhGYmnB3P3kxCbbnIdzOmjp3HKkuMgyXYs46YTjONAFBYsOhxo555d7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yJNEkbqpjua+bUaamfbIzpOL7weEboxu3qPxp1G7RQ=;
 b=hDqUJuxe8c/dqJ4/wIfUtUBbTo2bzvjx+NhtwxIzi8/giq1FeKZomPkh+CASCr0UD7pMGEPGvTI8W6uorBJA0oI8lv1qeJhKgw4SesBZxDjJxR3uoR18AvV5sqk2Hum1+g7dgmJ6+nk42p8f1SRgr1euGYoWbbA7jxTe6YjAVIDcL3J37GfP6OEzASBWHKnr9QEMIA1GRi0W7eCYhWmaKrh+1lf473hkxcYC1MWn6t07uKdStwFyq6uXGYSuQTFg2rNzfcIzlok7bE/ZOI2ApLtEsdd5SxNqtToynO+D8oR5pFjmFdrMZIbpNey+8IcGxwd8prdS3kwckSH5+4jU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=163.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yJNEkbqpjua+bUaamfbIzpOL7weEboxu3qPxp1G7RQ=;
 b=tYIBqhhaGKjPEfbEcuiD/NGn5TlGACn1bZLL27nvlMDHBLRbZobXy6USBOGnEYDTjL7HIOQRPPzVeMIVcJw3TPmWycbxrahbnn2qn5rZ0TYsVF6ltZkQ+g0SNvo5xoq64KflsR2Yw9jA6FgTpqEm/mxhuudqSndsWSfFWwdvOJw=
Received: from SJ0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:a03:3a0::9)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 10:12:26 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a3) by SJ0PR03CA0244.outlook.office365.com
 (2603:10b6:a03:3a0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 10:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 10:12:26 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 05:12:22 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: David Wang <00107082@163.com>, <perry.yuan@amd.com>
CC: <Alexander.Deucher@amd.com>, <Li.Meng@amd.com>,
	<Mario.Limonciello@amd.com>, <Xiaojian.Du@amd.com>, <Xinmei.Huang@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>, <00107082@163.com>
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
In-Reply-To: <20240730140111.4491-1-00107082@163.com>
References: <20240730140111.4491-1-00107082@163.com>
Date: Wed, 31 Jul 2024 15:42:12 +0530
Message-ID: <87zfpxsweb.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 080b950c-e67d-4ed9-bc5b-08dcb149470d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ya7NiEAMJbUqxAbkJgiW9ZIqDqdi9NBFJ3xtOx67g3MCD+YHBYLu6n7MOYfB?=
 =?us-ascii?Q?v6SJlvWGejv98TgEypMTIvhQlZ5eVjkmRgmr/87YLb0n027TeRRJSjZ0wQ3F?=
 =?us-ascii?Q?yhAQRtR6+/8NftaTimYXHyQwI6dgxhSXsgBYKiwpa2RgzZt9gWvj1U/hBhPg?=
 =?us-ascii?Q?1zjTG6WXzlJ+c5xk96cTRS46bGSB+/7/8Y7gJgr/2LCKx+WNYL+C+pECoCFO?=
 =?us-ascii?Q?vKfVncN3izlXzNwZmxkhMgCiPWK7I/9Mp55xHLnfFY0u+hRxQOPT5icUtpWP?=
 =?us-ascii?Q?bIIRMuBI9Ly/VpjqEyypGaUu+RR/Ey4HQiJGDaUm6S7axGIsddiPE77FDR35?=
 =?us-ascii?Q?Hg58Y8NBUJdLiWHd/TqZEZ1Y33Kj48zyzjeM3sdbjsmEJfk98rE3pf2eeXD8?=
 =?us-ascii?Q?GUxnI5lBlnGOflW8V0JAyD/tKpSD0pc20dwqSU924wcZK/DzVXhh3gahVZLd?=
 =?us-ascii?Q?MDQMa7s1+9eCL1ea59b5kPTiMyTvUyq9kjb+pyaYIryYLUXvGi0cj15RlJPi?=
 =?us-ascii?Q?HyYr9htVjGgUcTtdbt1Zud6Mgtk+1dn76DcFOfor/6HgGfvYhrPegn2lZEBV?=
 =?us-ascii?Q?cn2cDppFNlgXwH+W0GKb8XoaqM2SZNYtW65HUfpDUY7NHQ0LVzle/QrR/EDm?=
 =?us-ascii?Q?8TNZZwJIpLxp/Jqt+aqfmG9fSy176PVo5+nPM6hb+jMwT7/8m9FwpQYG73+o?=
 =?us-ascii?Q?G9g8/AKcDIyLRkM4TVMIrFA50OqzYvQbabJdHqOPQMZkvdU5CC05zbePXPsf?=
 =?us-ascii?Q?gXo3XdI4rR5iaIs7xq/nrwPjga4RJIlbahMZPN3WxJfvjT9PItDJbSAaIvE1?=
 =?us-ascii?Q?Pt6Ruvi+n1l27Ivk9YCr6idrcjlWplhw/VqvF7SL/38kXRVkUJq2Of+7BKZw?=
 =?us-ascii?Q?po8aO5DwRaWY1GlIC4+Rd5bI5Tf0N/pzZB18316XLCLki4eJqUh/Van8S7PY?=
 =?us-ascii?Q?OH8aw7gVbfR3fC8NcZ6sfflpr871yA2aU2C3aSk/oYyQWSCRejTeTgBOo8Cd?=
 =?us-ascii?Q?DSyFELZH5tDjPmoRWiyarZtbi+hisbOMY1M1kNOMlMbEQ+e1OutBqsht9Q8u?=
 =?us-ascii?Q?T8wwmk2Zowry1GAECPXgHGrq+ykdP1pRfl3Cp3fFP4dn3e5RE2W6G4ohtdJw?=
 =?us-ascii?Q?yNR7k2p3BLrvsBE+Vzhjw5AgsCwh+QzY/Ci25qNZCJcdnf+y7J3hJRM6/ydA?=
 =?us-ascii?Q?2rZfqyKuFGBd3SaGArOhBMSFj/soHYGEBxxnRt2i+MptKAkXuQgccQ3nI8dV?=
 =?us-ascii?Q?Fb/7fb4N4G0/aemTWgK79LWHFg6zQ5t8aywNTTeSRxt4nOQsEp2HV/mMIVBW?=
 =?us-ascii?Q?2Bif8mQ5bYMZHyVo6m6XX4WtrffWw3EWwQNPrU/wa5fEo+tn460D/UWNzXTE?=
 =?us-ascii?Q?6sWTwTiXSQnkXHqhMf5/7KgnhhPCwysInJLIaE715yem9LgkYv0gXj+8ZwQx?=
 =?us-ascii?Q?KBGKrMpiQHpN0WeXN0BC+0TL5X4+j40B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:12:26.1329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080b950c-e67d-4ed9-bc5b-08dcb149470d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420

Hello David,

David Wang <00107082@163.com> writes:

> Hi,
>
> I notice some kernel warning and errors when I update to 6.11.0-rc1:
>
>  kernel: [    1.022739] amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>  kernel: [    1.022739] Please enable it if your BIOS has the CPPC option.
>  kernel: [    1.098054] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.110058] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.122057] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.134062] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.134641] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.135128] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.135693] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.136371] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0) value is incorrect
>  kernel: [    1.136390] amd_pstate: failed to register with return -19
>  kernel: [    1.138410] ledtrig-cpu: registered to indicate activity on CPUs
>
>
> Those warning message was introduced by commit:
>  bff7d13c190ad98cf4f877189b022c75df4cb383 ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS)
> , which make sense.


If CPPC is disabed in the BIOS, then the _CPC objects shouldn't have
been created. And the error message that you should have seen is
"the _CPC object is not present in SBIOS or ACPI disabled".


Could you please share the family and model number of the platform where
you are observing this ?

--
Thanks and Regards
gautham.

