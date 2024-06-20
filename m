Return-Path: <linux-pm+bounces-9714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569E9115B1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 00:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E79283E9E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6679949;
	Thu, 20 Jun 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ge2HQb+5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734613C699
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922238; cv=none; b=bSylLKlC4bX9iuwgV4D0wZ+kCbwHxpQqh0UK3VGf9aTDkOmvJJ3xIwjn79qHio3KVwpRCgXI9Y3l5hS5hD1QERtRKpmPDQiyZduURZ/C5WAiRjWuWSlXz4wsZmkix8zcEMGyFG2mbE/A3Vhrh4uPhStz/MJSQxbcbHG1VGaPLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922238; c=relaxed/simple;
	bh=yWvDNUnycsvNLcY1fv9zSc+31qHIwCJyqw3hyXvVbPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TQ2Rs7bh4aJ/JwLvtVztQAen+QO1CfLhsx3IxFaCOUXDZnRoVQIKgAj4+F8mp57Rhbj8hDBEuDr90dBmF7LuCAZavWvZwDD2uGSivJWEKtVJeDLQrOeRBcCxltkLs8UqfRZyN3Kbrl4DjtiT66/rwQSAgMUVdeUnnGzdz+JPWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ge2HQb+5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebd421a931so13843561fa.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718922233; x=1719527033; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95cGvsTIxxoPqHVnj/dsaZr+AEgSGPbzLZmmEJChD/k=;
        b=ge2HQb+5CUktXMICqyaMQ5878VJRap5yBrX/o262PTEiVoq3c9pmmDQvk+0hx0aMW2
         7eAKsvo0CKZ1Q7tN3wmrwLd5FNKqdyuaGbr/NMocVLFo0AuYo+H7e//1vn/KKLpqe0px
         pG7uZKlzwX8lTknS1wqv4ixiSucWkzrmzL6M9lK1Gat3/yBHL9qki4h5A57TgAzRZLrp
         NBOwSW8rMRoM0UdxW6I3GcSnLWGP7nTRAog8y1eaVcCtZ75XN+8hqyimONHU4qrAFoMf
         F6fMM4dnv+thZ0hmvYRwJwhryaHDN8s3xH6VJz54z1Opu9dcbTYYhZGTDtuoUFcLXGyZ
         lzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922233; x=1719527033;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95cGvsTIxxoPqHVnj/dsaZr+AEgSGPbzLZmmEJChD/k=;
        b=aYifDh0YfwnrQTQr6MKV5IaREeCq/V5DVtZoo8Ek8HAZAiRXYmx+HuKoCHvm7tLW/n
         Q0fwM+dnlfEPpN+xz0rBrjTcOc1WHobMTmxMO/teGJZ1pv8zrlSsWHCwfLAyLC67xQ62
         q9aLkYgpdmXpqZHKWa8Ss9I+PcgsK7gX9DkRqHf20y56LsPQSAYDU5iMRVnj8TancXMB
         XOKb/PwK0F17w255VOG83wkxHq3EVk1uR73ysBxtV2y+CBc7YcbYx/bY8I1Gy9xTRLwD
         PSqWEkWuBxRGkR7c9lG7UZZ1DdaUOOH+epfTuJb+2FZXPnVEUcdVAcweZBFZi5Q6gHKx
         Szlw==
X-Gm-Message-State: AOJu0YzNO30l6tZ/EO0YbhiNCgVLp8vb7CwoI+/WIUSnCCYfaf3bUB7p
	cEoIT24tJaT/x0RSjFP0KLAIR1s4CROkVZOp5HETUgizuJ6n+zE6rxBHFcyDyKU=
X-Google-Smtp-Source: AGHT+IEH8QzReGIpzV4n3StJJcq4V4kD3jaaLDyLKlDq1I9VS4r4QDfxRATirFqHwJbvtHlKIiHKFQ==
X-Received: by 2002:a05:651c:20f:b0:2ea:e57c:a55b with SMTP id 38308e7fff4ca-2ec3cea2b52mr43643171fa.31.1718922233413;
        Thu, 20 Jun 2024 15:23:53 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d76f683sm416451fa.125.2024.06.20.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:23:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 01:23:51 +0300
