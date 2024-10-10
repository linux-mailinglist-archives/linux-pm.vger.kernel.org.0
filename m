Return-Path: <linux-pm+bounces-15499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACA99950F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEE91C22866
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989591E571D;
	Thu, 10 Oct 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cYQJ/t4+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE031BBBC4;
	Thu, 10 Oct 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598957; cv=none; b=kzj2e+qEKy2TmQjmmMY8S+X7VpCCCjJ//xdfkGHjU5DN16AZaLqUPkN4Sh/bsvf8mCkZIu02ssBoBfh6BILjW1TkPbDTfhf3h/F8jVo9L2LNQbFVd7DhhI/rGIY3ga0IOo8BcFiTBUpdTSmSju8hr1t4vg5p8ZNXd5Wxqth9QCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598957; c=relaxed/simple;
	bh=oZ3MkYoI/38gHlsW+UpIxuXSBrs2+RlFIlO9IgUbsic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhmhAU9qu8o10ZcnKYtNLMK1wQTSWXCxcL7tNCMs9xZwANyGhaz+ckNAtAjYo5pIhmgkhaRk00nTc0E3pfcVJjGPhgoewIw7HS50II8/bZszk/mZiLw/irrQePpnJbvWTazKdv5grD6WFSj+YnsJ7BzwlFqaR5kad+/IOpF7XRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cYQJ/t4+; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 75ad9fdc9bd72b61; Fri, 11 Oct 2024 00:22:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 443F669EF02;
	Fri, 11 Oct 2024 00:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598947;
	bh=oZ3MkYoI/38gHlsW+UpIxuXSBrs2+RlFIlO9IgUbsic=;
	h=From:Subject:Date;
	b=cYQJ/t4+wj8QqntZv8ZmaH9qvC0G/hG8bRlYPHU3PB18cxyVG97Zd7Jwgjexxf3jI
	 c6tDQSLkXCa1igl+ix7HJRYoGXeoppWx2Be5WHa/m7cJBZlRwHL9elYUTNAVIVSdRS
	 KbZwFLaMsKuEe2K4YRyAGzXYu0RznTV0PplnCcxyahiuKWopQCXS3NEYAq+ng1vuNp
	 PQFIkaiKsDkpgndrCbXKGwJZQ7EIt37ogrWocxl06KftUpwziqVfEuqKxG/zUCfNHs
	 DrIYAY0/WtL6st1npP2WDcPZr3fp1YLHBOEmUSOUTK6GVYX2aZCvXAhm1HBsRzwy2m
	 /sjno3+aFrhBQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 06/11] thermal: core: Introduce thermal_instance_add()
Date: Fri, 11 Oct 2024 00:13:50 +0200
Message-ID: <3618899.iIbC2pHGDl@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To reduce the number of redundant result checks in
thermal_bind_cdev_to_trip() and make the code in it easier to
follow, move some of it to a new function called thermal_instance_add()
and make thermal_bind_cdev_to_trip() invoke that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/2641944.Lt9SDvczpP@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |   46 ++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -743,6 +743,28 @@ struct thermal_zone_device *thermal_zone
  *				     binding, and unbinding.
  */
 
+static int thermal_instance_add(struct thermal_instance *new_instance,
+				struct thermal_cooling_device *cdev,
+				struct thermal_trip_desc *td)
+{
+	struct thermal_instance *instance;
+
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (instance->cdev == cdev)
+			return -EEXIST;
+	}
+
+	list_add_tail(&new_instance->trip_node, &td->thermal_instances);
+
+	mutex_lock(&cdev->lock);
+
+	list_add_tail(&new_instance->cdev_node, &cdev->thermal_instances);
+
+	mutex_unlock(&cdev->lock);
+
+	return 0;
+}
+
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
@@ -761,7 +783,7 @@ static int thermal_bind_cdev_to_trip(str
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *cool_spec)
 {
-	struct thermal_instance *dev, *instance;
+	struct thermal_instance *dev;
 	bool upper_no_limit;
 	int result;
 
@@ -823,23 +845,15 @@ static int thermal_bind_cdev_to_trip(str
 	if (result)
 		goto remove_trip_file;
 
-	mutex_lock(&cdev->lock);
-	list_for_each_entry(instance, &td->thermal_instances, trip_node)
-		if (instance->cdev == cdev) {
-			result = -EEXIST;
-			break;
-		}
-	if (!result) {
-		list_add_tail(&dev->trip_node, &td->thermal_instances);
-		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
-	}
-	mutex_unlock(&cdev->lock);
+	result = thermal_instance_add(dev, cdev, td);
+	if (result)
+		goto remove_weight_file;
 
-	if (!result) {
-		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
-		return 0;
-	}
+	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
+
+	return 0;
 
+remove_weight_file:
 	device_remove_file(&tz->device, &dev->weight_attr);
 remove_trip_file:
 	device_remove_file(&tz->device, &dev->attr);




