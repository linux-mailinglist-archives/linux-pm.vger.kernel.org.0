Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8483C382CED
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhEQNLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:11:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59438 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhEQNLC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621256985; x=1652792985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qMoC26aE1t/imsmMoQjUxEhGnzi1b1hiqgTM5NyeOBU=;
  b=IR+daVCXf5NrYfgfRId4AIFecmkRwbiOpBRPDAD49Euk0GoMgNZDhQ1J
   BQjMV1qIjaFxwaBNjlt9QFn3mQriNlY8sm8zrsfGGKlGMkfZNA6zqbc04
   7tmCb3vyPKsM4RlJSMUZJAsWxLRyvO08PhqMixMGX1gMNYWIv0WF7CWnm
   N76r8XVhvQZJyHuAs6dmUzrWL9vzEUI/rrpgqBBwfYHj/8wrh5FbI4bjs
   bOK6BZ06QQxSLCS5xYHf36CrAdm8TQSBuQ+raauatZ+0azfV3hxKXwKi4
   ZfrRYGvrQQzKU+yUyGyX3ULHz9+GWZmiqnpfC6Jwhk5ByXGGeJA99Vw3U
   Q==;
IronPort-SDR: kHIDTtIGNac6tukh+OnZLiAVIZf/6MZevu4TUAvzxlvX+azH9KBrjyv9qeOZZfYSgYOEfzZvrf
 vCKgkinlXv4iA+o9NldsLeJO9aCM0dTSn535qELBIA/tpR6SQM7FHmEdAPnnh9f3qOLTwsulab
 hV9gMo5jWaZ12f6p1axvw1ZjJP8DmC+QPda623XNQ+CIB2zGFO3h9zUo7rkPOFPN3z9HNoVVY6
 QWqsPl/VTiImRXPXy+l7z2AJC+b4wYKPcFoA+r8O1MMYaABKGrK6f8pDNJlABvPYsEDOV4gBHg
 8nc=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="167757123"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:09:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4vwg/sgPy/0WuzSVJtu9HS1t1NIjP1a4D1D89Nuc1AKQ6W4ZWdtya+ZSv3/K1U3OXt67hcQ2BOTNKM9uoTjklZMG33pVWnXEA4Bao56Z6KeRpbpmgK6rcxI2R1CLfmuCemuE1eZyzh/1y5QIipznk+PTVtfpS6n1DBGF0aMhSBBiGNW3I9WlKsVJyDvCL2rRKFC1X9XLUs+Aap7nPs1iRVK1Ppe68Z9FNv3GNEwiQQ38ESfjPCUwJ5asv9xcJvvMhsKA9Ex/7ukBGCJXnBkYBZcO5pA7nk79oK3EhmTbvzmIRtsIBXscn1YIxZSuFQGwSven+oFoeeYKCsVg9uVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=a7Z1oXsUZY6M9UVauXWvogkT7EzkJaELp754rbe9HqYFdiL/2a0En6ACylNMJVAT0QpK++a7xD9NRA9p6bobea7ZUdI7COPHQAMWUJaDSdHkcjHILArwWbn4V+yih2xseOcnHSSpMAeCX8RtQ/pJ0EDiCdeLeCZ/jC5ziQzY5duVa9RRG5HT/4nP6kuguCB1aRiWhkYmwHHAVP8UMa0KtLKrdEsLyh3EZ/NdvMC8GpCEja9rkcHRlywgDmUeZM4QwDxqxjaAX7OG95IwdZxsXgThYXox3EeG13DoE3/hSHSm0gKIilk0UGIocLKeux93dUvDe8QEiT0dt5St3+abFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=Uk13wtcSWWyFrhnR9ETG5UAYZL7OuO1UaB/ePq0+COsWvXBZmGgVRSs/j5yAJtU9N3Iihz8WyXUeIgBPMM/v+vsqlZAgeZP0cdp4Ir2Ux867PBBySO6MXOZmPhPM91nsXoCP3ReskV4tw3EZcaFLcZkVMWhYJADRINsLzDkBpg4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:09:41 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:09:41 +0000
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
Subject: [RFC PATCH v4 2/8] RISC-V: Rename relocate() and make it global
Date:   Mon, 17 May 2021 18:38:17 +0530
Message-Id: <20210517130823.796963-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:09:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b08c30-3463-4ffc-6519-08d91935084f
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB777896B6DCEBFF24F04AE68A8D2D9@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijAKrR/gXpiwkTveWZ6X1xtGPJ0pk61CJMXTlD6n0hj4WTke5YDr90SCsvL/TudCL16KK2IhogIaXps3pB15oHbIy79d/ezIng22aUvg7Mb9/QqdF6gZcZpPimH+cbuybQ6TVpKwxrQ2Dw37AXpguQUF4Zh0kMIyMfEvGKEdW9/X+xpscOX2yW9keB+9pZTznxn3hbK0z9TeOe7nALeWMOpSKrlC8FWSWPNDA5XukZb2NMFa7GbwUwyWRzCitUvHWKqgp10eHNmvrSgmp41lINzbZnVb4QtRhx2jrP8gRb1xLQ5vD3EWgorZm67OuzfG3oS2yoTobZCEy74/v768UeN1UP9T9/f46TkY4zrqcggouF3y7qKs5I7VQQS0/MpSD0orm2fSy/hfi8E+Ej6vlIYzmnnBLMnXr0Kp+Z/oRbwJJbjCRyz1G8eKxQbL9b7U6Kn5gH0fuPza2o++/bPPKNb3hn8+jd7s21f5yFSXJWtBy3mZIPLQgF1TmevC3sfPlIEk0bf2/hznx9e6jgQu08vksi6nL9Zg+zMELdRmQTGKi6ZpVVGSBquR6QoJUV81X3sRDP4Hcn8PwcTAcFhk8fyCC8I2jq5vmU4cAcJfR24Nt6yil7AHIxfcwXyBEZtPVU9Qan4rMQA1VY6cmzfkBLPHT9TbWPM69OIwfYzZvNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(83380400001)(38100700002)(6666004)(1076003)(26005)(8886007)(66946007)(44832011)(86362001)(38350700002)(316002)(4326008)(55016002)(2616005)(956004)(52116002)(7696005)(110136005)(54906003)(478600001)(8936002)(8676002)(186003)(7416002)(16526019)(66556008)(66476007)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L0CeysElzwAiKFFsOItXgi1WmIv1R+A6hz6qL4X1ibdGUTOfmn4wZCaSR3Og?=
 =?us-ascii?Q?qDheGt1kuwVrHdKNS1Mv6cmMCX614QdvDiHbBr3G377CnuknX0e36esAn2Hd?=
 =?us-ascii?Q?P0QodzQXHIdUXDUJGFCtrIPuLTk8h5cbxTy6nFRKCNczylju1utwjmpnJMnI?=
 =?us-ascii?Q?8DxI5+sPWSaldGiqlpNDoL0W3vgvzKZwwTRSvVs/cbuxJysimdeyytgb5asm?=
 =?us-ascii?Q?xC14VC3C+vw1s3t9ExPSbZAa8SvrRA8P54x2NrO7S72oVmkodrsnuYJ+RaXz?=
 =?us-ascii?Q?iV7qeVRhq1fxPoqQaHxLKVmSFtL27M4MdyI5c0ychSmtCtN8tmdmC7H5VJjR?=
 =?us-ascii?Q?YyDR+g2aTVyQbxdvuI/FhwWZvb/it3Ts87R03tky9zbYr4auHcDYey66yQjk?=
 =?us-ascii?Q?eCuIN5yrp2e4KtHLaNU4fTMCCNTVLLnngyG4BH/MfaWtQmMz4hR+qYjfMr4z?=
 =?us-ascii?Q?BFDtw7elA6+HF1t+4HWS720AhSzvHE/ygSTV+8BnANXNjJl6tQx4A2ngboT8?=
 =?us-ascii?Q?EB1d07TR2AmocO6bKPd+BK/fRPcAetbafUWAgAX0l0VIuAgd5W4/MZzxTRgQ?=
 =?us-ascii?Q?95d5eEuIqj4QeZET/B1Il29bfBVmzGRYtJtNymKaDp8Mg6rwu00BUdXcWWdK?=
 =?us-ascii?Q?gYZOOf3uqEnhxguqeLUX+xnsPDOe9WayXy/U2PCgWpMDx+uKacBa0j8d9DWP?=
 =?us-ascii?Q?h0wFr/ZBiyfR8dW0+YpgGe1gOc4P/Gls/qkci7nApLhiedvepPCRG+Y7x6WU?=
 =?us-ascii?Q?F2R0uss/qRBwgQgarotXBKe1VKYtsrxKMyEJEpjk22iZ/0+fgWki0EkHLdkB?=
 =?us-ascii?Q?h0P1LZ6KU219dTDEpCb47f0Hu0qjaTp8WgTXgoYMv2VKVpdOr0lifdifxNto?=
 =?us-ascii?Q?zRgX3U6aZ28mQqoU1AM0I8c6ue0W4bR21IbywgEy4Rro03Pw3pLiNAwuEN7T?=
 =?us-ascii?Q?1QxC8BvwREDEUC84l//iJ2aEmXIFxXao08d6BH5VEzr4TbE/S7G+8QCmSMEx?=
 =?us-ascii?Q?5hjQIOZZ0mhQqqdAp7pr03AlE/n1QA19z5ipxNqyCaZA0aSla2nakKKEkj27?=
 =?us-ascii?Q?YtmGOim3g/fwukUdEEvB6ZiRzuUEfxceyqdSRlRE5kjMdW2On+6w9vUa7Mll?=
 =?us-ascii?Q?2Ro/UsP/XqyM8LvQ+xIPd/kmDVfb6awWOJceOIXn0oYSpZKMcmQb2xtknfLI?=
 =?us-ascii?Q?mrno8OzpgiGZolTwa50vN/wolabWPR+FI+VQLELzPnOjQ7XXnqxBbaZ7GMz0?=
 =?us-ascii?Q?fAgqlIvJg9/GCP+rM13kAa7rj3xCcZ69Fl1bhcbqeLQaWqBPuQLQflqAyvK5?=
 =?us-ascii?Q?Opom7VRxVAKm0qQ2OfRFh2ZF?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b08c30-3463-4ffc-6519-08d91935084f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:09:41.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2D8RI4graMwz/FyhxLdODKVIp7em+6KE3nQ0UUOzzXAOfP12Sg1Evf18g+f2K7y180Knd4KTNt3bUO5Mf3oAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The low-level relocate() function enables mmu and relocates
execution to link-time addresses. We rename relocate() function
to relocate_enable_mmu() function which is more informative.

Also, the relocate_enable_mmu() function will be used in the
resume path when a CPU wakes-up from a non-retentive suspend
so we make it global symbol.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/head.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 89cc58ab52b4..a44c0bc9c2f3 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -79,7 +79,8 @@ pe_head_start:
 
 .align 2
 #ifdef CONFIG_MMU
-relocate:
+	.global relocate_enable_mmu
+relocate_enable_mmu:
 	/* Relocate return address */
 	la a1, kernel_virt_addr
 	XIP_FIXUP_OFFSET a1
@@ -174,7 +175,7 @@ secondary_start_common:
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif
 	call setup_trap_vector
 	tail smp_callin
@@ -311,7 +312,7 @@ clear_bss_done:
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif /* CONFIG_MMU */
 
 	call setup_trap_vector
-- 
2.25.1