Subject: [PATCH v8] power: supply: lenovo_yoga_c630_battery: add Lenovo
 C630 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240621-yoga-ec-driver-v8-1-daae67d0233d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPardGYC/3XPzUrEMBQF4FcZsjYl/z+ufA9xcdMkbdBpJC3BM
 vTdzQyIleDyLL5zz72hNZQUVvR8uaESalpTXlowTxc0zrBMASffMmKECSKZxnueAIcR+5JqKFi
 r6HWU3kMwqKHPEmL6ehS+vrUcS77ibS4Bfmo4YURSyQyxA2OcC64wxf6atrIPDsq+zu+5vnykB
 UoecpnutXNat1z2x8zK7+X/LqocE8yZBmsk9eDlueo+qYqzN50XzYsIxkeAoJ3qvPz1ivT3ZfM
 URkuBOMFZ79XJU9Z51bwJWjlo9YLbzuuzF53XzdtInHWCtAf+3j+O4xsoVz5j9AEAAA==
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19993;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=yWvDNUnycsvNLcY1fv9zSc+31qHIwCJyqw3hyXvVbPM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmdKv4l7DoBGQQ1ua2QNgMmgbfVSPZh0vsxdFpw
 f2Vzo+oreOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnSr+AAKCRCLPIo+Aiko
 1RsxCACJI37eYWT5YcqcqZZ+kM7V/fP8M/9n6oSET915Ra0eCFml4HN1EqrTGmbDtZnzJxkt7ho
 PFZ1xJG6qOW0ujkdSaFKvJZPsoJb04lZT8jCMORHRoDhX11lvuDdhjcDonot47pyoTBDYuF279T
 qzv3Gk/SiC3MLNrLXx3vCWzREypdKgHHX1JWDQ4xJESyx0oY17EKuAi2NxPsuAOoE3elPMk7299
 +emb2ppqv6jxb00ml/gNKtgePw86HSwE0kGK4Ci6c4/HpFra821y9TDgAlRVPmXq7wMXqAjz2zZ
 0EvPXpu5Ov+WyqZDiQpEnUjUYGsy/oiZrrnI3pO4zNSIHi/A
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
and battery status. Add the driver to read power supply status on the
laptop.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Add power supply support for the Lenovo Yoga C630 driver as handled by
the on-laptop Embedded Controller.

Support for this EC was implemented by Bjorn, who later could not work
on this driver. I've picked this patchset up and updated it following
the pending review comments.

NOTE: the patch depends on the header from the platform driver. Ilpo
Järvinen has created an immutable branch based on v6.10-rc1, please pull
it before merging the patches:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11

  platform: arm64: add Lenovo Yoga C630 WOS EC driver (2024-06-14 12:51:30 +0300)

----------------------------------------------------------------
Immutable branch between pdx86 lenovo c630 branch, power/supply and USB
subsystems due for the v6.11 merge window.

platform-drivers-x86-ib-lenovo-c630-v6.11:
  v6.10-rc1 + platform-drivers-x86-lenovo-c630
for merging into the power/supply and USB subsystems for v6.11.
----------------------------------------------------------------
---
Changes in v8:
- Added missing <linux/cleanup.h> include (Ilpo)
- Dropped rogue dependency on OF of the PSY driver (Sebastian)
- Split the remaining patchset per the maintainer
- Link to v7: https://lore.kernel.org/r/20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org

Changes in v7:
- In PSY driver use guard() instead of scoped_guard() (Ilpo)
- Use switch/case rather than ifs in yoga_c630_ucsi_read() (Ilpo)
- Link to v6: https://lore.kernel.org/r/20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org

Changes in v6:
- Use guard() instead of scoped_guard() (Ilpo)
- Add a define for UCSI version register (Ilpo)
- Added a check to prevent overflowing the address in reg16 read (Ilpo)
- Link to v5: https://lore.kernel.org/r/20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org

Changes in v5:
- Added missing article in the commit message (Bryan)
- Changed yoga_c630_ec_ucsi_get_version() to explicitly set the register
  instead of just incrementing it (Bryan)
