Return-Path: <linux-pm+bounces-23634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75DA56AE5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278103A8458
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040CA218AB4;
	Fri,  7 Mar 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhzaBEt3"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B771747;
	Fri,  7 Mar 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359282; cv=fail; b=RdEwWcPnwLP2LzaOT6IpXjZj5h8j0+bF8gxGTh8XeRJ5U6n9XE4PVXaFiDUAq0oKqh22VGi5Q6pQ17lv2B3NKA3SKxTs6pAQCEJax7uFtIQT6qvD39e1EX6HPGD3xyd8PRu2GEcCfhjBMtWZSxpH7xFjfb3MpIvAIjDO9GXmKZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359282; c=relaxed/simple;
	bh=1MOvp73et9HZhq1qg3KiNBuBkuH7wPsk88ZjujPywCg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bRZaNYQ0DkPAMLF7yIvs+NDGakhCYv+MSDlwvQcJn8iPDWDO/dkHyvuPVSOo2mSr7uQ/ul5P2LwGNVvUIjMvVWEUrhsKPXwNlPxsjXRZU/SuIJ3acfgmvNgTfs06F+cktOowO53IJqy3NRZfjGZ03RVo2aB9fLyhOi/dLl/YNJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YhzaBEt3; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmFzTFmca7Oq6avp1bKg/o48Zh0ebL/S0thCGly7PpunSU9lPW2GiMosj4pcY0TnUajfyqbX7EG1TFJ3bzwwFSJed0IfriMB7JhGoYXMAki5ne+iEZG2nqnFTHWmW5aIOm/R43KLdZV+gj+Sz8fjKVrE9ZtuOIjSyx1DNg1vAejAUPFj5rq4yBUOJQFrHAJPdQ9uoWiPBaSmiFjO/9s2KH9suxNnAluYammHJtSDjSvpbcb1gjhKIzjjT26D11QR+HH8zY7985/Zq08HF9NurQ71Sc66h78Qqe4rVCvlVqKXdnPkPbdxxjghizVnOjqMKuFyYr/ml/iHgLoNOUwWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOZT9ACCIXTZeWBzoFzxF/jWtPg0jUQ2U1wCLx+nOUA=;
 b=guRe+IXVVpSpQNilwCOb4VN/xPmyeQg47JC0g043jXybeU+SEhWC6uSxEktn4ky0b3FjQDkLnGm5gXgpAHIzJ9V3J/MNwerFS/+YiuiXi14umInutcbsYSBLiLU/d/5xPis0MNj7I+JcwnGjrYqdYFXeesL2ejuiaEDeTAn04BPq14VD5QjsI7qEpOjW5FU7PPbITo7Z9CkFxEy1tVE0y45LV5sEvKbf54Ku4b70W6OJMr+hd1wkMw0f5UWMznI+w3NNZtuRLscVDwqaIaTdLLPDzgQYhTq5FaJypZiGdimPwtdfNBS74lgyXOEMUqkjT5vAgJX7xROgC3iVT9teyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOZT9ACCIXTZeWBzoFzxF/jWtPg0jUQ2U1wCLx+nOUA=;
 b=YhzaBEt3d6RkCJcTtXV/yQgTGjcVfG6AxpYwEB0+DvLfzdU/uzTrwmuEUVTDE7e5Hyhkf+sFuk2HYMZ9GgeHX51oGPJViNTGQfntamf6wkqM/cYG919DSlSFwEU/aGuCCe1M/iDl/+5NEd0yqAKdUaS7KKwJ1cR8hqUE2VIXFqbtYaz4L2FWBpnA0NAgI4P9pMC0rqfpIRbSyBpuR8rXcoAHrEeptTDh5tp9zpW3Zsl/kABkizTOeISYGWJh5BMQm+YlcumjN88sY9uzVrDaKfL4ff6BmlLGmUep+q0106cw/pQM0MrkE3/L2oGxg/ixlDxjnTHRGme0XjrSckKwpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by VI1PR04MB9908.eurprd04.prod.outlook.com (2603:10a6:800:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 14:54:36 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 14:54:36 +0000
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
Subject: [PATCH v5] cpuidle: Init cpuidle only for present CPUs
Date: Fri,  7 Mar 2025 22:55:47 +0800
Message-Id: <20250307145547.2784821-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|VI1PR04MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a27993e-4d49-4ebd-6d01-08dd5d87faa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nbcMkQmfqr8YHFkuR0VWcCKaAiKEXlbHeuiQODt4T+/skYx68AlLsZnwfCdf?=
 =?us-ascii?Q?+f1eb6FYcMykFbpIOX73fXiObBvRNMnUAVH6jfSGlq2hzE1agyyUe8dPlrmH?=
 =?us-ascii?Q?6lBDgusZto4UEiFzjUR2UdaCT/LnKoDwqkg/DOmsLg47X6uWDIXGGg/GQhqS?=
 =?us-ascii?Q?LaFTo8tDsy0vOmrQ5ZIdhuqSaOylFd+X5R9utKJx7UG0Kh6m45GLwX356Qxd?=
 =?us-ascii?Q?DomjkEHezTya9xiC9EeDJimNdRK9pFOKz2gvGrZcat2hFTqheob69ieWK+HN?=
 =?us-ascii?Q?7uAqMYT6ssTeOj5QSajN05bidF/pf095tuhkHvAiP1hOaSjAhJjZTTTBIg6G?=
 =?us-ascii?Q?lglQacTHUf1z9FC8ZuTA5uxrvT7gXapmT6uUYw18NmXcndQAVbAEXxRPMYfN?=
 =?us-ascii?Q?8VxMA3es03gkCbWRDmCAD7F8QrZ1DpKuplYr7gnq8yyvoAt4JbSQ/wtnBujT?=
 =?us-ascii?Q?A0nDBvSAS+fMLdFe4KywjrmXjVkfs5rn9fSbQTBeMc+3DNpq2PwO5BhirAuT?=
 =?us-ascii?Q?C7E23JWBoTU4fZbcyPpm63j7UnrQPOjwNSiSfwUThrU913EwhV8OHGdttgSN?=
 =?us-ascii?Q?BzdyzQ24hMedgTaNtEqDgM/f5gjcTc+/RnVydM/wa6Z7Dh+XzcXtx+kiEp+o?=
 =?us-ascii?Q?9p/Psmvb/bs1iM+ozIBAXsf+3Ged0Bt3j+vRmiOoWWOYSWz2qZUU0sGBjdSc?=
 =?us-ascii?Q?g7PLUEcSmJ4pilvkYeymC33VqtxTRjz1hmORNvitc+IDd6soSuecg0qKszLY?=
 =?us-ascii?Q?2R9oNWfQ7BtgPjXWP0jrtvN8MUaOV40Rs5p/2r7oT724NmQ4ISXmseaWAJhT?=
 =?us-ascii?Q?d3pUUeIpsEKOKZzioVboQU58nlVkF8MpAWCAL3IcnRFLRHf+aBJx5PvHCQiT?=
 =?us-ascii?Q?5Z1uF6urLiZ46tjrF09m23NBsP3WnyVHHXEQv7XMcs6bI/UhW9AwWPdoTwQk?=
 =?us-ascii?Q?iLN447SpOFSA0Yh299rNfrq0WaC+1vnbJR2+aBTCdDYPnk8IpToZjwX8EYAe?=
 =?us-ascii?Q?jbBWQEk/0R2tfMAY9fHOeM7lklVGdk5IX1Lt/obpTBfz87Oq+/7RZFEuoFX3?=
 =?us-ascii?Q?8qUzk6U0vF3Gky1r/Q07FC3X+/cWtvqwIJcKDHwCxkW6509eviaAN1COYpTC?=
 =?us-ascii?Q?H2Dg5dxL9QG4HvbapCAqwLGfQd5qFIZpdgbsZPNJvhmdWX0I3twpLhQuDcQw?=
 =?us-ascii?Q?Ke1OHO+1VnUBRlBadYFUB1taHBIzdDt6Enc9yUvzTf8ej/A0yN8Wb9NrFw9v?=
 =?us-ascii?Q?mPmVYj6157xQTq/MWs3Qf7IRPvNFFC6fkqLrQDX3alPnXRvxyX+dqwd2MmFn?=
 =?us-ascii?Q?e4jNaBA8AxJI82bFv/u5zTkWN/2LJd/8MRSWnNViGCgPNl5BPu+sA0Ik31gt?=
 =?us-ascii?Q?PJBg5j9vx4zgV+P2rxwlZd7DaPuOQXkmKvx/AD0Yb77sxyqgQDoQyJfgC4MU?=
 =?us-ascii?Q?FZxxcqnkD0sxfK1f9eNCy8b6wnQNDB1OJPz8rKP2DJHcDbbuZ/IZ1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GV8Zk4a9FPMYfKwvbdXfGFzqWHMSQhnjuzpSayC9AEpv3AA7zIebxSJbkKIn?=
 =?us-ascii?Q?o43ZH2MHfORw3jEmI5aJQBgh4qFkbT016Kmd6apdqdLXmpdYWYerFaVhoVoD?=
 =?us-ascii?Q?/9uVqV+5NPRYrsCBpoEpk4cq8Zg8bbKMVqOrVW5ACfbPoz/ccedwybT6HetG?=
 =?us-ascii?Q?JZBimWyw1x3OITe04mQjOEYxh5214wV1Xx1xjexGZwztEG34DhDPoGLBdOBO?=
 =?us-ascii?Q?GDKtvh5CHnVXdraDLVCAwkeU0hHpN0E+j3jGy/jJnAUZzC8J1I+S1Blt5c+P?=
 =?us-ascii?Q?0RsN2VcNOndnUPR40VHdU4O0cqMs3K/UdFmeHEtOtt8J3PYGnysxdCYDVxCp?=
 =?us-ascii?Q?4NEBsT4USzcKeub1QrhVVQcRA5TvjAeBDLLkjFwlU42kEs4F2wibe9jh81lU?=
 =?us-ascii?Q?J+jcAtpsosQFFnvVyYljGQoXhJploGgv26j294pV0swC1jZIb9uqpHKcx816?=
 =?us-ascii?Q?JrOYY0kEC+5a8Ej8hZCAwQdflzRRoh+1ACJCkSZvIFiY1d3FbHj8HY4CwrOR?=
 =?us-ascii?Q?wY28CqKXRjwoFfeXX5jBR9srU7lgIqHP4j9oxFqM7sJWG5RgHdBJdWUoUFw1?=
 =?us-ascii?Q?94NDLJDZFkdiU73fy+Hd1x+6tDFnyHKbNWSd7sxE3uDYhwHwNuuxGpij3h11?=
 =?us-ascii?Q?ZWYHhmCu368p1wbBd2K8fwscQ5eKDdB1U5/6Syy6ta7EBFYdeGlIrHEgzFiw?=
 =?us-ascii?Q?F4jMq5euVWJBXaPfjSfm0wxx/6Ukar+kbM/bOZUibBNxAMFsAd0h8CQgWn6T?=
 =?us-ascii?Q?8lbL5OhpzfCXBaBv7BR2khDteLL/CFyYVjJzULmFSymsV5PAWkFeJ51GHDjQ?=
 =?us-ascii?Q?mhl7gOPF8GOzFVSZWVvyxWem6VaypzuGqYf+mGjdyPl8AKpV0JYEdPsMsm2z?=
 =?us-ascii?Q?PlmoeY+qpq57WmPDhqFI4dtaQ3UQncW/xqeSNsvnAZi3stXvzT0LNRVF6e7W?=
 =?us-ascii?Q?Og2cHBOmShswk8fdHNGdmQ3Kk6/ME6NaRt1gc5wUXnov7pnIU4ewgl08n2lj?=
 =?us-ascii?Q?ADSHUbUhNSa3hegVwbKj5QYMCDD6Ljlp2ndj7sB+VxwvOaZLdKH6Gu5OA/mf?=
 =?us-ascii?Q?aKuDa8dJivTC+GBfyNZbNSYWL3cI4fWkCaUmdjOcCpwQm3fLaqmvJSGjBsv/?=
 =?us-ascii?Q?7T0aiF3gFQDRoibIFqKMEQrfAIW9CXg7ya37/8rybbn/XQYOlr9BM2hqVXM0?=
 =?us-ascii?Q?+Bx9kxjjBxSEmEmHfcWxVOfrOzVKx32Ef5lAGy36th1PS/GEIyXm0CpeV9oB?=
 =?us-ascii?Q?J1bsmeLV7bVV3gDuFjEBgQmY0sSOdWG6QIw2tbw2hc5sWIR0gDBWDDUV6hMo?=
 =?us-ascii?Q?6qQfkqG/LG9pdertMWXm6TtghdQlYEBjYGIGgyXIwrfgoPAr9GS8kIoGvNBz?=
 =?us-ascii?Q?CvMDpSQyFgZ8IRjSUF/BWQhzFGiu73+ztQOaD6Frmtg3hZZSXWgaoGuhnEFQ?=
 =?us-ascii?Q?nE+n/Woj2nbONqa7VuAPiWAnEUII2+OTiHbZKzrXwEzIWpXOOT2RAmZmuL9O?=
 =?us-ascii?Q?NctYb7WZRJOjuOr26/CEE9qTCGSiy/06xFQDg8YGcW6Pr3hwqtnr0QzzFndR?=
 =?us-ascii?Q?oKNuO4h/1Y8txWakMPJ8jw9HRBbRFHLcFhd+rDZC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a27993e-4d49-4ebd-6d01-08dd5d87faa7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 14:54:36.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsPu1cpxXoHLbsd1ImHLVxGJsEmWfBBW36dmUVTMl438yIiyze3Hai+v/CWuJGMhcKrffOtA/C2O+iPwVXRZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9908

for_each_possible_cpu() is currently used to initialize cpuidle
in below cpuidle drivers:
  drivers/cpuidle/cpuidle-arm.c
  drivers/cpuidle/cpuidle-big_little.c
  drivers/cpuidle/cpuidle-psci.c
  drivers/cpuidle/cpuidle-qcom-spm.c
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
 - v5 changes:
   - add changes for cpuidle-qcom-spm

 - v4 changes:
  - add changes for other cpuidle driver that has the similar issue
    as cpuidle-pcsi driver.

 - v3 changes:
  - improve the changelog as suggested by Sudeep
---
 drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
 drivers/cpuidle/cpuidle-big_little.c | 2 +-
 drivers/cpuidle/cpuidle-psci.c       | 4 ++--
 drivers/cpuidle/cpuidle-qcom-spm.c   | 2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

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
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 3ab240e0e122..5f386761b156 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -135,7 +135,7 @@ static int spm_cpuidle_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "set warm boot addr failed");
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = spm_cpuidle_register(&pdev->dev, cpu);
 		if (ret && ret != -ENODEV) {
 			dev_err(&pdev->dev,
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


