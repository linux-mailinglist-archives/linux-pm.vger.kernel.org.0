Return-Path: <linux-pm+bounces-41282-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMSROFnncWkONAAAu9opvQ
	(envelope-from <linux-pm+bounces-41282-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 10:01:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E9663B00
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F5945E5AF3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA69449EB4;
	Thu, 22 Jan 2026 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oRalSUcW"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4F38B9AE;
	Thu, 22 Jan 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071916; cv=fail; b=l0kh45L0Uo4NVbe6eew0K0dc2nQq1WGeylZ9Rfl2xFlVldfyfhlcFPh5SjH4fLD3/mQHmDxzeLhVd7N3nEIu9xmDIEbbtckgfXvpmM44ngcjy3F5JAyeiVguI7F6oPIhYs1h6Gm8BOCOpZQefYR/PvdRN5yD4de6igWUGTI0MhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071916; c=relaxed/simple;
	bh=GxM5bQDuleaSNlFxNQTRz2XqjlMGeGZsbiJfKxNj+nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8/lu3CvR1H/8yh2L0sEfvaMZ7lyHqjdz4gQXmBeybwrBqPa8xqmREjT/JwvyUKI/6EI0CHJ2KDfXIKiF1SMFAgKq1QG3DZqj+G8V54Cdsmmjw09nHSeRcMiKdoLR77GPAmHXFMRUbV1JiF7NZFCls1W3axZGHX/b8I6DgoYbvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oRalSUcW; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp2+1gitY9m68oT+57uuMDYm92OQs8ze3VWp4coP/S6aPhuYtcZz2xQUIAZjlPfHP6M4tPbvX0UP+1yrmivmAH2LyZLDs1fRNsXLTXdMhm+S2fNRD2+EF1krz2t5JF79Pvg/Ub/thySS75OmGivRxJr4Dx9ULofAzATsSohzhy6IrhoKaa9UiPqrrfQ9uJxBxRv0cq4BW8pIRMggGz/OaV9lU7a3r+7o6fLxbW/JZhjdBzIvMsgqJEJA0Nz89dF1N0ZvzvqotJzzDf5VtwfS4Dxe4Uu0exaZJaRE6i4VaUdqw9mHDWFw2Z2IT9WsP5boHS5372tyEqYlrnjH21A2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxM5bQDuleaSNlFxNQTRz2XqjlMGeGZsbiJfKxNj+nU=;
 b=YVHaHZtgb6FbRIEYDvKiUX05Hu+2ShSDRFhScvmtRRC5Ctq1C4dAp0bQBQE7Sum4rZYak8zRjHY/52IqYBY5Abbl8QPbFYmI3qe60592IZE/LM5cpcyQuCc0PxbyZy3TtHIcpTLNX9lpFdT9cqTposkOpwdqB62Hek2R+OdRo2dFrwWT6p1+2Lw9l+X/JeRUYPFrapHkd/vTIW0PtU9pWP2Ydk2yjpyr0XK8kfZPOlMmzKz/0ILZJ8n/io138dVB36ZA9DIR3I9KxnxZwvzkQob41msasu1TLWO6z+ANiNnZ5zF/E9XJsjh1aeHb9wAf6B2yF+4P2miq/FlXHw17AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxM5bQDuleaSNlFxNQTRz2XqjlMGeGZsbiJfKxNj+nU=;
 b=oRalSUcWV4//wuohuNh9AKY0l3zHtAoZZrpISRQo8mreEjcjrQEeD8OPnR8ZvRnGZAE697+624/br1c2P+i9Jjxf9FqUqEl7Vo5ONveSudtHWFqh9jxjjGKzWiF0xzggJv/msPqqFdISshlk+QcyEUSP6x0GPqQ3EFKAuSW/am/IORLIypniGKJdNwxQ0GLMOJn4hWjY2N0BgJpfpUTpl0vDdOUlRAMGOn2F4yzBjI8YYwid8jgMz8A1X5+fbSsoRtsDdXDmR7/6e9ONz2p0L6lDt8O9WAJh4S8/iZLfDE3A2Z0IJxLq7+agMmxX6834+HkC224HQf4iGdtZgo+log==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB8003.eurprd04.prod.outlook.com (2603:10a6:20b:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 08:51:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 08:51:50 +0000
Date: Thu, 22 Jan 2026 16:51:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: imx: scu-pd: Fix device_node reference leak in
 imx_sc_pd_get_console_rsrc()
Message-ID: <aXHlHM+iINxFnDiU@shlinux89>
References: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: a28e95db-2149-4269-d2cb-08de59937b73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFcGZJprOKYPIWZWsO0DqRKeZpZm5ocnUZeE9cV12+/sgLXqO3G0WZLQGF16?=
 =?us-ascii?Q?0hSRaxZmyR8MQ7/Rj97OqAsvAKnM0++J9fYNhupWcWfjNxX4LZuhea9mZIAK?=
 =?us-ascii?Q?nflxhNykMrHbVkJKHUD70KQ6lQIW6geAmyKnIXEtGQbp15wqIxG3EQ3zuTpI?=
 =?us-ascii?Q?GlcL/oasKAT9uzYqrOsbJHKtnPRPL759TjbYkmQAIOr3yM9+omGJbEiiOA+1?=
 =?us-ascii?Q?wMoD/m3rhsRvEpdZIZ0qgiYAJ/3csyXg5goREiDg2IaSeLg7mCgfkrqkkccw?=
 =?us-ascii?Q?tsYwfW6YtE4RVl0G1CydU5mnhN3UDggWB96ZzxiZTHivjzOwJn2cv2n6WjQV?=
 =?us-ascii?Q?2Byy2Z1SKwt6MstIXMiyQuv7hOwEWmbciHzW64Esj2eA/IMtzC746rnsdcdA?=
 =?us-ascii?Q?f0D4W/45mJFBxxPLDVUmJYRHnushAXtrH8kDyzZlo4J3iL2z4xYgMgdQM781?=
 =?us-ascii?Q?sHZrdP8ZCaqau1c1k/zDQqcvHHzrDdazXQxpJ7dEKD9dKT3Jml326iXLnTHW?=
 =?us-ascii?Q?e0XrRdy8YAID62m74nm+04c56it1nz3XfO4Z9RZQXCBT/rmK87M1xyvJRiJ8?=
 =?us-ascii?Q?XueF/jBbjlmVhJsKZQP5AWW9w92CW3xHvroBwKXX60rdRoJflPW3SNpS5psF?=
 =?us-ascii?Q?dQA7sYjvQljNAhKHKN9QDy79EjFWzTD/ocZPDptyUGIVIouXRoxo9rNhjb7U?=
 =?us-ascii?Q?q5+UDhO+7NfDSQo9rMryNXCNDoYcJOkwWrO0D+IKyPOQQx3RtjqJiQQqN3+T?=
 =?us-ascii?Q?okTmkSl1pnfajnvk/+okIBR+SypQf1OzYu32GeBbc5eNihWeT1bEd/mNH7oo?=
 =?us-ascii?Q?fLQufSn8Q4RUswGPNpaoSa/vCNhrgEqHIBwJxi4KRHm8lV1EMxv+pvRQ5mFK?=
 =?us-ascii?Q?CPplMLxgg6FshP+JeuUU/aWLrEHB9X3bKvXk9lCmlcOppe/TSRuuQPJHia3V?=
 =?us-ascii?Q?+Buw/8+BUA9sxBB6eoaoe61Y9dPCTXbCiOH51HmcJZFLsuMyB/u3fb+zq1+R?=
 =?us-ascii?Q?ZWCZjaaoLYngTuMT7wQcGc78eR22YcOgZ5wWaaGAVXNRuMckGW3a7LQKA/KK?=
 =?us-ascii?Q?hzkEo1KsCZXNvI78WZjue/2kXk5Z3e7PkJZA+FBsxfJ11ig5sMEm7ZmAa4ng?=
 =?us-ascii?Q?0xd1Gp6I5RgRiQgEnrePH829y20QlpjW4G/iFOWIB6dOt5GVJKiVyjGaCxdW?=
 =?us-ascii?Q?Y7Royh6J+4rmyGWWCtc1Z+C/esQtq/0ETXJETq4avRAB7kGy3Y0i3frPaeh8?=
 =?us-ascii?Q?vS7mUS2ZSZg+FfOzIa6raXiyBcxHxtmsOOuAF7tlT+U33ImjjuraPcAj9G6i?=
 =?us-ascii?Q?OTymf/KFCdQySyFezaf9gBKFdAnY8n44T/BNt2ASixUz+wUAJ4V7S3Jt3Szk?=
 =?us-ascii?Q?68DCAW+YbyqhFHRbbTLf//aL1k8jIuBFk4OtYOHAicxA5CP1Y52Aml2FDaQI?=
 =?us-ascii?Q?E0Ghe5xuuCpWH5yr4Pcy8qS5qUmoa6n0ZhKb+towbwbDkhQmWmBqTAejZ5JJ?=
 =?us-ascii?Q?OM4BoaVcyr9yRUkt5XbLwiWE/55ABcASdjpdu81+14ilIALXWo+anproi/h/?=
 =?us-ascii?Q?yCUOWIqzBsQwfUplhfTZnA7FHidGIUhBJ4OMryPnwOM4K6xRiP8p61zVwnwF?=
 =?us-ascii?Q?FlnR/WNQx+k1er1pDFGpInA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gcoTHLIdEBGwkcbVQH16r0jEycaG+AeApgIMAosKXOKvLJQIPd0dJ5bn+ik?=
 =?us-ascii?Q?2518ZhTYOLfPgZvLqB5vE2bqCNBgMIRCnrsmWUftoegbk1OmO0azi5T7F89s?=
 =?us-ascii?Q?cYYCQUE7mbYuExhXKLDHM/BKOI2irlgzu+ZVmvqPIUUFyc9g2r/Q2qQFBP2/?=
 =?us-ascii?Q?bMAQQIEX5rpBvuJmL2lKcK3jOwTO5vDcp+qynVBNsP3mw/GjwyeeAG2NWVAi?=
 =?us-ascii?Q?W649sWISUWSr03eHpGGB+U2iaRjmMk1yKUXZ9MaquVYq9YvbMCe9EMOec0qu?=
 =?us-ascii?Q?3ucilw7bOR2FtmcoZDm7tf7N1onNcm1Tdq02cst7QZBoNaFBDOvNw2azswNH?=
 =?us-ascii?Q?XB0tKKfAqPvOqNEZp1tlVLnsWkYFl7Wc79BX9ST9svrW4YBP3jgn2AXovyIT?=
 =?us-ascii?Q?OjNveqWZoPSJmUbjeJkUBrHaj7LXOYmGPkB9bKXmjQC7OqrghUDL/aYt3Y4F?=
 =?us-ascii?Q?0SLRz+h+6ErSH7b/4gHcNv5J8o2YhDneXOf0QzczkaRl18L2pKH6kos0RLzH?=
 =?us-ascii?Q?fshpDufV+WYvUoOd02bWv5LrOjTDnKqH9MGNLodES34YPB7ItmE/MbSj4eYd?=
 =?us-ascii?Q?dSkqgktdu7ZHc5QI0qG3gJKGj9AypkWqpyAmYEv+blJVx0hOfZ0p178YkjcR?=
 =?us-ascii?Q?7npGcNsiYflY1rGGVUp3OuaA4CAt+LWs5bkPNmduZR7LNbBYxnAakn+uw+sZ?=
 =?us-ascii?Q?fbSjuS9GT3M8s5mLuGa5C9xDe1pw5TAkxv1UAtI7RWtck61Jy6wLXtUgvl6S?=
 =?us-ascii?Q?32EW21yEdhyayZ8nklXlJu9wzfT2mdD4ctGkrxO54azzUvbfBLE3Ysvj3P4c?=
 =?us-ascii?Q?nFBTot3QgPP67iZFHsuR+rEGfElQenHWAJlow0CkTGMdJypDTuzfi70UQY65?=
 =?us-ascii?Q?hGyOR4uwazfi+BKab/cQBMl9N47l/qhdWq9qCZw8k8OLBfUifupMn7SZrnBQ?=
 =?us-ascii?Q?pNh7n8zKRCmifGjXCxrdreytdX2TvmM3CSsYemUJUYioVdWIru57fc5y4oUT?=
 =?us-ascii?Q?CvalGAlK6ymBh5aQ1q2TKD35C4hy8APvfH0uOT7SC+cT6DycSqDHVky5PoOT?=
 =?us-ascii?Q?sKRpJJAtkREa8k6tw94JdB2lYmaluXDUmiEcJhaQ62dEhY6oKidhrRYMFPVN?=
 =?us-ascii?Q?fSAxRhJGzhJn/rDg3/hA1s9bw2b2k9qP28++1UbcZdwXHUHrNPNQskWKJVJF?=
 =?us-ascii?Q?yYz2fXBdxP1A8KTlv4h3WpBHpJk9RAx8wm5Oxv2HU5xr/5IEG+za3gcJrmiB?=
 =?us-ascii?Q?kb3Ek+/MrN4Pcd62ZysQAk010UpyV5ssQsK8YTc0DRORfXfuPghdtSKzg3nm?=
 =?us-ascii?Q?K53SDdvLROhNwblsExFa2rKNZuQap3g4l8BkgFs5K7tyH9VTF4R62Dx5LAbl?=
 =?us-ascii?Q?MbSz0lsdRq0dpdIHzAsFMscuwCdM1SFA9cbVcaqXOc1lOEZ43V9C7xg29AWp?=
 =?us-ascii?Q?rQZTQbtqH5ea5NgLxabmOwmRc24YlssGmJYGbZN5Xf/YGRwZSc7HgEfuEs3t?=
 =?us-ascii?Q?kzVxmVMWUMKyuLWkiJ7KgzhbryxVgWt8Tyg/pVtInUyUGJcEa9pCO7HiPnOI?=
 =?us-ascii?Q?yLoKEqFyt4sR9qCub07UtyJgHaPewY8PxyMppuudN39o9xq+PV0vFHbjQ1Xj?=
 =?us-ascii?Q?z42oKQM5KsU90dQk6ZH8/vGyVDCybfolHXKTiWhrKeIpP6QIkHSnq8OhLbT1?=
 =?us-ascii?Q?nA1RmDIDObWlz6nSGXEgim/rwIuRfR40LuzDSZvLszmWXB4ODbYn+ul6zGSd?=
 =?us-ascii?Q?phCiK5c3hQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28e95db-2149-4269-d2cb-08de59937b73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:51:50.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSPW28XajJGRCcyfP4ERBb24toQWB2Hpwc3Xy8UqfTL8nQhufeYFV24UN9OX8qZ3kv8SC0gSVQpX8Nf0z39g5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41282-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 79E9663B00
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 10:17:17PM +0800, Felix Gu wrote:
>When calling of_parse_phandle_with_args(), the caller is responsible
>to call of_node_put() to release the reference of device node.
>In imx_sc_pd_get_console_rsrc(), it does not release the reference.
>
>Fixes: 893cfb99734f ("firmware: imx: scu-pd: do not power off console domain")
>Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

