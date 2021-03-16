Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597F33D200
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhCPKmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:42:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13505 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbhCPKmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615891357; x=1647427357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y4YFFMKVmlQM+NHGrCbRGUcVF0miD9tt6EelOHDf/Ls=;
  b=K794TNTR6S07tCX8wljzqec+f0Z0ehzDnWHj9xujPGgoG51BUQf56fuc
   C/QRuIkZLh0S9YINiJeFgmN56gKcwhsEMkKtK2rIcC8V4/GphdN77QKN2
   CJp9JRnV8FO3qOJjvMaDsxa6YfPAlEybLt2+Eq2+GVZnvzsjjRbJY547O
   AyXoMDrYsG1ujmlBcW6yUEdsD5EY2htWY1LWXP+4Nqx+ryQz0Pb64vBQI
   xnCy72NYJ+c+4ulOW7wkaRL8JonIwg16e+MeJRSfNWBmBEUGSJssTGj5c
   jzCwlOHJiBhiAMfGkkqS3sJbCRhnq+it5C7tufVGMGsahupIRcPdegHMQ
   w==;
IronPort-SDR: 0Ez/hWlxb7khH+kuCEeJYbN8U/UQ2fs5L2MAL4Pt4vQ/0e6Log0GfPeD7X/mK5ok5jLefElqTO
 dvMOk3TiLHZBOWGCzcvL7YZimnKaSeFY7dODydqc02/O5ZVVnDYRogr23gblamF27CSH5Q6Z5u
 LwXY/+rhF+B26+9TBTSx5JJW5yVbR3JenaBPPK8EYBpIEop07xQyXRYoEd/MiyX9U7LHn3sxIS
 KHE6qvExTuWcVcREdZ083Zqog8EFa61BLOkd8vfi8+NP9JYcgNc5mlyiXCDdTZ7Sv8+cysu7v2
 gUY=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272971764"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX8ir18r76dtuW8o1IiCd7Oe+KyARN0komICrXuqQDHoSUpvob8caTkVmttdkmoQVD2y5FRGfSw6ztEVY/fRLR1H4reGHwEr38A/h7qv6A+vkgb3rH2dml5GjrP0lBNRnMOadAANmNkRlnQFRHqJd2o271nOThUiamlRUtqGbLiqEZe0IlGqlfh+DxMafETQclDNwpbsTSCZ2bMqhdWfezPe4yTBDvKkurzL/ovfX1snwCiT+SMnzO6gAZZ4FaEMOyX6oXrEfnYgtnXu0WnVCalmtLFpT/2TkrYtmqxhvIC4k5OPD7zLjz8la2eI8cfx9ETdWM3TQZCJh+TWlOYffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRnYrrQBMmPOciDojSI7+oGNW+nIEqIdYgzr++abP9s=;
 b=SeHjYNfuolnKradBTYzJkdxRHAsvopSf9cFyKUcIhL22byebqKmd7Ha+pAQAQXcCCzdxjJ97YpURHdQes4Lytp1Uw8lEsHwSgI150DaQJXtJtxm6gEMP0HAUrNDxIQ5Gt38EDcOY3XSV+lRlpBRfSR81cIAjZD/fZEuazR0w5qpteYigmRXK2jzz3ATR5KPMb/nZT4ovOo6/NPpkTo4AmCroD1yv+C5QINoLfPEJgBo7R07EdrbHWlrBidEWJ7MF36+1gW8YVUT7R4TkOjHEjZ3Yj5tgjpovDevRqysAEyBeOvuMzUjC+pqDOZV2JXlkxCVBc1Hbhwn6gNU7MqZNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRnYrrQBMmPOciDojSI7+oGNW+nIEqIdYgzr++abP9s=;
 b=H3AhJYekW9zZU1KcGKkI+5+sDseJMb/zxZkHxCjbsU884sO7HVstOqAQli6EauyGnlKj5VQuPeggAmOUzqG8Cet9WG3ovo1HJOxitiViYqmWhmLJ9N7B+w6tIIDJhTYE4dMmKpx2X2Ob1XTopD+E7nOHoXlZIeeYKyVNHBtqNx8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6377.namprd04.prod.outlook.com (2603:10b6:5:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:34 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:34 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH v2 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Tue, 16 Mar 2021 16:11:36 +0530
Message-Id: <20210316104140.878019-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316104140.878019-1-anup.patel@wdc.com>
References: <20210316104140.878019-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.218.45]
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.218.45) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 10:42:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56425630-a99b-4b16-a69a-08d8e8683532
X-MS-TrafficTypeDiagnostic: DM6PR04MB6377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6377CBD0F525CBF2B4680D2A8D6B9@DM6PR04MB6377.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocVnnHsW8PchrNUl1IrrXrV3NBNhP9fESmMJt/8t6fDaP6/uwBzjM8z6bXjDwmcj1y04K2F1R8nRvfFyKosF0IR2lRsvMOW0EdwM5HU1tEkWc3s0sRmBB0M2LVjxsTExR5GloLb1e3zcou7/YyWtBGkadfqdgotcA0ZOs8DvVAuyhsldAgxaz6Gw0yJ5y4ZLgc54SGNv1HSSmjKIwwtSa3jdjoDj1RHkpxZn5qxQzvBA8JFcU+W9Y93rByzBw6TFxfFvc1cI0oejDYGRIBXlWbDaT4OKBczAE8DfxvyGYvi6FmLgGSsVHJIggZEXttKw38RgYR9hrVXqQaJlChBRJysG355kr7WkED9OtvrGIU/MYxO2lwBMvvnf+bjbqk/hgDGTJlv9Red0MGJZJJMPtk/sAm70YMv73FlmV0t4Nx0JAu/RtCFyIvJDBuJkJXIFPQrStSN/LctS48HFRL1m5oShFO41gXe6PsUWQtSeON7gnebFD2wy7+tyFR7LpvXVWGSPOu/84BNLxHyIEVCsq3pZ3EsCWajF6AFyJQ2i/kQBpBRkVv2Aze3GCGTdajf+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(44832011)(52116002)(86362001)(83380400001)(110136005)(7696005)(8936002)(66946007)(8886007)(55016002)(7416002)(186003)(66556008)(16526019)(66476007)(26005)(956004)(15650500001)(2906002)(2616005)(4326008)(6666004)(5660300002)(498600001)(1076003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DF98/W7V8GqdiBbFnBqVTqHgEm5mR93YywFkweAJ/ralQV/1IGE5RuLNATJU?=
 =?us-ascii?Q?WQrM+oLinwcfP+IKaKJ/8WhP9SAYPB52tc2rqDIeQA3sxOEuq2+z7yE6+Yqa?=
 =?us-ascii?Q?jcvMNHqluXtLhH3JWgIBqiVsDGKNr8IpqCtiElXqYjG7JWkXdwMUWWS/RWw9?=
 =?us-ascii?Q?hhY1r6Nrk5svWl9cnE5vPurNDG8DhSdb5hkNqOZCytor6/jfywN7Ayo+O430?=
 =?us-ascii?Q?H0NQVF/DjrWpU5xUFkENm3T9rRFAzozYH2taeZtFxRxZwLIA9CUpEm5LT/Bt?=
 =?us-ascii?Q?CxOv14yxqiJZhHlnOUqPUzOUnErh+rMDQdlqoLhyNcoTmqWhv9C5ezNg0RRU?=
 =?us-ascii?Q?chobkNf+W3bWIvcz7pUfp7IU4hsCk3z401mAdNFYYH7KyLvlA9bSGKtskzDk?=
 =?us-ascii?Q?5V2YrdJ1y7UIreeIsdS1NFhw8Tyc0GebSWxTzLPsZYLo899bgQ3uGwTlr+1I?=
 =?us-ascii?Q?QQmnCFZHVEh+C8Vi5eZ8tV0nw5FFiE/ADIR5HmWMPxdf+8onsD13yKWdqi9H?=
 =?us-ascii?Q?3IhQFB0nqDQFCqrY2snamCBGN3BK5zpRD+fHU8lAsdrltVfRXiVxjFD5d+JT?=
 =?us-ascii?Q?/OuWL1OX1XjP9E6Ge/eGDUoCQIc69XtRTf1d0GypmnpqR5ZyKS3fUUH7kSGQ?=
 =?us-ascii?Q?gicr3+ElilmzYjrAHwUsv6JfEhqhPkFF7SoV+NMOpsndjBXxeJdjctoU55R3?=
 =?us-ascii?Q?03cC9bwKTJo40EX4K1d02ZzWT3HEo1FVG+he16eXTbHUNbsXwkQHBwvEpoBO?=
 =?us-ascii?Q?eyVDHu+Rl+UrZx9KjDhmYlrHHK+F1TyOcsQYlNUYSfj5TWmbHjNUGtavImDP?=
 =?us-ascii?Q?BiPyl3LqiVpg5BX+7hnTQzZeJ0a1zYR8rWtm2MR2HWkNzBx37XVduTkkxMXO?=
 =?us-ascii?Q?kt2AcRjpAOnqlynr+/W/L34rcvwMhJGroDNQqax8l0r6/jLEoOm/cqMh10qq?=
 =?us-ascii?Q?zSPt/y5UYtuOYV77jfV5beQSqnZbl6UFcBl7fy8qg7YGYIn6m/nlLscokIii?=
 =?us-ascii?Q?Gt1UnO1dIygYWqxf2RWJnMxGwpLeDYHB/4aJdYsH+UVB8c48h2vsDW7if0n4?=
 =?us-ascii?Q?+YtCFhlwUrJLqnslx635NJH5o3kWgt3R9UzlqRKWLzn0N563tT1URfdbJ8Fq?=
 =?us-ascii?Q?HpEa39MOfQZ50YUU1OmE1qwLNqhUQqdv/jN4104bXw6ZhwZSUB+O5y0ADzdX?=
 =?us-ascii?Q?a6pBoIkLfXnZN2Sba7LTc7eYDuOLrhGeLIVSbfI7QG9FetyMleOPvDOcej+K?=
 =?us-ascii?Q?mDsljDW1RK+AI0clZWsv4PMnA0DkRWeVfpphq3ZmtYMum5lMYB/02gD28wPJ?=
 =?us-ascii?Q?9sIz24ZY4nWRKSajeU11Rqrb?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56425630-a99b-4b16-a69a-08d8e8683532
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:34.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFcoccNPFQjb1YGHAQ4Mma3fjUh39CnvWAUtjrc4nXkkQhIpz6BRAJbp9Vo1MCFJIhsARRFOw5Mjs2dlBKmOog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6377
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We add defines related to SBI HSM suspend call and also
update HSM states naming as-per latest SBI specification.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
 arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 79fa9f28b786..4bdccec77a84 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -62,15 +62,32 @@ enum sbi_ext_hsm_fid {
 	SBI_EXT_HSM_HART_START = 0,
 	SBI_EXT_HSM_HART_STOP,
 	SBI_EXT_HSM_HART_STATUS,
+	SBI_EXT_HSM_HART_SUSPEND,
 };
 
-enum sbi_hsm_hart_status {
-	SBI_HSM_HART_STATUS_STARTED = 0,
-	SBI_HSM_HART_STATUS_STOPPED,
-	SBI_HSM_HART_STATUS_START_PENDING,
-	SBI_HSM_HART_STATUS_STOP_PENDING,
+enum sbi_hsm_hart_state {
+	SBI_HSM_STATE_STARTED = 0,
+	SBI_HSM_STATE_STOPPED,
+	SBI_HSM_STATE_START_PENDING,
+	SBI_HSM_STATE_STOP_PENDING,
+	SBI_HSM_STATE_SUSPENDED,
+	SBI_HSM_STATE_SUSPEND_PENDING,
+	SBI_HSM_STATE_RESUME_PENDING,
 };
 
+#define SBI_HSM_SUSP_BASE_MASK			0x7fffffff
+#define SBI_HSM_SUSP_NON_RET_BIT		0x80000000
+#define SBI_HSM_SUSP_PLAT_BASE			0x10000000
+
+#define SBI_HSM_SUSPEND_RET_DEFAULT		0x00000000
+#define SBI_HSM_SUSPEND_RET_PLATFORM		SBI_HSM_SUSP_PLAT_BASE
+#define SBI_HSM_SUSPEND_RET_LAST		SBI_HSM_SUSP_BASE_MASK
+#define SBI_HSM_SUSPEND_NON_RET_DEFAULT		SBI_HSM_SUSP_NON_RET_BIT
+#define SBI_HSM_SUSPEND_NON_RET_PLATFORM	(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_PLAT_BASE)
+#define SBI_HSM_SUSPEND_NON_RET_LAST		(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_BASE_MASK)
+
 enum sbi_ext_srst_fid {
 	SBI_EXT_SRST_RESET = 0,
 };
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 685fae72b7f5..5fd90f03a3e9 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -97,7 +97,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
 
 	rc = sbi_hsm_hart_get_status(hartid);
 
-	if (rc == SBI_HSM_HART_STATUS_STOPPED)
+	if (rc == SBI_HSM_STATE_STOPPED)
 		return 0;
 	return rc;
 }
-- 
2.25.1

