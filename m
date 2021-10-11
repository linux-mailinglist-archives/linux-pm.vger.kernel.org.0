Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE969428896
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhJKIXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:23:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31251 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbhJKIVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940360; x=1665476360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fuK+IvONLndof2kA2rtl/79+s8TSXcGfp6BXnqArj5M=;
  b=ZVHJQ5aPlIkSwrH0uPyYMTxSqPgFODk/99ZmzQXjc6nsFL+B9GNqmsc0
   2JWS1NQp9lV83Hp+TJvZXjBKsh9B+lUpI+08bBgLRFEcc84h9KRygFztx
   feKxG2b2iW+Vy9/7kU5pgmlYNu1DKugSthHzvmB84fkID/0RihVyCI1u5
   EQR5KsYlsl+jE5QDkRVv0J7fIsxlzgxkqs4w+dWmhcUlIwdipl2L2oFCy
   qZzGAIF7t0dJBonDc0djP/ASMBjelXvGVdpW1bxJB+3xS3NdOaD6i2l8l
   wnGlFcANKP7ef1799TbXl8ppwCCcXVgCJ+t6inlDdSr4NqHh8vjSNvnN9
   w==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="182476434"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:19:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTFPFmjnoKUD9zKwmmRf8b3e8R1zQUTy7fv0Vf0LIe/CfAlHulq9yhrHnIBVNhLhBgOvFEBMsqEClvvcAMR5l6URzOOWP3HDOkevQQRyMICBlQNjAKPrD2ClRpC7Z0opYfn9QdhI2+/Oj6ogjumUoQ3Xb6ThivTDmCO5PTMSn3mmHSRbdQUeLcy0gm8w+VDqT1032vPkU5ldwXPlxzCzp8u2XB2RL4ZG5D7A4TqRFrZihO/1qRyYmIYzeMyKfMGL0qI3UEXcDbQ6Wq2knFalJunl8MHSBNGtTjNquqjCOyo6ttnWNgrJ/e/tB96wkmUCNL1uqbmc+E5ScNwGOoK5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi+OYHHYMvNP9J+RVxY4cYh3uE9qh93i1ms8BbY+bns=;
 b=VTnRSJd1Qi+jEp3MwX2h+6vIDFTFzJkmbH93q8cJ+vG47f60SEqoSFBOqLCEstyiFUul79yQQuzFr+3GvWo8S+xU2+EG68b2HErGWIyYS3ioZfaTuUFskjKpDrRtckb2B5wDyqHLYKQ0FThboDT/2DW8lQhmgNJzPxO2/akN+DaYqVOIcviPcO3tj2WRZNtkkWjQezYOmhjj3rzVQfea5RSb76U2M59umIvr5xXaSzgE52Pz60B80dxC6GX/z3HDCyVlIgPSIyBqsFAMdWXLRhxvp0uy+1A/9hOeLoy7+pAcV0hxuHWXCl7vQHJahUUbJ1mALdcSM5zYTdBvFFh+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi+OYHHYMvNP9J+RVxY4cYh3uE9qh93i1ms8BbY+bns=;
 b=NgF0UpwTFkYwqNSlq/ObZgOKcSMtg+m3sLmwin9gl5A3eelCwPDD+rdhh518VOERcW5Kn9L1ftI/kfqQt6/ug/BdAhlac6T13oPAif6m1DxgPqelNiRol0hW+ig9Zfwx/oojlO5D3TibAjwmwMlN8EpIJ42bxdGIUqEA3u0/3aE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO1PR04MB8236.namprd04.prod.outlook.com (2603:10b6:303:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 08:19:14 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:19:14 +0000
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
Subject: [PATCH v8 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Mon, 11 Oct 2021 13:48:17 +0530
Message-Id: <20211011081820.1135261-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:19:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09e310f5-4993-4459-6faa-08d98c8fcf83
X-MS-TrafficTypeDiagnostic: CO1PR04MB8236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR04MB8236543C1A422AD01ECB6C948DB59@CO1PR04MB8236.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPEgHlr75fzIMyS7UzfravrdoeD84POBan0H8QjSDUW7pfLt/DmAjaAztDWNt/eBWEU+jXHfCh66plVa3M/z5r69zrp86GF7BWsLS3U6Y1n50i8ZwUXfYmvPGTXvGjBubYfvLkwkkXp1+tnZuVX24fYPUB/DVTpo/sVLHh7qySisfZjXdb+eo9QnKkNgKcly9mX+28S9mIRh8TPK809rRzFVW3xcVCy+J3aPBtPfAsxT5JkXAC4Sl9YW/uHLFfSoToFMKcR4NNsk5LOETDmiivdiRAAsK6t//un5XY8SY5D4jQX/WNz17r2kkC5b0plZS6w6tyorBnoopYR7OyONpKB9uRvfnbi+Y/k8L06ORMs6fdCm2g9rcyvUt3GcV+a9PR+D7SQQeVMAr/BSmaTCFYgpGQbREsZmz5EcYVp5UIL9ByKMaScfl2lpsuqU/kQ3/HoCBd7zCdupuWOWd77/8kQ9sWbkY5glHrrAmP4XPlhjeWv36U4k8C5P2mOpf0b1FYh/0IuHlcAEamQ5+g6XCIqlo1AgJIxSFgFvYEqn/56SJ3ftfnEm+ckQqlzfdNoWu5q9GIvxhGz/uzLljDJf/GcDLCe9igghFL8D8mE1FrasNjYl2GAAXMxC7gszExVOLKBlhTu/CttsbfTh1gicr4rzaAJxoenawCJQzYyltcd+YNUbk2grJIkvWotTCR50bysHxTuF13mqDVurWBhefQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(54906003)(26005)(7696005)(86362001)(8936002)(52116002)(36756003)(38350700002)(38100700002)(30864003)(316002)(2906002)(1076003)(4326008)(956004)(186003)(508600001)(66476007)(66946007)(8886007)(8676002)(55016002)(66556008)(83380400001)(2616005)(7416002)(5660300002)(6666004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWkiN8/3e8M9Z44LUeOWg3DUyv8lLrQcAAMedLah5IgZkjKstwAzAUgjswms?=
 =?us-ascii?Q?8L2gMSWJysHKhqBJ4EgcWIOTy6ZM9bsBDSlbNTgBBNNRC5VSryrdYD2IEp3Y?=
 =?us-ascii?Q?MgFhHc2mC4ztd6BjcsWNlSqbT4Ct90YPzih39iA3ZaytaGT0R4yKxhaumo9T?=
 =?us-ascii?Q?eRZq+7JQ6XvbGxFi/jI+s2SZ6by0LMaLbuNhqcr/y654cQ9GfpBPX6sR+xQL?=
 =?us-ascii?Q?Qf7nym4bgDjamLBLBp8tIpJtyd6U92C+fpfLgNCmIxXMKFVb3DjeCQ+F0D+m?=
 =?us-ascii?Q?kwohJYA4pCumo95wGvSGRDYgkRpx0H4cRoxezpmWfmvFsPBA1lFxuQxS2F4Z?=
 =?us-ascii?Q?72IFpafoebPmfDDTy07giFB5d8a3gLIif0rEN2zBBrKZW81w2vjIS7En9Awr?=
 =?us-ascii?Q?hUf2JdsoxbqFuMYNFgl9N9cfYGa5zdGcBKvL/iTWz10UDw7x2oUKdQzWidMo?=
 =?us-ascii?Q?sg2IAMRZxOgWgemrPKhK3vhOGP6uotxuziX74XKu3/heYAOyAmt/J3Aeq5gs?=
 =?us-ascii?Q?/UWMaURpQW9QRj5OCnWGq8HH0429yTuYSuTfQQ6EHPFm1N4bX7/WkiaiNEX4?=
 =?us-ascii?Q?UmtkpA/C67whRHQZEywLg2AzQh/9SipTAF6NtKGjI4b7f4elCozrG0sEUt5y?=
 =?us-ascii?Q?mERW1+Kro5iC/X0IP2vCM7s0p8G7Pb+Qx01bD5oJjBvANZQb+04b7D3n0xFf?=
 =?us-ascii?Q?fnbTti5T/riO4PPEDlRhUmzNr1dOXEABLjhsKsvhW+nIjMnf3Aj4T8aN8RHh?=
 =?us-ascii?Q?P2CEK/Pdzh3/lrdQ5CGr/e+kXrDAUgPtAFF5VmC1U1xnTQMFJnCIer5Uu3Z1?=
 =?us-ascii?Q?R7cjSaaMY+1MuYzIQRyqpbaKu9vFEeY86AyYuiR6/deGa7VghRt0Hip8gCf1?=
 =?us-ascii?Q?jon7Knz7PZMO8hcoIbUppCgpT2BlV7O2dOhKVY4rDi1A7+13Tg1I9j8s7IhJ?=
 =?us-ascii?Q?p0MeGHjVEG94vT3d0fvLP8sUs1KFeLIyV0uLT1T4Lf8DdUqg1zHHXnr/8ryU?=
 =?us-ascii?Q?Sta/cCMUblLVfC5GQVKNFi3xDOgB03+8ELuBSgEUYQj26iYxfyC0JJFjWkOe?=
 =?us-ascii?Q?+oGIJgzMt5cj9xuogPvC1xqgCwlZxzAAIckdjY65Iw/EYOSltSaNv966PbEB?=
 =?us-ascii?Q?OFI36rijYypIHep5sxiTlEzjY0bjboLkB7IO5+K0GtP+rJ8bWX+3RX0gC518?=
 =?us-ascii?Q?8mKYQ3tZ8gSlKonYW2B2ntisYZo/RTp8Q9JaoIxhuhRAWsEV8eskJbTNGoE4?=
 =?us-ascii?Q?Vj+z6GMOi042ZXVJ3z5mOfua+/DJeeSkTQZolNPo3dVmAr+h4QqJleXsCIcI?=
 =?us-ascii?Q?sSuNhWnS6pYU3y6IXvKXLMds?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e310f5-4993-4459-6faa-08d98c8fcf83
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:19:14.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIfZMF0PBh4XXG7a+oUx9K+/xOW94yhk+7nhlqPiWN/BSnHG3nqB/6pMX1GGLxr3yp2mC9bMEbujaPVZHmwHMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8236
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
index 4ccf3bce5c23..e42c17f9a316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4904,6 +4904,13 @@ S:	Supported
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

