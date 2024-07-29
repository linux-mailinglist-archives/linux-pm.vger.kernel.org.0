Return-Path: <linux-pm+bounces-11558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425F93FB46
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBDF284DC8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E16189F39;
	Mon, 29 Jul 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Mb6tU+dr"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D715F41D;
	Mon, 29 Jul 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270469; cv=none; b=BpK5SFIQScodC7pHML3BlZGlkKsjXY2Q+y6leAc4boa1OkQdWcgSpQymjlPIw38YAr1OQHOCtiLSxo91/UbPlgLef5umCQEjNlkQvl3S4jwY+jSweqrVAC7IKc0IQt4rbQHii1mwh5S9nInoTWd4dQXDeenXMzd5v0nBmdPQKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270469; c=relaxed/simple;
	bh=hJLgcLK0LAh17amECm6JufjVurQetnROU6/BdFAhOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmYAZIgtLv+bVHJ5lrGO5w11596mr9U39Nkcxbm1wDxEL+s9XYFFd2Lhx21PO8S9gUsgqbjo5j0FF3fiLkPNPigyeehkVqhTMDty4CgVuES7hasRIi9P8ytqTIZscwDUjl4yFh46nSMYLrW9OPzgj5pW4rY0FQbNgbGOgD9ztMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Mb6tU+dr reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 601d4a7f5434d95a; Mon, 29 Jul 2024 18:27:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B424677357F;
	Mon, 29 Jul 2024 18:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722270465;
	bh=hJLgcLK0LAh17amECm6JufjVurQetnROU6/BdFAhOdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mb6tU+drgv6Qa9qGDTujR/3u9TDPLtTZf/JnFks6E85TYzD6Nn8m8v3K8mkjvqBFJ
	 hxUCFaojwJgD8MXUIAnLTAxP+VgGu33vtGxnKTTfdcFKjPYrQca3oVkz71/JcRWOsU
	 US5ubi1E5Qf/wTZXgvucsBzyJCDE8dcj4ksS4j9znX66znvXkcgpvn2WnUyoZGHGEr
	 zA0yXAPbg+a6uhSAFQIoGK1r0AzRn8TJdKESTvCrRXQQ5gnB+I21aIS+BIq56QBGlb
	 614PH3t8bqetKoi2rVxNvZY0Ehr10QNKA3jzrbBV2CNBFO37i+9rhVo2D/Rw385HF9
	 o/Id8M34/+L9g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 1/3] thermal: core: Store trip sysfs attributes in
 thermal_trip_desc
Date: Mon, 29 Jul 2024 18:25:03 +0200
Message-ID: <46571375.fMDQidcC6G@rjwysocki.net>
In-Reply-To: <1960840.taCxCBeP46@rjwysocki.net>
References: <1960840.taCxCBeP46@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepudduffevjeejueekhfevtdetteektddvieethfdugfeutdelffettefgvdduhfeunecuffhomhgrihhnpegrthhtrhdrnhgrmhgvpdgrthhtrhdrshhhohifpdgrthhtrhdrshhtohhrvgenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhr
 ghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of allocating memory for trip point sysfs attributes separately,
store them in struct thermal_trip_desc for each trip individually which
allows a few extra memory allocations to be avoided.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h  |   23 ++++----
 drivers/thermal/thermal_sysfs.c |  103 ++++++++++++----------------------------
 2 files changed, 45 insertions(+), 81 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -15,8 +15,20 @@
 #include "thermal_netlink.h"
 #include "thermal_debugfs.h"
 
