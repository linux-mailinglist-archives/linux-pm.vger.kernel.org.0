Return-Path: <linux-pm+bounces-31043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9CB09B7A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C231891C70
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461701F542A;
	Fri, 18 Jul 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvTaAumk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F019E97C;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820663; cv=none; b=mq7kLW9ISFQIw/iHip6+1gUspY0Jy2xEyyyqbwHSMygd8btg2ka/7pRwJc2fcbB9Ola6csku57yEaq33NqVbfW0/Uxlq/VK5y1pKvSwi35qc7NNpN7WVl3wh82DPMEKHpswV9E5hxxn6s+2lAGNXtHP6Tkf02kgMKVWYBH4n9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820663; c=relaxed/simple;
	bh=zVwBnOBXZNVDZp8+mClSq+Wz1HDJCHk36NiLbL59xXk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L2dfNVyntHuuf0C3+DipMvg1RAksya8nJcTu26N/8UQWQM0y185dM2f3xqEJNsYm71y2Cbu71p9WgiipFu6+KbMxx8v9rm3R8QJc6FfEvKziXJerD1cdea3saUG/jJmwxWPiqkykVIPHMgj6jml5dws4W5etshiRAwn31vGiPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvTaAumk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FD88C4CEED;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752820662;
	bh=zVwBnOBXZNVDZp8+mClSq+Wz1HDJCHk36NiLbL59xXk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lvTaAumk/nbUCgo8+99L2zAVLaLAVrz7VlKpLaZ4d5UKZmTjnS6SJXT5CKayQYOH4
	 6/pzcEqkCsiAFYMVc3pG2gbJabuJo1lJDWAnKblEqpUe2aesVrXCTFnaRwMotRyAh3
	 CVCsuRExjW1TYB216KWqdeEARpTLSiW577533WfeJtcjLTh/BfSErudIddBvNIORZb
	 L2mX5kXPeVKoDYCwWLkfrhMnx0i9oPVUtz3XkciOlduQZvCusMSOOUwQVAW4zQVMqB
	 ggxbRt81g9WWGeOm1jJXNz5zY/MhGXIjDXTWt6mdoZIhpd0NsJdl/H2I6R6lvIER4E
	 vBsKzSz/gNSVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A45FC83F34;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] thermal: Support Amlogic C3 thermal
Date: Fri, 18 Jul 2025 14:37:40 +0800
Message-Id: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALTreWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0ML3WRj3ZKM1KLcxBzd5LSUNINEo6SkNFMjJaCGgqLUtMwKsGHRsbW
 1AKyiQAxcAAAA
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Liming Xue <liming.xue@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752820661; l=796;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=zVwBnOBXZNVDZp8+mClSq+Wz1HDJCHk36NiLbL59xXk=;
 b=f2ZEHyZc0eY/iGCAhjC75mGOUf1dT5uPNYGLrZJlrqSW9d8wpn88WbDDKbX/o+Nu9e6sLvQQq
 mK90zlJfD/0CV/AGldhcGn9ZEozYGCwKlNAZwk2Ni0u2D/3Q0hccY20
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add Amlogic C3 thermal compatible string, private_data
of driver and device node.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: thermal: amlogic: Add compatible string for C3
      thermal: amlogic: Support C3 thermal controller driver
      arm64: dts: amlogic: c3: Add tempsensor controller node

 .../devicetree/bindings/thermal/amlogic,thermal.yaml          |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi                   | 11 +++++++++++
 drivers/thermal/amlogic_thermal.c                             | 10 ++++++++++
 3 files changed, 22 insertions(+)
---
base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
change-id: 20250718-c3-thermal-cfdf0a2bbf52

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



