Return-Path: <linux-pm+bounces-33963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A006EB454A0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654395A51C2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35E3093B2;
	Fri,  5 Sep 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UnSWHfAm"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB850301009;
	Fri,  5 Sep 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067889; cv=pass; b=k1PJ6adyxWK2XGuaWWNMpmZib18zBApCYzURF6HsLd1qeHSswQO29oOSQLVsuCBi/mptUGbOWmkyI9uvV3IXaWSXOkTBHU6dBwsez5iHMlyv5AHwi9ATkDnf2aEt/CsD2LXlrc/FiodJfgrL+3NslXm9EkWqDaenBpoe4jhrmXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067889; c=relaxed/simple;
	bh=3NtQ2mX4QCrkZRpM2GRitWLjN5/5S5c0Gq0f7a8UCZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9wnH8QLZNzDauQ2J32+CpDo8OgJffRuwYfrGvgesXKW4UzgiMJbKG6afMQtsuPs5sbvM61otpu2kqtk1dSxj3fDoBnQE6ph8r/im1R8nd7kNmgWhKGN1qISK+133YXkCta3NXD2tl4T7R9evOjkWzg+9uSZLa/E4zAUVAN8Sq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=UnSWHfAm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757067864; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SuKZyoAwUWFKn7sciDyOB8jFC5iUsDPyz1FIZCDW3txy+Etu6VXei2UlYaf2xP1b6iuMFawC5kuQWb6qkPckdr9nrd2vmO6yJXzhMturuRJHITt63B4b0ZXEUrCCPTaHjApx+p6kBfkI+/hahTQtaLMYZYMiQ8wLN0Yo6FrYBG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757067864; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tD2U/HmgJxBzAQZ2WANquFxFh0SXL7yoKMcGAmneX0U=; 
	b=iIh7mWHrKVxtfKn+7B3Yue8FW+oUjHDd2rhTSpgKc9wNA8j6/ahUKmdP4PeIxPmc0ZVvopxUaW3W2kuTvFSLJAqOIhGf/KtKiGOsEBn1OG94Mkq5zHzDrKKoTZOZFcRrAkYIlBVXp86H6dG8S1j/LU35liFx1xj9ekpJSiDB7Ng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757067864;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=tD2U/HmgJxBzAQZ2WANquFxFh0SXL7yoKMcGAmneX0U=;
	b=UnSWHfAmPsF5kEJY2MbGAr+48Enh3MREpqtahzmiVGlxRHsL1q71jyFIHj2t5SDU
	YjkD/8HLaSCydf0d8i/Kz3zm0tZJZQJw53W8m9DUJ1+pGq54XJmIPwoBf4RgjcfQcwa
	lO3WXHv0FHzftQMGyraThzfVbusLsREmhbmlX5NY=
Received: by mx.zohomail.com with SMTPS id 1757067862443543.6422329389278;
	Fri, 5 Sep 2025 03:24:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 05 Sep 2025 12:23:04 +0200
Subject: [PATCH RFC 08/10] drm/panthor: devfreq: expose get_dev_status and
 make it more generic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-mt8196-gpufreq-v1-8-7b6c2d6be221@collabora.com>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
In-Reply-To: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The only device-specific part of panthor's get_dev_status devfreq
callback is getting the clock frequency. All the other logic surrounding
what it does may be useful for other devfreq implementations however.

Expose it in the panthor_devfreq.h header file, and make it call back
into get_cur_freq instead of poking the common clock framework directly.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 29 +++++++++++++++++------------
 drivers/gpu/drm/panthor/panthor_devfreq.h |  3 +++
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 02eb3ca15d1874e1cbafc6b614b196c5cc75b6a1..d495dd856299826c4bddc205087d8914d01d7fc4 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -43,6 +43,15 @@ static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
 	return err;
 }
 
+static int panthor_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(ptdev->clks.core);
+
+	return 0;
+}
+
 static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)
 {
 	pdevfreq->busy_time = 0;
@@ -50,14 +59,18 @@ static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)
 	pdevfreq->time_last_update = ktime_get();
 }
 
-static int panthor_devfreq_get_dev_status(struct device *dev,
-					  struct devfreq_dev_status *status)
+int panthor_devfreq_get_dev_status(struct device *dev,
+				   struct devfreq_dev_status *status)
 {
 	struct panthor_device *ptdev = dev_get_drvdata(dev);
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
+	struct devfreq_dev_profile *p = pdevfreq->devfreq->profile;
 	unsigned long irqflags;
+	int ret;
 
-	status->current_frequency = clk_get_rate(ptdev->clks.core);
+	ret = p->get_cur_freq(dev, &status->current_frequency);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
 
@@ -79,15 +92,7 @@ static int panthor_devfreq_get_dev_status(struct device *dev,
 
 	return 0;
 }
-
-static int panthor_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
-{
-	struct panthor_device *ptdev = dev_get_drvdata(dev);
-
-	*freq = clk_get_rate(ptdev->clks.core);
-
-	return 0;
-}
+EXPORT_SYMBOL(panthor_devfreq_get_dev_status);
 
 static struct devfreq_dev_profile panthor_devfreq_profile = {
 	.timer = DEVFREQ_TIMER_DELAYED,
diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
index e8b5ccddd45c52ee3215e9c84c6ebd9109640282..a891cb5fdc34636444f141e10f5d45828fc35b51 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.h
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
@@ -52,6 +52,9 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev);
 void panthor_devfreq_record_busy(struct panthor_device *ptdev);
 void panthor_devfreq_record_idle(struct panthor_device *ptdev);
 
+int panthor_devfreq_get_dev_status(struct device *dev,
+				   struct devfreq_dev_status *status);
+
 unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
 
 #endif /* __PANTHOR_DEVFREQ_H__ */

-- 
2.51.0


