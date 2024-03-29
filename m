Return-Path: <linux-pm+bounces-5608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09798914AB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C80D1C232F8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9944C81;
	Fri, 29 Mar 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg998GEA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191144C6A;
	Fri, 29 Mar 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699041; cv=none; b=JaEOMIbX8hHcR+Ilw42gtoGDwjuJBiyr/oenDPouh3Y47rZuSuxJhRPTx6sVOT3YUkxnhwixzzy9xNTe7Ope7bDdt3eRCvtpHkrZgOWRwmDhX5nCrh7mc96Qa+OfG7s96GjCEN2lWSI6qhS2Nbq+hZ1LWEv/uSXXsW7vltZTDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699041; c=relaxed/simple;
	bh=plNjzkSRLh/DaGoqAsb+jmxTjdZudYWUD5TO+9J6Chg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkTL6HUuEmqDVsdUUWvoQYWhSe3fOXal4cmMUk7QFPhe010yZiWLNlHNlZewfxSMSTjKtoCR7ku83609ZxtDU61h3mOFrPyMCo8Ou9GwazMXrljhjNtAw5iw/IBgBw5+YplxlfW7JHYT8/79HiDdN2v+OjusNrMcF3nPWnUl3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg998GEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70149C433B1;
	Fri, 29 Mar 2024 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699040;
	bh=plNjzkSRLh/DaGoqAsb+jmxTjdZudYWUD5TO+9J6Chg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sg998GEAAcB1ZsXJ363xiPAGlBhLGCaCP4KUhipxtOn5JoggHXQFZqd4PElb2mYG5
	 oNc9EQAMyglU4P7wHFtIz+G14jCCPs14YuAwhSbVRkgqWSfApgrx/mizP47BkRVafR
	 LOIREYTr7CjgepPz8f5e8TmXHeonYneA7jzLMOyt43SStxTa04tAay5GQnCY6RHmhF
	 Bn4pCyZMVbCM4DuzhQtEN9SHvku3rA+7YJoiBTqoRSxBf4MTzq+REOjGQKUaOnHzQR
	 GbcgcifTh6HvrsHy9G5QZNaY4TP7YnABlGgHI7qlm//kIBfRDV/GI4Qu83ZKWbW/QW
	 4mKN6EjCBGWtQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	sre@kernel.org,
	alexandre.belloni@bootlin.com
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	pmalani@chromium.org,
	linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: [PATCH 02/18] gpio: cros-ec: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:14 +0800
Message-ID: <20240329075630.2069474-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329075630.2069474-1-tzungbi@kernel.org>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using fallback driver name match, provide ID table[1] for the
primary match.  Also allow automatic module loading by adding
MODULE_DEVICE_TABLE().

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/gpio/gpio-cros-ec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-cros-ec.c b/drivers/gpio/gpio-cros-ec.c
index 842e1c060414..0c09bb54dc0c 100644
--- a/drivers/gpio/gpio-cros-ec.c
+++ b/drivers/gpio/gpio-cros-ec.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -197,11 +198,18 @@ static int cros_ec_gpio_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(dev, gc, cros_ec);
 }
 
+static const struct platform_device_id cros_ec_gpio_id[] = {
+	{ "cros-ec-gpio", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_gpio_id);
+
 static struct platform_driver cros_ec_gpio_driver = {
 	.probe = cros_ec_gpio_probe,
 	.driver = {
 		.name = "cros-ec-gpio",
 	},
+	.id_table = cros_ec_gpio_id,
 };
 module_platform_driver(cros_ec_gpio_driver);
 
-- 
2.44.0.478.gd926399ef9-goog


