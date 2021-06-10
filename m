Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68443A23E7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFJFZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:25:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11511 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFJFZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302598; x=1654838598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nzy9pCl8zwYLJGc+tqg047HMq9wQYVcYuA1f89D7X7Y=;
  b=CwSRhD/FvEiDaQwGXtjmTlakxYtW3zwzt1Wonop7uHNRBrVQTQ50Ey8/
   Bu+Z7WulT/WfHd8vm22VfOYW0zhjditzePnaJGAGwPMAQPKMvrLXqgYHV
   kDPi67fDJk1/41huGITBlUcVDQ8ONaUnYMXOG8kFXKkxG2c5W30IzyZx8
   X8jA3IBRPnYDhDoo6u+7F1AT7MbOKRZRp7ef3962TFe4XdOAkiJZho3YK
   tPlAXLPrBAoft/9XKZdzta+deyKS6CMP3Pq0oTBlTwtNdCO8JBbyjdU6h
   MOrI3cC5K65QXR+ooz/33CW2+qptboaimr3qOLe8CWt82z5ZuL/As49mg
   w==;
IronPort-SDR: Etm4rhUoG4y/SoyUmBgezK5YD8LXFa1Z8F6tkVts3nom0bdHHhLPSPp72mAHeKG7REz7aUcQHx
 yVCwS7uOMpMBYDzKhjTnmxmgBZ6BHon80X1cCBXNOZ3LQp5iYymz7SzcBEbwARUaOBB+eEfVWp
 sjj+QBgSmpJxZ+snWjnJSLV1oK3urWdfshU6QXanlefFbQo09illjE8/Jxhyqb1oruoon6e4lK
 FzT65/8Y1Z06BeZ6C1zbpC4737JX//wIhZLj8502CZTEk3AYmNOE+LBgTuacnmGwlfsiTrvtAW
 qEE=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211808"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:23:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB1kQNFBoCJg68JSPoRAhQG7ZOqYDVlIQy8qYn/zLPYNbmJaY2r233RYPQnQZONFqcW6Fx63Xg2r4mVZ45l1ZhRLcqBe09l1Cmrx+2BJF/I3bD7pMZyuBxO15KJ8OiV6CEJ48j/iEY7nPptsFVs4ZbIx3Y7b8l1uYgO1scAFiBHP5DDV0qiG5aBxnmrjO/bqg23g4waM6d8Ddng+h4udmn7KkGY97oonf9Nb4ou1MGITxy75EmT8zou2KeHnsa31ANiAp0MCTZ+r2UUWkMq55AJ2PZIHqurK/EVvXzp09/fRp3u5mHexvJeoaLNOhCCOtCwPglj7bKZvKXdmgzonxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/jB78KPasPpB+gWqSbtnjXrkCttN6l+ligdt5QCVT0=;
 b=FOTHk1GAJe/Hjb6QCEUmMNxJccRfsi08Au8bEznpYeFsLIbu1CmyN1Red/YZiZjVfphU3x+GGxYHv13SpsjzvuWjmwu9xjOUM1rexyPGUfo4bTkxJxM8fkdPRVUSORHuecNTFpd6SXDACz0m6kmNCCDtQaY0hqcBlBKz+09BvLIneqACbyiqAtr4Uc8fCXn3W/hJ53SIVoy/OfxLVU7F8JNkffxq0rGvcsUaudvllQJCx474DORH/L98V9LyL3+oq7DL/al9YubyIqQ7pD+c6J4yrrp6J+7kuee/G5IJrCRH4ftjyXXYQIHrxDW8+4MSYUhKQDnZM31g787bLcQPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/jB78KPasPpB+gWqSbtnjXrkCttN6l+ligdt5QCVT0=;
 b=O81nb+Pr7HPmNH1VqNCX+Ly6GVCEjcVnx/WbNIuJ7hESKBklmNuTfLbO2TajGWujJ/MXot1BcvUu6jLY96ZOlT+/GUJhDD9sMMlp38w0dr68I9ezyg/DVWWLuMwoBb46SeFfT5v326GVCYO34nmuYXRViBIOQItV5GCg28EjT3s=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:23:11 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:23:11 +0000
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
Subject: [PATCH v7 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Thu, 10 Jun 2021 10:52:18 +0530
Message-Id: <20210610052221.39958-6-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:23:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cb738dc-de20-47e9-bad7-08d92bcfd6d9
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778B2ED1E064774500BAED28D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhTg8DLvomm4tWdtrQ173uzFGHFn8bSYqCWThWm3M0qJA4l3KbSOJ5uGxJPrD4Xo3zLL7c0SHuvEbyQbEAF83Xih1lO4AA2jhqP9o4+3JRBE0emUbhm3putUy7+Xf95LOf00Hg4sg73DB7TnWhMl8RLjetTVtlwU/vNLOZdAAX9ZZgGUfp3NJ598T2toYLfaZKpdFBxe+Xcit/PD41AhOCQXASg299SR3HwPAKE72+Y+uz1craIPyb/dP9J2i7yKG2OQtug9UR+L7HsUzCtBZgFUOGy42mbTABTmAtHAizLbaoMAR7In689RrKYeiSPCWEAdcVucryGkVx9Uam8wX/8GDf9c086yHuZp1+IvOaA/krspXcIc5VTkLh/pwBOJya9hI52YKpKf6YawUiDhvfWrJZfrmFbDqlYpx3WqFbkBuqb49Gl2hi+4p7MZs2eSObX6dl0nErGfjHLz5Reb7rJxBaW8VbDux/75MxLu9Qs8IMDWRV02GbpT5HWQeSlyDkVkIGqIRg5dFGFc220FoxuIJ+u1HzmCwDug5E4IvFCOBRigHZVZy6nmpuhpJSdTb9d5XIbUgwTfwJ2glYU/vJLWHuYluqysjlBwuqEHD76f2ltuN9i7nfezv87wxEy9k5txf9vaoeJ6jmdgdW39XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(30864003)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htucyUT7Ksu2avULFP/n/TV7opC5+l1ewFOcu+JJj6uAuBjQajyOzr1mACZ2?=
 =?us-ascii?Q?MbgFGRXU4rDIbsKJU8W4n8C3svAojUf0MFps4s1tI0FLUGazkbl+GRKrEUnH?=
 =?us-ascii?Q?Ner2TKO++2BO3iZbTTgJ9+OMkqKweAly7XboUtw5r+fzInhTNH2koZM/lbo4?=
 =?us-ascii?Q?12rDjpU6UoDBzth+9GZXFBTArTI3UB6dFiXWekej5SXgOe5jory5uqf0yJYz?=
 =?us-ascii?Q?h0Ih7lRBl5T2vv9YWI0NyNsdcEYe/cm800Kck1qdHbEydir1uypux1xP15pt?=
 =?us-ascii?Q?zG+rWCr1xZIygkvrOtlkVEae3OVPqWPtA/lFKSlAjy5WfPdVIYWPTc6j0xUI?=
 =?us-ascii?Q?HFfY0oc2lgUkDLhy/lxFr5UPdUappAqeiBMbshJilf7EcG7Cg0JY2lARAEaw?=
 =?us-ascii?Q?HV5rjUkbat2cS8/Onx3Ud/hpkNmp6lGevEvVDUL5aVeDKAZr+YUwGrPTRMbw?=
 =?us-ascii?Q?oM8UzZ7xBBSaZDu5at7iHprETFp0xBpugf65vfv1Gdi7BjLkDonBBYpjMuZr?=
 =?us-ascii?Q?1i3rAIWkiT7g6jA3u+Ff2+90444H9raGVAZs3srogt8rus8L4ooDLF2/gwR3?=
 =?us-ascii?Q?tqaZK8YI8PDITKd8uAzk3Uqque4YdaznAsFTpw16lmBZ2iT9fXGyBV+OxxJx?=
 =?us-ascii?Q?w/7pDdNA2NlcFOjFhXIQPK09F1O7ooEqvx8myu+SorAAwFcVbo9ztHuLpejh?=
 =?us-ascii?Q?X1GFlHuNSNx/9e4KwIAhOuMoEGFlR4JcOxu+AF7vKtQKY3hg080Zl+n75QEJ?=
 =?us-ascii?Q?0UclZF3gXXmFsemQs+wtPSqNTsZ60NkIWz4IrgXWLeb7G1r9iM2EJgA2KPoY?=
 =?us-ascii?Q?SJU+/vgShRMiS54vJII3px098jebhqdNdfZsD2VfSwqPoDIjYHLjmp+NdhIP?=
 =?us-ascii?Q?IDuDoMjUBTlCirT8zxmmrN1kM55BRf6UlAWxq/FKe7K0jKgAbQaUaLajVJyq?=
 =?us-ascii?Q?u2NUCbS0II7O3awbqbNgAf1m5FRwovbMLndXRP788LfJM7BdPPcOWViI4XLC?=
 =?us-ascii?Q?alMxfCU7QJtwtp58kQ8+Ni0iAimfVYowDHHwECX6ZAYdCcLirGoUs2vYT/TK?=
 =?us-ascii?Q?DMG00gtElLdOBX7uFWO2ASdRqkq+6v/i8VAG2+xyXImI7y3Gr9X7eeyCjok1?=
 =?us-ascii?Q?psRgmcRFe7ZyaJovJOnM7HpeX1ty5o+SVMEOQY6NrgnYHRDsKBlrlD3zfaK0?=
 =?us-ascii?Q?LRoA3p4LOZl1hj5KQX3tiEIlV++s/Z1eblTRjqZ2+MUGMo9QpCAtdfWRApDo?=
 =?us-ascii?Q?LwmmhUg/Mjzfe90IqcQA0klHEMsZAUjJmcpdseCtQIeXEWuTRTw1TOeqS7Xo?=
 =?us-ascii?Q?MhIHrJryB57vWQpGA3icK3Ep?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb738dc-de20-47e9-bad7-08d92bcfd6d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:23:11.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTtb+5sFWIlxIwf+xp4UFdmHXZjaXCuvsix76QeXnfVoOU/ffyGdQbyAVyyZnO3yJHpwkqNW7m1qTFDfHhK5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic power domain related code in PSCI domain driver is largely
independent of PSCI and can be shared with RISC-V SBI domain driver
hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                           |   7 +
 drivers/cpuidle/Kconfig               |   4 +
 drivers/cpuidle/Kconfig.arm           |   1 +
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c | 138 +-------------------
 drivers/cpuidle/cpuidle-psci.h        |  15 ++-
 drivers/cpuidle/dt_idle_genpd.c       | 177 ++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.h       |  50 ++++++++
 8 files changed, 258 insertions(+), 135 deletions(-)
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20ff2b..5108b5058502 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4789,6 +4789,13 @@ S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.h
 F:	drivers/cpuidle/cpuidle-psci-domain.c
 
+CPUIDLE DRIVER - DT IDLE PM DOMAIN
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/cpuidle/dt_idle_genpd.c
+F:	drivers/cpuidle/dt_idle_genpd.h
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd66f02..f1afe7ab6b54 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -47,6 +47,10 @@ config CPU_IDLE_GOV_HALTPOLL
 config DT_IDLE_STATES
 	bool
 
+config DT_IDLE_GENPD
+	depends on PM_GENERIC_DOMAINS_OF
+	bool
+
 menu "ARM CPU Idle Drivers"
 depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e56120..be12a9ca78f0 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -27,6 +27,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
 	bool "PSCI CPU idle Domain"
 	depends on ARM_PSCI_CPUIDLE
 	depends on PM_GENERIC_DOMAINS_OF
+	select DT_IDLE_GENPD
 	default y
 	help
 	  Select this to enable the PSCI based CPUidle driver to use PM domains,
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e74123..11a26cef279f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -6,6 +6,7 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
+obj-$(CONFIG_DT_IDLE_GENPD)		  += dt_idle_genpd.o
 obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
 obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
 
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index ff2c3f8e4668..755bbdfc5b82 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -47,73 +47,14 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 	return 0;
 }
 
