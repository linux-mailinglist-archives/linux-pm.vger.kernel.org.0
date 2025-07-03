Return-Path: <linux-pm+bounces-30005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8FEAF6755
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 03:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1967F16AF55
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7B18641;
	Thu,  3 Jul 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XIYcwZUc"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E715442C;
	Thu,  3 Jul 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507372; cv=fail; b=DXGh3JtXclO9tutvprFkSQN0Zvsql4ZL/BkS+/OOzVk6ONioPrY2fISHNjPGv3QT2fJaVtwDjPFWoIsvgTGZrxWOrLNP8uRP+SyU/XF3QnkXnhqATM38GcbP8OzaLZtJx3PupYqfofUdvNvrHDb5SHtxjweZ+CrcUvlciiDQ6so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507372; c=relaxed/simple;
	bh=ONTGn1nXSZqQArOGx8YmLe8fLW8tgLFeaRGpcdnfSs8=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=GnlWjMpDIuyFMWUelYAU93s6rJ7jNNeD68V9TKa7gS5ESySO2rp/lr9ctvdMMlViL4pQ90MxtExRPCp2OX26Kb4vfYRSEIwvk8oSOycK39fYP3lu78Aie/TnpjFimfWPDYvJGRLvSFjoRPGtLBrWwsjdytVaKEmgRpVqz3ijXHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=XIYcwZUc; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d89bsQHv2lOFGf9Cksv2Bo7dM9WMlbfnZr+q7DHAzUHnnBfS/zXTC/195RIkmSgab5QUNtp7d5nYoBZljkff3MZwb6ev+O0HeVf6jDaRRuClge/UbAQuZF0mvz9tQT5pRhyLZj4UwYDuVmKJyC/xT+3KUvlVr7oYRZS48irrSybtz1OQyEABncR6CX76j7GgHfjnP99LCbz/TdEjNd5vzqLhGe0Ys8LA1V9fC0jwq76T8OR+NjWVzn7Kc9Ly/UkenncN87gvVCJXGYqxrPkuKupp2dgLe/T4KCqTcZCiLsN9UUcK+cvVB9eer2zMt4Ikvo03p7eX0gGDUSipqXIP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o8+spcbMcSbLXVQMbus1Vwvq8wzXBaGXNHnEADyNs8=;
 b=nDWp6aQzxD0Thi/tI6OHpOzMm7q/ko3eixXVHc6fwMjJi/4BsUBtJJteBO4usC9iUC+l2m/dbadqfcva638aG1YMNOSXhXWN4lTv9RcS6W6Z9cRHMuKiURu5UBqxZE5AMU3BmO0KVDOAGTfv7+Siki4f0qtfNws3QXfOaF+9vEXXKMGQH+6Fli8TR/QLCKKSm10UL+to4aZ8tzlZrCbie5OCoNuFVw4c9RaChHhPbOhiYSLQXr25xSBrFRHCgYFd82I3qD8HtGTthwzWpNDISMyIMs27WkoQTO2X4Qsjt/pW9lfWFhQtjl/iRrW3RZOI3J98kMcdNs7dMiTmHOJ/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o8+spcbMcSbLXVQMbus1Vwvq8wzXBaGXNHnEADyNs8=;
 b=XIYcwZUc3MAiL4S+EUGej1raYgdwmmRXZJf21HBFExBUp34oRE3G0pXc1qPasakuQIxBHLQvJhQIDphzf7uGbgJeOPNTX+LNuj+8Hi9hRn3F/y5s/Z2YT7dw13+H5d4GSsKJtDIQO3FwbfFzrPA47up1yfcxdznP20YdbQMuklw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSOPR01MB12299.jpnprd01.prod.outlook.com
 (2603:1096:604:2d9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 01:49:27 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 01:49:27 +0000
Message-ID: <87h5zucac8.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 3/3] pmdomain: renesas: separate R8A7791/R8A7793
In-Reply-To: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 01:49:27 +0000
X-ClientProxiedBy: TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::8) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSOPR01MB12299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d391d36-e727-4f29-f5c6-08ddb9d3d86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mrWeO/xY1y5/rd7nsDmUC/7bLOyqWjwCeqwKBLzveGTls/Pf09aqIw78rS/I?=
 =?us-ascii?Q?1Wha5lAJXZfhDVTo98QHDo3k51LX4WD+XGgOBhqFWvAuPyR4xg9dYLZIZYD7?=
 =?us-ascii?Q?iPnChObyO7AMbUGD9cIm+xgMCsF5wCPT3BmPwTywsb0F1bsoUMYWuU47t2fs?=
 =?us-ascii?Q?k/PubVv6nTFhgSqYSn4KdvCbQoqGmhyv4oT8nfQOlWgKsjTeHwHsU28VbzYC?=
 =?us-ascii?Q?SDZJ+We4+/8I8R2aLgu3dI2WP8bnZsME1BC04k7wRfRgYEfRXAZPG6g8i3Dz?=
 =?us-ascii?Q?j+P6ersg1fXs7RlT0ezpZt+nrlmaR1iUmmkHp03497D5BBUl6GvtcrBiwyUV?=
 =?us-ascii?Q?dzPJHx0m4TlFYfovVqtX16p21sa9squRzEU2zvf6nZ2mxUUXrr/qhmf6uoqZ?=
 =?us-ascii?Q?7HHFnnnYT9MXBfoz36MFonIivnzLmhN5KBjlAPFepRfSEvAE7wv2mCJXDA0N?=
 =?us-ascii?Q?nl6BMvwE/rjcRNC8Gq/QTj6kGLdfksMGu3jq3BZadMcB3VYgCUxJLKlxZRIo?=
 =?us-ascii?Q?mj4Nx4jG/6Hw/bhyVtaUdGSk1CU/J+BKDiXn3SGfo06DQC0bj6BDDVWcbkGS?=
 =?us-ascii?Q?bYBaSKnyQvhas9MiFB8Vt6m5uufq5ml01BFNo0VFQ1Hfv6dStbNuYPcsjdea?=
 =?us-ascii?Q?PklDILwF6I7Dm9HPOhNBqNRWtfzNXuo3f40hLpX0REmzXY2bRjgljfbYnJpF?=
 =?us-ascii?Q?1U2vPozsNCrasadYB+xFO3QGEEqoiblt8Y7+q+kgHWX0dMB/HEoBydLUp6HD?=
 =?us-ascii?Q?ogABDttmjGnpMNRctXSh8Iv31Gyr/giVIg1nvSy05lzWWaDvsCGR8PRZXrf5?=
 =?us-ascii?Q?Yn9YJq63/yv2tjgyc36KX+yagIwA/p+IQnKpM77J2lKB+PV0cVnMyC+cpesx?=
 =?us-ascii?Q?Z6bXdjGIqNxgxsfp/H593T9qrxnnt69LgIky6Yf1+VG8gNQin6kRu88qMOIU?=
 =?us-ascii?Q?THzhxwkJ8HZEBTpNBoHNc25PYuRZlAJjpojk8s4GDWBI6ivM8xCQrnyx9f2I?=
 =?us-ascii?Q?lPFClldL+LWOa4D6YRBrdgHkvwqENj9m1C6FRpNLKsXI7v6ai9mGo43msNI7?=
 =?us-ascii?Q?oJSMofAa35PBiHEUpf6A0qs8egacmv3y2tr/549mGUd0MipM9Cg2SROaaO8/?=
 =?us-ascii?Q?nugLe6u86tDv0IpPs0iCgZYuHBnPa9xGJyTSL0oAfVRpL2l/CLnoU4yaBpr2?=
 =?us-ascii?Q?6D0D5td/TPNGq2Io7FE4RJm557nI0tnq8txleEXzYHLfwgVNyeGxVRiNXEaJ?=
 =?us-ascii?Q?+ls4c5mX/g1s67/hN1J9HKerMHXRFVWSKDvbX5uzRVCiKU8vZ184Qr2WpAz5?=
 =?us-ascii?Q?bm4wxYB7FM4Xd6+7MVSP7FkUHV34Cs0r7gP7z0frosX/vpSI2VqmpGHNN+rH?=
 =?us-ascii?Q?+G40WoqfKHXPW2fOyAKQMy8OJ4ziMnu2hqZixUdkAbmSL7nX1/vsHE4KHaI3?=
 =?us-ascii?Q?iXKCnzeI+QmbMNMJ5Xqt0yFjnImVAoogx+giTkSKPSA23SQ8532rVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37+ZXtuMN6RDTcMoHFEds9DWKj6Ga+75w2Le+K92Y4wikc8Rt4O8rfe7Hpq8?=
 =?us-ascii?Q?WAEhnQJMzJH5PIcJbLUClQMLTwXiWvKUh+Q0umc1WJQDPtHK8WWJNeOl5B05?=
 =?us-ascii?Q?md0RsLTG8Nf+XyR44ZGMF2wDXBa2U8DMb15mZlq94fNsEdP/cn4lTYUWijGV?=
 =?us-ascii?Q?mrgIoj9SpLHTj5jbhafGnyfiH7vbMdyqAODg+jOLgKX3spRIpLYe5qIFO09U?=
 =?us-ascii?Q?h28vKJ809PEtmgfhBhGP/9nM1YDRF6vbsulmzg9mxxJUjC2fAV3gx8oEeYIu?=
 =?us-ascii?Q?9HjMTB3Ig3tVBePlD1VbcYI/+Jcg+3sNIdYgzUk0/rlVxAJIWDPQ8iHjFQ/c?=
 =?us-ascii?Q?RpLniaEJzr7Za0/HzCoFeuN7FCkyJgfDtJkA++tDAsm90WzS6ZCHS0fnk+9D?=
 =?us-ascii?Q?6RXozZ4fdgXyFm8q/0nHNdVOc6Ryq8KDw7MAtdHCW6aUYrFjGmMclu7l+d4b?=
 =?us-ascii?Q?vA3Fe5wKnQoXIEmQQ+HftHAX7MR2vN+bucMgfr8i5M0huD01lchG6mqVzbJJ?=
 =?us-ascii?Q?iIB4Z5wW662LrGMaqa8CEkvlz/2j9dphi/v3aA0yZPruZCBJFlMOQTX6unMZ?=
 =?us-ascii?Q?1kQYtPhIY9CxDCV/GM2rm6J1fXMP+4gCZ0SzJ2rNAL1dYZKCBlhJeOpFEMxW?=
 =?us-ascii?Q?LqEMm4/KN5O6EuZmDaWDVLxXW9tvVErbj2iVC0hWG68e48EcOajHBKOeAnk7?=
 =?us-ascii?Q?5w6RK0yWScpHMNU32ezS7ui1YOyjw7X9QW3YrlsZzDHuUIx2Q27MEz7RGR6d?=
 =?us-ascii?Q?+T0k5JMIH8cRQKEK/sxA/5wRi9znbw5crGQJDKPHf94Gkhv8xfejcHkNyy5i?=
 =?us-ascii?Q?T2oG5FTgBb3n5ldGYXmRQi531r0K5HPOe6JBqHsOptlYALGlytrHzdnZVMyv?=
 =?us-ascii?Q?DEPgcAoOqO8QB2jOXgvkjmanNVeiJDG8NeiG29/lLmzZbVDRSeHown5V7eeH?=
 =?us-ascii?Q?Rmidf0OfLb/7riwE8h9gUF5hi+PAW7EqM+ZIuCTA4iUTXZuV43SXgqm2QG6B?=
 =?us-ascii?Q?VRYrnzpnXjTn2ycKrkDtpOsuCT7h2s4edBmungPzk+37V0wMvpGUqZmJI0KH?=
 =?us-ascii?Q?FxzxeruKRaflgyXGztf7+6B2lIV/drpgU3Z9PcwCrCRPTMkduZZF6y2MNykb?=
 =?us-ascii?Q?2s8H/4109g7JYTnUDX1/p+RBmG+jSJKbOZxcWAo+HqJkgNVLpWgjnxr6Hle6?=
 =?us-ascii?Q?dxJSX7eg/5K0uDdnZlJT3Ywy9pFII0SqiqfJHO8B56VfuTntd0iQ3O8NtYdv?=
 =?us-ascii?Q?AxcdRMRtVcMsfjJCUkKn6n4Y0Vnp2ln3jiWC6kcFIpnbT9ZGD/+hfZMCxUNS?=
 =?us-ascii?Q?6EwejovCqDOLat7bAYdRyDAe9OM58pqel7PECdtaXkMk6F2es30w4QVBjB4H?=
 =?us-ascii?Q?Flu1FGg6d0R5fw1I0uu+389CLAzZWkLHj79PuWQUbehmwwYJstjnd5/5zhjb?=
 =?us-ascii?Q?nm3N3r6xSmqDRtiQOyWzoxPp60eYuqYKbCL0uadMol+x224eV+L0kG/nPtFm?=
 =?us-ascii?Q?2UHmIlQjL0tuywVvoKE+O1MNESYy41Hzn67ktc4yUcFAjnX78WekkzLGU46E?=
 =?us-ascii?Q?5j+yCTDdln+u3hTMW6RzFEzZh9ztP8vydI2CTyyQu9ysGcSP7WU4dtGyoebj?=
 =?us-ascii?Q?CZVVF4VPd6bFOVEVSp+1aBM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d391d36-e727-4f29-f5c6-08ddb9d3d86f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 01:49:27.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUAnDd0cQ1dMHb5EoIYWW7VUdolQye/UdA0FCMgIL3ihuAKfVWrkqj80/Fa7Oqval2CAF2jUgtKc7j2brO64QKjRH0KV4S640GUp7S2YdNaEEQL4qEmHqhfuT/hnbU4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12299

