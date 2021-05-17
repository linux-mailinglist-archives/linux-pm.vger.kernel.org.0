Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9095D382CF8
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhEQNL6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:11:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59496 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbhEQNLn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621257026; x=1652793026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=W26lc1r24KGvt1ZTmzzesXIwYHpMFrJ3fW7dDbzK/fI=;
  b=HoOfIee7kK1AwKMr1YIPYA4hU41FSAOBqriru1FFEjGa8q7oTHiuAXy2
   YVl6n5QSkqkwop+eGksX+qd9gep6o0EaTjfjVNcWxj4qZG4h/0/1o0wYu
   ZBa2RECwejl5uAiBCFKoSS+E7H23kTAr7AELmSvJLFsGuMxcwEgws1sdh
   rXi4B3nPkCWupWkFAYucKqCIoBwZ8XNHX+U1s9bzI38GhifxUWdcJpJQC
   5ztEQwIcGQLUCNtyRYv4MtiojXwyxgPUGr1Li1SXfpDbMt1IgvNcnemXw
   dWVfv+69fooO4EyZ/b4GhSu6i9MwKvAoLIudLFcBOAu7jy8dhRApadOsq
   Q==;
IronPort-SDR: nBawk/WxO2f9zEZk4IWdYXA3+84YyowJatLZXqEnA7S+UUN6DJfdWpEQVtvQaA9x67TRUwX+aL
 WU/lKSxNh3hqdOQPGVEYSGNbw0hkRWkX6RKOBOvv0lLVV1MzTkek9Ab1CwAybxSrBcR5ksoHyX
 FB5vVvK8JT+3rJe76RLgyWFc7n3Wg3vUttYrlyBThZPP8qeRB02aWt0UvBjOTPsR+uIUQaHieV
 ucaB0PaQ+R6inkpfWl0qaN0zbHz93z/2+2H2+OaHowhFl+50/LzT54TMTYq1kyz2iL6chBOkHU
 DlM=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="167757222"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:10:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqvWaSdoT/g3PO7Dr4DF1xd0/JhuoJZDXgC+pqNLvcbTH0+3HXi+pw6ERuUlEgYG0C0a/SOxugv5pFqRy9IulF1Yf/Hfspl62gj8XmQHek0dUvqIxez43gzd/zOAlKOIEGm48EHFmu5BdXz95L5HwetNFOBFg4QaXsjIayZgsWiH+d8SbSXen7ZwE3R96iK2nrNI5oGfOxtS26tvH+PO8nZox9Hefj9n8GvU5aiZf1aXLRlF5TbyHKbEeC7RmVscfHUa/JeUsoorQVJa9oRZIsMzSfEYHsIwXGd1DEoA65T1iPf8rCwBRVs2a781DaJBpZ7u0ATltO6CeESTH8sP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZtmHLhpl09igiCVrvzyfQ1S3z/ZYdkoZsbRroVkSE0=;
 b=BghN5FV5NwfUhxry1cNDPgGGK0EOYJKWFkGKJUVo5fYsCBN+/DYAmbz2c2syF927/93MXQlAr6vVlK+qCawX5jIJYYAl6VKRyUwPIbYl0rE3Fv97ditJeTjmY9l7a8hZlyfhfd7RlCLE1r3ArlsyDH1RDH2u0oHNYOpn64Q3Z2mjSbOEraLs/tmEHiYD/rzmeTl8uG/Y0vJmGkLKtpEbsT1DRMP0Sja+BfEufpwZhsfQCftiTOwKuJtjfb7GLugXxPFGxsjOQEremvqrU1p1JsAz9+IE56uP+HB8qC3fqWcXNEjEp0HJkb7RaSFfLQoO00b4PVPGQtvAwNBuHFTJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZtmHLhpl09igiCVrvzyfQ1S3z/ZYdkoZsbRroVkSE0=;
 b=Dtcqv6OJ9Ams0WIdFsxYeLcaHnFAZfAUTbqBjA8AHHMBWaY/1x4DNo+eXwfmWQ4BrfkImi9fx0pzHrJWqEw5dN+9ZtBjPsvCCMrnX9oCaCbjgxL3yORs5a38GFQUMoCrVFsRhTRE54RhI+DZjcK8qX6KFeajL/vIJ4NcUeGmGF8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:10:24 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:10:24 +0000
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
Subject: [RFC PATCH v4 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Mon, 17 May 2021 18:38:20 +0530
Message-Id: <20210517130823.796963-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517130823.796963-1-anup.patel@wdc.com>
References: <20210517130823.796963-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.32.240]
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:10:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54fb0717-def2-4192-60fb-08d9193521bc
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778E9D58704A0FEBA913C978D2D9@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rT2aI2uSQvTL9m2aPiZRGS7+Wp3bJ9BRbZTliUPK5IHP12ets91CKSVCxbIJYJSbptcnEpMF8rduWxoCJvcv0KrGDPZiYQBA0G7VmaPk+fVyQAX2SGkG0Bn7e6BzcL8cWiNoaMJG/b+OWrKG+ze681JIParA6h6Z8iM56hlGxc+ExfWnH4lkArRfAgSLOpdLBN4pU2aIO/nks3oXUaxPWfiAu1LkRbzyfUxc/LRm5Z27WVFTZ4p3nk+9IZnrFKJfqaoPI3mWv4ypdMvh26cGo+Rwrtzu3Ebm9AavFbykmdvF2tXyzT+KXtviePnNACXW41qBL0LjXh/VUChVAHSPuJ48PgePAS+svPA97msOZs06MdTNfK268R4onrKTJIP9T38Q2dG0D0d4Fwa7mw540gU33t85aVK8Co819R2/FlcxrL0CrLrzbscYpzU63mhDq27w8jBxyyqfMM2fDexamx5s0p7XeDw8UPr/bBAEG60QA1hV7hXdxSyVWZb6GiheBRRhWVlmnJjZsm0kzwqkG8uE8aInA8Ng5l7lpbzg7FCgUcoI/9WhvgspJyq6RipR7XXD/RAVKQMfH3devx6U/QXABW2SjkDDw0y4x4r6kFIJSxrhf7CSg71Xpu2Hd9UftNmx/JMv1821U8gZ8LCVzEN1EOIxnHN05oxX2TiAtRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(83380400001)(38100700002)(6666004)(1076003)(26005)(8886007)(66946007)(44832011)(86362001)(38350700002)(316002)(4326008)(55016002)(2616005)(956004)(30864003)(52116002)(7696005)(110136005)(54906003)(478600001)(8936002)(8676002)(186003)(7416002)(16526019)(66556008)(66476007)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XSYd2XTFW6IItss7keK6ZpkMquXMOP2oExsMz4YJOtcPSzlup/PBymzukMtY?=
 =?us-ascii?Q?U2pSYbZo2/CYJm+VO+XpcpuAPI8oaNZwFrRMSoV5w7VUSO+BqIL1Qw/TOjdd?=
 =?us-ascii?Q?phy5LV9090m8O2AH1K3nZ0eial5uiSlbMGV8ZSNjeijCfXNlj70fUQQSVcvS?=
 =?us-ascii?Q?gkobRHpzYkQQdiCddVK7+9fl4jLEilOcD2h8tIOaCNhEXYUEuKu518g0V0vY?=
 =?us-ascii?Q?GPg+bFtkfY5CVjTks9Yye93vsR/Vaz7k7qwFs+cY7TJ5bOzbmjSYHgdK4h/S?=
 =?us-ascii?Q?NLQmB1oGPmMhqroCJ1qFI2+jlckjhIRFZNqHVSNL2WOMy7bI6cx0nqJDuNJT?=
 =?us-ascii?Q?QRcRDq1aOTaXlvPU+kVIQ67Yo+VZ+qyTWX6MGx22z88XuzKNqgZPY8zp9nYw?=
 =?us-ascii?Q?LPK7CDYBc9N69hnypRDc3nKnaudBcQ8E01uwVGHGcfHlFfMqDO9x6wJ4qWHH?=
 =?us-ascii?Q?AbyDCdvuyi2s6BFLnyv0UMQ/Ikm5SWcNhVrBa5OQbuzFVQOIXL3oNfkj493e?=
 =?us-ascii?Q?ESqcPyVqCfcevUeXRGDLnK4nWmQGXqKObENtGl0oDCgyE23WKg4l22wrsIks?=
 =?us-ascii?Q?BnV7GxembO91Eb9sqsoy2woggrCtdX5sDjJTU3CyyWofmp26kqLCPOuj3B7U?=
 =?us-ascii?Q?LhkRH+hTdJURftVRJs9En5y2YwUtSl7dH732+a6xqiBf/qf5J1U9eYzStAGY?=
 =?us-ascii?Q?lj/MdywDGAgmTRWdSh3aRqfFwFdni12+H4sO5DCiWoXPq4CrSStnAa9808kV?=
 =?us-ascii?Q?M78Z1wuRKyiPZAlmBRNJUdFUiQa7OEzndpBNDdRFZwgWjLCrTbICw3eVmJ9g?=
 =?us-ascii?Q?iaK46vhVKlFpSzEN6VaNvTaYqlLNL2SHHsqhXwkG/O8r+67SAQiuRpaFOfXO?=
 =?us-ascii?Q?tQzwH/dJzJJj7M+dka0rJtdsx+TpnS/qYFH87OhhBekSfz0MV7GzaPXW5ZcR?=
 =?us-ascii?Q?Un+wvJijfu1pDeeH6EDLuEW5rykPL5heBHkaUkN54K7fqju7XPF1/sNcmQvB?=
 =?us-ascii?Q?cwYAy/tlNn65n+KlXj+TA7zLqbhqsXnRGzT8EfbA9tANjAWTqkYuX172ufWI?=
 =?us-ascii?Q?wX+V+BbmmY8mz/uBq7SJRgqZo5Cepajw37/AibUgXBSTrfCnEPwlXaxLHTvS?=
 =?us-ascii?Q?z+OnoHMttr7S/whT2A+UIb6kWcpAzONn9uCZaOatAsz8q4f5k4l6Qjk8/i65?=
 =?us-ascii?Q?WDZuT9TNtE2eyfrLj7jGNcR0w9+1hKfd+fZB4CZxzCeqvjWTaj0Dm0IFJHiZ?=
 =?us-ascii?Q?C7ZD9hDPLx1vJ+Eurh2zAgoIVO2XNJUKHYUy+7A3Okoit2YZvD9cqaeFXGIa?=
 =?us-ascii?Q?tAwt7NqFf5rX4bsTHyB69WPx?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fb0717-def2-4192-60fb-08d9193521bc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:10:24.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yw60oVDPv+Zq9LvbFC3kYSf8nwOqEbXzrz0aq/ZAJhS9S3uGVIr8Uw902hoc0fv4czLhNmAesBrnuiJdTibHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic power domain related code in PSCI domain driver is largely
