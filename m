Return-Path: <linux-pm+bounces-3848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696E852553
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 02:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5063E1C2326F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 01:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD128F8;
	Tue, 13 Feb 2024 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ceK9oBiX"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2079.outbound.protection.outlook.com [40.107.113.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40423A0;
	Tue, 13 Feb 2024 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783979; cv=fail; b=q1e9I+fongJYFXV++478ybNZGqnPK3ky7bZTcb9UfOZjnWeop/T4LKAa96lZuMU/nBnbvNtANIWcZ1s1OKVv5wYHAbOounSuxEX5BX6dE0kLZWe+f6EXvj9H4rGj2wJiDlFIGOAa318wNblbyljakrYLBWhjRjQgoQZS3yACzd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783979; c=relaxed/simple;
	bh=Ll1krBw3uiYXpuyYKqQpVT4dphvqDdiLbWjG9mTBlBI=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=cjuaAUpgkxfNA9YTDFNCyaTYiXiQTOc8x1UpRmKmMlTBBohTTqVp72Om/e4dDkMPTyR++jwuJvGSXnm4BkQL0T1g92lwZJiLi+EsDk1BfVNbQkwzr/wlkfxIo0tzNuE7zCrnG3ZrFmjGwR4AZ45gDk6nLbawcKDtnpAaYWaR/LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ceK9oBiX; arc=fail smtp.client-ip=40.107.113.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbzXsYorEFHVCrQWQtuThh6ShsIv8M0HcfqFT35WO3hmg030kBUxDCk4SRuEOHcxpYym4V+E75OZa1KofT+KKJD0fpuKHib/ufvGMKZnXFTAXuVtTtCSh7MJDggeyAsehq9o8LgZvo3Bk5Liyb/LCLFZvd9Sm0LmO+iE9ZZI8kuvl4ZeIZD1JmO4zgpnwTMwvofi5CFgIS5Jff8rXSHzwn5q12ESl4zetdUnK2asZZ4sQLAEq++A/tULIYLMwoDF9TbDbSgj+yENnxftT1xExrrzTjfVPWgHyYOPXuXz6seT+QgFzYg2ASSjWbWRBhPwmqM0at2mZ9nyXz3KWYeVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLOlGLUdkdwduQC7iFenRF/7YuOyLM0zHl29myyWImI=;
 b=nh002xIuOjwS58SYbmga731Nphtx885yUZoyut8TzlLzbWpCVxqrpOTk6ShqUe4SwXEciaqs5egejZw+nCyCvMywnaHfSA8TpQO7VKDT3sLPKyQC3rlVUcoOU13wgOmmKYuQ2htSbnMTKw8gKivqoUFCHCgH3vstDqbBndv5JRLM78P9hk/PZCoPekfsweDfDKNNPhCxJEIsJI6f/2jq29pCRvNzYKOBmicOOqgl1YcylVe16rl+gJPe+5ZXJB447QTIrRCyNytMIixoSkPjEKmSOmrDRGvY1Dj2wZks1+JwRhHMn0UCOmYiBgHwj67zy1w+k4BXF7s49b0lcDrnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLOlGLUdkdwduQC7iFenRF/7YuOyLM0zHl29myyWImI=;
 b=ceK9oBiX1Uo+XUWRmb0HIfNL430S6tZUqdkRnTOpd1IU7OLSy4YVyuH9kdzCX/znN6M+qitsaU4g9IHBfT5H7W8chaZsw189gdGS5dQyg9PULJQ7THir5WL5JgY8XmQYOJnxH91J+hF8W8AnZUVtbDa9bfH9NcE8xIrl1HKd2QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 00:26:12 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 00:26:11 +0000
