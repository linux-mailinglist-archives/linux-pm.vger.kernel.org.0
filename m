Return-Path: <linux-pm+bounces-32801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03967B2F654
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A319C7AF82A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4130DD09;
	Thu, 21 Aug 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="CxfT9eFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7822BD01B;
	Thu, 21 Aug 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775170; cv=none; b=ddtHFZuAlaMDhfVKxxuLpOnexG6vm0CSoVwg6U9Lxw/CuuYOg9fQizk/arypgS2/T/BzcUJSo8pcoogjLRysH36FjDkr4T1+yFo7PWngTWh9RIDnqpg5h+SrtBpwPRuRRwidAfy0YJRrQd4gSK7WN8KLY+Y5XuxwFaJQB6oSwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775170; c=relaxed/simple;
	bh=sZfO0I33cgEm+4dMt0Hj0C6c34cVlAeZrFGi34N8QJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8Qf1HrYNkkc6aLB0Sn7TUuBAspx8aWUApOBKMit+Zzak+PQmU/oW1GZqJ122k9INPa+89KjCXTLNIVNa1P9INASXnzmrzpEwDKgWGTydRXz5+0a2GVZt3J2QVdtUolue9/SveQlcVZZh5KHPU+z3GShp2hB5xc7MtYPiYxDZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=CxfT9eFL; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=bkjygQ4RWB5YIgYQcmBxJ6rnQ07NLsR8LZDpK7ads0U=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755775105; v=1; x=1756207105;
 b=CxfT9eFL4rvOBnLW1jE2TKKw9hAxb2IL/njJ+KTx4fo3hjj7cM2jDUiuaHKeT/V7F5UZSfRa
 eK40zC/915W6zEIOi/NwNXWUKnu4f4Y0xXoahtUqj1jc+IEJZ+qarw5GMmga+xs5/mNVJmJOklT
 P9D4bYEIwiQxpnfwTTiCHncr1koYexKTRRy3cjLRph5cwa+W/xtiv7M0WpxFPxRmqBpfprTPRnn
 G0WnJ86NvCOlYpWLn3zBJCQNdm3TsXo7Pc3LRAzhZa/uAoJntjw1VuYqpdYy3MaNRjso6EoZkLk
 BcoYCemXq92frPp41ZfMKaAoTC/iWr2LE8YM75dW6fqyg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 5c9dea5e; Thu, 21 Aug 2025 13:18:25 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Thu, 21 Aug 2025 13:17:44 +0200
Subject: [PATCH v2 2/4] dt-bindings: power: Add Marvell PXA1908 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-pxa1908-genpd-v2-2-eba413edd526@dujemihanovic.xyz>
References: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
In-Reply-To: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=sZfO0I33cgEm+4dMt0Hj0C6c34cVlAeZrFGi34N8QJA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBnLGerK7fbeUouRVtmkL8VxZSWvtcvRTNFXC7uvP/Xhb
 vjl2SbTUcrCIMbFICumyJL73/Ea72eRrduzlxnAzGFlAhnCwMUpABMpTGX4p68rLSS5tfSu+K5U
 m5nmveynzR6eiWBM/2YXl9k/U8N4B8P/2o8X5hwSf7umzl+49WAO/4XE5MOWJq90EzbdvLXnRis
 3PwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add device tree bindings for Marvell PXA1908's power domains.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v2:
- Drop schema
---
 include/dt-bindings/power/marvell,pxa1908-power.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/dt-bindings/power/marvell,pxa1908-power.h b/include/dt-bindings/power/marvell,pxa1908-power.h
new file mode 100644
index 0000000000000000000000000000000000000000..19b088351af138823505a774ff27203429fe2d97
--- /dev/null
+++ b/include/dt-bindings/power/marvell,pxa1908-power.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Marvell PXA1908 power domains
+ *
+ * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#ifndef __DTS_MARVELL_PXA1908_POWER_H
+#define __DTS_MARVELL_PXA1908_POWER_H
+
+#define PXA1908_POWER_DOMAIN_VPU	0
+#define PXA1908_POWER_DOMAIN_GPU	1
+#define PXA1908_POWER_DOMAIN_GPU2D	2
+#define PXA1908_POWER_DOMAIN_DSI	3
+#define PXA1908_POWER_DOMAIN_ISP	4
+
+#endif

-- 
2.50.1


