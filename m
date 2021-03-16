Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1872833D206
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhCPKnP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:43:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13505 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhCPKmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615891362; x=1647427362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h7XIRrb7qnCKO+6OJrZJvs+TZXOJkBQhu0RoEYGRKeM=;
  b=SmnlvkQLwoFRFopK6Dt3pIMRXBr2VtO1pSXpCZmFOyu/fP/+czkFb2Et
   13/6SWR7evSnHzZDYbIxzG6SuUbOdTjmMxyI/O/OeLyDDDNLjRmbGWBM5
   tfoS2xLygnVnQhJgIhiNFWvNquclRtQ4lqAV8iGxlLBzeAPVlRQCvN1Ei
   /UnTKmxEveSVuUMTNZswJisD/MoVVejrf+w4Wm8LMztE7QCibZj+nyOk0
   fjjt5FayxP3ipdGDvfyF1IzP47eglv/H2Gx/RmylcoMneZHBDjoipf290
   pgLBR3gKlj/7tHYuX8djWmRO4f873uIqand6RYz3wwoCmOCcdy1OWuOFx
   g==;
IronPort-SDR: qH8ID56MTM5vYL/m2TF+2ir4G/0j0z94NxzlXw3atUYY62UwpgdCGO1Vl7EJCqK8ebR5qCxGRz
 6tq1w6ibwa58IR6u9JxpxNqJ9FMigYB/+SmRdpXSDQeXdAgh7YxUNU9zZlZvexS63J0ujn5YF0
 l7cVgTW0RnVdDlzI1Aq/6U0lp3MmTFvCojUmSlHIghkeKdgfWFLYc8Tx/fys+S0SGytTPuMTph
 MJv3aEKOlU8zBa5DeyflVMg8a3BUcvrbfJfCMA/0pzCc2f/UmZis1PebBTm1pGO9/uKK2m68hL
 u7w=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272971773"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:42:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipYGQS6KXKrLkcEUJOhfClJt0w2RZrfHCB/HOPXIeTHReHblzzDVlbAPetT9LmbKBkbzysAOd49QveRgy+gMqKeg1BymJzc2pCFtQNbuQ5jYUYq4W095dW8Zq+8A9FZxhk/JSnSynzh9dpjBbr8z8vyE+YWTJuF+GM5KCDb3Tx9ovHzpYFF1BNgfY5JRMP19OfMjSo8DweeXiXEmk64Q6KRz2FtTU/vuvkZa+TqNWU9QuVovZho+z2nqRW/jQwsyLVmdWl+iA2kb3u7u7yM3KCfGPxJlzLSbBhJAw1XeuRb8drybwbGSxqRLTZ+lMgna9it/5lp/Gnk3zfuAn+04kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyxWnb7TFn0LIKLtqJo7m4RwwIbcKe4DHgZC40Yp3lk=;
 b=YdA7RKbYjuljnqRuAu3tojrSB3yV7bIJMvQs/nzy6U2i3fP7ZgBJrcSOs22DdHGIPvh3Ob3y1o28N9Bf3oQIPmq5o5+uK2VbiUa3YxNXAkEsMJYJVnuVRa0hrcimS4/o8rDc5mIKwHGM4uOnZpF2TY3o6OnGYB5p0JKG6QTcWej6LpvjnKXgqwZPIE9JVhwuKDi/FgxpGKK2l6rTxJgEifo2AX1KHXxid3BXZ/+MPrzkrAabix+OyxHHSKzSuZ/RzBj8sg3go49jm/XiUNhiDmTK4D6sehveJkGO6M2eLHiJHVfe9QY+s+ZZkQdfq3iKwbwVXjezb+AOW3j9wJ9TvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyxWnb7TFn0LIKLtqJo7m4RwwIbcKe4DHgZC40Yp3lk=;
 b=R1gggQxtsBZYT9tzQYRuS/8c/emX6LUh6K3RD1q3R53EyIW3Lrtsw+I7l7IpOhXpBChPGCr6+zGMEAYReUtsp3Lwxn6ET6WzVZgYOw94fpNeAMrUdOBMZ8vMqLErHxLhHnK/kltF347/y7h4I5er5ai26Co62zDFqSVT4vyhkCo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6377.namprd04.prod.outlook.com (2603:10b6:5:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:40 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:40 +0000
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
Subject: [RFC PATCH v2 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Tue, 16 Mar 2021 16:11:37 +0530
Message-Id: <20210316104140.878019-6-anup.patel@wdc.com>
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
Received: from wdc.com (122.167.218.45) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 10:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47517f90-6b15-4322-da14-08d8e86838b0
X-MS-TrafficTypeDiagnostic: DM6PR04MB6377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB63776F3CC24AF9EDA3730B848D6B9@DM6PR04MB6377.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0aBDNJy75QBx3a+yitb6Bxs/+QiN7DcBxI9wjZoM6c4SubXeU4+W8Bsu64aJjB8wiIMK/7Uvi21xC+k7Dd0UfNHqUOHm0y3ma1BvyxCM1tGpB3ayizzWhLINutD9wLmkq0S44Yt2DXTSpAJv2PBuNAwZvqHRDvWZ9IZQaz+vwZkjnKJYnedx3dzzMcgHSRYddMPY93MWVJXtEqOyr8fDeuulAML3RUNSW07qN7WkyeVz2g+OpwdipaWnGwp255qL6vX6nJ5h03l8khaQKfP+DFQpCLGJJG3X6huCF2bZsJbYgRnq/HxO4s4cPnzfhjWSa/Nq1mEHW33Rghw3NpZ4mndpvYaTUlObkhpq6K8x4lDqddI3l3RJcJfTleae9qakWl2K3LzBwCiIIFLlaZ90s5ripwwG5+ESXMNiYlJKmGPRfLPWnIfDlwEJ5fgON2F7XF56F1IToiZDO1qgjaRq2V4K4WGON0e4QQPzj2lJoIG+wVSp3KeFk9gvqOoRVWjkLs6S7t/NdJr6OgpmuumIAKD4MAc1hMeUfDCQsx3HVxXPKuqBCp/DFyaKeWau/Re
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(44832011)(52116002)(86362001)(83380400001)(110136005)(7696005)(8936002)(66946007)(8886007)(55016002)(7416002)(186003)(66556008)(30864003)(16526019)(66476007)(26005)(956004)(2906002)(2616005)(4326008)(5660300002)(498600001)(1076003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Li4nXAasR/0QfaWXL/rKPgaI69amXql1GMblwtnC0tUqJPOroqrPm5Z0B3eX?=
 =?us-ascii?Q?vmY9JwxZKQE0EDGXYexmT2CBNzEQoWiwq5z+5ZWdF27M6+pEU6x2ssfL1iY+?=
 =?us-ascii?Q?qQ03I5ik37AwS4dFIKrP5nSUrne4rjy+aKIYOKLzQ6yuYVw/rI4SRybVmheO?=
 =?us-ascii?Q?vF6DZOI5Ss+ZGkXihA+1pqMZ2/OAMwalNUIm/b7GeO4uih/wdxQLdFDms3Sy?=
 =?us-ascii?Q?jZ1WMJqNHTzWA7rv0AsYCLIpqIgkF0J91yvPqYbFtA0lpJrXMn0+fsTxuALh?=
 =?us-ascii?Q?S+Y6Lf9CpnpNthVZGTWRb+PPevjtr09IF9uFQy41kwe7LoU3Q9u6UBfZg0p3?=
 =?us-ascii?Q?xD8Z3qbG8wnkC4X676uQO6C7v9bX0pMgqgxZVsc9D1TBirLvbm0/tC92YE4Q?=
 =?us-ascii?Q?cCIdMyQbvEeZTO8adEx0Bhg4VnIrtTzNtQTg/U1WpCkz/5xt3Wl0vSKuzdRq?=
 =?us-ascii?Q?BqDF/relKkj0mBTtsHX9ibzAamJAafBF3ygbbBbl6S+STXguHA3KrfG7lujF?=
 =?us-ascii?Q?cBm7CK8kVWLBfC2qbaZlgmVFV9FtxG9tIrsqBncSKXitRZSbp0hpmpnFHl8j?=
 =?us-ascii?Q?Y1ZA+8wob2g8X5cCtoFOPnBPqU452RTSLFuNjeSBfpUEmKxu47FlMzmJwafl?=
 =?us-ascii?Q?O0zHoceB+pm89TfRWSCndxy7Ywzbl+OX2iVl9+gQmOUwfS7/cezvUz3LXUtp?=
 =?us-ascii?Q?10UPusaFF+0VqeFmql8nV0Gbue8a+ckUhgo8H7kprVK/H2lT4uZ3jK9VWb+8?=
 =?us-ascii?Q?eG+RklWI88hUhS7UXRZlhgdR05ak2vl6I3D0st0eYsuYqmyw8BytsugVNf0R?=
 =?us-ascii?Q?qRIQNJWB/dvQiTVDM/kZPKjELCjwlJnx26ojdJZ+6DJlxXXq6RHgC7gcPlO+?=
 =?us-ascii?Q?kjZImqq0MSiijU0bzIwVY2/62FcYCO0sRKtc8TuvoaVKLq6Lyiup3H9XF493?=
 =?us-ascii?Q?w4hPgraIL89mpriNTqOC21GEGJ69HxyRY3Ydbr3f6EU4tRx+DTHjY2IPHCu8?=
 =?us-ascii?Q?BBaFRJa1gbdDk5TBogRF0A2hk9WHbPZQfJqgecekwOZxKKXJj62lBo92wWdz?=
 =?us-ascii?Q?6W/3vaRHDIzAH5BixgcEWNydJ9cJ3PVc/9sDx0rLPn2HpfMI6MIGrt6eHyfb?=
 =?us-ascii?Q?YEEjfZcPbIfDzHYjO8keSDF3Ox46B32m38dP1Kf1qs3erVGlzgv5M6kHH3SP?=
 =?us-ascii?Q?Eoycr0JRw7WuG+0s6Vw8UuEbDbAA2GTMGoDr/6IzQMtDssRNI3U4e3mFdHg/?=
 =?us-ascii?Q?PMbZWiL0vTSeimp8M2rLJre/JTQdo2oVG+EJulDUTxGupLlrDcS83FgfR2IA?=
 =?us-ascii?Q?i7QRy63L4CP5IHz0w2XGCD28?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47517f90-6b15-4322-da14-08d8e86838b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:40.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sv4Safjaxuaxm0saOovZovGhqVO+zgrP3Re7oyB71Kdh8oyGOztvcify9ZxKHx4/5DlwdeuFhemi5N6EhxMmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6377
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

