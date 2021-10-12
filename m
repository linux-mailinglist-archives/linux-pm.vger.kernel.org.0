Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3C42A183
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhJLKBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 06:01:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28641 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhJLKBu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 06:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634032789; x=1665568789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UeD+FgLO9aIjFzdKrHDcrkqDgbjr4ljOtP7t6+n6Irg=;
  b=FuEcxMrF3gaA/TCgmljGQ7h4EBos84Y5hNAtsOXH7CLb6/xGReb3iBcs
   MknL1QrMs/QVWL3TyujoBAL16VwWvJ4x6Ca0camOJe/gg2glXBX4oz3pb
   7H3lJAdWzaOPIirfu5EYuNiGzVa3RpkfHpiGseASX+yNmZOPZZu+5WUvp
   4gocTCGcr2dxrYYoStb5XGdLo6CNufBoQHoIwXtDdetKKKLgFLqCoWX16
   l/zIZKMWBUZf5YC/BhE2SB9sK5QU/5E1gHVa9JDWAgw1mGN5pR5JeVSvP
   ILy01TVz4oKngncw4lWcZwnD4unpXDifNenj+9QIvdVe6vIG9QglFuQzi
   A==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624291200"; 
   d="scan'208";a="181612328"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 17:59:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkUX7hyLXdjMn+AHgD3M70Iquvyredsf3Hhv/kpUwt4Mnrt3TsCR4xvFYm+pSJGvtSHUIUWw98LwzvkoTHB1n6WQcOoSXZbnssTwzQ2p+wSKy4VozTIgzTjZr+Vhkjv7nED8cXVmP0XWDoFI2EI4VjeMCmDkufzJDPIilIBqVNDn+nUcLOK4edRwW4I4fL3D9HL/S64nZtitMYVYTQHXGkix25pztUshi2uQlUXTQ5tuRQ/363N8IyNRiV+tMIv+HnLYXm+JmR/z0WUmfqS/kwSXcqkLFbpG/lV9OhRofv/bzQe3CzlyUC4kGl2l55lgCwpEAJcZpB9tGvDfwHfV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=SrdrGgHHgs5EvUIi19rlQ9xZXL5Q/EeMmT7BtkaDMy2OMzZY+id6o+S6MBaLwyVF3bpZhSHZPFpx8APiOnX+eIso86w1GUk5PVGHpV/qRA6X1u8cFaWStzJuXKxFBHrnA6P90u/PSP97NaRNCsq80XRIZbanPlDoGBIG5Tcx75wP7a/co/WIJ0DwT5UBWREcUUuiANz0xHRh7wpLlI84j1UWgs7arGw+KjZu4SjFjWIqy0R9Q4dP/DeoxnKMqJk3pH2GznG0F9R0b+TXm6yPe9DV0vIFZAHba6d/cjPSuxTsDUVj6PBqeF+2A+iIGnFqCrJ0wA+OPE3WKo4pJJQKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QXaNsRGTyDgz2Sn7I2zPdXMtXIGlsEhVecpbL/TqiQ=;
 b=G70XHiCOnzbDwhf2UUqkTcCOROlDfUzuqgQ58nnfL2RB3DvXdYqPRbnRwkeKaD1mZ+UOqlwY3I15wmihTI7RMZCRhtnKBXMK2sM64NvIlq1WFgww2v9p9nBcjJEHVZx36F+uk5EybdT1fBXxlJV156NpGfv/ylbycABqAuD7gW4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8348.namprd04.prod.outlook.com (2603:10b6:303:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 09:59:47 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:59:47 +0000
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
Subject: [PATCH v9 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Tue, 12 Oct 2021 15:28:53 +0530
Message-Id: <20211012095857.1314214-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012095857.1314214-1-anup.patel@wdc.com>
References: <20211012095857.1314214-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.114.63) by MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Tue, 12 Oct 2021 09:59:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f893829-c263-4573-72de-08d98d6705d3
X-MS-TrafficTypeDiagnostic: CO6PR04MB8348:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB83485D4B676B985A0FB575A38DB69@CO6PR04MB8348.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQ1f04OA+Q6bmL3PPdwfvPZlvOv4oAoI7xO+HPksNdBTwJinG9UolV2bYdldg4TxALwGB34za4Nj0SlPtDCoDkaylF/l6cYRyqruxCQULzZ3FHO//rxRzymIGVYuTYCM5/XsgFXcqlvo8GXkOGcUNB7dW+8+3fA2fAgCCEHAj9kl3jY9U1xN/I6P0a5JI6uF30Gpy+6xj3frhf1r2bxEqRXgNIn73GEGfrqxGz9CQbJWpIjqK/rRwnctFltFcO9fk3WkhLeWEhAgeItZvRKJPhvqtaIVdm+R2ARd+RFVT9C9lbP+DYW5afXVfxhTIAXTWonyVM6tzPhGZVaRn92y3HBxgggwyH5PipmT0EAnKTyHPPqCENjkWOFrh08EfSnSqcKdIiQbVpfxW6l2RivI+KqFAfr2d2qPk3YTwtwxI/u3/Gqvdj4qe2AHypGjz5//5daq9uBLRmVeACJ66NRBseLexpkbFaA9il2Z87gSt9U7B5phM7WYXhhqz6bFaGi1cGx7Q0Tn0CKdmQsDhaXUmVGl5hH6C0ojTpETUy22iVQG7pq6Xkfqj8ELhcmx8gJhaZUfRiVnwa29bbTEh/coHi6OUPzf7aCiHTkDlq7s16e1sIixEug3/CmRHLRO7642Lv2BfwRf5yj/NQ3inWtUIaG3IzWfq3i/Jt/6ICZcJddu3If/82kHOPAgc3bmxnj16ZUNs17BKBhPaR5AlXH4OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6666004)(1076003)(8676002)(316002)(110136005)(44832011)(7416002)(508600001)(8886007)(54906003)(4326008)(2906002)(956004)(2616005)(38100700002)(55016002)(26005)(7696005)(83380400001)(36756003)(52116002)(186003)(38350700002)(66946007)(86362001)(66556008)(66476007)(15650500001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AanbN/TOTcAjn5JnAoAGLMlVzJbi08QMUVRD+MQj7rGaH81QNncbcqfsmfAE?=
 =?us-ascii?Q?rueOHiJYoyv0ESv4TNHI8FbgQV5K67iSkEX0fuZ7MEvVRqoGKD1v2x9b2R3h?=
 =?us-ascii?Q?fXm/ckrbW/PWDZKg06ktW+YwUJRc9TidLgXSeSN0kQ1ADGMrzkSsDXIA4gML?=
 =?us-ascii?Q?31wx3gA3gMFvALfkis9ZchOLP6hnz9Mkh+PM+1ZIK1Ia0jSUnA5uhG5q29D6?=
 =?us-ascii?Q?Ti7cdNpnLRIwEBqlSydTj5YhI3xcbn18QekdU2jrMlBz+8rmyG8PBNxu0iQP?=
 =?us-ascii?Q?3vipBBO9xKfV5yZgAmbm2kjoEdq82Uk9s9niZLtqGwBBsCaIADLdA3c3pi7O?=
 =?us-ascii?Q?cYo2JGHC8s2XRO+YUyFoKXeZmOtc9KBJdvx/Ge4XiO37BvGwDVsrDE1BgMft?=
 =?us-ascii?Q?rOilD5YEFEdw6m0hbN26E30u2hc26mQgvhlFcGM1RcwvkLuCZMYMwLA5/jeW?=
 =?us-ascii?Q?w6hAYrNGA37VnbuCedMHlG1YXq2zNE9JqB0s4Esx95LF2rmOXc5YIqI4fCqS?=
 =?us-ascii?Q?Hnjeqjnyb4xLwyaRbtQEIu0neRjoc/RxRfy8Q4ZbJGSxjnoiSRnF49jNIBmo?=
 =?us-ascii?Q?3W/aIBhSVjTq8OksHfvJOCgEwcCx4tWBLgVACwIFHFKsVokl1AcbO1GvlDI/?=
 =?us-ascii?Q?OIByorykCpBhi/qfrV0KcTG/ZN2/Xpf+phrJzBO/cGykCziKXni68ShgCWam?=
 =?us-ascii?Q?bPKl40/JmSwxPehmjees61YkUM53Yz9QA/e3Kyp/e2bHO9VH7Uv5SEMRBq09?=
 =?us-ascii?Q?zDVQP7kx8O9c1qhAne7h30/0Zh8zF/QJX6MqgozGsUDYPzMWNdlHZHBg1xOu?=
 =?us-ascii?Q?fKu2AamX3uDN38keR5VIavU5mLEaeWmFTE0IEIusPbTF1bktdreApJnExkYY?=
 =?us-ascii?Q?v55EGD2NX93M5Ltzib7BizNPByJvYjFNHgUrYNSoQaSRyiE6zmvgh3n5n0gd?=
 =?us-ascii?Q?osN0WC4/nHofGOABIcAUXAZ6u8pM5XIl12aVmMTabxYsUHl/BV4pUQh+FJD5?=
 =?us-ascii?Q?WHVZ6fRUo7+ZECjDEbADrybkM6X6lwzDPXZZSakVOCvyT3yIzUNn2pq7i5rq?=
 =?us-ascii?Q?J+F36Cvia7qG6772J5DCgI3OH56veVInB62LK7ktifBByeJBDF6EyN4n51bc?=
 =?us-ascii?Q?8db4qNktv6d7YCaMUZG2hik4+spP36d75keeLQfcEkWqcQNqagrLanrjHAm0?=
 =?us-ascii?Q?LuhLo5UAN3m5Eu1vhSWz45RklqA8Xv9QKTbZ4tmPG3VuYDTLdMB+Ad+IXcfL?=
 =?us-ascii?Q?wBsqkD068mw9bTLbbLtjeKcjge8s0YNqOCoCGWIjOIzyz9xEuf0jblxn+tQx?=
 =?us-ascii?Q?NHHpP5ic/g96cR2XZt06e4mx?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f893829-c263-4573-72de-08d98d6705d3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:59:46.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDtEJFhnlu1Al7/Vtl63Pq9UygQddmcg9LLcqY5R+F86N9XU1agOTImHK/zYFqh1uctSfFrGCMIN+plUB1IjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8348
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

