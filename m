Return-Path: <linux-pm+bounces-12810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A471995C981
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 11:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235CB1F24D9E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772516D33F;
	Fri, 23 Aug 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S2jrY8wf"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850E14F9D4;
	Fri, 23 Aug 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406281; cv=fail; b=JimWG0yKh3dBXjICzekVFmimHTWtuGf4Cl6iE2A2RKZFJbAXfrD1Qx4ZZU+iAHbg3iG3sHlCTzEirgre94eYnrB7Qv6xK6BESxxpzxa2myFrJiJg233uIEEPkvqlwolyxcgSC4vrs9wF1U3E5Bjv+GMjUbGr3zBvFHzRXBYf8X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406281; c=relaxed/simple;
	bh=kZUj6aN9KcQYSiNDizf4idUZbYz6TWD2wnpy1nsvetI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UJKlifXtk8KzVxfLuj1xqiqLLqsxE+t3CirhGmsai0DFuEi1bbd3J80Ax8+FFKLQUEhLbKMUgtathxPQ6z2EvvgsOpIuis5vVzMGLVYBgip2JgarpVsGwZjc8psSErBlpW8FpvIQJkFIMZu4s0ptWkhnh/x3t6j2HsioU82YK5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S2jrY8wf; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xH6/AtfKh1yJqIHInmfR+I10nexpVc3DCDL28wPZkRLvG01zGthq1k0TieeeVP9RFxs0vA9isJ1dW6MnuUnP3hThguEs9UK5mQvg6Gfv0EE8MNOcwgsOelM20oZSapa6FcnsyhxeL0JaA/H8kr5VZF4BA82hkosZR0e9vyzoRD6fO1gHxvfUG73acBhR6TPDoKbGjFqFEVM6xIjlYvpWLAXEVcVHVWHXA75O1/NkEUe79fnAhHj5yEhMVLjtaVkBq6xvf1JQiR/rElgFRBB21nh8ED18oY7DlY1G6yrblm1h0aIoVfMLEM+RdbU02NOaivUGV9rVsLVpYc3low1yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6BTvz66Q9bjs88/uwi2TQVU6CESaYwylM1S6sMG4AU=;
 b=kcNIfUy9UwFd+mpJcFyU8CAMoRSXpqMS3dJaj6FMzwy2mi6xCy9iNIqMS0I10X8AeZkdmGMLlmcHI7D6XGE85qViRzBh1d9yy4hGQw5MXXHvYmSqx/pnz9lf59H676/v/lbNq52ZHmcffZ5nv7sG5YMwOZwUNeFuzrhv66fxevpaWQc1Bjv8yMpFPXY+ZscZlELWsaYwGzi/IAOuF4VNmA2CAuJVg+qM5aTSAbNSK+1xnpdAXAloutYICR10JcfMAkbCnNWrMKE28kOFKahHomMMuhfk8cDm4qo7Le+7nJc8mXjGL+jJ29EtwoUURcO9t19V0AaSI6FyY58Gxn5AMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6BTvz66Q9bjs88/uwi2TQVU6CESaYwylM1S6sMG4AU=;
 b=S2jrY8wf/uMsKk0hDzKrpkNXNZzCsDu5XGoy6GRI9pQtBfif7OrMurv+M/4mh+H8jHRVk8pdBPhoIqQwXUUUvFoHrmNS3yVH10y/68o5moZIpuCA+X3nMAwfAhctCuYJmiIp+aoyC7EbyMXpqXCICja/14/xzzMh/lzAwZKsDBeNCtw5pxNpgtKIY91DbQM3rW/pBxdkOu7vqhm9uLhkc1LB2qduEvh1OOzul5yH5gbJ8N3jf9bz+ZRvDACCspn5Kbv+rdJjnlqfJcEl7aTvcD01RqQtojWi7uZJsOiMkGGAADL1C4JNE18WhM89joIQguRdwl+sh2Ks385I/AlpPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 09:44:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 09:44:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	victor.liu@nxp.com,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: imx: imx93-blk-ctrl: fix power up domain fail during early noriq resume