+struct thermal_attr {
+	struct device_attribute attr;
+	char name[THERMAL_NAME_LENGTH];
+};
+
+struct thermal_trip_attrs {
+	struct thermal_attr type;
+	struct thermal_attr temp;
+	struct thermal_attr hyst;
+};
+
 struct thermal_trip_desc {
 	struct thermal_trip trip;
+	struct thermal_trip_attrs trip_attrs;
 	struct list_head notify_list_node;
 	int notify_temp;
 	int threshold;
@@ -56,9 +68,6 @@ struct thermal_governor {
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
  * @resume:	resume completion
- * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
- * @trip_type_attrs:	attributes for trip points for sysfs: trip type
- * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
  * @num_trips:	number of trip points the thermal zone supports
@@ -102,9 +111,6 @@ struct thermal_zone_device {
 	struct completion removal;
 	struct completion resume;
 	struct attribute_group trips_attribute_group;
-	struct thermal_attr *trip_temp_attrs;
-	struct thermal_attr *trip_type_attrs;
-	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
 	int num_trips;
@@ -188,11 +194,6 @@ int for_each_thermal_governor(int (*cb)(
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
-struct thermal_attr {
-	struct device_attribute attr;
-	char name[THERMAL_NAME_LENGTH];
-};
-
 static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 {
 	return cdev->ops->get_requested_power && cdev->ops->state2power &&
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -382,87 +382,55 @@ static const struct attribute_group *the
  */
 static int create_trip_attrs(struct thermal_zone_device *tz)
 {
-	const struct thermal_trip_desc *td;
+	struct thermal_trip_desc *td;
 	struct attribute **attrs;
-
-	/* This function works only for zones with at least one trip */
-	if (tz->num_trips <= 0)
-		return -EINVAL;
-
-	tz->trip_type_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_type_attrs),
-				      GFP_KERNEL);
-	if (!tz->trip_type_attrs)
-		return -ENOMEM;
-
-	tz->trip_temp_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_temp_attrs),
-				      GFP_KERNEL);
-	if (!tz->trip_temp_attrs) {
-		kfree(tz->trip_type_attrs);
-		return -ENOMEM;
-	}
-
-	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-				      sizeof(*tz->trip_hyst_attrs),
-				      GFP_KERNEL);
-	if (!tz->trip_hyst_attrs) {
-		kfree(tz->trip_type_attrs);
-		kfree(tz->trip_temp_attrs);
-		return -ENOMEM;
-	}
+	int i;
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
-	if (!attrs) {
-		kfree(tz->trip_type_attrs);
-		kfree(tz->trip_temp_attrs);
-		kfree(tz->trip_hyst_attrs);
+	if (!attrs)
 		return -ENOMEM;
-	}
 
+	i = 0;
 	for_each_trip_desc(tz, td) {
-		int indx = thermal_zone_trip_id(tz, &td->trip);
+		struct thermal_trip_attrs *trip_attrs = &td->trip_attrs;
 
 		/* create trip type attribute */
-		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_type", indx);
+		snprintf(trip_attrs->type.name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_type", i);
 
-		sysfs_attr_init(&tz->trip_type_attrs[indx].attr.attr);
-		tz->trip_type_attrs[indx].attr.attr.name =
-						tz->trip_type_attrs[indx].name;
-		tz->trip_type_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
-		attrs[indx] = &tz->trip_type_attrs[indx].attr.attr;
+		sysfs_attr_init(&trip_attrs->type.attr.attr);
+		trip_attrs->type.attr.attr.name = trip_attrs->type.name;
+		trip_attrs->type.attr.attr.mode = S_IRUGO;
+		trip_attrs->type.attr.show = trip_point_type_show;
+		attrs[i] = &trip_attrs->type.attr.attr;
 
 		/* create trip temp attribute */
-		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_temp", indx);
+		snprintf(trip_attrs->temp.name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_temp", i);
 
-		sysfs_attr_init(&tz->trip_temp_attrs[indx].attr.attr);
-		tz->trip_temp_attrs[indx].attr.attr.name =
-						tz->trip_temp_attrs[indx].name;
-		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
+		sysfs_attr_init(&trip_attrs->temp.attr.attr);
+		trip_attrs->temp.attr.attr.name = trip_attrs->temp.name;
+		trip_attrs->temp.attr.attr.mode = S_IRUGO;
+		trip_attrs->temp.attr.show = trip_point_temp_show;
 		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
-			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_temp_attrs[indx].attr.store =
-							trip_point_temp_store;
+			trip_attrs->temp.attr.attr.mode |= S_IWUSR;
+			trip_attrs->temp.attr.store = trip_point_temp_store;
 		}
-		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
+		attrs[i + tz->num_trips] = &trip_attrs->temp.attr.attr;
 
-		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_hyst", indx);
+		snprintf(trip_attrs->hyst.name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_hyst", i);
 
-		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
-		tz->trip_hyst_attrs[indx].attr.attr.name =
-					tz->trip_hyst_attrs[indx].name;
-		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
+		sysfs_attr_init(&trip_attrs->hyst.attr.attr);
+		trip_attrs->hyst.attr.attr.name = trip_attrs->hyst.name;
+		trip_attrs->hyst.attr.attr.mode = S_IRUGO;
+		trip_attrs->hyst.attr.show = trip_point_hyst_show;
 		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
-			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_hyst_attrs[indx].attr.store =
-					trip_point_hyst_store;
+			trip_attrs->hyst.attr.attr.mode |= S_IWUSR;
+			trip_attrs->hyst.attr.store = trip_point_hyst_store;
 		}
-		attrs[indx + tz->num_trips * 2] =
-					&tz->trip_hyst_attrs[indx].attr.attr;
+		attrs[i + 2 * tz->num_trips] = &trip_attrs->hyst.attr.attr;
+		i++;
 	}
 	attrs[tz->num_trips * 3] = NULL;
 
@@ -479,13 +447,8 @@ static int create_trip_attrs(struct ther
  */
 static void destroy_trip_attrs(struct thermal_zone_device *tz)
 {
-	if (!tz)
-		return;
-
-	kfree(tz->trip_type_attrs);
-	kfree(tz->trip_temp_attrs);
-	kfree(tz->trip_hyst_attrs);
-	kfree(tz->trips_attribute_group.attrs);
+	if (tz)
+		kfree(tz->trips_attribute_group.attrs);
 }
 
 int thermal_zone_create_device_groups(struct thermal_zone_device *tz)




