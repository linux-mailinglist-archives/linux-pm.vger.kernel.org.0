Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42285320977
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBUJka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:40:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6893 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBUJk1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900427; x=1645436427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=H+OYs+jFzlVdYQDLVcZVlvb7X4BJ0ta32547LsaYpEg=;
  b=bAquP8z0Dg3iLkJYPwAGnFGa7ATQffe8VldA7b0jxq++tJmFU4HmFAQI
   Tx2naJOyUKqfRb3996Besj+2vZMJPfqJtUS5qpY5BSMW5dJbkObf60jU3
   2T3nS+yOwLtI4N/wje9KjA8Le+E1WH7PQM4l3rs+aCcsOlZ0RCkTzH7NP
   jcfiSpKL0VFHDXo3h0q4ItjL0kA/0nDMejMjoDBdd2oErNDxKYlQmcnLg
   zm0uayMgplEoDu3z0kAvkSK9eyCys6b7mE3Gq+o2OkliAWlyFqVFcb6fH
   TbplE1yWfO32jzLC7iqtN64HYqMhjl6KET9X3CufL4hDdj7mGA1CQA22Q
   w==;
IronPort-SDR: 5lSA2FW1FaAoJBDB/UgjD6NE32in5/9XLISd2PQJdoKtroitENcsXWxybTRFZvYsQdM7eCVfu1
 dnSxqrLpbYX6MPHkpX9zYplRvV6L9TzA05c6Yp2eI1wH25EPT5015mM6UAVUYc99pl5r4Q4qAE
 rqqHexrhQ7kZYwxc4Tzj+x92FfCZelJe/AJZ620IOWSa7g19ustzFBVmS2VAEVxd26XDbsAxuY
 dz2xtCkW48IK6SJR4xF3fuBNtGu0gOTaaJ/lsNMBHhX8woVShon/5loWRuQYtda9GROLocd4yN
 nCM=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="161607390"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:38:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBFQF75pLXMhHEP16AfZVQXKF+SQ8ZyFh3WfyfuoaENpQFN54q8YwVJVJq+WXQiSQYh5YSUNrPjLPXI/Dde2q+AvPf6nj6+3PCBTR1B83kVOWJkzSYG2OB1SYaMwbuZCLG5eU++eHq1ARA+PXYZcX7kZPyuxKpq3JjKhBIpQVgekXyrTJ9Tx5ezugUF4gHr236nqw9A8DrC20zrA4UtZUXczCq/MB5ixqn1ozuCoVhuRf/V+/C4ZyogTBx56RH2w7cJ17GdmA7jmj/2/DblkzBdr7WGF1oexs4HiVa9Jq7SP6kBmur9+XOpzy1d0kibVFgwv9TatbL6NOoKfMujkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGHL1pRtkoeN3x22DBazGqgLk76XP5Cvh4LOVZGlaTw=;
 b=EJYmIryO+51npwoVh7CJbt2n/GBf8sAX4axfj7OAJVYsCRG/fUKjF69khplTKKpLe3clxeZdZnspU4quu993mAm8arjvJslfPf4lpIl8TpwjRUamGOmwpi8QmDDErKYKBn23ci6yIw4ReXZCEAyFC3dsMrgbzX5+qTWb58zQW4lMVkNBlVrSnAB8orMfO/KXCM6W4726YTyOFwbeTjwGGYzkwspxUFmnnL8SL8m5gr2aR5RBn0amw81ZYC6tWruqYqzhnLnNoVKMVS/Vwz+nm4qlf5bqnB7f4aajHnRV4lP4AmYGbnU0SkNUXx9doc1hKDnBmYkUmIiZM/Lbt/TllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGHL1pRtkoeN3x22DBazGqgLk76XP5Cvh4LOVZGlaTw=;
 b=cK4//dzohGvKIndejBVoXlnaenzx8lXLzW2RaUSNwfCppnlLwznpcOyF4ph0f0UIWSZvna6oqZvPXaWLm4EcqlJM26lzQIUyUnlsx4MNt2lFZqfpLeJwt1ec/3tRYsX+tNpTURsGxF0UTxlAhJIVIUvHMjEQRXXeD/h1NhukVPE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:38:54 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:38:54 +0000
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
Subject: [RFC PATCH 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Sun, 21 Feb 2021 15:07:54 +0530
Message-Id: <20210221093758.210981-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221093758.210981-1-anup.patel@wdc.com>
References: <20210221093758.210981-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.171.12]
X-ClientProxiedBy: MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:38:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23bdb66a-6942-4e15-4edb-08d8d64c80fa
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0459AD740F1755CA858EA6F08D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya02Q5WWaxKGWHPHYhHgK7uxrvg1veyA83zI63b9WtuU57wgdZjEjX3o781hhYGI4vdFoOpjb7H36FiiXg0vfOnHXTakLlQs0URehbAXx5/PMNSNoFkv9zN1eenKJUQK30kZsT4A+QkDv0Xw4PytiG3pg+6ReUdNRVhVzM6u/bpjKHSYq17wGRhiKu4ShjBhXMEKgque/pNObBbw+IbgtDyGWEq3j4uOof74p+L8NK2PtvKBTIolrCv2gNtir3eudHpsc/Hdw+Y5CCj6oMIxzmz/cF9OtNwxMUVwe61NoEEVQ8pxrZWXcSSLhzA1hIm0d7xj/pNiFRUmmDq39LUYPZF9NTmF+4ZTh37GjluvdTGhJuZ9dCPnhCL0abBfqmlVNj5qrRWEtNJnzDWqy6k9akge0xCUUIkpKdjFjEUD/jWvwnkZuudO+e01bGyO+7oXn39bfNtbtYYXeDTBbpnXG+iPy2c9SjLgb0qKyyuRq+MY4B7PEQ7LWX2riHfeS+hKWAMRQDadyIfg/AZkk5y3BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(15650500001)(5660300002)(54906003)(110136005)(4326008)(66476007)(36756003)(83380400001)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aUQKotkDUOfn5CS6abD7IJNmteaKGarrUA+5gJbtOX6fZatp0G3TC/vBP/+6?=
 =?us-ascii?Q?/4zBq3aOI2LqA+c5lHHv95NMUo8Jq8Ni1IhPTqW3Ht1ecxngeUtIZzao6E5c?=
 =?us-ascii?Q?0+C/k4Aae+IaGS4WEAU/g6blP61qpq7EEq1WOnMKdRiSUjmzd37MhG4eBbjY?=
 =?us-ascii?Q?W3zbZsd0l8m64ib9gZgKc+kFEjF84Fq1iWBlBI2in2j3ynCVRrpx5AuJhxop?=
 =?us-ascii?Q?x/s8zB46cE1hI7p302CP1wZk6W4ko/uM0H27ve98xSBBQ5AZKk849Nj9Ojjp?=
 =?us-ascii?Q?GKxt0ljcN501pBoJdtRs3Kx+E+lcH5dbu3NAIb0J5gaqtbMWE0RAcnIZBXSK?=
 =?us-ascii?Q?FtYf4+XlX9WXYqV6MwkIMdPEy9tYPeUaUD+PpdBevDfGAwTlL4GG9oQTE45E?=
 =?us-ascii?Q?MX2EAwKkVp7zeK7Mf5IOOkIf829S/znoWvJgKO8TdKmHaSz+93OW0Di/ukAu?=
 =?us-ascii?Q?Rj3rIuiBUVOEnKC3NGlQGgR+w6Wv7WgTquIhkBaOeUoCcEDm5oP6nsyOsC6h?=
 =?us-ascii?Q?gczQRdHI1488suK0dNFFCEBkhslCEr4wPOwJ8/g3tiRupwzlL948xax5ntBG?=
 =?us-ascii?Q?zADO+0nOSRGtd2I8OWar45zXHPNh0CJMAKjilRwzh7LUL5Vhx7rGyu8thih3?=
 =?us-ascii?Q?Xo30EJ/pn041fZClAnqexN3cHXq7WzN/n/Y5dqcB+BPJm7t1PaEcIi7d2xmS?=
 =?us-ascii?Q?PGSg8flhq3StZj2ycSFE2sax9pqanQqfB5YydZ5TCYSFAOCt5tJm43wL5JaW?=
 =?us-ascii?Q?DCrcW6BkzRmYrHHhBM2tpv3Pl/wj9kaVxxG8E35qRpj+9QxxdKlY/0rT29Cm?=
 =?us-ascii?Q?L3S0WLehqaaQ3Z/GyPxagugKKQQ3v0CoQBHghl+pkW1x3eXTHTC4qEi40Wr5?=
 =?us-ascii?Q?7SQ5w9fvAjLC0fzRdN0mEvGtrYQ9Yy1FVupgbmfp0Ml6lkmt9HD4qCj2ikU+?=
 =?us-ascii?Q?++L24423u6O/2bs6HjSY8KKmRSCuzSavpaQBzNni/U4s8Tfl3pJAhfQGEi68?=
 =?us-ascii?Q?8pwjteNC4CZ2pYLe9FKNpcCKNR2Yu6np4pJhSY3XyBMcZO3OpX0T7keV0Vrj?=
 =?us-ascii?Q?goeazZbJ38klzRD16eNLh4lP17mGFgBKrA5mebXp5+8zH1+Eccr2OVS5rLin?=
 =?us-ascii?Q?bzykRbaVJmDc45E08WwhOvOuH0PXPpP5rpH3+CDXozDDmzWoUX1l1OjTqhLE?=
 =?us-ascii?Q?fKslObBenR10fwtfXTi5Ci3gcHlg/kROYa/YOmVir66TIYCjCz+5A7oXXNNr?=
 =?us-ascii?Q?vVQR8wr9QWyuU6RPKBVTmmFXHCHBMnPV/uOt4x9APVqTx6Y7ii9fMonkp9Iq?=
 =?us-ascii?Q?Qp7mVUa8iskBXMoNF0sCQYRm?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bdb66a-6942-4e15-4edb-08d8d64c80fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:38:54.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuSowIbT1fZzc97VT1oi89g0QEMLDqvhc0nTxxzZV7uM1CYU+SjvXkhXoBLVjKiymE6rjYO7qiqbVtlN9DB2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
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
index 5b2d6d614c20..4f101f1aa4ea 100644
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

