Return-Path: <linux-pm+bounces-12161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618799507D9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA8285103
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8419EEA0;
	Tue, 13 Aug 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="AuRHprR9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1619E7CF;
	Tue, 13 Aug 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559808; cv=none; b=NRgzOLS/L8HwZL1Z/lnq1rSCf5tBSgmDHs8Bwx9Z8AcvvJFFOJqmEGN9nSXyzKEz5zsRiAdwI4qGoiSeXxoeEdewHzO4Ee+UeplIQgEHbRq9QFgMhPu/gMpgF9BNyte7wZWPJFg1Msfa8o4TdptmZjGnfKbL+AUEbmpjHj8kYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559808; c=relaxed/simple;
	bh=xvkO/RTBKgQM5PQe33l5QAyOs/W2Yq6mxhuiaRF//TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5qPEG1EneV0zt+R8aN3vXuZ+YsiSgsxGgrUqRKWaUZbsyRyx3dYThhGA6WDW2V+Kbt6lsIDDy3tXhPamITidzk8moWJeqhV4oSjGNQWLzI2zRBOakDav4B1WahqOkbt8opzEuoLpa08rxstycfB8QTOwGTL4z5hB0RmwI+yN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=AuRHprR9 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 86b400dca339de90; Tue, 13 Aug 2024 16:36:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6461C6A89E1;
	Tue, 13 Aug 2024 16:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723559804;
	bh=xvkO/RTBKgQM5PQe33l5QAyOs/W2Yq6mxhuiaRF//TE=;
	h=From:Subject:Date;
	b=AuRHprR9VUBYzXzmcpiCwfMfV88NwIhxnWhdMTonPCmk1IJItZ0dVqGn3pLxAX9r2
	 +qN0MyuxbEU2NoMZJE260DhJcbdLEtLvaa7gbIrSjSMSzU3Ewh7gMLNJlwZ9fiY7KY
	 9rhe0O/0RxCl/Xu+/33gw2AMolBYcUc0dqt+3iZqvTImGRGomPGvcVOmX7aMH1aO/o
	 xGC2JHDElTEtbVQWp4TbwCdYYX0rGeSmkxYbUesfGP1b/0j8YyDJeCR5SnGZQw8Sgd
	 9JG2gYLvJvSyUXBaDA4B6Pev411v/HcRzlOmXL2MaYUVy775h8gpBjB2Q/l2Y8NIrl
	 cE1z9oJtbDnRw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject:
 [PATCH v1 1/4] thermal: gov_bang_bang: Call __thermal_cdev_update() directly
Date: Tue, 13 Aug 2024 16:25:19 +0200
Message-ID: <13583081.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <1903691.tdWV9SEqCh@rjwysocki.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohep
 uggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhesphhiihgvrdhnvght
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of clearing the "updated" flag for each cooling device
affected by the trip point crossing in bang_bang_control() and
walking all thermal instances to run thermal_cdev_update() for all
of the affected cooling devices, call __thermal_cdev_update()
directly for each of them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -71,12 +71,9 @@ static void bang_bang_control(struct the
 		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 
 		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false; /* cdev needs update */
+		__thermal_cdev_update(instance->cdev);
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_update(instance->cdev);
 }
 
 static struct thermal_governor thermal_gov_bang_bang = {