Message-ID: <8734tx8b18.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3] pmdomain: renesas: Adjust the waiting time to cover the worst case
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 13 Feb 2024 00:26:11 +0000
X-ClientProxiedBy: TYAPR01CA0233.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::29) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b242e4-2769-4024-91d7-08dc2c2a6193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SHU9WwG4oorans8Cb/jqyaw7ooDhAQk65Uf4q7q/hcOAw9RktV1PVRPLHM3hCd45mgo0D2rvQaF8ZHaQSuDmckInMovtp05TDdbhJtX/CNViYCml1xxtJFk5KvrijEvhEtKNk31o5spbEBVmiAQqTY1Wz8i6TEMYGKHzVeHJZaEYYDD8AEye6vIbRi6JXE3+eoMbz3JCzm1AG6wncHajJMi7oMU3yFgRy75GPC3fsb2QXDZ7uDkuO45C8nOo47NBHEhFBAsxiiGFNKBSj/NeSdZe4dJNJ+J8noQ/rb7gtt/nm2H3YcnGrcJQ0icz87e03BBx7HhjCJ3NoWZ+U7N8ISYOpE3TVyS6IC3Q0BKNgK/G7A3shcsnV79VCfhVmfkR4gOOj3brcxYgpqSxob/ZMBxPMSp+8aoI6VTY62JNsDI+oGMaQc+UrPhZ5Jp5M2d40isNnu1qcUn7mkIwgadM57lrxnq5sT4hPQ4C6Wpq1zX6z8iAEQK/Gto4ZPV6hnttNS7YmxBDdgn29o6sTkEfWzs2/E5j6CZosevy59Q7NvbFYeXviZtefJTGEOEzJdi0jKPXqjxOzAOfFk/IiAlCIq9e9Ir6yVbP7MoShVFa9OCTwosgbqco2nbLflyfdAiU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(5660300002)(38350700005)(478600001)(6486002)(52116002)(6506007)(6512007)(2616005)(41300700001)(110136005)(26005)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(83380400001)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uWd5x5bg460eITCqUQLvGQ8qdKiMb3/Jt/XK8cRrfK0oRznbuCU8Y6FUtc2?=
 =?us-ascii?Q?FJRVhMUsDiWZS4eqPYkYTnkzTNcD/TiwtRSBuEnDwpv4i1Bb+lVOORk1/L6M?=
 =?us-ascii?Q?P56ejaEAEvXcY1OK3iOuFZd3AB3G7a/x2+XdirdZk8hPOGyqaESzdme/li5Z?=
 =?us-ascii?Q?zlWJtx0PQIzkAEXcFYGjrUDWq8uMdlZRoaqVE5Cdh6kEETOZnjPVIVZW2zV1?=
 =?us-ascii?Q?RciLzfSQIGiHOxjFftLPs2YRVq9gBjXtUSY+qxziAnUtDUgbf+BQ1R4qiRW1?=
 =?us-ascii?Q?gPNpXjbtttDF9E0tpwFA5Ba/hb9XcW8gjWGHQQYLFfRFk8jjUmGom77Xux01?=
 =?us-ascii?Q?SFgfc2DF5Gq5uQJMX6b5JJovcDGasdkVrfgk8FCnlFPbqWIyWMJC+kn0S2mz?=
 =?us-ascii?Q?aQd2OBJHsdI7bf6dbhFQMzN6XjpvitaoyNue2C+lSmBvjlyL6eR91T4aMH43?=
 =?us-ascii?Q?c7ip9II3r5YDoH6rd3H3yl0b2h94e8N2hrCJJWvd2EZfyj5zTOA51zwMQZf4?=
 =?us-ascii?Q?Ss3uP4zQ034njoo/xAb4Ot3VHW9uqv1PfuM58eVkJ1p12mhcGe/d6P+r1gwp?=
 =?us-ascii?Q?5WMqtHec254yKoCIXrqrGCJh+s4QOjUJb88OhKs1/9MhcpdJF9jMQoXQhOca?=
 =?us-ascii?Q?Vox/73L+vuXGKfcg0O4KsVL24nPXRuK+ZJqBj3L8icPbf/UesiRZoLXYOQzw?=
 =?us-ascii?Q?9swupjEA2PjHc5MBcWopWBAWqZwZ/1OL3RooBrkmfUj/6fnxarLpMs9VhnXc?=
 =?us-ascii?Q?g3xke+XJkaGyWYpllVtprVrvTCVeN60NE/orOzLSx2Ipq6N5aV4cBXEkqRIm?=
 =?us-ascii?Q?7uANZZwHTp7QoYymXqpeUGRbFDn6HezOFOaNZ33WxSXwfVvaiOAtQcmnf3/6?=
 =?us-ascii?Q?P6+8a70hXRFn6fK05mJTXLcT/M6Sp1xWWxyGwSH4neWF1pvIb1KPZzIfC/PF?=
 =?us-ascii?Q?2PJxo1ISpZIyZmFdRWRQ18xl/dJdZrOAq5w2KIC0YhuYT0HqZjUP/TUpMV4Q?=
 =?us-ascii?Q?nrtm9MtSStoSgXxHbhvQz2k6l6UdEkJzRq7vreGK1GBqisQzub6DvICemaJ4?=
 =?us-ascii?Q?dlT4RICI5or4lqR73kvjg4UgFxeJ5wB1aLx2h0GxmIUd4eu+wUX01vRohkcL?=
 =?us-ascii?Q?KwLQ9sXIw74/cEJAMGEJ/1g/+l1mZbyqtRFG9CgTYMMg3+QA+PDjeLbws0Wg?=
 =?us-ascii?Q?wkm3J/UYM8WhWZ2wi6eP7LTB5uRblASbj+jyOEBs4fOQPojEeNKR4LR3ZekN?=
 =?us-ascii?Q?yJkLYdcN2RWI3mSXW2bw40xeZQY4jdA5NuIMcZqikUy2GnD2WkDqI7eYnY3S?=
 =?us-ascii?Q?msvjjdhtTq/RAPHSIpj9qO2NHf+9SrRIYZLtRos/ELXS1JpzOSsBcnU3ZES2?=
 =?us-ascii?Q?Q8TAfo/N1mGymkwCjP6Q0T+3QYU7SL+GcTwhhPCJPONZsShcg4S8V7zYDSmn?=
 =?us-ascii?Q?OBSGLL/Kd49vKsX4s2sRpIuEvsftdk8dYd/GpVhDs28YimDMJcPXahPA6gEw?=
 =?us-ascii?Q?qquNEx2IrKnStZppKduO/dUvNCYIkn0gZVaGQBqLPnZhSrjRa7fdIkqNrKkj?=
 =?us-ascii?Q?R6i3/BtN0dOVrEEDW463WTh5S3kwDbwGGtk2vlm26xxDN0VFiDC1SMKkqpTa?=
 =?us-ascii?Q?w+/q8ZDTV+9dVZyztXpjYOk=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b242e4-2769-4024-91d7-08dc2c2a6193
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 00:26:11.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpUG0Vr+fGzMqEVajjxN0Lk0nPqjvsf3O+ngV/V9pSLXzTwwYpuCwDVfQ+dTXLKNOXfBeVGqajigm7DU3iR1BqdQyi+d6ZVYO7/pGPG74WBGfJG0jVDoFp5ujBEXshJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8437

From: Dien Pham <dien.pham.ry@renesas.com>

Description in HWM rev0.51E, 9.4 Usage notes, page 455 tells

	"It takes several hundreds of microseconds to shutting off and
	 resuming power domain. Because actual time required for
	 shutting off and resuming depends on the status of on-board
	 power line, shutoff/resume time is not guaranteed by
	 electrical specification"

Let's assume the safe value of waiting is about 1000us.

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Tho Vu <tho.vu.wh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2 -> v3
	- remove Signed-off-by Geert
	- add    Reviewed-by   Geert

 drivers/pmdomain/renesas/rcar-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index eed47696e825..35d9aa0dfab8 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -45,10 +45,10 @@
 #define PWRER_OFFS		0x14	/* Power Shutoff/Resume Error */
 
 
-#define SYSCSR_TIMEOUT		100
+#define SYSCSR_TIMEOUT		1000
 #define SYSCSR_DELAY_US		1
 
-#define PWRER_RETRIES		100
+#define PWRER_RETRIES		1000
 #define PWRER_DELAY_US		1
 
 #define SYSCISR_TIMEOUT		1000
-- 
2.25.1


