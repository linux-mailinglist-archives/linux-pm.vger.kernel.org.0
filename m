Return-Path: <linux-pm+bounces-23610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896EA56221
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 09:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06871895C28
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9E1A5B86;
	Fri,  7 Mar 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M/I8XfRz"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE821A4E98;
	Fri,  7 Mar 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334532; cv=fail; b=OnaRRyRHvpZdFETXUFBQpJjEPNI+EwdUfpr1CZRZtFAmhJdm4fzBnsduaCU0WOGzzvECgwqaCvZRjZ7OrENIIUld4hCqKRtB2uGGAmqoYB5uipuyv0Qy3R0rDHTE7r+7xYfWGcy8rVSuHA9TQm+NxmcKPVfUafJb9uj+T0FBOHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334532; c=relaxed/simple;
	bh=Qpo+MwehnYCTNxiWbbD8SGf9wubqFk+2AdJ+n1YqWMM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p0ge2xUJT57NO+dLdjozELsrcLyj5E966yC9QOOD1/rihnZW7pKZjhDM+IW0FUwyHIdOA6RPatnZDq4NB7b6ueKPB8Bz99DH7Rt9qLwYfp/eTXihgJSQIg6QTg38HwlZyq+4zRZvCfkuW21Kcvq2buzUBqieROy8jrskJ+ph5Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M/I8XfRz; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sbsci04fY76JhJwTmX0vFy1FhKeRRpOg0YyjCHwqfTFt//hst0Bfu6FGK0LU5IU+suRzD3XXgJ31hayzBFsNQ8MYFOYBWnrSzvPlFutcKOSn+xpCiuOER/Tg4IMVjsblpB3wQKqSj3BqPq8dTy+N3DJJR59vcQPO6JDCvv6EwWXgdxtMEWiz47LWq+yEWBe1SJ++p3Tjuyrjqopk2oo9e1HS9DV+qTVuYVUktw9Bsi5aHZoVdCoS4i2TIWeZN9w8pwctbeUIDqKdPPVOYm+6gtCw/+sTmMv7TD7KH3wtcopbFgdF318z+ZP53L3fbKLw5NUr3qa8otaUmeUtsLVYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3ey7F8EiGCoepLHHpxOERrf1kCtSlujFO9JhRDC8hs=;
 b=V1Wt6vdfgWmKzsVJE8Mka8YG9303GGKB4LUwx6VZu3FPxXK9Q54pug172cVLkixIAcfz7iUQNxq4w/zRTwiByZKxVT72pTjwDwX2MGYqopyOF/cJ/Z2pGy3Xrp4b/XvPvW+iZvr9GeDFD6L9VaYys2oEFkrjWdil4iaDcTlOb2QhSB8qN+0F3jILuEwNnesYD0e57NJI5HtsjXtGV0eKsGGwbkmbvmgITOcswoWdh1b0Q6sA8TnfO2VD/KhcKpzNK1ijNB1KIMd+uvQcAjy2qVLqbTLNKMoltYuI+GCUJDMkm/8JWhNwHG8qbOMr/KYvbKIcbSSoZFyZcuzvJaHMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3ey7F8EiGCoepLHHpxOERrf1kCtSlujFO9JhRDC8hs=;
 b=M/I8XfRzLBK0ZcAO8we36SsPTRm71GGtmi7niguThRF4wWX1OlDbe4yJbN2fZDSA+pOW6EjSZDlogqTu3hg2Dg4qzjyPJ2Hz4/8TKPOIGU7woQgd1am1rxcN0r9qCd2ONP6CIz5NLNXraKqBPdztGB0Om6JV+C5NsSKXgy3nswntE/kp80wQIPX7i9uApbaPJGONEUxuiNwD6LMpCvVI0Ld+GptfmVQiQeGl+aaqlnZFAE84AzuBwJbTLbIZCAXFLj972pWrYuYThcG2BqEf4fanSNfg9bOpq69nhf3ZigQkILPacd84+nGjUPO8M7EGrTcFa3DSnApFCC3Oh4RWTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 08:02:07 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 08:02:07 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	ulf.hansson@linaro.org,
	james.morse@arm.com,
	d-gole@ti.com,
	anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	imx@lists.linux.dev,
	khilman@baylibre.com,
	quic_tingweiz@quicinc.com,
	quic_yuanjiey@quicinc.com
