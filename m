Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFC045321F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhKPM3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:29:55 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38857 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbhKPM3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:29:42 -0500
Received: by mail-lj1-f169.google.com with SMTP id e9so42906655ljl.5;
        Tue, 16 Nov 2021 04:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieVf7eKj9Dxwh6oAOuZ5j/xJ0HObNRApjkdhF8clVTo=;
        b=ttUmrVfTcY4zx2R/F+dxSS/kjchqenN1TTrnTYml+oMd4eOGH6EWgORbfXMGvswkvk
         iMw/sh6Mkiyisk1lMo1jjiJo2T/hufHGu7NPoaoBRMjsEH6G4A9XKxj+Sbevdn6h76eY
         KVRNMslANov+ke0JUhYksgn0l3hb82JtVFFQUTdDgOcVAW6V36PZMtI53cRarK6rqlWF
         xCyJlHEQ5iVxUZ+WTDREDymOIWQEjMSKsn9G9XQkbEwFS+LbJPR1ds5n9yLi/zxX9DR5
         CrQFDK/UTAGQp3xZx4vmjY8wSKXmAPg7qycvoF0RNuFefE5yELFw/v4zoUhMOo/Q1ydc
         n0ig==
X-Gm-Message-State: AOAM530YUnDeRNAu+cbNluyUqjCdQGf5jXN/vVIC+51AKxOvv8xtSEYN
        10S/ufhefEqSXq9Z0CCsEAY=
X-Google-Smtp-Source: ABdhPJzUFR+1LwtwK4LKi7fXgE1y+eHknbo5BV6mjdpFByIawUeDYxCfV+O+BAxHRJS3a+zmM4+oQA==
X-Received: by 2002:a05:651c:49b:: with SMTP id s27mr6367308ljc.404.1637065603266;
        Tue, 16 Nov 2021 04:26:43 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id i18sm1742852lfv.147.2021.11.16.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:26:42 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:26:36 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH v3 4/9] power: supply: Add batinfo getters usable prior
 supply registration
Message-ID: <6645a55c05cf12954f97347ade1cf47ddf62bb86.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3u/lwNdr/EAfOv2G"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3u/lwNdr/EAfOv2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In some cases it is beneficial to be able to query the static battery
node properties prior power_supply registration. The device-tree
parsing does not really depend on psy so add APIs which can
be used without the power-supply. Also, convert APIs to operate on
fwnode while at it.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
RFCv3:
  - New patch
---
 drivers/power/supply/power_supply_core.c | 279 ++++++++++++++---------
 include/linux/power_supply.h             |   5 +
 2 files changed, 176 insertions(+), 108 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index 1a21f692ab81..47176ed2570b 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -562,16 +562,63 @@ struct power_supply *devm_power_supply_get_by_phandle=