Date: Fri, 23 Aug 2024 17:53:19 +0800
Message-Id: <20240823095319.3917639-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:4:90::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9d9d41-ac14-465d-3d89-08dcc35830aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otV//TdjLkYvYXanm1IEpk4qKbEx4AEPVOAwZ82hofWmXoB170xrk/AGLYvc?=
 =?us-ascii?Q?lkI0BTMy1vC6YjdmTHXYb1KqERS7Lv3EQew2gx5WElSEbK57JQG2aqAWayq0?=
 =?us-ascii?Q?IrLj5PhPrTSFkxLuI7HFyJcB0aBDfah4Uxgx2Rat02XKvqYci5JayTm/3ahF?=
 =?us-ascii?Q?d2pu5ILDgUNP37SVcTfoit9nzPI+808aJ4icyFydRbzAT1RnKCpDvqHh18In?=
 =?us-ascii?Q?dqm5W6EsXtxBdmZvxJB71sr1CTAvxFwM9z8OQrP35sbpX704XLYH/j/iHO0c?=
 =?us-ascii?Q?dfAjmDzx15g/xTd0L0MqN9/TwsLt991UqTGaPifjCznSQZUrLi4HKlzzcO0R?=
 =?us-ascii?Q?ALd2U5YCiDKRriTccRiD6mLiHqp9H5FYtp7uW7iv6+MxWv0XemSVNUtjwtMo?=
 =?us-ascii?Q?28uEa13D0PD69wCCJ5orCJD+dgOMX+T/WzAuX2Hx4gD/1j8xh+hpEBx0RBT5?=
 =?us-ascii?Q?CnMtagw5WAa+D42DasD8BvrMyXbNvKwVEE6lFKpEi2zgDWPqElW16PhGvrLh?=
 =?us-ascii?Q?+PcRqDid84dZS5S2NzCdAQwO5DjKo8K/4hUXfH1Rtz1PkA6k6YB9U0gjQIoi?=
 =?us-ascii?Q?76NyaOgmhSlre7PS8n9vk+L5Fgfaya0HKWDB0kAM35cM0MZqkF9ZxDPxOdyp?=
 =?us-ascii?Q?yn/kyB5WDWLl4hLs/ZeQNhzInIm8miPKhzy5/1b1Y4C9dvyGD4fVgyWUxjZX?=
 =?us-ascii?Q?CGhwUgxb/NllVg41nOpETf5uAb90PIHcNoA2WQMsbWiH9p3Wm1qhUQcPkV2x?=
 =?us-ascii?Q?1TvOmEjDC3VtEcfouAyIN+2Ry47t/uWxSQZWvkfxijwR7UMEK+jPxmb+ZkC8?=
 =?us-ascii?Q?/cUlF384OpRjVyq4GwKFsIOt+s32nn8Cav0NSmfBRY5gBrOlxs03T/O72vgq?=
 =?us-ascii?Q?jqaTFSAhBaR3rHiCEkKUEyOl0I6NfD+j6NpYcYcYes/DNLj0dUELkyzyXT+N?=
 =?us-ascii?Q?dxNVK7Nshgs2fucNXEaVn/R40EJlmxQHojFRYlBRCPFf9D4/3odE7M5qneXS?=
 =?us-ascii?Q?YssEaNOhc6WC2ui5IRdDTv2KSURuV6QT8ARDqXL33zh1z+QrHCAZxlU2C8VQ?=
 =?us-ascii?Q?uwDlF8aY5zJCReXufD/ud+T3fiGajO/15LxOmce/h0blpFPd69gvCnNoP0ny?=
 =?us-ascii?Q?9ZZ3QPAPS4k6Q6BHEw0Qh6ktwLvREvfm14TgfVFwQ7N7eUW5JXpHnDiG7K7L?=
 =?us-ascii?Q?HlQKaJyXNnbRjSNywR72B1Am0l0SwICyAfvqBEqT6EqwulylB5aa2ah6YD0e?=
 =?us-ascii?Q?idcfBRwHzldTWISMbQ+p8IrnTm16O/WNfaJYcAyGcvvq2d4hCzy255gT8fU0?=
 =?us-ascii?Q?kTEMJJ8UisQKANFaUTlbi9/w9zQ2rWSXMmPNgCEPVFUvtQ/u6lC5qYsX6Ehn?=
 =?us-ascii?Q?QHzDl4M3bg8A7BTdWE7E/znC+x96yjjyxMY7x/bpFKql0dE9aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4D7IWfvSV3SoIf/okzGckmllZce2NxRYZ6nL5NhHCtEObApmd/0euvdrjiA?=
 =?us-ascii?Q?aNrwVJkAzxW/QrbMqbKs5mZ5kzOiIq45FS9G/G6LNegbF8f0q2zRh5kjqPVj?=
 =?us-ascii?Q?MjsmTgbooInY/zCR4zvuiW301t4M1gCw5Dsl0E7S78/FZcGb1MD9dmbW4Sov?=
 =?us-ascii?Q?nFbWJcTY3ytyzYRXKul1/q5gZAHUY2KI5BpYfXwlGRVfbfDwIH+8KtaAsMlu?=
 =?us-ascii?Q?ctiRYs9HyO/uog8ZRUa0Qj/1Df8RIl/oXcS7DigcEzmikzGhq/t+03FXUC4F?=
 =?us-ascii?Q?2sdACOGCDDN1aIGYIeM9ltf+sozx+EXX25W77+MJcqDcxcNJL5Xe03E9Xx4H?=
 =?us-ascii?Q?+LKe3jJmIXTQkHizM7lADXIlNJ17D9OUJMQJl5K+IHN2r2xo8eMg7QpBexqn?=
 =?us-ascii?Q?+Ik5U8GYjCwg8h7NjxsU1gQ65KbqyCbzZJdWHxdib/YgYvy7EMYC3JcEwSSF?=
 =?us-ascii?Q?WnlT+CgKoLWUoKunVC9EUKNsX3FI9Fx4dLfyO5PW1QBj0u2JmZs2hmpLSOAX?=
 =?us-ascii?Q?zdFaeIzQMcgOJMLzwb1kvI3UG2BwlrohSwg4KE4sn71qBqFgYAUKugRq4rm4?=
 =?us-ascii?Q?tbRynZ8DWVJt58Ruyb8fDEpBnSr/Z6EUMiU0rorEjuGj4ISA8jnbdEpk/ZFK?=
 =?us-ascii?Q?2egib5WFpIfGq+mfkQ7ATsLrbOocs5FBmJEMyMCGXgzoS2TgeTm3V78Wo0CG?=
 =?us-ascii?Q?F0+/lhxTGVS7A7vvxG4C9HHmHasFCiC6+FeFHR34xaNoYiHMnogsnWJXpbxX?=
 =?us-ascii?Q?rj9fjvJgGwWdho6okC1wqDpBsst4vLj2di5JyYhpH+pTMs2Z8JXRUkSO983w?=
 =?us-ascii?Q?zoq3kse50CVcFJ6D/s+9Kb2AgnhWNim1YzegbYMJfRV6aZNOltYnf/Q6kptK?=
 =?us-ascii?Q?IfwaacWe94cpd0QYDcqw1YgRKN3+LmwPb55kk/0CL+0HpSTwNbE8EWe2eWHI?=
 =?us-ascii?Q?GZq6eMuT5PJIrUYkSqODQyR0FoprITlg3DAo4wdQdQjkQ9KX2x0itZoCVjhM?=
 =?us-ascii?Q?YZ117PriD58tYJo92c2cOpQlMLitf+ndq3kaI+CVO+cTiN5Fk9XDFkjyFR/I?=
 =?us-ascii?Q?YgMngBvv9WIvrCFeUYKfHm9PsacS7zz7KyNUaLJMckrkISF8zVld5t8rHXlA?=
 =?us-ascii?Q?jGlsWhdr6PO+w98rOamXK/7XVoMXHuZPuR5foYkg9mEJtse22lRqRlsVXtlB?=
 =?us-ascii?Q?7CZXWfYWyB6fzdiyPeFcz19lu+omziAgwTbv/1bSNphFzcJJ5UsmvQZgAVJA?=
 =?us-ascii?Q?70zC6qnWhIO1wuxFbhKsWsbI5Lo6QI7LDsfUk9faDzyiMO+9zhIvstcEBmZF?=
 =?us-ascii?Q?bTFXUMZ7IxJbiJaQn4IAI05zMmqbuI6TmvgAL6d1NSsxYBf5bJbHCiQxkduo?=
 =?us-ascii?Q?UCIXMEJJSr+XPPzyh6DzF+/74fORdkbhKr0fQuBpqtKkP3EP6A8yDkS4z3D9?=
 =?us-ascii?Q?wgQEQLt8PxAv8Cd0+Ew/hqC5utp+555oFwavL6y9g5JZTBdvyfWghxqRqV+P?=
 =?us-ascii?Q?JLWrseQ8D3qgP7mcpMuFQBZj67IaH5uokZcFv8cix8ZJcUehjA89L/Yye1/F?=
 =?us-ascii?Q?T/luRFxPxkWXbwXY5h1mYylHPbWxx6cTXwQJCwPB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9d9d41-ac14-465d-3d89-08dcc35830aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:44:33.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czRBtE2M7QN8jKBbfcZLtTo5meg6PICm/VH4Bzwdd27z78JpaQHGzG0zB9SsGGU/+qgjil1K75Y+HTu6IHcL8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087

