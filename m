Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC3382D04
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhEQNMj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:12:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64954 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhEQNM2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621257070; x=1652793070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1uLrgPfppmFH2vM6/L/JqMHBvAu4tkt7ZHOK+EuhRKU=;
  b=Qcf28jcROccMbQD4xG0pqHeY7PR1edE/3Ru2F88kxBZ55QKGZp8GgTA6
   cvxx8wQx8z/rrS6sJQ/tZWfEoizScUZEhJUBFaX8LzSnbaekwWmtJJJrA
   mL6YFD7XjjJXtcWHlx1rKnDgXeUGfBqyl9te387wxDhg+NSOExLpT7g2O
   Xc3VxtBQSMtFGJPDe8R8IJA/xphh79qA1h7ZC1upCHD85TpODjh8yTEhv
   VtCU0BGKcnMnOwYdghizYGSF/Gb6R0H8EVJOK62zgymwAQsIevGzP2lQh
   tamiD0obrTtSfk6cArSEVLpjunTvOC3wyR4a+eLLCHtSoDjsZr4udUiRj
   A==;
IronPort-SDR: r3ApJRUivDBz+wMnRIIUAOZU5euVJLI6NCF/+8iQxo0yN9/T2ct0Wdw1B/QXsy/IYFBwOH8qzR
 b9JAa1FHmcIxOzKt2mNGnt1co9aeIe+DE/P253Yfj4+S45v+BsefKACOy+c/sIVPTfW20AegUx
 ZJ7bGfPOzquV0bWi3/GBdOOaEguRI4uv2caWyobSiNxhcRvrmazT8GRH5PriJ2LLOAs6C0WInB
 pYpURYC2xmUzbwnL7j4dBo+FhXdNn5qIajUHGkRx3X3GS54mwk6dfDzcD31Sk7vMEsG82tgxzv
 1h0=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="168450205"
