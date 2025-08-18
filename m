Return-Path: <linux-pm+bounces-32500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D723B29B36
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 550957A7A9D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95428750F;
	Mon, 18 Aug 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Ejfms6rg"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E89287266;
	Mon, 18 Aug 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503395; cv=pass; b=eQ2D6dvZm8Fgh/vkJ79GS3UZYFQEbZPP9mVi2toNSm0rXnOUWILiWexcuyFwGm2inCvyNYgrJg6Tp6OlgxL1fMLkANz+JpnSoNvf7IBWWI+h5jPmWJAnJTIAG2/CRTfRM210oSECdS9NeMKkvODxKt2OTAo5KjwdDgNdFBvXqOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503395; c=relaxed/simple;
	bh=STOcfr9kpIp0+CAMrZ593fZOnyRFM2UhBuPuApaF0rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLra7Fto+JGZv+eLtILqjyyQUBS0L53jwWtEgDTNnGih0UhRVNhAwyJaDZB1m5FuyM1mRey8nQkTytgytB8JYUyABh+1DUOZAJbiep2QRUnp4cijusmCjJdUnDxgqsWQkJqHhgwFn+9kcX+LxhLCgNQsSAOnL3mHVMZrC5ux62s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Ejfms6rg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755503380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YPOQyiQzZXF7BjL1Ii00u+6sVYI3xgAeVkxi37Ww+CkEHSFo4BgDodEXzfpNMTFTNrKXgHjuTZGrhDhEGQrDt92hhOZeKZ1pUNvBaANQgrsAssvGCFg5zga6Qx302Mdy0qNFbFPFfgO0HB4ZQCeDCrdM6IQW5NUCAf3cCcrPEKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755503380; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v71hNscntsNElHfK1DeG9/bpCIY/+k/7AMAOxJUUKlE=; 
	b=jepRpt1JfkkVP1u2BrfP/96x19UnvZNa+pBaxMOyXjWwrcmo7H5viWbt4b7yiDlKuSwQjNCHZ3aC+VLs6Zml/0xl5IbwkA5Mg7yMnPN0D9i4KPjLgJkxuQrivqwJWVUVM5eIoajmooLCar1LLYmej9lfPCcfd6UcZ04QoaVyFd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755503380;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=v71hNscntsNElHfK1DeG9/bpCIY/+k/7AMAOxJUUKlE=;
	b=Ejfms6rgpvxnqBcugd3F9yMvH489ENsnfLn+mtnu5VvXjGT/KOM5W79SW5YrQGqa
	0ydtUaz20eJMwmqjVx8Ty/83Dr91Tn3ZeVtBjgT1mSsWGaHsgbCIU8gdhsP0ZiQu6i/
	ambU/3dMRRTdrtiICHU7euNscxRNmaz1XjIGq48xRlXX1fn3Binls8VADVcgkgzhIRe
	HMCAjVswspZVRwkhQ9s4+jVA1DsTwEtphNhew1YCa2x6F8dV1heXP9w3T7X+dI9cwmP
	VX+JC5H8YJDlfH2geKNcuEvEdVGVi0hWb/k5qmoR9FZGTqnCmlePtm8soWpbposg2+R
	3Xm+33gFLg==
Received: by mx.zohomail.com with SMTPS id 1755503377570478.03956771827745;
	Mon, 18 Aug 2025 00:49:37 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] pmdomain: thead: create auxiliary device for rebooting
Date: Mon, 18 Aug 2025 15:49:06 +0800
Message-ID: <20250818074906.2907277-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818074906.2907277-1-uwu@icenowy.me>
References: <20250818074906.2907277-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The reboot / power off operations require communication with the AON
firmware too.

As the driver is already present, create an auxiliary device with name
"reboot" to match that driver, and pass the AON channel by using
platform_data.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/pmdomain/thead/th1520-pm-domains.c | 35 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index 9040b698e7f7f..8285f552897b0 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -129,12 +129,39 @@ static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
 	}
 }
 
-static void th1520_pd_pwrseq_unregister_adev(void *adev)
+static void th1520_pd_unregister_adev(void *adev)
 {
 	auxiliary_device_delete(adev);
 	auxiliary_device_uninit(adev);
 }
 
+static int th1520_pd_reboot_init(struct device *dev, struct th1520_aon_chan *aon_chan)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "reboot";
+	adev->dev.parent = dev;
+	adev->dev.platform_data = aon_chan;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
+					adev);
+}
+
 static int th1520_pd_pwrseq_gpu_init(struct device *dev)
 {
 	struct auxiliary_device *adev;
@@ -169,7 +196,7 @@ static int th1520_pd_pwrseq_gpu_init(struct device *dev)
 		return ret;
 	}
 
-	return devm_add_action_or_reset(dev, th1520_pd_pwrseq_unregister_adev,
+	return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
 					adev);
 }
 
@@ -235,6 +262,10 @@ static int th1520_pd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clean_provider;
 
+	ret = th1520_pd_reboot_init(dev, aon_chan);
+	if (ret)
+		goto err_clean_provider;
+
 	return 0;
 
 err_clean_provider:
-- 
2.50.1