From: Dong Aisheng <aisheng.dong@nxp.com>

After disabling PXP and having no displays connected, we met the following
suspend/resume hang issue on MX93 EVK board.

 Enabling non-boot CPUs ...
 Detected VIPT I-cache on CPU1
 GICv3: CPU1: found redistributor 100 region 0:0x0000000048060000
 CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
 CPU1 is up
 imx93-blk-ctrl 4ac10000.system-controller: failed to power up domain: -13
 imx93-blk-ctrl 4ac10000.system-controller: failed to power up domain: -13
 imx93-blk-ctrl 4ac10000.system-controller: failed to power up domain: -13
...

The issue was introduced since the commit c24efa673278
("PM: runtime: Capture device status before disabling runtime PM")
which will also check the power.last_status must be RPM_ACTIVE before
pm_runtime_get_sync() can return 1 (means already active) even pm_runtime
is disabled during no_irq resume stage.

However, the pm_runtime_set_active() we called ahead of
pm_runtime_get_sync() will not update power.last_status which probably like
a upstream kernel issue. But that's another issue which may worth an
extra fix.

This patch refers to the solution in the exist similar imx8m blkctrl
driver[1] that it will power up upstream domains during blkctl suspend
first in order to make sure the power.last_status to be RPM_ACTIVE. Then we
can support calling pm_runtime_get_sync in noirq resume stage.

