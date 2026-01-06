Return-Path: <linux-pm+bounces-40289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD8CF77CC
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7374A300D82C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1469315D2A;
	Tue,  6 Jan 2026 09:22:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABF314B9A;
	Tue,  6 Jan 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691351; cv=fail; b=TAN/NfrQscxOEECTA2MqQFl/Yzs+XrgnOjglYCAMeo2fCNyV0MnhA6zLTWAuofrJMc+bli5/BAcoOz/iOeXNt5TDw8ok4mULrX9WltnaXRGWUuhG9QSYDdx4jrfuktzwQU9/FXUzv0IUd4/LaEUrIKqkOcci+iAw6nVbpyzXi+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691351; c=relaxed/simple;
	bh=J7Ovp3UBPOqu51A4DzLnZdX0QqNu3JgSq3kWnrh5HLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PtsMfREesS3hJ7TPcUJEjYrof9ZexGPAzdR0mWuqvJq8f/QDOZgiOULaZE79b4TQ9YD7uak6oSjmz3sOz7jwPf02CV+qX+of7goPte4N+t4dDKIxcWxgDG5BOXw+ZMwD4YwmMQB+2Pa73vIpIjISUCWZWuetZFMG5XNun5QYvk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGcHljYkmCG2S0ClvY8AN+3lvvhWo3QO+j02GEs3B6eEoSobe2T586E3t5PvR1eKy8XObU1ErtZOUFB+dngqrrHXmG9+bnO+ls0889vdIhS1Y4DTZ5flCj37WysUTndTTRdXm+oYSq5Yc6N5GLbSJg2fuNUxNjyyQ7xj4G6yIJ1LcKLjzVtNwobY63Hcpyok1dfBlWK41G9izDMhPBuxfRRxBdKO7vZLraDKlX2fYvSbfiTJ+dMfmouxgWmAQoj3wHpswL5B5AGGFcHJnGwnZCmJ1DsZCq1FK7qJF9xM+QII/F7YrZTAfvaLGj+NOBJUZG95sEtuQ27dhkZCO2W8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZBFSosnb1fR14zHiC9lQgDymZ0LkoggJk3jqdeF+lI=;
 b=mTyJ9N0yJJ9uZADl1Z7gnKXwwKr/f0GR6WlFdp12JPoRK3PAcCammRs8P/x2w5jceoDXuWLQ7xEDjyNwaDKConUDRHemJJpzQZ1wZXbKeAwfFQla/rCVa8pdMBjVV63+6dpEwsWe25qzXDSRl2Vpuj0YyFMVPszkcRim2OXvmO2cgF5bKhoTmKMsEquDHQ1CVwaaEU0BgfqWUWZMh49D2hOsjJMiRhYy3m0tjbGqpPWoZ2tJBBE/wLFAQyPdmum2LXE8kjDDTLAouFi+fD7JMr74qmMvKWlzfX1VnBBjQDj2S4jHqjPMbAW1swu8HkLeJyMtMAH8FhlzJDqYCER0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0730.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 6 Jan
 2026 09:22:27 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Tue, 6 Jan 2026
 09:22:27 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: rahul@summations.net,
	anup@brainfault.org,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	sboyd@kernel.org,
	jms@oss.tenstorrent.com,
	darshan.prajapati@einfochips.com,
	charlie@rivosinc.com,
	dfustini@oss.tenstorrent.com,
	michal.simek@amd.com,
	cyy@cyyself.name,
	jassisinghbrar@gmail.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI performance service group
