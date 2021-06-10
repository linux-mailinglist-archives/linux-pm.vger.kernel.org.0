Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D283A23E5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFJFZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:25:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11490 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFJFZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302590; x=1654838590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UeD+FgLO9aIjFzdKrHDcrkqDgbjr4ljOtP7t6+n6Irg=;
  b=OZYj5Uf2tsum9BlzZipE12WgIeWF4HF2q7xph2Z7f444Zt4ObGCb0auP
   HpGbDRd0F65BZcr5/QHZCu3iHmM6rzxaqVQ7d7uMFmbTNR/ojeQZi5Rei
   AjCI5rWBDpFuTRHVKnC+lsKe2RfGYwHaaFkZXvT+0m4yH5NBiWQatBH/I
   K5iDkzoGtnJM3q2PVOnbFj0ZXp+I2g8QAWyBWO7lKU3gMLH+qFWgnxt9t
   cGAD3kVQOW1oypvsGvvO6QuZnnbGeQUoptwsCXJDjRjzpZey/JNnHLooy
   nPYbAi1AK2SYr+pqjwuNY9kZyU45b8RFCyS2cCMdHuErjUTmdMVraMSqb
   A==;
IronPort-SDR: X2efCUNs9rpXmv4F5h3aBnhkuqxkpzHKSCn3H8RnSWzYl2yXYWN1/KiISZmQ+e4gcb8AytCKo2
 JCCuo/RvPGmSRcoKQrGWiRIzxPVCw+ogHbbkQe+khPa3QLziUxnN4nUIFR2DIOu+q578wuhB/g
 7E6XOmgFxEauRH8kKX2TYefxnERwzHYbKh3yv9mgISGylv4l/tlUNfajYfDvN++a4eQ1bNmgJH
 XsbrlmZD0JMGYz6yfHbQaWnE2mNL0JNgBwSBQGXNwLZnPSAE6ULS8qBbDQBrcs9eQAZPy89JnH
 8N0=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211803"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:23:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmVE5xFC4cttD2mGJMEf+ptv5ju+xGvrK+UZ4CmtakFYG84zKYvaLwCyxdWpLBsGnNyGPZ8nFyMxUagIL6B6nfcULjLISLlJG8npe2g9NIISgWjUTy7awbigKe3ecjcQjPhDqpmEpLBvlV/0lXms4TERsaw8hUdGVXSqko/3/wx77q2+GSfXq0mWgQVZG8s6joo0+pH+7RtyLBbcVZa6fMiV4YZ6yy93rXC1KNuX+xOogl9LQ3mhzy7T8cmZyZg9WgqDsX2FNNihI+xSPK8u1BLLgN2pJK+tANe63Eoi2PACyNioqqF/PG7ec+P/AepUzwEilzAWsH8ADMQDfCRhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=mP59kk1sJNmZbrUusFFDoCZGNBkTWkXTbXELL/Np3acMzeDrnM9chxNijrnTaIfwbq6t1xd1rf01cf5nxPc49c0DzyYhpgZziJlqWgPqIZmIEDgwXqPH3IarhmEeDpR1a6SqfuTp0OZ+sxwVs5ELSzLtm2jgi9Y+vc8ZXZj0ubNx9rgQrvWx/kE01Dj7sZTJ4q/Bc35DXoZHe1PTOgqbHmMo7wPrcpwRvcOuMwPiLcUjrmCLQiIh1GwbayC2SNvtgx6yDmgsY45HGa0RY4kpT74lBdxefrE6Tn5RyKYjQ1O6tw2UlViq1kApl7KIUjJtkn52+SqRQBBUnhuTauznLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=ScbhqNSZRfICQFC5bza20Z0rVZPy+82xLCgEDjL9b6rHO83Tjd3FsxFkuTw5PsyvzESeA+Ls+RAAt0B06yvIyz/zRG+jwUKnaRnt4KIGnQmT0kL8Yv/LYFxlHBJ8uGH7R1gxiS+yBSbR+1VGbtMEdpQrrlipLOhT0xAGSsCprMY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:23:06 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:23:06 +0000
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
Subject: [PATCH v7 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Thu, 10 Jun 2021 10:52:17 +0530
Message-Id: <20210610052221.39958-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610052221.39958-1-anup.patel@wdc.com>
References: <20210610052221.39958-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.172.180]
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:23:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d3ca70b-97e1-4624-ab28-08d92bcfd3c0
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB777844C434D92C02C088557D8D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCVkzW+WFIB+YOp8jLCBJTooMcceB1PPAQpcgX1MI11EgU3t/WrpBOI11aMuSQCvublrzdqhIyg+lk+oNrUoj0Bwj3/8A1K3NW7bGwUQ33aNd+6Q7HkHWdpzvpb7R4N2F5hfib6sJnzHTnu3nPiVh1wo6wgUfcm/fBfm9LHVG26SBv5RLftVAwnuTRR4MzPwW2pxzT3LX9XYx4E3C6PNaNl4t7LwGEuXLLnPZ+OroHR+MtxHUXJz5PPiLbZsnEfE1ZieV8QtGXLxBrf5GZsI6NFaVkHFG5paQCNV23ZVrqt3zX8xl0l4EVLyTg7mK4OA3WXNkOdKSmEiWSqLye+e3fwH2CAu4K01HZ4ziFVP7dK0Mm7BYblG3zAYBSKCDHxqGTMlReMfc+d493VnwukZXWAP2jdxzl/jzUNEGq8yXxGOP7UPQXcynA4vReXCgOGJDwwruDE7InOR1sV2yb1pPgOylTYNwa4nuDv7OeKz55BA31iMUjMfRmgANb7EbDfv0YOXn7hGxVy6YZInqujt3mDheND+gzjqYTKxJ9bycJosF03XN4g7sisjmQf+T2KO0UnlWPGENqprGWkMPp80R2setcdtA3CVselrOFhH8L7vZ5ponkjwLw30QId6U4Ovu2Egz1VBL9MdxEm0jw1dgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(4326008)(1076003)(478600001)(38350700002)(2616005)(15650500001)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7HN5H+N8GowDvNktpUSXf0An/9BC9Xs3AMtQ93AYeLH03UYvOiCMbSFk7Rm?=
 =?us-ascii?Q?Zhqzn7xjen1+on5WRYt/kh9m6B5MxU5K5pIG3LA2QFdFuaDqvVsgXW3fYlTD?=
 =?us-ascii?Q?0oL9twbQ373n5go5zHlN+eWiYk4XUP8B8KesE9ow5oDv9mfH+ad4qGo4fHjT?=
 =?us-ascii?Q?PZJLehI/ZmDIiLij3BaxsG3o/oCyC3+ev+Ca7g1kNHE1GvU5rbRP8HhPw8LZ?=
 =?us-ascii?Q?yz2Kd7JSsYlY1OU/VC1ezJ+wzU06AaKjZspOtWTwiYPrFyG2XeDtqo0ZJvT9?=
 =?us-ascii?Q?LIdcc9hw09GKJGZPL1g8cRBX1yxvdVEouPhbMW6yrOSjEEitGgAB6+gDRZOt?=
 =?us-ascii?Q?UB/xfEiyeWTpRXFnSvEhI27AoAJUT2FHjPmmHLxKZl5wKx6urp2PmmgbI3lx?=
 =?us-ascii?Q?VlZ/oRRWA8DscC92DYjWtjM3ylfubYsu5mCqU3tTYgJ6YMuPgBsxHziq6qhC?=
 =?us-ascii?Q?p+isQX//Br5k6SGp7zupi5mvJHku2ZHpBbXRjXPPcM2GSqN5afxCvbs/ZNf3?=
 =?us-ascii?Q?h4A+5Ck65hOuNdlwDJbRoJ6N7jFWe9vlbp3OBetqfExKWxm7h8f8MSghJNoO?=
 =?us-ascii?Q?xaE4ezx253c5v2+DBNSuJbwzezk48W2kOvls/35TB/opYcQb+FDYktRhtU7J?=
 =?us-ascii?Q?cCLy3I+qZpD6NO69R5H6eGAqUbJlgvsgqtuiwkKBLOypBbWMby+ffyTfMXLS?=
 =?us-ascii?Q?VWOj0UXrHAQjDFdiYKWrTCVmywz5ADojGAv5lgC2q/n17hgCCXBRW/eCTNyq?=
 =?us-ascii?Q?MYqCJVZdtEcxmCBP1zcz2SPzKHAYdv6dv1yvnia1kXa3rbiMt53vwreoQddf?=
 =?us-ascii?Q?bG5QDv1yzCV1Yx0L4dw9lFdu/2fATNR7h4P86WvMFmX/3fYHFNuPc1NxwNe7?=
 =?us-ascii?Q?W1jZIf5Zv2T+YEbZ9d05zSvDLU+yB9p95CsqeSEka5UIelU/Y7F9ExcRBoSX?=
 =?us-ascii?Q?MSvvKsuYeuDVMl0ZMb7rSJBpNbHj5O0UgxMkmldXL4XUd0qvC3B6JKX0Y2ac?=
 =?us-ascii?Q?TEYxSK4ScJw9smpjDmvBnqrHi1iIBI5IKbvM7LM8WtrwHb7iA/0HsNOVFuqK?=
 =?us-ascii?Q?jHL/ZhWP2Hdkv+AEne5lSFh2tKorOTAIabqTb/tbkT8Y7vZmv1t271KHiKJR?=
 =?us-ascii?Q?YaGq9RT2uvVafqFDknKTqXN+Y97jWErFJqVHvApcJGWswFoiNj8fa8G6EKpy?=
 =?us-ascii?Q?GdirHTI/F9Nq4Fp4Hyc+qpOb6ZrLqepAMCWnN9VzLHAKj2srhOnimGvlB4OZ?=
 =?us-ascii?Q?xPPGZlcQQIskoqjCnuDdZrkIGy9FxwU5sxLzsLxTCfv+0PIG54QyspXTmYw/?=
 =?us-ascii?Q?HziB7pKPrrY25LEBXqWS+MAm?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3ca70b-97e1-4624-ab28-08d92bcfd3c0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:23:06.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chqJOEhVI9fjCOBDPDbQ0k26vg6eQTvXZTc8RoqR7r9UopvNorUH3LO/nPYFFVrJiRx+eW/Xf7hf4lJOqsDT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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
index 289621da4a2a..ab9782f8da52 100644
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

