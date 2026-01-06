Return-Path: <linux-pm+bounces-40286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD7CF77BD
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B58743012663
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4D30FF3B;
	Tue,  6 Jan 2026 09:22:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80930FF33;
	Tue,  6 Jan 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691331; cv=fail; b=NacCbfIVx1ZIHDMCRSd7p6ZKzDD+FJEcgycbgA6Bv/nBPzvN+nZI434vziaSKRyCOz+EQtaUPkL37xcJPKLLIg6a8/XR9+HRGk0LeNyonqEPOxTdQQkyBIXmwIX3cLG+kQ6aqrsotLQVORawG5CQ6WFedkPc5XGStzu3U+L7a9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691331; c=relaxed/simple;
	bh=oP1ovvZL4DTAUFkW23aAIJ6Y0kghiKxJpuRGyO55sJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8MDyvPoq3COb5eVo4r+X7JCk6N20C2kKYiP15M5jW8ln3kt+GUkBKPTto6NtDdJJae+az585naHQjpQNOPyyUHpoeSoljLq1ep+WodWocg/vxn9W/T75wGJf3f3Kk26iQhzKbpevMxnGSeEFFikjR/KFkLhUuRtk+/zmdbkftE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea4rbdu+3DqzE5mq4y2Ksu2VvAU/yp3T7WOrJdZNO8wKg2OD2upBSWNxnRnXQI/Hshmo9aBKdV98LM2/X1huzujlm/FjHsgDAXZ+PgQs8uV8+hRBGMfDJNt8sGiCbbAWyf5MqrSQz7fFYefKUhXUbdDBMDhMONzW8R9nspQy2sxnTnWlP0iNjUPPXyOSagOumsA7cGBqneIbRuZZBvrni4+qkWagYTvNjnjG99kS+Nl7Nr9OEcsBADL//J4ljWZLchoTOyWC1Q9WynBL85+amyMhC1wd8ENQXxEdq6ADHxTuHcWa19Xq4WD/N53pekzxHj07zsa1yeUh6gVwZeVoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riT3ma3FNotfFDXDu4XiwyZfXtI287FI8R03KiFZAOg=;
 b=gGvSCNgZOOehA2ZI5zrsrSp37kr5bEF1TkneqV8jmdmshcJpYtVgMBKqWDhDEnJ6ctxLz3KcStsmxCBIxmEOAKGF+3iz5EjCKUNC77PRrUE7a7gOIeY8xh0YHEVM0RqJlSKTFLRBKKjD6ZbCifETfT6XhahPEMPXb8e4xykdtLh6JIPvw9/z2P5q0J8/feQ2qRGjyt0glxWoRDbQ4y86tFK3CGRDSHm06VyoAFNfgF1AgWlrF71h0dfccf++r8tgmyuB1DStdjplwO4W8dZ245qXDnIikB0obEfEtmIVpKnKUC8nWCLwfoTQnG5TPNygOI494a3DivPnibL69gb2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0730.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 6 Jan
 2026 09:22:01 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Tue, 6 Jan 2026
 09:22:01 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: rahul@summations.net,
	anup@brainfault.org,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	sboyd@kernel.org,
	jms@oss.tenstorrent.com,
	darshan.prajapati@einfochips.com,
	charlie@rivosinc.com,
	dfustini@oss.tenstorrent.com,
	michal.simek@amd.com,
	cyy@cyyself.name,
	jassisinghbrar@gmail.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: firmware: Add RPMI performance service message proxy bindings
