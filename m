Return-Path: <linux-pm+bounces-18306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB79DF516
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 10:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9ED6B20C14
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFBF7E575;
	Sun,  1 Dec 2024 09:19:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021128.outbound.protection.outlook.com [40.107.57.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663735885;
	Sun,  1 Dec 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733044740; cv=fail; b=UMBG4xQlVi4o2QXHFctfFNUwoyFJ3RAoCvJpRuJZPZQNRjv6kLVG6R58P3umsWPm6v7wlTGzb6djOTbugrJZdEtOxJ5bwuI81D9oAh9Nrz294bk1LmiLTt+Twu7s5hvZj3Hn5/Dgd7klSkwszngXTObo8AJG0j/hOdPxxPs373Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733044740; c=relaxed/simple;
	bh=7pmjwW9kKnqZB+s72XOdThgr2xlxSy1e4iKbw23Ku9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tO4S7WfdsSFbEksDHVeVVlLtdzPydd6/JGKUvG8hLgMnk7hhlENiOco+00g2OkSZhZf0FnQBOO/RUiLK0EqPpESR4Gj7vHtCnpRxDMPqilopnj8d52jFut+grFoMSMfs7zpdt7S/dIvOAs7qcsPKHKL5jIONmhHRv0V/yPYBqRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=none smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=siliconsignals.io
Received: from PN2P287MB0351.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f3::12)
 by PN0P287MB0373.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sun, 1 Dec
 2024 04:44:25 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0351.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Sun, 1 Dec 2024 04:09:12 +0000
Received: from MA0P287MB0434.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c9::13)
 by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Sat, 30 Nov
 2024 17:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1cJmZeFe6OPHJJQnKufsXkrve8/2LJpqlBjlHY2t2AhXK+c8tlXUq6FOr6ZcG+dZLJNMonwjz01O7Q2XMJRglfxrbje1CfQhXU2cVPxna1z4ty1WhnfOYfg4qnYFWA2+Dcr+XcK1f4Xa7n9pZAZtsHa76ZAX7CnCWkhZPRNEvbZbr70L4T73jdoMLaBD75UG29/0+9Th/unu39UARAYXlLHowgKcWw3k2tqTpiOr5jPtZcyDSwmSzrEUS6OQTxv+c5/O1sOyIncscLSDEVRbIAMnRLOJAOowq9y6hUm20AhF1hwPI78e9Vg4erX0rEgkDHj4xc6MjgkZuW5AerdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APM6NRB2CFXov14285xDSxIVO+tWOrpyCITeAe4GYV4=;
 b=UYPsIvspCugBYXE0Xsg4eZHyghRbGCogFU3TcfvK4Se7wdj/3ZQsXPiL22ecmy//j5/uIw7VNXjwT2IE2G8BJS7ZEVtD3/H6YXvfXtx872vyW4fo045qgsbe1PYIt741kQh7OegdyD5n2SIRj3LEC/u+WBnPgzscaPSzrYj7FWluA+s3YaTLuDDhVKExOBNHmBIWgctG5kq5tZuiJ/SOdYTcQ3Wu/LkAR+u7Vo9qLi/+AwzA+HfN2DPmb3jeL5ZDJ7lmj+CA1L3LL+VuavEJYeJ2bEZem4XDtKo0ruaj+nZNxq2pUwvcLMkcmqHyBM9UGLHvzo9Pu8OxiLB54fAleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 MA0P287MB0434.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sat, 30 Nov 2024 09:46:10 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 09:46:10 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: krzk+dt@kernel.org,
	sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Date: Sat, 30 Nov 2024 15:14:18 +0530
