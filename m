Return-Path: <linux-pm+bounces-42160-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGilLoO+hGnG4wMAu9opvQ
	(envelope-from <linux-pm+bounces-42160-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 17:00:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDFF4E32
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 17:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 662DB3042986
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949D42E01A;
	Thu,  5 Feb 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X6OkgC3X"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58D42DFFF;
	Thu,  5 Feb 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307131; cv=fail; b=N/+r12frm9xEA42iqsBs8cLSPchiEaxKxc9vZvR3yLPW1ejG2e+LYOcZaxxgb6Df/bFF4mFAf9iJIF5xvzHZsPNIWyLtBkYjwxv0HujCbd0WxE1IHx+EplVzp3iRcBYiRfCVCGv80y69o8qLln3udCkm4cKPo9zYxPw0xIQvraU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307131; c=relaxed/simple;
	bh=KMdcwyOJEj3GkAvCAQGYrcQISQhn1YEUIL2Zd/lZZYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fw6DMK+22+nLV2mqP0g1LgyAEHg9moTskiuC8cPHTAB2zqZ2XnnoTRAroJWHzFHrN3b48E7oK4Fm8aictVrQa9R6DgS0ZVL/zGsTKfX6I7DvGIhl2rcSm3wWfqeDVR8tXSuP48qCHvjUdDRO3LHp/rervoF0TzDJSRKxSBG6l2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X6OkgC3X; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNiTBl2aO1z12Zu7CaXSAQh6xVszlJIPTlHiMo+cqO2cU7LZl7J5S6wLQPaOqxE5QAqfmIovll8OPHUF7MiyYPlaG0ChI+CiT/6Vm5UdixIAeloL7tqQzj0xsQn8GJ1LM+ltuszkMKtIsLlH0vluabOu4w47g/QCJF3ke7r8+cEvE2DT4nQFYVDWnOTYirk89CM6i17l/0y7Xf3pebaE2LKp/PcKFfU4Q9sjAP91MqDhQx9gqbm1JmJro3WFoZ7NQ64vDcWzpSgFKF1ZdUykJuMU7IruA9c2gotxiceg8rXa80mgTkf8AlqWNdFGPd0HLV1LdI9BsTm8nBCTs2jAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R+FAfArCPAKhMYNzQMu+yKaqg6EtKJfRn4X113tHSo=;
 b=xNNbAIYshjoHBhxHWqXx1y3uYtQUVu0/3d15vjOTvDGEIGFo6Pxv1z9f3SW9CppC0lq6IaM86Nc5Wb9N0rlpaPF+DxEI6DQG1gclMRCCSDclGvuw6kbmDm2AA4pigd74+VQGS/+tEON8HEQhoW9Ql8z+e0yVRWEkg+6ctlVv5bwV5PyPoFXTelHKhW051FA2Rh5hGlyDGR3wcUsI55xMtPw74COatNmwkAUSsi0/C7zjovIlXFgnBnCPPo2S32ndqwdAAn6QH1AqJ2qyR7xZ8osZJWmajphNAL6vJsd7RnVY3q72/1HPnuTaUUFyJKSb7YkmuqK8pVdepdXISa469Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R+FAfArCPAKhMYNzQMu+yKaqg6EtKJfRn4X113tHSo=;
 b=X6OkgC3XiMRQVX5kgVQOzF3Ok1QO71+lrgtCGtXe91Px9CRuyKJrr+w9QRSOtR0PeGl1JB3fnsWGrNwAD/EsdsyIeIoaLAb1Ikh+4lXRrSvXIVoBpi6f4oPsV7MKTkCYcqpopgWoOVKuWyWY7n1Td74vzD5nK/SnkBoqCkHHgKA3r6u3PmqwUoY+inVhfZdryX0+rdgYD2qxIYAZSdeMS1tWuzwc9p5p2AfkZJoEVgp3TTeQSwRflWugHqPa9/XXcFY2LTkyJH+am+pJRVQdvLbNZa2EXRzlp4aWIVo8VgKnSBLxWdctvZKA+YCtuQ5J8HDlDF9X5gOEnkAhBow/sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11343.eurprd04.prod.outlook.com (2603:10a6:e10:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:58:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 15:58:47 +0000
Date: Thu, 5 Feb 2026 10:58:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 4/5] i3c: mipi-i3c-hci-pci: Add optional ability to
 manage child runtime PM
Message-ID: <aYS-MBN5J6PrKI8s@lizhi-Precision-Tower-5810>
References: <20260205100915.19792-1-adrian.hunter@intel.com>
 <20260205100915.19792-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205100915.19792-5-adrian.hunter@intel.com>
X-ClientProxiedBy: PH7P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d7c20e-b801-4f0a-f9fc-08de64cf725c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gr8baF5rbFeqJi6ZAnQf9KlW1OSrcKiLXSiNq7mRi6EcIN286JTAlQD3h/U1?=
 =?us-ascii?Q?ef4LiVzs3D/7xBpkYSLN+UbPpERmYPyyE8pWc2HHchpxdJ3QaUPhxWb+nKuH?=
 =?us-ascii?Q?ncrqsQcT0Ih/hDQJmfqwm0FVxM0E0WyAaNSFJYM96tYGb8eyIxWExUtflj1P?=
 =?us-ascii?Q?BG00GecZEyYVrFo98apRfgeYLbQHhWniUsqlmYOyRuE41Tje6LnKlAUZugaC?=
 =?us-ascii?Q?6vdfJxIbUOWlIW5w69gR7c5WvoP0u26Ow+63gRXVV8Pob4G3WGJdnM5M1/nY?=
 =?us-ascii?Q?BCSE26nlBcYUrX26SjhEiHTPUBuB3O3r/iqNnYiBOTOlmkrlBGBmEVuRtIwk?=
 =?us-ascii?Q?5LQ2OVREoLXDfG0j8IWm1UpP5d81k5Xtw29CN4Dfkfy/OiHF8oRSsj+B+ZEN?=
 =?us-ascii?Q?hd9KWL/1n3QCbp06v/nildQ3eUJXK4OzrAnvysEwLiqTaDW4cl4pKVtqEfd3?=
 =?us-ascii?Q?SyHlkRiSBdaEOiGq+NjNgvrW89MvIKbcmN45j0SQFhhLWbCfaN9+xFqsxxQD?=
 =?us-ascii?Q?F1cj0RDElXBT0SNq4Kx2e6bK5xwAgJ8zwBfO4BkcllRkkSugFU4/tNRPUR4A?=
 =?us-ascii?Q?CGjp0rQMAOxp6Uc1SyMbfuK3EfLycRMps0Xo7wtBDxWCh67OSPs7etvNSv7r?=
 =?us-ascii?Q?yKz0QKuIdSu69i8wSXkWvc11BIbQs3jmxY7s+/BJuhzi9ktU0Tz/AxMcRbY4?=
 =?us-ascii?Q?1UXsNcaz0w1AHjwHcrupOzeP+sE2AEGFT3DZK3vDZ0lC9WeHTpzHlIAQJXME?=
 =?us-ascii?Q?H5RPckOfjvrdZ3QACIQDGytTNZVSOBgMDZVdul8zdV19BrKN8vgtyDY9EpIz?=
 =?us-ascii?Q?RqRuA0hZc7G6HnIKFjbQOX6b2sLRByI4Zz0qkjIsL8l3WJBSV1HIqoj9cOfT?=
 =?us-ascii?Q?+CZUyTnkG1t9/1zIv7b0F/UJhXaD+Z2nkZ0aMs3hmg8hlhkfPXa8fnlYEK5h?=
 =?us-ascii?Q?pn2s3B0J3oOHO9vfYZDsIfx4MZYgDU2Px5mLXG44Mv15iTmdQEkrYk2XegWx?=
 =?us-ascii?Q?B0G9MjCBgKLWDxKmblRQoE99HFh67Q87BVMERBQfG9zB6IrY+PfqApHvkLsO?=
 =?us-ascii?Q?S5oO9A42iWTb0VOet3obY0pSgaF0CjTW/OCpN2jWzBNLcl4g6G3rGQC7yr6u?=
 =?us-ascii?Q?HQERkYWPwioTZMJGrAxcdkFUM1ZgBzupRw8b6CwKBUXkETVyrvIvzwZdnM7y?=
 =?us-ascii?Q?9Sh0Q6otFk6qHGIxpGuFk44Id1NSzo9ZkVZ0yBcRtIEeMTxW2IvsABGUh4+9?=
 =?us-ascii?Q?1lCw+yBM+IDHT2u442KofrpjZpRx5UaQODwqrjAskOOJ7a5jYos8EaVev0IS?=
 =?us-ascii?Q?m15LyK2tR6vo52lBpC8vQoa03q6A61HeIpkOVxTxGIK1jWrF+Om85iYG2r4r?=
 =?us-ascii?Q?rwAWiAQMFF89dz275Fsqx2wm3cZF9ANuMwzs87IVZt5YpixZJazkgSNusTvP?=
 =?us-ascii?Q?YSzVpdUU6gcAxumpelnNRJguueLVmib8MZ+tpUE5M9BpQwUPTY1fR2YMLhNE?=
 =?us-ascii?Q?XlFWjsRw7E+geTx0Mt6YlcvHqPKUaXk5O9+4ZOO3Yq0QELOrbYZVPkcQ0RDj?=
 =?us-ascii?Q?hwIgQ3dV7M2XLR/C2osEBCHrCEEfCjxTcJ6L3DASIhrhaf7RNdHPaKgW2gj4?=
 =?us-ascii?Q?qlr3LjMwZu6g1MV/6Qaws+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJEzAKiuv5Vocch/nwMHN7anYUfbJ9W2dtFi558307TleXzj+BqGaT7MGiwo?=
 =?us-ascii?Q?S+0hCdiEoJQmVFR8gu39nAIgH+3RKJBRUi208ddRZ6287whL/WKpXwlY0q+a?=
 =?us-ascii?Q?KIRTrmia7n+9Ij535LrEixVyEaLLx/WZYUKZvxU8FTtP354NRgI+0cYby5Cr?=
 =?us-ascii?Q?uaj3KvDZkS2aImXWLmWAbKuH9FbSelhvQz/J2ASMpld5M612RAvvauf/JgEM?=
 =?us-ascii?Q?DxQgGol7c4S2HP9apmCA6Oxlzrq8lz4Hbxirgr0FFJpfQEAy0sFWUZ2JVFTC?=
 =?us-ascii?Q?FyIAu6nibNgKwEQvyACl92ts+QxcSV1Rbu/ACE95HmniqhkTIwpYcPavuHHq?=
 =?us-ascii?Q?dMhOzK9OmCvc0umrzAsheFjDXU9Mcx93pbE9QiJ/XyzwQVwaKvjsFR0PBOvs?=
 =?us-ascii?Q?ePUHoXplIJORAEAI1MWjnLBzfgPE/p7asMEy9GbEHUg3caFhtc7kcQpdXfJr?=
 =?us-ascii?Q?bdoP+V8cV1gJE2TxGnsRvaqHl+VArWDXVE8aQ22AVRdtAFHa3+fsFq/DFXeP?=
 =?us-ascii?Q?InMGaPZ6roEfIVwybA8YyaH3hwrzgAB9Nfw4yGI6eiQ8sn7Dx9rDqAk753go?=
 =?us-ascii?Q?E93ZjpbEHyk/8bFujmVlt79lUvJ5ZPPe8GKHaisYpS/J8yTYVFPb6rflih29?=
 =?us-ascii?Q?m2Vq/hi3jEHLsaIGGs3lgIkzQfv6rNsDRogxHTyZiHXwKEdu5NapmrlWb3Hs?=
 =?us-ascii?Q?sDGt9xmVQuGZVbDYWJkT6IJgfDUNzzUVpIn/o2SH3zIHa+xJAh7OezDE7nzd?=
 =?us-ascii?Q?xq9PuPoB5BxHKvp7D8sRtUEPGtajJkJPGhPaVAM7pLBvZo+Irt3GQeFLl+l4?=
 =?us-ascii?Q?ORD4M1N4CfX514UMZKirN9sbB3hLnF5tDN1PoNcqb0Q5zht2xpJ739OoP6gI?=
 =?us-ascii?Q?zMY0h7acI1mhbwrjxmNeEfbKRmuX1mHvxUAFjSZRmYS/K6jjvIa4M7DBsDsI?=
 =?us-ascii?Q?KFyQUBdAxWUKNyKAkPTv/QWFACqCqU9Pg/35xFc+JqPjq9fsgr3ze2M1MsXl?=
 =?us-ascii?Q?ZSbUdc6HNDBroSagxf1sjEAM5j1TZNUM6BrEBT6AcztQh03SrbqSixHPoi9H?=
 =?us-ascii?Q?PAppnmm7ZJaRj2BXncomqJvtZcJK/aWXHDQTh60riTzzMf9O/19YewOOSP7w?=
 =?us-ascii?Q?PeeFgg4RYkvrSHi6fQgLrNSsgc5inZYIHeh9kjlM6PUvexFu8e5W5D/Fub9s?=
 =?us-ascii?Q?UeAO9UnQep9l5kLhM9aE9ZQOJ9gjqnmn1gU1lai1Qi7rere2zMmXze3rjC3I?=
 =?us-ascii?Q?ncG7UAjcDW1NRp/oaOwA9CF1GaIpG22hae6jtQ0PzT9juF98KsXwp5QS3kbC?=
 =?us-ascii?Q?gJOm5sZ6WB7HFpGrhUUHbz3To4elbpdoE50Np1vfJTIXTmLVMbgZqoDbxnuO?=
 =?us-ascii?Q?Yzh5mvcL/t2/8DSK+LExgs0RsF48YUPsDqWATmpaRLurYSe3Z+kd0ux/Lka4?=
 =?us-ascii?Q?0XXBDz2Uo6/5gH9GKjFA/+vW/yq9D2QrRgL90DYbv/ZuLBOp7yMvwQoM2K5x?=
 =?us-ascii?Q?SI/sxce7YzJ38QWDqsZNDupK4ejLJQFWcGG2q9NO0/wikQ0wB1iaA65IBrtU?=
 =?us-ascii?Q?czBUGAZaZTIaDun8J8aNh4XKrwOMVJ8xLjMXUD2yWnAv8uNObliq0/4oBnYi?=
 =?us-ascii?Q?KXvY3zTn4RMGWoHFW7O0725xzATObiAqtqCyP+qXV7x63dJWlPv/h6EPMIUW?=
 =?us-ascii?Q?scyPzuQNuYF98VF+8+4J5+0KFaqj4jA3upvKaW4SINhuL9BQShvTpn5WlmQy?=
 =?us-ascii?Q?edUlxSu5ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d7c20e-b801-4f0a-f9fc-08de64cf725c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:58:47.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6fSRTSh0aDI2dwkFDE3hEyJ2nHraLvRhJPdaFTnJuSflarfdL4hRF/uZqnqgFoZ4IrXfuNKLh1rSUxI2igk5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11343
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42160-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 38EDFF4E32
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:09:14PM +0200, Adrian Hunter wrote:
> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> where a single parent device hosts multiple I3C controller instances.  In
> such designs, the parent - not the individual child instances - may need to
> coordinate runtime PM so that all controllers runtime PM callbacks are
> invoked in a controlled and synchronized manner.
>
> For example, if the parent enables IBI-wakeup when transitioning into a
> low-power state, every bus instance must remain able to receive IBIs up
> until that point.  This requires deferring the individual controllers'
> runtime suspend callbacks (which disable bus activity) until the parent
> decides it is safe for all instances to suspend together.
>
> To support this usage model:
>
>   * Add runtime PM and system PM callbacks in the PCI driver to invoke
>     the mipi-i3c-hci driver's runtime PM callbacks for each instance.
>
>   * Introduce a driver-data flag, control_instance_pm, which opts into
>     the new parent-managed PM behaviour.
>
>   * Ensure the callbacks are only used when the corresponding instance is
>     operational at suspend time.  This is reliable because the operational
>     state cannot change while the parent device is undergoing a PM
>     transition, and PCI always performs a runtime resume before system
>     suspend on current configurations, so that suspend and resume alternate
>     irrespective of whether it is runtime or system PM.
>
> By that means, parent-managed runtime PM coordination for multi-instance
> MIPI I3C HCI PCI devices is provided without altering existing behaviour on
> platforms that do not require it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>
> Changes in V3:
>
> 	Remove unnecessary pm_runtime_mark_last_busy()
>
> Changes in V2:
>
> 	Do not enable autosuspend.
> 	Callbacks for parent-managed invocation were renamed
> 	from i3c_hci_runtime_suspend to i3c_hci_rpm_suspend and
> 	from i3c_hci_runtime_resume to i3c_hci_rpm_resume.
> 	Amend commit message slightly.
>
>
>  .../master/mipi-i3c-hci/mipi-i3c-hci-pci.c    | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index bc83caad4197..ed0efed17726 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> @@ -9,6 +9,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
> +#include <linux/i3c/master.h>
>  #include <linux/idr.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> @@ -20,16 +21,24 @@
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
>
> +#include "hci.h"
> +
>  /*
>   * There can up to 15 instances, but implementations have at most 2 at this
>   * time.
>   */
>  #define INST_MAX 2
>
> +struct mipi_i3c_hci_pci_instance {
> +	struct device *dev;
> +	bool operational;
> +};
> +
>  struct mipi_i3c_hci_pci {
>  	struct pci_dev *pci;
>  	void __iomem *base;
>  	const struct mipi_i3c_hci_pci_info *info;
> +	struct mipi_i3c_hci_pci_instance instance[INST_MAX];
>  	void *private;
>  };
>
> @@ -40,6 +49,7 @@ struct mipi_i3c_hci_pci_info {
>  	int id[INST_MAX];
>  	u32 instance_offset[INST_MAX];
>  	int instance_count;
> +	bool control_instance_pm;
>  };
>
>  #define INTEL_PRIV_OFFSET		0x2b0
> @@ -210,6 +220,125 @@ static const struct mipi_i3c_hci_pci_info intel_si_2_info = {
>  	.instance_count = 1,
>  };
>
> +static int mipi_i3c_hci_pci_find_instance(struct mipi_i3c_hci_pci *hci, struct device *dev)
> +{
> +	for (int i = 0; i < INST_MAX; i++) {
> +		if (!hci->instance[i].dev)
> +			hci->instance[i].dev = dev;
> +		if (hci->instance[i].dev == dev)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +#define HC_CONTROL			0x04
> +#define HC_CONTROL_BUS_ENABLE		BIT(31)
> +
> +static bool __mipi_i3c_hci_pci_is_operational(struct device *dev)
> +{
> +	const struct mipi_i3c_hci_platform_data *pdata = dev->platform_data;
> +	u32 hc_control = readl(pdata->base_regs + HC_CONTROL);
> +
> +	return hc_control & HC_CONTROL_BUS_ENABLE;
> +}
> +
> +static bool mipi_i3c_hci_pci_is_operational(struct device *dev, bool update)
> +{
> +	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev->parent);
> +	int pos = mipi_i3c_hci_pci_find_instance(hci, dev);
> +
> +	if (pos < 0) {
> +		dev_err(dev, "%s: I3C instance not found\n", __func__);
> +		return false;
> +	}
> +
> +	if (update)
> +		hci->instance[pos].operational = __mipi_i3c_hci_pci_is_operational(dev);
> +
> +	return hci->instance[pos].operational;
> +}
> +
> +struct mipi_i3c_hci_pci_pm_data {
> +	struct device *dev[INST_MAX];
> +	int dev_cnt;
> +};
> +
> +static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
> +{
> +	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
> +}
> +
> +static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *data)
> +{
> +	struct mipi_i3c_hci_pci_pm_data *pm_data = data;
> +	int ret;
> +
> +	if (!mipi_i3c_hci_pci_is_mfd(dev) ||
> +	    !mipi_i3c_hci_pci_is_operational(dev, true))
> +		return 0;
> +
> +	ret = i3c_hci_rpm_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_data->dev[pm_data->dev_cnt++] = dev;
> +
> +	return 0;
> +}
> +
> +static int mipi_i3c_hci_pci_resume_instance(struct device *dev, void *data)
> +{
> +	struct mipi_i3c_hci_pci_pm_data *pm_data = data;
> +	int ret;
> +
> +	if (!mipi_i3c_hci_pci_is_mfd(dev) ||
> +	    !mipi_i3c_hci_pci_is_operational(dev, false))
> +		return 0;
> +
> +	ret = i3c_hci_rpm_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_data->dev[pm_data->dev_cnt++] = dev;
> +
> +	return 0;
> +}
> +
> +static int mipi_i3c_hci_pci_suspend(struct device *dev)
> +{
> +	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
> +	struct mipi_i3c_hci_pci_pm_data pm_data = {};
> +	int ret;
> +
> +	if (!hci->info->control_instance_pm)
> +		return 0;
> +
> +	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
> +	if (ret)
> +		for (int i = 0; i < pm_data.dev_cnt; i++)
> +			i3c_hci_rpm_resume(pm_data.dev[i]);
> +
> +	return ret;
> +}
> +
> +static int mipi_i3c_hci_pci_resume(struct device *dev)
> +{
> +	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
> +	struct mipi_i3c_hci_pci_pm_data pm_data = {};
> +	int ret;
> +
> +	if (!hci->info->control_instance_pm)
> +		return 0;
> +
> +	ret = device_for_each_child(dev, &pm_data, mipi_i3c_hci_pci_resume_instance);
> +	if (ret)
> +		for (int i = 0; i < pm_data.dev_cnt; i++)
> +			i3c_hci_rpm_suspend(pm_data.dev[i]);
> +
> +	return ret;
> +}
> +
>  static void mipi_i3c_hci_pci_rpm_allow(struct device *dev)
>  {
>  	pm_runtime_put(dev);
> @@ -323,6 +452,8 @@ static void mipi_i3c_hci_pci_remove(struct pci_dev *pci)
>
>  /* PM ops must exist for PCI to put a device to a low power state */
>  static const struct dev_pm_ops mipi_i3c_hci_pci_pm_ops = {
> +	RUNTIME_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume)
>  };
>
>  static const struct pci_device_id mipi_i3c_hci_pci_devices[] = {
> --
> 2.51.0
>

