Return-Path: <linux-pm+bounces-32876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B81B30E33
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B331C20F7F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD272E2679;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5j435qr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED328B4FD;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841289; cv=none; b=GIY24Goxvh8bXvt4anVmNuA19VPRlmpkPonQ1FqdPIyAu/1zy73QjzbY3G+EnRpbGsv0esz1Cxn/WwEw+wk2IX/Muqft9Kc2BLrsEid//eI8dUYRw3MXubIOY+5iAdpcgthkU6xvsk2SYCf3VUWkW0LMxkH98xFDz/cl24dywwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841289; c=relaxed/simple;
	bh=SWllvQUuWXUiZ37XKVOHkxwQQPRk+5jHJR1X7QQbqWU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JG7Y4HkiBfBGu1LwosZGKkGmWcKsGfceIaj/Mdl5VVjtr1QY9iis1nhKbKMgoSqCw2j6Z3sLgMZo0ENzhls+OS2t/ZZjCoxlG7mFZVQo6+fkp7PjTRKV2H2lWq4p2qiMmkSM2xoH/QcVrZpzh8scE7xKxCJ/zWuIoFDW6lI7Rmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5j435qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4FA4C4CEF1;
	Fri, 22 Aug 2025 05:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755841289;
	bh=SWllvQUuWXUiZ37XKVOHkxwQQPRk+5jHJR1X7QQbqWU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C5j435qr4Pj8VO0GCMmm/0ypKQMl7HSaVhfYN5xCQH/qpPo9DacK5T5F9oS+M0TKp
	 8H1h8ty/DB1Zkz7xbceBqro39/dRNmgI69ehsKsG3CnUmUpYBejhyMkrChVkcAkJA6
	 eGCVhz+jMl42iemjHiz3QytcNtmJq6AJvRuKAyFbKo7keecwUaG89HqysDFknHZxuc
	 Adet3E4iRgKeRl4k+aFHRnSoMYYQnj7pEJeBZD+xU8KStkZDQ/ypOf9D72AlvSzUIk
	 p+fGI6tNeTGH1Crq4/TXoZAYkjXD72DBKG28qb8qC9krbAhf9PzJgUr5EbCwQV2+XF
	 DsqzeK65yyBEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9EFCA0EFF;
	Fri, 22 Aug 2025 05:41:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/5] Power: Add power domain driver for S6 S7 S7D
Date: Fri, 22 Aug 2025 13:39:54 +0800
Message-Id: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoCqGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMD3YJc3WIz3WJzIErRtTQ1SDM3MkhMTDZLUQJqKShKTcusABsXHVt
 bCwC3esbIXgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 "hongyu.chen1" <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755841286; l=1213;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=SWllvQUuWXUiZ37XKVOHkxwQQPRk+5jHJR1X7QQbqWU=;
 b=v6zP1X1MiyNWQVfGhjRcfGOC0lt9iG/FSAbPc+2Df+zqZf0YLjimp7/DcF5ze+DfN5jFWSfkw
 C5A8U4wNBWFDDsajqvt6DFrIfF7N0vlKPmgrOvHh1HqITJru5NZz9yJ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add power controller driver support for Amlogic S6 S7 S7D SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
hongyu.chen1 (5):
      dt-bindings: power: add Amlogic S6 S7 S7D power domains
      pmdomain: amlogic: Add support for S6 S7 S7D power domains controller
      arm64: dts: amlogic: s6: add power domain controller node
      arm64: dts: amlogic: s7: add power domain controller node
      arm64: dts: amlogic: s7d: add power domain controller node

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  3 +
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 10 +++
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 10 +++
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 10 +++
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 95 ++++++++++++++++++++++
 include/dt-bindings/power/amlogic,s6-pwrc.h        | 29 +++++++
 include/dt-bindings/power/amlogic,s7-pwrc.h        | 20 +++++
 include/dt-bindings/power/amlogic,s7d-pwrc.h       | 27 ++++++
 8 files changed, 204 insertions(+)
---
base-commit: ffeebf7587f518a3717fad308cf735adbbcaba97
change-id: 20250820-pm-s6-s7-s7d-950f720aac6d

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



