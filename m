Return-Path: <linux-pm+bounces-33931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9336B451D2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B8171ED2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912927F183;
	Fri,  5 Sep 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qj9HpBv3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D691A9FB3;
	Fri,  5 Sep 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061748; cv=fail; b=EsZklq/SrIhnbPA/0uqUqmKcUKNcFjY++IYyu6sj1XZ16YKx+JrgAnBslv9H084k7FLrIW3oNFr2GHkcrWYQtTUrsfW56EQz4ZSzHRoPXivKXrfTc+otGxNjBkyC8ciNEplD4wbGdJ4irbxTX5wGdBE6a1BEqPJtVUt89TVm9+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061748; c=relaxed/simple;
	bh=+2u6B+o2HjfZcf2ObJXQcFL6uumPIahdfbJ4ULfh1bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amRF4u1GvLlEpFzXtngLaICvC0NsUOAT//IYRbJvQyQceaYutEHwTob8XqSzFRw+l1dG1bFWjruPkEyqJgZW1cyxHr0nyXhlUGP1WJEVsHaRKMTukgK1jEXjZR29qLL7y61z/4E76nPp/r3MPGyNQqFWKkLnA27oTjzacToMUoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qj9HpBv3; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nedcp1XL3hlFD9aa1KwYfVW/e4ome4MD9nA0TiCxc92hB/tdYe/kHujDk1xxTizV/WVxsHXOqfX7bxBtkYdYsFtJ1Wc5TiawW3ToBCT412ppX1IyIdBSteoXbNhwrhVTVesBZwKA1zD0TMyyBt7janMVveo13sycBcC6JCUaEVkePDtcGVPbs+PYSeYSHSbfKeE2pPodx3QXKZ0su+DBLzf7Mur/Udkgs8yDBoIfYCSaDZwmVuef39x0RzjRhmV8KNL1I6/IgejbyYPSvRSd3zU+GyuL+URcUpTPJrotOj1W1GPVs2Kl0JmjWPUmQqdV3rqInQCmUCmXY4bB4beuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD7c7XGJ6/A752uiPnxtiGTYcKPl6rIY+JujYapuL/s=;
 b=zDaEy89qzPz+JN6pz4FNw08fpD6h0Dy/jZA+q738LsMkFANt7fFDCqAlqrWpeIlaSewPNY2JaNdrtfYcZnep+tK6ue5Cj3YAThb9pm6RQ3yDNlAcQUYBEQx7sxqwdYkLkWa8pWlb67wGzAsEP1+KXsWfXxxdg49CTqFDi+ucS0SHZR3CfTe6m3v0xYBSeu7PlnWMAjZIByRAN67LfNoOrjjGVYO57FomhRgKBPzEE0k21C33l2xi7WeSi20GmG4PNDK0iTO6n1WcUIUYlVInlNUtjnRY2jySxg5E7jzwccXNFdzXrOnDVyKgu3SAWWLwPR/+tdup29o+1Byk2fvpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD7c7XGJ6/A752uiPnxtiGTYcKPl6rIY+JujYapuL/s=;
 b=Qj9HpBv3zey7Mf523nMt1gEUB4CH5wI9E1iNVrSItbv5TgZAOMgdXIQgiENvlOlEO36Osnbs0oXVLcHg2APwCSudAYZcuVh9RrbEUCadE7mPoiQHs8YgmBgFA5B+l1XsRhEL1d0cZaXZ3ZhVt31JuYrLIaJsoJTINzU25MTmmlE=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 08:42:21 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::77) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Fri, 5
 Sep 2025 08:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:42:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 01:42:11 -0700
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:42:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Salih Erim <salih.erim@amd.com>, "Anish Kadamathikuttiyil Karthikeyan
 Pillai" <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "open list:THERMAL"
	<linux-pm@vger.kernel.org>
