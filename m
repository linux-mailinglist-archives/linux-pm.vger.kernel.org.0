Return-Path: <linux-pm+bounces-41886-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP1jCi9XgGkd6gIAu9opvQ
	(envelope-from <linux-pm+bounces-41886-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:50:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92861C9530
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9209301DBA4
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753322BDC10;
	Mon,  2 Feb 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jrR+VgUN"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB4347DD;
	Mon,  2 Feb 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018378; cv=fail; b=KelzOgxuSyWufbDvX6YzmbfloMb7jOmXF5MJ7jKvLz+eEb1I6g79vG0X0UOb7HregJ64tNKDKa8cgyOXAbmclLbK/4T4PrHyq3vAFlckAbZkz+QXHu4Regqxv20aGQT+aHppKWE8bxNLmnB7MKiPWT7RFs71uYT5+nGPbcTgLfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018378; c=relaxed/simple;
	bh=a1SmMMEsMhBRC8wq47T4+prd/FoB2wEEQNQUp/cfgyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhaK3pkbRCdSHZUpdVx1H1kOMVriiWtuuNTHy4iJuzCsziTIyS+0pcoM6WTpeyZMAnZcuUIltRrj9wqbtpU0uHVH1oWTqn0JS7Yku/lTaUpf3Ec9bVrEhwkqyYIqiKvHhapBcdFv7ptFFa3F/EdojPzP9ZaMgnPMazWFA1roA/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jrR+VgUN; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGEAXqyBeGS2Nz5jxRYuSbEyMs0SGt58yO7ekuYcJOxJgPcSTVNH17NjWq/WQwZtwrMlQbPek+UfjsRI7a5JXD3vliogMLQw0UFWrgTTbGH7zA3aPvgPkpF/0bRg4XTfEhif9INpifAcBO5sn7EPsZZh1hRLA7ZgYGmJAXs1+aKsoeJuk6EVsUREM0i9wvwOOZQShTGD2ihTvm+DwFU3Ynej34lQ21yxlLZpC+GYGJAT7hsdc9i1RpR3TFz10H4/qlFmdSgNaZ4zbfZUaNUvU0KFIoLWG1xvkBmy+WGqWjWcz8oDpbUs8cOGbWTWe5dI6Aw199FOUTBetlnZ/eCOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vsi6X+3dGi7+rOoZweAzike4OJHQn7C/jJqO6qmuCA=;
 b=QUtWOIH7DbslECuftI/DFht5tOzIIjWsoeuR5pxwfXQqLl+3tPmEEMOvghsKjmChBLjfvDA9v3Wt9K57JzYDpdApwZJn5hOIimiq1oOa1+VuxcAec/imubHSvrbl8NEyUFhVrBDuG6+1X9q0TNKqJ6c7OU2UdG3VkEzD4XXfkSOjeVL6yedPuP+gQkvfErV9eOnUEeB1VPa5ISCko2o431X04hkxQAdReiKQ/EXGP2nTIoM2cje03/qiy7MMGGHI7PF+Cxuo7Zk9g2rXQhk8Ao8xsxV5oGXjiuhXL2CuhLoVsrokSt9jkqDu5c9LjEG9ab8euCe5rP7h+z2wB5UnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vsi6X+3dGi7+rOoZweAzike4OJHQn7C/jJqO6qmuCA=;
 b=jrR+VgUNxwxRdpwRVcrEMbpATeGkY8LoC1PN9JqidHkUY4kdqVjzLEme466QhcSKYq4borI64LErcf+9tQDatt9cBfdcR1rOlZgI3ldQ6LzTsGZEqu5WU62+3L8ppfWPqjXlEA36yCGyxWjIa1UMLdpcvf/WGXwlRuoDu3TWVv+DkRtRY+oBIW27VVYprxJ/Kr4RCCVZmWVAoTghLbJnvnmVhBySmiL23t49pPol+E/mtow2W/p1I68ERGE3YE11emXAaSXycTtQIpIdaUbjz2E3nwSAcnalkd1uy1XTkssRqCRG9Zo8CVMMVcMTtz/7mqT+nmsJr8Y+wb0RB6BUdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 2 Feb
 2026 07:46:13 +0000
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::49d0:5fa7:d131:7781]) by AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::49d0:5fa7:d131:7781%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:46:13 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: ulf.hansson@linaro.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jun.li@nxp.com,
	rafael.j.wysocki@intel.com,
	a.fatoum@pengutronix.de,
	ping.bai@nxp.com,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: imx: gpcv2: keep usb phy power domain on for wakeup
