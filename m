Return-Path: <linux-pm+bounces-22682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C6A3FC8A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCAD16D36B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBCA223708;
	Fri, 21 Feb 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Fz9LKnKo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9A215F43;
	Fri, 21 Feb 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157037; cv=none; b=SLCG+/1oABt3uMaG/jUlOeXnbAX1KtvLp1pbpEG2NKdqkPhVE5Ax/enEknoXWajm+Odc6MY4RJafBOd8XmF62aF/fNyAx469Bhnc8thBcwqsr5BXWUrwxBfSe+ZY/BKKvLJ5TRgJZGeE1kSPvQLXwxqL48oDAPCLz/gE9ZVpwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157037; c=relaxed/simple;
	bh=5RV0MfI+eFAbX3TFL3tJA1uo0SVXKiao6tzYw5ckz2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=thzWhz0+nh/LKTNTOznck2WCLL5tbWEo5hIyTBAhD/Tj7dmiybrCEOw4YS4vrKkbUTcpM/h8HoboAA5T3CkIIC5JyOdogx9MZu8jD/XT+m9S30bco1aKQcElnOz8908tZpMzmpd1hgPEYo+6Bs9ZSG6iebNCRWhUUHOIj7IYPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Fz9LKnKo; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 31ce6f5f9d79eda8; Fri, 21 Feb 2025 17:57:11 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 608977F624F;
	Fri, 21 Feb 2025 17:57:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740157031;
	bh=5RV0MfI+eFAbX3TFL3tJA1uo0SVXKiao6tzYw5ckz2o=;
	h=From:Subject:Date;
	b=Fz9LKnKogtW+RMgIsmLInJFXnkt6DFXL4TR9rzXHbB+Q5pi7Dez2pdJ6yceiYIUAt
	 Q+wfJqp+pSRVNTbjcoi6WpYOW/srhqdzoaVQjHYtkvwhp1dLw365pQkVhARfsYmrbJ
	 jAKcSY1e8bQzKgoWbqjtw4MHwZx9VZ1LJMne1Phqqp4mO/3C9VJW5L41G2fXgPFPWq
	 kIDF7aEi7Kzvp8bFT7Z8/A5/SdmesqFSld9oEqBBjnM9lraMCH+vQe1nuVQezUypMi
	 TXdvoZisyvtS4ryN7ObEoX12/g7+uWYTyImTu7vLsPiGyXfgOaHFe16IkJ9FjljJ8R
	 1OuVMU7y0hv6A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Yu-Che Cheng <giver@chromium.org>
Subject: [PATCH v1] thermal/of: Fix cdev lookup in thermal_of_should_bind()
Date: Fri, 21 Feb 2025 17:57:11 +0100
Message-ID: <2788228.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehgihhvvghrseg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_of_should_bind() terminates the loop after processing
the first child found in cooling-maps, it will never match more than
one cdev to a given trip point which is incorrect, as there may be
cooling-maps associating one trip point with multiple cooling devices.

Address this by letting the loop continue until either all
children have been processed or a matching one has been found.

To avoid adding conditionals or goto statements, put the loop in
question into a separate function and make that function return
right away after finding a matching cooling-maps entry.

Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone callback")
Link: https://lore.kernel.org/linux-pm/20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org/
Reported-by: Yu-Che Cheng <giver@chromium.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_of.c |   50 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -274,6 +274,34 @@
 	return true;
 }
 
+static bool thermal_of_cm_lookup(struct device_node *cm_np,
+				 const struct thermal_trip *trip,
+				 struct thermal_cooling_device *cdev,
+				 struct cooling_spec *c)
+{
+	for_each_child_of_node_scoped(cm_np, child) {
+		struct device_node *tr_np;
+		int count, i;
+
+		tr_np = of_parse_phandle(child, "trip", 0);
+		if (tr_np != trip->priv)
+			continue;
+
+		/* The trip has been found, look up the cdev. */
+		count = of_count_phandle_with_args(child, "cooling-device",
+						   "#cooling-cells");
+		if (count <= 0)
+			pr_err("Add a cooling_device property with at least one device\n");
+
+		for (i = 0; i < count; i++) {
+			if (thermal_of_get_cooling_spec(child, i, cdev, c))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static bool thermal_of_should_bind(struct thermal_zone_device *tz,
 				   const struct thermal_trip *trip,
 				   struct thermal_cooling_device *cdev,
@@ -293,27 +321,7 @@
 		goto out;
 
 	/* Look up the trip and the cdev in the cooling maps. */
-	for_each_child_of_node_scoped(cm_np, child) {
-		struct device_node *tr_np;
-		int count, i;
-
-		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
-			continue;
-
-		/* The trip has been found, look up the cdev. */
-		count = of_count_phandle_with_args(child, "cooling-device", "#cooling-cells");
-		if (count <= 0)
-			pr_err("Add a cooling_device property with at least one device\n");
-
-		for (i = 0; i < count; i++) {
-			result = thermal_of_get_cooling_spec(child, i, cdev, c);
-			if (result)
-				break;
-		}
-
-		break;
-	}
+	result = thermal_of_cm_lookup(cm_np, trip, cdev, c);
 
 	of_node_put(cm_np);
 out:




