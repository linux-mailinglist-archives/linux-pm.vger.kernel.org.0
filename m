Return-Path: <linux-pm+bounces-23947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4CFA5E979
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 02:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E00174C94
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 01:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3825776;
	Thu, 13 Mar 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QgzKckQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C36FC5;
	Thu, 13 Mar 2025 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829902; cv=fail; b=uqnMWoRr3Q8Xm3V9uXU/gTVBMckpBjK6uslsz2VZ6z+NObzSUeGHI9jL3SiHw4KYFDe8VSG3WoNZVVPxwDdGhy5Da8mvJo2UmqiFH1t1GuSzzHC6ngyA3XEL3JRic3J47wFN8nlADWFH+HQQSXKTuRgK629ystTKMggqw6P9fhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829902; c=relaxed/simple;
	bh=c6+ki3K8SqOAfhZl2iIUw1NmhDcXjBaxZ8eJE2XJTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NIq25/Mct48yfiUTHGdeRDslhdXoEbz7ZYlouvGv+WOhm2GmSYpZGdCnR1E0tjQytT6IrzAKzl6nDOm432FkfoeaN2LYhIyGDG3+67isRt3m/ZtkTj+1YlVnZIFQGhkYZ0td2Q54OstcfbHuUVIQXxXof9gXz3MdrlAQNQHB1bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QgzKckQz; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8Ry1oSv1e0VV8fsX20e42YkzQP7aaZ8NkLDdtnsDTK67OLNm6NnkEzTGNcXaoyz4mMxmzSBPha2b4oRfLBicfii9NlPzZiclZtPL9QlLk76LXZw3xY5Z/9frkeHQBisA3jRD812h+hYoYb/GYTLQo9AmTS2YtkXfl6hXwgCerzPtygCnRTPwqCn4oPSrORmM7fQzEU7HnjVomiusSI7uAew8ME7+Qy5IsjtgOQ6GAM1h6gv52qOk1GRQ8QDR77XeUrnpus/V0tqyGa+zEL2UWR6BvqPow4mSLChNEVQAJMmaZQ+3iLixximf0zaMbyyoofOWEY6F7tIAPHq1WhnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWMZCrvIwrFhyWSDZzWMjcPiMqjm/blQBFyujvYvl3Q=;
 b=osV77OkZptTI1jofrVfWeu4XWQxE40p2eK4q+/oZ2qBmb8nEmwzlUurvgeB7bPsEjKE6GbTzedQtFtVsH8LlN3zqRNS6KDlu4nVanQw7+iRLmB0QR6QV+UhSX0xXmJoR+M2Vb6Zbvhi6b8IaVekUL8im8LH/T43Ncr06t4ZMesq8HGMzqzmLsnqkARcX4PR0CSsFQHZM+lL/g9eQDxM1BMm7tdgmGtaa6XxQ4pQfPfGwQEXdtF3KjtzN9zFb/JMJ+MWRBxOHJVV7DEWL8G4D+Uv7OYZMwUnPpBYaqrLDXuYkpsCdTZdExB1yJCVkiLuyqoqV5fHNiy0j+RczODgCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWMZCrvIwrFhyWSDZzWMjcPiMqjm/blQBFyujvYvl3Q=;
 b=QgzKckQzf/zI23fiUaRPN67aERhaU2a2vbp9ku4j1c/cbhrgSiDKMA9MaWKAvG0g+ExYj9WW3kNCkCRXJvHHw30nns4+wNCkhe/huavd38Mcmf7KhiwfcNfby/NRLpKcr5qz/tekxa4OljfyehL8E72enEPgw1UO6lGrCANc6SOHc/rTrvavKpdwDmuwQqBY8D+fe9wCpf++MhPNQGlGL2YQSorrwj74u7gqcWxY5pI49ZuRmKZ8cLVwQn+otxqNMPwUctamHTF+kxWLlViObgskQ5iM9wlhIgfEdepsnQNBjlId9TEkHqvncur9mEIjh5ngckV54+5hb5unt6z6bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DUZPR04MB9793.eurprd04.prod.outlook.com (2603:10a6:10:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 01:38:17 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 01:38:17 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	sudeep.holla@arm.com,
	viresh.kumar@linaro.org,
	ilia.lin@kernel.org,
	tiny.windzz@gmail.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3] cpufreq: Init cpufreq only for present CPUs
Date: Thu, 13 Mar 2025 09:39:28 +0800
Message-Id: <20250313013928.529926-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|DUZPR04MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e31911-6151-49d3-c45b-08dd61cfba83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fsEiYkjVn4JF/tQva3ieontM7SlGch45diaFGtmdrkVjhF/Bh8iQYyWMdKCJ?=
 =?us-ascii?Q?ZOORyvA9fIbCtx/kyq3luZzT1XlyQMP7ogBnCcHmHivMMMi8UqjZiGPOTXR3?=
 =?us-ascii?Q?4CNrcpQXThvZztWh1IWQhiFPPjhTUFVG48ob3606b8OgM3Wbz1/LDJKBV7Sc?=
 =?us-ascii?Q?wkZZZdAuF3+jeByt1ksa8xhiI4DnP+ZZcSgpJVMq8aqk3kKq6zmYYlBUT2Nk?=
 =?us-ascii?Q?gIOHmvYxV7PYvqnXn5Nmc9W5hl1ubLmeaCo6K6ObR5ql1+F3Yf/TyBStr1/D?=
 =?us-ascii?Q?rcEnhSKfhTwrFZmGwFMiualsEZu8n+UhR3atWd4aL+fygCaeLrPfkpphF7qT?=
 =?us-ascii?Q?i+IF5QKHsjUqlILYslP8lPmS5uaPhdLRCYtz437ZraaBxN3LMqK+93HvJucP?=
 =?us-ascii?Q?Qd/qKkwaXbujP/lu9eLaESA8vPyjqpkXgY5/etz5Zl5ACjCtgwuXmVKfD9qe?=
 =?us-ascii?Q?HorbDlBuJ/9jdJdRyKM7SrvbYjVyHm93CuK2Eheyt+6lCHF8HQvso0DJ4M5S?=
 =?us-ascii?Q?xU5ACgXEQynsYxAgE9IC5aXMhFXVmwFsrEy9Cbz5Wug2cq24z0RC7mt/DDlg?=
 =?us-ascii?Q?rbfARqM4aLuy4YaUwVW11UEvGphbptqSNcKcEw2nC+NXHEt6rPSgvatWRT8Q?=
 =?us-ascii?Q?bfDPgmypw0miXdUSa0SS72pzcSpMoESRnm3FSK05Db4gFpI/lJmsBGRQMJiF?=
 =?us-ascii?Q?uTx3E3yjvToxPg6fw1z97BnpF5iCDUwV4pFuBjfP6vEh7AOlYEC0aORFmM6n?=
 =?us-ascii?Q?yIQJ8kKks6bE23uY8N1lcUbCsK8CoArw/YJGBzhJTMPd84VB9FYTOR8rnlip?=
 =?us-ascii?Q?jRsWO05BGtAm4fK/A6kJvIHf35LCOe3ATIkktSAuZ1iRw5CRgCKBYc3XqW6+?=
 =?us-ascii?Q?MFo5h28oVBHPxBLABdk8raLfj+qw8Ar8ZFJqMNr0Vvil5uAuKclgT8Zn2vc8?=
 =?us-ascii?Q?py/Xh16rvZNip242nC8/MIpQH5bNTuRnjbzLQud6UyYAwKLm6RiXW2uJe3kD?=
 =?us-ascii?Q?hBVa6xI3YRx4HkWj+yqAUE9SU/7w4N7WLXIBr2/jb8mbPCwekMN2KT1Y4lFn?=
 =?us-ascii?Q?2mqvRH7xaSrfZDBgymMrQIXLvYx9N6WsrD/3AHul8ileY1cL7SxGkUoPyS4V?=
 =?us-ascii?Q?8QxnyDdTrRZiaHuys3D30DpBYdwAC6UDwi4o3/9+ZYXdK6ojzER+eA80ejXS?=
 =?us-ascii?Q?OF2YbRGfcbVtcuynhGdw5k/J4P8NRewZGM2amOn/ciRXWV3fD0N3vt3brTDB?=
 =?us-ascii?Q?w9TbKZJjHiZlqrlPrylGNOzyCZ+2MKsWZpHtvk31Es9ZdFp3mv3RGfXQAALj?=
 =?us-ascii?Q?tBynl1Vrd9E1Qk0m71JOw5yefmKL+8su3OhrykpwoxzxBfww3/0hlE8M8R2i?=
 =?us-ascii?Q?qEmKjs/wgtr5tonKRgcemFMNG90gNQAd0gx1MTV3UTDG5eerB9OTmavAp7dX?=
 =?us-ascii?Q?j4s4OEcZ7AmekYg/bZt/Op9YBXfjy003JTOIpwoS087gz8qdiRhY3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6215pqDp9rdzyX9YfoPKRPQU7OzIuEbVCnJGDb7QRVx/1z0HhSSeJW0fLmg?=
 =?us-ascii?Q?qE124apToYAw/QGwrfD4dznrqsjScHFdctINWOWExQBF1lVhVQBngerT3465?=
 =?us-ascii?Q?nKJ033qVxnTMphjx0IiDlyf4T0WAc0qu0DCmE6rEZ3KALC6eSNN897zEbGLq?=
 =?us-ascii?Q?AGtMIXIDhopXzrhSJ6e04+9bY+zepwZkWTYhsmzTWKYjImGvcVltDHDxta3i?=
 =?us-ascii?Q?0uf2k/fNafsEg6o8B9/TYxIuVuE2bIlJxfk0p8Y2f9detRgakhz7BOwBBDT+?=
 =?us-ascii?Q?2dh6vP+jGN8uvTasVR+pIhu3pylbdzWPiYl/82NFsEkF9x+Jqh+5liTT68Zr?=
 =?us-ascii?Q?dkOI0ilx3BoR7ONJWK+z4mkbEF28z3yHtvcK1t4YQyTtnfPMuxeJXX5f4NQ9?=
 =?us-ascii?Q?PXtsku5xUVkXrWA8a7hUavCc7/UvOjEtqfb1EpqE2kJzHXge8I1JQd4LQTod?=
 =?us-ascii?Q?9lBd1WKsCMrnUE4nPkNEavGeUrJNE5teTx+rmkZicvnWcRJug4g51ZsLAb4V?=
 =?us-ascii?Q?XPGwmcr9RHeKqZTBQ9TaYwNIFQK1Vx/ir6VtvaL8y7KxvjDCCT+tVQF4+MqR?=
 =?us-ascii?Q?+oIF2dIEuLW0mHbl/oUCUSstOAgynG6WFWfOdri1FSsjgpIMCnR0v4jszI6R?=
 =?us-ascii?Q?74/dC1mzBh4oqF61sn7g3P1FDGXgIygMWj3RXASF9RWdEPUcBrQyvs3nAzbw?=
 =?us-ascii?Q?410doQfF9G94woFYJydTND2XS38a7Nz2nENsKk1zH8UQQEK7OxZHfxrFpXPE?=
 =?us-ascii?Q?K4n/ekk8/l6sMCBBU+xAxJFuPB83ZtCh7Yxq/5OF/ujzKF6xBqx1Tx0BaMn2?=
 =?us-ascii?Q?qXTeuql+BVd/mSO/40PMOlmVvIyfUI5UEly+rgcwERc3uG9qyYvWRNTRUKPM?=
 =?us-ascii?Q?BYbUHjKqi/Z2vsAitCcIZ3d27enCSVfIiN87vNQbDcAnwzvDjtxImQGgZPQ4?=
 =?us-ascii?Q?5WCucR3XPM8PghU6Ff6dNplKoSKEq2OeiaIvD6n6d3MSZ4bwEriW1plqDdub?=
 =?us-ascii?Q?vLn1OOuXacV9ABh0gPqsUk7LCtrJTR5pIciODEZWPrsFFNptBpQQW32JZ4+0?=
 =?us-ascii?Q?uHa924v87QHoANYbq4s2CNjC0hm40/01O5pYwfrFdRkE+QvavyfpbPi1286p?=
 =?us-ascii?Q?AeO4KrZmXz1AYPzyecAIgwBruFLjFaBGxwM30AWddPOe6YnRgxHQgwcxRLLz?=
 =?us-ascii?Q?AOihtMVhVJl2Byql2NNnDfXthPTyGMK/RFneZwk5alXjruxhnBLH0ZfJJBwF?=
 =?us-ascii?Q?q1de5wLQw14aDnHJmR/7mbWz/IrD7N6iPcnTyGBbpUe4a+pWRuzbfk+wv2NA?=
 =?us-ascii?Q?6M3Y9hTBQF9A8I44dOouh0kN2mbxL2wEpskwJ2oxjJS72kumTZFPxbzHFyyC?=
 =?us-ascii?Q?1LLURoZoFCQvikH3ed2HSrDtl/Y/yOr0lxjZ0a/5jwJ1ZQMR5JuHTAUw0pEH?=
 =?us-ascii?Q?QcECievT0nS6ikFZm4X0EmDa9M4WmUmKLxoZDqPNDQHZg7q123P+unL2hKtQ?=
 =?us-ascii?Q?5/rSxqKDvQiVDocx2UEMax57PJIgrJvhe0Xe0RrDOjHeaEB2VdqF2K7DyMj/?=
 =?us-ascii?Q?64ZDc1KFxWCSZroR2z3Uf9ThOlC1ux1oziSe/b2n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e31911-6151-49d3-c45b-08dd61cfba83
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 01:38:17.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNf2rmt3D2vHVaFNgnweiDfwZ62OxM+Molc3WqOAX0EAZ2X8xZRZbF/XrcuDGBapbB0WgTOsvhLmG+NE8fTgpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9793

for_each_possible_cpu() is currently used to initialize cpufreq.
However, in cpu_dev_register_generic(), for_each_present_cpu()
is used to register CPU devices which means the CPU devices are
only registered for present CPUs and not all possible CPUs.

With nosmp or maxcpus=0, only the boot CPU is present, lead
to the cpufreq probe failure or defer probe due to no cpu device
available for not present CPUs.

Change for_each_possible_cpu() to for_each_present_cpu() in the
above cpufreq drivers to ensure it only registers cpufreq for
CPUs that are actually present.

Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v3 changes:
  - refine the changlog to drop the changed driver list.

 - v2 changes:
  - Add changes for armada-8k-cpufreq, mvebu-cpfureq, qcome-cpufreq-hw,
    scmi-cpufreq, scpi-cpufreq, virtual-cpufreq.
---
 drivers/cpufreq/armada-8k-cpufreq.c    | 2 +-
 drivers/cpufreq/cpufreq-dt.c           | 2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
 drivers/cpufreq/mediatek-cpufreq.c     | 2 +-
 drivers/cpufreq/mvebu-cpufreq.c        | 2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 8 ++++----
 drivers/cpufreq/scmi-cpufreq.c         | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 +++---
 drivers/cpufreq/virtual-cpufreq.c      | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 7a979db81f09..5a3545bd0d8d 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -47,7 +47,7 @@ static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev;
 		struct clk *clk;
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 778916f89a51..e80dd982a3e2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -283,7 +283,7 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	int ret, cpu;
 
 	/* Request resources early so we can return in case of -EPROBE_DEFER */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = dt_cpufreq_early_init(&pdev->dev, cpu);
 		if (ret)
 			goto err;
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index aa209f5527dc..74f1b4c796e4 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -303,7 +303,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	struct regulator *cpu_reg;
 
 	/* Make sure that all CPU supplies are available before proceeding. */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 2656b88db378..f3f02c4b6888 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -631,7 +631,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "failed to get mtk cpufreq platform data\n");
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
 		if (info)
 			continue;
diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index 7f3cfe668f30..2aad4c04673c 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -56,7 +56,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 	 * it), and registers the clock notifier that will take care
 	 * of doing the PMSU part of a frequency transition.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev;
 		struct clk *clk;
 		int ret;
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4b3b3dbc7d38..8422704a3b10 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -306,7 +306,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	struct of_phandle_args args;
 	int cpu, ret;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_np = of_cpu_device_node_get(cpu);
 		if (!cpu_np)
 			continue;
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..54f8117103c8 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -489,7 +489,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		nvmem_cell_put(speedbin_nvmem);
 	}
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -543,7 +543,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -557,7 +557,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -568,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
 	unsigned int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ff2897789797..c310aeebc8f3 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -104,7 +104,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
 	int cpu, tdomain;
 	struct device *tcpu_dev;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 048dc43a9997..17cda84f00df 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -65,7 +65,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	if (domain < 0)
 		return domain;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
 
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 17d6a149f580..47d6840b3489 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -262,7 +262,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	snprintf(name, sizeof(name), "speed%d", speed);
 	config.prop_name = name;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev = get_cpu_device(cpu);
 
 		if (!cpu_dev) {
@@ -288,7 +288,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	pr_err("Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 	kfree(opp_tokens);
 
@@ -302,7 +302,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 
 	kfree(opp_tokens);
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
index 45becb92aa4a..7dd1b0c263c7 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -138,7 +138,7 @@ static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy)
 	cur_perf_domain = readl_relaxed(base + policy->cpu *
 					PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			continue;
-- 
2.34.1


