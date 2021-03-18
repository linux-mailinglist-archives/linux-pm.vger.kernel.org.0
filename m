Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9615934065E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCRNGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55993 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhCRNGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072789; x=1647608789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h7XIRrb7qnCKO+6OJrZJvs+TZXOJkBQhu0RoEYGRKeM=;
  b=ZV8zvhamhkgmjDuzBsiwjivbuNTyFiMyp8l+5jMc9h2nTUv6ef41KhjH
   w45WvLzOTUqeifefVm42t9iLAQnvdwsr1fps4QmrzLBZYvEXcsO3vZfsa
   EKl9AR8ti+m41FKyhHOZ4r8aTJFM7MUvp50Vzl5lswBYtm5XPxk51qAi9
   rpYPzJpRbaZOtQh2ASTyxP0++vxwauf+zyNKq+x3Z1GCYZBPjnE5E7LAd
   8BNEuzw9EO2EHyF7Q+DGul3z6+kRBy8Qerhbr895upOepN2n+/eOgnZnr
   +YqKiMp2NLGAzg7/KUVnzvAytt9Madx0e6lbKQNnZfebNahsJOEKOzYM+
   Q==;
IronPort-SDR: VKHgDXuEWI3KmrzPR38IbHqfvcHVUd4N9vDLEEfzi4+4EH1Ti67+9et3JN/PIv7Dy+9wiSjvT9
 Aza/Hpiu19WlIwIXvKz6xCu+QUG09gCUR9iPmr7qPZveJCKu2TGSsPGXLXy9Jhq6sCHlZAs5l8
 1UJ9pB0+ldaaHhrDDnmMEP3LjdvK+i4pBAUp3xwREsWM2s7/Th3jiWDPymzCm97U1My4XC8KKn
 tNRHLhIKg29RZ9aNgAJfL9/EAE9D0hCogtahR2S3xTbNkyjLoJQx9+ij0eGgBYnWnee0jG+bPt
 YH8=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="266856979"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:06:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GweKxsDCOFqKpxsmZtKK7M/YTSTrLC1vHFOwr0yjY2JQqKoqoqWN09v2W3BckF7XQl6zEtyboUxwSS7LxWJ35SCAScDKR9agbAN4PULwOBQMZ+aMxPhtcyDkHH/WERSN7XELz9vTBmOA2gYQcKFFTNd+GwoDv6diAhRDj5nvhWeKxYa8jd2YDzfxpDjjEIygoEcisvPE7ApW4lf8AkbXmzMmJM2qfZarFXerxQUHvp3kwP3tP/ep0Jx/O24H/AaeqPupR2kJ7gphIS8r3YTBc2M4l4rb1aPiRqb8AR9ZYj98o5EqpduMzv1xQ0JR1/bubmJOX2U66uExoQWHboRY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyxWnb7TFn0LIKLtqJo7m4RwwIbcKe4DHgZC40Yp3lk=;
 b=SIQfbRz7VwyTqGTiWl7nyTYVEuf9rFcDf9QWbPrmcsAw0T0E55D1oPKoAt7Yb+d4u8j1SDzllF46ILNnUin7jC0B0iNPNLfFljjymxZrCjskUjOuLIiSk9ZQVG3WAFNhbXL6qhp+nRmW0gqWAs/YY/uB3ABgAMv7JaCKfc3gtk2ivoo6MwCTfHXrOJQIGlZiCMiBhomptysh1QodbWB/uan5GQ3ojWuUsO5EKep/Mc3a0E5vFZGXbfQD6Po54qz8bxegyQ4B5thtOeeVjdcfi53M0FRThHh99CiTBleVDZztaV7NDZ9vdE1nF+Fr+Yp5iSPzoDnym2fIO7p+aTjHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyxWnb7TFn0LIKLtqJo7m4RwwIbcKe4DHgZC40Yp3lk=;
 b=UiiD2IVFhKjtmws9oFSb6I5GAG9gLJFRb5tJYhw1clPEVxdZCtfxEOH7Jq9EGsot+sh71qNrjoerWl9X8INjVCKIV1UyujBsHjqfn75w460JG3QBN5wptXAeW1LNxl2VD5Adyfk/DvFWtQfUVTxF+434RRHfKedh4HTIV/K39dE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:06:12 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:06:12 +0000
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
Subject: [RFC PATCH v3 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Thu, 18 Mar 2021 18:35:09 +0530
Message-Id: <20210318130512.1025416-6-anup.patel@wdc.com>
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
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad8028b7-2629-49c6-a36a-08d8ea0e9a98
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB08269B82DC64519B9D62ED628D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQO3FMIGv5aNEEALGQmgLoiVriqM2W5AnyrOv/W+ScW51y4qm04Dfykw6mZZIfiYCrGwuxu35Cnpx2rFgQ14QB5+1vZsw4uOsQAy9ZqdPcSFllBNPoYI/LDXd7mNekJ+gZJ6sTcXNclj/scWTxtGES0g+fJNs0B60X/wfoz/Tpv1iujjQJKTEwgYiBhPKxdzogxe4tHSdGG3GUfRt4dm9Dqikbdh7yemPVRVD8ndnQMXR52QrGrPQ/fZIltugtJRG2XCJ+34SX3pNvzM0YwQ6pJQQ2vTPtGzyoqP8EMwqELHhHqPrjEDoaHud8tNppDe+POUdkoEf4TpurxMWuwqeJwj7R52p0JBMUn7L67CDVLwoVZ5OHIH9drxL/dJMvc8QauMWfKeljYjgMVv2SV3FyFbONEVw4r5UUrlkmQPLbD6itjEq06FcnRYmGTszwAcEz++auFxRrzEGj90OCWOGphk29l7Bf5Kr7bA+3J3gKRVwdylzJhD4u5mpjMN51XzW3AMuutO+tetRL+iSzNkGVGlaeBGeJ+JyaWY6ZQIrXualdyNrc9IaypVuThk/o1XNKxyaMIR3BSAkNjf0eYU95zneNVRTiOorPqxE6m8pp7Ll4BeApJVtRt7EaJAfvCG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(30864003)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(66476007)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xj1Z61g5tfrf+ao88PnNJc95Hk1rO/38iXB3iWw0oY0LlToFAQYPlTnKfaLn?=
 =?us-ascii?Q?84RAD6b1QwXRHh1fWGBdZFrFXeEELlsEXlgkPyzioEnVZN2H8w0jByoUwpNO?=
 =?us-ascii?Q?op3XtSg2tw5jL49txMJq21r2bZGPFF0UO8h4MiGLLQWNAjRqjRIN78i/ArfX?=
 =?us-ascii?Q?Q8drWCkUW44Q3LENfvyoLZnJJObGsg+aPJkl2e4XPWS70AzhSseJEU6I2Ye6?=
 =?us-ascii?Q?yFHk+GLoiWsu8LoPkkWHL3j/FPEKRmUMl17MbQyMXd9nyj61J2oTQ4O6ejAu?=
 =?us-ascii?Q?iJsyphS93Nrv+mbZfODoOVqt82in0L6608g4wIzWYu1X/IpFwPRNsUVFcEaK?=
 =?us-ascii?Q?d1UjiqggVIKU3Y88hMDHwaIb6wOnz8DJslEAQqzfCa5a73nN8HYC07sp+j/O?=
 =?us-ascii?Q?qr7tAR9P1fQzvuSBexxXApdApq0Hf24m3Lbc1xfQ26EY2/5q1c1GNL1uEG2w?=
 =?us-ascii?Q?PlhX02OITTIOIz9xMUB2exnShZXnaed37JmPfY4vvDIWV+wIJ79t7FVI36Hp?=
 =?us-ascii?Q?BebjbOPS4VHBUWUNOXL7QntTukNhSjplp60iiS6bV/z7PnidpIK/1C4bgSry?=
 =?us-ascii?Q?Vysk8l8NI7yTwcW3gIcx9reETQXlSHOhysqUGjFmTGGCS93pucWGSjbwEiEg?=
 =?us-ascii?Q?W9kaQ4B6zIwUW1YiR6OAOhsvi9EuvhLj2iK2jym4DqbzwtHZGyCXKW1UCzSd?=
 =?us-ascii?Q?f2RCESNI9heEgrTZvA5Z2N6XXrVbnx7WFSkbAb2Y/C5UlTG15Kl9HCNau714?=
 =?us-ascii?Q?dBtHhForictctLfFWA5qkflmxSUg+1J+soBjYuuOwSGePYrSQFIjkqF/ZeEe?=
 =?us-ascii?Q?QCfT5xGN0UwF3hMWE44BBJ9F7Onq2oN6Dtrpv+bLOpFkuoVgxHxVhrxGEqHe?=
 =?us-ascii?Q?MPfVfWCkPDkuqumQeQlVuRb3K1IU5evMC2OPxVaNvEP7MXxbMEFapLQut2iu?=
 =?us-ascii?Q?UB7nrn9hFMNIsSZMAmudyzQf7cbA4hJLAZhZy2LE/nrwpchdBagtWn95a9Wc?=
 =?us-ascii?Q?4lZamx4YViauUMiWv+y+GUWVlxzlWafp3nawiEtFUbOjmjc1SM4pJDXIIIMU?=
 =?us-ascii?Q?YMwhOcgvWhqa8eFAZdLG3BsJZoeUwQw14iM9iGyS8xB/WCbMk6VwN4/pXUZr?=
 =?us-ascii?Q?VYnDt/8aBEGHQkwM/5jluAqcVooho6SEoCS7cMZUe9OhyzR2en0XZD9KcyTQ?=
 =?us-ascii?Q?ZKb3dsHeogHzUFjqxJ4Yb/Xwiwdc1LiC595AWE84IG8B7XbqSOPKDesMS18H?=
 =?us-ascii?Q?aT8fg+yaC5JQJwOnDlWuHaX12dbcFJ+JlRxQM0A7suiK52GQcBb+ijssWTke?=
 =?us-ascii?Q?QV83lnHeG20E0IRM+mSDg+0b?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8028b7-2629-49c6-a36a-08d8ea0e9a98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:06:12.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFiZfpLmhE0ew2UToeS8S9O4SJ2E4xZ5OoSVXmkLt1Pt8G4cWXpFL2wim396gC3DYujoTVyXqFph2GRMsB5PsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic power domain related code in PSCI domain driver is largely
independent of PSCI and can be shared with RISC-V SBI domain driver
hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/cpuidle/Kconfig                       |   4 +
 drivers/cpuidle/Kconfig.arm                   |   1 +
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c         | 244 +-----------------
 drivers/cpuidle/cpuidle-psci.h                |  15 +-
 ...{cpuidle-psci-domain.c => dt_idle_genpd.c} | 165 ++++--------
 drivers/cpuidle/dt_idle_genpd.h               |  42 +++
 7 files changed, 121 insertions(+), 351 deletions(-)
 copy drivers/cpuidle/{cpuidle-psci-domain.c => dt_idle_genpd.c} (52%)
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

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
index 0844fadc4be8..1007435ae298 100644
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
index ff2c3f8e4668..b0621d890ab7 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -16,17 +16,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/psci.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 
 #include "cpuidle-psci.h"
 
-struct psci_pd_provider {
-	struct list_head link;
-	struct device_node *node;
-};
-
-static LIST_HEAD(psci_pd_providers);
 static bool psci_pd_allow_domain_state;
 
 static int psci_pd_power_off(struct generic_pm_domain *pd)
@@ -47,178 +39,6 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
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
-static int psci_pd_init(struct device_node *np, bool use_osi)
-{
-	struct generic_pm_domain *pd;
-	struct psci_pd_provider *pd_provider;
-	struct dev_power_governor *pd_gov;
-	struct genpd_power_state *states = NULL;
-	int ret = -ENOMEM, state_count = 0;
-
-	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
-	if (!pd)
-		goto out;
-
-	pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
-	if (!pd_provider)
-		goto free_pd;
-
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
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
-
-	/* Allow power off when OSI has been successfully enabled. */
-	if (use_osi)
-		pd->power_off = psci_pd_power_off;
-	else
-		pd->flags |= GENPD_FLAG_ALWAYS_ON;
-
-	/* Use governor for CPU PM domains if it has some states to manage. */
-	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
-
-	ret = pm_genpd_init(pd, pd_gov, false);
-	if (ret) {
-		psci_pd_free_states(states, state_count);
-		goto free_name;
-	}
-
-	ret = of_genpd_add_provider_simple(np, pd);
-	if (ret)
-		goto remove_pd;
-
-	pd_provider->node = of_node_get(np);
-	list_add(&pd_provider->link, &psci_pd_providers);
-
-	pr_debug("init PM domain %s\n", pd->name);
-	return 0;
-
-remove_pd:
-	pm_genpd_remove(pd);
-free_name:
-	kfree(pd->name);
-free_pd_prov:
-	kfree(pd_provider);
-free_pd:
-	kfree(pd);
-out:
-	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
-	return ret;
-}
-
-static void psci_pd_remove(void)
-{
-	struct psci_pd_provider *pd_provider, *it;
-	struct generic_pm_domain *genpd;
-
-	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
-		of_genpd_del_provider(pd_provider->node);
-
-		genpd = of_genpd_remove_last(pd_provider->node);
-		if (!IS_ERR(genpd))
-			kfree(genpd);
-
-		of_node_put(pd_provider->node);
-		list_del(&pd_provider->link);
-		kfree(pd_provider);
-	}
-}
-
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
@@ -244,6 +64,10 @@ static void psci_cpuidle_domain_sync_state(struct device *dev)
 	psci_pd_allow_domain_state = true;
 }
 
