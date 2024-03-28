Return-Path: <linux-pm+bounces-5317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A734D88A74C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D26E1F64E58
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86B153BE4;
	Mon, 25 Mar 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bWcR5fp0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3214E2E0
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372638; cv=none; b=Xi8jHA/d+3Q/8q1NZLH9WkerGIzTRDw0baA/LKco1E55uvf1QDsR5VCfbqGXI8Yf1yjArU/ruNOo62Cveq/UinCNaArITZS6gAgeCxaIDnz6ttGJoHq11PMDU6WOHiHLsfAiiF+7ziZ11lvfYbC8cBoz+pAbU3IXAc3ca5FMpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372638; c=relaxed/simple;
	bh=ItVOWrm+zmPgwU0jiuXsWbAoFc6imFhaKj9fNGvBoW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmc33OY3CqjjkjxAYOfMbLg21B9h9HzqfvaOhqgFj0WxFgW8D6nb2s/u4XaTKqGFn7AGjdpG7aZPCvJGKvEztn6xO0bMHcWztdUtt2+w0c/W2ZNj7jD8MqcJTwEKFtN45UlpwrRET6H+9AmBcHBQscPE2dZKWjqr3GuBF6uNCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bWcR5fp0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34175878e30so3081830f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372633; x=1711977433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLRQo0XRS8LZDKEz8aQDPJI24t7vYnPhkxLETHKtHpE=;
        b=bWcR5fp0NQgNFHcaVtEWPyXRuGcrCYFsF3e5IzYI5bbaNUXdykaznXyU8VBsquqnUK
         sijtnJawadYMyWeDdf7RMcWkLDL/hUjhpPISDA0H48hWgQG+IOUJMkchQbmvfqFWHuCu
         1TgAZ3L4Gh7aYbA01yubsxwvggwLySBp50+L1b5JQkvLc3DHWycVGKROH1GqT0SI12V8
         klpS+S5e+I83W3kF7RlbHLxT3SkkoUN3ou5mL23SlAKbJljPMj1EnGu2t9XRtq5MzWcl
         LhgXHLlb7i5Efj8DFmaw2SIQTDHCKWYoQzzItkJmY45bvzeXkAZaFen94vbAp7A7D4/P
         zAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372633; x=1711977433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLRQo0XRS8LZDKEz8aQDPJI24t7vYnPhkxLETHKtHpE=;
        b=fQmwa4D4PCnyCtXDt0HA+bpEVUOG2k9Vr2VLQMHaRVNp4BRf1K6nBfByQgku8Z4FVz
         FHLYgTor13NypwZqPyfCG5R5639l2d+sJK+RJplzc8oEBZKzjbVBIrpvoNHKNIY2K2E7
         Mz1SfJnfKORmIhBka6buRgGsmY/uc9uTuEFphpQMTztAXIU85Gl3l6OMxVBZ7P/q8Y8D
         AOL4QqSyqWyGRwTUlJzgPxjFF33jD2yIOEekFRLpXUvHQslcB0AQP8T5CsL80J9AQ2ER
         tAH3jl5QKthsMNY1MYlpRXwQ/Pjk74Txq6vHIfdYSOlZvgD8Zak5OnzRe/+zJTLBA0v0
         LNTA==
X-Forwarded-Encrypted: i=1; AJvYcCU5DIJQw/M94iBpVtViKFSLWTA5tFTvTbICrO6o8NwYkiDXz7QnCmJpJxVhZutOkixOIv+Uxx8LmZxI7ajmPm9QSscqhSxqGO4=
X-Gm-Message-State: AOJu0YzjlGNq4TetK7/YPsCpeOOe9asNsNQOUQOWRve+MpHXTzmJh83e
	nYBTptpeRplbf+G5QcFB3Av/5ls9JrqSTTIRjKkb/Pk0ePNThXTBX6vPTjjZoTA=
X-Google-Smtp-Source: AGHT+IFnBB4ou+MtybFYeGBZFDzE9OJRQ1/N/lDwetqTu850+c2PtigCOW6y2/ygvJYaO6TvQpRrZA==
X-Received: by 2002:a5d:62c3:0:b0:33e:5fbf:ec4a with SMTP id o3-20020a5d62c3000000b0033e5fbfec4amr5030221wrv.64.1711372633464;
        Mon, 25 Mar 2024 06:17:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 11/16] PCI/pwrctl: create platform devices for child OF nodes of the port node
Date: Mon, 25 Mar 2024 14:16:19 +0100
Message-Id: <20240325131624.26023-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for introducing PCI device power control - a set of
library functions that will allow powering-up of PCI devices before
they're detected on the PCI bus - we need to populate the devices
defined on the device-tree.

We are reusing the platform bus as it provides us with all the
infrastructure we need to match the pwrctl drivers against the
compatibles from OF nodes.

These platform devices will be probed by the driver core and bound to
the PCI pwrctl drivers we'll introduce later.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 ++++++++-
 drivers/pci/remove.c | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..17ab41094c4e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
-	if (pci_is_bridge(dev))
+	if (pci_is_bridge(dev)) {
 		of_pci_make_dev_node(dev);
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..fc9db2805888 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -22,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_platform_depopulate(&dev->dev);
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.40.1


