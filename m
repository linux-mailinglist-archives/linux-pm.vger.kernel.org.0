Return-Path: <linux-pm+bounces-30004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC693AF6753
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 03:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5801C20996
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E317C208;
	Thu,  3 Jul 2025 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="fKssZetC"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011026.outbound.protection.outlook.com [52.101.125.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BE3FE7;
	Thu,  3 Jul 2025 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507365; cv=fail; b=GYRhJHE2qZ5vlR1OftWy7k5LtyUrgK8t7yrkAJKdeq3RiHeLEJQRnLDZa0oC2wOApRn2RFKOpuaKrJiAMQ4//rLJPTGs8ein/L+OE/3PYnmCsB/DZMQ+4DT0tt36ss9TN2Np2b4fGmCSiWY/m3cN0UzUJIBgHl0U6vTHaLr7Xcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507365; c=relaxed/simple;
	bh=2UXUfRl17E1iDh5ZQbple9GEEdzUJiqXTAkJtFiux9U=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=dPtQntq0rdx1w9QtnZpAKBd6QSfkiPgVWH1MFDgU7vjXgkGBTK5y/u72RadDtv5DqX3kcDononmc8G2zXLC19GRQc9Xrci3cCiUMcokSoT2DtzczI0whrYYoq6N5K/nfDTjqTfLvghT34vzog8LjTDweI2mXij9iYicyGVd+TLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=fKssZetC; arc=fail smtp.client-ip=52.101.125.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUZeWFnsnyX7+cG61kUjjIAin6W3kWYWOepIfADu0BKVbnARO7K9cxPZ/u8dG/saqhVWfrHLdHnHd1jdEOj14sClOflekLQI36JP4wCJYom7Wa7cFys6dTVWgGt2N6TZYkiUTrd+Zk0upTEaxbSSonpdbnPnsmzA6JFSj/AMpGsoFr2EIPXcCzcPOzjsWvD0nNTcZN6tYf18oiAj+bsj1qlPo8woXYJS0zDuWwycTTPBYp5/kG+Oo3gJMjulJa5TceBvQZf2O3nLH7iiCZMdSv8Q72uFymsTPIQFgPEA9wFFdKaWd+6jb9tsnyTUhOhLGHKm2CiRaPQJGkYMGtZRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoa63F2Uv7tPFcLstK6istzmOhGfphOLvC+DbxCBfFE=;
 b=VrFdb0E4FdItvOzjcDQtE+0XOL1MEwWn7h7U1PCxnLfqikBkHbs6yUB4aMzUApEjPg0/nyZqSwQeBSavyhIXk1KaLEdnjwkDhYmOwiPrxCRYzAILg2o6LnRDMFDe4vYHBcmtudWmaGEqopBw/hrQmnSi7DEwcpBX7VCX8EuQvJi7jmyTPyqDxuKQVa4dSC9rOeO/X7MK2HSXFXmBP1wKHQCsLC6IcL+M4Y6bgtyw9F9q35h0ZF8YjtlU8aJ285Xl8XYTbcd2+7Vuh9TUsY1ZotrwuMvFClFHN2bAOHAqZT244YlQpxQFBjPltqKklMHT4fPPNiQ7db02KcxnIJ5rOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoa63F2Uv7tPFcLstK6istzmOhGfphOLvC+DbxCBfFE=;
 b=fKssZetCv5dbcFiKmX6XQkrdxNxQlEzMqRrpylRkhKTKoByGY/N2CFNZVDezoZtusvNOZ8tPE5ArYeQFg3y12wF064FMRtCEPov3JS7VrmX5AJ/8WLqCxVE73G1tN9Vu58hCiW+A6c4LmY3WXl13hlzAK9IQDCYwJuEFSlzb3MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSOPR01MB12299.jpnprd01.prod.outlook.com
 (2603:1096:604:2d9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 01:49:21 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 01:49:21 +0000
Message-ID: <87ikkacacf.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 2/3] pmdomain: renesas: sort Renesas Kconfig configs
In-Reply-To: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 01:49:20 +0000
X-ClientProxiedBy: TYCP286CA0346.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSOPR01MB12299:EE_
X-MS-Office365-Filtering-Correlation-Id: a5baa24b-8ec0-4521-443f-08ddb9d3d464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1Y17LXLtSVBLTC5sf0suYst1PmJXL9nKzfM9y1nJWJpVtwnj5FIb4xYrMrW?=
 =?us-ascii?Q?//b8zU2qTKL/FOIwcKsHD9tKhIXunAx3CV/d648AeKukjGLTfMMg2vSO6e3P?=
 =?us-ascii?Q?UqEzziwqbg4KuYYi3b1yYGKRGZcBVKvNDqgKlnx4ptNtc41x4EQIFCmGr0hS?=
 =?us-ascii?Q?YREHW7SsOesjzEBoAKjMdYjtARUkgt+ENvgqBch9IpEdPwLktBpiWxkqRAu/?=
 =?us-ascii?Q?efBDSPHQ1aX+m68IYqUoyKlr/vIFwLQM8R2Mft+PEr7CE9ORznwnYFWA4SdH?=
 =?us-ascii?Q?8SxJ2nEkbNrltuLQpO2PydmfUw4qmpSnPqSTFZ/VxoJYUbh8RcqwFSLc1e2q?=
 =?us-ascii?Q?AG/j2q5jLcnnSmU925XjAWY3OV5CGSwMhTE8oX2W5aoLgDCtcqQvLMIYNvYe?=
 =?us-ascii?Q?vimXVdOQ1QMbp7sjlRnUNQ1WAOVeVV/K4huaOR/W7DFhy8TE0iQKeEsme2Rf?=
 =?us-ascii?Q?gB6UEPXuYRBI1ravjawlUbmsAXzs21JeE9R7AAhgZM+AlxwE769EF00OVmou?=
 =?us-ascii?Q?52ttVXFccOE56efDJ5Xa159mVNatn5zkRZMTPty7HjXYGczcV+0oaGGN8RzK?=
 =?us-ascii?Q?hgtdO9NpiUJt21/QuaI6fr2QkrB/AvCiKoDYBCu5NB+Te6LovTgBU8S0O7P1?=
 =?us-ascii?Q?KUK/2fuVKC0QPbfFJYYPvoKcmP6nlXKyKUUwiVIp52iNGQQfyjIPM6oyIQjS?=
 =?us-ascii?Q?+FoKbRkjv60vHOhrJMCe6pAnFogyPu1wyh61xI6fSoKY+cDS7Tq+0Cqx9dLq?=
 =?us-ascii?Q?+P5A0ewg2+GNIQi1rl5WphUtTkyqaNgmTzPHbD0v+mBSTwx9sdPnkoiH/ycJ?=
 =?us-ascii?Q?JjBEUmC5ey2tMhk/psqsMgCzzYIgaQha93xfswQVos782ql/dGtb+nCEuP0d?=
 =?us-ascii?Q?wqr9x4QCYTRnPZ7HDUju2LO4fJhsMDCvMTxZnsQHE5Ns4fqnNhHoEhAsCaVD?=
 =?us-ascii?Q?w0Hhl8eifrU/n9I69L3EpOvZrqGp+qctIITaRipfPbIJsUO+HoTRosZ2LUqw?=
 =?us-ascii?Q?/IevYh3jzrUL5homhVIxDvjZy87ElZOnvVrUA2dUf/lsGJiz8CtHWVhejo7b?=
 =?us-ascii?Q?YtEX0HI5owhuma9o73BdIT4IJirmfBJqGR5N+qKwHGIQAGBy0LnZwqePvnO3?=
 =?us-ascii?Q?WnE1gwbts+oENbz56rBH3f1MdSWm5LF2F7IpHR1j4Y1wdbEjhnhxnDD2x1Ji?=
 =?us-ascii?Q?OzeqQIA9RmuR4QF+hWnl5wELooV/9HKKP9ALR3qSyXdk28rJZZ39gtQ36IEu?=
 =?us-ascii?Q?YBIGH4dfe4XRQVt13aipa2x04/jmlvzw45IlFKk8lvJbfwaoD24baF2wTeU2?=
 =?us-ascii?Q?OGCJM5OTYfRdorFGae3bLUxsRE8Vr4EidF6KE9/gxP2JOympTbhtzWn3VGBi?=
 =?us-ascii?Q?psIsf2izoFLEMN2UW/m17Dx6dEfiIpejaItzWrkTyJlKZZtXHdvr1K6XuWu1?=
 =?us-ascii?Q?ZNOTkAJRyZOoONKmu7srmKCF+OVO9mYuHFDxiaPd6F1eajlPZ18W9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROC8g/n39tgS0M8WOQWxOotF7ol6dUDSQsYi/Dv0oSXXYzfamx1F6ofOeeqe?=
 =?us-ascii?Q?0a+gMJLbui6wXEOP5W94s3pBMcJNShmj1pSBk62+0AuYVs+tutWj29HO96d/?=
 =?us-ascii?Q?n3456ieDW6aFmFoxzccbFCWLZrYlWm+b+gJyEDdCEobytvM3QuZqlIzoZq3+?=
 =?us-ascii?Q?PND96WLe2Os6bzuH6i/csewDkP13NJBHR9A8mx4BQSMQyPTVU2ExvgQBy1pf?=
 =?us-ascii?Q?sHiLO6jyE2pzE0N92AAZLSciEzRP9VcQEb0AMrAk6c7vltD82D+8Ike7hEhY?=
 =?us-ascii?Q?FJvcFZi2OYW8uPh5SFkFM5i6Y8JZALNG3mWu4NUqDQh0rZBM4N1m1QhNRaQc?=
 =?us-ascii?Q?PDxA6K4Ep83NWtv6loCDN9ScFmhXQOvFGGT2ufCMFRybqRnz1am8KMO7UqKt?=
 =?us-ascii?Q?NfTRM1wBA7Qj8wes9vllntGfmTlG/N/ACizgBt4QCKpVvF3TmSL/ssKMb+uJ?=
 =?us-ascii?Q?4ez2Vib+vIel8F2BPWHKRVFBtEGPQ1oBwq7tc8Lm6CEjnOmtXsvRflRUe8mZ?=
 =?us-ascii?Q?l6fLygLJLW19K3jonuqc0/+rTR5Rx66dymvrMLjJlIAJQhyxN8d/3QjPkRfB?=
 =?us-ascii?Q?CdyP8SHSKX0YrXe2JXn96SQ74qWsP/Gcq7syv4fIsnNs4kHh/R9RUMifGnrw?=
 =?us-ascii?Q?cy19ZSib/LymjAI0fm4mhc3FC4h97SNy7AEB0IQwkd0v+eNn9CEsTrTF28q8?=
 =?us-ascii?Q?mp9ytIULXRyUo0xa+xs26h3X35cnEvBJTS3/hZldvBRIarw3oe4X4zFZhg25?=
 =?us-ascii?Q?Q5qNGNnrAguCUqPxBlSIbzZp6jOKuAPktKEtk7HmSQnmqAmD4WY0imL3FA3p?=
 =?us-ascii?Q?zMvLLHzbkiF3E9x/bxN5HE4XI+OvJcZJcERrelEdrgM4EQcR2TYbandsAol9?=
 =?us-ascii?Q?gU+HCoUcjTAWTP/cbXsneBA7+kjwoqjS7aagno/vGAjso/L33p5T75+7RPB5?=
 =?us-ascii?Q?8/yAxxTHi4+ceZ4I9CYcTN+52iHRzIY4FjIGKEyx1fIT3O8Ng++WZ3NPHAmt?=
 =?us-ascii?Q?lhCksThsVqSYjkw6J5CDgw8zMdtFS6VI0sLFJOaEJbhIB/wU+uOlCErOddct?=
 =?us-ascii?Q?TZrBOVwsI/vTof6E8+t73DP/hP2vrXmArP0AVMf6EGZU/8KsI4/bqWNOyP5K?=
 =?us-ascii?Q?AQsGr4oMgxN94GwU6JGE3ymlMe+l2moQ2547eEzkW5BjWhJmtz59CRS8tXx7?=
 =?us-ascii?Q?uRzfGje1ynuIT/TkjYYAaallsRzq6Jcy5howsbd0NEM/LRDu2NOJgGLCVQQo?=
 =?us-ascii?Q?t/ZIx7Emx9b6njiIKdmFFcX/A/y6ymPKz2BGW0nrLGfLoJwq7/OCpZqq0eCV?=
 =?us-ascii?Q?QF60AhtURTX7EfUogjk8NP+X/w1sLTiZdkhbR4PFeG3vO1V0nPeRmi5xmQ0Y?=
 =?us-ascii?Q?MFRf++xlIVwS8hdBDFno5QWxoxNrVtJUd/QQfQaj+cbk0H9lC/xgXDICFYfF?=
 =?us-ascii?Q?IKopqYrOktk9A1ks985V0vwY++KqPRB9d2kEWA1NVW2jvvR71cVbU1wKpKrs?=
 =?us-ascii?Q?wv509dZa69MOlTaPCzP129ocIfabnrUraXIvZfGs7B7alrdoVk3tVN+XxUJ3?=
 =?us-ascii?Q?T7wwoomMSfs9S2Oi8y4CUxddUKgtP6ih2hlq5BDjJtPtgKEGKUS5AJTJw/qX?=
 =?us-ascii?Q?fy6uuaKHJaHQbZWxaKkS3xY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5baa24b-8ec0-4521-443f-08ddb9d3d464
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 01:49:21.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS6MXMJQeRickrysS3NXOlZs4rYv3EN5q/b/xCKwSe3l7FRdi5YnjVUhX9kRUFVdAHVFctnvNNT+NPliGdipXhdqz6OvruGT03BrTk7Hvc6h2sTlc1uRJeHp2Hi67X4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12299

Renesas Kconfig is using "SoC chip number" for CONFIG symbol, but is
using "SoC chip name" for menu description. Because of it, it looks
random order when we run "make menuconfig".

commit 6d5aded8d57f ("soc: renesas: Sort driver description title")
sorted Renesas Kconfig by "menu description title order" (= SoC chip
name), but it makes confusable to add new config, because developer
usually checks CONFIG symbols (= SoC chip number).

Let's indicate both "SoC chip number" and "SoC chip name" in description
and sort it again.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/Kconfig | 122 ++++++++++++++++---------------
 1 file changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index 70bd6605a97c..b507c3e0d723 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -2,114 +2,116 @@
 if SOC_RENESAS
 menu "Renesas PM Domains"
 
+# SoC Family
 config SYSC_RCAR
 	bool "System Controller support for R-Car" if COMPILE_TEST
 
 config SYSC_RCAR_GEN4
 	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
 
-config SYSC_R8A77995
-	bool "System Controller support for R-Car D3" if COMPILE_TEST
+config SYSC_RMOBILE
+	bool "System Controller support for R-Mobile" if COMPILE_TEST
+
+# SoC
+config SYSC_R8A7742
+	bool "System Controller support for R8A7742 (RZ/G1H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7794
-	bool "System Controller support for R-Car E2" if COMPILE_TEST
+config SYSC_R8A7743
+	bool "System Controller support for R8A7743 (RZ/G1M)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77990
-	bool "System Controller support for R-Car E3" if COMPILE_TEST
+config SYSC_R8A7745
+	bool "System Controller support for R8A7745 (RZ/G1E)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7779
-	bool "System Controller support for R-Car H1" if COMPILE_TEST
+config SYSC_R8A77470
+	bool "System Controller support for R8A77470 (RZ/G1C)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7790
-	bool "System Controller support for R-Car H2" if COMPILE_TEST
+config SYSC_R8A774A1
+	bool "System Controller support for R8A774A1 (RZ/G2M)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7795
-	bool "System Controller support for R-Car H3" if COMPILE_TEST
+config SYSC_R8A774B1
+	bool "System Controller support for R8A774B1 (RZ/G2N)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7791
-	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
+config SYSC_R8A774C0
+	bool "System Controller support for R8A774C0 (RZ/G2E)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77965
-	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
+config SYSC_R8A774E1
+	bool "System Controller support for R8A774E1 (RZ/G2H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77960
-	bool "System Controller support for R-Car M3-W" if COMPILE_TEST
+config SYSC_R8A7779
+	bool "System Controller support for R8A7779 (R-Car H1)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77961
-	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
+config SYSC_R8A7790
+	bool "System Controller support for R8A7790 (R-Car H2)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A779F0
-	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
+config SYSC_R8A7791
+	bool "System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)" if COMPILE_TEST
+	select SYSC_RCAR
 
 config SYSC_R8A7792
-	bool "System Controller support for R-Car V2H" if COMPILE_TEST
+	bool "System Controller support for R8A7792 (R-Car V2H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77980
-	bool "System Controller support for R-Car V3H" if COMPILE_TEST
+config SYSC_R8A7794
+	bool "System Controller support for R8A7794 (R-Car E2)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77970
-	bool "System Controller support for R-Car V3M" if COMPILE_TEST
+config SYSC_R8A7795
+	bool "System Controller support for R8A7795 (R-Car H3)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A779A0
-	bool "System Controller support for R-Car V3U" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A779G0
-	bool "System Controller support for R-Car V4H" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A779H0
-	bool "System Controller support for R-Car V4M" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_RMOBILE
-	bool "System Controller support for R-Mobile" if COMPILE_TEST
-
-config SYSC_R8A77470
-	bool "System Controller support for RZ/G1C" if COMPILE_TEST
+config SYSC_R8A77960
+	bool "System Controller support for R8A77960 (R-Car M3-W)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7745
-	bool "System Controller support for RZ/G1E" if COMPILE_TEST
+config SYSC_R8A77961
+	bool "System Controller support for R8A77961 (R-Car M3-W+)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7742
-	bool "System Controller support for RZ/G1H" if COMPILE_TEST
+config SYSC_R8A77965
+	bool "System Controller support for R8A77965 (R-Car M3-N)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7743
-	bool "System Controller support for RZ/G1M" if COMPILE_TEST
+config SYSC_R8A77970
+	bool "System Controller support for R8A77970 (R-Car V3M)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774C0
-	bool "System Controller support for RZ/G2E" if COMPILE_TEST
+config SYSC_R8A77980
+	bool "System Controller support for R8A77980 (R-Car V3H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774E1
-	bool "System Controller support for RZ/G2H" if COMPILE_TEST
+config SYSC_R8A77990
+	bool "System Controller support for R8A77990 (R-Car E3)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774A1
-	bool "System Controller support for RZ/G2M" if COMPILE_TEST
+config SYSC_R8A77995
+	bool "System Controller support for R8A77995 (R-Car D3)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774B1
-	bool "System Controller support for RZ/G2N" if COMPILE_TEST
-	select SYSC_RCAR
+config SYSC_R8A779A0
+	bool "System Controller support for R8A779A0 (R-Car V3U)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779F0
+	bool "System Controller support for R8A779F0 (R-Car S4-8)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779G0
+	bool "System Controller support for R8A779G0 (R-Car V4H)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779H0
+	bool "System Controller support for R8A779H0 (R-Car V4M)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
 
 endmenu
 endif
-- 
2.43.0