R8A7791/R8A7793 are sharing same code, but because of it, Kconfig
settings is a little bit confusable. Let's separete these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pmdomain/renesas/Kconfig     | 6 +++++-
 drivers/pmdomain/renesas/Makefile    | 1 +
 drivers/pmdomain/renesas/rcar-sysc.c | 5 +++--
 drivers/soc/renesas/Kconfig          | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index b507c3e0d723..d8a2fed2fd26 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -54,13 +54,17 @@ config SYSC_R8A7790
 	select SYSC_RCAR
 
 config SYSC_R8A7791
-	bool "System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)" if COMPILE_TEST
+	bool "System Controller support for R8A7791 (R-Car M2-W)" if COMPILE_TEST
 	select SYSC_RCAR
 
 config SYSC_R8A7792
 	bool "System Controller support for R8A7792 (R-Car V2H)" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A7793
+	bool "System Controller support for R8A7793 (R-Car M2-N)" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A7794
 	bool "System Controller support for R8A7794 (R-Car E2)" if COMPILE_TEST
 	select SYSC_RCAR
diff --git a/drivers/pmdomain/renesas/Makefile b/drivers/pmdomain/renesas/Makefile
index 0391e6e67440..0ea5798519e0 100644
--- a/drivers/pmdomain/renesas/Makefile
+++ b/drivers/pmdomain/renesas/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SYSC_R8A7779)	+= r8a7779-sysc.o
 obj-$(CONFIG_SYSC_R8A7790)	+= r8a7790-sysc.o
 obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
 obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