Date: Tue,  6 Jan 2026 17:21:15 +0800
Message-ID: <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0730:EE_
X-MS-Office365-Filtering-Correlation-Id: 883800c8-2831-4cca-31f1-08de4d051bee
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	tZ5kZS3TQz72P9HJwMMoXoJQBRWCxev1RrIfOE6L3Ja5qAfzZI7caVORmga/ElAlIyQf9Mcyea8UOqWf0aVzzOstio5iiDcT+VHgS9u8flz5lz8gZrsriem5Nit0NUDOq0oiaPF2FwdZevDM3vi9uwDel06PtGRLR9Jj83PLepPcLGc6XV+7BJkZRyL8/cjr66BKxDDt25VW2O6Mg9oKe3UlLq7gT3MDXSxG6gX0O8HnM7DJGchJPNFs7WHzT9NgE7SI6T6zL5GTkQn3zckqCLJZInoLhfIcvHsXG1G7/07eJy399GnnXLHDNHN+l6p12IYsz2VLwdgqU/Y2UX0mtV5J5hZoFgys2Vsq0mM4pbSDzC1fDT5bz5BVlZT3mGlU4n0Lgz6ETJitFOK6Z2ZrTTXkFd8WW/eVMREBowyEXI8l2LqASw8m65AJjxLJoZCcQmZpSYOEtypLZRl5msYRCTXVcsvdYGEg5jfHhFRyrF6y2+4g3+WVGBWH7fevK8ifdBBaLHKLm9fnjVeq+YdqMzEkOnK28m9/hnTP/2Vxsromjxv8bxdGlVE8JaLOwinjvs7ZuOJZugIU92Celt+KTGzrc9vshBnuTsyV7nmeLoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KU6rcwORFf5mWETFijbCq3FIP2onwtXA6EOAnaPeBbgEhAibYeNzZEUBeFwd?=
 =?us-ascii?Q?xDmPT0DBIYBHHBbq0hRtHdT+IsfztptpOSbqPZHOz6ZT4GlYb2pFw3MKgPU0?=
 =?us-ascii?Q?yxJzgFJ/nifBnYKCM8nImVJpXBphlXvdVi3q/yYc94ge+GMthVLuBOfgKVx/?=
 =?us-ascii?Q?D6LJ8VbgPeNEP+cd+cWedU1UU80Gpr6JcSQL8BTkF4bxL4Jq0RLHkFlKlbQs?=
 =?us-ascii?Q?jvJ7Poq1BvrGxGhAVbUy1z8O+7TcVqChTleYr/2faPfiypVWTXlaw10F7/G7?=
 =?us-ascii?Q?U+Ig53mG9+ubFeQ/EP7CZplQqu5EjAA+TDFRnLryKbCWS/RcVE3ds3Mm5/J0?=
 =?us-ascii?Q?6PBAPerBtlDkxpK+x2J6gcRblDh7Z4ThegsuL9Dy1nALZd7sBO91nrmEqozb?=
 =?us-ascii?Q?OBAl5rNRTp3iolYI3AONpvPjhSc5r1QaYIrWiIcMXIXCxHPX0weMh6CqyCHE?=
 =?us-ascii?Q?GJjib1qL4JpdqAQNXU80NKx0bKEl3TFAUtctgvUY+1vyNr1wxyLWlJDVqImJ?=
 =?us-ascii?Q?xqhNMhzFma8vxLdXLQmerafoDAAh7iDkNnHZzmg15UUa9DIxYEeaOjnEB3sI?=
 =?us-ascii?Q?/NknIBCMz8h98fJkLny6ijl4LCD0OXXsaU4tdcsc7DHHn6yCT7PZSc4JJLcc?=
 =?us-ascii?Q?qNgli8QTKfm6UJB8YLizIXRWVzrBsGUQ3iT0km6TD3t3ksNFNXW13lmSaZkF?=
 =?us-ascii?Q?KIQmHwBKdmUd9bTG8NxK4YAXu2apaFZYzd7XqPpVIklCZAvpviQWZV6Yx/RP?=
 =?us-ascii?Q?adrjjLLqbDQqH08tqQ3X+x9PPEVx4L8BMGKhAZz2KXHXk4wn01pGZ0hxMXvj?=
 =?us-ascii?Q?K2B5fPJTDBHb8a6RZGKK64caj9G1pdHRNE6Trguo+rEGtEmk0511yESeOHnI?=
 =?us-ascii?Q?/8cOrRiLlGeOm6cPCvAA4rNJyRq3ndd7ZokJwjm4cMj/wTLijt3f6Ilf8wg8?=
 =?us-ascii?Q?F8FFu6e+giXYP4q9XVqsgPDl4tHJsvKnZaJYQxI/vwMg+LDPRpWxd9GE03rw?=
 =?us-ascii?Q?z6gaxlPUzK6nc3M0fFAdflhPnscM2fiQ4y3jaqVmrZ9VKfnRnkgsOdFYSIGj?=
 =?us-ascii?Q?LmLvEWo+86hKhKJLYYWU3Ulov7FUldvbtO1xtZzn0hCm65Tsss2THIBggqX3?=
 =?us-ascii?Q?FBGhOQqESKMS/Zn1pyHAj/2nyccTuIAGf2qypWvs6cAq/DccoIkZl3fRdunb?=
 =?us-ascii?Q?6F1FtLtT8CzRy1+RubqTFj5rUWiPMKKA4D8QalfPyQLBBpbKUnUCBMeczbga?=
 =?us-ascii?Q?p2QX4thZeFfZmW9pTuPfuyhoHomVSlRmerT8wiHU+QRSBjgebXT/ZdzW1Kgt?=
 =?us-ascii?Q?rGsatWVAFQ2DNMwx30AbS7ULk57+zzxTWaulepKtzuADpGB5m5ORcH1RIQyp?=
 =?us-ascii?Q?JvbbEJmWj8R5bnifmBzlM6BLQs2imLezNlmK5JZIM9Zt053eX5opn1vQ10lO?=
 =?us-ascii?Q?nfV5iOEdE6euBv2W0kkCgm0/rrOhdSGbdbSGQK/xSeCFS+POm6u2ZPV4r1AR?=
 =?us-ascii?Q?zTkLqr66VgEqEiwWmi/N5m2t5WqCvFehyCvfuB1jzn2pxm183z+ZpMNQD66Y?=
 =?us-ascii?Q?gWwuqmBnQUCEcW9RPFOWOaipyba7vzGXp3ONDRoN5mGf/htcNaoTIIpfekoO?=
 =?us-ascii?Q?WliOWDxCay14sUvlhFuPJ1s=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883800c8-2831-4cca-31f1-08de4d051bee
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:22:27.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9RxWtFw4vDjwYDxv6sGo8Z0enI1a8XsDMw0/bQnYlrPblDk9ZHU0zJ0kBN7JfuJ7j2Ccw6yn3cEA4hzczAgnJTJDMy/ku11MB67dhDXIxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0730

The RPMI specification defines a performance service group which can be
accessed via SBI MPXY extension or dedicated S-mode RPMI transport.

Add mailbox client based cpufreq driver for the RISC-V RPMI performance
service group.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cpufreq/Kconfig                    |  26 +-
 drivers/cpufreq/Makefile                   |   6 +-
 drivers/cpufreq/riscv-rpmi-cpufreq.c       | 976 +++++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h |  16 +
 4 files changed, 1017 insertions(+), 7 deletions(-)
 create mode 100644 drivers/cpufreq/riscv-rpmi-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 78702a08364f..9aaa1f71000e 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -4,8 +4,8 @@ menu "CPU Frequency scaling"
 config CPU_FREQ
 	bool "CPU Frequency scaling"
 	help
