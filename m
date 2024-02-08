Return-Path: <linux-pm+bounces-3671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467D84EE1B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0AA1F236E0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 23:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A35101E;
	Thu,  8 Feb 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DpS2fBYF"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2083.outbound.protection.outlook.com [40.107.113.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112751005;
	Thu,  8 Feb 2024 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436604; cv=fail; b=bn4GqpXNNXAYcHYmQAmjnILM3bKVGh22im4i71VXmyXnJhIRWEMSeKuF+KOj4SUASsOwZ/pK/P/kApSZcEtVWQNAhzVJQuN16gN31yQrbJ4Bd3Tibe34q+waKhEwtvtuFSIVrzts8eTiu/pZonoRX0AgsOg1RaJ648Qz8zK8bJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436604; c=relaxed/simple;
	bh=0kqriyGbSNGz07g4dq0M5x63QVvZ0sdQxXTF619MBTE=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:Date:MIME-Version; b=HUDCCi/522qCx61KR0TWCvveJnMbRAu6jQZ9SIdJKPu/MjpdCfAx3E1IxVg8ZcAJK/PCXIHChLfajcF3LuJaoqRcrjQ/n+JNOFujYcbMzYEPVCdQb14WC2IV3Lyvd0TOxeV9+pZS6GNsIrwJbOwd4JddVpyqNpfxLm+dnveBb/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DpS2fBYF; arc=fail smtp.client-ip=40.107.113.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/16bEZUYhJpIqpNo+mccVwo7yZED6taTJn59kx5Ry8Uwj+ZiFFhVFu051AF1nWcVyLBMOZ6zmw6qqyYSUYuyUXrAPrmpDHg96drIqpn1N5KUoLQo7PEEWPtb5cwlNzJQ7x86GHSP3aZEHhtdUOr4ay4JI4xp5EstB3Ux3ZplyBGcKoByGniFgY7aql8ZoGVdsIdnMcSxcA7Z6AUspqfCOtdAVy2hXAOQHxWJIC7Y0XgPyNh6QaVDJ7Gl4ygOBR3tnIuASsAXMpxpoOBFSujDuANSM/G0PPy0LvTD0+lkA/zsV14Nhc8Gs/l6xVZ82HWMmUhj62CG5+m+dYLCkR81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nCavvdNfxzHy6n3QYq/Uglur3vTtwZmJ+6gJ7a+S/E=;
 b=dBIyrkkXyqiQ28+lWbbt4lYjVmZ6pIsdF92uJ8UDLaBIdt7KXpDFrko4svcKzXxp+DPgyANnMcDVAdsHQ8F1ziYv0FhuQg9pStMylt84VAoovmogmVVIkQ02wBvQdiZ98JvGV5QA9wSV8v0Xy79pyhUNlRdPT4ah0LkMhk6VygkC8V+3bfRJv9XP1LRa3bY1dnoH4Bcj+0mQPVvrsYGyzbX7sHU+pPLaqKuHQS+agQctrr/Xp2HHXhSUAxpv5CFjZyeps7Vs1GeQaHjYbZrmcK334VvH1rxWOxCyXpZnwTV/YIjqJlQPN6TeynOyEqLU+l/rB/wTLwfr9q13rw2HQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nCavvdNfxzHy6n3QYq/Uglur3vTtwZmJ+6gJ7a+S/E=;
 b=DpS2fBYFkkBRECoTiSVnLgic/MeYGqrdyEWijRNBHcnlfTfA1G//lTTTqjLGNxITH0MVfo9pneeOTMRaTF7Peg/pge03/4cdsGJnXVQqgEtf5oOpSdvauHUIGci2JsjW0mFaEb3k8BZfnsUxI3Q0y8S3GBgEENVdXCQNsbZqFk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYYPR01MB7829.jpnprd01.prod.outlook.com
 (2603:1096:400:117::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 23:56:38 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8%6]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 23:56:38 +0000
