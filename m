Return-Path: <linux-pm+bounces-15947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3F9A3C05
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D62BB24F41
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78E202F9A;
	Fri, 18 Oct 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkxPDrGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996D200CA4;
	Fri, 18 Oct 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248561; cv=none; b=OwrJ+8ozY9l9wg9mD9I/d5G4pLSvGeKqKfTblF+NcWX5m8rZLedkMV7ShX9vFLziGK+MaYSAVav4o05Y72V/hbbd8s6Pae1AY7Mw1ljLvdhzFdExHeZrOemrOh9Zga9k+5P5cFwBDO+6ajMoMG1p/Xg19qJXF61T4ZiC10zHOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248561; c=relaxed/simple;
	bh=Xkjy4d53ZyxC4SQCRouYD4HITzPwapOHuevIE3Vm+Oo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6scX8nIOgVAgp8dQ1mXbZp1R9lEws7XnmxaK212PmTbuc3UMyklnKT398ol3uW1RuUccpYrZIXanLZrMeZ82F2iMwaGhEtkV/4VwOUvYqZhWbgmJ8HQOuufrwfws9KUVDMsGsy25bFrHJlnrNAAQBnwwyalTiqcY90jS6ViP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkxPDrGc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so1210511f8f.3;
        Fri, 18 Oct 2024 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248557; x=1729853357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZFlOJNXwxAQ2TJgCN69ClEqy96CSklKV7EGj2px/IY=;
        b=PkxPDrGcuELCTkjJTHCTiZDNKc4Zp6HmGfiqSosRSK0RmMSB/Fxcr9wLJcUmAfkNYn
         g2qhZy4zr751mKzoTy/O+fDXZCCZkxlMv033JKaZ86Y8RUCu7VyF+2J6CePXmmk7oqDF
         PydLaW1dryN/8dmN7XTkoEYHdyaJR1pnDbVHut9bleq9dyOSuXhA6ovvC2s0poqx4A0a
         9tCBEn9aaupv134hmG6xEr69cGugIJnilsrFjQ/z0jx1YjbP+bXdlZm/16vMDcnyOI/6
         +cGuH6WNXJmVj9JQ/NqhMNyjSzFF9fo8FZEOQKtp02RIDYrfvGo5Gv/pT3swIvn9qKjd
         URYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248557; x=1729853357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZFlOJNXwxAQ2TJgCN69ClEqy96CSklKV7EGj2px/IY=;
        b=kDPv60UEneHgPlYg8zLR75NskZpS3a3TsxacKyE6eisH+Npr7P/7PxSiDOUJtvYvVY
         olf2WHTYLwAMr1NP7JKzO8Wp3cevFaY/1wRNhUdzXLt4/Shb7AvXf3V/71EiRTV/duf5
         su191UbrGUViq4qTl+jo7sDI4aghZa9/XmsJileQAPp5ZhEfiqkyY6VBy9zLDaG8Pta5
         mNpprPqkDkariX4Z6SklpMw1MoE+45om0VkfH/EDy9MjT5AdC5EdvtiyCLWaKYD0kPru
         1nOHiD+i4IcxzOqkAtesf93nTizir5dzhT7Yi0fLc9AYqYpILF23nEbsvG2EWY7FCyFr
         uuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfHhxpUqvlTNTuQfpUyO4lqoN3PvjyC7T19W2q8AupXFr+SW2CjSJLLM+GPNqy6AzqVTuFFOCLMsc=@vger.kernel.org, AJvYcCW13RFnzgoCSkaf++hpWYRdRPTr3Ywh0jQNueWyBAxAROjbhrxeOWPUb+U89WecHtyS6B+NmpUaiHWsSNKw@vger.kernel.org, AJvYcCWJSnYekFMPDu4OXEvXDtccmg48QlPswdhwKCQnaJOAvNWIskEkzNZ0G8ImeMH4x2T1w07hWNYPaow7@vger.kernel.org
X-Gm-Message-State: AOJu0YyaROb/Iq7CuOiCZjkId7nGTtUeGv2l1xGQasXslBMVRklP/9dp
	nrtWzV+Pt0JnxvVX+ArE+PmgvAh19JJG8eNJ+1R6+SgtoA3OOuo/
X-Google-Smtp-Source: AGHT+IGCOJLPZ3wkYiux9WLmR1J/5aQsuolmbHpT9L+JknJZhTqsPEtlV08H47nEj0r3+24W73wysw==
X-Received: by 2002:adf:f80e:0:b0:374:c847:852 with SMTP id ffacd0b85a97d-37eab6e4800mr1313169f8f.29.1729248557027;
        Fri, 18 Oct 2024 03:49:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed5f4sm1606240f8f.68.2024.10.18.03.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:49:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v3 2/3] thermal: of: Add devm_thermal_of_zone_register_with_params() variant
