Return-Path: <linux-pm+bounces-33204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89AB38B17
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C401C2034A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C622F39DD;
	Wed, 27 Aug 2025 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Egv8i4FB"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D722F74D;
	Wed, 27 Aug 2025 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327463; cv=fail; b=nsv9D/gVkBtzcqpQUBg8zUkTeGNv1yYtv0pozNKyd/N3utsbP5gh6mdIJOte2y/dnVns/1x/YvNJ9Y6lBB9Ds49qAKy1JVBvDDRODkB3HQf7NrmB/KKYKx/GJ2dgwW6lxubJmXuW2420zLW4RQvLKKBUz0aBgvQwbjxum1uu1vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327463; c=relaxed/simple;
	bh=rmSQygkaNp+0ZIcua77BrvRI7QduIqOk6tM4rTkD7kI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=njrmx6Yjd2lE72faEixBYpqkNjbZCSYCpMdrbJVgtGnMo10wzx0tZ3GMN+jfY5INnKzfoFaWuJ74Jl/ZueHOut1uB9oC1lXTTijWCgFrogL2QIkQB19C2sSi7fvFcWOufKGhHcdrmzhxWzDKcSviU4bDOYoRHERtoMfuWzYDReM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Egv8i4FB; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymfD0FNmSdnTE77uhmSFV49wzfAuwC8A61d/j2f/XCMwkpcysRT/gg2xQm2h+TB9JhpEpEmP0xfrFapR3t1GwwAtJbMnO1u2tUdp+nU93MVmozsVZ+y6zwce6gSe4/KGvZbOswJdsx4w/5c6UtQm1D/SbWO75HgynyWQsGsUMR3/3VpwjtndWUafBXAyBZa5zisAJT0QUDBsK47RgWP40vCU4owwVXlX9s1a3DfMU/LmyoCkQ+x+iZnPdvoWks/u81q/+Q9u9mgrgMsrmC9ixXec9Qj5gjpgItvdkfI5x/2P5vN0k4fFSLvxLF/kUYsmAuxLQ3b5ld+uwPicii+33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RgE71hOcQjAr6myOvV8T2RqMhT0YJW7WNaOOc7DDTk=;
 b=Yswy6vBYEZjPwTTMYG9X09F4otTP/Kyfu3IRG44AoyEwc560LnyIPd671QMtipr98d1cxiqFgUYiBjx8Uvuy+V6fgLd6tRMYfe7K5kU2hsG7+aK0fizlXTayaA8KaIdkiI8/8PVd9qtXp7CDAzadP1rpguVc96mw0/af7q6QygkVkORCa86w6rCMA0nOphJQxzobeqcnwqM+SiPVzJbKYQ9aigxFaoA6aFirmSF+zJ7qfdh222ZPxYRtgdSXHXL1j0EBp9ZuTCT2aqQLpb/P6RbbuFjUnoP8PJ3540qOs5+Svt2t17c400RfUfzCF0afCv86JzGZw96dotczU0Gr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RgE71hOcQjAr6myOvV8T2RqMhT0YJW7WNaOOc7DDTk=;
 b=Egv8i4FB0Rj6j2fuu3O/PrapGVASKj43c5dI//Vvm4tfxpmHRzjoN2aiFWfojqwbb8m5H0FyWLNbbQqaJWyIdwoRMF4rDawYfKF3NP+Udn+/G/dA9M2NcgKK3i2qlpASIyZHKZ9T2tYFaPbCp5t9Z5xnizyJnUUntOp4iLC7ZPqnW3UQOWqo0lcOkTG+wiVKGLleeqRAjLVPGEc1DLVsjjopqo+xq8AzQlnM71BmTGqCT90uKiPKHdbuB/p/EqfFIwgXvI3GCap09IBT9wjIKVNHD5Uumz9Ycbx4CmpY08CbsYf+5U0Zj7cN3lOl3C/DQ8VBztdHdT4UHLRqLmaYEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7729.eurprd04.prod.outlook.com (2603:10a6:20b:24c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 20:44:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 20:44:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: cpufreq-dt: Remove redundant cpufreq-dt.txt