-static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
-				     int state_count)
-{
-	int i, ret;
-	u32 psci_state, *psci_state_buf;
-
-	for (i = 0; i < state_count; i++) {
-		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
-					&psci_state);
-		if (ret)
-			goto free_state;
-
-		psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
-		if (!psci_state_buf) {
-			ret = -ENOMEM;
-			goto free_state;
-		}
-		*psci_state_buf = psci_state;
-		states[i].data = psci_state_buf;
-	}
-
-	return 0;
-
-free_state:
-	i--;
-	for (; i >= 0; i--)
-		kfree(states[i].data);
-	return ret;
-}
-
-static int psci_pd_parse_states(struct device_node *np,
-			struct genpd_power_state **states, int *state_count)
-{
-	int ret;
-
-	/* Parse the domain idle states. */
-	ret = of_genpd_parse_idle_states(np, states, state_count);
-	if (ret)
-		return ret;
-
-	/* Fill out the PSCI specifics for each found state. */
-	ret = psci_pd_parse_state_nodes(*states, *state_count);
-	if (ret)
-		kfree(*states);
-
-	return ret;
-}
-
-static void psci_pd_free_states(struct genpd_power_state *states,
-				unsigned int state_count)
-{
-	int i;
-
-	for (i = 0; i < state_count; i++)
-		kfree(states[i].data);
-	kfree(states);
-}
-
 static int psci_pd_init(struct device_node *np, bool use_osi)
 {
 	struct generic_pm_domain *pd;
 	struct psci_pd_provider *pd_provider;
 	struct dev_power_governor *pd_gov;
-	struct genpd_power_state *states = NULL;
 	int ret = -ENOMEM, state_count = 0;
 
-	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	pd = dt_idle_pd_alloc(np, psci_dt_parse_state_node);
 	if (!pd)
 		goto out;
 
@@ -121,22 +62,6 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
-	if (!pd->name)
-		goto free_pd_prov;
-
-	/*
-	 * Parse the domain idle states and let genpd manage the state selection
-	 * for those being compatible with "domain-idle-state".
-	 */
-	ret = psci_pd_parse_states(np, &states, &state_count);
-	if (ret)
-		goto free_name;
-
-	pd->free_states = psci_pd_free_states;
-	pd->name = kbasename(pd->name);
-	pd->states = states;
-	pd->state_count = state_count;
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
 	/* Allow power off when OSI has been successfully enabled. */
@@ -149,10 +74,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
 
 	ret = pm_genpd_init(pd, pd_gov, false);
-	if (ret) {
-		psci_pd_free_states(states, state_count);
-		goto free_name;
-	}
+	if (ret)
+		goto free_pd_prov;
 
 	ret = of_genpd_add_provider_simple(np, pd);
 	if (ret)
@@ -166,12 +89,10 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 
 remove_pd:
 	pm_genpd_remove(pd);
-free_name:
-	kfree(pd->name);
 free_pd_prov:
 	kfree(pd_provider);
 free_pd:
-	kfree(pd);
+	dt_idle_pd_free(pd);
 out:
 	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
 	return ret;
@@ -195,30 +116,6 @@ static void psci_pd_remove(void)
 	}
 }
 