Subject: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
Date: Fri,  7 Mar 2025 16:03:03 +0800
Message-Id: <20250307080303.2660506-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: b08323f0-c541-45b5-6fc3-08dd5d4e5aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p9ZNQ5RZ3CdLh7xFtl0cPUmS6eiuIlJqW/zlQgnVagwVmuIJF+Sts8o0w7pH?=
 =?us-ascii?Q?Yi+fZS7zAesV+xKEggRkJX+Yw4WiAf+vOkYK/6IeBfSLlSnUdb/kxw3FadnQ?=
 =?us-ascii?Q?iUkwGHt3FeEq/ZSg/RoOkxVrTAiSJAlLUTjj6nR9LwaaayV9GVmJMteGJZPE?=
 =?us-ascii?Q?wfGNnSKmYjLeZkx9G/lPlyQasysnwiFRIgXuZS7KTCs09wy2WMDQn5pUhO48?=
 =?us-ascii?Q?Ni6oyLrhzXcQoCaaJlFASXKPf1tNx5WMjRRKTWmGxYE+SqtyH4RtJjxUCVmU?=
 =?us-ascii?Q?DLsFxchU3xuGaCQjN9ThNQyHFGjP7I65vHx+YUihGpxurrJGds1Z0HnuyXVX?=
 =?us-ascii?Q?ploXpeHvS83yDuq4XTmqL/s8pJvqeWyFFTVl2ZZLS/49v1hznRbG7QfFG7/E?=
 =?us-ascii?Q?oLWPuD7tyP0h9TO8j4G9uWasf0VpD8qrrL342noz8IW3Gy9mu25Pi1vndTAo?=
 =?us-ascii?Q?7brbfBd7FVnFrsFx+wMtuCRJCX3eZMgtB8ShLNRyTsN0ESd8/krC1rnhb20b?=
 =?us-ascii?Q?b6N4H408gD889/b07WDl1yNGNHxFlWGK611J8w9KLYynsE4dfLeFqC6EaDr6?=
 =?us-ascii?Q?bsLmiIW99DQPsyXhFSvu9xDEjvoC4+DfY1M06D00xu8u1lQKepJiGX9pL29W?=
 =?us-ascii?Q?xkzqKllepvO0NwikpIA5H1JXzLGU2Bf2g4hdHVTWDvUkfPfiaHONQTDHWPJA?=
 =?us-ascii?Q?czlDPc7iye3IsAc/Qu+LSNVeQeOv37TXby4Va1UKinK75+4JjVpiz96W3YRw?=
 =?us-ascii?Q?AzTCHQfutSGdxW1EGxn5zfzjuh/XXRZ6CJQnVSFprHp1BYLc+JYrBOOZqZO0?=
 =?us-ascii?Q?Etr5DXnyS406Xv/OCJDX8vrmOYLEd3C9iWBeGLnwRvR/rzm5THrzvqJTgGzP?=
 =?us-ascii?Q?VrDencjU1H59M+LcI4QvOp6W7oY5bcJlWCD/ApL3A/4kXO96dFN6ZcIxRVil?=
 =?us-ascii?Q?bm+uUe8yip65GLGJXB+RS3El3wBczZ3fLoBUa41yRbnMUg3b3wHCygC0r4l8?=
 =?us-ascii?Q?LetENixbsP0DMnWb1+ckW7RSSAWckMcxBOCkVL8xNq32vNjk03RX1NR7S3yo?=
 =?us-ascii?Q?JSKlBkLl/MlseOuDUpuFNoO/NIh3C85N9WkVG44th3x0z3jeprntrWmYEgPX?=
 =?us-ascii?Q?o1F6rwhVZye3ZbF+Nb6ybAMtinlXKRJqUeVvyzxtU4goInQzBvkeJmTK5brd?=
 =?us-ascii?Q?SKZ1dxrPUdJXB8CIJ/wDEO8nYcP79+pJuv45rKCnku4nj+JNgoJ42ozysYPX?=
 =?us-ascii?Q?E7vzgE/6xnoyJjOzt+X5L2iUboi04x81iQi4ivnhzF41slCFcdLZVt4wMGc7?=
 =?us-ascii?Q?GZ+7i445cMYS0RNhGML6Xe3XPdmuSeFPiAr279zHZsbsJzujs52hHLi29BBY?=
 =?us-ascii?Q?IMLKf96YgdbEDWwMRlDfgpRmzV293MKuJu36gSBYJpn+ctvoBvC6QuuyhxMA?=
 =?us-ascii?Q?eCsptvU0WCRNRqjpwxqEaK2N5vB8BIYCnD/7AynEUXKQUoXeaP2TpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkZ3lHu/z5JkVUGJ7GLW6CINi/aQitgSV62Dv3A+VW9xmoR5uRikiKkVXMQh?=
 =?us-ascii?Q?L4JTVhB4izirOq/p0u/PQHWjEDN8toNfurwmslEdjY7vMcnPnEZ4rbtFdiFM?=
 =?us-ascii?Q?PKXI13dukP1tXoYKP7PYpl1oZP4SDE0mSfq4n5NLEWriCsRoM8rxvrq1EAvS?=
 =?us-ascii?Q?Qk3zdj+oI0zt6/Fh3lSf6mFsUfA7+DuN0lQFYQW2N2E68VbpN6XQVpILnQd5?=
 =?us-ascii?Q?l9l+RXCBB9baIJkooIPlqq1EA+stqjj0sEtiz+YTDS0hYxnPvVcbERxesnEx?=
 =?us-ascii?Q?aiN01amvjjVNHJUOl0GTma5Vmn3hljGASJP3QBXg7P75Z49wY9Tplcx/8BkB?=
 =?us-ascii?Q?JuZqpCozV20wvFETG7SL2qfM9aUDdmog10paKI2e0Q1r1ujmsMaDUPkIT9fr?=
 =?us-ascii?Q?vhEUaIbfz2s9jfou0Ngxaf3C/IK/W3ljnF8eOmKBWB4d9Q9VHOJm4rhh+gwm?=
 =?us-ascii?Q?hkTQ1ezFD0Xzb8p6WJYNf5wBtcs3p39bOdV8eTXdjk2fsLSuBNxPkTLX5zsB?=
 =?us-ascii?Q?s1nM2NZZKkAcQkNF3ZQqP/hr+uJCCxP54INnGS3TXUYn9K9Ugn3bbzKGTiN6?=
 =?us-ascii?Q?XyMYHFd9sQHq6Lg7Tlwp1+VcmSEuBwaoh/uHsuMq0W3Tt414iC2SCh7vm+5g?=
 =?us-ascii?Q?RnyOerA21W1AtCXU1s0eK9SPxtoynrb5KG5lTZprqKTH26zP+H4IDvGQ0LKc?=
 =?us-ascii?Q?MzT/uTQB7rPIh4DYZ3f+WgTYZ4wl/tBehaxNT+PTCuizAWYDiEkZq/Aa0A7a?=
 =?us-ascii?Q?POow/OiuO3xfsQTtdm2R3/Aqxuxp6EKpzAe5mcqowYGpuz8XJYQwWgwOOK/M?=
 =?us-ascii?Q?BaPhniklzVfbqPRSpxPv0JSso8GQjShMtRxa6oi5frQW+TvkQbgFQLZ4wxuo?=
 =?us-ascii?Q?fzm2djGUHOeQGbzIJ7993wJD9viWUCxNpHokRdvmzF56yX4UoTf2xbG6SmKo?=
 =?us-ascii?Q?snnA17B5Kg/iF6msqHLH39oYeFHgFCGEl2YwpnACaNKS7BkzeoW5gs+Tct7z?=
 =?us-ascii?Q?XBTBAoeT8nM54pK4FHQ8jXGRqm1MRXi/LjZCCeR4ur7zhWWyujTwI8s/OcSd?=
 =?us-ascii?Q?xw7Bho7TH0CXzhoQP/nO2vlrxwWegpIVKs2TjUwYyKk4Dz5BznbULNcqJv6o?=
 =?us-ascii?Q?FmzQ34Nf2rV9aNH7/q0ASKvjaw0M5oeeqKTAGZ8AD2XSioYqQwyYgKgDhyvH?=
 =?us-ascii?Q?5jBg9ww9uHRvkctuWIPGCTFB3HhkpgrDLT5B5Y4EkpycaEdWOpVqO9ZDd43h?=
 =?us-ascii?Q?tcdue0n/lqgJ8W471LSRuRdGYy5T5Ji0OX+GmLsvqWy3RH43K9uP63HCdNX6?=
 =?us-ascii?Q?jpeHIcBDIwD3AimbElCU7njgmVQrOvTaxuMGcNmUSC58DFaldrO9Ahveggj6?=
 =?us-ascii?Q?lRRe5Vog+VRBqKq++65qqW/nisw56fSKQOBcFxEosoS8UPvcx+o18vCNmiUH?=
 =?us-ascii?Q?SuCx7QxkXXIe+GUHG8TVCGDSBCPIUc/uBR5FLnaE4O6gLiJwcEJ7RbUR6fxt?=
 =?us-ascii?Q?gGqiv9H0PGJ8ExzeXx+J4UaDHcqmkg/QWEo0qc3Pb58ocYImMscHuoxHVDp5?=
 =?us-ascii?Q?mQnJ636DMRCgppkyQXaWhuNDVClPCMwH0vzryzpm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08323f0-c541-45b5-6fc3-08dd5d4e5aef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:02:07.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4QXU/e/3Mu7PeLZb/+07Rk6k9ROJSXt4mu598GqdQ/8lqRCSz/ADNO5TQqXId9dCT2Ack9t+GpMzvnB0BiTtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