Date: Tue,  6 Jan 2026 17:21:12 +0800
Message-ID: <20260106092117.3727152-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a87ed47-4ddf-4ea5-1cc7-08de4d050c0f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	uQu2qLuOzJ7YU9WhgBAYJhiW+jNIueOP1F6fckdUF0Qt1vDGBhPpRk0l+8cerSTI6K0ojdVhZdqHj61r9Vh1dHiSE0UBIsmC436OMjfm+DoQGJSa7cVkevqH3xJM55mXDDjVw11XSj1b7cwRZGl0Zx5+WSt0SgiJ38angqqx7vPTAgJIqKpBmMmf9X1kLxVu665OVk7h9O4p5jRCv833Qj8RgmfkA58RblLprOF9Lu3t5afYbXdHAA3JntVdkpuNHr3oOleSm851BmRzu6KTvFPRcNnIzQ3v7F0rjcGfq/NjgDbDfTr3Xj0zuSoyHPp7apCqGl7UC3w7gOfQl6PzVKpi9QAVLxBEVkkvFe9q7xE3klyFvFvowT7ami6BYF9dsXmjvPLW4cM2zHTWz9CEgfNIF3JQCF6zytcW6/BRs2GSnnRGnAEgwoosqQ8jkXGmWZzloaOOP1y6THW9Dw8zj4gSgkeYBfoMUsp5ZQ2S+0PhjpPhWSpUJjBGqzCoXtqhEisitTQIJnaQWqG+kemUjbsYyZnPkOdcQjgcgr9ESiWP8zV6ObJKZnFoiGBJrY9rmg44yEZSetbBnChc3GRPrHVz7llcFFgveUtK3X65WnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NG94XhRNbcsx/WaQTAIGSpYbL0gJrbmo5gp8KPJme0pBtG8C7pNBtKjHiIqT?=
 =?us-ascii?Q?bzRyX3aYu7pD+mIFpKSvDuL26YwoTelmXFFdqxnWiFFl3z3hQ+z5p5fzkLhl?=
 =?us-ascii?Q?XK2rZBWEPYM2jU+5ar5Xy76Z5Q7grCR6pJk0lpnZ7kgxDtUlwsqNXnUb2goE?=
 =?us-ascii?Q?No85KpvhaCJcEsOO4KYZ2qsrGeYvRBJSZn7uIEv7yC6+hL8tJayfqdQ0gZ2A?=
 =?us-ascii?Q?3fN2dBlyRkqYtGiiaP38R7puxw8dy6p4+7W7kjBYn/F5ocYGsO67AiQNeySo?=
 =?us-ascii?Q?SRkRrN0HAJqmSwNOxRyDYEVnAx2pZnqFN8/WqD4O6i1wuEzs8+lRmFIIUHWf?=
 =?us-ascii?Q?PEFTkKl+JQu3IbBGZnu2ClfRn3faIwU/pSdALA1x/pObhSYdIma+A8WmO/9m?=
 =?us-ascii?Q?dMoanpSG+iAb5dZ+Gq4XPOuajurFtap4qtwDyBfheBlMk77O95hJKbSeMH+c?=
 =?us-ascii?Q?28R41Z5EkPPvCiCKTzYnH9yeLyoYqyJPCmWKHn4F98Eg8yw4PRkhDe6/U4Vq?=
 =?us-ascii?Q?0Jh6E+2GvkeszJ4WoKBYBoKZT9414GU+P8XBAl6m1aXgP7ovseY0HR2acvLc?=
 =?us-ascii?Q?YclXnvPvztarZHJCcDq0uIuDq0tmuPbRQ8krU/Y1oRDVCIxKirVK8luG/AyB?=
 =?us-ascii?Q?Q32Z2IwSOh2NJv86RAYcfdJvtnLNy5vWX1fa5D7zYDhcIYUBQAJfFdYKwdRn?=
 =?us-ascii?Q?GB+etf6mRvOfJZRznD/Gr/WOCQ96vwJXMICf76Ovc4fkl4aSv7CSRHT+Xlg6?=
 =?us-ascii?Q?Becwg+0GkdmlAOEpjDTf4X3SqQ9Nv3cIe8M+6kz6Pylt9fb9tzFractQuyQT?=
 =?us-ascii?Q?xYrhEG02V2TIIyenowdc3HBXHlCusSM73iKEwo826HFbaA8z/AAX+hiOCoyI?=
 =?us-ascii?Q?MLDK3iaT0uH4N8DnmuYfj0OI+FQydJc7qJ7zEk8SEqDKPlZyG/h9VNLS4Gz2?=
 =?us-ascii?Q?dPBSOS3nzT7qJcZBf3tqtakfET/bVe9qaOalaIp9SoB7aHvLMsZxDnmllJSE?=
 =?us-ascii?Q?tWQ/71gqxH5MPeA1mVCYU1Op3na9qyZSmPmhxRt4OUh9vjQ9M5pnkSczhq6F?=
 =?us-ascii?Q?uRa/hlaMdVggo46Y46ESFfagpmw7WbFVhUYwxXlYOKg8SCMEySD9dsWgyiD1?=
 =?us-ascii?Q?+q6Ezsfa83C6z+Tr9htQyt5RH/9VsbIlGUM98prXxujkoT28Ix9/rP6Ug+jo?=
 =?us-ascii?Q?qQPT9euvYh6ql1M7P/VsnGsev4GShiYw0zNsobcXQOm2ESftwMhEdbb0TEqU?=
 =?us-ascii?Q?Nost0txt3wDOjgUQ+IQ9TzB92lh6DRzYsxfFIhaGKdLCvxzz/JWpWa6ZyRhb?=
 =?us-ascii?Q?Uj6S7S6ui04ibv2KHLHcoeuj6hbXhA+KNP7YodFfUnVpriLBCmpGn6uZGblA?=
 =?us-ascii?Q?/mL/QaIk8yPV4PREB6IvK6n1ssbvRv7TtMqDSk4Lr4YX2bS14YIo3gM9JHY9?=
 =?us-ascii?Q?5Ft4lkKLATyfopXZfhJyZ47t7WT0Fjnmw1+YUCL4v6vNDsUXNAfIRdyza2fp?=
 =?us-ascii?Q?wCqF6z5i6aqZaleWEdJKZf1fZVxhnYbQHN/oMq6Rpy5UJP320nzvFOLARYta?=
 =?us-ascii?Q?W6z8y7cRkfT0V1P3z2vkYHZDVUhUwslmzFpoxnVDOkS29vZTN6Wwp93jjES8?=
 =?us-ascii?Q?ldnNQ99ZfjSXWRj2dRyRAd0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a87ed47-4ddf-4ea5-1cc7-08de4d050c0f
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:22:00.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mZJrfpZ4DqFCtE0P3vMqqJ89hjjFHQYaQjvMFIbWPEy3et1QP1VFpw9Wj8LbwgHSfshkpssnAat8YEIe8hSUNv8CUHjCIliCTgRHL+1TKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0730

