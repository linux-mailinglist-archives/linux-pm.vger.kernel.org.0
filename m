Return-Path: <linux-pm+bounces-34373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7637B518EA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737CD7BA0CB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D007326D67;
	Wed, 10 Sep 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyGzPipj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D3321F24
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513277; cv=none; b=iGJZShY1zmVJCaqwkxai+Tk0MhO5jksH3AHOOSC7veHEyOoyGWPz4hVFDsEf8oMu+cQuyjnlXeu8ZwbKtsNQP5KuSvXbamYvJClPCkaN35NEvmVzkH/Sa0brR+OgdPx8QRyKFGy/BpUgJHTyAxDXdfQ2M0gYsDx8Vr3hdbvulAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513277; c=relaxed/simple;
	bh=MPpGCU42enNG8jc0eIIufnnART3G77o6dPQkm6edfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcYajL8TWPf3Xtl56pQTsbwl7x7sPKPW5/7joyvLwFfqILHGmob8lQKVlNn8FleVv6picGmpn9QtXLTakKM8L3LSbRF/bRWwtt4NuoQCYPZa714LjLXgfLc1ma/QqNpH6nIUFAoRKJr+2FEzym5ikm5Jg81iSQ0hvPL+/8Oq7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyGzPipj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CDDC4CEEB;
	Wed, 10 Sep 2025 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757513277;
	bh=MPpGCU42enNG8jc0eIIufnnART3G77o6dPQkm6edfjE=;
	h=From:To:Cc:Subject:Date:From;
	b=tyGzPipjwowsGl0/Y0hZGa4Wi666+RbPz8WN/Amc90Pr/8+DMyPfvgGghyNZSX+WR
	 3bczBDv/dxBXLwAtFssGc8EbIY51DpljHB0CJuzlTmUoAKKJMMCebkx4ko8G4V8IkV
	 y1A9QnEugb+65xuv4VaLd+je4bzLg/xXzUdqGBbvzIQPW2rclkKH//GU2J20S5gazr
	 SYfXtbwLwL2jXQcaU8f2mxWnKqaOzFGxbV3wuXiMB8cJ8WaITrDKzk9VVWaftuoCOw
	 j0u+zGR6I13lPkFB6CjRF8qQ0/RP1hiGifZQp7XZH90375DsxK9qeL5ho4O4EcydMa
	 kQowTH43KQDkQ==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: intel_dc_ti_battery: Drop no longer relevant comment
Date: Wed, 10 Sep 2025 16:07:54 +0200
Message-ID: <20250910140754.334597-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the comment about not being able to use devm_iio_channel_get().
The code has actually already successfully been switched over to
devm_iio_channel_get(). This is just a no longer applicable left-over
comment, drop it.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/intel_dc_ti_battery.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
index 457d23b689e9..56b0c92e9d28 100644
--- a/drivers/power/supply/intel_dc_ti_battery.c
+++ b/drivers/power/supply/intel_dc_ti_battery.c
@@ -345,11 +345,6 @@ static int dc_ti_battery_probe(struct platform_device *pdev)
 	chip->dev = dev;
 	chip->regmap = pmic->regmap;
 
-	/*
-	 * Note cannot use devm_iio_channel_get because ACPI systems lack
-	 * the device<->channel maps which iio_channel_get will uses when passed
-	 * a non NULL device pointer.
-	 */
 	chip->vbat_channel = devm_iio_channel_get(dev, "VBAT");
 	if (IS_ERR(chip->vbat_channel)) {
 		dev_dbg(dev, "devm_iio_channel_get() ret %ld\n", PTR_ERR(chip->vbat_channel));
-- 
2.51.0


