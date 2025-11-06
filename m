Return-Path: <linux-pm+bounces-37493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4B3C38F1D
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 04:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4DB3B70B2
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F5245022;
	Thu,  6 Nov 2025 03:08:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C81AB6F1;
	Thu,  6 Nov 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398532; cv=none; b=CeK8wvuxYCyqZ7MpAKchYAF/JNu05Ce6bmbvsVa9ZKWL7E+ZiQ4NHO+Yzzn7SoVabh8yP0H1et+rnPMoGcUfCc/Nuv/bZ6bfMvfJT6JPBOwTtAzQ+CZzk4v3YVQ6kgyB2Yn7KWra2ux803WSTQrccrZ6MhFYEtyLaxoGBNi7/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398532; c=relaxed/simple;
	bh=diW8lv9rRsCvbXJzj48O9MmS08kAwb3LmvhoFjkcIec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0MglsghLH5KNDfwKHZgShwXecY9NdmVAxEchY9zWBo8NvNyy/4CtbNiJ/AgD4mjYEAAf5i+r3EIX2Cd2/VQsS9NuuTBFzurudaQROU3NVoZyDOhvp3A9snO6wOeNUF+BjN1TCpQiuPnMQnNp9+qkZgvZVq+oIidyzocyFKkT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADXQWwwEQxpWgyhAQ--.7059S2;
	Thu, 06 Nov 2025 11:08:33 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] soc: imx93: fix missing clock disable in remove path
Date: Thu,  6 Nov 2025 11:08:22 +0800
Message-ID: <20251106030822.1139-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXQWwwEQxpWgyhAQ--.7059S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyktFykJw4kCr17Cw48WFg_yoWkKFXEy3
	WUCr9agw43Ar4IvFn5tr1YvwnFqF9Fvrn0gFy0qF13CrWUA3WfZ3yYyr13XFy7Wrs7Aa4D
	AF18Ary7CryxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUe4SrUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkSA2kL5JjfdwAAsp

The remove function never disables clocks that were enabled
in probe when the domain was initially on. The function
pm_genpd_remove() does not invoke the .power_off callback,
so clocks may remain prepared and enabled if the power domain
has not been powered off before removal.

Explicitly disable and unprepare the clocks in
imx93_pd_remove() to ensure proper resource cleanup.

Fixes: 0a0f7cc25d4a ("soc: imx: add i.MX93 SRC power domain driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/pmdomain/imx/imx93-pd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index d68273330687..da5b7b81dd98 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -91,6 +91,8 @@ static void imx93_pd_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(np);
 	pm_genpd_remove(&domain->genpd);
+	if (!(readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK))
+		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 }
 
 static int imx93_pd_probe(struct platform_device *pdev)
-- 
2.50.1.windows.1


