Return-Path: <linux-pm+bounces-10717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A589F928DE6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D6F287B31
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3516DC22;
	Fri,  5 Jul 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CT5HS0pg"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F292F32;
	Fri,  5 Jul 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208797; cv=none; b=EihuE0c2GTbSf4JBowFFWHQhoDASfA5Nj/6IQEM5CySG4J+6eu/WUc83PqZep9SSzG5h93ZCjJqCNcZdteqxdUrC2CkTSat1EEZoPvK3F1GaXBQ65PBB8K8wIxmvGvEoyvRLBswo1fKvku8cqS3ptfTYagIOOKsS11uNmPRqw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208797; c=relaxed/simple;
	bh=olMcH7Vu2JbYhOr3EfFfi8edH85Gj5CbkImkJOKWW+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byiQG2+xFPpIeUTY+bUnEz6MGqM1RPE131TukX3HLuX4qU20OG7dR7oXJJMq+LCIbb/O4f7AVw/dT1pa+PPE/oT4INf44HCR09wzVPFfB4ijRA8h/U1FmyknKhqwkhfXpJzpjbJupj+R2u+o5zXnf5qmWvieuODDDbOAEzZC/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CT5HS0pg reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 4dc6d72d5972aa83; Fri, 5 Jul 2024 21:46:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 63AA27F5774;
	Fri,  5 Jul 2024 21:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720208793;
	bh=olMcH7Vu2JbYhOr3EfFfi8edH85Gj5CbkImkJOKWW+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CT5HS0pg7OiNMOOt3juGxUpEBA889eDECVs3pSg9/83YWQbLwjtuUuhJJ7rnuQ1S5
	 NAq5CU9tctgTaQEI/Z5wg3WwtH3PL3K7FGUyNQBmgk8Hr1YdPjkKjzym39yvRb6+MA
	 Y7gAaqfqhCrP8vj6Tvic3irwzeUe5NAGtlmL0OckfoBFy0MarNc/+zHg0OamzpXqCa
	 KFP9ryEUqL/vxGF2P2U6oQxUOhVPIQjLxyNT3TMScZWQpHS+tJywS+Urcp3n2+zOs2
	 bQAc0bOx0mlVq9SV9a25l/Nte1miMxiHfCp+JpWvkUJKMPs2tTvODliuKBW+xLHhU/
	 0Z7pzpNVUO5zw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v2 1/2] thermal: core: Change passive_delay and polling_delay data
 type
Date: Fri, 05 Jul 2024 21:44:50 +0200
Message-ID: <5803791.DvuYhMxLoT@rjwysocki.net>
In-Reply-To: <2746673.mvXUDI8C0e@rjwysocki.net>
References: <2746673.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is better to use unsigned int as the data type for the passive_delay
and polling_delay arguments of thermal_zone_device_register_with_trips()
because they are implicitly cast to unsigned int anyway in
thermal_set_delay_jiffies() and if they happen to be negative at that
point, the resulting behavior may not be as desired.

Update the thermal_zone_device_register_with_trips() definition
accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |    3 ++-
 include/linux/thermal.h        |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1359,7 +1359,8 @@ thermal_zone_device_register_with_trips(
 					int num_trips, void *devdata,
 					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay)
+					unsigned int passive_delay,
+					unsigned int polling_delay)
 {
 	const struct thermal_trip *trip = trips;
 	struct thermal_zone_device *tz;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -221,7 +221,8 @@ struct thermal_zone_device *thermal_zone
 					int num_trips, void *devdata,
 					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay);
+					unsigned int passive_delay,
+					unsigned int polling_delay);
 
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,




