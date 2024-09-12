Return-Path: <linux-pm+bounces-14057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD50B975E88
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 03:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DE61C22497
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C83A1DB;
	Thu, 12 Sep 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WUpjnsuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25822BB1C;
	Thu, 12 Sep 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104634; cv=fail; b=Zgdf9+Y/Z+1ZVKCQAWw0slQ6bXUXcpPJ3mVNf6nSIt+8Tu3TN5Ivuyx9vFDc6XnNIOtSEyOuajZnz8McT0KV0BcPBAuuHpdq5oLr2gPCSvDAC7mwAn6O/hO9XQbP/6oG8P9Hbr7DgeJyxc7dNHDJ4YUVzAQdFwKwW4vR+7oyIdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104634; c=relaxed/simple;
	bh=oWbyq55rcMN+dGMCnTiSgszx7xXD2khepBPItvrXQe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAtHXi1Dg5DFUglRmguYZtOsV0W5FeAVOJXe2asXMSUv0yfU6s+9+aFk/tPHjuxWTTSNfBiOckmdx2mc3upFmfLXmt4O3g2B9kGD7BXTF5uZbEMvuchhTARuvhFLk+esGxAONAwuybro+ZqPCJpCKpiPyKtoPL6In9dt6USRuUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WUpjnsuQ; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/MKkhSb4FL1FF1Z/vyeYO4OrWGF1KUGXq6DfiNp13gOmoUsBxWvvE9gAeSJGXU3hj09Fmhy9Ll1nHmTd4gXeaHxRLohN6T5s75rfQNXKYK1K2m3Mf2cstY01aXTXO5W6z/opMwfn3tmvG6rJi0QgCnJgx1c1l32W8epdF/0wRcRCPuJ9zjfVvatNVl53LUjEhBvVs91JcV59rYlflMPrzMidYEvgKUKG3pQ/NjZ2AqyPDcRmoO3QK3aZ3ROOaufL/prsTFKZoFNZwMvDLRzGqurK5h2/ii5VM21UF+xA9j5g0C6td5F+kaSWBvTiERQGUwGPjn2pHqEq7o6YAlsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJQjotCYTkWH2LDuMLlgfmORa6iefUFkK6B4n/nho80=;
 b=bkku042dlU02FkT/136pXvoUtMgP9SvUI96b5mJ2uFFHnDBQIVqroRJULmi1WizdL+JinhvGqnFLA5Qr2//H85IMHNJjDLAah6cxS2HrfbHSH2q1vzqJ9knjR8sCK+t4ImMeM5lRQKGSY20hLfc8E6oz6ZpAdim0N1wLS1LWJsa+R6PpuuwRQaDbdpp5oty2PkovxprvgdYnENwbmtz/LjoVBYTh222c+q6hwsZMUqvvlMzsOmSbC/54eQlv4JNvHzdSoJbk0GaK1A46BkqKGfDE7EMzekxegbrhWxdC+TLSd9BVeiPx42shk85WrlXqvsMpeu4euCuTfvjly0G+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJQjotCYTkWH2LDuMLlgfmORa6iefUFkK6B4n/nho80=;
 b=WUpjnsuQJVVGgkQyXvrs6GDJV8SwN5SiWlZEtexFWCwkWndJuSlOuvpug6Kkgugi+d4DhKeHfc08ds/1g/CTc69qo3E2z2dl5ShB6KsvH0g9ecN+WBqcsV+43aXEXjUIPRfwZIOXbS+Or5v7XDeNUfwzedQHhAGOKB3AzJdd1+N75Q2+vvEXY3YJBu+YgDctGORJerveiD270FlMWk9/vEhUz9JBcSbz3Kj1MdXSbvXFCx46qXl4r4AfVbfJ0FKJ0fcm/4GmdP9BUQPiYeWEJtjhv7OgyfED2R0te7Qccy6AkWU9W5fyM1USeUEZjCPjfWf0x1Q6D8RAfzhsFfZ9nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 01:30:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 01:30:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] pm: cpupower: Makefile: better support cross-compiling