After fixing, no need extra calling of pm_runtime_set_active() ahead.

1. drivers/pmdomain/imx/imx8m-blk-ctrl.c

Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 904ffa55b8f4..34ac7b722b90 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -424,6 +424,34 @@ static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
 	.reg_access_table = &imx93_media_blk_ctl_access_table,
 };
 
+static int imx93_blk_ctrl_suspend(struct device *dev)
+{
+	struct imx93_blk_ctrl *bc = dev_get_drvdata(dev);
+
+	/*
+	 * This may look strange, but is done so the generic PM_SLEEP code
+	 * can power down our domains and more importantly power them up again
+	 * after resume, without tripping over our usage of runtime PM to
+	 * control the upstream GPC domains. Things happen in the right order
+	 * in the system suspend/resume paths due to the device parent/child
+	 * hierarchy.
+	 */
+	return pm_runtime_resume_and_get(bc->dev);
+}
+
+static int imx93_blk_ctrl_resume(struct device *dev)
+{
+	struct imx93_blk_ctrl *bc = dev_get_drvdata(dev);
+
+	pm_runtime_put(bc->dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx93_blk_ctrl_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(imx93_blk_ctrl_suspend, imx93_blk_ctrl_resume)
+};
+
 static const struct of_device_id imx93_blk_ctrl_of_match[] = {
 	{
 		.compatible = "fsl,imx93-media-blk-ctrl",
@@ -439,6 +467,7 @@ static struct platform_driver imx93_blk_ctrl_driver = {
 	.remove_new = imx93_blk_ctrl_remove,
 	.driver = {
 		.name = "imx93-blk-ctrl",
+		.pm = pm_sleep_ptr(&imx93_blk_ctrl_pm_ops),
 		.of_match_table = imx93_blk_ctrl_of_match,
 	},
 };
-- 
2.37.1