- Dropped spurious debugging pr_info (Bryan)
- Added missing includes all over the place (Ilpo)
- Switched to scoped_guard() where it's suitable (Ilpo)
- Defined register bits (Ilpo, Bryan)
- Whitespace cleanup (Ilpo, Bryan)
- Reworked yoga_c630_ucsi_notify() to use switch-case (Bryan)
- Use ternary operators instead of if()s (Ilpo)
- Switched power supply driver to use fwnode (Sebastian)
- Fixed handling of the adapter's type vs usb_type (Sebastian)
- Added SCOPE property to the battery (Sebastian)
- Link to v4: https://lore.kernel.org/r/20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org

Changes in v4:
- Moved bindings to platform/ to follow example of other Acer Aspire1 EC
  (Nikita Travkin)
- Fixed dt validation for EC interrupt pin (Rob Herring)
- Dropped separate 'scale' property (Oliver Neukum)
- Link to v3: https://lore.kernel.org/r/20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org

Changes in v3:
- Split the driver into core and power supply drivers,
- Added UCSI driver part, handling USB connections,
- Fixed Bjorn's address in DT bindings (Brian Masney)
- Changed power-role for both ports to be "dual" per UCSI
- Link to v2: https://lore.kernel.org/linux-arm-msm/20230205152809.2233436-1-dmitry.baryshkov@linaro.org/

Changes in v2:
- Dropped DP support for now, as the bindings are in process of being
  discussed separately,
- Merged dt patch into the same patchseries,
- Removed the fixed serial number battery property,
- Fixed indentation of dt bindings example,
- Added property: reg and unevaluatedProperties to the connector
  bindings.
- Link to v1: https://lore.kernel.org/linux-arm-msm/20220810035424.2796777-1-bjorn.andersson@linaro.org/
---
 drivers/power/supply/Kconfig                    |   9 +
 drivers/power/supply/Makefile                   |   1 +
 drivers/power/supply/lenovo_yoga_c630_battery.c | 501 ++++++++++++++++++++++++
 3 files changed, 511 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..75b4f65c7d77 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
 	help
 	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
 
+config BATTERY_LENOVO_YOGA_C630
+	tristate "Lenovo Yoga C630 battery"
+	depends on EC_LENOVO_YOGA_C630
+	help
+	  This driver enables battery support on the Lenovo Yoga C630 laptop.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called lenovo_yoga_c630_battery.
+
 config BATTERY_PMU
 	tristate "Apple PMU battery"
 	depends on PPC32 && ADB_PMU
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..8ebbdcf92dac 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
 obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
 obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
+obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/power/supply/lenovo_yoga_c630_battery.c
new file mode 100644
index 000000000000..d4d422cc5353
--- /dev/null
+++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *    Bjorn Andersson
+ *    Dmitry Baryshkov
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/power_supply.h>
+#include <linux/platform_data/lenovo-yoga-c630.h>
+
+struct yoga_c630_psy {
+	struct yoga_c630_ec *ec;
+	struct device *dev;
+	struct fwnode_handle *fwnode;
+	struct notifier_block nb;
+
+	/* guards all battery properties and registration of power supplies */
+	struct mutex lock;
+
+	struct power_supply *adp_psy;
+	struct power_supply *bat_psy;
+
+	unsigned long last_status_update;
+
+	bool adapter_online;
+
+	bool unit_mA;
+
+	bool bat_present;
+	unsigned int bat_status;
+	unsigned int design_capacity;
+	unsigned int design_voltage;
+	unsigned int full_charge_capacity;
+
+	unsigned int capacity_now;
+	unsigned int voltage_now;
+
+	int current_now;
+	int rate_now;
+};
+
+#define LENOVO_EC_CACHE_TIME		(10 * HZ)
+
+#define LENOVO_EC_ADPT_STATUS		0xa3
+#define LENOVO_EC_ADPT_STATUS_PRESENT		BIT(7)
+#define LENOVO_EC_BAT_ATTRIBUTES	0xc0
+#define LENOVO_EC_BAT_ATTRIBUTES_UNIT_IS_MA	BIT(1)
+#define LENOVO_EC_BAT_STATUS		0xc1
+#define LENOVO_EC_BAT_STATUS_DISCHARGING	BIT(0)
+#define LENOVO_EC_BAT_STATUS_CHARGING		BIT(1)
+#define LENOVO_EC_BAT_REMAIN_CAPACITY	0xc2
+#define LENOVO_EC_BAT_VOLTAGE		0xc6
+#define LENOVO_EC_BAT_DESIGN_VOLTAGE	0xc8
+#define LENOVO_EC_BAT_DESIGN_CAPACITY	0xca
+#define LENOVO_EC_BAT_FULL_CAPACITY	0xcc
+#define LENOVO_EC_BAT_CURRENT		0xd2
+#define LENOVO_EC_BAT_FULL_FACTORY	0xd6
+#define LENOVO_EC_BAT_PRESENT		0xda
+#define LENOVO_EC_BAT_PRESENT_IS_PRESENT	BIT(0)
+#define LENOVO_EC_BAT_FULL_REGISTER	0xdb
+#define LENOVO_EC_BAT_FULL_REGISTER_IS_FACTORY	BIT(0)
+
+static int yoga_c630_psy_update_bat_info(struct yoga_c630_psy *ecbat)
+{
+	struct yoga_c630_ec *ec = ecbat->ec;
+	int val;
+
+	lockdep_assert_held(&ecbat->lock);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_PRESENT);
+	if (val < 0)
+		return val;
+	ecbat->bat_present = !!(val & LENOVO_EC_BAT_PRESENT_IS_PRESENT);
+	if (!ecbat->bat_present)
+		return val;
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
+	if (val < 0)
+		return val;
+	ecbat->unit_mA = val & LENOVO_EC_BAT_ATTRIBUTES_UNIT_IS_MA;
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_CAPACITY);
+	if (val < 0)
+		return val;
+	ecbat->design_capacity = val * 1000;
+
+	/*
+	 * DSDT has delays after most of EC reads in these methods.
+	 * Having no documentation for the EC we have to follow and sleep here.
+	 */
+	msleep(50);
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_VOLTAGE);
+	if (val < 0)
+		return val;
+	ecbat->design_voltage = val;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_FULL_REGISTER);
+	if (val < 0)
+		return val;
+	val = yoga_c630_ec_read16(ec,
+				  val & LENOVO_EC_BAT_FULL_REGISTER_IS_FACTORY ?
+				  LENOVO_EC_BAT_FULL_FACTORY :
+				  LENOVO_EC_BAT_FULL_CAPACITY);
+	if (val < 0)
+		return val;
+
+	ecbat->full_charge_capacity = val * 1000;
+
+	if (!ecbat->unit_mA) {
+		ecbat->design_capacity *= 10;
+		ecbat->full_charge_capacity *= 10;
+	}
+
+	return 0;
+}
+
+static int yoga_c630_psy_maybe_update_bat_status(struct yoga_c630_psy *ecbat)
+{
+	struct yoga_c630_ec *ec = ecbat->ec;
+	int current_mA;
+	int val;
+
+	guard(mutex)(&ecbat->lock);
+	if (time_before(jiffies, ecbat->last_status_update + LENOVO_EC_CACHE_TIME))
+		return 0;
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_STATUS);
+	if (val < 0)
+		return val;
+	ecbat->bat_status = val;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_REMAIN_CAPACITY);
+	if (val < 0)
+		return val;
+	ecbat->capacity_now = val * 1000;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_VOLTAGE);
+	if (val < 0)
+		return val;
+	ecbat->voltage_now = val * 1000;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_CURRENT);
+	if (val < 0)
+		return val;
+	current_mA = sign_extend32(val, 15);
+	ecbat->current_now = current_mA * 1000;
+	ecbat->rate_now = current_mA * (ecbat->voltage_now / 1000);
+
+	msleep(50);
+
+	if (!ecbat->unit_mA)
+		ecbat->capacity_now *= 10;
+
+	ecbat->last_status_update = jiffies;
+
+	return 0;
+}
+
+static int yoga_c630_psy_update_adapter_status(struct yoga_c630_psy *ecbat)
+{
+	struct yoga_c630_ec *ec = ecbat->ec;
+	int val;
+
+	guard(mutex)(&ecbat->lock);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
+	if (val < 0)
+		return val;
+
+	ecbat->adapter_online = !!(val & LENOVO_EC_ADPT_STATUS_PRESENT);
+
+	return 0;
+}
+
+static bool yoga_c630_psy_is_charged(struct yoga_c630_psy *ecbat)
+{
+	if (ecbat->bat_status != 0)
+		return false;
+
+	if (ecbat->full_charge_capacity <= ecbat->capacity_now)
+		return true;
+
+	if (ecbat->design_capacity <= ecbat->capacity_now)
+		return true;
+
+	return false;
+}
+
+static int yoga_c630_psy_bat_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
+	int rc = 0;
+
+	if (!ecbat->bat_present && psp != POWER_SUPPLY_PROP_PRESENT)
+		return -ENODEV;
+
+	rc = yoga_c630_psy_maybe_update_bat_status(ecbat);
+	if (rc)
+		return rc;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (ecbat->bat_status & LENOVO_EC_BAT_STATUS_DISCHARGING)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (ecbat->bat_status & LENOVO_EC_BAT_STATUS_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (yoga_c630_psy_is_charged(ecbat))
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = ecbat->bat_present;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = ecbat->design_voltage;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = ecbat->design_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+		val->intval = ecbat->full_charge_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		val->intval = ecbat->capacity_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = ecbat->current_now;
+		break;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		val->intval = ecbat->rate_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = ecbat->voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "PABAS0241231";
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Compal";
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static enum power_supply_property yoga_c630_psy_bat_mA_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static enum power_supply_property yoga_c630_psy_bat_mWh_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mA = {
+	.name = "yoga-c630-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = yoga_c630_psy_bat_mA_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mA_properties),
+	.get_property = yoga_c630_psy_bat_get_property,
+};
+
+static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mWh = {
+	.name = "yoga-c630-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = yoga_c630_psy_bat_mWh_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mWh_properties),
+	.get_property = yoga_c630_psy_bat_get_property,
+};
+
+static int yoga_c630_psy_adpt_get_property(struct power_supply *psy,
+					  enum power_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	ret = yoga_c630_psy_update_adapter_status(ecbat);
+	if (ret < 0)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ecbat->adapter_online;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = POWER_SUPPLY_USB_TYPE_C;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property yoga_c630_psy_adpt_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static const enum power_supply_usb_type yoga_c630_psy_adpt_usb_type[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+};
+
+static const struct power_supply_desc yoga_c630_psy_adpt_psy_desc = {
+	.name = "yoga-c630-adapter",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = yoga_c630_psy_adpt_usb_type,
+	.num_usb_types = ARRAY_SIZE(yoga_c630_psy_adpt_usb_type),
+	.properties = yoga_c630_psy_adpt_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_psy_adpt_properties),
+	.get_property = yoga_c630_psy_adpt_get_property,
+};
+
+static int yoga_c630_psy_register_bat_psy(struct yoga_c630_psy *ecbat)
+{
+	struct power_supply_config bat_cfg = {};
+
+	bat_cfg.drv_data = ecbat;
+	bat_cfg.fwnode = ecbat->fwnode;
+	ecbat->bat_psy = power_supply_register_no_ws(ecbat->dev,
+						     ecbat->unit_mA ?
+						     &yoga_c630_psy_bat_psy_desc_mA :
+						     &yoga_c630_psy_bat_psy_desc_mWh,
+						     &bat_cfg);
+	if (IS_ERR(ecbat->bat_psy)) {
+		dev_err(ecbat->dev, "failed to register battery supply\n");
+		return PTR_ERR(ecbat->bat_psy);
+	}
+
+	return 0;
+}
+
+static void yoga_c630_ec_refresh_bat_info(struct yoga_c630_psy *ecbat)
+{
+	bool current_unit;
+
+	guard(mutex)(&ecbat->lock);
+
+	current_unit = ecbat->unit_mA;
+
+	yoga_c630_psy_update_bat_info(ecbat);
+
+	if (current_unit != ecbat->unit_mA) {
+		power_supply_unregister(ecbat->bat_psy);
+		yoga_c630_psy_register_bat_psy(ecbat);
+	}
+}
+
+static int yoga_c630_psy_notify(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct yoga_c630_psy *ecbat = container_of(nb, struct yoga_c630_psy, nb);
+
+	switch (action) {
+	case LENOVO_EC_EVENT_BAT_INFO:
+		yoga_c630_ec_refresh_bat_info(ecbat);
+		break;
+	case LENOVO_EC_EVENT_BAT_ADPT_STATUS:
+		power_supply_changed(ecbat->adp_psy);
+		fallthrough;
+	case LENOVO_EC_EVENT_BAT_STATUS:
+		power_supply_changed(ecbat->bat_psy);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int yoga_c630_psy_probe(struct auxiliary_device *adev,
+				   const struct auxiliary_device_id *id)
+{
+	struct yoga_c630_ec *ec = adev->dev.platform_data;
+	struct power_supply_config adp_cfg = {};
+	struct device *dev = &adev->dev;
+	struct yoga_c630_psy *ecbat;
+	int ret;
+
+	ecbat = devm_kzalloc(&adev->dev, sizeof(*ecbat), GFP_KERNEL);
+	if (!ecbat)
+		return -ENOMEM;
+
+	ecbat->ec = ec;
+	ecbat->dev = dev;
+	mutex_init(&ecbat->lock);
+	ecbat->fwnode = adev->dev.parent->fwnode;
+	ecbat->nb.notifier_call = yoga_c630_psy_notify;
+
+	auxiliary_set_drvdata(adev, ecbat);
+
+	adp_cfg.drv_data = ecbat;
+	adp_cfg.fwnode = ecbat->fwnode;
+	adp_cfg.supplied_to = (char **)&yoga_c630_psy_bat_psy_desc_mA.name;
+	adp_cfg.num_supplicants = 1;
+	ecbat->adp_psy = devm_power_supply_register_no_ws(dev, &yoga_c630_psy_adpt_psy_desc, &adp_cfg);
+	if (IS_ERR(ecbat->adp_psy)) {
+		dev_err(dev, "failed to register AC adapter supply\n");
+		return PTR_ERR(ecbat->adp_psy);
+	}
+
+	scoped_guard(mutex, &ecbat->lock) {
+		ret = yoga_c630_psy_update_bat_info(ecbat);
+		if (ret)
+			goto err_unreg_bat;
+
+		ret = yoga_c630_psy_register_bat_psy(ecbat);
+		if (ret)
+			goto err_unreg_bat;
+	}
+
+	ret = yoga_c630_ec_register_notify(ecbat->ec, &ecbat->nb);
+	if (ret)
+		goto err_unreg_bat;
+
+	return 0;
+
+err_unreg_bat:
+	power_supply_unregister(ecbat->bat_psy);
+	return ret;
+}
+
+static void yoga_c630_psy_remove(struct auxiliary_device *adev)
+{
+	struct yoga_c630_psy *ecbat = auxiliary_get_drvdata(adev);
+
+	yoga_c630_ec_unregister_notify(ecbat->ec, &ecbat->nb);
+	power_supply_unregister(ecbat->bat_psy);
+}
+
+static const struct auxiliary_device_id yoga_c630_psy_id_table[] = {
+	{ .name = YOGA_C630_MOD_NAME "." YOGA_C630_DEV_PSY, },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, yoga_c630_psy_id_table);
+
+static struct auxiliary_driver yoga_c630_psy_driver = {
+	.name = YOGA_C630_DEV_PSY,
+	.id_table = yoga_c630_psy_id_table,
+	.probe = yoga_c630_psy_probe,
+	.remove = yoga_c630_psy_remove,
+};
+
+module_auxiliary_driver(yoga_c630_psy_driver);
+
+MODULE_DESCRIPTION("Lenovo Yoga C630 psy");
+MODULE_LICENSE("GPL");

---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240527-yoga-ec-driver-76fd7f5ddae8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