Date: Wed, 27 Aug 2025 16:44:01 -0400
Message-Id: <20250827204401.87942-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 57aaf7ea-1f52-478b-d39a-08dde5aa7d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgHAfk7r0EeiEwddYYHfxPVikXZDl1Q7iPUaGKHbqHTFBo9Q4CtDAZOX2KBu?=
 =?us-ascii?Q?IUMGjXNEH8r4ZNOpbZgON1gdqIbK7JGHKdqFucDAiolCy95YQOe8eZRg9bqC?=
 =?us-ascii?Q?i/Wl9JzDaEWt9xpKlF4CSuKG233qYmh3rQDncupu19WJxJ1M7PFHBAyPg6JZ?=
 =?us-ascii?Q?YhVII71pDCpr784JQX3z11zW+4Mq3cl5f9rbO9lyqQe399kYbUgYrwxYlhZt?=
 =?us-ascii?Q?blImyq/YV3RraShWBppDKJM5FlORmcf5qy2xiGicboWdZDU+cizWUK0kVVIy?=
 =?us-ascii?Q?Nu/nzAyZ7mTK4KLt7QjFbyHtz1xgpR6sVN6cHtwDXDArH8KWR3UvDGdk/LMI?=
 =?us-ascii?Q?lYWkALfnmId5aGF5/vIpCFEbYGYEq1Wu25Rb2F//b5WrkM6p0P6TDehjjmUl?=
 =?us-ascii?Q?G9CjJQ22/u1y0FBir3ICAHVP3BzSERJkQgIt8AFJNko2y3omlHTrdrkZY9Bf?=
 =?us-ascii?Q?0EQuS8d0UXomPu0hHiTZsGxgXOjANAOahyCqEhKN2fM7RKSYZQRPPYOgwRaK?=
 =?us-ascii?Q?dBMryk8b+kPOScTlZVM4KcMjum7fZOoTGmlYzSmtDelzsZfFwvhfbhMU+NjI?=
 =?us-ascii?Q?jm6clspbBDgGl0RDl0gatgv1zCzUFjH5XwJJbIdtUpackFxVY+ZUr2yKbyFE?=
 =?us-ascii?Q?HU8ezyC9KT5xXeEfrZipa2rV0GZfvMyUv/EwD6JJqutv5e3aS6J8W/XDhh22?=
 =?us-ascii?Q?xB0gP+zUvccfaD9EtS5Da6Y3THM7STWsZaDaRPP1xBznLPJJ9paNgUnrOcCx?=
 =?us-ascii?Q?cu1zyasmWfIrIKkODLcj8NG7yvLEHORG21LcyG5W6tkUx/J+ykF0YTLE1CVd?=
 =?us-ascii?Q?BW8vmz0xynpmF5qYpb3QBTqLsKp55NmIbwxv9vc9mBnMyF5jI+ydw8tJlHUO?=
 =?us-ascii?Q?NxTqlefNbJw4ilpbnzBAzCQCSV990MFNBpB7IWfDorlvHdSFL18+G2s66Z+9?=
 =?us-ascii?Q?TlISNZ/2zHJh+g8JWeS6AWS9UfKRa7oTNUuTIqgbF0pX4zqO43QYUJ2c4n2j?=
 =?us-ascii?Q?ujA76Q1fcZ1jW6+L+BVWc5DsNtSLiU0noci+b88pkhqEqYuu7qDwIdkI4ylz?=
 =?us-ascii?Q?JW8HEbwcmwRLE+GfZvuDt9saBrli0I90vmjvRqWmW0baym6USKziJQPAli7u?=
 =?us-ascii?Q?nk7eXwWpw6F7j0y+qCI51mMWLDdU0w3AKC1ATjkTqMx/OwaCFvIUT5EJponH?=
 =?us-ascii?Q?0j8SvFf+KHINUrm6eWRR5TjRn1ML59/j/ZdnB7AUylneKgm4i/xzwFrC8bHx?=
 =?us-ascii?Q?rVFQnz+8Q+pU8lpz3i/E/YmakmNU5SLDnzXCMGHzdXZJhGi5S/CsqfLsvmRU?=
 =?us-ascii?Q?qJwQBOUrMHGBb35YvXoSy7AV2YCyO6VpSneWPtcBxhaUJlQjBqWNC0a0db1K?=
 =?us-ascii?Q?6NgHUWD0k5BrlwOjGbQe/UgWQ3SzT0dgy/MxlMps4Mx0krI/RkaysKrmC8tj?=
 =?us-ascii?Q?SbWusDZzlj4m91VfsylT+3aczXD6ksYp8j9WDYHTjI99JFrbWWkmyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VZaKifmGyaSeHJvu+lUYmkwkfFuMy7WV0LPbVt4JGu65hqAiykTzN/QGiHwW?=
 =?us-ascii?Q?OKSl+p1z5cOLjEpy7lXSKWe5dzWUHFnsKXqA5TwaXg1M7ipR1A1KAPdAvZpV?=
 =?us-ascii?Q?lfEmNFhKBKfEZM5D50MWbtEEwiOLwGbwsyukCz+wxwlVN9+K54cU+Di1PxQw?=
 =?us-ascii?Q?9N/04nisabmmNGEutKV9ODB81a7qxMc/PgCnOnIKccRt/5aUXeipxKpdXhsR?=
 =?us-ascii?Q?KGQE7taQnZ/AF5fNOdcOZqaMm8rpWRQ1NSeETKACXgauIKvGwrjfbvGIarW5?=
 =?us-ascii?Q?QwKDZ73LgnlD/N3I12L68gUvCFW5hvBTGtcU27zBxQgSUxIPWYTj21lgJaxQ?=
 =?us-ascii?Q?nJqwl5yzyGh5RRoU2moTstt6o3liDXppgB9lEyaTj342ZyK49I2zSCOJdeVK?=
 =?us-ascii?Q?QyIQH+WAQQ/kBc0DfOQWtmW4gMKid3UyDEqcVk4SzMFHoNAYlDOiLCgpb4oG?=
 =?us-ascii?Q?0EA+LMvWwSDqbb4vKtKFmxEMmN4fAC5IniJ8HIofXSN+TQFJBMO0tvAjeqPk?=
 =?us-ascii?Q?m1E3iKaMswfsz0Pe4g9Y8CZtgd8ELk+eUWWFqnK7+Fcc/QfXS286mkbz0hXn?=
 =?us-ascii?Q?hKWm5n4JhuYiJOQ8ew6zqfs/g7KOthaulHRRtVu6cu77773MR0jAcQheT5Dw?=
 =?us-ascii?Q?yIDVsZ3k5d7W4Eh/dnHPGRNhfgj8XD6v2Bx56Tpr/kfQoZ5xgUWMw/flcnBf?=
 =?us-ascii?Q?KKOq9jso9MyAMbZJtT9XfAuLwJ0DvFZOKGC+KBrTCchSPkZPcKgCQm39n2oK?=
 =?us-ascii?Q?D4xg0VW2wQEEhYOoImuaLXZQmKsSDF64PduSjnBHajyHtlzsWXQKq91w8DTE?=
 =?us-ascii?Q?pZzBw1ASBEo+AtuL0SrVMq9h4TE9wsOvCEdN+S8tDM9ken8s2iTzgU5pXg01?=
 =?us-ascii?Q?A6QNH3ocj58NBHEN1sEcfp4WsMHiQl1irFGLNgjFx4uipsB7izQbtj1iLbYh?=
 =?us-ascii?Q?H9L7lflblJxnWBR3yYTQoPT9fmD+ed4aRPEEwaJxv7Zz/OoqiqdJbGp1NLBB?=
 =?us-ascii?Q?s+KVkPPE9nT6SGmiXp6A71UG+gUpdjCZXKzE2rMdqgxsoo+cKF54gMMd2Jar?=
 =?us-ascii?Q?VHArY28uqvB9VsKQaac6bYXM2SDDckiGTvr1LSLNp5+kQudv8EMBi4BBCa90?=
 =?us-ascii?Q?dh6SoJH9FMI8f1NQu1eTG0R6xIxMtqlSN0BIW9sWEHrHbc6xoSzi5c5LZ3uS?=
 =?us-ascii?Q?el5pGsQGy8Bwc5ZV28Bri6eTomgQqVt/osYImPKj5aBvM/Zqn59/wDagig8y?=
 =?us-ascii?Q?P/GGtgRQvQdivXInMT+ngjmWUXBREgEdmbAUCYwLyP18f0sBkNRNkr4xZB4a?=
 =?us-ascii?Q?i3g5il3kHe2NIGgA3GJt+Gf49SFLHKYaHUGBOtRdwgk8zWT2cmGwP5xf82jm?=
 =?us-ascii?Q?uQa1Z7xE+6kcAhOn5gQ3nJ20tNsnTseJ8E4F+L6tcFHRNoz1w/Drl3wyIIZR?=
 =?us-ascii?Q?gUPPqmnG6YgTTLjZO/A/PyIp1DluKBZgjvz8PkCSrccaTetg5UtP7KjdGh++?=
 =?us-ascii?Q?1sNL2ydxnSy9l4Khs0nDvgNCd9MRf6TfK4OaUOiyaijIGpw6J3nZIfd7fOfY?=
 =?us-ascii?Q?NpGVYIGtPjwKI4Kwhm+dzrDqn8vkD3wxAmBobjFx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aaf7ea-1f52-478b-d39a-08dde5aa7d81
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 20:44:17.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr9rULwcP9eofX0sgZaY6qfR0puivQaW6AoXmt32vF59NYxWq7+FAMC3ooSqcGeyY+NVET5OMmzKcM6c8hrnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7729