independent of PSCI and can be shared with RISC-V SBI domain driver
hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/cpuidle/Kconfig               |   4 +
 drivers/cpuidle/Kconfig.arm           |   1 +
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c | 138 +------------------
 drivers/cpuidle/cpuidle-psci.h        |  15 ++-
 drivers/cpuidle/dt_idle_genpd.c       | 182 ++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.h       |  50 +++++++
 7 files changed, 256 insertions(+), 135 deletions(-)
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
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
index ff2c3f8e4668..3ceec0ee9f02 100644
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
+	pd = dt_pd_alloc(np, psci_dt_parse_state_node);
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
+	dt_pd_free(pd);
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
+	ret = dt_pd_init_topology(np);
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
diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
new file mode 100644
index 000000000000..5a901773db60
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -0,0 +1,182 @@
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
+static int dt_pd_parse_state_nodes(
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
+static int dt_pd_parse_states(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *),
+			struct genpd_power_state **states,
+			int *state_count)
+{
+	int ret;
+
+	/* Parse the domain idle states. */
+	ret = of_genpd_parse_idle_states(np, states, state_count);
+	if (ret)
+		return ret;
+
+	/* Fill out the dt specifics for each found state. */
+	ret = dt_pd_parse_state_nodes(parse_state, *states, *state_count);
+	if (ret)
+		kfree(*states);
+
+	return ret;
+}
+
+static void dt_pd_free_states(struct genpd_power_state *states,
+			      unsigned int state_count)
+{
+	int i;
+
+	for (i = 0; i < state_count; i++)
+		kfree(states[i].data);
+	kfree(states);
+}
+
+void dt_pd_free(struct generic_pm_domain *pd)
+{
+	dt_pd_free_states(pd->states, pd->state_count);
+	kfree(pd->name);
+	kfree(pd);
+}
+EXPORT_SYMBOL_GPL(dt_pd_free);
+
+struct generic_pm_domain *dt_pd_alloc(struct device_node *np,
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
+	ret = dt_pd_parse_states(np, parse_state, &states, &state_count);
+	if (ret)
+		goto free_name;
+
+	pd->free_states = dt_pd_free_states;
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
+EXPORT_SYMBOL_GPL(dt_pd_alloc);
+
+int dt_pd_init_topology(struct device_node *np)
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
+EXPORT_SYMBOL_GPL(dt_pd_init_topology);
+
+struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name)
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
+EXPORT_SYMBOL_GPL(dt_idle_genpd_attach_cpu);
+
+void dt_idle_genpd_detach_cpu(struct device *dev)
+{
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
+	dev_pm_domain_detach(dev, false);
+}
+EXPORT_SYMBOL_GPL(dt_idle_genpd_detach_cpu);
diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
new file mode 100644
index 000000000000..23ebf6050e74
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
+void dt_pd_free(struct generic_pm_domain *pd);
+
+struct generic_pm_domain *dt_pd_alloc(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *));
+
+int dt_pd_init_topology(struct device_node *np);
+
+struct device *dt_idle_genpd_attach_cpu(int cpu, const char *name);
+
+void dt_idle_genpd_detach_cpu(struct device *dev);
+
+#else
+
+static inline void dt_pd_free(struct generic_pm_domain *pd)
+{
+}
+
+static inline struct generic_pm_domain *dt_pd_alloc(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *));
+{
+	return NULL;
+}
+
+static inline int dt_pd_init_topology(struct device_node *np)
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

