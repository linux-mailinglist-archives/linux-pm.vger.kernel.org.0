Return-Path: <linux-pm+bounces-19415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D369F6034
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 09:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149C9163B85
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B418E047;
	Wed, 18 Dec 2024 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV3Wpu+g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312218D656;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510908; cv=none; b=mDIndNp773wQJZkBtN+eqlBcf+ijaH9AqjpArCJ2Jw/uhuzU//dp6f3Xk1YRhkp2lg2ETas1mwTFx9I9GejoW62c9LYzvBiUFcI899Zyx43XRK2VExKRxXLhemkHIiPxAB3cX7xa0f2Cav6mDd3tYtjLnEd6gGUb4yU8yPxCpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510908; c=relaxed/simple;
	bh=hR2OWxnI4AiLexpWZFfBMDeP0lHpudXLW6rkM6ur0TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAGlpYsSDSsx3Ad+eyTCqrwDWpRKAQ4nr+ZnBDimrzd6gK6AEQZLf7WtF5wcVGFv/RAaK9Ia6EfCW30MNS9zNQQiB4NelNBZnInCtRWnz/9Id3pH2VYcyZRt5G59g+tJCaHSmyZAbbzQOgoCfYntTXYXAP9QQcIE6Zqgk6NNMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV3Wpu+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C920BC4CED0;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734510906;
	bh=hR2OWxnI4AiLexpWZFfBMDeP0lHpudXLW6rkM6ur0TU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lV3Wpu+gas7e5xsp3LkDJNm1AukvecbSnxKgFghuYQMJ9u6xU3x58IZh7DNhy+AtQ
	 CtP9bn9OnGvQteOM/uIrF7A6LbmE7QdoIjox7qZYKM7lQysKc+SF4tLoNMuo3pgthx
	 VI2MVtEy4RV9Q8jYScuwj8uUqByjc0Q61gdueP6hlFiSSeA2yYRN1sQ5HZvcrn9jCW
	 5QSDuEqZqp6SWk2/6U/xzOhBQXABa90JSOyjxigQua5beevD9QTpY99L+G6P/dPcWV
	 kmqxKyJO6oJeSDHmQv+AM52uVJDQg+ITTD/3YNfoeT/fGonP+TvkimmR0Yg4+jYtZz
	 ouqDdoOuyhleA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFFE7718A;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 18 Dec 2024 09:35:01 +0100
Subject: [PATCH v3 2/2] power: supply: gpio-charger: add support for
 default charge current limit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-default-charge-current-limit-v3-2-b26118cf06b5@liebherr.com>
References: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
In-Reply-To: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734510905; l=2214;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=8kkaeG3Fu8A0mMHCllTq6XlCfvacmcvVln/ePhFAfLE=;
 b=BsFCVnrWbJa0Tq6woukkKhmEd6zHKDqChEwZAYq1d4oKSBXaRfVP4dP/WQgR2xOle8V6HHKcq
 NBAX9wHlSfpBOzHhNzqzQSd0aGKPoQpLn/b8UWQpV4xPUFcCTbZ0fV+
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

With DT properties charge-current-limit-gpios and
charge-current-limit-mapping one can define charge current limits in uA
using up to 32 GPIOs. At the moment the driver defaults to smallest charge
current limitation for safety reasons. When disabling charging is
supported, which should be common, the driver defaults to non charging on
probe. By having a default, charging can be enabled on probe for such
devices.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/gpio-charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 68212b39785beabfe5536a18fa15bc249f7b1eea..56149545a1dc6004b474cec44984c6dfad3413b5 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -187,6 +187,8 @@ static int init_charge_current_limit(struct device *dev,
 {
 	int i, len;
 	u32 cur_limit = U32_MAX;
+	bool set_def_limit;
+	u32 def_limit;
 
 	gpio_charger->current_limit_gpios = devm_gpiod_get_array_optional(dev,
 		"charge-current-limit", GPIOD_OUT_LOW);
@@ -220,6 +222,9 @@ static int init_charge_current_limit(struct device *dev,
 	if (len < 0)
 		return len;
 
+	set_def_limit = !device_property_read_u32(dev,
+						  "charge-current-limit-default-microamp",
+						  &def_limit);
 	for (i=0; i < gpio_charger->current_limit_map_size; i++) {
 		if (gpio_charger->current_limit_map[i].limit_ua > cur_limit) {
 			dev_err(dev, "charge-current-limit-mapping not sorted by current in descending order\n");
@@ -227,8 +232,16 @@ static int init_charge_current_limit(struct device *dev,
 		}
 
 		cur_limit = gpio_charger->current_limit_map[i].limit_ua;
+		if (set_def_limit && def_limit == cur_limit) {
+			set_charge_current_limit(gpio_charger, cur_limit);
+			return 0;
+		}
 	}
 
+	if (set_def_limit)
+		dev_warn(dev, "charge-current-limit-default-microamp %u not listed in charge-current-limit-mapping\n",
+			 def_limit);
+
 	/* default to smallest current limitation for safety reasons */
 	len = gpio_charger->current_limit_map_size - 1;
 	set_charge_current_limit(gpio_charger,

-- 
2.39.5



