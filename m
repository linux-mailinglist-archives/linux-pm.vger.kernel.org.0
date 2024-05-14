Return-Path: <linux-pm+bounces-7794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F238C4C6A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DB51C20B61
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF9D2FA;
	Tue, 14 May 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hon4hOu/"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2061.outbound.protection.outlook.com [40.92.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C1386;
	Tue, 14 May 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669050; cv=fail; b=as2GosRYXnxU/CEHw/g9TPT2j9AwTZJmN1m6hDx9Z/BavrqpC+ELFHUjRdchfecyqEOBB4XnWZ5u9Nvcwpt+0NjkhUYY5Q6RChmu8lLju8Im+x/n2L6mvOVRRRj/rePomc+BM2kDFIGcPBgGHRjnj6PyWmZv0DtCgbYmwJ5weKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669050; c=relaxed/simple;
	bh=AA6xVIjeoFuG2Z4CnzdPtgqDguqJkdlXakW3sceZEUM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XvyxSfBGIG3yC3wB2NMd007uVRvr8rBGn4fDhq/Z0XGnye5wrG/7JVFi6KI4OrSxDtroZHtk72v8dDfLIW4cgsx0zpiVg5IN8gR/xuHyYq6hIJap1Ft9zpkBUcUi7L1SzV03D6TuxyJNX+9ILPXBUPuRlh+dLFi4sztwIBW4xDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hon4hOu/; arc=fail smtp.client-ip=40.92.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy5SjC0zsh0dqekcwpgp1WQmsuPiyuOzXGNRSht0Ja+++oxRwj+tg5jWe7Tk8qFy45OKOcxBcHqQxzyBS9VuyTXyjJPiAqr7biHULIVjeX93ptRu4XgAezWWh2OUkeor33hdEh4CwH0/G+OP7VBHIBUjfinVdA05XwTeRt6/F2zRoDNsPGFye3yRVpDNA5u5HoV4JyV6Blemrc5wFtof0XfoHgAy96o9t3gcQ6GCkDu6xvPBfPSt9i1Grq5PU1nStEAk79MasxJrOS0xN4W5iLI6OxhRIhYRVTIWNfvbh3jNrfU+Q7oSM0r/2NBRlQX06AW+xZwJ0R6Vwq/j+SGlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw+kMVPBU5qw+FtPWzKyveXpNVmR04EyH7e4nYIG8mk=;
 b=cUH9NUQVuwjgMp9Bi9CsKZ1XM3gd0tWX9u0CjbPuKzJ64T8wJ03V49KzHxmrNgFT0RtNwGkCEp5ms0pSQLWQbRYJiqvk7XvT9LZ/Gpb1JqHQbK8T3wzY474OeaTM2Af8cDjWnql05WmZda4z2+64EHPnWWXRQx6sosFyyNnTIe2LUy5uY2/TZ0flrDlI4Jwe71GdJv+1wlikGWCP2o2d2ogo/9yNjIo8gk7PYkEVEypO3++3tpuO90UIZieQSQxOFNAkzkYZJAbOVOy4uRAsbnpjlVzygkuXkXEYkUcPJhAXNdNUxIFridy9PvTAf0D2VsHYNcwLxlFWYBO/RB128w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw+kMVPBU5qw+FtPWzKyveXpNVmR04EyH7e4nYIG8mk=;
 b=Hon4hOu/o9XG6PUYTJSqgVBfuEU/up3/XaUw/yJq6ZrTcsLAJuXhQumgSW336M/6njxBj4BjXNY8/utBgTRM2DkoXFpz4Ls/k1PE8qcxhvDQuZBHRFMuGQ+flXHP04o52tDq3LslPKDPF+UTXcnjD2xZp/biP6QL9Ossdi9TKKB8EF1TCNYUcBOi4ft2utPQGXjcChIuUN3PzxBzjGEwAMK4yFE6LdAFo68yH5tWLtSZLamfbISPN3Pmt6CIfMRegZrhNOPUmuyFlt5DQ+nnElcuLyp2v8UZmgC6Dygu1hDaDWnBPR2sebbikca9RsBWhSVyXRx3ZNqx6ihnJ67CTQ==
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8) by SEZPR01MB4453.apcprd01.prod.exchangelabs.com
 (2603:1096:101:71::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:44:05 +0000
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd]) by PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:44:05 +0000
From: zhida312@outlook.com
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: andypma <andypma@tencent.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2] cpufreq: amd-pstate: fix the memory to free after epp exist
Date: Tue, 14 May 2024 14:43:27 +0800
Message-ID:
 <PUZPR01MB51206C1D9F3E2005B5BECCBA92E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7cp6/NcEvHTFzuXDbmBavEulT9/Q9ivn]
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8)
X-Microsoft-Original-Message-ID: <20240514064351.36746-1-zhida312@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5120:EE_|SEZPR01MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 764f445f-5521-407b-3b36-08dc73e13f49
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|3430499023|3420499023;
X-Microsoft-Antispam-Message-Info:
	syjQjQ1U8Xn3cbh2X523XKNBZHgzSggUY5brFNRFD4BMa4ypd6Dsu11hOAOmxYg+KwN+6VTgzi84Ppy3nu7VGTBo85ZjMSXLH2JoQbuRIkVGON2zSpyygtB0uzIhPOYV8LT3wmh3bRsQwMe57nGoyVb38/XWP6fYt2b0my5IMM1ef/CKUzARex2BZvNq4rIAoNhpE/27jPNMI7tPXXrOtWMDpwo7I5zWpQJMoW9xhYyEi6L6dROyP6hJWqHtTDzKtFJQEHHqa5q+BPYqap3dg/kVMjvCAYc3egFsXUedJ5FJkcrqiebRm4cujHeIhkEMHma84ztMEuI6xE9jaD1qDsLMTcNmUkWtGjgepGZG+IBkBoMCggQIiKuvfUoRukl3LhozRXYuF6VNFr38DZ++ixpR8Cg5dmeH+V9LrJKWY7/W4zw/th8G0BDKfSypYt/NFnPXEFjci6IVnuvo+g0KSMXfofg6qrgBhwWL64kHw9xLb/Qg8uJaCnHKDG8PjEV0c6whJzr5e9MO1jbFyQDSPaf8q8H41unaCWfC3seFAtSSSL7ZzuGyigHrs86xt7J/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcSJ8nO9WCLGGAfNzbYLr9y9eomWx70KrfvFhLflC19a0GyG6UU+FTdGV51l?=
 =?us-ascii?Q?WZs57ZO8UlOPCq4xIxBtHyZHzfPqZa/wuo9dOBS49ccf157pqtNkMhcszk2x?=
 =?us-ascii?Q?psDOekSgjvrCzbGcLMtWlCUgfJD4cWJ43gg7v2n5+F2I6Kgv239udSCheQfp?=
 =?us-ascii?Q?9l8YvDzOU+ytBE36gcTRQVjjd9XbWKi+1sY9wGkVAgNYnEm/EJYerZ4xI8Ha?=
 =?us-ascii?Q?2CQ4fFYIS53cO6eBi3FOO50cE8p6HQfnYzX6YwoARcBG6xQt81pbz2yPBoK3?=
 =?us-ascii?Q?A+EFbLK9kPno4pfG0uZyVN/JL9hmjEfQzvNz4utefAZSaFzR0bQQPDDn+zhn?=
 =?us-ascii?Q?+jZW5FUzWByy7caqd+r/+6nKN+8fRFKjLrOanxbYHJ3U9vzwWJ0wFakYECMy?=
 =?us-ascii?Q?71kxSvsnwASMLHxJtXhuwKz0hh4g409xmGjiXT0tsGtVB1t+JVK8DsO2mRl9?=
 =?us-ascii?Q?S0co2NeSzNtL0SjwaQnpxX9b1Ok0JwcQzIs7L7qztea9W/Qlg68Oapve6lfl?=
 =?us-ascii?Q?Qz2WsZM0nEHTuTtL8V3EMbmEtuX7gdDcU2W/kG4myBiJtQQdfVVkrrATyWUV?=
 =?us-ascii?Q?8Fb29lc/nRpZPnvSva5vpkUC2h2JnhLlHoYvH/cAPXt64sGFkrw4jl5LdBUp?=
 =?us-ascii?Q?4I+zfzZ5PNTazuxTJ7Mg8QWGT6MugNBeoCZrhhKUDseK562+XxmIbXZRoeVi?=
 =?us-ascii?Q?MaHfrKfiRQinhHXAefO0adOdJv2HdB+uFd6j+/LbxBiph+J+xwbU0XJg4b3H?=
 =?us-ascii?Q?Ns/YMEc6wl5vFketLSilZIQmifbXZOOU4BfiraAaCAlEEm5NVepi/LDBAkul?=
 =?us-ascii?Q?qJn30JMcKaNWhDlfTAHoAaAq1Z6G5vK+FfjQ05PtYzVRn5hsda63aPvstHCz?=
 =?us-ascii?Q?UYvCaklKJD+8mJtwq96yWOjkj9svHfwQfZcU6n3Tm1pjr3XSGYFJM8C6z3jB?=
 =?us-ascii?Q?jSUy0QrX4uHbn5OveKIbL7oHQzJE0xKdWVJg4Qu5IEVzqcUzfJle0WyjjhCC?=
 =?us-ascii?Q?cr2jdy6QscrhhQfrZS3ZCPIejau5I6WJ+BnHahpG2tXgwWl6HZwkUE6Fse6n?=
 =?us-ascii?Q?R/z+rXTeQFZ4WqUW0drdE3XvUr1tqZUdFpjq1IjkeWtWckUK97j48pUv/ywd?=
 =?us-ascii?Q?EGYykIv3MbXdO5sshzGbA4OxsUuk/34bMcHBf6sX9kPNfaC7/v407YJlP/5s?=
 =?us-ascii?Q?7gqlURu7rpY8ytg71ZT8XpkycvWzOGYMGgkFCfQnXgTiUn5ab+3TUN5Szhw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764f445f-5521-407b-3b36-08dc73e13f49
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5120.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:44:04.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4453

From: andypma <andypma.tencent.com>

the cpudata memory from kzmalloc in epp init function is
not free after epp exist, so we should free it.

Signed-off-by: andypma <andypma@tencent.com>

Changes since v1:
	check whether it is empty before releasing.
	set driver_data is NULL after free.
---
 drivers/cpufreq/amd-pstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a342b0c0140..e100c5b6c9b2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if(cpudata) {
+		kfree(cpudata);
+		policy->driver_data = NULL;
+	}
+
 	pr_debug("CPU %d exiting\n", policy->cpu);
 	return 0;
 }
-- 
2.33.0


