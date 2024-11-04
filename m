Return-Path: <linux-pm+bounces-16917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606319BAD6C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246CF281010
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00218C028;
	Mon,  4 Nov 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="knON+5fj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m25490.xmail.ntesmail.com (mail-m25490.xmail.ntesmail.com [103.129.254.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AB171E70;
	Mon,  4 Nov 2024 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706532; cv=none; b=NdgBaR4j1KKvHiPhboVSxp2qJk3jRQr0LL3FcYb3/zB6rbelk08QclMwljNqGHrRbsIIz/S9lwcNbJBNImziutsmaOOY0sChTz+lQhQkZfyl2tePNDAE1tfFCCPdLNeSjEv9Q6vLkH1Y+rrk2AMI4KIydYSyx4ZEYyJc13HeMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706532; c=relaxed/simple;
	bh=WgIipT40jl4pYds/OTrMhKqy5XuoM0fRrS/McLLqCTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o2Ot8dz1n4wnq0mvZ418bmfnKsvfEBEqZGHzO4O31rpYmy2n8yW8CtVnF4m0q5RPw8ZeZSjjhDQEBzgQ+FzXSyL5AyfCXDY9TjHjWvHxr32mXC9lSZ2Y3tNEdlNVZ8xUVM4GmCbPrMOvY25weJoHxAwwR1i1IfFIhdqSP7zjN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=knON+5fj; arc=none smtp.client-ip=103.129.254.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b5f864c;
	Mon, 4 Nov 2024 15:33:23 +0800 (GMT+08:00)
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
	linux-pm@vger.kernel.org
Subject: [PATCH v4 4/7] pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
Date: Mon,  4 Nov 2024 15:31:58 +0800
Message-Id: <1730705521-23081-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklDQlZNSUlJQ0IdTBlJQ0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f617bc0309cckunm1b5f864c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6Shw*SjIaQzoSQy0cNSET
	DxgaCjpVSlVKTEhLTEtOTUtOS09OVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhMSUo3Bg++
DKIM-Signature:a=rsa-sha256;
	b=knON+5fjAdt321L8ZYK83S/IHRfMBGfnppWO7IW1kNQsB2SXHHA35Li7L5Hw++Ec/GPNSpXbL9rkvZMlAkP3DMmbNGz9bUNhFUQqKZz1AHKri+fREBUp16I3kgcg+lPB3e08IMqCitqQ4c/p7MONNoi8hSGM3xqS3ozRPlyT0Go=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=0gxErG8feRCKrPWF5GLII5wJeK93Alo3YxFf9uFvuwk=;
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
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pmdomain/core.c   | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7..02bb5c8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -692,6 +692,36 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
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
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -863,6 +893,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 		if (!pm_runtime_suspended(pdd->dev) ||
 			irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
 			not_suspended++;
+
+			/* The device may need its PM domain to stay powered on. */
+			if (to_gpd_data(pdd)->rpm_always_on)
+				return -EBUSY;
 	}
 
 	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b637ec1..30186ad 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -245,6 +245,7 @@ struct generic_pm_domain_data {
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
 	bool hw_mode;
+	bool rpm_always_on;
 	void *data;
 };
 
@@ -277,6 +278,7 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
 int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
 bool dev_pm_genpd_get_hwmode(struct device *dev);
+int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -360,6 +362,11 @@ static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
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


