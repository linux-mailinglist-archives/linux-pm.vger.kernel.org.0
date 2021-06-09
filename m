Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACC13A1462
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhFIMaF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:30:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54359 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhFIMaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623241687; x=1654777687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nzy9pCl8zwYLJGc+tqg047HMq9wQYVcYuA1f89D7X7Y=;
  b=ovDHjpQxYEew2+6dwFfCuaSDKbAEP37TVY923FuxslX4l/oXmaIys0uk
   yEqal3IUkUcTihG2wq1kcb2TAtxAIBgvq2LgN7z7obTePWyMtj3fjmAaq
   MFKRjUK7sxjxzMF8Vml9CRwW7+xj8nbsuJtauo9OJUive19TYg1JsQa69
   MMJBqMh3uNi0Jp/hDJ3tLDUZ4k2nDG4dIXL99NwXY1IU/88WtVSmw6C0e
   lsaPYqeUR/rI8yOVHaRCN71vQp/3h/QP+N06mETMXDDBIZk+xwY7c6WiK
   F89OLDxzq08xrYnjrWzTI6TUzcWioifcc2bwBWvf0d9nTW2b2gidYn2kx
   g==;
IronPort-SDR: FvKoMe6UJ/q2so3vV7S0y3BFPDRpjTppQ1MRaHDotDnW+4cLWsJP+KbxJWIdduFMA+qKCq1ARP
 c+/15Y2zDt5/jXmOlSWcF6eoT4/CnyoCLqYHvpBQsFxNMA9FeL+FMa7UPGr4E7kzO4vDuLahcE
 fdZOFIK5lIjCnKwm4++R4WkNMp+9sYQP+8oJCiyOqf/74MnzfLeauAD10CbMaA3O2Y9aupoe4U
 +nT9/riFfsn7h19gspiqRf/sR31jcwD+DlsRu1ZSM15fv2Mad9j7F2TQyV7Ffj1Ob6t7vO2f2p
 G20=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="171847855"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:28:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtgT3Hp3BczX52TfbxmdI95CFrk2SZxERxRYxHtW1gVbJAwJHH3LCc/gSyJhf3II1p7cTC9z377eRFq5DdNoq6c2IXs0X3Xx7OaXW612YY1uHaCRrpEeSWwiemQGVLenAfleo520kQX4vt6RAtVkYxbTJbqrZJOzl5Yv0A3GruJ+q90clkPr0SWwVwds0azk1eYDO71Kc87gSbVTpUlGK9vBqWnSkLcg+9ZKqdWpQ2MIjuG1Xu9f9l0SKwbggc++kb7WHaZd86+bM2sER85b9cYSs5cqUg7+W3j6Npe0L4ObIaGswxAGT6DiY8oWJkuHrBb3SPi26B1n/c6K888rNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/jB78KPasPpB+gWqSbtnjXrkCttN6l+ligdt5QCVT0=;
 b=QJLMtRl9o8R8GxzsSYRmpK92cVO+hkoQcUKTyuqjjdzkSNkZ9Opf+UInngeALasZwfo4YSEOVtg3e97OgPe0icHZ+efm30P4aHU7gT4jpBw6PFTzz2bRpEI1Wp569uBX9gee/EpdP8U8hlwIklNF+vwy4p2NtcWSN3Vk0plPIiFX2zO0vQJ8MyWqlGpoX33MIiWW0o9mTdpyO/vtm7560WFc/kAceZKPDv1LGbf0p4iKlKoYpefqinOqafirHkSvm7xiq7xxan/JKeUO5GQN0urhxOgt/h1rhc4W+HRlW1rOm6v0vvuWiawD8blJcXRnq6Btsbmpailg9yC16/vAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/jB78KPasPpB+gWqSbtnjXrkCttN6l+ligdt5QCVT0=;
 b=C8AI7+VPNten9vGlizAu0vfhJaBvAEoi00KXqJVAhflGNLOU4B3suG6BLIzjmM2NjM6Dz+WIvwHBkhWttmVH+EB2ViP6WNjZFfNu5gt9728QdLz1LiWh9WiYaomF79XGP7YC7tJJQ6Kh3nEMcDS0pPW3B2hpb2rOq4bqsVFBZOc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:28:05 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:28:05 +0000
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
Subject: [PATCH v6 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Wed,  9 Jun 2021 17:57:12 +0530
Message-Id: <20210609122715.3389-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609122715.3389-1-anup.patel@wdc.com>
References: <20210609122715.3389-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.172.176.125]
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e3fb2a-fc9b-40f3-4465-08d92b4207c0
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7843DF8C4E595412BE94C5138D369@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MePUSvSpFgBlz+mnQe0l9bIg+FPNfaowS2kio+Eduz2m2hrpllZqkwFRg/Gv8PVYJU7iLKhqEaYXKf/+C5R3kXuNjuHcSMBYaeO1JcVG0R9S+aJ9BaMxUmO236OU7doSBoig28r90/2gsAoAlE/i7TsJ+DF1E58YiFgHe+RkvMxK+C9DQYal5B8T97c23ixYNFA+otO13C+X1C20uTTiyfisR1NjWzRPPjNdK9d0Dpxo69y3UX9FkfansJReJp5HPl0FNQKfOxJ8reFeDIcReRqGt/7H9k+/ChV2KQjZaCY4A8x8JfmxPTKPj9t1ESUwRgyzvv7HXXE7tCZ/Tj6s2zbSeUb4/yqX2O+WoUtyvKk16SLxvaDLR53FzzwvVFkzSfre159XRxeaKuHBhxq4FofUTuUwv+bCaKq/5QNUKHZafsZHOR2g3phEummMpnqnjwb7uDKX9UmhHaVTdgn6qxzieKIdyyBZU9+6Gdij4gLUndre15Xp+V5Xv3kJAs6Bq/ZAsYH+mD3C2HDk/aQ95Pu2HbCIhRgeIpYWlcfmYrwSQULD+j/beWyF7BT8uSHUQ2NKkapqnrx+DaOLeDaPMk+onq3UsMI4PDZBdg8gD5Wy1lm4vQEceeEeFskNYbe50kRG3MWhyNZHaxsLkXbOBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(4326008)(8676002)(8886007)(83380400001)(478600001)(30864003)(110136005)(956004)(316002)(86362001)(6666004)(44832011)(2616005)(38350700002)(52116002)(2906002)(55236004)(7696005)(26005)(8936002)(38100700002)(1076003)(55016002)(66476007)(66556008)(66946007)(36756003)(16526019)(186003)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcQPtMHv9vQgNDq0q8tpHsOxTgzmC/Aj6GU4vIOaNFrCniNtJ6QRHJlXgGqq?=
 =?us-ascii?Q?CvDlcXhN/zFvCHRqoJeExWuLUtelYVwFtNEFONSU9FEOO95wKOIX5WdYQ5TV?=
 =?us-ascii?Q?BQl0nKaqGiAm7L3WetAt22iBJmq5eNGqFqvD8hy01WTg8Z9wXWj+0/6r+DAm?=
 =?us-ascii?Q?O3GSm3GxsSq7fjFkRuMPRdEMPrx6G5Y97Ub3KaI547f29RL9MGE/giYjBt4N?=
 =?us-ascii?Q?4ZBybxN42B1Iu7p3kGFFkrIl6Bk4WG0BFPIzXhIhgm+XFad444mi2LlKCNtc?=
 =?us-ascii?Q?jSeUEz2hIs2auqtMIawI+x1BkmKriswa3vBBMUCRFeWuLCJx3FmrcYHn7Mew?=
 =?us-ascii?Q?Lkmv7MhJQ3u4GOizRQLFeFjZvY3Y8eFV01f5B8PoHHDh6VtlZA1Ovj7WLIQZ?=
 =?us-ascii?Q?18MPnFUWidEg4RcTyl7w1TRy0Z3OrhibglAVOEYXRAKnbBSzuN+PUyJcCerE?=
 =?us-ascii?Q?SJvKfKP7hypTN0IVaWjJRkeQdg7TqwUnWmRV0aZv98HSd0DlM59M0/fXPnps?=
 =?us-ascii?Q?5VrqcVhFRCGH6KZzKhAGmhx2muuatUdkP0ZVNsUHyD2mQHaNntRO/CeOd0NK?=
 =?us-ascii?Q?oP/oZG8sZ3WtTyzZIyKuhVMoiFTHM9pby8XYRR6dqvOyimu8vJSBzXl9pNLK?=
 =?us-ascii?Q?O0tL2KyXsU6Njc9iNaJdiBunRfKCp8wxdaGCiH3nSmrHmTEjk+oA8a3TvEyH?=
 =?us-ascii?Q?P2S+P/MxpFFEWErQZNHhyJMYpvx9qtH6Jqs3BDhFYLtQQOPo/cFYBnnrKLzz?=
 =?us-ascii?Q?vIsIEXit+f4g+DMfG3Th6F1nbepT7hP3cQJxYPLRyLgRpz70mhqPEzpIgcej?=
 =?us-ascii?Q?re4nabDHD4z13gJWTJVjUkc2Ds/YgqozaxlmpBjHSFC2JeBxiHuppO5N++IA?=
 =?us-ascii?Q?wzju61WGfj77xtIF63rCjwit/8NUqQJP+7WI4PMmxpirKU8rTi8ql4TcsowB?=
 =?us-ascii?Q?YGRr8No5sYMU/8B2hZiLyyBCT9C9Vf1SrcqsgHJ1zVxq4mnhlk6OH5gRSfsT?=
 =?us-ascii?Q?K2KQYSU+kjVXL+eUXAzyQQaCvyLYclnLm2ggrRoDuwEVusifWnV4FvVv0mFS?=
 =?us-ascii?Q?CtFzm1jWdaLT3tmNMVTEoTM8hwCzx4i8CgEsOtB9hpLkFBi0sCKtgBLPoWHQ?=
 =?us-ascii?Q?K7mDuiRGIFx2vqJfCKx9n/qP9yZc/wz/YIXJQjRStpoSSuZT3y08cgrkaZYn?=
 =?us-ascii?Q?VwimxhPRwcF8+Ff9C4HmCCo7ZJEBbVuZhH1Bjp3M0j3+GE34x8t/akArPoX0?=
 =?us-ascii?Q?p5G/zZ0Yom0MJJm6txER6lWayMc36NnXcPMLp1i2JDfYHQGEchMb2lpIYL6E?=
 =?us-ascii?Q?Wwlv2uDruIt1knbiiiWI6DhK?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3fb2a-fc9b-40f3-4465-08d92b4207c0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:28:04.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h+CQhTZDJELzvT/hclBNae5lbkzuMMGKhrDlBos2s7mrtiqHEcdHk3+K4x7yOhqaPQUUR9jDVaNgZPfl18aKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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

