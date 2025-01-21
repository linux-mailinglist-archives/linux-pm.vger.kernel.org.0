Return-Path: <linux-pm+bounces-20728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E438A17612
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEEF188A681
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B979148FE6;
	Tue, 21 Jan 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="C+T0xur9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com [45.254.49.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5838831;
	Tue, 21 Jan 2025 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428494; cv=none; b=SO8f4gWi5+Yj4ylNqJEyYugSM5332MOVFKzPzEY0tlxd49fDtEwhh1VxcPoNUZQ6vLkbNLSngsiV8SwFvT8dr/Ma//IpSE598XS7yj3EPg1hZlbvwm68MLHyqd08wR0nPCK94zwZsAMZOcwxNUhWS+uRIVijJx7rO3xe+bhcc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428494; c=relaxed/simple;
	bh=g/nwDZP9SLEI2Vjd99fwinnM0/MNyabMv89OXaCJVow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uawpQ6sphzpxvUcUSLH9PGZsO3fGyU6NV8WLcHxeXAQRaAaoFq4n8AVdikUjlsWZGqepqXuGS9o+sNFisG3A3nR+4WI3Xyd/0F+9hPuZBRP+jgbo+rkP/O/MmTqbwreJcRgXx1lQMN/ZR2yW3ytXIk9ikJMu5tfM/vo8WqpIGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=C+T0xur9; arc=none smtp.client-ip=45.254.49.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 93fdcf00;
	Tue, 21 Jan 2025 11:01:26 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 3/7] pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
Date: Tue, 21 Jan 2025 11:00:23 +0800
Message-Id: <1737428427-32393-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMZGVZIQk9CGUoeQ0NKGBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a9486cec7e909cckunm93fdcf00
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6STo*OTIRNDVNHgstEjEZ
	KQswFExVSlVKTEhMT0lDT0NMTE9LVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhDQk83Bg++
DKIM-Signature:a=rsa-sha256;
	b=C+T0xur92zfdXVdz9scdLgm4Aypk0CBcgFBWQD1SVlAhuFBgchP6VY9J7XQ8zkuGc3bCJEZhwevLSNuGWNm+Yzw+Ah0QPbCEN/cMuunFcWpnSMDJ9FCGI/wLyu+dA0+jOmerKBUQOUXyCs/uhDPe5qVYnWywuzE0ipqN3sVh9PQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=S8k3+QF/U7BZrl92gLsmr2O43MinCweidYG2hgjh7D0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

For some usecases a consumer driver requires its device to remain power-on
from the PM domain perspective during runtime. Using dev PM qos along with
the genpd governors, doesn't work for this case as would potentially
prevent the device from being runtime suspended too.

To support these usecases, let's introduce dev_pm_genpd_rpm_always_on() to
allow consumers drivers to dynamically control the behaviour in genpd for a
device that is attached to it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v6:
- export dev_pm_genpd_rpm_always_on()

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pmdomain/core.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85..b44c300 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -697,6 +697,37 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
 
+/**
+ * dev_pm_genpd_rpm_always_on() - Control if the PM domain can be powered off.
+ *
+ * @dev: Device for which the PM domain may need to stay on for.
+ * @on: Value to set or unset for the condition.
+ *
+ * For some usecases a consumer driver requires its device to remain power-on
+ * from the PM domain perspective during runtime. This function allows the
+ * behaviour to be dynamically controlled for a device attached to a genpd.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Return: Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	genpd_lock(genpd);
+	dev_gpd_data(dev)->rpm_always_on = on;
+	genpd_unlock(genpd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -868,6 +899,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 		if (!pm_runtime_suspended(pdd->dev) ||
 			irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
+
+		/* The device may need its PM domain to stay powered on. */
+		if (to_gpd_data(pdd)->rpm_always_on)
+			return -EBUSY;
 	}
 
 	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 45646bf..d4c4a7c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,6 +260,7 @@ struct generic_pm_domain_data {
 	unsigned int rpm_pstate;
 	unsigned int opp_token;
 	bool hw_mode;
+	bool rpm_always_on;
 	void *data;
 };
 
@@ -292,6 +293,7 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
 int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
 bool dev_pm_genpd_get_hwmode(struct device *dev);
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -375,6 +377,11 @@ static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
 	return false;
 }
 
+static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
+{
+	return -EOPNOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.7.4


