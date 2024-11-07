Return-Path: <linux-pm+bounces-17129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242559C0C2A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543F31C2220B
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229521733B;
	Thu,  7 Nov 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="b9HYVxWD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD12170BD;
	Thu,  7 Nov 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998984; cv=none; b=o7sdWdBlwaCLiJ0O71kcQ8DjbXXX7vuslUtu2MQy/COtgc9eh2KW5NPyWP7QipHZ/uI1ZfZBjKC+QmrXbjpuCGM/qtEOXBHsSnjhFUlWpbqgWNF0elW08t0YkYOLZMm0QW8ZB+GzX7g7I1KdXrP/QqstISR9GqmtGFO9o/3d5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998984; c=relaxed/simple;
	bh=4/3yIerMwWJrV0PgQtDH3R5bMiqTFPqF4LbIqu7XNtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTMCgln4Ldd/IOAamYQhVtzbzKS3G6wccnZ4geENmXKhg+At4VisRSs51kEMajFevy4RKoaLR0MepfkZVf83C6mtNmUh/YDOi+za0FK4qjIf8EM2r+IbEuJOmj/5EV9v+wkwBghfz3e8JZqxEYcAJGzaoaa+QIz9IEzygF2JMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=b9HYVxWD; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id A0E35E45C5;
	Thu,  7 Nov 2024 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cSXtHNT4k7URrcC7KCf7aIwX75O9SVcuiydlyG6cN4=;
	b=b9HYVxWDznwYuZi4XF9UWzgo7T2G7AbHKxNGyzA9bg4KCuEnHKCOS7uU2NZHyAkNJpI7K9
	pIOnXoN9usroW0HzYRkB1gQocw2qm/lg8FZ/CBRvn0OMbPvvVU0qJMmjx1MWJmUefANMFd
	H5Lnt6mY5neGaFD4YoV7OB8RBhHxivLJaz27fW2p+YFQUIUPwGxR5pxgnhGP4b7gYDh8JI
	Z9NhkQHjFvW0jxkztOwvGEUg3YNOEIVv8Fdc0D77YDk73wobzyg/cbX3TIcAZsFDOxVkd6
	EB4K1h7e1ekgygN/D02H66UjG6LNB8XecVyKaeeokqqCX7Gc4RAsPWJMP+/cog==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 07 Nov 2024 18:02:43 +0100
Subject: [PATCH v3 02/14] pinctrl: qcom-pmic-gpio: Add support for PM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-msm8917-v3-2-6ddc5acd978b@mainlining.org>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
In-Reply-To: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998970; l=1136;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=4/3yIerMwWJrV0PgQtDH3R5bMiqTFPqF4LbIqu7XNtA=;
 b=hYAUT/svKEE3ITQ9nUpOqCrhVmG7XwioFmlK4nUk5gjlSWoqKelQEC7PpLxYRnfYMmlu6g2Gn
 rIR00t+BMMeAKVNlEvTNII2x6kXLd/izhXFVriudpGrFhaqXX1xGY/B
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

PM8937 has 8 GPIO-s with holes on GPIO3, GPIO4 and GPIO6.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index d42c812a89a848b2f64c84da1546f48e9e899d4d..a8a154a2ac94e3fc94d2da1710867a6f0a7ae11e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1226,6 +1226,8 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8550ve-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8550vs-gpio", .data = (void *) 6 },
 	{ .compatible = "qcom,pm8916-gpio", .data = (void *) 4 },
+	/* pm8937 has 8 GPIOs with holes on 3, 4 and 6 */
+	{ .compatible = "qcom,pm8937-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8941-gpio", .data = (void *) 36 },
 	/* pm8950 has 8 GPIOs with holes on 3 */
 	{ .compatible = "qcom,pm8950-gpio", .data = (void *) 8 },

-- 
2.47.0


