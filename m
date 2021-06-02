Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0D398814
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhFBL0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:26:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57037 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhFBL0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633061; x=1654169061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P+lH8HYaQpf6JmSy6Q60yH3+POKmuS4lXQD3C/Bc1jY=;
  b=eIwMmM9Nt//ihN02wbkGiaA+7qdL3QK1B5SYD2vw6x3Z7HD5LzJBxrNQ
   MVEimYk/C+kRJzBX7PVISTfjZKmkdkP6jFi9g+DcKlk6MuYz4MkcwJTPi
   2spPY9bIqny48fYRe35MjlPK5DITmWVdXGIwl4lmw+j68Ono4L0Smf/aF
   3qdKPb6qjzQ01VC2dsR4dE373ULXXPevRatzXu5n9gLQciGlgxTs8mS++
   alNM4Vq77uguU5Ga/b6qFs7gOMxcz+J1oLXORhujG6noGdyPenvYmH8Nf
   a/ZP//RGJ6pOcVrxjgTkxA6ula08beDfxMnBzY7ynTF099R2auDkgJpgu
   g==;
IronPort-SDR: jcwI5o8jCn7++KcPxgFVl+RMgxpMeoGKZEOOYdQuhEA9RCg+3ZwICmNslGguPX1gDnH34ABgC8
 jrhVJCvEYwwr6KsidCFOWjWo7Uw5s53dpo+CNZXSBGPqZDng8ugLeIt7p8PALNILGBzK4v2YLK
 idorBGUIsLqwIoPqjcFDx7oB8flT2aAQPSnXkedEnuBmwpxD/3C/zuKPzxyBRQxdYfcrG/cRwd
 PPceY7Lm5VfDiLq5bl0uFye/aq7UdQ/Rn6KNEwrdb5xifnpzvQvGckMYZPNmv5SADTuhDAShfT
 rdI=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="169699703"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXuVN0vcgpbj3L1CXhqwuMxMK0BEKK3ybKB0WS3kDrRuhzRsBsS6TY0vY3liIAyqIN36054TuQGxv30SKXJlEHGLkOQmm4qr/liF5X0X2tfGpMyAHmYVKA6sJ0pGuM3SirN8pzqO9JaXeo+bbbeO+P+RE58MvGKbljwI6V/HV7uiK1C6Kf1QWJB/A0ZzLbfLGUOHgGyahPKRjPIQkizesA5e+G5V50QKshdDIoUl5N5Ji5X9+s2s9B+xrLF0m6IiecL4JDZ2Y8uQXAXfTeAI+/fSj6Sq6GipCwtriHLxIBRNH2z6SRJZFsh5iUNP6AGY0jxcthVW/ttpulXXfGlUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv41FkETWb7xLjPrP48laqRBR8nIcHoEGq57psI6hvE=;
 b=fYK9zFk6OklNZn4LZECpJWfwBnM7UZoik2wcAPgS5e5FW2ZvjSunA+2zVg/Sgnp9ri8fStz5a/n0zmIXsQO3QPd8XRu33eNrUXpniNAb8r5gBdhjc6GQvJXOrY1jOUfYNdZW/KhBlmbmnBxWnIJVCyghnBhWB3qPM1UhUuYw+Ma/+xpqazpHNDSmndvq+Pm0gzwJERHfQwkscN8K1W/1/OA3+Wckh/yhq1US6GF6eUubId/TEkACNfTwoiJh9RQQ1bEVs0nbDWlaFhqdoCscfACSEA47ZT8ssPS1M7f11Nzl2iVm/A4fN93AzQkXBkYwqpf8hA6zwM4hid3oo2CU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv41FkETWb7xLjPrP48laqRBR8nIcHoEGq57psI6hvE=;
 b=g/1YsvBIIHiNGwGdwsq6Yo/tz7/moeLbBzxFF1xLXdEAIXSRnEgA3aVCVBTPg9Atxuou7//9H8sLiijmx0an1O9gYQMRGlPXN9w2rNd15nFj7Y2MB05KsYqO1cKzXEieCZbFYXRgJtrDFU7W3Qif6V3nPMZ5fa8b2prZ+CG10xw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 11:24:16 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:24:16 +0000
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
Subject: [PATCH v5 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Wed,  2 Jun 2021 16:53:18 +0530
Message-Id: <20210602112321.2241566-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602112321.2241566-1-anup.patel@wdc.com>
References: <20210602112321.2241566-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.70.115]
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c10088-d9cc-491c-c950-08d925b8f4d4
X-MS-TrafficTypeDiagnostic: CO6PR04MB7747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7747F7F6385DFFE509DDAF0B8D3D9@CO6PR04MB7747.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXrhE6W2n1OfRkEQtwxZN2yEXrhdNtSiYbhY1UURxwGlTmMLlW+BbG5U0sffwQdD6KYM9yNPcenVWhsi6L0NFmPaIZ4on1gG5x4mFyiOJ+Bw+cA89BqriDiXXA6NJAGmPIDUsUzjvBbmPZRBtbd4k2u8Zp2+vuHd5MLQ2CQYxtTrqEMV1vdhcWCf1Xe5IG/fQIZKXc4tP/zarnryswXvbAJ5BT8iGBVhoU8DxiJG9OJe31q1HDIa0jZcMcccK1CuqE9DCNaV995UxHGbkJEAXwJCx+9qo1P0qZ96Cu1Ev9b2QlZoI7ROjADUyqw82oamPTiVnQ/ED7pqsNG6SrY4Cjv/L4+0dJiFcd6PGaeUteKlfhSGbK4ZLqkxBI0TjcI7EPXMpauN5ydALqI9tEmKOsDofw6aeOCwcTBJX/ujtbhRlSbb4E73CXQj5tkZ40Lrp666kZpG35hXOxX74a8ivPVH2LSHbRE9xPjA8qbBitgL6zFKZtedLrafJSRI52ZjQOo9KcC6C3ju1l/llAIB4jI8aMzlRv/lRtQq6EhhgFnXKzTD+MlOJmHCuCGRxjVPOOjUZjCSABvkaGMvVAr9fCexP7QAjArEsqOrgGL7v2+SewLLuneGSy7mpyv087Ahg8vW4XGRikm6HljIbDIarw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(52116002)(7696005)(36756003)(8936002)(86362001)(38100700002)(83380400001)(66476007)(30864003)(55016002)(110136005)(316002)(54906003)(26005)(4326008)(956004)(44832011)(1076003)(2616005)(8886007)(478600001)(186003)(16526019)(7416002)(66946007)(5660300002)(8676002)(38350700002)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PBAKnMNJd6QH7jdNVHP1AlxILxFlxymPeMMxZD0X3vGwLIpuNZtQqdX8Oo4Q?=
 =?us-ascii?Q?+tsUS4eYJPCI5Y1Fg4Bigy46HyD2pae0DUCzrydRvib/0ve/oU0apObZ/tS9?=
 =?us-ascii?Q?xpsS6r5WlQjnAxxoUh6qQZ7wzUhP8FF18qOvz9EDuTb97zJVyuXllSDj3mYk?=
 =?us-ascii?Q?Rfpgt4uhSb9WV6OSaDR2WsrGizuuFeADwivnL+T6BU5TAE1HjxVPRTbFosao?=
 =?us-ascii?Q?Hix+la9d6UY4hIZDuNSjPMcql7js6FKbKRqRw1ogmQS9aKCcNnT4gEOQript?=
 =?us-ascii?Q?JU594tMeGlAOOS1Q5p+O0KIAKTeXoiJ7DLh+Lv0piJrCdy6OVfvhbFyTaxxR?=
 =?us-ascii?Q?4I7aGzkH7zXui+psw09jfEnqAQiVVF8VVnh3x8zM3lNe0J4auytcnXvfvaom?=
 =?us-ascii?Q?paCANYidHKIFFCtdEVE8VsEiPxENvx+At1HZxJVrGQ6d4jT2hndj+ABZeMqq?=
 =?us-ascii?Q?9C5LP9dvoqOkOnvR6eqy+HjF1kFODPu0nt1umx92StpIwwNh9bFNgw/RRZfj?=
 =?us-ascii?Q?R5C5SELloySQU/jctAhZJjuWOiJDUtTS+rFdPRG1zUCDxTxKnSVWrbRvkrVH?=
 =?us-ascii?Q?2sE4Ac0q6Oc05cdZ1Obc/UsNeB6eChwXGT5adI+ZqYsw6IHx/r3wvZaH3phG?=
 =?us-ascii?Q?nEf4Nf3S/RMyTXhkMIzqUys/ia2YPGqWvMGQTpoRwatjjaULYWIMylR+I3xD?=
 =?us-ascii?Q?oSi+JxcYnMBlwbov3CCzMWMXo0xPjpp2C6vX88WDPzjpRUZR5y97thSj5XI3?=
 =?us-ascii?Q?G9SZStHabzU1fH7nhOsD9RoH+NucY6rqKIpj5RzeNqJWYpnIdn4qpEZA+YI4?=
 =?us-ascii?Q?YJhpki6GzZTpm9zFDYspHgT7tNtKX9wPyNCzBfbWbFptU+HHj8lscLhyryvM?=
 =?us-ascii?Q?aeMMiM0p6MbgkO3pSbLJL1/0k/CL6Sb2enmzTXlfPzS7jB/dTJcRF778hIVF?=
 =?us-ascii?Q?AdFfHVYIYiGEIkmjujmA5gBoJuNTvp3jdUBozun6cLZp/3xkKSokexwZLlt7?=
 =?us-ascii?Q?QTcpQYIEr9mDPnB5sFj9rSfJRUFOD+RoJGJ8aY/6GrhuDz9jUz9dkunFf8Gr?=
 =?us-ascii?Q?TQDkZwvgt7lbxqRAz+cSYN8NwtzhGetU/qPMVuAfBO1+mfOXyR9mISINIsFR?=
 =?us-ascii?Q?DgMEnMll/ixaQ2q5hID020totLNU5Bu66Ub7vlR/3SKg/PVMUJ4lKOvbF7fj?=
 =?us-ascii?Q?smzcsK/ufiPhqPxvVDfBYqst7MA2QydFl3q04QuVfNcchb4HcGKIp5mIulkf?=
 =?us-ascii?Q?f5XlTHwyoJqCaUaEYUY15oa40LqCch0c0+g93ErE6btsh1iQBUHZptFHxBYl?=
 =?us-ascii?Q?LTcYo6NDGRNfACElOLJuHg5w?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c10088-d9cc-491c-c950-08d925b8f4d4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:24:16.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MkimlnpvCsPvbl0+5kTjBSu+RDDVryfRm2+BPeVgXqTO/5LG0P+UvwwmwKUPYRDJnm8eb+hy9oF86EaRPjXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic power domain related code in PSCI domain driver is largely