(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
=20
+struct psy_int_tuple {
+	int a;
+	int b;
+};
+
+static int get_fwnode_tuple_array(struct device *dev, struct fwnode_handle=
 *fw,
+				  const char *name,
+				  struct psy_int_tuple **tuple, int *num_tuple)
+{
+	int num_values, i, ret;
+	u32 *tmp_table;
+
+	num_values =3D fwnode_property_count_u32(fw, name);
+	if (num_values <=3D 0) {
+		dev_err(dev, "failed to get %s\n", name);
+		return -EINVAL;
+	}
+
+	if (num_values & 0x1)
+		dev_warn(dev, "odd number of '%s' values\n", name);
+
+	tmp_table =3D kcalloc(num_values, sizeof(*tmp_table), GFP_KERNEL);
+	if (!tmp_table)
+		return -ENOMEM;
+
+	*tuple =3D devm_kcalloc(dev, num_values / 2, sizeof(**tuple),
+			       GFP_KERNEL);
+	if (!*tuple) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	ret =3D fwnode_property_read_u32_array(fw, name, tmp_table, num_values);
+	if (ret)
+		goto out;
+
+	*num_tuple =3D num_values / 2;
+	for (i =3D 0; i < *num_tuple; i++) {
+		(*tuple)[i].a =3D tmp_table[i * 2];
+		(*tuple)[i].b =3D tmp_table[i * 2 + 1];
+	}
+
+out:
+	kfree(tmp_table);
+
+	return ret;
+}
+
 #define POWER_SUPPLY_TEMP_DGRD_MAX_VALUES 100
-int power_supply_get_battery_info(struct power_supply *psy,
-				  struct power_supply_battery_info *info)
+int power_supply_dev_get_battery_info(struct device *dev,
+				      struct fwnode_handle *node,
+				      struct power_supply_battery_info *info)
 {
-	struct power_supply_resistance_temp_table *resist_table;
 	u32 *dgrd_table;
-	struct device_node *battery_np;
-	const char *value;
+	struct fwnode_handle *battery_node;
 	int err, len, index;
-	const __be32 *list;
+	const char *value;
+	u32 tuple[2];
=20
 	info->technology                     =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 	info->energy_full_design_uwh         =3D -EINVAL;
@@ -599,21 +646,23 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
 		info->ocv_table_size[index]  =3D -EINVAL;
 	}
=20
-	if (!psy->of_node) {
-		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
-			 __func__);
-		return -ENXIO;
-	}
+	if (!node)
+		node =3D dev_fwnode(dev);
=20
-	battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0);
-	if (!battery_np)
+	if (!node) {
+		dev_err(dev, "no charger node\n");
 		return -ENODEV;
+	}
=20
-	err =3D of_property_read_string(battery_np, "compatible", &value);
-	if (err)
-		goto out_put_node;
+	battery_node =3D fwnode_find_reference(node, "monitored-battery", 0);
+	if (IS_ERR(battery_node)) {
+		dev_err(dev, "No battery node found\n");
+		return PTR_ERR(battery_node);
+	}
+
+	if (fwnode_property_match_string(battery_node, "compatible",
+					 "simple-battery")) {
=20
-	if (strcmp("simple-battery", value)) {
 		err =3D -ENODEV;
 		goto out_put_node;
 	}
@@ -622,8 +671,7 @@ int power_supply_get_battery_info(struct power_supply *=
psy,
 	 * in enum power_supply_property. For reasoning, see
 	 * Documentation/power/power_supply_class.rst.
 	 */
-
-	if (!of_property_read_string(battery_np, "device-chemistry", &value)) {
+	if (!fwnode_property_read_string(battery_node, "device-chemistry", &value=
)) {
 		if (!strcmp("nickel-cadmium", value))
 			info->technology =3D POWER_SUPPLY_TECHNOLOGY_NiCd;
 		else if (!strcmp("nickel-metal-hydride", value))
@@ -638,67 +686,73 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
 		else if (!strcmp("lithium-ion-manganese-oxide", value))
 			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn;
 		else
-			dev_warn(&psy->dev, "%s unknown battery type\n", value);
+			dev_warn(dev, "%s unknown battery type\n", value);
 	}
=20
-	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
+	fwnode_property_read_u32(battery_node, "energy-full-design-microwatt-hour=
s",
 			     &info->energy_full_design_uwh);
-	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
+	fwnode_property_read_u32(battery_node, "charge-full-design-microamp-hours=
",
 			     &info->charge_full_design_uah);
-	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
+	fwnode_property_read_u32(battery_node, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
-	of_property_read_u32(battery_np, "voltage-max-design-microvolt",
+	fwnode_property_read_u32(battery_node, "voltage-max-design-microvolt",
 			     &info->voltage_max_design_uv);
-	of_property_read_u32(battery_np, "trickle-charge-current-microamp",
+	fwnode_property_read_u32(battery_node, "trickle-charge-current-microamp",
 			     &info->tricklecharge_current_ua);
-	of_property_read_u32(battery_np, "precharge-current-microamp",
+	fwnode_property_read_u32(battery_node, "precharge-current-microamp",
 			     &info->precharge_current_ua);
-	of_property_read_u32(battery_np, "precharge-upper-limit-microvolt",
+	fwnode_property_read_u32(battery_node, "precharge-upper-limit-microvolt",
 			     &info->precharge_voltage_max_uv);
-	of_property_read_u32(battery_np, "charge-term-current-microamp",
+	fwnode_property_read_u32(battery_node, "charge-term-current-microamp",
 			     &info->charge_term_current_ua);
-	of_property_read_u32(battery_np, "re-charge-voltage-microvolt",
+	fwnode_property_read_u32(battery_node, "re-charge-voltage-microvolt",
 			     &info->charge_restart_voltage_uv);
-	of_property_read_u32(battery_np, "over-voltage-threshold-microvolt",
+	fwnode_property_read_u32(battery_node, "over-voltage-threshold-microvolt",
 			     &info->overvoltage_limit_uv);
-	of_property_read_u32(battery_np, "constant-charge-current-max-microamp",
+	fwnode_property_read_u32(battery_node, "constant-charge-current-max-micro=
amp",
 			     &info->constant_charge_current_max_ua);
-	of_property_read_u32(battery_np, "constant-charge-voltage-max-microvolt",
+	fwnode_property_read_u32(battery_node, "constant-charge-voltage-max-micro=
volt",
 			     &info->constant_charge_voltage_max_uv);
-	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
+	fwnode_property_read_u32(battery_node, "factory-internal-resistance-micro=
-ohms",
 			     &info->factory_internal_resistance_uohm);
=20
-	of_property_read_u32_index(battery_np, "ambient-celsius",
-				   0, &info->temp_ambient_alert_min);
-	of_property_read_u32_index(battery_np, "ambient-celsius",
-				   1, &info->temp_ambient_alert_max);
-	of_property_read_u32_index(battery_np, "alert-celsius",
-				   0, &info->temp_alert_min);
-	of_property_read_u32_index(battery_np, "alert-celsius",
-				   1, &info->temp_alert_max);
-	of_property_read_u32_index(battery_np, "operating-range-celsius",
-				   0, &info->temp_min);
-	of_property_read_u32_index(battery_np, "operating-range-celsius",
-				   1, &info->temp_max);
-
-	len =3D of_property_count_u32_elems(battery_np, "temp-degrade-table");
+	if (!fwnode_property_read_u32_array(battery_node, "ambient-celsius",
+					    &tuple[0], 2)) {
+		info->temp_ambient_alert_min =3D tuple[0];
+		info->temp_ambient_alert_max =3D tuple[1];
+	}
+
+	if (!fwnode_property_read_u32_array(battery_node, "alert-celsius",
+					    &tuple[0], 2)) {
+		info->temp_alert_min =3D tuple[0];
+		info->temp_alert_max =3D tuple[1];
+	}
+
+	if (!fwnode_property_read_u32_array(battery_node,
+					    "operating-range-celsius",
+					    &tuple[0], 2)) {
+		info->temp_min =3D tuple[0];
+		info->temp_max =3D tuple[1];
+	}
+
+	len =3D fwnode_property_count_u32(battery_node, "temp-degrade-table");
 	if (len =3D=3D -EINVAL)
 		len =3D 0;
 	if (len < 0) {
+		dev_err(dev, "malformed temp-degrade-table %d\n", len);
 		err =3D len;
 		goto out_put_node;
 	}
-	/* table should consist of value pairs - maximum of 100 pairs */
+	/* table should consist of value triplets - maximum of 100 triplets */
 	if (len % 3 || len / 3 > POWER_SUPPLY_TEMP_DGRD_MAX_VALUES) {
-		dev_warn(&psy->dev,
+		dev_warn(dev,
 			 "bad amount of temperature-capacity degrade values\n");
 		err =3D -EINVAL;
 		goto out_put_node;
 	}
 	info->temp_dgrd_values =3D len / 3;
 	if (info->temp_dgrd_values) {
-		info->temp_dgrd =3D devm_kcalloc(&psy->dev,
-					       info->temp_dgrd_values,
+		info->temp_dgrd =3D devm_kcalloc(dev, info->temp_dgrd_values,
 					       sizeof(*info->temp_dgrd),
 					       GFP_KERNEL);
 		if (!info->temp_dgrd) {
@@ -710,12 +764,13 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
 			err =3D -ENOMEM;
 			goto out_put_node;
 		}
-		err =3D of_property_read_u32_array(battery_np,
-						 "temp-degrade-table",
-						 dgrd_table, len);
+		err =3D fwnode_property_read_u32_array(battery_node,
+						     "temp-degrade-table",
+						     dgrd_table, len);
 		if (err) {
-			dev_warn(&psy->dev,
-				 "bad temperature - capacity degrade values %d\n", err);
+			dev_warn(dev,
+			       "bad temperature - capacity degrade values %d\n",
+			       err);
 			kfree(dgrd_table);
 			info->temp_dgrd_values =3D 0;
 			goto out_put_node;
@@ -730,92 +785,100 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
 		kfree(dgrd_table);
 	}
=20
-	len =3D of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
-	if (len < 0 && len !=3D -EINVAL) {
+	len =3D fwnode_property_count_u32(battery_node, "ocv-capacity-celsius");
+	if (len =3D=3D -EINVAL)
+		len =3D 0;
+
+	if (len < 0) {
+		dev_err(dev, "malformed ocv-capacity-celsius table\n");
 		err =3D len;
 		goto out_put_node;
 	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
-		dev_err(&psy->dev, "Too many temperature values\n");
+		dev_err(dev, "Too many temperature values\n");
 		err =3D -EINVAL;
 		goto out_put_node;
 	} else if (len > 0) {
-		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
-					   info->ocv_temp, len);
+		u32 *tmp;
+
+		tmp =3D kcalloc(len, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		fwnode_property_read_u32_array(battery_node,
+					       "ocv-capacity-celsius",
+					       tmp, len);
+		for (index =3D 0; index < len; index++)
+			info->ocv_temp[index] =3D tmp[index];
+
+		kfree(tmp);
 	}
=20
 	for (index =3D 0; index < len; index++) {
-		struct power_supply_battery_ocv_table *table;
 		char *propname;
-		int i, tab_len, size;
=20
 		propname =3D kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
-		list =3D of_get_property(battery_np, propname, &size);
-		if (!list || !size) {
-			dev_err(&psy->dev, "failed to get %s\n", propname);
+
+		err =3D get_fwnode_tuple_array(dev, battery_node, propname,
+					     (struct psy_int_tuple **)
+						&info->ocv_table[index],
+					     &info->ocv_table_size[index]);
+		if (err) {
 			kfree(propname);
-			power_supply_put_battery_info(psy, info);
-			err =3D -EINVAL;
+			power_supply_dev_put_battery_info(dev, info);
 			goto out_put_node;
 		}
-
 		kfree(propname);
-		tab_len =3D size / (2 * sizeof(__be32));
-		info->ocv_table_size[index] =3D tab_len;
-
-		table =3D info->ocv_table[index] =3D
-			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
-		if (!info->ocv_table[index]) {
-			power_supply_put_battery_info(psy, info);
-			err =3D -ENOMEM;
-			goto out_put_node;
-		}
-
-		for (i =3D 0; i < tab_len; i++) {
-			table[i].ocv =3D be32_to_cpu(*list);
-			list++;
-			table[i].capacity =3D be32_to_cpu(*list);
-			list++;
-		}
 	}
=20
-	list =3D of_get_property(battery_np, "resistance-temp-table", &len);
-	if (!list || !len)
-		goto out_put_node;
-
-	info->resist_table_size =3D len / (2 * sizeof(__be32));
-	resist_table =3D info->resist_table =3D devm_kcalloc(&psy->dev,
-							 info->resist_table_size,
-							 sizeof(*resist_table),
-							 GFP_KERNEL);
-	if (!info->resist_table) {
-		power_supply_put_battery_info(psy, info);
-		err =3D -ENOMEM;
+	err =3D get_fwnode_tuple_array(dev, battery_node,
+				     "resistance-temp-table",
+				     (struct psy_int_tuple **)&info->resist_table,
+				     &info->resist_table_size);
+	if (err =3D=3D -ENOMEM) {
+		power_supply_dev_put_battery_info(dev, info);
 		goto out_put_node;
 	}
-
-	for (index =3D 0; index < info->resist_table_size; index++) {
-		resist_table[index].temp =3D be32_to_cpu(*list++);
-		resist_table[index].resistance =3D be32_to_cpu(*list++);
-	}
+	err =3D 0;
=20
 out_put_node:
-	of_node_put(battery_np);
+	fwnode_handle_put(battery_node);
+
 	return err;
+
+}
+EXPORT_SYMBOL_GPL(power_supply_dev_get_battery_info);
+
+int power_supply_get_battery_info(struct power_supply *psy,
+				  struct power_supply_battery_info *info)
+{
+	struct fwnode_handle *fw =3D NULL;
+
+	if (psy->of_node)
+		fw =3D of_fwnode_handle(psy->of_node);
+
+	return power_supply_dev_get_battery_info(&psy->dev, fw, info);
 }
 EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
=20
-void power_supply_put_battery_info(struct power_supply *psy,
-				   struct power_supply_battery_info *info)
+void power_supply_dev_put_battery_info(struct device *dev,
+				       struct power_supply_battery_info *info)
 {
 	int i;
=20
 	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
 		if (info->ocv_table[i])
-			devm_kfree(&psy->dev, info->ocv_table[i]);
+			devm_kfree(dev, info->ocv_table[i]);
 	}
=20
 	if (info->resist_table)
-		devm_kfree(&psy->dev, info->resist_table);
+		devm_kfree(dev, info->resist_table);
+}
+EXPORT_SYMBOL_GPL(power_supply_dev_put_battery_info);
+
+void power_supply_put_battery_info(struct power_supply *psy,
+				   struct power_supply_battery_info *info)
+{
+	power_supply_dev_put_battery_info(&psy->dev, info);
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
=20
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index fbc07d403f41..ef7db73a5bd1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -430,6 +430,11 @@ devm_power_supply_get_by_phandle(struct device *dev, c=
onst char *property)
 { return NULL; }
 #endif /* CONFIG_OF */
=20
+void power_supply_dev_put_battery_info(struct device *dev,
+				       struct power_supply_battery_info *info);
+int power_supply_dev_get_battery_info(struct device *dev,
+				      struct fwnode_handle *node,
+				      struct power_supply_battery_info *info);
 extern int power_supply_get_battery_info(struct power_supply *psy,
 					 struct power_supply_battery_info *info);
 extern void power_supply_put_battery_info(struct power_supply *psy,
--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--3u/lwNdr/EAfOv2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTo3wACgkQeFA3/03a
ocW4IggAjzKDmHOkA+Sa90rjnHucw+hUX/wRfkpvl3YURljECLYZnvIJcKk1/vzA
uGyKeilNbujDYK66S5/f7UdPgilsDigYQRfgEqj85RosKkB6nJ6JxR7oPKoh2PNi
X7cXKHTI4C6QOJMlDAUiyHxi3KBpOFBrMGAiwSAdGGN1paoMowRbQvQ+r7zILFPt
tG0q+5Ov/niFwSPPM/7zNr1OfmabvdjECSf8sbN6kLfSIDcZ2Fecym5wNbwNKvoZ
+hHo+RcWUm52j7mD/w5c43J61UXCw7Aixy8zdvltc7HTBd+MVBO46DtykqAdI7Fa
XDfFXeBnZSr6acTkXS3ndUgt7jYX1g==
=0CCW
-----END PGP SIGNATURE-----

--3u/lwNdr/EAfOv2G--
