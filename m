Return-Path: <linux-pm+bounces-15072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACD98DFFB
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255EE1F24C3C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BA1D0420;
	Wed,  2 Oct 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XTPDc8em"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DB1CF7DD;
	Wed,  2 Oct 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884773; cv=none; b=gRQOzH21HKQRsz5nWL/5BvY2JMp1x9CzUCTgIVSu+9Cvwiy4DS5WkTwKMoTE8gT76D1nnxsqwh2M+Ws/6EdtEpMWWCvsEBtCcQXgqMUjVsojg/Ho10At+BCe5Hly7nBDOGkvysjARGt0BMomODy0jnwnwkShV+vTGS436SqvrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884773; c=relaxed/simple;
	bh=Qyr9Qc7PrteUqMlqEN0V8uLmY0svFazM8cKuv7+1Eno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siVQI3f9rP+4/z0tl8GoiwiiNVD7ShPPlX0Ud/yuLfeovgJpeaCsWz4lynmGvxJy4rDWDwSwKQgYg1PBTyzwLfE+lzCOeYVugVSfGlJAHiOwcEJy4XaHcb3piFepkI+PEHhwNS5lIpfHwWfIjIQpAWkOgPkpAYgDX65lc1vujEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XTPDc8em reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5acf0b6a509f1dff; Wed, 2 Oct 2024 16:59:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D57237F587A;
	Wed,  2 Oct 2024 16:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1727881167;
	bh=Qyr9Qc7PrteUqMlqEN0V8uLmY0svFazM8cKuv7+1Eno=;
	h=From:Subject:Date;
	b=XTPDc8emQdXm1iDb4ZoAZP2lZTCzuXNP532taRtkl0RlHyvajaASoyNq857fHt9SC
	 g4uV0S68+lE9KaAMU8725yGRNZptw8wmhFurLQXTAnuQyC2/d1eLmpI8mUmgkRpkoV
	 ex1MDvJbg2ndJUSM2J73jbUsyFS/RwVECPajxcvB2OXfgHtolZIj0T3XVrzcudEjR4
	 Y5W7FtuLvLInL3zPEUHp3sYzhB2XVBM+Wi2VklPQK63b1qx3XMxKycDuJq8n/Ygokk
	 2nXVVq9j8KVxJ/VYhV12kT3QSTBYkb1aRX3vqgMcWhS2hZEaAl04/BJA8vgYdXJzx3
	 8SLYXznN/r3nw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 2/2] thermal: core: Free tzp copy along with the thermal zone
Date: Wed, 02 Oct 2024 16:59:15 +0200
Message-ID: <4615669.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <12541117.O9o76ZdvQC@rjwysocki.net>
References: <12541117.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The object pointed to by tz->tzp may still be accessed after being
freed in thermal_zone_device_unregister(), so move the freeing of it
to the point after the removal completion has been completed at which
it cannot be accessed any more.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1606,14 +1606,12 @@ void thermal_zone_device_unregister(stru
 	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
-
-	kfree(tz->tzp);
-
 	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+	kfree(tz->tzp);
 	kfree(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);