Subject: [PATCH 4/6] dt-bindings: thermal: versal: Add description for Versal Thermal
Date: Fri, 5 Sep 2025 10:41:47 +0200
Message-ID: <c46889536b2555c25aa6f17facdf085956b648a4.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2130; i=michal.simek@amd.com; h=from:subject:message-id; bh=kzf3zxCVMwBg6GlVmTOTrvwZyUlp+2MwNEb6Djv3yEE=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuRXlB1qe2vZkj6zd7+ty9fVnNjxovmRm+2ZKbfD1 13XkuXb3VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATiZvNyLD26/nF03+r6M8t eeH4fu3JH1NzkxWnuzdnhc1LfZI4z+o+w/9Ig47HScfl9Bxlzl/g93SYtL2Ib+IHOf9bSTMcmSc ECnIAAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: ac478399-4c49-4c01-130a-08ddec5820a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebgy0BuOhtvpOcl/M9Svwt5goLO6nhIIQEB1aaJ+OE0jmTzq0gJ/Ys/tdyBP?=
 =?us-ascii?Q?A1bkOBWuqKM37BRODTYQAIlSaFat416ZTm4kt0Oc6eMkUBDVApuOprkAfcNi?=
 =?us-ascii?Q?ycxrP5J1Szu5fzu1tYhmG5VEmFowfcWMD4jaBhHw485VLdrU1xY0nZhNNiu4?=
 =?us-ascii?Q?q1gJwKxSGbFXNDEuDO5Wll2Nbe2mQ7NlEaQqzP5ewpRXwrmsBixcS7kiqf75?=
 =?us-ascii?Q?NeP38/K+RVFgO8gzW+ithNaOQx6fQ777LGFLqRct1YA8hx91ChriMgXDR15S?=
 =?us-ascii?Q?c3WdnmTOYEs9SFJAErr/xb1uFGCkgL6WErxS1OTSezAB6Tyx+QT73JtvK3Yc?=
 =?us-ascii?Q?yBqxOXRzfcTeYoOf9DyujRAgyOXpFj6c/wAGPBRQeFpOYoXs7Io9JsriiqtJ?=
 =?us-ascii?Q?4phuqTPeDXk7KtEHGDNYO5FqoapjxWBoqf6FTL11YVWq++NGySQvKSyaSJMV?=
 =?us-ascii?Q?Vv8EAJ5r/2IiVXpXU7cjsWP9f33DqNDiNILTlq/fpEuGovBaWg9rxB9/j8dI?=
 =?us-ascii?Q?i6BePp6/BX/iGIh0tCy1hSLY+TQOpdPHLhC8KBaweglh6cBQblmRnJe8XGC3?=
 =?us-ascii?Q?9aVwMH8f3y6cJjrPnHkSxWq0DeFzVPPXaMyeyaDzg4UVpIi7aAxEfdLNVv8Y?=
 =?us-ascii?Q?ECCMZUpWPFBETUNgdKV4IrBzaJm1p+yKE5c/9QP7i4EIlA6yje7dHd7kbniG?=
 =?us-ascii?Q?IESckbz636iIiTRtq2NnxxU3uDv77TxpALI7kz0+taR9FanlTwH3l5Xl0X28?=
 =?us-ascii?Q?rMtoUH0fI22nUMniMVALNBQaqjWmCZQ4CbvpDtz1ldFkT/MJf4BZ4MjMX6Dc?=
 =?us-ascii?Q?WevxGZF7CS9J0EwZzavIlYLop/vPTnu/dZDCrAs7YRSBY8oIzoP6NvEOVasJ?=
 =?us-ascii?Q?XfFUtIeeM+hZcQhOMGNx4tqjgMJX2dpT3uUr7ozZlULfisPCqQfpYoJeyzp9?=
 =?us-ascii?Q?Wc0bO2beY7CUO1U65otxXpShZD5eWHcl6rmTy/c58wTKnIKF0kyKl5bkc44j?=
 =?us-ascii?Q?ViIaaR9pLUyCI4iTN5tBx0otJwqUohQjccqSm5Wo28v3+H6MO1hv+CwTZbV3?=
 =?us-ascii?Q?A9lNaRyFEv2KTtNOT+5P/VZ9bH+zKRsDjyqDJLBon+u6VDwLzZkZHmRAM8HS?=
 =?us-ascii?Q?bhKchyVJbnoOiI8CmFQK6n1+iXCe4qR4VLlBmnk3R1LIP5Z8jaRwkV8PD7fM?=
 =?us-ascii?Q?vZytNfDipa2LZtRu1A5LYK/AN+1MwwdzsETqHxIsW2MjsEloroQXtTFteEYV?=
 =?us-ascii?Q?BAuItxJ/ZLhrt5ORbL+nIUTC4Ly8a0gwVXBIS8qCaKfCt0LM1Kmr0fuhCPZa?=
 =?us-ascii?Q?d9dFhD3xd/B7UqtJ9Oh0/hNyYd+4Zw6TyVjQ5kMllDEmSxwLeGn0XI13JD8z?=
 =?us-ascii?Q?YcIizvQq4FfjIAGzqPsYYSQLRluy5WfEEccE3qNsBt6m+deHKPCyH2eXjCQO?=
 =?us-ascii?Q?8Hx52yMr7VksuZHlWFEMc6ZhjSLy/pPkrR3gT4RU4gxEpDn51COyWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:42:20.4280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac478399-4c49-4c01-130a-08ddec5820a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

From: Salih Erim <salih.erim@amd.com>

Add description of Versal Thermal which describes IO channels to
be binded to thermal. Constant channel of "sysmon-temp-channel" used as
mapped iio channel.

One temperature zone is used for the AI Engine temperature monitoring.

Signed-off-by: Salih Erim <salih.erim@amd.com>
Co-developed-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../bindings/thermal/xlnx,versal-thermal.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml b/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
new file mode 100644
index 000000000000..c374d7ae2d2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/xlnx,versal-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal Thermal
+
+maintainers:
+  - Salih Erim <salih.erim@amd.com>
+
+description:
+  Versal Thermal uses Versal Sysmon hardware for temperature reading.
+  It works as sensor interface to be defined in thermal zones.
+
+properties:
+  compatible:
+    const: xlnx,versal-thermal
+
+  '#thermal-sensor-cells':
+    const: 1
+
+  io-channels:
+    maxItems: 1
+
+  io-channel-names:
+    const: sysmon-temp-channel
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    versal-thermal-sensor {
+        compatible = "xlnx,versal-thermal";
+        #thermal-sensor-cells = <1>;
+        io-channels = <&sysmon0>;
+        io-channel-names = "sysmon-temp-channel";
+    };
+...
-- 
2.43.0