Date: Fri, 18 Oct 2024 12:48:05 +0200
Message-ID: <20241018104839.13296-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018104839.13296-1-ansuelsmth@gmail.com>
References: <20241018104839.13296-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b1ae92dcfa8e ("thermal: core: Make struct thermal_zone_device
definition internal") moved the thermal_zone_device struct from global
thermal.h to internal thermal_core.h making the internal variables of
the struct not accessible from the user drivers (without inclusing
thermal_core.h).

One case where the internal variables might be needed is for the
thermal_zone_params in the context of OF probe.

In such case a thermal driver might have default params that can only be
parsed at runtime (example present in EFUSE or derived from other values)
and wants to update the values in the thermal_zone_params for the
thermal device. (to use the helper like get_slope() or get_offset())

To account for this scenario, introduce a variant of
devm_thermal_of_zone_register(),
devm_thermal_of_zone_register_with_params(), that takes and additional
variable and permits to register the thermal device with default
thermal_zone_params.

To follow OF implementation, these params are only treated as default
params and are ignored if a related one is defined in DT. (example a
slope or offset value defined in DT have priority to the default one
passed in a thermal_device_params struct)

This permits to support both implementation, use the helpers and expose
these values in sysfs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Add this patch

 drivers/thermal/thermal_of.c | 67 +++++++++++++++++++++++++++++-------
 include/linux/thermal.h      | 13 +++++++
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..c9a65eb9ee1e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -250,7 +250,7 @@ static void thermal_of_parameters_init(struct device_node *np,
 {
 	int coef[2];
 	int ncoef = ARRAY_SIZE(coef);
-	int prop, ret;
+	int prop;
 
 	tzp->no_hwmon = true;
 
@@ -262,14 +262,11 @@ static void thermal_of_parameters_init(struct device_node *np,
 	 * thermal zone. Thus, we are considering only the first two
 	 * values as slope and offset.
 	 */
-	ret = of_property_read_u32_array(np, "coefficients", coef, ncoef);
-	if (ret) {
-		coef[0] = 1;
-		coef[1] = 0;
+	if (!of_property_read_u32_array(np, "coefficients", coef, ncoef)) {
+		tzp->slope = coef[0];
+		tzp->offset = coef[1];
 	}
 
-	tzp->slope = coef[0];
-	tzp->offset = coef[1];
 }
 
 static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
@@ -458,10 +455,15 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
  * zone properties and registers new thermal zone with those
  * properties.
  *
+ * The passed thermal zone params are treated as default values and ignored if
+ * the related property is found in DT. (DT params have priority to
+ * default values)
+ *
  * @sensor: A device node pointer corresponding to the sensor in the device tree
  * @id: An integer as sensor identifier
  * @data: A private data to be stored in the thermal zone dedicated private area
  * @ops: A set of thermal sensor ops
+ * @tzp: a pointer to the default thermal zone params structure associated with the sensor
  *
  * Return: a valid thermal zone structure pointer on success.
  *	- EINVAL: if the device tree thermal description is malformed
@@ -469,12 +471,12 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
  *	- Other negative errors are returned by the underlying called functions
  */
 static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-							    const struct thermal_zone_device_ops *ops)
+							    const struct thermal_zone_device_ops *ops,
+							    struct thermal_zone_params *tzp)
 {
 	struct thermal_zone_device_ops of_ops = *ops;
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
-	struct thermal_zone_params tzp = {};
 	struct device_node *np;
 	const char *action;
 	int delay, pdelay;
@@ -500,7 +502,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
-	thermal_of_parameters_init(np, &tzp);
+	thermal_of_parameters_init(np, tzp);
 
 	of_ops.bind = thermal_of_bind;
 	of_ops.unbind = thermal_of_unbind;
@@ -511,7 +513,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 			of_ops.critical = thermal_zone_device_critical_reboot;
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     data, &of_ops, &tzp,
+						     data, &of_ops, tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
@@ -566,6 +568,7 @@ static int devm_thermal_of_zone_match(struct device *dev, void *res,
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int sensor_id, void *data,
 							  const struct thermal_zone_device_ops *ops)
 {
+	struct thermal_zone_params tzp = { .slope = 1 };
 	struct thermal_zone_device **ptr, *tzd;
 
 	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
@@ -573,7 +576,7 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
+	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops, &tzp);
 	if (IS_ERR(tzd)) {
 		devres_free(ptr);
 		return tzd;
@@ -586,6 +589,46 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register);
 
+/**
+ * devm_thermal_of_zone_register_with_params - register a thermal tied with the sensor life cycle
+ *					       with default params
+ *
+ * This function is the device version of the thermal_of_zone_register() function.
+ *
+ * @dev: a device structure pointer to sensor to be tied with the thermal zone OF life cycle
+ * @sensor_id: the sensor identifier
+ * @data: a pointer to a private data to be stored in the thermal zone 'devdata' field
+ * @ops: a pointer to the ops structure associated with the sensor
+ * @tzp: a pointer to the default thermal zone params structure associated with the sensor
+ *
+ * The thermal zone params are treated as default values and ignored if the related property is
+ * found in DT. (DT params have priority to default values)
+ */
+struct thermal_zone_device *devm_thermal_of_zone_register_with_params(struct device *dev, int sensor_id,
+								      void *data,
+								      const struct thermal_zone_device_ops *ops,
+								      struct thermal_zone_params *tzp)
+{
+	struct thermal_zone_device **ptr, *tzd;
+
+	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops, tzp);
+	if (IS_ERR(tzd)) {
+		devres_free(ptr);
+		return tzd;
+	}
+
+	*ptr = tzd;
+	devres_add(dev, ptr);
+
+	return tzd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register_with_params);
+
 /**
  * devm_thermal_of_zone_unregister - Resource managed version of
  *				thermal_of_zone_unregister().
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f1155c0439c4..8130e111210d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -180,6 +180,10 @@ struct thermal_zone_params {
 #ifdef CONFIG_THERMAL_OF
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
 							  const struct thermal_zone_device_ops *ops);
+struct thermal_zone_device *devm_thermal_of_zone_register_with_params(struct device *dev, int id,
+								      void *data,
+								      const struct thermal_zone_device_ops *ops,
+								      struct thermal_zone_params *tzp);
 
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
@@ -192,6 +196,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline
+struct thermal_zone_device *devm_thermal_of_zone_register_with_params(struct device *dev, int id,
+								      void *data,
+								      const struct thermal_zone_device_ops *ops,
+								      struct thermal_zone_params *tzp)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
-- 
2.45.2