The information is already documented in
Documentation/devicetree/bindings/arm/cpus.yaml.
Documentation/devicetree/bindings/opp/opp-v1.yaml

Remove the redundant file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/cpufreq/cpufreq-dt.txt           | 61 -------------------
 1 file changed, 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
deleted file mode 100644
index 1d7e49167666e..0000000000000
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-Generic cpufreq driver
-
-It is a generic DT based cpufreq driver for frequency management.  It supports
-both uniprocessor (UP) and symmetric multiprocessor (SMP) systems which share
-clock and voltage across all CPUs.
-
-Both required and optional properties listed below must be defined
-under node /cpus/cpu@0.
-
-Required properties:
-- None
-
-Optional properties:
-- operating-points: Refer to Documentation/devicetree/bindings/opp/opp-v1.yaml for
-  details. OPPs *must* be supplied either via DT, i.e. this property, or
-  populated at runtime.
-- clock-latency: Specify the possible maximum transition latency for clock,
-  in unit of nanoseconds.
-- voltage-tolerance: Specify the CPU voltage tolerance in percentage.
-- #cooling-cells:
-     Please refer to
-     Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml.
-
-Examples:
-
-cpus {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	cpu@0 {
-		compatible = "arm,cortex-a9";
-		reg = <0>;
-		next-level-cache = <&L2>;
-		operating-points = <
-			/* kHz    uV */
-			792000  1100000
-			396000  950000
-			198000  850000
-		>;
-		clock-latency = <61036>; /* two CLK32 periods */
-		#cooling-cells = <2>;
-	};
-
-	cpu@1 {
-		compatible = "arm,cortex-a9";
-		reg = <1>;
-		next-level-cache = <&L2>;
-	};
-
-	cpu@2 {
-		compatible = "arm,cortex-a9";
-		reg = <2>;
-		next-level-cache = <&L2>;
-	};
-
-	cpu@3 {
-		compatible = "arm,cortex-a9";
-		reg = <3>;
-		next-level-cache = <&L2>;
-	};
-};
-- 
2.34.1