independent of PSCI and can be shared with RISC-V SBI domain driver
hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 MAINTAINERS                           |   7 +
 drivers/cpuidle/Kconfig               |   4 +
 drivers/cpuidle/Kconfig.arm           |   1 +
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c | 138 +------------------
 drivers/cpuidle/cpuidle-psci.h        |  15 ++-
 drivers/cpuidle/dt_idle_genpd.c       | 182 ++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.h       |  50 +++++++
 8 files changed, 263 insertions(+), 135 deletions(-)
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 503fd21901f1..aa4bed38b790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4788,6 +4788,13 @@ S:	Supported
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
index 000000000000..18839b0cb140
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
+EXPORT_SYMBOL_GPL(dt_idle_pd_free);
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
+EXPORT_SYMBOL_GPL(dt_idle_pd_alloc);
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
+EXPORT_SYMBOL_GPL(dt_idle_pd_init_topology);
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
+EXPORT_SYMBOL_GPL(dt_idle_attach_cpu);
+
+void dt_idle_detach_cpu(struct device *dev)
+{
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
+	dev_pm_domain_detach(dev, false);
+}
+EXPORT_SYMBOL_GPL(dt_idle_detach_cpu);
diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
new file mode 100644
index 000000000000..a8a3bad3cb7f
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
+			int (*parse_state)(struct device_node *, u32 *));
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