Message-ID: <20241130094531.14885-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
References: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:fc::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	MA0P287MB1178:EE_|MA0P287MB0434:EE_|MA0P287MB0332:EE_|PN2P287MB0351:EE_|PN0P287MB0373:EE_
X-MS-Office365-Filtering-Correlation-Id: e28d5310-51fd-4cff-405c-08dd1123d1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LvssqekZmsE40n3sSTObz/zy+xGTwkhnMbZwV4Bv5aem+C7isUDhGC4qOj37?=
 =?us-ascii?Q?BnlKJQePVWd69OjbYFkq9kDKSDvPDvdd641LCApJtNeFQPSQb7DoSovEoLr7?=
 =?us-ascii?Q?uUz/0uMDab2b618M3MbdtwYbZFGRMiA/PTvrqwyhtWb+l4KPnqKuZQmjG32e?=
 =?us-ascii?Q?26a9DQmYr3Q7eD86Hu7U/w1LO5HA6NWbg0b/tt7FwWmj+dZh0SsBFItl7lj0?=
 =?us-ascii?Q?PNVD/4hZ5AKjqBq8Djk0sqti+hUmHLOHb2/7suzz6a772gzt2LjK2b3EaqRw?=
 =?us-ascii?Q?S3O+mOY73BUZR+bXJXsc4epsyEQYH+65B53eQ5vHzX6nOk/Q7ncBuCVuEC2f?=
 =?us-ascii?Q?6ujzEMjro6t9ofQqblcCc0OgmvvRimghDvhbF7a6c6BeSC6+KDw2oPVnC/lm?=
 =?us-ascii?Q?1vglTlEdzNQ8MjOQn18xh43wsnyjkYVQL8EUVjPabb/yN3ityfkfI69i3WE2?=
 =?us-ascii?Q?P0PFsImCOdPcJHdAmjyEKgWEdyC8XTt6YUpXJ42b5mQcOrWoXYQxCjn17Yjq?=
 =?us-ascii?Q?JD8026qDG8e2YROgGVKYdZ7pIGv7ur3XjgxCbGFUOoi9ozk3MDqwT5RGybin?=
 =?us-ascii?Q?6ssHQvMoHq9Mt5fU0ScBlJNre9OwQ43H8x15QC7d2QHOYJuYxiH1jQO0j/d9?=
 =?us-ascii?Q?8h9m60dk39Ew07asXG6oi0P/V9VXmlyOXK0hoxqZTZeIZqX8lXrk/xau5xbE?=
 =?us-ascii?Q?1nje+SDX1QnzjZ7HGmkN2Wn6Dc0x4BpBix3e7C1+wpF5O6Ih4ZLYyccWv0+a?=
 =?us-ascii?Q?bs00TjLzsd3FzONucWp7JFDsdGsUiN+jBKKl2yRoqi+XWptXNekTaYrvW0c0?=
 =?us-ascii?Q?KQolxS9ZljPcyzspX/3x0+yoF+fyIFq6AAKPBxpk1DuSBpecqFO454LOI3/T?=
 =?us-ascii?Q?wGNw28xoF3LC9jrXzPHa/o6tyDF20WaClkIwi2H3/hZYXmU181+zeXqMtcLA?=
 =?us-ascii?Q?/AiuC2T2xAGw19+GsJ2LHOKTkCVebyf04nRlRgufy47q7pNrgSS4kBK3LCg3?=
 =?us-ascii?Q?+W0sklB0sblTah6kEmrLV8gRDxcB3wUN/GA3Q8lmi8xx17uNdANgA8ElatRn?=
 =?us-ascii?Q?aMR9q9tIxcA542m/bqYM+Fs6pz5MuA2CYlFot+uAR+/K3wbv96urXUHJNV31?=
 =?us-ascii?Q?emip9EA6cqNhi0G2FpP8ONzfYYO1CLnU3t95urQBSoKC0M6q+q1uYQ9zcOti?=
 =?us-ascii?Q?PPb5KxCCMMX/PixvybgYO0XEauYZtI/clqEYVrWnoG1WAVzht6IxXhpDa4JL?=
 =?us-ascii?Q?fEy5GRatMvpozMzEc5WvcR456NUfVDiFt8bJhiuWPMSQo+ygtJM46WS+rDmr?=
 =?us-ascii?Q?fYJUANX9HIjmSHnPuADtGQU8BO68Ahs0iGSkJUoutw2c4S48BwIpJ5H8K/Ar?=
 =?us-ascii?Q?G7amkD0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?O1xhHgNrMqrH0aD+P44CWy+asKHFS00/+5hTzT63HDxmBoXl3Lu2MR0/16E4?=
 =?us-ascii?Q?0bepCROKPsKtm0LLnJ0ZnnAzCckfx0uG/adKsCNBBG9OrrnHJg3lxsatx0nB?=
 =?us-ascii?Q?W9oBtE13RlwpjsRLfnKlrCmaDBcJKe7BhhnUV8aR9s2iINcu7/dygaOCzoCc?=
 =?us-ascii?Q?2uCKG4JXufOMj4Ig9p0m8YBTevnRedh0DiwsYJc/lAn2ftZLcJR28yhX/qGG?=
 =?us-ascii?Q?eV+iCBGiuQEczM+rWoK6DydQuKpOtJ030vV/aUhizir6pjWVpr5W+HuXPiUg?=
 =?us-ascii?Q?v0zutEzrQXvQhSTSnORdzwrVWIsVMSOIq6n+RGiFDHFAGwJLSE5WR2po9TX4?=
 =?us-ascii?Q?yGc5GPlD/fqvisNcLESRJj7PkZ7VGw5/qOsEdUpUo1/Ai11+sg/Ca0B8952r?=
 =?us-ascii?Q?IrbaYHrseVnmZsxKeASN4yrGpErAV9utmSloXgmMyDrgg7OqbB0UHJ7QXs0l?=
 =?us-ascii?Q?tIs/m0kkqcZk57hovdzuWOwpvtCsrzlhr9JtHnttHmy54dWOMTMWUjO9Ma0s?=
 =?us-ascii?Q?qfA7BRWRYmkHxJyAF2KoiHlA4SLsQFQW1T4mgI6wAyMGaK2j6+x+4fbJgiNz?=
 =?us-ascii?Q?WF5wUwbhd0u8zh/KDw3y32kPXZAbhIAvUtjgAmmRznrDYg/MeO6lYg0pFAJy?=
 =?us-ascii?Q?/Nw5z+zZaifUIJ/JWnLsHELQ3dXb2ASgjiR/MvwaKr5GtjVPCKK+cy+zguB0?=
 =?us-ascii?Q?PecFqHRxqiSr7zQ/tagy/YXn417wvyP+O8/ZtaSm1oA5Rqk2G7RcFn1wVv62?=
 =?us-ascii?Q?tgM7jku+TcvhFGRdPIJbGdj2nFYHLE80zdS039QX5u5yAkcJdNHEMVZwPNRT?=
 =?us-ascii?Q?SOwmXiW9OE84uSYPL9SWNHDkcrqHycYV5xOIZ9ZabIzlo17Ro5nwq2tUdmYy?=
 =?us-ascii?Q?2+TXxgCqMzVxn0dDEp6Iq4NS2lTvw1/W2EvA+NQnQ3l2+NrAiyyZdeD445nY?=
 =?us-ascii?Q?RFwR9nKoXqV9RM58qVwGZC9K6suEbxYgBJ67RcigT6Jp+94Pt4hFXdZ6h7mJ?=
 =?us-ascii?Q?1DOujveN785iEjzS/Mnd9LJ2412GnWaC3wA15GcNO+ZE8xHesv5zWKQ+7BHp?=
 =?us-ascii?Q?fJYGkXFR4Ghpu5g2rHFSOq4YWY02XviK8m6OPgcLfO4iKC68fWSgNeHIIbLl?=
 =?us-ascii?Q?ZB6y0KDeDZeNiMdXuqBj9Jy/xa7/qTCU6fr/Mo53tFzYzDsYi8kX4DGk5UgA?=
 =?us-ascii?Q?+eIyMmrQr3f6BHUDO22IXcY9Burmouz9mSEKfmTEk1mNCkOGJRPkNXrDKoyP?=
 =?us-ascii?Q?5P5Sa8roWhF1zQ6xDryx7uvBKoPut8CC9I5HrVc7qDigIWei7q9pLh3pDbro?=
 =?us-ascii?Q?CGvxAILZfLkkklnAJgcES6xbG/BPz31wXIK/kgqbCjxtOHb0F/Bgtm1Cg0CD?=
 =?us-ascii?Q?+F3aH2zqp2aEOf22qrvEjUI7OwIrdiF45ppTAPLApU+vO6Ib7zYJSqdDUN4b?=
 =?us-ascii?Q?nE6pJ9wngrpAZVD0iUWhR1fuAsjD+/cqrMtGq1Hpf6nnt9ME3XajfmwsVt/Q?=
 =?us-ascii?Q?7GAhL/+iXOh8ZUaPbkRCevmrwGvTnwn1jCCERqDr1gBcFyDsh8vEY9G8FUfY?=
 =?us-ascii?Q?LndMOWoTIV9J1kX8o9uEtwO+eDzr7E0S9YVKqHdi47kJ+JTIGCbrncFKd/5E?=
 =?us-ascii?Q?o6abwjUn5MO8QS1xqduneFY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e28d5310-51fd-4cff-405c-08dd1123d1ec
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 09:46:10.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS+hC9FpWHqzwBX0vT44o4JIkEv8PzptNn0AjwSObR+oDMmvA9GrE2izTgK3QPuhjKXiGARNH4NqUve/gnLuFhO+AZy3iTw6ExSE8eGyyK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0434
X-OriginatorOrg: siliconsignals.io

