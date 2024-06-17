Return-Path: <linux-pm+bounces-9292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD67990A70D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DC61C21843
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83167188CB1;
	Mon, 17 Jun 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tXw8S+bD"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2043.outbound.protection.outlook.com [40.92.98.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594D18C320;
	Mon, 17 Jun 2024 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609301; cv=fail; b=P14ZnLq/eFO8C1fciYowfbxQt7QvGEOZ1zjRADk3yR1/l1q0b/ei235Tuj5uqtczqfn3vU1GSC7LCSSFbdzlUTszgZOuBPeM+cFuTu3DYGLKcHDn6Vz4ITeQesXCpx9UfCu61xbLACXLIVCOi1GmxcbVwTLw0ifJmWs6ECQH8r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609301; c=relaxed/simple;
	bh=OFJeS/PP8zKTuCZvwf6nMKmxU3pRGd0lVmckNBH0Rcs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H91tftwGz/csFzRUCU8NmY5+oE+Z7ja7s90qlWWCX/rWqRULbn7ZmBuf6bcweTBMjwL9fURaok1qkFo76beK16ed4NRj4PUzuEgk6X0JFxtabR9GEiaq3yJ/yHzuW1BnlL6mVtZiUAjZYMC3FjxkoUCxcEOsBCQfr2Hg25ZCeC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=tXw8S+bD; arc=fail smtp.client-ip=40.92.98.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADsKOcLpiMVFfuuUDiVZZ28ntwDbgRyKdFATWTo8621OV4KzD/IDP7+pLjSKBQyqU03xcEhN9v2dMVhE14EerVUFSV66dH7nuSC4CUsZKMTQkW4KwFONL83dZpx1qN4QaMOrkFzhNzyLFZbatLrUf3GWWT3lxzku/Q4RY+r/B9rm4CjuNAshV1bFxoBCiaEQPYyd+Hnx64JKfgVrHL7eFeKMKWHrvrMAH6xaNiq+L9TlA8lh84x3jdhrlzsCa2LawghpnJqbybp9VpwvEM2s90Qqw/bx3Hot5vg0tr1MWC2A9Ns299jTaniyzKcoLyJG4qaB1IjBY6NBFSbwFRMipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kHmj+FF9DMq8xevOJbv/EWOkP8C4vSDTmV+2ZqxW84=;
 b=Y4WFJRRHm+9JhxkGpt4RehdGnaAH0WqvRo/UakYTdWxGY/lheZjMIW84x8AIPgtSoPKrXIChjszLJBRGC6Xhs3snmed+tO384E7Hz9hwXjeKpehcqvkL9X9p1tu9Y0kJJbrdfA3u+yff8MH4dBIY6rwHahO+6uVfEyANaimCmt1rDVczZDezqgSQkUjZf/DUHt+GNVPgsurWIV3cecVGmdQlb/1GGwbl9lNMjUGphMV30nYqh0F5dfcLYgMOkg9rnj9kFJv1MW1W8Lr02WYHbNviAQ4PHI26oqqD8wOR2PzQa5Lu4uKIiOpXm1q54Hj1zMSuLDdrIsp4JPEBlB93Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kHmj+FF9DMq8xevOJbv/EWOkP8C4vSDTmV+2ZqxW84=;
 b=tXw8S+bDklSYUgk64FKtV6yhWlf2Qom2eFUO8Pq0qWl+uQeXoXBEi3Qbf2HA0esz9TmzqLC7flgLtmUhmQQ7QZ9alE5awsy9lSEbcuOTUV+N6DqQTQTNaq0sohf/kHjwmUNu/OApsgtHmWJM1dxGlM2FTXqdACSLbIBhF9INamBXjFTYVzIuf7tInvIB/SaQ9+QCsHsvxy+uvDBvbhp3geJDmybPNBxP29n0uGyVeb0IcpSbHZw2JhhYEv+fLY6ERMZDhEA/3ApUm0u2IgIMkoy8rgcJba/s3Yg0BwN0JM7zWR9UEJU+9XLczZ4Umq8Y+JQHEleZ0jpt2jva7YJzXA==
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11)
 by OSZP286MB2442.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:28:17 +0000
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef]) by OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:28:17 +0000
From: Riwen Lu <luriwen@hotmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: ionela.voinescu@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] cpufreq/cppc: Remove desired_perf temporary variable
Date: Mon, 17 Jun 2024 15:28:05 +0800
Message-ID:
 <OS3P286MB249037D0472F6BCCFFD162D1B1CD2@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [qcsB02YZagS/W9WSDM8XD1z1JRQOzLu4]
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f1::11)
X-Microsoft-Original-Message-ID: <20240617072805.19407-1-luriwen@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2490:EE_|OSZP286MB2442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5486f2-8173-4c06-bd18-08dc8e9f0e0e
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	L8BjiQKKg9bfEf7se3a2ANiGcvMdazBynqTGWw3Ck5AAhOt+5m2Cq4EyvnKXcjNvwHQnFPX3ipQvvterziHu1Ihrg9ZLU8EUrvAln1u8nqBNmJtae7ZH+9n0RW7uPBw/5N52jtTXRB1avBfipKmO/+8N71wlegf+YBcAtR6qA/pWIejyZhH/eAGVpSxzYfNKAEyCzJnHUV8xvD0Pa6NNOR+urC+eOzG50c5zdwzkGULY+zwlRNeoDMbRM306jbXkfvE1VJLkqOLZYl0Nl67qgkUxc9Wy0LWeG7bddph8D/EPIJUZ9jwz4UgOqScaV+bAe8c4F5u1yj6yBXfr7QeqEmcH4/jidZooD8Rm37bJICKVsSBRzpZo05ARQW3WH4na8XXp1H+LN8zW7XGS0MeXi+rfIhxnzBeAsyid70Ila9m+9X9j86igAV5l1TkwNcZwxa2ZzbNUpZgqos937k2QKfjguIN8NUX56xmnp4MDkGf4YWLRkxRsgzIwyeVtuJqE8GP61/uuktsKxPSpcgzOBSOBrX51683ZdG8B4ZO4WteOcxm3RPBxyGf1mcflQmbb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSZ5e3W/3/cCS8OjlFnk+mVkrNBEo8gxuDaR/qIx5v4IVwcyp/G3j4kOUyzK?=
 =?us-ascii?Q?FSavk/3+902PMhNKtL3byuCKO4TU3obEPY5rbNY5IACghnUXx+U7lPUlZ55E?=
 =?us-ascii?Q?/bhI4Y1aqWeJaCY3VXfLl5X0nuVJYBWBYtZFWWX/GOEKsFirx1pCeRxrmiQ5?=
 =?us-ascii?Q?erI+rv4GLKzwcKN1qYy+ITonEPqPGL9IfBVmNWLGZbvPK/OdBzUEbr9+MBTe?=
 =?us-ascii?Q?kLb7SoJE+rbPCDuUwNQza+0a8+xjZoYpZ+7ee/Nt44Zkz8M4SfNmHWNYeWst?=
 =?us-ascii?Q?UjUNL6m+ED7pXoiS37tss9x309A0b8mQQquDK0pAv6XLYRwXS/wiJBjyg20I?=
 =?us-ascii?Q?OCxpSWsUyx/LH7tR29fWXNl1nFnIHd77JyBEALPpZ1kJeLSgsF67mA0re65G?=
 =?us-ascii?Q?HYqZ4TuryjM74/IABvXLuPNmymBGCG7iJrIbeOsWitvQEA+aoN5B3gQ6eS1f?=
 =?us-ascii?Q?w96063RUVAknkvOGRBbElVXaPds0+OymFlB6KCKYOfGSYreap2nAyt1n61Tg?=
 =?us-ascii?Q?sEHDqnJCswrSkQroOMT5HXaRDT667JCIIBFuBnxytQ4O+LPkR9ae+o45t+RG?=
 =?us-ascii?Q?T6SUXoQ0HxIG1MLIrBgQdcXpKGB5nWw2tJmYhA3mpLKHgo27knh5a76y4Bp6?=
 =?us-ascii?Q?a4fQ21k5LyZv+B7r3y7lfIwaMI58RoJJHEEQ3rthFo9N9MREhsvr/gOLWCqc?=
 =?us-ascii?Q?4Ylj6q9utbuyIcgrz3Coi5p9oRojAELAYWoH55Zd6pSHyN5IduSwa6yOif5d?=
 =?us-ascii?Q?h1SDjvqH2keHjo9rivckNa1r3itjWRnWGDRwJ0FyfQ0Jb2lXsMj0JNOEEm80?=
 =?us-ascii?Q?nPu6G+fcXCS4PIvoe3xewM3xuq9H3CRVjph5qiWNY44ir2UlaAwUAnj+4eRA?=
 =?us-ascii?Q?BxH7f+0+f67bMNDL6nQWKjk7EwBdFprBwgldeIdJfhzFVemjS3dEZHADKuYw?=
 =?us-ascii?Q?u2FatC2aSgFqIeZlq7ikT5G2IIowdGXNCe5i8t2ld0C1iwgcXMuZsEaA6iiH?=
 =?us-ascii?Q?aWayppItZXKgQOC2ATDjJl33zUjgxL8dmdxvkFEqSjCkHKKBB1E4q5hpUVJ9?=
 =?us-ascii?Q?a1ntFf9K/wLO3JkGGuGDtEV+oYq3qfDftuCldougAwH82/aN81KdTke8IoBL?=
 =?us-ascii?Q?StEnxW0Fwu478L1RlAMNbnCzloheBuk23B1lyOhBjnw6dbWtq69YqxNburQa?=
 =?us-ascii?Q?3+yjrM72qh++eeOrADb9TIHHZpFpuxKLp15RDtCbiH/GhHB1TvIvODRnhLk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5486f2-8173-4c06-bd18-08dc8e9f0e0e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:28:16.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2442

From: Riwen Lu <luriwen@kylinos.cn>

There's no need of the desired_perf temporary variable in
cppc_cpufreq_fast_switch(), remove it to simplify code.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9095fd5f8c2d..9a5af756e447 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -314,11 +314,10 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	unsigned int cpu = policy->cpu;
-	u32 desired_perf;
 	int ret;
 
-	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cpu_data->perf_ctrls.desired_perf = desired_perf;
+	cpu_data->perf_ctrls.desired_perf =
+			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 
 	if (ret) {
-- 
2.25.1