+static struct dt_idle_genpd_ops psci_genpd_ops = {
+	.parse_state_node = psci_dt_parse_state_node,
+};
+
 static const struct of_device_id psci_of_match[] = {
 	{ .compatible = "arm,psci-1.0" },
 	{}
@@ -252,48 +76,25 @@ static const struct of_device_id psci_of_match[] = {
 static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *node;
 	bool use_osi;
-	int ret = 0, pd_count = 0;
+	int ret = 0;
 
 	if (!np)
 		return -ENODEV;
 
 	/* If OSI mode is supported, let's try to enable it. */
 	use_osi = psci_pd_try_set_osi_mode();
+	if (use_osi)
+		psci_genpd_ops.power_off = psci_pd_power_off;
 
-	/*
-	 * Parse child nodes for the "#power-domain-cells" property and
-	 * initialize a genpd/genpd-of-provider pair when it's found.
-	 */
-	for_each_child_of_node(np, node) {
-		if (!of_find_property(node, "#power-domain-cells", NULL))
-			continue;
-
-		ret = psci_pd_init(node, use_osi);
-		if (ret)
-			goto put_node;
-
-		pd_count++;
-	}
-
-	/* Bail out if not using the hierarchical CPU topology. */
-	if (!pd_count)
-		goto no_pd;
-
-	/* Link genpd masters/subdomains to model the CPU topology. */
-	ret = psci_pd_init_topology(np);
+	/* Generic power domain probing based on DT node. */
+	ret = dt_idle_genpd_probe(&psci_genpd_ops, np);
 	if (ret)
-		goto remove_pd;
+		goto no_pd;
 
 	pr_info("Initialized CPU PM domain topology\n");
 	return 0;
 
-put_node:
-	of_node_put(node);
-remove_pd:
-	psci_pd_remove();
-	pr_err("failed to create CPU PM domains ret=%d\n", ret);
 no_pd:
 	if (use_osi)
 		psci_set_osi_mode(false);
@@ -314,28 +115,3 @@ static int __init psci_idle_init_domains(void)
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
index d8e925e84c27..70de1e3c00af 100644
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
+	return dt_idle_genpd_attach_cpu(cpu, "psci");
+}
+
+static inline void psci_dt_detach_cpu(struct device *dev)
+{
+	dt_idle_genpd_detach_cpu(dev);
+}
+
 #else
 static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
 static inline void psci_dt_detach_cpu(struct device *dev) { }
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/dt_idle_genpd.c
similarity index 52%
copy from drivers/cpuidle/cpuidle-psci-domain.c
copy to drivers/cpuidle/dt_idle_genpd.c
index ff2c3f8e4668..805c4c81d60f 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -1,71 +1,52 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * PM domains for CPUs via genpd - managed by cpuidle-psci.
+ * PM domains for CPUs via genpd.
  *
  * Copyright (C) 2019 Linaro Ltd.
  * Author: Ulf Hansson <ulf.hansson@linaro.org>
  *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
  */
 
-#define pr_fmt(fmt) "CPUidle PSCI: " fmt
+#define pr_fmt(fmt) "dt-idle-genpd: " fmt
 
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
-#include <linux/psci.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
-#include "cpuidle-psci.h"
+#include "dt_idle_genpd.h"
 
-struct psci_pd_provider {
+struct dt_pd_provider {
 	struct list_head link;
 	struct device_node *node;
 };
 
-static LIST_HEAD(psci_pd_providers);
-static bool psci_pd_allow_domain_state;
+static LIST_HEAD(dt_pd_providers);
 
-static int psci_pd_power_off(struct generic_pm_domain *pd)
-{
-	struct genpd_power_state *state = &pd->states[pd->state_idx];
-	u32 *pd_state;
-
-	if (!state->data)
-		return 0;
-
-	if (!psci_pd_allow_domain_state)
-		return -EBUSY;
-
-	/* OSI mode is enabled, set the corresponding domain state. */
-	pd_state = state->data;
-	psci_set_domain_state(*pd_state);
-
-	return 0;
-}
-
-static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
-				     int state_count)
+static int dt_pd_parse_state_nodes(const struct dt_idle_genpd_ops *ops,
+				   struct genpd_power_state *states,
+				   int state_count)
 {
 	int i, ret;
-	u32 psci_state, *psci_state_buf;
+	u32 state, *state_buf;
 
 	for (i = 0; i < state_count; i++) {
-		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
-					&psci_state);
+		ret = ops->parse_state_node(to_of_node(states[i].fwnode),
+					    &state);
 		if (ret)
 			goto free_state;
 
-		psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
-		if (!psci_state_buf) {
+		state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
+		if (!state_buf) {
 			ret = -ENOMEM;
 			goto free_state;
 		}
-		*psci_state_buf = psci_state;
-		states[i].data = psci_state_buf;
+		*state_buf = state;
+		states[i].data = state_buf;
 	}
 
 	return 0;
@@ -77,8 +58,10 @@ static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
 	return ret;
 }
 
-static int psci_pd_parse_states(struct device_node *np,
-			struct genpd_power_state **states, int *state_count)
+static int dt_pd_parse_states(const struct dt_idle_genpd_ops *ops,
+			      struct device_node *np,
+			      struct genpd_power_state **states,
+			      int *state_count)
 {
 	int ret;
 
@@ -87,15 +70,15 @@ static int psci_pd_parse_states(struct device_node *np,
 	if (ret)
 		return ret;
 
-	/* Fill out the PSCI specifics for each found state. */
-	ret = psci_pd_parse_state_nodes(*states, *state_count);
+	/* Fill out the dt specifics for each found state. */
+	ret = dt_pd_parse_state_nodes(ops, *states, *state_count);
 	if (ret)
 		kfree(*states);
 
 	return ret;
 }
 
-static void psci_pd_free_states(struct genpd_power_state *states,
+static void dt_pd_free_states(struct genpd_power_state *states,
 				unsigned int state_count)
 {
 	int i;
@@ -105,10 +88,11 @@ static void psci_pd_free_states(struct genpd_power_state *states,
 	kfree(states);
 }
 
-static int psci_pd_init(struct device_node *np, bool use_osi)
+static int dt_pd_init(const struct dt_idle_genpd_ops *ops,
+		      struct device_node *np)
 {
 	struct generic_pm_domain *pd;
-	struct psci_pd_provider *pd_provider;
+	struct dt_pd_provider *pd_provider;
 	struct dev_power_governor *pd_gov;
 	struct genpd_power_state *states = NULL;
 	int ret = -ENOMEM, state_count = 0;
@@ -129,19 +113,19 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	 * Parse the domain idle states and let genpd manage the state selection
 	 * for those being compatible with "domain-idle-state".
 	 */
-	ret = psci_pd_parse_states(np, &states, &state_count);
+	ret = dt_pd_parse_states(ops, np, &states, &state_count);
 	if (ret)
 		goto free_name;
 
-	pd->free_states = psci_pd_free_states;
+	pd->free_states = dt_pd_free_states;
 	pd->name = kbasename(pd->name);
 	pd->states = states;
 	pd->state_count = state_count;
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
-	/* Allow power off when OSI has been successfully enabled. */
-	if (use_osi)
-		pd->power_off = psci_pd_power_off;
+	/* Allow power off when available. */
+	if (ops->power_off)
+		pd->power_off = ops->power_off;
 	else
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
 
@@ -150,7 +134,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 
 	ret = pm_genpd_init(pd, pd_gov, false);
 	if (ret) {
-		psci_pd_free_states(states, state_count);
+		dt_pd_free_states(states, state_count);
 		goto free_name;
 	}
 
@@ -159,7 +143,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 		goto remove_pd;
 
 	pd_provider->node = of_node_get(np);
-	list_add(&pd_provider->link, &psci_pd_providers);
+	list_add(&pd_provider->link, &dt_pd_providers);
 
 	pr_debug("init PM domain %s\n", pd->name);
 	return 0;
@@ -177,12 +161,12 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	return ret;
 }
 
-static void psci_pd_remove(void)
+static void dt_pd_remove(void)
 {
-	struct psci_pd_provider *pd_provider, *it;
+	struct dt_pd_provider *pd_provider, *it;
 	struct generic_pm_domain *genpd;
 
-	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
+	list_for_each_entry_safe(pd_provider, it, &dt_pd_providers, link) {
 		of_genpd_del_provider(pd_provider->node);
 
 		genpd = of_genpd_remove_last(pd_provider->node);
@@ -195,7 +179,7 @@ static void psci_pd_remove(void)
 	}
 }
 
-static int psci_pd_init_topology(struct device_node *np)
+static int dt_pd_init_topology(struct device_node *np)
 {
 	struct device_node *node;
 	struct of_phandle_args child, parent;
@@ -219,49 +203,15 @@ static int psci_pd_init_topology(struct device_node *np)
 	return 0;
 }
 
-static bool psci_pd_try_set_osi_mode(void)
-{
-	int ret;
-
-	if (!psci_has_osi_support())
-		return false;
-
-	ret = psci_set_osi_mode(true);
-	if (ret) {
-		pr_warn("failed to enable OSI mode: %d\n", ret);
-		return false;
-	}
-
-	return true;
-}
-
-static void psci_cpuidle_domain_sync_state(struct device *dev)
+int dt_idle_genpd_probe(const struct dt_idle_genpd_ops *ops,
+			struct device_node *np)
 {
-	/*
-	 * All devices have now been attached/probed to the PM domain topology,
-	 * hence it's fine to allow domain states to be picked.
-	 */
-	psci_pd_allow_domain_state = true;
-}
-
-static const struct of_device_id psci_of_match[] = {
-	{ .compatible = "arm,psci-1.0" },
-	{}
-};
-
-static int psci_cpuidle_domain_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
 	struct device_node *node;
-	bool use_osi;
 	int ret = 0, pd_count = 0;
 
-	if (!np)
+	if (!np || !ops || !ops->parse_state_node)
 		return -ENODEV;
 
-	/* If OSI mode is supported, let's try to enable it. */
-	use_osi = psci_pd_try_set_osi_mode();
-
 	/*
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
@@ -270,7 +220,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		if (!of_find_property(node, "#power-domain-cells", NULL))
 			continue;
 
-		ret = psci_pd_init(node, use_osi);
+		ret = dt_pd_init(ops, node);
 		if (ret)
 			goto put_node;
 
@@ -282,44 +232,27 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		goto no_pd;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
-	ret = psci_pd_init_topology(np);
+	ret = dt_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
-	pr_info("Initialized CPU PM domain topology\n");
 	return 0;
 
 put_node:
 	of_node_put(node);
 remove_pd:
-	psci_pd_remove();
+	dt_pd_remove();
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
 no_pd:
-	if (use_osi)
-		psci_set_osi_mode(false);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dt_idle_genpd_probe);
 
-static struct platform_driver psci_cpuidle_domain_driver = {
-	.probe  = psci_cpuidle_domain_probe,
-	.driver = {
-		.name = "psci-cpuidle-domain",
-		.of_match_table = psci_of_match,
-		.sync_state = psci_cpuidle_domain_sync_state,
-	},
-};
-
-static int __init psci_idle_init_domains(void)
-{
-	return platform_driver_register(&psci_cpuidle_domain_driver);
-}
-subsys_initcall(psci_idle_init_domains);
-
-struct device *psci_dt_attach_cpu(int cpu)
+struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name)
 {
 	struct device *dev;
 
-	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
+	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), name);
 	if (IS_ERR_OR_NULL(dev))
 		return dev;
 
@@ -331,11 +264,13 @@ struct device *psci_dt_attach_cpu(int cpu)
 
 	return dev;
 }
+EXPORT_SYMBOL_GPL(dt_idle_genpd_attach_cpu);
 
-void psci_dt_detach_cpu(struct device *dev)
+void dt_idle_genpd_detach_cpu(struct device *dev)
 {
 	if (IS_ERR_OR_NULL(dev))
 		return;
 
 	dev_pm_domain_detach(dev, false);
 }
+EXPORT_SYMBOL_GPL(dt_idle_genpd_detach_cpu);
diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
new file mode 100644
index 000000000000..a3d3d2e85871
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_genpd.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_IDLE_GENPD
+#define __DT_IDLE_GENPD
+
+struct device_node;
+struct generic_pm_domain;
+
+struct dt_idle_genpd_ops {
+	int (*parse_state_node)(struct device_node *np, u32 *state);
+	int (*power_off)(struct generic_pm_domain *pd);
+};
+
+#ifdef CONFIG_DT_IDLE_GENPD
+
+int dt_idle_genpd_probe(const struct dt_idle_genpd_ops *ops,
+			struct device_node *np);
+
+struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name);
+
+void dt_idle_genpd_detach_cpu(struct device *dev);
+
+#else
+
+int dt_idle_genpd_probe(const struct dt_idle_genpd_ops *ops,
+			struct device_node *np)
+{
+	return 0;
+}
+
+static inline struct device *dt_idle_genpd_attach_cpu(int cpu,
+						      const char *name)
+{
+	return NULL;
+}
+
+static inline void dt_idle_genpd_detach_cpu(struct device *dev)
+{
+}
+
+#endif
+
+#endif
-- 
2.25.1