The STC3117 provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 .../bindings/power/supply/st,stc3117.yaml     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
new file mode 100644
index 000000000000..1300eb4d2851
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/st,stc3117.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply
+
+maintainers:
+  - Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+  - Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+
+description: |
+  The STC3117 includes the STMicroelectronics OptimGauge algorithm.
+  It provides accurate battery state-of-charge (SOC) monitoring, tracks
+  battery parameter changes with operation conditions, temperature,
+  and aging, and allows the application to get a battery state-of-health
+  (SOH) indication.
+
+  An alarm output signals low SOC or low voltage conditions and also
+  indicates fault conditions like a missing or swapped battery.
+
+  Datasheet is available at
+  https://www.st.com/resource/en/datasheet/stc3117.pdf
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,stc3117
+
+  reg:
+    maxItems: 1
+
+  monitored-battery:
+    description: |
+      The fuel gauge uses the following battery properties:
+      - charge-full-design-microamp-hours
+      - voltage-min-design-microvolt
+      - voltage-max-design-microvolt
+
+  shunt-resistor-micro-ohms:
+    description: Current sense resistor
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+  - shunt-resistor-micro-ohms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@70 {
+        compatible = "st,stc3117";
+        reg = <0x70>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+        monitored-battery = <&bat>;
+        shunt-resistor-micro-ohms = <10000>;
+      };
+    };
-- 
2.43.0


