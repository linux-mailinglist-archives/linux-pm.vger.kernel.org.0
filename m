Return-Path: <linux-pm+bounces-18988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00679EC58A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DD52850A8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F871C5F1F;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQtqNQ5i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71311C5F0C;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902174; cv=none; b=G6IxB13x9eshP1UEdF7nBLraI8xNYQQ3T5QenbMdPSmYPzzJG4QrSa8+b7Hq2tWyQVTqsCmPge4+iM74OcsJVL2yBCw6OzAuit+qKZuM6OuoGzmACfINHgwaKYi/NtwibseJbRJaLcpCWTqlyghoakzGvTg5DNgynFKM65humGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902174; c=relaxed/simple;
	bh=kE9grQmLn6LHMLUwo50GIjdSNUInWEzzqpTKkKa/hkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWZDScTYEu08I0Y3PQJNCDEnL5b53jkZ6wIGiSqKXxn+aAaH+od6jkqbjSkbODjEdtPIPA2c5e7y+sljFviLq5DHqKVvqCqmNHHXTVWrxTczCAMgaY4ANmgW8eAJRphQ5/nfna2veGJIaBUMFVOUyhNo2k/kW2oO+bI30wDu0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQtqNQ5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46846C4CEDF;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733902174;
	bh=kE9grQmLn6LHMLUwo50GIjdSNUInWEzzqpTKkKa/hkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OQtqNQ5i83nJoTgEiQRuOvahuc+ongdQ8RMDh6WVZcHY6Nt8P2k4hkzeoUaYok5Zl
	 kNnnp/5WUBjy8daGfUrsO9LuUCNdBYWrvWJwGh0qLzHNogLaBEvSpZkyebVhQB+CSt
	 oJU4Gk2KJtMJsh3PtUoL2fz+DvxUZTxlr76+veAKNIgYyyZXPz8iVN+NB5jdFE0Cuu
	 YKYWwVn/I3ilhYHMGL4SfQQeVP/uN53u7y2LLE3iBYji4DmjAxBr9elmO2xIrWCHyI
	 tIJRkeFkt+2H99iiGtxyCQPJHIA5K+juoKMbelGsgJvlp1AqtxBIIv2hp0WGADBFqd
	 io+ch03Tp0ecg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22782E77183;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 11 Dec 2024 08:29:10 +0100
Subject: [PATCH 2/2] power: supply: gpio-charger: add support for default
 charge current limit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-default-charge-current-limit-v1-2-7819ba06ee2a@liebherr.com>
References: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
In-Reply-To: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733902172; l=1905;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=5B4rPOB+5702QfWy45U125DyTvkQjxqeDuDwvqB5EFA=;
 b=l8QShK3uZiH18nY4r7xOEo4cv0gfqVRaW/2J265DhezaihkaAy0HwBwCqQ+G6mRZfyWcwg0Sa
 0VNOLf+2hZQD7E3yzorunI2tX/1KVje4RqETuOmCDQ7PLRD3q3h3ut6
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The driver defaults to smallest current limitation for safety reasons. Add
support for setting default current limitation via DT.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/gpio-charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 68212b39785beabfe5536a18fa15bc249f7b1eea..1c1fce6579464b61dbaf4125d0a91dc34c18c4d0 100644
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
+						  "charge-current-limit-default",
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
+		dev_warn(dev, "charge-current-limit-default %u not listed in charge-current-limit-mapping\n",
+			 def_limit);
+
 	/* default to smallest current limitation for safety reasons */
 	len = gpio_charger->current_limit_map_size - 1;
 	set_charge_current_limit(gpio_charger,

-- 
2.39.5