Received: from mail-dm6nam08lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:11:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMWoFXxzpqpqHXHpDKRD3BURh87R0KhuR9Ck00jKZLp9ixJFKtkzJdjHRHnUU4R54QyyfMlWAII5py3De2sL4aarikQtAP1s8MiH3vl+uIb/3YAIwRE5SiiGHIJFcMCrNAfbiHj9u5Gofzk2NgaCYZodu7hUuI9Oukmnh67W17WHE0a0j3fJN8ABIgK89lq68wHb0hCOqFdO47v5JiQm+yLBSCxCt7nyVqur0T3SzzLRfU47xTTt6w/bnncWmTklboQpaiyrQUXWP9XJQo2JJMgRJRZthEFkoWMdJ6eBka5I3i1YlDO+Esfee78oo0EFIRcddUHsGS5sgp2jChKckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rip7XFR0BFk/jcVrblzy2OjHhUZycRZYHU6/NmyDcb8=;
 b=IWu4y8r9yNIaqO2F5z2tAJ2AOWr211rIujuza1p74wO4w44q+2oUUH6ymN8cJ4EP5GWEmE7AhHbg2nqH+HaigEj8EawM6E/KVTNmq+pj1LQiAg6N7OMCh+YEBuHTZyN7byEovi5zlmceV3UnN7VKYfyQ9L+EznUTiUMzKSU2HmeX4TA/jqTBBhr/YtAs2ct1LLt4xkPM6WTh0AFoXXhguaMWYGiz84S6AgFNcmYxcdFJ0oAoUqJwBvreCskvLxxNX+BbDkDDalAnIkXAGHIX4H/q3uRHU1nIc+9RHQq72wsJDFzx2Sc1PjePG//RsEh3ZhBVVCqzHOaE/4qaWwCRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rip7XFR0BFk/jcVrblzy2OjHhUZycRZYHU6/NmyDcb8=;
 b=ZZqJ7gPbYsgEwYivMTHG1H7Ur+AQ9o881RybsoaSW5Oi6XjdLuGL9yiCrff6nMZ9S6RfPEb19MF6sv/JwCAwTLSV22KE91H5shn1SNPGSUvimTFHCkpi5cYuJEVCxz4b2uod18Tbqp6534EPZM2wG07r/slx0f1/TUdfz4TVagE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7875.namprd04.prod.outlook.com (2603:10b6:303:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:11:08 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:11:08 +0000
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
Subject: [RFC PATCH v4 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Mon, 17 May 2021 18:38:23 +0530
Message-Id: <20210517130823.796963-9-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:10:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1824654c-d81f-4e81-437a-08d919353c42
X-MS-TrafficTypeDiagnostic: CO6PR04MB7875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78750AB998CF6525A62822B68D2D9@CO6PR04MB7875.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoHKaSn4sPUUi1qmd2Yd+VpYX41PhCn9CYsIt0CNOcPRTgrLdCY0UhmjiNIgH6tWQSrupMVaF6U7LH7abDmAdUSF70rbhbhxvxRexUHCIhNRlkrZVFqTPkln+aFzZ40RA5MV2Jw0fbSODFcXl7hH7BO3HckC4OoiZ+67f3sVpIqyZD8vq1AphzH5L7pmahnt/AiBSlIRmYPTLu2BAfhJ6WG6+bLC88KxIY522XGHEj7gBXJ+0siI0zUEEYRbEp6w9s4pigsfYkUqN0FfB2T5j6E+aXSd1J0ucG8TNi2weg9s9n5jC1Co76lB1VnvcoV9XbPlJjh1MeX9XZuvErkoFjzJElnTVjJstYyRmRy1ztH9pmA2QKpRHuSyf7x4H/8kl0UvXnme2N81KHmLrO41azx79v/rzAf8EYsgOECADBNNYSxrcIhawLp1nqmDHjIbn4QM8WaePpr69mCP+u2r1C45dKh2pFIVm8nwlF5GEZQLlZgcU0wUB+VSv4c0gm75i8CBbCU1D++APw1BdqBNKKGQgm7tnM/p7C5a+ge4oNezBbo/PNz7dQMdqxQDBajtZT/QLJtL86uT4beWb2hMyD9PVpdbCXpL9W8v6S2TEEhbqYZAeXF7MgEnTcs7gM3gzKVru/x1ACztX0AQSFc7wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39850400004)(110136005)(44832011)(4326008)(66556008)(66946007)(956004)(55016002)(54906003)(316002)(8886007)(7416002)(186003)(7696005)(8936002)(26005)(478600001)(52116002)(86362001)(2616005)(8676002)(6666004)(38100700002)(38350700002)(2906002)(5660300002)(36756003)(1076003)(66476007)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yw2tRjt1GUgB42pw0YSpGLQ1WTIHj7NC0fJ5fJCJSnzUusQaP7WfRKFQdX6X?=
 =?us-ascii?Q?itR1e/coyh6X/br/ZMK+0ljkh7RV8a9t3iKxXNSL79LCEiaGH7U1MMUZasom?=
 =?us-ascii?Q?hCzzFyFBQjdsoiTEqbcVkrOnC9Nv0LXmpFmbMEREdWyMs4xWxCJx3xasgucs?=
 =?us-ascii?Q?3pC42yIGZObc7AYlJllky/FmVOEkXaLUjot3Ki3L7jo9+Zh56qvSlBMHUo85?=
 =?us-ascii?Q?YM4MEDxoC7SV4JmFAyT+PewVztEepJX0Nno3OycykiCgNiiTwx+lZXZSLO7W?=
 =?us-ascii?Q?J5Uc0hMPxwHWm/rM0oxFSWZe5G0Aqf4klCvNxxL+wkuXrzKwRnShc71YTL7B?=
 =?us-ascii?Q?6M9L6LV7aDtkg/McejjAu3QUg4WrZL/cnJLLo74dlMhB1YilBUp9cun7qPCS?=
 =?us-ascii?Q?5Jn4tEIA8i/M2prqfck/iZ+G4TifqMljCQX4z/22U4oYgJntdXR11q9xeY2Y?=
 =?us-ascii?Q?11NujDGXgXeBwC0tVk3wq1q10+pjhMRpMGvbpPUAgNPP24rYdJSaizi47r/o?=
 =?us-ascii?Q?d4utP/doNp6GormdVRTmw6MVHvfZEIjRY6tgyOBZn+f38oe0RDNg0501Ntis?=
 =?us-ascii?Q?R5z6Ld2dW9dy304f5peLXlFFIjcgF77r0+iAvdZI+W7OpabuN2if+zanlkd4?=
 =?us-ascii?Q?nZqvh8piXr8/ERuYZggXyDF5K4ld5LT4Ngzy3K/bHAmex1jUSmW0fUTHLran?=
 =?us-ascii?Q?Bax4IwfsxtNCNCCYzHTwdxNxeU2lXiMCvs7o1Q/ACul+tnFnC28cqM9Q9gPs?=
 =?us-ascii?Q?u8JbLCpYEW+L2Bp9iPAX1OTa6cAd43xqKr63jVdThxkoiOQNEq+ziFokJItq?=
 =?us-ascii?Q?pB3KNx6E970fqaFtBnVslGOv4F4lPAXtM4ZdVAqz4Hrzd4NRJ5vFe0vP60B6?=
 =?us-ascii?Q?akG0LNKoaDp56EA7PI56F9Agis00NioLzpNQJz7HsUqObnLhxjjy+fuxwi8+?=
 =?us-ascii?Q?mrMV+/0tMSqNYgJu6NDh9TabSN6jsJxfOH/gtJVIiul/zC9n2/BoFZD3J8eO?=
 =?us-ascii?Q?ambUjxH8QAJDepUgbFMhKi+zRY6ixMRQLIwO8qEQf6XvxH3n9gStCu/bst4T?=
 =?us-ascii?Q?OzaBU0ig8ladFrYsgTcqr7MGY1IBO0l1UTaoguUoW+CKq76AfcPp4BFcDSH9?=
 =?us-ascii?Q?XgJFw0YLBTdhp8fU+F0eSLv5WfRmTYRFXprcDJF2rTpwI0jibPbEGMgWVKgf?=
 =?us-ascii?Q?1bYMpBh5NaflCmbGvNTRDTeOVIcmu3RodkLXsLWblRiGxAdoKk6e1qP2BPAc?=
 =?us-ascii?Q?eJbL7NZM6uBJCfR2qLGf1sZjiRPPWbhMsTiT4LhSPr3o1j5kfb7fy9qNQkY7?=
 =?us-ascii?Q?awRJ1UidiLGh1x9VaQMvrRJB?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1824654c-d81f-4e81-437a-08d919353c42
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:11:08.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFvYWe8TfmCBfcDo9Khyi8nf8JMzQCgA70P2r1VzIhOraftn9egcw3DkEyAUmjcWDTcgzgrpOYFxuNhOipuDrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7875
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We enable RISC-V SBI CPU Idle driver for QEMU virt machine to test
SBI HSM Supend on QEMU.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig.socs           | 3 +++
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index ed963761fbd2..3ae937121a77 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -27,6 +27,9 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RISCV_SBI_CPUIDLE if CPU_IDLE
 	help
 	  This enables support for QEMU Virt Machine.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 57a24d40d43f..ed71f125cbc9 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 97d899df2445..0088d6989332 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
-- 
2.25.1

