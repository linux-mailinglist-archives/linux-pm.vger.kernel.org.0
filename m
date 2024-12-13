Return-Path: <linux-pm+bounces-19215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A8F9F15E2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 20:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2C72831F2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14271EC4C6;
	Fri, 13 Dec 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhNUIDKC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424C1EC014;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118362; cv=none; b=qoLdMBsYl2/XeuOGQ9FMChhRRf/9ikk7fE1l/g69ZiQBmkq08lBOKzcNEsyrUNN0PVK7z5qXYblwgOHbvJec8FVQ+lWfYfWMQPcLNnbs9Dy5l4H+Ntju4O2lvrojGY4YZq1BFUK1tFlD9zGXaRJunbtMnNjIroc2qbQQbfCpbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118362; c=relaxed/simple;
	bh=hR2OWxnI4AiLexpWZFfBMDeP0lHpudXLW6rkM6ur0TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDvIz/RuOqX8ruPcQQaUxiz+/04IVGdXd83hWQprwFFERoGZ38h25EuUTUrrrdMiM3KwxB0dJCesRhpi3qg2er6b2Va8SS0ShIvRDxKhx30TKpawSftgPr4926u1qxoetYOxKys0gY7SSmnuYQDg58bxu4hP0kL4b+/gowPYUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhNUIDKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56AD5C4CED6;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734118361;
	bh=hR2OWxnI4AiLexpWZFfBMDeP0lHpudXLW6rkM6ur0TU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NhNUIDKCSaOKqdoStmKMjeWWK/yO74LY2oC+mp8cMzGkuprfyRYCCXDclP5G+8y6q
	 ixe4oTeAbE+iXcW48h53BiGjstJyVGcAz6884CA5GcIOum3OS1bgTj2n/8KqICuYtM
	 ADTCj2QxjGWAHhTsLACcjsanoHZbakxXGOKqrkPpPXXyLgYQa8aJ6q1OFd/kbLPmJ6
	 bHdHOzActpcMd06X7hHthttFqP5cLlBs/J2TrqWxBUod0GNxgPoWHk7zuwBjMeESm1
	 3wtSBV/xmDUooNQlGdrMp3OvkK8cLmFASk6RshgmTcXYOHJkLr/ssmZ091W2UXGYAe
	 HJirBo90lrCyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4371BE77184;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 13 Dec 2024 20:32:34 +0100
Subject: [PATCH v2 2/2] power: supply: gpio-charger: add support for
 default charge current limit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-default-charge-current-limit-v2-2-45886fce905c@liebherr.com>
References: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
In-Reply-To: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734118360; l=2214;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=8kkaeG3Fu8A0mMHCllTq6XlCfvacmcvVln/ePhFAfLE=;
 b=l1eFTt5Hpnmk4r5m9dimQx/rMfKLcUx4nHVb3uN0U9n72cqYd4WKhxzux+t615DWImfJgTDb9
 PbudIbCxdGEDfRoJiLC8J0+qokkTQ0ruJNf9krtZ2W4wtfsWA8lzBP6
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