-	  CPU Frequency scaling allows you to change the clock speed of 
-	  CPUs on the fly. This is a nice method to save power, because 
+	  CPU Frequency scaling allows you to change the clock speed of
+	  CPUs on the fly. This is a nice method to save power, because
 	  the lower the CPU clock speed, the less power the CPU consumes.
 
 	  Note that this driver doesn't automatically change the CPU
@@ -65,7 +65,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
 	select CPU_FREQ_GOV_USERSPACE
 	help
 	  Use the CPUFreq governor 'userspace' as default. This allows
-	  you to set the CPU frequency manually or when a userspace 
+	  you to set the CPU frequency manually or when a userspace
 	  program shall be able to set the CPU dynamically without having
 	  to enable the userspace governor manually.
 
@@ -134,7 +134,7 @@ config CPU_FREQ_GOV_USERSPACE
 	help
 	  Enable this cpufreq governor when you either want to set the
 	  CPU frequency manually or when a userspace program shall
-	  be able to set the CPU dynamically, like on LART 
+	  be able to set the CPU dynamically, like on LART
 	  <http://www.lartmaker.nl/>.
 
 	  To compile this driver as a module, choose M here: the
@@ -147,11 +147,11 @@ config CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_COMMON
 	help
 	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
-	  The governor does a periodic polling and 
+	  The governor does a periodic polling and
 	  changes frequency based on the CPU utilization.
 	  The support for this governor depends on CPU capability to
 	  do fast frequency switching (i.e, very low latency frequency
-	  transitions). 
+	  transitions).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpufreq_ondemand.
@@ -367,4 +367,18 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 endif
 
+if RISCV
+config RISCV_RPMI_CPUFREQ
+	tristate "RISC-V RPMI Based CPUFreq driver"
+	depends on RISCV_SBI || COMPILE_TEST
+	default RISCV
+	select PM_OPP
+	help
+	  This adds the CPUfreq driver support for RISC-V platform using SBI
+	  RPMI protocol for CPU power management.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called riscv-rpmi-cpufreq.
+endif
+
 endmenu
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 681d687b5a18..9c6304d445b4 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_table.o
 # CPUfreq stats
 obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
 
-# CPUfreq governors 
+# CPUfreq governors
 obj-$(CONFIG_CPU_FREQ_GOV_PERFORMANCE)	+= cpufreq_performance.o
 obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+= cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
@@ -99,6 +99,10 @@ obj-$(CONFIG_CPU_FREQ_PMAC64)		+= pmac64-cpufreq.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ)	+= pasemi-cpufreq.o
 obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 