Date: Thu, 12 Sep 2024 09:38:45 +0800
Message-Id: <20240912013846.3058728-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd9f881-07e1-439b-270d-08dcd2ca7b49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RJ5UiDZH5s+VjB5BwiXDsVOJJ5A4NMKf9a7gq+C2IDEHnq2DIHi6ruNh4Fwf?=
 =?us-ascii?Q?+hPxVpnt4Uldzd3Dn5PMm49+5Ast4KMKccYGOTFyu/dR0n5z8JIJHNkyOAky?=
 =?us-ascii?Q?7qPPZFWNb9sElkklETooiHVZMcIxDKcsPfE4NmkO3hudWpnKw78StsbkVt6T?=
 =?us-ascii?Q?Dz53faSFoeGDgvrSIzKh8S1ORs3iPVMrSDfjTtnKZAaPG9El111JgWaJcPdC?=
 =?us-ascii?Q?FihOyWOF9X47mO1datPjJ+1Swd5gMowsYcHoSTn8qe0b7S3wyMTguKml/Dbz?=
 =?us-ascii?Q?THAMlv40Sw9ZxHTe3Vyyk+1mjssX+6feLFU1+hQIgugZ8K3DRh56fTAv1QWs?=
 =?us-ascii?Q?e3+4lmBrfHFMU0ggVmby1s+oS5YZFYgXqkSQS1p6H5DdljKBT0T6HRp4jNdx?=
 =?us-ascii?Q?FZY9+aslMM5UWPJ8Z6WRu+u78vrrgPCgYHj137t8KDkdwCBBnmSNgW0KC0wv?=
 =?us-ascii?Q?zxAf6PobeBBtUvD0ovom3mMMqDsMx/p9KVZay3eJWDbqH07f6xDvklaVCtHy?=
 =?us-ascii?Q?V956atjiRmHZ5g/h2JcYJ6N9Wbmyfm4fHCu0Ad8B0IMT61yPhP1N4fTPcOHn?=
 =?us-ascii?Q?Qga+ci8HiSnwbUBrCHixf72MF+UssKBkH//aJt7rYPKQmWw6yrU3pWOel3CC?=
 =?us-ascii?Q?i7TD/rbaosSX6O1rAVSwfTms0y1VXHpHHB3cb5wpfNDqe2sIjfP9APLPlSa6?=
 =?us-ascii?Q?5DDNQzPK1pns+Une3LZfaGwMuqBS/hOMyTyf7DnbH69c3y8Rqdog/Z0s674r?=
 =?us-ascii?Q?zHyi/LXDCD+7itsJ2DenKtztV9zLzBBvD6cHp4c55HXfWEjvZhJANs0yTGI0?=
 =?us-ascii?Q?A95PANqLAm2yuFD583PxWywJfrJTyaGMi+A4ePZzzOWb1TN6yuw4h47XhBKt?=
 =?us-ascii?Q?sbq6n9FK8Cqd8t8uFDJDjgH/M/7al1UdW7tW327tH7zuLbdbVsjVqSBsmCJM?=
 =?us-ascii?Q?LCXVBe8r+/FoFXDpfngseINy8byN1CLnl6utIPLUfan10qkf1LxBz8WkZrYX?=
 =?us-ascii?Q?SeB2JEH7SqMf41RUys9uRl58bKfJVWhIDh977ErrRgSD8VyNrCnvpqO7q/Mx?=
 =?us-ascii?Q?Tvs6FDLfaSRf/02RQC7NuL9eW7AfRjfLVEkm7uiiz8aKSHm/ZCFxM3G+TS+W?=
 =?us-ascii?Q?1nQ21kMrdXwBBsb/nxKlJXQQQVtJbt/vfl9nsZk243a395vJL9kuQWzogq4l?=
 =?us-ascii?Q?ZxbkkOPHRELsQddmNMjWJgPXA5CpxUiqrJOAezJIoK/F6/jeCzK9GclCy5MR?=
 =?us-ascii?Q?ZU2iGPrOBCO1S6fPbLnkh24A65QKzN1tL50fL33NBwbFkxnK6TH36G8NJ0am?=
 =?us-ascii?Q?fjrB6vowP+B6kyLfloeNGAUe2FU6XO7EDTLsLn2h2VT591JRL+1NVzEq/T3f?=
 =?us-ascii?Q?fQE3pTYJPoC6qb8BU+Elduat1WcPf+6kLBoLmp+slgDbyez+Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vutKO3BY8pQFHqomGIrKQgTHwSIYvcyfIJ8ip7jqF5orkJDyvjWlF8dWP4IB?=
 =?us-ascii?Q?H599omsnqSge+h3wUUaCb0L7J8JI3k5Uz3X25d6VGeajWIgbPYU2ICxLGaJV?=
 =?us-ascii?Q?QE4wWc2GQFNfLnI32h1+dXvTkHMAD7cDiRjquDHRptNOUppkIRZ2BLaLcXP2?=
 =?us-ascii?Q?N3o9iw0QAcp4RLVq5Mbmnxv7jfRaBBKcA2KVDUXY0QYQV8qzdf/mu7NDMGCN?=
 =?us-ascii?Q?GEf5qydJTGrW+wQJM6N682emA06QMu7yd8903O01UnhPK/puM7G/vhOVgeUG?=
 =?us-ascii?Q?JcPDr8leLpgjgsDPM/ZJdnC3x9+9YGZE5KdqoDcrcw6m7casVWdmfs5JGkbR?=
 =?us-ascii?Q?h/uhBJU1XBgnTwhQLQth/tM7w1T5I1uJMth/+/TRfa1KYZ/fz0Mw1WPggpLo?=
 =?us-ascii?Q?iv3Zs/K/mM5gheYzmrS/CU3rjNG68B6W3FDzYaqTVOyRopqfWp9uJRNQ/iaI?=
 =?us-ascii?Q?I3Q8J2CZNxuG8ecM3Vd/F9a8r2dbqR3DweBVnWccyKp830+uoewqSsW072Vv?=
 =?us-ascii?Q?5dBnZuV5Nh76W4ssLhhzlIyEmQ5IcR0//8iBRR+gGhDEQL6sVw7yYPLVZMnH?=
 =?us-ascii?Q?jyTUqAPzzUyWf12J8g1RbLANUjBjpfrNsejm7XukpwLEvAnyRutHrMBBhXAD?=
 =?us-ascii?Q?KK24Lklg67OUcraEb1dz9HzrGX6wCs0neobafYUTLGFWDcR7Q5XzEI9KeG+o?=
 =?us-ascii?Q?NuR+7HRyXIw7tvgyTXddIyr5orkcG0vJUGac8fKf+iRpgo81jhwWLOrxU75k?=
 =?us-ascii?Q?9Z/uAc+HjlhV0XxQxo4Q0ARZcf9aWobUey+wRCwKpkFez3clZmeUh2yKGFxS?=
 =?us-ascii?Q?buim+YJgfNhkYW4cCpAs97lNJvOSRxB+g+mBPRoqBbUg362eb4oZCK5UtVsU?=
 =?us-ascii?Q?V0/iZneHJwm+iy0ytbKxUCzeNAuxXT/g+Gu9ae5Aa5Kdbz0o7oIctqib9oZX?=
 =?us-ascii?Q?NDEPUnt3DXk4iTxBk5WGDDquMkt7F6qG1epYLFp7mV1mbyb21pKmUAoc082/?=
 =?us-ascii?Q?ctWEiUgPUhQxwCJyZRNJYVowTqLNEPhkrmv3x4zWFXDSCmQexIJwK+VwdeZ8?=
 =?us-ascii?Q?25W94NRdbnvJLK1fgGNVDx+ZXZ2/STC/+AWGUuVjsnxmx+x1wcYn4V5nEOUe?=
 =?us-ascii?Q?axZIE3FJM28xjbd1ACSL+7iG4GZXAqeUB6HJmY55Mz56OBhpPbpNcLNAXVk6?=
 =?us-ascii?Q?ayTUH8EwX6gbI3bQbnN7U3CZuxKL7SrWA8iZcOfiQpOFMbjquZ5wtoPQWneL?=
 =?us-ascii?Q?cICe3KmdAt7r8vNvj0qd0G+o+ipQ0FCExMPTl/83LIEDsvpjqRX0FApkraFn?=
 =?us-ascii?Q?tO+zUMLK0CLY4jM1S8NWxZZRsvYWSPlCh6S5rwmdHwSOetR0VtdpaUTF3qGx?=
 =?us-ascii?Q?QY0nOBI6zeiGpEcdzpUGk18woh4oaJmU9+qNgef6HPvySp5bTE/lc2al1MZ2?=
 =?us-ascii?Q?TCUnrU4aJ9/SK79lAU4v8WxZpOP/WJmmr+FH3cmIB7wSE48XSzMFHo+wznFa?=
 =?us-ascii?Q?NN6SnKoZMh00lTa//NgJdw4UtyIXudicVMYEC9NmDl8xnhzm2Q7TNiqQLar9?=
 =?us-ascii?Q?SYsUhcreGFyhBtPEh0KeDHTFEgpXHI9M/I5dptev?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd9f881-07e1-439b-270d-08dcd2ca7b49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 01:30:28.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAp2PnTiHIqEFBz3qgZG/H/dlZW82POhZf3FXVc4Kre2wpma951WMOeMzksG3B6bgMeUr7fhOufoI0Ktta2xPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

From: Peng Fan <peng.fan@nxp.com>

Allow overridding the envs, this will be easier to user Yocto
cross-compiler toolchains to build cpupower with only two steps:

source (toolchain path)/environment-setup-armv8a-poky-linux
make

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/power/cpupower/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f401069e..e2a48af6fa2a 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -86,12 +86,12 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
 # If you are running a cross compiler, you may want to set this
 # to something more interesting, like "arm-linux-".  If you want
 # to compile vs uClibc, that can be done here as well.
-CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC = $(CROSS)gcc
-LD = $(CROSS)gcc
-AR = $(CROSS)ar
-STRIP = $(CROSS)strip
-RANLIB = $(CROSS)ranlib
+CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
+CC ?= $(CROSS)gcc
+LD ?= $(CROSS)gcc
+AR ?= $(CROSS)ar
+STRIP ?= $(CROSS)strip
+RANLIB ?= $(CROSS)ranlib
 HOSTCC = gcc
 MKDIR = mkdir
 
-- 
2.37.1