-static int psci_pd_init_topology(struct device_node *np)
-{
-	struct device_node *node;
-	struct of_phandle_args child, parent;
-	int ret;
-
-	for_each_child_of_node(np, node) {
-		if (of_parse_phandle_with_args(node, "power-domains",
-					"#power-domain-cells", 0, &parent))
-			continue;
-
-		child.np = node;
-		child.args_count = 0;
-		ret = of_genpd_add_subdomain(&parent, &child);
-		of_node_put(parent.np);
-		if (ret) {
-			of_node_put(node);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static bool psci_pd_try_set_osi_mode(void)
 {
 	int ret;
@@ -282,7 +179,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		goto no_pd;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
-	ret = psci_pd_init_topology(np);
+	ret = dt_idle_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
@@ -314,28 +211,3 @@ static int __init psci_idle_init_domains(void)
 	return platform_driver_register(&psci_cpuidle_domain_driver);
 }
 subsys_initcall(psci_idle_init_domains);
-
-struct device *psci_dt_attach_cpu(int cpu)
-{
-	struct device *dev;
-
-	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
-	if (IS_ERR_OR_NULL(dev))
-		return dev;
-
-	pm_runtime_irq_safe(dev);
-	if (cpu_online(cpu))
-		pm_runtime_get_sync(dev);
-
-	dev_pm_syscore_device(dev, true);
-
-	return dev;
-}
-
-void psci_dt_detach_cpu(struct device *dev)
-{
-	if (IS_ERR_OR_NULL(dev))
-		return;
-
-	dev_pm_domain_detach(dev, false);
-}
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
index d8e925e84c27..4e132640ed64 100644
--- a/drivers/cpuidle/cpuidle-psci.h
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -10,8 +10,19 @@ void psci_set_domain_state(u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
 #ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
-struct device *psci_dt_attach_cpu(int cpu);
-void psci_dt_detach_cpu(struct device *dev);
+
+#include "dt_idle_genpd.h"
+
+static inline struct device *psci_dt_attach_cpu(int cpu)
+{
+	return dt_idle_attach_cpu(cpu, "psci");
+}
+
+static inline void psci_dt_detach_cpu(struct device *dev)
+{
+	dt_idle_detach_cpu(dev);
+}
+
 #else
 static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
 static inline void psci_dt_detach_cpu(struct device *dev) { }
diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
new file mode 100644
index 000000000000..db385fd2507e
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PM domains for CPUs via genpd.
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#define pr_fmt(fmt) "dt-idle-genpd: " fmt
+
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "dt_idle_genpd.h"
+
+static int pd_parse_state_nodes(
+			int (*parse_state)(struct device_node *, u32 *),
+			struct genpd_power_state *states, int state_count)
+{
+	int i, ret;
+	u32 state, *state_buf;
+
+	for (i = 0; i < state_count; i++) {
+		ret = parse_state(to_of_node(states[i].fwnode), &state);
+		if (ret)
+			goto free_state;
+
+		state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
+		if (!state_buf) {
+			ret = -ENOMEM;
+			goto free_state;
+		}
+		*state_buf = state;
+		states[i].data = state_buf;
+	}
+
+	return 0;
+
+free_state:
+	i--;
+	for (; i >= 0; i--)
+		kfree(states[i].data);
+	return ret;
+}
+
+static int pd_parse_states(struct device_node *np,
+			   int (*parse_state)(struct device_node *, u32 *),
+			   struct genpd_power_state **states,
+			   int *state_count)
+{
+	int ret;
+
+	/* Parse the domain idle states. */
+	ret = of_genpd_parse_idle_states(np, states, state_count);
+	if (ret)
+		return ret;
+
+	/* Fill out the dt specifics for each found state. */
+	ret = pd_parse_state_nodes(parse_state, *states, *state_count);
+	if (ret)
+		kfree(*states);
+
+	return ret;
+}
+
+static void pd_free_states(struct genpd_power_state *states,
+			    unsigned int state_count)
+{
+	int i;
+
+	for (i = 0; i < state_count; i++)
+		kfree(states[i].data);
+	kfree(states);
+}
+
+void dt_idle_pd_free(struct generic_pm_domain *pd)
+{
+	pd_free_states(pd->states, pd->state_count);
+	kfree(pd->name);
+	kfree(pd);
+}
+
+struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *))
+{
+	struct generic_pm_domain *pd;
+	struct genpd_power_state *states = NULL;
+	int ret, state_count = 0;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		goto out;
+
+	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!pd->name)
+		goto free_pd;
+
+	/*
+	 * Parse the domain idle states and let genpd manage the state selection
+	 * for those being compatible with "domain-idle-state".
+	 */
+	ret = pd_parse_states(np, parse_state, &states, &state_count);
+	if (ret)
+		goto free_name;
+
+	pd->free_states = pd_free_states;
+	pd->name = kbasename(pd->name);
+	pd->states = states;
+	pd->state_count = state_count;
+
+	pr_debug("alloc PM domain %s\n", pd->name);
+	return pd;
+
+free_name:
+	kfree(pd->name);
+free_pd:
+	kfree(pd);
+out:
+	pr_err("failed to alloc PM domain %pOF\n", np);
+	return NULL;
+}
+
+int dt_idle_pd_init_topology(struct device_node *np)
+{
+	struct device_node *node;
+	struct of_phandle_args child, parent;
+	int ret;
+
+	for_each_child_of_node(np, node) {
+		if (of_parse_phandle_with_args(node, "power-domains",
+					"#power-domain-cells", 0, &parent))
+			continue;
+
+		child.np = node;
+		child.args_count = 0;
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+struct device *dt_idle_attach_cpu(int cpu, const char *name)
+{
+	struct device *dev;
+
+	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), name);
+	if (IS_ERR_OR_NULL(dev))
+		return dev;
+
+	pm_runtime_irq_safe(dev);
+	if (cpu_online(cpu))
+		pm_runtime_get_sync(dev);
+
+	dev_pm_syscore_device(dev, true);
+
+	return dev;
+}
+
+void dt_idle_detach_cpu(struct device *dev)
+{
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
+	dev_pm_domain_detach(dev, false);
+}
diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
new file mode 100644
index 000000000000..a95483d08a02
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_genpd.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_IDLE_GENPD
+#define __DT_IDLE_GENPD
+
+struct device_node;
+struct generic_pm_domain;
+
+#ifdef CONFIG_DT_IDLE_GENPD
+
+void dt_idle_pd_free(struct generic_pm_domain *pd);
+
+struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *));
+
+int dt_idle_pd_init_topology(struct device_node *np);
+
+struct device *dt_idle_attach_cpu(int cpu, const char *name);
+
+void dt_idle_detach_cpu(struct device *dev);
+
+#else
+
+static inline void dt_idle_pd_free(struct generic_pm_domain *pd)
+{
+}
+
+static inline struct generic_pm_domain *dt_idle_pd_alloc(
+			struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *))
+{
+	return NULL;
+}
+
+static inline int dt_idle_pd_init_topology(struct device_node *np)
+{
+	return 0;
+}
+
+static inline struct device *dt_idle_attach_cpu(int cpu, const char *name)
+{
+	return NULL;
+}
+
+static inline void dt_idle_detach_cpu(struct device *dev)
+{
+}
+
+#endif
+
+#endif
-- 
2.25.1

