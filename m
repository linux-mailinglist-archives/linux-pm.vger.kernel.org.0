Return-Path: <linux-pm+bounces-13099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA39638C3
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DB7B22782
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13838DDB;
	Thu, 29 Aug 2024 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PVFRGeWp"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE3381A4;
	Thu, 29 Aug 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901969; cv=fail; b=CQjDyrQtaSjRE1rvZ7usSwH1IAwtfpU5wnp0gHpIfX3L/HG1pxWHjn8cnVq/m+85wN3XBapdym/Q25K1ODVNeKQBSGv4rNzlQgTsFsK1oFRWzwLFp37PuIbvEveMygKHTlDdm55HVFe65PhbRGwKlWKUuCtKf1gDbLNJbIZEjBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901969; c=relaxed/simple;
	bh=Uk/K4ay0DMQYHGFtgQk10iCyqVKtHcFpj97+Ufsp0Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ianCBtFVuxcicyi5/to5+6cuZk408m6Czf79XjbVn4HVaHHXk9u+xHDOpwF6dXG6a5HRfH3E69rbuGV+QsNUlmgvJpFhFjzJzjfpXk41PVHB6DmwBZ8ln+9Hz9tztVmYN+I1xoxTciA+6Pr5M8py1GoAoq3q/b+/mfy9JbYpW8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PVFRGeWp; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io4vLV9aQL2HH7g0Argy2OfqjsQ2M8paL0UryG3nm2cv36VUnoGgD34Ni8SXieLwp93TV3u9qhpr3Z6Opb4+vmNBWOUwqX55fH1Fa4uOnB2jBkxr7Dnjw6UgMWhD00RKRSPboGVBlW0GMZah7h4qLHloK8XgEp3QVlq81BcO+D+1G2w9J72hB/H0/6JHDOsgrs/aJW9Pf9jri1NacpThA8yP+MRFqVg3MKqjH4rkkb0HRfY5PL70BXxtpmcmeSWcfiQ67LysPbVG7vHsIrbOUxyAHwENC4N27O0qIxMY8vrOnF5qs0VxXtJCauuHLm52LhP9HMcQM02+ZRlRgQVfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk/K4ay0DMQYHGFtgQk10iCyqVKtHcFpj97+Ufsp0Ro=;
 b=xeMRYf7JV7JZX5B0Ijdq/QhE4V+Aqo+BZbB+1Eq0Pvx/g9OjGPXHISJj6KJcccf7MLzG2hUGEugvL7q7FaXv0/XPJefonhAwND7ASX2PPZWjzh22v3HwV4tef4AdXEhYymOKT4FmVxbNnWEUZLXwAO7I/D43FgYHM1Eo3BF+Mbm6Ti1aDpRTD6D40Lykhj6iWlBu5Acasfp2r0XG1dD1chDeuvFcZsSpQmeZh+iDWof9XjP+0Xt8FeumI52X4B0GjlMGebiqlOMZZuqJob358CCI2nHf3kTLFiHwsO3Sgel1njcG902jdorY17Bh4n9iL1MD/lQkfNC4cxyyLxM1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk/K4ay0DMQYHGFtgQk10iCyqVKtHcFpj97+Ufsp0Ro=;
 b=PVFRGeWp8Piek7GkttHjL48EUdgWomvso5A+OvfuC8nBYScAqWJD3IahNPuEb1qy/ymgZyGNWoXXRfwyc+FBuDQqWZdz5R4jlikc7LI+ZX8ywEg2XTlaY7H4LsVzDVZHUE5eH1t3RdfrkzQP1bwU7A5YsYbyOVk7qLKK4UZ61JRJI+H5m0jaVhQ56CJy2Paz0f9Z79xmhpd42aIbf6/HXQK10G1R1g20kOdJa760GJSQWUOOS1ubewNOiaYqOl316yOGbDjICAV0j70e6Bo1lh0WbXywpPO9cHHGOpRXhMSB3rU2XCc2wg08ruL+MUxrD+A5s2PT4y96mJkeGw0swA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5656.apcprd06.prod.outlook.com (2603:1096:820:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 03:26:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 03:26:03 +0000
From: Yangtao Li <frank.li@vivo.com>
To: frank.li@vivo.com
Cc: Jonathan.Cameron@Huawei.com,
	angelogioacchino.delregno@collabora.com,
	geert+renesas@glider.be,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	u.kleine-koenig@pengutronix.de,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 01/22] genirq/devres: Add devm_request_threaded_irq_probe() and devm_request_irq_probe()
