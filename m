Return-Path: <linux-pm+bounces-14265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 366AF979020
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18E0285813
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3851CEEAB;
	Sat, 14 Sep 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yIMI02N3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D121CEAB0;
	Sat, 14 Sep 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311273; cv=none; b=tDUR9ypMOd2NJKTgTzsefGRWomxkDsBHmLabbQePOFcqn/B/r1cCeWIFSC5Nqi3vDg/zKbfvyhTC8FLacsw6CQNAMpc/aZ6DgmhxOArBgopUEaW4NQJ0fy8NsPPJ2zhIBmkWjYR+Xda21hYV7VnX14r0QCysqiYOT81Sbgp7XYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311273; c=relaxed/simple;
	bh=+5/i/yZAcna1+JjBtrENZEzQS9hTFvlTTLY7k+oP7nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MujU6n/ZU6qtUrvqDRPr3A2swKXWsxjnivkLD2v2RdrM5M7cEil79YcMKfLB6uVYCsSIK8iJgt5YEiwBgUxdi0R6Cltpq7WXActY2IVd5YJxVnG/IgL3OHX7ArtrFQjdeQ7Osdwaqql7RLjpZU2xrbUp7eYjVDv4gEF7TbdUisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yIMI02N3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9e5b3eb4689cc188; Sat, 14 Sep 2024 12:54:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 86EF9853357;
	Sat, 14 Sep 2024 12:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311269;
	bh=+5/i/yZAcna1+JjBtrENZEzQS9hTFvlTTLY7k+oP7nk=;
	h=From:Subject:Date;
	b=yIMI02N3aF2YxVa8MbruYqSng6s1fFN9IaFnkkGQa42AZR50Wxe4N4flymlfhudXL
	 tPsOTm8/LZBX7qyn+uVRhL2sPBf6feMCrhEBK2AyAk6/RHhgmBGfc+Fk2DHe2AJfZl
	 Sxq8e0NopLUxYUmpo1U7p83Sm3pxtU9c1YyS9e0iaEOkD8oFD9PeOaiXAfK3tF6SxN
	 RYNJ2tYmuRyHmKIQpP+q2m8ZQoMy94WFMEx7Ie70lo5cPCt9ST2T5x3Wi/WW5wZd/Y
	 6LWY64wg7pmfZIfjWBccK4aGVDey+HhVqigOwOGdtH2mc3HCCZ7qIJPMr7Jh8TjB/A
	 u0R70cFpfNmOg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 16/20] thermal: core: Introduce
 thermal_cdev_update_nocheck()
Date: Sat, 14 Sep 2024 12:45:57 +0200
Message-ID: <3791590.MHq7AAxBmi@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Three thermal governors call __thermal_cdev_update() under the
cdev lock without doing any checks, so in order to reduce the
related code duplication, introduce a new helper function called
thermal_cdev_update_nocheck() for them and make them use it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c       |    4 +---
 drivers/thermal/gov_fair_share.c      |    4 +---
 drivers/thermal/gov_power_allocator.c |    5 ++---
 drivers/thermal/thermal_core.h        |    1 +
 drivers/thermal/thermal_helpers.c     |   13 +++++++++++++
 5 files changed, 18 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -30,9 +30,7 @@ static void bang_bang_set_instance_targe
 
 	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 
-	mutex_lock(&instance->cdev->lock);
-	__thermal_cdev_update(instance->cdev);
-	mutex_unlock(&instance->cdev->lock);
+	thermal_cdev_update_nocheck(instance->cdev);
 }
 
 /**
Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -89,9 +89,7 @@ static void fair_share_throttle(struct t
 		}
 		instance->target = div_u64(dividend, divisor);
 
-		mutex_lock(&cdev->lock);
-		__thermal_cdev_update(cdev);
-		mutex_unlock(&cdev->lock);
+		thermal_cdev_update_nocheck(cdev);
 	}
 }
 
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -317,9 +317,8 @@ power_actor_set_power(struct thermal_coo
 		return ret;
 
 	instance->target = clamp_val(state, instance->lower, instance->upper);
-	mutex_lock(&cdev->lock);
-	__thermal_cdev_update(cdev);
-	mutex_unlock(&cdev->lock);
+
+	thermal_cdev_update_nocheck(cdev);
 
 	return 0;
 }
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -212,6 +212,7 @@ static inline bool cdev_is_power_actor(s
 }
 
 void thermal_cdev_update(struct thermal_cooling_device *);
+void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -206,6 +206,19 @@ void thermal_cdev_update(struct thermal_
 }
 
 /**
+ * thermal_cdev_update_nocheck() - Unconditionally update cooling device state
+ * @cdev: Target cooling device.
+ */
+void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev)
+{
+	mutex_lock(&cdev->lock);
+
+	__thermal_cdev_update(cdev);
+
+	mutex_unlock(&cdev->lock);
+}
+
+/**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
  * @tz: thermal zone device with the slope attribute
  *




