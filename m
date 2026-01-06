Return-Path: <linux-pm+bounces-40287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0291BCF7880
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB805314E096
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E624311C19;
	Tue,  6 Jan 2026 09:22:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76A30C359;
	Tue,  6 Jan 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691346; cv=fail; b=olhdWW9tUMMXoV9sXsk1UNXmlgPoPPPvrHHsy3Ljvhmzv5Yqyni4N2RYcgAlOy/mCyrko/iGz0X5wxBHjRfOk+hhXo1jIPn1Z3MTxBlakX5TEfixDBz2pioZYLhmHF8DdpTlB1oqmc1voiunBcVAfrS34kgcz6UHv+n4OG0b1CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691346; c=relaxed/simple;
	bh=09BYvLzlTMpTyxUv76H25kfdzvoNYhr/4GiqhQooU28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZpWX/uxrfk9i7SVRjvRxhHaiwvkSE3GjOnNXfGGnmgJLIMWpPuTKuZZcJUtWVgPzTbRgRgsRY9zuc23arNqaYzH9sCAsI11NsrZ9vdSrO7kB7KwcqzKocsLELDvgZyh+woRySKT5cQdFI23Anol8dI87hqWuQD4emjGSdsRJVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvWTcI2tskjfvt0SzI2zrzzWeIr2fIS0kPnpEVxReNRsWcow/M3V6/oRJiX5RXaB16CJ/EwTHTZMFUso9s9fQKV/KqHE5HaIvf3pyDVHTLawSCuhYx7+M5A4UeGZyvRkljvcpP0g4cOZdlXTcnIKSYx9zNGXy4tBBJ/7K7yWWKSz7hE+zgITzybX8WP5mn7ydX4oQbUe6mY9MnYNDYxvPLW94x+r5brqdVoH5ertMywO5QDRD91mX4+Z3gLHSfliJUHbIXTAXBu2OxPFHZNT8bohhzTKJPorSwEQwDSZWAKAEb4eMbUHyEBOPuWjOD4u+HDPE82muhj+PaWrUv9E8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4mDJNji4mtjh1Y26Jd0d8dhHU7DpWSJDldQXvL/GoA=;
 b=lYeTg6cgrRmEPnSouj3l4FwGBTdmqG/70NGvgFruAYuk/sa023EjYjLidKEDkFpO+Yubm/un4drNSRKKHMRGQkHXU3iKed7CHhQLEpS7eVGN76teiJvNMjUwezCgZP3nP5MxdJQhLw3f5dnL+sL1OQ+o+8u6v5kjQz9tC3SyEZBbzuTsEv0MpOhkgQ4CX+epxCwuyTV09TTL3B3W0N2Ccam0IWv8FAmgjwQx0Amr8W4WhuFEzmRFWtpF6B2OlbALNoSfGymJaaIBSO0yGj6LcNoQO89+DxCURjT+FVchLlj6qHR4pWAz0rnJLAek+4oeKFhHZXgMIacXOFU590kuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0730.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 6 Jan
 2026 09:22:12 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Tue, 6 Jan 2026
 09:22:12 +0000
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
Subject: [PATCH 2/5] dt-bindings: firmware: Add RPMI performance service bindings
Date: Tue,  6 Jan 2026 17:21:13 +0800
Message-ID: <20260106092117.3727152-3-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b5498138-a731-4faa-5f4e-08de4d0512a4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	6LQ4uX0Jp9LZ6zidwUgGeZRzZXj7pD7h7kiFHNz006mhi2017rtAV2avCtXNETV5aTPKLDMwU75HkJncuZVrLskQ2UlLZ/GCg1RbHEQMFDSBzJh65x+29YYYcxrTuTvSoAlP7JNP3q8yIDpkCLk2tMzVNNik4F5xrII2rBeaYAKhtVv51rO7x5i648jWD9GEkQzm1v8yUCprKGQs82lsDWFtP7FznjSrnioce25D9q9ozo3wuLJXHhsyOdtLb41tjPf2D38oMCG7OsaNMGOsXmsEloT+LgnIyFhoVrVvyYTCL14fEFIctFUKfo9lFiDA9n67PjNtTSQ9t6Ak2DQlPj18X+FaufP6EzJB2GbKXgFoIMl6Jgr36rhG27xfZwTZ15SDyGmZZyJbMW0V/zBukQwcYkRY+691nBETE688aPr1Lwf0F1Xl6xtmvyWVICBZnNlhyWn69wx/WbiouMSmcoNBVq4sRN81q2MLydtrD3Xrt069qbR/xPWBP8m+pta1+COeiFFVTR0Vv6EE6RPMQQb5e2rQyWsyZSrUE8mZcVhAeSFTtjmJtSfik4yp/Qo/Rl0gGXJve02T/u37h/VuyB96rBIDIAhSmtNtnDchzVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEltrf/PgkkoUfqQuoOaCcfar5tSMen4Xe5QYr4a6/4SfgKUwr2cIzLkwT/m?=
 =?us-ascii?Q?JVNDp2pElq2qGmNZkUBRef8rAOCGEQqvNT1BpM7hKGOFL8ECDZaC8DHAEzF6?=
 =?us-ascii?Q?TA1gC9EC2sGtNz+nc91xYQfoO9hD5grhIPIFDbETGF7g230mMrRqXAdmCMQy?=
 =?us-ascii?Q?5NJWGYX0Z6bvmXAADilR5Mrbo4gqpasP4dxZeFrCZfnZoMuOCRT250/nvCFM?=
 =?us-ascii?Q?b8GErucUuKrlPhQ1V/4Zjlo8M65yBC1hg5qY3uHCxypXmmNAlZLQfWiGTn1k?=
 =?us-ascii?Q?5+IBTlpI7whR7CxdLmwNKKe3fgmC60lmCGVBew7R3lyjx88H2rUEKqPWOIpQ?=
 =?us-ascii?Q?5U1jRCRI5VdeKDPkWMxNZtwuCoS8wVhd0t00kMRTk/9dtEtvdhYP4qoL/TPC?=
 =?us-ascii?Q?f7ZyQ30j272vUbyS2Dvo4Hw4lHYw4qKAr3ySZsYm7baQ84k2i4VZdtApy4Uk?=
 =?us-ascii?Q?VJD6IzUcYRd/JfLaDtyZUfg2kkXtrpxkiZT5kkWci5T7tMys0UW02LCxLKKV?=
 =?us-ascii?Q?Owl/jW9q1ruGW1/60MfdIiae6cvP+pLOey2HRrSzhisSnP3wmdbRHBtpBRnU?=
 =?us-ascii?Q?wAPIb+nAWR4WWTRr+rjeFogK6W+N9tzIbFy1KwO6E5DoNXx0hCCo5EPy+RyK?=
 =?us-ascii?Q?uHKujQGmyuubQ7IrEIPkA7FNI4QfwLL2QgNBdd2NNbITN0FN20bgKTwcMNBC?=
 =?us-ascii?Q?GTV5tP9+zUh6WwC+lTEt9T1nWdEqZdVuK+j+iOozkBMcsKZiGcVozK6U7dLP?=
 =?us-ascii?Q?VzJc+DkA596UMqSYHAMzQZxWak/pK9OBTJUNsfJDwfHwQaSSwg3nEUc0Z1dl?=
 =?us-ascii?Q?lqNfMhMiQgGcAXL/OjUoAFNN3vTYdYyZwoGhBaM6ZH8yJnJVc+vurhsYk132?=
 =?us-ascii?Q?iKemqxs5jvznlZHRu8rd0XHqBmAmuV/Kh/e4JD5wYcENpQU6yklI0hL53cff?=
 =?us-ascii?Q?HAi5NHLew0c+6721h1Q25TyWSzi9Z99sD1em3ZgTgxWdseNLf0EO5wl0zSgT?=
 =?us-ascii?Q?+Db73AyZhGxm2tFgKLzYBwYGsC7DUFCLENMjgOP61LSMPNbYeTao/UDTiTBU?=
 =?us-ascii?Q?glb3S1i3/QFP/+4MF0fPdUcqNKdlBKLX1lEZo8dKwi4rUNLyQOtsZ89a2ttO?=
 =?us-ascii?Q?PzrNY4bTd/QagoWtaT+YDt3dy+8Z36kqtWMma2GvSmTDNspBRKFrp0mCnlcG?=
 =?us-ascii?Q?Que2fdA2AcfcUQ6pvQLQAHtbIRY9qZX181TVdrioHP93GPC8db9pJ4czBtn2?=
 =?us-ascii?Q?gAv2IqL6mW8jcDoT5gUcu4CMsL3qQKF1KcJahQNJ+oFP4FyZt6KTVqN0YFiC?=
 =?us-ascii?Q?EYCwVazJFMCS7k0B5wseTHJu/GqgxNIZ9f6B3cXMKYBfsxfmxQj56/5uYqYk?=
 =?us-ascii?Q?oZvN8Rjup8YWY8LvEbUi3CMPaYab28ijLVHkfpkg6SIaRtWyzqRdBz8IvwE5?=
 =?us-ascii?Q?pMiDqUHiJ9KcDZ5b2HHyPaGWWxYuT2slyTN3wUjRGAANFjAfx+g12doVFExR?=
 =?us-ascii?Q?ds4kCZRxwnl8yP3igsGdn+SngmxaveYnGIv3Zo0RNl/VsmneRvvdCGTJ84zx?=
 =?us-ascii?Q?2ZDyNhYPH+r2BFMlGcOrxtipXjJa+6vQwlCB3t++cL9YHXKl1Es3ZQHl3kNe?=
 =?us-ascii?Q?YEsJ/0iVGpT5nrIaLpwKTIE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5498138-a731-4faa-5f4e-08de4d0512a4
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:22:11.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mxtt7UsB9t5/+cePVsWH+VUXUllLh2FtDznnKovHv9/2BzVicd4ea7nErs0fGoCJly3naY4n1hE7rxnLbzCgu9sZaLMiiKnwxGohLyAu9kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0730

Add device tree bindings for the RPMI performance service group based
controller for the supervisor software.

The RPMI performance service group is defined by the RISC-V Platform
Management Interface (RPMI) specification.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../firmware/riscv,rpmi-performance.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/riscv,rpmi-performance.yaml

diff --git a/Documentation/devicetree/bindings/firmware/riscv,rpmi-performance.yaml b/Documentation/devicetree/bindings/firmware/riscv,rpmi-performance.yaml
new file mode 100644
index 000000000000..61adf6b1bed8
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/riscv,rpmi-performance.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/riscv,rpmi-performance.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI performance service group based cpufreq controller
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
+  resources, as implemented by a platform microcontroller. Supervisor software
+  can interact with the RPMI performance service group through an SBI MPXY
+  channel or through a dedicated supervisor-mode RPMI transport.
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
+      Intended for use by the supervisor software.
+    const: riscv,rpmi-performance
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport or SBI message proxy channel.
+
+  "#performance-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - mboxes
+  - "#performance-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    performance: rpmi-performance {
+        compatible = "riscv,rpmi-performance";
+        mboxes = <&mpxy_mbox 0x1001 0x0>;
+        #performance-domain-cells = <0x01>;
+    };
+...
-- 
2.43.0