Date: Wed, 28 Aug 2024 21:41:11 -0600
Message-Id: <20240829034111.2851672-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffbc76c-1d10-4634-c23a-08dcc7da4f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5G+V/nqIiSEGXbnhkV5iqmI9XG+/oX/MnL3qUBZORZHcBTinw/o6hVLQ3Iv5?=
 =?us-ascii?Q?S8ycG0CtCs4ASJtu975aCOJdlOOU+aqX/efvRZgDaHQ8CO2jd8a9EzJ6MQ2h?=
 =?us-ascii?Q?6b7GJel+tYq1Xi4/MVZRqj6R8aVb960QDkqemrQdeGtUxpf8GmSiath7UVbp?=
 =?us-ascii?Q?mCM9UzRmHnK7WoMem/cLXhYEYoIpkd9j5m8+7aQyOhBIqk/xJD1Sz6pLyBmO?=
 =?us-ascii?Q?FYfrdYoxtFmCfcIoRCfFvH6DDPkFh/nyrf3mNwyBFiS0ZfN6L1+HyMFmPXd7?=
 =?us-ascii?Q?azrnczogpVFVS1wa/KB2HK+rGbg6JFZ63s34CNnG6Zz+9AJMASenXmIRUQ8Z?=
 =?us-ascii?Q?xj0qt75SZy++wZMqxeJx1m+mq0JJ5TJs21gc36WqMJrCTbdZFIT3NjvhCPa2?=
 =?us-ascii?Q?nh3Cet3hKwxlbQg5v2IsNSgaC1yriRosS+qa1g8wFwvDBzdbuO7km23lFJV0?=
 =?us-ascii?Q?i0Rfx22xduBiQFAUHOQauqwouveI/A3gOTLC4IA94YDtM3m2Bd94BquA9NZU?=
 =?us-ascii?Q?Y1AMKvemtWymfRgwfTmpEReUbMK7FXJ5NH3OLSl6/oNLfgd996VFGBj9hRbo?=
 =?us-ascii?Q?bZM8ZjCbYTMSqnrgcpFvWTO35j5KCjDXVjcf/CEh7pkhPrFBOR0NWs2tUXdA?=
 =?us-ascii?Q?LePwMR4RE257/QoiUol7nPPls3K9zds2VzyyXPceCmAlDvvaTr3ZKYN3o0Fa?=
 =?us-ascii?Q?l3INg0jit05N73ulA4gbHsN4k5P64MeD86L9wAkPz6FcgR4lRGITkduLC8xs?=
 =?us-ascii?Q?yUFRH3Nv/Ab94CWvbSwKlpWuOwD9pKd+TGX62E76C7+O2iJGJiDZlgN3//Jm?=
 =?us-ascii?Q?K0mI39FqcimVTyKqVzRFHmFupHucVorqP3uN/FrIHLLfO8QZF84V5waDOQw9?=
 =?us-ascii?Q?KasgolIPsMxhbtNUhI2755U9PXv68yKHsSXtuLxMKrGslcGftBtBSE+3vWKD?=
 =?us-ascii?Q?5gpI+JvcZpsW6+gYi87tdElOpj96eWutHk5aMVP/A4/ztVz4MI3MRFIcuj0W?=
 =?us-ascii?Q?rzD+YOp2+rrasEaXgvVnBxesrNgToGPm3w3USMtzh//GaIL52pfq27bwWBJO?=
 =?us-ascii?Q?4XzhuFemJx++7ZHHqLD2DMMKnlM22gtowSyANm34IKQFVgze6Wov4m/ZfRnD?=
 =?us-ascii?Q?1xs05+zW/WPN8zP2Jl3PjWvTmCvcf9aDPtSjJC9Q4R+jq+nLoEpVCJ7xTUsK?=
 =?us-ascii?Q?iOqIBePW/tZSCvUUq+DotxBdwR+YDRu686E6JHnfw0QYmrommumGtiuXGPuM?=
 =?us-ascii?Q?yNeWQsn22/e6A+mGG0G+5jZCT/Ol3P2dfw/XRwXS/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1psLIFAxSngN5yT0p2DRgoIoihZXA3ISfyPbC2+ni2crEQRBKtWtBAjy8wS?=
 =?us-ascii?Q?bXx6uNC4TinWp7xDvjTAlEEtK8svQMgnIkks+f+UOJDprz85vXu4ItXNT4LK?=
 =?us-ascii?Q?y5tzjsVGXU7967WQUdc06DGC8VHaM5Htw5pS+SOUDivabXPhZnLyykO8eAEP?=
 =?us-ascii?Q?wkLy4aC3PX89KsroTn5DnpgsC4623WdIHHUf179T+cZhqry4iDIEKARz+U37?=
 =?us-ascii?Q?XKr8OKcX33KuDucDwD+tNakWyV1qm7VWA0UV57QHU/EVf9fB5z5ywYZDYaSx?=
 =?us-ascii?Q?X0jKjdO91VovuKZYtCzGOIGtyMb/O3QjLESTQA7vB8It38XyNnge+DumVutL?=
 =?us-ascii?Q?XeHzWlDJLgkZzHcAjHuCkQHZYn6767lUnlMIwMsiZcs+ejsAcGFsLG4tQ9ZM?=
 =?us-ascii?Q?C5XS1L/cvyRBIYTYwY1ttWA56TBHt+VlGx+Xh8sWhJy6pp3tV31E6JMX/PWF?=
 =?us-ascii?Q?6bwm2V65bXYlu3e/Gj5ovRosxsgcajMSEO7NC+MLWhFrFbC8OVWyM1qZ5/GS?=
 =?us-ascii?Q?cgY0LijoG3SuEZt1oIq2cCTHBGE1xeWMpIaqADANMBPbibPqAQgIrAM0yWkn?=
 =?us-ascii?Q?tfq+1cjEMlXJ8wQHah7ytM9BbwPB9Ec1k/agt6PSh1VfxmZwg0eNLyh3Gt/Y?=
 =?us-ascii?Q?gAovJyGUAN5KYVOTKnXDMBXoRlVgiWLOxwtQletu9YpaO3WFPY99ix5id2YS?=
 =?us-ascii?Q?VAUapSYgQbGmB2ISt3vpBQmF7KLteLTKzy8AonxjrdQDeC7WIet3aVh/2V6I?=
 =?us-ascii?Q?Rp+5c5428pyADC+NCPN4Yfu5Vvp5JDOwK+/4grrYTyOvMlNz+jaymuArlb8i?=
 =?us-ascii?Q?jtJE1oSLiYcTKRm9+JCzj+ERsWPj6inetPhYJUUfeH9cm9fhzecyKjeKR5kw?=
 =?us-ascii?Q?B+bixcOxCjUzRjXoSbVp/9J8vz7lbpxoA8LjkeNyxjd+PhS4DdAP3cW1QN7G?=
 =?us-ascii?Q?x9zGfcNValODh5DhiuMLYeDgQEieUlNFkyBjJgp15zrRTeGyT6vQeLQGZMIT?=
 =?us-ascii?Q?rNEN9DdyQblcTOPBrBxObYxCvLeb54bBD6a0AHpyuN8wY6aA8Cd8Eq/aTV8a?=
 =?us-ascii?Q?NXCJvd6aGJJnPysXZyVMPz3QbdseSbRtPSrtYCLDE84M5SKWht022L0Z86A9?=
 =?us-ascii?Q?Du1Dh4vhxJRvNVGZfFkhlswo7t/H2yYNpV29UGZ2exEQ7jZN8IS2hVD6nedk?=
 =?us-ascii?Q?wZTwdkEofDBrjBZzyRb6umKracEnAjYiNZcCpl3vZu1/j6irRbgDvGfn/LNS?=
 =?us-ascii?Q?Y2MULmQqbHTZSJWRx7qnkflemZ8ImLhX/t3Q22UdFBXJby77f0bEyz9SpzRG?=
 =?us-ascii?Q?RinO/Y2rzxceUsMymOv1JvgGb4sVMC03ZEkihJJYH0Wt7DUnOB/l+l+tS8w1?=
 =?us-ascii?Q?YktlE3+q//HV+cNtEcv5iQdqUpOa01rBVQ6a1RcBAoOcaAbch72bhKdhKsun?=
 =?us-ascii?Q?zV1M/mYidBbLohGWDeErQII5hXc5IIyI5b0lomhDVaxrHoxT4gUYVHTpmYr0?=
 =?us-ascii?Q?QFVVEAxkn29nItoXhK/cImaEFWpivlMQHMT+c/pbjRtrDKa2cUBsPVaXttYK?=
 =?us-ascii?Q?+VpsNOWPsZ9OMF7cTFKYfCksN9CVgEzC2KFl2t+X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffbc76c-1d10-4634-c23a-08dcc7da4f59
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:26:03.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyQsseDZ2iRpHJ+eWZyX4Z5fOcjpXwMQkDKoXPLAlvl/z/blXH9ogTuvt6WLMzEt+RavR5iLJDgdr9pSzJ+g2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5656

+cc rafael@kernel.org +cc linux-pm@vger.kernel.org

