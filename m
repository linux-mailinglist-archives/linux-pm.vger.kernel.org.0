Return-Path: <linux-pm+bounces-3670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B306284EE10
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 00:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D762A1C230F0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5345026E;
	Thu,  8 Feb 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bDGNcKlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072.outbound.protection.outlook.com [40.107.113.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD41E883;
	Thu,  8 Feb 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436343; cv=fail; b=h3rbSLfFHnxzgCl5RknhZ/wFYb/4UhsFLpYn1yx65azO0VFETletVluuNtNpMiJ+oOjQ78LS850l5n1NeBzc5zAvddCSE9mLsBv+TcgGGqrtTIeXvBpmvcykui+mgXz3JKcbVlVj7DvdE+nb2k1MEjCouatL4sTE0+O731HyUOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436343; c=relaxed/simple;
	bh=snG6nwgkxnsXuRt4idSB2r0PrF/ndlUH9dRqAI/Mlk0=;
	h=Message-ID:To:Cc:From:Subject:Content-Type:Date:MIME-Version; b=b2TK82Mi5YlJevlPztyIE8wblswSZ2Zq4DnJ/4DNrE6gP6l6sgBrD/JA2cVIRZw7OPevjommJof/rMqR20PwHhJtIUsZMR15Z+h9PCMkwjsf9fF9qqiAXbGtHWttzByrt43MBH1vKjYvlrTps+3B6RIoyjqI6XntnzMeLgH0/VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bDGNcKlh; arc=fail smtp.client-ip=40.107.113.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpK2mJJ2gV7Ie/oIM3OecgnbArsj8i83aNtc6itrb5MhlDZD37s1L4ATYkitsHqqg7l1Mc5Hl7so9PWH3Opx89hUSb3GQkweSXFlGi64DcX6TVgHgoR9IQtb1/jW5nvCTbdg1hrM3G4mlj8CKMcuWvEwAVqtWy/cibPGAK5pyaj5+cA7h+NdTcwniwJG0TVQdmM392b7SbmTMchwZ54W96LntJF0gqykW44mKxUKT+UJsmZcKr5DXo9CKcbbjY0vzygbShYxCvh4RgeGHACY2XYorI12XEP/ZZDlz1keFCGZz43MaFMRgw5GsuNy5gXwT9irGlwwW5fZpoeq30ozpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk92tElGuOYr4De0L467kAKft7YXZ05RfQXt0zFgm3I=;
 b=eHDO0wk2dyeGgWQH/6yxJTdEqvJXgf4Xgz5pOLql13kM6UoUJUDc0YXC79Xqhn9Hh7eCh/1WU+MvB+XdT+vKIDHKTiOFz0MySD7oyY1iBSgTumxlKgoIfY50QD1TumBeccFci8gEGEaSoGD8A4944fJHnUzeKxVhAhX4KwFyTP1VHX2iwtKsBfnP65hoNNMvrGDwN0/vv34/VKZ9aNDwb37FBPRihKngjrXiUhPprH5h7jmkCavbW+NVlTfNno3fCBZEsP63N44gZz+/pA73f0THUvb3FV2K1MIxZhNi2o4KrhJxpDcdFFvb3LKNEDc/H2/FAvh/82J82SKTLwjyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk92tElGuOYr4De0L467kAKft7YXZ05RfQXt0zFgm3I=;
 b=bDGNcKlhSFoAj/P4bWoKWvpcTWaGVF6K8vx8lf8XMZRVB3ilbYFPa8uOAihI+JidRlt6kkBsXNs/5kNxZFo9d0trynwRFhwlnH2GOE0cFaOz3ZpvKuvrsVeR/xAPEm8+6pn9X907njM7/jCfJobMCezcN0xG8hnn8vPykdcwpJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB10292.jpnprd01.prod.outlook.com
 (2603:1096:400:1e8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Thu, 8 Feb
 2024 23:52:17 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8%6]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 23:52:17 +0000
Message-ID: <87v86ya4zy.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Dien Pham <dien.pham.ry@rvc.renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] pmdomain: renesas: Adjust the waiting time to cover the worst case
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 8 Feb 2024 23:52:17 +0000
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB10292:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c592a4-25bc-42ee-e947-08dc2900fb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+R4M9k6sbUIgV7wb2r4PixhcCVJlv7Uc8w2/97d/QkbdFxnKvvsSeEC8OzklpudM1bWRZtkOb33SmbFUKU8jXUGrZYiSziuT4JM3F14kQiSTrigF/IvY7E66ffJNH90UeHgs75FbkS/z4/Pz5Vj6fyrrefVi7Xlwx5t/gaCKalvf8cqA3Vy345uJNyT9zelUB6Run68jhKOiuBap6s+Gn3WcN4n0v0lUnsyfh+Bf82aAjx1+w4B/MWq4woyU5rz1qhOZdf3TN4HHPytSqJ7Mb7xL1S98Lkio84KVKNECj82Efd/KT8tzuot6VdEiU4V1R/n+zp7i0GtND3iup3DNuc2d7lSgLvzW5dXr+deplRz1LUNiLIbUDnCFPHkh1X0J+Hl7VY56zqpl9jtatSuZm/RRY3KHgLK6RsXFuDY+JaTBxtQBuQNhiwJF/Mnjw+h931EgiHVnhmYtPrYlN73tUtU5diQ4Z5ZQzIq+xpmGGDjP45FL7sR7hVJn+951DMzyb+H0T0WyTMIY6ghdv7g73jADVMUryzThL/5dJhXZ5NNdsAXZOBj0tb08fkp09TZo2nxEWv/PpEs/dB8iJveW/+1J5EiSA6H0IW+bOxkkdN3+zxN28SeYAgSTlLATChTw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(41300700001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(86362001)(316002)(66476007)(66556008)(478600001)(110136005)(66946007)(6486002)(38350700005)(83380400001)(38100700002)(26005)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+IMcV/CnOn8ic8PXfyp7msd5gkbrh025NIg5hoyyz29yI6deURr2HI+9zIiw?=
 =?us-ascii?Q?3tQq8kCoueTAnEW+nvCDUWZBhRMeEbD8p11cEIVpulWEMEH8CGvxI2K7UcuP?=
 =?us-ascii?Q?GTDzapKkUN0drDoC/dHlN4vh1hS0+XFi67sRuiAL6KkZX6lFtzW794OdLym0?=
 =?us-ascii?Q?1MA8fKaopSNxI21SbL7/E/hJ4gi6pIo5q5HmeyO4t4HkoC7pPkW8l8ZwOEM8?=
 =?us-ascii?Q?9pxTTVmjmLn0Zft8/Z5csJYkknXSwMV38WVKQ9VM+dCZBa9/oHIYWkCjYshm?=
 =?us-ascii?Q?XCtOu/XBfhkJBOOWLnU8aPY9gjnU8nO1DYESDeF4dGjKry5SUMLVIoGe6x3u?=
 =?us-ascii?Q?ckcgdHPy4YLeOWwyX9CFnfNgXFOL/FTzLOxv7iDPYMhnhUTvdJfxksUt0s1D?=
 =?us-ascii?Q?5CNWikQ7hj4fCVeA88uz0oiv62KLfcu1XNH1sM/4in88R6MRciSHYBJGTGg2?=
 =?us-ascii?Q?nGTxuI8l3W564Oy/0UvFjwVQki4JUOqk7H5o1s3OURM8JOy6t9ukpOrhH0I1?=
 =?us-ascii?Q?4xIA1agPFUM+4kwiPKbG9UlgaX8pJn6L8bwu+ocjX9dbZSlQfMH++vKfuXQ/?=
 =?us-ascii?Q?nKj/6+LQ9xrIs9U/+O5+vtrr4G/Eu3+xckw74Ca0nmH1euCvpgf7Ym7zCDTb?=
 =?us-ascii?Q?4yxYqO1tfViiMOuQU2he19BHHoGK0LB9Jm2lkvizI/zKinhQnLTL8AFygfaG?=
 =?us-ascii?Q?iA7UaFjptcSLQxDAKgA+5q5o9TqqCUkW6SUMQ89WmQt9a2hH94VWgKsV36JT?=
 =?us-ascii?Q?I9KTBizomwVtJ7cyy8TkAFgwXH7xafblMk3NQ30VU1lRx6/NhbMB3aRfWNi2?=
 =?us-ascii?Q?77jnhQJFbjEHF4SFKBQ5eFbeYNSgk/Do6b/dShtVyCut1d4KU3mSlHjeu3fU?=
 =?us-ascii?Q?t79kgvtf0WaS+NdAwGFf4t2IbLjUALxDT0fgRF3sN68p9UmKFUsXgjWlJsbu?=
 =?us-ascii?Q?UauofVhXhA97NThyRw2qN7nf8Ur5vb0rLRnKDxN3dLQ3jKiW/40btrd27nmx?=
 =?us-ascii?Q?1aB6sSonbkjkvKfgInFFHdkC2l9qAdr2SPH0iObCuR59DxqXZ4NATR4a5mt6?=
 =?us-ascii?Q?aeCOop+GzVjhClPuBxPGo99XI665OOzSPMeIrQnXpgVtdkHQpo6eZUlWuO2e?=
 =?us-ascii?Q?dKp+9BW33EPW/5K6HAVn6C1zpNUScmu0UA0/tc5WEG+PI8BSBcWDLuBhj4pq?=
 =?us-ascii?Q?Ms7zadKUlO+hvKupSA6QKzb0C0t1l7/jTy4A53N2nsDNW/MVeHsPvjqInGLG?=
 =?us-ascii?Q?7pQpEHFwqSjF6OgoIvlySbk5xpJExJtvBMlWVmVpZK+qQ5ulsm53LysROWjP?=
 =?us-ascii?Q?Y+PWDQEvVBpmYkghpAyNnyQb7CA8F1NwY/ctA6v+sO6LRTAhbofzerdRbzOl?=
 =?us-ascii?Q?n9UW02hFnViQlHnAk9ndPc/zJsBSDcDOQzlUKFAvPNjSqnvCsBawZ/njTu1k?=
 =?us-ascii?Q?8brDVqDr39K/4eHKZE3RBULzQaRCMgy/cCboiLuAXh3fi9S4SQ3uTGvuNSSd?=
 =?us-ascii?Q?WbjH92CKFZQNpokxPLr+FRHAUQys9BiQSbwt2RVQ+p0wZTxzQQR+74gcruAn?=
 =?us-ascii?Q?8jx0mZ8u7fXf7Ghcd7rrMOHhQDSNVekHep59dLCkB1oO+izuhTjii2faVfOn?=
 =?us-ascii?Q?4Bj2s19IjLFWgzTEfq4o+og=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c592a4-25bc-42ee-e947-08dc2900fb7f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 23:52:17.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWwpMg2KHAkSYavs1yZ75OZZFiZC7BoS1jS4o3rFGYOgByiH6Hd8P4XV1lVzTS44FvdbC8+LEGzodpgrQ0/1PN00efbLFw+mHYJxsyELMUL3wjzz9wk3sHNzg8gFJ/3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10292

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

Description in HWM rev0.51E, 9.4 Usage notes, page 455 tells

	"It takes several hundreds of microseconds to shutting off and
	 resuming power domain. Because actual time required for
	 shutting off and resuming depends on the status of on-board
	 power line, shutoff/resume time is not guaranteed by
	 electrical specification"

Let's assume the safe value of waiting is about 1000us.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Tho Vu <tho.vu.wh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
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