+obj-$(CONFIG_SYSC_R8A7793)	+= r8a7791-sysc.o # same as r8a7791
 obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
 obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
 obj-$(CONFIG_SYSC_R8A77960)	+= r8a77960-sysc.o
diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 047495f54e8a..ea6e15865f14 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -300,12 +300,13 @@ static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #endif
 #ifdef CONFIG_SYSC_R8A7791
 	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
-	/* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
-	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7791_sysc_info },
 #endif
 #ifdef CONFIG_SYSC_R8A7792
 	{ .compatible = "renesas,r8a7792-sysc", .data = &r8a7792_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A7793
+	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7791_sysc_info }, /* same as r8a7791 */
+#endif
 #ifdef CONFIG_SYSC_R8A7794
 	{ .compatible = "renesas,r8a7794-sysc", .data = &r8a7794_sysc_info },
 #endif
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5213eb485a05..da677cbb156c 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -188,7 +188,7 @@ config ARCH_R8A7793
 	select ARCH_RCAR_GEN2
 	select ARM_ERRATA_798181 if SMP
 	select I2C
-	select SYSC_R8A7791
+	select SYSC_R8A7793
 
 config ARCH_R8A7794
 	bool "ARM32 Platform support for R8A7794 (R-Car E2)"
-- 
2.43.0