for_each_possible_cpu() is currently used to initialize cpuidle
in below cpuidle drivers:
  drivers/cpuidle/cpuidle-arm.c
  drivers/cpuidle/cpuidle-big_little.c
  drivers/cpuidle/cpuidle-psci.c
  drivers/cpuidle/cpuidle-riscv-sbi.c

However, in cpu_dev_register_generic(), for_each_present_cpu()
is used to register CPU devices which means the CPU devices are
only registered for present CPUs and not all possible CPUs.

With nosmp or maxcpus=0, only the boot CPU is present, lead
to the failure:

  |  Failed to register cpuidle device for cpu1

Then rollback to cancel all CPUs' cpuidle registration.

Change for_each_possible_cpu() to for_each_present_cpu() in the
above cpuidle drivers to ensure it only registers cpuidle devices
for CPUs that are actually present.

Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v4 changes:
  - add changes for other cpuidle driver that has the similar issue
    as cpuidle-pcsi driver.

 - v3 changes:
  - improve the changelog as suggested by Sudeep
---
 drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
 drivers/cpuidle/cpuidle-big_little.c | 2 +-
 drivers/cpuidle/cpuidle-psci.c       | 4 ++--
 drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index caba6f4bb1b7..e044fefdb816 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -137,9 +137,9 @@ static int __init arm_idle_init_cpu(int cpu)
 /*
  * arm_idle_init - Initializes arm cpuidle driver
  *
- * Initializes arm cpuidle driver for all CPUs, if any CPU fails
- * to register cpuidle driver then rollback to cancel all CPUs
- * registration.
+ * Initializes arm cpuidle driver for all present CPUs, if any
+ * CPU fails to register cpuidle driver then rollback to cancel
+ * all CPUs registration.
  */
 static int __init arm_idle_init(void)
 {
@@ -147,7 +147,7 @@ static int __init arm_idle_init(void)
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = arm_idle_init_cpu(cpu);
 		if (ret)
 			goto out_fail;
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 74972deda0ea..4abba42fcc31 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -148,7 +148,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int part_id)
 	if (!cpumask)
 		return -ENOMEM;
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		if (smp_cpuid_part(cpu) == part_id)
 			cpumask_set_cpu(cpu, cpumask);
 
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index dd8d776d6e39..b46a83f5ffe4 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -403,7 +403,7 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
 /*
  * psci_idle_probe - Initializes PSCI cpuidle driver
  *
- * Initializes PSCI cpuidle driver for all CPUs, if any CPU fails
+ * Initializes PSCI cpuidle driver for all present CPUs, if any CPU fails
  * to register cpuidle driver then rollback to cancel all CPUs
  * registration.
  */
@@ -413,7 +413,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = psci_idle_init_cpu(&pdev->dev, cpu);
 		if (ret)
 			goto out_fail;
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 0c92a628bbd4..0fe1ece9fbdc 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -529,8 +529,8 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	/* Initialize CPU idle driver for each CPU */
-	for_each_possible_cpu(cpu) {
+	/* Initialize CPU idle driver for each present CPU */
+	for_each_present_cpu(cpu) {
 		ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
 		if (ret) {
 			pr_debug("HART%ld: idle driver init failed\n",
-- 
2.34.1