Add device tree bindings for the RPMI performance service group based
message proxy implemented by the SBI implementation (machine mode
firmware or hypervisor).

The RPMI performance service group is defined by the RISC-V Platform
Management Interface (RPMI) specification.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../firmware/riscv,rpmi-mpxy-performance.yaml | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/riscv,rpmi-mpxy-performance.yaml

diff --git a/Documentation/devicetree/bindings/firmware/riscv,rpmi-mpxy-performance.yaml b/Documentation/devicetree/bindings/firmware/riscv,rpmi-mpxy-performance.yaml
new file mode 100644
index 000000000000..0b97bbff458f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/riscv,rpmi-mpxy-performance.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/riscv,rpmi-mpxy-performance.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI performance service group based message proxy
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a modular and
+  extensible messaging protocol for platform management functions. The supervisor
+  software can send and receive RPMI messages via SBI MPXY extension [2]
+  or via a dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines performance service group (performance
+  domain) for accessing and controlling platform-managed performance-related
+  resources implemented by a platform microcontroller. The SBI implementation
+  (machine mode firmware or hypervisor) can implement an SBI MPXY channel
+  to allow supervisor software to access the RPMI performance service group.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-clock
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    performance {
+        compatible = "riscv,rpmi-mpxy-performance";
+        mboxes = <&rpmi_shmem_mbox 0x0a>;
+        riscv,sbi-mpxy-channel-id = <0x1001>;
+    };
+...
-- 
2.43.0


