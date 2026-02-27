Return-Path: <linux-pm+bounces-43329-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAo/ByW8oWlhwAQAu9opvQ
	(envelope-from <linux-pm+bounces-43329-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:45:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E8B1BA2D8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 283C4317A977
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ACD43D4FC;
	Fri, 27 Feb 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WxIAhqIV"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0286328B78;
	Fri, 27 Feb 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206540; cv=fail; b=VzglkUYtVBvc2SDp4BNHBhx7hUP7CeAk5QmatXbXlK9t3eGiSPVHK/0EykP5yEDJNYp1ewZ60vbP4MY0EwK+hNVfkqPW/2sVm1viYrob7QJU+50y1gF0y5lInGbagjVb+gjZ24N935cPLh69br08S7/1O6TjtH6prOxX/8S0/ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206540; c=relaxed/simple;
	bh=G1l+9kw31I6jYCqCAkqRZuNHKNOWXaXNrzf+SaW2j30=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=sqEVW/yygAbw7cuA7h+S1JQjM1U6VptTTDp/pR2E7HcSbUPtoHXgxfJq7IwIg3KR5ndfx/kHeujuaD3YACl+JCCLnmF3qIGg0eHfhp8GDjr/R+FOBrS6von4ISuvVlGVyXvK7SPnOcwSARQkCTy2g/2uI68/111F32sbo0OxhM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=WxIAhqIV; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8jZ6VlWKUHo5C286T3sUrQaETgVch9hpKUWzslzT+tRfDycbZ3o1qmcKNEdC4npARXUwEFckEP3QhimZdqzHC9J6mLDPZvyACtVGPtYgNeThsUIJuJRMiKku3MA1OyJj/YXT/oMOei4OQmhPfLCpa3LGPQ1dbZxsMQk271O8KzV1Oshurb5s4gaqXE8f0SDbI0mF6IKSUju7nZ9rUhr5n4ffJDzKwvkAZO45KnoUfVO9QguLTrIeujnXgBK9ud85uLviJOoMTzRc9GrOg7ASFGt2lnz1Yl/rupNbXURlhW4LgjHdl0Ykv5+th7Uy/Lm+3aDNO+lufc+b0iV0oix1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGkP6f7O//mReZGEElYWBw730xNZdVLnRgEygn46rbw=;
 b=p0V5p96QO5W+cDioDi6WdHZNGBkunjtsuB7mCq47XRNpnCo/lCV6hQheY1dny9wWTCWxs2dHESl6cLl/poOf0CXbqFBF2OGj+wZsh40iJDIXnT+6/LYMvJmzfymvEXcqf1xoiMkgt2FtXq6grA+GOrsPmcUrICsxy2bs358mANn4zHjpvKQPTjFAnchcMj6ZyCtOK6dkJkwn761hGJV3rnCgU1VZTpi2vU4fBizD6hs0YKZ6H1N76c/l8Zpu5lnwOsBfT02CeI8YcCtMXrrw6mvuluixpLwDrZg37+LTBbrVaWG7UczkWFQynlP5lTCT9cQryCFWi8RdxyfAbRQb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGkP6f7O//mReZGEElYWBw730xNZdVLnRgEygn46rbw=;
 b=WxIAhqIVLIM/UTguyxOnwWZ0O2H/8NgQVLcrl2cjAw4eHfDU35iao8rd9swuXCzJRdC8neHpb7E+3n90xSVNG5XCqCrLaGphCl44A4xlVXzwvkyE6anXel+IAxF7eJcD87jvGP3y8Dqnrk0mHb8nBJokXTyZskNDvY8ZDvrZxHE=
Received: from AS4P189CA0032.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::18)
 by DB5PR02MB11961.eurprd02.prod.outlook.com (2603:10a6:10:64e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:35:35 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::ca) by AS4P189CA0032.outlook.office365.com
 (2603:10a6:20b:5dd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 15:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 15:35:35 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Feb
 2026 16:35:33 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
In-Reply-To: <cover.1772201049.git.waqar.hameed@axis.com>
References: <cover.1772201049.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <65f55d19b4bcf8f07300df5922ba1605bb669138.1772201049.git.waqar.hameed@axis.com>
Date: Fri, 27 Feb 2026 16:35:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|DB5PR02MB11961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e447868-023a-434d-2d6b-08de7615d9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	El959GB191LpnukURfxzPYYzzh9jjH3+Gn+4Kk0qUOhXdgRiXUIyvuOLzNgt8It0f1fSzoqTdXTgsDjIYWxGh+5C7k/+FEFQk7CPNzjmmoI53kk526hH5t5BVvSJO0h7xcMPBZKbiEtyG109noQf2OKEorRenG2XOXONllI41VYLaGtXCKb+lsTiZluVOZ9RZhYZjn3gBo2DRaQcXOo8yQmiwu2mQvBLdQn9EiEsqg3RL11SYUylZx6X4oX+7GWvJNRPCEp2PBEAuKfqsvzqd50MMItWShROtP0SvPD8WYgRGk7vcoKUJah0m5Gy8vbVzEjOlHdMAvb6IcIC3P6eAzWhl+GP8qGsX1MTAVJnJ36NbI/jXzcRlgkI+FluytzXfr8AKtwSwSXQ/jBqIA7e4V07UnSj3kOu+xaZ4d/2sC29QvohkCVO43+x017zh6C9LwfxV/CljWxN2QiDcBVtJudte8eAToXw/edTyEwWYpwMRB3YR9E7xsd3qBR4QwxO30Vciktn2hqoaRfcwVxubqGIe3/GcxuePWxCW/aLZKIAYdLaxVUz/krujnaOTBx61+uccowr5MWG2lg0Fr/N/OVD9+XbJlgSDdzKS1OHs3822FFnRGSOCNj83sOTetJvNUe8r5BWNM8q1mCf7etTuOCSCKAkKLanMQ5rhWQUx8OjK4mLsXGyxPbZrJGt26+2hNdDJzFxTCqvgvUkO/6zMOUtyKZ7ClF49UZVyswGU2ofcINbvksjAcxoUTUoNmTCMCMwcUdV7qq24eQ4xkSVlA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mdSXBc4mBtAc0Ukc78CXynQ3RwwYa2k/sQ77Sp2PtoIQDhhvesMCZx0nhuN5WWI/fN9AIZiFpX6V1qIL5WMGa8VKpTaxxSWbodwKW5ZZRW5d6wlQq6zsoKMmM1LWuKklqH5XX/oA9FiJa4mdGCLf9WtTff24RFW6PFys7RLDbdgV+VycNP907llzo6N13um2Jc5245gvXzCGAsm0R66OIz7EfH7Lc8IBljF/izgUgpVn/SqLdeoC8ktm2twSEltX9xB4axBc8KL6bwjx6n48dLaoqMRfB9Rxbx/16AlbqFhz05Qhtpp+ItcB2ImsaYBLVtJLlKASERysrP2dDfgwxU07D2dpWUhrG00KD9/Nmgqwa+6FNgCfe307ZFSdo7uxd825MP+H0PQN2JXiS5MTJyn7JN5h5ASO0LMkDSGq2vhzNDUyIjmQ/DxYiM9sjV53
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:35:35.5304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e447868-023a-434d-2d6b-08de7615d9ee
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB11961
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.85 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43329-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6b:email,devicetree.org:url,ti.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axis.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84E8B1BA2D8
X-Rspamd-Action: no action

Add devicetree bindings for the TI BQ25630 battery charger. It's I2C
controlled and sends interrupts.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../bindings/power/supply/bq25630.yaml        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25630.=
yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq25630.yaml b/=
Documentation/devicetree/bindings/power/supply/bq25630.yaml
new file mode 100644
index 0000000000000..57e4286dac7e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq25630.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/bq25630.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI BQ25630 battery charger
+
+maintainers:
+  - Waqar Hameed <waqar.hameed@axis.com>
+
+description: |
+  I2C controlled single cell Li-ion and Li-polymer 5A buck charger.
+  Datasheet: https://www.ti.com/lit/gpn/bq25630
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,bq25630
+
+  reg:
+    const: 0x6b
+    description:
+      Device I2C address.
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Device sends active low 256 =C2=B5s pulse. Type should therefore be
+      IRQ_TYPE_EDGE_FALLING.
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bat: battery {
+        compatible =3D "simple-battery";
+        voltage-min-design-microvolt =3D <1800000>;
+        constant-charge-current-max-microamp =3D <1344000>;
+        constant-charge-voltage-max-microvolt =3D <3700000>;
+        charge-term-current-microamp =3D <128000>;
+        precharge-current-microamp =3D <1000000>;
+    };
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        charger@6b {
+            compatible =3D "ti,bq25630";
+            reg =3D <0x6b>;
+            interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+            monitored-battery =3D <&bat>;
+        };
+    };
+...
--=20
2.39.5


