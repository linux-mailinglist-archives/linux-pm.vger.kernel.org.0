Return-Path: <linux-pm+bounces-40288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4454CF7892
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D5973152CA4
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA5314A77;
	Tue,  6 Jan 2026 09:22:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FF3128D9;
	Tue,  6 Jan 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691348; cv=fail; b=clYhVjD1u0hcly5EF0MfNfJ1H9WAVDTJWygweN75uiwJMS0+h4/vLItbP/VJ8wELbXX7FHCy8JNRTna44QqQk7gQsyBgpDilZW/3laQXH3u9qDYab0du5f/9PSG3Vc3d1Eg0lZRMnRac/KdSCe3L7kUI2t6N7P2dok7Oi2hb7OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691348; c=relaxed/simple;
	bh=0h4soRKEQwI7C5NAEQcAcXNvvUY81X70JbIrBc1qmIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgL5BiPZAcufRMgrmqUIvgxplJ+HjpYlJcSLPYpuTW1Q8IMZRaLFDWJ5AYjAAYGc1NRsjT+9zGm+8R74aqZWBoKCdUkgotbCnBUgSsPSx/0peHrr3pLEswwmJhnT4NvDr/7bamfIEcP+buvp3QLaJ6tbcAso0hZBG6+zyDsERtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrbkDXaLXRkIPLkAQwudABPhfRUnQfy9GgVxqNedJ0kwCq5fNFKmhUtZmtqijv37rxaGT7UQJLxkP8xBIzQOK2QRV7DiJKVfbf9VKmktmkBLsmzlZ09oZRdfv8xJfYfNA+YpMqFY3TJwx0ZcWis95FaEYlqWCPx+k8pJs2MlHzCamJit8Ws07b6uzlD3NsjJfxJ9IpnT23OVVLJih/on0IPm42gbM+DsiPVHkAqexn9ZPQaLFM1uORIVmkJksQJgRx+G+k+Li+lB7dGqn5SP4tjs+N9/TYoTkr1L9ATAGmE5sFP7Fa6EMboG6yIBE8S5Q4WX8AwZzA7YAtvtSej25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0opdMDfUs59Uk9CqjaxK57v7wc/9d//PB/5YEZ2jnE=;
 b=fi2jBFvmG1Arism7Si8t4IIEYNjjVvCN5ic+akUkiBp6KA4HzKz67RTp1rYOZwkrYb1zhx77jUFi85FnlSMiV9bLtVWpluw96xJMwuwQxI/zZDWVq9YTyAKpRX16R3F6V36ZZ8PXYJO5BtmZMZOVYVyYEye0LhLz91or/ZshMyli7ml1jy6xO02iwv9mLnIN/UruJxWoD45yAgigOHV0WSo2Fp0O2844hStjEbsokoRZ+BGUAK2reDoTyGdtF75Bal2i8K6UNq3BtG8AA7HPA2AYM4wx57B8Yjvm1HNrlck2uy1l68OuyK//2ETu7BYY8h6SYhZVA9EmBQi6mdkSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0730.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 6 Jan
 2026 09:22:19 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%4]) with mapi id 15.20.9388.011; Tue, 6 Jan 2026
 09:22:19 +0000
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
Subject: [PATCH 3/5] dt-bindings: riscv: cpus: document performance-domains property
Date: Tue,  6 Jan 2026 17:21:14 +0800
Message-ID: <20260106092117.3727152-4-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9f0ee9d-665e-49fb-564d-08de4d0516e0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Y/IpyhEH4VAm/0K0o/BFVCwm64QPhkO7IfAbrl/REGlK5efQVc3l4anqUvuVYJzmIXlhKSl7JqG/u/4NXpRErsFeisNeuuHCN6UF4EyJzYEEvZyGg0zlLrtv0DQho1vyk4eO5Wafongk1B/T8AbprIiVHhE74mGA8K2Sqov2UC211N/2FbFZynxtoDUlb/8l+DBiSthL8dRrptS8JwyM+i9A5su802/Qw4W2/W2pmxJt4Jfs3RxFUQZZJsV9zG8Hu4rUAIox74f5+LOPLHTtuE6awVOc4B4OR5jiFd8szhBXPWRiMxMlQq3O5Txa0Pz8akPX0eJT4I2FwQ+NBrb1eO8QJzi5hG5rsP6/LCY/+ktOcT/VZp8sTelJAtrjir2neDYI8YZDmJ/SfqFrCLPfmVHtzuPGpAHjPhVtkwTWgOL+hp9J4Gg3xVkA42s54alOVOg2ChlrKMcEMOrp3Q4FgqL6cwkpwLQ+C3WqsahLSJmr/WZs5YesvnBFe3ANEQEDueD+plRA+idwWut44+V0dRXjYkH1skqdqEwt0JdBDFKywparjiGaa7vLOmWrjS8N6OsAl9W/NodzUAHhKYp7vXIKYXq4HkmrubE3zQJq0R8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOZbyLaNqxAhMcoksSfS/XZL5DEB1P0sxAgMATkncmu14BoLJZHYzJXG9YZJ?=
 =?us-ascii?Q?I5cRhGA/xlP4oeIhG/WZuBzXtZPTC3qMOMpBVUyk1+gvdrTi2ZHTyrmk5RBV?=
 =?us-ascii?Q?BKNh9BkU6QMVbpQXDy4MPobs2P09earrOovZ+Hz88uNTOUWyLiHNouvzGh7j?=
 =?us-ascii?Q?AkT+aZ7hLICaf7l4DlT6OWabLxWwQJTpxJG/49Uws0mNbo1CSygmqwPtNe/6?=
 =?us-ascii?Q?NJMWI2oJVWYqDy6ydt0ihlFbvjKzFsgrVAmlxa6h+nyJq3wbMZPw88eCF2oX?=
 =?us-ascii?Q?1Otf6F7FA2WyZvvvx+/j5ITjDjQFpwzHwoqL4dYrs731yev98ZpQ2Ll8E8Yd?=
 =?us-ascii?Q?hlHyQhvcwltLYmgRtp75JMkxajP8z12ebrKQiczrQ3Hvs3RAG3hPp/+oCb0i?=
 =?us-ascii?Q?iOHAVkcvC4CqZH4+9fIZHgQhgOGtMMKy1tPrW+wxiROntyQLgzHtqI2/cVR5?=
 =?us-ascii?Q?zuvVcvyLnki5xSEOq2zwKgXpQvgEJf2lNKXYtBLtUrMsmaOV8Wi+vQCHgsg+?=
 =?us-ascii?Q?4EeSUYu/mQVvJyhSjUZFn11jQFwOVwSFegv4v2ZVNsd8lf2UThMwvI1koRrT?=
 =?us-ascii?Q?+RJaCrF9pYeM5Y4vs6nZvEZGk9NWG3vrRoa/5Qzn5VwHsKs7eX8wOWefaMia?=
 =?us-ascii?Q?XKiYpIaxrflMLQ+NulJYpV6pHytKsvRSXV6GpVvPYQ0GAjc6+oL4ULwNhGbX?=
 =?us-ascii?Q?7DQQ+LC2KUcFWNvwDw0fuJeOMDgVafJ0sP/TRg6hmMH4HgEJ5GBy++0XbYyC?=
 =?us-ascii?Q?GxoCKWuYHYgoftHk1TqCxC6ElWAvDhgUkQAeI0He0y0sSdsC1TNlw/ygwALC?=
 =?us-ascii?Q?PQqPjJx+oSweTpK1sp2gEeeJgJqTu/eV3y568f3IyMzeL5Ywr1whOPmKKgQi?=
 =?us-ascii?Q?eobeAc2+rDrYmtp1yZTNWE5WFeyX+R8K0toNeSGvwmhmeY+7/9YgWOYY8XkK?=
 =?us-ascii?Q?wKPtwSag1mN+TsL8HE2DOpSLHQOBzDN4igfMjfUyyHRHwrLODxZB7YHt9kW0?=
 =?us-ascii?Q?Pd36TS7rHCcaRWb+pPwQZ/06TMlkcoaZW58ETbRNyBqT4Hn/lBnZjljVmWpP?=
 =?us-ascii?Q?vuWWsmwnodzU00GOA2vm7sCKpcqdq/vx521ATrRGEZaepbTu8qDM0bEr85P1?=
 =?us-ascii?Q?jYeQrI4Zx56d+WroMPdmjS32ABdKX9gKJghqy6qETbWRKAZSh12+QLpd9q7t?=
 =?us-ascii?Q?allm2brj9xCmQVEe1MHqOO76psFPD+u10Q76UPuReh39JWg8IX8f6G209MUt?=
 =?us-ascii?Q?Skq84V4cEYTvW2NLehcXs4WUiMxdP6kQ/ulqHMEE/oVaGy85GTuHGBZbXo1U?=
 =?us-ascii?Q?8sCCl2nin7aI4DjYy0XdPA6TCPvHqQqazCta3PIW4sxT7/BltEFc+u8gb3FQ?=
 =?us-ascii?Q?gnQ39bl/x3pvDWT40qzYO8T6Q1T5VAyGlm114vHOzzLxf/ekHDdAoekUW3My?=
 =?us-ascii?Q?h+CjEarE59mPXNUdiw08b1QdWsVvARqpnp+9l0ryjL1I0EST00xIE2Z6MtK6?=
 =?us-ascii?Q?ZhZAAPFvtGXGag7qv0iy5LL/1TNmyNkGd3f3dNe7akR5+hQGLWmGwqaMa1SE?=
 =?us-ascii?Q?Nw8PTPYFzi+pZXKiFew+agx/aJbXOQbvAKqDI9H7FS8dWZF2aXsacSEvEp1c?=
 =?us-ascii?Q?Q5azm3svh2t2MFXNG3RBarw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f0ee9d-665e-49fb-564d-08de4d0516e0
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:22:19.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZQoJDWee//0+WqFghoWV4ejzPCo59xOx8SZBE7NqGGbT+fl1DQIIfdMi9yWEaPeb/+feimC0098rHU9rTOogj/L9nCPx4lBWnUja4kAcHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0730

The property is defined as a phandle array referencing an RPMI
performance domain provider, with the domain specifier interpreted
according to the bindings of the referenced RPMI performance controller.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d733c0bd534f..a7c38d078981 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -143,6 +143,13 @@ properties:
       DMIPS/MHz, relative to highest capacity-dmips-mhz
       in the system.
 
+  performance-domains:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle and RPMI performance domain specifier, as defined by the
+      bindings of the referenced RPMI performance controller or provider.
+      (see riscv,rpmi-performance.yaml / riscv,rpmi-mpxy-performance.yaml)
+
 anyOf:
   - required:
       - riscv,isa
-- 
2.43.0


