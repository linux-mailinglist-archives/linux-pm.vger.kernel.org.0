Return-Path: <linux-pm+bounces-29630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33967AEAE08
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 06:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24271BC5BD7
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 04:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA28194098;
	Fri, 27 Jun 2025 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SAVPhEwW"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010013.outbound.protection.outlook.com [52.101.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967441A8F;
	Fri, 27 Jun 2025 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999322; cv=fail; b=lpjtD6kMd1R4p7cLHyPbupYS/efrI9tqHnQ7yBOv2FHiNYA6yDYBfGPYeYO27QhnGaNrsWdDxHKukzBVBesiRUr1VgVaPlCMvWA6GbEAoiBRYymZU5jAOhXUKbaW3+uoUxtWusg9nYN28BV45SMFlodie3lxE3huGTnLCBXs7t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999322; c=relaxed/simple;
	bh=pXfhQssbdK/RMDx4QdmIp2zgSzZJ7QB4B6uJCyt3FLo=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=E1vOU4kCKdE8kluVv69nrAIW4/XjZKl7wyZS8MNXdHsu38JCvC97spVYIHo80bT50TeSHNzeBn+/MjP8Rh/u7pcQCkpA4Tw/qkD+4lNtmUNemXgxl01QYtIdZFi9x82k9vRwBuhroQvNy2mW+zEHI79ow3uwHcMpLEXrb10HInE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SAVPhEwW; arc=fail smtp.client-ip=52.101.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwJ2sjgE/OmpVwp6f/4KJ0mpTNeS6ID0tygIp1l7CAnYZiTk7aE0CttS13auKQg/uGsq2ygfxv/jbxZugyYv5gwWCTEnKrsxgST/lLBws/7nPLwrbm4ZILH0Fw+8r9UVhWgshCfi+TxQ4wndghePUPNe6oG85QUQ9tlxp832qSA7s3Y5t2TDKRs4WTsx2O0EOZxSp28PuLK3o/WUTcasGT/ZIDXKU5BTmnXbF6hmJU4bwgrUbtIukd8U5jHvr56360YdJEv/JTy4lXqz5sutBZmAOtxbYsIgWbWm38y3S60VQ4OcJLc+XiESQ93Zubae+AgVvif51WqCeQ1sMd2i8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2wiMK4xhNkimVSoYKIQAm1pQSwrk86XL0hI6+bV9Uk=;
 b=CfWYKiW4ABXbYVC3OBlJDoIWnytl+NvQ3ZCh4MvRM2LHydWcYcarNXmM2JBbw2rNWg0vjXwCa0zby7/vChk/YKhLlB1wVWs/VGtqiqLNBGTY9NoQPxnBiUrCVQhbG2JII/Fv+XV3L1YqpK93uH2YLQHoZTiYzcb9SqP8mGVp11Aensuze0oQswxIsPmEYSjuSnq5Ya8I5O3z9Zis7fQ0bmTiiaZj2F45GAyR1maN15aCKwvSYh+Jm0PzSLTc/yEM2g5XA9ruflQuARLgyB6Tece6GsLou96B/auWtdjzhi0QC2JpL4vihWH1p3IrM1rTAvEeqfPaFYhTRgubUj8Dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2wiMK4xhNkimVSoYKIQAm1pQSwrk86XL0hI6+bV9Uk=;
 b=SAVPhEwWvRTSPh0C036Qwq4G9WQacaOHLJUhDN2cVpNRAhkpUTgCVpmBAFYutkS+o3vCHvikPvyfhjA747oZ9hU4f7HITeR73DFIh9NrGBrhfHh1Cc+MAfDnq7rbzvrGt/1DFa8csetZofFSp+Ou4STOLKFIrnRPSSdv3tye55k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB6790.jpnprd01.prod.outlook.com
 (2603:1096:604:115::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 04:41:58 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 04:41:58 +0000
Message-ID: <875xghhk2y.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/2] pmdomain: renesas: use menu for Renesas
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 27 Jun 2025 04:41:58 +0000
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 71429bb3-673f-47d0-5369-08ddb534f354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bRfJb7oPlACqf2dPFib4w4kMVjEbGzAPSlIFKNAuMElDIavOfpF3v4Y1Zleh?=
 =?us-ascii?Q?MNmofhHJN7SmWuLqoN/u6YVSW39OkO9l0BIUD5epLkebXbgQ5dXHS1GOaayH?=
 =?us-ascii?Q?mFduT3AbIWEqURRw42C8Nc8Io2X6Fe9GzfKtEMzQ4ZdAuJoU8XXVtStfNOHn?=
 =?us-ascii?Q?QWE8kQSOD6TfotMsm5XL1rXQPZgyhYRDsMaE8z3NM1xwpZrFhEhFDBFVgLH5?=
 =?us-ascii?Q?UuCGSm5hNCF/1IvXh850LwB/1uJE1jlNYxQnZE7eoUdT5QzZgkOcJycuF6eh?=
 =?us-ascii?Q?v62PkQftvn6WgC0eM1cwCDy+S/wA1NyirpxmcA9psmyxt37zB/PREOX1/dQD?=
 =?us-ascii?Q?/JCUREht1kzQn22yiRVzwWGx+76Xm4AW18n3D+yZMc5DmAr754RhGoqWGKPs?=
 =?us-ascii?Q?go+9DGOPxqby8iXaDJS0mGms+B5tRJUYWgiZtAgUuFgvrku1yuRJXorQ8St+?=
 =?us-ascii?Q?3G2SQVCTbad5p/yb4n+mTs6713PqwKVxI8ldjgYW9FbJ8ewZ3vL4XxrvhmOm?=
 =?us-ascii?Q?IZJUbX4SB/0QFsMrjXGXQM33GwJjoTvBxj6FZbn/mHneEPAxUgADbjsgpZGF?=
 =?us-ascii?Q?/o/LEIpDcUIiiexDaVbbd5T6GQtOMmK54FtYFZpF+sz3w4BCgVnHZ/MPrnpw?=
 =?us-ascii?Q?JEzlo1m6z5N2nYdrelngG/+bAwCi7J4Q6hnksDzHaKDW/8v9pofXjq07SbSt?=
 =?us-ascii?Q?izBx1l4OkIdXBApnd9g/qQX6BYzblwU2pdnAK3LXreFDtL5JtNyWgHTyYyg3?=
 =?us-ascii?Q?HlIoLaG50andwDHIZLuoT8DuLJK22m+G1EEVnMjyOIFoUxmV32pgNU9C+yYP?=
 =?us-ascii?Q?z1TGpjg6Ud9KH+8L9m0YsK4SQ8XxV3QAZpsN2PlzFp2iIdBpUSvQb6hSe9vR?=
 =?us-ascii?Q?iW1OC1OijNldwYH2fxPhokXvLuoP+tOq3pQElxq7a024df9yxCcJEvSAJ+YU?=
 =?us-ascii?Q?AFuFgzlXwyUMzxezYoOCIzuWeeQwNq8iM6zyrotU4/LtKy2Kx/lkuefgr+xv?=
 =?us-ascii?Q?bKW//tVl2M3+UthgD7ZaZgyZ/kjek9uxlLBq+Qp/2GzNyRhTs2yFRUlRLzSd?=
 =?us-ascii?Q?hnDnB7Rm2ghIR80ZwXn+LIi2ZO+WC2qC0TCm1+SMRBbfHEfIESX/2WuqnaP+?=
 =?us-ascii?Q?oJzi0nRnx8/itFVuKXPIOe2zlTrrl7cn4jpdmSn0F15mpCzxnqSPNq+wwn0r?=
 =?us-ascii?Q?0Ydm00FCZGYy0gJmFZev26+k9TIVMJ8WCdsknekPnySp7qRvOrn1ecgSlL+3?=
 =?us-ascii?Q?aKD9V/crR6RsXmRFbTglYYKSubPA98URH2vVtMbBKGIbfAkjwwT9PSHthiXY?=
 =?us-ascii?Q?tElDi7Q1NwzEec9qbbdk8tdb1BP6U8XSfYlw/fHK7wMvV3cZD9ecBXHD8eZr?=
 =?us-ascii?Q?sf8hdGff6XP0sT7UZqiFlpE68lKgN9Q/EUI2f9VqNp2lsozYygI7D/mWw01i?=
 =?us-ascii?Q?4oLaPu3dCkXBeThhu9foR5s58fwxopCDX4eWyNo6BuZPaLopYjDxYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8oV7eBEIgt8L1rU+Jb1m6o2R98iihvlBz0G1+1noUPEKeHKipE3jiWRT0GD?=
 =?us-ascii?Q?y3OHoketQPN6zB/++AfvlqE0rF/AxQnSSsEGaylPC1m6YGP7ClQc2dTfQl39?=
 =?us-ascii?Q?QY3z/yBzqmSpLofQYpQhShISzotRE824C61xUj8EIJcMhqGqnYXiM62yIx28?=
 =?us-ascii?Q?DUnbygRJ+Xv+Kbjak0fN2dxGpRBL+xvxe0n47OqC8MHRLgMRAAJmlAwWiz6y?=
 =?us-ascii?Q?0Hp3MXhZrhT5em/rhrEyQTcJzjFA86Rjj+FeT1Ybt+JAKiAwf0XUSG/gkntq?=
 =?us-ascii?Q?otNodHoWTDAbJog9N8oHyr+liA+f+BvHvh9PWIirpuwkin8nHZhPr7u42Lkf?=
 =?us-ascii?Q?c2+R5PCz4DOdvMjPJir34DmAqgSUEvG8hzVXxaaAYkrXYYut9p1Dgj0vxhe3?=
 =?us-ascii?Q?gq+mnpYd9PahVOauje3QSZTmsML/Ezxi9p7Mib/lmauGlHI7Fm1/hJc8O7Is?=
 =?us-ascii?Q?ow7YD8407mBoAcyYNmYbybPfsvYEMhAt47wJSIdwUDcJVHLk1fNW3snLh4K5?=
 =?us-ascii?Q?3p9cfpw7dqoEH76VlSMfscTQ9nVuRNLsyWXpN741XucakzABYO3l/aCgC5lF?=
 =?us-ascii?Q?wmL19oEnZ6tUJOX0l9LmVnjkdkm4inQm9KpTR7hf6P6BxDZsbY1RN6tZTOvf?=
 =?us-ascii?Q?10Z2E7zRVresDFbWX/+hYyHVn7T1ZD6zzG1jCTRJ8GwnmTB/k+9OxAgvU1gg?=
 =?us-ascii?Q?QZjpOEZMXHmnp2keH6zr8ekmg0SGbX0AipYRlbAqwq8Nnr+Y0QKqpQn1Uy+5?=
 =?us-ascii?Q?iiKG22eUvNz9PpHClRowazPgSLB9WE3jxYy/jHs6K+fmesrb6e1ygOjuo7yt?=
 =?us-ascii?Q?fcxi/C9h9ppVSZPm35tfwHPvteSVpLPznPjHyBO+G8K3BP8VHwspoph7nMZ0?=
 =?us-ascii?Q?OwXxOwcTEiAtYtv12o4vKZOhrk0WQafo+bBbo5X3stKasurkPuMsAhO1u2vr?=
 =?us-ascii?Q?o6jkyNtxhedotwBtt3U4f5GTWriIf6wBUa+w+xAoJuCMqnNfTbLoG4XQ7ynP?=
 =?us-ascii?Q?c2u2UtflNHp+wWF6zpTn9Dte01wvGOXyf52S86KJ0Ei5HlD2xAPmBaS42seN?=
 =?us-ascii?Q?9WFeXd39nELBoxT+OLrnn2SH3qK0Fl3c/x2jJijpPAR5NPuKDNE4lfChYaeW?=
 =?us-ascii?Q?ugH3ahroCJ86bzRmyiRH/DpqFHdoUbQlhopgIiCFtPvD4RkhuBcHX0FIiPF6?=
 =?us-ascii?Q?ejQJGowf7jrM9xAAYt5qrR4vrmjsqGhEigwihGl2m1mMcY2y7em+aRJO+SUM?=
 =?us-ascii?Q?Ydf+7l5ajII5A1G6DmN4K50fF0B5rS++hBlEH84pwpVvHyPTBz5gkJ7bRMgj?=
 =?us-ascii?Q?mvEnz42UmvMxS1bWPFzp3O90EI1K+WMd6mxQh8ZGqIwLr0i26lJUJiCqC6M3?=
 =?us-ascii?Q?n5PPJ2YKgSia1tLzFeowFFehorgRWeQUW3yOe9Wl/T1EtpaI2y4A8cXqWE36?=
 =?us-ascii?Q?12UptOiBRSaGHKJrB4D6+y5E6DllspH0enamVneirFJKdCpj9lqrnesFcoOF?=
 =?us-ascii?Q?/VnXpXu7lsxmiRJ6IjmX44N1H8NPRRUC2bDg2V4u2ioDCp+iFhQfYqhmzdRz?=
 =?us-ascii?Q?u3p4KPE7lTcv/gInGuD7ZHXA4ZtxCI+FByjhfr49afwhQmYvqrU0DbsbgzKR?=
 =?us-ascii?Q?Q5PFGHVseJBnUit5XdRSk1Y=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71429bb3-673f-47d0-5369-08ddb534f354
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:41:58.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycbTeW1gCh9F7zusIMTuIckmbLUOv2HLU485xmuslGeA9gQnVSz7wG61atqJ0X63+h+WXN44OFzpo9fjznxW1/AjzywO0LMnv2KpbbPikeQeYsv56QFmyLnNndYFgJeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6790

Current Renesas PM Domains appears on top page. Let's create new
menu for Renesas.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pmdomain/renesas/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index 54acb4b1ec7c..70bd6605a97c 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if SOC_RENESAS
+menu "Renesas PM Domains"
 
 config SYSC_RCAR
 	bool "System Controller support for R-Car" if COMPILE_TEST
@@ -110,4 +111,5 @@ config SYSC_R8A774B1
 	bool "System Controller support for RZ/G2N" if COMPILE_TEST
 	select SYSC_RCAR
 
+endmenu
 endif
-- 
2.43.0