Message-ID: <87sf22a4sp.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Dien Pham <dien.pham.ry@renesas.com>
Subject: [PATCH v2] pmdomain: renesas: Adjust the waiting time to cover the worst case
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 8 Feb 2024 23:56:38 +0000
X-ClientProxiedBy: TYAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:404:15::29) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYYPR01MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 81577042-cfdd-48f8-b2b6-08dc290196fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUZDF9CWmWRBxj6osXgrcxbZdFBf0R3HItB/G75+GoXgqDTHG8bIczhReRf1R/n5s3+9oTnscrGv7iNS6e0Wo9SS3Gfy8LbJBZFpzpFp67iMzQR7pj4EyoVHVRIf+/lYO0eeRr5jniQ2UtsUBBtPlenNw6R4Mbn/Wje2RnAeo5DTjI4T10wjKqPS65AnrqrE5kt1LZmwmm0wlRwO7mdi4hlNeVhQhyNrzpsKR0EDp8BJkp9n7GIsPKdAMnEK7X6fIqFszV8kGdo6UrPrC2hw08zU0I8eMJXS4kYqK5fwRICJv5bAEu23Il0XqDW0J26KnjYj7mH0R14BL7zV4x3ZifGWrVWRoNxfNo+s5XoUO1sUbDSlWTuEa1OwFtQ8DGoemtblK2zDb7MlJCpz3jiLCEOaWcOnLag+ex/mpwQor/uUBkgXjria89w8uR95GsoGac0szl93xdg91hPtuFvkHLwXbffYvnKmYtsXNLRcBaeuCyx9yGNdvJiylNWrzMNy9AKUpy5TID6a1woNcL5ySr+TzUxfAhiAXwlFjL6p7SnGUTyMpEh65EAL1hwvCKtXjPuggf6oXKK+Am4mcAkSqJFr/AJ2kFSkU3idTBPGrdq2rQzGun4dL9Hui9XEieiA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38350700005)(36756003)(110136005)(316002)(86362001)(2906002)(4326008)(66946007)(66476007)(478600001)(6512007)(6486002)(5660300002)(6506007)(52116002)(38100700002)(66556008)(2616005)(107886003)(8676002)(8936002)(26005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wtpyu9p7w7ZovlIHaUGEuTskvJK5FbfwS7EojQgXdMooQ8udqC2jzRlXIdBf?=
 =?us-ascii?Q?roqJOiWtJZgi5InlrYeSctXtoa/h1Sr3Hjaj7BgC7J5ZWtzRzOGm5ZmtTCOK?=
 =?us-ascii?Q?T9ug7JmuFVdV7unQAvD53g6B0ZdCUTw0xJ+rIRRRGMhPBGMMV97te6gCb1af?=
 =?us-ascii?Q?cV+t6GOULUYkYMm+yeZSNz0Mp/Rr16F+A0BfzSmiB7bqrXEK+ze5wn5jOXRO?=
 =?us-ascii?Q?1VBTTzObY2wLprx2DPbrKOXOkV+5TvcYlvHPeRdJJfLssVPaRKxQmvpOSXf4?=
 =?us-ascii?Q?okglbxgmCgK3SLpMARowpsiDNh5sB+ShQzo6Tj8A5e1ozzw3lX/5zGNu5lpW?=
 =?us-ascii?Q?Ylr1NGGX6jaSyyZPL87/mxD+hKfF364UQoyytvuboLw6hoF7hazWC6pn1vbY?=
 =?us-ascii?Q?CuRXYl467qdL5PldIQt22vMRrBWy1UtUaNSg2yPRakm//hlw6CiAee6h9+vU?=
 =?us-ascii?Q?BkDq8qbERJqcWUbcZOjbVKZIEvqOlflaGaqNFhbAK5pQvI3neI2KRUGZikTG?=
 =?us-ascii?Q?39I1jOHVTBXOn7eSbHuEWye7rTq8XxRwMIcWpYyk65UdsPqBV58FUrtIt20z?=
 =?us-ascii?Q?ZsgUuhaJhBiSy2ecmsg3ufUdSSwy01pwsEYbyMoSNQU4lYOCwxn0gtyXGTt+?=
 =?us-ascii?Q?jRp7L7Of5NXni4cWflgdyIVPSGQhk9cg2Zq/Qj177PyTwJ2dpzxafImyLa/T?=
 =?us-ascii?Q?d4ntiZfT1o5gxnCypkM31xZVK1uSy8Cv3bCnEoAT6hY1oEiDVgy+QTXORoq+?=
 =?us-ascii?Q?USPAXQ6q29bvcY4C/0n3NCWSE2hE2Y8fiajggBSkiU6aYVlf7XWymxAOYTHZ?=
 =?us-ascii?Q?sMRTSvt5rdKKzlcUcDocBlHYe6pv8cPajIbLklTtVXNwK3VlXojAgmPWopkh?=
 =?us-ascii?Q?C+MdtEqdVXCVTwL+J44rBVWIDm3pa4feQqMmDQeld961UXAuhwKGt1mFEfty?=
 =?us-ascii?Q?E3Sv2ec56pydLgPcNxIR2MyxIznZradOCM8+S8cc4/uSlWubx3s1swCNhh26?=
 =?us-ascii?Q?dXtEGv8P1tRab1JMhs10/u5ZmhfydXm1wBUg6xCW+SiVfb4xGG/ic7wr28v1?=
 =?us-ascii?Q?mpqg5YPJwq1QuMcbmf8t1jcSf3/RYXn/xxZsyF28tqQT6khUgagGGIZcNUA1?=
 =?us-ascii?Q?kI5pYBKSNEgc7rMy+xfqNPn43zdBvOYrx/eVMTezvjl0FzHETc5oPKFwGDHO?=
 =?us-ascii?Q?5hxehFfbaD8XDjNLTHy/INo3aHXwmKqcqCITb2uHcEvJ+s/aoW2xbRM959Kc?=
 =?us-ascii?Q?nMwJB3sR95p1/K6BXxWkVQ7yzTeJ2Xo2V5nRfZGsMZYeRfMJfbHdb0Xf9RTw?=
 =?us-ascii?Q?GHKd80Hm7BCgZ//X9bloCNzsP41ha62dyQRqbThfBAnzZLls6SEZh8vbhMKt?=
 =?us-ascii?Q?p1NUIP8DfnrQNv0KS1aVvYFe9zd/5cU+f/vcNp46UVpFkqml43IkJc8wfF5A?=
 =?us-ascii?Q?GL/hWa6h6Mx+u1eVhpwt1wg9KPrwCOGaMV0jr0OIBBbLaoKRD1m3Y+CJsZ9R?=
 =?us-ascii?Q?OZEackPiWWBs9FEXVL17SM3nB0TUzfmHEWsRLLsHXYY9pfYKdE4q0fcM4S9s?=
 =?us-ascii?Q?Q8RzroSyhF4X9/CXkfq8Q2IopRmv3NC9jI2HZchtmoA18L0EWm8fvU9Tpt/f?=
 =?us-ascii?Q?uh/CnjpCOxYe2Op/XSGWQ7k=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81577042-cfdd-48f8-b2b6-08dc290196fc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 23:56:38.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0G/UrSPyO/5TVtsNlpgd4Vbharbjfy6PBQbMRWLzR8Ool4BbSsN62owqV38VNtF69mWh/IkHss1Wt0kIhMmt1Wk/yl6AYaJPfim6PhuSwPwBw9mU5jFDz1BwAXjan2HA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7829

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
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2
	- Dien Pham <dien.pham.ry@rvc.renesas.com>
	+ Dien Pham <dien.pham.ry@renesas.com>

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