Date: Mon,  2 Feb 2026 15:47:30 +0800
Message-Id: <20260202074730.738760-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202074730.738760-1-xu.yang_2@nxp.com>
References: <20260202074730.738760-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8825:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: edfbe20f-c01f-42ef-7238-08de622f2210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPfLnR7pjKYefl4i4lVkYatdp4MJsh67ZM9GAiJ8RL/lQPKGYPs0ZxRLNJpG?=
 =?us-ascii?Q?tutWy+hrQv0hHSgr1e000Vv7sfwAvIfMU4pgX611hhuD55XMjeJdahqPAlwI?=
 =?us-ascii?Q?RR5zCobU2f54ZR5HhtlWP0eW7/S8g7Cvor7W22JBIoKl6Lszs8B71RSWGBos?=
 =?us-ascii?Q?Pz4IqYJBQrZwfrf6cjTwVwQU/bXW5s1wg2jwOI1nI8nG+WDeK9DVE/tt1nvn?=
 =?us-ascii?Q?tmV9P9Ef8fyil1wW3hUpbT7SZz5aRuRVThJooPTGJx/znI4CqnwU6kQ3n1jQ?=
 =?us-ascii?Q?7cl5AM9mtQHbN/K4eHB5RJ71fcAje0oiYqU2zt1s4HM5PGAu0JUVufg8Vd6m?=
 =?us-ascii?Q?UjRNMwZt/fXn6H7jRnNcuqgmGqkSttbZ29bFS8JzbBz8DqJBq8Khk9Tz8KNB?=
 =?us-ascii?Q?XFyT56MB4LMksq51P2Y/8RHZXAQjacO8O1jWY3Q0ylwQFi6VMVmpVmd13yNv?=
 =?us-ascii?Q?MHdDXe+jy0AF+UpAVq2y4JOBqO14roYiYFtl7Lvr5U7s9xwL/MTBM5+LCGN/?=
 =?us-ascii?Q?pBofLcJhbrSBkX0PCsjeCTHKE+qipp0f/3fZITVLPP1xH3a8NJOVIgHbneEy?=
 =?us-ascii?Q?Hra4q+3b2X5gYOgwh/mnCi/PFN4/pduD+umR+t/NxeXzhJiPT350cAf0cFJA?=
 =?us-ascii?Q?e8yTi98IP+iNazj9oObJcF7smIs/KKxI9/ASxrK7LGFE7StYMyBwVxf6iCbw?=
 =?us-ascii?Q?fUjJM828QpXfqD1VOLbW3P8+NrmYolDhSkUlM8w/xy1kdwfcbe5GiE3coKkx?=
 =?us-ascii?Q?Ndt36HzN/rJrLQgZJw4CtmAV1C0eGS7T2knEUiAoMghcCQgFB+e+M6N3b1Jp?=
 =?us-ascii?Q?9nBDAoxkafg3H1wkl2RhBbjXR4p2dZGahfhMm2f6ZqaTKU/zrWsB+6i23mJp?=
 =?us-ascii?Q?tZyfos1rRsUfUIIfHC64J8C3+RcIOM3OKv63QHohRRWqOHKNntjKWaHgCveP?=
 =?us-ascii?Q?oqdzWNqAKqccuO6I3/czZ0qaFp4d7gAwzvjOA8UmsRtprFcGmj/nOZMi+dKE?=
 =?us-ascii?Q?Syc4UmWmIKgY6Lz+LzbxONaMEORcJVSSu1xixMQ5MANlPEvrmg+eTfA7cOzJ?=
 =?us-ascii?Q?IE5PlEjSF9yEvURq9V9N5XF+krfWp0cIghpwFldnubX12QcbJsfNhzI6kZu8?=
 =?us-ascii?Q?yWkrL5uX5HIZGoOn8R64aXALNvA25xK1Ra+H0Ihgb2nKpFY1dmybqn/q/pX2?=
 =?us-ascii?Q?ubt1ekgY3qnSEyv4OLIo3u+shiHP+InEQW07r8LD74wz04QDKYi0WrMNB6Ea?=
 =?us-ascii?Q?zfZHvNVbG++we5ps8TsKP13qX6QnD21cmwtPDoAAc495lF3ChPgJvBySrrOZ?=
 =?us-ascii?Q?GGePe+x0YnVjciJctoAoPoWgZIkjE0fI89FDzqe/EtyoBxaE6A1NM/gb1yqF?=
 =?us-ascii?Q?udM1FYwjEoIbQGflSGFxzPyAjL6xbcpIDIrIQmg9NZ2rYM5+9AUWpLExV6Dz?=
 =?us-ascii?Q?JDSjBC9c7St8Ju6CbtY3B6I7NHTgqIp/BKVvKA6ySxrgNf3gbizT8oUJ8jCw?=
 =?us-ascii?Q?ALUGb0FuiDEcr5KHoKDfSL2vxPonUFuFIuYqLnmJxqM/q4Vc/3v7JgqaLBpt?=
 =?us-ascii?Q?6D4PFkyqk+0qtq1w0OFmjY0wuYKWQDo5LmCHmAf4HYeZ/CKaVoTlYvRKkfgS?=
 =?us-ascii?Q?QHYE9IdZYwQ42OFHxfQ5qhDg0tCzzGPjUQqoqRHF/VIU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8825.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yIrZy3+jJZ4gC8jg4+kOvxPpDUUNdeiVSXokjvGmOzTsdHmIIncqEW/DgroZ?=
 =?us-ascii?Q?YwKCuJNkGewUzM512K613sKFUQdI123dxQ9COtiv3HoBO9EZ16duVpIFJVJv?=
 =?us-ascii?Q?0QSQIRFpFkzi9Crr7o9AT75QMbnE/xpCg/Aj5syYk5osrcZqlwyCDTC5WO6w?=
 =?us-ascii?Q?3Lzv2OoupFNuWl4lp3A1z5/1Q9xkEbEmIOeib4OTL7FzdrGlC6XW3VWrlCjo?=
 =?us-ascii?Q?a8ALy2luXgu6j0TU4yjfxbVvcUXHayfrvDTwgVEzdwc3EOZ6XfSlDl28Y0T3?=
 =?us-ascii?Q?P+eXoVs52vLEAKP1tUlPWuXl2iiN7AnPwLfyXUTD7HEbgVCM5SuSsKTUUCJ4?=
 =?us-ascii?Q?zAwl5coei78JZF9JOhQr2pHSwGiWsibWTrI/aC4zSYDkE7sbDm9Xtx4zVnNI?=
 =?us-ascii?Q?MSs9Wv6ZlpZgFMd3n0eacu7kBf9qhTyQV6+gO6UoL7yKHKML+twt0WwBUnTo?=
 =?us-ascii?Q?4QXtOgFiELpQs+BhmnZBQQBcZilL3eNNCgU/4rrdEW5RUoJzIH+7cEuhsBDL?=
 =?us-ascii?Q?rvRC88IOlPVjWkvb2ahQV/Saa4Ep9LApt4XVviYJ5TR6LmvZof8U5mWU3f99?=
 =?us-ascii?Q?4yE/ZZAcpeCqQPod5Z2Lh88+VjYuvYQaA9cf827lx8OPtur0UEGdzg4kBxZi?=
 =?us-ascii?Q?eNgUVTphMqhv7XcJka/6AYMhexMQLh8VeVs8JP3VvUdwi70R4SR5mysmxhyO?=
 =?us-ascii?Q?h3TtNsbrTG5BAwPiOaJ5KD+Am6lhr0nPKLZI/m9wp58Z8miOsf4/SCePQ9QH?=
 =?us-ascii?Q?uK/myoOsPq0XeBqq7WhM+P7CkuRazLPRB50tKAofWfPOrnvtPvEfL5Qrd4R+?=
 =?us-ascii?Q?6J5Q0c+iyT82qp03thIiQQGkhDIePf/E8cdoJV0/qhPxHaueTygfMQJlenWh?=
 =?us-ascii?Q?b21Ply62Qdhd39KpKJzGG0KS1mZBBV+x+UX1sD8NTBZnY13D+KfjCI6qWZR7?=
 =?us-ascii?Q?hmok7tndRyaptMSmM5zQx9xPcvhS035ZVR13DbiosGtrd+oU6Gw9Fid6GLCY?=
 =?us-ascii?Q?ZGk+rA7RYOwe+6XglZYU/FYbGvgrlMlgXaN4s1AsPulyaoSc0Pir1UGGf7eJ?=
 =?us-ascii?Q?hZcCTUVTI/QtA1DYnBTGleZEBv/JPFvfvfnDchn4Zaz9NWTIwDyqw9wnAGg/?=
 =?us-ascii?Q?Dj4WcDNMOtwOIbo5pteRvGoKaPngssEViYEP+JB4PUtw9L5LVZvyIOCO+Y4D?=
 =?us-ascii?Q?mXNEfZMKWBf25yTOTAzm7V2IZ+bZUM8G+BEePHod9/CZ4lRQDif44X5OZazm?=
 =?us-ascii?Q?i3kP9dh7Ln75+M9rC7n3eWYK0ijA3e0tjIp9Yt1iQR6eNMP2DZho2umxkWLT?=
 =?us-ascii?Q?/8OrQOZzlwoe/jBT0vDi3jAGXLF6BcbWvydPes4L4eKlzTLUn4b6UaLBIicp?=
 =?us-ascii?Q?nCnmiDJUBOj2sw+qL3uXJkF8EPVW9k5B8ubfR08rUWrD4kfiKVCk+ixlb2rj?=
 =?us-ascii?Q?pI1Kxyy0Dh3HfhWoKA8suJVo+DZi9+ZBZMsMjEy/PEoTxxuzZxJJvys8iHTj?=
 =?us-ascii?Q?OT1TVNneuz2C0yFzwzmKwKn0uwN4MvYgs6smHYpi2Y97K9d7+XeEzkDsrwDR?=
 =?us-ascii?Q?6q6ZvodyKNTWtX0EnDMvrE/DALMAiubcyveZP3rUzdsXmrBmI4Rh/lxuOek0?=
 =?us-ascii?Q?EeH1UmLIXToCL2Q5G9osDpHyFubJzSlaHd/oDHKVxAn66QL4bKYYllTIpG3b?=
 =?us-ascii?Q?UKgJVshWmWSymaGSOQM715l5A8XkGbZVHkwx0koHiNl2b0xcKThH/Xhni/ns?=
 =?us-ascii?Q?lVK/4Mq+rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfbe20f-c01f-42ef-7238-08de622f2210
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8825.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:46:13.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HF1GwLSMYSDJ/JjlkLyAHEZRxlfxJeZPpsQ3I56fG/ze0fgPXuZQpUrR/WHcOT/g+yrwOE4LDowDMSidiqJOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41886-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[linaro.org,nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 92861C9530
X-Rspamd-Action: no action

USB remote wakeup need its PHY on, so add USB PHY power domain
on active flag.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/pmdomain/imx/gpcv2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index a829f8da5be7..5c66ee0a3731 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -953,6 +953,7 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 	[IMX8MP_POWER_DOMAIN_USB1_PHY] = {
 		.genpd = {
 			.name = "usb-otg1",
+			.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 		},
 		.bits = {
 			.pxx = IMX8MP_USB1_PHY_Pxx_REQ,
@@ -964,6 +965,7 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 	[IMX8MP_POWER_DOMAIN_USB2_PHY] = {
 		.genpd = {
 			.name = "usb-otg2",
+			.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 		},
 		.bits = {
 			.pxx = IMX8MP_USB2_PHY_Pxx_REQ,
-- 
2.34.1