+##################################################################################
+# RISC-V platform drivers
+obj-$(CONFIG_RISCV_RPMI_CPUFREQ)	+= riscv-rpmi-cpufreq.o
+
 ##################################################################################
 # Other platform drivers
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
diff --git a/drivers/cpufreq/riscv-rpmi-cpufreq.c b/drivers/cpufreq/riscv-rpmi-cpufreq.c
new file mode 100644
index 000000000000..4ef7d76b6b08
--- /dev/null
+++ b/drivers/cpufreq/riscv-rpmi-cpufreq.c
@@ -0,0 +1,976 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V MPXY Based CPUFreq Driver
+ *
+ * Copyright (C) 2026 Shanghai StarFive Technology Co., Ltd.
+ */
+
+#define pr_fmt(fmt) "riscv-rpmi-performance: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/bsearch.h>
+#include <linux/cpufreq.h>
+#include <linux/io.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/platform_device.h>
+
+#define RPMI_PERF_DOMAIN_NAME_LEN		16
+
+struct rpmi_perf_opp {
+	u32 index;
+	u32 clock_freq;
+	u32 power_cost;
+	u32 trans_latency_us;
+};
+
+struct rpmi_fc_db_info {
+	int width;
+	u64 set;
+	void __iomem *addr;
+};
+
+struct rpmi_fc_info {
+	void __iomem *set_addr;
+	void __iomem *get_addr;
+	struct rpmi_fc_db_info *set_db;
+};
+
+struct rpmi_ctx {
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	u32 max_msg_size;
+};
+
+struct rpmi_fast_channel {
+	u64 addr;
+	u64 size;
+};
+
+struct rpmi_perf_domain {
+	u32 id;
+	bool set_limit;
+	bool set_level;
+	bool has_fastchannels;
+	u32 opp_count;
+	u32 rate_limit_us;
+	char name[RPMI_PERF_DOMAIN_NAME_LEN];
+	struct rpmi_perf_opp *opp;
+	struct rpmi_fc_info *fc_info;
+	struct rpmi_ctx *mpxy_ctx;
+	struct device *dev;
+	struct rpmi_perf *perf;
+};
+
+struct rpmi_perf {
+	u32 num_domains;
+	struct rpmi_fast_channel fast_channel;
+	struct device *dev;
+	struct rpmi_perf_domain *domain;
+};
+
+struct rpmi_perf_cpufreq_data {
+	int cpufreq_domain_id;
+	int nr_opp;
+	struct device *cpu_dev;
+	struct rpmi_perf *mpxy_perf;
+};
+
+enum {
+	RPMI_PERF_FC_LEVEL,
+	RPMI_PERF_FC_LIMIT,
+	RPMI_PERF_FC_MAX,
+};
+
+/* Service: ENABLE_NOTIFICATION */
+struct rpmi_perf_enable_notification_tx {
+	u32 event_id;
+};
+
+struct rpmi_perf_enable_notification_rx {
+	s32 status;
+};
+
+/* Service: GET_NUM_DOMAINS */
+struct rpmi_perf_get_num_domain_rx {
+	s32 status;
+	u32 num_domains;
+};
+
+/* Service: GET_ATTRS */
+struct rpmi_perf_get_attrs_tx {
+	u32 domain_id;
+};
+
+struct rpmi_perf_get_attrs_rx {
+	s32 status;
+	u32 flags;
+#define PERF_LIMIT_SETTING(f)		(FIELD_GET(BIT(2), (f)))
+#define PERF_LEVEL_SETTING(f)		(FIELD_GET(BIT(1), (f)))
+#define FAST_CHANNEL_SUPPORT(f)		(FIELD_GET(BIT(0), (f)))
+	u32 num_levels;
+	u32 trans_latency_us;
+	char name[RPMI_PERF_DOMAIN_NAME_LEN];
+};
+
+/* Service: GET_SUPPORTED_LEVELS */
+struct rpmi_perf_get_supported_level_tx {
+	u32 domain_id;
+	u32 level_index;
+};
+
+struct rpmi_perf_get_supported_level_rx {
+	s32 status;
+	u32 flags;
+	u32 remaining;
+	u32 returned;
+	struct rpmi_perf_opp opp[];
+};
+
+/* Service: GET_LEVELS */
+struct rpmi_perf_get_level_tx {
+	u32 domain_id;
+};
+
+struct rpmi_perf_get_level_rx {
+	s32 status;
+	u32 level_index;
+};
+
+/* Service: SET_LEVELS */
+struct rpmi_perf_set_level_tx {
+	u32 domain_id;
+	u32 level_index;
+};
+
+struct rpmi_perf_set_level_rx {
+	s32 status;
+};
+
+/* Service: GET_FAST_CHANNEL_REGION */
+struct rpmi_perf_get_fast_channel_region_rx {
+	s32 status;
+	u32 addr_low;
+	u32 addr_high;
+	u32 size_low;
+	u32 size_high;
+};
+
+/* Service: GET_FAST_CHANNEL_ATTRIBUTES */
+struct rpmi_perf_get_fast_channel_attributes_tx {
+	u32 domain_id;
+	u32 service_id;
+};
+
+struct rpmi_perf_get_fast_channel_attributes_rx {
+	s32 status;
+	u32 flags;
+#define DOORBELL_REG_WIDTH(f)	(FIELD_GET(GENMASK(2, 1), (f)))
+#define SUPPORTS_DOORBELL(f)	(FIELD_GET(BIT(0), (f)))
+	u32 offset_low;
+	u32 offset_high;
+	u32 size;
+	u32 db_addr_low;
+	u32 db_addr_high;
+	u32 db_id;
+};
+
+static void rpmi_perf_fastchannel_db_ring(struct rpmi_fc_db_info *db)
+{
+	if (!db || !db->addr)
+		return;
+
+	switch (db->width) {
+	case 8:
+		iowrite8((u8)db->set, db->addr);
+		break;
+	case 16:
+		iowrite16((u16)db->set, db->addr);
+		break;
+	case 32:
+		iowrite32((u32)db->set, db->addr);
+		break;
+	}
+}
+
+static int rpmi_perf_get_num_domains(struct rpmi_ctx *mpxy_ctx, u32 *domain)
+{
+	struct rpmi_perf_get_num_domain_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_NUM_DOMAINS,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	*domain = rx.num_domains;
+
+	return 0;
+}
+
+static int rpmi_perf_get_attrs(struct rpmi_perf *mpxy_perf, struct rpmi_perf_domain *perf_domain)
+{
+	struct rpmi_perf_get_attrs_tx tx;
+	struct rpmi_perf_get_attrs_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = perf_domain->id;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_ATTRIBUTES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(perf_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	perf_domain->set_limit = PERF_LIMIT_SETTING(rx.flags);
+	perf_domain->set_level = PERF_LEVEL_SETTING(rx.flags);
+	perf_domain->has_fastchannels = mpxy_perf->fast_channel.size &&
+					(perf_domain->set_limit || perf_domain->set_level) ?
+					FAST_CHANNEL_SUPPORT(rx.flags) : false;
+	perf_domain->opp_count = rx.num_levels;
+	perf_domain->rate_limit_us = rx.trans_latency_us;
+	strscpy(perf_domain->name, rx.name, RPMI_PERF_DOMAIN_NAME_LEN);
+
+	if (!perf_domain->opp_count)
+		return -EINVAL;
+
+	perf_domain->opp = devm_kcalloc(mpxy_perf->dev, perf_domain->opp_count,
+					sizeof(struct rpmi_perf_opp), GFP_KERNEL);
+	if (!perf_domain->opp)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int rpmi_perf_get_supported_levels(struct rpmi_perf_domain *perf_domain)
+{
+	struct rpmi_perf_get_supported_level_tx tx;
+	struct rpmi_perf_get_supported_level_rx *rx;
+	struct rpmi_mbox_message msg;
+	struct rpmi_perf_opp *opp;
+	u32 index = 0;
+	int ret = 0;
+
+	rx = devm_kcalloc(perf_domain->dev, perf_domain->mpxy_ctx->max_msg_size,
+			  sizeof(u32), GFP_KERNEL);
+	if (!rx)
+		return -ENOMEM;
+
+	do {
+		tx.domain_id = perf_domain->id;
+		tx.level_index = index;
+
+		rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_SUPPORTED_LEVELS,
+						  &tx, sizeof(tx), rx,
+						  perf_domain->mpxy_ctx->max_msg_size);
+		ret = rpmi_mbox_send_message(perf_domain->mpxy_ctx->chan, &msg);
+		if (ret)
+			goto exit;
+
+		if (rx->status) {
+			ret = rpmi_to_linux_error(rx->status);
+			goto exit;
+		}
+
+		if ((index + rx->returned + rx->remaining) != perf_domain->opp_count) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		for (int i = 0; i < rx->returned; i++) {
+			opp = &perf_domain->opp[index + i];
+			opp->index = rx->opp[i].index;
+			opp->clock_freq = rx->opp[i].clock_freq;
+			opp->power_cost = rx->opp[i].power_cost;
+			opp->trans_latency_us = rx->opp[i].trans_latency_us;
+		}
+
+		index += rx->returned;
+
+	} while (rx->remaining);
+
+exit:
+	devm_kfree(perf_domain->dev, rx);
+
+	return ret;
+}
+
+static int rpmi_perf_get_levels(struct rpmi_perf_domain *perf_domain, u32 *level_index)
+{
+	struct rpmi_perf_get_level_tx tx;
+	struct rpmi_perf_get_level_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret = 0;
+
+	tx.domain_id = perf_domain->id;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_LEVEL,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(perf_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	*level_index = rx.level_index;
+
+	return 0;
+}
+
+static int rpmi_perf_set_levels(struct rpmi_perf_domain *perf_domain, u32 level_index)
+{
+	struct rpmi_perf_set_level_tx tx;
+	struct rpmi_perf_set_level_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret = 0;
+
+	tx.domain_id = perf_domain->id;
+	tx.level_index = level_index;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_SET_LEVEL,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(perf_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return 0;
+}
+
+static int rpmi_perf_get_fast_channel_regions(struct rpmi_ctx *mpxy_ctx, struct rpmi_perf *perf)
+{
+	struct rpmi_perf_get_fast_channel_region_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_FAST_CHANNEL_REGION,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	perf->fast_channel.addr = rx.addr_low | (((u64)rx.addr_high) << 32);
+	perf->fast_channel.size = rx.size_low | (((u64)rx.size_high) << 32);
+
+	return 0;
+}
+
+static int rpmi_perf_extract_attributes(struct rpmi_perf_get_fast_channel_attributes_rx *rx,
+					struct rpmi_perf_domain *domain,
+					struct rpmi_fc_info *fc, u32 service_id)
+{
+	u64 phys_offset, phys_addr, db_phys_addr;
+	struct rpmi_fc_db_info *db = NULL;
+	void __iomem *addr, *db_addr;
+	u8 db_addr_width;
+	u32 flags;
+
+	flags = le32_to_cpu(rx->flags);
+	phys_offset = le32_to_cpu(rx->offset_low);
+	phys_offset |= (u64)le32_to_cpu(rx->offset_high) << 32;
+	phys_addr = domain->perf->fast_channel.addr + phys_offset;
+
+	addr = devm_ioremap(domain->dev, phys_addr, 8);
+	if (!addr) {
+		dev_err(domain->dev,
+			"failed to get fastchannel virtual addr in domain: %d\n",
+			domain->id);
+		return -EADDRNOTAVAIL;
+	}
+
+	switch (service_id) {
+	case RPMI_PERF_SRV_GET_LEVEL:
+	case RPMI_PERF_SRV_GET_LIMIT:
+		fc->get_addr = addr;
+		break;
+	case RPMI_PERF_SRV_SET_LEVEL:
+	case RPMI_PERF_SRV_SET_LIMIT:
+		if (SUPPORTS_DOORBELL(flags)) {
+			db = devm_kzalloc(domain->dev,
+					  sizeof(struct rpmi_fc_db_info),
+					  GFP_KERNEL);
+			if (!db)
+				break;
+
+			db_addr_width = 1 << (DOORBELL_REG_WIDTH(flags) + 3);
+			db_phys_addr = le32_to_cpu(rx->db_addr_low);
+			db_phys_addr |= (u64)le32_to_cpu(rx->db_addr_high) << 32;
+
+			db_addr = devm_ioremap(domain->dev, db_phys_addr, 8);
+			if (!db_addr)
+				break;
+
+			db->addr = db_addr;
+			db->width = db_addr_width;
+			db->set = le32_to_cpu(rx->db_id);
+			fc->set_db = db;
+		}
+		fc->set_addr = addr;
+
+		break;
+	}
+
+	return 0;
+}
+
+static int rpmi_perf_get_fast_channel_attributes(struct rpmi_perf_domain *perf_domain,
+						 struct rpmi_fc_info *fc,
+						 u32 service_id)
+{
+	struct rpmi_perf_get_fast_channel_attributes_tx tx;
+	struct rpmi_perf_get_fast_channel_attributes_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = perf_domain->id;
+	tx.service_id = service_id;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_FAST_CHANNEL_ATTRS,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(perf_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	ret = rpmi_perf_extract_attributes(&rx, perf_domain, fc, service_id);
+
+	return ret;
+}
+
+static int rpmi_perf_enumerate(struct rpmi_perf *mpxy_perf, struct rpmi_perf_domain *domain)
+{
+	struct rpmi_fc_info *fc;
+	int ret, id;
+
+	id = domain->id;
+
+	ret = rpmi_perf_get_attrs(mpxy_perf, domain);
+	if (ret) {
+		dev_err(domain->dev,
+			"Failed to get attributes of perf domain: #%u\n", id);
+		return ret;
+	}
+
+	ret = rpmi_perf_get_supported_levels(domain);
+	if (ret) {
+		dev_err(domain->dev,
+			"Failed to get supported level of perf domain: #%u\n", id);
+		return ret;
+	}
+
+	if (domain->has_fastchannels) {
+		fc = devm_kcalloc(domain->dev, RPMI_PERF_FC_MAX, sizeof(*fc), GFP_KERNEL);
+		if (!fc)
+			return -ENOMEM;
+
+		if (domain->set_level) {
+			rpmi_perf_get_fast_channel_attributes(domain,
+							      &fc[RPMI_PERF_FC_LEVEL],
+							      RPMI_PERF_SRV_SET_LEVEL);
+		}
+
+		rpmi_perf_get_fast_channel_attributes(domain,
+						      &fc[RPMI_PERF_FC_LEVEL],
+						      RPMI_PERF_SRV_GET_LEVEL);
+
+		if (domain->set_limit) {
+			rpmi_perf_get_fast_channel_attributes(domain,
+							      &fc[RPMI_PERF_FC_LIMIT],
+							      RPMI_PERF_SRV_SET_LIMIT);
+		}
+
+		rpmi_perf_get_fast_channel_attributes(domain,
+						      &fc[RPMI_PERF_FC_LIMIT],
+						      RPMI_PERF_SRV_GET_LIMIT);
+
+		domain->fc_info = fc;
+	}
+
+	return 0;
+}
+
+static int rpmi_perf_dvfs_device_opps_add(const struct rpmi_perf *mpxy_perf,
+					  struct device *dev, int domain)
+{
+	struct rpmi_perf_opp *opp;
+	struct rpmi_perf_domain *dom;
+	unsigned long freq;
+	int idx, ret;
+
+	if (domain < 0)
+		return domain;
+	else if (domain > mpxy_perf->num_domains)
+		return -EINVAL;
+
+	dom = mpxy_perf->domain + domain;
+
+	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
+		/* Frequency from RPMI is in kHz*/
+		freq = opp->clock_freq * 1000;
+
+		ret = dev_pm_opp_add(dev, freq, 0);
+		if (ret) {
+			dev_warn(dev, "failed to add opp %luHz\n", freq);
+
+			while (idx-- > 0) {
+				/* Frequency from RPMI is in kHz*/
+				freq = (--opp)->clock_freq * 1000;
+				dev_pm_opp_remove(dev, freq);
+			}
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int rpmi_perf_search_index(const void *id, const void *opp)
+{
+	return *((u32 *)id) - ((struct rpmi_perf_opp *)opp)->index;
+}
+
+static int rpmi_perf_search_freq(const void *id, const void *opp)
+{
+	return *((u32 *)id) - ((struct rpmi_perf_opp *)opp)->clock_freq;
+}
+
+static int rpmi_perf_level_to_frequency(struct rpmi_perf_domain *domain, u32 index, u32 *cpufreq)
+{
+	struct rpmi_perf_opp *found;
+
+	found = bsearch(&index, domain->opp, domain->opp_count,
+			sizeof(domain->opp[0]), rpmi_perf_search_index);
+	if (found) {
+		*cpufreq = found->clock_freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int rpmi_perf_frequency_to_level(struct rpmi_perf_domain *domain, u32 clock_freq, u32 *index)
+{
+	struct rpmi_perf_opp *found;
+
+	found = bsearch(&clock_freq, domain->opp, domain->opp_count,
+			sizeof(domain->opp[0]), rpmi_perf_search_freq);
+	if (found) {
+		*index = found->index;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int rpmi_perf_set_target_index(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+	struct rpmi_perf_domain *domain;
+	int ret;
+
+	domain = &data->mpxy_perf->domain[data->cpufreq_domain_id];
+
+	if (!domain->set_level) {
+		dev_err(data->mpxy_perf->dev,
+			"perf domain #%u - set perf level is not supported\n",
+			data->cpufreq_domain_id);
+		return -EOPNOTSUPP;
+	}
+
+	if (!domain->fc_info || !domain->fc_info[RPMI_PERF_FC_LEVEL].set_addr) {
+		ret = rpmi_perf_set_levels(domain, index);
+	} else {
+		iowrite32(index, domain->fc_info[RPMI_PERF_FC_LEVEL].set_addr);
+		rpmi_perf_fastchannel_db_ring(domain->fc_info[RPMI_PERF_FC_LEVEL].set_db);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static unsigned int rpmi_perf_fast_switch(struct cpufreq_policy *policy,
+					  unsigned int target_freq)
+{
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+	struct rpmi_perf_domain *domain = &data->mpxy_perf->domain[data->cpufreq_domain_id];
+	u32 level_index = 0;
+
+	if (!rpmi_perf_frequency_to_level(domain, target_freq, &level_index))
+		return 0;
+
+	if (!rpmi_perf_set_target_index(policy, level_index))
+		return target_freq;
+
+	return 0;
+}
+
+static unsigned int rpmi_perf_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+	struct rpmi_perf_domain *domain;
+	u32 cpufreq, level_index;
+	unsigned long rate;
+	int ret;
+
+	domain = &data->mpxy_perf->domain[data->cpufreq_domain_id];
+
+	if (!domain->fc_info || !domain->fc_info[RPMI_PERF_FC_LEVEL].get_addr) {
+		ret = rpmi_perf_get_levels(&data->mpxy_perf->domain[data->cpufreq_domain_id],
+					   &level_index);
+		if (ret)
+			return 0;
+	} else {
+		level_index = ioread32(domain->fc_info[RPMI_PERF_FC_LEVEL].get_addr);
+	}
+
+	ret = rpmi_perf_level_to_frequency(domain, level_index, &cpufreq);
+	if (ret)
+		return 0;
+
+	rate = (unsigned long)cpufreq;
+
+	return rate;
+}
+
+static int rpmi_perf_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_table;
+	struct rpmi_perf_cpufreq_data *data;
+	struct rpmi_perf_domain *domain;
+	struct of_phandle_args args;
+	struct rpmi_perf *mpxy_perf;
+	int ret, nr_opp, domain_id;
+	struct device *cpu_dev;
+
+	mpxy_perf = cpufreq_get_driver_data();
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_perf_domain_get_sharing_cpumask(policy->cpu,
+						 "performance-domains",
+						 "#performance-domain-cells",
+						 policy->cpus, &args);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to performance domain info: %d\n",
+			__func__, ret);
+		goto out_free_priv;
+	}
+
+	domain_id = args.args[0];
+	of_node_put(args.np);
+
+	ret = rpmi_perf_dvfs_device_opps_add(mpxy_perf, cpu_dev, domain_id);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to add opps to the device\n");
+		goto out_free_priv;
+	}
+
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		goto out_free_priv;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_opp;
+	}
+
+	data->cpu_dev = cpu_dev;
+	data->nr_opp = nr_opp;
+	data->cpufreq_domain_id = domain_id;
+	data->mpxy_perf = mpxy_perf;
+
+	/* Allow DVFS request for any domain from any CPU */
+	policy->dvfs_possible_from_any_cpu = true;
+	policy->driver_data = data;
+	policy->freq_table = freq_table;
+
+	domain = &mpxy_perf->domain[domain_id];
+	policy->cpuinfo.transition_latency = domain->rate_limit_us * 1000;
+	policy->fast_switch_possible = true;
+
+	return 0;
+
+out_free_opp:
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+
+out_free_priv:
+	kfree(data);
+
+	return ret;
+}
+
+static void rpmi_perf_exit(struct cpufreq_policy *policy)
+{
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+
+	dev_pm_opp_free_cpufreq_table(data->cpu_dev, &policy->freq_table);
+	dev_pm_opp_remove_all_dynamic(data->cpu_dev);
+	kfree(data);
+}
+
+static int __maybe_unused
+rpmi_perf_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
+			unsigned long *kHz)
+{
+	struct rpmi_perf_cpufreq_data *data;
+	struct rpmi_perf_domain *domain;
+	struct cpufreq_policy *policy;
+	struct rpmi_perf_opp *opp;
+	unsigned long Hz;
+	int idx;
+
+	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	if (!policy)
+		return 0;
+
+	data = policy->driver_data;
+	domain = &data->mpxy_perf->domain[data->cpufreq_domain_id];
+	Hz = *kHz * 1000;
+
+	for (opp = domain->opp, idx = 0; idx < domain->opp_count; idx++, opp++) {
+		if (opp->clock_freq < *kHz)
+			continue;
+
+		*uW = opp->power_cost;
+		*kHz = opp->clock_freq;
+		break;
+	}
+
+	return 0;
+}
+
+static void rpmi_perf_register_em(struct cpufreq_policy *policy)
+{
+	struct em_data_callback em_cb = EM_DATA_CB(rpmi_perf_get_cpu_power);
+	struct rpmi_perf_cpufreq_data *data = policy->driver_data;
+
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu), data->nr_opp,
+				    &em_cb, policy->cpus, true);
+}
+
+static struct cpufreq_driver  rpmi_perf_cpufreq_driver = {
+	.name = "sbi-mpxy-cpufreq",
+	.flags = CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = rpmi_perf_set_target_index,
+	.fast_switch = rpmi_perf_fast_switch,
+	.get = rpmi_perf_get_rate,
+	.init = rpmi_perf_init,
+	.exit = rpmi_perf_exit,
+	.register_em = rpmi_perf_register_em,
+};
+
+static int rpmi_cpufreq_attr_setup(struct device *dev, struct rpmi_ctx *mpxy_ctx)
+{
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	/* Validate RPMI specification version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SPEC_VERSION);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get spec version\n");
+		return ret;
+	}
+
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		dev_dbg(dev,
+			"msg protocol version mismatch, expected 0x%x, found 0x%x\n",
+			RPMI_MKVER(1, 0), msg.attr.value);
+		return -EINVAL;
+	}
+
+	/* Validate performance service group ID */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get service group ID\n");
+		return ret;
+	}
+
+	if (msg.attr.value != RPMI_SRVGRP_PERFORMANCE) {
+		dev_dbg(dev,
+			"service group match failed, expected 0x%x, found 0x%x\n",
+			RPMI_SRVGRP_PERFORMANCE, msg.attr.value);
+		return -EINVAL;
+	}
+
+	/* Validate performance service group version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get service group version\n");
+		return ret;
+	}
+
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		dev_dbg(dev,
+			"service group version failed, expected 0x%x, found 0x%x\n",
+			RPMI_MKVER(1, 0), msg.attr.value);
+		return -EINVAL;
+	}
+
+	/* Get max message size */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get max message data size\n");
+		return ret;
+	}
+
+	mpxy_ctx->max_msg_size = msg.attr.value;
+
+	return 0;
+}
+
+static int rpmi_cpufreq_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rpmi_perf *mpxy_perf;
+	struct rpmi_ctx *mpxy_ctx;
+	int num_domains = 0;
+	int ret, i;
+
+	mpxy_ctx = devm_kzalloc(&pdev->dev, sizeof(*mpxy_ctx), GFP_KERNEL);
+	if (!mpxy_ctx)
+		return -ENOMEM;
+
+	/* Setup mailbox client */
+	mpxy_ctx->client.dev		= dev;
+	mpxy_ctx->client.rx_callback	= NULL;
+	mpxy_ctx->client.tx_block	= false;
+	mpxy_ctx->client.knows_txdone	= true;
+	mpxy_ctx->client.tx_tout	= 0;
+
+	/* Request mailbox channel */
+	mpxy_ctx->chan = mbox_request_channel(&mpxy_ctx->client, 0);
+	if (IS_ERR(mpxy_ctx->chan))
+		return PTR_ERR(mpxy_ctx->chan);
+
+	ret = rpmi_cpufreq_attr_setup(dev, mpxy_ctx);
+	if (ret) {
+		dev_err(dev, "failed to verify RPMI attribute - err:%d\n", ret);
+		goto fail_free_channel;
+	}
+
+	/* Get number of performance domain */
+	ret = rpmi_perf_get_num_domains(mpxy_ctx, &num_domains);
+	if (ret) {
+		dev_err(dev, "invalid number of perf domains - err:%d\n", ret);
+		goto fail_free_channel;
+	}
+
+	if (!num_domains) {
+		dev_err(dev, "No PM domains found!\n");
+		ret = -EINVAL;
+		goto fail_free_channel;
+	}
+
+	mpxy_perf = devm_kzalloc(dev, sizeof(*mpxy_perf), GFP_KERNEL);
+	if (!mpxy_perf) {
+		ret = -ENOMEM;
+		goto fail_free_channel;
+	}
+
+	mpxy_perf->domain = devm_kcalloc(dev, num_domains,
+					 sizeof(struct rpmi_perf_domain),
+					 GFP_KERNEL);
+	if (!mpxy_perf->domain) {
+		ret = -ENOMEM;
+		goto fail_free_channel;
+	}
+
+	mpxy_perf->num_domains = num_domains;
+	mpxy_perf->dev = dev;
+
+	/* Get fast channel region for performance domain */
+	ret = rpmi_perf_get_fast_channel_regions(mpxy_ctx, mpxy_perf);
+	if (ret)
+		dev_err(dev, "invalid fast channel region\n");
+
+	for (i = 0; i < num_domains; i++) {
+		struct rpmi_perf_domain *domain = &mpxy_perf->domain[i];
+
+		domain->id = i;
+		domain->mpxy_ctx = mpxy_ctx;
+		domain->dev = dev;
+		domain->perf = mpxy_perf;
+
+		rpmi_perf_enumerate(mpxy_perf, domain);
+	}
+
+	rpmi_perf_cpufreq_driver.driver_data = mpxy_perf;
+
+	ret = cpufreq_register_driver(&rpmi_perf_cpufreq_driver);
+	if (ret) {
+		dev_err(dev, "registering cpufreq failed, err: %d\n", ret);
+		goto fail_free_channel;
+	}
+
+	dev_info(dev, "%d MPXY cpufreq domains registered\n", num_domains);
+	dev_set_drvdata(dev, mpxy_perf);
+
+	return 0;
+
+fail_free_channel:
+	mbox_free_channel(mpxy_ctx->chan);
+
+	return ret;
+}
+
+static void rpmi_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&rpmi_perf_cpufreq_driver);
+}
+
+static const struct of_device_id rpmi_cpufreq_of_match[] = {
+	{ .compatible = "riscv,rpmi-performance" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rpmi_cpufreq_of_match);
+
+static struct platform_driver rpmi_cpufreq_platdrv = {
+	.driver = {
+		.name = "riscv-rpmi-performance",
+		.of_match_table = rpmi_cpufreq_of_match,
+	},
+	.probe = rpmi_cpufreq_probe,
+	.remove = rpmi_cpufreq_remove,
+};
+
+module_platform_driver(rpmi_cpufreq_platdrv);
+
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_DESCRIPTION("CPUFreq Driver based on SBI MPXY extension");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index e135c6564d0c..a32210db48ed 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -93,6 +93,7 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 /* RPMI service group IDs */
 #define RPMI_SRVGRP_SYSTEM_MSI		0x00002
 #define RPMI_SRVGRP_CLOCK		0x00008
+#define RPMI_SRVGRP_PERFORMANCE		0x0000A
 
 /* RPMI clock service IDs */
 enum rpmi_clock_service_id {
@@ -119,6 +120,21 @@ enum rpmi_sysmsi_service_id {
 	RPMI_SYSMSI_SRV_ID_MAX_COUNT
 };
 
+/* RPMI performances service IDs */
+enum rpmi_perf_service_id {
+	RPMI_PERF_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_PERF_SRV_GET_NUM_DOMAINS = 0x02,
+	RPMI_PERF_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_PERF_SRV_GET_SUPPORTED_LEVELS = 0x04,
+	RPMI_PERF_SRV_GET_LEVEL = 0x05,
+	RPMI_PERF_SRV_SET_LEVEL = 0x06,
+	RPMI_PERF_SRV_GET_LIMIT = 0x07,
+	RPMI_PERF_SRV_SET_LIMIT = 0x08,
+	RPMI_PERF_SRV_GET_FAST_CHANNEL_REGION = 0x09,
+	RPMI_PERF_SRV_GET_FAST_CHANNEL_ATTRS = 0x0a,
+	RPMI_PERF_SRV_ID_MAX_COUNT,
+};
+
 /* RPMI Linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION,
-- 
2.43.0


