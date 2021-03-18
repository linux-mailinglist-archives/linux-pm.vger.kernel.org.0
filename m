Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29DA34065D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhCRNGk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21402 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhCRNGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072768; x=1647608768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y4YFFMKVmlQM+NHGrCbRGUcVF0miD9tt6EelOHDf/Ls=;
  b=IGM+4i6Tz5IS12Xmi3851oDkpPHfOlJ2hJxCuiZsD3wlhd4k3ppYx2E5
   iUQNxqruRTXG7OiKEmAAAMWzrtgSULetnk6UY6wDn2tug0EpTYNuFLh7L
   jvWeW1wy4FepN/Cko9ockOgFys9pMcL2sVyHj284nHJU8HDG3RdmZdlsa
   XAQWfBlfj6m3c3XI+Q5yx2YhDxkXiCPGybjYUM/dFTR0De+gBu7uWLRZU
   5m7o9EG7TRaRP2OuI7nSMyojMm5AJv0d1WayMSrIvL8lV2Bh2SbMapfBS
   5E6bDYvhsm4jtEW/pyyD6XoGacwsigiK1Esdx4kiOTfAa5QBrwZYb4qRd
   A==;
IronPort-SDR: 2i/4nboKWa9J0JJpvzYGZOxy51uE/LDRMyVD9BdD9jlgHC0qYXxu7xZ2eMjNfRok93jFKKBtXu
 NI6NAfOD7Uv8MTy6DDz3YGNvTFT1LrwD1j9mQicaDndRgjT8MEWqkgVUjcjYVrX1u9Q/X7/dQQ
 Slgf4jdYy6c23+NherKIXO7EECX5uGyTBarbzdmk3UqczabRa0WSe9l682zjA8DmYMXi0s2OOm
 IXgXQTmyELhctmodFK7NggNNU9VlN542zGk9vlbvXQ7Cvj2j4pj+DPqf7HogurdLp/9neMXAAS
 vDU=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="273192118"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHq/st1yBXh4W4yWAqMPs5QQXa1iCIcb9D7d+jW99kcwsFVFARhNkD4Is27HCEVRBCcmEfR/DZTLcxl91UadNRD4rhnk1PxfwtDKy1Ek/APSTkxz389jlqNtJMb1/IgSmkUH3XCcwzI9pHBtW7tLSvUrx17jNy0VFg+NIra+8YsEGAACzGsnuGZteoyEH4WBtCJRxFyZ3oisz9LMoH+ulaUhl0cT+NqblAW+69tFH33l9Dk/VTJkPjR2OKowfKviPkpwiH63uzwFj+aiRrZ5IqhPY0QcQTWSIGQqW++R8KbdlfyS5LIIuh8Z9PEqT8VwI6ySDT3dm2bchv/isZbWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRnYrrQBMmPOciDojSI7+oGNW+nIEqIdYgzr++abP9s=;
 b=ltAH3/WQo4dArJ4B2H0Tfl+X6SUsK0phH6MXOarXUwzJUxDO4XBkBsBmGGZAkunE59IHEq/SZgX60dZYam9B4TyvJ286qbbD9BswsBXXWpzWeRedHzU5G9JQ7sjMEMq/WfLP7uC3Eq89Xax6wXbGRNbTG2u8EDD3rw9UZQcFkxjku94vGpRMko0vGEtBgK06VIi76Vv+3Vw1/RNAkqjJr08f048EK56OuVdF0DHPHTYsUjP4yEaR0txIQOqqBmm+jNURwByWh4waLOZYTlPxWRPVWYWcYfpmj3tkPx3YeuELiv65s74PIfadsvoY7LcdfWnfGBChH8z/AAzppw32+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRnYrrQBMmPOciDojSI7+oGNW+nIEqIdYgzr++abP9s=;
 b=bz+vwUsuL/BZeG17lLTKiLCftcXyIrtSrk7NXyANzrmYgctgIoZIACUy1xvkWdcNCFbaS4y5x9RyagqDkCtivRD1pI8HbDflQHMclC9b3zbUnoalzegqJS1WqAFuMQHLds5+w/bT2pqycLOya0P8yTtNGwdExe+1j9PtavQi6jY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:06:06 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:06:06 +0000
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
Subject: [RFC PATCH v3 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Thu, 18 Mar 2021 18:35:08 +0530
Message-Id: <20210318130512.1025416-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318130512.1025416-1-anup.patel@wdc.com>
References: <20210318130512.1025416-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.155.94]
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:06:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0eb86908-9e85-4be1-a228-08d8ea0e96e9
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB08260F0447F637A6A30AEF4C8D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5SnMrKD/rlMYBE+8PaxIidfRJIHtmveScoIQyZWerx+8YwgMm/IP0ep/3kWQWN6AAzu2al3M7yjZrN7iYIoshkyP4ImMjxg7lse63RResDR57+oetmu3w48DndJQJjO68Faqnb/i8aM+FaufEdVTsz+vtmLstB0Rkq+6iXgAGypIlQy33W9PXq7uHckjPOTfy4K85w9aZP86f5BfxSBRp7kyl1px3v4C0d9uEOEu4Ke8bjC0I32Yb124yMI+fwTMTNm+PBTVmC37hIBhIpqqMw14emN3Ap5g8eQ01Ce1JVaGl36pzQWSKstfJbf0P1as9aDOLbKN05yYsu/0hL4gdSCdFHBPeKDoIv0DL4oQcjSsUXfDgfsx918H6UTqUZuwVRqMJMEmC16CzEzrxwse2kL59UVUHBZ0hPuElgDvwC6ZU265uZ08epmdSvcB7AmOy2PlxnA/9Tbk4QE3C3zB+W4cbUb34jIRKS2obtyOZAPNCsq7xdqyXsJZVyCPNoFzCeQIhG5k7XY/H8DTSfdn7idRh4UU7PGUwazzDjFK3Q769j61vVafrkgBHl+Sj3HWn3p9/iGzdbJ+ABEirs8hdne9E9DjVcSuD8VjPbt4iM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(15650500001)(86362001)(44832011)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(66476007)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Nn+zBHQek2GdmXrIp8pbiuKMv2kh/dexVk3dIvkUaboI3s7sz2DZdiBiRzkH?=
 =?us-ascii?Q?bhhdwRbPDMWT0HYVE66l1z/chkUhpzXD/XT0ijIuhLXkTlF/rgiF3U+lsstK?=
 =?us-ascii?Q?ZNlh/MkM9T1oihJxl9w4WCzKk/NEivJQhEzf8PQ0Zooem5un2YvV77XXZFsf?=
 =?us-ascii?Q?Nbi7VaT8QbwsV8KC+wBDDVlXF1bmZ6ERjxcv5fs+o5pyqRtaB7tPUw1QUp/f?=
 =?us-ascii?Q?SJjxv2c/DEajwja1zbyY4qDp+1N7i+I35KxD/GiPUoU1GfdT0Ou+ku7QBicF?=
 =?us-ascii?Q?HZ5NU9fF4iqyptxjNiAutSsfxtfe/uQjx8x7XDvi2gNvpWXolnMTKVW6F5Li?=
 =?us-ascii?Q?H94g47eJEOD0LPidZafSO5s1f5Eb9omsGbJSp/Ab79uBXUHR0NIyet+vTP2W?=
 =?us-ascii?Q?MifvkW8G2Mewla6SPFJMV/cmaf/p7IoE4HSpxtaiy/0rJ+w68KQFehjKy6y6?=
 =?us-ascii?Q?OHstiZlsR7wCxQrxiWFkyIktxWTMSW+oXicnBdGRmLL+68xhTumM075kDZru?=
 =?us-ascii?Q?INhcBT76yojuHD4YEPvfYZNqHfo/UezkQNcmow5ufdY0hRg904+Q7/SffbZV?=
 =?us-ascii?Q?olS3lEDlqQErgLRogSRTxPBwZU21utX0TbMy03ILQe+hQkt6Rr9/ae4oEonJ?=
 =?us-ascii?Q?gkw5qU42J3CleGiCk0G6yvGcFzwTu433RY/TFEzKuFCsyX/8PiY7Z9C99ztx?=
 =?us-ascii?Q?Tmkm2NCwfVJ8hNn1pzeTXfoSsW9t8O9GaLua231DvMJ0TqrBBlEyHvIT60KS?=
 =?us-ascii?Q?pu4W+oo+WOUemGCCbfOggR5fTMPx1BpQF3NsgxwpeXSTP6xBBgwIj5Hq3JAq?=
 =?us-ascii?Q?XXgWGCJUSBAEAwRlgt0jE0ytYnRs+7sr6OZ4Zus3Fr2dSCPiIa7dw8pnmiCd?=
 =?us-ascii?Q?DJ7b7z2cGmQudTbYpgpANENHCLsIRX0atXf3UeN8xJeVTxCP0N8kqybqTl8o?=
 =?us-ascii?Q?e5z1QU/YyHWLEuanZ6F5m1E9Uau9hN6/9mzhOC9cz88ABu4RvVtlliv/MDV6?=
 =?us-ascii?Q?a9j0cvSJh7gvyG5bsMagFP7k5Nb8zk3LVvHs5+4lH72C7W0WwDpaqWqfRWlZ?=
 =?us-ascii?Q?0mkzMJTnkGUb8y2Uq4nVH5Vh7Hu1SqwuwS0SMa8h/MjcmCctLJ5a/O8WJWZK?=
 =?us-ascii?Q?9IbK9xqguLnPccZTpHzN9/i2QFdCnHL642FyzOsRA2ZbfO6O7UOwSadF2qzV?=
 =?us-ascii?Q?TH+4FcAaNyBLXFGY8+SrYd908kq0160eH2FejoKKR3UuxlfvswKg3+1DEm0B?=
 =?us-ascii?Q?Rc4hBoUGJNMKyOlyfe8TVemNAowz4jDmHdP5g2e3gTliyfV+IXAh6H4eJwtv?=
 =?us-ascii?Q?icV+aFhuD7qgIt3gYxMWWcpx?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb86908-9e85-4be1-a228-08d8ea0e96e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:06:05.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSustxIbpvPQFHhC3fKY2pK9G7o0fGmfLgQS2FrmKgeXkwLbamzYY1Jv9NPCVepwi/X+v7wdphbdCHzQS7dmsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
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

