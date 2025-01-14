Return-Path: <linux-pm+bounces-20426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C7A10D28
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24CD169DFA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B241C2335;
	Tue, 14 Jan 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpQPbi38"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379D14B97E;
	Tue, 14 Jan 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874642; cv=fail; b=PQZhpTehqDcLIoshgt1YWs89+khi9SrrOBcmRfWlOw85SjF1CA8fNk5mCW1wlLEv6g5iUFT+R1XVb/gblJPDYamra5q2p6EOxiLK6bbVmaj3SJaYNfjN9PYLLhUWb0K3t0RfQFN4G6A0plbBOsqSIAmkMXpd3OoZc93pzIfctc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874642; c=relaxed/simple;
	bh=/jp3ZhccSF2LnY1ixS3ecAS6vf8cAUj6Hev4vYHuTJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUT5EVlFxSL2QIIpCLdEWdX66VMgStfaHf92pYOFUNKRruXiyW40Xp3QHEtjX2ZWrhxGtG4ZCkNTrlaI3KCdtjqRiCjQq1LytHbxikQuzoIRd+4ETg4YJ0pmGN/Alz9Xi7N4tFqMc3QiHLh3lHACnsFI0BxKxajpDsdItNzT04w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PpQPbi38; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qigCTOEwJb4m3auJR8DfCIYEfDS0frSTFUDir+TQMw+GOBmKKZX9MDQs7OEsrTGyofET2WAilGZBou60ZTuFER1zZUUoChtr2dAYdgB5q3X4N7hCK1Cyi1Upr0QIIesFaxLaCh0T608MsMTyZ5h2qCgVAR8vbbL3Id/RbqGmazrj58E40028EFJAMD0MeUmBwdvG8fvdvgXTeBExe9qJNQzu1WgNj6NfD0e1Dj5DFaVaiYIr2NncCMj3kiRMZMBhr2wZfb2nzwzWz0i9IlDblK3V5y6JaZX7v3SfeJMZtfZA9GZ1+bSvp0jSkt4S2R2cO+StMwknNVfVRYXUWeTsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVD3D4s6909dKMR1kcogLuJbTylhzaKJZZAXsPJevJs=;
 b=EZ4GCZrqTz5c5n/ZM+ln0Pr/0ajcUB654/h3GZCsz1H7z6YunPmn+1e3NfQwbAkWyrrFKGSqXvK45tJTLeZmrqF/MsnGC6FoV9PAN9oLpTZIWZC02i7lU9ElQ5kIkssvX1GcOUkdz3+VLoBb1BkyQX5sMjjZlWn7gDrfb4di6Bji3nXfEwEHqdN9GHiPNbkhpDSPBwLvTMMxIHprBBUG+NxSs0pceS1z9t5k8cDvQ4bXyT3vJx173biFyzmYZaFK6iKdKYJoKOvmAtFG0UTUmLgAxyvjGEyhZnsBxQDP52Z/tsyZQQG/QZh22aGAEHh0FPMh6qggPDfATj/3De8ybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVD3D4s6909dKMR1kcogLuJbTylhzaKJZZAXsPJevJs=;
 b=PpQPbi381jiQte7Bv7bKrNptYYQNw5j/yKKwhdxfolDKKi90Zzz1fcySC6bV3mgFnJpiTwyuBpZggoP9KhRQnQBgXeYDoC5ByfuuWhpnBYNvb7AeFK2sBxTselaHOQpNBy2xjUD1dJpSuV/q3Y9Ft/R6kHTqGHovTNduyVpqinLHU/k2mpYkvtRlpI2J+aDtbJ0T2rSTlrNecjT9OUqlTdNdQ7TdcP7D6ZNRKKDQcImOpxtF828Bnm20B1NqzYz9roKG0o0F6W+Sbq821cadgPR1trbnCdDv2KNCtOI4Db34d/a0Bqx1yqjcyKC9kgSFzMvGwEH0euSOKZQnCdJI+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9678.eurprd04.prod.outlook.com (2603:10a6:102:23c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 17:10:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 17:10:36 +0000
Date: Tue, 14 Jan 2025 12:10:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, ping.bai@nxp.com,
	l.stach@pengutronix.de, marex@denx.de, aford173@gmail.com,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pmdomain: imx8mp-blk-ctrl: add missing loop break
 condition
Message-ID: <Z4aagilTZFjaMsFS@lizhi-Precision-Tower-5810>
References: <20250114011818.2401479-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114011818.2401479-1-xiaolei.wang@windriver.com>
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 913ed2b2-7823-4bed-ae51-08dd34be5d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YQReAsOpwazHdzKSY6SV3OiFLE5NesrFDC6RYbsfKiS61QM0pQk67T3+wLd?=
 =?us-ascii?Q?XiRZkQ3CwiJ3JNgGm9dRfbTcJgFhba8eWdenHkKqdSVzXEWJKbYOmH8p/Bfd?=
 =?us-ascii?Q?Et2SitgFsOBI+G5Gia51UUaQ3Qn/T64L27OwtxgAAe9dhtcQ1aWsLzKqkBbR?=
 =?us-ascii?Q?yDnmaDSpeD01nMekI9/G878eTZQOXsCGz6DklzF2KRxkcE0nNdYyqOyB2qUk?=
 =?us-ascii?Q?X7MKCNGGhmu9Jx2BCZIP0Ze3gfBOA0AUFdxaFCNSG04pt/VW05xPAm07nEu5?=
 =?us-ascii?Q?BdJxX3miZ4jSotqcG0hfeIBmaJhAhFV3EbgYiwc//u81ctmt9RH1E4ES1c0+?=
 =?us-ascii?Q?X+ojGn7cZ9tGzNkU9nTP/KyLRoQVu/tgyhtJrb4o26QUSpPTdWtjmpctnTMf?=
 =?us-ascii?Q?R1Hfi1+bgY+eCvgQuAO9ajt46eHItVkZCpenIh6tmGWVX1gFUmcIqDiEU7Dl?=
 =?us-ascii?Q?r8+dFuoRuYQJBj2FhGm3UG0iGhQlCCqGZ334FdhAoH9YKz4G6YmFKx0osaxr?=
 =?us-ascii?Q?PZrDgZW2nUmdxT5LAOniMAJ5+83x5hgYvgmMNGX3bqni/qV3IFWXHI4kMU3R?=
 =?us-ascii?Q?PUo8wJZ4ABVWwCNJ8hqKB8lDOT55fRNID+78rh8rkGAsMXkOUYmSk9U15/Jh?=
 =?us-ascii?Q?2nzkmvArVnxiDMs3oX9Vj7JZVK0/lq5wGOUg86uqGoVY0zyDe1c2wokM8OJa?=
 =?us-ascii?Q?Ax84JQxcGJyGHQJGOB48VnUTde3OBWmBxLgnj2JCBYNXFmCpDuKdG3Th0uTt?=
 =?us-ascii?Q?RJu+rEVIPg0pSZI3zJ4FJ4jEcLgg7JC+UvPb/uM6DkXL9/e4DPTCEFZzPqWM?=
 =?us-ascii?Q?oa45O+Jp2h8/YZIuRBonkHSd4S0pzuwa0b8DsPaspAAR/QJIHyWNKDgqJEDy?=
 =?us-ascii?Q?1KliVb4gKyhD30M+lwdlqO162PrqgaMQxbR8j5c8usxHPlYmLUOa8976g4N+?=
 =?us-ascii?Q?xNk++up2sL7irx+1IyZoriYUG4WFcMBM8naoJDCg4a4hYArbIbr33ArJirse?=
 =?us-ascii?Q?eE9+BgVzruFLjzD2y8mIsUzKXkcjS/Iljz92SGs2nr2+mH7akeVsuWFvYX68?=
 =?us-ascii?Q?1i64jTyeEy7nqTiwpUOkSZIjffaaCs8Yeh1x2T89cRg+GjZ9flaX+h/vur2w?=
 =?us-ascii?Q?i7u/S/0s5YHxgtfxXK1H4Tb5edXHdU6MXrYtKSD2/iYp7MMBv0ZRvQcwK7t0?=
 =?us-ascii?Q?jcH00zSfkL8t7TCxC6YhJ61ViEP3lU6UhPRhtJjbe3cWLbJ51vfIJgJ+JLE/?=
 =?us-ascii?Q?feoNayiC58xOA8dVW5rt1ICk5+d8UxCFx3hwxMBPyxoNvwaF9vlwe7UyRRcz?=
 =?us-ascii?Q?w6p+js6l5rwRWVbApieCWfHgh9s5aMmnDj2O2hS9fuNJM0Y+brA8+HWPwZ/8?=
 =?us-ascii?Q?YKJH9DgLc2Ee2yqbdAVzxNOK79OUSXRxtgvQUY7N7TV2atrwKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znk5f5uSepwyW1tYB5HPCCV+PwhoMlrxOCbLJwXmdhF8VAnzdfDspsIq9rmE?=
 =?us-ascii?Q?kW4DOlYQyibbSlLGkPmraco3gEaoIXAZ3DnIa1TKmEb/npobSsXqKaXxnZGY?=
 =?us-ascii?Q?1RyOLP11z1rJojg5rV8Co+NcckiHRzz/s2rhKe5bPxBVJZk1L7jjsPvGN9cP?=
 =?us-ascii?Q?lBtJ9z5b1Ewd0qi/rT+xfM6Kj7RiODRQxQVJmAS9DOFTd9d34WcuL/HEgA9F?=
 =?us-ascii?Q?PCjTxLxsGC1lUPXUJpUK71RbfCwibuME4D+iq0w5bg6UrPB0lgdg5zivutUt?=
 =?us-ascii?Q?QSI8V6C+1G4YQKWGddzd5AvV6UOZuDH5MGI1Vftny809rLuZ7soQrAmVWG9D?=
 =?us-ascii?Q?bv/hkSAxxCoWAuorAqcfwTzYhRX1mZVPBVx/2g0DpArnM4J3QKFTE/x1M/W7?=
 =?us-ascii?Q?aoL7Hqz1wencmLWlb9/ou840o8Wdq1jgUcBE8I9w1SIy31uGtLeTXRVdDJ5F?=
 =?us-ascii?Q?xOUpLBA0IqvO53KoKSjWeva1NYjNRpmPv+KGVVB/2YtRixmOHKyc4CR+3NWO?=
 =?us-ascii?Q?l67Gy3l4kl2humxpSf3cKdb6zRmmI2iHw1wOWlDQE2MMH4uLwUzD2w338SZ0?=
 =?us-ascii?Q?SHn/mCtUKKxQ84/zLvcMEpgZDPL7w1c72F/gKFvwqxZwtK1oUKAN/Vx4xL05?=
 =?us-ascii?Q?aeShLVsGjDyDj/hBelIkS8043AuOG/OXQWsMwoNOU/7dP7TNRiFbzx9S0VOv?=
 =?us-ascii?Q?Fq3c0XUMA5AT7jWTBbFAoTPjkXH9yBIGy2ClMz2ZxR2IkzDL2wixpdLT3dLE?=
 =?us-ascii?Q?o5zoGDHK9w1gFWH8eaFjpDNukDDhHDeDuEqPF1enw8+jx2WkCZuMPrid9Kkq?=
 =?us-ascii?Q?mb8qHq2+9X01a+FMim4qg4MaVq741tXoFF+XpdhR8XbeOvnK69IdtDLeXrn/?=
 =?us-ascii?Q?i5Jp8QciYhKlYzgUmiZezACsvV7MSfWbvhX0UTT5f/ezBUY/xxY51OivyKVm?=
 =?us-ascii?Q?eROupBXAgzuZo3ZHQd2bbBdn2Yj6m9DgLwR9rN7vTxrojnW1pn+NVjR7fpym?=
 =?us-ascii?Q?jfTALyS1PPmyo0y1SNfMpaTcaQCrel53B8WpXO45Tn0WNqUoCuUFv2FteToP?=
 =?us-ascii?Q?blNeRPJ6q8LQMhM47fA0YkSJW/VJlN87T8QUiNCpPjfT1SkqSSpgWioIrB2/?=
 =?us-ascii?Q?6fbG0t74a8DEpKsSgErtTWGD1k66bSEajGHJAnx05uRbkgSU5JEGKAlb/pR5?=
 =?us-ascii?Q?iRSEm4ofvkLSxs4o+0IrsTk9nUUnt5DOE5GEg+em62mhE1lZzvb5tLCazZfr?=
 =?us-ascii?Q?/dTdftgwQj+C4DBKI2rHNv64y54qztikxPr144uyrHEgXMHRlLfBtBEcc2ph?=
 =?us-ascii?Q?y0LSov2AkGIVL4uqOzQPLGGVRPDFF5MZYFqhvW5OVficSN/V7BEXpn6Y4geX?=
 =?us-ascii?Q?KNyH7vIgOpTU/u2PsJXHmFTckGe970mz7oI0xl1Q4brfANlRsBG6VbFMLPii?=
 =?us-ascii?Q?XeJwK9mtAjVgJ8SmNjtIkouKqIyUY6C2xfUSDJUd+40U3S6QUfSIownb5eC1?=
 =?us-ascii?Q?vzg7YghUTVlghBTtjSoWYCb0JCd+V8/D2Q4J321VK7f2UtQePm5OC1NgVOS+?=
 =?us-ascii?Q?mPgP/MgtOrXtWsdtin9zeJ/wuhgUNpCzdY98Uf/q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913ed2b2-7823-4bed-ae51-08dd34be5d05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:10:36.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNCtgGARVBftMin25SGtxoXsWiMpWvhrMpsgNys5TGyhElKMBGxrYD4Nf8KXlCUuhEPtsThYUxbvivQKQx/3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9678

On Tue, Jan 14, 2025 at 09:18:18AM +0800, Xiaolei Wang wrote:
> Currently imx8mp_blk_ctrl_remove() will continue the for loop
> until an out-of-bounds exception occurs.
>
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : dev_pm_domain_detach+0x8/0x48
> lr : imx8mp_blk_ctrl_shutdown+0x58/0x90
> sp : ffffffc084f8bbf0
> x29: ffffffc084f8bbf0 x28: ffffff80daf32ac0 x27: 0000000000000000
> x26: ffffffc081658d78 x25: 0000000000000001 x24: ffffffc08201b028
> x23: ffffff80d0db9490 x22: ffffffc082340a78 x21: 00000000000005b0
> x20: ffffff80d19bc180 x19: 000000000000000a x18: ffffffffffffffff
> x17: ffffffc080a39e08 x16: ffffffc080a39c98 x15: 4f435f464f006c72
> x14: 0000000000000004 x13: ffffff80d0172110 x12: 0000000000000000
> x11: ffffff80d0537740 x10: ffffff80d05376c0 x9 : ffffffc0808ed2d8
> x8 : ffffffc084f8bab0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffffff80d19b9420 x4 : fffffffe03466e60 x3 : 0000000080800077
> x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
> Call trace:
>  dev_pm_domain_detach+0x8/0x48
>  platform_shutdown+0x2c/0x48
>  device_shutdown+0x158/0x268
>  kernel_restart_prepare+0x40/0x58
>  kernel_kexec+0x58/0xe8
>  __do_sys_reboot+0x198/0x258
>  __arm64_sys_reboot+0x2c/0x40
>  invoke_syscall+0x5c/0x138
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x38/0xc8
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x190/0x198
> Code: 8128c2d0 ffffffc0 aa1e03e9 d503201f
>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")

need cc stable?

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v1:
>   https://patchwork.kernel.org/project/imx/patch/20250113045609.842243-1-xiaolei.wang@windriver.com/
>
> v2:
>   Update commit subject
>
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index e3a0f64c144c..3668fe66b22c 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -770,7 +770,7 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
>
>  	of_genpd_del_provider(pdev->dev.of_node);
>
> -	for (i = 0; bc->onecell_data.num_domains; i++) {
> +	for (i = 0; i < bc->onecell_data.num_domains; i++) {
>  		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
>
>  		pm_genpd_remove(&domain->genpd);
> --
> 2.25.1
>

