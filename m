Return-Path: <linux-pm+bounces-31200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD30B0C40B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E95E3BF0EC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BE2D3EC6;
	Mon, 21 Jul 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJRms9dB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39F3C0C
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100778; cv=none; b=abzU+Ce/OXjE2KLqVufGstpwQU66OaWkDQhpRZKQsiOaM92EcPFzXsJscAsZSBGaLy+TqvMm0EsLaDNx7oGxsOwVuE924lYeAvDlGXHYmIa+++0/32sVRvE0rlfMQrm0OUffM13hP+etQ5SsHPqxRJV/hJdpL64M2ecGTmiCZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100778; c=relaxed/simple;
	bh=Tk2smwb0d1QApv0KNfUc6N9GlTwSpxBpzJ5iXCY2Jvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frowUqF4HD/JF+mEoWroMldgy+xZt2cUXD6kRjPIHUhDWvcO1pavVoXd3iDiwiboK3IZmUa/t1pmUexwAm/vIlPUad7turvyfBVFHRreIGYJr6GPBDE2m+2kEos4CIalXcTE3uZjZ8nNVkHLw9WEl0oxxbUGQAqQy+XwutwLsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJRms9dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845DBC4CEF5;
	Mon, 21 Jul 2025 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753100777;
	bh=Tk2smwb0d1QApv0KNfUc6N9GlTwSpxBpzJ5iXCY2Jvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJRms9dBUUZqowMkRR/2IXnhXJFKjQHvuDfw1LP9TMGEPp/EZH7EYYSFcpRVg2Rjh
	 JDqdy3hip3PESnaJfFHcPjF6nRR+kdkGjxtK00fpBFnOEE3qv9HpfKZoQ5tASnmDBM
	 bQL8MD0AxjoXLJksiC16zWiLT6tEZX+NHSZGIO87YzHI1AUTBbW698q1p7YvTcjG3v
	 cY8SZH5hGNRcUuzgOBTsy0msOTHfmmI1gUteiYIkgMJIMOrKaffIhpthQKquZVXEmy
	 e8Ci0WLP3pB0Hb/MUSykB5XxIvpDTzF5Y9dqCxgNWULw3d8XNv6yjQHp+TBikVB6s4
	 o4WAO/I4Xjp6g==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/5] power: supply: ug3105_battery: Put FG in standby on remove and shutdown
Date: Mon, 21 Jul 2025 14:26:02 +0200
Message-ID: <20250721122605.46724-4-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721122605.46724-1-hansg@kernel.org>
References: <20250721122605.46724-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the fuel-gauge in standby mode when the driver is unbound and on
system shutdown.

This avoids unnecessary battery drain when the system is off.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/ug3105_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 70dd58e121e3..c4d4ac859fa4 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -206,6 +206,8 @@ static struct i2c_driver ug3105_i2c_driver = {
 		.pm = &ug3105_pm_ops,
 	},
 	.probe = ug3105_probe,
+	.remove = ug3105_stop,
+	.shutdown = ug3105_stop,
 	.id_table = ug3105_id,
 };
 module_i2c_driver(ug3105_i2c_driver);
-- 
2.49.0


